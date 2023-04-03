Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686A16D3C00
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 05:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjDCDGI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Apr 2023 23:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDCDGH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Apr 2023 23:06:07 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D86C659D;
        Sun,  2 Apr 2023 20:06:02 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id n14so27030311qta.10;
        Sun, 02 Apr 2023 20:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680491161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVpHSWVPXPhCwMSet+5Qdfvz4A3AKximww2ubzxMDls=;
        b=NCEPTZzp7vT2RjILBwPZ851j1Z87CT9aGjL5VIUzghm3DTaDr06vg9TsQ46OM8Yvst
         eV2TNhziUC9veM8Bo+VY9ih7tx2q2oVKwTauiKQVtfrDRnLtX8jGLDe+p03VVRtENDFq
         5N7wiXi+8RJ4YqmPZXGDZZhmGfm+Xj7Gpw4l9QwK6et/NHiG5MOwOHkrLBvAjBzb/9vi
         cYi3XYdz5uNenMAu3JfXr+X1ENUvfukTEfVf2QPMcIZj9n5XNHTNNW5kWEaygwYZLqJ1
         zAoOcJPCXxNE5fpEgU4WHCScABiutyzpkqdbIDiEdRH49cTtjSnMJuwYXX7yR7f4yw3o
         gqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680491161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVpHSWVPXPhCwMSet+5Qdfvz4A3AKximww2ubzxMDls=;
        b=A/PWRHnezP2zgqhPF83UBot1b2uKvSY7sIgGhYa6l/ZWyPHWWWglYbgVC2+trUb3pU
         XgiQWav1gjP2K7XhUuvFz0vTh/f0QehfF+vDJ4ojJN/krkEzIVNZYTyLqQuy01N4yvHF
         E6/HtdfSgn6SruEap/dmEUUtGgNHQ4N9Big1hhjevCvHQg3QevGilngVJwHl7t2+lvVf
         lNPFty4OHTZN25NOnrLrJB7BwaBt2/pxPC/2ubi3/TVv1EPJdqE77Tke6mwgSFrqljWt
         SlNdam3TkZoPSJOaDUC6ZmtiUamrZrTjWAUJ34b1S1h2oOSyOyBuE6BumvhekqhMGkze
         aetg==
X-Gm-Message-State: AO0yUKW4UOCgRpQ9OemeOkDw4pLqcFYngVDRxLWLKSMjpPOLYXQ37qk8
        YajhZAq+Zg1e3FKZW+ei0mZHtZ3hWy+3QMGEbVM=
X-Google-Smtp-Source: AK7set/5mrV03m94+BlvYg6XHx+gP0ePwpQMiR7cBCL5RAycNI0TGe1Sqm2+ZsRCG7/zvMEzmxG3BBUc6BLS7VWgZKI=
X-Received: by 2002:a05:622a:1a02:b0:3e3:f70f:fb13 with SMTP id
 f2-20020a05622a1a0200b003e3f70ffb13mr12426978qtb.6.1680491161713; Sun, 02 Apr
 2023 20:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230326092208.13613-1-laoar.shao@gmail.com> <CAPhsuW43EiH0tVKU8s+JwV_V6EBETTDyXsAmMzAftpVtcgLHag@mail.gmail.com>
 <CALOAHbCqCb3xmSpNe1Qvm75GBY4ZEGrAOHfVJvpZV5t=akTTgQ@mail.gmail.com> <20230402233740.haxb7lgfavcoe27f@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230402233740.haxb7lgfavcoe27f@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 3 Apr 2023 11:05:25 +0800
Message-ID: <CALOAHbBj-+xY5jGLynUrg1GfSftZ+LT5DkADKz_+8+tL2kWMSw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Song Liu <song@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Apr 3, 2023 at 7:37=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Mar 28, 2023 at 11:47:31AM +0800, Yafang Shao wrote:
> > On Tue, Mar 28, 2023 at 3:04=E2=80=AFAM Song Liu <song@kernel.org> wrot=
e:
> > >
> > > On Sun, Mar 26, 2023 at 2:22=E2=80=AFAM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > Currently only CAP_SYS_ADMIN can iterate BPF object IDs and convert=
 IDs
> > > > to FDs, that's intended for BPF's security model[1]. Not only does =
it
> > > > prevent non-privilidged users from getting other users' bpf program=
, but
> > > > also it prevents the user from iterating his own bpf objects.
> > > >
> > > > In container environment, some users want to run bpf programs in th=
eir
> > > > containers. These users can run their bpf programs under CAP_BPF an=
d
> > > > some other specific CAPs, but they can't inspect their bpf programs=
 in a
> > > > generic way. For example, the bpftool can't be used as it requires
> > > > CAP_SYS_ADMIN. That is very inconvenient.
> > >
> > > Agreed that it is important to enable tools like bpftool without
> > > CAP_SYS_ADMIN. However, I am not sure whether we need a new
> > > namespace for this. Can we reuse some existing namespace for this?
> > >
> >
> > It seems we can't.
>
> Yafang,
>
> It's a Nack.
>
> The only thing you've been trying to "solve" with bpf namespace is to
> allow 'bpftool prog show' iterate progs in the "namespace" without CAP_SY=
S_ADMIN.
> The concept of bpf namespace is not even close to be thought through.

Right, it is more likely a PoC in its current state.

> Others pointed out the gaps in the design. Like bpffs. There are plenty.
> Please do not send patches like this in the future.

The reason I sent it with an early state is that I want to get some
early feedback from the community ahead of the LSF/MM/BPF workshop,
then I can improve it based on these feedbacks and present it more
specifically at the workshop. Then the discussion will be more
effective.

> You need to start with describing the problem you want to solve,
> then propose _several_ solutions, describe their pros and cons,
> solicit feedback, present at the conferences (like LSFMMBPF or LPC),
> and when the community agrees that 1. problem is worth solving,
> 2. the solution makes sense, only then work on patches.
>

I would like to give a short discussion on the BPF namespace if
everything goes fine.

> "In container environment, some users want to run bpf programs in their c=
ontainers."
> is something Song brought up at LSFMMBPF a year ago.
> At that meeting most of the folks agreed that there is a need to run bpf
> in containers and make sure that the effect of bpf prog is limited to a c=
ontainer.
> This new namespace that creates virtual IDs for progs and maps doesn't co=
me
> close in solving this task.

Currently in our production environment, all the containers running
bpf programs are privileged, that is risky. So actually the goal of
the BPF namespace is to make them (or part of them) non-privileged.
But some of the abilities of these bpf programs will be lost in this
procedure, like the debug-bility with bpftool, so we need to fix it.
Agree with you that this goal is far from making bpf programs safely
running in a container environment.

--=20
Regards
Yafang
