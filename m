Return-Path: <bpf+bounces-54145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8598CA637AD
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 23:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824B9188E950
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 22:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38C219F40A;
	Sun, 16 Mar 2025 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="QzokPHOU"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECD1EBE
	for <bpf@vger.kernel.org>; Sun, 16 Mar 2025 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742163669; cv=none; b=VW/X7FPhsy6tk6GFqnI1I9pKDR2iclWE86d4iSwgzfSMVKpWn2nOHwlocwQdfKw7h3Adc/ooZS3rMarsAHR1LiCHHguC/BPCexSnaApImFPpFZYxX4c4IlAe2ky5GDykfSZ2mOB4PLuJyQwmLcxQudTRT/n03eg9gYS0xVLPD+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742163669; c=relaxed/simple;
	bh=1U8RBuIp34KMHrC7gj/SOP8LYZGDIHiXZqstdPjdVmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/SlfZDqZ7z3YYpz81lT+1R98OK/U65zDTmGp+tE0alqi3gtcedyMBqhXtxgzOXVc675HqdNo/ze526P/LasvRyyP+MkTyhR3Mrm9gF2M88oociLTg0meNSknrfVhUbq02RAiUfMjG36+Js4CXZoO6uNkqcFUB1SbiXzI2OITlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=QzokPHOU; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1742163660; x=1742768460; i=linux@jordanrome.com;
	bh=gY6QjLOTEK6deiDulZWSJ5elEKhymg8qXLhOD0LDkiA=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QzokPHOUYO5XaULW3e486aeC21emgre3UF3Uw7kONIzaNffNrZP6xoZchWN6FHqt
	 QvuI8+tHIzefwbb/Jb5OyVPfFq0Z9jsusdjJsYbjHEJUlMTVDUkBqs8YOq7IkuKLq
	 ECfVwbXWQ+17TJebNzhqrW4InI19Gz9uLM39XVs1G2a8E4i8vHOo8dcQhj3f9JWKL
	 +xdAJI7CKAnKECuBpbrFXPm09RLFt1zheewOszpuoF+47ks2UUqbIc7XTVDVPvwpN
	 bbVfiukv128kVR7Z9XnQDMz3QWnW0ZAzkAaqJGwdJsv2E9+bh8dsthbi5ZHZ3rkVV
	 wv6sMZ0OHWMrN+gwAw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-io1-f42.google.com ([209.85.166.42]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MAx0f-1u4gvl0K7d-00FoZe
 for <bpf@vger.kernel.org>; Sun, 16 Mar 2025 23:21:00 +0100
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85b44094782so110972439f.3
        for <bpf@vger.kernel.org>; Sun, 16 Mar 2025 15:20:59 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw5mHf7RAuqYRWIenGfM38R9KFUhOsmqyzJsFIc4z7/Eqabq5Z7
	XySJm+Rpww+TK2R996fjsa3SJ11OlHDbQK/s1QeQmq3/AtKpavoMQLSuUXKmeG5Ifn3tyRekwj0
	AQvHubUj6kCdB1SxNYgEaLRhrulQ=
X-Google-Smtp-Source: AGHT+IEc6UQhuAwrGCZiI+w0pCKVkAVDJRS7DDqUYy9jTz/+a1GHfnBd/bSQr55XKoue+ghtU6alxjSI+TL44xii05M=
X-Received: by 2002:a05:6e02:3b88:b0:3d4:3ab3:daf0 with SMTP id
 e9e14a558f8ab-3d483a09c27mr124335575ab.7.1742163659528; Sun, 16 Mar 2025
 15:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312010358.3468811-1-linux@jordanrome.com>
 <CAEf4Bzb_TqinCgS92ehz8p00PQ=Z3U-8cTKBn9gfDu0Dh4EcNg@mail.gmail.com>
 <CA+QiOd66W5hajNCCbL+07xcCBnGUuSORwfDW5XC0Ev-w5Hgk+A@mail.gmail.com> <CAEf4BzZwwAyaToxUtmVDB-dQ7HGNcZT1ZquLH81r76A8t8u6uA@mail.gmail.com>
In-Reply-To: <CAEf4BzZwwAyaToxUtmVDB-dQ7HGNcZT1ZquLH81r76A8t8u6uA@mail.gmail.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Sun, 16 Mar 2025 18:20:47 -0400
X-Gmail-Original-Message-ID: <CA+QiOd4zH+YLgW2sQ_rsvV=LpkWaXhJHAX36w7y3PJPaopyM4g@mail.gmail.com>
X-Gm-Features: AQ5f1Jpei8Txj8awN3cu4wlNIjjsd0tZEIjl_BTZDbLFhYirRYzQ-xwCY9EwpO0
Message-ID: <CA+QiOd4zH+YLgW2sQ_rsvV=LpkWaXhJHAX36w7y3PJPaopyM4g@mail.gmail.com>
Subject: Re: [bpf-next v4] bpf: adjust btf load error logging
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9/gLX37d4y3OULc03/IlBniX345SgXwjSX+zMSwhtxyiAqeQRzr
 HcbTjDV5uLdxQQ1za25/F0Q1WTYQ3TzVhcqCPh26jBeDfxzMlkR6kkbn5epHTrWpA4kck70
 5fdhxEAlz0IxP/Z3hVTLNjR2aQozsLvTuT0r3L45gsnO0wXOKN/URdkznFKZtA/nGjCcScN
 izF25KUSdC9QTweCJ3TsA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1JKht0nHRPo=;xp4D9epf3LN6EuDdL2vacukDwAr
 mI1CNct9g8oPvVh9qugQKS1+lbMfeI2GIuG0KR5WcyJv5++QMhEzi4L5FzpNSkQcZav99mbqj
 wnqsZqmVf8aMGjfFmYC03z2Gp5Jvr0IzYFqFhUVyEnnDtrBKkrtiWftxEdTG8IRqRnh8EO0vh
 OL6H7z+RnlQ1VLq8gbgwJfdnhQ/xbdYBojfHYSue5lHaepWbzIQ8Puif4ISUNZknrWelE8xyp
 cluzuHQ5YR2eZ8mTOWK6CecIrsgSWaR7OWSIx1175Aq76lSGQctWObI/a8uvfHvYJq+x5GuBY
 pWNfV8AvhPfWemuK5wY12qqHOv6CEceo9aHBiWlS0CydGMZobEs1QzsYavrdrd5AtNZ4jtD5+
 Nk/r7/4/MCHxssKLIMiHkYCm0VYlV7wtv2UREJdbXhIbSIpyABatcGPj4R+7wN2zOaPXf8CV/
 3GCn1RuB17y6m5vuxZoUDtdH+mNIg/9GSJk5OP95o0rCFd4n/rFJH2RHlfXkvZNKV0r1Uq+/o
 WiwO19RSCv0Q1MOouL/gyUpifZSKPbt7rUvgYa51jCNP9C3YUY9xeOyFl+wvFTXlie7uYZFCd
 hSGRDB9bjWABkH30NtQMbpxa0sa5vzVHWl7w5GXm+zuBoJ++U3Xj8kMlUn4E+ZoBAPpMxZWSx
 mdsvbYfPCzeDK/wUE3gwE72qjqUmTmF/fb5GCcuvRPD7wL4KeySlYt0HorcnrP+k1s7tlQvDj
 mLuWzDPZY4k3nOj7PhssMkwCMy4rnQJJ7b7sGQEzJHfL1OmlX9npQsqCgbz8+WXodk1llRL52
 jxXXWM9NZzdy5Um0mfZKuRSRgEQGzsTs0nFY/YVHYQ6SQjeKcJcYxqooRXTzLCXrYNi5obTtw
 90riy/hun+6nStSzu1svrLJOFYTbHhhjyZPP3JIYNyRhABpqY7ErTWMec8tGRd6P8ZQZVBoQQ
 WFmDwUUw0onIILwIPrEtN0MfoQhnMKeauS9p3GJTMcxszR9skRqoHYDBWbdBZOaUv+dpSDg/U
 fId+AbAnIl3Rf67pEJaHVLwRhaf3qIQybK4BAfI9r+l23tWhxz1cAapeQI25leKwaa/vcbK9M
 7EpPX6qck5pOVhEu4AkpdFHGRjvAyHXqd6SvNji4mqakDglwTSRkaI/Bu/omojjTFZlna/Eac
 ToZjg+F77C891wugXQMILfgJEjQFiHK6yJHLCRf4Fwn1eoW8O48lzNa4CgUpHS5EU8knnHokX
 jaI82elkNA3qamYD85P+96dAeWajrcP1HZYuIiGKYhQwjFfvnhjvQLFB+1u5pEgVBgm7ihnTP
 choZkhfOUmLvK1aaesc33k3HyOwB6BAxnDeRV1lkjIqdZvakPrU6KSpPmaazFBE4rxKJVsY92
 tIm0shyiJg2VDyBg==

On Wed, Mar 12, 2025 at 3:31=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Mar 12, 2025 at 12:21=E2=80=AFPM Jordan Rome <linux@jordanrome.co=
m> wrote:
> >
> > On Wed, Mar 12, 2025 at 2:40=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Mar 11, 2025 at 6:04=E2=80=AFPM Jordan Rome <linux@jordanrome=
.com> wrote:
> > > >
> > > > For kernels where btf is not mandatory
> > > > we should log loading errors with `pr_info`
> > > > and not retry where we increase the log level
> > > > as this is just added noise.
> > > >
> > > > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > > > ---
> > > >  tools/lib/bpf/btf.c             | 36 ++++++++++++++++++-----------=
----
> > > >  tools/lib/bpf/libbpf.c          |  3 ++-
> > > >  tools/lib/bpf/libbpf_internal.h |  2 +-
> > > >  3 files changed, 23 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > > index eea99c766a20..7da4807451bb 100644
> > > > --- a/tools/lib/bpf/btf.c
> > > > +++ b/tools/lib/bpf/btf.c
> > > > @@ -1379,9 +1379,10 @@ static void *btf_get_raw_data(const struct b=
tf *btf, __u32 *size, bool swap_endi
> > > >
> > > >  int btf_load_into_kernel(struct btf *btf,
> > > >                          char *log_buf, size_t log_sz, __u32 log_le=
vel,
> > > > -                        int token_fd)
> > > > +                        int token_fd, bool btf_mandatory)
> > > >  {
> > > >         LIBBPF_OPTS(bpf_btf_load_opts, opts);
> > > > +       enum libbpf_print_level print_level;
> > > >         __u32 buf_sz =3D 0, raw_size;
> > > >         char *buf =3D NULL, *tmp;
> > > >         void *raw_data;
> > > > @@ -1435,22 +1436,25 @@ int btf_load_into_kernel(struct btf *btf,
> > > >
> > > >         btf->fd =3D bpf_btf_load(raw_data, raw_size, &opts);
> > > >         if (btf->fd < 0) {
> > > > -               /* time to turn on verbose mode and try again */
> > > > -               if (log_level =3D=3D 0) {
> > > > -                       log_level =3D 1;
> > > > -                       goto retry_load;
> > > > +               if (btf_mandatory) {
> > > > +                       /* time to turn on verbose mode and try aga=
in */
> > > > +                       if (log_level =3D=3D 0) {
> > > > +                               log_level =3D 1;
> > > > +                               goto retry_load;
> > > > +                       }
> > > > +                       /* only retry if caller didn't provide cust=
om log_buf, but
> > > > +                        * make sure we can never overflow buf_sz
> > > > +                        */
> > > > +                       if (!log_buf && errno =3D=3D ENOSPC && buf_=
sz <=3D UINT_MAX / 2)
> > >
> > > Original behavior was to go from log_level 0 to log_level 1 when the
> > > user provided custom log_buf, which would happen even for
> > > non-btf_mandatory case. I'd like to not change that behavior.
> > >
> >
> > I don't quite understand why we want to increase the log level
> > if btf is not mandatory. Users will still get an info message that
> > btf failed to load and if they are still curious, they can increase
> > the log level themselves right? The goal of this patch is to reduce
> > log noise in cases where btf fails to load and is not mandatory.
>
> Program's BTF is almost always not mandatory, so we'll basically never
> log BTF verification failure (only for struct_ops stuff), even with
> user-provided custom log buffer, which makes this whole logic much
> less useful.
>
> Perhaps we just need to keep existing logic as is? It's not expected
> for BTF to fail to be loaded into the kernel, even for old kernels.
> libbpf does BTF sanitization for that reason. So when this BTF loading
> fails, it usually does indicate a real issue.
>
> That's exactly what happened with the original issue that prompted
> your patches. And that's a good thing that the user was bothered by
> those warnings, which eventually led to fixing an issue with a missing
> patch in their backported kernel, right?
>
> Let's just keep things as is for now. I'd rather users complain about
> this rather than these BTF upload failures go unnoticed forever.
>

Fair enough.

> >
> > > Did you find some problem with the code I proposed a few emails back?
> >
> > Truth be told, I didn't like the added complexity in the conditionals.
> > I tried something similar in an earlier version and it led to a SEGFAUL=
T
> > when trying to access `buf[0]` which had not been allocated.
> >
> > > If not, why not do that instead and preserve that custom log_buf and
> > > log_level upgrade behavior?
> > >
> > > pw-bot: cr
> > >
>
> [...]

