Return-Path: <bpf+bounces-56062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7D4A90D92
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 23:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9373B3BB40F
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 21:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFFF2356C1;
	Wed, 16 Apr 2025 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIq58mmU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A58B1B4235
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744837494; cv=none; b=F3Km2yfR2pGHHmbc8HsNGONdQLbPpvyEx5q5W6uYz+jnwgx2rkeLpL7N8DsmNAMI6pRxhnUJsI1VbJQmaFzhBqL8o/xxqe0pedYcAkPj3H25mB3WGRYO8eQC8lb2Syi7mkT76fX/fQvBrJVIeFwKxjv/uPWhmKokYfa1wCQdlJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744837494; c=relaxed/simple;
	bh=s3qntYlWYv09V3GU1fncSlfSUYFilGX2Qm29dGutxLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQ0vmPM81kOTOQfpogeFEbhOANQujxfKjrLTPe5oLwoozT6IDV67deLafF6Z77hqqc1FY/LzYiLw8h0kvFu16nCczYhAWiVf1CybRGdu9nRelcAHv0Du+EUeYTCInFzR3xQhXnR+V6/JSpZh2uOwcfgW/3uid5reD/zsSLkZ6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIq58mmU; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736b98acaadso41367b3a.1
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744837493; x=1745442293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mv2h8e+SabaETkO9ZGFkyS7OQKGEN3r9duojp5XaC8E=;
        b=gIq58mmU7DmnWP1kUgvvElWBn/Kmo1Z9rPmOko7tHdlcgwTSMV2x16Ho/8UfdJOAXX
         3AY6tuqyi554Q9ESQqqegVL7rnyz465N+eZ1NTJnKTzF9/c7URgSvQik3hnYl3AivYDH
         6uxLZxW/NPPubEqc5MEpHJi8f/WRrJBFfgDzxysStxSGZZyB5IdXf4XaE0YeS0wyf+Db
         4JVqZUeKuESDQzcA9/uqc6Mj1jqNddsGqcEHsHFN2fTvTa7Izvrdli6EOTJTPmUFed4r
         yx5O87XFAhvSIlwS2qsKGy3X5K6qvZfPW1vEfLeBV7sYphpZ4yUCGTRFVAgpBwPIgOjn
         QoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744837493; x=1745442293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mv2h8e+SabaETkO9ZGFkyS7OQKGEN3r9duojp5XaC8E=;
        b=IwIN6H4mNlb5l9xtSA+Bb30Yzlb7JwyhN2farNdILnZOFpLWZ3MRwujINGODXR1kTW
         CVmwbG+aEPUNzmNOcquaQh42Mz/AcwaOcja5kw0lUYz7YKTLHHo1ZBzu8ccV3ssqKuAY
         92x48b0e3qMG7ZcUBY+7cNywdv+PqAycl3klaldLKoGy7mpEeQGOhg+YOs7JHuTBIwdC
         79H8GlCqoODLB1mpl4xo9+DgMqWFQf033FfvUBxQm9Y1LlFf0PfLCg8YLPUwx5FxcbWB
         7zLrGcGqKroouyXl02Yv2uw5uqM9cJBy2/c91fV7/ZsNQ1FIEcK64WvScWzyVZf4BHtO
         uImg==
X-Gm-Message-State: AOJu0Yy25ZwAqV806BotpN1MB2lFO9P43HVS2hY7r9A3rVzM4KtLA0gD
	Nvzo8XpyUkx3NZ0F9OqOxobqFwcBSRjHxwKlJrEBMt1f/mw2UIlAlFUQn9WwUJ7e9ykWrX5KjBE
	60W4uH8BC2abx2VqH4hKVYyxynR8=
X-Gm-Gg: ASbGncubfZmeJ68d+mj0ea+vBY9HUuwpPDy7QmzKAv9Bns3/E0sHkjCeRSwxUwaL272
	+b/ARXXFDqD83hYKVh3TAr2tDedamZLLgynjI/psJ/lDAxFlGFbBkafCw/1BbukU/W4bBdX9Q0k
	6fZokyqzc3vthuY6Ymyfx0OZNi1PAX6W9+qv2+FA==
X-Google-Smtp-Source: AGHT+IESBH+jQ6iWheYQ4RD2D4/TBMlICI7TQ7QBduMgjarOmhZLfC8XKL9u1CNlOoTpf+/Lpwmi29p+U2Of2GCoCK0=
X-Received: by 2002:a05:6a00:1147:b0:736:d6da:8f9e with SMTP id
 d2e1a72fcca58-73c264c5756mr4456370b3a.0.1744837492717; Wed, 16 Apr 2025
 14:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414161443.1146103-1-memxor@gmail.com> <20250414161443.1146103-3-memxor@gmail.com>
In-Reply-To: <20250414161443.1146103-3-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 16 Apr 2025 14:04:39 -0700
X-Gm-Features: ATxdqUHIjWtPiDcSWeES6LOX1MKVXsB-8-suewWiZ8bkyEPSC6lUVeA-fsivyHs
Message-ID: <CAEf4BzaoiQ7-OETFL7aPvOnR0g3GKJfJdRPp=+C7ErD=y-R2bQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next/net v1 02/13] bpf: Compare dynptr_id in regsafe
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 9:14=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Now that PTR_TO_MEM can be invalidated due to skb going away, we must
> take care to be more careful in regsafe regarding state pruning. While
> ref_obj_id comparison will ensure that incorrect pruning is prevented,
> since we attach ref_obj_id of skb to the PTR_TO_MEM emanating from it,
> it is nonetheless clearer to also compare the dynptr_id as well.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a62dfab9aea6..7e09c4592038 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18426,6 +18426,8 @@ static bool regsafe(struct bpf_verifier_env *env,=
 struct bpf_reg_state *rold,
>                        range_within(rold, rcur) &&
>                        tnum_in(rold->var_off, rcur->var_off) &&
>                        check_ids(rold->id, rcur->id, idmap) &&
> +                      (base_type(rold->type) =3D=3D PTR_TO_MEM ?
> +                       check_ids(rold->dynptr_id, rcur->dynptr_id, idmap=
) : 1) &&
>                        check_ids(rold->ref_obj_id, rcur->ref_obj_id, idma=
p);

hm... shall we split out PTR_TO_MEM case instead of making this
not-so-simple condition even more not-so-simple? or (if people don't
like that idea), I'd rather have this special PTR_TO_MEM handling as a
separate if with return


>         case PTR_TO_PACKET_META:
>         case PTR_TO_PACKET:
> --
> 2.47.1
>

