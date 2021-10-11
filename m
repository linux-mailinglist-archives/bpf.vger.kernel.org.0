Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC0A4298EF
	for <lists+bpf@lfdr.de>; Mon, 11 Oct 2021 23:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbhJKVdU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 17:33:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36456 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230114AbhJKVdT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 Oct 2021 17:33:19 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19BI8PkM001623;
        Mon, 11 Oct 2021 14:30:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=l/L7Wu+yEeUEl6FJvra+LK5zuFyh+DWQmGnrPnS1HPo=;
 b=R9zq0HS2Qx8Q951vrhjab2f3t3nBAzuq/OZFoxeZujb5rKGfapJUKjhzC9jrAApjuHaN
 i+ifOapR1j1hCE3iSnUCh7gMFK6PyGpee0pR623hIcpP4tq03SWXJXFInj6t/UbfBTv4
 M5CZTXRG4LpQr8QTclcY7xIx8Hre6QvwkrI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3bmk034g5t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 Oct 2021 14:30:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 11 Oct 2021 14:30:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dE0Of4Uk5l3q4mD46l/dnDzS7cbTowpC3KwU7NUN0VOXozWJ7BRNRsIPqRBm+jRE5dvzG+IOFbMAoH1wGrBo2l1FkM3PbUvPqgNlYH+xRlXSEvBjyIz/a18dCIwsJunSYsjsRyGs5MYSeub5Sy7GKE8qnN9cZSraOrfyNCtb009n1AGl/eTS1IBX0gHSP6XItbmrI9EawC73n7/YQ+2WxphMJ3vmhKOUuDZpNlVOSm4HriB1yNaujl1ztV+NAQGwN4HLIMTfp02XVAfBkVI2sUZdpqNcWik9taU3pOjcneCNGnk7XXa0uLbi/mEXSll50VrGu66CBHW1T6da05b14g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/L7Wu+yEeUEl6FJvra+LK5zuFyh+DWQmGnrPnS1HPo=;
 b=KtdWhYNWGEnzJtU7vNb2c1iiKoBUbApZPDt3WF0Hxlq1qSMcQ6LHyH6zz1T0WfzMkAHOnnyE1lGb0I4sMex/1WqNOHGntIecD0GvFBzAtd+miVJqjZz7qQo4CRswW8QYSiKeKh/0lH6cZ+RN4oxQ4qitW8JnyC0TqCLyYYQczIJ3nt+ABfiJCxXsTRAUV1kEBScfkMvg1nXNEYcnP9Z5B4/Tx8Tl7WZmB7p4L/hiT01UvCh6UT885tbRTYx4iK13YHCisN7cuSCWvBNq6pB7l6VCUNC3VWCngWPu8SZcIxsr4kS+4zeZcetUbMdDqZzSfMw2s1pHf3bvZjGK9bnJ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by MW2PR1501MB2170.namprd15.prod.outlook.com (2603:10b6:302:e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Mon, 11 Oct
 2021 21:30:42 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::7d63:ef35:f43e:d7c2]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::7d63:ef35:f43e:d7c2%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 21:30:42 +0000
Subject: Re: [PATCH bpf-next 00/10] libbpf: support custom .rodata.*/.data.*
 sections
