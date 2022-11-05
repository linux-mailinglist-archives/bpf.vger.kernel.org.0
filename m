Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D9861D7F6
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 07:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiKEGsM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Nov 2022 02:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiKEGsL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Nov 2022 02:48:11 -0400
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6503186D5;
        Fri,  4 Nov 2022 23:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1667630886;
        bh=+gll9StgemKd1xhohwq5I054sJFHK9r5jmDFbD01Ofk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RmlkMG2gfzEnzDUN/LVtIKIon4G/ZI7VsNms7DKRouUE3Ge10s/XSct/oeup7ixmY
         SzOqpIkF7XphVNM3EAuhgXbDPaXeKYY+oDdb9PF5AREPlXrpkvKkOD1IRhr1QDiefj
         jeJIAGoaTVpnVrclEO+GsfT19cc3x7M1YlvqagVM=
Received: from localhost.localdomain ([111.199.189.86])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id C021EA90; Sat, 05 Nov 2022 14:48:02 +0800
X-QQ-mid: xmsmtpt1667630882tixzor47r
Message-ID: <tencent_EBA3C18864069E42175946973C2ACBAF5408@qq.com>
X-QQ-XMAILINFO: NhUkPfKlCtQwXEHQjVhadMm1ARkhXNuiIX/WCZAPi0MgW0+Qw4ZCndktiRfURn
         1idLR/F0pL0XtosEK8T9CHF/uOQtkGURGuQ2uRyluOSe2yr6a44ToLxxBPVaN3kqUxU2od9j/eHo
         vuJlJJQ1JjZhmSh4FoSqcUMnoIzYc47jSUCVSjrBPVuJTLpEVbhkI0bUBrUNolWd8zJ+jPkdM1qY
         ukWlZJlrHCGhs3oev1kYqjhACpCMJnYy5K20SCkN1xyipIIXryxAInJBFJeBOvcRTrIjsUSIsfJS
         BipW3SzJYVMWW4Ie5eoDcjd9Ei/n2vxoNSuXMCE7RBTmTv/XKLqTMA5MBxk1/JGQtQg2U6FWsdzQ
         FFGE9NotzeVX1mW7rGLGXayaHTmbSumJXHsRo7/vEhc1+aoP15hHyHiFUvn/+rc87eqq9zSZSsRA
         qASTPmo30NaSVc2y3zk7x0LY+HJJuXBR1ixNiGeXmxpL31KWg0bXcRJoGblT8NHB5+4OscavNON+
         8Rp7eaI9fh3DTCwtRdjcrP714Xq7ntqMTn9nvuNJ0PTX1aUfChjliU6rXgEISi7l4IJ9QbUbQkfj
         t5du24mADDr0Pl6MEJx9RHi+IgZbbuwOnjuoOmcU9vEBfow0RfmzO0x2tXt4RD6/UuVznMF+LUCs
         Ub9OSWPhLIEZ9j1Cd+mE8BGx81eyE8pW/Ztp7PKms8LySOfpboowE5apCW+wOn0TU0htKRyD8h1W
         JKAuAdAIZnyZTv+ooAP+SXCE75kRkTX5d54LzdvVjbYNBU7uX+77CJGKWjuHlpBiZDPs6MwDm/vO
         XvQ4hOCtrT18HllfdKOMzmZF2EL36RiVfE4xhrP4cqd5d92TDR7U3VkFfxNSX294zmV7gKI3mlA3
         y46HmBj3JrQeAjW7hmj+VkLo7CyI5d1+VDrX1S/QgdjRdVapBXUb5gd5NMRDDJl6Y7TpvebJsAuq
         fahViaEQKZ528M7xrhfVSZSBluVjwGPH4TIjm15IKbGteS9kImLie8fr9fHhHUwEMbSiBvXq4=
From:   Rong Tao <rtoax@foxmail.com>
To:     andrii.nakryiko@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, rongtao@cestc.cn, rtoax@foxmail.com,
        sdf@google.com, song@kernel.org, yhs@fb.com
Subject: [PATCH bpf-next] samples/bpf: Fix sockex3 error: missing BPF prog type
Date:   Sat,  5 Nov 2022 14:48:00 +0800
X-OQ-MSGID: <20221105064800.50494-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <CAEf4BzbZDmgnohyyXBwy+p_qfZ1r_kq6d3bfqig+zSOm65vFHg@mail.gmail.com>
References: <CAEf4BzbZDmgnohyyXBwy+p_qfZ1r_kq6d3bfqig+zSOm65vFHg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

