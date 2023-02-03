Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBD0689EE2
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 17:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjBCQFs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 11:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjBCQFq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 11:05:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688F99F9DE
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 08:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675440295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=a9GxvJY6tIujAAbOqDif84FIm92SECZFywCQ9nH/kx0=;
        b=gJOCZSqEEGVrAkTi5brU6A5pSHpYHA3udu272O8WeZDggkdSh66IAtUPyoXX81ld4Sk7dL
        DsC0+rzExKx0sakTPjMkuQBTvmaRJPdlLCwNJxP4vBsH6L3NlsUzEDxQeNuh07vS3vIdp4
        CFaL0Lsi8VrgTEMHb8JTe8FtW7Iy4t4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-pjN-YZmiMW2ddNDyrolo4w-1; Fri, 03 Feb 2023 11:04:52 -0500
X-MC-Unique: pjN-YZmiMW2ddNDyrolo4w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6251857A81;
        Fri,  3 Feb 2023 16:04:51 +0000 (UTC)
Received: from redhat.com (ovpn-116-97.gru2.redhat.com [10.97.116.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED59253AA;
        Fri,  3 Feb 2023 16:04:50 +0000 (UTC)
From:   "Herton R. Krzesinski" <herton@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bpf@vger.kernel.org, davem@davemloft.net, liuhangbin@gmail.com,
        pabeni@redhat.com, gnault@redhat.com, jstancek@redhat.com,
        prarit@redhat.com, torez@redhat.com, carlos@redhat.com,
        dzickus@redhat.com, dhoward@redhat.com, kuba@kernel.org
Subject: [PATCH] uapi: add missing ip/ipv6 header dependencies for linux/stddef.h
Date:   Fri,  3 Feb 2023 13:04:48 -0300
Message-Id: <20230203160448.1314205-1-herton@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since commit 58e0be1ef6118 ("net: use struct_group to copy ip/ipv6
header addresses"), ip and ipv6 headers started to use the __struct_group
definition, which is defined at include/uapi/linux/stddef.h. However,
linux/stddef.h isn't explicitly included in include/uapi/linux/{ip,ipv6}.h,
which breaks build of xskxceiver bpf selftest if you install the uapi
headers in the system:

$ make V=1 xskxceiver -C tools/testing/selftests/bpf
...
make: Entering directory '(...)/tools/testing/selftests/bpf'
gcc -g -O0 -rdynamic -Wall -Werror (...)
In file included from xskxceiver.c:79:
/usr/include/linux/ip.h:103:9: error: expected specifier-qualifier-list before ‘__struct_group’
  103 |         __struct_group(/* no tag */, addrs, /* no attrs */,
      |         ^~~~~~~~~~~~~~
...

Include the missing <linux/stddef.h> dependency in ip.h and do the
same for the ipv6.h header.

Fixes: 58e0be1ef611 ("net: use struct_group to copy ip/ipv6 header addresses")
Signed-off-by: Herton R. Krzesinski <herton@redhat.com>
---
 include/uapi/linux/ip.h   | 1 +
 include/uapi/linux/ipv6.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/linux/ip.h b/include/uapi/linux/ip.h
index 874a92349bf5..283dec7e3645 100644
--- a/include/uapi/linux/ip.h
+++ b/include/uapi/linux/ip.h
@@ -18,6 +18,7 @@
 #ifndef _UAPI_LINUX_IP_H
 #define _UAPI_LINUX_IP_H
 #include <linux/types.h>
+#include <linux/stddef.h>
 #include <asm/byteorder.h>
 
 #define IPTOS_TOS_MASK		0x1E
diff --git a/include/uapi/linux/ipv6.h b/include/uapi/linux/ipv6.h
index 81f4243bebb1..53326dfc59ec 100644
--- a/include/uapi/linux/ipv6.h
+++ b/include/uapi/linux/ipv6.h
@@ -4,6 +4,7 @@
 
 #include <linux/libc-compat.h>
 #include <linux/types.h>
+#include <linux/stddef.h>
 #include <linux/in6.h>
 #include <asm/byteorder.h>
 
-- 
2.38.1

