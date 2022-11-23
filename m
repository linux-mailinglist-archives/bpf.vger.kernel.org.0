Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C4163658F
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 17:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbiKWQTZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 11:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238502AbiKWQTX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 11:19:23 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC538B13D
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 08:19:21 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2ANB5XQD006973;
        Wed, 23 Nov 2022 08:19:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=U3m94N1Jm0BcKndLD2rmSrvFjYz+9z2oxc8QnqfBw64=;
 b=Z8MGjHdLscbf2tGjmijwWDHkufjBp3sIaOFFS9/VCo+5tAeiQwix2Hu6TWbfl3DIaR2v
 uJjLJ+1mTN3S6rWzZPyi29GOCrJA3zRaxkxOtDqwZ38bSwk5IyFtOaXjBNI2PwLxoQAg
 iDS4XRIxp8pxyJo1bQxysRc3s44X2GYIa5msnrFAf8brBxC/U4zuSib3eiibz7p5CL4F
 OzI8UAxSGkZ8zzgIlu7+eAna5js1bRKaxB6lhyLi9pCterLiRZgE3y5sooczvJt4ayuE
 riBqqzL7rvtHxwHm/rORLU+Ovne4/DdUA5kBLckBqx3aWqHtZZIWdKZ6uG59E6s9PF/6 Mw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by m0089730.ppops.net (PPS) with ESMTPS id 3m1c7rc1t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 08:19:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/QPfPaqEP1EKnWyWY0cNWyabrGGxBhMs21VSbsyLg5zEIflo4yh2owmxNr+Mh/KdrBKbK2F6BjXEhZut5eVAPASeXnjhr9/oDJM0/SVVWFlGoPMQxzPIqDUHl4Ez4qS+sxwLwtj76sY/xYsCVIPlIoKB9rQMma+svqg57g6zlnwqz+OrU3kdzezlQKEpKkghl4MDaTuyv1DYeee8OytmHYASmVIqwR2RgHr22tcH2U0U4EUSWBZ6FnKQI2nvp+sQKGq3mwlrMNzX6+HRWPKPLNFFOHNZm3X7aqyyI1S4eILJuzzXcw1/a3dwHcXKgmMPA3fob5LoguLSBpKi8/Q2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3m94N1Jm0BcKndLD2rmSrvFjYz+9z2oxc8QnqfBw64=;
 b=VZeR3WtqeI/2VgBFOwBjIhGftZAIOBVUn/6IFSvLsUS2qZtD/XRpYFp1DmcPB3MEUirVTeCZhpwriPvQ0z42YrQQ8DEpR2z7RrYp9GozC4EicjGiRRWqWSH1pX8CcyNQ2enm6tdImv/TRu9XE/QVyFR2DQXLoUguvgmuQXHMuYGbIbkz3HlunSIoK/NQiwxLN6cDJbJfaU3xccI1BlBkpfcOdk7LwCYQZSWGztQihswwfRWikOMypNW07PyjLjyBkcZ3u+rzMVRRfzDjlSCgQhRQdO1JV6xSXsVifERBZJR97lM+8g7KR4RZa1Pf26ikawwKtovAypwjYep6CmU4Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4549.namprd15.prod.outlook.com (2603:10b6:a03:376::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 23 Nov
 2022 16:19:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5834.011; Wed, 23 Nov 2022
 16:19:00 +0000
Message-ID: <34cb2b2f-ac3b-65c4-c479-0c4ed3dda096@meta.com>
Date:   Wed, 23 Nov 2022 08:18:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Make sure zero-len skbs
 aren't redirectable
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>, Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com
References: <20221121180340.1983627-1-sdf@google.com>
 <20221121180340.1983627-2-sdf@google.com> <Y34QpET78/KX9JLh@krava>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y34QpET78/KX9JLh@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ0PR15MB4549:EE_
X-MS-Office365-Filtering-Correlation-Id: df3bb8a8-5890-49ce-d44e-08dacd6e6e0e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3eK/bdGDpu4kdVnl+nU2q5zESQH9jtYRWQOt4IZ5trbkrKJhkBvri1Jp8Qe3j7HEcrhei9YKVu/6dX0fuYhwryCDuR6HeYkStpO2W5JyC+hxeT6AdCIOMaj09aHLoHcwsKjM9DiRPUyKwDRKlJTBUFzw62uDzld121IJPePWExIrK5GweqTVD6VsMYuO3ZJXqXSRplu0PJvEtMDCn5ZQppuRuLJRwChQHjMmCskEKRdWMm0TWpk9KGAPIq21qCPKr6GTOLGSygp27DKMgDlVhNPeD5AFhG5lLmdaknfcEPyRx5cOw9Fx49UESdh6dQts/hDmZcDXi942MVsZC8NEwPMFyNt2qA8CKU5v1hDxsS2mcoeo/iwTd94ExYQvsB6wQoUaDGNPyEHur7YdDtQmFDVQgYycJEC55FIGIeupMqS4N6hTbIbwzLaaLeCnmidTHyZBL/fTkKoXLrrHhxYqTA2ns6CF9pgIrQTXRxAFACiSkc10jCzAl9fWVigzEbP69xttySN2yJ6s6m/0Zg2c+motkGNXVP82IfrfpmyMpESxr3NjigRFrNyf1ugTthrJwLD50SM3pa166Px8ocM7aOg3BxCvAgf1Hd9pESVciQ9gnMslWZuZCdMus8JwDOuEmnUXqKyOKnDKuXZ756lLNqecyQoO7MUA0QMCo/lmo+FVUISMcCQOAajgipE6L4FOkj/2qj4Ag+oS+FP/FCfnngIduxVdUfctANKZc/OiwtE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199015)(31686004)(2616005)(6512007)(478600001)(6486002)(83380400001)(36756003)(110136005)(316002)(186003)(53546011)(6666004)(6506007)(38100700002)(86362001)(31696002)(4326008)(66476007)(2906002)(5660300002)(41300700001)(66946007)(66556008)(7416002)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjNVZGxVZXpZUGtOMEF0R0xPb2k2V2hrbXpoNHZlaGtRL1J3SHNnVHhMMnlS?=
 =?utf-8?B?aStjWUl5akIvN3Nrc0pZYWJ4QkJPMkl6bm9HQktPc3pQbU1RVS9yYU83ZGor?=
 =?utf-8?B?blZVWDlLSzlWQm54RjBtRUdlRGk2dE5JVytoNVhETjJycjA2ZjNPb043aTN2?=
 =?utf-8?B?MjZKVGVSNVlXTVVnSXJYM296TzFlYklWZ0pCSkdpRFFhYWo0aXdLYUtuYURJ?=
 =?utf-8?B?SFFaemRUYlpiL3oxRjNmZjRJKzdDVCtXTHdabUREdDltc1hRbXMzU1RiMUxo?=
 =?utf-8?B?cFJjVDdtR2RpazVzMHExeUlHSzNleXI1MHB3WlNuT05rZ3oxTGdqOUEvQnlJ?=
 =?utf-8?B?YzR2ZDhienVDTDZwaWZPajMzZ2NUMi96YW5RQ1hkcEZvdkVXN0Y4a3phZldG?=
 =?utf-8?B?OXYyL2hScGpMQjFkb0FheGNTc2UrY05paG5vbkpWNTdTK3F1bS8yNlFiS1ZI?=
 =?utf-8?B?anhaNVZHczRHVDlkb3BKN2hLODY4VWtoZ3FBSHRTY29QWEVZcnNBOVk1S1Y0?=
 =?utf-8?B?bUNDZTZ6ejZQQmIvOGhYeE13aGI5QmNHU0RCc1YzNG9CZFNDa0MvSVBQNHZK?=
 =?utf-8?B?QjVsa1NYbDBhRDlMQThjSUQxVDF3MFB5UFN1WGY5WkhHNjhibXkzcDhTWThR?=
 =?utf-8?B?aVE2Z0xKQ2lZTkpON0d1SDk3OE9QdUJwNkF2TDRoaWRjZDhYSWZrQndMejhO?=
 =?utf-8?B?MHRmcVB2WmFsNkFOSEZzY2V4U21POUdSQ3N4em5qblpsNmlMUXBQdGdXekJE?=
 =?utf-8?B?NkZIdXFUZDdUOWxzZmZiS0E2dWdlQzhMWEptK21GeU9nZVVISTNHakthMzZE?=
 =?utf-8?B?eFd0WVA2VmhXMVJsK0U1QkVqOElxUVRqbjMyd0NuZUN1SEM4d1pmM1Zac1dn?=
 =?utf-8?B?OWZxUEdkSFVpR2hQV21VbzE4RWJ3WGZLT3dQNmlWRjBTWDl0TW5zZmI4eHlv?=
 =?utf-8?B?c3pZcmttdmhycnhJcVN4UXNaWXhnY0VrNWxIRDhTaUl1bzFubTIxblAxMnpT?=
 =?utf-8?B?cHBBaUFqdzBCcGJUUzNKZHM4dGVSR3ZvbmhxV2JmSk5IVmVmdUVBSnNhS0tj?=
 =?utf-8?B?cE1YcllMRXNYeGs5dWN4Qm5wVU8xdmNobFdNWERPSTN2NWJneVFjZ3o3SmFz?=
 =?utf-8?B?SHNrY2ttVU5ubldJbXAxVGtnRGpCNXo4VlVmWExDaXRKSkg1YnBGUHQwNkJn?=
 =?utf-8?B?Z3BqMWRUbE5wSU4wZVZ6WkVtOVFhZkZPekpYNWJ3YkRkYUcyRm9wRmVYSUpR?=
 =?utf-8?B?aTYzQlg1OUZmK3h2RjdtQXozOEllNmx6di9mT3J5VTQxb0VJWlhXMjBJQk11?=
 =?utf-8?B?SlRhcjY5T0Y4S1dkY2hnMEhJeTJRdTZqVFBsZjQwYXU3WjdWYmFleU9jQzYy?=
 =?utf-8?B?Tm1melh2YlJpeldDbzVwOXFMbkgwbVlKams2ZVdGbGVlNFIzZU5pR2xlRmV1?=
 =?utf-8?B?YlJOUmtJL0dhZ3dNSHlUd2NwUFowMEs5VkQwSURJdWhuZWtoVU1GNzBIUzBy?=
 =?utf-8?B?OG05ejFNM3VVQWZ5bHE0VHF1VXczYlprMTZud0RVZFlYbHNsak9aS0FSY0Nu?=
 =?utf-8?B?TnRPcnllQXVmeFRkeExxZUJ0SVp1Uy9jRWttRnJzYnV2SU5PRC96MzdnUGhR?=
 =?utf-8?B?d0t3MUhEeGovQnF0WEg2cytJYjJJSUdCU2NhL0hjYnZlY3hsSVQ0bDMzRG1s?=
 =?utf-8?B?T0laTGVSbG9oSEtvUW0wU3VoWWh5NWZWT011VWhUb2VpQ0NLRmh6YjZ4QmNx?=
 =?utf-8?B?b05mamRYYWZLaExlMDY0eHgyZzZneGsrTGlya3NpT1pzRXFNODJYT2RJbnk1?=
 =?utf-8?B?MGlhYStSS0E5SkRPc1dsTVR3RzlXUFdHaGQyUzBSK2pwbmJVWkVKRTBQdkhJ?=
 =?utf-8?B?ZGNWT3NWTzFWbHk3YkhVMUJvOEg2Y0VnUkhFSWpnWW01YWVZc3NUdFEycmRt?=
 =?utf-8?B?aFNQYlIyNzdKRHUrQ2JrRzNrUmNRN25WVjM1aUV0R3BieEFnSkNQZ3k2TTUv?=
 =?utf-8?B?T3RteEsyNHJ1MzBMeE5UbkZMWStPMXhjOEVLRGR4NnFuS0VtcTZVRHNBaU12?=
 =?utf-8?B?U2pZZWNrK2xFRDJMMU5RQlNPcFY3MGU5RDJvaDRrWlY2SjB0ZnRjL2IydWd3?=
 =?utf-8?B?SGpUZW9kUXZudGJTSnRWV1dJeEg3S0dWQVVoN2FkZUg4NUx2dkl4c1dSNWVm?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3bb8a8-5890-49ce-d44e-08dacd6e6e0e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 16:19:00.4002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVHQ0Uj0UVhYiYZrlzSJGhueqS6x7qxJ4Pjh7lugieNHmV2IuQuJWXe064XcYea8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4549
