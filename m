Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5868C24A230
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 16:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgHSO5K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 10:57:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33220 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727018AbgHSO5G (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Aug 2020 10:57:06 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07JEkinv020477;
        Wed, 19 Aug 2020 07:56:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=IEJfQcVYsaEkyro7hHviEPsXXn6GZCxeiKSucVKLWho=;
 b=OGmKRee361qf3iyyejjtNKIfh0+rPeFBafm+YdcHcZQJtBUTzFdjGdlkI9gUgBwjP3Yq
 E9R+G4t4XhvWqcxXs20rHSLAedmCN1kEt56r65HrTVWL+OK8o0E89lAHTbch6TA9fzxD
 gQJr68mn7KAoYLrNehc+Hm6+00VTT0qa8sE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3304p3gwdq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 19 Aug 2020 07:56:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 19 Aug 2020 07:56:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXkQPAhKFQCxBo2PdEGmypJfEUB60QbmNTAqnIwGApWtoXXt0s9kMxtktxV74+NCeMy9mao2VK030kiYvXD4XRVCwNJEv3hzGnHkiY/juMfLHIlglB8jnlSdZtzG5HU/6CC0z9kw1fyUjodShU4bVMcI4BYE/ywwBjyyJf6EZ5+C81ROI5ev8ffEEyUNA9y49Q2kcDJ22Vov6xqMjmj0YaMp/thQlaAyviBUbMui9o8AUHYES8p8sIlWQjyHedphaoPJWz8cyWXHGfvYPAByAUuTaLyK4GPm7QxszdU3bzIJasCDrUmQGQrxdv9Tz9zMOGf5ZMCOjPQOnybpnuGrRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEJfQcVYsaEkyro7hHviEPsXXn6GZCxeiKSucVKLWho=;
 b=OWc/nRyDfA3GeP/At+vzQ74XV5lXO9isSxvAEc3JNal9xo9XmmUB6igHcw2X0q/3cWYV20n4XZF+J+Jv+vqcNvNcUty33sfdSYqVjbnbzBcd/2VZaqjqABiczduQcVWIZrGeJNArhnijv+w/Xi36w5uOjhENOf0eGW1ffbj7vnZnY74B/uHutoA0z3yCJV4AIJXr2QlTvTU3LIB9C7j1R86XRhsgggYluyQR3OPtQroEfMmemjusSC9fSQ0aIbPU0S8GfWHIPXj8j9fNsu2+h+nyv0ysp8plLCQwDKlwAvpRJmJ7DMslaMlYzI+F1pPWRqXKcTpDbIWJ/Tg6k9+Avg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEJfQcVYsaEkyro7hHviEPsXXn6GZCxeiKSucVKLWho=;
 b=hJEaad1XHNij+QV3xjyD9sLW4peBv1MMw2pKwDmVM3skYIbsFhJY4J3CtslreEot0ABBVyxqh5EiOWVfMCagPthW+KBtHoXbm7wseg102SD2M6HCV+bVi1s4LJZKz7R7gNvHtG5klLx0BQsV4k5/pH5gW0W8MSp4jALrQkXojjI=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3618.namprd15.prod.outlook.com (2603:10b6:a03:1b0::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Wed, 19 Aug
 2020 14:56:41 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 14:56:41 +0000
Subject: Re: [PATCH] bpf: selftests: global_funcs: check err_str before strstr
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
CC:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>
References: <20200819023427.267182-1-yauheni.kaliuta@redhat.com>
 <66d63f42-ce71-446a-7ee2-586ffcea160d@fb.com>
 <CANoWswmccdLu4mCj48iVH1_Od4zZ=BdgCHZ0CMyieYQ9WxoHPA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <1518db68-6699-b261-7b6e-2d71c3d9566c@fb.com>
Date:   Wed, 19 Aug 2020 07:56:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
In-Reply-To: <CANoWswmccdLu4mCj48iVH1_Od4zZ=BdgCHZ0CMyieYQ9WxoHPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:91::39) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11e8::10d3] (2620:10d:c091:480::1:9a2) by BL0PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:91::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.15 via Frontend Transport; Wed, 19 Aug 2020 14:56:40 +0000
X-Originating-IP: [2620:10d:c091:480::1:9a2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 013fc913-076f-495c-98da-08d844501511
X-MS-TrafficTypeDiagnostic: BY5PR15MB3618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB36182F4EF1C7BBBA055BB266D35D0@BY5PR15MB3618.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AFGwD1T/XFrOeI/do0I51MvYchiifHxCCES+WfE13Z/CT9dNNXDIufnJ7+EihmoBkUe6XtCO0dUdRyT4sEGCaXh+RsNOwa7XDw+yAzIYOHS9eu0SjY/+lzUMGCb6tSWEt6kv1n9YXnZGD8oAYOejx+PHzPd5+JNtK/TOrorNSNHXKv11O4GrI7MsjtvJ2qsIv4YQ9IEwc3GOuGvMZA/HWmIKAn12F7GYFzEQoCec0m5h/xJHAR0viKncm0dNb4xEi4fYOB3D5EHpmld0JJm4wID5InjgADfgT3uHQRFaaFOda7RN+5wPD+laSXRO3DT+Lbvx5ArPUUmJELyRQ6m9Z+o/y4HWfbUgqzpJTtiEZnOLVMTjB66nPyXkVxE4B2l+hQlnLhpLXRV0uMP0wTP4A22+mPG/b9ytYo34WhxkLtgT40DaEXz9MrEdPco6aVmBT+RL4vj5BXfeSEdmsSpZjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(366004)(136003)(376002)(6666004)(86362001)(66476007)(66946007)(36756003)(8936002)(4326008)(8676002)(54906003)(6916009)(31686004)(316002)(66556008)(83380400001)(186003)(2906002)(53546011)(31696002)(2616005)(478600001)(52116002)(16526019)(6486002)(5660300002)(13914002)(17423001)(156123004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: hjQXR0RkchKqgtptalhZ/HVhXvxTCiH736KiVaoL8Ly+TH+HVCwndGgwo/1EiVMxdcZCaJxoBXan1hjTwB5WEciG1ceA6LK6xyAvpMQkC60+EviUZ/9Y9OaIovkSI/fxIPNrM6Vb6q4/Txz2KjFWUxtVUmycZhKec7NU+vNhb15SIEtRyjWFEv/AME516lbtxB/akcXXfi3XVjong7TmvfBKQLis7fst1Ho0/9zq9yIM9pRhZK/R+wzGhghmgdxtePXzwgaAGERCWHNEZv1Q7qpARX4gFSm/6eFBcl+wDaR2TUe5vMeSIpuh6RZpZYsVYyPkWPsZlYSMsxM4T6acm6tRy8DtfWmO077Xhhqh76WrRxuvZE2JThHu1SfOjlkBR8JQ1nuIpPtJJ3h0CsA3WbtmiBL/ImzOUTXvO8YN1HwSEerXOAIpXXuUFPiCj/Jl08wO711oOutwKLnsC6KnpVO/gvSnq3oAkMM3aQwmB/gXHS8upTIoEhOIUrIU2R2FzsRQaO2t2/Zh30hOiSRDfi30aQHdpGpoP7KOtaUe3FWY9PR5MmzFfYREXsjBnxT65L1V39VSyjYlTNeuH3tgrovnoQrePikCvo9b/Jn0tTX0pgr9JYiFH0qJ+KHrJby4IFTM3VNPCK7SHEJ9FLnJ7PskZMWh1cu3whjBoMDWwqAIO3PDE4lCMWR37e2Tt/bz
X-MS-Exchange-CrossTenant-Network-Message-Id: 013fc913-076f-495c-98da-08d844501511
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 14:56:41.8160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBCnz1Ye1QnXDirM2PwHyyJGNg0QJ10SthS3XVv4EGhqFcJR67uh28/zTXxuvxoc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3618
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_07:2020-08-19,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0 clxscore=1015 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190131
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/19/20 12:05 AM, Yauheni Kaliuta wrote:
> On Wed, Aug 19, 2020 at 8:19 AM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 8/18/20 7:34 PM, Yauheni Kaliuta wrote:
>>> The error path in libbpf.c:load_program() has calls to pr_warn()
>>> which ends up for global_funcs tests to
>>> test_global_funcs.c:libbpf_debug_print().
>>>
>>> For the tests with no struct test_def::err_str initialized with a
>>> string, it causes call of strstr() with NULL as the second argument
>>> and it segfaults.
>>>
>>> Fix it by calling strstr() only for non-NULL err_str.
>>>
>>> The patch does not fix the test itself.
>>
>> So this happens in older kernel, right? Could you clarify more
>> in which kernel and what environment? It probably no need to
>> fix the issue for really old kernel but some clarification
>> will be good.
> 
> I'll test it with the very recent kernel on that architecture soon,
> for sure. But it's not related to the patch.

The above "The patch does not fix the test itself" a little bit vague.
You can say that "The test may fail in old kernels where <why it fails 
...> and this patch is to fix the segfault rather the test failure.".
This way people can easily understand why and the purpose of this patch.

> 
>>
>>>
>>> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>

Ok, ack with the above nit and one nit below.
    Acked-by: Yonghong Song <yhs@fb.com>
I guess it is better to send a v2 carrying my ack.

>>> ---
>>>    tools/testing/selftests/bpf/prog_tests/test_global_funcs.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
>>> index 25b068591e9a..6ad14c5465eb 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
>>> @@ -19,7 +19,7 @@ static int libbpf_debug_print(enum libbpf_print_level level,
>>>        log_buf = va_arg(args, char *);
>>>        if (!log_buf)
>>>                goto out;
>>> -     if (strstr(log_buf, err_str) == 0)
>>> +     if ((err_str != NULL) && (strstr(log_buf, err_str) == 0))
>>
>> Looks good but the code can be simplified as
>>          if (err_str && strstr(log_buf, err_str) == 0)
>>                  found = true;
> 
> Yes, but I prefer to use NULL explicitly when I deal with pointers. It
> demonstrates intention better. You also can simplify strstr() == 0
> with !. Actually, strstr() returns char *, so comparation to 0
> (totally legal by standard) breaks my feelings too :).

comparison with NULL is okay. You can just do
    (err_str != NULL && strstr(log_buf, err_str) == 0)
there is no need for extra parenthesis.

> 
> If you insist, I'll send v2 of course.
> 
>>>                found = true;
>>>    out:
>>>        printf(format, log_buf);
>>>
>>
> 
> 
