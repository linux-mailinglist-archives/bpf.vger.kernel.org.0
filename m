Return-Path: <bpf+bounces-9853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D04679DD79
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 03:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE64281A12
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB25238D;
	Wed, 13 Sep 2023 01:19:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E077384
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 01:19:12 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2137.outbound.protection.outlook.com [40.107.215.137])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9A410E6;
	Tue, 12 Sep 2023 18:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWPXEuRGt1lvo5kn77t/2xSmPQ7PR1R4ggU1z8Oxj18o6B9Nfmt1PMWs0HTdSCCibvGx1FIV/tq1EbUvtMvq6b0FmDStttjaQlteVavImlgkI+2kgz+uZKxdc3PZ0yH/724YQYuTRz+on3gecBbiWXXa1SZ/ybsUUNtez9CByPXZqnaapRyWPkc7FwJMD9KTZVm1hROeorrii0G4DCDnL26qHeGMIZLh6E4tmxxE5a5NYh8x9db1jkCQ2goO8erxhRgnzN4XerCFqzjlBPV4Hw2iaj4d3WeovOvafnv/7BfTBQBVn/rbLuHnAs6b7c9Nydiznu8m2UvyXR7ej47dlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDokQxTJ0jffqX/Y66WuwuB93YZVIl5tg9oW8SVuRPs=;
 b=kkvSmh1tYPzG/heGDiFXJF641jwZwBLs7fV7CbRG20ooRH5tP77kK9p2SllYEpbUr1JSB8n134tq0sa61UuURTQtwSAJmh5AE61GHAd9WruuWeJcbHFEGQLyaGcLlhNCrdRt2RTxBeVgBBGZXRMqpn7Sbmbx5FbAA8+4BUys5ZIP+Wiqf0PUdOSvTjp+zJDXfCgIgPqU8UTAPNsJr+s+Sy70tXQ22MpIt0evZsGsCQuGXaWMqNiw9mzjcY0PLjIr+NuAqD6/nAulZX+DH+tl5KT3VC7dT87ntFu2/PGHLqCedY2G+ofei7wpheNNGlSJv+bwgXn4zWTBb8FYOI6Ujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDokQxTJ0jffqX/Y66WuwuB93YZVIl5tg9oW8SVuRPs=;
 b=EEfQhLRWtX60N9dH3hj4Actvi8AfY2M3xYdneS1nU8SdX5L0laaaSiS6j+IzTOPTX3N9eqP3Bab/Fk2lg6rhEDtC3OAG0vkjOdDLaf1tOufvz/82GbKIKTwytrqnv7I25gCRmHRzFx6JqKF/aYQ96F9xP0rAlquzoUMqY/WByQEYGcWM+NcBp99jgynp3aL1lKCrDs6XXVuLzYdtvVYgSs2d2T93OAuwKzzxyUci2Z4Q3cSF/Ju6PjcsrUMe7/mmzI0r6yytpbHazaHH4D5PjdsG3zFsdYeiwj+5VyfL59bFu2hQAKmKSTlP8EgZ7KmIlmv6xHxOHYA9oKacMhyO1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by PUZPR06MB5772.apcprd06.prod.outlook.com (2603:1096:301:f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Wed, 13 Sep
 2023 01:19:05 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::1c25:781c:9638:960d]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::1c25:781c:9638:960d%7]) with mapi id 15.20.6768.036; Wed, 13 Sep 2023
 01:19:04 +0000
