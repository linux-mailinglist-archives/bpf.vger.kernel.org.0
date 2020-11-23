Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06C42C1428
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 20:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733268AbgKWTCv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 14:02:51 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33876 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729119AbgKWTCv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Nov 2020 14:02:51 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0ANJ0StV006159;
        Mon, 23 Nov 2020 11:00:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=o+m1onBTcCjnhKHLFAFPmTiQ2yKpnjLlDUQSXVDzZuE=;
 b=Dm6gdPNrP06b8qgUdzGzvI3gF47wdvRssXSOpQeNCEGMhJuqZV9WSduPLdMLc9UoqvN0
 ADJSnj5ZfInUmLi8Eow8vXxws0RupH+Pi84aIN4pCHfYs9z9KqZ3MOkJ6/22Fxt13Fl0
 l4VwvkmpLyxvVYPL3u37ZuYtqj/UiCKWncI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 34ykstny6n-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 23 Nov 2020 11:00:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 23 Nov 2020 11:00:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcYvtvIsF3v4VnH5Xz401MRci5cLJmsfLz/HrjxE5G05cRi/AOd2nncAaqRsNkL0RFcD8RGSGIwwxcZSwnN4Sqd2AZXIDxPU+TUyNhl78KB4LQpl7ksnwkBuIS4QMGeUdBb5iblcn5uYPmGGEtZ1u2eyKMYaK69ei/BL+XRvrnIvAnXCMvQX2aQqRl372PvnVfWNZy2M0u+Ttl0+XnmBexxcxxq2M3S8eTtyvaRZ9KPT6XzHjxpfQxHt9GFr+jLDC6voUF447C1DpCazhFc1bv2+ZxhEYUdnk5T/J7GyzguOvToahzJdad6M5q9LiohS5d0rbt0oB7M0T+ULF4BAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZisoldRYEitwIM8GJsORWE7EXrrv7ME6lPD8W6KMxuo=;
 b=ex8D6JpMS3Rk8dOLcequWsIYpebOTsSNAAZKkVDx+7n2j/fEerkkF5L0pCScUK9r7UvXfFPEaXJOAHNvvA/c81Gjjld3sJqWeqCiQ+4mtTLg9LYucKVSwb7XSgQt08DMY7A7PrzSjAjtAp0q07QpIDMQN/Qdbe2r/pMJJcdyDa18gMm5Rz4PL9lrYYjJT8kQckZ6egOEghk4LiecfnPOIla4Xff2JwXKMHCciF2ODp8mCsTGGOSdoGFODr5KprhREp0Xy1iT/2kAuLgbKApGdsNO8zYKl8sTDdf/vbggd+kHUwMAhko91rxcNGghT2Aiv160HJE4uNoXymhO0/TrtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZisoldRYEitwIM8GJsORWE7EXrrv7ME6lPD8W6KMxuo=;
 b=afLQY18KiJlgg9OwBj5A5pAux2u7SQxzFSSgVu0q9+GUc+uj0zua1kH/0ALHiz+DIM7bKKqlaNib0Nbx2Nf9S/FdlUZxrdoHFwO/NcJQ0mf4EZ27Sh+OB1UvTIGPnR6xSdY+LrlX39zxyih6taQce29fORJL0f8nwRtVURy5TVY=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3512.namprd15.prod.outlook.com (2603:10b6:a03:10a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Mon, 23 Nov
 2020 19:00:25 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3589.029; Mon, 23 Nov 2020
 19:00:25 +0000
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Update LSM selftests for
 bpf_ima_inode_hash
From:   Yonghong Song <yhs@fb.com>
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
 <7f4e1733-175e-288d-8c6c-4adc12f17ad5@fb.com>
Message-ID: <1aef0681-a19d-cda3-8d64-4f7340045818@fb.com>
Date:   Mon, 23 Nov 2020 11:00:22 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <7f4e1733-175e-288d-8c6c-4adc12f17ad5@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:fc96]
X-ClientProxiedBy: MW2PR16CA0016.namprd16.prod.outlook.com (2603:10b6:907::29)
 To BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1039] (2620:10d:c090:400::5:fc96) by MW2PR16CA0016.namprd16.prod.outlook.com (2603:10b6:907::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 19:00:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e668745c-dcee-4afd-ae18-08d88fe20955
X-MS-TrafficTypeDiagnostic: BYAPR15MB3512:
X-Microsoft-Antispam-PRVS: <BYAPR15MB35128922038C50E4C9DB76A3D3FC0@BYAPR15MB3512.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Tpjq8gqu6s5BMl20mwngZWrwg9Kygq+swciy5cmC8143hLm8wNl6PeA9l49WvydfF2xEfcxwQxvZxwqQLdH3WZe0W1HCgdTKDjwgp5b1mb100JddmwLN3moiigRgBYXD4ABUEleT/RMOxyI7Jc6vLGz/5nvIW6fwgVRY5CHpmKTyiSSo+EvTvFLQ8dbjikcgmJfv6/Y1Vv7Y2iz5fqm7YAf0/poRrOo1Y/henRN8ah4cqhLwfdmlMGQjnuxTSviZFlrI061x+9bft5zE/Rc3QhlysvV391QyETwmTtySxrTJJAjtlE3zVShL/ldLkzLlCpQGCfRFxdpo1JSsGDfFV4fL2G/p3ROM+L+6VfmElPF3c+cUCoIakv9Oe0eVOwGDCj35zvmKwp9ZxqmbJJNKZxIBSJjKTwjNmwDBfjnhFSQGzDhr4xmn+rePgNoYXaiGFmPgiaanbMpKJZLJqTcZltaTwz4ylHZHNpk15rTasM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39860400002)(396003)(366004)(53546011)(5660300002)(54906003)(36756003)(4326008)(186003)(6916009)(52116002)(8676002)(6486002)(2906002)(16526019)(966005)(7416002)(31696002)(316002)(15650500001)(86362001)(66946007)(83380400001)(31686004)(66556008)(478600001)(66476007)(8936002)(2616005)(573474001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: YTxD5nKi6ch4GjeLNNauUz1oo9Sqr0l4YixJM6xiUOp/6O5SgXR5W6QoYPQMF83NHVqSVa3eeWL3ckr4rIY51csOpcSZE4NW7T0OPM/6XwzKE/nuP6dEwvnPa47s4UBdtQo4DSdMOcasZd1BuFXqfb4HwSt+a/dINZeDUCvmuxg3o7hBhAOVQJP6XfVdn8zTUK2YUpaD7ZUzfbmgh5VysJWwlErv9X+E8TMekOouXwaL6cHX/GuOOYZssqnFDu3jDF8YTKc/6Zdp8qGsc1n71ayNIuxXbFEJm3mRzGavK4qt9h97UVdqvvK6442WnaHYUezRoqlWdjZpagKuB3id04nnecyY8Frr6JeMRXTUenowjq9cilsnAj+aeXVdmQnG++EI4ERTZzk9TjwntF2m1NFdweERdCeHRr7bjrza/YA+DjHK8Ehkf+NhNlIKHFxf1X4EMMfMV1LFCkzPtjJDPXM4M+MRYOr1FtHrIUGRTTM5caOwQKtlSgHppcT2e1mx7SFAvNsirKnHr6yu+jzLzF9WfQCEgmn6csmK5+/kVPOEeUNa6RdBYyKNj2DJHod+oWXJVDFFIrE6lf8pgVWBybvN8N0T+hVkxyBvCkbX2ICKPGuokRzVAa2qTu4Cjyq7wy3KR5YoEMpUOWb7Anx6gbuXXZwvu3EGnqph9yunKXKcXx/6c3Zuge8aFO45DEdfkYyC7cl96J2J+l0cNF/Sgn5QdIZw5p7n2/X+gJ1hOtqKv/xCNHMTTjEvs4EKoFQl5+ZyDToFFb3YO/1/5XDyOI6v5DMPqDsE1QEYy75510sEHzx8Rb/3sBZov0wiMTSVyCQi9SjCNhmn79EAZFUWMruaxCxN1p6SiT3Yus8CENjC5jTSZA/EBds0MCu4t33hkHCed0gbwzslBPIsKSKux+TLzFmF/udGcBV1mNPfpHA=
X-MS-Exchange-CrossTenant-Network-Message-Id: e668745c-dcee-4afd-ae18-08d88fe20955
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 19:00:25.6345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jL2KBFX72+yOKwHg2azr7aS/tAFyMcDqNcbOXiyfxEmo3JWbDB1snkk5TjkijZA6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3512
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_17:2020-11-23,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011230124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/23/20 10:54 AM, Yonghong Song wrote:
> 
> 
> On 11/23/20 10:46 AM, KP Singh wrote:
>> On Mon, Nov 23, 2020 at 7:36 PM Yonghong Song <yhs@fb.com> wrote:
>>>
>>>
>>>
>>> On 11/23/20 10:27 AM, KP Singh wrote:
>>>> [...]
>>>>
>>>>>>>
>>>>>>> Even if a custom policy has been loaded, potentially additional
>>>>>>> measurements unrelated to this test would be included the 
>>>>>>> measurement
>>>>>>> list.  One way of limiting a rule to a specific test is by loopback
>>>>>>> mounting a file system and defining a policy rule based on the 
>>>>>>> loopback
>>>>>>> mount unique uuid.
>>>>>>
>>>>>> Thanks Mimi!
>>>>>>
>>>>>> I wonder if we simply limit this to policy to /tmp and run an 
>>>>>> executable
>>>>>> from /tmp (like test_local_storage.c does).
>>>>>>
>>>>>> The only side effect would be of extra hashes being calculated on
>>>>>> binaries run from /tmp which is not too bad I guess?
>>>>>
>>>>> The builtin measurement policy (ima_policy=tcb") explicitly defines a
>>>>> rule to not measure /tmp files.  Measuring /tmp results in a lot of
>>>>> measurements.
>>>>>
>>>>> {.action = DONT_MEASURE, .fsmagic = TMPFS_MAGIC, .flags = 
>>>>> IMA_FSMAGIC},
>>>>>
>>>>>>
>>>>>> We could do the loop mount too, but I am guessing the most clean way
>>>>>> would be to shell out to mount from the test? Are there some other 
>>>>>> examples
>>>>>> of IMA we could look at?
>>>>>
>>>>> LTP loopback mounts a filesystem, since /tmp is not being measured 
>>>>> with
>>>>> the builtin "tcb" policy.  Defining new policy rules should be limited
>>>>> to the loopback mount.  This would pave the way for defining IMA-
>>>>> appraisal signature verification policy rules, without impacting the
>>>>> running system.
>>>>
>>>> +Andrii
>>>>
>>>> Do you think we can split the IMA test out,
>>>> have a little shell script that does the loopback mount, gets the
>>>> FS UUID, updates the IMA policy and then runs a C program?
>>>>
>>>> This would also allow "test_progs" to be independent of CONFIG_IMA.
>>>>
>>>> I am guessing the structure would be something similar
>>>> to test_xdp_redirect.sh
>>>
>>> Look at sk_assign test.
>>>
>>> sk_assign.c:    if (CHECK_FAIL(system("ip link set dev lo up")))
>>> sk_assign.c:    if (CHECK_FAIL(system("ip route add local default dev 
>>> lo")))
>>> sk_assign.c:    if (CHECK_FAIL(system("ip -6 route add local default dev
>>> lo")))
>>> sk_assign.c:    if (CHECK_FAIL(system("tc qdisc add dev lo clsact")))
>>> sk_assign.c:    if (CHECK(system(tc_cmd), "BPF load failed;"
>>>
>>> You can use "system" to invoke some bash commands to simulate a script
>>> in the tests.
>>
>> Heh, that's what I was trying to avoid, I need to parse the output to 
>> the get
>> the name of which loop device was assigned and then call a command like:
>>
>> # blkid /dev/loop0
>> /dev/loop0: UUID="607ed7ce-3fad-4236-8faf-8ab744f23e01" TYPE="ext3"
>>
>> Running simple commands with "system" seems okay but parsing output
>> is a bit too much :)
>>
>> I read about:
>>
>> https://man7.org/linux/man-pages/man4/loop.4.html 
>>
>> But I still need to create a backing file, format it and then get the 
>> UUID.
>>
>> Any simple trick that I may be missing?
> 
> Maybe you can create a bash script on your prog_test files and do
> system("./<>.sh"). In the shell script, you can use all the bash magic
> (sed, awk, etc) to parse and store the needed result in a temp file, and
> after a successful system(""), you just read that temp file. Does this 
> work?

I guess under the current framework, you can also create a .sh file
manually and place it into tools/testing/selftests/bpf directory
and call it in your prog_tests .c file with system("./<>.sh")...

> 
>> - KP
>>
>>>
>>>>
>>>> - KP
>>>>
>>>>>
>>>>> Mimi
>>>>>
