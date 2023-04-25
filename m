Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6466EDB6D
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 07:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjDYF6p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 01:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjDYF6n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 01:58:43 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524F1AF18;
        Mon, 24 Apr 2023 22:58:41 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OMIR1U002087;
        Mon, 24 Apr 2023 22:58:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=dhlCV2xKD+QNNwz5g01nfZu+1hud5PTjfXv0YscC4Zo=;
 b=iUF52myNTNXntHgEv0r2Kjh7uC+Lj2aVrFt9P9tOm3cOCYQzuuIZ8muKUnNpiW2Gpay/
 DJXypOO0zU8IcABzf3EfoWgWUreZLzbxmUl6OI25nVKPnnJWV5RAOLzpACPrMcGab1gx
 RXb9qkQ3PF3BkJ3Gfk7CBUf3dKsrHtXB4WhbjPjmF04SXzEQlucqCDfbUewx0Ur3KPmM
 NXsNr+DArlhVeWjEwN+bz3RGPxebfXyuKWTs6OcxjjO//sw0LmHgNBe+PfXEhgAjzZjF
 GqXZhYCHmbR7+KPJTdPPP3AOUEIAbXtb9bCntSNhOThqqmmDTGaaCF5I5Rp9JF8Ssapx jw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q62ekj0q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 22:58:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOOkXgNMBUZ6ZwbKhlrmhIWpKNnP4vLE/ID2cVXJ3i2fZ6Od7SDingQuUBfRxhZdB/pQ9YXGT5sRUxp4ahktXlaA7pDN24l+XxDWysBh9sNiYWdgFW63U9N0pvOC/UHofq+gNcMeKEvW/c7syCceazaXfO3VovXcm5LOrx1D89GgBrTSdyhEQwZjjU2/U3Bs8zKtJQsFEWEOsjaKBChlPKyWQQzAox6VLF08npRYPeuR1snw3nye2WcyH3YPFjeGVyzMD0i0cxHJ1pWzGrVlBAs3NNr7wQz0X9TpqFnEOlkqIKKDm3smXLaTPoeayulHLAIRclEG1PcFpmE/XYVo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhlCV2xKD+QNNwz5g01nfZu+1hud5PTjfXv0YscC4Zo=;
 b=IREiNsBV6r2jqlpLLE5e+A6PWxaR0YgOiSimBTEgf1pIBzo+irgnZH6kzaPZkh+KRuPrqPWB4vQnX7hlN5JJzpauCnigpNjLdxr6tinx6Rn4apblrePKW0F71WjPIEeaJoEPQ7amcCme3uPGYhk7l9vDV34dUNB3D5l4XDMjwGqyOwnyicU2wPWCItpX83pixks2V7s7foWW5k7NJoV6CBOMFw9z+FQbR+IdMeheRJfoZyaNVAWD/g1TIud/4fsM1HugtRXCySW9LUaubB3Hs666Ts0nHWhIxfw+D2REUnok1YCTv0wZtl09ElHpNxPXV5rcn+y4IAcrvuP3qg3VCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3776.namprd15.prod.outlook.com (2603:10b6:806:87::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 05:58:14 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 05:58:14 +0000
Message-ID: <561b0f03-4a3a-89d3-5793-a0d69535ca0f@meta.com>
Date:   Mon, 24 Apr 2023 22:58:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next v2] bpftool: Dump map id instead of value for
 map_of_maps types
Content-Language: en-US
To:     Xueming Feng <kuro@kuroa.me>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, quentin@isovalent.com, sdf@google.com,
        song@kernel.org, yhs@fb.com
