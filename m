Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D94D4654CC
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 19:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352139AbhLASO3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 13:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbhLASOW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 13:14:22 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDF2C061748
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 10:11:00 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so2334464pjb.4
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 10:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9jm2kyBTEUmcq4PhVPwSiHCfzkpWfB+jxdd98MlHtrg=;
        b=J14nwNVPPM/KuwVVQu5n8Af4UlWnAsMrAdmIE+P4aLR5wxSuZ+SgWPsnrBM/Q/IYxw
         KxIPFPsumozdbt7UsrVhLqUENr9Zear88+JrqdlOxWHQ5vCmuvfM4sCCEfOBELVVXr7C
         r1ERh+MM+U3nv/gR6bIuqKw/TumsVVUUKgGbTydTykGv3n13l9l45hWs4Q2owZnTnJ/f
         J6kB8ytVgWcUGtegynsc6FqgmKWC1K6azb0gSdztwDcrQdMYp/HAPAyHwBRJOCjz118V
         x9egjDmaVH36ctgFpTZWq2OfGra1ltjJBSsjl2u+ocn8SkMhOTSM/SHwa41X23n4j6lH
         1rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9jm2kyBTEUmcq4PhVPwSiHCfzkpWfB+jxdd98MlHtrg=;
        b=ZXlAu76BkGPoKtgn++myckl6cyc1rS2M8UTh1Sr48iwGF4cVCj7uZaW4OsvlSmSpA0
         saArnp/UtMNl9VkNH8nlon6nELUiNIxON2Z1jJWpMs5mYR0ru70ZU27tdISqR6qW2Vay
         SU/fpctxs0Xa592YcExNjI/UXp3q8bOD6NkTzYfZrGonS91jE6d8neYKtrj/Kt3PUGk9
         gxlg+vohI0/8qM2I/DFJ48EKgIQuK1lzC6MfmiyR3Y+AsnwJvzpXZGjovep7wi00kvUq
         GXfGkArK1ZvGZFo/r7PY528wL7/KpyDqJrgiZBQ8mZLaJOPIqxJRcVJnjyjsRQX0zy5e
         jcfg==
X-Gm-Message-State: AOAM532ze2375r0X9C6xhZWs2UKxM77HzBObK7UNXEKuAAXBLfhPnvbH
        4S+mTQgaDelkTWAFBymKTp0=
X-Google-Smtp-Source: ABdhPJwdn04/EGwJC9zqoCxk9LWtoVGrk7vDM0DIb2moJ6s7gw++VBQ0iuxQQ2rrV9PQwSmoeuKD/g==
X-Received: by 2002:a17:90a:fe87:: with SMTP id co7mr9421329pjb.21.1638382259863;
        Wed, 01 Dec 2021 10:10:59 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:620c])
        by smtp.gmail.com with ESMTPSA id x16sm441317pfo.165.2021.12.01.10.10.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 10:10:59 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v5 bpf-next 06/17] bpf: Adjust BTF log size limit.
Date:   Wed,  1 Dec 2021 10:10:29 -0800
Message-Id: <20211201181040.23337-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
References: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Make BTF log size limit to be the same as the verifier log size limit.
Otherwise tools that progressively increase log size and use the same log
for BTF loading and program loading will be hitting hard to debug EINVAL.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0d070461e2b8..dbf1f389b1d3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4472,7 +4472,7 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 		log->len_total = log_size;
 
 		/* log attributes have to be sane */
-		if (log->len_total < 128 || log->len_total > UINT_MAX >> 8 ||
+		if (log->len_total < 128 || log->len_total > UINT_MAX >> 2 ||
 		    !log->level || !log->ubuf) {
 			err = -EINVAL;
 			goto errout;
-- 
2.30.2

