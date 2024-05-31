Return-Path: <bpf+bounces-31061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BBB8D6928
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 20:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6825FB23958
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 18:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFAB7E0F2;
	Fri, 31 May 2024 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNp5rRX9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9E81CA89
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717181114; cv=none; b=KZzDad3cfGAuWCYoRHA4OLt6VoduI/LSxISnpBLiPF4R4hAwxfnHlhWG1amuu2qTBG1dZ4HIE5BEyBHn0xIiuGipM4cg9639R4mGeS3MLagxFm5N2XpIzSHL9mH3e+e12esnxldz6cdXEA1GT/8Q3yX281Xph1lN7UwKMdE7vJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717181114; c=relaxed/simple;
	bh=R7YNcc28ZdchUOwA4T/J7A00+pMY/6LpwLpGte3eFmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d91qZ1oWUnCX/uryG9V5GbkN2EOZfVIHz/G+0ORk0VC65j8OjTzd/mhzdiugCAYmDuQtUkP7ljTVGZN/oQwXUaHrXo1H0M8UHC69CjP1uAmul4qnrMKZtVBSZfinbdtbXUqhS+KrTLnPIjWsqLsXO86BjRXLhXKJ6iOBVUnezYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNp5rRX9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2bf59b781d6so1918900a91.0
        for <bpf@vger.kernel.org>; Fri, 31 May 2024 11:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717181112; x=1717785912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZXcS5xuRUhFzfD78hEJsNXihn1mJx+9yvt0aKP19uo=;
        b=gNp5rRX9uhDPLr2XoqW2fk69Yo77V5mqDhI8vPK9qCiMchBENrmr8YEPXhk0wFfJzh
         lo4ZPmirqFPmrPHN+ZqZdXc+Ohp5uscDCy4NQnH0+fqhVhXQhmlMAq03ZqkijH9slB5o
         2a7TvbsgxIcsxNcPJIkQfd7SjwQRr7f3Pvq2QEgBqy5SF/aRbnlCc0ODZXXKjwrPADf+
         4BVSS6a2KKMcxy701cfSmULEMUNbsqRY2iVG0m9ZvHrXztawM8LOicWJtptQASgYgkpu
         QdsZiAt9AXXohKleEMOko+rYwOF4UFc3Wh2Da4FjmshVPXmGDGnyt6MqUemaEiOshIEs
         lK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717181112; x=1717785912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZXcS5xuRUhFzfD78hEJsNXihn1mJx+9yvt0aKP19uo=;
        b=NBT8QELpoR+wj+aHJWRh1KoEYPzSKQEytEq15OEHPzubvpR9nOFjPtVtYGwAVUiYl7
         WfW45Jz0eRGI67aF4Hy24d7qaBBnWmxXPfH8cdissr0G6wA0J60+08qLfe0IPhMBpW3v
         NuRkhCaxkyUg7z0Hp7dwOaO8HRsUZ4N2nQkQ/4PG4eO+oYAY8Ex8blndPatiJ73FZrM/
         txiuyNRVwdLoQhAKm0UlYRaOoAD+D/8FRSBE7uM9t3mg0wAnJRyQB20mPZj1GOHopKSk
         fSOA4kM05m7DlX3uV16PSwjBBxNUqcUeRrQyUPJGkeOvKEuXzlrIoj83S4BXnKCn8stQ
         iGng==
X-Forwarded-Encrypted: i=1; AJvYcCX2wT9Fmv6TX+xSLRVRkcncRiu8jAzMgUcg3CD/ooeYSMCJxtZJ9ae4GVcpnW44XQSLqapnktiGIcIdX5gzyJj3Zs2V
X-Gm-Message-State: AOJu0YydXLwpQPE2JaG7OmwpA/rkba6t5QzVVvwo4B35hqnbWB/5HPoe
	g0bvy7oovNqFqYenyqWNuZ457jL7ogIMTXEVGo9wxHcFI+irgBiwlV86u3coR7qw239h1lnR6rN
	MlFys1NsM/Z2RHMX4J5/Kd+NaaSdMEyMI
