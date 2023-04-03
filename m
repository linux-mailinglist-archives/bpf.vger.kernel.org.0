Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580BD6D4B02
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 16:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbjDCOvw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 10:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbjDCOvi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 10:51:38 -0400
Received: from mail-ed1-x562.google.com (mail-ed1-x562.google.com [IPv6:2a00:1450:4864:20::562])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A249618244
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 07:51:12 -0700 (PDT)
Received: by mail-ed1-x562.google.com with SMTP id er13so77420079edb.9
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 07:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680533471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tpQAyPLn90OluU+IePtUkRJyq+TL+h1VEGWV01w/GTM=;
        b=VJ9ZUx2nEg6JutLgbrgD+T/bzO5r9GVVfiBBA6STBZVJspcMtTB+c/fX/RD4dn5s9Q
         KpqDNJYSVusML3gZ60WtrkHvq4q2I44FBAfn0FfH3M4n8ScKW06sw+s3Z9FgolF4PDSg
         a2k9GrKGm9JlsslNqM+MdYf1ZG9y6RQTzZQk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tpQAyPLn90OluU+IePtUkRJyq+TL+h1VEGWV01w/GTM=;
        b=jB5aR38EXttEVPaW8XaYU/wHvdRAVmsF9JNCZXWyrdJntnFVmSZChIYOTNF83CXN/2
         jVru3PFGW18nL51lz2LBas6pK4M0zx7LLHW4Wac7LGhODAvF34UlIbeWQvOFDHoT5A9c
         DwJvtC9U7vsEdcNC1w87aC1FeNv83hXM1InY5qIh4vlfDgMqdNBn4OIBIEpTxRE6ZGVG
         ebd85lnbA9t8c1vbsH0UjvvRmGpXNQJWZTmxCqv3Sp7NusS45P4eo1WQ8qAtqS9sxH8x
         5VVlRfrslikidJ4EgchwuWU1PbIgsRh/4l9IUNEyqCOb61oWAFEDCwRIW6Isr6+zPvEO
         MrNw==
X-Gm-Message-State: AAQBX9fW7iBYr6a5WMHjsvLzW9sEvHaS/gUXis1NU4KFz6OuYQGrz7KA
        EN77vUPUoX+9tj3xIrHdvCJ+rCfRGiFmbTtn8wmUMrOjONr/
X-Google-Smtp-Source: AKy350a+ciSASMqZpj4hW3RskuhiweVuANyWfnb9JUO4CPFmhfKCAizGlxFdFtb6z/jUOa6EdlbOfbBsULZo
X-Received: by 2002:a17:906:85c2:b0:88d:ba89:1837 with SMTP id i2-20020a17090685c200b0088dba891837mr17657125ejy.8.1680533471087;
        Mon, 03 Apr 2023 07:51:11 -0700 (PDT)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id i25-20020a17090685d900b00944010e0472sm3146122ejy.236.2023.04.03.07.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 07:51:11 -0700 (PDT)
X-Relaying-Domain: dectris.com
From:   Kal Conley <kal.conley@dectris.com>
Cc:     Kal Conley <kal.conley@dectris.com>, bpf@vger.kernel.org
Subject: [PATCH bpf-next 0/2] selftests: xsk: Add test case for packets at end of UMEM
Date:   Mon,  3 Apr 2023 16:50:45 +0200
Message-Id: <20230403145047.33065-1-kal.conley@dectris.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset fixes a minor bug in xskxceiver.c then adds a test case
for valid packets at the end of the UMEM.

Kal Conley (2):
  selftests: xsk: Use correct UMEM size in testapp_invalid_desc
  selftests: xsk: Add test case for packets at end of UMEM

 tools/testing/selftests/bpf/xskxceiver.c | 16 ++++++++++------
 tools/testing/selftests/bpf/xskxceiver.h |  1 -
 2 files changed, 10 insertions(+), 7 deletions(-)

-- 
2.39.2

