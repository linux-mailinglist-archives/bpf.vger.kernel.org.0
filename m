Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4CD5AC680
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiIDUm3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbiIDUmW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:22 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D532CDD9
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:21 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w2so9104274edc.0
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+mueIs1LuZDJnwLYz7W392w8vTt4VMrhCefvTrYF2bM=;
        b=ad4OjzL73enn+oF0LieWDsYbFRn2XnJNDzSzHi2p5DCG+gr0zM0ZQlKje6istFiZ3i
         JYC+Dn5NTw2/xoH3iE9YsMmUCJQPQ5iLTtuMQBOfl9JPVUw0HiNGHumOOOvwm6kYe1CA
         VF+UJHmxOm1+Vkd3OGaHAh/gwnIff9NQbgGC2ZHeTNswOMJO/UaqLu8CS8g730LN09GC
         wPr1qWzCQLCvi7JdVBBPZuTD19LYWthBFG5ZO0e/3DA1W+OMYvvuFY04w7cXhLlJAv/R
         Qsqz5+6fr7WDfOeGq5YNcukPgzJmty9spGgZSJ7G+xWKUwWwrBV5pf7UX5p+CIM2JC4a
         vYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+mueIs1LuZDJnwLYz7W392w8vTt4VMrhCefvTrYF2bM=;
        b=OncvrpQHMIWDzhLTgYd6T/yhxB1e7jMmnHbTUQGkwV0+TaMzLqX00U1xotdcQ22T1j
         fbazsRey+OSL7y5MzwfVfLgqQXH58kLj7sNejty+3aZt+ANs7txfnDOotK9fNUPGuIiJ
         41vYST+RtaZ/SV4JKW4c4AUfgkaVtUQxIJtJiNqch54nOWWTs9SBvTr/Q53pJPO4xN7i
         AfTmKXZFlczUNIPHq9oSfP2JpsTGMA6CsRDNlefBoJqZ2yfFf7m89I6g6q2j8rH3S0kS
         cQnMyjSghfYkdtWuQGcykRSlSu/g+CuGUfE6eR9mog1fiwue0eGT6RWc7016KNQlwAHI
         RjRw==
X-Gm-Message-State: ACgBeo3+JbWRFGuTO4UMM5ESJx7U91cZtEy64wSOU6cPjRi976Iwkzc7
        DgSnZeWL7zFuluGX//ry0TwzChZ2GLaWxQ==
X-Google-Smtp-Source: AA6agR41bFhNVQ40Z8Z06j8DdBw0euhDa2uBWc6pS9UOfb8JksgLTZr2N55G62cKjV0BbgCWBv8jJw==
X-Received: by 2002:a05:6402:1e8c:b0:448:8776:d813 with SMTP id f12-20020a0564021e8c00b004488776d813mr26929787edf.15.1662324140568;
        Sun, 04 Sep 2022 13:42:20 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id by12-20020a0564021b0c00b00445e1489313sm5229250edb.94.2022.09.04.13.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:20 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 30/32] selftests/bpf: Add BTF tag macros for local kptrs, BPF linked lists
Date:   Sun,  4 Sep 2022 22:41:43 +0200
Message-Id: <20220904204145.3089-31-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1049; i=memxor@gmail.com; h=from:subject; bh=8MX/K32pt7DcebR6DqwYIOzDSTAXpIiJFaIypindMt8=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1yg8RRfQV+Kdvy9RY8rE21z3dF/HR1P1rB/tW9 Xk1hmliJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcgAKCRBM4MiGSL8Ryr1zD/ 95y58oLkmS1qGeGsMf6vBuHJ7paxZHyifHUFfw9kugRb6QSQzUhCtzSdnLaeDhIbjrAiQ5MDCuUPwv 3bSdOJynwp7gVsQdfPwV0TDi/Kbet5U61Nde4vBjsh51HS7btLjPbh3cQXJkfkjJ000HQdwS1jhmd3 GEOuRdEXtF2hOaw95uDbbZFSCqozJOObdxxkcPpr8Z3oJdPtlZDBm/rUNWHXMC2pw5yzGXV1cavrTg 09Lrc7sEopr+QO3DJ0P2NixnvVbetvPNP2IaPP4QxsSt1FlMSe5omjpCG8UI7XobOxhfqQ1UPHuPMI GljBCGwcZCy+P/dNLX9a4/qc0AY3tttJodEz84YnJOFJw72dDeoOEO2P8CDuwnvSHVodrmOxV273g3 NX7y7wjrZFXpxyr9g8XlRSs8AOWc84VUke25oqE/exxrmu4JfpjRItgdh/RxUYU632jQxw7qJN1jna yOOM9mzldXnwHbDJwWKR/9kt7gNKEnTRs9hrisBA4tl5ubyEmypUuLmWTo6tiZKKzKvIX9wkPd4Sxg aQ6T0QA3ieVRyd4fCWXF2BP/HY55eV5Yy6nI2PdonJPl6ata+mxJ+rROTtmvMmfSxuMMOD6kOb9E1O ArEwsb+Vj4FcgDcIG+f7g2AOtu/9yiaq7wqBMRkeiMyJa2JRMwTVfoNortTQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

Since this is an experimental API, all of these tags are not exposed in
libbpf, but hidden in the bpf_experimental.h header in the selftests
directory. Once enough field experience has been gained with this API,
it can graduate to stable and can be baked into UAPI.s

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 60fe48df4f68..21f12c510db4 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -3,6 +3,10 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 
+#define __contains(kind, name, node) __attribute__((btf_decl_tag("contains:" #kind ":" #name ":" #node)))
+#define __kernel __attribute__((btf_decl_tag("kernel")))
+#define __local __attribute__((btf_type_tag("local")))
+
 #else
 
 struct bpf_list_head {
-- 
2.34.1

