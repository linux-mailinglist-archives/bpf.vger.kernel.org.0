Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623316261F9
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiKKTdO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbiKKTdN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:33:13 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C8E78327
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:11 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso8612904pjc.0
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNUXGrsIBZA47dfMoUXlsA9DJrJBOE3oKFjyxYnaenU=;
        b=U0j2FX9rWCKh9lkUjYJPY+TcvQMIGMnMViC03lSHTmf0fhsFq52xJVrZQJ5lcWqxE9
         eUBIkNok8EZ/8breqQyzfx961AsbuE+gDAeUTVRTmNieNLISMZQvTClKoe++zIGBAxMM
         XthsueDL1LZPkn5bb3nuOA+MnqcKSGudAZVEcq3vutRsHvECXWMrV9vm5CUzJgiLXq9W
         RL4OAn4uFUnuu7I4DMCJfal9htrdGTRHtxO78N58CmqQ/ZNwqxqpcvhGaw4bDIFHK3my
         JB16Dfd5lUvwzSGBaRCMsb8LoeXMJYSeAAY+Z00qm+5UTN8w//5sDRcyWsjFUOhbd/cj
         JNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNUXGrsIBZA47dfMoUXlsA9DJrJBOE3oKFjyxYnaenU=;
        b=3J+XVNymWHJ8EvKgDJM5BtGz1Zbgd16uxvQzoCtD5RgaZo+heVSNxy+/RX6gbv8Fx9
         UBNSyIUM3OxaNIqdxrE1P2uEXwu2hTFpioQXc3LLHNPwCdgTkqZbXcnelP8CFOKVkAn+
         /kavpRMkeJVMElzHvUxQbU5G1wOpuFgvAm1eZhv0iIYEeL0nZxVuz3a3g/GnzhebZ49J
         tnEuxvJxvMFERrKdmPiFg1/pu3K1TepBRwuuielgW1FuTzZJ1Wi42MgILJynNX03zfA5
         HPFy7qSWJvntW5OjK6zF3jaCEXFysV7ekkeWdDez2bWgu10JD7MABf+nfntOGDBPCCgt
         uCjg==
X-Gm-Message-State: ANoB5pnSdybeD2d+15tjeS24ezzTPyniG3ZySy90LzAbkuYufsy5KULN
        VQa2tM7gEU6eSbKsm54Oj5PxBCYBwhPusg==
X-Google-Smtp-Source: AA0mqf6uRnzLyo9dICzT9GeeX+dMt5EDjesaWlPbClxP5VLoGdk1bLzL4z+dGg8HSw/qkX9amGKvIQ==
X-Received: by 2002:a17:902:a413:b0:186:8c19:d472 with SMTP id p19-20020a170902a41300b001868c19d472mr4073508plq.12.1668195190864;
        Fri, 11 Nov 2022 11:33:10 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id 77-20020a621750000000b0056baebf23e7sm1997392pfx.141.2022.11.11.11.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:33:10 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v6 03/26] bpf: Fix copy_map_value, zero_map_value
Date:   Sat, 12 Nov 2022 01:02:01 +0530
Message-Id: <20221111193224.876706-4-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193224.876706-1-memxor@gmail.com>
References: <20221111193224.876706-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622; i=memxor@gmail.com; h=from:subject; bh=6RvsvjttmdEULzDCNignBfVVDaAhe2Uld3KegARQNKU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbqInNLiBPyhOAGswnMZ++VCv2z7GCXT00P33PG8B xurXpGSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26iJwAKCRBM4MiGSL8Rys87D/ 9GctXmhqpuNtgRtUlWBLwU9GtcQqF+WdfNVTR7j+NmXVsRw+J/yVJfMSWbpfTZdcKGRiKYd3oJ+jEM Cv9SM5N6NRfVS4AsiO6vL46jOtRchtQWP2XXAxD/LYSMdu+BsBXK8rLcFhyJoeSU2b97rCkHLlIE9E kNK/N/C1XdfN4H+V28w60Mbq1H/0uAF+hgXM4n+tTCu//iDwWz4a88P3TRBryAhy4PAznAh39JHk+D pGqmHlFPCBD31eWkQ2eqBpvZCLEJIvu8vbJ04+ElNYfOwSxhnUQY3XYE9W5WN5qQHxQD5VI7gSbfl2 cR0am3l1gAQlgGF1Cp8Sx+saH0UXw6lQ7d5GBVMXAUvFiusZZAeZeNn0/BXaduAcjyr9ogkmyJJIM9 ZtEbM2fM/z07HEbNFrPiwZYD36UuekwmINHQlIXCl7wnPie1Tfbkc5CFXhvOjdb0X0Vr7A5pIXo7kM STL9+d/cIn0gESpP6j6LVE19XROUFk8kDmKWjfczTMk9yq68TFySyHgDKPyaly+evseE1w+nv2iRIP I817lALLYDwSaK48jVq7JRhniYBJ2QWDhKamPAJk56YFgm+imvuZFCBJ2nsziTSL1YANfjoy7X0nuu RxoQ4t6Mlp3Ct6ZrV6S62YGyg4+9RbuzDuEzfk8jMOAQD5Wwn2iwLVCkXnDg==
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

