Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C2E64747B
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 17:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiLHQka (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 11:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiLHQk3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 11:40:29 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA3359875
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 08:40:28 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id t17so5409327eju.1
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 08:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTJqkUg9tlm7AjuIGKJEdFJCYFhutqhsxr7B4Xa06U4=;
        b=EK5KNStyVskPlMbjlqHQEi64rRS9xt8abCe94lTp++acW+uaORe+FjJVS0hS+rn/5i
         IB0hcvHAHuFl3yxP168LIlFBNtzMh1zQ0KSCibwyPoQr8dUAb0U+gjl3F5FZITK2EJQP
         YZ4PNQ364lJKjBIs63+S5xAyuLhsExEZK16trdCgRy3LYoVoBAFzw1Wi42ZmbFRm+8kU
         dd9TXYIvOMFVbzwGw97MeSpG9qXQbSkfUYopF59JdPacKIxaBB4rm1g9TgFJtqI2dO+u
         5QyepHC64wGY/amGNRcZmMx+myIwTY8Rp4IY29AB4MhEXaX7so4R/vySSGaa0bOPjoc2
         kqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTJqkUg9tlm7AjuIGKJEdFJCYFhutqhsxr7B4Xa06U4=;
        b=hBM0OLM16r6ELxrri2sP7a+AVToky2jnTZRHvB+QUuzSHB40Kwmp4q7yQ9w/FpSgTL
         dDZmRk4m+cdJ4WFXs8p0vaM2K/6rAnAoFRBKsSa++O113qLRIHnPz2OBnPlehw+F3ND0
         k8ItKRcpKK80pqGhApcJhYteXGGUkbLq93yToY0kK8iRBaEnxCJUDRUgHDwxSC56o6Ec
         T++8L5UwJj3kX+XpJaZfWpPWSMFOvLslqeN6Sn6EaEhgAWHzoaLkH/hq7iNEgnxsWl+F
         KehboCaAWVCAEh1iTLwy72LfLZ7Dk4hx3SY6m7Onwur/rPk/740kZwtShfNCbiIibi25
         zsog==
X-Gm-Message-State: ANoB5pknfQ8czMabiLTsDhw2cst6Q17/OK97xGPHVNvzQw2lxaoosXq3
        CtQAaO304M9ocg1XWgknilM8qzD2CdGa/Q+N/co=
X-Google-Smtp-Source: AA0mqf7a6DTV/G+EnzTDcrTM4crBBK9iqjh1y/3P9GTzjxypyIOe5Lr9iXR7NtOBZmO574hYPUd9RZH55wdrii1jwv4=
X-Received: by 2002:a17:906:774e:b0:782:55de:4fcf with SMTP id
 o14-20020a170906774e00b0078255de4fcfmr79283464ejn.85.1670517626559; Thu, 08
 Dec 2022 08:40:26 -0800 (PST)
MIME-Version: 1.0
Sender: samiratou7105@gmail.com
Received: by 2002:a05:7208:8330:b0:5c:e834:9e68 with HTTP; Thu, 8 Dec 2022
 08:40:25 -0800 (PST)
From:   H mimi m <mimih6474@gmail.com>
Date:   Thu, 8 Dec 2022 16:40:25 +0000
X-Google-Sender-Auth: oDqxIXDJnusgLtbhvDwdiOYppx8
Message-ID: <CAH+LWNOGixNd=T=mu-LYx5DbUnCP8N+AfZfD51Sx=pxiz+rasg@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If you are interested to use the sum US$13.500,000.00 to help the
orphans around the world and invest it in your country, kindly get
back to me for more information On how you can contact the company and
tell them to deliver the consignment box to your care on behalf of me,
Warm
Regards,
Mrs Mimi Hassan Abdul Mohammad
