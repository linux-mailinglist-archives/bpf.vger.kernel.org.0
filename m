Return-Path: <bpf+bounces-15589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 573FA7F36EE
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 20:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718EA1C20D27
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 19:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71C04205F;
	Tue, 21 Nov 2023 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcZVgW98"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1048219B
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 11:50:07 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-33139ecdca7so3605159f8f.0
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 11:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700596205; x=1701201005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zg4v9mhW9i0AZKE0+N9Mrqy2Elax74YgikUIIda3cWo=;
        b=LcZVgW98xaDbuOTrtp5zW9p8ANiUIdKqqC7t9Jlk+AjwN5aeEpvGOIwYuLP26SKUjw
         s3pZ1cwrdeXh9El8/9caFqedUkm6BhJ4mfJsV5hwZBGV4N4wRNi00lu2KsLDWxQEjapH
         9nZ30b3BEfTACqFACNE/RxpWq9fMrU0BQUUnFio5ofqcU52clrFvT8b432yAN+T6QcBY
         19FPV4U+FaahCmARjI2TNGnZTvah6IE/3EAshGW97bNXo22+8ZUVr94ZoqE9QZmBEFiX
         extUHFwuuL5wfl6FmwW2RK46ioBkW8ttcic5A7kpGQC5k3K0y99L07zV54Qe4UImyg4o
         KHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700596205; x=1701201005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zg4v9mhW9i0AZKE0+N9Mrqy2Elax74YgikUIIda3cWo=;
        b=rm3IH2hOj25R9HgDERds5RCG/CeTD0zuL0b5vfcDs4kjukgkTBfHKHIz5JadNmrhJe
         QoTPkPwJ8W28O9QFioGwq7N1DSv13KIHfjpV2g2E61dzqc6HKTYND3l+zXSCPOv7adco
         kaHdTvZlFWzz2dQ8eDlwbG5QvfHlctexeGqtCRajiOuPVHi8gljCsi4vsv0MpILhjz5O
         Mi5f4O/pBuvVfh8nSTkHk8qqTM5xiEO47144xh1TNw9dSddn31pVFsLavdOG3gAlXHW3
         1wKymYUMRqzqSvArJsebo7rMS88QcHRi1FyhGuZeGERZoBSsw8/hm9zkPJieJnYcjTEg
         09Cg==
X-Gm-Message-State: AOJu0YyctRbYA5YUqtX3oxt+OKp2jfhIvqsN4CJO63WOjNiGlGCzsA4Z
	bmITtfB8pC9sAEX62CHd4dpOSg4tPzoPLit9SGjlgtfg
X-Google-Smtp-Source: AGHT+IG1K6k5EJ1pKJKjD6CLUSKi+IkQUmlg8+fkNZzfHjGS7audcRsW93Qn2fCeAlPs3ugTmUDaZ8fRibeEHIAuOVY=
X-Received: by 2002:a5d:588e:0:b0:332:cae1:db4 with SMTP id
 n14-20020a5d588e000000b00332cae10db4mr22010wrf.52.1700596204726; Tue, 21 Nov
 2023 11:50:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120175925.733167-1-davemarchevsky@fb.com>
 <20231120175925.733167-2-davemarchevsky@fb.com> <9b037dde-e65c-4d1a-8295-68d51ac3ce25@linux.dev>
 <3dd86df3-0692-42d8-b075-f79c5dc052be@linux.dev> <f4d7f72d-1ba2-49dc-b4e0-03289393d436@linux.dev>
