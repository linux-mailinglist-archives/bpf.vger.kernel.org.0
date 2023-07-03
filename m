Return-Path: <bpf+bounces-3883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9D6745FDC
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 17:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B851C209A0
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 15:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A533E100BE;
	Mon,  3 Jul 2023 15:29:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E1E79D5
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 15:29:43 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AFCE44
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 08:29:42 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363Ac9vi016233;
	Mon, 3 Jul 2023 08:29:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=aESfj3ml4m4qTMuZHdTFPqEN3QI+UZTZbOD9OeKgPEc=;
 b=QvtH5Ep0kbiBiZXFgFe3IPkoncN+/lBzjDuJVddtr/921g3tXDuaGCaXxLySfPl/VYE4
 VaK/5FUlaaqXvIMNjmOp09/aHoUPR2SH3hiLXmGLiI+t2/Bl+A2BuzpWOlNXVHpEdcs+
 r2UPXTVaCxyDPspR9pD3wehRn3zshkFjSYP7M9nygmBfIH/ZiANKzH+EWW80pZh0iSK9
 20BvwwrgUNCBl31ISwEvif6KexBVHrnJ4rJHmYHy90h411t+3U7LBiRWIt0dIea4PZ0g
 I4wtwu3VvXAh1QcPrZuLhz8T3KAAlRV05u7f5BGNaveV6gK5VcV34bCefZyar1RWoGQT 7w== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rkvrestm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jul 2023 08:29:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geLB4vyHc9gn2GxSuSX0TE0vIigmhGp0Ae69dc2Y3Yqe49KcGELeToHn9pFTZVZRUjawTHrNY37uKZtpQ2gqogjkm84sCcf7SmkSRznWKdb3xoMnnzbW0L5vqYMyUTeLoWlodXFcgRtQ35463zig3F0CPUBL0WRCNqiU3/Mxdrpr44m2xoQCe2tVXUZsnH+ClLc9HRk8nH3QcXIyUm+HKx0UuMC32Rfi0SS4RyHN+LGLs8qK8hLAGA0TW+aLqZwPmbsHQ6Acmx9qbomHuxKFB9GZNiieyhP+HcolsXmEgM93UVM4YAuO87Mm0aH+pT0E4Jp+p0o2Vs4fmMJaYVrrKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aESfj3ml4m4qTMuZHdTFPqEN3QI+UZTZbOD9OeKgPEc=;
 b=ivqexP1EV5jfZc6wviOrJb49WZh0LRZZjSJrGvn4QQNy/LjYE37+BXrBsAyk5JOB9tc5ocStklndkVvSCpFS9iDxw7vQ3ad/QouRvPI94V5d0Hd8QoBX09+2zmtDeXblz5zvdlIDy3ZegtJgC7OYYdDX0WpWkwzUYaZmK2fEE34Ulhm6gm4wMBrJBvvAi6BWIjXsSv1Q7wYpDiUzSKCPJjG6duwTk1iftKpnZSYpncSuTf34mfwGILoEb/DWNbCfMPUgnoDf8nkWx+1OX0BG3oT8Q/tPpIH1VnOPT3Da03aZp/3t2XgTHimBZXaXdO61KZ86k2dPlQYGQSBDpzYYlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ2PR15MB5833.namprd15.prod.outlook.com (2603:10b6:a03:4f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 15:29:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 15:29:23 +0000
Message-ID: <a2ea6493-10df-fe86-a1d6-ebc4e3640ead@meta.com>
Date: Mon, 3 Jul 2023 08:29:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC PATCH bpf-next 01/13] bpf: Support new sign-extension load
 insns
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com
References: <20230629063715.1646832-1-yhs@fb.com>
 <20230629063721.1647917-1-yhs@fb.com>
 <20230703005339.zjljypzmyhh73cfa@MacBook-Pro-8.local>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230703005339.zjljypzmyhh73cfa@MacBook-Pro-8.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ2PR15MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b64b81-680d-4253-29aa-08db7bda4760
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kbUoB5TLEVCllnC4NcqsUxphNyzg+h0HmTFRsMLt7T614lW6rSdcODqOzM3m5W9c01+2tfy0l+YUhLp/A1VhDm42yEHaQhZ+PeHgw7eJw3T5LDibcl1QaCfdM88D5HI+m8Bthkjt4wvaL4+1wG4UuPEH3yFUsRBHd5M6lV/A3uqEgk8kNlGURBsSlWizGPLTWbV13hg43JZrq8/fX/TAgQg3T3X6yFqSj+m73RwBBruKZ6rs+tx4JWwdcDQgSmpHGmmruBJFpyqOp2fC6C2WdHmsxcbM86tnSacncFOnmbMCb+k51Rfm+Xtf1PLZBqMZTu5/ioDv6fzYrJ0b1cT8rtW3MOGl00ZkXvIzcy4hQt4E2vVQ3CAYqksUCupG+GzIUpedYg5wYH3S+SSx7fVHACT2QgBiu4DeZleLgHisbR//EJt9IDNc7Xv2E9ePxR092Lgz0hhsDQLram1GNgNqDuq8fvlifOkGrH4faZ3idgavK3mF7maY2ncv2B4eQ5ooB3EJ9iIIN74EHYiuTwyCsSwebFgUKwitOtX09zhFD0+bV++aJ3c1uMeWIP9zzYYkOB3Akp8ym49QxXD0yrTx1EHML7XzZhaf7y0qm2349VrYq6rv4LS1jUSZjiaos0xSmXtNz+fSiNgsin+ltY4FsA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199021)(6506007)(53546011)(6512007)(316002)(66556008)(66476007)(4326008)(38100700002)(66946007)(2616005)(186003)(478600001)(8676002)(110136005)(54906003)(8936002)(31686004)(2906002)(6486002)(31696002)(5660300002)(86362001)(41300700001)(6666004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QnpkZWgzWVFRc3pxVU04WjVhU3ZoMTR2TnlyeUlMcmF4WWE0YWVlenZITDA0?=
 =?utf-8?B?MGR5bktNZkxwTTVqY2tyUnFicDlJSFgrQXRWSStJcWhGY2x1eVRQdTUrU3hM?=
 =?utf-8?B?b1E1VkJCOUVJZ3E0azBLRVJRcmJDekZmWXRUMVNnNi93REgrUjB2VGNnRmll?=
 =?utf-8?B?cVlWV2o5VlQwSFNqUURXNWl6cVNlcTRJbGlUOGVNV0R6RlE3YUZSMUduWTd2?=
 =?utf-8?B?ekdvY3RQelgvSFpXZXlaRnVRdHE5aGQyblVPcUlRUUZmSUFsWlNEMnNpZ0ZR?=
 =?utf-8?B?TnBYaGRlWXFGcFVNWXBKcE5WMXIzZG5GL1E1MlE5RHpLYnRRb3dKZlpLS0J3?=
 =?utf-8?B?ZWx6NGh0czc4ZWFJOHA5a2NFS0QrWmcraDJjZy9WMUw3NThicXc1WVRHakts?=
 =?utf-8?B?enVJeUNiU1FTVys3ZXhVSUpaOGQyZ0pHMkljUnJOR09SRU10cXo3cFQ3Q3pw?=
 =?utf-8?B?T3RQMGZJT2xmUmZuNS82SlFtMkRnM25KV3FFa3YrQmphdms4ZlRWdU01UzZD?=
 =?utf-8?B?Uk9CbUsrZ1FTM1E1bis5U2VYaEszRkNRZ2UwdlpnTUVLTVF6RWhWOU5QWnYy?=
 =?utf-8?B?dkJ1VGZSUkJTWWhycllkUzMyVVdRKzdFMFE3aHdvVVFGYy95MFZKN1JJZktQ?=
 =?utf-8?B?Mm5URlJXRGx0RmxyUFZFSCtzOGNZUHMwaCt5WDNHZ2pYdzBzMXE4a3hERVNI?=
 =?utf-8?B?RDhrQTRnSjJLbDBIZ2VIT0dUY0xxd2paR042ak02dHUyN1V6bEJEdHVtdUFk?=
 =?utf-8?B?VVhtUisvM3dKeW9WMXArZkRLdFBtN2pQUHVOdmhOMHhvOWsyaWtMQkQveWRU?=
 =?utf-8?B?VXB3bzU2aTN6NlB3QW5EOHA0NHB0OXRyZkM2eHZGTldyMkJoSjdrNGNlVDFR?=
 =?utf-8?B?N3cvTEkweCtNbUptRmtMMzlOTVBPYVZiSE9FSWVhcjRYYVl5NmFOaFVqTFV0?=
 =?utf-8?B?U1kxTndOZDNxd0I4RS9UUFFZSDFabUk4L3k1azE5S09RZER6Y3hia0syOEkz?=
 =?utf-8?B?U0NsRk9QSjYwSml1SEZiMU1NNGM2VjhhVkJrTy91Z2I1R0lqWVFKUGQ0OCta?=
 =?utf-8?B?eHZ5SWlWU2pXU1BsQ0l0cjZraXEyV1gvUDJUV1ZKY0d0QXNMeVFvN2FXVVdi?=
 =?utf-8?B?NlJZaGs3OWlzNHBPcXZTYW5YRSs1OS8yVU9tMDQ4cllwRmpoOVhLUmJOTVAx?=
 =?utf-8?B?WnBxUCtCR2oyOXVxS0p0bjhLMnoyMnVZTVc1R2daazNZdFlZYlRHd2c1ODZl?=
 =?utf-8?B?YWdodWFHU1p4V2wzdVR3Vlk5ZXJQTEJZSDVleW9NSVNrZENSVFB5QmI4c252?=
 =?utf-8?B?bTF6bVRNQnRpK0s0Q1dkVm5xaHF2TjdDcC9wUHdTc21IL08wQlNHU0F6SEp6?=
 =?utf-8?B?UFNBQXl4SmdlaXVjK0FVMk41bXBjSC8zNnRnUzJ3QS95NlJyOFVWVjNUT1lL?=
 =?utf-8?B?Q3BXelQ1RWFPeTV0Q05ST3hVYXcxR2MwVWgzVmJabjFJRG1pbG1zbWlJS1dY?=
 =?utf-8?B?WnVsRW1LSDVnL1RYMzRFUmpnMnV1ckYyb3dzZFFiTEZnZEQra2I1YzczNXM3?=
 =?utf-8?B?bEZSYXdVNFo5enNvUWN2ellQa2RBKzRFUzZpeFFtN1Y1UHEzSysxWS83aElH?=
 =?utf-8?B?SFd2c2RtUE9IMTlDVU94Umd4NExPS25RSmNxYmMvb09wMHJXbzcrUzJiRkNB?=
 =?utf-8?B?SzNLMVM3aWhDTjNjQ2VMOTRLdXZWS1B5TkRNaXlLeGRFWkovcHZnZCtWNUUz?=
 =?utf-8?B?QzJWQzFiZnNCUE9GZGIvTlJGNHNMbFpaM2lRaFJ6ZUloTHpoYjlhSUhoS0ti?=
 =?utf-8?B?NkZ3RmxrMUdJcEI5OVpmZVh3RTltVEJ2SnJwSjNTZWJPNFc5bjZkYW9vZjZ3?=
 =?utf-8?B?QzdCZ1RwNHZZajBrL0hoMUs3WGNGSGZtZ3hRMEtrYW1BbUM0Q1IvcmJMejIr?=
 =?utf-8?B?MktJVXpXTjJ2c0FoeXE5aWxpZC85a1VBb0Evd2VYeWJzcU1MK2htNUl1WFNT?=
 =?utf-8?B?ZzdUNmVzRktPRThIZE4xNzJRRmhIalZ4TFU1WCtSd0dYZ1BYcGZURlozalpF?=
 =?utf-8?B?WmlhZXVFZisxL0dyemF5NTZXK1E3TFdNY2JXODNYRUl2clZ2N2EzWlJLdCs5?=
 =?utf-8?B?Y1hweVhzQjMyUDAydEhzbC9mQWdTVlBBTmQ4YndQLzJWc1JVWGtETlhCQ1hK?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b64b81-680d-4253-29aa-08db7bda4760
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 15:29:23.4904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGFVnd+j1HupRZuZjWur3IOMk81U83mRMXKIT+kMcajjZZ5epxXh9ckH12IBcJ01
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5833
X-Proofpoint-GUID: 4OLqv_4J5RvdPC4VDDec8AeDG9L9Kjkd
X-Proofpoint-ORIG-GUID: 4OLqv_4J5RvdPC4VDDec8AeDG9L9Kjkd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/2/23 5:53 PM, Alexei Starovoitov wrote:
> On Wed, Jun 28, 2023 at 11:37:21PM -0700, Yonghong Song wrote:
>>   
>> +/* LDX: dst_reg = *(s8*)(src_reg + off) */
>> +static void emit_lds(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
>> +{
> ...
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 60a9d59beeab..b28109bc5c54 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -19,6 +19,7 @@
>>   
>>   /* ld/ldx fields */
>>   #define BPF_DW		0x18	/* double word (64-bit) */
>> +#define BPF_MEMS	0x80	/* load with sign extension */
> 
> Intel assembly instruction to do sign extending mov is called 'movsx'.
> Let's adopt SX suffix here and in other patches ?
> 
> s/BPF_MEMS/BPF_MEMSX/ here.
> s/emit_lds/emit_ldsx/ above.
> 
> s/emit_movs_reg/emit_movsx_reg/ in patch 3.
> 
> s/bpf_movs_string/bpf_movsx_string/ in patch 7
> s/bpf_lds_string/bpf_ldsx_string/ in patch 7.
> s/is_movs/is_movsx/ in patch 7.
> 
> sdiv/smod can stay as-is.

Sounds good to me! Will use the above suggested names
in the next revision.

> 
> Naming is hard, of course.

