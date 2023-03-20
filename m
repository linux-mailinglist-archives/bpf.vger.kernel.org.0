Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3266C181E
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 16:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjCTPUr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 11:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjCTPUB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 11:20:01 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534482BEEB
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 08:14:43 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id k17so5554612iob.1
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679325281;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebEOfpRXdHWY9ycpXGKvSUp16AC2xEFrZPbwbiRK63U=;
        b=YCpcvyVsCZ1dFFajN6yrUdvQXQzrd0szx8xbwq02aNadbIMOFFaNZ2aMHn3M4CuAls
         m8WG7fCstZmU69WxapBFHRWgWM+QQhuBbMDxYylVFU4ZXxKgZBHFZCMYxTUCvw2Fqv9i
         cYAc9k1waXNkq5Z2SmwyAQvT5ihfjToF4hVTqbdwfzTy1t9o1MlcWUd527l1Qe4AmOOR
         cnlcAvXvJe1/BfEKELEybI6qEbXpfRhYEVYMpSmGGIQhLADCh0TUjgfBPI2BnS/PZWxr
         oC7B6wkxE1nEuGMoRO6lcD6C1+e8QbxmMzWWr81PwbXpPoom0te67w2Usr+SyRr4q3+0
         c0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679325281;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebEOfpRXdHWY9ycpXGKvSUp16AC2xEFrZPbwbiRK63U=;
        b=E6tHhi8PEfwQEDBmctXx0m3tEyA6+L1B6ZfQe34/UfXJ5Q6cSk8WK1cJ5V+HqFejUq
         fe5UI9BXSsYKrDvJzWOTBqKvfq40rVIjOdRYrYo0xK53+y9SJr4WWaE+AZjjrL+P6R5H
         QjG42eZ2McmEjbAbBvfpMJdEQdUz727hePsQN2eU3mTT0p4SXWtVubxFRoA0/6QU+cLW
         0INZLrMJWQsWDaDf5uxukKkWyf0Gnae42I4lST30sNnDAW1tpyNM8FxGS4wMM50s+qDz
         IBDumROy9DrsnIb283dB6WMNbYNvwc2bVXvPsump52HDcgqotBWVjXL4umNnwLcV3GMn
         yvYg==
X-Gm-Message-State: AO0yUKV05QNwjRiBs0mS2LymEEiQtfJH6UE3xh19UpNqyJgAyr5oV/YG
        L5BVwV/lkE9G9cwRJGoZ0tBfz4te61pSFGoIbpM=
X-Google-Smtp-Source: AK7set/T18cJm1RvGQMo+baqoD371bW63cv9gZgX2n8cntVEcNcLPqTTn89JNZRpY8Pm1aP9ixbVxVS3Rbo11ZrNruU=
X-Received: by 2002:a6b:e216:0:b0:74c:8243:9290 with SMTP id
 z22-20020a6be216000000b0074c82439290mr3374937ioc.4.1679325281309; Mon, 20 Mar
 2023 08:14:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:60d:b0:406:45c9:b18f with HTTP; Mon, 20 Mar 2023
 08:14:41 -0700 (PDT)
Reply-To: sharharshalom@gmail.com
From:   Shahar shalom <mrjoshuakunte23@gmail.com>
Date:   Mon, 20 Mar 2023 15:14:41 +0000
Message-ID: <CAE8KSLypxdeNByCc1BWwokRO-VDOmz7sRF7pNh-k6Ca=39=peg@mail.gmail.com>
Subject: Good day
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
A mail was sent to you sometime last week with the expectation of
having a return mail from you but to my surprise you never bothered to replied.
Kindly reply for further explanations.

Respectfully yours,
Shahar shalom
