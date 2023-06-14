Return-Path: <bpf+bounces-2580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7490E72F7D9
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 10:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1FD2812C0
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 08:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAC9525F;
	Wed, 14 Jun 2023 08:29:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C633D7F
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 08:29:50 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEFEA1
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 01:29:49 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTP id 4QgzB12MKtzBQJZ4
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 16:29:45 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
	content-transfer-encoding:content-type:message-id:user-agent
	:references:in-reply-to:subject:to:from:date:mime-version; s=
	dkim; t=1686731385; x=1689323386; bh=+1CZbpCrooYnxpWHG3ifhgX0usn
	zkdJe1tOdGeUaLK0=; b=vntr5gEJOOfA/q8gGNcFA19BCt7GwwuLXojwjbWSlQC
	ZqUGtuVGkxPBdDkzPO4f0CCRz/X7PoBZQoHP/N5lNL6Fe6dXYnuZQWcBVNyFRpmV
	DkfdXt1oCFHf0bMtg5SgHgbq3efbj9sI+lUH7E07IW+XhAbEGYeL4HM6nxAIFJTF
	Mub50Q3KaKFI9DOiyJZ3sKHbMzrVQhRcsQhkUZ513w8icU0xtG6/dJiU2sRS2/a1
	oFe/rrOnOw8TevYsUbe0tsD1B/OGxtn8dkd84Xz2FGvaw4Aeg3ssRuoZQkYcS8yj
	B6PGHlpfkO+WDeWthDU2f/Hpcivy1WjchtrAfNFOZmg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
	by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5hEMlif4WegT for <bpf@vger.kernel.org>;
	Wed, 14 Jun 2023 16:29:45 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTPSA id 4QgzB04kc1zBJJCt;
	Wed, 14 Jun 2023 16:29:44 +0800 (CST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 14 Jun 2023 16:29:44 +0800
From: baomingtong001@208suo.com
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] libbpf: zip: Remove unneeded semicolon from
 zip_archive_open()
In-Reply-To: <20230614082626.45467-1-luojianhong@cdjrlc.com>
References: <20230614082626.45467-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <f629797b0b525095352acbf565b48481@208suo.com>
X-Sender: baomingtong001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

./tools/lib/bpf/zip.c:226:2-3: Unneeded semicolon

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  tools/lib/bpf/zip.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/zip.c b/tools/lib/bpf/zip.c
index 3f26d629b2b4..88c376a8348d 100644
--- a/tools/lib/bpf/zip.c
+++ b/tools/lib/bpf/zip.c
@@ -223,7 +223,7 @@ struct zip_archive *zip_archive_open(const char 
*path)
      if (!archive) {
          munmap(data, size);
          return ERR_PTR(-ENOMEM);
-    };
+    }

      archive->data = data;
      archive->size = size;

