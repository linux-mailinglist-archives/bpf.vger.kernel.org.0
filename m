Return-Path: <bpf+bounces-75844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0674FC99744
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 23:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 529EC3435FC
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 22:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CCD2882B2;
	Mon,  1 Dec 2025 22:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4gml9IV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847F9287268
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 22:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629720; cv=none; b=Z283gDNNFMOVosjCzqFzuHg98FY0pFfjEWj0Lx5sHIlP1V842L3YHxWChrbvrmfUxjFx/5H26zUMkHbK6ZTHcNX9lgBjTIWmPFEY2MDjxKCgSDDY3RsneOA3yfuu8MTn3WF8GHS3Ve3D1RcDOIMdVkBqA0xHXmp2cBz+gCqjJZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629720; c=relaxed/simple;
	bh=HwNquq7SV5NMtRUJ+wo7BsQT4sO68o+idkpf3nWzIqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umMFguef758KLUxeuJpoNmu8Fyxc3eUPozlEBYhXC537fAYzxq34UY5ozkd+cUchyBpxArxIUA6Rm/drW67O2b7mvhBug4+M/oIPzwgMUZEnlwUyXvZdAcUaY2PQhzpfmkRXxGVmC31KkC2h9pL9nhuFhLH+zrblrVivY6xCMx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4gml9IV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-298144fb9bcso47037085ad.0
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 14:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764629718; x=1765234518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3bg2WOkLoWG2atLwWkBEDRTRImwryuSczkORkA7j+I=;
        b=W4gml9IVJUJiqlV1iAlJPRp/Pnon7grMfUM/C87Ha6/VfMn2/juc4l7P+DTW0TmsTH
         QSTADkLLgrAoWvHUoEPFVsvFdHAoNneU/GsmNSX+Q4PjsjRP9vwyyG5TMBZmqRoT7Smm
         1fcU40iT/W1MdhaZrMJRJ/POYvobrl1IhAkPUMpwhVJ2cLYZB+KtBdFWRaRHn6j+bOpS
         fj/dz0JMQw3im604mMwZA4KTp2XcpJxEREylk7OQMNpbiFl6IgtehHvrwrrxa96sznKr
         M6+0ugu+HlU7JeTRC1Vco8RFYts5iilAoUQIJ0CPCbDTt7hhpFlQN35YQIV7oK0Vga+A
         Pr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764629718; x=1765234518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q3bg2WOkLoWG2atLwWkBEDRTRImwryuSczkORkA7j+I=;
        b=Ufhr40WFsjPsHEFm09zACB6bdfsdwiHPhgFTK7b79fMt7Jy5crxsTqZyRyn8oW6Jpt
         VbhFxAXxqx+8cOw1XEyiGhn4Mfpjsgin/tyGoh7RS7IH6NF0hQQwljHk5JQ+ekcu5AjU
         +N73XT2kx5fKuwfglEJkBkyDwlXAL4weaK5O6S4FTPq7SQ+FAXLUsubGmkJ8Z5FyQv7t
         WEaTcjQyV0n6NTjm4aWgzARlt7Sh/EC9Cr8ip6jdlh9s/YJ45bEs/J5H+Vncjk+ivYhB
         oxCskcOU/0HN8+ev34Gytju4qvEuYUgJtD03eboW18r4LWNUFK2xXGbBI9c4OIMU18lU
         K7QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRAQwXMrg33XWJtp7cgLdDPM9VaufFHBNFPkyJmxj5NOrvPnwT7xvYQor+V+XyLdwgPi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkzm2LL40I+a9P/ujVmoU8ziHZEyxV+T7OeGLLmce7FqVEFu52
	pjrW8WAAbmdtj0K+r2Zm9fgFqCXg85MV8HI5DgrLc3xZL/zOKKwKm3vx53l8mBFurK7z0nfinR9
	yO3ADMm0vNr/83ZsW2MYtuuxLWhj6Ldk=
X-Gm-Gg: ASbGncutbAoX9Tvmjfu+z6AY8cfoWDeuoI0kF9ygFHipjUyZ1q3FymVwJ93a8uOrpvg
	yS8bkfHMiIVZtJTEIDUdFfV975NJv+Pvh3P9L02pOBmsuAHHPgyx09/zIGVXiwo0NWL0lYoVBAf
	zL3Np23jwdaD8mtuSiUoVaeBgQgnVlWFwkwGad+xuKWhFcCy8VUt+6zJVZb/kCouscyRZvaNP7a
	IR3qScAdVYMjRpqOVHZj8YzfFQrmYVeXEwuYPIYMWVlRVQORAhopGxcWq/2WP5sS6/PWA/ERqMj
	E1vKJcliXhs=
