Return-Path: <bpf+bounces-29140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A328C079C
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 01:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F92D28384B
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 23:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FA078C72;
	Wed,  8 May 2024 23:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKrGV2Pc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC477393
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 23:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715210529; cv=none; b=NhSvtMpYvMgv9yViOPyB1Jo/sQ7EhUHaaKtEiRwGUsa7rLzZloVDbVYG/Nmr7J3Ufl5IXfWIJeGh1uEi7JfCiZ+zgZRaWWDg3U+HXg68y5xiU+rUElNq6n70f9i/rglm2jLiCiUsOAa0KA9bKQvwa3t3c1jQuofQGaURG+SiQtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715210529; c=relaxed/simple;
	bh=1goXU7Gh7CSCOX6ZgyXp+gfQGjElOHhjSGAwAmw56Mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEh3FlXulGHl0dWcw2MCthD1TnC07/YmcozwnIUeYp9UD+Mwv1bqFVK+82rGEB4VVsJMtSQAyPwBsJdfvqKLFkJNoKTjBwg6JaixGoO6U6gW7PPAjXvySCm3co807ebI090LLpBFIw60ZaQEKcXV4/tZiJ8Xtk7urqkeJe/0IGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKrGV2Pc; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso245240a12.2
        for <bpf@vger.kernel.org>; Wed, 08 May 2024 16:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715210527; x=1715815327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vhlu2LHkqp5UCJbb2pLyaiM21n8fb7OoBolJ9lqJ09M=;
        b=TKrGV2PcPsKpYTWHnqlXE34ZM0SpfPtCwQ8sE4dpqy8SHVmZjU+hREwegw4Hfi+sHa
         KhzMVVPcrZ2iu41PgKy9agMVo0+EjzwxS4UUX3rFmwv4yutB6iZZd1tKdFqrLdS3Y+0L
         83KHH0xmQPeBAFtx4PA6QH/ZBBxnYv9CElRcxAp2O6OvUwa6BHs8n4P4ESJtAhovNtX+
         2x4zvHp27T2zUDjiEjtVIOMqKX/u5MzMpnFnpo47VfXXJd5gPnl/Is/6tbN2cogucm7R
         A+kYVZfecm+0PD0cH/JWfQ8WxrUN/BDNl+Ghq0c7PLlmY7OKujFFUP/u+G/dlHWGNmDd
         cULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715210527; x=1715815327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vhlu2LHkqp5UCJbb2pLyaiM21n8fb7OoBolJ9lqJ09M=;
        b=szClHtea3iMBnW/u+DLxmpGFUr+iuU9m9Dhdo2VUXZwBx7t5QGkx2/d54/2tHx+MKJ
         8atuyr2JG9cNG1BQioKnGCQXLX5XL7Zj+qUFKNxQKEjBDNmuT8IaXGiWaYPHeEEMK2Dw
         E7NEdpXv/TMfvDKvxnt1OImUbw2j6k8jvHDiWNSdx11DtJX753/HnjLnG0DZnj1k9ME0
         98Dd+8WhVapFL7b0l3wCN5vpdnLehA8k0Oyy9EcEqCtC5E9JKMtOPJl7XNo4O7parpUn
         4Ssf6hFTwO7yEIcw22nMlRBYJ1u4/XKmuJqwzkz9U13br0PLzi4Qo1XCxgFZkx4+Np+j
         gdNg==
X-Forwarded-Encrypted: i=1; AJvYcCUyPBuVBDpruSoEI2Ju5QiEo4zMFZx1dExsOMI6a8Iye6GhTx6X4BR9K+an+l7b2274CYJyn515fJdlH3KWAPIIyWF4
X-Gm-Message-State: AOJu0YxM8UfEboErheOvVcQhNRGuUvfeTKKLp8fCUKoWeyRyg/3drIMW
	PzJ5XsAkVLYGeN4riQaj5erA/YhECDsCYlxDwEA6pemwsTSoF5fEZKdRH1yikc5ca28vVwXDcdH
	rkadDHmynTIyk+KAkYF9SnAMtYv0=
