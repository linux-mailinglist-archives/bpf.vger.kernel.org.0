Return-Path: <bpf+bounces-47734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ED69FF4A3
	for <lists+bpf@lfdr.de>; Wed,  1 Jan 2025 17:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9385161E19
	for <lists+bpf@lfdr.de>; Wed,  1 Jan 2025 16:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301F31E2607;
	Wed,  1 Jan 2025 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYcTwgPa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC652942A;
	Wed,  1 Jan 2025 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735750574; cv=none; b=i5pzGUcdt3o+lYoGDm0KygsE0vsVB3rBOGUUSG1EGwI89v05cCto9gP9Q6/Yvcp6Us/9vS4C7IKnZKeEnxWapxC6R8pGyUJUbbyB6IMXwU6CGUgXKBIUu1f15sqYa3q79xwaKIDFr7MzqEOPBFusMeRES8evAvzTw7fTPDyDITc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735750574; c=relaxed/simple;
	bh=09nWVagkVZ9t9sb3QkdX+LGVHhngVL98UINO/LWQ2VE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VV4QjYtCT7TWca0YDCJJ7WBxgu8WSTngcOdBXOGSDM9JS8fJzUDfMtHN5kouvCNS3ngNxfzqZwCFkwIKB84Vgiu+kthvixO3iHyDQ6rODGpnWJdCZLywWFlOB36udphDuYTUHkJd/s8GlJCbT3fe850wbUfH3EbAG9fcd/yP/so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYcTwgPa; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d27243ba8bso20418628a12.2;
        Wed, 01 Jan 2025 08:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735750571; x=1736355371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mf+GmWT6Is+U7LA24+CKqryejkOI6I9HjBj9goV9Lgg=;
        b=iYcTwgPavD/zirKrCw9/cuBh5EfYPnrQl4FziCRh51xRQ1yEJ4D6V4Y+8zgZkRQ7SS
         q/vanZfR04c/yEZ5Az8nd8FENzZpKcQyYGirTqglsb8sgBa5f+8VLjpeOA0r8epFfJEF
         6Usq4X2VSP7WJ8GkxV0KlkTJDlvVMtWz/3VPbffVor8jcM49Pq+BhxVnUXuO4jUZbgTn
         x2KzCDSgrdTCM0a/PwyWSzQpPXn+Ea4UnkCYhu7F02KhJczpnW0ByaLStBF39F9BkyUL
         jwVDgz62ieJim0Go7OLiIW3Xjb4gmaKfb8nJzMxgqH601aMF/b1IPcCuWCisd36vQaoH
         2Dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735750571; x=1736355371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mf+GmWT6Is+U7LA24+CKqryejkOI6I9HjBj9goV9Lgg=;
        b=DhY7KNJkjpk3Wt8bFDik3tma04/eTyZ1WwrO6eWOlLQniZgnlWDiWbj0x75NW472aW
         M6uUR30xoFUJJ0kzcQDByp9yVc0VHT6+VKxYsfBiRD1tBv1HtwVRxmNRv3gP4ZhgoXWw
         2Xve7bcNp51JbYW0yJcDpkZGKMd52pWa7NTvOZ8DCEzkysjSoQsQoKjNOhuFcKc7aAgj
         1jBPTUEYwsBgZjMWPIbZrS4msQuWmyuiJOrX4s+3PCuXIYzXaXZfRsg4MC88vAKDU4t1
         9HQoCOjGKjw1YZMn802klE2xFhm4FQwoVrQY3UnRbtf5gOrXy+8l4JslWL/o6M3GF1r0
         38wg==
X-Forwarded-Encrypted: i=1; AJvYcCXAQ/+5xqygKnkWpQLzBeSa1frOt6wApxsvzRDrhUYuuSZbo3BJDtpERPkpWgQREx+Nuuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu9FoleRcQ05UsbvjqEr504kqGnO2aaAzyIdNhWDQGwNVVsyCf
	k9RmSIDLkAnlCybtf8yYJlP8AjE2QMSnkciqgHFQGJW1MmqxS7xCetJuSA==
X-Gm-Gg: ASbGncsbDJosTW1vRG+yEYmu3t6S4GyoaFvgJHykWVVpx8DhNZcQzXy2r4iXkSUFWlu
	uREFqI31rSR77F7w2BZp5o1UE0vQ1uRHzlAJtVbbLiTyf2hmFlw+a3Y/TT2n+jcwxq4cMBl7AIa
	QSOzJmKENg5ToZqu2yraIavTmcTbgau2EKWmXixAW0WtijH+XG1lIrSsAPSEYk3whXnAFMwaa39
	ljhQRbsG6UTBjwYgkIlnSArGG3CD0kBwLNjoOSGlGBs5REwlDcu9xxECBLUHsU=
