Return-Path: <bpf+bounces-47736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD08C9FF4A5
	for <lists+bpf@lfdr.de>; Wed,  1 Jan 2025 17:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4D3161E8A
	for <lists+bpf@lfdr.de>; Wed,  1 Jan 2025 16:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438BA1E2848;
	Wed,  1 Jan 2025 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVO8mO+z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7722942A;
	Wed,  1 Jan 2025 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735750590; cv=none; b=q4tDOO0J/WP3QHquMkE9rMK43gkHZ78utlVw3R2wzdKJ2PmA1I1YE4O89R3V7rms8+aPLQz+BVM13wfydKEhcDYb1+baZjNpphiVaW0roTPhIaBoa6VqaeTlAy7+AU4AEMHK9JsSjCkdVQgAetE6n2wSNMuFfBRUKuOcvcJTOBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735750590; c=relaxed/simple;
	bh=m+f7sM9UGsIOoQUYvcqYnjq++6kJcCPuqj+E+7X6Hks=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnmSmGHeBkUMXlH1hhJMg8iesUZ+estT3RD39Dgw37LjHNH6Gb9ck2sQtOAP43VBNl53ygpYUOQe9m03GmLrWlb51SrpZxk8jABz1kMxlB+CD1sb6y3f8MAZ/Oq8aonlWyQK/HULLxbx6O7Mdd7DzpRn8NCAIaKFaxi4G5GWYVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVO8mO+z; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa66e4d1d5aso1683052966b.2;
        Wed, 01 Jan 2025 08:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735750587; x=1736355387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=La/wJ2wJadPED0ztu1qtla84plOVpGwZGebfvxffaKQ=;
        b=hVO8mO+zkFX5UXR6RjDTrfK40lJ2jqd0rAdh2Dq7ebuPQ0Bfku0N28fAIJV8g26QU6
         dKp/Ai40jQRTtI3QL3S8v+OSzeKoukx5S1pSRycU9i2Ct9lgHQZgBXnyv7Xe91s+WADZ
         Gn0QBMQeX4SJJpv0LXHav6HbqXYKQnbbSfRqmRG4IfIjSt/Y32kooio50UwaLeYzumr+
         7uvFS+dDKbSuxwWMfCpfFITQwneW0yMARn3k+0vFsFODLCbA84lITmMq2EtWvdsYEZqu
         xlPrjyN2+6DaVzMZVMD9EnJP6PUz6OCYTVrGMJ67MqLE4MCK2o6fcLmhHwOjhexpFCEf
         C22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735750587; x=1736355387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=La/wJ2wJadPED0ztu1qtla84plOVpGwZGebfvxffaKQ=;
        b=YCIQrT6vfPsCEbeoqwkhvXq7dbAKjvvfAAG1TtCn9Ts/ry8zHMHUwin7VWf4alMEX8
         8uaK5Yarsfqc8X6D9uwVDGyiH776blSZ5ymjb0ywFEmYVIjdNR5F+g992EkbKfn0W/hQ
         jCRz4Kbs6tjcCfRFwsLRfwt4h2VnxP86CnEKyZaUsMhx7BoBndNhoNNVR+xydHmfgPbT
         quU/qI2LL7FjrGYzl5miXh503uzN5CTR5oB/a3L/8fFKq/UykUzDw+zJ9JzYUU4eS9Of
         Ac5ZtNGSrOsVr0ItCLpr+FexTmMpkYd0JgD8tNch2GqgaDoPiCBLXl448cI0yKzSqDq6
         i6Mg==
X-Forwarded-Encrypted: i=1; AJvYcCW/wRa3V1MbvI+cp4Fk0EE6g/F72fBceKCP6DrKCYCcxzQllXRZfecWQtRmdm3tLknq+qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRBFeyDT0hX/r6wZfyLMMxJNjW/Kczp0N2VL13tmR0pmUsA9vI
	Xo6lb6WgISoqK3PnW1rUmYZMWKTagK9yIfv3iT3gPGphIMVolMP2
