Return-Path: <bpf+bounces-46234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98029E642B
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 03:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69C0167DDD
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 02:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F65145A18;
	Fri,  6 Dec 2024 02:31:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015D88F66;
	Fri,  6 Dec 2024 02:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733452261; cv=none; b=TJu/afybft7nVdKHEV3uEqIwBaREcy3/7F6SYROatXEPM1ORNL5PCWbxjcjOwKC1Au56PmQQbWaNRSgAkpjF2uZd4C+BtfNi1tgfrpNK+jUsOYyqwMs4nx5lgQtgsl//Mu9qC696j1ke2LeJACMUPyM3bc6LbdK4myF8m5k/RbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733452261; c=relaxed/simple;
	bh=yQ6ckN8Y02e6hyfNKLYancKsyXQ188SN1EDAT8noiic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VP8DAasqPdULpuyXaWEeFL7pCDC2H8peHSQlR4AskDEAja+JiQfN8hiQzsejY3sYDnrgxBApdj5DoZKjS+b8+nSHi29YhjKJH7Poi6cWLQhRQl2TeXIJ3hw7zZwmniv1X70CCbrnyUk2ELPz+d+oumySBryKZEXlC5w2DtDnzqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee8675261df5a0-165ec;
	Fri, 06 Dec 2024 10:30:55 +0800 (CST)
X-RM-TRANSID:2ee8675261df5a0-165ec
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee6675261dd45b-c9854;
	Fri, 06 Dec 2024 10:30:55 +0800 (CST)
X-RM-TRANSID:2ee6675261dd45b-c9854
From: liujing <liujing@cmss.chinamobile.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] samples/bpf: Modify the incorrect format specifier
Date: Fri,  6 Dec 2024 10:30:46 +0800
Message-Id: <20241206023046.2539-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace %d with %u in snprintf() because it is "unsigned int".

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/samples/bpf/xdp_router_ipv4_user.c b/samples/bpf/xdp_router_ipv4_user.c
index 266fdd0b025d..3fc1d37fee7c 100644
--- a/samples/bpf/xdp_router_ipv4_user.c
+++ b/samples/bpf/xdp_router_ipv4_user.c
@@ -134,11 +134,11 @@ static void read_route(struct nlmsghdr *nh, int nll)
 					*((__be32 *)RTA_DATA(rt_attr)));
 				break;
 			case RTA_OIF:
-				sprintf(ifs, "%u",
+				sprintf(ifs, "%d",
 					*((int *)RTA_DATA(rt_attr)));
 				break;
 			case RTA_METRICS:
-				sprintf(metrics, "%u",
+				sprintf(metrics, "%d",
 					*((int *)RTA_DATA(rt_attr)));
 			default:
 				break;
-- 
2.27.0




