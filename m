Return-Path: <bpf+bounces-75671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F410C90869
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 02:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 890DD34F0EA
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 01:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8E11FC0EF;
	Fri, 28 Nov 2025 01:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Owfm+QZ1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC791149C7B
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 01:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764294328; cv=none; b=aTU+AvaJZjHj4GrqgnNV04mdK7Ecw4P9iWeIuN5wb8lASPGIFUaCAJg/dzZP6zplU2czcLCJoY08pLDw6HxHZzOBSPJIU/79ACuJf3zj88dMwqWtLmseHQO7ajEtKeQp3ixUPBCJIQVuPQaoxFsrO5IWpZft+2iIRioWBZY4hcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764294328; c=relaxed/simple;
	bh=w0zib1ythtvHXUMpM2pXhvYsEPH0d3PAQM8wUU6Yai0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXjddo9TKkQExpiaVc7viSIYfzSH1wudDOfS5iIaB4F73pk0zzVTdyOqPOwH4wpSWxy0OxkbVg6aN10LKWgejCTPoMlAqDTrCDkMG7iUwU12pRVd3MzH1nrzlxpRdQUhJGRS+xOT+7k6U06HyclK1+8WZjTjlWvzKR024m9lvmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Owfm+QZ1; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-43376624a8fso7511185ab.0
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 17:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764294326; x=1764899126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQum3my8b/C4JwlaTjim4TDiqYwzaFLaURlhWLt3NcA=;
        b=Owfm+QZ1CkjhhTrrdJd1KpZPy3itmU49PB0rniYYagHjR3NTll9fW+MmHag7Ovw/Sk
         5j9fYOszL37CRTpdC4ouxKLdZ2PxxFYYxDEbttVEywmnPYHJ+8It+0qKw3RviPcO+KtP
         QJQBxI7KM00FpyU8pyAEaqc+LgV45zgdOcc4SeoVsnaY+Kga96i1GciEYfSNFBoQXJDy
         M236AGA+WHWD9WIA+7cEscMcl/zn7oUNXRV/735bqkp7F3EwUajmRHe3mlnIJNQcdeCB
         VSPFgCIAWdW/puqjmflUqxcWztXrlUYCQjVQPEUPrcMXA73rXuyzACiFa3pSiZuaF6W1
         4k+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764294326; x=1764899126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oQum3my8b/C4JwlaTjim4TDiqYwzaFLaURlhWLt3NcA=;
        b=FQgPVJP1+MPg4Ykglg3UM1NjTE9Pw/K34Aw2wVHdXnXVW2B59PA3gZoZtIj6chh4e6
         mTSdC2xDj1Qa4lRV09LBQrfKTqJzzi+6ABMB6hwmRwcKi9YebVmGTcNc8LnmrebvSgYn
         tEv6Wln+DDUr4jBvIMxOp9sEvXsJbLq4DKwhQ5OLsCsfKoM5kVM7560LgeShg2SnoN6c
         d48IV0TGXpjgqLq+UOsfbJOv/N/5XJlaQC1w7ttlFbtYBwoJkZOMsYIoBlXH5V7Pi1RQ
         vl7yjeycdL7BpJHg35PTuCh/31k9iNtCqMsPV4fuv+QxtYQp51nvS2rEMcyTHrxZE9Oy
         EY+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTvVN2HfaX5a0c6sECy4gVB32NLHKayoO9xORW1qsjNXlzm5nY3ELVLctIkXfTvGKbX7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzazio1yqDqWa5duektDUugBf8eziZJ+2UVV4ymzGTUCJkvEHkK
	ujJJvrbeU3aBhwBxXOL6/id1tDD8E8DhveovT9IVPvrS+Mf1f02y3Q4qFqsYUnqR2uaINLmw5mr
	O2JzANBhjVUE5jRPrGBndEfiP32yE1nE=
X-Gm-Gg: ASbGncvtRuC/H4b5eGqISrukn3BDSDqy4S4brPyVGIgEMp2Hca9TBW29B25ZxV7SEWQ
	LEJI45/vXs4dbDYaTZvFERaSLsSFZ9xRFWQBbC7+mRqOQ2HJMkKyemtnrkJ1o0NhSqlP6OtHmHP
	18ki82OaM5AtDkpZL5rrXVj3LU8kHcw8NCXVL2i+gem0Vy7WuMdwHtd5YxmYeXWMgzQbybI79x+
	53ZNeNsVECBXPbqsM7BgqDw/wX+MNe2+xxPdZ0ZaRix9Qti4aXMPRph6HWIiOmr6R9Wlak=
X-Google-Smtp-Source: AGHT+IGdEzYE1sBcDMVLgtO62NHYPsOi0ddf6d/CJXYvch1Vt7CQ0M2uHWRoV6ebXbYw3IpDysEFY/09VxSulLxhhTA=
X-Received: by 2002:a92:4a12:0:b0:434:a88d:f819 with SMTP id
 e9e14a558f8ab-435dd043b40mr96641795ab.2.1764294325842; Thu, 27 Nov 2025
 17:45:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125115754.46793-1-kerneljasonxing@gmail.com>
 <b859fd65-d7bb-45bf-b7f8-e6701c418c1f@redhat.com> <CAL+tcoDdntkJ8SFaqjPvkJoCDwiitqsCNeFUq7CYa_fajPQL4A@mail.gmail.com>
 <f8d6dbe0-b213-4990-a8af-2f95d25d21be@redhat.com>
