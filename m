Return-Path: <bpf+bounces-4276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9AA74A1B3
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 18:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C716628135C
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 16:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCB1AD41;
	Thu,  6 Jul 2023 16:00:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B9F8C17
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 16:00:13 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56661BEA
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 09:00:10 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso675140a12.1
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688659210; x=1691251210;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cX9kKxYIJv3ip+bm10ugdsP4ZscSU1mpF0YvzC6xnuo=;
        b=rQG6cR+PnkCS515HPL1UmtBIv6ie8WEoW01eti3dVLLSFt/0WAOYUmxuyGn0EGpE1C
         wHBQUjLOE6fKQWD7Lt/z8noWVWXiQs2UDXnRMbxw7LSxX/vWgUSi6ZPp1Hp71UUtkfQ5
         FErGt1+Tqy8dYNvnAiWLu4uc7NLawBPjl/9GBAIOwYgiX3xaf9GHuV6gU8piNn9FcGpj
         DDBYvk46oMpkEE+deY9FYAzA1OIL1SB1dwroVCauMxzs9Dnkf5OEwEOeBoDbOeVHEseE
         mOFWQtial0EFpSX/x6fILrfhhKsXelWEnPO5uTb3n6WwKrwpxOPaSuuH9OyEH2nLe8Iv
         kTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688659210; x=1691251210;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cX9kKxYIJv3ip+bm10ugdsP4ZscSU1mpF0YvzC6xnuo=;
        b=erTVncMTqR7Sz/qcFqBxPYMChpnWnfdCJ1XroQ4HtsyekTEVAS1DkFKJGcXdH6gaJI
         lyxu0xH/vw7p25OEXvjUlczgRffLuKLZtZ/6q8giYGKx7EQU9L4R9fk0KcJPHF5mox7W
         D94Es/hZ2CIuF7GcZ1qZEbvwxDRgXOmwULLkiZHLNsOOX1sS4bUFY3K2Pcck51xtRa4F
         Rh6/IAMOr5OYOwaSGWnERni058uVzgUfoq7ejL7+Tzp5/hcMw8xcAAOWTNYTIe2GBa1U
         ctwB1980edKu62ZAulHRWVVuJPhU41pNWQSmfBA0Tppr5U2FuBEtzIIT+bouaTBeCOg2
         DHVg==
X-Gm-Message-State: ABy/qLa4PuPkl0GRYxkV+rhXYPRjrgULvB8V0fRVcS4++Un6YPAeQ/K6
	Ob6pfK74Pu7ksrA2pCeoSB8E4sdjEvfTTduS
X-Google-Smtp-Source: APBJJlGqOX0uDpBiQab5K5TMuWuJwxSg0c7QOS7sIecNBCGIIn7JdIlWhRDfnT/EgC6ONYqoY5LZlg==
X-Received: by 2002:a05:6a20:244e:b0:130:6b27:729f with SMTP id t14-20020a056a20244e00b001306b27729fmr590616pzc.3.1688659209743;
        Thu, 06 Jul 2023 09:00:09 -0700 (PDT)
Received: from [192.168.1.9] ([14.238.228.104])
        by smtp.gmail.com with ESMTPSA id ey2-20020a056a0038c200b006828a3c259fsm1464537pfb.104.2023.07.06.09.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 09:00:09 -0700 (PDT)
Message-ID: <bd1477f2-a51e-a795-4f25-a32d6ab46530@gmail.com>
Date: Thu, 6 Jul 2023 23:00:06 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev,
 linux-kernel-mentees@lists.linuxfoundation.org
From: Anh Tuan Phan <tuananhlfc@gmail.com>
Subject: [PATCH v2] samples/bpf: Add more instructions to build dependencies
 and, configuration in README.rst
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Update the Documentation to mention that some samples require pahole
v1.16 and kernel built with CONFIG_DEBUG_INFO_BTF=y

Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
---
 samples/bpf/README.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
index 57f93edd1957..631592b83d60 100644
--- a/samples/bpf/README.rst
+++ b/samples/bpf/README.rst
@@ -14,6 +14,9 @@ Compiling requires having installed:
 Note that LLVM's tool 'llc' must support target 'bpf', list version
 and supported targets with command: ``llc --version``

+Some samples require pahole version 1.16 as a dependency. See
+https://docs.kernel.org/bpf/bpf_devel_QA.html for reference.
+
 Clean and configuration
 -----------------------

@@ -28,6 +31,10 @@ Configure kernel, defconfig for instance::

  make defconfig

+Some samples require support for BPF Type Format (BTF). To enable it,
open the
+generated config file, or use menuconfig (by "make menuconfig") to
enable the
+following configs: CONFIG_BPF_SYSCALL and CONFIG_DEBUG_INFO_BTF.
+
 Kernel headers
 --------------

-- 
2.34.1

