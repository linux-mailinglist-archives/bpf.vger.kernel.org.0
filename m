Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D934F456037
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 17:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhKRQOt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 11:14:49 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15994 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231167AbhKRQOt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 11:14:49 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIF0NCl018522;
        Thu, 18 Nov 2021 08:11:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Zj+eYH97XQRkExIu2WL5wUVcdJm4EIq6D2fzDQ29pjM=;
 b=CmYqBGuPo62PAHmUiBYvEywC8tlTNXKyFnJ6xuyQPsgShgoEqkE2VEVGBPg2LMTNbacw
 42Jk5poXfoVJkuHzqd1tHaksgKJ3gL7BA8jI4qxuTyKxyqf5N1KuJtvrZ9IOAHnN5UvE
 ui/F/o4dwlBLEtu1uZ6EXvEW5af4o4FwLQg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cds390h3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Nov 2021 08:11:35 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 18 Nov 2021 08:11:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0HC7RlTmct5Kd3gX67YYcStWjqKIN+wXDV16UI+ZS76vIBtVpB62RPghApoytXv1WLuL5/sE6N4LPB/lIpE+QwW9YVrZ2OGehssyMDMKUa11AgVyifHlDCE36Il5YUi1krMLu3JKzNorUK39OIZiNE1AhcrPsL0BZj2Ujt3TJDlIomMq+bPx8EkTb2FqLlYh/1YZoimV1X23DAwlPVw5X8vAQAELEomjY9rs6WTjMneoQ9yW+PiQJRaKYMO7PP6Vz+HkVB+CjgK/RM6rV+l3psGSjhymmvUF+0BEeSXOB8bySfNx/XU6KgSH+wGm6F7BudzWzy3Fx9HALMuo7oflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NGhtoX92R9wSriclXD3oSwjSeijibVm3sUSrQhnriI=;
 b=hMBB290S+w5NsBSSKkVdSq/Ph2Xaqnr8zm6MCKKvlMPMWnd+iR07hdZzryHQaqxlDIN/wAffTf7ixgP3linLhhWYaX8ZLOPbU5HfGV/7QNbIPCT70Nqp6VEaT7XslVRvcbQC40PNEfJsDccP3SirB/8O40xnI3/6z2tDgUIkuA74EAAar5Q2skHd0VX6Wi3/geoqilDz/cVxeoZOaAM1ZPCh0we4AFg8RG2T8/9YLvLovUu9Mpd06eJlE/tliXs5kw07NO9p5sPLTsXX3kY62dsQFl2hAZRX2zhFwYxrh1IRqVF6yU+DOF3CKayEDKTgdE0G1ocZcZHz1Z4y343RUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2061.namprd15.prod.outlook.com (2603:10b6:805:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 16:11:32 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c%5]) with mapi id 15.20.4690.029; Thu, 18 Nov 2021
 16:11:31 +0000
