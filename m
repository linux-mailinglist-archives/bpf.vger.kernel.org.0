Return-Path: <bpf+bounces-77034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 644E2CCD72E
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 20:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AB263029D30
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 19:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AE429DB64;
	Thu, 18 Dec 2025 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdarAu+E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C752129B8D9
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766087902; cv=none; b=bp5KPVXPhy9cc2FQNB+srqsPoyIfgmsM3MjxkncO/8Z0OdtfonhZSOoLR7jBRHmvonRZk1/o5430BSTMYBVPyUemtt1T8EoYaH/IbkweRT6B3lVmPPGRrBff7DtJq5ZqcBBWBOyN8mDgL8oFzHmMAm3kaqIMNVFZ5faZn/OKEUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766087902; c=relaxed/simple;
	bh=VeM3OJs75KWSs1s7ckUiCSzaCdotFMQP1yTobcW6rlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MR6ZoEUDBqyisq15qcXm3ZA4taUeoVuLNZaXWvZilJPlsFQFZa6cyyrU0180zlxLclpgKLyZvJG3pICRG7zNXd3qNlMpauThzHf/uHl3vseNdsk7UbxrF+MCyQ27+Q/LYzw18peD7HZJ80w4DV8pjb6y8uzRv8zeiViFB8QaiWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdarAu+E; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7f89d0b37f0so1156696b3a.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 11:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766087900; x=1766692700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jnOcnFnpSPGhMG5nqqe5zyzdTWJk6oajdNhIdN6DrQ=;
        b=KdarAu+ECkXqxH2RsPSLEoggyJk9slNgUTLk5tFVr6k3s6XxzDZlwQmICW192usR2F
         ULagLXWu2iAZdYHBHuNMA1evXyS8j/x8g+eoeY5ja6EBz1/myVtJspaVAZ2j1AfDhuhw
         Kats1sainWSA9KYt3Djf7qEbZ5C1tRaae5Y925QAx2dF+w/BRqwjXZTojQjNINIHbyYO
         fXfViQNbwyIKyEQYPue4KAAfNoKnQKeaYjuAc9+C46XIESNWu3kqXrWkFXZsj0uvNQHc
         pli3TO4E11qR7hg/Yg/6pOFPmwZks+nhA6Z9hwgWX5kQQNHpp007jkROI2PYNcq882I1
         bnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766087900; x=1766692700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0jnOcnFnpSPGhMG5nqqe5zyzdTWJk6oajdNhIdN6DrQ=;
        b=YwwJe7XlY3RCYjn/a5A1Au6WIDDKToYQHE3gBMohhiqYLpEQN3zgJRUlOdJRtO3Fs4
         SszsCQIOAEbsvExNNPAzqpALZhP1imdCzcKAOUlOmseReaRz8A21yEtkVK6NvUaok2Za
         0Z+S7vKVwSRIU0HS/MjeNnvmRhYX3+bNj3PbATxBiIE9p5I8EVPbsQV61bsW4xBf/cw1
         a78tiiHVJ0eW0c6NuYKIMF/9cSb3lWmjhlMMCB3/dblilmh2nxxoYhGnUxjdR5SAhqtS
         tZ7QQtPBEgweAiuEh6QRa8fRG/s4lYyOUUQt/6xK7XpECImDO3SWhEVYcGmukVFLC7+h
         q6uA==
X-Forwarded-Encrypted: i=1; AJvYcCUNFIoAjNAdPcheCu/CTKCMT+2ge5XDuUYzvsH8vDUw+mStSoHn19ttG9hJKnxdmrjxeB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR4a4iYB2gqPK28ntoFvm/hkpGda7+uFvU7+HdpTx0vvIE6LwB
	gpPD/seEn3Ms2gj9z3YdQGnPr5CeAjR6qDAmPzphVQV+fZ79/Qvn92MFtY4w2F0OcEcjAfrk6aN
	qocH9EZkVwpxLtiFb18uGQQ3faSQhWj0=
X-Gm-Gg: AY/fxX67SREAc3+0MhqPSxf1dQKlemlnt9/t1lXzTPtUU7hAvIXSzGf/+UcvvlzLTrV
	FQItXq4mbhLzaysFHJ2mV2uH+YnVqsyg6yxNHVf7+E/YLoDBrYauw3bziZirrTPb/boIUg/HW1F
	QkTuPRlQ02kPPAhhQSZkahwRj0lItFz9q+UPkPhDyFnjkuP5+uy/q340TdJfRWv658Fd9ldB4b0
	puyl8T36bo/ksZsS8z6hVPkQh5/pwK8ELuETg95vC+PYiRVK8WeZ/yaalMDjb9eKoTbOydIt07L
	i5+Old+ufPo=
X-Google-Smtp-Source: AGHT+IFHsN1ggcHGGK017zsJZDYebTkWT4IUvNBSnL0IZX0twQMbqEdMVRFFDZiQhKCRPXJgR7+UNOnrSfcaOKCpzKE=
X-Received: by 2002:a17:90b:28cc:b0:34c:6a13:c3bc with SMTP id
 98e67ed59e1d1-34e71e0a19dmr3339305a91.9.1766087899778; Thu, 18 Dec 2025
 11:58:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218003314.260269-4-ihor.solodrai@linux.dev>
 <106b6e71bce75b8f12a85f2f99e75129e67af7287f6d81fa912589ece14044f9@mail.kernel.org>
 <d9b9e129-349b-4510-bf33-01b831c2174b@linux.dev>
