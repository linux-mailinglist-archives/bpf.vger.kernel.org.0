Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C998C68F09E
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 15:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjBHOW6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 09:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBHOW5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 09:22:57 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1691B11E8A
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 06:22:54 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id j9so11501851qvt.0
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 06:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6oF9j80LVBPF/KMmx1PXi5SmA7WM0UIQRKbeBKyQgI=;
        b=E89lUuqeLZS3ADFJnvoOQl6yUCAWs+K5M9M4EGkQuTzbQTD6xGf7ip58voQlIaA6ci
         +uPoV/BJKVDRaliJIAorRILur/DjVSStTvhauGDXmThLZDpj6oLqp/o6Z2GMcU3wCKI+
         vexE9gWqCJ36u+IWSN9Eo0QwM04flZaqZZwPYZIBhiDOEiNuTFvHLv7QD+jfAiz+1MLy
         xDQjS1Fv1i14g/PSVYvsWt2pCCJS7+PQ0909gkv1sQ/IQZW1SRA/OwWVIhPsYwFa/C8h
         44Rsr7t83hEASpqYoSiC3UYoeuONieIxLkoIYjLv+QNmuiXJWCXZjpzgyYhbWBu50NbK
         A6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6oF9j80LVBPF/KMmx1PXi5SmA7WM0UIQRKbeBKyQgI=;
        b=nVcEPwDFthaZLoc4Bm7VE+CcSTOK/9fFhx1oFNtmdpegBHVdQ7fF6DGADbSEHJUGok
         JZPNJH4sOh9iODLBnbYr86cn06UfMvrewPplFqEYZarrfmnNpZ+Op34EwB3jy1TLauRU
         hq47f77NNe53faVGsHB7zkBed7WVG83xWk9DrLf/f6DgNxP6ds4H+CtKxiNyK+Ahuv9I
         lDcTi0YatnzvJKLghlZxlYkTW+2pX6LhvfyIvzwvSeLb/wB7zTwRBTIKP47QQRfSPghV
         I/wyLCJAkBkyLh7dS2EV2sdI+YLx7W0R+ovRtGQWMUS/cHmxFLoZLR3vK7eHqvTMVmWz
         sGdQ==
X-Gm-Message-State: AO0yUKXHZ0BKJMnHbU3C+MgLQZXtkhu1nU2Y++s78oT6mNT33iN0qPBx
        cmqnvVd2a4QxrgDZ1h+T06n9e1l6pv3aanckp7g=
X-Google-Smtp-Source: AK7set9pEr6SGniaXDs+fgtB00D1pgrh0Y4TXWMUSNUg1OrEr8NpOfoqYNccPZdFN2vc0DBM1tg3WEqikFFyHNoiA/o=
X-Received: by 2002:a0c:aa0d:0:b0:537:6e55:eeb7 with SMTP id
 d13-20020a0caa0d000000b005376e55eeb7mr720491qvb.66.1675866173212; Wed, 08 Feb
 2023 06:22:53 -0800 (PST)
MIME-Version: 1.0
References: <20230202014158.19616-1-laoar.shao@gmail.com> <20230202014158.19616-8-laoar.shao@gmail.com>
 <63ddbc69ef50f_6bb1520813@john.notmuch> <CALOAHbDUk7CymPco4s12EdFauFroVBhQM6yNJQzji1D=jmkM5g@mail.gmail.com>
 <CAADnVQLe9OVF2xUpsA6buPPRhFuRgPEgk2Mxe8UWPZrhfFAwCw@mail.gmail.com>
 <CALOAHbCzCprMhRHSBQ5NC8b=4DuuUT=H8Zx+3Eb1aTcb_XgEkA@mail.gmail.com> <CAADnVQLT4p0m5Z=WhSEJv5s3x_o8KZZyd48zEKabAfj7kHTT2A@mail.gmail.com>
In-Reply-To: <CAADnVQLT4p0m5Z=WhSEJv5s3x_o8KZZyd48zEKabAfj7kHTT2A@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 8 Feb 2023 22:22:17 +0800
Message-ID: <CALOAHbBfev35GEq+r8_HCP1g6+p0bhad0t+02pir811FyqGccw@mail.gmail.com>
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

On Wed, Feb 8, 2023 at 12:29 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 7, 2023 at 7:34 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > On Wed, Feb 8, 2023 at 9:56 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sat, Feb 4, 2023 at 7:56 PM Yafang Shao <laoar.shao@gmail.com> wro=
te:
> > > >
> > > > On Sat, Feb 4, 2023 at 10:01 AM John Fastabend <john.fastabend@gmai=
l.com> wrote:
> > > > >
> > > > > Yafang Shao wrote:
> > > > > > Get htab memory usage from the htab pointers we have allocated.=
 Some
