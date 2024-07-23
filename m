Return-Path: <bpf+bounces-35301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAC293977C
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF8DDB2192D
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 00:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878BF5A11D;
	Tue, 23 Jul 2024 00:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4bSzjpd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D114D11B
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 00:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721694860; cv=none; b=S2dBIr9dtuwg36bBOf3+RJpnziVqPI3bzpAK3K5P7MhXt9BVLX7qQGAz7VY+QYEDyEoWWmfeyM4kKU5UyQXnVy3vaexUj/cx54B2y+MPPhR9n38o57CQw039fsRlycL1PV4T3N+AGw29XQH0u0FdfsaSIip7tvv37SC4XTydh20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721694860; c=relaxed/simple;
	bh=x383W3eZhPG3z9AoIjQqe32gpmgUXCVj6GFg9YiRKsU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=R6/+8wL4nwFAzI+YMiRu23T/GlfgPibRygztBCEC1G36rophVnrT0zRETE1f/zcmIOrXLC+qxAe1cO9RcY4U8Sw5qvh0HPB9rKHJHGTgv/EiPB49ILIjzT8cSRpXNUATALjfGLuk13O8yqBWJinbhR+WzYKANbBZyacJbVVYeH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4bSzjpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56D3C4AF0A;
	Tue, 23 Jul 2024 00:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721694860;
	bh=x383W3eZhPG3z9AoIjQqe32gpmgUXCVj6GFg9YiRKsU=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=k4bSzjpdSLMKuQXFgN9j68b9g23sSXG1tD/X6l5wb7elLjFT4vp2HqxmfICtTCZcm
	 fpV9T2qxr8pqQKbeIHp+TlAgW/pyXf99vkGMKNkYJVOPD2wDdVT9+/xKp/2iy1nJ6i
	 n3x2G0lhHmylN/2zmuedbBs8xvTOyDCxCYoGBPlwEboGoxPEUEO1Ir0mPE/vvXIkb6
	 a1HuQSMdmj5vMUMUnVIFV+C+UnPzrNx5mrQwurT/3M+cu8ZkiOlKBCcgtcSvKZCmQL
	 1uh1NZJ8rLc7erMF7WmxL1F3yn4LjF3gWxDe4s0fwMNTWGVKgMQOfAm2/VoZyv32W7
	 xskTWTbXpl19w==
Content-Type: multipart/mixed; boundary="===============3989504289622498146=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6d5ceac9ee7a43b292affc1510af8a6c075bc275ae0d5712b61c5270ab14c360@mail.kernel.org>
In-Reply-To: <14eb7b70f8ccef9834874d75eb373cb9292129da.1721692479.git.tony.ambardar@gmail.com>
References: <14eb7b70f8ccef9834874d75eb373cb9292129da.1721692479.git.tony.ambardar@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Fix error linking uprobe_multi on mips
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 00:34:19 +0000 (UTC)

--===============3989504289622498146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next,v2,2/2] selftests/bpf: Fix error linking uprobe_multi on mips
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=873092&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10050383298

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============3989504289622498146==--

