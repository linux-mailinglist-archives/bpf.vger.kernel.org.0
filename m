Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9283757D717
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 00:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiGUWww (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 18:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiGUWww (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 18:52:52 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC892A265
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 15:52:50 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LJkeXL022636;
        Thu, 21 Jul 2022 15:52:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=NCKxU3H3vE4mDmhYNzYRWOEeqAidSXBT+z0dpcQpk+M=;
 b=kGV/Qar0gtP8fQyR3ttzFhVZ18zZ0kqVSBZwSD6Ed1b9LXuuPJ0i2jeZcbwFZuiXTweB
 kRZCIP3uQjoAB10ScZB53P4z9X6BhGUCf9mG7knD+moqYPNMrjKBZ/dsyEJEBC3JqcBX
 9FP6Vj07mCaYJCVRkdbjSpFfj/xY8EfLzgs= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hf7fbur9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 15:52:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJjaUHyCD64hrdomesVLh8cfq9J1t8BPPDDY/tt5OQcZdFrtd2c/1GMklY/E2ZDSXiGg+Hdx82Nm5S9CkBXqK7QDcfSNVMyq9Pe4xkNDi0WYaHfg24fvS+z2FzOploktoxqqfWe4XHs91EgSG1hFkcnowO8FaKo8HHdEVJASr1NTO3P5Y466VFKM1rY135fIgsQAfDJDEtMwhWJqXy0yHqf5N5UFEkNz7MfAxjf0pEeKJzd9d14fohyH+0Iul5ETuYV3NeOL+sKssRWioBAYcEYEH6SyPuOO/SImofZustrwGqgK5taoz2886sMx4EykhTHmoRzdcr5zIdR1F4iZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADaNnfiy4pXYOyr08T0EbtFMX1LwBqhi8ORqqyRrC8k=;
 b=YiUlhDy+n/sUurYtCPdHuRP8EKoPMK5Z8CMfSbLSwInLvqyznqbgkraWpPwPyGMD+kvRaXfZuIZZnU0Ja0ppUVyL6iD7+tagH7I/lKcAej0DC95Yt0tHYufrYZjMzOooTAtPoXklcoD8z9b/fBVTWtnWeOEqpSqzW6v0fqHtcW2a56UuUwyUtavvqIx7YdB8yNtatN/DE7OQdVNZMvPTol+unbKS6QTZK5EgQmZ7ted/82jiZue97CBopzbbl1+B4fsylnxXP6wRXdrUXzpzlD5qzJPrxO6jQNYen7rVK/9BhPo6/aqaOE98iPogw2e6amtYF5PkqEbQEWzkjkQb/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB5293.namprd15.prod.outlook.com (2603:10b6:510:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 22:52:43 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 22:52:43 +0000
Message-ID: <d56865b1-30dd-8761-2c12-ae5f66778de1@fb.com>
Date:   Thu, 21 Jul 2022 15:52:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: Signedness of char in BTF
Content-Language: en-US
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     Lorenz Bauer <oss@lmb.io>, andrii@kernel.org, bpf@vger.kernel.org,
        david.faust@oracle.com
References: <3fcf2cb7-8d27-4649-b943-7c58e838664a@www.fastmail.com>
 <87wnc6bjny.fsf@oracle.com> <e636b480-8d53-a628-bacf-bac2b1506a47@fb.com>
 <875yjqayyz.fsf@oracle.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <875yjqayyz.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::36) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aba1af41-0fd4-4051-2819-08da6b6bb898
X-MS-TrafficTypeDiagnostic: PH0PR15MB5293:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: peVYLmxCA1vTWkHhW86Jyuq5osNUb8yuZ9pYfylHt5bNbgkRcSXTQTw3URM20Mc6xx4wGBWFaZbD2NvEUefdMSACfyEHL38VdaNJKrVlH86loan1KMVAztobPn1A5Chra+Z8guQ6L6Al0VcuNpZemf9EAB6OP09mqxVs7e58NOBeRAWbJcOqnPNkF61V3iRmhLwcQ6W9cELUDnVuy62uc7GsqeOR1/OoknM5TQKpbWR3JgTOAcdPIViRRP4ndCTz4MbqmYoi7LYqfw/0AvsLogUYU8mEQnYHdH8RaZZCirzWynARPbBIn7x00LZakO30L4b5un/fA3JyEkN3bYkyuN0O9SM/lvQNaEgQSUaGieDs6Od5yTabPfG1rF+BviVOZFmUlkmlvk03Y67RD63dJEabRVPMRxK4Z7iYK/ozieXPUOlvAuHYNUiwVehj4S4RU5j2DTo3e8tAGMhTy/pUBhwAcUhNAPtTT69QWsDHFaw2jXw7plIW6Y2I+NU8rdhs6jp2aRCQrip0uu711C8d07L6T6a7ncz3eCna06CUXW/gxG8YJHgBbFvDAqTNu2doRwlzPBOPry55xbPaDg4+/ZjUdMyqgj/2acNzdR8XMZ64OfYtH3UvF17Ow6VNQwu9YwN0Gyl4ff3XcD6syFCymKjjege5Mw/UcuB/HfU2ghBIBTS5w0ddCcj9GPfFeK2eZELrCDnutosk330ppOX7seyZrVwsKvwRYciJZ3d6hR1pyORRVCMvVnD3mdZzbcOCCp/mfHSxLBiKUvmf5BFWqovsc6RP1ugF1HjwEpejeSkDvec3rOUBrUNTrQEXhH14WK7+PmkytzxL2OKBcGu+b5/GYSpqnnzh3W+1o6hwgQOcO8V5pglMz5pwxVlsOSg6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(316002)(36756003)(53546011)(31686004)(5660300002)(38100700002)(6916009)(41300700001)(2906002)(186003)(966005)(4326008)(86362001)(6512007)(66556008)(8676002)(66476007)(6486002)(478600001)(6506007)(8936002)(2616005)(31696002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czVoZ2F2SzVmMWxxL0JoMWp3UWgvVkhXMlJpeWUxY25zK29sNm8yM1lxWkVU?=
 =?utf-8?B?YmlMYmtubXYybHl4UzNQVXRiaHdkSFU1NXpkREtRUmYzSENEVWdnanRkcHpP?=
 =?utf-8?B?KzhZaGFBM3A0UWNyTzZpWEZBcW1sZ0prQVdYaVR4bCswY3NPY0NRYS9RVG9p?=
 =?utf-8?B?OGZCTS9xYjY4bitIN05TVmFGRUhQb2ZHNzZKZXNMV3BYS0JZTWE2UkducSt6?=
 =?utf-8?B?bzJ0bXplWC9yRHd3Z3M4UVI4VFZ0Z2UycDhHN0VaUXRVaUdSREt3SXNZbHA1?=
 =?utf-8?B?V056NzNRS1l6czVnck5MWlhuZDJmMzd2RXBjNVRIcEwybkxvSDZ2TFprV1dV?=
 =?utf-8?B?V3pKTHE0Q3o4UWNMQ2xnaldaMHlrQ2MvYmJmaWNkV3R3dVk2aUx5MzBFTGE4?=
 =?utf-8?B?RWtMRHdxZlEweHIrZHdpMjZqWHVnbUlqSVIrYUVkbkJzajR6MmhwMGxzTksr?=
 =?utf-8?B?NFlncjh4V1RFZ01ORTkxRkZiL29heUQyNStNOE1jb084NmhIYlN4Rk1ldVhp?=
 =?utf-8?B?ckg0YStwMEtSMFlwRnNzWG05SURCMnhvZWJlRGc1WkU4dFJLekp1RXBHRnJC?=
 =?utf-8?B?c2ZjbGZSOWljdmY4U2VtaXl2NzIzU3dKd2h2Rk1lbmxuc2ppSjQrRUhGRzZJ?=
 =?utf-8?B?dTNFQVJvL01FZU8vNzZ1aVZVSUJjZGVmaW1iNis5VHdoeHdjeEFBSFBhOWlm?=
 =?utf-8?B?VTE1L2QzWTd6a3ZzYlVzYllsOVVEWTQvdnlYVzVTWmtmem13U3h2TmV5SVFt?=
 =?utf-8?B?M2xVY05zVGx0Ym9Zdzl4YkJrTjNnZlhCcHgzM2Q1SlhZNWFWc3F2NFliN3pV?=
 =?utf-8?B?aENIaXljbGpjSzZ0UHZSY2RnMTFnZjFDVmhsL25xN2FxRlFnT1ptcG1oenY2?=
 =?utf-8?B?SU1jQnQwMXhsVHZubmxMK25aSE5yRGpxYklzdkVWMHhxeFMzUW1nWkdKT29X?=
 =?utf-8?B?Ni90NVY0MGRaWHR0QU5hTkl4L3h3enpvZUM1ekZPZGNGWkIwZU82S3lEeGFT?=
 =?utf-8?B?cnFucHE2d2VNeWN0U0lJVXJvN0hrQlF0Z2hZWUd5YjZQN1JWY3grT3BrN000?=
 =?utf-8?B?b1U3V2dqWkRyQnhiOXA0RGo2dVVPcmE0bFhYVzBSOXBMR283KzBXSlRwemZ5?=
 =?utf-8?B?TXRLRlpuSzJLVUZoY0FYb2xMeDYvTDJsRmxMVWZONzBqdTlpN2pJMXUzRjVB?=
 =?utf-8?B?SHFlS3RzOHBtblJkMXF4elpzYWJHYmdQbGtNNWpucHhxcEZ0a21nYVV2SUlZ?=
 =?utf-8?B?Wi9tYk9hN1E5K2ROZWppL0FiRWlkNVhldGhRT2lDTWhuckFLczFHQXVYcEpl?=
 =?utf-8?B?UXYyaGhDMXI5MklsY1ZzMXF3ejlSRlNRTlpBanRxK3Q0L0s5blIraHYxbi80?=
 =?utf-8?B?d05tOFZWRG1wSWlERVhRTWE2bnY3VmRiUE9zc0xnQXczTFpnd1BuQTAxcUtk?=
 =?utf-8?B?RDU0bGFXRHYvKy82K0xJUHc4bGpPWlRxcisxbmI0ZXRxQ3hIc2VVMi90RS82?=
 =?utf-8?B?MzkwVVVHOHk5aElmZDJ5N1VHWWlXaDlFeEoxL2N2eHh0U2FhcnFoSXJzZG9p?=
 =?utf-8?B?MDNRL21yV01DR1JOY3RCWk5tTFpQTXkxSTIwZVZ0bllLSVJxTEEyNEhxUVpR?=
 =?utf-8?B?d2REbktHOXE1YVRzMHcraDhwd2NjM0pBaTNWUktNR1A3ajF0dk10T0JhNFp2?=
 =?utf-8?B?cGo2a2F3bjJ0Sk4rNDhqN0lSMzZOQzFMYUZKc0lhRE1MMDc2dWFpaGRaU09h?=
 =?utf-8?B?UWpjdit4WG94YS93T1I5OWNNdXlrYlNnZi9JU2J1L2RqNlhnWXRmZlArVEQ1?=
 =?utf-8?B?OTJhWGxHUTNzbHVDc1R4NmowWEhlWGJzajJkcUpWTE5SajRNSmVXRit2UEI5?=
 =?utf-8?B?Ni9VLzJwcHA5eXVUOFp3SDlMK2RXTnVTZXJiNmVQRVNkY21kYWhTSVJaajVk?=
 =?utf-8?B?SXF1cU5Ib0Vsc2tkN3ZaRjNTUE1Qb0RmeThwTWNIYnRiM1pBZ2RDNnlmOE9Z?=
 =?utf-8?B?aEk4SjJoeDB5KzR3aDNSalBmYkNxZk1XMld5Q2syb0RmU050bXh6TWcyR0sv?=
 =?utf-8?B?aUR5Y2JRaEF6cy9vVW5OVk9CL0Vqb3BxZ0l2WU9nOHZ1akkvMDUrYTg3d2Ew?=
 =?utf-8?B?QU1PRmo4QWhiQkZveFBwRjdKTjNnQzUwcWdGeGhmV1hRNDdJNEFMeEYzSE5J?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba1af41-0fd4-4051-2819-08da6b6bb898
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 22:52:43.0248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFH7x5Wim8IOL1thEso1v0YbCd1KCv8uSZySIGJNxw1h42GGJEOSNEZjwP25EW+m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5293
X-Proofpoint-GUID: iNH-lsC8ETgCqykP3GGUfz8_DOwiKYFD
X-Proofpoint-ORIG-GUID: iNH-lsC8ETgCqykP3GGUfz8_DOwiKYFD
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_28,2022-07-21_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/21/22 3:21 PM, Jose E. Marchesi wrote:
> 
> Hi Yonghong.
> 
>> On 7/21/22 7:54 AM, Jose E. Marchesi wrote:
>>>
>>>> Hi Yonghong and Andrii,
>>>>
>>>> I have some questions re: signedness of chars in BTF. According to [1]
>>>> BTF_INT_ENCODING() may be one of SIGNED, CHAR or BOOL.
>>> I have always assumed that the bits in `encoding' are non-exclusive
>>> i.e. it is a bitmap, not an enumerated.
>>
>> Based on current BTF design, it is enumerated. So signed char
>> is 'signed 1-byte int', unsigned char is 'unsigned 1-byte int'
>> and 'char' could be BTF_INT_CHAR but since in debuginfo
>> any 'char' has a signedness bit, so it is folded into
>> 'signed 1-byte int' or 'unsigned 1-byte int'.
> 
> Ok, we will change GCC so it does the same thing.
> 
> What about BOOL?  I don't think we ever use that bit.  Does LLVM
> generate it for any case?

The llvm and pahole generate BTF_INT_BOOL when the dwarf type has
attribute DW_ATE_boolean.
But BTF_INT_BOOL is actually used in libbpf to differentiate
configuration values (CONFIG_* = 'y' vs. CONFIG_* = <value>)

In llvm,
   uint8_t BTFEncoding;
   switch (Encoding) {
   case dwarf::DW_ATE_boolean:
     BTFEncoding = BTF::INT_BOOL;
     break;
   case dwarf::DW_ATE_signed:
   case dwarf::DW_ATE_signed_char:
     BTFEncoding = BTF::INT_SIGNED;
     break;
   case dwarf::DW_ATE_unsigned:
   case dwarf::DW_ATE_unsigned_char:
     BTFEncoding = 0;
     break;
   default:
     llvm_unreachable("Unknown BTFTypeInt Encoding");
   }

For a concrete example,

[$ ~/tmp1] cat t.c
int test(_Bool g) {
    return g;
}
[$ ~/tmp1] clang -target bpf -O2 -g -c t.c
[$ ~/tmp1] bpftool btf dump file t.o
[1] INT '_Bool' size=1 bits_offset=0 nr_bits=8 encoding=BOOL
[2] FUNC_PROTO '(anon)' ret_type_id=3 vlen=1
         'g' type_id=1
[3] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[4] FUNC 'test' type_id=2 linkage=global
[$ ~/tmp1]

> 
>>>> If I read [2] correctly the signedness of char is implementation
>>>> defined. Does this mean that I need to know which implementation
>>>> generated the BTF to interpret CHAR correctly?
>>>>
>>>> Somewhat related, how to I make clang emit BTF_INT_CHAR in the first
>>>> place? I've tried with clang-14, but only ever get
>>>>
>>>>       [6] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=(none)
>>>>       [6] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
>>> Hm, in GCC we currently generate:
>>> [1] int 'unsigned char'(0x00000001U#B) size=0x00000001U#B
>>> offset=0x00UB#b bits=0x08UB#b CHAR
>>> [2] int 'char'(0x00000001U#B) size=0x00000001U#B offset=0x00UB#b bits=0x08UB#b SIGNED CHAR
>>> Which turns out is not correct?
>>> We used a signed type for `char' because that was what the LLVM BPF
>>> toolchain uses, but then we assumed we had to emit the CHAR bit as
>>> well... wrong assumption apparently (I just tried with clang 15 and it
>>> doesn't set the CHAR bits for neither `char' nor `unsigned char').
>>> But then what is the CHAR bit for?
>>
>> This is not generated by llvm or pahole but apparently it may still
>> have some meaning when printing the value, a 'char c' may have
>> a dump like 'c' instead of '0x63'. In kernel/bpf/btf.c, we have
>>
>>                  /*
>>                   * BTF_INT_CHAR encoding never seems to be set for
>>                   * char arrays, so if size is 1 and element is
>>                   * printable as a char, we'll do that.
>>                   */
>>                  if (elem_size == 1)
>>                          encoding = BTF_INT_CHAR;
>>
>>>
>>>> The kernel seems to agree that CHAR isn't a thing [3].
>>>>
>>>> Thanks!
>>>> Lorenz
>>>>
>>>> 1: https://www.kernel.org/doc/html/latest/bpf/btf.html#btf-kind-int
>>>> 2: https://stackoverflow.com/a/2054941/19544965
>>>> 3:
>>>> https://sourcegraph.com/github.com/torvalds/linux@353f7988dd8413c47718f7ca79c030b6fb62cfe5/-/blob/kernel/bpf/btf.c?L2928-2934