> > > > > > small pointers are ignored as their size are quite small compar=
ed with
> > > > > > the total size.
> > > > > >
> > > > > > The result as follows,
> > > > > > - before this change
> > > > > > 1: hash  name count_map  flags 0x0  <<<< prealloc
> > > > > >         key 16B  value 24B  max_entries 1048576  memlock 419430=
40B
> > > > > > 2: hash  name count_map  flags 0x1  <<<< non prealloc, fully se=
t
> > > > > >         key 16B  value 24B  max_entries 1048576  memlock 419430=
40B
> > > > > > 3: hash  name count_map  flags 0x1  <<<< non prealloc, non set
> > > > > >         key 16B  value 24B  max_entries 1048576  memlock 419430=
40B
> > > > > >
> > > > > > The memlock is always a fixed number whatever it is preallocate=
d or
> > > > > > not, and whatever the allocated elements number is.
> > > > > >
> > > > > > - after this change
> > > > > > 1: hash  name count_map  flags 0x0  <<<< prealloc
> > > > > >         key 16B  value 24B  max_entries 1048576  memlock 109064=
464B
> > > > > > 2: hash  name count_map  flags 0x1  <<<< non prealloc, fully se=
t
> > > > > >         key 16B  value 24B  max_entries 1048576  memlock 117464=
320B
> > > > > > 3: hash  name count_map  flags 0x1  <<<< non prealloc, non set
> > > > > >         key 16B  value 24B  max_entries 1048576  memlock 167979=
52B
> > > > > >
> > > > > > The memlock now is hashtab actually allocated.
> > > > > >
> > > > > > At worst, the difference can be 10x, for example,
> > > > > > - before this change
> > > > > > 4: hash  name count_map  flags 0x0
> > > > > >         key 4B  value 4B  max_entries 1048576  memlock 8388608B
> > > > > >
> > > > > > - after this change
> > > > > > 4: hash  name count_map  flags 0x0
> > > > > >         key 4B  value 4B  max_entries 1048576  memlock 83898640=
B
> > > > > >
> > > > >
> > > > > This walks the entire map and buckets to get the size? Inside a
> > > > > rcu critical section as well :/ it seems.
> > > > >
> > > >
> > > > No, it doesn't walk the entire map and buckets, but just gets one
> > > > random element.
> > > > So it won't be a problem to do it inside a rcu critical section.
> > > >
> > > > > What am I missing, if you know how many elements are added (which
> > > > > you can track on map updates) how come we can't just calculate th=
e
> > > > > memory size directly from this?
> > > > >
> > > >
> > > > It is less accurate and hard to understand. Take non-preallocated
> > > > percpu hashtab for example,
> > > > The size can be calculated as follows,
> > > >     key_size =3D round_up(htab->map.key_size, 8)=EF=BC=9B
> > > >     value_size =3D round_up(htab->map.value_size, 8);
> > > >     pcpu_meta_size =3D sizeof(struct llist_node) + sizeof(void *);
> > > >     usage =3D ((value_size * num_possible_cpus() +\
> > > >                     pcpu_meta_size + key_size) * max_entries
> > > >
> > > > That is quite unfriendly to the newbies, and may be error-prone.
> > >
> > > Please do that instead.
> >
> > I can do it as you suggested, but it seems we shouldn't keep all
> > estimates in one place. Because ...
> >
> > > map_mem_usage callback is a no go as I mentioned earlier.
> >
> > ...we have to introduce the map_mem_usage callback. Take the lpm_trie
> > for example, its usage is
> > usage =3D (sizeof(struct lpm_trie_node) + trie->data_size) * trie->n_en=
tries;
>
> sizeof(struct lpm_trie_node) + trie->data_size + trie->map.value_size.
>

Thanks for correcting it.

> and it won't count the inner nodes, but _it is ok_.
>
> > I don't think we want  to declare struct lpm_trie_node in kernel/bpf/sy=
scall.c.
> > WDYT ?
>
> Good point. Fine. Let's go with callback, but please keep it
> to a single function without loops like htab_non_prealloc_elems_size()
> and htab_prealloc_elems_size().
>
> Also please implement it for all maps.

Sure, I will do it.

> Doing it just for hash and arguing that every byte of accuracy matters
> while not addressing lpm and other maps doesn't give credibility
> to the accuracy argument.



--=20
Regards
Yafang
