Return-Path: <bpf+bounces-13990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2CF7DF884
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 18:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB3F1C20F8A
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33CD1DFCD;
	Thu,  2 Nov 2023 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqPQpbpI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD43A1DFC5
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 17:16:32 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB7A186
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 10:16:30 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9c603e2354fso240111366b.1
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698945388; x=1699550188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gd2Fs3GfhrEEJME/1JQNTfULynbPV+EasVl0KfnSo0g=;
        b=DqPQpbpIydExR8lisxXr2o0vLLtkOAoJlmqk5t2xhL+HN6U/1lKo/XItWuFQ8Sub/6
         i9RKbXO/+qdqmHaRqBS86dStzzOdeFljfg6nXdmbC5yZzCc8mqEoTgbqjt/uV3YG13IP
         RrZbHFv6k/PIWMmwlYPvihBe2EejPvObR8cfwqaPLypo7CFzYiiv9lYuO/UHqqZJgRej
         YbsNQy6Y8XMIX4riOOI80RaXYwNjGA0dZhlEf+T4m2qKNGl13fTKcBHg00C950Q1ac7k
         IuH+uxYrGaezaVMAkzb3JLkFn1WM5OPJrCcTnakNsM2cLHiYpTtQquBySkEeACwEhH85
         AGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698945388; x=1699550188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gd2Fs3GfhrEEJME/1JQNTfULynbPV+EasVl0KfnSo0g=;
        b=lbn6/BT2MZgVE1Rvc5vPsjMb0LyJKc3N1VuLagPAlQTTRh7n6t0aV4+Ni1CBWaBMeB
         luYXWvCZNxVrcrHQfI6zgnNvcDYzKnP8pMKUKe5osxn6poW0BdcKqkvNIZAj9Xsc9eWx
         ifI9dCvbplwCeSo03sVbX/M8ugJVcEows5ETi9UCiYj1as64dDsrI3pDG6t2U0xbDyWl
         zysmcGWEVu36uz637c0oSrpBaZAMJbQb3ogKjGLPMAsfb22pB55JJE7tW+sYVRJR6TfJ
         ZBOhblGTjGvqSDgwse0vO3P8DxiBRPdxBGPUkTPGmRWeGB/ZTQRcTwZnPBjyoZE5a427
         Oz0A==
X-Gm-Message-State: AOJu0YwWyVIgb9ChRD/R1BpjkpoJHplYCkg9EW2VFfsBb86j+oTOwjRJ
	edWmeNaOllLJNRmmT34Wd/IvyoDeGEJOUxEWn80=
X-Google-Smtp-Source: AGHT+IFmj6ncFqt7SUbCMeywVPQb8uDH5NpTMbtGAf7UXDd/+Hus/PLPbJRJnWModdcLjyPcoQY+WKqeOPoKCBxVv94=
X-Received: by 2002:a17:906:f190:b0:9c7:6523:407b with SMTP id
 gs16-20020a170906f19000b009c76523407bmr115498ejb.17.1698945388260; Thu, 02
 Nov 2023 10:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024235551.2769174-1-song@kernel.org> <20231024235551.2769174-2-song@kernel.org>
 <CAEf4Bzbr8dgksh2z+4nEkAFdV9gquhR+HROULKdTkWrUpSM9-Q@mail.gmail.com> <CAEf4BzbDFDX30Y_Hcmd__hgDp+m6X+htr-wTeBtaoauEnrEdLw@mail.gmail.com>
In-Reply-To: <CAEf4BzbDFDX30Y_Hcmd__hgDp+m6X+htr-wTeBtaoauEnrEdLw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Nov 2023 10:16:16 -0700
Message-ID: <CAEf4BzaD+FV_PM8_4yWnZVed9pXE-KX6CwpYEmiUDpMRQDNEXQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/9] bpf: Expose bpf_dynptr_slice* kfuncs for
 in kernel use
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ebiggers@kernel.org, tytso@mit.edu, 
	roberto.sassu@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 10:09=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 2, 2023 at 9:56=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Oct 24, 2023 at 4:56=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> > >
> > > kfuncs bpf_dynptr_slice and bpf_dynptr_slice_rdwr are used by BPF pro=
grams
> > > to access the dynptr data. They are also useful for in kernel functio=
ns
> > > that access dynptr data, for example, bpf_verify_pkcs7_signature.
> > >
> > > Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr to bpf.h so that kerne=
l
> > > functions can use them instead of accessing dynptr->data directly.
> > >
> > > Update bpf_verify_pkcs7_signature to use bpf_dynptr_slice instead of
> > > dynptr->data.
> > >
> > > Also, update the comments for bpf_dynptr_slice and bpf_dynptr_slice_r=
dwr
> > > that they may return error pointers for BPF_DYNPTR_TYPE_XDP.
> > >
> > > Signed-off-by: Song Liu <song@kernel.org>
> > > ---
> > >  include/linux/bpf.h      |  4 ++++
> > >  kernel/bpf/helpers.c     | 16 ++++++++--------
> > >  kernel/trace/bpf_trace.c | 15 +++++++++++----
> > >  3 files changed, 23 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index b4825d3cdb29..3ed3ae37cbdf 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -1222,6 +1222,10 @@ enum bpf_dynptr_type {
> > >
> > >  int bpf_dynptr_check_size(u32 size);
> > >  u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
> > > +void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset=
,
> > > +                      void *buffer__opt, u32 buffer__szk);
> > > +void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 o=
ffset,
> > > +                           void *buffer__opt, u32 buffer__szk);
> > >
> > >  #ifdef CONFIG_BPF_JIT
> > >  int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf=
_trampoline *tr);
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index e46ac288a108..af5059f11e83 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -2270,10 +2270,10 @@ __bpf_kfunc struct task_struct *bpf_task_from=
_pid(s32 pid)
> > >   * bpf_dynptr_slice will not invalidate any ctx->data/data_end point=
ers in
> > >   * the bpf program.
> > >   *
> > > - * Return: NULL if the call failed (eg invalid dynptr), pointer to a=
 read-only
