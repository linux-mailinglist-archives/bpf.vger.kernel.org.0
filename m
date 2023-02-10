Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946F9692096
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 15:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjBJOPQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 09:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjBJOPP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 09:15:15 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3201EBE9
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 06:15:12 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id hx15so16153680ejc.11
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 06:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NF5DLo+zNkdPXq3f8T4PzZK9JMILctmjLxyPFSx+yjI=;
        b=YmpUnYKDYORxsbjoOZ/L9INumNf0PGWzBmL3Zy5cvcxABirqJxMhHvlEMrJ7Fa9p7S
         Cizrx/ri3AEfZpbL5nzZ8vshH4/P1bSkJWceD9ncFsKClav9qLmsiySfKqbVpk9guIZI
         rLXpDgeJ/vgGFazvXBucsBYSTDB6s21z5Izby5RGgQgqC/rLDULobRzHIeGTeS2GmMcM
         ug0o5tZYx27ZLxxfrkn+VoCn5Fyffg5koV059t3h9s7bSYfmJV1MfBsaXcPUuclCEYu9
         rGa9MkkbNvmgYnXzdEBXOzV8Wofhlh8RhvzxCeKCNSVANwc3wRp15SyckRrRRcBpWFKN
         m2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NF5DLo+zNkdPXq3f8T4PzZK9JMILctmjLxyPFSx+yjI=;
        b=bBHMsikD0YzrBi5FT4Oo0jSRGa96sKhAyEQZk+v+y3GItkfmOYUF4P2c6AeLaP1wzX
         q8gz3y9W2fbVCzI8PT/lyP2gmkjcJMRZ15xJc3axB7fDN0OOpjzyrO+i1XEBm9MwGG78
         JlTtqctJ7k1+qDN6hlYlXji1OJ44BogRWIvB39T5BOEHpIxniNzVkqUgs+7aMxq63lNw
         FWah/jDr9oAL0IM9QWCJMXbiPmTo3ZBNBHwBfjkfZeUqPIEZRwc8Py4LBjNxbSS/hdbi
         XmZ9qRgL/mn/oyDtXvS7I0aIzHAo7WPbB5tRacUFSYkZiM89c921akAt/YAoKUHjij3z
         59hw==
X-Gm-Message-State: AO0yUKX+bWdAfAlt2EtLpU0gDBhoifY9x2kfGkD223Z1q38SW+6qBgpr
        IbQVF7EAbV/oz6QOmBIweplTw8C+JY7HZQ==
X-Google-Smtp-Source: AK7set/gCfh7KGBpogQLiFSZKey5QLC7CUoa7JNUD5QzH+LDX94JuSc/jegUdS7l3M7Zd7yUuSDyPg==
X-Received: by 2002:a17:907:1608:b0:87b:d62c:d87 with SMTP id hb8-20020a170907160800b0087bd62c0d87mr21389801ejc.1.1676038510819;
        Fri, 10 Feb 2023 06:15:10 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:2d0])
        by smtp.gmail.com with ESMTPSA id b5-20020a170906d10500b008784bc1dd05sm2395140ejz.76.2023.02.10.06.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 06:15:10 -0800 (PST)
Date:   Fri, 10 Feb 2023 15:15:08 +0100
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 bpf-next 08/11] bpf: Special verifier handling for
 bpf_rbtree_{remove, first}
Message-ID: <20230210141508.gullmm3ybvtoibpb@apollo>
References: <20230209174144.3280955-1-davemarchevsky@fb.com>
 <20230209174144.3280955-9-davemarchevsky@fb.com>
 <20230210031125.ckngdktylhslsxwd@MacBook-Pro-6.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210031125.ckngdktylhslsxwd@MacBook-Pro-6.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 10, 2023 at 04:11:25AM CET, Alexei Starovoitov wrote:
> On Thu, Feb 09, 2023 at 09:41:41AM -0800, Dave Marchevsky wrote:
> > @@ -9924,11 +9934,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >  				   meta.func_id == special_kfunc_list[KF_bpf_list_pop_back]) {
> >  				struct btf_field *field = meta.arg_list_head.field;
> >
> > -				mark_reg_known_zero(env, regs, BPF_REG_0);
> > -				regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
> > -				regs[BPF_REG_0].btf = field->graph_root.btf;
> > -				regs[BPF_REG_0].btf_id = field->graph_root.value_btf_id;
> > -				regs[BPF_REG_0].off = field->graph_root.node_offset;
> > +				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
> > +			} else if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
> > +				   meta.func_id == special_kfunc_list[KF_bpf_rbtree_first]) {
> > +				struct btf_field *field = meta.arg_rbtree_root.field;
> > +
> > +				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
> >  			} else if (meta.func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
> >  				mark_reg_known_zero(env, regs, BPF_REG_0);
> >  				regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_TRUSTED;
> > @@ -9994,7 +10005,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >  			if (is_kfunc_ret_null(&meta))
> >  				regs[BPF_REG_0].id = id;
> >  			regs[BPF_REG_0].ref_obj_id = id;
> > +		} else if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_first]) {
> > +			ref_set_non_owning_lock(env, &regs[BPF_REG_0]);
> >  		}
>
> Looking at the above code where R0 state is set across two different if-s
> it feels that bool non_owning_ref_lock from patch 2 shouldn't be a bool.
>
> Patch 7 also has this split initialization of the reg state.
> First it does mark_reg_graph_node() which sets regs[regno].type = PTR_TO_BTF_ID | MEM_ALLOC
> and then it does ref_set_non_owning_lock() that sets that bool flag.
> Setting PTR_TO_BTF_ID | MEM_ALLOC in the helper without setting ref_obj_id > 0
> at the same time feels error prone.
>
> This non_owning_ref_lock bool flag is actually a just flag.
> I think it would be cleaner to make it similar to MEM_ALLOC and call it
> NON_OWN_REF = BIT(14 + BPF_BASE_TYPE_BITS).
>
> Then we can set it at once in this patch and in patch 7 and avoid this split init.
> The check in patch 2 also will become cleaner.
> Instead of:
> if (type_is_ptr_alloc_obj(reg->type) && reg->non_owning_ref_lock)
> it will be
> if (reg->type == PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF)
>
> the transition from owning to non-owning would be easier to follow as well:
> PTR_TO_BTF_ID | MEM_ALLOC with ref_obj_id > 0
>  ->
>    PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF with ref_obj_id == 0
>

Separate type flag looks cleaner to me too, especially now that such non-owning
references have concrete semantics and context associated with them.

> and it will probably help to avoid bugs where PTR_TO_BTF_ID | MEM_ALLOC is accepted
> but we forgot to check ref_obj_id. There are no such places now, but it feels
> less error prone with proper flag instead of bool.
>
> I would also squash patches 1 and 2. Since we've analyzed correctness of patch 2 well enough
> it doesn't make sense to go through the churn in patch 1 just to delete it in patch 2.
>

+1

> wdyt?
