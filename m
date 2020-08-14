Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED4F244FFB
	for <lists+bpf@lfdr.de>; Sat, 15 Aug 2020 00:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgHNW4k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Aug 2020 18:56:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64344 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726213AbgHNW4j (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 14 Aug 2020 18:56:39 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07EMtpkG012120;
        Fri, 14 Aug 2020 15:55:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=FOkvAmEYIj5AkcE5mLVoc4HMAQzmC3gfqMTuf+gjtrs=;
 b=Yg6y+FHmwE5nTTefA91YmC9gljPqVOK8sLbcVlQ/cYdxNBeJt+w15u2+B05f9ZBKr/3Q
 4Gs/YVTI8RYDQuWI8+AGuE9UMdgmhFFlTEVmiDxAyorYokw2wlizxFjjdOQTscOVIYS1
 4YP4iKjzVwd1CO2UAFJZ6C2oAaI8uKpCsxw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32wag3eq0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 14 Aug 2020 15:55:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 14 Aug 2020 15:55:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dH8LeRuT9+vBj05uFAqjse3DPybQRwu+XUj9vGKL/QkeuLv3/ppfUGjO8Sc5In9Ni/6C3t8lQcMKRx0zCeaIM8SDNt8Q/fovm5Xho87mky+eBkslH1eMIyjkcd1VxRK9CKyqepZo/QDuSTyt2quTv/xr9xJN4HyDXvjXBl4nl/lkjo7K4C8rlD6zTzL21XYIDH4zXJ24VuiGzeVDYE94eTR0IGB0PEjw6xm3lozPrUH1XBKSVOcGWv6DBkb99K5kJfJgmFcQY8Puz9sR5yaCP9CfNuj8Fg36CwJ/UBegI8hJWrEV5A35dAXWGi5UaQ3hyHpNdZCZfDqVY8us8uVMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOkvAmEYIj5AkcE5mLVoc4HMAQzmC3gfqMTuf+gjtrs=;
 b=iYf2aWJGZbHGSSeY3XA4isSviy/vlU6k1/gVqTNDKFHPwpw7+FNtA2lxdgzcH5C/keLlkxAhCtjyIIvaun41iQAcRibmiPoXFsjHRxxIKufylck7KdepQs7PSN4VEpVKnQRwosR1dayqU6qYylyObspJC0qExBbebjhGeplUlOSZ+7Bxc+RrtFjYOpWcVfjz/pzlv7upRnVNcB/E5oNTsWpVfc08HickLlie7uD/Kg8EBZbJ+FoRqsjUzpcVy+alWqkQ0QMItORNtaiU+rVBY2QsE+FP1x/ap6+HywEDtHzxhJp5G7afVaGp6NrO5VUwPvvbiOwZIb4n+30A+isShA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOkvAmEYIj5AkcE5mLVoc4HMAQzmC3gfqMTuf+gjtrs=;
 b=JXEU5e7qNWMkpM+OD0yZNGgPz1z/JO/jHONF19qf8R8pshEfVuC7yJlweX6HF9A+x35ajsCguBUs0jMJKa2ixBAwCzEwSNwGDqWT9ZfaCGNNaskYQ68VFoU9s9MXC7VBSa29ta3JsJWwC48nUGAdPnhJwx5Xxr52AZmUucqQWBY=
Authentication-Results: lists.debian.org; dkim=none (message not signed)
 header.d=none;lists.debian.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2565.namprd15.prod.outlook.com (2603:10b6:a03:14f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Fri, 14 Aug
 2020 22:55:08 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3283.020; Fri, 14 Aug 2020
 22:55:08 +0000
Subject: Re: [PATCH] bpftool: Fix version string in recursive builds
To:     Ben Hutchings <benh@debian.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     <bpf@vger.kernel.org>, <debian-kernel@lists.debian.org>
References: <20200813235837.GA497088@decadent.org.uk>
 <1c00ee1f-5103-e8ec-7953-e09a1c0de707@fb.com>
 <ebf711740484b0a489f11b749d0f00d30be5a5b1.camel@debian.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <cda9dba0-230d-3cc6-7f53-6ee83ec6f81d@fb.com>
Date:   Fri, 14 Aug 2020 15:55:06 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
In-Reply-To: <ebf711740484b0a489f11b749d0f00d30be5a5b1.camel@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0032.namprd08.prod.outlook.com
 (2603:10b6:a03:100::45) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1963] (2620:10d:c090:400::5:fe0b) by BYAPR08CA0032.namprd08.prod.outlook.com (2603:10b6:a03:100::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Fri, 14 Aug 2020 22:55:07 +0000
X-Originating-IP: [2620:10d:c090:400::5:fe0b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb453295-e725-41e9-67dc-08d840a5177b
X-MS-TrafficTypeDiagnostic: BYAPR15MB2565:
X-Microsoft-Antispam-PRVS: <BYAPR15MB25655B35D6EC88A899EDE8D2D3400@BYAPR15MB2565.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oPyaKWs2Ok6WqKV/R43M91Y8dhMXc88ngiHTd4j4uLXBclYONEWnmxjQcjMflGFyLPQ2iy+LjWNd4vp3RWT2kAqBqI++62bEThFRh6FmZC+hjrH267Ddz+GPT5XtGn1fX3hMaUSLLHN/0PQ0u7w1OX7aKjZQx6FD9L0/jj4fvFJSAKAkrgIBB6EQE/Yv3U7IDf01v78X2XYrvqQkFW8QYtsj5Hnh1gRQ/afkD+6wiCvszA8xcWP9eFSXq92TvC6d+/qKO6zDPYUN9MqydY1fWeysX8G/prD/vBEDmFAy5A9bhdGJh0AMSqwNSEpplxXZDTBqW8nSzKCpo50QG9QlP2tu1iuVJ+8qLEihNYCcGM5veBG7b10zA/2kQCjQ+kve
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(366004)(39860400002)(136003)(8936002)(478600001)(31686004)(5660300002)(186003)(16526019)(2906002)(316002)(2616005)(8676002)(66946007)(36756003)(4326008)(52116002)(6486002)(66556008)(53546011)(31696002)(86362001)(66476007)(110136005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: zxksSG6mCc5c3Ccy00DBfK25aYdB17lEXqdwzcqloH+XSjC5Yje2OB2FHqhNvO5AolfborD8I5oa+cGEG5MDDz48jJqlE/muwi7d4xbEY0BKf0w7EfLc7NCPR9QiD+3tGgC3w7ubZXORWuA4wyA0ay3t8c8jwQEntsAxGg6JS4bnPGAMX+AlHtiIlmMB71WmeYltK+Dphq0BRCzPdCEBpn0gJtLYE+dn3ZkCLBZTW2EB8yDbvrTRoa7MR5xok+jyDhpTOFIYsF6QMGxRtWJnq3RFjLSPSB6nS0P/w3qn3rD4AviomNZfYbfLxYUVPG28pgFpiO0X71vow9dcpqP1SIuWxWNpUOIx/YHK3kCmhMCSRMLyGq85pBzfhagbiYJ//PP3kJnCoT9ruNlf/KKQ72ulC+vk/UplIEMc7ZvfzSZ8UltPoshxE4HDkZ1gt1LwWke4tix7i6kGBcmJ3rz0zJAnL5AGUqQOPVURk/KPCQbQ5/PidBU0E5gHGFFBR0NlicaQIAktpQXFgOBxS60m1Bqj2AFqZogCMaYCv1EkGsCylqZviIlaFudeyVcbfwsiTK4djsZSJ8KpUPIypwiFjawg3G2Mbi1GIW+jOb6I53MbtOHb+sp930RVhZkFBvVBmwsri/B6S55xBDrIAV/zJbt6/GflSjdwcymxUzz4W3c=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb453295-e725-41e9-67dc-08d840a5177b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 22:55:08.4917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIYO3OJlbBfAo8GMn5h3dafHr7HQ1M7o1sNzXPqC+06Go1GkZ0OwfplaBCF0PWc8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2565
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-14_16:2020-08-14,2020-08-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008140168
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/14/20 3:17 PM, Ben Hutchings wrote:
> On Fri, 2020-08-14 at 08:43 -0700, Yonghong Song wrote:
> [...]
>> I tried the following
>>
>> --- a/tools/bpf/bpftool/Makefile
>> +++ b/tools/bpf/bpftool/Makefile
>> @@ -25,7 +25,7 @@ endif
>>
>>    LIBBPF = $(LIBBPF_PATH)libbpf.a
>>
>> -BPFTOOL_VERSION := $(shell make -rR --no-print-directory -sC ../../..
>> kernelversion)
>> +BPFTOOL_VERSION := $(shell MAKEFLAGS=w make -rR --no-print-directory
>> -sC ../../.. kernelversion)
>>
>> -bash-4.4$ ./bpftool version
>> ./bpftool v5.8.0
>>
>> I set env variable MAKEFLAGS=w, and build bpftool it works fine too.
>> Maybe I miss something or debian changed top level Makefile?
> 
> Yes, but we don't change MAKEFLAGS or any of the logic around quietness
> or verbosity.
> 
> I assume there are other factors involved, as I've also been unable to
> construct a simple reproducer.

It would be good to know what is the exact problem, and then we can
decide whether this patch is the most appropriate fix or not.

> 
> Ben.
> 
>> I am testing against latest bpf tree.
>>
>>>    
>>>    $(LIBBPF): FORCE
>>>    	$(if $(LIBBPF_OUTPUT),@mkdir -p $(LIBBPF_OUTPUT))
>>>
