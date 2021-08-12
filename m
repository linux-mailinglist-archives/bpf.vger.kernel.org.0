Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C100D3EA62F
	for <lists+bpf@lfdr.de>; Thu, 12 Aug 2021 16:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbhHLOGZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Aug 2021 10:06:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235893AbhHLOGY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Aug 2021 10:06:24 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CE4G7E160849;
        Thu, 12 Aug 2021 10:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=jWrc90swzFbjHtNAbGyb9aaat99QwVqKjGo7oGJecFc=;
 b=M1XrBAT6sYzZeaQ/AGqE2z4TZEBfddjopVQ9MY75dQFoOLfSUGAoMsPdYCk329Ylhuij
 OUwgpMGbCj5bwY/ox1NHlB4RXbhPaPJYtCD2/beCHCd29yYGu5zuzNNLWk+Gzj9VXsbV
 fLUmt0ATEDIWcwEgtFLCMKBxfZua1CrTBU9OEm8X5Ed61eL9CmhFSyPO/egml70qlfDe
 gOqo13lj/xLDnunsVQLOgFgozMw66OffVEdyv+PuJYVPAO1EY/KqlyVCrYaGSrnytino
 +LkctSwX1KDO69vPkgMYzE2bo8mtF5uAYNOMdgTRIgw82OGu7QJLF/tT5PcryCvxBNhj /Q== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ad4hxh2g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 10:05:25 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17CE32wg026264;
        Thu, 12 Aug 2021 14:05:23 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3acf0ktja5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 14:05:23 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17CE26H655706038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 14:02:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C930E11C085;
        Thu, 12 Aug 2021 14:05:19 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 709D811C07D;
        Thu, 12 Aug 2021 14:05:19 +0000 (GMT)
Received: from vm.lan (unknown [9.145.77.113])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Aug 2021 14:05:19 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf 0/2] bpf: clear zext_dst of dead insns
Date:   Thu, 12 Aug 2021 16:05:16 +0200
Message-Id: <20210812140518.183178-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PkgnxKe4ypPww_TqVuhXymO9DXpy3lO6
X-Proofpoint-GUID: PkgnxKe4ypPww_TqVuhXymO9DXpy3lO6
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-12_05:2021-08-12,2021-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=981 spamscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120087
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix the "verifier bug. zext_dst is set, but no reg is defined" failure
in the "access skb fields ok" test on s390.

Patch 1 is the fix, patch 2 adds a test.

v1: https://lore.kernel.org/bpf/20210812111220.181824-1-iii@linux.ibm.com/
v1 -> v2: Rebase to bpf branch, add Fixes:, add a test (Daniel).

Ilya Leoshkevich (2):
  bpf: clear zext_dst of dead insns
  selftests: bpf: test that dead ldx_w insns are accepted

 kernel/bpf/verifier.c                            |  1 +
 tools/testing/selftests/bpf/verifier/dead_code.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

-- 
2.31.1

