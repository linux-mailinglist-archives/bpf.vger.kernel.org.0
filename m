Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF885A0454
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiHXW7R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiHXW7Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:59:16 -0400
Received: from mail-io1-xd63.google.com (mail-io1-xd63.google.com [IPv6:2607:f8b0:4864:20::d63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680F972877
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:59:14 -0700 (PDT)
Received: by mail-io1-xd63.google.com with SMTP id i77so14616250ioa.7
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc;
        bh=Z3KtFUqAsiQFo5yUQUxlkc4HIDDGh9eiGmDcrVtv0eE=;
        b=PwYE1lTcpF5skb/nSSxknoRbCxFHBJUhJgoKtRz2dE/d74OqltjkADKvpXQ7mNBIDK
         CTbBE+DoJIC0Sk47pNpdobKLYW5A1ZtDtdxUs8Z0xjrM4pkhDxgetdAMQDqSdUk3JxfQ
         z4tDK6KSWOGOKBDTgi06JP3Gi7Jq6qsfJWP+gIQ9RAcs+k4XuR+QK2HduQqkkGPxr/ZJ
         CFsMIsXfXda5nn1NmzijQTZOI513zIUGEE2aumkALm7IKhYOSpG/4jJBT7TrkInvvuNx
         h68ID2I2osJpGXUBsm6JoquuZbF9Ugu/K60pueobaHFJoltmETNpbycb4RkjYFTM5EFV
         gwVw==
X-Gm-Message-State: ACgBeo0mW66Z5K/OJhyfF++aYCUOqyn8eMRFNjHKKAzGGZzQ70inh3ss
        rKthA2lr6sdHFcH6FkPQ2Iu+GAXCTvfATceyrEYJ2xFqTlut
X-Google-Smtp-Source: AA6agR6gLfEleu24DPI1fiN+vthoo8l3e3IFpQqZLjm4sdFxrEf95IVW/B13Qhi+dJb8meetypEtsBn8YIWO
X-Received: by 2002:a05:6638:488a:b0:342:6d75:dfa6 with SMTP id ct10-20020a056638488a00b003426d75dfa6mr464638jab.319.1661381953884;
        Wed, 24 Aug 2022 15:59:13 -0700 (PDT)
Received: from smtp.aristanetworks.com (mx.aristanetworks.com. [162.210.129.12])
        by smtp-relay.gmail.com with ESMTPS id a4-20020a021604000000b0034a035a554bsm55780jaa.22.2022.08.24.15.59.13
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2022 15:59:13 -0700 (PDT)
X-Relaying-Domain: arista.com
Received: from us193.sjc.aristanetworks.com (us193.sjc.aristanetworks.com [10.243.24.8])
        by smtp.aristanetworks.com (Postfix) with ESMTP id 31DB64FEF00;
        Wed, 24 Aug 2022 15:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-B; t=1661381953;
        bh=Z3KtFUqAsiQFo5yUQUxlkc4HIDDGh9eiGmDcrVtv0eE=;
        h=From:To:Cc:Subject:Date:From;
        b=C49BLsmcUiyvgMMUuVhWGIhYWgLeoBC5mjG5MXz0LULzVvVl+dMGR6/DGvRsQLmH4
         /iWDzpVYUkWPYrUUZ/4ZkDD3BHJcjtbgleTOkk9CbmecUpfk++csyhSlTVvbKLB+6+
         HKHfORGvXj1bLU4jUZiVCGvVNgLCgXiG58/tECuk=
Received: by us193.sjc.aristanetworks.com (Postfix, from userid 12429)
        id 16429C3B01B7; Wed, 24 Aug 2022 15:59:13 -0700 (PDT)
From:   Lam Thai <lamthai@arista.com>
To:     bpf@vger.kernel.org
Cc:     Lam Thai <lamthai@arista.com>
Subject: [PATCH] bpftool: fix a wrong type cast in btf_dumper_int
Date:   Wed, 24 Aug 2022 15:59:00 -0700
Message-Id: <20220824225859.9038-1-lamthai@arista.com>
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When `data` points to a boolean value, casting it to `int *` is problematic
and could lead to a wrong value being passed to `jsonw_bool`. Change the
cast to `bool *` instead.

Fixes: b12d6ec09730 ("bpf: btf: add btf print functionality")
Signed-off-by: Lam Thai <lamthai@arista.com>
---
 tools/bpf/bpftool/btf_dumper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 125798b0bc5d..19924b6ce796 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -452,7 +452,7 @@ static int btf_dumper_int(const struct btf_type *t, __u8 bit_offset,
 					     *(char *)data);
 		break;
 	case BTF_INT_BOOL:
-		jsonw_bool(jw, *(int *)data);
+		jsonw_bool(jw, *(bool *)data);
 		break;
 	default:
 		/* shouldn't happen */

base-commit: 6fc2838b148f8fe6aa14fc435e666984a0505018
-- 
2.37.0

