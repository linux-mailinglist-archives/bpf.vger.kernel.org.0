Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3946F200B
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 23:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345702AbjD1VTj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 17:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345610AbjD1VTi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 17:19:38 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB6B1FF7
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 14:19:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5055141a8fdso241871a12.3
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 14:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682716776; x=1685308776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iWd7BAFLDGaLG7tHAfGqEHFeECwXXfcDb4kWniOhdY=;
        b=NqHAVFTDQh2ZN82Ny4qXkCzogPlscOQnev5JdEapI4lc8f7FrAldScYasu0Zj2N3XE
         DbcA72WdKHHpoWw0bKz0I4XSeHww/3EpRmX0/ua9MCOjIJI5/rP99uQtYgtQNQHYtCJj
         oRdDbCurwvmSHHTpDZUHd5fq2MSFmeTXCzypTrT8kCadCNjMMpbRuFfudgb9uwty6NpG
         iTjkMR4iz4dK0uNwGjdysy8TiU2U1d4jAswDh2EFPmx+T69nwI/DEuXjF6hUlo3IZf57
         p+zkND2UU23boOiY9Gp9LNiZhaqnnmg80Z22AVrrLw/EqJveZtMDxHHLKUpD6eNlUlUA
         GilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682716776; x=1685308776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iWd7BAFLDGaLG7tHAfGqEHFeECwXXfcDb4kWniOhdY=;
        b=TYVLAZdvEiZJsHs4rcrBgd5ZEzhZdapH8GnIUATIJYqnWaHUgJbgdu4eJ8ub1s8ElT
         jqVYF7XsiwXCAV4PAOBWcbDawB3jKoRNp+trVR5cYoZJEywRjZJ7zK/Ab5qsgmVYOTik
         xgORZQIlAsdgwn7tA9rOxo7iEfEvGmiFxwChM53ntv7QjE+5rvcAYQIkjlpz5TH9NHWl
         V9OhZfWkgoLc8kz7MgrbjdYrAWj/jAXaJbwbPdwoMf4mssHIu1Nf34BjWRb0Lw971v1j
         LbqsyA6GHiyfh0PE0eCpZ+V8scSg0nj66KSQm1GSuFO08ar8sd0USGcJjTpsHpnob/fo
         P78A==
X-Gm-Message-State: AC+VfDz5wBGx1RPN/sQQU92Rz1gu/jWz86rMk50apqk0YsO0js1EOZlt
        0tsNr1E+ldHQYjnB4crsTN3MRL5JzRrf84CGNlU=
X-Google-Smtp-Source: ACHHUZ6NH3BQExw7R6s9qTkDVhvigsjJ+Vkwpb9MRfOA0IoXU9VFq+cq7uhn/Ome24b/b+ym6ma00PWsg4RRJQMv128=
X-Received: by 2002:a05:6402:183:b0:50a:11ce:4d24 with SMTP id
 r3-20020a056402018300b0050a11ce4d24mr172499edv.15.1682716775514; Fri, 28 Apr
 2023 14:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230424160447.2005755-1-jolsa@kernel.org> <CAEf4BzbCogCFVmr-C4XQNR4KF3_kj_yFeeTcevdmfm1veu-26w@mail.gmail.com>
 <ZEpuEUTAOZ2XoYPt@krava> <CAEf4BzZaj0Y_PhMVOfa5fpAMbStevjdrKxq3jfTA2Bq4VjtvDg@mail.gmail.com>
 <ZEumD2RvDfvEs2o5@krava>
In-Reply-To: <ZEumD2RvDfvEs2o5@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 28 Apr 2023 14:19:23 -0700
Message-ID: <CAEf4Bza13OFvDToApa58i2wZvN4=-0=p0p55-eAEEyYXmAKxkg@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next 00/20] bpf: Add multi uprobe link
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Viktor Malik <viktor.malik@gmail.com>,
        Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 28, 2023 at 3:55=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Apr 27, 2023 at 03:24:25PM -0700, Andrii Nakryiko wrote:
