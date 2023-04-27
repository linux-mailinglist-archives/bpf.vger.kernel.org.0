Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438216F0E50
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 00:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344065AbjD0WYm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 18:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344032AbjD0WYl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 18:24:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33642715
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 15:24:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94f7a0818aeso1428720366b.2
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 15:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682634278; x=1685226278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BKGxV2sd7b5ZjBU0VYs5O7TbPu5WekN5VI+jHbSxCU=;
        b=ANp6TV68dKptg9Wtn4sYMPQ07ArkJIaq+k8R+U/Sbrhd7BVu9qU8QBsH/kj/BLnhy8
         BTlWZOshq+D1csRBaZvFJlE56akd8b7FQ4ohXaIObEgbO/AcM0eA3gnv7QSdNms9Js3n
         pjr7GA21Jdw8z4+egyoWfh0DItaUx7NSMhYEVEyJDTebCu6yCVDq3oWYdv3tcA17ZmMR
         r+cOxCzBqixKmBFpQ6pfU4WdiZRzOrdP8AprE+FzAAEiA/scmjod80zZbNigzFucky2N
         KkGZHxUVEC9wSXBh2VBsx5egT3tTLO2g0t8rajetMu9I9nPy/fr7aLuXU5b+Lw2c7JtS
         1LGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682634278; x=1685226278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BKGxV2sd7b5ZjBU0VYs5O7TbPu5WekN5VI+jHbSxCU=;
        b=KKGCv7/Y5oegj92DqQXPwgsapvwqbuVsiWiPsetY52SZUJRAxqsBTVPmAKTrlF2twU
         YIsgl9eu1XORCnToY5iYCYXVYyy0WaS/frO13M0ZSv9YflG2BWR5NS0UQj3lQy00MuKy
         hP0/VljPXNd6ZS7yfJfdijb9C1ShE1I++REqpyz6p/XddiKrSalrQctcusEbjuLwBrMp
         kjZMXwI3LkRHmWweUGsVEbTAmJy2AslzAmy2NAkCzykK9vU+0UBBeiuYe4hU7VubVByg
         YjUpYqY4KX8jPsED/uojTG311oQGks3kOwH4iVObEq8MqPW4Gsf8pXkeStYFTaOkcN8C
         ISjQ==
X-Gm-Message-State: AC+VfDyT0/4BdIUnkMPHbgdfxw0sJEZ8/BHpeWvdy74RAtZt10PoQ7hH
        ifWxA2avZva/WlX2g+PY100f750FqWoF6wstd74=
X-Google-Smtp-Source: ACHHUZ6tPqYC8CbgEf+OGLQ8kWNmX1vLA3JJkYq2xAivglCeUNYNeNl80fe3djSXQc0mmwASCLubSD+mZP4ch1ZtRGI=
X-Received: by 2002:a17:907:97c9:b0:953:43a1:1988 with SMTP id
 js9-20020a17090797c900b0095343a11988mr2725588ejc.46.1682634278254; Thu, 27
 Apr 2023 15:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230424160447.2005755-1-jolsa@kernel.org> <CAEf4BzbCogCFVmr-C4XQNR4KF3_kj_yFeeTcevdmfm1veu-26w@mail.gmail.com>
 <ZEpuEUTAOZ2XoYPt@krava>
In-Reply-To: <ZEpuEUTAOZ2XoYPt@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 Apr 2023 15:24:25 -0700
Message-ID: <CAEf4BzZaj0Y_PhMVOfa5fpAMbStevjdrKxq3jfTA2Bq4VjtvDg@mail.gmail.com>
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

On Thu, Apr 27, 2023 at 5:44=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Apr 26, 2023 at 12:09:59PM -0700, Andrii Nakryiko wrote:
> > On Mon, Apr 24, 2023 at 9:04=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > hi,
> > > this patchset is adding support to attach multiple uprobes and usdt p=
robes
> > > through new uprobe_multi link.
> > >
> > > The current uprobe is attached through the perf event and attaching m=
any
> > > uprobes takes a lot of time because of that.
> > >
> > > The main reason is that we need to install perf event for each probed=
 function
