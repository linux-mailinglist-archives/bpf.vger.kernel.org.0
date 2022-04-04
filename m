Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35314F0F19
	for <lists+bpf@lfdr.de>; Mon,  4 Apr 2022 07:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241656AbiDDFvF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 01:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiDDFvD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 01:51:03 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB319FE2
        for <bpf@vger.kernel.org>; Sun,  3 Apr 2022 22:49:07 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 233LTCki014581;
        Sun, 3 Apr 2022 22:48:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+MeANeClrTe4rFDG7PN+itWKgIJHQUmZvmLrkl1jxBw=;
 b=QqvFkHadLmWRbJWU7SjMUBGLgHBOPrHGxuFmT2a31IlEC5LxUFNF0UwyyHNo1lqqiY3l
 Bf+p0h4CWO19Q9+fkPUTAi8qd1xQC+go549IPqrMf76IlF9+oymP/J4cOTRWhVY5bW3C
 itFhz5FP2e2TPGTlPhdFiYy6LYWQtoq7L3c= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f6matykrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Apr 2022 22:48:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsodOqJTal62JAAJOZKiqxku4IfwiYAyZQePAZakdBmwqXjRlOHcYC2jlzGuK6rrkPGnsCRn9kEDECHde2r6YV5oaG58S0bDtFQ6qrjVflaRbWTBcF+5VZ2bbNcc9vwjimktYOItCWpKZjTzXn+yQOkhHWekK5gAtvDxCtC56YO1hh/DgHIQNUraD+Q8dvPYzrmvv4/hLrX8Ci5BO5NpU5IqDs3tOonBlZNolQRVvWIWn02q/qJBEWfQCTXZ/E7e+uOSJC61rF3/CYNYWdA+imyK/JDa6pisZ31s6Me7YtxPiwzq1HqqTCBs0RClungIRlNc60P6/NTi0VHKit37UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MeANeClrTe4rFDG7PN+itWKgIJHQUmZvmLrkl1jxBw=;
 b=jHtYmvBYE1JWXmwFZ2nxHWgJTtndf6VFYuWOxJTdQNDDgMgUuFgZG5ynwLJdWdX9PiWqFzUmI/38kdyHCEJhWjYDJqZ8tvwlKzh6cg4tXceqEK7hoTw6H2HeCu+U0J5++zt7ATkRnDRjETayv/oxkpsMQqtf7lm9la0Y4ryyqSALRH0eOMnvijQnfbFOpsqmyljXgdPZ1OgDqAY7Crr8pjSCZ91KEx+h413X4E9i7hLqRzeUegSJ3z7BunUYMtRJl99so2XVeCzIg/tQmI/JmWO/T7adxIIB+aCkcnOhZz04bfwDZAdujt+0upc7k9EQZ2EyVMoce5cYboSuH4VNYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by SJ0PR15MB4565.namprd15.prod.outlook.com (2603:10b6:a03:376::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 05:48:49 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::5ca4:f6e8:5d75:1abc]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::5ca4:f6e8:5d75:1abc%8]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 05:48:48 +0000
