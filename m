Return-Path: <bpf+bounces-1179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DF470FD91
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 20:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF80C2813AA
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 18:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E902260D;
	Wed, 24 May 2023 18:13:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA733C141
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 18:13:16 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D5DB6;
	Wed, 24 May 2023 11:13:14 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 34OH4xje026238;
	Wed, 24 May 2023 11:12:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ozvlsrdUFxVL7msJ2TVeuqMFas0UtKC4evxtnlAdSA0=;
 b=HRzEiu00hPadvkt72OFUExKP1R4U3bJ/wD01bXLn22YZw38bB2p0HJWsWMoVjd9JOlSL
 mph1necEa/MomX5zSIdFjvnkSoNx0V1NPnEQVF9wz6No0UZ7A0mRGf0lYW+gfxMFn0/B
 GKSASnff07HHuxGAb4ZxKSQ19rYHH44YbmvvBhrE/d3Jby+JA/cQekoa3O9CgEYwomi3
 7Cf9YNv4jF9JnhQMTQpF5T65uh5qZJRD0/jvaTshMylRsSE4GxVYkkmg3LmVVnfAZ3mM
 cVrDVY+N0z0yVRr5P+QCpQr6pjXUuOqtx3W+UMWwl0faiCPGldC65u0G1KrXqyGyLSmf Og== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
	by m0089730.ppops.net (PPS) with ESMTPS id 3qs564f6a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 May 2023 11:12:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWpJUdDibzvSt09mRp/ZICjcQdR62xw1YcOpxbp4s86rTM3nhe03wO+Fm7fH1Fg/wQ6nTTIk6FIDiuAhfNQcC3y/gWg7/P45R/4XsQ6qOJBvqL34n42ghOUYSD/fRVzCpVe1hgvmif/J44zw+oNwXmhj2Ur9QPuOYNE+qsi96HvFEWmDobKxlFTLAJbCKpbfHhuX/23AMuZFV/pLr/vA6al1gXzB5djCY4BzOF7c4x+hm4iihtTII2nrPVUwXG7CcMK19O36/meVapsWNcIxrUfU85Pg8myr+kkaj/mtTm2JKOKsHe0eWPtBJVq+jmSZyoyaONnWXNXgomxT+sZcdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozvlsrdUFxVL7msJ2TVeuqMFas0UtKC4evxtnlAdSA0=;
 b=Wk0TjCD9d1b0ki1DwkXKP2CqiKuQ2zQ84VFX6WJaIg9tlC5KgQftMwOsIYTZtuyVXwsQ9Gyn48NxDoWnufybqILleS3CcicTWFg5sIHHndVUSnZSdvtBaVGsotYOLEWqG8FyfbVpxCMPweFYdnWBnAsSoLv3GkJ5C+IEMUrcfJBITpXbWDDdsjYxQo2p2s8iTR1h/3bzkizJCSy3PHD9O0X3Dex5ydDMeZYCzaWJ5CeDMvy489pbdJikUWGYyqCHTANQnAXVG7bwj4MKswf5SFFXuHn794GIObOG+hqrBrvVWX9v5e0Q1lQEIKZMSalIJgL3Fy/eh9pGpsWJmMN0Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3824.namprd15.prod.outlook.com (2603:10b6:806:91::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 18:12:51 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 18:12:51 +0000
Message-ID: <d809e25a-f109-14ff-420d-50dced7b4dfb@meta.com>
Date: Wed, 24 May 2023 11:12:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] [v2] bpf: hide unused bpf_patch_call_args
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230523194930.2116181-1-arnd@kernel.org>
 <f7b6f68e-f218-9d7f-22dc-3e4bac70051a@meta.com>
 <e23c5155-477b-465e-a811-61945d68fde7@app.fastmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <e23c5155-477b-465e-a811-61945d68fde7@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:254::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA0PR15MB3824:EE_
