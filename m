Return-Path: <bpf+bounces-17192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED38D80A799
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 16:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2855F1C2099F
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 15:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96E831A92;
	Fri,  8 Dec 2023 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8mfTYyd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649BB10F1
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 07:39:45 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-33610bf5facso323567f8f.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 07:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702049984; x=1702654784; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QQBP4ODyQSqGWOBLO1urirvVPav5mAE3BBc1ZOsr7Nw=;
        b=Z8mfTYyddglInVwYZN6NmNfujmnVaE2CTI6eAPYu8/TZeFBtpwf5rrvnVhMZZC7hu6
         4e6iU1l8WMhedC9F/QVgtrFKc7axLKjBCAHfHtlU6Ei8gRjW+SmFf5jMInR7djiPQZxu
         wJAd9oJ4YlZUG3yOx1UqYr6Jsx2trU/di0nmNYjgAsZbTolDP2TqaD/y+oEuRfDdEyfp
         5QYeCC6pAN/8rJ3rxysnc+Re3S7mh9oWR4Sl/5HSsOCn5taHJ+THIG39ezVKLkSkdtSk
         tHGkoE9Qn9u3UfR8uhBciq3VGXVlHgjsP8yS3RXqR6WTEk2nsIiRQLysJeZT//1LFa7x
         zcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702049984; x=1702654784;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQBP4ODyQSqGWOBLO1urirvVPav5mAE3BBc1ZOsr7Nw=;
        b=LShU4UQiiQsVOpAYAu5Kmj03lCZOyweHjMIZ7N2EdYAbnDHxZ9PZR2XVxfnwAt+ekI
         Z7cGD1SIxcHdmE9iRANCXz6rtiy+V37cToul3F8fJHWc4NPQVB2jKn6ygchGhmxGrgXg
         zUPMg7joIzOffPDFqW7RfQIlFIZ1WcXEjc14wGbaCFA2FbehgWYeIyP+uVPDSx4bwXXD
         PHXzKqPyL+78gcZtVC2CtZGp1AtzpkABL9dlpshIBZiPpJOR1+XYfZHcpW2NUCkc9qiR
         dpRl9ulegYezVpvXNDDP+iMERePGERZK/sYY0KB8WP4gZRMMeNIqmZhSnn+lPrGdWaEg
         rtKg==
X-Gm-Message-State: AOJu0Yx8nB7PyB+6X1ouzJZqx9/mkCDUc0G09QZlLgKfN9s2Qy6ts9mJ
	cpWOCn9jFYylH7p4onYe5LM=
X-Google-Smtp-Source: AGHT+IH999+e85kVZiCk4F0MDlD+nLxSYwAq5OKG7M18Lv2QjZ3SWECO0OU/48ieEGbiMqLNN/Zo8Q==
X-Received: by 2002:a5d:42d2:0:b0:333:3d0a:5049 with SMTP id t18-20020a5d42d2000000b003333d0a5049mr142609wrr.51.1702049983641;
        Fri, 08 Dec 2023 07:39:43 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id j5-20020a5d6045000000b003332faefd86sm330465wrt.0.2023.12.08.07.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:39:42 -0800 (PST)
Message-ID: <6261d017f25d687f294f462ca0c0539d8b1cd436.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/1] use preserve_static_offset in bpf uapi
 headers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
 ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, jose.marchesi@oracle.com
Date: Fri, 08 Dec 2023 17:39:36 +0200
In-Reply-To: <b8ae795d-b010-f451-38d9-8357da66a291@oracle.com>
References: <20231208000531.19179-1-eddyz87@gmail.com>
	 <1d2a2af0-40db-80f9-da13-caf53f3d9118@oracle.com>
	 <069960f88faa6740b9059ff428f7f209d8e8d6d2.camel@gmail.com>
	 <b8ae795d-b010-f451-38d9-8357da66a291@oracle.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-08 at 15:35 +0000, Alan Maguire wrote:
[...]
> > Tbh, I like the decl tag approach a bit more too.
> > Although macro definition would be somewhat ridiculous:
> >=20
> >     #if __has_attribute(preserve_static_offset) && defined(__bpf__)
> >     #define __bpf_ctx __attribute__((preserve_static_offset)) \
> >                       __attribute__((btf_decl_tag("preserve_static_offs=
et")))
> >     #else
> >     #define __bpf_ctx
> >     #endif
> >=20
>=20
> As macro definitions go, that's not that ridiculous ;-)

Fair enough :)

> If we add it to vmlinux.h, would be good to have a
>=20
> #ifdef BPF_NO_PRESERVE_STATIC_OFFSET
> #undef __bpf_ctx
> #define __bpf_ctx
> #endif
>=20
> ...too, just in case the user wanted to use CO-RE with any of the types
> covered. Thanks!

Will do.

Thanks,
Eduard.

