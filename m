Return-Path: <bpf+bounces-1792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADF3721CFD
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 06:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB357281130
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 04:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E912100;
	Mon,  5 Jun 2023 04:10:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D823FE4
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 04:10:15 +0000 (UTC)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C414019A9
	for <bpf@vger.kernel.org>; Sun,  4 Jun 2023 21:09:49 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230605040943epoutp016a47f077acbe6e464d90cf2b7d3b0fc1~lp9h1lzkd1976619766epoutp01f
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 04:09:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230605040943epoutp016a47f077acbe6e464d90cf2b7d3b0fc1~lp9h1lzkd1976619766epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1685938183;
	bh=D6BYeEFjcwK/JjVlG0GME0GZtwXFEU/rtRQJcirZLm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f8cK3quR+2To1odFVlYZOP7kuZLWsJkXHD3qYsiEdm9mxS6boI5lk9AI0ua2kgzTh
	 onm1WXhNidoMI673PuluvASOoAifDBNrIcE9yJRZ0kDOHmi6qmIgjU/lLbD8e2wKrO
	 XlJ0YL8SmCTc+Nrfb+kYHT+LPetkAWaeZJkMkNgs=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20230605040942epcas5p152487d3a986533c90ab5bdeebb2e0798~lp9hFZWmR3075730757epcas5p1S;
	Mon,  5 Jun 2023 04:09:42 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	04.7B.04567.6006D746; Mon,  5 Jun 2023 13:09:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20230605040801epcas5p2ca850464882841a0a5748e217542a10a~lp8CcrBOy0082200822epcas5p2Q;
	Mon,  5 Jun 2023 04:08:01 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230605040801epsmtrp2a79647a26428599321e6aa4393a74d5a~lp8CbUkZ41080610806epsmtrp2y;
	Mon,  5 Jun 2023 04:08:01 +0000 (GMT)
