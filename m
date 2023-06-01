Return-Path: <bpf+bounces-1561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CB7719181
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 05:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5C728167D
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 03:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC92A5C8B;
	Thu,  1 Jun 2023 03:54:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66491FA9
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 03:54:05 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524A493
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 20:53:59 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1a26f26ebb8so337813fac.2
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 20:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685591638; x=1688183638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4gFW+99q2VsW0L4qxwUOeOd4L2CjaoPuEDRzLVfheE=;
        b=lgsrJSw1gUe7hbUS/chGksT2uc5KeVTnTC2MKCqz0MAyKo0TpgzhR93qtp/fwikhPH
         cRZijWzjIylU8EhyyIQQJcAOQFE+8gfSvgwfD5qHef/K+1oxp56EYiGaNwENVdfF2ZBp
         jNogAHUrXI6N6IYU7I9KDP53O8Q5gVJtyxsaI0YB+7J2vOexjw/z7ER4Fl9seQlNZhhX
         +cgctwnySEl7Dv4zPtt8qlbHGntvo+L//r7k6jqmwsWdkTDMqJ08HZkQzS9Qyxom/FCw
         m2fzS4v5eE1dIoyP3fs5dLfFeoE8nPx8EKL3XnR55d7IquBfMcPhoXSss8CmUs41Byka
         PC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685591638; x=1688183638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4gFW+99q2VsW0L4qxwUOeOd4L2CjaoPuEDRzLVfheE=;
        b=G3IneIOABB6SRhLKCjcNDVZVq+IDlTs6LMj5hivBOYSBicl4Mj4b3gaJ+xXdXyxF9A
         ZeizrkkSg98E7SGbKcdOM4Asi22l4QDxwV8vSRaSPwOgibJlNKIAtThUOMQq1lmFtsKg
         FT+5Afwv9Ne2LAKYYbqCeDxazzh/9qSUsGzn9IdHAxunla0yKo1DFqYcimPF3Abg/Rta
         eaXozWlM4o30WihrmRUzB3u3b/baRL746LjzOUWGzMzYlM+zWMGiHpvmg3UBW3m2Y+Cp
         6kyl1oa9vqfC7wLjuis/84VPbY0YDsSE7vFx8/sJ293y1P9yo0PXTIdCKf9GMXEnPJoo
         R9Yw==
X-Gm-Message-State: AC+VfDzIqlsiMeTYMDiRHLaITVhqfzqTUfFdozvnIwPVN1aICnMTir0y
	+vQokPXVOtpyVbp5pWYB/Yk=
X-Google-Smtp-Source: ACHHUZ7fq2HObZzQ3NvZfcr7EBeKO3JYT8QtfpHWDnoavRZfm0eVLv/sSPbQxVD4+3UVvhGhpTQC+w==
X-Received: by 2002:a05:6870:8c15:b0:187:9dfd:87cf with SMTP id ec21-20020a0568708c1500b001879dfd87cfmr4785008oab.37.1685591638450;
        Wed, 31 May 2023 20:53:58 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:a01a])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b001af98dcf958sm2151436plr.288.2023.05.31.20.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 20:53:57 -0700 (PDT)
Date: Wed, 31 May 2023 20:53:54 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	acme@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
	mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [RFC bpf-next 1/8] btf: add kind metadata encoding to UAPI
Message-ID: <20230601035354.5u56fwuundu6m7v2@MacBook-Pro-8.local>
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
 <20230531201936.1992188-2-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531201936.1992188-2-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 31, 2023 at 09:19:28PM +0100, Alan Maguire wrote:
