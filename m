Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C13629FC2
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 18:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKOQ77 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 11:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiKOQ76 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 11:59:58 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D6A286DF
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 08:59:58 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id g24so13726280plq.3
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 08:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hIbbEr/3Kh8NkpFyrukeQPM5xgK3uZ8FOG2wO93T5BA=;
        b=XN+TQY/+lDtBnldrkeaZcUtmdpY6usTYeMVRiK9ArLaM/qKJWH4wD/NXIS/sIE75Hq
         8s4o6caDva6IREOo0hAqenpMAAdV9hUl7KDyUvoQ/WykslnkzeE/khMSSHjhC2IZLN05
         HbBv/EAI+n7frq2wNhyR/GpvoCZ/3U/jPz9lL/ht3oIe176sKiDSqX38T4GT23Vymn25
         MnddLbGqbrjpKZutFye9GsTZ4nwndd656T8EU1iJxd9I6+SrafOHW8SdA9VfuM5c7sS4
         8dNmVtFuqFUmyjRt+Mc1fPlefOxgZmWBNwWXFVSE9KPs7lR5tU+TiUophKAnBsszCGZH
         dmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIbbEr/3Kh8NkpFyrukeQPM5xgK3uZ8FOG2wO93T5BA=;
        b=BgAfhUcxNUdJu3qvAbEZYsC4JIvTw20rR02MdnWP+/uL6un/CVSSUVxTJvFfB8brF2
         bwj66Jk1vrWV8FQEKgIBuanhB0Zm0yWqlCC5Z7C85BIumv9tZ2ZcpbqLI8D+VpLUm5xd
         hungd2n69wqf3jQI89t4AmTnL2Ju2vPsCOrLtzLzidaPT4/JN8r4PjAXqp6IsXBr+c7r
         rBLkH2tSvv5tns0Rb5uFmNya4iF4C3HJzclMkWlYMTGd06ScK8tk+CcnnUeJdzkm0r4z
         IoSIkZKkvp6unFxeUr3rMk14+Txeamax1NLn+6gfluXVa9AtvoMkw30CmHc2/L19x7YA
         nbiw==
X-Gm-Message-State: ANoB5pnEyWdxU0WmIlDGpS1YMx1R/i48SIxx7lu1Myxl7hKJD7xWCq2X
        byLek6T/UPvSS0AkAssfEqg=
X-Google-Smtp-Source: AA0mqf5rBP4xmrEyJg7VutWU2sZmT0KCD71AlAchwyuWD1NdsSefKwImr2l3KXHA2jNU25BF4VcxeQ==
X-Received: by 2002:a17:902:ba92:b0:188:d4ea:2568 with SMTP id k18-20020a170902ba9200b00188d4ea2568mr3931903pls.14.1668531597449;
        Tue, 15 Nov 2022 08:59:57 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id g3-20020a170902868300b00168dadc7354sm10136594plo.78.2022.11.15.08.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:59:57 -0800 (PST)
Date:   Tue, 15 Nov 2022 22:29:51 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: [PATCH bpf-next v7 20/26] bpf: Introduce single ownership BPF
 linked list API
Message-ID: <20221115165951.fy7bqwcum3veiz2d@apollo>
References: <20221114191547.1694267-1-memxor@gmail.com>
 <20221114191547.1694267-21-memxor@gmail.com>
 <20221115062637.hzuo7ehffpuxflsw@macbook-pro-5.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115062637.hzuo7ehffpuxflsw@macbook-pro-5.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 11:56:37AM IST, Alexei Starovoitov wrote:
> On Tue, Nov 15, 2022 at 12:45:41AM +0530, Kumar Kartikeya Dwivedi wrote:
> > +}
> > +
> > +static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
> > +					   struct bpf_reg_state *reg, u32 regno,
> > +					   struct bpf_kfunc_call_arg_meta *meta)
> > +{
> > +	struct btf_struct_meta *struct_meta;
> > +	struct btf_field *field;
> > +	struct btf_record *rec;
> > +	u32 list_node_off;
> > +
> > +	if (meta->btf != btf_vmlinux ||
> > +	    (meta->func_id != special_kfunc_list[KF_bpf_list_push_front] &&
> > +	     meta->func_id != special_kfunc_list[KF_bpf_list_push_back])) {
> > +		verbose(env, "verifier internal error: bpf_list_head argument for unknown kfunc\n");
>
> typo. bpf_list_node ?
>
> > +		return -EFAULT;
> > +	}
> > +
> > +	if (!tnum_is_const(reg->var_off)) {
> > +		verbose(env,
> > +			"R%d doesn't have constant offset. bpf_list_head has to be at the constant offset\n",
>
> same typo?
>

These two are typos.

> > +			regno);
> > +		return -EINVAL;
> > +	}
> > +
> > +	struct_meta = btf_find_struct_meta(reg->btf, reg->btf_id);
> > +	if (!struct_meta) {
> > +		verbose(env, "bpf_list_node not found for allocated object\n");
> > +		return -EINVAL;
> > +	}
> > +	rec = struct_meta->record;
> > +
> > +	list_node_off = reg->off + reg->var_off.value;
> > +	field = btf_record_find(rec, list_node_off, BPF_LIST_NODE);
> > +	if (!field || field->offset != list_node_off) {
> > +		verbose(env, "bpf_list_node not found at offset=%u\n", list_node_off);
> > +		return -EINVAL;
> > +	}
> > +
> > +	field = meta->arg_list_head.field;
> > +
> > +	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, 0, field->list_head.btf,
> > +				  field->list_head.value_btf_id, true)) {
> > +		verbose(env, "bpf_list_head value type does not match arg#1\n");
>
> and the same typo again?!
>

This is probably just poorly worded.
The value type (__contains) of bpf_list_head does not match arg#1 (node).

What's better, maybe:
bpf_list_node type does not match bpf_list_head value type?
