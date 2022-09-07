Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500E35AFE68
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 10:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiIGIDF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 04:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiIGICi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 04:02:38 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00F9A9C27
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 01:02:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bj12so28444794ejb.13
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 01:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=NcBf3iBCqpuqp0lZ8drSdlw1mbY1PENVuDSLlPZoZEc=;
        b=b84KsPQazkBAyCkWESDNe6aD1LneBFYqxL5rHpkFpJhRVc+/jJH0Mc/ZOVhBpESBeI
         1kNRwOD9LEZEdnfkvGvF95tMTfcK4S/01E5MtVKM9UrRKwVJ+a7+vki93J0Ybrsn7OlL
         4EFv8nv+gFQ0vYhCdBDm2GjzYfe6RLSGXjinPaOwmbtL1X8QTQQnEcSPKGQkg6a651JB
         E35oNb5NScNba0+ohikQjVXWGPXyPEZEcKvTVklSOCfdaemhuagzR7NEvKnnQOmMaFCM
         A1Sg/nsYrC1acWgiHnhqK4z11IdoowwBIn0vLAhSbQnEVK7AFtrnxK28JsHAGs45hmrk
         cNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=NcBf3iBCqpuqp0lZ8drSdlw1mbY1PENVuDSLlPZoZEc=;
        b=6sYJDAu32Jcnq/Ekv1rP1s9eTNYNEOw1WnwttLnZpG+Sk8CejXu9/Iy88C7FmD5OI0
         GQonKuvr6HdwIq8xjFiNijS+m26NDIidHwy2rbjUJIwyUkPsY86YbV6VaQaqd1fqM/V9
         gwJKomiknykU2zrEhgXtH2TAAjRqfzsCJWPMLU07byXlqEpm+Ab5mWLTxQMOT80Rx9/w
         jJqH6WhoFRiZikASQSzg4kCVmpB7/GLkWy2s6I1jzzrwRplS6EgBQTiXzdMxDlLgu6EP
         2LwluHCeP1LX7dmWF989/cGgkZ/3h7X71Ugjx5zQ0MFVbYx0WGPU3zAevvrQkDcSeKvd
         1fMw==
X-Gm-Message-State: ACgBeo2onHtsmEkj9C8uuE5aQoJYNQuQEBj0GoSsSDG1dv+BD04Ig1Jq
        HwshAJ3chxIa1EDj+lWaXXYCvccIdyTjQRZ5zYQ=
X-Google-Smtp-Source: AA6agR4VG+VXCQ9TjGZvuyTGgLhGs4upyrHmXSfsiRnosX1+1xHQC91UKbcQ2w64RQB7lPquZZul4Q==
X-Received: by 2002:a17:906:d7a9:b0:731:2189:4f58 with SMTP id pk9-20020a170906d7a900b0073121894f58mr1507468ejb.471.1662537729195;
        Wed, 07 Sep 2022 01:02:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:168:f656:0:5c2:41a8:eeed:529b])
        by smtp.gmail.com with ESMTPSA id r14-20020aa7c14e000000b0044e7adbe0c5sm6028009edp.87.2022.09.07.01.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 01:02:08 -0700 (PDT)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Martynas Pumputis <m@lambda.lt>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Anton Protopopov <aspsk@isovalent.com>,
        Eric Torng <torng@msu.edu>
Subject: [RFC PATCH] bpf: introduce new bpf map type BPF_MAP_TYPE_WILDCARD
Date:   Wed,  7 Sep 2022 10:01:40 +0200
Message-Id: <20220907080140.290413-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new map, BPF_MAP_TYPE_WILDCARD, which provides means to implement generic
online packet classification. Here "online" stands for "fast lookups and fast
updates", and "generic" means that a user can create maps with custom lookup
schemes—different numbers of fields and different interpretation of individual
fields (prefix bitmasks, ranges, and direct matches).

In particular, in Cilium we have several use cases for such a map:

  * XDP Prefilter is a simple XDP-based DDoS mitigation system provided by
    Cilium. At the moment it only supports filtering by source CIDRs. It would
    benefit from using this new map, as it allows to utilize wildcard rules
    without big penalty comparing to one hash or LPM lookup utilized now.

  * XDP Packet Recorder (see https://lpc.events/event/11/contributions/953/)

  * K8S and Cilium Network Policies: as of k8s 1.25 port ranges are considered
    to be a stable feature, and this map allows to implement this easily (and
    also to provide more sophisticated filtering for Cilium Network Policies)

Keys for wildcard maps are defined using the struct wildcard_key structure.
Besides the type field, it contains the data field of an arbitrary size. To
educate map about what's contained inside the data field, two additional
structures are used. The first one, struct wildcard_desc, also of arbitrary
size, tells how many fields are contained inside data, and the struct
wildcard_rule_desc structure defines how individual fields look like.

Fields (rules) can be of three types: BPF_WILDCARD_RULE_{PREFIX,RANGE,MATCH}.
The PREFIX rule means that inside data we have a binary value and a binary
(prefix) mask:

               size             u32
        <----------------> <----------->
   ... |    rule value    |   prefix   | ...

Here rule value is a binary value, e.g., 123.324.128.0, and prefix is a u32 bit
variable; we only use lower 8 bits of it. We allow 8, 16, 32, 64, and 128 bit
values for PREFIX rules.

The RANGE rule is determined by two binary values: minimum and maximum, treated
as unsigned integers of appropriate size:

               size               size
        <----------------> <---------------->
   ... |  min rule value  |  max rule value  | ...

We only allow the 8, 16, 32, and 64-bit for RANGE rules.

The MATCH rule is determined by one binary value, and is basically the same as
(X,sizeof(X)*8) PREFIX rule, but can be processed a bit faster:

               size
        <---------------->
   ... |    rule value    | ...

To speed up processing all the rules, including the prefix field, should be
stored in host byte order, and all elements in network byte order. 16-byte
fields are stored as {lo,hi}—lower eight bytes, then higher eight bytes.

For elements only values are stored.

To simplify definition of key structures, the BPF_WILDCARD_DESC_{1,2,3,4,5}
macros should be used. For example, one can define an IPv4 4-tuple keys as
follows:

   BPF_WILDCARD_DESC_4(
        capture4_wcard,
        BPF_WILDCARD_RULE_PREFIX, __u32, saddr,
        BPF_WILDCARD_RULE_PREFIX, __u32, daddr,
        BPF_WILDCARD_RULE_RANGE, __u16, sport,
        BPF_WILDCARD_RULE_RANGE, __u16, dport
   );

This macro will define the following structure:

   struct capture4_wcard_key {
        __u32 type;
        __u32 priority;
        union {
            struct {
                    __u32 saddr;
                    __u32 saddr_prefix;
                    __u32 daddr;
                    __u32 daddr_prefix;
                    __u16 sport_min;
                    __u16 sport_max;
                    __u16 dport_min;
                    __u16 dport_max;
            } __packed rule;
            struct {
                    __u32 saddr;
                    __u32 daddr;
                    __u16 sport;
                    __u16 dport;
            } __packed;
        };
   } __packed;

Here type field should contain either BPF_WILDCARD_KEY_RULE or
BPF_WILDCARD_KEY_ELEM so that kernel can differentiate between rules and
elements. The rule structure is used to define (and lookup) rules, the unnamed
structure can be used to specify elements when matching them with rules.

In order to simplify definition of a corresponding struct wildcard_desc, the
BPF_WILDCARD_DESC_* macros will create yet another structure:

   struct capture4_wcard_desc {
        __uint(n_rules, 4);
        struct {
                __uint(type, BPF_WILDCARD_RULE_PREFIX);
                __uint(size, sizeof(__u32));
        } saddr;
        struct {
                __uint(type, BPF_WILDCARD_RULE_PREFIX);
                __uint(size, sizeof(__u32));
        } daddr;
        struct {
                __uint(type, BPF_WILDCARD_RULE_RANGE);
                __uint(size, sizeof(__u16));
        } sport;
        struct {
                __uint(type, BPF_WILDCARD_RULE_RANGE);
                __uint(size, sizeof(__u16));
        } dport;
   };

This structure can be used in a (BTF) map definition as follows:

    __type(wildcard_desc, struct capture4_wcard_desc);

Then libbpf will create a corresponding struct wildcard_desc and pass it to
kernel in bpf_attr using new map_extra_data/map_extra_data_size fields.

The map implementation allows users to specify which algorithm to use to store
rules and lookup packets. Currently, three algorithms are supported:

  * Brute Force (suitable for map sizes of about 32 or below elements)

  * Tuple Merge (a variant of the Tuple Merge algorithm described in the
    "TupleMerge: Fast Software Packet Processing for Online Packet
    Classification" white paper, see https://nonsns.github.io/paper/rossi19ton.pdf.
    The Tuple Merge algorithm is not protected by any patents.)

  * Static Tuple Merge (a variant of Tuple Merge where a set of lookup tables
    is directly provided by a user)

To select a specific algorithm one should set a flag in the map_extra field,
see examples below.

Example 1. The following defines a brute force map to match IPv4
source/destination CIDRs:

    BPF_WILDCARD_DESC_2(
            capture4_l3,
            BPF_WILDCARD_RULE_PREFIX, __u32, saddr,
            BPF_WILDCARD_RULE_PREFIX, __u32, daddr,
    );

    struct {
            __uint(type, BPF_MAP_TYPE_WILDCARD);
            __type(key, struct capture4_l3_key);
            __type(value, __u64);
            __uint(max_entries, 16);
            __uint(map_flags, BPF_F_NO_PREALLOC);
            __uint(map_extra, BPF_WILDCARD_F_ALGORITHM_BF);
            __type(wildcard_desc, struct capture4_l3_desc);
    } filter_v4_bf __section(".maps");

Example 2. The only change requred for the previous example to use Tuple Merge
is to select a different algorithm:

    struct {
            __uint(type, BPF_MAP_TYPE_WILDCARD);
            __type(key, struct capture4_l3_key);
            __type(value, __u64);
            __uint(max_entries, 16);
            __uint(map_flags, BPF_F_NO_PREALLOC);
            __uint(map_extra, BPF_WILDCARD_F_ALGORITHM_TM);
            __type(wildcard_desc, struct capture4_l3_desc);
    } filter_v4_tm __section(".maps");

Example 3. Let's update the previous example to use Static Tuple Merge:

    BPF_WILDCARD_TM_OPTS(
            capture4_l3,
            BPF_WILDCARD_TM_TABLES_3(saddr, 16, 0, 16);
            BPF_WILDCARD_TM_TABLES_3(daddr, 16, 16, 0);
    );

    struct {
            __uint(type, BPF_MAP_TYPE_WILDCARD);
            __type(key, struct capture4_l3_key);
            __type(value, __u64);
            __uint(max_entries, 100000);
            __uint(map_flags, BPF_F_NO_PREALLOC);
            __uint(map_extra, BPF_WILDCARD_F_ALGORITHM_TM |
                              BPF_WILDCARD_F_TM_STATIC_POOL |
                              BPF_WILDCARD_F_TM_POOL_LIST);
            __type(wildcard_tm_opts, struct capture4_l3_opts);
    } filter_v4_bf __section(".maps");

Here we set new flags to specify that a pool of tables should be used to select
new tables from (BPF_WILDCARD_F_TM_STATIC_POOL), and that the field
wildcard_tm_opts contains a list of tables to use (BPF_WILDCARD_F_TM_POOL_LIST,
an alternative is to use a Cartesian product of arrays provided). The
capture4_l3_opts is defined by a helper macro BPF_WILDCARD_TM_OPTS, where for
each field we define a list of prefixes to use.  If a field is missing, then it
will be always ignored.

The following changes and are not part of this RFC, but planned to be added before v1:

  * implement priorities, i.e., users will be able to specify rule priority as
    u32 and rules with lower priorities will be matched first

  * implement !BPF_F_NO_PREALLOC: right now we always kalloc both elements and
    new tables

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 include/linux/bpf_types.h       |    1 +
 include/uapi/linux/bpf.h        |  127 +++
 kernel/bpf/Makefile             |    2 +-
 kernel/bpf/syscall.c            |   51 +-
 kernel/bpf/wildcard.c           | 1526 +++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h  |  129 ++-
 tools/lib/bpf/bpf.c             |    8 +
 tools/lib/bpf/bpf.h             |    5 +-
 tools/lib/bpf/libbpf.c          |  423 +++++++++
 tools/lib/bpf/libbpf_internal.h |    5 +-
 10 files changed, 2269 insertions(+), 8 deletions(-)
 create mode 100644 kernel/bpf/wildcard.c

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 2b9112b80171..c25bfbac7ceb 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -126,6 +126,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_STRUCT_OPS, bpf_struct_ops_map_ops)
 #endif
 BPF_MAP_TYPE(BPF_MAP_TYPE_RINGBUF, ringbuf_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_WILDCARD, wildcard_map_ops)
 
 BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
 BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 837c0f9b7fdd..b49f33136622 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -112,6 +112,128 @@ union bpf_iter_link_info {
 	} cgroup;
 };
 