X-Google-Smtp-Source: AGHT+IFhjF0T5Ddy1O8+2fAQdhwPvyppTRc6gto2XXpj4chKe7YPN2ZR3WpKd+0wvowXeFZGgaFiZQ==
X-Received: by 2002:a05:6402:26ca:b0:5d0:8f1c:8b94 with SMTP id 4fb4d7f45d1cf-5d81ddc0378mr37115061a12.13.1735750570912;
        Wed, 01 Jan 2025 08:56:10 -0800 (PST)
Received: from krava (85-193-35-38.rib.o2.cz. [85.193.35.38])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f23bsm17816845a12.32.2025.01.01.08.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 08:56:10 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 1 Jan 2025 17:56:07 +0100
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com,
	eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v3 2/8] btf_encoder: separate elf function, saved
 function representations
Message-ID: <Z3Vzp9M55sRsNgCP@krava>
References: <20241221012245.243845-1-ihor.solodrai@pm.me>
 <20241221012245.243845-3-ihor.solodrai@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241221012245.243845-3-ihor.solodrai@pm.me>

On Sat, Dec 21, 2024 at 01:23:01AM +0000, Ihor Solodrai wrote:

SNIP

> +static int saved_functions_combine(void *_a, void *_b)
> +{
> +	uint8_t optimized, unexpected, inconsistent;
> +	struct btf_encoder_func_state *a = _a;
> +	struct btf_encoder_func_state *b = _b;
> +	int ret;
> +
> +	ret = strncmp(a->elf->name, b->elf->name,
> +		      max(a->elf->prefixlen, b->elf->prefixlen));
> +	if (ret != 0)
> +		return ret;
> +	optimized = a->optimized_parms | b->optimized_parms;
> +	unexpected = a->unexpected_reg | b->unexpected_reg;
> +	inconsistent = a->inconsistent_proto | b->inconsistent_proto;
> +	if (!unexpected && !inconsistent && !funcs__match(a, b))
> +		inconsistent = 1;
> +	a->optimized_parms = b->optimized_parms = optimized;
> +	a->unexpected_reg = b->unexpected_reg = unexpected;
> +	a->inconsistent_proto = b->inconsistent_proto = inconsistent;

do we still need to update the 'b' state object?

> +
> +	return 0;
> +}
> +
> +static void btf_encoder__delete_saved_funcs(struct btf_encoder *encoder)
> +{
> +	struct btf_encoder_func_state *pos, *s;
> +
> +	list_for_each_entry_safe(pos, s, &encoder->func_states, node) {
> +		list_del(&pos->node);
> +		free(pos->parms);
> +		free(pos->annots);
> +		free(pos);
> +	}
> +
> +	for (int i = 0; i < encoder->functions.cnt; i++)
> +		free(encoder->functions.entries[i].alias);
> +}
> +
> +int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
> +{
> +	struct btf_encoder_func_state **saved_fns, *s;
> +	struct btf_encoder *e = NULL;
> +	int i = 0, j, nr_saved_fns = 0;
> +
> +	/* Retrieve function states from each encoder, combine them
> +	 * and sort by name, addr.
> +	 */
> +	btf_encoders__for_each_encoder(e) {
> +		list_for_each_entry(s, &e->func_states, node)
> +			nr_saved_fns++;
> +	}

the encoder loop goes eventualy away, but still would it make to store
func_states count instead of the loop?

now when there's just single place that stores 'state' it seems like it
should be straighforward

SNIP

>  void btf_encoder__delete(struct btf_encoder *encoder)
>  {
> -	int i;
>  	size_t shndx;
>  
>  	if (encoder == NULL)
> @@ -2447,18 +2469,19 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>  	btf_encoders__delete(encoder);
>  	for (shndx = 0; shndx < encoder->seccnt; shndx++)
>  		__gobuffer__delete(&encoder->secinfo[shndx].secinfo);
> +	free(encoder->secinfo);

nit, this seems unrelated to this change, should be in separate fix?

thanks,
jirka


>  	zfree(&encoder->filename);
>  	zfree(&encoder->source_filename);
>  	btf__free(encoder->btf);
>  	encoder->btf = NULL;
>  	elf_symtab__delete(encoder->symtab);
>  
> -	for (i = 0; i < encoder->functions.cnt; i++)
> -		btf_encoder__delete_func(&encoder->functions.entries[i]);
>  	encoder->functions.allocated = encoder->functions.cnt = 0;
>  	free(encoder->functions.entries);
>  	encoder->functions.entries = NULL;
>  
> +	btf_encoder__delete_saved_funcs(encoder);
> +
>  	free(encoder);
>  }
>  

SNIP

