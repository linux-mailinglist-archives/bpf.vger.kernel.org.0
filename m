Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D8B64FAFD
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 17:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiLQQ0B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 11:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiLQQ0A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 11:26:00 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73005DF0B
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 08:25:59 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BHGJJVo013782;
        Sat, 17 Dec 2022 08:25:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ia9RBeAglNxO4us8gAg/LsKm5XdLux0tr3UQdf2P+i8=;
 b=GWGztrG+FK2T8esH01sBItWm+lO9eg8lalKgPGoooOnVOmb2XliwX8Bfm17KjnW//3IO
 P5i+sWDA8Yan4y/PwarFHrdYAucU9b1t/mLXlLLtvKAeKBIDZAkI+DotYYm+zek42Ckc
 wNItwsRyPfc28pGAqwswjV5qxzKpbtFiX+xShC3hJmp+5Ul4paYmksZRzKzcUY4+1P56
 YH4bs5CpSc6SXbQaFzhqdTfgqNimuGlWOtbAfQpnuq7PWxsOSxFmEE4A7ZvaJ6OaI1Qg
 VXIVAuZ1hDipup3WDlpkZL3LQ+wHJVTqhexiBUJdMlRKw5BY7+s9c8QymUljt7gkp1+0 NQ== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mhc63gt4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Dec 2022 08:25:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObTWrD5rj84V2FRa9y0GpBSuLVDl6SH/56/RxpXugW0u2S5SrZmdQCBBTpIhJ70XI52SjbtTqej3cQlVuVSW46+G6GGf55EzDMoXiNTnpBK+EgwnFNAiYz+ZTMxj4PSln4zakClZ0rBeMnjXlr0RBoSm73HkURlsrABs9b3YQOw/p1WncP40ULdbZDzMru8fxo6EY+SSX3BuR4YVV9eOqNZ0DZLWATxwU06K29Wdz4ICuYxFJ9DwtKwi+H5bFd4PdseO4ykp9RC7+6bj8ZrETRSaoRSwbXKWaae3bqitqeL+RdLCwUDiOn3kU/SO4MiuDEp65Oz3kkqB9N7CeBGZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ia9RBeAglNxO4us8gAg/LsKm5XdLux0tr3UQdf2P+i8=;
 b=UVULshWlhwxvaGb44XbaKqM2dPD2I797Z7wffAqUX4QE3DfLSM89wbo4Yk2aaPEhPTUuHL+ZCJc0/I6+tAxsICib+qjrTa7ZPI1746mBo1bGISTaV/SCIbasuljupH+Zk96JjiwTS9VEfc9+6XclC7ePNGfCrs1UuQaYK/ou0KGTFGN2Mla7sKi0KEtqlYewikDH3Qi0HNwcSwEja83MH3X4Ud6gYQWQSpdSM5Z17oEfDnn3LUfkBayG4aUcu9KjJxBIvBgbUdqPTcClVTmuFf+Y2oxjXZKCCQBKgXNEB0bHcCIGMErEffIyK+h52TCswDoTVgFX0I2EXNuZA/Yzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW5PR15MB5265.namprd15.prod.outlook.com (2603:10b6:303:1a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Sat, 17 Dec
 2022 16:25:17 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.015; Sat, 17 Dec 2022
 16:25:17 +0000
Message-ID: <08872103-3300-da2d-edf8-1ffdc806ca44@meta.com>
Date:   Sat, 17 Dec 2022 08:25:14 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH bpf-next] bpf: Define sock security related BTF IDs under
 CONFIG_SECURITY_NETWORK
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20221217062144.2507222-1-houtao@huaweicloud.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221217062144.2507222-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW5PR15MB5265:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e88329-4bea-4295-5f00-08dae04b4894
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NnoUV033rnECLOy/PXFKfjJshuQ7b5OKFo78zKBDeBzGbdyMcArpFriP6My9swcLiEGgXkF+bQAISSoe7acHVRx0YRcC0+mNDow2h4y1DZLeVbcqFPQNFLFJ3XISSsJQGUDu73UaOFoTK+JNWI4F5RKYqibmQXnlv885U1bxTZO0Vdx6fM41OCMDc8WqmY3IqB2pwPFbGbcjgX5sGB3hrrXkMBEgBD6u1IsYfA4yUT7Ii3Do1X2FbCjVnDB8ZoajcOGcJcmNU+5QG17wmvPzcI4hQydCDWTdGKrUocAxgrRRxEqZCpeaTdyYpVGcygNYdl5Pk1FSNIGF37WPx/0fyfkRPJhQpLvttGQt48P1FN48PVY023OhI19vgMqdrV0olA5Hn5k2J1S+jW++Gfu2nfJLKfnkbgW95gHCjs7MjzHLprXN9UxM0xFNW3Cwx3LfN2NOUAQBZWpX1o761zcX5KFR+AVKVbIgcQYLyLTxs92yY/o+GuT9ezguES9CSV69DQf1n8RCgw7Ehv41016nsAEYusGIuRK+W3EKkCua/A9ZxfiKAtTMisPJ7T4L3LigyzN4EsDqVVE65hqI573vZfhBK1hhinORDCBdVUBimHavrVeI6WGcDaFn0pt2rfDpdobeaPeG0ylfDiN6k4+XKe87R/XlduOuFbl20ZU1iReWE0HtyoFGc2OMsTGvNdrxW7qc+gO/Ow+NFB1TdZFi+1AIl9LMdPi/EY2pGxFSNQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199015)(36756003)(86362001)(31696002)(316002)(54906003)(6486002)(478600001)(6666004)(4744005)(7416002)(8936002)(5660300002)(2906002)(66476007)(4326008)(66556008)(8676002)(66946007)(41300700001)(38100700002)(2616005)(53546011)(6506007)(6512007)(186003)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVVJR2U3alRVQVFzZVM4SEZPRUgzYmpUYWZqUDZ4bC93REFnUzlKWnZSanRJ?=
 =?utf-8?B?MGpNOThRWXpqNlpwMlhXTmh1SmNKUHcrYnZHNTNmdkQ3LzA3T0xsS2h4QU1r?=
 =?utf-8?B?R0xpemtXbk43dHVYa1h2R1FPUDA5MEl0WEJBQ1JMM29Qc1VSemZHc212VmJQ?=
 =?utf-8?B?V1V3amhPMFRET3lIS1RHNjViMldPODJOSUlSNHRma3F3dUl6anJ3dDZGeGJo?=
 =?utf-8?B?dFZqajFyWlRKeE9NN0ZaOCt0a2UyZnI2WVJzYmRvNWVIU2dTdDVKK3ZZWXdP?=
 =?utf-8?B?VUowdUdWUHM1ZThRazZJWWMrcFRJb0xXQUNRdXpkMldZSzZPcCtWMWYzU0ty?=
 =?utf-8?B?djdtanJhY2F4U2FvQmVwZGlraEpHMTBHREM0L2FmYjhhK2dtVTlFYm9MU1Iw?=
 =?utf-8?B?bWwxQVJiVFM0VE5pZlhQeGVCR0hFbnNsOEZOVlF5cUtLeitoREkybitFMlVR?=
 =?utf-8?B?ODhRU1NXQkw0U3NXV1RrSDVjRFg4MlQzVi9IMTUrdU5HeXh2QkZUZGZwM3dH?=
 =?utf-8?B?MHB6R3lPdGQyemMxVU4rS0NBc0RsVlBUc3d0WW1sdnlvUFBzL1hLZGdGRFpM?=
 =?utf-8?B?R0NKK3JBSXlzTDZManlXM2ZuS1FrNUl3ZXNLYWljeHJESzhUK0hxVWplRWdY?=
 =?utf-8?B?Wnl5ZW5Nbk84Um1rS3owNHVkWkZLTXJxRFV2MUpENWNSRGREVXZNRnMvMW5G?=
 =?utf-8?B?SisyWGwzRk1QUmRIZUUzTk1KU3krWHRzMzkrWDNCcnpwbGltU2hncW1JYWVX?=
 =?utf-8?B?Um5jRU1sYUxhd2QyWGo1cENKa1ZGdGd1QTFaZ0RGa2YyWDViSFZONlFDNERz?=
 =?utf-8?B?bkNHMUlCOERZd3pWM0tnOCtlcEt1ZzVZcCtuYnc5WUNkak8rc200bEp2RjZ6?=
 =?utf-8?B?V0s2SXJ4Smwycnl3N3h1eXBabDd6ZFB2V2w1OGN0SWVTdUNQYkdieWdpcTVh?=
 =?utf-8?B?azJVaWdWVGhTb3FaYTJveFcwRVhMMElhQnFOOTJkY1hyL3U1U3RUQ0c0MTBh?=
 =?utf-8?B?MjlNY2t1MndIYWhkWkRWb08zNzhzb0pnSm9vSHlVNmFreGQzTDYxZCtFSkR2?=
 =?utf-8?B?eHBGV0t1RGt4UWR4R0xBZWY1ZmVpdjR4cndIM3FxL1JtdjF4SEZlNVluWmxF?=
 =?utf-8?B?R0FHRE9yWnMwb2tqenJFSUp5SHpuMi9JSTFhK0FqTkIzT2I1K0ZXQncySStB?=
 =?utf-8?B?MVo0S2I3M3lHeVo5cXlTWG1YZlNQUFFqNmcxaVB1ZjFNS09zQ2VVWTYwYzdZ?=
 =?utf-8?B?b1haclFPSHBlSUlhVW9tay8zUDRza1paeDNwZ001RzlVSm9DdkZQOWtLSlJ5?=
 =?utf-8?B?WE9HUzEvS0JNZFI0eXNBdkhJV09WSWZDalZxam9TTVNyd3dNQWRhMHU5cnk3?=
 =?utf-8?B?OUhRalhoNGZQaVVIbzVCN2J5MzlHVFRqZFhIM1NXVDZmaFpPSlhobVpXNldu?=
 =?utf-8?B?YlNBQUlzTHI2Zll2V2JCQm9salJtMHRvR2ZtYXlQQlR4aGxBQVlSNmYyTDVV?=
 =?utf-8?B?TXhTc3dQb0xkVUhpL09KclhvQzNScmFpTnBCTEhGZWc2ODJIVmlaQjQyRVBs?=
 =?utf-8?B?cjBmR01QTlZFWUJtWFFpYW5hWVRaVkE4Q21LZWNUd3lwbm5OU0tmNnhkdU5S?=
 =?utf-8?B?VVpwQm1yZ0owTXJBczVTUlM2dUNZNGpOdGw4aUlzR1RSSkFpWFhXa3JNcENy?=
 =?utf-8?B?cURZU0VickZtOU1CdHRMaEpsWmJweWRJZzdyd2Q1ZDZqQWY3elRYQ29jb2tD?=
 =?utf-8?B?TGp4bkF1OUwzYUk4Tkp1Sjl1alE4VzZkUlRsZko4djdLQkorNWVkbjl5WnBp?=
 =?utf-8?B?TmJzai9OUC95Wjl3VFdjNjdvRmk4cWc3YUgvOHQvM1E2cWRrYWtWRFNtZGxs?=
 =?utf-8?B?YVNRM0dMMmhuK1VKazV4ZzFtVm9iYlowdWtlNnh2cHAwYkkzV2M3YUxyWjhD?=
 =?utf-8?B?UDhOaUI2SlUyRWdudnowajNTUDBHbU5rSzJPSnErWEF6OHJtVDE3VVE0SS9p?=
 =?utf-8?B?emlOaWZhaG8vQ1ZTUDlsMlBhZ2laak1CN1JXUzRjN2k4bXZ6V1JVNFI1aDF4?=
 =?utf-8?B?V2VwWW40a0hENFByWTJzaHFPd01ZaXZIYnpRY2huR0pqK2VvTXBZanc2Tk4y?=
 =?utf-8?B?QlQ2dDljektUa1dGYlA1VThQSWZ0UmMya0FVZVJKdlFSNzBRM0thWjQrVFFz?=
 =?utf-8?B?YXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e88329-4bea-4295-5f00-08dae04b4894
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 16:25:17.3386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qixDqZ3wqqBCjszvlLTET8YCJpl5m7k/YkfOnZt2Y+uN1D5CJml9debHdOCqTmK3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5265
X-Proofpoint-ORIG-GUID: blN52BU4cbhF5jaaNQuR3GlcQHGk_WU8
X-Proofpoint-GUID: blN52BU4cbhF5jaaNQuR3GlcQHGk_WU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-17_08,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/16/22 10:21 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> There are warnings reported from resolve_btfids when building vmlinux
> with CONFIG_SECURITY_NETWORK disabled:
> 
>    WARN: resolve_btfids: unresolved symbol bpf_lsm_sk_free_security
>    WARN: resolve_btfids: unresolved symbol bpf_lsm_sk_alloc_security
> 
> So only define BTF IDs for these LSM hooks when CONFIG_SECURITY_NETWORK
> is enabled.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>

LGTM. I think this patch should go to bpf tree.

Acked-by: Yonghong Song <yhs@fb.com>
