Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AB55A0781
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 04:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiHYC4N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 22:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiHYC4L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 22:56:11 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6A79DF9B
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 19:56:10 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P0itbO023753;
        Wed, 24 Aug 2022 19:55:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=KZK4jv4EWUqiyOGSD1j0YP+W1Ydd2eBOP1Ske5UqOzI=;
 b=WFjTsvFICbo7JGShM2XSb8w8O4fVPbJOQAWVtZWslzeGS6n1WzEsKd4A1kSvmk8nepIe
 lsXDGjNhUHmorQjOC6H7G5hXsJxt1osacHJr6MV2T0HDqShLaRneWdbhzfgvsLgIzKJD
 DbybDGbCitimc8REqJ7Z7D9EmQzxqUxYto8= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5u571vf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 19:55:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRdxZSoWbXHVM9e3AF/kkcGuqi6AWKzt5/skFTYV+t1iIf6ESkmrgUf+E+WommW/maTjwm3ERZRbv575q9aDsLU2mRnwML3Duz0bMLqx38F5k0unlHjWDmkDz5Za+UVJ+sB8CRYH04hErvptU3mjGK/ahze9sOue0SxFZtZlnUmz559vtkXeb8O7Y8rVkzeABeFzvEnyvb7Q/11Wyb08WERnnhUkDAsWyOBCpRODVGUGm1eGjGSjjkut643EIGrJieLqZloZGf2hUtxKjYS53z8ITSW4jh76MLwRMvQPOg+i804KYzURpdBdYCHxUYsxbwWTTPntbDhDgp+Dw0fZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZK4jv4EWUqiyOGSD1j0YP+W1Ydd2eBOP1Ske5UqOzI=;
 b=C1VzL+LvBFUlMlrQi1WLgHXcW7a6ZfoS/yIBqwDbxCdCkWzM/id4FVnP2pBdwIQfo/7NfeYWaxYW6VnC5Wlwn2QdQFCOlA3SgEqoPlnk3WQ8DhZ7YKdoDD4edAzcSUH37owUinuP5RmtNzVtoo2ANijjnTRpKVnitVhLclmf0UpEL2GSNipejK5EcNLSVzY3DiioA8Djzmnf4bkg4+NuJvQRP1GrtaoBXxkEOeFa7BnfnR85UEjFJA9Vj+N/XttfyU2dgZ+QLcV8uwhDLSo9UrjrTpPS+mqoeiklccXhxgBSqp0rPUQIx3rber55FCHO/qe8M83fCv5sGXf8fyaHRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4386.namprd15.prod.outlook.com (2603:10b6:806:191::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 02:55:54 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 02:55:54 +0000
Message-ID: <d9bf2adc-96e6-c6cd-8d69-e381e8568e0b@fb.com>
Date:   Wed, 24 Aug 2022 19:55:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH RFC bpf-next 1/2] bpf: propagate nullness information for
 reg to reg comparisons
Content-Language: en-US
To:     John Fastabend <john.fastabend@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
References: <20220822094312.175448-1-eddyz87@gmail.com>
 <20220822094312.175448-2-eddyz87@gmail.com>
 <63055fa5a080e_292a8208db@john.notmuch>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <63055fa5a080e_292a8208db@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a3b3359-4e30-40d5-d016-08da86455380
