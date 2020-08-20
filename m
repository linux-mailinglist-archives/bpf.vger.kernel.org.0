Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9680224ABE4
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 02:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgHTAOL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 20:14:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15860 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726841AbgHTAN3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Aug 2020 20:13:29 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 07K0AYIe018193
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 17:13:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=zEf3czixZcMWyNQbFcY66yuu9ivUqSRPkOj+BJh3UFc=;
 b=G0ioPFLgHOMKaYWW3WoDAIoZ50vMc3oC2aDhiJ5G1JHNCuZel1Kw0qU6xl5sU4g99qW/
 iLgziG+3B8Oa751sVkGXpEbO8K5d+lV/rYTsRwdaEVyJ/292L5v/o+OWN+30BExqnbCA
 cfAwPbbPSgGVlq+h7kwcxXGBzu7WOM0ZKEM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3304jqbcwt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 17:13:26 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 19 Aug 2020 17:13:24 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 4A1B437053B6; Wed, 19 Aug 2020 17:13:23 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 0/3] bpf: implement link_query for bpf iterators
Date:   Wed, 19 Aug 2020 17:13:23 -0700
Message-ID: <20200820001323.3740798-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_13:2020-08-19,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=664
 clxscore=1015 malwarescore=0 suspectscore=8 phishscore=0 spamscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190193
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"link" has been an important concept for bpf ecosystem to connect
bpf program with other properties. Currently, the information related
information can be queried from userspace through bpf command
BPF_LINK_GET_NEXT_ID, BPF_LINK_GET_FD_BY_ID and BPF_OBJ_GET_INFO_BY_FD.
The information is also available by "cating" /proc/<pid>/fdinfo/<link_fd=
>.
Raw_tracepoint, tracing, cgroup, netns and xdp links are already
supported in the kernel and bpftool.

This patch added support for bpf iterator. Patch #1 added generic support
for link querying interface. Patch #2 implemented callback functions
for map element bpf iterators. Patch #3 added bpftool support.

Yonghong Song (3):
  bpf: implement link_query for bpf iterators
  bpf: implement link_query callbacks in map element iterators
  bpftool: implement link_query for bpf iterators

 include/linux/bpf.h            | 10 ++++++
 include/uapi/linux/bpf.h       |  7 ++++
 kernel/bpf/bpf_iter.c          | 58 ++++++++++++++++++++++++++++++++++
 kernel/bpf/map_iter.c          | 15 +++++++++
 net/core/bpf_sk_storage.c      |  2 ++
 tools/bpf/bpftool/link.c       | 44 ++++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h |  7 ++++
 7 files changed, 140 insertions(+), 3 deletions(-)

--=20
2.24.1

