Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721B5618EE4
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 04:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiKDD0H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 23:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKDDZW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 23:25:22 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BCFC06
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 20:23:13 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id l1-20020a170902f68100b00187117d8e44so2617573plg.2
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 20:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zm63eFTPkWJYYLLsqSUKS3qevDGfBEn8OaulzKVgrZY=;
        b=QQckuPRmxt9NSuibqdCcuInp7/mT6aw7sEhbS55GZcSJBqXeK63jgG0VzKvbx1Iod7
         z/dAu1Ad5z/h+R/WlEJTXq69elnqvh8Un4vfd/3VAlRVVMo0n65PxFUqylK7rCe/bDNQ
         903MKjL/p59TJNyJ8Y65UVJqyBIl/GqH7vimRndphcRIiIAS4aj2WrPdMXHbLYlxFtZm
         cK9No07YHACxtces8ROWT1FbmlELmV/2Yrop7kWIXovUsjmh7hg40jNZO6glurD7YQz6
         9kFS0D7qUI/sEkgXkroBuZdS/uSFYdoCBUPRuPkmeP16A3pZ7ah00xEejxZer+ScUc8A
         LExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zm63eFTPkWJYYLLsqSUKS3qevDGfBEn8OaulzKVgrZY=;
        b=Cv6M50fBg4MLTq4EoSEDRaZx27NlNW55jY/VjFKuH4M59X8T7Dt39LSSGAODrDaJZp
         zP81yB/VeMBl6gXGLaWRNlYQW2MVR5s+rQeKFEa1bfp1LaU2ztadbGy5dcXkyD6wAQLG
         jdhPdebxTSEfgtKAtxHQSkL2420WAefiuRS8HbFvbR+4+EaFIaw2/JylZdnTQ4PPtsNO
         3+pli/10WOmpdnXqhezZZHm3zR6V7Olv9S5cSzY595HB7PlH6BCu9VE9bXKvgZtgdMUi
         IHuzV0jeYAzTCNMBHNOt1m6sshoqoyzLbTnn/CqvjRRx69ZC9f0AXh3JSochX7pVmMNF
         9WcA==
X-Gm-Message-State: ACrzQf1y8lbcZoC5NgyMt0boDMv1KPDd9Fn58bX9WU9X3KW06EsgL97w
        K80pcIgsbDwaKDo0hU2XWBsLa2AkSKqtchua+SIgAb+jk7hr2YAX4FQ3gcomI0rNwWewH+uJZUc
        NZYPdPLCbNEt9DTGos8nJfRpiOZtG4/EEsdeIeRycwVYJr25JXA==
X-Google-Smtp-Source: AMsMyM75KRXjJbs47kRvpwqA4GBTKMRPXnM5/kegtdEIdhmNbSKj2I3T87EwDWoQmIFVy8wtsgwjXpg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:e0b:b0:56c:8c13:2a54 with SMTP id
 bq11-20020a056a000e0b00b0056c8c132a54mr33390859pfb.17.1667532193234; Thu, 03
 Nov 2022 20:23:13 -0700 (PDT)
Date:   Thu,  3 Nov 2022 20:23:11 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104032311.1606050-1-sdf@google.com>
Subject: [PATCH bpf-next] xsk: fix destination buffer address when copying
 with metadata
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        "=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

While working on a simplified test for [0] it occurred to me that
the following looks fishy:

	data =3D xsk_umem__get_data(xsk->umem_area, rx_desc->addr);
	data_meta =3D data - sizeof(my metadata);

Since the data points to umem frame at addr X, data_mem points to
the end of umem frame X-1.

I don't think it's by design?

0: https://lore.kernel.org/bpf/20221028181431.05173968@kernel.org/T/#t

Cc: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/xdp/xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 9f0561b67c12..0547fe37ba7e 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -163,7 +163,7 @@ static void xsk_copy_xdp(struct xdp_buff *to, struct xd=
p_buff *from, u32 len)
 	} else {
 		from_buf =3D from->data_meta;
 		metalen =3D from->data - from->data_meta;
-		to_buf =3D to->data - metalen;
+		to_buf =3D to->data;
 	}
=20
 	memcpy(to_buf, from_buf, len + metalen);
--=20
2.38.1.431.g37b22c650d-goog