X-MS-TrafficTypeDiagnostic: SA1PR15MB4386:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cy9k7KQCGnz6jiA8UfdQLCK7qDv6HCPLsfW+1yd6Yf70H8amcTPugBC1hnXz/WygtytldeTBy4qU5JVJPWs8fNfR1eFzX0hBedmwGO2rg7B6TdERPNIOtQrZgH31de2HrtwuajcjkNXoPj8UQO6t2DzJiSKxDMkC6Gu2et3gkh54yR2nvHHhRDVan713IkUClEMgfiIvfbKkk9QGlX/QEft26Z3/l2Yak1V0SjnZjtRql3lsRwKnkCQrY07GgyaJccLX9I76H1Mm7J8a91XVh7/CeIHn89TSiv2H22UDjJZQXwYVGQhr4rY+K7Tk6aRHQJazfEkdXdOSR5yCNXlKLaoEeSOAsiNXMh+SDndLYqSxJGXtuEoWBji8ZELwfwqmpRTDYJfrNGL7JchUTvcmZVVUYF8dl0l0rhCcClzf+dIDQVWc/A0oRPgz9Ja5TTzYKa2pnMyNpHOcp7FLRv0T8byYFWdd2J1DN86JZ1edGv1EZmvVE31kxmPQvN2pDawu+fuzTYBqlAA1btvyAZ0aoJUUAIY1ZNQ0oqGqSggyay04zmpy3PdxR+8Ukr8bA/krZE1+ov6Y/G3XoQqNM11rtTMTwkdMSssVxkkBJxVidjYgCpUimIMIoM2Jvy2eBB62L64F6ttadnv6OsphmpAPgeqTjwc2OeQRl7+d+iTpI+8N5yVnoXfem/+XdxMJfQX7BmBa1S/I2wya/orR02zVMAlafcKoBZp9zl1FFggYjjYx/L5Qzype9h8IlCslo5vnnqLfvq6I7nD/2eLoKk6c/wZXx+NzH9rBvarr9MoOeHI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(83380400001)(2906002)(6512007)(53546011)(2616005)(186003)(6506007)(31696002)(86362001)(38100700002)(6636002)(36756003)(8936002)(110136005)(5660300002)(316002)(66946007)(41300700001)(66556008)(66476007)(31686004)(6486002)(478600001)(6666004)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmZTbDBQS3FOVTBnaTM1RnROZ2FXUGpnZnU4ekxlQ0pjenJnc05LSVJJTnhl?=
 =?utf-8?B?YmR3WHVsL2hKNXdETmF2bkFIRXZmRG9LV0xleUZwNjZVR2paVjVRNm9xZXA5?=
 =?utf-8?B?azZSRW96eFhITVdPOXJZUWkxQkpSQUdrMU1sOFk4VDlGemhTZFFRT3ZkTnhw?=
 =?utf-8?B?QUxnb0VoOW9ybjQ3YXFrcWFMVFB4U3hRU1k5STBEQy9Vcng1Tk9TOUQ3d05F?=
 =?utf-8?B?bnRhbWVjbDRmQklqYmdGVXY4b3luV1ByQWU2KzU3ang3Z2dJb3dzOSthYnpL?=
 =?utf-8?B?dmlQdjF4RDkxVE03YWJ5NCtNSjlSTyt1SjdSejVWaXl6SWczS2RIRVZSQzBK?=
 =?utf-8?B?UGN2aWVnUDV1aVVyRlFrcGp5MkVFVDEvdzVaOGJkS25TYmhRSDR3OHFHSm5p?=
 =?utf-8?B?and5R2dyWUticUdGZC9pRlhvalJ0WXNGWWpiaklyc0xHZjZuV3lTQWNjSWJM?=
 =?utf-8?B?NUNyNnNoTGRLZE5mL3I2NS95bFdoNWVJZXVaVTBhcVBxdlNJSER2cGc3MzJq?=
 =?utf-8?B?SHVSZjE0bTA3aGtGVVVYbTNWNEtUWjV3c0NPcmV0WEwzakVVRjlpdEh0RlF5?=
 =?utf-8?B?S3hDRUVVamJjWFFsMDBWU3lmT3VrOEYvQ1hGa3c5WEpBUHU2bFdyS3BaWmF1?=
 =?utf-8?B?RnhHWGNsM3AwVWk0Ui9jZ2lZR1dtZ3FZNG9PL1ZEUUVLSjJOdFVWUjJycXZJ?=
 =?utf-8?B?a2tlZW5zcGZUaUh2Nm9qSStiU0hZZmZGb1QyYVVGV2tMUFY0VEpCeGhFRFgr?=
 =?utf-8?B?TkErRmFHU0xUYmlwWU93cldidjhvZ2J3N2p4emtORGVEb1UzcDJ2YzlJVGk1?=
 =?utf-8?B?MDRGclRBdTlKcUhXN0VkQXF5bnUwLzd5dWlobWpLMmJscTVMQW5LWUpGaTdM?=
 =?utf-8?B?dFo1L0dNNjdPTE9JL1JnRFRmOEUwK041UWtwTFl5cmlTQ0lzdm14M0tlajdy?=
 =?utf-8?B?Vnd2ZDNMMmREUmV1V1d6L3YyVjhIdHM2aWx0Mm5rU0ROZ1Z0VVQzQ0hLeGtj?=
 =?utf-8?B?Rjl2bHZYbXg1ZVlsWUFiVVJQM2x4TzFKL25tbW1ZZGN5WlRzbTNNZkx5MzNp?=
 =?utf-8?B?MkJGdTFrak5TeVZPdElSSC9xaFVjOXp2cVB6YmJPUHlPa1RTWFFobHV2WjM2?=
 =?utf-8?B?WlIxUXVoaCt5V2NZVW5Md053U2FkSnBaL1M5ZUtRSWt5eHRqYWVLS3Z1R0dp?=
 =?utf-8?B?WjFsNStGMlNRajZuNU1Rbm51ODE5OWxxbEV0TThRTTdlNkdiWXRVa0paQTNn?=
 =?utf-8?B?RmZhTUlOcENlK05qK3VKTDNsajBEcCtqbit0eFdHUmh4ZEVzZ21GRlljTklv?=
 =?utf-8?B?cXFiWldYbERLZFNiaEY1L01rQW1XVXdSV0ZCaUkxWElva2xaNVhBRXRqSjIr?=
 =?utf-8?B?eVpuNVBPckJJSzVLenBrUEJ5Z3U5SW0vQkdjUHJ3aGk4STFVRzhqYzRaaGYr?=
 =?utf-8?B?cHNHQUx0c1ExSHhYZXY0d3FqQkdYSGxlRzFWenF3czlGbkFKL2lPZU5IaWNN?=
 =?utf-8?B?cnVxczlDNGdlNFFXcS9vV01oOUIzUTA3T0ltZE5iWDZ1WmMwNldYQVJNeFcz?=
 =?utf-8?B?TU5vZ1R5dXZvaTFRK0RVSnI0bktlWUZLb0x3bTh3V2VMc2pORkxnaWw4SDVK?=
 =?utf-8?B?Q1hFejQ0cUlPbWZ4WUc4TUhLeGxUNDBTalE1Q01sNjFpZ1NMMjNlaHhUMU1V?=
 =?utf-8?B?aCtTVUpnU0RhQldYT2N1a0N1VkN4WjB5TXp2WVp5QWxjbzc2MVYwbUUrZUhP?=
 =?utf-8?B?MkVwbjNXanN0K2RmdHpqRW1MalhhdkVhNW92ejNOVW5lVG40OTZEUUkvZkhC?=
 =?utf-8?B?T0FEaUlRT3pzVS9hMWRBbHhDbHdnMk1yRTdYUGtKd1lML1d5UDhUMjFLZG5L?=
 =?utf-8?B?QVpFRlJTZGhMeHhNWWI0dGJqUVlNWHpVaXhRdkExbFVxR1FHeWtpTVdmVlJk?=
 =?utf-8?B?c0tzV1RrYzNuUWF4bklqeEdDYnBjdnBhZlp3Y3U3NC9iWWk1dkJ5cEZLamgr?=
 =?utf-8?B?T2hWb2dMZFNHcC9vV2RjSTZWbDI3WWJiTlVpemRUajc5K1FSRHIrODdUcGkw?=
 =?utf-8?B?V2VjM3lpL1hBYTVSZ3RmQWdaTnlmNE05NkVlSG5Zbjk2U3VWaklTNjFva1VD?=
 =?utf-8?B?eU5lV01Jb0pIM3ZXVjlFMTFFN1JlMUI0dUV3SDVMb0t2NGNKL2hNNksrcjVu?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3b3359-4e30-40d5-d016-08da86455380
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 02:55:53.9412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evqC2eOYhG+YYTWPLwEFQbdznYVN5SBVUxLA4DegzwA501zGyd9fJLMFjraPMGxq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4386
X-Proofpoint-GUID: o77vQcy3F3U8yC_d0y_ClCD6TuD7OfBn
X-Proofpoint-ORIG-GUID: o77vQcy3F3U8yC_d0y_ClCD6TuD7OfBn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_02,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/23/22 4:15 PM, John Fastabend wrote:
> Eduard Zingerman wrote:
>> Propagate nullness information for branches of register to register
>> equality compare instructions. The following rules are used:
>> - suppose register A maybe null
>> - suppose register B is not null
>> - for JNE A, B, ... - A is not null in the false branch
>> - for JEQ A, B, ... - A is not null in the true branch
>>
>> E.g. for program like below:
>>
>>    r6 = skb->sk;
>>    r7 = sk_fullsock(r6);
>>    r0 = sk_fullsock(r6);
>>    if (r0 == 0) return 0;    (a)
>>    if (r0 != r7) return 0;   (b)
>>    *r7->type;                (c)
>>    return 0;
>>
>> It is safe to dereference r7 at point (c), because of (a) and (b).
> 
> I think the idea makes sense. Perhaps Yonhong can comment seeing he was active
> on the LLVM thread. I just scanned the LLVM side for now will take a look
> in more detail in a bit.

