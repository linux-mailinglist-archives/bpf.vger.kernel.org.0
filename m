Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0125A30E8
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 23:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbiHZVTx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 17:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHZVTw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 17:19:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5281625F1
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 14:19:51 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QJpS18012207;
        Fri, 26 Aug 2022 14:19:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=UXA0FJmenGrDMcELLg8taYlYDe4jx18gYL9ruKg2SE8=;
 b=G7yX4kVtwwKfWsI2V8TRq5njcu9E8ICwCAF8SEgCMISJiLNz5w9B0MXW/O0U9W7GLKxt
 /JSP5oHbTAdyP/QLLC+YWeADxxSjjKkYhk1qYTzLMiOkUcS2s+YdpjkiBDUL+nTmimgQ
 /FC/LHo8E6J6qTg/+sgItFX/XVg4uiv+hpA= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j74pn0hj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 14:19:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0Av5CaIMHwaAMMDfpyeOiIHhh3sl2K0+5jlFXnHjNkWrS6JRgSK07+0yuJeL5fiaVpfVxasjinKDPgQTvfRbiiU80/PhvrIBwdcy5izGAzae+q0tacugjw2mWY9vXNMMbYCwuexPnCQjoqBBeffIgekGqgYC/pcGz/c0jdk5O64hoNA0ryF6ZAh/L5n/HkIzA8Vr23bve6TzGJ4nFi9XDBVB5vT0/o7fJBOLhldm0wBRFi5t1vFaslHc/CDf4duYEtNi9nJDthrDNJEx5jLGUvsKvPBRoEXU97Pt6fy3mga9EDYkBq9TXzvWCWpA6E/l1pScXJJm3dBCoFgyQEp/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXA0FJmenGrDMcELLg8taYlYDe4jx18gYL9ruKg2SE8=;
 b=jFOeO3bZQJ0hxcYQZU8I+tFbCiwKiEYIb0ZbaH260dvseFk4JCVyMIoF/vwAmwC3yyRODImTSShiZv0PXGSMk5BeyNEcnMHOLLeX5f+648IIcQOqpLiF7hZxZRfbTG5DshHEXjh+8s54ZY7i5S43Z7aI/axuXs1XylCRCDg3xJLPN8qOJrH3KuO5Tn9iM60JYxCCJGUd2g6a6Dw0nDa0wK7ZLe2GbHvB8Gur/p6WDLnzFuyDw34S1Bqh+SqWcXAnp/TiBAogR51bWVgMb2m7L5sG4wpnf0pUQPqI9ABBUAoPpUhygbxm9EseL8L9tDQolZMt2rn0rHFXe0cnxq3T2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by BYAPR15MB2486.namprd15.prod.outlook.com (2603:10b6:a02:84::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 21:19:33 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::d4af:bf29:567:6cb3]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::d4af:bf29:567:6cb3%7]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 21:19:33 +0000
Message-ID: <a54bc903-ceef-75cb-24eb-272e55983ffd@fb.com>
Date:   Fri, 26 Aug 2022 14:19:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v7 4/5] selftests/bpf: Test parameterized task
 BPF iterators.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com
References: <20220826003712.2810158-1-kuifeng@fb.com>
 <20220826003712.2810158-5-kuifeng@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220826003712.2810158-5-kuifeng@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::6) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf173f2c-e1a2-4cc9-12b3-08da87a8abe7
