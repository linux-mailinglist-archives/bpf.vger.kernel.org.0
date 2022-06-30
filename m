Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E03E562490
	for <lists+bpf@lfdr.de>; Thu, 30 Jun 2022 22:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbiF3Un2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 16:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbiF3UnZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 16:43:25 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28BD377D5
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 13:43:21 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id n10so114595qkn.10
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 13:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ErrndpgymsMtrIg0H9zOHcUdUii9XdPu/yA4WHlmxXw=;
        b=JtpimtWpgi17Rxa6x1HY2fH1BDH16MGtKLkqOSXFHTRVTbYXuNfmX8iDOTXW4/3Ddp
         ur41Vmwej0Pm25fteVfcoyNeVVgNofFAVqePHVk6gip4LkzPh1mjq84WxAkYNpq6MWGs
         vYwP+qwLi/rpsgJY99Ahl6963ScwjWrlbkUdfnpmfUL5GlQBVFKJn1ADdgY5uawbJ++m
         /mLTj4IecazSuNqH6wWb9XmN59psuFYfacIJekpYN9JxMomHWb70P+CZ5C/cG5ydxLCV
         OtwFqOItawdPumJ+fFD7Z4ReyILZci5Ft/vvb/wZlPp3UBASCITPDJr5YvkLCyaVAU8p
         30wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ErrndpgymsMtrIg0H9zOHcUdUii9XdPu/yA4WHlmxXw=;
        b=fgitI/vUooXeM1KsUer8+iBTj8gKPiA/KfI7IIkyQ6kyncQ7ujnoh+bJJyWRpSkucX
         aA+5jTPwQHd6gVWvUnBmqXaxbAWgrHbyHuhxcIKQxbaHUgPpeYliBiyKelB71FH53UHZ
         j06/4G360766P2lJtEvamdY/AQEuK8gwBlISCRzQkAJMQhfTebCTX7nKqfe8mTbZ3ujG
         azXTCHP38MeHBzMbL+1xZAiQ/Gpo6/I3RwikmqoBhFVJVjd1VetszRKoNHG+oi6kBkD9
         8BqOCJGKorTB6OuXrJfWWzdzEjADJqT1UbNeUBFr3fAHjje+Muo2pYhUOttR1I6/UDzn
         TMQg==
X-Gm-Message-State: AJIora+wbhi6RqtS1sq18xsLAQ8Az4HL82T0e7fbqklxhVgzcxvmETBS
        ELWjc7g1/vxdJqqo25BqDZeD/+OldMiBhYYmydtRrQ==
X-Google-Smtp-Source: AGRyM1u9M09bZfTZTeS9VH777eRVNUJdnHrl8QSycOG8gOImSaCz8p15BAza0d2QZfCP273BG666tEOc5Sb9sA5TXS8=
X-Received: by 2002:a05:620a:67b:b0:6a6:8775:33e1 with SMTP id
 a27-20020a05620a067b00b006a6877533e1mr8099880qkh.583.1656621800831; Thu, 30
 Jun 2022 13:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220629154832.56986-1-laoar.shao@gmail.com> <20220629154832.56986-4-laoar.shao@gmail.com>
In-Reply-To: <20220629154832.56986-4-laoar.shao@gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 30 Jun 2022 13:43:09 -0700
Message-ID: <CA+khW7h2DWPM4nAOav+t8k+zbnUOkCO9C+47bSVN0UMHRE-v_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Don't do preempt check when migrate is disabled
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yafang,

On Wed, Jun 29, 2022 at 8:49 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> It doesn't need to do the preempt check when migrate is disabled
> after commit
> 74d862b682f5 ("sched: Make migrate_disable/enable() independent of RT").
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---

In my understanding, migrate_disable() doesn't imply
preempt_disable(), I think this is not safe. Am I missing something?

Hao
