Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732564DA26E
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 19:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiCOSe3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 14:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347383AbiCOSe2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 14:34:28 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477D11EEC1
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 11:33:14 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id w7so23280211ioj.5
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 11:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBb3rxhvuV5J+581BUtwaDyuGWSSGTqgfdkT+HwyJhs=;
        b=h0p6GSvrRw4K1/zjevhehP+Xw1OZo7ZgVCS2DpNDewzsbkEbrGYUgu8DiLtHYkvvmj
         a2gSOXn0UrAUEpNc01f5NSi7nA77kaqzsdYDQbjziOHh7z2WEBtWoQ3E+u6IcTy5+cJU
         YxHmBLhVQpo8Cc0ySRdDF1rsoNzRdpcZ0Pj4NKzgmug6RTv/99Oz5OML/l/EW6QR3YkX
         0Cp2SRe9oloxmLSdYZG3yYUeH2R6kVHReZy5bB0bdA9yWy9Rw4EOJ6BWXGubNdiAFwQx
         KOYw7DRdpkEwJK/iGgoG4IJXsLlmzfEcRnpXBJFUh4tozd9wG9/NyAB1hcNzIRojkTnQ
         HYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBb3rxhvuV5J+581BUtwaDyuGWSSGTqgfdkT+HwyJhs=;
        b=PnayE6+AZjecaQGdEMydduYDAbJYYRV/NFyXCS6AOAyThE7SWv83Wz+RL1LPBfY21c
         jly0GR4TnSg7iYJ8LKCfukjAa9WLk1NTGA803CjupiFOFA4F9UB1lpgosOTHCo4X03ov
         6AXgfwyAecN6RPcyUoY+X6ZYFFERKBynVVOorwS16OzNtk1u7RqBtDPr7AE1850Eaa6I
         cqtLVy1axxgqK/pWnntXAJsMyPhsii4BX+mB+Mk4FKkquPoPL3gG1TObZ+d0i+i0Dv/m
         NnS0DCTZX5YbjsXhW5stRgxnHXKp79RuUC07eOZeoCLhHicA6g+LMbDVl94vhd1wlFOC
         zjWg==
X-Gm-Message-State: AOAM532hRTAuCxi0RtrFX0XsaPQjhxANT9dA3mHWOvAIdzoOYhG6GL2U
        JNmds5yJ/+j+qBm3Mb8tmQLaxzRs3KFCBeE5J5k=
X-Google-Smtp-Source: ABdhPJyoJoBFI61nDTamWCDg79MT0eqH+A52gsy6ZZNaHcEEfxFVQMDlX1zDHd5kOk5BoQwNi2KuqLx8dXUWhzwv7R0=
X-Received: by 2002:a05:6638:772:b0:319:e4eb:adb with SMTP id
 y18-20020a056638077200b00319e4eb0adbmr14154361jad.237.1647369193648; Tue, 15
 Mar 2022 11:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220309163112.24141-1-9erthalion6@gmail.com> <CAEf4BzZJ1DBuhHi400ObWoEQA7nLMT8TD4cVmhea_g4tdRFzoA@mail.gmail.com>
 <CACdoK4Kviw5UiBCgP=3PFGRippmP1U3yXp-9vM8WwAB_-aRmeA@mail.gmail.com>
In-Reply-To: <CACdoK4Kviw5UiBCgP=3PFGRippmP1U3yXp-9vM8WwAB_-aRmeA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Mar 2022 11:33:02 -0700
Message-ID: <CAEf4Bzb0D=txKjrRu5mJczdfBde3v6HzY_XpbP=5JB5NwGRM9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6] bpftool: Add bpf_cookie to link output
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>
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

On Sat, Mar 12, 2022 at 2:59 PM Quentin Monnet <quentin@isovalent.com> wrote:
>
> On Fri, 11 Mar 2022 at 22:25, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Mar 9, 2022 at 8:33 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> > >
> > > Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
> > > BPF perf links") introduced the concept of user specified bpf_cookie,
> > > which could be accessed by BPF programs using bpf_get_attach_cookie().
> > > For troubleshooting purposes it is convenient to expose bpf_cookie via
> > > bpftool as well, so there is no need to meddle with the target BPF
> > > program itself.
> > >
> > > Implemented using the pid iterator BPF program to actually fetch
> > > bpf_cookies, which allows constraining code changes only to bpftool.
> > >
> > > $ bpftool link
> > > 1: type 7  prog 5
> > >         bpf_cookie 123
> > >         pids bootstrap(81)
> > >
> > > Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> > > Acked-by: Yonghong Song <yhs@fb.com>
> > > ---
> >
> > Quentin, any opinion on this feature? The implementation seems
> > straightforward enough. We'll need to not forget to expand the support
> > to other types that support bpf_cookies (and multi-attach kprobes and
> > fentries will be problematic, potentially), but this might be useful
> > for debugging purposes.
>
> No strong opinion. I'm generally in favour of adding more useful info
> to bpftool's output; I've not found myself in need for the bpf_cookie
> so far, but if it's helpful for debugging, then it makes sense to me
> that bpftool be the tool to provide the info. The change looks clean

Can I get your ack for this change, then?

> indeed. Agreed also that this will require us to think of updating
> bpftool when new types gain support for the cookies. What would be the
> problem with multi-attach, the kprobes/fentries would have several
> cookies?

Yes, multi-attach links will have one cookie for each attach target,
so there will be, in general, a multitude of cookie values.

>
> Quentin
