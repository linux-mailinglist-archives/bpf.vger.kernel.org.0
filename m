Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9838353D3AF
	for <lists+bpf@lfdr.de>; Sat,  4 Jun 2022 00:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243961AbiFCWl4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 18:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiFCWlz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 18:41:55 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F32414003
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 15:41:53 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253GmQgW021864;
        Fri, 3 Jun 2022 15:41:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=xe12oAaFCusujrdUo4vG+4P8e0AK9r/6iEekJd2E1Ns=;
 b=dbRYEYX5zPlDp+DDnjMLtZqGjeCUvWYDhkCS3n8Y8V2FCOwa8UNraFdrG6MiaDkSvRb5
 NJcn0Hu1yIojR3aSbg0Wc/KdgTTYVUOLdcXkZrvSFs850sCunmUwtMNTEE69yV9pFhz1
 pNPJR/ZqWa6z/FGJlImXrczUlfdu0DCC3tE= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gewq9ad9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 15:41:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTs9aykqAmpXcetCo7sLquFuq941Bo16GtSzBXYOfEVwqZP6/qsBER8cBaRc/t+0vA/6MmqLr1wzqZDT1dmHfnMaTlXmI7cL7ABlPxMXgEkAbw6BY+tgkm0bfzEs46x86vJQ2ud/j4GktzgTFr3IM/3dvstMDU2oLlrNQmJ+ZBP6tFUAVel+Ho6ET2QYsxtLmWrzlEgG275yAPd94fsS+HdHJEmqPSyLqkYpQ5KfrsQLWo/BhLm0IFHkvQhNKa9w2S8zLvXx0e7p4EQQqAhVtHju5K3UoaN6VnWSc+SweNtW6DY9unCt0sv4l3NMELzbx0n4/yS+nJhZfxDrfMvH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xe12oAaFCusujrdUo4vG+4P8e0AK9r/6iEekJd2E1Ns=;
 b=RYltHthGnkCEltniHJ3OWVvc38i6pmKPQSEBGb1WgL3vTs5Jfoi0g327RQoxQ62vSu18eBaIbBZKuSzor6LO/n9SgX8ieM30pouHy8f2rDhS9VjoY/6iuUrpIZEhwEyhy0bxNLEx5LwMVPPLoYC+VL7Nlu7ry1ivrQkrU6gkSiE44hjAxE/gB2S36MiDS1Py8b7lsdtbTldhUPnw1000j5fRdb3qfdu/HlEc01s1s5KQFzi25CwyOq/anSb6YpI01lrKJ+npWhP4ze2nlzjZhzEVOljyyhvI/M4OpxdCPzDMfnl3rjkxt6MBDnqDfpyu7Fw9YIbT15rbUoOjzp8+sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by CY4PR15MB1128.namprd15.prod.outlook.com (2603:10b6:903:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Fri, 3 Jun
 2022 22:41:08 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb%9]) with mapi id 15.20.5314.015; Fri, 3 Jun 2022
 22:41:08 +0000
Message-ID: <33a1b3c1-fbc1-f0ac-53e7-4504325b2c90@fb.com>
Date:   Fri, 3 Jun 2022 18:41:06 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4 bpf-next 1/2] selftests/bpf: Add benchmark for
 local_storage get
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Kernel Team <kernel-team@fb.com>
References: <20220530202711.2594486-1-davemarchevsky@fb.com>
 <CAEf4BzZihqda7cdSCwbF5fwZPSFevNGHc3+76n+=49NWWgqtEQ@mail.gmail.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <CAEf4BzZihqda7cdSCwbF5fwZPSFevNGHc3+76n+=49NWWgqtEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MN2PR19CA0066.namprd19.prod.outlook.com
 (2603:10b6:208:19b::43) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6e1beb4-d202-4951-0caf-08da45b226ee
