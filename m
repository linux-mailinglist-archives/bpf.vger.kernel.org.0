Return-Path: <bpf+bounces-21131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4D084845F
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 08:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E131C227A2
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 07:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A057F4EB2E;
	Sat,  3 Feb 2024 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKMacYWK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1689218637;
	Sat,  3 Feb 2024 07:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706946740; cv=none; b=iMxFeg5IFYI3qwpDuGiDi73orib/8ocOJUev9aTCYLzcipMz4WoaPrq8iL0181HOxSORE8WttjDNIGg5rC5ArklVG7CV+uEkE3/Cu2VEVsaRP9Yhl65cZ8yGCOThBVSOF1XJVyUKFZC0AdB/o01omOcVHJraWFckKVM+VcLFXHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706946740; c=relaxed/simple;
	bh=7GJK0S1MeJWkM8NTCJiSOwW2qUQ6eEcoMOd4Op1xVTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UxchiVZ4eFxnPX5T94gZb/NL2bzB4zpv1A2ohhDxA2GQztTaUfwQq3DETTGO261qwPXppITUfOHuc+t8YhGId97IYZEPCTlH/Wzgaq5RhFtm8BCi48vmBarLpsUlz7l/NyhssmD8RP1i/ZWZKKO9qTjg0CRIJVp8fJ7H2zXNZmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKMacYWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10F1C433C7;
	Sat,  3 Feb 2024 07:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706946739;
	bh=7GJK0S1MeJWkM8NTCJiSOwW2qUQ6eEcoMOd4Op1xVTQ=;
	h=From:To:Cc:Subject:Date:From;
	b=jKMacYWKOAhtNxRQ+bbulQJgxaEolgHJ6JOCqicDxX5MztuUtMfzaz7NeJOALSRe0
	 Xkjm0qVD/40LHYDEcOt24E7X+zbcp9u4JUGMqWg/bHG9hefGp5nIlPoDCGqSwCvSV0
	 dA4s6teqNkRewtppIhygSICFa1tb2z8A1j0Lz6Z6PdUxuhAW2MA/W2VWXgPwZ50Y0C
	 4XbZFSGHpH0Q/QhzRmuz0T8qcBSctblNtysaJmXsepkHP35jPn6usacLFKTNtj11+g
	 8c9YWJojJV8G1zEXzGbARYerP+OPpdVDm1jQwSVsrffUcz6XMHRC/L5ow/Ie3Ncl9v
	 75i150f7SJKMA==
From: Geliang Tang <geliang@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH bpf-next v2 0/2] bpf, btf: Add DEBUG_INFO_BTF checks for __register_bpf_struct_ops
Date: Sat,  3 Feb 2024 15:51:03 +0800
Message-Id: <cover.1706946547.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - add register_check_missing_btf helper as Jiri suggested.

Geliang Tang (2):
  bpf, btf: Add register_check_missing_btf helper
  bpf, btf: Check btf for register_bpf_struct_ops

 kernel/bpf/btf.c | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

-- 
2.40.1


