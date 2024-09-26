Return-Path: <bpf+bounces-40329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 283FD986B05
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 04:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0ED11F21D42
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 02:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA60175D2C;
	Thu, 26 Sep 2024 02:39:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BB41D5AAD;
	Thu, 26 Sep 2024 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727318395; cv=none; b=gLrI4MBdc0qT9P5kWdqSt5zRL7/MwlJ9/ElprzofwdB3VRuMBY+wPaAX5f6U7csq7wF+8pk2ORZMjGbCdFh+rtUpuXkRBZbHO3LX8V5dkQ8sYgBwx7p8W2/iMi4exibTCSQMDgzanFMSz3EXSmihyC1kCQEKN1SNrokZ1RfYkuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727318395; c=relaxed/simple;
	bh=UcRyjEvuYZA1EQbXIPMIZLGxbD1x8oDGMLqpKk4T8KM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fbUH4vJsgirD1Tr1dkBTtcAmNBJYgbPrOAR8Fmf8P3uL2CbdUe8BzVL6Vrln3okEj5SNr0GKeKkN88yJYL+gwzjW7uJka0xrEaABgb7eN4khhFNO1j5AZDubBh78negQQG8J78aKq+wLVaSyFzxj9sWq5EnKATNkl5RxH5Js3SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowACnu0BdyfRmJEshAQ--.9304S2;
	Thu, 26 Sep 2024 10:39:25 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH bpf-next] libbpf: Remove unneeded semicolon
Date: Thu, 26 Sep 2024 10:38:23 +0800
Message-Id: <20240926023823.3632993-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACnu0BdyfRmJEshAQ--.9304S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYu7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMx
	Aqzxv26xkF7I0En4kS14v26r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1sY
	FtUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unneeded semicolon in zip_archive_open().

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 tools/lib/bpf/zip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/zip.c b/tools/lib/bpf/zip.c
index 3f26d629b2b4..88c376a8348d 100644
--- a/tools/lib/bpf/zip.c
+++ b/tools/lib/bpf/zip.c
@@ -223,7 +223,7 @@ struct zip_archive *zip_archive_open(const char *path)
 	if (!archive) {
 		munmap(data, size);
 		return ERR_PTR(-ENOMEM);
-	};
+	}
 
 	archive->data = data;
 	archive->size = size;
-- 
2.25.1


