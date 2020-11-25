Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4272C391B
	for <lists+bpf@lfdr.de>; Wed, 25 Nov 2020 07:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgKYG2x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Nov 2020 01:28:53 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3434 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725838AbgKYG2x (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 25 Nov 2020 01:28:53 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AP6REME021069;
        Tue, 24 Nov 2020 22:28:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=kN7n60TlvaVdoU2x4CdnKHeVwtiSVl64Jtl9jdNgdr4=;
 b=TBghsZgIfl8EAa/1T1xOSUwTNkAwqXKv1ar8d1Vqhyc34cligdjNhqL5A0Q24Sz1bO66
 1C1NvKdoVKV40A620kZEFSFNiX/ItKUCcria3cXOdPxNS7t0mM3enPXi1sja4ONa/zvU
 AdUtaJzCYl5/zFW6di+FFd0pXqEdbw3jFSg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34yk9gd8n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Nov 2020 22:28:50 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 24 Nov 2020 22:28:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0ZE/7JJlmP0FK0K2Ize6WNRmtujAVoWhWyFdo97MhDiLHLdyKGGdOdY88gVPnlfHrIxf9mKqMQX/NJpBhcYVrtzxXS2qbLCSvBgy08C3UmBFcNa3uZHem/lq1OmWcO9Vc/JkGVxpKqY28VzyuB8NLxqu6FvVBMRiaGkrGmhupN5TDQtfRkjkZNDAATuDgNPTTs9At2Kl16x1hNOA/ddjq0fYnHp9hE/sLhmczmwgB0pRpTj2T1YVnNv8/CRdPK3Qhaie482Tl5DZEQQFM8GLCZZ+kPsdPXNnP0AIHUDOa10UA00iNnLlEyfo1QAWm9d7fGHRUvsiD4cENww3XVDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rq/CJUK5zr5v5EzzPivjFJJykcOUXNKuTUdJcB/i+GE=;
 b=NIASoDpDOowmJy2srQvMI6zGzBfjrjN6LpJAytnM+jr6XM2YtkynDoYSziUxK2GTQOVXiY9m/OGSmJ0lVwRC34YDvfq8vOugYGe9YdLXEFVpZ5Gew43Hhc1D2xzQC8Z+pwSY6WBHDb2Em6A6+rXzwln5bT2kfN3V5Yf+j0+j5V3f1a9DuINMUe7fJcRJYwFm9iVCtIf+MGeLrExvpho1Yta3kl83JX/H9rbbupAUCmZ3nzL+fZEK3BgBCsM3J6zN9xGyBn5T5K39tMC8EGGgm3TN5SwaFwfoGB16o3io0W3YVurV9jBUWkkrqqt8bd/8JCl4QiUnKkaZwj0SLgCaqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rq/CJUK5zr5v5EzzPivjFJJykcOUXNKuTUdJcB/i+GE=;
 b=QQNlKk6RHSwIvUoG+SR9zS1qXbFc4sfRcSoCvzNvWp7XMrXaV9q0vyM6/pD706XR3J1Mx0QkLJp30PZkCVaJhDdotfxYC2Pmeaq6YO4YegHo/VqTHhTYxjPN88jEG+aheZUHBTBBWHG+hgvddQOHAOTGL5orYV01HAoeXzgc6Js=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2406.namprd15.prod.outlook.com (2603:10b6:a02:84::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 25 Nov
 2020 06:28:47 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3589.029; Wed, 25 Nov 2020
 06:28:47 +0000
Subject: Re: [PATCH bpf-next] selftest/bpf: fix compilation on clang 11
To:     Andrei Matei <andreimatei1@gmail.com>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>
References: <20201125035255.17970-1-andreimatei1@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <a97c41f4-04b6-1ce2-9fe4-472e4ee6205a@fb.com>
Date:   Tue, 24 Nov 2020 22:28:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <20201125035255.17970-1-andreimatei1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:439d]
X-ClientProxiedBy: MW4PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:303:8e::24) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::121a] (2620:10d:c090:400::5:439d) by MW4PR03CA0049.namprd03.prod.outlook.com (2603:10b6:303:8e::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21 via Frontend Transport; Wed, 25 Nov 2020 06:28:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99f5d22b-27d1-4023-9ecf-08d8910b5d4e
X-MS-TrafficTypeDiagnostic: BYAPR15MB2406:
X-Microsoft-Antispam-PRVS: <BYAPR15MB24066157AF1CCE673B51CCFAD3FA0@BYAPR15MB2406.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dNScKP9ciaYlvO1Z+Fi8u8BRAMb84RKiXlnTlR00s+w+rvdNkpc74sijzM1Qr5FwZ/3KxsM19IsWl3N7zT/fDsMk/JV0Zjg/vWyrdZIAx9ua7wZm2SOBENuT0yFw6pZM05hu3QM2jZWaLc9bXtRS4wedOfJe2meDKlsRI4aBnrGHNMhzCwPBneYxhhxqf0uP+DFYZL+/BmV/1D/+pPWYXJrnSa1YmKxoPw8A8EjOt4L0RKwrRjtelI2iWzuYELCP8o0yl+yEm66KWdC31VWuN9l1y0EVavQOo6VES9f2Zi5erOxFaizxefUGMA6IHkDW/MiFK1+inBQCDoE3PTyu1/yUg8pOyWGvlby5/Iqn4O1Bgl6WkEeQ0I+NuJIqKiNC/1ujx2nkdXV/ao/Snb6URdhsc97/wTnr0jEeVp6FEECa9vcBxDftKIEhO/5xmjeHQnwQAoEMJoR70YRtQL5bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(396003)(366004)(39850400004)(478600001)(4326008)(52116002)(2906002)(36756003)(16526019)(53546011)(8676002)(8936002)(83380400001)(6486002)(86362001)(186003)(31686004)(66476007)(66946007)(31696002)(66556008)(5660300002)(966005)(316002)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bDkxQmhlaHdwUWFWcmNRVFczcHRqdzdzeXZlQXBTMmYzV1ZyVUcvLzVacm52?=
 =?utf-8?B?cXRnOXhxYjZJcmJSc25YVGFuSjZ2TXZyRmdybVVhbzJ2TnJBNDZLYXJiOS9n?=
 =?utf-8?B?ayt3clFVQ2FVWWZrVVlLNTAwMkovVUp1dGtZUmc1bVhLY0Z1TmtTdnlHZ1RH?=
 =?utf-8?B?c2U0N0FrVUhqWEJONXZMMHJGWGVoc1FSUm14TUJrbDdtbFRHdnJoL2tabWJG?=
 =?utf-8?B?SjJ2WG1lUUs5WjRUTzVSN210Q0ZiYnpFZ2pkQ0V5VHF0d3dRQ1B2M2NJM1I4?=
 =?utf-8?B?V2F5OVBLaFBGaXRkcHJac0E3bDk0U2RRKzQ0bjlhSWhiNW1GcTV3YXRMT0lw?=
 =?utf-8?B?UDVjTSttYU5TZkJaeHk1TzhFVUhvNEQ4aHdDZ0cvaitKOGVMcFZ5VnpjL2hE?=
 =?utf-8?B?Nk9ZeWJQZE8zU0YzTnBxalRMMXo1Sm0rQnV0RHp0UmpOOG0yTUxITHlzWWVI?=
 =?utf-8?B?Qnk1b1ZKSDhVUzBZeFFWa1ErZ3JaMitSR24wbHRLNGNuUGFQRXI3dXhaNXN1?=
 =?utf-8?B?ZWsvcExJZGI5TnRHRUF6YXBZUXNiQ1ViT214ZTg1RTQzQnI4NmNMa1Z5ZG9o?=
 =?utf-8?B?amczNEhrVnFZVjBZbG5jSlMrVDlSRjFxUzhkMlZtWFdGbnhpWDlYRHF0Uysx?=
 =?utf-8?B?bThEQk9LN2NhSSsydU5KMWVYTURaV2EyVjgyMVNiQVJueWdZbXNCZy9ucm1X?=
 =?utf-8?B?eVdzOFBNWEdiQXJKMkhaaWpoL0QxNHB2bU9hS2IzZGU0TmRzV0xkTFA5cDh0?=
 =?utf-8?B?SThHQzBxcjRiMmwvZ1ZQVXFxaG82L1dpRXhvZG1NbG9uelM2azl6T2toRm4z?=
 =?utf-8?B?NjRiU0duYlpKTndxVzF5NFBwU25VTjN0MnIxaGxDdkdSbTR0a1VTZWE5TGdO?=
 =?utf-8?B?bjlaTVZFSU5OVU9qZlZZWUtUY2hjVmo5eHIyNk9PRU1wSFNEN2Y2M0tYdlpr?=
 =?utf-8?B?aGQrYVRHSG9XMWo1RHdXSElqek1odzZvc3lXcmV0enZ4SWF0Z0psY3NCMUxn?=
 =?utf-8?B?NndpU216OWhrVkd3MW4vWk9kL2x4SHFYMWRRTmpoMmhXaXBtUEFDTjc5WkxP?=
 =?utf-8?B?TGhCNTRiVmpCNkZTVjVjMUlVL0U2QlBRR3IvTGxoYnI2TkU2Q1J3Y081eldK?=
 =?utf-8?B?Y1B0eG5VU3dEazJ4ZnZaRHpncDczcHlqRk9HalJUQkNNY1kyelI5S0xTLytU?=
 =?utf-8?B?alQ0enFjMy8zM2x3dWcza05VcG5PTE8zcHN2MXpTMCtKWm5wampxMGJQYmJE?=
 =?utf-8?B?TWFUUUF0dUlPWnRPSjNQR1lPNDFMRUw2eG42QkxKOTdKSFdsTHQySmUvN0da?=
 =?utf-8?B?VjRrUzMxQSs5VmJsaCsxQjlZZEFMdE5RdVhuWFc5OU9WbGFmZlVQaGowUlV2?=
 =?utf-8?B?Zkt0MHozekhnK3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f5d22b-27d1-4023-9ecf-08d8910b5d4e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 06:28:47.1415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Q7WsGYG02hDKVv4J/jocc+26zfo2eIr8j0dkS2tMPSnZ2HOAXQNcUqeA7VLSK2S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2406
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_03:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011250038
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/24/20 7:52 PM, Andrei Matei wrote:
> Before this patch, profiler.inc.h wouldn't compile with clang-11 (before
> the __builtin_preserve_enum_value LLVM builtin was introduced in
> https://reviews.llvm.org/D83242 ).
> Another test that uses this builtin (test_core_enumval) is conditionally
> skipped if the compiler is too old. In that spirit, this patch inhibits
> part of populate_cgroup_info(), which needs this CO-RE builtin. The
> selftests build again on clang-11.  The affected test (the profiler
> test) doesn't pass on clang-11 because it's missing
> https://reviews.llvm.org/D85570 , but at least the test suite as a whole
> compiles. The test's expected failure is already called out in the
> README.
> 
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>

Thanks for the fix! This change won't impact correctness as
profiler.c mostly to test verifier.

Acked-by: Yonghong Song <yhs@fb.com>
