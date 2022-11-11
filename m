Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC585626384
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 22:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiKKVZC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 16:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbiKKVYl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 16:24:41 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAAD60E8E
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 13:24:32 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id s10so4452179ioa.5
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 13:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GvdqHNM6CwkIOWtuhSQjkVWK+nxaNIJZKTfWzykDSMw=;
        b=sUJGhwCW2YG6ZCcEM/kqHdYoTRyb3wXM6iCDKoCbzE7Uxh8UsATTcZ82RHfb1a4CZR
         iTg44X+M5WGv7OZUNzWFsR6ishkp4ydQqpiM3nemzbXcOu/JBkSpL/O3JgF1Bb/LW62c
         7QTgVI2E4tt83IEG7iE8hhzZ4BLL/AmmVpiS+SPrwQnPRSHJqkQpy16cSv1Zmy6vRWYt
         nvqSWnJAwtEWMiE1D24JQjJxCdMPuzFlzibvf9YDqd5ABKlkf2W907KlpoKHvf8g7mA+
         0726PFjgHvjsn/SvtiUu95EWTdd6qVEkvOHKANl3O+E2IsuPa4fvYDecUagGT5oQV+Lg
         xyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvdqHNM6CwkIOWtuhSQjkVWK+nxaNIJZKTfWzykDSMw=;
        b=2naaVFITiDwfjpKI4GMiUbDxopnnpsOp+ZkwVjWKZPIH4QxmMwZP/cVu/5g5UU85CM
         w9ukLYREss5WbVCou3ynFU1HIkbA7hKpXMBQNXGNZ6CnjXx1sAVCoNKM2j7MM6/pB4t/
         R634etS2P9g8Stb1pSTxHAYtGPMaYcgrBMeX9Lh7FQEsR4h/C8E3w4zhL0Eywu7tqUJP
         qZDzLf7Kixhy7YwXvsDYR7gaw0fsY5vUohjAKzm/r1RsSb/EFgO/Vd7YlZXdMtniFzWv
         ioo2XJVaKmeX1bDjTLeY+Iz+eYE7sIOsf1qPoe0C2KRPYy0dQ12KkRaMlqQZxlyTe33G
         TR5Q==
X-Gm-Message-State: ANoB5plWnIcoLfzuxRSLkdS7LhEGp3eKXoR3QFP4R04WR2genz7vgYjH
        VGmfH9bURspDegKpt4wmKtFPi6+Ka4EWYAYAbsLZnA==
X-Google-Smtp-Source: AA0mqf5IA93xQyFFpAy3c6trjBPr1kkeb4eX7BVOIAXTrytcycK5JItrLkl1cMCI+gSZAvFFAk6NAaKKPDreE7pvkcU=
X-Received: by 2002:a6b:3bcb:0:b0:6c0:db74:7be1 with SMTP id
 i194-20020a6b3bcb000000b006c0db747be1mr1750767ioa.92.1668201871881; Fri, 11
 Nov 2022 13:24:31 -0800 (PST)
MIME-Version: 1.0
References: <20221111092642.2333724-1-houtao@huaweicloud.com>
 <20221111092642.2333724-3-houtao@huaweicloud.com> <Y26MTygDw2PUQlFz@google.com>
 <CAEf4Bza4yPEW2wOFAFMC8nwEEqVtD-jBD2T52CQ7vJpCUWCvmA@mail.gmail.com>
In-Reply-To: <CAEf4Bza4yPEW2wOFAFMC8nwEEqVtD-jBD2T52CQ7vJpCUWCvmA@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 11 Nov 2022 13:24:20 -0800
Message-ID: <CAKH8qBujeN17+B=CjLGHDG5Mr3bn9ZNYN9x0BLP6YVrtvA5oaw@mail.gmail.com>
Subject: Re: [PATCH bpf 2/4] libbpf: Handle size overflow for ringbuf mmap
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
        Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 11, 2022 at 12:56 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Nov 11, 2022 at 9:54 AM <sdf@google.com> wrote:
> >
> > On 11/11, Hou Tao wrote:
> > > From: Hou Tao <houtao1@huawei.com>
> >
> > > The maximum size of ringbuf is 2GB on x86-64 host, so 2 * max_entries
> > > will overflow u32 when mapping producer page and data pages. Only
> > > casting max_entries to size_t is not enough, because for 32-bits
> > > application on 64-bits kernel the size of read-only mmap region
> > > also could overflow size_t.
> >
> > > So fixing it by casting the size of read-only mmap region into a __u64
> > > and checking whether or not there will be overflow during mmap.
> >
> > > Fixes: bf99c936f947 ("libbpf: Add BPF ring buffer support")
> > > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > > ---
> > >   tools/lib/bpf/ringbuf.c | 11 +++++++++--
> > >   1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > > diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > > index d285171d4b69..c4bdc88af672 100644
> > > --- a/tools/lib/bpf/ringbuf.c
> > > +++ b/tools/lib/bpf/ringbuf.c
> > > @@ -77,6 +77,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
> > >       __u32 len = sizeof(info);
> > >       struct epoll_event *e;
> > >       struct ring *r;
> > > +     __u64 ro_size;
>
> I found ro_size quite a confusing name, let's call it mmap_sz?
>
> > >       void *tmp;
> > >       int err;
> >
> > > @@ -129,8 +130,14 @@ int ring_buffer__add(struct ring_buffer *rb, int
> > > map_fd,
> > >        * data size to allow simple reading of samples that wrap around the
> > >        * end of a ring buffer. See kernel implementation for details.
> > >        * */
> > > -     tmp = mmap(NULL, rb->page_size + 2 * info.max_entries, PROT_READ,
> > > -                MAP_SHARED, map_fd, rb->page_size);
> > > +     ro_size = rb->page_size + 2 * (__u64)info.max_entries;
> >
> > [..]
> >
> > > +     if (ro_size != (__u64)(size_t)ro_size) {
> > > +             pr_warn("ringbuf: ring buffer size (%u) is too big\n",
> > > +                     info.max_entries);
> > > +             return libbpf_err(-E2BIG);
> > > +     }
> >
> > Why do we need this check at all? IIUC, the problem is that the expression
> > "rb->page_size + 2 * info.max_entries" is evaluated as u32 and can
> > overflow. So why doing this part only isn't enough?
> >
> > size_t mmap_size = rb->page_size + 2 * (size_t)info.max_entries;
> > mmap(NULL, mmap_size, PROT_READ, MAP_SHARED, map_fd, ...);
> >
> > sizeof(size_t) should be 8, so no overflow is possible?
>
> not on 32-bit arches, presumably?

Good point, he even mentions it in the description, I can't read apparently :-/

"Only casting max_entries to size_t is not enough"

>
>
> >
> >
> > > +     tmp = mmap(NULL, (size_t)ro_size, PROT_READ, MAP_SHARED, map_fd,
> > > +                rb->page_size);
>
> should we split this mmap into two mmaps -- one for producer_pos page,
> another for data area. That will presumably allow to mmap ringbuf with
> max_entries = 1GB?
>
> > >       if (tmp == MAP_FAILED) {
> > >               err = -errno;
> > >               ringbuf_unmap_ring(rb, r);
> > > --
> > > 2.29.2
> >
