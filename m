Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BF7494645
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 05:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358403AbiATEBc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 23:01:32 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30718 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229787AbiATEBb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Jan 2022 23:01:31 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20K3Ejic021017;
        Wed, 19 Jan 2022 20:01:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=LBN/7YPm0w2Lyk2V8CyPWm2DrTWXgSXGtP+jAs7mEo0=;
 b=llOB5R4X4wcItMaMqUbQuB1qmoT1Acbza7RLnOJPfYy9wShJhe48ArYRPvy0sIJkGL8L
 MDuy5Mlaae0nNXuhj5uVp5atnWF0+NXzCgmj5MjqHP3Zk3/XxyVfAeAeYL9batzDI/bM
 GIe2p8GxpRQfN1nk5vxM+GXUDs3xXCwK6TM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3dpynj854v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 19 Jan 2022 20:01:17 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 20:01:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rzq10yCl8Fn7tW9uEcfYCQ6ao5WTah5dy4CoSXyn3G1gvH5X8/NrCmC/wRslAliV0x+aWX4M6mircEV5+fftPJOk9khKdLzj097vaAmnP9jwj0EvhlQNPPgw5cEU6jAPDaT1z+y6fgkSqr9cH/ummBjRl9ENLbdrkiOyMXyPZYALD5b/a4/58R2u+8qvVGTlN2yOqTFFD1IHB8Ar04bvNmuTEuao15AbHvO0AJe6k9bT/09Cj5JxHJsquswE7mniYf78vqcdY8WSxsDmYzhjYw8gm5ldvLuGcjrE4xrrJsnUzXCeJ10gqYDW/+wG3K6d384Zs93Wp/OFooRcM2qSvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBN/7YPm0w2Lyk2V8CyPWm2DrTWXgSXGtP+jAs7mEo0=;
 b=mgozEkvs05OmvV3A1YE8p7a5aomhPg0aigSwMvio+K7pGhq80vsX9DV02tq1CFBkMgay7yVAMK21o2sVkrHsN0m0YXT7j7SPQCMA2vBaab+Z6UGobqAUVDInXbNoDak1H1McU2+ENRMoL6mSDT/3yAmq/M+f1yDJUuloqIXyq8TWbo/22II5EhUNAKzL6lNeuzigrAfzF4Du5mhBrapqiIXP5lHR0HjkhU75ukJo4aX77YU+Js+TLcKYfH2eIqcTzKo9PEf9P4quGj/5K4gRiWksHHmzCUAy+dd6Zz/dzFChsDBufBMNgHKC4DYa8qHSjPTIlU3nOaxwIWkUk6D1aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by MN2PR15MB2623.namprd15.prod.outlook.com (2603:10b6:208:126::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 20 Jan
 2022 04:01:15 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::4033:8a7f:ec29:93f]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::4033:8a7f:ec29:93f%6]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 04:01:15 +0000
Message-ID: <f826dd2e-b97a-7f6c-f725-555303f02e27@fb.com>
Date:   Wed, 19 Jan 2022 20:01:10 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH bpf-next 4/4] docs/bpf: update BPF map definition example
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20220119225741.2944240-1-andrii@kernel.org>
 <20220119225741.2944240-5-andrii@kernel.org>