X-MS-Office365-Filtering-Correlation-Id: f2839dd7-ade2-466c-03e6-08db5c827cef
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Svao23unqxIQMjGGI8mB8iQRYlVyLTKsMTpeHlXNWpxWUQi2JH0SiK7LHVxDojgvpkcBmKd7ugKnoOcF6u7tIB4YBqHCSOTRGoyNDdLmngFKp7TLYt4aSLvXimFfdqteH2EPZpYNAXFwZUOteKpnUTzI01MLqngJqzUuBhroLb8x5i4yro1FF3ozTY/Ken5Suv225dt6rjbJsgvDdgkPj5ZPPNofZVgCXBF/q8AjQb2qEsD3dmSFFEVgIlfYtYahBvngCbrlDMrTM/w88UPAGUFSwZjC3Gxr9h4iTLlrg9OyD9AQA5uKPaxnFm8O8JzreUrqpMiOrKwd78gc7EXwdaJkEJ6fdV3mZbCBDGCATiVQTIjGvh5k0+JInTCnj5Fy+0cw3DoMOFYSIb9LLO8kbTXBSuavtOu0IOCtCa0+FF5fI3ksUJuKaygIpwGMu1Z07FK756qL33eY3ovozhZ+NtzzvcVOntVR30F83NAA+LFXWhETmJ5Z2v/tUHIJ2jp3dWADgW9Hm0ZbhJSgq/uHua+j7BFYTHO5Xi8wV6SkVh2TRS4Ec9mxLQPtpY/tCPxAJ93pLEoc5R8nTtbPvNUYUPyGiSk7HwSlLlxiwEO5R/QM/rgoNo0QQOzUWsSckQi5J63e+S/x7eY7QpwWyP3sxA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(53546011)(316002)(186003)(6506007)(86362001)(31696002)(6512007)(2906002)(6666004)(6486002)(8676002)(8936002)(7416002)(36756003)(5660300002)(41300700001)(478600001)(54906003)(110136005)(31686004)(38100700002)(2616005)(66476007)(4326008)(66556008)(66946007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?enltMXorc0lBTlJlK2xpblJsWFRGR2Z6S01QR2NVRkpBWWI1T3c4MnhVYitL?=
 =?utf-8?B?SDRHSUxWL3JCalpIOTFBMnhDa1orMFBCMVA3dUM3QjYxRis4ZHJtMFFOdzhN?=
 =?utf-8?B?ZFNkK1ZDc25UMm9JRXhQZEVWSjh0bW1CMTNHcTZXcjEvVXVhaFhIYXE5anhG?=
 =?utf-8?B?QWhrS2UwY1JOQm05NUJJUm9QTEx6QmxyYzc0akJocDdrMGpLeVdGZTRiMFdV?=
 =?utf-8?B?K1VaaFN6UEJKZWNjSE4rcUU2NUUvRy9PUUkwZERHZXFSMTBKYUNNSmdUUUtN?=
 =?utf-8?B?SXpxc3p2MEswQ0IzNFg2djl6RG5aazRtL2ZQZjFILzFOK0RDWWhvVmlCeXBy?=
 =?utf-8?B?cGw4eEUyNVp0ckd4dVZ6dy9FU1k4dEtvR2psMER4M2w4eFFScXcreXpsTGV5?=
 =?utf-8?B?eDRvVG9kdTBvMWdRUCsva2ExU1ZFYkVuUDhHblVINVZhSmZDL1FtMmxoTUp2?=
 =?utf-8?B?UEhhZ3hvaEk5c0kxamNOWFNveFNWWitsVnJ5SDBvOWY2TXN6cTZxRHlVWE9W?=
 =?utf-8?B?R2dEdDArR3JZb0ZXVENGL3cwWlVwT085WllKWXNHa2UvRXdBTU54eHNGNDVu?=
 =?utf-8?B?YVpic3RjaCtJMElvcFRUQ0dHSTN3a3c2MjRFejlnejdVU1VJL052cGJMWGQv?=
 =?utf-8?B?MkcyU1R2VkNMeGluVjJRTDZzWnVsaHEzUlozZE5Mb1pnMGVxUWI4eHBJc09Q?=
 =?utf-8?B?bTQybEdmVXk5b3MrOVpaejlYeGd1WjZyQ1hqOUZEYmxMUU5KbTd0UlhwWDlC?=
 =?utf-8?B?bE5DUVRUNU1CU0FSTDJFNGJPbkhuTTcwL0EvRndTTWlHQ2J3K0lPakxSUXRM?=
 =?utf-8?B?TUFhSmFyNlFzeFJ1K1Bra3RWYWhHR21HVVdnZFdZQTBTY0FjOU5KVzIwaEg2?=
 =?utf-8?B?czVnNHZwTld4dWw3TGNEdG8wT3pVU1Q2N09lK3g3V3JSSXJJUHI2WFJKd2xm?=
 =?utf-8?B?dW1EQVg5S1B5RlZBR3FZUkhPVk1qYmhPUDdXdTFuMjhmRXlaTWVJbzllc1Fo?=
 =?utf-8?B?RlJUeVJEdkswZHVrQnBKVUxrdnU2NHZBbHVoekhPdWZqdUdVcDJ0c3IydmY4?=
 =?utf-8?B?VDVWSGRkb2o2K2g1N3cxZUJnY0lYZkJ5aHQvbVZ3ekRKR3QyZ2NxaUJYRjBJ?=
 =?utf-8?B?d1owWkRIaEVGUXNwWmQxVXV2MS96bU11MUhNMElSWlRiR0d2Q3YxeERwZy81?=
 =?utf-8?B?bVFIeHN4c1BPazY1eEVmZDRZVTBlQkwzRi9XalFCYnh6V0I0enZKbkJOdzY1?=
 =?utf-8?B?VFp4N3V5RVcyYWw5emxMeENSYUZaUG5mUldiQy9RSXlXbllDa2c3djU1V2h6?=
 =?utf-8?B?OW5XK3dGUy9uakJqQnR6ZDZOYkh4Z2JlODZ5OHNzQ3RRVzluOHVGbElTa05i?=
 =?utf-8?B?bWIzUEx2SG5GeVNDK1NKcGxZVWNzeGFpTXNseWxSNHpZdmZXT1FmNHFtbXZI?=
 =?utf-8?B?TzlIZitrZmdMbm90allXVVdJNExnS09peHY0enlLOE1EZVlwRWkyYTZxRWI4?=
 =?utf-8?B?cjZseTZSZlllQ2l1RDJJc04vUE9TaVNLVWc2amFYS0hQR2VoWVUvdEg0MGpW?=
 =?utf-8?B?WWxTQVNra2w4K0llTnp5d0luU3pGQWNrOFQ4K0k1bjZBdXhQYStkaUNZcjhO?=
 =?utf-8?B?MkdqQUZBR1FvVUR4ek5TeXpUeWVlNzFFdGluK0o2eHFvVFFJdHA2R2xuTmRM?=
 =?utf-8?B?SGduRE5RRzJEOUF1MUVKZUdkS0hYdUgzdkttZ2dSdEgybFNEK2JKRVFXUnNx?=
 =?utf-8?B?VnNCVmp1dnh6RTY1ZSt3UDg5L3JKRVpSMU43SkpCUGhZdkVFM0lGY0REdDhG?=
 =?utf-8?B?eWNNVFVXUWlHVjd6eVNMY3l3NXEvYXUrMDBXWWR3ZWppOHd1NmI1K2JwYWty?=
 =?utf-8?B?WEpZUW9sWnBXYjZ3elBRdXpmUEJhZ0t5WUY2STF2Y1d3d25remlSTkxmQk5C?=
 =?utf-8?B?dTNzSXFYOXM3by9JM0FIR2NCRVpLbTJkclBIb09HWk1hZGx2RndULy9mV1J1?=
 =?utf-8?B?YTdmVWJOMSt2Qmp0NE9kR2dZTk5xdlpYRytCQllMVzMrb0VMZ1dobVVhcERu?=
 =?utf-8?B?TCtpTUdLdW5Ba0tuMk1YeThVMnZIT2tsb0t0cStIL05rdG05Ui9kbXhDZyt0?=
 =?utf-8?B?TkwwbzFrdlRZelBQRWVsVjlZZGZFVm5Xb2xjUEZYZGk2N3IwaXNROHE1bkwx?=
 =?utf-8?B?c0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2839dd7-ade2-466c-03e6-08db5c827cef
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 18:12:51.6570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29zDZLndHFNYNc2kH/hC76kpmvG2Qm5gYs8ZX8Ksy1HDvYiYLLqVgsW/yWq4oXcd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3824
X-Proofpoint-ORIG-GUID: PObXq0I6aaOKgOCS0-xKr4Bjq_aokTD9
X-Proofpoint-GUID: PObXq0I6aaOKgOCS0-xKr4Bjq_aokTD9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_13,2023-05-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/24/23 6:23 AM, Arnd Bergmann wrote:
> On Wed, May 24, 2023, at 05:05, Yonghong Song wrote:
>> On 5/23/23 12:43 PM, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> This function has no callers and no declaration when CONFIG_BPF_JIT_ALWAYS_ON
>>> is enabled:
>>>
>>> kernel/bpf/core.c:2075:6: error: no previous prototype for 'bpf_patch_call_args' [-Werror=missing-prototypes]
>>
>> If CONFIG_BPF_JIT_ALWAYS_ON is enabled, the definition of
>> bpf_patch_call_args should be invisible. Maybe I missed something.
>> Could you list *ALL& bpf related config options in your setup
>> so people can reproduce you above error messages?
> 
> Sorry, my mistake. I've reworded the changelog now to fix this:
> 
> | This function is only used when CONFIG_BPF_JIT_ALWAYS_ON is disabled,
> | but CONFIG_BPF_SYSCALL is enabled. When both are turned off, the
> | prototype is missing but the unused function is still compiled,
> | as seen from this W=1 warning:
> |
> | kernel/bpf/core.c:2075:6: error: no previous prototype for 'bpf_patch_call_args' [-Werror=missing-prototypes]
> |
> | Add a matching #ifdef for the definition to leave it out.
> 
> If this makes sense now, I'll send out a v3.

Yes, the above new commit message sounds good to me. Thanks.

> 
>        Arnd

