Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319833B9F11
	for <lists+bpf@lfdr.de>; Fri,  2 Jul 2021 12:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhGBK2t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Jul 2021 06:28:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22165 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230496AbhGBK2t (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 2 Jul 2021 06:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625221577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EM4rv+Os2BFUcNbdujbpAl42XdEpcURNArLBdyldSyk=;
        b=MxM6F1mRqZsHnllDbFUcTx+B+NE8XZ77vuwb6uwr46M2aQs99uRI0EDKMCc7mdtqoKkkgc
        gRU7/nsGHDIp0ZPSMDMNe8YPAiSpn0/rlbl+gFwZ3B+Oal/HcDA7ltGDlZ1EvDwYU99189
        yvGUPCF3nlJHa5wicEn5wHvbIQ+AdR8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-zErVilPiN-CWFQPsa3teUQ-1; Fri, 02 Jul 2021 06:26:16 -0400
X-MC-Unique: zErVilPiN-CWFQPsa3teUQ-1
Received: by mail-ed1-f71.google.com with SMTP id f20-20020a0564020054b0290395573bbc17so4857029edu.19
        for <bpf@vger.kernel.org>; Fri, 02 Jul 2021 03:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EM4rv+Os2BFUcNbdujbpAl42XdEpcURNArLBdyldSyk=;
        b=l07L+mV6IaCgDO2A72PA892fovtQTbSgwDRZ+gVQiE+oshNRDeZ60QAELMPE13YpbY
         t2jFYIyNpJ+2u4/IYn+bBuXCkPJjtnJnOKyefV40YtlWJ6kMIkEySW3Bd6KS0JGBfGwN
         IyVvDI2BsrVuZx3KYu0r69/3Szqt9474zdai1QJFshyUdntKEdMXIaE4ciLYxtvVrQXl
         C+bKNoJglaESYGRrAzByZAiRc0ksVNcWxUWOWDfN9cUCTkvXXcHhtDbR3ULW5sX+O5L1
         hx19Yht45oVHalePa5qMNsNrqxU6h1Pe7jackD/eGby5nAsUem1XwuUi086oZyYHbozc
         xkAw==
X-Gm-Message-State: AOAM5324qSXDJ52zNEJBU892GGCLP9nAzgmfVGD4QzDKp8KnbrG3Acbz
        q8XSEluo8P5fpcD3gxuq6uh1a/9ADdL1kQm3wHUWkQxobJWoPuuWGS4hjjlzRlAzfl5B73zwDee
        ZpNWqM/iv0TkB
X-Received: by 2002:a05:6402:31b3:: with SMTP id dj19mr1648293edb.24.1625221574989;
        Fri, 02 Jul 2021 03:26:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzn8k1h6e/dZCweAEKoFXiejKrvCFYp7PHqlHpnkSx8je37PU0hXAgg8Sl+uceeRMdngxs2Gg==
X-Received: by 2002:a05:6402:31b3:: with SMTP id dj19mr1648281edb.24.1625221574866;
        Fri, 02 Jul 2021 03:26:14 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id g23sm1122002edp.74.2021.07.02.03.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 03:26:14 -0700 (PDT)
Date:   Fri, 2 Jul 2021 12:26:11 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Brendan Jackman <jackmanb@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 1/2] powerpc/bpf: Fix detecting BPF atomic instructions
Message-ID: <YN7pw2mAg35Yao6/@krava>
References: <cover.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
 <4117b430ffaa8cd7af042496f87fd7539e4f17fd.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4117b430ffaa8cd7af042496f87fd7539e4f17fd.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 01, 2021 at 08:38:58PM +0530, Naveen N. Rao wrote:
> Commit 91c960b0056672 ("bpf: Rename BPF_XADD and prepare to encode other
> atomics in .imm") converted BPF_XADD to BPF_ATOMIC and added a way to
> distinguish instructions based on the immediate field. Existing JIT
> implementations were updated to check for the immediate field and to
> reject programs utilizing anything more than BPF_ADD (such as BPF_FETCH)
> in the immediate field.
> 
> However, the check added to powerpc64 JIT did not look at the correct
> BPF instruction. Due to this, such programs would be accepted and
> incorrectly JIT'ed resulting in soft lockups, as seen with the atomic
> bounds test. Fix this by looking at the correct immediate value.
> 
> Fixes: 91c960b0056672 ("bpf: Rename BPF_XADD and prepare to encode other atomics in .imm")
> Reported-by: Jiri Olsa <jolsa@redhat.com>
> Tested-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> Hi Jiri,
> FYI: I made a small change in this patch -- using 'imm' directly, rather 
> than insn[i].imm. I've still added your Tested-by since this shouldn't 
> impact the fix in any way.

yep, it works nicely

thanks
jirka

> 
> - Naveen
> 
> 
>  arch/powerpc/net/bpf_jit_comp64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 5cad5b5a7e9774..de8595880feec6 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -667,7 +667,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>  		 * BPF_STX ATOMIC (atomic ops)
>  		 */
>  		case BPF_STX | BPF_ATOMIC | BPF_W:
> -			if (insn->imm != BPF_ADD) {
> +			if (imm != BPF_ADD) {
>  				pr_err_ratelimited(
>  					"eBPF filter atomic op code %02x (@%d) unsupported\n",
>  					code, i);
> @@ -689,7 +689,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>  			PPC_BCC_SHORT(COND_NE, tmp_idx);
>  			break;
>  		case BPF_STX | BPF_ATOMIC | BPF_DW:
> -			if (insn->imm != BPF_ADD) {
> +			if (imm != BPF_ADD) {
>  				pr_err_ratelimited(
>  					"eBPF filter atomic op code %02x (@%d) unsupported\n",
>  					code, i);
> -- 
> 2.31.1
> 

