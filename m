Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7FB35B60D
	for <lists+bpf@lfdr.de>; Sun, 11 Apr 2021 18:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbhDKQWz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Apr 2021 12:22:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30308 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236406AbhDKQWz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 11 Apr 2021 12:22:55 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13BGKe9i012817;
        Sun, 11 Apr 2021 09:22:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=9/TT/wx9SJ7olP7RCFuS221lRUUA/XO5FeLgNNRDNA4=;
 b=eQnD8hTmQRCSwiKNWnMxSw53CoCD6q4BVzZZNFdubSyQsCHLOFKn/YM+3WOyBHIjC4VI
 XoI39ESr3zhbEczGs7hd9Ml7TKy4m75iDM4FNhNPUeAU0G3bm28rAF02F0n4z7hmmfLO
 wKjzP8mlyAzmfFD5hrnGZ8qI4FIUpVlrORI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37u9ht4ryb-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 11 Apr 2021 09:22:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 11 Apr 2021 09:22:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cz2kq+a/e+2iS1soSTqIWJBEpwhKS7sJDUU/qprvkuKuZ35I3lDmcbPpGzwXaBllM1fuUbntf32zLv+22Z0jNR7WQgXc01r+yAY4Gh9De3Wb4x/FVQGOrMrMYYoyy6jr5N4fFJKq+wAct5HEXEkZIGV+BNndx/Lj/ywvNClaWeRFUROt28oCJVUSTfOu0xCxTZv/KZnQUZdOIqxcpvauCubkJN1QV3vaQcS9R5oZqjsHQLPqX//74e7wwAff5QAIs+OKc13mR5ZAsGtD0eRpyg8QmA5mbLwRHUeFNotK7L1WYIkgkx0azmpAhu87k+Z0Z+1qENaq2oXmlMTmFXhPCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/TT/wx9SJ7olP7RCFuS221lRUUA/XO5FeLgNNRDNA4=;
 b=Sgek39K22faZS7f5fBLCMLk+04f+Yqvq+ciCepROthMeERJE11gZ+lxyRCiuZvWfjYd0685lAhIQfJ2ujUU5KU7NDVwkRTnrEWm1YE6vPp8DXhOqvNRlFEdlL9XtefWhK5JuCVKxtenRGlby9UIN+30jaHY91OzW9cAhb1PBv4A2AuGBLGDE7xkv72lLOzI+T2+XDUI7N6DvJcfUKCX/izU0KgILqpLDFJjd7QzWMQsMfU7gLMwUc5cXnvCCFqLmtqOdwgzMNYA2i3ugJJ72I7+dslWWS7bmSuockR62uJC3m4gZlbIzcxwUSwgx8/xsbDiTwuKP23TkS+v52d5A0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (52.132.118.155) by
 SN6PR1501MB4094.namprd15.prod.outlook.com (52.135.92.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.18; Sun, 11 Apr 2021 16:22:21 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Sun, 11 Apr 2021
 16:22:21 +0000
Subject: Re: [PATCH bpf-next] bpf: Document PROG_TEST_RUN limitations
To:     Joe Stringer <joe@cilium.io>, <bpf@vger.kernel.org>
CC:     <daniel@iogearbox.net>, <ast@kernel.org>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Song Liu <songliubraving@fb.com>,
        Stanislav Fomichev <sdf@google.com>
References: <20210410174549.816482-1-joe@cilium.io>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <ef619573-377f-a6c1-3a2f-477d2284fa3a@fb.com>
Date:   Sun, 11 Apr 2021 09:22:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <20210410174549.816482-1-joe@cilium.io>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ec9]
X-ClientProxiedBy: CO2PR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:102:2::40) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::110f] (2620:10d:c090:400::5:ec9) by CO2PR05CA0072.namprd05.prod.outlook.com (2603:10b6:102:2::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.9 via Frontend Transport; Sun, 11 Apr 2021 16:22:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd2355f8-eda5-4250-1233-08d8fd05fba3
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4094:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB40945256BCADC653ED66905DD3719@SN6PR1501MB4094.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /84zSwd5E/iB8okeLK66MjMiLCAtmf7+41ed+GEdL+aaI0SFsBp2CJLmi6CzVLmZyVkJJ+xfGxFRIHInxnqLBERv+NAeIh3YmRBJNPQjOAyjKe+TRAo1XsvmXhn1krnewt32vC7h7U3JdgsT1y96zJ0cx/V/5esiwKe4YBTZvA7nVLdGF5kDfzoJy8vjo1PsZaeM0O3jrNcixBDD1itagmcxs6bn2oMhMxypCwP+nbdJ7ReRUtgx4r9WVSGEYPFNJrW6hzxx6u5isMyT0hDW/+VYhkF8m3jNT2sU9S8oIxyjYwpdY5BJ9xv6PnH7ohzbEcoJ5Wn/0pmstsWodhKBzBnSGcvKAgdsbVKXkIf1OeWvqUrgy1V8sY37u5XOL0i1XKJjt5PBverzwoa2EdhLSo+2XbQvVwUXgl2q844Hmhe+0PzdopS+t8YB1pEsHaqC8fxaQ+wfWYjnDuZgDsMZ3Z2m1BfJmxVCkL8QGDS3U8jLWXNvWbYYMW+Q+feUGW8Hi0265j2M9191nHsB1cD3wazha9G0KuN0Dx7aarXzvII3kNQu/M0vWC5oa4gUFwsN3dZWhOl+aR+CVnev9dbdYsIq62a70j2lv6pQ05dAo8eFwzrHmc20aY0EXttxoNivLxKKWWoB7gp8J3aoQ06jFZ9LF+Exww+U+hfwo9F00vP3crlO+DJvSQrjhUlWfPYZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(396003)(346002)(39860400002)(5660300002)(316002)(2616005)(36756003)(38100700002)(186003)(8936002)(54906003)(8676002)(31686004)(83380400001)(478600001)(4326008)(66476007)(31696002)(6666004)(53546011)(6486002)(2906002)(86362001)(66946007)(66556008)(4744005)(52116002)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YUVKNkg1bmsyVUNrNDF4cGdIUVBNclY3YjR3U3ZVYXRHVHBJbTF4ekp1M3R5?=
 =?utf-8?B?d3dNbHBrK29xd2ZWaGlEa1p0MEh6UWNxRURQdm5NS1ZtSHRXS3NzVkliZWVV?=
 =?utf-8?B?OTh4QWlVN1NWR2loakZwbHNTVml4Q1RFRlZFUEZyaWRBNXFEajZwR1A2WXRk?=
 =?utf-8?B?bUZ3OVlMbVpjd1VOSVhRQ0NiNURyYXJmTDEvMTFUeVlJWkd6S0tCdXdLUWpk?=
 =?utf-8?B?aEFiWDh4VW1sa2NVeFJXWDRMMkdlUURnd2cwUTdGcVkxZ013TUNUMkdDNjFU?=
 =?utf-8?B?M1V1Q3FEc0tsZkxoclhWM2pXZHJ1ZmhMUE0za0NRaUdDaG4vc2pFRkRMRzRQ?=
 =?utf-8?B?UXpIbDlwZm1PRFRIcTNZa2d6T0ZZaUgwUjVlV2RCeVlNT3phWFVaRmtrR3ps?=
 =?utf-8?B?aWc2RktyMXN0cklkb3U5ZHM4bmpTV3V1NGZsS1RveFIzUzNYeXNaS2l0eVZG?=
 =?utf-8?B?amdHM0xxZmpnR01sMS9mejZESnIvQUNBYTRKOHpHTTdmSWJmd21VdXlQZ2dN?=
 =?utf-8?B?UGtSWFhDb2ZZbENXUnkzemlrY1d1NWFFeDJTZ2l1NGlVYjJhYWxFVDRST2dj?=
 =?utf-8?B?U3doay9OMnNaNWFTeVd1dCtaTngrcDZnUUR2SXNhdVhVMGt5aWhWaHk2OXRm?=
 =?utf-8?B?cms1Tlk4b1BZZWp6dmtCQUdQMjlobUZ4M0wrZWlWa1QwYTYrcDhWeFMrQ0RB?=
 =?utf-8?B?b2xzUkZRVEhhZ1NoLzZTTnhEUkxqdE1XTHJpOGpMNXdGVzdnM1oxMGJTUnlW?=
 =?utf-8?B?c0YySzQzVXB1a3JRYXZIOFl0K3I1cCtYbWVsSHlBT1lvdnlMY2hRRE9oNUJr?=
 =?utf-8?B?RUhvd2tlVk0xeE5CRkRFSkVDaGFJZ2xGenpWVjZGQ2VhQU15T1FRNndWWXBT?=
 =?utf-8?B?ZmlJTW5WanBxNUQxUWNxbXI4dmRYNGVzMzAxc1FnZmVqYnBPSDJIeTlkQ0pm?=
 =?utf-8?B?dkl6NU9uTkdJb0p2YkZtMVBEOFBURE9wRzBvVjYwejhPVURVcVJWNnBzN25Z?=
 =?utf-8?B?V2VNZHRWL3htTFBmb3NNeEJ0aDNaSDA5OXE2cGRKdVBJYUNDTmtZZGg1VFl6?=
 =?utf-8?B?NmRibnJSd25ySk1vSThoWElCZG8yZE10ZzhFR3JtMmlUZkVockttSXF0Nkxj?=
 =?utf-8?B?cjErc1IxOWQxNUNlNkl4blVhNUVBaXNQbjA4L200UG5DV1pvcnllUVlzUkY5?=
 =?utf-8?B?UkxNSHBmMEdFYzY5L0J6Sm1sRmptamdVWXIraGJ0c0tEVC81bmFvVnFZTFRN?=
 =?utf-8?B?L2tZeXdHOFNSZ3NZaEFkTWZRUmZwSXRYMWRldDkySXEyeUs1U2FuNXp6bm1J?=
 =?utf-8?B?Wk9DczQxMTRsd0dLUnNVQTBKRHZVOTUzT3hjVWg3UGtRc0h2Z20wa25yNmQ4?=
 =?utf-8?B?NXRxWEhpQ0NaSWpkc1JqUi9NZ1RTaUh0eDRMRW1NUUg1N0NTTm5kTE1Qdll3?=
 =?utf-8?B?d3g3MDcvVmZVdGdLWWtvVUdIeFc3a05vbHpFKzJOc01BL2ZKSmxaT2ZlbTVt?=
 =?utf-8?B?cnNIRS9mWFhDUGl4Y1lNbDZlNW4zekQvQnZwd3BJZ25GaTVWOVpOR2tVeHdw?=
 =?utf-8?B?NGdSWVZyQ3JBNzNRM05Idm5xQng3V1NIVlB5a1FWL0pwR0RiTzRtY2o5ZXBI?=
 =?utf-8?B?TTVFRWdJdjVQV21sVmJpWFVDSmsxVTVmbWo1VWw4TE5vQ1FjRTRRb3BsL2ty?=
 =?utf-8?B?T2h5OTVNTy9SL2F6OUgxOW43aWczR1dIbTJTNy9Sd01VUkphaVFGdU85ZFF6?=
 =?utf-8?B?QXllblA2N2hUMk5aNkM5SzFOekJvRDNYWEtZUG54QXg0dXA5aXViWlFkN0Vj?=
 =?utf-8?B?bHVUZDUwb1BZaVJkQk9hUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2355f8-eda5-4250-1233-08d8fd05fba3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2021 16:22:21.3086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fY4i2UHh1OwbnWQkQLqhmRC91WDdJazoO69IVoUCk17wyF5TjFq+gPa/XFDlL6r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4094
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 9KEcLqZB8c9uhAd03ZKbf0TIUkate9x3
X-Proofpoint-GUID: 9KEcLqZB8c9uhAd03ZKbf0TIUkate9x3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-11_09:2021-04-09,2021-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104110127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/10/21 10:45 AM, Joe Stringer wrote:
> Per net/bpf/test_run.c, particular prog types have additional
> restrictions around the parameters that can be provided, so document
> these in the header.
> 
> I didn't bother documenting the limitation on duration for raw
> tracepoints since that's an output parameter anyway.
> 
> Tested with ./tools/testing/selftests/bpf/test_doc_build.sh.
> 
> Suggested-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Joe Stringer <joe@cilium.io>
> ---
> CC: Lorenz Bauer <lmb@cloudflare.com>
> CC: Song Liu <songliubraving@fb.com>
> CC: Stanislav Fomichev <sdf@google.com>

Thanks for the fix of the doc.

Acked-by: Yonghong Song <yhs@fb.com>
