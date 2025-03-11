Return-Path: <bpf+bounces-53848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C734A5CAE6
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 17:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE9617883F
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 16:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA12260A2D;
	Tue, 11 Mar 2025 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilkGrbY2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59F825FA12
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741710722; cv=none; b=VUt/t9gsWzvP0qOymn9qRCO+Ur3l40PQGFkUcFTY2tLe/92jb8sLBKMiY2bBZaIq4jwGse3LweCCpLrNQ5GGbErjIJJm+cplpePLd9NH3VEnLKMgd7W8jspA7eIBqT34tC3bVFAKUXf86eZgLSRFLPXnrxnvJy5cUrP/XfDhGuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741710722; c=relaxed/simple;
	bh=T5xaA45swJs6EZrND2dqM9NE+NGXrrhiZbQH5uZFtfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0J1ED9w+R7nOkiWJ1EYPD8LlHOtme4PYDaSm0leOv3vgD+Kkn3okZKrgzN1MYGXNtbtpsHx++FL8solMHMqSBKNPfm+FpwPb2FWLtTj/eYbnwR7KeFRi/Oz4vIk9PUO/xGOfOTs5K05V6wPe84NXjN2nSipHzmdnwa373v541c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilkGrbY2; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so988997866b.3
        for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 09:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741710719; x=1742315519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ATE8FIn1idDAbY9I/1HHOPz3uLeAU5hh8uGv8VJ6WE=;
        b=ilkGrbY2vf9tDeyXtY5ra+Es9ibaP4eJOEB5UXGxlrDRmE1iEPSNKsCdtv2vgECzMq
         JA8CTnU7olaKxHaIK1KHhE3M/YF+c02BXONlfJoidGayFB95P/V91Mmf4QuMNOyeX9do
         gHXiJf2k7ixbkC93gEt2w8T6MVlM2BnvZHX5wc298H5zDJqzjQCWKa24AF7uBtMvrOX0
         KKziWmsVcsBA8A0uXV2z1ZfhaRsGr1P6lZLMWCVHNMR/diA4ibTiKj8YIgRoBHWX/MhN
         En1HaHg05VVfmkRt1NCWaSR7kwRjVpdLRDCURK0YiR45CFvbLuzIkZSmTSZ7yF30joef
         MAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741710719; x=1742315519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ATE8FIn1idDAbY9I/1HHOPz3uLeAU5hh8uGv8VJ6WE=;
        b=OBmFH4xYyTEL7bJ0CRRV8BmTGJI1X4OzAsEu9eyqZHFV0NK5fjzCgi7hzW40FN3PEc
         ZxeIaQOodkT7PGGNtuGoaeqGVI2pglnHNYYdB6pWRxz8fb1jz2FXd+3RvFizvF3jEoHz
         yLXPtFwzI6uDoozUrr38G0gk+w2lLNkHdZhAVfw4aE39b98e5IxY4gD2EGE3AlX+h30n
         D1vqbLceIbUm+TFJfD6kIZ1km+9mLc1oYc27nhbfJavi/9iN+OnUunlYYR8VikjDUuIU
         /JLWaW9Kyw2bmDAqX6zIP2FfoHalB4gEhj/PIJgwIryq69KG18cpkhyXIY+oFGX+8Flo
         HKew==
X-Forwarded-Encrypted: i=1; AJvYcCXRpqArRpiXb4HfIuSGJuiegJD81kgBQfcodgIYns2s4UNRYtyX9IbeYZon4JMIhjJ9mbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXJ7UNnMy6ltcERKzdwzIWMpKnpahDxHXbu2djEbzXgsWjbgPp
	i0JQfEjmFye38JtNLjZ7zirB2jw2fsSmRZc+GEGPP3XBzXUkh8spva5SAH1sE9e9qOn67lpQocF
	xYKmEawrNc/6FHawnnlAmyLDfYqU=
X-Gm-Gg: ASbGncts/4gt2Zxb3pasmWvVHKUMMnBJ+pgJmUBKSBywqCno+7jSouK2v/CzyIEfe5u
	jrtU5oQ5xfyWylNq4kJ4KZG3UbYrfE5f+OqPcUYjdGOKhAUcB6EkBGKcPfwJiYzMxwHpdC+0DaL
	9AP8+K+O+l3VAZ8NpRGkcsKgoIDd+nOh/CJrhF
X-Google-Smtp-Source: AGHT+IFkUDv1TXYed/RKP7EkFBEvEatnsfHK4Q2cbOI7UioO+YULzaTLJUdD+t6lXIPwz/NXgcDX8uKZJYS2w3tMmyg=
X-Received: by 2002:a17:907:940a:b0:ac2:d1b2:72a with SMTP id
 a640c23a62f3a-ac2d1b20967mr126736866b.11.1741710718767; Tue, 11 Mar 2025
 09:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
 <20250222024427.30294-2-alexei.starovoitov@gmail.com> <oswrb2f2mx36l6f624hqjvx4lkjdi26xwfwux2wi2mlzmdmmf2@dpaodu372ldv>
 <20250311162059.BunTzxde@linutronix.de>
In-Reply-To: <20250311162059.BunTzxde@linutronix.de>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 11 Mar 2025 17:31:46 +0100
X-Gm-Features: AQ5f1JoMZWiUeXEqeX6qKRTppvEcZw0ZkhBYhuz300pzaSRVQo3WrdTMl602Aqs
Message-ID: <CAGudoHEaGXwS1OQT_Af5YA=uw_zmUYy_csQ3nqYA_np+SbQ-cQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 1/6] locking/local_lock: Introduce localtry_lock_t
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, andrii@kernel.org, 
	memxor@gmail.com, akpm@linux-foundation.org, peterz@infradead.org, 
	vbabka@suse.cz, rostedt@goodmis.org, houtao1@huawei.com, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, mhocko@suse.com, willy@infradead.org, 
	tglx@linutronix.de, jannh@google.com, tj@kernel.org, linux-mm@kvack.org, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 5:21=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-03-11 16:44:30 [+0100], Mateusz Guzik wrote:
> > On Fri, Feb 21, 2025 at 06:44:22PM -0800, Alexei Starovoitov wrote:
> > > +#define __localtry_lock(lock)                                      \
> > > +   do {                                                    \
> > > +           localtry_lock_t *lt;                            \
> > > +           preempt_disable();                              \
> > > +           lt =3D this_cpu_ptr(lock);                        \
> > > +           local_lock_acquire(&lt->llock);                 \
> > > +           WRITE_ONCE(lt->acquired, 1);                    \
> > > +   } while (0)
> >
> > I think these need compiler barriers.
> >
> > I checked with gcc docs (https://gcc.gnu.org/onlinedocs/gcc/Volatiles.h=
tml)
> > and found this as confirmation:
> > > Accesses to non-volatile objects are not ordered with respect to vola=
tile accesses.
> >
> > Unless the Linux kernel is built with some magic to render this moot(?)=
.
>
> You say we need a barrier() after the WRITE_ONCE()? If so, we need it in
> the whole file=E2=80=A6
>

I see the original local_lock machinery on the stock kernel works fine
as it expands to the preempt pair which has the appropriate fences. If
debug is added, the "locking" remains unaffected, but the debug state
might be bogus when looked at from the "wrong" context and adding the
compiler fences would trivially sort it out. I don't think it's a big
deal for *their* case, but patching that up should not raise any
eyebrows and may prevent eyebrows from going up later.

The machinery added in this patch does need the addition for
correctness in the base operation though.
--=20
Mateusz Guzik <mjguzik gmail.com>

