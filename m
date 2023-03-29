Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04CE6CF23F
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 20:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjC2SiB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 14:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjC2Shy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 14:37:54 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D33D5B81
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 11:37:48 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t14so17174433ljd.5
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680115066; x=1682707066;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=RJSeC/2y2qkppfBW09GE8UOxZSPzbdYIny2ryywCTuK4vX4TBxGzGOvOeZu10KNpkj
         JabgDGbFBeBqEAamsSaiutBPfFH/ukcQ5gcmVsl+qzCoo3IX2+mz55K40mQSfDmROl3q
         ft392EItvlBGPsHYqiqCnxBv90UjNgwURx/ytndNU1K5pFZM3uTtG1bGcwWtJ/P1fp9Z
         WFb5Y65jIaFq+GIBo3p1dF8zbYmlg1I4d9xeC7cXn742Iat8m0VA9nZa5GzfLiSvN0Jb
         U+d/4OLfJpF/fDe/lLS5ISLIgzT4rJN1ImZqHw6BRSK9T/mpv0k5G5lpA3rH0tLmzIFy
         gjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115066; x=1682707066;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=AI70VC6GKJLJYJ1nnGNlNyn9pAxo/pvrZmqCaqj/WCicM/rywx4vfmjTeCLtUyJRUU
         zOpih29ld20/+qrnh6twEqBo4/pLvkj3lIjeXtSd2IrCpRsHh6VoHpdOzeoY5xbQQonz
         UxmG5QTUW7fFYNAwjrAhUWskcjefVvAReXrZZUOjH5S0HYzuKahbF/O8eJ+hSKy8ihJe
         ncwPcQHRoC+N2NQPBG3//QwmWcf/B8jDBGwVyCQm5yNO0YZQLqN+6nSWf0CgKrr0pl9R
         TegOYEK6e6a6AiYpkkaiPkxBp2qEY7lWXpgJKZtiKRR5pc0JuCMNXamRFAnnfMRQzAjM
         S9hQ==
X-Gm-Message-State: AAQBX9c69wpa6i76pRMmy8lVURLTYj32XIf4fiiBTDIRx7nskt4tkVjx
        Tsy3Bn/uk8GmvbEeaqVvV3lGEJZRZKw0AXUNgB0=
X-Google-Smtp-Source: AKy350aupUB33hSF1wGQo1yMdmnTKaXmF5STPKqaLqGSpa6+EcFuhwJpCQecC9rJXxEnefN4Wq6QbxB+8OhC8d7v5tM=
X-Received: by 2002:a2e:9c19:0:b0:2a2:ab76:c367 with SMTP id
 s25-20020a2e9c19000000b002a2ab76c367mr6152394lji.6.1680115066026; Wed, 29 Mar
 2023 11:37:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:4a4:b0:23d:475c:cd6c with HTTP; Wed, 29 Mar 2023
 11:37:45 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <teewe45@gmail.com>
Date:   Wed, 29 Mar 2023 11:37:45 -0700
Message-ID: <CAEPmxYdnC+k0Mub8KdbvnhUq_4W3EdqyyM3Sa0Ge6qFNiysSng@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