X-MS-TrafficTypeDiagnostic: CY4PR15MB1128:EE_
X-Microsoft-Antispam-PRVS: <CY4PR15MB1128D3969E761F2BBF3C222CA0A19@CY4PR15MB1128.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYrejAv4beZKLli6N44iswAfRS0LLC3Azq8njXTM15okDjYYBrMccfnROmR1YFhk5EtC/1c+GGOSBRpazDjWNbQiLBzHR30qOZ1J1tmQ1quABV68Uz7SXWClahjzMAvnvdM//YO4E9+ILyEe1N2AexMcvZhy2MjY/+p5L+CwwAbzvDBs688f1xKh9RMv5kQu/x+1wQV9db0PQ2K6itGuQhzcjnA/FuN/pRnjSRK13e44n+wMM35tWI0nAyFcdPdljtxkhXGMA+5DLG/4Rqe7Ei/oJk230j8jKrPdhbNqvVS1ptrklabVAhnMN7O9UWuNsP+rYUQ4FiKgo+E4P6a1Ggk8dsn10w/0PtQMYhgQVzdpmBO6QcIZ8kQb5h5nggLSPh6qoMO9DdUkdmHtm0lrJASSq75WGE+8NGtos5iOI5rUzZwWyR3MU2JAPlL9x0fwdOqNe+DKjKtenL8xuJ8eIVrfTr7Tskocr1GHkMzgq1O5O2jPHQmOtgl1USxDvxgawtuayE492IIv/mj8lEJHS6/k0c0EC8SgELdWDXq1qcj0Hd8Ec+U4PNd8f/wcxLcdYxcyiRaKFNvE3K99oBmJ9svA86/TZ6n5kq8cApkE4gxOWrCEJ3heqdK8eyfXiSCi7tDkEHRbhj6zXuZqGrOMVXum41Y8lFEJKrUfEW5Nr5zm82iVOPYVmNCHNIwtjcQGft6aSgDz+Zg4bOWiV2wWt98Dmepc5PFbjZ8h0vVKbKU1hPQatwtHH4e8sIbhcIo7Qioe1+DMwZnsAAwNPVjhH8R0jTtq8wIriBMlwMkcenPeJHHs/VqzHQVieC9OdN6P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(5660300002)(2906002)(53546011)(966005)(30864003)(31696002)(316002)(54906003)(6916009)(86362001)(6506007)(8676002)(4326008)(83380400001)(66476007)(66946007)(6486002)(66556008)(508600001)(6512007)(36756003)(2616005)(38100700002)(31686004)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTB3U3REUnFCa2syaGZKTytLZCtPMFBqeVN1dENkQjZzc1E5eElOTmsvZmlz?=
 =?utf-8?B?ZENsWXV4NU9LRHFMZTNDSHQzcVRqakJob054ZjIrWDRYdGd1aHE3OTgxS0Jz?=
 =?utf-8?B?NDBQc3V6RVZ3RStQVytMT25RM1dhb3g4VjJRVHAxdjhFeEtUVjY0OWwwNWFB?=
 =?utf-8?B?ai9mSi9vTkpPeDBBNUNnM1ZCZE43SHpreGo1WmZoMGdTSytuMlRNL1dNRHpy?=
 =?utf-8?B?N2Zha0hiMEJTZlhIb0h4Uk51bW5QTlNySjQ0UVB0TFE1b0Z3YkhqWVNlSXVu?=
 =?utf-8?B?UnEvdWwxcWNLUE1uQ08zdUsreVhPRlFIREF2ZlU3Smt1ZzJIdVBicHlVNVlL?=
 =?utf-8?B?cDhzb0gvZUM5NWNyWlFTOVpKZnRTSmJHMzN2R0xSK1U2cDJxY1Z0MDBFc0dE?=
 =?utf-8?B?WlRpa3RnZHBPUS9VMHRtMTBGbFRRNTBIMFc4dzhkUWV6akJVM3dpT2lxNDdl?=
 =?utf-8?B?WnI1ckdzUGF5ZURaeW0rSFUrVFU2MEZYK2Y2YWtWWkZrM3pmNHFTOEEyTDhN?=
 =?utf-8?B?WVNLZWtSRUxtU04xdHFZa2FaNjBFbUdsS3F4eGFEbXNNb0lERFRmVlZIVzRS?=
 =?utf-8?B?R2djYkhDTUdYbW4xK0RhU0VPWUNMMVB5UTl3RXNucGtvRzc0dG9yTDV6QUor?=
 =?utf-8?B?UkViYmxTSGp6U0JEY29BM3VBQ2ZQV3Zrdm9HTlBXbnNrVEdIMnFtbGlQRnYx?=
 =?utf-8?B?RlFHYWFDVVNMbWRNa09KalRSNEF2K3o3QTRMRFpBaCtvcmxxL09ZVThHOHZ2?=
 =?utf-8?B?QmRwVm51eVFiUytLeXZRcmh0QTZXWmtSMjlVcldqUnlpdFBzN2NQR1BJZjRS?=
 =?utf-8?B?aDVkZFYxcjIxc3FvWC91blN0NUVFbjVLRTU3RXBZTm0rZzJBTVZJcG1hSm11?=
 =?utf-8?B?am5acUpsczBSRTZVTTJZN2p4NXcybG1ZMGorajlvTnpVTE1lWm50U0tieDBo?=
 =?utf-8?B?MjJHeXlITERqNExwcHErODJWNzBZWHE2WmtYWEdjTUMwZ2RnWU1aTjhiNVUr?=
 =?utf-8?B?Z0pOdng3WHhyNVY4SWJkU1UyVExKZDFYUmh3UDhkY3lMd0tkQWxwZjVxb0JH?=
 =?utf-8?B?cXdJQU5xdmdMdkp4K3dnN3J5Wi9JUUVoYVhVZTI3Qkdnc01KUEhncEp0b0J0?=
 =?utf-8?B?MElhVUc2VlEwczJpVGNGcFMvWndBUzAzVGs4K1lVeTNLdHluU2pBS2JueEJL?=
 =?utf-8?B?cXorZlNLOGFCVEkxNk1RbEUwemlOZGczSVEvZ2FyN1A4Nk11TWJ3ZUtJU1RR?=
 =?utf-8?B?Q0lzdnhlK3ZENExOc2lUcWk4VmxzU242aXhod0JTUHI3MjVwQnBNcCtJZHVO?=
 =?utf-8?B?dnp3MDN1OUlvMDBENUdVbUNhK1FDbHFURFlEOWZoQk1wZ1pRVkhJYy8xc2dR?=
 =?utf-8?B?QXhCZmd0aDFVeFNtZG50YmNxcEN1OXhYV25BUEl1VWNkUU5uS2FiUDBwdnQ0?=
 =?utf-8?B?UTBnamhiRVlvejZYaUxPMVVhRHFMRTFBQm9QT0VVUjZYbXZVaFcrdXhzY2po?=
 =?utf-8?B?dEdYUVpnL1BtVC9nQmY0WXlmRFk3b01wN3U1dlJyQmJYTmtOKzFneUVYdnVu?=
 =?utf-8?B?cys0bm1ZUHBhUzB3cmIraEVMdHBNZmRZK29sSXZoa1I2QjZSYmpsamd5MmxG?=
 =?utf-8?B?aTN2WHBPOUpCbVRGZ0VqNHVBTC8vQXphVytaUVphaVFWMmoyS2NteWlXNUxx?=
 =?utf-8?B?MmkwSHc1dGdTOEY4eHhPK2UwSFMzTDZHRnRzamZMWk5EV2d6Wnoza21RMHht?=
 =?utf-8?B?N1JwQmZjSzE2V2RJNko0TVY5blBOL3AwYzdZRzU5S0lVWWFaZXlQMGxiRWJL?=
 =?utf-8?B?VmNnSVRlMVBvY1ZVNnBXeWJZNCs3TGFrZGFlR3c0U3dOVHpUKzkzQkxKcVp6?=
 =?utf-8?B?UFVvMElXZndhTTNzU0ZWeXVvaGlxb2gzdk83YkRIMTJoVXZGTmpjR3BkSzly?=
 =?utf-8?B?Z1FUaUlERlA3MzQvK3FwVkUrdGRRTmRqQ3ZIRDhBeUIyaWI2djFFU1UyekFq?=
 =?utf-8?B?ckRvL1FlanJDVlRjYWxxNm9Yc1ppYzNpbjNXeHFFYnBmaVQ0VWZPUnZGc052?=
 =?utf-8?B?eExCSTdLWHkzRnZTS2xYcXJDaGlZdFJJSEhrZVRhR1EzT2xOU1VRcjRKcUpV?=
 =?utf-8?B?dUs1ak5tRWtQalM0WkNDZ2p4UVk3UHh0OFNtS3VSQ0pvb0d1bkN5cmJuRlc2?=
 =?utf-8?B?VUxzQkxacVdKcW45L2hIZGxqNi9OZGRaZjFPSGgvUzZFdC9SdmpCcFkzeEJV?=
 =?utf-8?B?SlNyaFRwcU1CTFUzcE5tVHh6OEp2UHQ2dDVHVVIwcG5CeWQ2Yjl2S1ZkNEpy?=
 =?utf-8?B?UnZGakpOSEZHY3VUZ3ZiVGM5TVlmYkRhSmZhT25DcXJOc0gzbzY3Q2Rlbnpm?=
 =?utf-8?Q?vXLXjrfDbPpXOvrelnhN8quWSaVKzfUN3+iwB?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e1beb4-d202-4951-0caf-08da45b226ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 22:41:08.7226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ml3wSQ5N0IMN2H1bMWJr2UGyRCx5Ovj2FXaQCVdijcbb/x0QQxW7FFPPiLN0imiiwaHrPJuNwceH+rtn879xlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1128
