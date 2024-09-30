Return-Path: <bpf+bounces-40620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C19898B076
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 00:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC949283B16
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 22:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7526E188CA8;
	Mon, 30 Sep 2024 22:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tulagk6D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E3217332B;
	Mon, 30 Sep 2024 22:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736543; cv=none; b=H6FxnExJdDDfzyDGH1AUf7bp2hULboNmeQDxNChEoXzS5jcuWYdWr0PpwPowwpnMnH6/HZ3JcBKCZ6mrDpfLA9/BLTs1MNkR8yrvdsO1NX7P83dZnSMb81pXNC3w3alEo1gFJ0p80zP1BI5y4svfS5Dhxw/X5WewOHlMVrjI5bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736543; c=relaxed/simple;
	bh=PfrxoRnTbEz/F1cvSRav3TtUJxyEJU3rD6xDUE5CuPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NItxYTNBnC11p5X34oZ/fZHrSzhmPLzChmx9GTaQ5zM3poNwZppffLmLHRmXgyrviNOMzhBkTwUdWnZakgrCnjnJfSicss9peQXd8SLavRIPvflsDwJtuCYqT0B/bpUDQnUh82owMyXiH6qWlBI5JAadljGsl5NAenZHMOYoMbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tulagk6D; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7163489149eso4053127a12.1;
        Mon, 30 Sep 2024 15:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727736541; x=1728341341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+0X0TfzIjBFfpGKdYd3L1IvRzZizXeCvoJHwlKft50=;
        b=Tulagk6DWxhppNJRLzuc5yNqZgZCNGnJoZ5AUAGGnzoFKwbLLhOTyWrY5g4dWutwbq
         YS5BW1j6Yv4o6rqouAz2fS28IOxOWuNWPEjmCSaqv7oZX1b1goiEceTmtOMoPSacnrik
         g9ulqX115bk2GZ6hsXbHap8snc7HEg3mZIUP31rQ2CjzOpqikzRm8+oHq8s5+akMFAzA
         DCMwO82Y7tDvIQA8dBO16hwchLcapRWTtvYq41bwwoBBjZ166xF3uNiElI1PyMGtoaQm
         WoD7DDVYRtM+kmiYPp65W1SAWL+EtJrVRwofOj0JWpC4b39cCWCLD02ZUsbezPGNrygd
         tatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727736541; x=1728341341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+0X0TfzIjBFfpGKdYd3L1IvRzZizXeCvoJHwlKft50=;
        b=mwoGQRvdmkTtoIzfd1Z1OtdZ9VXozT5dl9aZnNzyFaH3R5gQr+g9h5pzwnYEFcU69m
         CkWFTQkXTTpdAQfgxiF2TFOYRd5cpKEBUk/BIpSgBi8uFjeBw9jRlIgQCRGp+mwIrs0m
         OV4Kf2Pc3j0298f1cme9NSpz0qUBD6rcDgTnw8tzybb2zOqGZX/8/NzzF0WPBTo0CPP0
         kmiAk3rKZBVOkbJKG2m1+QL0insPw/YqfljWaUUQJELmvXnVODaOIilWURP0Z2u+yATv
         2Bn0mwj/5WoB2D50iwAVkZS76cdm/azfDRyyrgYHzeBPbhq1rYlw8rKW37HxDH6mhm5B
         S78w==
X-Forwarded-Encrypted: i=1; AJvYcCUP+GeO2YrCa0/mE7G7mA0YGMdqK4qA/fQKEBrAIyAXVPJfSDhHzrTDrpoyM3xTfPZ8wp0=@vger.kernel.org, AJvYcCUcDup+0lb/nHQb5I7Zg0nbA58/zd2UX8cQXkr5rTTguBytBwrYDkEQ87SSQ1GIY0wB54mE9HS/@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj/OOBO0WiLoQDHAsDsjDOCXaSWVikS5UKo3VJ7IDgG5oNLOjs
	jKmDOztd8EMjdL56GjIQO0pm54711NwphRD+Et27lR4Mtp3MvVKxvhE+vDLnJbjDm5/WtjTiuw/
	gW5vPMwpoPVOQGqtRuoWAEvY1sfI=
