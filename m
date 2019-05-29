Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 462F92D31E
	for <lists+bpf@lfdr.de>; Wed, 29 May 2019 03:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfE2BOg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 May 2019 21:14:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32778 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725936AbfE2BOg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 May 2019 21:14:36 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T19E3Q014422
        for <bpf@vger.kernel.org>; Tue, 28 May 2019 18:14:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=vQo30FB4087B60G3Mv8+/295sxgMwrBVL2FIrouroUQ=;
 b=Ou8RHTw+BWcUmeIP4ctUi1bJb/GEem5iriBdBfONSldsy+sg0pV8huetSTAmlmGNLZGJ
 3OG0fjbdxlhNbTiO8HZ+iYYfGiJRp2aCVg2WVhRnu64eitvClUmFJLx1fHy8Do+TJnnM
 p4VznwIxxPRfScCFdBvC/nYq8621F2TzDtY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2ss90chjxw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 May 2019 18:14:35 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 28 May 2019 18:14:31 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id DBDBC8617AA; Tue, 28 May 2019 18:14:28 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <ast@fb.com>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 0/9] libbpf random fixes
Date:   Tue, 28 May 2019 18:14:17 -0700
Message-ID: <20190529011426.1328736-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905290006
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set is a collection of unrelated fixes for libbpf.

Patch #1 fixes detection of corrupted BPF section w/ instructions.
Patch #2 fixes possible errno clobbering.
Patch #3 simplifies endianness check and brings it in line with few other
similar checks in libbpf.
Patch #4 adds check for failed map name retrieval from ELF symbol name.
Patch #5 fixes return error code to be negative.
Patch #6 fixes using valid fd (0) as a marker of missing associated BTF.
Patch #7 removes redundant logic in two places.
Patch #8 fixes typos in comments and debug output, and fixes formatting.
Patch #9 unwraps a bunch of multi-line statements and comments.

If patches #8 and #9 create too much history noise, I can drop them, they
don't have functional changes.

Andrii Nakryiko (9):
  libbpf: fix detection of corrupted BPF instructions section
  libbpf: preserve errno before calling into user callback
  libbpf: simplify endianness check
  libbpf: check map name retrieved from ELF
  libbpf: fix error code returned on corrupted ELF
  libbpf: use negative fd to specify missing BTF
  libbpf: simplify two pieces of logic
  libbpf: typo and formatting fixes
  libbpf: reduce unnecessary line wrapping

 tools/lib/bpf/libbpf.c | 148 +++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 88 deletions(-)

-- 
2.17.1

