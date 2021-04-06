Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3010355A37
	for <lists+bpf@lfdr.de>; Tue,  6 Apr 2021 19:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346891AbhDFRX6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Apr 2021 13:23:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43790 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233509AbhDFRX5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 6 Apr 2021 13:23:57 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 136HJQdq020125;
        Tue, 6 Apr 2021 10:23:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=DEdvtJJAcFMF2j+Exrajp+Qo6amx56n/VXwpu4R/9VA=;
 b=dKKb+6uY6/8KlaYz9G2QC+L2jhOxIR1vdl/Jvi0ZLyjIidaZQ1K7Sd2OpHpH5FLTcIhC
 7cGol/zFLIIMhWiWe9VJCSLL5XT7+e1QT/OSpHJx7UWb1eKVGnEUUp7D9qlivmd+jwzL
 9WtZd4xzw1KYhRBe/t1OVUCRNyzNKoSef94= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37rr941tdt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 06 Apr 2021 10:23:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 6 Apr 2021 10:23:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WB+kJCEAHnt4DGDtxG8HVfW0j9VvefiL4crngUOJ++1sXVTqk/ao+IAuoNCoVje6fa6IXAS/3TLdBbRGeZjpQlWNIAP6Olb0tXnTMb0w3JIge8WlpbWUVLbqQUMz+TddxwjlCm3oXE5oMZDIEYh+XWvJpwvEDK2O9b/Tm37A1ktTknsI+EItzvif1yJprnStUaNI02dToAPLtAOpfcafCi+Wn67VOtvEhITiEYJSYpoU+z6sCc1YU2jJKFZzQ58Ds5NbbstRabBPBoYyn00fuFuisEOGHX5VAmMo6fZFdw6YDb4DmVCOR6hO2XV8mE6iZ6UOQg1u0CsSzQMLbHcFLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEdvtJJAcFMF2j+Exrajp+Qo6amx56n/VXwpu4R/9VA=;
 b=Xgu211kf7FNVO5Iw5tJtsEwRc5hF2ptjTOZRC+c05eU1JqysDKxIjfATB66WGd86wZCHh+jXNjlSyPOG2bgRJHKvGgDn3d2n/zRD3nifKhNldzydBhxXtu33enIWILj8fWIyL//0WCFEvBXVL4Gq2L33NEBJ8sOLehFNOBIOceLe7AcloreqDORUoz2jvgY4goQqOnBOdxyqPxC5CbMmbtQin3yuRcn/VFG+MfMUzBo4f9ldeq81J+0ABnLGG9BttSMwUrDUzSY7aCFm1g2xp5FQcJBXTZWmHeeT3AFofmzF+fXcnMsDWftVPFIVBj2KwVl2LnMZa1SENGgpvWYQJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB1965.namprd15.prod.outlook.com (2603:10b6:805:3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 17:23:41 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 17:23:41 +0000
Subject: Re: [PATCH dwarves 0/2] dwarf_loader: improve cus__merging_cu()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Bill Wendling <morbo@google.com>, Jiri Olsa <jolsa@kernel.org>
CC:     <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>
References: <20210401025815.2254256-1-yhs@fb.com>
 <CAGG=3QWpcCG7b70oQsRTATgt10acEFS=-Tg9U=DHZ6xoS3GeMA@mail.gmail.com>
 <CAGG=3QUUYn9K7zVQ1UVZ57_FFeiiOexwq_OgDw9VFPJD3fFbVw@mail.gmail.com>
 <06ba2ed4-2730-9ce8-0665-3c720bc786a3@fb.com>
 <CAGG=3QXkvwrm_tnsYtJ-gvHw8Emv5xFWeckoPoD4PhEud7v8EA@mail.gmail.com>
 <YGxgnQyBPf5fxQxM@kernel.org> <YGyO9KzDoxu5zk33@kernel.org>
 <YGySmmmn4J43I0EG@kernel.org> <YGyTco9NvT8Bin8i@kernel.org>
 <YGyUbX/HRBdGjH3i@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3a6aa243-add9-88a5-b405-85fd8bfbe21d@fb.com>
