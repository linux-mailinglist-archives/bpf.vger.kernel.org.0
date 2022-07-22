Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D51D57E3FD
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 17:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbiGVP7x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 11:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiGVP7w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 11:59:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2523F328
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 08:59:51 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MBxjN2025192;
        Fri, 22 Jul 2022 08:59:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=eI+hy+40rUyhZ/TWjxXVpTBCRHe7LPRs9CgYkIOaZyQ=;
 b=fjhnT1Q54ruEoUm6bq3rh3/hDRnQysK4d/ioO1tHiJLYMMypG4Toi0cj2Fhz8Hv2Fbk+
 tsc99W4qEH+QwVRH2GThvRdSgOkz/zS6itJ5IGIJkKqm85iz5LY0phtLnwllq9hm189L
 0uUGNBQYwqkASKWjV5UHwvoJZftmAWqqEfo= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3heyc928pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 08:59:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvGDGlos2yNEIPPycsGIHZdqgvENzbddy3+GSUmjPsiagNIeq5emqGUvGSipZQMlMAvWjZE2BPhNkhBSEqmSujmPJmBicnLHUwX75XIUJroUDFeDgErPxX35m5774LtwSYuxEK/aCDAv8LF1pohN1rSIuAKH8LIyvX4JgyW6Rtwl5Rztwk1da8SUHkC5LCtGiIXv3Z+jgLghT5niIuvcOEF41JliKdGnE2KX+7JwuLyJWorZ7P/8aYKS2qMrNYnuzHdCGtKuLTuoDzaewMgHhyiWXoMLrzzhwXcBxKlFUfdKxLHgo296QGFgxoLee4KkfOMCuwVdcHSzPEplESMI1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eI+hy+40rUyhZ/TWjxXVpTBCRHe7LPRs9CgYkIOaZyQ=;
 b=aYKk4zzYiEbJfEZUSbrB86j4PG2iucqiBexhyHSUP1zQRxS2D+J2iRHYF7pYMDnQM44e2rl8bPBMfqTr+F+8AY6vjygg+6/DkqGWmlKnX2onSBdm7DqabUA/1yQ/W6zferqEPudrdDThm1MKn6TB3Qwkph3+q8GBjxDLWXpPzaKtRuE+P2tQ/PoAkHMNK3iPHvRg7CfT0vZboq5fUQKMAg5qkm2UYJVzPO5ZpDOzBscsN8KMVHCiUCwqwtrR8Cnh41SpgCETsUOvCVjvwZi47ttErn6Y8whirNerfvBK7dLns6wYSwO0H2dUQiWBzQvazq33gbME7j3W4gzYwIVjNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by BN7PR15MB2305.namprd15.prod.outlook.com (2603:10b6:406:91::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 15:59:44 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::acda:cdec:5c2f:af77]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::acda:cdec:5c2f:af77%7]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 15:59:44 +0000
Message-ID: <b152c348-d524-a94e-b5a2-1f3086749967@fb.com>
Date:   Fri, 22 Jul 2022 08:59:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: Signedness of char in BTF
Content-Language: en-US
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     Lorenz Bauer <oss@lmb.io>, andrii@kernel.org, bpf@vger.kernel.org,
        david.faust@oracle.com
References: <3fcf2cb7-8d27-4649-b943-7c58e838664a@www.fastmail.com>
 <87wnc6bjny.fsf@oracle.com> <e636b480-8d53-a628-bacf-bac2b1506a47@fb.com>
 <875yjqayyz.fsf@oracle.com> <d56865b1-30dd-8761-2c12-ae5f66778de1@fb.com>
 <8735et8k42.fsf@oracle.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <8735et8k42.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0363.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::8) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90d702ed-49a7-41e4-4103-08da6bfb319e
