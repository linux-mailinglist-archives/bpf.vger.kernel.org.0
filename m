Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAC95B3B58
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 16:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiIIO6z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 10:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiIIO6w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 10:58:52 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7326138833
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 07:58:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id v16so4564458ejr.10
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=62jFklFu5MUSqSBplWE7qLFZD87yIRraMisa2DYeNNo=;
        b=AfEZ9URQNKMa9UXXsGz1iL3V7PGjZolUKKaDpHHviksqml2xv5GeR3bEO9uk0Zsdcr
         D5AYfbLgIFz6hamWkizrk/qdhsc2vMj9D+DQG9si0ePgnZHu4XwUdbhYyTKjis1eSJvj
         B07cI8Aq4oUT5ML82Sm6kDuoAuXK8ZOjhMXf+1kGGUOQHa76OA+epbNGQ4T0K5Dvpitc
         5Uk9xE3YY5o/wlEeh7huEfUIC/HOPOl1S8QAiUUuWAHPlYiw13Q9XF5fnrC4WK8l6v/K
         37KEH7kA6ZB8qgYOj+bCBXifl2vfTFIWJSQj+exMQIa9F8XnLtATso2TYz50JaCqQvkC
         uofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=62jFklFu5MUSqSBplWE7qLFZD87yIRraMisa2DYeNNo=;
        b=Nx2Iiv9pQIyamJb2Yteu2ND4tv0IyjRL9OQQaUCJRJiybo+pelEStYzjzqok0+l7Pz
         aG7c8z4E5gAfndtWgi3XrvcDezNWny5alW6pQDRQL4O7DE5M8sL53MzK0aYE6bhOm3dG
         /cFvdXZO9sTPhxVwxWkeE+NFV/TKljKC5yvOc36lGo/LVafXyWPbt7gHe8k9b9sF8SNA
         Hc7UGz0pFHqFZVl3TE139wWkdgyM8dTBiviiPkdOMvX7d9h/PIiMB7aVb4Xf734qEeE+
         iyZhflRgaCNPJMlllTDvoloCQM5vFjDiVIhvbBhqhEJVkvC/LigLMH52dqq92JNPlYM6
         tOHQ==
X-Gm-Message-State: ACgBeo2yh7nJLg+VeEKveLuMxWAXszreGwS6kJ8DjQGPERaxY9AdkN37
        FDWOTXeo1fIWjpHg89pdIA4wNRUUKVWPh1hal+I=
X-Google-Smtp-Source: AA6agR56q8lYQLNyWMJVg9OJhcQ69gNkIAVPLOFE+1CqsYRz0DmE9LAc8AV1qJGw9xoNn4w/VXvRBdbOOiJc6BBtPEY=
X-Received: by 2002:a17:907:7b94:b0:731:1b11:c241 with SMTP id
 ne20-20020a1709077b9400b007311b11c241mr10355649ejc.676.1662735524261; Fri, 09
 Sep 2022 07:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-22-memxor@gmail.com>
 <311eb0d0-777a-4240-9fa0-59134344f051@fb.com> <CAP01T76QJOYqk4Lsc=bUjM86my=kg3p6GHxuz3yXiwFMHJtjJA@mail.gmail.com>
 <CAADnVQJ6-kEE=_kHgyth_O3rUVHzJuNhS2MWhjQQed4wHzPpnA@mail.gmail.com> <CAP01T74-Bc8xLihXcoer8fOoSoQQ1dddJ1FGOVdRPRa92RRPyQ@mail.gmail.com>
In-Reply-To: <CAP01T74-Bc8xLihXcoer8fOoSoQQ1dddJ1FGOVdRPRa92RRPyQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 9 Sep 2022 07:58:33 -0700
Message-ID: <CAADnVQLJP8YyYx5+mCBuSyenAfQDyXxDP8wfuDYCoZtO6kpunQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 21/32] bpf: Allow locking bpf_spin_lock
 global variables
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@fb.com>
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

On Fri, Sep 9, 2022 at 7:51 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Fri, 9 Sept 2022 at 16:24, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Sep 9, 2022 at 4:05 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > >
> > > On Fri, 9 Sept 2022 at 10:13, Dave Marchevsky <davemarchevsky@fb.com> wrote:
> > > >
> > > > On 9/4/22 4:41 PM, Kumar Kartikeya Dwivedi wrote:
> > > > > Global variables reside in maps accessible using direct_value_addr
> > > > > callbacks, so giving each load instruction's rewrite a unique reg->id
> > > > > disallows us from holding locks which are global.
> > > > >
> > > > > This is not great, so refactor the active_spin_lock into two separate
> > > > > fields, active_spin_lock_ptr and active_spin_lock_id, which is generic
> > > > > enough to allow it for global variables, map lookups, and local kptr
> > > > > registers at the same time.
> > > > >
> > > > > Held vs non-held is indicated by active_spin_lock_ptr, which stores the
> > > > > reg->map_ptr or reg->btf pointer of the register used for locking spin
> > > > > lock. But the active_spin_lock_id also needs to be compared to ensure
> > > > > whether bpf_spin_unlock is for the same register.
> > > > >
> > > > > Next, pseudo load instructions are not given a unique reg->id, as they
> > > > > are doing lookup for the same map value (max_entries is never greater
> > > > > than 1).
> > > > >
> > > >
> > > > For libbpf-style "internal maps" - like .bss.private further in this series -
> > > > all the SEC(".bss.private") vars are globbed together into one map_value. e.g.
> > > >
> > > >   struct bpf_spin_lock lock1 SEC(".bss.private");
> > > >   struct bpf_spin_lock lock2 SEC(".bss.private");
> > > >   ...
> > > >   spin_lock(&lock1);
> > > >   ...
> > > >   spin_lock(&lock2);
> > > >
> > > > will result in same map but different offsets for the direct read (and different
> > > > aux->map_off set in resolve_pseudo_ldimm64 for use in check_ld_imm). Seems like
> > > > this patch would assign both same (active_spin_lock_ptr, active_spin_lock_id).
> > > >
> > >
> > > That won't be a problem. Two spin locks in a map value or datasec are
> > > already rejected on BPF_MAP_CREATE,
> > > so there is no bug. See idx >= info_cnt check in
> > > btf_find_struct_field, btf_find_datasec_var.
> > >
> > > I can include offset as the third part of the tuple. The problem then
> > > is figuring out which lock protects which bpf_list_head. We need
> > > another __guarded_by annotation and force users to use that to
> > > eliminate the ambiguity. So for now I just put it in the commit log
> > > and left it for the future.
> >
> > Let's not go that far yet.
> > Extra annotations are just as confusing and non-obvious as
> > putting locks in different sections.
> > Let's keep one lock per map value limitation for now.
> > libbpf side needs to allow many non-mappable sections though.
> > Single bss.private name is too limiting.
>
> In that case,
> Dave, since the libbpf patch is yours, would you be fine with
> reworking it to support multiple private maps?
> Maybe it can just ignore the .XXX part in .bss.private.XXX?
> Also I think Andrii mentioned once that he wants to eventually merge
> data and bss, so it might be a good idea to call it .data.private from
> the start?

I'd probably make all non-canonical names to be not-mmapable.
The compiler generates special sections already.
Thankfully the code doesn't use them, but it will sooner or later.
So libbpf has to create hidden maps for them eventually.
They shouldn't be messed up from user space, since it will screw up
compiler generated code.

Andrii, what's your take?
