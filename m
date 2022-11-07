Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A93620279
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 23:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiKGWp0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 17:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiKGWpZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 17:45:25 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29572BB3D
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 14:45:24 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7LKmeq022494;
        Mon, 7 Nov 2022 14:44:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=nyyvI3xxd7d3qOSRa2KRuD55iThFWUUH03NLvmP3LG8=;
 b=DX4LKGrN0+EOIu33+RPYZR4yI93KLsywV1+QoLClymPvItEYJCLZIGtAGRQ4VHTMdst4
 yv/nseorE8ARRWLY7Q2HIpNGCSHp2f4iPORXNPXzPBveE0WDFVhFkUsTzd9Z87ilP8xI
 r/8gYt+UlG638Ai7gf+g/oCptk7AeKsS+dq2BLyjvZ2XJAerBp+FUiCX71+W/JTVbiAw
 DIR2khxr7AJiCkPsNo45GsbzvRHXKp5v9APGv7OkenhtA5BEe4t4erSiJ/I3aLOZ48LA
 rYevUxJD4ieOTI+MARrcSoERLYic99LSZct787oR+Fssx343QofPhE1CNc4ROeCqT8/o zA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kq6kk2se1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 14:44:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RB8sKVRxVoSoMU0xg49wRI2xbSH/1QGg3fjAn6T/xQn//I+c+rjUzs6pMKjF+EGw7BwkcPUXgf5XXdQedneG7r5tw95zaeYYN0ongfhHgZAXIN0Dc5hLZZyPirZW2LDW8Z9rzh1/ZlweoosTD2TpS7qToV96FmOommtUbj6Q4E2+i91mRWAfoXAp9Enq/6X+I8ASVJtzWWfzIJtfZFxflVlPTDOBWqCbTPIbL2dmFtg1lgQi75+duDiyuIc+99WsjXFP82h/F6F0DPktgljFfBU6la/WWHQWUCGO3qApPyAG27tME4iAG1fzYtildLQ2wdWKVQWQRfDVuDEeyIkB/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyyvI3xxd7d3qOSRa2KRuD55iThFWUUH03NLvmP3LG8=;
 b=KVNvabI7USpUCHL6o9KQs4eMTcBDhGQttjEIYGgBCXYBRWBKKqrWktJH8aFRfSugSEMU+v1h4w7HzKGZZyjWjD3Fgi3b633dNT/joKzCuC7cJcGe6PHg+rjDnt/oOfMmGuh73IvF2cNkXYYS8CZ9aT+r78q+IrU/3mdKSqkjrYMMDeM4b7MHseHUjitBxP477HvL/9tcOJa8ybZHTqOrf4EuigpZfermYxS83s2J+jAZiqoata9SH6j8sDUvpgknuSh87Nmgyu7GB7b//OZuH4omJ61/3HSYD9Cg2+2JsAxgf01eu9kSsrgvgkpWVSBeYnFr4SGvTnynR5VlRcV1DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BY5PR15MB3603.namprd15.prod.outlook.com (2603:10b6:a03:1f7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Mon, 7 Nov
 2022 22:44:55 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 22:44:55 +0000
Message-ID: <d081c2ea-cdd4-d09b-4553-93ceafca80be@meta.com>
Date:   Mon, 7 Nov 2022 14:44:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf 3/3] selftests/bpf: Add test for cgroup iterator on a
 dead cgroup
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
        Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Tejun Heo <tj@kernel.org>, houtao1@huawei.com
References: <20221107074222.1323017-1-houtao@huaweicloud.com>
 <20221107074222.1323017-4-houtao@huaweicloud.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221107074222.1323017-4-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BY5PR15MB3603:EE_
