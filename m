Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03A12F3605
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 17:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404224AbhALQne (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 11:43:34 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31354 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403943AbhALQne (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Jan 2021 11:43:34 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10CGdl0n028758;
        Tue, 12 Jan 2021 08:42:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=RDPBnW6EaeSoKnNsQtlFl4TQ+SeoGWOecKPELGF1L6Y=;
 b=BjkBFbzp/+bgsqZYoPBLTk8TBcHYv9nV2EL+bpeEQFfW077l+pUCmWKilyVQc3WlZWjB
 EdCZQArNEcUE87Kp3DNOSbjITebnoDndr3Xgp4pVIwTeqLWo+6+emI4cQVGE3JI66Qql
 ypfPh3PH/Dx3bf4dkHWFeyyjeFe3RkFufuU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35yw1pkmu5-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 Jan 2021 08:42:38 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 12 Jan 2021 08:42:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j86TC++57HqQZ1o0weOjLkW8FtVd1Tyr0GF7Xtmk8ti8hIjGTlNeWnCwRjc17TjHIOi+3JyLN3aLpe93Y6PH7YEKr7viMeBF68joMzUCgCiKQ+lcpuc5vxZD2FFiBy/NlmpyGa6+T7kugi3Lb/BIvRv3DNTXPr2st/bpDY482XrOg1Vhwd9hKSmeTd9Sjjtr086S61aHoNy+MQPfBcXAPXNC7dLByFOJ5OOS+nGszycwnHUh9G9eh4AbofBVC72o3hS1LijzWAUMYioAzQFwa032+lZ+9O2D1aofmoOUW2V/ta/DCSq1nO6Y5yBR+eAmqO9/QTy1PbY8ab+LwJvZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDPBnW6EaeSoKnNsQtlFl4TQ+SeoGWOecKPELGF1L6Y=;
 b=Bc7uKaNxikswUQlLaLkz2o3cs6jiOhhaiOCszumUCm58x8Qp/5DUYBlb7ywM5lqIwQwwic9Mov/MavDAR/Ib4mpcIT502LXtmKarjXna3PTIP/GhVyeUfZ8WssuPOYfmtXVO1frMICLO6Ht5UzHJLKz8zuCdd8cJS3J0SqXxhpIwABQpYvoV4gHcKkRLya8ZqCkHai+I1Kd6kYdoM46Z+d/663dZfeSDstnPQJOiQekhVdoy3iO0MjOaPDPkapHx8+twZBj5v38ZdP/j88SI1UZwWjrsxyUJPStvhE0IroWh2mFGEwkcExL6Ms5TJSUDA7DyfZbiCsOAeYmhXjZlgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDPBnW6EaeSoKnNsQtlFl4TQ+SeoGWOecKPELGF1L6Y=;
 b=aEhVsfr+mfFXve4hMPB+e79gsRo5StBKrP9HVZ6zrWRJwNXHiGyABud9qjBkveMEQDC5flFu1KYW79Rk0Ltw8JIbJU5qKQW5JlSyQz/C+nTSezRFPUBAXGXClewpKIK+iagxlylWi14uvN4ocNEYOt56H6FoZ6acVQiRzbebotA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3302.namprd15.prod.outlook.com (2603:10b6:a03:10f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.10; Tue, 12 Jan
 2021 16:42:28 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 16:42:28 +0000
Subject: Re: [PATCH bpf-next] bpf: Fix a verifier message for alloc size
 helper arg
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>
References: <20210112123913.2016804-1-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <8fd88ea5-5d71-056e-615c-de670f34ea7e@fb.com>
Date:   Tue, 12 Jan 2021 08:42:25 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
In-Reply-To: <20210112123913.2016804-1-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:3e3]
X-ClientProxiedBy: MW4PR04CA0318.namprd04.prod.outlook.com
 (2603:10b6:303:82::23) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::190b] (2620:10d:c090:400::5:3e3) by MW4PR04CA0318.namprd04.prod.outlook.com (2603:10b6:303:82::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Tue, 12 Jan 2021 16:42:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bfad9f9-9406-4429-3dac-08d8b7190c74
X-MS-TrafficTypeDiagnostic: BYAPR15MB3302:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3302D5A3C029DE7CA795676AD3AA0@BYAPR15MB3302.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HRas9nURxRpdA8z9tTQkQ185XY7VoLjJVPA3TcLfcJhcX775oZUfeExRUkgAlRKz7jOxZmK9MiIaHMLYDc7Cwp+lpCiPSDDDctXMyQcmIchbVNsvW4EI3IjPeTah3x1xlR5qu93fojZsgN5cSCc3HabiP9RoQPVfu4oR42q/8cdPPK713clpVcLhTzUR+4r1gAM1xwYLTQrkGoj+7ZdCYHSeK1vhQjYB8f/MZ67mwAB0tWeR5qiszmfpHJkVOLMCUJ/OXFEPdgSuVjJRWucrgrMSsY7mtyOsYUO8WE7ZNYGOO/jeCq8PObltKWWi6QxpEFlf1JFOQftzkuNbFQFzv1HH/pro9XQBTeThmg6Noo0xH2jujvnXA7D6bs2dG1CSg+pvjAP6Rxnf56hKgGbn+FAqkvz5kYap1lUU5MQX8JOWajQbi1o+H0U+kDHDuIhSIDCbHnNGQdFoDJhEvcPGOe6QITKeZNjGJiRdZK/5KgE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(346002)(366004)(396003)(83380400001)(15650500001)(4744005)(8676002)(52116002)(53546011)(5660300002)(36756003)(186003)(2616005)(86362001)(66946007)(66476007)(31686004)(4326008)(54906003)(6486002)(316002)(478600001)(8936002)(16526019)(31696002)(66556008)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SEE1eCtLWDIzczExdlR5ZnIrSEthMmFGamhhNSttS2NtZElBUFl6REpuNFJ3?=
 =?utf-8?B?K0s4ZE9ZaTZCbTFqNXNsWWpHOUxPV1RDZ1gvMktOUGZYNmhEa2FQbXNFcDND?=
 =?utf-8?B?cFo1UC8xUHc2RDN1R0lwQ00rRWtnTUcwZVBPVk9kbXhPODh2ZThqdmRibkdv?=
 =?utf-8?B?Q0pnMzlUejBaUmtOOG5FV1hvM1FuUnVnMHc5ZkpSM0lwMDJRRk5hUHdRSUpn?=
 =?utf-8?B?ZEMyU3pRelRyYkp2Q2tnOEhQWFMwRnF2dWtQaFRvamt6NGFoZEtOd0VpbEIx?=
 =?utf-8?B?VkdBU0Z5OGdxVVhzWGlMazlaNjRpWFROZzlWMkRuNUZ1TFNUQ1ArM3UvQkpV?=
 =?utf-8?B?aW5VYkxKYXI3Y0VYcmhzMmdGNy9XcVFFMEpWZnlBVXRJSGg5UDVZcGYwdkhk?=
 =?utf-8?B?aE9pNG5aV2VPa3JPNDljNHFHUlJrTkVSSlBlOWdtbzlJKzBaUGRhQ3RrUWF5?=
 =?utf-8?B?c2dlaWVJdWIvN2VUTVJhTVlQaForRnNENmpvbUpMNVlvSC83azRLbE50YzE1?=
 =?utf-8?B?QjduMExoRFNncS80ZzBSb2prMlR5R3h3SFlKZ21nMFRFRjdUMDRacHJJYmdm?=
 =?utf-8?B?dThmTUtHQndHdWZoUWZQa0k3STY1ek5xRGE3Y3FtMS9FME5ZM0dFNHBVZzVY?=
 =?utf-8?B?YzY0M2ZyUDBrV3ZuVTNKZ3FFUDNWR3RrVVcvL1FzS2o1cG1TUlArWFJIQVh4?=
 =?utf-8?B?YXY5MG1hbmMrV2ZZT0NxSjhiZXpIa0ZLUmwxTmd2eGpFR0FxUnVLWkx3TktI?=
 =?utf-8?B?Yy9VbWVKS2RMb3piOVBiczJ6Y1FiTXJUKy9GYmliL2d1cEM5WEpYS3RBNzB3?=
 =?utf-8?B?bmRMVm1BTnM5Umw5aWs0T2ZlQXRFQWU2Z1NuMGh2Q0I5SEF1NFBuRTZuRGgx?=
 =?utf-8?B?bkxtRCthYis0Rm10S2FSbk43czBSTmEyN1hZUVhxRkk1SmVaTzdPRysyR1d3?=
 =?utf-8?B?R3FiaDh1TXJBRVIzK0cxcWJxYW1wS3p1TnhISTN0OFVldEpLdG5vMWJKYU10?=
 =?utf-8?B?czZVM2NuMzBCMERrUTVwYXgyMFp0V1FYSTEzc2hnNUJOUDRHbXU1ZFhCdTJk?=
 =?utf-8?B?bDBQZCtmekR2ZHhUem1vSTlVMVpQWXdQa1BWQUFyTGVsVkJBYmptQmZZb2Iz?=
 =?utf-8?B?dmN1UU1RTzlxd1BIbTVWbU1PUElUWnVveDZhQ3lQL24wNkxPcVptUGpaMGY3?=
 =?utf-8?B?MkhUYlNUeHZTd21IdVhKRWRmbG5SOUVtcTJpdkZhS2VOYVkwMFYxRXNXOHMv?=
 =?utf-8?B?bzcrWlBaZW5RS2NycVc0cXNVYW14bVdXNFBUWFBEc011WElWazRGSllpMVl3?=
 =?utf-8?B?ekV2UHFmVThBVUpoN25NUjBwVmRsbXJIVUhmbUxhckJwWUgvMUkrbWg0U2Q4?=
 =?utf-8?B?aDBPZGZVZFZxaFE9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 16:42:28.2426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfad9f9-9406-4429-3dac-08d8b7190c74
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtWMeR7SVjIDvd/xt/UZNRlWkoSeGgEobagrGI0xm5XqwC6kuZGcmTZjRz1ewl3L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3302
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_12:2021-01-12,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 mlxlogscore=968 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120096
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/12/21 4:39 AM, Brendan Jackman wrote:
> The error message here is misleading, the argument will be rejected
> unless it is a known constant.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Okay, this is for bpf_ringbuf_reserve() helper where the size must be a 
constant.

Acked-by: Yonghong Song <yhs@fb.com>
