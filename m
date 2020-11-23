Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7082C13ED
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 20:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbgKWSzK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 13:55:10 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39316 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729298AbgKWSzK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Nov 2020 13:55:10 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ANIomP8025460;
        Mon, 23 Nov 2020 10:54:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GKlqCh57nZafzZP9Fx7xpm6K783nJnAQ160aoROcXJ0=;
 b=jsKTsUruAf5T76xgkWOmzvGAJRihgMvTMZFE5BYCRL5klwWpW9r4vXx3O7VvjMkHkt7E
 BwWl9Kscs3De9CyLOLLBnacm8Tj32Pg4sFONOTYCqCMKigar/pN2Kii7kfuThen686aA
 C2nG4kyCzM2YhhTDmHrLcUBKaRXcOt18lSQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34yk9g6160-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 23 Nov 2020 10:54:48 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 23 Nov 2020 10:54:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsdQFonw7paRkmvtJfDwn1CLOfXCNxhJVN8fmVu+ht8/17NiKN2JZhR9AAg+yBuzy2ZsQhw9d+pAV+I7IJqjqb5ULv2gONafRzE3rsPOuR6C8Jr7ZF+LpDIqL7icKi1+t+DD1NvKE38AS3eCFVOQfc3FKsxoqBkeg7EAu7an3g3paWTquhayba7DVDMPGoRQ7FTYyuiToxHxBDs/W8nVZNnoOLjMfh0sviPKZSyhX1gZ4C7aZlTOyHUgLx63uJx+raO8byqih5d9Iqs+AQyiJtqAr0P0Cr4vaWQGfBLykp6I6LDENHHTGmxYW03ae/2DFw/dItuVizUCeB+UIOByiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cZac0x1SgwuQBH8ZzXKYecZJObp2xIsp1Iy+PmTuAA=;
 b=lFsaIKyJtMEhB9/XjqkqsoZ9HULOvhGKsBT8OEAe4JkR62IIF6v/UAAXURvMwJItMN8KQ9f/+qDo42eh0GYFhdcxouHKIlGspCCqVCo7PIQ91I8MNh5pQBQS5vXeddMjJnSr8eiWD4YV8gRUESaIgMC+K+xyfAAKtcHFGQ0CiCz+U0kIaRS9U+Y6ObOpKpkPBSEf/Oxy8JkLxFjmL9KL2/jyUo4NhgzLVnoqFAtU83dwUratxgTE/ToduYmVAjWPISBEWOhIVhr9czyDJJ9v7KBx3irOxTY1i2fHAyFSwUG1mjrmrh8/D/oXv4z1/a4S8vW943x4kXfBkZSxfGC/8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cZac0x1SgwuQBH8ZzXKYecZJObp2xIsp1Iy+PmTuAA=;
 b=Lc/uppv3YDk3pbri9z5Q+kcUoxo2fYpmskbZuUdJaOEx74iEx4y2qTUJruUHGDQvK3RYzkmguuM5jE6hKnv5SUgM6oQj0qQ2Ke5LRR/Jz/5LIwKKCL1VUmBexVJtiyK7KI+KB77Clf9kuMNM/ZrK5XDxXj8ZnOB6VvV7E2d+MpI=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2264.namprd15.prod.outlook.com (2603:10b6:a02:8a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Mon, 23 Nov
 2020 18:54:47 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3589.029; Mon, 23 Nov 2020
 18:54:47 +0000
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Update LSM selftests for
 bpf_ima_inode_hash
To:     KP Singh <kpsingh@chromium.org>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Petr Vorel <pvorel@suse.cz>
References: <20201121005054.3467947-1-kpsingh@chromium.org>
 <20201121005054.3467947-3-kpsingh@chromium.org>
 <05776c185bdc61a8d210107e5937c31e2e47b936.camel@linux.ibm.com>
 <CACYkzJ4VkwRV5WKe8WZjXgd1C1erXr_NtZhgKJL3ckTmS1M5VA@mail.gmail.com>
 <0f54c1636b390689031ac48e32b238a83777e09c.camel@linux.ibm.com>
 <CACYkzJ6VEKBJnJZ+CBvpF6C=Kft5A2O5f=Uu4rTMtUiRKN5S-g@mail.gmail.com>
 <cf0d94ca-b6a0-1a1a-6cf2-a641002588bf@fb.com>
 <CACYkzJ6RK=bhdGphbK6VZoLdvEfEo9rtYKCS=-dfyt5F=AujnQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <7f4e1733-175e-288d-8c6c-4adc12f17ad5@fb.com>
Date:   Mon, 23 Nov 2020 10:54:42 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <CACYkzJ6RK=bhdGphbK6VZoLdvEfEo9rtYKCS=-dfyt5F=AujnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:fc96]
X-ClientProxiedBy: MWHPR1201CA0024.namprd12.prod.outlook.com
 (2603:10b6:301:4a::34) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1039] (2620:10d:c090:400::5:fc96) by MWHPR1201CA0024.namprd12.prod.outlook.com (2603:10b6:301:4a::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 18:54:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0e61470-d349-47fe-6c33-08d88fe13fb3
X-MS-TrafficTypeDiagnostic: BYAPR15MB2264:
X-Microsoft-Antispam-PRVS: <BYAPR15MB22645792BD457B23335DD122D3FC0@BYAPR15MB2264.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gqmiNXFVSj7/3xnwlmJwfdySAf9gW9WpSW1vU6W4xiJ3b3qjD67HYEnTJ6NWJr5m+LUx33esfRhJGP0ARQQ/GOvcGQFpfuUVgySl9rSJXguoJgTyh1KhZgav1TYQyMojvRxpQYP601P/r6StZcV7Wb7hG7iwJ/oL6D2qgHICXgUHgeq+yPdQg2SXVnr5zttJmmhl1I2jzml+IA3ZEr8s4oqKw8Sk5dmB/z7PHaPqdPsfGwE3BWuFxluV3ohudYslHexk3RS11H3Hwq4fOGD9LK83xShs6GxlGTFfkmzpR7BsUwcDSjuOAOaim7/eoJ666vu3uCcLjVFGI/3K6fDSZhwnEtz/dz2cZQ+Dw0JA7El8gkt6Efn50uzI9HJyd7mIxCi5tbBFHUdk0ShfNOhj2sEpXbp3BffGYu3WWAS9RYCXAaBdyylvaBH//jCNq5SsrFj82RG7tM7x+8+nbhBL97BB+q/UczM6gtgxH7fEXHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(346002)(136003)(396003)(36756003)(31696002)(5660300002)(66946007)(66476007)(66556008)(83380400001)(54906003)(478600001)(52116002)(86362001)(8676002)(6486002)(316002)(4326008)(31686004)(7416002)(2616005)(186003)(6916009)(16526019)(2906002)(15650500001)(966005)(8936002)(53546011)(573474001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: qY0GAU6chKQuyxQk9yURXdzp8zefiEeqHCfMWX4nlMnZug7+121s+rKyPwsLjR2Qts2Fe6Ur/aOsDinKBQ3ipuaZClowzmzDhkfJGAGmAIJI3+MsCObwHQRmFanboyaemCVWOzF0fXEEXKdwoe+NVbjCUGyfzSuGMVhDWGjH2A1sBqK69IIh4tJx6BHUzvERkLrfbwfv8exFCcJAVcw3L5poG4cf3nsBuYH5m3PLi0a/I5Wn1tzWb3zItJhFU8paZ/+pqt6yxPYUqEmF5WuIgTB4ZDrvANfYrR/NhbTwxBXdgcbRl82IsymXzTX8Co9/VvWBV19FCI6AumW+7TAf0tuoYv2abPlZzFMKL9I8X9FX0LsYImlWEdzKb8Zcx/qKdsRCLECTtyqBHdB+NyThQLqwjPMACEO3/VO6t3EgUKe+jLYghUn4VmDpkaN0O7HOxwzkyf2LYMG/XsFNE6e6KFp+Nz+fsu+zakrm1VrcRr/7h+aXJjRfSSV/0HnFOudmlqhP5bpIWGc8H59Amv+GBiVJz0pr8fAjLL2YWdqO6cy4K0KWRGBUbtpwthiNIoTrJt81haWc/p30+IAutVRb0q+8C8ofVPShh42FERTizkEvFsMygVNXz+OO3gHIOrRt3tRLMgVTJmtEK4vrb9IZEWGtBBFX2B/UetPR6ONhmZhrp1ekygXfvs8gmJmlcDSLvE7FehYlWUsUgk5WldCcxm1BNd3p+z+1alQrhPpr2JHWXMujF3UMziezRbN3PYJWledM6ebrzA7qhG7wG3oUYRYPkcyuVvm6pa72M2zNBQySlTfgq8PTWmxNMF9DbqOYECZdaNp4i3N3DrSV2EinyozeRX9FDqpbU78VjmLOIlVW+MzjPu17gwmHoRAT3tvPMgTkCmao8zd1rF+vnW1K3ueqt1oej0JH0P6CJekCTDk=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e61470-d349-47fe-6c33-08d88fe13fb3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 18:54:47.3341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELohyxauKy3dcfunfSROgrEN8kmureBuhq+BtaXpe/2rL6pDTkkomyFn7p31Vedg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2264
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_17:2020-11-23,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011230123
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/23/20 10:46 AM, KP Singh wrote:
> On Mon, Nov 23, 2020 at 7:36 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 11/23/20 10:27 AM, KP Singh wrote:
>>> [...]
>>>
>>>>>>
>>>>>> Even if a custom policy has been loaded, potentially additional
>>>>>> measurements unrelated to this test would be included the measurement
>>>>>> list.  One way of limiting a rule to a specific test is by loopback
>>>>>> mounting a file system and defining a policy rule based on the loopback
>>>>>> mount unique uuid.
>>>>>
>>>>> Thanks Mimi!
>>>>>
>>>>> I wonder if we simply limit this to policy to /tmp and run an executable
>>>>> from /tmp (like test_local_storage.c does).
>>>>>
>>>>> The only side effect would be of extra hashes being calculated on
>>>>> binaries run from /tmp which is not too bad I guess?
>>>>
>>>> The builtin measurement policy (ima_policy=tcb") explicitly defines a
>>>> rule to not measure /tmp files.  Measuring /tmp results in a lot of
>>>> measurements.
>>>>
>>>> {.action = DONT_MEASURE, .fsmagic = TMPFS_MAGIC, .flags = IMA_FSMAGIC},
>>>>
>>>>>
>>>>> We could do the loop mount too, but I am guessing the most clean way
>>>>> would be to shell out to mount from the test? Are there some other examples
>>>>> of IMA we could look at?
>>>>
>>>> LTP loopback mounts a filesystem, since /tmp is not being measured with
>>>> the builtin "tcb" policy.  Defining new policy rules should be limited
>>>> to the loopback mount.  This would pave the way for defining IMA-
>>>> appraisal signature verification policy rules, without impacting the
>>>> running system.
>>>
>>> +Andrii
>>>
>>> Do you think we can split the IMA test out,
>>> have a little shell script that does the loopback mount, gets the
>>> FS UUID, updates the IMA policy and then runs a C program?
>>>
>>> This would also allow "test_progs" to be independent of CONFIG_IMA.
>>>
>>> I am guessing the structure would be something similar
>>> to test_xdp_redirect.sh
>>
>> Look at sk_assign test.
>>
>> sk_assign.c:    if (CHECK_FAIL(system("ip link set dev lo up")))
>> sk_assign.c:    if (CHECK_FAIL(system("ip route add local default dev lo")))
>> sk_assign.c:    if (CHECK_FAIL(system("ip -6 route add local default dev
>> lo")))
>> sk_assign.c:    if (CHECK_FAIL(system("tc qdisc add dev lo clsact")))
>> sk_assign.c:    if (CHECK(system(tc_cmd), "BPF load failed;"
>>
>> You can use "system" to invoke some bash commands to simulate a script
>> in the tests.
> 
> Heh, that's what I was trying to avoid, I need to parse the output to the get
> the name of which loop device was assigned and then call a command like:
> 
> # blkid /dev/loop0
> /dev/loop0: UUID="607ed7ce-3fad-4236-8faf-8ab744f23e01" TYPE="ext3"
> 
> Running simple commands with "system" seems okay but parsing output
> is a bit too much :)
> 
> I read about:
> 
> https://man7.org/linux/man-pages/man4/loop.4.html
> 
> But I still need to create a backing file, format it and then get the UUID.
> 
> Any simple trick that I may be missing?

Maybe you can create a bash script on your prog_test files and do
system("./<>.sh"). In the shell script, you can use all the bash magic
(sed, awk, etc) to parse and store the needed result in a temp file, and
after a successful system(""), you just read that temp file. Does this work?

> - KP
> 
>>
>>>
>>> - KP
>>>
>>>>
>>>> Mimi
>>>>
