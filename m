Return-Path: <bpf+bounces-53595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D00A56F0A
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 18:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B468716FE55
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 17:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6315523FC75;
	Fri,  7 Mar 2025 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kN212q/O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B9C1A7AF7;
	Fri,  7 Mar 2025 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368562; cv=none; b=HQ3UdNyVFyNi99QJ7UiViCwqtKAGs/QDzGtz4gn5Guo3PBjTKSTAhQNK0YGnJG/tiCghD1wOFxZM4aAYgBxI/UcxxRcFWBD7db5/88p1Zd5EYS3X3iYmEXim/k8rhQeRNAZJV10NtfrDZDX4iw47nT+8iyVefiUt1XNhlCtTXLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368562; c=relaxed/simple;
	bh=itZdauul+tW9WCiLuqkfsEpBGP8lriiRip0VoxtUx5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9nRLzOx71GsxdWHH/Z8k9dv3QmlY1TfqJMGhiu1ABDDwv409eCacIG5jodY/lRjX+nlngWTHlbglHWu/rm5c71PdRFZ410mDvX97wHvQEqvFb18a1LyUbDknc+bRQpSZpBBGxEltEuaMhAoe02k1c7LsJ8KGZYEOhcGs84VO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kN212q/O; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39130ee05b0so1107354f8f.3;
        Fri, 07 Mar 2025 09:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741368559; x=1741973359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nERRLl88hSef6xp7KKsPrrso9KdDaP9uUMc9oALsedM=;
        b=kN212q/OqSS41yUsspAqfNKllZSRXX3ogG/Lam7PSv7UJTA0DthCfK7igpb6/4mfLR
         ZkBT4ZCmyhMIoY5GqJn4P5xxVJVk2A4z7lh02ag/BCNAGnt1mEOb2H6n6zSufS08nhIs
         F/ITyn2K9VbVSetwWQYkNVx33Rc4hF+gcNxSsAT9qdhHGsIDAayaZapbqi/0xuNSXVXT
         c03KeL0UuMQ2G1Em+zxGHe845aaPuuk3YPAegbYLMRyTEutjq39nwGyG9kTBQaKnOVUp
         /HYNGdIOSGBXwjZLfdhm3SYqtGkqRzUpm01LVQ5G0EJPeuXHixvyE0PghaBcXGa9gyUs
         UZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741368559; x=1741973359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nERRLl88hSef6xp7KKsPrrso9KdDaP9uUMc9oALsedM=;
        b=hqF9JcF6EqhWd+5wqiMp9HPCwPR7lvj4ZWTMGKpVMHOp+JiEmDpy6Mms3gAyafsohB
         nrTfnmgDOjnz9vYElic2/nwZ+ne52ehSH2vujZ4m/PXx9sJlJ3WYdmpnyAySUhaLptrc
         e4kv8AsP+gK7BZIhU4DHbvew1NrzahyF5jxvjrLgYvlXya3h8aGwQkP82/gy2wOaoQDR
         UkAOHF8h15jkvRBWysnNNDiJw6WztCa13B2EAeeePSvAEOfnlPIp82ePx5whW6aAhHOx
         x7QbmfQ2p5xfypTqJdZNy9M95S6ewZ40MDs4lcaa2PgnO4ZVTHdQCZ4W2XTXlxJ3qGLQ
         4oTw==
X-Forwarded-Encrypted: i=1; AJvYcCWvjBRp6dmK7wavOs6fjNo9fIOIPt9428sAhkSQD65N8rFSTeA3GhOKpvq+xeCSvQpo/w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ3mxU0UXo1po/HezlrOfxMTu6wiLPaKKEJUU4XFo7DJAXIQEh
	YIL88jZf+JSJdXJetkYARaLyj1bX7eN/26im0pF5lBWcoA6YJpWSf4N5qZk5k/yuUuba5DSwrqi
	RQwA44KkLLXO2bIVnAmdshU9R0P8=
X-Gm-Gg: ASbGnctWaJtaXVDZPkmVQ97QQeJYP5wjriMfkYtA7xSQl0KKzzPJGPM++XjPKnMPjrl
	3i8lYznAe5m9dt/i08kMkAqyYNLOGrvcfr3/x4XttbldW7nXAy+G0qxa6ro0/ubANZ60C2Wznzh
	LG852cooBh2q61HG4iY5Zl3JUlms0QxKXIvYR/Q9TLTg==
