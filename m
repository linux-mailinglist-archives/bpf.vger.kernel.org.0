Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C874B2B27
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 18:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiBKRAt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 12:00:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiBKRAs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 12:00:48 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDF93B3
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 09:00:47 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21BFHETE004256;
        Fri, 11 Feb 2022 09:00:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=4TsPd6pV2uPaF57zDtCQSI8SMukPt5ws7FYR1rsuyJk=;
 b=cX5ycscIZoAnFIa/2zCgfHY71/CSSrVQxS4La/1h7U2ybIPQWc3JzqlAzEyZo8DPLxLf
 /Y5vYOR2qISohFT1Brpdo528N43l81R9uaNn8t/lXVWspdI1ZRpGDWrG1hjj2h5Ylj+Y
 R8RESxkd2SEpjfswjWK5ukq8DH5UkEz2n2g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e58y9xm25-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Feb 2022 09:00:15 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 09:00:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UR5D9vhlCF4hnmp7wPbpC4irTAJJ0LVIYSPHUueZGQtXC8lGBO6AcbJATE6+udAnHLoN/zn6yTcC2dNhG8SdZAI/3dI0dtWqaAbGCjfecZT1y7mOx00rybCrHKxSV9XNuLklO8IGu5kn51vu9odoWUuLtQTfTj0QBhErAEIv7tXsBqnChrb4w/53fZ2zzEFzqwZyomyTILvn5+nY6Eb12sGynE0yF+OHZMG1xCXKUHFF7qzF3QnBpATVlomChMyRvot9ollQ1w4cs4fQd6HhJp5Co6KCglhgIYub9ZEf7eG4ie2aotk9kFZD0pW5uy2KI3ZW/JNdlbJq/bY+lKhjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TsPd6pV2uPaF57zDtCQSI8SMukPt5ws7FYR1rsuyJk=;
 b=nVU1ZyvGwFiNQGk5AdZJulmN+L4AZSdphsk0QOSeWT63yFfwfsEFdAm7D+QpzUu7K/kGEjZGWflZk6p1FhoxOdzu+XNmvVAHIUqOWTY1UyhV/biWHUJmut5oLQGniu0+PMnEbP4h4VqAhLbJO89zEr07XMgup1uKccDxuHlKAf8ogiG75rHFb/rSw2CbGsHRPyN8kF3s7nujjzvXfI5K7czi5SwAabiYyQX6WJQfjDQnendoXFDaw2GOnCp6kbdhMXvbPON5x0KwuIHZ6qoS0DymN579/XAUttUaTT9z0I4E8wQIw0FIsJ14AQRPriGVuJzgYmVU0QlIpmIWgl1Thg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by MW3PR15MB3963.namprd15.prod.outlook.com (2603:10b6:303:50::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 17:00:12 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b%6]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 17:00:11 +0000
Message-ID: <a311c131-e960-7543-2457-fa1ae43e23fb@fb.com>
Date:   Fri, 11 Feb 2022 09:00:08 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH bpf v2 1/2] bpf: fix a bpf_timer initialization issue
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20220211152054.1584283-1-yhs@fb.com>
 <20220211152059.1584701-1-yhs@fb.com>
 <CAADnVQJAMf0u=7gcpuNVgx7DQ8Zayvg4KGHYnQ7eNPjbVmc=cw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAADnVQJAMf0u=7gcpuNVgx7DQ8Zayvg4KGHYnQ7eNPjbVmc=cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:303:b7::14) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11b867a2-6f23-4176-dfd9-08d9ed7ff749
