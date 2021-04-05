Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C47353AFB
	for <lists+bpf@lfdr.de>; Mon,  5 Apr 2021 04:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhDECbJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Apr 2021 22:31:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6908 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231656AbhDECbJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 4 Apr 2021 22:31:09 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1352TE7J018787;
        Sun, 4 Apr 2021 19:31:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=eXOp4Dm+IYAZWegSvVn5QtrDWE4W2IhRAs/daij/gR4=;
 b=HMFZwhPcVUS9q9K/jLzzceeB6w7YZ5b4hvqfxcZB/7/jRW+9QDHQNTXKZNpy/h4QB6ZG
 sqm/or7iJAo5t5l4FRPyTcFLtYbfB1iqv7mO3fqtGvXXAd37zAvE1xI6U1v6pxEJBH78
 aNopRzXfLe203ZwQHcJwi+n0tSZm29tz5fo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37qk8v8w9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 04 Apr 2021 19:31:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 4 Apr 2021 19:30:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eB0MWteipnw9vc+ikp+eU7FF2bJO8W3e1V/uZo9xY7Dh07BvoCUlbJG02U7+Z71hyR5msHpZtJjwEwOZuEF4hzMC+68SGu50US7YO9x6FhAv1qYgW7zz7XTuMMXtLspGbOZxZg/jZm/RG/u74xBLtRn9yDlj9DdggfxmfrSShBckYRp0HrCrAKrmn7RahScQFJiaSkEj5cu9HNi6hQzFiRnRGWWbvv8hj5/fJx0hwOanKx8SL5DkA5tPREX9UdauaDvXcsbdKllGSDa1vklHkfcb5VJxTNohQiZ6Qi24rwIqeflYWO/BUw84eL0vO6eR7J+QV3wg22u7PFwsrVJRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXOp4Dm+IYAZWegSvVn5QtrDWE4W2IhRAs/daij/gR4=;
 b=IPjAClP9bQLfAVOHPDZAkAwRXnyjCexf0JS6bVmVVp0ubqcnPE3AqW8Z1kDxA6G8yVZXjpuhMror8/mvWx/KjoGFwiSRWrg2QYsGFm6Pqv+FeBOgOW5pTSrNOzI0R8GQk43FWmxFRj+kKAwgpawH9O6KLGQM4XW70hmuvfLQ4qaIMXl5eapx2lDXrO51ANwoIw9cf1vPSENzinR/FvxUSMj8aWu6RGi2hFHOHaxRzX3nmTmsDep2jJmZZfNqi2k7EdzTXFrgfr4/JKcDiXccIDVA4bj4/pWF3YvfI81Ol/gZaIhGqz3ID94gwWHnsaYgPk5ttWrzKGHdTZ8Xu4gw4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4708.namprd15.prod.outlook.com (2603:10b6:806:19f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Mon, 5 Apr
 2021 02:30:56 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 02:30:56 +0000
Subject: Re: [PATCH dwarves] dwarf_loader: handle DWARF5 DW_OP_addrx properly
To:     <sedat.dilek@gmail.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>, <kernel-team@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20210403184158.2834387-1-yhs@fb.com>
 <CA+icZUWLf4W_1u_p4-Rx1OD7h_ydP4Xzv12tMA2HZqj9CCOH0Q@mail.gmail.com>
 <6c67f02a-3bc2-625a-3b05-7eb3533044bb@fb.com>
 <CA+icZUV4fw5GNXFnyOjvajkVFdPhkOrhr3rn5OrAKGujpSrmgQ@mail.gmail.com>
 <CA+icZUWh6YOkCKG72SndqUbQNwG+iottO4=cPyRRVjaHD2=0qw@mail.gmail.com>
 <f706e8b9-77ca-6341-db13-e2a74549576b@fb.com>
 <CA+icZUVb_J95Gk2Kf0i8waL6TDfJ2n9JrGbNK_dsN1n8HdcoXQ@mail.gmail.com>
 <CA+icZUVp3UTPUS-ZjCOnHbNXxaA7DN=4x_08jc8BExFe4Nf2ZQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <dfc28e40-5ce9-c6df-2e12-7840195ab570@fb.com>
Date:   Sun, 4 Apr 2021 19:30:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <CA+icZUVp3UTPUS-ZjCOnHbNXxaA7DN=4x_08jc8BExFe4Nf2ZQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ed0c]
X-ClientProxiedBy: MWHPR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:300:4b::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1149] (2620:10d:c090:400::5:ed0c) by MWHPR02CA0009.namprd02.prod.outlook.com (2603:10b6:300:4b::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend Transport; Mon, 5 Apr 2021 02:30:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9948b68d-699a-4aad-a352-08d8f7dad72a
X-MS-TrafficTypeDiagnostic: SA1PR15MB4708:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB470857736A7356A44EFDFE09D3779@SA1PR15MB4708.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5rgiJLR7E5JLWgJatOTmKUfiytUesC3boWs05AWpOeUQOH7U9Fa7dLAh5fBnGwkYzuhWDlxzhUd8sfYFwKuE9BFaMVvbbQKdpwvl0p/w6kW+S8zZOy5zgvdx0LY9Ce+UJN/pEpjTI5iYXG1zuhBGPE2vA+XLoZaIbQDDsnC47OglH6t8Ts3sR7rBTuqdcCSql6cCzaJjK3daX4c0vmkXIH+nPVr6ZU5l4pmAo7NtSJO/wLLO7xocDjJyCXA7MAta4Fq1QxWQPf59xNz/Rj/oOn9+M7dQj5H4D7USSW3Z+H1M9E4NC7tq/4Jcv+SfUoDt+Q3VT91d0y/uqbNvuLDS9xhgO+LPKZg+hdlC3dhKFane9TPaEkAuel4abIoa1SELyyXmDbry3V+69/nqte9fzBMKQQpCqxjqt8DmrzqC9MBGMC/zyKbBPaz/YsURz0xCvW3o6YoOT152xsRO0AAHMk5YImDat5QKpXPCTIQYykzDkQi56wyyc2RwuUDQgHf8jh0Ng4oFD2LOkImjahyXMM/RCW3xMf5csZ8krLAHAshM00c7x0ymivz/ZXXI6TpGX9hHH5ax8i9hBbme6VSI6d38T5TDhz/oTRjJL0yAZC/XGsDfmAJhwPUkFdxQ3GtOOwWdmNYpbjZB9S2IT7aYqaFHbCQm1Ufx1+SE0kkQi1h9Wgksz9Xl50eKQURdHPoKYPWdQZ/nX5RwA0c7f0RZ3trbvcrG7S7mBdo10hOdnr4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(346002)(366004)(376002)(6486002)(86362001)(8676002)(16526019)(2616005)(186003)(31686004)(6916009)(83380400001)(478600001)(52116002)(38100700001)(36756003)(4326008)(2906002)(66556008)(5660300002)(66476007)(66946007)(316002)(31696002)(8936002)(54906003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?clhUcTV0cktYd1Z2Ny8rTGtaZmFRYjViNTA4THM2eVZRU25MTkJIdlVKbmto?=
 =?utf-8?B?VmR2TmwxaFpPWnNxTGNKNW83cmk0bmdIYTY2QWRlN0hxTjFLYXBjZ3AwWFJM?=
 =?utf-8?B?dVMyUEV5eXdST0k1bHR4L1RwdzF3cDZxNkc0Vk1ZbVpBRE5MT2Jmd0gyRzJl?=
 =?utf-8?B?N1ZiR2ZkcDlaNk5TcGtXN29rWHlXTnV3NzVud2RQc0tYTTNCMGg3amhaUjZ5?=
 =?utf-8?B?UUZibFF4WUlKR3dyWGIzekJuMVpEdFd3M2Z3RGsrRmtlQkxtYlgvdExBZ0RH?=
 =?utf-8?B?eExHeVR1bTZFbk1iVmdOcTNZand1YXc1STFvL1BQZ1hTcTRHUVVDR0p3em9u?=
 =?utf-8?B?VUZRbUlPSm56YzI4eFpQRTBjWHdOak8vMTJVSFFINnJjUzZjd1ltYUVyYXA4?=
 =?utf-8?B?ck5nTTR1SmhqUHJQZkpBaXUrNEx6cFVUU0F1bUwxSWJab2ZjYjVacTJoZTFn?=
 =?utf-8?B?NUhySlhEaTVsRVF3OFhQeGNHQk1DQVlWTmJQV0l4K1R5YUN0OU5tSHRyaTRZ?=
 =?utf-8?B?SktJUENLNkI5eVUxeWZkNXhZS3pjMWFaWXAxYSt1TzRXSmp3ZFZWaWFFT3lZ?=
 =?utf-8?B?MFhqVk1uejVSSVQybERNM3BNMmtHM3dNeWtUc2tYV2JaTEd4MnVsbFZteXJT?=
 =?utf-8?B?VGl5YkMra2NkZ0I1R3d5RjlJMStXb3hsY2d6ZnBqR2tMczhXQVc1VmxPelBt?=
 =?utf-8?B?VG13c1c5cHRJdDFxSkFScVhsbkFFR0o3anJML3ZKcTFPcktQeUl2b1RaTkpZ?=
 =?utf-8?B?MEpXSHIvWEZZZm9TRDV2cytGN004UFhjNEg4czF0UDlGZ3FjVmE3RVpGYUIv?=
 =?utf-8?B?TGN6UXJmRHFsajZockdlNVM0NFRzZVZSd0p0akNNa0lqR21qcm0xc3NVNXgr?=
 =?utf-8?B?MGpHUWhjSzYrTWxSVzdtRDhuSFdybU4xNm5FSmw1QkRKZzUya0VOQUlSSGVB?=
 =?utf-8?B?TmE5OW1Vcmp4N1hoOHFWMGdGdEZ6T1Q5bWd1QTRGN05qNFdjUU1RaStWamtv?=
 =?utf-8?B?a2l6Z0lVSFpRckgyWDR2aU9DR05IRVlGcGhkajRkMkRxNkpsWFAvZ3dhZjRy?=
 =?utf-8?B?djRMRHp0dWFySHFGTnIwRERQOXBicm1kb1lNOTUwVm1TdFJtOTZlUW9zcVZq?=
 =?utf-8?B?TU8vMC82UDRpc3JMZmVxdlRBYmJKcHVBc3FkZVJraXRTYy9uSHR0RnNITnNF?=
 =?utf-8?B?Yit2QndFNm5qRGcrQStLNUFEb1oxaGNVZWVSdUNsR0wvaTEwd3JsKzN4UXBt?=
 =?utf-8?B?d3h6ekJQWWg4MTFSK1dPSGtYSU9UeWxINFVvSk5Vb3pHbXhPMVVKV1NyQnhW?=
 =?utf-8?B?ZkIxNElQa3FSMFc4K2Nmb3o1eEVOQ2oxdWpLakxqR3RicXJ6RCs5V0JkMXVh?=
 =?utf-8?B?UEw0TlpFUzcxUnhRSkovN3pwK1RoSE40aFJsVXZDZVhHWWMreC9SUkk0MnNN?=
 =?utf-8?B?REs1VFVRRUZtOURndXlCcHBueUxrQkMyRGtGYWI3YkNIZTFIVmRVZ0NJeitJ?=
 =?utf-8?B?S2M2Y3Iwanpjb21aQ0VBWVY3amgzOFJSeFBhMEgxSmJsSUpybkNKMGdHTWJu?=
 =?utf-8?B?ak4ydGE1SFNiRStVVVhWQkZURlM4UitQU0JLVWxXMm90Ym1iaXl0dmh6UkpX?=
 =?utf-8?B?cjJmeWM5MlM1cWhWQVhMSldqallzY0ZHNmVQRkZTUm5KeXY5bmNiN2dIY1hW?=
 =?utf-8?B?V25iQVFkQ3dmcVhtNHdJRWR5MXpsRTY2QjFBUXJNTEZNcVNTUldSQlA1VkxO?=
 =?utf-8?B?NkJNWHF4ZDBUT3NQZ2VVdExGYzdBeFM1cE5MQTdjSnhlcUwzMnArOXVSdTIz?=
 =?utf-8?Q?LkF+kCSsueai3wasFW2wghyGHwW1z178PffOI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9948b68d-699a-4aad-a352-08d8f7dad72a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 02:30:56.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBETlj2RVlycgsQnB5Vpsbefa25mAreUXMhGCs89RSPOOYPH2O80vq0IGue6Fnl1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4708
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 6iD2CfnrwjKNXrXDR_ZMmh0I_DjivIww
X-Proofpoint-GUID: 6iD2CfnrwjKNXrXDR_ZMmh0I_DjivIww
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-05_02:2021-04-01,2021-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050016
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/4/21 5:20 PM, Sedat Dilek wrote:
> On Sun, Apr 4, 2021 at 7:25 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> [ ... ]
>>>> Yonghong Song as you described your build-environment and checking
>>>> requirements for clang-13 in bpf-next (see [1]), I am unsure if I want
>>>> to upgrade LLVM toolchain to v13-git and use bpf-next as the new
>>>> kernel base.
>>>> Lemme see if I get LLVM/Clang v13-git from Debian/experimental and/or
>>>> <apt.llvm.org>.
>>>
>>> If you want to run bpf-next, clang v13 definitely recommended.
>>> But I think if you use clang v13 to run linus linux, you may
>>> hit DWARF5 DW_OP_addrx as well. But unfortunately you will
>>> may hit a few selftest issues (e.g., BPF_TCP_CLOSE issue).
>>>
>>
>> OK, I started a fresh build with LLVM/Clang v13-git from <apt.llvm.org>...
>>
>> $ /usr/lib/llvm-13/bin/clang --version
>> Debian clang version
>> 13.0.0-++20210404092853+c4c511337247-1~exp1~20210404073605.3891
>> Target: x86_64-pc-linux-gnu
>> Thread model: posix
>> InstalledDir: /usr/lib/llvm-13/bin
>>
>> ...with latest bpf-next as new base.
>>
>> I applied your/this pahole patch "[PATCH dwarves] dwarf_loader: handle
>> DWARF5 DW_OP_addrx properly".
>>
>> Will report later...
>>
> 
> Yupp, works.
> 
> $ cat /proc/version
> Linux version 5.12.0-rc5-13-amd64-clang13-lto
> (sedat.dilek@gmail.com@iniza) (Debian clang version
> 13.0.0-++20210404092853+c4c511337247-1~exp1~20210404073605.3891, LLD
> 13.0.0) #13~bullseye+dileks1 SMP 2021-04-04
> 
> MAKE="make V=1"
> MAKE_OPTS="LLVM=1 LLVM_IAS=1"
> MAKE_OPTS="$MAKE_OPTS PAHOLE=/opt/pahole/bin/pahole"
> 
> $ LC_ALL=C $MAKE $MAKE_OPTS -C tools/testing/selftests/bpf/ 2>&1 | tee
> ../make-log_tools-testing-selftests-bpf_llvm-1-llvm_ias-1.txt
> 
> dileks@iniza:~/src/linux-kernel/git/tools/testing/selftests/bpf$ sudo
> ./test_progs -n 55/2
> #55/2 subprog:OK
> #55 kfunc_call:OK
> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> 
> My linux-config and
> make-log_tools-testing-selftests-bpf_llvm-1_llvm_ias-1.txt.gz files
> are attached.
> 
> Feel free to add my:
> 
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v13-git (x86-64)

Great! Thanks for the help to test the pahole/kernel patches.

> 
> - Sedat -
> 
> P.S.: List of some relevant Linux Kconfigs
> 
> $ grep 'LTO_|_BTF|DWARF' /boot/config-5.12.0-rc5-13-amd64-clang13-lto
> | grep ^CONFIG | sort
> CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
> CONFIG_DEBUG_INFO_BTF_MODULES=y
> CONFIG_DEBUG_INFO_BTF=y
> CONFIG_DEBUG_INFO_DWARF5=y
> CONFIG_HAS_LTO_CLANG=y
> CONFIG_LTO_CLANG_THIN=y
> CONFIG_LTO_CLANG=y
> CONFIG_PAHOLE_HAS_SPLIT_BTF=y
> 
> - EOT -
> 
