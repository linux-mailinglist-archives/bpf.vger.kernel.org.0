Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650601BB650
	for <lists+bpf@lfdr.de>; Tue, 28 Apr 2020 08:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgD1GNx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 02:13:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19814 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726210AbgD1GNx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Apr 2020 02:13:53 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 03S681WT008267;
        Mon, 27 Apr 2020 23:13:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=6FlGPnsmU2z4WDq0f1++d12iZsjFc9dU6Gh0ENBgeLQ=;
 b=HDkYC1Z8z4MNiJaeSD+rbXIMM1oOpAZ2IQ2ZJ4OAYKnPGfrL9UGr54CGCEr0f038M73H
 ngSHMaDbHfINAXlS3qDGrlRMDhr+HjyOfIe9ku2aEq+4m22mo/GlG2q8fqiggXlQUvXK
 f+khU3U0lyw2P7067sTBouib6tkZZ9YL7+U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 30mgvnh5d0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Apr 2020 23:13:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 27 Apr 2020 23:13:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFgHrFxhxLLa82sJ+5wxWZx4L+UC/kulSNesW1P1Tj7lSJBtHO+0Xh5MfXmA/5Aj8Ud2fIc+RHS0PXikJ93Ov0HRZ5qzDYUNLWaWWzXh8nXOXSG1yoUJGpUXPVPTdbDsYlSMML0u9sZN5Hi4rD90dlOXujM9Cbc6FdkvPJkEUE6HCGI9yKjDd5H0i8OlZJUwZMcXtjBztEm3uD2n+XJX2VWQ7tBKuByt9iklNanLoPxFYc4aSh33w1VhT47TEvVo1M1yx+iP84UvqVHv77i1Qf6pHuefyxxMa7/2FMQgYlS7yEPhNG6SFJkhsg/F1VyC4KuhmugFKAmhaa2K0kRKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FlGPnsmU2z4WDq0f1++d12iZsjFc9dU6Gh0ENBgeLQ=;
 b=YTH/ikWxtGgzCec4gWNfqvJoiZMh0+rHdLFQa1XwVz/V4xNzK8lxeOgdOSYckfk6mB61H9ZO46hMw/88LGePjBFgRjKSZCwN2jAvzuGC9H1bTm7fK+C8VDex3TbBurZ6bySqbVN+uXWsVTjkV8t+RR7a81TPB1XvzUsnSU1ZU1hw1oDFwl4UbogsPpQllq6Nd46rWZxrYf6Lgdd+btbCmsBlH0h17pFvUoANRYNjWPR0rEDS88381Y07UQVAQJQ+bhPZsoETmg9fa+64J9ux5ngbcfafleOKFVoCGL2fJck8ASzuuWd7JJZYBY7apmLmX15DyzwOkwBWIGV3nj8kyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FlGPnsmU2z4WDq0f1++d12iZsjFc9dU6Gh0ENBgeLQ=;
 b=cUGLaDgiyyIGrBHQNME9tHaYDz9k/LrNVE4RTkMTPgRs8TS0Cg66Sw3Pt4PyOQJfP4+c+6MJuRoD5yn5SIcBlgg0lPJniIKI7Gqjjps7E8l7xnrK/luqNs/j79BUr3tOilUJEqyiIOn0A2HaClGwDYesQoAj50QbF/eF+34Cizg=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3208.namprd15.prod.outlook.com (2603:10b6:a03:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 06:13:14 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8988:aa27:5d70:6923]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8988:aa27:5d70:6923%5]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 06:13:14 +0000
Subject: Re: [PATCH bpf-next v2] [tools/bpf] workaround a verifier failure for
 test_progs
To:     Ma Xinjian <max.xinjian@intel.com>, <ast@fb.com>,
        <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>