The issue is discovered when making some changes in llvm compiler.
I think it is good to add support in verifier so in the future
if compiler generates such code patterns, user won't get
surprised verification failure.

> 
>>
>> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>> ---
>>   kernel/bpf/verifier.c | 39 ++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 2c1f8069f7b7..c48d34625bfd 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -472,6 +472,11 @@ static bool type_may_be_null(u32 type)
>>   	return type & PTR_MAYBE_NULL;
>>   }
>>   
>> +static bool type_is_pointer(enum bpf_reg_type type)
>> +{
>> +	return type != NOT_INIT && type != SCALAR_VALUE;
>> +}
>> +
> 
> Instead of having another helper is_pointer_value() could work here?
> Checking if we need NOT_INIT in that helper now.
> 
>>   static bool is_acquire_function(enum bpf_func_id func_id,
>>   				const struct bpf_map *map)
>>   {
>> @@ -10046,6 +10051,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>>   	struct bpf_verifier_state *other_branch;
>>   	struct bpf_reg_state *regs = this_branch->frame[this_branch->curframe]->regs;
>>   	struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg = NULL;
>> +	struct bpf_reg_state *eq_branch_regs;
>>   	u8 opcode = BPF_OP(insn->code);
>>   	bool is_jmp32;
>>   	int pred = -1;
>> @@ -10155,7 +10161,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>>   	/* detect if we are comparing against a constant value so we can adjust
>>   	 * our min/max values for our dst register.
>>   	 * this is only legit if both are scalars (or pointers to the same
>> -	 * object, I suppose, but we don't support that right now), because
>> +	 * object, I suppose, see the next if block), because
>>   	 * otherwise the different base pointers mean the offsets aren't
>>   	 * comparable.
>>   	 */
>> @@ -10199,6 +10205,37 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>>   					opcode, is_jmp32);
>>   	}
>>   
>> +	/* if one pointer register is compared to another pointer
>> +	 * register check if PTR_MAYBE_NULL could be lifted.
>> +	 * E.g. register A - maybe null
>> +	 *      register B - not null
>> +	 * for JNE A, B, ... - A is not null in the false branch;
>> +	 * for JEQ A, B, ... - A is not null in the true branch.
>> +	 */
>> +	if (!is_jmp32 &&
>> +	    BPF_SRC(insn->code) == BPF_X &&
>> +	    type_is_pointer(src_reg->type) && type_is_pointer(dst_reg->type) &&
>> +	    type_may_be_null(src_reg->type) != type_may_be_null(dst_reg->type)) {
>> +		eq_branch_regs = NULL;
>> +		switch (opcode) {
>> +		case BPF_JEQ:
>> +			eq_branch_regs = other_branch_regs;
>> +			break;
>> +		case BPF_JNE:
>> +			eq_branch_regs = regs;
>> +			break;
>> +		default:
>> +			/* do nothing */
>> +			break;
>> +		}
>> +		if (eq_branch_regs) {
>> +			if (type_may_be_null(src_reg->type))
>> +				mark_ptr_not_null_reg(&eq_branch_regs[insn->src_reg]);
>> +			else
>> +				mark_ptr_not_null_reg(&eq_branch_regs[insn->dst_reg]);
>> +		}
>> +	}
>> +
>>   	if (dst_reg->type == SCALAR_VALUE && dst_reg->id &&
>>   	    !WARN_ON_ONCE(dst_reg->id != other_branch_regs[insn->dst_reg].id)) {
>>   		find_equal_scalars(this_branch, dst_reg);
>> -- 
>> 2.37.1
>>
> 
> 
