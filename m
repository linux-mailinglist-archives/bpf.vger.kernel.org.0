Return-Path: <bpf+bounces-37071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAE6950C4F
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 20:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4660280D7E
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 18:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73FC1A2C27;
	Tue, 13 Aug 2024 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFCkowjN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7F21A38CB
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573851; cv=none; b=V1BBg4RE6JCCNeGcusfc2z5MccsO9YWdnYg62l0BrgLRKLnr2l1N3kDbzSdsA5kztkSSJq/QrL9nY8pKcW9NS3zRbXK4J/u9D4hhFfueflh6KH4yOdhNgcjN6hl2b7RaZSvTfRAHqXULK+JPvviOZGgDomTZyJmxLrsyHYi1eMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573851; c=relaxed/simple;
	bh=Yc+oaixQjrMf/fAPaQ6UV/qEV9MTR8XC3MrbziV6RtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpjRpi0AHgyqVv12TzJU4EKbsON0yP2L7GtFieCvN7iq4rtOD4y31f/IIQxaA95Aqk77KZudkWXxnliEyAso6Cf564Pqa1I/uce77rJCqXJGfN6XZoUzPb3BZ+Zza208VLuQCTDOCT44813dBHu0DeF35EOgbjd9xk/Ntg1izb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFCkowjN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-36bb2047bf4so3779841f8f.2
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 11:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723573848; x=1724178648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDnr1KBhosDy1kGF33uY1OqX0lrSUbYk6Vol0KARSaQ=;
        b=jFCkowjNmRqV0/S80IYMnrUkJpQk0nz1pSRLoiVCkvYUxuwiTaxU51p+UbnP8vY+/8
         Zcq9LR6dgb0ZJqF0ECbWTmW9+bQaHga5NKxTUNV1hJ4KgRy2pNQb/TewNVrgETtHNOsX
         20aW5ipPJbN+kuBM9wZ2jpzEp2MGKu/Nt/SGJiAoZ9tfGc029qg/boxIX6AxLO9GUEwz
         rUwaCunTI3Q1Qlx7dZ2iJiOVUfr8ra7vuGQ6qeHc3pylu285bZVnUkhrjaaeyWSG/wjr
         6ToGIbVjUQNgv7VFfju4s965imlPhACbkzD9VFcQwnkUFaQOsgDeXEJvxXn5mNsOk1Mu
         sglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723573848; x=1724178648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDnr1KBhosDy1kGF33uY1OqX0lrSUbYk6Vol0KARSaQ=;
        b=Xqr4T+WmMyefxlAXj0rxjEHuXETBX9bFtbHb4sUDkVijwH2zXBPrTrMZY1R0zWR6BR
         Y1IjdH1c3YABdvrVXB/5l8Bmwnage7brcpCcHFxXwOTSnXHUvZJYHts5vPF1ytKmb8+D
         uU99bNtIIiQ7wH5REH379VzqQYOGSLWtfuIynIomz1H6cRQLyCnMFbSeVRm3MCFtAJMN
         tZnZ8UCTQP3G3HI9npwKyJRL7yjXkTnNQEj8946ELVh4cODfN/sfGGc+mj1ynnA72373
         oT4ueq3MVAh12Xeqgr51dLELyMRnttX6xR2Vmt8PAea4yyu8ZhIqGUY7UMH1tT6B8DbK
         5ZOg==
X-Forwarded-Encrypted: i=1; AJvYcCW6/90xaN47a6qJMMCD9n3RIV5l7Ez+7hKplqPxUGuWUQvyxEnyn2HYs2zt87RdCJvx8/w+K3asVHa099hP+9/+o8Df
X-Gm-Message-State: AOJu0Yx5jooSD/n4qp27xPkQYi0ztqIRqLJCajNgAGBJxowpagN/SsJD
	pFgzPr8eoLJDdj4nYGrt/745OJ0KSRVQy66L/IxRXvjEHaMIeyYSxEItBIqk8yaTc9zIb7K+wd/
	SyKD9zE00enymz7UNvhYu2ye6dK4=