Message-ID: <e88fe274-cd53-40d4-9a8e-7c6a4e1d8c44@vivo.com>
Date: Wed, 13 Sep 2023 09:18:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/5] mm, oom: Introduce bpf_oom_evaluate_task
To: Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, muchun.song@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 wuyun.abel@bytedance.com, robin.lu@bytedance.com,
 Michal Hocko <mhocko@suse.com>
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-2-zhouchuyi@bytedance.com>
From: Bixuan Cui <cuibixuan@vivo.com>
In-Reply-To: <20230810081319.65668-2-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To TYZPR06MB4045.apcprd06.prod.outlook.com
 (2603:1096:400:21::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4045:EE_|PUZPR06MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a8ac6c-afbc-4917-c946-08dbb3f76b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E9USDeATdyATBgWDWP5MzNwa1OytbGe2g8duJZAg0ULCNdZLB/1ZEx/vya2suNvXwoN7wFPf3XdleStgR9Zh1KIuL2yAkhdTJl7oCS7d78Ct4DXdrXsOzr8CQ2I9gye63nTO84q3g29Zz56tOnYD+5x4PBfZRTlFGCZ2yBtRr7v/5IJB9qFbXKVbF4+AwBX1NCcs37CRW5ecpgbmWYjAbgWIf0jA5KBP20sx9IQYl3CPQN32tESTBfupHBDbhhqCFZJtQdm2WX8bfPZPbLEAXHi5SGl69oF0NM4ULmkCyUqgy6cNyIH4DZ9VEFnLhpm0z0Q5OhF71qv4s/XLnOWM2tW7t7Ud71vfq/mpEiQ/ArfGhJB9UGfFnGpLA8BWas8zG5ZJtq+EyytaF5bNKHGiELQefMISm8GYcjkZjrFk9V4n7bn1NwK4moLmL1WRWZX1m79weakb13TRAF1nT6QWRfLjMVS9AObdOd1pQTsybGyHxz52zI9iWP0KPAKFapqiFLJu6UCerbehLnCB4pMdtOobV8ARBnZi3IYyslSXWVki9z+h+4JGP2U6Mkp4HC+DrkNR3KlYlQGemxETN0+z0meokeFe1//aqcHDOdwq4R8piMNW0nCMhmmajcjaegSFnrarLgIuWvbn6Ym3A7DjS9ekSLP8kcImP9bAC2mt8OsVcQHLVXjwlOMY3C3qdS9H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(396003)(136003)(186009)(451199024)(1800799009)(478600001)(41300700001)(4326008)(8936002)(8676002)(6486002)(6666004)(6506007)(6512007)(52116002)(316002)(5660300002)(26005)(4744005)(2906002)(2616005)(66946007)(66556008)(66476007)(7416002)(38100700002)(38350700002)(86362001)(31696002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bG1OWC9pSzFXcGpOa1lYQjh1QWJxb0RReTgzQnhhRGNsZ1ZNRElkTUI3bys3?=
 =?utf-8?B?dVhLTkcrZ01YU2xOeG12OGovMzV4UG91eXJBam1qWFAwcC8yQndJUEtSbWVm?=
 =?utf-8?B?eHQ4YjFoMXFudWZOaXplMmk5OEpmNkFHVjN0QjNWb0RKMjJ1OEJKSng4eFY0?=
 =?utf-8?B?UXl5RVR4VGM4SytBZFVnSEI0T3V6azQwNGE0N3RnTzhTWXI0K0gvbTdaalZ2?=
 =?utf-8?B?U3V4eklFY25xMUp2d3BYOTB5VHBmNjk0U2VJbTlPMHFZcUtRK1JrOUJraWl3?=
 =?utf-8?B?dmxXUUlqTGhDWlJWQUh1YjJiOTMzaHZycmFKUEFlYzVFTkNYdG9WTUhEVW5G?=
 =?utf-8?B?bkk2SEU1V0E2KzloWkZzUzNueVBjU1lDS2s0ZHcrK1hRZW10b1IwclZBa2hP?=
 =?utf-8?B?eEZVcGhTaWkwTkF5V2RPL1hpQ3VpMUtnaWErOVA5NTZSOUNsL1VCb010bWlU?=
 =?utf-8?B?UEVxZGdabHBYM2FsWDZ2UEhLbUhyc2VhR21ESXlEK3lvVXUzSHpkSWN5Sklt?=
 =?utf-8?B?dFRkblh5MFdVbENNWnJ2UERpQ2VjN3VlMHY1SEdLMHFiaDZ2V0k4QTlRU3BJ?=
 =?utf-8?B?UktVeU9CQkNHQ0RZSURkYThQSTZiYjVlek9jMEhYWEcxQVN6cU02SzhLaHly?=
 =?utf-8?B?SWZadjIyT0lGQkpoOU5QNnRONVZjb2VwVTdYL055TGR1K3N3cDEvOTNvQy9s?=
 =?utf-8?B?Wkp4MEtlWEJYYStNUGV4L2NjQmNkcS9CSXFPcUJjUkJxcWg4SXN2dWdSbHpL?=
 =?utf-8?B?REJEdWozOUpzRmxGTVIwSjRpY0ZGNkdSTTFyZDZ0d1dUR2ljMzVEaDd3OEg0?=
 =?utf-8?B?aHZqc2JJTkdmYUlmTlpJR2ZDblhwSkwyK0N4L0VPbHdaMUpYRmpnV2V3SXBm?=
 =?utf-8?B?MlhreU9VeXN0SDNDZWtXa05XNFdYUHFVU1ROZGVvcHhFaHBnRnUrbDYvS01P?=
 =?utf-8?B?bzBtOUpyZjA4THB2VFBra3IwTmp5eWNoSnFaQVFCbTd4bERLRVduaElQMmpK?=
 =?utf-8?B?NGs1alRIcGVxazVWdHhRZDBlV0dqK0xtY3JDMXk1NmRnZHlOZXpBUXhEYS9D?=
 =?utf-8?B?Y1AwNGFqZUxDZ0lFd3dBa2ljM3h3NTVEaC85QVBUeFIwd1pqSlFEam5qS0R6?=
 =?utf-8?B?T2Nlc2l3ak1rWWZBSkVqZGhSZXFKSmZnQ1FJTU82c1pJUi9TVW43RVFXdkM3?=
 =?utf-8?B?cUx1ZExHVGJtNE9oNDkzdXlkU1RCUHRYOWVGV0pzU0hXalJMeElTY0lCdk9N?=
 =?utf-8?B?N21xcmZyMHlHUUt5dnlFTUU5NThwTmlxcTNGNytnbnhXM2ZNUksyalhuNlZN?=
 =?utf-8?B?a3lNdExzdGk2Rkp5TUlRelhPRGJnQ3B2cU95clVPVWlOQTNXSkEzanFkb2ZU?=
 =?utf-8?B?QUVoRWpBbVpIYW8vNGtXZWZRTThxN3dqNnBMSmJ2UVdFQmVzcUJGVkhmWkNu?=
 =?utf-8?B?bldET3BwckdaWFlWdDlONkZzdDdIUEoybnd3OGJzc2RCTDM3SjYyZmVpQm1n?=
 =?utf-8?B?czBKYnJwRmoxSGQwNDV6Slhlak8xZERMeEtNUmN6RVIwTm05TnJzUmVTMjNu?=
 =?utf-8?B?V0F0dngxOVZ4ZzVWNURTSTZZbjNyRWl4ampaZ01NanRsRFhnZzZQeVR5cXdy?=
 =?utf-8?B?NTBQMnF5YnM1bGFFUTE2cWhNN2NmUjhacDNVVW1WZ0pjSit3OTZqRjdIYTM5?=
 =?utf-8?B?VlVrNzIvZXlNSnpDZlRFZjhWdE1vMVVaVGFMS21NUXo0OTlLeTdibHRnWjBO?=
 =?utf-8?B?NXRiM2x4aEt1NXlVOVZudmtjSFVvV0ZWRFdCS2tCemFsRzNPSmlXdHVQdnJG?=
 =?utf-8?B?RFVZcy9zcmxsV0hVWmJ6Vyt2aUVPc2F0dVB6dnIzK29weGlzVmVPbWZpclcx?=
 =?utf-8?B?Z3dsWmlKanJkZGdBZE8wUHNpQnF0ck5LUS82STZ2TnJVZUNmS1VGQVh2eG9z?=
 =?utf-8?B?Z2JsWkpHdnhUMTVIZDhTMHBIVFdTWTBXc2tZUU9PWkNwSVV2SFlrOE53cGJs?=
 =?utf-8?B?SWJGQm9vUytHUjk1cWpFV0tGRVVNWEgwa0lLYlV2RzQrQXpHVDI4cTlxQk0r?=
 =?utf-8?B?T0hIRy8vT1BIVXpNVFNLQ1duUk1OZkszOGc1K0orcmRFRU5OT3U2WWQ1VG5I?=
 =?utf-8?Q?Dqq9JWXtOm2fCzyOdSM4MWtfW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a8ac6c-afbc-4917-c946-08dbb3f76b27
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 01:19:04.2050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLq+ifzBwvBGromgJuW4JOJMz/ksa1RV9qAotaGtlENXxqDk0DwV/+mVS3pIDdXXKNcnofAVXYsjb7IHhXnzfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5772



在 2023/8/10 16:13, Chuyi Zhou 写道:
> +#include <linux/bpf.h> #include <linux/oom.h> #include <linux/mm.h> 
> #include <linux/err.h> @@ -305,6 +306,27 @@ static enum oom_constraint 
> constrained_alloc(struct oom_control *oc) return CONSTRAINT_NONE; } 
> +enum { + NO_BPF_POLICY, + BPF_EVAL_ABORT, + BPF_EVAL_NEXT, + 
> BPF_EVAL_SELECT, +}; +

I saw that tools/testing/selftests/bpf/progs/oom_policy.c is also using 
NO_BPF_POLICY etc. I think
+enum {
+	NO_BPF_POLICY,
+	BPF_EVAL_ABORT,
+	BPF_EVAL_NEXT,
+	BPF_EVAL_SELECT,
+};
+
definitions can be placed in include/linux/oom.h

Thanks
Bixuan Cui

