Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB120623332
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 20:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiKITK2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 14:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKITK2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 14:10:28 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF86272C
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 11:10:26 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id r14so28529484edc.7
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 11:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T9v6S842rEM3KgSBdMX8GKJh9PlUXxUIOg5/nK6Wn6Y=;
        b=mrGnyiFjiq05+YUf6klb0gWgu7f9bFOY9J9foOjHo0UoEx81VSiiDkbqPCaazdmgm4
         HJh/r0uB/BKNqnZyaEK75/L0Q/gKaFpnqy9Cw3/YVSmsnaR9+y8r9s11nLwxXYeblwes
         fSbAeFXM1Z+AdY4FtMzzoAhooJNUPf2c7JCB01dIuPcY4jSFOiJ4q+VPyU2qSMaJzWft
         /gkR9k/srT1AHbisNWlD2vp+RB5yrESqMqGwtvdi6dkyE87BDMXZLugYhv9JwQLygrSa
         5YMWzWXsSjril52Lc+/xhDLE7iASs0VJ9MwzJfwcBHmvnmVy4qpNCLW/SyASTJXjD13q
         Xc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9v6S842rEM3KgSBdMX8GKJh9PlUXxUIOg5/nK6Wn6Y=;
        b=7cYJpmCqCFC9A9CbOfirojEt2yG1RywO52DFmfMDE+g2TVjdR2uoYWp8aTP0NYE5cR
         x9EM3i0/yHUxI5SNnJxhSbuiYYFrVZxaRADH4viZA57woEzN36tk63CD/WTCUyDtJbST
         lrdOZ4URvwKR4qQWDDboDnmV0LYzhvWpxqRLGzKCdQ6C1cIXJeGVizF+zXhWUiB6TAgd
         TZ6akFHhwmfkytT8d6eE8DFLA77gXtYldW3g+npK2/KpuBGek1bczc1JAutATJ9L+Zcw
         OBTl1GxPSALEBkU6zZuS/TEqy5m50Chz2KNfIqNksVHsqrp17Vlb759Gtn/3kThYz0sy
         aifA==
X-Gm-Message-State: ACrzQf3++y47uoYFjlG9FKQM2kwQMZI9CA74dAJ8b7gmMc0FLAiDNhd3
        s3hgJfg2n86JrWaVZOxs3j2JLsXaES7l6gXpj7104/Vx
X-Google-Smtp-Source: AMsMyM6HNJmYT/89nHeYcPR1RTNmUxr3DXYDYpmMvSf8mPsGJ3e2h5e60x52kfla3+u6ouD4FX8MewAV1Ojkqe/A43g=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr61456114edb.333.1668021025020; Wed, 09
 Nov 2022 11:10:25 -0800 (PST)
MIME-Version: 1.0
References: <20221027143914.1928-1-dthaler1968@googlemail.com>
 <20221027143914.1928-4-dthaler1968@googlemail.com> <CAADnVQKmzQJRX9KL06sbtpuQUO4A2Wc4Em+8--Y2Uku9fFPKRg@mail.gmail.com>
 <DM4PR21MB3440AA8F71FAD46496CFB84FA33E9@DM4PR21MB3440.namprd21.prod.outlook.com>
In-Reply-To: <DM4PR21MB3440AA8F71FAD46496CFB84FA33E9@DM4PR21MB3440.namprd21.prod.outlook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 9 Nov 2022 11:10:13 -0800
Message-ID: <CAADnVQJRe8AfdZ3Lk6ohWtMcu=ATvt-VmwnGHopzHocqggpR6w@mail.gmail.com>
Subject: Re: [PATCH 4/4] bpf, docs: Explain helper functions
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>,
        bpf <bpf@vger.kernel.org>
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

On Wed, Nov 9, 2022 at 2:30 AM Dave Thaler <dthaler@microsoft.com> wrote:
>
> > -----Original Message-----
> > From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Sent: Wednesday, November 9, 2022 1:51 AM
> > To: dthaler1968@googlemail.com
> > Cc: bpf <bpf@vger.kernel.org>; Dave Thaler <dthaler@microsoft.com>
> > Subject: Re: [PATCH 4/4] bpf, docs: Explain helper functions
> >
> > On Thu, Oct 27, 2022 at 7:46 AM <dthaler1968@googlemail.com> wrote:
> > >
> > > From: Dave Thaler <dthaler@microsoft.com>
> > >
> > > Explain helper functions
> > >
> > > Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> > > ---
> > >  Documentation/bpf/instruction-set.rst | 18 +++++++++++++++++-
> > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/bpf/instruction-set.rst
> > > b/Documentation/bpf/instruction-set.rst
> > > index aa1b37cb5..40c3293d6 100644
> > > --- a/Documentation/bpf/instruction-set.rst
> > > +++ b/Documentation/bpf/instruction-set.rst
> > > @@ -242,7 +242,7 @@ BPF_JSET  0x40   PC += off if dst & src
> > >  BPF_JNE   0x50   PC += off if dst != src
> > >  BPF_JSGT  0x60   PC += off if dst > src     signed
> > >  BPF_JSGE  0x70   PC += off if dst >= src    signed
> > > -BPF_CALL  0x80   function call
> > > +BPF_CALL  0x80   function call              see `Helper functions`_
> > >  BPF_EXIT  0x90   function / program return  BPF_JMP only
> > >  BPF_JLT   0xa0   PC += off if dst < src     unsigned
> > >  BPF_JLE   0xb0   PC += off if dst <= src    unsigned
> > > @@ -253,6 +253,22 @@ BPF_JSLE  0xd0   PC += off if dst <= src    signed
> > >  The eBPF program needs to store the return value into register R0
> > > before doing a  BPF_EXIT.
> > >
> > > +Helper functions
> > > +~~~~~~~~~~~~~~~~
> > > +Helper functions are a concept whereby BPF programs can call into a
> > > +set of function calls exposed by the eBPF runtime.  Each helper
> >
> > eBPF right next to BPF looks odd. Let's stick to BPF everywhere?
>
> Since the brand is eBPF, could we stick to eBPF everywhere except the
> actual defines (BPF_CALL, etc. have to be literal)?

I prefer to use BPF everywhere.
