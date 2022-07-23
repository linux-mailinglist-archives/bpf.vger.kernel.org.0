Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F0C57F1C0
	for <lists+bpf@lfdr.de>; Sat, 23 Jul 2022 23:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiGWVje (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Jul 2022 17:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGWVje (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Jul 2022 17:39:34 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9B61928A
        for <bpf@vger.kernel.org>; Sat, 23 Jul 2022 14:39:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a18-20020a05600c349200b003a30de68697so6329943wmq.0
        for <bpf@vger.kernel.org>; Sat, 23 Jul 2022 14:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=Can+tmBk+Wid7peUFFK03StsCKEQpkEmFqhp/kE6KsE=;
        b=ipERumaARiNZsuwJDDqcplfldFnM1+XYa2m2j/5kEzsPGd45px3pbVkDnTxMOT8YXK
         csiB7UKjMnEgh2J+DYWtgHkppIcDA36d20NHSp+ca14VuJ19C/aNk1M4sjr25Aa3brq1
         XRzJBaEVBgMX7utwy7lb2QFvTLEI4p4uWHdLZm9Gsva0xXO4WqFw7CyluKYMScUG3mt+
         L1676/sofUOpgLO6o8WRaa13Rl5trMYFdG82lOyFjCf7YXq4aJzz2hnZs7485DquT+Gc
         fz2K6w5PoXeyl802lGaM/tRKQ41I1Bo1p3gih1qWETrObPCkdzeiYX3Oj+SaQKo05lLq
         6RRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=Can+tmBk+Wid7peUFFK03StsCKEQpkEmFqhp/kE6KsE=;
        b=UEGY5gNm+nKJD3MyufpCYuXRu2F9DkV5uMUkkjouF6rHN/qOvDbWjeVMTXHYgVwlhT
         voFpOjXTq7WeszdcZyDtVdAnrsnylnHp2KVfkFMqRQCDehVFC3e5kgr7Hyhe5STwxA1q
         7v6Gl4W+rfgwzkRYFZG30zGXo2F1IrZLKhE9jmh7z3MXbt5g2CZ3PVeBWzO5jp8HwrvX
         VE2rlQiQLwtje8ognybw2aycQIJtcKFUSnMYolWKEghN3ybipHJ2eFQJNlM3aCgtysCf
         5LJne8pkQeYNg/BysC9qZczE+9nhRIpmkK0DrCtM22iIvYW6VhBHAi5haCavXaQzp96I
         BKXg==
X-Gm-Message-State: AJIora/c1m9IntBXYTMem2J0gSJAs32851f6FCmqai/7mr5yxeLifRlo
        cpWUoeXHavZhFuHH8om05qzpCfqz8hSoGw==
X-Google-Smtp-Source: AGRyM1sGNCkwfLkVoaVdvf7ieAvhrIx/iXvYs6sXTHRTMWAHfXb0tsgFpgbMImMQYlMlCDstNmqX/Q==
X-Received: by 2002:a05:600c:1c26:b0:3a3:2251:c3cb with SMTP id j38-20020a05600c1c2600b003a32251c3cbmr16534754wms.126.1658612371159;
        Sat, 23 Jul 2022 14:39:31 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id m39-20020a05600c3b2700b003a2e1883a27sm16680062wms.18.2022.07.23.14.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 14:39:30 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sat, 23 Jul 2022 23:39:27 +0200
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Message-ID: <YtxqjxJVbw3RD4jt@krava>
References: <20220722110811.124515-1-jolsa@kernel.org>
 <20220722072608.17ef543f@rorschach.local.home>
 <CAADnVQ+hLnyztCi9aqpptjQk-P+ByAkyj2pjbdD45dsXwpZ0bw@mail.gmail.com>
 <20220722120854.3cc6ec4b@gandalf.local.home>
 <20220722122548.2db543ca@gandalf.local.home>
 <YtsRD1Po3qJy3w3t@krava>
 <20220722174120.688768a3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722174120.688768a3@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 22, 2022 at 05:41:20PM -0400, Steven Rostedt wrote:
> On Fri, 22 Jul 2022 23:05:19 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > ok, I think we could use that, I'll check
> > 
> > > 
> > > But other than that, we don't need infrastructure to hide any mcount/fentry
> > > locations from ftrace. Those were add *for* ftrace.  
> > 
> > I think I understand the fentry/ftrace equivalence you see, I remember
> > the perl mcount script ;-)
> 
> It's even more than that. We worked with the compiler folks to get fentry
> for ftrace purposes (namely to speed it up, and not rely on frame
> pointers, which mcount did). fentry never existed until then. Like I said.
> fentry was created *for* ftrace. And currently it's x86 specific, as it
> relies on the calling convention that a call does both, push the return
> address onto the  stack, and jump to a function. The blr
> (branch-link-register) method is more complex, which is where the
> "patchable" work comes from.
> 
> > 
> > still I think we should be able to define function that has fentry
> > profile call and be able to manage it without ftrace
> > 
> > one other thought.. how about adding function that would allow to disable
> > function in ftrace, with existing FTRACE_FL_DISABLED or some new flag
> > 
> > that way ftrace still keeps track of it, but won't allow to use it in
> > ftrace infra
> 
> Another way is to remove it at compile time from the mcount_loc table, and
> add it to your own table. I take it, this is for bpf infrastructure code

hm, perhaps we could move it to separate object and switch off
-mrecord-mcount for it, I'll check

> and not for any code that's in the day to day processing of the kernel,
> right?

yes, it's bpf specific code

thanks,
jirka
