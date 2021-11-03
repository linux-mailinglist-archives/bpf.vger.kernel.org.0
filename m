Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86495443CEE
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 07:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhKCGJT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Nov 2021 02:09:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53660 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230152AbhKCGJR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Nov 2021 02:09:17 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2LbKbS004525;
        Tue, 2 Nov 2021 23:06:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=9qZ4DCoiVJQO2UcVt9Q6TFG3T0ZBOfhqV6CkZbL5qsw=;
 b=XN7TfiMqPl4s2XnWZHLMLWpjjodcAWLqRCuHHfQTzr6wD7BKq8mtNDcJWFJ2n5EMCX+q
 L82wj1BWzosws1Dd7qFZDQAyIqwmyj9lSOhQOT2bKRk8C7WfEtNoJ4Jb2qGI7PeAbEJZ
 rdqKpEAiruEqRqeSCv16B4BqApeVOyaTxlo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3ddfjgxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Nov 2021 23:06:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 23:06:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myhEoilJIU9ME+hO5g5KrmIEl/vboTo0PA+PdabfaTTy1XSsoakhqxA/bpWRBXhyMdceSwlgWZKOlnUj1XSrhPL22Nyrs1q6lGl8dE5OSG+BwWuECrWfKhWLpc+bw4dL8ZcV6+nm3aW2CaLxAwF7yEO7eBdk1og1XBerrILuhhNTkLxERGwsDAnvHSkbrTudnVx4lrVVXK/LfT5Y5yZpGrdomg2etgXJR3Lslw1lUHlFJDSzJXcuNZPhuuO+ns9xAenHSbHsAIomv6LM5XyOaAABClNOhfKofRPEP3JnFf+eEVLjzLWrRmi2TuAVefrdbLc+pxwm9+D5xf1d+lnA7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qZ4DCoiVJQO2UcVt9Q6TFG3T0ZBOfhqV6CkZbL5qsw=;
 b=kxm/7lzCEvPErjSfIGhMeRxUCyhOsyD6VfPC8yVDuoB1HGTX0Sf1fKfMydnGQCwi1ELAPwZIMBWbzLZ13O4hJTuTMtamgH6tLFV3q42No6fF5lcBGXyV4TFhPUtmRQRgNdj6STojlP9Wab2Bmjnj9JWGrCPoS+iyikmraEBrAEb40V/dhREEIshFXLxml73Q0EgFP3HtJSdXW/uDoxn+vpZP4QcL7czRgCYlg44qtV5DNyVzrCGhzGgllVafNFdJ+LIYgwJFD0UJKxPCioMr7vVhgOZKFvdSt9uHhoVvpMlOPutaWPQnddodyGsoa1dUwBRaK/XRBSRAsN+3IdtvZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4240.namprd15.prod.outlook.com (2603:10b6:806:109::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 3 Nov
 2021 06:06:27 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 06:06:27 +0000
Message-ID: <21677f40-5415-e932-46ef-4e31cf6dd0f2@fb.com>
Date:   Tue, 2 Nov 2021 23:06:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next 2/5] libbpf: improve sanity checking during BTF
 fix up
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20211103001003.398812-1-andrii@kernel.org>
 <20211103001003.398812-3-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211103001003.398812-3-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0163.namprd04.prod.outlook.com
 (2603:10b6:303:85::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e8::1066] (2620:10d:c090:400::5:b3c5) by MW4PR04CA0163.namprd04.prod.outlook.com (2603:10b6:303:85::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17 via Frontend Transport; Wed, 3 Nov 2021 06:06:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e496894-6250-4275-b33a-08d99e90129e
X-MS-TrafficTypeDiagnostic: SN7PR15MB4240:
X-Microsoft-Antispam-PRVS: <SN7PR15MB4240B965842860B60A2E1607D38C9@SN7PR15MB4240.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qgGDU1/n0WIKYy8qlss/Szm4Fh8YOrop8j5q2Dmy7dRA96sdbIoh7h7zWQ80xBVYFiFV1LGXaSh1W15iThebLpchH06YAHls9XKjm7QwdIJNid8XFrOIg9QVXrzx/iQbK3KE+NYU7VAjo9muy0JvKYtYyC5g7s88drm04jaM+XUqTMc93dTMuJJQmz5AdkSisbh8mrhVsa3P4u9WL1CvwEy8kxGYWb67xOMiNgCpJdQCOrpKeD67mzUzUPCQKQJCOKUhLqmH/iulU7FGUXYZI2dt45RcA3TyZVmkCYmqNn4wNMhVXMy1M/SiLiC2srrLfRn4LY+CGa42VMl5M3Y2ZcQoMcjvpKTk468lqSezB1xRNPdWf6SR2I6X3iTMMkI/Dq40AQyrTMAdedF6lg9YaTDEJd06UiXi1WSjktg8o63evm5nWbD35XzQ6AmTBvH8Xu7pagFisDgNCb9d5MfxRlcwQXvkGGeirnbsLnEoIDJHIupJ2Km9DxFtrlQWlSJDBeL7wanUOOTp/tk/c6LZZJeMCXMuiUpyjv7HzIdGZM+uB1p05PXf728UOrT8QC2VFUmrIc3HMxJNggeT+tTMdub3BpXDQo0elkLLXFM7C0xdGwrP7+9J8CC6YingI8qEfsrIrDxLrHGOx805HkmsCzn5zFrdNW+JBxQHmr+ljKimPGsyqWZ1cZWpoLyAQMwYW1ePvDMnLlR554WI1wlpCtG0b9DsK9tcbZD9UoUwwQU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(4326008)(8936002)(36756003)(6486002)(5660300002)(2616005)(4744005)(8676002)(2906002)(83380400001)(52116002)(66946007)(508600001)(66476007)(316002)(66556008)(186003)(38100700002)(53546011)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nks4S1JKK0VLaEVhTWJLNTZ3eG1xcFkzSCtaZ0ZYZWwxN2dVTXc0MXUxd3NT?=
 =?utf-8?B?TXRSYWhtOHVZaDRSeGN2dG5tR0g0akpSY0ZpOUJ5MjZBejdUdHF3bFVQUXVy?=
 =?utf-8?B?Z2xGNmxZNU5JWFZEMUNwTG9SSWJOUlBhY1pkVlVkTHloVWlsWC8rMnFyMFhI?=
 =?utf-8?B?QitmbloxbEZqdFdKUzd5L0FsRDQ4YmQzRkxxaS9XUjJvZ3lsb1FyQXRRdWJo?=
 =?utf-8?B?YUpGbGJXTHloNCtLVm1kdGRDK1Yzem84S1hSRVBSK1RPQTlyMWpIazVPNDVn?=
 =?utf-8?B?TGVrWGhsK05vVFBVcXl2dXk3Z0k2UTBYNElkekFOMHdoL3pWNFBpVWZkRzBs?=
 =?utf-8?B?V2lpTmVPZDJHUDBsRGVMY3ZLaDlzZHI2TWU5TW8xYWYrcWp0RVdXWnM5aElk?=
 =?utf-8?B?aXdNSWh5aHorZzdtUEVMckJzU1lHcjJzMEE3RG8ydkZnMmROd1ZVaG5USkFC?=
 =?utf-8?B?aHJ4ejZtUUcxNExKbHBDOTBYRjVOR1FmWUliKzYzcko1clJvMU9sbEdkYWZs?=
 =?utf-8?B?d2twZmRiU0x5VG4wRlE5M0I4ZFVkalp3ckl4cXQrb0VlMVhIamM4bW9icml6?=
 =?utf-8?B?c3gvRTYrU3hzZnZ4cmIwT1VCZEFURnVTazZjUFpzdnJnZ3Z2QmRreUF0cWtw?=
 =?utf-8?B?SkVxeDdrT1JPaVNhYXVuNGpyYVFzdlBhcEpXRnkvYVU0TER3cjExV2dFUEk5?=
 =?utf-8?B?dXFxUWI5TWg4NCtJTlRDUW5DbnVCdkVlRmlnN0FGbUo4RzBvNkgwSy9zTVhU?=
 =?utf-8?B?MHJ3eXAxeWozenRhOVBBOGhYMGNzdkEvczk5WnZENm11OVM2VFI2QVB1UVlC?=
 =?utf-8?B?MWJNT3UyMk1NNWE2c2hWeTA4RGJmbktXWDhpUVA3M0U3MDlkRG9KaGx3SzZO?=
 =?utf-8?B?clJjcnVaQnk4aFhsQ3BQZUhrVXpxNENZVW1iYlpjYk1Ec1k1TkpUcStJc2ZS?=
 =?utf-8?B?eWZqTEhpemVxOElhTlN1NDkveFN2cld4QUtlY0tkUmtCS2pETklqeVZKQVlh?=
 =?utf-8?B?MUZmemlpWVQxd0JtQVlvczMrV2ZNYm5HQm1heVh0T2lManpYZERlTlcyUkJU?=
 =?utf-8?B?N1MvTmZkVzV1Mm0rN0pmN24xNHhrbUhqZEg2S1htaFVKR0FLbVZ5Q3o3OEpv?=
 =?utf-8?B?d040NkZOUHlrM1JlZlhjcU1lT25TL3I2YmpSUDFGbTR6OWtHall3N0ZCTzkv?=
 =?utf-8?B?dEVxQXBxbytnaXRjRFNqbVpkNDR0a2Z4VTgrbmdGY0dYWlhueGNsamcva21Q?=
 =?utf-8?B?bW9pRDFwRjQ1V2JOdHBPN2JoWlpGeWxQSXA2VkhQYTVnNThCbTNNT1RrSU12?=
 =?utf-8?B?ZnZoM01XK1dxbUlpbE5UZ2cyeFJyM0xMMUozR3lFZ1hMTU81R0U2T1hONm0y?=
 =?utf-8?B?d2tiZzNHdUZXb2ZLU3VFOXdLR1VjZWtWWGVpSWlZdnJYREcvenpPakRxQ2VW?=
 =?utf-8?B?a1hBT3l2YWxHZGlFQys2NmZwNlFPeS9uaE9jcWc2YTdocmxHMFVMUmxpQUtT?=
 =?utf-8?B?TjZDQVpiNWFWaHF1ZnJPVW14aU1aT2xnNXhONmpVOWYvamtQK2JCZjF4WHpW?=
 =?utf-8?B?ZE83aW5yNy9SSWd4UWZRSEdZQ2tUY0R2RXVOc1ZjSDJnb3c2QmUvTy9rMk9V?=
 =?utf-8?B?Ty85eURERGdtRnA1L0IwdDdrejArM3BTL2NyQ1pCYkhqam9DWVhWS3VpbThv?=
 =?utf-8?B?RWVrcVpkR2FsT2dNVjNxWWg5Nkd3RDhYa2R5VHRrWEJmdVh5Sk05Wm1sTmQ2?=
 =?utf-8?B?TnBTMjB2NHVKc1pmWmZYcjdDN1JxNjN5OGxybVlYdUFxNTFTZTBjWEFSWXdX?=
 =?utf-8?B?ZWJYOEpxK1d3WXhQeGtWcnVkYTd3RmhxZFBIUFdIT0w3VlE5Qkc5Ykl4cXJS?=
 =?utf-8?B?a2VJTVBSUnNyd0ZuUm4ydmJ0dmQreDhzTWZRMXJSWlc1S3hwQUwxdllJTlZL?=
 =?utf-8?B?NEJTN0tOWjBsSDZpM3dNYzBUMHBZc3RPdk05a3ZvNlBUSndVVkVEQ090K0RL?=
 =?utf-8?B?MlBISDNhOEZpWFVEclY3V0x1RWZPUUowZWg0WXVnNTRmN1hBdjVoMjJiVGFI?=
 =?utf-8?B?a1lEQ2Rpdk0rVWFwVEVUOUhsNGVHdmdFSXFBNkdWVTlzZmg0eHR5ZEpzYmRm?=
 =?utf-8?B?LzBZb25jckRaR2lDUUJva25pS0VIS2loQ0VRenVhR2F2MUpvOERmVEhpTWJh?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e496894-6250-4275-b33a-08d99e90129e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 06:06:27.6384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juDNe7OaBl78wNDPWbFuOXYAE4qXjWqL9AYdKbmsGEEDtqa/9n+nGkyGk91Sy7PD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4240
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: MvJEY7d9Z2slfdXqCfxYaicYvNbVQmSm
X-Proofpoint-GUID: MvJEY7d9Z2slfdXqCfxYaicYvNbVQmSm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_01,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111030037
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/2/21 5:10 PM, Andrii Nakryiko wrote:
> If BTF is corrupted DATASEC's variable type ID might be incorrect.
> Prevent this easy to detect situation with extra NULL check.
> Reported by oss-fuzz project.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Ack with a nit below.
Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/lib/bpf/libbpf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 71f5a009010a..4537ce6d54ce 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2754,7 +2754,7 @@ static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
>   		t_var = btf__type_by_id(btf, vsi->type);
>   		var = btf_var(t_var);

Can we move the above 'var = ...' assignment after below if statement?

>   
> -		if (!btf_is_var(t_var)) {
> +		if (!t_var || !btf_is_var(t_var)) {
>   			pr_debug("Non-VAR type seen in section %s\n", name);
>   			return -EINVAL;
>   		}
> 
