Return-Path: <bpf+bounces-8049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B157807BC
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 11:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989A028233E
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 09:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6267617FE6;
	Fri, 18 Aug 2023 09:01:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259EE17FE1;
	Fri, 18 Aug 2023 09:01:56 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F9A4231;
	Fri, 18 Aug 2023 02:01:34 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bf1935f6c2so4881465ad.1;
        Fri, 18 Aug 2023 02:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692349289; x=1692954089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjo2nSusQS/qrdkLkrw+FknH/a8T5MRr2OaKIcA4HTI=;
        b=Brd/xnuWG/1z9EXVnSiXPFO1zhCbPYsomZyUCVXH95WIXO5xjBD/vTinLB1gKhfHVz
         G030SR2QZwT1djzrfevbRaehostrqXUdCMFJb4034ge448y+H9i3XjwvtBJA7YS1vFgA
         2BA43lktTZ9XlXLZfnT3m3obNpZTsiI3pIVjAFsxGVrB3D5jdfomWaDb4USdNVq3oNGh
         iCMIhSe0MxJ6YCWPIytITQCNHh/sqaBT4R4Yru17MyamNy7RppVk6z5v9Xh5yMSJTVC9
         4+5oHgXVSh0dwQdOrxypmzp1IIwBPxBNdw63uu/EzbCNBVyyvVlmXENqotQBElZ2ONLB
         ugbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692349289; x=1692954089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjo2nSusQS/qrdkLkrw+FknH/a8T5MRr2OaKIcA4HTI=;
        b=NGYGC1jzG7Hti2GJtl1de0tD6IM9gme7MqyUcHT+yeHHjjTyZ+2x+bRMx1oT6uQ3oY
         39+ry2IHvpsd5kjMthABrySE3XPveKzAsws+8ahvYCdZabzH0v/vEhhV1KuBNWW96OPQ
         29kDYJ3C4xK2US804OhqBe1KrgWLPJi0+kffzNUSnryIGnfStWR2XIqQsyXMaBp4C29T
         rMclJ+/IPkDwfbO7Po31Lbv7udf7XZykBpv115GDjz/S5m6PRVsN8976hIl69uceWDyU
         tyeENPcrS3E8E4/YRmivKY4g6c+hVy+rovswDVR7OWis0BF8r/V9JDZ3RTD0FEEqeKt9
         WDKA==
X-Gm-Message-State: AOJu0YyYdGaxPZU0W0KUGX/jG7PU7QQk4egPn/pUYVRRMp//U6Tl4wqF
	6T7ZuHPFtcjLiZQS2nakWw==
X-Google-Smtp-Source: AGHT+IFUcTs3CJWbj66sHsUFM0c/MihJ8cd7uzAWCLQoNe+q8frH0q5GpA1cBSeQkYMU0slJrIrMpA==
X-Received: by 2002:a17:903:186:b0:1bc:5e36:9ab4 with SMTP id z6-20020a170903018600b001bc5e369ab4mr2465679plg.21.1692349289368;
        Fri, 18 Aug 2023 02:01:29 -0700 (PDT)
Received: from dell-sscc.. ([114.71.48.94])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b001b89045ff03sm1217130plb.233.2023.08.18.02.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 02:01:29 -0700 (PDT)
From: "Daniel T. Lee" <danieltimlee@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [bpf-next 1/9] samples/bpf: fix warning with ignored-attributes
Date: Fri, 18 Aug 2023 18:01:11 +0900
Message-Id: <20230818090119.477441-2-danieltimlee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818090119.477441-1-danieltimlee@gmail.com>
References: <20230818090119.477441-1-danieltimlee@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, compiling the bpf programs will result the warning with the
ignored attribute as follows. This commit fixes the warning by adding
cf-protection option.

    In file included from ./arch/x86/include/asm/linkage.h:6:
    ./arch/x86/include/asm/ibt.h:77:8: warning: 'nocf_check' attribute ignored; use -fcf-protection to enable the attribute [-Wignored-attributes]
    extern __noendbr u64 ibt_save(bool disable);
           ^
    ./arch/x86/include/asm/ibt.h:32:34: note: expanded from macro '__noendbr'
                                       ^

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 595b98d825ce..b32cb8a62335 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -440,7 +440,7 @@ $(obj)/%.o: $(src)/%.c
 		-Wno-gnu-variable-sized-type-not-at-end \
 		-Wno-address-of-packed-member -Wno-tautological-compare \
 		-Wno-unknown-warning-option $(CLANG_ARCH_ARGS) \
-		-fno-asynchronous-unwind-tables \
+		-fno-asynchronous-unwind-tables -fcf-protection \
 		-I$(srctree)/samples/bpf/ -include asm_goto_workaround.h \
 		-O2 -emit-llvm -Xclang -disable-llvm-passes -c $< -o - | \
 		$(OPT) -O2 -mtriple=bpf-pc-linux | $(LLVM_DIS) | \
-- 
2.34.1


