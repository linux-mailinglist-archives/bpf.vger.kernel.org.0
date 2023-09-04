Return-Path: <bpf+bounces-9190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91949791974
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 16:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4DE280F5B
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 14:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCD1C127;
	Mon,  4 Sep 2023 14:11:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4140BA42
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 14:11:06 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418A4C6
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 07:11:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a63b2793ecso222725666b.2
        for <bpf@vger.kernel.org>; Mon, 04 Sep 2023 07:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693836663; x=1694441463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8T+DkNRhbz5ujxLNiABL5VjgOAd0y62AxHcSxLVPYss=;
        b=eOTIWO6bU91xYkBSL/WEbqiXkzpHhLq2QTj7jIsWwEiBxXD97INeJxkIaKTr0QnTuN
         1Qt0ZLakMy4ER9ADhhgEdLzAF+Sz16daugs8gjqjo2+IJFpqgdTkwudXpPp93WrlK+p6
         69H/wZzUpT7JMfOoOC5g5TmT9XJnlZtmL8vDxigz8kSqJ3W4JumyyWo6nB10eog1M+H2
         H0a+KRJofUdC1MKWmb7472/7MjAgIuFkVqlo6uxBI1UeOXCbdi/7YnMPH6AfWrEGjSTk
         VQBabYE6GXwpEKhB9bsdLYyVmyk2/s1HtpbecQzqVOOUW5e1j5Z3InSxZdsPwHuxFfC0
         ZATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693836663; x=1694441463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8T+DkNRhbz5ujxLNiABL5VjgOAd0y62AxHcSxLVPYss=;
        b=ltr0v9dWNcDwTKK/RUXgCd4MzU81V2KpFtZdk52I9U0idmw7I8nRk3b+KQcRGP7j87
         +bOGgFD4t7U4Ypw86ofG9aDpcZmvyi1v9QRQrSoMQRhq2dcm6zMouYEj7qAsE4DKLDva
         g7sh+jnKyHM1cBMbx2Q6M+6SrTlLddc6/saFzoEgBnLdC1PETtzGcYQ0GY2Edf1Yq+js
         9CAJcZShdrfK3T/8a4DGqog0zbt43pHveZ8McbewXzRlqhjq3LCtud0KRMWdPdLdVHFB
         iaB/Ur8W0huu1KZleSOFiJynQHOMbCpM3KyeCfkqvKSquv7rYV2niCY9LPFo52bMWOtz
         kG1Q==
X-Gm-Message-State: AOJu0Yy4NzvbSf/DeMz392Rxjyn1bfAqHsqN91BA6YdX6mESXn3B7GEO
	7G7RMYZ18K5DXhcK11aAyeLEKAKH/fg=
X-Google-Smtp-Source: AGHT+IFQO71PPMYaLXfwnda/1cBumH3C4KRu7xjhzBzXWVn9A0dNZNi1lV/giwOygJ43TPwfLbVhOw==
X-Received: by 2002:a17:906:20dd:b0:9a1:eef2:a110 with SMTP id c29-20020a17090620dd00b009a1eef2a110mr7954657ejc.19.1693836662359;
        Mon, 04 Sep 2023 07:11:02 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id c11-20020a170906924b00b009929ab17be0sm6194164ejx.162.2023.09.04.07.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 07:11:02 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 4 Sep 2023 16:10:59 +0200
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org
Subject: Re: [PATCH bpf-next 2/2] libbpf: Support symbol versioning for uprobe
Message-ID: <ZPXlcwnSuq16+gcc@krava>
References: <20230904022444.1695820-1-hengqi.chen@gmail.com>
 <20230904022444.1695820-3-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904022444.1695820-3-hengqi.chen@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 04, 2023 at 02:24:44AM +0000, Hengqi Chen wrote:
> Currently, we allow users to specify symbol name for uprobe in a qualified
> form, i.e. func@@LIB or func@@LIB_VERSION. For dynamic symbols, their version
> info is actually stored in .gnu.version and .gnu.version_d sections of the ELF
> objects. So dynamic symbols and the qualified name won't match. Add support for
> symbol versioning ([0]) so that we can handle the above case.
> 
>   [0]: https://refspecs.linuxfoundation.org/LSB_3.0.0/LSB-PDA/LSB-PDA.junk/symversion.html
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/lib/bpf/elf.c | 98 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 90 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> index 5c9e588b17da..ed3d9880eaa4 100644
> --- a/tools/lib/bpf/elf.c
> +++ b/tools/lib/bpf/elf.c
> @@ -9,6 +9,7 @@
>  #include "str_error.h"
> 
>  #define STRERR_BUFSIZE  128
> +#define HIDDEN_BIT	16

hum, the docs says it's bit 15 ?

