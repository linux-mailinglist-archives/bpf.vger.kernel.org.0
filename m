Return-Path: <bpf+bounces-37083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53678950D38
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 21:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96125B29087
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 19:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6FA5D477;
	Tue, 13 Aug 2024 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fu8aqb0V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395811DDF4
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723577769; cv=none; b=hVx8OfugPT3+hmQ2QQ0JI3xr/1d8W4Z3DS1kNMMrvZcbH1VF8cklTKX5MyNhf3QX3K2bMCroydqM/OsVe/RDQLw3d2/s8SMoi6F/NU4DISiMTCbP/g9SNtQ9ZIs1pBP1ag8IH3pKSCf+1LP+pMhyVIHF1dks+QB8Om/lOxuHGis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723577769; c=relaxed/simple;
	bh=1+nSosBbPkDBAwEghX8v3JexB9dMN/IqidwpMBMHzRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOikej1UDoKS+4SUSHiyDG7vNHQC/8rmf5DKOH4VQ+kP7oWPFKoxnLWcnn84tBcF/dR6UWh8PHS0FzhgfmitQRObAezKmBxLmnfq/nSBhf6rcbeHHcu9696dW8PXkzUtReCuUxgHBwAkeHVRlAqpHLkTFNzLwSs13SPjQttPOno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fu8aqb0V; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso45116855e9.1
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723577766; x=1724182566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBU/nnPxRESNNmVe0Xkov9neazgbn5y7qUAlwDHbFa8=;
        b=Fu8aqb0VApdKr839SI9bokkPH15xISajunHtLjH8D2v8IywPl/4t7wVyrZfhi6e8b6
         gCo8hyFBmXRoG3SJeapJnQi7RoamyIfgisvou98YJumlgf3eDTNPtlZ0HeCUnPu+pIBQ
         VJTebRn7glRYuFKD141Xq5QXk29b414IC3jSI/aaWsP2bErzatL/WhW5GWTOloXt3aqe
         RTYpqCcNGPoJNIG9+Wv0GC+w7sBWAPy0ojrnD4CSoQll4r+jka4/bwRYPibOPY9NGdRH
         pErQrgj1FAV49sYLygrccv/4mtldu4Akf0gHT/RtIhijO+pnbcOoCNI2NBDif04PvfTX
         LYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723577766; x=1724182566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBU/nnPxRESNNmVe0Xkov9neazgbn5y7qUAlwDHbFa8=;
        b=Ozjs0BIChCKeYIfHLkmaEM0nwOOIAukKQaorap+nKlVfNfO8+WwrWQhdrfRm9QhT7V
         pPnWrsxKk9jAIBqCbvZOWc1KAazF297ZM1Fq9iHCPPIzs6spNWf0s3n5ZCxIEryxKGXD
         UAfj5l6r8kiMl8pOsv32zeytcO5e3fNcX6ohxvzhsCBhQ1ov4e4lywCeIFl7TSv6OSsB
         GSkjgSp/WdEJuwvIIC+7o58+P1pFz4Geqk4x+goxIyvJKLKvKIgZFv0j36B8JyqHbtRm
         NkGrf9KTI88A5iz/Z627XAR0IDnWFO1/ZyAbZk17nQi6vy1bA68yLcDWymVHqyBQtTpF
         F2Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUff2Lr0kj7qQeH3sjawWFhFh0Fq0BBxBvgEHmVrOFMd09CMUj0X39paZFeomocDMol438=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYhO5BsJ2ZOpNKPc5W1Ze0RbKvBVF16DeF5oLZ2bRicmC9uN2g
	0MZNz9nYI33D1eW87fHnWBCBkay24VSqp5nQzaIEBrDzDjhPlvsBoXTtl2u6ARH+4AaSOpnvkAk
	GgPv598KS1vq1FOPpcBFzhHgkO1o=
