Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58A658CB47
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 17:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243316AbiHHP2R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 11:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243708AbiHHP2Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 11:28:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57E31408C
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 08:28:15 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 278ClNJS018560;
        Mon, 8 Aug 2022 08:27:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=BWpM9sTAid+Tn1jX7K5vvEzkpPt//IibfmfALwytfZQ=;
 b=F0llPih1qFmhu7uE5ToQLHJwn0sdfxvY5D7ADNw7zSIkakYQDqn10ucoxZpGlWlYwq0x
 RjWpB/AKb8Cq1Op84jMrn8PRWOhlyukikdM70tnLtLfMW0EGzH59lZiL4v6+rkmc5uWb
 mkEd2rIOef/Peyx80ohIOoRjswd8bzpocY4= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hskywjpmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 08:27:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpBY6iabOPuZo+YX8rDsxaaxuweHjeV6s4IlqBSD/Eg09fHHCy5TTCJdt4fU2Tzpmq9HO8KcL+UTudSsTn3OHF8UoZFaDdqzNvS5RHbRVtJSgw4sqB/KQreLNEwifpZZPQ5b2u2apMdgayqnBToKclljUxa2lFODdqvWVZ9CG1LWyvzA/pkknd8UjWeDhObxObmSBxJF6DXvLnePZPbUt26fhQ6w5WE4rrKsS3Ar245O1Uy5PF390q9fTdJz+979dE0gA8dSe+AKWXORuq6VsAblE/2pFoU6Ncolip3Yh5mMt0K1HwBfJMpHpp7z99EMBE8Gca5fVIn1MXH/MdjEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWpM9sTAid+Tn1jX7K5vvEzkpPt//IibfmfALwytfZQ=;
 b=R/3XZttnsprPNdc7NNIArT99Zyb4A5w1Ph/g1RwVTaXa/dsSJsTmKOcxcYifyhY4Nh54M+ZeNsBDNr/LGG6EXGFPIE6A9F2V41qDIRf/ZTiLX71rOcVvGpn1Jb8Ki4g58ffCXp0jdBfmgnlAljwUyiXWLiYJyv9DHMOXTF6SBfmsN2hJLfOE5+/dfJfkmovhQZY3SyBB/MUf0xCp+tIRd11iW4psd2iKdfC+v3r2UizqKaBfsweLwbPnx2/OSWda0WH8iEP73Iz7owTi3xkOLnVZsX8IMP9zHzaaLX65FZMfFuPJDW818nAz4aAW2D1q6lgK6y+K3sP3uF64F+SSqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO1PR15MB5049.namprd15.prod.outlook.com (2603:10b6:303:e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 15:27:40 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55%3]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 15:27:40 +0000
Message-ID: <eb3836ee-2830-83a9-2081-4527fa4141d0@fb.com>
Date:   Mon, 8 Aug 2022 08:27:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf 8/9] selftests/bpf: Add write tests for sk storage map
 iterator
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
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20220806074019.2756957-1-houtao@huaweicloud.com>
 <20220806074019.2756957-9-houtao@huaweicloud.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220806074019.2756957-9-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0285.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cd8c162-e9f6-4f84-f4e4-08da795287bf