X-MS-TrafficTypeDiagnostic: BYAPR15MB2486:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfAeED1xvGthZ01tcA1WlLfeN9tC8HMNcTQ+EW/oR+49eQUwNMZnZwkbfm4VSZ/VgS04hVwIJ51ijk4B+ZTA1nQaKAA0Kvx/eGKBdGqHefnHuVj3VybKmcn9+3wQdCt5+oG2JYp76NLa3JX05vaqp/McIvk4ovKtpa7SJv4Upz6eNNEx/OAOg90TXE7WTkQFkndyAZ04jaAoJPTgA1uXhdlYlq7Fbdj593n0y5X8gwJfsv4Q+l3xVFILZF+scA6wO6vjlN0dA3mqHjOw1hgtqd9Sa5l/KBbStkc1T97+NRjqQIFhjUkylhTho3zC0s9gTNuL6BQEcStBV9UXhnO4U7rcy2X3slz7XTj3gioDw6cY4fg1enXqhyt7LyHjACtmShfIzQM+YqohXFeC8+CYi6I5OxwVc5Ad12hYoCjokd72srzUCpsxzZl4nazcespwWKIYe3qZh8LOAcJCcOT+F83MTHMCMUm6u/LYS1+1Tkq2wEHC+Pdy8HwxM5BHX+ldqn2cMAmmlA4/kPKqooCI5bLi+Ha+sr20QSYuiioCkI1rrvr3vTq3JcDF4OtzHcVpvIKlC788PgXXJ1wHYGkzmpUrl37OKJEijTlVnMsRZ5DGDbHyeISwu9YGXITu4Si3/5534UVp49O7zT1laoknxYEMttuJbw8v1LkbCU0VWX3IeV1PxmJuV3TOE23iOgXmzj+cNKvl21tSNFSoylTYlOjHpxWd3m2WkKZzCnpdELQC4YkVyGHi0fgxttJnJ0oCTMASty/9irBYY8riTGFNmcNWXbNYSAQFmyX0MRocF7w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(186003)(6636002)(53546011)(2906002)(86362001)(6506007)(36756003)(31686004)(6512007)(316002)(5660300002)(66946007)(6486002)(478600001)(2616005)(66476007)(66556008)(41300700001)(83380400001)(8676002)(31696002)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzRjSENscEdSUzI1Y0lzUEU3dkN6cWpWUUJxTnB4OVB6VVNvbUFGM1UrK0FG?=
 =?utf-8?B?eFZNb1N2bW4xQkYreVZtNWZPL21YSmNXNnZpZDFZMndKWm9LTmNuRUs1dTlN?=
 =?utf-8?B?Q2FyVGtmSjVxb3JEYTNqcTYrRE1mZ0ZZUUVRaHAySGdTUjFjcXh2c3gyQWlQ?=
 =?utf-8?B?MUlLdmpDVXlsamNNbCtNc0JyM0w5ZmN3Tk1CemZZMm1mQ0drU0RRdFFmMUhh?=
 =?utf-8?B?MkcyOGdZUllrU0VTRS9mcWhqRjlXREhZVlZyMktBcGlIdDVDQWVpVTJ4Z1A2?=
 =?utf-8?B?bWVOdm1tL3VuaSsyTzlFVmxhNDJ1UHEzM3hFNHRjZHhJUFJjM2hnTWZhUUJn?=
 =?utf-8?B?T0tuQU5wSTVOVWxzL25ZQ1N3NVJUeU5CSnY4RS9kaVh6NloyMmU5aEg3Ly91?=
 =?utf-8?B?VU13STc0QXhPZGJzZlFaY2I5NjBlcFNtQzNuNHBoT0VpRVZvaUk0Q2J2RU9x?=
 =?utf-8?B?NjFuQWdpSk02aEhDLzNQQ1lGVjlqQm54d0I0eFg2Q0drenc3QUlLTTNVZmQ5?=
 =?utf-8?B?MlRrYTFGcXdvUFB3SUVNTEtIbXVtZ0djekVTdEszbm90WXNUOE52YXVYcGVR?=
 =?utf-8?B?L2dEcW02QlpBcWFzQ3dFQXlaYWJpK0FzZThlMi8wclkxY3JUb2ZoUUVwUlJF?=
 =?utf-8?B?SDZ6OVh1L2ZQT1JvSkVyYjhnSVlud3hVWmk0WDdwYklqNE94TUZzUWIzSDcz?=
 =?utf-8?B?bEFYc3RFWndrRFdVb2tQMENwL2lpeUx0bE5aSk41MjE2UWU0SE1wWXVaKzBN?=
 =?utf-8?B?N3lUMEpQdWh0THJRSDRNeGJla2ZJaEVWelplSnVqT0pKV1E2U1d6T1lnODla?=
 =?utf-8?B?WDhmQ0hXN1dEQmJubjNmbzM4bVRGN0txZ3hCVnpoY3dvaVNaT2Z1Y0xaTHZP?=
 =?utf-8?B?V3hVRmVReXV4dmNWVTdCQ3YrbGM3YTZNOEdEQnVnKy83eElDQStIeFk4bEN2?=
 =?utf-8?B?ODJVazJ6bVpZejhYYzQ0YXdmWXB1dExlT216TkR2dTBlVVBreEQwRjUwRWtw?=
 =?utf-8?B?OTFhaU9uOU9yMUs0ZEh3K1dDTFVTTTI1ejZiSUlGZzVaNE9tMTcydUZ4NzEw?=
 =?utf-8?B?Vit5N1g3YWZML0dRSXpBOW12Q3J2NUVLUzFKSmM2ekxuZ0krZHlydEdqQm1P?=
 =?utf-8?B?VEFyeUZPcmlnc0NGd2huMG5RL2M0d0ZUNEVoTGtOZHpaRkRHblpGc0htNVo0?=
 =?utf-8?B?bkJ4c01wMGhoTzlmTjcxTFNDZ0Zlbmo5MTFKcEVMU1VXazAxODZ4UktkNVVK?=
 =?utf-8?B?Rm1DamJkM29VdTRMMTNaemRjV0FtN0d5QXhWR0Z2OTA1TE5oSEF2bVhiWUYr?=
 =?utf-8?B?SkxkeUVZQlFJbU0wVzVFMkdaYnB4UDRWTEVLTG1FSHRNY25ER0grTjNDTzhI?=
 =?utf-8?B?NEg0L0FmNm9mRHd5UnZNK1NtMmp0ZDdzUlYxdEViN0FPMDNaQys3Y1FMdnNH?=
 =?utf-8?B?aG42R1Vmc2IwaHFQb3NtUTMzdjhrRVdwczNuZGI0c0VoS1Y5TndTekFVajc5?=
 =?utf-8?B?ZW9QVjZQcW9PNUgrMndVYXhvamoyMUNBSUZLZ3lTeWQyMDNFK0lDanhMZXMr?=
 =?utf-8?B?S2RIUFUwYURvQ0dYRm1GOVFUdk1JQUsrMVYwQnBTakhUZDErb2xOVXhQQTA4?=
 =?utf-8?B?UDhoZDZxTTQ1UlA0WEZQSHloeHl4MUsrNVZtcExwZTVZdjF5SWRtWXU2NkxG?=
 =?utf-8?B?Y3d1NVBwaW0rNFVGUDZ3cFVHTlZ0WVlON0pQOTh3aWk4NmRHSlp0dkNTUEdu?=
 =?utf-8?B?REtiYlZ2VWVKRU0rL05Qd3hlWXFlZ0FzZTVneUcrL0pBOWJUNXVYbnBIWWF0?=
 =?utf-8?B?aDVtMXR5bmEwRU5pcUVWQWpBWk5XTkp3bXNKVTk1dSsrUk9uYXFaaGJMN2lj?=
 =?utf-8?B?SmJQbkJVanNtdFJYZCtReWlyZ0V0VDFkUlNnQWc5d2wvbHdYWWM1QWE4S3pC?=
 =?utf-8?B?MjlsMDNHRytYTzVtK0Jla0hCNW1Ua25hTldPMklwSy81b2xjMDJORFFKTFkx?=
 =?utf-8?B?NXRIT2gwenk1MjlEcnJrYVZsVUZ1aUNheXR6NmNUcnRFLzNMMkZFOTRFdlhi?=
 =?utf-8?B?d1kwNDgycW93V01FQUNlWVFhRHgzYXkveSsrRDh1bVYyR3JZYVR4eVYvb2ND?=
 =?utf-8?B?bWZQekhzYXFKalBuY2JEQzJuMEZDMnN4SDlxQm9EYkkzdW1uNjhTWDN1ZjV4?=
 =?utf-8?B?ekE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf173f2c-e1a2-4cc9-12b3-08da87a8abe7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 21:19:33.5899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AirPssg0fKNryDiAq49QkwB8z0cXnUdowPZvN37yBXeQZudeV7vgIcNQ0d0IhE5k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2486
