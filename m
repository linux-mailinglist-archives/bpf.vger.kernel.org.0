Return-Path: <bpf+bounces-23091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A878086D6C0
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 23:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7311C233C1
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 22:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994D674BF0;
	Thu, 29 Feb 2024 22:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HksWH4O/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966A174BEF
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709245179; cv=none; b=Nul7Pbp3m0BAdnTz+aIaHErEKRMXh3O/mqaUzQEs+DFF7EDSDjjObFDn18be6kgpKM1g/Z02w00dGvAicLpusHj3QASf0X2KbTIZufM2WBwwVDfDsFD/E+cv9DC24SxS1G8fidGIShqqC1+qPr9d9MacJyHlaaU1IdBSWCSCdns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709245179; c=relaxed/simple;
	bh=Fc+KBt6LlMcXUbqsCU4IdQ3s7nj+Hv9ofnR93Ht0lGw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fmc0dWEKjlkt0xF5bE7FGpBjVHWaOVbQkv8jxQkdZ/73MGF7pAZ25QMwvW3YHm0B8QxzH5eLzZHa5pO0o22rj4+IwedFQNnOJUOlMwidDU6I42eWsIO6BPeEAWb9NVPzSBNFfG/ns2S+U3kSanBwXRHzLawO+5KROUtOj6g5raQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HksWH4O/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e558a67f70so1451460b3a.0
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 14:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709245177; x=1709849977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDlUW5ucRkqgmv/Tj/e41+r62FnixbgJyc+Q4a26KOs=;
        b=HksWH4O/TvxpkzdxRrZXgiWEUS7OAp4jqYJB9+eOcPS1AA4IDfjnfWSXsDu7G0kNsg
         jjy7tSvWzEwxeWSGKUce/5Mt4XeDefeu5Wfjs+L1SyX8AO1yJgKlJY6iF5A2KWH1Fa6q
         0ty3AGIXfQmeQdurnK+/aAlIbCg9uWF+g3Zx6eTC6TzCpsgYghi5mkxaZLJxk1sdooUb
         fsVXH9CqfTFRGVOYziDXaQt1+WuF6qog5lJURpj2FIhn6yUPQ/cA+PTG8nxz3bwwnx8B
         ASWmqcPODnMS23WE9aR9nG8SBwY/3I2TBRW73QQy5b4ED6yex69zYzQ9Jzzl0P5GtM48
         UgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709245177; x=1709849977;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HDlUW5ucRkqgmv/Tj/e41+r62FnixbgJyc+Q4a26KOs=;
        b=a1DNlnT8VmesqjSWCCpnjRNbixWnr3Otv/FME5m7g5BHuekYaYXEibFnZ0m0Zi9NqM
         HirQTbZvHiq250MwS4EOdetTKKeDCV7+3M55CVqFeIHbvpqJU8ikTk+C6jzF3cT499yC
         l/gZbxnRm4ZnaQhIyO88yeYI9jsq+1RX7lTDpo7OnSXxAdry1JhuckR8aWuBU+G2nypn
         M+gXArHUniSbrYteKDduBro0LbJ0H91qi4CP6E24pJh3appECEzCdLpgZkvPHqZiIEqj
         TKZtbjWp+ukSFHcqXNvB62PuWCprNpXxQWGWl1hY6P3YRuZB0HXVFM3orQNoMNv1KgVs
         gdfw==
X-Forwarded-Encrypted: i=1; AJvYcCWs5dT/NBpoq5V1RaIW1kiRwSnFxSvENPztaLIs7w5gLX5kIas9qSHCwgABmF3fd8dlXupXLhUTjQrMfFg4eC0DsOHF
X-Gm-Message-State: AOJu0YxjwWKJcU7MMxC5s51xhs4eA1neLvpaKyzmRGH3Wq9AOPjAd7X0
	veOm8fCnd7JLdzCm3aZp+4+fs1bg0mX3nHoqStYeG+vz9GPXnOPO
