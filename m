Return-Path: <bpf+bounces-5422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABC475A69C
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 08:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6DC1C21308
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 06:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761A714299;
	Thu, 20 Jul 2023 06:37:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBA9383
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 06:37:23 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2319B273C
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 23:36:55 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 36K34H5a023317;
	Wed, 19 Jul 2023 23:36:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ZVbleUG0U5I81/5cL0hhjZzjSTrkaEXgGgHmwZsriOM=;
 b=D4Jv1TjJaEdauKaWo7D5hp5unhBz6PP0HDcvCLRH5e8c+QybTpTU6NOHCpSABRSDzHIZ
 0fkYFLZEE8xB8CmCPTDHN3Z/CtDk1tuENA2AC6vjNenwzvOH/a75a4q6f05q0lUmRM2c
 vD12xVvWWdQs/eeHRgRYIHuvPGKjVdMLuckOVG7QVxnOA6SdvR6wnkEdb7ujD8ANWbkO
 4kxAxA4I1kuyBZnU/OL/9koX+n5ZS/OiqmjlmYBAa7U3YpQYolEX6yf1mPfYLWFriYNC
 BWhSkhF7g5cY8kGlcyCUd+/LfiDaIvOx5NtG3kuOdG8YSMbu/1Z58zqXqeCsqIM3N3Kx +g== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
	by m0001303.ppops.net (PPS) with ESMTPS id 3rxbxv0ygp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jul 2023 23:36:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RerH12ZE80NlQVzpjpO1Rz5OmxitKf4D5YQUE3n6GGOQ5Rg3TjndzWCUah8I3D5HPRIVH9XiXJqFhfPcGp/i+ssgoiNfLLhZx4Egebotg7jIg4hWRXfEAYCr8Fk1m+qU4fWvcPMWIf1d2s2jv69JuXZwHKlJcCGSpNhP/Ij2xDgIcsuW+YRSAr6yPggS6ZkMujEyK4Atr3W8PJos0NsQ9CPVZH7vzv7UPWCN0Oorc6G8s/noYhrFSX6oC5Br8pSjlUr9pzZ5N7w6scty0QTVAhdmwzdfQ9LogANWgALeY58qt3Q/RNYO4xJKGAsFOqFXkzOBmF9hZT+B4xSWSEZhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVbleUG0U5I81/5cL0hhjZzjSTrkaEXgGgHmwZsriOM=;
 b=XCEIkiclemRDMAcyiSZHD6nE2lkqLDZRNQiEAkTbVvitXKo/fhl5JWPvNErPtSxrUEUNVBpoZKqGZN6kkJoYHx2WARkqZpBfnXz4Luzow9EyWJHGwC0p283JPXeTJLHuONQ0vHRQGUyWsPzFI+iRUbksjdn30GAbd2VVvTaYSABcvhKzofwmurGHRjoo3bEoB8PulNzwMsS6WKQxBP0uB9KoojaZ/cZOcxp75Daz2G+qJVFWNw3enJldBuwULg16MdhIm/z9pxRzJ7sxOsNQ/o3YcQ/d0T2r3tNFgxY/L/B99H5PEZs8wH8tXbJxuxqznF0rMJgQ/t999oVVuuYnLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by IA0PR15MB5935.namprd15.prod.outlook.com (2603:10b6:208:40e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 06:36:08 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785%6]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 06:36:08 +0000
Message-ID: <02e666bf-82a5-9b80-0cc0-2c50b8da5126@meta.com>
Date: Wed, 19 Jul 2023 23:36:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v3 11/17] selftests/bpf: Add unit tests for new
 sign-extension load insns
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
To: Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@ietf.org, Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com
References: <20230720000103.99949-1-yhs@fb.com>
 <20230720000202.109554-1-yhs@fb.com>
 <6be0dc44-c781-a3e9-e2b5-f26e3ffa42e8@meta.com>
