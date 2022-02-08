Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EDB4ADF06
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 18:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383825AbiBHRMS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 12:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383783AbiBHRMR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 12:12:17 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45189C061576
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 09:12:17 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 218E772N028621;
        Tue, 8 Feb 2022 09:12:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=FSoqEmJMe8nl5sRzWKXW05uL5FbniUcNXR5Sxle7EN0=;
 b=ZPfQUDG5z0o/vK3O8p6X16XpT0dayKwP58OORwqTLbAKemgIcd+V2CQUIFyETN6s5pRc
 y/ZcVmoFgdafqztzcCUzhAaa4YlTGLzxnU52SVOzU55vKolmHdPNDxGyLm7bXvRgMJsu
 42rp91YlfIoDlj86xGVQvk2GuRCSfIWwR1s= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e3ak7eh3f-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Feb 2022 09:12:02 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 09:12:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8sMNGdLTmxQQ2FuBrmglGjaS/cpKcs/6WjFdrkFJsVcFi0SQuL9cFFlKK0NQD3ukjTpxKQRkTChrpoiXVjOhNc3Pj6LQjhkaFT3sob6LA2RI2GWrfI6PpD82VCGVrqzrwp4m09vB1Y9FJ56ZhRNucOuGPJwZ92OoQK0PCgYkKL4F3cqcArWTtE5oTq4BKymxbjMsVBsIXAJKPhwXdYvGar8fEqIlydWz5YAW1x6uyijf7/+blNOUTrK6LkrPjoHs+VX7brqQrHqfJj6CKpyIUyucywS/ugx5/Xctw0Nv5OUc3F4Hi3wyEmGgD+Y6vPbrjdD/GVNswLFTZlAV0zHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSoqEmJMe8nl5sRzWKXW05uL5FbniUcNXR5Sxle7EN0=;
 b=VfqHLVHWF7fO9FfbN795AyMLx2ccfLeC6qAJytFcoo03VZXK1aEqUx4uS3ZQuhfkrvC7BctMqbGnGuLeIz1AQko1acf4OzGFlOQhcOJwJH69S0uTjGvceZ6tjWedolqJ9+h0fiCjMtux5O0dsHOXNLI+70VnpAgYDrpOqxEJ2saaw6SgpMe0hhNLK8aJpsXMFyRDL8DVhczSSk0eirZDemWAT3R68xys2YobiyLAuGaITJVdXHEp70EeUvmaPzPz1DcpYFq6kg3fF0I3JAtcA3nOwA28oxIAG6i3Ag5CLkqRdMlaYsgSB8Wi+lXJPOzcVldJNxxtvWj5jh4mP0UaPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by DM5PR15MB1420.namprd15.prod.outlook.com (2603:10b6:3:cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 8 Feb
 2022 17:11:59 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b%6]) with mapi id 15.20.4951.018; Tue, 8 Feb 2022
 17:11:59 +0000
Message-ID: <45a1d67d-e269-5790-9713-bb3704c7da36@fb.com>
Date:   Tue, 8 Feb 2022 09:11:56 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH bpf-next 1/5] bpf: Extend sys_bpf commands for bpf_syscall
 programs.
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20220204231710.25139-1-alexei.starovoitov@gmail.com>
 <20220204231710.25139-2-alexei.starovoitov@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220204231710.25139-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0082.namprd15.prod.outlook.com
 (2603:10b6:101:20::26) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d089d8b-29b2-4f20-3c1a-08d9eb261da8
