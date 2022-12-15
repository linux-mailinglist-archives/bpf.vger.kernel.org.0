Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394F364DC3F
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 14:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiLON22 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 08:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLON21 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 08:28:27 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8CC1A807
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 05:28:26 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qk9so52280473ejc.3
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 05:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=UtkMJ1Ok5ijxhISOFz7DNUabG9pRMf7qpSEWxVAggF5NENZrhATS7iCOypM3Ldzz4d
         hCbh1eJY3CdRdo6OnIuEMmNPcLvRtxBH6ZNjWKNzk1sToTS4X6xN8Z21T0Uu2mfeZzQv
         H4uufN1cgq4Yp9acifYXBpOSebDY1RN+ZmDlMWFvIV8t0dalXsE+A4CBigCorxtIsg6V
         +Uw/GjpvCE5LAqHWihjkPg+iCUdiiH+9Go9zhb7QuaPdmXdAOUZDCjdi8HP0kpkrhbH3
         2yv97GiBnnVBIacxHHJvXbhz8bVwrFJbJdBBi+jAICREqqWBSyqx5yiJOgnI0bsPzoZK
         8mhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=c4os98mQd/7sWMJb6n8YtDz4muvzmvCBKnrnYNVY6KXqk25iHPRRLbWF7IxDoA9m43
         WlqNtcLkDlVGazaubkoJEvqsJMIIt6O8E0dARb1Pg5q+hwamPxZPkpz1oYvynCk1F6B7
         B45awnFtrhmDIrXe/C12F0Iwrakqre7SyW552WI5Ora+O+4wl1UTghSCfT5e6+SSpxhs
         AJIY9OpYa+eO2wv1otwLE8R5GvEQ/57zK+4KIwkV1wtalQ4u/y6n/ZL26fmMZc2tmgWy
         e64aTMiyMtfmeHGUb/ofnV7T+M1+Os1C9rBkJfWNs/6c61qB4g6WDSPfppSiPH97vfsp
         bksQ==
X-Gm-Message-State: ANoB5pnJ4xAvNKrPKe6NtsR2PGnUtbeT/wpH/K0oKU74wRctQsJwBiVm
        dUBEyj/zvIrtQP8K6DWw0LmX/ih/WizX+qzvUAE=
X-Google-Smtp-Source: AA0mqf5Bc1fuURMHSeddM7urCHhvW0PjUq/47dIPRwnWalvuQ87uXeWer8RB+Etd4nlwZSJl/zMz7OQgmNsIdiZZfFU=
X-Received: by 2002:a17:906:6d88:b0:7ad:b86b:3ff with SMTP id
 h8-20020a1709066d8800b007adb86b03ffmr87226571ejt.448.1671110905274; Thu, 15
 Dec 2022 05:28:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:3fd1:b0:7c0:b6b2:c759 with HTTP; Thu, 15 Dec 2022
 05:28:24 -0800 (PST)
Reply-To: subik7633@gmail.com
From:   Susan Bikram <timh79161@gmail.com>
Date:   Thu, 15 Dec 2022 05:28:24 -0800
Message-ID: <CAAfykGWOnEPZsGakjsCdi0o+RFvOwLc+SrCRvAYCEzKFv3JwqQ@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dear ,

Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Susan
