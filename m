Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D4662172E
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 15:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiKHOq7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 09:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbiKHOqq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 09:46:46 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D0F6307;
        Tue,  8 Nov 2022 06:46:46 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A85muPm021566;
        Tue, 8 Nov 2022 06:46:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=8fSy/CA/QWqcxbVdNwUZKEE41sLYXsjQdE7AAEazlnA=;
 b=YDj8hdQ8txHin37r99tIkTb/o4C14LZSvqVE74upFYSjxVeQC8owZVTNhKvfiVO5WqsP
 I7NrzkzPWr5aZT4bW0jQInGXNq07VePlH5WDDnu0DQKk/OjeLqMTJGdCYud6U7blHUas
 HHmChfjEDVRY2Soj7/RdRaM6JcX4V9W1+G92Yu6E7uHBmv7jCbbZL/TBFudvhPVp+E7V
 teK9mktQ5lCaXYm5A2uFFiMpz/NE8n/sEbTieVIo8UMPVkE7JPFfbCKg4/MWDCRjDUDr
 RCjSK8O+/gxEt5HkffyNEWluhcBnR8dnZhRII4hFvnFJL+Hpxz6CGq1r4sJUd9aBrYeQ 2g== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kqh9wb6t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 06:46:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2RqMPQcgc5vbuLOUxpci/GWWYyIt/9JnIDqFzdEWWvFiFYJOIhfsXui+TFN8wCb3OndafBWn+OOZZCTlY6Bu/BK0vOj8t6PoQS9wyMGroFJHpsuyQAeFspJFtsXntrTiG1WhGcUf2x2Erec2XoyzWLXxbpu6F5HjXPShw5Mfx4jILeO+SK6YE0k7bq50YKAT8AjJuwbHTfqorjKQkE4ODG6URXQpXm9UJnR2mnYzA+ZJk0ME1AtDsZR6zpTeTdduypXvSLGEl7lssxHszXPJDraypqUvxXcfcQSx8ZdAlyKDKqUI5/oHMiy/wqCFOm5Em9/usoepR5keL18yi6pfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fSy/CA/QWqcxbVdNwUZKEE41sLYXsjQdE7AAEazlnA=;
 b=R+RgLBY9GHHb1riQnViyL5yo0asRpgXSU4wALi9zt6SdzXK9m260qOeDGX4o7YnRKbF5NsJIcdpfXxh0OZsR0jzU5iq23rXlYUIT9PAUN3nLuBhjx3C1IXDZgDbezip2BIbyeR9YQRyWwqOXm3Wtr8bGgSh2zYukFdhDzsNvoIDv139/1er8AGdD5E5vnLF0vISimzM7vE0yyDNaKTU+nbb664qBHI2wUdD85aQrK7ukoB2PKMmV/ZWoTs4e/B4fD/n8R+s+svtoVOVEzo5XxE96+vMsoWqYFxDyhwklPDj5/+OI+tuCU0RMZ3Gl0NPlm2zWUY8cwcxBm3Jo/xeEGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB3103.namprd15.prod.outlook.com (2603:10b6:208:f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 14:45:59 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 14:45:59 +0000
Message-ID: <57eb6611-3e4e-2a4c-69b1-c6f0c1eafe92@meta.com>
Date:   Tue, 8 Nov 2022 06:45:56 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf] selftests/bpf: Fix casting error when cross-compiling
 test_verifier for 32-bit platforms
