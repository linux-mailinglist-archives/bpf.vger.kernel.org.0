Return-Path: <bpf+bounces-7693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29C277B13F
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 08:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3D9280FEE
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 06:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF2C53A1;
	Mon, 14 Aug 2023 06:09:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371F25237
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 06:09:05 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C2F19B5;
	Sun, 13 Aug 2023 23:08:55 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E63R5h005710;
	Mon, 14 Aug 2023 06:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+LEqgbgJrJJaX+HpQ83fqIFwJ69ofoMpd+GcuOiWZ9U=;
 b=TLRcDwZeasuwyWQRCrgVxPoq4CCsE83o0LYj97uXFZtwlgTDbwqq/drjAqYi0OAq3Goi
 gD9kpTiV9EvxMRoOPcyQLAvSPD+H3prM1XPjBjKZCPCLRsXHuBuk99HtHWnsJZVyCUQd
 gTq3WSukfUyemTwoCEIM5dSFjFVGjTFTvzx5nw5HGectFGxmoO3DbFLEWMV658uTZnMC
 oULA7QjFjKBFao+HUKdr9JbXP7Q0B5b7uN+Lajrtt9O8obogJ52djGOH0TKYfHb7Ew+C
 hMx6OL2jtxExMnAZXkMulKumX/dkV9IVz3xqZE8kc52yi9hHwRFjRHL50Qc2XZedP4m4 tg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfenqrfc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 06:08:48 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37E4x8N4013240;
	Mon, 14 Aug 2023 06:07:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sepmj97cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 06:07:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37E67NrD2818690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Aug 2023 06:07:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4ADA72004E;
	Mon, 14 Aug 2023 06:07:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C06572004B;
	Mon, 14 Aug 2023 06:07:22 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Aug 2023 06:07:22 +0000 (GMT)
Received: from bgray-lenovo-p15.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B71006064A;
	Mon, 14 Aug 2023 16:07:17 +1000 (AEST)
From: Benjamin Gray <bgray@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-doc@vger.kernel.org, bpf@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc: abbotti@mev.co.uk, hsweeten@visionengravers.com, jan.kiszka@siemens.com,
        kbingham@kernel.org, mykolal@fb.com,
        Benjamin Gray <bgray@linux.ibm.com>
Subject: [PATCH 6/8] tools/power: fix Python string escapes
Date: Mon, 14 Aug 2023 16:07:02 +1000
Message-ID: <20230814060704.79655-7-bgray@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814060704.79655-1-bgray@linux.ibm.com>
References: <20230814060704.79655-1-bgray@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hl6PiBnu7GQCT8PUV4NKLnXO2JONskZ5
X-Proofpoint-ORIG-GUID: hl6PiBnu7GQCT8PUV4NKLnXO2JONskZ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_24,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140055
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Python 3.6 introduced a DeprecationWarning for invalid escape sequences.
This is upgraded to a SyntaxWarning in Python 3.12, and will eventually
be a syntax error.

Fix these now to get ahead of it before it's an error.

Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
---
 tools/power/pm-graph/bootgraph.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/pm-graph/bootgraph.py b/tools/power/pm-graph/bootgraph.py
index f96f50e0c336..e983c4e71d77 100755
--- a/tools/power/pm-graph/bootgraph.py
+++ b/tools/power/pm-graph/bootgraph.py
@@ -77,12 +77,12 @@ class SystemValues(aslib.SystemValues):
 			fp.close()
 		self.testdir = datetime.now().strftime('boot-%y%m%d-%H%M%S')
 	def kernelVersion(self, msg):
-		m = re.match('^[Ll]inux *[Vv]ersion *(?P<v>\S*) .*', msg)
+		m = re.match('^[Ll]inux *[Vv]ersion *(?P<v>\\S*) .*', msg)
 		if m:
 			return m.group('v')
 		return 'unknown'
 	def checkFtraceKernelVersion(self):
-		m = re.match('^(?P<x>[0-9]*)\.(?P<y>[0-9]*)\.(?P<z>[0-9]*).*', self.kernel)
+		m = re.match('^(?P<x>[0-9]*)\\.(?P<y>[0-9]*)\\.(?P<z>[0-9]*).*', self.kernel)
 		if m:
 			val = tuple(map(int, m.groups()))
 			if val >= (4, 10, 0):
@@ -324,7 +324,7 @@ def parseKernelLog():
 		idx = line.find('[')
 		if idx > 1:
 			line = line[idx:]
-		m = re.match('[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
+		m = re.match('[ \t]*(\\[ *)(?P<ktime>[0-9\\.]*)(\\]) (?P<msg>.*)', line)
 		if(not m):
 			continue
 		ktime = float(m.group('ktime'))
@@ -336,20 +336,20 @@ def parseKernelLog():
 			if(not sysvals.stamp['kernel']):
 				sysvals.stamp['kernel'] = sysvals.kernelVersion(msg)
 			continue
-		m = re.match('.* setting system clock to (?P<d>[0-9\-]*)[ A-Z](?P<t>[0-9:]*) UTC.*', msg)
+		m = re.match('.* setting system clock to (?P<d>[0-9\\-]*)[ A-Z](?P<t>[0-9:]*) UTC.*', msg)
 		if(m):
 			bt = datetime.strptime(m.group('d')+' '+m.group('t'), '%Y-%m-%d %H:%M:%S')
 			bt = bt - timedelta(seconds=int(ktime))
 			data.boottime = bt.strftime('%Y-%m-%d_%H:%M:%S')
 			sysvals.stamp['time'] = bt.strftime('%B %d %Y, %I:%M:%S %p')
 			continue
-		m = re.match('^calling *(?P<f>.*)\+.* @ (?P<p>[0-9]*)', msg)
+		m = re.match('^calling *(?P<f>.*)\\+.* @ (?P<p>[0-9]*)', msg)
 		if(m):
 			func = m.group('f')
 			pid = int(m.group('p'))
 			devtemp[func] = (ktime, pid)
 			continue
-		m = re.match('^initcall *(?P<f>.*)\+.* returned (?P<r>.*) after (?P<t>.*) usecs', msg)
+		m = re.match('^initcall *(?P<f>.*)\\+.* returned (?P<r>.*) after (?P<t>.*) usecs', msg)
 		if(m):
 			data.valid = True
 			data.end = ktime
-- 
2.41.0


