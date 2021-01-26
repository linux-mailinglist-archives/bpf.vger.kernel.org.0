Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40969304CBF
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 23:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbhAZWyc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 17:54:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39034 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395428AbhAZTWN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Jan 2021 14:22:13 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10QJ1UEP023691;
        Tue, 26 Jan 2021 11:21:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5npvfjCFco8yZamVQDxnWgx/kome0zpIoZpcl0ujoMs=;
 b=K4U4ZMSt7oAiarcjtkPv1IxE4tSLRdoYThArURfptvtX5Wom0qOAOkceuQWNc2TRJGLF
 MGRG8Yeks5IPVMQn1Rpw3zODWSbhlluLxB/a2Icue4EIp1Q2x2kKduwHDXdUuf9DI93H
 ZRL2DxGG9EHij1Ox6JaNEGXiXsCzdA2BqDY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3694qux8af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 Jan 2021 11:21:08 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 Jan 2021 11:21:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/hJ0JrR4swZXAE+svlaUJPY+M8PuJokddNs7Dg4XQTzWiwRD8OpoRVi3JDJLif0gHWr17Ojm+Y9TP3MlcFLHSLMLuxhxMyakzlsFW+iVe0AIWwXzsAdFcy/hKe3/x57Ae63oReQKieQLQ7a9MBlUwQR8o9ilRQBd/h1hFGvdXYUVbassok4kzDhUqwrlzX63mT19W7pMCiCzq1oemHs78mc5Hi+oKQjq2dlkzQDKMY1C7F5F/+NQO9lJhtMQMMroidOtDBd5MifGF8ZUVVibEc6kfiy4adcRHjO6/o1EBdzjre/LCsft4SvtXJw6hTArkcy4LObgNaYtTuswWRDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5npvfjCFco8yZamVQDxnWgx/kome0zpIoZpcl0ujoMs=;
 b=izvazAYCnx1Um45I9TFLg0jqopXzDczd3P3xwQUni+T4Vfu0CUHdSLbgFpETlbTnJ+67wGW1MnSJjuexMn2SLvNowUJihKUuOOGE7WpWg54u/XG6TXF9IRw8O/UWr/yUq11gnB8cwIfR/S1pGAB8OuvldXqaYN/sIRXiSl4O1ee8bzEfY0WMAYKToK8e5P+XhfAcYT9gUwlMchouA1j40Ej8K3vA9mP4t24UD5Krr6/Fspk2t94NmNNnD/GImeyeXVKoADQpu8wCajAEJtUquKqQUMY/k0EG5tJEj5chUKtMD9DB/2Br1m7G4Lp87ZcE0T/SIsx6NEvhrXoCbC8onQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5npvfjCFco8yZamVQDxnWgx/kome0zpIoZpcl0ujoMs=;
 b=MlhouMLyMzioDYapXk8u254LtOqJavdxPqhfjcorK89w5zCGwR0+pz1P+wqNXc3FvHLYtL1EczXDow4qsU63XhDyQ3K++DBhmuCxWfCzG7Dseysi2JaJDI5gLxsqq1/PRRttbygKHKQa56ftowkMyDX4ee2vZbZvejRNShQO0fg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2728.namprd15.prod.outlook.com (2603:10b6:a03:14c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Tue, 26 Jan
 2021 19:21:04 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 19:21:04 +0000
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions
 properly
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <x86@kernel.org>, KP Singh <kpsingh@kernel.org>
References: <20210126001219.845816-1-yhs@fb.com>
 <YA/dqup/752hHBI4@hirez.programming.kicks-ass.net>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <66f46df5-8d47-8e4f-a6ab-ab794e57332d@fb.com>
Date:   Tue, 26 Jan 2021 11:21:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <YA/dqup/752hHBI4@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:c70]
X-ClientProxiedBy: MWHPR12CA0068.namprd12.prod.outlook.com
 (2603:10b6:300:103::30) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1246] (2620:10d:c090:400::5:c70) by MWHPR12CA0068.namprd12.prod.outlook.com (2603:10b6:300:103::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 26 Jan 2021 19:21:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b900e2c0-2c04-4dad-3aa7-08d8c22f8637
X-MS-TrafficTypeDiagnostic: BYAPR15MB2728:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2728E04AC1CBFF779F6AF7AFD3BC9@BYAPR15MB2728.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppAMtONpLi+uZNUNoO8vNjmL1vOS/HScY5bn+eyl1gpjvRkyGAB8V9Q/fvY7pRdoDm2ZV9zWOIZhe3M+oEDKoDPuy6ckf0WVOon6juBPT1nyStZTXb+MU1n2Bd/8g40SGgmj8Qge8azBG38mYvU4KBew78gqQmkq0gS8mOhpkXTnlovIDunTBzLha9O0nA/RJJffC1qOF2vYXRG3izISd3GiknHAn5Losqe2UP423Cxvd5rUI9Aa0zzO3E2NuYyggNXKXA0+ehFp0FwKN0TcarzlgPiJl58rlGz05of1AkNQUQ2zejrYj49qtrgQOvvQbeGryODMOopd51VT9EiSVO69bRmsZh1xtutQyqPBrCw1RhMusft+rV8TdfQfDeNey79WLgNldYvK1KU62ee3JLLRnWc7pXPXLOyKre3LSiqlgul/yuYiy4ZPbfw7oxmjKkTk2ra2M//eF5SfhNMfy0prsTj80kd3ZF+ORv9jdh8rx4IOuNSj8aoU4B9glii4JVS7gbF4jwVf8Owd88xDM5J+pcAUWXCKSzv8uoaBCd5HTpAHgLdv9zkQ4NOqi9R+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(39860400002)(136003)(376002)(52116002)(53546011)(966005)(54906003)(31686004)(66556008)(316002)(66476007)(2616005)(16526019)(478600001)(186003)(2906002)(8676002)(66946007)(83380400001)(4326008)(8936002)(36756003)(86362001)(6916009)(31696002)(6486002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QVFPaWpZak40YjQzVUJxK05hMGJ0YlVBSE1qMkNoK3YvY0lSNHR4NDVIc3Ri?=
 =?utf-8?B?L0VITnVmdDZUeUE3aWJvY1AxditDaXNiRTd6UmR6UUZ4c2dGa3Fyek5PbUxm?=
 =?utf-8?B?cytMM1lXNXhzQVdic2ZkUXVwSmR4bzNJYlUybW1qdlUvcGduU2RHUGJLRTVZ?=
 =?utf-8?B?L1BxVmRxREVLeDhaRWRGMUMyMTkycG5ENkFHOW1YYjNNUU5sWGgrZ24xUlFR?=
 =?utf-8?B?V3RCQ1JTSUV4ZE8yRkwvYk9iVW1KYWp6VEtkVUZTZHozMkJoVUJ1YklsT3ZX?=
 =?utf-8?B?NkkrSThUK05kSUlOaitManZRYXpSVk92dEtsM2JLY0xIT1Z5ZDZTMnpKL09O?=
 =?utf-8?B?TWFmL2k3OWx5SzVHOUp3STBtOTNlTHFzRTBFYjVyTURyZDFmaFpubnlKdVJ5?=
 =?utf-8?B?ODhzWERmMWI3VFlZQmZ0VHVnWXZzd08zTFdSdjdHUEpVYkFGcExlazJjOVJ4?=
 =?utf-8?B?STRqQjFWTzJlZ2F0NXpOWlBZVHYzZVVvK1JndTB3aithcXFOcS9hMm9vb2hq?=
 =?utf-8?B?ODZYSWQrTE9lZmdGekRmUUVGY2xVa0ZCUDNrZ2dROERzUm1zQk4xa2V0dUd6?=
 =?utf-8?B?YlpGVWVGcHExOWY0ZUo1SEVoaVNDVmRtM2Z1NjdYSU1vSmphUVdScmFXb0Uw?=
 =?utf-8?B?QjlPTFFTbGVJQndDbkJPYkRvaS9RL1I4d0xGc0h2L2gzazc1RG1EY3N2NVBJ?=
 =?utf-8?B?MEpwcHVMSXVxd2dFUHczbmFrS2NmdkhVbkI4VjJZQnF4cUZnUDFlTGhLejBT?=
 =?utf-8?B?bVRONysxZVZLc0xZZm13eEpqa3hkM3BNQXpsWk1nT1NyYnNUcmp0VUpONGVX?=
 =?utf-8?B?UHIrSlZubDl2TThxbUpSSlg5N1BENjI0aS9mNlNISE9DOTBPTWtMSW05WDVS?=
 =?utf-8?B?K1BURkJ0cW1SOG0yWDIrQzNsRHp2aGszclN0OVlTeEQ4TGJqR05Qei9VM2JX?=
 =?utf-8?B?WWozNWF1R25DbnNZZHBiWWJ5cCthcXRMa0VDcnRvUnFMdVl4L2NXK1NmWVZK?=
 =?utf-8?B?ZXZPNnlEdEhrSEo4aW9VQWNENlFDY3ZmTG9naWZlaVJnSC9HRTBUVHJ3MWp0?=
 =?utf-8?B?Yi9MNCsrWjVSNjV3TGswOFFoOG15YW1ybGdmV1FYek9idVVqSHExd0VQMmw2?=
 =?utf-8?B?VzJESEJuQ1lMSml2OUdFRVlZZkE2VVJCaUdXcVFuT1c5QkVoa1ZSSTNqRm9p?=
 =?utf-8?B?NDRnZ1c5TjhnQXBocDJERzVFdXZ5cDdjNm83akg2MXRGTWR3eGpmd3o3bnMw?=
 =?utf-8?B?OHhtdy95RHpuaytuUmpBMkxNVEF1elhNOEJRbWVzWWE3VFhrRFlSbnVnR0Mr?=
 =?utf-8?B?dGRxN1FXRmNsaVVRTlRFaVBCaWpIMHVZQnMxSm9jOXNzckdmOWhuNE40QjJG?=
 =?utf-8?B?bk8yT3k1ZXR4VGRpR0ZiaUpZbFVkbjRJU3RlVkpldXRVaHUzQnZSbjhrc1F2?=
 =?utf-8?B?VkVNdStBdzh3cUF3K29rVWpJTmhtclFyZ2dvV2tBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b900e2c0-2c04-4dad-3aa7-08d8c22f8637
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 19:21:04.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygTcUAHpRjVMIR4ZYFfhy6MJK7ZtBjAIOeSEp5u+LMWPqaCWfwEbdSzDClA/APR7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2728
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_10:2021-01-26,2021-01-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101260098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/26/21 1:15 AM, Peter Zijlstra wrote:
> On Mon, Jan 25, 2021 at 04:12:19PM -0800, Yonghong Song wrote:
>> When the test is run normally after login prompt, cpu_feature_enabled(X86_FEATURE_SMAP)
>> is true and bad_area_nosemaphore() is called and then fixup_exception() is called,
>> where bpf specific handler is able to fixup the exception.
>>
>> But when the test is run at /sbin/init time, cpu_feature_enabled(X86_FEATURE_SMAP) is
>> false, the control reaches
> 
> That makes no sense, cpu features should be set in stone long before we
> reach userspace.

You are correct. Sorry for misleading description. The reason is I use 
two qemu script, one from my local environment and the other from ci 
test since they works respectively. I thought they should have roughly
the same kernel setup, but apparently they are not.

For my local qemu script, I have "-cpu host" option and with this,
X86_FEATURE_SMAP is set up probably in function get_cpu_cap(), file
arch/x86/kernel/cpu/common.c.

For CI qemu script (in 
https://lore.kernel.org/bpf/20210123004445.299149-1-kpsingh@kernel.org/),
the "-cpu kvm64" is the qemu argument. This cpu does not
enable X86_FEATURE_SMAP, so we will see the kernel warning.

Changing CI script to use "-cpu host" resolved the issue. I think "-cpu 
kvm64" may emulate old x86 cpus and ignore X86_FEATURE_SMAP.

Do we have any x64 cpus which does not support X86_FEATURE_SMAP?

For CI, with "-cpu kvm64" is good as it can specify the number
of cores with e.g. "-smp 4" regardless of underlying host # of cores.
I think we could change CI to use "-cpu host" by ensuring the CI host
having at least 4 cores.

Thanks.


> 
>> To fix the issue, before the above mmap_read_trylock(), we will check
>> whether fault ip can be served by bpf exception handler or not, if
>> yes, the exception will be fixed up and return.
> 
> 
> 
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index f1f1b5a0956a..e8182d30bf67 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -1317,6 +1317,15 @@ void do_user_addr_fault(struct pt_regs *regs,
>>   		if (emulate_vsyscall(hw_error_code, regs, address))
>>   			return;
>>   	}
>> +
>> +#ifdef CONFIG_BPF_JIT
>> +	/*
>> +	 * Faults incurred by bpf program might need emulation, i.e.,
>> +	 * clearing the dest register.
>> +	 */
>> +	if (fixup_bpf_exception(regs, X86_TRAP_PF, hw_error_code, address))
>> +		return;
>> +#endif
>>   #endif
> 
> NAK, this is broken. You're now disallowing faults that should've gone
> through.
> 
