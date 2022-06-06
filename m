Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C3553F235
	for <lists+bpf@lfdr.de>; Tue,  7 Jun 2022 00:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiFFWqd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jun 2022 18:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbiFFWqc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jun 2022 18:46:32 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7040B5591
        for <bpf@vger.kernel.org>; Mon,  6 Jun 2022 15:46:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w2-20020a17090ac98200b001e0519fe5a8so13801972pjt.4
        for <bpf@vger.kernel.org>; Mon, 06 Jun 2022 15:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eoK4z3j+4VVgoiwHq8CGdLVxmgUiRltw8RLHmMxieoQ=;
        b=A6X6BV9S6OlUufC2bnRxhV77QZulQqXTAkY/jXL8fdPK182fdoOukMyqFtfhis3Iwa
         wEOEPHoVTgDqOsJ0eIHuDgwrOLezzpfrFaDeEJ1qtzv+hZSec58wb7rFfVD4A5TBIbbq
         zoki1JZdz0PlzQU1guP26Y4cd3XIufqTHZ4RMo1EV/WM4qNYnj3o/5/+6ElxgZpOJF7o
         gD8w3RrJooHh06XT1o6VyzMcFuGZUZj4Hofc15DIz4YxqFPhNZiXQDrJYCByRJX+LYt8
         g4JQ0VYPyMOhhrlt7Oo5vrTRl+WrcxttBWyae906ihM25T/ZS9vqC2cZCJgGl+wuEPkY
         WMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eoK4z3j+4VVgoiwHq8CGdLVxmgUiRltw8RLHmMxieoQ=;
        b=IAHQ5BsL1tauoFzG2rJzHOgURjugpU15J6uF/pTE1EtBtizCkxVLLYgqGfvlhXur16
         XMQVTvMxH8bM6xiyIff4tubUQOAm85Q8hbjMuDKzCscFM4aFD1Q6EUTITtosFwo2fIC8
         u5Oqg3/BLT6hkjPECzsD0glkO1Ows3/wMo96ABrGmtqesC5S62irsA1akEGDzBTzZn82
         5ytGuTfWGxrf9MKBa50wC6TiL5cj7ysQBzCVExdt95J7AFszuCJZ1U86lysziCJIY6JJ
         K3jmU4znHd6EfwARB1aU2rmOB0s9Sw4kfRlLD9IC5gBtETeG9alq314wcONoe761ZUnM
         sqFw==
X-Gm-Message-State: AOAM530RWPtCkc6d2y5pZySqpyOFUpOr4M+wtm0Mu5gEdSWxbZfQ6ZKi
        /kTRrewWNp+s5umdBG30sZ4qrsQGdj57/JopWUWaNQ==
X-Google-Smtp-Source: ABdhPJygjgF+GrIBaogKrcRUSo3ekaCL1qskEHLSvtht3vmz35+ndkGGcEbLk2JqBicXN8N1kln5As7HoIqFUaHTK+o=
X-Received: by 2002:a17:90b:380b:b0:1e6:67f6:f70c with SMTP id
 mq11-20020a17090b380b00b001e667f6f70cmr31132737pjb.120.1654555590631; Mon, 06
 Jun 2022 15:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220601190218.2494963-1-sdf@google.com> <20220601190218.2494963-4-sdf@google.com>
 <20220604061154.kefsehmyrnwgxstk@kafai-mbp> <20220604082706.s3r42iwgi7ftiud7@kafai-mbp>
In-Reply-To: <20220604082706.s3r42iwgi7ftiud7@kafai-mbp>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 6 Jun 2022 15:46:18 -0700
Message-ID: <CAKH8qBs-TYyFt2d7i8JnTTEiQ5Ee37aWiwE3t+31huCDx62+cg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 03/11] bpf: per-cgroup lsm flavor
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 4, 2022 at 1:27 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Fri, Jun 03, 2022 at 11:11:58PM -0700, Martin KaFai Lau wrote:
> > > @@ -549,9 +655,15 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
> > >     bpf_cgroup_storages_assign(pl->storage, storage);
> > >     cgrp->bpf.flags[atype] = saved_flags;
> > >
> > > +   if (type == BPF_LSM_CGROUP && !old_prog) {
> > hmm... I think this "!old_prog" test should not be here.
> >
> > In allow_multi, old_prog can be NULL but it still needs
> > to bump the shim_link's refcnt by calling
> > bpf_trampoline_link_cgroup_shim().
> >
> > This is a bit tricky.  Does it make sense ?
> I think I read the "!"old_prog upside-down.  I think I got the
> intention here now after reading some latter patches.
> It is to save a bpf_trampoline_link_cgroup_shim() and unlink
> for the replace case ?  I would prefer not to do this.
> It is quite confusing to read and does not save much.

Ok, let me try to drop it!


> > > +           err = bpf_trampoline_link_cgroup_shim(new_prog, &tgt_info, atype);
> > > +           if (err)
> > > +                   goto cleanup;
> > > +   }
> > > +
> > >     err = update_effective_progs(cgrp, atype);
> > >     if (err)
> > > -           goto cleanup;
> > > +           goto cleanup_trampoline;
> > >
> > >     if (old_prog)
> > Then it needs a bpf_trampoline_unlink_cgroup_shim(old_prog) here.
> >
> > >             bpf_prog_put(old_prog);
> > > @@ -560,6 +672,10 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
> > >     bpf_cgroup_storages_link(new_storage, cgrp, type);
> > >     return 0;
> > >
> > > +cleanup_trampoline:
> > > +   if (type == BPF_LSM_CGROUP && !old_prog)
> > The "!old_prog" test should also be removed.
> >
> > > +           bpf_trampoline_unlink_cgroup_shim(new_prog);
> > > +
> > >  cleanup:
> > >     if (old_prog) {
> > >             pl->prog = old_prog;
