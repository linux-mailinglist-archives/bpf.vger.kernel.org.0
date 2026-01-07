Return-Path: <bpf+bounces-78040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AC8CFBE8B
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 04:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 095F1310EA87
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 03:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2342C21DD;
	Wed,  7 Jan 2026 03:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RybFakUZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7342BE658
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 03:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767757546; cv=none; b=HjzX1XhDaCBUuDD6wgC2ri9hloGuTSmkh0+HN9NdD6FbRsTqK2fY6tJraD/pxoBJlJ8dO3sHFwOjbcGT7KLgrLfuYwCMOjoEqciRe189/hVoeqUVP4qDt6u95YTkCmb0mRohjjnYNe/94dCEWVwunXgrXpF8VTOQ52qGqaXrkNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767757546; c=relaxed/simple;
	bh=9GnewEJFAZob3Lju3UHVKejDu0hbjk+If50TdCYlnjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aywmFrlyYkQ3qH8OYzffKjA+ht8XZjQkoTVlh20DyMhqqIHT58e92NQMkMczE+EwNiD3kVhhAByQvPA3C8wNN4TQqq4KROlQ48a+kIXWuztXMVnl5A6nfcr8UoqXV1RexpFoc+1VvdKqjT+4xYy5JQYm/TojMmp8JKavKb/9omA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RybFakUZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b804646c718so240858566b.2
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 19:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767757541; x=1768362341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceXpaTM5Ol9H+c8sTXDz/rrUJ1A5Cj0BMs5WXoYNYXc=;
        b=RybFakUZlfCkLdhhuO2bDPeN5H4S+hw2p68vEAZolJA/492mQw4PXClQgIzWClydus
         mT1sOOwTagxrJNR3HtnGho/fsD4b71n+oCNAwOjd/644dL9pn+PejtgaRhpnQ6fHnRVu
         FuScCMcenbnWHZw4MTa4Aafz8CyhJ+wuMot6sNqGcc2ytEODN5MhwWq7PmJokCQ+Jprr
         y9zSk8Z9oAv55nv1poo2CdnPzUExbw1JcfcLY/or92G4BhKb75lFKdSSanfCy2riok08
         mohnK0WvJx30BStfqi2Zjxl4G/oN4BwQH+E3bxr5PYXPoY3A02gUXXSYoOfGSYwFgN1I
         ShPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767757541; x=1768362341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ceXpaTM5Ol9H+c8sTXDz/rrUJ1A5Cj0BMs5WXoYNYXc=;
        b=Blpt8KkTKMU493KiSxSD2pxr6mVh+vKxvAwm47TlOpqvnasZ03JA+u7HbO3dJ21nWw
         Hvzu4wFd8qa2RSKvnB2kUdm1MuyzZTuRvnK8sZNRWIr2zwcsR5QpPIytAELnZphkg1LR
         PlgiVJIXWOZ+Fii2xHdd/EJHU7l0Mk8VeBxdm9NH3jtpQuste+PzT7YW4JP5kpLjTUun
         JTKHahgzcHzijD3Ay5rcpkqHqGeni8AhjmzrrozOnv2WiikUzPcsBl3QmHiiWwd2JlB9
         C3sK5OKrWsrclAyI6AAaEHKNjYXK+oynEsqAZjzR7BStsTRf1zJUNfDghqqA5ObekCnm
         JWtw==
X-Forwarded-Encrypted: i=1; AJvYcCWalMSnySjskN4ld/asqq+Sf/LokKV5nV4R2jfXQHCAgU1wEMQqmMDZvE9ysFQo/lEQnDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQnUmJfH/Sew8QeiDSpj3z/UMzUoidQ23fv4OXgg/L0/+MqRO+
	UuiP6b/00YzDJdA02Xi9CrJV3ho3+SH97j5cCMdsZU4xSjmRq+7D5ZkJxrPku6s792ZZ0UZUzeS
	NgBoh0qqzovd9DCyj38DWbFNWOaU7IUQ=
X-Gm-Gg: AY/fxX63mihnmQr8000rIdMyu2wV+HoY5oDlM/PQAGUUSAqYAU+rnCXb4350S7JN+sD
	vkwfxPaWN+MDavjuLZPTfAQGlPgo3T2DBSJrrkPxpWhDBdStr4GLqIhN9w11Q24XcPCryllMgNh
	82fk0xi184suncZk0ZTUqUrpUAafSZRm5kaRJlU6jetCNeFcvIg58FzBaSuKodwHC9uvF5bcRmP
	ic1QTaO78qh4Aw/VYgCspcbXK6VcGOxvD/6FUVFe4I+4K02sCUwOPrS8dQtEP9xqZUE2OvJZGrG
	sJoE9zI=
