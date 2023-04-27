Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD8C6F0057
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 07:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbjD0FOX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 01:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjD0FOW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 01:14:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B56BE54;
        Wed, 26 Apr 2023 22:14:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2f46348728eso4878036f8f.3;
        Wed, 26 Apr 2023 22:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682572459; x=1685164459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9fCmQIEKpN2vCCdLdDbmdbQ8H+2U2tsMn9nlcgKxUM=;
        b=LP+HEJJdhkHc+l/AU1/JIixPA7bpTzbVnDm6spWkvTzhLU+Lzv5WELkqy7vnxsxyQw
         272wICEBLrkvKhuZ7qw4V23rCzLUThyg1UF6Y4AkegEz5g4E683md+lQLopUnx4t77j7
         rReG70d/i5IcBHsTbXerJocFLgUHtiVh48kCWZij7lW7tyWWJac53vB2+/8pWYOWbWYj
         lWCABx6jHMa4HH1nNz2tnwfXqq2/z4NZoHakpeLHHZXEHQffNxoHoUEd7RFQdYPADXN1
         kUws0QkN5iaIT8Qb3CS0TYUsFpR203YqqIWNIIf5vxdXhFinH1ZfTiHZyOmqGnSQdO6s
         wQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682572459; x=1685164459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9fCmQIEKpN2vCCdLdDbmdbQ8H+2U2tsMn9nlcgKxUM=;
        b=Auxm03EyOl1vftz9ncL3ADKdKdWyxqmx/kvBSTVvMNFsDkVF4DO8NTlTSk2OEyb9Jr
         lJFX3ANPaS3jMLxjjiVWCiZDWOxz/GDLDM0opVx173gHD+xwOdFShAHEDoAMXiMDWhqS
         LqyF1VS58iaFu8BU0SVhK8ZbYqT5ALaUwTbe6jx3WKKaQoMrMVyWGy+j7MRRnYA7OQKz
         cDksV8X2U1ogNN30P/4xd06Mu3dNgVgW8gINgHBmMktkIqtAy1rVrtArVFBr4VQ04Egp
         AG7whmga2JbftXTJ3MNwC9MdhkRcGuE5XvEZ5SVUIY1NOS+8qMYnPkx0I9hcUubJqnKP
         dm8w==
X-Gm-Message-State: AC+VfDx0ESkZ7M6KJRocuq1uEKrFZTE04fQQs9/1pmo486Zcawy0DTAl
        rL6h69N1+SZXlatGpqHpREg=
X-Google-Smtp-Source: ACHHUZ5FyODYj5sBHzA0Vo2xS+OjMp0rCuKVcBYNDMOfFSaOQ6xPOTmKqligWhqEsMUdlr3jqDLznQ==
X-Received: by 2002:a5d:5956:0:b0:304:b1da:77d with SMTP id e22-20020a5d5956000000b00304b1da077dmr127403wri.52.1682572458652;
        Wed, 26 Apr 2023 22:14:18 -0700 (PDT)
Received: from solpc.. (67.pool90-171-92.dynamic.orange.es. [90.171.92.67])
        by smtp.gmail.com with ESMTPSA id a14-20020adfe5ce000000b002fbe0772ab1sm17359664wrn.16.2023.04.26.22.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 22:14:18 -0700 (PDT)
From:   =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
To:     jpoimboe@kernel.org
Cc:     i.pear@outlook.com, acme@kernel.org, alan.maguire@oracle.com,
        alexandref75@gmail.com, bpf@vger.kernel.org, dxu@dxuuu.xyz,
        jforbes@redhat.com, linux-kernel@vger.kernel.org,
        olsajiri@gmail.com, peterz@infradead.org, ptalbert@redhat.com,
        yhs@fb.com
Subject: Re: [PATCH] vmlinux.lds.h: Force-align ELF notes section to four bytes
Date:   Thu, 27 Apr 2023 05:14:10 +0000
Message-Id: <20230427051410.2054787-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230416185204.2592590-1-joanbrugueram@gmail.com>
References: <20230416185204.2592590-1-joanbrugueram@gmail.com>
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

PS: As additional information for posterity, there are various conditions that
explain why this is/was only a problem on some specific distributions:

* In addition to dwarves/pahole 1.24, binutils 2.40 seems to also be required
  for the problem to occur (in Arch, downgrading to binutils 2.39 fixes it).
* Debian (and thus derived distributions) configures binutils with
  `--disable-x86-used-note`, which by default disables emitting the GNU notes
  which ultimately cause the .notes section to be aligned to 8 bytes.

  On Debian Bookworm & Ubuntu 23.04, the problem reproduces when building like:
  ```
  export KCFLAGS="-Xassembler -mx86-used-note=yes"
  export KAFLAGS="-Xassembler -mx86-used-note=yes"
  make
  ```

Finally, here's a smaller .config to reproduce the problem on affected systems:
https://zealcharm.com/20230416-btf-dedup-bug-sample-configs/minimal-repro