In-Reply-To: <6be0dc44-c781-a3e9-e2b5-f26e3ffa42e8@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0119.namprd05.prod.outlook.com
 (2603:10b6:a03:334::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|IA0PR15MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5135d3-8604-4346-2398-08db88eb998a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2cmbz4IHWwhyq39g+kJ2w1b2AtBwlbtWfuCaN75gvMeHapSHPCTQcqlWfiuxK3N4kre0eU5tw7NqZEOWYLrSHpPZEDWqmXc4FLa/M4fJQf1RKmKKyGF+7FO5Cn4MoNlZgUYLAfZLClMFaZK69bc9OktM/hqou4oJDpzYVU04Br+IGhmplZvxFv2qPN5nxR1aX6FU0WV0ZhEFkOVRSjTreNtaRRSgGRz39cOaKFYtWIRkEpWB2khgwAorryycq6RBEwMqwW5IqkEs8SdI5iwub7V1h6pYhxsjsDHcA+MjhE+hnB31yI3IevDDTvZ5QER4a/xNhqXILPPtZVSbhW8Bq68DIAGlx6hXKYfwb2aYNcsbflFHen6GBwX42XLrrp/5ObOrzZtidUKzvN2SD7Ab7VnXa/02m3hOPEG/LoyQ6m4dP0oLOhZa8WU1X5fhl+HJPJ35yW3BG4Tx5Z6xOnclQOA162UxODgdYSgjU6Wla3Z/Mm4P3/jy65693Mlc3bjlOLisw8UiVjtG+gI0m5e5T76ozqWP5ABe6IBtuTfTkPpjxqY1YbqAfOViEsHJG/y5CNHuJgIDnZyo9oCh3thJ4BTRWTVNLi3YszKbaTB3GY85kgG4fKQ+BW2wGg7XNlSL
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(2906002)(38100700002)(6512007)(6666004)(6486002)(966005)(2616005)(83380400001)(36756003)(6506007)(186003)(53546011)(31696002)(86362001)(478600001)(4326008)(31686004)(41300700001)(8676002)(54906003)(8936002)(66476007)(316002)(66946007)(66556008)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WXZNQXljNkZZc0JSVTJ6c0k3dW5sM2g0T0xITXJvNGgrWDB4djBGWW9ZVkpy?=
 =?utf-8?B?U2F4ZFZMTUExeDhJRC9NZy9SalBGVUw1bC8xcFJMMnR6cDB6MFNKU0RSVGJ1?=
 =?utf-8?B?UkFYM1NsQmxwd0ZBN2hwZXNmb05BVHFob0pLaGVVWXRLQmt0dlBYN0wzclV0?=
 =?utf-8?B?OEZLeVVZd25RUmJ5cEFGMTF5ZGloZDNxTys1eXM5engrbk9mbG5QSndNRzV4?=
 =?utf-8?B?OE9CdDJ0TThsM1llcEZKUmNNY0NrbEtTbjRLUDBaNFlJa2NRMUdzYnNhMXhJ?=
 =?utf-8?B?YzNPNjhuV1lMMlN6ZlhWNlYrYjQ0MTBlZGU4UUFZdEk5ZG5XYWVKOWQwSk1i?=
 =?utf-8?B?TnpISTVXMnA3cm5xcnk0M3o4UkhsN2FyTWRXVXBjaVhybGhZV1BWL2ZqWFBj?=
 =?utf-8?B?MkRDUHQvVUdTY1NsM2NzaVJNMGdPdFZjM0VkRjNQelhmOVhYOHh1OXh1ZlpM?=
 =?utf-8?B?THM0UFUzdFROcFhvNXp3TVdtK1B3bGwvazFXL1dRcW9ncmZhaFRZSURoRUV6?=
 =?utf-8?B?R3ZaWk93S0E1MWh1Nmlhbm83NnIyTUhNM1E4REcrS1V5b1ZnLy80WU5aajRs?=
 =?utf-8?B?bGY3WmFTTUNtRi9ONmliTUdTNGt6aUFLREJUeUZrR2p1WG5JSzhEZ1hXUXNE?=
 =?utf-8?B?VVBSbHAzbS8zMjlXdFVxbzVyOG1BdyszT0xmTVVHVTNtb3NLM2tEdU50Y2Rt?=
 =?utf-8?B?aFhWVllReGpsclJ5T2hmcVlOTkw5UUxSdjdQKzI2eVlPWlBtUWRuMzd5Z2FI?=
 =?utf-8?B?bXFCbkVwemdoYzcyRkRER0xBcFhIVG9QT0hzOTNjcFFSbzk2ZHFYYWwrYlc3?=
 =?utf-8?B?bG1TcVZYTXJBWUdocVcrV3FEOEJHL2V1SlJRZXRSRXVpVlZnN2kwY2xLUHRZ?=
 =?utf-8?B?ZG5mUkMzTHhHMC9rdVRBMUdlWDZUUDE3VTN6emdST1IycGJOam1YVE1nMDhx?=
 =?utf-8?B?YkFPL2RyREt0Q3UyQVdEeEFPTG52UkNRRjIzdUMzeHJuTitXZGZqNmMvK01m?=
 =?utf-8?B?ZUNLNm1YZjZ1RTVHNjZ5d2FqelEvaDJxeDFsSVViU1YrSU1uZ3h1US9ka1Qv?=
 =?utf-8?B?ZnRNaWJ1M1VnNzdNaW9rOWt4U3h3OHoxZXQxcndDLzU3SWxYbWdhY0g4SWcw?=
 =?utf-8?B?STBnMG9hb3huMnZQUTBQNjU2NDI4NFd4SWlTRzVDeDd3b1A0UmlOY1RwUUhG?=
 =?utf-8?B?UHlFNlIvUEVqYkREMVZ5NmFQbWhvcG9xNEc0RndUSkNXSU00Y1kyNkV1Qk1S?=
 =?utf-8?B?LzlUQlhxeVh2TXVJSXQxNmIrVkVHUzdCYk9QWVZOalc2OW9BT28yMnppNzRX?=
 =?utf-8?B?TzhKcjZjVjlHNFBWNXdoTkFFS3o4bGZNUVZLanh5YTBsSkhzeEFlRzR0Vk9n?=
 =?utf-8?B?RHNiRS9JR1V4cWYyUDREUHFjWE8vVzdkQXlpVW52ZjlKMUhWT3o0SUhBVm1D?=
 =?utf-8?B?d2g4K3BhcmdIVlVuVzI3eGxkSEtSR0RsenM1aHFmQXhlQWF4cXdjbmNNR1JT?=
 =?utf-8?B?WnZCeVB1NTJGd3ZEMXFwNWg4dk9tY2tDdm9FU2QzelJWUUh4ZCtWRkdSRUUz?=
 =?utf-8?B?UkU2Nm9vZG9aZDJBTzkzQnVjK1hMTFU1bkZ4bHg4ZytTUzZWQ0pCVm02bXNH?=
 =?utf-8?B?d2hXUHpFYzJnM3lZWVB4TjdkUDA0ZUd4SDBWbGRJOXFhSEtmYjZBbTErS2M2?=
 =?utf-8?B?V0RSTTV6LzBlWStrSWhRM09GRFIwR0pib0RCVzMzR25ybWJEZG5xT1RiVmQv?=
 =?utf-8?B?ZG5sQ2NzUWhaT2oydmhmWlF0eHNyK2ljbnpHOHg1MUcwL3llSUhxYUR4Zzhq?=
 =?utf-8?B?RGpQUzd2YWlIRG91Q1R0eWw2UTRyOUtDakw0RUhZVTdhNnJUdlZvKzN1bVFX?=
 =?utf-8?B?SlM1T3hIQ3lCZUVuZFN3cUxrTjlUWVJSWUs4OUZuNmpOS1F6UVd5NE1TWHBD?=
 =?utf-8?B?NVdZRTlmRS9YOEdSQktUQTF3N3pjcVRSNGo1NHlCZjl4dnhnVHN3ZmYwYml5?=
 =?utf-8?B?SWdRM25rNFRIUnBsdzBSMkkzTm9lb3h0K1N3cnJ6amZ3VEhPREJ5clBpKzhX?=
 =?utf-8?B?S1BzVnRaQlJOYjZCYkFpQjcxZi9Nb3hSZVdDU2wyMmVScDVHY2JRNVl1QjVs?=
 =?utf-8?B?TmNzWnByRFRlYjFCTXZYcHdvazNEWkdXK2hWQVVkTjlLN0tkUU5wVXFRWUhX?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5135d3-8604-4346-2398-08db88eb998a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 06:36:08.0202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W53cIqMklz+NoNGxLFHUhZDtn7Toe7cOSYHj/GguFzFcpzsglaFLutdDEUL9WNEc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR15MB5935
X-Proofpoint-ORIG-GUID: h9-cMBSpEdBFTTpeHVQupH9Sck22sseM
X-Proofpoint-GUID: h9-cMBSpEdBFTTpeHVQupH9Sck22sseM
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/19/23 11:31 PM, Yonghong Song wrote:
> 
> 
> On 7/19/23 5:02 PM, Yonghong Song wrote:
>> Add unit tests for new ldsx insns. The test includes sign-extension
>> with a single value or with a value range.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   .../selftests/bpf/prog_tests/verifier.c       |   2 +
>>   .../selftests/bpf/progs/verifier_ldsx.c       | 117 ++++++++++++++++++
>>   2 files changed, 119 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/progs/verifier_ldsx.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c 
>> b/tools/testing/selftests/bpf/prog_tests/verifier.c
>> index c375e59ff28d..6eec6a9463c8 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
>> @@ -31,6 +31,7 @@
>>   #include "verifier_int_ptr.skel.h"
>>   #include "verifier_jeq_infer_not_null.skel.h"
>>   #include "verifier_ld_ind.skel.h"
>> +#include "verifier_ldsx.skel.h"
>>   #include "verifier_leak_ptr.skel.h"
>>   #include "verifier_loops1.skel.h"
>>   #include "verifier_lwt.skel.h"
>> @@ -133,6 +134,7 @@ void test_verifier_helper_value_access(void)  { 
>> RUN(verifier_helper_value_access
>>   void test_verifier_int_ptr(void)              { 
>> RUN(verifier_int_ptr); }
>>   void test_verifier_jeq_infer_not_null(void)   { 
>> RUN(verifier_jeq_infer_not_null); }
>>   void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
>> +void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
>>   void test_verifier_leak_ptr(void)             { 
>> RUN(verifier_leak_ptr); }
>>   void test_verifier_loops1(void)               { RUN(verifier_loops1); }
>>   void test_verifier_lwt(void)                  { RUN(verifier_lwt); }
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c 
>> b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
>> new file mode 100644
>> index 000000000000..4163e9ffffe9
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
>> @@ -0,0 +1,117 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/bpf.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>> +
>> +SEC("socket")
>> +__description("LDSX, S8")
>> +__success __success_unpriv __retval(-2)
>> +__naked void ldsx_s8(void)
>> +{
>> +    asm volatile ("                    \
>> +    r1 = 0x3fe;                    \
>> +    *(u64 *)(r10 - 8) = r1;                \
>> +    r0 = *(s8 *)(r10 - 8);                \
>> +    exit;                        \
>> +"    ::: __clobber_all);
> 
> Looks like latest llvm17 is okay with the above asm syntax
> but llvm16 is not okay.
> 
> https://github.com/kernel-patches/bpf/pull/5377
> 
> Will check and fix the problem in the next revision.

I may need to guard this and other similar tests
with llvm compiler versions.

> 
> 
>> +}
>> +
>> +SEC("socket")
>> +__description("LDSX, S16")
>> +__success __success_unpriv __retval(-2)
>> +__naked void ldsx_s16(void)
>> +{
>> +    asm volatile ("                    \
>> +    r1 = 0x3fffe;                    \
>> +    *(u64 *)(r10 - 8) = r1;                \
>> +    r0 = *(s16 *)(r10 - 8);                \
>> +    exit;                        \
>> +"    ::: __clobber_all);
>> +}
>> +
> [...]