References: <8b893118-6687-1d2b-d838-1a0c6ff7d886@meta.com>
 <20230425041050.59727-1-kuro@kuroa.me>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230425041050.59727-1-kuro@kuroa.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA0PR15MB3776:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f61d17b-d808-4df0-60a4-08db45520ec0
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SxhE+gcdh9O61V7ut77HRWjyCCFT3rSB/J9jU1bMPK1BfCw0ZCtx5IzbWZySII0A/6PoO/0F9OG0zdTprBb/r8pvW6/KnmcOQzzk/wTnMfogsN7pe+HS0APbZu3AWxARQEO++IPX5A5m+ihHwNbFuK5sGWaexzlFnJJGpNISq2DkBfkEs7ojUfuu0SwUiMqTw7X1AyzKP2nR1F/BhQ44VMukofoP4O0NU6333n5/I31umrFVwEq3QkSk6rmkNDZJNx7cb+kHYX3w8XjuOV/n3Spbo4D23IJnbRH5ZKoll7c/siOoWtFaYCT8u5HR18A6cR2JjoRCAWBV25dbCMuQKh2AM9mZS5vE2xvBVXbMrXy6yu7Fhbaqon2GDsh1tRnUNem1efFKL3lZa7tDSjpfSeXIT1URscbHcw/9tJNk/Hp5rSDdxRSnq9zYVJq+vu7pDTP8FvQhW9IXhTTWB+RaUDkoB6aUQTXv2hCd/+SoO71s2TAcEK2N0ezIPFWQR1/glBOokff+hDXM+X6l5qtfeAazWqSbysdgpHnHocDGcyw0K8mV9v8wZFD1XMVThqbtwR80JNVrDt3j8Mfowp23uAzUtojyS8loZ9mSlfhzGqqZdQMhP1ZPw/R+BmYr3IWLjMhvE95eriznQIgDuqmdJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(478600001)(31696002)(86362001)(36756003)(186003)(53546011)(6486002)(6512007)(6506007)(4326008)(6916009)(66476007)(66556008)(316002)(6666004)(66946007)(83380400001)(2906002)(38100700002)(8676002)(41300700001)(31686004)(5660300002)(8936002)(7416002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clJIdndMTmc2SlVFWGFPcFVVQUV4QlNMSkNOWklpSFVZYTVMd3lmTnJPU2xv?=
 =?utf-8?B?U0MzenZ2R2prMFJuQzhlY1FIUkpEckNzZXhPcmM0OGxVbXRWSU40NHUybm9U?=
 =?utf-8?B?U3cxVFRpWEt0KzFLdm9ETVlZSHEwZG5LeUtJUHJpUnEvOVlHalNXZEhvSmZ4?=
 =?utf-8?B?ajY5UjBsWWMyc3UvL3BwQTVaKzU2MExpRUI0YjIwREVaRHoxblBlOG9Ydmgr?=
 =?utf-8?B?VldTa3MvKzJKSnhwNFdwcmhuTkFKdnhra1R0b1F1UW9valpaS1hFQllnZU43?=
 =?utf-8?B?dW1GaHNqNWR3OW9pbysxNEM4Wm1DWVJkRnJRWkpzenVWamNFa0dlTFhVZlVx?=
 =?utf-8?B?aUtDNjlDb2FCbG50K0tqSWxtbm93cllxSkNGQi9UU1NZb2lVdFRKcU5MYnNw?=
 =?utf-8?B?cDZiS2RPLzNvZ1hZRkRJUzQ4a0NpQjBNdllGWkhFNWhKRDJFOUNwQTk2UXJw?=
 =?utf-8?B?STNvdkRBV25tenIvT2FZclBLMmt2OTA2WFZ1WnAybXNMcm1tY3RUeWdYU2Y4?=
 =?utf-8?B?TUJoVHNNZEN6WWo1WUdoYkxYWTc1YUk1clZrTTNUMEFXczlNVDhyTldBa3hY?=
 =?utf-8?B?SjI4NkhuLzJEVmFYeDNQam8wSTBZYUl6WUlmdFZKdndQd0dSWjI1N00zZ2Vo?=
 =?utf-8?B?ZGNoTmprcnZTdGNuTWlURndIMHp2Z1diZmptRlUrK3cvRFdjRU1rQWNuREpJ?=
 =?utf-8?B?MEh1bzh4Z2g2OE1iQlA1NWJaN2s3TmY5U0JWYmpiUCtnVzBaZWcvSFdUQ2Uy?=
 =?utf-8?B?N2ZwOWdreVdHd2VtU3RiMndwb0o1UW9FQkpaUWFDNUNJa2IyallkVW14Vzlw?=
 =?utf-8?B?bG9Sdml1bzR2WU9sYURpdGpPQUtPaHF3Qjh1S2ZOSnZpRmJFdlhzU1c4c01k?=
 =?utf-8?B?Rk0wa3pxbEFEc3NrSUUxdklBQVNOMytiWk40Rmxsc3RxNHgvbkUvanB3NmhL?=
 =?utf-8?B?YVBRbzIyVktyYW1DTG0za1hQdG1TdjNjN1VSWWZqb29oaUtFanlWanMydXpD?=
 =?utf-8?B?dVlmVWlpc2FDT0w4MGE0d0NyYkVPd1pHV0ZQZnRRcDBqbXNrRUxNOGxqbzI3?=
 =?utf-8?B?Q3laY0tUSnBBUFhUQ3dyS1FMaWZ4SjIycDQ0NUo0U3V2ay90eUVSTEYxekpK?=
 =?utf-8?B?VHF0b3oyQXNHdnpCNGZycGVQUXhFNzVKNWV3N054Y2dpeU1RM2dKb0lDUjBQ?=
 =?utf-8?B?eUJtc05Ua0VPQUpWZmdLNGlkVFVXV2RqWGYyRmpOUXRBcmRUZmRXUUVTbXZT?=
 =?utf-8?B?Ty81NERPMXJpc3FIbnJaR2JyNFArcXNRcU51NmtzQUFsT0dSWnZaY0JKUm9h?=
 =?utf-8?B?WERoVVZyQlkrVTNQQisrK1hmS3NZMVZWVWRvRnBOTlZ0bDJGdUJveWNBZ25v?=
 =?utf-8?B?cUhabVUyNmV5QmNobTZTR3FJSE5ZUEtKb005d1luQkVOMjBKenBLQVNMaVZ2?=
 =?utf-8?B?K0ZuUUxVb0dueEpxRFpYWHRRSFBnTnpYVWkzVWk0N2VKYVIyUnptTlFybkFI?=
 =?utf-8?B?NUlFQlBsN21iN2x1aWlscXdJTnQrNmFPWVlWeTMwNW12MithLzNiekxWdkMr?=
 =?utf-8?B?SDZONXdMNFVjVzE3UFVUYkREK21aK2h6Q2ppQVYwaEdqTXlPMExaZThscFQ4?=
 =?utf-8?B?am5ad0ZBS2dGenYzY0RuRGNPd3pMOGtyRDhhQ2c3LzliKzBXVkFmaXBkK3Nq?=
 =?utf-8?B?MnJmc2xUMi9yVms2MTQ2eUtOVTdQTUNDSk1rMnRJVGFQdzJRazJyd0c5eHRk?=
 =?utf-8?B?Tjc2R3hZaHk4Q1VnWjhZb1EwaUpMMDNMNVpXK3JsRllqdEEwTjllditIVmVz?=
 =?utf-8?B?Qk4ybnpOWGVYb1E1VnpDU2x3RVB5S2FHQ1BiaVdpMTFiWll0cGREVDZpUU9N?=
 =?utf-8?B?UVk5SW9TNDVST3dZQ3lVMGVsSTQ5UDFHL3Q1dms1UktBTmhLMG5nSk84WUtm?=
 =?utf-8?B?OFJlbGV5YnIvazRmRWZEVmVMeEtqdjhReE5mU3kremZJTEd1cHFEQmViQXpp?=
 =?utf-8?B?S1NKTGZMODlBUTZJSzBVVkIraUJwVnkvMzYzTzZlRkpXR1N1dGZ0WmZsSTlH?=
 =?utf-8?B?Q2xPNjlWQ25XUTRZcnJwMkZHS0oxTVRoK04wbXR3alJ5VG9WWVhrMHMycm1I?=
 =?utf-8?B?NWFneGFnYXo5UkY4cnN3eGF1c0c0YjQ4LzUwTWtQcWdrM3MrQ2szMDFhalRZ?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f61d17b-d808-4df0-60a4-08db45520ec0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 05:58:14.1873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M556T9XFJo89C0CDR1LHn1QbhA2lm1XHjHROCY5mibqW1fhyhDoHnMaKPENy7FzQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3776
X-Proofpoint-GUID: 3JRpIOdqKPWbZTXsK1zmEXA9fBpNbkOU
X-Proofpoint-ORIG-GUID: 3JRpIOdqKPWbZTXsK1zmEXA9fBpNbkOU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_03,2023-04-21_01,2023-02-09_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/24/23 9:10 PM, Xueming Feng wrote:
>> On 4/24/23 2:09 AM, Xueming Feng wrote:
>>> When using `bpftool map dump` in plain format, it is usually
>>> more convenient to show the inner map id instead of raw value.
>>> Changing this behavior would help with quick debugging with
>>> `bpftool`, without disrupting scripted behavior. Since user
>>> could dump the inner map with id, and need to convert value.
>>>
>>> Signed-off-by: Xueming Feng <kuro@kuroa.me>
>>> ---
>>> Changes in v2:
>>>     - Fix commit message grammar.
>>> 	- Change `print_uint` to only print to stdout, make `arg` const, and rename
>>> 	  `n` to `arg_size`.
>>>     - Make `print_uint` able to take any size of argument up to `unsigned long`,
>>> 		and print it as unsigned decimal.
>>>
>>> Thanks for the review and suggestions! I have changed my patch accordingly.
>>> There is a possibility that `arg_size` is larger than `unsigned long`,
>>> but previous review suggested that it should be up to the caller function to
>>> set `arg_size` correctly. So I didn't add check for that, should I?
>>>
>>>    tools/bpf/bpftool/main.c | 15 +++++++++++++++
>>>    tools/bpf/bpftool/main.h |  1 +
>>>    tools/bpf/bpftool/map.c  |  9 +++++++--
>>>    3 files changed, 23 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
>>> index 08d0ac543c67..810c0dc10ecb 100644
>>> --- a/tools/bpf/bpftool/main.c
>>> +++ b/tools/bpf/bpftool/main.c
>>> @@ -251,6 +251,21 @@ int detect_common_prefix(const char *arg, ...)
>>>    	return 0;
>>>    }
>>>    
>>> +void print_uint(const void *arg, unsigned int arg_size)
>>> +{
>>> +	const unsigned char *data = arg;
>>> +	unsigned long val = 0ul;
>>> +
>>> +	#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>>> +		memcpy(&val, data, arg_size);
>>> +	#else
>>> +		memcpy((unsigned char *)&val + sizeof(val) - arg_size,
>>> +		       data, arg_size);
>>> +	#endif
>>> +
>>> +	fprintf(stdout, "%lu", val);
>>> +}
>>> +
>>>    void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep)
>>>    {
>>>    	unsigned char *data = arg;
>>> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
>>> index 0ef373cef4c7..0de671423431 100644
>>> --- a/tools/bpf/bpftool/main.h
>>> +++ b/tools/bpf/bpftool/main.h
>>> @@ -90,6 +90,7 @@ void __printf(1, 2) p_info(const char *fmt, ...);
>>>    
>>>    bool is_prefix(const char *pfx, const char *str);
>>>    int detect_common_prefix(const char *arg, ...);
>>> +void print_uint(const void *arg, unsigned int arg_size);
>>>    void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep);
>>>    void usage(void) __noreturn;
>>>    
>>> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
>>> index aaeb8939e137..f5be4c0564cf 100644
>>> --- a/tools/bpf/bpftool/map.c
>>> +++ b/tools/bpf/bpftool/map.c
>>> @@ -259,8 +259,13 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
>>>    		}
>>>    
>>>    		if (info->value_size) {
>>> -			printf("value:%c", break_names ? '\n' : ' ');
>>> -			fprint_hex(stdout, value, info->value_size, " ");
>>> +			if (map_is_map_of_maps(info->type)) {
>>> +				printf("id:%c", break_names ? '\n' : ' ');
>> 1> +				print_uint(value, info->value_size);
> 
> On Mon, 24 Apr 2023 18:07:27 -0700, Yonghong Song wrote:
>> For all map_in_map types, the inner map value size is 32bit int which
>> represents a fd (for map creation) and a id (for map info), e.g., in
>> show_prog_maps() in prog.c. So maybe we can simplify the code as below:
>> 	printf("id: %u", *(unsigned int *)value);
> 
> That is true, maybe the "id" could also be changed to "map_id" to follow the
> convention. Do you think that `print_uint` could be useful in the future?
> If that is the case, should I keep using it here as an example usage, and to
> avoid dead code? Or should I just remove it?

Maybe, "inner_map_id" is a better choice. For array of maps, some array 
element value could be 0, implying "inner_map_id 0", but I think it is
okay, people should know a real inner_map_id (or any map_id) should 
never be 0.

Function "print_uint" is not needed any more. Please remove it.

Please add the command line to dump map values triggering the above 
change, also the actual dumps with and without this patch.

> 
>>> +			} else {
>>> +				printf("value:%c", break_names ? '\n' : ' ');
>>> +				fprint_hex(stdout, value, info->value_size, " ");
>>> +			}
>>>    		}
>>>    
>>>    		printf("\n");
