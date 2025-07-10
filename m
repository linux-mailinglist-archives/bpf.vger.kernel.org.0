Return-Path: <bpf+bounces-62913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BACB00111
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 14:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41E31C80AE5
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 12:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FEB258CE2;
	Thu, 10 Jul 2025 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fyZ5EV88"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D71230D1E;
	Thu, 10 Jul 2025 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148788; cv=none; b=OS0SoQcUoLyx6eD1/G4HNP4D3cCzI/tO2nn2POeNr0jXKKSvosh3ctW9iPh5lvgWLcSS8ucIn55tRdmdZQMU9FUvaYubeEb/YswN+cUBwaXmrk4Vw8iRvLDfHXf0UUkdtgVdOoz7jngAxh1BKGVs/X7AIZ+LTx1V/qGrD0onCeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148788; c=relaxed/simple;
	bh=gNCxzJsDn9gdEyJo3Z7t2p8WEEmiQ2LS5kDUpkWb5nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MsozmpUO/v4z/jiNXoh3KOcUChtBtw85BXR2geUm5aBEe9VBrCKzBmeeeE4djeXDPB/DUvFUJmdruVw4qg5aZy4PWWwDXkZG12WaCtC58cNUPGYgjtgYefojwRk5XzWhYZHwj6/Y1UlHReDGw7RzC1o1uvQSK/6flk2GvdbCgJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fyZ5EV88; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A7YlIE010973;
	Thu, 10 Jul 2025 11:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=OpCNIQJBz886dEMbI2Ec3w9pVflL1kz7l1b1KeRf/
	vE=; b=fyZ5EV883tAhyxDnybYgZYPvXQQvYQ0lDElNIx2UjaCTU9+FJFXkIjOa4
	MUxBH2Xlx9HtFPUzhc8wKSa2LHIi1DRhaa5gNMgZK19smlSBqxDgH1C5Nl191Uvc
	C7HPJvFhAYhl4bFUNfXwW02+LeIQ1Yq77qNiKi0rhLSxMzwPN9y/8qtty5frE+IE
	e2boqwV/6FqKHXBPfB6X7DEE3+lDWSGzovtvUO6iza23A1dSMRMRSSH0S15KkHIo
	VSO4qIuov2QGYDtz9PYWjVeTGfQT2+3p0K2rR7g2de8EIrdcm4OONHOARyjQcCga
	fEQ7Gyga1D2QlRdood+h5gDGepNxg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puqnkj47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 11:59:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9HFKF021522;
	Thu, 10 Jul 2025 11:59:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qectwp9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 11:59:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56ABxRBU32702836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 11:59:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D6032004B;
	Thu, 10 Jul 2025 11:59:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AC5920043;
	Thu, 10 Jul 2025 11:59:26 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.154.34])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 11:59:26 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/2] scripts/gdb/symbols: make BPF debug info available to GDB
Date: Thu, 10 Jul 2025 13:53:18 +0200
Message-ID: <20250710115920.47740-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FZ43xI+6 c=1 sm=1 tr=0 ts=686fab23 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=Wb1JkmetP80A:10 a=IYNAWcdd8jllPgNNEL8A:9
X-Proofpoint-GUID: KbXdV9Z0tZv8HI9n-VMQeVRT5dOucmdt
X-Proofpoint-ORIG-GUID: KbXdV9Z0tZv8HI9n-VMQeVRT5dOucmdt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwMSBTYWx0ZWRfX9aXX2knXaKx0 +vVUWje1KN6zPgQ5Mwta8qI7u9WFdZi538Kw2QfDFVKdPQdsUIeEOjLl5pZJIsaGT6KdB4Etise yQKbHEmQUyX1sJnLadyW0PgocnAU+X57fLtJuYzXUGbeimGqdzkQ5Tp0TyuyQOmJTEvhw4Id1fv
 MekgrVg9EDkmT1HPp57+MYD3zEgySfu1XPGKURFYlH/xE2Ib6tzCACm2KKYQydzxcmnL90AzWvc 6n/pvcH4/ohk7DIr/UsCNnE+fl1u6TmDKFZK3l5yej5Vnll5gp68De6nZyKQx8iMNQhlk6Cg40X Cxt70Lq6CkyUoNBUvOnXEHDh4g3XgUXneyqTw0E1zwF8k2XkB02CQr2PGXNFqyW8pF9OhnM1ONE
 KBRI5RkM4kkS6oOdXZnhaL/BLntcdVi2jvT/H7RrbSh+8aT3/kSzhF+hwELGxL70mZ9Itsro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=534 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100101

Hi,

This series greatly simplifies debugging BPF progs when using QEMU
gdbstub by providing symbol names, sizes, and line numbers to GDB.

Patch 1 adds radix tree iteration, which is necessary for parsing
prog_idr. Patch 2 is the actual implementation; its description
contains some details on how to use this.

Best regards,
Ilya

Ilya Leoshkevich (2):
  scripts/gdb/radix-tree: add lx-radix-tree-command
  scripts/gdb/symbols: make BPF debug info available to GDB

 scripts/gdb/linux/bpf.py          | 253 ++++++++++++++++++++++++++++++
 scripts/gdb/linux/constants.py.in |   3 +
 scripts/gdb/linux/radixtree.py    | 139 +++++++++++++++-
 scripts/gdb/linux/symbols.py      |  77 ++++++++-
 4 files changed, 462 insertions(+), 10 deletions(-)
 create mode 100644 scripts/gdb/linux/bpf.py

-- 
2.50.0


