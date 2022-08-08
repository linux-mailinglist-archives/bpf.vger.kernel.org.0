Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE03058CB1B
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 17:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243618AbiHHPQT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 11:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243613AbiHHPQS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 11:16:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0CE261A
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 08:16:15 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 278ClLtJ028804;
        Mon, 8 Aug 2022 08:15:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=9Y+OFEbKQEU3B/mA/rSSfAnfdJqUApQFVC6UpzKzByc=;
 b=JwcPwjiCSFf3RUAD835x6SYjbJ/zfVOz2xsLwyPw7k3/y4xG3nNGmCUeBiV3FrpA/F1M
 p7sP2t0HXWlyOjkt0xbBM3c7lACskI6UqsNwSNWCc8vewkLva/n7cgJ/VauBXjUIH+o0
 urLNWqAPSBZIfQ4RoS6+vDn3X/caSHsbLMs= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hskt8tjk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 08:15:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pke1oqF9E9Z2ucPalSjupYP/3ymgTsgkLANBGZNKMubxckxvD2o2WoSzWlQQAXxQyK696hHU/hiQjKk5m+0JqvgWr9Ptg8Qs8dFtkwUHV2LWqGx7279AzOaXdjlRhUQvHSlALvzCodh9E3CBI7qF6lQnpOr/hrMQH20+tX/BU+P8fIQ7ipygKYf3OUfq4NbE2rksJDjuqWY11wjDa/UkuvAPU7OfvIGN3KT4i+mfX4or/BKDiaRPi7uvEtZkkXXm4fO4amlvg3eH8kITAkYCXz4EQJ24Tl4zeqMI8H06363SkJ+6gkZkCxPpP2GRgEsQfsMSrMHH4/KpyBLoOT5Ukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Y+OFEbKQEU3B/mA/rSSfAnfdJqUApQFVC6UpzKzByc=;
 b=H/Lpj9NZHFtIxAZkzOxlhO2+WK1WgnOApXjhNxlNNdoNjRwcqfcSZKH1jhzYljrpXQfjdmdIdsWb/Di2xfW08ZSpBcMeYfE0q6iPDa11EeAwoRmn2HOsqVBZDWA1OCmP0DNW/2gMHX5mZTxLL/sS/vXsojq6c7M83OKoAmyP7c1cVu9h6uC+C7/QGhy7vtPfHDj4U16URuGaYPIPQlEgUlODv92l6qXtKuZVgz4I/GXSFOpxAzdtpNNL01eLXMLwE6FqQZwAi8G6YgahPrZdDtO/kZxsG7zpcV5Er+p4ieuUyDw0FUJ/xs20fnsKqMUFbEqProj/5qfW1ZeWSyB0ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2144.namprd15.prod.outlook.com (2603:10b6:805:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 15:15:30 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55%3]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 15:15:30 +0000
