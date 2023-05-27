Return-Path: <bpf+bounces-1357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFE471372F
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 01:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59E81C2094F
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 23:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395E21990B;
	Sat, 27 May 2023 23:44:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D81182B8
	for <bpf@vger.kernel.org>; Sat, 27 May 2023 23:44:09 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7201C9
	for <bpf@vger.kernel.org>; Sat, 27 May 2023 16:44:07 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34RK2llr030469;
	Sat, 27 May 2023 16:43:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=nYsak0MfEWHB683/HCLd/b9mcA149s67cjU+mmcqxh0=;
 b=Hu3iXIhJY+Y0GtzRmv/wNQCPkAaNurRFzXV4tGMrFdLBioiocCckoocSV5ieyhZxcPv5
 afevZlEw9Bro817TAf/pxufjWFxlmHunjIhA1UlpG6VF6/V98IzGx8DLugeq2PhSEBmf
 WZt8rZbWz/W50OgVOMwa6V9kbnI1abGQdymoHWfaA4VTvXruIOaBj2r+4ORhwHmx/UkD
 CsR7bIy+OXk4hv7KYZGoo9R1FCrXvCn18hFj1q+UsS8hjctYa0E3mdwl7lzG/lLNlupU
 k4bvMSWAlMj2F4BQD4lTiqUwUOsNvcxjYeiH85XXlIu4T9gRS/5ZzZP8EnkpiOc33cvv Fg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3queywjyqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 May 2023 16:43:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SD0c/7yZjf8toxdgiGJ1BTR3bRhLEUsA1jXpRJPcsxA1AUEF5jaSLuy7g/DX+PTDTOyBaY492Rzh+u5G4mOPHCbLWgs/lMtLLwzXYFpwrCoTSq3saAXoaMB7IuOsx5Aow7UXr2mgJ8dy8MHaeaCT63TGL1lbsuXKp15L9+4mXeyxQ/mLuGQwhVigi6e1ZiI7TQ/553u87CriWxyLIArxYalIflUpG09JuuZewTJ7lSQYfXYb5Gg64QKsAmwq60zlsVzn+BTF+FyrQVjAlWkr3LAIIUy1f6cGJR5veL3mlXd2IFoYJH3J0LSQH57UqYLSBl+Wx6brTPZzm9TCBP7FhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYsak0MfEWHB683/HCLd/b9mcA149s67cjU+mmcqxh0=;
 b=csUzHNp8pPtgv5Wz2RN0RZnrbXHUzmcZ4K+ZgNgdvabvaMXWMd2zy4r4gNNZs212FGbwmyy7e+x7JHAYZIom8/PDeY2PqZFDp71DbVaA1bPckVi0MbAVPWikWho7Gi9scLDk/1BVf816UH7Gr+Ak/ApMuQacO28IK1BtbxHbbE/vY+ordtp5LIYlcwUq2QPPROyMMTBhW8DLmrB48Wdr0lUnGDycHECyOz1MgBEoHJU0j6HB5aZXW9q0yjqsKENAl0sVLVpsGPZohYYNnne1RZJP7lLS+eaeT791JLWn9W4EATbDDXusZ84kIjyf7lQgAUa1HjJI5N97GUsAr0LVHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW5PR15MB5266.namprd15.prod.outlook.com (2603:10b6:303:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Sat, 27 May
 2023 23:43:46 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0%6]) with mapi id 15.20.6433.020; Sat, 27 May 2023
 23:43:45 +0000
