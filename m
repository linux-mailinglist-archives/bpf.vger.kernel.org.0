Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4744158A0B1
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 20:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiHDSpd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Aug 2022 14:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiHDSpc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Aug 2022 14:45:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D92FD28
        for <bpf@vger.kernel.org>; Thu,  4 Aug 2022 11:45:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y13so803866ejp.13
        for <bpf@vger.kernel.org>; Thu, 04 Aug 2022 11:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LT8EntzTQx4FXzf8ujFhKvJBalVOvM5VsXwPWJElMgc=;
        b=WbQqp6sDHfxbwf5Sk9FnpHFoUsP7WUJaw52RywSIxZ/Hf2yBhnA1uskxE7QulN5vlE
         7QanDulOQ5prlfpwP3T712XgDU50zlTtMQFGq9NK/WG8QQqOFeaNEWFu32U/DlmT9Lw9
         1/rgDbSy94/AEbCNzfg6L2XmQlxMJQeQOeJhGZkdd603LdDQUvv1GjMLNSC/yGR7powT
         HZdbauIoQb6MrKwFC1vJkNH9m+lTNlmUTOR+OHj94dafNKsEwEh9BUypxc2wqQ8lQR95
         z7U1uVMCilBhZ2XsuUJoUHKOaFNuJObkz8qcxwKRf7vPc/PCM/gQXyXjk26nJShVlsYG
         7SwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LT8EntzTQx4FXzf8ujFhKvJBalVOvM5VsXwPWJElMgc=;
        b=36VPPS8fs9DoXnQ6KS9BvU5q7IT9qlGhIeL0udgOykqQllPEKJ00DpIkMBOLL9f83R
         UdUHXa+IJQgY+ZDsrSW66l92qe5ioJmpcjEsiMFcWek/vVxSpYZDnsmxmrgCkavPKF3Q
         nJ1BvSUKvbq12e//inn3+Cmyu5RqwD+WBTDXWpjJ7NzCxJzKAdannNn0qKT1z58oLaGF
         oF1m+UkZd7/gPzrkeep4PKs004crIr4UHBoqctdDkHtTFu1cBMO4hS6tv7zXwmFResmU
         bmhNdWwEfmwk97SUJ4tCmSpFt6z9PBNxINAU/XREXJyOrvth4maXfQ/ktgoAjOxaHCzP
         T10w==
X-Gm-Message-State: ACgBeo05hVcubTScRm0ubeKirHpSsjo+mVzCOVdxqg70uENII/h4w8tZ
        PmPS/rMCiOwf2QbTQRqFR0JWgG2nFno06O7B1sUCo3j6xRw=
X-Google-Smtp-Source: AA6agR5nJPN6X0qrhQou7vYaNokGCVUrdNomzhwq5HoSmxKUsBu6PM41Ab2OEduR6uSdyHBWWAA4rgkuR++UvaIieUY=
X-Received: by 2002:a17:907:971c:b0:72b:83d2:aa7a with SMTP id
 jg28-20020a170907971c00b0072b83d2aa7amr2340698ejc.633.1659638727421; Thu, 04
 Aug 2022 11:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-4-joannelkoong@gmail.com> <CAEf4Bzb2Jev=NpwzkKn8UPRe-99-3WcgySfGwOB6W8n-3E4G1g@mail.gmail.com>
 <CAJnrk1Yg75-pMX=T9AnXoCWhvRX+bA=DBkyj1Quci_zkazpZyg@mail.gmail.com>
 <CAEf4BzZVq2vG3DOx0Pa03ksucSYZK5=QKMPTO1NYqces4TPAJA@mail.gmail.com> <CAJnrk1aodZ84YjaHNcxPZhREA+nx4=2Rh=4Nx9NcmkYvWn6S0g@mail.gmail.com>
In-Reply-To: <CAJnrk1aodZ84YjaHNcxPZhREA+nx4=2Rh=4Nx9NcmkYvWn6S0g@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 4 Aug 2022 11:45:15 -0700
Message-ID: <CAADnVQLEkfj-T8DXgmHU=MyUBL6Hb3TXPwNERzogW_DKCN2Asw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: tests for using dynptrs to
 parse skb and xdp buffers
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
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

On Wed, Aug 3, 2022 at 9:11 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > __builtin_memcpy() is best. When we write just "memcpy()" we still
> > rely on compiler to actually optimizing that to __builtin_memcpy(),
> > because there is no memcpy() (we'd get unrecognized extern error if
> > compiler actually emitted call to memcpy()).
>
> Ohh I see, thanks for the explanation!
>
> I am going to do some selftests cleanup this week, so I'll change the
> other usages of memcpy() to __builtin_memcpy() as part of that clean
> up.

builtin_memcpy might be doing single byte copy when
alignment is not known which is often the case when
working with packets.
If we do this cleanup, let's copy-paste cilium's memcpy
helper that does 8 byte copy.
It's much better than builtin_memcpy.
https://github.com/cilium/cilium/blob/master/bpf/include/bpf/builtins.h
