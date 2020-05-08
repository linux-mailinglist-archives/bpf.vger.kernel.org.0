Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C818A1CA42E
	for <lists+bpf@lfdr.de>; Fri,  8 May 2020 08:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgEHGj7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 May 2020 02:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726873AbgEHGj6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 May 2020 02:39:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78515C05BD0A
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 23:39:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 186so986679ybq.1
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 23:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JqKocGa5cimql1fp4DS+xPXwrVZ2Z2hJEVO/fiKh20k=;
        b=LSasER3WBqtfBg/bGE3PeVOf3C1Dim6JBLIEgeU3rioM9+MNBKorVZ4wLEoKOWeVEB
         WVpX2iRLeOoAaTH5FU79u0hIMkOIFUHESFKAB1oxCjCgjRvmMdaxTMqaBOwQHVR2u8SD
         YZHIpK0wPVJW+tg5pO++cjzhWrun5K+JyrZzWt5wXl2Y8cto4/QGzWXb3Z/TQ/PXtNRg
         qgUSdqGjHPbW9fg5ueq6bMEwFbpewcbkDB66XY25g0+h47IYWDzeNld91gofqSW4vQkh
         JGmHEsw+wh2w1youzj1UIYZYEk5FplV54amOTaCJkWNEEuH/6+HkYRwNtBmntewVUL2F
         WsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JqKocGa5cimql1fp4DS+xPXwrVZ2Z2hJEVO/fiKh20k=;
        b=EsfQVNfcl0aHjxu4ZqYJ2HWtXUFDt3xZQrFcqO8r5L/cXM8tT4ZR4irpGQ8RQG2kTX
         lb0Lv1sxoMpiz9XPjZHt3uU+e55Nb26C1m9LRSngyewVjjDCepQzef3mToNUP8UHuC5s
         lhui+TVoxnbyCwd+nmqgWTOjg3jIXAJuhpdQ/av3Ei982iCRhbhsrQ3aNjyYkD7R0KXJ
         hJjtSLtvh9pqKvBZaxnVq9XRfPN0L6YRFEE1gXplCn9iOaZ1jKgQLLMecdqEpz7h+DSz
         lMYClbsRjH3UtwrbvV89JZQu8JL73D/kqTvNvh5TMwe3OG4Q7ueE7xRhEEPULyRxkamr
         7X2Q==
X-Gm-Message-State: AGi0PuZAziui2tFcQSEhAc6J2h7BRzZh6/yDx4LJLUmJJJw9dtw/5cVw
        +Yefa0Hc8Dz+q/Qjg2c2Rp+qM6xlyNaW
X-Google-Smtp-Source: APiQypIzG335LQcvib+amwZBO3RBTIJWyEl0ag5FnTDtNK3nU2gmInNWeH2R0b+Fk2aSWTZl0MrQJhBzEET6
X-Received: by 2002:a25:dbd2:: with SMTP id g201mr2328607ybf.17.1588919997600;
 Thu, 07 May 2020 23:39:57 -0700 (PDT)
Date:   Thu,  7 May 2020 23:39:54 -0700
Message-Id: <20200508063954.256593-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH] libbpf hashmap: fix undefined behavior in hash_bits
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If bits is 0, the case when the map is empty, then the >> is the size of
the register which is undefined behavior - on x86 it is the same as a
shift by 0. Fix by handling the 0 case explicitly.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/hashmap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index d5ef212a55ba..781db653d16c 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -19,6 +19,8 @@
 static inline size_t hash_bits(size_t h, int bits)
 {
 	/* shuffle bits and return requested number of upper bits */
+	if (bits == 0)
+		return 0;
 	return (h * 11400714819323198485llu) >> (__WORDSIZE - bits);
 }
 
-- 
2.26.2.645.ge9eca65c58-goog

