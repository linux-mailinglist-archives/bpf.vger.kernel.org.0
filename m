Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A644132663D
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 18:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhBZRU0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 12:20:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48700 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229863AbhBZRUY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 12:20:24 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QH4m3f029646;
        Fri, 26 Feb 2021 09:19:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=LhpTjjDSGnVPkAIEuvsauQnUYD+iOrd8NNjsdT55y9s=;
 b=aiexfw6dMvBK8kMFBBbnA+mAbbJ4sVWsjDneeGXjJ9CjVAVXhQFND9zT6xfSlbnDEIph
 AJHueUHyjdEB4+I2+bqLUHz4MMv3BWSOv8WBJopC9t5wcwLh/ML0jixzao8LmYhg3Szk
 CPAimwhzQ55wRzhvyLn1V6XLyspIgSu/fek= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36xkfkd34d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Feb 2021 09:19:28 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Feb 2021 09:19:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irU7kQy55AwdHb5rUUSHfgOjeR/BSUsuOyTePW3mphkSCWL2EyauD/pIM/ovlQj/fjYcmPsx4ZYQpHBRelF1caLlzz2Vu2vY8YBS8BrogcSqnXKbYFuv7W/qCLukT6Uchr+9pyMmBP8YOwWyp0+MwebPwFM8cGxoph7algc+f7NjmJ3HSH2L9TMxG6spjOpCGFg2Ka6GC0SKJuABc2jrD9ATP5W/FoBJzZ9UCTPU9qcjxOBZQGdYt0h05+BFeVAJOuV6JzQvUe4X0yE5GlmxodMTb72uL4Y0V/xCY8GOFA/sSACvFUv6Blh+GRyWihivXF/302+5SbpEqjgXSq1MlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhpTjjDSGnVPkAIEuvsauQnUYD+iOrd8NNjsdT55y9s=;
 b=ZzZg9pWcMgUpsA6UsSjgJT0S+E0DY18cJ3Ey3ije5HQcbpTsKl8/IBBNwrXJOhp6SY0xT5eV7yYo6Uh9Eh5apz4pcgKSawe8KT7xCwcDkuZ4HkjSPuV90LacL/f2qP+Kgfmq6GdWW6NALxdmh4LA9+py0FHZAQjNC/GhAJ160KhO289UcjgwC7RjAFR/5av+8bO/vzLWdipqohpr4dbmRDi7VcCxxGH8GD+mV+VvEuRyvAHeDAKvrg2bsPIPlayYZBP6dzUfTPRyA/yZY2ltXDWEaTDYk77A5uWvELNj7/zZT7YE1WB7MD0qsd4rXPDM/xNObh9LMq29H+6uSYWRCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2480.namprd15.prod.outlook.com (2603:10b6:805:25::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Fri, 26 Feb
 2021 17:19:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 17:19:25 +0000
Subject: Re: [PATCH bpf-next] selftests/bpf: Use _REGION1_SIZE in
 test_snprintf_btf on s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     <bpf@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210226135923.114211-1-iii@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <9715c71f-f258-5a3b-af4c-a9c56b2b53ad@fb.com>
Date:   Fri, 26 Feb 2021 09:19:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210226135923.114211-1-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c091:480::1:9651]
X-ClientProxiedBy: BL0PR02CA0086.namprd02.prod.outlook.com
 (2603:10b6:208:51::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11d1::15dd] (2620:10d:c091:480::1:9651) by BL0PR02CA0086.namprd02.prod.outlook.com (2603:10b6:208:51::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 17:19:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51b0f648-3fda-4bd7-b714-08d8da7aaa94
X-MS-TrafficTypeDiagnostic: SN6PR15MB2480:
X-Microsoft-Antispam-PRVS: <SN6PR15MB2480FDB20F3F9AB1220E2465D39D9@SN6PR15MB2480.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lp81yYRzuZvJpR1Op8chYCCbU9suqZNLmAZBwzbD08fucmWvgRBET9FgHneALZHXn3oOsxvRBOMjsgkI1ouVeTNmmAVSzrBYLZl0FayEK/ND6zL4S0PfOzHnXeU9prXqSU7Zd2CxNouT6CLWxM+mVIhsa66mqqBysdByG4KqezHbcoLYGJX+e5paUnKm2cL5Wo3aMx0Lv7QIJFLwItgBFzGVeX9sfzFko1Al8jViz8Ojz/rUW/C+53g8q5WWn7A9Y5K2A8Srd119sF6rQmRG1Kr32/i6V9b+3/uhGUDaZiWqbXXd36T9dVFWU3NLJqJW0711dURxmtISzRk9JQNusMLNOLqfyRtahoUqgmQjSgu9WJ/fCBI/InLOHDDfHPrU+2sRrjyKV45inUtsZE2QxeWSTsuqke6NjPVwzzw5futrWo5ydf4CqTOvYt3kAOjZ8HylyRg3f2EhsY6jz31ce07kGBGPUSuvQOdw6lH0IhjFJOLbLhtTz7diS/FE2iJiv63Zrw9eUUxvXy5vNeL8BI7ny2xdxfPAfkQ5+RISrplF+HROHcTHdmswYbuKOczsdop0XDIrAT7u8TWcO8KezpnawxY3YHJBikcykDfC508=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(396003)(366004)(39860400002)(2616005)(5660300002)(8936002)(186003)(316002)(53546011)(66946007)(66556008)(36756003)(31686004)(6486002)(2906002)(54906003)(31696002)(16526019)(110136005)(478600001)(86362001)(52116002)(66476007)(8676002)(4326008)(6666004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VDY4aWFrbUZ3ekoxeXpER25GZkRxbExCWmFudkcvVmVjUEMyNEhodXJMWGN3?=
 =?utf-8?B?eE82emdVUmViaExuQXRJZEtRcFltQmRyb0xsZE5WcURhUjJIRkFzd1JCTEo2?=
 =?utf-8?B?ZFdhcXM3Rk1UM0ZHRU5yVjhOZUcyd3orS0M4UDFnNzlSM2pQZVJZdHpSUXlZ?=
 =?utf-8?B?Rk1UMXRqaCt3cWNZc092Z251S3BwYVJkeFR5cHJjT1JIdUhpMERSMHJ6eVBY?=
 =?utf-8?B?TXpLMm10RVU3dldOZVhPUXdDZVRmWi9LY2VWeHNHUFBKcFBnMnA5RVUvMCs4?=
 =?utf-8?B?ZWliQ1RSTW4yd1l2Y2E1aVp4MDRORU95Qk0xQjhtMG4wRXU3bTVzWDFkMmZO?=
 =?utf-8?B?eWpic2VqUk4za0UyTzlaaVlDbTYySkRFWU41NUtXVE1ZYkxlalBMRjJ4Tktw?=
 =?utf-8?B?Qk9EOFMxM1ZJMjNFT1lLWHVtcEd2YVRQZlN5VjFSY0N5eVJDWmlwWTdJdkVE?=
 =?utf-8?B?dGRMTCt1a0ttWEJDamZLbEM2NGsrTzFmaGROVk1DWUZxeGVKc3lvbVZjb29O?=
 =?utf-8?B?ZktqSi9nSTlBR1J5bkhJMkZoOTViTXN4eTh0bXJHN1JTU2ZlVzZoUnAyWDZk?=
 =?utf-8?B?Z05JL2pJQ05jcDg1TXJFVFFSSktVYUhZOUdVM0ZWQUxpdnl3M0hSMVNpTlBh?=
 =?utf-8?B?czRDNWErWW5wZTVnZ3hlT3RSckl5RnFaSm5zVzJDRC9qUWNkTkRUdlBXSk1P?=
 =?utf-8?B?Uk4rWTk1RVdpVVRmNDZVcEN5RGZMeTd5RUVPUkttK0RsSVVvbm5wOTkwbHJu?=
 =?utf-8?B?SHNSYTA2SEJOdkl6Q2dtUDlvdHROa2IwSXJlUCswRHM0dEExVm5iNzJpcnNM?=
 =?utf-8?B?MDlVQlFEWmc5MS8weVlHcENYVkd0eVlGcFV1Q0tvMEQvQm5zbUdOQUtxUzg4?=
 =?utf-8?B?N0g1NHBkdWVlNERJKzlxOGFiVWpPTkt3U1hvTFFEL291bFJpSlEwMlhoV1Ir?=
 =?utf-8?B?T25PY3lJRTNBVHhSSjY4WDYyancvb3VYUXFic0JoeTU1Vmp0aWNUQTR0TVEz?=
 =?utf-8?B?K2FKbWZwam9obHNqelhKSmEvY3JWZUptQzlsV1lnZVNsamVtYXl4NFVYMGVE?=
 =?utf-8?B?c0c1ZjBjVGllU0JrNnh1NWV0U3VBWDZ2WHh1OWNkWEpRc3hXRU4ySWlacWhV?=
 =?utf-8?B?T2pMRU1WZzFDTml5L0lKWThidXE5NXJPbUpLM3FFaUpGYUpvMWswNytYN2pa?=
 =?utf-8?B?TitUWlB0cDdkckU0Y3lwVmZTY2QyYUhVUlZpVFEzcEM3UXRhb2dkR2NoRXg1?=
 =?utf-8?B?U2laSUlySW5SMjVLUENGdklSSExkSmZvTEQ5YnVnb0lXOWRpcXc2c2VJTGFF?=
 =?utf-8?B?bElITXRXcFEzNGNkczRFa1NBNFBETTB5cCtKNVFQRnd6cGNuNGVaY2ZXdXRX?=
 =?utf-8?B?alB1UkNGZ0dQNUdQMXU5YUZGeU9sdjQzVFN5Sms2eTlBMm5oVUlIZnpGN0Nz?=
 =?utf-8?B?M0svd0JDNWU2TWE5RWRLTFQxU0d4UytuNm9IQ0tTZUMxUFRmTXViUytNSTJj?=
 =?utf-8?B?MFE1Zm9GZjVadThTZjNmVzBMWnQ5aUJ6blJUUWFDeGNobFFzT3JvUEFKQ2Vq?=
 =?utf-8?B?Q1V0VTNlSG1nMkdVS0w0TXFhY3ZvNmtrRERleStnZDdFNzBCVDJVVjlZeUpQ?=
 =?utf-8?B?aXgyQXRnVnpiUlFGbHlsclkvYTViVmFuWEJocW5Mem1qMVl5dlNlYkxVTDFY?=
 =?utf-8?B?UlJwMmNFK0dZc1J3WUJCYU9KeDdsZ05QUkVZd1VFWCtnYmI0OTNpMHptUW5z?=
 =?utf-8?B?d0FJVVdwMldURk9HNzhCcEJkTUVqQ2NpUTAxRzQ4RnQwS0V0aTRwY0lKZWxQ?=
 =?utf-8?Q?fgDIIRlanT9cyLKR5w6MqaW6Ae14TfKRKL1YI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b0f648-3fda-4bd7-b714-08d8da7aaa94
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 17:19:25.6582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IyFb23Ol6uHe549Yvp+Yh2lK/uqXpLqgw7Q3eQv9AcH5u2n8PvdR44IHB+xuL6mF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2480
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_05:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/26/21 5:59 AM, Ilya Leoshkevich wrote:
> test_snprintf_btf fails on s390, because NULL points to a readable
> struct lowcore there. Fix by using _REGION1_SIZE instead.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Ack with a minor nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/testing/selftests/bpf/progs/netif_receive_skb.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> index 6b670039ea67..fa54d2abc41e 100644
> --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> @@ -16,6 +16,13 @@ bool skip = false;
>   #define STRSIZE			2048
>   #define EXPECTED_STRSIZE	256
>   
> +#if defined(bpf_target_s390)
> +/* NULL points to a readable struct lowcore on s390, so take _REGION1_SIZE */
> +#define BADPTR			((void *)(1ULL << 53))
> +#else
> +#define BADPTR			0
> +#endif
> +
>   #ifndef ARRAY_SIZE
>   #define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
>   #endif
> @@ -114,9 +121,9 @@ int BPF_PROG(trace_netif_receive_skb, struct sk_buff *skb)
>   
>   	/* Check invalid ptr value */
>   	p.ptr = 0;
> -	__ret = bpf_snprintf_btf(str, STRSIZE, &p, sizeof(p), 0);
> +	__ret = bpf_snprintf_btf(str, STRSIZE, &p, sizeof(p), BADPTR);
>   	if (__ret >= 0) {
> -		bpf_printk("printing NULL should generate error, got (%d)",
> +		bpf_printk("printing BADPTR should generate error, got (%d)",
>   			   __ret);

The previous error message NULL implies address 0. The new error message
did not print out the badptr address. Do you want to print them out so
in case of errors, you don't need to search source code?

>   		ret = -ERANGE;
>   	}
> 
