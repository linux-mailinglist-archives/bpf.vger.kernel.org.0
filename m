Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F85499EBA
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 00:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837223AbiAXWnP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 17:43:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50488 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1453514AbiAXWX2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Jan 2022 17:23:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643063005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=067mQ/rXiwBk6yJpI9gB9PMeq9lk0HWia8mGv4MMwCI=;
        b=d8S6C39CcQL7U1uNwZh01brtN8E+9uheYcUYUZDwUjVy6bYvFVfLmBTSkScokeoMzjUbpm
        iR6R4tJdaSBSIKU37GFfwl/GtbucZgo8awdV5Klbx+XJ3FThN2SlgckMNZ6HWvQlTdDAcQ
        qCpLdmbdQyzCzezYGB3gbM/7qhIJc7A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-cmMeDkXoP-eJXb1wb0X5bA-1; Mon, 24 Jan 2022 17:23:24 -0500
X-MC-Unique: cmMeDkXoP-eJXb1wb0X5bA-1
Received: by mail-ed1-f70.google.com with SMTP id c23-20020a056402159700b00406aa42973eso6685126edv.2
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 14:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=067mQ/rXiwBk6yJpI9gB9PMeq9lk0HWia8mGv4MMwCI=;
        b=XVF0onRTzMO0DTNrr2MqA071P08oq5pBh0+jFl+NqRh9eJj+ZthyoZiwqCapnelJ7C
         M8t5gxtfdJi/R9YmPPbzWhNwIeQ3gue7uMq9rZ+y+pcgnfy0/vXsmU3bdWOdmjCxQUJQ
         Rjbw68XzTZYXqvJqJUyoCDcvJUdrhA41MY36yRjwDuZl3YesWFiMVH1Mdbop4Y3im6Lc
         TkWOswkPqf+tNOMxTOUILhWcFncQsuLc44gaSt9wGE5q+kuxV8sjdvtYyhKllcJn2bme
         hWzuUoFb89j3vUJpD69XlLAChdflHjB3Nb3BxMkh+4Ne6jZv/mkUC6+y1RtZLuYvhHrl
         bzNw==
X-Gm-Message-State: AOAM531yiCRtLtohT+/PeWxEt1cFTq4a0Jm1tNoccjHDiiBC20Xjxn7d
        v3MEB3mWRAHJP7vE0ZJu7c/mV6HWhrqeKz24/SpQDGG9IZb2+CptKUm8ddECiMWdcPFCUvhmWmc
        oo1RKjU2MfkfO
X-Received: by 2002:a17:906:6a1a:: with SMTP id qw26mr5794942ejc.454.1643063003241;
        Mon, 24 Jan 2022 14:23:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/8716fksKjT7h1gtcfWcvIT83G/teXeHSfZuelcx9XPN1OZLtilO1FMN72ciP7y3cZa5/tA==
X-Received: by 2002:a17:906:6a1a:: with SMTP id qw26mr5794923ejc.454.1643063002990;
        Mon, 24 Jan 2022 14:23:22 -0800 (PST)
Received: from krava ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id l2sm7162047eds.28.2022.01.24.14.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 14:23:22 -0800 (PST)
Date:   Mon, 24 Jan 2022 23:23:20 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH v3 0/9] fprobe: Introduce fprobe function entry/exit
 probe
Message-ID: <Ye8m2CpVI8VOiMTH@krava>
References: <164260419349.657731.13913104835063027148.stgit@devnote2>
 <CAEf4Bzbbimea3ydwafXSHFiEffYx5zAcwGNKk8Zi6QZ==Vn0Ug@mail.gmail.com>
 <20220121135510.7cfa6540e31824aa39b1c1b8@kernel.org>
 <CAEf4Bza0eTft2kjcm9HhKpAm=AuXnGwZfZ+sYpVVBvj93PBreQ@mail.gmail.com>
 <Ye3ptcW0eAFRYm58@krava>
 <20220124092405.665e9e0fc3ce14b16a1a9fcf@kernel.org>
 <Ye6ZyeHQtPfUoSvX@krava>
 <CAEf4BzbrVBXDJA4qbCgudiiLGtHNyUQAOuE=AUwfxzMrF=Wr=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbrVBXDJA4qbCgudiiLGtHNyUQAOuE=AUwfxzMrF=Wr=w@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 24, 2022 at 12:22:10PM -0800, Andrii Nakryiko wrote:

SNIP

> > > > > > > > (This testing patch is just for confirming the rethook is correctly
> > > > > > > >  implemented.)
> > > > > > > >
> > > > > > > > BTW, on the x86, ftrace (with fentry) location address is same as
> > > > > > > > symbol address. But on other archs, it will be different (e.g. arm64
> > > > > > > > will need 2 instructions to save link-register and call ftrace, the
> > > > > > > > 2nd instruction will be the ftrace location.)
> > > > > > > > Does libbpf correctly handle it?
> > > >
> > > > hm, I'm probably missing something, but should this be handled by arm
> > > > specific kernel code? user passes whatever is found in kallsyms, right?
> > >
> > > In x86, fentry nop is always placed at the first instruction of the function,
> > > but the other arches couldn't do that if they use LR (link register) for
> > > storing return address instead of stack. E.g. arm64 saves lr and call the
> > > ftrace. Then ftrace location address of a function is not the symbol address.
> > >
> > > Anyway, I updated fprobe to handle those cases. I also found some issues
> > > on rethook, so let me update the series again.
> >
> > great, I reworked the bpf fprobe link change and need to add the
> > symbols attachment support, so you don't need to include it in
> > new version.. I'll rebase it and send on top of your patchset
> 
> Using just addresses (IPs) for retsnoop and bpftrace is fine because
> such generic tools are already parsing kallsyms and probably building
> some lookup table. But in general, having IP-based attachment is a
> regression from current perf_event_open-based kprobe, where user is
> expected to pass symbolic function name. Using IPs has an advantage of
> being unambiguous (e.g., when same static function name in kernel
> belongs to multiple actual functions), so there is that. But I was
> also wondering wouldn't kernel need to do symbol to IP resolution
> anyways just to check that we are attaching to function entry?

ftrace does its own check for address to attach, it keeps record
for every attachable address.. so less work for us ;-)

> 
> I'll wait for your patch set to see how did you go about it in a new revision.

I agree we should have the support to use symbols as well, I'll add it

jirka

