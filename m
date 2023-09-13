Return-Path: <bpf+bounces-9873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6AC79E13C
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 09:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62D51C20BE5
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 07:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA51C1DA36;
	Wed, 13 Sep 2023 07:55:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37811802E
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 07:55:50 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2129.outbound.protection.outlook.com [40.107.215.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865601729;
	Wed, 13 Sep 2023 00:55:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jrs0JFfV+C2/vbvTwnFoX2txBN6AGGD7t1fgbNIq7KJgHhqJa+zN7UNjV/vpdtfv5PIzOZUgGt2jTqFhbSQBzT4rAPtusmiMBlWeA7cw4HNhO7HySi90DxrUqYezpkrmzrk3HdHs5mld9+RjghgUlfpfxjD+0GD0lj+n1OK5hCbfVxYeGUvJsW7/fdbPfAPP+X9/Eoa5IKGgOcUjUpfmlgQlJ9lmz2FjtpHYmpKZ6RLpm4SEFZZW4ZZBuBWuDHROPUhX1EPtxH+GEa2NfF5UbBvN/bJhlN+MDd3YpIGkMtYeJNwt+I2VYF9RtmcZKuyu7N9BTgO03GxU3stAiQxTfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYyvZluYBLrf1eTt7h14miI4PTsxZkiSKZubhsyejiI=;
 b=HiyQohybPHTEvYhM0EBOl4kOFxyZEf4+Lhjz2YGaUJqq8iQca4U10OZp3GNuvqGkZZz+tVJH4DMP9My6E39st6NSaFSMO7p7iUun15mID1rk8quBhgAxhxFa6sVesitJUJhKLXzR227KYDtTKBl6M8+HwaJjK8U6CoQWbCrf5PirGaJXaNEnRyNFOJYiEmSWTUi44FjdKU2G7kHTu0lRjNINicT4SO1kExWvGLg8dlURya3EUeAIJbUUYsXlOCmb7qJJkXO+rVlpBgclRFSWU2B2GEtLPJV3yuMYBRswdp92uqWt67ipgmITvEteCQG3Hptns7hbwODiTNBkV4w5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYyvZluYBLrf1eTt7h14miI4PTsxZkiSKZubhsyejiI=;
 b=Nx3hFhlNu52tGZ+R+fosHGlVP3FR2Pt/V/I9iSbUUAhIAonJJQgLPnIBE6DdgaHTMbh4fSIqT03jJeOn6XOL0/bqp8QGLIL2ue3EowlsDEtWLF8mFmdoTxFlAEjjc+53U/8mJ/d9KLYcGCxpO5zWby8tOimi+Fj3PDI5+2B+cPswoIP0F/Ju9Gp3rEEBFei/GUQlQ79i1VDCmwjbwWoAUCbRWry/ee4jitANCvXfNjw6mWq0ybjs4D3OkLpKvzJmLI+Q9NtzaoJi13E1xPanGatrGRN/zQr/VrhGCV1/dTlIU0yMJTiqDFLQtmxFf9xAsSPf8xt+647dVoyzEu1CdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by SEZPR06MB5069.apcprd06.prod.outlook.com (2603:1096:101:44::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Wed, 13 Sep
 2023 07:55:46 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::1c25:781c:9638:960d]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::1c25:781c:9638:960d%7]) with mapi id 15.20.6768.036; Wed, 13 Sep 2023
 07:55:45 +0000
