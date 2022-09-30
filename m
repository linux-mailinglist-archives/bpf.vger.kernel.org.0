Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735375F0612
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 09:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiI3Hx6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 03:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiI3Hxo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 03:53:44 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056F415ED0D
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 00:53:44 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id q26so3962365vsr.7
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 00:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Szw16HNOo1vMmp24mOARIGE8cr3OLxIvjfwYPhv6z4k=;
        b=QX4rDFvSrQT7WBySuXieFjOk8qKI0REVMHmb9M3czAc/Sa4e1v/3S/q7kDTyUtvbQN
         gH+dZF5a/7xSb909veBTEdaId65Nhfj0S2vlhOGHpQ9bQLt+Q1L/P/mcaLp/sxxH/xPD
         kJT33b0ro8lfJstF9TaIwfXZSRyKfxvsMLiRhDgKks0pkgCNpMrFTMilMX+ccDL2l7Hg
         kFqDKkHwwbrsk66wqYTequrpq0Ghm4DcJAIOOor3I9/4aCDg/0qkynXW2FwJRhUHmYVj
         ErPZBoLSRHWC9c6MbIg+Iy4ETm6wRz7sB18bPp2iQbwL6S0lOpxg7IUUNuXOfVX5aNAI
         SwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Szw16HNOo1vMmp24mOARIGE8cr3OLxIvjfwYPhv6z4k=;
        b=Qs/SWkaTB49eBV8Nw/RS2u88mx1nME84OTfHE3zAEgDQdlkgDHSKwoVSNjceerbUeT
         N5qxIq83VtJqPsinPt9mmykGJjjKIl84JQLruCevJUH97yTdokR6tOI+jGEqAkjFU3v4
         Cc0o5XSQylOf0YG2b81bWRG/de83Y4A8nSpARLerN2kfrV8Y/zyS7Rs3nS2p/5bZKNeF
         niJzW55jUBG8YrpfMIUcjA62RPGM1ejo+L8RFyWYujG/7yRcs1ryLvOdfqsA/TJ7InpX
         DQuBY3A8wzZYFrxypCVcR/bDzaB9hzrkKqn0Th/tLew2V49J0UCWgw9OcYEyG8VadMFx
         WAGg==
X-Gm-Message-State: ACrzQf3vTLC0RVD17P9/Y+oi6dErSm/jBwzNhGrNbq3r9nQmjlGhhOUO
        ukOxCaqKHBulMcfW71RojOPXe58pGzcB+X/xLjKybPBfEjQyEw==
X-Google-Smtp-Source: AMsMyM6371bLGEWL5wtfTeTXUqmM2SS9KlEDnA+ivkixv0nPWmJYaAX0Gdocku1QAfI71i48ZRgChvYcLN7zQlhVQTs=
X-Received: by 2002:a67:fdc3:0:b0:398:26c4:52f9 with SMTP id
 l3-20020a67fdc3000000b0039826c452f9mr3955679vsq.8.1664524422845; Fri, 30 Sep
 2022 00:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-VjpyJxPNJ0438FbxEWxNbyL7zsCFwrEt6Tzw-vHz0ZQHxmg@mail.gmail.com>
 <CAP-Vjpzqw=_t61tyJ7SPCLHresuX7XXv2gyQgO8NW1p5dNsViQ@mail.gmail.com> <63365039486df_233df208aa@john.notmuch>
In-Reply-To: <63365039486df_233df208aa@john.notmuch>
From:   Owayss Kabtoul <owayssk@gmail.com>
Date:   Fri, 30 Sep 2022 09:53:06 +0200
Message-ID: <CAP-VjpyWM6dtyPfWJNrx79Q8WEWKLYL1gRjZwyP+NJdoy3bnjw@mail.gmail.com>
Subject: Re: Fwd: bpf syscall failing on aarch64 with "Invalid argument"
 (Asahi Linux on M1)
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org
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

Hello John.

The "minimal" program in question is the one from:
https://github.com/libbpf/libbpf-bootstrap/blob/bc186797086bee39769e3f24bcccf292a94cdcb7/examples/c/minimal.c


On Fri, Sep 30, 2022 at 4:11 AM John Fastabend <john.fastabend@gmail.com> wrote:
>
> Owayss Kabtoul wrote:
> > Hello.
> >
> > I have built libbpf from source (a7c0f7e). When running any of the
> > provided examples, the bpf syscall fails with "Invalid argument":
> >
> > ```
> > $ sudo strace ./minimal
>
> Could you post the minimal C code. Its likely easier to read than
> trying to parse the strace output. Sure we could probably figure
> it out from strace but lets go the easier route.
>
> Caveat I didn't bother to try and read the strace.
>
> Thanks,
> John
