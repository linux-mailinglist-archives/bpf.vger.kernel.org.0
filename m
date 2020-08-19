Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA1B24A335
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 17:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgHSPgQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 11:36:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12170 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726809AbgHSPgP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Aug 2020 11:36:15 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07JFYIhG020498;
        Wed, 19 Aug 2020 08:36:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=pVu2cg6Ts7R/pv209NqUrBba2XB/BLipoPmNA63Aq2A=;
 b=UAcQB1EKyxElPy+bpr3r80Mn1tLiOIVEL555+U3Mc/E5bYVxcfwYNVBGcEMmcnUJcICJ
 yTGWpM9fxO7Z6R/KyqNxa7lbJo6dCKS6NIaPPu3mLkVhK4snMXGLInLGMEY+yKchJhQr
 PWvpg2hnu1zE/YTIUkZosKrDKAMNEevfpfc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3304nxs2e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 19 Aug 2020 08:36:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 19 Aug 2020 08:36:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZB2tFi1ui4V/E+ISlbkruHT9GPBmdLmPqRahdHXAUUvbg0oRl1lVpMRh50LiL2VW52IZ7qC5VY/1gXdmXjHnWdqjdL2cy62/EaMCIIK81pXUeeut6gu+qOdUR/epiwJskxi97bqHw/E9CgUPC4tl5m6SqhvFWHGs4VluLiSN/X+NlW2jEjvsgsSu8YYxEEARV9sLuxlcMep6YFsTf22IWQC3CWJSERbyPEJN3V3dEAuTxR5g4WVVA/bTsTOKt+8eBnD3uuXI/tvAogZ0MkOajOzZzVd1ms7gkbnUTptpuzYL49z9OG/J77meI6eDXFkiXqlET4zU3y5fWkav+hFToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVu2cg6Ts7R/pv209NqUrBba2XB/BLipoPmNA63Aq2A=;
 b=VxyyRjfzLeJ8yshIBtwNPsVLyyr6LcDGmpa67HkC9MUzVFLS50sKw93s16jWijClaNezZGNWxxxuLQp1Ik1IzkxSrac3/6Vm84C1krZZ3V6qHxCcVzUOi3PAfDIGK2QDidfOc4Lo97z5OsB7OCH/6BsqS3U31yPV8u7fLsNTiVbnSLitNmhJqBuSdMowhuKbAVL+nqZamoA5z4uUaKq88cwZGG7Ws+TBwAhJaGhxB5XQluGkQLuj7v+L78HegJJNyH2fO7zkhIiW9X5FGYmU3W9bRn78MEq3M7WdnCy9H46t7Xru7iBNqEIjYAFepYdhsVmXNUzgMbb4meIVRy24gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVu2cg6Ts7R/pv209NqUrBba2XB/BLipoPmNA63Aq2A=;
 b=PvCbhVOTQseNJZy+H8EvPSUANYA5NovbVN6Ez5a+2C+9lXB16KTt8GP2rQ6VJdu4vkp8Z9QkcWN8SpvfBZmW3DCEjM9ESAwpFo8q8QxmcZGHIVXWvV5sAAj84m+n11LcxCfRbBoza+F5eFnCfGEF67P2DJY3Vub5fri/bvclrOU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2728.namprd15.prod.outlook.com (2603:10b6:a03:14c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Wed, 19 Aug
 2020 15:36:07 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 15:36:07 +0000
Subject: Re: [PATCH] selftests/bpf: Remove test_align from TEST_GEN_PROGS
To:     Veronika Kabatova <vkabatov@redhat.com>, <bpf@vger.kernel.org>
CC:     <sdf@google.com>, <andriin@fb.com>, <skozina@redhat.com>,
        <brouer@redhat.com>
References: <20200819102354.1297830-1-vkabatov@redhat.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <8c876d8d-c13b-279d-6b94-15c3ad4f0a9c@fb.com>
Date:   Wed, 19 Aug 2020 08:36:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
In-Reply-To: <20200819102354.1297830-1-vkabatov@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0019.namprd16.prod.outlook.com
 (2603:10b6:208:134::32) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11e8::10d3] (2620:10d:c091:480::1:9a2) by MN2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:208:134::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Wed, 19 Aug 2020 15:36:05 +0000