Message-ID: <39a426ed-9b78-4d7d-a35c-d99c69115982@vivo.com>
Date: Wed, 13 Sep 2023 15:55:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/5] bpf: Add a OOM policy test
To: Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, muchun.song@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-5-zhouchuyi@bytedance.com>
From: Bixuan Cui <cuibixuan@vivo.com>
In-Reply-To: <20230810081319.65668-5-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To TYZPR06MB4045.apcprd06.prod.outlook.com
 (2603:1096:400:21::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4045:EE_|SEZPR06MB5069:EE_
X-MS-Office365-Filtering-Correlation-Id: ee60e16e-bb52-4bdb-9c9d-08dbb42ed61b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GwwcKsH+KjF8dGH0la7nw+aBvJ7Gv+TCEl/WFGET8/0m8XlrBuakfvwaLtvoUxNqIU3IGEhuHk+x0+n181TBZrFKH6b4Ng4g5d7BITvLBoZK1+ajgs2Q74R33mvM8mVd/5JqIWFrPvm9NaKuOb6GqzHLVGi1lfoKkt1WIugGu7qeixf5K+AC2VPltHeR8u7Z1JRH9WsRxxjFaxMvlH8mvOXS489GudNsFjZZ2wyydQ2k86OYdzj1jvcn5zbv76ubUGDM/Mx8r/E0hm2F+Au4scdUEEboZd8GUI/UxVYEdmCCt/gaD7W97I4KZJBEjtZ0fT28ygIIyObcWz77/jp6sGXUHDoUvPGNkUMlEwlGiNEIT3QamgsrQZuek0LHcz06sGr0Kq38Eguf6tuERyhWjkfg8J0za6iQaXSOsdjLsJhoZZuOGJiGM2UCV+5c8IdJALYei6nNwyp2ohFqN0tyw5C7lGuD2bb4nV91Q6bbOxmWk/F2r7qrp9KTnpiAZWpZq+3rpqO9VW4pKfOJLhFTp2iOTZQ3AxAtAIePzP71GXNMeynmXEORdFpvXhKPIT7YQvAnbX/2EUnmQodNa3RQtkBL9JYKyMRFOuztBo9asUQQ0lSQWnrbL/JgQi3h/STf5wzfo5ZAA3ZphfO7W1IhbxN6MlwknHGjXuU1HoIuCofRFTuS66ZP6rPy0wZb2qHo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199024)(1800799009)(186009)(2906002)(38100700002)(31696002)(38350700002)(36756003)(86362001)(558084003)(41300700001)(26005)(4326008)(2616005)(8676002)(8936002)(66476007)(31686004)(5660300002)(66946007)(66556008)(6506007)(6512007)(316002)(52116002)(6666004)(6486002)(7416002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wk1UQkN3UG9NUHQ0dG94bFFGY1VJa3pDeDhyNVNYeTkvNmYxZy9pVkpCemF6?=
 =?utf-8?B?dUk4OXdlVUtxTzQ4bzl2b0h0SUhCT2NrK3NQOE1leTZ3bjZLYms0RFhGUzZI?=
 =?utf-8?B?TmdTNE1kN21JSVZ5b205bDVFUVFVV0FFbmlSOTN0WmpQaWF3Q1ZrQVZRaEFt?=
 =?utf-8?B?R1VIVzdneUxKR2lNb0tTdXVMR0tRUVJOL1hoa1BZblFFRkNNRHNjSDlPeG5Z?=
 =?utf-8?B?T01KWWtsVGdUa0FOcngvU1JyQ0JGZitVS21aNk9GVU1IOGYrSmFrd3VxaHlh?=
 =?utf-8?B?YWFzMnpYeE1iUmRlK1ZsLzhNdXBLc2lZalowNmUwVHA5YmdBZ1NTZ1lYTnR6?=
 =?utf-8?B?bDhjVldvZ2ZUelp5aS9YVlNHN3hZRkxxeXZkRTlvWkpjVUVUSldBRU1rVDBD?=
 =?utf-8?B?RFFaUGs2N0lxajJlWWkrTEZaeCtOVVZIS3VXK0cwQjgxaXhSSmNIWWtPVzFB?=
 =?utf-8?B?UVlwS053Rk1ISG54a2tiUDh1ajZHTFUyZnZYeVk5eG1RM2J0TE0wemxRUHA1?=
 =?utf-8?B?WUZOQitwL1BNNHJCb28vT0Nqcjk3ckZETjRPeWJEcDhOcXZGajgwdDVKRzlx?=
 =?utf-8?B?endMNlh5SEFPaUpVWE1KSE94QmFxM0VqdW5nYXo5dVFNVVFhbndOenVsbEVx?=
 =?utf-8?B?RFhSd25peHJGUGhqRThqNU5BU2VlS0tqSlc5VVAzVnh5VkZTWFdGUkxCOE9F?=
 =?utf-8?B?cFh4OUo0a2s0UHNGRUpDS2YwdTJIc2dCQmNkOVpNWjhvRnBFMlNqaG9BTDE5?=
 =?utf-8?B?MS8wREw3TTdWaWk3MzRLRFV2Y2hPczhkc3QwSDROcE1pUVRKVFpSakpmMzhP?=
 =?utf-8?B?RXhGM25tT2JnTXVlU0FwQTFpMTFoTFcxd2s5ZTNOcWoxNnV5Ri9WYzR5ekww?=
 =?utf-8?B?aWdVQnh5aEZ6ak9ZdS82TEQvZDhqTStsRm1aMnhrcUs0UXZlZ0ZNbndxdUVD?=
 =?utf-8?B?aVkvYlZ6ZDFPU1dka3ZvbUJoT0RFbUhvc25Ka1F2T3R0S3RrMXFlbDlCbzFL?=
 =?utf-8?B?QnF6cXVudWZjZGhNRjZPSGJ1ODJYa3FQOHR5aDhGR0FBSmlxWDl0RHlCU2hv?=
 =?utf-8?B?MDdhZS9pS1VxS25sMkNSRDF1MGthUUxLcEFUcUZXdnB2Mm1GbXBaVkZ5K1ds?=
 =?utf-8?B?L1I3dXlBTWp3dGtRbHN6dnVyRkwxSDFnR1prMnJzVk56Q0ZJQ3grVXJWVkNP?=
 =?utf-8?B?WUhhbmUxaDdQK2sreXhxSUcwRVR1bXhWNnMrWHJXcTQ3VXg2NkloZ3pFbGFl?=
 =?utf-8?B?ODBlaGJRZitRdVNtaW1NYVBjSVFaWDE0dmdUNENuNWhBbUh1L0N6eTQ3SGU5?=
 =?utf-8?B?Y0F2T3lXaGJlNko5cXVtUEhJbGFVMVpZa2JRbHVkVUIzVThTMUtmRU5tWlhM?=
 =?utf-8?B?SVZmSXMrdDJIcXExSmE5bGdWTDlQckhCNWhVb01yZVlVTU9XZytDeHltZEVI?=
 =?utf-8?B?c2tJc3pVN2xrMXE4Mkc3ejErb0VvY3FzYzdZS0w4WldtRXdqZmNvVmd4R3Fq?=
 =?utf-8?B?M01XQzFGbkdYZEpnczlGdFFEelpvTXhkUlBNeElHL0szOTdKdkI0Rmo2R2ZW?=
 =?utf-8?B?anpHNzd3dENPRnhZTHpTN2pJMWFyT25TS2o2ZlFFN3JVcWJXWFNGb3FvbUtk?=
 =?utf-8?B?MXlWN1ZNYlNBWWdXM3hWVkpwdEcxTGgvZTlnZEo4UkZlbkl6SkpKKzVwdzVV?=
 =?utf-8?B?SzB2UitJeURxTXFhVFh4NEZRa2IvUVN1R2htU2piSVJTdUhMa0tyN0JhT1dX?=
 =?utf-8?B?SFlRWlZWOS9vZndnS3g4WjBaTCsrcUFEMkVWbmI3WUJidVV6UlZlei81eUMz?=
 =?utf-8?B?ZExucHFsWHVwd2c3SzVKVGNJd3QyWFA1b0hndFNuV2NWZzhBK1RDcmdhb2Jt?=
 =?utf-8?B?ZXJVN1grN1hDQUp2RC9uN2dRWGQvR1dRQUlmRStMR2w3Sm9DSUdtMndvbVRw?=
 =?utf-8?B?aTNhL1Q5QVk2Nk1ka2RKK2R6am1PVGRLUTk1M1ZwWUpmWUJ3TklBVGtSRmd1?=
 =?utf-8?B?Z0srV3dQZmpkenV6QXNHVElUMGR6bjZxNWRLOHVhTUpnMEJWQUNqell3MUY1?=
 =?utf-8?B?NUhabCtxM05Cb0Yzb3ZhRkgrOEpKOFFZRThJb1J6Z2srcWZMOWV5aXkzMVUx?=
 =?utf-8?Q?YekDy7yGoQHi+vUQda3DX/by6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee60e16e-bb52-4bdb-9c9d-08dbb42ed61b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 07:55:45.9375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpGAz5PPJev9gMBZfq1tB31tGMQPnoSxZyiKM7XSXFxIP7LVEZZLr+nwCCCUiTNmGQ6IXdVLTK4SDA+UCafBUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5069



在 2023/8/10 16:13, Chuyi Zhou 写道:
> + +void test_oom_policy(void) +{ + struct oom_policy *skel; + struct 
> bpf_link *link;
'link' doesn't seem to be used.

Thanks
Bixuan Cui

