Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00BA3DCEBC
	for <lists+bpf@lfdr.de>; Mon,  2 Aug 2021 04:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhHBCoi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 Aug 2021 22:44:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5454 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229915AbhHBCoh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 1 Aug 2021 22:44:37 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1722f7TH020592;
        Sun, 1 Aug 2021 19:44:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=g+FiLvTo8XU/yEmkTs+j+LC91FGGxrZzYNfFlZVnn1Y=;
 b=OWhqbBNQgyC4Ax7g0cDq9JXawEcleH8HmZiTUFYWRJQCaOGEqS/d5oFfVkdheF2CTt1R
 tpQuQefCqOnALj/PJyUifuBUxnYQpOhuo7RhmeWT1VAqesoHfW/kdVVzUC8Nd4Nt5irN
 uu4f7vT5SW6/X/ht1e+qcrSkXbdG60TSrOU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a51ut6tu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 01 Aug 2021 19:44:15 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 1 Aug 2021 19:44:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuDP+r9lmXH6alhW/C/sqBEjNPfb/rYnH/tA0PN27+7k0YSsz12NGCpLkPhsMRf88lvIdrsUUPeXmb+GOD9/D/Qxil1FXwm4iX1J/DXC1Mkr/W4qCx8k7B+jRF6SlWW5LpOZKSAgtk9PAxb+kvrVmdxm++KSwt+hudhyrIB3xI0r0SvAyVJkmSueO+j5AWTDfXVWsycCprD6Vt/mHcNZtZ0qL1L2641tLEPrQ9adTstY48m9jinzOw0b4vI1UYi9rB8N8Ux2c/h5apvsI+b3nsbPubbXnyrV25xV53cvsCLF5+t2m3phGTX3SaD3K8/B/aFj0gzcv5gMobEtXmaFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+FiLvTo8XU/yEmkTs+j+LC91FGGxrZzYNfFlZVnn1Y=;
 b=lTTnXp2yZxhtULs7HVaQX5dbqI9HscuXJoRDLCW1LeJ7XaFWeuBvnWv1+n8WVm0dBbZOFswcHEMWkvHEoGBi0OrOoiYQRU+AgEnz2cMTu4p9ZXAI4eA5mcmRwVxBkgk7S1K2extFigInsZBuhWqf15Nk9vQ6EjbFKPd8GGmzLUsVysh05vwFKtptczwFNshVICC/sZNuXrdn4RzWy2P5Wp9i8CqKUMTvxnHWhdMEQ35eLkzYMiM7vHXJE+insy1WQs/5JcrFcfx4xO+gMqq1dDfmfHKG1GcFMf6nqcn5YoF+C2GVYL6U28eMSAkqgpAdPdSDKJYH/9Pgwdc5DEmxog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4223.namprd15.prod.outlook.com (2603:10b6:806:107::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Mon, 2 Aug
 2021 02:44:13 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 02:44:13 +0000
Subject: Re: [PATCH] selftests/bpf: Test
 btf__load_vmlinux_btf/btf__load_module_btf APIs
To:     Hengqi Chen <hengqi.chen@gmail.com>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <john.fastabend@gmail.com>
References: <20210731143244.784959-1-hengqi.chen@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <ac1139ff-0680-0aae-550d-3222fb4c4710@fb.com>
Date:   Sun, 1 Aug 2021 19:44:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <20210731143244.784959-1-hengqi.chen@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0306.namprd03.prod.outlook.com
 (2603:10b6:303:dd::11) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1130] (2620:10d:c090:400::5:a39) by MW4PR03CA0306.namprd03.prod.outlook.com (2603:10b6:303:dd::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 02:44:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caa4dd1c-c1b9-456c-dc18-08d9555f6998
X-MS-TrafficTypeDiagnostic: SN7PR15MB4223:
X-Microsoft-Antispam-PRVS: <SN7PR15MB4223593F8AC708174CF53FD6D3EF9@SN7PR15MB4223.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8DftfLRpyOwT/NiugFgw9nrZA4rqRDOSWMc89aYpaJLRiodrhB7mrcuXJ5riPk9nuQ3FIfWLm/nWJxzGQV3XpqAKS1erJ5pZRQOpc1vP8cL+AQ9zwPiSKY+0FfCYZgaRn32GA+0IYGq6WmikPInzKAi6YV2yWiuY64sOq+4MWBEitv8LxWGqUYpCB9VGDHzm6B8C1gCwVwrUA8ecmDvG8j3ONtKTApoRU4EXUL+s5h8ysd1O74F5QN6hdWrMHywc2pf5Vu1bYX5iizsoBoPXngz/GT8PPuewwA3s4AhAXhiqAHHvByytYb1jpZmGZKUjGXtRreFOoDhhOm+pq+/LuXMcCSYnL3DZA31WbggbW58ROwEuQUwpIgt01xCeExxEoHFzd0WovnN60IcvvCfkrLDwYkbbuV0XHYIrRIU2Dwj/xqBzjDXzwB5EdCHpKEd94fuzUfUuJDdL7GUSPqH5y1S0Ra1RH5r2Runto+r/gc+uHWAOpomy3n78LxMB6MtWygMxdTzOVgP5oIiqEJY7+sPnarCLNp5S3B28ztm2stNH5ZcfhHbP9+kXPeHRPAaP0+98RF5T22VMYMLLqO3PfGTeHSe/jYGgRa04PYn8nM90+w3n85s7Y0mAixOkjKIjpfl/G9Ln/YW82tzLJ+scx8nEMyvNTcg9V/Y5Uqs1x3r69xbVl58I9ocpi0v8Q9VIrceMvcb9h2nqD9fNShVAkvrFXDl6u0QtatoQUJT2wDStnKuDGibCPyC1Xo/TXkHvoBOL8XmS78aJyvpwDYSGcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(66946007)(66476007)(83380400001)(38100700002)(86362001)(36756003)(52116002)(66556008)(186003)(5660300002)(2906002)(6666004)(31686004)(2616005)(8936002)(6486002)(53546011)(31696002)(4326008)(316002)(8676002)(478600001)(101420200003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEJ5blVXdUJxT2ErMmNsSWZTMisyaG9uTXVDYTg0QXVoM2pZblpqUTBVTklF?=
 =?utf-8?B?M1JKMmVtakJJeDRTdnp0NDQ0NHNrNWEzVTlMdW9MUmZGQms5RXF2TG9rbjZh?=
 =?utf-8?B?OGhESTFaemdLSUVaMHovTG02ekxkV05lUEFFTDduTGJtcGZOVVRoUWw1U0w3?=
 =?utf-8?B?blluOG1TT09yQkJ6UzlSbnRSeGVucThVNGI4RDVON2pPclhYNUNJRWpsWnhX?=
 =?utf-8?B?SjlTY1lBSjBzWVlZNGhLbG0vRktlWG92Z3dJRzhDQkp5c1lYMjdxaGxBZUt5?=
 =?utf-8?B?Z0IzeHlBdWRwVCs3OEdPRGEzcXZsdHhMTXk1dlVoRkd1S1cvRHdFLzJrODJ1?=
 =?utf-8?B?bHNGN0RSUmdMQWo3OWFGL3hFK2pQaE05TFFIb2tzNlZNNjBZVUhjcTQwNzZK?=
 =?utf-8?B?RDVkUUZFZ2ROazV3NU14WmNNdDJvVU9WQkVrdDJMQVJTNDlDL0Q0VnVnOE95?=
 =?utf-8?B?cjZkTFdKTk0wNlhHV3JUeE1oNjNyYWNUZG1VZnJWcXlZdStxeE9Pa3lFRkJj?=
 =?utf-8?B?YjZjU3VNaC9hbDhRRU1kN2thRWVhV29kY2x5dDBneFpDYldjUzVKVjVieHh5?=
 =?utf-8?B?RW5XbVc1eTR0UEVBVlcrLytZWmp0M2p5OEM4cmthK0J1clpmcEl0VVNYaUFI?=
 =?utf-8?B?dnlpdklZdEdkOVB1ME5YUGlOVVVCRFpoS3pGOG5CUkxFMlFFb2tFNUhGT3dE?=
 =?utf-8?B?YjlJSlFGZW5DWW9valN6d1RtR2Y2WG9LalRSZ0h5RVE2ZnZMV29nV0hwTG50?=
 =?utf-8?B?MGhNZGdQQW1Uc0g1ekltckR5TTI0UFhneGczNnBNYmN0c0JqYkYrRGViNzJB?=
 =?utf-8?B?MWZnNjB6cjhIbTVsQ01SNkMwVTlBNXVJVjBUejRMa3lnQ1lOYVg3b0UyRUtq?=
 =?utf-8?B?L1NuN0krRzdaZ1lBdWZpWjU4SzNwTVRMdXBwN2FmcmdZV0Y3eWhQWFBCdTYw?=
 =?utf-8?B?YWpzVmgvd3JGUit5Mi8xdnhsVEpUa0hJRVgxaTJTZUJpVlBSaFd4ditSbUUw?=
 =?utf-8?B?SmRjWjJiU1Vlb3ZJNzNndlRvdUlvT29WUTdLd0lwaEU3ZStGVWFWcERNUDc5?=
 =?utf-8?B?eHVmWm02UU1Oa0dMMjJQSk1TUGxiRTFtZFdKR2dpUHFMTVFPeGEzUjNWdkM0?=
 =?utf-8?B?Sno4U0pLQnN6Ni9nbzl4WDRwOE5GYktTM1FHTEZPb3BIMHQxd3BpV3FiYk9G?=
 =?utf-8?B?ZW9JbXY4U1lYZW02RTdPTk5YRmhTUnc4OGUrVkZPdGFFcUhjT2k2UDJPNU0x?=
 =?utf-8?B?anlpeWprUFp3UTVucGdxSHpHTGY1ZHcydE9vbi94NTJiVEZnNTd3MHBmVEd2?=
 =?utf-8?B?eDdQbFUxaFpQbTk0bFdtYUo5R20wNW5QUjVMT1FWR0R2eEQxR0lqTS8vVitJ?=
 =?utf-8?B?a3o0OGhXQzBXVmRvTkdMbmhZYlBUemhEcHA4QW9rRVFWeEtVcXZlZTBsbVZS?=
 =?utf-8?B?Y21aTlN1elZOV1lCc1MyYSt6d01DMFlCbzVhMjFaK1d6TnJmQnBwTGFXOTIy?=
 =?utf-8?B?R0VIKzdPblg4UW9aQ0RjQXFjdS9uS1I4ZUJwMHZxM0RRQjVYYnp6YWhhdS8z?=
 =?utf-8?B?Z3oxRkZOdDB1OVhJVFU0THdqYmhTbytDRlRZMFN5bHNEK1ZUaEFHOTF2SVBq?=
 =?utf-8?B?bTU0VWhiY1I4UkNWNUh2MWVBNml0UVRSQXZzZitGVHZmTVE3N2dONVBZbXVk?=
 =?utf-8?B?YUI5NktDK1R4SXEraURRdS9rZWdIUW5DOGFPVkwveW1kL1ZJQWxySklKN2lM?=
 =?utf-8?B?UWlIUkZqT21XTFowRGJja2RwQ1BsaVBUeXdWL2hxMzBnaWprOVB2eTI4enBu?=
 =?utf-8?B?VXVHZUFqbjNiN1NLWENQZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: caa4dd1c-c1b9-456c-dc18-08d9555f6998
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 02:44:13.2474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNlN5bsGIzhAy/DrDAXh757fntTl9PBSIrRev3xsSFTkNM+YvobOcjuYP47ft1sP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4223
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: ja1q89L32M5hRCFcdFdzf9XJAeRCxLf0
X-Proofpoint-GUID: ja1q89L32M5hRCFcdFdzf9XJAeRCxLf0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-02_01:2021-07-30,2021-08-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108020016
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/31/21 7:32 AM, Hengqi Chen wrote:
> Add test for btf__load_vmlinux_btf/btf__load_module_btf APIs. It first
> checks that if btrfs module BTF exists, if yes, load module BTF and
> check symbol existence.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>   .../selftests/bpf/prog_tests/btf_module.c     | 31 +++++++++++++++++++
>   1 file changed, 31 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module.c b/tools/testing/selftests/bpf/prog_tests/btf_module.c
> new file mode 100644
> index 000000000000..cad1314e3356
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_module.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Hengqi Chen */
> +
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +
> +static const char *module_path = "/sys/kernel/btf/btrfs";
> +static const char *module_name = "btrfs";
> +
> +void test_btf_module()
> +{
> +	struct btf *vmlinux_btf, *module_btf;
> +	__s32 type_id;
> +
> +	if (access(module_path, F_OK))
> +		return;
> +
> +	vmlinux_btf = btf__load_vmlinux_btf();
> +	if (!ASSERT_OK_PTR(vmlinux_btf, "could not load vmlinux BTF"))
> +		return;
> +
> +	module_btf = btf__load_module_btf(module_name, vmlinux_btf);
> +	if (!ASSERT_OK_PTR(module_btf, "could not load module BTF"))
> +		return;

Should we do `btf__free(vmlinux_btf)` before `return`?
 From implementation perspective, maybe use "goto" so we have one
place to do `btf__free(vmlinux_btf)`.

> +
> +	type_id = btf__find_by_name(module_btf, "btrfs_file_open");
> +	ASSERT_GT(type_id, 0, "func btrfs_file_open not found");
> +
> +	btf__free(module_btf);
> +	btf__free(vmlinux_btf);
> +}
> 
