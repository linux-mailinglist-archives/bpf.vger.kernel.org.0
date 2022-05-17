Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF72752969E
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 03:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiEQBR6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 21:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiEQBR4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 21:17:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5AB165B8
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 18:17:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i17so16007682pla.10
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 18:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=urpZgCt/ZhOHec7427fz215Q1NE4DW47dm7yE98R5JQ=;
        b=PUUhdp72m1Wvlii5EFHxZtiG7UnbgbNHwky6i03k0H6yBGKa7eiaY70+5yR4DwJGQo
         7IB340r/ek2VQkkuD1C8Q8mDk8dlu5cSn9vfQHp5KlYmNSDfbtiopsmwniKPatFORUUG
         hGQqcBc21rTtBdJcKyVhMeYhPdePNoHK+qEn+HXiE/LwZP7HF4lf8A8jlg55NIziynmI
         +spKdEtlu7KySne5Fjw/ib9OfAyJ3q1CEE19oPyg46a0IKYHv7NUYTSFUx9/UpLoYVv9
         RoFTGx/yGEnIr/ehUCmxCkjT8MX/GUB3NPUajk8bM+RkI7JHswKMgHEJJmuIRtBY+mce
         R60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=urpZgCt/ZhOHec7427fz215Q1NE4DW47dm7yE98R5JQ=;
        b=t/Tcpj47TtjkojnrqmoBcLREEdmd8KFZ1qVabl1LF1kTET4vcUSXhHz9H62qx9dNK6
         ohkSt73bX/KFAgfVnYU3kMeGrznbkZH02KenNrvDm3QY9gnCBG+/Puks7JShzaBL0Aff
         6FTZvwm8VxatEZKPI4qd7EAXWsxTMUIM/H8rGeEVI8qUfw7A4O8pq5VVUImknWzziqkv
         IxIomqhrTLq6T8HbSrFBdbUNBBRM1BOQqPiTwg5Qp+dUARHCHw/XXBNf4oJH9+E3tm07
         Kbv2JcesSrGFv4WuKuf+bYOOvlZHZ1ttjBZinrlSEcQ4QPTGmJ4I7CcfvCA/G/RMCYbU
         JK0g==
X-Gm-Message-State: AOAM533q13z9Gofs7TQ/RPT/xkm1b943XQJ78tTGF2c44MkjmCXKPhD1
        YQ3v7EjFys8hXDotXxFiRdk=
X-Google-Smtp-Source: ABdhPJzeYi0BR5TESzDJmRw9pU212Il9F9NUi5dFxnPp3qURAB36F285eBxADR9Ze9e5EC0QMoQirA==
X-Received: by 2002:a17:902:c404:b0:15e:a090:dc8a with SMTP id k4-20020a170902c40400b0015ea090dc8amr19887748plk.31.1652750275215;
        Mon, 16 May 2022 18:17:55 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::4:3651])
        by smtp.gmail.com with ESMTPSA id 185-20020a6204c2000000b0050dc76281d8sm7679761pfe.178.2022.05.16.18.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 18:17:54 -0700 (PDT)
Date:   Mon, 16 May 2022 18:17:52 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rik van Riel <riel@surriel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>, Kernel Team <kernel-team@fb.com>
Subject: Re: [RFC PATCH bpf-next 4/5] selftests/bpf: Add test for USDT parse
 of xmm reg
Message-ID: <20220517011752.or6r4k5qwcc3kgy3@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220512074321.2090073-1-davemarchevsky@fb.com>
 <20220512074321.2090073-5-davemarchevsky@fb.com>
 <CAEf4BzYj2i4shfAFW4fUKaEDFQvkMtyirVpq8_5AQAX0pW36yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYj2i4shfAFW4fUKaEDFQvkMtyirVpq8_5AQAX0pW36yQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 16, 2022 at 04:31:55PM -0700, Andrii Nakryiko wrote:
> On Thu, May 12, 2022 at 12:43 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >
> > Validate that bpf_get_reg_val helper solves the motivating problem of
> > this patch series: USDT args passed through xmm regs. The userspace
> > portion of the test forces STAP_PROBE macro to use %xmm0 and %xmm1 regs
> > to pass a float and an int, which the bpf-side successfully reads using
> > BPF_USDT.
> >
> > In the wild I discovered a sanely-configured USDT in Fedora libpthread
> > using xmm regs to pass scalar values, likely due to register pressure.
> > urandom_read_lib_xmm mimics this by using -ffixed-$REG flag to mark
> > r11-r14 unusable and passing many USDT args.
> >
> > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > ---
> >  tools/testing/selftests/bpf/Makefile          |  8 ++-
> >  tools/testing/selftests/bpf/prog_tests/usdt.c |  7 +++
> >  .../selftests/bpf/progs/test_urandom_usdt.c   | 13 ++++
> >  tools/testing/selftests/bpf/urandom_read.c    |  3 +
> >  .../selftests/bpf/urandom_read_lib_xmm.c      | 62 +++++++++++++++++++
> >  5 files changed, 91 insertions(+), 2 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/urandom_read_lib_xmm.c
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 6bbc03161544..19246e34dfe1 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -172,10 +172,14 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
> >         $(call msg,LIB,,$@)
> >         $(Q)$(CC) $(CFLAGS) -fPIC $(LDFLAGS) $^ $(LDLIBS) --shared -o $@
> >
> > -$(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
> > +$(OUTPUT)/liburandom_read_xmm.so: urandom_read_lib_xmm.c
> > +       $(call msg,LIB,,$@)
> > +       $(Q)$(CC) -O0 -ffixed-r11 -ffixed-r12 -ffixed-r13 -ffixed-r14 -fPIC $(LDFLAGS) $^ $(LDLIBS) --shared -o $@
> 
> this looks very x86-specific, but we support other architectures as well
> 
> looking at sdt.h, it seems like STAP_PROBEx() macros support being
> called from assembly code, I wonder if it would be better to try to
> figure out how to use it from assembly and use some xmm register
> directly in inline assembly? I have never done that before, but am
> hopeful :)

stap_probe in asm won't help cross arch issue.
It's better to stay with C.
Maybe some makefile magic can make the above x86 only?
The test should be skipped on other archs anyway.