+enum {
+        BPF_WILDCARD_RULE_PREFIX = 0,
+        BPF_WILDCARD_RULE_RANGE,
+        BPF_WILDCARD_RULE_MATCH,
+};
+
+struct wildcard_rule_desc {
+        __u32 type;    		/* WILDCARD_RULE_{PREFIX,RANGE,MATCH} */
+        __u32 size;    		/* the size of the field in bytes */
+
+	__u32 n_prefixes;
+	__u8 prefixes[16];
+};
+
+struct wildcard_desc {
+        __u32 n_rules;
+        struct wildcard_rule_desc rule_desc[];
+};
+
+enum {
+	BPF_WILDCARD_KEY_RULE = 0,
+	BPF_WILDCARD_KEY_ELEM,
+};
+
+struct wildcard_key {
+	__u32 type;	/* WILDCARD_KEY_{RULE,ELEM} */
+	__u32 priority;	/* rule priority, when BPF_WILDCARD_F_PRIORITY is set */
+	__u8 data[];
+};
+
+/* Max total rule size. For example, for IPv6 4-tuple the size is (16+2)*2=36 */
+#define BPF_WILDCARD_MAX_TOTAL_RULE_SIZE 128
+
+/* Wildcard map algorithm selection */
+#define BPF_WILDCARD_F_ALGORITHM_BF	0
+#define BPF_WILDCARD_F_ALGORITHM_TM	1
+#define BPF_WILDCARD_F_ALGORITHM_MAX	2
+#define BPF_WILDCARD_F_ALGORITHM_MASK	0xff
+#define BPF_WILDCARD_ALGORITHM(flags)	(flags & BPF_WILDCARD_F_ALGORITHM_MASK)
+
+/* generic flags */
+#define BPF_WILDCARD_F_PRIORITY		(1 << 8)  /* Sort rules by priority */
+
+/* per-algorithm flags */
+#define BPF_WILDCARD_F_TM_STATIC_POOL	(1 << 16) /* Specify the search tables */
+#define BPF_WILDCARD_F_TM_POOL_LIST	(1 << 17) /* Specify tables as list */
+
+#define __BPF_WILDCARD_DATA__BPF_WILDCARD_RULE_PREFIX(T, FIELD)	\
+	T FIELD;						\
+	__u32 FIELD ## _prefix
+
+#define __BPF_WILDCARD_DATA__BPF_WILDCARD_RULE_RANGE(T, FIELD)	\
+	T FIELD ## _min;					\
+	T FIELD ## _max
+
+#define __BPF_WILDCARD_DATA__BPF_WILDCARD_RULE_MATCH(T, FIELD)	\
+	T FIELD
+
+#define __BPF_WILDCARD_DATA_RULE_1(TYPE, T, FIELD, ...) __BPF_WILDCARD_DATA__ ## TYPE (T, FIELD)
+#define __BPF_WILDCARD_DATA_RULE_2(TYPE, T, FIELD, ...) __BPF_WILDCARD_DATA__ ## TYPE (T, FIELD); __BPF_WILDCARD_DATA_RULE_1(__VA_ARGS__)
+#define __BPF_WILDCARD_DATA_RULE_3(TYPE, T, FIELD, ...) __BPF_WILDCARD_DATA__ ## TYPE (T, FIELD); __BPF_WILDCARD_DATA_RULE_2(__VA_ARGS__)
+#define __BPF_WILDCARD_DATA_RULE_4(TYPE, T, FIELD, ...) __BPF_WILDCARD_DATA__ ## TYPE (T, FIELD); __BPF_WILDCARD_DATA_RULE_3(__VA_ARGS__)
+#define __BPF_WILDCARD_DATA_RULE_5(TYPE, T, FIELD, ...) __BPF_WILDCARD_DATA__ ## TYPE (T, FIELD); __BPF_WILDCARD_DATA_RULE_4(__VA_ARGS__)
+
+#define __BPF_WILDCARD_DATA_ELEM_1(TYPE, T, FIELD, ...) T FIELD
+#define __BPF_WILDCARD_DATA_ELEM_2(TYPE, T, FIELD, ...) T FIELD; __BPF_WILDCARD_DATA_ELEM_1(__VA_ARGS__)
+#define __BPF_WILDCARD_DATA_ELEM_3(TYPE, T, FIELD, ...) T FIELD; __BPF_WILDCARD_DATA_ELEM_2(__VA_ARGS__)
+#define __BPF_WILDCARD_DATA_ELEM_4(TYPE, T, FIELD, ...) T FIELD; __BPF_WILDCARD_DATA_ELEM_3(__VA_ARGS__)
+#define __BPF_WILDCARD_DATA_ELEM_5(TYPE, T, FIELD, ...) T FIELD; __BPF_WILDCARD_DATA_ELEM_4(__VA_ARGS__)
+
+#define __BPF_WILDCARD_RULE_DESC(TYPE, T, FIELD, ...)	\
+	struct {					\
+		__uint(type, TYPE);			\
+		__uint(size, sizeof(T)); 		\
+	} FIELD
+
+#define __BPF_WILDCARD_RULE_DESC_1(TYPE, T, FIELD, ...) __BPF_WILDCARD_RULE_DESC(TYPE, T, FIELD)
+#define __BPF_WILDCARD_RULE_DESC_2(TYPE, T, FIELD, ...) __BPF_WILDCARD_RULE_DESC(TYPE, T, FIELD); __BPF_WILDCARD_RULE_DESC_1(__VA_ARGS__)
+#define __BPF_WILDCARD_RULE_DESC_3(TYPE, T, FIELD, ...) __BPF_WILDCARD_RULE_DESC(TYPE, T, FIELD); __BPF_WILDCARD_RULE_DESC_2(__VA_ARGS__)
+#define __BPF_WILDCARD_RULE_DESC_4(TYPE, T, FIELD, ...) __BPF_WILDCARD_RULE_DESC(TYPE, T, FIELD); __BPF_WILDCARD_RULE_DESC_3(__VA_ARGS__)
+#define __BPF_WILDCARD_RULE_DESC_5(TYPE, T, FIELD, ...) __BPF_WILDCARD_RULE_DESC(TYPE, T, FIELD); __BPF_WILDCARD_RULE_DESC_4(__VA_ARGS__)
+
+#define __BPF_WILDCARD_TM_TABLE(PFX, N)      __uint(prefix ## N, PFX)
+#define __BPF_WILDCARD_TM_TABLES_1(PFX)      __BPF_WILDCARD_TM_TABLE(PFX, 1);
+#define __BPF_WILDCARD_TM_TABLES_2(PFX, ...) __BPF_WILDCARD_TM_TABLE(PFX, 2); __BPF_WILDCARD_TM_TABLES_1(__VA_ARGS__)
+#define __BPF_WILDCARD_TM_TABLES_3(PFX, ...) __BPF_WILDCARD_TM_TABLE(PFX, 3); __BPF_WILDCARD_TM_TABLES_2(__VA_ARGS__)
+#define __BPF_WILDCARD_TM_TABLES_4(PFX, ...) __BPF_WILDCARD_TM_TABLE(PFX, 4); __BPF_WILDCARD_TM_TABLES_3(__VA_ARGS__)
+
+#define BPF_WILDCARD_TM_TABLES_1(X, PFX)      struct { __BPF_WILDCARD_TM_TABLE(PFX, 1); } X
+#define BPF_WILDCARD_TM_TABLES_2(X, PFX, ...) struct { __BPF_WILDCARD_TM_TABLE(PFX, 2); __BPF_WILDCARD_TM_TABLES_1(__VA_ARGS__) } X
+#define BPF_WILDCARD_TM_TABLES_3(X, PFX, ...) struct { __BPF_WILDCARD_TM_TABLE(PFX, 3); __BPF_WILDCARD_TM_TABLES_2(__VA_ARGS__) } X
+#define BPF_WILDCARD_TM_TABLES_4(X, PFX, ...) struct { __BPF_WILDCARD_TM_TABLE(PFX, 4); __BPF_WILDCARD_TM_TABLES_3(__VA_ARGS__) } X
+#define BPF_WILDCARD_TM_TABLES_5(X, PFX, ...) struct { __BPF_WILDCARD_TM_TABLE(PFX, 5); __BPF_WILDCARD_TM_TABLES_4(__VA_ARGS__) } X
+
+#define BPF_WILDCARD_TM_OPTS(NAME, ...) struct NAME ## _opts { __VA_ARGS__ }
+
+#define BPF_WILDCARD_DESC_x(x, NAME, ...)						\
+											\
+	struct NAME ## _key {								\
+		__u32 type;								\
+		__u32 priority;								\
+		union {									\
+			struct {							\
+				__BPF_WILDCARD_DATA_RULE_ ## x(__VA_ARGS__);		\
+			} __packed rule;						\
+			struct {							\
+				__BPF_WILDCARD_DATA_ELEM_ ## x(__VA_ARGS__);		\
+			} __packed;							\
+		};									\
+	} __packed;									\
+											\
+	struct NAME ## _desc {								\
+		__uint(n_rules, x);							\
+		__BPF_WILDCARD_RULE_DESC_ ## x(__VA_ARGS__);				\
+	}
+
+#define BPF_WILDCARD_DESC_1(...) BPF_WILDCARD_DESC_x(1, __VA_ARGS__)
+#define BPF_WILDCARD_DESC_2(...) BPF_WILDCARD_DESC_x(2, __VA_ARGS__)
+#define BPF_WILDCARD_DESC_3(...) BPF_WILDCARD_DESC_x(3, __VA_ARGS__)
+#define BPF_WILDCARD_DESC_4(...) BPF_WILDCARD_DESC_x(4, __VA_ARGS__)
+#define BPF_WILDCARD_DESC_5(...) BPF_WILDCARD_DESC_x(5, __VA_ARGS__)
+
 /* BPF syscall commands, see bpf(2) man-page for more details. */
 /**
  * DOC: eBPF Syscall Preamble
@@ -928,6 +1050,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_INODE_STORAGE,
 	BPF_MAP_TYPE_TASK_STORAGE,
 	BPF_MAP_TYPE_BLOOM_FILTER,
+	BPF_MAP_TYPE_WILDCARD,
 };
 
 /* Note that tracing related programs such as
@@ -1312,6 +1435,10 @@ union bpf_attr {
 						   * struct stored as the
 						   * map value
 						   */
+
+		void *map_extra_data;
+		__u32 map_extra_data_size;
+
 		/* Any per-map-type extra fields
 		 *
 		 * BPF_MAP_TYPE_BLOOM_FILTER - the lowest 4 bits indicate the
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 341c94f208f4..f59e524bc9a0 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -7,7 +7,7 @@ endif
 CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
 
 obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
-obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
+obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o wildcard.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 074c901fbb4e..bb94dbb3c9f5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1067,9 +1067,34 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	return ret;
 }
 
+static int copy_map_extra_data(union bpf_attr *attr, bool is_kernel)
+{
+	u32 size = attr->map_extra_data_size;
+	void *old = attr->map_extra_data;
+	void *new;
+
+	if (!size || size > 1024)
+		return -EINVAL;
+
+	/* released by map */
+	new = kzalloc(size, unlikely(is_kernel) ? GFP_KERNEL : GFP_USER);
+	if (!new)
+		return -ENOMEM;
+
+	if (unlikely(is_kernel)) {
+		memcpy(new, old, size);
+	} else if (copy_from_user(new, old, size)) {
+		kfree(new);
+		return -EFAULT;
+	}
+
+	attr->map_extra_data = new;
+	return 0;
+}
+
 #define BPF_MAP_CREATE_LAST_FIELD map_extra
 /* called via syscall */
-static int map_create(union bpf_attr *attr)
+static int map_create(union bpf_attr *attr, bool is_kernel)
 {
 	int numa_node = bpf_map_attr_numa_node(attr);
 	struct bpf_map *map;
@@ -1089,9 +1114,14 @@ static int map_create(union bpf_attr *attr)
 	}
 
 	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
+	    attr->map_type != BPF_MAP_TYPE_WILDCARD &&
 	    attr->map_extra != 0)
 		return -EINVAL;
 
+	if (attr->map_type != BPF_MAP_TYPE_WILDCARD &&
+	    (attr->map_extra_data || attr->map_extra_data_size != 0))
+		return -EINVAL;
+
 	f_flags = bpf_get_file_flag(attr->map_flags);
 	if (f_flags < 0)
 		return f_flags;
@@ -1101,10 +1131,21 @@ static int map_create(union bpf_attr *attr)
 	     !node_online(numa_node)))
 		return -EINVAL;
 
+	if (attr->map_extra_data) {
+		err = copy_map_extra_data(attr, is_kernel);
+		if (err)
+			return err;
+	}
+
 	/* find map type and init map: hashtable vs rbtree vs bloom vs ... */
 	map = find_and_alloc_map(attr);
-	if (IS_ERR(map))
-		return PTR_ERR(map);
+	if (IS_ERR(map)) {
+		err = PTR_ERR(map);
+		goto free_map_extra_data;
+	}
+
+	/* ->map_alloc should release and zero the attr->map_extra_data */
+	WARN_ON(attr->map_extra_data);
 
 	err = bpf_obj_name_cpy(map->name, attr->map_name,
 			       sizeof(attr->map_name));
@@ -1188,6 +1229,8 @@ static int map_create(union bpf_attr *attr)
 free_map:
 	btf_put(map->btf);
 	map->ops->map_free(map);
+free_map_extra_data:
+	kfree(attr->map_extra_data);
 	return err;
 }
 
