Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F7646FE04
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 10:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbhLJJnf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 04:43:35 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:59454 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232524AbhLJJne (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Dec 2021 04:43:34 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=chengshuyi@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0V-8nwzU_1639129198;
Received: from 30.225.28.43(mailfrom:chengshuyi@linux.alibaba.com fp:SMTPD_---0V-8nwzU_1639129198)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 17:39:58 +0800
Message-ID: <eb53035b-bf91-674f-2227-cd01ba820935@linux.alibaba.com>
Date:   Fri, 10 Dec 2021 17:39:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
To:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
From:   Shuyi Cheng <chengshuyi@linux.alibaba.com>
Subject: [PATCH bpf-next v3] libbpf: add "bool skipped" to struct bpf_map
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix error: "failed to pin map: Bad file descriptor, path:
/sys/fs/bpf/_rodata_str1_1."

In the old kernel, the global data map will not be created, see [0]. So
we should skip the pinning of the global data map to avoid
bpf_object__pin_maps returning error. Therefore, when the map is not
created, we mark “map->skipped" as true and then check during relocation
and during pinning.

Signed-off-by: Shuyi Cheng <chengshuyi@linux.alibaba.com>
---
v2: 
https://lore.kernel.org/bpf/CAEf4Bzbxf4kEtCEWBSonomEp7ZiKBD50k-U941i=okKfgKb6FQ@mail.gmail.com/T/#mb884d33b1b5b8e5dfb5a362af0d3c025510b5a4c
v2->v3:
-- adjust the "bool skipped" position

v1: 
https://lore.kernel.org/bpf/CAEf4BzbtQGnGZTLbTdy1GHK54f5S7YNFQak7BuEfaqGEwqNNJA@mail.gmail.com/T/#m80ec7f8bc69dbcf4a5945e2aa6f16145901afc40
v1->v2:
-- add "bool skipped" to struct bpf_map.
-- replace "bpf_map__is_internal(map) && !kernel_supports(obj, 
FEAT_GLOBAL_DATA))" with map->skipped

  tools/lib/bpf/libbpf.c | 11 ++++++++---
  1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 18d95c6a89fe..d027e1d620fc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -431,6 +431,7 @@ struct bpf_map {
  	char *pin_path;
  	bool pinned;
  	bool reused;
+	bool skipped;
  	__u64 map_extra;
  };

@@ -5087,8 +5088,10 @@ bpf_object__create_maps(struct bpf_object *obj)
  		 * kernels.
  		 */
  		if (bpf_map__is_internal(map) &&
-		    !kernel_supports(obj, FEAT_GLOBAL_DATA))
+		    !kernel_supports(obj, FEAT_GLOBAL_DATA)) {
+			map->skipped = true;
  			continue;
+		}

  		retried = false;
  retry:
@@ -5717,8 +5720,7 @@ bpf_object__relocate_data(struct bpf_object *obj, 
struct bpf_program *prog)
  			} else {
  				const struct bpf_map *map = &obj->maps[relo->map_idx];

-				if (bpf_map__is_internal(map) &&
-				    !kernel_supports(obj, FEAT_GLOBAL_DATA)) {
+				if (map->skipped) {
  					pr_warn("prog '%s': relo #%d: kernel doesn't support global data\n",
  						prog->name, i);
  					return -ENOTSUP;
@@ -7926,6 +7928,9 @@ int bpf_object__pin_maps(struct bpf_object *obj, 
const char *path)
  		char *pin_path = NULL;
  		char buf[PATH_MAX];

+		if (map->skipped)
+			continue;
+
  		if (path) {
  			int len;

-- 
2.19.1.6.gb485710b