since commit 450b167fb9be("libbpf: clean up SEC() handling"),
sec_def_matches() does not recognize "socket/xxx" as "socket", therefore,
the BPF program type is not recognized.

Instead of sockex3_user.c parsing section names to get the BPF program fd.
We use the program array map to assign a static index to each BPF program
(get inspired by selftests/bpf progs/test_prog_array_init.c).
Therefore, use SEC("socket") as section name instead of SEC("socket/xxx"),
so that the BPF program is parsed to SOCKET_FILTER type. The "missing BPF
prog type" problem is solved.

How to reproduce this error:
$ cd samples/bpf
$ sudo ./sockex3
libbpf: prog 'bpf_func_PARSE_IP': missing BPF prog type, check ELF section name 'socket/3'
libbpf: prog 'bpf_func_PARSE_IP': failed to load: -22
libbpf: failed to load object './sockex3_kern.o'
ERROR: loading BPF object file failed

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 samples/bpf/sockex3_kern.c | 95 ++++++++++++++++++++++----------------
 samples/bpf/sockex3_user.c | 23 ++++-----
 2 files changed, 64 insertions(+), 54 deletions(-)

diff --git a/samples/bpf/sockex3_kern.c b/samples/bpf/sockex3_kern.c
index b363503357e5..26d916834865 100644
--- a/samples/bpf/sockex3_kern.c
+++ b/samples/bpf/sockex3_kern.c
@@ -17,47 +17,12 @@
 #define IP_MF		0x2000
 #define IP_OFFSET	0x1FFF
 
-#define PROG(F) SEC("socket/"__stringify(F)) int bpf_func_##F
-
-struct {
-	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
-	__uint(key_size, sizeof(u32));
-	__uint(value_size, sizeof(u32));
-	__uint(max_entries, 8);
-} jmp_table SEC(".maps");
-
 #define PARSE_VLAN 1
 #define PARSE_MPLS 2
 #define PARSE_IP 3
 #define PARSE_IPV6 4
 
