Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848F2505FB7
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 00:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiDRWZR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Apr 2022 18:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiDRWZQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Apr 2022 18:25:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F7929CB4
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 15:22:34 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23IKenmb005017;
        Mon, 18 Apr 2022 15:22:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=O86dorsk5dPkCxU7NF/+arnmwyCTJZPIi87kMHnhyz4=;
 b=p/QRrAoGKmKkIBTyxNu8tY+dRd2buBgwW7awPZ8fxEQOG5RnZ1XJjZh8pURYK6Qr8DOx
 U5N4TKt+veO/9Z1p7PSS5rZZGmFCNGGP++nkg8EcDaddUYCYTsQX34x+UAnXVAXn4KoY
 nbKDL7yldynsIprWf7GlEancK/8rqBKAOCY= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ffugnugkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 15:22:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CH4UObRYr4rjY+ctEHHnfaQ5CBPc1CbMJ5k8WjPs25t0v9uv2uGAuYm1OD5UdVsvV/u/ympDMGdZ+qzBUROVXLFFcFd3HbN2LicgF1tZDGrpLsg9jFUlKCkppO4V5MyP56hNOY8IiLiByOIcvtbSuRzNkzVVg4vJPowzwSVR3pNKAMSvair4aPFjxjjlI6RlI0xywrEtoua4hnc4LEvcj9IuTsiu52U+1eTvELBKdcOTgoMg4AcvG7L4LJTmIBcqnXO7yRSzUfB8mUgin3VgJTFSu4n7dhZuOhKDTCu26ikrB9Bx2Ke8h5B+pZqXqAHoi7PBeDtZLVYO6/pi328oxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O86dorsk5dPkCxU7NF/+arnmwyCTJZPIi87kMHnhyz4=;
 b=W0Q7+3pscsXrtjzmFpRe9GikqDZ2UYxDtPPHiavdvdkp89OyV3uYSgNV799Y4EIpuvh+8A76keJOjMW9ZUPsdIx66VdAqPAFcfvKW76u4HwT153lJzok5oC7KRnnsCaZSDVyz33pGBUYfiOn6voBwi86MPigvfCzT9D73Qkm8hfZhOavK1h2PIn9faibfZL7rkeQ3Et2lv3d9325n6PAQt4jSN8qKd6uhj49/zezmQwvw+r3LoXiNLLRPfap+uo6TrP2l7+hZZxvjTUdgaIhBCHrQ539XOXgzdseTXeDtXc1cKu/pX6DjtrVT3LbJuh8sAUxzq3hkU+d+g+IjBHgcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN8PR15MB3363.namprd15.prod.outlook.com (2603:10b6:408:73::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Mon, 18 Apr
 2022 22:22:17 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::24de:30b1:5d2:b901]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::24de:30b1:5d2:b901%7]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 22:22:17 +0000
Message-ID: <19b5e6fa-b041-a824-362e-a1cc7615d253@fb.com>
Date:   Mon, 18 Apr 2022 15:22:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Ensure type tags precede modifiers
 in BTF
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20220406004121.282699-1-memxor@gmail.com>
 <20220406004121.282699-2-memxor@gmail.com>
 <47fe6f32-fe4d-2e1d-6297-36c30d8c6586@fb.com>
 <20220418203108.zsyox6jr4k5al5yo@apollo.legion>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220418203108.zsyox6jr4k5al5yo@apollo.legion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0042.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5479940-546a-4d19-025d-08da2189e569
