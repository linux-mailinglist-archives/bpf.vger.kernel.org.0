Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A4F539A58
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 02:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344418AbiFAAWg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 May 2022 20:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbiFAAWg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 May 2022 20:22:36 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0915AA65
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 17:22:35 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id k4so127677vsp.3
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 17:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=97j5rEDfoEwGW91tYkswsUJ3eNOm+2oHe7hi0oMmIRo=;
        b=nafrDY05j1RCmdGcGrACg0naPmtjaLrjAFpjiaw7nYjScwHXYwvfocU95qhTzKAo0Z
         G0t5cRQsIIMRag+27BqyAVfHs3IRPdC7rKcs3BEBpU2r2oWe3lNGzZd+FFUBpqfrn2D8
         DALnQFZ+rw0Yc3PK2D+K/D587UfJjcuZQOmYMWvg9hhhLiEPHKh8rwdyveCp22vXYQBq
         lpiKQVRto9oVNrvvWzBA2ZrYyW8FscZTVxQMPpeEBfHbQjwx8iDdUKBcV9zBU/YxQTxD
         LQVRsD7p+ZmRPMagUBIbBdnYcFUmurVgcsL6SBxX/pSIF56NCvCh024E0aMxHepRLbuD
         kNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97j5rEDfoEwGW91tYkswsUJ3eNOm+2oHe7hi0oMmIRo=;
        b=khEx4slZwVK8mZzuKIf9H872cyEkYl1WTUeav48GDrslC3JJZqJ+/c2HpiGXSA/SuU
         +2TyPugBXkX9mo2bi8HRj6vxHBCmiUsk5kZvBwa/pA7eeyDclew07PJI3vOfivxJxuZ+
         MrEO78FrW8zcB9xA5cBuyHFJvQE9GaCR8E6ywK3xFPJPNhRg84qbVk5wk5oWw2eBzpwe
         bOZNCf47ZbduwjXk5wiGuAho/+9INFKnNCo4sbwy7HDFffVAPNm9Vdcg5cDgSzfn27Yq
         vKY1QOqmyvVc1BjCP5IOvKq4Hw2VTNVYsZI9GQtsRNRzV4pqeBX79qXDiYaMmhpTk4wh
         NFpQ==
X-Gm-Message-State: AOAM533wQTMGa34q8Uu+VGBQ7pLIq0JumDbzu3LqpFKJxm3VxSFa4DV3
        TwnD4r1v2Ju/DyT6isbWg49IRl5R2goDrxyHGhnmITOw
X-Google-Smtp-Source: ABdhPJyZZvCA17Wv9FyjuMIS7o7KRmWTmg4sobZBlDFETTlnvbUZ08Sl+lbQoyrt522XsVtaHCekeZfSawWrAMc/4xU=
X-Received: by 2002:a67:e019:0:b0:349:d44f:c843 with SMTP id
 c25-20020a67e019000000b00349d44fc843mr2239366vsl.54.1654042954218; Tue, 31
 May 2022 17:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAPxVHd+hHXFjc3DvK0G5RWnLChOTbGXHZp_W-exCE6onCMSRuA@mail.gmail.com>
In-Reply-To: <CAPxVHd+hHXFjc3DvK0G5RWnLChOTbGXHZp_W-exCE6onCMSRuA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 31 May 2022 17:22:22 -0700
Message-ID: <CAEf4BzbiiZd7OJxN17=3ikZTor_mcqVO2XTdK6dbpcm9NqgX8w@mail.gmail.com>
Subject: Re: BPF_CORE_READ issue with nvme_submit_cmd kprobe.
To:     John Mazzie <john.p.mazzie@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "John Mazzie (jmazzie)" <jmazzie@micron.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 27, 2022 at 3:07 AM John Mazzie <john.p.mazzie@gmail.com> wrote:
>
> While attempting to learn more about BPF and libbpf, I ran into an
> issue I can't quite seem to resolve.
>
> While writing some tools to practice tracing with libbpf, I came
> across a situation where I get an error when using BPF_CORE_READ,
> which appears to be that CO-RE relocation failed to find a
> corresponding field. Compilation doesn't complain, just when I try to
> execute.
>
> Error Message:
> ---------------------------------------------
> 8: (85) call unknown#195896080
> invalid func unknown#195896080

This means CO-RE relocation failed. If you update libbpf submodule (or
maybe we already did it for libbpf-bootstrap recently), you'll get
more meaningful error and details. But basically in running kernel
there is no cmd->common.opcode.

>
> I'm using the Makefile from libbpf-bootstrap to build my program. The
> other example programs build and execute properly, and I've also
> successfully used tracepoints to trace the nvme_setup_cmd and
> nvme_complete_rq functions. My issue appears to be when I attempt to
> use kprobes for the nvme_submit_cmd function.
>

[...]