SNIP

> @@ -138,12 +155,57 @@ static struct elf_sym *elf_sym_iter_next(struct elf_sym_iter *iter)
> 
>  		iter->next_sym_idx = idx + 1;
>  		ret->name = name;
> +		ret->ver = 0;
> +		ret->hidden = false;
> +
> +		if (iter->versyms) {
> +			if (!gelf_getversym(iter->versyms, idx, &versym))
> +				continue;
> +			ret->ver = versym & ~(1 << HIDDEN_BIT);
> +			ret->hidden = versym & (1 << HIDDEN_BIT);
> +		}
>  		return ret;
>  	}
> 
>  	return NULL;
>  }
> 
> +static const char *elf_get_vername(Elf *elf, int ver)
> +{
> +	GElf_Verdaux verdaux;
> +	GElf_Verdef verdef;
> +	Elf_Data *verdefs;
> +	size_t strtabidx;
> +	GElf_Shdr sh;
> +	Elf_Scn *scn;
> +	int offset;
> +
> +	scn = elf_find_next_scn_by_type(elf, SHT_GNU_verdef, NULL);
> +	if (!scn)
> +		return NULL;
> +	if (!gelf_getshdr(scn, &sh))
> +		return NULL;
> +	strtabidx = sh.sh_link;
> +	verdefs =  elf_getdata(scn, 0);

should we read verdefs same as you did for versyms in elf_sym_iter_new,
so you don't need to read that every time?

> +
> +	offset = 0;
> +	while (gelf_getverdef(verdefs, offset, &verdef)) {
> +		if (verdef.vd_ndx != ver) {
> +			if (!verdef.vd_next)
> +				break;
> +
> +			offset += verdef.vd_next;
> +			continue;
> +		}
> +
> +		if (!gelf_getverdaux(verdefs, offset + verdef.vd_aux, &verdaux))
> +			break;
> +
> +		return elf_strptr(elf, strtabidx, verdaux.vda_name);
> +
> +	}
> +	return NULL;
> +}
> 
>  /* Transform symbol's virtual address (absolute for binaries and relative
>   * for shared libs) into file offset, which is what kernel is expecting
> @@ -191,6 +253,9 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
>  	for (i = 0; i < ARRAY_SIZE(sh_types); i++) {
>  		struct elf_sym_iter iter;
>  		struct elf_sym *sym;
> +		size_t sname_len;
> +		char sname[256];

is this enough? not sure if there's symbol max size,
maybe we could also use asprintf below

> +		const char *ver;
>  		int last_bind = -1;
>  		int cur_bind;
> 
> @@ -201,14 +266,31 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
>  			goto out;
> 
>  		while ((sym = elf_sym_iter_next(&iter))) {
> -			/* User can specify func, func@@LIB or func@@LIB_VERSION. */
> -			if (strncmp(sym->name, name, name_len) != 0)
> -				continue;
> -			/* ...but we don't want a search for "foo" to match 'foo2" also, so any
> -			 * additional characters in sname should be of the form "@@LIB".
> -			 */
> -			if (!is_name_qualified && sym->name[name_len] != '\0' && sym->name[name_len] != '@')
> -				continue;
> +			if (sh_types[i] == SHT_DYNSYM && is_name_qualified) {
> +				if (sym->hidden)
> +					continue;
> +
> +				sname_len = strlen(sym->name);
> +				if (strncmp(sym->name, name, sname_len) != 0)
> +					continue;
> +
> +				ver = elf_get_vername(elf, sym->ver);
> +				if (!ver)
> +					continue;
> +
> +				snprintf(sname, sizeof(sname), "%s@@%s", sym->name, ver);
> +				if (strncmp(sname, name, name_len) != 0)
> +					continue;
> +			} else {
> +				/* User can specify func, func@@LIB or func@@LIB_VERSION. */
> +				if (strncmp(sym->name, name, name_len) != 0)
> +					continue;
> +				/* ...but we don't want a search for "foo" to match 'foo2" also, so any
> +				* additional characters in sname should be of the form "@@LIB".
> +				*/
> +				if (!is_name_qualified && sym->name[name_len] != '\0' && sym->name[name_len] != '@')
> +					continue;

hum, I never checked the versioned symbols, but it looks like we
don't get symbols in 'symbol@version' form, so I wonder how that
worked before

would be great to have a selftest for that

also I had to add change below to test that through prog's section,
I think we need allow '@' in there

thanks,
jirka


---
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 96ff1aa4bf6a..a30f3c48f891 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11512,8 +11512,11 @@ static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf
 
 	*link = NULL;
 
-	n = sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.]+%li",
+	n = sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.@]+%li",
 		   &probe_type, &binary_path, &func_name, &offset);

