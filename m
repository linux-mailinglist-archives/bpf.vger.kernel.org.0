Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F47628903
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbiKNTQM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237077AbiKNTQE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:16:04 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B5026498
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:01 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id v28so11916678pfi.12
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNUXGrsIBZA47dfMoUXlsA9DJrJBOE3oKFjyxYnaenU=;
        b=Ybt6hotfYhHBdLPnxjTKOaiLl/gs+ROSWcdo3b4eFkWB3i+ta+BN4EXEV5lspE4+zX
         i48BYnRXJnLAu9K7ni0LSVntYOpzt7IJxsWBd/Qkq/LNGA7vjIDsCXIO5+wA5XhrGSct
         zF24uqnr3WES8apCITpXng9a8GCS/XLeuayh8IJubGWiyAd0mgiobMIgqIFD72jiBIvr
         q2kZ7Zu1WnfFMAHBFnuTVRRm2JychK5WYPzI/T/lPrdDjLkarXMoR1E159jGnb2BOMiG
         tCwoYBHhYDT6kWHI2rwB9XjoKBfRO5h5dL11UGRBWZAHM19KcajVq8hvha3JLOoOsRKB
         5s2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNUXGrsIBZA47dfMoUXlsA9DJrJBOE3oKFjyxYnaenU=;
        b=hFHhflSmG20T+Rv8O4EYebN6qywt+3cGXHjVf2tQ3fYlZt6UOnpgZpYmRvEfLKu+YO
         TitxxSg4MlWAkTRdCzVZC6Wi46WNKUvLFy+LLpfP4JKdfQMN9jm6ypTa9m0FEzB6sg/+
         gMX1yR6Tj3GlOF3aGYXIhrFT3N2O2ao5l/bEPv58g4MYhsLb7g2xOOWAKs92rdWpEIU1
         rqFBWTVssZFfcXXC5gt7/m8L1GvArSXIWDPJQ71JcoSwmN6boS07jBJvzc7KifzTmO2U
         ecLFi/8BNo5nITwDRCVs+ZF8rMeKy/Edhfv/qizTwhk1HB4LGVsTYyVO+KGAWHdZVLIA
         2LVw==
X-Gm-Message-State: ANoB5pmr/hM3Cib2weGWsG6jMwQz3E/m/78qDdH2nmH9Y1oZvIFGhg0M
        +YAxbgK5msaEMG+0t0cIRT7I6SyaIcymug==
X-Google-Smtp-Source: AA0mqf7flxNLxnKvG3vA39Zsdu+FGqRm+rf2BGy+uHKtQdZ6hg4WDQTKIaMCBZ3F9rfswL9muwSwag==
X-Received: by 2002:a63:8f48:0:b0:455:8333:d8e with SMTP id r8-20020a638f48000000b0045583330d8emr12537724pgn.380.1668453360804;
        Mon, 14 Nov 2022 11:16:00 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id i3-20020a636d03000000b0046f6d7dcd1dsm6232464pgc.25.2022.11.14.11.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:16:00 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v7 03/26] bpf: Fix copy_map_value, zero_map_value
Date:   Tue, 15 Nov 2022 00:45:24 +0530
Message-Id: <20221114191547.1694267-4-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114191547.1694267-1-memxor@gmail.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622; i=memxor@gmail.com; h=from:subject; bh=6RvsvjttmdEULzDCNignBfVVDaAhe2Uld3KegARQNKU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjcpPINLiBPyhOAGswnMZ++VCv2z7GCXT00P33PG8B xurXpGSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3KTyAAKCRBM4MiGSL8RypZxEA DC9Qyv20/94RYHeqeZhTH2gl4Cy4d9m6nLXYC7hJ/lTQqLFEwcNM23KDmtTb29CgaIecPbeQyJvBtF LFFDRDABl1nGigZqwCrGpbOXQ6+2kW0Z0aQnhk139cPIHd0zi8oMiBdlI50ZTRadJ9lcrqDPxSmudp VLE4NSNNjNgs8f85OBm16+ra7Mb/cZDL904I3xBDVQilsMbllWlR2CJuJ0yhz/PUDTHGSh972w8+Tb +4sQ9NtlRC2y9SooacealSHvObUjG8EBlsFH84NSZk+qD3FnmTfw8HiG1d9lTJlAoSNpLrmnhmHahU K1gyGDJbrH0LVS5M9UKgMG6yuPZ1X60Yg0DZ8NE801a93FGaiUCInh3XaxUyoQyGGEEkKpYWrLQaIt cHSaTBnFbxWe80+UC7qIoTIYy2ixaF7WZs2APPNAqvW0XibesDzPobDZPx68u3abjKzElrx+xd/gsB sghX3dIJVUyAZwwKbVLrvIa+EkFsX73bubo0s1by9NT1u9ALenBnUqJPLpmte1cu7c27maHlkZHz8Q 4YAk0ZePJROkxp666oB8FWVhotITFRnHzelgH0rhDhjClZpQTU++qZTeZtHvoqUkO8cTsHPGwM248A PsIMUYVmiGCVM2V1/7wDvlaR0MvRzSU815TEF0/8M06l4iQZRKafMz/QfgWQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The current offset needs to also skip over the already copied region in
addition to the size of the next field. This case manifests where there
are gaps between adjacent special fields.

It was observed that for a map value with size 48, having fields at:
off:  0, 16, 32
size: 4, 16, 16

The current code does:

memcpy(dst + 0, src + 0, 0)
memcpy(dst + 4, src + 4, 12)
memcpy(dst + 20, src + 20, 12)
memcpy(dst + 36, src + 36, 12)

With the fix, it is done correctly as:

memcpy(dst + 0, src + 0, 0)
memcpy(dst + 4, src + 4, 12)
memcpy(dst + 32, src + 32, 0)
memcpy(dst + 48, src + 48, 0)

Fixes: 4d7d7f69f4b1 ("bpf: Adapt copy_map_value for multiple offset case")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1a66a1df1af1..f08eb2d27de0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -360,7 +360,7 @@ static inline void bpf_obj_memcpy(struct btf_field_offs *foffs,
 		u32 sz = next_off - curr_off;
 
 		memcpy(dst + curr_off, src + curr_off, sz);
-		curr_off += foffs->field_sz[i];
+		curr_off += foffs->field_sz[i] + sz;
 	}
 	memcpy(dst + curr_off, src + curr_off, size - curr_off);
 }
@@ -390,7 +390,7 @@ static inline void bpf_obj_memzero(struct btf_field_offs *foffs, void *dst, u32
 		u32 sz = next_off - curr_off;
 
 		memset(dst + curr_off, 0, sz);
-		curr_off += foffs->field_sz[i];
+		curr_off += foffs->field_sz[i] + sz;
 	}
 	memset(dst + curr_off, 0, size - curr_off);
 }
-- 
2.38.1

