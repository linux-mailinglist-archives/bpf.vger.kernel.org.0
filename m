Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B2168E728
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 05:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjBHEbE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 23:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjBHEa0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 23:30:26 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F70142DDD
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 20:29:57 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v10so18835731edi.8
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 20:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/v51f2sKhv0Rifso1sCtjYR4vUAot9Q+i8d3sbt1rOc=;
        b=Mh33QyL0aZxb9h/t0pgS3xfkZ8kKszlfGvDbOSoZMZGHPS83Czbd/S5Q361Pd1P1Jm
         xMQWOQZlY4TB5sA+zl2ky4K6/HEkl5mNA7Y7OPPjY+e7dPUx5vpdfPVNPqF1ebhOWO+A
         ufDRKo9H37a69foN36QZXXYE/ToTJ5VZ2ThbtO71hMpyPtpTPZM3iIYdcSKcmS0nLxcV
         F0nxs4Ocdr99Oe7V7zzbjcO3ZtrPPANYcqXCltulcb7dAkJQNOlrozXIe+NrVups+/Bl
         Ti0tz/Vg+2ZweLrO3dlVxugommx4H1vnMUv8ahluo0onx3TEt2Ds4lp12Y9o6sLIbP5C
         IGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/v51f2sKhv0Rifso1sCtjYR4vUAot9Q+i8d3sbt1rOc=;
        b=CsrBYqs1UA1+vsAPSha0dGvIsIXRVpar34DadSQ84PeGo2jhZt10H0WjWWCEnEwYaz
         0OFNDrXCyCtMXdlXy5BolMIOnUFm+X9hstpr1iiaQmWIKXavv/o7GKis3GPTNwyJqv0h
         OvJyzTZBCGzzEGRVgGyBFAaS/FkUk/ShSti1LviX5jYj1X+GKUxMSLycHfBK4wA7Qm9v
         2h7vOBKQ4bYvZPRPr8ha0BoKOd0OC58hSf3cI51XQ1EqSTxmj/8eFnLBbzuPS5yYVevG
         i8jUO191F7S/Lta+zZnF/vlCS5STpY5t+GBQXu96/kgIT9F7ogJZlORoqsjbKEm8LI8X
         IUTQ==
X-Gm-Message-State: AO0yUKXln+fgQfHrkxPNW9Hcvm7NtFPwc2r8TAfL36zVyrIaT6C6WZH2
        AC7qAFy55zYzF+tU/cN2yqdtespHcw1+k7EDdvX0OqIlcnI=
X-Google-Smtp-Source: AK7set8m7REp8XimiRtS19hcOkbqhhhqicP23pKdQQ80e4zrjuPbuWBjjdC6H1c5pelkhAe3zx/+GYghtwpdnDNPP80=
X-Received: by 2002:a50:d717:0:b0:4aa:a4e6:b323 with SMTP id
 t23-20020a50d717000000b004aaa4e6b323mr1512869edi.34.1675830595739; Tue, 07
 Feb 2023 20:29:55 -0800 (PST)
MIME-Version: 1.0
References: <20230202014158.19616-1-laoar.shao@gmail.com> <20230202014158.19616-8-laoar.shao@gmail.com>
 <63ddbc69ef50f_6bb1520813@john.notmuch> <CALOAHbDUk7CymPco4s12EdFauFroVBhQM6yNJQzji1D=jmkM5g@mail.gmail.com>
 <CAADnVQLe9OVF2xUpsA6buPPRhFuRgPEgk2Mxe8UWPZrhfFAwCw@mail.gmail.com> <CALOAHbCzCprMhRHSBQ5NC8b=4DuuUT=H8Zx+3Eb1aTcb_XgEkA@mail.gmail.com>
In-Reply-To: <CALOAHbCzCprMhRHSBQ5NC8b=4DuuUT=H8Zx+3Eb1aTcb_XgEkA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 7 Feb 2023 20:29:44 -0800
Message-ID: <CAADnVQLT4p0m5Z=WhSEJv5s3x_o8KZZyd48zEKabAfj7kHTT2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/7] bpf: hashtab memory usage
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Tejun Heo <tj@kernel.org>, dennis@kernel.org,
        Chris Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, urezki@gmail.com,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 7, 2023 at 7:34 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Wed, Feb 8, 2023 at 9:56 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Feb 4, 2023 at 7:56 PM Yafang Shao <laoar.shao@gmail.com> wrote=
