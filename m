Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F3B623581
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 22:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiKIVMH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 16:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKIVMG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 16:12:06 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EB22EF76
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 13:12:05 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9KWL1Y005313;
        Wed, 9 Nov 2022 13:11:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=vIF81awT40/SDB0W/25L/BUp2UZak+iUjD0iNBhG3mQ=;
 b=VpInklML7CGp9Kmb2dgFQ30fgWqYwGcV5g84auX+nn7MADzWMmkMbygNnYIZOOJFQjGv
 25odLnlSiX56BlPY71acRYLvvqJEikAE2SMbe9aNK4E0Pq6RduvFaEVIvoxByXPmnBM+
 LFqF2+F4OWDY2sIvWxPDJkaZdpDXassGprEDFCJCx82ChXGsKVtbc51SwJoH68fBP0aT
 TUE8KPNZzNFHjdRj7ofbZd/RfSwQpONf4H8czf0FDANsmc1RPulY/TFsNdTrjLmo+y7c
 WVKtLD1Or4kLv/2tWJwHdCMTF4+jy4shgp471z/HUliWGadnOXry5jZgxDju6I6C1PlB rg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3krh8r9d5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 13:11:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8tMvj9I6rcZwjJJmJFuR2ALX/+a/ee9XP6TuXG0H2wsoFq3RUR64pUpGc+qVbd+PYSLckLjzYB9uKdA1zdNccwfCkOMgAvg3koz3LgIJdpgIGFd7VPvjN15nYh5mD1Fq+i1otvpYBXWJC787QrqhRDyATjUVzCKllQUVNrIyI35nly6o4tMTCKwAVSrPGWkF8d4XemquVbIdot0/FCtTsoufmf9qbABtqaCK08jKoCvPQEEAqXy9gD42kWq0IKmPRJHSjr4QQJ7mqsBMRlARvydWNUEbhd6NrHbCRS/Mh2kJdr23mw0jlYWnKrkyrvn5vjksj8zjQXtWTSdblySmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIF81awT40/SDB0W/25L/BUp2UZak+iUjD0iNBhG3mQ=;
 b=S8HsIjH2QYVc1aM7uS4Ky9kMQIn6CVCh+HCBDriUq05eyVqKp/UiJ4mr03tJ3zrP3kq6nmYDkuA/rZrlZdSmIqe+NIsiEqsoJ/2wUMVAD5EYeLo1rv+EkyZyof1oMNns+ZDfxUg6jWndduPFUMHDoI+Siu0Qvf2U7Mz6nvPvmzpkm+04XlHHfOlcocWxWHuVS2tsTX0kisao9BcSBFk59dJDyvYN1uYGX0dMiI7G+USlonlhe2YVhC9ruHCX7v2MLitFjlxwc7da43m3pnBnYhuwug/mvjCja/wiv5EmoHqsQMvTt/0jtmu7+mdlTX/oFz/zpleD0A4y/QJBylK3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2763.namprd15.prod.outlook.com (2603:10b6:5:1ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Wed, 9 Nov
 2022 21:11:37 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 21:11:37 +0000
Message-ID: <45abee73-850d-9563-2d70-46aec79cb054@meta.com>
Date:   Wed, 9 Nov 2022 13:11:34 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH bpf-next v2] selftests: fix test group SKIPPED result
Content-Language: en-US
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com
References: <20221109184039.3514033-1-cerasuolodomenico@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221109184039.3514033-1-cerasuolodomenico@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0130.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB2763:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d0f032-18c4-41b5-69f8-08dac296fd11
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yVxDZzAamSwHHlcsMX0CSjBkM2PyNuc4+6GIoF9K6WXjNHB9IBim6WQuLIx/1Tv3jhMXBP+S2+Dikq0J3Nvay9My7zG7hzKJVyr9/GdDQzC1IPpwHDDhK7iWJKy5HdW3ziF/KhQR9LAx28Y5hRuLnTEn2Sv1eUNU2b2JXRZ8waP6pQuGUVWaIj/8I0TQ40TiJ0oQKfz8g31R5e/SwIssg9paOfrw2H7ypViJm5ACC4/Wj78TnolfJ988iaGAPyzDG7BetARYUVUY92zlEBpfXQlYoBQFhovqzwWc7E+IyYFWtiEqaXOYTQvlHFQ8ncKPoU2+DO2gb/2WwTVX0OLKIlr6e3gyofKFpVzwPeFCqO7asRrWdFhMNjyZRThOFd2U/N/MUympLHFhEsJksgeG6StIHx2wIPar+s/2TDedJvuNoyRc+qUYOv3LwxWQykipoW4eMkQ4G6oPL7VUhCYE7t0LPqRvA+Hz34zr2RC7ebHr2qN6qRycYX6Iny94k8OCKd3e+7WNodf+tvUk6jo8DZc+jlznb6CpqCspvhR+iJRSML7hcIgPrPYNM/MwMgxFuCaeKPOWaP8NthiArew00LI/X3UxF+/ALn/Wsga/H9v12zbULaCdsM+faTqJhHgpiZDRNSJEyMO45AQFm0fPTTlBFcfBaqDwqJoLr0F5XcMSlEHzlBsOmsydFWGgo6NhgCsKJj5rHgby3ym3ZPbUsWBrAFIBPqE6O6BZftqEm334y2ku0FXhN+7uVYOI8/pkech1VL1gFnCSHOaRFgysKeTUAtgN2lXcpxPf7reGVMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199015)(2906002)(36756003)(66946007)(8676002)(6666004)(66556008)(66476007)(478600001)(316002)(5660300002)(41300700001)(8936002)(6486002)(186003)(2616005)(31686004)(53546011)(6506007)(38100700002)(86362001)(6512007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTdLYk1YUytjcVUvR05tU3lpNXBYS3ZhYUlMK3hXODFTV29xUGxPM1hKdmdY?=
 =?utf-8?B?MDhqU2Y1d2pTYTVwd2ZKcTJMUmlmYjZTMUFzd1BGR1B3QW5lbGxCVTkxOU9k?=
 =?utf-8?B?RXJSTEMzWEh3dzl2WnhVcVh2bGhzQlVMc1M4NjhLUGhJUGhySCtVblBhalZ1?=
 =?utf-8?B?dy9jT0V1S0c2RU1xNWd5R2RWZUNTUjlNT3lOanNHNWZLaU93VVJmWlNMV290?=
 =?utf-8?B?UXhGeGZFeWJMZ3lGU1ZWWU5Yd25WZTRyL2gvcFdLMUt3eHFNYlJlYUk1NUZ0?=
 =?utf-8?B?dm0rd3dhejY4S0dGeW16emhUM0lvUTdpVVlaV1EyRU1vbXplZTU1YXFiVEk1?=
 =?utf-8?B?VFp2YzF1U1ZEUk5EVmRRS1hjNDhDOFJLbXM4T09ocHZSeVZxdjZRZXM5Y29t?=
 =?utf-8?B?VWF0WjZsQWhJYnIzcndnVDhwUzhWTHVlTVpONWRCKzFGdzNnN1E5amFzS2h6?=
 =?utf-8?B?UVluSm9QVXRZay9iUUdJY0prS1dxM3ZnZGJQOGhBRkI2QTlJTTJoQXpmekVK?=
 =?utf-8?B?Wk0rd2huL3VlSVNISGY4d3diMDNNTmw4ZEhiUTJQaVczeWVJUFJoN0dTOWR5?=
 =?utf-8?B?QkJEUysvVUJSOFIyWHVldGU1WEhrNnRGRGx1YkdjZWxYN2JXNkJEelZ2K2N2?=
 =?utf-8?B?WktUTGNwRGppOHRXY0x3M3NLREFJQTFEMTczQk45TkJyVGh4RGZvKzZkOFVy?=
 =?utf-8?B?TmNyd3FxZnpQa0NLS1doT0gwTThIVCtNWTQzUFNwMnJOdHhJMEN2ZVRwbjc2?=
 =?utf-8?B?S0NTNGlyZk5JTlJJUVZ4YnE5REVJVFEzZU5RaFU1Q2FUMGRxazY3MWJxdGYz?=
 =?utf-8?B?R0E1MGtLKzdIRUR5MUhOWkdvTUxqQVhIS1Y3R3JaYWRxSFhhZi9ZVWVNRTlQ?=
 =?utf-8?B?LzF1WnZTMTE1bEFWcll5Nys5SjhTYWtLbU81by95K2duS3lmV3Rla2lkakRZ?=
 =?utf-8?B?c2RrWEJwOGN2d3BuRHZPVW1lQmhJdGdGcEUvVFRQSjhIL1NWVmpuRDBNU0pJ?=
 =?utf-8?B?QVNDQ1JjTEVSQUM0dDlzUkNvMlpKSktWeXdlSUNZa0JSVlltQjZ5Z3hOQUsv?=
 =?utf-8?B?b2tNZnI3UmZ2OHM1NDNZSzcvanFORDM1czh4K3ZJT0xwa1p3TEt0V1hHUjdL?=
 =?utf-8?B?VnJJYTFpaUFxbEUzNGZRcFF1RVFOVjNHVmdiZGN6ZTdaMHNQL0lWRXkyWjU3?=
 =?utf-8?B?QmRiOExKanJvTW5ndUJnQVVST05GWUp3TnBqakJ5M2RBMktpYnQvWGpyVEJQ?=
 =?utf-8?B?TEV5TDF4OERUVDYvbmNKV0c4R0xZTDdwM05Ncm9FVXh2YWN6YkZTdGt3ald3?=
 =?utf-8?B?R3h5WkFNWG5QSGhmY2V0NlkxWGR4a096cllsZHowWE9pcTFtQlpiRjRDZmh6?=
 =?utf-8?B?UEo2ZVZ1T0pnR2pBNHdCMEx6QlN6RkV0V1REdG5kYWFXQ0ZSd0FBNERXcStm?=
 =?utf-8?B?YThHWWZLRHJ4ak9RWHpkTlo0MmVvN05wa0k2LzFKajIzR1ROandhclNYT1RO?=
 =?utf-8?B?ZGhDVkNDSSt0OU42SmNKQVQ0d3FRdkFQamxFNFhDRmhtVktXMXN0bGUvWVN3?=
 =?utf-8?B?aWowTmRyS28yQk5XRjYrNHlDRGlsNWMxQ2twNHM0elloaklreU50OTQyT01O?=
 =?utf-8?B?NXBMMjhBQjN6QnhHRDB1KzMvY1R2Z0g3QWovZmZ5YU82VmMwRHFFZysrbUxv?=
 =?utf-8?B?dlpVOUwxTTRnSGp2eEZ2cFljdFNmeHNjL0pwVnVYTHdKQ2xuVEtCTTlyM0Nx?=
 =?utf-8?B?MzBxUmpaeXUyRUJJc1UzSVNodU9idy9XSXZWVFc3M1FVUlRKRUNxQkE2amoy?=
 =?utf-8?B?WE9kYXRXdktyTVRGMFhmeWMzWFlockJvRjRkTlpUaTBLUUk1Zk9vSzc2TG9O?=
 =?utf-8?B?SVYzQmMweDBEdXNhU1IrUjcrcjdyb3lrQkJHSmdFSjRjRW8yaVFmVnZRUE9Y?=
 =?utf-8?B?TzJ0MmlzYnh6VWNaOEh2UjV0YTJISERwU1V6RkhPbDIyK0NVK3Z5VHI3QzBR?=
 =?utf-8?B?R2N2bTJ6NSs5WGdHUUN2L3FVTHowS2I0S3ZjZDhEaXJFcUI5clRVVU11elMy?=
 =?utf-8?B?Sld3ZU0xMXdWcTdzUThvc2RwQWlCemhmVzdjQkUwS08wWnRqNUhKVU1QUVJ0?=
 =?utf-8?B?MzFMOGw1cnQ4REVVc1J0RUErOXZvMlNHMklOT2NTRmo2OHphUHJzb1IrMXdT?=
 =?utf-8?B?d0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d0f032-18c4-41b5-69f8-08dac296fd11
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 21:11:37.4568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbdc2EqUnwlaSjaph8RtBJsfQ+8SIaZVHmXbpmC+BUxM9z6LKNQN8htKNJkteOL8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2763
X-Proofpoint-ORIG-GUID: dNT9jDeTaj3baB1U-XTi6IC4JDP2d0Ub
X-Proofpoint-GUID: dNT9jDeTaj3baB1U-XTi6IC4JDP2d0Ub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/9/22 10:40 AM, Domenico Cerasuolo wrote:
> From: Domenico Cerasuolo <dceras@meta.com>
> 
> When showing the result of a test group, if one
> of the subtests was skipped, while still having
> passing subtests, the group result was marked as
> SKIP. E.g.:
> 
> 223/1   usdt/basic:SKIP
> 223/2   usdt/multispec:OK
> 223/3   usdt/urand_auto_attach:OK
> 223/4   usdt/urand_pid_attach:OK
> 223     usdt:SKIP
> 
> The test result of usdt in the example above
> should be OK instead of SKIP, because the test
> group did have passing tests and it would be
> considered in "normal" state.
> 
> With this change, only if all of the subtests
> were skipped, the group test is marked as SKIP.
> When only some of the subtests are skipped, a
> more detailed result is given, stating how
> many of the subtests were skipped. E.g:
> 
> 223/1   usdt/basic:SKIP
> 223/2   usdt/multispec:OK
> 223/3   usdt/urand_auto_attach:OK
> 223/4   usdt/urand_pid_attach:OK
> 223     usdt:OK (SKIP: 1/4)
> 
> changes from v1:
> - added (SKIP: x/y) to OK tests that have
> SKIP subtests
> - merged print_test_name and test_result
> functions as they were always called together
> 
> Signed-off-by: Domenico Cerasuolo <dceras@meta.com>

Acked-by: Yonghong Song <yhs@fb.com>
