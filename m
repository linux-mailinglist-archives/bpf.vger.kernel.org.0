Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22D94CE6A9
	for <lists+bpf@lfdr.de>; Sat,  5 Mar 2022 21:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiCEUCA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Mar 2022 15:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiCEUCA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Mar 2022 15:02:00 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7572AE0
        for <bpf@vger.kernel.org>; Sat,  5 Mar 2022 12:01:08 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 225BwwsJ008598;
        Sat, 5 Mar 2022 12:00:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5KFgTmCCm6+0zVaQeNSeU91ZOiM/+jdT4e6meu9hoh4=;
 b=mXjDbG4+3UstWFZmU6MU2ssR6+v44RiuusYSZjNgYF5qhnaF1WUV2ZCnJ5LdjZnmn91P
 helH9VtEL51IuXLRGGIywephz00Kudx4hvF4arezNzMVXfhpeRwXzqdX7dVxw59fhGB8
 EvWihO6JjFd9LdnmdtNwU4SN2osJTwXAZq4= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3em6g29rhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Mar 2022 12:00:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kadY+1NaKFYr5fUDf3V66PEZfTRQaVJlJqZjv0KCRoFBC0yTSEJAWZjU3XKcVnJepBFiJB71hlN7tpurst14vLdG488Q5P8yTzxG2a4I5HelE+kmV5Swbd4qSysntMfNh6DpX9v2WXmh+HyHTEe1HyX5yyiQjy7hPGyGMSTyBOrJBIgcklCFD4mv/XQthNKJDxJKIwHy80V+DuSqEgsS/3h9HZWX0gqTG340dQ7WZok/MMxXv/G+GNCbDhix5KQdnZ2GkmXcMspaHOoODUhttZXU3MFVwgye3yGGxA/ajDhuqd1lpBVCEt1sLYVcjKnC+ZLH6YH2+YF+69GVcoX0/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KFgTmCCm6+0zVaQeNSeU91ZOiM/+jdT4e6meu9hoh4=;
 b=Y+svsZIEC+8IPb06lv9+9yceHHbUxfJuF2NahIUHfwJaER1Qy05XUE1MW6+s6h2fl5jxns+zuJcFd/B8i4EF1vFlF/qf3H7dQtHuDXF+737j8luPp//d2wjniucDzovZws23WO+X0v8STVhv0tfuBoXA5gpWr0pkhoCapByse/JVN2TVOHyld0qJGUQX5O0FsR/b3rc6Y7R61SI9Y4gmITg1+kviQbF1b7h14pMkD4ZjNjkYjogGnJ49awpRATSaSwdOwrCK+sAcHhyZ9A5JCtfFlx5D5Zji7Km0aMqg6VjIot62HfMmZ7keO2uifiynL7nh9qThoKVO7MLOf+sL1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4361.namprd15.prod.outlook.com (2603:10b6:303:ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Sat, 5 Mar
 2022 20:00:49 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5017.029; Sat, 5 Mar 2022
 20:00:49 +0000
Message-ID: <03e251f5-6a5e-cd07-9f72-82e25a96cd62@fb.com>
Date:   Sat, 5 Mar 2022 12:00:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Fix checking PTR_TO_BTF_ID in
 check_mem_access
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     acme@kernel.org, KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
References: <20220304191657.981240-1-haoluo@google.com>
 <20220304191657.981240-2-haoluo@google.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220304191657.981240-2-haoluo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:303:dd::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c298c82-4b67-4ec4-c063-08d9fee2d834
