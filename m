Return-Path: <bpf+bounces-49609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10094A1AB85
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 21:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1E11667BA
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 20:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F22B1C1753;
	Thu, 23 Jan 2025 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRqUP08R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65B312FB1B;
	Thu, 23 Jan 2025 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737664665; cv=none; b=M2MbnLlUdJbBk4lupCDXha1nsC6X1Bb2U/Ua9pmi+Fsm3on/p0fgY0XLIpAannjjb3rZ61izgn/QLoUoQeb2yEZjIax4b8Fipa6gvrRLQatosHQC1JOGi9e9Dv3XOHN8K6+SXfNGwqu//mVGX6zkPdeIuwBSko4csP/SRiKT1ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737664665; c=relaxed/simple;
	bh=Ggr0CNMMbYphCfqIZrpb7aZ4VH5s2B1Y+1imY/1JkBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPY+2IxnDwErnbiK+hD3BOmlpjLDtFeLcPtpL3RJkRUqmTanaFE0NTT0GLl/Un2EdD2Phmw9eCTqBW+eUxbHHQ2vlTbTVf1C6Ew8Nrd6bFVM2ZVdSGdHFYXbKr+VDBYy//FK7DNO5ChSc1Ibsm7gDnnaC6bjXHybO8TwspS4u6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRqUP08R; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21670dce0a7so27893575ad.1;
        Thu, 23 Jan 2025 12:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737664663; x=1738269463; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h9Og1lB1O9fUGpix1uNn4vBTIpZtAi9xigvetQVRkt4=;
        b=ZRqUP08RIIr6Nhn6y6lMX8L3Og+9yjNE4fWZChPmD9XjuwBHaYM7ZQ8waIQlEAjG7J
         Ylj78LKCqx7yW9UFJRGk5kavUJ/lJfMReeZMUjz1d+dI6eTx3X+bvAb8Q3Yl+HEQl2/q
         HR4X0MeMpqW5K028j/ws0H12f9KXGWUwDqft8UqLOLjrL/R9UQg6bNPI+522cXxUbsEr
         3LgAZF2TqX6B4AVON2WkQeHBw8HA9mVPjnJgq/Z/6AGlxtg0PGj5rJvLQ0Zn4Q8UCY7U
         f1JCOxXnUWqyAbZ7NUY+3WDGhCkIsxCJwoy8jzxmWjeIsuOMjEL+p1eSK73R4kmsx6AZ
         Wkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737664663; x=1738269463;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9Og1lB1O9fUGpix1uNn4vBTIpZtAi9xigvetQVRkt4=;
        b=tJRbS1JzdBbjFkd62MoUG20/VlALsBt55H0bOcs7wNEmZp6f56lmZCYOjORJvvPj7x
         LzcBW6ptq4eXyfB3GDxnYUXHlEiGe0pLJ4zhau3X5fTS96tXCliSq3Cl7qW6fbah668f
         1yXD0eUQU1OMzgGbPbJtBEzeWOr4f1ogB9/IcPbvLtOeZrBBSZ3qpx40o4m3WmMzX7uW
         kRxMZ9XIR/Lm6SsJd1oI6ESs5De36c6HxLzja6GoC53PnBaAaQYR4ATkMhwVQfCoVuDW
         28IXFaqhWsGTK1Eg0M0o2Ck716zSkQZWEQ4t77FqC8Ng90aeTXspc8Rb0pCsjhcURv0v
         +e3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNdPKKVO7CJ6dVFy41yPcr00nCsALkAmqmCiglWXCqzv6+n1xwiLCkqLJ3RMy0ptMMNkHtx5tnMBSMII9G@vger.kernel.org, AJvYcCV8FiHDhgmNFQfKTuI5wYi8ocIgfYUiZDTLaRGu0NKe0S8dDH13rzGxRkh8P8Vpxqj5cOQ=@vger.kernel.org, AJvYcCW0EMzioK9gpgGFYPmbnHxV0oJQ3Z0GxP64tkmnWhtMlZq5e9ds5i1zIl3lhl370Ux8MsUP5JXt@vger.kernel.org
X-Gm-Message-State: AOJu0YxzZXFDvvyf/uotNJmsZKTA2QJexkSge4PrZtyM3ds24HYOM+nw
	01XN2tRlYpP0cHzC85efDdurmbWqWqqRv0nlop9ugy5hNSgV/pkYIcpllTw=
