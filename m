Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDAB4D5A4C
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 06:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiCKFLp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 00:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240951AbiCKFLo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 00:11:44 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A62A1AC28D
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 21:10:42 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22B3NSXX015207;
        Thu, 10 Mar 2022 21:10:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=sFFpbnuHzN1QFm4o4xH9sub+g6eu+w2GbM/uauWGnP8=;
 b=BDe6Zjjn4IEH7MAeePJJtl+NwsPHwOcZIlMVbJCRLN+ELXca4DOjWf3BrnYahDPk7UJ7
 nlvwq8PknP6sqfsttUcePindJs1kNxlwt30kfCjM6WKpXYS3BkMegJchHp5YELOpiOLK
 KJcnm1GU9b6LRzB3IArL07yC2zVmKatAeoQ= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eqxfu8cm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 21:10:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbY1nKfOD9DlxSLS6WBrQk8829iZa6RU4tJ20uQjUHdcdhRU2yLqZejzJJH/18zj2iAINF1d4Sd0a218iStDC1ZNg0S/Xq4HJ+RXO1XPgwVT6E2F1CnoQUZsKVBEzL8bhORb6MUZjjrJBX4PkgE0EJU8TsnF0mMF5L3uGrA5Zc+E4kMTF/ZCh5X74qtfBuAbUqanJP5qatSfI1TRAqqZOxPZ4PZgI5pLWf/UYcvBwPhS6yODnmZA1vhun5g/h1mtWFpkEEhUMQyoVrtlEiSgDbZSEGxDnL01h0Z7z6tJVh/Oii0GqrKspGTgDdYV/Dk1zlA5s22l5OtPbFRyUM8tXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFFpbnuHzN1QFm4o4xH9sub+g6eu+w2GbM/uauWGnP8=;
 b=jkf4lRqN85d/GQundPfF4iEOm7lIpHK7xAkyWwdpg/SGXNaLWKnVshl6zoZ1vmqKgn8cafX+ypF1+kRT9Hv0xQp7jIeNeKsI2chcIlRG/B8gthPgfIk98fL4NB/+UoUO2QGvBotmK4CDK7RtcK62Lsu8UuifNBzUjWMGy2FjXOhXtypVN4WX/hMV5LoBdm2NLabjnoCzLuLhrGYf9c6S6ClqohSMXlgbeFq8g1VsRoukicW52x+jQ81xZsfnf1YIMLewYwigaVot7BODNP+/vPj42+HQHUR1WHwJ94loJVeb84h+Yv11Sj25Qy6MRLdQZ3+Z2CZXtoDIAMRLQk6DPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN6PR15MB1732.namprd15.prod.outlook.com (2603:10b6:405:5b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Fri, 11 Mar
 2022 05:10:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c5c7:1f39:edaf:9d48]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c5c7:1f39:edaf:9d48%4]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 05:10:25 +0000