In-Reply-To: <f8d6dbe0-b213-4990-a8af-2f95d25d21be@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 28 Nov 2025 09:44:49 +0800
X-Gm-Features: AWmQ_bkUYcerIs8U4CrLfJsh8DBflPxy2QghT5jN_y43S0d05LeeeH-n1yjxm3I
Message-ID: <CAL+tcoAY5uaYRC2EyMQTn+Hjb62KKD1DRyymW+M27BT=n+MUOw@mail.gmail.com>
Subject: Re: [PATCH net-next v3] xsk: skip validating skb list in xmit path
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 1:58=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 11/27/25 1:49 PM, Jason Xing wrote:
> > On Thu, Nov 27, 2025 at 8:02=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 11/25/25 12:57 PM, Jason Xing wrote:
> >>> This patch also removes total ~4% consumption which can be observed
> >>> by perf:
> >>> |--2.97%--validate_xmit_skb
> >>> |          |
> >>> |           --1.76%--netif_skb_features
> >>> |                     |
> >>> |                      --0.65%--skb_network_protocol
> >>> |
> >>> |--1.06%--validate_xmit_xfrm
> >>>
> >>> The above result has been verfied on different NICs, like I40E. I
> >>> managed to see the number is going up by 4%.
> >>
> >> I must admit this delta is surprising, and does not fit my experience =
in
> >> slightly different scenarios with the plain UDP TX path.
> >
> > My take is that when the path is extremely hot, even the mathematics
> > calculation could cause unexpected overhead. You can see the pps is
> > now over 2,000,000. The reason why I say this is because I've done a
> > few similar tests to verify this thought.
>
> Uhm... 2M is not that huge. Prior to the H/W vulnerability fallout
> (spectre and friends) reasonable good H/W (2016 old) could do ~2Mpps
> with a single plain UDP socket.

Interesting number that I'm not aware of. Thanks.

But for now it's really hard for xsk (in copy mode) to reach over 2M
pps even with some recent optimizations applied. I wonder how you test
UDP? Could you share the benchmark here?

IMHO, xsk should not be slower than a plain UDP socket. So I think it
should be a huge room for xsk to improve...

>
> Also validate_xmit_xfrm() should be basically a no-op, possibly some bad
> luck with icache?

Maybe. I strongly feel that I need to work on the layout of those structure=
s.

>
> Could you please try the attached patch instead?

Yep, and I didn't manage to see any improvement.

>
> Should not be as good as skipping the whole validation but should give
> some measurable gain.
> >>> [1] - analysis of the validate_xmit_skb()
> >>> 1. validate_xmit_unreadable_skb()
> >>>    xsk doesn't initialize skb->unreadable, so the function will not f=
ree
> >>>    the skb.
> >>> 2. validate_xmit_vlan()
> >>>    xsk also doesn't initialize skb->vlan_all.
> >>> 3. sk_validate_xmit_skb()
> >>>    skb from xsk_build_skb() doesn't have either sk_validate_xmit_skb =
or
> >>>    sk_state, so the skb will not be validated.
> >>> 4. netif_needs_gso()
> >>>    af_xdp doesn't support gso/tso.
> >>> 5. skb_needs_linearize() && __skb_linearize()
> >>>    skb doesn't have frag_list as always, so skb_has_frag_list() retur=
ns
> >>>    false. In copy mode, skb can put more data in the frags[] that can=
 be
> >>>    found in xsk_build_skb_zerocopy().
> >>
> >> I'm not sure  parse this last sentence correctly, could you please
> >> re-phrase?
> >>
> >> I read it as as the xsk xmit path could build skb with nr_frags > 0.
> >> That in turn will need validation from
> >> validate_xmit_skb()/skb_needs_linearize() depending on the egress devi=
ce
> >> (lack of NETIF_F_SG), regardless of any other offload required.
> >
> > There are two paths where the allocation of frags happen:
> > 1) xsk_build_skb() -> xsk_build_skb_zerocopy() -> skb_fill_page_desc()
> > -> shinfo->frags[i]
> > 2) xsk_build_skb() -> skb_add_rx_frag() -> ... -> shinfo->frags[i]
> >
> > Neither of them touch skb->frag_list, which means frag_list is NULL.
> > IIUC, there is no place where frag_list is used (which actually I
> > tested). we can see skb_needs_linearize() needs to check
> > skb_has_frag_list() first, so it will not proceed after seeing it
> > return false.
> https://elixir.bootlin.com/linux/v6.18-rc7/source/include/linux/skbuff.h#=
L4322
>
> return skb_is_nonlinear(skb) &&
>                ((skb_has_frag_list(skb) && !(features & NETIF_F_FRAGLIST)=
) ||
>                 (skb_shinfo(skb)->nr_frags && !(features & NETIF_F_SG)));
>
> can return true even if `!skb_has_frag_list(skb)`.

Oh well, indeed, I missed the nr_frags condition.

> I think you still need to call validate_xmit_skb()

I can simplify the whole logic as much as possible that is only
suitable for xsk: only keeping the linear check. That is the only
place that xsk could run into.

Thanks,
Jason

