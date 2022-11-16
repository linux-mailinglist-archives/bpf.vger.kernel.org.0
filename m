Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4531662CEF3
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 00:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbiKPXmw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 18:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbiKPXmg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 18:42:36 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB8A5BD55
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 15:41:53 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2AGNMCbt007845;
        Wed, 16 Nov 2022 15:41:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=p4oqfS/UI3bTaujclitH070v7dGduKuczHq5r6iBY1U=;
 b=bJvROXYFrrZ/quR5enm/es00xDetlAW8Dhv5117BRDjOXo56JvY8237SDxPi6l08Ugq1
 YuCsWmVzmHL0v0vMowu3HZS+qf6JeJvNS/K3U88Ib2ZZuijWdYI2ymwkuOiwTrVUrByo
 4/KGeGXP2DJYhsmbmLIw8cQvWCJ5mYXo3qruu/T9dyksW9xO9j/nGXCKCb9fK5O1+xWh
 PNfuyTnFTEO/DyfF95jP/KYS5O0sICrH7XzEk4zGq+8lBxQrl5VqmCzEyOKYEeYGYrnN
 95XkYvPvcraljizQ+Ytz9Pw9IujtMLJQ9H+Vo/FdkqGoY8b89tGAfRzXjyRJ3yQ/15aL +w== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kw33fux7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 15:41:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiONN/cY3qItejcvG64SKQc3wGJL+VT0dz8ad2Wg5qYgQKY9CS/zZWCWHYQGhMY+7uQ4UPzhWW9Peejtm3qFOggNPnvtQIfAJbL+I3tGYvGOexIyrWdIKFQvY4FM0xKI3TAC+MbKWqTtjbT0WFEutOiTZ8GryWNE8fJKW15yz4wWYhZ4Zs/ByGgRc7S9qqMCM6CfzojIc6GXVWnq55jf8Ow0LQQhJgmyFk3WeLVkr0qSu3XCpVPS/drKNtPKTE1XqKuXjT6pCS3hJmcfhXPNj0hrUmQJomqFoRz/bGnMcswWh0CoOHSVJ3pd0KNL9YTywo4w+K5VExo3JcZ64V8Uhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4oqfS/UI3bTaujclitH070v7dGduKuczHq5r6iBY1U=;
 b=A51Jj52AukbyHaptkIVnxP63jfFheLEYVr1O9g48irFx2v6hwfcECQoYKnCqk/qzjQHc9SQlo1p5vhYMPtH7/4GRQoDuSJhtBMimYg+fwSDfCn8CJQDrgEioRgdSN1JFLhsvhDo0Ai42KVA/d1x2Jjj5iYL1EsGKUtbPE1oymBCYrvZhExhb7VHU/cN3SsVVDk+862n55m7qG2pyvQIP8Dn0YUW94KY6rutxnNzYOQXxBkwxeIJhtGTu2gIwHXrvHgleKzA1frrW6nDHMz6KuPeGhlEVEWlea7kfHiF3sY8rOOlGHFbvT0hIUCAYZo6qjKF5aDjf4HRwPQFPBb8BAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2762.namprd15.prod.outlook.com (2603:10b6:5:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Wed, 16 Nov
 2022 23:41:11 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5813.013; Wed, 16 Nov 2022
 23:41:10 +0000
Message-ID: <48f7e9dd-b9d2-373d-6e71-c2ec17d53d73@meta.com>
Date:   Wed, 16 Nov 2022 15:41:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH bpf-next v3] bpf: Pass map file to .map_update_batch
 directly
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
References: <20221116075059.1551277-1-houtao@huaweicloud.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221116075059.1551277-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB2762:EE_
X-MS-Office365-Filtering-Correlation-Id: 258384d0-d10a-43aa-9dd0-08dac82c0a66
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qKJW4ykZT6IceQXrVzshCpC6HZUdo2Ip9RBDKxgMi+DOFuX0PlkvrNgC72zOONbx5LrRmoCDedL0RZrAgIrHeQL8u+VDx3PUSjZqeDMLEawu5WiNhfnS+i4h4qbMrFvJBFpNRIyMg/41a7oU59wxg2SIYlrM5SGOuc47kzQhU149byo5iqE9aDmGm13uuYuo6Ff2N520aILZpa8qA1Ktr8srOAYjOSx5shCBQPgi2TUjDHjw0N+GtxxisqOkvs2rVh495IkY3Zh6xWu1PqaP0DcrIEFpH+kgV2Xc+MUkIosQ0sJ+xa3ZBgxhKXKClHPQs1saTr8TChlBfIrbZ2stDikt7YAlPlwSJZ6QL7+nFoDg+EhM604YCmvhw2n4boymvzSifvKDqWlu5Xb6wt3yj5V9vIccVm1ggtQ2CnUi2iQy/y36t7xXliH8Sy0yl0gAQSUgThOOKVB8dzjtzi9Z8rX5q6zew4OI1xZ5NWw6BahJaBtgOlFo22B+nyN0Z7NswL+iHea+NEHsv84Losnt/uIn/fiL9Hq0b53uSdo5JIMh/uwfCTRRQswAbZdasF0swp8t2XaCpyEfpjdc7fTlCh3v5mrJ1/iApmp11NYgM6IzWbUX2h8aiw6g9h3TC+yZM5tbmoccuakqvesa6Fu/DSqIUJig8/5j1EJW3ZH/wFPd8+/DzJDTZ6ihBfH/fsZwY8J34swMiyTq45/zB17HOBlw+2qGv8+b/nwqaENGecz4SWMQeJXxc0Lv76ICfK52p8NbguWvkrsQjSAsEt0VueEc5ary0qwhi9feVfjQl23MtgELgQCVRMi6g0X1RDs9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199015)(36756003)(31686004)(38100700002)(31696002)(83380400001)(4326008)(6666004)(86362001)(478600001)(6506007)(8936002)(6486002)(53546011)(7416002)(66556008)(8676002)(66946007)(5660300002)(2616005)(2906002)(54906003)(186003)(316002)(41300700001)(66476007)(6512007)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1hIalV2UXgyekplY1ByUVVPdERldWhKZjhMaHdCUEI2ZDJTTmwxdVdCZFBy?=
 =?utf-8?B?dEhYL0pRMzVRQ3dlV0dGdTd1QWhIOGhDWDc5YTVLbnM5Wi9NU0lyQ0lDTmJO?=
 =?utf-8?B?TU9oaFgvckF0S0twNVVqWkdTTHE1MmVpZUhZZGlDWlFHMTBNNmVMWVpEOURm?=
 =?utf-8?B?SG9ibVkxK0dUVDN4QTVqZDNCM1B1OEI4dDgzTHRCUTZOcXA5VWFRbElKN21J?=
 =?utf-8?B?UnlNaHM2bUpaTlZnajNEQ2VhN1VkVytmcDJEYnQva0R2OXVnS1U1SUF6VnRJ?=
 =?utf-8?B?VTQyUDhJZmU0bUovNUFIemt0UHZsZ2dSLzMyMGtqVlBhUWcxN3RmM2d0ZE1x?=
 =?utf-8?B?TlZhZHl3SWVDdGtLalRNdkR5VW9Fd1ozeTJoVGdvZzJoblRkdENMWXNybnFh?=
 =?utf-8?B?M0JzWXg1N1pJNXFYWEZQRFcxcHdCNWNzUUtuWlAyeThnWWRxbjN1ZDVWTXZZ?=
 =?utf-8?B?OHRBRXg3Sm55NzFrVW1xTndjMVc5WWg1VkxVOEYvRE85Q1dMMlVsYWdQdDZj?=
 =?utf-8?B?empHSXdjaVJvbEEvWXh3WVZ4ZXA1MjNpUEE4N2swQTFmSEZ5dkhvSzNONFQy?=
 =?utf-8?B?cUpNMkh3c2VWNGtRSnZQeDNjMzVBMksyWFdYaUtwNDRCbSsrR0x4N2xrTDV6?=
 =?utf-8?B?bS9la3NZUTY5OWNsSEFJc1ZzTHlWUnhUZmpEVWxNbm9FTTJjMHVrMk40NllX?=
 =?utf-8?B?WEFNSEpMeUpTYUdlT0h6LzZnUmRXUDZFNk9SaGZjeTE1VHR4NG44ZVpNRTBi?=
 =?utf-8?B?amFRS2d4NklqOFpFaWt5b1Q4RmdQMFdFc2NJNXNpbGF4Z2lSaXJ5akltRFEz?=
 =?utf-8?B?bE1SWTZhRGhtNkU1ekhQZTBua2dyRTBxSk5ZTDQ4d3dkMCtpTlQrMVEyMlZS?=
 =?utf-8?B?a2w3V3FwcllxNkVTQlpiMlFScmZ1cnZOSWovanZFRWVSb292TncwdzV3dkoz?=
 =?utf-8?B?V1d0RHFUSTJMMjRJZnM1VlpBcjFxa1kzMnRUaWE2U1dqMmNQamNmOTg4cGxq?=
 =?utf-8?B?Kzc5UFJWUk5NNExla0FUSG5ta0JHc3dRZTFtZjFyYXRZWTY5UEQ4dVZpdVh5?=
 =?utf-8?B?dTRSeldYWTNaOVNPbjdFNHZLaExUL0VNS1hJUHdJczZnUWQ2RnRLUVowbTE1?=
 =?utf-8?B?enZnMWt4elJ3aWZPK3FEbG5MMjBjN1ZHZkRPV2tJWHZXdEFhemNMMXRpM3gx?=
 =?utf-8?B?ODRrUDg1cm5BVTMzd1c1V2dQRU94WHpaVnQyYk9CUENzYU1JV2NMbVp3U1dx?=
 =?utf-8?B?ZHVWRTMxS2hQajRteWQ0M3dHVzUzOGNXYlVFTzNxZk4raDVaM2Nsb1MyWHN5?=
 =?utf-8?B?c0NMY3BjOHpvMWhtZWtRMFIvK0ZEOVpsRnNiaGVvZ0hRakJqa1VuekZad0N6?=
 =?utf-8?B?QmZTUmxxb2NmZlBHNEdvNS9hT3VvSVlHNHJCU3JNQ3lGNFhxWVN0aExVMTkx?=
 =?utf-8?B?Smk0SHpiU2hnVStveDZWdjdpUHl4MUk3amg2dk8vUXgwQlYzYUJoaEVrMGY1?=
 =?utf-8?B?L0w3NWMyRzRkUDVEVXM4Y1hyMjdUNlg5ZE1GMy9FOFdUdHNISkJkMU8vTWhQ?=
 =?utf-8?B?OEZiZkxXYUUxcG9KN2I5a0xMRWwyZ29XMGhacjk1SytZVFJqa1QvQjlHNjBK?=
 =?utf-8?B?S3Z3eVYvcVFXZHJwTk1wVVdyZlhTNlpYRGphYW9nZ1JJOXpqakhlcTliSGlN?=
 =?utf-8?B?VFNZeHp3VjE4S1k4WWJEY1p2U3c5eGdwcDBTYWtWY3ZYeXpmN2d4eEVzVFhV?=
 =?utf-8?B?WE1jcGs4NGtFdmdubDdiS0d2blhTcjdCNEVIeVBZOUo5YWRtU3FYMlVlM1F6?=
 =?utf-8?B?Y3BzQmJjQkpSUm5pelFDOGViNlpaa2dMM0xDSXh2NjFaVEFVanR2L285c0Q0?=
 =?utf-8?B?QkpoR25VcDZlMk1JdlU4ZHF6VTkyVmwyMnlNNXN4MFhBcml2bjdwOGl3SEUv?=
 =?utf-8?B?MWE5Z1NmT1dmdVdmRjVheWNTSlFuenFrWFBETTBaVUZ1Z0FERGpHeGEwQ3My?=
 =?utf-8?B?dW1aNno1N3VZTVZEeGo3TkY0UXhacXA2RWxtcXJmOHNLUlIwcTZ3TkhDaFVW?=
 =?utf-8?B?a0MrUTJOVTFobDZKUWhCTEUvcVFpQU9wQnFNeU1LOFU5bTF2eG5xWmNZS3Q4?=
 =?utf-8?B?aklSUFVrUTkwMElxSFhxWFhESkFvVkk0aHNGUnNBQzFtVjgydmtVUkdCNjlP?=
 =?utf-8?B?S3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258384d0-d10a-43aa-9dd0-08dac82c0a66
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 23:41:10.6053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VY1U0l0lnrOb65qHcGn1f/dcEI2R1RYH0ugyiazK6jLNqcc/Mjy6REmTr1qjdXbM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2762
X-Proofpoint-ORIG-GUID: L22d_f9c6U-DvRWEkoB3n79M6PKOi4jh
X-Proofpoint-GUID: L22d_f9c6U-DvRWEkoB3n79M6PKOi4jh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/15/22 11:50 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Currently bpf_map_do_batch() first invokes fdget(batch.map_fd) to get
> the target map file, then it invokes generic_map_update_batch() to do
> batch update. generic_map_update_batch() will get the target map file
> by using fdget(batch.map_fd) again and pass it to
> bpf_map_update_value().
> 
> The problem is map file returned by the second fdget() may be NULL or a
> totally different file compared by map file in bpf_map_do_batch(). The
> reason is that the first fdget() only guarantees the liveness of struct
> file instead of file descriptor and the file description may be released
> by concurrent close() through pick_file().
> 
> It doesn't incur any problem as for now, because maps with batch update
> support don't use map file in .map_fd_get_ptr() ops. But it is better to
> fix the potential access of an invalid map file.
> 
> Using __bpf_map_get() again in generic_map_update_batch() can not fix
> the problem, because batch.map_fd may be closed and reopened, and the
> returned map file may be different with map file got in
> bpf_map_do_batch(), so just passing the map file directly to
> .map_update_batch() in bpf_map_do_batch().
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Yonghong Song <yhs@fb.com>
