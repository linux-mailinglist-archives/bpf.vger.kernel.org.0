Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9C424C710
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 23:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgHTVQP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 17:16:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17214 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbgHTVQO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Aug 2020 17:16:14 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07KLAZ6k003481;
        Thu, 20 Aug 2020 14:15:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=lLH6giOJJVaw6tqoYjABFC8a5CCbPGoAibl5O5uo3ZY=;
 b=Supu6rh87yvAeId3bfDfLolO0TjItIWYXWV70Dt8L5CFw6Z3FwOhpHo+OrMGS6DA8FBB
 wEyAVIb6tX5BPtVktShFCda9ztbjEfbsL4Yo47JIS2bmzlbygxnTcTuXBGMlInM2DnUo
 oMEzDkbpvtdy9E73JswHUb7Q7xIwUSTGLDI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 331d50nn20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 20 Aug 2020 14:15:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 20 Aug 2020 14:15:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHN6L5f3OFJYsCELBFgpmi+63H7FkxYwBS47loyKNoXuqgG/q6FF0qzjqoVooVW9IMkAPA991+m/tnTBOe6dhDJ+SFBtwEffRNwx8rnB6Tj+Gb7F30w/MBC4XTjL1lYBvYTAxEf+VN+Y4T2Hv9SMPG+oA1Xshux4l6a3lbrbX2tXWlFjrChGvji8sZGt0+Io/Pp1MtuBOnbaqgO8h0IX0kfH0ZNE3qFKJHscR8QJ1vtTA8Uqtll1FcN+jgLsLQ6uJVHPFzOq2pu4Z92UckqH5wx0z3LM+wZh56DoDy5ojdJJ9ys1YvQO0AiENvVaAJwyuWdyDPbmskJL7Bjvr0oWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLH6giOJJVaw6tqoYjABFC8a5CCbPGoAibl5O5uo3ZY=;
 b=EYJdtQWTQGBM8XYoZYSgouRTsFFsDTy5cczBrb6J7McxqB5+pkOs5diwI+QSrNF35TxjEcRYse6rNAGjpVKqsSIht+pGR8t/Gx/Kr02aG6jHXdLk8x4qa1+LBgC3i3ixWCzp0SdDdZP56jx2aD+UbJfAqKIaRNy9ztmRsrQomebjEWMK+h5QhOeZpyO3gAXWe5fQ9pPCpRztgWFB5A7nKejvlschYGuoiYr8qfwu2PJKkgtdeGRh5Dcb8mAe0xEFCmkSGbxdkxQfUzYZ17Aoq5zQTu5puITcVIBNaXSTUWJX/KJEeh1dYjWKZ+4DpKP3l0r9gQKoSy5c1XdyVe82Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLH6giOJJVaw6tqoYjABFC8a5CCbPGoAibl5O5uo3ZY=;
 b=k6aRrbnliwZRTrkq4WnCy25Kd2x33mrj11FptcxxGyv2c/o6PFgzoVB8rAD44fZVwcRZGbuvOJwr9BNV5wMpRhTu9BDPS6dKWn8VbGuRD6bbIOiiNdIM1s14kyfGHKIlVt/Bdb0sFHM3iKPKBO7/SVxeFrlGQbGW2lVfZuFWqLk=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3414.namprd15.prod.outlook.com (2603:10b6:a03:10f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 21:15:56 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3305.026; Thu, 20 Aug 2020
 21:15:56 +0000
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: Test bpftool loading and
 dumping metadata
To:     YiFei Zhu <zhuyifei1999@gmail.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
References: <cover.1597915265.git.zhuyifei@google.com>
 <788b0e49bd5dfc292b71a57f21cbf010821a0aca.1597915265.git.zhuyifei@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <e0946350-9829-09b3-0a60-4b45ed918d93@fb.com>
Date:   Thu, 20 Aug 2020 14:15:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
In-Reply-To: <788b0e49bd5dfc292b71a57f21cbf010821a0aca.1597915265.git.zhuyifei@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0002.namprd16.prod.outlook.com
 (2603:10b6:208:134::15) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:208:134::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 21:15:54 +0000
X-Originating-IP: [2620:10d:c091:480::1:7a86]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15809ee7-76da-40a3-1195-08d8454e3a14
X-MS-TrafficTypeDiagnostic: BYAPR15MB3414:
X-Microsoft-Antispam-PRVS: <BYAPR15MB341410DF9C99C4080659A65ED35A0@BYAPR15MB3414.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mRBax6swqq6gzJVpwYItfzVpAuTrrv+uO3j/a2dfBIw/ejZ8w7LAX7hLq8cGiY/qOMTDaRFWCJ2e7YNYiXyhiySmSYp2GjLlmMt3LwQ/FN3MGdQcz8mBguFOCuxzIQBIegVd19tU/hZT6B3pefh1KY8wO1gZq/gkE04yRwEmGKGQPCPp0hKxEhGowciX3wdWPaT/V2+eKqZNBgz04Wf1jaAJnZEjCaYqvxfP5IGU1eA6oslq/JxtPYT4eAE9Ci4xFnmHFs1rpK17corpsBHIYU8j8VWkEx9VYPNFIWTYRcfEWQsxSzv5ugYJvx7telZvQabWHQf3wGKscYnGUkdbV5OReNJIPNsxwSKZuzmkvHnhfkviemS85AGf3zZbug5Js2vnTkeNEdH4uZPDYddd8hUm3/uX4ATsa2sWa0j+H3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(39860400002)(346002)(376002)(8936002)(66946007)(53546011)(6486002)(110011004)(478600001)(66556008)(31686004)(31696002)(2616005)(66476007)(52116002)(36756003)(4326008)(86362001)(5660300002)(956004)(16576012)(316002)(186003)(2906002)(8676002)(83380400001)(54906003)(6666004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: OepqM+B8c62FQwKZln638ipuk++Iv6APWeXACaDD/o2vg0FsOI6ASUWSkf/0qbvmLcSLI9T6vXIWeDxsBDt16wGqVz6x+Mj8tbG3QxM2dPqxcW5tPkwCoYk13xrL/bgweJb3PeK6N4AsQr2+Aewnol8K4t3JZtNPX4qRJeOHXMsjaPpyGHNo2FHoAFzYJ853Jo4z0I5H8UXldveNdcp5gkGRi2kSmQ/CClMiXrH0OBH5kJSSAtMybJ5ZgdTEZgz0DjzV7gQ/A/P7GPNEKpd7FxD2dfoAacPiEsj11Yp6qgc4NwpYrhCHHZo9x2U7Hj8bqxb//VOLMbBnPt4wykKF0zw+EvGKKL7ra9KLOm30OPeKBxjsVtA4efoT50SeIPM/6+7RejWsi0pOaKw5+M+BtqmPc50/5qK4GUfvCt9IFLPBVVTwwcPJlzpDWSChJO37V+FsZ9xTZw7dxlE4M6ifgBLgWwoh+2YmVdN2Ybujvli3Nc+zo9QM1tv3PujHa675Kq3qt3NnRZPhUev0sLAd11q4gq8vCFaoZKSRays0s/1Ql631ZSCk5oEutlTe0drj8sO8VwJjk2cK/i+5AF5jVZ6WOrdfY2Awll8fFAnuo7Cw+Zm/ARacpUAmtpogZwSThguDkzqXiA+V5oKr9ot3hFbILohR8Y0wG/Hw0b07Ixay3ciii/P2cAUZLSk2wY2L
X-MS-Exchange-CrossTenant-Network-Message-Id: 15809ee7-76da-40a3-1195-08d8454e3a14
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 21:15:55.9533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +80o22b2cRa1+rPheHS3lJ8pDIKSm1JWCpp+7OgbVsJIAQh5qmWoot2wui4+VssB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3414
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-20_07:2020-08-19,2020-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008200172
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/20/20 2:42 AM, YiFei Zhu wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> This is a simple test to check that loading and dumping metadata
> works, whether or not metadata contents are used by the program.
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> ---
>   tools/testing/selftests/bpf/Makefile          |  3 +-
>   .../selftests/bpf/progs/metadata_unused.c     | 15 ++++
>   .../selftests/bpf/progs/metadata_used.c       | 15 ++++
>   .../selftests/bpf/test_bpftool_metadata.sh    | 82 +++++++++++++++++++
>   4 files changed, 114 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/metadata_unused.c
>   create mode 100644 tools/testing/selftests/bpf/progs/metadata_used.c
>   create mode 100755 tools/testing/selftests/bpf/test_bpftool_metadata.sh
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index a83b5827532f..04e56c6843c6 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -68,7 +68,8 @@ TEST_PROGS := test_kmod.sh \
>   	test_tc_edt.sh \
>   	test_xdping.sh \
>   	test_bpftool_build.sh \
> -	test_bpftool.sh
> +	test_bpftool.sh \
> +	test_bpftool_metadata.sh \

This is mostly testing bpftool side.
We should add testing to test_progs too as it is what most developer 
runs. If you add skeleton support for metadata, similar to bss, it will
both make user interface easy and make testing easy.

>   
>   TEST_PROGS_EXTENDED := with_addr.sh \
>   	with_tunnels.sh \
> diff --git a/tools/testing/selftests/bpf/progs/metadata_unused.c b/tools/testing/selftests/bpf/progs/metadata_unused.c
> new file mode 100644
> index 000000000000..523b3c332426
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/metadata_unused.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +char metadata_a[] SEC(".metadata") = "foo";
> +int metadata_b SEC(".metadata") = 1;
> +
> +SEC("cgroup_skb/egress")
> +int prog(struct xdp_md *ctx)
> +{
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
[...]
