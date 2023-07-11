Return-Path: <bpf+bounces-4701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9E074E3FC
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 04:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA1D1C20D18
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 02:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0263A1FD6;
	Tue, 11 Jul 2023 02:13:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B838A50;
	Tue, 11 Jul 2023 02:13:58 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EFB91;
	Mon, 10 Jul 2023 19:13:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnpwtvrVUOWWq8ZzNiNx07Fuq7h/Uf2yU05T9Ty0b/mbNdi1AEjUdCfzgfdEccQLTmhmuZEq/yPGo6JA6YkJPj18sz37Ab8XWNbdo0iyaCFHtVxNZjbVPCO4JOMerap2sDQetNZOuEP0gdiAfoinbuIMYV3yp9wqqlw/qieaPiVPnwHDJeOk69N74nmBXP22hOyMB0jJChUQRt8FrGX+IJMlXbM2F0knucAhVTgc4Haz1fXNTKm7zqsopDPXE4opZMdjVKDWad7AZrOElKss7H+Etgj0p6ZaHEYkVq8BwhkL+4PMqOIQ9b58u/6+n7LkDV4OT+xS7INiMQC2Wuae7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXDpZ8wE6d9xuWygKBdM0vnkvZZ2iZHTvupMx4kHi0o=;
 b=W0ucscBjg8BZ8UqrBrIFdg9a+OMLZ6CtnMsKhDMBzAfOLlAfSI2P3z02LifkTBbMIOtuZ2aV3ur8x0EPMLaJt2mlZZKj0hUV9y6iLHsYc3HDEIZnFZ4vyb+xclaJCk25yOgCGPI0T5TEPb7//mPqhu7oRWEXFf9ldb/zYE7Y3CCmq/1JlN2IvisbubbHI+gX/d+dX1zcS3J9xHXAXrsZ/v4zgHriOF14UwDK27HQzwfub3o219Hk97rqYsMzCBPe23TZfrJipzDoE6mwgQr/M8iPCWDoxzYNmvtAHo4IwL4h8gz2YGPuVXsFg47YjSINGBj+WaoS+0H2KH6T3mcVTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXDpZ8wE6d9xuWygKBdM0vnkvZZ2iZHTvupMx4kHi0o=;
 b=sD7NlIfAPz2tmTeMDjixqjSYa53VmT0rw7MHw8YjfZWYCEO1nXO2EbYIazvpP3UH2mJycteI7vJaaylFtFjL+r8rVz4wMgdzsvlZTl82rxjzTUMRcVNS8vfhCaEqRg0aPJDI4qpVExN6rBcxij5GskSn6WFj5ezJyeQcy7AXNqh0VhJUZ3fEUug/tnXcNUuSK1xNK1KjFgslohRhQOm1Mq8OfWImB1wPSXdoRz4FZ+jamY6CAeih89zMC057qbuhFgac8HTuI6S5N1kmVtBoXmv27gd1wE76Z3AoUsclig3XYpVguP2FaKLdg51wcLoWg0zjaAKfE6d0Cyrts8gvtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10)
 by SJ0PR12MB5485.namprd12.prod.outlook.com (2603:10b6:a03:305::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 02:13:53 +0000
Received: from CY5PR12MB6036.namprd12.prod.outlook.com
 ([fe80::69ec:e7ff:85d:8121]) by CY5PR12MB6036.namprd12.prod.outlook.com
 ([fe80::69ec:e7ff:85d:8121%6]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 02:13:53 +0000
Message-ID: <c1b647dc-6832-f8a2-baad-0e3a32ceef94@nvidia.com>
Date: Tue, 11 Jul 2023 10:13:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH net-next-mlx5 V1 0/4] virtio_net: add per queue
 interrupt coalescing support
To: Jakub Kicinski <kuba@kernel.org>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 jiri@nvidia.com, dtatulea@nvidia.com,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20230710095850.2853-1-gavinl@nvidia.com>
 <20230710110952.30c4384c@kernel.org>
Content-Language: en-US
From: Gavin Li <gavinl@nvidia.com>
In-Reply-To: <20230710110952.30c4384c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0199.apcprd04.prod.outlook.com
 (2603:1096:4:187::13) To CY5PR12MB6036.namprd12.prod.outlook.com
 (2603:10b6:930:2c::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6036:EE_|SJ0PR12MB5485:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea5cdd8-a509-4f53-a2dd-08db81b47924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gFkXM28LX0eMIQS0csn9Hg0h5LboQTgEGl42RhUeq+SUhm5Qs23S6Sn6pA2CWKKguPl2d7LvG+BtWL1NgeE87nIg3883vJCQG/bQiqKd0HJtopsiwMC115l4SEOvdVPzsnhwYIXmC75LcIxrGCKY7BPt+h4adwxkP9ExKpGZH31JP/3/gqms/bwdVLRIx5+6fz47clLt0EhACtovZVi7NJyAlIg6HeCcGNnSom76wgInmOJySEeF7Y2Jkz06j2HnK5amuUOQ+A018VDjOb74vgWj+rWf3CCFybeQVbs6Iw/PcBtLbswlrSM7wQdhOWmtWnD3hYP2w/59/8Zh/UvKRNisxE/QYw+0txlVQnV89ueVjE01t61JWkf8yaQrq55GIWHDYCSZfUlrprWWAkx+FD4ER++w8FaatvsAs/iePpM/78e5zDrsfYg6VQ2Ov0O/Ag5qL/MBfymPU1P3BkPjDUKcvxfY3/h8oS1/AI5j//KFvqAQS9PUz4Oq27jVh3fRJp6Fq49Wj8gjbMM1EpWO6aTh2ZgaERHkpy5Une5PUyZJU4zO8bfj2UkMVC+DVrz1hF5KsOVzOZE1X+qz4loZCZDJcsHDbc+yzlnI1dD2ox66+2EM/JNtCFDq2qXkr3r7Mfjydv/0jTbzs30YVH218gs32RYdKAuFLW93uSjbjwdqc3mJV73Mu89AfQmvX9pz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6036.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(38100700002)(86362001)(31696002)(31686004)(36756003)(6666004)(6486002)(478600001)(26005)(186003)(6506007)(2616005)(966005)(6512007)(53546011)(7416002)(316002)(2906002)(66556008)(5660300002)(6916009)(66946007)(66476007)(8936002)(8676002)(4326008)(4744005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmVtTlVqckVoZGZUQjFpZ1ZsU01STks0QUpPZjIxcW50dFRjUERtSWdqeTJn?=
 =?utf-8?B?NTNPMDZ5eWo1eVpzalVXSUhQaUtCcjh0NjlrVWprT2piSDJlR29HOTRiMlhO?=
 =?utf-8?B?b0JoRkUyQ3o0M08xS2o0V29waUJJNEh6eFBxWTN2dUNWa3p4MStBK0Q5OWRY?=
 =?utf-8?B?ZTh3ekpGK3l2TTJjNURaK1FwbTNqSTd6Z0t3ZHZWUWt3YnpxdGxCS282WnlC?=
 =?utf-8?B?amFZZENxSm12SGJHNlpjOTZDTjBpSnhKVHhrRXMxaURQSEVyc3V5bVhmaGpa?=
 =?utf-8?B?ME9QeXFmWmRvSUE0TExTSFRrRFQwNlBRd2kxdlRMRm1Rb3k4RmpIUVNTOEVn?=
 =?utf-8?B?dVNSWVMyczZtZkNMdnNhS3Y4ZFBjY3NrTndvZ2dVTjdtbVFRT09vbXpjc3lY?=
 =?utf-8?B?VHgzZEovb2RHZ0tLNnMzditvQ1FZcDhnb2l3eWVET3I2NDZxVHlDU2M0elFr?=
 =?utf-8?B?Y00wT1hGTnhpMmE3YzFFdkRIRUliQnBMQXpFbk5LQUc3K3p6NERGZHdBR3Vs?=
 =?utf-8?B?UVU3YU1BQUdHNG5kUUdVZjFPWW9IbzM1TWFhRnRDSitNRDF3Vk4wZWp1T29V?=
 =?utf-8?B?UERTTVdzVGp6LzdDeXZnWnRSUHRUYTAyTUVsc3ZlL244SUVhMU14clJVVHh4?=
 =?utf-8?B?YzA5RVlCOEpIeXVNVzUvY3g3Uml2NnMxTXNKZEdDSDJvdHhpdk1yRkR0RFBZ?=
 =?utf-8?B?T29SNjV6WVJmTWtHVE1XYTYxTmZJWmR4TXZ3Ym4rMVhKRmw3M3dRWVd6c0Nr?=
 =?utf-8?B?ZjZKME5wc0s4TFZHVmlTSFh4WmtCeVpBZlA3VGlkMkdqcTlTS2RPMXlWRkY4?=
 =?utf-8?B?aHJPY3UrQXQ4WVFiQlBEeDdYY09FSXV3Vm9XL0hzNWYxR012K0xkdXRqVHU3?=
 =?utf-8?B?aG9qQ01mbXhLZXltZXlaL0QwczNZbDRuVTdLTW15d2E5M3d0cWdXUVNOZlYz?=
 =?utf-8?B?M2ZNVkpnQVJYUHNPTUY2YUVqRjZjQmx3M3ZOVWFoMnVBaG1jWUM4OTBiSmhl?=
 =?utf-8?B?RzFxbFVLMzl2WEk0U2lTRUpwS3dhY2orZk55Q2lnUVZZbUl3ZzVZbVZoZmdJ?=
 =?utf-8?B?R3hIa2YzRjNTRnNRVjdzTDA3TklMUHhBQmp5WUpWQVF6WDhrZGhZVzcwWU1v?=
 =?utf-8?B?ZDhnMUYrZ1dxSG5vc2JvOS9XQ3RMNjE1QTl5dEpldFg2UjBSVWwrUHkvVkVm?=
 =?utf-8?B?T2pjV1hRbnFwZER1RVZaTnlaOXVNbmlqbDRXV3NhcmhmMy9pWjdIZGdXVzNy?=
 =?utf-8?B?OXppS2RrMmxEL1o3d0s4b29VOUJGQUdRVll5ZitWajZ3amNxVkdlL2c4anpo?=
 =?utf-8?B?d2xLV3ZOVWFQVnh0dXdLTlRhbCtvVEZsUmNLampITFNCSkVGN2crRlZ3QU1V?=
 =?utf-8?B?OUVOdEtrbzBXK01wbzQ0REFxZURGOUkrTEVOd3N3SVcvajNjc2YyMWJrN2pB?=
 =?utf-8?B?M2JobnRLVVhLNzB0UXFnYWRMODNESnEvQkJSVmh1SUhwRUdsaE00U0JFcWdt?=
 =?utf-8?B?Z0N5c1c4eXNPbFgxNlIrUGxISmF4UitFSS9rMlpSZXYzN0toc3IyeEpQR3Zx?=
 =?utf-8?B?SE90SWxiUkZpU1dLcmd1TUYzYjFCUUJGai9najBVK0hqYU9oSWd3dW1LWXNK?=
 =?utf-8?B?dEt5Sjdubnp3RmNVeTZ2eFVKMGhkUmdxVW56RWRlSitrRkwyZSt2dW1mU3BC?=
 =?utf-8?B?d2JLK3lLQmJKaVpiWmxEVDN3S3U3TFM2aXpRc2JsRW1Pb3JSaXJvc29nZXFC?=
 =?utf-8?B?YnNXYkYxNWhEcmFRV2d3cnJsMUV3aWxHTDEvQmZ5bnhGeFRzZWU0WXFPb3Yw?=
 =?utf-8?B?bGUzOGVQYjNWdC8xVzM3c2JUQnpRMlloQXlxMGxRSVdaaXBla0VIR3o4NHZ3?=
 =?utf-8?B?emZTZS9UM1FYU2gxb09IQXF3b0Nrd2ZDN3FVWUhHd2QreXdmTkswZkcxdG1h?=
 =?utf-8?B?ZklraEMyblM1dEViRVJFdFNTMlRrS3JacG9pdTB1ejU0NlBwM3hERmJ2bmNv?=
 =?utf-8?B?cEVBS1UzWHNYMHpPdmxJUzRQeE5XL0lWQ2xLdVIrZ2dGTlUvb0ZjSWlHZk8w?=
 =?utf-8?B?bGVoVEV3QzhPZm1UZmgvVXVRTStyRnp2UzZsdVNzNUxhM3JYWlZJR2NwYXhv?=
 =?utf-8?Q?1fC9T/ieS0nw3WFFxqRWIVOy4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea5cdd8-a509-4f53-a2dd-08db81b47924
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6036.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 02:13:53.3624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsDrljFTY1nHOqAIx2hLoegbOpMhudS2Xx1B8w9gowEcGHehq5Ee0FHMDHs9HEXNxEIrLxJ3L0pPTdnja7ppcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5485
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 7/11/2023 2:09 AM, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, 10 Jul 2023 12:58:46 +0300 Gavin Li wrote:
>> Currently, coalescing parameters are grouped for all transmit and receive
>> virtqueues. This patch series add support to set or get the parameters for
>> a specified virtqueue.
>>
>> When the traffic between virtqueues is unbalanced, for example, one virtqueue
>> is busy and another virtqueue is idle, then it will be very useful to
>> control coalescing parameters at the virtqueue granularity.
> Why did you resend this, disobeying the posting rules:
>
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
>
> and what is net-next-mlx5? :|
I thought I made a mistake to use a wrong branch net-next. Please ignore 
this mail thread then. Sorry for the confusion.

