Return-Path: <bpf+bounces-22113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E75857182
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 00:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1021F22C44
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 23:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514C514533E;
	Thu, 15 Feb 2024 23:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2d633XX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ABF13475C
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708039375; cv=none; b=sMqgtTXjpRcnS3qXT4DmJ1frRk0Z4WVDp5KpRQfahtNrWY1txwFufQE5ZOzG3KubZg2mlLZke7SXnkKP0uxxb1rPGMoYYu1RHWo6f7ZY7XIf+FhQ+0bl3Pt8uqwfgth4vjtVwClwaY8CJDSSIHlW2/SZkyfmNTVC7A39O2fplus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708039375; c=relaxed/simple;
	bh=mB5kn7I4UBtF0dcQ3W03DGjuiBV1784/LoN/GqKkIAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0SLvy7IqVUBovH39/u++3QaGeg68M9H0azbEtsi7ATnpDY+2oRJlxdl5LwkiYT0+J81L+5nt2wivsP3EdRarkvGPj6aN9nn899LGRXY9fywLtyJcRe/B/0aAWcU4wk4WMIQETDxsmHcbeRa6+++Bz23C2YnNq/nKMoC1L29Hgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2d633XX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d7881b1843so12901475ad.3
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 15:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708039373; x=1708644173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dLceug3cfLK49yZ37XrnumvhkZ2gDGZaKc3SJd7xT0=;
        b=H2d633XXUHNmgyfyEGsBHJqj6R/wJSrRcGTRrM/uiwmwE+mhKJROr4T7HW+lV5emvq
         /MByI64lZuTb6yOUnOIOYDOTTOWTUvVkg7J27suBu+3o20EzM/1Mb8GRC6VXYZmbVLWY
         BrOHum3ajcQfBWVXZv5pXEXxh9LrGhHtQRuTLtYrjX5lu4blaG7CmQg55KbpvUX6GLu1
         qaCZW7oeCNSTErj2y3blyn/XXMGEZ2CF8H+DMpdw7ox+BecZUzZicOTJH+sH5AgnCbpB
         VII7KYhybn3rHTQG8nVi3f32SE5fczjEVGxbcqy1B+3UG0/f+LcPEokNel20wnXwSO4v
         uWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708039373; x=1708644173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dLceug3cfLK49yZ37XrnumvhkZ2gDGZaKc3SJd7xT0=;
        b=C2LBYEfsgf3XS8mpgg+/fTqDuiTlVZElLsSw2Kv9i9vVPJiwQKlznQ57IWTRqlxuar
         +Kho1MzoPhZT9o/izRh/3RUFx80VnRsGfOqk+W2yWgQvje19VCEGKCuTCW3wP/JHIlX+
         fJG7YP7yQesTXRPaDoedOTr/wOnSIbIFaHFb3ssLo1RHdOL492MJ7LpMn2dMKEDGH8XN
         KUO0Xf/dN877OCyETrq4ofCh1ob8WNq2+Og/dZCCrtkJZEgqm/aFHCN4Q9JmgfZCInrO
         fExlf+YopKazJRAgQeF5QkxyWIRFvErlpMQZIF8MLv01LkemBWQmBkwrP1Fn55xYZFP+
         d+sg==
X-Forwarded-Encrypted: i=1; AJvYcCW2xCj7QgnjmDhbBB1bLHwMsc3p4QK3EYS0HbGmMB/lbZrzil/Jy7Xw4pFcdJIqIh1LoTbW3r+rtENC5n2A07xICCDo
X-Gm-Message-State: AOJu0YwGTXm9cfmbB75RaMQqYEohssZU6Mp4eqcLPKlGb2wHB5ECEeFf
	5Yi6y+i4Ezpd1Bu08ao/U8KRJv0PBAsD1z+2VVM4CBhEDzxUi3tB68ffCciebdDYONebZMQ1maI
	xBj3c1paEl9ox0VeE66uzOPfmZp8=
