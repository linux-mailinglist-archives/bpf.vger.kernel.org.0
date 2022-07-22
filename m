Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05BD57E8AB
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 23:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiGVVF2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 17:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGVVF2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 17:05:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D589332456
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 14:05:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v13so271928wru.12
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 14:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=9+Zd09Eu0mSPUan3H+PXv0+9UH21VZ71PGZMbWEgQJU=;
        b=l4eQKL/H2hhOzI39ZFDZuTijPWsMHdleXRlFmSl01C3Ed/3S9HvtXUjPpio212zHET
         WhxLPb4JSGBlkmUA9H0gszo3Cet/cX87JCIy/C2cIWZps+T6vTzLZJbaIhT+P/TUy1tL
         Oqv/fsgE/53qddyti9qS9hfmhhhC63fEAKuzLBF88/+AtOWbniF3s8+h/VsC2xATyNh6
         L2e/+87dAE3Ub5EaAkW1F+acsVysJauJ3v6Z5oX5lEhz65EQ9i5/lincCvLxUah0WIya
         JNCzZuLJrhnePIl8QSjWw0LMxK/i0h7whkja4/8CYJcO33RuCfzW155OJUtRHqZi3Jyj
         YoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=9+Zd09Eu0mSPUan3H+PXv0+9UH21VZ71PGZMbWEgQJU=;
        b=UIvwnI19pBXpp+GGaS6JZIH3BJawt7RqA3c8UHuG7cH8vxHXfZAaR4IADWcWfsXj4N
         VlWPDA4YMwbmEqQPGQNq4djgVgCuyt3lJUdpc1cRGCR0aMv+7c3Bvrhv/9U8ebF3vODC
         cIhasTBTjvk0rQhAcYtsQTjIfCxk2zsyR7d/qSSyusIESHdQjH/caXmJMRS8nUKboNXQ
         IkepDAd/f4DQp3qmMvzklICUNWAYNwoNs5cTLLEnIQD+SnqLi2yEShaH1/QivtV8PmWV
         kmQ8wnf55IwsJG6xm/nFU012VpwE5PH1YL6ANl48ntunWWq1BRMjqbKFhkv7JUsfToSD
         Yskg==
X-Gm-Message-State: AJIora+G7NVqPubX93zmQyLrQkPE3Rftqz517ZDdfGY34bly+dYMWAU+
        oxzudZbcl+3y5Kau+lvKLSo=
X-Google-Smtp-Source: AGRyM1srae6OAhIkwx0jmXZ5lXgoVTZV6v8Yz8JmP587SsPuEoVVdE87TC4ziUe79iWmYWry9D3e0g==
X-Received: by 2002:adf:f98d:0:b0:21e:492a:8452 with SMTP id f13-20020adff98d000000b0021e492a8452mr1091004wrr.404.1658523924396;
        Fri, 22 Jul 2022 14:05:24 -0700 (PDT)
Received: from krava ([83.240.63.177])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c35cd00b003a046549a85sm10651155wmq.37.2022.07.22.14.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 14:05:23 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 22 Jul 2022 23:05:19 +0200
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
Message-ID: <YtsRD1Po3qJy3w3t@krava>
References: <20220722110811.124515-1-jolsa@kernel.org>
 <20220722072608.17ef543f@rorschach.local.home>
 <CAADnVQ+hLnyztCi9aqpptjQk-P+ByAkyj2pjbdD45dsXwpZ0bw@mail.gmail.com>
 <20220722120854.3cc6ec4b@gandalf.local.home>
 <20220722122548.2db543ca@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722122548.2db543ca@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 22, 2022 at 12:25:48PM -0400, Steven Rostedt wrote:
> On Fri, 22 Jul 2022 12:08:54 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 22 Jul 2022 09:04:29 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > 
> > > ftrace must not peek into bpf specific functions.
> > > Currently ftrace is causing the kernel to crash.
> > > What Jiri is proposing is to fix ftrace bug.
> > > And you're saying nack? let ftrace be broken ?
> 
> Sounds like a BPF bug to me. Ftrace did nothing to cause this breakage. It
> was something BPF must have done. What exactly is BPF doing to ftrace
> locations anyway?
> 
> > > 
> > > If you don't like Jiri's approach please propose something else.  
> > 
> > So, why not mark it as notrace? That will prevent ftrace from looking at it.
> > 
> 
> And if for some strange reason you need the mcount/fentry on some internal
> BPF infrastructure, the work around is to register two ftrace_ops() that
> have filters to that function. In which case ftrace will force the call to
> the ftrace iterator loop, and any more ops attached will simply be added to
> that loop, and ftrace will no longer touch that location.
> 
> Then you can do whatever you want to it without fear of racing with ftrace.

ok, I think we could use that, I'll check

> 
> But other than that, we don't need infrastructure to hide any mcount/fentry
> locations from ftrace. Those were add *for* ftrace.

I think I understand the fentry/ftrace equivalence you see, I remember
the perl mcount script ;-)

still I think we should be able to define function that has fentry
profile call and be able to manage it without ftrace

one other thought.. how about adding function that would allow to disable
function in ftrace, with existing FTRACE_FL_DISABLED or some new flag

that way ftrace still keeps track of it, but won't allow to use it in
ftrace infra

jirka
