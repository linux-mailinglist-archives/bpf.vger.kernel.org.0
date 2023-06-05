Return-Path: <bpf+bounces-1791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFB4721CFC
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 06:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B51B2810FE
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 04:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887A33D92;
	Mon,  5 Jun 2023 04:10:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3962100
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 04:10:09 +0000 (UTC)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A89BE71
	for <bpf@vger.kernel.org>; Sun,  4 Jun 2023 21:09:43 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230605040940epoutp040e16100778b998b9523c5af4555b62a1~lp9e_j4Er0567505675epoutp04I
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 04:09:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230605040940epoutp040e16100778b998b9523c5af4555b62a1~lp9e_j4Er0567505675epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1685938180;
	bh=Fi1sOsiDHHx+gfQ29iwbhaaJETQZNbqv0f9OXt08XM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kws1VDt51X+OMNgT5OucHo30omXmqACU6T1z0ACVrKrccqazi5cJv6SSMSMsuU+pM
	 iXjLn9iMEZQsw462WBN8MncopDbbrkGzJAxwdh9DwHmw395cUCVGHH2gkozV1m6cLO
	 zL+F+Y3wgRSu28Yo98Ra2zAC/NWfx4YMq5HR8jJc=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20230605040940epcas5p39a4865eeffa0c1cc19dce413c55ede44~lp9ee7ZCY1277312773epcas5p3W;
	Mon,  5 Jun 2023 04:09:40 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4F.6B.04567.3006D746; Mon,  5 Jun 2023 13:09:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20230605040753epcas5p2640ca20e5fe0f628926d5cba16d8270a~lp77NakNH0082200822epcas5p26;
	Mon,  5 Jun 2023 04:07:53 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230605040753epsmtrp2a926e61806e40e3d526676a17dc217df~lp77MT7781080610806epsmtrp2h;
	Mon,  5 Jun 2023 04:07:53 +0000 (GMT)
X-AuditID: b6c32a49-943ff700000011d7-e5-647d60034268
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	EA.B8.28392.99F5D746; Mon,  5 Jun 2023 13:07:53 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230605040748epsmtip23403b68277135b425da66ba075a17876~lp72SWoPg3106431064epsmtip25;
	Mon,  5 Jun 2023 04:07:48 +0000 (GMT)
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
Subject: [PATCH v3 2/3] kallsyms: make kallsyms_show_value() as generic
 function