X-Proofpoint-GUID: zy6nzC-clRmaAY4YYnEiMVNsuNBVBwje
X-Proofpoint-ORIG-GUID: zy6nzC-clRmaAY4YYnEiMVNsuNBVBwje
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_09,2022-11-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/23/22 4:23 AM, Jiri Olsa wrote:
> On Mon, Nov 21, 2022 at 10:03:40AM -0800, Stanislav Fomichev wrote:
>> LWT_XMIT to test L3 case, TC to test L2 case.
>>
>> v2:
>> - s/veth_ifindex/ipip_ifindex/ in two places (Martin)
>> - add comment about which condition triggers the rejection (Martin)
>>
>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> 
> hi,
> I'm getting selftest fails and it looks like it's because of this test:
> 
> 	[root@qemu bpf]# ./test_progs -n 62,98
> 	#62      empty_skb:OK
> 	execute_one_variant:PASS:skel_open 0 nsec
> 	execute_one_variant:PASS:my_pid_map_update 0 nsec
> 	libbpf: failed to determine tracepoint 'raw_syscalls/sys_enter' perf event ID: No such file or directory
> 	libbpf: prog 'handle_legacy': failed to create tracepoint 'raw_syscalls/sys_enter' perf event: No such file or directory
> 	libbpf: prog 'handle_legacy': failed to auto-attach: -2
> 	execute_one_variant:FAIL:skel_attach unexpected error: -2 (errno 2)
> 	test_legacy_printk:FAIL:legacy_case unexpected error: -2 (errno 2)
> 	execute_one_variant:PASS:skel_open 0 nsec
> 	libbpf: failed to determine tracepoint 'raw_syscalls/sys_enter' perf event ID: No such file or directory
> 	libbpf: prog 'handle_modern': failed to create tracepoint 'raw_syscalls/sys_enter' perf event: No such file or directory
> 	libbpf: prog 'handle_modern': failed to auto-attach: -2
> 	execute_one_variant:FAIL:skel_attach unexpected error: -2 (errno 2)
> 	#98      legacy_printk:FAIL
> 
> 	All error logs:
> 	execute_one_variant:PASS:skel_open 0 nsec
> 	execute_one_variant:PASS:my_pid_map_update 0 nsec
> 	libbpf: failed to determine tracepoint 'raw_syscalls/sys_enter' perf event ID: No such file or directory
> 	libbpf: prog 'handle_legacy': failed to create tracepoint 'raw_syscalls/sys_enter' perf event: No such file or directory
> 	libbpf: prog 'handle_legacy': failed to auto-attach: -2
> 	execute_one_variant:FAIL:skel_attach unexpected error: -2 (errno 2)
> 	test_legacy_printk:FAIL:legacy_case unexpected error: -2 (errno 2)
> 	execute_one_variant:PASS:skel_open 0 nsec
> 	libbpf: failed to determine tracepoint 'raw_syscalls/sys_enter' perf event ID: No such file or directory
> 	libbpf: prog 'handle_modern': failed to create tracepoint 'raw_syscalls/sys_enter' perf event: No such file or directory
> 	libbpf: prog 'handle_modern': failed to auto-attach: -2
> 	execute_one_variant:FAIL:skel_attach unexpected error: -2 (errno 2)
> 	#98      legacy_printk:FAIL
> 	Summary: 1/0 PASSED, 0 SKIPPED, 1 FAILED
> 
> when I run separately it passes:
> 
> 	[root@qemu bpf]# ./test_progs -n 98
> 	#98      legacy_printk:OK
> 	Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> 
> it seems that the open_netns/close_netns does not work properly,
> and screw up access to tracefs for following tests
> 
> if I comment out all the umounts in setns_by_fd, it does not fail