@@ -4935,7 +4978,7 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 
 	switch (cmd) {
 	case BPF_MAP_CREATE:
-		err = map_create(&attr);
+		err = map_create(&attr, bpfptr_is_kernel(uattr));
 		break;
 	case BPF_MAP_LOOKUP_ELEM:
 		err = map_lookup_elem(&attr);
diff --git a/kernel/bpf/wildcard.c b/kernel/bpf/wildcard.c
new file mode 100644
index 000000000000..8c394309071f
--- /dev/null
+++ b/kernel/bpf/wildcard.c
@@ -0,0 +1,1526 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Isovalent, Inc.
+ */
+
+#include <linux/container_of.h>
+#include <linux/btf_ids.h>
+#include <linux/random.h>
+#include <linux/jhash.h>
+#include <linux/sort.h>
+#include <linux/bpf.h>
+#include <linux/err.h>
+#include <linux/btf.h>
+#include <linux/err.h>
+
+#include <asm/unaligned.h>
+
+typedef struct {
+	u64 lo, hi;
+} u128;
+
+/* TYPE is one of u8, u16, u32 or u64 */
+#define __mask(TYPE, PFX) \
+	(PFX? (TYPE)-1 << ((sizeof(TYPE) * 8) - PFX) : 0)
+
+#define __mask_prefix(TYPE, X, PFX) \
+	(*(TYPE*)(X) & __mask(TYPE, (PFX)))
+
+#define ____match_prefix(TYPE, RULE, PFX, ELEM) \
+	(__mask_prefix(TYPE, (ELEM), PFX) == *(TYPE*)(RULE))
+
+#define ____match_range(TYPE, X_MIN, X_MAX, X) \
+	(*(TYPE*)(X_MIN) <= *(TYPE*)(X) && *(TYPE*)(X_MAX) >= *(TYPE*)(X))
+
+static inline int
+__match_prefix(u32 size, const void *prule, const void *pprefix, const void *pelem)
+{
+	u32 prefix = get_unaligned((u32 *)pprefix);
+
+	if (size == 16) {
+		u128 rule;
+		u128 elem;
+
+		rule.lo = get_unaligned((u64 *)prule);
+		rule.hi = get_unaligned((u64 *)(prule+8));
+		elem.lo = get_unaligned_be64((u64 *)pelem);
+		elem.hi = get_unaligned_be64((u64 *)(pelem+8));
+
+		if (prefix <= 64) {
+			return ____match_prefix(u64, &rule.lo, prefix, &elem.lo);
+		} else {
+			return (rule.lo == elem.lo &&
+				____match_prefix(u64, &rule.hi, prefix-64, &elem.hi));
+		}
+	} else if (size == 4) {
+		u32 rule = get_unaligned((u32 *) prule);
+		u32 elem = get_unaligned_be32(pelem);
+		return ____match_prefix(u32, &rule, prefix, &elem);
+	} else if (size == 8) {
+		u64 rule = get_unaligned((u64 *) prule);
+		u64 elem = get_unaligned_be64(pelem);
+		return ____match_prefix(u64, &rule, prefix, &elem);
+	} else if (size == 2) {
+		u16 rule = get_unaligned((u16 *) prule);
+		u16 elem = get_unaligned_be16(pelem);
+		return ____match_prefix(u16, &rule, prefix, &elem);
+	} else if (size == 1) {
+		return ____match_prefix(u8, prule, prefix, pelem);
+	}
+
+	BUG();
+	return 0;
+}
+
+static inline int
+__match_range(u32 size, const void *pmin, const void *pmax, const void *pelem)
+{
+	if (size == 2) {
+		u16 min = get_unaligned((u16 *) pmin);
+		u16 max = get_unaligned((u16 *) pmax);
+		u16 elem = get_unaligned_be16(pelem);
+		return ____match_range(u16, &min, &max, &elem);
+	} else if (size == 1) {
+		return ____match_range(u8, pmin, pmax, pelem);
+	} else if (size == 4) {
+		u32 min = get_unaligned((u32 *) pmin);
+		u32 max = get_unaligned((u32 *) pmax);
+		u32 elem = get_unaligned_be32(pelem);
+		return ____match_range(u32, &min, &max, &elem);
+	} else if (size == 8) {
+		u64 min = get_unaligned((u64 *) pmin);
+		u64 max = get_unaligned((u64 *) pmax);
+		u64 elem = get_unaligned_be64(pelem);
+		return ____match_range(u64, &min, &max, &elem);
+	}
+
+	BUG();
+	return 0;
+}
+
+static inline int __match_rule(const struct wildcard_rule_desc *desc,
+			       const void *rule, const void *elem)
+{
+	u32 size = desc->size;
+
+	switch (desc->type) {
+	case BPF_WILDCARD_RULE_PREFIX:
+		switch (size) {
+		case 1: case 2: case 4: case 8: case 16:
+			return __match_prefix(size, rule, rule+size, elem);
+		}
+		break;
+	case BPF_WILDCARD_RULE_RANGE:
+		switch (desc->size) {
+		case 1: case 2: case 4: case 8:
+			return __match_range(size, rule, rule+size, elem);
+		}
+		break;
+	case BPF_WILDCARD_RULE_MATCH:
+		return !memcmp(rule, elem, size);
+	}
+
+	BUG();
+	return 0;
+}
+
+static inline int __match(const struct wildcard_desc *wc_desc,
+			  const struct wildcard_key *rule,
+			  const struct wildcard_key *elem)
+{
+	u32 off_rule = 0, off_elem = 0;
+	u32 i, size;
+
+	for (i = 0; i < wc_desc->n_rules; i++) {
+		if (!__match_rule(&wc_desc->rule_desc[i],
+				  &rule->data[off_rule],
+				  &elem->data[off_elem]))
+			return 0;
+
+		size = wc_desc->rule_desc[i].size;
+		switch (wc_desc->rule_desc[i].type) {
+		case BPF_WILDCARD_RULE_PREFIX:
+			off_rule += size + sizeof(u32);
+			break;
+		case BPF_WILDCARD_RULE_RANGE:
+			off_rule += 2 * size;
+			break;
+		case BPF_WILDCARD_RULE_MATCH:
+			off_rule += size;
+			break;
+		}
+		off_elem += size;
+	}
+	return 1;
+}
+
+struct wildcard_ops;
+
+union wildcard_lock {
+	spinlock_t     lock;
+	raw_spinlock_t raw_lock;
+};
+
+struct tm_bucket {
+	struct hlist_head head;
+};
+
+struct tm_mask {
+	u32 n_prefixes;
+        u8 prefix[];
+};
+
+struct tm_table {
+	struct list_head list;
+	struct tm_mask *mask;
+	atomic_t n_elements;
+	struct rcu_head rcu;
+	u32 id;
+};
+
+struct bpf_wildcard {
+	struct bpf_map map;
+	u32 elem_size;
+	struct wildcard_ops *ops;
+	struct wildcard_desc *desc;
+	bool prealloc;
+	bool priority;
+	int algorithm;
+	struct lock_class_key lockdep_key;
+
+	/* currently, all map updates are protected by a single lock,
+	 * so count is not atomic/percpu */
+	int count;
+
+	union {
+		/* Brute Force */
+		struct {
+			struct hlist_head bf_elements_head;
+			union wildcard_lock bf_lock;
+		};
+
+		/* TupleMerge */
+		struct {
+			struct tm_bucket *buckets;
+			u32 n_buckets;
+
+			union wildcard_lock tm_lock; /* one global lock to rule them all */
+
+			struct list_head tables_list_head;
+
+			bool static_tables_pool;
+			struct list_head tables_pool_list_head;
+		};
+	};
+};
+
+struct wildcard_ops {
+	int (*alloc)(struct bpf_wildcard *wcard,
+		     const union bpf_attr *attr);
+	void (*free)(struct bpf_wildcard *wcard);
+	int (*get_next_key)(struct bpf_wildcard *wcard,
+			    const struct wildcard_key *key,
+			    struct wildcard_key *next_key);
+	void *(*lookup)(const struct bpf_wildcard *wcard,
+			const struct wildcard_key *key);
+	void *(*match)(const struct bpf_wildcard *wcard,
+		       const struct wildcard_key *key);
+	int (*update_elem)(struct bpf_wildcard *wcard,
+			   const struct wildcard_key *key,
+			   void *value, u64 flags);
+	int (*delete_elem)(struct bpf_wildcard *wcard,
+			   const struct wildcard_key *key);
+};
+
+struct wcard_elem {
+
+	struct bpf_wildcard *wcard;
+
+	struct hlist_node node;
+	struct rcu_head rcu;
+
+	union {
+		/* Brute Force */
+		struct {
+		};
+
+		/* TupleMerge */
+		struct {
+			u32 table_id;
+			u32 hash;
+		};
+	};
+
+	char key[] __aligned(8);
+};
+
+static int check_map_update_flags(void *l_old, u64 map_flags)
+{
+	if (l_old && (map_flags & ~BPF_F_LOCK) == BPF_NOEXIST)
+		/* elem already exists */
+		return -EEXIST;
+
+	if (!l_old && (map_flags & ~BPF_F_LOCK) == BPF_EXIST)
+		/* elem doesn't exist, cannot update it */
+		return -ENOENT;
+
+	return 0;
+}
+
+static inline bool wcard_use_raw_lock(const struct bpf_wildcard *wcard)
+{
+	return (!IS_ENABLED(CONFIG_PREEMPT_RT) || wcard->prealloc);
+}
+
+static struct wcard_elem *
+wcard_elem_alloc(struct bpf_wildcard *wcard, const void *key, void *value, void *l_old)
+{
+	struct bpf_map *map = &wcard->map;
+	u32 key_size = map->key_size;
+	struct wcard_elem *l;
+
+	if (wcard->count >= wcard->map.max_entries && !l_old)
+		return ERR_PTR(-E2BIG);
+
+	wcard->count++;
+	l = bpf_map_kmalloc_node(map, wcard->elem_size,
+				 GFP_ATOMIC | __GFP_NOWARN, map->numa_node);
+	if (unlikely(!l)) {
+		wcard->count--;
+		return ERR_PTR(-ENOMEM);
+	}
+	l->wcard = wcard;
+	memcpy(l->key, key, key_size);
+	copy_map_value(map, l->key + round_up(key_size, 8), value);
+	return l;
+}
+
+static void __wcard_elem_free(struct wcard_elem *l)
+{
+	l->wcard->count--;
+	kfree(l);
+}
+
+static void wcard_elem_free_rcu(struct rcu_head *head)
+{
+	struct wcard_elem *l = container_of(head, struct wcard_elem, rcu);
+
+	__wcard_elem_free(l);
+}
+
+static void wcard_elem_free(struct wcard_elem *l)
+{
+	call_rcu(&l->rcu, wcard_elem_free_rcu);
+}
+
+static inline void wcard_init_lock(struct bpf_wildcard *wcard,
+				   union wildcard_lock *lock)
+{
+	if (wcard_use_raw_lock(wcard)) {
+		raw_spin_lock_init(&lock->raw_lock);
+		lockdep_set_class(&lock->raw_lock, &wcard->lockdep_key);
+	} else {
+		spin_lock_init(&lock->lock);
+		lockdep_set_class(&lock->lock, &wcard->lockdep_key);
+	}
+}
+
+static inline int wcard_lock(struct bpf_wildcard *wcard,
+			     union wildcard_lock *lock,
+			     unsigned long *pflags)
+{
+	unsigned long flags;
+
+	if (wcard_use_raw_lock(wcard))
+		raw_spin_lock_irqsave(&lock->raw_lock, flags);
+	else
+		spin_lock_irqsave(&lock->lock, flags);
+	*pflags = flags;
+
+	return 0;
+}
+
+static inline void wcard_unlock(struct bpf_wildcard *wcard,
+				union wildcard_lock *lock,
+				unsigned long flags)
+{
+	if (wcard_use_raw_lock(wcard))
+		raw_spin_unlock_irqrestore(&lock->raw_lock, flags);
+	else
+		spin_unlock_irqrestore(&lock->lock, flags);
+}
+
+static inline int bf_lock(struct bpf_wildcard *wcard, unsigned long *pflags)
+{
+	return wcard_lock(wcard, &wcard->bf_lock, pflags);
+}
+
+static inline void bf_unlock(struct bpf_wildcard *wcard, unsigned long flags)
+{
+	return wcard_unlock(wcard, &wcard->bf_lock, flags);
+}
+
+static void *bf_match(const struct bpf_wildcard *wcard,
+		      const struct wildcard_key *key)
+{
+	struct wcard_elem *l;
+
+	hlist_for_each_entry_rcu(l, &wcard->bf_elements_head, node)
+		if (__match(wcard->desc, (struct wildcard_key *)l->key, key))
+			return l;
+
+	return NULL;
+}
+
+static void *bf_lookup(const struct bpf_wildcard *wcard,
+		       const struct wildcard_key *key)
+{
+	struct wcard_elem *l;
+
+	hlist_for_each_entry_rcu(l, &wcard->bf_elements_head, node)
+		if (!memcmp(l->key, key, wcard->map.key_size))
+			return l;
+
+	return NULL;
+}
+
+static int bf_update_elem(struct bpf_wildcard *wcard,
+			  const struct wildcard_key *key,
+			  void *value, u64 map_flags)
+{
+	struct wcard_elem *l_old, *l_new;
+	unsigned long irq_flags;
+	int ret;
+
+	ret = bf_lock(wcard, &irq_flags);
+	if (ret)
+		return ret;
+
+	l_old = bf_lookup(wcard, key);
+	ret = check_map_update_flags(l_old, map_flags);
+	if (ret)
+		goto unlock;
+
+	l_new = wcard_elem_alloc(wcard, key, value, l_old);
+	if (IS_ERR(l_new)) {
+		ret = PTR_ERR(l_new);
+		goto unlock;
+	}
+
+	if (l_old) {
+		hlist_replace_rcu(&l_old->node, &l_new->node);
+		wcard_elem_free(l_old);
+	} else {
+		hlist_add_head_rcu(&l_new->node, &wcard->bf_elements_head);
+	}
+
+unlock:
+	bf_unlock(wcard, irq_flags);
+	return ret;
+}
+
+static int bf_get_next_key(struct bpf_wildcard *wcard,
+			   const struct wildcard_key *key,
+			   struct wildcard_key *next_key)
+{
+	struct wcard_elem *l = NULL;
+	struct hlist_node *node;
+
+	if (key)
+		l = bf_lookup(wcard, key);
+
+	if (!l)
+		/* invalid key, get the first element */
+		node = rcu_dereference_raw(hlist_first_rcu(&wcard->bf_elements_head));
+	else
+		/* valid key, get the next element */
+		node = rcu_dereference_raw(hlist_next_rcu(&l->node));
+
+	l = hlist_entry_safe(node, struct wcard_elem, node);
+	if (!l)
+		return -ENOENT;
+
+	memcpy(next_key, l->key, wcard->map.key_size);
+	return 0;
+}
+
+static int bf_delete_elem(struct bpf_wildcard *wcard,
+			  const struct wildcard_key *key)
+{
+	struct wcard_elem *elem;
+	unsigned long irq_flags;
+	int err;
+
+	err = bf_lock(wcard, &irq_flags);
+	if (err)
+		return err;
+
+	elem = bf_lookup(wcard, key);
+	if (elem) {
+		hlist_del_rcu(&elem->node);
+		wcard_elem_free(elem);
+	} else {
+		err = -ENOENT;
+	}
+
+	bf_unlock(wcard, irq_flags);
+	return err;
+}
+
+static int bf_alloc(struct bpf_wildcard *wcard, const union bpf_attr *attr)
+{
+	INIT_HLIST_HEAD(&wcard->bf_elements_head);
+	wcard_init_lock(wcard, &wcard->bf_lock);
+	return 0;
+}
+
+static void bf_free(struct bpf_wildcard *wcard)
+{
+	struct hlist_node *n;
+	struct wcard_elem *l;
+
+	hlist_for_each_entry_safe(l, n, &wcard->bf_elements_head, node) {
+		hlist_del(&l->node);
+		__wcard_elem_free(l);
+	}
+}
+
+static void __tm_copy_masked_rule(void *dst, const void *data, u32 size, u32 prefix)
+{
+	if (size == 1) {
+		u8 x = *(u8 *)data;
+		x = __mask_prefix(u8, &x, prefix);
+		memcpy(dst, &x, 1);
+	} else if (size == 2) {
+		u16 x = get_unaligned((u16 *) data);
+		x = __mask_prefix(u16, &x, prefix);
+		memcpy(dst, &x, 2);
+	} else if (size == 4) {
+		u32 x = get_unaligned((u32 *) data);
+		x = __mask_prefix(u32, &x, prefix);
+		memcpy(dst, &x, 4);
+	} else if (size == 8) {
+		u64 x = get_unaligned((u64 *) data);
+		x = __mask_prefix(u64, &x, prefix);
+		memcpy(dst, &x, 8);
+	} else if (size == 16) {
+		u128 x;
+
+		x.lo = get_unaligned((u64 *)data);
+		x.hi = get_unaligned((u64 *)(data+8));
+
+		/* if prefix is less than 64, then we will zero out the lower
+		 * part in any case, otherwise we won't mask out any bits from
+		 * the higher part; in any case, first we copy the lower part */
+		if (prefix <= 64) {
+			x.hi = 0;
+			x.lo = __mask_prefix(u64, &x.lo, prefix);
+		} else {
+			x.hi = __mask_prefix(u64, &x.hi, prefix-64);
+		}
+		memcpy(dst, &x, 16);
+	}
+}
+
+static void __tm_copy_masked_elem(void *dst, const void *data, u32 size, u32 prefix)
+{
+	if (size == 1) {
+		u8 x = *(u8 *)data;
+		x = __mask_prefix(u8, &x, prefix);
+		memcpy(dst, &x, 1);
+	} else if (size == 2) {
+		u16 x = get_unaligned_be16(data);
+		x = __mask_prefix(u16, &x, prefix);
+		memcpy(dst, &x, 2);
+	} else if (size == 4) {
+		u32 x = get_unaligned_be32(data);
+		x = __mask_prefix(u32, &x, prefix);
+		memcpy(dst, &x, 4);
+	} else if (size == 8) {
+		u64 x = get_unaligned_be64(data);
+		x = __mask_prefix(u64, &x, prefix);
+		memcpy(dst, &x, 8);
+	} else if (size == 16) {
+		u128 x;
+
+		x.lo = get_unaligned_be64(data);
+		x.hi = get_unaligned_be64(data+8);
+
+		/* if prefix is less than 64, then we will zero out the lower
+		 * part in any case, otherwise we won't mask out any bits from
+		 * the higher part; in any case, first we copy the lower part */
+		if (prefix <= 64) {
+			x.lo = __mask_prefix(u64, &x.lo, prefix);
+			x.hi = 0;
+		} else {
+			x.hi = __mask_prefix(u64, &x.hi, prefix-64);
+		}
+		memcpy(dst, &x, 16);
+	}
+}
+
+static u32 tm_hash_rule(const struct wildcard_desc *desc,
+			const struct tm_table *table,
+			const struct wildcard_key *key)
+{
+	u8 buf[BPF_WILDCARD_MAX_TOTAL_RULE_SIZE];
+	const void *data = key->data;
+	u32 type, size, i;
+	u32 n = 0;
+
+	for (i = 0; i < desc->n_rules; i++) {
+
+		type = desc->rule_desc[i].type;
+		size = desc->rule_desc[i].size;
+
+		if (type == BPF_WILDCARD_RULE_RANGE ||
+		    (type == BPF_WILDCARD_RULE_PREFIX && !table->mask->prefix[i]))
+			goto ignore;
+
+		if (likely(type == BPF_WILDCARD_RULE_PREFIX))
+			__tm_copy_masked_rule(buf+n, data, size, table->mask->prefix[i]);
+		else if (type == BPF_WILDCARD_RULE_MATCH)
+			memcpy(buf+n, data, size);
+
+		n += size;
+ignore:
+		switch (desc->rule_desc[i].type) {
+		case BPF_WILDCARD_RULE_PREFIX:
+			data += size + sizeof(u32);
+			break;
+		case BPF_WILDCARD_RULE_RANGE:
+			data += 2 * size;
+			break;
+		case BPF_WILDCARD_RULE_MATCH:
+			data += size;
+			break;
+		}
+	}
+
+	return jhash(buf, n, table->id);
+}
+
+static u32 tm_hash(const struct wildcard_desc *desc,
+		   const struct tm_table *table,
+		   const struct wildcard_key *key)
+{
+	u8 buf[BPF_WILDCARD_MAX_TOTAL_RULE_SIZE];
+	const void *data = key->data;
+	u32 type, size, i;
+	u32 n = 0;
+
+	for (i = 0; i < desc->n_rules; i++) {
+
+		type = desc->rule_desc[i].type;
+		size = desc->rule_desc[i].size;
+
+		if (type == BPF_WILDCARD_RULE_RANGE ||
+		    (type == BPF_WILDCARD_RULE_PREFIX && !table->mask->prefix[i]))
+			goto ignore;
+
+		if (likely(type == BPF_WILDCARD_RULE_PREFIX))
+			__tm_copy_masked_elem(buf+n, data, size, table->mask->prefix[i]);
+		else if (type == BPF_WILDCARD_RULE_MATCH)
+			memcpy(buf+n, data, size);
+
+		n += size;
+ignore:
+		data += size;
+	}
+
+	return jhash(buf, n, table->id);
+}
+
+static struct wcard_elem *__tm_lookup(const struct bpf_wildcard *wcard,
+				      const struct wildcard_key *key,
+				      struct tm_table **table_ptr,
+				      struct tm_bucket **bucket_ptr)
+{
+	struct tm_bucket *bucket;
+	struct tm_table *table;
+	struct wcard_elem *l;
+	u32 hash;
+
+	list_for_each_entry_rcu(table, &wcard->tables_list_head, list) {
+		hash = tm_hash_rule(wcard->desc, table, key);
+		bucket = &wcard->buckets[hash & (wcard->n_buckets - 1)];
+		hlist_for_each_entry_rcu(l, &bucket->head, node) {
+			if (l->hash != hash)
+				continue;
+			if (l->table_id != table->id)
+				continue;
+			if (!memcmp(l->key, key, wcard->map.key_size)) {
+				if (table_ptr)
+					*table_ptr = table;
+				if (bucket_ptr)
+					*bucket_ptr = bucket;
+				return l;
+			}
+		}
+	}
+	return NULL;
+}
+
+static void *tm_match(const struct bpf_wildcard *wcard,
+		      const struct wildcard_key *key)
+{
+	struct tm_bucket *bucket;
+	struct tm_table *table;
+	struct wcard_elem *l;
+	u32 hash;
+
+	list_for_each_entry_rcu(table, &wcard->tables_list_head, list) {
+		hash = tm_hash(wcard->desc, table, key);
+		bucket = &wcard->buckets[hash & (wcard->n_buckets - 1)];
+		hlist_for_each_entry_rcu(l, &bucket->head, node) {
+			if (l->hash != hash)
+				continue;
+			if (l->table_id != table->id)
+				continue;
+			if (__match(wcard->desc, (void *)l->key, key))
+				return l;
+		}
+	}
+	return NULL;
+}
+static void *tm_lookup(const struct bpf_wildcard *wcard,
+		       const struct wildcard_key *key)
+{
+	return __tm_lookup(wcard, key, NULL, NULL);
+}
+
+static void __tm_table_free(struct tm_table *table)
+{
+	bpf_map_area_free(table);
+}
+
+static void tm_table_free_rcu(struct rcu_head *head)
+{
+	struct tm_table *table = container_of(head, struct tm_table, rcu);
+
+	__tm_table_free(table);
+}
+
+static void tm_table_free(struct tm_table *table)
+{
+	call_rcu(&table->rcu, tm_table_free_rcu);
+}
+
+static bool __tm_table_id_exists(struct list_head *head, u32 id)
+{
+	struct tm_table *table;
+
+	list_for_each_entry(table, head, list)
+		if (table->id == id)
+			return true;
+
+	return false;
+}
+
+static u32 tm_new_table_id(struct bpf_wildcard *wcard, bool dynamic)
+{
+	struct list_head *head;
+	u32 id;
+
+	if (dynamic)
+		head = &wcard->tables_list_head;
+	else
+		head = &wcard->tables_pool_list_head;
+
+	do
+		id = get_random_u32();
+	while (__tm_table_id_exists(head, id));
+
+	return id;
+}
+
+static struct tm_table *tm_new_table(struct bpf_wildcard *wcard,
+				     const struct wildcard_key *key,
+				     bool circumcision, bool dynamic)
+{
+	struct tm_table *table;
+	u32 off = 0;
+	u32 size, i;
+	u32 prefix;
+
+	/*
+	 * struct tm_table | struct tm_mask | u8 prefixes[n_rules]
+	 *        \             ^       \           ^
+	 *         -------------|        -----------|
+	 */
+	size = sizeof(*table) + sizeof(struct tm_mask) + wcard->desc->n_rules;
+
+	table = bpf_map_kmalloc_node(&wcard->map, size,
+				     GFP_ATOMIC | __GFP_NOWARN,
+				     wcard->map.numa_node);
+	if (!table)
+		return NULL;
+
+	table->id = tm_new_table_id(wcard, dynamic);
+	table->mask = (struct tm_mask *)(table + 1);
+	atomic_set(&table->n_elements, 0);
+
+	table->mask->n_prefixes = wcard->desc->n_rules;
+	for (i = 0; i < wcard->desc->n_rules; i++) {
+		size = wcard->desc->rule_desc[i].size;
+
+		switch (wcard->desc->rule_desc[i].type) {
+		case BPF_WILDCARD_RULE_PREFIX:
+			prefix = *(u32 *)(key->data + off + size);
+			table->mask->prefix[i] = prefix;
+			if (circumcision)
+				table->mask->prefix[i] -= prefix/8;
+			off += size + sizeof(u32);
+			break;
+		case BPF_WILDCARD_RULE_RANGE:
+			table->mask->prefix[i] = 0;
+			off += 2 * size;
+			break;
+		case BPF_WILDCARD_RULE_MATCH:
+			table->mask->prefix[i] = 0;
+			off += size;
+			break;
+		default:
+			BUG();
+		}
+	}
+
+	return table;
+}
+
+static struct tm_table *tm_new_table_from_mask(struct bpf_wildcard *wcard,
+					       const u8 *prefixes,
+					       u32 n_prefixes, bool dynamic)
+{
+	struct tm_table *table;
+	u32 size;
+
+	BUG_ON(wcard->desc->n_rules != n_prefixes);
+
+	/*
+	 * struct tm_table | struct tm_mask | u8 prefixes[n_rules]
+	 *        \             ^       \           ^
+	 *         -------------|        -----------|
+	 */
+	size = sizeof(*table) + sizeof(struct tm_mask) + wcard->desc->n_rules;
+
+	table = bpf_map_kmalloc_node(&wcard->map, size,
+				     GFP_ATOMIC | __GFP_NOWARN,
+				     wcard->map.numa_node);
+	if (!table)
+		return NULL;
+
+	table->id = tm_new_table_id(wcard, dynamic);
+	table->mask = (struct tm_mask *)(table + 1);
+	atomic_set(&table->n_elements, 0);
+
+	table->mask->n_prefixes = wcard->desc->n_rules;
+	memcpy(table->mask->prefix, prefixes, table->mask->n_prefixes);
+
+	return table;
+}
+
+static int tm_table_compatible(const struct bpf_wildcard *wcard,
+			       const struct tm_table *table,
+			       const struct wildcard_key *key)
+{
+	u32 off = 0;
+	u32 size, i;
+	u32 prefix;
+
+	for (i = 0; i < wcard->desc->n_rules; i++) {
+		size = wcard->desc->rule_desc[i].size;
+
+		switch (wcard->desc->rule_desc[i].type) {
+		case BPF_WILDCARD_RULE_PREFIX:
+			prefix = *(u32 *)(key->data + off + size);
+
+			/* table only is compatible if its prefix is less than or equal rule prefix */
+			if (table->mask->prefix[i] > prefix)
+				return 0;
+
+			off += size + sizeof(u32);
+			break;
+		case BPF_WILDCARD_RULE_RANGE:
+			/* ignore this case, table is always compatible */
+			off += 2 * size;
+			break;
+		case BPF_WILDCARD_RULE_MATCH:
+			/* ignore this case, table is always compatible */
+			off += size;
+			break;
+		}
+	}
+	return 1;
+}
+
+static void tm_add_new_table(struct bpf_wildcard *wcard, struct tm_table *table)
+{
+	list_add_tail_rcu(&table->list, &wcard->tables_list_head);
+}
+
+static struct tm_table *tm_get_dynamic_table(struct bpf_wildcard *wcard,
+					     const struct wildcard_key *key)
+{
+	struct tm_table *table;
+
+	list_for_each_entry(table, &wcard->tables_list_head, list)
+		if (tm_table_compatible(wcard, table, key))
+			return table;
+
+	table = tm_new_table(wcard, key, true, true);
+	if (!table)
+		return ERR_PTR(-ENOMEM);
+
+	tm_add_new_table(wcard, table);
+	return table;
+}
+
+static bool tm_same_table(struct tm_table *a, struct tm_table *b)
+{
+	BUG_ON(a->mask->n_prefixes != b->mask->n_prefixes);
+	return !memcmp(a->mask->prefix, b->mask->prefix, a->mask->n_prefixes);
+}
+
+static struct tm_table *tm_get_static_table(struct bpf_wildcard *wcard,
+					    const struct wildcard_key *key)
+{
+	struct tm_table *static_table, *table;
+	bool found = false;
+
+	/* Find a static table which is compatible with the key. This is
+	 * possible that the key doesn't fit into any static tables */
+	list_for_each_entry(static_table, &wcard->tables_pool_list_head, list)
+		if (tm_table_compatible(wcard, static_table, key)) {
+			found = true;
+			break;
+		}
+	if (!found)
+		return ERR_PTR(-EINVAL);
+
+	/* Check if this static_table is listed alerady in the active list */
+	list_for_each_entry(table, &wcard->tables_list_head, list)
+		if (tm_same_table(table, static_table))
+			return table;
+
+	table = tm_new_table_from_mask(wcard, static_table->mask->prefix,
+				       static_table->mask->n_prefixes, true);
+	if (!table)
+		return ERR_PTR(-ENOMEM);
+
+	tm_add_new_table(wcard, table);
+	return table;
+}
+
+static struct tm_table *tm_compatible_table(struct bpf_wildcard *wcard,
+					    const struct wildcard_key *key)
+{
+	if (wcard->static_tables_pool) {
+		return tm_get_static_table(wcard, key);
+	} else {
+		return tm_get_dynamic_table(wcard, key);
+	}
+}
+
+static inline int tm_lock(struct bpf_wildcard *wcard, unsigned long *pflags)
+{
+	return wcard_lock(wcard, &wcard->tm_lock, pflags);
+}
+
+static inline void tm_unlock(struct bpf_wildcard *wcard, unsigned long flags)
+{
+	return wcard_unlock(wcard, &wcard->tm_lock, flags);
+}
+
+static int __tm_update_elem(struct bpf_wildcard *wcard,
+			    const struct wildcard_key *key,
+			    void *value, u64 map_flags)
+{
+	struct bpf_map *map = &wcard->map;
+	struct tm_bucket *bucket;
+	struct tm_table *table;
+	struct wcard_elem *l;
+	u32 hash;
+	int ret;
+
+	l = tm_lookup(wcard, key);
+	ret = check_map_update_flags(l, map_flags);
+	if (ret)
+		return ret;
+	if (l) {
+		copy_map_value(map, l->key + round_up(map->key_size, 8), value);
+		return 0;
+	}
+
+	l = wcard_elem_alloc(wcard, key, value, NULL);
+	if (IS_ERR(l))
+		return PTR_ERR(l);
+
+	table = tm_compatible_table(wcard, key);
+	if (IS_ERR(table)) {
+		__wcard_elem_free(l);
+		return PTR_ERR(table);
+	}
+
+	hash = tm_hash_rule(wcard->desc, table, (void*)l->key);
+	bucket = &wcard->buckets[hash & (wcard->n_buckets - 1)];
+	l->hash = hash;
+	l->table_id = table->id;
+	atomic_inc(&table->n_elements);
+
+	hlist_add_head_rcu(&l->node, &bucket->head);
+	return 0;
+}
+
+static int __tm_delete_elem(struct bpf_wildcard *wcard,
+			    const struct wildcard_key *key)
+{
+	struct tm_bucket *bucket;
+	struct wcard_elem *elem;
+	struct tm_table *table;
+	int n;
+
+	elem = __tm_lookup(wcard, key, &table, &bucket);
+	if (!elem)
+		return -ENOENT;
+
+	hlist_del_rcu(&elem->node);
+	wcard_elem_free(elem);
+
+	n = atomic_dec_return(&table->n_elements);
+	if (n == 0) {
+		list_del_rcu(&table->list);
+		tm_table_free(table);
+	}
+
+	return 0;
+}
+
+static int __tm_cmp_u8_descending(const void *a, const void *b)
+{
+	return (int)*(u8*)b - (int)*(u8*)a;
+}
+
+#define lengths(I)	wcard->desc->rule_desc[I].n_prefixes
+#define prefix(I, J)	((u8)(lengths(I) ? wcard->desc->rule_desc[I].prefixes[J] : 0))
+#define masks(I, J)	(*(u8*)(mask + (J) * m + I))
+
+static void *__tm_alloc_pool_cartesian(struct bpf_wildcard *wcard, u32 *np)
+{
+	u32 n, m = wcard->desc->n_rules;
+	void *mask;
+	int *idx;
+	u32 i, j;
+
+	/*
+	 * Each element in rule has an array prefixes[n_prefixes], and we need
+	 * to build a Cartesian product of theese arrays. Say, we have ([16,8],
+	 * [24,16], [], []). Then we construct the following Cartesian product:
+	 *   (16, 24, 0, 0)
+	 *   (8, 24, 0, 0)
+	 *   (16, 16, 0, 0)
+	 *   (8, 16, 0, 0)
+	 */
+
+	n = 1;
+	for (i = 0; i < m; i++) {
+		if (!lengths(i))
+			continue;
+		if (wcard->desc->rule_desc[i].type != BPF_WILDCARD_RULE_PREFIX)
+			return ERR_PTR(-EINVAL);
+
+		/* Prefixes should be sorted in descending order, otherwise
+		 * lower tables won't be ever reached */
+		sort(wcard->desc->rule_desc[i].prefixes, lengths(i),
+		     sizeof(wcard->desc->rule_desc[i].prefixes[0]),
+		     __tm_cmp_u8_descending, NULL);
+
+		n *= lengths(i);
+	}
+
+	mask = kzalloc(n * m + m * sizeof(*idx), GFP_USER);
+	if (!mask)
+		return ERR_PTR(-ENOMEM);
+
+	idx = mask + n * m;
+	for (j = 0; j < n; j++) {
+		for (i = 0; i < m; i++)
+			masks(i, j) = prefix(i, idx[i]);
+
+		i = 0;
+		idx[i]++;
+		while (idx[i] == lengths(i)) {
+			idx[i++] = 0;
+			if (lengths(i))
+				idx[i]++;
+		}
+	}
+
+	*np = n;
+	return mask;
+}
+
+static void *__tm_alloc_pool_list(struct bpf_wildcard *wcard, u32 *np)
+{
+	u32 n, m = wcard->desc->n_rules;
+	void *mask;
+	u32 i, j;
+
+	/*
+	 * Each element in rule has an array prefixes[n_prefixes], and we need
+	 * to build a combined list of theese arrays. Say, we have ([16,8],
+	 * [16,8], [], []). Then we construct the following list:
+	 *   (16, 16, 0, 0)
+	 *   (8, 8, 0, 0)
+	 */
+
+	n = 0;
+	for (i = 0; i < m; i++) {
+		if (!lengths(i))
+			continue;
+		if (wcard->desc->rule_desc[i].type != BPF_WILDCARD_RULE_PREFIX)
+			return ERR_PTR(-EINVAL);
+
+		/* We do not sort elements for lists because users might want
+		 * to specify pools like (32,32),(32,0),(0,32). If sorted,
+		 * then this will be interpreted as (32,32),(32,32),(0,0) */
+
+		/* All the lists should be of the same length, or empty */
+		if (n == 0)
+			n = lengths(i);
+		else if (n != lengths(i))
+			return ERR_PTR(-EINVAL);
+	}
+
+	mask = kzalloc(n * m, GFP_USER);
+	if (!mask)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < m; i++)
+		for (j = 0; j < n; j++)
+			masks(i, j) = prefix(i, j);
+
+	*np = n;
+	return mask;
+}
+
+#undef lengths
+#undef prefix
+#undef masks
+
+static int tm_alloc_static_tables_pool(struct bpf_wildcard *wcard,
+				       bool cartesian)
+{
+	u32 n, m = wcard->desc->n_rules;
+	struct tm_table *table;
+	int err = 0;
+	void *mask;
+	u32 j;
+
+	if (cartesian)
+		mask = __tm_alloc_pool_cartesian(wcard, &n);
+	else
+		mask = __tm_alloc_pool_list(wcard, &n);
+	if (IS_ERR(mask))
+		return PTR_ERR(mask);
+
+	for (j = 0; j < n; j++) {
+		table = tm_new_table_from_mask(wcard, mask + j * m, m, false);
+		if (!table) {
+			err = -ENOMEM;
+			goto free_mem;
+		}
+		list_add_tail(&table->list, &wcard->tables_pool_list_head);
+	}
+
+free_mem:
+	kfree(mask);
+	return err;
+}
+
+static int tm_update_elem(struct bpf_wildcard *wcard,
+			  const struct wildcard_key *key,
+			  void *value, u64 flags)
+{
+	unsigned long irq_flags;
+	int ret;
+
+	ret = tm_lock(wcard, &irq_flags);
+	if (ret)
+		return ret;
+	ret = __tm_update_elem(wcard, key, value, flags);
+	tm_unlock(wcard, irq_flags);
+	return ret;
+}
+
+static int tm_delete_elem(struct bpf_wildcard *wcard,
+			  const struct wildcard_key *key)
+{
+	unsigned long irq_flags;
+	int ret;
+
+	ret = tm_lock(wcard, &irq_flags);
+	if (ret)
+		return ret;
+	ret = __tm_delete_elem(wcard, key);
+	tm_unlock(wcard, irq_flags);
+	return ret;
+}
+
+static int tm_get_next_key(struct bpf_wildcard *wcard,
+			   const struct wildcard_key *key,
+			   struct wildcard_key *next_key)
+{
+	struct tm_bucket *bucket;
+	struct hlist_node *node;
+	struct wcard_elem *l;
+	unsigned int i = 0;
+
+	if (!key)
+		goto find_first_elem;
+
+	l = __tm_lookup(wcard, key, NULL, &bucket);
+	if (!l)
+		goto find_first_elem;
+
+	node = rcu_dereference_raw(hlist_next_rcu(&l->node));
+	l = hlist_entry_safe(node, struct wcard_elem, node);
+	if (l)
+		goto copy;
+
+	i = (bucket - wcard->buckets) + 1;
+
+find_first_elem:
+	for (; i < wcard->n_buckets; i++) {
+		bucket = &wcard->buckets[i];
+		node = rcu_dereference_raw(hlist_first_rcu(&bucket->head));
+		l = hlist_entry_safe(node, struct wcard_elem, node);
+		if (l)
+			goto copy;
+	}
+	return -ENOENT;
+
+copy:
+	memcpy(next_key, l->key, wcard->map.key_size);
+	return 0;
+}
+
+static void tm_free_bucket(struct tm_bucket *bucket)
+{
+	struct hlist_node *n;
+	struct wcard_elem *l;
+
+	hlist_for_each_entry_safe(l, n, &bucket->head, node) {
+		hlist_del(&l->node);
+		__wcard_elem_free(l);
+	}
+}
+
+static void tm_free(struct bpf_wildcard *wcard)
+{
+	struct tm_table *table, *n;
+	unsigned int i;
+
+	if (wcard->buckets) {
+		for (i = 0; i < wcard->n_buckets; i++)
+			tm_free_bucket(&wcard->buckets[i]);
+		bpf_map_area_free(wcard->buckets);
+	}
+
+	list_for_each_entry_safe(table, n, &wcard->tables_list_head, list)
+		__tm_table_free(table);
+
+	if (wcard->static_tables_pool)
+		list_for_each_entry_safe(table, n, &wcard->tables_pool_list_head, list)
+			__tm_table_free(table);
+}
+
+static int tm_alloc(struct bpf_wildcard *wcard, const union bpf_attr *attr)
+{
+	unsigned int i;
+	int err;
+
+	wcard->n_buckets = roundup_pow_of_two(wcard->map.max_entries);
+	wcard->buckets = bpf_map_area_alloc(wcard->n_buckets *
+					   sizeof(struct tm_bucket),
+					   wcard->map.numa_node);
+	if (!wcard->buckets)
+		return -ENOMEM;
+
+	for (i = 0; i < wcard->n_buckets; i++)
+		INIT_HLIST_HEAD(&wcard->buckets[i].head);
+
+	INIT_LIST_HEAD(&wcard->tables_list_head);
+	wcard_init_lock(wcard, &wcard->tm_lock);
+
+	/* this flag means that we need to pre-allocate a list of tables to
+	 * pull tables from; it should be provided by user. Otherwise we don't
+	 * know what to do. However, we can try to do two things: either
+	 * pre-allocate tables based on the field size / rule type (only
+	 * /prefix rules require a non-zero prefix), or to do a dynamic
+	 * allocation as in classic TM
+	 */
+	wcard->static_tables_pool = !!(attr->map_extra & BPF_WILDCARD_F_TM_STATIC_POOL);
+
+	if (wcard->static_tables_pool) {
+		INIT_LIST_HEAD(&wcard->tables_pool_list_head);
+		err = tm_alloc_static_tables_pool(wcard,
+						  !(attr->map_extra &
+						    BPF_WILDCARD_F_TM_POOL_LIST));
+		if (err)
+			goto free_buckets;
+	}
+
+	return 0;
+
+free_buckets:
+	bpf_map_area_free(wcard->buckets);
+	return err;
+}
+
+static struct wildcard_ops wildcard_algorithms[BPF_WILDCARD_F_ALGORITHM_MAX] = {
+	[BPF_WILDCARD_F_ALGORITHM_BF] = {
+		.alloc = bf_alloc,
+		.free = bf_free,
+		.get_next_key = bf_get_next_key,
+		.lookup = bf_lookup,
+		.match = bf_match,
+		.update_elem = bf_update_elem,
+		.delete_elem = bf_delete_elem,
+	},
+	[BPF_WILDCARD_F_ALGORITHM_TM] = {
+		.alloc = tm_alloc,
+		.free = tm_free,
+		.get_next_key = tm_get_next_key,
+		.lookup = tm_lookup,
+		.match = tm_match,
+		.update_elem = tm_update_elem,
+		.delete_elem = tm_delete_elem,
+	},
+};
+
+static void *wildcard_map_lookup_elem(struct bpf_map *map, void *key)
+{
+	struct bpf_wildcard *wcard =
+		container_of(map, struct bpf_wildcard, map);
+	struct wcard_elem *l;
+
+	switch (((struct wildcard_key *)key)->type) {
+	case BPF_WILDCARD_KEY_RULE:
+		switch (wcard->algorithm) {
+		case BPF_WILDCARD_F_ALGORITHM_BF:
+			l = bf_lookup(wcard, key);
+			break;
+		case BPF_WILDCARD_F_ALGORITHM_TM:
+			l = tm_lookup(wcard, key);
+			break;
+		}
+		break;
+	case BPF_WILDCARD_KEY_ELEM:
+		switch (wcard->algorithm) {
+		case BPF_WILDCARD_F_ALGORITHM_BF:
+			l = bf_match(wcard, key);
+			break;
+		case BPF_WILDCARD_F_ALGORITHM_TM:
+			l = tm_match(wcard, key);
+			break;
+		}
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (l)
+		return l->key + round_up(wcard->map.key_size, 8);
+
+	return ERR_PTR(-ENOENT);
+}
+
+static int wildcard_map_update_elem(struct bpf_map *map, void *key,
+				    void *value, u64 map_flags)
+{
+	struct bpf_wildcard *wcard =
+		container_of(map, struct bpf_wildcard, map);
+
+	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST))
+		/* unknown flags */
+		return -EINVAL;
+
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
+		     !rcu_read_lock_bh_held());
+
+	return wcard->ops->update_elem(wcard, key, value, map_flags);
+}
+
+static int wildcard_map_delete_elem(struct bpf_map *map, void *key)
+{
+	struct bpf_wildcard *wcard =
+		container_of(map, struct bpf_wildcard, map);
+
+	return wcard->ops->delete_elem(wcard, key);
+}
+
+static int wildcard_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
+{
+	struct bpf_wildcard *wcard =
+		container_of(map, struct bpf_wildcard, map);
+
+	return wcard->ops->get_next_key(wcard, key, next_key);
+}
+
+static void wildcard_map_free(struct bpf_map *map)
+{
+	struct bpf_wildcard *wcard =
+		container_of(map, struct bpf_wildcard, map);
+
+	lockdep_unregister_key(&wcard->lockdep_key);
+	wcard->ops->free(wcard);
+	bpf_map_area_free(wcard);
+}
+
+static int wildcard_map_alloc_check(union bpf_attr *attr)
+{
+	struct wildcard_desc *desc = attr->map_extra_data;
+	struct wildcard_rule_desc *rule_desc;
+	unsigned int algorithm;
+	unsigned int i, j;
+	u64 flags_mask;
+	bool prealloc;
+	u32 tot_size;
+
+	if (!bpf_capable())
+		return -EPERM;
+
+	/* not implemented, yet, sorry */
+	prealloc = !(attr->map_flags & BPF_F_NO_PREALLOC);
+	if (prealloc)
+		return -ENOTSUPP;
+
+	if (attr->max_entries == 0 || attr->key_size == 0 ||
+	    attr->value_size == 0)
+		return -EINVAL;
+
+	if ((u64)attr->key_size + attr->value_size >= KMALLOC_MAX_SIZE -
+	   sizeof(struct wcard_elem))
+		/* if key_size + value_size is bigger, the user space won't be
+		 * able to access the elements via bpf syscall. This check
+		 * also makes sure that the elem_size doesn't overflow and it's
+		 * kmalloc-able later in wildcard_map_update_elem()
+		 */
+		return -E2BIG;
+
+	algorithm = BPF_WILDCARD_ALGORITHM(attr->map_extra);
+	if (algorithm >= BPF_WILDCARD_F_ALGORITHM_MAX)
+		return -EINVAL;
+
+	switch (algorithm) {
+	case BPF_WILDCARD_F_ALGORITHM_BF:
+		flags_mask = BPF_WILDCARD_F_PRIORITY;
+		break;
+	case BPF_WILDCARD_F_ALGORITHM_TM:
+		flags_mask = BPF_WILDCARD_F_PRIORITY |
+			     BPF_WILDCARD_F_TM_STATIC_POOL |
+			     BPF_WILDCARD_F_TM_POOL_LIST;
+		break;
+	}
+	if (attr->map_extra & ~BPF_WILDCARD_F_ALGORITHM_MASK & ~flags_mask)
+		return -EINVAL;
+
+	if (!desc || !desc->n_rules)
+		return -EINVAL;
+
+	tot_size = 0;
+	for (i = 0; i < !desc->n_rules; i++) {
+		rule_desc = &desc->rule_desc[i];
+
+		switch (rule_desc->type) {
+			case BPF_WILDCARD_RULE_PREFIX:
+			case BPF_WILDCARD_RULE_RANGE:
+			case BPF_WILDCARD_RULE_MATCH:
+				break;
+			default:
+				return -EINVAL;
+		}
+
+		switch (rule_desc->size) {
+			case 1:
+			case 2:
+			case 4:
+			case 8:
+				break;
+			case 16:
+				if (rule_desc->type == BPF_WILDCARD_RULE_RANGE)
+					return -EINVAL;
+				break;
+			default:
+				return -EINVAL;
+		}
+
+		tot_size += rule_desc->size;
+
+		for (j = 0; j < rule_desc->n_prefixes; j++) {
+			if (rule_desc->prefixes[j] > rule_desc->size)
+				return -EINVAL;
+		}
+	}
+	if (tot_size > BPF_WILDCARD_MAX_TOTAL_RULE_SIZE)
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct bpf_map *wildcard_map_alloc(union bpf_attr *attr)
+{
+	int numa_node = bpf_map_attr_numa_node(attr);
+	struct bpf_wildcard *wcard;
+	u64 data_size;
+	int err;
+
+	data_size = sizeof(*wcard) + attr->map_extra_data_size;
+	wcard = bpf_map_area_alloc(data_size, numa_node);
+	if (!wcard)
+		return ERR_PTR(-ENOMEM);
+
+	/* Copy and release the map_extra_data field */
+	wcard->desc = (void *)(wcard + 1);
+	memcpy(wcard->desc, attr->map_extra_data, attr->map_extra_data_size);
+	kfree(attr->map_extra_data);
+	attr->map_extra_data = 0;
+
+	lockdep_register_key(&wcard->lockdep_key);
+
+	bpf_map_init_from_attr(&wcard->map, attr);
+
+	wcard->prealloc = !(wcard->map.map_flags & BPF_F_NO_PREALLOC);
+	wcard->priority = !!(attr->map_extra & BPF_WILDCARD_F_PRIORITY);
+
+	wcard->elem_size = sizeof(struct wcard_elem) +
+			  round_up(wcard->map.key_size, 8) +
+			  round_up(wcard->map.value_size, 8);
+
+	wcard->algorithm = BPF_WILDCARD_ALGORITHM(attr->map_extra);
+	wcard->ops = &wildcard_algorithms[wcard->algorithm];
+
+	err = wcard->ops->alloc(wcard, attr);
+	if (err < 0)
+		goto free_wcard;
+
+	return &wcard->map;
+
+free_wcard:
+	wildcard_map_free(&wcard->map);
+	return ERR_PTR(err);
+}
+
+BTF_ID_LIST_SINGLE(bpf_wildcard_map_btf_ids, struct, bpf_wildcard)
+const struct bpf_map_ops wildcard_map_ops = {
+	.map_meta_equal = bpf_map_meta_equal,
+	.map_alloc_check = wildcard_map_alloc_check,
+	.map_alloc = wildcard_map_alloc,
+	.map_free = wildcard_map_free,
+	.map_lookup_elem = wildcard_map_lookup_elem,
+	.map_update_elem = wildcard_map_update_elem,
+	.map_delete_elem = wildcard_map_delete_elem,
+	.map_get_next_key = wildcard_map_get_next_key,
+	.map_btf_id = &bpf_wildcard_map_btf_ids[0],
+};
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 793103b10eab..b49f33136622 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -79,7 +79,7 @@ struct bpf_insn {
 /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
 struct bpf_lpm_trie_key {
 	__u32	prefixlen;	/* up to 32 for AF_INET, 128 for AF_INET6 */
-	__u8	data[0];	/* Arbitrary size */
+	__u8	data[];	/* Arbitrary size */
 };
 
 struct bpf_cgroup_storage_key {
@@ -112,6 +112,128 @@ union bpf_iter_link_info {
 	} cgroup;
 };
 
+enum {
+        BPF_WILDCARD_RULE_PREFIX = 0,
+        BPF_WILDCARD_RULE_RANGE,
+        BPF_WILDCARD_RULE_MATCH,
+};
+
+struct wildcard_rule_desc {
+        __u32 type;    		/* WILDCARD_RULE_{PREFIX,RANGE,MATCH} */
+        __u32 size;    		/* the size of the field in bytes */
+
+	__u32 n_prefixes;
+	__u8 prefixes[16];
+};
+
+struct wildcard_desc {
+        __u32 n_rules;
+        struct wildcard_rule_desc rule_desc[];
+};
+
+enum {
+	BPF_WILDCARD_KEY_RULE = 0,
+	BPF_WILDCARD_KEY_ELEM,
+};
+
+struct wildcard_key {
+	__u32 type;	/* WILDCARD_KEY_{RULE,ELEM} */
+	__u32 priority;	/* rule priority, when BPF_WILDCARD_F_PRIORITY is set */
+	__u8 data[];
+};
+
+/* Max total rule size. For example, for IPv6 4-tuple the size is (16+2)*2=36 */
+#define BPF_WILDCARD_MAX_TOTAL_RULE_SIZE 128
+
+/* Wildcard map algorithm selection */
+#define BPF_WILDCARD_F_ALGORITHM_BF	0
+#define BPF_WILDCARD_F_ALGORITHM_TM	1
+#define BPF_WILDCARD_F_ALGORITHM_MAX	2
+#define BPF_WILDCARD_F_ALGORITHM_MASK	0xff
+#define BPF_WILDCARD_ALGORITHM(flags)	(flags & BPF_WILDCARD_F_ALGORITHM_MASK)
+
+/* generic flags */
+#define BPF_WILDCARD_F_PRIORITY		(1 << 8)  /* Sort rules by priority */
+
+/* per-algorithm flags */
+#define BPF_WILDCARD_F_TM_STATIC_POOL	(1 << 16) /* Specify the search tables */
+#define BPF_WILDCARD_F_TM_POOL_LIST	(1 << 17) /* Specify tables as list */
+
+#define __BPF_WILDCARD_DATA__BPF_WILDCARD_RULE_PREFIX(T, FIELD)	\
+	T FIELD;						\
+	__u32 FIELD ## _prefix
+
+#define __BPF_WILDCARD_DATA__BPF_WILDCARD_RULE_RANGE(T, FIELD)	\
+	T FIELD ## _min;					\
+	T FIELD ## _max
+
+#define __BPF_WILDCARD_DATA__BPF_WILDCARD_RULE_MATCH(T, FIELD)	\
+	T FIELD
+
+#define __BPF_WILDCARD_DATA_RULE_1(TYPE, T, FIELD, ...) __BPF_WILDCARD_DATA__ ## TYPE (T, FIELD)
+#define __BPF_WILDCARD_DATA_RULE_2(TYPE, T, FIELD, ...) __BPF_WILDCARD_DATA__ ## TYPE (T, FIELD); __BPF_WILDCARD_DATA_RULE_1(__VA_ARGS__)
+#define __BPF_WILDCARD_DATA_RULE_3(TYPE, T, FIELD, ...) __BPF_WILDCARD_DATA__ ## TYPE (T, FIELD); __BPF_WILDCARD_DATA_RULE_2(__VA_ARGS__)
+#define __BPF_WILDCARD_DATA_RULE_4(TYPE, T, FIELD, ...) __BPF_WILDCARD_DATA__ ## TYPE (T, FIELD); __BPF_WILDCARD_DATA_RULE_3(__VA_ARGS__)
+#define __BPF_WILDCARD_DATA_RULE_5(TYPE, T, FIELD, ...) __BPF_WILDCARD_DATA__ ## TYPE (T, FIELD); __BPF_WILDCARD_DATA_RULE_4(__VA_ARGS__)
+
+#define __BPF_WILDCARD_DATA_ELEM_1(TYPE, T, FIELD, ...) T FIELD
+#define __BPF_WILDCARD_DATA_ELEM_2(TYPE, T, FIELD, ...) T FIELD; __BPF_WILDCARD_DATA_ELEM_1(__VA_ARGS__)
+#define __BPF_WILDCARD_DATA_ELEM_3(TYPE, T, FIELD, ...) T FIELD; __BPF_WILDCARD_DATA_ELEM_2(__VA_ARGS__)
+#define __BPF_WILDCARD_DATA_ELEM_4(TYPE, T, FIELD, ...) T FIELD; __BPF_WILDCARD_DATA_ELEM_3(__VA_ARGS__)
+#define __BPF_WILDCARD_DATA_ELEM_5(TYPE, T, FIELD, ...) T FIELD; __BPF_WILDCARD_DATA_ELEM_4(__VA_ARGS__)
+
+#define __BPF_WILDCARD_RULE_DESC(TYPE, T, FIELD, ...)	\
+	struct {					\
+		__uint(type, TYPE);			\
+		__uint(size, sizeof(T)); 		\
+	} FIELD
+
+#define __BPF_WILDCARD_RULE_DESC_1(TYPE, T, FIELD, ...) __BPF_WILDCARD_RULE_DESC(TYPE, T, FIELD)
+#define __BPF_WILDCARD_RULE_DESC_2(TYPE, T, FIELD, ...) __BPF_WILDCARD_RULE_DESC(TYPE, T, FIELD); __BPF_WILDCARD_RULE_DESC_1(__VA_ARGS__)
+#define __BPF_WILDCARD_RULE_DESC_3(TYPE, T, FIELD, ...) __BPF_WILDCARD_RULE_DESC(TYPE, T, FIELD); __BPF_WILDCARD_RULE_DESC_2(__VA_ARGS__)
+#define __BPF_WILDCARD_RULE_DESC_4(TYPE, T, FIELD, ...) __BPF_WILDCARD_RULE_DESC(TYPE, T, FIELD); __BPF_WILDCARD_RULE_DESC_3(__VA_ARGS__)
+#define __BPF_WILDCARD_RULE_DESC_5(TYPE, T, FIELD, ...) __BPF_WILDCARD_RULE_DESC(TYPE, T, FIELD); __BPF_WILDCARD_RULE_DESC_4(__VA_ARGS__)
+
+#define __BPF_WILDCARD_TM_TABLE(PFX, N)      __uint(prefix ## N, PFX)
+#define __BPF_WILDCARD_TM_TABLES_1(PFX)      __BPF_WILDCARD_TM_TABLE(PFX, 1);
+#define __BPF_WILDCARD_TM_TABLES_2(PFX, ...) __BPF_WILDCARD_TM_TABLE(PFX, 2); __BPF_WILDCARD_TM_TABLES_1(__VA_ARGS__)
+#define __BPF_WILDCARD_TM_TABLES_3(PFX, ...) __BPF_WILDCARD_TM_TABLE(PFX, 3); __BPF_WILDCARD_TM_TABLES_2(__VA_ARGS__)
+#define __BPF_WILDCARD_TM_TABLES_4(PFX, ...) __BPF_WILDCARD_TM_TABLE(PFX, 4); __BPF_WILDCARD_TM_TABLES_3(__VA_ARGS__)
+
+#define BPF_WILDCARD_TM_TABLES_1(X, PFX)      struct { __BPF_WILDCARD_TM_TABLE(PFX, 1); } X
+#define BPF_WILDCARD_TM_TABLES_2(X, PFX, ...) struct { __BPF_WILDCARD_TM_TABLE(PFX, 2); __BPF_WILDCARD_TM_TABLES_1(__VA_ARGS__) } X
+#define BPF_WILDCARD_TM_TABLES_3(X, PFX, ...) struct { __BPF_WILDCARD_TM_TABLE(PFX, 3); __BPF_WILDCARD_TM_TABLES_2(__VA_ARGS__) } X
+#define BPF_WILDCARD_TM_TABLES_4(X, PFX, ...) struct { __BPF_WILDCARD_TM_TABLE(PFX, 4); __BPF_WILDCARD_TM_TABLES_3(__VA_ARGS__) } X
+#define BPF_WILDCARD_TM_TABLES_5(X, PFX, ...) struct { __BPF_WILDCARD_TM_TABLE(PFX, 5); __BPF_WILDCARD_TM_TABLES_4(__VA_ARGS__) } X
+
+#define BPF_WILDCARD_TM_OPTS(NAME, ...) struct NAME ## _opts { __VA_ARGS__ }
+
+#define BPF_WILDCARD_DESC_x(x, NAME, ...)						\
+											\
+	struct NAME ## _key {								\
+		__u32 type;								\
+		__u32 priority;								\
+		union {									\
+			struct {							\
+				__BPF_WILDCARD_DATA_RULE_ ## x(__VA_ARGS__);		\
+			} __packed rule;						\
+			struct {							\
+				__BPF_WILDCARD_DATA_ELEM_ ## x(__VA_ARGS__);		\
+			} __packed;							\
+		};									\
+	} __packed;									\
+											\
+	struct NAME ## _desc {								\
+		__uint(n_rules, x);							\
+		__BPF_WILDCARD_RULE_DESC_ ## x(__VA_ARGS__);				\
+	}
+
+#define BPF_WILDCARD_DESC_1(...) BPF_WILDCARD_DESC_x(1, __VA_ARGS__)
+#define BPF_WILDCARD_DESC_2(...) BPF_WILDCARD_DESC_x(2, __VA_ARGS__)
+#define BPF_WILDCARD_DESC_3(...) BPF_WILDCARD_DESC_x(3, __VA_ARGS__)
+#define BPF_WILDCARD_DESC_4(...) BPF_WILDCARD_DESC_x(4, __VA_ARGS__)
+#define BPF_WILDCARD_DESC_5(...) BPF_WILDCARD_DESC_x(5, __VA_ARGS__)
+
 /* BPF syscall commands, see bpf(2) man-page for more details. */
 /**
  * DOC: eBPF Syscall Preamble
@@ -928,6 +1050,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_INODE_STORAGE,
 	BPF_MAP_TYPE_TASK_STORAGE,
 	BPF_MAP_TYPE_BLOOM_FILTER,
+	BPF_MAP_TYPE_WILDCARD,
 };
 
 /* Note that tracing related programs such as
@@ -1312,6 +1435,10 @@ union bpf_attr {
 						   * struct stored as the
 						   * map value
 						   */
