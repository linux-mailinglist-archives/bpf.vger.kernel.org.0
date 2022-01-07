Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA8B486EEB
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 01:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343870AbiAGAgR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 19:36:17 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6604 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343832AbiAGAgQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 19:36:16 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2070DYLV031032;
        Thu, 6 Jan 2022 16:36:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=mWQcx3vP/G9BFVhZvhE9OJr1xswbGEjQ83fkTZpxsx8=;
 b=pqMxUWY2sgUSCE+1x+g1fcxu/xBiuqjDW80xEquNRhXYlQxz4DzlYO0I/mDBSj4iKE9D
 DmrWkcEX2Ww+ugpCbHA3+8z/WBmCbODQq3jplYW+E30H62RyQX08x61Zy0L5P2gTkYuW
 YyEYILqnJ/DUDgIR1dVVH6n7nvYkXwnFhkU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3de4vvaenc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 06 Jan 2022 16:36:02 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 16:35:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1G3Md/JdlT9JaDB3SmsKaWYYZ5M+LlnoXIIGbvAsGGP6Sop8Zz4Ll3teG9LnWrCV4ooGIW/baD9vDM+1cCrZEIZtpR/51nqnMCdURVSzh2Ei5Ve3dMA5Mru2Bo6Vg0k2fV6zNqbc1XMpf2oqjd3GuJNdw4kGj1hAVMVs6M10u/2UPJDJqJjuMK/rGvltOtvSHDbV8LASfsJ+0k/HHXxX4rAWk3d3xHx8m7TLNsDruA1O63Pp0j8+mxaKnEyWJ/cZ+RoKITN1Q3+iwcs0y1nyM+00OTzaWFDxqSRZ0xPw78US0VuaNg0ciwKmWo00N/e5R1iYEMc+WYzbk2nqGM5/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWQcx3vP/G9BFVhZvhE9OJr1xswbGEjQ83fkTZpxsx8=;
 b=Z8SJBednNJW2g+f5XJAH1Lk84iteNCTPx/jqIj1bRHoBR/59Z3MBUwzOIp9uiDNXjwC7pVCSIrWDTW6aX0DOM6G/rzIIbY6f1sOhXuflDQSx2luXCFugi2FMbJFYPJaAOo+e7q89KMfbsOZceLprwti2k5B0yfk8WShP5WkSH2E2hNWAwtUHPY5+VCHc03ejSrZTH1EnBWEJSQ1vTD/UbwMgYlC75uU/G9EK/Gy1rA7IJktyEU9wOpMv+1C2yh7HLi0K7UD7NP2KtS6TDzojDnFpdvkCll6zX9hAFqeePTPBxEvIOGMyfimQBlRoYnIQ+TMWZcuYirnOde09wZp90A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by DM6PR15MB3797.namprd15.prod.outlook.com (2603:10b6:5:2b7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 00:35:54 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::8988:8ab3:bd6f:514f]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::8988:8ab3:bd6f:514f%3]) with mapi id 15.20.4867.009; Fri, 7 Jan 2022
 00:35:54 +0000
Message-ID: <653e9ca0-7783-4ed8-4762-ff736d5b599d@fb.com>
Date:   Thu, 6 Jan 2022 16:35:50 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH RFC bpf-next v1 5/8] bpf: Introduce a new program type
 bpf_view.
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, <bpf@vger.kernel.org>
References: <20220106215059.2308931-1-haoluo@google.com>
 <20220106215059.2308931-6-haoluo@google.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220106215059.2308931-6-haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:104:5::32) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec9e7dc1-5dbe-421c-235c-08d9d175a9ea
