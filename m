Return-Path: <bpf+bounces-8326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 496A0784DAD
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 02:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F261C28101B
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 00:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BEB1851;
	Wed, 23 Aug 2023 00:08:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03207E
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 00:08:58 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0EF133;
	Tue, 22 Aug 2023 17:08:57 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 487AC3200945;
	Tue, 22 Aug 2023 20:08:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 22 Aug 2023 20:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1692749335; x=
	1692835735; bh=gXxP7iiK/oU+8bBrOR/Op7LOLROQaeDwd9FAhyRGKto=; b=N
	ZFvkIYWasrUZ92HTq+WxrnmcrWiSMLW79bGOFkfmoc3+YeI/yN97dTBgGZlXxbme
	t63XGA7EHIYTFxj2shjqxW+doDvhWe6TaMyo2oeYX3+kMCTo8irQzl+qNLm8TKjC
	9YDvTEQHrSnWJ5v+3waDzghP+kYHhCiEdx2t+Tc7I+Xw6GqZsaSTTcEgEttaWwRg
	4JgPa5nx52P6kaQw81IHU89x112zqGayEnwIPV2dq5gTfbfEH2J4O5yeY1Zcz+2F
	8TfCvANDaUj8K7jj2Kpqh5HBRQm2XFD14SQ582a/Aavjlc72H/0jlbdTNdxGAiEE
	ZVd3L0PZYPmrvnnO3acsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1692749335; x=
	1692835735; bh=gXxP7iiK/oU+8bBrOR/Op7LOLROQaeDwd9FAhyRGKto=; b=e
	upTK5XhQv3QuIsN5Ijmt548J11UcS+GzxscRNQR6pDb7Jjc+95XLfIt9oOWkYE8T
	GB+K5Keo01Ihoqcp+8C3kn9qozR/gTOfpP/nhKvc1tt0ZUVo/lmSpBtYAiy9P7dP
	kUeT6vn/jSxjbtNNiCWNEf5ZNJlaspzgsNZpF9GQ4mYsM0J8zJxxvVSpST4MBF4E
	IlboBiNL3iq1It0EMpntc/bs9HuXlR10wk1P68e2usnTPq7arJkTkocTOUSLE6A2
	zyCDyb8amtqQ/E5+tz74+W9fvKuNGpeCB/9VIUOztdUJYZUVS7tBilqeIXaLeJDK
	2kybCeqmZCsV270i11lOQ==
X-ME-Sender: <xms:F07lZBlSRDd1fepYn-zixMbkGTmo2WOKhH2XnIV_jFwIfP3TeJyuMg>
    <xme:F07lZM2G247lnxd1r59gmrHNw-Qd-ttXKOVKfccyvC17dDEziOBP9pzxQCIMjCBrG
    ie8XwI0T8zfd_izpg>
X-ME-Received: <xmr:F07lZHrr8BAlJ0jApeIuWa2NS6AAIGzn5NbVbkGvc6zIsh4Kr6WnPOcXs3XjO-oUGlqHDenfQjJhSByDchRBnwrQeDuR_Ai5xfLEFpnZeB4Rzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvvddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvedtkeejffekgfefhf
    evffeftefgueeuuedtteejudduheehieffvdeghffhvefhnecuffhomhgrihhnpehgihht
    hhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:F07lZBlLf8_AfjqXh_zZST9wtYOoNI-wOQD_lZ_-e7R9AIyn7uIxTQ>
    <xmx:F07lZP0z-9sFverzf8E8WjFo9bBp_9kkjGuMBrbpg1tyujQytn9NLw>
    <xmx:F07lZAsNzS5Mf1Oz8Yq8LZMJcxywaxBanvmCnWzFC5Sn6CgsZdYH8w>
    <xmx:F07lZIt4vMM8iCEVDkzFyYNlThMRwt4GLcgQ90MkRRy0_fgko-xK-g>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Aug 2023 20:08:54 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org