Message-ID: <9f4b3d01-d47f-bb3c-0ced-b83978c15dde@fb.com>
Date:   Thu, 10 Mar 2022 21:10:22 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH bpf-next v2 0/5] Subskeleton support for BPF libraries
Content-Language: en-US
To:     Delyan Kratunov <delyank@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <cover.1646957399.git.delyank@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <cover.1646957399.git.delyank@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR15CA0028.namprd15.prod.outlook.com
 (2603:10b6:300:ad::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93dad455-1aaa-458e-519c-08da031d7379
X-MS-TrafficTypeDiagnostic: BN6PR15MB1732:EE_
X-Microsoft-Antispam-PRVS: <BN6PR15MB1732463C8CF25176E6D065A9D30C9@BN6PR15MB1732.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3v5yYQeoXQaBcJpKPFWToWQ4JPdcV9S04RslAp+sFFJIWnumBQe0U38vVRji3hWKDegTq2XkOVKBH8DXuTjWi1MuhKCbs2A2L72R9DmuhaavNDZe28wWisFnjt0+wxkQzFr3TI7aGClil6u5CgzOhzaDrmT9+8RT1ss6s9xt8agjgppy7Vw07JZg01rHeF6d/d+5mjYQnCcwDfn1EfZiaGtE/gWsCDEFjSRLqp/gR3HsAaCpfv1wJzNjjxVzyeuBk1qWmd9SgdNLfihgAxq6x5EppDq2DyQ8tvboBvf4pCNFbi52NREJcKptQa6GiT/b3/BX9pzuA8SkYknYXpSjBq3B2iCj/o8Qvo5jWTFxxQmvq9ouKoNMzqVVFgJbwNMp6R3spUwsU/4I+VN//lzGHwzxbG7vEIZG731RNMGJ85j7AtnyDDTDQsSxM8UzsQEKuVin2DWnpcNFrJVfQJc/GwxTmpwN5eNSnIEwmK59t0UJHaynKiNJAQTc4Ngfjr9rBbp6jFRNbBWz3YXpWU6FUtvzp1DCTzRwMFgh1V9skIas5o1F/dRS9Fx9R7g7sGM2tHlw4qnTthh0ncf/jieQAn28UAgV1gT/h+pwCXU1onniWXa1EbXgzIC8X7I1uZpO5sSzYMja2NIcVDoBOgqOj11yN8fPS3cLh/lyy5hLhtzaMmglsZOqLzO4xAEwlPMZxqFQKp/X+lHl7xTwh+0hCDXWa7qGyKgAQ2Z3XP5V9Yg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(6666004)(52116002)(508600001)(5660300002)(2906002)(86362001)(53546011)(6506007)(8676002)(83380400001)(6486002)(66476007)(66556008)(36756003)(66946007)(38100700002)(2616005)(186003)(316002)(6512007)(8936002)(110136005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzBsSGhpOGVxR0xUZXRsdk9HVkRrRDRudzR5b3hXU1U3K3hTUndNWGtlYlZi?=
 =?utf-8?B?QTVFUTRONzhJSnF0SVpKQkt3Q3ErVHRoaXEyV2RRckRuakpNaG9udnVoS1pB?=
 =?utf-8?B?RVVDSStKbDYvZFBlancyeXdPSm9xeS9oc3pSbnVxSUM3OTc2bUNNTzBsMEhL?=
 =?utf-8?B?dnFYSFUrNGpnaEJqbkZ0SWNjTzRVY1pmcEJuaGczeWpaQkNQNCtlOTBTQmVl?=
 =?utf-8?B?bXpsVnpkd2JYbE9GeUp3T1F1RGRWWXhGLzdDOXMvZzJZdEd3WVhPYzRHby9L?=
 =?utf-8?B?RXJLbTBJd3NtaklRZE9ZV1ZDTmFnTkpoaVp6UnIxRURvOFJPalYrTmNSMjRw?=
 =?utf-8?B?eVlFL3lvSjNvTTg2S3BEL25iSVpROWQrYWhKMlNBVm1ZdDN2OVVxTzhvT3RJ?=
 =?utf-8?B?YW44V1g4LzBpUGoxK0I0bTFjVGp6UEtnTG5SUWxtRnluRlN3V3V2QW5ySFpG?=
 =?utf-8?B?NkxDekdQcmdFT2JxMWpoSGxWalZVTEFyQXFRamZqUExDWkNqRVVwc204dEJM?=
 =?utf-8?B?RFd1YWNHYnB2aFRoYmEzOGRQVWIvc2RkOG1DUjViNzRnaWdXMnNBaFFvZVFV?=
 =?utf-8?B?VjJkU0xnb1NrRU9oVzBlaktRNFVzWUxYSUFLUENGYUVFYmJ1RERUMFFEa2ZF?=
 =?utf-8?B?bmY0SkJFcXZFanNtWHE3bVZHNUJlcVMwT1FHdm4xMlJsS05kOEZXR0RUZFdv?=
 =?utf-8?B?aEd1OEFWdmVvNFRaTEI0dUh2T2dFbE5HTFlPWmxoRXErelZyY1BRYjUySmFI?=
 =?utf-8?B?MERiRzJCUjVqS0c0MEQydTNGaG9HWkdSWjQ0MjFkOVlNb2NnN3RtQjFvZ2Fk?=
 =?utf-8?B?MnY0R3IrSitHU3hDaFFxaUlFaU4vZkNHc0VKUE80SWIxeTVBSXZpbDhGdjJN?=
 =?utf-8?B?cEFaMUZ3OGwreUJ5bk0rQWhMaWRLQTNVRFN5alBGb0lidldZdFJSUHFLWmNM?=
 =?utf-8?B?eGNHR3JrMWd2SHRsKzVyM1VtcmRsUmhYRGtpSGo5cnlBSlFtU0dPem42ZG1U?=
 =?utf-8?B?eGg0VUhTMi80VTNoc3dhQkVpZ2dBZnBNVGlpU3MxSUhoa25pN2FabGptTDZB?=
 =?utf-8?B?dHk4T1NXYWxPMFdiUktoU2ZkdlQ4K3gxQ29kUVNicnUvSmMvYS8wODZmaC9h?=
 =?utf-8?B?M0dhWkMrMTNHZnJDODVaZTF4V0hHZlRnS21wdkhYZFkrY0pUVStWNzQvejZP?=
 =?utf-8?B?dC8yM1R3OEhBYkk2V2taZVc4ejhzTFE4bjJhd0lGQ2hGQ2JBeklSczhVSDFv?=
 =?utf-8?B?c3l6dFNxZWlyK0xXVXhUdy9YY3VLV1FtQ21MT3lwanhXaTlKdzhFSnFhdGJ2?=
 =?utf-8?B?eDVhWnJuWFBJb1FtYlpmVEpnZUxrUXBGY2k2aHFXYWpBMVdMcWZuOTJiMlNM?=
 =?utf-8?B?M2ZQSlBIeUpvQWs0eU00RTh3Tm5PTkEyRithZHhOMWZ0eGVqd2dpMjVBVmpF?=
 =?utf-8?B?a3BIaUxYOUcvcDZHV09pMUI1VmMxV0c4cWNYWDg1Yk04MFdwdXc3bVlYV3N3?=
 =?utf-8?B?NWxLRDdOaUw1aW1jeUhBZWVsK3pGTWx2R0VDMTJEWUsyMTVBa24zTjhZeTcy?=
 =?utf-8?B?bU9UZ2NXR3c0enJGMWtKWnk1OUg0SkRDcEk2R3o3ZStjczdEK0crcEtpRkhB?=
 =?utf-8?B?QlBXMHNxYnFMSnd6cC9Nb0ZHLzY3Q21kY0dLeGszcWhKVTc4LzBkdTFCNlBL?=
 =?utf-8?B?NkZSWnRPKzQzOXhPSS81OFQxOExzNnJwNXY1OGJvc0FMZEVJYlh4eTBEdEx5?=
 =?utf-8?B?bS96N1NoemRLcCtpLzErUE5HZWUrQkE0a2ZBV25FMi93Mk9DeVMwVFc1SjFl?=
 =?utf-8?B?eVdJTUZLMVd1c3l0V2phSDRmMER1cUtZMHl2Zjc5OFYyWEFCZldEd01mMVBJ?=
 =?utf-8?B?R0dlaEkyQjN6WUJrbjhjaktnSlppZGI5K3FvZDJ2YjA5WHg0Ky9ISTFJTmJV?=
 =?utf-8?B?L2dVZkNrUHlFUS9oTlIzWVoxb1RabC94ZDV2QVVwVlBUWDg4OWlQOXRMeFY0?=
 =?utf-8?B?dVFBMVBjT3ZpdGM2Mk9odmZYSEdISHBQeHJCVWNpdG5UTk4xZlk3RFU0MW5s?=
 =?utf-8?B?cit5eFpwRE9PSEpQeGNVNjg4TVFRa2R6NGZaeDAwaU5qVERtUFNOK0M4ZnNx?=
 =?utf-8?Q?b+rL7UrPNUfCyx5mAwAddT72p?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93dad455-1aaa-458e-519c-08da031d7379
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 05:10:25.3705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yT0IFo24nGSn3MWpZh/jT30PwbQ1SAy5ZJ7mHwfSvNyKvOjPX9WnkPYJ84Tmxtc+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1732
X-Proofpoint-ORIG-GUID: JPeNoTfAzw4_7d-kV7DNcYqrVlfD5DWb
X-Proofpoint-GUID: JPeNoTfAzw4_7d-kV7DNcYqrVlfD5DWb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_09,2022-03-09_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/10/22 4:11 PM, Delyan Kratunov wrote:
> In the quest for ever more modularity, a new need has arisen - the ability to
> access data associated with a BPF library from a corresponding userspace library.
> The catch is that we don't want the userspace library to know about the structure of the
> final BPF object that the BPF library is linked into.
> 
> In pursuit of this modularity, this patch series introduces *subskeletons.*
> Subskeletons are similar in use and design to skeletons with a couple of differences:
> 
> 1. The generated storage types do not rely on contiguous storage for the library's
> variables because they may be interspersed randomly throughout the final BPF object's sections.
> 
> 2. Subskeletons do not own objects and instead require a loaded bpf_object* to
> be passed at runtime in order to be initialized. By extension, symbols are resolved at
> runtime by parsing the final object's BTF. This has the interesting effect that the same
> userspace code can interoperate with the library BPF code *linked into different final objects.*
> 
> 3. Subskeletons allow access to all global variables, programs, and custom maps. They also expose
> the internal maps *of the final object*. This allows bpf_var_skeleton objects to contain a bpf_map**
> instead of a section name.
> 
> Changes since v1:
>   - Introduced new strict mode knob for single-routine-in-.text compatibility behavior, which
>     disproportionately affects library objects. bpftool works in 1.0 mode so subskeleton generation
>     doesn't have to worry about this now.
>   - Made bpf_map_btf_value_type_id available earlier and used it wherever applicable.
>   - Refactoring in bpftool gen.c per review comments.
>   - Subskels now use typeof() for array and func proto globals to avoid the need for runtime split btf.
>   - Expanded the subskeleton test to include arrays, custom maps, extern maps, weak symbols, and kconfigs.
>   - selftests/bpf/Makefile now generates a subskel.h for every skel.h it would make.
> 
> For reference, here is a shortened subskeleton header:
> 
> #ifndef __TEST_SUBSKELETON_LIB_SUBSKEL_H__
> #define __TEST_SUBSKELETON_LIB_SUBSKEL_H__
> 
> struct test_subskeleton_lib {
> 	struct bpf_object *obj;
> 	struct bpf_object_subskeleton *subskel;
> 	struct {
> 		struct bpf_map *map2;
> 		struct bpf_map *map1;
> 		struct bpf_map *data;
> 		struct bpf_map *rodata;
> 		struct bpf_map *bss;
> 		struct bpf_map *kconfig;
> 	} maps;
> 	struct {
> 		struct bpf_program *lib_perf_handler;
> 	} progs;
> 	struct test_subskeleton_lib__data {
> 		int *var6;
> 		int *var2;
> 		int *var5;
> 	} data;
> 	struct test_subskeleton_lib__rodata {
> 		int *var1;
> 	} rodata;
> 	struct test_subskeleton_lib__bss {
> 		struct {
> 			int var3_1;
> 			__s64 var3_2;
> 		} *var3;
> 		int *libout1;
> 		typeof(int[4]) *var4;
> 		typeof(int (*)()) *fn_ptr;
> 	} bss;
> 	struct test_subskeleton_lib__kconfig {
> 		_Bool *CONFIG_BPF_SYSCALL;
> 	} kconfig;
> 
> static inline struct test_subskeleton_lib *
> test_subskeleton_lib__open(const struct bpf_object *src)
> {
> 	struct test_subskeleton_lib *obj;
> 	struct bpf_object_subskeleton *s;
> 	int err;
> 
> 	...
> 	s = (struct bpf_object_subskeleton *)calloc(1, sizeof(*s));
> 	...
> 
> 	s->var_cnt = 9;
> 	...
> 
> 	s->vars[0].name = "var6";
> 	s->vars[0].map = &obj->maps.data;
> 	s->vars[0].addr = (void**) &obj->data.var6;
>    ...
> 
> 	/* maps */
> 	...
> 
> 	/* programs */
> 	s->prog_cnt = 1;
> 	...
> 
> 	err = bpf_object__open_subskeleton(s);
>    ...
> 	return obj;
> }
> #endif /* __TEST_SUBSKELETON_LIB_SUBSKEL_H__ */

When I tried to build the patch set with parallel mode (-j),
    make -C tools/testing/selftests/bpf -j
I hit the following errors:

/bin/sh: line 1: 3484984 Bus error               (core dumped) 
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/sbin/bpftool 
gen skeleton 
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/test_ksyms_weak.linked3.o 
name test_ksyms_weak > 
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/test_ksyms_weak.skel.h
make: *** [Makefile:496: 
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/test_ksyms_weak.skel.h] 
Error 135
make: *** Deleting file 
'/home/yhs/work/bpf-next/tools/testing/selftests/bpf/test_ksyms_weak.skel.h'
make: *** Waiting for unfinished jobs....
make: Leaving directory 
'/home/yhs/work/bpf-next/tools/testing/selftests/bpf'

Probably some make file related issues.
I didn't hit this issue before without this patch set.

> 
> Delyan Kratunov (5):
>    libbpf: add new strict flag for .text subprograms
>    libbpf: init btf_{key,value}_type_id on internal map open
>    libbpf: add subskeleton scaffolding
>    bpftool: add support for subskeletons
>    selftests/bpf: test subskeleton functionality
> 
>   .../bpf/bpftool/Documentation/bpftool-gen.rst |  25 +
>   tools/bpf/bpftool/bash-completion/bpftool     |  14 +-
>   tools/bpf/bpftool/gen.c                       | 589 ++++++++++++++++--
>   tools/lib/bpf/libbpf.c                        | 151 ++++-
>   tools/lib/bpf/libbpf.h                        |  29 +
>   tools/lib/bpf/libbpf.map                      |   2 +
>   tools/lib/bpf/libbpf_legacy.h                 |   6 +
>   tools/testing/selftests/bpf/.gitignore        |   1 +
>   tools/testing/selftests/bpf/Makefile          |  10 +-
>   .../selftests/bpf/prog_tests/subskeleton.c    |  83 +++
>   .../selftests/bpf/progs/test_subskeleton.c    |  23 +
>   .../bpf/progs/test_subskeleton_lib.c          |  56 ++
>   .../bpf/progs/test_subskeleton_lib2.c         |  16 +
>   13 files changed, 919 insertions(+), 86 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/subskeleton.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton_lib.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton_lib2.c
> 
> --
> 2.34.1