X-Google-Smtp-Source: AGHT+IGR6Y1hXJpQvkvbKMqxSkuSqFu+5S4rcVUdYCN8evXfFdJSQGdTiqoI3NKzK+ds0YR2PE/T7C2Y/937JYzZT08=
X-Received: by 2002:a17:90a:d246:b0:2b3:90ab:fb9 with SMTP id
 98e67ed59e1d1-2b616c0410amr4069838a91.49.1715210526792; Wed, 08 May 2024
 16:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506134458.727621-1-yatsenko@meta.com> <CAEf4BzZ+nw6iu8RO1xJutRf+qnxAotHx47bXuJuw8AT-5Z3QfQ@mail.gmail.com>
 <8ff3e0a3-faf7-4377-a4c3-8ee1aa82dd21@gmail.com>
In-Reply-To: <8ff3e0a3-faf7-4377-a4c3-8ee1aa82dd21@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 8 May 2024 16:21:54 -0700
Message-ID: <CAEf4Bzar7k4P+JE2FVrcMzaXMHd6OZwvPjf7QUm5rJWoizYXZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: introduce btf c dump sorting
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Quentin Monnet <qmo@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 4:07=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 5/7/24 22:02, Andrii Nakryiko wrote:
> > On Mon, May 6, 2024 at 6:45=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Provide a way to sort bpftool c dump output, to simplify vmlinux.h
> >> diffing and forcing more natural definitions ordering.
> >>
> >> Use `normalized` argument in bpftool CLI after `format c` for example:
> >> ```
> >> bpftool btf dump file /sys/kernel/btf/fuse format c normalized
> >> ```
> >>
> >> Definitions are sorted by their BTF kind ranks, lexicographically and
> >> typedefs are forced to go right after their base type.
> >>
> >> Type ranks
> >>
> >> Assign ranks to btf kinds (defined in function btf_type_rank) to set
> >> next order:
> >> 1. Anonymous enums
> >> 2. Anonymous enums64
> >> 3. Named enums
> >> 4. Named enums64
> >> 5. Trivial types typedefs (ints, then floats)
> >> 6. Structs
> >> 7. Unions
> >> 8. Function prototypes
> >> 9. Forward declarations
> >>
> >> Lexicographical ordering
> >>
> >> Definitions within the same BTF kind are ordered by their names.
> >> Anonymous enums are ordered by their first element.
> >>
> >> Forcing typedefs to go right after their base type
> >>
> >> To make sure that typedefs are emitted right after their base type,
> >> we build a list of type's typedefs (struct typedef_ref) and after
> >> emitting type, its typedefs are emitted as well (lexicographically)
> >>
> >> There is a small flaw in this implementation:
> >> Type dependencies are resolved by bpf lib, so when type is dumped
> >> because it is a dependency, its typedefs are not output right after it=
,
> >> as bpflib does not have the list of typedefs for a given type.
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   tools/bpf/bpftool/btf.c | 264 ++++++++++++++++++++++++++++++++++++++=
+-
> >>   1 file changed, 259 insertions(+), 5 deletions(-)
> >>

[...]