Date:   Tue, 6 Apr 2021 10:23:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <YGyUbX/HRBdGjH3i@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:5b04]
X-ClientProxiedBy: MW4PR04CA0110.namprd04.prod.outlook.com
 (2603:10b6:303:83::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::142a] (2620:10d:c090:400::5:5b04) by MW4PR04CA0110.namprd04.prod.outlook.com (2603:10b6:303:83::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 17:23:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f277ee0c-7820-4638-2f42-08d8f920b8c9
X-MS-TrafficTypeDiagnostic: SN6PR1501MB1965:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB19652673F44A1D083DB4B042D3769@SN6PR1501MB1965.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njnmecK3jj4rmW0APH+b0Gw2/qstKxaQoF9yMLwtzRB01pjXkPDPsEplBExVOgtV4v57fgCkSZe5/JRVkjlbkYnYzWiwrhgiZEBkbrjXu3NRlh9UJkFh1o1T4XJpdV7tvlHyfmGQVVW6mqpk6Qhxp6V9SYPNb5lC5legIU+h2VLm6j9Iv0pImJAk7Hlfd196foNOiIP53qmjCSVQfoyA/Lc40zhgDzuwbpNRsPpQecA6GZPEvCSopN6xODm2lC05mVHqsqGHif7hvJ8tSlMRNBa84eh4cbjP+uJJa5qdDExavrIPSN0IGgtCxT0UTG2eur1kLrGbsB//1Hr04Iwhawp4KMErSFxVWQIzZbk8FHr35aOWQH1uoGEdAaoNV9aTeM+X14/T+qcB88uRMVywCT7lPNacSNSoSuR6N+q3MExhFCmjJJm13R0MS9fwv2cT9LuxjQagI5sxXWKYJaKiTdH1YKWKIIuDfwMowpdbE5bNVpP4M/2PLyl5p23EJEdl3FBDMJ5r3muyX188s5JrG9wWhB6RlBNCdV+e0Ru/YVHQ78hHvJJNS9541kRKn+gSuUBAuuAAEGt8LRJzlfHKKMV+1jde2Ht3jWdn0fEoGPuwyYMseLruZQHwkEdbY8BnxCqpjlSvT9gp4N4hIWNQ40U5Greq0jXXiQYUXTC9GgxXtcCujBez8c9uKQr5LOgVxHS1RSv26Fh5PRH7Djz+4gDE53b+5RBSxLDnE00Imdu0JtwT8Bsz9KfKQISFFQr8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(39860400002)(136003)(396003)(5660300002)(52116002)(7416002)(31686004)(2906002)(316002)(86362001)(16526019)(186003)(6486002)(478600001)(8676002)(83380400001)(4326008)(38100700001)(110136005)(2616005)(8936002)(66556008)(66476007)(66946007)(36756003)(53546011)(54906003)(31696002)(101420200003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NytUbTgrZjBLeEY3MlMva0hQZ0hyUDlDTkVOdUZVa0pUck9oVUNFZEpMUzFu?=
 =?utf-8?B?UXEvQ3piZlgvSVo0N0ZmSlViVjR2ano4Ly9MNUlaaGJhQk51OTh1UFJySEd1?=
 =?utf-8?B?dXRISldSYmZhM2tDa0FOQlVCTmVCMTBVcmlsTm5OUXlaekhHZ1d4SmJuUXFN?=
 =?utf-8?B?UUtSaW9zR2dRbitLcmh0clNXd0xPVnBjbWt6ZmVnN2d4ZXhQdytUY3ptbXBL?=
 =?utf-8?B?aFovM05HSzczZjVIZmJyeFNtamdPZk56YVRKelg3VU50Y3pobmhYUU14ejJ6?=
 =?utf-8?B?MzROQkhvWW5SRldCZi9FaHo0RzdWZ1VNM2JxOUZvaWY2aXlNd3U2OWM5UXRk?=
 =?utf-8?B?cHZxOElheFlUZWQ3SWtla0RIakJUd2xYZ2xXV1g5N0EzZzVWQytTeXI5L2p1?=
 =?utf-8?B?MGNHbTRMQVhsZzBSOEJRdS83dnE1VlNRSm95NUdqbmVub1VyVXhVNDdPa3V5?=
 =?utf-8?B?WDVzR3ArL3N1bnVMeThoa1FsSy9QQW9VVVExNlB2UmlYVjd2VEluMkVXcXJY?=
 =?utf-8?B?M2tRYVAwWTY1NVJ3WmZMZ1BvNTJDajdqMUUzclFYQ3FBMmpadDRQV0hpWnFY?=
 =?utf-8?B?emJBY2pYcjBGcWkydnBaRkI4L0dqQ3FoWFFFVE84aTVmRGQ4KzY4R2R0R29o?=
 =?utf-8?B?R0RHRTVjVnlVN01DYlYwREpEY1R5WFlNaFRPK0hlNElSQ2doVVlndHZlOG5a?=
 =?utf-8?B?YnV6NmlwM1ZZZ2x1NXFpY2V3ci9weVV0MDJNSTJGZlJmbmtBQXBOd3o1MUFl?=
 =?utf-8?B?MTZZaTZLSE15YUNaRmswQmk0dWxZOEpxZU5WNXZrOUJpT0tjTjY0VjA0WVhU?=
 =?utf-8?B?WTZQMk56bXlDdjhRRktEZDVQMG1waFhlV0ZJd0RBMEhXMnFKZjdiTk9wK1lt?=
 =?utf-8?B?UTQ0UlVOS1dmdkFJSTA1aHZtUDV3NkNqT0c3Wm9pZzdOR1RHR01HTktEblJj?=
 =?utf-8?B?cm40S0graEJFOCtERjFwZlRqcUFjT3B4WjFNZlg5Y1RMemJvWThvZE0ySDFv?=
 =?utf-8?B?b3VhSUxkTDdKMmlNUUEwY0plZHpXL1Mvb1REbURBUzU2ZnpNVlRpN2VKczZ2?=
 =?utf-8?B?K3Rzd2JXaE84bFQvSnFJbkJSWVJQK3JjK1B1YVUyelJQOGlGUE9EenlEemtn?=
 =?utf-8?B?UzY4V0V4Q2FxeW9hOHIwNkM5SGwxSk56QUxybXFGYjF3M0N2SnJ3S05HWHBB?=
 =?utf-8?B?RkpqUktVNVFBSk1YV28yUUNyWkh2aVhnZXZnSCtvUWdUQm50QXErY08vNjlQ?=
 =?utf-8?B?NkNNeFpCWlBQa2FIMTBmbUgyaUtUU0ZsQWFORnBWc2NkZWNwbjk4dTZiZ2Nm?=
 =?utf-8?B?dW0yVUNsaXFaaXVrL3ZHQ1h6V2lGcThwOW9yMzFmU3RDNzdHeXFHWWFjZkln?=
 =?utf-8?B?U2xvY3YxNGlJdmpPNEMvUDJZbGpPZk1FN1RuN3JHd1FGQkplZnpacGxEY1lD?=
 =?utf-8?B?Q3pRbEZCSU1xc0VmSGVlL3Mxam54a1BZUEZtaGlmVzBSVS8yOU52NStsOVM2?=
 =?utf-8?B?R1VBWklGWGF0NVJTMUZ4RWFpOUFHRnNOeUZUV2NoS0M3Vmp2THB3Q1BiaGxD?=
 =?utf-8?B?NDFxVUFnZHhJQ2NKbm9DV0ZSWEVTTDQyTjNMTEhxcGE2NUIvZGNJUDN1NnEx?=
 =?utf-8?B?cittSi9pM25NUWtLTGc1a0d4R0ZkajdZZ3poNzU3Y0lOZ3RLUUp1eUhVZ0hO?=
 =?utf-8?B?N2FHeGJpNmVpbG9JYmY2UlQ5MjQ1ZTkvaHZvODhXNkdSdWxVRVRMN0tFZnVn?=
 =?utf-8?B?SVl4aDNxOWJkeHg4MnF2L2IxVmYwMXFXa2ovVWVJcDZsOTZ3ajRaL1FYbHVw?=
 =?utf-8?Q?2WfvoEwvB/jxsp3f9LREmsMbSqOoPEKcr4lDk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f277ee0c-7820-4638-2f42-08d8f920b8c9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 17:23:40.8746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXj3D/dyBON04S6M/gPTbbM57jqamb7lRoLKvyfkJ11K1sTplhLQpLVld8XHEjHg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1965
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: sZgPAnYD160ivzPoLEEGQQjXuLrOhpCk
X-Proofpoint-GUID: sZgPAnYD160ivzPoLEEGQQjXuLrOhpCk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_06:2021-04-06,2021-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/6/21 10:03 AM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Apr 06, 2021 at 01:59:30PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Tue, Apr 06, 2021 at 01:55:54PM -0300, Arnaldo Carvalho de Melo escreveu:
>>> Em Tue, Apr 06, 2021 at 01:40:20PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>> Em Tue, Apr 06, 2021 at 10:22:37AM -0300, Arnaldo Carvalho de Melo escreveu:
>>>>> I'm seeing these here:
>>>
>>>>> [acme@five bpf]$ rm -f ../build/bpf_clang_thin_lto/*vmlinu*
>>>>> [acme@five bpf]$ time make -j28 LLVM=1 LLVM_IAS=1 O=../build/bpf_clang_thin_lto/ vmlinux
>>>>> make[1]: Entering directory '/home/acme/git/build/bpf_clang_thin_lto'
>>>>>    GEN     Makefile
>>>>>    DESCEND  objtool
>>>>>    DESCEND  bpf/resolve_btfids
>>>>>    CALL    /home/acme/git/bpf/scripts/atomic/check-atomics.sh
>>>>>    CALL    /home/acme/git/bpf/scripts/checksyscalls.sh
>>>>>    CHK     include/generated/compile.h
>>>>>    GEN     .version
>>>>>    CHK     include/generated/compile.h
>>>>>    UPD     include/generated/compile.h
>>>>>    CC      init/version.o
>>>>>    AR      init/built-in.a
>>>>>    GEN     .tmp_initcalls.lds
>>>>>    LTO     vmlinux.o
>>>>>    OBJTOOL vmlinux.o
>>>>> vmlinux.o: warning: objtool: aesni_gcm_init_avx_gen2()+0x12: unsupported stack pointer realignment
>>>>> vmlinux.o: warning: objtool: aesni_gcm_enc_update_avx_gen2()+0x12: unsupported stack pointer realignment
>>>>> vmlinux.o: warning: objtool: aesni_gcm_dec_update_avx_gen2()+0x12: unsupported stack pointer realignment
>>>>> vmlinux.o: warning: objtool: aesni_gcm_finalize_avx_gen2()+0x12: unsupported stack pointer realignment
>>>>> vmlinux.o: warning: objtool: aesni_gcm_init_avx_gen4()+0x12: unsupported stack pointer realignment
>>>>> vmlinux.o: warning: objtool: aesni_gcm_enc_update_avx_gen4()+0x12: unsupported stack pointer realignment
>>>>> vmlinux.o: warning: objtool: aesni_gcm_dec_update_avx_gen4()+0x12: unsupported stack pointer realignment
>>>>> vmlinux.o: warning: objtool: aesni_gcm_finalize_avx_gen4()+0x12: unsupported stack pointer realignment
>>>>>    MODPOST vmlinux.symvers
>>>>>    MODINFO modules.builtin.modinfo
>>>>>    GEN     modules.builtin
>>>>>    LD      .tmp_vmlinux.btf
>>>>>    BTF     .btf.vmlinux.bin.o
>>>>>    LD      .tmp_vmlinux.kallsyms1
>>>>>    KSYMS   .tmp_vmlinux.kallsyms1.S
>>>>>    AS      .tmp_vmlinux.kallsyms1.S
>>>>>    LD      .tmp_vmlinux.kallsyms2
>>>>>    KSYMS   .tmp_vmlinux.kallsyms2.S
>>>>>    AS      .tmp_vmlinux.kallsyms2.S
>>>>>    LD      vmlinux
>>>>>    BTFIDS  vmlinux
>>>>> WARN: multiple IDs found for 'inode': 232, 28822 - using 232
>>>>> WARN: multiple IDs found for 'file': 374, 28855 - using 374
>>>>> WARN: multiple IDs found for 'path': 379, 28856 - using 379
>>>>> WARN: multiple IDs found for 'vm_area_struct': 177, 28929 - using 177
>>>>> WARN: multiple IDs found for 'task_struct': 97, 28966 - using 97
>>>>> WARN: multiple IDs found for 'seq_file': 510, 29059 - using 510
>>>>> WARN: multiple IDs found for 'inode': 232, 29345 - using 232
>>>>> WARN: multiple IDs found for 'file': 374, 29429 - using 374
>>>>> WARN: multiple IDs found for 'path': 379, 29430 - using 379
>>>>> WARN: multiple IDs found for 'vm_area_struct': 177, 29471 - using 177
>>>>> WARN: multiple IDs found for 'task_struct': 97, 29481 - using 97
>>>>> WARN: multiple IDs found for 'seq_file': 510, 29512 - using 510
>>>>>    SORTTAB vmlinux
>>>>>    SYSMAP  System.map
>>>>> make[1]: Leaving directory '/home/acme/git/build/bpf_clang_thin_lto'
>>>>>
>>>>> [acme@five pahole]$ clang -v
>>>>> clang version 11.0.0 (Fedora 11.0.0-2.fc33)

This could be due to the compiler. The clang 11 is used here. Sedat is
using clang 12 and didn't see warnings and I am using clang dev branch 
(clang 13) and didn't see warnings either. clang 11 could generate
some debuginfo where pahole didn't handle it properly.

I tried to build locally with clang 11 but it crashed as I enabled
assert during compiler build. Will try a little bit more.

>>>>> Target: x86_64-unknown-linux-gnu
>>>>> Thread model: posix
>>>>> InstalledDir: /usr/bin
>>>>> Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/10
>>>>> Found candidate GCC installation: /usr/lib/gcc/x86_64-redhat-linux/10
>>>>> Selected GCC installation: /usr/lib/gcc/x86_64-redhat-linux/10
>>>>> Candidate multilib: .;@m64
>>>>> Candidate multilib: 32;@m32
>>>>> Selected multilib: .;@m64
>>>>> [acme@five pahole]$
>>>>>
>>>>> [acme@five bpf]$ git log --oneline -10
>>>>> 49b9da70941c3c8a (HEAD -> bpf_perf_enable) kbuild: add an elfnote with type BUILD_COMPILER_LTO_INFO
>>>>> 5c4f082a143c786e kbuild: move LINUX_ELFNOTE_BUILD_SALT to elfnote.h
>>>>> 42c8b565decb3662 bpf: Introduce helpers to enable/disable perf event fds in a map
>>>>> f73ea1eb4cce6637 (bpf-next/master, bpf-next/for-next) bpf: selftests: Specify CONFIG_DYNAMIC_FTRACE in the testing config
>>>>> f07669df4c8df0b7 libbpf: Remove redundant semi-colon
>>>>> 6ac4c6f887f5a8ef bpf: Remove repeated struct btf_type declaration
>>>>> 2daae89666ad2532 bpf, cgroup: Delete repeated struct bpf_prog declaration
>>>>> 2ec9898e9c70b93a bpf: Remove unused parameter from ___bpf_prog_run
>>>>> 007bdc12d4b46656 bpf, selftests: test_maps generating unrecognized data section
>>>>> 82506665179209e4 tcp: reorder tcp_congestion_ops for better cache locality
>>>>> [acme@five bpf]$
>>>>>
>>>>> I'll try after a 'make mrproper'
>>>>
>>>> Same thing, trying now with gcc.
>>>
>>> With gcc no such messages:
>>>
>>>    CC [M]  drivers/gpu/drm/nouveau/nv84_fence.o
>>>    CC [M]  drivers/gpu/drm/nouveau/nvc0_fence.o
>>>    LD [M]  drivers/gpu/drm/nouveau/nouveau.o
>>>    AR      drivers/gpu/built-in.a
>>>    AR      drivers/built-in.a
>>>    GEN     .version
>>>    CHK     include/generated/compile.h
>>>    LD      vmlinux.o
>>>    MODPOST vmlinux.symvers
>>>    MODINFO modules.builtin.modinfo
>>>    GEN     modules.builtin
>>>    LD      .tmp_vmlinux.btf
>>>    BTF     .btf.vmlinux.bin.o
>>>    LD      .tmp_vmlinux.kallsyms1
>>>    KSYMS   .tmp_vmlinux.kallsyms1.S
>>>    AS      .tmp_vmlinux.kallsyms1.S
>>>    LD      .tmp_vmlinux.kallsyms2
>>>    KSYMS   .tmp_vmlinux.kallsyms2.S
>>>    AS      .tmp_vmlinux.kallsyms2.S
>>>    LD      vmlinux
>>>    BTFIDS  vmlinux
>>>    SORTTAB vmlinux
>>>    SYSMAP  System.map
>>>    HOSTCC  arch/x86/tools/insn_decoder_test
>>>    HOSTCC  arch/x86/tools/insn_sanity
>>>    MODPOST Module.symvers
>>>    TEST    posttest
>>>    CC [M]  arch/x86/crypto/aegis128-aesni.mod.o
>>>    CC [M]  arch/x86/crypto/blake2s-x86_64.mod.o
>>>
>>> Now will try with clang non-LTO.
>>
>> Works:
>>
>>    AR      drivers/usb/built-in.a
>>    AR      lib/built-in.a
>>    AR      drivers/md/built-in.a
>>    AR      drivers/built-in.a
>>    GEN     .version
>>    CHK     include/generated/compile.h
>>    LD      vmlinux.o
>>    MODPOST vmlinux.symvers
>>    MODINFO modules.builtin.modinfo
>>    GEN     modules.builtin
>>    LD      .tmp_vmlinux.btf
>>    BTF     .btf.vmlinux.bin.o
>>    LD      .tmp_vmlinux.kallsyms1
>>    KSYMS   .tmp_vmlinux.kallsyms1.S
>>    AS      .tmp_vmlinux.kallsyms1.S
>>    LD      .tmp_vmlinux.kallsyms2
>>    KSYMS   .tmp_vmlinux.kallsyms2.S
>>    AS      .tmp_vmlinux.kallsyms2.S
>>    LD      vmlinux
>>    BTFIDS  vmlinux
>>    SORTTAB vmlinux
>>    SYSMAP  System.map
>> make[1]: Leaving directory '/home/acme/git/build/bpf_clang_no_lto'
>>
>> [acme@five bpf]$ grep LTO ../build/bpf_clang_no_lto/.config
>> CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
>> CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
>> CONFIG_LTO_NONE=y
>> CONFIG_HID_WALTOP=m
>> [acme@five bpf]$
> 
> Sorry, I forgot to use clang on this no-lto build... doing it now with:
> 
> [acme@five bpf]$ grep LTO ../build/bpf_clang_no_lto/.config
> CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
> CONFIG_HAS_LTO_CLANG=y
> CONFIG_LTO_NONE=y
> # CONFIG_LTO_CLANG_FULL is not set
> # CONFIG_LTO_CLANG_THIN is not set
> CONFIG_HID_WALTOP=m
> [acme@five bpf]$
> [acme@five bpf]$ make -j28 LLVM=1 LLVM_IAS=1 O=../build/bpf_clang_no_lto/ vmlinux
> 
> - Arnaldo
> 
> 
