Return-Path: <bpf+bounces-37087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC4D950DBC
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 22:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F42F1C21FB4
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 20:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF631A7050;
	Tue, 13 Aug 2024 20:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXtAIcoW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C5A1A4F3B
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 20:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723580336; cv=none; b=l2wsPMpz6M2ZtvTy+6swtqC/YGjSow1PxLqEJ1PU03cyR7yxIG6Z64yYVgbm7NzQs2HTomyj0tkqJSfhMeeLi+ynwD6EiM7kbHLDZG2RfYZXm9Fa1ARABvPKWc4Zaal26QhvoRIKjcC9q2n57mKyrQO1V+J5nKlQ+l2Hs1IyIRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723580336; c=relaxed/simple;
	bh=/esICExrfqeB0gE55MuBub9cekp+zs8Vs6XGvImm/F8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=je91UjK3HKLquMVSxqrCzmc1mqbXWtwTxYhmqOFBCahPQltzKl/HwBvO8dqmEcQ5/iUbp4wzOhbO9cBG9ZzWLjm9sQ040lrvom38jN0ImG1xI3Fpa4oPQBmXbC+1yXMQqCaWUkepPgOgRY9qu/cxU6dKBwfgGPKOC/P2srorFWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXtAIcoW; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7106e2d0ec1so4209301b3a.2
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 13:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723580334; x=1724185134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6hzyxXkxKKMRG59umRxXesL3i+mb0C6CMYrxnY87Cg=;
        b=gXtAIcoWk+uEkCtn0mcCELD1bbEZHbVPtQrP0G8IOJ6s2+QavFmJ6LtPTuJ0E0bGwS
         N7V69y4IFHNlpw9f4M4MMcoqIV3iTIU18JTFxjS7C9psdKtcTadcJM5MqyGRevb/Mq1E
         hisnsIHu1V/qNaxFT83QzIybooRoQJKkmXUpoQxofafSUKJR2T8fTUS6d2n7ZNqpcTbB
         54WzpvCakdgQItBswh8YsqOa1FF9VTl09rGZlN2MXFSk1XW43UJ7vl6ya9Dn8GN8OC5J
         TPkJKVjprjgqHJoIvOg8MPUFbtNDjJTi3Gz50EnmRIhGqcA6yXmXF3FfRU4ZemiHPfAi
         /ZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723580334; x=1724185134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6hzyxXkxKKMRG59umRxXesL3i+mb0C6CMYrxnY87Cg=;
        b=ChNDTNGZe0SNhpfnplkSq+X31fNknw1zNDYFfEuvQAd3XmcSW2/A8J/rvwlbCa8uzg
         rRQhlDXXHm8XmI/mQTDN4qH7t+cqgVpQsTuCqNGQPzwHna6F43LpR/Eds+bKlEY5knGW
         8Ss9UlXxG0fS0RiVsz66KsVY9fWaYmHqI2/icNoWnvtC6Xk440oKh5CWi6E71WM28S2S
         /DwnYfYx6ohucpKWy8J5aFbhuH+nUCXOmUFuFp6+v/pJD3jPiCEHoZBfcihmGBDuFSjM
         qZTLOYQUnFzRaq3jlNSxjuvxLjU461fNSBuSb41BVBIcFQEtdKiaX5ksmr5UO+wEkvlR
         EqKg==
X-Forwarded-Encrypted: i=1; AJvYcCXcTCoPj71ZVRiR9NRB7kKQHPZkB9cxrNMUhjnjx7+miy9ymh+Cu7r7TPy7EPE/+PCCJ3G1C1pP4kQ/BVIAoE3h5lta
X-Gm-Message-State: AOJu0YzjCmGb+h/oTateOE9sGZbhcKgUM6BJ/zbPmGEWRs2pRS1vHACv
	hG4tWLDBS4iJHunO6+pyZpRKM2NrZioli+27iMRj/UC5Sgrt+K+pPDBB07t07QpFmAR/osd0M2x
	qpsqcC3k09W3Q7obqWgRw+3UiJ9U=
