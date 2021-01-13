Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194A12F57E2
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 04:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbhANCKe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jan 2021 21:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbhAMWS2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jan 2021 17:18:28 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7C7C061786
        for <bpf@vger.kernel.org>; Wed, 13 Jan 2021 14:17:04 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id dj23so1031423edb.13
        for <bpf@vger.kernel.org>; Wed, 13 Jan 2021 14:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=araalinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PcPABvWfPUA80XK0sRCGNkVMyYBXqoCbvlU5XSgzCoU=;
        b=eBHYyC9VTM71x1PvZ3I6vA4B95YczHUkZLx6ZTXvipBAdFwB0PcwIb/njyWtkJqVHh
         Zll2Ail82TUnzl2Mnx3rOYo+BYZ5No+Rgo++FCOGzSRrmQOmLBkIvxedMhNd4BHYooHu
         7LC7pJ7LXKbASPbxKgq3q+scRLnySW64OhU+xM/gJW8i98pyrnGKCEF1JmiFFbBtcypM
         ggmXF2Mbbh9/42ysn0ogmJi+dEtT9wOmcrqC15EJnldCG5qHkKpjF7lrnJ3Uf14aex3G
         gG8RFzWeln2ZiNkvxleNK0puIZ0wU0axCZcyeOGUgJdAJP0O+HMf5fJiZWXkdv8Siln+
         MeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PcPABvWfPUA80XK0sRCGNkVMyYBXqoCbvlU5XSgzCoU=;
        b=iXpD3u/oCScNKlRrWoiV0rLMmWQuto70XqMHbxbAXn9wsNhqb/qgwyBpYJmaf55U6r
         T2Gdg7Jx/jQcc1G3x3QgvhlSTGSn9lRZ3/UyOIqwNjAki2p+Iobg4hI4hBmDcc87nc1/
         oleYWL/1AJS/Lpz+1N+MDA23bmH9a9sXVWE+aqRVCZkFP8nCt3gaptrdEdI3Asfzd6Ix
         NY2zy3vstrKbJK7zJ5GMg3Gg8Q0I++oL8APeO5uTPq7Z321hcQgQSqK8TtHIwLbiAgi5
         OBKQbDEmUoSjrc14VzS87KOBQsUMKlVZROIqtuNRPZLwp6MwWAWgKeyL4qRy+okAxI1u
         wNsQ==
X-Gm-Message-State: AOAM532v67lIzlXViMtc7GW5aOXNsRRJtb099me9u66sNwC9uZGU7Chm
        tlzuJJdibfNlMCxVsGExAr2hUNtJtJ1+T2Be0cluXRzHxzaYIQ==
X-Google-Smtp-Source: ABdhPJzqd2S02027cy0vS6VrBpWzG6s12xNH4UU0ucU4zs4cMgxTGGGc+0wqUrsnGNlBkKrZDL1j+o3z2DX/IOL9Ev0=
X-Received: by 2002:aa7:d9c1:: with SMTP id v1mr3502131eds.115.1610576222621;
 Wed, 13 Jan 2021 14:17:02 -0800 (PST)
MIME-Version: 1.0
References: <B8801F77-37E8-4EF8-8994-D366D48169A3@araalinetworks.com>
 <CAEf4Bzbgw49w2PtowsrzKQNcxD4fZRE6AKByX-5-dMo-+oWHHA@mail.gmail.com> <CADmGQ+3_h22VmJPddhf4Vy2J4PwwkhJAj+N3qSV7vERb+PZw8Q@mail.gmail.com>
In-Reply-To: <CADmGQ+3_h22VmJPddhf4Vy2J4PwwkhJAj+N3qSV7vERb+PZw8Q@mail.gmail.com>
From:   Vamsi Kodavanty <vamsi@araalinetworks.com>
Date:   Wed, 13 Jan 2021 14:16:51 -0800
Message-ID: <CADmGQ+0JMBm8QANoEg5V7pDF6SadSN=u0y1w8BTrYOg5OOWa0g@mail.gmail.com>
Subject: Re: [PATCH bpf v1] Add `core_btf_path` to `bpf_object_open_opts` to
 pass BTF path from skeleton program
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 11, 2021 at 7:33 PM Vamsi Kodavanty
<vamsi@araalinetworks.com> wrote:
>
> Andrii,
>    Thank you for the detailed review. I will address them as well as
> the self tests. And will send out a new patch addressing them and
> conforming to style/expectations.
>
> Cheers
> Vamsi.
>
Andrii,
      I understand the `bpf` repository being a mirror of the
`bpf-next` tools/lib/bpf. Do the patches
to `bpf` go back into `bpf-next`. I see there is a script for
`bpf-next` to `bpf`syncs.
      I ask because the `btf_vmlinux_override` changes only exist in
