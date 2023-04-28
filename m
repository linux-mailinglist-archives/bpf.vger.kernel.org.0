Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0A06F1618
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 12:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345699AbjD1Kz0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 06:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345729AbjD1KzS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 06:55:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9181211C
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 03:55:15 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f182d745deso96438495e9.0
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 03:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682679314; x=1685271314;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O6y1BM7sJx78pClJ9c1x2f53ywnKF20R2M17ETNTSZY=;
        b=Db41/o8NlQ+TBrrauIMonjvpkI864TgNp/q5vr/POn+FWgSJ4w+Hefq9Ifc33A1k51
         HzB8NGu/NYV2VBtatE6n45qtytqxh6+aARW6qIAaMr5whQBEU37p5SViIRA/aecmVLE7
         kOO0y0zqlSThyZWdPBml9/ysyvda7a8w41l2RKs5m9yLAcwwCkufsbg7vtzEo2ZEKmo/
         yLAUQzvy+mQ7nc0jnIaUzkD8aBJstQOvZvjOHbCl/7CqBrVonUG30fUVwiQ8RFMmvMxB
         +iDBpXZHoDMaClXxRUTq502m//ilnqpre3C3dVhs3eXpJDPWp1tqcltbXzlOptDKY/q+
         RFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682679314; x=1685271314;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6y1BM7sJx78pClJ9c1x2f53ywnKF20R2M17ETNTSZY=;
        b=JV4+y7A8ZbNU3qK3XOcAG5ZxqVkUeowzJaDcETMq9aS1g/ZmLK4HIvlvlvyqOVTvrh
         rpBarUpvF2iNMRz0yLAQZkh5cCVr2lTH6Sq2zouYS9kuMys9wHdFl9i2ZhW08jwi2L7b
         kVp0AzxDut/Eh+Fe58uvPe1F8qoZVjJ0CVE9Rbb3HGIKedfxTjxcXMCxGI++tdq0Vsbx
         4txD9jjoTEvyitMvFztQjgtW5TPpKuKcjUJ4E1bnszkpb+Nl2phZnnpp4pOjrlZslG+B
         E+eiMlpob1xXFUwgojkmJHcW/+zJ3VJhIFSEvj0Vt+GXDC1JzTAJ8E8CJZ/RSsCk/Rh6
         7+qg==
X-Gm-Message-State: AC+VfDzKA1HHPE8Pt1IZGzQb8UAHPUXbDgIeFpC/EVkbjRN6Wqmq5cZA
        BuojFTyAlPUeD9lbN1gJx2lhJoLaOaPX4w==
X-Google-Smtp-Source: ACHHUZ5hBrfVah2gzGQzz0Mx8iWHb9RVWixJLUskGvpdya6oLA7pWy5N/gMjymK3qV1SA3RsbloypQ==
X-Received: by 2002:a7b:c7d3:0:b0:3ef:622c:26d3 with SMTP id z19-20020a7bc7d3000000b003ef622c26d3mr3727505wmk.35.1682679314007;
        Fri, 28 Apr 2023 03:55:14 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c358e00b003f188f608b9sm24813318wmq.8.2023.04.28.03.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 03:55:13 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 28 Apr 2023 12:55:11 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <ZEumD2RvDfvEs2o5@krava>
References: <20230424160447.2005755-1-jolsa@kernel.org>
 <CAEf4BzbCogCFVmr-C4XQNR4KF3_kj_yFeeTcevdmfm1veu-26w@mail.gmail.com>
 <ZEpuEUTAOZ2XoYPt@krava>
 <CAEf4BzZaj0Y_PhMVOfa5fpAMbStevjdrKxq3jfTA2Bq4VjtvDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZaj0Y_PhMVOfa5fpAMbStevjdrKxq3jfTA2Bq4VjtvDg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 27, 2023 at 03:24:25PM -0700, Andrii Nakryiko wrote:
