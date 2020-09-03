Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CF625B897
	for <lists+bpf@lfdr.de>; Thu,  3 Sep 2020 04:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgICCKj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 22:10:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54718 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726177AbgICCKg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Sep 2020 22:10:36 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08329fV3029377;
        Wed, 2 Sep 2020 19:10:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=0OiUWUrc6aVTMdBioYdwJq3TnNvU51sfDubGjxB2RbA=;
 b=co7cooJjqkzoOBDz2MsvhmPy8T1Whd4qamTh48sBzFF72KjVcHtZRuqvgRhcLKF/R3hX
 3oXV0xLt5FviX+dYF/WC5atNK8hP4c/7KCB117xgjy6dwox7ONuGMt5FpOdyNtzGzqA4
 IOA1YJu+upZ5fSvODXZ8xK/LfseVWqSyfAY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33am8e8t91-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 02 Sep 2020 19:10:20 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Sep 2020 19:10:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxZ8NNOielogt2ZbGUlvvn1iG4kl0Q7vQAsR0HUjqfpogd/DzOD3oObjT3q/m8naA0/e5hQuSb2B9u3Fbzpqch5dsa3U2QV89j3W+gV78UybQqQ7cIoqCYHP5kFEYl+WnCz3JdC1TBsjB9jxY2Q+yqde9zg19JKY5YQMZH4NbWpYIgzAlR5TydL2RKVvq+YczVr9jd/AdMEsx5NlXR/MRvagx5Gxmc4cyRAdneE12tuzZgdO9f+1p2YioSyvpKNpOXw5He22jCW+uBe6i2x6/8x0yvJINmaktP4zA2AEYq+cWB4o3PeMmCmgo4t6qlTfaT5xb1NBMtoBTZuMpGumUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OiUWUrc6aVTMdBioYdwJq3TnNvU51sfDubGjxB2RbA=;
 b=LQKHowKOzV0Og6iW6h0a1Imyun9J8fKV34PF/ZsxJkAHcWpocROD6s1MyLCuofJSgVf7e3Juce901ZQguFI2vfzcJgMyBI5RiXoh2QVmWEu8i3Pte95JKBtUP33RE455Z6D6SDqEjOf2Y2hqBAGDEolKFkn0ZiaI0IpSrx9oXCZbateDCz2XmkVonLrRnEmlUJnM3sB5yTH6gxRyDhhfpsM+YQxUK1HUNjMQLwF9zx2HmpyB5U0dDV5oFyRg3Dje4ea21Y3N1eS49YHvg7bMBaXpjywthIRpqUcTh0eyISdHkqeO9v/OsUuiJi8CaA+s2S9R16fFpeV1chQNaIbl8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OiUWUrc6aVTMdBioYdwJq3TnNvU51sfDubGjxB2RbA=;
 b=jn58lgfiJBKlZX8W+spGDGM4AbCZRi7STMpKNVyGBpOWhNSnsdR3c/mOXlFKxAQGnueRYO74ilFJakD1Y/B8PzG/F5luBDsjNwH7VDwqpYEvHGttDEjT+qCU/kYllPqAWOyref3SdI2AY/KfNzs4Ycc9g+KAEvXg6dyCvZjRbRs=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3572.namprd15.prod.outlook.com (2603:10b6:a03:1b2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 02:09:56 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 02:09:56 +0000
Subject: Re: [PATCH bpf-next v2 2/4] net: Allow iterating sockmap and sockhash
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
References: <20200901103210.54607-1-lmb@cloudflare.com>
 <20200901103210.54607-3-lmb@cloudflare.com>
 <CAEf4BzavEyerq8an-rwFi5GRGtrOqObnCBx7jAbx-GmxA4-9-w@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <4d758925-15f2-43e9-cc0f-109a9e5137d6@fb.com>
Date:   Wed, 2 Sep 2020 19:09:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <CAEf4BzavEyerq8an-rwFi5GRGtrOqObnCBx7jAbx-GmxA4-9-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0053.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::30) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BYAPR06CA0053.namprd06.prod.outlook.com (2603:10b6:a03:14b::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 02:09:55 +0000
X-Originating-IP: [2620:10d:c090:400::5:d32f]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be940aa2-15ae-4fe2-89ff-08d84fae73cc
X-MS-TrafficTypeDiagnostic: BY5PR15MB3572:
X-Microsoft-Antispam-PRVS: <BY5PR15MB35722624F3AA0AD3EF9D108BD32C0@BY5PR15MB3572.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzVXKUcgBhszVITvJWSsdsaYthdkAv1mNEFgGSY+mVhL7fpyUy6ncZWMJXCjdmZPSZs0xMVvrIbT0Cd2HbqN78wdeAvRZ0+YGqnFFSlf3+ChxO0dbfrDKKNrj4X1XHa6wtE5ZDfR/Mw0+iaDiBQU0y61FcpZR2AGMu3wjnGDExgYGmmQYvPue4nXXA/4kWXB0LZK9+DNr2YxPYx7+Pw9TF3Rq2MoQ6CqaVVLt4bfCqurTlk3WC8T4DRsMxAsj5ngHpZQ5dcPMYb8PMISS8F1nAM6ZCbnr7E9cNVclkmT5fBSPtvVVqeTvGhuVo7rlusa7jd8Cm5eFOBGN+23BUYlXpUbCrh42UZq6qyzl0eAszU1/6gZl4wllEIP38mOB1Mz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(136003)(376002)(39860400002)(52116002)(4326008)(6486002)(66556008)(66946007)(53546011)(186003)(5660300002)(316002)(16576012)(54906003)(110136005)(86362001)(31696002)(956004)(2616005)(66476007)(8676002)(31686004)(36756003)(83380400001)(2906002)(478600001)(8936002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: zopGrQxU7Mt/ZXe9kIbXnDg6nwHoV353/GWiFz6GjdaJqaviXniPoj6loQi+iGq08oKVOzBGNF+/ojGzLH/XVmXEMHng7/98FgQvPe0Fge467ONnB6C8pjIsrVE0jrkL8NjNI/5d+y+K6GHeccR+oZoHA4qqcOuvl90WRW6c2vIm7Kdho0mfDN4vPUJlDB86hqoi804pVLViQvDTC5HdA/n8YyTgoXhLzHgfelsfMgQbflpg6zgjJZzsIPDkR2+Ex8Chqi/FrY1qTxeGhygyUt2KlDzLz7R5dHjNX5yqP2Ml9hsC/RJJj5jPFlqKZgVj6+llLJMtfKsERMi1HnQp6GI1fTv259drhe5MRUB3ag/0SIVKCH2V2fx0hq3N7tX1fAFDyLuJ7NorgM5FSPSYl3shOEiCZxLm3px64Ghc5IPoTQSeeK4oN8ipUNbKyz+cCqPg/hWW/noYcev5VihKzwikDnXqVl5g6kIGwdRYbnuuGg7kHlOiaXE04ZnGTbnTDzyDO0pq46t9anIqfgOWNbrpyCxxt0jb72BZL7OPVSepRTPpaE7PV17JcbOUjWhuGwi3Fvv88Hx4xJ3jddUgcQHS5Z8VM7aEVjNdfksj9oAkppathpn+XOLgtOxrNHOgLtJyOk+V8F3fL0TF41EH7JyEv8cbfdB0FR2cfdHQ8jI=
X-MS-Exchange-CrossTenant-Network-Message-Id: be940aa2-15ae-4fe2-89ff-08d84fae73cc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 02:09:55.9912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAsPlurFtZ0yUk5wdFr96jfQykut7Tx/+xIJqe7cZYesgEa61oNOph2F+JQ156p5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3572
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_17:2020-09-02,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030018
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/2/20 6:31 PM, Andrii Nakryiko wrote:
> On Tue, Sep 1, 2020 at 3:33 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>>
>> Add bpf_iter support for sockmap / sockhash, based on the bpf_sk_storage and
>> hashtable implementation. sockmap and sockhash share the same iteration
>> context: a pointer to an arbitrary key and a pointer to a socket. Both
>> pointers may be NULL, and so BPF has to perform a NULL check before accessing
>> them. Technically it's not possible for sockhash iteration to yield a NULL
>> socket, but we ignore this to be able to use a single iteration point.
>>
>> Iteration will visit all keys that remain unmodified during the lifetime of
>> the iterator. It may or may not visit newly added ones.
>>
>> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
>> ---
>>   net/core/sock_map.c | 283 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 283 insertions(+)
>>
>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>> index ffdf94a30c87..4767f9df2b8b 100644
>> --- a/net/core/sock_map.c
>> +++ b/net/core/sock_map.c
>> @@ -703,6 +703,114 @@ const struct bpf_func_proto bpf_msg_redirect_map_proto = {
>>          .arg4_type      = ARG_ANYTHING,
>>   };
>>
>> +struct sock_map_seq_info {
>> +       struct bpf_map *map;
>> +       struct sock *sk;
>> +       u32 index;
>> +};
>> +
>> +struct bpf_iter__sockmap {
>> +       __bpf_md_ptr(struct bpf_iter_meta *, meta);
>> +       __bpf_md_ptr(struct bpf_map *, map);
>> +       __bpf_md_ptr(void *, key);
> 
> For sockhash, the key can be of an arbitrary size, right? Should the
> key_size be part of bpf_iter__sockmap then?

key_size is available from map->key_size. map->value_size is
for value size.

> 
>> +       __bpf_md_ptr(struct bpf_sock *, sk);
>> +};
>> +
> 
> [...]
> 