X-MS-TrafficTypeDiagnostic: DM5PR15MB1420:EE_
X-Microsoft-Antispam-PRVS: <DM5PR15MB142071F03481D14269B6A827D32D9@DM5PR15MB1420.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0+al/2ZqaooFXgm55ahkyIxUXjDopwvyqDaix0mlTqD9ngf0pDkZl1krLrZRS1i3rKHD2xqx6tJwq2E12y9S673vYHCyK+/SStUq1vLtCBL2XO0K94mPSx5a369cWIumT+i51tUw7Bt6nyGnlZuoncWqsXMkNNiZrw/UuSjqggtB8gxDLEUzM6wYy2+77mFhIPpemWk0KhtPOzfxOcccIFhP9rLKDW0xiP1lCT8jY0tk4hzoCkphK+1a1x44GyiqBcnPOKYsVkWvCf8zp8QRYeTS6ODP3nkU7n8vKhH54P2eteVUGP3af0lezxI34dQds94zDIhSEJSgCF43m1V4XTJqaFYQfDmLFhl30gyMyqe2JjWWoI/v2lDPh2VV0CVArlrntY3+rtxnDcn2lwCV61PHzNSvmWv+y0q6gwcPFXf5cR8cM/zwlG+lyGnBU5SNz1hzN+ebMLB3Y2w+esZ+zcsj/1E3L1U0NkqmM3LyajaKnYCwqX6SpKlSDMkV1qExYBxGp7dSWrQOUw/PNLA/TGwrxKC2be/Vke1iJQIm1UJUrbZJBQvgBNfYoVSfgYqSN8YDIYZeJskYiPAS71WqgfCXL/MZApoMPImnpHLV3J0adAlD2sBfKSWtv4Op6pgKKJN/zvVuwt6p1IbDa8WvnzVQhN/EpNJDVkA6NzLmO5YX6BzGHjW0HsV5gIZP6gPxROBR5Mfr2FPO1DxhDVSzivRHGPSUgaNaB3wVzIQrNUiub9I2wEDurVbuPRgt9hn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(4326008)(53546011)(52116002)(8936002)(66946007)(66476007)(66556008)(6486002)(6506007)(4744005)(2616005)(38100700002)(5660300002)(186003)(6666004)(508600001)(316002)(31696002)(36756003)(6512007)(31686004)(2906002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkE4N0NjcnVQMVZVN3RxWHJrRkFpL1NNYTNsYThjbUZOSXVyUnFyMldaaC91?=
 =?utf-8?B?SXpEOWFqdVZMOVJYbnRIb2tYOVBORmhmamhzeldJRnhpSEZFdDMzbU5oNU8v?=
 =?utf-8?B?OW9jY0s2WkhwVTVhOHBtOU5GRCtMcW8zcWwyMWtsRE8yaEd3UFE3Tys0NC9p?=
 =?utf-8?B?WlArNm83MkxxckpMa0V4cFZLUy8yM1FVRzJNTk5XL3R5eE9vNTZaaWkrS29B?=
 =?utf-8?B?NEVFUzJBSDBHRjFxYXc4QW1RYU84L0lTK1dwUG03TkNydWZ2ZEtaT1hxOGF4?=
 =?utf-8?B?YzdvZytsRGlud2FYclZjWHNpWWNkSVcyaEZyYUdSZnJGNzVZUjliejFyRFp4?=
 =?utf-8?B?bll6Y0RhTnJvQkpqcmxpSVRDQlNUYmpLMEF1aThSV2tWcnVzK1pqckdjcUl6?=
 =?utf-8?B?WE1ZREx4RmVMaXo3akhMYm9pNkxYcVp1d1VZWkRrMk1mUVp4NE4yQThWc0Rr?=
 =?utf-8?B?Um9xY2dsT0Fidkl1cnJiVjBqQ1cxTnRGbDNua0ZubmVwWDNRR3RzWFZIdHlx?=
 =?utf-8?B?dnNBQzhrTGMvdUkzRHc2NWtGS21VRXR0ZVRoT3ZsL2dhRjdFQjYzcGtyMFBu?=
 =?utf-8?B?UnRoWGRuZ3pRckVOMG05R042VW9OODIrVWJrd1o0QzZlc2d1cCtLMGExNWxQ?=
 =?utf-8?B?b1VqRDhZaVdpS3BLU0E4OVY2aDBJS29CRTVvYlkxNnJxWmoyU0V4MTRjWkFV?=
 =?utf-8?B?VFI4NXRSazhQejRySlhjZ3hRVFRncWpwVEI0a2xyZEZpMm9SWk13WjI5ems2?=
 =?utf-8?B?VktCa2pRM2YxSXlhN0k4UlcrSHYzRk5FdURqbWtsMkNQN05ZT2MzVUNYVzFC?=
 =?utf-8?B?R1JYZm5uM0pkQjVBUXdBYzJuSG9yRWg2VnNTZDlVSWRVMnVCRm1JK2RNVFNY?=
 =?utf-8?B?a2Q3UzNCYkFZMm9mMGJVM3JTQjVqS1I5bmlPbkVMUHRtWkppT2V3OXd0OThl?=
 =?utf-8?B?VW9aS0VWblp6RDNURFIyZS9Lb0pmVmRkS1VQZ2VleDBGb1pOS1REN1JQTDl2?=
 =?utf-8?B?SWhCVVFIcHg5MVkwVXJEd3V3K3RwVjIzTFF4QkxIaVhOZzN4K3BqZmxQd2JL?=
 =?utf-8?B?N2FudlZJYjdsZXZpT2VwZ0lkSjd4NThtdk01UDdYTmQwbFhKZnpaZGVtVkUy?=
 =?utf-8?B?SGYzSXovSFlGSVlRWjRnTGVvK1ZUZ3dOb0NKdUhGZ3NEdDc3TjBZTDJ1MXF2?=
 =?utf-8?B?Wi95RHpYdGw5LzVzSlFTUEJ0WHdTMmQzeThhUEdXUWdXMGtmTXh5VnZ2ay9O?=
 =?utf-8?B?dndSYTJHS25pY2UwdFFYekhSOUpsK2poQ0hId3VQUVA0bjBjZVZxSFpkSTRs?=
 =?utf-8?B?UDlKWkhheGpGNGUwcHZHZkNLaS9Ka1V4OUhzV3Y2ZGdSbVJ1aXlsa2Rxb0F1?=
 =?utf-8?B?UG0yQUxwZUxvMS9MT2pUVFBUei8yUzJrS3U5Q2FEb2pyc2xtand5SDhzcTNU?=
 =?utf-8?B?U3lkdzdHc3FUajRRV01ldlUxMy9RczZQc2xPOXYyejQzOVBmZFUzbEMyeG5Y?=
 =?utf-8?B?aS9RYytDVnp1SnptQjhLZlRmUUdybnJOQjExM0NjQURmMDJGeHJ3SmwraXJm?=
 =?utf-8?B?eXNUcjhYREgwRGhBZVFmVUFwNVFQTUVxYTBuUEFxNVhIUCtwR3ZqVWJkVVRF?=
 =?utf-8?B?ZDdVV0RlTFBTaUdyS2JzTG5sMERxaTcrK2RJcjR6ZzM5aE14TENTSVFSa0tv?=
 =?utf-8?B?RmNZbnVjekVha2RITTJENnhsRXYxbG02YjRlQ3lGNkU0VXIweThBTjJDYVY0?=
 =?utf-8?B?SW1FaE43VWxXcUVkSlhSUWJ1S0MwS0s1OWpPTjhxU3MzQndNallJQjUrWEJo?=
 =?utf-8?B?SVQ2QktVa05JdlZXWUdMc2dVNURRMHNhVnlVY0xzZUpvR1dXMzNSUEo0SWNh?=
 =?utf-8?B?Yy9oL2M4T3JUVzZPSjRvbWFLNDluMDNUU0JOckFxWHdSc0Q3YXR1LzNQWGRB?=
 =?utf-8?B?L25YRENybW9Xalp1MXQzRDFMRTEva0pab0Fad3JreDdQL1VhdlQ4YUVPdjc3?=
 =?utf-8?B?UUFyVVIranR1c01FbXdNckdUazlhTmpoc3Z5THNmNE0rUE9RRGpEejROTlpL?=
 =?utf-8?B?eDJYUmlPZDFCZS9NN0ZEWkxDZGFVT3ExOGJlVTI0Ump2R1pSdVQrZU53NGpw?=
 =?utf-8?B?MEROeC9VZ0hqSytjNmQ5K0VnaUU2MjJad2lDY2NZR0pWazBQTXlaSURnR1Rt?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d089d8b-29b2-4f20-3c1a-08d9eb261da8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 17:11:59.0203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWqvRntzpjS9m5IUhPZs/Kbu/P9Xj/M3diaW1r/lxQ6MVhPpcn5TK1T+limoyNdc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1420
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 9DbaPfekNG6WmmSEYUbczBwfJIq1fq5W
X-Proofpoint-ORIG-GUID: 9DbaPfekNG6WmmSEYUbczBwfJIq1fq5W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_06,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=592 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080103
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/4/22 3:17 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> bpf_sycall programs can be used directly by the kernel modules
> to load programs and create maps via kernel skeleton.
> . Export bpf_sys_bpf syscall wrapper to be used in kernel skeleton.
> . Export bpf_map_get to be used in kernel skeleton.
> . Allow prog_run cmd for bpf_syscall programs with recursion check.
> . Enable link_create and raw_tp_open cmds.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