X-Google-Smtp-Source: AGHT+IFcvRKhaipCKvRR5DYvkK0gUeE/gf+f2fxd/j1B1Q31aaUa4P1f5jVK/THZ7GtamlbLH+3mMzHxHLzDwLV3dt0=
X-Received: by 2002:a05:6a21:168c:b0:1c4:c305:121d with SMTP id
 adf61e73a8af0-1c8eaf5b144mr909810637.39.1723580334283; Tue, 13 Aug 2024
 13:18:54 -0700 (PDT)
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
 <CAADnVQL5rskNLC-f6z_Rg3Tjf7khis=pzNiKzJOMzvpw-R5wKg@mail.gmail.com>
 <CAEf4BzZVvdUYY5DRTLhmaZP7zssa1tBm1P1=96DvJWxfFP-xSw@mail.gmail.com> <CAADnVQJramfGwT7H5GBM1ss7zQ3mO4uy4UhHyVfx3S9PLthDTA@mail.gmail.com>
In-Reply-To: <CAADnVQJramfGwT7H5GBM1ss7zQ3mO4uy4UhHyVfx3S9PLthDTA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Aug 2024 13:18:42 -0700
Message-ID: <CAEf4BzZn1cu1Fke-ziaJx58eFNzyhGi78zxMZ_qSm+4h4LSr_w@mail.gmail.com>
Subject: Re: [bpf-next v3 1/2] bpf: Add bpf_copy_from_user_str kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jordan Rome <linux@jordanrome.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 11:30=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Aug 13, 2024 at 11:10=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Aug 13, 2024 at 9:08=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Aug 13, 2024 at 6:30=E2=80=AFAM Jordan Rome <linux@jordanrome=
.com> wrote:
> > > >
> > > > On Tue, Aug 13, 2024 at 6:27=E2=80=AFAM Jordan Rome <linux@jordanro=
me.com> wrote:
> > > > >
> > > > > On Mon, Aug 12, 2024 at 10:10=E2=80=AFPM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Aug 12, 2024 at 6:26=E2=80=AFPM Jordan Rome <linux@jord=
anrome.com> wrote:
> > > > > > >
> > > > > > > This adds a kfunc wrapper around strncpy_from_user,
> > > > > > > which can be called from sleepable BPF programs.
> > > > > > >
> > > > > > > This matches the non-sleepable 'bpf_probe_read_user_str'
> > > > > > > helper.
> > > > > > >
> > > > > > > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > > > > > > ---
> > > > > > >  kernel/bpf/helpers.c | 36 ++++++++++++++++++++++++++++++++++=
++
> > > > > > >  1 file changed, 36 insertions(+)
> > > > > > >
> > > > > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > > > > index d02ae323996b..e87d5df658cb 100644
> > > > > > > --- a/kernel/bpf/helpers.c
> > > > > > > +++ b/kernel/bpf/helpers.c
> > > > > > > @@ -2939,6 +2939,41 @@ __bpf_kfunc void bpf_iter_bits_destroy=
(struct bpf_iter_bits *it)
> > > > > > >         bpf_mem_free(&bpf_global_ma, kit->bits);
> > > > > > >  }
> > > > > > >
> > > > > > > +/**
> > > > > > > + * bpf_copy_from_user_str() - Copy a string from an unsafe u=
ser address
> > > > > > > + * @dst:             Destination address, in kernel space.  =
This buffer must be at
> > > > > > > + *                   least @dst__szk bytes long.
> > > > > > > + * @dst__szk:        Maximum number of bytes to copy, includ=
ing the trailing NUL.
> > > > > > > + * @unsafe_ptr__ign: Source address, in user space.
> > > > > > > + *
> > > > > > > + * Copies a NUL-terminated string from userspace to BPF spac=
e. If user string is
> > > > > > > + * too long this will still ensure zero termination in the d=
st buffer unless
> > > > > > > + * buffer size is 0.
> > > > > > > + */
> > > > > > > +__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__s=
zk, const void __user *unsafe_ptr__ign)
> > > > > > > +{
> > > > > > > +       int ret;
> > > > > > > +       int count;
> > > > > > > +
> > > > > > > +       if (unlikely(!dst__szk))
> > > > > > > +               return 0;
> > > > > > > +
> > > > > > > +       count =3D dst__szk - 1;
> > > > > > > +       if (unlikely(!count)) {
> > > > > > > +               ((char *)dst)[0] =3D '\0';
> > > > > > > +               return 1;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       ret =3D strncpy_from_user(dst, unsafe_ptr__ign, count=
);
> > > > > > > +       if (ret >=3D 0) {
> > > > > > > +               if (ret =3D=3D count)
> > > > > > > +                       ((char *)dst)[ret] =3D '\0';
> > > > > > > +               ret++;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       return ret;
> > > > > > > +}
> > > > > >
> > > > > > The above will not pad the buffer and it will create instabilit=
y
> > > > > > when the target buffer is a part of the map key. Consider:
> > > > > >
> > > > > > struct map_key {
> > > > > >    char str[100];
> > > > > > };
> > > > > > struct {
> > > > > >         __uint(type, BPF_MAP_TYPE_HASH);
> > > > > >         __type(key, struct map_key);
> > > > > > } hash SEC(".maps");
> > > > > >
> > > > > > struct map_key key;
> > > > > > bpf_copy_from_user_str(key.str, sizeof(key.str), user_string);
> > > > > >
> > > > > > The verifier will think that all of the 'key' is initialized,
> > > > > > but for short strings the key will have garbage.
> > > > > >
> > > > > > bpf_probe_read_kernel_str() has the same issue as above, but
> > > > > > let's fix it here first and update read_kernel_str() later.
> > > > > >
> > > > > > pw-bot: cr
> > > > >
> > > > > You're saying we should always do a memset using `dst__szk` on su=
ccess
> > > > > of copying the string?
> > > >
> > > > Something like this?
> > > > ```
> > > > ret =3D strncpy_from_user(dst, unsafe_ptr__ign, count);
> > > >   if (ret >=3D 0) {
> > > >     if (ret <=3D count)
> > > >        memset((char *)dst + ret, 0, dst__szk - ret);
> > > >     ret++;
> > > > }
> > > > ```
> > >
> > > yep. something like this. I didn't check the math.
> >
> > I'm a bit worried about this unconditional memset without having a way
> > to disable it. In practice, lots of cases won't use the destination
> > buffer as a map key, but rather just send it over ringbuf. So paying
> > the price of zeroing out seems unnecessary.
> >
> > It's quite often (I do that in retsnoop, for instance; and we have
> > other cases in our production) that we have a pretty big buffer, but
> > expect that most of the time strings will be much smaller. So we can
> > have a 1K buffer, but get 20 bytes of string content (and we end up
> > sending only actual useful size of data over ringbuf/perfbuf, so not
> > even paying 1K memcpy() overhead). Paying for memset()'ing the entire
> > 1K (and string reading can happen in a loop, so this memsetting will
> > be happening over and over, unnecessarily), seems excessive.
> >
> > Given it's pretty easy to do memset(0) using bpf_prober_read(dst, sz,
> > NULL), maybe we shouldn't do memsetting unconditionally? We can add a
> > loud comment stating the danger of using the resulting buffer as map
> > key without clearing the unfilled part of the buffer and that should
> > be sufficient?
>
> probe_read as memset is a quirk that folks learned to abuse.
> Let's add a flag to this bpf_copy_from_user_str() kfunc instead,
> so it behaves either like strscpy_pad or strscpy.

agreed, a flag sounds good

