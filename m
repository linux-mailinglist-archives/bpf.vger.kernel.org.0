Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB994AE691
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 03:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242078AbiBICj3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 21:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243233AbiBIBjN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 20:39:13 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D11DC06157B
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 17:39:12 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 218NJGFW022320;
        Tue, 8 Feb 2022 17:38:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=hiAP7pTOtJowcgYj6XEf6C1eLQcYVtcaZRu8MgW3Zes=;
 b=pbkv6Xa10Vtru1PGx6zbkC2IkMa//UiJ89nTlirrpnalBJlMs/vU1CpixdjpIu+m6Gk6
 ZC+Hm31u4EUB0HBpG+MhWLUsG/RdInSEabHrFgWpQ5S1tgkptncCiyK7t7pQS8gWqfU0
 NZAyxPfpoMBHxizzvtB8GdX41mRVTnF3YTg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e3tybc9v1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Feb 2022 17:38:56 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 17:38:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acxNG+/Ppt05yVM+vFxOv6dcxcWvYtVYLgL5UelB85mMwHEJnIhcFw45bSrxDqwjwRPYA6ERH7MnxTrlrAi1A98QZgcbup88T/3kz9bH4IzWKzah+xN7E974m6DhMf7CeoEYmEQL0+9NiHGbNfqlS6vnrQhhY9ZP8gu/vFWQjgnFa4iAahIKnYaqTN68o0zT/ZQlgmhMRQzjlxrfRnS4xI6LLAy31ozC+M+zOyRMO5ai/1S4jfFPPQoelUhfUVaWJsk/AAtEv+pCeBjinB8C7jqlHri6fqHXe6AEpI+lvaF9Oj+Q+I09zI6bRCzlWpzvRsVwk6JnL2H3gJud2ix9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiAP7pTOtJowcgYj6XEf6C1eLQcYVtcaZRu8MgW3Zes=;
 b=L7eJlbARTmp9Kw9YGrJo8vqQpoQ2zm7vluhUJsoZVDGaXxMcXH9oVqIa2lR0PbsxK6rj1Z0PQQqQu+BUbj4jPsPwb1xsZLVXiXy+OqxSkrd9fTYZMOpwPFy0JpW8++zaIhcmNPp94098HvXUEsR8z7jpsddv1ezGiDbUhfAScGjoKQwhHtFd4PrAUBv2xR5rBcSUE06a42zNXJD2uJ8/PpySkclBUaI36/3aVWL3n5WSL6V9gQk2RCK6hvf5lbv6fwEgHx8MF4xQw/tbtMHFC4FnzG27kH11tfyejc/t4zRmbvJLCINYDXD8GtlzgepF115TIi9ujntlGH163SH4Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BL0PR1501MB2082.namprd15.prod.outlook.com (2603:10b6:207:31::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 01:38:54 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 01:38:54 +0000
Message-ID: <d188c083-3eaa-c153-8059-847a257bc553@fb.com>
Date:   Tue, 8 Feb 2022 17:38:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 bpf-next 3/5] bpftool: Generalize light skeleton
 generation.
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <davem@davemloft.net>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
References: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
 <20220208191306.6136-4-alexei.starovoitov@gmail.com>
 <8a126b25-b8d0-3838-ecaa-0613c9e4894e@fb.com>
 <20220209005235.jqc3ox557oceuwsb@ast-mbp.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220209005235.jqc3ox557oceuwsb@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:303:8d::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92cf93da-319f-48cb-16d6-08d9eb6ceed9
