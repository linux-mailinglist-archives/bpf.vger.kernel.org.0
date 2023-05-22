Return-Path: <bpf+bounces-1005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06C570B3CD
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 05:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4441C20970
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 03:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D22EB8;
	Mon, 22 May 2023 03:32:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4E8A5C
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 03:32:45 +0000 (UTC)
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292B790;
	Sun, 21 May 2023 20:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1684726358;
	bh=FvsG6zOPtvIvHZ5Zye5fMsBrNoweYDB083Dy7y0Xqrs=;
	h=From:To:Cc:Subject:Date;
	b=qcMBZeAZieLL5Yj7kdY/CdWBFtlxdm9nTVsX2pJ8YPXxG9qFS9RUW91pAJrm603Ko
	 /s633NQ6yLUUPepmiKaoNhbq6KLf+mTN4HCYyRdRTlq8avwqM98/PKR38r25zs1H3J
	 sd/qGUjTaGxr4L6TaCWqwOwUKgkEkWrg93Odbfik=
Received: from localhost.localdomain ([39.156.73.12])
	by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
	id 5060064F; Mon, 22 May 2023 11:20:06 +0800
X-QQ-mid: xmsmtpt1684725606thdrdrro9
Message-ID: <tencent_C11060D6C765B08AC1ABE2A801228381B206@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYS7ayxzI94vsOM+ZPCRxB8U/TquQOXf2ycGLo9n9lDXzYX/TzUgz
	 02EERgYO4w/XLqL983HMHc6kfuSc0emfhjg+0kiz/iW6g2wXs404i1hvk34r5yDIb9oW+wFhAq9J
	 npR2gTjuiJYDfj/CtKoCDs3dYWKY7y1hWpc8FkkRU+V8dHNs3jjZ45wkOvDZAm4bJpwEwiUS6ch4
	 rTRl+f8aawVlrtc/5LrIRCbjji0Jz4JkRQk1NNnoQpoZ+hPwVerrBKVvndaV+TMVeRQj6mdZgJRY
	 D8waZ7+gB42cIYPxjIbyFGh1qpgh1JJUOjO7kwB7TrwIMk0/B1mUG8BjIh1qjAt6I/9BMw5HsR2d
	 kcb2zLqnl0xLDbHTuKBzHZmx+0yx8puc3yq7+wDIlFnm3LKhFOLZnah9ikIY2ABtxQl/ahiyhYs+
	 3E7sKYUGKxJHwAS2dwP+6WeNm1pJjg4bFg38mzGlShEIV+P3MoLt2KKMiUuNL+5ErnMdcqWPjHGm
	 bVGSFELLgf12x9JhL/pe/Dcyb/hig0yGxvWiO/Tk6yivvkPH+rVAeoWjxgoxchMoVJza1/i7DPYh
	 R8TotPX0NqSldQWiQzxI3zwJAuMAGKwWgwiTncC8qWZfYE6YW5vnJZsIh4vP4BgPe0TeLn65nFRO
	 pdr+jLxfGr+YVbroibRlylcN/80GTtS5NT/DSFRPz94JKRxh6OhKzytaqX9J8urtS1j+INNIHJC/
	 0W1qwaBCGGZYl+ExupGgntmXZJQw2fdaAFpJju3awBRCARhIrlWyKLq+LNqqHtAzLvWgwxrCRqmK
	 Y6sCmgL0rd+oFH2/Rg2KcCCCZpdw8ZZbIA70OyLx9+E6V4uuHapMWJA++l88fA6DuubTZdFY29Os
	 Ipu6KfsJ4ltM9ItHMSYVA7hdJcv8xfStHCPq/BmU+MyCBiT49cxQRRB1VwLLtWXSc49n9TAgu7ZC
	 AtUqy9J16bnQxW8s+dxw==
From: Rong Tao <rtoax@foxmail.com>
To: ast@kernel.org
Cc: Rong Tao <rongtao@cestc.cn>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next] samples/bpf: hbm: Fix compile error about fallthrough marking
Date: Mon, 22 May 2023 11:20:03 +0800
X-OQ-MSGID: <20230522032003.79769-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Rong Tao <rongtao@cestc.cn>

commit f7a858bffcdd("tools: Rename __fallthrough to fallthrough") rename
macro __fallthrough to fallthrough, commit 4b7ef71ac977("bpftool: Replace
"__fallthrough" by a comment to address merge conflict") use comments to
replace __fallthrough, here we can use fallthrough directly.

Compiling samples/bpf hits an error related to fallthrough marking:
    ...
    CC  samples/bpf/hbm.o
    linux/samples/bpf/hbm.c: In function ‘main’:
    linux/samples/bpf/hbm.c:501:25: error: ‘__fallthrough’ undeclared
    (first use in this function); did you mean ‘fallthrough’?
    501 |                         __fallthrough;
        |                         ^~~~~~~~~~~~~
        |                         fallthrough

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 samples/bpf/hbm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/hbm.c b/samples/bpf/hbm.c
index 6448b7826107..7ddf25e9d098 100644
--- a/samples/bpf/hbm.c
+++ b/samples/bpf/hbm.c
@@ -498,7 +498,7 @@ int main(int argc, char **argv)
 					"Option -%c requires an argument.\n\n",
 					optopt);
 		case 'h':
-			__fallthrough;
+			fallthrough;
 		default:
 			Usage();
 			return 0;
-- 
2.39.1


