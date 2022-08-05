Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E9358AE30
	for <lists+bpf@lfdr.de>; Fri,  5 Aug 2022 18:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbiHEQaU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 12:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241522AbiHEQaE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 12:30:04 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE5179ECE
        for <bpf@vger.kernel.org>; Fri,  5 Aug 2022 09:29:52 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id e13so3976254edj.12
        for <bpf@vger.kernel.org>; Fri, 05 Aug 2022 09:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nk4tkar6FQCklwHX1NANYf26V0QQZYpFM8xIdydL27g=;
        b=evx3+bJ4FbDQO1utt7AIkpXgtLAgg0Zl+ei+DcDS6dsPZLuUnqtrEPPBuSbh/vi2wv
         hwKNCXU4UKhHtyU+LtR/1X5rLbMspQvPUNTSaiBnD4wI1VcdsanKrt5c9vU6NvxWRtTj
         3/4dKhTAADh1mBnnMpqjG3oagmrHvdf6RtaBftb8eqYQPo/LV6/3fIgSmq9NlsJDTEvX
         6YrVjlfApaFhzT9kjqv9c93KCsp/bUalT/AjWP/NiJKPnAl0+Kni6+E/MncLYx1X4fSY
         93vVCiyf0FgPLhQks2CUuraMi7icTPmqKsRq2WP8eaRmh1pujeLD11Fyh1SWWUJqNsnC
         B4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nk4tkar6FQCklwHX1NANYf26V0QQZYpFM8xIdydL27g=;
        b=l23fWeU7XIuqy9b8R/jZ5RwPuvvOktlGN94i7Cx2fMZrAqapNkpwqoQD5m7LSKRbHc
         YxTCixGT80tNZivxE4QTu6tKGcVN+Jz/DvzBFfLLzeC3nrxWg6A4vjt+UslDtrCgbeUS
         WPz9AcbErZpwFYMGR5mB9nI15jJl7fjPs8eqwj8Nlsa9P39XaGFC8duTHONT2C2fmxsc
         gKas6Hq32umzF5PtKatxCzTEUeFdCo5qvFfdpXUt32YQmR+cxI5qYlPVgz6VxnwTLo5d
         JDXQkF+LWKRbbd8J5KVpKjoUE5pUtbBQeiHHF2HrAnLr10p0vL9nTlMl3n/aaCyXuzm/
         u6QA==
X-Gm-Message-State: ACgBeo2qvB8AXdqEhn6O2G/p+4gyEd4sC4fOoOSB/fuJFvQaQMYbjhUd
        BlsPtULi60mQjrcKwmq0gCHCB7mozyPYqMqqsAKgJpPe
X-Google-Smtp-Source: AA6agR61VsVwonVqdFPw96Zw1uRKIWHsneA7D43V0cRzo2/CTdlWfqdIM9adnOSbrScHqSuT2wKnJqFk+tXwXyzhsW4=
X-Received: by 2002:a50:fb13:0:b0:43c:ef2b:d29 with SMTP id
 d19-20020a50fb13000000b0043cef2b0d29mr7460429edq.378.1659716991358; Fri, 05
 Aug 2022 09:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-4-joannelkoong@gmail.com> <CAEf4Bzb2Jev=NpwzkKn8UPRe-99-3WcgySfGwOB6W8n-3E4G1g@mail.gmail.com>
 <CAJnrk1Yg75-pMX=T9AnXoCWhvRX+bA=DBkyj1Quci_zkazpZyg@mail.gmail.com>
 <CAEf4BzZVq2vG3DOx0Pa03ksucSYZK5=QKMPTO1NYqces4TPAJA@mail.gmail.com>
 <CAJnrk1aodZ84YjaHNcxPZhREA+nx4=2Rh=4Nx9NcmkYvWn6S0g@mail.gmail.com> <CAADnVQLEkfj-T8DXgmHU=MyUBL6Hb3TXPwNERzogW_DKCN2Asw@mail.gmail.com>
In-Reply-To: <CAADnVQLEkfj-T8DXgmHU=MyUBL6Hb3TXPwNERzogW_DKCN2Asw@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 5 Aug 2022 09:29:40 -0700
Message-ID: <CAJnrk1ZHY+ajmMkG-pB_bjWhb0g-HJmeKg6NtP4YC2m8cjvW0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: tests for using dynptrs to
 parse skb and xdp buffers
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
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

On Thu, Aug 4, 2022 at 11:45 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 3, 2022 at 9:11 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> > >
> > > __builtin_memcpy() is best. When we write just "memcpy()" we still
> > > rely on compiler to actually optimizing that to __builtin_memcpy(),
> > > because there is no memcpy() (we'd get unrecognized extern error if
> > > compiler actually emitted call to memcpy()).
> >
> > Ohh I see, thanks for the explanation!
> >
> > I am going to do some selftests cleanup this week, so I'll change the
> > other usages of memcpy() to __builtin_memcpy() as part of that clean
> > up.
>
> builtin_memcpy might be doing single byte copy when
> alignment is not known which is often the case when
> working with packets.
> If we do this cleanup, let's copy-paste cilium's memcpy
> helper that does 8 byte copy.
> It's much better than builtin_memcpy.
> https://github.com/cilium/cilium/blob/master/bpf/include/bpf/builtins.h

Maybe we should have a separate patchset to changing to use cilium's
other builtins as well (eg memzero, memcmp, memmove); I'll leave the
memcpy() -> __builtin_memcpy() changes to be part of that patchset.
