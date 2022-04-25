Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6373050E530
	for <lists+bpf@lfdr.de>; Mon, 25 Apr 2022 18:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240107AbiDYQLK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Apr 2022 12:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238645AbiDYQLK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 12:11:10 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06B13D4A7
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 09:08:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w4so21525693wrg.12
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 09:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qEHXX8+RUJZBVxgjCy0bUHqIpHBMNJwp3wfItFFaoao=;
        b=OMwe9keaN5waMrugXFNZe7JuqVXI7C7FVI22g9O1uN+an1F9AtO8872/KbLH0b4Mwj
         sVNWlE8sEP2GqvgT6LPrTeJ4RY7AGUywqkgSoHfnEI9f11ldv828bXzO5szlYruJoBwG
         3FZBTE2ju31/0dxUP4XKR4RzVey+xwZMX0wnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qEHXX8+RUJZBVxgjCy0bUHqIpHBMNJwp3wfItFFaoao=;
        b=gPEaQosr+r4JA/ZLURKxZS+nPVmPQRrjNOa9W02rinZiZ08eIWT/AlmPLTEDKko+lV
         MTP5q2WDlcCOTioCU6qGTz0vxtF4Fib5psfhZk4UuaSyv9+D+9XoTILpGHVUtrkCshg/
         jyLHp2eUJBIX0vGqz9e7mgiMRu7G0pgPaqApAzZ24UsJLS+uTL2uTs9i+PkOf6HfVPBq
         ZWdrSz0AoOensXws//Y0mzZBspg8qbZF6JMC1lX+DzD51Bydi7+ID7VraBeLGZZKhw3X
         ORBYWuXE5XtXuKr2QePeLj/O0nZ+HLg605Vw8WeIl9TI9TxNWKV5C/GQbtDwNRUVoasg
         OhXA==
X-Gm-Message-State: AOAM533IBqfaOt+q7qnbkA0ajdshxsT+rCs+3gLQL+qgloYslwIvnohp
        M27O/7IS7LSurTERlVx48LBDkQ==
X-Google-Smtp-Source: ABdhPJxWYaU7QfE4XR/kDVbeZLwoXKRrOcvCSMIUxoAgmQwe9rU9q3uvjP5SKl8cctXI19coBTJWxQ==
X-Received: by 2002:adf:d0d0:0:b0:20a:d93f:e252 with SMTP id z16-20020adfd0d0000000b0020ad93fe252mr5747929wrh.78.1650902884395;
        Mon, 25 Apr 2022 09:08:04 -0700 (PDT)
Received: from cloudflare.com (79.184.126.143.ipv4.supernova.orange.pl. [79.184.126.143])
        by smtp.gmail.com with ESMTPSA id m1-20020a1ca301000000b003929c4bf250sm12126281wme.13.2022.04.25.09.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 09:08:03 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     linux-man@vger.kernel.org
Cc:     bpf@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH] bpf.2: Note that unused fields and padding in bpf_attr must be zero
Date:   Mon, 25 Apr 2022 18:08:03 +0200
Message-Id: <20220425160803.114851-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In a discussion regarding a potential backward incompatible change [1],
Andrii Nakryiko points out that unused bytes of bpf_attr should be
zero. Add this bit of information to the bpf(2) man page.

[1] https://lore.kernel.org/bpf/CAEf4BzbT4vQBnZzdD00SuPCDkeb4Cm=F6PLUoO_3X93UQD5hbQ@mail.gmail.com/

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 man2/bpf.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/bpf.2 b/man2/bpf.2
index 2d257eaa6..ee57226ee 100644
--- a/man2/bpf.2
+++ b/man2/bpf.2
@@ -142,7 +142,7 @@ provided via
 .IR attr ,
 which is a pointer to a union of type
 .I bpf_attr
-(see below).
+(see below). The unused fields and padding must be zeroed out before the call.
 The
 .I size
 argument is the size of the union pointed to by
-- 
2.35.1

