Return-Path: <bpf+bounces-3741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AACE742823
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 16:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABB41C20AB9
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38C5125DB;
	Thu, 29 Jun 2023 14:18:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C6E290C
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 14:18:24 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98DB2D52
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 07:18:21 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T7ZOZq013083;
	Thu, 29 Jun 2023 07:18:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=5yl8M4Lbkz5SScYPdXBHpzmWEwxjZnTQ9/lcEutYm8o=;
 b=YXKoel6lC7lJs0MWqhN4aMp3m3fBHQ2H5nr2q/sI2HADSeYJIbN0ZGxvoSixmNVIttRS
 Wfh2fd+HkD+AIwgy89kI1jguojRamWKbhUR3pYzJFDRHhK9CBRzyAVn3pIcbEvMbiHql
 0Q3DfQ3e4LKpM0HPtU5KuB+7uiPF14A1qmRwGFt0kPrn+Yp6rOMFanU9Ax6Y4JS45+HK
 QxvOeonfQYzedWvUy2lqL1gA0oZtzvvfZxPBpm+XVWLqr/AwE4/MyFqNmyT91d1ZB/UB
 o1L6FJJbXs+ZBFqQkF5GTv30x5ttmr0CxbCB0jGmaXJt0exeKNUnXbuB5VZDqYGGABLC 2Q== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rgynb4wmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jun 2023 07:18:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0IXA70xpTBkd+s3bvAfgZzLW5MX3bXoLxSfmxUZYs3z3L+W/mEtTIvcDh5ttidJSHiWv3W8kRDnCitEvQooYj5n2Ti7Cq7GdOHdpqIWIA0xRqVJreR8Sw0zXnhumm3wl++m2LIzhNsiPSFi6Q5h5v+LDc3sKSoGhsIbdW0IBAqlOzmYMGFT6x+RY29XuFOkpr192TDnJSAXH9JJ9Mjitw0ODjhxawqnffN0QMA8GSaMDpLJoJ1jD6LejI+CfKh8GyV3waEIlM6mY07viyj+B4pAviivZmKtHEbG0lkdIsjcrrbyiusvpVtRiREK1M2ZyGSAjFa04P2cY8PjrQKIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yl8M4Lbkz5SScYPdXBHpzmWEwxjZnTQ9/lcEutYm8o=;
 b=LVHv7NNiMnGOsFM7MvIh6WQZ5ckOAysNKg1vTZ+XHlCmEHHD5ibVQY2zTQ6gNWQAIPG0rYaMchfnbt1nrQCvXyxHEw1jO5KrjUeYFFwFR3BUtfTv9eK27Jw3+WsowGGcqJCgn2j+iMcT+gXoTGsW1hC/HNkOkEUmOEY6cRLPK44aJ5GRiL+xEb/Ep63nboUtFlvvTfCqdtkQwRZqugEDth21xHWF3ZgAIBOaDLalKBkG+fpoQ8fKEw3dUBrtsOS2+0hv2ggGUeuZOKrE89MXQVfQTp7tGu+oZNQa6lU8BEcTkhlqf1WRncmMy66A6KGywh0AKtgMSYk2ZKT42mKjgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO1PR15MB4890.namprd15.prod.outlook.com (2603:10b6:303:e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Thu, 29 Jun
 2023 14:18:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 14:18:00 +0000
Message-ID: <1b8e956e-ebfd-bfa1-713a-37c8039bf92a@meta.com>
Date: Thu, 29 Jun 2023 07:17:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Support new insns from cpu v4
To: Dave Thaler <dthaler@microsoft.com>, Yonghong Song <yhs@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <20230629063715.1646832-1-yhs@fb.com>
 <PH7PR21MB38786422B9929D253E279810A325A@PH7PR21MB3878.namprd21.prod.outlook.com>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <PH7PR21MB38786422B9929D253E279810A325A@PH7PR21MB3878.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CO1PR15MB4890:EE_
X-MS-Office365-Filtering-Correlation-Id: 38663353-4e15-43e3-3ac1-08db78aba4a1
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kW6Mpf51GKP8dTkqTe27RoVp7b4tnCavJ6dgk2mmHQgMZZfL4rSgXkIk7XnDHiNrPyjQoH5lFyroLD8Uj0WbG8EYxrEMHorlUzrsza2DQk8052H/uCrikLqOQj4qhbxidqzjwhCS3xUV1jhH3NPT4np8eJL57pzivV3Xm0/d2cTwCj1vYo3SDb3sFVfj2u3BP2bZ0mDdZ16qDZJnQM/s3JipYsLCpkpz5/aYNgWpgOI00M/0/ZWCeV0Van9cdnbrrZrK9RY2uE1QrkMKP3pQ4h/uNG75iF6ERhlypOGOvXiuK1tq3XFFYU0imarcG/Muo94yrWTLSp3DXd26rvvI2YAtws6A59HCMOna+MWzi9nHG92U9VU3Y6tV9oGM9ZxOfL5PebTLmh+VxJyo3M2DjHfyLYKDemcXsAAqrE/MlGnSI923YwsZeyb91to1oTcO3bOwcMFqc8gbEaDu5sCqRPioUtjEiCLrdKR5l4n1pIAWjYJYjs0K82IblzLncu0uHEPtunahe9dM6a7HMWqVuNzXVi3XETi+ivRzcbdBKmT6yJpWSfdhQOXdPPWRFDcqxY1wqR9QpkQYlVTyVM8rew+oG5lzAet8TQdtddEZ+lLuD1pLtoLnxzpEeV74jMhBZvgVPZmKDKiQCMQp9AH5Ng==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(83380400001)(2906002)(4744005)(2616005)(186003)(316002)(66556008)(66946007)(6666004)(4326008)(54906003)(66476007)(110136005)(478600001)(5660300002)(6512007)(8936002)(6506007)(53546011)(41300700001)(8676002)(6486002)(38100700002)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OU1SRzZuQUNSSEwxOVZJdG9uS0FJUzFab0VhY3h3a2QyQWJYUGw0SXVCck04?=
 =?utf-8?B?QTJPc2xLaTVpeDVWMWQvbTZiWVI4Z0ZBY0R0dU5rSXhzbWdXbjlPaHJyZnFv?=
 =?utf-8?B?b1Z3NzFzWVYxNTByR0Z1dmtlLzlyMVFwN2ZqOVlvU0ZIT3g5M0k1enNDSVNo?=
 =?utf-8?B?ejlISitlcElwaWNYRFJuYWdDOVh6bzZRdmUzTWd4MFRpbWJvaU9pRy8yeEZY?=
 =?utf-8?B?NGQyZXNQUVZtakpWUkdydy9UWEcxTnVsSDlnZ3VhNUc2V0FJQjJzaHY5WnhR?=
 =?utf-8?B?Yi9XUFNBRm9Ra09FYnBCZDYydW9OTVowdFNMMmhNUHJpeENOQlJaeUNWYmdX?=
 =?utf-8?B?anI1bmdVTCtHajN4RzNPdktpbXhtSUJoTkFWdTN6Z1hJQUFheXEySGFldDh5?=
 =?utf-8?B?b3NPQm02OFdSUmxoamlvUlRNMGhPTnp0SVJCZGFqYXMwVUd0SjNvazdMdFIr?=
 =?utf-8?B?aUl3Z3FXYm9oZW9HemxWSDJPRkN3ek5YSS9UQXlONFRhUlNReHB3WFJtQ292?=
 =?utf-8?B?NGxYRS9ZZExqbnltd0s3ZWpCYnRFbGRuUzJ1emtHUDZSY1VaRFVZTS9VNUZX?=
 =?utf-8?B?YXA2OHFlME1aRnowTHZMUU1jSCtBaEYrWXlmeldzRCtFMW42MjBHM3V4bHFJ?=
 =?utf-8?B?ZENaaHVYNGdYNy9ydWx6Y1ZWc0ViaEU1czRaUmNmdmhOVnFMTEF4ejlIRkYv?=
 =?utf-8?B?L2tlWVpEZGhyd1pWNUZDUnF1STZ1T3FMamRNZkRXSEdUVFFnRDJJNG1oQi9l?=
 =?utf-8?B?UVQzdTczYVN4RG1KKzQzZmtVVGNqTTlWSmcyUkljY0o1YUQzclRzclJKczJ6?=
 =?utf-8?B?REVuMmtjbUtOa3JXdkcvVS9EWGpvdk9aK1NuOWMrbzNZY1VIbXYvaHVlYlVv?=
 =?utf-8?B?em5GeWxaaXovVXdqNWdMYk1yS3FLMGhmTjlubGVxK09QOXUvVzV5MUtTeExC?=
 =?utf-8?B?MUVtaFUwOG04ZTRvOXZZLzRSUmFiRm5HTWVMemZXRnVtWkRGM2NBQXZlVGRN?=
 =?utf-8?B?MHBuY0l5c0REM2VDankrc1BHZlhXQVFFVW5OY0ZUUCtMTnllM2h1Qkd3TkVD?=
 =?utf-8?B?ZldTVDVpNmNianBRV2l4ZGxReFRLNXVxMCtOMCtDNlMrZkJQYkZPOFVCc3pq?=
 =?utf-8?B?Q0xFWFNjVGV4aGY1bXZTV242V3FVZ25DTnMzWnBUdjZiUHYyWTdEMXZzVllF?=
 =?utf-8?B?YzZpeEN2SFZ1eHAwU3JWNDYrYWZreHBaWEMvbjdaMlFZTEdSRDBteFNVdDcy?=
 =?utf-8?B?eCtUUDZhaVIwQ2JaRkdPUFVhMkxLWHVuSlJKTS9tYVdOU3JqbzhVWmFES0lC?=
 =?utf-8?B?L1dRN0hQdStJS2h2SWVScnJzeEpNdjJSeDhEekNPZStqbG9GR3ViTmEvN25W?=
 =?utf-8?B?NEswQy9tWmRrMytjblZBNGhrbDF5ZXc5N1Y2WXJqdUVSSWR4Y3doWlo4L3Bo?=
 =?utf-8?B?T0tRM1RZTm5vR0hNYjgzNEViUWRZdHU3alc1UjIwZzg3dXg2NU5FMTBnQkI3?=
 =?utf-8?B?OUV4anJmNWhyY2tMQlByWVVTd1RxUnAreDN0NXY5S21Zd3VtbEQ5cjhiYzlx?=
 =?utf-8?B?L3RnSFlFRG9UNFZySElUZ2Z4WWtreW5mQlluYzRFUTQyclE0ZlgzTmpibVVy?=
 =?utf-8?B?YUh5ZUs4RXArcDVhMFN3Q1o5eEVEbXgxNXROem1FeUt1TklFRUE1VndsVDJ4?=
 =?utf-8?B?NzFROThnV1RMYVlYb1hnM2FpcjgyQWJrWkhRbis3YzRUeGFGV3FKVWdMNGdC?=
 =?utf-8?B?cTNxcDZsNGY0OVBEQThWZDVBWUhHcThEWW9ZTUhOTXg5S2crcW1LbDJIUFhY?=
 =?utf-8?B?M0pzWGVnTEdNbkVKaDExVE9xQmVyVXpTSnZmYXpwYjJLQm9qZWRVbEVzeTlK?=
 =?utf-8?B?TlZxM2I5Rk04R25zNVQ3ZGIyd2JZamlpcWxJRk5NNFlGRHpxajdjVzRDdEdS?=
 =?utf-8?B?UnI2dVJKd3JCT1F4NFlTcUdvMStzaGxtZWZVZWVnZWtycllWY21iOWt1WGty?=
 =?utf-8?B?SUFTRG9Sb20waklwdFIxMWNXdkV6ajE5dFVXdllObzJJbWxsd05xVGVJWlRJ?=
 =?utf-8?B?aG95ZVVkSnp1bjhISnNYdUFLRTRzbEhNS0U3Tm5aZXA5a3FWWStJRmNheTBU?=
 =?utf-8?B?SjE1KzU4ZmZ4czEvRXpxVHFFYVYzL2EzQldYK2JXa3pmYjI3eW94NFFKcFVE?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38663353-4e15-43e3-3ac1-08db78aba4a1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 14:18:00.0929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofl+tRp7yvf0k2vZLJYRkAAqeE8MS4GVt1KjZ8Tg6v5ycjUen1RSC2s+k9efnwYi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4890
X-Proofpoint-ORIG-GUID: l2D7YRYzE_sPHC4VuXFWhDzg5ipqYaxK
X-Proofpoint-GUID: l2D7YRYzE_sPHC4VuXFWhDzg5ipqYaxK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/29/23 6:42 AM, Dave Thaler wrote:
> Yonghong Song <yhs@fb.com> wrote:
>> In previous discussion ([1]), it is agreed that we should introduce cpu version
>> 4 (llvm flag -mcpu=v4) which contains some instructions which can simplify
>> code, make code easier to understand, fix the existing problem, or simply for
>> feature completeness. More specifically, the following new insns are
>> proposed:
> [...]
> 
> What about also updating instruction-set.rst?

Will update doc in the next revision.

> 
> Dave
>   
> 