Agreed with the above observations.
With the current bpf-next, I can easily hit the above perf event ID issue.

But if I backout the following two patches:
68f8e3d4b916531ea3bb8b83e35138cf78f2fce5 selftests/bpf: Make sure 
zero-len skbs aren't redirectable
114039b342014680911c35bd6b72624180fd669a bpf: Move skb->len == 0 checks 
into __bpf_redirect


and run a few times with './test_progs -j' and I didn't hit any issues.

> 
> jirka
> 
> 
>> ---
>>   .../selftests/bpf/prog_tests/empty_skb.c      | 146 ++++++++++++++++++
>>   tools/testing/selftests/bpf/progs/empty_skb.c |  37 +++++
>>   2 files changed, 183 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/empty_skb.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/empty_skb.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/empty_skb.c b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
>> new file mode 100644
>> index 000000000000..32dd731e9070
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
>> @@ -0,0 +1,146 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <test_progs.h>
>> +#include <network_helpers.h>
>> +#include <net/if.h>
>> +#include "empty_skb.skel.h"
>> +
>> +#define SYS(cmd) ({ \
>> +	if (!ASSERT_OK(system(cmd), (cmd))) \
>> +		goto out; \
>> +})
>> +
>> +void test_empty_skb(void)
>> +{
>> +	LIBBPF_OPTS(bpf_test_run_opts, tattr);
>> +	struct empty_skb *bpf_obj = NULL;
>> +	struct nstoken *tok = NULL;
>> +	struct bpf_program *prog;
>> +	char eth_hlen_pp[15];
>> +	char eth_hlen[14];
>> +	int veth_ifindex;
>> +	int ipip_ifindex;
>> +	int err;
>> +	int i;
>> +
>> +	struct {
>> +		const char *msg;
>> +		const void *data_in;
>> +		__u32 data_size_in;
>> +		int *ifindex;
>> +		int err;
>> +		int ret;
>> +		bool success_on_tc;
>> +	} tests[] = {
>> +		/* Empty packets are always rejected. */
>> +
>> +		{
>> +			/* BPF_PROG_RUN ETH_HLEN size check */
>> +			.msg = "veth empty ingress packet",
>> +			.data_in = NULL,
>> +			.data_size_in = 0,
>> +			.ifindex = &veth_ifindex,
>> +			.err = -EINVAL,
>> +		},
>> +		{
>> +			/* BPF_PROG_RUN ETH_HLEN size check */
>> +			.msg = "ipip empty ingress packet",
>> +			.data_in = NULL,
>> +			.data_size_in = 0,
>> +			.ifindex = &ipip_ifindex,
>> +			.err = -EINVAL,
>> +		},
>> +
>> +		/* ETH_HLEN-sized packets:
>> +		 * - can not be redirected at LWT_XMIT
>> +		 * - can be redirected at TC to non-tunneling dest
>> +		 */
>> +
>> +		{
>> +			/* __bpf_redirect_common */
>> +			.msg = "veth ETH_HLEN packet ingress",
>> +			.data_in = eth_hlen,
>> +			.data_size_in = sizeof(eth_hlen),
>> +			.ifindex = &veth_ifindex,
>> +			.ret = -ERANGE,
>> +			.success_on_tc = true,
>> +		},
>> +		{
>> +			/* __bpf_redirect_no_mac
>> +			 *
>> +			 * lwt: skb->len=0 <= skb_network_offset=0
>> +			 * tc: skb->len=14 <= skb_network_offset=14
>> +			 */
>> +			.msg = "ipip ETH_HLEN packet ingress",
>> +			.data_in = eth_hlen,
>> +			.data_size_in = sizeof(eth_hlen),
>> +			.ifindex = &ipip_ifindex,
>> +			.ret = -ERANGE,
>> +		},
>> +
>> +		/* ETH_HLEN+1-sized packet should be redirected. */
>> +
>> +		{
>> +			.msg = "veth ETH_HLEN+1 packet ingress",
>> +			.data_in = eth_hlen_pp,
>> +			.data_size_in = sizeof(eth_hlen_pp),
>> +			.ifindex = &veth_ifindex,
>> +		},
>> +		{
>> +			.msg = "ipip ETH_HLEN+1 packet ingress",
>> +			.data_in = eth_hlen_pp,
>> +			.data_size_in = sizeof(eth_hlen_pp),
>> +			.ifindex = &ipip_ifindex,
>> +		},
>> +	};
>> +
>> +	SYS("ip netns add empty_skb");
>> +	tok = open_netns("empty_skb");
>> +	SYS("ip link add veth0 type veth peer veth1");
>> +	SYS("ip link set dev veth0 up");
>> +	SYS("ip link set dev veth1 up");
>> +	SYS("ip addr add 10.0.0.1/8 dev veth0");
>> +	SYS("ip addr add 10.0.0.2/8 dev veth1");
>> +	veth_ifindex = if_nametoindex("veth0");
>> +
>> +	SYS("ip link add ipip0 type ipip local 10.0.0.1 remote 10.0.0.2");
>> +	SYS("ip link set ipip0 up");
>> +	SYS("ip addr add 192.168.1.1/16 dev ipip0");
>> +	ipip_ifindex = if_nametoindex("ipip0");
>> +
>> +	bpf_obj = empty_skb__open_and_load();
>> +	if (!ASSERT_OK_PTR(bpf_obj, "open skeleton"))
>> +		goto out;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(tests); i++) {
>> +		bpf_object__for_each_program(prog, bpf_obj->obj) {
>> +			char buf[128];
>> +			bool at_tc = !strncmp(bpf_program__section_name(prog), "tc", 2);
>> +
>> +			tattr.data_in = tests[i].data_in;
>> +			tattr.data_size_in = tests[i].data_size_in;
>> +
>> +			tattr.data_size_out = 0;
>> +			bpf_obj->bss->ifindex = *tests[i].ifindex;
>> +			bpf_obj->bss->ret = 0;
>> +			err = bpf_prog_test_run_opts(bpf_program__fd(prog), &tattr);
>> +			sprintf(buf, "err: %s [%s]", tests[i].msg, bpf_program__name(prog));
>> +
>> +			if (at_tc && tests[i].success_on_tc)
>> +				ASSERT_GE(err, 0, buf);
>> +			else
>> +				ASSERT_EQ(err, tests[i].err, buf);
>> +			sprintf(buf, "ret: %s [%s]", tests[i].msg, bpf_program__name(prog));
>> +			if (at_tc && tests[i].success_on_tc)
>> +				ASSERT_GE(bpf_obj->bss->ret, 0, buf);
>> +			else
>> +				ASSERT_EQ(bpf_obj->bss->ret, tests[i].ret, buf);
>> +		}
>> +	}
>> +
>> +out:
>> +	if (bpf_obj)
>> +		empty_skb__destroy(bpf_obj);
>> +	if (tok)
>> +		close_netns(tok);
>> +	system("ip netns del empty_skb");
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/empty_skb.c b/tools/testing/selftests/bpf/progs/empty_skb.c
>> new file mode 100644
>> index 000000000000..4b0cd6753251
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/empty_skb.c
>> @@ -0,0 +1,37 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>> +#include <linux/bpf.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_endian.h>
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +int ifindex;
>> +int ret;
>> +
>> +SEC("lwt_xmit")
>> +int redirect_ingress(struct __sk_buff *skb)
>> +{
>> +	ret = bpf_clone_redirect(skb, ifindex, BPF_F_INGRESS);
>> +	return 0;
>> +}
>> +
>> +SEC("lwt_xmit")
>> +int redirect_egress(struct __sk_buff *skb)
>> +{
>> +	ret = bpf_clone_redirect(skb, ifindex, 0);
>> +	return 0;
>> +}
>> +
>> +SEC("tc")
>> +int tc_redirect_ingress(struct __sk_buff *skb)
>> +{
>> +	ret = bpf_clone_redirect(skb, ifindex, BPF_F_INGRESS);
>> +	return 0;
>> +}
>> +
>> +SEC("tc")
>> +int tc_redirect_egress(struct __sk_buff *skb)
>> +{
>> +	ret = bpf_clone_redirect(skb, ifindex, 0);
>> +	return 0;
>> +}
>> -- 
>> 2.38.1.584.g0f3c55d4c2-goog
>>