X-Proofpoint-ORIG-GUID: KrsSUapJ_9sRsoHGSUvTG3XiPwQp5Wbg
X-Proofpoint-GUID: KrsSUapJ_9sRsoHGSUvTG3XiPwQp5Wbg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_12,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/25/22 5:37 PM, Kui-Feng Lee wrote:
> Test iterators of vma, files, and tasks of tasks.
> 
> Ensure the API works appropriately to visit all tasks,
> tasks in a process, or a particular task.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>   .../selftests/bpf/prog_tests/bpf_iter.c       | 282 ++++++++++++++++--
>   .../selftests/bpf/prog_tests/btf_dump.c       |   2 +-
>   .../selftests/bpf/progs/bpf_iter_task.c       |   9 +
>   .../selftests/bpf/progs/bpf_iter_task_file.c  |   9 +-
>   .../selftests/bpf/progs/bpf_iter_task_vma.c   |   7 +-tf
>   .../selftests/bpf/progs/bpf_iter_vma_offset.c |  37 +++
>   6 files changed, 322 insertions(+), 24 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_vma_offset.c
> 
[...]
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> index a1bae92be1fc..343e4506c5dd 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> @@ -764,7 +764,7 @@ static void test_btf_dump_struct_data(struct btf *btf, struct btf_dump *d,
>   
>   	/* union with nested struct */
>   	TEST_BTF_DUMP_DATA(btf, d, "union", str, union bpf_iter_link_info, BTF_F_COMPACT,
> -			   "(union bpf_iter_link_info){.map = (struct){.map_fd = (__u32)1,},.cgroup = (struct){.order = (enum bpf_cgroup_iter_order)BPF_ITER_SELF_ONLY,.cgroup_fd = (__u32)1,},}",
> +			   "(union bpf_iter_link_info){.map = (struct){.map_fd = (__u32)1,},.cgroup = (struct){.order = (enum bpf_cgroup_iter_order)BPF_ITER_SELF_ONLY,.cgroup_fd = (__u32)1,},.task = (struct){.tid = (__u32)1,.pid = (__u32)1,},}",
>   			   { .cgroup = { .order = 1, .cgroup_fd = 1, }});

Looks like there is a merge conflict with the latest bpf. Please rebase 
and resubmit.

diff --cc tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 7b5bbe21b549,343e4506c5dd..000000000000
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@@ -764,7 -764,7 +764,11 @@@ static void test_btf_dump_struct_data(s

   	/* union with nested struct */
   	TEST_BTF_DUMP_DATA(btf, d, "union", str, union bpf_iter_link_info, 
BTF_F_COMPACT,
++<<<<<<< HEAD
  +			   "(union bpf_iter_link_info){.map = (struct){.map_fd = 
(__u32)1,},.cgroup = (struct){.order = (enum 
bpf_cgroup_iter_order)BPF_CGROUP_ITER_SELF_ONLY,.cgroup_fd = (__u32)1,},}",
++=======
+ 			   "(union bpf_iter_link_info){.map = (struct){.map_fd = 
(__u32)1,},.cgroup = (struct){.order = (enum 
bpf_cgroup_iter_order)BPF_ITER_SELF_ONLY,.cgroup_fd = (__u32)1,},.task = 
(struct){.tid = (__u32)1,.pid = (__u32)1,},}",
++>>>>>>> selftests/bpf: Test parameterized task BPF iterators.
   			   { .cgroup = { .order = 1, .cgroup_fd = 1, }});

>   
>   	/* struct skb with nested structs/unions; because type output is so
[...]
