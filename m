Return-Path: <bpf+bounces-3611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BD5740750
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 02:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BAC281147
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 00:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A28C1390;
	Wed, 28 Jun 2023 00:54:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5513F7E2;
	Wed, 28 Jun 2023 00:54:53 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF1E296D;
	Tue, 27 Jun 2023 17:54:51 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RH9tJm012808;
	Tue, 27 Jun 2023 17:54:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=TpTFTMpKfGATZ29O4n9fBWj3HqY2NemqL4rVpTv6cS8=;
 b=Cig4w2+QCeOx++Yokgh5B2foptsntENWsgXWR0GVdJu1AqgUk8aybsvCofyR3X1KxbCR
 VzGaHSglh419N4o2JsjPRBgXKcYPpjvjXVywFbkmot3SigBnpalZEnMhFETtmL2IEXL+
 +jWuGIKzbWNmOix/n5ZSU9PdXEkarZ2pCgyR7p22Tofy5+uTxO8ihAZJdXv/cgtnDSqK
 nNxmfEgfYyG0zIZTuNdhcnuNGfsPA6tYaI/Cu5wMHJGP35weHSEc85ALsjhszm62vBWd
 Afh0Fe2PpEB4Y9IbtsZqxpwGJZFR4yN5tD7kUbM3w9/23Oc9Yr/exRjytmgdwDXa8Hsn nA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rfvqjq2ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jun 2023 17:54:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4qpgeJx0EBmna7CTjoNKlkvvtLtvcyQh60OP1VRA5jc/mDO+vyYSFkpg6E+Oin+NG+RUts3XKpfebHRhs/fc4rOtuGfXHhCGOGI49mhLrrEh+4F5OoJTYb0yCdF5tNi3joDz2DotBK5ovT6ciAocqlyJ0j6xAyXznwbm3vDDbrxGmody32bWu5+cwe+uoF9noPZ6SewoRMN2zicVFcNmtTothqWcqwygkmKp59ZMemwYR4YA1IMTyEBi79XQlA8K4f3DYFLUKEYxmcOllMAGyxQuGbTmtjUji2S3x5sCNH70UHsMwR3DusCZK7i2Z5av8AUgYf5scE32fWKB4KF6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpTFTMpKfGATZ29O4n9fBWj3HqY2NemqL4rVpTv6cS8=;
 b=V8GQRGSyQDDKs3qWh02mROBOeWbdtJ+wMvqf1B4NLJ/+K9goyZFB3ixgRWWd5jpsOucqoqoA5r9sFYm/j48AW2L7zqe1qfIjVqKa0zZ/il/coi7eC0O6gw5b7Xt53R3zmlNx02DuuOc/c9Khp4dzmip7l9TJ3KrLkQ+ys9oS1GFL0xZjGt2lhdgK6JFxJOgzN5/ytMNkeVAiWLOBDd70RSaBIrCie7oqTpOTQgOqtcSkUmz+QlvrVI0QcbNB98Q3RhTjzuiQqM8bOvILdowU0nGNL6FZ8ZeETTzkB/7Nb87C2H3amH9kN5+tg5Y+VCcZT3fUA07qD7UrnXb/uwNGew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4902.namprd15.prod.outlook.com (2603:10b6:806:1d1::12)
 by SA1PR15MB4756.namprd15.prod.outlook.com (2603:10b6:806:19f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 00:54:17 +0000
Received: from SA1PR15MB4902.namprd15.prod.outlook.com
 ([fe80::3b4a:9ff0:1438:b7a6]) by SA1PR15MB4902.namprd15.prod.outlook.com
 ([fe80::3b4a:9ff0:1438:b7a6%5]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 00:54:17 +0000
Message-ID: <cbdd45b2-4a03-f11c-f00f-5da90d5dd2e7@meta.com>
Date: Tue, 27 Jun 2023 17:54:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 bpf-next 12/13] bpf: Introduce bpf_mem_free_rcu()
 similar to kfree_rcu().
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        daniel@iogearbox.net, andrii@kernel.org, void@manifault.com,
        paulmck@kernel.org
Cc: tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
 <20230624031333.96597-13-alexei.starovoitov@gmail.com>
 <019fe889-34c1-04eb-31a7-50b3cd40b83c@huaweicloud.com>
From: Alexei Starovoitov <ast@meta.com>
In-Reply-To: <019fe889-34c1-04eb-31a7-50b3cd40b83c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0010.prod.exchangelabs.com (2603:10b6:a02:80::23)
 To SA1PR15MB4902.namprd15.prod.outlook.com (2603:10b6:806:1d1::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4902:EE_|SA1PR15MB4756:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c60f1f-9d29-4af5-b918-08db77723319
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/ZwtbDmubnibQ2OpkKG/GrowFK62w/H9ytZpRiJuRp8CMQMQrIjOYps+Dse0hdXUQ7vyvBLz5PU58ZotLRMYmN8y44r+hRR/K8mgFWaXEHt8u2mSpCG3qpZV5JZSlQreBmjJgiCEeWPOLujVMwuTIv0P2ZQaJEHM3fCCv9UTePYN7bJu1i3jTmlkbaFjFByXuYd6qngqX3ikOyreMZAtkA5sLY4eREFhvu0x2X0erre2DWkvlQrL8wLdtl4AgCLnvn46FNDcS0eb1QFQzEr1Ur1ul77si7SOsmds2KGFMVnlxWah+JzTkKQEACkab1lz8A+If2Yp25pLUx5UdbAx6CSsbhJAotmH0gzgL2JXXkCrDiYpPd7NDTXJ9/c4tLkYs5H2mpevsSg5p/uHQFLcFqk7LFUKIToKFzgqmeLsLE8zm1lIn86p3sXr1JgjgiPZGqKkq2lVIL84Ic9cu0qUN4lfI8YmEotN4EWTcCWuqyKF8EHxEbn3Zn64AVvX7SDS5xV5NBpleZeLJJB136gaElP6mjC/ElO38w1UwpUPRTKhATJJ2NuJM7N3CastWNv2iEnn3JJUXjVDcKdPSGVJGAHqkGplu0hXcJfTALe5jNZX9ncypXQuyvN17OgkZbuemrAbjqfXi1j3A06X+afiXA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4902.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199021)(2906002)(86362001)(6666004)(6486002)(38100700002)(53546011)(2616005)(186003)(110136005)(41300700001)(31696002)(6512007)(4326008)(36756003)(478600001)(66476007)(66946007)(66556008)(316002)(31686004)(6506007)(7416002)(5660300002)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZEVyZVNaWklhZTFjNlhOMFRuQnVMd1pDck1iQ25LbjhjTzB4R3d4Z3kySHRK?=
 =?utf-8?B?c1RGUkorYVVlQlc5dys5YTI4NjNHREZ4STNhWHpld1FaN3NTTTN4c0M5a3Fi?=
 =?utf-8?B?bnNvZlhYa2hnV3puU285TDZhTExvT29ERW50enJZTkZtbFcrdU9MQkJzbWd1?=
 =?utf-8?B?eDJNaUxRbk1QRU9zQVBxM1FudUtnQUdoT3MrbmV4RTRrdG1xL3RORmFMaDFl?=
 =?utf-8?B?TGxlZXUzYjdaelFRaWczMlZTelZVdVgrb0srUHFOSXZ1elpoYitMcEJzWkJN?=
 =?utf-8?B?Z1JLcy83c25tUFpmTWdMbE9kOFQ0SHd4Qk9UUE8rUld1QTVuOGxzc1d5MkVJ?=
 =?utf-8?B?dWFKb29YeWdmRlJtVlIxWEFKU0lYSHQwb0g4bGhDTXYvdnBuV3kxTHNXNHFF?=
 =?utf-8?B?RSsxbUZYMFBuYU5iMEsrOTFVaHFpQ3l6ZnRVNHBUbUxvWG8wSXlrVUFDZEQ4?=
 =?utf-8?B?b0h3MmhjK0g0RGIvV3YrNmR6SkJIMGpoeTluQkNSaWY4engwOERURXFHZGQw?=
 =?utf-8?B?UkVGV2psR2dPZzJtbS9WeERQK3RxdGk2dzlYQThscUJBRWFDZE1yWXdEdDhS?=
 =?utf-8?B?My92MnMyTDBNbSs2VVVnOUhHN20vRlBnd2d1SkRnNndrNzJjWGpTbEtzTXFi?=
 =?utf-8?B?Zm5rQ3lsVjE3WWtiWVI5Y1J0TjRRamhyYzJCNWV2S1pHeSsydVVZK0VxOW1R?=
 =?utf-8?B?eU5DYkRac0VVVnFzQUd3WlBMUFliZm1jRzFRcThvT3ZKR2UyL1AxVXFpbXdJ?=
 =?utf-8?B?Y3ZTQ2I4Z0Z1L2tXdjRhNXlWNTNXd2s3TFFUK3VGV2M4U3N5WmpWVkFEWERJ?=
 =?utf-8?B?Z1VXYjh1V1FTMm1wRDRLMjUvRnd1NDU3b21PdnZPVjRmM09ycDhiYVBybEpO?=
 =?utf-8?B?WUcvc1B3Z0EzRGpiSUVjUGZXd2RITG1hS3RVM2ZxSmp2S1Y3dEszNWUwNFAz?=
 =?utf-8?B?bU5EaHJOYW5BZFc0OU1tZTBrVk9ZZGQ0Q3JJVHgzbFFpNGd1U3N0TS9URzVP?=
 =?utf-8?B?SlZ0S2hLZ3VDZkpGN3RnODlmRStHdXUrc3NOZmxSUndFbmFaak9oVnJPRHU3?=
 =?utf-8?B?ZnpsVisxWnA5dXhhUnU3eE15eFBBYkJkLzJVN21FSlUxYmo1cStEaEZtUlVi?=
 =?utf-8?B?a1hkOFpaZjVRbjRYTWtWVkxReExwUmhzdTJTRDBIYmk3UXUxSm4vckc4a2RI?=
 =?utf-8?B?bjJ0VkM5b2puaGxVcmEvRjB4aUEvMHFybUlTU2Q1MG53Um9POWpqUmhKcUZ4?=
 =?utf-8?B?eElWOUU3MXlJbzR1ZEw5OTcvcGZoVUMxcVc2VjRFTWw4dE5zSEpGMlRxVEJG?=
 =?utf-8?B?Uys0b3hteU5IWldZWnpQYkVxQ0drckZobk5SR1NJVTJ1L0NacndSOElCazdW?=
 =?utf-8?B?ZFozL0Fra2o0S0FxWTJSbXB2QXNiQnc5K2dncTZKOEVsVUhINmFaWnVoZ1N5?=
 =?utf-8?B?SlhXRW95ZVA1YUhQaXZCeUlua0JoR2xnMHNJT3V0MlRUOFZLV2lneDNZamRk?=
 =?utf-8?B?YkI4eDlVRVE4dnN4cTE0VGhkV2RGUC9xRDJqOVE1VVRhWkJoN1ZZdE9DVUlz?=
 =?utf-8?B?TkhFS0tRaXVjTUhlOG9ic014Ri9DYitKL1ZUOU9rK0QyTXZMQ0RsVkpYZmVC?=
 =?utf-8?B?NUFpS1pRR29xNlJlODIwWEhPZ3hpTEZTQ2dXSGREMjhyNU0wTjFaUWw0Lzdt?=
 =?utf-8?B?bU9lTzVwdUhRcWQ2MTdGUXZtYTl4T3dNZWg0T3lFa25kQ0o2ZlA2S3lTR3dM?=
 =?utf-8?B?U0lvZWtUQmVxTzF0ajFnZGh1a0tvRDYxdjE0QlQ5NEtPMXc2bHQrQytwQ0RD?=
 =?utf-8?B?T2tUdVZ0V0QvdEhSRjA2bVo0NExyczFaY2ZQR0NpdkRvcWluSWp4ZGZOaWdR?=
 =?utf-8?B?cGl3dTlYVHlUUU5YTit4bkJuUWQrTk9ERkhyay8vR1RUSi9HZm1kWjFPR1Yr?=
 =?utf-8?B?NHBleFZ6VUtOZDI0NlpsZGRXbjVkdXBDdWlLMGM1eTFueU8xMVZtNmtqZlJi?=
 =?utf-8?B?UForSm1qbVArcjB1Tjd1dmpJcks4eE9QSDRUWmo5ZUQvUHVqUHYrdi82MEwr?=
 =?utf-8?B?K09ZMnpPMGtQWjAvVW5NVitLYnhDeGhsT05xZ3FzYkhJRm9Wby85di8wWGFn?=
 =?utf-8?B?RmRJcnFCb01pVmhuZ05Mck52Nk0yNVduUE5mcHR4MC9wVjhvVEhOWXZYZ3FF?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c60f1f-9d29-4af5-b918-08db77723319
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4902.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 00:54:17.1416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXcT0TURzE/39NkGub7ydY5UoJBtJd7jEbwGm0oG1Ick/BcbHO4omq0gMCrT/Ymf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4756
X-Proofpoint-ORIG-GUID: Q74SOmfZNi1t5nWA_6iDQviV5lcQSaJQ
X-Proofpoint-GUID: Q74SOmfZNi1t5nWA_6iDQviV5lcQSaJQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_16,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/24/23 12:53 AM, Hou Tao wrote:
> Hi,
> 
> On 6/24/2023 11:13 AM, Alexei Starovoitov wrote:
>> From: Alexei Starovoitov <ast@kernel.org>
>>
>> Introduce bpf_mem_[cache_]free_rcu() similar to kfree_rcu().
>> Unlike bpf_mem_[cache_]free() that links objects for immediate reuse into
>> per-cpu free list the _rcu() flavor waits for RCU grace period and then moves
>> objects into free_by_rcu_ttrace list where they are waiting for RCU
>> task trace grace period to be freed into slab.
>>
> SNIP
>> +static void check_free_by_rcu(struct bpf_mem_cache *c)
>> +{
>> +	struct llist_node *llnode, *t;
>> +
>> +	if (llist_empty(&c->free_by_rcu) && llist_empty(&c->free_llist_extra_rcu))
>> +		return;
>> +
>> +	/* drain free_llist_extra_rcu */
>> +	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra_rcu))
>> +		if (__llist_add(llnode, &c->free_by_rcu))
>> +			c->free_by_rcu_tail = llnode;
> 
> Just like add_obj_to_free_list(),  we should do conditional
> local_irq_save(flags) and local_inc_return(&c->active) as well for
> free_by_rcu, otherwise free_by_rcu may be corrupted by bpf program
> running in a NMI context.

Good catch. Will do.