Message-ID: <32e803c8-4042-2d01-0249-b6358c0fb627@fb.com>
Date:   Mon, 8 Aug 2022 08:15:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf 7/9] selftests/bpf: Add tests for reading a dangling
 map iter fd
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, houtao1@huawei.com
References: <20220806074019.2756957-1-houtao@huaweicloud.com>
 <20220806074019.2756957-8-houtao@huaweicloud.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220806074019.2756957-8-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0042.namprd08.prod.outlook.com
 (2603:10b6:a03:117::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7245574-111a-45b1-3e91-08da7950d509
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2144:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhqudqaMQvXiLaQnmL3q4UgGusDhs2LPhHdkdOrnDRHA50HZeKuWMec1qaWJDzYxqvfnUChME78Yw4ssNKsR8WUSrDkIKc402ByzxIkyvZR7dmGwWBUKCJrlVlDIwYkNGhjhgn+xfVu1ty/auqbxaCG22H9cEz2eYkhYsVZh16WSCd7ZOt3L2Q3J79iWLLyp055LxO9tqC6PDNPkPvSwxk+2jaLef7EBlx/EzUSrdpKrspIlb7cIJw/5IWz+unTkeX5V7EcIOd5ZzojtdGSoN4FTlOQZ799OBkZTmEuCARMFlY3bQZSsSHpNsI9Ef/37UuHs4ozcz4Q5FsstTdxtmRtfCGT440Vw3kt2b8rKSBfUse1bf66xjYV1UfFBUElRVLvN5SsaM2EUvpGdQMYupnytmSOzxEt+EfreeinpZWspqXRSFvC6s6AyUqmcCtt+E3+UCxQnlVtFLix5w8JX1bI/kQ1UynapoIluzbqgmpoO7q+m+KpsJ/TBzyGDf9GazQAdmJ8og1DSiIZZWv0hH1sJ8QwzzPsOFtRIa5TS9AiEduIZTG5EwT1tCYTvmTkOxpLoUbE7R5b9frzdZgEP8q0YBs6pnbqMQKDt9RE2s6HIqJ07i+YqPuYJmE9QF4TWRq4Fo7f2ZAKfObf6CEY6jaOSDHa0YdnttOR+j8/NtN1Or2Ox5jSxKPU9SbJgHRw5/eX+BVWquFYDCeAtxM5LVVPieWkv0+rY6xN1d9GTWE+eDz3YA+LyGD8n8wCYdst+DNDI3O6nz/oPdRgbr3FkqWuPj/Hx+ro+ujhZ0EaZQ6+WYIdzaFNJ8vtkob6DzV/7+MJK801Ia9zbCYieEJtcuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(6512007)(83380400001)(7416002)(2616005)(41300700001)(186003)(66946007)(66556008)(66476007)(54906003)(316002)(31686004)(36756003)(86362001)(31696002)(6486002)(53546011)(6506007)(478600001)(5660300002)(6666004)(38100700002)(2906002)(4326008)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEl1c1dPNXpBZnl6bFIyLzVlWEpySkJXSEJla0VlSHo5UTBURjdlejhkK2ZM?=
 =?utf-8?B?dmxQNXZZaENOTnBJSjFpaUpCcXJ5L3FmU0VLTW5IV1QyM01RQUMwSjJBdkRp?=
 =?utf-8?B?V1ZpVFBxTXFWT3pONmxOOXFvMzgrMU4wcm9tcFJ1MGF3ckxGSUc3bFRjQnpj?=
 =?utf-8?B?bFBIN2I4SmdES2IrWWFkdmFudTJrZHAwNGJWaDR4RU11Y3A4aGdCNDR3aHky?=
 =?utf-8?B?U0FSYXZ0d0RmQy9aNmVVRm1LMEZXb1RxOXpVSzhvQWN1SlNwOHFsT0JyaFdZ?=
 =?utf-8?B?TFUxb2dpYXA3RDVDcThTb1pvQzROeFdORHdUQ1pqYlhxRzRLU1UwZDczazhj?=
 =?utf-8?B?a2E4Z2R4UFdXaHRKdDN0YWZ2ZHJrYy9VWVFaMEM3bkZ0YWxmQ0c4NVI4MGlC?=
 =?utf-8?B?NmdkUmMxUjNWeHRoUXhtS0tBQ0Npb1liSElHVk5FZmduV1RFdCtTSU8wemhD?=
 =?utf-8?B?Q0hXVm1hcVc3ZDY3NDFjZ3Vzbkxwa0hYNnZxOVMyZmRRcFZ4c2l3VjJJYnBL?=
 =?utf-8?B?RzBidm5OSjN6RXBvK0xnemFTZTlkU1pTSDEwWUU3UTZCbC9McGxJUmd5OXBR?=
 =?utf-8?B?ZC9iMndMVm9aR2pqcWpaQjQ2OUF4V3pxRGJvaGlOaHZwQ1RIWVhqaWw1RTlT?=
 =?utf-8?B?NWJtclZRSXJMbkRnZy9rOVozcjBLZmJ2ZGNSMUM3Z084Nk9oUXZyYzBueEx3?=
 =?utf-8?B?eFhjcG5ITkFqaDNGOExRWEl1OFVCdlNsWWJvWjUzRW5hNklhNFlPdGUwUWhE?=
 =?utf-8?B?aVg2Qkc4SjU3MWRwZjlrZStyYTZDYldLcUNKaUFUWXZGdWJvY1BaQ2Q2VFhv?=
 =?utf-8?B?Yzd3a0tXaVg1TmhBcWU4am5GTVljaytkaEp0bGNwdTFXUUw4V0hlblhNVnZW?=
 =?utf-8?B?NWhnb3Y4U1QrRjVlR2o1Z3FXaGU2M2p1L1NYb0pvMHozVThTSVZRWGtqanY4?=
 =?utf-8?B?anB5MFBhRk5CVXhXRzlTcGJYdVhLeUhzMXFwYU9FMkMxN0N0T3pwOU5ZRzdn?=
 =?utf-8?B?UWRMWE8xaTdXUUZJd0xCQm1jbm02YnhMZDY0aU9IalVVckpLNUpGWUNXVURj?=
 =?utf-8?B?U2FMc1p5Q2hydFEzVXgybSsrekluc3JXdUVxRXFZZ3VORFhpcjFGTzZiM0w3?=
 =?utf-8?B?OGNhbXljZ25vNlVZOGZDeU9EOFdBNkQ0TStQU0Ewc2UvRUsrVEV4L3lRS3RG?=
 =?utf-8?B?SlVqVXJqSkRuMW42R3ZFaVBHSFA1dkJtRzQ4a2JIclJBcjdMUlBrR0FyMmw4?=
 =?utf-8?B?VGh1cHZncXc5eHBlbGVBOXlnUWFQN0hJV01QSGFuS1BjL3hJcjIwSnRxcVIz?=
 =?utf-8?B?aTg1ZDFXMW5talVmRTFnTm9LUnJTaS91aHJlK09sWERYSXgvT3UxWkh5RjJs?=
 =?utf-8?B?Qk9IRllqL0dpL2ZzR1ZPMWZWSzI5ZVM3eWt4MTdLUm0rYzFaa1M4c3BVdWRD?=
 =?utf-8?B?VlBIbGxWclJsZUhDTWFBZzNkU2FVZUNnZFlVbG56OXE0ZGRxS3VVNzhzeGNh?=
 =?utf-8?B?b0JoYXlGbHV3cUpicXlTSll4NUdjNjNiZHNXKytOS0ZMOFo3M0N0cHJvSlBP?=
 =?utf-8?B?SGxPZ3IweGV1b2pSVS9EK2VDUnZVQ2VmQlJLeHBFTUpJUW9xL0ZvQmpHVysr?=
 =?utf-8?B?RFFYZEZWVDFxTUZSc0VLMFV3SDg5Ymw3RWlmMU1LZVhqZVpEcGVISDl2YTJq?=
 =?utf-8?B?ZVlpcXZUUXhGYWtibW5PL2dXclQxR1VDa2hwUnpUZHBJNEVsQjZWSHBEV0Jz?=
 =?utf-8?B?UkxQSGRLSU12RmpSRDBmdXNDblNiZ0JtS0psK0xnR3phaVg5bTNoZUhUTkpN?=
 =?utf-8?B?cDJkbGttMnlkQ3JNcjBjVmgrdC81MENqQlFHbzhORHlFWnZCaGxtWU5aTFZM?=
 =?utf-8?B?UWdRWi84TjFNTG9IK0J5SXNXcEdwV05KdkNhNTVnak9pYTJQMVZ2Mk1Scjlt?=
 =?utf-8?B?cFVGc0RxTFBWVTZGTldHZlhaNHV5eVExelh0VWhtNDdiMzRIZlQ4VDVLdmVs?=
 =?utf-8?B?aDRncEZWRi9mejhvYXIrRXNsSkJ3cE5VNE9hWWFkQmtvS0pMTzBzSUo2YUFM?=
 =?utf-8?B?Tm1YQnFuZkFjNEdZanFMdkJyN3R0MzR1WWF3NUtjNHYyQTR3YjRGek9WL1R5?=
 =?utf-8?Q?cV4jDGyW4C/I6a0gdgNBZ0BrP?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7245574-111a-45b1-3e91-08da7950d509
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 15:15:30.6093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sEo/EsGtJI+lIKKC5m1R2Vtoa9NKawlTk1bpOvFzXU34zmIpXG9FaZRnWvWZ5fa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2144
X-Proofpoint-GUID: 8zM0CETQii3I8sm3S3ShlAHIE_nRPIqx
X-Proofpoint-ORIG-GUID: 8zM0CETQii3I8sm3S3ShlAHIE_nRPIqx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_10,2022-08-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/6/22 12:40 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> After closing both related link fd and map fd, reading the map
> iterator fd to ensure it is OK to do so.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>   .../selftests/bpf/prog_tests/bpf_iter.c       | 90 +++++++++++++++++++
>   1 file changed, 90 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index a33874b081b6..94c2c8df3fe4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -28,6 +28,7 @@
>   #include "bpf_iter_test_kern6.skel.h"
>   #include "bpf_iter_bpf_link.skel.h"
>   #include "bpf_iter_ksym.skel.h"
> +#include "bpf_iter_sockmap.skel.h"
>   
>   static int duration;
>   
> @@ -67,6 +68,48 @@ static void do_dummy_read(struct bpf_program *prog)
>   	bpf_link__destroy(link);
>   }
>   
> +static void do_read_map_iter_fd(struct bpf_object_skeleton **skel, struct bpf_program *prog,
> +				struct bpf_map *map)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +	union bpf_iter_link_info linfo;
> +	struct bpf_link *link;
> +	char buf[16] = {};
> +	int iter_fd, len;
> +
> +	memset(&linfo, 0, sizeof(linfo));
> +	linfo.map.map_fd = bpf_map__fd(map);
> +	opts.link_info = &linfo;
> +	opts.link_info_len = sizeof(linfo);
> +	link = bpf_program__attach_iter(prog, &opts);
> +	if (!ASSERT_OK_PTR(link, "attach_map_iter"))
> +		return;
> +
> +	iter_fd = bpf_iter_create(bpf_link__fd(link));
> +	if (!ASSERT_GE(iter_fd, 0, "create_map_iter")) {
> +		bpf_link__destroy(link);
> +		return;
> +	}
> +
> +	/* Close link and map fd prematurely */
> +	bpf_link__destroy(link);
> +	bpf_object__destroy_skeleton(*skel);
> +	*skel = NULL;
> +
> +	/* Let kworker to run first */