> BTF kind metadata provides information to parse BTF kinds.
> By separating parsing BTF from using all the information
> it provides, we allow BTF to encode new features even if
> they cannot be used.  This is helpful in particular for
> cases where newer tools for BTF generation run on an
> older kernel; BTF kinds may be present that the kernel
> cannot yet use, but at least it can parse the BTF
> provided.  Meanwhile userspace tools with newer libbpf
> may be able to use the newer information.
> 
> The intent is to support encoding of kind metadata
> optionally so that tools like pahole can add this
> information.  So for each kind we record
> 
> - a kind name string
> - kind-related flags
> - length of singular element following struct btf_type
> - length of each of the btf_vlen() elements following
> 
> In addition we make space in the metadata for
> CRC32s computed over the BTF along with a CRC for
> the base BTF; this allows split BTF to identify
> a mismatch explicitly.  Finally we provide an
> offset for an optional description string.
> 
> The ideas here were discussed at [1] hence
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> 
> [1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/
> ---
>  include/uapi/linux/btf.h       | 29 +++++++++++++++++++++++++++++
>  tools/include/uapi/linux/btf.h | 29 +++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index ec1798b6d3ff..94c1f4518249 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h
> @@ -8,6 +8,34 @@
>  #define BTF_MAGIC	0xeB9F
>  #define BTF_VERSION	1
>  
> +/* is this information required? If so it cannot be sanitized safely. */
> +#define BTF_KIND_META_OPTIONAL		(1 << 0)
> +
> +struct btf_kind_meta {
> +	__u32 name_off;		/* kind name string offset */
> +	__u16 flags;		/* see BTF_KIND_META_* values above */
> +	__u8 info_sz;		/* size of singular element after btf_type */
> +	__u8 elem_sz;		/* size of each of btf_vlen(t) elements */
> +};
> +
> +/* for CRCs for BTF, base BTF to be considered usable, flags must be set. */
> +#define BTF_META_CRC_SET		(1 << 0)
> +#define BTF_META_BASE_CRC_SET		(1 << 1)
> +
> +struct btf_metadata {
> +	__u8	kind_meta_cnt;		/* number of struct btf_kind_meta */
> +	__u32	flags;
> +	__u32	description_off;	/* optional description string */
> +	__u32	crc;			/* crc32 of BTF */
> +	__u32	base_crc;		/* crc32 of base BTF */
> +	struct btf_kind_meta kind_meta[];
> +};
> +
> +struct btf_meta_header {
> +	__u32	meta_off;	/* offset of metadata section */
> +	__u32	meta_len;	/* length of metadata section */
> +};
> +
>  struct btf_header {
>  	__u16	magic;
>  	__u8	version;
> @@ -19,6 +47,7 @@ struct btf_header {
>  	__u32	type_len;	/* length of type section	*/
>  	__u32	str_off;	/* offset of string section	*/
>  	__u32	str_len;	/* length of string section	*/
> +	struct btf_meta_header meta_header;
>  };
>  
>  /* Max # of type identifier */
> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
> index ec1798b6d3ff..94c1f4518249 100644
> --- a/tools/include/uapi/linux/btf.h
> +++ b/tools/include/uapi/linux/btf.h
> @@ -8,6 +8,34 @@
>  #define BTF_MAGIC	0xeB9F
>  #define BTF_VERSION	1
>  
> +/* is this information required? If so it cannot be sanitized safely. */
> +#define BTF_KIND_META_OPTIONAL		(1 << 0)
> +
> +struct btf_kind_meta {
> +	__u32 name_off;		/* kind name string offset */
> +	__u16 flags;		/* see BTF_KIND_META_* values above */
> +	__u8 info_sz;		/* size of singular element after btf_type */
> +	__u8 elem_sz;		/* size of each of btf_vlen(t) elements */
> +};
> +
> +/* for CRCs for BTF, base BTF to be considered usable, flags must be set. */
> +#define BTF_META_CRC_SET		(1 << 0)
> +#define BTF_META_BASE_CRC_SET		(1 << 1)
> +
> +struct btf_metadata {
> +	__u8	kind_meta_cnt;		/* number of struct btf_kind_meta */

Overall, looks great.
Few small nits:
I'd make kind_meta_cnt u32, since padding we won't be able to reuse anyway
and would bump the BTF_VERSION to 2 to make it a 'milestone'.
v2 -> self described.

> +	__u32	flags;
> +	__u32	description_off;	/* optional description string */
> +	__u32	crc;			/* crc32 of BTF */
> +	__u32	base_crc;		/* crc32 of base BTF */

Hard coded CRC also gives me a pause.
Should it be an optional KIND like btf tags?