X-MS-TrafficTypeDiagnostic: CO1PR15MB5049:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7oWfwDa3sGLNGRzELFqplziqnb4xhcMcXx/KMchy+7NrlZ/sMpt06ef1XNgLPS7rvvieHiP7KOvAx1oZeWSRaAxZeCPnetjaD8NG9kBvjNApq3ehNQ8wVze9SIm76Q3uwBgcmC71cK5Q0Qt4XZxywC8dQrEiIg7+7/YtjtK3NitWp0q2zwx3DPqsqK9DWqF/xiY2TUQNLxROaFfqVUj/p2h4gRpVYX+vKKnRJdSsneAeW901nbdl02yQWflL8gFY0w8xOJDhPZt/jO2ZnftvF/REm1+AYeezWJk0m3+N5BtwMl0mFP32d7xjwyf+2DmI1IHFAgTVuJ9cWDsMztEAeQOecgQR1Z6q6OKUXKNPH6UV93z8qDDf21H9H3TN9CXIgL1jAX+FvzrZTGYitwFn6z/IU0tEyRgojeocMYRQ7boyUCPd8kt5QN+o+rl/cZMUdlNe3K/FKQ4HVLqoxTFfONJY/pL8q35k5b/q6+qI2IZY5oycwqNXH3qMo7qGboHh98mGheuqTBdbRswh7UJepGGMNrHEd2eFFvFoOMsilqB6mFk/V0VUiNPDkyHYMAj++KaxHbLrPq+x5cDWfqzTTRHUYV8JnQxDWNfui29Ppyxn09m2oU7bhxLBYQFdo+iPlJX30uDNqxbtvBj7UQoUqYKbGxuxWoBd+WXrmjdhq0PqdgNCt/PwvmzB0UBBZAvpKCCDgBXFKkR4ov7BlgiLxQFgvCpgbhQIFd+LqHoUfbtu4n+WwStcA/TRAlwapyjcChA8KhdR5GbQGy5M8YI0x0kXganGRWYGPnUzQsQRtlHAeiqqDoUh57Vk1cf507BpIdqOAiTVMzb1rHRMCWBMzN8/5HKFYsYPxaK4OYPtgJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(38100700002)(186003)(36756003)(31686004)(54906003)(316002)(83380400001)(2616005)(6486002)(8936002)(7416002)(4326008)(5660300002)(8676002)(478600001)(53546011)(2906002)(31696002)(66556008)(66476007)(6506007)(86362001)(66946007)(6512007)(41300700001)(6666004)(461764006)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFZPcFBaQng5UGRjSXN1QU5EMHZDZlRYbzZGemkwNy9YeWNJbkQvMlRuZGZZ?=
 =?utf-8?B?WG1TL2RKY2hvRlYvRUZqUVc2UWJ6aHQ4Y2NSSnZiR1pZNDhJQ0xsUlNRS0VR?=
 =?utf-8?B?SWQ2Nk5YYmx4S2VHbkZ2ekM3WlE1OG9RWE1VZmxZdEx4NGFwdU1jcUZ5ejVp?=
 =?utf-8?B?d2NLUlhVcUZMTDZZdDFyOXVKcUZ6RVhmSE10TUFZNE9oWm0vL0JSdkhQTHQy?=
 =?utf-8?B?NHVCaFl0SEhxWVlqZnloR0loTXRTTUxZMngxd1pOK1RlL0dWejMwMWROL1p0?=
 =?utf-8?B?SXZNMC8yMmpXY3pHK2ZSMlB5OXhzL05sbkZWYTZNbjJZOWZpTXVUS1pNSWNM?=
 =?utf-8?B?YmhtOXU0bGRtZkhqZ3NSUnFHeVBnbkUxcUtETFplMldsaTNqb1hWK3lQS1lO?=
 =?utf-8?B?dU9sU3k2N2x3Q1M5c1gvUUxHaml5bVlnd0FLeUxSY01QYTJVL0JJOUx1YWxm?=
 =?utf-8?B?WHJSMDJ4UDlLVnV2NWsyc2pjVjVlZ29vV3hnQmtDaEU5UHM5MVFjNUpBODRH?=
 =?utf-8?B?NFhyU1ozRWlPK1ZTbm8yQ3FRSEdpMXBTNXVRZ0lEa3p4R3cxbTR2RjJETlVB?=
 =?utf-8?B?UmN4cjhVSzJFZ24xbS9jWHZVOFFPQ1ZCTU1SSXV5VUJad2dPOG42SEt6Z1JU?=
 =?utf-8?B?L3JkWkZtNVBxbXYyakxONm9QTms1Y1ZhZXFSN3paaWNRMExnN0xUc0IxdlVr?=
 =?utf-8?B?ay9rdkRsTmVsT0JCbS9YWGFaSDBoNlFyNDNTeEJhZy8rWk1EamRyZzBYSjdI?=
 =?utf-8?B?dzRRc2xEUW1nZW9tVStHT1lLWUVQQnlLRFFwRzJ1YlllbXB0b3lSUTNWM3h1?=
 =?utf-8?B?SGZXOUlFOUpnd0t0aHhyKzJIaTkzOCs3RjA4SnFMYkVvM1VtRS9TVFQzMmpI?=
 =?utf-8?B?ajBzL1JpOU03Skk3WTNIdDUyU0RzMWNwYWZGMkkxSzRkd0VLUEx4bE1pUGFl?=
 =?utf-8?B?ZmlOQmpqWUlVNmVWRnF3R0NvalZ6TFZuems1TGpaV2JLbUNBREVXUi9mb3Bx?=
 =?utf-8?B?UnFmZzhOMk1vdGZzSk45TW9xbHN0K24zZ1h1NkdLRjl2NGgrMUs0aVVxNmtw?=
 =?utf-8?B?Nnl4WEY3RjRFUW5iQ3Arc2sybGs0NEdVWE1peUlvR0dLUE5uMlhnbjRCSTJU?=
 =?utf-8?B?SFJsNzNWbVdzT1BYU21PZmh5Q3RUbitoa1ZONFBqU0wxREtxMW53bkNvckZG?=
 =?utf-8?B?aXJXcGx4WE1nVEhsNnM0Y01PUlNYcWp2dGg3WjdidksvcnMzaUt5SE9VY0Ix?=
 =?utf-8?B?VXZKeTR1SnppZVEvaEJ5U3BmVk9sYW0wS2JyVEZQNmRJTWtFK0t0WjhZL2Nw?=
 =?utf-8?B?Nk1KTnB0RWhaUlVVNnlSNVUvWEprbDFUVnJyc3VYaU9xVCtPT3dId1hmbDVq?=
 =?utf-8?B?WTJPNFBkRGVrRFFhTHdTUndnYlcvRmxBZ05OZlh3RW56M3ZqajJlcjladTIx?=
 =?utf-8?B?cHRTVUc3K3NXZHQ2aEJHeHNBaXU4N1AybWhXRGJJY3NTMGFNNXBSV04yUVNH?=
 =?utf-8?B?bkpIbkZUcnJqQzUvSzM2aS90UnIwZkNZY0RmVEpGSXdQQ0ovQjNxSTRvTWIx?=
 =?utf-8?B?UVZsYWZzRzBpaG9LbWhNci9tU1hMa2QzcWl2V3lxcGtsMjZxcjJOUUZpOFc0?=
 =?utf-8?B?UGRZekJmeEdHaEdjbnpxSVVuTkdDVllaY2lqQzVoTW1yT0trR29ZVWpCbHlh?=
 =?utf-8?B?NWVMUGg4dUdtT05CM1JvNFRZcWt1VkNMNWJlVTJ0a2VyWjZSaFhkTm1Da0J0?=
 =?utf-8?B?cFUvQUpiWStlbUpiVitkSlJYZlJmVnVENkRibVdWZmVzN2lqeWtoS0diVDIv?=
 =?utf-8?B?NlEyeWxPblk3ZE9ZTkFWT09QdzFuSHd6Y0pCN1I1bTdJaXE0VFNMNGl6dlBH?=
 =?utf-8?B?YnRJa2tiOWN5Wkc3R1F3RklvZHBKbU5OU3QxSWZFYXFOa2Yydzl6bEs1OEZK?=
 =?utf-8?B?czdHaWxSMDVFZUJob0s4T2tUT3FSLzJCWXVJUmM5T2QrZDVnNVNxeUt1OVlv?=
 =?utf-8?B?YkZ0UitSdFhCd3NHM1d2clVqMHdNZThLRlovRlUwZi9qZXY1WjdBRHFobTlJ?=
 =?utf-8?B?MlVOTnk2VjJoQkZpUWtySzdwYkkySG1oUnJzU2ZDQ3lkOEw0c3MxdVZJZVVi?=
 =?utf-8?B?cTdCeURsMDd2ZHRVL2pISzdURjVJUDhWQ2RJNWFCUjNtOW1OeWsrRVdBMUNn?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd8c162-e9f6-4f84-f4e4-08da795287bf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 15:27:40.0317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDHNHSlJu6BQrNhdRwRapyZ0f+LfCA98irQ5/FBGIYa/SPL5xIe/2ruQzcZ1vOSy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB5049
