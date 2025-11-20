Return-Path: <bpf+bounces-75154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85681C73990
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 12:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 251B6357DD5
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 10:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C8332D7DE;
	Thu, 20 Nov 2025 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4Lks7VL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7362E3128CF
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636208; cv=none; b=bv+D6hGq+K9J7WGIoWu72Q54C3q50rUU/fC4d1SqQkHeHu//pzDe2ja6bxh5X6YPUY+yzNOZR9KCGOTpY3kqKeZCxPtwKnH3pqPkLACxjneFgnRp9veWbWPqh71A4WrWZuTwtvzxcIDjyf3U9uqO2RHU6KagE3h52G4wj++6UHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636208; c=relaxed/simple;
	bh=RLKCYMJbWg3wVaXkn6Ql8g5NF9XDZ0jFGbj0sgjqjQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDHfmD3TuLyutU+LfLN+EQSTgLLTrBdWBAai6U5ayMCYASWcFRflVEcr6YgOcb+9n670jqUH3Y+572fVZRzo7Z7ypfb/hspuKlvhTeEhFqHCm0Ra9ODJldUmIpERZjT3lHlIg6aN/TF3zjNHAxEudCzJFaDmOyzDT8NC8YGlQIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4Lks7VL; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-434709e7cc9so3839085ab.1
        for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 02:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763636205; x=1764241005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8odtBE8sLdskhW90dhEfIJ46nBmMlbNnS8SSIbrjUU=;
        b=H4Lks7VLTiSnnBQbPv/Cy4Ypoot2yZQ6K5Hz2hxuctpSH+g88wXP7bw+eQ4Sl9ks+S
         18bl4sAaYaY2VZL3UZfSo8hSvlgWIIwvth7W/jvHdBbYDLMErg/ylxYkT5zp0r/kNmuG
         EPL8cOm8JzNr5l6XLONpDB4SlsTJAVD0VBZLhtjaYleGWr+acRqA2jvdz5JwBo5H7m2l
         ao6EQO+vaX3aPCS0dGq/44CuZVXW3UC9grGwILLwvZeJzsisrzWsdxdaDWvcLf6DR2YB
         pXXcjH0P+n+s6OAvhhMebrUmv26QHIt3AjK7t3RfxYkAwfvYp3WmdFWEBj6wENTeToB2
         /jww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763636205; x=1764241005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U8odtBE8sLdskhW90dhEfIJ46nBmMlbNnS8SSIbrjUU=;
        b=pAmaMYhmbBaoHBfVA7WXw5DuyLstfpslfjwIdwv9Gmja0XDLKP1ukrvnqp+7lJUOlX
         vUaCFNelUaYB3dn73iKxeRMU4AOt92JN5/E1GVWuY07lsdIL5Fo+S3qrmnr5RnSqcJTy
         SCSRDAVbSxsRag1ht8wKu2OvJ4Z3nT4zeDKgmUSp8kHoL0Qa2ZWFUyLhLsaZ2uKiAdTV
         hZfVMfBKwzCJwB2Nh8UlfymYxGjKhugdqd4m7QYwQ2zaBeenwwkv7ugzUXkCI/J5vpGM
         lSbm+EE+WWq/3+lAdIhFvlkapdGro031PITG/dag55eDnBBDybVuCq8aQpmzzlMKb4uE
         ipMg==
X-Forwarded-Encrypted: i=1; AJvYcCWu1xCP4EJMQIgS+lvV8YBq4VEFbKhE7VQCMGOrHN4F+JTlqwk5V7MOPNH5euKxT/m9m90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxul798R/nnCisgNk/tmMbSeF0VxC5eVKLrBEODzpS9TVP3argD
	fPh16ZUBvQTaRjjq+xdDxoM3LQJwZtCebHx7byqnYXNzKmXGxzK6YSrS5a3mAQ65exY6q5BxbKu
	py+xUi6XJHvDCUCMySH5N+NAgiYgdg3VEFg==
X-Gm-Gg: ASbGncu7mLbkTA1janP6SY62RwuoiaUQCQAnn97iA1sbSIPVzesywQ95RoNMwdyvFK8
	J75b8ghFY1sl9gBJusVFmam7khAJvt0Se8zOi1c32QTW0IXdNenlkZRpdln0kva+5X9fBOqEIf8
	6En3TY2Lv1ZFol4Qt1kQ7ydXwlifAE7Jo9mnmYP8DyG8MgSsOusfwatqwOliTvqnwgSzoEYvhxv
	DfButCzx1hL7aFq3UVI2wPFyVQhivrVNuTYxyeCbuPWq3U04/syPGTrUZ3o/Ae+kH5VNn69Bawx
	hQJPwcLADA==
