Return-Path: <bpf+bounces-1809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97529722415
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 13:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F126B1C209BF
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 11:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECF6168B7;
	Mon,  5 Jun 2023 11:01:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835EC443A
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 11:01:29 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9B5EA
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 04:01:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f739ec88b2so9678435e9.1
        for <bpf@vger.kernel.org>; Mon, 05 Jun 2023 04:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685962886; x=1688554886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uGPWYQW06NY0REwEkliOWEXlF5uNiuR5wR6i5XDg5kg=;
        b=p0U6ynq+BI8K6sk+wCOzsKtEuu76ygD3giZ/1iERUhy7QUIEdvFUPEybyo8L6cyqFX
         u6XvCuJmcaIqnwHXQD4y8OxobKXFwwVeuz2fvQuiNNL6FWl6UyLF9DcNMSkBsX0QtCMM
         Lr0VXiCLFoJ8vZCuVXlfEnye8dlnCCpMFdkEJ5WqAXqKVblU4Q4v9zfQNPODkw//V42v
         WL0tlsclhilSHlZeifFYqB1jFqsnf7j9NPmDYliTRvtlp0mdwSqDAOX9OW6BvdnpDJQc
         GIJM0ZmHsIhHPxwLaVbs1emIjISzjEt1TGmXz5FdtygIKU4wmsjOtHB5DfKR4gknnXmH
         emSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685962886; x=1688554886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGPWYQW06NY0REwEkliOWEXlF5uNiuR5wR6i5XDg5kg=;
        b=IlDCCd39zeJx4iMQJUpTNY3SdCXli5f290SaO+Uavv6NwNhzmFpb+FJwxpBDQT3wr4
         N56db0Te6kj8a7WXkAy3rA0aG/J8CGLwl0b34ZFRC9K54LQYJGJ0Bo7WNeP+P+aZQjlZ
         CGNY8EMKcdfHoz5CzDBrEJEzmDtRpfv5KQrKEHPRsmlxCKbVWUFtKXMJXYqv8ToFBWw9
         soNblq4AJdHrILe71aqFZ7UzwSDUFRrjzcoSQRcWKsz2M1fZvFRStUJdj0ySiXtiObx9
         Eao8/RhulEesGbzaUAyMZ5WnRU+8PWwJwUaeIN1YqykXTd8sTA/zI8bscSYHMyI/gUSL
         2Fjg==
X-Gm-Message-State: AC+VfDzJQkwi/yRbgIRvIdMTkT5Z9Sd1H3dHLsHBjZ1YESwgMa2Mspga
	+RVIuXoriEUF3ElOa2Rwuns=
X-Google-Smtp-Source: ACHHUZ6cnUVA8ZrDpqU3/l4wq0d/nSB+nQSdeMBmcApNrA4aIaVhzyV97bPlJ899HFR27L/OMqp9Og==
X-Received: by 2002:a05:600c:2185:b0:3f6:444:b344 with SMTP id e5-20020a05600c218500b003f60444b344mr5899248wme.34.1685962885397;
        Mon, 05 Jun 2023 04:01:25 -0700 (PDT)
Received: from krava ([2a00:102a:4002:d0bd:b404:82f8:eedb:87ed])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c290a00b003f7e34c5219sm2340218wmd.42.2023.06.05.04.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 04:01:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 5 Jun 2023 13:01:21 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	acme@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, quentin@isovalent.com, mykolal@fb.com,
	bpf@vger.kernel.org
Subject: Re: [RFC bpf-next 2/8] libbpf: support handling of metadata section
 in BTF
Message-ID: <ZH3AgcYeJPPxWJu3@krava>
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
 <20230531201936.1992188-3-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531201936.1992188-3-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 31, 2023 at 09:19:29PM +0100, Alan Maguire wrote:
> support reading in metadata, fixing endian issues on reading;
> also support writing metadata section to raw BTF object.
> There is not yet an API to populate the metadata with meaningful
> information.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 141 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 111 insertions(+), 30 deletions(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 8484b563b53d..036dc1505969 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -16,6 +16,7 @@
>  #include <linux/err.h>
>  #include <linux/btf.h>
>  #include <gelf.h>
> +#include <zlib.h>
>  #include "btf.h"
>  #include "bpf.h"
>  #include "libbpf.h"
> @@ -39,36 +40,40 @@ struct btf {
>  
>  	/*
>  	 * When BTF is loaded from an ELF or raw memory it is stored
> -	 * in a contiguous memory block. The hdr, type_data, and, strs_data
> -	 * point inside that memory region to their respective parts of BTF
> -	 * representation:
> +	 * in a contiguous memory block. The hdr, type_data, strs_data,
> +	 * and optional meta_data point inside that memory region to their
> +	 * respective parts of BTF representation:
>  	 *
> -	 * +--------------------------------+
> -	 * |  Header  |  Types  |  Strings  |
> -	 * +--------------------------------+
> -	 * ^          ^         ^
> -	 * |          |         |
> -	 * hdr        |         |
> -	 * types_data-+         |
> -	 * strs_data------------+
> +	 * +--------------------------------+----------+
> +	 * |  Header  |  Types  |  Strings  | Metadata |
> +	 * +--------------------------------+----------+
> +	 * ^          ^         ^           ^
> +	 * |          |         |           |
> +	 * hdr        |         |           |
> +	 * types_data-+         |           |
> +	 * strs_data------------+           |
> +	 * meta_data------------------------+
> +	 *
> +	 * meta_data is optional.
>  	 *
>  	 * If BTF data is later modified, e.g., due to types added or
>  	 * removed, BTF deduplication performed, etc, this contiguous
> -	 * representation is broken up into three independently allocated
> -	 * memory regions to be able to modify them independently.
> +	 * representation is broken up into three or four independently
> +	 * allocated memory regions to be able to modify them independently.
>  	 * raw_data is nulled out at that point, but can be later allocated
>  	 * and cached again if user calls btf__raw_data(), at which point
> -	 * raw_data will contain a contiguous copy of header, types, and
> -	 * strings:
> +	 * raw_data will contain a contiguous copy of header, types, strings
> +	 * and (again optionally) metadata:
>  	 *
> -	 * +----------+  +---------+  +-----------+
> -	 * |  Header  |  |  Types  |  |  Strings  |
> -	 * +----------+  +---------+  +-----------+
> -	 * ^             ^            ^
> -	 * |             |            |
> -	 * hdr           |            |
> -	 * types_data----+            |
> -	 * strset__data(strs_set)-----+
> +	 * +----------+  +---------+  +-----------+  +----------+
> +	 * |  Header  |  |  Types  |  |  Strings  |  | Metadata |
> +	 * +----------+  +---------+  +-----------+  +---------_+
> +	 * ^             ^            ^              ^
> +	 * |             |            |              |
> +	 * hdr           |            |              |
> +	 * types_data----+            |              |
> +	 * strset__data(strs_set)-----+              |
> +	 * meta_data---------------------------------+
>  	 *
>  	 *               +----------+---------+-----------+
>  	 *               |  Header  |  Types  |  Strings  |
> @@ -116,6 +121,8 @@ struct btf {
>  	/* whether strings are already deduplicated */
>  	bool strs_deduped;
>  
> +	void *meta_data;
> +
>  	/* BTF object FD, if loaded into kernel */
>  	int fd;
>  
> @@ -215,6 +222,11 @@ static void btf_bswap_hdr(struct btf_header *h)
>  	h->type_len = bswap_32(h->type_len);
>  	h->str_off = bswap_32(h->str_off);
>  	h->str_len = bswap_32(h->str_len);
> +	if (h->hdr_len >= sizeof(struct btf_header)) {
> +		h->meta_header.meta_off = bswap_32(h->meta_header.meta_off);
> +		h->meta_header.meta_len = bswap_32(h->meta_header.meta_len);
> +	}
> +
>  }
>  
>  static int btf_parse_hdr(struct btf *btf)
> @@ -222,14 +234,17 @@ static int btf_parse_hdr(struct btf *btf)
>  	struct btf_header *hdr = btf->hdr;
>  	__u32 meta_left;
>  
> -	if (btf->raw_size < sizeof(struct btf_header)) {
> +	if (btf->raw_size < sizeof(struct btf_header) - sizeof(struct btf_meta_header)) {
>  		pr_debug("BTF header not found\n");
>  		return -EINVAL;
>  	}
>  
>  	if (hdr->magic == bswap_16(BTF_MAGIC)) {
> +		int swapped_len = bswap_32(hdr->hdr_len);
> +
>  		btf->swapped_endian = true;
> -		if (bswap_32(hdr->hdr_len) != sizeof(struct btf_header)) {
> +		if (swapped_len != sizeof(struct btf_header) &&
> +		    swapped_len != sizeof(struct btf_header) - sizeof(struct btf_meta_header)) {
>  			pr_warn("Can't load BTF with non-native endianness due to unsupported header length %u\n",
>  				bswap_32(hdr->hdr_len));
>  			return -ENOTSUP;
> @@ -285,6 +300,42 @@ static int btf_parse_str_sec(struct btf *btf)
>  	return 0;
>  }
>  
> +static void btf_bswap_meta(struct btf_metadata *meta, int len)
> +{
> +	struct btf_kind_meta *m = &meta->kind_meta[0];
> +	struct btf_kind_meta *end = (void *)meta + len;
> +
> +	meta->flags = bswap_32(meta->flags);
> +	meta->crc = bswap_32(meta->crc);
> +	meta->base_crc = bswap_32(meta->base_crc);
> +	meta->description_off = bswap_32(meta->description_off);
> +
> +	while (m < end) {
> +		m->name_off = bswap_32(m->name_off);
> +		m->flags = bswap_16(m->flags);
> +		m++;
> +	}
> +}
> +
> +static int btf_parse_meta_sec(struct btf *btf)
> +{
> +	const struct btf_header *hdr = btf->hdr;
> +
> +	if (hdr->hdr_len < sizeof(struct btf_header) ||
> +	    !hdr->meta_header.meta_off || !hdr->meta_header.meta_len)
> +		return 0;

I'm trying to figure out how is the meta data optional, and it seems to be
in here, right? but hdr->meta_header.meta_off or hdr->meta_header.meta_len
must be set NULL or zero

I'm getting crash when running btf test and it seems like correption when
parsing BTF generated from clang, which does not have this meta support

we do need clang support for this right? or bump version?

thanks,
jirka


> +	if (hdr->meta_header.meta_len < sizeof(struct btf_metadata)) {
> +		pr_debug("Invalid BTF metadata section\n");
> +		return -EINVAL;
> +	}
> +	btf->meta_data = btf->raw_data + btf->hdr->hdr_len + btf->hdr->meta_header.meta_off;
> +
> +	if (btf->swapped_endian)
> +		btf_bswap_meta(btf->meta_data, hdr->meta_header.meta_len);
> +
> +	return 0;
> +}
> +
>  static int btf_type_size(const struct btf_type *t)
>  {
>  	const int base_size = sizeof(struct btf_type);
> @@ -904,6 +955,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
>  	err = err ?: btf_parse_type_sec(btf);
>  	if (err)
>  		goto done;
> +	err = btf_parse_meta_sec(btf);
>  
>  done:
>  	if (err) {
> @@ -1267,6 +1319,11 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
>  	}
>  
>  	data_sz = hdr->hdr_len + hdr->type_len + hdr->str_len;
> +	if (btf->meta_data) {
> +		data_sz = roundup(data_sz, 8);
> +		data_sz += hdr->meta_header.meta_len;
> +		hdr->meta_header.meta_off = roundup(hdr->type_len + hdr->str_len, 8);
> +	}
>  	data = calloc(1, data_sz);
>  	if (!data)
>  		return NULL;
> @@ -1293,8 +1350,21 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
>  	p += hdr->type_len;
>  
>  	memcpy(p, btf_strs_data(btf), hdr->str_len);
> -	p += hdr->str_len;
> +	/* round up to 8 byte alignment to match offset above */
> +	p = data + hdr->hdr_len + roundup(hdr->type_len + hdr->str_len, 8);
> +
> +	if (btf->meta_data) {
> +		struct btf_metadata *meta = p;
>  
> +		memcpy(p, btf->meta_data, hdr->meta_header.meta_len);
> +		if (!swap_endian) {
> +			meta->crc = crc32(0L, (const Bytef *)&data, sizeof(data));
> +			meta->flags |= BTF_META_CRC_SET;
> +		}
> +		if (swap_endian)
> +			btf_bswap_meta(p, hdr->meta_header.meta_len);
> +		p += hdr->meta_header.meta_len;
> +	}
>  	*size = data_sz;
>  	return data;
>  err_out:
> @@ -1425,13 +1495,13 @@ static void btf_invalidate_raw_data(struct btf *btf)
>  	}
>  }
>  
> -/* Ensure BTF is ready to be modified (by splitting into a three memory
> - * regions for header, types, and strings). Also invalidate cached
> - * raw_data, if any.
> +/* Ensure BTF is ready to be modified (by splitting into a three or four memory
> + * regions for header, types, strings and optional metadata). Also invalidate
> + * cached raw_data, if any.
>   */
>  static int btf_ensure_modifiable(struct btf *btf)
>  {
> -	void *hdr, *types;
> +	void *hdr, *types, *meta = NULL;
>  	struct strset *set = NULL;
>  	int err = -ENOMEM;
>  
> @@ -1446,9 +1516,17 @@ static int btf_ensure_modifiable(struct btf *btf)
>  	types = malloc(btf->hdr->type_len);
>  	if (!hdr || !types)
>  		goto err_out;
> +	if (btf->hdr->hdr_len >= sizeof(struct btf_header)  &&
> +	    btf->hdr->meta_header.meta_off && btf->hdr->meta_header.meta_len) {
> +		meta = calloc(1, btf->hdr->meta_header.meta_len);
> +		if (!meta)
> +			goto err_out;
> +	}
>  
>  	memcpy(hdr, btf->hdr, btf->hdr->hdr_len);
>  	memcpy(types, btf->types_data, btf->hdr->type_len);
> +	if (meta)
> +		memcpy(meta, btf->meta_data, btf->hdr->meta_header.meta_len);
>  
>  	/* build lookup index for all strings */
>  	set = strset__new(BTF_MAX_STR_OFFSET, btf->strs_data, btf->hdr->str_len);
> @@ -1463,6 +1541,8 @@ static int btf_ensure_modifiable(struct btf *btf)
>  	btf->types_data_cap = btf->hdr->type_len;
>  	btf->strs_data = NULL;
>  	btf->strs_set = set;
> +	btf->meta_data = meta;
> +
>  	/* if BTF was created from scratch, all strings are guaranteed to be
>  	 * unique and deduplicated
>  	 */
> @@ -1480,6 +1560,7 @@ static int btf_ensure_modifiable(struct btf *btf)
>  	strset__free(set);
>  	free(hdr);
>  	free(types);
> +	free(meta);
>  	return err;
>  }
>  
> -- 
> 2.31.1
> 