X-Gm-Gg: ASbGncv53w90ikaDMYjjYtuK17rWelyaKEWzkcZSH2mCOX4WK+6fnWsJkQCvIL0HmQr
	t+nKPsGctrWE1fJgClu5j4p2znhqpKdtc07zwTEXOLakBAFBTDqdXR7HQlWfaWuZmxLaUmYwUnE
	p+I6emWiIuiMAmRRDu/aRaDPbax8vZjOrzYHrGFu6fRl8uaaTtcAJUhpuAnTRjL9kGkVIAFAXL5
	NvMh6C5Lfm38zDaYyVPckqT0Kk6DPWbkEMOOYRV5IjUr7ZoAM/gCFQEzVQpXpNaC7vixrCiFTWe
	YAtN
X-Google-Smtp-Source: AGHT+IF6eg3dSJTnukPisAUGSKhtOMhhzrtrTYcHTDTzgGzrTNfaP/OuX60jH0j/Bvo2ts+BvpxkDQ==
X-Received: by 2002:a05:6a21:9990:b0:1e1:3970:d75a with SMTP id adf61e73a8af0-1eb214761dcmr39398603637.9.1737664663096;
        Thu, 23 Jan 2025 12:37:43 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6b30d3sm392771b3a.50.2025.01.23.12.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 12:37:42 -0800 (PST)
Date: Thu, 23 Jan 2025 12:37:41 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	BPF Mailing List <bpf@vger.kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	Matt Moeller <moeller.matt@gmail.com>
Subject: Re: [PATCH bpf] bpf: fix classic bpf reads from negative offset
 outside of linear skb portion
Message-ID: <Z5KolQGqCV3PBjWS@mini-arch>
References: <20250122200402.3461154-1-maze@google.com>
 <CANP3RGe_cspCzYe_scA37Hgr0GNbASmN94RRnPRUT1YiBcn=eg@mail.gmail.com>
 <CANP3RGc7-ZkQ2xGtkW00+A+zcWpm4WdMEbSn=UjotBQHzO+f7w@mail.gmail.com>
 <CANP3RGeE4T8a9Mn4+tAKkGU8BaCrt5tu89aQt2dzq4DzNXbb4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANP3RGeE4T8a9Mn4+tAKkGU8BaCrt5tu89aQt2dzq4DzNXbb4w@mail.gmail.com>

