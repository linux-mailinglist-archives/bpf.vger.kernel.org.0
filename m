Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0B92C8AC4
	for <lists+bpf@lfdr.de>; Mon, 30 Nov 2020 18:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgK3RVn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Nov 2020 12:21:43 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50328 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728337AbgK3RVn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Nov 2020 12:21:43 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AUHFcPI001168;
        Mon, 30 Nov 2020 09:20:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qvdyr2LEy/+G111As7n8IGdqEp3P4KqB3Vnx6ZIP9PU=;
 b=LR3R3BgkSgfBAmWNQDjhWQAGSOi1kVGAS1tFwvnWf68rglFT4IuLpMLTFyPrXnbkdgnV
 Jz/UW1IUzOXDqnWKh2N5iIAKvh8OuQEp3brhBUXTb9QbnwD2ez7SA3NTb2IYhmnkUXOS
 ZaKtOPSjHUBf2sSYhFYUJxymabfakBqEeeU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3542bnemjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Nov 2020 09:20:44 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 30 Nov 2020 09:20:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luLLq+b2AFD4bwTbjW7BIScjcFOwp0IsDPSsYMA9C3ZzDdp+LtQXts/PxOJrQyqtHjq/3TK1otpG9j0XkYRMzhkaXJ6QirJpGiOq9Ux0lR/aj9iyX+P1WM3ixin9f2f2UbN3nmcwkj6xyvCfN8Sd7brLygTZico8oFKGP1ySUMsiwLAkTfTyWszMjRnESxe4mnYrVgWLRg6LmoYJJ+vBtTHTbjJYEcqR3CBeIXHIRuWYnb8q/i8BqsiD40UKIkwGA6tOeSVYtXvqft1BOlf76NCvJVnecTaCeWrJt0mlFS5lLIOFKUdOTSTJDu4U6nrx2nvXa2mhxmjpA2hxxEDRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvdyr2LEy/+G111As7n8IGdqEp3P4KqB3Vnx6ZIP9PU=;
 b=KLGWi0nWzt2cXP53BEd6uNrPomwG3Z3S049m/gBAMwVOO/A4pIQhnSg8QFVvWBDxYFChgR8+HKmMvIigW+QZTxdholoseqQSKGer2ssXuQ2t5Y2Xv4gcqxqS+6G6jDQb13NHJ0EyD7yqJm8CpsmJN+TdzONUj9JHfpw0Ge7ABdUupyyBmw1CxfkLmbJO6freORlYMECyR06XglgprsG4yC+AirUsATpt1exNFbcCo2LEQXOLC2McuOddob5pQ3iTsRj+lzcVbT3EAA9ogyeKZhIkoT1aDvhvn9tYRxnUwJyghyTiPITYodDBA+dcQX+Ax6MTazsnkIxiO2Bvj9nVaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvdyr2LEy/+G111As7n8IGdqEp3P4KqB3Vnx6ZIP9PU=;
 b=JAmmF/pdkRSnNeZ4LpJQb4lXah6JAFP6W/qELSgJDeO47qqTSZEzuWL/A0nNkGxuMpspKhUTjPN1YV8cpl1Lpude3bPqYwwCr+Qb6b5bOVpkIQFKiAGPqOImmOymN5HIJMMTnErqLdw1AlZlW7WtmrBWcwietvSzIy6/ozum8Mw=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3047.namprd15.prod.outlook.com (2603:10b6:a03:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 17:20:39 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3611.025; Mon, 30 Nov 2020
 17:20:39 +0000
Subject: Re: [PATCH v2 bpf-next 11/13] bpf: Add bitwise atomic instructions
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-12-jackmanb@google.com>
 <d2e093c3-79bc-0a6b-8919-c5a07667926a@fb.com>
 <20201129013615.mf45ihcio2abuvlu@ast-mbp>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <57c39719-06e6-17cf-32d4-70869f6618a5@fb.com>
Date:   Mon, 30 Nov 2020 09:20:34 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <20201129013615.mf45ihcio2abuvlu@ast-mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:5f96]
X-ClientProxiedBy: CO1PR15CA0086.namprd15.prod.outlook.com
 (2603:10b6:101:20::30) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::124e] (2620:10d:c090:400::5:5f96) by CO1PR15CA0086.namprd15.prod.outlook.com (2603:10b6:101:20::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Mon, 30 Nov 2020 17:20:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f695335b-3f37-496a-fdc2-08d8955441e2
X-MS-TrafficTypeDiagnostic: BYAPR15MB3047:
X-Microsoft-Antispam-PRVS: <BYAPR15MB30470695E954567F82CF9F36D3F50@BYAPR15MB3047.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VRNhvCePbfGLfIC2bCc6gKlifnSoCbpYAS/Po8DJOA1I7rNXWTLF+QT0mfMuXc73APYQ9Mtw1dXk/bCLpyqLNORHhzHNEuukrku9OF7Ik/s88h370GnkM5wZMEgwRqzTVRadJKVTJLkaPcQ+SPAKBnJ5wdKaSwOHZaAs5eeEqWZXRB6ygqlB3q/wpuXbEPj8HluohAn+PxU+4yyGtlorq2OV93NZuw5yxO/SXJd3a83g4957XNW5POlpfFeQGW3d35KgHZ4AHRgU9L5OmHhZSb1dNA25c8ET+iIQQ12s3nbe7oojWUn4bNRQQFPWnUkn0vBfvIvIj3ERq5DPHAB1AP9/25NjL+AFhvjzK0OOJ3upH5VzJSaQ90L4CyhwHNfo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(346002)(136003)(366004)(53546011)(8676002)(54906003)(36756003)(2616005)(8936002)(2906002)(478600001)(66946007)(66556008)(66476007)(6666004)(31696002)(6916009)(86362001)(52116002)(316002)(6486002)(16526019)(186003)(31686004)(5660300002)(4326008)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?THd6WkJnM0p2dThWVTZJOXZlelRCNmpzeFJ0NXNjQmYxWnVucStPdlNZNW9r?=
 =?utf-8?B?c2hUWCtjOUhQQUhuSmNiTEpDK3pWM2xLYjZTLzA3ZmdIWFhMdmEycENJRzFI?=
 =?utf-8?B?ellyaHExay9sK1FmTndoMDVRcTZsd0ZuY0c4V0l2RTNsZG1NblJxMmM5SUk5?=
 =?utf-8?B?djBxa21XYmhQeGZ5ZFZ1a3h0QjdQUUpiQ2UzdWFaN3NLTGNwRjREV1VZTGxZ?=
 =?utf-8?B?MlAxTGwyOGhYc09hS2FkdW8wdW4wUVFETjI1YTR6RGN1bmtuTGVSNWdKbkcr?=
 =?utf-8?B?OVpxL0ZEZnE3cGpnNk00ajF4VTB3WWY3d3ZtclRZcFIydTZYaVFmc21mTnZh?=
 =?utf-8?B?aEFFSkVaUHR5RVlLcGpvWTVzMHlSZG01MXhjaTY4YkFZU0tVTWNSWUlvZGR0?=
 =?utf-8?B?cTBCemltS2pKZ0o5SllOYWJONmNReG9FTHFYdDZGbFBTMnZzZnMvQ1MxM3Uz?=
 =?utf-8?B?ZThvVUlESmNVd0N1T3RVcXk2NVR3eTNKWkJoRXBacVVob094VXhhL25CSUFY?=
 =?utf-8?B?RXdaWS9WcnpkZ0cyeC9qMHRteGVZRWF6SlRLTWxjbzB5bFpZL01CZklLeXk1?=
 =?utf-8?B?cC96dEF5RzhqQk41T2MwNnZOQml6WEJWL2txQTNpTDBkV2NueG0rYlNwQ0Nr?=
 =?utf-8?B?NlpXYUNJRDhIQlUyUmI3SEJvSk5vSmNEdlBqNm9vekx5L3l3Q0FaRXBwQXNW?=
 =?utf-8?B?U3NKb3ZiYjBxVGFvWjdoNGtQSEZiSmZNMEovNDh5MmlDTlF1Q2FPczdKMDhV?=
 =?utf-8?B?cU9YVWp5UjVibndiZ0hoMHZvMlhTOTNwZ3FyU1Y4eDVELy9OcC92L1JZWlZw?=
 =?utf-8?B?dGk5THhNbXovUDZXcjMzd0ZQSWNtTENNRlczUHpQdnVoSTYvVXM1eXJMT3lC?=
 =?utf-8?B?UzFSTUJHUXlETVRJQkdnKzltdVY4YjBPZGY5WVpzVllFSXhpQmREZzZRUTJ1?=
 =?utf-8?B?eDdpQVA3NFRSYmhDVDVEMkZtVzNsTFRRQVF4dS95WnNyZDlSb2lHSW05QVIz?=
 =?utf-8?B?V1RZcUxxdHV4K2wwSnpSbU8rRmE1blZzeTdnOWUwQkVnYjFic1lpMlJWMnAz?=
 =?utf-8?B?TWxuTjl0NGNYY0thaHJCMy9pV0pZSWRzUW9MVFdaSXBpZ3ZYMU5mVVVkSnRu?=
 =?utf-8?B?elpsSDVBVUo0UENoNjJ4ZDg3U09ENW93UXFjcnZVK2xoSjRKTnJsVEVmUFpU?=
 =?utf-8?B?MUpkNVp4NkR3aFRreHh5TDRkR3IrT0wxYnNjSWtnWXdkWldWdE9MNUo4Z21a?=
 =?utf-8?B?a1VUTlYzM1REdFloUHkrMDRsZGIwTWJHU0xGalAvV01yTlI2Y3ZyOU54Umor?=
 =?utf-8?B?MVJJa2d2TGUybXByeUdpQmgzSkFNTGhQanR6cGYzTGdZdXVLLzJWcUR3L285?=
 =?utf-8?B?VXg2cldYMExpZ2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f695335b-3f37-496a-fdc2-08d8955441e2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 17:20:38.9740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0hUYxGfK4lp4aM6aGcpQzMm7Qc/7F0ycEtOn2DzKoYAMf49KQCMrxB97/xw/dKf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3047
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_06:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=840 malwarescore=0 suspectscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/28/20 5:36 PM, Alexei Starovoitov wrote:
> On Fri, Nov 27, 2020 at 09:39:10PM -0800, Yonghong Song wrote:
>>
>>
>> On 11/27/20 9:57 AM, Brendan Jackman wrote:
>>> This adds instructions for
>>>
>>> atomic[64]_[fetch_]and
>>> atomic[64]_[fetch_]or
>>> atomic[64]_[fetch_]xor
>>>
>>> All these operations are isomorphic enough to implement with the same
>>> verifier, interpreter, and x86 JIT code, hence being a single commit.
>>>
>>> The main interesting thing here is that x86 doesn't directly support
>>> the fetch_ version these operations, so we need to generate a CMPXCHG
>>> loop in the JIT. This requires the use of two temporary registers,
>>> IIUC it's safe to use BPF_REG_AX and x86's AUX_REG for this purpose.
>>
>> similar to previous xsub (atomic[64]_sub), should we implement
>> xand, xor, xxor in llvm?
> 
> yes. please. Unlike atomic_fetch_sub that can be handled by llvm.
> atomic_fetch_or/xor/and has to be seen as separate instructions
> because JITs will translate them as loop.

Okay, will try to implement xsub, xand, xor and xxor in llvm.