X-Gm-Gg: ASbGncuqifiixSPY42tR+abwWH9AmCX/9nPaMB7mCvjnpEHg7AbzW+gtkucVBDtuIpE
	1Ve4pJD2S8Qc7+soTslgG9RSjXwYsgWC1L0F7ZQP5hsXnKsnv29Usw2lrC0z+fnp9OXScJMSpK3
	2jM1F0duYICZ9vITh/10HUxiFXrHlEHnZ8QiV4+4SMi58slfFNvc2TwVOQPFbONGnBMuPLhEyh8
	64JbLNlO/iuKSqHc8F/PVPDvE+m+CLCha1g3NKhv2PT+/XVXrJVWCqQIaL/1g8=
X-Google-Smtp-Source: AGHT+IFetTrohW2K09N3bgW1/qfPvJNbOG2izUp+Vm2k2QWYwEgX7yPpuCDGEak/Yq/uSrHNFEyUGA==
X-Received: by 2002:a17:907:6092:b0:aab:c35e:509b with SMTP id a640c23a62f3a-aac3378bee1mr3451851366b.55.1735750587132;
        Wed, 01 Jan 2025 08:56:27 -0800 (PST)
Received: from krava (85-193-35-38.rib.o2.cz. [85.193.35.38])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f06542fsm1684866866b.176.2025.01.01.08.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 08:56:26 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 1 Jan 2025 17:56:24 +0100
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com,
	eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v3 8/8] btf_encoder: clean up global encoders list
Message-ID: <Z3VzuN8yX63qktPl@krava>
References: <20241221012245.243845-1-ihor.solodrai@pm.me>
 <20241221012245.243845-9-ihor.solodrai@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241221012245.243845-9-ihor.solodrai@pm.me>

On Sat, Dec 21, 2024 at 01:23:45AM +0000, Ihor Solodrai wrote:

SNIP

> -static int btf_encoder__add_saved_funcs(bool skip_encoding_inconsistent_proto)
> +static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_encoding_inconsistent_proto)
>  {
>  	struct btf_encoder_func_state **saved_fns, *s;
> -	struct btf_encoder *e = NULL;
> -	int i = 0, j, nr_saved_fns = 0;
> +	int err = 0, i = 0, j, nr_saved_fns = 0;
>  
> -	/* Retrieve function states from each encoder, combine them
> +	/* Retrieve function states from the encoder, combine them
>  	 * and sort by name, addr.
>  	 */
> -	btf_encoders__for_each_encoder(e) {
> -		list_for_each_entry(s, &e->func_states, node)
> -			nr_saved_fns++;
> +	list_for_each_entry(s, &encoder->func_states, node) {
> +		nr_saved_fns++;
>  	}
>  
>  	if (nr_saved_fns == 0)
> -		return 0;
> +		goto out;
>  
>  	saved_fns = calloc(nr_saved_fns, sizeof(*saved_fns));
> -	btf_encoders__for_each_encoder(e) {
> -		list_for_each_entry(s, &e->func_states, node)
> -			saved_fns[i++] = s;
> +	if (!saved_fns) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	list_for_each_entry(s, &encoder->func_states, node) {
> +		saved_fns[i++] = s;
>  	}
>  	qsort(saved_fns, nr_saved_fns, sizeof(*saved_fns), saved_functions_cmp);
>  
> @@ -1377,11 +1313,10 @@ static int btf_encoder__add_saved_funcs(bool skip_encoding_inconsistent_proto)
>  
>  	/* Now that we are done with function states, free them. */
>  	free(saved_fns);
> -	btf_encoders__for_each_encoder(e) {
> -		btf_encoder__delete_saved_funcs(e);
> -	}
> +	btf_encoder__delete_saved_funcs(encoder);

is this call necessary? there's btf_encoder__delete call right after
same for elf_functions_list__clear in btf_encoder__encode

thanks,
jirka


>  
> -	return 0;
> +out:
> +	return err;
>  }
>  

SNIP

