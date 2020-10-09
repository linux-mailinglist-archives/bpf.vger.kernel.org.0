Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4663E28902A
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 19:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbgJIRmL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 13:42:11 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27804 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387436AbgJIRlu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 9 Oct 2020 13:41:50 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 099HSING017556;
        Fri, 9 Oct 2020 10:41:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : mime-version : content-type :
 content-transfer-encoding; s=facebook;
 bh=DT/ETP7+fupcPfrwSmuhhD+TfzGnBy2kOKJ8XLPLkuE=;
 b=LN8/4p8ytQOHbRmEDt2QgM/Rm2rxcYDo49jGxKOttp5tlvcO1cnXEpP4OtHVaR0oFXfK
 mfZSLsEaU5VMxANwPdLKkCjdN5gK768ocWfhg8aOrxCgiatrKr82MiKx8xtIWzZnEGAm
 CM5Tf6VoOQjuXee75X0WFcmzRBB1LGNKUvs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3429j5502k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 09 Oct 2020 10:41:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 9 Oct 2020 10:41:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EylripFud12r2Cpsq8+A9VoGc1JKPccIHjLflU2evIHyMIXWTkcNxhBUEgawr7w8pbo00UgIpRwfIJnlaXNb2pxbvHo7rgBTXUPgXr8SGKbyOwQEGygIzNJPpzLM9A7ZlpXMSn1xxo/4g2iQIU2qPJppd/fVRzyi4b/UK0ApwxzdMh4tKZEYYk4gzBjtrGvwXshXRtbLRHDX8ovb9oT6VOb2vWKowzAqkjsP9T/yBbuf+nErr6XfiBBtOozb5dql+kxGUkxMKkzL8D+OnfkkbUYLpXBb75WypUg3BW8jjVUpXbU9QVIfuV1Pfsf5R7I/JuY2uvPv4b8ZdVM27fmz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DT/ETP7+fupcPfrwSmuhhD+TfzGnBy2kOKJ8XLPLkuE=;
 b=RF/Tta2DQgZspyGERfZw5H9S11YoPQdxrk8c867x9XAm/JucubV0oKInOQ2Ol+gdfHH01h72i/AB2dbwzS5e2rlGamzqRVi27h+3PxOWKqwYimO7LqzaDvvhRgH+gZFs5fyAUu4kfjNeHX2ZPOxcZhs4m0XuwQG62U2CAyR3LxlHJlvmIZd73oNypbsAyiT5cD8wNasfLXiag++yQuDaH1BL1LL5oAtRO5mMyxr+qL7gNsZWpyeZp0jZ0rwNMKvGT6wtpS3P5632S2R/TZtMtT1CsOmb4QkCrt6Z6TdLnSc++YLoMl68YDB01101QswGzBHog9pX/WioSOscQP5G9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DT/ETP7+fupcPfrwSmuhhD+TfzGnBy2kOKJ8XLPLkuE=;
 b=OVxln9gWebq5dPXjXxwpicaOZBPe0/CK5llgkmiik3wO2xo9QhGPMPlMzHFkLVeoRQxFz777th0ElHHB0S6U3DlylIhhWh6J/ylBE72OrkNIPcHZkVf9wPlP4iibA2A1V8fOsdO6GjsBZ3eFIk57VtZevUBsF2VHucbb1Bouz+o=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3190.namprd15.prod.outlook.com (2603:10b6:a03:111::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Fri, 9 Oct
 2020 17:41:31 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42%3]) with mapi id 15.20.3455.024; Fri, 9 Oct 2020
 17:41:31 +0000
Subject: Re: libbpf error: unknown register name 'r0' in asm
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Yaniv Agman <yanivagman@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
 <a8abb367-ccad-2ee4-8c5e-ce3da7c4915d@iogearbox.net>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <e89e7eda-bcda-7cf4-43a2-f9c1c99431b2@fb.com>
