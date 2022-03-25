Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BFC4E6DC2
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 06:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354761AbiCYFbk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 25 Mar 2022 01:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354825AbiCYFbi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 01:31:38 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA2B583A8
        for <bpf@vger.kernel.org>; Thu, 24 Mar 2022 22:30:04 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22P0IYjO027218
        for <bpf@vger.kernel.org>; Thu, 24 Mar 2022 22:30:04 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f02uw6mt3-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 24 Mar 2022 22:30:04 -0700
Received: from twshared4295.42.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 22:30:02 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 89EDF14CB0B96; Thu, 24 Mar 2022 22:29:53 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 4/7] libbpf: wire up spec management and other arch-independent USDT logic
Date:   Thu, 24 Mar 2022 22:29:38 -0700
Message-ID: <20220325052941.3526715-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220325052941.3526715-1-andrii@kernel.org>
References: <20220325052941.3526715-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7ubKxmpWtY5OCTws_q6Hfmm8jdG5AKtu
X-Proofpoint-GUID: 7ubKxmpWtY5OCTws_q6Hfmm8jdG5AKtu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_01,2022-03-24_01,2022-02-23_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Last part of architecture-agnostic user-space USDT handling logic is to
set up BPF spec and, optionally, IP-to-ID maps from user-space.
usdt_manager performs a compact spec ID allocation to utilize
fixed-sized BPF maps as efficiently as possible. We also use hashmap to
deduplicate USDT arg spec strings and map identical strings to single
USDT spec, minimizing the necessary BPF map size. usdt_manager supports
arbitrary sequences of attachment and detachment, both of the same USDT
and multiple different USDTs and internally maintains a free list of
unused spec IDs. bpf_link_usdt's logic is extended with proper setup and
teardown of this spec ID free list and supporting BPF maps.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/usdt.c | 167 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 166 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 86d5d8390eb1..22f5f56992f8 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -74,6 +74,10 @@ struct usdt_manager {
 	struct bpf_map *specs_map;
 	struct bpf_map *ip_to_id_map;
 
+	int *free_spec_ids;
+	size_t free_spec_cnt;
+	size_t next_free_spec_id;
+
 	bool has_bpf_cookie;
 	bool has_sema_refcnt;
 };
@@ -118,6 +122,7 @@ void usdt_manager_free(struct usdt_manager *man)
 	if (!man)
 		return;
 
+	free(man->free_spec_ids);
 	free(man);
 }
 
