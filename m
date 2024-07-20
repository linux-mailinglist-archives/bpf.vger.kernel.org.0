Return-Path: <bpf+bounces-35133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57680937E71
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 02:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2BB31F2171E
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 00:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8BDA23;
	Sat, 20 Jul 2024 00:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjF877xn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C267F9
	for <bpf@vger.kernel.org>; Sat, 20 Jul 2024 00:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721434485; cv=none; b=HSeHztpGsfboVsXFi3tsBEUnDGFhuZPhfnxWAD9vqtdyYb4t1HOFSA6Y0t0r22nQ/2HjKByWvtQ9FKpueY34qIUCvxITaNwMDNS9HD0DRRR5yVStuVtq7AZv+dpaOgcicXMdGEEgLmNyddpCt6W4W4bLZyGhJPXAG90TzTxjW+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721434485; c=relaxed/simple;
	bh=U1/GrLpjkWdzN6EBNYR1lqjUgkGf3hwZJJJmod2sv44=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=leI8Mg2LMBb/XOWCQuoGFdmwOM7iil0Gy56n5RZW1JUUtLPbgvVRKnmLzdAx13G9Br4DO78A11HeXLKRojC4ASz1obiIebEuuoB4k6PshepG0QMvFDr8h8gPJXzneahpQdnzyEN3RN95LB6PGq5xtcVocsS3WroO+4gz8dX7jFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjF877xn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF975C32782;
	Sat, 20 Jul 2024 00:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721434484;
	bh=U1/GrLpjkWdzN6EBNYR1lqjUgkGf3hwZJJJmod2sv44=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=VjF877xnspXUfhIUGyeSVGjfn8z2JhjG9QChVguK9cBfuLbiUeB+I0bdBvuGkiYAw
	 kSI1N+6SexSEzLCyGv0kMKYbmChNVpcpN2QRAR5ElLmz1C784PjKxm41mR/J4RCFqb
	 GUpRaj10E/cCMMHWXgGU/8zAsHUwh8oKQDmVi0yN+R+i6p+Lc6PmdbM/Rqj2wuFhA1
	 dDmCyNk8YjbKQgPndNL5a93Q1dA9WVrzKMttsvJzTFiD/1K5ULVHZ91UTEbfnxYc0+
	 4luRSj+hcR5gRbZKEmaXH4D0V21PliSO8Z7Cmbb7oi3IWIvOd3vD/0L5b2shgz2H+3
	 tRSnW+VtWVPuA==
Content-Type: multipart/mixed; boundary="===============3066431540592357659=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <28dc2325015943080d8b83f2ba941d17ddc3b80fa019b124adc475091cae75db@mail.kernel.org>
In-Reply-To: <20240719232159.2147210-1-tony.ambardar@gmail.com>
References: <20240719232159.2147210-1-tony.ambardar@gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Fix wrong binary in Makefile log output
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Sat, 20 Jul 2024 00:14:44 +0000 (UTC)

--===============3066431540592357659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next,v1] selftests/bpf: Fix wrong binary in Makefile log output
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872629&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10015585896

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============3066431540592357659==--