X-Proofpoint-ORIG-GUID: 9oW6zFVdBXHR6lWHtIU0luSnBpgfYOcw
X-Proofpoint-GUID: 9oW6zFVdBXHR6lWHtIU0luSnBpgfYOcw
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_08,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/3/22 5:26 PM, Andrii Nakryiko wrote:   
> On Mon, May 30, 2022 at 1:27 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>
>> Add a benchmarks to demonstrate the performance cliff for local_storage
>> get as the number of local_storage maps increases beyond current
>> local_storage implementation's cache size.
>>
>> "sequential get" and "interleaved get" benchmarks are added, both of
>> which do many bpf_task_storage_get calls on sets of task local_storage
>> maps of various counts, while considering a single specific map to be
>> 'important' and counting task_storage_gets to the important map
>> separately in addition to normal 'hits' count of all gets. Goal here is
>> to mimic scenario where a particular program using one map - the
>> important one - is running on a system where many other local_storage
>> maps exist and are accessed often.
>>
>> While "sequential get" benchmark does bpf_task_storage_get for map 0, 1,
>> ..., {9, 99, 999} in order, "interleaved" benchmark interleaves 4
>> bpf_task_storage_gets for the important map for every 10 map gets. This
>> is meant to highlight performance differences when important map is
>> accessed far more frequently than non-important maps.
>>
>> A "hashmap control" benchmark is also included for easy comparison of
>> standard bpf hashmap lookup vs local_storage get. The benchmark is
>> identical to "sequential get", but creates and uses BPF_MAP_TYPE_HASH
>> instead of local storage.
>>
>> Addition of this benchmark is inspired by conversation with Alexei in a
>> previous patchset's thread [0], which highlighted the need for such a
>> benchmark to motivate and validate improvements to local_storage
>> implementation. My approach in that series focused on improving
>> performance for explicitly-marked 'important' maps and was rejected
>> with feedback to make more generally-applicable improvements while
>> avoiding explicitly marking maps as important. Thus the benchmark
>> reports both general and important-map-focused metrics, so effect of
>> future work on both is clear.
>>
>> Regarding the benchmark results. On a powerful system (Skylake, 20
>> cores, 256gb ram):
>>
>> Local Storage
>> =============
>>         Hashmap Control w/ 500 maps
>> hashmap (control) sequential    get:  hits throughput: 48.338 ± 2.366 M ops/s, hits latency: 20.688 ns/op, important_hits throughput: 0.097 ± 0.005 M ops/s
>>
>>         num_maps: 1
>> local_storage cache sequential  get:  hits throughput: 44.503 ± 1.080 M ops/s, hits latency: 22.470 ns/op, important_hits throughput: 44.503 ± 1.080 M ops/s
>> local_storage cache interleaved get:  hits throughput: 54.963 ± 0.586 M ops/s, hits latency: 18.194 ns/op, important_hits throughput: 54.963 ± 0.586 M ops/s
>>
>>         num_maps: 10
>> local_storage cache sequential  get:  hits throughput: 43.743 ± 0.418 M ops/s, hits latency: 22.861 ns/op, important_hits throughput: 4.374 ± 0.042 M ops/s
>> local_storage cache interleaved get:  hits throughput: 50.073 ± 0.609 M ops/s, hits latency: 19.971 ns/op, important_hits throughput: 17.883 ± 0.217 M ops/s
>>
>>         num_maps: 16
>> local_storage cache sequential  get:  hits throughput: 43.962 ± 0.525 M ops/s, hits latency: 22.747 ns/op, important_hits throughput: 2.748 ± 0.033 M ops/s
>> local_storage cache interleaved get:  hits throughput: 48.166 ± 0.825 M ops/s, hits latency: 20.761 ns/op, important_hits throughput: 15.326 ± 0.263 M ops/s
>>
>>         num_maps: 17
>> local_storage cache sequential  get:  hits throughput: 33.207 ± 0.461 M ops/s, hits latency: 30.114 ns/op, important_hits throughput: 1.956 ± 0.027 M ops/s
>> local_storage cache interleaved get:  hits throughput: 43.540 ± 0.265 M ops/s, hits latency: 22.968 ns/op, important_hits throughput: 13.255 ± 0.081 M ops/s
>>
>>         num_maps: 24
>> local_storage cache sequential  get:  hits throughput: 19.402 ± 0.348 M ops/s, hits latency: 51.542 ns/op, important_hits throughput: 0.809 ± 0.015 M ops/s
>> local_storage cache interleaved get:  hits throughput: 22.981 ± 0.487 M ops/s, hits latency: 43.514 ns/op, important_hits throughput: 6.465 ± 0.137 M ops/s
>>
>>         num_maps: 32
>> local_storage cache sequential  get:  hits throughput: 13.378 ± 0.220 M ops/s, hits latency: 74.748 ns/op, important_hits throughput: 0.419 ± 0.007 M ops/s
>> local_storage cache interleaved get:  hits throughput: 16.894 ± 0.172 M ops/s, hits latency: 59.193 ns/op, important_hits throughput: 4.716 ± 0.048 M ops/s
>>
>>         num_maps: 100
>> local_storage cache sequential  get:  hits throughput: 6.070 ± 0.140 M ops/s, hits latency: 164.745 ns/op, important_hits throughput: 0.061 ± 0.001 M ops/s
>> local_storage cache interleaved get:  hits throughput: 7.323 ± 0.149 M ops/s, hits latency: 136.554 ns/op, important_hits throughput: 1.913 ± 0.039 M ops/s
>>
>>         num_maps: 1000
>> local_storage cache sequential  get:  hits throughput: 0.438 ± 0.012 M ops/s, hits latency: 2281.369 ns/op, important_hits throughput: 0.000 ± 0.000 M ops/s
>> local_storage cache interleaved get:  hits throughput: 0.522 ± 0.010 M ops/s, hits latency: 1913.937 ns/op, important_hits throughput: 0.131 ± 0.003 M ops/s
>>
>> Looking at the "sequential get" results, it's clear that as the
>> number of task local_storage maps grows beyond the current cache size
>> (16), there's a significant reduction in hits throughput. Note that
>> current local_storage implementation assigns a cache_idx to maps as they
>> are created. Since "sequential get" is creating maps 0..n in order and
>> then doing bpf_task_storage_get calls in the same order, the benchmark
>> is effectively ensuring that a map will not be in cache when the program
>> tries to access it.
>>
>> For "interleaved get" results, important-map hits throughput is greatly
>> increased as the important map is more likely to be in cache by virtue
>> of being accessed far more frequently. Throughput still reduces as #
>> maps increases, though.
>>
>> To get a sense of the overhead of the benchmark program, I
>> commented out bpf_task_storage_get/bpf_map_lookup_elem in
>> local_storage_bench.c and ran the benchmark on the same host as the
>> 'real' run. Results:
>>
>> Local Storage
>> =============
>>         Hashmap Control w/ 500 maps
>> hashmap (control) sequential    get:  hits throughput: 96.965 ± 1.346 M ops/s, hits latency: 10.313 ns/op, important_hits throughput: 0.194 ± 0.003 M ops/s
>>
>>         num_maps: 1
>> local_storage cache sequential  get:  hits throughput: 105.792 ± 1.860 M ops/s, hits latency: 9.453 ns/op, important_hits throughput: 105.792 ± 1.860 M ops/s
>> local_storage cache interleaved get:  hits throughput: 185.847 ± 4.014 M ops/s, hits latency: 5.381 ns/op, important_hits throughput: 185.847 ± 4.014 M ops/s
>>
>>         num_maps: 10
>> local_storage cache sequential  get:  hits throughput: 109.867 ± 1.358 M ops/s, hits latency: 9.102 ns/op, important_hits throughput: 10.987 ± 0.136 M ops/s
>> local_storage cache interleaved get:  hits throughput: 144.165 ± 1.256 M ops/s, hits latency: 6.936 ns/op, important_hits throughput: 51.487 ± 0.449 M ops/s
>>
>>         num_maps: 16
>> local_storage cache sequential  get:  hits throughput: 109.258 ± 1.902 M ops/s, hits latency: 9.153 ns/op, important_hits throughput: 6.829 ± 0.119 M ops/s
>> local_storage cache interleaved get:  hits throughput: 140.248 ± 1.836 M ops/s, hits latency: 7.130 ns/op, important_hits throughput: 44.624 ± 0.584 M ops/s
>>
>>         num_maps: 17
>> local_storage cache sequential  get:  hits throughput: 116.397 ± 7.679 M ops/s, hits latency: 8.591 ns/op, important_hits throughput: 6.856 ± 0.452 M ops/s
>> local_storage cache interleaved get:  hits throughput: 128.411 ± 4.927 M ops/s, hits latency: 7.787 ns/op, important_hits throughput: 39.093 ± 1.500 M ops/s
>>
>>         num_maps: 24
>> local_storage cache sequential  get:  hits throughput: 110.890 ± 0.976 M ops/s, hits latency: 9.018 ns/op, important_hits throughput: 4.624 ± 0.041 M ops/s
>> local_storage cache interleaved get:  hits throughput: 133.316 ± 1.889 M ops/s, hits latency: 7.501 ns/op, important_hits throughput: 37.503 ± 0.531 M ops/s
>>
>>         num_maps: 32
>> local_storage cache sequential  get:  hits throughput: 112.900 ± 1.171 M ops/s, hits latency: 8.857 ns/op, important_hits throughput: 3.534 ± 0.037 M ops/s
>> local_storage cache interleaved get:  hits throughput: 132.844 ± 1.207 M ops/s, hits latency: 7.528 ns/op, important_hits throughput: 37.081 ± 0.337 M ops/s
>>
>>         num_maps: 100
>> local_storage cache sequential  get:  hits throughput: 110.025 ± 4.714 M ops/s, hits latency: 9.089 ns/op, important_hits throughput: 1.100 ± 0.047 M ops/s
>> local_storage cache interleaved get:  hits throughput: 131.979 ± 5.013 M ops/s, hits latency: 7.577 ns/op, important_hits throughput: 34.472 ± 1.309 M ops/s
>>
>>         num_maps: 1000
>> local_storage cache sequential  get:  hits throughput: 117.850 ± 2.423 M ops/s, hits latency: 8.485 ns/op, important_hits throughput: 0.118 ± 0.002 M ops/s
>> local_storage cache interleaved get:  hits throughput: 141.268 ± 9.658 M ops/s, hits latency: 7.079 ns/op, important_hits throughput: 35.476 ± 2.425 M ops/s
>>
>> Adjusting for overhead, latency numbers for "hashmap control" and "sequential get" are:
>>
>> hashmap_control:     ~10.4ns
>> sequential_get_1:    ~13.0ns
> 
> So what this benchmark doesn't demonstrate is why one would use local
> storage at all if hashmap is so fast :)
> 
> I think at least partially it's because of your choice to do fixed
> hashmap lookup with zero key. Think about how you'd replace
> local_storage with hashmap. You'd have task/socket/whatever ID as look
> up key. For different tasks you'd be looking up different pids. For
> your benchmark you have the same task all the time, but local_storage
> look up still does all the work to find local storage instance in a
> list of local storages for current task, so you don't have to use many
> tasks to simulate realistic lookup overhead (well, at least to some
> extent). But it seems not realistic for testing hashmap as an
> alternative to local_storage, for that I think we'd need to randomize
> key look up a bit. Unless I misunderstand what we are testing for
> hashmap use case.
> 
> But other than that LGTM.

