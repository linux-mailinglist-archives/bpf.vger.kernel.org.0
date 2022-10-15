Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974AD5FFB32
	for <lists+bpf@lfdr.de>; Sat, 15 Oct 2022 18:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJOQYZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Oct 2022 12:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJOQYY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Oct 2022 12:24:24 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EB9267C
        for <bpf@vger.kernel.org>; Sat, 15 Oct 2022 09:24:23 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a13so10682441edj.0
        for <bpf@vger.kernel.org>; Sat, 15 Oct 2022 09:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6c6RloR1f1meVJL/BrGR4Y0ez6uzlYlKHhaiRNYhs0=;
        b=cDbZSRrX1oarLKbAZH39BmN+e4n7H2hlpqa9Casu26tpoAI8oM1DaVD3LVkuI2lgBM
         HHTuHYmKnNKHov4UU2i0z6V+M0dAO9pzkKmJX0PjTAbRq/B3UfazeCbrdXxUejXLmUCi
         Nd769RNu+w6yocjfxXZ+/ztM2g/rPqGm0u0Ndgh1mF2YjbBW5yWkmU7cWslqlSHIfMmk
         koU5F7dEC+UdU93M4DZq2oj9AuVbSfu4UI1S786Cnu4N3J8Sm/elshmCnvLao5mH+8AX
         WLRQ33rs38xl5ZKlkQG3/50ufV42+D3tOtYcqo2hOpgl56TvIoqwVdFhPUyzc0+wON4y
         iTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6c6RloR1f1meVJL/BrGR4Y0ez6uzlYlKHhaiRNYhs0=;
        b=HPVBS3uGJ7oRMmNod67u9/e4NigWb3u4SbsVfHPBQBfRDjyZZjFEBszfNqdZZOWauK
         HzufgueaekLfJG7abOBpeZYdtB77/bA8IkaTrq0xckk1D8lk1Jn+17uWvsTcMJXlE8b/
         dQj+HHvtlO9BrFwKizsGIG7adBK9G6dq8C2muo0Z2/bCfSvx9Xgjg7uTb6jo94cW91vV
         +U2rIbYoREOgkIwXs5VC6TD8Sj2BfDTuEfES4brzsB9er8ViwH96U8MZshTbLcDIEEdQ
         6/yh3D5p241OVfp6pjxf+e3KPNohwWU1zu5ZJeRTrVGGCYhYpCQaHdaC2UN9jQrP3d8g
         EgGg==
X-Gm-Message-State: ACrzQf11zQckPWbyfFxNohAxpw+W6p+GRQ0enjrQ9eXm8GVz3OVdR2xu
        btFM1MJkvidLETfYE/BSc5jAF+bQMCwCZyBPpP8=
X-Google-Smtp-Source: AMsMyM4BneQ5+d4KAixn+OXWyjHcpjPgImwegN85qPg0CuwG62dyKlqcPx6ieiD8GZzFEses+Tan1/vHODCZFcZN6wA=
X-Received: by 2002:a50:fe85:0:b0:458:5562:bf1e with SMTP id
 d5-20020a50fe85000000b004585562bf1emr2818703edt.167.1665851061761; Sat, 15
 Oct 2022 09:24:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:c0b:b0:780:f627:3403 with HTTP; Sat, 15 Oct 2022
 09:24:21 -0700 (PDT)
Reply-To: mmrstephen16@gmail.com
From:   "Mr. Stephen Melvin" <xmlpsw@gmail.com>
Date:   Sat, 15 Oct 2022 09:24:21 -0700
Message-ID: <CAEZXVO8miNcgw2Sgyj7dUc1BZ5c_-Eb_1B-F4Zqr6iqorX_M7g@mail.gmail.com>
Subject: Reply and let me know if you received this email.!!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
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