Message-ID: <9fe005ca-ee56-f852-33fe-24381da8bc04@meta.com>
Date: Sat, 27 May 2023 16:43:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH bpf-next v1 1/2] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com
References: <20230526184126.3104040-1-eddyz87@gmail.com>
 <20230526184126.3104040-2-eddyz87@gmail.com>
 <ecc663f1-d8c1-0ccd-a226-00888aeee83b@meta.com>
 <0900f41a57683ce0f55ee46435bf393f36ea24cd.camel@gmail.com>
 <eef495be92934cab0b6ee60a71a22a9b755d1777.camel@gmail.com>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <eef495be92934cab0b6ee60a71a22a9b755d1777.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW5PR15MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f3b094e-e90d-476f-4671-08db5f0c35d2
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ct2nyiGN78eqEc8FQtPi8KmQgzHLu9bnCmZ5NZmw8n23eyyNVZTx+oPBmPwe6y4JjBPvki8YZO3nOaDBex8UqLurwrEQ8KZfV8AddNMiT9Ys+dTr2t/905S7h6aU2yw3xkan35xhc8T6yu3St3tAKmSiHoV6239CfuHU+vQ5Mxf0lCQZtUdJRLVzH7FYenRz8Dc4P/vfAF+P5tMh78dVrZLYR41uLV7m8QshN24H2dv2jeUo27Y4PDQybkpv4F3iwhZ6C1YtbFjp/yCXuKKnj5fGL5B57nzPefJ7YTHf70RcL0zzp1y9XgHngBFO2jb1P72j1cb78AT50ZouVTnNTUUT4TkycxWqcS+/q7vSh32NfL6gZ+wa8eCuyrH9JlGeMxknB4aMo9BaFNP5xFz0BMfU+jCAfde82WvyoU3GyyvGv3aJl2z5S2xdfBs++UJhIyyrA6ac7q6uV6adFN/dZlq5i11IGmsAHPCJf+vOOAaqfhOLaZCEwjMmQyDskm/yq59xQszkGMmUfafBxDQU4xiz0OLZuDm43cLLzfUsEurtnkH+wn2/S8kg7T5IKVUFZ+rQpNG+vmbofVtRpV3q8rnMpBX5fr84yVrDWQgitGtaXHkEhaRdoU3y5DdI0JVswouYfIvpaMNWq3pMa8Z7yA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199021)(2906002)(4326008)(66946007)(66476007)(66556008)(15650500001)(31686004)(5660300002)(41300700001)(316002)(8936002)(8676002)(6666004)(478600001)(6486002)(186003)(36756003)(53546011)(2616005)(83380400001)(6506007)(86362001)(6512007)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZXhOS2p1WnAwK1Y1L09ySUhUbnBUN2hJRGg1QTJSWTU4L2Q2TDViaEJrNG44?=
 =?utf-8?B?bEFEbzljV3hEbTlGNlAwSmZoTklFeEMzcjRFcEdMSEdDNVRockpjTU5oQ3JH?=
 =?utf-8?B?amhUTGFBYnVzR2w4Zk80cUlFM1htclZKSE1xdC94N01JZlhtaFhQQ0hTSC9T?=
 =?utf-8?B?aWZkZFRKNEVOdlRnbkFncE9zYjZDWTNkVjZXN1hQTzI3a2drK2pEK0MrTVZQ?=
 =?utf-8?B?NmQwMm5ZRXd6M3FWZmk5NXNuUUJWT2U1Zk16U0d2aGtKSWhjaldUU0Z5MTds?=
 =?utf-8?B?TVhWWC9KMzhCK0k1czkzT29ZK3Y3VjRPNysrOVltSEcrKzZyb0U0S0x5d1BK?=
 =?utf-8?B?UlYyRHZhQStHUXRjVHNzNzJiUmtIODNpdzVvRkM3U241UTR6U0Vwais5SFBO?=
 =?utf-8?B?VHFMMDdVUzlhbm1CMnIyNHQzL2Q4WTNIcUxnRno2WElHdmdrQkNVUUcwNjRJ?=
 =?utf-8?B?MmdHM0lmWEpXeDVnbFJTRld6c1Q3ZmxUdFVzM2lQR29WUE1LT2lNZS9tVks2?=
 =?utf-8?B?SjNzR2pHeUFTTVBRQUd6RUNwOW9yYllPY3RMN2JNS0FRRURSL1lUWC9tZWJS?=
 =?utf-8?B?RmVhYkxFRzNtUE1JQnozTXBTalJteWxiUlgvQXBVajlJWUZuT01vaWFOZkZO?=
 =?utf-8?B?Vmd1dWhlTkc5elpEUlM2Y2k2ckltZ25mQTFPTjdRb2dZT2JINVVtNXpBbGdM?=
 =?utf-8?B?V3JSeDBoUkNoNXZ3MmZ5Z0tzbEVyN3NqOVJZS2twbjltNGpuVVViTEVlN2lp?=
 =?utf-8?B?TTBLN1hqRGhPeENsNkxEU2U3VnpEZUlFQXNPdlByczJ2WE92UlphV0YvRGhO?=
 =?utf-8?B?eFBEM3ZaNTdNd0w5RythR3I0SVFMa05FeTNFaW1Vck55a0xXT3Z0ZVlRWkFz?=
 =?utf-8?B?T29yT1dWTUNrM3Bsc2NTUjM4UGxyNFdobTZUV1U1eXVIaVBFQnlKdkNleXRy?=
 =?utf-8?B?UG5WZ2RlbmN5ak03dGtFMDBkZEpRTVhJU3UydnY3NEVQcUxETVU4QWxCWUlZ?=
 =?utf-8?B?THQ0QU5hQ3RLbWx0VVlObWx0bHFDeEpCcFNNRkNWSEF3eENQMFJUV0t4dXB3?=
 =?utf-8?B?T3p2VytzZEJEek1oTHoxak9PN0VrZCtDaTRxNm9SeG90SzloejR4TEt2YnE0?=
 =?utf-8?B?Y2FXQWI0MmZaM21YVWp6czk3ZldxQXowWjVCc3o2Qi9iZkhZOVJvVWxIa2l5?=
 =?utf-8?B?TXVMWGVEdTFIMytpdHJTN2V1cWNUWG5pNmpUNnY1OWRCS1A5WWhpUDNtYW9V?=
 =?utf-8?B?eGJsNDFyNUtubEZ0OWFmQUFlNkJLTlYrdEVWQVpPS1NGY3ZYa0I1YzM2cmVy?=
 =?utf-8?B?SnVSUzFlcW5kYUx3WnQwUk9HVnN0QzMwbFY5Zmg4OHVtR1ZYVFQ1elNOQ2x3?=
 =?utf-8?B?d29HYTZUZFNxZlJpSEc4b2lTSjYyWFBpWEtTS0wrUlpZYU1aZExLK0VGZUdk?=
 =?utf-8?B?dUZoYTl3empyYzJlSjF6NEppZzhmcHA1VFFOYUg1VXkrU1RNaEpJMXZqMnZp?=
 =?utf-8?B?TXhyeVNYa1BFcjBkZ2FHK1ZBWUt6RG11c2RuaG5udDc0YURIOVJZMHhlNS91?=
 =?utf-8?B?bk43Y0tKbjR6bXFsTit1c1lyMGJzVUl1Znp5OFBzNHNVNkt1YnRkMDlpSzJG?=
 =?utf-8?B?V3k5K0NyMjQ4ZlpsNy81Q1g0ME8ra1Y2SjBxNER1RXBSaG9XdGFEWEhnb3hU?=
 =?utf-8?B?VTVZVXFZcnRHMlVqd1crSDBrNU9UWWdTTGFGNWpDRStBWk5Rc2FIMmRLTG4x?=
 =?utf-8?B?TWVtZEpicVpsRWNIenRTZDFLc1ZlSHh0aDlKU0R2bWd2a2s2a0ZPTTNPOFVN?=
 =?utf-8?B?bVpYUWdHcEFGclpKRlFYZnpYUXZwUzNiOTNncy9sVmYzZjlKZEZLSkdRTmYr?=
 =?utf-8?B?bjhvQnlMalBUMUc0YlNMNG80LzlTcjg4WjJjU3hLZnFSbVJsT1djaTRCYko5?=
 =?utf-8?B?K3UySlFjdVJsaGNmUmVhQ0ZxdlV3elQwUjlPS09qZERnSVVvYVRQMSt1T25G?=
 =?utf-8?B?VnUyWVZKSzFkTjVIQTlBRnhrSlZzZU54LzY0aFRlMXcvTTh0V3RVOU5wWWJv?=
 =?utf-8?B?aFE3KzArM0ZqM1FZT2ZrVXdUQXhOeVV0MnNZakVqUmFFcHlTZTROQW9qTlBh?=
 =?utf-8?B?TTZCQndXcDMrVzZXRlRUMzlselFYa0duNkNIQS9mZkR6YUR0OWNpUG52TDda?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3b094e-e90d-476f-4671-08db5f0c35d2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 23:43:45.2940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsmSI0vjmo11rDyZSX2PmLtJgUNJT/gGRaPIt2DnTt4gs5k8xasWQZsMrCV00j/Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5266
