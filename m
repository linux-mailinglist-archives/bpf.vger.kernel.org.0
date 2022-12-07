Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BB66452CD
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 05:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLGEBu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 23:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiLGEBn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 23:01:43 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82AB2D74D
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 20:01:41 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6NZW6M019313;
        Tue, 6 Dec 2022 20:01:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=mA7iC5zXqkZ3h/B1mxcQIqaLcFnTp5qZsILfL0NuB08=;
 b=X76frXd3ge2M1OdIEfBnqSWLKBobiPsttQvTybTJxIR5yeOtxMvOGvijOsfEvMOQMBFD
 C1xAWEnQGwc5xiDO9WHvCuJuWkphk4R7i1G97QWwVp04Tu9A8UiaN/jUnVbCqp8Gpbsf
 l03GUfq65/uZuMzu3kLCfrNayTeUbYu6rZXpQfmeAhB2mjMqPw2f0DgrxifWOveATrLM
 9/WRDN6qv/P4LuQHODFM5eD5Mt1w+spdhclNsj2ohkle2rXL12SEP0tNOuN3UKqyclgT
 fqPkGAUwaOB7fgYDbE7URBNwMZwRefGOl4/a/tPA74IuHOPKDYbHl+v6X+JcjiEjulKC 8w== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m9nc03h40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 20:01:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTgKiexQFxztBIoY4qOlOQxD6uTZkBEOSmSHFSqXH/3H+3HOFNl896YaAqEjqRc81kQ4GhdTIvoyXMBuDlCOs+te5Ar+v/Wo6RvHvtT7iYHtcpmoENH0g6Of8N9xOMbvzj/6/mqwuXTzp/RLAsEQ4Ka7puna28mWH6xGFldP3u4h26dnyJI1gQcgYlKeb0SRJzDhzEMkTKIuhjce+9UqeGFjqIsw7PX1S7qy5gNoLFPH5uarqZJ9TTcBaI2IHKNuczbOK3iHU8HvSQgeimygsOjs2wBEA5yuzGfNebvl3VDcnvAkZLvtzqz3HFyKTvJwLPNSp58P0Kq6SD1L3cBXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mA7iC5zXqkZ3h/B1mxcQIqaLcFnTp5qZsILfL0NuB08=;
 b=GJpoCLK7k/u+KMFqYn1t5u/uXNvJpkDRKu9Fh0N8NmXRprIsr9pVk8luX5SkMv6VpBz4DpdyUTuK62PyLLeKgZJ5p04B4iQPw7DqktB7tucqC463fsyBToxk022tyYbUhbfUnSqiF2YIYWMBauqckP9a6fSXzI2Ii+ATZ/6CO+CO/T54KdiQ8G+Vez+ImG2TBbi3ZfERqyhMxSVawtebw9WHcKkUu6P2FlUUb1axqob6q4SJMwtYAsNLacIQjszRBDf7ljDjKzG7473EE0/ybAvhe1d2xhe3M/NTxd64bs0oTCqQ8zL60SUw2yCbxekBhKl4zITaErt8MozCs+ZOVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2613.namprd15.prod.outlook.com (2603:10b6:a03:151::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Wed, 7 Dec
 2022 04:01:01 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 04:01:01 +0000
Message-ID: <d2073c1a-6f52-d7a1-e8e5-3d9f2d3f4e19@meta.com>
Date:   Tue, 6 Dec 2022 20:00:58 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next 2/2] bpf: Skip rcu_barrier() if
 rcu_trace_implies_rcu_gp() is true
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
References: <20221206042946.686847-1-houtao@huaweicloud.com>
 <20221206042946.686847-3-houtao@huaweicloud.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221206042946.686847-3-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BYAPR15MB2613:EE_
