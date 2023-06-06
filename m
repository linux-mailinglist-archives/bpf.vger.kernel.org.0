Return-Path: <bpf+bounces-1916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D23723643
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 06:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9A02814C3
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 04:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC2B211C;
	Tue,  6 Jun 2023 04:28:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFAE211A
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 04:28:58 +0000 (UTC)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94B811D
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 21:28:56 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230606042854epoutp04d4340a9e263efd7d36f6edfa03892236~l93jdb7FK0544305443epoutp04u
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 04:28:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230606042854epoutp04d4340a9e263efd7d36f6edfa03892236~l93jdb7FK0544305443epoutp04u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1686025734;
	bh=B13/GxW/aC+E0iS9akiMYysKoCOqpsq+pQ7ZEhjZXc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sBVG1IHZYx+UrHF+3gTruX9S0CbZHi68Gy6Zy6URVpBOg5fxg6CdNql0HsQJ1vb+j
	 fgxpv4Qhm6rohCctRXMPXRm8htWZtit+uT2km3Mcud5Zzdl+ogQQG8LLAD3k7Djy3B
	 l8e52ezt6Jzy3BD78+btuxSqT+AU70qJNN9F6VDQ=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20230606042853epcas5p1f01ceaf04307f1007ef8dd39a3190ee2~l93ixpDF71253112531epcas5p1C;
	Tue,  6 Jun 2023 04:28:53 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C0.20.16380.506BE746; Tue,  6 Jun 2023 13:28:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20230606042825epcas5p13579e5999f3cc7d9d517e4c3040cf16a~l93I0AwP13091830918epcas5p1L;
	Tue,  6 Jun 2023 04:28:25 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230606042825epsmtrp2cb817c1a199f5c88475a67440fe32948~l93IyvrUk2695426954epsmtrp2D;
	Tue,  6 Jun 2023 04:28:25 +0000 (GMT)
X-AuditID: b6c32a4b-7dffd70000013ffc-92-647eb6056101
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	2A.13.28392.9E5BE746; Tue,  6 Jun 2023 13:28:25 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230606042820epsmtip16722489e7417b5f23335c78b840607b7~l93D9PBdA1823818238epsmtip1m;
	Tue,  6 Jun 2023 04:28:20 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	thunder.leizhen@huawei.com, mcgrof@kernel.org, boqun.feng@gmail.com,
	vincenzopalazzodev@gmail.com, ojeda@kernel.org, jgross@suse.com,
	brauner@kernel.org, michael.christie@oracle.com, samitolvanen@google.com,
	glider@google.com, peterz@infradead.org, keescook@chromium.org,
	stephen.s.brennan@oracle.com, alan.maguire@oracle.com, pmladek@suse.com
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Maninder Singh
	<maninder1.s@samsung.com>, Onkarnath <onkarnath.1@samsung.com>
Subject: [PATCH v4 3/3] kallsyms: make kallsyms_show_value() as generic
 function
