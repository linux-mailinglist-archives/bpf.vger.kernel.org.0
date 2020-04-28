Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC041BB5FA
	for <lists+bpf@lfdr.de>; Tue, 28 Apr 2020 07:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgD1FuB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 01:50:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43676 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725792AbgD1FuB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Apr 2020 01:50:01 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03S5emA8023538
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2020 22:50:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=cDS1ketFLwmw3AN/hdnufJSymWBrPpxMQkbn4xllyCg=;
 b=YEKQ13aKphdjkaDqDoE9OWA7JVvzmUbHj8CNo9UIQ174A5ptGBuIIYmuOLUapodozaXP
 x27+7m6hr/ZwpJghY5vxCwb/9XCcEb+gh+aPyg4Evj3T9kCK0Y7H/+YWP7ohgHuZnYPF
 uj0rRJSCzMeSmL0r8+X0scnRLUbESF6FJ+E= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30n57q4ubu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2020 22:50:00 -0700
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 27 Apr 2020 22:49:59 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id E73EE2EC3228; Mon, 27 Apr 2020 22:49:54 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 03/10] bpf: support GET_FD_BY_ID and GET_NEXT_ID for bpf_link
Date:   Mon, 27 Apr 2020 22:49:37 -0700
Message-ID: <20200428054944.4015462-4-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428054944.4015462-1-andriin@fb.com>
References: <20200428054944.4015462-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_02:2020-04-27,2020-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=8
 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004280048
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support to look up bpf_link by ID and iterate over all existing bpf_l=
inks
in the system. GET_FD_BY_ID code handles not-yet-ready bpf_link by checki=
ng
that its ID hasn't been set to non-zero value yet. Setting bpf_link's ID =
is
done as the very last step in finalizing bpf_link, together with installi=
ng
FD. This approach allows users of bpf_link in kernel code to not worry ab=
out
races between user-space and kernel code that hasn't finished attaching a=
nd
initializing bpf_link.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 include/uapi/linux/bpf.h |  2 ++
 kernel/bpf/syscall.c     | 49 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6121aa487465..7e6541fceade 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -113,6 +113,8 @@ enum bpf_cmd {
 	BPF_MAP_DELETE_BATCH,
 	BPF_LINK_CREATE,
 	BPF_LINK_UPDATE,
+	BPF_LINK_GET_FD_BY_ID,
+	BPF_LINK_GET_NEXT_ID,
 };
=20
 enum bpf_map_type {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 659fe3589446..f296c15b8b3e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3713,6 +3713,48 @@ static int link_update(union bpf_attr *attr)
 	return ret;
 }
=20
+static int bpf_link_inc_not_zero(struct bpf_link *link)
+{
+	return atomic64_fetch_add_unless(&link->refcnt, 1, 0) ? 0 : -ENOENT;
+}
+
+#define BPF_LINK_GET_FD_BY_ID_LAST_FIELD link_id
+
+static int bpf_link_get_fd_by_id(const union bpf_attr *attr)
+{
+	struct bpf_link *link;
+	u32 id =3D attr->link_id;
+	int fd, err;
+
+	if (CHECK_ATTR(BPF_LINK_GET_FD_BY_ID))
+		return -EINVAL;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	spin_lock_bh(&link_idr_lock);
+	link =3D idr_find(&link_idr, id);
+	/* before link is "settled", ID is 0, pretend it doesn't exist yet */
+	if (link) {
+		if (link->id)
+			err =3D bpf_link_inc_not_zero(link);
+		else
+			err =3D -EAGAIN;
+	} else {
+		err =3D -ENOENT;
+	}
+	spin_unlock_bh(&link_idr_lock);
+
+	if (err)
+		return err;
+
+	fd =3D bpf_link_new_fd(link);
+	if (fd < 0)
+		bpf_link_put(link);
+
+	return fd;
+}
+
 SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned =
int, size)
 {
 	union bpf_attr attr;
@@ -3830,6 +3872,13 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __us=
er *, uattr, unsigned int, siz
 	case BPF_LINK_UPDATE:
 		err =3D link_update(&attr);
 		break;
+	case BPF_LINK_GET_FD_BY_ID:
+		err =3D bpf_link_get_fd_by_id(&attr);
+		break;
+	case BPF_LINK_GET_NEXT_ID:
+		err =3D bpf_obj_get_next_id(&attr, uattr,
+					  &link_idr, &link_idr_lock);
+		break;
 	default:
 		err =3D -EINVAL;
 		break;
--=20
2.24.1

