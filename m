Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27CB31806E8
	for <lists+bpf@lfdr.de>; Tue, 10 Mar 2020 19:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgCJSgq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Mar 2020 14:36:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54502 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726426AbgCJSgq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 10 Mar 2020 14:36:46 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 02AIWdse017218
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2020 11:36:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=CghPHU0EWW/X1MFI/B2AHyo+oWelZVD3Y8Uuidhhfps=;
 b=dEpaDcHQBzF7xNhbg5UKDzy8afdJycgWkCngDIbp4DudmE7IFFv4Sjca9OUyFYi8Vv1l
 oo7HdOuDjn0xP136sJLn4QmmEwxeG41+euRY5SNw52XZ9ruo1kqz/dihtg6jHeBMvMmS
 cOZOaD6rIrA54fPuZNoFtQ+8BgRTFMnp9dI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2yp6uw3285-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2020 11:36:45 -0700
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 10 Mar 2020 11:36:29 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id BF5A262E28D2; Tue, 10 Mar 2020 11:36:25 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <quentin@isovalent.com>, <kernel-team@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <arnaldo.melo@gmail.com>,
        <jolsa@kernel.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/2] Fixes for bpftool-prog-profile
Date:   Tue, 10 Mar 2020 11:36:21 -0700
Message-ID: <20200310183624.441788-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-10_12:2020-03-10,2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 mlxlogscore=722 bulkscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2003100110
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

1. Fix build for older clang;
2. Fix skeleton's dependency on libbpf.

Song Liu (2):
  bpftool: only build bpftool-prog-profile with clang >= v11
  bpftool: skeleton should depend on libbpf

 tools/bpf/bpftool/Makefile | 15 ++++++++++++---
 tools/bpf/bpftool/prog.c   |  2 ++
 2 files changed, 14 insertions(+), 3 deletions(-)

--
2.17.1
