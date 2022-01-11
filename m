Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7E648B2DE
	for <lists+bpf@lfdr.de>; Tue, 11 Jan 2022 18:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343910AbiAKRGw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jan 2022 12:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343881AbiAKRGu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jan 2022 12:06:50 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BBCC06175E
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 09:06:49 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id c19so2081495qtx.3
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 09:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GwEzTM3puzNanowtznxFdQD0oxHY+bU4sdD4AmBgDQM=;
        b=oU2h8BTnh+No2/FSEdZqT34174p1sINz8IZ6ecV0I639jO4BHW187txTk2WN/babDR
         FCGI4kAzGKAXCeQBYPIcGm5+1bjHOQFGthQ1USST6lR506582xtkFo8tXullDo0TgjWu
         FKsPR+aO1mie3szEPXuY3bciuN25BknXWXudKCJpEqgpQBt2kMyCE5oTP6gVq7L7egFa
         SeuO84SgFCreG5Xjvt/QjsQbqNbHH4S97M5E00BnvXovU9TO91iVbJftQMJvIdP+M5dv
         HH2Hp/CBMBJRUxV1o1Ed+QSCbelWXtKgkWWV+E4X1gvx0rjXF3JKTg4DvFuHPCJvFwDO
         CXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GwEzTM3puzNanowtznxFdQD0oxHY+bU4sdD4AmBgDQM=;
        b=30XvkER7amOCrn6b6x5sF2vzhB0oQwdTljsPEKVS6sSay5bxujyFNEoH1FfhXBhEZ6
         ZDH2m5K8vEr4+FmiiB/jO5mTJstfYy89OtV1lcmQ2s53DjvjLYeVZ/1gT99ja57x0cm+
         MSjgOwmnSO2TK1wIYZohy/GzaG5cIkiue12GlMmtpDaZKpj88V1DuYshP+6CeLo3Ygjk
         KVyWk11DSRKp0/50CRSs0X6Ub4wHMFIvEkBqq2Ln+CqavTsn4gvG+hbPE1LK5vV3IHyQ
         FGN2aZF0DUQrtKaz/YIB1C1OrzxqyddfToTRkwRvCaYmrpIyCUcevCMZRUtJLIptxPAX
         s9zQ==
X-Gm-Message-State: AOAM530TmnNMPN4hEH+Vzfxb7oYgm32jhL6QAvyiIAyzum3QpXGf3Qpf
        uou/crbv8zRc/WGM9uH1RXtY4gwDgYFZ1dW+geNwaA==
X-Google-Smtp-Source: ABdhPJyMoHEvtzNosqvIy9I+7+Q09Hg2zEVapxeM84dFxPU6gqU01wa2t7vRtkvWONMae0fAkeSOiNR/FyQgk+tzvkc=
X-Received: by 2002:ac8:4e83:: with SMTP id 3mr4464054qtp.375.1641920806098;
 Tue, 11 Jan 2022 09:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20220106215059.2308931-1-haoluo@google.com> <Ydd1IIUG7/3kQRcR@google.com>
 <CA+khW7h4OG0=w5RXnentwnsi614wZdpYW4EUwN6k7Vce3unBKw@mail.gmail.com>
 <YdiTrq4Y7JwmQumc@google.com> <CA+khW7ihrLZwvzPTGAy0GyFmKzB7tH-FU6D+-fthqbj4wuiwFg@mail.gmail.com>
 <20220111033344.n2ffifjlnoifdgnj@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220111033344.n2ffifjlnoifdgnj@ast-mbp.dhcp.thefacebook.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 11 Jan 2022 09:06:35 -0800
Message-ID: <CAKH8qBtWQ6AhQ_es-ytTGyaCxpy1RYsXtJX-f1m=aJx300YVCQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 0/8] Pinning bpf objects outside bpffs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 10, 2022 at 7:33 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jan 10, 2022 at 10:55:54AM -0800, Hao Luo wrote:
> >
> > I see. With attach API, are we also able to specify some attributes
> > for the attachment? For example, a property that we may want is: let
> > descendent cgroups inherit their parent cgroup's programs.
>
> Plenty of interesting ideas in this thread. Thanks for kicking it off.
> Maybe we should move it to office hours?
> The back and forth over email can take some time.
> It sounds to me that "let descendents inherit" is a mandatory feature.
> In that sense "allow attach in kernfs" is not a feature. It feels that
> it's creating more problems for the design.
> Creating a "catable" file inside cgroup directory that descedents inherit
> with the same name is a cgroup specific feature.
> Inherit or not can be a flag, but the inheritance needs to be designed
> from the start.
>
> echo "rm" is not pretty.
> fsnotify feels a bit hacky.
> Maybe pinning in cgroupfs will avoid both issues?
> We can have normal unlink implemented there.

With unlink we can do chown and let regular users call unlink.
So maybe it's actually more flexible vs syscall detach, although no
idea why the users would do that.

> The attach bpf_sys cmd as-is won't work. It needs a name at least.

Can we use prog_name in attach? Or, if it's limited by
BPF_OBJ_NAME_LEN, can we extract function name from btf? Or is it too
magic to derive the path from the program name?
obj_pin+unlink is a good alternative. One thing I'm not certain is:
what happens when I call unlink on some of the inherited nodes? (i.e.,
do I need to have a flag to say "unlink this one including
children/parent"? probably not and returning error is fine?)
Agree with your summary that the inheritance story needs more thought :-)