> On Thu, Apr 27, 2023 at 5:44 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Apr 26, 2023 at 12:09:59PM -0700, Andrii Nakryiko wrote:
> > > On Mon, Apr 24, 2023 at 9:04 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > hi,
> > > > this patchset is adding support to attach multiple uprobes and usdt probes
> > > > through new uprobe_multi link.
> > > >
> > > > The current uprobe is attached through the perf event and attaching many
> > > > uprobes takes a lot of time because of that.
> > > >
> > > > The main reason is that we need to install perf event for each probed function
> > > > and profile shows perf event installation (perf_install_in_context) as culprit.
> > > >
> > > > The new uprobe_multi link just creates raw uprobes and attaches the bpf
> > > > program to them without perf event being involved.
> > > >
> > > > In addition to being faster we also save file descriptors. For the current
> > > > uprobe attach we use extra perf event fd for each probed function. The new
> > > > link just need one fd that covers all the functions we are attaching to.
> > >
> > > All of the above are good reasons and thanks for tackling multi-uprobe!
> > >
> > > >
> > > > By dropping perf we lose the ability to attach uprobe to specific pid.
> > > > We can workaround that by having pid check directly in the bpf program,
> > > > but we might need to check for another solution if that will turn out
> > > > to be a problem.
> > > >
> > >
> > > I think this is a big deal, because it makes multi-uprobe not a
> > > drop-in replacement for normal uprobes even for typical scenarios. It
> > > might be why you couldn't do transparent use of uprobe.multi in USDT?
> >
> > yes
> >
> > >
> > > But I'm not sure why this is a problem? How does perf handle this?
> > > Does it do runtime filtering or something more efficient that prevents
> > > uprobe to be triggered for other PIDs in the first place? If it's the
> > > former, then why can't we do the same simple check ourselves if pid
> > > filter is specified?
> >
> > so the standard uprobe is basically a perf event and as such it can be
> > created with 'pid' as a target.. and such perf event will get installed
> > only when the process with that pid is scheduled in and uninstalled
> > when it's scheduled out
> >
> > >
> > > I also see that uprobe_consumer has filter callback, not sure if it's
> > > a better solution just for pid filtering, but might be another way to
> > > do this?
> >
> > yes, that's probably how we will have to do that, will check
> 
> callback seems like overkill as we'll be paying indirect call price.
> So a simple if statement in either uprobe_prog_run or in
> uprobe_multi_link_ret_handler/uprobe_multi_link_handler seems like
> better solution, IMO.

it looks like the consumer->filter is checked/executed before installing
the breakpoint for uprobe, so it could be actually faster than current
uprobe pid filter.. I'll check and have it there in next version

> 
> 
> >
> > >
> > > Another aspect I wanted to discuss (and I don't know the right answer)
> > > was whether we need to support separate binary path for each offset?
> > > It would simplify (and trim down memory usage significantly) a bunch
> > > of internals if we knew we are dealing with single inode for each
> > > multi-uprobe link. I'm trying to think if it would be limiting in
> > > practice to have to create link per each binary, and so far it seems
> > > like usually user-space code will do symbol resolution per ELF file
> > > anyways, so doesn't seem limiting to have single path + multiple
> > > offsets/cookies within that file. For USDTs use case even ref_ctr is
> > > probably the same, but I'd keep it 1:1 with offset and cookie anyways.
> > > For uniformity and generality.
> > >
> > > WDYT?
> >
> > right, it's waste for single binary, but I guess it's not a big waste,
> > because when you have single binary you just repeat the same pointer,
> > not the path
> >
> > it's fast enough to be called multiple times for each binary you want
> > to trace, but it'd be also nice to be able to attach all in once ;-)
> >
> > maybe we could have a bit in flags saying paths[0] is valid for all
> 
> No need for extra flags. I was just thinking about having a simpler
> and more straightforward API, where you don't need to create another
> array with tons of duplicated string pointers. No big deal, I'm fine
> either way.

ok

thanks,
jirka