X-MS-TrafficTypeDiagnostic: BN7PR15MB2305:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D51TGm4/+0RW1Yref6C90HKrEl+Qd4riZaSVtoLiPLsOD2XpUwDEzlAh37fTtjERlx/S1x0T7+gsEGmS739Ssi4ufdZs77Mopu95D9cWi0BG31bYuChWUMgcPyZsKamJ6tXAvDTBUTijWKGEgHJjmBKYw1XwCjTQJDeBxdKZDWYbwaaUUb2WTlW/b7k2clNW7ZSnXOLZX/Whq5FWZQRv5AxlRNPX+CEDZf8YVjUrMs7IA2H2NQPwHRNUoSV4s8Me3T1AUAJ3MLUtsd1IcanDFeGysATP1IS/9m33QLae+Rr4HMr+F4eFHOwLcxjWFj1i7VGEkDryA5bfhEmeClmqNUEb95ZM9ca71xr1GlATQEDT5zriNEINM/EdcF5BG7myBHX4t23Cuu1VDW6RvZnBMilPGTBLECag/+PQvtzZDJjNr+BdvvaoBB0lWwJxgPHF52BL7pofN9XYEysIhDD0N3D6iCIN12oFURVRHNlIfH6/XNVrfBq7IAj7XJ6JXRrCJuwCqFWQ106xtSTJgL6ZA1S2fFjQEPVIQXrM0Y9Exp+h3dRdN8R3EzeKr8k4IBTbF7xYQCNh8Y+fT0cvOtK8qNRn+4tF0rYw2Lc++n3TDsGOaCkVShaw8HD6QxOMy3663zFdF7pyt0QkHPdv/fApIMuihiLee5Pc/25VQmN999N6yUmwIBTBDMncVVhBF+bUmucjgtJ3o4HP3u8StuN3RSiXhkevz0rdflOvywByX35xjpy6I/v6/DFVJpiH++AtwCPudmSRUlIsNrokVqDBGbuVsNa1k3JxD4AjP0avvPwd8vHbWJBrR0Vdqeb0Ax+kbd8+a8ita31zOZT0ygE4xl4ENSqcFB9Jd4olS5VZhUY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(36756003)(31696002)(86362001)(6506007)(8936002)(5660300002)(2616005)(31686004)(53546011)(186003)(6512007)(6666004)(38100700002)(478600001)(41300700001)(316002)(6916009)(66476007)(8676002)(66556008)(4326008)(4744005)(66946007)(966005)(6486002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkkvRDQyUXJ5MlZlaStsdDBBWmNIQUd1Tzhmc3pNTTVER3VYeWtYYkoweHhG?=
 =?utf-8?B?QVNmeVJZakRBWFd6SWRNM0sxejd6U0NsS3R2ODdJam03ZVdDNDNoUXNSa2Rw?=
 =?utf-8?B?dWRKd1dKaDFmeEU4bmVUSm5BK1FkaVpDTU1NN0M5NStvdVR3MGlrYXpxeW9F?=
 =?utf-8?B?TEsvaTRiMnJ6cEt3MW91clNqRko4MFdWY051MkZEZ2tkWStaTVJpVjhrdTJJ?=
 =?utf-8?B?aEp5b1lpcGl5QmZKN0Q1WUppd3FlUWZKU1MxNjdBdFhibWE4YlpvcC81YTVo?=
 =?utf-8?B?ZHFvMEVSZXJnb3V6NUN0Z1l0WmUrWU51ZmZ3Rjg0b3Z6eVZnT1lPSVhYeE43?=
 =?utf-8?B?R2hFcnE5VEM4dmVITTE5cE9paVllME1FTzlUVE9MdkNTWnZISUpGRnJnUDBZ?=
 =?utf-8?B?Z0FLM3VISTdaQUQvSzJ0WWtta1k5MWM1VzVKUEt4eHhnckZWcUcvQW9rbTlN?=
 =?utf-8?B?VE55WEpTTVdDTkxtMnN2NFBTUldWTEpEYy8zNDVpb09SVDVwMnBJakJUd25m?=
 =?utf-8?B?YTRGbnlqZmxiV2JleHVjUFRJNW53M0J5a0oydVUxZWFLaHMxWjhrRHBTQmJW?=
 =?utf-8?B?T1pabHJvQ29KYnNIOTU1M3FFQk5nSTZORXF3NnIzbzUraE1IcVA3eFlSREpZ?=
 =?utf-8?B?WThVVTRZeFZYRDJyR3lXNlJiUkRtUWg2RER1ZjB1d05zZWY1SEdxRjlOZFJJ?=
 =?utf-8?B?RDJVa1RTRS9WMDdFUWxYN3JnVFlhZFBJTkhLL25RVWJwcEZkUE5BcW5FZkxQ?=
 =?utf-8?B?WWNWMGhQN1o4RnErNSswUXVuMEpBYmxpbW1PS1ZmSE84WkRSVWR4dXJINXlG?=
 =?utf-8?B?RWQ2TkE3d1J6cVczWGhiMVdFNHhkQjdzckJSOGZ2U0dvaTJuVk9NSW4zRVFT?=
 =?utf-8?B?SWRpbFpEL29MTHgrTGE5WW9qRUNlb1dscSsrUGtGZHNjaURGaWtkcFpaV1J5?=
 =?utf-8?B?SWVNWXoxVWhOb0p3aXNaWUNZNzJzNkFDS3lJY2hTdU9yQTVJd04vd0JSTUNr?=
 =?utf-8?B?WmlIZ1lnT0F4SCsydzYyYlNrNTM3SDgrb29OUnBQVHhjQ3E5aUR5OG9BL3li?=
 =?utf-8?B?VlRMaXVubENyS3hNZnh4K0tucWNlc1ZQemthSzluRGIrcWRxRTNaZ3B3NDZw?=
 =?utf-8?B?bjdvTG5GVVBOTG5hVDV2WTlvKzQ2bTd6SC9QUVRDM2tpYkVoSkpFMjlOMlRm?=
 =?utf-8?B?cGQ3cFVkNkl3cTlYcUM2YUdEMW9QbEVXSFQvbzEva1ZWT2lPOWhlemh3a3hY?=
 =?utf-8?B?c2tQejNVNG55WEQ4dTJreldCZmloZXFFNU5UcElpdkhWc1ZHbW9GT3h6aDJR?=
 =?utf-8?B?UnVEN1R1U1NOb2Q4OVRWMjF2MzJVT3pxV0lqTStKRXZqVW9LRlZibW9WTlZR?=
 =?utf-8?B?QlBHZExqelk3Q0I5MzFYMmNJK0RmamlROUtLeHJickhUNC9DNXkxQ3NBcjhi?=
 =?utf-8?B?SWtWR0dpUnMwV3VzVHhxc29RdGExUVVaMWVoVjZ0V2kxN1NsNkJMMHZMeFAr?=
 =?utf-8?B?ZDI2cHVoN25HMUhVOThBQVpibXdRbkFoeXJFZGZNSnRwb2dnVThwbDVtSkxs?=
 =?utf-8?B?eExQUjdkdjE4ZHNTaHVvU3loKzRiTHNHT1dOalBJYys1L2hkb2F0UVNQcWVa?=
 =?utf-8?B?b2JLaW02empGcTl4eDhVTmpPL3ZRM20yVGx2eDI5ZUVCV3BuSi9iYXhtQXd3?=
 =?utf-8?B?QzZXTVZyMCs5RXpoYVJVQm05bStDRHE4bXpWY0Y2MXhsT1pYTGZJVHZTdzJx?=
 =?utf-8?B?QTh0L2ZYenFGYlRwYlczT0EzbUc0UlZhOTVKVjI4cjFvV29ydHVtOW1wL3FN?=
 =?utf-8?B?SlZ3Z1RnN2ZmR0pRUk50V2lkNnZMeGRMWnZnOUJPemVncHQ0VnIySU9BL3Vr?=
 =?utf-8?B?QXBCR3dyZ2tGV1psdHpXOXhpMVpOUFlNZ1A3NlJNUFZFaHJPc0E4TzczRm1Z?=
 =?utf-8?B?L1BqTFFKUTZ3Mm9IKzMrSHNTUStnSFlzVS9hOXVUQlhLbk9zbXQvaWFYTVU1?=
 =?utf-8?B?RC91em80UloyS0t2WXQ5aGhEdFplWkVHeFJKL0lwNVlvOExZMGRLR2NqNlYx?=
 =?utf-8?B?bjdYOHZ6cUV4K2prY1BsbytTRjJpQytlWld3TlhSWGVtYlI5eFFOZ0xCSFRP?=
 =?utf-8?Q?B50MD/HCREwFbOB5PSflFtNTh?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d702ed-49a7-41e4-4103-08da6bfb319e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 15:59:44.3045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YhqGHKONEX2NAPVz6V+KVbxNQ3Upq8U6yLDogWPo7gqQrPODP1ipAqpsudljNpF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2305
X-Proofpoint-GUID: WC0zK35NPR6FsP2mR6Jd3pKzNlqJBDT-
X-Proofpoint-ORIG-GUID: WC0zK35NPR6FsP2mR6Jd3pKzNlqJBDT-
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/22/22 4:25 AM, Jose E. Marchesi wrote:
> 
>> The llvm and pahole generate BTF_INT_BOOL when the dwarf type has
>> attribute DW_ATE_boolean.
>> But BTF_INT_BOOL is actually used in libbpf to differentiate
>> configuration values (CONFIG_* = 'y' vs. CONFIG_* = <value>)
>>
>> In llvm,
>>    uint8_t BTFEncoding;
>>    switch (Encoding) {
>>    case dwarf::DW_ATE_boolean:
>>      BTFEncoding = BTF::INT_BOOL;
>>      break;
>>    case dwarf::DW_ATE_signed:
>>    case dwarf::DW_ATE_signed_char:
>>      BTFEncoding = BTF::INT_SIGNED;
>>      break;
>>    case dwarf::DW_ATE_unsigned:
>>    case dwarf::DW_ATE_unsigned_char:
>>      BTFEncoding = 0;
>>      break;
>>    default:
>>      llvm_unreachable("Unknown BTFTypeInt Encoding");
>>    }
> 
> I just sent a patch to make GCC behave the same way:
> https://gcc.gnu.org/pipermail/gcc-patches/2022-July/598702.html

Sounds good. Thanks!
