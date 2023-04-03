Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009226D54DE
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 00:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjDCWuX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 18:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjDCWuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 18:50:23 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0182724;
        Mon,  3 Apr 2023 15:50:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w4so29513870plg.9;
        Mon, 03 Apr 2023 15:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680562221; x=1683154221;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HzYZ35hX6WBNT4wjT4vhfFBdjAnCWzBZd6L9rd9Paa0=;
        b=ViIFmgKim0TbdZVc3THk3ycR5r7rKepDuCLA2MU1rSpwHxU9lpMgiFOkUtRrF4SLvZ
         a0BcAix1zHvyso2wUghai75CkJNdbE9z+2A0sFB92KK5b7oNGBGLpGh/rYxo3N4Rn5R1
         fCdgP4mg0+2a4qZN2dXDs6TgWomEMBWKiTqaOoI3EYKx4GwCAfHOa8BDJafEq5m00LNv
         lFFXlDk9oFGO7PucYHshZ/H/gnfbpMXQntnqeAR8MvqEOkkbN6DJGFSIVPG0C6qEhLmr
         NaU8mBYtb4DiP1Fsi740bOJYOgBxOW67CvYvp1qv2y8IN+0EiWYA6T88HdHehIvz7+mf
         V/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680562221; x=1683154221;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HzYZ35hX6WBNT4wjT4vhfFBdjAnCWzBZd6L9rd9Paa0=;
        b=q+8cUU4kWJ0K9gnOz+nFuJ+QrTcpebt2klounct8RCNTVLSG3h8FW0w6yx1KQd2Dct
         LbHXjBNMcqSUQhsHNECUdzwTossLmJxUIASab/25mY4IZk2z1fiUk7189F31hkn3GS3c
         P8UYJExSni37+YiGUqOn4G6hpwuEYtz9/2XDTeT4vKYZKIKKwgfH4UMGV1UsSHT6KHqM
         niBsAmMfzNwFMnTgpAlhvcCg859MaxAFDeeBczN7Sr+J/auwthY6NlEhkdrJzuz3R6sm
         NGLN7FLJX1awFyTfduj0hciEzULNMJjx1x80g4ToypE00lOo982eq+1xP6rQLFkRHMho
         4RhQ==
X-Gm-Message-State: AAQBX9dJM+cdb6hGGlYAt1Z4P5dv2x9TfPwd5wVAp1DlH333lrl+AlgJ
        Hbbbh3fr8R6d9LKKfvDE2bc=
X-Google-Smtp-Source: AKy350YBqrxWWC4KtRFS0hy2Z/ju5NYK6Wgzx6hmc7awYhetSLotX8mL42N5wbP0RMN9ckB99weUoQ==
X-Received: by 2002:a17:902:cf4f:b0:1a1:a8eb:d33e with SMTP id e15-20020a170902cf4f00b001a1a8ebd33emr644890plg.8.1680562221199;
        Mon, 03 Apr 2023 15:50:21 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:3c8])
        by smtp.gmail.com with ESMTPSA id ji13-20020a170903324d00b001a1cf0744a2sm7137093plb.247.2023.04.03.15.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 15:50:20 -0700 (PDT)
Date:   Mon, 3 Apr 2023 15:50:17 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Song Liu <song@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
Message-ID: <20230403225017.onl5pbp7h2ugclbk@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230326092208.13613-1-laoar.shao@gmail.com>
 <CAPhsuW43EiH0tVKU8s+JwV_V6EBETTDyXsAmMzAftpVtcgLHag@mail.gmail.com>
 <CALOAHbCqCb3xmSpNe1Qvm75GBY4ZEGrAOHfVJvpZV5t=akTTgQ@mail.gmail.com>
 <20230402233740.haxb7lgfavcoe27f@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbBj-+xY5jGLynUrg1GfSftZ+LT5DkADKz_+8+tL2kWMSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbBj-+xY5jGLynUrg1GfSftZ+LT5DkADKz_+8+tL2kWMSw@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 03, 2023 at 11:05:25AM +0800, Yafang Shao wrote:
> On Mon, Apr 3, 2023 at 7:37 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Mar 28, 2023 at 11:47:31AM +0800, Yafang Shao wrote:
> > > On Tue, Mar 28, 2023 at 3:04 AM Song Liu <song@kernel.org> wrote:
> > > >
> > > > On Sun, Mar 26, 2023 at 2:22 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > > >
> > > > > Currently only CAP_SYS_ADMIN can iterate BPF object IDs and convert IDs
> > > > > to FDs, that's intended for BPF's security model[1]. Not only does it
> > > > > prevent non-privilidged users from getting other users' bpf program, but
> > > > > also it prevents the user from iterating his own bpf objects.
> > > > >
> > > > > In container environment, some users want to run bpf programs in their
> > > > > containers. These users can run their bpf programs under CAP_BPF and
> > > > > some other specific CAPs, but they can't inspect their bpf programs in a
> > > > > generic way. For example, the bpftool can't be used as it requires
> > > > > CAP_SYS_ADMIN. That is very inconvenient.
> > > >
> > > > Agreed that it is important to enable tools like bpftool without
> > > > CAP_SYS_ADMIN. However, I am not sure whether we need a new
> > > > namespace for this. Can we reuse some existing namespace for this?
> > > >
> > >
> > > It seems we can't.
> >
> > Yafang,
> >
> > It's a Nack.
> >
> > The only thing you've been trying to "solve" with bpf namespace is to
> > allow 'bpftool prog show' iterate progs in the "namespace" without CAP_SYS_ADMIN.
> > The concept of bpf namespace is not even close to be thought through.
> 
> Right, it is more likely a PoC in its current state.
> 
> > Others pointed out the gaps in the design. Like bpffs. There are plenty.
> > Please do not send patches like this in the future.
> 
> The reason I sent it with an early state is that I want to get some
> early feedback from the community ahead of the LSF/MM/BPF workshop,
> then I can improve it based on these feedbacks and present it more
> specifically at the workshop. Then the discussion will be more
> effective.
> 
> > You need to start with describing the problem you want to solve,
> > then propose _several_ solutions, describe their pros and cons,
> > solicit feedback, present at the conferences (like LSFMMBPF or LPC),
> > and when the community agrees that 1. problem is worth solving,
> > 2. the solution makes sense, only then work on patches.
> >
> 
> I would like to give a short discussion on the BPF namespace if
> everything goes fine.

Not in this shape of BPF namespace as done in this patch set.
We've talked about BPF namespace in the past. This is not it.

> > "In container environment, some users want to run bpf programs in their containers."
> > is something Song brought up at LSFMMBPF a year ago.
> > At that meeting most of the folks agreed that there is a need to run bpf
> > in containers and make sure that the effect of bpf prog is limited to a container.
> > This new namespace that creates virtual IDs for progs and maps doesn't come
> > close in solving this task.
> 
> Currently in our production environment, all the containers running
> bpf programs are privileged, that is risky. So actually the goal of
> the BPF namespace is to make them (or part of them) non-privileged.
> But some of the abilities of these bpf programs will be lost in this
> procedure, like the debug-bility with bpftool, so we need to fix it.
> Agree with you that this goal is far from making bpf programs safely
> running in a container environment.

I disagree that allowing admin to run bpftool without sudo is a task
worth solving. The visibility of bpf progs in a container is a different task.
Without doing any kernel changes we can add a flag to bpftool to let
'bpftool prog show' list progs that were loaded by processes in the same cgroup.
bpftool already does prog->pid mapping with bpf iterators.
It can filter by cgroup just as well.
