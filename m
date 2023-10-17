Return-Path: <bpf+bounces-12490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C987CD011
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 00:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297CF2812BA
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 22:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FA02D03A;
	Tue, 17 Oct 2023 22:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVSQQAnT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DF817735
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 22:40:39 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CBCBA
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 15:40:37 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507b96095abso2489201e87.3
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 15:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697582436; x=1698187236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+t2oBSmgVOkL1cEr7s5DILahgjgWDtbegCWKTV0JuvA=;
        b=VVSQQAnTxQFJgPXKCzwR5dV4qbZ2a316w2DDNrt/0tyAgRJF1RbKtT7yjn7bGTUVg4
         jTR/OLi5207HIBM/0XrP09iN1eJO8kXdA6oNJsfLGuDQ82Uij7UQbTERziBP6oe2B1e3
         BkMRifrXwvtT4jW9sgm8p7E93925/Esqyu2KQHzyHGMBs3OwYV3zzLoUwip8Kmzd8pA0
         HDiQBay/DKoeM6il0QHp4GbM66PYea6ESJdTzj+A1bJJjlKgBiOnZ3GPGQeN/GoqAxKm
         9sA9te92E7iKesFCeMmsJPPUTWu9A9827ZcmzQB1keIcXys4USycueMiMHhYjMC7UaAe
         isyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697582436; x=1698187236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+t2oBSmgVOkL1cEr7s5DILahgjgWDtbegCWKTV0JuvA=;
        b=d/Olv0ohu4/OJtZ946cbYctP3UmThWZq5r7zVrwM8bEJJ2HDAA+SHqPHvre2o9ImUL
         p1+kTaYLNXRoarmoWkJp/ks6kg8o+FqHX2WG6/gwQ2E5td2YQ3Hs8hh/WHgbpiVw1SI1
         7qXomDnfodV4WBsIFQ2nmHZTi1DUOHrmaNCRGtdTWGu7OeVvASv1FpafTitLDYJrtT4M
         lOOa03pkbZxoPHxapLgLuz0lJQJSfLI6DdtkjgGk02iFfjEsni0vVAOPl0NEkNjePRab
         XxCyxitioPaaMRplog91axM+TED+1ANtgKWMHDhGsJ6F1LkLlG2L6iTO7qzFUWBm8TGu
         /14g==
X-Gm-Message-State: AOJu0YxoqnIsP7HSe+QgPCR6OV31K8gJ6hWo7dEK6OYGqxL3//+0VSBy
	mNsLleockH3XrrA3tiygbx2U5YBTpGwioZtDOIw=
X-Google-Smtp-Source: AGHT+IHxmoM5IfXswvNuM01QDq2A/jkLjQQDErkDCN6UuiGs8195FS1h1bVsfXJZWzfLanwCYaAjEE4K1s4t9/ocpAw=
X-Received: by 2002:a05:6512:1589:b0:503:28cb:c087 with SMTP id
 bp9-20020a056512158900b0050328cbc087mr3406646lfb.29.1697582435690; Tue, 17
 Oct 2023 15:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231013182644.2346458-1-song@kernel.org> <20231013182644.2346458-2-song@kernel.org>
 <CAEf4BzYbQzMU4T6KYt4UudXvZiPg4nQdQCxD9zqzoJLgqOE9bQ@mail.gmail.com>
 <0ABF7860-A331-4161-9599-C781E9650283@fb.com> <CAEf4BzaNA18CpG-E-OUynEZuhGoQsieyzTVTkVOF9qB=j4u+yA@mail.gmail.com>
 <5FBE8C27-0280-4434-BBF2-70344276F16D@fb.com>
In-Reply-To: <5FBE8C27-0280-4434-BBF2-70344276F16D@fb.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Oct 2023 15:40:24 -0700
Message-ID: <CAEf4BzZXPMqLG95f5XXayvbTUOOJmzUKjyaurnjdMrt46S5d1Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add kfunc bpf_get_file_xattr
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"fsverity@lists.linux.dev" <fsverity@lists.linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Eric Biggers <ebiggers@kernel.org>, "tytso@mit.edu" <tytso@mit.edu>, 
	"roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 3:16=E2=80=AFPM Song Liu <songliubraving@meta.com> =
