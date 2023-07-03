Return-Path: <bpf+bounces-3929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB24746635
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 01:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB36280EE7
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 23:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD32411C9A;
	Mon,  3 Jul 2023 23:37:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3013C3C
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 23:37:09 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900EDFB
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 16:37:07 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363LAVnD013814;
	Mon, 3 Jul 2023 16:36:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=7rwyXm5oEuYDngc1UXwL5NHBmpvUuyBu/yZG8G47YBg=;
 b=JGbN/cEQfuzRSaxfIAxVyDbU/UDk8UTJiwmB9xbz4QOzsqcHLDbyJ4hmvzbIu/SR0Me9
 eowy+J5IishuCePRI2JIEMTrhu1pjZO9Gq0oES9fvpxX+VcCj2/i9sNkMDlANKNC0dal
 iSBzyYgcX3gZJcPAYxCG28b/fZuQhB+Dp59q34jaSJJtMMTnyzrgf9sVuXdhMN4XP74h
 tshS09uAVNDPLOIGLhfl+mlYBjF6PwReNr3zvL0YC3hwWLuEKzittH/cal918vzo44Gu
 7Uf0f8V8dqOqgwF7Lh5SfQ7NblGc/o+vyL+vH2buDxgzXDq65ATp7bUyif7Eaz3N7wiZ 3g== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rkkmnr2sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jul 2023 16:36:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvgvi1Gaq89X3mgWReL3OjBKWjm6ubqYqEben2kejKalKtIx8GyD2LT6GALdt0/FSYZ512crJ804GnScNjHJk173sNfRx2AwHwCjaalnkCQqGXCLXCfGMuJTS5kpc0gB3/2YNMDK72F9/ImOjBXxDn+VHFWqXRCaWd2+a/XbyZLONWVwExpmqvXTUjmx6MJYdm+e4wNFG22oi8k0KQm4rw1/UK7OTfmkBwfuzIFysNLTSwJeuoTzOl4P8c3JJgt1ihNuaAiag+GOqFP3I3N/IuDwHNvgHvj3Gs5n1uD1P15f8XdE0n5niD9Mr8wyHLxg6+YZxHzQ7Tpj4IVbo8axyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rwyXm5oEuYDngc1UXwL5NHBmpvUuyBu/yZG8G47YBg=;
 b=CObwuHxzVQkPuovgFUfZ2BcjoG0sNefeQ0DHBqZqWNkT4Mm+UPTkY5WAbkuxhKBOyYZVx8rVOuR78kyO8P9qeHs9iq8UWtQXxQF7RXFIDWjxE2y/ExcjemFqYMM1WGqjPkjzEBUTUR6rq7ez5UFYSUwc8yoVqP60tLUUOD/8uK2gw2kfI5iRkOYjs0w7AbeN0V0IJHa9Vhee9su8hdumex8nNSiY8Ce3BtU1tfKxe9izkOT5cwHllagDrnybuEZUSbtf8/VG8FdGp1I+j3AK7e/AflqrIxf/F5HGHQ2ibHCsUBOvr8qgNAzwZ9Ke5oGS6SQVYX0NC65N/+qmU9Ai+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3942.namprd15.prod.outlook.com (2603:10b6:5:2b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 23:36:45 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 23:36:44 +0000
Message-ID: <7a8c3a95-9556-5f44-1f97-4ef07bd4ffd3@meta.com>
Date: Mon, 3 Jul 2023 16:36:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Support new insns from cpu v4
Content-Language: en-US
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Dave Thaler <dthaler@microsoft.com>, Yonghong Song <yhs@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <20230629063715.1646832-1-yhs@fb.com>
 <PH7PR21MB38786422B9929D253E279810A325A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <1b8e956e-ebfd-bfa1-713a-37c8039bf92a@meta.com>
 <klq6m6gvliobcibcq5icuz6wst33xhe7rg6cs3kr66y4kkiug7@5r4mk44zjfkq>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <klq6m6gvliobcibcq5icuz6wst33xhe7rg6cs3kr66y4kkiug7@5r4mk44zjfkq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0166.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3942:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d67b2ef-b26d-4c3b-bfb2-08db7c1e5c7a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+2HI2N3uxpVQIii0s6UFr5ODHfUyAvs7ScyOzW6n0H2Jx8eIMz57mwIrlA1erOLDVvwuxuvD2sdodvc8QdbIugG4nK1u4WG95qfRW6Wyn44r9159pu3mztnLBJrU/uZPUHQVswl6VJn9M4U8bAiz8cJSbwOMrNmKQgs9GcHlqhYAqa2WWZfxix7LUriMy2pzOpqNS5bf39zYo4e+cwEIa47x0OcdmKa/E6dEA6KOTKhSlJDdBBaPQO8ZKqGAy0YC/vkDz61gcfu2xZRQRq8QWAyMcLzj6qzVBWkVyZXPmoA5mtw5j3NDQKOBvD4JRlZHSE4SESZLRibXSGi1Asr1k3akvRQQqfogJCbDxamwOnUFi7i8ADgQQyNcwypqIv8LAoNVnLUZeZvCst4rH5ndJAdDvtHmYw3/aytgx8Q/tY68xGIboGQClL98OMFluIMtNYKGEMwguQ7SgyHPDfj2QTKeeeErb1/wJqHMlyQZmD0IFAQKiucBZ7gYuMAjUhmbGER1lF8hUH9zWC5iRsTpyZay8zOQrdzqkk9M/ukpzFL4Cu+k5O8hDAnXfg9VpUK90rahaaE/jfQ1hCRDz5t0N2SvDukbhq/6yD/rpLwHgQuWNKphKGt6hLyf797tBcsEuuKBsLqRQp12fdIGybDNQA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199021)(4744005)(2906002)(41300700001)(5660300002)(8676002)(8936002)(36756003)(86362001)(31696002)(186003)(2616005)(478600001)(31686004)(6506007)(6512007)(6666004)(53546011)(6486002)(316002)(6916009)(66476007)(4326008)(66946007)(66556008)(38100700002)(54906003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NWdUbVpybS9adURobXZ1ZVYrcndJMzU1cjVqM015ZE1mYnlrbFNaSkRrRGFN?=
 =?utf-8?B?L2FFZmpvQkRsZ0pIOFRld3F1bVYya3ZCOCtaaElFaEtZRFVhcVdSd1g4eUJz?=
 =?utf-8?B?ekNwTXV3UXN2QVRrTHNicCtpazZSUjdZL0ZIc0kxNEp1eHdWZkRZTkthWlRq?=
 =?utf-8?B?QjQwZnh6dldTYWFDUGw0ZFZVU2RERjA3cnNTM2NFamJiWmRzb2JMZE5id3Za?=
 =?utf-8?B?ZWVibkl4c202NlJnbkdUT2lsNHZjMmdpTHU4MlY0ME9xM0ptdzR0eFF5b3pO?=
 =?utf-8?B?VkhpSHZKQVFRZG4xd2hSR2FmUnVrTjZ6KzBsVml6QzVEQklyNFozQnR5ZWZE?=
 =?utf-8?B?TURMUlBiZXp5b1ZnQ01RdU5PTkJ2eUVMOWVzZkE0RXh1T3BLcFNzeFhYcFk3?=
 =?utf-8?B?dUpJNGtDMFA1TklJWTlqT0lkRGorcXl1WHM3eGVmNEEyK3ZXdkdaOFR4ZWJt?=
 =?utf-8?B?ZU1Jc00wNjhWQ1p3UFhXQlVVam0vRzBMaWhicGdrSVNEK2V5TThSamdER0hZ?=
 =?utf-8?B?LzNEY3ExamhuWU5LemlFbWNzSDNSMWFjWVR5K2tYRWNuUm1Ubk1nNGVvR1RG?=
 =?utf-8?B?NTZHRXd6aW16QTNwMys4d0hWd2RvNHZXTjBNb0hmZTdWOWVueXp2Z01SRTVw?=
 =?utf-8?B?dG1WUVpxZm5XN3VDR1NzWHFzdmFTQzFZWThtd2NGREV2ZnR0MHRnblFwT08r?=
 =?utf-8?B?Z2t5RHpCaUZaZ0hSNWN5UzJuejJEWFRmUGlLajNac1FLYk03N3A1WHduM0ZS?=
 =?utf-8?B?bVcrTDYydkxnYUltVi9RbzVSclh1LzR6dnNETXRtSVB1anExbjVobmVVQXNE?=
 =?utf-8?B?VkRvU3piWk05dmNZb0JycFlqWWE3WThJekNpV2hCYXhZWUpQMURsL3Y1ZjFS?=
 =?utf-8?B?b3NpcXdveGhoSWZBNE9Qc1VqNVl3a2c4UkJaWVpxM2UwMXFZclArcG9LOWVC?=
 =?utf-8?B?anRmSXMzSk5IM1ZjUDB1enB2VzdBSWwrWHZ3WHdkVENpY0h5MVEwa1phMEdr?=
 =?utf-8?B?UkRSNzREanFkeDBaTUNJV2MxUVhGM1krU21IZnFZSFVSeFJtN0dnMW5QMWh3?=
 =?utf-8?B?K2tiaklSRm5jcFluSCtQQnFFWjhpMWNkUXNZK2JHeGNvRTFraVJVM2pkcXlw?=
 =?utf-8?B?d29IYmJxcEdUUkJvUW9tdUZwalcxZ1JkKzlFYzlDN3lNS1Q0MFJQZ2ltdTVU?=
 =?utf-8?B?eDFIeEpxWnB5MTAzc0QyNlU2dUwvZ01hZ0tOWllwbUd2NVp3QzZOVC9pUjRk?=
 =?utf-8?B?Ymx6aVY0cEF1aG1oZ0k0bVhHQmtsUmoxaFpDeVQ1cUZBZ2YzODlpU1ZUb0hT?=
 =?utf-8?B?QnRaR2Y1R0R0T3djMnBJcnRVdWZuWExMajdmZzVtZ1RiT2EzbUludHVCek5F?=
 =?utf-8?B?ajg4aExDTXE5Z0UvcWZ5VWlwUUE2VVFGM05hc3p2a0MraHlkdndxSXQ2TmZS?=
 =?utf-8?B?Z2hzc1dBR3NobU1wVWZvT0FqanFsK1REZnpBWGppUmJVczJBMDBpcVl5djF0?=
 =?utf-8?B?OFU2OFlQNi93ZXB1Rno5T05QSmVtMkVPSWZ3NnM2cmJZMWNTWFhIaGNJM0Qw?=
 =?utf-8?B?V0gyQjJxMDZmdFNUR29tSWdRbStQRGZZWi8wNldHSGt0bndYUTY4TTNYWnUz?=
 =?utf-8?B?TTlPTjN0Mk9wbTNxaEtrcE1BcUE2ZFBORVFJc0V4T084RWFGa2Nab25xZWIw?=
 =?utf-8?B?Y0svNnROdHZ0WEVpUzN2bW1KZ0k3OGxxanBRbWg2K0gvb01GNXdDWjVDTyt0?=
 =?utf-8?B?UUF1WDgxRUlmd2dmSS9UWWk0R2Rvbi9vOXhuSlNLTnV1QVQyWFp1K1BMSDJF?=
 =?utf-8?B?azk0b3NFZElvK0Z3bVBJVC92dkl0T3c0N1poRU5wQWVhSDRIQkJnNXAxVlRD?=
 =?utf-8?B?NzBNenZMMHlYaTNxYTdvODluUkdMcnB1Si9lcXpLMlU4c09wRXFsNFlUMXhL?=
 =?utf-8?B?QUZ3VTVqRE00T2FLTDlNbkpiWVNpQTg4Nms5d3d4Z2tVYytBTnp1cjVKMkh2?=
 =?utf-8?B?TkZJUGZ1alBqbFR0MWhJbnl1Z21pTTZHOE9Gc3V5YWVadDhjNGRhRTZjMTJD?=
 =?utf-8?B?ejdXektQbngzOTU0eG9VZTdWenFZM1ZxdFVYTkpUVkowMktZS1pMQ3NRektx?=
 =?utf-8?B?b1VtamkrczFUVjBicUw3VjNCdWZXaUNpODZNOW9yTlh6SEdNajIzaFZPdHNL?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d67b2ef-b26d-4c3b-bfb2-08db7c1e5c7a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 23:36:44.7073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/u1foggHeLeMaFu8lYLZXHKzjbo9Siy5nmuHxGPnzFv2KyMkJ+rcMCwddkc/iML
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3942
X-Proofpoint-GUID: iUh7B5j3WRF_47zHiEZa-OlH5XweYPc-
X-Proofpoint-ORIG-GUID: iUh7B5j3WRF_47zHiEZa-OlH5XweYPc-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_16,2023-06-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/3/23 2:11 PM, Daniel Xu wrote:
> Hi Yonghong,
> 
> On Thu, Jun 29, 2023 at 07:17:56AM -0700, Yonghong Song wrote:
>>
>>
>> On 6/29/23 6:42 AM, Dave Thaler wrote:
>>> Yonghong Song <yhs@fb.com> wrote:
>>>> In previous discussion ([1]), it is agreed that we should introduce cpu version
>>>> 4 (llvm flag -mcpu=v4) which contains some instructions which can simplify
>>>> code, make code easier to understand, fix the existing problem, or simply for
>>>> feature completeness. More specifically, the following new insns are
>>>> proposed:
>>> [...]
>>>
>>> What about also updating instruction-set.rst?
>>
>> Will update doc in the next revision.
>>
>>>
>>> Dave
>>>
>>
> 
> I think bpf_design_QA.rst needs to be updated as well:
> 
>      Q: Why there is no BPF_SDIV for signed divide operation?
>      [..]

Sure. Will do!

> 
> Thanks,
> Daniel

