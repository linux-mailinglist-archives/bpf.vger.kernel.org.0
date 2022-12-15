Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836C664DC46
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 14:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiLON3p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 08:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLON3o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 08:29:44 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF57D1A3B4
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 05:29:41 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id m5so729629uah.3
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 05:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=ZHGAaN9uIdSqxjsfF1/+XzBxsVeceIdAAzipEPf0B94wQIdE3O1qzCPoDnVMVMDcIG
         FOK8BUAY5dIm+ipqjffxEJ45nhIsuGORKxsZXeOytxpoxfHF8cWYQON5rM6voHO3oIjF
         harZFoYltJaAPVpHfXt2+AQ7i7cVQ2yPzI/ugwHedDPB652s3/7evwFZ/k373IU4qhPf
         LYRGqClPKC2/4Wh4+RMF1le0qMzxLLLSPdiXXLBbiI9GZixQoJAbeoemqijRuptKJNAJ
         qme7jxUEQpUPzmkwVM8RHihDU+iN704SFfjNVIZhClw+oHZsq6kwIdsoKx3m3qbxzxvo
         P7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=Knyz6xbrcnlinT9g5+RdiKVqhcx65UtUpfCjMqIVT3hmRfX9J+IUidVpou24uxCY23
         9dW40ohAniPQOSHHJ9nRsb4ikwRE8JxgSz540X9qMLOrHWUbn2fequtU8nNZ0yLoCbPa
         SDZpqMy1UoYbHlMGOyW/x/Owy3vNu3mJdCbPt0kIrAYNHOyT5NEGKKhAD9ZJ8A1I+yQD
         2c7cyD3Q9n1B6wV4zAR8arb5jrPoBdD0pSANwzmcFtYiV3dYRXeVvpUkaCtqAdMKqKXC
         DLjTgiltelHaGnvwDv5irftd5oeubuaED6OxLNRnTLX7RVbrf2AyvH0b2DC4GwZxIavM
         Rj0w==
X-Gm-Message-State: ANoB5pkALjS9uwLmekydrE5PSEHrU4NQkoiDo2EfXzu2qR4Nqb88UeXz
        X4A22XaA9yr4d0WQRZM9Sr3lRduXhA3xMFnNeLU=
X-Google-Smtp-Source: AA0mqf4s+NZYt/nEMgfDwtvQpEA7YYTlDS7t4FgiWlColSSzg4KYbUQAtgx0FyKR/e2uOHkBJGZqEKFba4X6whk18IE=
X-Received: by 2002:ab0:602a:0:b0:425:d41a:a2a2 with SMTP id
 n10-20020ab0602a000000b00425d41aa2a2mr2511384ual.10.1671110980858; Thu, 15
 Dec 2022 05:29:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:a40b:0:b0:355:1a00:10b2 with HTTP; Thu, 15 Dec 2022
 05:29:40 -0800 (PST)
Reply-To: subik7633@gmail.com
From:   Susan Bikram <igoniemerges021@gmail.com>
Date:   Thu, 15 Dec 2022 05:29:40 -0800
Message-ID: <CAPdPzj2yFDJ6Ur=L4ZEGHT0BCVhKJ2+byMi+YCgNUX+tomefEg@mail.gmail.com>
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
