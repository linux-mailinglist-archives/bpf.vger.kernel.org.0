Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4A66F0D8B
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 23:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344027AbjD0VDh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 17:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjD0VDf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 17:03:35 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF9A1FF3
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 14:03:34 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 33RIPpbN008023;
        Thu, 27 Apr 2023 14:03:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=EJ9MCDWgMSymFiQrcXyG2Sli71T8eDUqhdfvfYsKqj8=;
 b=h7KlSgk1w2bClvyO7v1Cw3UNqz2xKJJ/1uksVYmG6XgDxdq8kYkhubGE2RDgED3bE9s2
 QQ4WUarAl+k950l7KjIrM5mqnUW6No2kxoKatN4F+CUSPjNfsX3V0E1DokhVxpkPzUCP
 jww7vFH6KBS6bMCcMZ0lX91A70ISh5KQxizGovwawfMR8D2w7cx7MTgThOchJ50P8Xzm
 3mbFIkvwtSYm3UKr5O1U1JJONoW8O8qfe6m+6mcLsqmfECNRESZwl75mto0u5MV06WWh
 46pcGaHT9j70ZWbsQF+6ZiZh3wg/o+SEW6dz6qqVtvs50v/pJRljiM++8r/a/8ZJkojz 4w== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by m0089730.ppops.net (PPS) with ESMTPS id 3q7utb2mg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 14:03:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ssc/qT3fb53X+31Hr1ilbhfWaP/90gKkvMEgNritY+XEKtXRf9L3UHtw//+K2fWGlyCt/hPaoXSrfQQwCcJhTAStmt1SlP7KGK904D5GPuYdnVrsONEfimZVXZtXRDBE7JRFrTo/KqzH4CNENtlh0NpvzugE/ZHt4Tck0PNHCmjnwsltOlq3GZoSgVkwWmOyGAtXxPNXw1gaUYih5/ER4zpfFXIgGVxSRp42ouGdDbw8jaA+pLyi9N6lj5gjXISP+aPcvo6oOYe9U0Jgk9nTGhlar5QQuubxOHjZSNkXJ3RGDmd4IZIfCnkxCK657G4AYmTXLN1g54oOiiE9ZB3DBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1USl9XnctX2TJABx/H+050af1RSAHjNe6loNbOixyI=;
 b=E6J4gKiuGWD2KTwwWc2CMsPB/0HkN8X+kBfKO10kSjtbXvQMIkrtbmqm9+XOaSLS//onk1KKp00bN1A7NXQdS7DIPf0AK7ZaLbFCz9+Iph/ssl4WcrJW0Pzo2xvIMeJDro6wgSytg+vmt/LeFhAEoMTDTFolME/5YBrdpougQlDTdDXqs0YaVfddolQNCFVwrYnU/sGQ/neMqlrDsDW76o1vetsB2CUaY5EeUE5ec7TS2Rwv6VbLa/5Y9bVLWWynM7SLjiU6ozu94HYstk7c2aaLrQRREQXFr8bZPm+ZdHKBgNHZ6UntZdGIPFjLdf0HE+ePAnBmDR4NDbaciN+nqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DS0PR15MB6093.namprd15.prod.outlook.com (2603:10b6:8:12c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Thu, 27 Apr
 2023 21:03:17 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 21:03:17 +0000
Message-ID: <47b33bed-40ed-a051-e66b-178f1bfb95ac@meta.com>
Date:   Thu, 27 Apr 2023 14:03:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix selftest
 test_global_funcs/global_func1 failure with latest clang
