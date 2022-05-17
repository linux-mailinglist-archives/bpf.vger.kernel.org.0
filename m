Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D72852A137
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 14:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345537AbiEQML5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 08:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345786AbiEQMLy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 08:11:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133B246B3A
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 05:11:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r23so8466441wrr.2
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 05:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=080TFCtc6/0lTaYEgOBCAhTPjDzKju3URFvGSSKVTYo=;
        b=HzVz5V9H3ZgAQxHq7pygWJtTHB5b2GEr5aXlNgYeUP9ov+6EwR6+uorsf5FasrQl1c
         C/Y4Te66b84EK7cbdH6VRYIBo4XJ2fFX5m3lV7fbvZ4ubKebWhHDmYA5JNYezJO1v0cO
         qrDhNG2EmIAGcpxPkkVst8voqr+aLMCDBO2lvF4bB4XhOBUA08AscJHX0hFeg+zoUg25
         I0Rkkvc6H7ZFG1o0zjF1Di2AaEFMeT94K1CIpPJTMMXifPEi8KQA+TecXZC6AhdAdSgo
         OTO+qLuxRLCT8wbJPVvivczsSDPudFaV2/f8TyFl1x5PfP9ec2NlVmgGq+AFuiIJG8pm
         cfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=080TFCtc6/0lTaYEgOBCAhTPjDzKju3URFvGSSKVTYo=;
        b=tff3cIj67yoLJYybi9vkF+hlyP6VT4934pZ74nrrKOjkpC/u/l+gBcjhFgg/oCpzMl
         a4fJMfcSMYRkWugnpgNGfSwWZpUaXMzOAEo+BJ0NPfgbGsW7UJ/W2pgZ5EQKaFc021nQ
         RXH48mcV3AQSdEjyJyI64+9ECWZ8SRZofCty8dUubE/6lCshXDRfiCB8rVxG6bCn120a
         RUIB9CfTYdxKSDOETMVwn/ivsewJpj4yAaHf1W0cG67JNeHWxdoGc3/IOAlg2ktZckth
         rZXlaMipGjgnCvU63veSlOPj8lkvlnvmBmy88vSOOEP8l5qCrfrZm5Ic/k1AtIkhABQ0
         u7pw==
X-Gm-Message-State: AOAM531dEurkXG6W2WILc3+Ne+2Y7BLpQYgVIYeLdXdbO5kKOyHLDJLN
        wDHvdYG+w67I+gA5QLCFyb4=
X-Google-Smtp-Source: ABdhPJzbCFP2bLphifC7snMLjARos4zE+LBezwDE3d8TuSdCQIyd0yqh8duoPzqbq4mHWKFT9k8Zcg==
X-Received: by 2002:adf:f8c9:0:b0:20d:11ae:d104 with SMTP id f9-20020adff8c9000000b0020d11aed104mr5141037wrq.89.1652789502745;
        Tue, 17 May 2022 05:11:42 -0700 (PDT)
Received: from [10.10.10.62] ([102.64.213.229])
        by smtp.gmail.com with ESMTPSA id a25-20020adfb519000000b0020c5253d90asm11790987wrd.86.2022.05.17.05.11.37
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 17 May 2022 05:11:42 -0700 (PDT)
Message-ID: <628390fe.1c69fb81.eaa69.756c@mx.google.com>
From:   David Cliff <kikouraphaela@gmail.com>
X-Google-Original-From: David Cliff
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hello
To:     Recipients <David@vger.kernel.org>
Date:   Tue, 17 May 2022 12:11:25 +0000
Reply-To: davidcliff396@gmail.com
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        TO_MALFORMED,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello dear. I have viewed your profile and I wish to say you are very beaut=
iful and charming, nice and gentle. I like you to know that this beauty I s=
ee in you is the heart of every man, I would like to know you better as I a=
m searching for a long lasting relationship. I will tell you more about mys=
elf when I get your reply, send me your email address, here is my email:  d=
avidcliff396@gmail.com  ,
I wait for your reply. Thanks
Gen David
