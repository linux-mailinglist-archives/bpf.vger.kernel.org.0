Return-Path: <bpf+bounces-9713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8821679C698
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 08:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BCD281626
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 06:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E98D171C4;
	Tue, 12 Sep 2023 06:08:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2C5171AD
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 06:08:49 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CE110C6;
	Mon, 11 Sep 2023 23:08:49 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C67ptP023034;
	Tue, 12 Sep 2023 06:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=i/BWHqLFUbyvP7xwuZNU6sl0evU8IuBy8XSKXM7iy4M=;
 b=aAvDBdoOF2s0iz8P+59qU5iannJGZ5Z/k3DfwMzND5xZNFUhooKFry4mSzQWnaD4kPkm
 Uz/aS0PJGmDmgzdkAJhU+oZZUcC1HZNiHW/aVQER1DZdq1XD56GuVS1iYuU1abcuKupc
 27UkO8cGjNh3Zh+ZZ2IGtfAcZXkyC0ABACfjD81VknI+QJacjZ8x3UtZAu68PST6+BV/
 POtmUjwpFhOHNEdn92kNoU/x1ky7v9XBInhZKxWG9W4/j9JBIYjt9QHXqZNC9nnEGBZC
 FE1mkKh9lFwbt/K4yO09Rs2SeyumvI5lp3RQNHBr4LkzTtDzu5wGZB02wDLEPCZewPgn Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2jbhr2gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Sep 2023 06:08:21 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38C68KlR026058;
	Tue, 12 Sep 2023 06:08:20 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2jbhr2f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Sep 2023 06:08:20 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38C50QcL024061;
	Tue, 12 Sep 2023 06:08:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t131t14q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Sep 2023 06:08:17 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38C68GK751511700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Sep 2023 06:08:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19B132004F;
	Tue, 12 Sep 2023 06:08:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 894CD2004D;
	Tue, 12 Sep 2023 06:08:15 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Sep 2023 06:08:15 +0000 (GMT)
Received: from bgray-lenovo-p15.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 51EA460525;
	Tue, 12 Sep 2023 16:08:13 +1000 (AEST)
From: Benjamin Gray <bgray@linux.ibm.com>
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, llvm@lists.linux.dev,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>
Subject: [PATCH v2 3/7] drivers/comedi: fix Python string escapes
Date: Tue, 12 Sep 2023 16:07:57 +1000
Message-ID: <20230912060801.95533-4-bgray@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912060801.95533-1-bgray@linux.ibm.com>
References: <20230912060801.95533-1-bgray@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ht3TfvFc0_YeVg_8IiUdPAm8k0D23rNZ
X-Proofpoint-ORIG-GUID: muMt5JJeGDhOfEDCB02ZP0AzKiBwbhnu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120050

Python 3.6 introduced a DeprecationWarning for invalid escape sequences.
This is upgraded to a SyntaxWarning in Python 3.12, and will eventually
be a syntax error.

Fix these now to get ahead of it before it's an error.

Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
---
 drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py b/drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py
index 90378fb50580..d19101fc2a94 100755
--- a/drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py
+++ b/drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py
@@ -44,7 +44,7 @@ def routedict_to_structinit_single(name, D, return_name=False):
 
     lines.append('\t\t[B({})] = {{'.format(D0_sig))
     for D1_sig, value in D1:
-      if not re.match('[VIU]\([^)]*\)', value):
+      if not re.match(r'[VIU]\([^)]*\)', value):
         sys.stderr.write('Invalid register format: {}\n'.format(repr(value)))
         sys.stderr.write(
           'Register values should be formatted with V(),I(),or U()\n')
-- 
2.41.0


