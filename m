Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894615209C7
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 02:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiEJAEa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 20:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiEJAE3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 20:04:29 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972C02BD0F2
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 17:00:34 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id n6so8471393ili.7
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 17:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P61VYHC3i6xEU/QnQf0liUJxhGpXc5cEdEz1skPCE98=;
        b=puVno8HBca4GoS3Tgu5p6/fkSX+f5TP0w9ySA5g2dfYW7pDalOcPkURnu6xAonXc5A
         7NZY+nzxK776pl3t2CS2h1ejOme06sz0FNLTn4QV0InU2qJv2ikSWfsv2Sx3ewcVb/sm
         0nQOgRhtF08quiif6Weoe5blArb4419wqwBiGCvDkhS8KUEx0JvDar4cnLzgwTJg62cp
         4H2jwU3VOnR8Argg6YSHdhF8zkZ75hugWgC1sXJXNWl5kL7QXaD0iRvp4wAWrEnJF6BE
         hoSv6cQ1MApavoOLU0XdRiOTkk62FE9mgsoHn+BOExyJ2yDNZssDvnVWQUL1QhoBs9Wv
         CRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P61VYHC3i6xEU/QnQf0liUJxhGpXc5cEdEz1skPCE98=;
        b=e21azSmhecpAbQvRya6E3Fjv4XtZdVGqV9+7uIb1O7hXLyORAs3s4utnb0VYaJxb0W
         PYUhfGzzwNyPZlr0a5eyUY/lrtQmQ9ju2/yv2ZEXShtHb9P6DwA4AyEJ0hqWHTk9pHD+
         J/dB0p/nj16H+eHzeXl5qeCVNghjMgDZbD2LwUOwum5WLzoWKUmyGyeV4X3N104RZ+bB
         fa7ACtCDQYqjxo2wEx1jB2JTWWQ3SklhQOWpshpq4+AHm9w3FIsXOHRGeCTGX6/t7/6J
         kVLCBX6zsgHcFezz7EPRLfgtuSX7S4jmPEHxsdZ/3ytdufvOsbfLST0bAc1CJmb1hG9y
         xJpQ==
X-Gm-Message-State: AOAM5332uYjrhaMYWeHmfY4b5N3y9gLL2lB56RJXgC64qh9WxNoUKpft
        mKKehfTW1UtIMgx72VORkIYpoQ4i0kmWIjOjU4NJ6zXu
X-Google-Smtp-Source: ABdhPJwqEcqORtNTzDH0Hi8ouk0v2Nm+GI9RY0KAtErLi1yHLZa8uAUb8fS0bk2uJqIIeIlmVPxPZOXZPZ/3T+nkCZQ=
X-Received: by 2002:a05:6e02:11a3:b0:2cf:90f9:30e0 with SMTP id
 3-20020a056e0211a300b002cf90f930e0mr4525991ilj.252.1652140834039; Mon, 09 May
 2022 17:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAN9vWDLY24LEY-zhBSNVRTPBqbYQd+D62av0jKK_BqMvwt5-ig@mail.gmail.com>
In-Reply-To: <CAN9vWDLY24LEY-zhBSNVRTPBqbYQd+D62av0jKK_BqMvwt5-ig@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 17:00:23 -0700
Message-ID: <CAEf4Bza6Ks-FGAGkLCGhK1KEDRdtqv==y7nN63KejF829XQtfA@mail.gmail.com>
Subject: Re: BPF maps don't work without CONFIG_TRACING/CONFIG_FTRACE
To:     Michael Zimmermann <sigmaepsilon92@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
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

On Tue, May 3, 2022 at 2:40 AM Michael Zimmermann
<sigmaepsilon92@gmail.com> wrote:
>
> Hi,
>
> I'm using a kernel which has TRACING and FTRACE disabled and it looks
> like BPF programs are unable to communicate with usespace.
> I've reproduced this on aarch64 and x86_64 with both aya-rs's XDP
> sample and bcc's "tc_perf_event.py" sample. bcc's sample uses
> BPF_PERF_OUTPUT instead of maps though.
>
> Everything seems to run and work correctly, but there's no data being
> send to userspace resulting in no log output.
> Is that expected or am I running into a weird bug here?
>

You probably need to provide few more details on what you are trying
to do, what you expect to happen and what's actually happening. As it
is it's hard to provide any useful help.

> Thanks
> Michael