X-MS-TrafficTypeDiagnostic: MW4PR15MB4361:EE_
X-Microsoft-Antispam-PRVS: <MW4PR15MB436135F203BF4206BB108E02D3069@MW4PR15MB4361.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbmAgZjNZa1YBhwAsVH55lGcCP+pvvoL5QarBUV5pel17DZqub7OeoQyytEH6zjJ9sP3fk25t4V3eetl5HtxmKczrtL0dORkUr+LlIQMBwmRao1CEz78RpAQ5+yp7lXpmhqUEF23KE+3cfsbUzdW4WN0ImYe/wi8yCfXa+FwsztuMEEuASEya70BVMt+Oy3IsbABIm6/F7/oDp0waSMgqdbFjJ7rU8OCW5x94ju5cdUEQcouyX0daZ/jma+cJ6MxGdGBbqVic0KlUVA51AstL4TlG8NEIE6Vck2hfSvz01A6rUYOvLTyCVeE2RmxRBnnNQ8c0u2dxUVMQJXS/TVVe4yKMan3/VrAhown5CI/QErr6en/BFJDLKUXgwDUQK8N/p5DnxYkW1eq2MjB+13VxPjOXbjhC3j7QEcQWMp4KgW0D6iXeGYHZToXD7hqp+7awzMZZFFPleS7af7Fk6tUOValrTKaEs3wjspAWNTCQjCC85tv3WneKlzQ2k4xVrG4J+OUOldKIJpNpW/iyqBdcxMEYHe3LAoPj4C5zJYiq3T9Vgin/wb3O0t8UW+19AlOmPbqWNEUNYTVBdcsA3LuLmq/WOD6P7jpLmiJFH+TN+gj7CZTTosXQZpeFMHBlbI+ox9Vm9e1/8xbm8GmWjTu3KgCjoG8lgm76QVDjG03lIB9LyYQCykqsByz9Wblosj7mNlHOflmMq1nher1I0I3g5cDk1sOezfwf8rK8tfGxyQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(86362001)(6666004)(316002)(83380400001)(508600001)(31696002)(6512007)(110136005)(8676002)(66946007)(66556008)(66476007)(6506007)(52116002)(53546011)(4326008)(8936002)(36756003)(2906002)(2616005)(186003)(5660300002)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUVnYnhwa3BlTTQ2dStURjVmTXlsQjlrR3BpaTU1Q0NZTkVvMlBGRUhBbXBw?=
 =?utf-8?B?WG52NE53TGIvSGNtTkxOQlM3Y0hMYXQrb1JOOVJnQlIyanVsVHI0U3BSRE9r?=
 =?utf-8?B?VjEyYUJBNWdqQlM3SXhEMm1rQWwzaUw4dTU2cUxnV1E4NnpYYUdrK3g2OXFN?=
 =?utf-8?B?dHE4ZzVEc1E3ekl1cm5nRHMvQ0haUGoxdDRZNWhEOGU4emxBODVzdWNWYmNU?=
 =?utf-8?B?L3pVNjNKbCtFeEVGUDQ3dzNSOFdUSmpsQkMyL3ZmNVNzNjNVbmVPSlMrTERv?=
 =?utf-8?B?N0F0Nm1qa295b0tUZk15Um5qa3BtdnRFbXF1RVhERUhiUWJIbE9UcnQ3WW5t?=
 =?utf-8?B?SWhiZWJOdmVUeVBVOWFVVXB4RGh1WXdFRzM4anJiZ2VPakhlWk9EYmJxVGg1?=
 =?utf-8?B?bDV5M3FyMkJLSE9rTmpXdS8zS3JQaTNsd3RpU1h2STU0QkdQdXkxYXRablNx?=
 =?utf-8?B?QytNNzV1MTUvRTRGUG9QVEF4NmR0enFBRVd1d0NJRjJ1c0JuNlRxUWszSjNF?=
 =?utf-8?B?bkdJV2ljM0tPRTBLK0x6S2V4NnVqbzNEQWkxRW1tcDZMYXBWZGJ2ZWhqUkdJ?=
 =?utf-8?B?cjgzL2VYNWdncUJ1WU5zTEZJdWRDaFMyVWprWHlDM254ZmtGdHlSWDR2c1FE?=
 =?utf-8?B?K2hwNGhSa2UrQU5MRTMrNkFkM1dlQ3Y5b3ZGN1ZKRGJhM0ZqVzB3dy9KcE1N?=
 =?utf-8?B?d1BNNWpuQkJHNnhFM29vcSt3RndONGJuM1Bva2VDMTFlL2lZNGsyaVVILzFJ?=
 =?utf-8?B?SDdwMEVxSitvbWg2OGtFaVFMT3ZmRjQzQXZRT3NOT0dObVFYeHE2UGR6VlZ0?=
 =?utf-8?B?cXJzekFQYkFheXRPaWNyK2J6MCtnMHp3SUMzazNYSFlHR1cwRGFLWFhzTmFU?=
 =?utf-8?B?YldRcGRKWmkvdGQzKzJZRU5PTlhDL1dVNVcxU3pnYkV1eTFERTBkdHNpcEs5?=
 =?utf-8?B?UDMyZUVKaW11bU5PTlRkOWRjYXhJRWV4dGZDN0NhclZ4djdIbkZwWnFnU2VR?=
 =?utf-8?B?ZXp6ZHYxUFd3QjBUZ3dPWS81Y1czU3FTVm52RWRkRDVoRHpTYlY4MUtjN0hD?=
 =?utf-8?B?ZDRIVDczMEhuZUpJNTdTTU1jT0F3bzJNbE82bWJLdVVYbi9RKyszSjhYUGRp?=
 =?utf-8?B?V2pNUys1U0RwRFZaWStwb2xZaVkrb0x0NytOMlhXOGVPOE9FbC83eGtIWTEv?=
 =?utf-8?B?OWlnb1Q2a1JZZnNJdy9YZmQ1b1YxeDhJRTZ1bm1NaEI1WmptbUg1YVREQWxF?=
 =?utf-8?B?Y0VIWDJOMmJ0NzFuUXpZcVRFeFhxN1Fpdmh3anlpS2d2L1VkMlI1Vy8rc21V?=
 =?utf-8?B?MDhsRjlFOTdSTkx6NkdiM29vaU1NdHBXMHlaNFl6amMzQ1ZvSHhhdXdBL1V2?=
 =?utf-8?B?ODRENTlXTktQTkROaUtScHhSTWJ3R2pUK2tCOWllc2lCTzZxMytjZUgwcXlN?=
 =?utf-8?B?V0wwY29RQTE1L2ZXSTVWSGtXSkJGdExicXVhT0NxZmptNG9yTEpIK01PLzdU?=
 =?utf-8?B?dVRtamozOXhRNnNuWmRnNVl2MGJ0MFR4Tm9vT2JIcjJUUUtSelRmT1ZRbDA4?=
 =?utf-8?B?ZDFsTG01bS9sNnpRWFRXKy9jRjRLaEJXczV4UnNaeXNTdVl4SXUxbEkybFph?=
 =?utf-8?B?biswejM3ME1sT1VtTVZXcjFIelUyRWhuRW00SXJkSTBZVGlMc0owbHFIVFpv?=
 =?utf-8?B?YkJWN2RMaFMrYUVVR1NDTXRHYlU5SEUrbnFmczVvZFdpckZaQVFidHdoaGVE?=
 =?utf-8?B?dWRLQzVQNkQ1NzZnQjdDN3h0bDVOMGdsWHRGbzFpRzVnYzZOdDdUMDkvNWtI?=
 =?utf-8?B?a1VXSEwrZkpic3d0eEMxTGF1TEtXT1BYL20xZUROVExhWjN1TGQ1U0hwL1hN?=
 =?utf-8?B?dUluRE1TRGR0MWpHUlN1MUpqa0lsL2FERFUybGUvbDNPNXEwc3lzTCswc0Ji?=
 =?utf-8?B?SG4xZXhtc1Q1M21NcGtDRGwrbTg5SUplY3ZvbHhLaEQyZnpPZVBydWJycHBn?=
 =?utf-8?B?VmZ5K2RGSUZiWkdYSjdhbDBMWlhuLzY0SVliMlJQRTAydHdIaVlFTmw0MmhR?=
 =?utf-8?B?THhRMVZrZDl5L2NNekdvSzZUWStTSGYzd3FSM3VkaHcvdkt4aDFDd2poV3p5?=
 =?utf-8?Q?eyoIJImEV/HVo/pigRtddPvB+?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c298c82-4b67-4ec4-c063-08d9fee2d834
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2022 20:00:49.5379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bg+mmmHfl645wPm2lA01yMxbczCdtYBPoTohu2VNjfGz37LAZ3tSwEeP2QPhHIe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4361
X-Proofpoint-GUID: 68xglVUVg8Qn2c8bjSOYY5_c5EFEIfxf
X-Proofpoint-ORIG-GUID: 68xglVUVg8Qn2c8bjSOYY5_c5EFEIfxf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-05_08,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/4/22 11:16 AM, Hao Luo wrote:
> With the introduction of MEM_USER in
> 
>   commit c6f1bfe89ac9 ("bpf: reject program if a __user tagged memory accessed in kernel way")
> 
> PTR_TO_BTF_ID can be combined with a MEM_USER tag. Therefore, most
> likely, when we compare reg_type against PTR_TO_BTF_ID, we want to use
> the reg's base_type. Previously the check in check_mem_access() wants
> to say: if the reg is BTF_ID but not NULL, the execution flow falls
> into the 'then' branch. But now a reg of (BTF_ID | MEM_USER), which
> should go into the 'then' branch, goes into the 'else'.
> 
> The end results before and after this patch are the same: regs tagged
> with MEM_USER get rejected, but not in a way we intended. So fix the
> condition, the error message now is correct.
> 
> Before (log from commit 696c39011538):
> 
>    $ ./test_progs -v -n 22/3
>    ...
>    libbpf: prog 'test_user1': BPF program load failed: Permission denied
>    libbpf: prog 'test_user1': -- BEGIN PROG LOAD LOG --
>    R1 type=ctx expected=fp
>    0: R1=ctx(id=0,off=0,imm=0) R10=fp0
>    ; int BPF_PROG(test_user1, struct bpf_testmod_btf_type_tag_1 *arg)
>    0: (79) r1 = *(u64 *)(r1 +0)
>    func 'bpf_testmod_test_btf_type_tag_user_1' arg0 has btf_id 136561 type STRUCT 'bpf_testmod_btf_type_tag_1'
>    1: R1_w=user_ptr_bpf_testmod_btf_type_tag_1(id=0,off=0,imm=0)
>    ; g = arg->a;
>    1: (61) r1 = *(u32 *)(r1 +0)
>    R1 invalid mem access 'user_ptr_'
> 
> Now:
> 
>    libbpf: prog 'test_user1': BPF program load failed: Permission denied
>    libbpf: prog 'test_user1': -- BEGIN PROG LOAD LOG --
>    R1 type=ctx expected=fp
>    0: R1=ctx(id=0,off=0,imm=0) R10=fp0
>    ; int BPF_PROG(test_user1, struct bpf_testmod_btf_type_tag_1 *arg)
>    0: (79) r1 = *(u64 *)(r1 +0)
>    func 'bpf_testmod_test_btf_type_tag_user_1' arg0 has btf_id 104036 type STRUCT 'bpf_testmod_btf_type_tag_1'
>    1: R1_w=user_ptr_bpf_testmod_btf_type_tag_1(id=0,ref_obj_id=0,off=0,imm=0)
>    ; g = arg->a;
>    1: (61) r1 = *(u32 *)(r1 +0)
>    R1 is ptr_bpf_testmod_btf_type_tag_1 access user memory: off=0
> 
> Note the error message for the reason of rejection.
> 
> Fixes: c6f1bfe89ac9 ("bpf: reject program if a __user tagged memory accessed in kernel way")
> Cc: Yonghong Song <yhs@fb.com>
> Signed-off-by: Hao Luo <haoluo@google.com>

Thanks for the fix!

Acked-by: Yonghong Song <yhs@fb.com>
