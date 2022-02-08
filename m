Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27ABA4ADDF7
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 17:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382045AbiBHQIz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 11:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382709AbiBHQIy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 11:08:54 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4DEC061578
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 08:08:54 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 218E6iWZ026701;
        Tue, 8 Feb 2022 08:08:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=tv2w7cGPej5JFtwEkqqvMrfVrhBDAXgSIPr302qz8Mg=;
 b=nP66V7yfLKrA2k8zxSI+mbaJO2r4dJJ0t1vToZNTWvdJdLCBExKJ6BSKDpFtpZvkAPRh
 naU0K+4UHa7JYcrq2jNPUS4pj+DCnjQp3Gx2rRHUOotPvpfkKKxJCYePamQf+tWmrwjf
 y+OJcBghmS8g8CjfiGJS3eIX9Penhhenc/A= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e3suxrxg9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Feb 2022 08:08:08 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 08:08:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJD1ccDGV1nCKE4EEVzFjgKaTbtr0A4cAyN1WGh+d1i6MljmAIFSQBBqTvgpb4S4sB2VdzqsgSQzE2q80RtU2vvTy3+3YMIy8u0FobAEfQnENWFhKvQ6xrYZW/v/Xlm06nOPw0Va5pMucUoM6JLMy7ThwDV22GUlUnCJON3iMGJ3wNYavUocTB3WCmW4sRQ/9SK6q1Gfa4agfd0KnGL2XDy241f0RTQJp+edL7QB32qpnr8vYtHet7nJK8994yv4BXUIuEhABxiw7KC5dwusTZpZ9dDGKeKeqKKH1VQk2A7qD/RkoeakZC7i6TlysRnl40U8mphrxMlVHD7lVQC34A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tv2w7cGPej5JFtwEkqqvMrfVrhBDAXgSIPr302qz8Mg=;
 b=RjuusQdaA1NvQfumK+q/Ej862vi5zyGbUHcoWq2Ukhu3XK82IuRJZhL28Yb7qNbkFz8u7QHbXmYwlz77kxWewQI6+wy1U+Wc1qLrw+FrYOcrcGP1hvyDxRdZrP3cl5plFwnNOhubGE/dE6ccATk8QJGTpwZ3AByYhMonhgSoC8n/+n3DTmlESXA/d01+aLKZZlucy8vjPfIzeWNM+AnJjSBF4Bo8j8GtBWUTQOhgCTV37VmHtvwJ0YhQqmmfI4AUj6bdTjzAeuV/QeyT/ghj5AWBIXnGR07IgnW9RP6v+OgC+HdnUIBAVU3E2vGNUoOzalwsdzPr30fbrvwLgXFu5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by SA1PR15MB4918.namprd15.prod.outlook.com (2603:10b6:806:1d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Tue, 8 Feb
 2022 16:08:06 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b%6]) with mapi id 15.20.4951.018; Tue, 8 Feb 2022
 16:08:06 +0000
Message-ID: <f003ecfc-fe99-0937-8798-e694e98f41ec@fb.com>
Date:   Tue, 8 Feb 2022 08:08:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH] libbpf: Fix signedness bug in btf_dump_array_data()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, <bpf@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20220208071552.GB10495@kili>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220208071552.GB10495@kili>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR22CA0006.namprd22.prod.outlook.com
 (2603:10b6:300:ef::16) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dad863a-fc89-4a82-198d-08d9eb1d3117
