Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75722350CD6
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 04:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhDAC6x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 22:58:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27444 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233151AbhDAC6U (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 31 Mar 2021 22:58:20 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1312tV07002149
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 19:58:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=xeNlapM7v0P/FnP6aguTk3EKSxjBNDF0uVO+jYloMP4=;
 b=WVQw602gmMumG3fheHUZRXz9YspgyTJPehaqQRg71yMI08K8OJqa9v9cMbO0rMQvIBol
 yEq3iNwpbGKJePj6xNgPLqJhiLhwFX2ozvf4cq3BUAWyuVlmYuwO4IqBEguPabzxb6Z7
 7sottN7qAqrjNr79YQyhu1DODLOnAsyaqaU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37n28y0wde-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 19:58:20 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 19:58:17 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 1327CEB9B4C; Wed, 31 Mar 2021 19:58:15 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?UTF-8?q?F=C4=81ng-ru=C3=AC=20S=C3=B2ng?= <maskray@google.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH dwarves 0/2] dwarf_loader: improve cus__merging_cu()
Date:   Wed, 31 Mar 2021 19:58:15 -0700
Message-ID: <20210401025815.2254256-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 11EO-f24CeVE_Apl4P12By4o3aMr9KD5
X-Proofpoint-ORIG-GUID: 11EO-f24CeVE_Apl4P12By4o3aMr9KD5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_11:2021-03-31,2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=561
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010020
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Function cus__merging_cu() is introduced in Commit 39227909db3c
("dwarf_loader: Permit merging all DWARF CU's for clang LTO built
binary") to test whether cross-cu references may happen.
The original implementation anticipates compilation flags
in dwarf, but later some concerns about binary size surfaced
and the decision is to scan .debug_abbrev as a faster way
to check cross-cu references. Also putting a note in vmlinux
to indicate whether lto is enabled for built or not can
provide a much faster way.

This patch set implemented this two approaches, first
checking the note (in Patch #2), if not found, then
check .debug_abbrev (in Patch #1).

Yonghong Song (2):
  dwarf_loader: check .debug_abbrev for cross-cu references
  dwarf_loader: check .notes section for lto build info

 dwarf_loader.c | 76 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 21 deletions(-)

--=20
2.30.2

