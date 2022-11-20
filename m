Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4B96315C0
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 19:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiKTS4m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 13:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKTS4l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 13:56:41 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6523A1AF11
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 10:56:40 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AK9lUGY024058;
        Sun, 20 Nov 2022 10:55:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=qurBr+zzWLApEH6eW1lGMJqg/fOA9Ef++iYMY+6H5wo=;
 b=DbPGFbXKbtk248hpyAgyOk/bE52uCz8PBDtuAYaBOWeI/nc5D1AyPpsPqNV85ydcNBMs
 P0l0jmcgM743vJH6+5nBvhg8Hzes8qGnqur+NXN/gv2MaN6Ev8lCg8bDD6EkhSQILEW+
 f8kCgNzLkQpPVY5aUk5Gu4RrBp4X5/W45xrttzLWgs6bwds1RLhSWBO+B6enV5QovfCJ
 Z+KljYcqf2KjtlXPnemIe0Y0j2OloXMY/zu9YCuxzLNqKrZs62bqNCZhcHZv1u0TuFvy
 lVnp5Qf0UqCt/ae6evVTw8e45YwyIli4rZGl4r2Q4hsPh8WWC3bRHmUbfu4lrO9Mpt0z lg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kxwuyyqde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 20 Nov 2022 10:55:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGIEUtbPTMZik8Lo5+pbiKOTKu8n5LDTkg+VIvpLjy9iWxVEYjfEDp1f8t/I2cVSxdMYIMLWDg4ibi51DBbCAz4jenCKGAc7dDy3J5mqeV0vmRQPjbgg0F575YBscX20pTpdh9SSc4nMhUZDfkb6FSlg6z4rOVcXW0sLtYvQ5GXlFp4pMKMSzAF3aU79mDm2z5bng4zPeWrNRtqaOzk6xP+IsILIWHz115wHGGbwrSxYYLIY9BRKklrX1/mdVhPc7cX0a0wKc+BqUirMHf1voQYtaW1IcXoqh37spr2d/MJNB4/CRxIm98dIE51buwQlnqVOLF+a06hd+rYGtYBgrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qurBr+zzWLApEH6eW1lGMJqg/fOA9Ef++iYMY+6H5wo=;
 b=Qyli6AlFWUbckibEUsod7M5MaWjRi0gH+U00kbe2nZXo3EF/eGhCaRRb9sZKWXZdke6hlQoXX6wKpXH96NbLF0LTQaXGDZSNBIVt3sHvhGb/ZpB1VrDJIuioZrZJHnBbhbuywqLR8JOYDfoUoBmWP/AFjk0U9harLXefCrpZxqiIxzm3/ezEzFFNjy7A4ldugIylydFQ1Y50Xcss6nHg3O1T9ss5dVuKZoJQQyneVjtpE4dBbAj7u3X/TXxb/+1DRGlLty/1eETqLUTKXcrtS7cBzaMH6GCA4jIhlPvzmDciYVbdeL1sbMUwZDsU85s4HUg+ks6SOGgWLe0RCyf4OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BY3PR15MB4865.namprd15.prod.outlook.com (2603:10b6:a03:3c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Sun, 20 Nov
 2022 18:55:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5834.011; Sun, 20 Nov 2022
 18:55:57 +0000
Message-ID: <0703ccef-cb2e-3903-fe4d-e907b1b8ceea@meta.com>
Date:   Sun, 20 Nov 2022 10:55:54 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Add a kfunc to type cast from bpf
 uapi ctx to kernel ctx
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221120161511.831691-1-yhs@fb.com>
 <20221120161522.833411-1-yhs@fb.com>
 <20221120183324.vlgassj34isouosg@macbook-pro-5.dhcp.thefacebook.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221120183324.vlgassj34isouosg@macbook-pro-5.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BY3PR15MB4865:EE_
X-MS-Office365-Filtering-Correlation-Id: 0514bc61-9a1a-4623-f8fc-08dacb28db83
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bLLWdjBy5Ac+PlNl0OLzGeSx2Y0M+kBiaCSBawzrOsocQaoRle1kz9ocuJMVIvvFdKRElMf5NGew+NWqHoOYgH9WE76AxTcbGaH5a3GOKGwPlSSnPa0XgCtk1t3u8svPekqKqKb1U9DqtAlf8qOnmZ+iEDGHXkXMj7nGOQL0Za4Ca67DjT0DKsG+ox9GB1moiMN9j+ikyS29/i+3F0hmr1es3wpFwOnjkn6d0075vwoLvZYwwfGgp5JlOpUHK60+eRAmrVUtGaJ26f3VAh0aXIiVxE5ksAaoAd+RZjPHTb4yiRq+0elwlQ1huFpT085DtbCUGXRxmGJAuLoDfeW8XVcJtNgHzjGIed60bXaJ0icbLs67hdNMZIyx7zPUl8HOoNMCCAl85U14CkX0ylYEZspKlLqTDZ3Kuev/zk8xJLSV8XDnyEtyb+RNb/SgoNnlVm573PRWyn8g8cpvloD36p5GUVdMaiqEfu4HE6a6lpenx23M7Xvsd+Cb5HPwZ30xzaA7EQkn4cggUzNgFj8SpXRBwCl4cxBCFTetP4GriSetAhKERowDx8XLUQlk/0UTX3PQeObJGE3HTNvxxOZLIG2JEFNq2hQjiSDUQTVNu5cGIpTgFfpEStmBUMAF/gwW3ccmSx/CdX8vfRC6o9QtNtZqvhxlZCnD0hDued6oKnejU0L+s1utf4PIvqH9QSWXd8X1ZAe9/NmKdAl9r9us+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199015)(83380400001)(6512007)(186003)(2616005)(38100700002)(86362001)(31696002)(2906002)(4326008)(8676002)(41300700001)(5660300002)(8936002)(66476007)(6506007)(110136005)(54906003)(316002)(66946007)(66556008)(478600001)(53546011)(6666004)(6486002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elhJeSsrVUVtY3kxYU5tSEpnSVlhMXRraDg3blN1QTNsclFxd2RXd1gvVGZF?=
 =?utf-8?B?WTRlN2NzNW13YWd1L1htYmg5N0htOE1lUE1lZGlEeTVFOXE1bHBNcElRbEZs?=
 =?utf-8?B?bjN1bmtGLzBocHo3ZTlOMmp3QXp4b2JHZ1B4bE53WFhJT1JsSm10N2pPbmh5?=
 =?utf-8?B?Z2M1RWFpZnNkU2hTcnFzVUs2eWtPeVpJbWVWRzZoelNySjgvVGI3UnlTZWZa?=
 =?utf-8?B?ZmxSa2c4djNKSkN5bzFyc2RuS0hWaElld09qTUNaVmxZTnB3U2d3Y3ExRXI3?=
 =?utf-8?B?WUVYeUJpV253Q3drQ3VueG5ES2YxZmUwbmxyTGtOeVRWeG1oZlE5dzl3NHFB?=
 =?utf-8?B?WklNSXlseE5kMUthUDVGamdzTUlPbWJ4dCtrNmdtZzlST25jd2FUVUhIRGRL?=
 =?utf-8?B?TkZtV0JFM0lldkMwRWxvanNaanFUb3NiU3pMV3VCdTl2bVF3N1FFeCtlLzBC?=
 =?utf-8?B?M05tUXBQL3VETjdJWVBRM2d0Um1iZWZVdmd5bFBZaFFlZ21TSlVWTGpqck1h?=
 =?utf-8?B?QW9hZlhQMi93QWFWeWlaRDlWZkRMRVcxa3NSTmFFaDFIMC9aKzNhbStYWXVI?=
 =?utf-8?B?KzdiSnE4UmE4ejVpSDdDWG5rSmlsaGkwRVhwcVo0QThwM3poYUo0ODBTdFdt?=
 =?utf-8?B?cjVnVGpCbGI1eHdBR1NMVC9ReCtEVThReFlsUmhzY3krOVBPMkRWc2dLMEtj?=
 =?utf-8?B?OXA1OXlEeUNiRzhieDdBemduYzkyL21JTEkvNm9HQ2c0aU1tTDZpNU5qSlhh?=
 =?utf-8?B?WWFCd3hxbXg1ejROc25oYVBGU3pMSzd4SGk5dlhzUDg1SXNudCtXN0sxMjhN?=
 =?utf-8?B?N0ZIS2I0VnE4WkVCREN4RzVZcHk2b3Zrb01qTnBBMGh3TlcvWVQ0SHQyelRV?=
 =?utf-8?B?TVRWN1FoNVlGS0ZVUE95aU9Xb1daS3IwaGFXVmVEUGVYRnZOSkc1N25QUWZw?=
 =?utf-8?B?N3dZTXl2dE5rTFVTMzdaOVM3S0swUTYrUWFoN2gwbEVrVkV4RktlaTNTSE9Y?=
 =?utf-8?B?bGZVbzNnOE1hYXZoeVZaTFJQZUxQNktpR3RSWXJua0lQSFIvZXNhRXBCaTFj?=
 =?utf-8?B?UE1YNE11TCtiYWNxb215Q2pVQlZoV2tjc0YvbnpxU3psKzQyZHVzRmtXaWo3?=
 =?utf-8?B?SWNJSFpIcGFvblhhOGJXZUxNbVp6eExvZzQybUhFWE8xNGJZRE1WdVprTis4?=
 =?utf-8?B?QjdsSWI3U2tTVGkzOTM4L1JvejhGdnYyNFN0WDUyeVIrTHFOZmY2Wjkycjcx?=
 =?utf-8?B?bjJteHgwMU43VXJSVDZWZ1lkempLSGdkL0d2SmVreDcvNjVnSkplNXI2QUNo?=
 =?utf-8?B?cVgxY1djZzJkL3FHdnF2MUUzZmQ2N0ZxbGVHeGdKUkFXSHlOaXNld3E1eVNw?=
 =?utf-8?B?NzZxbE1WTVBTWU5GY0trL1E1enZtS29TS0Z0L1llNXpTdTFnS0lLdUNXMzVO?=
 =?utf-8?B?a3ZqTWpxUFdVYWRGb2VJdVQ5N1M3ZjNaZVFHeFdWK21vcEM1MVppS1FBbDJS?=
 =?utf-8?B?UXpCTDRKdVhXdGV3YWcwbkFBZWxidHVMc3pxbUhyd3Yyb21YeDV6ek9SR2R1?=
 =?utf-8?B?Sk9NTytoNGJXRWd6ZXZnODNzWHN4SzdnVDZEdUxsWGVOUlJIclg2MEFGalV0?=
 =?utf-8?B?Z0I5VFVXUzNPR05NZ1BhRjMrU0lRbzFrb2V1OHBXZU9WQ2RjaWMwMWVYUC9w?=
 =?utf-8?B?eGs3T3hhdHovdnp0Vy8xV2NibnpsejhyODc1MkFuN0pNdEhGckhCN0dwQkJD?=
 =?utf-8?B?U1h2bGN1RjN2cXJ4UUhnQWJmUHU4L20vcWJjMU5EZmcveWdWUTZvdXJWNzBD?=
 =?utf-8?B?SWtXM3A3US9wREJDeVVZRGk3TjI1dlBWMzBhelZCK3BWZ2FoUFFQb2JHT2ww?=
 =?utf-8?B?cW5KbGpyNzJFSDJoNHFCekJNM20xTWE4Tk5FT2ZtaXN5cEtHbm8vd1FLS2RE?=
 =?utf-8?B?STBYbCtLcW4raGRTcXgvaUc2dXpYdi96ci9hblBaL1hwbkpVaVhjUFhUSm01?=
 =?utf-8?B?c0pSb0czS3pjOHkzYTJSOUdZMXdQdmN0MklUbUExbEdkSXhmT0VpY1pLaXpY?=
 =?utf-8?B?UTQyamlwRjVWd3Rtd25TS052dGxvQUpLMFkzcFZNZ1Bub1RzbncxNkU5Rkg0?=
 =?utf-8?B?STBZdnpucWNyWG1uZThUbXZJWlV5clN0aTlLcFRkd1pNYXJhblZOOWVMUGJP?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0514bc61-9a1a-4623-f8fc-08dacb28db83
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2022 18:55:56.9742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRKGI5TaBxIqsXRUUfuHK8nTkatr77pdM+xFpe0Y4CyklD4NYYjkdRcAkSVXbigC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4865
X-Proofpoint-ORIG-GUID: RKPIknb3cFlIkxLJ4QJYCHONPY5pSErp
X-Proofpoint-GUID: RKPIknb3cFlIkxLJ4QJYCHONPY5pSErp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-20_13,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/20/22 10:33 AM, Alexei Starovoitov wrote:
> On Sun, Nov 20, 2022 at 08:15:22AM -0800, Yonghong Song wrote:
>> Implement bpf_cast_to_kern_ctx() kfunc which does a type cast
>> of a uapi ctx object to the corresponding kernel ctx. Previously
>> if users want to access some data available in kctx but not
>> in uapi ctx, bpf_probe_read_kernel() helper is needed.
>> The introduction of bpf_cast_to_kern_ctx() allows direct
>> memory access which makes code simpler and easier to understand.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/linux/btf.h   |  5 +++++
>>   kernel/bpf/btf.c      | 25 +++++++++++++++++++++++++
>>   kernel/bpf/helpers.c  |  6 ++++++
>>   kernel/bpf/verifier.c | 21 +++++++++++++++++++++
>>   4 files changed, 57 insertions(+)
>>
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index d5b26380a60f..4b5d799f5d02 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
>> @@ -470,6 +470,7 @@ const struct btf_member *
>>   btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
>>   		      const struct btf_type *t, enum bpf_prog_type prog_type,
>>   		      int arg);
>> +int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_type);
>>   bool btf_types_are_same(const struct btf *btf1, u32 id1,
>>   			const struct btf *btf2, u32 id2);
>>   #else
>> @@ -514,6 +515,10 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
>>   {
>>   	return NULL;
>>   }
>> +static inline int get_kern_ctx_btf_id(struct bpf_verifier_log *log,
>> +				      enum bpf_prog_type prog_type) {
>> +	return -EINVAL;
>> +}
>>   static inline bool btf_types_are_same(const struct btf *btf1, u32 id1,
>>   				      const struct btf *btf2, u32 id2)
>>   {
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 0a3abbe56c5d..bef1b6cfe6b8 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -5603,6 +5603,31 @@ static int btf_translate_to_vmlinux(struct bpf_verifier_log *log,
>>   	return kern_ctx_type->type;
>>   }
>>   
>> +int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_type)
>> +{
>> +	const struct btf_member *kctx_member;
>> +	const struct btf_type *conv_struct;
>> +	const struct btf_type *kctx_type;
>> +	u32 kctx_type_id;
>> +
>> +	conv_struct = bpf_ctx_convert.t;
>> +	if (!conv_struct) {
>> +		bpf_log(log, "btf_vmlinux is malformed\n");
>> +		return -EINVAL;
>> +	}
> 
> If we get to this point this internal pointer would be already checked.
> No need to check it again. Just use it.

This is probably not true.

Currently, conv_struct is tested in function btf_get_prog_ctx_type() 
which is called by get_kfunc_ptr_arg_type().

const struct btf_member *
btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
                       const struct btf_type *t, enum bpf_prog_type 
prog_type,
                       int arg)
{
         const struct btf_type *conv_struct;
         const struct btf_type *ctx_struct;
         const struct btf_member *ctx_type;
         const char *tname, *ctx_tname;

         conv_struct = bpf_ctx_convert.t;
         if (!conv_struct) {
                 bpf_log(log, "btf_vmlinux is malformed\n");
                 return NULL;
         }
	...
}

