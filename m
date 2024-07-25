Return-Path: <bpf+bounces-35639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A481C93C259
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 14:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3A828377D
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 12:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5F019AD56;
	Thu, 25 Jul 2024 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2gb1h1B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B042A19A289;
	Thu, 25 Jul 2024 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911733; cv=none; b=pKvCHjvb83PWb6GibrDacrel5meFcGmGWZLkDUSyqQLq6PdAsZ2Nuf6lheUJlwszIISo3k9tOeM0QQ0P21ISBNuubVQqe3uZ3DJDMC6FHXMpL3izWMnLPF3Rbk+2t2HOzCRwY2qvqTJyS1zELigBPBMDSFVcK8a/qGmVwCCHQNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911733; c=relaxed/simple;
	bh=xvUmv/V5XpbZDV3hoLQplCvV5YwOW60LYQUs7hz1w+k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9lqJ7V9uPbbwdUdWyU1g7bgafNOKvjt3mWfmIL/7VoTZo1Objpvsc78PBgJng8idltNejV4ENaYi+zV+BS09BMyU5ndIaMwo8AoWRZEsDzjKjzShwPaBwJrEwEVQIQ7JhpwZcxInPclBkTXTKobqohNIphoiZYhW4YjoldIUAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2gb1h1B; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a9a7af0d0so66164166b.3;
        Thu, 25 Jul 2024 05:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721911730; x=1722516530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jxVK/86EyhdF5peNq0CDNZyt485zqN4rxGsUWvCjMK0=;
        b=c2gb1h1BT0PpLwjS0dyGfz0yjWLfhNd3+C8BcGTl7gYKVQex9Hx3gV7wfk6cB720NR
         qL0zL0HTBIWfBvbXB2iWezGymO5PUuLjIPdusor1QYNoZBvRK/XPtG0OKyUeOqBbjLQh
         9O9a54Guw2sUtoS4WYDjfCrCw368Q0FSGXoFCHUjQwuVqIGOtqvgx0YxPeWblzPxJSaI
         ngr1x7kgQrPitF6J1pCho5ypNwg2WxjFLFpA6qVWMBsjC/MW4F/dceH2U/OKfeS6ptym
         j110sS+kLAL7P/gsjSDxySifpIi6X5RKU45VuSYR5Nrbj762AnN2VsZY24n0F/+DMk+5
         INXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721911730; x=1722516530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxVK/86EyhdF5peNq0CDNZyt485zqN4rxGsUWvCjMK0=;
        b=NlMr4F4YdGmXFC0+YM2+LWU4X1jqFy8JMj1mPG2J5ORTyS/UIEXVMXGIrvPkfMsYER
         X0ZiY4OmFK0DHCW7uMX3GJZdYNjMcrgsMOIul3hVgjZ7ynD4wqFMY/XRrhBbKSoqYTzL
         p+Teo3Xzd9YiJVpKG2jJ/r7zOAhiZb6X/KNQ5K/jjEbvGySMgXHTxIy8gZq5mJBslm/X
         xtfbuRhmHYwujCZrc40qQgV1fLkL1DSZlaaVpfps0XDOsDhqv8A0dwQi3spyMwY8NkVN
         1qfzMyGdGVmwkoyymPqRvBbHG7Rq1RdzoqFGu5NykchrgLs3OQSZwhGZ4iI0PWW1zHUS
         UCvg==
X-Forwarded-Encrypted: i=1; AJvYcCW2dPHfYCGD+BBno/KnMcxxUK5oFsRMG3QkbnQeaFPAr1weEvyK70yZRkB6LdKZ30FGdNI0/aYDjFHNAprnoPF6RPh8COxs1prchoURFPvsep41ATF/30wORjf9dA==
X-Gm-Message-State: AOJu0YwE24BWfwDzcm7+NQhr+dRIrHLUnmEuu1BhMkIlpvPPofPXryAt
	yJW6ynRAF7zq2iwyLTrgW61X5SQEoSItU50F4KrNOcONm6H4jDsLgawoRQ==
X-Google-Smtp-Source: AGHT+IEWfW0bolIktzt9ynOAmtbVKjj+Z2e31FprNPes2lx22CnhuNtFYbMjd19i8BHcmxQX55hnAA==
X-Received: by 2002:a17:906:6a1c:b0:a79:8318:288f with SMTP id a640c23a62f3a-a7acb477e3fmr160724266b.16.1721911729541;
        Thu, 25 Jul 2024 05:48:49 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab23654sm70420166b.32.2024.07.25.05.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:48:48 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 25 Jul 2024 14:48:46 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, cavok@debian.org, ben@decadent.org.uk,
	dwarves@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves] btf_encoder: log libbpf errors when they cause
 encoding errors
Message-ID: <ZqJJrpL2eBJblTtz@krava>
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

the more info the better ;-) lgtm

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
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
> 