X-MS-Office365-Filtering-Correlation-Id: fa5f2f19-0b98-4dba-f56e-08dac111b0d4
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KV7gcmhU8GJrz6bIP1CEsZkbxrWkrs86utCkX27UPdataepZTNWoY1CocR8NNECw4r8YaOJJQZsVcXTjb+I5i+81XGusIzDS1bNOtFQZfnBFUn9dyw9SBrR5W7u5voGjZBW3wZpLSm7iyRlfWU1auEXq3qf6X5yoI4VbIhYLOiOEU99UZrjo5A6inc0/6jwDMBIZvW9vrIUMtjA8qSGzeT/w6HmrRYrT4SNiUNlJx3fculGPkKWeK2ufW9r0TjrwLZaxUJxvztzsukvh0Bp8BevTgbVUK/t/PTQqVhzM7D7tq2vERb3+HFG7pp/Y6zWniwlL6hOg7zS+PZ72qrh/pEeG8rJ/VUUJ+/6daWjrShvr0bQVhUl0LCgHUB4rsrnP7Md5JtzNvFOXTXZ6tLb5lJ1+Lxa1e2qCF9hyjqBE9EwV5uJoUtuJVIdkokYtN67umqVT0Kzw1uXeaqmoSJZWalBw+zWVZmcg04hZ+GdbvHqRaPUDvIz6kv8Dtrzpdn3e2QM6tSRsgnhULvTDLsOEQ6nYEPQw41Hchu2Tp8hvwk25lcB4BSrwsFygvtDEvS1GcJhdQcYKT9H9aE77LBJB+q7vGC+NqJihFNTG5vErOONEmT2anAq3Mj+uLkr6rQMl4rzMWS8HRrJxXV0nUnJvsDxA9h4C4yHGmJQaapO1vJweFCPxzTGwe+ETVpxnSj9Cu5wAUmz1whubjSWmEyGQhPCedkt7dUkmQMF0jccRPd5TinLMAZuK2p1vanwN5CfmZAVjscEUZh/JBis7BYFGx7j9Hek33er3INmPQj0ugDw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199015)(86362001)(31696002)(38100700002)(8936002)(41300700001)(4326008)(5660300002)(8676002)(7416002)(316002)(110136005)(54906003)(6512007)(6666004)(66556008)(2906002)(186003)(66946007)(83380400001)(6486002)(66476007)(2616005)(478600001)(53546011)(6506007)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVpCV0dPWVg0dnhGMnBOeUY0QklHcGJPa1N0OHZwaFkxd2krWCswRmV6N1Fy?=
 =?utf-8?B?RmtyenRjODNJSHQ4dHZrSVdweXErZ0lMNnRPbS85OXc0S25NQ0dlQ09YdXly?=
 =?utf-8?B?Zm13M0FKZUhhUFJsUS9OaDlCK1EvbWFOS0J0S1V1VU5DTS9QRGtqTkFZd3hV?=
 =?utf-8?B?dEVKaVZoZFNmNUJhSkk0cTRBSUcxQmN6WFRMUm9nZlNGN1VORkgrbmNpUDJZ?=
 =?utf-8?B?QlNyYi9mSGhuWnVFN3FmeWE5S2J1UkJ1a1dMOVZqekdBQWJZM01DUFNUNUsr?=
 =?utf-8?B?enJlUE9Nb0o5cFN3aUMxNS85VFZpeHAzanNQWDFUa0NjaU5DLzhaRHRrNzg0?=
 =?utf-8?B?YTFCc2Q2K2E0TlRJT0JRbFhoNi9KVURFSnBVcjEvUEFPYW0xUzZDSG5FeE8r?=
 =?utf-8?B?a1pmbHEwd1BneEl6cG94aU4vMjRjbXhodmJ1SzRHeFFGdWVycDB2Vm55Rm9r?=
 =?utf-8?B?bmsrNW5jcm9pNHZ0aS94amR1VjgweGtKK1MxMVN5a0xRZHFYV1Z1SmQvM3lQ?=
 =?utf-8?B?WFdWRkRYZDJQNytuMGpuUXBndkVzcE03UjFpMVJtYldQUGVabkRMSk1kN0ZY?=
 =?utf-8?B?dVZUWC9WVXp3Y1pBN24zRU5aUStKeG1ZSHlQTHBSZ1dIUTRBTGtneXVPWUZ5?=
 =?utf-8?B?aVQ2dVF1RFhyVExGRWFnM3lJZEtOajcvUVEzdDFQUENqbWV1Qmt6VC9wbkIw?=
 =?utf-8?B?VWRXd0lEdXFpMUJHc1FwNXJSTjYrRTh0blB4VUQ3MTZLUmNVeDFxd1hNUldG?=
 =?utf-8?B?b2NFRytWVVFXKzBUbXlsK3lGM0x5MHR5WGNpaXJhaUN0U1Z1QnNJM0NlWWtS?=
 =?utf-8?B?YTVncGhLbFpCWGpUUjZjaURvNEppMEtiTEFIdElBd3ZJUzNmYkhZd0grYXBF?=
 =?utf-8?B?QkRpcVdSUjhUczVLcXJ0bmszbHljdVhQcWp0NTBWRDhQZFFsT21UMW1Qc0xF?=
 =?utf-8?B?Qy9Qa3RRd0paYlFqeHJ5OWFHZE9TMjYwR3RtTHdLMmZXdU5sUk1PK2lZeG9o?=
 =?utf-8?B?NkVVSGxYUGNFOUs4Ym0rTGlsY0cwU3JMcm1td1VCaE1aekViRVU1RXBXQXZJ?=
 =?utf-8?B?bGQxZ3NJR1llL0plVHJVeEJGZmw1Z0Q2d21scmIwWGJ6T09VMXZJZStuMVZ6?=
 =?utf-8?B?aURNNDhrSER1Tk8wMWFGaXB1V2hMTlB3bjlSdlNRL012MjhuakR1akYvNHFL?=
 =?utf-8?B?SXArSHRwdVFoOHQ1YTlLYXE1NmFsQTRSbjQ1TkVzRlVOT0YvNFlNNTF3QmFj?=
 =?utf-8?B?aUE2N0VHeEJoanhaRkRmMjVOdG9lbFl1K2cvVWRDQlZ1QUhZTTVLTkhXTTJN?=
 =?utf-8?B?b09yTTFuaTRIKzY5Qk1RYUl6SGlqc1htSTRLeHlRR2tJSXVoWW5neVF0MkIw?=
 =?utf-8?B?UlJQVDQzMy9WclFBbmpSaVZrbjZRUndlc3FrcURsY0Ztd3VlSFFELzZvU0Jw?=
 =?utf-8?B?Qy9EUnVUanR4bU1Ld0RQemUvcUtCUVF5ZmNydUI3UGJJejdRQTdQYm95eGRQ?=
 =?utf-8?B?TjNmZkhteGV3QWlUSjZIWHFxL1haNXVkYmVjS3p1VmwyUnY0Nlg5ZFA0Yk1l?=
 =?utf-8?B?K2Y3SG9xOGl4R0JRSmthWDlHZ2h1RDYyUHgvQWJER0IvQjdqdmplTHdDY1A5?=
 =?utf-8?B?QVkwMC9qd0VZazlDQWhRSzc5aCtjbG9xNWlWUkhmN0JtVy91U2wvMkozS3Ez?=
 =?utf-8?B?UW5oWWk0OUJJMXBScTJpSHZTNDZFYmVtZ05TYWVVWWFiWkZSZDFkNnR5UXI2?=
 =?utf-8?B?alZZTEF3UzR6WnY2VWlid0tvd1l4QW40U2VRNEppeEVjS3ZsQ1Nrc0lWeEU5?=
 =?utf-8?B?L25icXlyMEh2bE0zY1g4WTlzZ3JPam1kU2ppVkQ3WlFXdmJGNFgvVmVKMTlW?=
 =?utf-8?B?SG9RemRuMTFLSnpmcVFFcldwaXNtNlZFa3ZBZDN5NUsraFphVWZNUHJPS0pE?=
 =?utf-8?B?WWJiL21CcFgrN0h3ZW1qR3lCTGttNy81aVB1cnRwNWlGZFBMaFdaYzRKa3JN?=
 =?utf-8?B?MXc1ZGppakhYK1h4OWMyV0ovSXR3bWtHSEY4M3BjOE01c1dqOVZzVWZ2bHhs?=
 =?utf-8?B?a2JCajNyK3NocVRuQ0Q2eXJvd3RRY0NJRUhMZmNabm1kTTUxMUtYRXVTcmc0?=
 =?utf-8?B?RE82TyttR3pqWHJJeSswQnhqWXhyNlJzMWRBQ3ljak95Zy9PUlZCOGZxVFJL?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5f2f19-0b98-4dba-f56e-08dac111b0d4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 22:44:55.3416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hh6xyYDEbPOsuQF/hltnv81DzpHlo8b3zsw1pRFXpFvHZ7Uu058aiMp8NYLWhXxq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3603
