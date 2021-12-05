Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1311F468D76
	for <lists+bpf@lfdr.de>; Sun,  5 Dec 2021 22:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239342AbhLEVln (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Dec 2021 16:41:43 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19176 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232165AbhLEVlm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 5 Dec 2021 16:41:42 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B59CbGp008171;
        Sun, 5 Dec 2021 13:38:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=k7cfZWo1pM/iR2CEdTgVteM4tYdoFGqC7KvYQGc7/CU=;
 b=aQtFlTCFqZ2H1ou1+mKxQwUtw6PUdnToJdH+Wla4WhZ6kkgE4nZE3bfF0fSTw9Bwf1yY
 heV3M/VmCOmfDmZ1/ZhHQmLjWw7DFLSJINfT3l6+TM8DLhl8zAINhqtP+DLCiIypuCrd
 dtkp4fuf3xZ6X+Y65MY5Z9AAF4sPxzL+HGY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3crs872ma3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 05 Dec 2021 13:38:00 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 5 Dec 2021 13:37:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hcad2BACUIymuN1OoT9F/ruFBmE8s7LDuHs+fq3+xGiCHC6WZHfF0IDQkIUSfT58QFP7MlQD7qZVr6MS2Xev55D84PDAOF3A9DYSPKyrxyd/jMY6sNMnwtjI48UWcXTSXSAwoCFMLVW85DzoapFPOowF+h4MH5YZpvU8+Krlwk/bonnpK6GJKgGQ3qXdlHHx7XcUoTUuhzN/HEBMxZWuSFbBE66Plgiwcax6aC6cWmfKp1LY4MrRRledw0178uhd1Pq9WxnutsP+pvCCk4YCeEBBk7Nfyxqe73T9Wd5exOOsINXA+RmhD3wdfJDq/FuRtjixD1jRghu7TMqRhE1sSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7cfZWo1pM/iR2CEdTgVteM4tYdoFGqC7KvYQGc7/CU=;
 b=Z834B7Vex6aWaehg5j9Dn9wQBi3FUouBHPcpxz77T8JKDK06holtb0vYGLBw73t3Y1YN2/G0cfNQaFSpT4cToP7ouQ5kbmiKVDvMzl2t5NhYROWIwRqWhnMP3V6lJ81fES8eaDzhBF+vAHhy3L88+MVhAFLf/KvQ2sMaQ7YxCX6RyrzbLbJDA5Ds5yL71QqoAiii3h4MZAdg3NG9IweY8aVzVU8VKhBz/mwfk1YA7tzgawT5q/YRoCR5HkSFJhknaFvj4f3TG6OToTEM3Q88F2NT1SdfWhg8njljLq00pNQZyKFWjWZVTgbgZbMP2ZG2Ij4huzVzqNIWEeDvdRFDCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by CO1PR15MB4905.namprd15.prod.outlook.com (2603:10b6:303:e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Sun, 5 Dec
 2021 21:37:58 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::64bc:59b4:a6f1:23f1]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::64bc:59b4:a6f1:23f1%9]) with mapi id 15.20.4755.011; Sun, 5 Dec 2021
 21:37:58 +0000
Message-ID: <a4030b10-c7c7-cf3f-59df-34601300c7ff@fb.com>
Date:   Sun, 5 Dec 2021 13:37:55 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH bpf-next] bpftool: Add debug mode for gen_loader.
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20211204194623.27779-1-alexei.starovoitov@gmail.com>
 <CAEf4BzZz=QSEqGWQaqjh73Mjd0Zk+f2vsDN0Goa+k3ooefHYDA@mail.gmail.com>
