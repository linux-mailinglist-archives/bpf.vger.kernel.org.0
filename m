Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B6357AF92
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 05:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbiGTDob (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 23:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiGTDo3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 23:44:29 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C454691C4
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 20:44:28 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y9so15400298pff.12
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 20:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+PSJPlZymtlYSTg6ofWEwWeCmvOxPD9VCqup5ZtmP4=;
        b=gBY5otWcCM45UjG7WIR4HFTzNHg0wJDJM6jHcug6K3dvIgd9E2ekQmJgEEg1UWlz/p
         xKZLdUhKM1tqyZLbe4t89WnMFUrQv93QqNEGkM9AdQ6ZCXbjeD9CXitQIgF/TT1h4sMN
         N7h8hOEX7J9JA+bLv6BwavMHisIYY+isi1pkKdd18X2NOdMqGDbvNxAsY7nteu+Kdasq
         NdXop0z/wZNEFts8f0U4HRKRQI8qKWoz/A0q2faUZRbsUiLlpsdro/lE2HKQHswTaooR
         BMLTFRY5MMt/uJcirC/uijZbnct5QNgPTqgJIHM6kuumHg8lZUu/ILhHWQgIQDJvL6uG
         RIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+PSJPlZymtlYSTg6ofWEwWeCmvOxPD9VCqup5ZtmP4=;
        b=vOYUCwNDI+h69kfJ+PMydIMQJrq8R1pt18VCzmrp5cWSA3SGOihuOSv2w0WiX2Loya
         PuD7l7VxlLJ7aeLxS6ycKnv9UvjB2X0s+pS/s4YVzJqifndX+Yzu0BKSgNmTYv3eeI5W
         y4O7nwSDeQzUb7LnwIHeSLyGvfIeQ4MW94rvYRW5+nUb6qifu4h6Nd9IG/Jv/iLH9tu6
         1MMxdjgZJ6PqSMc38i4Fz3y/BiwF4dd++MS/yTb2dVv5DCGUZDgM2yzls+aEQe3S2cvA
         X1Z5XP0cWn3xNJ4eXSL8QF8976rm6Y4aqA/Mq3+aoh7RdtWV9cUju0O56MlvFvT0ZYs8
         4jhw==
X-Gm-Message-State: AJIora8vpzziVZEDASRVI2MseCoRoXFYwBvekUqZsPPVWKQ/ZZeF+iVJ
        lJM5ilsBPfhvEO6eracJDbAqIlD/8cZYqzA3mRxEfw==
X-Google-Smtp-Source: AGRyM1sYKwq08y6bQxiqIw8cm5dqtnnyMCpEDahPGCHbQnOjPOpD6zriqIY7aq9kOOQJDliaorDgzPsRw3wq2ueH/XU=
X-Received: by 2002:a63:85c6:0:b0:412:a94c:16d0 with SMTP id
 u189-20020a6385c6000000b00412a94c16d0mr32433401pgd.253.1658288667739; Tue, 19
 Jul 2022 20:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220720115956.3c27492f@canb.auug.org.au> <CAADnVQ+xFuff3TRhzrPWkJD+MA16MdRvcprcniX4yzxL5Z+=UA@mail.gmail.com>
In-Reply-To: <CAADnVQ+xFuff3TRhzrPWkJD+MA16MdRvcprcniX4yzxL5Z+=UA@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 19 Jul 2022 20:44:16 -0700
Message-ID: <CAKH8qBvuuMObnepogT13F+41L-RzVu6BLR91dnZWbw3PB0ipRA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Tue, Jul 19, 2022 at 8:42 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jul 19, 2022 at 7:00 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > After merging the bpf-next tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> >
> > ld: warning: discarding dynamic section .glink
> > ld: warning: discarding dynamic section .plt
> > ld: linkage table error against `bpf_trampoline_unlink_cgroup_shim'
> > ld: stubs don't match calculated size
> > ld: can not build stubs: bad value
> > ld: kernel/bpf/cgroup.o: in function `.bpf_cgroup_link_release.part.0':
> > cgroup.c:(.text+0x2fc4): undefined reference to `.bpf_trampoline_unlink_cgroup_shim'
> > ld: kernel/bpf/cgroup.o: in function `.cgroup_bpf_release':
> > cgroup.c:(.text+0x33b0): undefined reference to `.bpf_trampoline_unlink_cgroup_shim'
> > ld: cgroup.c:(.text+0x33c0): undefined reference to `.bpf_trampoline_unlink_cgroup_shim'
> >
> > Caused by commit
> >
> >   3908fcddc65d ("bpf: fix lsm_cgroup build errors on esoteric configs")
> >
> > I have reverted that commit for today.
>
> Argh.
>
> Stan,
>
> please take a look.

Sorry about that, I forgot to update the ifdef guards in the header
:-( Will send a fix shortly..
