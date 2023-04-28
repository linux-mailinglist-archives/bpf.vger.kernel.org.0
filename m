Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893396F1050
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 04:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344424AbjD1C1D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 22:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344782AbjD1C1C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 22:27:02 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C56268E
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 19:26:59 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RIQIIr010530;
        Thu, 27 Apr 2023 19:26:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=0lub45xaB8KaNog4HOjbN/WHWHpvoPH4wJ/xqC6wKug=;
 b=WTqE3Q2yXrXcTQJZh30/8P1A5WcM7F/6s5893R7sM2iI5D9dWgLnCophpWnv658c+SFt
 ZHkxf1WknQxvY1CHdFVZHgGtNLuI8jGpwHh7PApWzGM5PB/ncrz4wHVb5VNPvYswBJo2
 v9gp2sdr0LsDsMMy2ZLIlNK5o/l1nqXBFbqCi/VkLX4c3VKQRfjzZdgrp8taomL/yQBf
 zwgmFqJs2D7yEUSMuAwkyWNDHFwXDElacNWasNkUouLVKrZv+zrncZTVRwppyQhakRNN
 R5QsnlV32ojzbvlk4eakzyZ+2T71S9tCUJuTn3x3E6QNzfG5zLRB6MaIpJpUtS4DHFxg WA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q7pcrex9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 19:26:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbOhI641Vn2V23Z4Rbzc1VrKxzHOXrQ4lb7lclZIQt+KzeaZcAAQ49J+N0zOVnEYP6pKl9Mg/Syf10PhXH7crBb+93Onf/FAmIQOVKdCn/owg0ohtTUlFnB717flVHYYsIXSceGwRKhifVM9XLF4MsyxtNigfgV+cTqJOln54qQxzM+AUBbeQY8UQfnQ6vL9Qokoke0E+ooIldxvw8IjD6eCid7noWhWZsqsOkvhC/rNioJWwZxFALuIqf7alYjntYpcUkWQjf018ANM9lAJWySYNc+gbsXH7Tpop8KNW/ijqdIAYbUv+T7Th38LGrr4zrcKsEjtFaDRVzWRGOdSRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lub45xaB8KaNog4HOjbN/WHWHpvoPH4wJ/xqC6wKug=;
 b=aASLJjwwYhlooJpZojegrZe82Glx2Yi1/jQUk2JI41clybTKnIRGpqvd5OwW5qVG5d7vsLHaw1gkT7l/cE7T4Hs06Ha8dSg/lTegZr0B4JABBPoJ+hsgMlU6ACJWMCd7XC+5DfK0ppXJ25mrVP0NsOA3KRoW7Q+bOdoYyuT124OsVVWaV3AdIhckz9IVmw1Y18Z7j0XltU0rRG9hVGt5qntgrXl4Rf340r8JbO19EEY0VwMMi2ETuoyD5S5KJGviW9y1WF+zIGdD1Tc/hohyH5RCxvLue1r/GxAhMkXe+RYZiiNGpB+wjYIOfYB1FfM6HD68ZT2a2X8WFsHDIbamiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BY3PR15MB4881.namprd15.prod.outlook.com (2603:10b6:a03:3c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 02:26:38 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 02:26:38 +0000
Message-ID: <bca80871-88e7-938b-7d39-12379d263dde@meta.com>
Date:   Thu, 27 Apr 2023 19:26:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2 bpf-next] libbpf: btf_dump_type_data_check_overflow
 needs to consider BTF_MEMBER_BITFIELD_SIZE
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
References: <20230428013638.1581263-1-martin.lau@linux.dev>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230428013638.1581263-1-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0056.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BY3PR15MB4881:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e07580-5150-44dd-6b0f-08db478ffecc
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mf+62fwaBdaV5w3z9uKc46OT49Z2CRyNHWmOKTS4BGXW3DwPc+0HxTBPqCQSBsc5fYu3PUh1vyLXY39HreZOEd9dhXq+YW7s++klvqCTTQsT/wf6B9OLKxTfHQKdBJadMo7X9rrt3fmvvVxI2dVr4IzN0SwYb2W/fdAxIpDKQ0IenBA2j3/pRGxSYcsmpTFRRSddq3RklkRmeRdC6tsaCVl+7Jiv+fXUuatjMi53/f/Q91Lt6dyANsEJ9pn0E9eCFWuBk8R4C48vkObLqAyGQSOYyr/R3/hbnu12XHK5m9/4yRdG+4LT2StJWkDZixOcTrZujdvSVs05Ck59q8HiQdbllphMBk5AJAWtOsnfAvWHAjfxXhJE9ki5J5WbpN0RSMOJHop2SofEi4J5naoYTSvFJCj42AOBoeKRkNUUHqRcB7BQQn5JbydA5BG/5Wn7qW3F6OvtO08ognbnbQIo/oeLiaFX7lgTFaTLi7XhU1cwyHx9vUi74ZVjnKUnVsP+Qw0H0zWV4v/cu/RrsxEcp70im9+Cf5wNRwRZgCMhvk8Eg5wDO8dilNQ+gm0nPtn13vEkcD1c24NjsjPZiJiFznhvcHWpxWlEDdei7uMznuKKYvQleux+42sbo7QA9MQ965ohiVQmvfJaHyOGZRp9XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(186003)(478600001)(31696002)(54906003)(86362001)(36756003)(6666004)(6486002)(38100700002)(2906002)(5660300002)(8676002)(8936002)(66476007)(66556008)(66946007)(4326008)(41300700001)(316002)(6506007)(6512007)(53546011)(107886003)(2616005)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0RMT1FJZTIwM0tWQWNBT2JtNjdScmhpdGs5VWdIdmlVNlIxQmNFREM2UEcr?=
 =?utf-8?B?U2lEV3ExcE9lU251cTBSRnBZWDV5TWxyT2Fza293OFB4M1pZMFVMZm1jWm8y?=
 =?utf-8?B?bXhhYzVjcWJ0SW5vQ1p0TWd3QkVjUEYrSDVXaWpYai81N0VObXh6Zk9XWXh3?=
 =?utf-8?B?bGtQcUpjcWpRbTEvRGoweWZlaXBJODNqMlJBK3pDYVVFbEk3NzNiSzd3VFY0?=
 =?utf-8?B?ZWdOYVVmdVVBWUpac3cwWEZWWkpteHg4UjFDNHk3SWllNVhMUkVySHR2Q2Nr?=
 =?utf-8?B?YU9oWGN0bU9lK1MxbWVTSEVsQlB5N21yamNjTFZmRE02UGlFYXpmKytnYmpC?=
 =?utf-8?B?aEhGREdqai9XbUNSb2VUczJtWUNuK3piT0RzdzJDb1lsWFRocURIdkZNS1lm?=
 =?utf-8?B?ckQ4ZkkxVVFNRUYrT01LeWJ5TUhGOVBQOUtQcnFmT0hBVVVtRXpKbGRkSUM4?=
 =?utf-8?B?a0lERU1uWllMZjd5a2dIZm1ZbkpjZUliWjdTTC9oNkFLdENQdVk0UVJzWHdU?=
 =?utf-8?B?bjFNNzFRcjNBTHM2NnJRRGRXc2o4VGFLN08rTVFhOHNPaWV4WGcyVGRtTXNG?=
 =?utf-8?B?bDBLbnJqUG5TTXJxZS9Ma0M2VU4vZnIzVTRwQkxjRmlhUEtIbzdsc21uRzg2?=
 =?utf-8?B?SU9YaEc5eEtoc2pIUmRIcnV3V0pHd2VXUi9WLzJqT3ZHMkxZVVdaYlo1ZWdY?=
 =?utf-8?B?RW8ySVNWakoxUWpxS0F2dXpMTm0xdTU4cXh0MFlpUm12VHI1SzBFZG1xQUUy?=
 =?utf-8?B?aWdKMFJWbERBaERuTUpKVGg4RmtZODEwVFNSL092MVhIUVltdERnN1N4M2s1?=
 =?utf-8?B?TjBNM25jSFFOWklOY2Rad1NNcFJ2UStXTjdLY0FKdGZjcWlEOTJFcXEwQU5s?=
 =?utf-8?B?K3dZT1JwVUpqN3hHSFEvTVlpWWJUTnlneklwMzhUWmpxWG1qNDVESkNjdUht?=
 =?utf-8?B?alZrZGN1VXIvb1VpREwwejJnS1BLTENvcVYzQWNSbW8vaFRURVJTTnVSdUtn?=
 =?utf-8?B?bnNWNk16OVpHeWNWMENabDNva3RFeUFiRzhaS3ZIb2JPNHRRSERqT0dzZVBS?=
 =?utf-8?B?aGE0elFuSmZyUDlqb0tFYWxVUTU3QXlMUjl0NjNKOWtMaFkyNGNxNy96ditC?=
 =?utf-8?B?K2VXdFAwN2xCR2pUVk1vN3k3TXdTYWJ3dHpwTzd0TVhTSnVDZDhhUWpTZmZZ?=
 =?utf-8?B?eVNUdVBBVHFWdm92VjJTS2JwTHhBUkpaWXJhZTUvV096TjIzbzMzK2N0QnY1?=
 =?utf-8?B?UXVLWjhST1FaTVFobnhJeVU1N1paeDFSS1BBVnBNYWJkYWh5MmNHUDVZcFdw?=
 =?utf-8?B?NmRkcUlFV3BXWW1rSi85OWdLaXdQWXVTZzI0Q1QrRFZEMk9XZm92MFB5SHdv?=
 =?utf-8?B?QVRLOUh1TDYwZkZCNnRlOTZnSHBLbUhvcWx0ckN2eGl5SHkzaGNvUjZBaHQy?=
 =?utf-8?B?KzM0NUMzcGJobStXdUJ5N2VqaEhBMDJGdHhQUEtkdFdHNkV3cGgzQU1kMGpT?=
 =?utf-8?B?QWlERytLZXhhV3hreHpXajZLSmZhT3h4dFkvNGtjS0M0NTZmdWg3VGpNZ2Nw?=
 =?utf-8?B?ampTd1l0ckFBRm9VSmJmN1A5RDdML00reG5Nc3hnUXAxLy8yWWN2S2JNVWxL?=
 =?utf-8?B?b1ZpMnNPcThnRklMS0cwaEh6djdzRTV1M3l1VE5vUy9RdWhvMGNteWJVSGlV?=
 =?utf-8?B?cnB3NjJRNUxPcFgzSXQ3cVo2REpJVkdOQms0bk9CelByemFPNXo1QUIxR2Ux?=
 =?utf-8?B?TVJySUJOamRLVWlDS1pMaHNxOVdmSi9NMzZDeHJCYmNzeVRDZTNUSktCQVo3?=
 =?utf-8?B?ekVhSTl6S1RvOEpSQTNxc2xjOUx2eDAvcGFDSU5veDJHVVl3U2dLOXNWOE9t?=
 =?utf-8?B?ZkVMZFo3eHIwWnBpNHdBcHkzYUZDbVdWMDMwcG5DRUpJRUdxb2ZScHVpVUV4?=
 =?utf-8?B?VTAvekg5ZzBWbHNEbDBxRDNPbmZqcDcrK0w5NXgvMVhlc1hYOXR0YWZkT0c4?=
 =?utf-8?B?ZW1kM0lXZU03T29td3M1aHRGRzZxTWhTOFZidUY3Ymd5UWc3UldPcmcvN0R2?=
 =?utf-8?B?UjEyY3dBbUhqREZvcmc3WEx4cHN2dXZpRDcyanpTOTFEQ09rWFIwa2oya0hW?=
 =?utf-8?B?WVliNTZGNmxRbTl1OEYrZ2N4VVFvU0NxaTJFZ25WdjM4RXl6Q3RId3VLdDR3?=
 =?utf-8?B?VXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e07580-5150-44dd-6b0f-08db478ffecc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 02:26:38.5218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdQUgF9PdvNFTsaEjFcegL0R3QfaeNpUcNZeVqLI8R+Af7YXYUxs1cTXE4k0ya/R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4881