X-Originating-IP: [2620:10d:c091:480::1:9a2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acb9b66b-f794-45cc-0ba0-08d84455969b
X-MS-TrafficTypeDiagnostic: BYAPR15MB2728:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB272892F4649A055716B08B83D35D0@BYAPR15MB2728.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:451;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5f1lRmJc8HUpcJz+ZRjICc94GPAsFO6JyhhPWQBViimXWFKqvf9stESCgh0z3R/PBriBswmiLtZfImFNvLEgBSkh++Hzx71fZ2fDKivB5KorikikauuU7x7QYO2btNlsYT48g/ZRbfC17khHJg9DNaZVNN25pePoI6LSG3uZTiimpbHgQY65OAvNUqi59bnPbMHklNCvWJMSB9KZK/5Pi1OvM8v/oxq8Dqh6RXmn7q51YdJoulZqQeE0ihYXVaVhRjD9j86oOrJ9M8sxK1WcP1iR/0cDSE0LavAs1TF7GPhQ77BMVLc8pQxMDtkOE6fl663MYrFXtO0RdYMe8bWYvNJj78Nx32x/gjFMc/rv5/p6ksKIqHmOhlfoGRRGMtzb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(396003)(366004)(136003)(316002)(2616005)(52116002)(66556008)(83380400001)(66476007)(53546011)(36756003)(478600001)(4326008)(86362001)(6486002)(2906002)(66946007)(31696002)(5660300002)(186003)(8936002)(31686004)(6666004)(16526019)(8676002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: rlqddxXP9yfwcms8LvuLlG+kcvGxYLR8n6doDdFtWrDoojfGRZwF8l9DBylzZIup/tmNBkgJus7ro6SF5Zuw8TQ4OuocR7Eh2czqlPtbSn6ifzmEMZsWPDn7h6/S1UWYx2RQ0+OmlrTNuRbvGgz6U7eRFv2SCvaASqzEMNKOhaH2+6BfenaXqEELp9k33FEc3JWgtioX8fU1ayhqTP3eaT0UUmAnR/leDpV+M/QKjiZPPwo7zN6+betlIxVHINaVttIKmpiXmvQWYuc/ihVjuUicj5m2NvDt43RikY0MU3jgwxezionNs77uPRDHq4yYDpDxZRyB79w8XZx3MF4BsgVE75rH7YZWO8eT4chMgmzhkI/IABs9ZV03ZunNwPcRzgRaPSZYkdbhG9aROKQI5tynVVvO9mZnQT+hdQPLUTgkG8CAuFjQ0zVmypktZe7vSXkmn2I1/7n1rQIqF2boqmRTLn/25iGSmUin3Pz+WtYyYD0BMn58v2w90x7YrsRg67t8QTHkkqWtI/aGYgCo0cUHWDh6bSGOCFN0FwglXVQntemCC6k6AwRxqHuAm9DktjORDbbOvLH2jsxcKOaZRNDtuBDt55WcbHofii3EN1nlO035uKFpLVex+gItufCg9UII9c8J5hCyYS70frfekBuKH+CH/oEoVAAg2UayrbVz/rkLE4dkwDkCDdXYYbUU
X-MS-Exchange-CrossTenant-Network-Message-Id: acb9b66b-f794-45cc-0ba0-08d84455969b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 15:36:06.9074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epMzEjIrDqLX0Dnv//DYdIEIv3dhwYLttg5VkMeUFnmgMVhFs05bEcF85I+B9N4Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2728
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_09:2020-08-19,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190133
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/19/20 3:23 AM, Veronika Kabatova wrote:
> Calling generic selftests "make install" fails as rsync expects all
> files from TEST_GEN_PROGS to be present. The binary is not generated
> anymore (commit 3b09d27cc93d) so we can safely remove it from there.
> 
> Fixes: 3b09d27cc93d ("selftests/bpf: Move test_align under test_progs")
> Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>

Could you remove 'test_align' for .gitignore as well? With this,
Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/testing/selftests/bpf/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index a83b5827532f..fc946b7ac288 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -32,7 +32,7 @@ LDLIBS += -lcap -lelf -lz -lrt -lpthread
>   
>   # Order correspond to 'make run_tests' order
>   TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
> -	test_align test_verifier_log test_dev_cgroup test_tcpbpf_user \
> +	test_verifier_log test_dev_cgroup test_tcpbpf_user \
>   	test_sock test_btf test_sockmap get_cgroup_id_user test_socket_cookie \
>   	test_cgroup_storage \
>   	test_netcnt test_tcpnotify_user test_sock_fields test_sysctl \
> 