Cc: john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 2/2] bpf: Take a uref on BPF_MAP_TYPE_PROG_ARRAY maps during dev attachment
Date: Tue, 22 Aug 2023 18:08:31 -0600
Message-ID: <4ee4520b5b3f7c3532ca524032212e9fcb56eea3.1692748902.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692748902.git.dxu@dxuuu.xyz>
References: <cover.1692748902.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This commit changes the behavior of TC and XDP hooks during attachment
such that any BPF_MAP_TYPE_PROG_ARRAY that the prog uses has an extra
uref taken.

The goal behind this change is to try and prevent confusion for the
majority of use cases. The current behavior where when the last uref is
dropped the prog array map is emptied is quite confusing. Confusing
enough for there to be multiple references to it in ebpf-go [0][1].

Completely solving the problem is difficult. As stated in c9da161c6517
("bpf: fix clearing on persistent program array maps"), it is
difficult-to-impossible to walk the full dependency graph b/c it is too
dynamic.

However in practice, I've found that all progs in a tailcall chain
share the same prog array map. Knowing that, if we take a uref on any
used prog array map when the program is attached, we can simplify the
majority use case and make it more ergonomic.

I'll be the first to admit this is not a very clean solution. It does
not fully solve the problem. Nor does it make overall logic any simpler.
But I do think it makes a pretty big usability hole slightly smaller.

[0]: https://github.com/cilium/ebpf/blob/01ebd4c1e2b9f8b3dd4fd2382aa1092c3c9bfc9d/doc.go#L22-L24
[1]: https://github.com/cilium/ebpf/blob/d1a52333f2c0fed085f8d742a5a3c164795d8492/collection.go#L320-L321

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/syscall.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d8e5530598f3..6706bb1c8e16 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2164,8 +2164,37 @@ void bpf_prog_put(struct bpf_prog *prog)
 }
 EXPORT_SYMBOL_GPL(bpf_prog_put);
 
+/* Whether this program type, when attached, take a uref on prog array maps */
+static bool bpf_prog_should_pin_uref(enum bpf_prog_type type)
+{
+	switch (type) {
+	case BPF_PROG_TYPE_SCHED_CLS:
+	case BPF_PROG_TYPE_SCHED_ACT:
+	case BPF_PROG_TYPE_XDP:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void __bpf_prog_add_prog_array_urefs(struct bpf_prog *prog, s64 cnt)
+{
+	struct bpf_map *map;
+	u32 i;
+
+	mutex_lock(&prog->aux->used_maps_mutex);
+	for (i = 0; i < prog->aux->used_map_cnt; i++) {
+		map = prog->aux->used_maps[i];
+		if (IS_FD_PROG_ARRAY(map))
+			atomic64_add(cnt, &map->usercnt);
+	}
+	mutex_unlock(&prog->aux->used_maps_mutex);
+}
+
 void bpf_prog_put_dev(struct bpf_prog *prog)
 {
+	if (bpf_prog_should_pin_uref(prog->type))
+		__bpf_prog_add_prog_array_urefs(prog, -1);
 	bpf_prog_put(prog);
 }
 EXPORT_SYMBOL_GPL(bpf_prog_put_dev);
@@ -2366,7 +2395,16 @@ struct bpf_prog *bpf_prog_get(u32 ufd)
 struct bpf_prog *bpf_prog_get_type_dev(u32 ufd, enum bpf_prog_type type,
 				       bool attach_drv)
 {
-	return __bpf_prog_get(ufd, &type, attach_drv);
+	struct bpf_prog *prog;
+
+	prog = __bpf_prog_get(ufd, &type, attach_drv);
+	if (IS_ERR(prog))
+		goto out;
+
+	if (bpf_prog_should_pin_uref(type))
+		__bpf_prog_add_prog_array_urefs(prog, 1);
+out:
+	return prog;
 }
 EXPORT_SYMBOL_GPL(bpf_prog_get_type_dev);
 
-- 
2.41.0


