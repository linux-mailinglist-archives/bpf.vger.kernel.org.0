Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6588C580AB5
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 07:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiGZFRx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 01:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiGZFRw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 01:17:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4962222B8
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 22:17:51 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26Q0rTJ5004103
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 22:17:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=3iKXab+m/X3iJD3v2CiOO2xTU9uF6ajaJLFLlumTScc=;
 b=i1GTQumDDoeWVJoqxbrHUH+lFv9Dutb2E88J/Ak4YFGW42dSN59bzaNv61Aljw9lwUHy
 COYJOBTAYW1L+iP/ZIcAAQIZFdtCzHh9MM9z4SW9tLT46CFdqdAZnjassQCZcXoHW3CW
 UCaNXjUOWhP1mygdtqXLcuNIPTBzDituN6M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hge3qp97k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 22:17:51 -0700
Received: from twshared30313.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 22:17:50 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 18FEA5E528A9; Mon, 25 Jul 2022 22:17:42 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next 0/3] Parameterize task iterators.
Date:   Mon, 25 Jul 2022 22:17:10 -0700
Message-ID: <20220726051713.840431-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: r_6DdA-dWK1zXOfi2Md-JQLVtEvFEExh
X-Proofpoint-ORIG-GUID: r_6DdA-dWK1zXOfi2Md-JQLVtEvFEExh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_13,2022-07-25_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow creating an iterator that loops through resources of one task/threa=
d.

People could only create iterators to loop through all resources of
files, vma, and tasks in the system, even though they were interested in =
only the
resources of a specific task or process.  Passing the addintional
parameters, people can now create an iterator to go through all
resources or only the resources of a task.

Major Changes:

 - Add new parameters in bpf_iter_link_info to indicate to go through
   all tasks or to go through a specific task.

 - Change the implementations of BPF iterators of vma, files, and
   tasks to allow going through only the resources of a specific task.

 - Provide the arguments of parameterized task iterators in
   bpf_link_info.

Kui-Feng Lee (3):
  bpf: Parameterize task iterators.
  bpf: Handle bpf_link_info for the parameterized task BPF iterators.
  selftests/bpf: Test parameterized task BPF iterators.

 include/linux/bpf.h                           |   4 +
 include/uapi/linux/bpf.h                      |  27 ++++
 kernel/bpf/task_iter.c                        |  91 +++++++++---
 tools/include/uapi/linux/bpf.h                |  27 ++++
 .../selftests/bpf/prog_tests/bpf_iter.c       | 131 +++++++++++++++---
 .../selftests/bpf/prog_tests/btf_dump.c       |   2 +-
 .../selftests/bpf/progs/bpf_iter_task.c       |   9 ++
 .../selftests/bpf/progs/bpf_iter_task_file.c  |   7 +
 .../selftests/bpf/progs/bpf_iter_task_vma.c   |   6 +-
 9 files changed, 258 insertions(+), 46 deletions(-)

--=20
2.30.2