X-Proofpoint-ORIG-GUID: sEVu1TDVde8XNObkF9gsvGVTWFH_Uvtn
X-Proofpoint-GUID: sEVu1TDVde8XNObkF9gsvGVTWFH_Uvtn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_02,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/27/23 6:36 PM, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The btf_dump/struct_data selftest is failing with:
> test_btf_dump_struct_data:FAIL:unexpected return value dumping fs_context unexpected unexpected return value dumping fs_context: actual -7 != expected 264
> 
> The reason is in btf_dump_type_data_check_overflow(). It does not use
> BTF_MEMBER_BITFIELD_SIZE from the struct's member (btf_member). Instead,
> it is using the enum size which is 4. It had been working till the recent
> commit 4e04143c869c ("fs_context: drop the unused lsm_flags member")
> removed an integer member which also removed the 4 bytes padding at the end
> of the fs_context. Missing this 4 bytes padding exposed this bug.
> In particular, when btf_dump_type_data_check_overflow() reaches
> the member 'phase', -E2BIG is returned.
> 
> The fix is to pass bit_sz to btf_dump_type_data_check_overflow().
> In btf_dump_type_data_check_overflow(), it does a different size
> check when bit_sz is not zero.
> 
> The current fs_context:
> 
> [3600] ENUM 'fs_context_purpose' encoding=UNSIGNED size=4 vlen=3
> 	'FS_CONTEXT_FOR_MOUNT' val=0
> 	'FS_CONTEXT_FOR_SUBMOUNT' val=1
> 	'FS_CONTEXT_FOR_RECONFIGURE' val=2
> [3601] ENUM 'fs_context_phase' encoding=UNSIGNED size=4 vlen=7
> 	'FS_CONTEXT_CREATE_PARAMS' val=0
> 	'FS_CONTEXT_CREATING' val=1
> 	'FS_CONTEXT_AWAITING_MOUNT' val=2
> 	'FS_CONTEXT_AWAITING_RECONF' val=3
> 	'FS_CONTEXT_RECONF_PARAMS' val=4
> 	'FS_CONTEXT_RECONFIGURING' val=5
> 	'FS_CONTEXT_FAILED' val=6
> [3602] STRUCT 'fs_context' size=264 vlen=21
> 	'ops' type_id=3603 bits_offset=0
> 	'uapi_mutex' type_id=235 bits_offset=64
> 	'fs_type' type_id=872 bits_offset=1216
> 	'fs_private' type_id=21 bits_offset=1280
> 	'sget_key' type_id=21 bits_offset=1344
> 	'root' type_id=781 bits_offset=1408
> 	'user_ns' type_id=251 bits_offset=1472
> 	'net_ns' type_id=984 bits_offset=1536
> 	'cred' type_id=1785 bits_offset=1600
> 	'log' type_id=3621 bits_offset=1664
> 	'source' type_id=42 bits_offset=1792
> 	'security' type_id=21 bits_offset=1856
> 	's_fs_info' type_id=21 bits_offset=1920
> 	'sb_flags' type_id=20 bits_offset=1984
> 	'sb_flags_mask' type_id=20 bits_offset=2016
> 	's_iflags' type_id=20 bits_offset=2048
> 	'purpose' type_id=3600 bits_offset=2080 bitfield_size=8
> 	'phase' type_id=3601 bits_offset=2088 bitfield_size=8
> 	'need_free' type_id=67 bits_offset=2096 bitfield_size=1
> 	'global' type_id=67 bits_offset=2097 bitfield_size=1
> 	'oldapi' type_id=67 bits_offset=2098 bitfield_size=1
> 
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