Date:   Fri, 9 Oct 2020 10:41:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
In-Reply-To: <a8abb367-ccad-2ee4-8c5e-ce3da7c4915d@iogearbox.net>
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:544b]
X-ClientProxiedBy: MWHPR01CA0046.prod.exchangelabs.com (2603:10b6:300:101::32)
 To BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1844] (2620:10d:c090:400::5:544b) by MWHPR01CA0046.prod.exchangelabs.com (2603:10b6:300:101::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Fri, 9 Oct 2020 17:41:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53bb51f5-4540-4fa2-ad15-08d86c7a8efd
X-MS-TrafficTypeDiagnostic: BYAPR15MB3190:
X-Microsoft-Antispam-PRVS: <BYAPR15MB319004D3BBCAF8572BC71EE4D3080@BYAPR15MB3190.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:428;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gsNl0COobZay9NrINLUiSP40atDcQjYoCLwxsurLNbqMrTvnfUedVBVnFLC1yWYbk4qUEtz+xFlU7MuMGwInemFHSMwPjAE+j05UvBHiPZja52Na5BuAOyT0K0/ST4yn//oCREPldzKqDdKba11BHx7AiCuP8cvlViL3aHJF+sIsSR/JymgcP06f5JFEa0TDuuAuOD1ESDBBws7BKJffI7t2CK+WCzrjN5AK3mPb5nfeqx/PRsg4aMFLGP5nJY1JMnTTEgzqakzfg2RQOUyH7mKV+adR+vp7e9r3/1r/0sqbp5N0gd7rqfhKXwkoMTIDKvhUomweKNKEYi4YUS/0h3jLIjetdaiUKyO9YmflZCdYA12V/GJ62qhKOtpemtk/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(376002)(346002)(366004)(52116002)(478600001)(316002)(36756003)(6486002)(8676002)(8936002)(110136005)(5660300002)(66476007)(66556008)(31686004)(2906002)(66946007)(86362001)(31696002)(2616005)(16526019)(186003)(6666004)(53546011)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 2P9Ctc00R9BpyUI6Y+RITAAF/JkigwSQMX5bjzCXZw05EoZesWoW6nRUwjhMWDVsCbmtueVLYNrkoUQeocrCjQZMkqxWsuNiYMasIdtA1uywYW6abS52BGxAmQGGQpZjR34xRRZsNaO9qETul+NjGfPsffhILAKvQe2/TOAyHtU37cx/VczREk6Z4xRBUyCSkMng15X+y/XfO76psflIPjf8fQNoCNrvPtpRg3AREMjzSyn2Hgctp6WouI0zNGG4NfveKp1J/coZin0JuJbTIkfT169C6CrTGa7MYgXG/NGTgB0OUWSTXfaNe0w2LKu8u7CygnonOL7KJ8r81rO49rEBaokuzshyaUliJKOHGO4eUtSDyPnPeEs4BldENLrw+SPOyT6fBPRCgOiaFeC1NrX0ntfO4u6Ifla81IRg0BEjyUx09bB8mxhHF2IKLdA+Je0ZKs2Fx6EVZOP5rPW7DbhL++6Vf0UwIUrFzXtw7BCdUym/qC4tn7XXqDgLxZmyaojfObWrUDKq8fiAUgFFZMDTJz8dz6c6rx5EB4btEEqchVa+oPFM4YxaOm5ZPQ2hBetkDe1nX2XDWF2ghIjWLFkFq0nhaApdYnTnYOFgcg0UPmzXpKMB7SyC14oryLxZbBoILQ0Pet55gsCGk2pdXERJ6oMQOd9HvHxW8/8JFdW30u03Jpc+6pAKF5/BgXlU
X-MS-Exchange-CrossTenant-Network-Message-Id: 53bb51f5-4540-4fa2-ad15-08d86c7a8efd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 17:41:31.5593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eo22mm2l2Bkj1AhTmHy2GXx9oVZTFKY0iWbGu2QLqIvycLdSb0sFln5/Qy8Lxl0E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3190
X-OriginatorOrg: fb.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_09:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/9/20 9:27 AM, Daniel Borkmann wrote:
> [ Cc +Yonghong ]
> 
> On 10/9/20 6:05 PM, Yaniv Agman wrote:
>> Pulling the latest changes of libbpf and compiling my application with 
>> it,
>> I see the following error:
>>
>> ../libbpf/src//root/usr/include/bpf/bpf_helpers.h:99:10: error:
>> unknown register name 'r0' in asm
>>                       : "r0", "r1", "r2", "r3", "r4", "r5");
>>
>> The commit which introduced this change is:
>> 80c7838600d39891f274e2f7508b95a75e4227c1
>>
>> I'm not sure if I'm doing something wrong (missing include?), or this
>> is a genuine error
> 
> Seems like your clang/llvm version might be too old.
> 
> Yonghong, do you happen to know from which version onwards there is 
> proper support
> for bpf inline asm? We could potentially wrap this around like this:

llvm6 starts to support inline asm.

> 
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 2bdb7d6dbad2..0d6abc91bfc6 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -72,6 +72,7 @@
>   /*
>    * Helper function to perform a tail call with a constant/immediate 
> map slot.
>    */
> +#if __clang_major__ >= 10

Just change to __clang_major__ >= 6 should be okay, you may want to
double check though.

>   static __always_inline void
>   bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>   {
> @@ -98,6 +99,7 @@ bpf_tail_call_static(void *ctx, const void *map, const 
> __u32 slot)
>                       :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
>                       : "r0", "r1", "r2", "r3", "r4", "r5");
>   }
> +#endif /* __clang_major__ >= 10 */
> 
>   /*
>    * Helper structure used by eBPF C program
> 
> 
> 
>> Yaniv
>>
> 
