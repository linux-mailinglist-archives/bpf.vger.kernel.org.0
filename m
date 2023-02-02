Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B22687AE3
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 11:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjBBKx7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 05:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjBBKx5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 05:53:57 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8AB3594
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 02:53:54 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4a263c4ddbaso21678207b3.0
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 02:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeUz7W5STdevGt5G9BBQgnVLYpQy3pLUPLWMeOjLAJg=;
        b=EBLVo/hOzONGPvV+DdZWNZLFJZ4kkNZk8gwAGDAIOOSVHBgq+aFQRxFA/4RQmcvj+P
         6AsrXQ4y+FaZziJGv2QL40V1+r+f8blrcLlEvj8d7OEjdMuEiPrIp0XITbsHh6jBty43
         lC/gCF+xkCCfoOvcDxZcqqsymiCJQfx9VjMV8I4TSeKLC/vps8ua+z9AYcJmSFajuI01
         fOo7fvTRGMYS6WUHoX5l8Zr46Z23Ei13IkXYFoBMfpfeyYVyw6ogKoFdW9yGRrKJ42jt
         yUaepSLYvGGC8CvW8PJg57CdLf00sjQfCe/4hN66cRKe0pDrlXw7oa/9SpF8DeTMUI8k
         Yarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CeUz7W5STdevGt5G9BBQgnVLYpQy3pLUPLWMeOjLAJg=;
        b=3tWuwvWtKFEGh62IjQOqaYDRHhFbB4+J5XJAUckbyFQvOJ1dFKaQo9avLezReCQf21
         GD4mo+ELQe5nAr8wEtBVVWSxyrdugdp5lmpCyVOWr70kpA3+8wHKbkzu4Q8ZWzxXSpL2
         uRI2R61zvfahMcKD6qU9wV+mRkA9m98RxmLuZWlSw+6i3oA05+1g5d97EN2EY1fGF4W6
         aSNtozfG8BX+0W8sadKBybm7jVkdy70HEUS4WIPjJbHH/CJzTElhdKfQmFtK7LSooU4F
         mc6j77k7V8A2qX9lhpv6XwCbd349z57RrjwrOJTXv3aiogkUsbyTSOeS9az4soFxgIcP
         dvAQ==
X-Gm-Message-State: AO0yUKX9B8ytBJLlygJOPHzFlsjmmy91ueQGjZZVUA+du1v3Xy3FAEkj
        d/uelWvDHfM+TGJYwOjGfoxkviXaDtu2UJEfaUs=
X-Google-Smtp-Source: AK7set++D/D1EgoX6W7naLUTyl9bfJAulnCR/oaHucEJk6l0uAn3stQWnEIwuFEkLZ0zF3KxSBIHraq201Bw7yFkSzQ=
X-Received: by 2002:a0d:e6c4:0:b0:522:6b25:7a with SMTP id p187-20020a0de6c4000000b005226b25007amr182600ywe.342.1675335233936;
 Thu, 02 Feb 2023 02:53:53 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:580c:b0:467:ccb7:598e with HTTP; Thu, 2 Feb 2023
 02:53:53 -0800 (PST)
Reply-To: cynthiaaa199@gmail.com
From:   Cynthia Lop <cynthiaaaa199@gmail.com>
Date:   Thu, 2 Feb 2023 10:53:53 +0000
Message-ID: <CALungV_Cz7H6H50Lkb+n1qvBaU4ZsFvSTQhat1XF8ECfm0mpsA@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.7 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1136 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7685]
        *  0.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        *  1.0 HK_RANDOM_FROM From username looks random
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [cynthiaaa199[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [cynthiaaaa199[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [cynthiaaaa199[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

How are you doing today?

My name is Cynthia Lopez, I am 37 years old and single . My country is
United States . Now i live in Kiltseva Street Kyiv, 1013.Ukraine . I
work as bank auditor here in Ukraine .

I have something important to tell you because i contacted you for
something good important , Please introduce yourself so that i will
know more whom you are ,
