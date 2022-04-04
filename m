Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805F24F20E9
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 06:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiDECiO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 4 Apr 2022 22:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiDECiF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 22:38:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568D0235742
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 18:37:18 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 234NPIPY005698
        for <bpf@vger.kernel.org>; Mon, 4 Apr 2022 16:42:23 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f6m6hx04u-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 04 Apr 2022 16:42:23 -0700
Received: from twshared20084.04.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 4 Apr 2022 16:42:20 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 9C69E1661B521; Mon,  4 Apr 2022 16:42:11 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v3 bpf-next 4/7] libbpf: wire up spec management and other arch-independent USDT logic
Date:   Mon, 4 Apr 2022 16:41:59 -0700
Message-ID: <20220404234202.331384-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404234202.331384-1-andrii@kernel.org>
References: <20220404234202.331384-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gP-bpvzceknhZHbZOKEgngD0wqoK9FNJ
X-Proofpoint-GUID: gP-bpvzceknhZHbZOKEgngD0wqoK9FNJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_09,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/usdt.c | 168 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 167 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index f1670e3014ed..2799387c5465 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -239,6 +239,10 @@ struct usdt_manager {
 	struct bpf_map *specs_map;
 	struct bpf_map *ip_to_spec_id_map;
 
+	int *free_spec_ids;
+	size_t free_spec_cnt;
+	size_t next_free_spec_id;
+
 	bool has_bpf_cookie;
 	bool has_sema_refcnt;
 };
@@ -283,6 +287,7 @@ void usdt_manager_free(struct usdt_manager *man)
 	if (IS_ERR_OR_NULL(man))
 		return;
 
+	free(man->free_spec_ids);
 	free(man);
 }
 
@@ -789,6 +794,9 @@ struct bpf_link_usdt {
 
 	struct usdt_manager *usdt_man;
 
+	size_t spec_cnt;
+	int *spec_ids;
+
 	size_t uprobe_cnt;
 	struct {
 		long abs_ip;
@@ -799,11 +807,52 @@ struct bpf_link_usdt {
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
+		 * from ip_to_spec_id map, otherwise we'll run into false
+		 * conflicting IP errors
+		 */
+		if (!man->has_bpf_cookie) {
+			/* not much we can do about errors here */
+			(void)bpf_map_delete_elem(bpf_map__fd(man->ip_to_spec_id_map),
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
@@ -813,22 +862,96 @@ static void bpf_link_usdt_dealloc(struct bpf_link *link)
 {
 	struct bpf_link_usdt *usdt_link = container_of(link, struct bpf_link_usdt, link);
 
+	free(usdt_link->spec_ids);
 	free(usdt_link->uprobes);
 	free(usdt_link);
 }
 
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
+static int allocate_spec_id(struct usdt_manager *man, struct hashmap *specs_hash,
+			    struct bpf_link_usdt *link, struct usdt_target *target,
+			    int *spec_id, bool *is_new)
+{
+	void *tmp;
+	int err;
+
+	/* check if we already allocated spec ID for this spec string */
+	if (hashmap__find(specs_hash, target->spec_str, &tmp)) {
+		*spec_id = (long)tmp;
+		*is_new = false;
+		return 0;
+	}
+
+	/* otherwise it's a new ID that needs to be set up in specs map and
+	 * returned back to usdt_manager when USDT link is detached
+	 */
+	tmp = libbpf_reallocarray(link->spec_ids, link->spec_cnt + 1, sizeof(*link->spec_ids));
+	if (!tmp)
+		return -ENOMEM;
+	link->spec_ids = tmp;
+
+	/* get next free spec ID, giving preference to free list, if not empty */
+	if (man->free_spec_cnt) {
+		*spec_id = man->free_spec_ids[man->free_spec_cnt - 1];
+
+		/* cache spec ID for current spec string for future lookups */
+		err = hashmap__add(specs_hash, target->spec_str, (void *)(long)*spec_id);
+		if (err)
+			 return err;
+
+		man->free_spec_cnt--;
+	} else {
+		/* don't allocate spec ID bigger than what fits in specs map */
+		if (man->next_free_spec_id >= bpf_map__max_entries(man->specs_map))
+			return -E2BIG;
+
+		*spec_id = man->next_free_spec_id;
+
+		/* cache spec ID for current spec string for future lookups */
+		err = hashmap__add(specs_hash, target->spec_str, (void *)(long)*spec_id);
+		if (err)
+			 return err;
+
+		man->next_free_spec_id++;
+	}
+
+	/* remember new spec ID in the link for later return back to free list on detach */
+	link->spec_ids[link->spec_cnt] = *spec_id;
+	link->spec_cnt++;
+	*is_new = true;
+	return 0;
+}
+
 struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct bpf_program *prog,
 					  pid_t pid, const char *path,
 					  const char *usdt_provider, const char *usdt_name,
 					  long usdt_cookie)
 {
+	int i, fd, err, spec_map_fd, ip_map_fd;
 	LIBBPF_OPTS(bpf_uprobe_opts, opts);
+	struct hashmap *specs_hash = NULL;
 	struct bpf_link_usdt *link = NULL;
 	struct usdt_target *targets = NULL;
 	size_t target_cnt;
-	int i, fd, err;
 	Elf *elf;
 
+	spec_map_fd = bpf_map__fd(man->specs_map);
+	ip_map_fd = bpf_map__fd(man->ip_to_spec_id_map);
+
 	/* TODO: perform path resolution similar to uprobe's */
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
@@ -864,6 +987,12 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
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
@@ -883,8 +1012,43 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 	for (i = 0; i < target_cnt; i++) {
 		struct usdt_target *target = &targets[i];
 		struct bpf_link *uprobe_link;
+		bool is_new;
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
+		err = allocate_spec_id(man, specs_hash, link, target, &spec_id, &is_new);
+		if (err)
+			goto err_out;
+
+		if (is_new && bpf_map_update_elem(spec_map_fd, &spec_id, &target->spec, BPF_ANY)) {
+			err = -errno;
+			pr_warn("usdt: failed to set USDT spec #%d for '%s:%s' in '%s': %d\n",
+				spec_id, usdt_provider, usdt_name, path, err);
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
 		err = libbpf_get_error(uprobe_link);
@@ -900,6 +1064,7 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 	}
 
 	free(targets);
+	hashmap__free(specs_hash);
 	elf_end(elf);
 	close(fd);
 
@@ -909,6 +1074,7 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 	bpf_link__destroy(&link->link);
 
 	free(targets);
+	hashmap__free(specs_hash);
 	if (elf)
 		elf_end(elf);
 	close(fd);
-- 
2.30.2

