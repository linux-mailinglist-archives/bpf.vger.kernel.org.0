Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7AD4B9F7F
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 13:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbiBQMBC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 07:01:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbiBQMBC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 07:01:02 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4641829412D;
        Thu, 17 Feb 2022 04:00:48 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HBddKk030523;
        Thu, 17 Feb 2022 12:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=RPK02i33myDKA4bIkfBDslJjVJucaG1dFf32Qm6oCgE=;
 b=rk1u9ymXsuEs3djR5ElAft4xFo4MRy4bFLpasvqVsK46eYuEiMBA81wE25tRWlORrpk8
 nM3xTNqufSc02jOvf4YeleHIkMGr77nlB0NVyYuUPkKZMUcsVPmMxHb3oIFJJgvgv56g
 AkiLu1nOZoKtjdU+CRj3WdMI0PkzJADUn90fLa4g4i/QtCcEuJRLMMsykV/jBry3vpjd
 A3S7sTPbqyYt8mDlN+ohJ1uACV37mQxEo4Dr8OhlIvAgNNfH/nt+ooT5tg+AjyIwxGKQ
 cTjk7iIXX+2cPATrWE2J7SfLkFn/CprV/GRw/TX94y5t/WJo1IusAuiSiUAI0+GhnHZ/ pA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e9k53kyju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 12:00:10 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21HBrw4A016454;
        Thu, 17 Feb 2022 12:00:09 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e9k53kyh6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 12:00:09 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21HBZwAv022806;
        Thu, 17 Feb 2022 11:36:46 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3e64ha7782-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 11:36:45 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21HBahp937028328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 11:36:43 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91A4352071;
        Thu, 17 Feb 2022 11:36:42 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.115.39])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1E43852065;
        Thu, 17 Feb 2022 11:36:39 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, <bpf@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] powerpc/ftrace: Reserve instructions from function entry for ftrace
Date:   Thu, 17 Feb 2022 17:06:22 +0530
Message-Id: <cover.1645096227.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DQ6MhTknBE0_u8Dy8aNbZyxfn4xTp6Am
X-Proofpoint-GUID: 16gxvXOI1def_ltGAETNZW6zLj_LE4PB
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_04,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=564 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previously discussed here:
https://lore.kernel.org/20220207102454.41b1d6b5@gandalf.local.home

- Naveen


Naveen N. Rao (3):
  powerpc/ftrace: Reserve instructions from function entry for ftrace
  bpf/trampoline: Allow ftrace location to differ from trampoline attach
    address
  kprobes: Allow probing on any address belonging to ftrace

 arch/powerpc/include/asm/ftrace.h  |  15 ++++
 arch/powerpc/kernel/trace/ftrace.c | 110 ++++++++++++++++++++++++++---
 kernel/bpf/trampoline.c            |   2 -
 kernel/kprobes.c                   |  12 ++++
 kernel/trace/ftrace.c              |   2 +
 5 files changed, 129 insertions(+), 12 deletions(-)


base-commit: 1b43a74f255c5c00db25a5fedfd75ca0dc029022
-- 
2.35.1