In get_kfunc_ptr_arg_type(),

...

         /* In this function, we verify the kfunc's BTF as per the 
argument type,
          * leaving the rest of the verification with respect to the 
register
          * type to our caller. When a set of conditions hold in the BTF 
type of
          * arguments, we resolve it to a known kfunc_ptr_arg_type.
          */
         if (btf_get_prog_ctx_type(&env->log, meta->btf, t, 
resolve_prog_type(env->prog), argno))
                 return KF_ARG_PTR_TO_CTX;

Note that if bpf_ctx_convert.t is NULL, btf_get_prog_ctx_type() simply
returns NULL and the logic simply follows through.

Should we actually add a NULL checking for bpf_ctx_convert.t in
bpf_parse_vmlinux?

...
         err = btf_check_type_tags(env, btf, 1);
         if (err)
                 goto errout;

         /* btf_parse_vmlinux() runs under bpf_verifier_lock */
         bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);

         bpf_struct_ops_init(btf, log);
...


> 
>> +
>> +	/* get member for kernel ctx type */
>> +	kctx_member = btf_type_member(conv_struct) + bpf_ctx_convert_map[prog_type] * 2 + 1;
>> +	kctx_type_id = kctx_member->type;
>> +	kctx_type = btf_type_by_id(btf_vmlinux, kctx_type_id);
>> +	if (!btf_type_is_struct(kctx_type)) {
>> +		bpf_log(log, "kern ctx type id %u is not a struct\n", kctx_type_id);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return kctx_type_id;
>> +}
>> +
>>   BTF_ID_LIST(bpf_ctx_convert_btf_id)
>>   BTF_ID(struct, bpf_ctx_convert)
>>   
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index eaae7f474eda..dc6e994feeb9 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -1824,6 +1824,11 @@ struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
>>   	return __bpf_list_del(head, true);
>>   }
>>   
>> +void *bpf_cast_to_kern_ctx(void *obj)
>> +{
>> +	return obj;
>> +}
>> +
>>   __diag_pop();
>>   
>>   BTF_SET8_START(generic_btf_ids)
>> @@ -1844,6 +1849,7 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
>>   };
>>   
>>   BTF_SET8_START(common_btf_ids)
>> +BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx)
>>   BTF_SET8_END(common_btf_ids)
>>   
>>   static const struct btf_kfunc_id_set common_kfunc_set = {
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 195d24316750..a18b519c5225 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -8118,6 +8118,7 @@ enum special_kfunc_type {
>>   	KF_bpf_list_push_back,
>>   	KF_bpf_list_pop_front,
>>   	KF_bpf_list_pop_back,
>> +	KF_bpf_cast_to_kern_ctx,
>>   };
>>   
>>   BTF_SET_START(special_kfunc_set)
>> @@ -8127,6 +8128,7 @@ BTF_ID(func, bpf_list_push_front)
>>   BTF_ID(func, bpf_list_push_back)
>>   BTF_ID(func, bpf_list_pop_front)
>>   BTF_ID(func, bpf_list_pop_back)
>> +BTF_ID(func, bpf_cast_to_kern_ctx)
>>   BTF_SET_END(special_kfunc_set)
>>   
>>   BTF_ID_LIST(special_kfunc_list)
>> @@ -8136,6 +8138,7 @@ BTF_ID(func, bpf_list_push_front)
>>   BTF_ID(func, bpf_list_push_back)
>>   BTF_ID(func, bpf_list_pop_front)
>>   BTF_ID(func, bpf_list_pop_back)
>> +BTF_ID(func, bpf_cast_to_kern_ctx)
>>   
>>   static enum kfunc_ptr_arg_type
>>   get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>> @@ -8149,6 +8152,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>>   	struct bpf_reg_state *reg = &regs[regno];
>>   	bool arg_mem_size = false;
>>   
>> +	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
>> +		return KF_ARG_PTR_TO_CTX;
>> +
>>   	/* In this function, we verify the kfunc's BTF as per the argument type,
>>   	 * leaving the rest of the verification with respect to the register
>>   	 * type to our caller. When a set of conditions hold in the BTF type of
>> @@ -8633,6 +8639,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>   				verbose(env, "arg#%d expected pointer to ctx, but got %s\n", i, btf_type_str(t));
>>   				return -EINVAL;
>>   			}
>> +
>> +			if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
>> +				ret = get_kern_ctx_btf_id(&env->log, resolve_prog_type(env->prog));
>> +				if (ret < 0)
>> +					return -EINVAL;
>> +				meta->arg_constant.value = ret;
> 
> It's not an arg. So 'arg_constant' doesn't fit.
> No need to save every byte in bpf_kfunc_call_arg_meta.
> Let's add new filed like 'ret_btf_id'.

Okay, I can do that.

> 
>> +			}
>>   			break;
>>   		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
>>   			if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
>> @@ -8880,6 +8893,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   				regs[BPF_REG_0].btf = field->list_head.btf;
>>   				regs[BPF_REG_0].btf_id = field->list_head.value_btf_id;
>>   				regs[BPF_REG_0].off = field->list_head.node_offset;
>> +			} else if (meta.func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
>> +				mark_reg_known_zero(env, regs, BPF_REG_0);
>> +				regs[BPF_REG_0].type = PTR_TO_BTF_ID;
> 
> Let's use PTR_TO_BTF_ID | PTR_TRUSTED here.
> PTR_TRUSTED was just recently added (hours ago :)
> With that bpf_cast_to_kern_ctx() will return trusted pointer and we will be able
> to pass it to kfuncs and helpers that expect valid args.

Right, will add PTR_TRUSTED in the next revision.

> 
>> +				regs[BPF_REG_0].btf = desc_btf;
>> +				regs[BPF_REG_0].btf_id = meta.arg_constant.value;
>>   			} else {
>>   				verbose(env, "kernel function %s unhandled dynamic return type\n",
>>   					meta.func_name);
>> @@ -15130,6 +15148,9 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   		insn_buf[1] = addr[1];
>>   		insn_buf[2] = *insn;
>>   		*cnt = 3;
>> +	} else if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
>> +		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
>> +		*cnt = 1;
> 
> Nice! Important optimization.
> I guess we still need:
>   +void *bpf_cast_to_kern_ctx(void *obj)
>   +{
>   +     return obj;
>   +}
> otherwise resolve_btfids will be confused?

Right, we still need the above function definition so resolve_btfids can 
properly populate kfunc id for verification purpose.
