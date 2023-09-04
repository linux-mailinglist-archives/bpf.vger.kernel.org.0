Return-Path: <bpf+bounces-9201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422FD791AC1
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 17:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9551C20853
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A23C2D5;
	Mon,  4 Sep 2023 15:40:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA69EC2C0
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 15:40:40 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43D1E5C
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 08:40:38 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c0db66af1bso6266995ad.2
        for <bpf@vger.kernel.org>; Mon, 04 Sep 2023 08:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693842038; x=1694446838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vH+U4g0fGgtTe3Su0HGmCBgxexbKdkNLh2v+gPVUFyo=;
        b=l7cKNWzzIkFAEkj2gaVyFlMa7JZDiqYh6xuOjh7SE/8apMYSTjMo0KUS+QAioAKp4g
         nvGc4NNlJvvUIfmctNrpGiuex3m93RSbXykVaSgGcvExp1j7K9KFXnt2xF38pQAoT1/D
         2BWnndIY54Azbjo6sh+xT7zBDKX8QT6LbRtTt2EZKngLG5OQQmCHAd9003K/83SsF1rh
         8DP5y2kfBEb2iWKLqZXeB+h53H7/oHTfpyqf6MMXtv/vZqCBSHNHlDYEdJ1FwlxqZlNZ
         P3lPx6VB9MIwSWl+DE/LZ+eKW1bjDTjHBTfRWCtiS7xGFDCcbyKZUjKvae+9rjflq6xV
         Ucuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693842038; x=1694446838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vH+U4g0fGgtTe3Su0HGmCBgxexbKdkNLh2v+gPVUFyo=;
        b=ljgeMbhM2JhuhoDYNuXZtbXQCtfD89jOoHhVbimJxe/zzlOfYjI+khvcgNJzkVrEG9
         hLrfX1jGW6es3SK713969yhdmEFEZ7DTZQL2/L0u0mHFyszzozGagkRHIN328hH4sDK+
         h57nsgehiLrod5iUkhCHpQChTYXRwjOq53mpNJ4JsDgyU/MxnGskGosabN1Qvp4l4BQI
         UJd+Oeh8Zm8yHwanfo7t65R3sGBzJ82/D5bLF1NykPjn+AY29MwrEPlsWkFSl+TpnIRl
         2Cezm1JCqv2l4sSkKz13P7EjQz/jfLg2K5Hbblt9WC2+Y9acCbNTsQ7suS7p4yP7cvfw
         NtpA==
X-Gm-Message-State: AOJu0YwCSl+A1PQD3cJNoObAbMRdtZO5P0HKdmFUO0E4Wpxm7aurnnJx
	c2GuvtcwVt9cGv0EdOoakAqVvgmeQwfIMw==
X-Google-Smtp-Source: AGHT+IGdRZAGpYn5rXLO0n00FKVcxTrn3ULk8eyHxpg3+dSml9pn/yMTMY3I/YGctHR6aFCJnZtO3g==
X-Received: by 2002:a17:902:7d97:b0:1c2:702:61af with SMTP id a23-20020a1709027d9700b001c2070261afmr7665184plm.38.1693842038229;
        Mon, 04 Sep 2023 08:40:38 -0700 (PDT)
Received: from ?IPV6:2409:895a:38a8:67b4:64fa:756f:cff2:929a? ([2409:895a:38a8:67b4:64fa:756f:cff2:929a])
        by smtp.gmail.com with ESMTPSA id o9-20020a170902bcc900b001c1f4edfb87sm7697215pls.92.2023.09.04.08.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 08:40:37 -0700 (PDT)
Message-ID: <3b134f87-eb1d-49dc-05b1-e0e8aef227d2@gmail.com>
Date: Mon, 4 Sep 2023 23:40:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next 2/2] libbpf: Support symbol versioning for uprobe
Content-Language: en-US
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
References: <20230904022444.1695820-1-hengqi.chen@gmail.com>
 <20230904022444.1695820-3-hengqi.chen@gmail.com> <ZPXlcwnSuq16+gcc@krava>
From: Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <ZPXlcwnSuq16+gcc@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi, Jiri:

On 9/4/23 22:10, Jiri Olsa wrote:
> On Mon, Sep 04, 2023 at 02:24:44AM +0000, Hengqi Chen wrote:
>> Currently, we allow users to specify symbol name for uprobe in a qualified
>> form, i.e. func@@LIB or func@@LIB_VERSION. For dynamic symbols, their version
>> info is actually stored in .gnu.version and .gnu.version_d sections of the ELF
>> objects. So dynamic symbols and the qualified name won't match. Add support for
>> symbol versioning ([0]) so that we can handle the above case.
>>
>>   [0]: https://refspecs.linuxfoundation.org/LSB_3.0.0/LSB-PDA/LSB-PDA.junk/symversion.html
>>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
>>  tools/lib/bpf/elf.c | 98 +++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 90 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
>> index 5c9e588b17da..ed3d9880eaa4 100644
>> --- a/tools/lib/bpf/elf.c
>> +++ b/tools/lib/bpf/elf.c
>> @@ -9,6 +9,7 @@
>>  #include "str_error.h"
>>
>>  #define STRERR_BUFSIZE  128
>> +#define HIDDEN_BIT	16
> 
> hum, the docs says it's bit 15 ?

