Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5670620228
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 23:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiKGWLP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 17:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbiKGWLK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 17:11:10 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD591E71B
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 14:11:09 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7LKr8K031156;
        Mon, 7 Nov 2022 14:10:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=6Lsh5SZt39kqiDJTJtQeMJbgRpe1gLxsMoWnZKhhMlM=;
 b=CZeOD3qZN2LaBXpcp/1wYlnmINFlDWy9ZvDjHZiA0ghnzHqFw6i13oOlFXFJN8s4Ma4T
 WqTB/iRr9EB74wfOwJv0vi8VOqHPH+VLgyuhmF/30hhqkBmF0EDPe0tVbA3G4itex0A0
 RAHM4vzBSaNZi6pEoSWClw6EClIfaSo5rr6u4ZmtCAqbFo1/2kEsmvguA33YHYUPqNaR
 LUJnX5gDnHTPc1XDtTd89apTz+pkDCI/GrIo6nkee9cJzsJSkmy2aXS2B6F7vSsQVFAt
 i+mINVkyaDf60bSdcKGg2DKea+d/jTkSOSToNi+9yTpUPBwhIq5wgC/Qs+F/sKKpB1yF yw== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3knnhnu3gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 14:10:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSnt/75GUUzRoob39z6bVY4q4roiGcY5k4SPjoyk5vuGMu5QTPxdP44cViT+N3HqBwKufpntGrfyjTKNUmJg5tCc8GcqBQnl+r4qsAbFqKZjMimDH2sW4Q7HoXOhsroXJzn7kSRI5NEL8OMgTF0q7/L0vmlzzbAOphXnZ6fwT8c6UaXuJD3CQFyWs9SzHdBlimtDahf6LM6uyd3a1zDaax+6LibxEx+tMK/5nI+GYf5b8OUezA0/8tcir02vgazDE6FJ6S4O6wULJpdahMYthSgqnGDMmJ6QzqYFWvrFuFVcgzZ3SIhE5aaMy4SZ9mQr0esBYNsIBctXVDqJyUXqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Lsh5SZt39kqiDJTJtQeMJbgRpe1gLxsMoWnZKhhMlM=;
 b=TLs/nM6uCxXwilsqkIBnVo4WOeZVafYnE3jbHN1Ep40MxvxT4cAVdovYhqgZ1XIzcLJfD//RuOV2YZfsuDNyz4m3APBodi4GphXoEnC5jbeUId65UqzQr8pTcVIvM2n303BHfPUikEEGqsfC393u+SoPud3RmmtK+WmB7ptdUz1CYxs64MybeRpvPXFCC2aaxGMUftVxqu6mXAKMnjTsLSv1u4NTAiGNmFjECBNkyrPObQIPWNa4BOtJZdljEDoqVbJW02ASQLWPSGbZ1W4PS4vNJCJ5pOpHxKT2PV6AOFlKJPukP6h1YispCWiEJPKv3/XVsTaNUUwxwu0YGj0enA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW2PR1501MB2060.namprd15.prod.outlook.com (2603:10b6:302:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 22:10:31 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 22:10:31 +0000
