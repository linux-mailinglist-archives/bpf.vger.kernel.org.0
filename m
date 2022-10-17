Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30ABB600D8E
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 13:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJQLQT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 07:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiJQLQQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 07:16:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70AB5F7E8
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 04:16:15 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u10so17958582wrq.2
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 04:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h6TAvh2KhlPwZbZl975on9cPhNtC4Qh0FGtOTBu2EFs=;
        b=gef9b3AUbM1jxHBI3J2IgkZLbPMxgVy7XmwCxNmb2IBJBxWu3hZAyt+3MjPgPB+Wx2
         PdrI80xY3gMdc9slDOov4IoH+Sp9T1OR4WcOE9KNy+OCHcxolCAQY4HgTFlzmjSH08DF
         fEc9oO3JaVO60ni+KxewqI14/TVKiPydmQBsCpS+ZUqZgyjMxYSd7dxDfgqaW3HBiETZ
         ejKOOQ/KOkyT35oD5TqOJQYytQwNIrbfsKzqaF8rIMtamb5Q6pf6S0QdyF3uuPimHh0a
         PKCvokqGIe31BFghP//nOuFdyZQ9xuPhTYYtyDJwiI70b5Kjj0pkAOG1VnfdrZ9kKL1w
         4O9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h6TAvh2KhlPwZbZl975on9cPhNtC4Qh0FGtOTBu2EFs=;
        b=giqQX49y5JI4u1Uoekx1yrkyWofPI4urSsbT27gLXhoQqCNER/QOqQtSnZkOtcUeTo
         5QiSutxj+1bkxi+b03QjdM2B9WqfQ9FRHhZtP24kk0YaXx6V6GXB2sO44qeePittZiWY
         C0X9tj10QL6MfIYooFItNI1tyJxTnXk2Fu3zUowCe0bilM5GXWhahiAH13UCwjF+smiH
         ixe73bGKf+IHPtW3DveG7ZS6PL3lYbYKedR7HcyWyQmX7eX5+PPjQ++vv6ndeSvgt83x
         +xdnl0izdHAqLYu2rpioGAc/QueqWomd/H2kmxVDrskeKuyyYbUFYRPnycBVUngviknS
         M61A==
X-Gm-Message-State: ACrzQf0Y0eLE3IBlWEyjFkBLEUT3xBAAa/YWtUuozVsyzsLqkgsNFI7/
        WR2utG/g39YJpf/XQMwmNhKRncBfnbDlhZGKzgxN2yjR0oZcPg==
X-Google-Smtp-Source: AMsMyM7W22dR4R/9ZWFE7rFWHbFW/An8xEhuCN+rCfC642k1ysd1JquoABPWibAhNv6v8cuJU8/FjiFR5g7MjikMiG4=
X-Received: by 2002:a17:906:65c6:b0:73c:8897:65b0 with SMTP id
 z6-20020a17090665c600b0073c889765b0mr8311585ejn.322.1666005363403; Mon, 17
 Oct 2022 04:16:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:71a:0:b0:1df:c5cd:1b43 with HTTP; Mon, 17 Oct 2022
 04:16:02 -0700 (PDT)
From:   M Cheickna Toure <metraoretk5@gmail.com>
Date:   Mon, 17 Oct 2022 12:16:02 +0100
Message-ID: <CACw7F=bjFM_a7nU=sYTn61huSMhQ+==ovsGxuT_=o-NmGEakwQ@mail.gmail.com>
Subject: Hello, Good morning
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,
Good morning and how are you?
I have an important and favourable information/proposal which might
interest you to know,
let me hear from you to detail you, it's important
Sincerely,
M.Cheickna
tourecheickna@consultant.com
