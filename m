Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E20A0A9507
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2019 23:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfIDVXh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Sep 2019 17:23:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39556 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbfIDVXF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Sep 2019 17:23:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id j16so188934ljg.6
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2019 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1A0DTH8yoCPJNcxERaZ+ijIkUOQqqgHSIHaATGrPTFQ=;
        b=JxOWBX3K7ATM3R5k6qLko7irOYaDDp/EgE8lqfrCSuMD68Wxvfb5wgkZ5UbBXSNViD
         R37hhdMVyVTttgCsjHZkCQK2sZsQ/+mOjH2MmEnjoNubt0fsAOh+YGAb5XgJJ7CiMDVm
         Oj0dm134XL61kE1LH53qBXVlpjUIpWHL04VEkk0t0hzqmk6ihGiJu1fwZYv8qOnE/agN
         s0JL+ECqalNyE3mSNjOsv45sWpYK0MD9Xb5RhXGiwzcJlKmj7RfFCi0Mx8TMIsSEXmwf
         3pc3CzpYyw4n2l94LKGE5Ws0K3mJNjjYb6vSUrZ64UMhnFZ6v1EEzgCkPrikOTSfU4Kj
         g8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1A0DTH8yoCPJNcxERaZ+ijIkUOQqqgHSIHaATGrPTFQ=;
        b=TJxoZm4LonkcsOZBmSRWoCcIBjuiwrMlwWV1A5tJNh6IQXqNgL8LnR0WXdLcNI4Hh5
         JVfDIUVj9QInu45eIHYcGUj8m8vETfyTzeojSwju7/QEOkWxCEGfyywSL2bn702GYKB4
         JZKl2OGidYxszTins4tiCs/8rDA2eqxfwAjhvgT0n0FCP6jUtmYQy50Dx9+8Cis0UA49
         9YBBCZRwSPeNgNV27rNdedZR7/11FCNjFYVUPwtJz78vIFqTNnOJSOVJG4CQQ60eQyMl
         ldWozw9BFS7ggwb5VBDLRsv9SSBZKHprCwjK9DvmP0TWEJImV2td6jAN9roc/cvGsdOk
         z+KQ==
X-Gm-Message-State: APjAAAWGW9q6hMvnMUZedQU2Imw7R23/ewPjLyibqRl2HG1syxXbz55b
        8QhZJtv1YSvDZLrxA3bvnTFRtA==
X-Google-Smtp-Source: APXvYqwz4ndJZfXhBcpi8UvRZpCbYG9ilF+aaCsG3QbQJpYkccg1tFAjfOYCP6qU35rHpewQ9EUEDA==
X-Received: by 2002:a2e:7210:: with SMTP id n16mr14294364ljc.235.1567632183622;
        Wed, 04 Sep 2019 14:23:03 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id s8sm3540836ljd.94.2019.09.04.14.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 14:23:03 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 2/8] samples: bpf: Makefile: remove target for native build
Date:   Thu,  5 Sep 2019 00:22:06 +0300
Message-Id: <20190904212212.13052-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904212212.13052-1-ivan.khoronzhuk@linaro.org>
References: <20190904212212.13052-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

No need to set --target for native build, at least for arm, the
default target will be used anyway. In case of arm, for at least
clang 5 - 10 it causes error like:

clang: warning: unknown platform, assuming -mfloat-abi=soft
LLVM ERROR: Unsupported calling convention
make[2]: *** [/home/root/snapshot/samples/bpf/Makefile:299:
/home/root/snapshot/samples/bpf/sockex1_kern.o] Error 1

Only set to real triple helps: --target=arm-linux-gnueabihf
or just drop the target key to use default one. Decision to just
drop it and thus default target will be used (wich is native),
looks better.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 61b7394b811e..a2953357927e 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -197,8 +197,6 @@ BTF_PAHOLE ?= pahole
 ifdef CROSS_COMPILE
 HOSTCC = $(CROSS_COMPILE)gcc
 CLANG_ARCH_ARGS = --target=$(notdir $(CROSS_COMPILE:%-=%))
-else
-CLANG_ARCH_ARGS = -target $(ARCH)
 endif
 
 # Don't evaluate probes and warnings if we need to run make recursively
-- 
2.17.1