wrote:
>
>
>
> > On Oct 17, 2023, at 2:52=E2=80=AFPM, Andrii Nakryiko <andrii.nakryiko@g=
mail.com> wrote:
> >
> > On Tue, Oct 17, 2023 at 1:31=E2=80=AFPM Song Liu <songliubraving@meta.c=
om> wrote:
> >>
> >>
> >>
> >>> On Oct 17, 2023, at 11:58=E2=80=AFAM, Andrii Nakryiko <andrii.nakryik=
o@gmail.com> wrote:
> >>>
> >>> On Fri, Oct 13, 2023 at 11:29=E2=80=AFAM Song Liu <song@kernel.org> w=
rote:
> >>>>
> >>>> This kfunc can be used to read xattr of a file.
> >>>>
> >>>> Since vfs_getxattr() requires null-terminated string as input "name"=
, a new
> >>>> helper bpf_dynptr_is_string() is added to check the input before cal=
ling
> >>>> vfs_getxattr().
> >>>>
> >>>> Signed-off-by: Song Liu <song@kernel.org>
> >>>> ---
> >>>> include/linux/bpf.h      | 12 +++++++++++
> >>>> kernel/trace/bpf_trace.c | 44 ++++++++++++++++++++++++++++++++++++++=
++
> >>>> 2 files changed, 56 insertions(+)
> >>>>
> >>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >>>> index 61bde4520f5c..f14fae45e13d 100644
> >>>> --- a/include/linux/bpf.h
> >>>> +++ b/include/linux/bpf.h
> >>>> @@ -2472,6 +2472,13 @@ static inline bool has_current_bpf_ctx(void)
> >>>>       return !!current->bpf_ctx;
> >>>> }
> >>>>
> >>>> +static inline bool bpf_dynptr_is_string(struct bpf_dynptr_kern *ptr=
)
> >>>
> >>> is_zero_terminated would be more accurate? though there is nothing
> >>> really dynptr-specific here...
> >>
> >> is_zero_terminated sounds better.
> >>
> >>>
> >>>> +{
> >>>> +       char *str =3D ptr->data;
> >>>> +
> >>>> +       return str[__bpf_dynptr_size(ptr) - 1] =3D=3D '\0';
> >>>> +}
> >>>> +
> >>>> void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
> >>>>
> >>>> void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
> >>>> @@ -2708,6 +2715,11 @@ static inline bool has_current_bpf_ctx(void)
> >>>>       return false;
> >>>> }
> >>>>
> >>>> +static inline bool bpf_dynptr_is_string(struct bpf_dynptr_kern *ptr=
)
> >>>> +{
> >>>> +       return false;
> >>>> +}
> >>>> +
> >>>> static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog=
)
> >>>> {
> >>>> }
> >>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >>>> index df697c74d519..946268574e05 100644
> >>>> --- a/kernel/trace/bpf_trace.c
> >>>> +++ b/kernel/trace/bpf_trace.c
> >>>> @@ -24,6 +24,7 @@
> >>>> #include <linux/key.h>
> >>>> #include <linux/verification.h>
> >>>> #include <linux/namei.h>
> >>>> +#include <linux/fileattr.h>
> >>>>
> >>>> #include <net/bpf_sk_storage.h>
> >>>>
> >>>> @@ -1429,6 +1430,49 @@ static int __init bpf_key_sig_kfuncs_init(voi=
d)
> >>>> late_initcall(bpf_key_sig_kfuncs_init);
> >>>> #endif /* CONFIG_KEYS */
> >>>>
> >>>> +/* filesystem kfuncs */
> >>>> +__diag_push();
> >>>> +__diag_ignore_all("-Wmissing-prototypes",
> >>>> +                 "kfuncs which will be used in BPF programs");
> >>>> +
> >>>> +/**
> >>>> + * bpf_get_file_xattr - get xattr of a file
> >>>> + * @name_ptr: name of the xattr
> >>>> + * @value_ptr: output buffer of the xattr value
> >>>> + *
> >>>> + * Get xattr *name_ptr* of *file* and store the output in *value_pt=
r*.
> >>>> + *
> >>>> + * Return: 0 on success, a negative value on error.
> >>>> + */
> >>>> +__bpf_kfunc int bpf_get_file_xattr(struct file *file, struct bpf_dy=
nptr_kern *name_ptr,
> >>>> +                                  struct bpf_dynptr_kern *value_ptr=
)
> >>>> +{
> >>>> +       if (!bpf_dynptr_is_string(name_ptr))
> >>>> +               return -EINVAL;
> >>>
> >>> so dynptr can be invalid and name_ptr->data will be NULL, you should
> >>> account for that
> >>
> >> We can add a NULL check (or size check) here.
> >
> > there must be some helper to check if dynptr is valid, let's use that
> > instead of NULL checks
>
> Yeah, we can use bpf_dynptr_is_null().
>
> >
> >>
> >>>
> >>> and there could also be special dynptrs that don't have contiguous
> >>> memory region, so somehow you'd need to take care of that as well
> >>
> >> We can require the dynptr to be BPF_DYNPTR_TYPE_LOCAL. I don't think
> >> we need this for dynptr of skb or xdp. Would this be sufficient?
> >
> > well, to keep thing simple we can have a simple internal helper API
> > that will tell if it's safe to assume that dynptr memory is contiguous
> > and it's ok to use dynptr memory. But still, you shouldn't access data
> > pointer directly, there must be some helper for that. Please check. It
> > has to take into account offset and stuff like that.
>
> Yeah, we can use bpf_dynptr_write(), which is a helper (not kfunc).
>
> >
> > Also, and separately from that, we should think about providing a
> > bpf_dynptr_slice()-like helper that will accept a fixed-sized
> > temporary buffer and return pointer to either actual memory or copy
> > non-contiguous memory into that buffer. That will make sure you can
> > use any dynptr as a source of data, and only pay the price of memory
> > copy in rare cases where it's necessary
>
> I don't quite follow here. Currently, we have
>
> bpf_dynptr_data()
> bpf_dynptr_slice()
> bpf_dynptr_slice_rdwr()
> bpf_dynptr_write()
>
> AFAICT, they are sufficient to cover existing use cases (and the new
> use case we are adding in this set). What's the new kfunc are you
> thinking about?

I wasn't talking about kfuncs, but rather just internal helpers to be
used by other kfuncs when working with dynptrs as input arguments.

>
> Thanks,
> Song
>
>

