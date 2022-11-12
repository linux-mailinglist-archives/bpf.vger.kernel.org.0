Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2F9626B46
	for <lists+bpf@lfdr.de>; Sat, 12 Nov 2022 20:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiKLTq2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Nov 2022 14:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLTq2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Nov 2022 14:46:28 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661F413E27
        for <bpf@vger.kernel.org>; Sat, 12 Nov 2022 11:46:27 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id g15-20020a4a894f000000b0047f8e899623so1081639ooi.5
        for <bpf@vger.kernel.org>; Sat, 12 Nov 2022 11:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GTypzwwLcb7xKfsuPFEGFg2yii9gxBj0GXhwmgB4su0=;
        b=Y3eFHj8/yeqk4rbOMRv4EpAmGV0hqWPElvQNvIXxgbC4Y98B/yOhXizKSArk0MYgsm
         cKZ9ciOyywIoY+JGk/HTWuWk9Qns/TOGqWm7epz2J5RlgtXQMDW4jlmBAVyK5AKnzQRP
         AxjfgqbnbP68jdFNKnYtjuDtE98bdIGtF+eR7ojFpwce1ORa2a7xKufn8oyW+BuoSDYk
         RUpCXOpnk8kpseekEXZuQbvaqSnzOvwB24lKbZzzQmZbiq+qeR7wbVlCBuyT31dqpLCt
         KycvKm6WvRq9Duav3PFyKgJA66hDUMHvetXLvR1KNrHFv7ghfdKZTYEq53Ckt+q8jXhO
         KrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTypzwwLcb7xKfsuPFEGFg2yii9gxBj0GXhwmgB4su0=;
        b=bJj2ugnHXPrVGtLTPyaLdI21YhqHYftQuYIVAEICpJjZpHelfp2rk0OEiNNy+pXn5I
         /pWcwW6odx+8i21gd1ysCgaOnSLhEhgf8r3bspSWD4KW/fgca+iVtu0cBgTzQFCUTnyv
         xacHgmtVlh95gP4GmqbI/90AyffFHRcYytOS7Umb19QPzuWRBDJ20PIwdjcMIRijdg14
         DARIYGUx0m8T7Gat5+FV8aQ1I5Hj8cLmN+R2e0JdIkJ2o4Wq9kNIgPLv9JA3MXTl3/14
         BwcI0bOXFPcFo1rPD67j90ytTVS2gpY09xZMwbKS0BSzSnJTQDsPwUUGe+WJ6MDTJWvR
         ua2g==
X-Gm-Message-State: ANoB5plbZCezefb1TqQY6UqJrLUkuVTbVQySM/CsX/bxsXjpDdhrCaiq
        HxaA2b6qStA38dIj3XmCwkgPCxS6nqfsyeLl+9GEaM7tq7j7RA==
X-Google-Smtp-Source: AA0mqf7AzqlRXjg+ex2UF00n0tor6iW1x8v+eLBnwunDei7JgxwhIzjDtbLr05uPcawGtH2f91Gki2HUrJNdYThtdQg=
X-Received: by 2002:a4a:aa4b:0:b0:49f:4837:1313 with SMTP id
 y11-20020a4aaa4b000000b0049f48371313mr2474615oom.95.1668282386282; Sat, 12
 Nov 2022 11:46:26 -0800 (PST)
MIME-Version: 1.0
From:   Gavin Ray <ray.gavin97@gmail.com>
Date:   Sat, 12 Nov 2022 14:46:16 -0500
Message-ID: <CAFtvWZN937H9D2mKTXevpH8SvrZ_pSNGmAwT5vOR3CZoCzipZQ@mail.gmail.com>
Subject: Applicability of BPF as a general-purpose programming
 language/runtime platform?
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all,

Apologies if questions/non-patch content aren't allowed on the mailing list,
I've not used the Linux kernel lists before so not certain of the
rules/etiquette.

I watched the talk from LPC, "The journey of BPF from restricted C language
towards extended and safe C" recently and many of the properties seemed
desirable. Particularly things like bounds-checking and verifiable locking.

Is it possible to use BPF as a general-purpose language for writing software?
If not, is it planned for the future? (Or maybe it's not technically possible)

Would be pretty neat, in my opinion.
Thanks and best regards,
--
Gavin

(P.S. Will I receive replies to this message?)
