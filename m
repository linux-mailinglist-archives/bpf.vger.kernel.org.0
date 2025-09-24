Return-Path: <bpf+bounces-69641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F18B9CB7D
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 01:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC6819C6BE7
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 23:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9427429BD83;
	Wed, 24 Sep 2025 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYb1xXtm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D33E22422E
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757902; cv=none; b=PsZXUwrn+yQlaJLwZzxR/wyD4iuoZxoSdUux29je6JVxZvkQEiS2PzI1z8c1r+h7QCh8cgYqXbUcCP7y4Yvwzl0QVwO6wUyONx4iv1JbFVqfQUztzuU+5hTs0mZamkNinztGTdvBxdRQK90opMLzO+rddF05IgdzziGTv8RUA/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757902; c=relaxed/simple;
	bh=V+e6NgtRg4CTyrBn62z+8s5V2ApNRZeSiEjo1YkIuws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phJaFG/DytbEcF0vF+sebieZ53d/66x9I6YgTZVdjIAby+5hguMLVGWNGNWZT/yGMacK8zMw1LVxXOPVaBofTNawGn9ObjSRDXS7gELb72iPa6Dq2lGJt71Cdvl0IQhpl0rbA7tKW5d93yvvq4u9tNqub4+SO/13SxjFR45z/OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYb1xXtm; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so467625a91.1
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 16:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758757900; x=1759362700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qZtM7pCTlUkcsOWvT5z6LUI0aFsIPK03lrsjPZe2kA=;
        b=GYb1xXtmvl9O47kiLUnTJOZz2+m0vQuz5ThhxoElZaeJxBt1vw8vV4jdsP1sS3A62X
         KDSh2DT9IwMvK2StGeVSZrCOnDKHON0mJvbKIsWigMsKdtFloNGykhM9eKzVp9Gt7emS
         nNsa8UgGasNiI/FeS18TlXeOYzGBBHBLBi7Mzo60FzDYwwkmG1CLattbt4Hb2q0ZqmUP
         Zh1EVJ1ybW6uJAAWTdx6RqsnihIeOBUddjSvlGX3GybZTk4VYdwNrzTGVS8A9pbOjCGn
         3QR7MjFN88uBJDUN46CzW1oIMkhnJNvdaO5CE4UXKEl2qtK9lR0ChLQzl25LYqhiz/Yg
         EJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757900; x=1759362700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qZtM7pCTlUkcsOWvT5z6LUI0aFsIPK03lrsjPZe2kA=;
        b=JR2U1gj3L8pGgRKwmFQGimEWIK91fgdxyn7sC2GjJ1OAVZfwrOedIcKmem6F8mJBDu
         K69/+3NjdVWG4dtm+maFhHQANmroglFZY/NM38gekzbkqYJms2HsfKcIoeMShShjWff7
         rmRKVO7HjAF5FUvxw9p9S70hJgk1OBfbw2BM1wXUvdEla/B9paMHBADwRi3DrIjle9eW
         d1FgrD4GfcbNrJ4INvv51Kn73rm7MsSDxwsyrxQrfV5/iG+0E4HnldWgxL1xfTvJI51C
         07nRRdkAtpa8MWlCKiv0nxGShG2v/FChrQEcsCvrKRMzBL64MnF3O8ZsW9A9jjst8RcE
         g9TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJXW0vYOUQHdri8ZM4cRi2F5G+nz2LdJPT1SDNwq8iXwAg7yInJsq8iFUC/zv4NGU0Y/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU13ESb6E38i9AfldW/4JCmOzUyGZ7upgVvh0/Xw4/sXg3amgJ
	7Q98zYbtPn7WY7JsBfqmpljYrJRGXaBlKYjtneKy+ggglimhxPOstimaWppAfsERghLtW5LfVAX
	ooX2N0T4JlIWbL6cus47olVUOxUcPQNk=