Ahh, right, should be 15.

> 
> SNIP
> 
>> @@ -138,12 +155,57 @@ static struct elf_sym *elf_sym_iter_next(struct elf_sym_iter *iter)
>>
>>  		iter->next_sym_idx = idx + 1;
>>  		ret->name = name;
>> +		ret->ver = 0;
>> +		ret->hidden = false;
>> +
>> +		if (iter->versyms) {
>> +			if (!gelf_getversym(iter->versyms, idx, &versym))
>> +				continue;
>> +			ret->ver = versym & ~(1 << HIDDEN_BIT);
>> +			ret->hidden = versym & (1 << HIDDEN_BIT);
>> +		}
>>  		return ret;
>>  	}
>>
>>  	return NULL;
>>  }
>>
>> +static const char *elf_get_vername(Elf *elf, int ver)
>> +{
>> +	GElf_Verdaux verdaux;
>> +	GElf_Verdef verdef;
>> +	Elf_Data *verdefs;
>> +	size_t strtabidx;
>> +	GElf_Shdr sh;
>> +	Elf_Scn *scn;
>> +	int offset;
>> +
>> +	scn = elf_find_next_scn_by_type(elf, SHT_GNU_verdef, NULL);
>> +	if (!scn)
>> +		return NULL;
>> +	if (!gelf_getshdr(scn, &sh))
>> +		return NULL;
>> +	strtabidx = sh.sh_link;
>> +	verdefs =  elf_getdata(scn, 0);
> 
> should we read verdefs same as you did for versyms in elf_sym_iter_new,
> so you don't need to read that every time?
> 

It looks weird to retrieve version from elf_sym_iter, and we should not
reach here too many times.

>> +
>> +	offset = 0;
>> +	while (gelf_getverdef(verdefs, offset, &verdef)) {
>> +		if (verdef.vd_ndx != ver) {
>> +			if (!verdef.vd_next)
>> +				break;
>> +
>> +			offset += verdef.vd_next;
>> +			continue;
>> +		}
>> +
>> +		if (!gelf_getverdaux(verdefs, offset + verdef.vd_aux, &verdaux))
>> +			break;
>> +
>> +		return elf_strptr(elf, strtabidx, verdaux.vda_name);
>> +
>> +	}
>> +	return NULL;
>> +}
>>
>>  /* Transform symbol's virtual address (absolute for binaries and relative
>>   * for shared libs) into file offset, which is what kernel is expecting
>> @@ -191,6 +253,9 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
>>  	for (i = 0; i < ARRAY_SIZE(sh_types); i++) {
>>  		struct elf_sym_iter iter;
>>  		struct elf_sym *sym;
>> +		size_t sname_len;
>> +		char sname[256];
> 
> is this enough? not sure if there's symbol max size,
> maybe we could also use asprintf below
> 

OK, will use asprintf instead.

>> +		const char *ver;
>>  		int last_bind = -1;
>>  		int cur_bind;
>>
>> @@ -201,14 +266,31 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
>>  			goto out;
>>
>>  		while ((sym = elf_sym_iter_next(&iter))) {
>> -			/* User can specify func, func@@LIB or func@@LIB_VERSION. */
>> -			if (strncmp(sym->name, name, name_len) != 0)
>> -				continue;
>> -			/* ...but we don't want a search for "foo" to match 'foo2" also, so any
>> -			 * additional characters in sname should be of the form "@@LIB".
>> -			 */
>> -			if (!is_name_qualified && sym->name[name_len] != '\0' && sym->name[name_len] != '@')
>> -				continue;
>> +			if (sh_types[i] == SHT_DYNSYM && is_name_qualified) {
>> +				if (sym->hidden)
>> +					continue;
>> +
>> +				sname_len = strlen(sym->name);
>> +				if (strncmp(sym->name, name, sname_len) != 0)
>> +					continue;
>> +
>> +				ver = elf_get_vername(elf, sym->ver);
>> +				if (!ver)
>> +					continue;
>> +
>> +				snprintf(sname, sizeof(sname), "%s@@%s", sym->name, ver);
>> +				if (strncmp(sname, name, name_len) != 0)
>> +					continue;
>> +			} else {
>> +				/* User can specify func, func@@LIB or func@@LIB_VERSION. */
>> +				if (strncmp(sym->name, name, name_len) != 0)
>> +					continue;
>> +				/* ...but we don't want a search for "foo" to match 'foo2" also, so any
>> +				* additional characters in sname should be of the form "@@LIB".
>> +				*/
>> +				if (!is_name_qualified && sym->name[name_len] != '\0' && sym->name[name_len] != '@')
>> +					continue;
> 
> hum, I never checked the versioned symbols, but it looks like we
> don't get symbols in 'symbol@version' form, so I wonder how that
> worked before
> 
> would be great to have a selftest for that
> 
> also I had to add change below to test that through prog's section,
> I think we need allow '@' in there
> 

Let me try.

> thanks,
> jirka
> 
> 
> ---
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 96ff1aa4bf6a..a30f3c48f891 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11512,8 +11512,11 @@ static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf
>  
>  	*link = NULL;
>  
> -	n = sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.]+%li",
> +	n = sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.@]+%li",
>  		   &probe_type, &binary_path, &func_name, &offset);

---
Hengqi

