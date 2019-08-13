Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C8D8BE7B
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2019 18:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbfHMQ0m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Aug 2019 12:26:42 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:54512 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbfHMQ0m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Aug 2019 12:26:42 -0400
Received: by mail-qk1-f202.google.com with SMTP id x28so20241754qki.21
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2019 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zozR5939lKPKijWCEA8Kq+6lgaUz4pI7IwG97p6anoI=;
        b=rpsx3xRYVUo+8HMvYoICPBFAyFKy5wRht98LRjh5rGDHDDbKCzC3HGAaPi7p6hqlXH
         lh0rVvIj2OXHnsTJVWY5YwDHTySHAn+3gyj7Qxar7uE7GHeOlN6DhjKWHM/HSHk0lFyQ
         q0k+G/HMWGAtS/90q8+LlymY26SZ3V6zkkz8hIXbrpzLJT2SwVO9nXj3qLmtITOs5gbs
         l9qqBCTjUt7RgE/YzCHJsKmRK/TEahNqkVI9y9lBaStdRo+6rYjUWF1zZI/GIb5yTXN0
         0VNWHnDqiYxDYiwbV0BGIXYUBUmpmWCv6WfwUUVCKY9GsfYMk3PSdkkLlejGjQYzfEKa
         9ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zozR5939lKPKijWCEA8Kq+6lgaUz4pI7IwG97p6anoI=;
        b=Ei7JEP1KBAhNuse5yv91g9MqXGj7BvbT6ljMs7yC1dMseOiDH1SuVZtqV275qYzKGU
         tdvIRVtn9ATINVEXnBe0LrKl/WaRvP1RkgA9U2Bpq0dIhk0E58Naq+qcOZoTqDe3d21E
         vy3rRhOwCkpvjh07COixTb7AYiNvutxa7Xwb4KOgM+/a+PsMgFSyJVr7LYh1pol9lI3h
         rpaTLBtz884eUagf/gPXPS2V0tJMbRYUIzadL6DdBo8vo0tsFDMKZ04YkzkJwKwg1PaW
         bpeC8OkKsqXWM2eoJ7NuAA9AE+JpxbRQEoLalECW2IdiKwPezsH7SDvwpyMWcl6UknYG
         FQgQ==
X-Gm-Message-State: APjAAAUWYOKhjb9o4Xw/zgO4TWXG/MAftTHobMeRbSoZdWAFbz14gxiA
        1KA04MA9Qr4BNRzY1uO/EWEJ5BM=
X-Google-Smtp-Source: APXvYqxJeV6yuWOLi+YQW1QrHpDnaztuvF20TBnRsYyMb4VqZvgP2fwvJ6ubzBX0ekymaJzEdSrUklc=
X-Received: by 2002:a0c:f88b:: with SMTP id u11mr8947436qvn.99.1565713601043;
 Tue, 13 Aug 2019 09:26:41 -0700 (PDT)
Date:   Tue, 13 Aug 2019 09:26:29 -0700
In-Reply-To: <20190813162630.124544-1-sdf@google.com>
Message-Id: <20190813162630.124544-4-sdf@google.com>
Mime-Version: 1.0
References: <20190813162630.124544-1-sdf@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH bpf-next v3 3/4] bpf: sync bpf.h to tools/
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sync new sk storage clone flag.

Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/include/uapi/linux/bpf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4393bd4b2419..0ef594ac3899 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -337,6 +337,9 @@ enum bpf_attach_type {
 #define BPF_F_RDONLY_PROG	(1U << 7)
 #define BPF_F_WRONLY_PROG	(1U << 8)
 
+/* Clone map from listener for newly accepted socket */
+#define BPF_F_CLONE		(1U << 9)
+
 /* flags for BPF_PROG_QUERY */
 #define BPF_F_QUERY_EFFECTIVE	(1U << 0)
 
-- 
2.23.0.rc1.153.gdeed80330f-goog

