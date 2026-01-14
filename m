Return-Path: <bpf+bounces-78811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2844CD1C1C7
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B124301EFDE
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9E323D7DC;
	Wed, 14 Jan 2026 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXHzWh5E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004802309AA
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768357053; cv=none; b=OKnnEt3QKZJWp4egrXNkG7nhklWoFy5aMgscGWjcgGWC67SLVp1y8PsgcP+o8Hp/nZbqm3hTZYchkcPVOY3vMrHmN56ZQbqONlSis4f9rRD+0p7vMUJhe8GODJ0kj8OQodrnZfRdCbXXfVT2IfXnQdf0GSCY+UVzUXgJytZMx3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768357053; c=relaxed/simple;
	bh=xHMj8c2poE2KIaoRsgu9gbKi85ImU6vZcB+UxNnP+RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8gDllO6J7jhBM5+Bhg0AI4QQaZkDoBS/SVCeWaplIN+oFnM0LILJP5zW4E1cybwsFxy+PRX/42CJMUFv4XKulWEkpzdnWJcPu2al5tPsaRTqnR6zlrZsl0sUR+wUpusrgrvbi5UH1eKMha5IQdFPLYe9kVbdctYYzGt95z5WSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXHzWh5E; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b874c00a3fcso166094966b.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 18:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768357050; x=1768961850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7R3X6ciqh6wxdXEeSdBXalHNtKGiwIzDvS78i/5Ba8Q=;
        b=iXHzWh5E6sEneE9/WTbwwzRrg1JA2NopwQvA0KRy2y8ka2fNxKTERlIvNpR2gm/hwZ
         ujWcoJh/ayDSwMfe2q8S3U92UsEckrssQDtx3W/BLPqtIT450Grp8+iDuVzs5DJHFtVR
         Cj87MBoOVAoaMy1lrQPkZIPuigrTWayHlTrlt/Nwp2GTFW7wwhUwE4D8DFjzbPQaQVi3
         pALQNXNQExfqSzsNhRan7osFj7Tk/uwq0kXgp/JSxOOopge0c7EC3XOsmgt9GfZ/lKby
         a1Z0TTEhNjdwGJ1ZM9RNyjywwAN3FkLdf5qztc561DQ5hUFUx6EuGlrycpydw//zKIew
         zU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768357050; x=1768961850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7R3X6ciqh6wxdXEeSdBXalHNtKGiwIzDvS78i/5Ba8Q=;
        b=oDgWKO9vd0fpbUpwSdmExLtmHeI92XDiZoYNbBbKhREkRN4Y9dXXc9lkgMZXkf9Iqh
         JTldNzYuJBTzmyQobXZGiD9RZ+ve03t2JA2HjqgAUpoufxlM14CnhTxAj0ap0UyRwZVu
         A8Wo+DAWIdsQ8D6klItmyVB6KcN59CTgBa74QRp3Jz6NtRPbVowLgSWeoM4T0jLwLcjY
         QXCuFES1XNXpJV80o3dS2YSlVtmiCebfYeukJr/wGfirlvwoo4hAgVogi82RxxohRrtE
         4+eTcxkUt7anhRRdSiAB9Vq+wuoSylXhWSI5gKub0ljQurYnilo09ystu40mfKuX8xZJ
         3XBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsd/q7PC4EdK8A6147ukZidca+zkm8KbwjrmjCEBx/LDZM8hgWmtU/uTw6HsxRSwDuNVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypl7oTniB2IIkBIfOXOm/7RYt6SAfgVoHGwuOv4dhA0UyGTSB0
	ESs1E7QOE4+b3JrF3I6NSDpArmbF6vz7TT+7FmF1rh7v7Qj7S06G0+WCfe7kOxg9mkw8VEoEtP7
	9B/9ivqGR2uwIab/7waQFWmbO624nhic=
X-Gm-Gg: AY/fxX7eMNLFFg/NFcC8XmatMgwpA000GoPfmDuapxt6k5ct3YVkmarQKKPHwzePsTp
	D2XdYZeKlkMehdJMFIV2JYAmtWP9+badxcvT9MbQHZ9WK+gVyz8/ro5ngS9yLgSV9Wyu40IWCWE
	Vg16bR72qEPREeeNd652HmPmdXmsSWjtQnh/KDkobooFDKXn5JFNGJgi0ofgAf1DzTVFHLQilHq
	UtxIYfo+LHYu3/4Q3JLb1syqB6lHLsQsvnFwvyNKFSsJpkgu5aDykwbi+6PhlDswxzR086Z