X-Google-Smtp-Source: AGHT+IGKsBCFfrfY0Ia6URNCBxeHTnBsyQ1Nq+ZZfftxrxKk98+hci/BR1KJGBtpuKYjzeqcSHPBTkHjLkgf6CukWg8=
X-Received: by 2002:a05:6000:21c4:b0:390:fe05:da87 with SMTP id
 ffacd0b85a97d-39132d50473mr1869436f8f.18.1741368559161; Fri, 07 Mar 2025
 09:29:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
 <20250305-afabre-traits-010-rfc2-v1-1-d0ecfb869797@cloudflare.com>
 <CAADnVQ+OShaA37-=B4-GWTQQ8p4yPw3TgYLPTkbHMJLYhr48kg@mail.gmail.com> <D89ZNSJCPNUA.20V16A9FXJ54J@arthurfabre.com>
In-Reply-To: <D89ZNSJCPNUA.20V16A9FXJ54J@arthurfabre.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Mar 2025 09:29:07 -0800
X-Gm-Features: AQ5f1JoiewzVELZu2m9ft3xh4xbBXN1KO4SGswpubdv7OKAiIZg_hEErWIkc2ao
Message-ID: <CAADnVQ+_O+kwTV-qhXqA9jc-L3w6uwn9FShG_859qx30NPkzsw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 01/20] trait: limited KV store for packet metadata
To: Arthur Fabre <arthur@arthurfabre.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Yan Zhai <yan@cloudflare.com>, 
	jbrandeburg@cloudflare.com, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <thoiland@redhat.com>, 
	lbiancon@redhat.com, Arthur Fabre <afabre@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 3:14=E2=80=AFAM Arthur Fabre <arthur@arthurfabre.com=
> wrote:
>
> On Fri Mar 7, 2025 at 7:36 AM CET, Alexei Starovoitov wrote:
> > On Wed, Mar 5, 2025 at 6:33=E2=80=AFAM <arthur@arthurfabre.com> wrote:
> > >
> > > +struct __trait_hdr {
> > > +       /* Values are stored ordered by key, immediately after the he=
ader.
> > > +        *
> > > +        * The size of each value set is stored in the header as two =
bits:
> > > +        *  - 00: Not set.
> > > +        *  - 01: 2 bytes.
> > > +        *  - 10: 4 bytes.
> > > +        *  - 11: 8 bytes.
> >
> > ...
> >
> > > +        *  - hweight(low) + hweight(high)<<1 is offset.
> >
> > the comment doesn't match the code
> >
> > > +        */
> > > +       u64 high;
> > > +       u64 low;
> >
> > ...
> >
> > > +static __always_inline int __trait_total_length(struct __trait_hdr h=
)
> > > +{
> > > +       return (hweight64(h.low) << 1) + (hweight64(h.high) << 2)
> > > +               // For size 8, we only get 4+2=3D6. Add another 2 in.
> > > +               + (hweight64(h.high & h.low) << 1);
> > > +}
> >
> > This is really cool idea, but 2 byte size doesn't feel that useful.
> > How about:
> > - 00: Not set.
> > - 01: 4 bytes.
> > - 10: 8 bytes.
> > - 11: 16 bytes.
> >
> > 4 byte may be useful for ipv4, 16 for ipv6, and 8 is just a good number=
.
> > And compute the same way with 3 popcount with extra +1 to shifts.
>
> I chose the sizes arbitrarily, happy to change them.
>
> 16 is also useful for UUIDs, for tracing.
>
> Size 0 could store bools / flags. Keys could be set without a value,
> and users could check if the key is set or not.
> That replaces single bits of the mark today, for example a
> "route locally" key.

I don't understand how that would work.
If I'm reading the code correctly 00 means that key is not present.
How one would differentiate key present/not with zero size in value?

>
> That only leaves one other size, maybe 4 for smaller values?
>
> If we want more sizes, we could also:
>
> - Add another u64 word to the header, so we have 3 bits per key. It
>   uses more room, and we need more popcnts, but most modern x86 CPUs can
>   do 3 popcnts in parallel so it could be ok.

Two u64s already need 3 pop counts, so it's a good compromise as-is.

> - Let users set consecutive keys to one big value. Instead of supporting
>   size 16, we let them set two 8 byte KVs in one trait_set() call and
>   provide a 16 byte value. Eg:
>
>         trait_set_batch(u64 key_from, u64_key_to, size, ...);
>
>   It's easy to implement, but it makes the API more complicated.

I don't think it complicates the api.
With max size 16 the user can put two consecutive keys of, say, 16 and 8
to make 24 bytes of info,
or use 4 keys of 16 byte each to form 64-bytes of info.
The bit manipulations are too tricky for compilers to optimize.
So even with full inlining the two trait_set() of consecutive keys
will still be largely separate blobs of code.
So trait_[gs]et_batch() makes sense to me.

Also let's not over focus on networking use cases.
This mini KV will be useful in all bpf maps including local storage.
For example the user process can add information about itself into
task local storage while sched-ext can use that to make scheduling decision=
s.

