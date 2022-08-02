Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC78588104
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 19:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiHBR3C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 13:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbiHBR3B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 13:29:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB2E49B7E;
        Tue,  2 Aug 2022 10:29:00 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id tl27so9320711ejc.1;
        Tue, 02 Aug 2022 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fG01VtUQWDj2G8XLV85uGypDOMVsGyzXJZJeDD96RAU=;
        b=CudTMV1iKdUHGiDVdV7lhFWDU8JAGnxTMWs4/iUZh0aRx3/wLccMOVk/DrfLAW2ql+
         eqiAqsGhN0zpcgq9lUgQSXDA3iN+rGTDJwcd7AuUTi980OFOi46Okl2TSAMvHZOPloQJ
         diLs8pZ/+ia+Imhya8uTRGbbzI0wnsspNLokCHIO4ZDYg3i0M9qaxJvhGR9/vAHGqps/
         ACcehG9qvRvL9vf+zSEs3uj3jq3CoLPavsKFJv2l2Ycxc9l/2DSw48HGOxgiImM/58g8
         mxmvKvw6STlI1muk6MvG/Y8oz6Lxr+5kG67lBW3Dy9eKkA4iOb3QSN+BKDOcYw1Ee4ft
         VlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=fG01VtUQWDj2G8XLV85uGypDOMVsGyzXJZJeDD96RAU=;
        b=iUcSe387zOlQRzj5niqFY1KgjhCRRRvqt3BrMMaqwa8SltqN98D5TPQYygTMAZnIDL
         zsQtBrmQJ8f/mIkkQgGvwT69lBK7GBFLbjrtdBlGRooliLQdZOPCse4nTOSOTIEfWywe
         fVGTenOiwJsJq+clkrVNcils3ABiVjgY/uZOPzH3L0rbRuCMzENux+NjS27A6B6+zZcn
         l8ypPEucWGrVyZZKGtz/mAFROmWAqtwm+3HzoUK2LUhbo88wj/rnE1YPvG7x6JAQDEqP
         cEPnkLc7KnIxONwwdzrW9xyBeS8ND1mHheZEfs5Gs6Qs9hYqZDjEtL8V3YB2Zywect75
         8Wzg==
X-Gm-Message-State: ACgBeo2a1Z10C3o/+rSrSr6CDvyc4O99cEF+JL6Fp2/wwsQIVlDGLdIU
        T+/nFMwZQ2D6h/rsF8BX+lw=
X-Google-Smtp-Source: AA6agR4nOHE9GdQzapRL6UPnQdOGydmJQ+w040Ps7whhbs2UsMYWS00BBj4QEXTQFOnfoPFIwjQ5ug==
X-Received: by 2002:a17:906:4fd4:b0:730:a685:d27c with SMTP id i20-20020a1709064fd400b00730a685d27cmr1682599ejw.595.1659461338945;
        Tue, 02 Aug 2022 10:28:58 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id y8-20020aa7c248000000b0043c7efb8badsm8463219edo.61.2022.08.02.10.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:28:58 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 2 Aug 2022 19:28:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Daniel =?iso-8859-1?Q?M=FCller?= <deso@posteo.net>
Subject: Re: [PATCH] x86/kprobes: Fix to update kcb status flag after
 singlestepping
Message-ID: <Yule2F3i+Qj6Cdxc@gmail.com>
References: <165942025658.342061.12452378391879093249.stgit@devnote2>
 <20220802105230.43bb6079@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220802105230.43bb6079@gandalf.local.home>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  2 Aug 2022 15:04:16 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Fix kprobes to update kcb (kprobes control block) status flag to
> > KPROBE_HIT_SSDONE even if the kp->post_handler is not set.
> > This may cause a kernel panic if another int3 user runs right
> > after kprobes because kprobe_int3_handler() misunderstands the
> > int3 is kprobe's single stepping int3.
> > 
> > Fixes: 6256e668b7af ("x86/kprobes: Use int3 instead of debug trap for single-step")
> > Reported-by: Daniel Müller <deso@posteo.net>
> > Tested-by: Daniel Müller <deso@posteo.net>
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/all/20220727210136.jjgc3lpqeq42yr3m@muellerd-fedora-PC2BDTX9
> > ---
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> I guess this will go through the tip tree?

Yeah, it's already in tip:perf/urgent.

Thanks,

	Ingo
