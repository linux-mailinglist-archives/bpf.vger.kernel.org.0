Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84301559898
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 13:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiFXLhO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 07:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFXLhO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 07:37:14 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B1D7946B
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 04:37:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m1so2775147wrb.2
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 04:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kFHIsLpnRngnhveG5SS8YxStPFGCqilJv+KNYCsp+p4=;
        b=06Uzn64evaRqUHY3wgJhGf0j+xejHu/p31jHOuv06d0evYTZOB5ADeSmuWTpgGoGrX
         Kdmr8p8FZssH3WMlgMnl1XxduTInUUd/b8tgxlOzxw4qqKHxRA9ttCT6w2DagWPHnTDa
         nOMw77D/0D2J8D+FUblJUd1WkOAaTIiRajnQpv3UAIOWD+p76Fi7lUjl84cSnGJzDmUL
         nHCatoxLHkd7dpOeNOapH6BV06OWA5NnpEE2YOym7Tdxwg6FVHdMYCCYz1Uau7nBfC2+
         rQuybZKnlgswV10b1LWCacvMxOCEAyxBrnGmMEl2XQFGQDtMDun8LGSs8KzqUvCfMWRb
         54eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kFHIsLpnRngnhveG5SS8YxStPFGCqilJv+KNYCsp+p4=;
        b=rm9tZ3ul6X90nPTlq/VN0oqfJWGs/qu0bJls+gpTKtKQI+1hZwEbUuuTQ4DWw89plF
         VfyvMfHPDOIbLXUdcEcp7/J/tGZZ+Fttsv4BDj0nPHwaon+NNqSKiON9Fn+jWvPanu+Z
         Ib7Br8AU7ltu9J4sJqsrS08Ut8/DYihC1bvk7BZgm/6F2JiFME8Rip+iTNvzfdSGFt/y
         T2/qh9RnggZe1vrHOV03giZ4m1ZfCtnnI6sB92b2c/OwyMgGSwGokvIj7Ksgtamxs2wT
         2S8M4N49o3plggH3bjqEmmCJuyW65jBtmrkwg6rz+RzWNkd8p4HBjxmatfP41bE81CfK
         Uahw==
X-Gm-Message-State: AJIora+RpMWmOcELZ5ajEVk+8rR4RxdJrKXxieET8ofdac5evQAJYmXv
        fpciHhbfhLtaKxubAXzFwUjZLw==
X-Google-Smtp-Source: AGRyM1sa/8pU6r2Ay5BubikGheGU/nuRzY4lDkSGEN/XMlyfrmEBhoxNvQStzqyri9JUL8HsYamI9Q==
X-Received: by 2002:a5d:4a42:0:b0:21b:838f:12bc with SMTP id v2-20020a5d4a42000000b0021b838f12bcmr12668870wrs.523.1656070631063;
        Fri, 24 Jun 2022 04:37:11 -0700 (PDT)
Received: from [192.168.178.21] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b0020d02262664sm2188410wri.25.2022.06.24.04.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 04:37:10 -0700 (PDT)
Message-ID: <a4770a25-b78a-d721-4d30-ae58feec965c@isovalent.com>
Date:   Fri, 24 Jun 2022 12:37:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH bpf-next v2 2/9] bpftool: Honor BPF_CORE_TYPE_MATCHES
 relocation
Content-Language: en-GB
To:     =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     joannelkoong@gmail.com,
        =?UTF-8?Q?Mauricio_V=c3=a1squez?= <mauricio@kinvolk.io>
References: <20220623212205.2805002-1-deso@posteo.net>
 <20220623212205.2805002-3-deso@posteo.net>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220623212205.2805002-3-deso@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-06-23 21:21 UTC+0000 ~ Daniel Müller <deso@posteo.net>
