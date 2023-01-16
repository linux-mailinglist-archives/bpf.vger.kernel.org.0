Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1317866B59F
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 03:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjAPC2C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 15 Jan 2023 21:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjAPC15 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 15 Jan 2023 21:27:57 -0500
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F09E728D;
        Sun, 15 Jan 2023 18:27:57 -0800 (PST)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-4d59d518505so194063247b3.1;
        Sun, 15 Jan 2023 18:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rf3oYMshP1FK8r55wtFcYr8p7u075CmKOwZBIt1AJME=;
        b=ZbE+TFA+ei/ozO8vXf2wNwOOEbolWBI8xxLCZOqLChDIEyBkNgG6zT7qvQcPyGNaz1
         tOMj+HW8Eg2bMExypX1UgwbvhsDtTTM4orD4k4frATLgEcq4ZzbCZBB/LJ/hL9VAlOvP
         tq+O9QzDrg3rKqlNzjsOa0ZS4pkFEQ609xUGVZOVzhAMi+iP7E0WX/YL2U/IMNAmYQDL
         47eMp73Amj+mTcLROge3gV0hQtE6HZ56Jms4zStCwmT5+0eRvlmYpohUid+a1b6nHTB/
         c+5DOLNgaP3i/IvS5B2cr6FyzGtu3EE0+CMIaNfZ/RumgKVbnfGPMbh1gCPyJdSxAspb
         5+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rf3oYMshP1FK8r55wtFcYr8p7u075CmKOwZBIt1AJME=;
        b=7KlxDZxYlJNuU5Q7cMs/zKGhN+1ZNXeGI6dIfPfiWxBUm/MZSfmMo97VVxw78wX4ih
         AzXA5leZLG/qrmflAaRENOLh7zvP0oa2A7MqcjuFCc0Pi3G+d7Ywk356EboqgakNt4Jz
         xAahOsWWyLYAY6CRQ5MPofPWsm1t/LM6rlDWCaJFryDktP1Da1RFd46tS39QiXTFSJCq
         zhM2jC3/15pPL/1e+LmH3vD/YeeJhCTU9607/wMfBfiqDih1tCnufXYer307mA0tMjE6
         mdjHK+LN2iWiun3Q6Udl6fBTaXKmydPBORodYRQxGO1b6V1R1uJ2aD1XuMFGSAuNXR0R
         xyVg==
X-Gm-Message-State: AFqh2kqPSntAQ9CqrgA7Oz9F21WhFoP9c3BLFVTAfJvnSnJs90B7qP4e
        17+fShMZBT7SuFzgWEk6FMENHTu9w16UoDYnshY=
X-Google-Smtp-Source: AMrXdXv3OEd1aT/KA9stR9zP/tT2p/re0Lpanqx7mbXkKxFVlAgShiM0BwqULHDALZcDJ7PVxFGcIpSOwkTQWpo8ub0=
X-Received: by 2002:a81:4c83:0:b0:3be:16c3:6829 with SMTP id
 z125-20020a814c83000000b003be16c36829mr4581695ywa.298.1673836068557; Sun, 15
 Jan 2023 18:27:48 -0800 (PST)
MIME-Version: 1.0
References: <20230113093427.1666466-1-imagedong@tencent.com>
 <bdca73eb-07e3-2187-c46f-a3f14a9e50a4@oracle.com> <CAEf4BzZ5FNw-j3F8cUpy4knRiM1sqQOOPZnM43Kj8peN9kKQLg@mail.gmail.com>
In-Reply-To: <CAEf4BzZ5FNw-j3F8cUpy4knRiM1sqQOOPZnM43Kj8peN9kKQLg@mail.gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Mon, 16 Jan 2023 10:27:37 +0800
Message-ID: <CADxym3YqgvYt71+WhMM4jzp+9uqkNdq3nB9kvBxT=CVM7hwRsA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: replace '.' with '_' in legacy kprobe event name
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
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

Hello,

On Sat, Jan 14, 2023 at 6:07 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jan 13, 2023 at 6:13 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > On 13/01/2023 09:34, menglong8.dong@gmail.com wrote:
> > > From: Menglong Dong <imagedong@tencent.com>
> > >
> > > '.' is not allowed in the event name of kprobe. Therefore, we will get a
> > > EINVAL if the kernel function name has a '.' in legacy kprobe attach
> > > case, such as 'icmp_reply.constprop.0'.
> > >
> > > In order to adapt this case, we need to replace the '.' with other char
> > > in gen_kprobe_legacy_event_name(). And I use '_' for this propose.
> > >
> > > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index fdfb1ca34ced..5d6f6675c2f2 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -9994,9 +9994,16 @@ static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
> > >                                        const char *kfunc_name, size_t offset)
> > >  {
> > >       static int index = 0;
> > > +     int i = 0;
> > >
> > >       snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(), kfunc_name, offset,
> > >                __sync_fetch_and_add(&index, 1));
> > > +
> > > +     while (buf[i] != '\0') {
> > > +             if (buf[i] == '.')
> > > +                     buf[i] = '_';
> > > +             i++;
> > > +     }
> > >  }
> >
> > probably more naturally expressed as a for() loop as is done in
> > gen_uprobe_legacy_event_name(), but not a big deal.
> >
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> Applied, but tuned to be exactly the same loop as in
> gen_uprobe_legacy_event_name. Thanks.
>

Thanks for your modification, it looks much better now!

> >
> > One issue with the legacy kprobe code is that we don't get test coverage
> > with it on new kernels - I wonder if it would be worth adding a force_legacy
> > option to bpf_kprobe_opts? A separate issue to this change of course, but
> > if we had that we could add some legacy kprobe tests that would run
> > for new kernels as well.
>
> Yep, good idea. If we ever have some bug in the latest greatest kprobe
> implementation, users will have an option to work around that with
> this.
>
> The only thing is that we already have 3 modes: legacy, perf-based
> through ioctl, and bpf_link-based, so I think it should be something
> like
>
> enum kprobe_mode {
>     KPROBE_MODE_DEFAULT = 0, /* latest supported by kernel */
>     KPROBE_MODE_LEGACY,
>     KPROBE_MODE_PERF,
>     KPROBE_MODE_LINK,
> };
>
> LEGACY/PERF/LINK naming should be thought through, just a quick example.
>
> And then just have `enum kprobe_mode mode;` in kprobe_opts, which
> would default to 0 (KPROBE_MODE_DEFAULT).
>
> Would that work?
>

Sounds great, which means I don't have to switch to an older
kernel to test this function for my app.

BTW, should I do this job, (which is my pleasure), or Alan?


Thanks!
Menglong Dong

> >
> > Alan
> > >
> > >  static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
> > >
