Return-Path: <bpf+bounces-40347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0373398731B
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 13:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73D7287656
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 11:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94603154BF8;
	Thu, 26 Sep 2024 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qr/yAL8y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2B61798F;
	Thu, 26 Sep 2024 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351627; cv=none; b=hwG8OVpTvWkyq43VlUE3XkBheackhVOmy7gxELqIP92JQ0t7GSQCWddFz88wZbdlHW8T2Seh+LR79IDOkWUq+GIyz7wjnK9nMEljpRS1OKD9ELKcH1F1fNqnN9TobW2016yvwdggKUH8jBClNlw6kYT0oTJGTo7g5eh+FAqER8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351627; c=relaxed/simple;
	bh=IBP0mMp2Q2sfIRnpWh/868kKysPgTuEIZ/NauQxSenU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=RRrFB6ytQm7ilXiR4sAQBn1yUcmGM8EqyHtgbO1IC3RJVTuM7SzKH1UtQ6vjvPBkPbNP0+sUMNt23T8rETBphRTqomremxPNZO9iGF3uqgEyLEWVHtVqvCcHeGTqN/TETtVhcXZI8aChtVJy/VzhDONaeO9NtTbZ/589O7GhUHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qr/yAL8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709A6C4CEC5;
	Thu, 26 Sep 2024 11:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727351626;
	bh=IBP0mMp2Q2sfIRnpWh/868kKysPgTuEIZ/NauQxSenU=;
	h=From:To:Subject:Date:From;
	b=Qr/yAL8y9WrKF1/9UbbeIPQrebmqDbGH6mHURcXsK1oeXZlW/MOvybNzrIcR4aViE
	 8ULpBNFvz+e8h3W2wW+WIbHWylb2VXav8gSJPpGrG2AWxghFlg0KthlgUXsAxvSIec
	 R8/mKemwb8kFmwHrggCaAij+OV1rE83DDPBdX8JUbqNxNYBF7J2tNvDi/k02YiCJUy
	 80VzLwbUsm1fnp7jRS741tquLPjksEwKy+QbRUji8+XYDS9fmvtuvxYQNAevJoPbcS
	 ToLf246YEjIuOFEMm1aMLs5bvvnH/oGNePJwElGxstSI2X99UHVhY4tQ+gH7jgu8wS
	 bpqPiTrPAVdHA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	puranjay12@gmail.com
Subject: [PATCH bpf-next v2 0/2] Implement mechanism to signal other threads
Date: Thu, 26 Sep 2024 11:53:26 +0000
Message-Id: <20240926115328.105634-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set implements a kfunc called bpf_send_signal_remote() that is similar
to sigqueue() as it can send a signal along with a cookie to a thread or
thread group.

The send_signal selftest has been updated to also test this new kfunc under
all contexts.

Changes in v2:
v1: https://lore.kernel.org/bpf/20240724113944.75977-1-puranjay@kernel.org/
- Convert to a kfunc
- Add mechanism to send a cookie with the signal.

Puranjay Mohan (2):
  bpf: implement bpf_send_signal_remote() kfunc
  selftests/bpf: Augment send_signal test with remote signaling

 kernel/trace/bpf_trace.c                      |  78 +++++++++-
 .../selftests/bpf/prog_tests/send_signal.c    | 133 +++++++++++++-----
 .../bpf/progs/test_send_signal_kern.c         |  35 ++++-
 3 files changed, 207 insertions(+), 39 deletions(-)

-- 
2.40.1