X-Google-Smtp-Source: AGHT+IHgLQo+dL04EMhE8G136z32g3/c8/G5t2Zj4k/x1onYxCqavT0W0GFTP6w/sGqWpRT8lIsEu4R6gC0qYb1WF3c=
X-Received: by 2002:a17:90a:df01:b0:2d3:c8e5:e548 with SMTP id
 98e67ed59e1d1-2e0b89dff8cmr16655486a91.13.1727736540851; Mon, 30 Sep 2024
 15:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929-libbpf-dup-extern-funcs-v2-0-0cc81de3f79f@hack3r.moe>
 <20240929-libbpf-dup-extern-funcs-v2-1-0cc81de3f79f@hack3r.moe> <CAADnVQLdmmvJRyf+br=CtJaDw6PowqKGTXb3z-q7LpbYiYFpHQ@mail.gmail.com>
In-Reply-To: <CAADnVQLdmmvJRyf+br=CtJaDw6PowqKGTXb3z-q7LpbYiYFpHQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Sep 2024 15:48:48 -0700
Message-ID: <CAEf4BzYaCtYutq8g1vh0N3d89kyd4ZtaTsbPNO7zfGTjhMYGSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: do not resolve size on duplicate FUNCs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: i@hack3r.moe, bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 9:32=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Sep 29, 2024 at 2:31=E2=80=AFAM Eric Long via B4 Relay
> <devnull+i.hack3r.moe@kernel.org> wrote:
> >
> > From: Eric Long <i@hack3r.moe>
> >
> > FUNCs do not have sizes, thus currently btf__resolve_size will fail
> > with -EINVAL. Add conditions so that we only update size when the BTF
> > object is not function or function prototype.
> >
> > Signed-off-by: Eric Long <i@hack3r.moe>
> > ---
> >  tools/lib/bpf/linker.c | 23 +++++++++++++----------
> >  1 file changed, 13 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> > index 81dbbdd79a7c65a4b048b85e1dba99cb5f7cb56b..cffb388fa40ef054c2661b8=
363120f8a4d3c3784 100644
> > --- a/tools/lib/bpf/linker.c
> > +++ b/tools/lib/bpf/linker.c
> > @@ -2452,17 +2452,20 @@ static int linker_append_btf(struct bpf_linker =
*linker, struct src_obj *obj)
> >                                 __s64 sz;
> >
> >                                 dst_var =3D &dst_sec->sec_vars[glob_sym=
->var_idx];
> > -                               /* Because underlying BTF type might ha=
ve
> > -                                * changed, so might its size have chan=
ged, so
> > -                                * re-calculate and update it in sec_va=
r.
> > -                                */
> > -                               sz =3D btf__resolve_size(linker->btf, g=
lob_sym->underlying_btf_id);
> > -                               if (sz < 0) {
> > -                                       pr_warn("global '%s': failed to=
 resolve size of underlying type: %d\n",
> > -                                               name, (int)sz);
> > -                                       return -EINVAL;
> > +                               t =3D btf__type_by_id(linker->btf, glob=
_sym->underlying_btf_id);
> > +                               if (btf_kind(t) !=3D BTF_KIND_FUNC && b=
tf_kind(t) !=3D BTF_KIND_FUNC_PROTO) {
> > +                                       /* Because underlying BTF type =
might have
> > +                                        * changed, so might its size h=
ave changed, so
> > +                                        * re-calculate and update it i=
n sec_var.
> > +                                        */
> > +                                       sz =3D btf__resolve_size(linker=
->btf, glob_sym->underlying_btf_id);
> > +                                       if (sz < 0) {
> > +                                               pr_warn("global '%s': f=
ailed to resolve size of underlying type: %d\n",
> > +                                                       name, (int)sz);
> > +                                               return -EINVAL;
> > +                                       }
> > +                                       dst_var->size =3D sz;
>
> Looks like a hack to me.
>
> In the test you're using:
> void *bpf_cast_to_kern_ctx(void *obj) __ksym;
>
> but __weak is missing.
> Is that the reason you're hitting this issue?

This is the real issue, unfortunately. And the reason we have this
size update is due to weak *variables*. When the weak variable is
overridden by a "strong" variable or extern is resolved to a concrete
variable, its underlying type might change (e.g., FWD to STRUCT, but
probably there are other cases). Details are a bit hazy by now.

But in any case, this size updating logic should only apply to
variables, so filtering out FUNCs is the straightforward solution. It
can just be coded a bit more nicely, which I suggested in a separate
reply.