X-Google-Smtp-Source: AGHT+IE3Qy4CLNTV2DhjdNYQB9dxshMdJWcc860G7BvoUnis89leiRUgqqWvkUDU0kksDxT/HzhuLjRHJcLlej/V4K8=
X-Received: by 2002:adf:f34a:0:b0:36c:ff0c:36d7 with SMTP id
 ffacd0b85a97d-3717776be2emr337281f8f.2.1723573847258; Tue, 13 Aug 2024
 11:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813012528.3566133-1-linux@jordanrome.com>
 <CAADnVQ+cfn0SMQZwnCcv5VvCCixO+=CsTcF4bfjEYTpHPWngwA@mail.gmail.com>
 <CA+QiOd6WYqBHjDdG8OpRFby7MC2jh_YoXY2kTZt3YrmoY4J2ow@mail.gmail.com>
 <CA+QiOd5q3j1x+Pvt1Tpx3s+mA0HWfcwniSg11AJCsArZLWRhGA@mail.gmail.com>
 <CAADnVQL5rskNLC-f6z_Rg3Tjf7khis=pzNiKzJOMzvpw-R5wKg@mail.gmail.com> <CAEf4BzZVvdUYY5DRTLhmaZP7zssa1tBm1P1=96DvJWxfFP-xSw@mail.gmail.com>
