Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08120691707
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 04:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjBJDLb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 22:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjBJDLa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 22:11:30 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCDE25B87
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 19:11:29 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id nn4-20020a17090b38c400b00233a6f118d0so1400641pjb.2
        for <bpf@vger.kernel.org>; Thu, 09 Feb 2023 19:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GLt3LsvUMmWJ7n4Zf/xVUe3GcvSeAfoA8jq/L/mg+m4=;
        b=EoreiXxCLCNxwOSgPdxhUZCui5MyUKm/VWZsn3fQqUIZJmezrN2s2QznxHoFp06hCs
         Mly6C0FISqEbTCCTCMqVjq+Ko6h0DRaw3QgRXC7z+2etnGxi7ExQCDSuboib85XmR9Ix
         guW0MhOQ/LElPcgjC9hdpxNxAD0Dhg7sReIcOBCDbLX5cgs9O4AT0QViaI0fiJaHzr+K
         QJs4NajKH/spzTghENGF7/AVvE13adMQO4cNAKhGBAOx29tyO+exJmQvYb0DHe0uqKL1
         apyIyrLd1aZapK1FvVPryMu8Kveh5bS/wgq1Z7iuxE1u3qFOQ8oNyXXUkW8GReMB07Xo
         q7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLt3LsvUMmWJ7n4Zf/xVUe3GcvSeAfoA8jq/L/mg+m4=;
        b=ALvIgQws2LsKLymqtWoEoJyT5l2/5g/+Bz6oPi+8o0WyP2fZj048wawEgZ7H+EXtmv
         /9TliKCQ6F9dyhdt84aQFCIJs7XMaAUaN7H09JdMGJDOzD7bkSCLsZ2/JeorJRGpf8lW
         kijsnL2MKA386jOOS38nZ0tUdo2XatUauM40d5Bt32vgE2dAspNEwq+p5Uwc8iBGWf67
         4Vb1+L4Cj7kgUzNGgu/+n6oxktNmmX++MKJCG6VuK79xupiq1vfhCNxauf/e/3bQQDz9
         MiRkJYY6ReJOwll7dk/2cVmST9a5qWanJNLgPKeBFAtWU141urHPwetPE4aX6o2FJ3x4
         W6MQ==
X-Gm-Message-State: AO0yUKWa65XfeZasUlkpjgCz98XO8eKKwnE5UhM41dwl7VM2fbQ2gNkc
        I/1TcMLbEOdSLeQeTAXWZkA=
X-Google-Smtp-Source: AK7set/fuV5/TBhnP/s6pCn4RyvaX+wkOER5USZ0bTM/QgoOmvDTNUsRtYbgmYLQ4wPiRGkcNFTB2A==
X-Received: by 2002:a05:6a20:69a6:b0:bf:85bc:ef33 with SMTP id t38-20020a056a2069a600b000bf85bcef33mr14017846pzk.42.1675998688893;
        Thu, 09 Feb 2023 19:11:28 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:c6db])
        by smtp.gmail.com with ESMTPSA id g6-20020a63b146000000b0042988a04bfdsm2013760pgp.9.2023.02.09.19.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 19:11:28 -0800 (PST)
Date:   Thu, 9 Feb 2023 19:11:25 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 bpf-next 08/11] bpf: Special verifier handling for
 bpf_rbtree_{remove, first}
Message-ID: <20230210031125.ckngdktylhslsxwd@MacBook-Pro-6.local>
References: <20230209174144.3280955-1-davemarchevsky@fb.com>
 <20230209174144.3280955-9-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209174144.3280955-9-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 09, 2023 at 09:41:41AM -0800, Dave Marchevsky wrote:
> @@ -9924,11 +9934,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  				   meta.func_id == special_kfunc_list[KF_bpf_list_pop_back]) {
>  				struct btf_field *field = meta.arg_list_head.field;
>  
> -				mark_reg_known_zero(env, regs, BPF_REG_0);
> -				regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
> -				regs[BPF_REG_0].btf = field->graph_root.btf;
> -				regs[BPF_REG_0].btf_id = field->graph_root.value_btf_id;
> -				regs[BPF_REG_0].off = field->graph_root.node_offset;
> +				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
> +			} else if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
> +				   meta.func_id == special_kfunc_list[KF_bpf_rbtree_first]) {
> +				struct btf_field *field = meta.arg_rbtree_root.field;
> +
> +				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
>  			} else if (meta.func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
>  				mark_reg_known_zero(env, regs, BPF_REG_0);
>  				regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_TRUSTED;
> @@ -9994,7 +10005,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			if (is_kfunc_ret_null(&meta))
>  				regs[BPF_REG_0].id = id;
>  			regs[BPF_REG_0].ref_obj_id = id;
> +		} else if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_first]) {
> +			ref_set_non_owning_lock(env, &regs[BPF_REG_0]);
>  		}

Looking at the above code where R0 state is set across two different if-s
it feels that bool non_owning_ref_lock from patch 2 shouldn't be a bool.

Patch 7 also has this split initialization of the reg state.
First it does mark_reg_graph_node() which sets regs[regno].type = PTR_TO_BTF_ID | MEM_ALLOC
and then it does ref_set_non_owning_lock() that sets that bool flag.
Setting PTR_TO_BTF_ID | MEM_ALLOC in the helper without setting ref_obj_id > 0
at the same time feels error prone.

This non_owning_ref_lock bool flag is actually a just flag.
I think it would be cleaner to make it similar to MEM_ALLOC and call it
NON_OWN_REF = BIT(14 + BPF_BASE_TYPE_BITS).

Then we can set it at once in this patch and in patch 7 and avoid this split init.
The check in patch 2 also will become cleaner.
Instead of:
if (type_is_ptr_alloc_obj(reg->type) && reg->non_owning_ref_lock)
it will be
if (reg->type == PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF)

the transition from owning to non-owning would be easier to follow as well:
PTR_TO_BTF_ID | MEM_ALLOC with ref_obj_id > 0
 -> 
   PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF with ref_obj_id == 0

and it will probably help to avoid bugs where PTR_TO_BTF_ID | MEM_ALLOC is accepted
but we forgot to check ref_obj_id. There are no such places now, but it feels
less error prone with proper flag instead of bool.

I would also squash patches 1 and 2. Since we've analyzed correctness of patch 2 well enough
it doesn't make sense to go through the churn in patch 1 just to delete it in patch 2.

wdyt?