X-Google-Smtp-Source: AGHT+IFbpotLU7v1QFFiYS1aIGeUpVetl/YJZXY2lW/p54XDL3r77VDyr2bZo/rEF8JzT3xsr4AkO2/kPZUczjCoDCw=
X-Received: by 2002:a05:600c:4f93:b0:428:2e9:65a9 with SMTP id
 5b1f17b1804b1-429dd25d95emr3398055e9.28.1723577766246; Tue, 13 Aug 2024
 12:36:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807235755.1435806-1-thinker.li@gmail.com>
 <20240807235755.1435806-3-thinker.li@gmail.com> <CAADnVQJdZgJi7=jo+Ur+hL1WtW3x06Zptupk+QOp-mMzSefzYw@mail.gmail.com>
 <00ec1572-9f74-4a01-b30a-4eb03489284e@gmail.com>
In-Reply-To: <00ec1572-9f74-4a01-b30a-4eb03489284e@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Aug 2024 12:35:55 -0700
Message-ID: <CAADnVQLLpdRMVJsaVMrUBTyzXBbg+1uxZTs-12n2BXQuSVLK2g@mail.gmail.com>
Subject: Re: [RFC bpf-next 2/5] bpf: Handle BPF_KPTR_USER in verifier.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 9:52=E2=80=AFAM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 8/12/24 09:48, Alexei Starovoitov wrote:
> > On Wed, Aug 7, 2024 at 4:58=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.c=
om> wrote:
> >>
> >> Give PTR_MAYBE_NULL | PTR_UNTRUSTED | MEM_ALLOC | NON_OWN_REF to kptr_=
user
> >> to the memory pointed by it readable and writable.
> >>
> >> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> >> ---
> >>   kernel/bpf/verifier.c | 11 +++++++++++
> >>   1 file changed, 11 insertions(+)
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index df3be12096cf..84647e599595 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -5340,6 +5340,10 @@ static int map_kptr_match_type(struct bpf_verif=
ier_env *env,
> >>          int perm_flags;
> >>          const char *reg_name =3D "";
> >>
> >> +       if (kptr_field->type =3D=3D BPF_KPTR_USER)
> >> +               /* BPF programs should not change any user kptr */
> >> +               return -EACCES;
> >> +
> >>          if (btf_is_kernel(reg->btf)) {
> >>                  perm_flags =3D PTR_MAYBE_NULL | PTR_TRUSTED | MEM_RCU=
;
> >>
> >> @@ -5483,6 +5487,12 @@ static u32 btf_ld_kptr_type(struct bpf_verifier=
_env *env, struct btf_field *kptr
> >>                          ret |=3D NON_OWN_REF;
> >>          } else {
> >>                  ret |=3D PTR_UNTRUSTED;
> >> +               if (kptr_field->type =3D=3D BPF_KPTR_USER)
> >> +                       /* In oder to access directly from bpf
> >> +                        * programs. NON_OWN_REF make the memory
> >> +                        * writable. Check check_ptr_to_btf_access().
> >> +                        */
> >> +                       ret |=3D MEM_ALLOC | NON_OWN_REF;
> >
> > UNTRUSTED | MEM_ALLOC | NON_OWN_REF ?!
> >
> > That doesn't fit into any of the existing verifier schemes.
> > I cannot make sense of this part.
> >
> > UNTRUSTED | MEM_ALLOC is read only through exceptions logic.
> > The uptr has to be read/write through normal load/store.
>
> I will remove UNTRUSTED and leave MEM_ALLOC and NON_OWN_REF.
> Does it make sense to you?

I don't think it fits either.
MEM_ALLOC | NON_OWN_REF is specific to bpf_rbtree/linklist nodes.
There are various checks and logic like:
1.
      if (!(type_is_ptr_alloc_obj(reg->type) ||
type_is_non_owning_ref(reg->type)) &&
            WARN_ON_ONCE(reg->off))
          return;
2.
invalidate_non_owning_refs() during unlock

that shouldn't apply in this case.

PTR_TO_MEM with specific mem_size fits better.
Since it's user/kernel shared memory PTR_TO_BTF_ID logic with field walking
won't work anyway, so opaque array of bytes is better. Which is PTR_TO_MEM.

