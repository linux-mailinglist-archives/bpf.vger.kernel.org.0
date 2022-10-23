Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF61609529
	for <lists+bpf@lfdr.de>; Sun, 23 Oct 2022 19:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJWR2V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Oct 2022 13:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJWR2U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Oct 2022 13:28:20 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1156475CFC;
        Sun, 23 Oct 2022 10:28:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z97so23467385ede.8;
        Sun, 23 Oct 2022 10:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QVWc790angtkQLF3fvax2L6R8j2vNS1XJ9vbYZVbDv4=;
        b=peGjirtDcnlNcdDuScg2tol+8JiSx9kdtJ1+e33/080oTqd7ZdPebtPGucjeGL8wkl
         wz5SvUde/y8DWSxc2IssQIsGK9eDEQZ9+CygfnCe78Mf1aRR0lawn9RGH6utnMazyEQ8
         er5gbgmdofGaTGMj03Qt/oa2SnOX+E/zfBGlgJlG208eBFWjY+XevAHNjCuhRtb27nj4
         ebuo2GDcJC2kLLWl+uw/F8MC04qzm7g90RMn+h0TXAYmXbGHpe4p6wFowxNAOXxGjgO0
         GxK6T+2KBvorDgVvAfqoNCfUUkltSoLEPOxoz1zNPmJefuG3VekhtODUsnQH2IDptQRZ
         Hjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVWc790angtkQLF3fvax2L6R8j2vNS1XJ9vbYZVbDv4=;
        b=qExfQiK1YkdR/wp1+QMJAo4MvfBJKzrnTLL6q/RB7VikOC61V3MosC2hlvSE9Ey6a4
         //q5VKYCfWgu/BcwA+Y/TMTAEDC8KTHlW4hKbyNey0FtlZsLdVmJSt84ACPKywVaOwmA
         25xS4JMRudi0PVVaRrfRzCK0FgAtmbrn50bCTnmSCTLB8AOEkW9wcXTXzzU6YJiXZPUC
         TknreDjGBMNvqBAu5Ni/X+ti/c1AWfgPkE6DE1HYX2mEDSmRWirXQhyn73o37aAeHXkM
         KzXrTDYnjeovxjqtpPf2oDBTOdz3aXAmqrVut+NdRvsCMQbSY8bkQoI1khNL9o4XBfWm
         KuZA==
X-Gm-Message-State: ACrzQf2ma8IEFzzbc8HOfRGFaNFC13ZYdMvHtRC5p5/+STvzbZwT5l6D
        DLRcOORyo30fanPNytCKSPeLEj2Gv94k/RZTSXHhWtpT
X-Google-Smtp-Source: AMsMyM4oJJ7cEV2AawxeGzXMam6ZePJlu8jev37tQywnD3fQnX72pVBzTeVJkXFR1gXmz+1YlHDe4y5wCGQSbvcumAg=
X-Received: by 2002:aa7:c6c1:0:b0:460:f684:901a with SMTP id
 b1-20020aa7c6c1000000b00460f684901amr16492125eds.6.1666546098448; Sun, 23 Oct
 2022 10:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <Yz8lbkx3HYQpnvIB@krava> <20221007081327.1047552-1-sumanthk@linux.ibm.com>
 <Yz/1QNGfO39Y7dOJ@krava> <Y0BDWK7cl83Fkwqz@hirez.programming.kicks-ass.net>
 <CAADnVQJ0ur6Pox9aTjoSkXs43strqN__e1h4JWya46WOER9V4w@mail.gmail.com>
 <CAADnVQ+gquOKjo68ryUhpw4nQYoQzpUYJhdA2e6Wfqs=_oHV8g@mail.gmail.com>
 <CAADnVQKj5B1nfkQTSTrSCPq+TQU_SD22F7uG7Carks8oVi8=aQ@mail.gmail.com>
 <CAHk-=wh5bT2GPy4EYiPd3Vu+wm9QHmsP38XApFp8qLaup=exfA@mail.gmail.com> <CAHk-=whtjPiiz-wtjAO2AXHNtUwWa6CXk6r0OfPrVTt6KQmYmw@mail.gmail.com>
In-Reply-To: <CAHk-=whtjPiiz-wtjAO2AXHNtUwWa6CXk6r0OfPrVTt6KQmYmw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 23 Oct 2022 10:28:07 -0700
Message-ID: <CAADnVQJ9SVHAPGbS+W_0yH0m6r6t5Ropa+WH64g-3tqLphW5WA@mail.gmail.com>
Subject: Re: bpf+perf is still broken. Was: [PATCH] bpf: fix sample_flags for bpf_perf_event_output
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 23, 2022 at 10:20 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Oct 23, 2022 at 9:55 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I have a pull request from Borislav with the fix that came in
> > overnight, so this should be all fixed in rc2.
>
> .. and now it has moved from my inbox to my -git tree.

Great. Thank you.