X-Google-Smtp-Source: AGHT+IGd8SvULzqaCj+mwh1XP/Lv95EYGXD9sVcfeZvyV5x/nXJ3f4i/xwWzNgHWjIkQwIjk4q/YnL9Ou5EvbWhFQzo=
X-Received: by 2002:a17:907:2d88:b0:b76:7e90:713f with SMTP id
 a640c23a62f3a-b84451692fdmr131542766b.10.1767757541412; Tue, 06 Jan 2026
 19:45:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-6-dolinux.peng@gmail.com> <CAEf4BzY+gnT9aET_NDOkzX2iBwLednyK4xGe4S6JmhzN0C5GoA@mail.gmail.com>
 <CAErzpmusyOMQTcoWiT7nNa=gOAOHgdRYqVb+Dc24BaqjzzeRYw@mail.gmail.com>
 <CAEf4BzY=3KWxZ1F98sE-zB0g-HKz87HJ5msBYESZ0Ri0jN=WCg@mail.gmail.com> <CAErzpmsvirekLBRrJYVgmRC0YKWCbo7OyRQXgNYrk83aF-Wz2Q@mail.gmail.com>
In-Reply-To: <CAErzpmsvirekLBRrJYVgmRC0YKWCbo7OyRQXgNYrk83aF-Wz2Q@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 7 Jan 2026 11:45:29 +0800
X-Gm-Features: AQt7F2qae3DZ1nwOnkA8AGmme34o_FaO955WhYKqG4tJpZkkMt0u5vOxVi-lzrE
Message-ID: <CAErzpmv99TG_pjyjcQd5xjC7M+yUGs6SNtL9b3nJQAC8z-nafw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 05/13] libbpf: Verify BTF Sorting
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 10:36=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.c=
om> wrote:
>
>
>
> On Sat, Dec 20, 2025 at 1:33=E2=80=AFAM Andrii Nakryiko <andrii.nakryiko@=
gmail.com> wrote:
> >
> > On Thu, Dec 18, 2025 at 9:06=E2=80=AFPM Donglin Peng <dolinux.peng@gmai=
l.com> wrote:
> > >
> > > On Fri, Dec 19, 2025 at 7:44=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@=
gmail.com> wrote:
> > > > >
> > > > > From: pengdonglin <pengdonglin@xiaomi.com>
> > > > >
> > > >
> > > > typo in subject: "Sorting" -> "sorting", it looks weird capitalized=
 like that
> > >
> > > Thanks, I will do it.
> > >
> > > >
> > > > > This patch checks whether the BTF is sorted by name in ascending
> > > > > order. If sorted, binary search will be used when looking up type=
s.
> > > > >
> > > > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > > > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > > > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > > > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > > > ---
> > > > >  tools/lib/bpf/btf.c | 41 +++++++++++++++++++++++++++++++++++++++=
++
> > > > >  1 file changed, 41 insertions(+)
> > > > >
> > > > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > > > index 2facb57d7e5f..c63d46b7d74b 100644
> > > > > --- a/tools/lib/bpf/btf.c
> > > > > +++ b/tools/lib/bpf/btf.c
> > > > > @@ -899,6 +899,46 @@ int btf__resolve_type(const struct btf *btf,=
 __u32 type_id)
