Return-Path: <bpf+bounces-35147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35020937F13
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 07:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA21D1F2188F
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 05:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E71DF78;
	Sat, 20 Jul 2024 05:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1dPBgld"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3099C132
	for <bpf@vger.kernel.org>; Sat, 20 Jul 2024 05:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721454571; cv=none; b=ACIeDykyA4tlQGYeB2Tj09xNbc6gXjr9Fnzag2+Z9yyBBlJykHvcym2fyD6jzW80S2N6vHoc0Ih5JrRioCbQwpBGrFXaV92a/eHGZDhf+FhSqRLRtCDPQ7jFyQWMmHOUKVB7nS2wqjJdXK7ZoD4PbzZ5JKeX53EaM3TrY0ZRk7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721454571; c=relaxed/simple;
	bh=W1VxUVt8qewpb+RJR7bwVkxunkSp5/mZTjCp+RKtm/M=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=BRpxtZwzByBjpNeEm8wF255AGgB4H0bUl8atUvuhUvnv5xvYGFl75y5QQCeH+BldDxtYqLtJR/KonV1k28l8plkayzLEbD6BTeJDFka2vpsHTpDSws/fsyvYSLC8In4dvibb0Sc5Pd3P3YfKn3+cJiaxkwNAC5fa3jvGpm6Xuv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1dPBgld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D778BC2BD10;
	Sat, 20 Jul 2024 05:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721454570;
	bh=W1VxUVt8qewpb+RJR7bwVkxunkSp5/mZTjCp+RKtm/M=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=T1dPBgldo97vHdvH6MwWbZFFrQPZ9uIxSjqWUMPRFq0Zes40aDG8eAN49nsp76QDG
	 S9Bc2q9ETaw01/chqVDPQ1FpqnUHLpQ26cJ90Lh4d8fvRdzxMYkgCIzClh7d4/r5iF
	 f0IUgdd5uGsNlSTsfsHqokAAQ7dK+ydpGs3pfsXXebK0dI7+u6HZjqHxF3j6l14omQ
	 f1M1b1bC4kZXQGV6tfRIvaIGiffkxgzKyO4u6+2cn/G0E6U1DPfhodSN16mcwRTeUs
	 J/9FBJddmRCmVHgs2LOZl3mIjlzhLbElKTwqDJp8XPmSYoNMiQAdPcaFfhc1g4KS4N
	 9yYkLToS4iw8Q==
Content-Type: multipart/mixed; boundary="===============9111687914976755202=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <85364e4019dfdd8151ec941841ffd92f8bf9384282aa4728acbe39b1ad8ba248@mail.kernel.org>
In-Reply-To: <20240720052535.2185967-1-tony.ambardar@gmail.com>
References: <20240720052535.2185967-1-tony.ambardar@gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix wrong binary in Makefile log output
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Sat, 20 Jul 2024 05:49:30 +0000 (UTC)

--===============9111687914976755202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next,v2] selftests/bpf: Fix wrong binary in Makefile log output
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872645&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10017878438

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============9111687914976755202==--

