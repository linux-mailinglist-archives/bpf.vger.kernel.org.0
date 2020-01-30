Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0224614D517
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2020 03:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgA3CJl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jan 2020 21:09:41 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60082 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726632AbgA3CJl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 Jan 2020 21:09:41 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00U25Rrr026709
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2020 18:09:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Wve3vdg/Xj7dM3IcXA1CuHaJmAn1D0qlflZfMFTggbg=;
 b=AltwyslTL6YrbtM4Ja2Z7OmB/uPDsaf1V5n5ZSDxAE+WUHTO08KpOqOhhEFp3BwNteLs
 rocBRucYJ2T3Ozg1yF6uXwa2+AD/4aA7BvplLA+JPAHqp2YjidLBBUP5HVHLIHuy9P9v
 WYSbrkp4XaWa1mbM+SSYH3U2NbAmE0rD/O8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xufqk9ryq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2020 18:09:40 -0800
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 29 Jan 2020 18:09:38 -0800
Received: by devvm4065.prn2.facebook.com (Postfix, from userid 125878)
        id 35FAA435722AB; Wed, 29 Jan 2020 18:09:32 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Yulia Kartseva <hex@fb.com>
Smtp-Origin-Hostname: devvm4065.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <hex@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <netdev@vger.kernel.org>
CC:     <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf 0/1] runqslower: fix Makefile
Date:   Wed, 29 Jan 2020 18:09:05 -0800
Message-ID: <cover.1580348836.git.hex@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-29_08:2020-01-28,2020-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 mlxlogscore=896 suspectscore=8 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001300012
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Julia Kartseva <hex@fb.com>

Fix undefined reference linker errors when building runqslower with
gcc 7.4.0 on Ubuntu 18.04.
The issue is with misplaced -lelf, -lz options in Makefile:
$(Q)$(CC) $(CFLAGS) -lelf -lz $^ -o $@

-lelf, -lz options should follow the list of target dependencies:
$(Q)$(CC) $(CFLAGS) $^ -lelf -lz -o $@
or after substitution
cc -g -Wall runqslower.o libbpf.a -lelf -lz -o runqslower

The current order of gcc params causes failure in libelf symbols resolution,
e.g. undefined reference to `elf_memory'

Julia Kartseva (1):
  runqslower: fix Makefile

 tools/bpf/runqslower/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.17.1