X-Google-Smtp-Source: AGHT+IG63XDQSTEXpeNzM3anisHJsMTPz25xk+LkNpVbgq/H6jnS2tQAvX7cDqlSHlKJN53M8iRLZQ==
X-Received: by 2002:a05:6a00:3cca:b0:6e5:9342:f0fb with SMTP id ln10-20020a056a003cca00b006e59342f0fbmr24410pfb.14.1709245176782;
        Thu, 29 Feb 2024 14:19:36 -0800 (PST)
Received: from localhost ([98.97.43.160])
        by smtp.gmail.com with ESMTPSA id y13-20020aa7854d000000b006e56cc934b8sm1743951pfn.154.2024.02.29.14.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 14:19:36 -0800 (PST)
Date: Thu, 29 Feb 2024 14:19:34 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, 
 daniel@iogearbox.net, 
 john.fastabend@gmail.com, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 kpsingh@kernel.org, 
 sdf@google.com, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 bpf@vger.kernel.org
Message-ID: <65e102f6ebef2_33719208c8@john.notmuch>
In-Reply-To: <CAEf4BzYK4o558CcQt=yzKZH+M-eD3z0GpdUORcapJKXAHZJy-g@mail.gmail.com>
References: <20240225100637.48394-1-laoar.shao@gmail.com>
 <20240225100637.48394-2-laoar.shao@gmail.com>
 <CAEf4BzZfUnV+k6kGo1+JDhhQ1SOnTJ84M-0GVn0m66z9d6DiqQ@mail.gmail.com>
 <CALOAHbARukciMpoKCDGmPRWuczS8FYLxNOK41iaHUOy1gHhDpA@mail.gmail.com>
 <CAEf4Bza3DTS4H7t1bx5JrJSrZgmbKS6-4A_pRQjocWBPsD3RHQ@mail.gmail.com>
 <CALOAHbCH8q_xPJBW=Eq-nwsS9N-EVnwt_dkKS_RjdHZMGsqq0w@mail.gmail.com>
 <CAEf4BzYK4o558CcQt=yzKZH+M-eD3z0GpdUORcapJKXAHZJy-g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Add bits iterator
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko wrote:
> On Wed, Feb 28, 2024 at 6:16=E2=80=AFPM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> >
> > On Wed, Feb 28, 2024 at 2:04=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Feb 27, 2024 at 6:25=E2=80=AFPM Yafang Shao <laoar.shao@gma=
il.com> wrote:
> > > >
> > > > On Wed, Feb 28, 2024 at 9:24=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Sun, Feb 25, 2024 at 2:07=E2=80=AFAM Yafang Shao <laoar.shao=
@gmail.com> wrote:
> > > > > >
> > > > > > Add three new kfuncs for the bits iterator:
> > > > > > - bpf_iter_bits_new
> > > > > >   Initialize a new bits iterator for a given memory area. Due=
 to the
> > > > > >   limitation of bpf memalloc, the max number of bits that can=
 be iterated
