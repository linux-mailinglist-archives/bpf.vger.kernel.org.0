Return-Path: <bpf+bounces-3162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794E973A613
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 18:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB4F1C21167
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4BA200A8;
	Thu, 22 Jun 2023 16:27:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB3D8494
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 16:27:44 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D5F1BD9;
	Thu, 22 Jun 2023 09:27:42 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MF5TUh017775;
	Thu, 22 Jun 2023 09:26:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=CLyTbworMchDlx4OcnrXwOp5NwyzE2wxp1hMHiNOa7c=;
 b=elRayK9BdQL/dl4aAfNZx4GgsfaMSMnz7EGApfy2cJ9r4iz14DELWq/YrvagqJjcKRUs
 kJPzNh26TbTRQKObxY9Ht3Vvb5dygpvMFd13XBjAuJRCz7wNwCdeYLtUNu1nrtmT/bx2
 57/Y2mO6/lPZGosS1Ugs9p8uS0wr95N7eM1CLWCbt0DrIlqfDN7fxMqNwvlJI4IaHeVv
 QsTXVSwt5/Hs4MM4ChDol97WbZDKKawSXiWp32gJvbBKjvO7Q/RVrwL2nUpoU5EHWwjS
 KmiBE9RS6lXjmU2hunwir8K/nTKYFTF35NQH86mAtcBV5UnYwpgUMNE2mzbzZbdlSDTk Dw== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rcn2ct83d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jun 2023 09:26:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdaRa31mfb8VOx5swR64u2XbkXqHp6d2H3HH34tw5X4DMrFwInXGm52Qhj9+FOiiRhzwrmsiqPi7mJ5K8d3fdZYMebrhIiZF1NWNLNR5HGLH5uMLmhxOcd00X+gRYs68qznOSUpKsqDKVN5jzsVJCBuhT77sBHucdwzy80AbDWLFh/zE8TmRo+JQbQONnzdr/2rHUaidJMq4H4DorLSpNrZi3bux3h6m1nXPFqNLZ8CikYwfQsK/D0flHmwMnyoC5vFgtUW45NAckinucflh1PnOLC9Q0PueQnztZJJDAE6f5RI+CLLceStiNxP8tnObhq/3GxRvxuyfVyno5h+PfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLyTbworMchDlx4OcnrXwOp5NwyzE2wxp1hMHiNOa7c=;
 b=XHQPGwaVpdwMYU8Kfq03Fg6r9tZ/FOy06iu2tYUaz3guVHpy4F/AHEYll7JiwfKYnT/02LjgJSaroICttTDjKvukq/GGM99IrtiIrahg2MMsXPHlGf+Vb5jB9jQpSUvFfCNqdCK3Tby2Prq4ebv42AT4otYKsQMxltc7n1ewmAjRrdVqTPDBI9DmjdI/2WhHIauCIrppDeCNHfx0nwOMkWJi2PaIHsehYtv8Np0XlkhxspfBbwaYaTftFyvNvVNZQ4goccbvVeX79N5GMgV8JUiWu33saNyE4pPk8jq7m2J5lCqAv0C+a2Y5cmA9W+r4z9X1TZdU6HGJ3D71m4JJEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN6PR15MB6002.namprd15.prod.outlook.com (2603:10b6:208:475::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 16:26:46 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 16:26:46 +0000
Message-ID: <c59ab814-32d2-963d-e098-7965f6ff1441@meta.com>
Date: Thu, 22 Jun 2023 09:26:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next v5 2/3] bpf, x86: allow function arguments up to
 12 for TRACING
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>,
        "menglong8.dong@gmail.com" <menglong8.dong@gmail.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
Cc: "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com"
 <sdf@google.com>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "benbjiang@tencent.com" <benbjiang@tencent.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Menglong Dong <imagedong@tencent.com>
