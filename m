Return-Path: <bpf+bounces-14334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858487E2FF4
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 23:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10FCE280D63
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 22:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDAC1CF95;
	Mon,  6 Nov 2023 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKGWZqnt"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539521CF92
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 22:41:02 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B76DD51
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 14:41:00 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9dd3f4a0f5aso515392966b.1
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 14:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699310459; x=1699915259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxY9zXUG0PvjEP+fiwMUAi3gc50qQYOPjUmna5NAa34=;
        b=XKGWZqnt4LDuItZ+qat5iiSqNegfkd7SZ+c/QnALP698AwC904VavFwXSAt1JMNxId
         QUp19uVDKbe/nbP6nANWR2ZRtMVH/JWVe1+wdnNFnu9gWZBFlxmXg0GVY12cVxpte1NB
         a4vQVCMeT1ZXQtU/gHpLGjvjSsnX1O8RtHUx9b7M6S84ElmKnHwgHT4RvdXBDDcYfSgv
         +xAvVme4xdb4zxoYGVR9ImiqV4oPvIlQbrlXfW/MB40bmiYFOtfG6lS2GmDsxGCdYZo7
         n3Vn2tpLm94S3zf5fVE2uTLLU9H3+szC4Lyi8TX02A74bkubA8kBXpJI7lZITu2IvWvN
         VpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699310459; x=1699915259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxY9zXUG0PvjEP+fiwMUAi3gc50qQYOPjUmna5NAa34=;
        b=fDNin8GAlcX6C/Fs5wz+X5VDdTf9IhJGMRIhcNHvmJ88NSLjkQWBDPqmv6rkR7ylkp
         7XXMBC1HZzxd4ar+4e0oh+79UADnXU2jXm0551vbmqK74Rd/mUIlcGNUwBATjXSFnxo1
         d9wwTtUJn9tYcwsyY9Kh7c3lNB8Z5MTXZb0y5YIp+UaZHInPm+v82V7hoY/O1DMu+xm6
         M6zn/Zf52Qe+SkBiNMbGEYcAarShfcx7mTQC9X8ZSLn/u+fq1lvKTzpSR8yFw+uyUjps
         uoe9SOvQifJ7nhBMug6s/TZpfZkM5K8kCblDMsRk43UzvsXrscM9ujwOGVzoGP1uy87z
         6spQ==
X-Gm-Message-State: AOJu0YxayHQhE6LnmU9tslVRPTQgl2KaNCrNNOrYaL0m5TY8ofM3Sh+X
	rtgqndbs1wxh6xtgi0+ogsI6SMhz1EVdsKUvaw4=
X-Google-Smtp-Source: AGHT+IHnCwL9y7/kVgZgCI+JyDy8hslvsXEflto2xPMT2F92j0PKRwwTvHzxR23Kf9RRjSO3daq3VCmyFW7mM97e6ig=
X-Received: by 2002:a17:907:c20d:b0:9df:4232:5276 with SMTP id
 ti13-20020a170907c20d00b009df42325276mr5889196ejc.76.1699310458502; Mon, 06
 Nov 2023 14:40:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231104001313.3538201-1-song@kernel.org> <20231104001313.3538201-2-song@kernel.org>
 <CAEf4BzadqTVe=OPiKb=F63j3pqFPayUddjf17WFw0E47zqEqOw@mail.gmail.com> <F6545A31-F23B-4422-A74C-71F8C626A709@fb.com>
In-Reply-To: <F6545A31-F23B-4422-A74C-71F8C626A709@fb.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Nov 2023 14:40:46 -0800
Message-ID: <CAEf4BzYGQ8pXdhtqger0p3EZgsehsrMRQDzF-pEmTNzY_5ep1g@mail.gmail.com>
Subject: Re: [PATCH v12 bpf-next 1/9] bpf: Add __bpf_dynptr_data* for in
 kernel use
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"fsverity@lists.linux.dev" <fsverity@lists.linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Eric Biggers <ebiggers@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, KP Singh <kpsingh@kernel.org>, 
	Vadim Fedorenko <vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 2:00=E2=80=AFPM Song Liu <songliubraving@meta.com> w=