> > can we avoid all this complexity with TYPEDEFs if we just rank them
> > just like the type they are pointing to? I.e., TYPEDEF -> STRUCT is
> > just a struct, TYPEDEF -> TYPEDEF -> INT is just an INT. Emitting the
> > TYPEDEF type will force all the dependent types to be emitted, which
> > is good.
> >
> > If we also use this "pointee type"'s name as TYPEDEF's sort name, it
> > will also put it in the position where it should be, right? There
> > might be some insignificant deviations, but I think it would keep the
> > code much simpler (and either way we are striving for something that
> > more-or-less works as expected in practice, not designing some API
> > that's set in stone).
> >
> > WDYT?
> >
> I don't think this will guarantee for each type all typedefs follow
> immediately.
> For example:
>
> With this patch next output is generated:
>      typedef s64 aaa; /* aaa is the smallest first level child of s64 */
>      typedef aaa ccc; /* ccc immediately follows aaa as child */
>      typedef s64 bbb; /* bbb is first level child of s64 following aaa */
>      typedef s32 xxx; /* xxx follows bbb lexicographically */
>
> Option 2: I we apply flat sorting by rank and then name, we'll get next
> order:
>      typedef s64 aaa;
>      typedef s64 bbb;
>      typedef aaa ccc;
>      typedef s32 xxx;
>
> Here order just follows aaa - bbb - ccc - xxx. Type ccc does not immediat=
ely
> follow its parent aaa.
>
> Option3: If we use pointee name as sort name, next output is expected:
>      typedef s64 aaa; /* dependency of the next line */
>      typedef aaa ccc; /* sort name aaa */
>      typedef s32 xxx; /* sort name s32 */
>      typedef s64 bbb; /* sort name s64 */
>
> I think Option 2 will have the simplest implementation, but we are
> getting BFS
> ordering instead of DFS. I'm not entirely sure, but it looks to me, that =
we
> can't achieve DFS ordering with sort-based simple implementation, let me
> know if
> I'm missing anything here.
> If DFS ordering is not required, I'm happy to scrap it.

I'd go with Option3, but I'd resolve ccc -> aaa -> s64 as sort name
(so all the way to non-reference type), and use INT as rank for that
typedef. We'd have ordering ambiguity between `ccc -> aaa -> s64`
chain and `bbb -> s64`, to resolve that we'd need to be able to
compare entire chains, but that would require more bookkeeping. So
maybe let's remember both resolved name and "original" name (i.e., for
ccc resolved would be "s64", original is "ccc"), and if the resolved
name is the same, then compare original name. That will give the
ordering more stability. And it's just an extra u32 to keep track per
type in this extra sort_datum thingy. WDYT?

I think simple trumps whatever ideal ordering we come up with. In any
case it's going to be pretty stable and easy to diff, so I'd go with
that.

> >> +static int *sort_btf_c(const struct btf *btf)
> >> +{
> >> +       int total_root_types;
> >> +       struct sort_datum *datums;
> >> +       int *sorted_indexes =3D NULL;
> >> +       int *type_index_to_datum_index;
> > nit: most of these names are unnecessarily verbose. It's one
> > relatively straightforward function, just use shorter names "n",
> > "idxs", "idx_to_datum", stuff like this. Cooler and shorter C names
> > :))
> >
> >> +
> >> +       if (!btf)
> >> +               return sorted_indexes;
> > this would be a horrible bug if this happens, don't guard against it he=
re
> >
> >> +
> >> +       total_root_types =3D btf__type_cnt(btf);
> >> +       datums =3D malloc(sizeof(struct sort_datum) * total_root_types=
);
> >> +
> >> +       for (int i =3D 1; i < total_root_types; ++i) {
> >> +               struct sort_datum *current_datum =3D datums + i;
> >> +
> >> +               current_datum->index =3D i;
> >> +               current_datum->name =3D btf_type_sort_name(btf, i);
> >> +               current_datum->type_rank =3D btf_type_rank(btf, i, fal=
se);
> >> +               current_datum->emitted =3D false;
> > btf_dump__dump_type() keeps track of which types are already emitted,
> > you probably don't need to do this explicitly?
> I use `emitted` to indicate whether type index has been copied into outpu=
t
> `sorted_indexes` array. This is needed because type (if it is a typedef)
> can be put into output out of order by its parent base type, if base has
> been processed earlier. It helps to avoid putting the same type twice in
> the output array preventing buffer overrun.

Would this still be needed if we do this sorting only approach?

[...]

