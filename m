Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EFE5FFB30
	for <lists+bpf@lfdr.de>; Sat, 15 Oct 2022 18:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJOQUm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Oct 2022 12:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJOQUl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Oct 2022 12:20:41 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EFF3F313
        for <bpf@vger.kernel.org>; Sat, 15 Oct 2022 09:20:39 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id e15so6153699iof.2
        for <bpf@vger.kernel.org>; Sat, 15 Oct 2022 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6c6RloR1f1meVJL/BrGR4Y0ez6uzlYlKHhaiRNYhs0=;
        b=EUyjyWEGIR5AGofPr4lafBp81ZRgHH3kFX97VOPCG4HVodpSBK6m1tUWshmy3Ux9vk
         3QM40vUC2RvWB4Fngf6M/u2ttP0XWlHC6ic7CLbCX1nx3GebsmuZCkM+WVdCeniHQNtA
         4ENdvn0SpI/Q0eOsBjimnteAnzU+UP1sLIlTr0Olh+XeIMK+vClwPNgRGXfJD1oFKKl9
         1CmNvRsr7KNRjtwm3rnpmeBnS7BZukWFKGzsX1+lhMuX0fNTmA9tjRRwidrsq2HDu81o
         nH3XZ8eeYUfqxDaX4UTYVcegG6mwZhNBM2YBTqVjWTDqLNTos4DA/kmzLf4lAxk8AKjO
         caHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6c6RloR1f1meVJL/BrGR4Y0ez6uzlYlKHhaiRNYhs0=;
        b=xfLD3DGP9eFXgWx/xHCfUGkXrLOoNdxBDYnDND+/gSvSAOEeueD094nvyJ2FGUq9i/
         J6259mkEsvreKT4t31EDTYGsZHV6qPwVcPhOE7ZkgVZZFJd5MVhcsEovYGGG+bc1p4dH
         F6SwXRSBoPcLZydLav57hH62opJTDd6s1P/LNR4VSSuO3KQON+/+wDWVs6Mr90M+EYQo
         H85ePjegRfGxbnhrl7hOv7yg5egGZZbjmZRyXOdEZxBmeBdZh0GwuRU04cBzHIw2FYR1
         mCA7kwKHNeoyq75LG5an2aZgLS3bB0O7J7b6UtNrn4NvDIC0LZGNi5TVj1LBIsoWXTQb
         rnzQ==
X-Gm-Message-State: ACrzQf3jGnrChjU3IPAGU/URVpCineBAmIW2S1zA8Xkix0fRoiUYoihc
        nMHgbMCusdQtzSj7vfj8xKJ8RUHi6+HurIuyKQM=
X-Google-Smtp-Source: AMsMyM6OBsx7XiamJCNs/0NMiUW9G/qxJecNpNlkZbWtYN+l9AuZw7S65NMzB9kb8KqLYbdJ2+mh7R0Z4K3VMYlBf9E=
X-Received: by 2002:a05:6638:d45:b0:364:fa5:de94 with SMTP id
 d5-20020a0566380d4500b003640fa5de94mr743627jak.182.1665850839203; Sat, 15 Oct
 2022 09:20:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6602:204c:0:0:0:0 with HTTP; Sat, 15 Oct 2022 09:20:38
 -0700 (PDT)
Reply-To: mmrstephen16@gmail.com
From:   "Mr. Stephen Melvin" <xxspclmr@gmail.com>
Date:   Sat, 15 Oct 2022 09:20:38 -0700
Message-ID: <CAJdY8AWyZOzcOVb=VopSL1m657CXoynqXm9tZcuzjWgut7+3jw@mail.gmail.com>
Subject: Reply and let me know if you received this email.!!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        *  0.5 FROM_LOCAL_NOVOWEL From: localpart has series of non-vowel
        *      letters
        *  1.0 HK_RANDOM_FROM From username looks random
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mmrstephen16[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [xxspclmr[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Dear, How are you today and your family? Want to believe you are
all doing great.

Please reply to me as fast as possible. I have important information for you.

Kind Regards,
Mr. Stephen Melvin.
