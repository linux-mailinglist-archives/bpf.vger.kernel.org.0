Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6384143AAD8
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 05:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhJZDvV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 23:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbhJZDvU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 23:51:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD410C061745
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 20:48:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k2-20020a17090ac50200b001a218b956aaso588328pjt.2
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 20:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L7yXnguj8TeUILD4Tfggkj7W20tOoJJt8WpfF8TKrj8=;
        b=RrwVmBO9gvIFaUQI+eAMWvxdN+7RjWLuVg1kn1HqZvpvy4leARRTNZU0WSo5gGD1YY
         +9iecQuBO309NfUoUYooEN2Mobzdu7oQYIDEvx68YYysmznL3OJAdtXlzN/9mp1aRCJ6
         Vjijn1O3LzQyp9iyOk/RKP6UuKLOu3keP62taCp8mKXib1WRH9kSMq++kC9jP2G+usIw
         8LoJogoT6So3H18GoCcvl4oMI2PBahyp8V1UWdR0BqzpMYMypdNBBlF6bPO9drwIWbnZ
         HYmUCRCtX8kEKGdtmK8iD/inQv0XAOZgQ1OTSav6+q+2c/znvMm4ucrEB1VtdMxk76XB
         XP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L7yXnguj8TeUILD4Tfggkj7W20tOoJJt8WpfF8TKrj8=;
        b=dyd/eQkCYvmiF5SqRDyXb2pA6BwhD7kiVe47NkxKRB1gfjOLPk/5DSJEpDFvmQVT2A
         I50jnprAe2tcurZgTU/DnxKY3KvjQXCG5DrItrPdg4pCLJmRiCj/oasUxgqsrMv1PjBQ
         4vYx2JtBVcKnpTR1HPU+06I1DNhGo9lgm/5w7Wvk0AGdvrVE2EWzJLhFuQ93/K09GLXq
         I8YXD0BpK/apFOimNp7HBAzpLxD7BJgYL7oeTc3UtKaed3Xlnj8XUC62OsHkY6MV7KU3
         82pCrMra5z4GoLOFv2EiwarfaLsf5qNWcFmgIjrMbVe6hpnmLnIeOxz5tHj1mG2niXUK
         IPTQ==
X-Gm-Message-State: AOAM531m5pSiCYv3LqNchJ9hQLIk9RWnov7cudXF4sX2n0TD36AjXms9
        KEjymMQqhwrqv1Plfgki3vKofkBrV94=
X-Google-Smtp-Source: ABdhPJyClz7Md5d9A1DfxeknZtoriY1rrqWFg1iQvJNGiYHx68C3pp3bDI/uX1NBf5kOJpxVDhA8jw==
X-Received: by 2002:a17:90a:a8f:: with SMTP id 15mr25759564pjw.229.1635220137216;
        Mon, 25 Oct 2021 20:48:57 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8f62])
        by smtp.gmail.com with ESMTPSA id f15sm22871857pfe.132.2021.10.25.20.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 20:48:56 -0700 (PDT)
Date:   Mon, 25 Oct 2021 20:48:54 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Introduce ARG_PTR_TO_WRITABLE_MEM
Message-ID: <20211026034854.3ozkpaxaok7hk6kn@ast-mbp.dhcp.thefacebook.com>
References: <20211025231256.4030142-1-haoluo@google.com>
 <20211025231256.4030142-3-haoluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025231256.4030142-3-haoluo@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 04:12:55PM -0700, Hao Luo wrote:
> Some helper functions may modify its arguments, for example,
> bpf_d_path, bpf_get_stack etc. Previously, their argument types
> were marked as ARG_PTR_TO_MEM, which is compatible with read-only
> mem types, such as PTR_TO_RDONLY_BUF. Therefore it's legitimate
> to modify a read-only memory by passing it into one of such helper
> functions.
> 
> This patch introduces a new arg type ARG_PTR_TO_WRITABLE_MEM to
> annotate the arguments that may be modified by the helpers. For
> arguments that are of ARG_PTR_TO_MEM, it's ok to take any mem type,
> while for ARG_PTR_TO_WRITABLE_MEM, readonly mem reg types are not
> acceptable.
> 
> In short, when a helper may modify its input parameter, use
> ARG_PTR_TO_WRITABLE_MEM instead of ARG_PTR_TO_MEM.
> 
> So far the difference between ARG_PTR_TO_MEM and ARG_PTR_TO_WRITABLE_MEM
> is PTR_TO_RDONLY_BUF and PTR_TO_RDONLY_MEM. PTR_TO_RDONLY_BUF is
> only used in bpf_iter prog as the type of key, which hasn't been
> used in the affected helper functions. PTR_TO_RDONLY_MEM currently
> has no consumers.
> 
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>  Changes since v1:
>   - new patch, introduced ARG_PTR_TO_WRITABLE_MEM to differentiate
>     read-only and read-write mem arg types.
> 
>  include/linux/bpf.h      |  9 +++++++++
>  kernel/bpf/cgroup.c      |  2 +-
>  kernel/bpf/helpers.c     |  2 +-
>  kernel/bpf/verifier.c    | 18 ++++++++++++++++++
>  kernel/trace/bpf_trace.c |  6 +++---
>  net/core/filter.c        |  6 +++---
>  6 files changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7b47e8f344cb..586ce67d63a9 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -341,6 +341,15 @@ enum bpf_arg_type {
>  	ARG_PTR_TO_STACK_OR_NULL,	/* pointer to stack or NULL */
>  	ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string */
>  	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
> +	ARG_PTR_TO_WRITABLE_MEM,	/* pointer to valid memory. Compared to
> +					 * ARG_PTR_TO_MEM, this arg_type is not
> +					 * compatible with RDONLY memory. If the
> +					 * argument may be updated by the helper,
> +					 * use this type.
> +					 */
> +	ARG_PTR_TO_WRITABLE_MEM_OR_NULL,   /* pointer to memory or null, similar to
> +					    * ARG_PTR_TO_WRITABLE_MEM.
> +					    */

Instead of adding new types,
can we do something like this instead:

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c8a78e830fca..5dbd2541aa86 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -68,7 +68,8 @@ struct bpf_reg_state {
                        u32 btf_id;
                };

-               u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
+               u32 rd_mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
+               u32 wr_mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */

                /* Max size from any of the above. */
                struct {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c6616e325803..ad46169d422b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4374,7 +4374,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
                        return -EACCES;
                }
                err = check_mem_region_access(env, regno, off, size,
-                                             reg->mem_size, false);
+                                             t == BPF_WRITE ? reg->wr_mem_size : reg->rd_mem_size, false);
                if (!err && t == BPF_READ && value_regno >= 0)
                        mark_reg_unknown(env, regs, value_regno);
        } else if (reg->type == PTR_TO_CTX) {
@@ -11511,7 +11511,8 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
                        goto err_put;
                }
                aux->btf_var.reg_type = PTR_TO_MEM;
-               aux->btf_var.mem_size = tsize;
+               aux->btf_var.rd_mem_size = tsize;
+               aux->btf_var.wr_mem_size = 0;
        } else {
                aux->btf_var.reg_type = PTR_TO_BTF_ID;
                aux->btf_var.btf = btf;