References: <20230613025226.3167956-1-imagedong@tencent.com>
 <20230613025226.3167956-3-imagedong@tencent.com>
 <ca490974-0c5c-cfe9-0c6f-3ead163e7a7b@meta.com>
 <7a82744f454944778f55c36e8445762f@AcuMS.aculab.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <7a82744f454944778f55c36e8445762f@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:a03:338::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN6PR15MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: df7a69f4-6998-4883-6f3c-08db733d78b6
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nq9NZwtj9Q1aT2lWwHxMQlEL2NyM8gmiv6Q1MtJxN13I+W3jrak0qZeGzcgreOUr4J4Gv/LE4Q36WW5S1R4fLYV6fQxxd9hh4rU/PoiBp2XBYHyuPRRd6W1skCZuaAXjipxeLw6ZX0wDrvGaFP5FqV3ofHoKduLuETpRHY+AMr7zvDCdzy9pwk55Alhjkjg8g78xe83AGuX7KdByHII/y2SaTYQ5upHdR7HqO/tYSfIBjv06iaJDhj6yFSLYOHuVeSuXJ+DhmdPXlrSanfGuX+iLkoCkflqyzWoan70h88hC6eXo4npEdZESOLpQ64B68xCVaiarxGsc801OaT4wvPaXDRGl/kFRLu7hlpSIlcPDloh7/RZjh8B3WV/Ye/pl+Xbe67mIc7M70lUN6Yez7KKmIZ3SDLsCs5LJCISZN5HIDxF5iu+zFwB25b1lXG3680chjBk1/GEXHj4ddext5N4uJRRsL/yfkt7WR7b0vx9ctNe5ZYGnhrQDU/0dXOaPhTkNbHTbgiCshttx7SvaC10Ad6Afe67q5ipMABvfcA3zi8O5FHaG4jiWatGSS9oOGairhWLcOsCzHe5KjPSilIbJLqAwYaA9n4KcKcILElnVw02ZP9I5Qd8oglEQhO2rDh/e+HNjJ7gkdqBZCxO2tw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199021)(7416002)(5660300002)(8936002)(36756003)(8676002)(38100700002)(2906002)(478600001)(6666004)(6486002)(186003)(31696002)(110136005)(54906003)(86362001)(2616005)(31686004)(53546011)(6512007)(6506007)(4326008)(66946007)(66476007)(66556008)(41300700001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dU5xY0dGbElkTG8vRnJlckd3blZaM3pkUCt5dDRUdG8wMVg1WFowZW9QTFhw?=
 =?utf-8?B?anFDSFp1SnhENGpXeC8xVGNrY1FqYWVvRUpNR2dSQjZ6SHJpdDhkZ3BoMGlB?=
 =?utf-8?B?M0NtVDluR3VIV1V2c2hHMTRlZ2JhaGQ0dTJ4aGg3L21WRTZNTkxDM2gyUFFs?=
 =?utf-8?B?TkdYWWoxN0s4UERJVkJCcWpUUEZ6S3VlKzF2ZU5oYUZKUS92RFpGV0hQUnZN?=
 =?utf-8?B?d1o1Y2hCalZYUlZMd21tK3ZhTUZvT0hDdkd5eEN5dEt3SndDeVZxbUlLUWRx?=
 =?utf-8?B?RzVtKzF2YlRlQk1PS2JvdWU0d2J0M1ZkNXlCWXRnV0pYSFZHcHNFSzdsVVc1?=
 =?utf-8?B?c0svY0daZTF1WlVTTEJKUlVTNjJGZ29jRVd2Y2RYaTROY0NLZ0R0N2p2a3Bs?=
 =?utf-8?B?aEJOY1RqMFhFSDRVMkhrOWRvV3VRYnZRY05DMjZrekxEcUVpZ0dyQ2p2YjZq?=
 =?utf-8?B?Ry9XdWJUdlFSVmJmMVVvOCtNOGpVak5PZkxGWUNvUXJRNWlaT1RFUGJ3ZFAx?=
 =?utf-8?B?cThMeEtyZXZDS1FvY3VCRFNYQytBQzZBWDBsODdYZkdmL0t6d0NHbEp6M050?=
 =?utf-8?B?eDRVKytRREpFYlhlc29CeUpNN2ptVVkwRVozSi94REFJMjZQQ2JqWFBUamlj?=
 =?utf-8?B?eUtoS2tkOEtoMHdKYitucFBjcTF0ZjZ6TFAvUU5JRTdCWEc2c1hsR2xmdUZ2?=
 =?utf-8?B?ckdyL3lqb0VDZ0V0c09Ed1Z4b1dPeDRjZUhxanJuVGpTVFkwT2tWOWMrbjh6?=
 =?utf-8?B?a3hUVmhQcGdCM0NmSnlObjFVakczYUtTVlNHcGZtSUI1WGY2OEpEanNQY0lp?=
 =?utf-8?B?d21la0ZSR3JOZEFud1J1VGNKb3dLV3ZMcXU1NXR4cjZsdWdTSU9rQkowMk4v?=
 =?utf-8?B?MWo1dVRKb0pyQ1BkVEtDZzYrZlU4MFdTeUN4L0RnTWk0d25La3dIZ2hSdmQ1?=
 =?utf-8?B?UG9xSU8xc1RxSUQ3QSsxTm1LNi9KNU55SXZYbHhZMDU1WjNMY040MURlWS9y?=
 =?utf-8?B?SE9aUWdFSHQ1V1UyQmozdkgxWjRrK0JWY0RTVGVXdDRaR2hMeHR6dTRrNVNn?=
 =?utf-8?B?TmJob2FDQ0NkV1ZBUXN3RUlRcE0rRHd2SVg0NGxaT252R25ETXdKdnhQV2J6?=
 =?utf-8?B?K3pnMit1ejMrUU5aZEZ0a2JQZTVBOE4xV0xxVkJ1YnJmUExWblpWTUVVOUR2?=
 =?utf-8?B?UUpTZ2o4cnlPdEw0WGNTOHBDZ1BIYmlyTWtlbXpiYWg2N3paQ2x6T2duM2Uy?=
 =?utf-8?B?bXA5RHFWaVFYQWs5TERvUWdRZjNqWTFhV2V1OXhlb0sxVkJnMXZjWkZhOWwy?=
 =?utf-8?B?S3FGMTNzNFNmOE4xbGpqUVE5OUxQVVRpY2JXR0dnQjBOYlFoaHF0T3ROUzRM?=
 =?utf-8?B?bmdsbFgrelhNWmJ1blBNMnZrMFI1bmNlZ2tDc1hlMmtEaHBCU1FUbHZVRUVt?=
 =?utf-8?B?Z1NKbHZtZFEwd0ozR2N1dmJpRXdlcGtmUk42Qmo3VjhNM1BuNGUxaUxYeTBa?=
 =?utf-8?B?YVhHRElQM3BYSHBxdUUvUmRKeU5zS05kT2ZDRU5XT3pJc1BHeDNyVmwxb0NL?=
 =?utf-8?B?M2ZaSk91cXU1RWFoWlFMN0lNcllKeEFTUnRuV2RnZjF1bzVId0tob0FORmVH?=
 =?utf-8?B?R2VadlhVWU84WGl5V1dvdzYvT2dlSXhGbnNHSUJRdlp2eXhwR01kUHA1UTdm?=
 =?utf-8?B?NGl2MFg5YWxBUGUwR0tQcE5GL0RXUlhycyt5Uys5ejlZLzNZNGxwUW9lMk1J?=
 =?utf-8?B?TmtENGUyZUlYV1Fpd3JodGRNVjBFdkdQSWxlbTROSFhhaUZOQ1BoUEdJVG1p?=
 =?utf-8?B?eVkyTUFNcVR0aXZlZVBFeHo4QmlPWDRmZ0FBelNpN1ZNVXlBZ0ZCZ0xDY3BP?=
 =?utf-8?B?S1NzMlJMKzhEc0o4THNzSHA3dGZrdzFDWDkrV0dmNmxOdFhsRTdWbC9kZWhX?=
 =?utf-8?B?UkM5TGhndHVYNFcvMTQwQ3dHK3lSTEt5dm9weDR6QS9PaTA2NXpyMXhaMXF6?=
 =?utf-8?B?WmtSenloM2pReXdFY0l1dWV0NmxuQWZ2eCtRWDgrRjRIVGkyYUsxSlVSWk44?=
 =?utf-8?B?Vyt2YnZlZFl1VVRHWmVWSS9YeUIzZnVIa0c1dUpvL2FuMkxRM0I4ME1NWms0?=
 =?utf-8?B?WFhrb3RCUlRTTFBwNHVVZVdCNnhhdHdQaFZZUVpSUDR0Q1NDSlNWUmNZN08y?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7a69f4-6998-4883-6f3c-08db733d78b6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 16:26:45.9740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVOJ73yvFcGD6YS4eyHJcrM5i3WEpY4kmCuENuR7yNLHqKuAFC9jpE9+h4JrFp5y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR15MB6002
X-Proofpoint-ORIG-GUID: GLotAy8hc79X671MWQGcHaUJHUOexgd7
X-Proofpoint-GUID: GLotAy8hc79X671MWQGcHaUJHUOexgd7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_11,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/22/23 2:06 AM, David Laight wrote:
> ...
>>> +	/* Generally speaking, the compiler will pass the arguments
>>> +	 * on-stack with "push" instruction, which will take 8-byte
>>> +	 * on the stack. On this case, there won't be garbage values
>>
>> On this case -> In this case. The same for below another case.
>>
>>> +	 * while we copy the arguments from origin stack frame to current
>>> +	 * in BPF_DW.
>>> +	 *
>>> +	 * However, sometimes the compiler will only allocate 4-byte on
>>> +	 * the stack for the arguments. For now, this case will only
>>> +	 * happen if there is only one argument on-stack and its size
>>> +	 * not more than 4 byte. On this case, there will be garbage
>>> +	 * values on the upper 4-byte where we store the argument on
>>> +	 * current stack frame.
> 
> Is that right for 86-64?

yes,

> 
> IIRC arguments always take (at least) 64bits.
> For any 32bit argument (register or stack) the high bits are undefined.
> (Maybe in kernel they are always zero?
>  From 32bit userspace they are definitely random.)
> 
> I think the called code is also responsible form masking 8 and 16bit
> values (in reality char/short args and return values just add code
> bloat).

yes, it does. For example, if an argument has type u8, so
x86_64 might only put a u8 value into 1-byte subregister
and rest of if is undefined. This is what happened to bpf program,
   (1). the whole register/stack is saved to 8-byte stack slot.
   (2). in bpf program, the 8-byte stack slot will be read
        and then cast to u8, so the compiler will do proper
        left shift and right shift to get proper value.

If the argument is u32/s32, the 32-bit subregister 'w*' could
be used without left/right shifting (similar to x86_64 subregister).

So we should be okay here.

> 
> A 128bit value is either passed in two registers or two stack
> slots. If the last register is skipped it will be used for the
> next argument.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

