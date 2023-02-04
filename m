Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0F568ABD7
	for <lists+bpf@lfdr.de>; Sat,  4 Feb 2023 19:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjBDScz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Feb 2023 13:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjBDScy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Feb 2023 13:32:54 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4DC305E6
        for <bpf@vger.kernel.org>; Sat,  4 Feb 2023 10:32:48 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id h15so984105plk.12
        for <bpf@vger.kernel.org>; Sat, 04 Feb 2023 10:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hWXqY6vkS6h8Vyi+cCa2wgxLlkbcE67+3y3A1NRgkP0=;
        b=LExrl+KFcVf2/FYhWCQdYF32QGdh5UXA4AmcX728sSl4odYnnjrrZq16jx3MvQzFcv
         dQ1H3oGKuIHaSgHT0VSFNVp+YJPAZdUO3p+/taza+s0XIXj0/FP1/7id8OINHB/DuB7T
         W7YTVEPmQomTURqo0D25gEVKpsdipmXEZZJqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWXqY6vkS6h8Vyi+cCa2wgxLlkbcE67+3y3A1NRgkP0=;
        b=VTH4Sa9/ApOURix7IrOvpYMQ/qf8qO5ewmdPjB12tXgtMGSAOfXOMxZpPsgxRgIYkv
         f1kfmIyGph42NudLE255PhzUxekL6KRtlaSh1JWvGVekViFfCEXyrJKQap7rRAnUSsqP
         0ZqPF64OoxmZaLgMpCQunrn/om9q2p9gLQocaf9e6GEkueQsBukis6UWI5vEDyznyUIJ
         01znLnGyNG8iCSKgrrXAL6KoO0SF82/Dn40OE/MizfuVQbMedQaSNIxTd8Kcdd3bATs2
         7FROkNP7qswcdXwH2Jh4t8GMGtcunzqRc2RemM185reOTkYyTnVEO1cRPJkBrgZ5Zypm
         YFNw==
X-Gm-Message-State: AO0yUKWtv6kXUGubtOqYiiePwI19NI1Up91FgsOppI9kphbp0e/U29XC
        JHytJKFTuvUxWZZgriewkk7hNw==
X-Google-Smtp-Source: AK7set8ndlru/LQXkvkAKjSEdQnGbFpts6hOxMVbgJ2BfEljDsnEQJjCuV1dzvs6hCZvsRjEvrk7gQ==
X-Received: by 2002:a17:902:e0cd:b0:194:457d:6dca with SMTP id e13-20020a170902e0cd00b00194457d6dcamr11858096pla.44.1675535567229;
        Sat, 04 Feb 2023 10:32:47 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g21-20020a170902869500b00194a297cb8esm2109672plo.191.2023.02.04.10.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 10:32:46 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] bpf: Replace bpf_lpm_trie_key 0-length array with flexible array
Date:   Sat,  4 Feb 2023 10:32:44 -0800
Message-Id: <20230204183241.never.481-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3245; h=from:subject:message-id; bh=8UjW+Zy+1y3cIspI89jzw8FmWvL6uos84uq4mMimB0Q=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj3qTM1ht5vMIp0wFAnwtKlrGMR52OBqU2d1wGvknh p4xzmaKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY96kzAAKCRCJcvTf3G3AJvgYD/ 4gbPMJvXXbsBmYsUpuJKym76FsMyPeVmqDsr9eazRsJPrXYT/Cjf+wXXotjT1IukgBmNxSVbq3FsyI jnPq041qMY/zMM3NYurX38M6lIf9VeD7IPwUlsQrDpMOf3RYYrOA/WOCuFbfqW8FvgyQCGRAtW95Jb lW1DpWFeXkiMxxqtJhD7QS04V8887YQ0DkXwbM/t8JVaKudE9LMgVvTxcimzGPC1eBClzkIlw+5L2/ 2Tz50uOg1PRSd6F9LP0m56P3WtX2+0OMRTFg03CMcNcpHYOSQRpkRac8CZG2qRwtiHxVnj0ekeMAj2 c5+8xwXst7vWDPbVucMDYmX5s2JdpD3Qq+M8OWMFzLuHwgLWYevblaB4pF/35yTCbEnT00bS7rEDtI 8fNBCG558+bobc540bAFf4N8wEPwO+GvG2OsBpZWEBQpGoNaAOJywnklLtZgbDyVWuHsGTabmFLqK9 7Osq6wT3O4Z6+vMUvmIJOJnrvi2hPumoSbm0ihHeKhi1HLCVFQs7xgtRVWOOiTtIZTFmVL+Fm79Q+4 tfEMfE6U827t/hEy7qdSFawVFyO8QibSjlvSTDM2/mTRtW5CEHE9plbSRbEcIPVYftHWqn9tBzLWBO aPMvVw8tolEP/BXWNuXMvFT7TAgaVWSiLkd7jpuUNQAdCP85KusshqzXrVsQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace deprecated 0-length array in struct bpf_lpm_trie_key with
flexible array. Found with GCC 13:

../kernel/bpf/lpm_trie.c:207:51: warning: array subscript i is outside array bounds of 'const __u8[0]' {aka 'const unsigned char[]'} [-Warray-bounds=]
  207 |                                        *(__be16 *)&key->data[i]);
      |                                                   ^~~~~~~~~~~~~
../include/uapi/linux/swab.h:102:54: note: in definition of macro '__swab16'
  102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
      |                                                      ^
../include/linux/byteorder/generic.h:97:21: note: in expansion of macro '__be16_to_cpu'
   97 | #define be16_to_cpu __be16_to_cpu
      |                     ^~~~~~~~~~~~~
../kernel/bpf/lpm_trie.c:206:28: note: in expansion of macro 'be16_to_cpu'
  206 |                 u16 diff = be16_to_cpu(*(__be16 *)&node->data[i]
^
      |                            ^~~~~~~~~~~
In file included from ../include/linux/bpf.h:7:
../include/uapi/linux/bpf.h:82:17: note: while referencing 'data'
   82 |         __u8    data[0];        /* Arbitrary size */
      |                 ^~~~

This includes fixing the selftest which was incorrectly using a
variable length struct as a header, identified earlier[1]. Avoid this
by just explicitly including the prefixlen member instead of struct
bpf_lpm_trie_key.

[1] https://lore.kernel.org/all/202206281009.4332AA33@keescook/

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mykola Lysenko <mykolal@fb.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Haowen Bai <baihaowen@meizu.com>
Cc: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/uapi/linux/bpf.h                         | 2 +-
 tools/testing/selftests/bpf/progs/map_ptr_kern.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ba0f0cfb5e42..5930bc5c7e2c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -79,7 +79,7 @@ struct bpf_insn {
 /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
 struct bpf_lpm_trie_key {
 	__u32	prefixlen;	/* up to 32 for AF_INET, 128 for AF_INET6 */
-	__u8	data[0];	/* Arbitrary size */
+	__u8	data[];		/* Arbitrary size */
 };
 
 struct bpf_cgroup_storage_key {
diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
index db388f593d0a..543012deb349 100644
--- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -311,7 +311,7 @@ struct lpm_trie {
 } __attribute__((preserve_access_index));
 
 struct lpm_key {
-	struct bpf_lpm_trie_key trie_key;
+	__u32 prefixlen;
 	__u32 data;
 };
 
-- 
2.34.1