CC:     "Li, Philip" <philip.li@intel.com>
References: <4c14c01e-be39-817b-ca8c-200690ac4caf@intel.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <1b8051db-20af-73ab-179e-8818bee7c7ee@fb.com>
Date:   Mon, 27 Apr 2020 23:13:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
In-Reply-To: <4c14c01e-be39-817b-ca8c-200690ac4caf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0024.namprd16.prod.outlook.com (2603:10b6:907::37)
 To BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MacBook-Pro-52.local (2620:10d:c090:400::5:f088) by MW2PR16CA0024.namprd16.prod.outlook.com (2603:10b6:907::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 06:13:13 +0000
X-Originating-IP: [2620:10d:c090:400::5:f088]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d85a38f-1e31-426b-88be-08d7eb3b3c06
X-MS-TrafficTypeDiagnostic: BYAPR15MB3208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3208C7014C401274A77935A1D3AC0@BYAPR15MB3208.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(376002)(136003)(366004)(396003)(66476007)(66556008)(8936002)(6486002)(6506007)(52116002)(53546011)(31686004)(6636002)(186003)(66946007)(16526019)(31696002)(8676002)(2616005)(2906002)(4326008)(316002)(478600001)(966005)(86362001)(5660300002)(36756003)(81156014)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMI7n6aHEdejZvhE9KyG1Wk92wo5t0glFwtz36w7sC2s9uiO6rQqbchuXe6biBbbk2yfgLFn2HXoH39H6Mq6PeWIqZlG3geFAZcc+sZMyzuVao5+mgsLmurUBk9I0KPpCMaqUrmpSj5GfJDFo3Fz8p7w6qSWGfh/nf5Psw8cK/R2XghxR2qAis3wlOps81wJ6uWPc9+87XCUT/0F6EtP/6cnV2rGdrd5G9CGbCAbs9VFJ3oTetTQA+C7AUSbv6G3zL9zRVJaZ9Gl/EI5N9b/j8BmftbPFibkflcKaBdxYY5UTt1gy32dR12PuCUHXP56aAtsqhycthv4CxrXS3HC6sZMVDGxMtE5FJnhZVgLAyn2zieWUep4r8Jys2cY9WmBc9eGB3FODm2eXnY1G2N926JpMKdkxYZRmrITs5xLnKnOh8YM55CoMIGTIxwVKqvyOR8FJSCFm/G2Yoi3UdZz+AnlFYhnCNLOSSBMqm0c5ffuNuap7zAbwkTEjtR6f3UvD056aoubAcIE+JuJzTQcfg==
X-MS-Exchange-AntiSpam-MessageData: Ia99wWMzweoeYltw97MPGlCKJtYlwJcqbYH6ZifaBOkB41vq49BcKblwJB7nOCDotdeIFc8QFsqibm1zpsJxmlrwXNiUaGRYvy/y7w1VOiqd6qkPeP0Bd/zXD/ust2KTohFu0ZjvDpz2UfMvIDzP/FQ8yn6b28ccDdXmHDJiCw8cOlCanpWqZ5VLc2ZsI/1FHDEj6BX234ycHx0q8pBKAiA37Vt7WcbP/HyEcZoDCK8cCe2hsyqjWMcXip/dQ77GRUnZPGPsV21QRW7LDwhSjNKx55r1ksUY83UWFT83W1OUPX304xJVdiQUJsX65bwadIs6sD3fwIQAcZjyyt5jmVmmRXQKI0aBNxSJr1zlXP7/raVzp/WnHlNpSq4xALPmQ6c8zj30EVLdY4NpaqL1ZdwTWRyKYGGaN5yqeLkghqgWjQ9qgE8mIjZr5TNMv3JpI5BkVStAeR9SiCTKLKYKZSIzAYus8bMTrPuWzpSj1PFpx/qHfFca0Th5odrJTrblT9Z/084Mi8xI3mGolxZHIrHQM793l+YqRzMDHc78p61w9tPpL2FFl1z/hvwiQg7KkA0cY9fuJvEGa1I6C4Qo8gCUCMfrMtesEuPbc7TwXFpTEKG7vHjlCvrscLwitRZnaLN6+/Z9ZyPiiN9eFvcUsvyFKATZca//TH5ya47V4V1G3ZGNj4Lowfegj71QFkC7H/Ndv6tdnD32VzEAJwurtp5HVhug41Y8TQJTtH2EsBGdQvL7sD6CBbZj2nGzcsGta9PoIQZ/+fjSeSaZEkVrGVq2w+b1iNrdWXoCe6bdrVvWzWgyAQAARGhnrFHueieIaq4dNcN/dvSEcbcW+jbaNA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d85a38f-1e31-426b-88be-08d7eb3b3c06
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 06:13:14.0652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PsZETIqs6VJzcC7cJ78PQSs09cw4gNacDTs08LSMZfn8dG17R08qbo+c9Vq1+Y/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3208
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_02:2020-04-27,2020-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 clxscore=1011
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004280052
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/27/20 7:56 PM, Ma Xinjian wrote:
> Hi Yonghong.
> 
> During our team's test, we find a similar issue. when run test_sysctl of 
> bpf, we met error:
> 
> ```
> 
> libbpf: -- END LOG --
> libbpf: failed to load program 'cgroup/sysctl'
> libbpf: failed to load object './test_sysctl_prog.o'
> (test_sysctl.c:1490: errno: Permission denied) >>> Loading program 
> (./test_sysctl_prog.o) error.
> 
> ```
> 
> Testing env: "Debian GNU/Linux 9 (stretch)"
> 
> kernel: 5.6 5.7-rc1 5.7-rc2 5.7-rc3
> 
> clang/llvm version: v11.0.0.
> 
> we have tested a log of commits, following commits are part of them
> 
> drwxrwxr-x 2 root root  1 Apr 28 07:01 
> f30416fdde922eaa655934e050026930fefbd260
> drwxrwxr-x 2 root root  2 Apr 26 11:38 
> 10bc12588dac532fad044b2851dde8e7b9121e88
> drwxrwxr-x 2 root root  1 Apr 26 07:01 
> 969e7edd88ceb4791eb1cac22828290f0ae30b3d
> drwxrwxr-x 2 root root  1 Apr 23 13:51 
> bbf386f02b05db017fda66875cc5edef70779244
> drwxrwxr-x 2 root root  1 Apr 22 10:01 
> 2de52422acf04662b45599f77c14ce1b2cec2b81
> drwxrwxr-x 2 root root  1 Apr 21 07:07 
> a9b137f9ffba8cb25dfd7dd1fb613e8aac121b37
> drwxrwxr-x 2 root root  1 Apr 17 07:01 
> 40d139c620f83509fe18acbff5ec358298e99def
> 
> drwxrwxr-x 2 root root  1 Apr 16 07:02 
> bee6c234ed28ae7349cb83afa322dfd8394590ee
> 
> 
> And I have tested, If I add following patch like you did, test_sysctl pass:
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_prog.c 
> b/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
> index 2d0b0b82a78a..8e3da8d2e7c9 100644
> --- a/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
> +++ b/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
> @@ -45,7 +45,10 @@ int sysctl_tcp_mem(struct bpf_sysctl *ctx)
>          unsigned long tcp_mem[3] = {0, 0, 0};
>          char value[MAX_VALUE_STR_LEN];
>          unsigned char i, off = 0;
> -       int ret;
> +      /* a workaround to prevent compiler from generating
> +      * codes verifier cannot handle yet.
> +      */
> +      volatile int ret;
> 
>          if (ctx->write)
>                  return 0;

Right. This is related to alu32 mode. The detailed description
https://lore.kernel.org/bpf/20191107170045.2503480-1-yhs@fb.com/

We are still working on this, either a verifier solution or a compiler 
workaround.

> 
> root@vm-snb-15 
> /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-6a8b55ed4056ea5559ebe4f6a4b247f627870d4c/tools/testing/selftests/bpf# 
> ./test_sysctl
> 
> ...
> 
>   Summary: 40 PASSED, 0 FAILED
> 
