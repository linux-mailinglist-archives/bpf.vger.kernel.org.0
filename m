Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20970510798
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 20:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbiDZS4C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Apr 2022 14:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238860AbiDZS4A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 14:56:00 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA65155705
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 11:52:52 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s137so16804494pgs.5
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 11:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q83nrxCtwJ11Lq7iNqg941Jw01wWW3jUt+b/g/Oob+Q=;
        b=pRXRaCyxDVFtXDS4aNFAiLnKITIqCEyAB1uAnVeKoaTszSw+1Nj0rfOss5mTXMDNEE
         dlaTCaFvZgldxDtuOGre7cAxQmMYI0xnroJerSeUn+RwT71t8xdkN1+MbSZD3/GvD7UC
         2jIE0ZpqmtC1AfzwE8ZveOqseIG1eIETX8hf0WRrxZHNjtLjNJsI+axr3PdFwx09iBje
         rSDlhp1K74iS5xegR5y05wBhiyI9e+kXfkXXDUJnSeVddzM6S9ZvamSOcNfsYw4XH1dU
         H9EpFNKbZVcyDC5PZkwl2knVnKs33qpZyTpGnLRIRC0xFPqpLjgN4q+7haLs8nRtMVZ6
         eQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q83nrxCtwJ11Lq7iNqg941Jw01wWW3jUt+b/g/Oob+Q=;
        b=kc4sfWpFEf8qGIkCoAlvLDfEwc83NsxOWyiXoBYT5Bn+aZvwZehtfW106BdE/t2eJY
         ooSP4EcjjZ00MtuD0CZjoDB3+zzLoXYNjQJW14oYfbsBT9NXctwNBoj/2usmdOcfJTTM
         LOmt37QtnHVX1OqLjb34IsZo2P+e57d952hBP5+WqYabzkN/+2h8HhoPTt7nrpHRXNSf
         CgFBDn8izBU/uagIsLWCmMHVaoXZdsYpdN2RYOsOkKk6CP8sU2kPj8/iLVuM6ETQl1yu
         WLnPsABF2xMIHHhOaNe4Q9rZIpCksizO8iqpYubSKmAopAc9rOG8o18x8273siHrnsmN
         G4Aw==
X-Gm-Message-State: AOAM531Z2PO0cUFUlj0c+TkF3WJ0Qkke1xm/HhYRrPcAaN2Wp1mJyK9O
        K9Fv/4KLEnBd7zxmAkL50IIiscZCSoo=
X-Google-Smtp-Source: ABdhPJxLx4c7UUsSKSPzLRO64p6DSIhqPX6fZIkncJU+dTySGRr0Jr2bEOHTptGiSegBxC/ygbl4rA==
X-Received: by 2002:a63:8943:0:b0:3aa:f1ce:4f24 with SMTP id v64-20020a638943000000b003aaf1ce4f24mr15730370pgd.34.1650999171872;
        Tue, 26 Apr 2022 11:52:51 -0700 (PDT)
Received: from MacBook-Pro.local ([2620:10d:c090:500::2:3e5a])
        by smtp.gmail.com with ESMTPSA id l14-20020a17090aec0e00b001d8ace370cbsm3776663pjy.54.2022.04.26.11.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:52:51 -0700 (PDT)
Date:   Tue, 26 Apr 2022 11:52:48 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 07/10] libbpf: refactor CO-RE relo human
 description formatting routine
Message-ID: <20220426185248.ogbjc7f2rwfzhxqs@MacBook-Pro.local>
References: <20220426004511.2691730-1-andrii@kernel.org>
 <20220426004511.2691730-8-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426004511.2691730-8-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 25, 2022 at 05:45:08PM -0700, Andrii Nakryiko wrote:
