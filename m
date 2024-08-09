Return-Path: <bpf+bounces-36777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A6094D266
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 16:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A401F23582
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 14:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B49197A65;
	Fri,  9 Aug 2024 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="mKrqswFu"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2453D1DFE1;
	Fri,  9 Aug 2024 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723214681; cv=none; b=ZZ49QHIrLlKrxQqy9qyyR8m/Jme1knx8EP8Tr47ds37CqMjad98xuGtKg6BgNJCWYcPRFcwKSwsI799lvPQM9BY8UR2cI2+xL5MkFGbIztcpxE2WxU//2CEZmZtkoaZv3tU7W9UXVyoiwQk8cgcXbkxUh89uGqjrDE2rUAT51p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723214681; c=relaxed/simple;
	bh=TrF/mr/2zI8FT+BViDYpEcVJbQ3l7PzuFtp6y3/Szts=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XaqvUGkJ4hcgq3CYSiOvUPyyr2tcs2nQleS7V5+DeZRz87nF/FzfjibSmf0Gh3g7eg/za6gTah7QmDznBkQRVDK1xGQOZyHL7JNsz8x1+Ax8s4k7Rf2Obut6y96nxMoK0RRXAZCX/wyHST9rd2vjS/m0OtL8c3QszUIjpjPFNgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=mKrqswFu; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479E0b2x019365;
	Fri, 9 Aug 2024 14:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=pzF8DEytzWMJR
	E2Zo3V+oeXaX+x2DcWjDmWLTnsk25A=; b=mKrqswFupu7596N0VzXCAg5YXFtiF
	WxPasbQtAQYVosQkXDhVqJQQZ3nfwCuob2mDmWiBEUbcjE17CVSVECb5xOCNMOh+
	hgn5J0LCPbaKCBwvGsy+xTkhUxmYdRXLX9d4fWq6Cs++JyD6y/AAV4wsxpv+QgRO
	FHgXCt2YrOX8Z+eWLyOi0fDPYeLXXzGH0i7IQXI2vB80SoNqgkjvd8LX7ktRCPDw
	B8tfpN34xXl9gp8W9Ow0mnGGdHM7RJL7b2oQbYyUnf2cr03dwmeOmaVDC+MyRnSg
	0yTRAbEnwE5ahp+HdWor2MEzNIbjiNCUrAeuDqYGfYl60GecODQ6qG+yg==
Received: from 03wpexch12.crowdstrike.sys (74-209-223-77.static.ash01.latisys.net [74.209.223.77] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 40wf908qvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 14:16:55 +0000 (GMT)
Received: from 03wpexch13.crowdstrike.sys (10.80.52.143) by
 03WPEXCH12.crowdstrike.sys (10.80.52.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 9 Aug 2024 07:16:54 -0700
Received: from 03wpexch13.crowdstrike.sys ([fe80::595e:a96f:853f:da0d]) by
 03wpexch13.crowdstrike.sys ([fe80::595e:a96f:853f:da0d%14]) with mapi id
 15.02.1544.009; Fri, 9 Aug 2024 14:16:54 +0000
From: Rahul Shah <rahul.shah@crowdstrike.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: Marco Vedovati <marco.vedovati@crowdstrike.com>,
        Kelly Martin
	<kelly.martin@crowdstrike.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
        Rahul Shah <rahul.shah@crowdstrike.com>
Subject: uprobe causing a process to crash on file modification
Thread-Topic: uprobe causing a process to crash on file modification
Thread-Index: AQHa6mU1CRKX5L7u10y95iAPiGl51Q==
Date: Fri, 9 Aug 2024 14:16:54 +0000
Message-ID: <d26368538d5f4504b9ca239b14328d33@crowdstrike.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-disclaimer: USA
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Authority-Analysis: v=2.4 cv=AqC83/9P c=1 sm=1 tr=0 ts=66b624d7 cx=c_pps a=gZx6DIAxr9wtOoIAvRqG0Q==:117 a=gZx6DIAxr9wtOoIAvRqG0Q==:17 a=xqWC_Br6kY4A:10 a=EjBHVkixTFsA:10 a=N659UExz7-8A:10 a=yoJbH4e0A30A:10 a=gYw7AgALRtIvlrhRB3wA:9 a=pILNOxqGKmIA:10
X-Proofpoint-ORIG-GUID: KE0GaMDCDTws6WXWNTkzS1AeEiMiYAxT
X-Proofpoint-GUID: KE0GaMDCDTws6WXWNTkzS1AeEiMiYAxT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_10,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408090103


We have noticed an issue when a uprobe is attached to a valid file offset, =
and the content of that file is modified (with no inode change).
Executing from a modified file while the uprobe is attached may cause a pro=
cess to crash. The crash happens if the probed offset is invalid for the ne=
w file content.

Here's a simple scenario for an executable leading to consistent crashes (b=
ut something similar can happen for DSO too):

1. Create a simple binary B1 that has symbol S1 at offset O1. The binary B1=
 has inode INO_1.
2. Start a new process P1 and attach an uprobe to this binary at B1:S1:O1
3. Run the binary B1 and the uprobe is fired as expected.
4. Continue to run the process P1 (a.k.a the uprobe is still attached to B1=
:S1:O1)
5. Create a new binary B2 that no longer has the symbol S1 at offset O1. Th=
e binary B2 has inode INO_2
6. Copy the content of binary INO_2 to INO_1 using cp command. As a result =
the original binary B1 with INO_1  has new contents and no longer has symbo=
l S1 at offset O1. The key here is it=92s the same inode.
7. The original process P1 still has an uprobe attached to B1:S1:O1.
8. Re-run the binary B1 and it seg faults immediately. In short any B1 beco=
me completely unusable.
9. Detach the uprobe.
10. Re-run the binary B1 and all good

Sample gdb output where it crashes (Notice the (bad))

0x0000555555555154 in _fini ()
(gdb) x/20i _fini
   0x555555555148 <_fini>:	repz int3
   0x55555555514a <_fini+2>:	(bad)
   0x55555555514b <_fini+3>:	cli
   0x55555555514c <_fini+4>:	sub    $0x8,%rsp
   0x555555555150 <_fini+8>:	add    $0x8,%rsp
=3D> 0x555555555154 <_fini+12>:	ret

Syslogs output:
Aug  8 21:33:00 rshahvm2 kernel: [50553.686400] hello_world[30144]: segfaul=
t at f7d3e9c8 ip 00007f9701b40144 sp 00000000f7d3e9c8 error 4 in libfoo.so[=
7f9701b40000+1000]
Aug  8 21:33:00 rshahvm2 kernel: [50553.686409] Code: 0f 1e fa 55 48 89 e5 =
90 90 90 5d c3 f3 0f 1e fa 55 48 89 e5 e8 1d ff ff ff 5d c3 00 00 00 f3 cc =
1e fa 48 83 ec 08 48 83 c4 08 <c3> 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00

What we saw is that when a file (executable or a DSO) is mapped in a proces=
s memory, the kernel installs all uprobes registered for that file's inode,=
 no matter if the file has been changed since the initial uprobe registrati=
on.

If uprobes are installed at a offset that's mo more valid, this behavior ca=
n make all new application completely unusable.

Just wondering if there is any fix in the kernel for this of if anyone else=
 has observed similar behavior.

Thanks,
Rahul

