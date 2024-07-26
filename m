Return-Path: <bpf+bounces-35725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA6793D304
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 14:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B27B20D03
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 12:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D95C17B409;
	Fri, 26 Jul 2024 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9vY95o1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F262179957;
	Fri, 26 Jul 2024 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997120; cv=none; b=nXgu9FVLuQ08v1Feg5p2hL07ly7fIYBuBIdZ+6OiBCeftdYOPUJ9RggsCYr+0H5OvKlpROZfSqqBFTsmKfxqqV4I+yUPf7JoWjDCcQ2Nnf7uW/EM6IXzTTQdd3qnr9tuTPVra+jIHxI6ZfeOsH7vTFIO6yXKGyv3o78yaA3hrsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997120; c=relaxed/simple;
	bh=wQ86fZI4MKfiHv5LgeOss1b5Y45NUDvJVHe9t4v2g08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIXd0TyXWIu6LL9ep9DyvREE6HP8Sxjtz3GCRC8RcIqiJ3LubSm+6PIN/D6QAWDJdPiA/zbRu79wmKYGqObvs0EATGsYpz/HyI6673QW76PA3R3G1n/3pVfqJ293nlrGBSlAezRjSmSDaEI/RLqPQABkVqs7M/BrrZDcMvz8S3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9vY95o1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B36C32782;
	Fri, 26 Jul 2024 12:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721997119;
	bh=wQ86fZI4MKfiHv5LgeOss1b5Y45NUDvJVHe9t4v2g08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B9vY95o1PuEMIfHqflv598ilUBKTkZVWSPQbZ6uWVhKKkoNNj2vjZFLnqBHLOsjVJ
	 YtguBWZ6GAIGILBofT+J2okh4vEg5apPsohAu6rcpELiV0JGslHBGhZgWyCMRh6NVL
	 EA3BZQ6z87+c7mpdjMRPbrO/2RwM2yStMVxwz5XVq1Ah4Iv9EGhwAWFKCckR8wRmy1
	 cstCuC+5gh0rjMdZuXeybi3IhQ3EqaTgkbR3avK03NyZVH1kqnSzgWpRS8kbw5HC83
	 D0O6dhRCUV3BsoGCgyOVY27Hp25+EtqNcqwOCBbKfHCIa9OKzXfHcmmh5YxQ2Co4+N
	 nSdrg0CZP9Gvw==
Date: Fri, 26 Jul 2024 09:31:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: cavok@debian.org, jolsa@kernel.org, ben@decadent.org.uk,
	dwarves@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves] btf_encoder: log libbpf errors when they cause
 encoding errors
Message-ID: <ZqOXO1ltZoueQQ_f@x1>
References: <20240725075520.1281905-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725075520.1281905-1-alan.maguire@oracle.com>

