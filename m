Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CC239489A
	for <lists+bpf@lfdr.de>; Sat, 29 May 2021 00:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhE1WR4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 18:17:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38378 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhE1WRz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 May 2021 18:17:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14SMEsjN129834
        for <bpf@vger.kernel.org>; Fri, 28 May 2021 22:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : from : subject :
 message-id : date : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=OeQgnw9EfyFvjEg3nU3FwHXDdCGpuFCMsAhCTL5P3LM=;
 b=ss1RhpMCrjB2b7ZZf63ksVgt8xcxvMqXlns6REjtZkyQoBiAiCmUsknzAdVHU8EN1QkJ
 cSX/FMSNqtc232vPv9RqrStOFjGjDJdjogLHIannLA1HA1YII7XbomMdLU4sfRh2L7i5
 65te4t6zVhfxjFPttxXOWolkE80+1ZlRYYaUM6UxXZAMtOt5OypzRC7DhSzT7FM7xnKv
 SzMvnjS59dwU/yG75vAE1Xe+EmT8C7kP3+OW+ehM5rmyJ3WtJ42NCWGGxe/K9DkqRxez
 qQCp3pmgwkGKRw+6BoPjZxjqGF4FaqfGiqblKaWBTcrV5TVfZDRCZQbTimpA1StLDffz Yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 38q3q97pvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <bpf@vger.kernel.org>; Fri, 28 May 2021 22:16:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14SM9lPn166631
        for <bpf@vger.kernel.org>; Fri, 28 May 2021 22:16:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3030.oracle.com with ESMTP id 38pq2xxh8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <bpf@vger.kernel.org>; Fri, 28 May 2021 22:16:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyygq8kpnppkcjaln2X1nxb424XYb/wFdFFs+quC6e0STZEcLhUvR+BaS5Qx8Wn44MB/HVcSO00SNyjKMc4ulzWE+pX8REK/on9xD0NcDV153lOb8pwG2FtmSdYJLaWJv83j2KuffNU26IMfDGhL0DHpob0J52Km+E5dixEnZnnw8lZSOOaqB3Io+0ig3HBVfAUp3AnVtFMd1c6lbKqVs/SZladk5gAoZn7/BMxESXRlREqS3FiKh1lSWk8wVU+NWIXlT/otp4+O6nBo8RB+7cBVF8Eg/YvuyHfeDDY8hyczvQY7XCn6UmLk/B0/8rPm7saKzGiSumF67/keQz2PAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeQgnw9EfyFvjEg3nU3FwHXDdCGpuFCMsAhCTL5P3LM=;
 b=i/CeSly7mC9O6016mL34kriWhVCmDwPGRfi+qDYGvSLpNQ4e1MJhpRnG5OkJtvjbQaa+HWgacAoj6x8GPIsQRBxLObF3GB8oaWYpC+6YUVMqLv4LmTg1YhSpf3g7exTFC1aOloxYseiAkCQ0wymns89xQ4OfEy41eL2orJVmWPBzJLcPrWtKBEZpNPjjixBsPb48J+YAeiGlWOqJ5VMdLq7epIjzF+cVhzkrTV86nHjfoNZWVBQ1h6LLeiZBYvVTZ50FL73ImflNSPl/SrbBZKr+/di+6qD1J5zAoK61dwdM/qp9d6QoyEwAIZaQNQOB76K31CrAaA2LZsuWga4rzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeQgnw9EfyFvjEg3nU3FwHXDdCGpuFCMsAhCTL5P3LM=;
 b=ZWekGXc5pCwmSk5gUxFensb6rP9BNyDbS3VssrIAt//3UT0lP7VRFpFJjpladtZ4Jd+XelhksdqKXXgPTVdx7dCdeuJR/18Pm/0E2sYcxJn5zTb0DS8mbfpMWDZo2TyK5MRC1G/wqfhCqr4wudav9h4ke3Diqz91h1caeaxdY/A=
