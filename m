Return-Path: <bpf+bounces-4922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F7B7517E4
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 07:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D299281B67
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 05:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B63553AB;
	Thu, 13 Jul 2023 05:09:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFEA443F
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 05:09:12 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7F52114;
	Wed, 12 Jul 2023 22:09:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R1jM62XMWz4f3m7l;
	Thu, 13 Jul 2023 13:09:06 +0800 (CST)
Received: from ubuntu20.huawei.com (unknown [10.67.174.33])
	by APP2 (Coremail) with SMTP id Syh0CgCHlufvhq9ktQcZNw--.45992S2;
	Thu, 13 Jul 2023 13:09:06 +0800 (CST)
From: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
To: Yonghong Song <yhs@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Weiyang <wangweiyang2@huawei.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	gongruiqi1@huawei.com
Subject: [PATCH] bpf: Add support of skipping the current object for bpf_iter progs
Date: Thu, 13 Jul 2023 13:13:23 +0800
Message-Id: <20230713051323.2867905-1-gongruiqi@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCHlufvhq9ktQcZNw--.45992S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WryfCF45ZrWrXF4xAF4ktFb_yoW8Ar17pF
	s7KF9rCw40vw47uFZFyFs7CryrAwnaq3W7GFWqk3yrKr1UXws8Wrn8GF1aqFyrtryxKr1F
	vF4I9FWYv345uFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

bpf_seq_read() can accept three different types of seq_ops->show()'s
return value:

  err > 0: skip the obj and reuse seq_num
  err < 0: abort the whole iter process
  err == 0 (implicitly): continue

but bpf_iter_run_prog() is limited to the last two cases. Extend the
legal return value of bpf_iter progs so that they can skip certain
objects and then proceed to the followings.

Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
---
 kernel/bpf/bpf_iter.c | 9 +++++----
 kernel/bpf/verifier.c | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 96856f130cbf..1c1d67ec466c 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -716,13 +716,14 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
 		rcu_read_unlock();
 	}
 
-	/* bpf program can only return 0 or 1:
-	 *  0 : okay
-	 *  1 : retry the same object
+	/* bpf program can return:
+	 *  0 : has shown the object, go next
+	 *  1 : has skipped the object, go next
+	 * -1 : encountered error and should terminate
 	 * The bpf_iter_run_prog() return value
 	 * will be seq_ops->show() return value.
 	 */
-	return ret == 0 ? 0 : -EAGAIN;
+	return ret == 0 ? 0 : (ret == 1 ? 1 : -EAGAIN);
 }
 
 BPF_CALL_4(bpf_for_each_map_elem, struct bpf_map *, map, void *, callback_fn,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 930b5555cfd3..cebd3a0b3172 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14333,6 +14333,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 		case BPF_MODIFY_RETURN:
 			return 0;
 		case BPF_TRACE_ITER:
+			range = tnum_range(-1, 1);
 			break;
 		default:
 			return -ENOTSUPP;
-- 
2.25.1