X-AuditID: b6c32a49-db3fe700000011d7-ec-647d60066fb5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	D0.C8.28392.1AF5D746; Mon,  5 Jun 2023 13:08:01 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230605040756epsmtip287381b7bf2d8b7632331a41ebaa9cd96~lp79mtpvu0198301983epsmtip2M;
	Mon,  5 Jun 2023 04:07:55 +0000 (GMT)
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
Subject: [PATCH v3 3/3] bpf: make bpf_dump_raw_ok() based on CONFIG_KALLSYMS
Date: Mon,  5 Jun 2023 09:37:31 +0530
Message-Id: <20230605040731.13828-3-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605040731.13828-1-maninder1.s@samsung.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGd+69vf0w3S6FzCM4ZgjEFCeOMecxobolc7swdLLFzY8ts5G7
	2lgqa8HCjBtYAuOjyBhMKAyE4iiIiAy0lrnSj9DgdA7IHJRUCFTZRkChIFNER3sh87/f+77P
	c57znhweLjpHBvPkylRGpZQqwkgBcckuFm8kD55IejW3ZyMasGURaH6hEkezD4e4qLk9C0Ne
	h5NEE/YZgAy1D3CUO30VRzanhYuqBl9DJ01GDDlK9Ti6XpCMxn/RYajfXEUie00OgZrzGjlo
	oPgOQIslAxzUWNMAkLHwPgc5dV0Yejo2x0FnjZMc1PfvBIGcDYskWnRYMeR5NEOiohsfoL/q
	y8GboXRlZi9Bf6ud4tJX9G4ufaYtjc52THLon4yRdP5AH063NeWRdG1mGU5P33ERdFF7E6Av
	tP9B0N620N3C/YLYJEYhP8aoNm07KDhcVbhAphiF6a66I5mgZFU+4PMg9TocairH8oGAJ6I6
	AbSd7ibYYgbAiqxry4UXwHyrnVyx/Ogu4vhYRJkB7HuiZEWzANZ9/4DwDUgqCjaZf/a7gygT
	AX+/OOIPwakcACurrX5VIJUAe/stfiaoCLjgGAU+FlKx0N19g8PGvQwr+ua5PuZTEjg4XEqw
	mgDYU+HxM76k0XZU4r4ASFn40NV6acnMWyrehqe+kbHnBMJ/nO1cloOhd+oqyUo0sKP4a9aa
	DaClqnR5ze3Q01vrPwanxPCCeRPbfgmWXWvB2NjnoW7Bg7F9ITRVr3AEzB5sXb5+CPROTxMs
	0zB/VMtlX6sYwO/KrmDFYJ3+mXX0z6yj/z/6DMCbwBomRZ0sY9SbU6KVjCZKLU1WpyllUYeO
	JrcB/3+OjDMB98j9KBvAeMAGIA8PCxKa448niYRJ0owvGdXRz1RpCkZtAyE8Imy1cL2k55CI
	kklTmSMMk8KoVqYYjx+ciYXHrqkWBBkCFkNr0ks+/uKhZG4rp6D6rfhftxQWlwfd2jrcOWY3
	HLiNn3w6vvbD4SFJOP+VvM07NG3HNrz3XHjeVyiGTNgxmyWuqHtsHToRtiVmoVcTkN0YvxY1
	Wj85PRlpeUH8J9N1YMPY7ZEa53bzi6vvvXMrnDkLbx6PSd0HH3m6FbRScX7nKl4DH9U6Elvu
	hRfNtxou39yWGxd9d2JPkMnl7NJIQuz75txyUXDuqLzz/Y8Muy4mOp+MJ6yr1/7W3+HqP7e3
	6IfW8usjuvLEz7V3m5vF+3M+3R3Xkvr37ONBeYYxsRlmFIglKvu7e9LeIAJJ7Pzeeu16XfqU
	THfZHRFGqA9LoyNxlVr6HzxkQNY+BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA03Se0hTURzA8c597bpaXKfYLcFoPchhS+3B+cOkB8UtIrSUKDJb7qKRm2vX
	R28se+DyNTPUaensNYe9zMccy2wul5CUs4dZGmVqYcvU0pxp6UbQfz/O93PO+edHosIubB55
	QJHIqhTSeBHBx2oaRfOX6aJPyAIrRnDYbjmFwdHxIhT+GHvLgxVVpxA4bLURsL9xCMCruhEU
	nh98gEKL7SEPFr8JhqeNegRa87QofHpBDvvqMxHYZiomYGPJOQxWpJdPPZnTA+BEbjsOy0tu
	AqjP+I5DW2YDAv90/8Thdb0Dh/Zf/Ri03Zwg4IT1EQI/OYcImNWyHX6+VgDW+jFFqa0Yo0n7
	xmPqtJ08prQyiTljdeDMfb2YUbfbUabSkE4wutRLKDPY04ExWVUGwNypeokxw5V+YYLd/BAZ
	G38gmVUtD93HjyvOGCeUesHhjrKDqSB3php4kDS1kr7RmYWrAZ8UUkZA9zruIO7gS49NDmDu
	2Ysun+zjudEQoL++aHMFgpLQBpMZmw7e1DuMrv9yz6VQSg3oD70VvGnlRW2lW9seum5g1GJ6
	3PoRTM8CKoTubGrB3V/Mpwvtoy7vQa2h37zPc3nhlDHlNRNu70k3F35ynaNTPq26CM0BlPa/
	pP0vlQLEAOaySk4eK+eClMEKNkXCSeVckiJWEpMgrwSuFRCLjcBs+C6xAIQEFkCTqMhbYNpy
	TCYUyKRHjrKqhGhVUjzLWYAviYnmCJ6rm6OFVKw0kT3IskpW9a8ipMe8VOTy/tsNw5co/+Sl
	G8aEF6MCNatOHtZnh5bZtywM8457NbRp5J5XV7YZd8qQuif5r5y5xg21ibP6UgaQhNvFiyTr
	oq+B1z98Zl60Tn59v3D28WfhP3dGmXeYIldh5/K7e31s8PEt4V1H/Vpz3VzeoT3qHF+lpjWt
	zdknc9aWJqUEKbTBRsdRS9S2PzkpUTUwPZK/hFsxERGbL13f5Sfubi5viBiMXNBg2v5b9zZo
	xuMmylxw4vfzzC9pBccyd9WcnRUQsGBdGHclvDqjh6TObr3suSbUf2VZwIr4esVTO6kJLwnm
	7Srz2dvkqYoI7PAvTTizOmSjztafPOC1uU4Tmh3TIsK4OGmQGFVx0r/GbRYScQMAAA==
X-CMS-MailID: 20230605040801epcas5p2ca850464882841a0a5748e217542a10a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20230605040801epcas5p2ca850464882841a0a5748e217542a10a
References: <20230605040731.13828-1-maninder1.s@samsung.com>
	<CGME20230605040801epcas5p2ca850464882841a0a5748e217542a10a@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

bpf_dump_raw_ok() depends on kallsyms_show_value() and we already
have a false definition for the !CONFIG_KALLSYMS case. But we have
expanded kallsyms_show_value() to work for !CONFIG_KALLSYMS case also
in previous patch.

And so to make the code easier to follow just provide a direct
!CONFIG_KALLSYMS definition for bpf_dump_raw_ok() as well.

As it is heavily dependent on KALLSYMS and checking based on
kallsyms_show_value() will not work now.

Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/filter.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index bbce89937fde..1f237a3bb11a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -923,13 +923,21 @@ bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_helper_changes_pkt_data(void *func);
 
+/*
+ * Reconstruction of call-sites is dependent on kallsyms,
+ * thus make dump the same restriction.
+ */
+#ifdef CONFIG_KALLSYMS
 static inline bool bpf_dump_raw_ok(const struct cred *cred)
 {
-	/* Reconstruction of call-sites is dependent on kallsyms,
-	 * thus make dump the same restriction.
-	 */
 	return kallsyms_show_value(cred);
 }
+#else
+static inline bool bpf_dump_raw_ok(const struct cred *cred)
+{
+	return false;
+}
+#endif
 
 struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 				       const struct bpf_insn *patch, u32 len);
-- 
2.17.1