X-Google-Smtp-Source: AGHT+IFC3af3YGcUtMR/2f7wapKqrCIPzgJpAoVyr2np7EEI0rnydUEP++AYKyhGpO6OtTUwvh6l4b7SBgVBlRNpRU4=
X-Received: by 2002:a05:6e02:16c7:b0:433:7b4f:f8c3 with SMTP id
 e9e14a558f8ab-435b1fdfd26mr7710405ab.17.1763636205548; Thu, 20 Nov 2025
 02:56:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118124807.3229-1-fmancera@suse.de> <CAL+tcoCthXqJS=z3-HhMSn3nfGzrqt8co3jKru-=YX0iJ2Yd6w@mail.gmail.com>
 <c7fb0c73-12e9-4a6d-94d9-65f7fc9514ce@suse.de>
In-Reply-To: <c7fb0c73-12e9-4a6d-94d9-65f7fc9514ce@suse.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 20 Nov 2025 18:56:09 +0800
X-Gm-Features: AWmQ_bmwdP2Ky1CmR0H_rapr3ryMgjeUXCwnY8pfBLuLZAXGnWN_6Wy6iRoqC-U
Message-ID: <CAL+tcoC3ZkhV5d7rStShghVFdmGDx9pb13S4ZUqSo9KmrJesLg@mail.gmail.com>
Subject: Re: [PATCH net v4] xsk: avoid data corruption on cq descriptor number
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, csmate@nop.hu, maciej.fijalkowski@intel.com, 
	bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 5:06=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
>
>
> On 11/20/25 4:07 AM, Jason Xing wrote:
> > On Tue, Nov 18, 2025 at 8:48=E2=80=AFPM Fernando Fernandez Mancera
> > <fmancera@suse.de> wrote:
> [...]>> @@ -828,11 +840,20 @@ static struct sk_buff
> *xsk_build_skb(struct xdp_sock *xs,
> >>                                  goto free_err;
> >>                          }
> >>
> >> -                       xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_=
cache, GFP_KERNEL);
> >> -                       if (!xsk_addr) {
> >> -                               __free_page(page);
> >> -                               err =3D -ENOMEM;
> >> -                               goto free_err;
> >> +                       if (xsk_skb_destructor_is_addr(skb)) {
> >> +                               xsk_addr =3D kmem_cache_zalloc(xsk_tx_=
generic_cache,
> >> +                                                            GFP_KERNE=
L);
> >> +                               if (!xsk_addr) {
> >> +                                       __free_page(page);
> >> +                                       err =3D -ENOMEM;
> >> +                                       goto free_err;
> >> +                               }
> >> +
> >> +                               xsk_addr->num_descs =3D 1;
> >> +                               xsk_addr->addrs[0] =3D xsk_skb_destruc=
tor_get_addr(skb);
> >> +                               skb_shinfo(skb)->destructor_arg =3D (v=
oid *)xsk_addr;
> >> +                       } else {
> >> +                               xsk_addr =3D (struct xsk_addrs *)skb_s=
hinfo(skb)->destructor_arg;
> >>                          }
> >>
> >>                          vaddr =3D kmap_local_page(page);
> >> @@ -842,13 +863,11 @@ static struct sk_buff *xsk_build_skb(struct xdp_=
sock *xs,
> >>                          skb_add_rx_frag(skb, nr_frags, page, 0, len, =
PAGE_SIZE);
> >>                          refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc=
);
> >>
> >> -                       xsk_addr->addr =3D desc->addr;
> >> -                       list_add_tail(&xsk_addr->addr_node, &XSKCB(skb=
)->addrs_list);
> >> +                       xsk_addr->addrs[xsk_addr->num_descs] =3D desc-=
>addr;
> >> +                       xsk_addr->num_descs++;
> >
> > Wait, it's too late to increment it... Please find below.
> >
> >>                  }
> >>          }
> >>
> >> -       xsk_inc_num_desc(skb);
> >> -
>
>
>
> >>          return skb;
> >>
> >>   free_err:
> >> @@ -857,7 +876,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_so=
ck *xs,
> >>
> >>          if (err =3D=3D -EOVERFLOW) {
> >>                  /* Drop the packet */
> >> -               xsk_inc_num_desc(xs->skb);
> >
> > Why did you remove this line? The error can occur in the above hidden
> > snippet[1] without IFF_TX_SKB_NO_LINEAR setting and then we will fail
> > to increment it by one.
> >
> >
> That is a good catch. Let me fix this logic.. I missed that the
> -EOVERFLOW is returned in different moments for xsk_build_skb_zerocopy()
> and xsk_build_skb(). Keeping the increment logic as it was it is better.

Right. Thanks!

My new solution based on net-next with your patch is ready now :)

Thanks,
Jason

