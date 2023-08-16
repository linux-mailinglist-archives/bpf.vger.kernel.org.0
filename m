Return-Path: <bpf+bounces-7908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A6977E596
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 17:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531481C21096
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 15:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033DF16415;
	Wed, 16 Aug 2023 15:50:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05A1125B2
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 15:49:59 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149F92D55;
	Wed, 16 Aug 2023 08:49:51 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GFnBWG012362;
	Wed, 16 Aug 2023 15:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=aHwaYRnkxa+7Cx2tcdB6vCxEkjdPaozZFSi/y5fWKic=;
 b=bOWhg8QfS1CMBehNRqiXkBbSu0DcO8HHZ73cbKsnVfOzB5yANXwazf7QGuT3wIefXkmj
 Nwfp1LZ1tpDZmhqrVNLZuYLBO8Mu5+m1NLSMXo3RbTbHWifgbv+0lphkUm9h4eFe21Qh
 dn6uoel/quu6Y5969cY8SIswUWNOrTjV6pYMWtvxqshxELYlYI3ExuDzI3DOBhKyylNO
 oEVVj6/tT1AIF0k4Qw224BiQs67rSiBx8F1OnVLqmEbc3eNLqBEZ7P/uLK/zNLUbC9Yy
 WbcrzJYe7rsJdOXZhI2jc6JMffdL8boxieEUDeIBR+3jW546qlJVJFjRbwXLYSit/t0I 3Q== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sh1ec80y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Aug 2023 15:49:47 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37GEeEsi013223;
	Wed, 16 Aug 2023 15:49:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sepmjwkrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Aug 2023 15:49:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37GFnimO57475498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Aug 2023 15:49:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9701520043;
	Wed, 16 Aug 2023 15:49:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8391120040;
	Wed, 16 Aug 2023 15:49:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Aug 2023 15:49:44 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 21A2CE012C; Wed, 16 Aug 2023 17:49:44 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH RESEND v3 0/3] few fixes for synthetic trace events
Date: Wed, 16 Aug 2023 17:49:25 +0200
Message-Id: <20230816154928.4171614-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: arZIAlubfSFextnGlf2IW_5VZ4dIWbIl
X-Proofpoint-GUID: arZIAlubfSFextnGlf2IW_5VZ4dIWbIl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_15,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=991 phishscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160135
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Steven,

I'm now sending these patches in one patchset, because the second patch
has a dependeny on the union vs. cast fix.

Changes in v3:
- remove superfluous struct around union trace_synth_field

Changes in v2:
- cosmetic changes
- add struct trace_dynamic_info to include/linux/trace_events.h

Sven Schnelle (3):
  tracing/synthetic: use union instead of casts
  tracing/synthetic: skip first entry for stack traces
  tracing/synthetic: allocate one additional element for size

 include/linux/trace_events.h      |  11 ++++
 kernel/trace/trace.h              |   8 +++
 kernel/trace/trace_events_synth.c | 103 ++++++++++++------------------
 3 files changed, 60 insertions(+), 62 deletions(-)

-- 
2.39.2