> > > and profile shows perf event installation (perf_install_in_context) a=
s culprit.
> > >
> > > The new uprobe_multi link just creates raw uprobes and attaches the b=
pf
> > > program to them without perf event being involved.
> > >
> > > In addition to being faster we also save file descriptors. For the cu=
rrent
> > > uprobe attach we use extra perf event fd for each probed function. Th=
e new
> > > link just need one fd that covers all the functions we are attaching =
to.
> >
> > All of the above are good reasons and thanks for tackling multi-uprobe!
> >
> > >
> > > By dropping perf we lose the ability to attach uprobe to specific pid=
.
> > > We can workaround that by having pid check directly in the bpf progra=
m,
> > > but we might need to check for another solution if that will turn out
> > > to be a problem.
> > >
> >
> > I think this is a big deal, because it makes multi-uprobe not a
> > drop-in replacement for normal uprobes even for typical scenarios. It
> > might be why you couldn't do transparent use of uprobe.multi in USDT?
>
> yes
>
> >
> > But I'm not sure why this is a problem? How does perf handle this?
> > Does it do runtime filtering or something more efficient that prevents
> > uprobe to be triggered for other PIDs in the first place? If it's the
> > former, then why can't we do the same simple check ourselves if pid
> > filter is specified?
>
> so the standard uprobe is basically a perf event and as such it can be
> created with 'pid' as a target.. and such perf event will get installed
> only when the process with that pid is scheduled in and uninstalled
> when it's scheduled out
>
> >
> > I also see that uprobe_consumer has filter callback, not sure if it's
> > a better solution just for pid filtering, but might be another way to
> > do this?
>
> yes, that's probably how we will have to do that, will check

callback seems like overkill as we'll be paying indirect call price.
So a simple if statement in either uprobe_prog_run or in
uprobe_multi_link_ret_handler/uprobe_multi_link_handler seems like
better solution, IMO.


>
> >
> > Another aspect I wanted to discuss (and I don't know the right answer)
> > was whether we need to support separate binary path for each offset?
> > It would simplify (and trim down memory usage significantly) a bunch
> > of internals if we knew we are dealing with single inode for each
> > multi-uprobe link. I'm trying to think if it would be limiting in
> > practice to have to create link per each binary, and so far it seems
> > like usually user-space code will do symbol resolution per ELF file
> > anyways, so doesn't seem limiting to have single path + multiple
> > offsets/cookies within that file. For USDTs use case even ref_ctr is
> > probably the same, but I'd keep it 1:1 with offset and cookie anyways.
> > For uniformity and generality.
> >
> > WDYT?
>
> right, it's waste for single binary, but I guess it's not a big waste,
> because when you have single binary you just repeat the same pointer,
> not the path
>
> it's fast enough to be called multiple times for each binary you want
> to trace, but it'd be also nice to be able to attach all in once ;-)
>
> maybe we could have a bit in flags saying paths[0] is valid for all

No need for extra flags. I was just thinking about having a simpler
and more straightforward API, where you don't need to create another
array with tons of duplicated string pointers. No big deal, I'm fine
either way.

>
> >
> > >
> > > Attaching current bpftrace to 1000 uprobes:
> > >
> > >   # BPFTRACE_MAX_PROBES=3D100000 perf stat -e cycles,instructions \
> > >     ./bpftrace -e 'uprobe:./uprobe_multi:uprobe_multi_func_* { }, i:m=
s:1 { exit(); }'
> > >     ...
> > >
> > >      126,666,390,509      cycles
> > >       29,973,207,307      instructions                     #    0.24 =
 insn per cycle
> > >
> > >         85.284833554 seconds time elapsed
> > >
> > >
> > > Same bpftrace setup with uprobe_multi support:
> > >
> > >   # perf stat -e cycles,instructions \
> > >     ./bpftrace -e 'uprobe:./uprobe_multi:uprobe_multi_func_* { }, i:m=
s:1 { exit(); }'
> > >     ...
> > >
> > >        6,818,470,649      cycles
> > >       13,275,510,122      instructions                     #    1.95 =
 insn per cycle
> > >
> > >          1.943269451 seconds time elapsed
> > >
> > >
> > > I'm sending this as RFC because of:
> > >   - I added/exported some new elf_* helper functions in libbpf,
> > >     and I'm not sure that's the best/right way of doing this
> >
> > didn't get to that yet, sounds suspicious :)
> >
> > >   - I'm not completely sure about the usdt integration in bpf_program=
__attach_usdt,
> > >     I was trying to detect uprobe_multi kernel support first, but end=
ed up with
> > >     just new field for struct bpf_usdt_opts
> >
> > haven't gotten to this yet as well, but it has to be auto-detectable,
> > not an option (at least I don't see why it wouldn't be, but let me get
> > to the patch)
>
> thanks,
> jirka