Date: Tue,  6 Jun 2023 09:58:02 +0530
Message-Id: <20230606042802.508954-3-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230606042802.508954-1-maninder1.s@samsung.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0yTZxTG8363li4ln9CFF8iYqXIpatl0y95dVGKc+5wxIWaZbppplS/A
	BCQtoNuSQbXBFMalDqZtuW44SmUDukJouUlb08BwCAsTBDemEBwFpQVUwM5RPsj87znn/J7z
	5Lx5+XjANSqEn5SazspTZcliSkA02yWR28jmr+Nfs034oSGbkkBPlvU4ml8c4aE6sxJDcw4n
	hVx2D0A/VD3G0UV3O45szk4eKh3ejs63GDDkKNbhqDcvBU125GPod2sphewVOQSqU9eSaKho
	AiDvpSES1VbUAGT4ZpZEzvzrGHp+f4FEVw0zJBp46iKQs8ZLIa+jC0PjSx4KFdw8hB5UXwGx
	YYw+u59gNBce8hiL7i6PqTRlMCrHDMn8YohmcocGcMZkVFNMVXYJzrgn7hBMgdkImHrzIMHM
	mcLihJ8K3otnk5MyWXnMrhOCxKmF37A0Z+C5y6YCIhuU0LnAjw/pN2DOUhvu0wF0K4Day6Jc
	IFjRHgAH8j08bjAHoGv5/XXD9E8awEFWAL/tWya5Yh7Au1V5qw6KlkKjtY3wDUR0CwFvNY5h
	vgKncwDUl3cRPiqQPgT/Hn4AfJqgw6GlumPVLaR3wll1LsHlvQq1A09W+ny+H70LGvKjOGQD
	7NaOryL4CnKhSY/79kPa7gfLR7NxzrsXupXPKE4HwimnmcfpEDj3sJ3y7YT0WdhUlMV5VQB2
	lhav8bvheH8V6WNwWgLrrTFc+xVY0vMzxuX6w/zlcYzrC2FL+boOh6rhBpLToXDO7V47hYG6
	+etrr6UBsOnHIlAENupeuEf3wj26/6MrAW4EwWyaIiWBVbyZtiOVPStVyFIUGakJ0lNnUkxg
	9T9HH2gB98ZmpTaA8YENQD4uFgmtH34VHyCMl33xJSs/c1yekcwqbCCUT4iDhJE7u08F0Amy
	dPY0y6ax8vUpxvcLycbe8gRvkt5hLWUq6ldjYvWNg9WfNN7uP6rEdvfc7+79o3U68wjelGd5
	1OYV2xo/jh+pqR3NjPKKnt3+blLe9U9XYcjWW1Nw/6OP6sI3P700uSfp+yjDy6GbNg++u9eR
	1dN/Mmmfbv/kzaXUz0p7Zxh/8+noTlXytueT7nANGpxquOEOS4jUVPqXLVCaiL7PFdciytR7
	AhySmA9ipWOLzSMbHXUdOyQR9/6qV/+p2n6gMFbuPl5YSOUGaUXN7/RVGDdMOwyC0auWhmNb
	XP8Kj44JFytOplcefik9aN+W1sOSduUA6SLOF2899lhvD4tTXbkY7HIePOdu1cZFv33CmrVI
	H+GLCUWi7PVoXK6Q/Qcj/4bdPgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsWy7bCSnO7LrXUpBlsn81ncONTIYvH992xm
	iy8/b7NbrNnSyGTx+chxNovXhz8xWixe+I3Zov3jXmaLQ8f3s1vMuWlk0bRjBZPFkSmzmC3O
	dOdaPN/Xy2RxedccNovD89tYLNZ0rmS1uDHhKaPF30k3WC1Wzl/OaLGi5wOrxfHeA0wW/x9/
	ZbVYuuItq8WlH69ZLI4v/8tm8ffIQSaLJ78+sVn0nQ2yeLFkBqODnMfshossHhOb37F77Jx1
	l91jwaZSj5Yjb1k9Nq/Q8ui6cYnZY9OqTjaPhQ1TmT0+Pr3F4tG3ZRWjx/otV1k8Pm+SC+CN
	4rJJSc3JLEst0rdL4Mp49fUcU8Fx4Yrpm/pYGhinCnQxcnJICJhIvFk7kbGLkYtDSGAHo8S6
	Q9uYIBLSEj//vWeBsIUlVv57zg5R9IlR4vC7TWwgCTYBPYlVu/awgCREBO6wSOx7uRGsihlo
	uMTDZ2vYQaqEBQIk+rZ9YwaxWQRUJXYu2QcW5xWwlfjQ2QW1Ql5i5qXvQHEODk4BO4kVvRog
	phBQybfJTBDVghInZz4Bq2YGqm7eOpt5AqPALCSpWUhSCxiZVjFKphYU56bnFhsWGOWllusV
	J+YWl+al6yXn525iBKcALa0djHtWfdA7xMjEwXiIUYKDWUmEd5dXdYoQb0piZVVqUX58UWlO
	avEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTCUNf/R1jpwsqStWWyRqUMO4IXU/
	//y3d98U5bvLOXMJ9U9KEbqwP9hCM3GR5o2XN213Kxp9Cpw0MfHkhSfqDaGXW63TK04JfZl5
	ga0sZ1vplJuMCnsUj7FVy8x2KKjRmBV0rj9pMv8ezqsFwfWdHGlNZvcWZP6rTag2KFL81bxD
	cpaT2w3ukCXRZ7ar59ma7HW/3/9HTm7xrwlTrsku5+7lW/VG/P2UfTXTdzZ/CVIt7Dl0Jvxp
	uvpTydqZD6fo/KrZ1Z3nZjU1hvts6eeJTDJHy8ROfl2oekF6z6qrN8W3rNayPzZN1VH7mqv/
	CjmjZX2coqrCSRMX567neWbkHdiTcsF25cf38edvOrhLK7EUZyQaajEXFScCAHYi7llwAwAA