X-MS-TrafficTypeDiagnostic: DM6PR15MB3797:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB3797E4C9F21D8310252C6D97D34D9@DM6PR15MB3797.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2BqFrgtdoSQjp4SY/i78aohmM80xNXic/LACwfUE095aszzlY+w+QCSsBJBuTtHKG8z80sNg2bTbtzuNXOQ8X87bh6Mrkl2YmNVGI/suKmaidBE4wYfxS1aqSZNlzO8CDXG2IYC5opd2bnABQsuvkzA2EisLoIH8AisGoFMx4DrswFNoTUwo5MHnOl/MZ9kn70iPQps+uaGlqm6FKKKz5pY9Bra3GYBCorfqzjDjO6DIyYjKwDT1jNfdJ0Z5BcroEchZuZwUCB2FhpiiSE7WK0TGtL7vziwL6Co7fjxT2xsWktC3Xf9xnJdRKHj79eFXYF5pCSHxOrLf1n90wtYxfPqnyu9HjHa33GdzF4suOJ+mZt+j9RL2sBEwMx+dJM5hp/WERZdDQ1eg9xaoZgCJ8UfNKQhvauYwHlFLvAgN4Hf1crQ07r59Xo/SAbhH/TYjtyr5bTvYT+RNXbPDEUlwGxOzEv7iI2X+hKVQIr5xd9vad1WCHPrlqLjzQfx0XWvMz2VW3FrP4bC+1xAf9eM9C9D4M+jnlvDwrtI+/dInM0STCqkOfS7yookJ6kMYHamABPKpFJ1wPcR5E1vthPLG/avel6xBGV/kYshGkcu0ZhrHN1hN85IzEYs82lXBGKKyshgHSm15PIXsnhf3Qq76gpq9MScti/szQTxA2tYLfpnYqQ7k30nV6h1/ttpJ/D4YgiJhUsVF+SYVB3/jiSlPM6vno7EYLmBOdnBbRIgfJnU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(6512007)(6506007)(4326008)(2616005)(53546011)(52116002)(8936002)(110136005)(6666004)(36756003)(316002)(6486002)(186003)(508600001)(31696002)(66476007)(38100700002)(66556008)(2906002)(66946007)(5660300002)(54906003)(86362001)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXNTVVFIbTA4ZG8zQlVVQVBzSEVlZ3kyY2h1aXlSNngxRFRBQlVSWkxrOEds?=
 =?utf-8?B?SE5QK0JCajdBTnJZUWV5WHRSdVVrODQzaU0ycmhPSHhTTkpqcllZa29zYWtY?=
 =?utf-8?B?WS9TVy9kdmw1cEV3WTdyR0R6NFdSTmcrQTVMUVFxMzhTZEpwNGpsdUJIUkRx?=
 =?utf-8?B?eTN0Tklzd1Z3YUZ4Z1h4ZEY1eXFzOEpubDZnd29BREcreFVmWnRwbjEvNk1W?=
 =?utf-8?B?MkFzSm1tWWVZZk5RSkNvaERINXZlRWVjdUhnQWRqejQrWHp2OEl1bVI3UExL?=
 =?utf-8?B?OFMwTThTMFNjZ2xUVFhYWUg3MllkZnN3ZFN3UG1SZDNMUCtHZnl3V1JiZmtL?=
 =?utf-8?B?OHJzOFpML2xPZ3lUWGFSVGk1aUpIOU1WZkNkOTFUTHJUeWhFRVF5cGdQMUJN?=
 =?utf-8?B?S0QyZk4rWkN5V1lUNWlKZ2lXOWorbHR1OHZqdktIUlNRVDJCaUJXWUc0WWV6?=
 =?utf-8?B?ay9WOE4vZSsvc3hmOEc4cjhjWEpCdCthRWMzOFlTSTZhNmpOYXJsSDcvY0Nr?=
 =?utf-8?B?V3cxcHBVU2d1Mk1LZWRqVWttTTZPMGU5TStkbW9NSHIxVTlXVzB5eGxQR01j?=
 =?utf-8?B?OVVDbmF3d3hqOGpMb1pudlBFbllyNS95SU4xK3lzZ0J6bXB6NGx0RzI3aFVL?=
 =?utf-8?B?ZXVEUlZQbHo1VUQzaWxzLytUaDIwSzBtcjdlMHB4VStKeDNXUXJJQTIyVWJY?=
 =?utf-8?B?cUtxTDJ0aFdQRHVYWDhERWFteXhxR25DQ05PYmlNSGRhVkZIa1dmR3AwM3di?=
 =?utf-8?B?cmRGUUg0Q0EzOWdwY01CaytML1JNbnVRejNINWVacCs3UnB6dm9mV2RLZ2pl?=
 =?utf-8?B?N01qNi9jZE1jMElwNzk0anprTDlrdG5kTmhjZTFPckdPY1hKbjMra0llK1N3?=
 =?utf-8?B?YW40dUtMaVZtQVV1djBrWXkwM0Y2ZDNMQmxGUmxYa09yMU9PNGFuNVlEWWU4?=
 =?utf-8?B?QnA4MW5xZTBKRS9GZjI5NHpnWHZadXhYeUxLS3E4eWlPWVFkSi9NejR6RXlB?=
 =?utf-8?B?ampScVBibi84SFVPMTRSdnE4WkdBZnd0clh6WjFia2p6dE5lOTBORWJVeXdI?=
 =?utf-8?B?MUVra0FzSk94dldQOHZnaWdHYjBrUTRGV0RDWTZTREF6V1c0a2ViSkUzRFNZ?=
 =?utf-8?B?QTNNcXZnVUdmRGVyalpkZDBDbFQ5YmREQ3cwQTVOdFc4MEVDM2F4MlVublg3?=
 =?utf-8?B?NHdNek0yNzdBeHlSbTBIV1dQVzZqYUc4YnI5UlNiRWdWUkNjSW9GcU1VUEVv?=
 =?utf-8?B?Uis1SjRYNDN4K0N4N0xDZVdLcWVqZDRVcFEyVXVNZkdQQ09scExSa1FnQTNL?=
 =?utf-8?B?aXZBVThJQmlUd0V2eGM4KzdEcVY3Ky9GMW1TU3FscGo5QW1EK1V0UkRNYWpL?=
 =?utf-8?B?QVFhTFM0Mjhma3dWc1VEb3NXeW42VngrMmc1d3F5cjJpREw0WWNZR3IzcVJB?=
 =?utf-8?B?VVdNemFsall4SnJZVUluZHdYdmM5V2NOMm9SWXpUR2h1WjRqbFowelYyU3Zp?=
 =?utf-8?B?eUx5bXpvdFM3bVp5T0piR2F6c1hia2VKdC9iWWc3VjNUNUxEOGhMZjNrY1Q2?=
 =?utf-8?B?NmFOMC9ZSU44MnkxQ0NzZmFMMW8vSUZkQzVHWmxIaWhRbXU3c1pFb0kvbVlQ?=
 =?utf-8?B?YVpmV3AzdzRXUUQ5MDZvQTJoaVlBMzJRbnEydDlnSDJsOVJFYzVBQTJ4NWtm?=
 =?utf-8?B?akpDR2VnQzZvcEhwdUFkQWdqTDluTEFCWW40WEpOMXY2alZUalJWS2V6bDhs?=
 =?utf-8?B?eUl2cG1Eb1AzS1VYUWZnc2lKMVFtbWd0anZ6WkpVN1VnTTc4T1pHRnZyTEtN?=
 =?utf-8?B?R2lEL0F3eVVQbGpGc1hiRWplOEJ1TkpvYnZ1OTFCZHQxeDdseldGajhEQlpO?=
 =?utf-8?B?c3c2YS8reGJEbUxLUVI4MU1KbU01OUYzNkxMSEk4aHlXZ3NUNk5paFREZHZ4?=
 =?utf-8?B?d1Rnc214R1hzek5jTjMrK21ZVUJHcWxNeFBiMTdUbVcwUEFDdFhiQ2JPTUlx?=
 =?utf-8?B?MjFDWjdicFc3L0Q0d3c2WmtXSXl5b2ZGSkJWN3QrUnZvcmFUWUFsVDNJM1ZT?=
 =?utf-8?B?aFdneStnWUZEQnVpL0NzQlV6NWJJbDJldVVtM1N0c1ZjdHRKR2xUWVBjaWZU?=
 =?utf-8?Q?8gk3Tu/lA1iuUx6R5t55NRK3w?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9e7dc1-5dbe-421c-235c-08d9d175a9ea
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 00:35:54.2802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkRBlvJy+1GnyDYJSe4J7/hHS61ZAOD3AsUbMQ73mY27RD54NsXiq7ZekBiPkEkl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3797
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: gmfw0ZvrZTij6jV0J0HXCh43aMsupOCT
X-Proofpoint-ORIG-GUID: gmfw0ZvrZTij6jV0J0HXCh43aMsupOCT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_10,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201070001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/6/22 1:50 PM, Hao Luo wrote:
> Introduce a new program type called "bpf_view", which can be used to
> print out a kernel object's state to a seq file. So the signature of
> this program consists of two parameters: a seq file and a kernel object.
> Currently only 'struct cgroup' is supported.
> 
> The following patches will introduce a call site for this program type
> and allow users to customize the format of printing out the state of
> kernel objects to userspace.
> 
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>   include/linux/bpf.h            |   4 +
>   include/uapi/linux/bpf.h       |   2 +
>   kernel/bpf/Makefile            |   2 +-
>   kernel/bpf/bpf_view.c          | 179 +++++++++++++++++++++++++++++++++
>   kernel/bpf/bpf_view.h          |  24 +++++
>   kernel/bpf/syscall.c           |   3 +
>   kernel/bpf/verifier.c          |   6 ++
>   kernel/trace/bpf_trace.c       |  12 ++-
>   tools/include/uapi/linux/bpf.h |   2 +
>   9 files changed, 230 insertions(+), 4 deletions(-)
>   create mode 100644 kernel/bpf/bpf_view.c
>   create mode 100644 kernel/bpf/bpf_view.h
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 2ec693c3d6f6..16f582dfff7e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1622,6 +1622,10 @@ void bpf_iter_map_show_fdinfo(const struct bpf_iter_aux_info *aux,
>   int bpf_iter_map_fill_link_info(const struct bpf_iter_aux_info *aux,
>   				struct bpf_link_info *info);
>   
> +bool bpf_view_prog_supported(struct bpf_prog *prog);
> +int bpf_view_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
> +			 struct bpf_prog *prog);
> +
>   int map_set_for_each_callback_args(struct bpf_verifier_env *env,
>   				   struct bpf_func_state *caller,
>   				   struct bpf_func_state *callee);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index b0383d371b9a..efa0f21d13ba 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -982,6 +982,7 @@ enum bpf_attach_type {
>   	BPF_MODIFY_RETURN,
>   	BPF_LSM_MAC,
>   	BPF_TRACE_ITER,
> +	BPF_TRACE_VIEW,

Please add the new entry to the end of enum list. Otherwise,
this will break backward compatibility.

>   	BPF_CGROUP_INET4_GETPEERNAME,
>   	BPF_CGROUP_INET6_GETPEERNAME,
>   	BPF_CGROUP_INET4_GETSOCKNAME,
> @@ -1009,6 +1010,7 @@ enum bpf_link_type {
>   	BPF_LINK_TYPE_NETNS = 5,
>   	BPF_LINK_TYPE_XDP = 6,
>   	BPF_LINK_TYPE_PERF_EVENT = 7,
> +	BPF_LINK_TYPE_VIEW = 8,
>   
>   	MAX_BPF_LINK_TYPE,
>   };
[...]