> > > > > >   over is limited to (4096 * 8).
> > > > > > - bpf_iter_bits_next
> > > > > >   Get the next bit in a bpf_iter_bits
> > > > > > - bpf_iter_bits_destroy
> > > > > >   Destroy a bpf_iter_bits
> > > > > >
> > > > > > The bits iterator facilitates the iteration of the bits of a =
memory area,
> > > > > > such as cpumask. It can be used in any context and on any add=
ress.
> > > > > >
> > > > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > > > ---
> > > > > >  kernel/bpf/helpers.c | 100 +++++++++++++++++++++++++++++++++=
++++++++++
> > > > > >  1 file changed, 100 insertions(+)
> > > > > >
> > > > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > > > index 93edf730d288..052f63891834 100644
> > > > > > --- a/kernel/bpf/helpers.c
> > > > > > +++ b/kernel/bpf/helpers.c
> > > > > > @@ -2542,6 +2542,103 @@ __bpf_kfunc void bpf_throw(u64 cookie=
)
> > > > > >         WARN(1, "A call to BPF exception callback should neve=
r return\n");
> > > > > >  }
> > > > > >
> > > > > > +struct bpf_iter_bits {
> > > > > > +       __u64 __opaque[2];
> > > > > > +} __aligned(8);
> > > > > > +
> > > > > > +struct bpf_iter_bits_kern {
> > > > > > +       unsigned long *bits;
> > > > > > +       u32 nr_bits;
> > > > > > +       int bit;
> > > > > > +} __aligned(8);
> > > > > > +
> > > > > > +/**
> > > > > > + * bpf_iter_bits_new() - Initialize a new bits iterator for =
a given memory area
> > > > > > + * @it: The new bpf_iter_bits to be created
> > > > > > + * @unsafe_ptr__ign: A ponter pointing to a memory area to b=
e iterated over
> > > > > > + * @nr_bits: The number of bits to be iterated over. Due to =
the limitation of
> > > > > > + * memalloc, it can't greater than (4096 * 8).
> > > > > > + *
> > > > > > + * This function initializes a new bpf_iter_bits structure f=
or iterating over
> > > > > > + * a memory area which is specified by the @unsafe_ptr__ign =
and @nr_bits. It
> > > > > > + * copy the data of the memory area to the newly created bpf=
_iter_bits @it for
> > > > > > + * subsequent iteration operations.
> > > > > > + *
> > > > > > + * On success, 0 is returned. On failure, ERR is returned.
> > > > > > + */
> > > > > > +__bpf_kfunc int
> > > > > > +bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsa=
fe_ptr__ign, u32 nr_bits)
> > > > > > +{
> > > > > > +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> > > > > > +       u32 size =3D BITS_TO_BYTES(nr_bits);
> > > > > > +       int err;
> > > > > > +
> > > > > > +       BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) !=3D s=
izeof(struct bpf_iter_bits));
> > > > > > +       BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_kern) !=
=3D
> > > > > > +                    __alignof__(struct bpf_iter_bits));
> > > > > > +
> > > > > > +       if (!unsafe_ptr__ign || !nr_bits) {
> > > > > > +               kit->bits =3D NULL;
> > > > > > +               return -EINVAL;
> > > > > > +       }
> > > > > > +
> > > > > > +       kit->bits =3D bpf_mem_alloc(&bpf_global_ma, size);
> > > > > > +       if (!kit->bits)
> > > > > > +               return -ENOMEM;
> > > > >
> > > > > it's probably going to be a pretty common case to do bits itera=
tion
> > > > > for nr_bits<=3D64, right?
> > > >
> > > > It's highly unlikely.
> > > > Consider the CPU count as an example; There are 256 CPUs on our A=
MD
> > > > EPYC servers.
> > >
> > > Also consider u64-based bit masks (like struct backtrack_state in
> > > verifier code, which has u32 reg_mask and u64 stack_mask). This
> > > iterator is a generic bits iterator, there are tons of cases of
> > > u64/u32 masks in practice.
> >
> > Should we optimize it as follows?
> >
> >     if (nr_bits <=3D 64) {
> >         // do the optimization
> >     } else {
> >         // fallback to memalloc
> >     }
> >
> =

> Yep, that's what I'm proposing

When I suggested why not just open code this in BPF earlier I was
mostly thinking of these u64 and u32 masks we have lots of them
in our code base as well.

I have something like this which might be even better than 3
calls depending on your use case,

 int find_next_bit(uint64_t bits, int last_bit)
 {
    int i =3D last_bit;
    for (i =3D 0; i < sizeof(uint64_t) * 8; i++) {
        if (bits & (1 << i))
           return i;
    }
    return -1;
  }

Verifier seems plenty happy with above.

Thanks,
John=

