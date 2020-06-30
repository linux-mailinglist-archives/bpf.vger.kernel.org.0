Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBA320FBBB
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 20:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbgF3SaQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 14:30:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26536 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732246AbgF3SaP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Jun 2020 14:30:15 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05UIDSPV023938;
        Tue, 30 Jun 2020 11:30:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qWFOjJORr6hhwLV4dZfiA7vyomGHnIw2pzn7kA5yyoE=;
 b=JO5oZWEkxdOQQRkHDMit0JQoYx299NAR3bHKVH9MRccGdjNHSe8UwwUuOtUsq2pPFGux
 lkvJtPsqzQpEvNxy5N51bvoeG50N+ctwAbjMOEBdASoJgaG6jUxGkNPkD5cpnTJiWBi9
 h46H5vwsBZaslp+dQ2eKplSdcJFfiN0Pajc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 31ykcj69r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Jun 2020 11:29:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 30 Jun 2020 11:29:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIqBZkuD/4v8BEA7cD7TIhYgXdBVpIOCtvcQpgpAIzTSiogJbrx4hhoZV9+IFLAEC1wsQGelfIGlhqhCQ4JYfq+x2CeWeTa2X+lgWD0rs+zpoG4yB3qVZbgweXtt6M5E6K1Jcz6ClSpDI326AFOVwvvGzHrx6kH+pWC/+5n2BZRx1D4IhbAf6+7onR+rDxX7q272mzBHroK84awDwP+Ui8cV/hc61TzfrBx4GmDxhe2X53YLDczr1qwXYCEp6evyVe6CfAjmyqpzSZrm5LOdu+mANGUS8W8lzhwoq5GUPZdeSbCb9ufboNQUheg8oTFIgzPVKWnURiw2SJu/BbvjSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWFOjJORr6hhwLV4dZfiA7vyomGHnIw2pzn7kA5yyoE=;
 b=Kk5lNnw07ZBx0bT+BLGZjGRVDyduLHVIKsL2c5CR7hOnvxy7QKNbjwuFo3XaC4zWLij02ZL3UyJ6JDvspP19Lsw8SFoYn9ocdeVtRRp2KcaRS/vlQ4owYRmKKsUgQicvkTY3e34QrvAK6J7lUQfio+9DbL35J1JbIa2S8G0+jo0Iz5R2fXBWG5zORRDN0/SrrqgIYB61rrc8NuBi+YVYHUfQhTmWCMUyG6m1u9LW+jFsmQnnS9pXH36HBmk17RhyZy+6avsDoVvR+pqJ86zIFvFRkiJQYG3d8tLlkK2c2fYMNLZ6EOH55WWXDsdX3BK41uHrAoKwRJKGELoCZ+5ksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWFOjJORr6hhwLV4dZfiA7vyomGHnIw2pzn7kA5yyoE=;
 b=Rq21wlYfzZGojScm2KnfyR8RW+nh6NnsOaIxZXsQWFsNAnZ7OYpMLFCa36foWgLpLb487rwyaktXolGTto4M5p1m7Js0y8FEEbWRpRxx6TfxfFzczLNHWQjbZqp02MBvti+VR0OCgVtlW43WyQZhSzNFefiThEmGWmeELPZthlY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3414.namprd15.prod.outlook.com (2603:10b6:a03:10f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Tue, 30 Jun
 2020 18:29:57 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 18:29:57 +0000
Subject: Re: [PATCH bpf 1/2] bpf: fix an incorrect branch elimination by
 verifier
To:     John Fastabend <john.fastabend@gmail.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Wenbo Zhang <ethercflow@gmail.com>
References: <20200630171240.2523628-1-yhs@fb.com>
 <20200630171240.2523722-1-yhs@fb.com>
 <5efb7ba67bae6_3792b063d0145b4b4@john-XPS-13-9370.notmuch>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <c7416fc5-b9b6-7778-9ec3-0c4634e3e902@fb.com>
Date:   Tue, 30 Jun 2020 11:29:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <5efb7ba67bae6_3792b063d0145b4b4@john-XPS-13-9370.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:40::21) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::15c2] (2620:10d:c090:400::5:c3b5) by BYAPR04CA0008.namprd04.prod.outlook.com (2603:10b6:a03:40::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend Transport; Tue, 30 Jun 2020 18:29:56 +0000
X-Originating-IP: [2620:10d:c090:400::5:c3b5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2abc4b33-b8f1-4fe7-794f-08d81d239747
X-MS-TrafficTypeDiagnostic: BYAPR15MB3414:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3414CDD41BBD5F589D0DC524D36F0@BYAPR15MB3414.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rjU2kqIlihExOPQIRxPhydx9NBreM+g8dR3b2p6iotcIp12RhLMgpBqe3YdKqPeHlqu/3NJ4Zoto2CeX7HsE4w9Nn9ryb5jc7nSwZxwqv2/B2jG84HY2JyBPKOcnTB/32k1oUIhxQrczImjvEUNlL14Vo6EeCimQnGbu8GX7HxL9kNOuCsIvhMvv1vI13VPiAmATvVkxABds6+ynqFhHeYSYtVJDMvsDRek1dVbsrWKuXt9mTISuGyWiPDH8Ns/Ny56FGEtkU3B48TOmicJqvTE8NRFVK76Cy1DdkJ8Rgim+nNHmif7dRexeeAXLXEWPGtyDLVVSUe4JrPn74+5xwQPPVG2R14oQS8PtQBmsmyvQOQBvSO7igOHyM242SnSI4jI/o7CTPgGfucjSTzMHCmHKSkmHGNuwEMWDGjv9DhakKHnFWneFxO7Z/1wiPMdcYuqYF89jnncix97lW/tvKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(39860400002)(376002)(136003)(396003)(2616005)(8936002)(16526019)(478600001)(31686004)(186003)(31696002)(5660300002)(4326008)(54906003)(316002)(53546011)(52116002)(66556008)(6486002)(2906002)(966005)(66476007)(86362001)(66946007)(8676002)(36756003)(83380400001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 5hAjzyl1nmg/7DlQ32RNvbNPgzjEWZURKmUEYm5DD1ipPlKxr8vsxZKE4mlcX22A8DQnl2p8uoCbD2B8dSCtj8VZqG3e5wRKEC3oG4u1tocqJua6DO+8l4EMRiRJ+FVADhJIi2V7N3CAMcjMVDc8pgCXAoaGqpa+tvTFbbxLvv7PgSfMmV7e2sxFtyrtVUPXa7ZxXWgt3zrW4lFd8kFMRxHlbFm3K5csX9PslKKBuKXKn9JS+NYfr3I9jI32CRK/NHb3OlDr6xCV3h3A6b2t6pbH+VToFCvFQlbFVtbYk+ilNHo8fNocWCryDSlxw+hk/mEs/xftQ6WG7ujh21rSKK5gghRx2lFJ1t1a8/FWd1pqkIHloe8yc42L8ubWN1zdmjC8a8ZHa34qftw4bdIVGJO3314CaU4+L2335XaIzzB8AKxQZokkYdJ/iKHcuyyF32OsE/0G2Jq3XVxCQ85poieM9cx4jJhcOELlg/L+XAR4YBLyDDATOgyFQFfQLeEgZ4twv59o6mYlCW6KiODP6w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abc4b33-b8f1-4fe7-794f-08d81d239747
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 18:29:57.4428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLuDh+yR+JAPL+DMboNcGwiHE2oEqW0IHiG9fD9hgAEv7bPZu7+QGu/nYyW/XwXK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3414
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_06:2020-06-30,2020-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 cotscore=-2147483648
 mlxscore=0 malwarescore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300126
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/30/20 10:51 AM, John Fastabend wrote:
> Yonghong Song wrote:
>> Wenbo reported an issue in [1] where a checking of null
>> pointer is evaluated as always false. In this particular
>> case, the program type is tp_btf and the pointer to
>> compare is a PTR_TO_BTF_ID.
>>
>> The current verifier considers PTR_TO_BTF_ID always
>> reprents a non-null pointer, hence all PTR_TO_BTF_ID compares
>> to 0 will be evaluated as always not-equal, which resulted
>> in the branch elimination.
>>
>> For example,
>>   struct bpf_fentry_test_t {
>>       struct bpf_fentry_test_t *a;
>>   };
>>   int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>>   {
>>       if (arg == 0)
>>           test7_result = 1;
>>       return 0;
>>   }
>>   int BPF_PROG(test8, struct bpf_fentry_test_t *arg)
>>   {
>>       if (arg->a == 0)
>>           test8_result = 1;
>>       return 0;
>>   }
>>
>> In above bpf programs, both branch arg == 0 and arg->a == 0
>> are removed. This may not be what developer expected.
>>
>> The bug is introduced by Commit cac616db39c2 ("bpf: Verifier
>> track null pointer branch_taken with JNE and JEQ"),
>> where PTR_TO_BTF_ID is considered to be non-null when evaluting
>> pointer vs. scalar comparison. This may be added
>> considering we have PTR_TO_BTF_ID_OR_NULL in the verifier
>> as well.
>>
>> PTR_TO_BTF_ID_OR_NULL is added to explicitly requires
>> a non-NULL testing in selective cases. The current generic
>> pointer tracing framework in verifier always
>> assigns PTR_TO_BTF_ID so users does not need to
>> check NULL pointer at every pointer level like a->b->c->d.
> 
> Thanks for fixing this.
> 
> But, don't we really need to check for null? I'm trying to
> understand how we can avoid the check. If b is NULL above
> we will have a problem no?

It depends with particular data structure.
If users are sure once pointer 'a' is valid and a->b, a->b->c, a->b->c
are all valid pointers, user may just write a->b->c->d. this happens
to some bcc scripts. So non-null pointer is checked.

But if user thinks a->b->c is null, he may write
    type *p = a->b->c;
    if (p)
        p->d;

Or user just takes advantage of kernel bpf guarded exception handling 
and do a->b->c->d even if a->b->c could be null.
if the result is 0, it means a->b->c is null or major fault,
otherwise it is not 0.

> 
> Also, we probably shouldn't name the type PTR_TO_BTF_ID if
> it can be NULL. How about renaming it in bpf-next then although
> it will be code churn... Or just fix the comments? Probably
> bpf-next content though. wdyt? In my opinion the comments and
> type names are really misleading as it stands.

So PTR_TO_BTF_ID actually means it may be null but not checking
is enforced and pointer tracing is always allowed.
PTR_TO_BTF_ID_OR_NULL means it may be null and checking against
NULL is needed to allow further pointer tracing.

To avoid code churn, we can add these comments in bpf-next.

> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3d2ade703a35..18051440f886 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -337,7 +337,7 @@ enum bpf_reg_type {
>   	PTR_TO_TCP_SOCK_OR_NULL, /* reg points to struct tcp_sock or NULL */
>   	PTR_TO_TP_BUFFER,	 /* reg points to a writable raw tp's buffer */
>   	PTR_TO_XDP_SOCK,	 /* reg points to struct xdp_sock */
> -	PTR_TO_BTF_ID,		 /* reg points to kernel struct */
> +	PTR_TO_BTF_ID,		 /* reg points to kernel struct or NULL */
>   	PTR_TO_BTF_ID_OR_NULL,	 /* reg points to kernel struct or NULL */
>   	PTR_TO_MEM,		 /* reg points to valid memory region */
>   	PTR_TO_MEM_OR_NULL,	 /* reg points to valid memory region or NULL */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7de98906ddf4..7412f9d2f0b5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -500,7 +500,7 @@ static const char * const reg_type_str[] = {
>   	[PTR_TO_TCP_SOCK_OR_NULL] = "tcp_sock_or_null",
>   	[PTR_TO_TP_BUFFER]	= "tp_buffer",
>   	[PTR_TO_XDP_SOCK]	= "xdp_sock",
> -	[PTR_TO_BTF_ID]		= "ptr_",
> +	[PTR_TO_BTF_ID]		= "ptr_or_null_",
>   	[PTR_TO_BTF_ID_OR_NULL]	= "ptr_or_null_",
>   	[PTR_TO_MEM]		= "mem",
>   	[PTR_TO_MEM_OR_NULL]	= "mem_or_null",
> 
>>
>> We may not want to assign every PTR_TO_BTF_ID as
>> PTR_TO_BTF_ID_OR_NULL as this will require a null test
>> before pointer dereference which may cause inconvenience
>> for developers. But we could avoid branch elimination
>> to preserve original code intention.
>>
>> This patch simply removed PTR_TO_BTD_ID from reg_type_not_null()
>> in verifier, which prevented the above branches from being eliminated.
>>
>>   [1]: https://lore.kernel.org/bpf/79dbb7c0-449d-83eb-5f4f-7af0cc269168@fb.com/T/
>>
>> Fixes: cac616db39c2 ("bpf: Verifier track null pointer branch_taken with JNE and JEQ")
>> Cc: Andrii Nakryiko <andriin@fb.com>
>> Cc: John Fastabend <john.fastabend@gmail.com>
>> Cc: Wenbo Zhang <ethercflow@gmail.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   kernel/bpf/verifier.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 8911d0576399..94cead5a43e5 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -399,8 +399,7 @@ static bool reg_type_not_null(enum bpf_reg_type type)
>>   	return type == PTR_TO_SOCKET ||
>>   		type == PTR_TO_TCP_SOCK ||
>>   		type == PTR_TO_MAP_VALUE ||
>> -		type == PTR_TO_SOCK_COMMON ||
>> -	        type == PTR_TO_BTF_ID;
>> +		type == PTR_TO_SOCK_COMMON;
>>   }
>>   
>>   static bool reg_type_may_be_null(enum bpf_reg_type type)
>> -- 
>> 2.24.1
>>