In-Reply-To: <f4d7f72d-1ba2-49dc-b4e0-03289393d436@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Nov 2023 11:49:53 -0800
Message-ID: <CAADnVQK6c8chC1E6_O8bncncBuiscdFrKk6EgPbBC_WyVoj=9w@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 1/2] bpf: Support BPF_F_MMAPABLE task_local storage
To: Martin KaFai Lau <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>
Cc: David Marchevsky <david.marchevsky@linux.dev>, Dave Marchevsky <davemarchevsky@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 11:27=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 11/20/23 10:11 PM, David Marchevsky wrote:
> >
> >
> > On 11/20/23 7:42 PM, Martin KaFai Lau wrote:
> >> On 11/20/23 9:59 AM, Dave Marchevsky wrote:
> >>> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_lo=
cal_storage.h
> >>> index 173ec7f43ed1..114973f925ea 100644
> >>> --- a/include/linux/bpf_local_storage.h
> >>> +++ b/include/linux/bpf_local_storage.h
> >>> @@ -69,7 +69,17 @@ struct bpf_local_storage_data {
> >>>         * the number of cachelines accessed during the cache hit case=
.
> >>>         */
> >>>        struct bpf_local_storage_map __rcu *smap;
> >>> -    u8 data[] __aligned(8);
> >>> +    /* Need to duplicate smap's map_flags as smap may be gone when
> >>> +     * it's time to free bpf_local_storage_data
> >>> +     */
> >>> +    u64 smap_map_flags;
> >>> +    /* If BPF_F_MMAPABLE, this is a void * to separately-alloc'd dat=
a
> >>> +     * Otherwise the actual mapval data lives here
> >>> +     */
> >>> +    union {
> >>> +        DECLARE_FLEX_ARRAY(u8, data) __aligned(8);
> >>> +        void *actual_data __aligned(8);
> >>
> >> The pages (that can be mmap'ed later) feel like a specific kind of kpt=
r.
> >>
> >> Have you thought about allowing a kptr (pointing to some pages that ca=
n be mmap'ed later) to be stored as one of the members of the map's value a=
s a kptr. bpf_local_storage_map is one of the maps that supports kptr.
> >>
> >> struct normal_and_mmap_value {
> >>      int some_int;
> >>      int __percpu_kptr *some_cnts;
> >>
> >>      struct bpf_mmap_page __kptr *some_stats;
> >> };
> >>
> >> struct mmap_only_value {
> >>      struct bpf_mmap_page __kptr *some_stats;
> >> };
> >>
> >> [ ... ]
> >>
> >
> > This is an intriguing idea. For conciseness I'll call this specific
> > kind of kptr 'mmapable kptrs' for the rest of this message. Below is
> > more of a brainstorming dump than a cohesive response, separate trains
> > of thought are separated by two newlines.
>
> Thanks for bearing with me while some ideas could be crazy. I am trying t=
o see
> how this would look like for other local storage, sk and inode. Allocatin=
g a
> page for each sk will not be nice for server with half a million sk(s). e=
.g.
> half a million sk(s) sharing a few bandwidth policies or a few tuning
> parameters. Creating something mmap'able to the user space and also shara=
ble
> among many sk(s) will be useful.
>
> >
> >
> > My initial thought upon seeing struct normal_and_mmap_value was to note
> > that we currently don't support mmaping for map_value types with _any_
> > special fields ('special' as determined by btf_parse_fields). But IIUC
> > you're actually talking about exposing the some_stats pointee memory vi=
a
> > mmap, not the containing struct with kptr fields. That is, for maps tha=
t
> > support these kptrs, mmap()ing a map with value type struct
> > normal_and_mmap_value would return the some_stats pointer value, and
> > likely initialize the pointer similarly to BPF_LOCAL_STORAGE_GET_F_CREA=
TE
> > logic in this patch. We'd only be able to support one such mmapable kpt=
r
> > field per mapval type, but that isn't a dealbreaker.
> >
> > Some maps, like task_storage, would only support mmap() on a map_value
> > with mmapable kptr field, as mmap()ing the mapval itself doesn't make
> > sense or is unsafe. Seems like arraymap would do the opposite, only
>
> Changing direction a bit since arraymap is brought up. :)
>
> arraymap supports BPF_F_MMAPABLE. If the local storage map's value can st=
ore an
> arraymap as kptr, the bpf prog should be able to access it as a map. More=
 like
> the current map-in-map setup. The arraymap can be used as regular map in =
the
> user space also (like pinning). It may need some btf plumbing to tell the=
 value
> type of the arrayamp to the verifier.
>
> The syscall bpf_map_update_elem(task_storage_map_fd, &task_pidfd, &value,=
 flags)
> can be used where the value->array_mmap initialized as an arraymap_fd. Th=
is will
> limit the arraymap kptr update only from the syscall side which seems to =
be your
> usecase also? Allocating the arraymap from the bpf prog side needs some t=
houghts
> and need a whitelist.
>
> The same goes for the syscall bpf_map_lookup_elem(task_storage_map_fd,
> &task_pidfd, &value). The kernel can return a fd in value->array_mmap. Ma=
y be we
> can create a libbpf helper to free the fd(s) resources held in the looked=
-up
> value by using the value's btf.
>
> The bpf_local_storage_map side probably does not need to support mmap() t=
hen.

Martin,
that's an interesting idea!
I kinda like it and I think it's worth exploring further.

I think the main quirk of the proposed mmap-of-task-local-storage
is using 'current' task as an implicit 'key' in task local storage map.
It fits here, but I'm not sure it addresses sched-ext use case.

Tejun, David,
could you please chime in ?
Do you think mmap(..., task_local_storage_map_fd, ...)
that returns a page that belongs to current task only is enough ?

If not we need to think through how to mmap local storage of other
tasks. One proposal was to use pgoff to carry the key somehow
like io-uring does, but if we want to generalize that the pgoff approach
falls apart if we want __mmapable_kptr to work like Martin is proposing abo=
ve,
since the key will not fit in 64-bit of pgoff.

Maybe we need an office hours slot to discuss. This looks to be a big
topic. Not sure we can converge over email.
Just getting everyone on the same page will take a lot of email reading.