X-Received: by 2002:a17:907:9724:b0:b7f:fedc:2711 with SMTP id
 a640c23a62f3a-b87612a4811mr109122966b.53.1768357050308; Tue, 13 Jan 2026
 18:17:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109130003.3313716-1-dolinux.peng@gmail.com>
 <20260109130003.3313716-8-dolinux.peng@gmail.com> <CAEf4BzZpNz6BWg3GJcmbQh_nN71bKnohG5L_0hhD+=DkHLgMbg@mail.gmail.com>
In-Reply-To: <CAEf4BzZpNz6BWg3GJcmbQh_nN71bKnohG5L_0hhD+=DkHLgMbg@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 14 Jan 2026 10:17:18 +0800
X-Gm-Features: AZwV_QhIMtyP-my2CjYzIl3nsi1za5gSQ91Y4ytOJ6cB-0T2zfqNeNEt97fkeS0
Message-ID: <CAErzpmsHTvs3zkd8f_aShZLNYunF9zNEYs4h1rBcavE_e+Qc3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 07/11] btf: Verify BTF sorting
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 8:30=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jan 9, 2026 at 5:00=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.c=
om> wrote:
> >
> > From: Donglin Peng <pengdonglin@xiaomi.com>
> >
> > This patch checks whether the BTF is sorted by name in ascending order.
> > If sorted, binary search will be used when looking up types.
> >
> > Specifically, vmlinux and kernel module BTFs are always sorted during
> > the build phase with anonymous types placed before named types, so we
> > only need to identify the starting ID of named types.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> > ---
> >  kernel/bpf/btf.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index d1f4b984100d..12eecf59d71f 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -550,6 +550,46 @@ u32 btf_nr_types(const struct btf *btf)
> >         return total;
> >  }
> >
> > +/* Note that vmlinux and kernel module BTFs are always sorted
>
> wrong comment style, I'll fix it up when applying, but keep this in
> mind for the future

Thanks, I understood.

>
>
> > + * during the building phase.
> > + */
> > +static void btf_check_sorted(struct btf *btf)
> > +{
> > +       u32 i, n, named_start_id =3D 0;
> > +
> > +       n =3D btf_nr_types(btf);
> > +       if (btf_is_vmlinux(btf)) {
> > +               for (i =3D btf_start_id(btf); i < n; i++) {
> > +                       const struct btf_type *t =3D btf_type_by_id(btf=
, i);
> > +                       const char *n =3D btf_name_by_offset(btf, t->na=
me_off);
> > +
> > +                       if (n[0] !=3D '\0') {
> > +                               btf->named_start_id =3D i;
> > +                               return;
> > +                       }
> > +               }
> > +               return;
> > +       }
> > +
> > +       for (i =3D btf_start_id(btf) + 1; i < n; i++) {
> > +               const struct btf_type *ta =3D btf_type_by_id(btf, i - 1=
);
> > +               const struct btf_type *tb =3D btf_type_by_id(btf, i);
> > +               const char *na =3D btf_name_by_offset(btf, ta->name_off=
);
> > +               const char *nb =3D btf_name_by_offset(btf, tb->name_off=
);
> > +
> > +               if (strcmp(na, nb) > 0)
> > +                       return;
> > +
> > +               if (named_start_id =3D=3D 0 && na[0] !=3D '\0')
> > +                       named_start_id =3D i - 1;
> > +               if (named_start_id =3D=3D 0 && nb[0] !=3D '\0')
> > +                       named_start_id =3D i;
> > +       }
> > +
> > +       if (named_start_id)
> > +               btf->named_start_id =3D named_start_id;
> > +}
> > +
> >  /* btf_named_start_id - Get the named starting ID for the BTF
> >   * @btf: Pointer to the target BTF object
> >   * @own: Flag indicating whether to query only the current BTF (true =
=3D current BTF only,
> > @@ -6302,6 +6342,7 @@ static struct btf *btf_parse_base(struct btf_veri=
fier_env *env, const char *name
> >         if (err)
> >                 goto errout;
> >
> > +       btf_check_sorted(btf);
> >         refcount_set(&btf->refcnt, 1);
> >
> >         return btf;
> > @@ -6436,6 +6477,7 @@ static struct btf *btf_parse_module(const char *m=
odule_name, const void *data,
> >         }
> >
> >         btf_verifier_env_free(env);
> > +       btf_check_sorted(btf);
> >         refcount_set(&btf->refcnt, 1);
> >         return btf;
> >
> > --
> > 2.34.1
> >