-/* Protocol dispatch routine. It tail-calls next BPF program depending
- * on eth proto. Note, we could have used ...
- *
- *   bpf_tail_call(skb, &jmp_table, proto);
- *
- * ... but it would need large prog_array and cannot be optimised given
- * the map key is not static.
- */
-static inline void parse_eth_proto(struct __sk_buff *skb, u32 proto)
-{
-	switch (proto) {
-	case ETH_P_8021Q:
-	case ETH_P_8021AD:
-		bpf_tail_call(skb, &jmp_table, PARSE_VLAN);
-		break;
-	case ETH_P_MPLS_UC:
-	case ETH_P_MPLS_MC:
-		bpf_tail_call(skb, &jmp_table, PARSE_MPLS);
-		break;
-	case ETH_P_IP:
-		bpf_tail_call(skb, &jmp_table, PARSE_IP);
-		break;
-	case ETH_P_IPV6:
-		bpf_tail_call(skb, &jmp_table, PARSE_IPV6);
-		break;
-	}
-}
+#define PROG_SOCKET_FILTER	SEC("socket")
 
 struct vlan_hdr {
 	__be16 h_vlan_TCI;
@@ -74,6 +39,8 @@ struct flow_key_record {
 	__u32 ip_proto;
 };
 
+static inline void parse_eth_proto(struct __sk_buff *skb, u32 proto);
+
 static inline int ip_is_fragment(struct __sk_buff *ctx, __u64 nhoff)
 {
 	return load_half(ctx, nhoff + offsetof(struct iphdr, frag_off))
@@ -189,7 +156,8 @@ static __always_inline void parse_ip_proto(struct __sk_buff *skb,
 	}
 }
 
-PROG(PARSE_IP)(struct __sk_buff *skb)
+PROG_SOCKET_FILTER
+int bpf_func_ip(struct __sk_buff *skb)
 {
 	struct globals *g = this_cpu_globals();
 	__u32 nhoff, verlen, ip_proto;
@@ -217,7 +185,8 @@ PROG(PARSE_IP)(struct __sk_buff *skb)
 	return 0;
 }
 
-PROG(PARSE_IPV6)(struct __sk_buff *skb)
+PROG_SOCKET_FILTER
+int bpf_func_ipv6(struct __sk_buff *skb)
 {
 	struct globals *g = this_cpu_globals();
 	__u32 nhoff, ip_proto;
@@ -240,7 +209,8 @@ PROG(PARSE_IPV6)(struct __sk_buff *skb)
 	return 0;
 }
 
-PROG(PARSE_VLAN)(struct __sk_buff *skb)
+PROG_SOCKET_FILTER
+int bpf_func_vlan(struct __sk_buff *skb)
 {
 	__u32 nhoff, proto;
 
@@ -256,7 +226,8 @@ PROG(PARSE_VLAN)(struct __sk_buff *skb)
 	return 0;
 }
 
-PROG(PARSE_MPLS)(struct __sk_buff *skb)
+PROG_SOCKET_FILTER
+int bpf_func_mpls(struct __sk_buff *skb)
 {
 	__u32 nhoff, label;
 
@@ -279,7 +250,49 @@ PROG(PARSE_MPLS)(struct __sk_buff *skb)
 	return 0;
 }
 
-SEC("socket/0")
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(key_size, sizeof(u32));
+	__uint(max_entries, 8);
+	__array(values, u32 (void *));
+} prog_array_init SEC(".maps") = {
+	.values = {
+		[PARSE_VLAN] = (void *)&bpf_func_vlan,
+		[PARSE_IP]   = (void *)&bpf_func_ip,
+		[PARSE_IPV6] = (void *)&bpf_func_ipv6,
+		[PARSE_MPLS] = (void *)&bpf_func_mpls,
+	},
+};
+
+/* Protocol dispatch routine. It tail-calls next BPF program depending
+ * on eth proto. Note, we could have used ...
+ *
+ *   bpf_tail_call(skb, &prog_array_init, proto);
+ *
+ * ... but it would need large prog_array and cannot be optimised given
+ * the map key is not static.
+ */
+static inline void parse_eth_proto(struct __sk_buff *skb, u32 proto)
+{
+	switch (proto) {
+	case ETH_P_8021Q:
+	case ETH_P_8021AD:
+		bpf_tail_call(skb, &prog_array_init, PARSE_VLAN);
+		break;
+	case ETH_P_MPLS_UC:
+	case ETH_P_MPLS_MC:
+		bpf_tail_call(skb, &prog_array_init, PARSE_MPLS);
+		break;
+	case ETH_P_IP:
+		bpf_tail_call(skb, &prog_array_init, PARSE_IP);
+		break;
+	case ETH_P_IPV6:
+		bpf_tail_call(skb, &prog_array_init, PARSE_IPV6);
+		break;
+	}
+}
+
+PROG_SOCKET_FILTER
 int main_prog(struct __sk_buff *skb)
 {
 	__u32 nhoff = ETH_HLEN;
diff --git a/samples/bpf/sockex3_user.c b/samples/bpf/sockex3_user.c
index cd6fa79df900..56044acbd25d 100644
--- a/samples/bpf/sockex3_user.c
+++ b/samples/bpf/sockex3_user.c
@@ -24,10 +24,9 @@ struct pair {
 
 int main(int argc, char **argv)
 {
-	int i, sock, key, fd, main_prog_fd, jmp_table_fd, hash_map_fd;
+	int i, sock, fd, main_prog_fd, hash_map_fd;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
-	const char *section;
 	char filename[256];
 	FILE *f;
 
@@ -45,26 +44,24 @@ int main(int argc, char **argv)
 		goto cleanup;
 	}
 
-	jmp_table_fd = bpf_object__find_map_fd_by_name(obj, "jmp_table");
 	hash_map_fd = bpf_object__find_map_fd_by_name(obj, "hash_map");
-	if (jmp_table_fd < 0 || hash_map_fd < 0) {
+	if (hash_map_fd < 0) {
 		fprintf(stderr, "ERROR: finding a map in obj file failed\n");
 		goto cleanup;
 	}
 
+	/* find BPF main program */
+	main_prog_fd = 0;
 	bpf_object__for_each_program(prog, obj) {
 		fd = bpf_program__fd(prog);
 
-		section = bpf_program__section_name(prog);
-		if (sscanf(section, "socket/%d", &key) != 1) {
-			fprintf(stderr, "ERROR: finding prog failed\n");
-			goto cleanup;
-		}
-
-		if (key == 0)
+		if (!strcmp(bpf_program__name(prog), "main_prog"))
 			main_prog_fd = fd;
-		else
-			bpf_map_update_elem(jmp_table_fd, &key, &fd, BPF_ANY);
+	}
+
+	if (main_prog_fd == 0) {
+		fprintf(stderr, "ERROR: can't find main_prog\n");
+		goto cleanup;
 	}
 
 	sock = open_raw_sock("lo");
-- 
2.31.1

