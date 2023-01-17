Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A400566E4A3
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 18:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbjAQRQn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 12:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbjAQRQJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 12:16:09 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255DC4B762;
        Tue, 17 Jan 2023 09:15:27 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HG4Bie025632;
        Tue, 17 Jan 2023 09:14:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=06iMB/7jMc/qoBuGxYsjRbBoa8nllEBSMo6pFoppPLE=;
 b=EgiiBVej3NUKxAg2rji5cnzFKGwm/F1/0maRA+/vUrsc3y+ETtGGEeNPipWwd+AVhDaR
 XcbL/cY4f6eiPL4XFMMmwkjDtRoG2cLuUx7TGo2EIO0xE3+FdjlY08Emtg43ZGl+zpeA
 qZTPUVP+y5zFpYDqiJ6rs0EtoQCiExwKb/FsvEuUOZJ90qo1vV5V7WhWHf14sv6KGYn0
 vhfAZ3GXR2egqxBIYM7tVQsRRGl3TGxpCKd2eUPaSmSGL3xASAXqciTiUZG3aCxYrVkx
 Hbk9zBVOlHgM/+QhzBfMy/wY3lxG8/5vGf3+40503RYSWH91TGo4rm5ojvLN6Fh4M/iW /A== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n5rcwjujs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 09:14:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dfg0MzfVPf5FsCBNhkbAg9HTTC25qR41Rf+E2IVrtRjJ86vxJJdlWfXBdUcDyRM6OCttkSVHBpo6GE7lj4Qz1OJNJ0rjZt1KuhMNDfWmFNdGkHZZFiDdy+tX+N0hdZxXOJixgL7j6Zt36yeyqYJoCcombTXP1aOGq9Ou1WwD/XGGxdDLkEu5OabZ5YPo9F3qj7Zx1tIpNXuAZkwedwfMqSzSJAwQcrwURY5y24HAOSIFYmvkblGnslYQ58kc5447jr/Jgw41CdIWHbb5b3+0yK6F7Iy9LC0xVjMR/B1lbzMqw8c4K2cSdFvkZG5B+XF+ZvyE2uMbtv7BznXUe9a6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06iMB/7jMc/qoBuGxYsjRbBoa8nllEBSMo6pFoppPLE=;
 b=huvNLl9tcfgLBBwdn/ZB3gYHxqZSUnhh9ltOH95KJHLCSjsnWvFeAMgcMfEQolaWk0AQDs9uHoMFbgq3mduhOrQ2haEp3d+QvwNixGMMgm2rIzDk/SkzIMp7LayLyIu/jQslB3qsqv73xPP9YdPM+yTzWeuJZzXmkOM/4PRU2MELYrg+I8qaU0BKYVYwOxxR8YAJEtlNJDVrXHwzQG6OzGRQ02YjPJPwWzofzP5Tarsx+MI7mPY1UOtZKR/kMyZi8Rs1QVypVVp0AEjVIoPQu1uuQbw20/KAaD/QqhisUG6M+XtkaKUfTWggKnNJqmsbNS1W7+xnlikPWLhNB2+pGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3831.namprd15.prod.outlook.com (2603:10b6:5:2b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 17:14:42 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 17:14:42 +0000
Message-ID: <806bd4c6-7dff-f740-3625-849282310ce0@meta.com>
Date:   Tue, 17 Jan 2023 09:14:38 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] tools: bpf: Disable stack protector
Content-Language: en-US
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     Peter Foley <pefoley2@pefoley.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        david.faust@oracle.com, elena.zannoni@oracle.com
References: <20230114-bpf-v1-1-f836695a8b62@pefoley.com>
 <cb03b745-26b8-706c-de40-80ae991e29fd@isovalent.com>
 <194f38f2dc7d521375e5a660baaf1be31536be9a.camel@gmail.com>
 <CAOFdcFOgAH1z7EKyM=Q4EvzLuKETOWWDMwuqp36SxV-X6PGP5Q@mail.gmail.com>
 <1135125e-6b8a-7b75-5f0b-3208f6b6e8ae@meta.com> <87bkmx9tw8.fsf@oracle.com>
 <87sfg96s30.fsf@oracle.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <87sfg96s30.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0057.namprd08.prod.outlook.com
 (2603:10b6:a03:117::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3831:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ada997-e991-4ac6-74ea-08daf8ae527c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MBMVBBXeCPF5a/TTbrBrk4ElWdoA4cejV0nosfDdrSb3MIvlnHYRfQyAMe7eAs9wJsiwlHgQmB3bPlJPn8v1ttPwnhFNXtCcFqBKS/88rU9RQSrjE15yNXxYdK4Qcb4F0isC7gGJ/4tJtYmyIQ1ZrLWSJJp7oKsRGzbOmPCtMqpq1idXAmxK3PBBeUNjzl/AOi4GYRnKpHp5AG3U2NXKvCUlzLGmFfm5ivRPVf5Z+w9z46KkEaVTD8xtwxQUob09hkFNiCTJinrp0xOZDMpMP43vqh0gebxnOfMO4G+NlZmOB+mO+v79UWYffVnspGU9sOK79L89w7/HAg6TI3zJejaxwGx2fCP8PVEU0nUYxFt0rTNjhGFy0C7wsO6vYtWooNu6YKQawrkVC/kCwyq7poo2dBw4S9WLw7t2Y7wfn+v5tC+Y4+BejkNOWgdxt0SRb9/GN0BLZM3LO+TVDGmtS3M3ACRZILztRyNlfUFSGJX7sY0sRpigKAtfIopLQ4nM8yuoqGlP+gOHKV35Z1/GAaor0NBePu7DX0Rx9U+aagYUrY3MyIeLejgHKGniddq9z5FAZlesjo02ImgR7p3g0xoDwkbuaTBzIkGzo/TodB7hL6CLxGRslXeoFbHXBEs57ndV0ll1+TfQJidTXkOd/gtFHKPLVByM5Pjs+8ZWZ/1btxrVYwaBzP87fQc3/CebuHeo3u1ijdXxWUHNh4w3+OoHxTZp507axAE+ztfkFGo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199015)(83380400001)(38100700002)(5660300002)(86362001)(6916009)(2906002)(7416002)(4326008)(8936002)(66556008)(66946007)(31696002)(8676002)(66476007)(478600001)(186003)(6506007)(53546011)(2616005)(6512007)(54906003)(6486002)(316002)(6666004)(41300700001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEk0ZVBzNUNFSGNoNjh0YlYzRjhldVJmL29seWtmRXlCV1NVbTNtajYxMXEr?=
 =?utf-8?B?NzFNc2xVbE5VQ2pjQ016aFVNQTkyWllFQlNZbEVHSURFUnMrWTlsNFRBK0Rn?=
 =?utf-8?B?a2czOFFHTW1FOGRWVFBNRVFJZm82ZDVmTGwvSzhGWTZ6aFdMWkJ4T0MrVzVU?=
 =?utf-8?B?QVY3aFVxNnJCY0RWbjl1d2Y5M3BiMDNJdHBoMnpjeHV5Mm51TWwzc1cxYTha?=
 =?utf-8?B?MXRnNUJNa3FLVFB2NGRnczZROGJ0YVgwdjhVaHFnRWNsU2paQWppZFZHQTJI?=
 =?utf-8?B?MWY5STdianVJRDhVRnZzRUMwUTBOT0lxWmxnQjlCVW96MmNVelpDU3lkR0xx?=
 =?utf-8?B?WWhBeUJtYnB5T1RKYXJJanh1ZUlGL3RBM3NaZHZvOTNtaHhPS3dDQzlUMHVr?=
 =?utf-8?B?QVdHRC9VN1V5eStZSG1FcjhzS2lyNTBhSnZwVTNObWZabTJycUR2bnhZSzkz?=
 =?utf-8?B?VzdhRFNoRklLaUlXZk1ZZzdWWGhaSHhvZUZHaG93Njk5c2tOQWtuWlNtR2U4?=
 =?utf-8?B?a2pWMnJwZnZYTk1kRjU0TlZKR2I3SFFySXJLcmR1NDhBa3RITHVIb0VkcUFI?=
 =?utf-8?B?UTJqYXdpUEl0U0RGV21NZFNBNFpzcjNmZW1HZkdROFV2czlQaFZmcEFhQUpl?=
 =?utf-8?B?bUZPOTcxWlRmc2hvWTNTTzBDbHhSLzFrTFdjUUFQdHVwdnk3Tk05YUNLUmhU?=
 =?utf-8?B?U2FEWXB0TGdNWXdmSzE3S0JHc0hka05TVnQxNjd2KzBCc2NkN2VvU1dIMXpP?=
 =?utf-8?B?cVMxb2IrL3FOM1FqdEh1UnZiRWFKeTU0WGcwSFJ5TkpuQWVMS0ZTMmd3WUZH?=
 =?utf-8?B?U0dMVUZKVzNJd2RxR25OaGV2ZlZUWjFhaTV5WnBPMndxUDE5Z0h0ZVBnU1BK?=
 =?utf-8?B?dkxvNG8raExZeFhOaTJPMlI5enJ6Sk93d1VDdHpTa1FvSjdRMC9sUkdhSDFy?=
 =?utf-8?B?elZ1UUYvNW9tOTZpQXdINEdjN2tHT2tyR1M3VEJESTdpUlFlTkUrc1U3WUtP?=
 =?utf-8?B?R2lwTFU4WmpuMXZhNnJmczQyem4zSDJpSnVWeEtxdWZteDN4c1NYMWVkT2JZ?=
 =?utf-8?B?UTZxbU9lSG9IVnpDUXhYbDFDMjRKT1F2bkNkMDdzY3lWNEhqNXd0OEhjVkJK?=
 =?utf-8?B?WlpxNnlGclNjWFRaUW9EcGk3eEpwZUdvWkVBWC9vWDZYZVFNQkJlY21FdWdm?=
 =?utf-8?B?NGpaN0p3eFZZNTB2TEVUZWM1SkRTMHp5YThHWnN1RXF0VzlYdU01Rzk1TTZI?=
 =?utf-8?B?UkEzMEFzblBqTjJIakh3NjRhQXJ0dnZxRjB1Q2d2MEtPVnZkRUpEdjMwRE9j?=
 =?utf-8?B?elZqbHM0RTZPQkdIYkFKRXZNYlRHbnJjZlo0bVZsaVA2Z2hpWkQ3Nkd0eStn?=
 =?utf-8?B?eDNsZGN2ZE1nenlEWXNrL2M2MUpaZU95QlZDS1hISFRmR0VyaERJR3VnR3JN?=
 =?utf-8?B?OUN3VjRzZFFqemhBU1NkN1ljWWhtbkNzb0w1LzMwc0xQaEFZTlpBUFdna0lE?=
 =?utf-8?B?YldWeHpXQzdsQTBwakM4RGtPVndldHZBV08rNldEaFRuYlVoRkYxZmxQWWhC?=
 =?utf-8?B?emorSUx4elBsT2dBZkVZaUR1eFAyN2NHU1dXallEWWVZZVFncWZHbjk2RFdn?=
 =?utf-8?B?aXh4RFp6YjF5S3lKMUVBUVVwV0VxU0ZSU28yOC95YlRxaHBGMkowN2xBZnNS?=
 =?utf-8?B?WXJJZ2lUOXVubjE3cWZHU041b3dEeUNmK1lWVkNPMC9hd0ZCQlpTMFdXTXZC?=
 =?utf-8?B?S2UrYi9EbnFydDJKVGVwZUZOaDlGNHd3dGpqVnU0MkwwaHQ1U3RyZll5TzhU?=
 =?utf-8?B?Qk5vdGVPZ3pYUVpKZ0RJTUxRcEdDSkl6TjJEK3NVY0JucngraUM1Z0pUakph?=
 =?utf-8?B?NERtaXd4ajkvTGkvY09KdUNMNFlvbUpOMXZhSmpQcUpwOExKWW1GdnFYTGpt?=
 =?utf-8?B?b2RuTndrQldCT04xYlFNTFQxUFRiTGNla1NOck9UTHU3V3FqVzRyL0taV2xW?=
 =?utf-8?B?Sm8xRkNZMDBVN29PVFpVQXR0S1VvdTFRcWRMVkJEOXR2cDZrTjg4cEZSV2Vt?=
 =?utf-8?B?bEJORnV0TlpiT3NrUk9MNGNGVVdBdXVUZU05cUZBMTdxblltRHVRUkZjWlN5?=
 =?utf-8?B?bWQ0c3BvUzVrb3JETHZtdTJmc29VTWtTRVp6NysxOFUxckJTM2tyd01iSk5j?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ada997-e991-4ac6-74ea-08daf8ae527c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 17:14:41.9638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxEPx0ZKmHpRrVgSCWlo56EDJd23J8pcW6QMYLZqqUkBcJgyBg+KbmZ/J6eQVsnS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3831
X-Proofpoint-ORIG-GUID: su1w1tKbMcKW5dmQ4DDpplXSYOBM94s3
X-Proofpoint-GUID: su1w1tKbMcKW5dmQ4DDpplXSYOBM94s3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_08,2023-01-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/17/23 8:31 AM, Jose E. Marchesi wrote:
> 
>>> On 1/16/23 2:49 PM, Peter Foley wrote:
>>>> On Mon, Jan 16, 2023 at 4:59 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>>>
>>>>> A bit tangential, but since BPF LLVM backend does not support the
>>>>> stack protector (should it?) there is also an option to adjust LLVM
>>>>> to avoid this instrumentation, WDYT?
>>>>>
>>>> That would probably be worth doing, yes.
>>>> But given that won't help already released versions of clang, it
>>>> should probably happen in addition to this patch.
>>>
>>> Peter,
>>>
>>> If I understand correctly (by inspecting clang code), the stack
>>> protector is off by default. Do you have link to Gentoo build
>>> page to show how they enable stack protector? cmake config or
>>> a private patch?
>>>
>>> Jose,
>>>
>>> How gcc-bpf handle stack protector? The compiler just disables
>>> stack protector for bpf target?
>>
>> It doesn't.  -fstack-protector is disabled by default in GCC.  When you
>> use it you get something like:
>>
>>    $ echo 'int foo() { char s[256]; return s[3]; }' | bpf-unknown-none-gcc \
>>      -fstack-protector -S -o foo.s -O2 -xc -
>>    $ cat foo.s
>>    	.file	"<stdin>"
>>    	.text
>>    	.align	3
>>    	.global	foo
>>    	.type	foo, @function
>>    foo:
>>    	lddw	%r1,__stack_chk_guard
>>    	ldxdw	%r0,[%r1+0]
>>    	stxdw	[%fp+-8],%r0
>>    	ldxb	%r0,[%fp+-261]
>>    	lsh	%r0,56
>>    	arsh	%r0,56
>>    	ldxdw	%r2,[%fp+-8]
>>    	ldxdw	%r3,[%r1+0]
>>   	jne	%r2,%r3,.L4
>>    	exit
>>    .L4:
>>    	call	__stack_chk_fail
>>    	.size	foo, .-foo
>>    	.ident	"GCC: (GNU) 12.0.0 20211206 (experimental)"
>>
>> i.e. it pushes a stack canary and checks it upon function exit, calling
>> __stack_chk_fail.
>>
>> If clang has -fstack-protector ON by default and you change the BPF
>> backend in order to ignore the flag, I think we should do the same in
>> GCC.
> 
> I went ahead and pushed the patch below to GCC master.  If
> -fstack-protector is ever considered useful in the architecture, we can
> always stop disabling it.
> 
> I would recommend to change the default for -fstack-protector in clang
> to be off by default when targetting BPF targets, and to emit the same
> or similar note to the user when the option is enabled explicitly with
> -fstack-protector:
> 
>    note: ‘-fstack-protector’ does not work  on this architecture
> 
> WDYT?
> 
>  From 3b81f5c4d8e0d79cbd6927d004185707c14e54b2 Mon Sep 17 00:00:00 2001
> Date: Tue, 17 Jan 2023 17:16:32 +0100
> Subject: [COMMITTED] bpf: disable -fstack-protector in BPF
> 
> The stack protector is not supported in BPF.  This patch disables
> -fstack-protector in bpf-* targets, along with the emission of a note
> indicating that the feature is not supported in this platform.
> 
> Regtested in bpf-unknown-none.
> 
> gcc/ChangeLog:
> 
> 	* config/bpf/bpf.cc (bpf_option_override): Disable
> 	-fstack-protector.
> ---
>   gcc/config/bpf/bpf.cc | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/gcc/config/bpf/bpf.cc b/gcc/config/bpf/bpf.cc
> index 576a1fe8eab..b268801d00c 100644
> --- a/gcc/config/bpf/bpf.cc
> +++ b/gcc/config/bpf/bpf.cc
> @@ -253,6 +253,14 @@ bpf_option_override (void)
>     if (bpf_has_jmp32 == -1)
>       bpf_has_jmp32 = (bpf_isa >= ISA_V3);
>   
> +  /* Disable -fstack-protector as it is not supported in BPF.  */
> +  if (flag_stack_protect)
> +    {
> +      inform (input_location,
> +              "%<-fstack-protector%> does not work "
> +              " on this architecture");
> +      flag_stack_protect = 0;
> +    }
>   }

Thanks, just replied based on a previous email
communication a while back. Yes, clang could
do similar things.

>   
>   #undef TARGET_OPTION_OVERRIDE
