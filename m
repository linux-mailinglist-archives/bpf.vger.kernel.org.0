Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2761222B568
	for <lists+bpf@lfdr.de>; Thu, 23 Jul 2020 20:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgGWSJ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 14:09:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16466 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726304AbgGWSJ4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jul 2020 14:09:56 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NHrfdF021948
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 11:09:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=OSYQXum1ZUSOus2pzbijxGAz08dWSHRpUo7YeYxklVA=;
 b=RwS3AWQXEJlHx2XI9jFPh1C6P4Hwbm6u1YU+MSDU7J9FCmzM49Cd119lj2LI7IB9UxDa
 IICvdJvrmfc/hx9Uo+BFChHSVPX+xid6vJgDcKEHVdrcyDMeGNCn2ynoUCfb9tClHk0h
 jWQ3NVOVUs5UNNa9r8HdDY90Gp8JAxzWZF8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32et5kwmwy-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 11:09:55 -0700
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 11:09:54 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 765E962E5064; Thu, 23 Jul 2020 11:07:00 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <brouer@redhat.com>, <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v5 bpf-next 3/5] libbpf: print hint when PERF_EVENT_IOC_SET_BPF returns -EPROTO
Date:   Thu, 23 Jul 2020 11:06:46 -0700
Message-ID: <20200723180648.1429892-4-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200723180648.1429892-1-songliubraving@fb.com>
References: <20200723180648.1429892-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_09:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007230132
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The kernel prevents potential unwinder warnings and crashes by blocking
BPF program with bpf_get_[stack|stackid] on perf_event without
PERF_SAMPLE_CALLCHAIN, or with exclude_callchain_[kernel|user]. Print a
hint message in libbpf to help the user debug such issues.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/lib/bpf/libbpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 846164c79df1c..484e50d49a4cf 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7833,6 +7833,9 @@ struct bpf_link *bpf_program__attach_perf_event(str=
uct bpf_program *prog,
 		pr_warn("program '%s': failed to attach to pfd %d: %s\n",
 			bpf_program__title(prog, false), pfd,
 			   libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+		if (err =3D=3D -EPROTO)
+			pr_warn("program '%s': try add PERF_SAMPLE_CALLCHAIN to or remove exc=
lude_callchain_[kernel|user] from pfd %d\n",
+				bpf_program__title(prog, false), pfd);
 		return ERR_PTR(err);
 	}
 	if (ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
--=20
2.24.1

