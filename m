Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD2468AE2D
	for <lists+bpf@lfdr.de>; Sun,  5 Feb 2023 04:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjBEDz7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Feb 2023 22:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjBEDz6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Feb 2023 22:55:58 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B2D24125
        for <bpf@vger.kernel.org>; Sat,  4 Feb 2023 19:55:57 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id h24so9684213qta.12
        for <bpf@vger.kernel.org>; Sat, 04 Feb 2023 19:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNB7l69G5EVamMMwD0y1T6jxH8qZN4tcziNc44xXMCQ=;
        b=XAEacJ2On/XjzYCIN7d/BXM4IDi7UX11lCS0M+fk3v0oVOu8FPTFeWHzQ0pk6iQMkq
         CU26rqpkywfaaf01hw4xlng4lk3oZkfBEyEi5zhUWuDDD/YRBflmNztFeWXS0DPRqfqn
         YFxaA/YfFmgGxdh5P7rsPB32yVUZ4u4K4aHBeVfT+pwUNybXFPesiQv7kYR77qdfIZG4
         s6BoRPzMdVSC2Iy10izwvAbhHF1VpuyHoIl8PgZeThvjgItClrGCEW4+9OcHbH9xev2I
         bgB3keeYjOsZg11SqB/uiI7OBLj14gm++BXiLm51PHkBnp9t44rhJ0XHxiVSr0fCeB0H
         B8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNB7l69G5EVamMMwD0y1T6jxH8qZN4tcziNc44xXMCQ=;
        b=UgD/KgzbfMSVpDU9ae0mgOcYrNHencxdEQuDTn0jUMtY6Thvl2S9qgqqSRSBHVEX3a
         Rt2Y6ZrEBitD0DKDDhHTODLie0lsU+WaFWQ0XAY9oZJ9ZOOhf4DL0jX2Jht8vJHKvv+r
         kGcyiP+C2+RaxriETEv6WAM0qPd4h09R6rA0R9e+j/FrJZqSyTDDgBPFCGayNSqj5uCY
         N2KH1fde9f4jcRzKL9swn3WhS0BJzN2A5Jq2JPaHpjOdfPnc/OQX/JAHrrh/6RVfhBuB
         YfrAi1oOrKz2gQYGeH0o82yWpwV4TTkgKTmWcFtyaHj9N5yrae2L1aaqkoyxU8hB1ogL
         ybSg==
X-Gm-Message-State: AO0yUKVAlQWfo/LLYZvHk/ihVkA0/BaiLtU+MfcQTxbrjA8rlCujpbHL
        U6AULk7dpN6ote9L24RwcPGT5SbrWvMWNpGApoY=
X-Google-Smtp-Source: AK7set/IL926C9dc4nDRWsDCvzI/WMJNRgkMW8R5SV33JrNMeAh5vKZJReFp93RP25S5KXBq3G98wlyNvnNwwvh9Xyg=
X-Received: by 2002:ac8:5fd2:0:b0:3b9:b148:b734 with SMTP id
 k18-20020ac85fd2000000b003b9b148b734mr1893028qta.65.1675569356625; Sat, 04
 Feb 2023 19:55:56 -0800 (PST)
MIME-Version: 1.0
References: <20230202014158.19616-1-laoar.shao@gmail.com> <20230202014158.19616-8-laoar.shao@gmail.com>
 <63ddbc69ef50f_6bb1520813@john.notmuch>
In-Reply-To: <63ddbc69ef50f_6bb1520813@john.notmuch>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 5 Feb 2023 11:55:20 +0800
Message-ID: <CALOAHbDUk7CymPco4s12EdFauFroVBhQM6yNJQzji1D=jmkM5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/7] bpf: hashtab memory usage
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, dennis@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, vbabka@suse.cz, urezki@gmail.com,
        linux-mm@kvack.org, bpf@vger.kernel.org
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

On Sat, Feb 4, 2023 at 10:01 AM John Fastabend <john.fastabend@gmail.com> w=
rote:
>
> Yafang Shao wrote:
> > Get htab memory usage from the htab pointers we have allocated. Some
> > small pointers are ignored as their size are quite small compared with
> > the total size.
> >
> > The result as follows,
> > - before this change
> > 1: hash  name count_map  flags 0x0  <<<< prealloc
> >         key 16B  value 24B  max_entries 1048576  memlock 41943040B
> > 2: hash  name count_map  flags 0x1  <<<< non prealloc, fully set
> >         key 16B  value 24B  max_entries 1048576  memlock 41943040B
> > 3: hash  name count_map  flags 0x1  <<<< non prealloc, non set
> >         key 16B  value 24B  max_entries 1048576  memlock 41943040B
> >
> > The memlock is always a fixed number whatever it is preallocated or
> > not, and whatever the allocated elements number is.
> >
> > - after this change
> > 1: hash  name count_map  flags 0x0  <<<< prealloc
> >         key 16B  value 24B  max_entries 1048576  memlock 109064464B
> > 2: hash  name count_map  flags 0x1  <<<< non prealloc, fully set
> >         key 16B  value 24B  max_entries 1048576  memlock 117464320B
> > 3: hash  name count_map  flags 0x1  <<<< non prealloc, non set
> >         key 16B  value 24B  max_entries 1048576  memlock 16797952B
> >
> > The memlock now is hashtab actually allocated.
> >
> > At worst, the difference can be 10x, for example,
> > - before this change
> > 4: hash  name count_map  flags 0x0
> >         key 4B  value 4B  max_entries 1048576  memlock 8388608B
> >
> > - after this change
> > 4: hash  name count_map  flags 0x0
> >         key 4B  value 4B  max_entries 1048576  memlock 83898640B
> >
>
> This walks the entire map and buckets to get the size? Inside a
> rcu critical section as well :/ it seems.
>

No, it doesn't walk the entire map and buckets, but just gets one
random element.
So it won't be a problem to do it inside a rcu critical section.

> What am I missing, if you know how many elements are added (which
> you can track on map updates) how come we can't just calculate the
> memory size directly from this?
>

It is less accurate and hard to understand. Take non-preallocated
percpu hashtab for example,
The size can be calculated as follows,
    key_size =3D round_up(htab->map.key_size, 8)=EF=BC=9B
    value_size =3D round_up(htab->map.value_size, 8);
    pcpu_meta_size =3D sizeof(struct llist_node) + sizeof(void *);
    usage =3D ((value_size * num_possible_cpus() +\
                    pcpu_meta_size + key_size) * max_entries

That is quite unfriendly to the newbies, and may be error-prone.

Furthermore, it is less accurate because there is underlying memory
allocation in the MM subsystem.
Now we can get a more accurate usage with little overhead. Why not do it?

--=20
Regards
Yafang
