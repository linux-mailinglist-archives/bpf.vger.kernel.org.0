Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CBE6545A2
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 18:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiLVRe4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 12:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLVRez (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 12:34:55 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAF120186;
        Thu, 22 Dec 2022 09:34:54 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id 3so2363758vsq.7;
        Thu, 22 Dec 2022 09:34:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXPRka6t/Y1/aWjRGkJ/Za7qTddnlVApRMzjAnZSMGo=;
        b=xhWAUknpO/X2gdLA2iUUr1/5hYBZ5+s6H99k94eoyhnpg7TRWTRY6ixCShmXMbxZKY
         KBUMrAs9Z/QEGJ5aKFob83OCeBiJQxw22+OnbBGNKLngFLZbLYSBVt7y4SG6+cQI9iav
         7KnEh+LcnIPqQt485V/DeF5ogqWANFdEWWW91QnZaVbKNZTt9Q/5qS6e4bjPWzvmrmbp
         HLJXQM9jNtg7xOzRT65hRccpTln9sYgiAWA30JIkuSgnPJo8gheQV0/lKhQ1FiKJV1a4
         PVE8dhwvpm3LDLbQEE5oOXoKahDNfm7gYvBNwFhbQ4kGmrLW4SryBW/HTwdgOO+McTAy
         RVow==
X-Gm-Message-State: AFqh2krP5s+4PAYtSjQQzvM5X5xIppwodEkKNs1kwIBRF+fpT8FoGV0m
        tt1rbFfDKY85RDJ57cRgHCfUIXJ2sCViZsHjWBc=
X-Google-Smtp-Source: AMrXdXtkcGbwThHIoHw8XzglvSsg7zxPDU+VC00aLR6aTTeqZAMwFHmUTre/aaguU1iUpYTtn1GqneNk6DI+LLmVbZY=
X-Received: by 2002:a67:fa14:0:b0:3b5:4247:2f70 with SMTP id
 i20-20020a67fa14000000b003b542472f70mr696880vsq.37.1671730493480; Thu, 22 Dec
 2022 09:34:53 -0800 (PST)
MIME-Version: 1.0
References: <20221220220144.4016213-1-namhyung@kernel.org> <20221220220144.4016213-2-namhyung@kernel.org>
 <Y6RTy29ULXp8WJ/Q@hirez.programming.kicks-ass.net> <2d164a5f-2885-2a6e-581a-2673ca0b1b81@iogearbox.net>
In-Reply-To: <2d164a5f-2885-2a6e-581a-2673ca0b1b81@iogearbox.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Dec 2022 09:34:42 -0800
Message-ID: <CAM9d7cj=iuxhLndNMBMeff6Ayp2hLfdz+6CHsZL7g213aWbUYQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/perf: Call perf_prepare_sample() before bpf_prog_run()
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Thu, Dec 22, 2022 at 5:17 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 12/22/22 1:55 PM, Peter Zijlstra wrote:
> > On Tue, Dec 20, 2022 at 02:01:43PM -0800, Namhyung Kim wrote:
> >> When the BPF program calls bpf_cast_to_kern_ctx(), it assumes the program will
> >> access perf sample data directly and call perf_prepare_sample() to make sure
> >> the sample data is populated.
> >
> > I don't understand a word of this :/ What are you doing and why?
>
> Yeah, above commit message is too terse and unclear. Also, not following where
> this assumption comes from; bpf_cast_to_kern_ctx() can be used elsewhere, too,
> not just tracing. Recent example from CI side can be found [0].

Sorry about that.  Let me rephrase it like below:

With bpf_cast_to_kern_ctx(), BPF programs attached to a perf event
can access perf sample data directly from the ctx.  But the perf sample
data is not fully prepared at this point, and some fields can have invalid
uninitialized values.  So it needs to call perf_prepare_sample() before
calling the BPF overflow handler.

But just calling perf_prepare_sample() can be costly when the BPF
doesn't access the sample data.  It's needed only if the BPF program
uses the sample data.  But it seems hard for the BPF verifier to detect
if it'd access perf sample data.  So I just checked if it calls the
bpf_cast_to_kern_ctx() and assumed it does.

Thanks,
Namhyung