X-MS-Office365-Filtering-Correlation-Id: 13159ddf-5381-4f89-7614-08dad807a74c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QHfYvVsb2DOSXiZV5lGLr5CwSqtRerZ0UmoFDAkZ9ckHU7BNqsSkWA7TSIxFYhlz/brp+ijVbpC0LIxYGGZA2EgicX2TC4AkqeUKCxIkx8fFEj+j2y659iK5AttoCjD2Mld8Xz9Y+2KM5d5U4+LSHVNRfLr6DSrfHCkMbL2A9jHcGF3+dpxW+BswkLdTJ4L16ex9KC93A4c/DiYKUlpJCUKsyDw5kJPpCpR6xASlSVjBZEispTHiVDmlah9of6wDJkNbE+mkH0IUUYHksMg0bqJSxYPLs8zDrPhwNszfruBNcWRwWsxVz95tJQRp75z9Guqnryez5FbJjiJl4KbFoLrKpxvq+hn1A+yI4jByLFxekcMblLKSJcjODDNQwG8wWsv+c8upkKbqffYtUxKZgKZL8sot9t8nRVSaqXFH04VPLqJYJ0F1ctTRmAMS2dsx9Wa1tbo5qqL48DNqoUYrmX0eXLow7qo1uVKNgI0PCPwpVZpcCC1JcMlgt/mNnKTyfShAtQBI0ayz9AAitp14RFEPaf/eZMKnBLSdpJtaoDr5aq+u1ielv9VUlkr/Ik7mLKgENJPWcLnBnfmE0JSOE34ujzRU4YSnw/2O/oQNpz587+ViXycl6RGpXPtqAsuR51GFMqx3AR5dnzm5zdoU0Uh9KHQeZ24RVs2PAJWzD2/8Uph8urP/eGPaWDfTdoHvStAaHDBPIfIh6CogUZsPZj4Cd9XMcfzoWbTNhvpNDJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199015)(316002)(36756003)(6512007)(6666004)(6486002)(186003)(53546011)(6506007)(54906003)(2906002)(31696002)(86362001)(66476007)(4326008)(66556008)(38100700002)(8676002)(66946007)(478600001)(31686004)(2616005)(4744005)(41300700001)(7416002)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REgyYzcrQ0d0dXRLOSszYkYrL3hvWUxLT0FXRFpzQTI4M0M0ZzByMVhrTVA3?=
 =?utf-8?B?ZFMyQjdhTEpwcEszMy94bW1TL1VMZHEwOEJ2WVp5VHptZ01iVmFOWVlpVHFD?=
 =?utf-8?B?TVdxbEp4djRYWDVkM2hVWGtGSnZkNVczM1NwbHFWQ3pTWlg0bkdLMW41Y0Mr?=
 =?utf-8?B?OFR2eXc2a3pvS0RkUlVOa25FVnJaK3YySXc2Q3RFQ2lQMm5PRmxRVDBOY0p4?=
 =?utf-8?B?eTJNRk9lSHFIZDgzQVBENnFjQmpSZVhhcmZ4aUhCVmRPaU5nWWJqRTVEOVVV?=
 =?utf-8?B?UWtKZnhSbENrQU5oL2FvNXZqS1NYNE10TTNHTHdwektnbjIveTVBc2xzNzVl?=
 =?utf-8?B?cERMN1FEamNVa1Y0SjNpN0FjTGxkT3B2b3RBNUQwN2pEZGtEQWgxa083eExK?=
 =?utf-8?B?SVZGL0JLblM3MldOY2RGNlFRSitIM3pHcXdLMUJNMWpYell2U1d4THh0RUlU?=
 =?utf-8?B?NUpQQi9IcGw2M3U0RTNkdHlzcmZISTE3M042NWxsRndRT21UMlpDdGhETE9Z?=
 =?utf-8?B?L0JhNGNURDJWOTZkV01MeHVOZEM1UTZJUVdvNVJDNG95N2oyaXp0b3VIdUJC?=
 =?utf-8?B?YjJVTjI0d084RUtXbXhpNThzWkkzL0E3M05EUHVJcktHUXlGVVhLQkFKTDU4?=
 =?utf-8?B?Y3BuTm5zZVErOW1ZWlROMDd1eUloSWZHUVVZMjl2M3BJMVpEUkNLMEl4TkdS?=
 =?utf-8?B?b2pFQ0FVWUV1SFRKWkdjMkJXUzRUdGlkOVk2UnhHTkZ0QXFVUFZ2MmZIRTVI?=
 =?utf-8?B?RE5oUkdIQnF2QVRmSlhEd0w1ZHZLbkdCcHJUa2pWdnV6VTBEbVpIMlAzNEE0?=
 =?utf-8?B?Rk9OZjNNS1ZnRWdmQVY0T1lZc2MwelF4YWE3ZStJVG9WNFBSVHFEQm9URVRt?=
 =?utf-8?B?UXppRDNnTnRPOThVRnlhN09UeVJDeTd5RWNvSkpvWURUUDFtV2FOMGo5RDlj?=
 =?utf-8?B?QW0xOEcvT0kxMjl5RDJSdjRkY2hhYlQ4OWNackpCUzBxeTRHKzVBKzluNE03?=
 =?utf-8?B?OVVnNXZOTXVxNGhJejIzWTREUHdjUEJzSFZDVzF2b240V3RXcmVDWjl1Z015?=
 =?utf-8?B?N0VzL1oxdXpoZTZWU0cwaFdOQi9qU3lha3VDYmJmVUZoMGluVUZIdVk3MEY5?=
 =?utf-8?B?bkpPdmJWYUtEek1UM1dqNEhHT3p5YVBFQVNBMjJrSXUwZ0hoN0NVUk5NdlNJ?=
 =?utf-8?B?V25iRG81T0hxODZldHpJUG9DSGExRFJrRFB5eHhDODY3RC9jWUJWMTMyTGJn?=
 =?utf-8?B?RGNtODIrU1czWXhvZ2kvVmUzQnRKVWhSK3ZRNUVoNmVRbWRVa053NGJSQkRH?=
 =?utf-8?B?R3YrL2tUSDFyNHl6anVwSVM3bkFFa3lUUE9DWUtaOGtCNHJPSERLSHM2cEln?=
 =?utf-8?B?TFhXcm14LzFmWGJybzRJZVBKK2w5bW9JeTVkOTErL0RPeEkrdDlBdVl0eFVP?=
 =?utf-8?B?ZTJYSXdvSXhJditDYmJ3MjZKRWJNTitPVDhDUUpXME12VnVPVkRBcEhxQ2pa?=
 =?utf-8?B?WXVhU2xoTGgzWHpTeDJZT3JiaHJjM2o3d1lMUlRxRFJCcUpMOFBiR3FvTnZx?=
 =?utf-8?B?YXdWZWFPSFlPTUFJT1cxUmYwVTZUeDNGWDZmZGtVNDRtc3hDN1dqc20xTW5Y?=
 =?utf-8?B?NFlBNFVWUVFkR2JJZC9ITlh6NW84WkY1Ynk5M3FwN2VmQm13TjhQSlhOK2lB?=
 =?utf-8?B?ZUFBYlRNV3J1eTJRWnMyRWNjS2FzQTNHeTQwY21CU1RyTDU4cE8wRVo5RkhR?=
 =?utf-8?B?VTZaVXhOVytWdnNuZUhEOGt2QU5tUzhZekJwWjlTS2w5M0tkVGpYVnlmMjNr?=
 =?utf-8?B?LzEyK3lFQVVYdU1ySjBGWGtpY1ppVmtad1lCTVNxQ3N1ak84R1NFaVNUUW5V?=
 =?utf-8?B?eGZWNTZvNStCWm04TG55bWFGbUx6SE5jVjVFSmtOeVdkYWlPWVhDZ2dKYWxv?=
 =?utf-8?B?SDkxbTdudTJ1YkVhZnZqWVREaTRwK3JuMXNvWXJEQjVlczYvMk1oQWFCd1JZ?=
 =?utf-8?B?K0F5ZE1WSm5veEZTUGRDVGhtTU1XSGNhTzJzMTB6ZEJlNnRNYWpzTzU3S1Nk?=
 =?utf-8?B?VGZ5V0E3STdtb0ZYTlZSWmg3QTAzWWNRYkRscUJWbVhtb0dhTFkwMHNVNnlt?=
 =?utf-8?B?WWZkSnZmUGdwNVo4MkZLQlEwOVdLNTN2c2dWMXYzNzhSblBWd0l2L21kYnhN?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13159ddf-5381-4f89-7614-08dad807a74c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 04:01:01.1085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bL0UdefkywrW3MlWdUOwVVD+hd3e2pcsIB1zf9Tx8i+2U7vOZXf0MZ1JOGc62a5r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2613
X-Proofpoint-ORIG-GUID: k-tn6yqDu6sh-KtJe_ecTsmycsi4_fjp
X-Proofpoint-GUID: k-tn6yqDu6sh-KtJe_ecTsmycsi4_fjp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_01,2022-12-06_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/5/22 8:29 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> If there are pending rcu callback, free_mem_alloc() will use
> rcu_barrier_tasks_trace() and rcu_barrier() to wait for the pending
> __free_rcu_tasks_trace() and __free_rcu() callback.
> 
> If rcu_trace_implies_rcu_gp() is true, there will be no pending
> __free_rcu(), so it will be OK to skip rcu_barrier() as well.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Yonghong Song <yhs@fb.com>
