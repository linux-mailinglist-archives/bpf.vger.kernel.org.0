Return-Path: <bpf+bounces-5421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7638575A697
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 08:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955231C212D2
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 06:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1D214273;
	Thu, 20 Jul 2023 06:37:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D26383
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 06:37:21 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60B62699
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 23:36:50 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 13088C151990
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 23:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689834978; bh=jnk1G8RkmKpET46CAHg62+9GP/IKwX44Xt/x1Nsl0vI=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZtdDutaDiBhDBUY9zjoBeXdTh3ighy09vszcWwQfNB21AopPg25qYBLpM0GKrh8bA
	 ApROP6FPbKV22qNzho14jbf5xLiGp2VKIImLEbALYkGnPD+TQtmB+MWsFJDXlcjybC
	 e99u2WprzVa6Lr1KOKq7gx7IsYZ9kUDdvL/oUWIY=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id DB30EC151067;
 Wed, 19 Jul 2023 23:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1689834977; bh=jnk1G8RkmKpET46CAHg62+9GP/IKwX44Xt/x1Nsl0vI=;
 h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=rExsiLw28E18cXPf9NX5MPFwMayJUmNoWd/GqqRm/2QFZl3zI2sn28fup+zZKoew1
 xZsC+BkeTPrrp/z2RDYj/C25AtR1VG7zt+UMziUvddUcBcD7hqh8/KCxfauQcyo0vw
 CACHOT3oi7EoR3kTQQI4YdMfJamN/1A25zXTuQ+U=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id C313DC151067
 for <bpf@ietfa.amsl.com>; Wed, 19 Jul 2023 23:36:16 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.095
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=meta.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id scIWucC--eL0 for <bpf@ietfa.amsl.com>;
 Wed, 19 Jul 2023 23:36:12 -0700 (PDT)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id C14E8C14CEED
 for <bpf@ietf.org>; Wed, 19 Jul 2023 23:36:12 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
 by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 36K34H5a023317;
 Wed, 19 Jul 2023 23:36:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ZVbleUG0U5I81/5cL0hhjZzjSTrkaEXgGgHmwZsriOM=;
 b=D4Jv1TjJaEdauKaWo7D5hp5unhBz6PP0HDcvCLRH5e8c+QybTpTU6NOHCpSABRSDzHIZ
 0fkYFLZEE8xB8CmCPTDHN3Z/CtDk1tuENA2AC6vjNenwzvOH/a75a4q6f05q0lUmRM2c
 vD12xVvWWdQs/eeHRgRYIHuvPGKjVdMLuckOVG7QVxnOA6SdvR6wnkEdb7ujD8ANWbkO
 4kxAxA4I1kuyBZnU/OL/9koX+n5ZS/OiqmjlmYBAa7U3YpQYolEX6yf1mPfYLWFriYNC
 BWhSkhF7g5cY8kGlcyCUd+/LfiDaIvOx5NtG3kuOdG8YSMbu/1Z58zqXqeCsqIM3N3Kx +g== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
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
 by IA0PR15MB5935.namprd15.prod.outlook.com (2603:10b6:208:40e::8)
 with Microsoft SMTP Server (version=TLS1_2,
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
Content-Language: en-US
To: Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 bpf@ietf.org, Daniel Borkmann <daniel@iogearbox.net>,
 Fangrui Song <maskray@google.com>, kernel-team@fb.com
References: <20230720000103.99949-1-yhs@fb.com>
 <20230720000202.109554-1-yhs@fb.com>
 <6be0dc44-c781-a3e9-e2b5-f26e3ffa42e8@meta.com>
In-Reply-To: <6be0dc44-c781-a3e9-e2b5-f26e3ffa42e8@meta.com>
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
X-Microsoft-Antispam-Message-Info: 2cmbz4IHWwhyq39g+kJ2w1b2AtBwlbtWfuCaN75gvMeHapSHPCTQcqlWfiuxK3N4kre0eU5tw7NqZEOWYLrSHpPZEDWqmXc4FLa/M4fJQf1RKmKKyGF+7FO5Cn4MoNlZgUYLAfZLClMFaZK69bc9OktM/hqou4oJDpzYVU04Br+IGhmplZvxFv2qPN5nxR1aX6FU0WV0ZhEFkOVRSjTreNtaRRSgGRz39cOaKFYtWIRkEpWB2khgwAorryycq6RBEwMqwW5IqkEs8SdI5iwub7V1h6pYhxsjsDHcA+MjhE+hnB31yI3IevDDTvZ5QER4a/xNhqXILPPtZVSbhW8Bq68DIAGlx6hXKYfwb2aYNcsbflFHen6GBwX42XLrrp/5ObOrzZtidUKzvN2SD7Ab7VnXa/02m3hOPEG/LoyQ6m4dP0oLOhZa8WU1X5fhl+HJPJ35yW3BG4Tx5Z6xOnclQOA162UxODgdYSgjU6Wla3Z/Mm4P3/jy65693Mlc3bjlOLisw8UiVjtG+gI0m5e5T76ozqWP5ABe6IBtuTfTkPpjxqY1YbqAfOViEsHJG/y5CNHuJgIDnZyo9oCh3thJ4BTRWTVNLi3YszKbaTB3GY85kgG4fKQ+BW2wGg7XNlSL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:SN6PR1501MB2064.namprd15.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(2906002)(38100700002)(6512007)(6666004)(6486002)(966005)(2616005)(83380400001)(36756003)(6506007)(186003)(53546011)(31696002)(86362001)(478600001)(4326008)(31686004)(41300700001)(8676002)(54906003)(8936002)(66476007)(316002)(66946007)(66556008)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXZNQXljNkZZc0JSVTJ6c0k3dW5sM2g0T0xITXJvNGgrWDB4djBGWW9ZVkpy?=
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
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 06:36:08.0202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W53cIqMklz+NoNGxLFHUhZDtn7Toe7cOSYHj/GguFzFcpzsglaFLutdDEUL9WNEc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR15MB5935
X-Proofpoint-ORIG-GUID: h9-cMBSpEdBFTTpeHVQupH9Sck22sseM
X-Proofpoint-GUID: h9-cMBSpEdBFTTpeHVQupH9Sck22sseM
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
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/EKkVGV7oyBFcfKcC60-oBYvCrKs>
Subject: Re: [Bpf] [PATCH bpf-next v3 11/17] selftests/bpf: Add unit tests
 for new sign-extension load insns
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Yonghong Song <yhs@meta.com>
From: Yonghong Song <yhs=40meta.com@dmarc.ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

CgpPbiA3LzE5LzIzIDExOjMxIFBNLCBZb25naG9uZyBTb25nIHdyb3RlOgo+IAo+IAo+IE9uIDcv
MTkvMjMgNTowMiBQTSwgWW9uZ2hvbmcgU29uZyB3cm90ZToKPj4gQWRkIHVuaXQgdGVzdHMgZm9y
IG5ldyBsZHN4IGluc25zLiBUaGUgdGVzdCBpbmNsdWRlcyBzaWduLWV4dGVuc2lvbgo+PiB3aXRo
IGEgc2luZ2xlIHZhbHVlIG9yIHdpdGggYSB2YWx1ZSByYW5nZS4KPj4KPj4gU2lnbmVkLW9mZi1i
eTogWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT4KPj4gLS0tCj4+IMKgIC4uLi9zZWxmdGVzdHMv
YnBmL3Byb2dfdGVzdHMvdmVyaWZpZXIuY8KgwqDCoMKgwqDCoCB8wqDCoCAyICsKPj4gwqAgLi4u
L3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdmVyaWZpZXJfbGRzeC5jwqDCoMKgwqDCoMKgIHwgMTE3ICsr
KysrKysrKysrKysrKysrKwo+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDExOSBpbnNlcnRpb25zKCsp
Cj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJv
Z3MvdmVyaWZpZXJfbGRzeC5jCj4+Cj4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9icGYvcHJvZ190ZXN0cy92ZXJpZmllci5jIAo+PiBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2JwZi9wcm9nX3Rlc3RzL3ZlcmlmaWVyLmMKPj4gaW5kZXggYzM3NWU1OWZmMjhkLi42ZWVj
NmE5NDYzYzggMTAwNjQ0Cj4+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9n
X3Rlc3RzL3ZlcmlmaWVyLmMKPj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3By
b2dfdGVzdHMvdmVyaWZpZXIuYwo+PiBAQCAtMzEsNiArMzEsNyBAQAo+PiDCoCAjaW5jbHVkZSAi
dmVyaWZpZXJfaW50X3B0ci5za2VsLmgiCj4+IMKgICNpbmNsdWRlICJ2ZXJpZmllcl9qZXFfaW5m
ZXJfbm90X251bGwuc2tlbC5oIgo+PiDCoCAjaW5jbHVkZSAidmVyaWZpZXJfbGRfaW5kLnNrZWwu
aCIKPj4gKyNpbmNsdWRlICJ2ZXJpZmllcl9sZHN4LnNrZWwuaCIKPj4gwqAgI2luY2x1ZGUgInZl
cmlmaWVyX2xlYWtfcHRyLnNrZWwuaCIKPj4gwqAgI2luY2x1ZGUgInZlcmlmaWVyX2xvb3BzMS5z
a2VsLmgiCj4+IMKgICNpbmNsdWRlICJ2ZXJpZmllcl9sd3Quc2tlbC5oIgo+PiBAQCAtMTMzLDYg
KzEzNCw3IEBAIHZvaWQgdGVzdF92ZXJpZmllcl9oZWxwZXJfdmFsdWVfYWNjZXNzKHZvaWQpwqAg
eyAKPj4gUlVOKHZlcmlmaWVyX2hlbHBlcl92YWx1ZV9hY2Nlc3MKPj4gwqAgdm9pZCB0ZXN0X3Zl
cmlmaWVyX2ludF9wdHIodm9pZCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB7IAo+PiBSVU4o
dmVyaWZpZXJfaW50X3B0cik7IH0KPj4gwqAgdm9pZCB0ZXN0X3ZlcmlmaWVyX2plcV9pbmZlcl9u
b3RfbnVsbCh2b2lkKcKgwqAgeyAKPj4gUlVOKHZlcmlmaWVyX2plcV9pbmZlcl9ub3RfbnVsbCk7
IH0KPj4gwqAgdm9pZCB0ZXN0X3ZlcmlmaWVyX2xkX2luZCh2b2lkKcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgeyBSVU4odmVyaWZpZXJfbGRfaW5kKTsgfQo+PiArdm9pZCB0ZXN0X3Zlcmlm
aWVyX2xkc3godm9pZCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHsgUlVOKHZl
cmlmaWVyX2xkc3gpOyB9Cj4+IMKgIHZvaWQgdGVzdF92ZXJpZmllcl9sZWFrX3B0cih2b2lkKcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB7IAo+PiBSVU4odmVyaWZpZXJfbGVha19wdHIpOyB9Cj4+
IMKgIHZvaWQgdGVzdF92ZXJpZmllcl9sb29wczEodm9pZCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHsgUlVOKHZlcmlmaWVyX2xvb3BzMSk7IH0KPj4gwqAgdm9pZCB0ZXN0X3ZlcmlmaWVy
X2x3dCh2b2lkKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgeyBSVU4odmVyaWZp
ZXJfbHd0KTsgfQo+PiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3By
b2dzL3ZlcmlmaWVyX2xkc3guYyAKPj4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJv
Z3MvdmVyaWZpZXJfbGRzeC5jCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+IGluZGV4IDAwMDAw
MDAwMDAwMC4uNDE2M2U5ZmZmZmU5Cj4+IC0tLSAvZGV2L251bGwKPj4gKysrIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3ZlcmlmaWVyX2xkc3guYwo+PiBAQCAtMCwwICsxLDEx
NyBAQAo+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKPj4gKwo+PiArI2lu
Y2x1ZGUgPGxpbnV4L2JwZi5oPgo+PiArI2luY2x1ZGUgPGJwZi9icGZfaGVscGVycy5oPgo+PiAr
I2luY2x1ZGUgImJwZl9taXNjLmgiCj4+ICsKPj4gK1NFQygic29ja2V0IikKPj4gK19fZGVzY3Jp
cHRpb24oIkxEU1gsIFM4IikKPj4gK19fc3VjY2VzcyBfX3N1Y2Nlc3NfdW5wcml2IF9fcmV0dmFs
KC0yKQo+PiArX19uYWtlZCB2b2lkIGxkc3hfczgodm9pZCkKPj4gK3sKPj4gK8KgwqDCoCBhc20g
dm9sYXRpbGUgKCLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+ICvC
oMKgwqAgcjEgPSAweDNmZTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBc
Cj4+ICvCoMKgwqAgKih1NjQgKikocjEwIC0gOCkgPSByMTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgXAo+PiArwqDCoMKgIHIwID0gKihzOCAqKShyMTAgLSA4KTvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgXAo+PiArwqDCoMKgIGV4aXQ7wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+ICsiwqDCoMKgIDo6OiBfX2Nsb2JiZXJfYWxs
KTsKPiAKPiBMb29rcyBsaWtlIGxhdGVzdCBsbHZtMTcgaXMgb2theSB3aXRoIHRoZSBhYm92ZSBh
c20gc3ludGF4Cj4gYnV0IGxsdm0xNiBpcyBub3Qgb2theS4KPiAKPiBodHRwczovL2dpdGh1Yi5j
b20va2VybmVsLXBhdGNoZXMvYnBmL3B1bGwvNTM3Nwo+IAo+IFdpbGwgY2hlY2sgYW5kIGZpeCB0
aGUgcHJvYmxlbSBpbiB0aGUgbmV4dCByZXZpc2lvbi4KCkkgbWF5IG5lZWQgdG8gZ3VhcmQgdGhp
cyBhbmQgb3RoZXIgc2ltaWxhciB0ZXN0cwp3aXRoIGxsdm0gY29tcGlsZXIgdmVyc2lvbnMuCgo+
IAo+IAo+PiArfQo+PiArCj4+ICtTRUMoInNvY2tldCIpCj4+ICtfX2Rlc2NyaXB0aW9uKCJMRFNY
LCBTMTYiKQo+PiArX19zdWNjZXNzIF9fc3VjY2Vzc191bnByaXYgX19yZXR2YWwoLTIpCj4+ICtf
X25ha2VkIHZvaWQgbGRzeF9zMTYodm9pZCkKPj4gK3sKPj4gK8KgwqDCoCBhc20gdm9sYXRpbGUg
KCLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+ICvCoMKgwqAgcjEg
PSAweDNmZmZlO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4gK8Kg
wqDCoCAqKHU2NCAqKShyMTAgLSA4KSA9IHIxO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBcCj4+ICvCoMKgwqAgcjAgPSAqKHMxNiAqKShyMTAgLSA4KTvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgXAo+PiArwqDCoMKgIGV4aXQ7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+ICsiwqDCoMKgIDo6OiBfX2Nsb2JiZXJfYWxsKTsKPj4g
K30KPj4gKwo+IFsuLi5dCgotLSAKQnBmIG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6
Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

