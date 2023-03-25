Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF0A6C8E4D
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 13:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjCYMqn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 08:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCYMqm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 08:46:42 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C7340C7
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 05:46:41 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id z33so1225293qko.6
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 05:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679748400;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDgw3EdTdOatKS1pHHh0ECvgjZdkiuV7cXcUHAouieo=;
        b=mfTvBwrXi/dUqaJ4hHpAGWeIdSkFjxvtYlvVOVF+ikAq78aaHf72eq50rCGfXwTgXB
         uVRncNdip9s8Wf2JaYuK8EJCJWyBTTFw7ih+Jn07Sb01bLC2DDmOeS4bb5DrLHD6LxC/
         ewqZuRfn2vsIG4GmJTLavBz9JdKI6O0jv7Au2T9RBS9o18ojJyRLdUsxiGE/e+1XKeRQ
         +1BDYgKF88qoZE8R2kPC9sLYPYdWpqs0K6HS3ZYzuAo0yeJIeNze/JSqVsu43xNw5SyI
         IooG5NpyVCcE2u4jONPJgzTdLtFG9OEimurfTAQE/xi6Mhm7dKm42OTeRSzid2xSNHJ0
         eSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679748400;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDgw3EdTdOatKS1pHHh0ECvgjZdkiuV7cXcUHAouieo=;
        b=A3t75c4Jrh/Mh8WUhtrX4IsgUk4MB9+AlA8l7afDOi92gbayKcnz7oag7ImB4xFW3N
         0o82+8ciCMwsk1DZcZQjp5VKd1N/O7dWOh3/KzKCj/dxuL53OheY2srN8J5hYk2UX0tm
         y/gybewJtzIu7vXFlkmJds7dgd4pbaRUV8Vdcuoa0JHOWhIdT49/srVBOF9EDCb5BESP
         CEScsZILwOzqbH5kISFi3IMTAQ9iu2JYi3IKsixcdwLM7QsmzvL554hf7P5gpOuUgxJR
         SZ9qcLKZYFsiXQO+WRnA0xvABPQRAYibxocdIY/oaDrb2H/qjb+9h4jKwAU/bDRkYc91
         Hbyw==
X-Gm-Message-State: AO0yUKVvkDh6IcxItzAHtQ1HKOr9YLT3qqycIW3MezxBVXI+S1Q/jiPT
        2C10eOusGwEZMu8CYIJflol3tyYmJ5wdyiA3PqE=
X-Google-Smtp-Source: AK7set9UpfmeflOCeJEKON7dFZkhdY5/Bda7IizvdvcjcWaDOS2Bn9xOIwQ5dynrYsQz4iwkuUGU1CjjCRyXgG1Kb98=
X-Received: by 2002:a37:4083:0:b0:746:9b7f:85 with SMTP id n125-20020a374083000000b007469b7f0085mr1455420qka.7.1679748400670;
 Sat, 25 Mar 2023 05:46:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:e4cf:0:b0:5dd:d6fd:2925 with HTTP; Sat, 25 Mar 2023
 05:46:40 -0700 (PDT)
Reply-To: hitnodeby23@yahoo.com
From:   Hinda Itno Deby <beattykate.01@gmail.com>
Date:   Sat, 25 Mar 2023 05:46:40 -0700
Message-ID: <CA+AyO7eZvENE4mmDumuvGOZsu0f2ooUMreVucajnumrQvMaLpw@mail.gmail.com>
Subject: Reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:72d listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [beattykate.01[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [beattykate.01[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [hitnodeby23[at]yahoo.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.9 URG_BIZ Contains urgent matter
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
 Hello Dear

My name is Hinda Itno Deby Please I want us to discuss Urgent Business
Proposal, if you are interested kindly reply to me so i can give you
all the details.

Thanks and God Bless You.

Ms Hinda Itno Deby