Which kworker?

> +	usleep(100);
> +	/* Sock map is freed after two synchronize_rcu() calls, so wait */
> +	kern_sync_rcu();
> +	kern_sync_rcu();

In btf_map_in_map.c, the comment mentions two kern_sync_rcu()
is needed for 5.8 and earlier kernel. Other cases in prog_tests/
directory only has one kern_sync_rcu(). Why we need two
kern_sync_rcu() for the current kernel?

> +
> +	/* Read after both map fd and link fd are closed */
> +	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
> +		;
> +	ASSERT_GE(len, 0, "read_iterator");
> +
> +	close(iter_fd);
> +}
> +
>   static int read_fd_into_buffer(int fd, char *buf, int size)
>   {
>   	int bufleft = size;
> @@ -827,6 +870,20 @@ static void test_bpf_array_map(void)
>   	bpf_iter_bpf_array_map__destroy(skel);
>   }
>   
> +static void test_bpf_array_map_iter_fd(void)
> +{
> +	struct bpf_iter_bpf_array_map *skel;
> +
> +	skel = bpf_iter_bpf_array_map__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_array_map__open_and_load"))
> +		return;
> +
> +	do_read_map_iter_fd(&skel->skeleton, skel->progs.dump_bpf_array_map,
> +			    skel->maps.arraymap1);
> +
> +	bpf_iter_bpf_array_map__destroy(skel);
> +}
> +
[...]
