Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCF26D8E4D
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 06:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbjDFEYU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 00:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjDFEYT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 00:24:19 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2B07AAC;
        Wed,  5 Apr 2023 21:24:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ew6so146141989edb.7;
        Wed, 05 Apr 2023 21:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680755052; x=1683347052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXsgvmzHukaaTecEY3Yt625/lLug2G4Dbez5De3xAOM=;
        b=Fdz+ZTUWOR98kFskw8WAXK8kkfJhEe1LRWVhn2tWMXz1ZAIrrAcpvrkN85FHGGEQCf
         V7LKb0DctSR2FCqZURuIwXiJ35yX98y/2K2ImkeD87WatEVmaJClsAYU6c5MwSInz2ed
         hNXO5GgM4v9qo6J7azUzy7TI1Ctc9tRJEo022aqC6epZK6uI03Z2N3mlaFau0UT1qFkA
         Ae8/wk3H3GGGDAIgYXt9PgKDQEU6T50qtNBU6oa5KDNYbougxMTd83LLMhci+5z4u3Vs
         5wsmFCiPxBbnDqFBg4JPZuBRnjnGqs4ZKchKcEmC5baRiE5HgMJjpJ3onSLdjF35jxWF
         qRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680755052; x=1683347052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXsgvmzHukaaTecEY3Yt625/lLug2G4Dbez5De3xAOM=;
        b=Hl2udt4tznJff8pt3E2JalpNwbpiUzdjshGE1Noek6Wiu8yg72sUGZ/5FQU/HdhbSo
         oNRJiqxcPGM01gcWiFhryLPwEKLnNHjjpM4JBmhfrm5SCHiWVsWDoQniY43BcKyFEfhV
         0lVL1ujMLr9zBpC6WcwF5laElxEnJpDMmabEL9TREIpeIHJYRapiWxFt9KKmBv5hf9KI
         gGbXFfcvfX0U40ivBOkjJSCsywyuuSWSEzHVax3JaG+wTKNkFNuoRK7bEAl6WIoHJ1TB
         1Tq6eseDZSNM3KVCTYB5VU9Jk8G/glrgNlCCM/2OLQSKmurIeTCrDTQyMVifNzWeSktK
         z33g==
X-Gm-Message-State: AAQBX9e4nKlsCVx3mdx9At8xdv1IwGtidQn6/U1iwomaW4l1L4c2Ej1Z
        njg4l3g9E3aX5zLipkg7Q49AevoRdL9KL7H36quaq2lP
X-Google-Smtp-Source: AKy350a9wYLbU5oSTk06jkpVn/2X4h/tjTlb5DJoEV6xT+TELnb0TC1J749GC+pE/8aOtz4ULJnFzbBUyZHCvVM8gFI=
X-Received: by 2002:a17:907:8a07:b0:924:32b2:e3d1 with SMTP id
 sc7-20020a1709078a0700b0092432b2e3d1mr2786379ejc.3.1680755052190; Wed, 05 Apr
 2023 21:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230326092208.13613-1-laoar.shao@gmail.com> <CAPhsuW43EiH0tVKU8s+JwV_V6EBETTDyXsAmMzAftpVtcgLHag@mail.gmail.com>
 <CALOAHbCqCb3xmSpNe1Qvm75GBY4ZEGrAOHfVJvpZV5t=akTTgQ@mail.gmail.com>
 <20230402233740.haxb7lgfavcoe27f@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbBj-+xY5jGLynUrg1GfSftZ+LT5DkADKz_+8+tL2kWMSw@mail.gmail.com>
 <20230403225017.onl5pbp7h2ugclbk@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbDQROKrWe732Qv1CsZwr6nMJN-2y77JW3EuT53D8At+Ow@mail.gmail.com>
 <20230406020656.7v5ongxyon5fr4s7@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbCEsucGRB+n5hTnPm-HssmB91HD4PFVRhdO=CZnJXfR6A@mail.gmail.com>
 <CAADnVQ+1VEBHTM5Rm-gx8-bg=tfv=4x+aONhF0bAmBFZG3W8Qg@mail.gmail.com> <CALOAHbAorooyteDjgs82TtujP4Fwo5hSkh-Z5QhxhV9p7_2mfw@mail.gmail.com>
In-Reply-To: <CALOAHbAorooyteDjgs82TtujP4Fwo5hSkh-Z5QhxhV9p7_2mfw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 5 Apr 2023 21:24:00 -0700
Message-ID: <CAADnVQKr5Y3z9f_Vv49DvRFcN+OF3JaFx_9NgBL58pz+TLq8ig@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 5, 2023 at 8:22=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Thu, Apr 6, 2023 at 11:06=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Apr 5, 2023 at 7:55=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > >
> > > It seems that I didn't describe the issue clearly.
> > > The container doesn't have CAP_SYS_ADMIN, but the CAP_SYS_ADMIN is
> > > required to run bpftool,  so the bpftool running in the container
> > > can't get the ID of bpf objects or convert IDs to FDs.
> > > Is there something that I missed ?
> >
> > Nothing. This is by design. bpftool needs sudo. That's all.
> >
>
> Hmm, what I'm trying to do is make bpftool run without sudo.

This is not a task that is worth solving.

> > > Some questions,
> > > - What if the process exits after attaching the bpf prog and the prog
> > > is not auto-detachable?
> > >   For example, the reuserport bpf prog is not auto-detachable. After
> > > pins the reuserport bpf prog, a task can attach it through the pinned
> > > bpf file, but if the task forgets to detach it and the pinned file is
> > > removed, then it seems there's no way to figure out which task or
> > > cgroup this prog belongs to...
> >
> > you're saying that there is a bpf prog in the kernel without
> > corresponding user space ?
>
> No, it is corresponding to user space. For example, it may be
> corresponding to a socket fd, or a cgroup fd.
>
> > Meaning no user space process has an FD
> > that points to this prog or FD to a map that this prog is using?
> > In such a case this is truly kernel bpf prog. It doesn't belong to cgro=
up.
> >
>
> Even if it is kernel bpf prog, it is created by a process. The user
> needs to know which one created it.

In some situations it's certainly interesting to know which process
loaded a particular program.
In many other situations it's irrelevant.
For example, the process that loaded a prog could have been moved to a
different cgroup.
If you want to track the loading you need to install bpf_lsm
that monitors prog_load hook and collect that info.
It's not the job of the kernel to do it.

> > > - Could you pls. explain in detail how to get comm, pid, or cgroup
> > > from a pinned bpffs file?
> >
> > pinned bpf prog and no user space holds FD to it?
> > It's not part of any cgroup. Nothing to print.
>
> As I explained above, even if it holds nothing, the user needs to know
> the information from it. For example, if it is expected, which one
> created it?

See the answer above. The kernel has enough hooks already to provide
this information to user space. No kernel changes necessary.