Message-ID: <87565e18-e45a-0352-f9a5-7849ee8d2f30@fb.com>
Date:   Thu, 18 Nov 2021 08:11:26 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH dwarves 3/4] dwarf_loader: support btf_type_tag attribute
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <20211117202214.3268824-1-yhs@fb.com>
 <20211117202229.3270304-1-yhs@fb.com> <YZZOXq0mL7YW5IhC@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <YZZOXq0mL7YW5IhC@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: CO2PR06CA0073.namprd06.prod.outlook.com
 (2603:10b6:104:3::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPV6:2620:10d:c085:21e1::1798] (2620:10d:c090:400::5:184a) by CO2PR06CA0073.namprd06.prod.outlook.com (2603:10b6:104:3::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 16:11:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 896ff3ba-b445-45dd-4f84-08d9aaae1552
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2061:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB20616524230F4991F0F02CA5D39B9@SN6PR1501MB2061.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ktYQ5HJiGGJlDzWWmarSUA+uOhDtDIG/4V1BNK2q+pyYAAg66M8hXkw1oWy6QRjnO7Y9ckuZkFDOWLuU5BzqckxGrw/9p/ltnWkdK9ZXH8aFNkzi5KUAnhCLLXok0fmL2L7xU1/9gcm4HXdvo4TaWr94veQD5g0Uim8UdMeRT6Z+EEnh403Thf5FtsY6+W5hbq2o/GWduqgBZpyRw4lRvnpbtjcXzBWzq9GMJWX2c48E1G8P7kgS1ziQocCjjwHhm/1cMQP4ERTRWVdXW6I+R0mXZ5ZJiE1WZTmetGU0x6/SEVPYMjFe7dcEvH2pbZvpdCR+BpFVaP374eGcJOmv+tPh9LYKk1er2a63trD4bM3M3ltMMbQbNpWju+dbR4YzwyEOjsjBYIAoRfv+Y7EcSTWqHqGOj/cDbg0t2tYsPc+oJ4M7/83JsFjBHwVOXiTU4+c+aUTNqBJJxAwGLI6huK5jxmvy1Io9pYtaeaMQ+Vm68bAPJwCXwFggZ8qTeHrSLF90+lRaCxBpLNoUn7yjFdMmUt8pV5Qx3i5HuhKO2xyLt9DSvRVQp5P9N6FEXEX6LUuVZJQQSKJHMTJn1inym68SuiJt0W8TZtQjleoRGPnoelFlX+k2ZSDlGAKs3i1lCyNjWTrCmlMvs3Yij1khvMrM+LUyGffCj1ZQclf2+EV1r1gx+kS3C01KSvwh+HG6W1YdMb8kUpKgMf8HBysgUITUvqS+hPqiDxzulUsOrcZCQvNMAuOgg5PyVNoKC0gAqZ7MR6osw5USiTKSJM1B/a/1jwoTEODClkHxwrt8ePwQM8JkqA+iBMDCN9z02XFeHobX1Sr2RpT/DSaqUShEXVcQcS5Z3XFs42WLOqIE0Xc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(8676002)(31686004)(5660300002)(36756003)(508600001)(966005)(6666004)(53546011)(52116002)(6486002)(186003)(2616005)(66476007)(86362001)(2906002)(66556008)(54906003)(316002)(8936002)(83380400001)(31696002)(66946007)(38100700002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkJlcnB0SjlBalBWNnBjNStyanRNZ3paWDNFaE05aytKVXp1YTQ2Ump3YTlI?=
 =?utf-8?B?TWxsaHVUQzZqTHROclRXSElTa0ZpUWVwUmJ2VjUvY1dJZlBpMkxWRWRvNzV0?=
 =?utf-8?B?Yy96eWJBSnNjYSs5bXV1MmttQkNsdWdkUVAzME15UU56VXJWTkJSSWNBZ2Vr?=
 =?utf-8?B?cm5rMlJlT0JVQ0ZmYS9SZHR3SU1wa3R0MVJVb1RvdzBob2xFK0Vjb2pOMmNz?=
 =?utf-8?B?Y3NsRzRDVnhjZGowdjdtNjVBbzZQSFJ4bWFneXVUNC9DOG8zYlhhRUtiL3hS?=
 =?utf-8?B?MkpKdFUvdm8yT2FxL0VPVGxJTk9DZ0MwRjd1VXVoZGhzZ0NJd2REU2o0c1dr?=
 =?utf-8?B?UFZsQTBwbVZISFhiZFJvNXphNnBxV05XYW12OXJ5MEhSTmNjVFhPSVpNaFY1?=
 =?utf-8?B?cGRaQ0o1bTlaeHVXQU0rVUprdzlNN0wvMXhkWjFIekVaN01ua0xLaElkVnpy?=
 =?utf-8?B?RWZ5NHNCVGNmZ0daMGtEb0dydCthWVdJYWxqbi9LOWJNbVI2OEI2amZxYmZB?=
 =?utf-8?B?MldGSytCUjUvb0MvRUVQQ3g3UjdueFdFT3l4a0tQeE5KZ29td2xVUEM1Q2NI?=
 =?utf-8?B?eEc1SlVpU3ZDTzJUK0QzWU5iYW9BQnhNSW95MG5wTW9ncWtvRnRXdG9pN21E?=
 =?utf-8?B?TkN6MVFESHV0bkxSaUdrMm9MUFVIcWY4UE5BSFdiUUN5U3I0QlMyWDRLZHU0?=
 =?utf-8?B?RzR5ZWNZaU5hK0llVTFOL0VUaTRqR0FaTmlDTVhqRzlRbndnS2IxVmlsL3RI?=
 =?utf-8?B?VW9qWjdoZEZNZGtHM3RsSi9rQmNGNStWMDAzV2xtUG53UlFhTStvOExtNkpp?=
 =?utf-8?B?T0xlUitVSk4yYW93YjBZelExVU9OWVd3MGxiYlZtbHhmTGdpY0ZnQVNWMy9p?=
 =?utf-8?B?Y1U3blpWdWFHTXFrelNaMTNsVmNrSmloanlEMnpabWp4MkJxYUZDeWo0Mk1s?=
 =?utf-8?B?eGl1bk1PV0RxMDREVlNsT0x0QW9LOUI0VXFGeExZZDdCbHBNS2s4T2IxVlRG?=
 =?utf-8?B?NUg3R1RsSjhrS1EwbjBKOWJkSHF6ekRJNUNZWGRnYUdjaU9SVThGN0ZtelZT?=
 =?utf-8?B?aHE4ZHdrZnpkc2tSeGdldEsxMTJZQVFLUGFRbk9XbDZLckp2VW9EK3hNRGtO?=
 =?utf-8?B?VmF4WmkyRVJabVY3c1MzcnRnK3N5RUg0bUJZVUdKbFVRZ3VVYnJEbzYzQTg1?=
 =?utf-8?B?U0VpWEFQMmtNdjNCTHlkVGxHUCtvU0cyOTNzRHIvV1NJYW9lUnFRTGVNb3cv?=
 =?utf-8?B?R05JTERSS0ViZzRRbmgvSWU0T1lSeUgvQzlvdW1NQThuNFYyYzBNM29Rb1Zu?=
 =?utf-8?B?dFdGQVRaVWtUODNTZ2g2Sk04NU9oazh0ZytoQ01GY2E2dlNqZzdHL2tXMGo1?=
 =?utf-8?B?aXYxVEdpdGVmWWE4bXUzTTFkTVFUSmQ0aHJSN1RLdGZYK2xDbnpKSDhqRCto?=
 =?utf-8?B?dm9zbUlXUEsyRGVnWlo0dlpBM2NpOWJ6VDQxM001Zk11WlZuV3hJUVpCQjc4?=
 =?utf-8?B?SUJyRGgrbWdMMTNvNjFYaytwY0hsNkk3c1VJR0xkb0ozRkoxS1pRT2hHZUNo?=
 =?utf-8?B?d0V2Ym9USVgxNDEvQjlna3pNSWJGU0E0MFQxeGs3RDRTNS9nS01lY2F0UDZ3?=
 =?utf-8?B?NDYwZXlDTDIrZU5xY3I3ZVBXU0V1eWJJbTFHaTlPdHRkekJQajZiYlAwbXht?=
 =?utf-8?B?ZFRYdk5Cek9SM0k0cTBnSXQvcEdXM3NjVC84NlRsYzVKYTNFL1ZmZHVMRlRT?=
 =?utf-8?B?S2Z3QU9hcy8zdTdqL3d4bE9Cbm9rNUxDYk45T21LcWlNMUFPeVdBSXlOaTEv?=
 =?utf-8?B?SWpXY0dGN2diZnJ1cy9UcW1ZM1g3cVVydjkxcE9MODJFeFR1d0lwL1RRaDc1?=
 =?utf-8?B?bUFtZVNHNTlkNjBENTVmeHZPcHpEKzlMMFpiZ09MMXJ0NnJMdDZJaXU0aml4?=
 =?utf-8?B?TnQ5UzhsdXlMSDJ4NVRXakNoUkJmMm9MVUtES0FWMGNxcHM5MExmRWcvOHNP?=
 =?utf-8?B?dXdGbDhjL0R1QlZCT3QzenhWVzNVSytONU40VjVQcTR0Ti83THpibzlxREhB?=
 =?utf-8?B?L000SmVsQ2NvaGN6OXkzbkllYVc5VGFNVzNKRE5LUm9BK090dHc2SGpFdHlm?=
 =?utf-8?Q?N2kvdxDybpKQLHVU9qkIj+HmZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 896ff3ba-b445-45dd-4f84-08d9aaae1552
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 16:11:31.0591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INQkTm3t5BB6B0nAlsGs2pOZu3Xfz0LQYoAzPLo01jqkKay1tZrLoN64QmgaMGW5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2061
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: JOqzuXdzMOmupQIAv-33F_3HVxDIzA2-
X-Proofpoint-GUID: JOqzuXdzMOmupQIAv-33F_3HVxDIzA2-
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 3 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 mlxlogscore=633 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180090
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/18/21 5:00 AM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Nov 17, 2021 at 12:22:29PM -0800, Yonghong Song escreveu:
>> This patch implemented dwarf_loader support. If a pointer type
>> contains DW_TAG_LLVM_annotation tags, a new type
>> btf_type_tag_ptr_type will be created which will store
>> the pointer tag itself and all DW_TAG_LLVM_annotation tags.
>> During recoding stage, the type chain will be formed properly
>> based on the above example.
>>
>> An option "--skip_encoding_btf_type_tag" is added to disable
>> this new functionality.
>>
>>    [1] https://reviews.llvm.org/D111199
>>    [2] https://reviews.llvm.org/D113222
>>    [3] https://reviews.llvm.org/D113496
> 
> You forgot to add your S-o-B and to add this entry to
> man-pages/pahole.1, I'm fixing both cases, bellow is a followup
> patch, I'll add one as well for the recently added
> --skip_encoding_btf_decl_tag.

Thanks for the fixup! It is my fault as I never changed man page
before and not aware of that.

> 
> - Arnaldo
> 
> commit 9c3101db76acf364607d90adb3052e34d81fa1bd
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Thu Nov 18 09:56:35 2021 -0300
> 
>      man pages: Add missing --skip_encoding_btf_type_tag entry
>      
>      In the past we saw the value of being able to disable specific features
>      due to problems in in its implementation, allowing users to use a subset
>      of functionality, without the problematic one.
>      
>      Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index edcf58b8ca5814a3..f9f64b67945b45cb 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -197,6 +197,10 @@ the debugging information.
>   .B \-\-skip_encoding_btf_vars
>   Do not encode VARs in BTF.
>   
> +.TP
> +.B \-\-skip_encoding_btf_type_tag
> +Do not encode type tags in BTF.
> +
>   .TP
>   .B \-j, \-\-jobs=N
>   Run N jobs in parallel. Defaults to number of online processors + 10% (like
> 
> 

LGTM.

[...]
