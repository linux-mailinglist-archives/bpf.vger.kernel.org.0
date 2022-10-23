Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3A2609514
	for <lists+bpf@lfdr.de>; Sun, 23 Oct 2022 19:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiJWRTm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Oct 2022 13:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiJWRTj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Oct 2022 13:19:39 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E388DD59
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 10:19:24 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id f14so5271999qvo.3
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hud+8UtOIj7px+Ybea5ZrafkXvnAXxNHRaMhHn2uzZI=;
        b=V1QpCIEYcXdsNdfcTUmzhuTSu9BjrteRAl3zdbadLIDSab68MePQSKghHk3FwMIDzO
         Ta9mNVttm7GBcLmt4oXgTV49Kgr+QtyehxSJZEQzelFJfCFZNut243qr+t7jo/kaBFzE
         bAa3TfVVRZ7IfXYo8ZoSFGYmz89i/tMFFbvlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hud+8UtOIj7px+Ybea5ZrafkXvnAXxNHRaMhHn2uzZI=;
        b=q7PgP9PwR2eEbzs2IC/FCr5qQ7Zmu0w3yj06fLi1cQxiZldr7LjmpfycNcY3ZOt9r5
         8n6e2dBYCCOT1KcB/G8CU6OdKWdqSrrKy/u3Ozv7WddBmJXImIZYw/qyG3kOfqLrq0Sr
         LUMJMmGXp9XQ28kBcx6gJfa9NnSbyLvuqCsJfkYjvD36HXebW5V7/rptL21uzIGhdIJ3
         Z0l/GtVu6ignEz4+kCR+xElb8Ss0fhKuUymJaT0V5nBx3yYYWAFSpHRX174ikp0QG+Ra
         0yd4xtC2raLcClBIRsvvYKhUe9/7orSshuZzHpZLcfZAJBT4kP2HBB+sEQuPh/5QqU2y
         /ghw==
X-Gm-Message-State: ACrzQf0MPU3UB6sCxZ+aZ4ievmvBHWPUp+4mf9wqF6FAq1vT2KDs85pd
        /aK6Lj4Md1rqulF/CX1zul3Nvr2JdnUzog==
X-Google-Smtp-Source: AMsMyM43o/nIy76n8ZuMAQaCwOG6D/U3ckxO2JAx5Z0dI9yZd4zJVInH8hZ+i+TUEXxmLySOqL2ihA==
X-Received: by 2002:ad4:5961:0:b0:4af:b7e2:b463 with SMTP id eq1-20020ad45961000000b004afb7e2b463mr24114194qvb.105.1666545563598;
        Sun, 23 Oct 2022 10:19:23 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id 5-20020a370805000000b006ec09d7d357sm13189102qki.47.2022.10.23.10.19.21
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 10:19:21 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 126so8797907ybw.3
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 10:19:21 -0700 (PDT)
X-Received: by 2002:a25:5389:0:b0:6bc:f12c:5d36 with SMTP id
 h131-20020a255389000000b006bcf12c5d36mr24896573ybb.184.1666545560782; Sun, 23
 Oct 2022 10:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <Yz8lbkx3HYQpnvIB@krava> <20221007081327.1047552-1-sumanthk@linux.ibm.com>
 <Yz/1QNGfO39Y7dOJ@krava> <Y0BDWK7cl83Fkwqz@hirez.programming.kicks-ass.net>
 <CAADnVQJ0ur6Pox9aTjoSkXs43strqN__e1h4JWya46WOER9V4w@mail.gmail.com>
 <CAADnVQ+gquOKjo68ryUhpw4nQYoQzpUYJhdA2e6Wfqs=_oHV8g@mail.gmail.com>
 <CAADnVQKj5B1nfkQTSTrSCPq+TQU_SD22F7uG7Carks8oVi8=aQ@mail.gmail.com> <CAHk-=wh5bT2GPy4EYiPd3Vu+wm9QHmsP38XApFp8qLaup=exfA@mail.gmail.com>
In-Reply-To: <CAHk-=wh5bT2GPy4EYiPd3Vu+wm9QHmsP38XApFp8qLaup=exfA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Oct 2022 10:19:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtjPiiz-wtjAO2AXHNtUwWa6CXk6r0OfPrVTt6KQmYmw@mail.gmail.com>
Message-ID: <CAHk-=whtjPiiz-wtjAO2AXHNtUwWa6CXk6r0OfPrVTt6KQmYmw@mail.gmail.com>
Subject: Re: bpf+perf is still broken. Was: [PATCH] bpf: fix sample_flags for bpf_perf_event_output
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <olsajiri@gmail.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        X86 ML <x86@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 23, 2022 at 9:55 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I have a pull request from Borislav with the fix that came in
> overnight, so this should be all fixed in rc2.

.. and now it has moved from my inbox to my -git tree.

                   Linus