+
+		void *map_extra_data;
+		__u32 map_extra_data_size;
+
 		/* Any per-map-type extra fields
 		 *
 		 * BPF_MAP_TYPE_BLOOM_FILTER - the lowest 4 bits indicate the
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 1d49a0352836..f8e64f7505fb 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -170,6 +170,7 @@ int bpf_map_create(enum bpf_map_type map_type,
 		   const struct bpf_map_create_opts *opts)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, map_extra);
+	char map_extra_data[sizeof(opts->map_extra_data)];
 	union bpf_attr attr;
 	int fd;
 
@@ -198,6 +199,13 @@ int bpf_map_create(enum bpf_map_type map_type,
 	attr.numa_node = OPTS_GET(opts, numa_node, 0);
 	attr.map_ifindex = OPTS_GET(opts, map_ifindex, 0);
 
+	attr.map_extra_data_size = OPTS_GET(opts, map_extra_data_size, 0);
+	if (attr.map_extra_data_size) {
+		memcpy(map_extra_data, opts->map_extra_data,
+		       attr.map_extra_data_size);
+		attr.map_extra_data = map_extra_data;
+	}
+
 	fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
 	return libbpf_err_errno(fd);
 }
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 9c50beabdd14..987938e48cfe 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -51,8 +51,11 @@ struct bpf_map_create_opts {
 
 	__u32 numa_node;
 	__u32 map_ifindex;
+
+	__u32 map_extra_data_size;
+	char map_extra_data[1024];
 };
-#define bpf_map_create_opts__last_field map_ifindex
+#define bpf_map_create_opts__last_field map_extra_data
 
 LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
 			      const char *map_name,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3ad139285fad..c5906121a191 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -512,6 +512,8 @@ struct bpf_map {
 	bool reused;
 	bool autocreate;
 	__u64 map_extra;
+	__u32 map_extra_data_size;
+	char map_extra_data[1024];
 };
 
 enum extern_type {
@@ -2120,14 +2122,303 @@ enum libbpf_pin_type {
 	LIBBPF_PIN_BY_NAME,
 };
 
+static int
+__parse_btf_wildcard_tm_opts(const char *msg_pfx, struct btf *btf,
+			     const struct btf_type *opts,
+			     struct wildcard_rule_desc *rule_desc)
+{
+	size_t max_size = ARRAY_SIZE(rule_desc->prefixes);
+	const struct btf_member *m;
+	__u32 vlen, val, i;
+
+	/*
+	 * Parsing the following structure:
+	 *     struct {
+	 *             __uint(prefix3, a);
+	 *             __uint(prefix2, b);
+	 *             __uint(prefix1, c);
+	 *     } xxx;
+	 */
+
+	vlen = btf_vlen(opts);
+	if (vlen > max_size) {
+		pr_warn("map '%s': opts size is too big: %u (max %zu).\n",
+			msg_pfx, vlen, max_size);
+		return -EINVAL;
+	}
+	rule_desc->n_prefixes = vlen;
+
+	m = btf_members(opts);
+	for (i = 0; i < vlen; i++, m++) {
+		if (!get_map_field_int(msg_pfx, btf, m, &val)) {
+			pr_warn("map '%s': invalid field #%u.\n", msg_pfx, i);
+			return -EINVAL;
+		}
+		rule_desc->prefixes[i] = val;
+	}
+
+	return 0;
+}
+
+static int
+parse_btf_wildcard_tm_opts(const char *orig_msg_pfx, struct btf *btf,
+			   const char *rule_name,
+			   const struct btf_type *wildcard_tm_opts,
+			   struct wildcard_rule_desc *rule_desc)
+{
+	const struct btf_member *m;
+	const struct btf_type *t;
+	char msg_pfx[256];
+	const char *name;
+	__u32 vlen, i;
+
+	/*
+	 * The wildcard_tm_opts, if present, can, optionally, contain
+	 * the following structure used in the TM algorithm:
+	 *
+	 *  struct {
+	 *     ...
+	 *     struct {
+	 *             __uint(prefix3, 0);
+	 *             __uint(prefix2, 8);
+	 *             __uint(prefix1, 16);
+	 *     } saddr;
+	 *     ...
+	 *  };
+	 *
+	 * We need to parse it and fill the corresponding fields in the
+	 * rule_desc structure. We don't care about the order, as kernel
+	 * will eventually sort the array.
+	 */
+
+	if (!wildcard_tm_opts)
+		return 0;
+
+	snprintf(msg_pfx, sizeof(msg_pfx), "%s->%s", orig_msg_pfx, "wildcard_tm_opts");
+
+	vlen = btf_vlen(wildcard_tm_opts);
+	m = btf_members(wildcard_tm_opts);
+	for (i = 0; i < vlen; i++, m++) {
+		name = btf__name_by_offset(btf, m->name_off);
+		if (!name) {
+			pr_warn("map '%s': invalid field #%u.\n", msg_pfx, i);
+			return -EINVAL;
+		}
+
+		/* not ours */
+		if (strcmp(rule_name, name))
+			continue;
+
+		t = btf__type_by_id(btf, m->type);
+		if (!t) {
+			pr_warn("map '%s': type [%d] not found.\n", msg_pfx, m->type);
+			return -EINVAL;
+		}
+		if (!btf_is_composite(t)) {
+			pr_warn("map '%s': spec is not STRUCT: %s.\n", msg_pfx, btf_kind_str(t));
+			return -EINVAL;
+		}
+
+		if (__parse_btf_wildcard_tm_opts(msg_pfx, btf, t, rule_desc))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+parse_btf_wildcard_rule_desc(const char *orig_msg_pfx, struct btf *btf,
+			     const char *rule_name,
+			     const struct btf_type *rule_desc_type,
+			     const struct btf_type *wildcard_tm_opts,
+			     struct wildcard_rule_desc *rule_desc)
+{
+	const struct btf_member *m;
+	char msg_pfx[128];
+	__u32 vlen, val, i;
+	const char *name;
+
+	snprintf(msg_pfx, sizeof(msg_pfx), "%s->%s", orig_msg_pfx, rule_name);
+
+	/*
+	 * The rule_desc_type points to the following structure:
+	 *
+	 *     struct {
+	 *             __uint(type, BPF_WILDCARD_RULE_XXX);
+	 *             __uint(size, sizeof(xxx));
+	 *     } saddr;
+	 *
+	 * So we need to extract fields and store them in the rule_desc.
+	 */
+
+	vlen = btf_vlen(rule_desc_type);
+	if (vlen != 2) {
+		pr_warn("map '%s': there should be %u fields, got %u\n",
+			msg_pfx, 2, vlen);
+		return -EINVAL;
+	}
+
+	m = btf_members(rule_desc_type);
+	for (i = 0; i < vlen; i++, m++) {
+		name = btf__name_by_offset(btf, m->name_off);
+		if (!name) {
+			pr_warn("map '%s': invalid field #%u.\n", msg_pfx, i);
+			return -EINVAL;
+		}
+		if (!get_map_field_int(msg_pfx, btf, m, &val))
+			return -EINVAL;
+
+		if (!strcmp(name, "type")) {
+			rule_desc->type = val;
+		} else if (!strcmp(name, "size")) {
+			rule_desc->size = val;
+		} else {
+			pr_warn("map '%s': the field name should be either of {\"type\",\"size\"}, got \"%s\"\n",
+					msg_pfx, name);
+			return -EINVAL;
+		}
+
+		if (parse_btf_wildcard_tm_opts(msg_pfx, btf, rule_name,
+					       wildcard_tm_opts, rule_desc))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int parse_btf_wildcard_desc(const char *map_name, struct btf *btf,
+				   const struct btf_type *wildcard_desc_type,
+				   const struct btf_type *wildcard_tm_opts,
+				   void *map_extra_data,
+				   __u32 *res_map_extra_data_size)
+{
+	/*
+	 * `wildcard_desc_type` has, e.g., the following structure:
+	 *
+	 *     struct capture4_wcard_desc {
+	 *             __uint(n_rules, 4);
+	 *             struct {
+	 *                     __uint(type, BPF_WILDCARD_RULE_PREFIX);
+	 *                     __uint(size, sizeof(__u32));
+	 *             } saddr;
+	 *             struct {
+	 *                     __uint(type, BPF_WILDCARD_RULE_PREFIX);
+	 *                     __uint(size, sizeof(__u32));
+	 *             } daddr;
+	 *             struct {
+	 *                     __uint(type, BPF_WILDCARD_RULE_RANGE);
+	 *                     __uint(size, sizeof(__u16));
+	 *             } sport;
+	 *             struct {
+	 *                     __uint(type, BPF_WILDCARD_RULE_RANGE);
+	 *                     __uint(size, sizeof(__u16));
+	 *             } dport;
+	 *     };
+	 *
+	 * using it we need to fill in the following structure:
+	 *
+	 *     struct wildcard_desc {
+	 *             __u32 n_rules;
+	 *             struct wildcard_rule_desc rule_desc[];
+	 *     };
+	 *
+	 */
+
+	const struct btf_member *m;
+	struct wildcard_desc *desc;
+	const struct btf_type *t;
+	char msg_pfx[64];
+	const char *name;
+	__u32 desc_size;
+	__u32 n_rules;
+	__u32 vlen;
+	__u32 i;
+	int err;
+
+	snprintf(msg_pfx, sizeof(msg_pfx), "%s->wildcard_desc", map_name);
+
+	vlen = btf_vlen(wildcard_desc_type);
+	m = btf_members(wildcard_desc_type);
+
+	/* The first member should be the "n_rules" which specify how large is
+	 * the structure */
+	name = btf__name_by_offset(btf, m->name_off);
+	if (!name) {
+		pr_warn("map '%s': invalid field #0.\n", msg_pfx);
+		return -EINVAL;
+	} else if (strcmp(name, "n_rules")) {
+		pr_warn("map '%s': the first field should be \"n_rules\", got \"%s\"\n",
+			msg_pfx, name);
+		return -EINVAL;
+	}
+	if (!get_map_field_int(msg_pfx, btf, m, &n_rules))
+		return -EINVAL;
+	if (vlen != n_rules + 1) {
+		pr_warn("map '%s': there should be %u fields, got %u\n",
+			msg_pfx, n_rules+1, vlen);
+		return -EINVAL;
+	}
+
+	desc_size = sizeof(*desc) + n_rules * sizeof(desc->rule_desc[0]);
+	if (desc_size > *res_map_extra_data_size) {
+		pr_warn("map '%s': wildcard_desc is too big: %u (max %u).\n",
+			msg_pfx, desc_size, *res_map_extra_data_size);
+		return -EINVAL;
+	}
+
+	desc = calloc(1, desc_size);
+	if (!desc) {
+		pr_warn("map '%s': failed to alloc wildcard_desc.\n", msg_pfx);
+		return -ENOMEM;
+	}
+	desc->n_rules = n_rules;
+
+	err = -EINVAL;
+	for (i = 1; i < vlen; i += 1) {
+		m++;
+
+		name = btf__name_by_offset(btf, m->name_off);
+		if (!name) {
+			pr_warn("map '%s': invalid field #%u.\n", msg_pfx, i);
+			goto free_desc;
+		}
+
+		t = btf__type_by_id(btf, m->type);
+		if (!t) {
+			pr_warn("map '%s': wildcard_desc type [%d] not found.\n",
+					msg_pfx, m->type);
+			goto free_desc;
+		}
+		if (!btf_is_composite(t)) {
+			pr_warn("map '%s': wildcard_desc spec is not STRUCT: %s.\n",
+					msg_pfx, btf_kind_str(t));
+			goto free_desc;
+		}
+
+		if (parse_btf_wildcard_rule_desc(msg_pfx, btf, name, t, wildcard_tm_opts,
+						 &desc->rule_desc[i-1]))
+			goto free_desc;
+	}
+
+	*res_map_extra_data_size = desc_size;
+	memcpy(map_extra_data, desc, desc_size);
+	err = 0;
+free_desc:
+	free(desc);
+	return err;
+}
+
 int parse_btf_map_def(const char *map_name, struct btf *btf,
 		      const struct btf_type *def_t, bool strict,
 		      struct btf_map_def *map_def, struct btf_map_def *inner_def)
 {
+	const struct btf_type *wildcard_desc_type = NULL;
+	const struct btf_type *wildcard_tm_opts = NULL;
 	const struct btf_type *t;
 	const struct btf_member *m;
 	bool is_inner = inner_def == NULL;
 	int vlen, i;
+	__u32 type;
 
 	vlen = btf_vlen(def_t);
 	m = btf_members(def_t);
@@ -2324,6 +2615,53 @@ int parse_btf_map_def(const char *map_name, struct btf *btf,
 				return -EINVAL;
 			map_def->map_extra = map_extra;
 			map_def->parts |= MAP_DEF_MAP_EXTRA;
+		} else if (strcmp(name, "wildcard_desc") == 0) {
+			t = btf__type_by_id(btf, m->type);
+			if (!t) {
+				pr_warn("map '%s': wildcard_desc type [%d] not found.\n",
+					map_name, m->type);
+				return -EINVAL;
+			}
+			if (!btf_is_ptr(t)) {
+				pr_warn("map '%s': wildcard_desc spec is not PTR: %s.\n",
+					map_name, btf_kind_str(t));
+				return -EINVAL;
+			}
+
+			type = t->type;
+			t = btf__type_by_id(btf, type);
+			if (!t) {
+				pr_warn("map '%s': wildcard_desc type definition [%d] not found.\n",
+					map_name, type);
+				return -EINVAL;
+			}
+
+			/* We will parse wildcard_desc type below, after the
+			 * main loop is over because we don't know if map type is BPF_MAP_TYPE_WILDCARD
+			 * or not (and for the latter case we want to return -EINVAL) */
+			wildcard_desc_type = t;
+		} else if (strcmp(name, "wildcard_tm_opts") == 0) {
+			t = btf__type_by_id(btf, m->type);
+			if (!t) {
+				pr_warn("map '%s': wildcard_tm_opts type [%d] not found.\n",
+					map_name, m->type);
+				return -EINVAL;
+			}
+			if (!btf_is_ptr(t)) {
+				pr_warn("map '%s': wildcard_tm_opts spec is not PTR: %s.\n",
+					map_name, btf_kind_str(t));
+				return -EINVAL;
+			}
+			type = t->type;
+			t = btf__type_by_id(btf, type);
+			if (!t) {
+				pr_warn("map '%s': wildcard_tm_opts type definition [%d] not found.\n",
+					map_name, type);
+				return -EINVAL;
+			}
+
+			/* This type is required in the parse_btf_wildcard_desc() below */
+			wildcard_tm_opts = t;
 		} else {
 			if (strict) {
 				pr_warn("map '%s': unknown field '%s'.\n", map_name, name);
@@ -2338,6 +2676,26 @@ int parse_btf_map_def(const char *map_name, struct btf *btf,
 		return -EINVAL;
 	}
 
+	if (wildcard_desc_type || wildcard_tm_opts) {
+		if (map_def->map_type != BPF_MAP_TYPE_WILDCARD) {
+			if (wildcard_desc_type)
+				pr_warn("map '%s': 'wildcard_desc_type' isn't supported for map type %u.\n",
+					map_name, map_def->map_type);
+			if (wildcard_tm_opts)
+				pr_warn("map '%s': 'wildcard_tm_opts' isn't supported for map type %u.\n",
+					map_name, map_def->map_type);
+			return -EINVAL;
+		}
+		map_def->map_extra_data_size = sizeof(map_def->map_extra_data);
+		if (parse_btf_wildcard_desc(map_name, btf,
+					    wildcard_desc_type,
+					    wildcard_tm_opts,
+					    map_def->map_extra_data,
+					    &map_def->map_extra_data_size))
+			return -EINVAL;
+		map_def->parts |= MAP_DEF_MAP_EXTRA_DATA;
+	}
+
 	return 0;
 }
 
@@ -2372,14 +2730,71 @@ static size_t adjust_ringbuf_sz(size_t sz)
 	return sz;
 }
 
+static const char *
+pr_map_extra_data(__u32 map_type, char *buf, ssize_t buf_size, const void *x)
+{
+	const struct wildcard_rule_desc *rule_desc;
+	const struct wildcard_desc *desc;
+	ssize_t nret, n = 0;
+	char err_buf[128];
+	int i, j;
+
+	if (map_type != BPF_MAP_TYPE_WILDCARD) {
+		snprintf(buf, buf_size,
+			 "can't parse map_extra_data due to unsupported map type %d",
+			 map_type);
+	} else {
+		desc = x;
+
+#define _snprintf(...)					\
+	nret = snprintf(buf+n, buf_size-n, __VA_ARGS__);\
+	if (nret < 0) {					\
+		goto print_error;			\
+	}						\
+	n += nret
+
+		_snprintf("{");
+		for (i = 0; i < desc->n_rules; i++) {
+			rule_desc = &desc->rule_desc[i];
+			_snprintf("{type=%u,size=%u", rule_desc->type,rule_desc->size);
+			if (rule_desc->n_prefixes) {
+				_snprintf(",prefixes={");
+				for (j = 0; j < rule_desc->n_prefixes; j++) {
+					_snprintf("%u%s", rule_desc->prefixes[j],
+						  j == rule_desc->n_prefixes-1 ? "" : ",");
+				}
+				_snprintf("}");
+			}
+			_snprintf("}%s", i == desc->n_rules-1 ? "" : ",");
+		}
+		_snprintf("}");
+
+#undef _snprintf
+
+	}
+
+	return buf;
+
+print_error:
+	buf[0] = 0;
+	snprintf(buf, buf_size, "error: %s", strerror_r(errno, err_buf, sizeof(err_buf)));
+	return buf;
+}
+
 static void fill_map_from_def(struct bpf_map *map, const struct btf_map_def *def)
 {
+	char buf[512];
+
 	map->def.type = def->map_type;
 	map->def.key_size = def->key_size;
 	map->def.value_size = def->value_size;
 	map->def.max_entries = def->max_entries;
 	map->def.map_flags = def->map_flags;
 	map->map_extra = def->map_extra;
+	map->map_extra_data_size = def->map_extra_data_size;
+	if (map->map_extra_data_size)
+		memcpy(map->map_extra_data, def->map_extra_data,
+		       map->map_extra_data_size);
 
 	map->numa_node = def->numa_node;
 	map->btf_key_type_id = def->key_type_id;
@@ -2411,6 +2826,10 @@ static void fill_map_from_def(struct bpf_map *map, const struct btf_map_def *def
 	if (def->parts & MAP_DEF_MAP_EXTRA)
 		pr_debug("map '%s': found map_extra = 0x%llx.\n", map->name,
 			 (unsigned long long)def->map_extra);
+	if (def->parts & MAP_DEF_MAP_EXTRA_DATA)
+		pr_debug("map '%s': found map_extra_data = %s.\n", map->name,
+			 pr_map_extra_data(def->map_type, buf, sizeof(buf),
+					   def->map_extra_data));
 	if (def->parts & MAP_DEF_PINNING)
 		pr_debug("map '%s': found pinning = %u.\n", map->name, def->pinning);
 	if (def->parts & MAP_DEF_NUMA_NODE)
@@ -4948,6 +5367,10 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	create_attr.map_flags = def->map_flags;
 	create_attr.numa_node = map->numa_node;
 	create_attr.map_extra = map->map_extra;
+	create_attr.map_extra_data_size = map->map_extra_data_size;
+	if (create_attr.map_extra_data_size)
+		memcpy(create_attr.map_extra_data, map->map_extra_data,
+		       create_attr.map_extra_data_size);
 
 	if (bpf_map__is_struct_ops(map))
 		create_attr.btf_vmlinux_value_type_id = map->btf_vmlinux_value_type_id;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 377642ff51fc..e17a43475fa0 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -241,8 +241,9 @@ enum map_def_parts {
 	MAP_DEF_PINNING		= 0x100,
 	MAP_DEF_INNER_MAP	= 0x200,
 	MAP_DEF_MAP_EXTRA	= 0x400,
+	MAP_DEF_MAP_EXTRA_DATA	= 0x800,
 
-	MAP_DEF_ALL		= 0x7ff, /* combination of all above */
+	MAP_DEF_ALL		= 0xfff, /* combination of all above */
 };
 
 struct btf_map_def {
@@ -257,6 +258,8 @@ struct btf_map_def {
 	__u32 numa_node;
 	__u32 pinning;
 	__u64 map_extra;
+	__u32 map_extra_data_size;
+	char map_extra_data[1024];
 };
 
 int parse_btf_map_def(const char *map_name, struct btf *btf,
-- 
2.34.1

