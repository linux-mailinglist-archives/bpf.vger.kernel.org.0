Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583D764BF9F
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 23:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbiLMWsD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 17:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbiLMWsB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 17:48:01 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF4223EBF
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 14:47:59 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bx10so17476605wrb.0
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 14:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P2rPSpV30DMArlILJhVf/pTOykjarxMulIIIDDH7UVw=;
        b=G6kBGUFFgfwTZSKoa0aosDD5Wxux3w3OF7RvGU0xEmTxpuBtQgm85e1jZ/rg9YrLu9
         fPF+IPDmy2MarCLC0d1UOBcD0CQ4Sez8K3qhTbguNDoKsyZsqKNakie5Kymj86C3yI9w
         JYCfL6I/fgNHIUfHOn2ZXxfOjAtDP/WHjBCsg3dWbawsEhu1doOivfn2bdzSnU5qy34K
         bRqFyoY/7fRjBnjdlm7k/a7UAR5eTGZAWIoJoyKLLBSvs7Xge3iriN+PmXs7TdSsQjdC
         pCc8V7pPIXt20wu6dTYkIwcEf8q3rL+wyFpD4knHIo5KeVP2fHrVrddQJLU79ZJzTd90
         7eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P2rPSpV30DMArlILJhVf/pTOykjarxMulIIIDDH7UVw=;
        b=HDgX9tfbkw7dpQZ3MtRCe94UWLTvTLBN6O3frOZG1c3UZhJgnTzZWrGXG0D6sCeI/W
         YtbjQYp2+RtXX2i9KhRO3o1jhu5NSbSfHDWKvcRQNIVz3h9mPfjyzsAyeq5ixggqaBR2
         EAKs5T1bck2/ecxhjo+MCg0/KPP7/Jk6J85/9vmloDHhFiG3t7DpBysdD9fnDa3OTqP4
         Eeyz0SiiEygkWQbXFQa/R2n7qjwwRBSpzMyZ5PIXTPArXTuf1sIpWTi7lv1a7r5vnRlh
         aYtHYURRPNFSiyUYni5f+eDA/ekF6IpTUa3j/2Y9S+z2l5uCMcC+Ia2H8GhSQzp/hc8M
         USJg==
X-Gm-Message-State: ANoB5ploMOC22b1Hp7mPXbrIdHo4DeEZcEyuLnVzM+xS6cObMrgFio9u
        HAQV2HZzn2OUICA9TZbLRtfYoGuQf4hngsuSYjOXJA==
X-Google-Smtp-Source: AA0mqf4bhFpkeK8ZTyG2hqUWEfovpOG10oszQspQQQIntPx71LnjjEFLPxDVqPiHPuPaulPAZDlkqvYO0inWLUWcJh4=
X-Received: by 2002:adf:f3c5:0:b0:242:5caa:5fbf with SMTP id
 g5-20020adff3c5000000b002425caa5fbfmr11175741wrp.300.1670971677544; Tue, 13
 Dec 2022 14:47:57 -0800 (PST)
MIME-Version: 1.0
References: <Y491d1wEW4TfUi5f@kernel.org> <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org> <Y498YP2N3gvFSr/X@kernel.org>
 <C9F248C8-AF8D-40A1-A1AD-BCC39FBA01C7@linux.vnet.ibm.com> <Y5DNBZNC5rBBqlJW@kernel.org>
 <36CD1041-0CAE-41C1-8086-C17854531B3E@linux.vnet.ibm.com> <Y5JfgyN59dSeKbUP@kernel.org>
 <Y5Jl8MeW90DXy1wT@kernel.org> <8F6F0C27-53F3-4837-A19C-845768253249@linux.vnet.ibm.com>
 <Y5cxyk3OdgFXlyhS@kernel.org> <BB236C92-3505-4DAB-AE28-A55F74EDE161@linux.vnet.ibm.com>
 <CAP-5=fVVPDo_3cjKmumEVKDN2Zssz-ZU=nYVQFNr1xUGHxx-PQ@mail.gmail.com> <927374FD-C6C0-42B3-9F93-5379A5898FB3@gmail.com>
In-Reply-To: <927374FD-C6C0-42B3-9F93-5379A5898FB3@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Dec 2022 14:47:45 -0800
Message-ID: <CAP-5=fUD+0sPu1u+MMJQ=P5haufV7ifZtt3E7PFpufY6DyX5bw@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf build: Use libtraceevent from the system
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 13, 2022 at 2:34 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On December 13, 2022 7:09:07 PM GMT-03:00, Ian Rogers <irogers@google.com> wrote:
> >Thanks Athira and Arnaldo. It is a little strange to me to be using
> >the shell to do a version number test. The intent was to be doing
> >these in the code:
> >#if LIBRTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
> >vs
> >...
> >LIBTRACEEVENT_VERSION_WITH_TEP_FIELD_IS_RELATIVE := $(shell expr 1 \*
> >255 \* 255 + 5 \* 255 + 0) # 1.5.0
> >ifeq ($(shell test $(LIBTRACEEVENT_VERSION_CPP) -gt
> >$(LIBTRACEEVENT_VERSION_WITH_TEP_FIELD_IS_RELATIVE); echo $$?),0)
> >CFLAGS += -DHAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> >endif
> >...
> >#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> >I'm a little selfish as I'm maintaining a bazel build and a single
> >version number to maintain is easier than lots of HAVE_... tests. I'm
> >happy to follow Arnaldo's lead. I think the test should also be
> >greater-equal rather than greater-than:
> >https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/tree/include/traceevent/event-parse.h?h=libtraceevent-v1.5#n128
>
> I'll fix that, and in a case like this please consider to send a patch with your preference, I'd happily
> graft it.
>
> - Arnaldo

I can fix it. I can fold it in with:
https://lore.kernel.org/linux-perf-users/20210923001024.550263-4-irogers@google.com/
which I mentioned in this thread.

Thanks,
Ian

> >