> > > - * data slice (can be either direct pointer to the data or a pointer=
 to the user
> > > - * provided buffer, with its contents containing the data, if unable=
 to obtain
> > > - * direct pointer)
> > > + * Return: NULL or error pointer if the call failed (eg invalid dynp=
tr), pointer
> >
> > Hold on, nope, this one shouldn't return error pointer because it's
> > used from BPF program side and BPF program is checking for NULL only.
> > Does it actually return error pointer, though?
>
> So I just checked the code (should have done it before replying,
> sorry). It is a bug that slipped through when adding bpf_xdp_pointer()
> usage. We should always return NULL from this kfunc on error
> conditions. Let's fix it separately, but please don't change the
> comments.
>
> >
> > I'm generally skeptical of allowing to call kfuncs directly from
> > internal kernel code, tbh, and concerns like this are one reason why.
> > BPF verifier sets up various conditions that kfuncs have to follow,
> > and it seems error-prone to mix this up with internal kernel usage.
> >
>
> Reading bpf_dynptr_slice_rdwr code, it does look exactly like what you
> want, despite the confusingly-looking 0, NULL, 0 arguments. So I guess
> I'm fine exposing it directly, but it still feels like it will bite us
> at some point later.

Ok, now I'm at patch #5. Think about what you are doing here. You are
asking bpf_dynptr_slice_rdrw() if you can get a directly writable
pointer to a data area of length *zero*. So if it's SKB, for example,
then yeah, you'll be granted a pointer. But then you are proceeding to
write up to sizeof(struct fsverity_digest) bytes, and that can cross
into non-contiguous memory.

So I'll take it back, let's not expose this kfunc directly to kernel
code. Let's have a separate internal helper that will return either
valid pointer or NULL for a given dynptr, but will require valid
non-zero max size. Something with the signature like below

void * __bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len);

If ptr can provide a direct pointer to memory of length *len*, great.
If not, return NULL. This will be an appropriate internal API for all
the use cases you are adding where we will be writing back into dynptr
from other kernel APIs with the assumption of contiguous memory
region.



>
>
> > > + * to a read-only data slice (can be either direct pointer to the da=
ta or a
> > > + * pointer to the user provided buffer, with its contents containing=
 the data,
> > > + * if unable to obtain direct pointer)
> > >   */
> > >  __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr=
, u32 offset,
> > >                                    void *buffer__opt, u32 buffer__szk=
)
> > > @@ -2354,10 +2354,10 @@ __bpf_kfunc void *bpf_dynptr_slice(const stru=
ct bpf_dynptr_kern *ptr, u32 offset
> > >   * bpf_dynptr_slice_rdwr will not invalidate any ctx->data/data_end =
pointers in
> > >   * the bpf program.
> > >   *
> > > - * Return: NULL if the call failed (eg invalid dynptr), pointer to a
> > > - * data slice (can be either direct pointer to the data or a pointer=
 to the user
> > > - * provided buffer, with its contents containing the data, if unable=
 to obtain
> > > - * direct pointer)
> > > + * Return: NULL or error pointer if the call failed (eg invalid dynp=
tr), pointer
> > > + * to a data slice (can be either direct pointer to the data or a po=
inter to the
> > > + * user provided buffer, with its contents containing the data, if u=
nable to
> > > + * obtain direct pointer)
> > >   */
> > >  __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern=
 *ptr, u32 offset,
> > >                                         void *buffer__opt, u32 buffer=
__szk)
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index df697c74d519..2626706b6387 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -1378,6 +1378,7 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(stru=
ct bpf_dynptr_kern *data_ptr,
> > >                                struct bpf_dynptr_kern *sig_ptr,
> > >                                struct bpf_key *trusted_keyring)
> > >  {
> > > +       void *data, *sig;
> > >         int ret;
> > >
> > >         if (trusted_keyring->has_ref) {
> > > @@ -1394,10 +1395,16 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(st=
ruct bpf_dynptr_kern *data_ptr,
> > >                         return ret;
> > >         }
> > >
> > > -       return verify_pkcs7_signature(data_ptr->data,
> > > -                                     __bpf_dynptr_size(data_ptr),
> > > -                                     sig_ptr->data,
> > > -                                     __bpf_dynptr_size(sig_ptr),
> > > +       data =3D bpf_dynptr_slice(data_ptr, 0, NULL, 0);
> > > +       if (IS_ERR(data))
> > > +               return PTR_ERR(data);
> > > +
> > > +       sig =3D bpf_dynptr_slice(sig_ptr, 0, NULL, 0);
> > > +       if (IS_ERR(sig))
> > > +               return PTR_ERR(sig);
> > > +
> > > +       return verify_pkcs7_signature(data, __bpf_dynptr_size(data_pt=
r),
> > > +                                     sig, __bpf_dynptr_size(sig_ptr)=
,
> > >                                       trusted_keyring->key,
> > >                                       VERIFYING_UNSPECIFIED_SIGNATURE=
, NULL,
> > >                                       NULL);
> > > --
> > > 2.34.1
> > >
> > >