Date: Mon,  5 Jun 2023 09:37:30 +0530
Message-Id: <20230605040731.13828-2-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605040731.13828-1-maninder1.s@samsung.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGc+5XS7Oyy8fCsUQhLIASLeCmOS4g0y3jOt1E9xGmS0Ynd8ig
	pbYwtzlj+QgOHJQZIFJAStzkYyBQitRuymiLDUPGYFvW0hGJVmA4GFAmYCWO9krmf7/3fZ4n
	7/ueHD7u30KJ+OmybFYhk2SGUQLiqnlL5DY85XRqzI3ml5DNlEugJXc1jhZXHDzUos/FkMti
	pdB98wJAl+of4Ojs/HUcmaw9PFRj347yDI0YspRrcHTrnBRN3ijB0K/GGgqZ6woJ1FLURCJb
	2T2AVs/bSNRU1wBQ41dzJLKW/Iihx3f/JdG3jTMkGlm+TyBrwyqFVi29GHI+XKBQ6eBhNPXN
	BfDyJqZaNUwwX+fP8phrmjEeo9XlMAWWGZLpbIxiim0jOKNrLqKYelUFzszfGyWYUn0zYNr0
	vxOMS7cpSXhEEJfKZqZ/wiqid6cIjvddXiblnQGf/uFeJFXg0bPFwIcP6RdhrfYy5mF/+nsA
	p1Z2FQPBGi8AOH3OgnOFC8DSwbv4esLhXgFcwgjgqtqXMy0CWLbcR3gEihbDZuMPhEcIpA0E
	/KVjHPMUOF0IYPXFXq8rgD4MnQ8HKA8TdDic7DR7FxHScXBC734yLgRWjSzxPOxDx0P77XKC
	8/jB/iqnl/E1T35XtXdXSJt94M9n7RQXfhUOTtQCjgPgtFXP41gEXbPX1zz8NT4Ju8rOcNkC
	AHtqyp9kE6BzuJ70eHB6C2wzRnPtjbDipysYN9cXlridGNcXQsPFdQ6HBfZ2kuNg6JqfJzhm
	YNGVGR73XGUADnVpiTIQqnnqHs1T92j+H60FeDPYwMqV0jRWuUMeK2NPipUSqTJHliY+liXV
	Ae+HjtpnAGPjc2ITwPjABCAfDwsUGl8/leovTJV89jmryPpAkZPJKk0gmE+EBQkj4/uP+dNp
	kmw2g2XlrGJdxfg+IhWWL7dvHcqXDW3OmG4/o4WFmiDRnSXdrZ2jixEY/6a7fWryiNoYvdrq
	Op1t3k1X7r9m6oukh78I2DGQ22HafOjo0Vino/+97qsfuqiItvPPTZcPp8+nCyKeD2nKEHwU
	HP6+peaVF7BJtSwEq3hblVjZ8FvHqcIukaTHb2/gne+ifPOqVJ3qgwf+EbEbMdO22V31vNaE
	HCc0vBZEJ8hHNuBDMVLbx2N+cyfGt28d/asujk1Wi/f8Sa+8Gf9uXsClxzm3k13ds6EDN2Ow
	1rid+3sjU95yXYhXJOZVjo0kfzmR2P2GKjqpoiPrQMac45kHSe2hs8Hs3hMR78z8/UgeYtvj
	YGvDCOVxSWwUrlBK/gMKVgyEPwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsWy7bCSvO7M+NoUg9eX+S1uHGpksfj+ezaz
	xZeft9kt1mxpZLL4fOQ4m8Xrw58YLRYv/MZs0f5xL7PFoeP72S3m3DSyaNqxgsniyJRZzBZn
	unMtnu/rZbK4vGsOm8Xh+W0sFms6V7Ja3JjwlNHi76QbrBYr5y9ntFjR84HV4njvASaL/4+/
	slosXfGW1eLSj9csFseX/2Wz+HvkIJPFk1+f2Cz6zgZZvFgyg9FBzmN2w0UWj4nN79g9ds66
	y+6xYFOpR8uRt6wem1doeXTduMTssWlVJ5vHwoapzB4fn95i8ejbsorRY/2WqywenzfJBfBG
	cdmkpOZklqUW6dslcGUcXfaDtWCzcMX1319YGxj/8HcxcnJICJhI3P79kxHEFhLYwShx85kC
	RFxa4ue/9ywQtrDEyn/P2SFqPjFKfJmvCWKzCehJrNq1B6iGi0NE4A6LxL6XG9lBHGaBLkaJ
	h8/WgHUICwRITDveAbaBRUBV4vnmw0wgNq+AjcSzLb+ZITbIS8y89B2snlPAVuLm/SksENts
	JHZNOckGUS8ocXLmE7A4M1B989bZzBMYBWYhSc1CklrAyLSKUTK1oDg3PbfYsMAoL7Vcrzgx
	t7g0L10vOT93EyM4BWhp7WDcs+qD3iFGJg7GQ4wSHMxKIry7vKpThHhTEiurUovy44tKc1KL
	DzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamAKMpybsce4yfprW3k31zXd72v+50v9
	7cs7sv/wmoW/109i0j7Ju7jBiS8/5eq3B+b+D78XrK85WHY66tRtm5XfNCPKeXhsv6lXT0t8
	+k71U2pshnlO4LorJsf9j9YFJUZ1Him7HMZf8MF31iPrGd8Fs+Q+1xt+/5BR/Xnay8qlZ5cs
	TzDgEr1pmPzj/KQ5c+4f3fK65oHsTc2qye57DYznPNKTt7rC+p53ib3y3NINDCHaF2tr+fiL
	rNzmB92PWnilnVXWerKOTkzP4ztd2/+u0OfjWhdQw7b58uVn3EfO7xZ6vfr9bo62eBXbWd8K
	7q7cKKfX/rpwhUx0zmpPn/slaUtcztv3XbhsfNE59cQCJZbijERDLeai4kQAWyqNp3ADAAA=
X-CMS-MailID: 20230605040753epcas5p2640ca20e5fe0f628926d5cba16d8270a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20230605040753epcas5p2640ca20e5fe0f628926d5cba16d8270a
References: <20230605040731.13828-1-maninder1.s@samsung.com>
	<CGME20230605040753epcas5p2640ca20e5fe0f628926d5cba16d8270a@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
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
 kernel/knosyms.c         |  2 --
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
diff --git a/kernel/knosyms.c b/kernel/knosyms.c
index 9e2c72a89ea5..830905b0986a 100644
--- a/kernel/knosyms.c
+++ b/kernel/knosyms.c
@@ -9,7 +9,6 @@
 #include <linux/kallsyms.h>
 #include <linux/security.h>
 
-#ifdef CONFIG_KALLSYMS
 static inline int kallsyms_for_perf(void)
 {
 #ifdef CONFIG_PERF_EVENTS
@@ -45,4 +44,3 @@ bool kallsyms_show_value(const struct cred *cred)
 		return false;
 	}
 }
-#endif
-- 
2.17.1


