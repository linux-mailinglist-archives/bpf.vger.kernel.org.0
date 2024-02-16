Return-Path: <bpf+bounces-22193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06329858A6D
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 01:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711231F21516
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 00:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FB414C5B1;
	Fri, 16 Feb 2024 23:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VQCtYCr/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C97154441
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127747; cv=none; b=hJKqKswMLBBuQWrvXNiTR/CMW0J2OpfpTTGbeBI1pSDds7swn2mTowf2Z+4hJlIiPcoSj4c6yXAlwfJhUUFOOsFBQxG8EeTNy8k9UerFfCURoM33bWFkYs4z1gy91fFDUTr/s0wUrFbld29PXa0Mk0aTAkaXSvz5neRDCoGOPOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127747; c=relaxed/simple;
	bh=4OucJmNe1/pNjupONQadff5J4lun4ayJWUXyyzw61w8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=krjPliP3jPkbddWytiWTci3ryX0rEtkl2nx1UOocgdyj92LPL7Tyq4PS/ica6xVk8wG6tYH3HGpVcFOz1dTvvp98Nc9zleaYU5kRFOOthpT+b37IIEjEp7o/xgKzyT7Zzx+OBGsvFph6/LOT9iVjM8vz4Ype4KYXKm/2uvz1n6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VQCtYCr/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6da9c834646so2377595b3a.3
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 15:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708127743; x=1708732543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rUDkEiOEm4wZFWkz9cLvzAsbKQOJPsyUHuSB+y80Mkk=;
        b=VQCtYCr/+ts5IGN30TRG5SvBOqUyUZrUebrY5VZC5UYDCsfaMgpa/3qM9YoBXxTx3U
         Gc9AUYF5vVlvdREE3lVmWZ3yJpbArbyk4bmvb+kSQnSQlaQJV5DIvlubT0QquujUA0Br
         fQFB+0fUe3oegyOpeZvpJiJ4HbgTWjzHAYYzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708127743; x=1708732543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rUDkEiOEm4wZFWkz9cLvzAsbKQOJPsyUHuSB+y80Mkk=;
        b=gSMgQ/mAnpCZMi5hloEABoKJKlNjgUs33xWlpdZf4totTxbZfkxKeKby6N9qLKBjbb
         A9wjDSPE291NgwtjQ2YycAORqf8BIzactUhaVglqDo23tLWoRSlnImxl+QxDtbKjqbju
         iuVOPe/rK/g9iHbioFY8pCI9txxUgfij961RYRZHGOEvJyDah7R4WmCl8Lp3K4UlxsaN
         pg+UOW0KO01z4W5CjsjEsF/sp36y4H7oyCz5bxmBUOnOkyUqQmQztz29q2fontnomCVh
         Fpspv8VQ/F0zNIMb2o1+KCONggx5ySlQ8jhuUrpojNYfKOxvY5UeZ4PSXO7LczAtdX3S
         SBvw==
X-Forwarded-Encrypted: i=1; AJvYcCVYsaaEpFCYk4NZBId8invwjyedONGvEXWRX8BI0Thh3V/wFCiJGbVyVY3zR9vLZ5Vf2PsKYmvzhOIHdbqEVb/e3Q9W
X-Gm-Message-State: AOJu0Ywf+DhKp/PBtOHFeXMhNlx9qtB2WPv3sJpqPkO9UbvAlRqI/RpQ
	n7QqI9mHjYrHzSj4vMrd7wnARmd+k8U7vJe/0cGvCkNpo9Z6UAF1eNkFedyGuQ==
X-Google-Smtp-Source: AGHT+IGp6ieCJBOEJNwqboZ7bIDXfwShDqq4uoQtFYAcWRwFzB9mZWSbaV8y9ctUgAo16I+2+a2wCw==
X-Received: by 2002:a05:6a00:2d20:b0:6e1:4854:a971 with SMTP id fa32-20020a056a002d2000b006e14854a971mr1937441pfb.29.1708127743221;
        Fri, 16 Feb 2024 15:55:43 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ca27-20020a056a02069b00b005dc4fc80b21sm368295pgb.70.2024.02.16.15.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 15:55:42 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Alexei Starovoitov <ast@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Haowen Bai <baihaowen@meizu.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yonghong Song <yonghong.song@linux.dev>,
	Anton Protopopov <aspsk@isovalent.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] bpf: Replace bpf_lpm_trie_key 0-length array with flexible array
