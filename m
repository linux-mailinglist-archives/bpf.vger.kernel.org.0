Return-Path: <bpf+bounces-61318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A491AE51F8
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 23:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB58188988B
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 21:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A11221FC7;
	Mon, 23 Jun 2025 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wh+Kpigk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC01621D3DD
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 21:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714732; cv=none; b=KkDrwdtF19qpuRqPL0F+u2nBFPzmSp8WblKelDFgKkrTP0z/OWQcVrM2iP+7u+KaTVUXzLwV03S5S1cU1Ng8h8pDOo5BeNhKIVIxrC/h0qcd0Umoe/NJWnFcUCAO3uYb19lPTp10+91CORM2vIfl2oUxVOcoEtMlTODwQXSIn8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714732; c=relaxed/simple;
	bh=VCgdxKthgJw5KyGq6qm9Kc59FtDqUGVeWw/ueoFN9M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZUr43g1f76XBzoOhB/h178HJMdYMseTzRq7PsBcs2DHMNvz/vyEGX9Iodre9XfnPiq/izRHpztYGsUvsx9gcKu1kfFZFzYpdEm6jfc/WGf2KHBHd8Jd/Jir6fJ5FqYQC6BTsyBWBPg00SYK8I46w/fSaGHO2HdqpIPrmzZ7nlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wh+Kpigk; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b31d578e774so3296571a12.1
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 14:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750714727; x=1751319527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCgdxKthgJw5KyGq6qm9Kc59FtDqUGVeWw/ueoFN9M4=;
        b=Wh+KpigkRZfNDAKCsYkLNc0MOEE8JlSw0oQeY0C7zLN4mrxuX/mDSG9FRcNksMjS7W
         s5N3VfTdtolP6wp2eow2n5/Ct5ZtseVQFhAaa96z2JL9DFpee67A97kFmBvOqQd6v+8f
         yvUA/hmrHFJexGDHzM8f9Nq8HwoYH9HoEbNcbk299fI7ZTlHyuOdtl2sk7Fb3ft8B4CV
         R7cXOk6UachbCAxmjt1k8+6nSpCqAQkYzS/5gjar0mrGFzswJPqWPxCHdH58IZ+sMQC8
         w53TsvGdVorVStpX0LqV3+GDoILk5RsAP+I2wu7kANjystjIrJHhSRtw8PN9rTm4KhlF
         6RZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750714727; x=1751319527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCgdxKthgJw5KyGq6qm9Kc59FtDqUGVeWw/ueoFN9M4=;
        b=mD8KlhJkK09G+KpPXfkB+cfq0gIWK/wNJSSbNdfTgLNNLg5Z5wM4ujzCpDldDtHQJR
         9fNHTB7i/Ilky2rgim319EoEYY6uvMTWwS0t+ZAkUbrnNuiIeib7g1jiGts82kw0mobp
         X4TRjT/ZM9dDLqxdr6cQe3xdd8PDqPzsLAO4si+ICPE5qmqFOu5U5Q483dlQvPoJ+s+I
         JAozyont4cwxrLAPeRUQE7mU/Qgrv0ylYarXQpt45WYAMCIfG96OalZTTx8RA2txsuOa
         cPCN/nQr1u+iyFWBWZGCr34plzUNVQCr//Uz47rK+8YY+yaTQdm1lYVMydq2mADvuouT
         EzWA==
X-Forwarded-Encrypted: i=1; AJvYcCVeAcr2i1N24zo1VGcYeacXZYtWV3n4R9V11UDkpsqvlwHa+hx2Kel2bw2EarS1zWRI/Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw26lmQil37hpVbX+3jP0oUz7NsywXv054ubwOrt1CRQR3VbQU
	4f03pelRcYpTYrvwntFhPhsT/HrpnNaiY6pCzSGd6RZ+Vgmixr34feRSzeQ49TQoglx450XZD0q
	e1H9QthzCBG+GlxRuGAnVl/WmIEQLSoE=
X-Gm-Gg: ASbGncvxr/xZP8SPG+SxATQaw50HGLmR7N8mbZsNUH2bJBn2UVo6bTBybWvr3uWLg9D
	SLxEP4roWwjAiJyS0/FTyCpZydrWEsh+JLNJhf+4gwV013nS1Pvs4wys5nQLmOgLe2Iql9ZCa2b
	oppogyEXqOTtjLWdSwsiBd87ElinetpidUf0ni3iR69H0C1wwpsbJoLSEt6XU=
X-Google-Smtp-Source: AGHT+IEBPt1zSl7akQk8HiYOi0nLTLLYUiDxarhXsnfF7LwPuDBfh5Vw1gBE87dOo7L2WAFh4gspSq+ohlc8nf/fB6s=
X-Received: by 2002:a17:90b:17c5:b0:302:fc48:4f0a with SMTP id
 98e67ed59e1d1-315cca43ceamr1628545a91.0.1750714727092; Mon, 23 Jun 2025
 14:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618223310.3684760-1-isolodrai@meta.com> <b35ce32e-a5e7-4589-ab16-d931194a32bb@gmail.com>
 <45390c6c-bd2a-4962-8222-1ad346f9908c@linux.dev> <7852f30ba177dc5b811bb0840ca0f301df2a8b58.camel@gmail.com>
 <7e7e4056-e2b8-41a5-a6b2-a2fbe0a94f4c@linux.dev> <50c2f252620107b6fa6642e281a91db444b032c5.camel@gmail.com>
 <c8540b80-2903-4e31-a4ee-93278475d232@linux.dev> <51cbadb3cabbb0b2479e5087618e1015c25b4f26.camel@gmail.com>
 <a64d331ff474e9896c7d6c071e027c34fc8c2966.camel@gmail.com>
In-Reply-To: <a64d331ff474e9896c7d6c071e027c34fc8c2966.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 23 Jun 2025 14:38:34 -0700
X-Gm-Features: AX0GCFvxEc7q9QBoPKj2ReeBm3Jnrnh-P6HYlOFdxEexUc5ZizrgwpPVQ3f8a9I
Message-ID: <CAEf4BzYZBMOexPSM9=utpn22W=XMsztiE_X9AxO9CSSb1yv7LA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_dynptr_memset() kfunc
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	andrii@kernel.org, bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	mykolal@fb.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 11:17=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Thu, 2025-06-19 at 11:13 -0700, Eduard Zingerman wrote:
>
> [...]
>
> > Also, what's the plan if you'd like to memset only a fragment of the
> > memory pointed-to by dynptr?
>
> Oh, I see, there is bpf_dynptr_adjust(), sorry for the noise.
>

Even though we do have bpf_dynptr_adjust() for maximum generality and
flexibility, for most dynptr-based APIs we try to pass also additional
offset into dynptr to avoid unnecessary overhead. So it's not a bad
idea to add this to bpf_memset(), IMO.

bpf_memset(struct bpf_dynptr *dptr, u32 off, u8 val, u32 n) ?

a bit unfortunate that we have 3 integers that you need to be careful
to not swap accidentally, but even with just val and n you'd have to
be careful. For other APIs we normally have offset to follow dynptr
pointer, so hopefully this arrangement won't that surprising.

Thoughts?

