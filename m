Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD4262FBFD
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 18:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbiKRRtC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 12:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235435AbiKRRtA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 12:49:00 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08C2391E4
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 09:48:58 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id d6so9359120lfs.10
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 09:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLuxvrtTwLpjQCdZkBOlAPtT4PuOt7o3XUb4SWGRYeY=;
        b=VDSMFl8A4XNQMyndIxf/Eg1RH6+wkl1QUxMIJsx6HicT42tQSs0uXr9wQ8wt1cxKsS
         JgfszhqzJ6lOqZKA3BQcJUfWchjros44FzFQdmZv7MjusT5LLi2NDP/JAYXDWgoMit1n
         gKAi4y9TMdK7ailbEepGd1LLh1StLEHYP+E+2PWijTADgbjajHIPVk3o+P45fM9lTZ+2
         X3zVTVs5lXIKJyLXvTlugYpUHpOTbgVG/4Z9tK7AkqFCvgij793D12hI6Qvt9TVT66P8
         ZEM9mGmeUXraNYZDK6qYP5Iix/KmQP1Z/Y76pFNd0FOJKdqxi8MjEgcq9itKBlAjtu2n
         E6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLuxvrtTwLpjQCdZkBOlAPtT4PuOt7o3XUb4SWGRYeY=;
        b=cNbNxSb9kI9Q2OqMFRmc/YMXpwo2zAOahg4X/RjYyb1jXWq2+KfcrRCyk4LTdbIKRP
         aBMUnMEZ++zW2WqEzv/tvE9btQb1LAZTixmMikdq+B2oi0bQABQvhaVJhJhR/HsN9vRn
         8h3503+DYu1mXTibtIswYQStJam3t+aJBK0xtxPrmFF4rjaB3KsAfkQKVykBwZpbQo5C
         zeBG0Z1pwAXk/A7jnwGM2Cy5JcgtJP+/x2tG2dq1jJPTgtDB4blo0dBM3LCiIRN/CuyQ
         z1ipYTikJi7UgtRRR49koWfQXOxWHUUAWRNqM37r+vZIaeaNVxqFd1cz7tjhdV0VHJB3
         zqYg==
X-Gm-Message-State: ANoB5pkp1fUvN8iLI7wBcsUiBLLzvNZURGMUb5jgGic8mtUnzmLtPf8v
        bcOHQIex1c8OF/y6L7CjtUB9xSSBaPiUfn+OLQE=
X-Google-Smtp-Source: AA0mqf5cVIUXuWkowg8fB32rVuPd2S9j+CHn0LqMTJ+vNFuB9m7s6Pc9KTevlUD4dQQB3qBsijO/x2ozzlSQrBuSGWQ=
X-Received: by 2002:a05:6512:3da3:b0:4aa:f992:28aa with SMTP id
 k35-20020a0565123da300b004aaf99228aamr3033558lfv.459.1668793737124; Fri, 18
 Nov 2022 09:48:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:651c:4cc:0:0:0:0 with HTTP; Fri, 18 Nov 2022 09:48:56
 -0800 (PST)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <arounayawo@gmail.com>
Date:   Fri, 18 Nov 2022 17:48:56 +0000
Message-ID: <CALU0pJe0Ciho87NaWuoinNRWkGeD-42KYNb1oK4HJJYGGMp0tQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Dear Friend,

I have an important message for you.

Sincerely,

Mr thaj xoa
Deputy Financial State Securities Commission (SSC)
Hanoi-Vietnam
