Return-Path: <bpf+bounces-78427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCF5D0C902
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 00:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBE6D301CE99
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 23:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5BC340D86;
	Fri,  9 Jan 2026 23:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix/gH/gI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07580320CDF
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 23:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768002207; cv=none; b=lp5Z7mRq1bGaoIMnXKKITAsrBTyvQgJO/ha9RBJI7xGuBiNzb66NDn2sqez/x4VGReEq4ZIYWWjN8pZg2WIi0hf5mx7h3tOffmp/R+qqrSBscUJX6DiqQgnPuzonrESs8Wu7I++3DapIZGJvTqMo61KWJieD6MAm5sFe5mdZTpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768002207; c=relaxed/simple;
	bh=Sb5r0wywbagilleJPW6QO97Po4jOyhKWAwIHTnrvyVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qW1itL82XP1tiKUPV41eBoL+nGjIyw5xiRaFH1yCL8GMXDZhDFd7jwuSgsr3h99ckxL/3DsY8QNGr0s3f4EL0EYsiA7zo4N2KeiJRV3lonOJnRbV0plDXqzWVravMQWy4K+LRrLbNxOdcHz2w9rtb6/QCz5NkPrl8SMzzVbz9gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ix/gH/gI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81ef4b87291so288368b3a.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 15:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768002205; x=1768607005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHCpnerOC5um4xc4HZEsI+ZEnjV9mj0ABla+PkLDu8I=;
        b=Ix/gH/gIRS9RehlY08NZx7X2go06xceu7MSXRB27DO1Ct2FFDExN7QYgPdqrUE/qe7
         fFOLq9van0tr/SgVLM5IcG6bd9qEZe+fxbSHhOoQE/uaad4DelGemnDVb8nt/LC9pvh4
         kVU4NJkVnggi4LsyGOOlexvtlK8V02zwvY7ZJ0aPzb0wTLunkKFsP3UxGjEkEGjwz7o1
         RtISwT/8rXNW7Rj7t/Li8KPc6+cc2LdtO6WP9BAwpg1GIz3wpBxhUVoncx7A3C5RpnM6
         /1JiOitrjjVfNyjK4vAc/EvgiFLnWhfpPMihNV7aHC6UK7LuSeUDyBb8YIxcywmy+q1c
         dMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768002205; x=1768607005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DHCpnerOC5um4xc4HZEsI+ZEnjV9mj0ABla+PkLDu8I=;
        b=qBIeogstDV7O4vCxmH6nahD2BOTIVyFtD2pDDDJ+byK86L7KlCTJ3nJ6w1163VzCJs
         tMnS+XGtkl7Q5zX3hsMHxmEZM027m/vTsRAX+iE0YbbebQXhRa73HgCTf7tGOoEEXZ0G
         1E0efQi0rxYM5S736vFUxToFFJY5ra435KiJ79+hloWZiFR5AUcVcstDqmGH2O0CJgBN
         dKNsHvJLO+jQgNVZ7deX8Rd1suY5kg+2IoElh0QBrrhxr19SIXDXlIHlhgVYCtBTvhD3
         p0oI4Wjb80xqX4EJqe/U2lq45fWVg4lvJlHJSanxr/JIgXjWwfnc6KPAfZ3o0RSQUHis
         FQmw==
X-Forwarded-Encrypted: i=1; AJvYcCURaC190oJeOrD+Ur/T1lhAnbVc7i/6pRC0oahFSqb9WJRBsh+ZBHWiDbD8f60RtzNSRFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN4l7d+fFtBzRtE1DKlihLHiZy5HFEH2AO9ii3vj8wl+c1OEyw
	btbwV6VCCOKdfou6WpMHGafFPZS+VYCsEorXR3fyPtOcqtj2sOFaacjR3gO8ZbSdQcnnamcD7/0
	e8ogysJGrZhM+B5KEzNMdpiNj5m8C310=
X-Gm-Gg: AY/fxX6KLPNc9ZdK2iZA+0cqrAI4xUJNRxhcevSudBN1aVoRsLMiH6Gr5s/175mZzq9
	+RqbOZ70E1j8X25HqYNtvKEgYRmVajKCYtyd/Z6fd+SbIghESF4gSxkrj1RPGIS84fOc+JO2vuQ
	+Zy0qplI/ho+amayTsLiquVop3wJEK7qrWs0C8EbcFs6FSLURtBjXOzEhN4xfZbEXsXS0YGt41M
	UD4kw/XDnh+I76QibFqmswtY87CVFOavhTifwB+q9ULZtMESl0eaFdQ8wx0hiSp2P3bk3Qi7xPJ
	smbWZQkB
X-Google-Smtp-Source: AGHT+IHsqm595MasKmBW9NPEldGblkfM3NXLU1oq+e7lUifnNa7rZBL4P9VMRWULEBtPSdfo3CSEVDVgqQasmKva4fg=
X-Received: by 2002:a17:90b:3e43:b0:34a:b4a2:f0bf with SMTP id
 98e67ed59e1d1-34f68c28716mr11665088a91.16.1768002205140; Fri, 09 Jan 2026
 15:43:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223103214.2412446-1-wangjinchao600@gmail.com>
 <20251223092932.0a804e046fc2e5de236ced69@linux-foundation.org>
 <86b3f8af-299a-4ae7-b2dc-0b068046fe92@kernel.org> <CAEf4BzaozamTRoK8YromvPZ3b1wNBvxwWrbpfpX4ZFwkMDbMGg@mail.gmail.com>
 <b15ad63d-100e-4326-961b-5cb2de3332d8@kernel.org>
