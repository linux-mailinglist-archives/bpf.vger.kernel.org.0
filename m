Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7E525FDDA
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 17:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgIGP7t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Sep 2020 11:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730001AbgIGOtE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Sep 2020 10:49:04 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F13C061786
        for <bpf@vger.kernel.org>; Mon,  7 Sep 2020 07:48:33 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c19so12471758wmd.1
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2020 07:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=drF67q2mBxuUFYjet2Np2C1FhA/wmc+gwqkjVPZbrp8=;
        b=n7eDaMD4bQpckFEp/Dx9wUpU9C/Kvsfi0sLn+uNHd2uuSra/jsl5ivhFcv7IIZEAME
         OvyPWG30DvZHJS+nyPFMxsIeCU2nAlGJmQQuReWx1054qQug7ZGDe/7ETgX8E8zAEwFI
         6QjL2ediZ0i4/NFCutpGoqtY0N6Na0+8sDcUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drF67q2mBxuUFYjet2Np2C1FhA/wmc+gwqkjVPZbrp8=;
        b=qHEslcl4q+8UbRG0vO2GBu25uXcvSepfp5MQcTiz4p4ZwwhFOebKA5HGsLarrmEIBT
         1K0AnluoY6Q3rwVIsvs73KWvSfhhQmk8gW48InfbbgBkIkmknnaGQITXTLcXGNJ4wbEI
         hWpHIfMu6nyKuTaZwwrj9T7UR3AHZzNm0nLzGEq+/3ZFAF6Gpe03gWKbX0aYGPLImHZ/
         woKQUyaZuwBqOQUZQ1GbeNOUk1xanBiCuPKXp8wPkYWKwmG6kN9Xy3XxLnrWPLHcme3C
         h7kfiCaEPL7hmKQ4UD6idQ93drIwBAN/O7f3M09SaQixoayix6p+st2MJqCYJQhhkCfX
         3K7g==
X-Gm-Message-State: AOAM531PSXdPYucUuLhyiB1Ca0Nalk9vOoDK7zpGSLA8+bkt8yhb2X6v
        Hws1w7msuuIRxr34Erl25sv72g==
X-Google-Smtp-Source: ABdhPJxwaOkr2N7ZS9Zi2d9KUuSUFSPWMKMf/DnAfi0Qke+iqNaB//wvdCTMLiJiyzxRojFza/H/eA==
X-Received: by 2002:a05:600c:2053:: with SMTP id p19mr20892423wmg.50.1599490112563;
        Mon, 07 Sep 2020 07:48:32 -0700 (PDT)
Received: from antares.lan (2.e.3.8.e.0.6.b.6.2.5.e.8.e.4.b.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:b4e8:e526:b60e:83e2])
        by smtp.gmail.com with ESMTPSA id 59sm8816834wro.82.2020.09.07.07.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 07:48:31 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v4 4/7] bpf: sockmap: accept sock_common pointer when updating
Date:   Mon,  7 Sep 2020 15:46:58 +0100
Message-Id: <20200907144701.44867-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907144701.44867-1-lmb@cloudflare.com>
References: <20200907144701.44867-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The sockmap update path already ensures that only full sockets are
inserted (see sock_map_sk_state_allowed). Allow BPF to pass pointers
to sock_common to map_update_elem(sockmap). This allows calling the
helper with struct sock pointer derived from the sockmap iterator context.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f1f45ce42d60..a4c398e05673 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3895,7 +3895,7 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
 	case BPF_MAP_TYPE_SOCKMAP:
 	case BPF_MAP_TYPE_SOCKHASH:
 		if (*arg_type == ARG_PTR_TO_MAP_VALUE) {
-			*arg_type = ARG_PTR_TO_SOCKET;
+			*arg_type = ARG_PTR_TO_SOCK_COMMON;
 		} else {
 			verbose(env, "invalid arg_type for sockmap/sockhash\n");
 			return -EINVAL;
-- 
2.25.1