In-Reply-To: <CAEf4BzZVvdUYY5DRTLhmaZP7zssa1tBm1P1=96DvJWxfFP-xSw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Aug 2024 11:30:36 -0700
Message-ID: <CAADnVQJramfGwT7H5GBM1ss7zQ3mO4uy4UhHyVfx3S9PLthDTA@mail.gmail.com>
Subject: Re: [bpf-next v3 1/2] bpf: Add bpf_copy_from_user_str kfunc
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jordan Rome <linux@jordanrome.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 11:10=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Aug 13, 2024 at 9:08=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Aug 13, 2024 at 6:30=E2=80=AFAM Jordan Rome <linux@jordanrome.c=
om> wrote:
> > >
> > > On Tue, Aug 13, 2024 at 6:27=E2=80=AFAM Jordan Rome <linux@jordanrome=
.com> wrote:
> > > >
> > > > On Mon, Aug 12, 2024 at 10:10=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Mon, Aug 12, 2024 at 6:26=E2=80=AFPM Jordan Rome <linux@jordan=
rome.com> wrote:
> > > > > >
> > > > > > This adds a kfunc wrapper around strncpy_from_user,
> > > > > > which can be called from sleepable BPF programs.
> > > > > >
> > > > > > This matches the non-sleepable 'bpf_probe_read_user_str'
> > > > > > helper.
> > > > > >
> > > > > > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > > > > > ---
> > > > > >  kernel/bpf/helpers.c | 36 ++++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 36 insertions(+)
> > > > > >
> > > > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > > > index d02ae323996b..e87d5df658cb 100644
> > > > > > --- a/kernel/bpf/helpers.c
> > > > > > +++ b/kernel/bpf/helpers.c
> > > > > > @@ -2939,6 +2939,41 @@ __bpf_kfunc void bpf_iter_bits_destroy(s=
truct bpf_iter_bits *it)
> > > > > >         bpf_mem_free(&bpf_global_ma, kit->bits);
> > > > > >  }
> > > > > >
> > > > > > +/**
> > > > > > + * bpf_copy_from_user_str() - Copy a string from an unsafe use=
r address
> > > > > > + * @dst:             Destination address, in kernel space.  Th=
is buffer must be at
> > > > > > + *                   least @dst__szk bytes long.
> > > > > > + * @dst__szk:        Maximum number of bytes to copy, includin=
g the trailing NUL.
> > > > > > + * @unsafe_ptr__ign: Source address, in user space.
> > > > > > + *
> > > > > > + * Copies a NUL-terminated string from userspace to BPF space.=
 If user string is
> > > > > > + * too long this will still ensure zero termination in the dst=
 buffer unless
> > > > > > + * buffer size is 0.
> > > > > > + */
> > > > > > +__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk=
, const void __user *unsafe_ptr__ign)
> > > > > > +{
> > > > > > +       int ret;
> > > > > > +       int count;
> > > > > > +
> > > > > > +       if (unlikely(!dst__szk))
> > > > > > +               return 0;
> > > > > > +
> > > > > > +       count =3D dst__szk - 1;
> > > > > > +       if (unlikely(!count)) {
> > > > > > +               ((char *)dst)[0] =3D '\0';
> > > > > > +               return 1;
> > > > > > +       }
> > > > > > +
> > > > > > +       ret =3D strncpy_from_user(dst, unsafe_ptr__ign, count);
> > > > > > +       if (ret >=3D 0) {
> > > > > > +               if (ret =3D=3D count)
> > > > > > +                       ((char *)dst)[ret] =3D '\0';
> > > > > > +               ret++;
> > > > > > +       }
> > > > > > +
> > > > > > +       return ret;
> > > > > > +}
> > > > >
> > > > > The above will not pad the buffer and it will create instability
> > > > > when the target buffer is a part of the map key. Consider:
> > > > >
> > > > > struct map_key {
> > > > >    char str[100];
> > > > > };
> > > > > struct {
> > > > >         __uint(type, BPF_MAP_TYPE_HASH);
> > > > >         __type(key, struct map_key);
> > > > > } hash SEC(".maps");
> > > > >
> > > > > struct map_key key;
> > > > > bpf_copy_from_user_str(key.str, sizeof(key.str), user_string);
> > > > >
> > > > > The verifier will think that all of the 'key' is initialized,
> > > > > but for short strings the key will have garbage.
> > > > >
> > > > > bpf_probe_read_kernel_str() has the same issue as above, but
> > > > > let's fix it here first and update read_kernel_str() later.
> > > > >
> > > > > pw-bot: cr
> > > >
> > > > You're saying we should always do a memset using `dst__szk` on succ=
ess
> > > > of copying the string?
> > >
> > > Something like this?
> > > ```
> > > ret =3D strncpy_from_user(dst, unsafe_ptr__ign, count);
> > >   if (ret >=3D 0) {
> > >     if (ret <=3D count)
> > >        memset((char *)dst + ret, 0, dst__szk - ret);
> > >     ret++;
> > > }
> > > ```
> >
> > yep. something like this. I didn't check the math.
>
> I'm a bit worried about this unconditional memset without having a way
> to disable it. In practice, lots of cases won't use the destination
> buffer as a map key, but rather just send it over ringbuf. So paying
> the price of zeroing out seems unnecessary.
>
> It's quite often (I do that in retsnoop, for instance; and we have
> other cases in our production) that we have a pretty big buffer, but
> expect that most of the time strings will be much smaller. So we can
> have a 1K buffer, but get 20 bytes of string content (and we end up
> sending only actual useful size of data over ringbuf/perfbuf, so not
> even paying 1K memcpy() overhead). Paying for memset()'ing the entire
> 1K (and string reading can happen in a loop, so this memsetting will
> be happening over and over, unnecessarily), seems excessive.
>
> Given it's pretty easy to do memset(0) using bpf_prober_read(dst, sz,
> NULL), maybe we shouldn't do memsetting unconditionally? We can add a
> loud comment stating the danger of using the resulting buffer as map
> key without clearing the unfilled part of the buffer and that should
> be sufficient?

probe_read as memset is a quirk that folks learned to abuse.
Let's add a flag to this bpf_copy_from_user_str() kfunc instead,
so it behaves either like strscpy_pad or strscpy.

