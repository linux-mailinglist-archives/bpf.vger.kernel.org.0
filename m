Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C848564A78
	for <lists+bpf@lfdr.de>; Mon,  4 Jul 2022 01:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiGCXMt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Jul 2022 19:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiGCXMs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Jul 2022 19:12:48 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE3E2AE7
        for <bpf@vger.kernel.org>; Sun,  3 Jul 2022 16:12:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id mf9so13922895ejb.0
        for <bpf@vger.kernel.org>; Sun, 03 Jul 2022 16:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=UrhyWhD0uCav5bV2Vy1FYLvcu6loom7O6yHzuhdEFBA=;
        b=X8ZxDubSy77pmu7xTu+e/l1GVJHAeolxnVcQfZoZF1fHP/EwC3Sjx5H8MwT/b2W+dO
         7I0Vwso8h+D9mh14gotSSBljxE4Ty8NwoTtHTEzSQ+hCm2GGTQ/fkYxVBPrWGvQvwTzQ
         RftlSD3ae4Dn5SUfiKVeJQZXb+o+EhQENn7Zc1SEiwZ86osZJUo51pMoczJm9lkCzKEo
         /Oaic7halKeDt2SAdYndOXE3ZkxDGjKGaGZwrwCrSLkHt2c1plOuGoaF+ae4J+sNdwBV
         UKAwqaGCnl3HsJ8RrR5BNHp2+NXHbkECDpC5XZUSbHv6nVmwzuJGFYGRCM+HQsgDpdYI
         gRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UrhyWhD0uCav5bV2Vy1FYLvcu6loom7O6yHzuhdEFBA=;
        b=VTyKDoumiO6TLlyvSsOVuzYSn/ug6whbJjzXMgosg9Yt7DrR/oDnPl6vKg+IDVMYGn
         lZMGHD4K03JqZ6TALVygaAOHWoLghNT2YDBzj2nyoH5Vp2/f+wKG3JaYy++z9M/+jGjR
         KyiHzLzm3LYAbxD492OdTZ5cBMZxyVrTlFtDK1JT4AZryXpcOqMF3ogjPHGx9MyOjlQG
         ahKrWbeMUhtfskpsEVpfFFl79Gl/JZWoyGmVyyjrqrz9sUolZklyonMoEujPetRNHVd+
         4pVfqawdImAy1cxbAqbI2ZgeYHpukZCBpf1vNcbnVLqNAhSH8IR/SdTfgiqKA+qYdPET
         Pjaw==
X-Gm-Message-State: AJIora/6qhvfUMEAlOok1bF+Wm2O6/eLiwuOObIjY4qBy8C2ChvFlmn8
        h9N9RVrje2742c2WIQ0Gn8Bo6gCcYlbOuVBHSW8=
X-Google-Smtp-Source: AGRyM1tLq2joo7uy/qmVWidfa7rBTM4P/8gci9txaKL2RMD5x7BHswDGOKHZBOOeNXr9RQwLLgsYbaZHwKc6Rb3Ef/U=
X-Received: by 2002:a17:906:2654:b0:722:fd1b:d5fb with SMTP id
 i20-20020a170906265400b00722fd1bd5fbmr26159497ejc.59.1656889965788; Sun, 03
 Jul 2022 16:12:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:9611:b0:726:d6c8:9883 with HTTP; Sun, 3 Jul 2022
 16:12:45 -0700 (PDT)
From:   "Mr.Terry Adam" <mrterrya394@gmail.com>
Date:   Sun, 3 Jul 2022 16:12:45 -0700
Message-ID: <CADLGsBhEWa6TvjU=z93Dg-D6Bv6fk7fkGrprqhRxvpxuk-uqwQ@mail.gmail.com>
Subject: Mr. Terry Adam,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

How are you today. I hope you're well. I haven't heard from you in
regards to our last conversation. Please reply back to me is very
important.

 Regards,
 Mr. Terry Adam,
