Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5C8459088
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 15:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbhKVOvB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 09:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238634AbhKVOvB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 09:51:01 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D834C061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 06:47:55 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so46970pjj.0
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 06:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r+wBS1fzUIKF1wccGCa69P8E29WcTW2I608qOgX3ow8=;
        b=mJ3hMRP5XXFPuLXy5YxJyOvgLeX1fMYTrK+Mpyp6BNvE+KaT+b96aGkqKrRtQgifSU
         9qLnakSaucVK8a3pHon4bPugvGCFLYOCxuHi2/cz8Nwk4ZPSDebXAJVTWUafOrDmq3f8
         VMCvop5w1YMs1nbQCrN1y56BOVida0udD3F2FX0ZeL6SA//Nil4U0KoiN/E3V6g40AsR
         K5S7Fbr/3gxiJ7Py1ZtUFKvrAN8APogOO4bVWN7iFiF82iHWT9XkZdAclYfBy6cNFH25
         Tjm5W1T1N3eZJJ7i2NJ+Vjp+RYWCXAWZk2YFxggESZPLOPL2DJSbMM0sY/xiI8FlvcXB
         XIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r+wBS1fzUIKF1wccGCa69P8E29WcTW2I608qOgX3ow8=;
        b=HjfyGgrilza8yqjFpaqILDLMrHj22nC6fSeOKFl3d/3/wmOCvEs/1P8bKjQ1D+7cdu
         Okt0sQ9Lg4Pu/g1e81ZWr88Ah4IZ+14MnI0qoys1KuHRdnXUJ2r2GvHSqDejUcyrJXSg
         heyuhHk4Xo53yGO7pChFgldrMW6n6o5b4qjdKywAW1KKRYarEtnMBDpBTLrLsgoVR+Q0
         GVcF33jPKpfVhK6LUPGmbIqE+j2yQ9FfL0sZQxnY1TOKbfz8ioEDhjymy7vc2tYZLxXT
         6nmYOSturhoAcqjwhOSf1wfRKKqoOQRzL1ScgeL/aufGVlq8uxyygVh4MOIL7aPUIuGv
         XTIg==
X-Gm-Message-State: AOAM5301zNwuLoBcV5YEVGJDYuEGfSpmZc052g0kUCSTmfLVBplxa7L7
        rb+0NW37n8m/88NikhvlQ+K7PQeKmgI=
X-Google-Smtp-Source: ABdhPJxc04KoaLpm7Rrpn/BalAYjMKOZkoBJyV6f9JLRGMwAh+qamIsmgKd1JvWY79KKso/jrLZCgQ==
X-Received: by 2002:a17:90a:7ac8:: with SMTP id b8mr31990527pjl.206.1637592474361;
        Mon, 22 Nov 2021 06:47:54 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id f4sm9521911pfj.61.2021.11.22.06.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 06:47:54 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 3/3] tools/resolve_btfids: Skip unresolved symbol warning for empty BTF sets
Date:   Mon, 22 Nov 2021 20:17:42 +0530
Message-Id: <20211122144742.477787-4-memxor@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211122144742.477787-1-memxor@gmail.com>
References: <20211122144742.477787-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2653; h=from:subject; bh=1K+2ztXUCApyPc3vMeg4ZEuoX75tB/Of486o7XLlBXE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBhm6195n34F8GMiMnK1gKHM7xbMs83dvZVoYN23JA4 2l5bKkKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYZutfQAKCRBM4MiGSL8RyqJ9D/ 9R5O0T/J7zrUvOHbypX5YqMSvqQzlCVHrqriNInwKEvs+TjeJ26Hfzh7M9ckZhX6q8NmivYwqL+19W PDK9JwEixDbmhWRP7sPNeuCJ7cGlgADFcVLHe7sMLG86oInDNVZ4swxVcVMvp2+DVTRNXhwFserfdC ftTmTHfgkocBMXVhKqc8L0xopOCa+pRMSFwmjCGTjyTOboWU7wKrISWX80LVEP3A2kzAJn1OsKcwTC TLM0ue8gXA50tbIbMC3QB33qqERNDmGOMDO5xKzVqwFCfYvILXhleple55H4AQv327aNhRnnLYS9JE yyXmhgakV45T2DtvsIn1k3EEBvU+gMpogygNcP5fBnbo6d53fPnMeeIrZWELmYxdusNgVSKsOTePLr Y3ZAzbeEBzIjdUfGlem4O+QKv5clKZZmieUO3MXts02TzPSh4poARYrML7aTQU6AslKqQ3kw3cJJh+ iPomzuC4DQ0FUNMuDUDxXbyJ5mfCzsZn3QzfoOcAtRmVhYk4B1SleTRU/zNH2uLj8myvnJpHeM8YUV f2zsFUSXJf4kVsG3K/d0Hsx36Zl3TGu2MYqzFm4Y1VWgk/Jujw5KR4LqrjkP/24VAhrOl2tSuvKcRS Pr14AqoOr3Fj5isnAr5+ZSdpE+w4c2/j3HrorDrCDXVL8dBOD/FJQXvvdm7A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