Message-ID: <617fbc23-8770-08d7-a824-67bb5e17fa4e@fb.com>
Date:   Mon, 4 Apr 2022 01:48:45 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2 bpf-next 6/7] selftests/bpf: add basic USDT selftests
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
References: <20220402002944.382019-1-andrii@kernel.org>
 <20220402002944.382019-7-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20220402002944.382019-7-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0010.prod.exchangelabs.com
 (2603:10b6:207:18::23) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07da7a24-276c-44d8-6280-08da15feca2c
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4565:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB456596B96F1695AE85A2233AA0E59@SJ0PR15MB4565.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pC8C76B1gBbZViHA6Bkv8arTsfXpw7oBT5h2mp3DlBw0FxCNWyjQsZr9wzqmwpk7Z9k3glufkFTLZVO67lMsx5jW9Zbp7P7KruhQ9M5CPcAgm/kZcFmxouUH4XvtIKz0SCiMFFusJmvhJkOOmVd46u0lEDaVgCAFLQxjOVCv+6ikwwOPk+4LuHYPmh9mJiszkmpgVMSZG44PUslNr0uyxmg1ZFpB2uK5IS4Z53mrtQ6+Ejvz3Kc8XVZMoL026IhkmNothBjy8a6FBYFWJnu//0wqQMA/ZPy29bzZjN9c+IFRICSMOCmfLpKFSH1oxVnrWyAv3hE+kL37cM+ltRgs5h5EO3wsvEpKHCWTIDApoKDjm+bYNSQyAOelh6M6GAD8GsXHZGILFNQnOArakFORsdPtGAx7l5kFfK7X5fG3sAFTX3Og6yBeB8jIiQozIK4TdzG8agh4feGQr69A3FJxPJtAy8pjyEK0tw+22UvmHNRGuzeKBEI1n6dD7vt3mpf4xIrgF8D75MACm9YCK9npdJ/Y4pXUeMZS5Th29/F5L7mb7O8ji5p7eEQPY+Xaz6Qrqm7d8LpUtIugCNJJVfDfWpJ15iIseZygVriTbXmtnjpuca8+3E17JEHidmI1B1Pseb/q4lv2SDlGnF+z6AXF66H0BhyBdeQ/7+i+AtJlMOrKag4ipwj5K6e5jhMIgvRmZokL8ctRfRR2Wl90t3zJ80jPFnpU7GIGL0OWvSQ2AEhz+x02MNoyDHOHHreWZWK5bXxjjx4z4ZXsSrXkKiN2ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(31686004)(8676002)(53546011)(36756003)(66946007)(66556008)(66476007)(83380400001)(4326008)(86362001)(6506007)(6512007)(6666004)(8936002)(31696002)(54906003)(186003)(2616005)(38100700002)(5660300002)(2906002)(6486002)(316002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGtlaGU5aENMV1FhbUhqTU43WUk5WVQ3ckp5dnhydnRqT2syMVdEV3lmemJS?=
 =?utf-8?B?cGRXWFIxNDRSbFl6V2lOeGFxZk42QW95cWRVWGhlaEhGSmlNRUtuRExSRnlh?=
 =?utf-8?B?QUJqUmZKb2hSWHVoR0cxVkpwUVhmajJGb3AzblVtV0Y0M3hOOVNiR3duM1RF?=
 =?utf-8?B?YXVVRHZwTHpuQXhwV2xNa1pJZHV3TmF2S283RmFXbXRmR01rTHdwOFNBRnpD?=
 =?utf-8?B?eVdQbUg0YitwS1VNU1gvc2doSXZqYlR6S2FkZFU5SGZLOUU1NnowREJuUnZK?=
 =?utf-8?B?YlZxSGE4bTR6dlM5a3pNK29lUzVONSszbVNPdTg2ZXE4cExkb3l4T0FWeUdR?=
 =?utf-8?B?bWQ3em1HUVlNeTVoWHQ1dTdhQVBDUWtsZ0lySEUzQ2g0N0ttUFlLdHpRTHNp?=
 =?utf-8?B?emN5TDZiQzRDNXF2NGhkelBMWmNjUDZOdnUxT1YwMUFOVmlEOUR1dFVWMmxh?=
 =?utf-8?B?RnBPYklKQTlpWWc3Wktzd25Zcm0yS1RTenJUcE0rMUpYK1I3enROaWZEMjI1?=
 =?utf-8?B?VjBFQU5oOWJMM29NZTN0d2pVK2pUZElQWkYrMTlId0x2SGFvZ3p6SHEza2Qv?=
 =?utf-8?B?Q2l6TFp0bGxzTUg4OGVIY2YyMStJZllTc2JwQTJXQmNSekFmdkpIblByUy9X?=
 =?utf-8?B?T1dHaFU3bTZDdUFKWlM3VzJsMFNUYnh1WDF1L1p2SXhWOW9IV0xhTnVyaGhz?=
 =?utf-8?B?R2ZNTHAvT3djV0pjRUg4YW9mTTZLbkhTRDZOV3RtYU5UV1R6ay92ZytPNi95?=
 =?utf-8?B?VnozWnV2Si9QRXdXaDczV2tsV25vdXk3Tk9PNVRnQWx2SDlvYzQrNDBiVEJG?=
 =?utf-8?B?V2VRd3M0UXNhZzFMTmlMemREUTVZeUVNVk1FdEM4ODJhWXQ0djFkTUpFcGs4?=
 =?utf-8?B?d1JmMVg5dEx6NXJJUkFIMUhyWHdmdi92RlV6cE42aVFVWmtSUFRnS3Q2RUkv?=
 =?utf-8?B?UTRTWTBBQlV2WGdjcjM1YzE2Vy9uUmozOEZXVW41MFhJaXdqS2hBKzhjbnQ4?=
 =?utf-8?B?Tm13eThSYmdzanJ0QndxajlrdGNrM2VhdEJtUXpVemdZRGdNVUhPVUUxVTJk?=
 =?utf-8?B?SGtqcGcrK0RxUW9ib00weEk0aVd0dDlQcEtoWEFOZmh5ZUZROXRJQ3czM2pL?=
 =?utf-8?B?WS9RMWF3SXhDc2lEbElNZkxyM09rLzlXLzg3MFlnT2hIajR3a3Z2TnBMK1ND?=
 =?utf-8?B?MlBWRElnTGRjdmlwL1c5VDZRVUo2dHQxVHV2WWlvRjZLWWZUWmtiK2k5MHZH?=
 =?utf-8?B?NmFQaGRSOTdMSVhvbDlhZkNIaW13OWd0UW92M29zTlA2dkxZYis1U3NhOHZK?=
 =?utf-8?B?Z3NGQUdmWEMrR3BrUWdFaWJhZDVPS1MrSW5JMy96RE5ZeHRzZzdQN3kxWkFj?=
 =?utf-8?B?ZTNWZjBkMTNlQ0o1bFEvL2w3N3hKdkxNTzJpdjZpaEd0d05JTllBZmNraDlJ?=
 =?utf-8?B?UzV0Rlk3akxhNFhIaFcxRzdHWHBaUGRLUDRHY09TOEgxWGdXUjgyMHVPOTlL?=
 =?utf-8?B?eURFWU9zMFc4aGk1aUFjWGZ4N2dlUy9YR1RXcEc3dE5GMnZNWEgreWZWT1c2?=
 =?utf-8?B?RzVSRURtNjFHVDdOWHZlWWRMYnFIZm9OSjdTNGZQV0o3VkZEeXYxUkhpczAw?=
 =?utf-8?B?RXVYWWp5cTg4UGFkNktYbXlqYzdJZUpreFh3SWhVTlZtc1pjUkxlanhtcHdx?=
 =?utf-8?B?bmRFdUpoNGpYcXVxUEpjTGw3cTZwdkVvWVQyeEtKZHlWSUEvZ3NQWGh4V1Vz?=
 =?utf-8?B?dW9PRUlmbmRLeXhVbTVyZFFTSkgvQnVaZGNBQTRLd1haa0RkeFpaNUZHQ1VD?=
 =?utf-8?B?dTRqNVk0bmFLSHpqRFNFUGFnT1NqbDJIallUQzBjQ3l5cDl3VE1xN0ZtWWFS?=
 =?utf-8?B?Z0M1UndWaHFpaHZRTURVNnlqUlFyYzB2WlovdFl5SE9XcFNDU3Z3SlI1K2Nu?=
 =?utf-8?B?YkFrb285Tk0vRXhXbEVsYVdXbE56dG5HVHBST3V3T1Nsb1diOWtxOCtvZUJD?=
 =?utf-8?B?MURBbzM0S0E0cVZESlJock81SmgwQUpHcGltY1RLaGdQQjRzSWFubEhrM3ho?=
 =?utf-8?B?U3NKak1BSnhabFJMSHVLVTJsZWhnSFlwTThidk1QTVJyOE1Zc04yYVd2ckR3?=
 =?utf-8?B?cWsrYXkvZVE2WHUyUEg3WG01MitVcEV1STUremJxTVd5eXpzZFl5OWJ2NEZV?=
 =?utf-8?B?TUlQTmVqTFkwbmUxNVQ3V0RkWkIvL2Eyd3VpL2ErRkwzbUYyT0lMVjRqZ2dC?=
 =?utf-8?B?TXIzQ0hhaXdKN1hDWjhicnRGMjRIWHphVjlEWEE3c2dHanpEU1h1cWFOVkdI?=
 =?utf-8?B?ckJLMXZ4ZU9qa05HQmhQT0JkVDUvL095b0NiN3dmamZLV0NDM0lFbVptbTdC?=
 =?utf-8?Q?P8J+kZB+rRnYAahF2G8TsFNQQs0TxsHB/4Eo9?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07da7a24-276c-44d8-6280-08da15feca2c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 05:48:48.5546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8cPZd880KbRH+5gbRgCtUyq5dN+JhzqlAOMcWUzKDMiSipYmqcU8b0HoMcmFidBkFKneRD+QNQ6T9dG1BK8hIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4565
