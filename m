Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDA36DE4FE
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 21:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjDKTaz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 15:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDKTay (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 15:30:54 -0400
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C344412B
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 12:30:53 -0700 (PDT)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-184549428acso7014442fac.8
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 12:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rethinksolnmedia.com; s=google; t=1681241453; x=1683833453;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3c1QbukfXf81y9oxS7ubcfQ0cxpGbQS6eBUbDXuLSwA=;
        b=c03Yx8wv812j+WLggtKItqQ8HyR73SZBzM1f6dSb8XyPeUwfN17DI+4VXKdBlfwRyz
         jDSfVBKZx6mL3S7oEszrMnY+Jui/CsNKvSPnQp4+9WybAjxxWvqee1235RS7GJy0WP2U
         i0nS3PySUYvX+5ZxYW26NtOeVTGIwbf13os8pFlPxFVrWQdW/Xx9CfWel92w0iZ3wLXk
         GdCGJy5GyLuMaNxRFjyusIe6qJT6OyUT1SrxDNPBGtD1eNbDkx4H4veL5DI3o/JqLp+1
         HSYejXJJJRFhofiYG0Vjer3lzCRCwmUFOUDVpSJlfsSv6dlptsOY8ybcmNyhgm5zgYIX
         phsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681241453; x=1683833453;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3c1QbukfXf81y9oxS7ubcfQ0cxpGbQS6eBUbDXuLSwA=;
        b=sGzpGZYK+Q46kDOeJp86i6KT/3gTXE+aREnIdOq/e9extnBKZJYbZJhQwIJaJFc4/u
         RFlFt9gnueOLZZetu1I39ax7vz1WzOot4JW685q8vfjyJ1HkHyKzOGDRrAYS9Son0rRi
         wkD05eRdgMfDparjjtIeyoRTUmU03jXJ4DepLtSV8Map4olTdIgbtSzBkAw+TIutW2sY
         AuWQFQmT91aKeBdWPR9e2L9ELi/+4Dh6q8hO5CzFPH+BTxTiu5j10/zYW9makKPl48nH
         sWneJRRnrYwGlLFh0b08Tg+KTHZ7sksAajEgbdh9M394H0On+BE+SUXrql6gt3UEfKNq
         hu1A==
X-Gm-Message-State: AAQBX9eI+y8INhDWbX8/FIH0uxd52GiuXNHpr2dkDTD/FlzB3z4FDjv0
        iryioWJYq1sHw5HVOQ6F3QV193DT2L6G6T2KRSKhBA==
X-Google-Smtp-Source: AKy350aSmkdx5WfezzlANt7yPZUQlrMo6aZWmUfHqTz1o9xmT+Ifyzg5IxGJY8DKH7jki5gcpXycYXA0x/YkFQ6kd5Q=
X-Received: by 2002:a05:6870:56a4:b0:184:2a60:6005 with SMTP id
 p36-20020a05687056a400b001842a606005mr4563655oao.7.1681241453205; Tue, 11 Apr
 2023 12:30:53 -0700 (PDT)
MIME-Version: 1.0
From:   Savannah Jackson <savannah@rethinksolnmedia.com>
Date:   Tue, 11 Apr 2023 14:30:42 -0500
Message-ID: <CAHEvo37XLr1=9ajAvpNGLRoGeGXL6PkmZvvi-c1otOd+0LVu8A@mail.gmail.com>
Subject: RE: RSA Attendees data List -2023
To:     Savannah Jackson <savannah@rethinksolnmedia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Would you be interested in acquiring the Association for RSA
Conference Attendees data List 2023? Which Includes Complete Contact
Details And Verified Email Address.

Number of Contacts :- 35,562
Cost :- $1,785

Let me know your thoughts and advice on the next steps.

Kind Regards,
Savannah Jackson
Marketing Coordinator