X-Proofpoint-ORIG-GUID: drPAss5SGUUiKqYxiwUy6Mj3nJLY3TOf
X-Proofpoint-GUID: drPAss5SGUUiKqYxiwUy6Mj3nJLY3TOf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/6/22 11:42 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> The test closes both iterator link fd and cgroup fd, and removes the
> cgroup file to make a dead cgroup before reading cgroup iterator fd. It
> also uses kern_sync_rcu() and usleep() to wait for the release of
> start cgroup. If the start cgroup is not pinned by cgroup iterator,
> reading iterator fd will trigger use-after-free.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>

LGTM with a few nits below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   .../selftests/bpf/prog_tests/cgroup_iter.c    | 78 +++++++++++++++++++
>   1 file changed, 78 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
> index c4a2adb38da1..d64ed1cf1554 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
> @@ -189,6 +189,82 @@ static void test_walk_self_only(struct cgroup_iter *skel)
>   			      BPF_CGROUP_ITER_SELF_ONLY, "self_only");
>   }
>   
> +static void test_walk_dead_self_only(struct cgroup_iter *skel)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +	char expected_output[128], buf[128];
> +	const char *cgrp_name = "/dead";
> +	union bpf_iter_link_info linfo;
> +	int len, cgrp_fd, iter_fd;
> +	struct bpf_link *link;
> +	size_t left;
> +	char *p;
> +
> +	cgrp_fd = create_and_get_cgroup(cgrp_name);
> +	if (!ASSERT_GE(cgrp_fd, 0, "create cgrp"))
> +		return;
> +
> +	/* The cgroup is already dead during iteration, so it only has epilogue
> +	 * in the output.
> +	 */

