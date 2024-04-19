Return-Path: <bpf+bounces-27190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 626D48AA630
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 02:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D232831B3
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 00:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0334337C;
	Fri, 19 Apr 2024 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lerU5q4m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F15C7F
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 00:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713486017; cv=none; b=hkreVLcfAhBpH/oS7FLXcqzhPQ/e1xDof/Lbyn32sbuUs/9HCHcUrTxdn/BhtsBZtj94M3oN7pMS2XwCKk3g9iApbtrvvS+EZVSIG6BjKuVufQ4Bkz7XEQQ19mHfDpHWjmZJZ7Rhh7GwxSo6PEMVrD8R+d3l+spcBEWRqasfprQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713486017; c=relaxed/simple;
	bh=5ZMIybh35O9aIZHFbVOBdcindUl0aeLqMhe0PLajdi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9xEs7HT+SIPQeZQp/heVjkwAE8+7T146foG5FRSyLZ0b9VsoHvNow5EoLkFt2PHwhQDMiE+onbdew+vMUe3AXeeR2lVNZRhW3dGIubVHRky5u8Z5a2qAxRdT8aassRBxSQMzKpLJxLh5KoQNJPGK5FAKykvHg/DWtlRQkZnhKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lerU5q4m; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso1736709b3a.1
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 17:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713486015; x=1714090815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgpLbJlQhDldiLfp+vDg6mggTk7CRUXpCD7gpAzKB08=;
        b=lerU5q4mrLArbtF16ShVaA0xHrmuPKljxA+/MpVDwxFY06M6dzaz9376LOPQkJpvwu
         RnwnooZNLmAsV+HTGBpIM+tPMlsOqKNj6ZpOtWgvwVZGJSe6RvjvGCwq99Fyckki5lZm
         yEwsYQeVvYDpOs4Bm3XatCm/zs0/fbrWKxqf+SEN0aNjhQy8z4vd68/zu0zkVEN1WwTu
         0JGGNT4Rql6RvL6OZwfwMCi8hpON1gstVFBenPMN29cI4byA+ZDjs2UxiyMa9AZOSheX
         Pic1i6btEoeEV7Qu8aPHqL0rSGObQTkmQAO90J9bEVgx9Fu8fuBX/FEKAV0sExZ2WSA2
         ye9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713486015; x=1714090815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgpLbJlQhDldiLfp+vDg6mggTk7CRUXpCD7gpAzKB08=;
        b=eQ7+ZyMt51Z+lqlfgkuAy/oxrc/U4MBaOtYJ4zio2RCLqX/We8xuWHLAHOk2Uq7nJk
         ljT8qEGOk/0Bfx5vXD+QbJjLckpQ0uC9DZhPA/6/ib3iIeWAh5vce3R+mf5SDF2F7cy0
         KTBU5pjYpKUDZ0YiX54Y5U22CdhR27Ggh3/CN7PyNpGoJ6xQfkYvCf/CDyyonIUZ2TLa
         SfQntDicDDHTtr9PKb5ZDqwWvLmwIvOSS89y2BVABb8R79kvm+7qcIetXWu0dDjhCtPH
         10ou/DlLT72GMkcydFz4GmvS3VJL80mDEc6nIBChMMPAlgnechgtgWRTobszqiVdRyhd
         oieA==
X-Forwarded-Encrypted: i=1; AJvYcCXAMZ0GKWHhw/Z88FaTRiNtj2etGaZJeSRNRtkJZQg2G9hamIQ/g/cLYeLzU/sHhtM4ss3fTWIVCpfuZvQQFxooFwNZ
X-Gm-Message-State: AOJu0YzxmwT0PwiBpA9hSA58kJfChHyitVeamccDS3eKytLI8zWWQN94
	1q7NpgVnIIqz7JUy9hKj8GdIUBMGWeTb0bORRKL7oPRDalchrf4bYwUHiCZpGqtyNGtAPyngbMA
	6RgAhZbCuZ/ooiPu4GZAf7Xkxyxk=
