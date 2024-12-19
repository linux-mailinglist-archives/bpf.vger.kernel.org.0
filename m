Return-Path: <bpf+bounces-47324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAE59F7D7B
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 16:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB87A167C1D
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 15:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3D8225797;
	Thu, 19 Dec 2024 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwlyLDg+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754FE41C64;
	Thu, 19 Dec 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620394; cv=none; b=bpOWfpHYw3fXPzoe3RTA3eUBeED0OdnrC8SgRtewK96rXRzuyTA9DSe3PB7DrT83exyZc5lL6MEQNtu1aLRkTcw9t6HhjVUL4KqwgTcKPi+PUOOaoVUAtm4DN5H7iW7Y0memJoBbebhmC6frbuRJBfAmnMxCu7bQ9O2/Nr5d8i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620394; c=relaxed/simple;
	bh=OgTzGdMjUDzBpLH3nE4dxG966TArIliV3MMG4w1Bj7s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAkStSZxwRYrGebzOPo2wjUrB1KOHf5U59JNaQco4FzJ9OSdofhUGxd+n5DhGUuNCEZjPAt2lQf1Y+TT93vH4wLs/FvK1lR9wtl87k2F9i0AZjoxys13eGmCjHuxOREoqMEwWr4xU4wJ5+L5jpnV5oZiER/9iQyLumHRsD1ZCvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwlyLDg+; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso152407366b.2;
        Thu, 19 Dec 2024 06:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734620392; x=1735225192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RT8b7xWGQgIZNvaQiz2rHjeAdabu/n/BYzlY90fVtTo=;
        b=TwlyLDg+6GY2t8LBnsvD81n/rCaiPK4p/hG1idNn5H+iVmyqKXxli3QULRuZ9r1svD
         YuTtnts7pL91Eg1b2j8hTCymGh4QDwScCuuioHWmiC6jUWR/h2/5Qc0NyU2rEUGQbVZy
         /zsx2S9mVMQQY51E7ZHcD8vvNmFux/xYyu+1CTfsrKRQoHkUu8kiQFVwCAx7sGv7ARy9
         5wdMH6AwEoMT3gGiv/HFkm2mdQLrzClALV7075/kaTF/IdJdmM1rPVP/g+JgM9TruwwZ
         eyIwv7wZLMbxwKfOoSZ5E94WUZvBiFMtu5mjUbF6r6v/JP4LtRkzkkY5KtkgVSktCrEX
         Bg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734620392; x=1735225192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RT8b7xWGQgIZNvaQiz2rHjeAdabu/n/BYzlY90fVtTo=;
        b=a8IirkVeaZXm7S6QaOwOn4YCU0ueM/VmQh1gfydRjqTIn95NUSzRFLqKIBDa7ZzK1s
         XF44VenTivmuwu+UU13zLmsbzFTh1vWbsaf0ObVj21lxFuQQuY7t44Vq4IjOCL45IBJM
         cyptxxwrcvxE0exdJPHT/kkMRAHZ2TXG6yvvfKIAkhXAgvOpm/kym8S/+rcP5Dnoq/Wh
         9gXyERCKSMsNoREO0oXxCl1ljm/ZRsmMmwK8bhok249Hdmcpdj5tIQ76aYbuzvx99RRk
         NwBhvzeSPt8nIzx5wIRTos/hjBJYHz0189o1MwXHhHbdUiKkJ822dbHX0ZOXCTNXlk5H
         oqag==
X-Forwarded-Encrypted: i=1; AJvYcCWhhXT2Ir0OxtqY4CuqLKQdJb9RHOnbRnCCDppbFjOoBcgBen+0+mIlT+aXTDIdOnOXfBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFD2RnZPuDOzmeImi9uqm9j2W8s1PMnWX0v0le1CjAEiGujEMr
	489MCVpN/Ws65Zk+lm8VDGINNs4yhHUfBtcAJdqt6vKfl9XKa1D1
