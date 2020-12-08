Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5BF2D216B
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 04:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgLHD0W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 22:26:22 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36682 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725995AbgLHD0V (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Dec 2020 22:26:21 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B839ESV005879;
        Mon, 7 Dec 2020 19:25:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=S61m4zdKmkJ+wD+/0Md1DULOfTGd0aa+RcBmIHyM+80=;
 b=AHyHMVEMCpY1FSp91oyQk7d4IAtz+XuIyZVjkO9KR/7vWUqgURFOy+Oe1P50ndAJPyFC
 WQEYrNzVj93p0U0lAzSDxDdPZ0gXy4eKyQBhPggKorMX9MuxQ9L6rfeNG7VfR+FdyFcv
 xn6yPaIvPq4ibA+TCU0o0iFJS/43EHoch2s= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 358u4dbnja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Dec 2020 19:25:21 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 7 Dec 2020 19:25:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB4M3PqVf8gA8thxfcmxUqvOhXZJbmTq6sZMfd5sNBFZ5PWQHEDN/eJzrXqg2YkkjcHVytb4RXTas9D9TxFrKJI4w8winNgF/i4MQ9z/Nh3wIgbQYAs1CnZrYygk/Jol3IFErmscJDiuYaj4Y6vVrYZMx5B7H/r9UpxYoRY9GKyckbCnj9e+sxFeoMvZlCO+LwJNbPfjiM+i7HyBHAXa+muwvHTo+Eww++3fvwCdveMM+qn8FzdD9YunZcOgE89hKMcoEczl+DWHmMR+VfU2SIYZdS1jrOu9DuFg0g1xMGaMGgNtFwQJjGBku0kTgxE5jmV0eme9Rt1oLBwYKYghLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S61m4zdKmkJ+wD+/0Md1DULOfTGd0aa+RcBmIHyM+80=;
 b=PVUGg6EdsVVDW0C8DJJjnIolDV2JIowQw7CaggNAPjIUkQCL3mgVtZczonejCFaWWJvN10AtC0jIfL4wLONCUFQOq9ahy8swttBHVl15Cm8SQEcO9CVuk3dnmT1SBRS/yt4+kHRxsO/vgVTxJpysRXrt80uaclFv+TrpiYWj0bETKd+UJqiGV92sQaT3jrZALps5541o+B/H+qWL9dkXL1el2mwG0ovvBnUxt3TSo50nb7hs07r2oSTsUS7rWESmJSIQ0VWKCBRr48kJoSfZ3emIQtodUaYh4G+o6S60Oz3J4yccABq5PZm2dQ2knzAf7BheCBwCj8DwrAFXVe0Hug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S61m4zdKmkJ+wD+/0Md1DULOfTGd0aa+RcBmIHyM+80=;
 b=LFkONoQ/CR/f5xaGvrx70orzz/5bH7fhqS7QjOBv0wUj4hA64L23tq3C9P1qrduyLTzrd0cU7vhNx7T4wyxPsC1qiCc+EZFe7VZx+6y+HcdyYqTKtW0SQxg9HHnxqygttb4SrYo5myuneyzuxpZNx0piB5MXsPLBccRsOD7k/2w=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3413.namprd15.prod.outlook.com (2603:10b6:a03:10b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 03:25:19 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 03:25:19 +0000
Subject: Re: [PATCH bpf-next v4 11/11] bpf: Document new atomic instructions
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-12-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <7b82cf2c-e7d0-0969-d5ce-2d3341b31a52@fb.com>
Date:   Mon, 7 Dec 2020 19:25:16 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201207160734.2345502-12-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:4c73]
X-ClientProxiedBy: MW4PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:303:69::7) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::113f] (2620:10d:c090:400::5:4c73) by MW4PR04CA0002.namprd04.prod.outlook.com (2603:10b6:303:69::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21 via Frontend Transport; Tue, 8 Dec 2020 03:25:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 938db3e6-3ca2-4309-df76-08d89b28e3aa
X-MS-TrafficTypeDiagnostic: BYAPR15MB3413:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3413969BF7DD60E4CE2BE98FD3CD0@BYAPR15MB3413.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HWDc3fslYecZ5IQCjZxyDrt5Dp7mnBm1rx6PX1w+RoVAUrZE8y9ULyhn7xLEaXnhg8A1w7kC7POpUobXZMVQIkmyUW+DPcK4JlDBOOQW6p00MpiMVzsBPqOm/z2d16rCs/BeF1mO0diYqCPPTrgttUTyz+0eXTSeRv3Icr+qFUCsuRPSUezJGFLWtUWJMLg0iQLJgQ5PphGc32MumQivXE3vwSxZY3cVNmdG+1JNtndiHi2EMTMblDPuewfG+lT4ZGeokeUvzCL5+NAQL3NjCIhHoCoMG38uK+fd/vQzDtQuEEut/KoDy8mjrTFfrAK+MPbGfGUSOlgO8oa//65xEDILt7rV7xQNHNTt64jCsiZRPjNMXBvRbMo1/6JPsnrLMiSWtuWfTprF+M3GAwlft4eAVy0rTCK7lPqTKSVFYhE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(396003)(346002)(136003)(66946007)(66556008)(31686004)(2906002)(16526019)(66476007)(478600001)(8676002)(36756003)(186003)(83380400001)(31696002)(4326008)(52116002)(8936002)(2616005)(86362001)(316002)(54906003)(53546011)(6486002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dnJEcURma0xQUVF3eFl0UENoS2lKOVJ1VWE2V1dkSDFlZ215RmIyZDFxMHVR?=
 =?utf-8?B?ck1vUmt1SXJrTXloSTNGenFsTGRmQ0lmYVhZdlFYNEc0UURhWWZHQUpUVVMy?=
 =?utf-8?B?QWpoOGxxK1VDeEY2QUtlWHF4QWUvc3FJWllwM1Ira3dSOCs3K01ac2cxUkZx?=
 =?utf-8?B?UXlySWxLc1ZtRUpnZUYyeXlyZDFadWRHM3prdkFqcGJUbTZkckFqK1ZtTVI3?=
 =?utf-8?B?dzNZZFdGVEt3ZUVWOSsxaE5zTC91NkVxSmczZ05INmRTd3BkUmJOU2dSdmZK?=
 =?utf-8?B?RFZjM0pOaTQxamtDUjB1Tm95Y1dVeVBlN1psU3JKTWJPNDNnRm1nQ0ZkRTl6?=
 =?utf-8?B?T3V6cWdML0s5Rlo5enBYZkdvVFpTU09xazB1NDhxeHRaQ0s2WXE3Q2RUTTd5?=
 =?utf-8?B?MHdRVTZZcUVCNFQzOGdXYnJlSWV3enc5cjZRM1dGcEJXY0crWTFZWTV3cEx2?=
 =?utf-8?B?UERUbmtXbDJxdU5SK2V2ODhMQ1oyQ21qeTBxSEIxSXd2VGRmZldic2xpWE9s?=
 =?utf-8?B?bktIS2Z0UDJXME8weG5vN09EZVRqZU53SWpnOG5LNHhGWFdwTk5ScXJxeldo?=
 =?utf-8?B?ZUVNK0lob0Z6VGNaV0NsQm1uQ09TTlNmSWdKMUsrWCtiUUZ5MWhRTSs0UVNI?=
 =?utf-8?B?b2RZWjlyV2RaaFBCUnJxcVF0Y0Z5U1pzUXUrK2JrNHlGTHhFbXpubXozZDY3?=
 =?utf-8?B?U21xc3p0QXFLUEdmbDA2c2xBZWZJdExILzRJVXdRN1pJK3FHb2MvVHlPRGI4?=
 =?utf-8?B?aDRyOGFPREZKRDJvcnJuc3pqQ0JvU25XaThTSjlEQ1NqTGxjdXZKZ2licWZs?=
 =?utf-8?B?UU5OZ0dpczZSb0w3djdkdTNGKzFITDh1U3EyOHFZWDVldExWNDNhenlJVlJn?=
 =?utf-8?B?V1BvRFpDcVRhVllhU29NR2MxWTFwaHU2WTRCTEFFcFl0VVhyMTgvR0dpN3pT?=
 =?utf-8?B?ekRwNyszdFRBR2FzTXAvbWkvbEdqQUI0RTRLRnZ0cGtzcUQyRmd6WnFHN2k1?=
 =?utf-8?B?ekxySnp1Ulk4Z3hSYVdhSkE5cnVNcDNjNWthWnhiUGNDYy9ubVhrNFc0eFFJ?=
 =?utf-8?B?ckxsQXdEellkT1FIOXRsc3FwelVqbEs1T3lTbmhkZjJlQ2oyeDlER2UxTkVz?=
 =?utf-8?B?ZWVrNFVHM2VuZkd3WDBEOFBEaXRPOEh2dlc1OGFpUVJDaUZsM1BsdW9paWNJ?=
 =?utf-8?B?c1MyMnRaOEd0Rk51NVkvNm1nVnN5SDlvM1FZbGRnWGh3R0h3NkNqSFliVWZS?=
 =?utf-8?B?UENibVdqa3hxbno4eGZGVlU3U1JUTGptN0dNWHpyWjUvRFZ1ZmJQbWV3U2k1?=
 =?utf-8?B?NEVKd2VQYU1UbEpCdWM1VEZYRjhuWHg1RkR1KzdmbXVDejJnanZYVmh3cW0x?=
 =?utf-8?B?YlNobjNETm1TZEE9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 03:25:19.2109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 938db3e6-3ca2-4309-df76-08d89b28e3aa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2P55hmGOjuHnX8mgdNulCfd2zDiftMIH6NlFaRlUYxXHt91z3w/LUM5RHhIi108V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3413
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_19:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 adultscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080019
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/7/20 8:07 AM, Brendan Jackman wrote:
> Document new atomic instructions.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Ack with minor comments below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   Documentation/networking/filter.rst | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
> index 1583d59d806d..26d508a5e038 100644
> --- a/Documentation/networking/filter.rst
> +++ b/Documentation/networking/filter.rst
> @@ -1053,6 +1053,32 @@ encoding.
>      .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_W  | BPF_STX: lock xadd *(u32 *)(dst_reg + off16) += src_reg
>      .imm = BPF_ADD, .code = BPF_ATOMIC | BPF_DW | BPF_STX: lock xadd *(u64 *)(dst_reg + off16) += src_reg
>   
> +The basic atomic operations supported (from architecture v4 onwards) are:

No "v4" any more. Just say
   The basic atomic operations supported are:

> +
> +    BPF_ADD
> +    BPF_AND
> +    BPF_OR
> +    BPF_XOR
> +
> +Each having equivalent semantics with the ``BPF_ADD`` example, that is: the
> +memory location addresed by ``dst_reg + off`` is atomically modified, with
> +``src_reg`` as the other operand. If the ``BPF_FETCH`` flag is set in the
> +immediate, then these operations also overwrite ``src_reg`` with the
> +value that was in memory before it was modified.

For 4-byte operations, except BPF_ADD, alu32 mode is required.
alu32 is implied with -mcpu=v3.

> +
> +The more special operations are:
> +
> +    BPF_XCHG
> +
> +This atomically exchanges ``src_reg`` with the value addressed by ``dst_reg +
> +off``.
> +
> +    BPF_CMPXCHG
> +
> +This atomically compares the value addressed by ``dst_reg + off`` with
> +``R0``. If they match it is replaced with ``src_reg``, The value that was there
> +before is loaded back to ``R0``.
> +
>   Note that 1 and 2 byte atomic operations are not supported.
>   
>   You may encounter BPF_XADD - this is a legacy name for BPF_ATOMIC, referring to
> 
