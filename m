Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CD852568B
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 22:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240139AbiELUuo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 16:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348349AbiELUun (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 16:50:43 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65703EA8
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 13:50:41 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id o190so6684282iof.10
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 13:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ooET60zI3sdDUciE0UU4uqFSXu2MNREZl3PtN8lmxZ8=;
        b=B3UZfmNo7aDJXMY9PDaKVwuwUywdJXFjL6EM4rDPPoYFpaTXqK5mjHFe82vy0/P7VS
         6LNkWanS+2ONTbm60VqYO/OiF3B7s1wdfawOldNBQ7rufv8eOVIV2TjbG2iQjnBkms2E
         i/lqwxIrrOekW/YEjGZY0A1YdUMCE0caxT0CuNWXQLKsfhkt6ya8/3crp2zqC0FqSrB5
         kavtWpzM2lOb8vGFmSObompNh/Q6ZKnavRGG61JAMpsv1wVaRex8/OySwypzStUGwCby
         C/LX89zQtzGf87tw1q/8CLHbWR11DxbqPTybnojqstXSIHGOp2lBWmKG2z/DkgiQa+AC
         hs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ooET60zI3sdDUciE0UU4uqFSXu2MNREZl3PtN8lmxZ8=;
        b=PC1Vi2JfNPd3DgLoy/ZSm9YxUzx8z4o9HFU/g2FyvdgdqKOd3OsrQ/LBi1uh/qGKV7
         q310EX6erjY8uLgzw9r5RjbnDv6N6GOD9nwLODfKtL0G/bCCCrUtpKMAI76jgT+ntmv7
         FgRFbSwfJ1loXSHHCLSqcteh4cw5CwT7K8T+uCMhj7SAcsR2ygblIGl6HHTCsIi7atRC
         B1I9nIH1y9QzQjLBKJeD4MW10Ch0F8Y1VeEzTj6sQjZ+kpCPBwg/KTeg15+9xAsoeFNW
         VWe9utfQvjoS5UqTo9fcTZBE+RnCTbwzDLFRiLcth7+FvnTQhiV8NmjFCZ2reP68jmBh
         vtHg==
X-Gm-Message-State: AOAM531rsd4Vk6643WmjBoMB0TnMgKm4wAn7IMsAfqEorpKBd/H33mTV
        wCqjdPeQ4RqDnpVebaJeDXUIqh3vjMyEaoKG3tg=
X-Google-Smtp-Source: ABdhPJwKqwn23FjU75mdhXljOcT6jEQCf481M/HcMX5x4INvp4NBFiNY7TBZRR1Xiv76fjbp1L3WynY+bUqSBZ+MsUI=
X-Received: by 2002:a05:6638:533:b0:32a:d418:b77b with SMTP id
 j19-20020a056638053300b0032ad418b77bmr914741jar.237.1652388640560; Thu, 12
 May 2022 13:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220511231448.571909-1-andrii@kernel.org> <cb4f508b-fdcf-aff6-3e94-db387791c8ff@iogearbox.net>
In-Reply-To: <cb4f508b-fdcf-aff6-3e94-db387791c8ff@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 May 2022 13:50:29 -0700
Message-ID: <CAEf4BzbydiD0_D2FnVrfW-ABDPWsKQOd21RE8N_1KiLvWLMbcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add safer high-level wrappers for
 map operations
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 12, 2022 at 12:12 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 5/12/22 1:14 AM, Andrii Nakryiko wrote:
> > Add high-level API wrappers for most common and typical BPF map
> > operations that works directly on instances of struct bpf_map * (so you
> > don't have to call bpf_map__fd()) and validate key/value size
> > expectations.
> >
> > These helpers require users to specify key (and value, where
> > appropriate) sizes when performing lookup/update/delete/etc. This forces
> > user to actually think and validate (for themselves) those. This is
> > a good thing as user is expected by kernel to implicitly provide correct
> > key/value buffer sizes and kernel will just read/write necessary amount
> > of data. If it so happens that user doesn't set up buffers correctly
> > (which bit people for per-CPU maps especially) kernel either randomly
> > overwrites stack data or return -EFAULT, depending on user's luck and
> > circumstances. These high-level APIs are meant to prevent such
> > unpleasant and hard to debug bugs.
> >
> > This patch also adds bpf_map_delete_elem_flags() low-level API and
> > requires passing flags to bpf_map__delete_elem() API for consistency
> > across all similar APIs, even though currently kernel doesn't expect any
> > extra flags for BPF_MAP_DELETE_ELEM operation.
> >
> > List of map operations that get these high-level APIs:
> >    - bpf_map_lookup_elem;
> >    - bpf_map_update_elem;
> >    - bpf_map_delete_elem;
> >    - bpf_map_lookup_and_delete_elem;
> >    - bpf_map_get_next_key.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> [...]
>
> (Looks like the set needs a rebase, just small comment below.)
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 4867a930628b..0ee3943aeaeb 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -9949,6 +9949,96 @@ bpf_object__find_map_by_offset(struct bpf_object *obj, size_t offset)
> >       return libbpf_err_ptr(-ENOTSUP);
> >   }
> >
> > +static int validate_map_op(const struct bpf_map *map, size_t key_sz,
> > +                        size_t value_sz, bool check_value_sz)
> > +{
> > +     if (map->fd <= 0)
> > +             return -ENOENT;
> > +     if (map->def.key_size != key_sz)
> > +             return -EINVAL;
> > +
> > +     if (!check_value_sz)
> > +             return 0;
> > +
> > +     switch (map->def.type) {
> > +     case BPF_MAP_TYPE_PERCPU_ARRAY:
> > +     case BPF_MAP_TYPE_PERCPU_HASH:
> > +     case BPF_MAP_TYPE_LRU_PERCPU_HASH:
> > +     case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
> > +             if (value_sz != libbpf_num_possible_cpus() * roundup(map->def.value_size, 8))
> > +                     return -EINVAL;
> > +             break;
>
> I think this is fine, imho. My initial reaction would be that we should let
> kernel handle errors and not have some kind of additional gate in libbpf that
> would later on make it hard to debug/correlate where errors are coming from,
> but this one here is imho valid given we've seen hard to debug corruptions
> in the past, e.g. f3515b5d0b71 ("bpf: provide a generic macro for percpu values
> for selftests"), where otherwise no error is thrown but just corruption. Maybe
> the above grants a pr_warn() in addition to the -EINVAL. Other than that I
> think we should be very selective in terms of what we add into this here to
> avoid the mentioned err layers. Given it's user choice what API to use, the
> above is okay imho.
>

yep, can add pr_warn for size mismatches and provide expected vs
provided key/value size. Given this is not expected to happen in
correct production program, I'm not concerned with overhead of
pr_warn() for this. Will rebase and add this, thanks!

> > +     default:
> > +             if (map->def.value_size != value_sz)
> > +                     return -EINVAL;
> > +             break;
> > +     }
> > +     return 0;
> > +}
> > +
> > +int bpf_map__lookup_elem(const struct bpf_map *map,
> > +                      const void *key, size_t key_sz,
> > +                      void *value, size_t value_sz, __u64 flags)
> > +{
> > +     int err;
> > +
> > +     err = validate_map_op(map, key_sz, value_sz, true);
> > +     if (err)
> > +             return libbpf_err(err);
> > +
> > +     return bpf_map_lookup_elem_flags(map->fd, key, value, flags);
> > +}
> > +
> [...]
