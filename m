Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4735739E1
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 17:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiGMPSr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 11:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbiGMPSq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 11:18:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E64F7C
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 08:18:38 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DDEFKQ001632;
        Wed, 13 Jul 2022 15:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fZkxsXTodrQugUNJyPCHSu47nh3VbxDG2wd+1+UzsYQ=;
 b=AXiCN/FycmzwUK62tz0ic4gLp4b7IGXwOQV01/1rMxcMlP0BatvbND5Ksft/Kc/m/Bej
 NZeGj/m8Jvos8lXQ9IJkCMZ+Ql+0f/y11aIyVihE+/1ttGD7hLrBwGg3XqOd/uHl4AXz
 AXRa7UvnmRnyPDFOdvIigv4eNRpbN8P0Z6rN8r4ssaNgdX5XHcBhGvOxN/tekr/W0Lej
 tgvNMU2ipIaAurTdrB0J1JRjv5qjt/izYyx6tpsTe986e1gSKOdS7et6MU1uPz10XSVp
 CiLlCjsTtTpw5DMZiHywoMGN0TuE45ITmBbmynIezD4R6nMMf2w++6/yTqYJR0Ma69YQ cQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h727sjwr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 15:18:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26DFFdmJ036453;
        Wed, 13 Jul 2022 15:18:21 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h70455kay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 15:18:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbC0BZoQkVF1KwvkoJMVoBGNpzmIS1FK98u3O5u/MUerNJYipWkiCX5juPsyF8+nI7V9oN5cPsVUVPYEU/xEe0+E+Zrtj/SVJ/odlr8VBr1blXBQ8oAmzaLg6co8fZ+2X0Yf39mfg1gqHxTUdPU3eraVh4PiVCj0VjHyyX4k2i8skhlvbj1cn19uhC+NZl+HMTFzqpCh6KlXF0r6ndnWEuAiIADMW/BAWp7OOiooaZz9R1x4+c1aj5zr28FJDyIB5+iT+p7dFLj9iOOqIkJW6+tJ0DWWTbF4c91CvGpWSbaZU6MZINay4CjbK9nV4xS1jDitVo6deKIwBa04rQvYcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZkxsXTodrQugUNJyPCHSu47nh3VbxDG2wd+1+UzsYQ=;
 b=X/9ybaEDCpUSrwsSqf91p6VrGYxmq4evgAPZwCbzp+u9LQ/d8CYgJaW/kQ33lsph3hv8dskY1qlfNvEZo2qTCO6Kf6C4pWBqKM1UmqsFOXvb1d4h//2JMpsNpipv3/G4jPqCsgqN8tutOeZSFCBzWITStDL1sBkHT42pYs6A/wU3r0BwCV0++Ri2YnfSB4CL+KxnT7JEBysZCALX8w3mG4/sSXoHdtKU6vwkX6PTHpssHdBVvxx5U+ZbT+tSI3txqvBt2xhoLQCXO5JiC68C00jRvZp6+u+2gWAvWdkceJ1fITq53HEVidieXL00MIm2vLgPa034yWuJzeW+wVe+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZkxsXTodrQugUNJyPCHSu47nh3VbxDG2wd+1+UzsYQ=;
 b=DbE/3u2f3LI3qkGOhIoT67GbVUXtz7APZP4lrGaCoVU72aHxAfMV4VMnnkeNYH415HPX484gVf/rw+HVQK18Lfd363rFF5y1hAKxsISudG2MRdsId/GNi/zIRzzeb458zxTbFY7AQo5LEuutXAANGU921RCKWZ+IT5yTE0sQAWg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA1PR10MB6220.namprd10.prod.outlook.com (2603:10b6:208:3a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 15:18:19 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 15:18:19 +0000
Subject: Re: [PATCH bpf-next 1/5] libbpf: generalize virtual __kconfig externs
 and use it for USDT
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20220713015304.3375777-1-andrii@kernel.org>
 <20220713015304.3375777-2-andrii@kernel.org>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <f748ace1-f3fb-2525-ee3f-5fb6c564fe2d@oracle.com>
Date:   Wed, 13 Jul 2022 16:18:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20220713015304.3375777-2-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0238.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8695f5bc-3b61-4864-d069-08da64e2eaa6
X-MS-TrafficTypeDiagnostic: IA1PR10MB6220:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uhTiPaCwoUhCpbkRersqk/VC954dPCE3Se76qbS278/lo+yXa78smdCQI/t+ygPyil399cijQ2E30zqQTjXPUT7RXUMN/5I3WDC+xuGEso+nBBXafbG6DqfeUG7xZOY7Qhfeskd29AmqiFw9Oe0h++eHQ0g95xmMH9X2Q+n7cHalBRXKPNHHOt1qkd0/E+KAY48mbLrKp1x4S5d7/XmHHxfeFpMeuycAcehRORDCP26IOBqQwZ7FXCPuc0V3apOikOnTgAknEiBMGT8GruyMO+Y+Tp8wnhU1y9vPBmCmjLy1bumFA6AVbWdxvCg4FXymScOimaV7op/TIJBFklKc+z5xUU3G37gdEXcW0paT5DkqRN3na0Bnnxne0O9RGm5uy2Df9l0URp42WHIV+GYKHBfoCWeen04hmPTucVZVMqNpg4k+fXHXyEnbbSLe79Oeg6+TubAxenJs+asInGc9QdX02DrgMoPwW0nSOzhS0+IOxj7I3SlDMBFnlyEfBNgUSbeM19r6wmTexT5x83su06vLyCIfjSJYlb2rEJkaxY6pgi+lxddHjSR2wtfg888+Vaaz0x6bHboc/NAleLEbKHyWsRAP6Y6e5U29ImhS6hqvMaiUyt8ha8Gxwvmm4wI9h/9/iv/QNpSGnqu9OR88cV67n6gqxAe+WJJO+ih24jjMSytyNgbHAb/aep/HL+0cfCc9yhNYr/MaceQhIpXZgTZ6+nYxTP6xCa+UUPtWP6lOu726LPjzFUHn8yqmOCSJ6Qu9bDlWAZi2K5yoyy0q8JezshmUPKxndxL8lJwJ6yW/aIH6mT55Y2ZJfe3ILaWavyYoXsHTsJF3u0/TonKpih0zKjwQOJ0FqoG19FzbQjReZvac+pdcSjvQHPdye0VAJvVxWCADDPE0AzOkAvB1Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(39860400002)(376002)(86362001)(36756003)(83380400001)(38100700002)(6486002)(2616005)(44832011)(66556008)(8676002)(66476007)(66946007)(8936002)(186003)(5660300002)(4326008)(52116002)(31696002)(41300700001)(6512007)(6666004)(53546011)(31686004)(6506007)(316002)(478600001)(2906002)(461764006)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHNFc2dZUUhBN01RODJtRzMvcCtreWhNekVmc0RmaGJ0THNKUjNDcDVybk5K?=
 =?utf-8?B?ZzY2NlJ0amVUY1M3VkNJYmdkLy9iK0J3Z3MwaEJ6UnZHTExKQmN4U2xxNEYv?=
 =?utf-8?B?aVVISWc4T1laZkdOaTh5RXFXNFp3dVNlZHliME43eFI4a3g2d21udUYrK3Y2?=
 =?utf-8?B?VGZHVERMNmdXc24wYW1mV05XNW9zMDlXajJjcUlQUFBYd2E2NjhuSDU2ZHJ1?=
 =?utf-8?B?TkJQSVM5QnZqd1duei9lTXphVVVNK1dDTklPcG4zN0ZnZTRZcHFjZzU5UEdJ?=
 =?utf-8?B?VkNmbDBqbUVUcjZLWkhSc2k5Q3BrOTBLRlMxOEtNSlBUcTY5V01aZXVWUUNz?=
 =?utf-8?B?U1lzVERQb1l5cE9oVEt2VXpUc0JjZ3FoUkFUdFo1YVpnMmlTZC9pWXNzZVRj?=
 =?utf-8?B?blVuUHJmZS9ESVRpaEQ1K0Q1TExIek1NaUZCcDZQNjlVeVA1YWFWQkh6RUNr?=
 =?utf-8?B?enpDWXE5UDlSWThxWmVwTmRrM3M4dXhobjFUV0dEcENoSG1NTjQ1U0JCcFlv?=
 =?utf-8?B?UmFlYU9oNE80dStTOSt6VGJHaFRTUE9IdHY1Z0pKbVpCenNZNG9qOEdESG53?=
 =?utf-8?B?cUhzOTA0dmFTaG50RmV6Z3NQR0pUM0w3TlJjWDlJdWl5elIwNEtaMW01bkxi?=
 =?utf-8?B?QWpxK3EwS1hkWnpEOFBqaVJhYy9BZ0Fjb3pFY0VxYzRLYTk3NjBnOXk0dXRG?=
 =?utf-8?B?eFgrVkd0eE1kL1ZjR0hEVE9LZllSWUdDdkx2VU1QY2ducm9CZEh5NWdCRXgr?=
 =?utf-8?B?TThGbng0YkNhWFhtYTB2K05ETXYySDUrR2JidjJDczNTS3ZFdnRaZEUrOVBj?=
 =?utf-8?B?aCtoQnFSUG1LLzRrL2ZROFJzQUtFVTZxaVRodFpBdEJPVDdMdFBNZitJaFNm?=
 =?utf-8?B?MXVDS0ZMcGNMMXovWUE1SlJybGtOMHQrTDcyK21Yc2RvVmwrd1V1NHM0bDNN?=
 =?utf-8?B?aEhnQ1RCdXo1bStDanFyd3Yxa2FYVTdMYW54NDBrZTFqZ0hZeVROZ2VqRERD?=
 =?utf-8?B?aDdKS1M1UTNxSjZ3VWdTYTE2VmgyL2xxYlBQUjdZcjh3dFRQWm1lVGFja0dq?=
 =?utf-8?B?eFdNTmZEd3FSNTJnK2M5V0dIcG9wLzZaYTY0UkFkR1RTNmV0QVhDOFFGeFRh?=
 =?utf-8?B?bWIwUHNVRVUxNDVZZjJRaUUwTVR0dkJoRnVEbWpTSFF6WHQya094SDdveUU2?=
 =?utf-8?B?V0l1R1JDSjVWeVdLL0tScWlDdkREcElQNnN5WmZ3VFJWZXFtTTNjZzMwVFdp?=
 =?utf-8?B?WWJ1M3QzNjN5c2tQaGxON0M4T0lYQ0ZSaGJudzNNVGtMT0tzclpUSDN4RVd5?=
 =?utf-8?B?dEdadlBObzRGUFVKZWViS1B5eENsYVIwbnphTy9MbFhBQ2xEQ1RHdldqSmMz?=
 =?utf-8?B?OVBuWVhlME94YXVJaVlnZHBUc0JKak1Sc0FGV0w2b0lscnh1K0VzRllSSGtn?=
 =?utf-8?B?Y0dRNVhyRGh5MGErZ1Yxb0xxb0o0aXcrSDRzMG4rdnA5bG5uVzg0RWxkSFh0?=
 =?utf-8?B?WVQ1dmJObFdLcm92QmROak1XeVEvcjRMZ0JET1hkUG5qMFBqQmpsQStNSXRo?=
 =?utf-8?B?bVZKd25ENzBHK0ZsTDh2bzFBZWV4bGR1dWs3aVVWRTlGbldmZnFvR0VVMndx?=
 =?utf-8?B?UnRyYmVOUEtrMlV6eWx1MVNValYvK0p0dG9xdWRIdUdXbHZYSWUvMXB4WUQz?=
 =?utf-8?B?QW11NGNFMVg0aHFGbXlNVGxTVVZLOUNuc2hBcklqOGdMeUpyRWpSc1lIZ015?=
 =?utf-8?B?MVVNejN5ckpvT0hMR3BzNmUvQ3BSNjMrOUszMmtpSS9CZjhmSlBtWmRwL3NL?=
 =?utf-8?B?WnF1WkJVL0lvRHNDaktvdWdYSUVJRTlXRjN1NnVGT2NXRWN0Yjk2Y2lYNGp2?=
 =?utf-8?B?V01LbkI1OUxVWjJhbDFWRXZCRmFVcFF3YS9zTnZPN05wcEM3b3ZCVWVNUnlm?=
 =?utf-8?B?SmpZb3poMHVNWjNGZW1EdUx3NXZkZFRUVVEwUUdHOE0zcmJJWVEzOG5UU3Ns?=
 =?utf-8?B?ZHAxZDhiSEpNcXkwMlpTandFOE1kNWthTERFUkxtZkNwZERWMENWV1ZKS2Z6?=
 =?utf-8?B?TmpqNTF3TTVGT1l3QUZTRTF4VGhYbFFqcXRRWjU4bWhveFBtUk0zOWNXd2I3?=
 =?utf-8?B?MWpqU3c5Z2h4NkZiNW9TWXhDeGRrVS96QTZxdDFzY2UxZVRMSmZoYXUvemt4?=
 =?utf-8?Q?/rp2k/Ej4xidAAfgCDtc/VU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8695f5bc-3b61-4864-d069-08da64e2eaa6
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 15:18:19.1361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0u5LeBT2/Ii/ZaQI+HNhFXkf+WHNVlXRQYK3tMviSJpTw0GW0cUQpMxN0eCNii31WdCLif5/r69M5iPipdCMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6220
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_05:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207130063
X-Proofpoint-ORIG-GUID: JQNmIYnh1GJgBCAna4eY8ArpozvyRwCm
X-Proofpoint-GUID: JQNmIYnh1GJgBCAna4eY8ArpozvyRwCm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 13/07/2022 02:53, Andrii Nakryiko wrote:
> Libbpf supports single virtual __kconfig extern currently: LINUX_KERNEL_VERSION.
> LINUX_KERNEL_VERSION isn't coming from /proc/kconfig.gz and is intead
> customly filled out by libbpf.
> 
> This patch generalizes this approach to support more such virtual
> __kconfig externs. One such extern added in this patch is
> LINUX_HAS_BPF_COOKIE which is used for BPF-side USDT supporting code in
> usdt.bpf.h instead of using CO-RE-based enum detection approach for
> detecting bpf_get_attach_cookie() BPF helper. This allows to remove
> otherwise not needed CO-RE dependency and keeps user-space and BPF-side
> parts of libbpf's USDT support strictly in sync in terms of their
> feature detection.
> 
> We'll use similar approach for syscall wrapper detection for
> BPF_KSYSCALL() BPF-side macro in follow up patch.
> 
> Generally, currently libbpf reserves CONFIG_ prefix for Kconfig values
> and LINUX_ for virtual libbpf-backed externs. In the future we might
> extend the set of prefixes that are supported. This can be done without
> any breaking changes, as currently any __kconfig extern with
> unrecognized name is rejected.
> 
> For LINUX_xxx externs we support the normal "weak rule": if libbpf
> doesn't recognize given LINUX_xxx extern but such extern is marked as
> __weak, it is not rejected and defaults to zero.  This follows
> CONFIG_xxx handling logic and will allow BPF applications to
> opportunistically use newer libbpf virtual externs without breaking on
> older libbpf versions unnecessarily.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Tested the v1 patch series on arm64, all works well, so feel free to add

Tested-by: Alan Maguire <alan.maguire@oracle.com>


...for the series.

I really like the concept of extending LINUX_ kconfig values.
A few nits, but looks great!

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/lib/bpf/libbpf.c   | 69 +++++++++++++++++++++++++++++-----------
>  tools/lib/bpf/usdt.bpf.h | 16 ++--------
>  2 files changed, 52 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index cb49408eb298..4bae67767f82 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1800,11 +1800,18 @@ static bool is_kcfg_value_in_range(const struct extern_desc *ext, __u64 v)
>  static int set_kcfg_value_num(struct extern_desc *ext, void *ext_val,
>  			      __u64 value)
>  {
> -	if (ext->kcfg.type != KCFG_INT && ext->kcfg.type != KCFG_CHAR) {
> -		pr_warn("extern (kcfg) %s=%llu should be integer\n",
> +	if (ext->kcfg.type != KCFG_INT && ext->kcfg.type != KCFG_CHAR &&
> +	    ext->kcfg.type != KCFG_BOOL) {
> +		pr_warn("extern (kcfg) %s=%llu should be integer, char or boolean\n",
>  			ext->name, (unsigned long long)value);
>  		return -EINVAL;
>  	}
> +	if (ext->kcfg.type == KCFG_BOOL && value > 1) {
> +		pr_warn("extern (kcfg) %s=%llu value isn't boolean\n",

most warnings sem to conform to the format

		pr_warn("extern (kcfg) '%s'; value '%llu' isn't boolean\n",

I find that a bit clearer but subjective I realize...

> +			ext->name, (unsigned long long)value);
> +		return -EINVAL;
> +
> +	}
>  	if (!is_kcfg_value_in_range(ext, value)) {
>  		pr_warn("extern (kcfg) %s=%llu value doesn't fit in %d bytes\n",
>  			ext->name, (unsigned long long)value, ext->kcfg.sz);
> @@ -1870,10 +1877,13 @@ static int bpf_object__process_kconfig_line(struct bpf_object *obj,
>  		/* assume integer */
>  		err = parse_u64(value, &num);
>  		if (err) {
> -			pr_warn("extern (kcfg) %s=%s should be integer\n",
> -				ext->name, value);
> +			pr_warn("extern (kcfg) %s=%s should be integer\n", ext->name, value);
>  			return err;
>  		}
> +		if (ext->kcfg.type != KCFG_INT && ext->kcfg.type != KCFG_CHAR) {
> +			pr_warn("extern (kcfg) %s=%s should be integer\n", ext->name, value);

I think the logic here is meant to support a KCONFIG_CHAR value that is expressed as an
integer; if I've got this right would the error message read better as something like

			pr_warn("extern (kcfg) '%s': '%s' isn't an integer value\n", ext->name, value);

> +			return -EINVAL;
> +		}
>  		err = set_kcfg_value_num(ext, ext_val, num);
>  		break;
>  	}
> @@ -7493,26 +7503,47 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
>  	for (i = 0; i < obj->nr_extern; i++) {
>  		ext = &obj->externs[i];
>  
> -		if (ext->type == EXT_KCFG &&
> -		    strcmp(ext->name, "LINUX_KERNEL_VERSION") == 0) {
> -			void *ext_val = kcfg_data + ext->kcfg.data_off;
> -			__u32 kver = get_kernel_version();
> +		if (ext->type == EXT_KSYM) {
> +			if (ext->ksym.type_id)
> +				need_vmlinux_btf = true;
> +			else
> +				need_kallsyms = true;
> +			continue;
> +		} else if (ext->type == EXT_KCFG) {
> +			void *ext_ptr = kcfg_data + ext->kcfg.data_off;
> +			__u64 value = 0;
> +
> +			/* Kconfig externs need actual /proc/config.gz */
> +			if (str_has_pfx(ext->name, "CONFIG_")) {
> +				need_config = true;
> +				continue;
> +			}
>  
> -			if (!kver) {
> -				pr_warn("failed to get kernel version\n");
> +			/* Virtual kcfg externs are customly handled by libbpf */
> +			if (strcmp(ext->name, "LINUX_KERNEL_VERSION") == 0) {
> +				value = get_kernel_version();
> +				if (!value) {
> +					pr_warn("extern (kcfg) '%s': failed to get kernel version\n", ext->name);
> +					return -EINVAL;
> +				}
> +			} else if (strcmp(ext->name, "LINUX_HAS_BPF_COOKIE") == 0) {
> +				value = kernel_supports(obj, FEAT_BPF_COOKIE);
> +			} else if (!str_has_pfx(ext->name, "LINUX_") || !ext->is_weak) {
> +				/* Currently libbpf supports only CONFIG_ and LINUX_ prefixed
> +				 * __kconfig externs, where LINUX_ ones are virtual and filled out
> +				 * customly by libbpf (their values don't come from Kconfig).
> +				 * If LINUX_xxx variable is not recognized by libbpf, but is marked
> +				 * __weak, it defaults to zero value, just like for CONFIG_xxx
> +				 * externs.
> +				 */
> +				pr_warn("extern (kcfg) '%s': unrecognized virtual extern\n", ext->name);
>  				return -EINVAL;
>  			}
> -			err = set_kcfg_value_num(ext, ext_val, kver);
> +
> +			err = set_kcfg_value_num(ext, ext_ptr, value);
>  			if (err)
>  				return err;
> -			pr_debug("extern (kcfg) %s=0x%x\n", ext->name, kver);
> -		} else if (ext->type == EXT_KCFG && str_has_pfx(ext->name, "CONFIG_")) {
> -			need_config = true;
> -		} else if (ext->type == EXT_KSYM) {
> -			if (ext->ksym.type_id)
> -				need_vmlinux_btf = true;
> -			else
> -				need_kallsyms = true;
> +			pr_debug("extern (kcfg) %s=0x%llx\n", ext->name, (long long)value);

nit: should we use "extern (kcfg) '%s'=" as above to be consistent with warning messages?

>  		} else {
>  			pr_warn("unrecognized extern '%s'\n", ext->name);
>  			return -EINVAL;
> diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> index 4181fddb3687..4f2adc0bd6ca 100644
> --- a/tools/lib/bpf/usdt.bpf.h
> +++ b/tools/lib/bpf/usdt.bpf.h
> @@ -6,7 +6,6 @@
>  #include <linux/errno.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
> -#include <bpf/bpf_core_read.h>
>  
>  /* Below types and maps are internal implementation details of libbpf's USDT
>   * support and are subjects to change. Also, bpf_usdt_xxx() API helpers should
> @@ -30,14 +29,6 @@
>  #ifndef BPF_USDT_MAX_IP_CNT
>  #define BPF_USDT_MAX_IP_CNT (4 * BPF_USDT_MAX_SPEC_CNT)
>  #endif
> -/* We use BPF CO-RE to detect support for BPF cookie from BPF side. This is
> - * the only dependency on CO-RE, so if it's undesirable, user can override
> - * BPF_USDT_HAS_BPF_COOKIE to specify whether to BPF cookie is supported or not.
> - */
> -#ifndef BPF_USDT_HAS_BPF_COOKIE
> -#define BPF_USDT_HAS_BPF_COOKIE \
> -	bpf_core_enum_value_exists(enum bpf_func_id___usdt, BPF_FUNC_get_attach_cookie___usdt)
> -#endif
>  
>  enum __bpf_usdt_arg_type {
>  	BPF_USDT_ARG_CONST,
> @@ -83,15 +74,12 @@ struct {
>  	__type(value, __u32);
>  } __bpf_usdt_ip_to_spec_id SEC(".maps") __weak;
>  
> -/* don't rely on user's BPF code to have latest definition of bpf_func_id */
> -enum bpf_func_id___usdt {
> -	BPF_FUNC_get_attach_cookie___usdt = 0xBAD, /* value doesn't matter */
> -};
> +extern const _Bool LINUX_HAS_BPF_COOKIE __kconfig;
>  
>  static __always_inline
>  int __bpf_usdt_spec_id(struct pt_regs *ctx)
>  {
> -	if (!BPF_USDT_HAS_BPF_COOKIE) {
> +	if (!LINUX_HAS_BPF_COOKIE) {
>  		long ip = PT_REGS_IP(ctx);
>  		int *spec_id_ptr;
>  
> 