X-Google-Smtp-Source: AGHT+IEWLxJXVOWRTPfAniTBbk6adQv1Jd2bBOVIIlbL52L8x0hRMts+2HYqIfL8Z1CrQOHvp7WprVeGTK/KA3zyUOw=
X-Received: by 2002:a17:903:1212:b0:1d9:14fb:d142 with SMTP id
 l18-20020a170903121200b001d914fbd142mr3457355plh.32.1708039372800; Thu, 15
 Feb 2024 15:22:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-15-alexei.starovoitov@gmail.com> <e9fbe163f0273448142ba70b2cf8a13b6cca57ad.camel@gmail.com>
 <CAEf4BzYbkqhrPCY1RfyHHY1nq-fmpxP2O-n0gMzWoDFe4Msofw@mail.gmail.com>
 <7af0d2e0cc168eb8f57be0fe185d7fa9caf87824.camel@gmail.com>
 <CAEf4BzZyPDdtV8xyFxpLmPQpKrtO-affGrEfyDkodr_BDHVZcA@mail.gmail.com>
 <CAADnVQKY0UKYRUBmUZ8BPUrcx-t-v6iMz7u0AaBUKLB1-CS0qg@mail.gmail.com> <CAEf4BzY8grOqDUOAuvyBw+t1oZh6x_6xubHePv3byxV3sC9uVg@mail.gmail.com>
In-Reply-To: <CAEf4BzY8grOqDUOAuvyBw+t1oZh6x_6xubHePv3byxV3sC9uVg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Feb 2024 15:22:40 -0800
Message-ID: <CAEf4BzapMe_zjrN9j7w41xP05VZOV_Nys9kwks7yCC312Omdpg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 14/20] libbpf: Recognize __arena global varaibles.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 9:24=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Feb 13, 2024 at 5:24=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Feb 13, 2024 at 4:09=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Feb 13, 2024 at 3:37=E2=80=AFPM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> > > >
> > > > On Tue, 2024-02-13 at 15:17 -0800, Andrii Nakryiko wrote:
> > > >
> > > > [...]
> > > >
> > > > > > So, at first I thought that having two maps is a bit of a hack.
> > > > >
> > > > > yep, that was my instinct as well
> > > > >
> > > > > > However, after trying to make it work with only one map I don't=
 really