From:   Alexei Starovoitov <ast@fb.com>
In-Reply-To: <20220119225741.2944240-5-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:303:83::20) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3d801a4-c158-4777-858d-08d9dbc98107
X-MS-TrafficTypeDiagnostic: MN2PR15MB2623:EE_
X-Microsoft-Antispam-PRVS: <MN2PR15MB2623F3356EE0383BB2E87B9DD75A9@MN2PR15MB2623.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jemOtDpgZCMfryMqF14KbIoDrdgqa1kM01QuZZL+TgCu0UJjxJ28oTePpeZ95nzUM/0w8vv5/SxgaIMIAsyBVUP7iWfZMMI9334E2k+FuBbgy3KQ2admXmr9XGQLtowDvr+vSE2/QToQBCVgzdHUeQ6Gia4vrwAMcxxGGIGwlqSa/sqx1MBew4QrwrScRwqeE+3jG/DHFiRtJAmDVVi3znYfmcYXuqSHny+tpZRTk068ZT8xUG7FwhH/vfoewm0seXq14iz3XvKJ913symYbinvp3BFvi2anuOWWZAJXewTM/f99mJXyzV8CUW8UobthYoci2w8UqiknOmjqDJJEGCgxCzM6PrVw4m/Sn4/dhhISCpeyVOfV3sv0idkGBzkcgtT0BzMHtivKqgDbEGNHByp/K3fevznz8DZrnM61ku6ooUKANkWuueGoWerhOzxAifCX94b5xhiTTY6e1VGkZ3dkjj/FKAUkWkdLNxGhNM6++2OOMJCDswbSc7JShIrhpnIYL/7fc9VpHSMBPclAzdPVooPnmhO1T1PwQ7ZA16eksPq3y/y8pgbwH9sBj7u0EfRSQGB8YvgqgiOFO8uOFN3BrqrnSL9gxSLmdnIFOj2VuY5d9fGMaBNgH5wx1nv/11SnvYvw/7AnBdxWZGGY+guOyBGnA8fdqoa2Dw0UCyo7AZJv3i4NkZ0Q2JnHEI/Wyp6aoB2t0Wb20WaqyWFwof+NE5oUctiM5btQt7nZbcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66556008)(83380400001)(316002)(2906002)(508600001)(2616005)(186003)(36756003)(6512007)(8936002)(6486002)(86362001)(6506007)(53546011)(4326008)(38100700002)(31686004)(66946007)(52116002)(5660300002)(8676002)(6666004)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkJ1K1FDRzV5eTRGdDhFdWczN1FsMTFkOWdqNS9ac0oxUXNaMU5vRm11N29G?=
 =?utf-8?B?ZFBZMEFpSDJPcGNzeGJmeWF6VVNIRnhOQU5kYm5MSE5qcHZqOXU3b0ZmYTVx?=
 =?utf-8?B?M1d1QUJSQlBaUEk3MEN4eTA3SXhRR2JCZGtSbThkVUxuVUpNamh3a0pJUE5Q?=
 =?utf-8?B?S1VlVm5wWE96d0xZK2pjSFVHazErQmcrNElCUEVaWktCSkJrNCtqSjZXbjhV?=
 =?utf-8?B?SjFENUdqUlh3Z3lNUVpocDBiZzR0N000d2krbzVIVWV4NlROdUU3c1ZXNUdp?=
 =?utf-8?B?Q0prRmpjdjBJeWMrRVFNMkFGSUVwV2hHSWZYSVE1SFQ4dzhTV2s1cFd5ODlV?=
 =?utf-8?B?TGN2K0RuMDRJbklvRCtlOHp2VmNMTnphTDNpeGxGRzloWUQ3OVdsbFZScDZT?=
 =?utf-8?B?ZHFCR0czRlIreWtTajF1YkY4aFNudVZaSEhiR0tyN2NtMkRUaVU4ajFwNENj?=
 =?utf-8?B?YXVWUGl3YkY5YUpHVnJmUTlBbVAzOGFrakpzMHZvdkVYOGZabWViU0Nqam44?=
 =?utf-8?B?UW9vVUNzeU9RZUJzay9JQUJrT3NLRHVCRTJMV1VzNVUyclI0Yyt4OFBUTWxN?=
 =?utf-8?B?OHBuaS8vNlo0MHdHM1B0QUFmeThoSWx5UnU3UlVUOXMya1J5ZS9vZTZlS3BZ?=
 =?utf-8?B?dzZObEEwSTYxemY5cmwvN0VnbHFseUJ3ZlkzNWwvM1hPNzYwUW9qRzRkYmQw?=
 =?utf-8?B?Zm5nNVpUWGRZYW5JemxVNkVEUXFoemNOWTJrT2RUZXl2Q091WHBFcUJjc01C?=
 =?utf-8?B?MHFlY08vSHdFNWJqTm44c3NYU2VVYUlNamd3djhKMVhXUTNhMUxQU0JPY1Rh?=
 =?utf-8?B?UjlFOWk4bEJ4YzdRUm5HOG5PMEdRQzkyTUNCbG5JSTUrM0dqMU56eFNXUWNr?=
 =?utf-8?B?YUtwUW1mSFhjTzJVZTRmQm9KM1l2QVpuTmwwbFRQM3owSVNuQ21INzdkbkFK?=
 =?utf-8?B?c1BYSkl6KzZ4MnFyVVNFS0IxbWVHOEV2aHA0NTFLVHBlY2MydlNBQm52WWtr?=
 =?utf-8?B?cFpuSWRIVXdCcm05WDMreThNNFhHK0h4bXFjOFdGMlYvSjNzbFM2Vzk3S1JO?=
 =?utf-8?B?aG1KNUdJMi9SYk9QTzFYUDN0Z2lHQmo4cVZJZG1BZFIyaks4NXd2NFBYdHBN?=
 =?utf-8?B?RGI0MWxRa3AxV2ZqNVI3RE81Rlh2S0M2NzhRSDd2RlBwN0FDZEZZalUvbEFH?=
 =?utf-8?B?cDVWdjVwb1Qyb0pDVEZDbXhRcnR5NUhyMXhlWXBBT0hoeEc4RmsyS3pocVox?=
 =?utf-8?B?TGlhWG9iQkxhb3pPUU9LOTA0TXBDeWV5WkZjUnZqaVR0U2pTcE51d1hzNks4?=
 =?utf-8?B?c2V0NEYrNXZEbklWdUhHejhmUnkyTUZSbWlrblpqOUN3RDNHQy9oTFQwTVo4?=
 =?utf-8?B?VkowYy9vWU0ydFljM1dCUml5bVNNeklIVVZhWGFBbzBUSE5Jd0lybzBCMmdj?=
 =?utf-8?B?a1VxUEJsZ0l4eUtDaVpEaWdnclU4NVZySlBoNmVLQnB3dUNseStvMUx6bU95?=
 =?utf-8?B?WDBWK0VsdlZLd05heGRMR3NOR3ZmRzJMVWZQWnpoUWROM29ENFVmSWRZRXk5?=
 =?utf-8?B?UnNTcUsvOXVQZ2NSbzVvTklQYUhiWVNkZEJ5VWx5K3lDOVJYR0tLVERSNU5h?=
 =?utf-8?B?eWNBMUdDM21RSkZBVzlNY2prRjRoMWRaOVYzWGNXZ2h1cEhUYWdqUmY3Ym5x?=
 =?utf-8?B?L2M3aXJraW0vWXc0S3QvYWhsNTZONVVhZEtpUVJJWng4UFR0QUZXVm5jRm1V?=
 =?utf-8?B?ZzBXbU1DV1c2cklzVGxyTDVFTi84cHBEL1RPVG1DWVRLdlkxVTBhNlRuQW9W?=
 =?utf-8?B?ZENJeGY2T1VXaHJxZ1VuTUxPS3lacGx4RVZUN3Y2V3drNCsyYWUwZ2x2ZFZw?=
 =?utf-8?B?OWwyNksyQ1FLSUl4Nm9Nd3dMbnJQVTZhZGFKZFRsQ28vNnR2aU9wdHUvRmdK?=
 =?utf-8?B?dXdyYkcxTTZHV1lHcFY5dEpzTC9BNGtzZ3NKeU5ob3VJOUt4L2VhZE13YkR6?=
 =?utf-8?B?UkNyRUtDaC8vTmRUSC9BTWc3MWJFbWdJbFZVL1JmV0lIWUw1Nm8zQnN1enBz?=
 =?utf-8?B?aTR6WHVDb0NqWURVdDJVRlkxbXFjK0wzcFlkZ3o5eHJNTjJqVnFiWi9kTkZu?=
 =?utf-8?Q?ZgRl1BtmF5SdpQpKZP8Rgzynz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d801a4-c158-4777-858d-08d9dbc98107
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 04:01:15.1642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q11r9LDA4eFzqg+JViJaoo5JnNIV8Lo2hicjk6vDR6ugAaT9hGXwAIAyXX4Pct8H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2623
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: hcxjO5rmjClc3kY9LrqLjw47iMAHj4AL
X-Proofpoint-GUID: hcxjO5rmjClc3kY9LrqLjw47iMAHj4AL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_01,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1011
 adultscore=0 mlxscore=0 impostorscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201200021
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/19/22 2:57 PM, Andrii Nakryiko wrote:
> Use BTF-defined map definition in the documentation example.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   Documentation/bpf/btf.rst | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index 1ebf4c5c7ddc..07165682da2b 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -565,18 +565,15 @@ A map can be created with ``btf_fd`` and specified key/value type id.::
>   In libbpf, the map can be defined with extra annotation like below:
>   ::
>   
> -    struct bpf_map_def SEC("maps") btf_map = {
> -        .type = BPF_MAP_TYPE_ARRAY,
> -        .key_size = sizeof(int),
> -        .value_size = sizeof(struct ipv_counts),
> -        .max_entries = 4,
> -    };
> -    BPF_ANNOTATE_KV_PAIR(btf_map, int, struct ipv_counts);

There is another bpf_map_def in btf.rst.
Maybe convert it as well? Especially considering it's an example of
BTF enabled pretty printing.
