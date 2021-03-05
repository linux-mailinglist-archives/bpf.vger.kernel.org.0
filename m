Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB9932F55B
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 22:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCEVgy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 16:36:54 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47040 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229672AbhCEVgb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Mar 2021 16:36:31 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125LWroJ027883;
        Fri, 5 Mar 2021 13:36:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=szZwv0gjpsr3qPHiMNJfzrrzKfOKlo2Bj0BInYRfyHc=;
 b=SbWDLSkpDNZcEVG5vlI+Y1ZMQ1sZX/tZcE3wq5E5c/aoEu2tqMny6gqbb6K20Lys8D4/
 gcsYtt+iihEccBxTsTr0ptzBTdYFzC+q74Ycw4daNlKX5nV8MCX1IFIJ/T49v1aI+SbU
 jL4L5g+aSsoYnU8yjuV4kJXrYh/0Eu2IfGQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 372nyhuydd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Mar 2021 13:36:29 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Mar 2021 13:36:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddXyFKHPfFOOx6OkcYakuCwKSKGf+EBv32aSn08pEaB9ys4Y0NNtDtf8JWFlI8EqIDDYmMvR3JQDcN/KVu+PoygtzBWU2UDr3Nj8UtQ1TcTRABAfDgPDde3XiN/wRUJmRigxwl3grNPSej2tmtjCCrWpA/UTpvfE82okm3luX+LY50RAfYwEuKMAPLV+jLs9DiE1JD+j7KdLy4yuZrmISoAdlKYtvCerxcbT5iC+E0Y+RPNGvEM7EOCKM/59ztDQ2ZtaV0GYIkWg2vK4KsnrSCmA3FDyXPV3NRVYCBJJgupsuPyXvLS+/yttnnVA+7nB17xdWJ9kH4qOyAwTdPYLVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMCRr9BUsYkKnOsf8tTFPlsYNCKjUKtskN6V7Nsm9ik=;
 b=ntBxm+F117lpyGWHFeLMEkf7ntuSi53Nbrb1PPizLHvFlblkidC4+R3pa+VKzeQGzYRMoeqRuKHTmnpy9oEj8l3dl/UGqZ1hUAnzydoXCZ2BeMG8rguU6LeRtgs/IyUdSaoLMfwKPYBegL2FPDn5OK7yMiyfv6BgvT6FMzVO7q8y5jGEAIGdKAaAzlJONqS+qEq1w0PbY5n0vdyZd2l/mNGNq6gGqo+w7MIGfU7IT06+AhPKlKvWe51viM6bjximmOS83GEPCOtpDYaGbS+isbsgT1RhIkqVRB+cviruCU5+YWRxn24Hbl2d5xtXqnofsAJbxqbE/llj7WGIGw8prg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4420.namprd15.prod.outlook.com (2603:10b6:806:197::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 5 Mar
 2021 21:36:28 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.034; Fri, 5 Mar 2021
 21:36:28 +0000
Subject: Re: bpf_core_type_id_kernel with qualifier aborts clang compilation
From:   Yonghong Song <yhs@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>,
        Andrii Nakryiko <andrii@kernel.org>
CC:     bpf <bpf@vger.kernel.org>
References: <CACAyw9_P-Zk+hrOwgenLz4hCc7Cae9=qV86Td2CkGVUPAzWQ8A@mail.gmail.com>
 <a3782f71-3f6b-1e75-17a9-1827822c2030@fb.com>
Message-ID: <6c02f403-666f-2025-4a57-416feab147a5@fb.com>
Date:   Fri, 5 Mar 2021 13:36:25 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <a3782f71-3f6b-1e75-17a9-1827822c2030@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:81bc]
X-ClientProxiedBy: MWHPR11CA0047.namprd11.prod.outlook.com
 (2603:10b6:300:115::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1105] (2620:10d:c090:400::5:81bc) by MWHPR11CA0047.namprd11.prod.outlook.com (2603:10b6:300:115::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 21:36:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99460784-e8fe-4734-aeb7-08d8e01ebbe1
X-MS-TrafficTypeDiagnostic: SA1PR15MB4420:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4420001853179BE8C99D70F4D3969@SA1PR15MB4420.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TXmuxcFyxEWwblGri8Q22sbnT2VHr5A3sgxKj/dp4Sp1VzaM3+aKYuc6n3KHHohIAEO/qXf+qSq84rQzj3pR/Qo5kksCkSr0wvRSa93Xe1ZWdfKKlHwTvhb+KnpIMxK7yIAJ/WFiXdpRA+QtU+wcgE+ykrBeHFYfscoDkJz1pewhouLkG2KJ7mwMxgCPeEjQAEK+oJ2nUI3knQyhCp9ohBP+r9+5k9aNlE1Oqnqud1k3uhpC3jrnZ2A+JGMp/07fowodB0RbolFUl7iyi/9j1FtSsSTzBd/zdZy968yv3MK4qRWMZ/BCXKM6pBvLX8ckebtCOcAd2alvur4X13mTrp38AUY1LQRy6e4GSPSk7GCLuFWRvlz1T5dMOueo0RmBz8VbqYV0Y4dEllI2aEcvSH+21FGYhd9ZUdnoAOaoS+JbaQbbjN5qPX6I5rKM3yeG1thOLS2UEbpjTDBfc4EVJYw9cerT/YBBoYp+DuOVSPw2DfAFso4TpgqUYc4MUdwN6tDKwkoJeWgBlOn481zZTTn2Oz4aqLYASYphBNAYfPPBvwtao8ImMemnD+MtAuFuSoVWUOho9O0/wT0jjPEDvMrhM5149VJ6wjl56kzbFrb79zjaZbXCP94DCJ1HNWAbGAln0tGPXJjv4h+J2oSbP00/InCLeJvjW8jHrT10o2ju3TIsWlwzsHZV6/kTzDt/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(346002)(366004)(376002)(16526019)(186003)(52116002)(5660300002)(110136005)(4326008)(316002)(83380400001)(66556008)(478600001)(966005)(66946007)(86362001)(6486002)(31686004)(2906002)(8936002)(53546011)(8676002)(66476007)(2616005)(36756003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y0VOTXQ0OW5JbmpiM2Vmc2wrTnJORjlGTmRDUEJwdFJEanovMEVWUU1HV2hr?=
 =?utf-8?B?emVNbTlONEpGOTZ1ZmtESk9IejBTd2hYbk9zamFoS29BZ2hIV09wRkFOZE44?=
 =?utf-8?B?d3dQb3pyMWE2TDdZa3A0RnhRUGNrZ1BZN2JzaFNHRUl3WDBpQVZUMTYvU3Nw?=
 =?utf-8?B?ZmNuZnZnbkF3TGZRTlBkczN4TFlHZGIwNHhROFFwZ0NKM1BoSXNNSEtERVln?=
 =?utf-8?B?T1V2NTkxLzVJWTljZnlNU0ViTEVlQ1pHckVNL2h4Y2lpdnhZRWkyd1RZck16?=
 =?utf-8?B?bUFrLzRIM2dHNm04OHVXVzVPbVdzTXBaaXVkSEFMdkRLeFJRTmhJaEUrYmJF?=
 =?utf-8?B?TmtHblF0c0dYTG1IQWVJdFNqSWJIem5sSEtNYktwa0IxUkxnTzQwZWIwZ2xx?=
 =?utf-8?B?K2plcHlxbnl0S1dCVnJjQXM5cC9BVWNmTnlzQUNxUHhoMjd6VUpUV1ZYVzBY?=
 =?utf-8?B?QUJkQjB3SzA2ZlovRnh4UDJTaUJJZ2Z6WlA3Q3RlSVRoN0VKQVJLcGNRbHlv?=
 =?utf-8?B?REZrN1VRT0tnd1V0WUl5Q0xNcGppdVJXYlplWGlxMWFOQjVrbjdmblc2MHU5?=
 =?utf-8?B?UlY0RnpLdlhqQ3Y2Y2QzWTlGa0Rob0llcFVCa21iT0lFb0lobjg0RDZZdEZu?=
 =?utf-8?B?TXZBU2dzQWlBNzVIYmIvdVR3dUlnSUN6bVZUY1JtT2lSc2kyT0M0RnJ1Vytq?=
 =?utf-8?B?SzRVVmp1dE16ejZqMk4zaVo1ZjRVeTFhcTMrcmorbjlUY1hUUUgxR2twdTlF?=
 =?utf-8?B?bjh1MW5WaERDVEJjZmZ3Ui8vWG5aaFJoY0tJWUc1UENQT2htNFhXcTY4Q2dN?=
 =?utf-8?B?R1U5dTdsZldidVZNZ0MySXpXUEZiTHYwV1FjbzVyMytHb1ZJK1A5dkFHWS9p?=
 =?utf-8?B?U2s5YlZtNTl6cWFTTXJ0NmYwU0JFcUVramo0eVgzNHN0Yis0MGN1dTBzeEpT?=
 =?utf-8?B?QlZ2VmZUVkJIejdpTjBsUTR3UFhMSGxTd3dWMmJXWkVmTWk2NlJVRDN1Y2t0?=
 =?utf-8?B?QVlkUTNGakhScDczOEhuRi9DQXZpMDBVc3dBc0ZVZGJ5UC9ncER3eE1CazNE?=
 =?utf-8?B?Q1NKMWFESThtb1FTOE04L091bXNiWFFYdzZjcEdsbnpDTEIzSkROMXdnR0tO?=
 =?utf-8?B?S3pOZEthVzdRSGdRdEZkK0VxWnRuVURlaWVuZ1h6MUdidTdyZ0dOWndUZVBB?=
 =?utf-8?B?Mktkd2JMNEw1UHEvRVRJK2RzWnVGTURoa3pEaVN6U0ZHem1IVEZiQVFBVVR0?=
 =?utf-8?B?TVhLeldicC9uVTFmRU5wQmdZU29zY1d6d1REYkM5VSs3NVZ0YW9uUEZaMzR1?=
 =?utf-8?B?VENsai9jeFpFM25kT2xxdy9ybk9FbmNEL3RJcElaRW5UVTJYdTNYNGN3ZXdw?=
 =?utf-8?B?RGR4aEF5aXhFSnlUeHNNREI0MVFnMXpmLzJjM0hHbEJjQjVYVjdDdWFpRHF2?=
 =?utf-8?B?cXRxeG9pNk5YdXJzTU5SS3BaSDFQdmcxQ0dGbytIc0pWWnhzWFdMR1dnbWtE?=
 =?utf-8?B?bm01RVRzTGZIZ05OSWgwT0xWZ2U3V0VTRkJ6ZExaZmNRcDlldzJmRzBLTnRG?=
 =?utf-8?B?ZFNuNjRyRGZRNVd2a1pNTHlVS3FubC9kM1V6UG9qVUpreGRTUjdsbGE0ZTM5?=
 =?utf-8?B?ME9SWDdSZGhtODhibkp2N2h0TkJxMi96MW1wMmZFRHJOeGkwb2JJeXF1S2tS?=
 =?utf-8?B?WGhrencvZ3JPTlczNjBaNVdwOWgweTFTaGg3SDRZMlUvZ3VkWVBZY3dmazda?=
 =?utf-8?B?SDg4VkwvSldiWldMTVJ6U0dQeGZpVHVreXpCczhaR1I1a21ndWVJVFBjT1lr?=
 =?utf-8?B?ZTJUK0w3TVViK3V1cVllZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99460784-e8fe-4734-aeb7-08d8e01ebbe1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 21:36:27.9814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDc0TtgbyvQTt7/lnu+zWT29oC4p7TkiT2+wMUwXB22fFY/N18UCwt2jglE9SUDn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4420
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_14:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103050109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/4/21 8:41 AM, Yonghong Song wrote:
> 
> 
> On 3/4/21 3:25 AM, Lorenz Bauer wrote:
>> Hi Yonghong, Andrii,
>>
>> Some more poking at CO-RE. The code below leads to a compiler error:
>>
>> struct s {
>>      int _1;
>>      char _2;
>> };
>>
>> __section("socket_filter/type_ids") int type_ids() {
>>      return bpf_core_type_id_kernel(const struct s);
>> }
>>
>> Truncated output:
>> fatal error: error in backend: Empty type name for BTF_TYPE_ID_REMOTE 
>> reloc
>> PLEASE submit a bug report to 
>> https://bugs.llvm.org/   
>> and include the
>> crash backtrace, preprocessed source, and associated run script.
>> Stack dump:
>> 0.    Program arguments: clang-12 -target bpf -O2 -g -Wall -Werror
>> -mlittle-endian -c internal/btf/testdata/relocs.c -o
>> internal/btf/testdata/relocs-el.elf
>> 1.    <eof> parser at end of file
>> 2.    Per-function optimization
>> 3.    Running pass 'BPF Preserve Debuginfo Type' on function '@type_ids'
>> ...
>> clang: error: clang frontend command failed with exit code 70 (use -v
>> to see invocation)
>> Ubuntu clang version
>> 12.0.0-++20210126113614+510b3d4b3e02-1~exp1~20210126104320.178
>> Target: bpf
>>
>> "volatile" has the same problem. Interestingly, the same code works
>> for bpf_core_type_id_local. Is this expected?
> 
> First, bpf_core_type_id_local() works as compiler did not check type 
> name. for bpf_core_type_id_local(), there is no relocation, libbpf
> may need to adjust type id if it tries to do btf dedup, merging, etc.
> 
> Second, the above bpf_core_type_id_kernel() failed due to
> "const" (or "volatile") modifier. bpf_core_type_id_kernel()
> requires a type name as relocation will be performed.
> In the current implementation, the btf type is
>     const -> struct s
> and there is no name for "const", that is why compiler issues
> an explicit fatal error:
>      fatal error: error in backend: Empty type name for 
> BTF_TYPE_ID_REMOTE reloc
> 
> To fix the issue, just do not use any modifier,
>    bpf_core_type_id_kernel(struct s)
> should work fine.
> 
> I think in the case, it would be good if the compiler tries
> to peel off modifiers and find the ultimate type name
> instead of fatal error. I will put a patch on this.

Lorenz, the issue has been fixed by llvm patch
https://reviews.llvm.org/D97986. It is in llvm13 trunk now.
I have also requested the fix to backport to 12.0.1 release.
Thanks!

> 
> Thanks for reporting!
> 
>>
>> Best
>> Lorenz
>>