In-Reply-To: <b15ad63d-100e-4326-961b-5cb2de3332d8@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 15:43:12 -0800
X-Gm-Features: AQt7F2oHmRI8vjhhnfCk44dtIj4x1B7ASPD5jcy31R0S7xg8y2qUDCvf6V0Bb2k
Message-ID: <CAEf4BzaRABPLFV-tVXqCrAgd07nkvcqNA-QZqt8RvSLcmu16mQ@mail.gmail.com>
Subject: Re: [PATCH] buildid: validate page-backed file before parsing build ID
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jinchao Wang <wangjinchao600@gmail.com>, 
	Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	syzbot+e008db2ac01e282550ee@syzkaller.appspotmail.com, 
	Axel Rasmussen <axelrasmussen@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@kernel.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Wei Xu <weixugc@google.com>, Yuanchu Xie <yuanchu@google.com>, Omar Sandoval <osandov@fb.com>, 
	Deepanshu Kartikey <kartikey406@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 11:16=E2=80=AFAM David Hildenbrand (Red Hat)
<david@kernel.org> wrote:
>
> On 1/5/26 23:52, Andrii Nakryiko wrote:
> > On Tue, Dec 30, 2025 at 2:11=E2=80=AFPM David Hildenbrand (Red Hat)
> > <david@kernel.org> wrote:
> >>
> >> On 12/23/25 18:29, Andrew Morton wrote:
> >>> On Tue, 23 Dec 2025 18:32:07 +0800 Jinchao Wang <wangjinchao600@gmail=
.com> wrote:
> >>>
> >>>> __build_id_parse() only works on page-backed storage.  Its helper pa=
ths
> >>>> eventually call mapping->a_ops->read_folio(), so explicitly reject V=
MAs
> >>>> that do not map a regular file or lack valid address_space operation=
s.
> >>>>
> >>>> Reported-by: syzbot+e008db2ac01e282550ee@syzkaller.appspotmail.com
> >>>> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> >>>>
> >>>> ...
> >>>>
> >>>> --- a/lib/buildid.c
> >>>> +++ b/lib/buildid.c
> >>>> @@ -280,7 +280,10 @@ static int __build_id_parse(struct vm_area_stru=
ct *vma, unsigned char *build_id,
> >>>>       int ret;
> >>>>
> >>>>       /* only works for page backed storage  */
> >>>> -    if (!vma->vm_file)
> >>>> +    if (!vma->vm_file ||
> >>>> +        !S_ISREG(file_inode(vma->vm_file)->i_mode) ||
> >>>> +        !vma->vm_file->f_mapping->a_ops ||
> >>>> +        !vma->vm_file->f_mapping->a_ops->read_folio)
> >>>>               return -EINVAL;
> >>
> >> Just wondering, we are fine with MAP_PRIVATE files, right? I guess it'=
s
> >> not about the actual content in the VMA (which might be different for =
a
> >> MAP_PRIVATE VMA), but only about the content of the mapped file.
> >
> > Yep, this code is fetching contents of a file that backs given VMA.
>
> Good!
>
> >
> >>
> >>
> >> LGTM, although I wonder whether some of these these checks should be
> >> exposed as part of the read_cache_folio()/do_read_cache_folio() API.
> >>
> >> Like, having a helper function that tells us whether we can use
> >> do_read_cache_folio() against a given mapping+file.
> >
> > I agree, this seems to be leaking a lot of internal mm details into
> > higher-level caller (__build_id_parse). Right now we try to fetch
> > folio with filemap_get_folio() and if that succeeds, then we do
> > read_cache_folio. Would it be possible for filemap_get_folio() to
> > return error if the folio cannot be read using read_cache_folio()? Or
> > maybe have a variant of filemap_get_folio() that would have this
> > semantic?
>
> Good question. But really, for files that always have everything in the p=
agecache,
> there would not be a problem, right? I'm thinking about hugetlb, for exam=
ple.
>
> There, we never expect to fallback to do_read_cache_folio().
>
> So maybe we could just teach do_read_cache_folio() to fail properly?
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index ebd75684cb0a7..3f81b8481af4c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -4051,8 +4051,11 @@ static struct folio *do_read_cache_folio(struct ad=
dress_space *mapping,
>          struct folio *folio;
>          int err;
>
> -       if (!filler)
> +       if (!filler) {
> +               if (!mapping->a_ops || !mapping->a_ops->read_folio)
> +                       return ERR_PTR(-EINVAL);
>                  filler =3D mapping->a_ops->read_folio;
> +       }
>   repeat:
>          folio =3D filemap_get_folio(mapping, index);
>          if (IS_ERR(folio)) {
>
> Then __build_id_parse() would only check for the existence of vma->vm_fil=
e and maybe
> the !S_ISREG(file_inode(vma->vm_file)->i_mode).
>

That would be great. But something like this was proposed earlier and
Matthew didn't particularly like this approach ([0]).

  [0] https://lore.kernel.org/all/aReUv1kVACh3UKv-@casper.infradead.org/

>
> --
> Cheers
>
> David

