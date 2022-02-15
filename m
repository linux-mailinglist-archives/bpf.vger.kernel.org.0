Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A28B4B6262
	for <lists+bpf@lfdr.de>; Tue, 15 Feb 2022 06:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiBOFWr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 00:22:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiBOFWo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 00:22:44 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FD1B238C
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 21:22:35 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id z18so14033432iln.2
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 21:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcU3czxcw/V8K/QB1U0wWZEzbMCgOCXoZeQ5/EHmOLY=;
        b=h4oozrmhHbiMXi6fxIxCRyxXEP+b4UDRKlRELPGYxri9n8ZjlCsXxb85DH+63+s/jT
         QmpluRykgEdvzvHmjOUCFt/ZwTOqe+SDy/SWzRE9+ybwqHvZJ64rzbmnZpC+0JVCtDzW
         z1TdEhLbZ5KFZB2a/d3Bj4Kjk9kIJCjQxmZNn7XxyXY8R8iQwvzRoS5yM2x3yZXUvAl6
         zOgK9oDEW0GqZDETfnkksVI8FxM/zeZ3lCqfgXn3yFCpDrGR9FXCEvdJIn6yU723vmz/
         2GloijWHbQ8ZY5DdABqQAfdRur5Ic1SBi5WCq6MgEhBiNwswcMFXwZ2vXAT6+uU191GQ
         tuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcU3czxcw/V8K/QB1U0wWZEzbMCgOCXoZeQ5/EHmOLY=;
        b=4WRd5ojKAmMNlQM8H+xG7Ngm7OAJTOoqyHXnuhXv4R6RT6TNrE/RgsYYFnt6/5Fnqz
         HPaDTx+izggHYVuC5WS/7cF2lUMcohkbqsFaKaj194iLj7Y3xk5/v1QAMg3CnUniiRYn
         CvTvIcRU/FcD2H7HlNlS+LsO/Kv8DEo4GLhddIihgoSYS7i1AQtPnD0sw8jE5aVzyUXM
         DFtcdIL1LpGkkrmQCLMjrv4ddPPGR4l62Yo9rHw2TyBbQSyRtF99e8ilrDPnN1+mlQce
         XzmQklfRpN/p2Wd29kJxTfj2xNkdVrIo7MhZaC0bySc3xEvQUk57QV2pkeBzycqMuz/W
         lRLw==
X-Gm-Message-State: AOAM533jexl6oA1gM253mQAwfW4R2+wJja3t7yvHBx+IBP620mj+uZpD
        IAHxCY8X+MWOim520Y+Qgb3YM7Y77ycA04IhbUk=
X-Google-Smtp-Source: ABdhPJz4obu3FK0KGVL9rqvLQpRZ/8p4hJkeBAOFYWqA6Zy7KFynfdGMdWlhQOWxWJTIVeOr0JvMCq4kTpY2ZP/0eyk=
X-Received: by 2002:a05:6e02:1b85:: with SMTP id h5mr1495518ili.98.1644902554683;
 Mon, 14 Feb 2022 21:22:34 -0800 (PST)
MIME-Version: 1.0
References: <20220211211450.2224877-1-andrii@kernel.org> <20220211211450.2224877-4-andrii@kernel.org>
 <20220211231316.iqhn3jqnxangv5jc@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzbrdJMX0P=P84D40oYH3BNrL-16xqFNFH48BtYc9DaJHw@mail.gmail.com>
 <20220212001832.2dajubav5tqwaimn@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzY_tQQ3sTmTwx_uFAg3Z50ckWf1MWgCy-ZR==gV65e3Mw@mail.gmail.com>
 <20220214172747.o6xr3pfvvt7545wk@ast-mbp.dhcp.thefacebook.com>
 <alpine.LRH.2.23.451.2202142305590.25685@MyRouter> <CAADnVQ+Rcim71k8z2ifsEbJRRFwPHCxhOmzv+VCL3Qk1kMtKsA@mail.gmail.com>
In-Reply-To: <CAADnVQ+Rcim71k8z2ifsEbJRRFwPHCxhOmzv+VCL3Qk1kMtKsA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 14 Feb 2022 21:22:23 -0800
Message-ID: <CAEf4BzZz_sXFi4dk8k_Eg14VJ4MO+v3V5z76h6i0rDX92dM47A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: add custom SEC() handling selftest
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Mon, Feb 14, 2022 at 4:29 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 14, 2022 at 3:14 PM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > On Mon, 14 Feb 2022, Alexei Starovoitov wrote:
> >
> > > Alan,
> > > can you demo your "okprobe" feature based on this api?
> > > Any rough patches would do.
> >
> > sure; see below.  Requires Andrii's v3 patches to be applied first,
> > and demonstrates okprobe handling for a kprobe function that exists
> > and one that doesn't - the important thing is skeleton attach
> > can succeed even when a function is missing (as it would be if
> > the associated module wasn't loaded).
> >
> > > The "o" handling will be done in which callback?
> > >
> >
> > We set program type at init and do custom attach using the function
> > name (specified in the program section after the "okprobe" prefix).
> > However we make sure to catch -ENOENT attach failures and return 0
> > with a NULL link so skeleton attach can proceed.
> >
> > From 9bbd615b71f8f59ff743608bc86d7a2a346da2a8 Mon Sep 17 00:00:00 2001
> > From: Alan Maguire <alan.maguire@oracle.com>
> > Date: Mon, 14 Feb 2022 22:57:56 +0000
> > Subject: [PATCH bpf-next] selftests/bpf: demonstrate further use of custom
> >  SEC() handling
> >
> > Register and use SEC() handling for "okprobe/" kprobe programs
> > (Optional kprobe) which should be attached as kprobes but
> > critically should not stop skeleton loading if attach fails
> > due to non-existence of the to-be-probed function.  This mode
> > of SEC() handling is useful for tracing module functions
> > where the module might not be loaded.
> >
> > Note - this patch is based on the v3 of Andrii's section
> > handling patches [1] and these need to be applied for it to
> > apply cleanly.
> >
> > [1] https://lore.kernel.org/bpf/20220211211450.2224877-1-andrii@kernel.org/
> >
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>
> Thanks. The patch certainly helps to understand the api usage.
>
> >  static int custom_init_prog(struct bpf_program *prog, long cookie)
> >  {
> >         if (cookie == COOKIE_ABC1)
> >                 bpf_program__set_autoload(prog, false);
> > +       else if (cookie == COOKIE_OKPROBE)
> > +               bpf_program__set_type(prog, BPF_PROG_TYPE_KPROBE);
>
> I think bpf_program__set_type() would have worked
> from the prepare_load_fn callback as well.
>
> What would be a recommended way of setting it?

Currently, bpf_program__set_type() could be done only from init
callback, as by the time preload_fn is called, libbpf already captured
prog_type. This can be adjusted, but I think it's cleaner to do it in
init callback, so that user code, if it chooses to iterate programs
with bpf_object__for_each_program() and such, would get correct
information before bpf_object__load().

I also just checked bpf_program__set_type(), it seems like it's void
function, but it should certainly fail, if called after
bpf_object__load() phase. Not sure if it's an ABI-breaking change to
change it to int, but would be good to adjust this. Same for
bpf_program__set_expected_attach_type().
