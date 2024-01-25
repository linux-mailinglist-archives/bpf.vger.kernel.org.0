Return-Path: <bpf+bounces-20329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321EE83C457
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 15:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927011F24806
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 14:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2DE63112;
	Thu, 25 Jan 2024 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAoPe23d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C067629F6
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191720; cv=none; b=eS0+c+YzH5pW7NP3Zg7f0WVG/Yh0wCNTaI6prQ/F8uMceBOSl+0c7ZwNPIQeHlw/LxxRZX+GIbfzDYEtlzuwo5kVexLPrAQOqC9AI3zU1XESE3k5PlTk1c9LbjSpJz8uO5twrKO4XRj+HyTRlAdPrhpR6cEqqgZWEb0MHVN/uDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191720; c=relaxed/simple;
	bh=suc4CkXXnDGNYjZLa29PbyRmLJsHpSA0LijZsCX8y40=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eRNqGsr9EN0dZzvJL4LoPM/Kb9V0vuK14vYGrzMq3EzQOvasN4fRGItB3ooTteQQIJe40Hwk45dO6W0JKMHxuiLep9M64xLkUUkSkWdqT6ZZPEKVstkxcTa387EcBwPakZvmz78SVBGE89ouNxMIgIZ4irCNNxkGSn58qYQMmtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAoPe23d; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2e0be86878so151716866b.1
        for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 06:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706191717; x=1706796517; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jRtfW31apD4bx9+ppSTvwWXN6EqEeOV4WgmowxxGQnQ=;
        b=XAoPe23dIyQhs4EhF22p4fHKPdcECX7vH8OFcu5nlcyZwAQWyL3X2gi/8os/W9o8X/
         4Mj7Cq+O4rgMt9qjlGAXvk12NIEsZRLnE+PgE7TdfUsgNH5fupQfBugPSbEbsB3UhR9c
         oN+RRgWwdKyZi2dxgfwxn4+uRVbnz42plc5G/9bBMahmOuG5C/wI7XQHGcg589Sbvj3D
         H6nkxAXrACLheO49mDoEQq9uFsjBBsSG3bAd2o4eHcoCpH+FN7J9VBDIoja6EBkFcsHZ
         XClNE8dpwiaa4kXj4sJ+xc6nFdWZaZputaSaBqXBN1fl0Nfd2slLEB90Xm8mCFmOAyTS
         hdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706191717; x=1706796517;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRtfW31apD4bx9+ppSTvwWXN6EqEeOV4WgmowxxGQnQ=;
        b=NnuLTXM3vU2N6XS/96N7B9laKYOfADzrSJhmcUXPOwTcTTbX9tdKJcVFq7FIH0RM+V
         09ji8je2/YRjA96OoePlYSiCsSMcOsSIXUVleoeiKabgm0Y5KxtYTak3HctmYbdnMwAk
         Q/DLBGcutyAeSQFQbNWtnR2vaq+XXWTi5JStSnpJveLEPPFuBydAYzJENgnelvNH18Mb
         B0e0iJ0wrtLgIM6cFkBMsvUmYeVWeGjYEJUDlUb4Ps5xpPtst/2+mHWq0hPtzXBxJcJA
         tpIsPM3qxGTyx7FwdgW7fvqqWES3kWRbrSdwSMVn03vpJ9LZIq+kGznJ8Nh4ewWdYm4G
         I8Sw==
X-Gm-Message-State: AOJu0YweOrTh0zmaVMLgt2reQXghDvcco1aJC3gV8SVLHbGWUhgcvtA6
	JE6y2vOoTRlKMd028YA/TlkCofmBl0dmdHExcQQ2dJF5GpSX0fvb
X-Google-Smtp-Source: AGHT+IFqtWFTv96UMaJ/gSXGmd+ILFj5hhEHNxOwJ3YOdHKEPMHWsw4Vq43/Y+MOW3yaiqmk0jQx6A==
X-Received: by 2002:a17:906:3a88:b0:a28:c04e:315b with SMTP id y8-20020a1709063a8800b00a28c04e315bmr1105460ejd.13.1706191716692;
        Thu, 25 Jan 2024 06:08:36 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id r22-20020a1709067fd600b00a274f3396a0sm1070596ejs.145.2024.01.25.06.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:08:36 -0800 (PST)
Message-ID: <c01d6d3faf499716eeee049a32b2eca4afdc23b3.camel@gmail.com>
Subject: Re: Anonymous struct types in parameter lists in BPF selftests
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yhs@meta.com>, david.faust@oracle.com, 
	cupertino.miranda@oracle.com, Andrii Nakryiko <andriin@fb.com>
Date: Thu, 25 Jan 2024 16:08:34 +0200
In-Reply-To: <875xzhzm2o.fsf@oracle.com>
References: <875xzhzm2o.fsf@oracle.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-25 at 12:31 +0100, Jose E. Marchesi wrote:
[...]
> However, btf_dump_test_case_syntax.c explicitly tests the dumping of a C
> function like the above:
>=20
>  * - `fn_ptr2_t`: function, taking anonymous struct as a first arg and po=
inter
>  *   to a function, that takes int and returns int, as a second arg; retu=
rning
>  *   a pointer to a const pointer to a char. Equivalent to:
>  *	typedef struct { int a; } s_t;
>  *	typedef int (*fn_t)(int);
>  *	typedef char * const * (*fn_ptr2_t)(s_t, fn_t);
>=20
> the function being:
>=20
>   typedef char * const * (*fn_ptr2_t)(struct {
>   	int a;
>   }, int (*)(int));
>=20
> which is not really equivalent to the above because one is an anonymous
> struct type, the other is named, and also the scope issue described
> above.
>=20
> That makes me wonder, since this is testing the C generation from BTF,
> what motivated this particular test?  Is there some particular code in
> the kernel (or anywhere else) that uses anonymous struct types defined
> in parameter lists?  If so, how are these functions used?

fwiw, I can't find any FUNC_PROTO in test kernel BTF that have
anonymous struct or pointer to anonymous struct as their parameter.