Message-ID: <9d179a19-a220-bce6-b047-39f393552ad5@meta.com>
Date:   Mon, 7 Nov 2022 14:10:28 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf 2/3] selftests/bpf: Add cgroup helper remove_cgroup()
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
 <20221107074222.1323017-3-houtao@huaweicloud.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221107074222.1323017-3-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW2PR1501MB2060:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f58a83-f15c-41cf-d5a2-08dac10ce291
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8sT8yqrIXl5FPaxkOPswJpOSKlE4cW+igm5RxERYHgZ2YAY54AOP84m1GPg9G/5A3vlZjjZoN3Vl5wroWPaF3TPdyuzGo80Io62yjvy7A5ornkJ5MQYxDHZmNHXqVXVNn0BY8+Ojd4JOwdMNP20LTldFPinxtCK1ZkDoYCtc7A3ZYU3M353pn30WVm7H6mLauirz9PceU5AU7RgTYXcqpW3Hek/UHvwt36WHX+CiHfU4q/fFC3a6QKiwGn6siDBPfKfUT1o9ISmfx1R9EENP0rh5YD31/Bbk5PLSW1tuMPUKTjL9Hz3hljwkj3pESKCpj+jCLwOtgbhWbZfAjO4eIFTvgjLzDdez867tw2tMai4mpDZpInMd2MfzCGYxDSMABeJhbEFxGDtYAD3vj2GtgU2MQaZqyGRyX9xwjQ97op7CWRtGUa767RSnfP3yvUrHSgM2siftHc1xULz5H0virPr14FzawvvNwlgj4/MSw5rGmQjmvJCDisu9nPxLCRR1KjD+PO83IfMEdhz+KYed9yxm008nv9HIJgChURKE7x1HqRe7ZkDxkNX8VIU7Mz8Lr/HW25e0/PoAXcNM/MTrD2kYPwW6Bxh5ZhG+9oi2pUDfi0nxWV+uiG77XDJZne4u789vMGN7YnUhuRIYplTM7TVswUGIt+hZqtmeLHggzm0WHPzkTeTLwR8cHfFXU76XycEo6hM1RThw4gXlvcb+ezQ2ulmUMMkbCTRnbW1ZB9CkR8ZEo4m27cUb2GxlPaN4CXBYimi7puJrEnAlqeSDIwIGrBjJDjdoMXK9nPS7s2g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199015)(31696002)(36756003)(86362001)(186003)(66476007)(66556008)(66946007)(316002)(41300700001)(4326008)(2616005)(53546011)(54906003)(6506007)(6512007)(6666004)(110136005)(478600001)(6486002)(38100700002)(8676002)(4744005)(7416002)(8936002)(5660300002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHNCM1lNUFY1RFMzQmJVa3lyQlBkUENXbHFVb3BmY0FSeGZVdEdObW1IWGxQ?=
 =?utf-8?B?QUFheFhkWlVkTjJCT1Z1S3VQWDYxNGxRcHRPTWVhcmtFYk1NQnNkZFpGSnNj?=
 =?utf-8?B?U2hidzZqRlRWaHQ2SXdZbWQ5bmJ6WktESUd3M0ZVY3JtU1hnS3lvMzZoUVQv?=
 =?utf-8?B?VVRGd3E1bm44NmRhd1lCQnlrOXI0Ums2NitMSkdFdzkwSXRlVVVxNDJveG5p?=
 =?utf-8?B?ZzhsQ1VMRm5zWkFoKzVjK0tORno5eXc3ZFdXS3oxYnBINE1IcmYvVzdtOGZa?=
 =?utf-8?B?SFdhdU9ZSHpPY3YyRU1FditDUUpvS2dIU0FYV0FVbDQ1dkNldHJzMWdid1g3?=
 =?utf-8?B?MjR5YXhDbFhPa1o2WXpnOW5jUEFBU0RQZnRJeUMxbGpYR21tUDVHTXZESWc5?=
 =?utf-8?B?dWxpQ1pWU25KNUJGbWZyV2Z2d3dvOUF3NlBVWlZub0x1bUxZb3FGbUFRVk9Z?=
 =?utf-8?B?VDBYaWhrak8wa0ZjeW5kYzVvNlNBVEFrNEYrNnR3Rk9yR204dFdNc3pjMjF6?=
 =?utf-8?B?eXhQb1BDeldINGMwL0FTalhUQkNDTnhFUllCTmRySzlrL3BQOVJ1MDlDQk5s?=
 =?utf-8?B?ajl5MU05Z0xpNnVrK0J6TkpPSVVkdjVzNEk1MkZtcmZTRnhrMDlzM1BiS3BB?=
 =?utf-8?B?czJXMFp0MlZ0ZXkzcEpCRmpuMEZwNlhtSHZaa3BaeVpPK2htcCtaUUd5ekFm?=
 =?utf-8?B?eVJaWldMYUI2SjVINkQvaDV0RkhOOVN0dEZEM3FSekNDa2pwVXFxVEZ4UFR2?=
 =?utf-8?B?SWo2S3JheGtzUjdUSzMzVjhld2sxQlpSbUVlTUhESFpYRUVkd3J5cGJSbUNT?=
 =?utf-8?B?NmQ5K21Bd3FCR1lHUGZoM0FUNG9WMkRUUUdOUkNhb0VLK0FOQ2RldlJWWTVi?=
 =?utf-8?B?SExTZ2ZCWXB3YWQwK1hTWWlqayszWVRpWThGUXF5eDlQRVNaS2sxUjc2dnp0?=
 =?utf-8?B?UnR3bUFPdXRDQkVHQUp4cUcwMXhlaS8rWERjNFRkK1dVcDJoNkFvelpOanlk?=
 =?utf-8?B?RXUwQ2JTMi80T1hLQnRpdEpncmU4MDNROXRWRFFIZ25qalo1NHFnQUlYRXB2?=
 =?utf-8?B?V0g0cFhLdWZrWmpJNngxRGYyZUtCZHE0ZEV6MHM0Mm9WcnB3YXJMeUNaZ0tp?=
 =?utf-8?B?UGxoSm1OK0p0RmcwcnI5UXhSOVVBclU3OU1Oa1I1T3dqcVZOd3lyek0yM29q?=
 =?utf-8?B?dDd5bEQyNDZ5VGtMS0l4bDl2S21idjBvNlVGQTBFT2JTMStVZUhMeHdQaUNV?=
 =?utf-8?B?cVB1eXdNaFIwcnp4RjhYaEdOT09ZM1lQTGRLQXpQUUNqblpEVElZMU1YSDIw?=
 =?utf-8?B?MklWODBxeTg0eVZqVEYvUW9NQkNJek1ScUVmU1RWamRpS245VkJuNDhRLy8r?=
 =?utf-8?B?enFBL1RLSHZQamVuN2lQK3BBLzhja0tTVTZVZkRJMXM3eHZITmFXRU1SS0lj?=
 =?utf-8?B?b1VGbWhiZldZdW1VbkRjaHBZVnl1dHpZRHhIa0ZVc1k1RUN2eGd0ejJmb2Zw?=
 =?utf-8?B?RmZCeTQ5NlpzQU5uc3pDZXhmOXpqbFN1VHlzMm1WaTUyYjFJVzB6S3luOVNy?=
 =?utf-8?B?eGZTMDBnL3BHSDJuMFJNS0lvMVcvTXVwTjd5U0dmMEJWaDJyM0EvQmg5RWdu?=
 =?utf-8?B?M2EwU1hrZ056UjRIdkdWa0xGK2Y4UC83R21jWm9sajN6MmhyVVdpV084alps?=
 =?utf-8?B?WHhmSERERnM3OWhWRHJQR3hIcC9haWh6QXdJanVjS0VpK0RBQlVuczRhbU9R?=
 =?utf-8?B?U2V6YWsyazA3dCs4a2svalNaU3o4eVVqaVhwQ0YvYmEyd1FDMjNRUENpM201?=
 =?utf-8?B?bFprOEJ2U2NNbmRuS05JSmo5aGxqSVJ5Z09GVjgvZUpHb29xdzVKeXhRTllM?=
 =?utf-8?B?OHlQZjlBS2wzNnY5L3o5L0h2eVREOWxIMlV6aW1ZSzJmWFZtTHhEMjMwZmND?=
 =?utf-8?B?R0NCM3hOelhhOGhIMWZwWXdrRmR0NEVHVU9ZSm5Pemh4SXkzTFFpc2tYOXdt?=
 =?utf-8?B?RmdPQTFLZ1NVa2YvUUdyNXlPMnN5YXFhbHVaUmlPMUd5TEJwVUMwN0FtNFl1?=
 =?utf-8?B?NEF4NnhDSHdOR2hHTGU4VUNoMnp3YW5sMXExaHppa0FEMUpVWEFoalNHY1R4?=
 =?utf-8?B?WlZOdHAxLzM3OVg2OUU0bklVa3IrOWpNOWlmQmg1Tjl3RnJMODB3OFc2VVRp?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f58a83-f15c-41cf-d5a2-08dac10ce291
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 22:10:31.4135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYw5wrEJGqycr3Ytn5Ko3q/Lvm0Y6tuNpX69UgOh/b/eAq6Zv6t9olp/8aYiQeqC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2060
X-Proofpoint-GUID: 7j04-7lufrgmelDNxm34DKZFdhS38ERV
X-Proofpoint-ORIG-GUID: 7j04-7lufrgmelDNxm34DKZFdhS38ERV
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
> Add remove_cgroup() to remove a cgroup which doesn't have any children
> or live processes. It will be used by the following patch to test cgroup
> iterator on a dead cgroup.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Yonghong Song <yhs@fb.com>
