Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDCE5BEFD4
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 00:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiITWMC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 18:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiITWL7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 18:11:59 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EE677EBD
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 15:11:58 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id o123so4750801vsc.3
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 15:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=9oUhhe9WhBbu4JoH4Pz+I0OHBn3Qr9dI0a7PR0a2whk=;
        b=qT2eAD6cJna02c8BqQU8Zb5eJiK9F1oAksLNVo4gGEK5Ii+K07LIehykaKgS8L/c1a
         FDVc1hzMon8o2pa5vB5eabbY71h4bzu4U7iCK6X5elvAhpU4RcGajjGmq2zSIDOkf817
         Hocn8zezemTIz6uEgbEaIY82AJl4Ten9eMQsQxe7FlG1I+gRQZyTa1C0SXcQX3Xio6/D
         em7v+OwRiKgrqiQSk1ifMdvcHBdIU2tp621hZJku5KlEOljvFQ1aZ7WM5V+MToByDxGl
         2UBP+6YIYQARp0VOPBBh2PuyZ4d/oYqgguxrh/j+aEiIs6ymOE+EdwWvWlDyUf70VtMV
         LNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9oUhhe9WhBbu4JoH4Pz+I0OHBn3Qr9dI0a7PR0a2whk=;
        b=uYAVpCcnPnLlTcMA3J9+GVxrUH5LcaM0XPAUyht+fB3XxzH4/qziTST61K8kNIS/O0
         8QUYcsXOqpPuV1WaELCCIBoA0IwZdqW7PyuzOaUVI/WFB8blUKqm6EBqi/g6E6voAkmi
         VbYSYlGSkRwq+wpwCyTC8Q8VibbOVhuE6La9FsH16qLIacPYENZIzsLDbhZgne2iIHSk
         JtRZcm+nTeD1NdrUxKSPQDHkorhc0KgogPfCQH9UFmcJCF0uwzMLsS2SGI6bSQzghTGw
         AfmHBOLajGOPQN7j0zpEVTIPHMf4hQc+brv4G9UOgrXtv5ZcEgJRk+YGWJFgpgMaMoOJ
         3x8w==
X-Gm-Message-State: ACrzQf0/6oBwIL3WZ8eT+PcDLNbOoZ0N9wkrGKE9SLAdOFUadhwoQOE/
        E+1nIwACNkPeNHON+JRPC4H9lztfJyqnhRA1P00=
X-Google-Smtp-Source: AMsMyM599Uq3bI0xBsdWRJgppL7H/lMNaS0BfpHx8VQLgYYyGfLsPJZKCqjkNuRuFhB58W8DiUKTa3D5luEiTYhuuP4=
X-Received: by 2002:a67:e04d:0:b0:397:f787:7880 with SMTP id
 n13-20020a67e04d000000b00397f7877880mr10064880vsl.71.1663711917240; Tue, 20
 Sep 2022 15:11:57 -0700 (PDT)
MIME-Version: 1.0
Sender: badagbocamillo@gmail.com
Received: by 2002:a05:6102:222c:0:0:0:0 with HTTP; Tue, 20 Sep 2022 15:11:56
 -0700 (PDT)
From:   Miss Reacheal <reacheal4u@gmail.com>
Date:   Tue, 20 Sep 2022 22:11:56 +0000
X-Google-Sender-Auth: vapQWgF2xzxXbIW8n0z_WZQwe3s
Message-ID: <CAEU_3uB9w65u8iw6HMa8agYSyCknJEMMywR8jZ39qRTZcVHePw@mail.gmail.com>
Subject: RE:HELLO DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

You received my previous message? I contacted you before but the
message failed back, so i decided to write again. Please confirm if
you receive this so that i can proceed,

waiting  for your response.

Regards,
Miss Reacheal
