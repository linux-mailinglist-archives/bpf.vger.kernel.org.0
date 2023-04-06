Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFC36D8C13
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 02:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjDFAlB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 20:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbjDFAkw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 20:40:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933506A7A
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 17:40:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54bfc4e0330so23275847b3.3
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 17:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680741645;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x8R/SEDfqF4QrtFeRx/u2abN72cLJ7gQ42FhuO/V5K0=;
        b=famZmD8e73CVngP4c6cGtRK/a9wp8f3PKrJd3hm4RoeMJ7uCVI+lLTqZy9uQB6sPmm
         7nFVvQtrMzfDVr1l0lenai6wPn7yUxplL8YjKjtqDJmhmIQ2byK+ArCjWWNK+p5Hzl+Y
         MMlOasgm7PWGb2d6UCF0raqEa63assoqaILb9vd2uYNs4XALzjf9lMoSr0PeZNgQh1Df
         O1nfKPxUvPy/ClQJQDq9nKsS3VEc7dGyfn1pLjrJX8zUD6J5/GXVyha9MJgu6jjIQZ/p
         OLzqbWeXt6O9M0aEkOW7pvyhlo0WMdugK2azwqs56sPj/ED+WmwibsF8+2VR8mUvhZSM
         7p+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680741645;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8R/SEDfqF4QrtFeRx/u2abN72cLJ7gQ42FhuO/V5K0=;
        b=ZNTp2PjJ1T4GOmlU7h8IR3r55Cevie/QBS9pyRM3mRDDvkKxoNcva+DmUnA20p49v3
         Qa5usEfnErBMFD0h5ddtIffJm0HOF0YkvOITGgj6IeWs/vqQlh/Nfjq6Od3pNINeKf1X
         6O97UUaMEYABc9wDxyW8wnJv89wrzks1/MS+yH3EJ8p1Z+J6bG8yy3rE/ICoxbyXx3+u
         dLaXlLRMDvdcmBZOF6ZLMdCb8glXp8vddw+L/z9kaq6PVcdpjNw/u2ApsD3jZnF22Xon
         f2/yD2eXAxVacd4QGtEtds7wWmFBHkfh/LYxNdKOtYXykTiMKruBjkmQ8156lYzXWuXs
         KfFQ==
X-Gm-Message-State: AAQBX9fdlfQXF/uoCc377H0EakxaQ757pT0OYO12ugy1Eybl8pDR0ryu
        GzHz9ludUWzOOf4nS2ed3nwV0k02RcuCwa412TTIT3kTpwM2nH20+Suot4O+ZGDD6gme7CAkE6f
        XHiD7JXxWhZfXrAy8W4VuyP5JhhY760TNzQB2km/ZKo21nrkZhJuWQHJ4kw==
X-Google-Smtp-Source: AKy350Y+if23WZgYEhMrSezh2kGa1/V3dBjppuEeSCDz5TpXpURFDSDF0HvuDxVTPEWFxq3wS4lP9CWr3/Q=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:694f:f21b:c6de:aead])
 (user=drosen job=sendgmr) by 2002:a25:d4c7:0:b0:b76:126b:5aa1 with SMTP id
 m190-20020a25d4c7000000b00b76126b5aa1mr715873ybf.8.1680741644750; Wed, 05 Apr
 2023 17:40:44 -0700 (PDT)
Date:   Wed,  5 Apr 2023 17:40:18 -0700
In-Reply-To: <20230406004018.1439952-1-drosen@google.com>
Mime-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230406004018.1439952-4-drosen@google.com>
Subject: [PATCH 3/3] selftests/bpf: Test allowing NULL buffer in dynptr slice
From:   Daniel Rosenberg <drosen@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_dynptr_slice(_rw) no longer requires a buffer for verification. If the
buffer is needed, but not present, the function will return NULL.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c |  1 +
 .../selftests/bpf/progs/dynptr_success.c      | 21 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index d176c34a7d2e..db22cad32657 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -20,6 +20,7 @@ static struct {
 	{"test_ringbuf", SETUP_SYSCALL_SLEEP},
 	{"test_skb_readonly", SETUP_SKB_PROG},
 	{"test_dynptr_skb_data", SETUP_SKB_PROG},
+	{"test_dynptr_skb_nobuff", SETUP_SKB_PROG},
 };
 
 static void verify_success(const char *prog_name, enum test_setup_type setup_type)
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index b2fa6c47ecc0..a059ed8d4590 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -207,3 +207,24 @@ int test_dynptr_skb_data(struct __sk_buff *skb)
 
 	return 1;
 }
+
+SEC("?cgroup_skb/egress")
+int test_dynptr_skb_no_buff(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	__u64 *data;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr)) {
+		err = 1;
+		return 1;
+	}
+
+	/* This should return NULL. SKB may require a buffer */
+	data = bpf_dynptr_slice(&ptr, 0, NULL, 1);
+	if (data) {
+		err = 2;
+		return 1;
+	}
+
+	return 1;
+}
-- 
2.40.0.577.gac1e443424-goog

