Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B364DA655
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 00:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245117AbiCOXkg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 19:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239050AbiCOXkf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 19:40:35 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1CB5C870;
        Tue, 15 Mar 2022 16:39:22 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e13so444095plh.3;
        Tue, 15 Mar 2022 16:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gdgwc50V9R2+QH5FBUvazQfb7JYjYQJxqctQWcR0o0M=;
        b=X9afLoy+Ml4ks/kD1uF3I63U/IvRzLI8Wayo9PTqvrLdXNdY9g7SxZ3aPHGh9P+JQQ
         2X/BS74LPouGFZiTft7ay/9ZzxqgCEGVssFqxN6qeR+IovKA9Mg0GG3wG9NiClZemos7
         4jzEeKmOoryRpkcpWs/vsXHtnGzAKYyqtgY4LTMvzzuX/rsfZ7sgAJi1f8KHgCkZLghk
         msY+tiZA3MmEEYrpMC+XuOrhn02JMIvdeCxy5rQ+FgBbXS6sNcoO0D9Mq/0i+JKDfpFW
         e3OvKaO1Tib0eO/TEloIoCLILRwuTtbTOYrQ/aD5aRAZG4ggxkTHkhQB6w/kc+E5wP8t
         LQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gdgwc50V9R2+QH5FBUvazQfb7JYjYQJxqctQWcR0o0M=;
        b=td1L4Gnw7PZ8jmFsqVB4EmSE5/oeQzLL6M5ngpl31+DmjRUW/N+NKWXMWtmAG5VX2V
         zNBRjv7o9keBwuY1Rckemf0qAnlqgxOvStf8AWPOhg5Z39lOMpexBWwX/mMzPwnGc4Gx
         j/EcsPUsKetqcRh4WwpOauS6AMoPZtoiwvSZ0SaUtwWyTDrTPbwEF43IMSgKickX6VAx
         vh990QZsdc7y7OP90eVr/RQerSJ6px4Z8mNu+P34dYipYc+Fu5Ifv402J0Ff+jo0FsUF
         8bxvPDrqgBYZUtdE2z557ZxpYZKsZqj6VcBk5udTbIfw2q/CTZU2EEkHGlwrcFiJnDq5
         2SVA==
X-Gm-Message-State: AOAM531dReVg1X37ZLisNNV2hOdKY2OD7wAPh4HNcE4HRrHlrTBGx8Kk
        El+wGZG8bXfZ7JCFVkRYElJDvvLyVvEynhOR/nzCMpRQ
X-Google-Smtp-Source: ABdhPJyRTFFGCZrP+dVbhabkEnMndJ5CeJHcdM+bPVWC/Wm8vTYT90aP2Za5gmkYq2fk/U9j5bIpzrDRC6z2R8UE9B8=
X-Received: by 2002:a17:90a:3e42:b0:1bf:53ce:f1ef with SMTP id
 t2-20020a17090a3e4200b001bf53cef1efmr7231971pjm.33.1647387561997; Tue, 15 Mar
 2022 16:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <1d2931e80c03f4d3f7263beaf8f19a4867e9fe32.1647212431.git.dxu@dxuuu.xyz>
 <CAADnVQJUvfKmN6=j5hzhgE25XSa2uqR3MJyq+c=AGCKkTKD05g@mail.gmail.com> <53a71699-3ffb-4a49-9d15-7fe4a0f51612@www.fastmail.com>
In-Reply-To: <53a71699-3ffb-4a49-9d15-7fe4a0f51612@www.fastmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 15 Mar 2022 16:39:10 -0700
Message-ID: <CAADnVQ+bkyPPA9r_n+A7VeYQch-fOiPDHGO-2EZ1dhgva8GF8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Add SPDX identifier to btf-dump-file output
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Mar 15, 2022 at 4:10 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hi Alexei,
>
> On Tue, Mar 15, 2022, at 2:38 PM, Alexei Starovoitov wrote:
> > On Sun, Mar 13, 2022 at 4:01 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >>
> >> A concern about potential GPL violations came up at the new $DAYJOB when
> >> I tried to vendor the vmlinux.h output. The central point was that the
> >> generated vmlinux.h does not embed a license string -- making the
> >> licensing of the file non-obvious.
> >>
> >> This commit adds a LGPL-2.1 OR BSD-2-Clause SPDX license identifier to
> >> the generated vmlinux.h output. This is line with what bpftool generates
> >> in object file skeletons.
> >>
> >> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> >> ---
> >>  tools/bpf/bpftool/btf.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> >> index a2c665beda87..fca810a27768 100644
> >> --- a/tools/bpf/bpftool/btf.c
> >> +++ b/tools/bpf/bpftool/btf.c
> >> @@ -425,6 +425,7 @@ static int dump_btf_c(const struct btf *btf,
> >>         if (err)
> >>                 return err;
> >>
> >> +       printf("/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */\n\n");
> >
> > I don't think we can add any kind of license identifier
> > to the auto generated output.
> > vmlinux.h is a pretty printed dwarfdump.
>
> Just so I understand better, when you say "I don't think we can",
> do you mean:
>
> 1) There may be legal issues w/ adding the license identifier
> 2) It doesn't make sense to add the license header
> 3) Something else?

2