X-Gm-Gg: ASbGncvQQRWmIdR5KAFMOSzsN2oxNNYOPFRaReRt/Ddtlb4rgRLafPaPw5DY50eWxNs
	EGqlqgMmuHvDugC/NY3/Ecltc36/QPWlslWsAdvhAK7zFrJcVCQLP+M+b3ZN4QNjPXh7FncGj1p
	YrFEcnpfyMPX/ASVugAcsf8jiGc2X4w400lssOVjFCWD3ly7tolWuFOrHH/FFqLe5UwNOlkiAE1
	zoXXpT4QJf3Q+AHUK5QYtjhB4yr3A9zmAQj+fvfiQPIcFRg6btFkgXwUI6NgyOJ0+UnGdH3ungD
	dRn9Gh/P7AQP76nCnEeM0XGObflLBA==
X-Google-Smtp-Source: AGHT+IEDvkM7Ciq+jR/RlAmvhDkvs5hHzML8ujzNicZkiL7EluLOQbDvj+UGSJXLayE8BDFetoNoaw==
X-Received: by 2002:a17:906:f5aa:b0:aab:eefc:92e5 with SMTP id a640c23a62f3a-aabf473fe7emr646883166b.14.1734620390680;
        Thu, 19 Dec 2024 06:59:50 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e895194sm74052066b.70.2024.12.19.06.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 06:59:50 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 19 Dec 2024 15:59:48 +0100
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com,
	eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v2 02/10] btf_encoder: separate elf function,
 saved function representations
Message-ID: <Z2Q05JfsckYSuun0@krava>
References: <20241213223641.564002-1-ihor.solodrai@pm.me>
 <20241213223641.564002-3-ihor.solodrai@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213223641.564002-3-ihor.solodrai@pm.me>

On Fri, Dec 13, 2024 at 10:36:53PM +0000, Ihor Solodrai wrote:

SNIP

> +	btf_encoders__for_each_encoder(e) {
> +		list_for_each_entry(s, &e->func_states, node)
> +			nr_saved_fns++;
> +	}
> +
> +	if (nr_saved_fns == 0)
> +		return 0;
> +
> +	saved_fns = calloc(nr_saved_fns, sizeof(*saved_fns));
> +	btf_encoders__for_each_encoder(e) {
> +		list_for_each_entry(s, &e->func_states, node)
> +			saved_fns[i++] = s;
> +	}
> +	qsort(saved_fns, nr_saved_fns, sizeof(*saved_fns), saved_functions_cmp);
> +
> +	for (i = 0; i < nr_saved_fns; i = j) {
> +		struct btf_encoder_func_state *state = saved_fns[i];
> +
> +		/* Compare across sorted functions that match by name/prefix;
> +		 * share inconsistent/unexpected reg state between them.
> +		 */
> +		j = i + 1;
> +
> +		while (j < nr_saved_fns && saved_functions_combine(saved_fns[i], saved_fns[j]) == 0)
> +			j++;
> +
> +		/* do not exclude functions with optimized-out parameters; they
> +		 * may still be _called_ with the right parameter values, they
> +		 * just do not _use_ them.  Only exclude functions with
> +		 * unexpected register use or multiple inconsistent prototypes.
> +		 */
> +		if (!encoder->skip_encoding_inconsistent_proto ||
> +		    (!state->unexpected_reg && !state->inconsistent_proto)) {
> +			if (btf_encoder__add_func(state->encoder, state)) {
> +				free(saved_fns);
> +				return -1;
> +			}
> +		}
> +	}
> +	/* Now that we are done with function states, free them. */
> +	free(saved_fns);
> +	btf_encoders__for_each_encoder(e)
> +		btf_encoder__delete_saved_funcs(e);

nit, wrong indent

jirka

> +	return 0;
> +}
> +
>  static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *sym)

SNIP