> bpftool needs to know about the newly introduced BPF_CORE_TYPE_MATCHES
> relocation for its 'gen min_core_btf' command to work properly in the
> present of this relocation.
> Specifically, we need to make sure to mark types and fields so that they
> are present in the minimized BTF for "type match" checks to work out.
> However, contrary to the existing btfgen_record_field_relo, we need to
> rely on the BTF -- and not the spec -- to find fields. With this change
> we handle this new variant correctly. The functionality will be tested
> with follow on changes to BPF selftests, which already run against a
> minimized BTF created with bpftool.
> 
> Cc: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Daniel Müller <deso@posteo.net>
> ---
>  tools/bpf/bpftool/gen.c | 107 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 480cbd8..6cd0ed 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -1856,6 +1856,111 @@ static int btfgen_record_field_relo(struct btfgen_info *info, struct bpf_core_sp
>  	return 0;
>  }
>  
> +/* Mark types, members, and member types. Compared to btfgen_record_field_relo,
> + * this function does not rely on the target spec for inferring members, but
> + * uses the associated BTF.
> + *
> + * The `behind_ptr` argument is used to stop marking of composite types reached
> + * through a pointer. This way, we keep can keep BTF size in check while

Typo, "we keep can keep"

> + * providing reasonable match semantics.
> + */
> +static int btfgen_mark_types_match(struct btfgen_info *info, __u32 type_id, bool behind_ptr)
> +{
> +	const struct btf_type *btf_type;
> +	struct btf *btf = info->src_btf;
> +	struct btf_type *cloned_type;
> +	int i, err;
> +
> +	if (type_id == 0)
> +		return 0;
> +
> +	btf_type = btf__type_by_id(btf, type_id);
> +	/* mark type on cloned BTF as used */
> +	cloned_type = (struct btf_type *)btf__type_by_id(info->marked_btf, type_id);
> +	cloned_type->name_off = MARKED;
> +
> +	switch (btf_kind(btf_type)) {
> +	case BTF_KIND_UNKN:
> +	case BTF_KIND_INT:
> +	case BTF_KIND_FLOAT:
> +	case BTF_KIND_ENUM:
> +	case BTF_KIND_ENUM64:
> +		break;
> +	case BTF_KIND_STRUCT:
> +	case BTF_KIND_UNION: {
> +		struct btf_member *m = btf_members(btf_type);
> +		__u16 vlen = btf_vlen(btf_type);
> +
> +		if (behind_ptr)
> +			break;
> +
> +		for (i = 0; i < vlen; i++, m++) {
> +			/* mark member */
> +			btfgen_mark_member(info, type_id, i);
> +
> +			/* mark member's type */
> +			err = btfgen_mark_types_match(info, m->type, false);
> +			if (err)
> +				return err;
> +		}
> +		break;
> +	}
> +	case BTF_KIND_CONST:
> +	case BTF_KIND_FWD:
> +	case BTF_KIND_VOLATILE:
> +	case BTF_KIND_TYPEDEF:
> +		return btfgen_mark_types_match(info, btf_type->type, false);
> +	case BTF_KIND_PTR:
> +		return btfgen_mark_types_match(info, btf_type->type, true);
> +	case BTF_KIND_ARRAY: {
> +		struct btf_array *array;
> +
> +		array = btf_array(btf_type);
> +		/* mark array type */
> +		err = btfgen_mark_types_match(info, array->type, false);
> +		/* mark array's index type */
> +		err = err ? : btfgen_mark_types_match(info, array->index_type, false);
> +		if (err)
> +			return err;
> +		break;
> +	}
> +	case BTF_KIND_FUNC_PROTO: {
> +		__u16 vlen = btf_vlen(btf_type);
> +		struct btf_param *param;
> +
> +		/* mark ret type */
> +		err = btfgen_mark_types_match(info, btf_type->type, false);
> +		if (err)
> +			return err;
> +
> +		/* mark parameters types */
> +		param = btf_params(btf_type);
> +		for (i = 0; i < vlen; i++) {
> +			err = btfgen_mark_types_match(info, param->type, false);
> +			if (err)
> +				return err;
> +			param++;
> +		}
> +		break;
> +	}
> +	/* tells if some other type needs to be handled */
> +	default:
> +		p_err("unsupported kind: %s (%d)", btf_kind_str(btf_type), type_id);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Mark types, members, and member types. Compared to btfgen_record_field_relo,
> + * this function does not rely on the target spec for inferring members, but
> + * uses the associated BTF.
> + */
> +static int btfgen_record_types_match_relo(struct btfgen_info *info, struct bpf_core_spec *targ_spec)

Nit: Maybe btfgen_record_type_match_relo() ("type" singular), for
consistency with btfgen_record_type_relo()?

> +{
> +	return btfgen_mark_types_match(info, targ_spec->root_type_id, false);
> +}
> +
>  static int btfgen_record_type_relo(struct btfgen_info *info, struct bpf_core_spec *targ_spec)
>  {
>  	return btfgen_mark_type(info, targ_spec->root_type_id, true);
> @@ -1882,6 +1987,8 @@ static int btfgen_record_reloc(struct btfgen_info *info, struct bpf_core_spec *r
>  	case BPF_CORE_TYPE_EXISTS:
>  	case BPF_CORE_TYPE_SIZE:
>  		return btfgen_record_type_relo(info, res);
> +	case BPF_CORE_TYPE_MATCHES:
> +		return btfgen_record_types_match_relo(info, res);
>  	case BPF_CORE_ENUMVAL_EXISTS:
>  	case BPF_CORE_ENUMVAL_VALUE:
>  		return btfgen_record_enumval_relo(info, res);

Aside from the minor nits, the patch looks good to me. Thanks!

Acked-by: Quentin Monnet <quentin@isovalent.com>
