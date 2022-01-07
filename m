Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2132487C51
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 19:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiAGSqM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 13:46:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19810 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229984AbiAGSqM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 7 Jan 2022 13:46:12 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 207CSajZ017356
        for <bpf@vger.kernel.org>; Fri, 7 Jan 2022 10:46:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=3g5f7vrbyhAyjAXzv1QRxgJgBhJq+pcmnuVyp/3wv1A=;
 b=HFAe25vCAnSuJodbwVKpf9/UFNF+KCOVGHypCyXFSBXarXFlVZvHA2KK8aZndlsusxON
 bWf9vatoxz9XjQVo3RR7DRm6Oc0lCleh6D73eEnJHLOo5CBTIDnWeOFCrXQlLl2u6NU0
 uyteDQ2yz4sRj8pnJ0Wu8HGAu0A5v8O34m4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3denj32cdb-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 10:46:11 -0800
Received: from twshared5363.25.prn2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 10:46:09 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id C0AF21662904; Fri,  7 Jan 2022 10:46:05 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>
CC:     <christylee@fb.com>, <christyc.y.lee@gmail.com>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 0/2] libbpf: rename bpf_prog_attach_xattr to bpf_prog_attach_opts
Date:   Fri, 7 Jan 2022 10:46:02 -0800
Message-ID: <20220107184604.3668544-1-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: aJJDXYAm2Mt9VkaZ5X5wfL3Dh3wmsK8z
X-Proofpoint-ORIG-GUID: aJJDXYAm2Mt9VkaZ5X5wfL3Dh3wmsK8z
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-07_08,2022-01-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=946 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201070118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

All xattr APIs are being dropped, mark bpf_prog_attach_opts() as deprecated
and rename to bpf_prog_attach_xattr(). Replace all usages of the deprecated
function with the new function name.

  [0] Closes: https://github.com/libbpf/libbpf/issues/285

Changelog:
----------
v2 -> v3:
https://lore.kernel.org/all/20220106234639.1418484-2-christylee@fb.com/

* Fixed build break

v1 -> v2:
https://lore.kernel.org/all/20211230000110.1068538-1-christylee@fb.com/

* Used alias instead of returning original function
* Split out selftests to a different commit

Christy Lee (2):
  libbpf: rename bpf_prog_attach_xattr() to bpf_prog_attach_opts()
  selftests/bpf: change bpf_prog_attach_xattr() to
    bpf_prog_attach_opts()

 tools/lib/bpf/bpf.c                                  |  9 +++++++--
 tools/lib/bpf/bpf.h                                  |  4 ++++
 tools/lib/bpf/libbpf.map                             |  1 +
 .../selftests/bpf/prog_tests/cgroup_attach_multi.c   | 12 ++++++------
 4 files changed, 18 insertions(+), 8 deletions(-)

--
2.30.2
