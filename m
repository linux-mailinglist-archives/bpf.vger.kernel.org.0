Return-Path: <bpf+bounces-37054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BE79509D9
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 18:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFEA1F281F9
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9931A0AEA;
	Tue, 13 Aug 2024 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diQSzpS6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F34B1A0715
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565284; cv=none; b=akujH/opMFpB5MHx2BOcCBnh73mkr/W/tpnPWADoUJ8uN2x9ARGdDPkqxptoQndS2rrl/Db+dSYfw6xY7ax5POcEIu/qAvQzr+t+nhlNhoEGHDIgXUFfaw6V76Zg914BSct4eVFbKBKnoSROpT1873jRfKlxdgxVcttxLm6jOv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565284; c=relaxed/simple;
	bh=8iAaL5I0bFj1gmX71iQfpqPJUDDUwPIKazzlVQAH2vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGnIji8xVqLYfhsBB+HwZo/4kZ3eG+w0E+r+7iUNJRSdshgbHUpygpCe1he4JCWbFzlKrwKa2js2/VCoTXTnauEv6p+yjCY/XMGFy7FGHJGsaLbpMlM+YS9Kk/RLsywHirqxOk+n3EptsnRAq9NjmqWRuC2A58Eh3YtGc+3h/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diQSzpS6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3686b554cfcso2934952f8f.1
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 09:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723565281; x=1724170081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uo/heghG9iKkgyKQ5nsPN5FwXwIAAn+s3toov245TQ=;
        b=diQSzpS6FDnQNkWcQmw1a/BuL/qla8DiEucQ8r/f047ebkYIhgWLjp9F+rjLGaSWg1
         oDTl9thPKbYrK/DnrGR0otF/JjBYGZv1Cljp7cQlsCUuDP2VywZNZBK5cEUZj/ZughgS
         3Yw5re0+oqVN5mn+Io38oEr0HnmGXfdHkr/xBu9mOj6lfotN2wY0KA4LTUzKZkyoiYrr
         0DE1kgKir68HCfqg7hrxWCi00e6nAofh/Mufg90R7zQGrO/jhWYtxf3IKHj2Q4uoPv3Q
         fygj4thbSOS/+Ou2xKPc5N1rnNt3S7Y6KLJ8JKZ/ld4iLlb3FgpZF/YoZ3O9pViOWk84
         +K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723565281; x=1724170081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uo/heghG9iKkgyKQ5nsPN5FwXwIAAn+s3toov245TQ=;
        b=dENyYH6SdoIKa+QC/PV0Ohaq1LWmb6uajYGx1eyNsccuf/3xVHGVEEaOq0l1sme3Ec
         Mw6ye1Sdez8Woi66YwGqy05LDy6C943r7CgeXQb6Z565G3c6KsNOB103NeCA2NC0mK95
         KZMIwMp1ZumrNYm6nyDd0kKFD5Jb/Z7Oyi9jqtw62tY7hHozVkQqTACL6bApZtRBiqn5
         SqkziPwchlIWA7C5U8trq2VJn4Y4KNh8RUVLnB5vdZRorB0Uw08YK6zYHcCkpV/Cme9L
         VteuuXHtWRohHTdu9gqvHn0e4FWBy66lFWXtIROx4Q1jNZKF+4K64lynTnihFmYJ6+D6
         flmw==
X-Gm-Message-State: AOJu0YzQnV6Kr5SgKBBoz4dUvYsRQ/951oKka3HJx0qksI4OdN4e2z03
	6zaa3domI27Zq3c6UsmBSRylxORPTPAKpM6iz+lHTl4Hd5DonnzvJ3tpZl9FqVD8qL0J1ockqBr
	gb1BFQtOtNksBBNqqhlKyJoCFVf3ZGg==
X-Google-Smtp-Source: AGHT+IEAGbqufo6KIt/Z+MkvEH+oE8yIuKcwrYx2/+uHnPOwBRHZT2FLMRJbcBB59shRmWG6ZK/6j5Ao1FduPnnWJDc=
X-Received: by 2002:a5d:4283:0:b0:367:8926:812e with SMTP id
 ffacd0b85a97d-3717783283dmr42586f8f.62.1723565280369; Tue, 13 Aug 2024
 09:08:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813012528.3566133-1-linux@jordanrome.com>
 <CAADnVQ+cfn0SMQZwnCcv5VvCCixO+=CsTcF4bfjEYTpHPWngwA@mail.gmail.com>
 <CA+QiOd6WYqBHjDdG8OpRFby7MC2jh_YoXY2kTZt3YrmoY4J2ow@mail.gmail.com> <CA+QiOd5q3j1x+Pvt1Tpx3s+mA0HWfcwniSg11AJCsArZLWRhGA@mail.gmail.com>
