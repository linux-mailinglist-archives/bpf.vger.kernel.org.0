Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055963B4BCD
	for <lists+bpf@lfdr.de>; Sat, 26 Jun 2021 03:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFZBYb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Jun 2021 21:24:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11000 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229889AbhFZBYa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 25 Jun 2021 21:24:30 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15Q1M4Mq008728
        for <bpf@vger.kernel.org>; Sat, 26 Jun 2021 01:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=Lfg5texR+rCcl/VocOMvqiIHOR5xN3dlHKLmTBLHxOQ=;
 b=kHBPGojgf+dlctCfqxodCqWtVVLctsDYQmBTYZ/mxDAYfN1rSsljVdn3qS/ZWjdCO4U3
 V/5D+IoEKIYUzYPjjsdbmIgtZJ0JNw7/e96zQ5jxIJLJTfdOyeSZv3srw3/vzrb62iWZ
 G+vg+vPU0+MUfPOraTcAHbrgx602qVEW1L39YK2SrLURcuHxUOuC32sndESYi8jRqkd3
 ek9IthOFOKJFpzdFuWH1QmHIY0UEIljuPGP+M+6TVSO/3NpLHpnZfedqubxyfl9LBQsW
 y72mXjm2xP74xklLbxoMl2Hts7/6mUsfewEjyPHdVNU5x1EecP5aaj9aZ3+fAh2fplmN mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d2kxtdfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <bpf@vger.kernel.org>; Sat, 26 Jun 2021 01:22:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15Q1LTtC060221
        for <bpf@vger.kernel.org>; Sat, 26 Jun 2021 01:22:07 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2043.outbound.protection.outlook.com [104.47.56.43])
        by userp3020.oracle.com with ESMTP id 39dbb2au9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <bpf@vger.kernel.org>; Sat, 26 Jun 2021 01:22:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VACFMNsE17ksrEzVHhrRbSIhXrEU3da1Y7UjYhHeljLGkjvdcS94nMbFR55GubIvXYPe15lr3H/gUCpoc6Hv8JGmpqqOpGXTXQKtVkl114QaCYzmWwEZxvOoj3u2A+KEnYguO7E0/+z41MwICxO4zU+ox5RqAq/khJ3gBTrk8Nhg+VqcfgOSv/2EV2FwPh1/qCz2L0g0ubBaMbsrh1q4MlXe7giJav+tQuVmeqiYxP5GZVg9Yi3mrD3c+A0JVLIV9n5RKPBXwKvB84273JVDDhNZ168ZQGEIgOs1/NVEkhHZd47pE5KLeb7aoQfT4XT9NDjXeZKdwxC9kVsY4J0vzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lfg5texR+rCcl/VocOMvqiIHOR5xN3dlHKLmTBLHxOQ=;
 b=azl4FrgB1vAT0BuxTeS2Zg6t6Ns+DhwRWPbfBTpu8nEAzA/dyGxzzLBMEFmPdshIEyRD6GXxtRfyDx3+G5/A3dF/9BIN6DF6mFREzJkW+b2xpo0BrZwsAlO8YiIYidPA1wUqbNLhuTPTTfvGN2jB88HnfT3kfVm4aUg+WBrhJBslNpNgjUC2H/tkOrurr2Lqazey3/1k/QB4kkelqCR1ZcmtlVB3RQqRRFJZHsZr81Nly0uQ4CaSEEPm5HzDgj7E2MktORztlIsl50bggvzliCW/3ySgwlZiXQGYak72JQfpHbzusF9oIqV8I7gXSgjhNNYT68j1BxqRmjMmzFJUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lfg5texR+rCcl/VocOMvqiIHOR5xN3dlHKLmTBLHxOQ=;
 b=l1F0yXaoqcNceNNcTn8Qec4jQFsHtjwZq+3DdIBeZegC1MNAr0bh67/ooDtOflwpFlaX2FD8RICdAfvlJd8cCwjyjzVrI7g7h6Mdan0aShdbWqj/mnWT6XDbQaiabqNg+arn9qEx2lHJWFZcRQXJvl0eZbaQ6FDzY+PKjrqqDyc=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4644.namprd10.prod.outlook.com (2603:10b6:303:99::24)
 by CO1PR10MB4770.namprd10.prod.outlook.com (2603:10b6:303:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Sat, 26 Jun
 2021 01:22:05 +0000
Received: from CO1PR10MB4644.namprd10.prod.outlook.com
 ([fe80::f9:e074:c1c2:955f]) by CO1PR10MB4644.namprd10.prod.outlook.com
 ([fe80::f9:e074:c1c2:955f%7]) with mapi id 15.20.4264.023; Sat, 26 Jun 2021
 01:22:05 +0000
Subject: Re: using skip>0 with bpf_get_stack()
To:     bpf@vger.kernel.org
References: <30a7b5d5-6726-1cc2-eaee-8da2828a9a9c@oracle.com>
 <c65ac449-ec54-3dff-5447-8a318001285b@fb.com>
From:   Eugene Loh <eugene.loh@oracle.com>
Message-ID: <1b59751f-0bb1-a4ad-6548-2536e60a80ec@oracle.com>
Date:   Fri, 25 Jun 2021 21:22:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <c65ac449-ec54-3dff-5447-8a318001285b@fb.com>
Content-Type: multipart/mixed;
 boundary="------------7AF13DA0DDAFAFBF29A48905"
Content-Language: en-US
X-Originating-IP: [148.87.23.10]
X-ClientProxiedBy: SA9P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::23) To CO1PR10MB4644.namprd10.prod.outlook.com
 (2603:10b6:303:99::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (148.87.23.10) by SA9P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Sat, 26 Jun 2021 01:22:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74be9c7f-9a21-4437-ca00-08d93840ced8
X-MS-TrafficTypeDiagnostic: CO1PR10MB4770:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4770E4FCFD6814578968B193FF059@CO1PR10MB4770.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ixdn+j6+bqSFp/ejTllwsAR/3JQPWVsF7JQu8bJDFckR3cyQCqH4rgOaQppY5kqvwxEfV/rHC6fehejpr5ehpL9nWWRopWE0USmrvWQsZcQcIjjIe+VbbQtU4+WS8uZiYrf8PN6eTfU9nJeUp1FS0RJlnJC13a/l87/giWmLR1kjdtGz7r3GvbrKoRbq/Ez8a3Lui0Sl7BzqKZBer6J986kic+skBo1qSvUXpKWFRvYElI8zEYpCUNldYclKF/fdyxLC2Ht9Z5E0PdaYLNq4r1IrWqiwZhzi+dyd3Ln7fTZBlEZMo+MOj6UoCtQbqcW1GofJegAWV1Urp8wJ0ZnQTGnDG4K8lwz/PpqfgXAOgP5QR7PSe5Sb6Dl2gIR9Io/vT2CLSfgmMh57iuUabdPJBkAw9M7TQL17ExdC00Jm0GKYE6m93Gc+SJOL5QjdatqrLMcXpFwFkW7hPonLcXM0wVU3hR85b/hnBlRwKEoDfyoaTzUMaLL4qLE9MhGBOedHApPrRWVp85bN8uMQ897O0P3/ZpICS3PPi9WieRoOKPnYRADnciIcbHel/GUNsN3yXq8CD/iIfxVfcM7ZRwgCqeTteZvsa2KDO+8/kPv0co1ZT/Fxv0dGubma548+fml+jqC4MXcAxClG9/de+m3gesJExe0JiUtzUSImvCj6KDanZV29tsNuJcAIyeUMhsCjK4zQ7MuuJeqezr5oSGU72HHidgPXFfxciUy9gADEPC7aV6tPbiOpEszfTWXD7lWonLiMeNAZwcP7NCDibWRzfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4644.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(396003)(376002)(366004)(956004)(38100700002)(53546011)(235185007)(6506007)(478600001)(2906002)(5660300002)(83380400001)(86362001)(2616005)(44832011)(36756003)(31696002)(6512007)(6486002)(66946007)(8676002)(31686004)(66476007)(66556008)(316002)(6916009)(26005)(186003)(33964004)(66616009)(16526019)(8936002)(69590400013)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVk2eWNHVDVOeDM1aHl0RG9RcE8rSS96NHU4SVA1QnV4OTd6U3pXMUJPeGtQ?=
 =?utf-8?B?VUFFT1kvVjk4bUVsdXBKcnlsN0NoUVdkbnF5T29GZDBwdG51QXdQNGRhSEVz?=
 =?utf-8?B?cEhaWjVsa0hjOU9aN2dncUNURDB5L1lrL3ByZHRqcFhKalFaYTFyR0hLNjZ6?=
 =?utf-8?B?ckFTK2NEU1FVay90VmtjZFJZODlLVUJiOUs1UDViWldYOTE4WUpiWVI3RHZs?=
 =?utf-8?B?cWlDRzlZbVlUb284Mmo1SmFHV1RTZFFSWGJvTkkxNE5zN01xeWJKa0o3QWpP?=
 =?utf-8?B?YW1naE5PNTNoZEJDMDYrdnlhY0szVzFObkpOZHhaTE8vY2RYZ3pqZ25rWTFv?=
 =?utf-8?B?RW04UUFod0o4a1hCNzVMaU45NCtZdVhoQ1N5Z3I4YXFON1I2NVkzTWZ1QnhM?=
 =?utf-8?B?TVFXbEQ1MnIwL1hkUHkrNnNuVFRvcER1WDBWYlJuNkl5Rk1sSVd6Ny9WdW9X?=
 =?utf-8?B?aVBMNDJBNGNKUmJ1UUs3TXhPNHZDSERYdENKQWUzcVdOMmtGdzFlaVl2YjFr?=
 =?utf-8?B?Rk9qd0QwS2FYdW81c1pyOE1Zb3piV3p1YXAvaTNaYTh3UEpmQjRvM1Q3TTNS?=
 =?utf-8?B?citDNHJyWFNYcEVzOEduMDBqRXRYWkMvMnFGV0doNkc0MXVhRUV1UHBHTXpJ?=
 =?utf-8?B?SEtiZkIvVDIvSDBzUERsb1BXeGVEeUtwWVN3OFNwSXoxbE5MZUg2dkpBMm9n?=
 =?utf-8?B?OW0wbGV4YXM0K1F5cjJqL3h0bTVSNlJHZWFKYlZ3OW5zMXFrRVJISkRqRytK?=
 =?utf-8?B?KzVRaGZXUWlya1VSdHBZYVlBRkxwTlpHUWhXOWJuMmxFdFJDRXZqVXM1Y2JK?=
 =?utf-8?B?WWMxSFpBQ0hpMHVMQ3puUmUwSTdvdklXb2RZejhkU3F3Ly9TR1RRR1JUdEls?=
 =?utf-8?B?TjZGVEJyUzVrdTkzNHUveEQxUG5MY3lTSWJRbk9lT0MwNWNVaG9UWWwyZHdF?=
 =?utf-8?B?Rmw4QTJIUUdkMkN3V2NjWFpIdlFvWkhkMEdOSHNSbWZKOTdlTVhFSGVGZWM5?=
 =?utf-8?B?cE12STk2QTk3dzYzVEVRY3BRVEY0NFcyMVFSTWU2Z0FTaUU5VEJnWE9SNTV1?=
 =?utf-8?B?MlIrZlI3bzFMajZTVGdoeVZDcTUraXZaSGpGdFQyQ2VKVkpWNFhMUnBCK2dm?=
 =?utf-8?B?dGJ6NmRGL0lzaUMrQXNiSmhUaGFpbkdKNklvcW5NYUhvQW1zOU5yS3Q3L252?=
 =?utf-8?B?WFF6YisyZkpUbGVGMnZHanJHMStwMVBQcEt3R0F4Z29ZS3I2dXU0RmdJajAx?=
 =?utf-8?B?cTZTbW5LTXloeldBeW1mS0hXOWsvYm1nWHdIS1FnZzlISU5sdlAwS3hsUTF6?=
 =?utf-8?B?ckYxRER4Uy9jM1NNMG43NHZ6Q3ZhU043eEpGbGM3NE43bzM0WGhpd0d6VmMx?=
 =?utf-8?B?VjljN1YwanMzQnBNYTVyRDRMY1p4V1RWRWNZdy9NWjh0SVFKdnpwNnRJL1NX?=
 =?utf-8?B?aTFUbmRZTHYrTGVKcjgxSGx3RlIvenpIeXgwc3NURDJnREdnbjhwTXlLSlZB?=
 =?utf-8?B?UWc2Q1N2di9HVDNHbWxrZi9aUWdKWndFcHNvZFZZSFVWaVJpbWh0SzBqUzNn?=
 =?utf-8?B?OEgySG1rMUhnZVRqUmljc0xmY05HbDlBTnJka1FpM0ovSG0ybldsRFVoVmJw?=
 =?utf-8?B?NnF3b0hWLzRvWUdXM0pJZVZhc3R2SlNiTzRHZzlpMDdocUhVS2hMRzRiNDRM?=
 =?utf-8?B?TE9YUUlGVmx3SzRnRmVoVG05bzRoaFEzV1lnWCtVd1lCUEtPQWRjYXJlUWJ5?=
 =?utf-8?Q?uWOggc9cDhJ7GtBpoZ1rUrU7oam6HndnGKNqE6n?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74be9c7f-9a21-4437-ca00-08d93840ced8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4644.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2021 01:22:05.1780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gD5v9aP6f0CWtYF6yHez8H/uC+2Ln8FopIItoQnD4QAFx7Fb34garKRXqWGynn7ACoyn6+jHp7IQ2VW6/4DZcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4770
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10026 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106260006
X-Proofpoint-GUID: kUYkVXUcP9-xC9vw-SS0-QWZlhPdW2u0
X-Proofpoint-ORIG-GUID: kUYkVXUcP9-xC9vw-SS0-QWZlhPdW2u0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--------------7AF13DA0DDAFAFBF29A48905
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/1/21 5:48 PM, Yonghong Song wrote:
>
>
> On 5/28/21 3:16 PM, Eugene Loh wrote:
>> I have a question about bpf_get_stack(). I'm interested in the case
>>          skip > 0
>>          user_build_id == 0
>>          num_elem < sysctl_perf_event_max_stack
>>
>> The function sets
>>          init_nr = sysctl_perf_event_max_stack - num_elem;
>> which means that get_perf_callchain() will return "num_elem" stack 
>> frames.  Then, since we skip "skip" frames, we'll fill the user 
>> buffer with only "num_elem - skip" frames, the remaining frames being 
>> filled zero.
>>
>> For example, let's say the call stack is
>>          leaf <- caller <- foo1 <- foo2 <- foo3 <- foo4 <- foo5 <- foo6
>>
>> Let's say I pass bpf_get_stack() a buffer with num_elem==4 and ask 
>> skip==2.  I would expect to skip 2 frames then get 4 frames, getting 
>> back:
>>          foo1  foo2  foo3  foo4
>>
>> Instead, I get
>>          foo1  foo2  0  0
>> skipping 2 frames but also leaving frames zeroed out.
>
> Thanks for reporting. I looked at codes and it does seem that we may
> have a kernel bug when skip != 0. Basically as you described,
> initially we collected num_elem stacks and later on we reduced by skip
> so we got num_elem - skip as you calculated in the above.
>
>>
>> I think the init_nr computation should be:
>>
>> -       if (sysctl_perf_event_max_stack < num_elem)
>> +       if (sysctl_perf_event_max_stack <= num_elem + skip)
>>                  init_nr = 0;
>>          else
>> -               init_nr = sysctl_perf_event_max_stack - num_elem;
>> +               init_nr = sysctl_perf_event_max_stack - num_elem - skip;
>
> A rough check looks like this is one correct way to fix the issue.
>
>> Incidentally, the return value of the function is presumably the size 
>> of the returned data.  Would it make sense to say so in 
>> include/uapi/linux/bpf.h?
>
> The current documentation says:
>  *      Return
>  *              A non-negative value equal to or less than *size* on 
> success,
>  *              or a negative error in case of failure.
>
> I think you can improve with more precise description such that
> a non-negative value for the copied **buf** length.
>
> Could you submit a patch for this? Thanks!

Sure.  Thanks for looking at this and sorry about the long delay getting 
back to you.

Could you take a look at the attached, proposed patch?  As you see in 
the commit message, I'm unclear about the bpf_get_stack*_pe() variants.  
They might use an earlier construct callchain, and I do not know how 
init_nr was set for them.

--------------7AF13DA0DDAFAFBF29A48905
Content-Type: text/plain; charset=UTF-8;
 name="0001-bpf-Adjust-BPF-stack-helper-functions-to-accommodate.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-bpf-Adjust-BPF-stack-helper-functions-to-accommodate.pa";
 filename*1="tch"

RnJvbSA3MGRhOTA1N2Q3ZmE3ZGRhNzZlMWIwODYxYjhhMDE3NDA3ODQzNGVhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFdWdlbmUgTG9oIDxldWdlbmUubG9oQG9yYWNsZS5jb20+CkRh
dGU6IEZyaSwgMjUgSnVuIDIwMjEgMTU6MTg6NDYgLTA3MDAKU3ViamVjdDogW1BBVENIXSBicGY6
IEFkanVzdCBCUEYgc3RhY2sgaGVscGVyIGZ1bmN0aW9ucyB0byBhY2NvbW1vZGF0ZSBza2lwPjAK
CkxldCdzIHNheSB0aGF0IHRoZSBjYWxsZXIgaGFzIHN0b3JhZ2UgZm9yIG51bV9lbGVtIHN0YWNr
IGZyYW1lcy4gIFRoZW4sCnRoZSBCUEYgc3RhY2sgaGVscGVyIGZ1bmN0aW9ucyB3YWxrIHRoZSBz
dGFjayBmb3Igb25seSBudW1fZWxlbSBmcmFtZXMuClRoaXMgbWVhbnMgdGhhdCBpZiBza2lwPjAs
IG9uZSBrZWVwcyBvbmx5IG51bV9lbGVtLXNraXAgZnJhbWVzLgoKQ2hhbmdlIHRoZSBjb21wdXRh
dGlvbiBvZiBpbml0X25yIHNvIHRoYXQgbnVtX2VsZW0rc2tpcCBzdGFjayBmcmFtZXMgYXJlCndh
bGtlZCAoYW5kIGhlbmNlIG51bV9lbGVtIGZyYW1lcyBhcmUga2VwdCkuCgpbTkI6ICBJIGFtIHVu
c3VyZSBvZiB0aGUgYnBmX2dldF9zdGFjaypfcGUoKSB2YXJpYW50cywgd2hpY2ggaW4gdGhlIGNh
c2Ugb2YKX19QRVJGX1NBTVBMRV9DQUxMQ0hBSU5fRUFSTFkgdXNlIGN0eC0+ZGF0YS0+Y2FsbGNo
YWluLCB3aGljaCB3YXMgd2Fsa2VkCmVhcmxpZXIuICBJIGFtIHVuY2xlYXIgaG93IGluaXRfbnIg
d2FzIGNob3NlbiBmb3IgaXQuXQoKQ2hhbmdlIHRoZSBjb21tZW50IG9uIGJwZl9nZXRfc3RhY2so
KSBpbiB0aGUgaGVhZGVyIGZpbGUgdG8gYmUgbW9yZQpleHBsaWNpdCB3aGF0IHRoZSByZXR1cm4g
dmFsdWUgbWVhbnMuCgpTaWduZWQtb2ZmLWJ5OiBFdWdlbmUgTG9oIDxldWdlbmUubG9oQG9yYWNs
ZS5jb20+Ci0tLQogaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oIHwgIDQgKystLQoga2VybmVsL2Jw
Zi9zdGFja21hcC5jICAgIHwgMjYgKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KIDIgZmlsZXMg
Y2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oCmluZGV4
IDc5Yzg5MzMxMDQ5Mi4uN2M3YjkzZTFkYjkwIDEwMDY0NAotLS0gYS9pbmNsdWRlL3VhcGkvbGlu
dXgvYnBmLmgKKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oCkBAIC0yMTgzLDggKzIxODMs
OCBAQCB1bmlvbiBicGZfYXR0ciB7CiAgKgogICogCQkJIyBzeXNjdGwga2VybmVsLnBlcmZfZXZl
bnRfbWF4X3N0YWNrPTxuZXcgdmFsdWU+CiAgKiAJUmV0dXJuCi0gKiAJCUEgbm9uLW5lZ2F0aXZl
IHZhbHVlIGVxdWFsIHRvIG9yIGxlc3MgdGhhbiAqc2l6ZSogb24gc3VjY2VzcywKLSAqIAkJb3Ig
YSBuZWdhdGl2ZSBlcnJvciBpbiBjYXNlIG9mIGZhaWx1cmUuCisgKiAJCVRoZSBub24tbmVnYXRp
dmUgY29waWVkICpidWYqIGxlbmd0aCBlcXVhbCB0byBvciBsZXNzIHRoYW4KKyAqIAkJKnNpemUq
IG9uIHN1Y2Nlc3MsIG9yIGEgbmVnYXRpdmUgZXJyb3IgaW4gY2FzZSBvZiBmYWlsdXJlLgogICoK
ICAqIGxvbmcgYnBmX3NrYl9sb2FkX2J5dGVzX3JlbGF0aXZlKGNvbnN0IHZvaWQgKnNrYiwgdTMy
IG9mZnNldCwgdm9pZCAqdG8sIHUzMiBsZW4sIHUzMiBzdGFydF9oZWFkZXIpCiAgKiAJRGVzY3Jp
cHRpb24KZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvc3RhY2ttYXAuYyBiL2tlcm5lbC9icGYvc3Rh
Y2ttYXAuYwppbmRleCBiZTM1YmZiN2ZiMTMuLmUyYTE5MzU4MTU1MCAxMDA2NDQKLS0tIGEva2Vy
bmVsL2JwZi9zdGFja21hcC5jCisrKyBiL2tlcm5lbC9icGYvc3RhY2ttYXAuYwpAQCAtMjQ5LDIz
ICsyNDksMzAgQEAgZ2V0X2NhbGxjaGFpbl9lbnRyeV9mb3JfdGFzayhzdHJ1Y3QgdGFza19zdHJ1
Y3QgKnRhc2ssIHUzMiBpbml0X25yKQogI2VuZGlmCiB9CiAKK3N0YXRpYyB1MzIgZ2V0X2luaXRf
bnIodTMyIG5lbGVtLCB1NjQgZmxhZ3MpCit7CisJdTMyIHNraXAgPSBmbGFncyAmIEJQRl9GX1NL
SVBfRklFTERfTUFTSzsKKworCWlmIChzeXNjdGxfcGVyZl9ldmVudF9tYXhfc3RhY2sgPD0gbmVs
ZW0gKyBza2lwKQorCQlyZXR1cm4gMDsKKwllbHNlCisJCXJldHVybiBzeXNjdGxfcGVyZl9ldmVu
dF9tYXhfc3RhY2sgLSBuZWxlbSAtIHNraXA7Cit9CisKIHN0YXRpYyBsb25nIF9fYnBmX2dldF9z
dGFja2lkKHN0cnVjdCBicGZfbWFwICptYXAsCiAJCQkgICAgICBzdHJ1Y3QgcGVyZl9jYWxsY2hh
aW5fZW50cnkgKnRyYWNlLCB1NjQgZmxhZ3MpCiB7CiAJc3RydWN0IGJwZl9zdGFja19tYXAgKnNt
YXAgPSBjb250YWluZXJfb2YobWFwLCBzdHJ1Y3QgYnBmX3N0YWNrX21hcCwgbWFwKTsKIAlzdHJ1
Y3Qgc3RhY2tfbWFwX2J1Y2tldCAqYnVja2V0LCAqbmV3X2J1Y2tldCwgKm9sZF9idWNrZXQ7CiAJ
dTMyIG1heF9kZXB0aCA9IG1hcC0+dmFsdWVfc2l6ZSAvIHN0YWNrX21hcF9kYXRhX3NpemUobWFw
KTsKLQkvKiBzdGFja19tYXBfYWxsb2MoKSBjaGVja3MgdGhhdCBtYXhfZGVwdGggPD0gc3lzY3Rs
X3BlcmZfZXZlbnRfbWF4X3N0YWNrICovCi0JdTMyIGluaXRfbnIgPSBzeXNjdGxfcGVyZl9ldmVu
dF9tYXhfc3RhY2sgLSBtYXhfZGVwdGg7CisJdTMyIGluaXRfbnI7CiAJdTMyIHNraXAgPSBmbGFn
cyAmIEJQRl9GX1NLSVBfRklFTERfTUFTSzsKIAl1MzIgaGFzaCwgaWQsIHRyYWNlX25yLCB0cmFj
ZV9sZW47CiAJYm9vbCB1c2VyID0gZmxhZ3MgJiBCUEZfRl9VU0VSX1NUQUNLOwogCXU2NCAqaXBz
OwogCWJvb2wgaGFzaF9tYXRjaGVzOwogCi0JLyogZ2V0X3BlcmZfY2FsbGNoYWluKCkgZ3VhcmFu
dGVlcyB0aGF0IHRyYWNlLT5uciA+PSBpbml0X25yCi0JICogYW5kIHRyYWNlLW5yIDw9IHN5c2N0
bF9wZXJmX2V2ZW50X21heF9zdGFjaywgc28gdHJhY2VfbnIgPD0gbWF4X2RlcHRoCi0JICovCisJ
aW5pdF9uciA9IGdldF9pbml0X25yKG1heF9kZXB0aCwgZmxhZ3MpOwogCXRyYWNlX25yID0gdHJh
Y2UtPm5yIC0gaW5pdF9ucjsKIAogCWlmICh0cmFjZV9uciA8PSBza2lwKQpAQCAtMzMxLDggKzMz
OCw3IEBAIEJQRl9DQUxMXzMoYnBmX2dldF9zdGFja2lkLCBzdHJ1Y3QgcHRfcmVncyAqLCByZWdz
LCBzdHJ1Y3QgYnBmX21hcCAqLCBtYXAsCiAJICAgdTY0LCBmbGFncykKIHsKIAl1MzIgbWF4X2Rl
cHRoID0gbWFwLT52YWx1ZV9zaXplIC8gc3RhY2tfbWFwX2RhdGFfc2l6ZShtYXApOwotCS8qIHN0
YWNrX21hcF9hbGxvYygpIGNoZWNrcyB0aGF0IG1heF9kZXB0aCA8PSBzeXNjdGxfcGVyZl9ldmVu
dF9tYXhfc3RhY2sgKi8KLQl1MzIgaW5pdF9uciA9IHN5c2N0bF9wZXJmX2V2ZW50X21heF9zdGFj
ayAtIG1heF9kZXB0aDsKKwl1MzIgaW5pdF9ucjsKIAlib29sIHVzZXIgPSBmbGFncyAmIEJQRl9G
X1VTRVJfU1RBQ0s7CiAJc3RydWN0IHBlcmZfY2FsbGNoYWluX2VudHJ5ICp0cmFjZTsKIAlib29s
IGtlcm5lbCA9ICF1c2VyOwpAQCAtMzQxLDYgKzM0Nyw3IEBAIEJQRl9DQUxMXzMoYnBmX2dldF9z
dGFja2lkLCBzdHJ1Y3QgcHRfcmVncyAqLCByZWdzLCBzdHJ1Y3QgYnBmX21hcCAqLCBtYXAsCiAJ
CQkgICAgICAgQlBGX0ZfRkFTVF9TVEFDS19DTVAgfCBCUEZfRl9SRVVTRV9TVEFDS0lEKSkpCiAJ
CXJldHVybiAtRUlOVkFMOwogCisJaW5pdF9uciA9IGdldF9pbml0X25yKG1heF9kZXB0aCwgZmxh
Z3MpOwogCXRyYWNlID0gZ2V0X3BlcmZfY2FsbGNoYWluKHJlZ3MsIGluaXRfbnIsIGtlcm5lbCwg
dXNlciwKIAkJCQkgICBzeXNjdGxfcGVyZl9ldmVudF9tYXhfc3RhY2ssIGZhbHNlLCBmYWxzZSk7
CiAKQEAgLTQ1OCwxMCArNDY1LDcgQEAgc3RhdGljIGxvbmcgX19icGZfZ2V0X3N0YWNrKHN0cnVj
dCBwdF9yZWdzICpyZWdzLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ssCiAJCWdvdG8gZXJyX2Zh
dWx0OwogCiAJbnVtX2VsZW0gPSBzaXplIC8gZWxlbV9zaXplOwotCWlmIChzeXNjdGxfcGVyZl9l
dmVudF9tYXhfc3RhY2sgPCBudW1fZWxlbSkKLQkJaW5pdF9uciA9IDA7Ci0JZWxzZQotCQlpbml0
X25yID0gc3lzY3RsX3BlcmZfZXZlbnRfbWF4X3N0YWNrIC0gbnVtX2VsZW07CisJaW5pdF9uciA9
IGdldF9pbml0X25yKG51bV9lbGVtLCBmbGFncyk7CiAKIAlpZiAodHJhY2VfaW4pCiAJCXRyYWNl
ID0gdHJhY2VfaW47Ci0tIAoyLjI3LjAKCg==

--------------7AF13DA0DDAFAFBF29A48905--