Content-Language: en-US
To:     Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20230425174744.1758515-1-yhs@fb.com>
 <e6b0a452-3f5e-2eea-51cb-484b342361c0@iogearbox.net>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <e6b0a452-3f5e-2eea-51cb-484b342361c0@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DS0PR15MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d155238-1461-4e9d-ac06-08db4762d2ad
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KysTpWbtqUTjfjv4dOPb19mBsCepouRZ6z4Q6e4VfVMDTxSLJJi1tGeMD4EYRvWyfd7pDt3Qu7fp6OafejDdfimLObg/EOCz6Sc4s3xpu0OpTgPA7fMXIuRFiM7rUv7YNTHEnFvLsvaVB+Ena7wFGyWLDGOPutO61/yYOTi7cNwL24x2lDwRCiQ7a1oTEfH0SMcewj2wFKkTczxuSHSOMXjYTFxHtQMN8LISfzVv3+UVdafHfFI1pqQcFQMeBmTSv11CWWVBxE5dkMw/BB7ckVE/8gDxm+RglTeQavTkqU2gAGaz7rQLZwAcjXU+uxp1uh3nFe9oMrgPBiUk18FzhgpYcFh/qdAxilG5Er+DZb7zLjAuXf+gbgjPQmvBaVPbBtwpxIjcFITOjb7OWIsl4gHI0IJUj29hKIphSIFrBVuNmGXiSPtzm6uP8qDQD5XfxwOxWASt0Pyef+5EoxUcdBO/coy3JrQt7CKZGhYB/FAYdIhNqXdbtcrAZROOCjdkbIchJnWTBxQqoSyfSRg8w2XgmD51sW3KmoPytC+EnFmKDl5pArEqbPR1lxKSBPFFNd7gzY+37t7a9sVMJlOJIYUQbjJjVJCwvSUdbPNm8NSPyT/HtkQLtWzSd4/X1ZTgX2kh4ehho3WkvrEsSVXLkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(66476007)(83380400001)(110136005)(6486002)(2616005)(478600001)(186003)(6666004)(6506007)(966005)(54906003)(6512007)(53546011)(31696002)(5660300002)(8676002)(36756003)(41300700001)(2906002)(66946007)(38100700002)(66556008)(4326008)(316002)(8936002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDdVLzVlRlJlUlhvZTQ0M1pGRElmeU5Rd2wzUWtONENOSmo1VjdhM29BRlZZ?=
 =?utf-8?B?TlJGR2R3cWVsMGtQd3hRTXVGYkFJeWRwUENyNFRWTG1CZktlL1VLbEM5ekZo?=
 =?utf-8?B?eTVuV3ZiWTZVdEI3M2NWM1dYd3lYbnZSTkVNamlmdzBielZSQjNEUlZiR09W?=
 =?utf-8?B?V2hUSUdEZk1zRyt0SmVwZ3c1Z1pSdHNwd1c5QzdvLzg0VUptV2RHRHJDY1N2?=
 =?utf-8?B?TzhWZ2pOV3EvOW1HV1lnWGkvZVRXMG05dEpNSm1xaFpVdHlqN21ITjFHWlB1?=
 =?utf-8?B?Tm1TRzNQZUpXd0E1Z0IvNW5nd1pYMjN3Um1ZOHRiTC81Ris5dDBtUWVxR1hX?=
 =?utf-8?B?SGwwa3h4K1Vxc3k5TjY3NEpVQkIzaFI1bDBUbkJ2cDhvaUZGbW9kcFFTcDRL?=
 =?utf-8?B?QXJPMFhpYUN2U2hIakZpYVg1Mlp6MllFR2ljNDcwY1NaK2llZVRyU240YTRU?=
 =?utf-8?B?K1E4WTdPZGdaMzhKZzVMbjlyMGFvVXNZZnFlaHVUdzhVS0pqNmYwVEZRYjRl?=
 =?utf-8?B?VVNrRHF5RE1RUEZubWFDRlpHek81OWRWR3FWTEtPNy92RkFFcDgrNGhCN3dS?=
 =?utf-8?B?dHVSN0RoblNmZVQrMTZ3UFBpRVF0YlVndDVsZTM5MGltZEJmbktzRzZFaHBo?=
 =?utf-8?B?em9QK25aWkR4bHNMODE2ckFBT3NzaTJROTAyTVl1TUltdXQ1QVkrcVA1SDZS?=
 =?utf-8?B?a21XUE5QOFJOOFB6VnhlUmlmNXZXMmhWN3p4cm56NXduVW9CTXRBRmRyNGhw?=
 =?utf-8?B?ZFlDMitTYlhBb2QvZ1VjKzJSMWtNSTMzS0JIazFENFZ2V1lBMWRGMjlxdDRN?=
 =?utf-8?B?ZW9qK1Q3SWNsUEJNNUpDaWlPK2drT3o5N0Z4U1BEVXRHWHNEd29aUFRrWkNz?=
 =?utf-8?B?enhNTHlERExVdGtlVlBvcnVHOXBHekJHeGthdENZZ1hyR3l5OWFlRGcrUDI1?=
 =?utf-8?B?K3VEeDExcWhWNWR0VHFoUXdpcHk1TUFtWEFhcXArVUZxMGZHY1oxVFZwOExV?=
 =?utf-8?B?YVRiUExHd0RNaGRTVUJKSG50RlJUUGl0WGJmK2Z2ei9tbzRFTURsRUpIZkdS?=
 =?utf-8?B?VmJyN0svY0lNdnYwdEY2dHlrTDdFSi9xZGRRWHB3OHhYNENkWitwVytkTFFX?=
 =?utf-8?B?K1YyMTJYb2s0NS93Mm5MRk9LY2todWRkNU43VTJYbmkrZjV2aEhYTFNoeXBo?=
 =?utf-8?B?TmRHSFNBZkRLbW4vaWdVMEZPM0V6anlIM3VtYWNsMDRUUWdOZXhDenVKVWFO?=
 =?utf-8?B?N05vQ0k1YW0xczdIckhDTDdGVFh5VENSVGRTZWx0SkhOaW9VUTNpUU41SjN6?=
 =?utf-8?B?UGxQWG9UdmI1NkQ5VUpNNlVma3c1MUI1dnNIZXhEcHNhWkxkUU90QWZtQytF?=
 =?utf-8?B?bWRqV2F3dVZiSVYwS3gvelpaaUI2U3dhVEZlcGtOcG9hNmpHcVF4LzBhcWhP?=
 =?utf-8?B?WE51MHFKNGxHTGlPa29QNG8wcnpWa2hnMmtjZzRSZEdwcSsyYytma0k3UC9V?=
 =?utf-8?B?NmxwTEZLSnBkSEp2OURiWHFHYVFpSEEzU2MrTzF4ZFEwRVpnUjRDenZHb0Nr?=
 =?utf-8?B?RGx0WGw5Z3VtTHRKQXJEN0wxSVBpcVRiK2NTelNNbEl4UzBYZmd2emtXM0V5?=
 =?utf-8?B?aGFIdHFTaDc5N3hCaHJ6Y3dKMXVVbnFNM2pSdlRSc25CRVpkcTc3VHBuZVBw?=
 =?utf-8?B?WjZCVmtkdXJMY1ExeWtac0JTdll6eEVDV2VrdmFNS2hVazNQZWVaRTZMNVEz?=
 =?utf-8?B?Tllib1R2SjVlRit6dW91TFhJNlNlWHA0YVVWVjZ1K3RNaW1TOVVyL09tOWVC?=
 =?utf-8?B?bGhWZmhmZ01GMmpxWWdoYnVMR0V2SVFZQVUvNStjM3BqMjBndWJ1dkUrT1V2?=
 =?utf-8?B?dmlzc3h0SGpNeFltQTRBNStsajFteE83M21lR2lEbnd6aXgvOEd4OTg3cUJG?=
 =?utf-8?B?UzVHbTFMS3NYREZUVFRKUWRPN053WmFVNkY5QnRvKzZJREhqYXFVSFhIUGg1?=
 =?utf-8?B?NGUyN2hYUmF3bGtQZ1F3VnRqaGM0aXZ2NjJpT055a1dnOFI3eWkyRC9MS0Jr?=
 =?utf-8?B?blQrQlU5SmxjNXI2SWxzNWJpaXRZVW1qaC9qKzU2VzJ4bWZzdnl2aUcwZjdW?=
 =?utf-8?B?RGxVbVZnNTl5a0Rhemd5RG5BZFI1QWdoMG1UUTNTT2pBMmNjMklqUXc4Yjll?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d155238-1461-4e9d-ac06-08db4762d2ad
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 21:03:17.1535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXqfH++xrxVGVWcNllJ1mhmB1m1+8MewRHpLh7WzjblVScBQrqt+xcxDvNmFMmy+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6093
X-Proofpoint-GUID: fkMJTY6UcwtFrnQUNumT_SB0Fbcx_Ee1
X-Proofpoint-ORIG-GUID: fkMJTY6UcwtFrnQUNumT_SB0Fbcx_Ee1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_09,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/27/23 1:23 PM, Daniel Borkmann wrote:
> On 4/25/23 7:47 PM, Yonghong Song wrote:
>> The selftest test_global_funcs/global_func1 failed with the latest 
>> clang17.
>> The reason is due to upstream ArgumentPromotionPass ([1]),
>> which may manipulate static function parameters and cause inlining
>> although the funciton is marked as noinline.
>>
>> The original code:
>>    static __attribute__ ((noinline))
>>    int f0(int var, struct __sk_buff *skb)
>>    {
>>          return skb->len;
>>    }
>>
>>    __attribute__ ((noinline))
>>    int f1(struct __sk_buff *skb)
>>    {
>>     ...
>>          return f0(0, skb) + skb->len;
>>    }
>>
>>    ...
>>
>>    SEC("tc")
>>    __failure __msg("combined stack size of 4 calls is 544")
>>    int global_func1(struct __sk_buff *skb)
>>    {
>>          return f0(1, skb) + f1(skb) + f2(2, skb) + f3(3, skb, 4);
>>    }
>>
>> After ArgumentPromotionPass, the code is translated to
>>    static __attribute__ ((noinline))
>>    int f0(int var, int skb_len)
>>    {
>>          return skb_len;
>>    }
>>
>>    __attribute__ ((noinline))
>>    int f1(struct __sk_buff *skb)
>>    {
>>     ...
>>          return f0(0, skb->len) + skb->len;
>>    }
>>
>>    ...
>>
>>    SEC("tc")
>>    __failure __msg("combined stack size of 4 calls is 544")
>>    int global_func1(struct __sk_buff *skb)
>>    {
>>          return f0(1, skb->len) + f1(skb) + f2(2, skb) + f3(3, skb, 4);
>>    }
>>
>> And later llvm InstCombine phase recognized that f0()
>> simplify returns the value of the second argument and removed f0()
>> completely and the final code looks like:
>>    __attribute__ ((noinline))
>>    int f1(struct __sk_buff *skb)
>>    {
>>     ...
>>          return skb->len + skb->len;
>>    }
>>
>>    ...
>>
>>    SEC("tc")
>>    __failure __msg("combined stack size of 4 calls is 544")
>>    int global_func1(struct __sk_buff *skb)
>>    {
>>          return skb->len + f1(skb) + f2(2, skb) + f3(3, skb, 4);
>>    }
>>
>> If f0() is not inlined, the verification will fail with stack size
>> 544 for a particular callchain. With f0() inlined, the maximum
>> stack size is 512 which is in the limit.
>>
>> Let us add a `asm volatile ("")` in f0() to prevent ArgumentPromotionPass
>> from hoisting the code to its caller, and this fixed the test failure.
>>
>>    [1] 
>> https://reviews.llvm.org/D148269
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/testing/selftests/bpf/progs/test_global_func1.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/test_global_func1.c 
>> b/tools/testing/selftests/bpf/progs/test_global_func1.c
>> index b85fc8c423ba..17a9f59bf5f3 100644
>> --- a/tools/testing/selftests/bpf/progs/test_global_func1.c
>> +++ b/tools/testing/selftests/bpf/progs/test_global_func1.c
>> @@ -10,6 +10,8 @@
>>   static __attribute__ ((noinline))
>>   int f0(int var, struct __sk_buff *skb)
>>   {
>> +    asm volatile ("");
>> +
>>       return skb->len;
> 
> Is it planned to get this reverted before the final llvm/clang 17 is
> officially released (you mentioned the TTI hook in [1])?

No. This fix will not be reverted even with final clang17.

The TTI hook I am used (https://reviews.llvm.org/D148551) is
to prevent the optimization from increasing the number of parameter
beyond 5. In this particular case, the number of arguments
remains at 2, so BPF backend TTI hook has no effect.

> 
> Thanks,
> Daniel
