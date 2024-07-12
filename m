Return-Path: <bpf+bounces-34639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115EA92F80C
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 11:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424C41C220FA
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 09:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D1D1442F7;
	Fri, 12 Jul 2024 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fvx4pJo/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE53B1422DE
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720776575; cv=none; b=YnTCFDH0yNVtVn69vSqFuqVX9D2EJv+d1kkG5ubI8pN5bJ4Zz6TUA8nf+3d27at2tVwLROgF6dmGkJ0/poU2Ov19KWe9BlFkO3x8+Mm9l+hDtmjeOEoJgRELiwr8J9YBc+ShvUt75nLg3iQnF2PeJ/IoDbQ91lv6rTxWtDVxaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720776575; c=relaxed/simple;
	bh=ObOQiaGFKUtUSi0oRIoFK+DjH7rCRjJc3vrlLZEj7tM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iOUx9H4m318BQgUquHH4w+idEvZO94SFFwOknV2klLV6n+Vugd5N3E6RPp0Q8J37PJPImcRLKBEK2g/t3iE7U+ZTcATKd4VsG0Lo4ek0sC/q3SjH58VDuHbot4wtpWi6EVz2gXFTG0h/NxkY30l8TlQrK7InsyH6iNVtsRGRTPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fvx4pJo/; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C1BUHb016088;
	Fri, 12 Jul 2024 09:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=corp-2023-11-20; bh=dEQ9/SJfeW66aw
	ALqwpgl5y0Xevdb25JhGFi6K5FmPU=; b=fvx4pJo/zb9guqf883cYxnXiojrB1s
	0MUAwBgSlsYLNIcycIyfS22jNytwrsBKwdh7JtFuWagZA3Nd/WgH2HesJLY6SfKV
	b0elhKIcP9XfATCd2qkLpKgRysiYSfIHv9C/qINdFKLv234GNKCC9FLwTaLRcELA
	rXEZSJSs2HbbQGsMwcAwCyaX6nuXPoVtEmItsWih4qnVsnCpmMMryowt0H2dG1fC
	BZyfsQ+h2Zj4PxO7o5QqRQimMPmi+l2rEsgGxMetmkFESy6Sm+o0RSETRtqu1jjf
	fxeUuRk7EpnSlEgurOXPn8eh9fyZFlaOkfnJGeEe+tnCLxR+e/kNAP5A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknuh9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 09:29:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46C8VDl4008783;
	Fri, 12 Jul 2024 09:29:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv5qdda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 09:29:04 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46C9T42M013625;
	Fri, 12 Jul 2024 09:29:04 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-207-250.vpn.oracle.com [10.175.207.250])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 409vv5qdbb-1;
	Fri, 12 Jul 2024 09:29:04 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: martin.lau@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Mirsad Todorovac <mtodorovac69@gmail.com>
Subject: [PATCH bpf-next] bpf: eliminate remaining "make W=1" warnings in kernel/bpf/btf.o
Date: Fri, 12 Jul 2024 10:28:59 +0100
Message-ID: <20240712092859.1390960-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_06,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120067
X-Proofpoint-GUID: wy7uAw7QVKPUC7rgHkkNAdkCShvtz1k3
X-Proofpoint-ORIG-GUID: wy7uAw7QVKPUC7rgHkkNAdkCShvtz1k3

As reported by Mirsad [1] we still see format warnings in kernel/bpf/btf.o
at W=1 warning level:

  CC      kernel/bpf/btf.o
./kernel/bpf/btf.c: In function ‘btf_type_seq_show_flags’:
./kernel/bpf/btf.c:7553:21: warning: assignment left-hand side might be a candidate for a format attribute [-Wsuggest-attribute=format]
 7553 |         sseq.showfn = btf_seq_show;
      |                     ^
./kernel/bpf/btf.c: In function ‘btf_type_snprintf_show’:
./kernel/bpf/btf.c:7604:31: warning: assignment left-hand side might be a candidate for a format attribute [-Wsuggest-attribute=format]
 7604 |         ssnprintf.show.showfn = btf_snprintf_show;
      |                               ^

Combined with CONFIG_WERROR=y these can halt the build.

The fix (annotating the structure field with __printf())
suggested by Mirsad resolves these. Apologies I missed this last time.
No other W=1 warnings were observed in kernel/bpf after this fix.

[1] https://lore.kernel.org/bpf/92c9d047-f058-400c-9c7d-81d4dc1ef71b@gmail.com/

Fixes: b3470da314fd ("bpf: annotate BTF show functions with __printf")
Suggested-by: Mirsad Todorovac <mtodorovac69@gmail.com>
Reported-by: Mirsad Todorovac <mtodorovac69@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d5019c4454d6..520f49f422fe 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -415,7 +415,7 @@ const char *btf_type_str(const struct btf_type *t)
 struct btf_show {
 	u64 flags;
 	void *target;	/* target of show operation (seq file, buffer) */
-	void (*showfn)(struct btf_show *show, const char *fmt, va_list args);
+	__printf(2, 0) void (*showfn)(struct btf_show *show, const char *fmt, va_list args);
 	const struct btf *btf;
 	/* below are used during iteration */
 	struct {
-- 
2.31.1


