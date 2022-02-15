Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085794B5F0E
	for <lists+bpf@lfdr.de>; Tue, 15 Feb 2022 01:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiBOAaI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 19:30:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiBOAaI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 19:30:08 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2286D119F4E
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 16:29:59 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id l8so5811098pls.7
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 16:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uODnUceeqy2Q9DJASZSJXMC+NT5aJMhnRokR9cgN4JI=;
        b=iGuRc7pncCsMSGWR4lAoET5QW3nUzSfpKw/a/HHKxfGyoQx1DDvhDp0Em0fApwHRmX
         z1UaUFBixYI4t6Kd5UcJZOPcEvxihUvVrABsyLPOiN9GmDC11i9a60xj+Y5AP4mgnbeN
         G+y7BQkedL0RNiAXltnDG/doxCMonhb69XOjEA6XInORL28ALWRcZ5lDJr/RHiZTNxMv
         WeuP8UVi7dK5OaKzimP8qBFW5xjorJtxDDQeWIDILxr0EylsdtrCSKT0u7Bfv97lFxK1
         cywlMtq3rKSiaH1hY4F2jWETlmLlawX8OyDbFbTkW/ohHM+9Rz1FFJeUqHgVynQ+DN8J
         ctcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uODnUceeqy2Q9DJASZSJXMC+NT5aJMhnRokR9cgN4JI=;
        b=nlsOqAPrXjQFWNTntXwKFMIa7uP7sKkXh7vhaqxBWSPmdPYgyBd3PqDlrBEOVDZjKF
         gbPAptEV2FLUelZ3NdyZWHszNpaUqwj+xttnwQMlrI9rgKH/h+WeUDst9oWhgBDfULVA
         uYRw+VmMsYEVBBWeLThhfR7iyeAScQLK29D8byhj12g7oedv7Yf5cCttuQy8v00Jp3Zg
         x3FdQb3uxcUgAlchQzTYk/w6isgpFK0uNIabA1ZQD75cQHfyStJZNMGiIjbvenmkVel1
         YJO0XHKX8O978XdXk5B+XKeL0eG0PFHioI6/gU5ahsMDluyvjSw8ACJdtGZzBKLBjwa6
         XvYg==
X-Gm-Message-State: AOAM531L5ugTvBOZAVdlCWbSTtAeVsh1cO9u8zS47dDc0fBBGOsGPEHb
        s8HDymSr/d55B1b6ShWrVjdvejEiy+EJH2vkyrw=
X-Google-Smtp-Source: ABdhPJysEXaz/N4/kSIN4a0Q9e/5m5brAxXlusZl2ks5OO+QqPe9dZpDCVuAHN+t8/jdLYqmYaG609zTVFiLbWg2HBs=
X-Received: by 2002:a17:90b:1803:: with SMTP id lw3mr1414090pjb.117.1644884998552;
 Mon, 14 Feb 2022 16:29:58 -0800 (PST)
MIME-Version: 1.0
References: <20220211211450.2224877-1-andrii@kernel.org> <20220211211450.2224877-4-andrii@kernel.org>
 <20220211231316.iqhn3jqnxangv5jc@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzbrdJMX0P=P84D40oYH3BNrL-16xqFNFH48BtYc9DaJHw@mail.gmail.com>
 <20220212001832.2dajubav5tqwaimn@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzY_tQQ3sTmTwx_uFAg3Z50ckWf1MWgCy-ZR==gV65e3Mw@mail.gmail.com>
 <20220214172747.o6xr3pfvvt7545wk@ast-mbp.dhcp.thefacebook.com> <alpine.LRH.2.23.451.2202142305590.25685@MyRouter>
In-Reply-To: <alpine.LRH.2.23.451.2202142305590.25685@MyRouter>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 14 Feb 2022 16:29:47 -0800
Message-ID: <CAADnVQ+Rcim71k8z2ifsEbJRRFwPHCxhOmzv+VCL3Qk1kMtKsA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: add custom SEC() handling selftest
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
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

On Mon, Feb 14, 2022 at 3:14 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Mon, 14 Feb 2022, Alexei Starovoitov wrote:
>
> > Alan,
> > can you demo your "okprobe" feature based on this api?
> > Any rough patches would do.
>
> sure; see below.  Requires Andrii's v3 patches to be applied first,
> and demonstrates okprobe handling for a kprobe function that exists
> and one that doesn't - the important thing is skeleton attach
> can succeed even when a function is missing (as it would be if
> the associated module wasn't loaded).
>
> > The "o" handling will be done in which callback?
> >
>
> We set program type at init and do custom attach using the function
> name (specified in the program section after the "okprobe" prefix).
> However we make sure to catch -ENOENT attach failures and return 0
> with a NULL link so skeleton attach can proceed.
>
> From 9bbd615b71f8f59ff743608bc86d7a2a346da2a8 Mon Sep 17 00:00:00 2001
> From: Alan Maguire <alan.maguire@oracle.com>
> Date: Mon, 14 Feb 2022 22:57:56 +0000
> Subject: [PATCH bpf-next] selftests/bpf: demonstrate further use of custom
>  SEC() handling
>
> Register and use SEC() handling for "okprobe/" kprobe programs
> (Optional kprobe) which should be attached as kprobes but
> critically should not stop skeleton loading if attach fails
> due to non-existence of the to-be-probed function.  This mode
> of SEC() handling is useful for tracing module functions
> where the module might not be loaded.
>
> Note - this patch is based on the v3 of Andrii's section
> handling patches [1] and these need to be applied for it to
> apply cleanly.
>
> [1] https://lore.kernel.org/bpf/20220211211450.2224877-1-andrii@kernel.org/
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Thanks. The patch certainly helps to understand the api usage.

>  static int custom_init_prog(struct bpf_program *prog, long cookie)
>  {
>         if (cookie == COOKIE_ABC1)
>                 bpf_program__set_autoload(prog, false);
> +       else if (cookie == COOKIE_OKPROBE)
> +               bpf_program__set_type(prog, BPF_PROG_TYPE_KPROBE);

I think bpf_program__set_type() would have worked
from the prepare_load_fn callback as well.

What would be a recommended way of setting it?
