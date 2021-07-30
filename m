Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4255D3DBD98
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 19:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhG3RTr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 13:19:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51896 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229999AbhG3RTq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 30 Jul 2021 13:19:46 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 16UHI5xV013222;
        Fri, 30 Jul 2021 10:19:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=3wtpjMKjqw3P/iJmBED7uF32loTAtj7q0co4uguVjao=;
 b=kbGZvZEg8EYEo0O8CsIwEQ6g0ut0f93IwFA+enI0nvyHBN2XwpdMrSKIg8nZdq27T3N5
 15+eY1R2pcD5095QQgAEbDlHJefQSM81f+RZ/6fkVlo+Yn1O+CAAYSqi0a7WUIUi1Qgt
 S6ZgTitvx6tZrfx6gC07pjW+20tbHcmXOVY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3a4fpra69y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Jul 2021 10:19:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 30 Jul 2021 10:19:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCninXlbJTEE3JU89QjBvAda9iJyyGc7QQ9j/CUNfR8Ysk9LO5Wl46oylVc32b9Ry2HQJh5wD/3sOx77F1C5X7ixUL9/Xa9+9YJIRXGDwvBJkO5uTXDCkuK0TH98l2sAsGIOlltthqVts5H2ijMtK7j8XTMcewMpFOqOd2JK09ov+EYJhfqi5eCkX7Be2ruiweOWIJ7fCYSSotKCT2DNqeR7zUubiYlho5xZt/xL04TGchtRJ8o8Eu3hazpek+gnL7Mt7fjlEaYpU1a9Kyhvju0eWnzI97Hva2K9Q+oHm9Av9uzvKjHGjSlCEbzXubVYsMkFev/1Vg5X7N2Q03IlfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wtpjMKjqw3P/iJmBED7uF32loTAtj7q0co4uguVjao=;
 b=RUKN7sf1tAxN0D5AXgPy1mjXV86LFt3RcJjmeZdmxjjnElwbnV2qDIG5xdYgU5JJt4w2MqgJj6bOzxO/aXXZJ4JgDaBNzF6I4USAgL7cxOKn5UzAnx1OfbyOMKTNmL0gCR0iXp5xJjfIKVU3QLt3mxCVOvpQGDXpMi1otXnrI3VRVyT0qUJbQ9yDw2kEanZHO6SBJvHBeTxr6tIzcKh3a5BoX48MNAEnQDFJrjXr57CwxMeV9JtIoh1OFfCnKsHQffH02ObG+2TCc1+zawgH2uB2sdTZiypweKtoq6oNkRI/7oz+tjdlaOQtdgMhxG/BneLo9wgvWdKHnieSeYqtVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4498.namprd15.prod.outlook.com (2603:10b6:806:199::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Fri, 30 Jul
 2021 17:19:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4373.021; Fri, 30 Jul 2021
 17:19:24 +0000
Subject: Re: [PATCH v3 bpf-next 01/14] bpf: refactor BPF_PROG_RUN into a
 function
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Peter Zijlstra <peterz@infradead.org>
References: <20210730053413.1090371-1-andrii@kernel.org>
 <20210730053413.1090371-2-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <03992bd4-d1e5-9187-f5a3-c05d5d3f98f9@fb.com>
Date:   Fri, 30 Jul 2021 10:19:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <20210730053413.1090371-2-andrii@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::46) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1130] (2620:10d:c090:400::5:ca99) by BYAPR02CA0033.namprd02.prod.outlook.com (2603:10b6:a02:ee::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend Transport; Fri, 30 Jul 2021 17:19:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab65e6a9-a89d-4e48-8257-08d9537e2d47
X-MS-TrafficTypeDiagnostic: SA1PR15MB4498:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4498E8806FA68CBD42A758A6D3EC9@SA1PR15MB4498.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tplwpT9SCNbFT9A+Fnlc1EsChNTQvlKM28ZKd3fsbz+w4898EAHXZRqyhMbYvym+xunEWbWX2bxCwRPmy7j7+bj/4ksDa2jbJqV6CdOSNP3GWGmqkuX9aritR9zR9j4quFywnOkwTOBF9lXljLeqpFJrUBKfhk3lk5IMLEvHr4QD2nwg1OkPm6B9eNxHbTyGCtEp5UqJHGtScnHyNlE9o9AKk8XAVYdVWVc6DeNiRpkNqEpQNUvZ3xiMuY7XkFS5jZpoy58ZaFpaNMTNGwzaaU5kF72rXWlTD1QjFkt2Ny7mtwTVPvhi+SCb3NWvlakc7JTEliI64FEENwO7lZ6Dmaom5YAaayojUSJbb/ILU3QFri9/p+ixJd+jp0olsshFfUNk98cnF+GDemitwvb2KnpkZItzJ5L6aD5diQyuy5AwsuJq6zJpHk0mLXGxpo7rOqEQWlOltfyRF3qj0U0hc0LTTUCqfefHwkQaJO31y97/Ry962hvTIE2TxFNxsZYh7HY2gAddGO85H3UrOoN8ChEaHFyF8WGVHb/FJDtJwlzoOUIoIut0N+jbE/VN8M3C0naXmX/fjZfR5npG7y+ijvE3DPt4okui2a18M35mSr2IaZAXmAoDwIL62P7WtkzSP2HnlFaQypKTYuR5IMFk6tEIZkiMj+NLOCNYEh60/nAaa4vfERl2qxZXJgls2ULIBzgLvlFGr1fBkdP0rg1MpMzFDTbA2xM2/mbUn2++bTw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(31696002)(316002)(31686004)(36756003)(8936002)(6486002)(4326008)(66476007)(53546011)(66556008)(2906002)(66946007)(52116002)(508600001)(38100700002)(86362001)(5660300002)(8676002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjFKYmNJQzRjWDhTdEVrS2s5eXdIZUlET3dPcFZFZURVcXN6cG5WNjUveGY4?=
 =?utf-8?B?UEtKdEkvcitBVHJzRm1LRTdTZFRoWjRSa0hIb2EvUUhhR1FKc0JDUlFDNXRB?=
 =?utf-8?B?L0R4QVAxdGFjdzNmY0k2SFdaanRHYktSVFVnSE1yOTVFSkliNnJZMDB3RGJX?=
 =?utf-8?B?UXpQbWVQUWlGT29VM0hxcCtYSVdLenZ4V3BjZDlXNFNZbVJuZ3RXV2xldEx3?=
 =?utf-8?B?OEFKeFRVTmFuVGZ3Wll4MEV5MWorcXNEYzlIQitrcVF2UU40RVExMmdDZmxk?=
 =?utf-8?B?WHpMVVV0Qm5senlsSHRVdkM4RGYxTmFubHNsU0l0UmZOanEzU0NqaGlpUnRy?=
 =?utf-8?B?T1dOemREdkpXTERodCtGMnkyWU45S012aXl2bzFZeEVwOGxVN1ppeE84NFN1?=
 =?utf-8?B?RVM2OERYQ0E2YkFLemNhbWJscmtyU3JvRjFFMHdGYUdkV2MvUlgyTDZwdkh6?=
 =?utf-8?B?enZuWE5Ydy85ZkY0SFBMKzRTcVhGUnRJWlVydnhuZTgvOWlUVnViMThWNkla?=
 =?utf-8?B?SlZ1anBpczU2cU14bklEeHlCN3pFUDNsVlRDM2VaY1F2V015aWZHLzlOeEV3?=
 =?utf-8?B?alZSbnBndGhCYXIzZWFoUHg5aEVUbjA4bHNNL0NLMUVqS3kxUkllWEl0cG92?=
 =?utf-8?B?bVkyUzBoYXc3NVMwdHNWK0x1WGk3WUJGcTJUaFJNa1RPV21UM0hPUzBRTG0r?=
 =?utf-8?B?Y3E0VktFMDM0UStHd3lMeUJsRmt3NGIvdkhYUEphMGtXbjd4eU1WbzJHYW9Q?=
 =?utf-8?B?Q0VRR3Vva0ZrRjZHT2hmMERpMS9LRFlGQXByS0VONnBLQ0RzbmV1bDJSWDV3?=
 =?utf-8?B?ODNWMG9mU1Z1dXhqRDdmZ0ZGUHNDdWpQanIvNU1wMjZCQ3RxQjVFLytWV0hx?=
 =?utf-8?B?cWwvblhvQ1VOaFZQQmFoeHJFUk5JMSttQzNTQTdqa3l2a2M2bWl5aW1nd0Fo?=
 =?utf-8?B?R0hma1BhQVpXUFY3V1NMS1RjZGZWQ0lWbmd6dHlNaytaTS9MdktnOVlCS2xq?=
 =?utf-8?B?UVJnbDVPM3NKT3h5aGN4cEdhNmpKMkMyencvdTNCOGFlQS80TTRWQmFHWS9o?=
 =?utf-8?B?MzJHdHJ2SkovSndvcUtIV2FhMnJ0ZkJubml1MHozVWZhOStaUlNOdXQ1bkZY?=
 =?utf-8?B?QVl1VDBndTNSMGw4UDNvRThNSjVPRWowRXFFU2FYdS93QUdycytEWFdxbGhu?=
 =?utf-8?B?SGZuY1ROMkxuNlFXeGhFSVlXTXRWdkFUZmxWQUdLQzFpUEY2blgzMzFhKzUz?=
 =?utf-8?B?UVVYbTNncWdINlBHOWlJS1d1bktEZHg1ZDA3N0lsenFFV2JnQXd1TFZUeldl?=
 =?utf-8?B?WG5lbnd3aS93WGozY0ZKMU04WjNZRVhMQmI5dVdzcDBBWkJvYXp6TlhVeng5?=
 =?utf-8?B?OW5YWkhCQTFENWJzbmJjc0Q3aG5ZTkF6LzJHSHlaMGpuR0owazNGWHQwNEpO?=
 =?utf-8?B?dktIMldQemVUdWdZTEhBaVpCSEFxMWI0NzZUMzlJa0gyL2RIb012YWtMQllV?=
 =?utf-8?B?OU1OWnVqQ0U4SXUvK1J3dWw2UFVxSHJSTmJ5UTZGSFZGUnVVL3FBSnMvekRn?=
 =?utf-8?B?ckFYckEvdXpIMkhxNzA1Q1lGOUNKREdFUU9pTWNWTnZVQkZEelVTeG51NEV3?=
 =?utf-8?B?Ulp5aWZiL0tsNG1nYzdIZG5Kc2NMZzNwcWJLdzV1ZE5rNUMxS1NoMW9hM3BD?=
 =?utf-8?B?eTZGQzdSSnFVQnlnTUxNVW5UMGdpVVNXb0h0cXVTRnNtOUk5UmVJRTZrWUdC?=
 =?utf-8?B?U2tLT3IwZUZrS203KzVkSGtUbXp6VTU4VTkrTTJmOTRRSkdCNHVOSkhoK2ll?=
 =?utf-8?Q?A+CZ1euIjESBgspgRm+2ISeRudY7bN16a9phM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab65e6a9-a89d-4e48-8257-08d9537e2d47
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 17:19:24.1550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2pDXwBDxanUWwO/H31jE7r4BhTys939/BgvYUK7fzIq9y1TWdIGPJOTyrjh25vS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4498
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: ngadIkzfV0cHhMj2-MihjszhFUbYp5ra
X-Proofpoint-ORIG-GUID: ngadIkzfV0cHhMj2-MihjszhFUbYp5ra
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_11:2021-07-30,2021-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=860 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107300116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/29/21 10:34 PM, Andrii Nakryiko wrote:
> Turn BPF_PROG_RUN into a proper always inlined function. No functional and
> performance changes are intended, but it makes it much easier to understand
> what's going on with how BPF programs are actually get executed. It's more
> obvious what types and callbacks are expected. Also extra () around input
> parameters can be dropped, as well as `__` variable prefixes intended to avoid
> naming collisions, which makes the code simpler to read and write.
> 
> This refactoring also highlighted one possible issue. BPF_PROG_RUN is both
> a macro and an enum value (BPF_PROG_RUN == BPF_PROG_TEST_RUN). Turning
> BPF_PROG_RUN into a function causes naming conflict compilation error. So
> rename BPF_PROG_RUN into lower-case bpf_prog_run(), similar to
> bpf_prog_run_xdp(), bpf_prog_run_pin_on_cpu(), etc. To avoid unnecessary code
> churn across many networking calls to BPF_PROG_RUN, #define BPF_PROG_RUN as an
> alias to bpf_prog_run.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