resolve_btfids prints a warning when it finds an unresolved symbol,
(id == 0) in id_patch. This can be the case for BTF sets that are empty
(due to disabled config options), hence printing warnings for certain
builds, most recently seen in [0].

The reason behind this is because id->cnt aliases id->id in btf_id
struct, leading to empty set showing up as ID 0 when we get to id_patch,
which triggers the warning. Since sets are an exception here, accomodate
by reusing hole in btf_id for bool is_set member, setting it to true for
BTF set when setting id->cnt, and use that to skip extraneous warning.

  [0]: https://lore.kernel.org/all/1b99ae14-abb4-d18f-cc6a-d7e523b25542@gmail.com

Before:

; ./tools/bpf/resolve_btfids/resolve_btfids -v -b vmlinux net/ipv4/tcp_cubic.ko
adding symbol tcp_cubic_kfunc_ids
WARN: resolve_btfids: unresolved symbol tcp_cubic_kfunc_ids
patching addr     0: ID       0 [tcp_cubic_kfunc_ids]
sorting  addr     4: cnt      0 [tcp_cubic_kfunc_ids]
update ok for net/ipv4/tcp_cubic.ko

After:

; ./tools/bpf/resolve_btfids/resolve_btfids -v -b vmlinux net/ipv4/tcp_cubic.ko
adding symbol tcp_cubic_kfunc_ids
patching addr     0: ID       0 [tcp_cubic_kfunc_ids]
sorting  addr     4: cnt      0 [tcp_cubic_kfunc_ids]
update ok for net/ipv4/tcp_cubic.ko

Cc: Jiri Olsa <jolsa@kernel.org>
Fixes: 0e32dfc80bae ("bpf: Enable TCP congestion control kfunc from modules")
Reported-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/bpf/resolve_btfids/main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index a59cb0ee609c..73409e27be01 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -83,6 +83,7 @@ struct btf_id {
 		int	 cnt;
 	};
 	int		 addr_cnt;
+	bool		 is_set;
 	Elf64_Addr	 addr[ADDR_CNT];
 };
 
@@ -451,8 +452,10 @@ static int symbols_collect(struct object *obj)
 			 * in symbol's size, together with 'cnt' field hence
 			 * that - 1.
 			 */
-			if (id)
+			if (id) {
 				id->cnt = sym.st_size / sizeof(int) - 1;
+				id->is_set = true;
+			}
 		} else {
 			pr_err("FAILED unsupported prefix %s\n", prefix);
 			return -1;
@@ -568,9 +571,8 @@ static int id_patch(struct object *obj, struct btf_id *id)
 	int *ptr = data->d_buf;
 	int i;
 
-	if (!id->id) {
+	if (!id->id && !id->is_set)
 		pr_err("WARN: resolve_btfids: unresolved symbol %s\n", id->name);
-	}
 
 	for (i = 0; i < id->addr_cnt; i++) {
 		unsigned long addr = id->addr[i];
-- 
2.34.0