X-Gm-Gg: ASbGncvN8gJn5dzMk22BVQEjPGb//Ukv9+Fkf+kBepnpbIrtx5SjHT7nKYsulbQ8jO8
	310PZYOzx6FNBWLXCP3qomrjv4B/PSkVifdTEU9vVIt+B9u9bMyVuR3WkxFT7UlwdoVarDjici3
	zvvCjDU2RMaXLqw82tphs+6hVIFRW09newijBNznwNiVALLtWunQ3M+25GrxNRzcD3pdDZMPAHQ
	Hm67wTqTjSTapfBNR5AbcA=
X-Google-Smtp-Source: AGHT+IEuvoGh6upSehZjqtCEOtXpeSMCsy4dC04ky2MHe0YehOImO+HBp78e6xe42TwvL3GACsG7jOrXHXRW9We/7TU=
X-Received: by 2002:a17:90b:4b4c:b0:32e:3830:65e1 with SMTP id
 98e67ed59e1d1-3342a2f01e3mr1561148a91.33.1758757899836; Wed, 24 Sep 2025
 16:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918080342.25041-1-alibuda@linux.alibaba.com>
 <20250918080342.25041-4-alibuda@linux.alibaba.com> <CAEf4BzY5oowUpq2x3Uz+TNi=8GJgc1FDzS-u5UqZwNXvkWtSEw@mail.gmail.com>
 <20250924080634.GA14633@j66a10360.sqa.eu95>
In-Reply-To: <20250924080634.GA14633@j66a10360.sqa.eu95>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Sep 2025 16:51:24 -0700
X-Gm-Features: AS18NWCjKLKT8_-PtXMG6XiZlDV75Kg21s5qtPwsoXf4y_w3GqcRtwgvOcVLMeQ
Message-ID: <CAEf4Bza=qH6CLULLoVy1nKUicDG1zi4rW-sXU8fhgU6V+E8+kg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] libbpf: fix error when st-prefix_ops and
 ops from differ btf
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, sdf@google.com, 
	haoluo@google.com, yhs@fb.com, edumazet@google.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, jolsa@kernel.org, mjambigi@linux.ibm.com, 
	wenjia@linux.ibm.com, wintera@linux.ibm.com, dust.li@linux.alibaba.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, bpf@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	sidraya@linux.ibm.com, jaka@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 1:06=E2=80=AFAM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
> On Fri, Sep 19, 2025 at 03:22:41PM -0700, Andrii Nakryiko wrote:
> > On Thu, Sep 18, 2025 at 1:03=E2=80=AFAM D. Wythe <alibuda@linux.alibaba=
.com> wrote:
> > >
> > >
> > > At present, cases 0, 1, and 3 can be correctly identified, because
> > > st_ops_xxx_ops is searched from the same btf with xxx_ops. In order t=
o
> > > handle case 2 correctly without affecting other cases, we cannot simp=
ly
> > > change the search method for st_ops_xxx_ops from find_btf_by_prefix_k=
ind()
> > > to find_ksym_btf_id(), because in this way, case 1 will not be
> > > recognized anymore.
> > >
> > > To address the issue, we always look for st_ops_xxx_ops first,
> > > figure out the btf, and then look for xxx_ops with the very btf to av=
oid
> >
> > What's "very btf"? Commit message would benefit from a little bit of
> > proof-reading, if you can. It's a bit hard to follow, even if it's
> > more or less clear at the end what problem you are trying to solve.
> >
> > Also, I'd suggest to send this fix as a separate patch and not block
> > it on the overall patch set, which probably will take longer. This fix
> > is independent, so we can land it much faster.
> >
>
> Thanks a lot for your suggestion. I'll improve the commit message.
>
> It's fine to send this patch separately, I'm concerned it won't be
> verifiable in isolation without the other patches. But if you feel
> it's okay to proceed, I'm happy to do so.

I think the issue is pretty clear, I don't mind fixing it outside of
the patch set introducing this mixed vmlinux vs module BTF. So yes,
please send a patch (unless you already did, as I'm catching up on
emails)

