Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D058059B358
	for <lists+bpf@lfdr.de>; Sun, 21 Aug 2022 13:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiHULf5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Aug 2022 07:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHULf4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Aug 2022 07:35:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA941835F
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 04:35:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so4636500wms.0
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 04:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Emvzw81E9rbTpR7B4v/LnUFapcpD5Nw0KeJWBhy/LAE=;
        b=Ea+OHOfB2wZ0mjdR27UV1O0nLu8PkpH2W8dtkQ0gebllTfEFk07tAOtXEuBZyIaIO0
         O5wMDY8RBDCiJuiguVETybqGj5vEva4RYBMZCxo64F1PG3BxEgNo0kIiyt1/mI4euv67
         0XxQjPtKTzsSl1Cd6VcZy8LPQXvVGlZLLFqcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Emvzw81E9rbTpR7B4v/LnUFapcpD5Nw0KeJWBhy/LAE=;
        b=3r67mDjEPcPCVFbRXAq4roNzHlhnDijAwfn3o/BEDcx3x65VFdBROZhZ2NpWIGlt2T
         j4vMCXxXvw5svzr+tum+m/8iEMVcCritiwqsQdrNgj2wL4hP518iRv7tPuJStxrqYsGW
         4M4pOKL4e6sAA2LexAFqGFuu03HXrbf6GGh2n76y2FrEkkFcL54A+pMtYKt7NwF/AcAz
         FGjaKyjqymn07+pXNs0kUvJNf6PVSVcWP7PRAOIXLOaENKDrYFgOeY9mIusa28wOp934
         O6XZy94EiUgNBUftXl8Nr+7LO4gya9PCIb2nWwgBfqKlpVsECzO6kJq/O1Kut9JFhNhX
         uyXg==
X-Gm-Message-State: ACgBeo0+1jx1lQj1G1OoJRxEhBAra8Hj1JcoVIXwd2SJdoJDaCsHOWyL
        Jb853P1cKnMP4aWZEZg3hjGqX0V0QwBjADV2F/HBloUaGDxMpA9MhL6XdSV2ggPB84wNVC4h+Kw
        VxyNmZFdJ0w8cyn915mkvkVXIM+O44D6UbEfyT0qxhNGS8eo+5i8qkQrgHNTUFy8be/stW1Ll
X-Google-Smtp-Source: AA6agR7947z5lpBeW5Ame0BJfug407/tGmULHJCxQZmvM3gaSrfoX+ulf98cSNCutQpbceK66ZQ2Bw==
X-Received: by 2002:a05:600c:358e:b0:3a5:f19d:28db with SMTP id p14-20020a05600c358e00b003a5f19d28dbmr13211720wmq.76.1661081753483;
        Sun, 21 Aug 2022 04:35:53 -0700 (PDT)
Received: from blondie.home ([94.230.83.151])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c2cc800b003a6632fe925sm1067178wmc.13.2022.08.21.04.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 04:35:53 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH v2 bpf-next 2/4] bpf/flow_dissector: Introduce BPF_FLOW_DISSECTOR_CONTINUE retcode for flow-dissector bpf progs
Date:   Sun, 21 Aug 2022 14:35:17 +0300
Message-Id: <20220821113519.116765-3-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220821113519.116765-1-shmulik.ladkani@gmail.com>
References: <20220821113519.116765-1-shmulik.ladkani@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, attaching BPF_PROG_TYPE_FLOW_DISSECTOR programs completely
replaces the flow-dissector logic with custom dissection logic.
This forces implementors to write programs that handle dissection for
any flows expected in the namespace.

It makes sense for flow-dissector bpf programs to just augment the
dissector with custom logic (e.g. dissecting certain flows or custom
protocols), while enjoying the broad capabilities of the standard
dissector for any other traffic.

Introduce BPF_FLOW_DISSECTOR_CONTINUE retcode. Flow-dissector bpf
programs may return this to indicate no dissection was made, and
fallback to the standard dissector is requested.

Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
---
 include/uapi/linux/bpf.h       | 5 +++++
 net/core/flow_dissector.c      | 3 +++
 tools/include/uapi/linux/bpf.h | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 934a2a8beb87..7f87012b012e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5861,6 +5861,11 @@ enum bpf_ret_code {
 	 *    represented by BPF_REDIRECT above).
 	 */
 	BPF_LWT_REROUTE = 128,
+	/* BPF_FLOW_DISSECTOR_CONTINUE: used by BPF_PROG_TYPE_FLOW_DISSECTOR
+	 *   to indicate that no custom dissection was performed, and
+	 *   fallback to standard dissector is requested.
+	 */
+	BPF_FLOW_DISSECTOR_CONTINUE = 129,
 };
 
 struct bpf_sock {
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index a01817fb4ef4..990429c69ccd 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1022,11 +1022,14 @@ bool __skb_flow_dissect(const struct net *net,
 			prog = READ_ONCE(run_array->items[0].prog);
 			result = bpf_flow_dissect(prog, &ctx, n_proto, nhoff,
 						  hlen, flags);
+			if (result == BPF_FLOW_DISSECTOR_CONTINUE)
+				goto dissect_continue;
 			__skb_flow_bpf_to_target(&flow_keys, flow_dissector,
 						 target_container);
 			rcu_read_unlock();
 			return result == BPF_OK;
 		}
+dissect_continue:
 		rcu_read_unlock();
 	}
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 1d6085e15fc8..f38814fbb618 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5861,6 +5861,11 @@ enum bpf_ret_code {
 	 *    represented by BPF_REDIRECT above).
 	 */
 	BPF_LWT_REROUTE = 128,
+	/* BPF_FLOW_DISSECTOR_CONTINUE: used by BPF_PROG_TYPE_FLOW_DISSECTOR
+	 *   to indicate that no custom dissection was performed, and
+	 *   fallback to standard dissector is requested.
+	 */
+	BPF_FLOW_DISSECTOR_CONTINUE = 129,
 };
 
 struct bpf_sock {
-- 
2.37.2