X-CMS-MailID: 20230606042825epcas5p13579e5999f3cc7d9d517e4c3040cf16a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20230606042825epcas5p13579e5999f3cc7d9d517e4c3040cf16a
References: <20230606042802.508954-1-maninder1.s@samsung.com>
	<CGME20230606042825epcas5p13579e5999f3cc7d9d517e4c3040cf16a@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This change makes function kallsyms_show_value() as
generic function without dependency on CONFIG_KALLSYMS.

Now module address will be displayed with lsmod and /proc/modules.

Earlier:
=======
/ # insmod  test.ko
/ # lsmod
test 12288 0 - Live 0x0000000000000000 (O)  // No Module Load address
/ #

With change:
==========
/ # insmod test.ko
/ # lsmod
test 12288 0 - Live 0xffff800000fc0000 (O)  // Module address
/ # cat /proc/modules
test 12288 0 - Live 0xffff800000fc0000 (O)

Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 include/linux/kallsyms.h | 11 +++--------
 kernel/ksyms_common.c    |  2 --
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 1037f4957caa..c3f075e8f60c 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -65,6 +65,9 @@ static inline void *dereference_symbol_descriptor(void *ptr)
 	return ptr;
 }
 
+/* How and when do we show kallsyms values? */
+extern bool kallsyms_show_value(const struct cred *cred);
+
 #ifdef CONFIG_KALLSYMS
 unsigned long kallsyms_sym_address(int idx);
 int kallsyms_on_each_symbol(int (*fn)(void *, const char *, unsigned long),
@@ -94,9 +97,6 @@ extern int sprint_backtrace_build_id(char *buffer, unsigned long address);
 
 int lookup_symbol_name(unsigned long addr, char *symname);
 
-/* How and when do we show kallsyms values? */
-extern bool kallsyms_show_value(const struct cred *cred);
-
 #else /* !CONFIG_KALLSYMS */
 
 static inline unsigned long kallsyms_lookup_name(const char *name)
@@ -154,11 +154,6 @@ static inline int lookup_symbol_name(unsigned long addr, char *symname)
 	return -ERANGE;
 }
 
-static inline bool kallsyms_show_value(const struct cred *cred)
-{
-	return false;
-}
-
 static inline int kallsyms_on_each_symbol(int (*fn)(void *, const char *, unsigned long),
 					  void *data)
 {
diff --git a/kernel/ksyms_common.c b/kernel/ksyms_common.c
index e776f12f0f5a..9603bbef095c 100644
--- a/kernel/ksyms_common.c
+++ b/kernel/ksyms_common.c
@@ -6,7 +6,6 @@
 #include <linux/kallsyms.h>
 #include <linux/security.h>
 
-#ifdef CONFIG_KALLSYMS
 static inline int kallsyms_for_perf(void)
 {
 #ifdef CONFIG_PERF_EVENTS
@@ -42,4 +41,3 @@ bool kallsyms_show_value(const struct cred *cred)
 		return false;
 	}
 }
-#endif
-- 
2.17.1