On Thu, Jul 25, 2024 at 08:55:20AM +0100, Alan Maguire wrote:
> libbpf returns a negative error code when adding types fails.
> Pass it into btf__log_err() and display the libbpf error when
> negative.  Nearly all use cases of btf__log_err() happen as a
> result of a libbpf-returned error, pass 0 for the exceptions.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  btf_encoder.c | 45 +++++++++++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index c2df2bc..adc38c3 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -237,9 +237,9 @@ static const char * btf__int_encoding_str(uint8_t encoding)
>  		return "UNKN";
>  }
>  
> -__attribute ((format (printf, 5, 6)))
> +__attribute ((format (printf, 6, 7)))
>  static void btf__log_err(const struct btf *btf, int kind, const char *name,
> -			 bool output_cr, const char *fmt, ...)
> +			 bool output_cr, int libbpf_err, const char *fmt, ...)
>  {
>  	fprintf(stderr, "[%u] %s %s", btf__type_cnt(btf),
>  		btf_kind_str[kind], name ?: "(anon)");
> @@ -253,6 +253,9 @@ static void btf__log_err(const struct btf *btf, int kind, const char *name,
>  		va_end(ap);
>  	}
>  
> +	if (libbpf_err < 0)
> +		fprintf(stderr, " (libbpf error %d)", libbpf_err);
> +
>  	if (output_cr)
>  		fprintf(stderr, "\n");
>  }
> @@ -355,7 +358,8 @@ static int32_t btf_encoder__add_float(struct btf_encoder *encoder, const struct
>  	int32_t id = btf__add_float(encoder->btf, name, BITS_ROUNDUP_BYTES(bt->bit_size));
>  
>  	if (id < 0) {
> -		btf__log_err(encoder->btf, BTF_KIND_FLOAT, name, true, "Error emitting BTF type");
> +		btf__log_err(encoder->btf, BTF_KIND_FLOAT, name, true, id,
> +			     "Error emitting BTF type");
>  	} else {
>  		const struct btf_type *t;
>  
> @@ -429,7 +433,7 @@ static int32_t btf_encoder__add_base_type(struct btf_encoder *encoder, const str
>  
>  	id = btf__add_int(encoder->btf, name, byte_sz, encoding);
>  	if (id < 0) {
> -		btf__log_err(encoder->btf, BTF_KIND_INT, name, true, "Error emitting BTF type");
> +		btf__log_err(encoder->btf, BTF_KIND_INT, name, true, id, "Error emitting BTF type");
>  	} else {
>  		t = btf__type_by_id(encoder->btf, id);
>  		btf_encoder__log_type(encoder, t, false, true, "size=%u nr_bits=%u encoding=%s%s",
> @@ -473,7 +477,7 @@ static int32_t btf_encoder__add_ref_type(struct btf_encoder *encoder, uint16_t k
>  		id = btf__add_func(btf, name, BTF_FUNC_STATIC, type);
>  		break;
>  	default:
> -		btf__log_err(btf, kind, name, true, "Unexpected kind for reference");
> +		btf__log_err(btf, kind, name, true, 0, "Unexpected kind for reference");
>  		return -1;
>  	}
>  
> @@ -484,7 +488,7 @@ static int32_t btf_encoder__add_ref_type(struct btf_encoder *encoder, uint16_t k
>  		else
>  			btf_encoder__log_type(encoder, t, false, true, "type_id=%u", t->type);
>  	} else {
> -		btf__log_err(btf, kind, name, true, "Error emitting BTF type");
> +		btf__log_err(btf, kind, name, true, id, "Error emitting BTF type");
>  	}
>  	return id;
>  }
> @@ -503,7 +507,7 @@ static int32_t btf_encoder__add_array(struct btf_encoder *encoder, uint32_t type
>  		btf_encoder__log_type(encoder, t, false, true, "type_id=%u index_type_id=%u nr_elems=%u",
>  				      array->type, array->index_type, array->nelems);
>  	} else {
> -		btf__log_err(btf, BTF_KIND_ARRAY, NULL, true,
> +		btf__log_err(btf, BTF_KIND_ARRAY, NULL, true, id,
>  			      "type_id=%u index_type_id=%u nr_elems=%u Error emitting BTF type",
>  			      type, index_type, nelems);
>  	}
> @@ -545,12 +549,12 @@ static int32_t btf_encoder__add_struct(struct btf_encoder *encoder, uint8_t kind
>  		id = btf__add_union(btf, name, size);
>  		break;
>  	default:
> -		btf__log_err(btf, kind, name, true, "Unexpected kind of struct");
> +		btf__log_err(btf, kind, name, true, 0, "Unexpected kind of struct");
>  		return -1;
>  	}
>  
>  	if (id < 0) {
> -		btf__log_err(btf, kind, name, true, "Error emitting BTF type");
> +		btf__log_err(btf, kind, name, true, id, "Error emitting BTF type");
>  	} else {
>  		t = btf__type_by_id(btf, id);
>  		btf_encoder__log_type(encoder, t, false, true, "size=%u", t->size);
> @@ -600,7 +604,7 @@ static int32_t btf_encoder__add_enum(struct btf_encoder *encoder, const char *na
>  		t = btf__type_by_id(btf, id);
>  		btf_encoder__log_type(encoder, t, false, true, "size=%u", t->size);
>  	} else {
> -		btf__log_err(btf, is_enum32 ? BTF_KIND_ENUM : BTF_KIND_ENUM64, name, true,
> +		btf__log_err(btf, is_enum32 ? BTF_KIND_ENUM : BTF_KIND_ENUM64, name, true, id,
>  			      "size=%u Error emitting BTF type", size);
>  	}
>  	return id;
> @@ -682,9 +686,9 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
>  		t = btf__type_by_id(btf, id);
>  		btf_encoder__log_type(encoder, t, false, false, "return=%u args=(%s", t->type, !nr_params ? "void)\n" : "");
>  	} else {
> -		btf__log_err(btf, BTF_KIND_FUNC_PROTO, NULL, true,
> -			      "return=%u vlen=%u Error emitting BTF type",
> -			      type_id, nr_params);
> +		btf__log_err(btf, BTF_KIND_FUNC_PROTO, NULL, true, id,
> +			     "return=%u vlen=%u Error emitting BTF type",
> +			     type_id, nr_params);
>  		return id;
>  	}
>  
> @@ -718,9 +722,9 @@ static int32_t btf_encoder__add_var(struct btf_encoder *encoder, uint32_t type,
>  		t = btf__type_by_id(btf, id);
>  		btf_encoder__log_type(encoder, t, false, true, "type=%u linkage=%u", t->type, btf_var(t)->linkage);
>  	} else {
> -		btf__log_err(btf, BTF_KIND_VAR, name, true,
> -			      "type=%u linkage=%u Error emitting BTF type",
> -			      type, linkage);
> +		btf__log_err(btf, BTF_KIND_VAR, name, true, id,
> +			     "type=%u linkage=%u Error emitting BTF type",
> +			     type, linkage);
>  	}
>  	return id;
>  }
> @@ -781,9 +785,9 @@ static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char
>  
>  	id = btf__add_datasec(btf, section_name, datasec_sz);
>  	if (id < 0) {
> -		btf__log_err(btf, BTF_KIND_DATASEC, section_name, true,
> -				 "size=%u vlen=%u Error emitting BTF type",
> -				 datasec_sz, nr_var_secinfo);
> +		btf__log_err(btf, BTF_KIND_DATASEC, section_name, true, id,
> +			     "size=%u vlen=%u Error emitting BTF type",
> +			     datasec_sz, nr_var_secinfo);
>  	} else {
>  		t = btf__type_by_id(btf, id);
>  		btf_encoder__log_type(encoder, t, false, true, "size=%u vlen=%u", t->size, nr_var_secinfo);
> @@ -819,7 +823,8 @@ static int32_t btf_encoder__add_decl_tag(struct btf_encoder *encoder, const char
>  		btf_encoder__log_type(encoder, t, false, true, "type_id=%u component_idx=%d",
>  				      t->type, component_idx);
>  	} else {
> -		btf__log_err(btf, BTF_KIND_DECL_TAG, value, true, "component_idx=%d Error emitting BTF type",
> +		btf__log_err(btf, BTF_KIND_DECL_TAG, value, true, id,
> +			     "component_idx=%d Error emitting BTF type",
>  			     component_idx);
>  	}
>  
> -- 
> 2.43.5

