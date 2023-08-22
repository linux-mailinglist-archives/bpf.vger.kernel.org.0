Return-Path: <bpf+bounces-8264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD3B78463D
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 17:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8373280D88
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 15:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365061DA55;
	Tue, 22 Aug 2023 15:51:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982361D303;
	Tue, 22 Aug 2023 15:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427D6C433C8;
	Tue, 22 Aug 2023 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692719472;
	bh=HytErZ3SwNQutXsq7fKy9d1+X8hsvPNkS1TDLwjTPfw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=YtQo28CMzQF5g9hOIUKPCp1yN9pIIwqYOv7IULsSYEBoND0HQdZur4sTv1S7KPrGe
	 smiiT23SEckNPhx01XcKFhv3hNspXg4UgIKZne3Boa8ILSb3YR6gdaOwlbuhJDLE4L
	 evUNStoR1EaJJKH6xlWLEGpSeLwX0MplGlkyDEepeU0zFzXmTdxvjM3EDmgzA5FUCB
	 7n06yyKxO9ihY429gQO8xe/k/qnv0WE3tBokuzE56LhTGKQSuij0JoglWIti2wYqKH
	 F8FUw/H7S2LDqJA8gbONeXJSnI4nX9zpYqe3xPVmuGLe4S4Gcr6yt8/XhuHf0fTgcj
	 kYUYQ7MfpmIzQ==
Message-ID: <721e5240-ab19-507a-c80e-ce5d133c0a9f@kernel.org>
Date: Tue, 22 Aug 2023 17:51:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Samuel Dobron <sdobron@redhat.com>, Ondrej Lichtner <olichtne@redhat.com>,
 Rick Alongi <ralongi@redhat.com>
Subject: Re: [PATCH bpf-next 4/6] samples/bpf: Remove the xdp1 and xdp2
 utilities
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
References: <20230822142255.1340991-1-toke@redhat.com>
 <20230822142255.1340991-5-toke@redhat.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230822142255.1340991-5-toke@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 22/08/2023 16.22, Toke Høiland-Jørgensen wrote:
> The functionality of these utilities have been incorporated into the
> xdp-bench utility in xdp-tools. Remove the unmaintained versions in
> samples.
> 

I think it will be worth our time if we give some examples of how the
removed utility translates to some given xdp-bench commands.  There is
not a 1-1 mapping.

XDP driver changes need to be verified on physical NIC hardware, so
these utilities are still being run by QA.  I know Red Hat, Intel and
Linaro QA people are using these utilities.  It will save us time if we
can reference a commit message instead of repeatable describing this.
E.g. for Intel is it often contingent workers that adds a tested-by
(that all need to update their knowledge).

Red Hat is in the process of moving our QA to use xdp-bench / xdp-tools.

Want to mention LNST team are also adding xdp-bench (+pktgen) support:
  - https://github.com/LNST-project/lnst/pull/310

--Jesper

> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
>   samples/bpf/Makefile    |   7 --
>   samples/bpf/xdp1_kern.c | 100 ------------------------
>   samples/bpf/xdp1_user.c | 166 ----------------------------------------
>   samples/bpf/xdp2_kern.c | 125 ------------------------------
>   4 files changed, 398 deletions(-)
>   delete mode 100644 samples/bpf/xdp1_kern.c
>   delete mode 100644 samples/bpf/xdp1_user.c
>   delete mode 100644 samples/bpf/xdp2_kern.c

