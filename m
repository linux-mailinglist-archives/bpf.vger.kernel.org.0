Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD445A03C6
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240875AbiHXWKh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240847AbiHXWKh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:10:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2C677548;
        Wed, 24 Aug 2022 15:10:36 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h24so22384194wrb.8;
        Wed, 24 Aug 2022 15:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=1S7hEgYwJdq28zms1wKavkqQ3o/4Fh91ZwrbI4pxEOE=;
        b=WN+Sr0LMUVqBPbaJobE2E4MmTVnv8ZKKAKwuafyNn1HPCSx8f+AvLD9L+Zrj5Xf25D
         IyEuO0cuEqqrcHYHryaJoqXvGr9hgbyen8d9db8LHR3dJ8yOznsgIWKVS5pneY/gX8aB
         hfR2UKA/QtsmQeYXxbqQ/FCmQqdXmA2X278ERmFfD6M5Q5KGbIFK7HAs4fxB6TwgmYo7
         dY6UsvHHa6qJMRFSy9K6oSup9X81PpPzPBPmWuGWLrKnAjsyPYpTTs9PRh1gsIYoNBmL
         F/OLuxg8/aEwuFzl73rnBuPP9dYNzLedjl2abR1LZxu8aMBXP8kzzb8DNnz1AtZvUlsZ
         kIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=1S7hEgYwJdq28zms1wKavkqQ3o/4Fh91ZwrbI4pxEOE=;
        b=huilOaxf4FZ1nn5j/DMMhQ+c1IV8Mzw+7e6ha2TIH4V3UCgNYBqDsl2lcURq7eZ8pV
         ltfJV4qZMT/RFAX4l5TRTwjD2DZe+pOGSPzjdNws2KMxbCeQbT3P3oWrrc2uw4u2fu1r
         LT9o1BiR4IkBgy59rGmx3l7Vdf+l1YpcprjJX3+JP9WOgEDUfwXsvnlFOlh374P94v0u
         nypN0i2lwuKlryHOAxdvZoNWCAnR/i1XfZffZso9egdjuevK/6RpzvtZZxxBGEK36vzI
         RXP2ybWPYdRAPsJhL07p3C5ICbj86Oc0az5m44xw+6ueged2kJ85+f9oMg0Gemtho6ll
         4IEA==
X-Gm-Message-State: ACgBeo1lcRn7vC3hT4gLwI0++ug9+HcBa7nTTBlhm4aj3tG5IH5gGNSV
        PSNGxEITZQeQIbTMiJRpKfOe9SHGU/WNeA==
X-Google-Smtp-Source: AA6agR6pFgsd7g2mqgdVvEHR0helPT3Alm/6RChWf37BmZOgpvLP74wqp88nDrbaDo0SDzQWEin3+A==
X-Received: by 2002:a05:6000:1364:b0:225:37d8:26e8 with SMTP id q4-20020a056000136400b0022537d826e8mr549002wrz.589.1661379034232;
        Wed, 24 Aug 2022 15:10:34 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b44b:882e:8988:f510])
        by smtp.gmail.com with ESMTPSA id j27-20020a05600c1c1b00b003a5ce167a68sm3399930wms.7.2022.08.24.15.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 15:10:33 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v2 0/2] Add table of BPF program types to docs
Date:   Wed, 24 Aug 2022 23:10:16 +0100
Message-Id: <20220824221018.24684-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend the libbpf documentation with a table of program types, attach
points and ELF section names. The table uses data from program_types.csv
which is generated from tools/lib/bpf/libbpf.c during the documentation
build.

Patch 1 adds subdir support to Documentation/Makefile and changes
userspace-api/media to use this instead of being a special case.

Patch 2 adds the the program_types documentation with a new makefile in
the libbpf doc directory to generate program_types.csv

I plan to look at adding info about format of section "extras" as a
follow-on.

v1 -> v2:
Automate the generation of program_types.csv as suggested by
Andrii Nakryiko.


Donald Hunter (2):
  Add subdir support to Documentation makefile
  Add table of BPF program types to libbpf docs

 Documentation/Makefile                     | 16 ++++++++--
 Documentation/bpf/libbpf/Makefile          | 36 ++++++++++++++++++++++
 Documentation/bpf/libbpf/index.rst         |  3 ++
 Documentation/bpf/libbpf/program_types.rst | 18 +++++++++++
 Documentation/bpf/programs.rst             |  3 ++
 Documentation/userspace-api/media/Makefile |  2 ++
 6 files changed, 76 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/bpf/libbpf/Makefile
 create mode 100644 Documentation/bpf/libbpf/program_types.rst

-- 
2.35.1

