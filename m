Return-Path: <bpf+bounces-36154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0E8943434
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 18:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD671C21848
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 16:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87931BC077;
	Wed, 31 Jul 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzF6dXzG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C89179A7;
	Wed, 31 Jul 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722443774; cv=none; b=e6+e5pi9SrS84bXF55icD/zJCTIj1o44oIcoCcx2MuFtciIl+8GAwMfeB2F6Jcyp54V/XHUZ2YDWgzcF9KoCed8dGaXyKNt6NS/7NGBpa3Efskg90sPOaY+S4FlGcH71CkAha+wZsD8qb3hWJdIj5o9t9rq6FtZn7s+8TJZnoSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722443774; c=relaxed/simple;
	bh=JtlXxBjAOrEmosYKdJKz1Z66An9LhS14Bt8GI0T1VrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Igw3+5RUQdK6YpmVeWbcSn58AGB2tWW892C8wCCMI0JCc7l55sYCWHe+FJTgwFOUccwcsGLwyxdhRQtWYfEKlvLCT0mZKNNOhL58fitoXHkqr6B1bxP/cH2tX5xC4DDVWM3RYDpGaCeY3ac1zYmabV4wvGXBu8yO7mzEtzW1FzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzF6dXzG; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-2ef7fef3ccfso71202881fa.3;
        Wed, 31 Jul 2024 09:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722443771; x=1723048571; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tuopywArHoNKOcqOwUe7PWX86+bvoKcyGmrV8dXhWDQ=;
        b=dzF6dXzGVbG/B+brV0sw2GRHUV8fWI3owu6p2jlJLckUu8Iy6XsjzpbaqqoAoFTQHT
         78WekTSChHXaojHYtFmfhbXEMZrtfZauvo8lnlYo66NsJl49hsYX/r+l3zKbWs08Kq99
         ClX9/7yl4+g2p8zT81vu4geW9X+CDzfIVg/44ysxumjXPUNSkth2XZRZU+qL1miYOg9d
         GujSO5sJOiuzZk6p8oh+k5UWViOkAqJq5ofvYjqNBUEpBjfzig4h3WpXPy7aNqFd5ifi
         /Hhay1oGNggAmyL9Au2zlH+zecIPtaBeD/vuRju75yHqei5wNeJPCdheZTw04FHHCP4c
         wDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722443771; x=1723048571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tuopywArHoNKOcqOwUe7PWX86+bvoKcyGmrV8dXhWDQ=;
        b=uOBX/lIJBA9nCaZPQ+BdoqWSFAl9p/FM3EUGvnWiQuboKfaM+6Qq8Ckv2ctCoTtetG
         t8hIcX5kR5T89caqKQYY6bsku0bFvOCim1qcSQMjZT5fJs15WrygJpBXE5IUT8RNLjfd
         kUrY6GLtw+ECPMkoLoPS15DkgwWke9hQk+WGWfXE4jWpLpFC+Mgnc2tu4bqLQwEZs66D
         E4r+G3eGhR3AhmtgRQpqQpnCR7bt6Pr4IFb07y+THuBzhGlPWSscelym1wYqLtjmuacN
         DWNbLeJ558ZJVtbziLEwoQITgt279lbJVAeWpfeI8SlJcBX2tO1CQr0ZvZTtBhyjjfYm
         aDUA==
X-Forwarded-Encrypted: i=1; AJvYcCU48GbGciks/DnsQ+fBrK8/G04XPsGe/6Psg9QJZuiJbdunbE07EmDnvFnvlJ06/EkrRhLXvAE8UkLVibY3p7thzcG+eJkouH7VJ2xoqEe92uiUvcvd1nkwBYwir+yvL2az+iMAaum5xQSjlCu+occj4W8buIoSNWVr
X-Gm-Message-State: AOJu0Yy00j+AJsw2ojPoItV9dvK2MMQ3sflU0clB9++Ks28nqrRWCAQZ
	9nlkjGn8tEPPUrILPLLPVM5w+LhGIHQ69VLCtrzUCc4L12If9g7tDo6fFjRpcjBdBF6zTBcZUSt
	bT9B4KZ3Ahbzl1D2HzIvIYM8yeCo=
