Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1373EBB3D
	for <lists+bpf@lfdr.de>; Fri, 13 Aug 2021 19:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhHMRT4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Aug 2021 13:19:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36248 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229533AbhHMRTz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Aug 2021 13:19:55 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17DHAGFW019631;
        Fri, 13 Aug 2021 10:19:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=MRDctgWIfmJk6aay6mQlT+w/EQgAmC8uEXaEdD4Joxw=;
 b=CGM+/gOTq2UlXrKFT5w/JJneXTWoquHgnpKSg5I0IPpEHGST48ewjhdwy8RvkWayZt0X
 DLlWQdl5yLnSd/dnUHomer4QotNEwsa9VfPC7zhIlGLc8B5ILmxM0RUZwEDhpNh8y/5z
 ZZRbI7qu+IOoJRBIA82ZQBD8X5Q4409k5No= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3acxqb2n9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 13 Aug 2021 10:19:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 13 Aug 2021 10:19:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8IcMk3dNDEQr03/khyWXPAa6+H3Iw7KEExczdcYWGBAaBXGKqGXVNP2ylmHMA9Co8F7cyU+WtqHlIfpcQ8o2VThsGMMxgghacnvcGRFp1i+x81CdOFVxptzypFrWxxdU19qST4fbQ5aBPZLJ0hdHLI8YHcpLcK3rOfGe4puLSBFwMLadHsRwu+72DXfRGJdmhDcH8STbwSjsOVQfWW678vubzkG3s6K3th9A1OZnD30PRckizh9F5jAIX3wKnXtKm7TodMSqKnNQ2OmnurAG5WNvh5HGmOU99WB+DXA5GqbCh7xNSfCEEuQqJIY0PUXdTO9munCZEEn7/6UDRoqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRDctgWIfmJk6aay6mQlT+w/EQgAmC8uEXaEdD4Joxw=;
 b=ne7GnoSxZWMogrHNU/GPVISw5uUHrQOSqgEjRA1oKFo9lCG4vqVxt9BvVKxjhYSkMy53zgLgL+ZAQlC7W44+6XA3qBcQyKdbuvc32sP0DnMbKxextS34ke29aStgnXD7DdV0GImi7OrltHHyuu+V+y3wSMWmM6cX+F+zZauyqf/sshwclQOKiRvpb8ACRAXcQotpLSa+JL7Vii/M9LlxZMwVde8G8UZXdDQkEY+yLoFiVDpDngvfLyGJ7itVl04ML6IFErOiYQf8h+n7eE6snfGdB5Ai8JB9GJ6G6r4hdkq3+YIvjfAsa2/oFTJVQj/dT2go2wFrITfn/c1HpWpwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB4094.namprd15.prod.outlook.com (2603:10b6:805:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Fri, 13 Aug
 2021 17:19:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4415.017; Fri, 13 Aug 2021
 17:19:19 +0000
Subject: Re: signal/signal_deliver and bpf_send_signal()
To:     Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>,
        bpf <bpf@vger.kernel.org>
References: <HE1PR83MB038015B1D19B02219FB1315BFBFA9@HE1PR83MB0380.EURPRD83.prod.outlook.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <bda97fe2-d8b5-2539-273e-275276947b49@fb.com>
Date:   Fri, 13 Aug 2021 10:19:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <HE1PR83MB038015B1D19B02219FB1315BFBFA9@HE1PR83MB0380.EURPRD83.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0036.prod.exchangelabs.com (2603:10b6:a02:80::49)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1013] (2620:10d:c090:400::5:8f57) by BYAPR01CA0036.prod.exchangelabs.com (2603:10b6:a02:80::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Fri, 13 Aug 2021 17:19:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d89af399-b85f-4e5b-6dcb-08d95e7e7c2a
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4094:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB40946DF5650F5CA8361DB974D3FA9@SN6PR1501MB4094.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KeE3m88cjkZAaCcMKmpYq0rgwAQ+c1QtNIGrCG7+tiNDGIQuQj2nDpbDAQvtsvAKcjYe7uRxsS9F+2ngyhNRQibz3bOm4L+U1HLfGQrkqwsfaYExuxQ0K3KYd4MY4IXsYe+7m55qLqDCpC+RlCFWhfb5p5LPrbQ1MyxLHo2s5NgwqQkbPpnn15voYIJOB2YdF1QZze64U81S3ed2SSSQ0LyMH7V1hlvYnelR7G1fydVjB0RkQxhAAzxKP0WrtKf9b5sKxOhSKvEkuSGE5ItpXhFZEaHriFmPCQRjGSE+3rEaUjQHHIdTf0V+Vm6EoOngwUrb1/kz2kQQX2vQKvHcUXL6kcdglCTG4zT9WE2Cv+HOjfP0pBO7nr+Y25zbr6/ScUK4TXmhZ4cAlJP0rLMNeDrcTQcDb8rzWdPdoEz8uLlvcTCsZEn1/NqT2eA2eWtPl58pbh060YY5uaGa4du4sstVYdfioxr0Q9nyQTVZIoA3HUf9VugjldfiUiDblBp7q30Au6kieSi96qgfW99bzgugt5+yx+vvhcmdfD/fkAzSJrfZObmjQ/tbMFSY2Z4Xp3mZ6sxp1DYlqBBkN6E53I3UeJxA4R5w7Xbf0qaPneTaqd/SXtQQzZuT+BaT9kkURC5gTrSoCX1TsCbOJF09LRV0DpE46zIiQ3BGc4zTYV3CgV/6CJnMMGbidqXCPoML+P35er1nBj1PMbn9LfQJRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(8676002)(186003)(53546011)(66556008)(66476007)(52116002)(66946007)(316002)(31686004)(110136005)(2906002)(38100700002)(5660300002)(2616005)(8936002)(86362001)(31696002)(6486002)(478600001)(36756003)(83380400001)(45080400002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVJZZWhZQmtPdjZieWlEemNraWZSMVlqUEZDWjJqd2QrVks3Qzc1TEJSa3NS?=
 =?utf-8?B?Y0Y1ZlpPeU91SllIeG1ETm1qRVk1cjcrV2tlQnFsMWNENnVhOFB1Rm8ybDBz?=
 =?utf-8?B?VWR0R1ovU0NKVW1sVStpcHJCdlR2cWVBZmFEZkZYV0kvMm1wbjBsQ1drUWVZ?=
 =?utf-8?B?RlRrS3NVTmcwVEFMQXl4bDc0cGp1RWxRTFpxM29HN0NRakcwREdHbm5lS2NI?=
 =?utf-8?B?TnJSWUc5QU16b0NIWHBvbTZtcGk4a3U0clhVRkZDcmVyR0FlZjY5VWxUNlY1?=
 =?utf-8?B?M0Q5RVEyVzNVcWVXSmlTUnZGRGE0RW5xdU9ZNm1BMC8ySmJzNlZvYThoQUk5?=
 =?utf-8?B?VFJ2cVFGTkg3V1Zzc24zNGg1NzNXdVY3NXdLSWRCZTdKdm9qR2RJK0R4enJl?=
 =?utf-8?B?UnREVk1PaEZ2MmJ3ckdYcHVTUTlYOFFkSkxycnN5OXRDYktqOWE5dHYzdml6?=
 =?utf-8?B?dE80YlMrUTdScVdTLzl1d1FYUmJJbXRKa3N1U3E2bEFLa1R4anVDUzlOWkpJ?=
 =?utf-8?B?aTFoWlVVdFhDNnpQbnJVeGp5bzF1RWRHek82b05lQ0dFbkFyeWVrTWQ0ZXEy?=
 =?utf-8?B?ZCt6MllpZ3lmVUxFQi9yUEpYUjZ4d0ZKMjRvU294eVNEV1pJdzV3a3BKVHdn?=
 =?utf-8?B?UWV5eWoySXhXNWhPRmxxdW1tUml6c0tlUW5hWHdpYW50cm5RNHBSZVU3MHFK?=
 =?utf-8?B?Y1hYKzUvRTQ3aWF3SmNPMlBmd3RXRlgxemQzNjI3alA4Q3VLZzFnc042K01p?=
 =?utf-8?B?MTBxbURlQ0ViUTkzSlVsMmVLcE1qUThZS3FDRGtkQ0g3bERiUnNZU05QS01n?=
 =?utf-8?B?UE93THNQNWxmMW9mYVAvbHFTMGtFQW4rY1RkaGo3NW9CVy93SGlXWmV1TFFy?=
 =?utf-8?B?TnpoeW1xYXhpdExWQXIzRm9PV0R3M3BNQ3p0NlRjbkF5Ym9xSHdaQWJsQjJH?=
 =?utf-8?B?dHZyOFhBZU10aWg2TkM2aStvUlBSaFg4M0g0NnRSWFZxT0RsTmZDZjIwTHlT?=
 =?utf-8?B?a092U1J5QjdtU0hUOGVDTFJtTWFPRnErSHFDYlNIOTVIdEoyOUpEaUIxVFc5?=
 =?utf-8?B?aHNPeUdBYklVZzhOb1JmRXdLYTVGNVJWMkxBV3lLUTRFNmtMWStnSllrdHZZ?=
 =?utf-8?B?ZGd3aFdHQmdWM1dSVTNocWlPTFMvWEo5SisyT1BpM29BQnlRSGI3RExudlRJ?=
 =?utf-8?B?TUh2MlQ4V2owZzlUVkYwMWEvVUgzQXlNRkVURGJiYUZCT3g0SjRKU2UvNzYv?=
 =?utf-8?B?K1dQVlhNeERIM3Vab3dPN2ltcCsrTHlGdCtnQ3hMZjRySzUzTC9LdnpRa1FX?=
 =?utf-8?B?L1luSmlFSnJBVDJubHo4SFlZa3BYRDExRmRUdU1NOElIZmZyblRMMng1Y01N?=
 =?utf-8?B?L0t3YUNjQU1mOElMbzFhMHk0aXlyalQrdDI5dVNha25MU3lGZ0czRmMyUVlv?=
 =?utf-8?B?RFp6M1dqV1l1U2E5SXZOSVkwNHRXTXI5NktHNkFrUkYzMEdoWFpzOVlEL0J5?=
 =?utf-8?B?YTQzeFVxZHJDNU5Ob0xhVThFcVhUNkJ0T0JJMWVZT3c2aTdqVUlNa2hCYnJE?=
 =?utf-8?B?MVVvWDNmQkp4SkwxcjNYN2k3UE5mMDYwOUxnTVJMWnFTeEZCS09TSU8xN1Vn?=
 =?utf-8?B?RHdyRlNuWHJ6YzhyVHFoRkdQZDF0RmNuYlg1M1l2QlZocFBDL0hOMG1qUHFl?=
 =?utf-8?B?T3NLeDFBbXQ1WFNSU3hBUGFianNCNHhDRjl4VlVEbVFidm1jM2tPRTlDWnkz?=
 =?utf-8?B?WDdUTnRZQngvSUVBclpTbHpBNTdFVjdERWFod3F5ZmlkRmdZbFJOamdlcEhD?=
 =?utf-8?B?ZFdLYmFZODBNYjdIRWIxQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d89af399-b85f-4e5b-6dcb-08d95e7e7c2a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 17:19:19.3170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxbBv653LRs/o4Tfu5brXRJXxnm7hrfS3Y6MfNXseaG6fgAwpZZtoEV1FGD/YCCS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4094
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 5qO7OSt-4jX1mqi9nErJ9KL13yWJtRKy
X-Proofpoint-ORIG-GUID: 5qO7OSt-4jX1mqi9nErJ9KL13yWJtRKy
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-13_06:2021-08-13,2021-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108130104
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/13/21 2:57 AM, Kevin Sheldrake wrote:
> Hello
> 
> I have a requirement to catch a specific signal hitting a specific process and to send it a SIGSTOP before that signal arrives.  This is so that the process can then be attached with ptrace(), but without the necessity of ptrace()ing the process continuously beforehand (due to performance and stability reasons).  I thought this might be possible with an eBPF program attached to a tracepoint.
> 
> I attached a program to the signal/signal_deliver tracepoint and used bpf_send_signal() to send the SIGSTOP but it didn't stop the process.  If I sent SIGTERM or SIGHUP instead it worked as expected, just not SIGSTOP or SIGTSTP.
> 
> Sending a SIGSTOP prior to another signal (eg SIGSEGV) works from userland - the process stops and the other signal is queued.
> 
> I'm guessing that the reason is that bpf_send_signal() adds the (non-state transitioning) signal to the process signal queue, ignoring SIGSTOP, SIGTSTP, SIGKILL, SIGCONT, but doesn't change the state of processes.  Can anyone confirm if that is correct or if there's another possible reason that bpf_send_signal seems to fail to send a SIGSTOP?  If so, is this documented anywhere?  Is there another way to do this with eBPF?

Kernel has SIG_KERNEL_IGNORE_MASK like below

#define SIG_KERNEL_IGNORE_MASK (\
         rt_sigmask(SIGCONT)   |  rt_sigmask(SIGCHLD)   | \
         rt_sigmask(SIGWINCH)  |  rt_sigmask(SIGURG)    )

So SIGCONT will be ignored for bpf_send_signal() helper.

For other signals e.g., SIGSTOP/SIGKILL, there are some comments saying 
special processing might be needed. But I think they may still get
delivered. If you use signal/signal_deliver when SIGSEGV is delivered,
is it already too late to do bpf_send_signal() SIGSTOP since that
will be processed after SIGSEGV? Note that SIGSEGV is already delivered?

> 
> Many thanks
> 
> Kev
> 
> --
> Kevin Sheldrake
> Microsoft Threat Intelligence Centre
> 
