Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E245A0561
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 02:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiHYAwr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 20:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiHYAwq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 20:52:46 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FCE8F976
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 17:52:45 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id gb36so36593210ejc.10
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 17:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ot0aEvyT380VjDU6PPl13tz+5G5649T71Q1QmyiGXIo=;
        b=YpSDVkBcxWVnnXfQXF/M7AZGWY5x+V+c24wMO5zVR8RFtXivElwnk0FLNTXke/emLT
         oh8/MGX4jyRJc+YrZXh96+Jtsdh8UfgCE6n4YSYTOMmu4AtkTQJ7laVjSVHJm8+QclNG
         oVzUJs4I5lvMg1LyJ9KO0CmiPyQ9FIcsSPJtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ot0aEvyT380VjDU6PPl13tz+5G5649T71Q1QmyiGXIo=;
        b=cICZeKTuYbb/wySlOLj3hFDFoV59+0xfp5ASgm97+Mg1xn6SN6mMUuOcs1MPxuXYgg
         5uYuH32Mmcb6Fl1l0WgS0SJWMmSp/bXOwI51JKxNJvxMNmBC72SOU6PHhgUC2YpkTZ8S
         z+3vPUTino6u34KLEwXG9qnEvlaWApXVU00IPJp2cht3eG9b0xHw7VuHXk975C53ngc3
         ridy0oktu3uvLnEcuf5l39ynWzMtWVGATlmmmATrSNoBYHloE2DK9TXQ32cTiFMxg8Oh
         zyXa3Tf5avAi2QupvJFovgQwElfhvtyNU+PK5IykCTpZJ1nBty4/Y4zlvGw0j5iF7A+r
         59zA==
X-Gm-Message-State: ACgBeo1hTul+Eyid5bxvB8BAnmZsRZsXnwt2cVyA3K3QKqaFQr5kHEPC
        x67/MFNlMj52VNiJ7SO+6qgCIae71OHkX+ch
X-Google-Smtp-Source: AA6agR43TRXnadJNT0oaXmHdHreCLMO0ApFlSk/OdhsdbjhFrIKUWHWuwtJlWk/GysdUHA34Xoq5jA==
X-Received: by 2002:a17:907:97cb:b0:731:6d1:13fa with SMTP id js11-20020a17090797cb00b0073106d113famr853376ejc.375.1661388763918;
        Wed, 24 Aug 2022 17:52:43 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id e4-20020a056402088400b0043cb1a83c9fsm3856586edy.71.2022.08.24.17.52.38
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 17:52:41 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id a4so22729011wrq.1
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 17:52:38 -0700 (PDT)
X-Received: by 2002:adf:e843:0:b0:225:221f:262 with SMTP id
 d3-20020adfe843000000b00225221f0262mr764111wrn.193.1661388757863; Wed, 24 Aug
 2022 17:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com> <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
In-Reply-To: <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Aug 2022 17:52:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>
Message-ID: <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C naming
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alex Colomar <alx@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Zack Weinberg <zackw@panix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Florian Weimer <fweimer@redhat.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 24, 2022 at 4:36 PM Alejandro Colomar
<alx.manpages@gmail.com> wrote:
>
> I'm trying to be nice, and ask for review to make sure I'm not making
> some big mistake by accident, and I get disrespect?  No thanks.

You've been told multiple times that the kernel doesn't use the
"standard" names, and *cannot* use them for namespace reasons, and you
ignore all the feedback, and then you claim you are asking for review?

That's not "asking for review". That's "I think I know the answer, and
when people tell me otherwise I ignore them".

The fact is, kernel UAPI header files MUST NOT use the so-called standard names.

We cannot provide said names, because they are only provided by the
standard header files.

And since kernel header files cannot provide them, then kernel UAPI
header files cannot _use_ them.

End result: any kernel UAPI header file will continue to use __u32 etc
naming that doesn't have any namespace pollution issues.

Nothing else is even remotely acceptable.

Stop trying to make this something other than it is.

And if you cannot accept these simple technical reasons, why do you
expect respect?

Why are you so special that you think you can change the rules for
kernel uapi files over the *repeated* objections from maintainers who
know better?

                  Linus