In-Reply-To: <d9b9e129-349b-4510-bf33-01b831c2174b@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 11:58:07 -0800
X-Gm-Features: AQt7F2p48Gmilc3nV7XwZv5cvWFMLs7_EpbDLoqocIvuXu77FjccU8vvsXHjSr4
Message-ID: <CAEf4BzZXzQ6fZetTA8Trwa_pu7o1AJuMyUuHbW9YXHYGQL-_HA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/8] resolve_btfids: Introduce enum btf_id_kind
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bot+bpf-ci@kernel.org, alan.maguire@oracle.com, ast@kernel.org, 
	arighi@nvidia.com, akpm@linux-foundation.org, andrii@kernel.org, 
	morbo@google.com, changwoo@igalia.com, daniel@iogearbox.net, 
	void@manifault.com, dolinux.peng@gmail.com, eddyz87@gmail.com, 
	haoluo@google.com, jolsa@kernel.org, john.fastabend@gmail.com, corbet@lwn.net, 
	justinstitt@google.com, kpsingh@kernel.org, martin.lau@linux.dev, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, nsc@kernel.org, 
	shuah@kernel.org, song@kernel.org, sdf@fomichev.me, tj@kernel.org, 
	yonghong.song@linux.dev, bpf@vger.kernel.org, dwarves@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, martin.lau@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 9:47=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 12/17/25 4:47 PM, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfid=
s/main.c
> >> index b4caae1170dd..da8c7d127632 100644
> >> --- a/tools/bpf/resolve_btfids/main.c
> >> +++ b/tools/bpf/resolve_btfids/main.c
> >
> > [ ... ]
> >
> >> @@ -260,22 +279,36 @@ static char *get_id(const char *prefix_end)
> >>      return id;
> >>  }
> >>
> >> -static struct btf_id *add_set(struct object *obj, char *name, bool is=
_set8)
> >> +static struct btf_id *add_set(struct object *obj, char *name, enum bt=
f_id_kind kind)
> >>  {
> >> +    int len =3D strlen(name);
> >> +    int prefixlen;
> >> +    char *id;
> >> +
> >>      /*
> >>       * __BTF_ID__set__name
> >>       * name =3D    ^
> >>       * id   =3D         ^
> >>       */
> >> -    char *id =3D name + (is_set8 ? sizeof(BTF_SET8 "__") : sizeof(BTF=
_SET "__")) - 1;
> >> -    int len =3D strlen(name);
> >> +    switch (kind) {
> >> +    case BTF_ID_KIND_SET:
> >> +            prefixlen =3D sizeof(BTF_SET "__") - 1;
> >> +            break;
> >> +    case BTF_ID_KIND_SET8:
> >> +            prefixlen =3D sizeof(BTF_SET8 "__") - 1;
> >> +            break;
> >> +    default:
> >> +            pr_err("Unexpected kind %d passed to %s() for symbol %s\n=
", kind, __func__, name);
> >> +            return NULL;
> >> +    }
> >> +
> >> +    id =3D name + prefixlen - 1;
> >
> > Is this off by one? The original code computed:
> >
> >     id =3D name + sizeof(BTF_SET "__") - 1
> >
> > For BTF_SET ("set"), this gives: name + sizeof("set__") - 1 =3D name + =
6 - 1 =3D name + 5
> >
> > The new code computes:
> >
> >     prefixlen =3D sizeof(BTF_SET "__") - 1 =3D 6 - 1 =3D 5
> >     id =3D name + prefixlen - 1 =3D name + 5 - 1 =3D name + 4
> >
> > The -1 appears to be applied twice now, once in the prefixlen assignmen=
t and
> > again when computing id. Should this line be:
> >
> >     id =3D name + prefixlen;
>
> Yes, this is an off-by-one bug.
>
> Good catch, Opus 4.5. Sonnet 4.5 missed this in v3.
>
> This was "harmless", since the names stored in the trees don't affect
> the output.  The comparison between the names still works, as they all
> simply got a "_" prefix.  But this only makes the bug sneaky, which is
> very bad.
>
> The suggested fix is meh though, IMO a better one is:

the bug is not in determining prefix length, but in using it to find
where id starts in the string, so the fix should be

id =3D name + prefixlen;

prefixlen is calculated correctly, IMO

>
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index 3e88dc862d87..ffc15c249ed4 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -295,10 +295,10 @@ static struct btf_id *add_set(struct object *obj, c=
har *name, enum btf_id_kind k
>          */
>         switch (kind) {
>         case BTF_ID_KIND_SET:
> -               prefixlen =3D sizeof(BTF_SET "__") - 1;
> +               prefixlen =3D sizeof(BTF_SET "__");
>                 break;
>         case BTF_ID_KIND_SET8:
> -               prefixlen =3D sizeof(BTF_SET8 "__") - 1;
> +               prefixlen =3D sizeof(BTF_SET8 "__");
>                 break;
>         default:
>                 pr_err("Unexpected kind %d passed to %s() for symbol %s\n=
", kind, __func__, name);
>
> >
> >>      if (id >=3D name + len) {
> >>              pr_err("FAILED to parse set name: %s\n", name);
> >>              return NULL;
> >>      }
> >>
> >> -    return btf_id__add(&obj->sets, id, true);
> >> +    return btf_id__add_unique(&obj->sets, id, kind);
> >>  }
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/REA=
DME.md
> >
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/2032=
1956014
>