Received: from CO1PR10MB4644.namprd10.prod.outlook.com (2603:10b6:303:99::24)
 by CO1PR10MB4532.namprd10.prod.outlook.com (2603:10b6:303:6d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 22:16:16 +0000
Received: from CO1PR10MB4644.namprd10.prod.outlook.com
 ([fe80::1089:39ed:75c3:64f9]) by CO1PR10MB4644.namprd10.prod.outlook.com
 ([fe80::1089:39ed:75c3:64f9%5]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 22:16:16 +0000
To:     bpf@vger.kernel.org
From:   Eugene Loh <eugene.loh@oracle.com>
Subject: using skip>0 with bpf_get_stack()
Message-ID: <30a7b5d5-6726-1cc2-eaee-8da2828a9a9c@oracle.com>
Date:   Fri, 28 May 2021 18:16:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [148.87.23.10]
X-ClientProxiedBy: SJ0PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::19) To CO1PR10MB4644.namprd10.prod.outlook.com
 (2603:10b6:303:99::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (148.87.23.10) by SJ0PR13CA0044.namprd13.prod.outlook.com (2603:10b6:a03:2c2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.10 via Frontend Transport; Fri, 28 May 2021 22:16:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcd5c4f5-28c0-4d3f-ef2c-08d922263655
X-MS-TrafficTypeDiagnostic: CO1PR10MB4532:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB45329FCE949825271C7F282CFF229@CO1PR10MB4532.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGm3w91Hyf6t1x2MDE0nmeNZEkYZ1tm6dWK0j/ddFwF1HHRd1fb27Zj9Xf8khb9d57F0UnVukL5Gld/wTx1DJ9WwWNqw/uCYhBamnImuuiWcRGOJQPyJpvK4FM8qLSoTuvh0uZLcuBhuc9cavwIOYeBfzNUDGy6lk6gjm8bXpVpwO8PkXvMKAQyjUvVbPb9sPpYy2yiS6qi5RbgDSzWwz3mkrfB8HBPLvHEkuo5b8GRAHs9NXQy7+JQ8QWJiPpZZbTFnGjDiESriypk3IH729OeKsfYl07944ylu5EJl97JcLneWWtL9WDoDElqIxVi+/OAtIG45hg4Ex5m/7yRIc0hYMr3J5ky0vjLfk+VQ6+OeBDWHZVqKDxkYqF/XCtRpV4A1zRxdJ8LjUiYeZuflvJB3XYsbQLUMxE39dCUdFe2bcObhpY6aUepoANag97XiFOY9eGJLZNen1e8vRP6pSNRckKU13aYr32tJwLMiTsQQ0kaRrTlbbP2gFkcQnllVagV34tRhe7IKtd3IOhNN0C1rk6Qep5SFfWRHDcttiXlUTY5fXmtvLY8oel+sRYQH6iuSrMsvxK0b8oKpspkaPxXSAkalSNu4Vq8ZrsTZhyIaoWpAELkmvJWJLILf/euNXhA5dWbGH7xWQm0tIdJdcQaN51JRrXUBMnlW6BwjQMYbZQ1Dz1Rm+5YyGIL7WKGL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4644.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(366004)(396003)(39860400002)(478600001)(8676002)(6506007)(2616005)(8936002)(2906002)(956004)(36756003)(26005)(86362001)(31696002)(316002)(5660300002)(44832011)(6486002)(6512007)(66556008)(66946007)(6916009)(186003)(66476007)(16526019)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bEZkbEhDaWlnaHErKzFGN04zUWlzdW16dGRuTkZoSGF1d1pXakgyaVpMakp2?=
 =?utf-8?B?ZzlBMjZoVzZEZERPQjh3TEkvMVlUVXhYQU1TNnVFR0x1bmRhbE0vWlhvNXpw?=
 =?utf-8?B?WjY2OTV6Z2VDYk4rNU9rZXcrcGJOYzJIL3A1OWVvR0pFRklEK3AwUWUzdmxW?=
 =?utf-8?B?WWthaVI0ZklLbElHbGtoL1FjZDJ5anlDc2pJYUY1MytiU0wwVWM4RlkvZy9q?=
 =?utf-8?B?VjBUNDc2OVFMdUhnWkpMdHd4czVscXdHNm5KcTVnZXBBYlVXN2liczZSYnY1?=
 =?utf-8?B?WWJKOGlVK1pBM1NuRDdqM2FORG1BU0R5THVtQTVlMTE1MS9uOE1YUkJsQ2hV?=
 =?utf-8?B?YmJMdmhsdmw1S083UFJQOUQvZlE1VkVGYnBEcVlRbnJHckF5V2hNeU1wUHRz?=
 =?utf-8?B?OUpKTm9Qb0VyRGpSMDQrbDJLT1NMbDljb3JnYlRUS1g0VVFzNE1Bdlk3UTNY?=
 =?utf-8?B?MklaMUN6RWNTWS8vRlNCVG1RaDZRTEU2cytoaURrY1BzVHg4d3pWUElHNVNu?=
 =?utf-8?B?M3E3dFoxeC9mZXY1aHAzVGhvZW5hV3NWVHowSi8xcXJiM0VNWU01RXJucXg1?=
 =?utf-8?B?MlhnSFZZT0JkMTlVNm1xSEEyM1Y3QkQxcnJhYlJSUVpPSmIvRXhlUkVicXQz?=
 =?utf-8?B?elVpVnd1QmVRY2xhdGVIWXQwd2UzbjJCalpVWERseHJBQXNxZHZnbEtiN1ZS?=
 =?utf-8?B?ZytNdFkrbzk1cWhoRnlqY2tScXg0eldwajNpUTZDSzY1T2sxWEJBSVJCT0hK?=
 =?utf-8?B?dDZWVi91cTJpOUYwWmxRekZESG1iUGxRQUdPOEpyanA5QS9wUTEwM2RpMzVj?=
 =?utf-8?B?N2V4QXY0N1FsWGE5RDNJWkpyNUpjWUpMWGY0dkJDeFpsRnZYNEhFUXlaQjdW?=
 =?utf-8?B?MU52M1kyektDNzQ1cDJBUWloYmo5SUd3dlpjSU5VcmcxbE96YWhHK002M05D?=
 =?utf-8?B?QklTd0RCRmtIOXhiZUxtSjVRam5ieVhNUjA2M04rZDVLUEFzS1lJUE91T0Nw?=
 =?utf-8?B?dExYdWdoTUZDNk1kN25pT0tTN0VjM2VjRTNoV0ZFQXZYL3djRnN0Y3ZKSXdt?=
 =?utf-8?B?Vmp0c0JHUUo5U2gxcG1CM3lNdHFFcEV2RXF5bDVrUkdZeGF6N3k3Tmt5TWxa?=
 =?utf-8?B?SVlpOVRLUFh6N2loZmFxRXEzUkxxc3dLeTB1VllDMmRPNjNNNjZDRHptdTdG?=
 =?utf-8?B?bWdJYVpiYUp5dEhiUjM1dkZTUHB5RUMxUGRxQ3JLcWxocVlSdE1FdHBXbS9j?=
 =?utf-8?B?OG1pU2x2bXplVDBqLzc0bmdCTGlRNno4Q0VNSkJ3c282SmhLYU1JcHkwdzA2?=
 =?utf-8?B?T2JwZkRINGtpUmJQZFFrS0NLeEpoNkxSZmphdWxYR3BTV0llTWl6cUZyZWNz?=
 =?utf-8?B?alVkSy9LU3piWERPTlRBS2IxeERmOW9Pc2VlUWhiUVZVNk9qWmdUVUppbUhk?=
 =?utf-8?B?bUVXVGxrbDUrTWdwblkyeUZjNXd3SytmdGVocXYwcWI2U2pNdlhuVkxZQk1K?=
 =?utf-8?B?akpua2k3aktvVDNkRHp4dnpKTXlQUEZaakE5bXJSS1BzQXl2S2tTUmd3bHNz?=
 =?utf-8?B?bXJRalpDVkZXQkFHYTBERmk5dWVYblluTkhKRmVIdXNiZ2xobm5mdEM0VTNy?=
 =?utf-8?B?V0J4Nk55b3lmUnlnTXhZaUJOV2Z3cmxpcjd4ZHFNeko5MFpHdVZ3a3lYUm9U?=
 =?utf-8?B?U1Z0d3FHelFFUEplSlo4VW5jQWd1OFlFU0FpNUt1U20zYjhtQy8rNFVnSDZX?=
 =?utf-8?Q?bqT5bEIhQKmhJ51SuoVWiBDfTzal/9y4w5fqCPo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd5c4f5-28c0-4d3f-ef2c-08d922263655
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4644.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 22:16:16.7340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SeEEGsRCWaJgRnTgh5cSe24FeoYhYyphzeo9RSdrt9cNny94BtFn8qVoregEuS4oZK/ZbWnIfOc2iyo1h4sO9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4532
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9998 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=859 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105280148
X-Proofpoint-GUID: Qo6GqRrZ__i9dxRXJClusZc5IT-37Meb
X-Proofpoint-ORIG-GUID: Qo6GqRrZ__i9dxRXJClusZc5IT-37Meb
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9998 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105280148
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I have a question about bpf_get_stack().  I'm interested in the case
         skip > 0
         user_build_id == 0
         num_elem < sysctl_perf_event_max_stack

The function sets
         init_nr = sysctl_perf_event_max_stack - num_elem;
which means that get_perf_callchain() will return "num_elem" stack 
frames.  Then, since we skip "skip" frames, we'll fill the user buffer 
with only "num_elem - skip" frames, the remaining frames being filled zero.

For example, let's say the call stack is
         leaf <- caller <- foo1 <- foo2 <- foo3 <- foo4 <- foo5 <- foo6

Let's say I pass bpf_get_stack() a buffer with num_elem==4 and ask 
skip==2.  I would expect to skip 2 frames then get 4 frames, getting back:
         foo1  foo2  foo3  foo4

Instead, I get
         foo1  foo2  0  0
skipping 2 frames but also leaving frames zeroed out.

I think the init_nr computation should be:

-       if (sysctl_perf_event_max_stack < num_elem)
+       if (sysctl_perf_event_max_stack <= num_elem + skip)
                 init_nr = 0;
         else
-               init_nr = sysctl_perf_event_max_stack - num_elem;
+               init_nr = sysctl_perf_event_max_stack - num_elem - skip;

Incidentally, the return value of the function is presumably the size of 
the returned data.  Would it make sense to say so in 
include/uapi/linux/bpf.h?

