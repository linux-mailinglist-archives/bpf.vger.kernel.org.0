Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C884913D352
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 05:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgAPE7Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jan 2020 23:59:24 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:46015 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbgAPE7X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jan 2020 23:59:23 -0500
Received: by mail-pf1-f201.google.com with SMTP id x21so12310889pfp.12
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2020 20:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Yujd7NYO/Gpv5hGCan+Hwvd6fcY54ztoBNLrmT1puBg=;
        b=nTEBofKCmnS3/2Efie7j4FZM7iYpE9k7Y1Z9TsJLPzuhnrp5h87vi8ctGlA2+HfJAl
         opiTgWmaY7DX0H/+B1r6K6Tg64BvXYhhD+ShVHVdU0vIj7oMvLT5OPdIBFqk1wtlkG4b
         G0eiPMDFBf8NZsdmCdkSL8vw80EVcjJfeGLKpid+7f0y/zZTbcAgZ9y5ibio3uXvSI46
         jyoeSWHvjVLfTKMUipCNT2kCx97J5p9Rcr8QXZIVRCEitkKtbEs9qjMvvVJO/p2d0rwc
         ldkk6YdzhMKWycWNdoaaVP8O6REhdqAYPhUL9WJaRLMLfdb7/Zwu2VS3l4VQXmxB9JH4
         QvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Yujd7NYO/Gpv5hGCan+Hwvd6fcY54ztoBNLrmT1puBg=;
        b=Cstqx6dQ7g0Asbued2ULMaiphZBQEZpLXB/xZZItkzfCNKADIoFUsQhglE3ELIoDr8
         EvfaQqOCRnKQynnKWUuFOAcEcHUKKdIkWVId15aEodCMxDWuRM9+YM6BdV4w6Q97v9I7
         U7KCF0lZA2aEXwhWpdVBxZc+T7QEe2mm0BZvl8cmerjPlPLunNf0Qblf3i2od4rB0Nfu
         c6LKdshv5EZpXZpYbyg5SiNsQ3JBckQt80fObHTasS2k7iWD3E3V1HpN+w3JcTEobL12
         BZMH6qzeZXDv9OAHJZ4IV7MOqndh2Hb7/byohckmdRusSLTkMnOVCFN/1sa53isrr6Os
         mrzQ==
X-Gm-Message-State: APjAAAW7Vu5kn7PnKNNAcOde+P3gwE22ygUtqWwbXwplkN6lVyf8+muJ
        sHYS8+va8mZURIKvzn/w5X5ybOr2KygV
X-Google-Smtp-Source: APXvYqztiY0Q4ZmmaSQYCImVDBFiPoKpJXtaMUoBTv6utaLXpsOu5sO8VaU8H9zbSEU0+Q8RUA3PyWHvcwVI
X-Received: by 2002:a65:48cb:: with SMTP id o11mr37361408pgs.313.1579150763148;
 Wed, 15 Jan 2020 20:59:23 -0800 (PST)
Date:   Wed, 15 Jan 2020 20:59:18 -0800
Message-Id: <20200116045918.75597-1-brianvv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH bpf-next] libbpf: Fix unneeded extra initialization in bpf_map_batch_common
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_attr doesn't required to be declared with '= {}' as memset is used
in the code.

Fixes: 2ab3d86ea1859 ("libbpf: Add libbpf support to batch ops")
Reported-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 tools/lib/bpf/bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 317727d612149..ed42b006533c4 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -457,7 +457,7 @@ static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
 				__u32 *count,
 				const struct bpf_map_batch_opts *opts)
 {
-	union bpf_attr attr = {};
+	union bpf_attr attr;
 	int ret;
 
 	if (!OPTS_VALID(opts, bpf_map_batch_opts))
-- 
2.25.0.rc1.283.g88dfdc4193-goog