> > > > > > like that either :)
> > > > >
> > > > > Can you elaborate? see my reply to Alexei, I wonder how did you t=
hink
> > > > > about doing this?
> > > >
> > > > Relocations in the ELF file are against a new section: ".arena.1".
> > > > This works nicely with logic in bpf_program__record_reloc().
> > > > If single map is used, we effectively need to track two indexes for
> > > > the map section:
> > > > - one used for relocations against map variables themselves
> > > >   (named "generic map reference relocation" in the function code);
> > > > - one used for relocations against ".arena.1"
> > > >   (named "global data map relocation" in the function code).
> > > >
> > > > This spooked me off:
> > > > - either bpf_object__init_internal_map() would have a specialized
> > > >   branch for arenas, as with current approach;
> > > > - or bpf_program__record_reloc() would have a specialized branch fo=
r arenas,
> > > >   as with one map approach.
> > >
> > > Yes, relocations would know about .arena.1, but it's a pretty simple
> > > check in a few places. We basically have arena *definition* sec_idx
> > > (corresponding to SEC(".maps")) and arena *data* sec_idx. The latter
> > > is what is recorded for global variables in .arena.1. We can remember
> > > this arena data sec_idx in struct bpf_object once during ELF
> > > processing, and then just special case it internally in a few places.
> >
> > That was my first attempt and bpf_program__record_reloc()
> > became a mess.
> > Currently it does relo search either in internal maps
> > or in obj->efile.btf_maps_shndx.
> > Doing double search wasn't nice.
> > And further, such dual meaning of 'struct bpf_map' object messes
> > assumptions of bpf_object__shndx_is_maps, bpf_object__shndx_is_data
> > and the way libbpf treats map->libbpf_type everywhere.
> >
> > bpf_map__is_internal() cannot really say true or false
> > for such dual use map.
> > Then skeleton gen gets ugly.
> > Needs more public libbpf APIs to use in bpftool gen.
> > Just a mess.
>
> It might be easier for me to try implement it the way I see it than
> discuss it over emails. I'll give it a try today-tomorrow and get back
> to you.
>
> >
> > > The "fake" bpf_map for __arena_internal is user-visible and requires
> > > autocreate=3Dfalse tricks, etc. I feel like it's a worse tradeoff fro=
m a
> > > user API perspective than a few extra ARENA-specific internal checks
> > > (which we already have a few anyways, ARENA is not completely
> > > transparent internally anyways).
> >
> > what do you mean 'user visible'?
>
> That __arena_internal (representing .area.1 data section) actually is
> separate from actual ARENA map (represented by variable in .maps
> section). And both have separate `struct bpf_map`, which you can look
> up by name or through iterating all maps of bpf_object. And that you
> can call getters/setters on __arena_internal, even though the only
> thing that actually makes sense there is bpf_map__initial_value(),
> which would just as much make sense on ARENA map itself.
>
> > I can add a filter to avoid generating a pointer for it in a skeleton.
> > Then it won't be any more visible than other bss/data fake maps.
>
> bss/data are not fake maps, they have corresponding BPF map (ARRAY) in
> the kernel. Which is different from __arena_internal. And even if we
> hide it from skeleton, it's still there in bpf_object, as I mentioned
> above.
>
> Let me try implementing what I have in mind and see how bad it is.
>
> > The 2nd fake arena returns true out of bpf_map__is_internal.
> >
> > The key comment in the patch:
> >                 /* bpf_object will contain two arena maps:
> >                  * LIBBPF_MAP_ARENA & BPF_MAP_TYPE_ARENA
> >                  * and
> >                  * LIBBPF_MAP_UNSPEC & BPF_MAP_TYPE_ARENA.
> >                  * The former map->arena will point to latter.
> >                  */
>
> Yes, and I'd like to not have two arena maps because they are logically o=
ne.

Alright, I'm back. I pushed 3 patches on top of your patches into [0].
Available also at [1], if that's more convenient. I'll paste the main
diff below, but gmail will inevitably butcher the formatting, but it's
easier to discuss the code this way.

  [0] https://github.com/anakryiko/linux/commits/arena/
  [1] https://git.kernel.org/pub/scm/linux/kernel/git/andrii/bpf-next.git/l=
og/?h=3Darena

First, as I was working on the code, I realized that the place where
we do mmap() after creating ARENA map is different from where we
normally do post-creation steps, so I moved the code to keep all those
extra steps in one place. No changes in logic, but now we also don't
need to close map_fd and so on, I think it's better this way.

And so the main changes are below. There are definitely a few
ARENA-specific checks here and there, but I don't think it's that bad.
A bunch of code is just undoing code changes from previous patch, so
once you incorporate these changes into your patches it will be even
smaller.

The main outcome is that we don't have a fake map as an independent
struct bpf_map and bpf_map__initial_value() logic works transparently.

We'll probably need similar special-casing for STRUCT_OPS maps that
Kui-Feng is adding, so ARENA won't be the only one.

The slightly annoying part is that special casing is necessary because
of map->mmapable assumption that it has to be munmap() and its size is
calculated by bpf_map_mmap_sz() (I could have hacked
map->def.value_size for this, but that felt wrong). We could
generalize/fix that, but I chose not to do that just yet.


commit 2a7a90e06d02a4edb60cf92c19aee2b3f05d3cca
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Thu Feb 15 14:55:00 2024 -0800

    libbpf: remove fake __arena_internal map

    Unify actual ARENA map and fake __arena_internal map. .arena.1 ELF
    section isn't a stand-alone BPF map, so it shouldn't be represented as
    `struct bpf_map *` instance in libbpf APIs. Instead, use ELF section
    data as initial data image, which is exposed through skeleton and
    bpf_map__initial_value() to the user, if they need to tune it before th=
