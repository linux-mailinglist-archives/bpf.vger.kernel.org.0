Return-Path: <bpf+bounces-44369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF9F9C249E
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 19:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36FFE1F23986
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 18:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99178233D64;
	Fri,  8 Nov 2024 18:05:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C67233D6E
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731089126; cv=none; b=sT+aIxIGX5JC+O/vn3AkOxx/fXqKR7stUR/gJFnG6r8nXKw41Vist+nLsRuYnVskcBxNKYLnso2U2olWpIs28RqMlOe04al8aUA6yl5L4XoR1pje1mSaHHbrZE0GQ8rn/G5LJ0Fkwp/pbRd3wR+qwb8gl0HotIkbO2IUXXwuu7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731089126; c=relaxed/simple;
	bh=GicJG50qtpuNN3jpBymXir8kT/gCN/GScH9Uz4NG7KA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZwTOyTzrezNiKc0Yy57leby/CW6dmkJ2Xvn7fSraom86/6jnOaJyH2Yd9Bm5f26aZeFI2BxMBO7eYdx8jOd0ZeaY37pxApOX3DArfLcmOqPWmIzzzv7g1y+vhsEkahx3U08zXffhsVZ7+pos4wPvH93UjM7hJyADUz5+9sGtXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id CDAD4ADDC4EC; Fri,  8 Nov 2024 10:05:08 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com
Subject: [PATCH dwarves 0/3] Check DW_OP_[GNU_]entry_value for possible parameter matching
Date: Fri,  8 Nov 2024 10:05:08 -0800
Message-ID: <20241108180508.1196431-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, pahole relies on dwarf to find whether a particular func
has its parameter mismatched with standard or optimized away.
In both these cases, the func will not be put in BTF and this
will prevent fentry/fexit tracing for these functions.

The current parameter checking focuses on the first location/expression
to match intended parameter register. But in some cases, the first
location/expression does not have expected matching information,
but further location like DW_OP_[GNU_]entry_value can provide
information which matches the expected parameter register.
Patch #3 provides details how this will work.
Patches #1 and #2 have some preparation work done for patch #3.

Yonghong Song (3):
  dwarf_loader: Refactor function parameter__new()
  dwarf_loader: Refactor function check_dwarf_locations()
  dwarf_loader: Check DW_OP_[GNU_]entry_value for possible parameter
    matching

 dwarf_loader.c | 134 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 102 insertions(+), 32 deletions(-)

--=20
2.43.5