Date: Fri, 16 Feb 2024 15:55:40 -0800
Message-Id: <20240216235536.it.234-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4343; i=keescook@chromium.org;
 h=from:subject:message-id; bh=4OucJmNe1/pNjupONQadff5J4lun4ayJWUXyyzw61w8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlz/X8UPCdAKeZwgS/GrEX/APRKLSR78iobTw4y
 dXxUgXbWaKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZc/1/AAKCRCJcvTf3G3A
 Ju39D/9tO6fK6reOxpstX11hwZ2bgrVjYujyRm7uaqbmD+TCRcbVOzoQd0p7gjziow3lwrEyLa+
 4YP7D8O3gXP0SZVLS4qwYCBDTT09wuVBZzXp9rm3z8IxDmN+WpJOCaMh5j6jd84QsNNO8INr2Tf
 Opb2E+xfhF9+rW3QEIksdQj1gOOS5o/R/jF0x+KJCS+fB5lNtJa0x545ihPNPAC76/WUdogGftD
 SdhjFednoLYJFL/AOIiCa9GWmd8Gj7USAKFHFSs3ZkMwLqzAngxC8oPvGuK9stI/cBkAqzDj9Mg
 ldvYlxhlCeAjn2yP0LKEEiCCGHz/KioHHO3r1J7ywT1ccobLkatybedYEk8zGMQWpfVKyWR4udr
 ZLw4uXlAmfPdoZBZ0r8RcFpqhg6X+uTR6le6/I3JiOXHLPb2T4xaghtvCxXwWcjaG9DXXyK3wRz
 CuLQ1arkLEbVTyyHNjBnG65P+BVRB5mJqSm1t3uA0nuMp+d2i4qgce2Z801e3gLPVI6TKVdrZHo
 5HqzhpSZXfrN7LaXubTTX7EVx+5jVV54lRpxKOdiOy23UrA9pI+olBpYjQHM+uztAtb6hVoHmTW
 vRp8RuUUrhKE8U2QE65ZTTFIl1P86FFUqDgH96cB9vp3OQNZNGwBnRFR3+KxEGzvH0RQ4fKIoQn
 q51rjQ9 nGYFw61w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

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

And found at run-time under CONFIG_FORTIFY_SOURCE:

  UBSAN: array-index-out-of-bounds in kernel/bpf/lpm_trie.c:218:49
  index 0 is out of range for type '__u8 [*]'

This includes fixing the selftest which was incorrectly using a
variable length struct as a header, identified earlier[1]. Avoid this
by just explicitly including the prefixlen member instead of struct
bpf_lpm_trie_key.

Note that it is not possible to simply remove the "data" member, as it
is referenced by userspace

cilium:
        struct egress_gw_policy_key in_key = {
                .lpm_key = { 32 + 24, {} },
                .saddr   = CLIENT_IP,
                .daddr   = EXTERNAL_SVC_IP & 0Xffffff,
        };

systemd:
	ipv6_map_fd = bpf_map_new(
			BPF_MAP_TYPE_LPM_TRIE,
			offsetof(struct bpf_lpm_trie_key, data) + sizeof(uint32_t)*4,
			sizeof(uint64_t),
			...

The only risk to UAPI would be if sizeof() were used directly on the
data member, which it does not seem to be. It is only used as a static
initializer destination and to find its location via offsetof().

Link: https://lore.kernel.org/all/202206281009.4332AA33@keescook/ [1]
Reported-by: Mark Rutland <mark.rutland@arm.com>
Closes: https://paste.debian.net/hidden/ca500597/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
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

v2- clarify commit log, add more failure examples
v1- https://lore.kernel.org/all/63e531e3.170a0220.3a46a.3262@mx.google.com/
---
 include/uapi/linux/bpf.h                         | 2 +-
 tools/testing/selftests/bpf/progs/map_ptr_kern.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 754e68ca8744..359dd8a429c1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -80,7 +80,7 @@ struct bpf_insn {
 /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
 struct bpf_lpm_trie_key {
 	__u32	prefixlen;	/* up to 32 for AF_INET, 128 for AF_INET6 */
-	__u8	data[0];	/* Arbitrary size */
+	__u8	data[];		/* Arbitrary size */
 };
 
 struct bpf_cgroup_storage_key {
diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
index 3325da17ec81..1d476c6ae284 100644
--- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -316,7 +316,7 @@ struct lpm_trie {
 } __attribute__((preserve_access_index));
 
 struct lpm_key {
-	struct bpf_lpm_trie_key trie_key;
+	__u32 prefixlen;
 	__u32 data;
 };
 
-- 
2.34.1


