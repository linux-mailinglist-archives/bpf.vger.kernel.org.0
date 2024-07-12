Return-Path: <bpf+bounces-34641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF56992F8BC
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 12:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938B01F23643
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 10:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E162E14F104;
	Fri, 12 Jul 2024 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLqFpLWb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA0013F439
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779263; cv=none; b=AAbt2oCJXrxGTOjs/05YhN5gReAHWNJ0qMhEIIwEknpFV7A4eYi9iwWVTh3QDhahf+FAtfE2r2KY2A/P4BNJ/X0+g8Sr/YbxwSEUEKUgQvq2U5EK44tHQ1Aormm7Uo1AMbj4C1bf3PbgtJldli2t7SbYUCieP5hUByCrcWp5+zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779263; c=relaxed/simple;
	bh=stA5m4VzbUdBWR7B4uSh8hIvbQS5Fx3sF6RzkpRFumM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ucWQn3WZMaIK0i5ygSlwwCXFTfmC7EHxCiQdYcFDWcA1icJo6J9Qxgk4uC4l0uIUcUNK/LNQJwycFhJ+KNJitlcmMDyPQWCUJPI5RCC9Od2viO1W5OLrA2aw8ydSrWML85pP9uzYA0KIueWHVJl+iJ+5g/H4fuIYrGBfXlt821g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLqFpLWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CE5C32782;
	Fri, 12 Jul 2024 10:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720779263;
	bh=stA5m4VzbUdBWR7B4uSh8hIvbQS5Fx3sF6RzkpRFumM=;
	h=From:To:Cc:Subject:Date:From;
	b=SLqFpLWbzfX4sOutbsIhTVgJ2Z4hgIJu3hG04zkibZwReN44mcEv8nQGzJx5YqQlG
	 BDRKzwQbA6Xzl2MrNJOUuCOlPrrRQkxZ2GPJhteGPtIeEdAs/QBK9l5zb+HGsqMZX2
	 /X6ah/kxjRgvlLzyZs7XWiFoVmYw254c43AC65EedX1Sd4ZcMHqw6vGcbl2KUpvOLl
	 IqSo4SNqP3MCJfV10o8bI2axs04XW8cdYnSAL+nHmQ3UipDber6NDSwaYBmepLpeXI
	 IpZyOagGyLeRKvaekPBdBQXwMClyEaigHlUs9or9vFb9ICDm6KloshJ/Q8bVlYce/+
	 Pu5aKivN+vBvg==
From: Geliang Tang <geliang@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 0/2] handle errno ENOTSUPP
Date: Fri, 12 Jul 2024 18:14:11 +0800
Message-ID: <cover.1720778831.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patchset contains two fixes for handling errno ENOTSUPP. Patch 1
fixes the return value of fixup_call_args() to make sure ENOTSUPP
is returned to user space correctly. Patch 2 handles ENOTSUPP in
libbpf_strerror_r() in libbpf.

Geliang Tang (2):
  bpf: verifier: Fix return value of fixup_call_args
  libbpf: handle ENOTSUPP in libbpf_strerror_r

 kernel/bpf/verifier.c     |  6 +++---
 tools/lib/bpf/str_error.c | 11 +++++++----
 tools/lib/bpf/str_error.h |  4 ++++
 3 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.43.0


