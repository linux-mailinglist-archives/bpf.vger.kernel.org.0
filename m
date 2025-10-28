Return-Path: <bpf+bounces-72499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 775E3C132F4
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 07:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B269D4EED4C
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 06:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7DC2BDC33;
	Tue, 28 Oct 2025 06:37:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F165E29293D
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 06:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761633424; cv=none; b=OnO2mZ5bbszMOBCNhQGJtN6dYUqP9vmphD1y56jp2DaM3GufMbM3UlNRlF1p0ZrSjQJgBTm+JWtLOEvidoAbPhatEOC11RzOE8+Cse0VEr2P/6REHVjXVd+N7ohXeIsOaasxyddlFk1bUqaYfEj0adRHCbXpvwwmpSou1JvRk/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761633424; c=relaxed/simple;
	bh=Ln0eEjqd5MJgKySWvc33us1BhZgJkUypawNCo7DyBVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fBWPd4CXwvQ5xQpZDkM5+T+NhA+WSIEy4+SvETau6JukUu4dMRYhIroONaxABpZJVaZbP7+7oNrpvMwooN+Q6MqYdhF9Si7mTuy2cbESzfKZbEmFkzstTj6Cc57kXQdmYtkm8ugCEd9MlNiFY1jhoVRL45R633kbR9IePf8HWdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7690063cdb13-52be2;
	Tue, 28 Oct 2025 14:33:50 +0800 (CST)
X-RM-TRANSID:2ee7690063cdb13-52be2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100149 (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee5690063ccc07-cb4ed;
	Tue, 28 Oct 2025 14:33:50 +0800 (CST)
X-RM-TRANSID:2ee5690063ccc07-cb4ed
From: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
To: bpf@vger.kernel.org
Cc: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
Subject: [PATCH] tools:bpf: fix missing closing parethesis for BTF_KIND_UNKN
Date: Tue, 28 Oct 2025 14:33:45 +0800
Message-ID: <20251028063345.1911-1-zhangchujun@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the btf_dumper_do_type function, the debug print statement for
BTF_KIND_UNKN was missing a closing parenthesis in the output format.
This patch adds the missing ')' to ensure proper formatting of the
dump output.

Signed-off-by: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
---
 tools/bpf/bpftool/btf_dumper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index ff12628593ae..def297e879f4 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -590,7 +590,7 @@ static int btf_dumper_do_type(const struct btf_dumper *d, __u32 type_id,
 	case BTF_KIND_DATASEC:
 		return btf_dumper_datasec(d, type_id, data);
 	default:
-		jsonw_printf(d->jw, "(unsupported-kind");
+		jsonw_printf(d->jw, "(unsupported-kind)");
 		return -EINVAL;
 	}
 }
-- 
2.50.1.windows.1




