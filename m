Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE505849E4
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 04:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiG2Csf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 22:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiG2Csf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 22:48:35 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8278061723
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 19:48:34 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id h19so357095ual.8
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 19:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc;
        bh=+D1zF2DCKf5WB+zgoPewh33B5r7wz0pan/6d9WW6hok=;
        b=KW1Hn/a4RFy0cVXQeUYwHmdckhnrxb2Yek1GBhXd5ulmbokGqKBbUpBvlTF8oH4cxn
         PM74oV0ye5obEJJlmZiXboEFiMUjoYs/PBw57JK8gJ17wVZ+T4K81uwlXApKUx9Fpa2i
         z67rWjA1vHc4XrKHzgyNoVK4fN5Z+ggHkGxQ0YuSTkZJkk84zW6WsXwpwaVzdyQUrd1U
         GlTPX/+X5TWUfIz8Ol5tJrRSlRPn+1nl12A7M6HOTyeylT3FkDNA/7dzr3cbxex0TPKK
         4P36LmqwDbsAXcwfmP2VArf9egEnZ73a/+evlFKk8Q3lwHRzxFFTXqzuvXsO/dGudSu4
         yeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=+D1zF2DCKf5WB+zgoPewh33B5r7wz0pan/6d9WW6hok=;
        b=tr+0Dpb8lk8hiPswBdghqhiZGM6nLxP3czQGtF/KuED3WEoc6gox94ZAppd4R1AXy9
         5g1lk9yRDQ1hCvfUDmsBMY4kSltbVMlShKydZCiSV8YHwLnXOvcLObvIirGqLG4xZKEA
         IM/S6/OhpD/m6dzDoVbcdj+R9onR/EESw6xfEusPsnJmvQEkVJstT7L4nfRVtZtqJb/m
         mRC+IHbWQk+d4WyWCMS0RP34zt+brnLM635lu5Z7pL7p7dgCC/pNtQS8BFe7pdlT/Mgh
         8THdJ2ByZO3iQITS+t/lkeLBFJUDhrSIjD6l/abVCppHratR4SoTveE10Y977NGcduEv
         r11w==
X-Gm-Message-State: ACgBeo1ExZVf3recZiK2eDwQ7PToNG4MMKLpVwDqKZAocVMtRCi5Y0jV
        crVQjMHaRC2P33mkQJRGx5BOKfZ3wFG7ZQ/qgCU=
X-Google-Smtp-Source: AA6agR6jQJY5xyd+RyjAvzAnGcvJBzWmqyQ7uP4t7MPAtKqE9EwHzX+FcR37hMuxPfyaJA7I7iVp+ja23YByr/ryGxE=
X-Received: by 2002:a05:6130:90:b0:362:891c:edef with SMTP id
 x16-20020a056130009000b00362891cedefmr608230uaf.106.1659062913665; Thu, 28
 Jul 2022 19:48:33 -0700 (PDT)
MIME-Version: 1.0
Reply-To: edmondpamela60@gmail.com
Sender: phillipcannon202@gmail.com
Received: by 2002:a05:6102:3137:0:0:0:0 with HTTP; Thu, 28 Jul 2022 19:48:33
 -0700 (PDT)
From:   Pamela Edmond <edmondpamela60@gmail.com>
Date:   Fri, 29 Jul 2022 02:48:33 +0000
X-Google-Sender-Auth: RQywGThRAJD0oPMwIzhCZ6ySoGs
Message-ID: <CANLyv5hYMXYStLdsPA+9Ey0xoG8x4L4Db6AmO2s6XGe7g-Xghg@mail.gmail.com>
Subject: It concern Ukraine and Russian issue
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Good afternoon!

Recently I have forwarded you a necessary documentation.

Have you already seen it?
