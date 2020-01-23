Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45DAE146EDF
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 18:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgAWRAC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 12:00:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39934 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbgAWQ7p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 11:59:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so3905917wrt.6
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 08:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7SvZ9phUNQgBFhv9EVqVUJXNc7V2T/+gA9/uB1lrNY=;
        b=gtrzkuQ3f7nCSsbvZV+79p3YHEpiG55tz/BtLLT1TKC04h4wnV8nBZfVTy/oeleTWI
         FLytsgneqoqPVgRerwb4UmFKfANQw/OyLCbDS9cyI8/FdPksxF1YRxNFYVfCmifcHrmO
         gfDjmiP/5qHzq51cApwjJfE8JvSN2pHsTbzhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7SvZ9phUNQgBFhv9EVqVUJXNc7V2T/+gA9/uB1lrNY=;
        b=NKgsrsapkU3LzGFlrNUVL2JHUHOgcf5FLd41DHQTibquALMIPWGHRIsQZOHy0PaZ5W
         3U9ohbn9rWz0pFgbYCj6IPNTatyQ4KlB+/OdPubc6tnH01ivT6bK6jQrGFrHEkbSAF7b
         6tr0vLSsU4JqAcyYm/qWUBV5O/1TfsejhaFMV8LUcoPepenQlmihjn2xETJu+9/xNRrQ
         gKW6dzesXPdz34yvAAnSzzNtue726Ib6bjKNJKxFbQILhTI92diYXetYF+cdoazMuRvW
         vzBKpAmG7yeOKh6gvwrry0keoUUWHE1uZlsVHyrHO4LMCt1Iv1rGqoAnN1zgeqyYhm5z
         AYVA==
X-Gm-Message-State: APjAAAU823rfQwKsQfy8WPmfX8PG2OF8p349ULHbwrk4jCma5hInaGjP
        jevxpsPheGwEUpU2o7otCTq46A==
X-Google-Smtp-Source: APXvYqxZBMzloyeuvuGWMOXyEMsTRg357vgRAFLanDZW9K3hvo17Oc9CnYfhEOKDJRcCoIGSj/eFaA==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr18246948wrj.325.1579798783545;
        Thu, 23 Jan 2020 08:59:43 -0800 (PST)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:d0a9:6cca:1210:a574])
        by smtp.gmail.com with ESMTPSA id u1sm3217698wmc.5.2020.01.23.08.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 08:59:42 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf 2/4] selftests: bpf: ignore RST packets for reuseport tests
Date:   Thu, 23 Jan 2020 16:59:31 +0000
Message-Id: <20200123165934.9584-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123165934.9584-1-lmb@cloudflare.com>
References: <20200123165934.9584-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The reuseport tests currently suffer from a race condition: RST
packets count towards DROP_ERR_SKB_DATA, since they don't contain
a valid struct cmd. Tests will spuriously fail depending on whether
check_results is called before or after the RST is processed.

Exit the BPF program early if FIN is set.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../selftests/bpf/progs/test_select_reuseport_kern.c        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c b/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
index d69a1f2bbbfd..26e77dcc7e91 100644
--- a/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
@@ -113,6 +113,12 @@ int _select_by_skb_data(struct sk_reuseport_md *reuse_md)
 		data_check.skb_ports[0] = th->source;
 		data_check.skb_ports[1] = th->dest;
 
+		if (th->fin)
+			/* The connection is being torn down at the end of a
+			 * test. It can't contain a cmd, so return early.
+			 */
+			return SK_PASS;
+
 		if ((th->doff << 2) + sizeof(*cmd) > data_check.len)
 			GOTO_DONE(DROP_ERR_SKB_DATA);
 		if (bpf_skb_load_bytes(reuse_md, th->doff << 2, &cmd_copy,
-- 
2.20.1

