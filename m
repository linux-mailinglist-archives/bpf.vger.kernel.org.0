Return-Path: <bpf+bounces-872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479C67084C8
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 17:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7346428184C
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 15:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDE621077;
	Thu, 18 May 2023 15:21:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B73819507
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 15:21:04 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3F5194
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 08:21:02 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HNX57S009448;
	Thu, 18 May 2023 08:20:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=YhZM2ocgd0S5jQdX0fLt30J6OnA4gJP8i6azO6eUDl8=;
 b=IT64Y4CewWWWLJUfOdY1ZmTpR75hVlfvVi26ZNw0UOZg3DIbJAtzcKcp5jPmhMm7nIX8
 2rU/dlJkyNBPS8t+0nNKBqhBjpE52/UIhqTYaT0aA0LMrwDw/HsWxMqnOK+p+hRtfmwD
 +YjRvYGjEuEJ5K3CYanQbiGkkiDEmXjX4JtyAYok1MwgJCOl6uVNpHwmDJXEEwDo/g9r
 dYHddicGUJtI6EBYnr7tD816pG3W4gK3TQNxCWVleIBpD4ohqKiGREEQ2hnH+a28aM9F
 SOTEGJQb5em5VeBSH2NWeh/htSP4VSmC339vsfBcnJsgS4yVOIeXHea2YuRMhAVjJXTI 1A== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qmk2xmrtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 May 2023 08:20:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cx7rO+N6dnGXlxfOIj8LABjA38zKwN+g13Oik7jIoxeAEBAg6ZgjCCaRqGpalGvdOp+FfNtXe9MGAIogwnxzunK51W2nv4CIff9rANEoQaVlJVtMHD1m0GsiGxxHEX9ObakLm99jlSX1sEgk3ObOX/+8+B1ZuV+T0o7EvFukaoOcoz7XGcD4JUVUDNlnQ3PNX1Q91OW1+C6gNbpsWQmuHMWD5snT/oJo92FYENpOnSnuvALuCxN6FvdJouVTzHqfGta31izCQBtk2AcgX7zF/tqElg0lN+ULV0hjdmahMS/8yo++A/4ITuc3P+KHADGH1Dsak3u7n1w2sRVCSVid0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhZM2ocgd0S5jQdX0fLt30J6OnA4gJP8i6azO6eUDl8=;
 b=NqSRkcUYkHHKHOk86efJJRxxiKItDcSX9/sxJ+74PheeUdXGyKwyuN8T1os5LKqAkhDZnKr9yapdooMdaLSL2/J7eedUyr5F1JBmrx/sBLUIhHQLu6walXJdEj4FKq4/hP9fE9zr7dE/n6d5R4DuNEZ0OMlZYS7VP78looR1NxTtdTjOuBwWW3kYLroaCnGMyngyJLfoABRJx7Hvtu/iir9G8En0gvig2xOnnpyZfHBBxGRg7f6O+Kchs8pDq7j5/KeprgyjeH4qTnm16iaW/m0NwV5Fj6JRQ+ic9ycRAfozE48tfz9rj9X99nQiabJoKfQezlo9XnKJGV6uApslDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4540.namprd15.prod.outlook.com (2603:10b6:303:109::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 15:20:39 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%7]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 15:20:38 +0000
Message-ID: <a05c4f42-ce99-967b-d5a9-d88d46ab5876@meta.com>
Date: Thu, 18 May 2023 08:20:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [RFC dwarves 5/6] btf_encoder: store ELF function representations
 sorted by name _and_ address
To: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: acme@kernel.org, ast@kernel.org, yhs@fb.com, andrii@kernel.org,
        daniel@iogearbox.net, laoar.shao@gmail.com, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, bpf@vger.kernel.org
References: <20230517161648.17582-1-alan.maguire@oracle.com>
 <20230517161648.17582-6-alan.maguire@oracle.com> <ZGXkN2TeEJZHMSG8@krava>
 <35213852-1d29-e21f-e3f8-d3f164e97294@oracle.com>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <35213852-1d29-e21f-e3f8-d3f164e97294@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::43) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB4540:EE_