This makes more sense than what I'm doing now, and I think better fulfills
Alexei's request from v1 of this series:

    Also could you add a hash map with key=tid.
    It would be interesting to compare local storage with hash map.
    iirc when local storage was introduced it was 2.5 times faster than large hashmap.
    Since then both have changed.

I tried changing the "hashmap control" benchmark to just have 1 inner hashmap,
with max_entries 4,194,304 (PID_MAX_LIMIT on my system). use_hashmap branch
of bpf prog does bpf_get_prandom_u32 to select key. Results are more promising:

               Overhead: ~19.5ns  (prandom call + additional modulo)
4,194,304 possible keys: ~150.5ns (~131ns w/o overhead)
  100,000 possible keys: ~55ns    (~35.5ns w/o overhead)
    1,000 possible keys: ~31ns    (~11.5ns w/o overhead)
       10 possible keys: ~28ns    (~8.5ns w/o overhead)

So big hashmap with only a few keys used is faster than local_storage but far
slower when many keys used. Somewhere between "100k keys" and "1k keys" is
probably what performance would look like if a program which needed an entry
per running task used hashmap instead of local_storage. Close to Alexei's
memory of 2.5x difference.

Will send in v5.

> 
>> sequential_get_10:   ~13.8ns
>> sequential_get_16:   ~13.6ns
>> sequential_get_17:   ~21.5ns
>> sequential_get_24:   ~42.5ns
>> sequential_get_32:   ~65.9ns
>> sequential_get_100:  ~155.7ns
>> sequential_get_1000: ~2270ns
>>
>> Clearly demonstrating a cliff.
>>
>> When running the benchmarks it may be necessary to bump 'open files'
>> ulimit for a successful run.
>>
>>   [0]: https://lore.kernel.org/all/20220420002143.1096548-1-davemarchevsky@fb.com
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> ---
>> Changelog:
>>
>> v3 -> v4:
>>         * Remove ifs guarding increments in measure fn (Andrii)
>>         * Refactor to use 1 bpf prog for all 3 benchmarks w/ global vars set
>>           from userspace before load to control behavior (Andrii)
>>         * Greatly reduce variance in overhead by having benchmark bpf prog
>>           loop 10k times regardless of map count (Andrii)
>>                 * Also, move sync_fetch_and_incr out of do_lookup as the guaranteed
>>                   second sync_fetch_and_incr call for num_maps = 1 was adding
>>                   overhead
>>         * Add second patch refactoring bench.c's mean/stddev calculations
>>           in reporting helper fns
>>
>> v2 -> v3:
>>   * Accessing 1k maps in ARRAY_OF_MAPS doesn't hit MAX_USED_MAPS limit,
>>     so just use 1 program (Alexei)
>>
>> v1 -> v2:
>>   * Adopt ARRAY_OF_MAPS approach for bpf program, allowing truly
>>     configurable # of maps (Andrii)
>>   * Add hashmap benchmark (Alexei)
>>   * Add discussion of overhead
>>
>>  tools/testing/selftests/bpf/Makefile          |   4 +-
>>  tools/testing/selftests/bpf/bench.c           |  55 ++++
>>  tools/testing/selftests/bpf/bench.h           |   4 +
>>  .../bpf/benchs/bench_local_storage.c          | 250 ++++++++++++++++++
>>  .../bpf/benchs/run_bench_local_storage.sh     |  21 ++
>>  .../selftests/bpf/benchs/run_common.sh        |  17 ++
>>  .../selftests/bpf/progs/local_storage_bench.c |  99 +++++++
>>  7 files changed, 449 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_local_storage.c
>>  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_local_storage.sh
>>  create mode 100644 tools/testing/selftests/bpf/progs/local_storage_bench.c
>>
> 
> [...]
> 
>> +
>> +static void hashmap_setup(void)
>> +{
>> +       struct local_storage_bench *skel;
>> +
>> +       setup_libbpf();
>> +
>> +       skel = local_storage_bench__open();
>> +       ctx.skel = skel;
>> +       ctx.bpf_obj = skel->obj;
> 
> nit: ctx.skel->obj is the same as ctx.bpf_obj, so bpf_obj is probably
> not needed?

Will get rid of it in v5.

> 
> 
>> +       ctx.array_of_maps = skel->maps.array_of_hash_maps;
>> +       skel->rodata->use_hashmap = 1;
>> +       skel->rodata->interleave = 0;
>> +
>> +       __setup(skel->progs.get_local, true);
>> +}
>> +
> 
> [...]
