Return-Path: <bpf+bounces-1259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A18711AF0
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 02:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033CA28163C
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 00:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9349D1C26;
	Fri, 26 May 2023 00:00:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF69136A
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 00:00:47 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F419C;
	Thu, 25 May 2023 17:00:45 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f4bd608cf4so84151e87.1;
        Thu, 25 May 2023 17:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685059243; x=1687651243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9kWBvWIUbg78256b1umES+hb4psNSbCISwF5e8PRTo=;
        b=AaFoMPOp9UKOiR2IQLAt35sRqkhW6KSi6PQP9FMKDqQnLJUvSs3dawUn6T98PZeBvX
         +dYzBv405Y+dH7hWEl+xL1Rs+rN3IPrzITh/LXpc/4RmWXteNtPV2BvNn/+jAaWE9vjL
         3tVyJp2TO9D9ucGjwuQjeW08rxqfFrhH71olxdINuPfG9uRncRItVGso6IQ93tXdHoU+
         /J6limNIsMyAir18iXt+7AijAlEp6Sv9oiw1qcrXlh0UmEZ9dHeDDJ8+lc8ztfJvlYAg
         UUC3tuhlaQZmueOUVB45PbiMpdt+5MXbDPne3uj9HkDyEApwkGFzTXoYqn6CvFdnBXbI
         scDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685059243; x=1687651243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9kWBvWIUbg78256b1umES+hb4psNSbCISwF5e8PRTo=;
        b=Q/DLK2WoYQ2sjuHOBjmBa68jdKaZQVqRjRpW99ViLwKOig5Adb8UlW0mCXFpSburqy
         mnj2cNSGLx2Br3Cuq/fo2S/9Uau6CV622XS3F1nLkfSTyxsWsi5h4pLzThLRV/Xim3IS
         MDIkS7LRP3l3wP1gzIsdlYUZTEC+0+t69TpntPfN3UzlSphtT8VN8czkuhCEopwzr+Vm
         GOT1ovKK0b97kg4xlPwpJAExw493QbpkcMGTpwNXQT77uuzliHJDFUExfkrnN1ydZNe3
         AJ06VMT03ZZOCpsVoTIJU92ygBzN0TEZtdhOape39VnJxRNDWDYLprKIF5za2Ccr+Kfn
         lvYA==
X-Gm-Message-State: AC+VfDySEZE0AkD3kTSK0Tw1tYLDjo7H+fjB2Fh+A1+W64k0WhRY++oQ
	gui8kkLnCsT1BmIj+2GUYhXBo6t/B/JoiQ==
X-Google-Smtp-Source: ACHHUZ7cc/6xqPOqeZrL9U6UpddxF5CaRnK81xF5I5kl8Ccmnqv8BjxQxfETa7+LwfY0YWkuVGBh+w==
X-Received: by 2002:ac2:5183:0:b0:4f4:6189:1d0 with SMTP id u3-20020ac25183000000b004f4618901d0mr5184342lfi.7.1685059242933;
        Thu, 25 May 2023 17:00:42 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id r2-20020a19ac42000000b004f38717ca34sm383761lfc.97.2023.05.25.17.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 17:00:42 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: dwarves@vger.kernel.org,
	arnaldo.melo@gmail.com
Cc: bpf@vger.kernel.org,
	kernel-team@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yhs@fb.com,
	mykolal@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH dwarves] pahole: avoid adding same struct structure to two rb trees
Date: Fri, 26 May 2023 02:59:49 +0300
Message-Id: <20230525235949.2978377-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When pahole is executed in '-F dwarf --sort' mode there are two places
where 'struct structure' instance could be added to the rb_tree:

The first is triggered from the following call stack:

  print_classes()
    structures__add()
      __structures__add()
        (adds to global pahole.c:structures__tree)

The second is triggered from the following call stack:

  print_ordered_classes()
    resort_classes()
      resort_add()
        (adds to local rb_tree instance)

Both places use the same 'struct structure::rb_node' field, so if both
code pathes are executed the final state of the 'structures__tree'
might be inconsistent.

