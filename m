Return-Path: <bpf+bounces-5928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487607633FE
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 12:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03439281D64
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 10:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543DFCA4F;
	Wed, 26 Jul 2023 10:39:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DBECA41
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 10:39:42 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF77D1BCB
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 03:39:40 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5221cf2bb8cso6332159a12.1
        for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 03:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690367979; x=1690972779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cMnx0XOprVxm6n8vIDKg9EIs0e3WJDlXeg/0dOSQZgI=;
        b=B46CTEnxzVtroX+zo8Tmiwgy1iRzr4YFC/4Nuafb90Q04ArY40a1ICLPGDFe1gJL7p
         I46Hf7haR0gYvPB29tNkXl4AOiKGWR9ih+7jYfKkYoxLJtJoI+B1xM82t+crTIMDE51b
         jmqsvyJreCCZ5OIW5fonqNhr8qeWsDq3aNyDHl6X2Axl9JeSseIq4CUMMxNLWZ99V2fn
         jVCapKQRvNDQF8GTHmPn3Z3tbppTNEHzgCVXfV8g2VXNHwca2MpQtvVHIztyYt5jp0aM
         4GSEnfuEYv3CLgDJUH4fqXvVD7X7KH3D8Lgmx9v6SAbP2abHskXASQRY/+WLwo+j0DEv
         tX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690367979; x=1690972779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMnx0XOprVxm6n8vIDKg9EIs0e3WJDlXeg/0dOSQZgI=;
        b=XEyYmZQQYbdxkcmHRjFx2UwkKvtqQPt9gxijUULeZgvWOLMXF1QGpQ0IkwEKxVEYDF
         XxQczOVUWf5ZcZLr2yOmypO87vhEQRo/0YHpweUNVC7ecttsZ1ffRHUcBW4aNKiEAJmz
         Hn3i9wnmYilnAuKIPnoNBuCjGML9qE/hIbmFeiJ/nIaa7jtnNjXroek7IG1Xx25d4+Y8
         uJOJIVYIyneR3cM7zsEdbOB8Se7GzAjJsq5Jad5lHqg7YXbmW9TceURiVo2eOW2RsY0o
         15vUJAMLvDctD6tdrqVMoLkyFDSh5d37ZsOn0QCVbROja30qQ+G8MWJ6RSpBhTjBiGky
         Uarg==
X-Gm-Message-State: ABy/qLY2rWLqMmbm9OW6fniZ33sFf2RjQ9sov+ZojHBA1LprLTOLVGbq
	QAJU3zoDMKnsrzTun2yDO68=
X-Google-Smtp-Source: APBJJlH3m4JTTgQmsEK53aMNvWcuOr4Z6mao+cnqLg3+h32TJaVL+/+sh+n++dprylVnBJA973Ning==
X-Received: by 2002:a17:906:749b:b0:994:3207:cddd with SMTP id e27-20020a170906749b00b009943207cdddmr1467355ejl.34.1690367978946;
        Wed, 26 Jul 2023 03:39:38 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id qp7-20020a170907206700b00992b66e54e9sm9407750ejb.214.2023.07.26.03.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 03:39:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 26 Jul 2023 12:39:35 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, andrii.nakryiko@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, mykolal@fb.com,
	bpf@vger.kernel.org
Subject: Re: [RFC dwarves 1/2] dwarves: auto-detect maximum kind supported by
 vmlinux
Message-ID: <ZMD35ydVT69zDipR@krava>
References: <20230720201443.224040-1-alan.maguire@oracle.com>
 <20230720201443.224040-2-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720201443.224040-2-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 09:14:42PM +0100, Alan Maguire wrote:
