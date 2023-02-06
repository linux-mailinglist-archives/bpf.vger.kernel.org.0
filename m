Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F6A68BC16
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 12:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBFLxY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 06:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBFLxX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 06:53:23 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F4612F29
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 03:53:22 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id b7so2796382qvo.6
        for <bpf@vger.kernel.org>; Mon, 06 Feb 2023 03:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WpOlzlgprXcBwzGCC3ZZLrYR97mq4YuOjOiXOKGzquY=;
        b=jTk8Ff7B/f0cUIwybEahiD0B53JzmMiPAESl+iqnoN2oJbQUsoCKwyFUdfntCHN1Tq
         RKlSnBIWljYqtCMddu1MfamKAz50vJAh4XxRBgY6BLzVwvXy0BZltifH5NDUAwrcl+1a
         KOXJ8QtvVSVAtVBxRkDYLajTGYd4JKe40twh0FJcVD+atIriki0tSUDbVVn3620UflNc
         hGAOXRWZCwOi6kStCYUyUk96yTb6EsU3cbXdAR/ccLyzZAGiGqJLjNJ8benii3BiIk80
         14Y7N7Vx589pYhsJ6hE4wILwW3aMUXk62LftPQNX4cEjpSYyMabRCOKqX6CPoDnFe3i5
         TH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WpOlzlgprXcBwzGCC3ZZLrYR97mq4YuOjOiXOKGzquY=;
        b=v//qwUG9Wwz4sRrce/B0ABzSXHzYxayNOdkOS20Hasq9ux/5nfA5FqPs3aEcFxFrTH
         qtNGqewdbsIJZ0A+8R+gNLOWEvL4tgdTaPc+k8ffVxW/2TzOylJbRkesgzBErXSwX10m
         tcH4iZcZucoRCOVsRxiKgwh31djXHJ6lOI12ZvRLfRkS9e/X8MT+F+vJZcYp3eE4I1pZ
         Ful4z4esibU9jMIEQ8E8rcNrGTSAATR+2cgDH28wLUm71kIMR09wzgdyjNLBNjqRTpMS
         fnUVuFzrXuzdTrENBojGdwG9A5WcnVwN005Tt84hyK0qiHAEbdeqYcQ4N5VpEi81YqXK
         YdwQ==
X-Gm-Message-State: AO0yUKVu9rcnZSQCzcAqEsemY6y2FWWg5iAUBihYnf3NizY132rKCFg/
        kTP1yhg4ACI8pEcOx4+43hq8U8DMN7w+yWmLt0VtT3oF6k8S7w==
X-Google-Smtp-Source: AK7set/qqvbkHL+8abukp/KqPpIpfPhfODhJgn087gy4RZ1tmJw+8wgEKfnzxP7KHhivFpyDl9AZY5So/eb0/7ex3SA=
X-Received: by 2002:a0c:f40f:0:b0:56a:eed2:704f with SMTP id
 h15-20020a0cf40f000000b0056aeed2704fmr540110qvl.5.1675684401966; Mon, 06 Feb
 2023 03:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20230202014158.19616-1-laoar.shao@gmail.com> <20230202014158.19616-8-laoar.shao@gmail.com>
 <Y+AqPJSBnAN830p3@pop-os.localdomain>
In-Reply-To: <Y+AqPJSBnAN830p3@pop-os.localdomain>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 6 Feb 2023 19:52:45 +0800
Message-ID: <CALOAHbAT46+joi2Px2c9ACmtkZ6OPjf64uBpCB9ABF7CPzW19g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/7] bpf: hashtab memory usage
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        urezki@gmail.com, linux-mm@kvack.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 6, 2023 at 6:14 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> On Thu, Feb 02, 2023 at 01:41:58AM +0000, Yafang Shao wrote:
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
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/bpf/hashtab.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>
> What about other maps like regular array map?
>

I haven't finished the work to support all bpf maps.

Most of the maps have fixed entries, so we can get the usage directly
from an map pointer or get the element size and then calculate it, for
example,
- arraymap usage
  size = kvsize(array);
- percpu arraymap usage
  size = kvsize(array);
  size += percpu_size(array->pptrs[0]) * array->map.max_entries;

But there's special case like cgroup_storage, the max_entries of which
is 0, for example,
122: cgroup_storage  flags 0x0
        key 16B  value 8B  max_entries 0  memlock 0B

For this case, we should calculate the count of entries first.

-- 
Regards
Yafang
