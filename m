Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3264377AC
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 15:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhJVNJ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 09:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhJVNJZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 09:09:25 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F547C061764
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 06:07:08 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s1so2628610plg.12
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 06:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9JDK/zYHBPlI7UN5orEe5bbjb6f6AAf+xpyZzZCD7Io=;
        b=LY/bKfHK/8i3Tw4n9u2QopM9G9kCzpXmOndj57iWgpsSAptEGlpDoCV15zfbcKSVzq
         EiWanrJmI1XdEUj5Yas0fI7BKR6uZrFm1wmQsXFB2TV8eD+3BH2cljq5akb1LhMepO28
         gTWIwIpgZyD1QzNIqqvjvbMVzgJ/fc1MW0ErtcFoAVdpRI/y6WCDTy9zU8IvhpsGlhu+
         UKig3tl6nWCN+k2ZoiiKoFdAaLtkhocM4etY4wb5/NoRiusHGJG1nUymWRp4//o9rqUI
         PUHjbArefgHKapkJtNSwdOLjmAXj0OHB+sqV2vRHR+hU2egx0vC9JmnJNh2juMILDlrk
         jmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9JDK/zYHBPlI7UN5orEe5bbjb6f6AAf+xpyZzZCD7Io=;
        b=3Qgvz6AyRK07+/KqTRvvbvUgZFrjQbiYAk9ge+6JjBPZJOprKmiZ/3NjKpXLigJIjB
         YOQJguD4J4zEauwC8R1g7ub3e+/5LsmAyUc+s1YKNghmz4LWN/pkOBkYHlU9AWrsfMXk
         EZZ/VYLRIzwtnu4VUFe7A6gw78vZGHyCgKKkBK7FKXx/AGNTsd9+XK3YOOfDXll8mur+
         apznJlQFBoxbJJBOCnZQ4m397/iFmSnBaHnH8w/zYicIxteagKqZ4T6cJwHVFBzkmJnP
         phUwLxTYGstq7Zsw8RxcAlLySk6BAdICH2IM/8xS3rA+63eRfdM4X/d6XJAOCE6GqGrJ
         PIIg==
X-Gm-Message-State: AOAM530uHNB2EtRmLiEbb+77kIvXLwF8JZrJgBRivM7p1I5HscrtRXW+
        5qHnLqX8BBx869vklUAIlAmWyyA3lYj/gg==
X-Google-Smtp-Source: ABdhPJwoZOMY1f3HYDcJjTyzBxrT0HSVAZgkD/WrAx11dYE9wsg+WzZ2/q7IuC1qbQaPKOQ28uJkQw==
X-Received: by 2002:a17:90b:4a05:: with SMTP id kk5mr14469842pjb.25.1634908027827;
        Fri, 22 Oct 2021 06:07:07 -0700 (PDT)
Received: from VM-32-4-ubuntu.. ([43.132.164.184])
        by smtp.gmail.com with ESMTPSA id k22sm9632083pfi.149.2021.10.22.06.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 06:07:07 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kafai@fb.com,
        songliubraving@fb.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 2/5 v2] perf bpf: Switch to new btf__raw_data API
Date:   Fri, 22 Oct 2021 21:06:20 +0800
Message-Id: <20211022130623.1548429-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211022130623.1548429-1-hengqi.chen@gmail.com>
References: <20211022130623.1548429-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace the call to btf__get_raw_data with new API btf__raw_data.
The old APIs will be deprecated in libbpf v0.7+. No functionality
change.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/perf/util/bpf-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 1a7112a87736..388847bab6d9 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -110,7 +110,7 @@ static int perf_env__fetch_btf(struct perf_env *env,
 	u32 data_size;
 	const void *data;

-	data = btf__get_raw_data(btf, &data_size);
+	data = btf__raw_data(btf, &data_size);

 	node = malloc(data_size + sizeof(struct btf_node));
 	if (!node)
--
2.30.2
