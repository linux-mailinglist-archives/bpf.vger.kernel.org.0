Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D9C59CD4A
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 02:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbiHWAqR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 20:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHWAqR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 20:46:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC964B4BF
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 17:46:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w19so24480334ejc.7
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 17:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mx6iH25MqAk0QMxhP/iujeqf4cbBmojIAuHogERGzHI=;
        b=G58MsPpT2IOBhBXfItNJ3DXENcYBd9TCyC1iO+Cg3M6qAR+RLmhocIiQFJqP929sBq
         W5p5zZYgm03MNASeydGCZi+irCf/Coii3vVDOvRrlhSxOmTaGFKUPkEqwSVFFgpxhWtc
         3sR00Ufs33cgZMUMOWzTrKX5Iu0wSxtw7FpnKZivKBNi4lbFW/vjlH5diCJdyHKP8Py5
         rF8rw8GDHfb68kYofyOjpbQ8tMClnDSkFr3f1KSKLsCNftYZtFa9msQb6Q2pcjfU7Eqm
         SKPrX/grXzFrm6oF+0YwK8qgNXszMrY+EZPXOmHnvffI34Fbe8/J2JTEfIO8FDjnzPm/
         ZicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mx6iH25MqAk0QMxhP/iujeqf4cbBmojIAuHogERGzHI=;
        b=qVRcERBvZdjNIU/VRlAulFmWdQm0G5ObVKHhxtxDIRDMdAkRlBqC70TcsoSeXcR+9x
         fsUxu3tfHa5fclOlpceUc2UysEq1xEMUj0xuNQb/Av1vcs266pd3ce5nMu/NPQb3Gzd4
         3/RdsounpxXINgIbOU371u+lUCNdTp4QN2z5AnHe81JfqeVQlPxiNpFrHGeeWgxc9+cb
         ILhYJtd7+rbU8z5sKLSOIvCLAZL77hTY4bV7vupNyF6Pcqwq/8k6HM5dpzqewVyjmjhW
         DM6Yb4UqrT8a0zkJurMUC79l+4MRuOfRWAMClhLByvOH49Gw4TEXo6z5kpGaQ6zky06V
         Mf3w==
X-Gm-Message-State: ACgBeo2rk3nAJbBHRUwPPS4qG5tzxkCFcM+E83XZ0Ar0M8jiWxzk4k1s
        kxjD9rsvuLW4t69851P1Xw+BaxiCEGUWl08WWg0=
X-Google-Smtp-Source: AA6agR7dRV5U3KpYlRSuKaXhGaqBP7AHE4avMkDS00GOVn9+YIQXqnJ7XlPdFRR39bpPaDVfkk9twHMnz7xEaq/1Iic=
X-Received: by 2002:a17:907:e8d:b0:730:a4e8:27ed with SMTP id
 ho13-20020a1709070e8d00b00730a4e827edmr14073219ejc.58.1661215574661; Mon, 22
 Aug 2022 17:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <1660996260-11337-1-git-send-email-yangtiezhu@loongson.cn> <7af3c82c-220b-1e9c-765f-105480264ae6@loongson.cn>
In-Reply-To: <7af3c82c-220b-1e9c-765f-105480264ae6@loongson.cn>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 22 Aug 2022 17:46:03 -0700
Message-ID: <CAADnVQLx=V05UuyF2U5Scf=LUO9EtCCB=MkgWr_ycV9R0dgZQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/4] Add BPF JIT support for LoongArch
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        loongarch@lists.linux.dev
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

On Sun, Aug 21, 2022 at 6:36 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>
>
> On 08/20/2022 07:50 PM, Tiezhu Yang wrote:
> > The basic support for LoongArch has been merged into the upstream Linux
> > kernel since 5.19-rc1 on June 5, 2022, this patch series adds BPF JIT
> > support for LoongArch.
> >
> > Here is the LoongArch documention:
> > https://www.kernel.org/doc/html/latest/loongarch/index.html
> >
> > With this patch series, the test cases in lib/test_bpf.ko have passed
> > on LoongArch.
> >
> >   # echo 1 > /proc/sys/net/core/bpf_jit_enable
> >   # modprobe test_bpf
> >   # dmesg | grep Summary
> >   test_bpf: Summary: 1026 PASSED, 0 FAILED, [1014/1014 JIT'ed]
> >   test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
> >   test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED
> >
> > It seems that this patch series can not be applied cleanly to bpf-next
> > which is not synced to v6.0-rc1.
>
>
> Hi Alexei, Daniel, Andrii,
>
> Do you know which tree this patch series will go through?
> bpf-next or loongarch-next?

Whichever way is easier.
Looks like all changes are contained within arch/loongarch,
so there should be no conflicts with generic JIT infra.
In that sense it's fine to carry it in loongarch-next.
We can take it through bpf-next too with arch maintainers acks.
