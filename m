Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFE75E61BD
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 13:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiIVLxO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 07:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiIVLxN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 07:53:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999B2979F4;
        Thu, 22 Sep 2022 04:53:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t7so15070785wrm.10;
        Thu, 22 Sep 2022 04:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=+EO80SPRWg5tCr6JwsANQXApnPAi2pPn2xvc+2uILU0=;
        b=jtl0JHE111TNmC2pKToSLZuFxKaqh6m3rfTwt7rv1EFXUdBkXyBHSiG8jf9zGzDyBB
         uF2xLoaQDmOL+cmuGkx3sFUoP8R9SmnsGMYov9hPQ004A1glWPzeZ31jy/Xn1tOvI6td
         SaN3GtnFRIe9ks1U78CDG7WkV/wlhM0UDflh7y4Ec7DXKewSH1qFbOaA1EZWtOh5qrAi
         sCl4j3GsGjNOQ8A2j85JDBLfzeVylmAyC084yU8FYXaUrbOlfXjRs1xPZdqeWCX8hlBy
         CzLCgDG5GHpNYJXuUyWozay6ygPIjhniZ3jGIrbAIDhdM+eV2Ej0q4vnzu1vZV2RMwfx
         QEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=+EO80SPRWg5tCr6JwsANQXApnPAi2pPn2xvc+2uILU0=;
        b=o5Yt2WKCH2i9PEO2z0gBQP8iEtGuYjgGX67SxExsFqwjwI3WVPfqOVMt1lGADaMCST
         5Ew8e/W9Dl0Ra2YX42ohoxwsS6SGmj/lJxj7VLz+Wcj4/gu33Tt1kuGG3Ust21YV5Krn
         8rCemM9ZUpeRU0tIRVxrG0MDpD1b39zqLhq7xqypkh2JqmJw76jCVoTjAYB6GpH7Oq+P
         8ITvCDwUm6znOgmqNiUgSPFS387oWPK69AEhX/3jP1nzyUTT+A21xriQmKdheCysoF4Z
         72oBL6NuNmm1XZeBbtYxXfjDbIL2jMyfeFJSQyoa76zFS5/zSPEpunlGjhTWUjxM3wgV
         3yrg==
X-Gm-Message-State: ACrzQf33106x7BXCWr1hbKMy3tNEtS3MefKvwBCLEP9s8QbSd7aa4o6k
        YwK+La1mY9HHiCXRoU/BUkFaF1sXhmeo+g==
X-Google-Smtp-Source: AMsMyM6NjU5s5wT23z6SSIrz5YltzqINCNfIZt11xrEepsibOPozuGPZ3Qg8jQozL9mFRQFmT5hU8Q==
X-Received: by 2002:a05:6000:1189:b0:228:62c7:7e6c with SMTP id g9-20020a056000118900b0022862c77e6cmr1884752wrx.716.1663847590382;
        Thu, 22 Sep 2022 04:53:10 -0700 (PDT)
Received: from imac.redhat.com ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id bg17-20020a05600c3c9100b003a5f4fccd4asm5865074wmb.35.2022.09.22.04.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 04:53:09 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v4 0/2] Add table of BPF program types to docs
Date:   Thu, 22 Sep 2022 12:52:55 +0100
Message-Id: <20220922115257.99815-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Patch 2 adds the program_types documentation with a new makefile in
the libbpf doc directory to generate program_types.csv, using
scripts/gen-bpf-progtypes.sh

The generator is now in scripts/gen-bpf-progtypes.sh so that it can be
exported to the libbpf git repository along with the libbpf docs. The
libbpf repository will need to be updated to sync and use
scripts/gen-btf-progtypes.sh after this patch lands.

I plan to look at adding info about the format of section "extras" for
each program type as a follow-on.

v3 -> v4:
Fix typo reported by Jesper Brouer
Move the generator from the Makefile to a separate script

v2 -> v3:
Put program_types after API docs in TOC as suggested by Andrii Nakryiko
Fix formatting as reported by Andrii Nakryiko
Include USDT extras example as suggested by Andrii Nakryiko
Include sample of program_types.csv as suggested by Andrii Nakryiko

v1 -> v2:
Automate the generation of program_types.csv as suggested by
Andrii Nakryiko.

Donald Hunter (2):
  Add subdir support to Documentation makefile
  Add table of BPF program types to libbpf docs

 Documentation/Makefile                     | 16 ++++++++--
 Documentation/bpf/libbpf/.gitignore        |  1 +
 Documentation/bpf/libbpf/Makefile          | 29 ++++++++++++++++++
 Documentation/bpf/libbpf/index.rst         |  3 ++
 Documentation/bpf/libbpf/program_types.rst | 32 ++++++++++++++++++++
 Documentation/bpf/programs.rst             |  3 ++
 Documentation/userspace-api/media/Makefile |  2 ++
 scripts/gen-bpf-progtypes.sh               | 34 ++++++++++++++++++++++
 8 files changed, 118 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/bpf/libbpf/.gitignore
 create mode 100644 Documentation/bpf/libbpf/Makefile
 create mode 100644 Documentation/bpf/libbpf/program_types.rst
 create mode 100755 scripts/gen-bpf-progtypes.sh

-- 
2.35.1