X-Proofpoint-GUID: TB8O32NQmB7may1rAnzJLNIepJNImJTp
X-Proofpoint-ORIG-GUID: TB8O32NQmB7may1rAnzJLNIepJNImJTp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_02,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/1/22 8:29 PM, Andrii Nakryiko wrote:   
> Add semaphore-based USDT to test_progs itself and write basic tests to
> valicate both auto-attachment and manual attachment logic, as well as
> BPF-side functionality.
> 
> Also add subtests to validate that libbpf properly deduplicates USDT
> specs and handles spec overflow situations correctly, as well as proper
> "rollback" of partially-attached multi-spec USDT.
> 
> BPF-side of selftest intentionally consists of two files to validate
> that usdt.bpf.h header can be included from multiple source code files
> that are subsequently linked into final BPF object file without causing
> any symbol duplication or other issues. We are validating that __weak
> maps and bpf_usdt_xxx() API functions defined in usdt.bpf.h do work as
> intended.
> 
> USDT selftests use sys/sdt.h header provided by systemtap-sdt-devel, so
> document that build-time dependency in Documentation/bpf/bpf_devel_QA.rst.
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  Documentation/bpf/bpf_devel_QA.rst            |   3 +
>  tools/testing/selftests/bpf/Makefile          |  14 +-
>  tools/testing/selftests/bpf/prog_tests/usdt.c | 313 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/test_usdt.c |  96 ++++++
>  .../selftests/bpf/progs/test_usdt_multispec.c |  34 ++
>  5 files changed, 454 insertions(+), 6 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/usdt.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_usdt.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_multispec.c

[...]

> diff --git a/tools/testing/selftests/bpf/progs/test_usdt_multispec.c b/tools/testing/selftests/bpf/progs/test_usdt_multispec.c
> new file mode 100644
> index 000000000000..96fe128790d1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_usdt_multispec.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/usdt.bpf.h>
> +
> +/* this file is linked together with test_usdt.c to validate that ust.bpf.h

nit: usdt.bpf.h in above comment

> + * can be included in multiple .bpf.c files forming single final BPF object
> + * file
> + */

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
