Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCC36F0608
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 14:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243788AbjD0MoI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 08:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243517AbjD0MoH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 08:44:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8A3E78
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 05:44:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f315735514so21770425e9.1
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 05:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682599444; x=1685191444;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V1ZyRoh8JO8Pmby88tKfy3l2M9+0WcCXNZ4berods00=;
        b=BtB6Ito6WSnEbLHc4IAchoD+TTq1ceIBJHoLLm1OcGgGUwdR7lSGxnxpDUvTX9qNwp
         65J5RSftDq4KJ4H/RvOHqFUmnX0DR2R3lOyZm9uJ/KWJZUNVnNeCFVzsjrdbTfUPKO7c
         0x5ONvDOQ6CB1qZ5+UujLNlfzlZ4zZomKePKfZia61MffXEbL99yNyV2wMLbDl0hX7OV
         MtfT00qGV/x+x4VgbA3M7mYefrjJ/kA238bYtur+FgMcgO9G5IAYutAifhbor2mPcbDR
         wAYCdNRBjxZ13Lznz+ZdTOaR0dv9TRpVaoVeGcw8DKtERQySTahopNeZWM0Mp0t4pLdr
         oSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682599444; x=1685191444;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1ZyRoh8JO8Pmby88tKfy3l2M9+0WcCXNZ4berods00=;
        b=PS4w8ZR5lrso8ZrY1co3mEwgrJdSrgI8LJOf64c/mewItEo5OmxJ2GwcV6GTJXqg5r
         sR+Tje5UwpH7C7UOhq5MZC/5xAr1hqsg9gEUfLHveSdN2RNLA47/SwsAcb3cI73C7RBS
         2KCjzHwFHTXUubWcZTobRqsJQkdYT3vVI+D8pnnenic8R09rOdIM/Q+Flu1EKk8dXIz/
         tbaEtB2/F8RuO2kkGrH7HNJcyCg9xfu38zChG5CGkgvZXGnpZQPlt/cClA3zoOyPZbNF
         ekROfnTKNs3TaiBYe1ztBzyucAifB1y1MhbxilubPmZknIicTAmOVs1nhxiyVr4tLl86
         6GPQ==
X-Gm-Message-State: AC+VfDz3SDiRM5YVTtXu8/Ph+hiG9REJtX2PHqAATw1mDVV5R3EbSoH5
        n3ulInE+bDY8EaxTpDoer6w=
X-Google-Smtp-Source: ACHHUZ6ggAEiM61+fcwf/R1HEC7evu06TDrsDP8ioME5d/kLr1YH0peUVR7TflxFBXQ3HdZaz6OMJA==
X-Received: by 2002:a7b:c7c4:0:b0:3f1:6f57:6fd1 with SMTP id z4-20020a7bc7c4000000b003f16f576fd1mr1593524wmk.9.1682599444225;
        Thu, 27 Apr 2023 05:44:04 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c444900b003f173be2ccfsm32469279wmn.2.2023.04.27.05.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 05:44:03 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 27 Apr 2023 14:44:01 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Subject: Re: [RFC/PATCH bpf-next 00/20] bpf: Add multi uprobe link
Message-ID: <ZEpuEUTAOZ2XoYPt@krava>
References: <20230424160447.2005755-1-jolsa@kernel.org>
 <CAEf4BzbCogCFVmr-C4XQNR4KF3_kj_yFeeTcevdmfm1veu-26w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbCogCFVmr-C4XQNR4KF3_kj_yFeeTcevdmfm1veu-26w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 26, 2023 at 12:09:59PM -0700, Andrii Nakryiko wrote:
> On Mon, Apr 24, 2023 at 9:04 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > this patchset is adding support to attach multiple uprobes and usdt probes
> > through new uprobe_multi link.
> >
> > The current uprobe is attached through the perf event and attaching many
> > uprobes takes a lot of time because of that.
> >
> > The main reason is that we need to install perf event for each probed function
> > and profile shows perf event installation (perf_install_in_context) as culprit.
> >
> > The new uprobe_multi link just creates raw uprobes and attaches the bpf
> > program to them without perf event being involved.
> >
> > In addition to being faster we also save file descriptors. For the current
> > uprobe attach we use extra perf event fd for each probed function. The new
> > link just need one fd that covers all the functions we are attaching to.
> 
> All of the above are good reasons and thanks for tackling multi-uprobe!
> 
> >
> > By dropping perf we lose the ability to attach uprobe to specific pid.
> > We can workaround that by having pid check directly in the bpf program,
> > but we might need to check for another solution if that will turn out
> > to be a problem.
> >
> 
> I think this is a big deal, because it makes multi-uprobe not a
> drop-in replacement for normal uprobes even for typical scenarios. It
> might be why you couldn't do transparent use of uprobe.multi in USDT?

yes

> 
> But I'm not sure why this is a problem? How does perf handle this?
> Does it do runtime filtering or something more efficient that prevents
> uprobe to be triggered for other PIDs in the first place? If it's the
> former, then why can't we do the same simple check ourselves if pid
> filter is specified?

so the standard uprobe is basically a perf event and as such it can be
created with 'pid' as a target.. and such perf event will get installed
only when the process with that pid is scheduled in and uninstalled
when it's scheduled out

> 
> I also see that uprobe_consumer has filter callback, not sure if it's
> a better solution just for pid filtering, but might be another way to
> do this?

yes, that's probably how we will have to do that, will check

> 
> Another aspect I wanted to discuss (and I don't know the right answer)
> was whether we need to support separate binary path for each offset?
> It would simplify (and trim down memory usage significantly) a bunch
> of internals if we knew we are dealing with single inode for each
> multi-uprobe link. I'm trying to think if it would be limiting in
> practice to have to create link per each binary, and so far it seems
> like usually user-space code will do symbol resolution per ELF file
> anyways, so doesn't seem limiting to have single path + multiple
> offsets/cookies within that file. For USDTs use case even ref_ctr is
> probably the same, but I'd keep it 1:1 with offset and cookie anyways.
> For uniformity and generality.
> 
> WDYT?

right, it's waste for single binary, but I guess it's not a big waste,
because when you have single binary you just repeat the same pointer,
not the path

it's fast enough to be called multiple times for each binary you want
to trace, but it'd be also nice to be able to attach all in once ;-)

maybe we could have a bit in flags saying paths[0] is valid for all

> 
> >
> > Attaching current bpftrace to 1000 uprobes:
> >
> >   # BPFTRACE_MAX_PROBES=100000 perf stat -e cycles,instructions \
> >     ./bpftrace -e 'uprobe:./uprobe_multi:uprobe_multi_func_* { }, i:ms:1 { exit(); }'
> >     ...
> >
> >      126,666,390,509      cycles
> >       29,973,207,307      instructions                     #    0.24  insn per cycle
> >
> >         85.284833554 seconds time elapsed
> >
> >
> > Same bpftrace setup with uprobe_multi support:
> >
> >   # perf stat -e cycles,instructions \
> >     ./bpftrace -e 'uprobe:./uprobe_multi:uprobe_multi_func_* { }, i:ms:1 { exit(); }'
> >     ...
> >
> >        6,818,470,649      cycles
> >       13,275,510,122      instructions                     #    1.95  insn per cycle
> >
> >          1.943269451 seconds time elapsed
> >
> >
> > I'm sending this as RFC because of:
> >   - I added/exported some new elf_* helper functions in libbpf,
> >     and I'm not sure that's the best/right way of doing this
> 
> didn't get to that yet, sounds suspicious :)
> 
> >   - I'm not completely sure about the usdt integration in bpf_program__attach_usdt,
> >     I was trying to detect uprobe_multi kernel support first, but ended up with
> >     just new field for struct bpf_usdt_opts
> 
> haven't gotten to this yet as well, but it has to be auto-detectable,
> not an option (at least I don't see why it wouldn't be, but let me get
> to the patch)

thanks,
jirka