:
> > >
> > > On Sat, Feb 4, 2023 at 10:01 AM John Fastabend <john.fastabend@gmail.=
com> wrote:
> > > >
> > > > Yafang Shao wrote:
> > > > > Get htab memory usage from the htab pointers we have allocated. S=
ome
> > > > > small pointers are ignored as their size are quite small compared=
 with
> > > > > the total size.
> > > > >
> > > > > The result as follows,
> > > > > - before this change
> > > > > 1: hash  name count_map  flags 0x0  <<<< prealloc
> > > > >         key 16B  value 24B  max_entries 1048576  memlock 41943040=
B
> > > > > 2: hash  name count_map  flags 0x1  <<<< non prealloc, fully set
> > > > >         key 16B  value 24B  max_entries 1048576  memlock 41943040=
B
> > > > > 3: hash  name count_map  flags 0x1  <<<< non prealloc, non set
> > > > >         key 16B  value 24B  max_entries 1048576  memlock 41943040=
B
> > > > >
> > > > > The memlock is always a fixed number whatever it is preallocated =
or
> > > > > not, and whatever the allocated elements number is.
> > > > >
> > > > > - after this change
> > > > > 1: hash  name count_map  flags 0x0  <<<< prealloc
> > > > >         key 16B  value 24B  max_entries 1048576  memlock 10906446=
4B
> > > > > 2: hash  name count_map  flags 0x1  <<<< non prealloc, fully set
> > > > >         key 16B  value 24B  max_entries 1048576  memlock 11746432=
0B
> > > > > 3: hash  name count_map  flags 0x1  <<<< non prealloc, non set
> > > > >         key 16B  value 24B  max_entries 1048576  memlock 16797952=
B
> > > > >
> > > > > The memlock now is hashtab actually allocated.
> > > > >
> > > > > At worst, the difference can be 10x, for example,
> > > > > - before this change
> > > > > 4: hash  name count_map  flags 0x0
> > > > >         key 4B  value 4B  max_entries 1048576  memlock 8388608B
> > > > >
> > > > > - after this change
> > > > > 4: hash  name count_map  flags 0x0
> > > > >         key 4B  value 4B  max_entries 1048576  memlock 83898640B
> > > > >
> > > >
> > > > This walks the entire map and buckets to get the size? Inside a
> > > > rcu critical section as well :/ it seems.
> > > >
> > >
> > > No, it doesn't walk the entire map and buckets, but just gets one
> > > random element.
> > > So it won't be a problem to do it inside a rcu critical section.
> > >
> > > > What am I missing, if you know how many elements are added (which
> > > > you can track on map updates) how come we can't just calculate the
> > > > memory size directly from this?
> > > >
> > >
> > > It is less accurate and hard to understand. Take non-preallocated
> > > percpu hashtab for example,
> > > The size can be calculated as follows,
> > >     key_size =3D round_up(htab->map.key_size, 8)=EF=BC=9B
> > >     value_size =3D round_up(htab->map.value_size, 8);
> > >     pcpu_meta_size =3D sizeof(struct llist_node) + sizeof(void *);
> > >     usage =3D ((value_size * num_possible_cpus() +\
> > >                     pcpu_meta_size + key_size) * max_entries
> > >
> > > That is quite unfriendly to the newbies, and may be error-prone.
> >
> > Please do that instead.
>
> I can do it as you suggested, but it seems we shouldn't keep all
> estimates in one place. Because ...
>
> > map_mem_usage callback is a no go as I mentioned earlier.
>
> ...we have to introduce the map_mem_usage callback. Take the lpm_trie
> for example, its usage is
> usage =3D (sizeof(struct lpm_trie_node) + trie->data_size) * trie->n_entr=
ies;

sizeof(struct lpm_trie_node) + trie->data_size + trie->map.value_size.

and it won't count the inner nodes, but _it is ok_.

> I don't think we want  to declare struct lpm_trie_node in kernel/bpf/sysc=
all.c.
> WDYT ?

Good point. Fine. Let's go with callback, but please keep it
to a single function without loops like htab_non_prealloc_elems_size()
and htab_prealloc_elems_size().

Also please implement it for all maps.
Doing it just for hash and arguing that every byte of accuracy matters
while not addressing lpm and other maps doesn't give credibility
to the accuracy argument.