X-MS-Office365-Filtering-Correlation-Id: 09da9052-920b-4b82-457a-08db57b36fad
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lm7rCDMy9hUMC57p+HqE7YsN41vbsqTTBylYTP6RkJw1sRY6ZELF62CBdLLKPn2mTHlt3U7wmyNagsSZL63zeaPjhGzT3ipQBvX+yLIK/SloPY//WWZBIMI58/YGMFBxjTHD1fdPPAa0OfIShryeHnxqKeX1f1uGBil3hD/zq3m+AOXkdlYKrvVVsceFkQ3IiyQ0zv8Xa++cVbQUruV159FBQjNPojDMn1gytopAAtk2zH1zoQBU90KB3hb5B21CS8QTXbgg2+ZJ9YemeqFesAvjHmSA71YxkhKHaYXpJYef3fKfEi9ZiEYbDSmZXXQnWqqsUxF1x2IGkEbxZgHAObBg/s4tQ7aE3PJpkuWgXGH9OeUsVrvSQJkqFLq8M3WPXfFnRsODTyQATLxHvRmUyu8Ae+ZKVYUTcHu2SlGUoszhtPbj+D0XenGp85jNCsQmvTlrEkVbHpJv/xqdfJbBTHPVZjK+2ZIX/+ViY2w4rxQtw+pQZ9Fi4lzOi/nhT/ZjycnNyMG0tMLy6M2bGVbqqCF/GgisKg+Sf0e88qUJSB5BsvubOL/6Cn34t7eVsifHiQ66n3v6wk77g+Y+b8aiPYFfET/dEJYTAswxT3I09GzW0DKqA9gr5cl7DH9iDUNuIEHOahhrHRA3zsI1rGngGg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199021)(966005)(6486002)(6666004)(6512007)(6506007)(53546011)(186003)(5660300002)(7416002)(31696002)(86362001)(41300700001)(8676002)(8936002)(31686004)(4326008)(66476007)(66556008)(38100700002)(316002)(66946007)(2616005)(2906002)(36756003)(110136005)(84970400001)(478600001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y2VncVlZbmpXSkR6UXg1TVF4czNuMS9iOEJZVTRiV3lSb25KcjBlNjFTYnh3?=
 =?utf-8?B?NTE3MW40dXhQak0rZGpqenUvQU4vU0R0YStNdng5VVdBSnpEcUUrd1NFQzVT?=
 =?utf-8?B?VUV6Z2x4MFlUNUtOZjUxVWhkbUdCWFRrZ0RFT0g1eDNvMUd2K0grZkFpWXJt?=
 =?utf-8?B?YVM3bmNSZUErN1lSa1FabmlRU01nekMwajFuMS8xSjhPNFlaeGZmZ0hKM3Rk?=
 =?utf-8?B?VXRpb3NKby9pTDVWVW9WREIyNTRaMnFoT1pGMy9LNU9CbTBVaEdTT3hhVVJH?=
 =?utf-8?B?eW5xb0U1eGNCU242KzVDRlF4UElMbzFPT0pLZC9DTnlvemd5amdEdlFMbHE0?=
 =?utf-8?B?cnJPUm9GcjczR3BHQjRlMlBEYlpxR1duOW4wUmQyOEZSWW1nSFpiazg4aGta?=
 =?utf-8?B?R3BmTUhLWFF6WEIwM3ZjL1VJSk1FS3c1Y2dDTXhleGU2UXlCVTdXTVpPaEFC?=
 =?utf-8?B?cnc0a3F5S1NaMWFVR25VL0NjQ083U3BFOU5NbDBGS1krZVFURGl0VGpQVXZV?=
 =?utf-8?B?OTh6UExwT3BBQU1JVWN0bXVDNGhtY290aWV5OElRYy9mSFlNUXpIUXQ3N3BJ?=
 =?utf-8?B?c2VPTFl1MW9SMVpzdUpyU3JCNnNvQlJXSkdmUXFyQ00zbWZ0aTF0dkpsTXd6?=
 =?utf-8?B?ckg0WTRUZFVpZnpRYWMxNlBScll2VDQ4cmpCUGhGajJXTU5heE5iN09mV3Qy?=
 =?utf-8?B?WUI2dFB4c2d1SVlmVDFFZU9pSTRVdG1kQ09PQTNwcFBoQjRtWnBPYUxIeVJh?=
 =?utf-8?B?ZVdXT284ZVYzZDQ5dS85QVJVSHN0T1JFLzdpWnFhZ3NDK3Q4bldLMXo2dkpD?=
 =?utf-8?B?T2syTUlHaVQwdE1UVG5uVURORS9LRnh6M2l0M1R5N29Tc0QzNW1FTXNIbjM1?=
 =?utf-8?B?bEVyL0dlRFRxRTY5Q3puNk4rOWl0ODlDR0lEWmZKQytPWTBOTTIweTZ4VHVr?=
 =?utf-8?B?a3FkYmhDdDFtTTU5Z2JmTjdpdzNlZ2w4TVpBTzJja25oNENyVkxKd1VyVHBS?=
 =?utf-8?B?REkrZU5LdlVNbHdpWDNBR3VFeDNIbEZPYzlNTGNoUE9xWDNXS3E1b3NlZ2U5?=
 =?utf-8?B?V0N1QjM2cmFMWjZCRXg2WE9GZnp0R2FuS2NFc0M2VmRzM2xDMjJDZFE4WU9n?=
 =?utf-8?B?cDFMdk5yMXEwbE9yaUNYTmt5M0JEbTlUMkZRZXVWanY4NkNQUUtLM2xNM3l5?=
 =?utf-8?B?MnZIWGNtWFlZSmVDL2JQVFlyNlRGNVNJRmZKOUluTmhEWXl4S2t3dXRwNnUz?=
 =?utf-8?B?WlBsZEtpeE4xUUF5UzF4OWJ5NUs5Yzhzc25RbGx3Q2w5a2JYZjA1VzI0MjJL?=
 =?utf-8?B?dG9FbWJvcVFRTGVMTWdyYVZxem0rdzZ1VjFwajZFZThiNVdyMXFNdk0zZGd3?=
 =?utf-8?B?MGRVenZUMi9PbFpxMWJ2cnB4NGU0R1daNEtkQjZTa3pMZkdscElQWnpoUXBh?=
 =?utf-8?B?Qkw3Mm1TNEtoSmZTOFJWWGtWMk9IUmY0eHpkSUxzQ1poUDBNSGY1OFhNUzcy?=
 =?utf-8?B?OTdxZlVkTFovdDJKYStRNmtGNmtRc3I4MjNQN1VoQ3RWN3ZFTmgxWk1KcjhD?=
 =?utf-8?B?UFJvWmkxcWEzZnQ0S2VRVlR3R0puVVNHTDVxRVVxb1hoUU1mVjYwSTl4cHQv?=
 =?utf-8?B?M04zTkI3NElKUkFOL1Z2cWVxSm5iS1ROa1REUGl4TU9JVnV6aXdwSGx5Vi9u?=
 =?utf-8?B?Q05zdFVmYXp0cGNlRGduaXhPenNZTGN4N0VIcUU0YituS2JFa2FucWdnWnJQ?=
 =?utf-8?B?eFNSbFlPcW1oajdtVnE3UWdiTUtFUDkrVTIvWjhLQ0VuZGpXS2pKS3RlWXNK?=
 =?utf-8?B?S01QczZyUmFiK2VGZTRTRDNFbzRucFA2N1JtODkrd1JaNW9sQmNKVnRndzBu?=
 =?utf-8?B?dnpKbFhXTVpvblZ2a244NWJhWVgzNU80Z0ZidkRsWDBhQVhhVU56ZVNYRGFX?=
 =?utf-8?B?T2NyYW8rRXhrZ0VhWkc2bDFCVlJrU2puMXFiVjlNQTl6T0JiWEFMNWNPalBv?=
 =?utf-8?B?QjJkNmNtc2NZMlJ2UWhCdnE3UE9GdzFycGRYaTJudTNJYXUwUmhENTNFbTNJ?=
 =?utf-8?B?ek0xSUNueVRXbWNZNkJ1Z2xnTE9OWVQrb1duUkxjbERKWnFZbStlOXhJUXNy?=
 =?utf-8?B?cXBSRythZzVPNlUxSERTRzdRRHBNQ0xwYlQyZ0xEOGlZZ0doKzNzR0ZpN2cy?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09da9052-920b-4b82-457a-08db57b36fad
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 15:20:38.9013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zA2dwYSZEnLdP12gOYepdcnA8ZzQgi4p+l2xCICCxFmosESK6jUv7YDdlz50I7Q8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4540
X-Proofpoint-GUID: vMyF-7nybGNyghpv4oLOsp-xNZCHsFML
X-Proofpoint-ORIG-GUID: vMyF-7nybGNyghpv4oLOsp-xNZCHsFML
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/18/23 6:23 AM, Alan Maguire wrote:
> On 18/05/2023 09:39, Jiri Olsa wrote:
>> On Wed, May 17, 2023 at 05:16:47PM +0100, Alan Maguire wrote:
>>> By making sorting function for our ELF function list match on
>>> both name and function, we ensure that the set of ELF functions
>>> includes multiple copies for functions which have multiple instances
>>> across CUs.  For example, cpumask_weight has 22 instances in
>>> System.map/kallsyms:
>>>
>>> ffffffff8103b530 t cpumask_weight
>>> ffffffff8103e300 t cpumask_weight
>>> ffffffff81040d30 t cpumask_weight
>>> ffffffff8104fa00 t cpumask_weight
>>> ffffffff81064300 t cpumask_weight
>>> ffffffff81082ba0 t cpumask_weight
>>> ffffffff81084f50 t cpumask_weight
>>> ffffffff810a4ad0 t cpumask_weight
>>> ffffffff810bb740 t cpumask_weight
>>> ffffffff8110a6c0 t cpumask_weight
>>> ffffffff81118ab0 t cpumask_weight
>>> ffffffff81129b50 t cpumask_weight
>>> ffffffff81137dc0 t cpumask_weight
>>> ffffffff811aead0 t cpumask_weight
>>> ffffffff811d6800 t cpumask_weight
>>> ffffffff811e1370 t cpumask_weight
>>> ffffffff812fae80 t cpumask_weight
>>> ffffffff81375c50 t cpumask_weight
>>> ffffffff81634b60 t cpumask_weight
>>> ffffffff817ba540 t cpumask_weight
>>> ffffffff819abf30 t cpumask_weight
>>> ffffffff81a7cb60 t cpumask_weight
>>>
>>> With ELF representations for each address, and DWARF info about
>>> addresses (low_pc) we can match DWARF with ELF accurately.
>>> The result for the BTF representation is that we end up with
>>> a single de-duped function:
>>>
>>> [9287] FUNC 'cpumask_weight' type_id=9286 linkage=static
>>>
>>> ...and 22 DECL_TAGs for each address that point at it:
>>>
>>> 9288] DECL_TAG 'address=0xffffffff8103b530' type_id=9287 component_idx=-1
>>> [9623] DECL_TAG 'address=0xffffffff8103e300' type_id=9287 component_idx=-1
>>> [9829] DECL_TAG 'address=0xffffffff81040d30' type_id=9287 component_idx=-1
>>> [11609] DECL_TAG 'address=0xffffffff8104fa00' type_id=9287 component_idx=-1
>>> [13299] DECL_TAG 'address=0xffffffff81064300' type_id=9287 component_idx=-1
>>> [15704] DECL_TAG 'address=0xffffffff81082ba0' type_id=9287 component_idx=-1
>>> [15731] DECL_TAG 'address=0xffffffff81084f50' type_id=9287 component_idx=-1
>>> [18582] DECL_TAG 'address=0xffffffff810a4ad0' type_id=9287 component_idx=-1
>>> [20234] DECL_TAG 'address=0xffffffff810bb740' type_id=9287 component_idx=-1
>>> [25384] DECL_TAG 'address=0xffffffff8110a6c0' type_id=9287 component_idx=-1
>>> [25798] DECL_TAG 'address=0xffffffff81118ab0' type_id=9287 component_idx=-1
>>> [26285] DECL_TAG 'address=0xffffffff81129b50' type_id=9287 component_idx=-1
>>> [27040] DECL_TAG 'address=0xffffffff81137dc0' type_id=9287 component_idx=-1
>>> [32900] DECL_TAG 'address=0xffffffff811aead0' type_id=9287 component_idx=-1
>>> [35059] DECL_TAG 'address=0xffffffff811d6800' type_id=9287 component_idx=-1
>>> [35353] DECL_TAG 'address=0xffffffff811e1370' type_id=9287 component_idx=-1
>>> [48934] DECL_TAG 'address=0xffffffff812fae80' type_id=9287 component_idx=-1
>>> [54476] DECL_TAG 'address=0xffffffff81375c50' type_id=9287 component_idx=-1
>>> [87772] DECL_TAG 'address=0xffffffff81634b60' type_id=9287 component_idx=-1
>>> [108841] DECL_TAG 'address=0xffffffff817ba540' type_id=9287 component_idx=-1
>>> [132557] DECL_TAG 'address=0xffffffff819abf30' type_id=9287 component_idx=-1
>>> [143689] DECL_TAG 'address=0xffffffff81a7cb60' type_id=9287 component_idx=-1
>>
>> right, Yonghong pointed this out in:
>>    https://lore.kernel.org/bpf/49e4fee2-8be0-325f-3372-c79d96b686e9@meta.com/
>>
>> it's problem, because we pass btf id as attach id during bpf program load,
>> and kernel does not have a way to figure out which address from the associated
>> DECL_TAGs to use
>>
>> if we could change dedup algo to take the function address into account and
>> make it not de-duplicate equal functions with different addresses, then we
>> could:
>>
>>    - find btf id that properly and uniquely identifies the function we
>>      want to trace
>>
> 
> So maybe a more natural approach would be to extend BTF_KIND_FUNC
> (I think Alexei suggested something this earlier but I could be
> misremembering) as follows:
> 
> 
> 2.2.12 BTF_KIND_FUNC
> ~~~~~~~~~~~~~~~~~~~~
> 
> ``struct btf_type`` encoding requirement:
>    * ``name_off``: offset to a valid C identifier
> -  * ``info.kind_flag``: 0
> +  * ``info.kind_flag``: 0 or 1 if additional ``struct btf_func`` follows
>    * ``info.kind``: BTF_KIND_FUNC
>    * ``info.vlen``: linkage information (BTF_FUNC_STATIC, BTF_FUNC_GLOBAL
>                     or BTF_FUNC_EXTERN)
>    * ``type``: a BTF_KIND_FUNC_PROTO type
> 
> - No additional type data follow ``btf_type``.
> + If ``info.kind_flag`` is specified, a ``struct btf_func`` follows.::
> +
> +	struct btf_func {
> +		__u64 addr;
> +	};
> + Otherwise no additional type data follows ``btf_type``.
> 
> 
> With the above, dedup could be made to fail when functions have non-
> identical associated addresses. Judging by the number of DECL_TAGs in
> the RFC, we'd end up with ~1000 extra BTF_KIND_FUNCs, and the extra
> space for struct btf_funcs would require roughly 400k. We'd still get
> dedup of FUNC_PROTOs, so I suspect the extra size would be < 1MB.

Agree that this seems a better idea to save space and also not impacting
existing dedup algorithm. The only weird thing is previously we use
KIND + option vlen to decide overall size of the type, but now we need
KIND + kflag to decide FUNC type size. But this should be okay.

We need to add an option to pahole to enable this feature and
in kernel to enable this option only if the kernel supports new format.

Do we want to add addresses to all functions in which case we will have
FUNC types with both kflag 0 and kflag 1? Do you imagine whether
we potentially need to encode other additional information to FUNC type?

> 
> 
> 
>>    - store the vmlinux base address and treat stored function addresses as
>>      offsets, so the verifier can get proper address even if the kernel
>>      is relocated
>>
> 
> yep; when we read kernel/module BTF in we could hopefully carry out
> this recalculation and update the vmlinux/module BTF addresses
> accordingly.
> 
> Thanks!
> 
> Alan