rote:
>
>
>
> > On Nov 6, 2023, at 1:07=E2=80=AFPM, Andrii Nakryiko <andrii.nakryiko@gm=
ail.com> wrote:
> >
> > On Fri, Nov 3, 2023 at 5:13=E2=80=AFPM Song Liu <song@kernel.org> wrote=
:
> >>
> >> Different types of bpf dynptr have different internal data storage.
> >> Specifically, SKB and XDP type of dynptr may have non-continuous data.
> >> Therefore, it is not always safe to directly access dynptr->data.
> >>
> >> Add __bpf_dynptr_data and __bpf_dynptr_data_rw to replace direct acces=
s to
> >> dynptr->data.
> >>
> >> Update bpf_verify_pkcs7_signature to use __bpf_dynptr_data instead of
> >> dynptr->data.
> >>
> >> Signed-off-by: Song Liu <song@kernel.org>
> >> ---
> >> include/linux/bpf.h      |  2 ++
> >> kernel/bpf/helpers.c     | 47 ++++++++++++++++++++++++++++++++++++++++
> >> kernel/trace/bpf_trace.c | 12 ++++++----
> >> 3 files changed, 57 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >> index b4825d3cdb29..eb84caf133df 100644
> >> --- a/include/linux/bpf.h
> >> +++ b/include/linux/bpf.h
> >> @@ -1222,6 +1222,8 @@ enum bpf_dynptr_type {
> >>
> >> int bpf_dynptr_check_size(u32 size);
> >> u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
> >> +const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 =
len);
> >> +void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len=
);
> >>
> >> #ifdef CONFIG_BPF_JIT
> >> int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_t=
rampoline *tr);
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index e46ac288a108..c569c4c43bde 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -2611,3 +2611,50 @@ static int __init kfunc_init(void)
> >> }
> >>
> >> late_initcall(kfunc_init);
> >> +
> >> +/* Get a pointer to dynptr data up to len bytes for read only access.=
 If
> >> + * the dynptr doesn't have continuous data up to len bytes, return NU=
LL.
> >> + */
> >> +const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 =
len)
> >> +{
> >> +       enum bpf_dynptr_type type;
> >> +       int err;
> >> +
> >> +       if (!ptr->data)
> >> +               return NULL;
> >> +
> >> +       err =3D bpf_dynptr_check_off_len(ptr, 0, len);
> >> +       if (err)
> >> +               return NULL;
> >> +       type =3D bpf_dynptr_get_type(ptr);
> >> +
> >> +       switch (type) {
> >> +       case BPF_DYNPTR_TYPE_LOCAL:
> >> +       case BPF_DYNPTR_TYPE_RINGBUF:
> >> +               return ptr->data + ptr->offset;
> >> +       case BPF_DYNPTR_TYPE_SKB:
> >> +               return skb_pointer_if_linear(ptr->data, ptr->offset, l=
en);
> >> +       case BPF_DYNPTR_TYPE_XDP:
> >> +       {
> >> +               void *xdp_ptr =3D bpf_xdp_pointer(ptr->data, ptr->offs=
et, len);
> >> +
> >> +               if (IS_ERR_OR_NULL(xdp_ptr))
> >> +                       return NULL;
> >> +               return xdp_ptr;
> >> +       }
> >> +       default:
> >> +               WARN_ONCE(true, "unknown dynptr type %d\n", type);
> >> +               return NULL;
> >> +       }
> >> +}
> >> +
> >
> > Song, you basically reimplemented bpf_dynptr_slice() but didn't unify
> > the code. Now we have two almost identical non-trivial functions we'd
> > need to update every time someone adds a new type of dynptr. Why not
> > have common helper that does everything both bpf_dynptr_slice() kfunc
> > needs and __bpf_dynptr_data() needs. And then call into it from both,
> > keeping all the LOCAL vs RINGBUF vs SKB vs XDP logic in one place?
> >
> > Is there some problem unifying them?
>
> Initially, I was thinking "buffer__opt =3D=3D NULL && buffer__szk !=3D 0"=
 was
> a problem for bpf_dynptr_slice(). And the buffer__opt =3D=3D NULL case ma=
y
> make a common helper more complicated. So I decided to not unify the two.
>
> After a second look at it, I agree it shouldn't be a problem. And actuall=
y
> we can do: (though you may argue against)
>
> const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len)
> {
>         return bpf_dynptr_slice(ptr, 0, NULL, len);
> }

yeah, let's do this, at least for now. If we have a problem with this,
we can extract a common helper function later. It's more about
interfaces (__bpf_dynptr_data() vs bpf_dynptr_slice()) staying
separate


>
>
> As we are on this, shall we update bpf_dynptr_slice() to return
> "const void *"? This is a little weird for buffer_opt !=3D NULL, case as
> buffer_opt is not const. But the compiler (clang) doesn't seem to
> complain about it.

Good question, but I don't know the answer, so I'd just leave it as is.

>
> If we cannot have bpf_dynptr_slice() return const pointer, we will need
> a little more casting for __bpf_dynptr_data().
>
> Thanks,
> Song
>
>
> >
> >> +/* Get a pointer to dynptr data up to len bytes for read write access=
. If
> >> + * the dynptr doesn't have continuous data up to len bytes, or the dy=
nptr
> >> + * is read only, return NULL.
> >> + */
>
>
>

