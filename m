Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4517A35B653
	for <lists+bpf@lfdr.de>; Sun, 11 Apr 2021 19:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbhDKRY7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Apr 2021 13:24:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5392 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233822AbhDKRY6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 11 Apr 2021 13:24:58 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13BHLYIv028473;
        Sun, 11 Apr 2021 10:24:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=zRxH6dDSPZ5//2UCsgq2fi4semI/DgtTSWdOkgKUJqU=;
 b=kIVef/LhEGb0fQ/TQXDIlCpTSD/nin8/VMGQMNZ1DZuCoQ7++DmfCpfqnHFHoP/Mxug5
 mK5xz7ZA5kt61L8nlD9DFsccs/YO03tlEKkX4nIuupM9P54DtaBP6PPyPcs1r8Ii03+0
 qVsF2iALSO93n62wpmbGgyM/Aj9whQwj2/M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37uuus9mgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 11 Apr 2021 10:24:38 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 11 Apr 2021 10:24:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdfKSaYIuOQF3z07vXrjwiYIAIP4tjIZQCqeVRU6xCahmbUt6HWYrHEq8uL3gaGp9pS8auoWBI/g24UQJEAv8haFxZGspr9K7otogOT/TZ/Wpx7rKGshEjPJXZD5V2uz4ADodThib0nUQB1/iyhxcpgTCqwF0JMoTQ91j/nlLokUCljfdfFI/pEoSIeocaO0RzKcHO+Cm5a6TxLywOHdRERmyyZgMbmiDjQVlcJGsaOKff2T5qphHvicOJcMr5pw2Eu5DbRXOjceUS4thMR0iSebl9cGXAK0wMIl9ECO23TkAWM1/qHiomvm4pnwa5jrgYi73y/EaYG0ynGSjseIug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRxH6dDSPZ5//2UCsgq2fi4semI/DgtTSWdOkgKUJqU=;
 b=O359Pb1MbWTblAAtxUXaLoORqYlGP6BYKdOv8XTgytvNvWm929rhJozwiCgu64s7EZWG+hd+9Bhq6PfNUEfQIm+Gk5ingGZJ8Ra7L+P6cC3EN3T7fObxvhAiIr9nsGz13eYZY7mJj6fIjSLW4ExRoKGEGwq+yIGY8tKbmOPYuhJsdVWxWykRT+x9rfZ/ncXc/i5FNTppU8x+2473ZMdJv++T+RT+IKLJyxdmtJj8gwO+LUCR1x9T67wZaxqsgY1g5Kj9L1OFNKqdardadT1dbtFC9QKanus9i0EfhPn5Zbwh1ZASreCDPqSyCFkjNvc8PUiui980KDL2SwQMSizJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2126.namprd15.prod.outlook.com (2603:10b6:805:5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Sun, 11 Apr
 2021 17:24:33 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Sun, 11 Apr 2021
 17:24:33 +0000
Subject: Re: [PATCH bpf-next 5/5] bpftool: fix a clang compilation warning
To:     <sedat.dilek@gmail.com>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>
References: <20210410164925.768741-1-yhs@fb.com>
 <20210410164951.770920-1-yhs@fb.com>
 <CA+icZUUuqNrzho6vQXNUonSuvbZbkyEx100UWzGFEzUrGzYSKg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <64c4ef87-4e03-d644-a382-4ca6f5d27509@fb.com>
Date:   Sun, 11 Apr 2021 10:24:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <CA+icZUUuqNrzho6vQXNUonSuvbZbkyEx100UWzGFEzUrGzYSKg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:ec9]
X-ClientProxiedBy: MW4PR04CA0089.namprd04.prod.outlook.com
 (2603:10b6:303:6b::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::110f] (2620:10d:c090:400::5:ec9) by MW4PR04CA0089.namprd04.prod.outlook.com (2603:10b6:303:6b::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Sun, 11 Apr 2021 17:24:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 527b0cde-809b-4fb8-9ba2-08d8fd0eabe2
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2126D81A99B53593C2C8A5EBD3719@SN6PR1501MB2126.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rjcj1sTXt4cb9plXmXeyo54X2pVMA2+ibgKNqlmcZH1hvJVdgUn2Glx+w84vOK0NxSQiD0AOpYF0Gy7kgCtL03ybUE0ZmBI/pnM+DjLReD7o7dQ4psnKIqL3Myj1kW6ZszkfWLKPyBuGX+SoG57/geKpMfiDwNKF19VyxtKtamV2zmw0PPKFx4dK6ZHqCvI3aLwb695YoYN6zmjmndpnZYQLuqMCyAlVmMJkT9N5v9Rv49IQ4imnfIOthIzghUBqyKe99fI/mCiwAdh7nMHkElhTvAlPXMoKdam76gg9QDrgRvTkFtsUXNE7SzWsTCixaEM7kBs/tPdByDHVZb6h/S7UMDnArAPB5Sy2Ku7WV8fHEouZwpD4i6soaZp0chnHFhFQZRCKSIgGLqW8fZivux5dtxoGkL8zY138r6UXmLyt9sFIjNujtHJHVSDThRVpizjgL0HTbGJiO85mRTkBg88IokAm4DfHTyGxYh/atUL8l42dr2ZcH10NUOCB6g6vPO/eqElk6JKCE9teq41sRImNTR58Ih9yh6FQ8wDEADuEJPiFNJSrcHDPK2KmcGK8oAfyedXQXd0iusUhrn5CSAJhDS3WvO8F17ecFOxMPwzbZr7cpuGROBSjKU3Ao42snlfvcWsXEJoOrNzpUiXcU1M/bU0TAhV/B3dz2EzxWW07bF2X2fiDuyXm4aJ1D/hunoN4hfXzVeEV/LHMHPeKxbd2+rojCZmpFb2gL5mBnHscC7U8JBkszua9qjJT94ko+HmI002cFZqi99sdxCyCQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(39860400002)(346002)(366004)(5660300002)(66946007)(83380400001)(2616005)(6486002)(31696002)(186003)(2906002)(6666004)(16526019)(6916009)(36756003)(52116002)(316002)(478600001)(54906003)(66476007)(31686004)(966005)(8936002)(8676002)(4326008)(38100700002)(86362001)(53546011)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UFJBM20yTlZXdm40T001T2E0dVEzUEhUM05objBUWFZSaFpuYjVqT1pBSzVq?=
 =?utf-8?B?cVpVNDFXRkJ4S1BVaHJvMjlITk8vdlpqditLVUIwbm1LRkQzSVFlSU92SGFS?=
 =?utf-8?B?MkZ1bkozWFV0K3hEOUNKVjVyZTZvUjYzTm55d1lhaUdsWmt6cWJFU09qQlE2?=
 =?utf-8?B?aW9BckVhTmR0NnJRN0l3ZVg5QmFRUmRQdFFwUWNubGVQamJqSk11ZGJGRkRP?=
 =?utf-8?B?SUlwNGFXM0pjWEtuMmVPenVPWnhGdS9oZmRGQXB6QUs2dC92UHpVSmVXOGIz?=
 =?utf-8?B?a2NkRHNNSVh4cVB1RUdyMURBbWkycFR0dXNYT1VselllcUFLTm5tVUtvOHM1?=
 =?utf-8?B?RjJEVG44ejhyS3RNNjE2ODVpbXlZb0d3TWNBSjhJRW43c3BRY1FXZTZjcjZq?=
 =?utf-8?B?VXE2ZVY4cUZ0dndXOHk1QXY1WXFFZ21DWVZBc3JoTXErMVYvUURRNVlneWdk?=
 =?utf-8?B?VFI1UWdueFN2UDhwSUNld3poQTFUbnBkcVJDMmtCNTdETlRRZitla2RpSEEy?=
 =?utf-8?B?UUxtMTZxNmdZL09acVlhU0w2aG1QK1g5VjU3bDVsVEJ2Q3IvbGFoWjFjOVFO?=
 =?utf-8?B?dWxtTXhXWFBxMzN4bG5xVEJTemwxMGJXTTZ5bE9ZZGFCeUhIMERQSVg5cGFI?=
 =?utf-8?B?cTdqTGtPS3ZxcVpEaWwxOFQvalRRR0d0d0ZraWMzTytSbkd0ZWlkK0VPMlJT?=
 =?utf-8?B?SGh4Zm5ZSm5VOVo0eEZ5TmR0WFRuaDg2aWZQV3dST3M2QkU0bW5udWVIU0hE?=
 =?utf-8?B?OEVRY3VWdVBoVmVpZkM2V0tFcXZxZVU1RUd4bFh0d0FtN0JxVldpQ0RiL295?=
 =?utf-8?B?SDBtWlFVU3IrWnM2aXh1QXkrUGNVOUU1ZHhtaUVXZWlMTzdkYW56czBFaGhw?=
 =?utf-8?B?d3czRUpWRW5Mc1RiNWd5anROUFZySVNHeXhZZ3A5eCsyTk1PZlJScnRBRndM?=
 =?utf-8?B?Y2QycFRINlVURmZ5bXVIRGdkNXhGaHJ5N3pHL1NiSUluV3laNFdWY2N3eTNS?=
 =?utf-8?B?YWhua3F5WHRyaWFhZG9sT1N0N1FNM3h0NnBBNkVvMGdoWDFKVzNJcXdiUkp0?=
 =?utf-8?B?WnF0U2Vsd2RITXREYnUrK3F0NVZtRjZIem5OaHAwTVVRY1JRNDZueUpzd3Zq?=
 =?utf-8?B?U3pzbkJ0Qm05bVh2RnJCeFhTQW1rTDg1K2hBdE1qZjU1U2VOOE56OG0wMDBj?=
 =?utf-8?B?MjhkMUlDQnlzQlVoWjEvM0RaVnBnNkQ2UGw2dFMxN3d0ZWROakJnczJxbmNW?=
 =?utf-8?B?TFdQenl2M2czbmtPYnhEQldKYm1LY1Ezd3V0MHNCNzVGNVdteTFTYjFqM3V3?=
 =?utf-8?B?R0RKSE5PbzZqeFN6eGhCcmJuZ283OCswYlFZT0tUTWxLcm9GTk93VXcvOXlR?=
 =?utf-8?B?YTU5UjR3VW8xa0FwZ3ZtQWFCc3BFajRKZTd1M2UrcFE3cGJ2NXpneDNtWDNz?=
 =?utf-8?B?SnI1dG5sS3F5bng4bzVCUWZsU3NqVFhpRXJtUmpsM2dXSzd3Q25FTXBRcG5P?=
 =?utf-8?B?YnM2TlFLanp4Q3BrRmxSZ1l5ejhpVVZEb01sak1DUHVUQU9iMHJ4ZktjemRt?=
 =?utf-8?B?N3pkdzgvYTZnRFkwLzZzUjdaOS9hOTdLTHB5Q1RDMEdVVHFnYWZkZmNoQ01h?=
 =?utf-8?B?bHQrbUhVVWJHZmNaZXhwK3h2U0F1UG0wUGN3T3Uxem1LWmRJMWJib0hiVlZQ?=
 =?utf-8?B?WFRPMmthTUpoWGdtcUdlUmVkSDNzQW92U3I2OTluaE9jb0hJVnBzWEcvZWlE?=
 =?utf-8?B?RWV5elVkNGtMVmZHZzh5bHRKNVhrZjhRSURSMTh1M01aVnoyWTE3OVZlRzhW?=
 =?utf-8?Q?g9+XxEV37FwlDGC4HPLhj7tNK/HzBVig+Ietw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 527b0cde-809b-4fb8-9ba2-08d8fd0eabe2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2021 17:24:32.9088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tuwwh1KloeuSguCYlZVCt6meGxME4h8V/oBSLNAXIpOtEayxm0JbxbvQRq7xjyZU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2126
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 5z_q69vs98QLiDtQGdtYpmgMMcXor97a
X-Proofpoint-ORIG-GUID: 5z_q69vs98QLiDtQGdtYpmgMMcXor97a
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-11_09:2021-04-09,2021-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104110136
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/11/21 4:05 AM, Sedat Dilek wrote:
> On Sat, Apr 10, 2021 at 6:49 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> With clang compiler:
>>    make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
>>    # build selftests/bpf or bpftool
>>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
>>    make -j60 -C tools/bpf/bpftool LLVM=1 LLVM_IAS=1
>> the following compilation warning showed up,
>>    net.c:160:37: warning: comparison of integers of different signs: '__u32' (aka 'unsigned int') and 'int' [-Wsign-compare]
>>                  for (nh = (struct nlmsghdr *)buf; NLMSG_OK(nh, len);
>>                                                    ^~~~~~~~~~~~~~~~~
>>    .../tools/include/uapi/linux/netlink.h:99:24: note: expanded from macro 'NLMSG_OK'
>>                             (nlh)->nlmsg_len <= (len))
>>                             ~~~~~~~~~~~~~~~~ ^   ~~~
>>
>> In this particular case, "len" is defined as "int" and (nlh)->nlmsg_len is "unsigned int".
>> The macro NLMSG_OK is defined as below in uapi/linux/netlink.h.
>>    #define NLMSG_OK(nlh,len) ((len) >= (int)sizeof(struct nlmsghdr) && \
>>                               (nlh)->nlmsg_len >= sizeof(struct nlmsghdr) && \
>>                               (nlh)->nlmsg_len <= (len))
>>
>> The clang compiler complains the comparision "(nlh)->nlmsg_len <= (len))",
>> but in bpftool/net.c, it is already ensured that "len > 0" must be true.
>> So let us add an explicit type conversion (from "int" to "unsigned int")
>> for "len" in NLMSG_OK to silence this warning.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/bpf/bpftool/net.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
>> index ff3aa0cf3997..f836d115d7d6 100644
>> --- a/tools/bpf/bpftool/net.c
>> +++ b/tools/bpf/bpftool/net.c
>> @@ -157,7 +157,7 @@ static int netlink_recv(int sock, __u32 nl_pid, __u32 seq,
>>                  if (len == 0)
>>                          break;
>>
>> -               for (nh = (struct nlmsghdr *)buf; NLMSG_OK(nh, len);
>> +               for (nh = (struct nlmsghdr *)buf; NLMSG_OK(nh, (unsigned int)len);
>>                       nh = NLMSG_NEXT(nh, len)) {
>>                          if (nh->nlmsg_pid != nl_pid) {
>>                                  ret = -LIBBPF_ERRNO__WRNGPID;
>> --
>> 2.30.2
>>
> 
> Thanks for the patch.
> 
> I remember darkly I have seen this, too.

In this particular case, through analysis, the compiler COULD decide
the comparison is okay as the range of "int" value for "len" is > 0.
But it really depends on when and how much analysis the compiler
did before issuing this particular warning. So working around at the 
source code is a better choice than silencing all similar warnings. Some
of such warnings may actually reveal a real issue.

> 
> The only warning I see remaining *here* is fixed by this patch from bpf-next:
> 
> commit 7519c387e69d367075bf493de8a9ea427c9d2a1b
> "selftests: xsk: Remove unused function"
> 
> - Sedat -
> 
> [1] https://git.kernel.org/bpf/bpf-next/c/7519c387e69d367075bf493de8a9ea427c9d2a1b
> 
