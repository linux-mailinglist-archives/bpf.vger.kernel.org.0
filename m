Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200CB1EE02B
	for <lists+bpf@lfdr.de>; Thu,  4 Jun 2020 10:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgFDIzF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Jun 2020 04:55:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56536 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgFDIzF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Jun 2020 04:55:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0548kV17025798;
        Thu, 4 Jun 2020 08:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=JIQfxmPvTFHHyVrHNeasOgcdmrQ+G3M5MRzkNLwrEqs=;
 b=B/THnTSpSZVKPVZDbzXqGZ0Ri2QVlJWQoLNZPv0GtT71G7zbbEfTU36kJn3SPksT2kR4
 ekv/gTdftG1l3HGtGr/M8GvbzSTyRepIouOeSoL4ud6RTmypOQ0hAhlWNsJncVOik5vJ
 SuPi/yMnHSGwqtPdOGwLuSajpcNAj4s1z5idXX5a27RBmj+RMOa6/Ab4m/0aMKSNlOzi
 ad4L48I0bQrHxLXavR2MM6lGBRzr8kNyON7Owlljav72yj9GjTpxQ9xgYmbolMm6LMJN
 WdRq5CbBg0pAKpDGgDJCxDQW8NNiMIPtmnzLeqMhOltX6HJL6n6yy7Vba7++cXiYa+3D 3Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31evap0hsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 04 Jun 2020 08:54:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0548m6sZ006063;
        Thu, 4 Jun 2020 08:54:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31dju4nure-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jun 2020 08:54:45 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0548si4v002251;
        Thu, 4 Jun 2020 08:54:44 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jun 2020 01:54:43 -0700
Date:   Thu, 4 Jun 2020 11:54:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2 bpf-next] bpf: Fix an error code in check_btf_func()
Message-ID: <20200604085436.GA943001@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJPwtan12Htu-0VhvuC3M-o_kbnPpN=SXVC-amn9BcZCw@mail.gmail.com>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006040059
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006040059
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This code returns success if the "info_aux" allocation fails but it
should return -ENOMEM.

Fixes: 8c1b6e69dcc1 ("bpf: Compare BTF types of functions arguments with actual types")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: style change

 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5c7bbaac81ef9..34cde841ab681 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7552,7 +7552,7 @@ static int check_btf_func(struct bpf_verifier_env *env,
 	const struct btf *btf;
 	void __user *urecord;
 	u32 prev_offset = 0;
-	int ret = 0;
+	int ret = -ENOMEM;
 
 	nfuncs = attr->func_info_cnt;
 	if (!nfuncs)
-- 
2.26.2