X-Google-Smtp-Source: AGHT+IHrCBzcziOVvQf63cGtcrHI8gYDJvZzhwG0bZktE8khOW88tmclb9VBMu25R7j47pXgQ1T+HM7lGdg7CIKfNAY=
X-Received: by 2002:a17:90b:4a88:b0:340:2f48:b51a with SMTP id
 98e67ed59e1d1-3475ec0dc4fmr29588284a91.15.1764629717771; Mon, 01 Dec 2025
 14:55:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120224256.51313-1-alan.maguire@oracle.com>
 <CAEf4BzaDx52argxexyaG3AbvsfQzjmftqrT=xWNuRqfvORM9-Q@mail.gmail.com> <a4199316-fe85-4145-b69c-f97e881ebbcc@oracle.com>
In-Reply-To: <a4199316-fe85-4145-b69c-f97e881ebbcc@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Dec 2025 14:55:05 -0800
X-Gm-Features: AWmQ_bkrFH3QZvjkPLHE4KZtcqgQMmOIW9qYgn2OzalKnxxobocqgK9QGe4I1K4
Message-ID: <CAEf4BzbPL7T2ZzvHMD2iwhMS87GE1uCGL3H43MHktqcN2Cf_6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add debug messaging in dedup
 equivalence/identity matching
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 2:26=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 25/11/2025 23:00, Andrii Nakryiko wrote:
> > On Thu, Nov 20, 2025 at 2:43=E2=80=AFPM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> We have seen a number of issues like [1]; failures to deduplicate
> >> key kernel data structures like task_struct.  These are often hard
> >> to debug from pahole even with verbose output, especially when
> >> identity/equivalence checks fail deep in a nested struct comparison.
> >>
> >> Here we add debug messages of the form
> >>
> >> libbpf: struct 'task_struct' (size 2560 vlen 194) appears equivalent b=
ut differs for 23-indexed cand/canon member 'sched_class'/'sched_class': 0
> >>
> >> These will be emitted during dedup from pahole when --verbose/-V
> >> is specified.  This greatly helps identify exactly where dedup
> >> failures are experienced.
> >>
> >> [1] https://lore.kernel.org/bpf/b8e8b560-bce5-414b-846d-0da6d22a9983@o=
racle.com/
> >>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  tools/lib/bpf/btf.c | 36 +++++++++++++++++++++++++++++++-----
> >>  1 file changed, 31 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> >> index 84a4b0abc8be..c220ba1fbcab 100644
> >> --- a/tools/lib/bpf/btf.c
> >> +++ b/tools/lib/bpf/btf.c
> >> @@ -4431,11 +4431,14 @@ static bool btf_dedup_identical_types(struct b=
tf_dedup *d, __u32 id1, __u32 id2,
> >>         struct btf_type *t1, *t2;
> >>         int k1, k2;
> >>  recur:
> >> -       if (depth <=3D 0)
> >> -               return false;
> >> -
> >>         t1 =3D btf_type_by_id(d->btf, id1);
> >>         t2 =3D btf_type_by_id(d->btf, id2);
> >> +       if (depth <=3D 0) {
> >> +               pr_debug("Reached depth limit for identical type compa=
rison for '%s'/'%s'\n",
> >> +                        btf__name_by_offset(d->btf, t1->name_off),
> >> +                        btf__name_by_offset(d->btf, t2->name_off));
> >> +               return false;
> >> +       }
> >>
> >>         k1 =3D btf_kind(t1);
> >>         k2 =3D btf_kind(t2);
> >> @@ -4497,8 +4500,18 @@ static bool btf_dedup_identical_types(struct bt=
f_dedup *d, __u32 id1, __u32 id2,
> >>                 for (i =3D 0, n =3D btf_vlen(t1); i < n; i++, m1++, m2=
++) {
> >>                         if (m1->type =3D=3D m2->type)
> >>                                 continue;
> >> -                       if (!btf_dedup_identical_types(d, m1->type, m2=
->type, depth - 1))
> >> +                       if (!btf_dedup_identical_types(d, m1->type, m2=
->type, depth - 1)) {
> >> +                               /* provide debug message for named typ=
es. */
> >> +                               if (t1->name_off) {
> >> +                                       pr_debug("%s '%s' (size %d vle=
n %d) appears equal but differs for %d-indexed members '%s'/'%s'\n",
> >
> > Honestly, reading this message in the commit description above I was a
> > bit confused about what it actually means... "appears equal" refers to
> > shallow equality check passing, right? Given this is for debugging,
> > just use consistent terminology here, maybe? It's for you, me, Eduard,
> > Ihor, maybe a few more people, so we don't have to invent UX-friendly
> > allegories here :) Just say "are shallow-equal" or something like
> > that, maybe? As for "%d-indexed", IMO, "field #%d" would be
> > unambiguous.
> >
> >  Also, I saw you reply to Eduard, but I still think that if I were to
> > debug this I'd like to know original type IDs of structs involved to
> > be able to look at raw BTF dump and dive deeper? We have consistent
> > "[%u] %s" pattern for referring to BTF types, let's use that here to
> > identify two structs/unions involved?
> >
>
> Sure; how about this format:
>
> libbpf: STRUCT 'task_struct' size=3D2560 vlen=3D194 cand_id[54222]
> canon_id[102820] shallow-equal but not equiv for field#23 'sched_class': =
0
>

lgtm

>
> > Also, is size/vlen really useful? I bet you'd still be looking at raw
> > BTF output to check details about the struct/union, and there the
> > size/vlen is readily available. Just curious if it's really that
> > useful to have it here.
> >
>
> In the above form we can basically take the
>
> STRUCT 'task_struct' size=3D2560 vlen=3D194
>
> and grep for those details. Useful if we have name-conflicted types. In
> a dedup failure we could potentially have such ambiguites where CUs have
> different views of structs with different fields compiled in, so while I
> didn't strictly need it this time I suspect it will be helpful in
> clarifying exactly which object we're talking about.
>

ok

>
>
> > pw-bot: cr
> >
> >
> >> +                                                k1 =3D=3D BTF_KIND_ST=
RUCT ? "struct" : "union",
> >> +                                                btf__name_by_offset(d=
->btf, t1->name_off),
> >> +                                                t1->size, btf_vlen(t1=
), i,
> >> +                                                btf__name_by_offset(d=
->btf, m1->name_off),
> >> +                                                btf__name_by_offset(d=
->btf, m2->name_off));
> >
> > field names will be identical, guaranteed by shallow-equal check, why
> > logging twice?
>
> yep, good point, will remove.
>
> >
> >> +                               }
> >>                                 return false;
> >> +                       }
> >>                 }
> >>                 return true;
> >>         }
> >> @@ -4739,8 +4752,21 @@ static int btf_dedup_is_equiv(struct btf_dedup =
*d, __u32 cand_id,
> >>                 canon_m =3D btf_members(canon_type);
> >>                 for (i =3D 0; i < vlen; i++) {
> >>                         eq =3D btf_dedup_is_equiv(d, cand_m->type, can=
on_m->type);
> >> -                       if (eq <=3D 0)
> >> +                       if (eq <=3D 0) {
> >> +                               /* provide debug message for named typ=
es only;
> >
> > please use more "canonical" comment style
> >
> >> +                                * too many anon struct/unions match.
> >> +                                */
> >> +                               if (cand_type->name_off) {
> >> +                                       pr_debug("%s '%s' (size %d vle=
n %d) appears equivalent but differs for %d-indexed cand/canon member '%s'/=
'%s': %d\n",
> >> +                                                cand_kind =3D=3D BTF_=
KIND_STRUCT ? "struct" : "union",
> >> +                                                btf__name_by_offset(d=
->btf, cand_type->name_off),
> >> +                                                vlen, cand_type->size=
, i,
> >> +                                                btf__name_by_offset(d=
->btf, cand_m->name_off),
> >> +                                                btf__name_by_offset(d=
->btf, canon_m->name_off),
> >
> > same question about field names, can they be different here ever?
> >
>
> My read of shallow equality means name equivalence is guaranteed; will
> remove.
>
> Will send a v2 if the above proposed format looks good. Thanks!
>
> Alan