the `bpf` repo. So, I make my
changes in `bpf`?. In that case what happens to the `selftests` which
are in `bpf-next`. And they
won't have any idea of the new open option 'core_btf_path` that is
being introduced.

Thanks again. Hopefully this is my last question before I come back to
you with a proper patch.

Cheers
Vamsi.

> On Mon, Jan 11, 2021 at 2:02 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Jan 8, 2021 at 6:36 PM Vamsi Kodavanty <vamsi@araalinetworks.com> wrote:
> > >
> > > Andrii,
> > >      I have made the following changes as discussed to add an option to the `open_opts`
> > > to take in the BTF.
> > >      Please do take a look. Also, I am not sure what the procedure is for submitting patches/reviews.
> > > If anyone has any pointers to a webpage where this is described I can go through it. But, below are
> > > the proposed changes.
> > >
> >
> > Daniel already gave you pointers. Also make sure you add [PATCH
> > bpf-next] prefix to email subject to identify the patch is for
> > bpf-next kernel tree.
> > And with all changes like this we should also add selftests,
> > exercising new features. Please take a look at
> > tools/testing/selftests/bpf. I think updating
> > test_progs/test_core_reloc.c in there to use this instead of
> > bpf_object__load_xattr() might be enough of the testing.
> >
> > > Best Regards,
> > > Vamsi.
> > >
> > > ---
> > >  src/libbpf.c | 56 +++++++++++++++++++++++++++++++++++++---------------
> > >  src/libbpf.h |  4 +++-
> > >  2 files changed, 43 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/src/libbpf.c b/src/libbpf.c
> > > index 6ae748f..35d7254 100644
> > > --- a/src/libbpf.c
> > > +++ b/src/libbpf.c
> > > @@ -2538,9 +2538,12 @@ static bool obj_needs_vmlinux_btf(const struct bpf_object *obj)
> > >         struct bpf_program *prog;
> > >         int i;
> > >
> > > -       /* CO-RE relocations need kernel BTF */
> > > +       /* CO-RE relocations need kernel BTF or an override BTF.
> > > +        * If override BTF present CO-RE can use it.
> >
> > nit: "CO-RE relocations need kernel BTF, unless custom BTF override is
> > specified"
> >
> > > +        */
> > >         if (obj->btf_ext && obj->btf_ext->core_relo_info.len)
> > > -               return true;
> > > +               if (!obj->btf_vmlinux_override)
> >
> > please combine this into a single if
> >
> > > +                       return true;
> > >
> > >         /* Support for typed ksyms needs kernel BTF */
> > >         for (i = 0; i < obj->nr_extern; i++) {
> > > @@ -2561,6 +2564,27 @@ static bool obj_needs_vmlinux_btf(const struct bpf_object *obj)
> > >         return false;
> > >  }
> > >
> > > +static int bpf_object__load_override_btf(struct bpf_object *obj,
> > > +                                                                                const char *targ_btf_path)
> >
> > formatting is off? scripts/checkpatch.pl -f <path to file> will report
> > issues like this
> >
> > > +{
> > > +       /* Could have been be set via `bpf_object_open_opts` */
> > > +       if (obj->btf_vmlinux_override)
> > > +               return 0;
> >
> > see below, let's make sure we load btf_vmlinux_override in one place
> > (and cleanup somewhere close)
> >
> > > +
> > > +       if (!targ_btf_path)
> > > +               return 0;
> > > +
> > > +       obj->btf_vmlinux_override = btf__parse(targ_btf_path, NULL);
> > > +       if (IS_ERR_OR_NULL(obj->btf_vmlinux_override)) {
> > > +               int err = PTR_ERR(obj->btf_vmlinux_override);
> > > +               obj->btf_vmlinux_override = NULL;
> > > +               pr_warn("failed to parse target BTF: %d\n", err);
> > > +               return err;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static int bpf_object__load_vmlinux_btf(struct bpf_object *obj, bool force)
> > >  {
> > >         int err;
> > > @@ -6031,7 +6055,7 @@ patch_insn:
> > >  }
> > >
> > >  static int
> > > -bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
> > > +bpf_object__relocate_core(struct bpf_object *obj)
> > >  {
> > >         const struct btf_ext_info_sec *sec;
> > >         const struct bpf_core_relo *rec;
> > > @@ -6045,15 +6069,6 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
> > >         if (obj->btf_ext->core_relo_info.len == 0)
> > >                 return 0;
> > >
> > > -       if (targ_btf_path) {
> > > -               obj->btf_vmlinux_override = btf__parse(targ_btf_path, NULL);
> > > -               if (IS_ERR_OR_NULL(obj->btf_vmlinux_override)) {
> > > -                       err = PTR_ERR(obj->btf_vmlinux_override);
> > > -                       pr_warn("failed to parse target BTF: %d\n", err);
> > > -                       return err;
> > > -               }
> > > -       }
> > > -
> >
> > given we are moving out btf_vmlinux_override loading from
> > bpf_object__relocate_core, we need to move out its destruction and
> > cleanup to the same function that does BTF parsing. That will keep the
> > logic simpler.
> >
> > >         cand_cache = hashmap__new(bpf_core_hash_fn, bpf_core_equal_fn, NULL);
> > >         if (IS_ERR(cand_cache)) {
> > >                 err = PTR_ERR(cand_cache);
> > > @@ -6556,14 +6571,14 @@ bpf_object__relocate_calls(struct bpf_object *obj, struct bpf_program *prog)
> > >  }
> > >
> > >  static int
> > > -bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
> > > +bpf_object__relocate(struct bpf_object *obj)
> > >  {
> > >         struct bpf_program *prog;
> > >         size_t i;
> > >         int err;
> > >
> > >         if (obj->btf_ext) {
> > > -               err = bpf_object__relocate_core(obj, targ_btf_path);
> > > +               err = bpf_object__relocate_core(obj);
> > >                 if (err) {
> > >                         pr_warn("failed to perform CO-RE relocations: %d\n",
> > >                                 err);
> > > @@ -7088,7 +7103,7 @@ static struct bpf_object *
> > >  __bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
> > >                    const struct bpf_object_open_opts *opts)
> > >  {
> > > -       const char *obj_name, *kconfig;
> > > +       const char *obj_name, *kconfig, *core_btf_path;
> > >         struct bpf_program *prog;
> > >         struct bpf_object *obj;
> > >         char tmp_name[64];
> > > @@ -7126,6 +7141,14 @@ __bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
> > >                         return ERR_PTR(-ENOMEM);
> > >         }
> > >
> > > +       core_btf_path = OPTS_GET(opts, core_btf_path, NULL);
> > > +       if (core_btf_path) {
> > > +               pr_debug("parse btf '%s' for CO-RE relocations\n", core_btf_path);
> >
> > Move this right after btf__parse(), so you can report success or
> > failure in one log statement; see how libbpf_find_kernel_btf() does
> > it. Please use similar wording (just "target BTF" instead of "kernel
> > BTF" to distinguish them).
> >
> > > +               obj->btf_vmlinux_override = btf__parse(core_btf_path, NULL);
> >
> > This BTF is not needed until the load phase, so let's not attempt to
> > load it on open() unnecessarily. Just remember the path and defer till
> > bpf_object__load() time.
> >
> > > +               if (IS_ERR_OR_NULL(obj->btf_vmlinux_override))
> > > +                       pr_warn("can't parse btf at '%s'\n", core_btf_path);
> >
> > if BTF can't be loaded, load should fail
> >
> > > +       }
> > > +
> > >         err = bpf_object__elf_init(obj);
> > >         err = err ? : bpf_object__check_endianness(obj);
> > >         err = err ? : bpf_object__elf_collect(obj);
> > > @@ -7481,13 +7504,14 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
> > >         }
> > >
> > >         err = bpf_object__probe_loading(obj);
> > > +       err = err ? : bpf_object__load_override_btf(obj, attr->target_btf_path);
> > >         err = err ? : bpf_object__load_vmlinux_btf(obj, false);
> > >         err = err ? : bpf_object__resolve_externs(obj, obj->kconfig);
> > >         err = err ? : bpf_object__sanitize_and_load_btf(obj);
> > >         err = err ? : bpf_object__sanitize_maps(obj);
> > >         err = err ? : bpf_object__init_kern_struct_ops_maps(obj);
> > >         err = err ? : bpf_object__create_maps(obj);
> > > -       err = err ? : bpf_object__relocate(obj, attr->target_btf_path);
> >
> > For backwards compatibility, we need to still respect
> > attr->target_btf_path. I'd say let attr->target_btf_path override
> > opts->core_btf_path, if specified. Later on we'll probably just
> > deprecate bpf_object__load_xattr() and target_btf_path will go away.
> >
> > > +       err = err ? : bpf_object__relocate(obj);
> > >         err = err ? : bpf_object__load_progs(obj, attr->log_level);
> > >
> > >         /* clean up module BTFs */
> > > diff --git a/src/libbpf.h b/src/libbpf.h
> > > index 3c35eb4..40c4ee9 100644
> > > --- a/src/libbpf.h
> > > +++ b/src/libbpf.h
> > > @@ -93,8 +93,10 @@ struct bpf_object_open_opts {
> > >          * system Kconfig for CONFIG_xxx externs.
> > >          */
> > >         const char *kconfig;
> > > +       /* Path to ELF file with BTF section to be used for relocations. */
> >
> > Given you use btf__parse() when opening this BTF, it handles both ELF
> > and raw BTF data. So let's reword this comment to mention BTF in
> > general.
> >
> > > +       const char *core_btf_path;
> > >  };
> > > -#define bpf_object_open_opts__last_field kconfig
> > > +#define bpf_object_open_opts__last_field core_btf_path
> > >
> > >  LIBBPF_API struct bpf_object *bpf_object__open(const char *path);
> > >  LIBBPF_API struct bpf_object *
> > > --
> > > 2.23.3
> > >