Let us reword the comment like
	The cgroup will be dead during read() iteration, and it only has
	epilogue in the output.

> +	snprintf(expected_output, sizeof(expected_output), EPILOGUE);
> +
> +	memset(&linfo, 0, sizeof(linfo));
> +	linfo.cgroup.cgroup_fd = cgrp_fd;
> +	linfo.cgroup.order = BPF_CGROUP_ITER_SELF_ONLY;
> +	opts.link_info = &linfo;
> +	opts.link_info_len = sizeof(linfo);
> +
> +	link = bpf_program__attach_iter(skel->progs.cgroup_id_printer, &opts);
> +	if (!ASSERT_OK_PTR(link, "attach_iter"))
> +		goto close_cg;
> +
> +	iter_fd = bpf_iter_create(bpf_link__fd(link));
> +	if (!ASSERT_GE(iter_fd, 0, "iter_create"))
> +		goto free_link;
> +
> +	/* Close link fd and cgroup fd */
> +	bpf_link__destroy(link);
> +	link = NULL;
> +	close(cgrp_fd);
> +	cgrp_fd = -1;

We can remove 'link = NULL' and 'cgroup_fd = -1' and
add 'return' after 'close(iter_fd)', which seems better
to understand the code.

> +
> +	/* Remove cgroup to mark it as dead */
> +	remove_cgroup(cgrp_name);
> +
> +	/* Two kern_sync_rcu() and usleep() pair are used to wait for the
> +	 * releases of cgroup css, and the last kern_sync_rcu() and usleep()
> +	 * pair is used to wait for the free of cgroup itself.
> +	 */
> +	kern_sync_rcu();
> +	usleep(8000);
> +	kern_sync_rcu();
> +	usleep(8000);
> +	kern_sync_rcu();
> +	usleep(1000);
> +
> +	memset(buf, 0, sizeof(buf));
> +	left = ARRAY_SIZE(buf);
> +	p = buf;
> +	while ((len = read(iter_fd, p, left)) > 0) {
> +		p += len;
> +		left -= len;
> +	}
> +
> +	ASSERT_STREQ(buf, expected_output, "dead cgroup output");
> +
> +	/* read() after iter finishes should be ok. */
> +	if (len == 0)
> +		ASSERT_OK(read(iter_fd, buf, sizeof(buf)), "second_read");
> +
> +	close(iter_fd);
> +free_link:
> +	bpf_link__destroy(link);
> +close_cg:
> +	if (cgrp_fd >= 0)
> +		close(cgrp_fd);
> +}
> +
>   void test_cgroup_iter(void)
>   {
>   	struct cgroup_iter *skel = NULL;
> @@ -217,6 +293,8 @@ void test_cgroup_iter(void)
>   		test_early_termination(skel);
>   	if (test__start_subtest("cgroup_iter__self_only"))
>   		test_walk_self_only(skel);
> +	if (test__start_subtest("cgroup_iter_dead_self_only"))

Let us follow the convention in this file with
	cgroup_iter__dead_self_only

> +		test_walk_dead_self_only(skel);
>   out:
>   	cgroup_iter__destroy(skel);
>   	cleanup_cgroups();
