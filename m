Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B6F68DFF5
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 19:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjBGS01 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 13:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjBGS0O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 13:26:14 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA12ABBAE
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 10:25:52 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id h24so17761241qta.12
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 10:25:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxF3m0wkFWNxXYpyLaviTEWCnYsxyIrprcvTzUEetXk=;
        b=IX6CKKhuGVQsw1/Gpjuc1ROL65WRFdFzqfo1wREHhFDXBdsA4JU/MYKCLjx8XsFELr
         3T1gYoQbGBQPyGAJBqO+PlN36B4IcGKnya+LxqbCTPeoSNlmvyOXNUJFCN0Ih1PXeyB3
         xH45eJB9G1/mMAM5iG/xg9kG7dFDQA0P8+zDqtZkqf1HLRvkk5aOyOoZYrljIOvgs954
         TLivqWtu33uCD8BJpHIefdcXW0JVHjKhCnL+Jk7qSMg20zVMWDcpxNmQ1u542KJIrplb
         LdWX+vdiq+JC+laBGaO29K/WL9unKuRffJy+xCBTyG0Av/4M88qn1Q27oKOZxh0aGMWc
         3x6A==
X-Gm-Message-State: AO0yUKXWj4CYvpJjO5PdNMRFbic59C4alv0BnJ3V8FpvzQ6zYMzH2hxM
        ML6GJUf0+N3UIk7mgL2TpLOo/EFeTkxfEA==
X-Google-Smtp-Source: AK7set9/MRGCE/Sa2f2mcdSR5X2TZqzWvhCo0TofhH/BE0ydmd1oEweqyv8yFdQAu8GeV04uGu+sNA==
X-Received: by 2002:a05:622a:1a03:b0:3b8:2dac:b5e1 with SMTP id f3-20020a05622a1a0300b003b82dacb5e1mr6692127qtb.37.1675794311931;
        Tue, 07 Feb 2023 10:25:11 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:3f8])
        by smtp.gmail.com with ESMTPSA id n3-20020ac86743000000b003b80a69d353sm9785921qtp.49.2023.02.07.10.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:25:11 -0800 (PST)
Date:   Tue, 7 Feb 2023 12:25:16 -0600
From:   David Vernet <void@manifault.com>
To:     Hao Luo <haoluo@google.com>
Cc:     lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: Mapping local-storage maps into user space
Message-ID: <Y+KXjKK+ncbket1C@maniforge.lan>
References: <Y9LQVU2uz9SzYARP@maniforge>
 <CA+khW7iLVbK-QSgfR6OwUb_Hzs__=qsH6ho8gKf2vVqkp6Z9LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+khW7iLVbK-QSgfR6OwUb_Hzs__=qsH6ho8gKf2vVqkp6Z9LQ@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 26, 2023 at 04:42:20PM -0800, Hao Luo wrote:
> On Thu, Jan 26, 2023 at 11:11 AM David Vernet <void@manifault.com> wrote:
> >
> > Hi everyone,
> >
> > Another proposal from me for LSF/MM/BPF, and the last one for the time
> > being. I'd like to discuss enabling local-storage maps (e.g.
> > BPF_MAP_TYPE_TASK_STORAGE and BPF_MAP_TYPE_CGRP_STORAGE) to be r/o
> > mapped directly into user space. This would allow for quick lookups of
> > per-object state from user space, similar to how we allow it for
> > BPF_MAP_TYPE_ARRAY, without having to do something like either of the
> > following:
> >
> > - Allocating a statically sized BPF_MAP_TYPE_ARRAY which is >= the # of
> >   possible local-storage elements, which is likely wasteful in terms of
> >   memory, and which isn't easy to iterate over.
> >
> > - Use something like https://docs.kernel.org/bpf/bpf_iterators.html to
> >   iterate over tasks or cgroups, and collect information for each which
> >   is then dumped to user space. This would probably work, but it's not
> >   terribly performant in that it requires copying memory, trapping into
> >   the kernel, and full iteration even when it's only necessary to look
> >   up e.g. a single element.
> >
> > Designing and implementing this would be pretty non-trivial. We'd have
> > to probably do a few things:
> >
> > 1. Write an allocator that dynamically allocates statically sized
> >    local-storage entries for local-storage maps, and populates them into
> >    pages which are mapped into user space.
> >
> > 2. Come up with some idr-like mechanism for mapping a local-storage
> >    object to an index into the mapping. For example, mapping a task with
> >    global pid 12345 to BPF_MAP_TYPE_TASK_STORAGE index 5, and providing
> >    ergonomic and safe ways to update these entries in the kernel and
> >    communicate them to user space.
> >
> > 3. Related to point 1 above, come up with some way to dynamically extend
> >    the user space mapping as more local-storage elements are added. We
> >    could potentially reserve a statically sized VA range and map all
> >    unused VA pages to the zero page, or instead possibly just leave them
> >    unmapped until they're actually needed.
> >
> > There are a lot of open questions, but I think it could be very useful
> > if we can make it work. Let me know what you all think.
> >
> 
> Hi David,
> 
> I remember, I had a similar idea and played with it last year. I don't
> recall why I needed that feature back then, probably looking for ways
> to pass per-task information from userspace and read it from within
> BPF. I sent an RFC to the mailing list [1]. You could take a look, see
> whether it is of help to you.
> 
> [1] https://www.spinics.net/lists/bpf/msg57565.html

Hi Hao,

Thanks for sharing that thread, it's great to see that there is already
interest from other folks. It looks like the main use case you were
trying to enable was passing an fd from user space to a TLS element for
the current task, which the BPF prog would then pass to helpers that
take an fd. There was a need specifically to enable this for
unprivileged programs which can't e.g.  use bpf_prog_test_run to set the
fd. Alexei proposed an alternative option in [0] which it seemed like
everyone was on-board with.

[0]: https://lore.kernel.org/bpf/20220329232956.gbsr65jdbe4lw2m6@ast-mbp/

The use-case I was envisioning is a bit different in a couple ways:

- I was anticipating that user space could map an entire task (or
  cgroup, sk, etc) local-storage map, rather than a task only being able
  to mmap its own TLS entry. I think this approach would be more
  generalizable for other local-storage map types like cgroup and sk,
  and would also be useful for ghOSt, sched_ext, etc. It could also
  serve as a higher-performance alternative to bpf-iter for user space
  applications that don't want to have to trap into the kernel.

- I was envisioning this being read-only, though I expect it would be
  possible to enable writeable mappings as well. The tricky part here is
  that we will eventually certainly want to enable referenced kptrs in
  local-storage maps, so it's not always safe to let user space mutate
  local-storage entries.

- I'd like to avoid allocating an entire page for each entry. Most of
  the local-storage entries that I've used are far smaller than a page,
  so it seems prudent to have some kind of allocator that we could use
  to pack multiple entries into a single page. This would also have the
  benefit of potentially allowing an O(1) lookup for a map entry as
  well, rather than requiring us to do an O(n) iteration over a task's
  local storage entries when doing a lookup from a program. This is a
  super hand-wavey claim though -- a lot more details and validation
  need to be ironed out.

What do you think?

Thanks,
David
