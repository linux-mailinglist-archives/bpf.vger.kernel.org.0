Return-Path: <bpf+bounces-10203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4182D7A30F7
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 16:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5AB282430
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 14:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7DC14017;
	Sat, 16 Sep 2023 14:47:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D704812B9A;
	Sat, 16 Sep 2023 14:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4018C433C7;
	Sat, 16 Sep 2023 14:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694875668;
	bh=DrpFaRSh/IAeouBerVCYqiVaRBz09LVTL2zZXjVhk0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcGZXd7tGQX9f5peC25KLnAHHnsRMglQ2tX2ZQlXPodNBeeEDSPRM7LaDVUwchSK/
	 aGU6cA7qLoXcoqcfKRaoydd98XmsKv7GZOS/LlXhPk7q480dXWJG3xedTzLac2/Vtj
	 +RrsniiJQHOplMRj9R0agcXR6IgVBKnUqwLSyneJ0os+zB6TD2vm3GfzubIBSIshVh
	 XDS2Y9MJAjZ+wQsdDdr7q1B1bQJj6MUlDEX2FyR00OcO4loRd5/40PVIQUW77Bx6i1
	 qrvl27ZSLI5oiokE6B7zjD88dfkhIKS+0R5xygnHUnSTMAAhV6FkC4MyaFQi0AnTtO
	 rJ2GwPydVg5uA==
Date: Sat, 16 Sep 2023 16:47:42 +0200
From: Simon Horman <horms@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Luke Nelson <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 3/6] riscv, bpf: Simplify sext and zext logics
 in branch instructions
Message-ID: <20230916144742.GB1125562@kernel.org>
References: <20230913153413.1446068-1-pulehui@huaweicloud.com>
 <20230913153413.1446068-4-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913153413.1446068-4-pulehui@huaweicloud.com>

On Wed, Sep 13, 2023 at 11:34:10PM +0800, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> There are many extension helpers in the current branch instructions, and
> the implementation is a bit complicated. We simplify this logic through
> two simple extension helpers with alternate register.
> 
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 82 +++++++++++++--------------------
>  1 file changed, 31 insertions(+), 51 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 4a649e195..1728ce16d 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -141,6 +141,19 @@ static bool in_auipc_jalr_range(s64 val)
>  		val < ((1L << 31) - (1L << 11));
>  }
>  
> +/* Modify rd pointer to alternate reg to avoid corrupting orignal reg */

Hi Pu Lehui,

nit: original

I suggest running checkpatch --codespell over this series before submitting
v2.