For example, this could be observed when DEBUG_CHECK_LEAKS build flag
is set. Here is the command line snippet that eventually leads to a
segfault:

  $ for i in $(seq 1 100); do \
      echo $i; \
      pahole -F dwarf --flat_arrays --sort --jobs vmlinux > /dev/null \
             || break; \
    done

GDB shows the following stack trace:

  Thread 1 "pahole" received signal SIGSEGV, Segmentation fault.
  0x00007ffff7f819ad in __rb_erase_color (node=0x7fffd4045830, parent=0x0, root=0x5555555672d8 <structures.tree>) at /home/eddy/work/dwarves-fork/rbtree.c:134
  134			if (parent->rb_left == node)
  (gdb) bt
  #0  0x00007ffff7f819ad in __rb_erase_color (node=0x7fffd4045830, parent=0x0, root=0x5555555672d8 <structures.tree>) at /home/eddy/work/dwarves-fork/rbtree.c:134
  #1  0x00007ffff7f82014 in rb_erase (node=0x7fff21ae5b80, root=0x5555555672d8 <structures.tree>) at /home/eddy/work/dwarves-fork/rbtree.c:275
  #2  0x0000555555559c3d in __structures__delete () at /home/eddy/work/dwarves-fork/pahole.c:440
  #3  0x0000555555559c70 in structures__delete () at /home/eddy/work/dwarves-fork/pahole.c:448
  #4  0x0000555555560bb6 in main (argc=13, argv=0x7fffffffdcd8) at /home/eddy/work/dwarves-fork/pahole.c:3584

This commit modifies resort_classes() to re-use 'structures__tree' and
to reset 'rb_node' fields before adding structure instances to the
tree for a second time.

Lock/unlock structures_lock to be consistent with structures_add() and
structures__delete() code.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 pahole.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/pahole.c b/pahole.c
index 6fc4ed6..576733f 100644
--- a/pahole.c
+++ b/pahole.c
@@ -621,9 +621,9 @@ static void print_classes(struct cu *cu)
 	}
 }
 
-static void __print_ordered_classes(struct rb_root *root)
+static void __print_ordered_classes(void)
 {
-	struct rb_node *next = rb_first(root);
+	struct rb_node *next = rb_first(&structures__tree);
 
 	while (next) {
 		struct structure *st = rb_entry(next, struct structure, rb_node);
@@ -660,24 +660,39 @@ static void resort_add(struct rb_root *resorted, struct structure *str)
 	rb_insert_color(&str->rb_node, resorted);
 }
 
-static void resort_classes(struct rb_root *resorted, struct list_head *head)
+static void resort_classes(void)
 {
 	struct structure *str;
 
-	list_for_each_entry(str, head, node)
-		resort_add(resorted, str);
+	pthread_mutex_lock(&structures_lock);
+
+	/* The need_resort flag is set by type__compare_members()
+	 * within the following call stack:
+	 *
+	 *   print_classes()
+	 *     structures__add()
+	 *       __structures__add()
+	 *         type__compare()
+	 *
+	 * The call to structures__add() registers 'struct structures'
+	 * instances in both 'structures__tree' and 'structures__list'.
+	 * In order to avoid adding same node to the tree twice reset
+	 * both the 'structures__tree' and 'str->rb_node'.
+	 */
+	structures__tree = RB_ROOT;
+	list_for_each_entry(str, &structures__list, node) {
+		bzero(&str->rb_node, sizeof(str->rb_node));
+		resort_add(&structures__tree, str);
+	}
+
+	pthread_mutex_unlock(&structures_lock);
 }
 
 static void print_ordered_classes(void)
 {
-	if (!need_resort) {
-		__print_ordered_classes(&structures__tree);
-	} else {
-		struct rb_root resorted = RB_ROOT;
-
-		resort_classes(&resorted, &structures__list);
-		__print_ordered_classes(&resorted);
-	}
+	if (need_resort)
+		resort_classes();
+	__print_ordered_classes();
 }
 
 
-- 
2.40.1


