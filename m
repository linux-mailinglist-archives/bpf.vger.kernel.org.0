Return-Path: <bpf+bounces-43510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0332D9B5C8A
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 08:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F684B22BA8
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 07:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFAC1E0B66;
	Wed, 30 Oct 2024 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bEP1Oet3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5331E04AB;
	Wed, 30 Oct 2024 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730272214; cv=none; b=cEES6GnYOn+yyrgoCTMYoz/29HRunEEeVyphRfoRoKZNCcgJ1vuZmtGk0orJjC9ROkEW9TtHrE+67mu+aIQlJ14EEIJ58lpfYUniiEvRZn5o6e5dQdLJQkzpYYiSM7mqYX6f30mngbry4hcQoeHjIUW7qefWLovhqBlpKvtrA/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730272214; c=relaxed/simple;
	bh=LCPNUq3iGaeSR2LP4VejehOOUzsAM5p+N/nlx1Uemzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxfOhogAJj8Ax85yvKIts9BrypGfUXaeEoHqf4tg0YneMgFZPFbhuwrM1hyX7phnp0VyyGWxlJbDw95LTR+2VJHAC+4DxPVZWssYAz8EvyYMDddFJkRR/1hpyXp8aiqOCZirnVtQioyAetDuXSVAZ38c0cDEhpkrLsbKojYiIP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bEP1Oet3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U2d5tV025731;
	Wed, 30 Oct 2024 07:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=in13zijG61l7ecLJb
	GiATCq7CXIA4eH8JaPC0+Wp3mg=; b=bEP1Oet3OZEICCEwdXCrvDGfb4qhWfjbW
	CQWH0r0wd0O2VDtv1LA0dcs11hyYylwXZafcHMkOqX4JD33zDCsD3Z7ZNwgjpO8T
	yJ6yoCiFMGNRhSRP4sDROKMl5HytTg6O0jOcTdexzMDwAW2+ED4uu12mctzMYKan
	8SeMhI4au2/EvXGj3NlybKfzu2bFS/Jh1PmRJZQe+E/uiUXKxntJZsC8EV3DJgvw
	8fNyFH8mRWh6mkSeeMNEd5O3U0HNd45Nak4k5bXiEEGCWttz4XFxageQjWpIX8Pc
	e6dGP1XdLBcDlq6X9MUX4rrOvRaP7Iqt/3DwmcPGjc3yqPTchuk6w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42jb65h30c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:09:45 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49U79iNq019690;
	Wed, 30 Oct 2024 07:09:45 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42jb65h30a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:09:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49U3smdQ018363;
	Wed, 30 Oct 2024 07:09:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hc8k6u1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:09:44 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49U79e2e44302690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 07:09:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35D172004D;
	Wed, 30 Oct 2024 07:09:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6B2520043;
	Wed, 30 Oct 2024 07:09:36 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.203.115.143])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Oct 2024 07:09:36 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, "Naveen N. Rao" <naveen@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Vishal Chourasia <vishalc@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Subject: [PATCH v7 11/17] kbuild: Add generic hook for architectures to use before the final vmlinux link
Date: Wed, 30 Oct 2024 12:38:44 +0530
Message-ID: <20241030070850.1361304-12-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030070850.1361304-1-hbathini@linux.ibm.com>
References: <20241030070850.1361304-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KXSjSZRDuFAWyQFuTNbLFtfDCPdXm4Dy
X-Proofpoint-GUID: -N5FLRbBM4nblGbXmFJ9f7q2AgrIB-nj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300051

From: Naveen N Rao <naveen@kernel.org>

On powerpc, we would like to be able to make a pass on vmlinux.o and
generate a new object file to be linked into vmlinux. Add a generic pass
in Makefile.vmlinux that architectures can use for this purpose.

Architectures need to select CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX and must
provide arch/<arch>/tools/Makefile with .arch.vmlinux.o target, which
will be invoked prior to the final vmlinux link step.

Acked-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Naveen N Rao <naveen@kernel.org>
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

Changes in v7:
* Changed 'arch_vmlinux_o=""' to 'arch_vmlinux_o='.
* Added Masahiro's Acked-by.


 arch/Kconfig             | 6 ++++++
 scripts/Makefile.vmlinux | 7 +++++++
 scripts/link-vmlinux.sh  | 7 ++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8af374ea1adc..a1538927c8c1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1684,4 +1684,10 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
 config ARCH_NEED_CMPXCHG_1_EMU
 	bool
 
+config ARCH_WANTS_PRE_LINK_VMLINUX
+	bool
+	help
+	  An architecture can select this if it provides arch/<arch>/tools/Makefile
+	  with .arch.vmlinux.o target to be linked into vmlinux.
+
 endmenu
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index 1284f05555b9..dddad554e912 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -22,6 +22,13 @@ targets += .vmlinux.export.o
 vmlinux: .vmlinux.export.o
 endif
 
+ifdef CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX
+vmlinux: arch/$(SRCARCH)/tools/vmlinux.arch.o
+
+arch/$(SRCARCH)/tools/vmlinux.arch.o: vmlinux.o FORCE
+	$(Q)$(MAKE) $(build)=arch/$(SRCARCH)/tools $@
+endif
+
 ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
 # Final link of vmlinux with optional arch pass after final link
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index a9b3f34a78d2..a3c634b2f348 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -100,7 +100,7 @@ vmlinux_link()
 	${ld} ${ldflags} -o ${output}					\
 		${wl}--whole-archive ${objs} ${wl}--no-whole-archive	\
 		${wl}--start-group ${libs} ${wl}--end-group		\
-		${kallsymso} ${btf_vmlinux_bin_o} ${ldlibs}
+		${kallsymso} ${btf_vmlinux_bin_o} ${arch_vmlinux_o} ${ldlibs}
 }
 
 # generate .BTF typeinfo from DWARF debuginfo
@@ -198,6 +198,11 @@ fi
 
 ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init init/version-timestamp.o
 
+arch_vmlinux_o=
+if is_enabled CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX; then
+	arch_vmlinux_o=arch/${SRCARCH}/tools/vmlinux.arch.o
+fi
+
 btf_vmlinux_bin_o=
 kallsymso=
 strip_debug=
-- 
2.47.0