X-Google-Smtp-Source: AGHT+IEOeLydWJ7rqr4+r1EuA5EsXOzD+jw9D1vZ7hL5vSIiDEJy5VwC9/tYB5kBNRN5xDwZbbw/1X9fFEkLuE/02mM=
X-Received: by 2002:a17:90a:df96:b0:2be:b9:da18 with SMTP id
 98e67ed59e1d1-2c1dc560b85mr2551590a91.2.1717181111885; Fri, 31 May 2024
 11:45:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528122408.3154936-1-alan.maguire@oracle.com>
 <20240528122408.3154936-4-alan.maguire@oracle.com> <7da6ec1c366bb7b5461b10eeaaa75945b74815be.camel@gmail.com>
 <843d8e77-080c-4211-b7c7-dd6918bef901@oracle.com>
In-Reply-To: <843d8e77-080c-4211-b7c7-dd6918bef901@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 31 May 2024 11:44:59 -0700
Message-ID: <CAEf4BzYM316rV6iCgicqsu_xL8824F1yMCM3Bn1eOJDmbaM_aw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 3/9] libbpf: split BTF relocation
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 8:39=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 31/05/2024 03:22, Eduard Zingerman wrote:
> > On Tue, 2024-05-28 at 13:24 +0100, Alan Maguire wrote:
> >
> > [...]
> >
> >> +/* Build a map from distilled base BTF ids to base BTF ids. To do so,=
 iterate
> >> + * through base BTF looking up distilled type (using binary search) e=
quivalents.
> >> + */
> >> +static int btf_relocate_map_distilled_base(struct btf_relocate *r)
> >> +{
> >
> > I have several observations about this algorithm.
> >
> > The algorithm does Base.Cnt * log2(Dist.Cnt) binary searches.
> > However, it might be better to switch searches around
> > and look for distilled {name,size} pairs in base btf,
> > doing Dist.Cnt * log2(Base.cnt) searches instead.
> > Suppose Base.Cnt =3D 2**20 and Dist.Cnt =3D 2**10, in such case:
> >   - Base.Cnt * log2(Dist.Cnt) =3D 2**20 * 10
> >   - Dist.Cnt * log2(Base.cnt) =3D 2**10 * 20, which is smaller
> >
>
> Hi Eduard,
>
> I crunched some numbers on base, distilled base BTF to try and flesh
> this out a bit more.
>

Wow, you guys really went hardcore here with counting...

Eduard, as Alan mentioned, you ignored both CPU and *memory*
requirements for sorting a large base number of types. If N is base
type count, M is distilled type count (note, M << N), then

  - with Alan's current approach we have
    - O(MlogM + N*logM) =3D O((M+N)logM) for sorting/search
    - O(M) memory for index

  - with your proposal
    - O(NlogN + M*logN) =3D O((M+N)logN) for sorting/search
    - O(N) memory for index.

Just on memory usage it's clear that the current approach wins
significantly and is the reason enough to prefer it. But even on
overall CPU usage we have (N+M)logM < (N+M)logN, which
(asymptotically) is still better.

But I think the memory argument in this case wins, we should avoid
allocating 1MB of extra memory to shave off 1ms (if at all) of kernel
load time, IMO.

[...]

>
> So the overall relocation time - from 11 distilled types in hid_ite to
> 610 for cxgb4 - is within a range from 4.5msec (4432193ns above) to
> 8msec. The times for relocation represent less than 50% of overall
> module load times - the later vary from 11-18msec across these modules.
> It would be great to find some performance wins here, but I don't
> _think_ swapping the sort/search targets will buy us much unfortunately.
>

As long as it's NlogN-ish (mix N/M here), I think it's fine. It's
O(N*M) that would be horrible.

> > The algorithm might not handle name duplicates in the distilled BTF wel=
l,
> > e.g. in theory, the following is a valid C code
> >
> >   struct foo { int f; }; // sizeof(struct foo) =3D=3D 4
> >   typedef int foo;       // sizeof(foo) =3D=3D 4
> >

I think only typedef has its own "namespace", right? And typedefs are
not in distilled base. All other types share the same name (so at
least we don't have to support two separate namespaces).

But you are right, it's C, and across multiple compile units one can
technically have two different kinds with the same name co-existing
overall in vmlinux BTF.

But instead of doing bsearch_unique(), I propose we implement
lower-bound-like binary search, which will find the first instance of
a given name, and then we iterate linearly across all duplicates,
ignoring incompatible kinds. If we do find two possible matches (when
taking size/kind into account), then we should error out due to
ambiguity.

Alan, please see find_linfo() in kernel/bpf/log.c. You basically need
exactly that implementation, except you'd be using strcmp() <=3D 0
condition to find the index. After that just iterate starting from
that index and do strcmp() =3D=3D 0, marking all matches. Check number of
matches (0 -- bad, 1 -- great, >1 -- bad).

Eduard, Alan, makes sense or did I miss anything?

> > Suppose that these types are a part of the distilled BTF.
> > Depending on which one would end up first in 'dist_base_info_sorted'
> > bsearch might fail to find one or the other.
> >
>
> In the case of distilled base BTF, only struct, union, enum, enum64,
> int, float and fwd can be present. Size matches would have to be between
> one of these kinds I think, but are still possible nevertheless.
>

+1

> > Also, algorithm does not report an error if there are several
> > types with the same name and size in the base BTF.
> >
>

[...]

>
>
> struct elf_thread_core_info;
>
> struct elf_note_info {
>         struct elf_thread_core_info *thread;
>         struct memelfnote psinfo;
>         struct memelfnote signote;
>         struct memelfnote auxv;
>         struct memelfnote files;
>         siginfo_t csigdata;
>         size_t size;
>         int thread_notes;
> };
>
> struct elf_thread_core_info___2;
>
> struct elf_note_info___2 {
>         struct elf_thread_core_info___2 *thread;
>         struct memelfnote psinfo;
>         struct memelfnote signote;
>         struct memelfnote auxv;
>         struct memelfnote files;
>         compat_siginfo_t csigdata;
>         size_t size;
>         int thread_notes;
> };
>
> Both of these share self-reference, either directly or indirectly so
> maybe it's a corner-case of dedup we're missing. I'll dig into these late=
r.

I think it's some differing type deeper in the
elf_thread_core_info/elf_thread_core_info___2 (and note that this is
not a self-reference, it's a different type).

I don't think it's a bug in dedup algo, this is a known case due to
some type that is supposed to be equivalent actually not being such.

>
> > I suggest to modify the algorithm as follows:
> > - let 'base_info_sorted' be a set of tuples {kind,name,size,id}
> >   corresponding to the base BTF, sorted by kind, name and size;
>
> That was my first thought, but we can't always search by kind; for
> example it's possible the distilled base has a fwd and vmlinux only has
> a struct kind for the same type name; in such a case we'd want to
> support a match provided the fwd's kflag indicated a struct fwd.

yep, makes sense (though highly unlikely)

>
> In fact looking at the code we're missing logic for the opposite
> condition (fwd only in base, struct in distilled base). I'll fix that.

I'd error out on this, this looks like a weird nonsensical case (but
technically can happen with BTF, of course).

>
> The other case is an enum in distilled base matching an enum64
> or an enum.

I mentioned that in a previous email, we should just ignore the enum
vs enum64 difference as long as their size matches.

>
> > - add a custom utility bsearch_unique, that behaves like bsearch,
> >   but returns NULL if entry is non-unique with regards to current
> >   predicate (e.g. use bsearch but also check neighbors);
> > - for each type D in the distilled base:
> >   - use bsearch_unique to find entry E in 'base_info_sorted'
> >     that matches D.{kind,name,size} sub-tuple;
> >   - if E exists, set id_map[D] :=3D E.id;
> >   - if E does not exist:
> >     - if id_map[D] =3D=3D BTF_IS_EMBEDDED, report an error;
> >     - if id_map[D] !=3D BTF_IS_EMBEDDED:
> >       - use bsearch_unique to find entry E in 'base_info_sorted'
> >         that matches D.{kind,name} sub-tuple;
> >       - if E exists, set id_map[D] :=3D E.id;
> >       - otherwise, report an error.
> >
> > This allows to:
> > - flip the search order, potentially gaining some speed;
> > - drop the 'base_name_cnt' array and logic;
> > - handle the above hypothetical name conflict example.
> >
>
> I think flipping the search order could gain search speed, but only at
> the expense of slowing things down overall due to the extra cost of
> having to sort so many more elements. I suspect it will mostly be a
> wash, though numbers above seem to suggest sorting distilled base may
> have an edge when we consider both search and sort. The question is
> probably which sort/search order is most amenable to handling the data
> and helping us deal with the edge cases like duplicates.
>
> With the existing scheme, I think catching cases of name duplicates in
> distilled base BTF and name/size duplicates in base BTF for types we
> want to relocate from distilled base BTF and erroring out would suffice;
> basically the following applied to this patch (patch 3 in the series)
>
> diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
> index f2e91cdfb5cc..4e282ee8f183 100644
> --- a/tools/lib/bpf/btf_relocate.c
> +++ b/tools/lib/bpf/btf_relocate.c
> @@ -113,6 +113,7 @@ static int btf_relocate_map_distilled_base(struct
> btf_relocate *r)
>  {
>         struct btf_name_info *dist_base_info_sorted;
>         struct btf_type *base_t, *dist_t, *split_t;
> +       const char *last_name =3D NULL;
>         __u8 *base_name_cnt =3D NULL;
>         int err =3D 0;
>         __u32 id;
> @@ -136,6 +137,19 @@ static int btf_relocate_map_distilled_base(struct
> btf_relocate *r)
>         qsort(dist_base_info_sorted, r->nr_dist_base_types,
> sizeof(*dist_base_info_sorted),
>               cmp_btf_name_size);
>
> +       /* It is possible - though highly unlikely - that
> duplicate-named types
> +        * end up in distilled based BTF; error out if this is the case.
> +        */
> +       for (id =3D 1; id < r->nr_dist_base_types; id++) {
> +               if (last_name =3D=3D dist_base_info_sorted[id].name) {

technically this a) has to take into account kind and b) even with the
same kind is legal

On some older kernel version we'd have that with ring_buffer, for
example. There were two completely independent struct ring_buffer
types.

I thought we would do all the relocation-time size check shenanigans
to resolve all this. I might have missed some nuance, though.

> +                       pr_warn("Multiple distilled base types [%u],
> [%u] share name '%s'; cannot relocate with base BTF.\n",
> +                               id - 1, id, last_name);
> +                       err =3D -EINVAL;
> +                       goto done;
> +               }
> +               last_name =3D dist_base_info_sorted[id].name;
> +       }
> +

[...]

> > Wdyt?
> >
>
> My personal take is that it would suffice to error out in some of the
> edge cases, but I'm open to other approaches too. Hopefully some of the
> data above helps us understand the costs of this approach at least. Thank=
s!
>

I wouldn't change the overall relocation algorithm, but better
detection of ambiguities and reporting would definitely be useful.

> Alan
>
> [1] https://github.com/oracle/dtrace-utils
>
> >> +    struct btf_name_info *dist_base_info_sorted;
> >> +    struct btf_type *base_t, *dist_t, *split_t;
> >> +    __u8 *base_name_cnt =3D NULL;
> >> +    int err =3D 0;
> >> +    __u32 id;
> >> +

[...]

Please try to trim larger chunks of code/discussion that are not
relevant anymore.