X-Proofpoint-GUID: YJnF4Foctxhap-GEh3-y8Vlw3-NOyPv8
X-Proofpoint-ORIG-GUID: YJnF4Foctxhap-GEh3-y8Vlw3-NOyPv8
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
> Add test to validate the overwrite of sock storage map value in map
> iterator and another one to ensure out-of-bound value writing is
> rejected.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>

One nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   .../selftests/bpf/prog_tests/bpf_iter.c       | 20 +++++++++++++++++--
>   .../bpf/progs/bpf_iter_bpf_sk_storage_map.c   | 20 ++++++++++++++++++-
>   2 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index 94c2c8df3fe4..f75308d75570 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -1074,7 +1074,7 @@ static void test_bpf_sk_stoarge_map_iter_fd(void)
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_sk_storage_map__open_and_load"))
>   		return;
>   
> -	do_read_map_iter_fd(&skel->skeleton, skel->progs.dump_bpf_sk_storage_map,
> +	do_read_map_iter_fd(&skel->skeleton, skel->progs.rw_bpf_sk_storage_map,
>   			    skel->maps.sk_stg_map);
>   
>   	bpf_iter_bpf_sk_storage_map__destroy(skel);
> @@ -1115,7 +1115,15 @@ static void test_bpf_sk_storage_map(void)
>   	linfo.map.map_fd = map_fd;
>   	opts.link_info = &linfo;
>   	opts.link_info_len = sizeof(linfo);
> -	link = bpf_program__attach_iter(skel->progs.dump_bpf_sk_storage_map, &opts);
> +	link = bpf_program__attach_iter(skel->progs.oob_write_bpf_sk_storage_map, &opts);
> +	err = libbpf_get_error(link);
> +	if (!ASSERT_EQ(err, -EACCES, "attach_oob_write_iter")) {
> +		if (!err)
> +			bpf_link__destroy(link);
> +		goto out;
> +	}
> +
> +	link = bpf_program__attach_iter(skel->progs.rw_bpf_sk_storage_map, &opts);
>   	if (!ASSERT_OK_PTR(link, "attach_iter"))
>   		goto out;
>   
> @@ -1123,6 +1131,7 @@ static void test_bpf_sk_storage_map(void)
>   	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
>   		goto free_link;
>   
> +	skel->bss->to_add_val = time(NULL);
>   	/* do some tests */
>   	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
>   		;
> @@ -1136,6 +1145,13 @@ static void test_bpf_sk_storage_map(void)
>   	if (!ASSERT_EQ(skel->bss->val_sum, expected_val, "val_sum"))
>   		goto close_iter;
>   
> +	for (i = 0; i < num_sockets; i++) {
> +		err = bpf_map_lookup_elem(map_fd, &sock_fd[i], &val);
> +		if (!ASSERT_OK(err, "map_lookup") ||
> +		    !ASSERT_EQ(val, i + 1 + skel->bss->to_add_val, "check_map_value"))
> +			break;
> +	}
> +
>   close_iter:
>   	close(iter_fd);
>   free_link:
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_map.c
> index 6b70ccaba301..6a82f8b0c0fa 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_map.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_map.c
> @@ -16,9 +16,10 @@ struct {
>   
>   __u32 val_sum = 0;
>   __u32 ipv6_sk_count = 0;
> +__u32 to_add_val = 0;
>   
>   SEC("iter/bpf_sk_storage_map")
> -int dump_bpf_sk_storage_map(struct bpf_iter__bpf_sk_storage_map *ctx)
> +int rw_bpf_sk_storage_map(struct bpf_iter__bpf_sk_storage_map *ctx)
>   {
>   	struct sock *sk = ctx->sk;
>   	__u32 *val = ctx->value;
> @@ -30,5 +31,22 @@ int dump_bpf_sk_storage_map(struct bpf_iter__bpf_sk_storage_map *ctx)
>   		ipv6_sk_count++;
>   
>   	val_sum += *val;
> +
> +	*val += to_add_val;
> +
> +	return 0;
> +}
> +
> +SEC("iter/bpf_sk_storage_map")
> +int oob_write_bpf_sk_storage_map(struct bpf_iter__bpf_sk_storage_map *ctx)
> +{
> +	struct sock *sk = ctx->sk;
> +	__u32 *val = ctx->value;
> +
> +	if (sk == (void *)0 || val == (void *)0)

Newer bpf_helpers.h provides NULL for (void *)0, you can use NULL now.

> +		return 0;
> +
> +	*(val + 1) = 0xdeadbeef;
> +
>   	return 0;
>   }