Content-Language: en-US
To:     Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Pu Lehui <pulehui@huawei.com>
References: <20221108121945.4104644-1-pulehui@huaweicloud.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221108121945.4104644-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN2PR15MB3103:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e813e42-58af-4dc6-3f18-08dac197f348
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fx1WClVx02hjlVchPovig4FYXl78axIG+Fb1Le+d5/eu16JeuLXJQR9eWuGeHz2ai8PVf1CAjWC5J333rSSdxzbgjV5aQBhD9+I6lyDcEE70QlAsHlnqVFoHSnYSaUg7Si1+Z8RhnNZ/N/P1cZq3HKjxEwbMgSMnWUROZD/dgLkJaH/UKXGmVmS4J1g0qmcqxoK9SjcuMI3Ux4JF4JG++Pea0Y/2yD3mwMrBp9hW1qhV2YO+z54lQ9luqNSu42Qdr4Xc4rMPGsEN4ww9EKN8V+8gkKNJlQ5uA4pKTcCgdKbuofG38KyV1gpiuAttIcmN+RLfyUhkEtZQFNlN+lTq9p3uUIfLTerRrzTG5IqaUEi34oP8htr1um7xt3sSkn8TTNVoyBOA4+zqGy+PFLvFuyizYH0dKhrxhLuAvOKm9MfiZiybwHh3JJa8i51j/u0Gnw7SwA/rFQhUKyxVra77NGxfeq7fD0bhLCcCZnI8d4JURGAXLlRAFN2muaol+c79QSjVe2P9BdeQOnBjTEgK2Qr277wBhhU1ZElc/WPKdWnYb8od1TeNZxmVu7XNltKL+1l37ntIyfEjF+f6uJP4SohsK3kZPviXWwHcmdAQ+/vPXSeZTWM/p431LhJJ7TqewiU/fChBYnwOhUvxnNx61CPmtxnu61h64wPa3pe6/JQWJt40Rm6Wjge1iO+6mm62hq9L0fKtz9i28jjmpaEzZHFue0fU+W6/qRE1VndlpoaqW8IWfu4PkLVodtTeOzQHx0R//dek89W7wKFagsJIBPSAO2rLMl0wa8EDkdQoUuI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199015)(36756003)(31686004)(38100700002)(86362001)(66556008)(316002)(66946007)(66476007)(31696002)(83380400001)(6666004)(2616005)(186003)(478600001)(6506007)(53546011)(6512007)(6486002)(8676002)(5660300002)(4744005)(54906003)(2906002)(7416002)(8936002)(41300700001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEdsVGNXTngvRnN1N0g5UHhsc0R6V1JacENXV1FFdUNwNnh3WDhOTG9aN0lm?=
 =?utf-8?B?ZGJsN0lCcWxybmljdEM4VFJmZzlESlpJSDc2ZWY3bU1MRGdCcHMyMG1jUlh6?=
 =?utf-8?B?dnVvNmJKM1dZRE5yLzZzNFIzSGtaVFRocWxYUXRBWmdvY2tjakNldDE5YW4w?=
 =?utf-8?B?MnRxU1lKSk5RZEh4V0xKRmJvSFl1NDlBZkpKUklGTU0vd2JmZzdiT05oakVU?=
 =?utf-8?B?dTFhcUc3WUJJK0NpU1JnK1FIekg1T25QTHcyeFBxQVBkR2Q4SFFjdWJCeHdB?=
 =?utf-8?B?NzE1NWMvTHJwUHlCWWxtVEp3OFd0cktsTzRBUWs4bElpK3RvMnJoRjh6bEpU?=
 =?utf-8?B?dEkvUzFES3VwZVVIT3hjN2pYa29YN1ZhOURYWVdWTHJQU3kxYVJic0dRTzcz?=
 =?utf-8?B?emtJNDJuLzg1cEZwbENYWnc1aWVwYVgvbmswMFA0WW9kY3pUTHE2RkxOc3Bo?=
 =?utf-8?B?akVkL3VicTBraFhXTGNHUjRXaElhRmZBSXlRSVcyVG5uTUN1elYrZGx5S3Rs?=
 =?utf-8?B?MXN0VlI2dHByRUtVdXdMWG9hNjJ2dUJZMm1KZDdER21YZlN0SlV5WkJ5bVR6?=
 =?utf-8?B?Qlo5blZ3WjhxZ1JNYVJBRE5NalR1TWwzMWxDMlpTcjdXQ2Mxd1NHWXVaWERh?=
 =?utf-8?B?SWxjOW1ySDFCOVJjWGhsRlpUd1RZL0R3c2JxQnl3cjZrRTVRcTdvVEZLL1pa?=
 =?utf-8?B?QmtiRnBSKzA0UWxWQlMvVHlkdXNKQmVkbEFhYXIrSXR6a3o1bFJ5dTU1V0Vn?=
 =?utf-8?B?cDYxd3Y4RkNzNDRxVnRiSWZkNDZIcUc3blRoM255RXhNdVNjUjk2M3VScURp?=
 =?utf-8?B?aU9EVTRsZzdIWnZvdG9xOHBhLys5czlPOEFwdCtkZmdheEVDcDUxV1J2SllM?=
 =?utf-8?B?V0E5STNRb1N0L3QxYS95UDNxUlRXeUQxNnZwQWpZVWNwU0MvdW1jaWttMExX?=
 =?utf-8?B?RUtJR3BjNzUydEpaUWIxNzd3RHFuQ25WMnQ2TXlkY0pRTmZUSFpEdkZaVjZK?=
 =?utf-8?B?NkhRTTlVZnhUZ1gvMGRVNlBOSCtiM1dmVTQvNGJVWC9qem1xYlI1c1dIN1Rj?=
 =?utf-8?B?b1RTaHk1SzRsRE1HdHRpbm1CaVhsaDZXTjFLWEJJZG5oK2dOZzAzQ3Z6cnp3?=
 =?utf-8?B?bkFuZmpjQjJVUWVDUytTWFZtT3hwbDE1U0NJSE02UDk1blN2eWlFV09PcnZ3?=
 =?utf-8?B?b2w2WHJiVHErZnZlUC9IRVo0L2FEWFlaZ1FqVG9TbldPai9memJTL0J4YWlv?=
 =?utf-8?B?SHNyWnV6V040U0t1RU5hN3N1OFdIcTdRS0pCSGVHTVErOTBlelBXeUdMbHZj?=
 =?utf-8?B?WUE3dHZBWUcwaGVlWFB5UEpBSkpOckNNVzJZV2NoSitSL2J3V09zazlnZTlW?=
 =?utf-8?B?MXNDYkc2NDA0LzRPR3VnOWpaVm0rQ3RXclBrQnFsMXk3VU9XdkxzZW5mRm1a?=
 =?utf-8?B?RnRlRWdpdjMvQllYTzZUd3JUVGR6YUNnOVEzcXRTWk1jTlpsRE9uUmIvREVy?=
 =?utf-8?B?YjBZNWpaMnEwWjZOa3ZMYVo4OFZWenpSRGZHc1J6T1lOaG02Vjh0Vk9xSlBs?=
 =?utf-8?B?YXBSL2hqV1I0Vm0wZmR4Z1BtaFJaMmpVZWZaT1c5UEJPaDYxU09EbmxvK2U3?=
 =?utf-8?B?bHFCK1ZJanBBbDVkRGZjMXRVYWx2NU5KN09PN244Um1WMEUzYlZEZDBuQTRG?=
 =?utf-8?B?NkNRYmU2UnppMExvZlpHYkh3di9JckhQRmEybFQrMjgvaEtrdjI4VjIyczlL?=
 =?utf-8?B?SzlzMVFrMWM2aWNCTUJ0RE96Mk54ME5pMjg1aHRmRStsUkZkUjBISFZOVmJj?=
 =?utf-8?B?M0RxRVI3b3pNdlh2MDFZN0dqbDBpZXF3aEppckJCaGR1RnlQbXg1ckU5MGhB?=
 =?utf-8?B?UXRQY3lVTS93dkRjaWd4WmgzdXZmamUrd2NMandpb0hGSVJiSFVtaXh3VzZt?=
 =?utf-8?B?OUhEMjk2bk1hQmhOZUwrcXNtQ2xldjNvSUlxczc0RThsZmVzcDlPWWhTNC9I?=
 =?utf-8?B?Uk1OQVBpWkxaOU9WQ2pXU05aY05HZTdJdjV0MGVuTVVOVTg3a2xnV1dLc3l4?=
 =?utf-8?B?cXBOUWVPcDFQQklxNDFqV0ozeFNrOUZiZkh6Q0N4RHFWRmxSUmwrQUd3cjhr?=
 =?utf-8?B?bzh0NlU1a3RWNUgxalFxS1VieWtYVWRlbk1JdzBRWE1QMUlieHA5M1IwYVZr?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e813e42-58af-4dc6-3f18-08dac197f348
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 14:45:59.3260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53UEU6aBynW7lGLNT/3iHUXFQ5pDKdTSlNkH4XetPDC+RquFtkNHjxFta9f3tiPc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3103
X-Proofpoint-ORIG-GUID: 6EE86P_hRllApdPzRztQo4KxK5lYQWGr
X-Proofpoint-GUID: 6EE86P_hRllApdPzRztQo4KxK5lYQWGr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/8/22 4:19 AM, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> When cross-compiling test_verifier for 32-bit platforms, the casting error is shown below:
> 
> test_verifier.c:1263:27: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>   1263 |  info.xlated_prog_insns = (__u64)*buf;
>        |                           ^
> cc1: all warnings being treated as errors
> 
> Fix it by adding zero-extension for it.
> 
> Fixes: 933ff53191eb ("selftests/bpf: specify expected instructions in test_verifier tests")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Acked-by: Yonghong Song <yhs@fb.com>
