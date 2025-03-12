Return-Path: <bpf+bounces-53871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 257BEA5D39C
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 01:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29231881F9C
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 00:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91CE2594;
	Wed, 12 Mar 2025 00:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="g3StCKef"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38611C32
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 00:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741738301; cv=none; b=ZPWDZ917ZC+lgUpSXdKPXvCoJG9PyS05coy5MoUwvAErEKRLvnNmbgBvql/qDfExlHbqTyUaCicmrG9ACibT7P+M0WC/XIXwJVe75Kj0qtCmZ7QNtpnWZwFbsSUA9AG/jQVGrFca1e2qtIWoCQaTq6g/kpICJCsRsxX4NStriBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741738301; c=relaxed/simple;
	bh=XdMHoicrtfZnb9ZMBEEuD8xJMvWWSNlqUQrt1IhxCBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CW4XE0R1S8pCZDNkO7ZwQuwUlivW3FnkynLmKhppBbth2qA+A92YCywE/Uzg1KFT7Ab8XidfzyWoDbs51Q5eiQWYvxMg1ICXFUwRlKdlwMKJ078KFDh0FOJuz8+SlqSaFPyHvfODxy1ZztMmgyMPgUYkO6D4spKRk7FRxsKDyVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=g3StCKef; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1741738292; x=1742343092; i=linux@jordanrome.com;
	bh=zQ7MdJD3628uX7sn500WT/DNL5b6N15rQ85MRrkX7lw=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g3StCKefedcnPGQt1FMtlBMFlQhtuMnRR8KF8fkDN9GBXjnrBh/anny4SGHmpFxq
	 WhXKYYgQGFTVGhkBNcF+en3ZUyTa5660ItbuBdxNQsCtvccbO6YsryHNCQajbBCf1
	 o3zclA+p08O9+pa1gmLmoTRQEkwWpIhOmU1VbqXaO2ZnY+evzS2FDsUL4EtFdSUYn
	 4V2gyk15rhSgD46PZN8g45mvvXNEBRF8pyXSqoQSrNYaggkc6dlE8VG+tneKhLLXf
	 tuRmQMKsn90fK0EPXkTv6GSP2+yDLniF7r9SSntqfGaave6PvZ4hYicYdc4gPNv12
	 ArvSnJlqSpn3Quz5cg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-il1-f182.google.com ([209.85.166.182]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1Mna9J-1tT24f1VHJ-00qmDF for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 01:11:32
 +0100
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d442a77a03so14173735ab.1
        for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 17:11:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YwTNjI0M1SK9iY7EdwRgSilXm/MIkivchrVhxx9kfoiXWsgHJI/
	eOnt80dJeS6fBePFn4zBQwDJkJBuWb2gVh7sg/XpcCBR0JPeirPj+9pNjqlA/wcgPebPL29XhMN
	jVwbR6MwLKZt+7FhHv3kG2ACw1uU=
X-Google-Smtp-Source: AGHT+IGR6FWgfhU5T9P30/rvyFEKCkIFaVz1N7deWfV1HIwRYZXKRrknGGa/ZNAOwA2RnA6mOmYjo6EkwmCCkU11KBc=
X-Received: by 2002:a05:6e02:156d:b0:3d3:fdb8:1792 with SMTP id
 e9e14a558f8ab-3d441a39d87mr147396645ab.14.1741738291851; Tue, 11 Mar 2025
 17:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307150016.2172675-1-linux@jordanrome.com> <CAEf4BzbEPm22eV=LFvJTkMp0OQeScp2MnKT4oy7RPdygmcqdvg@mail.gmail.com>
In-Reply-To: <CAEf4BzbEPm22eV=LFvJTkMp0OQeScp2MnKT4oy7RPdygmcqdvg@mail.gmail.com>
From: Jordan Rome <linux@jordanrome.com>
Date: Tue, 11 Mar 2025 20:11:20 -0400
X-Gmail-Original-Message-ID: <CA+QiOd50wxXScrE2ctzsS8qHs1iiKfYu=fqmP+BycNxFf+iBdA@mail.gmail.com>
X-Gm-Features: AQ5f1JogIiNbBYZ7g-jRobcBaVYTZ-2-R0B9OFHlPqYujpUz1eQX7l4hhkEC0u0
Message-ID: <CA+QiOd50wxXScrE2ctzsS8qHs1iiKfYu=fqmP+BycNxFf+iBdA@mail.gmail.com>
Subject: Re: [bpf-next v3] bpf: adjust btf load error logging
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tsdKF7JkdigQ8Gx3B9VHI01eRYWOHr8NVOeI19l6lWLBS+aF/Bv
 SX4S/rsVTwhna8NzmGx+3Hlh88+SD+O7S99IsuyhJZqLkYzaYHzsLg2RiaTZEmL6eiP3upq
 f0M9Tzq4SYlD+HtH0UWFoQpD8sKFnveoq29MN8lqag8skv9CT4gPNZOL3xZdLHf3PvWaTDU
 G4MPNNS1KpJ8qMQjmlyDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rGCuCAWSBrI=;RElVlpo4Zp1hkkFRUPXosBGzONf
 3V8DhFaa0ZmKHrM47qrygBdngWz9oUiGkoPZKDwe7KlqLzSmYE35DTIM1z0EtvG71zvujyp/4
 BpFxyiX5Y6CqwcodAlfADBEQ5ywPRNn7hgbD9ReCGGDGSsW6JHnuViMH0y09mJk4PSTjT2tEF
 6Gfd1/ghb09khZnxnMiSruIfFmPP6SKZoenK//LD7vMIBrvwWzRt7WEHSmVZfbyxwkfGwS5bS
 SIYOQ6HBXEUxCOquftnh4fTm4QZmfq62xgaXoFM5u3SmKjjNhTmELXK9To4tRyFuDvPGuXIGN
 J2U8yoS74gfewSZIKD19mW97rogcruVgXf+oX5FgRaE2ADFN7Z3Q7btRA4B5miUdS4kHRcBxv
 pnAacrePOq0stMovQqmwlACdrVGYheIfs5pQdZZMsMLzMY89w7gCJkGXgjGfq7U9ecKeRq7PN
 7+91T0X89DH0zkB5HZWXhGNeFjYNgoAglNXsUC1d5nn6uW7/lk8V5BF/RV64HuVDsOPpgQmGr
 spr7amNznteji3drypio7iBhDUe9P5D3IkqHWP3IYNYRA6g0wVcRYy+PpG5XYWHSHaUt7a5yq
 vxp5WAUUUwUHzyVNIIqEdkbGRZ9V5sAcn76dDU1zNQ+WpPceuHnJHjKW0aypoRGKFxfw0C/yn
 MTnFtlSawofqy+tW1r5CHpufAWmX/DAopgcd+sshbnbW1k6xZ4GnaBqL09btmkWSENfidxjA6
 WjopTXEPxqinYWRR82OIp9j2ME9M2XfIT2lyCGPZgzQswJWtSCC++BCFCu4BHKYggJKwGfbi3
 PWI0NZKylf0yjO4sofDEvKmb1tI0f+3PHkJY51qYXcB31B7DQsD0VLpGEhiMSEeSsjrdhXSNU
 FJKEmpAWLxKHKBxcfriO9drohvsHj48tCS3pwI6Wh/ZXJxJk3oo+onqcxzRtJEiC6ueT1VBgs
 v9nnLzcVkI/8LD8o5izrVwnXYbjNTB6TbmTTircu0L4S4e/hSOydp/BEvYk9ho6J9tcbZJui0
 +8tzrrlPCIn9L14qm0HuDJIE8Y1V3U3Z2t2QTjhyx0jR1DhCZi66x2y5y8e9NoNB8SdivGFuk
 yTE1zORp65vJdoEqYu0Fox1Ox+EzKXGgUI9LCUmpk8blHWLWjZ1qrHukz7vKQL3QtadhCFXtF
 /CpFzbZH9xq91hk3p9t2H/DJBP+CGJQZ1KumPnnixDclhd9ts6C4MrSIhpEBvJCFaB1iLthwq
 pzL2DuXsxpUhd+tBWcO4Wvz5R3bOGZBPqlOUN9/OhaLCZOncS4v7vk1D2QRsPYiMfDQHWjQmM
 GISn0vFgt4dq/q0AwXNdnakRAynDopLukq0CY9yiIbmljd6S34Hcqgc6W0t+mMsCFnj

On Mon, Mar 10, 2025 at 8:10=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 7, 2025 at 7:00=E2=80=AFAM Jordan Rome <linux@jordanrome.com>=
 wrote:
> >
> > For kernels where btf is not mandatory
> > we should log loading errors with `pr_info`
> > and not retry where we increase the log level
> > as this is just added noise.
> >
> > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > ---
> >  tools/lib/bpf/btf.c             | 16 ++++++++++++----
> >  tools/lib/bpf/libbpf.c          |  3 ++-
> >  tools/lib/bpf/libbpf_internal.h |  2 +-
> >  3 files changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index eea99c766a20..c8139c3bc9e0 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -1379,7 +1379,7 @@ static void *btf_get_raw_data(const struct btf *b=
tf, __u32 *size, bool swap_endi
> >
> >  int btf_load_into_kernel(struct btf *btf,
> >                          char *log_buf, size_t log_sz, __u32 log_level,
> > -                        int token_fd)
> > +                        int token_fd, bool btf_mandatory)
> >  {
> >         LIBBPF_OPTS(bpf_btf_load_opts, opts);
> >         __u32 buf_sz =3D 0, raw_size;
> > @@ -1435,6 +1435,15 @@ int btf_load_into_kernel(struct btf *btf,
> >
> >         btf->fd =3D bpf_btf_load(raw_data, raw_size, &opts);
> >         if (btf->fd < 0) {
> > +               if (!btf_mandatory) {
> > +                       err =3D -errno;
> > +                       pr_info("BTF loading error: %s\n", errstr(err))=
;
> > +
> > +                       if (!log_buf && log_level)
> > +                               pr_info("-- BEGIN BTF LOAD LOG ---\n%s\=
n-- END BTF LOAD LOG --\n", buf);
>
> I'm not a fan of duplicating this. Wouldn't something along the
> following lines work as well?
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index eea99c766a20..fc06f3a8e8d7 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1436,18 +1436,19 @@ int btf_load_into_kernel(struct btf *btf,
>         btf->fd =3D bpf_btf_load(raw_data, raw_size, &opts);
>         if (btf->fd < 0) {
>                 /* time to turn on verbose mode and try again */
> -               if (log_level =3D=3D 0) {
> +               if (log_level =3D=3D 0 && (log_buf || btf_mandatory)) {
>                         log_level =3D 1;
>                         goto retry_load;
>                 }
>                 /* only retry if caller didn't provide custom log_buf, bu=
t
>                  * make sure we can never overflow buf_sz
>                  */
> -               if (!log_buf && errno =3D=3D ENOSPC && buf_sz <=3D UINT_M=
AX / 2)
> +               if (!log_buf && btf_mandatory && errno =3D=3D ENOSPC &&
> buf_sz <=3D UINT_MAX / 2)
>                         goto retry_load;
>
>                 err =3D -errno;
> -               pr_warn("BTF loading error: %s\n", errstr(err));
> +               __pr(btf_mandatory ? LIBBPF_WARN : LIBBPF_INFO,
> +                    "BTF loading error: %s\n", errstr(err));
>                 /* don't print out contents of custom log_buf */
>                 if (!log_buf && buf[0])
>                         pr_warn("-- BEGIN BTF LOAD LOG ---\n%s\n-- END
> BTF LOAD LOG --\n", buf);
>
>
> pw-bot: cr
>

Let me try another version where we don't complicate the conditionals too m=
uch
and don't repeat the log messages.

> > +                       goto done;
> > +               }
> > +
> >                 /* time to turn on verbose mode and try again */
> >                 if (log_level =3D=3D 0) {
> >                         log_level =3D 1;
> > @@ -1448,8 +1457,7 @@ int btf_load_into_kernel(struct btf *btf,
> >
> >                 err =3D -errno;
> >                 pr_warn("BTF loading error: %s\n", errstr(err));
> > -               /* don't print out contents of custom log_buf */
> > -               if (!log_buf && buf[0])
> > +               if (!log_buf && log_level)
> >                         pr_warn("-- BEGIN BTF LOAD LOG ---\n%s\n-- END =
BTF LOAD LOG --\n", buf);
> >         }
> >
> > @@ -1460,7 +1468,7 @@ int btf_load_into_kernel(struct btf *btf,
> >
> >  int btf__load_into_kernel(struct btf *btf)
> >  {
> > -       return btf_load_into_kernel(btf, NULL, 0, 0, 0);
> > +       return btf_load_into_kernel(btf, NULL, 0, 0, 0, true);
> >  }
> >
> >  int btf__fd(const struct btf *btf)
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 8e32286854ef..2cb3f067a12e 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -3604,9 +3604,10 @@ static int bpf_object__sanitize_and_load_btf(str=
uct bpf_object *obj)
> >                  */
> >                 btf__set_fd(kern_btf, 0);
> >         } else {
> > +               btf_mandatory =3D kernel_needs_btf(obj);
> >                 /* currently BPF_BTF_LOAD only supports log_level 1 */
> >                 err =3D btf_load_into_kernel(kern_btf, obj->log_buf, ob=
j->log_size,
> > -                                          obj->log_level ? 1 : 0, obj-=
>token_fd);
> > +                                          obj->log_level ? 1 : 0, obj-=
>token_fd, btf_mandatory);
> >         }
> >         if (sanitize) {
> >                 if (!err) {
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_int=
ernal.h
> > index de498e2dd6b0..f1de2ba462c3 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -408,7 +408,7 @@ int libbpf__load_raw_btf(const char *raw_types, siz=
e_t types_len,
> >                          int token_fd);
> >  int btf_load_into_kernel(struct btf *btf,
> >                          char *log_buf, size_t log_sz, __u32 log_level,
> > -                        int token_fd);
> > +                        int token_fd, bool btf_mandatory);
> >
> >  struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf);
> >  void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
> > --
> > 2.43.5
> >

