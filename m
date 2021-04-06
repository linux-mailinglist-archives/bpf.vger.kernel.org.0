Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2F0355ABA
	for <lists+bpf@lfdr.de>; Tue,  6 Apr 2021 19:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244466AbhDFRtU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Apr 2021 13:49:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54220 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234159AbhDFRtT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 6 Apr 2021 13:49:19 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 136HlWv7031349;
        Tue, 6 Apr 2021 10:49:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Rc1BYhTGsZToQ285BMgJjJxEXp1iwJyIFDvmnjaUDys=;
 b=DyL1hHaXh/jTFSVLOII9FUAir2rSrkk7BEiHRRksI69U5PIrJYH8yVZ87PyVgcAhC6gY
 iK3loRbciUrqc/8+/OsqqLSF6Kg/OkCipgtz55OGpzysBJJSewLEpxmGATXnPmCq33do
 iHwASGs5Zce4x5idAFucnUmRq5GvYcljZgE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37rvanr0y9-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 06 Apr 2021 10:49:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 6 Apr 2021 10:48:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+oAfOcKPhy3eoCxmQ8hRhz/6gLy0FfA0GADvbA6OVqOOFEbmxWv6rlfb1Kp0cIZCPLdoou/YkaSjqfx5qjze1Yj/ySb90WqLcejX+yVHcggsbRblrhvgZZ6whN6l+A2uySH7doRUycJXV5d+/gRGlaLEtDZFDctCkd/LuPzCaY//P9ak4uG29PJpmKh+v9Ta1x1UdgDsRBWIwMr7514g1MMMN+Zvxy3Xq6J+GZAXwiDI1/BldbV6bjm02aKSCukHwaYsH88tkBNLBChiaJuGKSCog4nzZPMvQOOKIYGrSTaNGcro6PBWFIGLSVO6Y619jJKG5/ggeXBRdY0YDreJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rc1BYhTGsZToQ285BMgJjJxEXp1iwJyIFDvmnjaUDys=;
 b=C59t9TNDTW7wixWsUTNbWRKVcD6dvhVcEGUm8lFSurCxeQqsc/rtkaY6G1UvKeJvW0ticrHbLj54naEJxVCk/+caJLOL4A7i0BGhaXVmvXTCEADbkuEsrHa78Lu9DJ2hSuVTF11R6fcmHdgdjsNdtPLTfqaYmzJJ2XxEhMRWzmg5LPTbBQwtnDYiXqvMLHLExic1e3AISM9xtpOVf/dqU1dBc7wcsxAr8x/6gI9j0H5xUhrrU5YlhczxMxqr4DCaQ3CaDw37mT11sb03PMmauyn1xkyKkMsE/GPQojeQYfBB79c2f2TKn2Fl9kWEDUmVQFzdrPlotYr8NhbxMNzXMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3855.namprd15.prod.outlook.com (2603:10b6:806:89::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 17:48:26 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 17:48:26 +0000
Subject: Re: [PATCH dwarves 0/2] dwarf_loader: improve cus__merging_cu()
From:   Yonghong Song <yhs@fb.com>
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
 <YGyUbX/HRBdGjH3i@kernel.org> <3a6aa243-add9-88a5-b405-85fd8bfbe21d@fb.com>
Message-ID: <4eda63d8-f9df-71ab-d625-dcc4df429a89@fb.com>
Date:   Tue, 6 Apr 2021 10:48:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <3a6aa243-add9-88a5-b405-85fd8bfbe21d@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:5b04]
X-ClientProxiedBy: CO2PR06CA0057.namprd06.prod.outlook.com
 (2603:10b6:104:3::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::142a] (2620:10d:c090:400::5:5b04) by CO2PR06CA0057.namprd06.prod.outlook.com (2603:10b6:104:3::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Tue, 6 Apr 2021 17:48:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7eedb632-c763-4f7f-bdc2-08d8f9242e01
X-MS-TrafficTypeDiagnostic: SA0PR15MB3855:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB38553D864D9518A0CC451CD1D3769@SA0PR15MB3855.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ht2m3q11uf36TskHWeNfpRKG1QE1+EQxmwGbRh1Irf0kiRTbjYRDzKDxf8qpfSzftKIaGVaNFu2rnTN9zSD/xk+tflQ8Bq64egxhAdVQWOLx1d/WfrZaC0pKBhGmC2yykJVIrxUeM9pTXbY7B7MIASgtQkvo5JHfXHpTUoe2aBm7dIK4B35i8pnlJH9co+AS9WvF6R1yjDZ+OfYf1PuXsznLUaKdyzrihYYgMvWvjQLQWX4FgyI8o3BrMS/CeRFJmiu/lDBukLzwdEdmmB2SsTgdCSSO8/FaQncxDRE4cAh4dTxhES2E9YPo8WMjN+rDnwbpGKoEQjP3/CpnO6dYGdSZhQteqI5iVoGL/tYgQA72zxuH5ML3eP7FQvMMJHYqqR9cy0iOxt3DA9Imz6sEpGuS3988ByDc5RoRlv9m1c7gLCDR+swbwC6jJOAxFN03wKxUaEQ9tSRK+g6eddYEjYnm1Q1TRniQG6v+EO4QtJZZMrtWTpB5pmngPq39S9ygkksT85A5vuTe2hcyLOLQOWnfcTRedz0axddQYl2OV48DuLwUqCwzaIGwxWks6WC/9kebGYd+IDywIIpvQKcyxCPBJo7BgRJn9kDO2mF7RTMou85hT9Pq93mScnUhv+OeXbnvKwyBEL7FnrfegQNIe48uT4WVKqyHs5UkRNjRarStOlKwkZEgW6PEQpD/XdpoBZBsgSQSVgFnzZr4sCKycEXiVJyYWUulECETSLIvTHJtTHGcKFLZrjU1y9BD5m4349RMXyOF2kA9ewC8vhmAclr3WZNecqcK7Uxmyiqfs5Xhc4OKPX0ruo4hJcsZVtwbfLoFGw6VTAM87GTwtsDGBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(136003)(346002)(396003)(31696002)(16526019)(110136005)(186003)(2906002)(52116002)(31686004)(53546011)(83380400001)(2616005)(86362001)(478600001)(316002)(36756003)(38100700001)(7416002)(8936002)(5660300002)(66556008)(66476007)(6486002)(4326008)(8676002)(54906003)(66946007)(101420200003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K3AxeHFXbk1pOGVMMGZvSS9xUldNa0t1RjZZRllZUWEranNXVVFBNHFBcFJ5?=
 =?utf-8?B?dkpPcHd2bm81eVhiOXJSZTdwQm9QZ1J6QjF0WEZQOGY0TW9FeVVxVDh2d2I3?=
 =?utf-8?B?Y1U2bU9iNmNGTzBFMzliLzh2WWpmcnVhRUZiODZBclpEZ0NndytDZ0hEZkFK?=
 =?utf-8?B?aVF1TC9mL2Exd0pibjBGc2tGVFRZMEsxTE9zblg0NmZ0VElZd0ZKTjh4MUZy?=
 =?utf-8?B?b3ZQSml0ZHBmWW5TVkFDL0JHU0x0R3YweTlpT2FBeWVrSHdwNXl5TmFkK0pU?=
 =?utf-8?B?RW9QemVUTVIyeUlDY0RBZ2Z3bEZtZlFWWTZyVURiendKSjEvODNiZnlJbjBm?=
 =?utf-8?B?eFVZaUR5T3F3Nk9nbmFtT3hYSVp1K2RHc3BPNjFxV1JReDkzUS9CbFBpNFp6?=
 =?utf-8?B?Z0h2TENTbjVJb0doTmlvNmdPcndDMTV6VWlQQjByaUNXVTV1bmhXbU5wSDhh?=
 =?utf-8?B?Ylk2aFVwUzVoZ2JVckVWS1JRNWJCMXJpYWQ2L3F1OWd3Sm4rUjR2aEh6WFpn?=
 =?utf-8?B?dCttaTVuY25jRU03U3J2aGFUNjQ4dHRkVHA4VFFrUnRRQXM2NVBKOURsU1RI?=
 =?utf-8?B?NUlkcVBGejhXNVc0RnFPbUp0bXBFaFpBYzRWWWtKNDVXRUkwdmw2RCtHKzly?=
 =?utf-8?B?QnN0bzlwOTdta1ppbVVMZjBadXFreTM0SFNJTGNTMzZGbkZkRlUyOGpqVUlj?=
 =?utf-8?B?S2EzWGdDU1pZaXRRWjIva1JXbHBSNHh6ME9kRlpUdFZoQWdaT285WmVQUmJ0?=
 =?utf-8?B?c3lUR0IwMDBzRU9CZTd1NktlRmRrVXBta0dYaTVJOGlJUHRoNFdXMk5YZ0NP?=
 =?utf-8?B?ZzBUZ1RZc3JVcWxNOEt4bEU0Z2tlZHc0U0ZqazQ3MHZzYmszRU9pRkVJcFVq?=
 =?utf-8?B?TkRXREtFbTc0eSsvSkpLNkllUGx2M29aWnNQQnpqVDNtWGlra1YyR3Fyd1Nz?=
 =?utf-8?B?ZzZpYjdMbUNzNEsydjNaZGl3WmV4VmtOczQxamFJcnRiN0cxL010QnFpakt0?=
 =?utf-8?B?VlozY0tDQ2YydkJwMkg5ZG1VSHoyV0MyQUlVRDhiRzFxSE94aWJZOG10SWMv?=
 =?utf-8?B?U1owS05iVE9TMEt4cWVyTTlsaDBTUUpSOVZ1SjdoNkNvWG9CQUY0Wk9WVGxJ?=
 =?utf-8?B?TkRUR0g4SkEzZ29HaFVTNzVaLzNnU3NIODRvaVMvNExjeHpEbkpVdjM5Tm1C?=
 =?utf-8?B?c3hxYmM1Y21pMDQ4V3dVK3h5RDFwMlRqSW85eE1DV09NSTJzRFNVMFgzdTBG?=
 =?utf-8?B?cGhlM29DYjNpaTAxbmNDV2dna2k5dEJWWWZXM2ZGNng3ZE1kQi80ejVCODRQ?=
 =?utf-8?B?QUFnMkhUVG90VlpZUVVxZVIzSjczK2ZLVk9DcTQ5RHlIQ0p5dm5MVncyVlpx?=
 =?utf-8?B?NHNuSktyTy94d3NsMUliMVR2b2Z3R3QvVUF1c2IrQVIxeVF3L1VrZWNKVEw3?=
 =?utf-8?B?M0k1ZXFMbmJVa1dRaDNtVGhBL0JpU0lwMk1xQU1MVzhwM2g1blNzcytEd1VF?=
 =?utf-8?B?VkMxM1hWT01NSXlrWlVyZmVWMmhNd2grNlVYQWxZNGdsQ004WmVDVTlxMG1M?=
 =?utf-8?B?NldFeFUrUGpMWC92L0JVYXdXSGF5aUk4c08zY2dSRS9GS2dsTFpLQWVCaVNL?=
 =?utf-8?B?UWVOUjVZSTRlN1A0bmtSQWNGWmxnaHVmQzQ4ZDR3dyt6OXFCMG54Tk1iS01M?=
 =?utf-8?B?UW1KRllzbFdBY04veS9kTzZ1NkFwZ3Vvenc0dEZtY0E2NXNnZERXZzViUG1I?=
 =?utf-8?B?cTJlMTZKMHVmQXExSmZaSm82QThWYUlPajVjNEk4Kys3bWxrbzFuS1o2SFVE?=
 =?utf-8?Q?biQFpGiFAuXDcNUbVKb9qVN2l8knKjdOYTJeQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eedb632-c763-4f7f-bdc2-08d8f9242e01
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 17:48:25.9939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjKCs2ZepE5A5Zq7Qhppg5mwj0Tqsx4rsiK+3OGFcAbxGFeK/IP5+NeosRzWoZ2B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3855
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: DRktvpnQr4V5r0AuYl_7bHTb53YUxQC4
X-Proofpoint-ORIG-GUID: DRktvpnQr4V5r0AuYl_7bHTb53YUxQC4
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_06:2021-04-06,2021-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104060122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/6/21 10:23 AM, Yonghong Song wrote:
> 
> 
> On 4/6/21 10:03 AM, Arnaldo Carvalho de Melo wrote:
>> Em Tue, Apr 06, 2021 at 01:59:30PM -0300, Arnaldo Carvalho de Melo 
>> escreveu:
>>> Em Tue, Apr 06, 2021 at 01:55:54PM -0300, Arnaldo Carvalho de Melo 
>>> escreveu:
>>>> Em Tue, Apr 06, 2021 at 01:40:20PM -0300, Arnaldo Carvalho de Melo 
>>>> escreveu:
>>>>> Em Tue, Apr 06, 2021 at 10:22:37AM -0300, Arnaldo Carvalho de Melo 
>>>>> escreveu:
>>>>>> I'm seeing these here:
>>>>
>>>>>> [acme@five bpf]$ rm -f ../build/bpf_clang_thin_lto/*vmlinu*
>>>>>> [acme@five bpf]$ time make -j28 LLVM=1 LLVM_IAS=1 
>>>>>> O=../build/bpf_clang_thin_lto/ vmlinux
>>>>>> make[1]: Entering directory '/home/acme/git/build/bpf_clang_thin_lto'
>>>>>>    GEN     Makefile
>>>>>>    DESCEND  objtool
>>>>>>    DESCEND  bpf/resolve_btfids
>>>>>>    CALL    /home/acme/git/bpf/scripts/atomic/check-atomics.sh
>>>>>>    CALL    /home/acme/git/bpf/scripts/checksyscalls.sh
>>>>>>    CHK     include/generated/compile.h
>>>>>>    GEN     .version
>>>>>>    CHK     include/generated/compile.h
>>>>>>    UPD     include/generated/compile.h
>>>>>>    CC      init/version.o
>>>>>>    AR      init/built-in.a
>>>>>>    GEN     .tmp_initcalls.lds
>>>>>>    LTO     vmlinux.o
>>>>>>    OBJTOOL vmlinux.o
>>>>>> vmlinux.o: warning: objtool: aesni_gcm_init_avx_gen2()+0x12: 
>>>>>> unsupported stack pointer realignment
>>>>>> vmlinux.o: warning: objtool: aesni_gcm_enc_update_avx_gen2()+0x12: 
>>>>>> unsupported stack pointer realignment
>>>>>> vmlinux.o: warning: objtool: aesni_gcm_dec_update_avx_gen2()+0x12: 
>>>>>> unsupported stack pointer realignment
>>>>>> vmlinux.o: warning: objtool: aesni_gcm_finalize_avx_gen2()+0x12: 
>>>>>> unsupported stack pointer realignment
>>>>>> vmlinux.o: warning: objtool: aesni_gcm_init_avx_gen4()+0x12: 
>>>>>> unsupported stack pointer realignment
>>>>>> vmlinux.o: warning: objtool: aesni_gcm_enc_update_avx_gen4()+0x12: 
>>>>>> unsupported stack pointer realignment
>>>>>> vmlinux.o: warning: objtool: aesni_gcm_dec_update_avx_gen4()+0x12: 
>>>>>> unsupported stack pointer realignment
>>>>>> vmlinux.o: warning: objtool: aesni_gcm_finalize_avx_gen4()+0x12: 
>>>>>> unsupported stack pointer realignment
>>>>>>    MODPOST vmlinux.symvers
>>>>>>    MODINFO modules.builtin.modinfo
>>>>>>    GEN     modules.builtin
>>>>>>    LD      .tmp_vmlinux.btf
>>>>>>    BTF     .btf.vmlinux.bin.o
>>>>>>    LD      .tmp_vmlinux.kallsyms1
>>>>>>    KSYMS   .tmp_vmlinux.kallsyms1.S
>>>>>>    AS      .tmp_vmlinux.kallsyms1.S
>>>>>>    LD      .tmp_vmlinux.kallsyms2
>>>>>>    KSYMS   .tmp_vmlinux.kallsyms2.S
>>>>>>    AS      .tmp_vmlinux.kallsyms2.S
>>>>>>    LD      vmlinux
>>>>>>    BTFIDS  vmlinux
>>>>>> WARN: multiple IDs found for 'inode': 232, 28822 - using 232
>>>>>> WARN: multiple IDs found for 'file': 374, 28855 - using 374
>>>>>> WARN: multiple IDs found for 'path': 379, 28856 - using 379
>>>>>> WARN: multiple IDs found for 'vm_area_struct': 177, 28929 - using 177
>>>>>> WARN: multiple IDs found for 'task_struct': 97, 28966 - using 97
>>>>>> WARN: multiple IDs found for 'seq_file': 510, 29059 - using 510
>>>>>> WARN: multiple IDs found for 'inode': 232, 29345 - using 232
>>>>>> WARN: multiple IDs found for 'file': 374, 29429 - using 374
>>>>>> WARN: multiple IDs found for 'path': 379, 29430 - using 379
>>>>>> WARN: multiple IDs found for 'vm_area_struct': 177, 29471 - using 177
>>>>>> WARN: multiple IDs found for 'task_struct': 97, 29481 - using 97
>>>>>> WARN: multiple IDs found for 'seq_file': 510, 29512 - using 510
>>>>>>    SORTTAB vmlinux
>>>>>>    SYSMAP  System.map
>>>>>> make[1]: Leaving directory '/home/acme/git/build/bpf_clang_thin_lto'
>>>>>>
>>>>>> [acme@five pahole]$ clang -v
>>>>>> clang version 11.0.0 (Fedora 11.0.0-2.fc33)
> 
> This could be due to the compiler. The clang 11 is used here. Sedat is
> using clang 12 and didn't see warnings and I am using clang dev branch 
> (clang 13) and didn't see warnings either. clang 11 could generate
> some debuginfo where pahole didn't handle it properly.
> 
> I tried to build locally with clang 11 but it crashed as I enabled
> assert during compiler build. Will try a little bit more.

Yes, I can see it with llvm11:

   LD      vmlinux 
 

   BTFIDS  vmlinux 
 

WARN: multiple IDs found for 'inode': 245, 36255 - using 245 
 

WARN: multiple IDs found for 'file': 390, 36288 - using 390 
 

WARN: multiple IDs found for 'path': 395, 36289 - using 395 
 

WARN: multiple IDs found for 'vm_area_struct': 190, 36362 - using 190 
 

WARN: multiple IDs found for 'task_struct': 93, 36399 - using 93 
 

WARN: multiple IDs found for 'seq_file': 524, 36498 - using 524 
 

WARN: multiple IDs found for 'inode': 245, 36784 - using 245 
 

WARN: multiple IDs found for 'file': 390, 36868 - using 390 
 

WARN: multiple IDs found for 'path': 395, 36869 - using 395 
 

WARN: multiple IDs found for 'vm_area_struct': 190, 36910 - using 190 
 

WARN: multiple IDs found for 'task_struct': 93, 36920 - using 93 
 

WARN: multiple IDs found for 'seq_file': 524, 36951 - using 524 
 

   SORTTAB vmlinux 
 

   SYSMAP  System.map 
 

   LTO [M] crypto/crypto_engine.lto.o 
 

   LTO [M] drivers/crypto/virtio/virtio_crypto.lto.o

$ clang --version
clang version 11.1.0 (https://github.com/llvm/llvm-project.git 
1fdec59bffc11ae37eb51a1b9869f0696bfd5312)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /home/yhs/work/llvm-project/llvm/build/install/bin

clang12 is okay:

   LTO     vmlinux.o
   OBJTOOL vmlinux.o
   MODPOST vmlinux.symvers
   MODINFO modules.builtin.modinfo
   GEN     modules.builtin
   LD      .tmp_vmlinux.btf
   BTF     .btf.vmlinux.bin.o
   LD      .tmp_vmlinux.kallsyms1
   KSYMS   .tmp_vmlinux.kallsyms1.S
   AS      .tmp_vmlinux.kallsyms1.S
   LD      .tmp_vmlinux.kallsyms2
   KSYMS   .tmp_vmlinux.kallsyms2.S

$ clang --version
clang version 12.0.0 (https://github.com/llvm/llvm-project.git 
31001be371e8f2c74470e727e54503fb2aabec8b)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /home/yhs/work/llvm-project/llvm/build/install/bin

I think we do not need to fix pahole for llvm11.
When linus tree 5.12 is out. clang 12 should have been released
or very close, we can just recommend clang 12 and later.

> 
>>>>>> Target: x86_64-unknown-linux-gnu
>>>>>> Thread model: posix
>>>>>> InstalledDir: /usr/bin
>>>>>> Found candidate GCC installation: 
>>>>>> /usr/bin/../lib/gcc/x86_64-redhat-linux/10
>>>>>> Found candidate GCC installation: /usr/lib/gcc/x86_64-redhat-linux/10
>>>>>> Selected GCC installation: /usr/lib/gcc/x86_64-redhat-linux/10
>>>>>> Candidate multilib: .;@m64
>>>>>> Candidate multilib: 32;@m32
>>>>>> Selected multilib: .;@m64
>>>>>> [acme@five pahole]$
>>>>>>
>>>>>> [acme@five bpf]$ git log --oneline -10
>>>>>> 49b9da70941c3c8a (HEAD -> bpf_perf_enable) kbuild: add an elfnote 
>>>>>> with type BUILD_COMPILER_LTO_INFO
>>>>>> 5c4f082a143c786e kbuild: move LINUX_ELFNOTE_BUILD_SALT to elfnote.h
>>>>>> 42c8b565decb3662 bpf: Introduce helpers to enable/disable perf 
>>>>>> event fds in a map
>>>>>> f73ea1eb4cce6637 (bpf-next/master, bpf-next/for-next) bpf: 
>>>>>> selftests: Specify CONFIG_DYNAMIC_FTRACE in the testing config
>>>>>> f07669df4c8df0b7 libbpf: Remove redundant semi-colon
>>>>>> 6ac4c6f887f5a8ef bpf: Remove repeated struct btf_type declaration
>>>>>> 2daae89666ad2532 bpf, cgroup: Delete repeated struct bpf_prog 
>>>>>> declaration
>>>>>> 2ec9898e9c70b93a bpf: Remove unused parameter from ___bpf_prog_run
>>>>>> 007bdc12d4b46656 bpf, selftests: test_maps generating unrecognized 
>>>>>> data section
>>>>>> 82506665179209e4 tcp: reorder tcp_congestion_ops for better cache 
>>>>>> locality
>>>>>> [acme@five bpf]$
>>>>>>
>>>>>> I'll try after a 'make mrproper'
>>>>>
>>>>> Same thing, trying now with gcc.
>>>>
[...]
