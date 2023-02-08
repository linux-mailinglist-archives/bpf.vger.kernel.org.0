Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BFF68E5AE
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 02:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjBHB47 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 20:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjBHB46 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 20:56:58 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D6B76B3
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 17:56:57 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id eq11so18591587edb.6
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 17:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWswHjZfE/NK5HNFXHCk8eijOrRMtyo/H4dKw814SU8=;
        b=ZbHvqK6wX37Ta0NG9nFt6fT5/XJnSgbf2oZofuDgCIXWz/LT/Kum6ALV4PFDX1CgmN
         EYNic2FFeCRUrAts5tevK3SWhnLMMHk98/67N2dJcKGNJL7YnXs3MLpHOiGUL+Axj7+1
         6xoW1gfPPDZTVmMg/2zfdhSXMPSnVBSxxBEoDV5oxtG2GEmwy61ku7w8TULzHJbCVIEW
         vhBVWRRswll0niz1+gY7wW8eNxmn55cW/7iKXp4Ps7W6W9qnL7Dv2T7w0AjMjlbrhAPF
         J3+Qzkn5QdqA6tD797T1KeRhtKmNETCfaAi+76lHNpsyDF5qLTmAK9Ec9lXwMgdcvBZD
         5wFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWswHjZfE/NK5HNFXHCk8eijOrRMtyo/H4dKw814SU8=;
        b=l83wtqPtKdxYWO/5VaDacO1N22FCa4wVAiP4T9tldVcBssV82tgiQpp3YuN46v9wA5
         yKa2GiRxmfFQmocg21e7pmTTn75pXch/JI+wDm5sDt6IkeUrj6hVkN3yuNmGFyZFRtnM
         lvUqeqobknLctTE18HtUp+He7zWFf0POeSLSJAJb0VyFITD5SuVHg8PqQLSEJ6O9LOB+
         fDKfzHxHSBH7rG0Fob8NCYx7ueVYWZhzz82Gjmz+0zbsRYzNwiiA/LRR+UnR4JhNMv85
         0Q5/G8+sd0KRzzLdS6o2WkdGeDJ78AEMe/UrlZ4yJZTSdlxZ/P7E9pxLWglWIjOPlFw7
         4ung==
X-Gm-Message-State: AO0yUKWoc3Nravqn9JhXCY2VnkoBUu1ezoiMQzYh/m2Uofk4VHlLvgKZ
        csapNqMBGqcakae7AhocWDHBfFoznpX24a1QUFc=
X-Google-Smtp-Source: AK7set8Doz0Ia4La/kfFSzyiw+nXXjNGhS9r4tzNLD9CCqrGA8VDWhvXPL81940RyPC1UjGFQj/A5oa3eDS9BKmTcGk=
X-Received: by 2002:a50:9ecb:0:b0:49d:ec5d:28b4 with SMTP id
 a69-20020a509ecb000000b0049dec5d28b4mr1187168edf.6.1675821415834; Tue, 07 Feb
 2023 17:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20230202014158.19616-1-laoar.shao@gmail.com> <20230202014158.19616-8-laoar.shao@gmail.com>
 <63ddbc69ef50f_6bb1520813@john.notmuch> <CALOAHbDUk7CymPco4s12EdFauFroVBhQM6yNJQzji1D=jmkM5g@mail.gmail.com>
In-Reply-To: <CALOAHbDUk7CymPco4s12EdFauFroVBhQM6yNJQzji1D=jmkM5g@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 7 Feb 2023 17:56:44 -0800
Message-ID: <CAADnVQLe9OVF2xUpsA6buPPRhFuRgPEgk2Mxe8UWPZrhfFAwCw@mail.gmail.com>
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

On Sat, Feb 4, 2023 at 7:56 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Sat, Feb 4, 2023 at 10:01 AM John Fastabend <john.fastabend@gmail.com>=
 wrote:
> >
> > Yafang Shao wrote:
> > > Get htab memory usage from the htab pointers we have allocated. Some
> > > small pointers are ignored as their size are quite small compared wit=
h
> > > the total size.
> > >
> > > The result as follows,
> > > - before this change
> > > 1: hash  name count_map  flags 0x0  <<<< prealloc
> > >         key 16B  value 24B  max_entries 1048576  memlock 41943040B
> > > 2: hash  name count_map  flags 0x1  <<<< non prealloc, fully set
> > >         key 16B  value 24B  max_entries 1048576  memlock 41943040B
> > > 3: hash  name count_map  flags 0x1  <<<< non prealloc, non set
> > >         key 16B  value 24B  max_entries 1048576  memlock 41943040B
> > >
> > > The memlock is always a fixed number whatever it is preallocated or
> > > not, and whatever the allocated elements number is.
> > >
> > > - after this change
> > > 1: hash  name count_map  flags 0x0  <<<< prealloc
> > >         key 16B  value 24B  max_entries 1048576  memlock 109064464B
> > > 2: hash  name count_map  flags 0x1  <<<< non prealloc, fully set
> > >         key 16B  value 24B  max_entries 1048576  memlock 117464320B
> > > 3: hash  name count_map  flags 0x1  <<<< non prealloc, non set
> > >         key 16B  value 24B  max_entries 1048576  memlock 16797952B
> > >
> > > The memlock now is hashtab actually allocated.
> > >
> > > At worst, the difference can be 10x, for example,
> > > - before this change
> > > 4: hash  name count_map  flags 0x0
> > >         key 4B  value 4B  max_entries 1048576  memlock 8388608B
> > >
> > > - after this change
> > > 4: hash  name count_map  flags 0x0
> > >         key 4B  value 4B  max_entries 1048576  memlock 83898640B
> > >
> >
> > This walks the entire map and buckets to get the size? Inside a
> > rcu critical section as well :/ it seems.
> >
>
> No, it doesn't walk the entire map and buckets, but just gets one
> random element.
> So it won't be a problem to do it inside a rcu critical section.
>
> > What am I missing, if you know how many elements are added (which
> > you can track on map updates) how come we can't just calculate the
> > memory size directly from this?
> >
>
> It is less accurate and hard to understand. Take non-preallocated
> percpu hashtab for example,
> The size can be calculated as follows,
>     key_size =3D round_up(htab->map.key_size, 8)=EF=BC=9B
>     value_size =3D round_up(htab->map.value_size, 8);
>     pcpu_meta_size =3D sizeof(struct llist_node) + sizeof(void *);
>     usage =3D ((value_size * num_possible_cpus() +\
>                     pcpu_meta_size + key_size) * max_entries
>
> That is quite unfriendly to the newbies, and may be error-prone.

Please do that instead.
map_mem_usage callback is a no go as I mentioned earlier.

> Furthermore, it is less accurate because there is underlying memory
> allocation in the MM subsystem.
> Now we can get a more accurate usage with little overhead. Why not do it?

because htab_mem_usage() is not maintainable long term.
100% accuracy is a non-goal.
