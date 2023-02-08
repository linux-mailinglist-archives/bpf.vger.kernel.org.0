Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDBE68E69F
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 04:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBHDeb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 22:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBHDea (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 22:34:30 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590541EBD4
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 19:34:29 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id h24so19559160qtr.0
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 19:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8njTTPO7Ws6+B27NcFo6Rw0G6yrzVzCpbkk7pqzSOtU=;
        b=e9tTj1YueTFbNfCC6l0mVGcAVZZJdqbF+41dFz34/E+NoTb7u3/kG43eISG+WwxGyN
         uQ8kBvaDdCqkEnCMqoTGwzsDYTP9qFZTSysTYHP3KtnAgwa/vmInmKpzt2COSHCzV+I0
         4Lqvd66vQHaVqhxHAQKI0quFrcJjMSOow92IAED49//Bp94f/vYKN+rdBiSevYD0Xfc6
         xVaA3hCUTlwd33JtYp/kN6Bejn3iX+ANqfqAlzz3rWH3o0pcg6p6XTj5+MdDEpPWvjgL
         Sbd3ClPGZYQCL4fZvy3wYc8/gooCwHc1P3lZzgpPL+BCh9V0Lr/9ylgIPlfdK0V+G+en
         Xn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8njTTPO7Ws6+B27NcFo6Rw0G6yrzVzCpbkk7pqzSOtU=;
        b=HXgDTO4iQlEDCwUkJ/3rXzm7SlElMl7DvEd1PII4olrnIWK/6zrTZ6JWIoqh0cRASQ
         Nais2uQvgpgcZ9FsvmM2Z8KvqgKYF4ZMVW8TUUskg/zKX/v7LsHYzigm0Bf8sekYHs/k
         klNMXRzjAA/llok8yb3k8IpVoOhzJq5BlgDy8dDyfMj+EIq4AC42jee7rA5gqVL4muSL
         9MnJ1IMxYk1fBK9PMmWf1B4/HwpI2VaO0dPQR7lSKRR8wf2lNXv0boBhrsawuopygb3J
         lQ2WFChI7N1wYcAX8FqrRMli72xc56FgVeBMU5hh1UAqoAEUhJt8rELEeQZ6O88vEC3j
         UjSg==
X-Gm-Message-State: AO0yUKXbWs34XSRx0/OyQuH1s9t/WC6gTcA/3Z+L+nUmsuZ3zcqfWcue
        il2uIRTd6y7iNHvm8o9UFT/mIyRhBpeoaxUHp6vYbZlAIpl+7w==
X-Google-Smtp-Source: AK7set/uxt6BzYh1nLwg699CHLl8mnuKj1YXOd7omWQz1IygKsIuElPndBjwEfIpzOXiUkMcUFzsq92XNCL2dfD5WAk=
X-Received: by 2002:a05:622a:2c7:b0:3ba:240b:99ad with SMTP id
 a7-20020a05622a02c700b003ba240b99admr1166819qtx.65.1675827268424; Tue, 07 Feb
 2023 19:34:28 -0800 (PST)
MIME-Version: 1.0
References: <20230202014158.19616-1-laoar.shao@gmail.com> <20230202014158.19616-8-laoar.shao@gmail.com>
 <63ddbc69ef50f_6bb1520813@john.notmuch> <CALOAHbDUk7CymPco4s12EdFauFroVBhQM6yNJQzji1D=jmkM5g@mail.gmail.com>
 <CAADnVQLe9OVF2xUpsA6buPPRhFuRgPEgk2Mxe8UWPZrhfFAwCw@mail.gmail.com>
In-Reply-To: <CAADnVQLe9OVF2xUpsA6buPPRhFuRgPEgk2Mxe8UWPZrhfFAwCw@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 8 Feb 2023 11:33:52 +0800
Message-ID: <CALOAHbCzCprMhRHSBQ5NC8b=4DuuUT=H8Zx+3Eb1aTcb_XgEkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/7] bpf: hashtab memory usage
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Wed, Feb 8, 2023 at 9:56 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Feb 4, 2023 at 7:56 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > On Sat, Feb 4, 2023 at 10:01 AM John Fastabend <john.fastabend@gmail.co=
m> wrote:
> > >
> > > Yafang Shao wrote:
> > > > Get htab memory usage from the htab pointers we have allocated. Som=
e
> > > > small pointers are ignored as their size are quite small compared w=
ith
> > > > the total size.
> > > >
> > > > The result as follows,
> > > > - before this change
> > > > 1: hash  name count_map  flags 0x0  <<<< prealloc
> > > >         key 16B  value 24B  max_entries 1048576  memlock 41943040B
> > > > 2: hash  name count_map  flags 0x1  <<<< non prealloc, fully set
> > > >         key 16B  value 24B  max_entries 1048576  memlock 41943040B
> > > > 3: hash  name count_map  flags 0x1  <<<< non prealloc, non set
> > > >         key 16B  value 24B  max_entries 1048576  memlock 41943040B
> > > >
> > > > The memlock is always a fixed number whatever it is preallocated or
> > > > not, and whatever the allocated elements number is.
> > > >
> > > > - after this change
> > > > 1: hash  name count_map  flags 0x0  <<<< prealloc
> > > >         key 16B  value 24B  max_entries 1048576  memlock 109064464B
> > > > 2: hash  name count_map  flags 0x1  <<<< non prealloc, fully set
> > > >         key 16B  value 24B  max_entries 1048576  memlock 117464320B
> > > > 3: hash  name count_map  flags 0x1  <<<< non prealloc, non set
> > > >         key 16B  value 24B  max_entries 1048576  memlock 16797952B
> > > >
> > > > The memlock now is hashtab actually allocated.
> > > >
> > > > At worst, the difference can be 10x, for example,
> > > > - before this change
> > > > 4: hash  name count_map  flags 0x0
> > > >         key 4B  value 4B  max_entries 1048576  memlock 8388608B
> > > >
> > > > - after this change
> > > > 4: hash  name count_map  flags 0x0
> > > >         key 4B  value 4B  max_entries 1048576  memlock 83898640B
> > > >
> > >
> > > This walks the entire map and buckets to get the size? Inside a
> > > rcu critical section as well :/ it seems.
> > >
> >
> > No, it doesn't walk the entire map and buckets, but just gets one
> > random element.
> > So it won't be a problem to do it inside a rcu critical section.
> >
> > > What am I missing, if you know how many elements are added (which
> > > you can track on map updates) how come we can't just calculate the
> > > memory size directly from this?
> > >
> >
> > It is less accurate and hard to understand. Take non-preallocated
> > percpu hashtab for example,
> > The size can be calculated as follows,
> >     key_size =3D round_up(htab->map.key_size, 8)=EF=BC=9B
> >     value_size =3D round_up(htab->map.value_size, 8);
> >     pcpu_meta_size =3D sizeof(struct llist_node) + sizeof(void *);
> >     usage =3D ((value_size * num_possible_cpus() +\
> >                     pcpu_meta_size + key_size) * max_entries
> >
> > That is quite unfriendly to the newbies, and may be error-prone.
>
> Please do that instead.

I can do it as you suggested, but it seems we shouldn't keep all
estimates in one place. Because ...

> map_mem_usage callback is a no go as I mentioned earlier.

...we have to introduce the map_mem_usage callback. Take the lpm_trie
for example, its usage is
usage =3D (sizeof(struct lpm_trie_node) + trie->data_size) * trie->n_entrie=
s;

I don't think we want  to declare struct lpm_trie_node in kernel/bpf/syscal=
l.c.
WDYT ?

>
> > Furthermore, it is less accurate because there is underlying memory
> > allocation in the MM subsystem.
> > Now we can get a more accurate usage with little overhead. Why not do i=
t?
>
> because htab_mem_usage() is not maintainable long term.
> 100% accuracy is a non-goal.

htab_mem_usage() gives us an option to continue to make it more
accurate with considerable overhead.
But I won't insist on it if you think we don't need to make it more accurat=
e.

--=20
Regards
Yafang