X-Google-Smtp-Source: AGHT+IGZdej5B/wigRaTg07dksx8Nuf3XrDB7Knj3gGQirPCsvkxtbl6vRxd0f9yMpdWKrvmRbiuXnUoF1iuMGJwVzE=
X-Received: by 2002:a2e:2e0c:0:b0:2ef:1b64:5319 with SMTP id
 38308e7fff4ca-2f12ee04091mr100727311fa.11.1722443770292; Wed, 31 Jul 2024
 09:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <AM6PR03MB58488FA2AC1D67328C26167399A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAP01T74pq7pozpMi_LJUA8wehjpATMR3oM4vj7HHxohBPb0LbA@mail.gmail.com> <AM6PR03MB5848CA39CB4B7A4397D380B099B12@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5848CA39CB4B7A4397D380B099B12@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 31 Jul 2024 18:35:33 +0200
Message-ID: <CAP01T75ZUE04VKFrjL=uW-j+9DLF6OnHuzGBWjfjf4zGnuq7aQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next RESEND 03/16] bpf: Improve bpf kfuncs pointer
 arguments chain of trust
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, andrii@kernel.org, avagin@gmail.com, 
	snorcht@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jul 2024 at 15:29, Juntong Deng <juntong.deng@outlook.com> wrote:
>
> On 7/23/24 01:20, Kumar Kartikeya Dwivedi wrote:
> > On Thu, 11 Jul 2024 at 13:26, Juntong Deng <juntong.deng@outlook.com> wrote:
> >>
> >> [...]
> >>
> >> 2. sk_write_queue in struct sock
> >> sk_write_queue is a struct member in struct sock, not a pointer
> >> member, so we cannot use the guaranteed valid nested pointer method
> >> to get a valid pointer to sk_write_queue.
> >
> > I think Matt recently had a patch addressing this issue:
> > https://lore.kernel.org/bpf/20240709210939.1544011-1-mattbobrowski@google.com/
> > I believe that should resolve this one (as far as passing them into
> > KF_TRUSTED_ARGS kfuncs is concerned atleast).
> >
>
> Thanks for letting me know.
>
> I tested it and it works well in most cases, but there are a few cases
> that are not fully resolved.
>
> Yes, the verifier has relaxed the constraint on non-zero offset
> pointers, but the type of the pointer does not change.
>
> This means that passing non-zero offset pointers as arguments to kfuncs
> with KF_ACQUIRE will be rejected by the verifier because KF_ACQUIRE
> requires strict type match and casting cannot be used.
>
> An example, bpf_skb_peek_tail:
>
> # ; struct sk_buff *skb = bpf_skb_peek_tail(head);
> @ test_restore_udp_socket.bpf.c:209
>
> # 75: (bf) r1 = r2                      ;
> frame2: R1_w=ptr_sock(ref_obj_id=6,off=168)
> R2=ptr_sock(ref_obj_id=6,off=168) refs=4,6
>
> # 76: (85) call bpf_skb_peek_tail#101113
> # kernel function bpf_skb_peek_tail args#0 expected pointer to
> STRUCT sk_buff_head but R1 has a pointer to STRUCT sock
>
> Should we relax the strict type-matching constraint on non-zero offset
> pointers when used as arguments to kfuncs with KF_ACQUIRE?
>

Yes, I think it makes sense (on surface, though it requires some
deliberation, can do it over the exact code).
As long as we prevent special cases through existing
btf_type_ids_nocast_alias, it should be ok.
Please send a separate patch for this, and include selftests
exercising corner cases.

>
> In addition, this method is not portable (such as &task->cpus_mask),
> and the offset of the member will change once a new structure member
> is added, or an old structure member is removed.

This should be handled by BPF CO-RE. A lot of selftests would fail if
this didn't work.
As long as the struct is annotated as __attribute__((preserve_access_index)).

>
> [...]