>
> > > such issue.
> > >
> > > Fixes: 590a00888250 ("bpf: libbpf: Add STRUCT_OPS support")
> > > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 37 ++++++++++++++++++-------------------
> > >  1 file changed, 18 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index fe4fc5438678..50ca13833511 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -1013,35 +1013,34 @@ find_struct_ops_kern_types(struct bpf_object =
*obj, const char *tname_raw,
> > >         const struct btf_member *kern_data_member;
> > >         struct btf *btf =3D NULL;
> > >         __s32 kern_vtype_id, kern_type_id;
> > > -       char tname[256];
> > > +       char tname[256], stname[256];
> > >         __u32 i;
> > >
> > >         snprintf(tname, sizeof(tname), "%.*s",
> > >                  (int)bpf_core_essential_name_len(tname_raw), tname_r=
aw);
> > >
> > > -       kern_type_id =3D find_ksym_btf_id(obj, tname, BTF_KIND_STRUCT=
,
> > > -                                       &btf, mod_btf);
> > > -       if (kern_type_id < 0) {
> > > -               pr_warn("struct_ops init_kern: struct %s is not found=
 in kernel BTF\n",
> > > -                       tname);
> > > -               return kern_type_id;
> > > -       }
> > > -       kern_type =3D btf__type_by_id(btf, kern_type_id);
> > > +       snprintf(stname, sizeof(stname), "%s%.*s", STRUCT_OPS_VALUE_P=
REFIX,
> > > +                (int)strlen(tname), tname);
> > >
> > > -       /* Find the corresponding "map_value" type that will be used
> > > -        * in map_update(BPF_MAP_TYPE_STRUCT_OPS).  For example,
> > > -        * find "struct bpf_struct_ops_tcp_congestion_ops" from the
> > > -        * btf_vmlinux.
> > > +       /* Look for the corresponding "map_value" type that will be u=
sed
> > > +        * in map_update(BPF_MAP_TYPE_STRUCT_OPS) first, figure out t=
he btf
> > > +        * and the mod_btf.
> > > +        * For example, find "struct bpf_struct_ops_tcp_congestion_op=
s".
> > >          */
> > > -       kern_vtype_id =3D find_btf_by_prefix_kind(btf, STRUCT_OPS_VAL=
UE_PREFIX,
> > > -                                               tname, BTF_KIND_STRUC=
T);
> > > +       kern_vtype_id =3D find_ksym_btf_id(obj, stname, BTF_KIND_STRU=
CT, &btf, mod_btf);
> > >         if (kern_vtype_id < 0) {
> > > -               pr_warn("struct_ops init_kern: struct %s%s is not fou=
nd in kernel BTF\n",
> > > -                       STRUCT_OPS_VALUE_PREFIX, tname);
> > > +               pr_warn("struct_ops init_kern: struct %s is not found=
 in kernel BTF\n", stname);
> > >                 return kern_vtype_id;
> > >         }
> > >         kern_vtype =3D btf__type_by_id(btf, kern_vtype_id);
> > >
> > > +       kern_type_id =3D btf__find_by_name_kind(btf, tname, BTF_KIND_=
STRUCT);
> > > +       if (kern_type_id < 0) {
> > > +               pr_warn("struct_ops init_kern: struct %s is not found=
 in kernel BTF\n", tname);
> > > +               return kern_type_id;
> > > +       }
> > > +       kern_type =3D btf__type_by_id(btf, kern_type_id);
> > > +
> > >         /* Find "struct tcp_congestion_ops" from
> > >          * struct bpf_struct_ops_tcp_congestion_ops {
> > >          *      [ ... ]
> > > @@ -1054,8 +1053,8 @@ find_struct_ops_kern_types(struct bpf_object *o=
bj, const char *tname_raw,
> > >                         break;
> > >         }
> > >         if (i =3D=3D btf_vlen(kern_vtype)) {
> > > -               pr_warn("struct_ops init_kern: struct %s data is not =
found in struct %s%s\n",
> > > -                       tname, STRUCT_OPS_VALUE_PREFIX, tname);
> > > +               pr_warn("struct_ops init_kern: struct %s data is not =
found in struct %s\n",
> > > +                       tname, stname);
> > >                 return -EINVAL;
> > >         }
> > >
> > > --
> > > 2.45.0
> > >

