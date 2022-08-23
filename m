Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1726C59E555
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 16:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242414AbiHWOtH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 10:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242442AbiHWOsq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 10:48:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983BE8708B
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 05:10:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DD85615E8
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 12:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A60C433B5
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 12:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661256545;
        bh=HJshxCeNGwXJZyi2uX/UEN2GZGeybEcTynXXCpJmkO4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Aefz8O8k2n0VL6lcXenjJq37jc3XytL31Pv/vS1vbRhRVbtavbpLbItLumrF9425D
         LbK1v1R/i5c//avnOrrCRwYT8EF5oYaOActaamqWQDsN0eOAqQll6J6Oe4wesvKlvR
         SxNwxrJRj/eQGjYzyRTxp6H4UINxswLl/P1Yi3r6XH/CeF5iAfelA4hfYC13cEPuth
         Hvn4tAtYEYM452UUeV+BBxbv7q6+iOy+p8cE3kmDiWRBWCZB3KH8tMuLBtRgu9W0Gk
         IwK/my+xwFH6jgx8naC5EN8C4BP4Y0GwhYaGxh5NkDPnGwpGmyZD9D9GibWIMkVkJF
         ON5H18NuLTqnw==
Received: by mail-vk1-f175.google.com with SMTP id i67so6999531vkb.2
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 05:09:05 -0700 (PDT)
X-Gm-Message-State: ACgBeo2fti4ANJ3IdrLPr8jaDDnwJvNF8ZM2neY84pKAS1tWfYQ/vkjr
        D3CjJvyRFU5TFAv6QGUwji62lQRFloBm5CLdEfo=
X-Google-Smtp-Source: AA6agR6vvUVddKo+cJC/PGP435i2eqsLDAd1qBZDlzFcGKY628TDUoiMEQuof1NGSEXaXvq9GKHaTOYTSootdZ+8QRg=
X-Received: by 2002:a1f:1d4d:0:b0:382:59cd:596c with SMTP id
 d74-20020a1f1d4d000000b0038259cd596cmr9472460vkd.35.1661256544491; Tue, 23
 Aug 2022 05:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <1660996260-11337-1-git-send-email-yangtiezhu@loongson.cn>
 <7af3c82c-220b-1e9c-765f-105480264ae6@loongson.cn> <CAADnVQLx=V05UuyF2U5Scf=LUO9EtCCB=MkgWr_ycV9R0dgZQA@mail.gmail.com>
In-Reply-To: <CAADnVQLx=V05UuyF2U5Scf=LUO9EtCCB=MkgWr_ycV9R0dgZQA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 23 Aug 2022 20:08:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4eTQyhNC5CsH0Bbf8w6VD_goN98N44VxFdH5_dp=NQCg@mail.gmail.com>
Message-ID: <CAAhV-H4eTQyhNC5CsH0Bbf8w6VD_goN98N44VxFdH5_dp=NQCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/4] Add BPF JIT support for LoongArch
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, all,

On Tue, Aug 23, 2022 at 8:46 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Aug 21, 2022 at 6:36 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> >
> >
> > On 08/20/2022 07:50 PM, Tiezhu Yang wrote:
> > > The basic support for LoongArch has been merged into the upstream Linux
> > > kernel since 5.19-rc1 on June 5, 2022, this patch series adds BPF JIT
> > > support for LoongArch.
> > >
> > > Here is the LoongArch documention:
> > > https://www.kernel.org/doc/html/latest/loongarch/index.html
> > >
> > > With this patch series, the test cases in lib/test_bpf.ko have passed
> > > on LoongArch.
> > >
> > >   # echo 1 > /proc/sys/net/core/bpf_jit_enable
> > >   # modprobe test_bpf
> > >   # dmesg | grep Summary
> > >   test_bpf: Summary: 1026 PASSED, 0 FAILED, [1014/1014 JIT'ed]
> > >   test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
> > >   test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED
> > >
> > > It seems that this patch series can not be applied cleanly to bpf-next
> > > which is not synced to v6.0-rc1.
> >
> >
> > Hi Alexei, Daniel, Andrii,
> >
> > Do you know which tree this patch series will go through?
> > bpf-next or loongarch-next?
>
> Whichever way is easier.
> Looks like all changes are contained within arch/loongarch,
> so there should be no conflicts with generic JIT infra.
> In that sense it's fine to carry it in loongarch-next.
> We can take it through bpf-next too with arch maintainers acks.
OK, both ways look good to me.

Huacai