To:     <andrii.nakryiko@gmail.com>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
References: <20211008000309.43274-1-andrii@kernel.org>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <f70ddfc2-8cc4-72d6-6a87-0b4f08a1fdee@fb.com>
Date:   Mon, 11 Oct 2021 14:30:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20211008000309.43274-1-andrii@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR01CA0043.prod.exchangelabs.com (2603:10b6:300:101::29)
 To MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21cf::1945] (2620:10d:c090:400::5:7e70) by MWHPR01CA0043.prod.exchangelabs.com (2603:10b6:300:101::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Mon, 11 Oct 2021 21:30:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6a696a6-f512-4a9f-388d-08d98cfe604a
X-MS-TrafficTypeDiagnostic: MW2PR1501MB2170:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR1501MB2170E89DF94EA221FCFDEFBBD7B59@MW2PR1501MB2170.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:451;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ACQowNa/UssVRYDinUYbjZqlvGRZcOIJqhD2T97mhIZ6Kcau3EiQcIQVV6/HuTan+CrWZJPLYuXlnGBVFyO5vXHURQNPXFFIcM51Wco7BCJGgnEc8YymB4J2FFaW0bPtXQMUW0znrAX5axbYNToM7vxPAEvmwEQYkcgAsALrtTwHG+LRidqhecJgEpm4FKFHM13qSGbApbytkZ3AE2aQfIK0k5wjTs5ObkbOxMv5FCRQBr+6o4dIzKTOgqXk3m3U+RiLdoWxXFPsyBvVntqO6XDD3PIwC7Ux/iNtnvFoxfMRXMbLnn/YLnlxY/PYVlRSU1wMtqhBwqiO/r99o6PfoatVU2+0LPCEzXfqBCSuXJwLOf8NBC/IuSNGBznszVmXDIXvMMMddQILCRyNkNMUbLxeB1iEFaXwR8UrHTtlW+mg/j+lxpw1rCmApqPmvrgLtOG4RxnlrpdnmrfzPXAFNh+Fr24pXoJOzlUyF/hdyriHjfy3sVgewG6cHw9DYYlPwF9E6O8vYqQ7805SKTWGlMVgtOeCIHk8O5ugipUMiT02+bvCoLwINdcmxk4S+8vy3ZTbWO59G9wZK4yZNKhb+SMZcUvXh6KaWPzaKlfXwnnZ/wV0kOIzYton0oMwXqaLyMQrOIjs5WAr/dFSuAt0HB/nUbSVRND/YXW/f1GbHliUXvxbCTuoQSAVpnZbfeoc3Dv/R4MwN03H/Ik8a+H8OefCVqykSqVnbN73D13CrcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(52116002)(186003)(31686004)(31696002)(86362001)(83380400001)(38100700002)(36756003)(2906002)(508600001)(2616005)(316002)(6486002)(66476007)(66556008)(4326008)(53546011)(8936002)(5660300002)(66946007)(142923001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anpGVEcyMWlYQ0dNd1FEYkVBcDZEUDJXakpTUzNlaEJXZjZxanBqS1NFUEJJ?=
 =?utf-8?B?SFprOC9Uc0FDTEpWOHI4cFBOQ1RCUUdzblVPQVplU2M4TXJlRzRObXE5eDkx?=
 =?utf-8?B?UDZDUkIvRXZwTnFacDJvQllHa09QMFR0MEZwOG4rZFo1bURiVTBkeGs5azhE?=
 =?utf-8?B?ajBZcURHTDNPdk4zOTlnbGlvZHRDZ2lHeWRvSVFvNWxvTzZTb2xSbm9OeEp4?=
 =?utf-8?B?aFVYSWRHSG9MUHFqN2ZCaHVGWXRwM2JwOGpxK3FEM0tqemdaT0wyTEZucXMx?=
 =?utf-8?B?amJHTlZNWXVuUTZUM1EzZTZBSWhqQVBENlRlNU9wNnFLWEZrREhuRDlXTUtG?=
 =?utf-8?B?eUhxcklMUDVwUm1MYWE1MHJQdW44UEVRaGlka1BBMStBQzQva3cwMG1LNjFx?=
 =?utf-8?B?cW9IRW9HMXBPZno3dXBKcE1PaERaNTdWQzBnVmtEYzJqNi9oYmFMYnpwejl6?=
 =?utf-8?B?c3dpLzdVbktqOXBrV1RIL2Vwb05XNGk2N0kvd3Y1K3RvQjRtWXc1ZDdUM1A0?=
 =?utf-8?B?NE9xdTZjTlIvdkJlZUV4dWdFdm9RUnEyS3k5R2pxMHh0aDg3TE9NSWJwUlFv?=
 =?utf-8?B?OVgweHNHSWlwMm55WkN5MWtnVXQyYUJDTlBQUHVQbmgyV2hia0QzNVZodloz?=
 =?utf-8?B?aWdNZ3YvMzVLK0JRN3djRFQ4dk1xTmFxVHBJZHVkSTFVbHFXRmF3WXR1Qnoz?=
 =?utf-8?B?ZFd3cU5pMGNhZjdjM3JmVjFxWE5VdUxFajNDdGNnOWF6RUxtZjVPSHpzQlpW?=
 =?utf-8?B?NnVrVWQ5MkMrclhyWklLUFlZOFhGWnZlRDR0djBxaTRqNFBhem0wOFZUQSty?=
 =?utf-8?B?Q2hTVU9ZN0hncFo2UEdJbXJQcFZOWVE3TXpIRkpsUVA1TkYvVnU5UTVSTW5t?=
 =?utf-8?B?S0pLY1ZwSk9ldEVpU2RQTnowQmJnSEd5UnIrOFVJRWVzZUtLZUVvQlpibFhK?=
 =?utf-8?B?Z3E4Q3NsSWJNZUlMU3ZNRGFzL0ltSllRWTRvR0JxcDBqRVlwSDZzYThXRWFV?=
 =?utf-8?B?YTdQZjF1c21RSjJVam1HTEJtSklSSlhqc2VtcDZicDcxMUZMUUNYa1N3MlhW?=
 =?utf-8?B?eUhTZERtMXVLdDFtTmFoN0pwTXdDbUpBQzRuRi8vVEE1TWwyRDgvOUN4dm9G?=
 =?utf-8?B?VWpBQkgyNEUyd2JPSTFWQlRYeUhTZEZqc2FCbnZMZU9URUlkL2ZLQ1V4ZHBC?=
 =?utf-8?B?THUrUVpEQmhuTFg4SHZhL0Qyd2swV1lRcWJnRllhODZYZ2tqL0NobWhhMXJk?=
 =?utf-8?B?M3luV2wvMzUvdWxuYVFjSmF5QzRvZjZ2Qk5pNENvOWhvb0tnTEdyRDZ5NkEz?=
 =?utf-8?B?L24rYmtoYk9xUWUwZ3ZTRk5Na2FZUUdPNEhWZHZJbE5ENzcwR0EzSVltd3JX?=
 =?utf-8?B?dWtlTVNlZzJuaFliaXVsTTFFQ2FXOUxXSEJiRHovTW5CRUJrMm5vOTQ2eEs4?=
 =?utf-8?B?NGVBamZPZ2RsV2dqOTlHODFXLy84Unc5RjJiVVgwdSs4bW9hSTREMERMb2FE?=
 =?utf-8?B?NUp6dGJhcGx4bWs3S3R5aDRyWGRTM3ZoN0kwdFRvblphUzZ4aW5Tdm00andS?=
 =?utf-8?B?OS9LMTRRMmx0d05DSVNwV2wrVmxBT2lsVVVXMHZENzk2V2hCZ1dHNkE0dnMy?=
 =?utf-8?B?akVRdmYxaG1RWDJIaENyRlpndVhwb0ZhWlRzYWtCR1pXZlVDQTgxQnFMdytM?=
 =?utf-8?B?Z0UxRFpOSnZPZWNJdTlEbDJSNWo3ODZ4Y1RCOTlQODdzcjdsRjFEY1puOVlm?=
 =?utf-8?B?ZFZHOWNDVXJMaUlBQzRtd2F2SjFNMHBOV3IvZU5rd0ZUTndtMytwSkpQL0cw?=
 =?utf-8?B?aWpocW9RZmdGbXdTWWYwQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a696a6-f512-4a9f-388d-08d98cfe604a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 21:30:41.9991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mynKNs0hq5xUHN4/VW+IZQgE4qv8Cioj7SAcALNa9VrVMVb3E4KO2DFmndC1IBMd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2170
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: dLvJv0HQ7Rj7aPAdi353XxP92SsLemYe
X-Proofpoint-ORIG-GUID: dLvJv0HQ7Rj7aPAdi353XxP92SsLemYe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-11_10,2021-10-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/7/21 5:02 PM, andrii.nakryiko@gmail.com wrote:
> 
> One interesting possibility that is now open by these changes is that it's
> possible to do:
> 
>      bpf_trace_printk("My fmt %s", sizeof("My fmt %s"), "blah");
>      
> and it will work as expected. 

Could you explain what would be the difference vs existing bpf_printk macro?
Why these patches enable above to work ?

> I haven't updated libbpf-provided helpers in
> bpf_helpers.h for snprintf, seq_printf, and printk, because using
> `static const char ___fmt[] = fmt;` trick is still efficient and doesn't fill
> out the buffer at runtime (no copying), but it also enforces that format
> string is compile-time string literal:
> 
>      const char *s = NULL;
> 
>      bpf_printk("hi"); /* works */
>      bpf_printk(s); /* compilation error */
> 
> By passing fmt directly to bpf_trace_printk() would actually compile
> bpf_printk(s) above with no warnings and will not work at runtime, which is
> worse user experience, IMO.

What is the example of "compile with no warning and not work at runtime" ?
