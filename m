Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BA72A815A
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 15:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbgKEOs4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 09:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbgKEOsD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 09:48:03 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB60C0613D3
        for <bpf@vger.kernel.org>; Thu,  5 Nov 2020 06:48:02 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id a71so1806828edf.9
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 06:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GQFn82EPSsaqSkZSdg3eEn7h3cPHKXwNy46wDlBGgtk=;
        b=oQcRddVMRJFOjATM6MFwc4nJOoyW+a++30WPkcrnHX594tciMfISGFGm9sMvXrYorW
         EMeFOUfX71GNUwbOWUZNzzJwYLRzTqR2IoLq0h5N3jB+qgZnmB9GAHWhjMCDGyBRf4D3
         mg5AGNUGO950l6npW3WU+8DLsCEcZz7iOm8bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GQFn82EPSsaqSkZSdg3eEn7h3cPHKXwNy46wDlBGgtk=;
        b=V39oA1JzixOpL61FKE9EwRKBB6chmLTOm/9lweiFIyCfLLRjQzzGu8YlHmHTu3P5fn
         Rpn7r/gZ7aKTztAE5Fc83ziEyAixUMoL1zZx2MBxpdmNMEeU0bYJ3vaaMYI9noFdWn80
         PDqClmzC3Dv8QBYbdu0RbcmWjnPiyCeiGDb1eDqzaxatPHsVG6Mi054IeYwQL4/nsx/Q
         zfYbPk3GjnK358wO5P8Q3paKmnF+nlKN2c8dndzZQswMuBgUbsIH7puITZegJAsUgrVd
         Aj8JyVMpXGw0rK/K/AtM/AqTfWt2PbBp4a8JX4wQLVpHwx782LPH6huiqp1qjS2YMM+B
         J1og==
X-Gm-Message-State: AOAM5304llzXhalGAb/UaBOkJ0v4izpWSxrMyft9MlY3rUVUdcUbueTS
        0W6/Q7El7L7PiUt6L2/BM5x/gw==
X-Google-Smtp-Source: ABdhPJwR5NxI5a1T36gRGzzhawPU7W7lfWCHKRan+Hz7xfdifuIJgsGKCAygMvL7UdVUwqc9G7fMGA==
X-Received: by 2002:a50:ec10:: with SMTP id g16mr2578622edr.63.1604587681408;
        Thu, 05 Nov 2020 06:48:01 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id z13sm1075870ejp.30.2020.11.05.06.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:48:00 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v4 3/9] libbpf: Add support for task local storage
Date:   Thu,  5 Nov 2020 15:47:49 +0100
Message-Id: <20201105144755.214341-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201105144755.214341-1-kpsingh@chromium.org>
References: <20201105144755.214341-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Updates the bpf_probe_map_type API to also support
BPF_MAP_TYPE_TASK_STORAGE similar to other local storage maps.

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/lib/bpf/libbpf_probes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 5482a9b7ae2d..ecaae2927ab8 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -230,6 +230,7 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 		break;
 	case BPF_MAP_TYPE_SK_STORAGE:
 	case BPF_MAP_TYPE_INODE_STORAGE:
+	case BPF_MAP_TYPE_TASK_STORAGE:
 		btf_key_type_id = 1;
 		btf_value_type_id = 3;
 		value_size = 8;
-- 
2.29.1.341.ge80a0c044ae-goog