> Refactor how CO-RE relocation is formatted. Now it dumps human-readable
> representation, currently used by libbpf in either debug or error
> message output during CO-RE relocation resolution process, into provided
> buffer. This approach allows for better reuse of this functionality
> outside of CO-RE relocation resolution, which we'll use in next patch
> for providing better error message for BPF verifier rejecting BPF
> program due to unguarded failed CO-RE relocation.
> 
> It also gets rid of annoying "stitching" of libbpf_print() calls, which
> was the only place where we did this.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/relo_core.c | 64 +++++++++++++++++++++++----------------
>  1 file changed, 38 insertions(+), 26 deletions(-)
> 
> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index adaa22160692..13d36a705464 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c
> @@ -1055,51 +1055,66 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>   * [<type-id>] (<type-name>) + <raw-spec> => <offset>@<spec>,
>   * where <spec> is a C-syntax view of recorded field access, e.g.: x.a[3].b
>   */
> -static void bpf_core_dump_spec(const char *prog_name, int level, const struct bpf_core_spec *spec)
> +static int bpf_core_format_spec(char *buf, size_t buf_sz, const struct bpf_core_spec *spec)
>  {
>  	const struct btf_type *t;
>  	const struct btf_enum *e;
>  	const char *s;
>  	__u32 type_id;
> -	int i;
> +	int i, len = 0;
> +
> +#define append_buf(fmt, args...)				\
> +	({							\
> +		int r;						\
> +		r = snprintf(buf, buf_sz, fmt, ##args);		\
> +		len += r;					\
> +		if (r >= buf_sz)				\

Do we need to check for r<0 here too or it's highly unlikely?

> +			r = buf_sz;				\
> +		buf += r;					\
> +		buf_sz -= r;					\
> +	})
>  
>  	type_id = spec->root_type_id;
>  	t = btf_type_by_id(spec->btf, type_id);
>  	s = btf__name_by_offset(spec->btf, t->name_off);
>  
> -	libbpf_print(level, "[%u] %s %s", type_id, btf_kind_str(t), str_is_empty(s) ? "<anon>" : s);
> +	append_buf("<%s> [%u] %s %s",
> +		   core_relo_kind_str(spec->relo_kind),
> +		   type_id, btf_kind_str(t), str_is_empty(s) ? "<anon>" : s);
>  
>  	if (core_relo_is_type_based(spec->relo_kind))
> -		return;
> +		return len;
>  
>  	if (core_relo_is_enumval_based(spec->relo_kind)) {
>  		t = skip_mods_and_typedefs(spec->btf, type_id, NULL);
>  		e = btf_enum(t) + spec->raw_spec[0];
>  		s = btf__name_by_offset(spec->btf, e->name_off);
>  
> -		libbpf_print(level, "::%s = %u", s, e->val);
> -		return;
> +		append_buf("::%s = %u", s, e->val);
> +		return len;
>  	}
>  
>  	if (core_relo_is_field_based(spec->relo_kind)) {
>  		for (i = 0; i < spec->len; i++) {
>  			if (spec->spec[i].name)
> -				libbpf_print(level, ".%s", spec->spec[i].name);
> +				append_buf(".%s", spec->spec[i].name);
>  			else if (i > 0 || spec->spec[i].idx > 0)
> -				libbpf_print(level, "[%u]", spec->spec[i].idx);
> +				append_buf("[%u]", spec->spec[i].idx);
>  		}
>  
> -		libbpf_print(level, " (");
> +		append_buf(" (");
>  		for (i = 0; i < spec->raw_len; i++)
> -			libbpf_print(level, "%s%d", i == 0 ? "" : ":", spec->raw_spec[i]);
> +			append_buf("%s%d", i == 0 ? "" : ":", spec->raw_spec[i]);
>  
>  		if (spec->bit_offset % 8)
> -			libbpf_print(level, " @ offset %u.%u)",
> -				     spec->bit_offset / 8, spec->bit_offset % 8);
> +			append_buf(" @ offset %u.%u)", spec->bit_offset / 8, spec->bit_offset % 8);
>  		else
> -			libbpf_print(level, " @ offset %u)", spec->bit_offset / 8);
> -		return;
> +			append_buf(" @ offset %u)", spec->bit_offset / 8);
> +		return len;
>  	}
> +
> +	return len;
> +#undef append_buf
>  }
>  
>  /*
> @@ -1168,6 +1183,7 @@ int bpf_core_calc_relo_insn(const char *prog_name,
>  	const char *local_name;
>  	__u32 local_id;
>  	const char *spec_str;
> +	char spec_buf[256];
>  	int i, j, err;
>  
>  	local_id = relo->type_id;
> @@ -1190,10 +1206,8 @@ int bpf_core_calc_relo_insn(const char *prog_name,
>  		return -EINVAL;
>  	}
>  
> -	pr_debug("prog '%s': relo #%d: kind <%s> (%d), spec is ", prog_name,
> -		 relo_idx, core_relo_kind_str(relo->kind), relo->kind);
> -	bpf_core_dump_spec(prog_name, LIBBPF_DEBUG, local_spec);
> -	libbpf_print(LIBBPF_DEBUG, "\n");
> +	bpf_core_format_spec(spec_buf, sizeof(spec_buf), local_spec);
> +	pr_debug("prog '%s': relo #%d: %s\n", prog_name, relo_idx, spec_buf);

Looks great, but return value 'len' doesn't seem to be used in this
patch or in the following patch.
What was the intent ?