X-Google-Smtp-Source: AGHT+IGMZ6lp2g5ZKdpPwXzCspmEm8mvcOy93y/aZm7GomyDIET/WSqranlsxOlGwBX65qxm6NOxxn6UPlRSnujcBgw=
X-Received: by 2002:a17:90a:d345:b0:2aa:d88d:d706 with SMTP id
 i5-20020a17090ad34500b002aad88dd706mr5748719pjx.4.1713486015235; Thu, 18 Apr
 2024 17:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36c8d494-e1cf-4361-8187-05abe4698791@tu-braunschweig.de>
 <4f62fa70-ac50-41ff-a685-db6c8aefb017@linux.dev> <6d224ee5-ca50-44a9-882e-074710bf8477@tu-braunschweig.de>
 <39a68b12-a921-471b-83ff-6d59b21aa4a9@linux.dev> <9c019772-8c21-4eb5-908d-103f0966dc13@tu-braunschweig.de>
In-Reply-To: <9c019772-8c21-4eb5-908d-103f0966dc13@tu-braunschweig.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Apr 2024 17:20:02 -0700
Message-ID: <CAEf4BzYpZ-_KAGHNiRxy+7Ybf-y1HKLif0+mSUvPHMkj4h3Deg@mail.gmail.com>
Subject: Re: No direct copy from ctx to map possible, why?
To: Fabian Pfitzner <f.pfitzner@tu-braunschweig.de>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 12:39=E2=80=AFPM Fabian Pfitzner
<f.pfitzner@tu-braunschweig.de> wrote:
>
> > In your particular example, since you intend to copy xdp_md->data, you
> > can directly
> > access that from xdp_md->data pointer, there is no need to copy ctx
> > which is not
> > what you want.
> Thanks for your answer, but I think you misunderstood me. I need to
> store the packet's payload in a map (not the xdp_md structure itself),
> because my use case forces me to do so.
>
> I write a program that reassembles split packets into a single one.
> Therefore I have to buffer packet fragments until all have been arrived.
> The only way in eBPF to realize such a buffer is a map, so I have to put
> the packet's payload in there. My problem is, that I have no clue how to
> do it properly as there is no direct way to put the payload into a map.
>
> How would you put a packet with a size of 700 bytes into a map? What
> would be your strategy when you can only access your packet via the
> xdp_md structure? My strategy (and that's the best I have found so far)
> is to split this packet into two packets of size 350 bytes, so that I
> can process them on the stack consecutively.

Check bpf_dynptr_from_skb()/bpf_dynptr_from_xdp() (see selftests for
examples) and then generic bpf_dynptr_data() will give you a pointer
into packet data. There are also generic bpf_dynptr_{read,write}()
helpers, which might be useful (all depends on specifics of
implementation).

As for 512 on the stack limitation. Just as a general solution, you
can use a single-element per-CPU ARRAY map as a temporary scratch
space to copy data there.

>
> On 4/16/24 5:22 AM, Yonghong Song wrote:
> >
> > On 4/15/24 1:25 PM, Fabian Pfitzner wrote:
> >>> Looks like you intend to copy packet data. So from the above,
> >>> 'expected=3Dfp,pkt,pkt_meta...', you can just put the first argument
> >>> with xdp->data, right?
> >> Yes, I intend to copy packet data. What do you mean by "first
> >> argument"? I'd like to put the whole data that is depicted by
> >> xdp->data into a map that stores them as raw bytes (by using a char
> >> array as map element to store the data).
> >
> > Sorry, typo. 'first argument' should be 'third argument'.
> >
> >>
> >>> Verifer rejects to 'ctx' since 'ctx' contents are subject to
> >>> verifier rewrite. So actual 'ctx' contents/layouts may not match
> >>> uapi definition.
> >> Sorry but I do not understand what you mean by "subject to verifier
> >> rewrite". What kind of rewrite happens when using the ctx as
> >> argument? Furthermore, am I correct that you assume that the uapi may
> >> dictate the structure of the data that can be stored in a map? How is
> >> it different to the case when first storing it on the stack and then
> >> putting it into a map?
> >
> > The UAPI xdp_md struct:
> >
> > struct xdp_md {
> >         __u32 data;
> >         __u32 data_end;
> >         __u32 data_meta;
> >         /* Below access go through struct xdp_rxq_info */
> >         __u32 ingress_ifindex; /* rxq->dev->ifindex */
> >         __u32 rx_queue_index;  /* rxq->queue_index  */
> >
> >         __u32 egress_ifindex;  /* txq->dev->ifindex */
> > };
> >
> > The actual kernel representation of xdp_md:
> >
> > struct xdp_buff {
> >         void *data;
> >         void *data_end;
> >         void *data_meta;
> >         void *data_hard_start;
> >         struct xdp_rxq_info *rxq;
> >         struct xdp_txq_info *txq;
> >         u32 frame_sz; /* frame size to deduce data_hard_end/reserved
> > tailroom*/
> >         u32 flags; /* supported values defined in xdp_buff_flags */
> > };
> >
> > You can see they are quite different. So to use pointee of 'ctx' as
> > the key, we
> > need to allocate a space of sizeof(struct_md) to the stack and copy
> > necessary
> > stuff to that structure. For example, xdp_md->ingress_ifindex =3D
> > xdp_buff->rxq->dev->ifindex, etc.
> > Some fields actually does not make sense for copying, e.g.,
> > data/data_end/data_meta in 64bit
> > architecture. Since stack allocation is needed any way, so disabling
> > ctx and requires
> > user explicit using stack make sense (if they want to use *ctx as map
> > update value).
> >
> > In your particular example, since you intend to copy xdp_md->data, you
> > can directly
> > access that from xdp_md->data pointer, there is no need to copy ctx
> > which is not
> > what you want.
> >
> >>
> >> On 4/15/24 6:01 PM, Yonghong Song wrote:
> >>>
> >>> On 4/14/24 2:34 PM, Fabian Pfitzner wrote:
> >>>> Hello,
> >>>>
> >>>> is there a specific reason why it is not allowed to copy data from
> >>>> ctx directly into a map via the bpf_map_update_elem helper?
> >>>> I develop a XDP program where I need to store incoming packets
> >>>> (including the whole payload) into a map in order to buffer them.
> >>>> I thought I could simply put them into a map via the mentioned
> >>>> helper function, but the verifier complains about expecting another
> >>>> type as "ctx" (R3 type=3Dctx expected=3Dfp, pkt, pkt_meta, .....).
> >>>
> >>> Looks like you intend to copy packet data. So from the above,
> >>> 'expected=3Dfp,pkt,pkt_meta...', you can just put the first argument
> >>> with xdp->data, right?
> >>> Verifer rejects to 'ctx' since 'ctx' contents are subject to
> >>> verifier rewrite. So actual 'ctx' contents/layouts may not match
> >>> uapi definition.
> >>>
> >>>>
> >>>> I was able to circumvent this error by first putting the packet
> >>>> onto the stack (via xdp->data) and then write it into the map.
> >>>> The only limitation with this is that I cannot store packets larger
> >>>> than 512 bytes due to the maximum stack size.
> >>>>
> >>>> I was also able to circumvent this by slicing chunks, that are
> >>>> smaller than 512 bytes, out of the packet so that I can use the
> >>>> stack as a clipboard before putting them into the map. This is a
> >>>> really ugly solution, but I have not found a better one yet.
> >>>>
> >>>> So my question is: Why does this limitation exist? I am not sure if
> >>>> its only related to XDP programs as this restriction is defined
> >>>> inside of the bpf_map_update_elem_proto struct (arg3_type restricts
> >>>> this), so I think it is a general limitation that affects all
> >>>> program types.
> >>>>
> >>>> Best regards,
> >>>> Fabian Pfitzner
> >>>>
> >>>>
> >>>>
> >>>>
> >>
>