X-MS-TrafficTypeDiagnostic: MW3PR15MB3963:EE_
X-Microsoft-Antispam-PRVS: <MW3PR15MB3963237A5F1C35D0DFBA6FB8D3309@MW3PR15MB3963.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FNjh1+LsCp8G0dY2GgTmdVxw+t/vF3L6dtQhddl1Q9do+Ohf+7FH+/g2we0+UkSLWgG+vxyVKXysFI4sry5IXZHb14+D096pbclOjgO3r+fT+EHLsECTyQ9ykIJa3W0opgNe8CAgmdw/eyEhSIA8Oo2o27lt0RzpCq4jQdvFin39q0usesnv1Jh2lQFTreZI29PYCpLTBAHh3HGnfPgFKdg0UbAaqagRCsmVy9ETWIc79qHCh3q70lMQGGE+Y1DrD1lJLhSS53Meb3FOTq+ssSPXIo5LLxf8fvhK4w8pZfcFipsy/DJ2rWKhYVEkmwEJZIh6JZfnRWR+T1/Il/8c9Ewva7wmPnxp6tbyT1rTpbGBhLakkVbb6NLocx+3ZXLW89PJpHrRtwXulrCwvo3M6/cfSyKoiEBVU6zut4fGvFUS1Ht9XZgLSjwPClbVr0kdR/UWkc6MxJuohWL3+c56lqOVUMBnlMW6XWiax7RDeGmp4874drzdE0lDdXvRvtlnLPEibtx04IdLQeeuinGQqdtJhybFmcaBQ+mwzdZpBksP7yIUGgDT7kNXWNeIPcfI0fSBEHHu97TrpwfpqQeEU8pqhFJf9sCpZfj22d2QaoG8GE0H2A5vSsKjB325EQ0Mdq+j1xUwrhPSsUCKYTXxtMZ+sn3l4Hv6GawhVSCyDaWYCAYKFFiw4G44vJn3FPOAVpTWJ4axPHCO5UJxjuO0EzQP+RYNN2oiSvjYw9los7GKdU0AROHtQ6Q6R87mTfDS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(66946007)(8676002)(4326008)(66476007)(186003)(66556008)(83380400001)(2906002)(31696002)(38100700002)(5660300002)(508600001)(6512007)(316002)(52116002)(53546011)(6666004)(36756003)(8936002)(2616005)(6486002)(31686004)(6916009)(54906003)(6506007)(2004002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkpOdDJNMzQ3VUZiSXpQT2FiaVJ0R2FGaHRveENtME5Nc0NZU0JRTXROQzdX?=
 =?utf-8?B?YWFmWE1NcnVwYkc1dVppQlNyWVp0K2I1eFNzMHhyMy9WUStZTDBxbWpEOFpo?=
 =?utf-8?B?UHRKQzNmY2ROTUwyVHdmVnQ5QndzbGFZQkZBMlkwUEV6VmdxSldPN21OR09y?=
 =?utf-8?B?ZGpUQXFYZmdpb2tlQ3lTdWIzdzFCUGlRNis2VlNpdng5a054ZUM3aW1ZcEE4?=
 =?utf-8?B?OFZIbldibTZIazNuYk10UVhrOEZUa0hTL09ONVYzRGMxV0Erell4dnl5YzN6?=
 =?utf-8?B?NlVEVzNyWFl3bG5hOEtobU8wZ0RjaGJiUTRmTFJtT3BlOGlGdFU4cWFaWnNV?=
 =?utf-8?B?VXlZZ1pROTFxNFVob05NWFpvUTFRS3VPZ1FVNHdpRmxMa2VITy9zNytlM3dF?=
 =?utf-8?B?YXplbEJLSUppM2NJd2M5RzJMbkxCOUhNMXppY00xdlFtWUJ2YUdMSldTVTcx?=
 =?utf-8?B?bHlOL21kQk5kbkd2S3htYUk5OG5vMnkvVlRkekE2bjhSRHhyd1dMQTdOTEY3?=
 =?utf-8?B?cUUzOFl4ZFNVKzhCRkxjQVQxeVVDYy9ONzQva0pmQzlQQ2tUSWgzaWgzeGhL?=
 =?utf-8?B?SFdCbmUzYk9KbHp6V3kzRDZFcHFCTmVMZlpnMW1CTG9rR21CaVgycVVxVDNk?=
 =?utf-8?B?cXRNbk9EdFJRUm5BZHdrNFd2YUpNcDlKQ25rZzRYOFM0cWUrS0l3ZWFZem5o?=
 =?utf-8?B?UGVITGY1UkNyOVNVL3lXajh3emh3YXh2eHdtZXdmczV0eC9vQ21NU2dPUUpX?=
 =?utf-8?B?bS9SS3VVcUpkcUI0TVlZdThaQWw2eUY4TytEaVZyNFRQdDhXeVE3V1dMMEFs?=
 =?utf-8?B?ZEtoV0FPWmx4R0NvaDl4bXlTNnNIQlpPenEweVlFdjhuR2JzREk1TmVkczlJ?=
 =?utf-8?B?aHgvbmhQMkdJdlloTnMrQS9qVEdaSEMzTWVkVFBoSkZaZFBIMUo1LzFvTEFz?=
 =?utf-8?B?ZHVpNGFsTjYwdUpWK3A3R2NhWHEzVVhNeVNua2JYTjJpeWt3aVNZSVJhcG0v?=
 =?utf-8?B?K3VwL0haTHk2TzB1WEt2SHVqaW1UdkdHU1hOakhuZXFNeHhzamk2RjMyWU5h?=
 =?utf-8?B?aUhVTllYcGJyQU1vL3FIOWFtanI3SFJEWmMvdnVac0Z3cE5UOEZqZkFyN3pi?=
 =?utf-8?B?ZVpMNTBVR3RXRVV6NjMrKzYrYkZ6ejNBRkJUaUl4elgvUGhYUzQ5OG0yeTQz?=
 =?utf-8?B?ZFFOM040bVJjUzBiVTJCRy8zUzlJY0VEMFJDQnVsWVBuaEJzbE11QzM2Nll1?=
 =?utf-8?B?VXp3U2lLMzBqWnVjYzIwblJ3QjJtbGtNaDVsYkJCbVZ2ZU5yYVVuSlVKb3Ax?=
 =?utf-8?B?SjlUZlo4YUhJQUZLdndzcERKWnp3eDNScU1nMkNrQWxyaEQyWktTUXR5WE00?=
 =?utf-8?B?WGN4Rm5yenFMNG93UjcwVXdaM1Z2bzZSVjE4anVrMWpyb2xuU1dMMGxESE5U?=
 =?utf-8?B?T1dLR3JBUjJITkN2N1JUbFlBa2M3end4WFB2TnlVS0NDMXp1QlZ6d0RnSlA2?=
 =?utf-8?B?SWRBcWszOHN2cWE2c3VEb05rL1hwQ1BnNFhxR0E1T2ZnNGhJVTJZWEtsdGpK?=
 =?utf-8?B?ZXFnUDA0RWJZbDlMdXlJWGFUMjV5WndMekRtM0l5Tko3TTBCem15bVNDVUUr?=
 =?utf-8?B?NkZLSHM3MCtzdHptUUNvK3pIY3U5SndsSkxrYWdHZVB1dU5zUmFWYUpQUity?=
 =?utf-8?B?Z3FwT0JWQkxndnRtQXJFRzhsQmhjTnVsaE05ODVVUjM5aDhIRTRJc3h3MWJu?=
 =?utf-8?B?K2IxQUxOcWJEL1Jxdk5MLzRQdVVQUTUvc0pEaEE0ZDNwc21EeWliQjdjKzJ4?=
 =?utf-8?B?WmVuTEVyZ2tYWm02OUx4RVRQQU5UbHZjNElBdmxhRVdEYjlNVktYS0w0dEJh?=
 =?utf-8?B?SUhRZGtFbkcwbFk5ZG5uTU10UmFLcTRhQ2Nwc1N5QVRCcDd3bjhEMnVRdSt5?=
 =?utf-8?B?UjlXMCtLOTc5cmpoTGVWWWhKVGJwZ3RVcCtRKys1K0pxWURWdDNiQ0V2Tnp6?=
 =?utf-8?B?UndXVGhjZEpSV0tpRGNlNktpU1pBYW5iQW5nY1hwQjFDa1dPZGhBeUJ5VnNI?=
 =?utf-8?B?TlFPa3ozd3IxRVNEMS8xeXF4c2R2OHc1c0dGbjBFZHVqanZoOUo4eFRmbmNk?=
 =?utf-8?Q?jRW3OdIIseil3W710IT34G/Fv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b867a2-6f23-4176-dfd9-08d9ed7ff749
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 17:00:11.7266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWSIgJfbaMFFeIxp3F1kOUyS2Ocsxx/mqrnzy3KI05eB2ih+tAtmCh+XIvbcpnkD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3963
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: X2n9D67eEqVudyD9257NVD-eH_Sh6Ude
X-Proofpoint-ORIG-GUID: X2n9D67eEqVudyD9257NVD-eH_Sh6Ude
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_05,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202110092
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/11/22 8:47 AM, Alexei Starovoitov wrote:
> On Fri, Feb 11, 2022 at 7:21 AM Yonghong Song <yhs@fb.com> wrote:
>>
>>    struct bpf_spin_lock {
>>          __u32   val;
>>    };
>>    struct bpf_timer {
>>          __u64 :64;
>>          __u64 :64;
>>    } __attribute__((aligned(8)));
>>
>> The initialization code:
>>    *(struct bpf_spin_lock *)(dst + map->spin_lock_off) =
>>        (struct bpf_spin_lock){};
>>    *(struct bpf_timer *)(dst + map->timer_off) =
>>        (struct bpf_timer){};
>> It appears the compiler has no obligation to initialize anonymous fields.
>> For example, let us use clang with bpf target as below:
>>    $ cat t.c
>>    struct bpf_timer {
>>          unsigned long long :64;
>>    };
>>    struct bpf_timer2 {
>>          unsigned long long a;
>>    };
>>
>>    void test(struct bpf_timer *t) {
>>      *t = (struct bpf_timer){};
>>    }
>>    void test2(struct bpf_timer2 *t) {
>>      *t = (struct bpf_timer2){};
>>    }
>>    $ clang -target bpf -O2 -c -g t.c
>>    $ llvm-objdump -d t.o
>>     ...
>>     0000000000000000 <test>:
>>         0:       95 00 00 00 00 00 00 00 exit
>>     0000000000000008 <test2>:
>>         1:       b7 02 00 00 00 00 00 00 r2 = 0
>>         2:       7b 21 00 00 00 00 00 00 *(u64 *)(r1 + 0) = r2
>>         3:       95 00 00 00 00 00 00 00 exit
> 
> wow!
> Is this a clang only behavior or gcc does the same "smart" optimization?

gcc seems okay for my above test.

$ /home/yhs/work/gcc2/gcc11-2/install/bin/gcc --version
gcc (GCC) 11.2.0
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

$ /home/yhs/work/gcc2/gcc11-2/install/bin/gcc -O2 -c t.c
$ llvm-objdump -d t.o

t.o:    file format elf64-x86-64

Disassembly of section .text:

0000000000000000 <test>:
        0: 48 c7 07 00 00 00 00          movq    $0, (%rdi)
        7: c3                            retq
        8: 0f 1f 84 00 00 00 00 00       nopl    (%rax,%rax)

0000000000000010 <test2>:
       10: 48 c7 07 00 00 00 00          movq    $0, (%rdi)
       17: c3                            retq
[yhs@devbig309.ftw3 ~/tmp2]

> 
> We've seen this issue with padding, but I could have never guessed
> that compiler will do so for explicit anon fields.
> I wonder what standard says and what other kernel code is broken
> by this "optimization".

Not familiar with the standard. Need to dig out.
