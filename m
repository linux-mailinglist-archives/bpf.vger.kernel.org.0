Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7171597E90
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 08:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243639AbiHRGYs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 02:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243637AbiHRGYq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 02:24:46 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE63A8974
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 23:24:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y13so1388486ejp.13
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 23:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Qu09lJpReSX+SUME4IXmwGa358TUYq7t6MDEsPG5O/U=;
        b=CccAywSjzlBpI5ULacGUJj3LaHn48zDl30B7kj94qYYlxNpVfgo4UPgv9fg3q6aJpA
         wSJNkTphkACYDUk2jn968eHoLnax7CSPIJQPd4q6/XV+2ktNoLefgzf4KtIvzVM3qQVY
         2qp1RBXSbLdtQNyBuTvJXcnImS7Jw+1WFmKQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Qu09lJpReSX+SUME4IXmwGa358TUYq7t6MDEsPG5O/U=;
        b=n+dCabm7dbiVlLrHuB/s13adEXLJrdoZ87sJeerdxe/hdZ27FK/HtJxNta8v6JfrT7
         3CYYS/hVUV/TZkyeFF1E9iWXrmvXohAJJkYjePT0+yCYPbH6fWzUxBQs9b9DIsstB7c/
         t6bUih7+kegKIqwxveLv0Irusa8fvQ0lHH/XIwszTd4iGncdtuO5nZQYQqMGFMXMlF24
         7MzdVQVvcxDXUq4VbqNGrOeSvxvsEudTTcrfFZjrX78l8cUUFqpYqrZm8QfAmGs7Jp+r
         JkQEYuK8+LgAEwpcFFoc8LgR74ARygefm+KUU7jL8Hp9YE/3BlssDDP4XRnhQ/OFN0o0
         9s+Q==
X-Gm-Message-State: ACgBeo2SC35GlGnUQh1vgK77W3MVKanBVuxI9uJtdquYuKvug+BZGUpV
        sH56Gtrj/den/CXHp4BhFePKz5m9Jtp0ixw/gKuhRai+cK0r4VsAn1TWEnspGfwk4HFesJpGuO3
        ERQTOIvgzu0tzsEn2H7jLUcV7iOSyIEXP/k37x7e9QpZEHa3AQAHHV60E8Yzc3zC0+FcOLgRz
X-Google-Smtp-Source: AA6agR5YeyasVgK25EL3cOUUBgureRWjEQhc57W1OW9llzxy3Wx0xyFL5o2xoL7HgvZiei62p8rUNw==
X-Received: by 2002:a17:907:288a:b0:730:7ee5:e6a with SMTP id em10-20020a170907288a00b007307ee50e6amr942201ejc.218.1660803883843;
        Wed, 17 Aug 2022 23:24:43 -0700 (PDT)
Received: from localhost.localdomain ([141.226.169.165])
        by smtp.gmail.com with ESMTPSA id a11-20020aa7cf0b000000b0043bc19efc15sm535263edy.28.2022.08.17.23.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 23:24:43 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH bpf-next 2/2] bpf/flow_dissector: Introduce BPF_FLOW_DISSECTOR_CONTINUE retcode for flow-dissector bpf progs
Date:   Thu, 18 Aug 2022 09:24:05 +0300
Message-Id: <20220818062405.947643-3-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220818062405.947643-1-shmulik.ladkani@gmail.com>
References: <20220818062405.947643-1-shmulik.ladkani@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 include/uapi/linux/bpf.h  | 5 +++++
 net/core/flow_dissector.c | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7bf9ba1329be..6d6654da7cef 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5836,6 +5836,11 @@ enum bpf_ret_code {
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
 
-- 
2.37.1

