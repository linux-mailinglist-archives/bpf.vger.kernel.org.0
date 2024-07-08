Return-Path: <bpf+bounces-34137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13DB92AAB8
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 22:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0B11C20C8C
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 20:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DAB3BBC1;
	Mon,  8 Jul 2024 20:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I68oRze4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B836418641
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720471544; cv=none; b=NfM5/ACAVqBiprREoBaRJPyPwFEWlg+dAoSolsVROlXh33k9yGFOqJ9BqUwqMoLUKg0rLVbFbCCjcz4dygvBA0ZEiB2+oh6ZqnefO137Zoo2/cLaEnPXPuJ9sFvuJNC6yqmeX9hI+8v1WXmIefeFU05mtk5VM0dR5GzbiyjAd30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720471544; c=relaxed/simple;
	bh=b6qYpDhnfjOmOdouzrAMlNJhJQXt9/calUVj7eOQ8ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWwTzc+Rc71eRygo+g2+pMbRFeq9qBeD8ycRiRcQtz9yRlrCpPwfjVZB95ijsdi+Wp9mL2zPjbqSIXR2neTLCf0zMEF0xnZy+mdJXVXqEVoQAlxXXhU37V20bEB2Sp4L+sSrFOFF+Er1XBqaOfWnsD9GFPp0dk5nUVdDCP4kG50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I68oRze4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30155C116B1;
	Mon,  8 Jul 2024 20:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720471544;
	bh=b6qYpDhnfjOmOdouzrAMlNJhJQXt9/calUVj7eOQ8ck=;
	h=From:To:Cc:Subject:Date:From;
	b=I68oRze4wpCJ1NiNBl+rLNtMH647HWVPQcn5Isx5CAOXivRmghu68kgqLP6i8a7kx
	 6JOi8J/Q6InXctBx4ji9wxUou4SfmGnFNLIP8n0lixJgk47BiQpDYNRKdZ0FHZ+3l7
	 H6e+2zNWd8jB5UWVFArZGcbUpf9GJm4dvj341TqgTz5k2hOV6Z3VoPzuJfBNzPtsFH
	 z7CK0a5SWr6LUnCpuxiaTfpWcpioQ27RIdJqcctXwCrmKhKX/Cmq3FAmj0zVq/olKM
	 8Ft7oskxQ1B9p7CZrX2MTUMP2UwgDRg8bC8LWCrBi/Azd5psrAZWCa892LCbpewbxU
	 4gZwmyGPLl9UA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 0/3] Fix libbpf BPF skeleton forward/backward compat
Date: Mon,  8 Jul 2024 13:45:37 -0700
Message-ID: <20240708204540.4188946-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix recently identified (but long standing) bug with handling BPF skeleton
forward and backward compatibility. On libbpf side, even though BPF skeleton
was always designed to be forward and backwards compatible through recording
actual size of constrituents of BPF skeleton itself (map/prog/var skeleton
definitions), libbpf implementation did implicitly hard-code those sizes by
virtue of using a trivial array access syntax.

This issue will only affect libbpf used as a shared library. Statically
compiled libbpfs will always be in sync with BPF skeleton, bypassing this
problem altogether.

This patch set fixes libbpf, but also mitigates the problem for old libbpf
versions by teaching bpftool to generate more conservative BPF skeleton,
if possible (i.e., if there are no struct_ops maps defined).

v1->v2:
  - fix SOB, add acks, typo fixes (Quentin, Eduard);
  - improve reporting of skipped map auto-attachment (Alan, Eduard).

Andrii Nakryiko (3):
  bpftool: improve skeleton backwards compat with old buggy libbpfs
  libbpf: fix BPF skeleton forward/backward compat handling
  libbpf: improve old BPF skeleton handling for map auto-attach

 tools/bpf/bpftool/gen.c | 46 ++++++++++++++++++--------
 tools/lib/bpf/libbpf.c  | 71 +++++++++++++++++++++++------------------
 2 files changed, 72 insertions(+), 45 deletions(-)

-- 
2.43.0