X-MS-TrafficTypeDiagnostic: BN8PR15MB3363:EE_
X-Microsoft-Antispam-PRVS: <BN8PR15MB33633CC0C7F6580D663759E7D3F39@BN8PR15MB3363.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aiI1nHQ60ADT555giaRn/4fXLF+RPBx/YmszqxJiksqy+TCHFj7Hs6syVx3GF2v/+uyi0ymTQQmfqEtmS09wMqljswZrYfW3jAypOHyCiLHAEPy6HdwO2dqXBTYlGnVRcN/YXG2FORiZg6MVtb73OA6qkYdgNkm4TProxUj6g/uZgglf9dWU6lYrrbD1/q253epxDCGnAzW3qDmjHm3ojav3f4f7rmAtCvQYJ+mJeOUUUYlOj3DLIEwwzzr4yBBvFsCUjxLIXv3Nz5yxyexaPnzJxGJp/HREshFNoGYZ5j6WDpwkpm2W6ljWYEoWE6xR3CA98LZuoYV0KpP965+SHPf7UHuoQ8b+SGUVk1lzL5QqapKqUowOo4jsigSGV96FmRfuAYk74sd6O22WnauO53+zFx7qznpIjQ2wZ+PVc4bvRyuN1fN4xItRJnF47hvnonbuMkN8QeZiwoV+dDScfHIcV1DMlMM5H1J6dbN1T0PqcP1ne2hcST+pLIMlcJjr6/KnV0Y50I3z76VJjnkOIPhdp9jSKSv9/soATki9qcEr6hwss2dtW5uPaRBJHJqs8jMvp0kv557rx8W2xedZjhghx3OQb+H9el5JS6oeZYYhVfkB5Os+wdLv9rVJRiqinwd1Po7dCdflFVhspoyW4H6ps15km/Enk2tZQWk2xHaMl5TRARv1n5oLg/t5Ugd95+4LYoVc+sMWMDu8pG5d1uIZRKgydp2ielCSeQ70Px6R631gfyI5wQK9wEkZvRcX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(31686004)(86362001)(6486002)(31696002)(5660300002)(2616005)(186003)(36756003)(66476007)(66946007)(66556008)(8676002)(4326008)(52116002)(316002)(38100700002)(6512007)(53546011)(6506007)(508600001)(8936002)(6666004)(54906003)(2906002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nnh5RTFleDhMRmFOZ2N3c2FXaTNUdk5Xd1krNkpFcWZFaGZZNS83aUVSaTJJ?=
 =?utf-8?B?bGJlWDdESnZmZ3o0dUpla0RYMUFnNllHY21vRTJrTG55bTF5NGs1WHFVTzd1?=
 =?utf-8?B?MDQ1dldSd09XMUl3SGlUSXprVmpjNFBrdzlaMlFvUE9zSWJFeDBIOUV1bTBK?=
 =?utf-8?B?b052THBVa1ZCS3VyZjRvcVl0QnBxb29TL0s0cmdUM0lzTE85MG94WVd2bWR2?=
 =?utf-8?B?ZXVqeVZLZ2lBUjhBNmo1ZHN6Y0pqdXNNc2RTWVc1WHJhQy9SNVNTU3hmUDVF?=
 =?utf-8?B?SERsUkUyRVk4S21pbjNDbXplR3NpY3NEenlkakJaTDJYZ2RIcVVxOUNicVls?=
 =?utf-8?B?NHhWYjRNeDVzeWJkUW9IS0JLOWRhaW1UTERScjhsTGpVdFN6RlVtdFNnc1lN?=
 =?utf-8?B?Rm11VWxydDNVdkE0WEd3YVNLZ2V6eFZ5ZHJZZSs0M3ZFMXd0MlRPYWsxSzU3?=
 =?utf-8?B?MHJKVGJPK1lKNEVTc2w3bkV5S2VITjhaM0pvMm9RY3BxZyt6bHIvclYycGRr?=
 =?utf-8?B?VXFsSkVncURlaGpoL3lyVVhzNlRHQy9jeHBpMmo1ODNCUzZwYkZBRkdkV1Bu?=
 =?utf-8?B?TkRCVnNLYytRbnpGR20wYVp3N2t3T0g4QTZ3em1zZ3hZUVl2OG5kaXFKOTAx?=
 =?utf-8?B?VFQ4VWdLQTR1VnNZR1R6S2NhaDhwM1M3WFo2RXl2ZFF5cSthVGhjOGxxdkhp?=
 =?utf-8?B?RFcyYUIyK25ldVE0WTNiQjBMaWVnRS85dVkzS0g5WFBjTEtDUW5UOVdoWVVP?=
 =?utf-8?B?aHdVNUJYQ2p0QlNJS1ZiUmZiM2phLzA3MGZTRFloVTR4cDdnUkh2SVI2eVVz?=
 =?utf-8?B?bnp4ME9LdmN0ZERva3pTaS9SRnhaVzVzTmJpSWpBZ3k5VTF2aExxZUlPWVBW?=
 =?utf-8?B?WVdSYlc4ZEI5NUZmak5ibzkrbmI2dlUrNEhmYWRIWXhuQmhYUlc3NnJ0Z2hU?=
 =?utf-8?B?L3lVb0tZMExNWTN2cU5yelpUK3hzVzFJTjA2Y2xSZEN0T2lqRHVoRFhZQ3Z0?=
 =?utf-8?B?MG9Ec1ZLVHFzWnhVTkN3YTJOMWtseEZaMm1oMy9tYXNselg3NzlzbmUyK2R3?=
 =?utf-8?B?cmdNL1Z4KzBGZXl0dThwVVJxaGFhVit1WnpMeDdmTzBTdUs3WXYyZFgxMW8x?=
 =?utf-8?B?ZENXMUdxeGNOeWRqd2VwZVNkeU9INlUwZks2WTIyUzc2OWlTelRMeW1xeE9j?=
 =?utf-8?B?SGlzQjFXQVcxMVZTWHFXU3pUb0hHL1RocTNLRkNxdHF4RXY2N3RpYk85N0NI?=
 =?utf-8?B?TlI4S01SUmJJRk1Odi9PWjU4dHhWWGYwV25JQmNGeCtXaC9VdDFSczY1M3ZT?=
 =?utf-8?B?ZndoUHBHRGhxZmRPSTRheEcvYmFLWVRMZU1tY0tZVUcrMUtEMVlNbUVTQ2ps?=
 =?utf-8?B?RStQKzdzR1pUcUVnUzY5ZnFBajlaVGxTQlppRURsMlpXanRBU1BUcElLOXNs?=
 =?utf-8?B?SnF4WEppeVRjTUkva0xRN0kzUUxUR2VuOUg3S1VwZ3ZYQkc5UVVGWnRWYVEz?=
 =?utf-8?B?UjFiZExjODUrQ0crUFFOMWIrY1M5K2JiZFlVK2tUU1M2TFFubWEvMnc2bEgy?=
 =?utf-8?B?YVNqTUZVVUtKNzJFUEpNYWFNMjUxQ25IT0UwZEJZODk4UTJFcnVIenBQdmxE?=
 =?utf-8?B?ZGR5RXhyR21yODBIMFJNekhITGdCd1JxejlGS0MzeVJqZTJxY3ZpM012OTVD?=
 =?utf-8?B?dWhXM1YyeEdLVXk3eGl3WG1BVU9RNTRHMXhkb1ZqdWtDNXpyOVFqbzFvMFkx?=
 =?utf-8?B?cWN4emJSNndFbElyTXpPRU5MWUlibkIvM29FQ25QSjJ0SjM4RFFpcE5pQ3Zn?=
 =?utf-8?B?a2hjdmhKOXAyS1R1eUhoVjRiZjZuL0pGU1hQcFZoWFh6d0Zia2NSRkNzZWZw?=
 =?utf-8?B?QThlSmczdjhKRVZyRGdZTHVzVEJ2R094NEJnNVdCTUdFWjEwTTFrQ3ZNbUov?=
 =?utf-8?B?Vko3dUxmSWdNVXo2Q1NKZXpTN3BsY2lycnJwVjU2Wno5ZmFpaEdSb0VWK3dl?=
 =?utf-8?B?dE5sSWZlZW1PSGdQempBSHlnN2hnWngwazdLRjVNUktXb3p5RDNjMER5anZQ?=
 =?utf-8?B?L3NORTVRc2JZTGtCSDB2eStaNWd2N2hEOTV1NW0yTzBrY2FhYlB0SVdERjJG?=
 =?utf-8?B?a3FaMHplTEFaSGVEc1AxTk1Ccm5abFFjb2VrdGhuRVJyYk9HTnduZHpYV0lV?=
 =?utf-8?B?eHZIVFlQaklCNGpEV3ArNkZ1UnNYQmExekxJS08xbWpMMVpLRVF5Z0VXNHJn?=
 =?utf-8?B?K0xBeDk5TFJza2Z5ei9ITWlWSmcyN2Jsc3BaYmhDdGU1My95dE8reHZKYTJV?=
 =?utf-8?B?TUxEd0xMc1Z4NStwN3grMkxzMElnZW5NK0FVZm1DWkd4ZWs1U3NIWVZMSVdn?=
 =?utf-8?Q?ozeP/8XKD/gtlhAU=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5479940-546a-4d19-025d-08da2189e569
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 22:22:17.1009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdMw8vn9v2z6PvouvCnVbj1ee14RzWUrPHmBGKowgNy7OtCn1dZXPy14JrUww/g+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3363
X-Proofpoint-GUID: uS2uCaRHMSfm3h2MeK4-qC3L_Vcg_vdg
X-Proofpoint-ORIG-GUID: uS2uCaRHMSfm3h2MeK4-qC3L_Vcg_vdg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-18_02,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/18/22 1:31 PM, Kumar Kartikeya Dwivedi wrote:
> On Tue, Apr 19, 2022 at 01:23:32AM IST, Yonghong Song wrote:
>>
>>
>> On 4/5/22 5:41 PM, Kumar Kartikeya Dwivedi wrote:
>>> It is guaranteed that for modifiers, clang always places type tags
>>> before other modifiers, and then the base type. We would like to rely on
>>> this guarantee inside the kernel to make it simple to parse type tags
>>> from BTF.
>>>
>>> However, a user would be allowed to construct a BTF without such
>>> guarantees. Hence, add a pass to check that in modifier chains, type
>>> tags only occur at the head of the chain, and then don't occur later in
>>> the chain.
>>>
>>> If we see a type tag, we can have one or more type tags preceding other
>>> modifiers that then never have another type tag. If we see other
>>> modifiers, all modifiers following them should never be a type tag.
>>>
>>> Instead of having to walk chains we verified previously, we can remember
>>> the last good modifier type ID which headed a good chain. At that point,
>>> we must have verified all other chains headed by type IDs less than it.
>>> This makes the verification process less costly, and it becomes a simple
>>> O(n) pass.
>>>
>>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>>> ---
>>>    kernel/bpf/btf.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 51 insertions(+)
>>>
>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>> index 0918a39279f6..4a73f5b8127e 100644
>>> --- a/kernel/bpf/btf.c
>>> +++ b/kernel/bpf/btf.c
>>> @@ -4541,6 +4541,45 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
>>>    	return 0;
>>>    }
>>> +static int btf_check_type_tags(struct btf_verifier_env *env,
>>> +			       struct btf *btf, int start_id)
>>> +{
>>> +	int i, n, good_id = start_id - 1;
>>> +	bool in_tags;
>>> +
>>> +	n = btf_nr_types(btf);
>>> +	for (i = start_id; i < n; i++) {
>>> +		const struct btf_type *t;
>>> +
>>> +		t = btf_type_by_id(btf, i);
>>> +		if (!t)
>>> +			return -EINVAL;
>>> +		if (!btf_type_is_modifier(t))
>>> +			continue;
>>> +
>>> +		cond_resched();
>>> +
>>> +		in_tags = btf_type_is_type_tag(t);
>>> +		while (btf_type_is_modifier(t)) {
>>> +			if (btf_type_is_type_tag(t)) {
>>> +				if (!in_tags) {
>>> +					btf_verifier_log(env, "Type tags don't precede modifiers");
>>> +					return -EINVAL;
>>> +				}
>>> +			} else if (in_tags) {
>>> +				in_tags = false;
>>> +			}
>>> +			if (t->type <= good_id)
>>> +				break;
>>
>> General approach looks good. Currently verifier does assume type_tag
>> immediately following ptr type and before all other modifiers we do
>> need to ensure
>>
>> I think we may have an issue here though. Suppose we have the
>> following types
>>     1 ptr -> 2
>>     2 tag -> 3
>>     3 const -> 4
>>     4 int
>>     5 ptr -> 6
>>     6 const -> 2
>>
>> In this particular case, when processing modifier 6, we
>> have in_tags is false, but t->type (2) <= good_id (5).
>> But this is illegal as we have ptr-> const -> tag -> const -> int.
>>
> 
> Thanks a lot for catching the bug.
> 
> So when we have set a non-zero good_id, we know two things:
> If good_id is a type tag, it will be followed by one or more type tag modifiers
> and then only non type tag modifiers, else it will only be a series of non type
> tag modifiers.
> 
> When comparing next type ID (t->type) with good_id, we need to see if it is a
> type_tag and compare against in_tags to ensure it can be part of current chain.
> So this t->type check needs to be changed to be against current type ID, and
> should happen in next loop iteration after in_tags has been checked against 't'.
> 
> The following change should fix this:
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 4a73f5b8127e..c015ccd1c741 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -4550,6 +4550,7 @@ static int btf_check_type_tags(struct btf_verifier_env *env,
>          n = btf_nr_types(btf);
>          for (i = start_id; i < n; i++) {
>                  const struct btf_type *t;
> +               u32 cur_id = i;
> 
>                  t = btf_type_by_id(btf, i);
>                  if (!t)
> @@ -4569,8 +4570,10 @@ static int btf_check_type_tags(struct btf_verifier_env *env,
>                          } else if (in_tags) {
>                                  in_tags = false;
>                          }
> -                       if (t->type <= good_id)
> +                       if (cur_id <= good_id)
>                                  break;
> +                       /* Move to next type */
> +                       cur_id = t->type;
>                          t = btf_type_by_id(btf, t->type);
>                          if (!t)
>                                  return -EINVAL;
> 
> --
> 
> If it looks good, I can respin with your example added as another test in
> selftests.

I checked and it looks good to me. Right, it would be great if an 
selftest is added for this pattern.

[...]
