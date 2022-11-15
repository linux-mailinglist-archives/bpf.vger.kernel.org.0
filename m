Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAE86291D0
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 07:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiKOG0m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 01:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiKOG0l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 01:26:41 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9567E1EC75
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 22:26:40 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id b62so12444378pgc.0
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 22:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a238A7VfVTURFUHS8cMxnIg6hx8DYwg9/Fcw7LRFR08=;
        b=SARLzjuVkpFnM/o6l9iEJ242iafI1IUgHO7sJETRZxWPjX7lbmYMD2lTsTk942pCUr
         v+inlCVgf/5ZiWMVG4WG7DKiGY0LPcWAiHogcqNuGv9t8kQlyLkYteWFCXQkt/IA29nm
         2S/jyuvyXRh5H8aXgSsTjguq/8RTnopDdnvf6QbP/KRfb22lYVasMKWEAY0+NPKw/9/a
         UQCp5MlHn4i1+LW/oNbpHmcLe1SaN6F4kStCs7idrry6cHITU+vngwuNFGW6HgW7jTcg
         GEF/pbbm9Jamfk/hUv27I/5lUjgpAk8ictlgNNUHY7EOnWl3qfPfXO4ljIzf0rPPMaqk
         oWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a238A7VfVTURFUHS8cMxnIg6hx8DYwg9/Fcw7LRFR08=;
        b=S2gy452kgjo6flUogECaEIluhVWx9Zf+xd5Q9AkEz0MKutQvHtKUd7E8SNkuaHxLYH
         DWoewk9xOtXAzOLOnN+oo02OMNp4t1zjW/h/rjvg4FKFiFfy3Fl2Y+/kZGVroBsxIpe+
         se+SZS2F7gPwb2wT0aTNXkgHzf3759dfJOngkCJj4Q7JUk+Vf6i+G0mCPglQy8UuiQT0
         zpqc/cZHZHkwR6Vxz+/R6vd2ltUhWIy3AYGSTKeN4MIczOwN/MMiqkcrU3cDTFNq75Bd
         0iK4awUZSUj8Deb9hoMhp5aivIG756s8O4EwD5M7y/zJj85/J/To0hXEL2GS9If9faSF
         AbzA==
X-Gm-Message-State: ANoB5pkEKM28Ma/ueJ3SfCjWMciHQC7pIsTv7gVZJpNSeiwTDkySIGQ/
        eIkkTbFrl1Q0kEhwk/zCx4iSucnOtoQ=
X-Google-Smtp-Source: AA0mqf4i8TVN0LI66M9+o+6H0NDDD1FyQsUMSDpFqLamjkiAYLaID1xxNNsy4PpYZHzvr01N6HOfZg==
X-Received: by 2002:a63:570b:0:b0:470:5619:4d7d with SMTP id l11-20020a63570b000000b0047056194d7dmr14490477pgb.301.1668493600023;
        Mon, 14 Nov 2022 22:26:40 -0800 (PST)
Received: from macbook-pro-5.dhcp.thefacebook.com ([2620:10d:c090:400::5:cee6])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902654e00b0017e9b820a1asm8785056pln.100.2022.11.14.22.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 22:26:39 -0800 (PST)
Date:   Mon, 14 Nov 2022 22:26:37 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: [PATCH bpf-next v7 20/26] bpf: Introduce single ownership BPF
 linked list API
Message-ID: <20221115062637.hzuo7ehffpuxflsw@macbook-pro-5.dhcp.thefacebook.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
 <20221114191547.1694267-21-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114191547.1694267-21-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 12:45:41AM +0530, Kumar Kartikeya Dwivedi wrote:
> +}
> +
> +static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
> +					   struct bpf_reg_state *reg, u32 regno,
> +					   struct bpf_kfunc_call_arg_meta *meta)
> +{
> +	struct btf_struct_meta *struct_meta;
> +	struct btf_field *field;
> +	struct btf_record *rec;
> +	u32 list_node_off;
> +
> +	if (meta->btf != btf_vmlinux ||
> +	    (meta->func_id != special_kfunc_list[KF_bpf_list_push_front] &&
> +	     meta->func_id != special_kfunc_list[KF_bpf_list_push_back])) {
> +		verbose(env, "verifier internal error: bpf_list_head argument for unknown kfunc\n");

typo. bpf_list_node ?

> +		return -EFAULT;
> +	}
> +
> +	if (!tnum_is_const(reg->var_off)) {
> +		verbose(env,
> +			"R%d doesn't have constant offset. bpf_list_head has to be at the constant offset\n",

same typo?

> +			regno);
> +		return -EINVAL;
> +	}
> +
> +	struct_meta = btf_find_struct_meta(reg->btf, reg->btf_id);
> +	if (!struct_meta) {
> +		verbose(env, "bpf_list_node not found for allocated object\n");
> +		return -EINVAL;
> +	}
> +	rec = struct_meta->record;
> +
> +	list_node_off = reg->off + reg->var_off.value;
> +	field = btf_record_find(rec, list_node_off, BPF_LIST_NODE);
> +	if (!field || field->offset != list_node_off) {
> +		verbose(env, "bpf_list_node not found at offset=%u\n", list_node_off);
> +		return -EINVAL;
> +	}
> +
> +	field = meta->arg_list_head.field;
> +
> +	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, 0, field->list_head.btf,
> +				  field->list_head.value_btf_id, true)) {
> +		verbose(env, "bpf_list_head value type does not match arg#1\n");

and the same typo again?!

> +		return -EINVAL;
> +	}
> +
> +	if (list_node_off != field->list_head.node_offset) {
> +		verbose(env, "arg#1 offset must be for bpf_list_node at off=%d\n",
> +			field->list_head.node_offset);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
