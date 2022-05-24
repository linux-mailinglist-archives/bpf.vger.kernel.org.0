Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDDC532B63
	for <lists+bpf@lfdr.de>; Tue, 24 May 2022 15:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbiEXNgg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 May 2022 09:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237886AbiEXNge (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 May 2022 09:36:34 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD8B78930
        for <bpf@vger.kernel.org>; Tue, 24 May 2022 06:36:29 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e2so14140296wrc.1
        for <bpf@vger.kernel.org>; Tue, 24 May 2022 06:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=P8kko6n9YLybNZcqfobKtwCXCSV8aasojc6/WwGHAog=;
        b=JEe+R57XIghRcsWvYwSzw7XHFpnnE67p301d7aLar+y8a2eu5n8Zuc2/CmufOk1JLT
         pSDdR4zAUyAQ1xQJTwvnO7ev9BPxgfWtLp0R7chNClDrIT5I/s4RfyNP1G4vzG72rI6A
         9sBn4zaW4boHQVJC71JU+TKnLIx78uOSatzhsJKlDjYo7gVZG9lAal+UPwEVpLHHyFSM
         i7Q9AnpzJ1CWYBTVzgr5VrqosByqrUs317Y0GVlDk2Fr5pYrXF87mf5opkNJ0+F8KT9q
         x+aIywj9ItprCZVyH6s15nWRUDVhSStDXDlhXuqSkGsCjdMGEBws5rUwrJfl/1TZo1yv
         Mv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=P8kko6n9YLybNZcqfobKtwCXCSV8aasojc6/WwGHAog=;
        b=bfOVQb41EzY0xVsZ130If9G4mYcSNYq9HPWtAqWHN/ugEAIk2U0MDvnAve1GlpZ6T+
         i4cOeENgXDGC4dhZqE5w1iy+VGQgME8el1kxU1yx7DenaLZGY+TwgLXEEZP0kuW0tHDN
         UCeJZQp4RehxG3IZY0fCsZppTvmgk9EdaY2k2sKCJ+IFTNWa2dXlusBra4HXLpMZkdEp
         FrS1qu4b+0YR/x7/Gd301l87bVZvux4bqje/LwGkvvlHcUMylLRRFJ6tyugTBBIP7fLw
         KOCKghQGFjDEDEWydfCo34BLC07BxmweiClE/uaBOZphR1uHyiASJ8vCU8PRjIZF2NUB
         AyIA==
X-Gm-Message-State: AOAM530FuTgAld5bKX404bUg+NdDAid7jMXeKIape24srKnEso3lTasn
        trl2zN2FRSCeV42ytj8LjQF3wMGfo8l3NHMi
X-Google-Smtp-Source: ABdhPJy3HcZG/LmN/574hAA3htrDUFwQsdM2h2N/XnIMLMbH4STy/5dOaOhrHjROqpGBGrVjMsaN4w==
X-Received: by 2002:a5d:540a:0:b0:20e:69db:4dc5 with SMTP id g10-20020a5d540a000000b0020e69db4dc5mr21576805wrv.337.1653399388516;
        Tue, 24 May 2022 06:36:28 -0700 (PDT)
Received: from [10.10.10.81] ([156.38.87.43])
        by smtp.gmail.com with ESMTPSA id n1-20020a7bc5c1000000b003976525c38bsm388112wmk.3.2022.05.24.06.36.25
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 24 May 2022 06:36:28 -0700 (PDT)
Message-ID: <628cdf5c.1c69fb81.56397.2011@mx.google.com>
From:   David Cliff <essohamlokou764@gmail.com>
X-Google-Original-From: David Cliff
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hello
To:     Recipients <David@vger.kernel.org>
Date:   Tue, 24 May 2022 13:36:19 +0000
Reply-To: davidcliff396@gmail.com
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TO_MALFORMED,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello dear. i have view your profile and i wish to say your very beautiful =
and charming, nice and gentle. I like you to know that this beauty i see in=
 you is the heart of every man, i would like to know you better as i am sea=
rching for a long lasting relationship. I will tell you more about myself w=
hen i get your reply, send me your email address, here is my email: davidcl=
iff396@gmail.com,
I wait for your reply. Thanks
David