From:   Alexei Starovoitov <ast@fb.com>
In-Reply-To: <CAEf4BzZz=QSEqGWQaqjh73Mjd0Zk+f2vsDN0Goa+k3ooefHYDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:303:b9::18) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:2103:c99:e09d:8a8f:94f0] (2620:10d:c090:400::5:9b98) by MW4PR03CA0223.namprd03.prod.outlook.com (2603:10b6:303:b9::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Sun, 5 Dec 2021 21:37:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fde201aa-d852-429c-169e-08d9b837813c
X-MS-TrafficTypeDiagnostic: CO1PR15MB4905:
X-Microsoft-Antispam-PRVS: <CO1PR15MB49053FB656BFEBDF63F888FAD76C9@CO1PR15MB4905.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: teMppsdXUlskd4ScaLYF3wgYvqduItb1oAzbKw1+TvGlXjG4+Sle4PwyOXQt93YDojJH1e9e72IB95fP8yPBziRgKZDFPoKipEF6jGw/5kwh0fE2NKsK5hpD4tn2c6FnJ58XJseOg9NCumoE9sqRKn+f8TjLGEx0gAkelX/kI7Mb8XKX6mivK3CDbhCMIqJ2pS4UUztmoPxtveEyW0W1SPk3wNdlmLs8GtQW01+J6w29XcUh6CngR/5VCjDt81Ece8N6XVlc5vLMH3skdBZbtK8DlvxXBiQS3rsj8PLVItfhdy3qf61ruE4dc6ShVDnJpraYF5z8bajSbz17GU+XayhUPqYsKGAPoOdZ46bG3/JjL9WUPQSGibeMNcJKXPGBoEWlz0ANqdK1PYtSqAzRl50l8MoiSX6yn8rF6NqxvesCmckCXGmb8M78OssFW7wW9lJu5nzNu9pzNWoVk057zyhS7sqo5SDB0l89s6+0zgVtEGyj5R1hGnhYCQnDBwkIg3lgH5AlPWB5xbj1Xzo3pM3h8vytu1aycrOB9me/XaQxHgVPHEiYWorQd0891icNaVwsNoasVE4g93s3uEZxfluM61T+/vVZRHF3iDYzVj0ygb/L8mucxCidEFegZSZX+ekvhYhe3P1XNkkFlfFGDS3KGFXxahn7FrE0HZZR+SiGbcclDlgW4FCGYjiP0lnhj3Gd8jH3oN3ZmbcylstcONa3u2+q+IzoiWcbuxciHqX51TOftkaZkD94xa8xJYUR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(6486002)(66556008)(53546011)(2616005)(52116002)(5660300002)(316002)(2906002)(31686004)(66946007)(4744005)(508600001)(31696002)(110136005)(86362001)(54906003)(186003)(36756003)(8936002)(66476007)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0ZiZjJXcnJ6NmhldUowQnFjR2lZV0wvclozMDVpem5mTVpaTHF4M1JMdmdX?=
 =?utf-8?B?cGtCNmx0TklWZW1IakN0M0Yxak4wVkp5cnlWaFZJdzlNT0VHSUNXc1I4NTFl?=
 =?utf-8?B?dlVOYllFOEltMEJabGNEZW9ST2J3ek5YT1lqU3hnWW5JeSsydEJuV05ZaUhr?=
 =?utf-8?B?R2tBbTRvWG9QUWlZa1VzSjNIT0VIb1RlTFVEZWUxWWVtNlM2N2RZVk51c3Qw?=
 =?utf-8?B?bk1jTjg4czBxbUMzbjJpN29Rb0VVVWN2RXdVZEpUY3JSemdGSGd4Qi9aRmZp?=
 =?utf-8?B?YVBpZUp6OUdoTVFRb1hSYzQ1aFlZWUZNdFRvWUFQZ3M1Z2pDSmhLTFNaL05J?=
 =?utf-8?B?K09FTFJ3bExSZmNrUk9oWjNvZFFBU3EvT1psR3laMVZ1L2s5NlNBQ3BXcHVk?=
 =?utf-8?B?Z2ozbHF4bFJidUQxZVZiNHVXSzUzeUFmb25BeE50NXl2bko4RzlVeW5OTW9n?=
 =?utf-8?B?SzVFQ1NwVU9aamFlT1ZPaVpPR2RBTHYvOU02cDBzWmJWWlRKeGhHYkczdTVF?=
 =?utf-8?B?RGxhRHpuVUtBWWhaOFlENGsvZWFjV3VmR0tTQmltYkNJY0Z5V2FTTnVmcXVh?=
 =?utf-8?B?YytGUGtXS1pCcC9WWmxlc2U3NXQ4VmR4TGZvcXZzdkVMaWZPRFBQTHB3TXBW?=
 =?utf-8?B?TFpGc0VleEx3U2NCOUZlTzcwdXRXejF3QUNldERHWWhQb3NjME51aVZzTGhy?=
 =?utf-8?B?SFlGeU5UMWxMcmQ0elk5clR0YmkwZDFSVXI0MThqUmxtTWY5S1JjTUQ3bXRu?=
 =?utf-8?B?STJadGdlQU1rZTRSalU4Z3FiTlNMQ1RIcXVBWjJySnU3Q2RmeFFwSVhPYjI0?=
 =?utf-8?B?eityUExOc2Q3UE5uSm56VS9CL0lFcFRsdEFwTHhEM0U0bVRQeHlySXV6MzdJ?=
 =?utf-8?B?YXV2Yk1oNGh0TEhOL3pHY3FRMXJKc3RKMzRFT2M2NkdPMGV5ZFA0STlsMGRP?=
 =?utf-8?B?TEVqR2xpanEyZzg5eVFQd3V5cWdyb3hDNHFPWkpibmNkNThtdVh1Q2dPYlBq?=
 =?utf-8?B?OGNrVXVBbTc0OEp3RVZZeklPRWJyU1NSbWRNQm1JVlE1SmhsRWdJM1ZaZFRt?=
 =?utf-8?B?K0lXUTRITjFxUVNNR29MWnRMYjlDMDN3eDNLbVZTOThuK1BhQkNiSUI1WjJW?=
 =?utf-8?B?REZSMEtNb2hXRzE3ZVByNEdEVXpjWmZUU2U0aTM5TTJkNHpSVFhodjcvRjEx?=
 =?utf-8?B?cHBxOXVGV1NTc0ZPcXJJejQ2T0VDOERuN1lOQ1dtb3orRVZReWQ5M3g2VTBU?=
 =?utf-8?B?eHZsbGlsMWRHQ29KaVJVVVFrWnlHUE1xQjVzajlDNHo5cUNWZkxWNEg5UkdJ?=
 =?utf-8?B?cVhOc01xbGNERTF0WndWZldJWFg2ZkNtK1V6L0YxWk1HTjdGSEl0NUI1NXpq?=
 =?utf-8?B?UUpyd0NKdmVZMFpnSHE5WmoxaW5pY2xRUTEyeXF0cmJ3Z3ovQWt0Ym9meWZw?=
 =?utf-8?B?L2dBSWk5bFI5Z1pVbG85cG8zQXVWbndLcEErcGFqVm9WY251dHYzMUVkWFNR?=
 =?utf-8?B?U3A0OFpBV2xDTUFIOVlFdUgwVEtvenlSa0FBTXIxa0xUUTJjLzJaU211Q1JT?=
 =?utf-8?B?dVFhYmpteWlqNVZUdVdMOVRoU2paQTBONDRiVkptRS9ITzhjODFTZ2lkWGRX?=
 =?utf-8?B?Q1d5R202OEFqa1NKS0dVOTVFOVhVUlpNYm9hWkdFVm4vei9rVWxNSHNVOVkv?=
 =?utf-8?B?ZXFzTVVPUmF3bklyWG96Z0FYZG9qU1hRWXpWdGpQTWQzVU1ZWTBVTVhDUzg4?=
 =?utf-8?B?aUg1TFBiNGlReGx2YTRVR1dTd21jbG1JUnF1c3podm5VR0wxUWRFcVRuYXU0?=
 =?utf-8?B?bGlUZ1J1bjY2UlpUdzNrc2R3Mzl2Zkp4WmNkVUV1N1pqclR0NHNCeEJZSWJS?=
 =?utf-8?B?ZzJUYkc0VVhiSVZjVHc2SkoycUI4cElPTWVqMWxxQktvZ3Y2UGs3UjlQTkI1?=
 =?utf-8?B?Zk5mZHVJNldIcVBOejM3MHRWdytrbm0xa2xrNlRJbWVlL2NYNFlwQnBVbjdl?=
 =?utf-8?B?V3A0dGcyL0g3NDhZTXplV3cwb0xUS1JHa1JGNmdnVHd2dkxSazhRWlhpV3dr?=
 =?utf-8?B?MEd1QWE4TFRUajZQc0c3U2FuNDUyR21ER3hhd3VhU0ZZcTlXNzBnMVJFTlNN?=
 =?utf-8?B?ZG5ycmRMRHVab3dOb2pDZkFBYitOOVl2c2VPNTBSZWxzMHozdUNrQ0VzUmZI?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fde201aa-d852-429c-169e-08d9b837813c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2021 21:37:58.2139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaEOeD3QoA/vqmP5A5+hMWhr1iIQ6wDMUiVUV+EBKLd60U3xWZZAdNx3EsjnCg4p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4905
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: ulHwT0_181uSUU3SB6-oFcRhJvrd82GY
X-Proofpoint-GUID: ulHwT0_181uSUU3SB6-oFcRhJvrd82GY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-05_12,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112050132
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/5/21 11:42 AM, Andrii Nakryiko wrote:
>>
>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>> index e47e8b06cc3d..b9f42e9e9067 100644
>> --- a/tools/bpf/bpftool/prog.c
>> +++ b/tools/bpf/bpftool/prog.c
>> @@ -1779,12 +1779,14 @@ static int try_loader(struct gen_loader_opts *gen)
>>          ctx = alloca(ctx_sz);
>>          memset(ctx, 0, ctx_sz);
>>          ctx->sz = ctx_sz;
>> -       ctx->log_level = 1;
>> -       ctx->log_size = log_buf_sz;
>> -       log_buf = malloc(log_buf_sz);
>> -       if (!log_buf)
>> -               return -ENOMEM;
>> -       ctx->log_buf = (long) log_buf;
>> +       if (verifier_logs) {
>> +               ctx->log_level = 1 + 2 + 4;
>> +               ctx->log_size = log_buf_sz;
>> +               log_buf = malloc(log_buf_sz);
> 
> if verifier_logs is false, log_buf will now be left uninitialized and
> passed like that into free(log_buf), crashing or corrupting memory.
> I've fixed it up by NULL initializaing and pushed to bpf-next.

Indeed. Weird that compiler didn't complain and bpftool didn't crash.
Thanks!