On 01/22, Maciej Żenczykowski wrote:
> On Wed, Jan 22, 2025 at 12:28 PM Maciej Żenczykowski
> <zenczykowski@gmail.com> wrote:
> >
> > On Wed, Jan 22, 2025 at 12:16 PM Maciej Żenczykowski
> > <zenczykowski@gmail.com> wrote:
> > >
> > > On Wed, Jan 22, 2025 at 12:04 PM Maciej Żenczykowski <maze@google.com> wrote:
> > > >
> > > > We're received reports of cBPF code failing to accept DHCP packets.
> > > > "BPF filter for DHCP not working (android14-6.1-lts + android-14.0.0_r74)"
> > > >
> > > > The relevant Android code is at:
> > > >   https://cs.android.com/android/platform/superproject/main/+/main:packages/modules/NetworkStack/jni/network_stack_utils_jni.cpp;l=95;drc=9df50aef1fd163215dcba759045706253a5624f5
> > > > which uses a lot of macros from:
> > > >   https://cs.android.com/android/platform/superproject/main/+/main:packages/modules/Connectivity/bpf/headers/include/bpf/BpfClassic.h;drc=c58cfb7c7da257010346bd2d6dcca1c0acdc8321
> > > >
> > > > This is widely used and does work on the vast majority of drivers,
> > > > but is exposing a core kernel cBPF bug related to driver skb layout.
> > > >
> > > > Root cause is iwlwifi driver, specifically on (at least):
> > > >   Dell 7212: Intel Dual Band Wireless AC 8265
> > > >   Dell 7220: Intel Wireless AC 9560
> > > >   Dell 7230: Intel Wi-Fi 6E AX211
> > > > delivers frames where the UDP destination port is not in the skb linear
> > > > portion, while the cBPF code is using SKF_NET_OFF relative addressing.
> > > >
> > > > simplified from above, effectively:
> > > >   BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, SKF_NET_OFF)
> > > >   BPF_STMT(BPF_LD  | BPF_H | BPF_IND, SKF_NET_OFF + 2)
> > > >   BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 68, 1, 0)
> > > >   BPF_STMT(BPF_RET | BPF_K, 0)
> > > >   BPF_STMT(BPF_RET | BPF_K, 0xFFFFFFFF)
> > > > fails to match udp dport=68 packets.
> > > >
> > > > Specifically the 3rd cBPF instruction fails to match the condition:
> > >
> > > 2nd of course
> > >
> > > >   if (ptr >= skb->head && ptr + size <= skb_tail_pointer(skb))
> > > > within bpf_internal_load_pointer_neg_helper() and thus returns NULL,
> > > > which results in reading -EFAULT.
> > > >
> > > > This is because bpf_skb_load_helper_{8,16,32} don't include the
> > > > "data past headlen do skb_copy_bits()" logic from the non-negative
> > > > offset branch in the negative offset branch.
> > > >
> > > > Note: I don't know sparc assembly, so this doesn't fix sparc...
> > > > ideally we should just delete bpf_internal_load_pointer_neg_helper()
> > > > This seems to have always been broken (but not pre-git era, since
> > > > obviously there was no eBPF helpers back then), but stuff older
> > > > than 5.4 is no longer LTS supported anyway, so using 5.4 as fixes tag.
> > > >
> > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > > > Cc: Willem de Bruijn <willemb@google.com>
> > > > Reported-by: Matt Moeller <moeller.matt@gmail.com>
> > > > Closes: https://issuetracker.google.com/384636719 [Treble - GKI partner internal]
> > > > Signed-off-by: Maciej Żenczykowski <maze@google.com>
> > > > Fixes: 219d54332a09 ("Linux 5.4")
> > > > ---
> > > >  include/linux/filter.h |  2 ++
> > > >  kernel/bpf/core.c      | 14 +++++++++
> > > >  net/core/filter.c      | 69 +++++++++++++++++-------------------------
> > > >  3 files changed, 43 insertions(+), 42 deletions(-)
> > > >
> > > > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > > > index a3ea46281595..c24d8e338ce4 100644
> > > > --- a/include/linux/filter.h
> > > > +++ b/include/linux/filter.h
> > > > @@ -1479,6 +1479,8 @@ static inline u16 bpf_anc_helper(const struct sock_filter *ftest)
> > > >  void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb,
> > > >                                            int k, unsigned int size);
> > > >
> > > > +int bpf_internal_neg_helper(const struct sk_buff *skb, int k);
> > > > +
> > > >  static inline int bpf_tell_extensions(void)
> > > >  {
> > > >         return SKF_AD_MAX;
> > > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > > index da729cbbaeb9..994988dabb97 100644
> > > > --- a/kernel/bpf/core.c
> > > > +++ b/kernel/bpf/core.c
> > > > @@ -89,6 +89,20 @@ void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb, int k, uns
> > > >         return NULL;
> > > >  }
> > > >
> > > > +int bpf_internal_neg_helper(const struct sk_buff *skb, int k)
> > > > +{
> > > > +       if (k >= 0)
> > > > +               return k;
> > > > +       if (k >= SKF_NET_OFF)
> > > > +               return skb->network_header + k - SKF_NET_OFF;
> > > > +       if (k >= SKF_LL_OFF) {
> > > > +               if (unlikely(!skb_mac_header_was_set(skb)))
> > > > +                       return -1;
> > > > +               return skb->mac_header + k - SKF_LL_OFF;
> > > > +       }
> > > > +       return -1;
> > > > +}
> > > > +
> > > >  /* tell bpf programs that include vmlinux.h kernel's PAGE_SIZE */
> > > >  enum page_size_enum {
> > > >         __PAGE_SIZE = PAGE_SIZE
> > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > index e56a0be31678..609ef7df71ce 100644
> > > > --- a/net/core/filter.c
> > > > +++ b/net/core/filter.c
> > > > @@ -221,21 +221,16 @@ BPF_CALL_3(bpf_skb_get_nlattr_nest, struct sk_buff *, skb, u32, a, u32, x)
> > > >  BPF_CALL_4(bpf_skb_load_helper_8, const struct sk_buff *, skb, const void *,
> > > >            data, int, headlen, int, offset)
> > > >  {
> > > > -       u8 tmp, *ptr;
> > > > -       const int len = sizeof(tmp);
> > > > -
> > > > -       if (offset >= 0) {
> > > > -               if (headlen - offset >= len)
> > > > -                       return *(u8 *)(data + offset);
> > > > -               if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > > > -                       return tmp;
> > > > -       } else {
> > > > -               ptr = bpf_internal_load_pointer_neg_helper(skb, offset, len);
> > > > -               if (likely(ptr))
> > > > -                       return *(u8 *)ptr;
> > > > -       }
> > > > +       u8 tmp;
> > > >
> > > > -       return -EFAULT;
> > > > +       offset = bpf_internal_neg_helper(skb, offset);
> > > > +       if (unlikely(offset < 0))
> > > > +               return -EFAULT;
> > > > +       if (headlen - offset >= sizeof(u8))
> > > > +               return *(u8 *)(data + offset);
> > > > +       if (skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > > > +               return -EFAULT;
> > > > +       return tmp;
> > > >  }
> > > >
> > > >  BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb,
> > > > @@ -248,21 +243,16 @@ BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb,
> > > >  BPF_CALL_4(bpf_skb_load_helper_16, const struct sk_buff *, skb, const void *,
> > > >            data, int, headlen, int, offset)
> > > >  {
> > > > -       __be16 tmp, *ptr;
> > > > -       const int len = sizeof(tmp);
> > > > +       __be16 tmp;
> > > >
> > > > -       if (offset >= 0) {
> > > > -               if (headlen - offset >= len)
> > > > -                       return get_unaligned_be16(data + offset);
> > > > -               if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > > > -                       return be16_to_cpu(tmp);
> > > > -       } else {
> > > > -               ptr = bpf_internal_load_pointer_neg_helper(skb, offset, len);
> > > > -               if (likely(ptr))
> > > > -                       return get_unaligned_be16(ptr);
> > > > -       }
> > > > -
> > > > -       return -EFAULT;
> > > > +       offset = bpf_internal_neg_helper(skb, offset);
> > > > +       if (unlikely(offset < 0))
> > > > +               return -EFAULT;
> > > > +       if (headlen - offset >= sizeof(__be16))
> > > > +               return get_unaligned_be16(data + offset);
> > > > +       if (skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > > > +               return -EFAULT;
> > > > +       return be16_to_cpu(tmp);
> > > >  }
> > > >
> > > >  BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const struct sk_buff *, skb,
> > > > @@ -275,21 +265,16 @@ BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const struct sk_buff *, skb,
> > > >  BPF_CALL_4(bpf_skb_load_helper_32, const struct sk_buff *, skb, const void *,
> > > >            data, int, headlen, int, offset)
> > > >  {
> > > > -       __be32 tmp, *ptr;
> > > > -       const int len = sizeof(tmp);
> > > > -
> > > > -       if (likely(offset >= 0)) {
> > > > -               if (headlen - offset >= len)
> > > > -                       return get_unaligned_be32(data + offset);
> > > > -               if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > > > -                       return be32_to_cpu(tmp);
> > > > -       } else {
> > > > -               ptr = bpf_internal_load_pointer_neg_helper(skb, offset, len);
> > > > -               if (likely(ptr))
> > > > -                       return get_unaligned_be32(ptr);
> > > > -       }
> > > > +       __be32 tmp;
> > > >
> > > > -       return -EFAULT;
> > > > +       offset = bpf_internal_neg_helper(skb, offset);
> > > > +       if (unlikely(offset < 0))
> > > > +               return -EFAULT;
> > > > +       if (headlen - offset >= sizeof(__be32))
> > > > +               return get_unaligned_be32(data + offset);
> > > > +       if (skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > > > +               return -EFAULT;
> > > > +       return be32_to_cpu(tmp);
> > > >  }
> > > >
> > > >  BPF_CALL_2(bpf_skb_load_helper_32_no_cache, const struct sk_buff *, skb,
> > > > --
> > > > 2.48.1.262.g85cc9f2d1e-goog
> > > >
> > >
> > > Note: this is currently only compile and boot tested.
> > > Which doesn't prove all that much ;-)
> >
> > Furthermore even after cherrypicking this (or a similar style fix)
> > into older LTS:
> > - sparc jit is (presumably, maybe only 32-bit) still broken, as the
> > assembly uses the old function
> > - same for mips jit on 5.4/5.10/5.15
> > - same for powerpc jit on 5.4/5.10
> >
> > (but I would guess we don't care)
> 
> and Willem points out that:
> 
> "skb->network_header is an offset against head, while the
> get_unaligned_be16 and skb_copy_bits take an offset relative to data.
> 
> I did check yesterday that skb_copy_bits can take negative offsets, in
> case a protocol header (e.g., SKF_LL_OFF) is smaller than skb->data."
> 
> which makes me think this approach is possibly (likely?) incorrect?
> skb offsets always leave me confused...

Same for me WRT skb offsets... However, it should be easy to write a minimal
reproducer to trigger the issues in a local vm: create tap device, attach
egress bpf (classic) classifier, use tap's new zerocopy api (tap_get_user
SOCK_ZEROCOPY) to create fragmented skb. And attach it as a selftest O:-)