e
    load phase. During load phase, this initial image is copied over into
    mmap()'ed region corresponding to ARENA, and discarded.

    Few small checks here and there had to be added to make sure this
    approach works with bpf_map__initial_value(), mostly due to hard-coded
    assumption that map->mmaped is set up with mmap() syscall and should be
    munmap()'ed. For ARENA, .arena.1 can be (much) smaller than maximum
    ARENA size, so this smaller data size has to be tracked separately.
    Given it is enforced that there is only one ARENA for entire bpf_object
    instance, we just keep it in a separate field. This can be generalized
    if necessary later.

    bpftool is adjusted a bit as well, because ARENA map is not reported as
    "internal" (it's not a great fit in this case), plus we need to take
    into account that ARENA map can exist without corresponding .arena.1 EL=
F
    section, so user-facing data section in skeleton is optional.

    Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 273da2098231..6e17b95436de 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -82,7 +82,7 @@ static bool get_map_ident(const struct bpf_map *map,
char *buf, size_t buf_sz)
     const char *name =3D bpf_map__name(map);
     int i, n;

-    if (!bpf_map__is_internal(map) || bpf_map__type(map) =3D=3D
BPF_MAP_TYPE_ARENA) {
+    if (!bpf_map__is_internal(map)) {
         snprintf(buf, buf_sz, "%s", name);
         return true;
     }
@@ -109,7 +109,7 @@ static bool get_datasec_ident(const char
*sec_name, char *buf, size_t buf_sz)
     /* recognize hard coded LLVM section name */
     if (strcmp(sec_name, ".arena.1") =3D=3D 0) {
         /* this is the name to use in skeleton */
-        strncpy(buf, "arena", buf_sz);
+        snprintf(buf, buf_sz, "arena");
         return true;
     }
     for  (i =3D 0, n =3D ARRAY_SIZE(pfxs); i < n; i++) {
@@ -242,14 +242,16 @@ static const struct btf_type
*find_type_for_map(struct btf *btf, const char *map

 static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t s=
z)
 {
-    if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) &
BPF_F_MMAPABLE))
-        return false;
+    size_t tmp_sz;

-    if (bpf_map__type(map) =3D=3D BPF_MAP_TYPE_ARENA) {
-        strncpy(buf, "arena", sz);
+    if (bpf_map__type(map) =3D=3D BPF_MAP_TYPE_ARENA &&
bpf_map__initial_value(map, &tmp_sz)) {
+        snprintf(buf, sz, "arena");
         return true;
     }

+    if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) &
BPF_F_MMAPABLE))
+        return false;
+
     if (!get_map_ident(map, buf, sz))
         return false;

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5a53f1ed87f2..c72577bef439 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -506,7 +506,6 @@ enum libbpf_map_type {
     LIBBPF_MAP_BSS,
     LIBBPF_MAP_RODATA,
     LIBBPF_MAP_KCONFIG,
-    LIBBPF_MAP_ARENA,
 };

 struct bpf_map_def {
@@ -549,7 +548,6 @@ struct bpf_map {
     bool reused;
     bool autocreate;
     __u64 map_extra;
-    struct bpf_map *arena;
 };

 enum extern_type {
@@ -616,7 +614,6 @@ enum sec_type {
     SEC_BSS,
     SEC_DATA,
     SEC_RODATA,
-    SEC_ARENA,
 };

 struct elf_sec_desc {
@@ -634,6 +631,7 @@ struct elf_state {
     Elf_Data *symbols;
     Elf_Data *st_ops_data;
     Elf_Data *st_ops_link_data;
+    Elf_Data *arena_data;
     size_t shstrndx; /* section index for section name strings */
     size_t strtabidx;
     struct elf_sec_desc *secs;
@@ -644,6 +642,7 @@ struct elf_state {
     int symbols_shndx;
     int st_ops_shndx;
     int st_ops_link_shndx;
+    int arena_data_shndx;
 };

 struct usdt_manager;
@@ -703,6 +702,10 @@ struct bpf_object {

     struct usdt_manager *usdt_man;

+    struct bpf_map *arena_map;
+    void *arena_data;
+    size_t arena_data_sz;
+
     struct kern_feature_cache *feat_cache;
     char *token_path;
     int token_fd;
@@ -1340,6 +1343,7 @@ static void bpf_object__elf_finish(struct bpf_object =
*obj)
     obj->efile.symbols =3D NULL;
     obj->efile.st_ops_data =3D NULL;
     obj->efile.st_ops_link_data =3D NULL;
+    obj->efile.arena_data =3D NULL;

     zfree(&obj->efile.secs);
     obj->efile.sec_cnt =3D 0;
@@ -1722,34 +1726,10 @@ static int
 bpf_object__init_internal_map(struct bpf_object *obj, enum
libbpf_map_type type,
                   const char *real_name, int sec_idx, void *data,
size_t data_sz)
 {
-    const long page_sz =3D sysconf(_SC_PAGE_SIZE);
-    struct bpf_map *map, *arena =3D NULL;
     struct bpf_map_def *def;
+    struct bpf_map *map;
     size_t mmap_sz;
-    int err, i;
-
-    if (type =3D=3D LIBBPF_MAP_ARENA) {
-        for (i =3D 0; i < obj->nr_maps; i++) {
-            map =3D &obj->maps[i];
-            if (map->def.type !=3D BPF_MAP_TYPE_ARENA)
-                continue;
-            arena =3D map;
-            real_name =3D "__arena_internal";
-                mmap_sz =3D bpf_map_mmap_sz(map);
-            if (roundup(data_sz, page_sz) > mmap_sz) {
-                pr_warn("Declared arena map size %zd is too small to hold"
-                    "global __arena variables of size %zd\n",
-                    mmap_sz, data_sz);
-                return -E2BIG;
-            }
-            break;
-        }
-        if (!arena) {
-            pr_warn("To use global __arena variables the arena map should"
-                "be declared explicitly in SEC(\".maps\")\n");
-            return -ENOENT;
-        }
-    }
+    int err;

     map =3D bpf_object__add_map(obj);
     if (IS_ERR(map))
@@ -1760,7 +1740,6 @@ bpf_object__init_internal_map(struct bpf_object
*obj, enum libbpf_map_type type,
     map->sec_offset =3D 0;
     map->real_name =3D strdup(real_name);
     map->name =3D internal_map_name(obj, real_name);
-    map->arena =3D arena;
     if (!map->real_name || !map->name) {
         zfree(&map->real_name);
         zfree(&map->name);
@@ -1768,32 +1747,18 @@ bpf_object__init_internal_map(struct
bpf_object *obj, enum libbpf_map_type type,
     }

     def =3D &map->def;
-    if (type =3D=3D LIBBPF_MAP_ARENA) {
-        /* bpf_object will contain two arena maps:
-         * LIBBPF_MAP_ARENA & BPF_MAP_TYPE_ARENA
-         * and
-         * LIBBPF_MAP_UNSPEC & BPF_MAP_TYPE_ARENA.
-         * The former map->arena will point to latter.
-         */
-        def->type =3D BPF_MAP_TYPE_ARENA;
-        def->key_size =3D 0;
-        def->value_size =3D 0;
-        def->max_entries =3D roundup(data_sz, page_sz) / page_sz;
-        def->map_flags =3D BPF_F_MMAPABLE;
-    } else {
-        def->type =3D BPF_MAP_TYPE_ARRAY;
-        def->key_size =3D sizeof(int);
-        def->value_size =3D data_sz;
-        def->max_entries =3D 1;
-        def->map_flags =3D type =3D=3D LIBBPF_MAP_RODATA || type =3D=3D
LIBBPF_MAP_KCONFIG
-            ? BPF_F_RDONLY_PROG : 0;
+    def->type =3D BPF_MAP_TYPE_ARRAY;
+    def->key_size =3D sizeof(int);
+    def->value_size =3D data_sz;
+    def->max_entries =3D 1;
+    def->map_flags =3D type =3D=3D LIBBPF_MAP_RODATA || type =3D=3D LIBBPF=
_MAP_KCONFIG
+        ? BPF_F_RDONLY_PROG : 0;

-        /* failures are fine because of maps like .rodata.str1.1 */
-        (void) map_fill_btf_type_info(obj, map);
+    /* failures are fine because of maps like .rodata.str1.1 */
+    (void) map_fill_btf_type_info(obj, map);

-        if (map_is_mmapable(obj, map))
-            def->map_flags |=3D BPF_F_MMAPABLE;
-    }
+    if (map_is_mmapable(obj, map))
+        def->map_flags |=3D BPF_F_MMAPABLE;

     pr_debug("map '%s' (global data): at sec_idx %d, offset %zu, flags %x.=
\n",
          map->name, map->sec_idx, map->sec_offset, def->map_flags);
@@ -1857,13 +1822,6 @@ static int
bpf_object__init_global_data_maps(struct bpf_object *obj)
                                 NULL,
                                 sec_desc->data->d_size);
             break;
-        case SEC_ARENA:
-            sec_name =3D elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
-            err =3D bpf_object__init_internal_map(obj, LIBBPF_MAP_ARENA,
-                                sec_name, sec_idx,
-                                sec_desc->data->d_buf,
-                                sec_desc->data->d_size);
-            break;
         default:
             /* skip */
             break;
@@ -2786,6 +2744,32 @@ static int bpf_object__init_user_btf_map(struct
bpf_object *obj,
     return 0;
 }

+static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map=
,
+                   const char *sec_name, int sec_idx,
+                   void *data, size_t data_sz)
+{
+    const long page_sz =3D sysconf(_SC_PAGE_SIZE);
+    size_t mmap_sz;
+
+    mmap_sz =3D bpf_map_mmap_sz(obj->arena_map);
+    if (roundup(data_sz, page_sz) > mmap_sz) {
+        pr_warn("elf: sec '%s': declared ARENA map size (%zu) is too
small to hold global __arena variables of size %zu\n",
+            sec_name, mmap_sz, data_sz);
+        return -E2BIG;
+    }
+
+    obj->arena_data =3D malloc(data_sz);
+    if (!obj->arena_data)
+        return -ENOMEM;
+    memcpy(obj->arena_data, data, data_sz);
+    obj->arena_data_sz =3D data_sz;
+
+    /* make bpf_map__init_value() work for ARENA maps */
+    map->mmaped =3D obj->arena_data;
+
+    return 0;
+}
+
 static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool str=
ict,
                       const char *pin_root_path)
 {
@@ -2835,6 +2819,33 @@ static int
bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
             return err;
     }

+    for (i =3D 0; i < obj->nr_maps; i++) {
+        struct bpf_map *map =3D &obj->maps[i];
+
+        if (map->def.type !=3D BPF_MAP_TYPE_ARENA)
+            continue;
+
+        if (obj->arena_map) {
+            pr_warn("map '%s': only single ARENA map is supported
(map '%s' is also ARENA)\n",
+                map->name, obj->arena_map->name);
+            return -EINVAL;
+        }
+        obj->arena_map =3D map;
+
+        if (obj->efile.arena_data) {
+            err =3D init_arena_map_data(obj, map, ARENA_SEC,
obj->efile.arena_data_shndx,
+                          obj->efile.arena_data->d_buf,
+                          obj->efile.arena_data->d_size);
+            if (err)
+                return err;
+        }
+    }
+    if (obj->efile.arena_data && !obj->arena_map) {
+        pr_warn("elf: sec '%s': to use global __arena variables the
ARENA map should be explicitly declared in SEC(\".maps\")\n",
+            ARENA_SEC);
+        return -ENOENT;
+    }
+
     return 0;
 }

@@ -3699,9 +3710,8 @@ static int bpf_object__elf_collect(struct bpf_object =
*obj)
                 obj->efile.st_ops_link_data =3D data;
                 obj->efile.st_ops_link_shndx =3D idx;
             } else if (strcmp(name, ARENA_SEC) =3D=3D 0) {
-                sec_desc->sec_type =3D SEC_ARENA;
-                sec_desc->shdr =3D sh;
-                sec_desc->data =3D data;
+                obj->efile.arena_data =3D data;
+                obj->efile.arena_data_shndx =3D idx;
             } else {
                 pr_info("elf: skipping unrecognized data section(%d) %s\n"=
,
                     idx, name);
@@ -4204,7 +4214,6 @@ static bool bpf_object__shndx_is_data(const
struct bpf_object *obj,
     case SEC_BSS:
     case SEC_DATA:
     case SEC_RODATA:
-    case SEC_ARENA:
         return true;
     default:
         return false;
@@ -4230,8 +4239,6 @@ bpf_object__section_to_libbpf_map_type(const
struct bpf_object *obj, int shndx)
         return LIBBPF_MAP_DATA;
     case SEC_RODATA:
         return LIBBPF_MAP_RODATA;
-    case SEC_ARENA:
-        return LIBBPF_MAP_ARENA;
     default:
         return LIBBPF_MAP_UNSPEC;
     }
@@ -4332,6 +4339,15 @@ static int bpf_program__record_reloc(struct
bpf_program *prog,
     type =3D bpf_object__section_to_libbpf_map_type(obj, shdr_idx);
     sym_sec_name =3D elf_sec_name(obj, elf_sec_by_idx(obj, shdr_idx));

+    /* arena data relocation */
+    if (shdr_idx =3D=3D obj->efile.arena_data_shndx) {
+        reloc_desc->type =3D RELO_DATA;
+        reloc_desc->insn_idx =3D insn_idx;
+        reloc_desc->map_idx =3D obj->arena_map - obj->maps;
+        reloc_desc->sym_off =3D sym->st_value;
+        return 0;
+    }
+
     /* generic map reference relocation */
     if (type =3D=3D LIBBPF_MAP_UNSPEC) {
         if (!bpf_object__shndx_is_maps(obj, shdr_idx)) {
@@ -4385,7 +4401,7 @@ static int bpf_program__record_reloc(struct
bpf_program *prog,

     reloc_desc->type =3D RELO_DATA;
     reloc_desc->insn_idx =3D insn_idx;
-    reloc_desc->map_idx =3D map->arena ? map->arena - obj->maps : map_idx;
+    reloc_desc->map_idx =3D map_idx;
     reloc_desc->sym_off =3D sym->st_value;
     return 0;
 }
@@ -4872,8 +4888,6 @@ bpf_object__populate_internal_map(struct
bpf_object *obj, struct bpf_map *map)
             bpf_gen__map_freeze(obj->gen_loader, map - obj->maps);
         return 0;
     }
-    if (map_type =3D=3D LIBBPF_MAP_ARENA)
-        return 0;

     err =3D bpf_map_update_elem(map->fd, &zero, map->mmaped, 0);
     if (err) {
@@ -5166,15 +5180,6 @@ bpf_object__create_maps(struct bpf_object *obj)
         if (bpf_map__is_internal(map) && !kernel_supports(obj,
FEAT_GLOBAL_DATA))
             map->autocreate =3D false;

-        if (map->libbpf_type =3D=3D LIBBPF_MAP_ARENA) {
-            size_t len =3D bpf_map_mmap_sz(map);
-
-            memcpy(map->arena->mmaped, map->mmaped, len);
-            map->autocreate =3D false;
-            munmap(map->mmaped, len);
-            map->mmaped =3D NULL;
-        }
-
         if (!map->autocreate) {
             pr_debug("map '%s': skipped auto-creating...\n", map->name);
             continue;
@@ -5229,6 +5234,10 @@ bpf_object__create_maps(struct bpf_object *obj)
                         map->name, err);
                     return err;
                 }
+                if (obj->arena_data) {
+                    memcpy(map->mmaped, obj->arena_data, obj->arena_data_s=
z);
+                    zfree(&obj->arena_data);
+                }
             }
             if (map->init_slots_sz && map->def.type !=3D
BPF_MAP_TYPE_PROG_ARRAY) {
                 err =3D init_map_in_map_slots(obj, map);
@@ -8716,13 +8725,9 @@ static void bpf_map__destroy(struct bpf_map *map)
     zfree(&map->init_slots);
     map->init_slots_sz =3D 0;

-    if (map->mmaped) {
-        size_t mmap_sz;
-
-        mmap_sz =3D bpf_map_mmap_sz(map);
-        munmap(map->mmaped, mmap_sz);
-        map->mmaped =3D NULL;
-    }
+    if (map->mmaped && map->mmaped !=3D map->obj->arena_data)
+        munmap(map->mmaped, bpf_map_mmap_sz(map));
+    map->mmaped =3D NULL;

     if (map->st_ops) {
         zfree(&map->st_ops->data);
@@ -8782,6 +8787,8 @@ void bpf_object__close(struct bpf_object *obj)
     if (obj->token_fd > 0)
         close(obj->token_fd);

+    zfree(&obj->arena_data);
+
     free(obj);
 }

@@ -9803,8 +9810,6 @@ static bool map_uses_real_name(const struct bpf_map *=
map)
         return true;
     if (map->libbpf_type =3D=3D LIBBPF_MAP_RODATA &&
strcmp(map->real_name, RODATA_SEC) !=3D 0)
         return true;
-    if (map->libbpf_type =3D=3D LIBBPF_MAP_ARENA)
-        return true;
     return false;
 }

@@ -10006,22 +10011,35 @@ __u32 bpf_map__btf_value_type_id(const
struct bpf_map *map)
 int bpf_map__set_initial_value(struct bpf_map *map,
                    const void *data, size_t size)
 {
+    size_t actual_sz;
+
     if (map->obj->loaded || map->reused)
         return libbpf_err(-EBUSY);

-    if (!map->mmaped || map->libbpf_type =3D=3D LIBBPF_MAP_KCONFIG ||
-        size !=3D map->def.value_size)
+    if (!map->mmaped || map->libbpf_type =3D=3D LIBBPF_MAP_KCONFIG)
+        return libbpf_err(-EINVAL);
+
+    if (map->def.type =3D=3D BPF_MAP_TYPE_ARENA)
+        actual_sz =3D map->obj->arena_data_sz;
+    else
+        actual_sz =3D map->def.value_size;
+    if (size !=3D actual_sz)
         return libbpf_err(-EINVAL);

     memcpy(map->mmaped, data, size);
     return 0;
 }

-void *bpf_map__initial_value(struct bpf_map *map, size_t *psize)
+void *bpf_map__initial_value(const struct bpf_map *map, size_t *psize)
 {
     if (!map->mmaped)
         return NULL;
-    *psize =3D map->def.value_size;
+
+    if (map->def.type =3D=3D BPF_MAP_TYPE_ARENA)
+        *psize =3D map->obj->arena_data_sz;
+    else
+        *psize =3D map->def.value_size;
+
     return map->mmaped;
 }

@@ -13510,8 +13528,8 @@ int bpf_object__load_skeleton(struct
bpf_object_skeleton *s)
             continue;
         }

-        if (map->arena) {
-            *mmaped =3D map->arena->mmaped;
+        if (map->def.type =3D=3D BPF_MAP_TYPE_ARENA) {
+            *mmaped =3D map->mmaped;
             continue;
         }

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5723cbbfcc41..7b510761f545 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1014,7 +1014,7 @@ LIBBPF_API int bpf_map__set_map_extra(struct
bpf_map *map, __u64 map_extra);

 LIBBPF_API int bpf_map__set_initial_value(struct bpf_map *map,
                       const void *data, size_t size);
-LIBBPF_API void *bpf_map__initial_value(struct bpf_map *map, size_t *psize=
);
+LIBBPF_API void *bpf_map__initial_value(const struct bpf_map *map,
size_t *psize);

 /**
  * @brief **bpf_map__is_internal()** tells the caller whether or not the