> > > > >         return type_id;
> > > > >  }
> > > > >
> > > > > +/*
> > > > > + * Assuming that types are sorted by name in ascending order.
> > > > > + */
> > > >
> > > > Unnecessary comment, and no, btf_compare_type_names() itself makes =
no
> > > > such assumption, it just compares two provided types by name. Drop =
the
> > > > comment, please.
> > > >
> > > > > +static int btf_compare_type_names(__u32 *a, __u32 *b, const stru=
ct btf *btf)
> > > > > +{
> > > > > +       struct btf_type *ta =3D btf_type_by_id(btf, *a);
> > > > > +       struct btf_type *tb =3D btf_type_by_id(btf, *b);
> > > > > +       const char *na, *nb;
> > > > > +
> > > > > +       na =3D btf__str_by_offset(btf, ta->name_off);
> > > > > +       nb =3D btf__str_by_offset(btf, tb->name_off);
> > > > > +       return strcmp(na, nb);
> > > > > +}
> > > >
> > > > you use this function only in one place, there is no real point hav=
ing
> > > > it, especially that it uses **a pointer to type ID** as an
> > > > interface... just inline its logic in that one loop below
> > > >
> > > > > +
> > > > > +static void btf_check_sorted(struct btf *btf)
> > > > > +{
> > > > > +       const struct btf_type *t;
> > > > > +       __u32 i, k, n;
> > > > > +       __u32 sorted_start_id;
> > > > > +
> > > > > +       if (btf->nr_types < 2)
> > > > > +               return;
> > > >
> > > > why special casing? does it not work with nr_types =3D 0 or nr_type=
s =3D 1?
> > >
> > > No. I just think it doesn't make any sense to check the sorting
> > > of BTF with zero or only one type.
> > >
> >
> > Look, I don't know how to emphasize this enough. Any special case like
> > this is nothing good, it adds more cases to consider and raises
> > questions why generic case code doesn't handle such special cases. It
> > implies that generic case handling might have some unhandled corner
> > case that we are trying to short-circuit with early exits like this.
> > It just basically means we don't trust our code, in a sense. It's just
> > unnecessary and thus sloppy. Don't do this unnecessarily.
>
> Thank you for taking the time to explain this so clearly. I=E2=80=99m gra=
teful for
> your patience in pushing for rigor =E2=80=94 it=E2=80=99s exactly the kin=
d of scrutiny that
> makes the codebase stronger. I=E2=80=99ll make sure to apply this lesson =
in future
> revisions.
>
> >
> > > >
> > > > > +
> > > > > +       sorted_start_id =3D 0;
> > > >
> > > > nit: initialize in declaration
> > >
> > > Thanks, I will do it.
> > >
> > > >
> > > >
> > > > > +       n =3D btf__type_cnt(btf);
> > > > > +       for (i =3D btf->start_id; i < n; i++) {
> > > > > +               k =3D i + 1;
> > > > > +               if (k < n && btf_compare_type_names(&i, &k, btf) =
> 0)
> > > > > +                       return;
> > > > > +               if (sorted_start_id =3D=3D 0) {
> > > > > +                       t =3D btf_type_by_id(btf, i);
> > > > > +                       if (t->name_off)
> > > >
> > > > I'd check actual string, not name_off. Technically, you can have em=
pty
> > > > string with non-zero name_off, so why assume anything here?
> > >
> > > Thanks, I will do it.
> > >
> > > >
> > > > > +                               sorted_start_id =3D i;
> > > > > +               }
> > > > > +       }
> > > > > +
> > > > > +       if (sorted_start_id)
> > > > > +               btf->sorted_start_id =3D sorted_start_id;
> > > >
> > > > You actually made code more complicated by extracting that
> > > > btf_compare_type_names(). Compare to:
> > > >
> > > > n =3D btf__type_cnt(btf);
> > > > btf->sorted_start_id =3D 0;
> > > > for (i =3D btf->start_id + 1; i < n; i++) {
> > > >    struct btf_type *t1 =3D btf_type_by_id(btf, i - 1);
> > > >    struct btf_type *t2 =3D btf_type_by_id(btf, i);
> > > >    const char *n1 =3D btf__str_by_offset(btf, t1->name_off);
> > > >    const char *n2 =3D btf__str_by_offset(btf, t2->name_off);
> > > >
> > > >    if (strcmp(n1, n2) > 0)
> > > >         return;
> > > >    if (btf->sorted_start_id =3D=3D 0 && n1[0] !=3D '\0')
> > > >         btf->sorted_start_id =3D i - 1;
> > > > }
> > >
> > > Thanks. I believe we shouldn't directly assign a value to
> > > `btf->sorted_start_id` within the for loop, because
> > > `btf->sorted_start_id` might be non-zero even when the
> > > BTF isn't sorted.
> >
> > Ah, right, we'd need to reset btf->sorted_start_id to zero in that
> > strcmp(n1, n2) > 0 branch. Using btf->sorted_start_id directly is not
> > the main point here, though, feel free to use a local variable, but
> > don't add unnecessary helper functions which don't do much, but
> > obscure the logic unnecessarily.
>
> Thanks, I will use a local variable and remove the helper functions.

Hi Andrii,

I noticed that the code above does not handle the scenario where
only the last btf_typein a sorted BTF has a name. So I've added an
additional check in the loop as follows:

static void btf_check_sorted(struct btf *btf)
{
        __u32 i, n, named_start_id =3D 0;

        n =3D btf__type_cnt(btf);
        for (i =3D btf->start_id + 1; i < n; i++) {
                struct btf_type *ta =3D btf_type_by_id(btf, i - 1);
                struct btf_type *tb =3D btf_type_by_id(btf, i);
                const char *na =3D btf__str_by_offset(btf, ta->name_off);
                const char *nb =3D btf__str_by_offset(btf, tb->name_off);

                if (strcmp(na, nb) > 0)
                        return;

                if (named_start_id =3D=3D 0) {
                        if (na[0] !=3D '\0')
                                named_start_id =3D i - 1;
                        else if (i =3D=3D (n - 1) && nb[0] !=3D '\0') /*
only the last one has a name */
                                named_start_id =3D i;
                }
        }

        if (named_start_id)
                btf->named_start_id =3D named_start_id;
}

WDYT?

>
> >
> > >
> > > >
> > > >
> > > > No extra k<n checks, no extra type_by_id lookups. It's minimalistic
> > > > and cleaner. And if it so happens that we get single type BTF that =
is
> > > > technically sorted, it doesn't matter, we always fallback to faster
> > > > linear search anyways.
> > > >
> > > > Keep it simple.
> > >
> > > Thank you. I will adopt this method in the next version.
> > >
> > > >
> > > > > +}
> > > > > +
> > > > >  static __s32 btf_find_by_name_bsearch(const struct btf *btf, con=
st char *name,
> > > > >                                                 __s32 start_id, _=
_s32 end_id)
> > > > >  {
> > > > > @@ -1147,6 +1187,7 @@ static struct btf *btf_new(const void *data=
, __u32 size, struct btf *base_btf, b
> > > > >         err =3D err ?: btf_sanity_check(btf);
> > > > >         if (err)
> > > > >                 goto done;
> > > > > +       btf_check_sorted(btf);
> > > > >
> > > > >  done:
> > > > >         if (err) {
> > > > > --
> > > > > 2.34.1
> > > > >