X-Proofpoint-ORIG-GUID: ag6k5zHPDxLgC_W2MZLpP0kwrnOk8ACT
X-Proofpoint-GUID: ag6k5zHPDxLgC_W2MZLpP0kwrnOk8ACT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-27_16,2023-05-25_03,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/27/23 5:29 AM, Eduard Zingerman wrote:
> On Sat, 2023-05-27 at 15:21 +0300, Eduard Zingerman wrote:
> [...]
>>>> @@ -15151,6 +15153,33 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>>>>    
>>>>    	switch (base_type(rold->type)) {
>>>>    	case SCALAR_VALUE:
>>>> +		/* Why check_ids() for precise registers?
>>>> +		 *
>>>> +		 * Consider the following BPF code:
>>>> +		 *   1: r6 = ... unbound scalar, ID=a ...
>>>> +		 *   2: r7 = ... unbound scalar, ID=b ...
>>>> +		 *   3: if (r6 > r7) goto +1
>>>> +		 *   4: r6 = r7
>>>> +		 *   5: if (r6 > X) goto ...
>>>> +		 *   6: ... memory operation using r7 ...
>>>> +		 *
>>>> +		 * First verification path is [1-6]:
>>>> +		 * - at (4) same bpf_reg_state::id (b) would be assigned to r6 and r7;
>>>> +		 * - at (5) r6 would be marked <= X, find_equal_scalars() would also mark
>>>> +		 *   r7 <= X, because r6 and r7 share same id.
>>>> +		 *
>>>> +		 * Next verification path would start from (5), because of the jump at (3).
>>>> +		 * The only state difference between first and second visits of (5) is
>>>> +		 * bpf_reg_state::id assignments for r6 and r7: (b, b) vs (a, b).
>>>> +		 * Thus, use check_ids() to distinguish these states.
>>>> +		 *
>>>> +		 * The `rold->precise` check is a performance optimization. If `rold->id`
>>>> +		 * was ever used to access memory / predict jump, the `rold` or any
>>>> +		 * register used in `rold = r?` / `r? = rold` operations would be marked
>>>> +		 * as precise, otherwise it's ID is not really interesting.
>>>> +		 */
>>>> +		if (rold->precise && rold->id && !check_ids(rold->id, rcur->id, idmap))
>>>
>>> Do we need rold->id checking in the above? check_ids should have
>>> rold->id = 0 properly. Or this is just an optimization?
>>
>> You are correct, the check_ids() handles this case and it should be inlined,
>> so there is no need to check rold->id in this 'if' branch.
>>   
>>> regs_exact() has check_ids as well. Not sure whether it makes sense to
>>> create a function regs_exact_scalar() just for scalar and include the
>>> above code. Otherwise, it is strange we do check_ids in different
>>> places.
>>
>> I'm not sure how to best re-organize code here, regs_exact() is a nice
>> compartmentalized abstraction. It is possible to merge my additional
>> check_ids() call with the main 'precise' processing part as below:
>>
>> @@ -15152,21 +15154,22 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>>          switch (base_type(rold->type)) {
>>          case SCALAR_VALUE:
>>                  if (regs_exact(rold, rcur, idmap))
>>                          return true;
>>                  if (env->explore_alu_limits)
>>                          return false;
>>                  if (!rold->precise)
>>                          return true;
>>                  /* new val must satisfy old val knowledge */
>>                  return range_within(rold, rcur) &&
>> -                      tnum_in(rold->var_off, rcur->var_off);
>> +                      tnum_in(rold->var_off, rcur->var_off) &&
>> +                      check_ids(rold->id, rcur->id, idmap);
>>
>> I'd say that extending /* new val must satisfy ... */ comment to
>> explain why check_ids() is needed should be sufficient, but I'm open
>> for suggestions.
> 
> On the other hand, I wanted to have a separate 'if' branch like:
> 
>    if (rold->precise && !check_ids(rold->id, rcur->id, idmap))
>    
> Specifically to explain that 'rold->precise' part is an optimization.

Okay, I think you could keep your original implementation. I do think
checking rold->ref_obj_id in regs_exact is not needed for
SCALAR_VALUE but it may not be that important. The check_ids
checking in reg_exact (for SCALAR_VALUE) can also be skipped
if !rold->precise as an optimization. That is why I mention
to 'inline' regs_exact and re-arrange the codes. You can still
mention that optimization w.r.t. rold->precise. Overall if the code
is more complex, I am okay with your current change.

> 
>>
>>>
>>>> +			return false;
>>>>    		if (regs_exact(rold, rcur, idmap))
>>>>    			return true;
>>>>    		if (env->explore_alu_limits)
>>
> 