> > On Thu, Apr 27, 2023 at 5:44=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Wed, Apr 26, 2023 at 12:09:59PM -0700, Andrii Nakryiko wrote:
> > > > On Mon, Apr 24, 2023 at 9:04=E2=80=AFAM Jiri Olsa <jolsa@kernel.org=
> wrote:
> > > > >
> > > > > hi,
> > > > > this patchset is adding support to attach multiple uprobes and us=
dt probes
> > > > > through new uprobe_multi link.
> > > > >
> > > > > The current uprobe is attached through the perf event and attachi=
ng many
> > > > > uprobes takes a lot of time because of that.
> > > > >
> > > > > The main reason is that we need to install perf event for each pr=
obed function
> > > > > and profile shows perf event installation (perf_install_in_contex=
t) as culprit.
> > > > >
> > > > > The new uprobe_multi link just creates raw uprobes and attaches t=
he bpf
> > > > > program to them without perf event being involved.
> > > > >
> > > > > In addition to being faster we also save file descriptors. For th=
e current
> > > > > uprobe attach we use extra perf event fd for each probed function=
. The new
> > > > > link just need one fd that covers all the functions we are attach=
ing to.
> > > >
> > > > All of the above are good reasons and thanks for tackling multi-upr=
obe!
> > > >
> > > > >
> > > > > By dropping perf we lose the ability to attach uprobe to specific=
 pid.
> > > > > We can workaround that by having pid check directly in the bpf pr=
ogram,
> > > > > but we might need to check for another solution if that will turn=
 out
> > > > > to be a problem.
> > > > >
> > > >
> > > > I think this is a big deal, because it makes multi-uprobe not a
> > > > drop-in replacement for normal uprobes even for typical scenarios. =
It
> > > > might be why you couldn't do transparent use of uprobe.multi in USD=
T?
> > >
> > > yes
> > >
> > > >
> > > > But I'm not sure why this is a problem? How does perf handle this?
> > > > Does it do runtime filtering or something more efficient that preve=
nts
> > > > uprobe to be triggered for other PIDs in the first place? If it's t=
he
> > > > former, then why can't we do the same simple check ourselves if pid
> > > > filter is specified?
> > >
> > > so the standard uprobe is basically a perf event and as such it can b=
e
> > > created with 'pid' as a target.. and such perf event will get install=
ed
> > > only when the process with that pid is scheduled in and uninstalled
> > > when it's scheduled out
> > >
> > > >
> > > > I also see that uprobe_consumer has filter callback, not sure if it=
's
> > > > a better solution just for pid filtering, but might be another way =
to
> > > > do this?
> > >
> > > yes, that's probably how we will have to do that, will check
> >
> > callback seems like overkill as we'll be paying indirect call price.
> > So a simple if statement in either uprobe_prog_run or in
> > uprobe_multi_link_ret_handler/uprobe_multi_link_handler seems like
> > better solution, IMO.
>
> it looks like the consumer->filter is checked/executed before installing
> the breakpoint for uprobe, so it could be actually faster than current
> uprobe pid filter.. I'll check and have it there in next version

ah, so if it's not executed on each uprobe run, then yeah, that would be be=
st

>
> >
> >
> > >
> > > >
> > > > Another aspect I wanted to discuss (and I don't know the right answ=
er)
> > > > was whether we need to support separate binary path for each offset=
?
> > > > It would simplify (and trim down memory usage significantly) a bunc=
h
> > > > of internals if we knew we are dealing with single inode for each
> > > > multi-uprobe link. I'm trying to think if it would be limiting in
> > > > practice to have to create link per each binary, and so far it seem=
s
> > > > like usually user-space code will do symbol resolution per ELF file
> > > > anyways, so doesn't seem limiting to have single path + multiple
> > > > offsets/cookies within that file. For USDTs use case even ref_ctr i=
s
> > > > probably the same, but I'd keep it 1:1 with offset and cookie anywa=
ys.
> > > > For uniformity and generality.
> > > >
> > > > WDYT?
> > >
> > > right, it's waste for single binary, but I guess it's not a big waste=
,
> > > because when you have single binary you just repeat the same pointer,
> > > not the path
> > >
> > > it's fast enough to be called multiple times for each binary you want
> > > to trace, but it'd be also nice to be able to attach all in once ;-)
> > >
> > > maybe we could have a bit in flags saying paths[0] is valid for all
> >
> > No need for extra flags. I was just thinking about having a simpler
> > and more straightforward API, where you don't need to create another
> > array with tons of duplicated string pointers. No big deal, I'm fine
> > either way.
>
> ok
>
> thanks,
> jirka