> When a newer pahole is run on an older kernel, it often knows about BTF
> kinds that the kernel does not support.  This is a problem because the BTF
> generated is then embedded in the kernel image and read, and if unknown
> kinds are found, BTF handling fails and core BPF functionality is
> unavailable.
> 
> The scripts/pahole-flags.sh script enumerates the various pahole options
> available associated with various versions of pahole, but the problem is
> what matters in the case of an older kernel is the set of kinds the kernel
> understands.  Because recent features such as BTF_KIND_ENUM64 are added
> by default (and only skipped if --skip_encoding_btf_* is set), BTF will
> be created with these newer kinds that the older kernel cannot read.
> This can be fixed by stable-backporting --skip options, but this is
> cumbersome and would have to be done every time a new BTF kind is
> introduced.
> 
> Here instead we pre-process the DWARF information associated with the
> target for BTF generation; if we find an enum with a BTF_KIND_MAX
> value in the DWARF associated with the object, we use that to
> determine the maximum BTF kind supported.  Note that the enum
> representation of BTF kinds starts for the 5.16 kernel; prior to this
> The benefit of auto-detection is that no work is required for older
> kernels when new kinds are added, and --skip_encoding options are
> less needed.
> 
> [1] https://github.com/oracle-samples/bpftune/issues/35
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  btf_encoder.c  | 12 ++++++++++++
>  dwarf_loader.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  dwarves.h      |  2 ++
>  3 files changed, 66 insertions(+)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 65f6e71..98c7529 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1889,3 +1889,15 @@ struct btf *btf_encoder__btf(struct btf_encoder *encoder)
>  {
>  	return encoder->btf;
>  }
> +
> +void dwarves__set_btf_kind_max(struct conf_load *conf_load, int btf_kind_max)
> +{
> +	if (btf_kind_max < 0 || btf_kind_max >= BTF_KIND_MAX)
> +		return;
> +	if (btf_kind_max < BTF_KIND_DECL_TAG)
> +		conf_load->skip_encoding_btf_decl_tag = true;
> +	if (btf_kind_max < BTF_KIND_TYPE_TAG)
> +		conf_load->skip_encoding_btf_type_tag = true;
> +	if (btf_kind_max < BTF_KIND_ENUM64)
> +		conf_load->skip_encoding_btf_enum64 = true;
> +}

hi,
so there are some older kernels other than stable that would use this feature
right? because stable already have proper setup for pahole options

or it's just there to be complete and we'd eventually add new rules in here?
wouldn't that be covered by the BTF kind layout stuff you work on? is there
some overlap?

> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index ccf3194..8984043 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -3358,8 +3358,60 @@ static int __dwarf_cus__process_cus(struct dwarf_cus *dcus)
>  	return 0;
>  }
>  
> +/* Find enumeration value for BTF_KIND_MAX; replace conf_load->btf_kind_max with
> + * this value if found since it indicates that the target object does not know
> + * about kinds > its BTF_KIND_MAX value.  This is valuable for kernel/module
> + * BTF where a newer pahole/libbpf operate on an older kernel which cannot
> + * parse some of the newer kinds pahole can generate.
> + */
> +static void dwarf__find_btf_kind_max(struct dwarf_cus *dcus)
> +{
> +	struct conf_load *conf = dcus->conf;
> +	uint8_t pointer_size, offset_size;
> +	Dwarf_Off off = 0, noff;
> +	size_t cuhl;
> +
> +	while (dwarf_nextcu(dcus->dw, off, &noff, &cuhl, NULL, &pointer_size, &offset_size) == 0) {
> +		Dwarf_Die die_mem;
> +		Dwarf_Die *cu_die = dwarf_offdie(dcus->dw, off + cuhl, &die_mem);
> +		Dwarf_Die child;
> +
> +		if (cu_die == NULL)
> +			break;
> +		if (dwarf_child(cu_die, &child) == 0) {
> +			Dwarf_Die *die = &child;
> +
> +			do {
> +				Dwarf_Die echild, *edie;
> +
> +				if (dwarf_tag(die) != DW_TAG_enumeration_type ||
> +				    !dwarf_haschildren(die) ||
> +				    dwarf_child(die, &echild) != 0)
> +					continue;
> +				edie = &echild;
> +				do {
> +					const char *ename;
> +					int btf_kind_max;
> +
> +					if (dwarf_tag(edie) != DW_TAG_enumerator)
> +						continue;
> +					ename = attr_string(edie, DW_AT_name, conf);
> +					if (!ename || strcmp(ename, "BTF_KIND_MAX") != 0)
> +						continue;
> +					btf_kind_max = attr_numeric(edie, DW_AT_const_value);
> +					dwarves__set_btf_kind_max(conf, btf_kind_max);
> +					return;
> +				} while (dwarf_siblingof(edie, edie) == 0);
> +			} while (dwarf_siblingof(die, die) == 0);
> +		}
> +		off = noff;
> +	}
> +}
> +
>  static int dwarf_cus__process_cus(struct dwarf_cus *dcus)
>  {
> +	dwarf__find_btf_kind_max(dcus);

first I though this should be enabled by some (detect) option.. but that
would probably beat the main purpose.. also I think we don't need kernel
with BTF that it can't process

jirka

> +
>  	if (dcus->conf->nr_jobs > 1)
>  		return dwarf_cus__threaded_process_cus(dcus);
>  
> diff --git a/dwarves.h b/dwarves.h
> index eb1a6df..f4d9347 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -1480,4 +1480,6 @@ extern const char tabs[];
>  #define DW_TAG_skeleton_unit 0x4a
>  #endif
>  
> +void dwarves__set_btf_kind_max(struct conf_load *conf_load, int btf_kind_max);
> +
>  #endif /* _DWARVES_H_ */
> -- 
> 2.39.3
> 

