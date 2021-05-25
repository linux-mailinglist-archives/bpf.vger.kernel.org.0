Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80F639057B
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 17:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhEYPdP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 May 2021 11:33:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11380 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230433AbhEYPdN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 May 2021 11:33:13 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 14PFRoIS027495;
        Tue, 25 May 2021 08:31:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=fHW7EslREz0Ez2dXOni1EQSVMMFWRVs/F80j5fFg2UQ=;
 b=AiKrZC98D1Mn2zbo964kuJ9XCnwAzmpzZVJR4CMAewx7GmaVTX8P+053RcLxAXV6tgIl
 Da2tG6MFy960qwkdzKft8Yxgv9RgHNO6+jAGvxqY7a/yF0ss8aUz6a/5twrSyoiWxiVX
 flAe6zJQDtlYI+DFwZhpfRZt3cjCn7mQq9I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 38rjj25p1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 May 2021 08:31:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 08:31:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVUJLVNd3LlIt+pfGdvBus7/apDU3uJGeBWADM4T55RdiCVpVUH7dpkV693zALbkHqAX62kijJxUPIULyE5DdBr6zusGWHhV9Z83csdEAmaCUCRAPzXYlhTY9hWGFQ4vcvXi7BIvLk4A41CynVmubQ8b6RR6RBgdT3xitVBTXkhT2SzqED5fd2qatwFC4Nar8gRcSlj/9v4pwbXtvQn5vFSmIpZStJjTck4j/1ve3s2N9nJBPX5SG7dngvmrQ+H72mwSmg1Q/L6EABLZ3k8tnA8oLV2SpUv6CCVv7P/rFsmivZKDTsDpN0nR6ZR4DUYg7b0diMKWEh8GLE/eYsn8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVzyqMW1JLbz+U4YR5RPYMRBvX4H0OgcwymaDIvaL/8=;
 b=fGI6g1PziSNDokZI6i09K2GAsWeWYcROHiLC5cV+pAtNvpqbUtHyC8HCGO5k8k/clr9CIwqd5MOoxCXodKY6NOBdoD8u1Z3jKYbZyx23IrIpVYU11mC2HxYZNYW3ju529p6fcAQ9VmoNqB1ZDD1DoA28x4i6oIfiQDH59Pzq8m13Za5gzZGssyeXDe82wgbRVsFtby5nxINs4HUIXTjV+nAmVHK4AmbUZqK9qlcnlLASvf9QY5LiKuqZAA1a9NOn4yxB3F/PkRJRFryjuaKwd0wnyI+xRGYw2ZknmZ4KsA5/VmmLvKeI/4XuMA9RdqfSugv/Pztad1bXpvpyjBfxsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4740.namprd15.prod.outlook.com (2603:10b6:806:19f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 25 May
 2021 15:31:27 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 15:31:27 +0000
Subject: Re: [PATCH bpf-next v2] docs/bpf: add llvm_reloc.rst to explain llvm
 bpf relocations
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
References: <20210525152500.2061481-1-yhs@fb.com>
Message-ID: <4392b2d9-9643-00e9-c9fe-f722041adef8@fb.com>
Date:   Tue, 25 May 2021 08:31:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <20210525152500.2061481-1-yhs@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:6524]
X-ClientProxiedBy: MW4PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:303:8c::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1278] (2620:10d:c090:400::5:6524) by MW4PR03CA0129.namprd03.prod.outlook.com (2603:10b6:303:8c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26 via Frontend Transport; Tue, 25 May 2021 15:31:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c56905a1-98de-4e7e-0427-08d91f922953
X-MS-TrafficTypeDiagnostic: SA1PR15MB4740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB47408D83A7C3A623EB5BB5E1D3259@SA1PR15MB4740.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jsuS9cJoTpthvxjCQExefR69xvBAgQKjfx4POQgtoMgR8Kge/G0/Fpl1JhUqqj0MMxC9KLzE2HZoCeYR7rghlXVMxctds08DHdRWf+8/0CThVEIzFD5nSrFTtHf6WO+nJQkqi42zqb05Gk0VkampMc15A0DvcYahJNHrCi4srpicKCPVnLpBPYzBBktGRbSq/uZX+rUGGqxdvLU+1wk/3hKwuT94mfz6F0FSJrkFNJne+5tU2r124JFFaoGY3uG2zfk+5evEI62svzAWcCHtIRL3/8F5ifuFoKnzECR3PQzFBppYL8b9cwoHI0HKZXZz3/sRUttRnBUsDL79QAblv0QGR7vuHWuKRUGw/P4wRg33gj6Z4/kC9dtdVlBGc36WDQDzUfUAQomKI/xOqelsoOv63hHl1X9Krcy+Kaq0NeX9M5bjbrh2ilovd7Buxjoxae+ZbCiDDkRUfXf151k0AiazYUKm/xXimvlvNFusIahGeW+SQuksJQtUTO7GGkEmStMzMzLU9wFOsdnxJsvqQHasQkDKh0L2+55YFhW6Sdu12cTXlOBVywF/sj6MCdE17885HLMv4wO1A8RQ/9gEAsvqCsAH0Hn05M+NocOQo54dYuC2WWoHFYdxzGxwWNgTYLAzBQu8QaqWyFLABCfRzrUIh6DxzUfmf8cX0iJ1kjIs+7wNNDIPtl5uZAy1Y0pAdbAGUzGJdttTemFtmhUT9M/u4iT9bloQC9HOJceUbpUxXB+KlQHaQnqpW/X1840dr9euKGnl38YXJLceSUZ2QDI4EaN8DyiesJ8AZPc7CpGySL+ROg81VbmqccDuFTIe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39850400004)(366004)(346002)(376002)(16526019)(478600001)(6916009)(54906003)(4326008)(38100700002)(6486002)(316002)(5660300002)(53546011)(52116002)(186003)(86362001)(36756003)(83380400001)(966005)(6666004)(2906002)(31686004)(31696002)(66556008)(8676002)(66476007)(66946007)(2616005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q2RndlZjaVpxTFBEYmlwakJNWGQvL0xHUG0wWm5zQUtSam9ZREhXeXVaSGNS?=
 =?utf-8?B?NlBpNlZ3N2FvbHUzQXlkMzM4aGV1c2RhTitZYklnQjk2UmNodmFFMHBHOTZN?=
 =?utf-8?B?WGloK1l6ZVJQdlgyalJ1WFMvaURaYmhIcEgyczZXMTg5NjFtdmNRR3I1cXJ5?=
 =?utf-8?B?Q2pWNldadllYc2tMSVhrMWc1UFg0Nyt5MnIyT2ZIMC9XamdlNkYrWCtaRldZ?=
 =?utf-8?B?dzNhMUJmWHVmUEtHc1FpQ3dseTlHem9ISHgzdng1b2RIMForZ2p3NEZzNW1G?=
 =?utf-8?B?ZDh1RTNqc2RZTVVNRmxVejMrYU85KzdWd2FoaHp2VWpzTE01TlNqNFdrQ0NT?=
 =?utf-8?B?VzRNMlY2OGdKZHJGVUVyLytnRSs1S1FXR055U1h1RWxQcXJBRHFRWXp1NlFu?=
 =?utf-8?B?QWRIcnJkNktTTkNUN0ZGeDdiSDA2YzFvdVF0SkljNFFjZFRZNG9Oc1lpbFFP?=
 =?utf-8?B?SmlnUEFJSFFxRjJVeWZUeG02aVZZZml0T3VnM0dCWnluTjZZQzRKTWNNdGFY?=
 =?utf-8?B?czFQcllSbWdTMEV5ME82eDFHTXFGTElOS3RlZ2F6STBDYVE0VUF5UnhGRVl4?=
 =?utf-8?B?a0NTQUdGMUdHUkdiVmloalIzWVNTZFU0SVpxNlRsZHdmMG9jRzYrbC9vNEZQ?=
 =?utf-8?B?bnRMMi9hU08wVkcrcWxDOUh5ZjVsTURLOUliQWphYW9rc3kzUGdXTUovNERh?=
 =?utf-8?B?WHo4OHZ2V0xaL0VhL1VxYUtYMC9YZ082ZTNybWtENDUvd2pwNDUxVTdKWUZ5?=
 =?utf-8?B?QzRMaDRLQnRCRTVsVFBWMjdlLzcrMnliNndYazhNc0NDZkxqQUpvVzEvZGVl?=
 =?utf-8?B?amltb0dHcW1iZU16VCtKd1I5THIyWkU1cmREbmZ3MVNwRm44eVNvaDhOQ21m?=
 =?utf-8?B?MmMzRTBEbkVZUmxacnh1RDNvYVRtcEYrZ01qMW96c3dhcnBiYnY4NzRlSU1w?=
 =?utf-8?B?eUVYRUE1TnF5Tmhtc0NBQVBFOHBTay9MVTdDaHZQeCszeGxkMTJrN1BwUkNZ?=
 =?utf-8?B?WHJhS1A1bVVwbVdUV3MxSlVtQUJsSVFtbUhzTHBiM3hYRGo2dWczeXVSTVc5?=
 =?utf-8?B?dGZjSUFEN0ZZUHVHKzU0YWV2Mmo3Q2wzWkFhSm85UFY5QUoxcDd2U1F5VDY4?=
 =?utf-8?B?STBqbW1FV2pKTUI4NW9PWnk4VWhNWlFST1d2MThyazVvTStLUzlyRzBFNE03?=
 =?utf-8?B?VHNwTjNVTXA1MHN4ZEZWZGJsa1BIUEMxSjJscWhuWCtCUzZ6UDFqUXptcGlJ?=
 =?utf-8?B?V0R4QzdNbVQ0bmNuS3JUNUJQTWxDZzJyclJlclYwYzNVQWpYWm5RTWY5bk1N?=
 =?utf-8?B?M2k4NCs3cS9jZzJrdkhrYmxvdmlFWkUzTzVBN3o3NzUzYVpBbVM3TURtZmNX?=
 =?utf-8?B?czRWVkNIOTgxeXlobVFHV1dta08yd3ZhTmxXUXU0WTVaNUtjMXJtVGNKeWpC?=
 =?utf-8?B?VDZJYitoVElwRlBRVnZlL25rNG1UcjVmMVJCQTBReWhHbVdLdXBmWno2dXg5?=
 =?utf-8?B?elhwRXRBQy9iNWt6UVZDZGhpdTEydU05dlFqTjcxMEFveFYxVUs5QUUvd1VI?=
 =?utf-8?B?RzMybG1yUnMzUUxqL3dhRTNEWDhxV0RBTlE5UU5sTXd4VndmcXdZZVNvbHJH?=
 =?utf-8?B?YXdFZVVrM0U0a1BrSkpnUW54ekVlRytSVnF6dmFva1N1MXV3aE1lOExmODNy?=
 =?utf-8?B?endvNUZqeFd6dEpKYVo0QklrdDlPZjZLNTdteFcyV1Y4SnVIVjFvM1ZFd3ZO?=
 =?utf-8?B?aTlmNUk4djBZZ2xsZ3gzbmYzMkcrZWhubTY2cjJuZWQzZy9lZHhOc2FOM3NN?=
 =?utf-8?B?YnloMnh1RHBadWU1a3Y4dz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c56905a1-98de-4e7e-0427-08d91f922953
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 15:31:27.0147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ys82UcbCUzuMnJuMpCDblGz4aPlEuJLkriUTYzgsHGs1pnWntE5fQ4UQch47upxy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4740
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 33xSSRQSqdXkm_Z6AbMwcbfEzVyWk_Ka
X-Proofpoint-GUID: 33xSSRQSqdXkm_Z6AbMwcbfEzVyWk_Ka
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_07:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250094
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

sorry, please ignore this one. The same patch has been sent out last 
night. I may have accidentally deleted it from my inbox and didn't see 
it and so sent out again.

On 5/25/21 8:25 AM, Yonghong Song wrote:
> LLVM upstream commit https://reviews.llvm.org/D102712
> made some changes to bpf relocations to make them
> llvm linker lld friendly. The scope of
> existing relocations R_BPF_64_{64,32} is narrowed
> and new relocations R_BPF_64_{ABS32,ABS64,NODYLD32}
> are introduced.
> 
> Let us add some documentation about llvm bpf
> relocations so people can understand how to resolve
> them properly in their respective tools.
> 
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>   Documentation/bpf/index.rst            |   1 +
>   Documentation/bpf/llvm_reloc.rst       | 240 +++++++++++++++++++++++++
>   tools/testing/selftests/bpf/README.rst |  19 ++
>   3 files changed, 260 insertions(+)
>   create mode 100644 Documentation/bpf/llvm_reloc.rst
> 
> Changelogs:
>    v1 -> v2:
>      - add an example to illustrate how relocations related to base
>        section and symbol table and what is "Implicit Addend"
>      - clarify why we use 32bit read/write for R_BPF_64_64 (ld_imm64)
>        relocations.
> 
[...]
