Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF5D57581C
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 01:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiGNXmz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 19:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbiGNXmz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 19:42:55 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125D01FCDC
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 16:42:52 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ENcckN010064;
        Thu, 14 Jul 2022 16:42:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5VJYkOQLKdGAqXA9KlaX7kNcwNqGYAF+Dw7Z3iiaQzM=;
 b=iorfZGqsLd8kaiyG0/uc8Om6FJ7WukfGHPh9r60CwNLVpAKyAMVGIbfqUhEpkzobsHi+
 2es1VZNZOjQtS8Yw8OfZpEd8aXGVnLkZnYncXGk7Si58mT4/iJDx68s/fxfDZ3QpuPj7
 yx86mXEMGJkvrycSdw+70Nv1WR1+UII21DQ= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hae0w5q7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 16:42:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2IqqHd54v12q4cvShsQmLeeIKoO1ouv2xnWQJoQxVUtRRetQF+dgfg2HjxjU7EkaxArER3ZW2uyevoVJ7XbWk9FqdNisba6XqdQsgt8QTpf6/wY/t04I/GxdGjwy1KfmhEIMS9EusrIiYo0iQoa9LUjknt141Pbdr+YE9IIbICv7woElcyZ9ly5UHWwHPgg8rT7V/9UWp9vzjRGqIWmmhIelrTBCIeAgQuWzIBRcORmcb2V7b0UGPOe7acv/Xq0q5ZLUeqNuO/+7ie5HW893W/KH8xBnCdVBOC+tALlF2ESdBesioCfyrShcwkeF21rjMAC2pF/CHHDV7BJh7DbOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VJYkOQLKdGAqXA9KlaX7kNcwNqGYAF+Dw7Z3iiaQzM=;
 b=Q7BnCPSSctTrTCza74bJIz8CYGWi7tk+bu5U3JZs/pa8b6JJEQvzmBrTMnyB4LX4IGP7KyN+WQBMQhSHDx6yrNKZ06pt8NG0aXHtTxAi/YM5a+MWVIMMqrD9nIQ2J/MchI1MZHiCmI2/ay1AOFhMZAB3PYkVj31kysYXULBfMZkpsGR9cGeC4ldmbTUUBSnm7Q5fLzjHJgLvkISmZNv6PDzsEworYnCLQsD0x5bMaVcgWd+Q8SwA5f/2SZkkugQrGNCOkJFuwvxy5oKlABVFV6DcJ+c4R7nPU7+po/U5ldL+wYpgaJE2fKw0DN/7vXZkq1UitngEnfBT8VO1yMQV0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4157.namprd15.prod.outlook.com (2603:10b6:806:10c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 23:42:34 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 23:42:34 +0000
Message-ID: <7f5f82e4-b348-0f43-f159-8d1160afacc0@fb.com>
Date:   Thu, 14 Jul 2022 16:42:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next] bpf: Fix subprog names in stack traces.
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        kafai@fb.com, bpf@vger.kernel.org, kernel-team@fb.com
References: <20220714211637.17150-1-alexei.starovoitov@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220714211637.17150-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0103.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::44) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3de85905-8cb9-4228-7c3d-08da65f28680
X-MS-TrafficTypeDiagnostic: SN7PR15MB4157:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0S93ZD99TA+CLOnYVm9oildcgsZvFLtMyjwTtjRRsTc2YxEAYFci/YUs5XD4ytetg1rGDCzmkC4crS9lkJyo6Q9HUWG6UQWR0fb4e/WnYidztjWn0oZUDGK9FkEpJZWM62ZFIN8SpnfZgWyK9dafSuluQXT2aYojXeiwM5SdhVPKZxBWrBvMa5vzl/Wiu5jY/2DlZlxD3jkjFP6QvnPZVdcuW5h/PLBleJpyFiNeuonlfPciWp9bkO4Vya7lcB8BZIA2LYYEyROIZNG0F9CmusU7c/25cDfAZ9N/osuxC00NrlpdErplLapBPIn9gkhDnX84t4t807fDUQuHImcjk4RPrjQs6tDxvaMkk/OOtA2r5qcPePq/Qn+IrtXE4WSz53EnoCe2dIS1LDQVuxCDoEXSq1u1c59Epkfsma2CT5NAxTBmNDEgf2Xd5tag0K5XU4BK1dOaGAlD5qKcOQT8dqk3d9GKEOYsb60C09UkD/xRkekIQqkD45ebhb3BmwvbTUrvmHG183iPY2+8m7d7MHcCpvLZNXXZCEZg6jkmCf99Ozcaw7DQttsscAcw0wr66RUULGRXwE52UHSB2uqnfsH/0nbxg1eHB0VBX90JjPU7/zxsXlQS91w53XEUzk2zIFjjwHn6Mp4r4OhsV+E37oB/gThyARs0IcJNy7YLAVnWvVg9meTJcU6OQ+C8Rjv2KMrCLzUetOgJCXCOfxq1eZTf5kwZYvImnhrHkufF+7BzbetMB4gkUQlpFwGtnemEEjfjUbkQhFam0OwEos6gdyuO+pw7vK2Vma6vubMUvJVuep7ehjfG6OlvYrpSkq04Gvr0L0DEF5gIe1ylPC3kRCJXNh2YIf1Bm/pDF2B6c8c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(186003)(38100700002)(2616005)(66556008)(66946007)(4326008)(8676002)(316002)(31686004)(36756003)(8936002)(5660300002)(6486002)(2906002)(86362001)(6512007)(53546011)(6506007)(31696002)(4744005)(478600001)(66476007)(6666004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzZOamI3dnEzWWRMZWxIcGhDWU5yaHpKL2lOM21FMEdxY251UDQrWVlvWlpR?=
 =?utf-8?B?YWJLN3BlazFaeTNDcG1zaVRCZkdjV1dMYmNLRUoreHF6Y1BFZENVbEVLeUJs?=
 =?utf-8?B?SnhwQmpqeEdmNU1nNFJ5a0JQb0Jvd3VzZFZlbTAvZ0IyenFpczgxd0ZNNUp5?=
 =?utf-8?B?NUJmR2g4dVVCaGxGSjhKSVA3QVlVaXpIc0RVYkZiYjdaWDJ6OU1iUFNUYjJz?=
 =?utf-8?B?RWRJeUgvMGo1MlUweWVEbjNSWkV1bTJIb2U4T3dVZmNxUDNNR0wyZXJVL3hT?=
 =?utf-8?B?Z1hNNjdGY3p4WUtLRGhrcVhtN2xSb3l1S0F0bC9yWmRDN2NNT3BvVFBXeFJr?=
 =?utf-8?B?YjlsZXY1RytocTQxc0hITnpIMkhRb0l6RGRBZG8wTUE4ZW1jOVk5Tk5NZTNx?=
 =?utf-8?B?c2JMbE42TVlYNUdiRlJsZWNUZ2xiejVTaUlJZ25HNW42TVhiajQ3NjYzeU03?=
 =?utf-8?B?VDlDbUlERmwvbVVTTFRwWllHZDRKeXNNRndsaTZDc2Zzbmh2SFdDM1VodU1k?=
 =?utf-8?B?Z2VoR1JsMFNEWmtWMWkydE1WU05NYThNejRtOS9ldFc4bEpvRjRuVkZJSDNs?=
 =?utf-8?B?UkIzUHZNVXJrQ0RGbDNMZmdqeGVYYmJtVFJGQXRBNWJnYWpSVWVQT0tSTERF?=
 =?utf-8?B?U09nZUxZT2dDUUpzWVhQK2o0eW96K3V6czdCMVhORElkTTRIVEIzV1BhcnIy?=
 =?utf-8?B?bi9iUHF3TXJTT2phMjU3bHNML3lEWHpteHoxRTZFYjJ4bk0zYkl3OEhZbFNh?=
 =?utf-8?B?Ti9YdTFnLytGWXJLQWw5YlBadkgzOXBEc0wzV3BsdDFqcFlCa0E5U3ZCclhy?=
 =?utf-8?B?dVRQUlJrZTBuQ282MWRTTm1ZdUJueXZSaHQvZ1V5OWtKeGQrWGsycnAxZ0RS?=
 =?utf-8?B?dElSUUNDV3FVZlFhanpiZksxbkVWTk5tM2NJK1AydmNvMUVUeFU4bWZaeEYx?=
 =?utf-8?B?dS9xWW5TWmU4bnNLTytCSWgvMDFnNnhJb0pmc3ZrRzFhaDZ2WmZHbWNGTjNC?=
 =?utf-8?B?eHBuVU9PZ0R1LzRKV2FiUVhIMUY0ckZ0akkvbFVCd2E2eUJPMEhTT0pNWkty?=
 =?utf-8?B?dG9nL3NyTFYrb05TWVd6NDJzSmdldmNoTUliQzVDK3FYYXlGcEFMd3F6M29G?=
 =?utf-8?B?Y1BkMFFXSXpRMWFGaGhoKytuMlNNWVJlaUJMc0Ric0V6V09EWXpLQ1pDK2dD?=
 =?utf-8?B?YytvR3dkNFBCcHhVZTBkWkkzQThOQzlqaFA5NklpYjJSdHFCMWlHZjNpaUNW?=
 =?utf-8?B?SitpaE53c3BBdjRVUGtKcjRjMFlTRExDUHhpN0svakR2SWdFRVc4eXBhVnIv?=
 =?utf-8?B?SE1NNTJBUFpNekR2aGRqVGs1emQ2WFhURTlaenh4ejM3ZmlvQk1lbEdiYUM2?=
 =?utf-8?B?amJhaW1WNDlLRXlobFlOb0pSVHluOURtZktJUW9EWC91ZlhMcnFFTWZGd1kx?=
 =?utf-8?B?WHRpZjhmN0VNakkxcmN6U1pSNW5RZkhZeTBjbDdXNko4d3JLenNWcjZSSHNj?=
 =?utf-8?B?dWRPcENGWkU0Qk5qM2NDWFp6NWdTNnBuQTBmTjBwWXhGTnJzN2M4dHk5a2RR?=
 =?utf-8?B?dEpnRExpTWd1NVN4TDFYbDNJTEpwN1QrWGp3QkFuUE5BdUVxRkJ2YkNGbEoy?=
 =?utf-8?B?T05nakI2RkZWaHdaYndaOVFSMDRESXVyd044emhEaGJQdU1KU3hlMm94UFBj?=
 =?utf-8?B?VUZGM3FDZUY0NGxNUkVwUllNSmFyRXp4cWc0ZVJxdkt3Z2RYVm02VDhGUGpz?=
 =?utf-8?B?dG0wUUlkcENRMWYzd3QwVC9zNnpXdzNkT0lmQjJhZXltUEFLMVpSTFU1YVZJ?=
 =?utf-8?B?SVU4NVhIdkVlRTlYNnJ3TTJ1bGhJSC9VU0RuVWZBQ2JXTUZFRzVadHhTYzdI?=
 =?utf-8?B?THJPQlZMRzU5TjJmZkhNVFhqb3YyTkFlMDFwSjV6VXorN3VZOUtJOC9HSVZt?=
 =?utf-8?B?ZS9lbEJvNXBCaDVrU3ZpYUpsQTNpbVdFbDVPV0ttSU9KaHZaN01xTnpmZkIv?=
 =?utf-8?B?T2REL3RsTmpLdVorSGFsT2dQbjZkbXlNVTNqMFgzdWJOaWZoeFdicnNrN2RG?=
 =?utf-8?B?a3JONjVkWkE5U2VKMkVkdkVoZ0dwY0x5RG9DNFNLUmo0cStkdWtscmJ1bnN4?=
 =?utf-8?Q?io4ZARDR/Bz82FVGf8S4B/F+Q?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de85905-8cb9-4228-7c3d-08da65f28680
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 23:42:34.1748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GE2pP16WrQrzRpMSIlBaKsADQS/2kZMHPp++/cC+K9LibDh7lFu0Zn0/O6JJ2yep
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4157
X-Proofpoint-GUID: 4EBHA56McY-d0S7KGs1LH4Cj744BlRpR
X-Proofpoint-ORIG-GUID: 4EBHA56McY-d0S7KGs1LH4Cj744BlRpR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_19,2022-07-14_01,2022-06-22_01
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



On 7/14/22 2:16 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The commit 7337224fc150 ("bpf: Improve the info.func_info and info.func_info_rec_size behavior")
> accidently made bpf_prog_ksym_set_name() conservative for bpf subprograms.
> Fixed it so instead of "bpf_prog_tag_F" the stack traces print "bpf_prog_tag_full_subprog_name".
> 
> Fixes: 7337224fc150 ("bpf: Improve the info.func_info and info.func_info_rec_size behavior")
> Reported-by: Tejun Heo <tj@kernel.org>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