X-MS-TrafficTypeDiagnostic: SA1PR15MB4918:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB4918D43D157CEC7CE4AFBA75D32D9@SA1PR15MB4918.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1bDoBuJk1tbMcDpEIoFHAo2av4Mv++UxWc7Dj/93311ufyz4918wzhXhHepuMXCONtNMft8An8m5zxfzC5bfPsgL1AZfbEeLH6UWkDbXzWvBMnhD3MUubp4S4UnEOEu7vsRrzNgam6snSNPn4Z0/tizH1vTwsfYWVRQAsOuYrIn1FAlHKjDW5IToDAtNVpMpIozu1kI4ktn4u70rS/g2AXcPLuRy7HzMtiOMqZkbYQak3lXb7ghXu1yvUgWaS9meQniuVuDFK2eOGOr5T2VoptwfsJxLc39vsXoAKKU82TcGe148Xud8AbSSkk8X3uIvVbRNP84WDJ9ByOgF6EImwBNkKzJPrHrc8/GPYsb1y8e/JEBlq9GrUss0Erb6wCKjHY24T57Wo1qhytfMSud4yOwVTpc9uapqKcmfW27mimmh/v77+kuPhwnafK7LvYjXfAHxq7dg4aZsQKDsQ/8q4aMA3ogLQ37nS1w24NWWkaS2IEwcPlIjPzUsDl3yRJR84DLu0r/YIGHh0xdto7ry24QN6kZHPdO8XxjHJgE0FO2V5wkB+f0dBf63rKztOMIcS+4RMHefYtckd1ex8HkUVsK41hE1+qcyMu4HV0mVcGsGJDz5Qgez1MltDzAcmd+VpZj+ft1octOYFl4qM46VzsEmoiLXmTDqgV0ymIgTrPoO1Ii5SQ1SjYdgA3ztWOAortn4cNYHaMzFtNQeLRRqzKaTZWeqnWeQHJS9037Ai4Ms4G92xT3gdOnuW7Wg2dRY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(86362001)(31696002)(38100700002)(54906003)(66556008)(316002)(8676002)(4326008)(52116002)(4744005)(6666004)(8936002)(6506007)(66476007)(6486002)(6512007)(2616005)(2906002)(31686004)(53546011)(186003)(508600001)(110136005)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFg2ZFEvOS8wWDNwZHRSZHNMZFhSajhZRDU3RVJUOFd5c0t0cHZBSmNSWlo2?=
 =?utf-8?B?SWJiTFR2UHVxZGdoYkNqeFFDQ3U0azVwdkRBNkczanphK0daTlY4ZzdDQ3JX?=
 =?utf-8?B?RE5sZ2ExUmhCL1B6Um92S1JlMnI4ZzRTczJSL1QrV3YvTUtIdE42c3F0dW53?=
 =?utf-8?B?amMyVndqa29tUjkxbGdOVmYrS0QvL0tRMG55cjNIRWlJVmpHdGdYdy9GRmd4?=
 =?utf-8?B?NVF3Rnp4Y0hCcGhBUkZhbVVuSWF1UUNUd0NFU3hzR1R0dExqeXE4UUxUMlhz?=
 =?utf-8?B?OHJRbnJkT1VKM2ppQWEralUwam9waFROTzhXUDM4UzN1bkNMN2dwc0U0UzQ0?=
 =?utf-8?B?TFg5NXA1MjUwR011M2NqWGtFOTRZNXNGUVFVczF3N054ZjltbHV2cmk3Y2lK?=
 =?utf-8?B?TVR1Q2JyL0ROcDR5aVlXL2U2L1JNZkYyaDRCd0srZlQ4QWRxbnpWNEVFQXdU?=
 =?utf-8?B?TlhvaDlYNHVlSGl4WFRobVJPN0Z6dzQzaWtDa2owaFlSRHN1Nk14U1RTdklG?=
 =?utf-8?B?TFFGZm1abXNwdVJ5aEN5dmZ0emU1eFJzSWY0V0FnSmVZaEE4RzdQb0IzTnRL?=
 =?utf-8?B?U0VqeVppM24zZHQ2T3dzckRkVE5rWmVJSWxId2h4ODYrRm1yVGZKSmpGWE9F?=
 =?utf-8?B?MzRtcDlJK2Y5amJSRTV1Zm5RSWxzOXBSN2NMTFNyZXhIZS9yUllDdU00Ymxt?=
 =?utf-8?B?YVh0a3UyY0xXaWVlaFVyNkgrWit5WDVzaHZRT3BVenZWbGZSY2lkdUFHMWdI?=
 =?utf-8?B?U2oyRkRvVFhKd1RwZGNZS21Hc25oNlQ4Q2xrWjNqbC9weHJxcVp1SVVmeXpI?=
 =?utf-8?B?ZVVSbW4zMnJockJoZE1aaC9UTzFzeTlEWHhJbWhlTHFJY0tPc0FlcHBXekpr?=
 =?utf-8?B?eStnTFY0QmdIbDNZdVYyZGlxKysxR2FPaHZ1VjIvWVN2K0M0TkJsN05UaWhp?=
 =?utf-8?B?cHQycDJmMnlsT2hEMi9sejlQcWFxMm0vdkFpNkw5M0hIOFg3QTUvUitGczdq?=
 =?utf-8?B?SWVlRHJmcFFPQTQ1UWpFSXQ1cC94OWtSWEY3ZHZ4bEhTbUp1S0trVzBOY0xJ?=
 =?utf-8?B?RUlIb3ZBTzRRb0RwTTlTZnRXZFlKdVBYTXJTTjVacGNQYXBIdWFlWG5pemdT?=
 =?utf-8?B?TjkyVG4xODl2TUQrUmpzMW1tejN5MmFKTXZpNVVDNXEwVlAxZDFjeE83M3Jo?=
 =?utf-8?B?c1c4L3kxek9ObTBKK3JrN3huWm1KaTZISTdFZnQrZW9xZU9mbEhzNlYrRnFY?=
 =?utf-8?B?bzRZQXNkRTl3YXdxaTRSc2VFVHBXaVVLTzF3MGZRK3MrVE93YlZEbW1tZHk1?=
 =?utf-8?B?RUdDWDBOZU9raUphb1FIUTdYRjZSaVE1RUI4RE12MzZuTktRUjB3d2VjdnV4?=
 =?utf-8?B?d1V6aUZMYlA0V3VOUjBVRVRCVjhETTRjUWFMYkhQdWRwYjl6TkFvY0ZZTlpO?=
 =?utf-8?B?byt1anp4S2VKa3JjcGh3SHJxOU5KQmZtOGZUSTZCUW1nMUJvUW1DcEdwck1W?=
 =?utf-8?B?V2wxQ2lqcmhnU0s3QUNuQTdFa3hRUkpOdEd6cWxZT2lLMFVqVitTVU0wd040?=
 =?utf-8?B?aklVUHU0RS9LK2tTMkFaSHhhQytTMWF3Mytqbzk3ZHo1Z1hneU5MRUo5OHpI?=
 =?utf-8?B?QzY3TGc2ZFAvZGxXdkxvbUFVbjZLMXFlMkNBZGduYXJ6aDR2V0luRzVjY2Fa?=
 =?utf-8?B?UmxMbWdZaXkrbUxKcVlFbE5zK1NMWjJ1UFhXSnBJMVpsRUowRy9UTk52b0Qx?=
 =?utf-8?B?VmZVdVcrc1UxVzRFMzdMV043ZHB5b2VLMFY1MWl1OXF5UFNkSlYwTjZsVi9a?=
 =?utf-8?B?TUszN1RYVjl2NTlPQUFNOGdTejJqSkJuN1R4bjBVUTgveHpxeGlETWQ2TXJG?=
 =?utf-8?B?UytldmVVZ3ZxZmdrS1p0UC8wcVFBQzFEbi9zOHBSTjZ0R3YwLzNzNnk5dFpF?=
 =?utf-8?B?ZDROdGFQTzJDVHlHNnlmeWxkTWhHK3gxRy9OV0cxY0l1UW9rNzJqVzJsSDVm?=
 =?utf-8?B?SVM4MVdFb0J6Z21yZm5aRzVibk9UTUdhZHRYZ3VCWkMzNkhIWWhPT0Q1eHB1?=
 =?utf-8?B?OWpkZkZvOVluQS90aFpFSU5PcmNoUElYMS9EL3R2Y0EwbUV3RkFUN2pINTdP?=
 =?utf-8?B?YWRUcktNYlVXQWN4cVVNcUxxUk9lSEZxd2U1eENlK29xL1BmanFKL0NWZEU4?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dad863a-fc89-4a82-198d-08d9eb1d3117
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 16:08:06.2468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vaw1mSMJPTzTAY43q1mtQsEV1wJ/wuhJrkL/oQ472M0+aGsJXomvpK38F/AVVqP5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4918
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: jL19n5M1AJWJU8PkexZa3nV9LCK8orwP
X-Proofpoint-GUID: jL19n5M1AJWJU8PkexZa3nV9LCK8orwP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_05,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080100
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



On 2/7/22 11:15 PM, Dan Carpenter wrote:
> The btf__resolve_size() function returns negative error codes so
> "elem_size" must be signed for the error handling to work.
> 
> Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Yonghong Song <yhs@fb.com>
