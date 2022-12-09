Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E64A6487D7
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 18:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiLIRh0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 12:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLIRhY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 12:37:24 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CAA82FBC
        for <bpf@vger.kernel.org>; Fri,  9 Dec 2022 09:37:23 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9HVME8021918;
        Fri, 9 Dec 2022 09:37:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Vk5Py81be+dfdMffpKQ0SE/j4sVPWDQq/d4wduEI5UY=;
 b=bwPJ6ttF9bekSVom4LLnhuyd1RZivWsRWK0zQ9O3RZuHe3345YWccw/Q2/dbTM+bFlj8
 lWSAKgjvMBa6Lo3xeGkL5Lm625L8Z26GvbdiKVJqxm61Nwp9YiNPMxL043HS1xyUxl1T
 Qdx/aERu/vKc42ObAdcjXqTHKSQroXyPeiQ2zY3afr/Vn8ZDiAbZE0kKpRu1BUwmWUSA
 rnnLrV0zTJbLe+HgXws3MmISYOKT8k3gHomyYV4/r/4uwxQyAKv+p1zSB7D3NwpT7h5i
 5zKO3BxAPMWfAlQFECqtQBJ8Dza4rvzTXMjkHzta8e3JAJzxY6KhxlA8TaQxqNLRWQEm qg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mc7swrv9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 09:36:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvaQw/shB6hOWK2iTklRbCbm6Sxtdcqfra50hE+l37TJhJAIddYOtjrI0bRdI/DHf7UaeE1YnVej1DzJ7hSs7z8XxoOWVVsGU51On1sG8fEbUFHibmpuNoa4hEiDG5C+QUfEp7abzIwzR9VVHTh3/SV18a86T36OYCWZCOkZ1dnSQ7bvEECUh5sQo0QF5+ODftQan19dEZRH2irDGSGnSkEP8tjo0Qz5eiH6Y1/NuWmroL1k+ydO+kWSLtroQ776XxOW4HFTgwUcg+OOZGM/0FTvIXjWU3VM0jh5f3vADWX8+jJjwiadnZgcCTh7wmQdS5qeEkF9WwdTnqcgeZSjmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk5Py81be+dfdMffpKQ0SE/j4sVPWDQq/d4wduEI5UY=;
 b=Z1+L/6NhtOXuTSN95fatDZS8R+i5qhgcv4VsUzfjekQeNn4DBB0+5c7/JHni2e8VXTvqugVhJ5I3dkwR65hHVsEE1h247dReNS2LzNLhWt+W+zcBZ2XPC25q7Kw8AzGAXJV9r+NWziSjAMVAJY+R3iCaxGOe+EwbMf9nbWHjQ/xisg3AWB3oAwCYESL8JZiD5ZzxCMyIPHPcPvqz94Fzecxndl8QGjDUTCV9dLE5LoXooIoEcWwJxEyomnDXBLxQe7hXCsnvZUndfJwHLq2yUcXKwSzDyZoe0bH7BEkwEAu+Q1hgKj7zljgrd95I9VdkmNgOajD0o6se5tOZs+Hn6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR15MB1274.namprd15.prod.outlook.com (2603:10b6:3:b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 9 Dec
 2022 17:36:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.018; Fri, 9 Dec 2022
 17:36:55 +0000
Message-ID: <d19c9e1f-b530-07df-de0f-a26c9f3c6dfe@meta.com>
Date:   Fri, 9 Dec 2022 09:36:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf v2 1/2] bpf: Resolve fext program type when checking
 map compatibility
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org
References: <20221209142622.154126-1-toke@redhat.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221209142622.154126-1-toke@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0088.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM5PR15MB1274:EE_
X-MS-Office365-Filtering-Correlation-Id: af530941-e565-42af-d79f-08dada0bf771
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PuImmFjoX0BcFpd0vn5Y+/84s2YK+GCmJM0S1CKCcXhsIDL3lJuiUE0+HfihJODW6pV6vjdC6+dhORszkY49yLSaKEJa7ww3UFZxKZVyIDx+uyYcQRroKfeXGUIZ+Vih4Xf0h1ic8oku6Z/sYDIYGzkds6xA8I9DFPUARAl8BoV06dELqgDe/BtcGuwLEsEmu8bNuqOCw8gpo2stLsu2/WyPWQFwi8XzT1j84PX0kcyL2ubjhBVloPxDQl6MPfyOexQ7EkUAbxGL1dSXtoGv4NzOyDXGKgCCCdgQb5jrgP/lrAimMGfJpjs7jmCzHgeSm9/ESiT1HfMqPCf/0ESqHbBH+fDNj6HTOAfHO9QwjW7/dUlzbZh/CPJ7Xqlor0qTUa9z/AvHMLybBFAn9Rc0NSah7KB9ERHmBnij+pAlxarV1fLDn3U8KSPLYMHt09BOzpyQPDopUa+xhyWGF8j3v9ZYv3ycPEHoNPe8JaNErcYUmu/RqSNfDoQHiwnOej9NQg9/Ld78hSmGNDvmfHd13B1AsiXOj2DvRsumkTJ8j/Zd64I5rYX7feRwoSD7ONAeJwu4iEbUDdb9OZF4L27fEDDKMwFjSO3kNMzlMqIuH6Ofe1wsnZAoj167m2eHvk3Rm1vou/5HzEtLbAZSeq8XPimkC9d3WbQrYwCBaTWMaxfy4b83Ns0tNpMTuexZV4sM7CDiNOPi4u6tR87trE8OQuPJbWriS5L3LNiacqHPe6XSb/lrrz2s8UU10iwWEI3f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199015)(31686004)(5660300002)(2906002)(7416002)(41300700001)(478600001)(6512007)(186003)(83380400001)(66476007)(66946007)(36756003)(66574015)(8936002)(4326008)(8676002)(66556008)(31696002)(316002)(110136005)(2616005)(6486002)(6506007)(6666004)(38100700002)(86362001)(53546011)(921005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak55RWxJSFVMZy9WSTBOYVhNVUg4MUFBckJUWXgyMXZ4UzVzMndoV21rOVRI?=
 =?utf-8?B?T2l1OHpXVTZ1YklSVi9DeWFWQWMwMmRNSXFFSmhOaG1jMXFhN280MVdWcWF6?=
 =?utf-8?B?d2lXaEIrZVNMcjNzNmdOVEhnd25aNjJuejFLTm5EeCt4czFlL2VyNENGdjZ1?=
 =?utf-8?B?OEUwa2JHQUl5enA1WUdpUi9aOFBUdVFPdjRkdERyQXF2YXFMbDJnQjI4SEVC?=
 =?utf-8?B?a1hEQXVvbW91TW1oWEVoRnNXT09kdkRGeW9rWk5icjRCeTlUenZHbWVWR1JH?=
 =?utf-8?B?NXUxazBZd3FuTXU1TFZBNkl1OGVRcmEvbjB4RU1FVVhId2Y1K0paUkkzL0FF?=
 =?utf-8?B?aFlZVzRibnlTUmdaa3lZd0FDNjJ6MlVpMWRvSVBZUndKaS9RcmcveXZ3VVdv?=
 =?utf-8?B?V0VQV2hWRlhyeVFLcFc4ZU9lajFDb21mTk4vclZwV3FEc0luRlVrK1cxSTNz?=
 =?utf-8?B?RlZQZWFTTWIwQ0VZTDhwK1BuNVhSR2hmOEhBVFBWSnF6b3p2eHRHSFd2VXc3?=
 =?utf-8?B?QXFaa3VlVldpcm16UGk2dkJROS9tU3pTUkFGcTQwRUZxVlVpV0R3V0gwY0R5?=
 =?utf-8?B?L3FqUWQ3UFVKSm5JRldKM3Q0cGlsU2xUY01kNjJCemN6d2M0M0pjRDEycy8y?=
 =?utf-8?B?YlFOMXNLcTllRjlFK0lNZFhJVUpYUTBUWkdEeTMwNi8xL0lFVXZwMXUyU2pJ?=
 =?utf-8?B?TjJ4ejlIS2NpMU0xSDY5RkdHV2dobnd5aUZKc3dzL1phQk5zQXZmVjVmTldP?=
 =?utf-8?B?M1BzVWppZ010MlRxcmRoTGZVeWZsWU9PM2ZleWVEY1RVQXVWcGxFZTFIb29V?=
 =?utf-8?B?TFZtc2RmakRVWk41NDVXKzFvcGNQRUN3cFRTV2IrT0ZRT3pJaHFab0JvWTZr?=
 =?utf-8?B?ZkFyRy9XcTRzaC95YmVybzlMczVzejJ3ZzlIT0RJZytNTCtVN3RIN1doeDNu?=
 =?utf-8?B?NmY4eWdoTUdod0xqNXVSSWFNbWhmZXNKb1RzakFmQXZNaEV5SEExZzZXOGRl?=
 =?utf-8?B?TThoTFh2TFZ2VTQzUWhDM1FWMDRpTzAvKzUrd1IwaDltbnNGR25CVUZoZHdv?=
 =?utf-8?B?NWlKZ3hNQW5BMjVwajdmZ2s4Q2o0NzJwbGljRCt5NkRkUDBnZkFIcmluY2VZ?=
 =?utf-8?B?bytjZ25GZVZ2eC9MdmhGczgvdlJTb0lQRmJLMURWYlc2c1BFT013OWNPQVND?=
 =?utf-8?B?aUdiRGEzUlJ1cWRRVGxHQzV3ZmVneUg2WVhCNUZEejlWQjJ2MENjZUd0cm1P?=
 =?utf-8?B?OC95bEIxdTE5SU1oT3M3WlRuMXZmQTc3MWZxc2ZFWllWUFlRaXZPNTEvL1E2?=
 =?utf-8?B?VXlmU3BzMkwzWk5qTEtCZU01TWNkc2ttcUlZSlYwMy9rRytmT0R1Uk5qODl2?=
 =?utf-8?B?K3ArM1o2VEZzZVF1dnRqdVRDYUIxdXF5aXZPSlF1RHcyOTBOWEpYSTFmYm1K?=
 =?utf-8?B?M29VWjhEM2dJSmpjSytDYmc0SDVEMU50Q0I3aGlHNnVlN1pqTXVLRmZvQUlV?=
 =?utf-8?B?MHkreThaVlBMcTdVNjRyNXpqTnJjajJFQ3pqUVVSQ0U4YU5OUHBoUzF2a1Bk?=
 =?utf-8?B?cC9ZMTVRcVp1UXZmOXpEM2NFWXFtZmR5ZGRKYXkvc3IrVFpsYmxMdUdNd0tQ?=
 =?utf-8?B?Y2dFVWsxS2RrdXhrbVRLYlNXRGV3aHY3UTZOV3lXRXE0d1VtU0djZlhVbFc4?=
 =?utf-8?B?V1FETEphdTNhZ2p6NEU1cEZSTW5YS1F2SkdMNGM4WjdzR3gxU0ZCaFVVdnFj?=
 =?utf-8?B?aFE0Q2pPZXdZemZwblFhdVdSakhYVmJUMTMvUlYxempIdFFjdDAxNEx4UUhp?=
 =?utf-8?B?UEtiVnFONGZFVlJybXBqQ2FobjhocGk1Tzd2OVhTb1dVdEF2RUdxSGNFdWRC?=
 =?utf-8?B?NHZOODBOVXowRE9SYnRTY0JKU3FmNS8xMTdYcUQ1SXZORTZhNk5MNmp6REQx?=
 =?utf-8?B?RkhXQ1JvSVZqekdOb3J1T1drWitCV3FVZ05VK1NKVllXMWpkNkdtOWlyVzU1?=
 =?utf-8?B?K1hrcmlkVGkzVDB0M05IUDBudUFXMFVSSm80aTNVbjh1SnFSc2YwdEgwL2tm?=
 =?utf-8?B?SExmY0phaTAyRWpiNG9vMGpRRTRJa2RTblBjR2N5aHFUSytUVHY2TG9CQ0tV?=
 =?utf-8?B?TkpVN0pveWhmaWV5MXhwckRpN3N5bWNWRW5tZGpQMnVDNmJrY2pGV0dDMXpU?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af530941-e565-42af-d79f-08dada0bf771
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 17:36:55.8993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CC+aXaS3COC3Bvg+pP4Re/PpIERt3D9g34cjwhaJdd7UJOJGe+xnEHd55HaR4F+c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1274
X-Proofpoint-ORIG-GUID: dQNCIeQ-wNCbgcACPswD5LgslHs2RqHx
X-Proofpoint-GUID: dQNCIeQ-wNCbgcACPswD5LgslHs2RqHx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_10,2022-12-08_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/9/22 6:26 AM, Toke Høiland-Jørgensen wrote:
> The bpf_prog_map_compatible() check makes sure that BPF program types are
> not mixed inside BPF map types that can contain programs (tail call maps,
> cpumaps and devmaps). It does this by setting the fields of the map->owner
> struct to the values of the first program being checked against, and
> rejecting any subsequent programs if the values don't match.
> 
> One of the values being set in the map owner struct is the program type,
> and since the code did not resolve the prog type for fext programs, the map
> owner type would be set to PROG_TYPE_EXT and subsequent loading of programs
> of the target type into the map would fail.
> 
> This bug is seen in particular for XDP programs that are loaded as
> PROG_TYPE_EXT using libxdp; these cannot insert programs into devmaps and
> cpumaps because the check fails as described above.
> 
> Fix the bug by resolving the fext program type to its target program type
> as elsewhere in the verifier. This requires constifying the parameter of
> resolve_prog_type() to avoid a compiler warning from the new call site.
> 
> Fixes: f45d5b6ce2e8 ("bpf: generalise tail call map compatibility check")
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

Acked-by: Yonghong Song <yhs@fb.com>