X-MS-TrafficTypeDiagnostic: BL0PR1501MB2082:EE_
X-Microsoft-Antispam-PRVS: <BL0PR1501MB20822F3405BDDAF0AC7582D8D32E9@BL0PR1501MB2082.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:332;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1eN3Lrun2+bICoMAGoyknSC4KcqB+xrpQt4dO2rlBPt0P/dnhf9m4nlQkPc9NenDAhmvBiTMYE58sxUapSqiyGMeBO/QDsTLXA3SlhoMtgMbOVbajO++eeMToiRVad+eCIdLnzbpdWkxTzEgehb6PR0gjZPrJ0KxhKnRQoJOMg4N+IVrGrNblryNwQQK9NYhkDoScUcOxvpSTV4UlAUVrgGtLRRjd729QsDcjXypT9RnNZeeRB2Uu9qPmnHnq5EVrU3EmbRCgrQwIREp4IFN0R0nK7LmS4ZLrwcY1jAB/qqebQxp4/cksJfpc2YYMyikiihInBOWtl3ke6hx5ZTQleW2IOaFkRIMfSl/GxFUkFr5WWNTTkyxRHgCbwJ8XKHZSlX+6HwuHBOxcXT1u75KJo/u89DRPfIUVvyyav+LJW7Out7OxegzRpMaZ5wwx7k8324ph8NiAP2QqdvbGX9GXHiIAeMcp/XFHSV7nCkhIFLaYt8JyavLeVu0ceXtjsrMs8YbfLBbU7quTf8jNVIELY8OPCjwTRViPRkixUFFaMGI6mNsMhbfNMLQ95IlyillSS6vsQfMp4x6sU/r88DwNy9uqXcWgR4chRusPXcThcblK3qsam802Xu4XRbxsgagVbRkNeTyzEKKd46D5T/X6oCq863BzbGY5L92ecQlwyo23LuptOk0r4+xlnp2C3vDxEclRlBbZSoE99r+uM9P0RG5NRdPMsKAm2NPGFOuPFteCjl/0HfmP2gqv4ReHIpj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(2616005)(5660300002)(6506007)(52116002)(4326008)(8676002)(6512007)(66556008)(66476007)(66946007)(8936002)(6916009)(31696002)(316002)(53546011)(186003)(36756003)(2906002)(86362001)(83380400001)(6486002)(6666004)(508600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnMyQnVBZnJxZnZXVkZRMVdYKzJ2V0hyU2pPQ29jcUE4dVpVNEt4MFhTaGxT?=
 =?utf-8?B?U3hWMVJkMWJvV0lBUUdmMERrNmZpRW1ab1ZkOWQ3YVhsdFVOM3BVdnJYK2lt?=
 =?utf-8?B?SDVmaUJ5MUlKYWt1M2wzSytkK3g5bmpDYWtlUUR3YXliaElJRVVkcGZFM3lk?=
 =?utf-8?B?d21FT3c3MGVaTWVOakQ1N0kzWWtRME42dzZ1QWREOUthNzgvbVpaaWszb0lZ?=
 =?utf-8?B?Qzd0SW9tVW1RK3NkUDBtZGU2VVdzWTFBQzNJYzlhZjZmRW1Sb2txZ2ZVcDM2?=
 =?utf-8?B?T2xscUFXUUZUU1FJZ1QwTDhhNm0zYVQ0UDRhemwvNkpCanFnSWtvMklnTDhD?=
 =?utf-8?B?WStuUFRXTnMvZHVKOFI1QjRNVEpCR0d3amlWOVU0L3huT3BmZUh3V1FwMHBJ?=
 =?utf-8?B?cG9lMWI4bHB2eGYwMzJ6eTBhK2ZQR2hITFRPcDhUcVVkNXVzbEIvT2kySkFQ?=
 =?utf-8?B?eE80L3Q1N0JYcWtNTjlLWmVKWnRKMWJ4eHk4WE56MFgrNytKanpOcVFsWExi?=
 =?utf-8?B?aHlzOGVmYVE2UCtrUWQ2V3VzbmwxcldvYVErMThSOFNHU2o1eThNVmtsM09o?=
 =?utf-8?B?ODZ1OWVzTW5IbzV2QytVbXB0K1loZTk3K1hJZHVQRnFLcGJVU1VEOTkvWFNw?=
 =?utf-8?B?MzdvdkZBck4xcFZaT056MC9ubW1VN2Znc0krZlZESHZHQUtVTWN4ZUpncFpu?=
 =?utf-8?B?NUxDUUhWSTJkZ3NneTBHUkNnQWZHU0FOSTdCSEc0K1d0TmV2dVhwcnhuVXpk?=
 =?utf-8?B?bXp3RC9ndmtzL2hMYlk1UU40SThWbkdTZy9oY09KY2NpRnN6SXl0bTBaZ2lG?=
 =?utf-8?B?dThvN1NpYUNBU2x6dG9yMWl5VGV1UGRVd01zSTNaNkRVQ2ZINCtxdDlwTnZN?=
 =?utf-8?B?TnRPajlMRXJ3TmxoZEkwdE9hRE8zaHZIbGtrOTFRYXcyTU1TTG9pcWl5aEhN?=
 =?utf-8?B?NjRZeHlncmNwcmlhNzZPRWpEbHV1OXFZZ0VYaUNwMWtmTzgvNjZhL2J4Sk5B?=
 =?utf-8?B?M0NGdG5uSFFLMDZnMDlxcndSTGN2eTEwR0NBMElpOWJpaWZuR2JiS1hHZHJF?=
 =?utf-8?B?VGJYUkE0aUZHZmNQcHRuNlJCRkYxZTgvYlQvM3BvSzExVjhCWGJRdmZ5M2tC?=
 =?utf-8?B?TW1QVTJQeHh5WGtJam1xZnBBNE1zUkJMWnJnN0VNRElSVmE2ZEwyV3dJTXQ4?=
 =?utf-8?B?ekxnWVM1dlh6TTNSd3ZLWGN4anJLSThsb251TGJnOEVUZ2JLSkZTSlFSMWsx?=
 =?utf-8?B?aExXMmV3dXpESUkvbThnWlVXSHNWdGdxR1l0UmQvc1JRNG45TG5IVGhweSs3?=
 =?utf-8?B?TG1hYWc0MHpvaDlDeUhjeHZZa2VSVW9DRjV2SHhhdFZTNExFU0Z4YncvOEcx?=
 =?utf-8?B?dUNHMDhMSmFBeitsbDgweVE5aWxXVG9lbnBWV1gvcmd3dGRnLzVtSTNiM09k?=
 =?utf-8?B?aDFMNERIakZnK1BYRlhGZlhURWNsRWFjN0xVekxmZzZ2NWlkMkpqZEVSVGVs?=
 =?utf-8?B?VUVSZlEyRThtTnFkZ0xyTlhpZ296VklUY0F2cEhCR2ptZHFWaHhGVkVSOHNO?=
 =?utf-8?B?Q2NTNzh1a0VvM1N4bXNUemhuZmdlMW81dkt0eTEvZ0tpYngyeHlIbU1ja0Rp?=
 =?utf-8?B?VUViZXIxVXJpTmxZSDF6dmNDVlBOblRSay9DVk1DcVQ1RFJGbDBmU3B4WURF?=
 =?utf-8?B?cmhTZDJPM1pGejZ0WXhBZGVVNjlERFlvcTcyQzV0dnJ4Ym5ZZFBwdi9pU3Ra?=
 =?utf-8?B?d2cvanBLOGNlR2VLR1RwSWlyRnpma2RZcTZZSTJWWFI1T1hVdWdZYnAxWis3?=
 =?utf-8?B?ZzZaQWVNWFRrS0R4VUVhTkFjZ2hxYXhZTnpZSkQ2Z2tyMnlqSlczcFJNTS9Q?=
 =?utf-8?B?Z0N4dnpVTEd4LzRhaHdua05RZWFPYytjSWRSTGR3aHozZ1FVcVJKbmYyejQr?=
 =?utf-8?B?bnRtMUJFbkpvZ2pEeTV4Q2x0dTNEcm52clJjRVRydnFqTXNIekZ2anMyTEtT?=
 =?utf-8?B?L3pKdjMwS2M0NmNaMmgzbFY2dS84YndPQjlUVFRBY0JiWWRNcTRQaFgwbXNO?=
 =?utf-8?B?a1VDdVdTUUxHUkZXNWJXaEF6SUNSbVJSaVV6OWNMeEh1MlNsMmE5TEdUVmhO?=
 =?utf-8?B?dHJiZEtWTXFoVjhKVHJ5NWZ2VFNrb1E2cVhGYUJzcVNmRnA4ZmNrMkp2bFBK?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cf93da-319f-48cb-16d6-08d9eb6ceed9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 01:38:54.7085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OSFK5/oy7FZhG/iCDGhJofFVVaFT7OxoM/K7fVUTrLKU5KQUDvHpVO0aFWdzglS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2082
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: XgtrTftKbgwH1iSxrZ9MtOla6qsPQD4x
X-Proofpoint-GUID: XgtrTftKbgwH1iSxrZ9MtOla6qsPQD4x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_08,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090011
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/8/22 4:52 PM, Alexei Starovoitov wrote:
> On Tue, Feb 08, 2022 at 04:25:15PM -0800, Yonghong Song wrote:
>>
>>
>> On 2/8/22 11:13 AM, Alexei Starovoitov wrote:
>>> From: Alexei Starovoitov <ast@kernel.org>
>>>
>>> Generealize light skeleton by hiding mmap details in skel_internal.h
>>> In this form generated lskel.h is usable both by user space and by the kernel.
>>>
>>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>>> ---
>>>    tools/bpf/bpftool/gen.c | 45 ++++++++++++++++++++++++-----------------
>>>    1 file changed, 27 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
>>> index eacfc6a2060d..903abbf077ce 100644
>>> --- a/tools/bpf/bpftool/gen.c
>>> +++ b/tools/bpf/bpftool/gen.c
>>> @@ -472,7 +472,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
>>>    			continue;
>>>    		if (bpf_map__is_internal(map) &&
>>>    		    (bpf_map__map_flags(map) & BPF_F_MMAPABLE))
>>> -			printf("\tmunmap(skel->%1$s, %2$zd);\n",
>>> +			printf("\tskel_free_map_data(skel->%1$s, skel->maps.%1$s.initial_value, %2$zd);\n",
>>>    			       ident, bpf_map_mmap_sz(map));
>>>    		codegen("\
>>>    			\n\
>>> @@ -481,7 +481,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
>>>    	}
>>>    	codegen("\
>>>    		\n\
>>> -			free(skel);					    \n\
>>> +			skel_free(skel);				    \n\
>>>    		}							    \n\
>>>    		",
>>>    		obj_name);
>>> @@ -525,7 +525,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>>>    		{							    \n\
>>>    			struct %1$s *skel;				    \n\
>>>    									    \n\
>>> -			skel = calloc(sizeof(*skel), 1);		    \n\
>>> +			skel = skel_alloc(sizeof(*skel));		    \n\
>>>    			if (!skel)					    \n\
>>>    				goto cleanup;				    \n\
>>>    			skel->ctx.sz = (void *)&skel->links - (void *)skel; \n\
>>> @@ -544,18 +544,12 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>>>    		codegen("\
>>>    			\n\
>>> -				skel->%1$s =					 \n\
>>> -					mmap(NULL, %2$zd, PROT_READ | PROT_WRITE,\n\
>>> -					     MAP_SHARED | MAP_ANONYMOUS, -1, 0); \n\
>>> -				if (skel->%1$s == (void *) -1)			 \n\
>>> -					goto cleanup;				 \n\
>>> -				memcpy(skel->%1$s, (void *)\"\\			 \n\
>>> -			", ident, bpf_map_mmap_sz(map));
>>> +				skel->%1$s = skel_prep_map_data((void *)\"\\	 \n\
>>> +			", ident);
>>>    		mmap_data = bpf_map__initial_value(map, &mmap_size);
>>>    		print_hex(mmap_data, mmap_size);
>>> -		printf("\", %2$zd);\n"
>>> -		       "\tskel->maps.%1$s.initial_value = (__u64)(long)skel->%1$s;\n",
>>> -		       ident, mmap_size);
>>> +		printf("\", %1$zd, %2$zd);\n",
>>> +		       bpf_map_mmap_sz(map), mmap_size);
>>>    	}
>>>    	codegen("\
>>>    		\n\
>>> @@ -592,6 +586,24 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>>>    	codegen("\
>>>    		\n\
>>>    		\";							    \n\
>>> +		");
>>> +	bpf_object__for_each_map(map, obj) {
>>> +		size_t mmap_size = 0;
>>> +
>>> +		if (!get_map_ident(map, ident, sizeof(ident)))
>>> +			continue;
>>> +
>>> +		if (!bpf_map__is_internal(map) ||
>>> +		    !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
>>> +			continue;
>>> +
>>> +		bpf_map__initial_value(map, &mmap_size);
>>> +		printf("\tskel->maps.%1$s.initial_value ="
>>> +		       " skel_prep_init_value((void **)&skel->%1$s, %2$zd, %3$zd);\n",
>>> +		       ident, bpf_map_mmap_sz(map), mmap_size);
>>> +	}
>>> +	codegen("\
>>> +		\n\
>>>    			err = bpf_load_and_run(&opts);			    \n\
>>>    			if (err < 0)					    \n\
>>>    				return err;				    \n\
>>> @@ -611,9 +623,8 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>>>    		else
>>>    			mmap_flags = "PROT_READ | PROT_WRITE";
>>> -		printf("\tskel->%1$s =\n"
>>> -		       "\t\tmmap(skel->%1$s, %2$zd, %3$s, MAP_SHARED | MAP_FIXED,\n"
>>> -		       "\t\t\tskel->maps.%1$s.map_fd, 0);\n",
>>> +		printf("\tskel->%1$s = skel_finalize_map_data(&skel->maps.%1$s.initial_value,\n"
>>> +		       "\t\t\t%2$zd, %3$s, skel->maps.%1$s.map_fd);\n",
>>>    		       ident, bpf_map_mmap_sz(map), mmap_flags);
>>>    	}
>>>    	codegen("\
>>> @@ -751,8 +762,6 @@ static int do_skeleton(int argc, char **argv)
>>>    		#ifndef %2$s						    \n\
>>>    		#define %2$s						    \n\
>>>    									    \n\
>>> -		#include <stdlib.h>					    \n\
>>> -		#include <bpf/bpf.h>					    \n\
>>
>> I noticed that in patch2, the "bpf.h" is used instead of <bpf/bpf.h>.
>> Any particular reason for this or it is a bug fix?
> 
> skel_internal.h didn't include bpf.h directly.
> gen_loader.c needs it. It does:
> #include "skel_internal.h"
> because gen_loader.c is part of libbpf.
> libbpf sources cannot do #include <bpf/...>
> 
> If skel_internal.h did
> #include <bpf/bpf.h>
> there would be a build error:
> In file included from gen_loader.c:15:
> skel_internal.h:17:10: fatal error: bpf/bpf.h: No such file or directory
>   #include <bpf/bpf.h>
> 
> Hence #include "bpf.h" in skel_internal.h
> So it works for libbpf's gen_loader.c and for generated lskel.h too.

Okay, now I understand, previously <bpf/bpf.h> is in *.lskel.h file, 
which has nothing to do with gen_loader.c, and now the bpf.h header
needs to be in skel_internal.h which will impact gen_loader.c compilation.

Acked-by: Yonghong Song <yhs@fb.com>