@@ -623,6 +628,9 @@ struct bpf_link_usdt {
 
 	struct usdt_manager *usdt_man;
 
+	size_t spec_cnt;
+	int *spec_ids;
+
 	size_t uprobe_cnt;
 	struct {
 		long abs_ip;
@@ -633,11 +641,52 @@ struct bpf_link_usdt {
 static int bpf_link_usdt_detach(struct bpf_link *link)
 {
 	struct bpf_link_usdt *usdt_link = container_of(link, struct bpf_link_usdt, link);
+	struct usdt_manager *man = usdt_link->usdt_man;
 	int i;
 
 	for (i = 0; i < usdt_link->uprobe_cnt; i++) {
 		/* detach underlying uprobe link */
 		bpf_link__destroy(usdt_link->uprobes[i].link);
+		/* there is no need to update specs map because it will be
+		 * unconditionally overwritten on subsequent USDT attaches,
+		 * but if BPF cookies are not used we need to remove entry
+		 * from ip_to_id map, otherwise we'll run into false
+		 * conflicting IP errors
+		 */
+		if (!man->has_bpf_cookie) {
+			/* not much we can do about errors here */
+			(void)bpf_map_delete_elem(bpf_map__fd(man->ip_to_id_map),
+						  &usdt_link->uprobes[i].abs_ip);
+		}
+	}
+
+	/* try to return the list of previously used spec IDs to usdt_manager
+	 * for future reuse for subsequent USDT attaches
+	 */
+	if (!man->free_spec_ids) {
+		/* if there were no free spec IDs yet, just transfer our IDs */
+		man->free_spec_ids = usdt_link->spec_ids;
+		man->free_spec_cnt = usdt_link->spec_cnt;
+		usdt_link->spec_ids = NULL;
+	} else {
+		/* otherwise concat IDs */
+		size_t new_cnt = man->free_spec_cnt + usdt_link->spec_cnt;
+		int *new_free_ids;
+
+		new_free_ids = libbpf_reallocarray(man->free_spec_ids, new_cnt,
+						   sizeof(*new_free_ids));
+		/* If we couldn't resize free_spec_ids, we'll just leak
+		 * a bunch of free IDs; this is very unlikely to happen and if
+		 * system is so exausted on memory, it's the least of user's
+		 * concerns, probably.
+		 * So just do our best here to return those IDs to usdt_manager.
+		 */
+		if (new_free_ids) {
+			memcpy(new_free_ids + man->free_spec_cnt, usdt_link->spec_ids,
+			       usdt_link->spec_cnt * sizeof(*usdt_link->spec_ids));
+			man->free_spec_ids = new_free_ids;
+			man->free_spec_cnt = new_cnt;
+		}
 	}
 
 	return 0;
@@ -647,17 +696,82 @@ static void bpf_link_usdt_dealloc(struct bpf_link *link)
 {
 	struct bpf_link_usdt *usdt_link = container_of(link, struct bpf_link_usdt, link);
 
+	free(usdt_link->spec_ids);
 	free(usdt_link->uprobes);
 	free(usdt_link);
 }
 
+static int prepare_spec_id(struct usdt_manager *man, struct bpf_link_usdt *link,
+			   struct hashmap *specs_hash, struct usdt_target *target,
+			   int *spec_id, bool *id_exists)
+{
+	void *tmp;
+	bool reused;
+	int err;
+
+	/* check if we already assigned spec ID for this spec string */
+	if (hashmap__find(specs_hash, target->spec_str, &tmp)) {
+		*id_exists = true;
+		*spec_id = (long)tmp;
+		return 0;
+	}
+
+	/* otherwise get next free spec ID, giving preference to free list */
+	tmp = libbpf_reallocarray(link->spec_ids, link->spec_cnt + 1, sizeof(*link->spec_ids));
+	if (!tmp)
+		return -ENOMEM;
+	link->spec_ids = tmp;
+
+	if (man->free_spec_cnt) {
+		*spec_id = man->free_spec_ids[man->free_spec_cnt - 1];
+		man->free_spec_cnt--;
+		reused = true;
+	} else {
+		*spec_id = man->next_free_spec_id;
+		man->next_free_spec_id++;
+		reused = false;
+	}
+
+	/* cache spec ID for current spec string for future lookups */
+	err = hashmap__add(specs_hash, target->spec_str, (void *)(long)*spec_id);
+	if (err) {
+		/* undo usdt_manager state changes, if we got an error */
+		if (reused)
+			man->free_spec_cnt++;
+		else
+			man->next_free_spec_id--;
+		return err;
+	}
+
+	*id_exists = false;
+	link->spec_ids[link->spec_cnt] = *spec_id;
+	link->spec_cnt++;
+	return 0;
+}
+
+static size_t specs_hash_fn(const void *key, void *ctx)
+{
+	const char *s = key;
+
+	return str_hash(s);
+}
+
+static bool specs_equal_fn(const void *key1, const void *key2, void *ctx)
+{
+	const char *s1 = key1;
+	const char *s2 = key2;
+
+	return strcmp(s1, s2) == 0;
+}
+
 struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct bpf_program *prog,
 					  pid_t pid, const char *path,
 					  const char *usdt_provider, const char *usdt_name,
 					  long usdt_cookie)
 {
-	int i, fd, err;
+	int i, fd, err, spec_map_fd, ip_map_fd;
 	LIBBPF_OPTS(bpf_uprobe_opts, opts);
+	struct hashmap *specs_hash = NULL;
 	struct bpf_link_usdt *link = NULL;
 	struct usdt_target *targets = NULL;
 	size_t target_cnt;
@@ -669,6 +783,9 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 		return libbpf_err_ptr(-EINVAL);
 	}
 
+	spec_map_fd = bpf_map__fd(man->specs_map);
+	ip_map_fd = bpf_map__fd(man->ip_to_id_map);
+
 	/* TODO: perform path resolution similar to uprobe's */
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
@@ -704,6 +821,12 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 		goto err_out;
 	}
 
+	specs_hash = hashmap__new(specs_hash_fn, specs_equal_fn, NULL);
+	if (IS_ERR(specs_hash)) {
+		err = PTR_ERR(specs_hash);
+		goto err_out;
+	}
+
 	link = calloc(1, sizeof(*link));
 	if (!link) {
 		err = -ENOMEM;
@@ -723,8 +846,48 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 	for (i = 0; i < target_cnt; i++) {
 		struct usdt_target *target = &targets[i];
 		struct bpf_link *uprobe_link;
+		bool reused;
+		int spec_id;
+
+		/* Spec ID can be either reused or newly allocated. If it is
+		 * newly allocated, we'll need to fill out spec map, otherwise
+		 * entire spec should be valid and can be just used by a new
+		 * uprobe. We reuse spec when USDT arg spec is identical. We
+		 * also never share specs between two different USDT
+		 * attachments ("links"), so all the reused specs already
+		 * share USDT cookie value implicitly.
+		 */
+		err = prepare_spec_id(man, link, specs_hash, target, &spec_id, &reused);
+		if (err)
+			goto err_out;
+
+		if (!reused &&
+		    bpf_map_update_elem(spec_map_fd, &spec_id, &target->spec, BPF_ANY)) {
+			err = -errno;
+			pr_warn("usdt: failed to set USDT spec #%d for '%s:%s' in '%s': %d\n",
+				spec_id, usdt_provider, usdt_name, path, err);
+			/* make sure we don't return this bad spec ID into the
+			 * pool of free spec IDs
+			 */
+			link->spec_cnt--;
+			goto err_out;
+		}
+		if (!man->has_bpf_cookie &&
+		    bpf_map_update_elem(ip_map_fd, &target->abs_ip, &spec_id, BPF_NOEXIST)) {
+			err = -errno;
+			if (err == -EEXIST) {
+				pr_warn("usdt: IP collision detected for spec #%d for '%s:%s' in '%s'\n",
+				        spec_id, usdt_provider, usdt_name, path);
+			} else {
+				pr_warn("usdt: failed to map IP 0x%lx to spec #%d for '%s:%s' in '%s': %d\n",
+					target->abs_ip, spec_id, usdt_provider, usdt_name,
+					path, err);
+			}
+			goto err_out;
+		}
 
 		opts.ref_ctr_offset = target->sema_off;
+		opts.bpf_cookie = man->has_bpf_cookie ? spec_id : 0;
 		uprobe_link = bpf_program__attach_uprobe_opts(prog, pid, path,
 							      target->rel_ip, &opts);
 		err = libbpf_get_error(link);
@@ -740,6 +903,7 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 	}
 
 	free(targets);
+	hashmap__free(specs_hash);
 	elf_end(elf);
 	close(fd);
 
@@ -749,6 +913,7 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 	bpf_link__destroy(&link->link);
 
 	free(targets);
+	hashmap__free(specs_hash);
 	if (elf)
 		elf_end(elf);
 	close(fd);
-- 
2.30.2