In-Reply-To: <CA+QiOd5q3j1x+Pvt1Tpx3s+mA0HWfcwniSg11AJCsArZLWRhGA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Aug 2024 09:07:49 -0700
Message-ID: <CAADnVQL5rskNLC-f6z_Rg3Tjf7khis=pzNiKzJOMzvpw-R5wKg@mail.gmail.com>
Subject: Re: [bpf-next v3 1/2] bpf: Add bpf_copy_from_user_str kfunc
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 6:30=E2=80=AFAM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> On Tue, Aug 13, 2024 at 6:27=E2=80=AFAM Jordan Rome <linux@jordanrome.com=
> wrote:
> >
> > On Mon, Aug 12, 2024 at 10:10=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Aug 12, 2024 at 6:26=E2=80=AFPM Jordan Rome <linux@jordanrome=
.com> wrote:
> > > >
> > > > This adds a kfunc wrapper around strncpy_from_user,
> > > > which can be called from sleepable BPF programs.
> > > >
> > > > This matches the non-sleepable 'bpf_probe_read_user_str'
> > > > helper.
> > > >
> > > > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > > > ---
> > > >  kernel/bpf/helpers.c | 36 ++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 36 insertions(+)
> > > >
> > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > index d02ae323996b..e87d5df658cb 100644
> > > > --- a/kernel/bpf/helpers.c
> > > > +++ b/kernel/bpf/helpers.c
> > > > @@ -2939,6 +2939,41 @@ __bpf_kfunc void bpf_iter_bits_destroy(struc=
t bpf_iter_bits *it)
> > > >         bpf_mem_free(&bpf_global_ma, kit->bits);
> > > >  }
> > > >
> > > > +/**
> > > > + * bpf_copy_from_user_str() - Copy a string from an unsafe user ad=
dress
> > > > + * @dst:             Destination address, in kernel space.  This b=
uffer must be at
> > > > + *                   least @dst__szk bytes long.
> > > > + * @dst__szk:        Maximum number of bytes to copy, including th=
e trailing NUL.
> > > > + * @unsafe_ptr__ign: Source address, in user space.
> > > > + *
> > > > + * Copies a NUL-terminated string from userspace to BPF space. If =
user string is
> > > > + * too long this will still ensure zero termination in the dst buf=
fer unless
> > > > + * buffer size is 0.
> > > > + */
> > > > +__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, co=
nst void __user *unsafe_ptr__ign)
> > > > +{
> > > > +       int ret;
> > > > +       int count;
> > > > +
> > > > +       if (unlikely(!dst__szk))
> > > > +               return 0;
> > > > +
> > > > +       count =3D dst__szk - 1;
> > > > +       if (unlikely(!count)) {
> > > > +               ((char *)dst)[0] =3D '\0';
> > > > +               return 1;
> > > > +       }
> > > > +
> > > > +       ret =3D strncpy_from_user(dst, unsafe_ptr__ign, count);
> > > > +       if (ret >=3D 0) {
> > > > +               if (ret =3D=3D count)
> > > > +                       ((char *)dst)[ret] =3D '\0';
> > > > +               ret++;
> > > > +       }
> > > > +
> > > > +       return ret;
> > > > +}
> > >
> > > The above will not pad the buffer and it will create instability
> > > when the target buffer is a part of the map key. Consider:
> > >
> > > struct map_key {
> > >    char str[100];
> > > };
> > > struct {
> > >         __uint(type, BPF_MAP_TYPE_HASH);
> > >         __type(key, struct map_key);
> > > } hash SEC(".maps");
> > >
> > > struct map_key key;
> > > bpf_copy_from_user_str(key.str, sizeof(key.str), user_string);
> > >
> > > The verifier will think that all of the 'key' is initialized,
> > > but for short strings the key will have garbage.
> > >
> > > bpf_probe_read_kernel_str() has the same issue as above, but
> > > let's fix it here first and update read_kernel_str() later.
> > >
> > > pw-bot: cr
> >
> > You're saying we should always do a memset using `dst__szk` on success
> > of copying the string?
>
> Something like this?
> ```
> ret =3D strncpy_from_user(dst, unsafe_ptr__ign, count);
>   if (ret >=3D 0) {
>     if (ret <=3D count)
>        memset((char *)dst + ret, 0, dst__szk - ret);
>     ret++;
> }
> ```

yep. something like this. I didn't check the math.

