Return-Path: <bpf+bounces-66937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 044BFB3B297
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 07:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9EE24E3274
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 05:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E460212567;
	Fri, 29 Aug 2025 05:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKGMxngP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFEC1401B;
	Fri, 29 Aug 2025 05:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445804; cv=none; b=dXIKNj2FpHzVrhDoOxDI7DzXvYkzYHPfy6RSW2UI6tqgcVT3xhyYAn9b3fIu1Rm6oSklyFD8XexWnlSyPiyQiNElmCA1qhDMnr2td2g9I+p0DinYdYy+PGmBFe6TmB1SvgxM+PAYi8YpPfSKNm7YTQhfxE5ziiuW/2QWc7Zj9Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445804; c=relaxed/simple;
	bh=MK16zQXWmy+SczHIIAdHA2lqBpZuzlXe0LLX9PF+ePM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHLYpTJSQoIcut0G8xSgt15BkcYxOq92EbRfNY7jRhBXkX73qj6nD5sOJltPLX5U9tVEuldp1L/okpoEJFgCtdn0BSqVcv1Y11BKJp2bn2IJVYdbWgZ/P4CE7RZWXSozgZDiXgbiqt1V0KEsHnMys4QNLoJcRkaVHIg3GKFD4I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKGMxngP; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-70dfcc589a6so12862846d6.2;
        Thu, 28 Aug 2025 22:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756445801; x=1757050601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7ABgTxwsaGc4hfk3OGe0GkOSvaX5N8CZX+Bz0AJlVE=;
        b=bKGMxngPNnmo2/FQIR49a3Uq8N1SD+9LOtv8LCkztDgC4TTxZBmXbWt4sbWlmWWOUy
         vd+iVS56hmOcmZv5tSQYy5xj3VOTXfzVIMqgglWzn9YDfkX+Meizgx16nljDSmkhjq0h
         hsmw8qoVV3ZH4ObQQhuO9/XMIGuGLake3M8TCxitDU1//leGBZVKAZbx9S0C0rhHxpHo
         1WNw+6pPyVdQhprr4iV0vjPUYWP4nH5uZBYSw8by9kFzJU0y3/87sVk9FQ0oAdWI/JaQ
         EQRnCYmTZXAsi6ZWeTklVkskP+hfYb1CjxB8+GqKlLlXs9RXpoBoVt7c1WFysKgWzpoE
         hiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756445801; x=1757050601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7ABgTxwsaGc4hfk3OGe0GkOSvaX5N8CZX+Bz0AJlVE=;
        b=Y42ulEhdbke3Cvv7iSiLzPVkArQPfYmRye07Nlw1r6SryQc8Hhv5UdI48U/yKm0lT+
         YkXLjClMnBsGQPbTOgb968TgUOtQt7qqp9Qwc7KVo23LtJmmM1mk4WE44kbt1hEayF8T
         8Pwd4d0MTTLPTI+wCbAx2QT46TDbI43TjUqmFYi3Z8v53cHzGzGhkyuSbnke29Zusb19
         uLazOkmgM8JQSDKTlCJUKD0pai+eVKGqssD3sJ9iMn6/RxGPRrNUCy0V71Qniao9ZX0Z
         dJq1YYTL8ZfLvhsTnzAPZHTLF6miMxn7fx3QiMMGdwvQPLz1mJEOz3GDCqeAIh09bocK
         s2Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWJIlWKITuTyYq6n6mC6vLrEbzeJeoLmqxhlAmTkMKYxGDbTGOMCPTqWcN9Oqq+kK4VXtE=@vger.kernel.org, AJvYcCWQGh0Byqv1HbEAMg/9GX+WbyFonGfvRtKNETW+JFuZp1p0DE5ql9seu1XhaXYlyjG5mNdX6kSueamu@vger.kernel.org
X-Gm-Message-State: AOJu0YzsmiCltRJr7e6e+PlI1dmovkldDptB9Xqg7zuzSW+4B2gWVXUM
	zJqpwyhVo6BTvzEYGrUPseiUDUlaUCdkC8bPr/HgYcWYac9XiVyG0oprmOv4/wVEiEFtm5Spss8
	NdxGwsLHcOUaPVfDVEAms0twCsWnV9Fg=
X-Gm-Gg: ASbGncuLdjFcsa/xh5jt2QBpDCeafjq3gueHODb0NXyOxhe+j54l8JyYo1aj2IjHCy3
	kp295Mp1CaxoE5TlP+Org1uSxmm5jvAT3pFPjS9QArwzgldk+Wq1UwO0wwPS2rKhNQXdTxsEkUq
	+FSwGVkh13XFpzwLty8L1nsKK+ZkmAF8x5uBov9/AU6tIH3NHZxeZKR1nJ1Y/umbpOvudcr0wbg
	ypz1HtZHwH+psC9y98fxfCagAzQmRvKqHPtOQmU
X-Google-Smtp-Source: AGHT+IGq8OntLZha2E+RHRzjfT2kevRfQDBROpREspWyrgfBnKhulrj6jbFwS3r1qYQLbJVZUxHzKt/hQ0CwFQvkx/g=
X-Received: by 2002:a05:6214:18f4:b0:70d:eec2:cff2 with SMTP id
 6a1803df08f44-70deec2d983mr46345376d6.49.1756445801302; Thu, 28 Aug 2025
 22:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-1-laoar.shao@gmail.com> <20250826071948.2618-2-laoar.shao@gmail.com>
 <CAGsJ_4wa0gC7FQmUP9HQxbacheKFRCqMbnfXwugeyOzhOS4McA@mail.gmail.com>
In-Reply-To: <CAGsJ_4wa0gC7FQmUP9HQxbacheKFRCqMbnfXwugeyOzhOS4McA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 29 Aug 2025 13:36:05 +0800
X-Gm-Features: Ac12FXzur8PyRFGmxf0SsAofO8ehtJn06i2WVKKAJDTji0n-pHUGNLV1GMbF8dk
Message-ID: <CALOAHbApA9oUR2f27=HnsJASekTR+4tiBaXu1opy=CgLmogNWQ@mail.gmail.com>
Subject: Re: [PATCH v6 mm-new 01/10] mm: thp: add support for BPF based THP
 order selection
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com, 
	rientjes@google.com, corbet@lwn.net, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 12:56=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Tue, Aug 26, 2025 at 3:43=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> [...]
>
> > @@ -4510,13 +4510,18 @@ static struct folio *alloc_swap_folio(struct vm=
_fault *vmf)
> >         if (!zswap_never_enabled())
> >                 goto fallback;
> >
> > +       suggested_orders =3D get_suggested_order(vma->vm_mm, vma, vma->=
vm_flags,
> > +                                              TVA_PAGEFAULT,
> > +                                              BIT(PMD_ORDER) - 1);
>
> Can we separate this case from the normal anonymous page faults below?
> We=E2=80=99ve observed that swapping in large folios can lead to more
> swap thrashing for some workloads- e.g. kernel build. Consequently,
> some workloads
> might prefer swapping in smaller folios than those allocated by
> alloc_anon_folio().

make sense to me.
Perhaps we can add a new tva_type such as TVA_SWAP for this case.

--=20
Regards
Yafang

