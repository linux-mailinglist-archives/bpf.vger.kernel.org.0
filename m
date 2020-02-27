Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98BC7172AFB
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2020 23:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbgB0WUO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Feb 2020 17:20:14 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55702 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729728AbgB0WUO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Feb 2020 17:20:14 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RMJTww010686;
        Thu, 27 Feb 2020 14:19:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=yRzVOvAJmtu2hlsoFIwMsiYSP3ZOjCv8WEan1zToh0E=;
 b=MFlNNwaHpbtz1TH78WQcZYYrTWrN79jmPGCYr09wEellhjSkaqzU4YpWTB5+h3ATwo4M
 AMHP11FiuGi0LUwOXOu1+eAQGZF7c+4Zz5zH9GWB783K+qJ9ttpeO1JdQnySBiLDSe7I
 FaEh7/0NQipxQ1UQokl4sDIKL0qr/tAJHcs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yegvk26vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 27 Feb 2020 14:19:58 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 27 Feb 2020 14:19:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4sTHEIn3qC9+1QjFPUO//IKhAy38h3gaxUycMX14FQ0EEXRHCjmQ1JNL1EV9dPytFP8tgBHQCXlMMnyhE/e2BYoQWnhTp4yMo8qdpKBXomMbo0HJ7FWFs6WsIzHmhaDBfIEnhKPIZy+M6o9PozjG1aNLUdN4+BIpRfDz7/sfChm5Uia9AufWLvnSPsZ/nqz+xO92qqQez7fBegjHKWVf2hF/pYGduhQpICQfaZyLAkvbStFtqnSzvQJKT348A/k4NShON+emRSxGctDuvlnvRFzLdRC4/fH3CVr1fgE7zVGr06p+bv6hRZtO1VIY47+lw8RwyWSSn4XfshDwcWQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRzVOvAJmtu2hlsoFIwMsiYSP3ZOjCv8WEan1zToh0E=;
 b=WbkaMZnuraSAVQEO8Qni6Dhkcr6wWKvRwSBwwB2blxhl62tpQvdkXpZ/EyKKoJkFMganopnxwvW8Q2LkHDqooxw7gXwKFqJtWB3gNyDOIvJlaZKU9ZJzMu1T+xjU4AXdJ2/Qjr57VVsa/kImMfz8Tb6P9HMv9WwG1GGNFG/SJMxepyM7I0Cfz+JJa8FXUJwXEUpYVYgbDVp/zZYjUqrf3kla7cqX8WdiheMQ/BI35HJZXufFwAhPKhTkJRn7vS1NA/kpFuf8FX1gbS+uQ6W6TFgnTDD2TV/6EdlFRkyz0iPJVEYOgrtkSxjmZ49zaB82mKQcN77vL4pdrjA+chE0Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRzVOvAJmtu2hlsoFIwMsiYSP3ZOjCv8WEan1zToh0E=;
 b=TW6KvkYncwb+0kN+DjnsNA1k4+hlfFH7N9Skbjx2oJLkm4TpspS6UJhlov39FTLQT/i3RemyKrNPy3N/BZo3zGONkxPMuKo7/yffl73feIo38V4I6q09+OnGdMN7wqJ8cGriUTH3VfLIhXVKGfrE/LO//gFNIKqJ/gtRTrUpaSw=
Received: from DM5PR1501MB1974.namprd15.prod.outlook.com (2603:10b6:4:a1::28)
 by DM5PR1501MB2150.namprd15.prod.outlook.com (2603:10b6:4:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Thu, 27 Feb
 2020 22:19:25 +0000
Received: from DM5PR1501MB1974.namprd15.prod.outlook.com
 ([fe80::4909:9ec9:ffc:b10a]) by DM5PR1501MB1974.namprd15.prod.outlook.com
 ([fe80::4909:9ec9:ffc:b10a%7]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 22:19:25 +0000
Subject: Re: [PATCH bpf-next] bpf: Add drgn script to list progs/maps
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrey Ignatov <rdna@fb.com>,
        Stanislav Fomichev <sdf@fomichev.me>, <ast@kernel.org>
CC:     <bpf@vger.kernel.org>, <kernel-team@fb.com>, <tj@kernel.org>
References: <20200227023253.3445221-1-rdna@fb.com>
 <20200227180102.GA188741@mini-arch.hsd1.ca.comcast.net>
 <20200227182653.GC29488@rdna-mbp>
 <8cbe6219-004c-e4f0-5f1e-5270c326f21b@iogearbox.net>
 <24d4115d-d36b-91fe-cad9-ce7fbb5d714a@iogearbox.net>
From:   Omar Sandoval <osandov@fb.com>
Message-ID: <7d2e2356-e0c1-4a31-d820-c07317b5746c@fb.com>
Date:   Thu, 27 Feb 2020 14:19:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <24d4115d-d36b-91fe-cad9-ce7fbb5d714a@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1601CA0008.namprd16.prod.outlook.com
 (2603:10b6:300:da::18) To DM5PR1501MB1974.namprd15.prod.outlook.com
 (2603:10b6:4:a1::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c083:1309:e6a7:a0ff:fe0b:c9a8] (2620:10d:c090:500::7:8494) by MWHPR1601CA0008.namprd16.prod.outlook.com (2603:10b6:300:da::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend Transport; Thu, 27 Feb 2020 22:19:23 +0000
X-Originating-IP: [2620:10d:c090:500::7:8494]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ae91337-2666-41bd-31d2-08d7bbd319f7
X-MS-TrafficTypeDiagnostic: DM5PR1501MB2150:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1501MB2150697568744077D10DD57FDFEB0@DM5PR1501MB2150.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10001)(10019020)(39860400002)(396003)(366004)(136003)(346002)(376002)(199004)(189003)(2616005)(110136005)(52116002)(6486002)(36756003)(66556008)(66946007)(316002)(66476007)(31686004)(478600001)(186003)(53546011)(8936002)(81166006)(5660300002)(2906002)(16526019)(966005)(86362001)(4326008)(31696002)(8676002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1501MB2150;H:DM5PR1501MB1974.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7d4vnFXs1XQcvD4y1s6jjebwjfUhkazHqjnvzH1espbG+OBO7s22ocHSJh0amhUIoSPI0PLhLOrm0FuKSwbuH0SE2Yc7CEQrISVaCELc6HnWaLkTB//zPNg+ia1a1IXTuG3OR/5EPRjMkMn+dEa6/mq16wl6vHOwfEcfp1E2QcYcLDijfU/V48BsWmktbpgm9VFLuHMlwHxpSXJYZRbMsCMH8xgzvJVGID+8wYpkl8KRaDk5k0s7h+QCBy8FWKpAPsCVJEKcz6TWYdpKN3rd7GnGmQisUj7ztGOrXHpk+ZyAq/5bWjsAZybiczgPLidVaDy8huDMNLD0ISKbB/gD875k4a/pjpaeUO9xsmHu1jFpKH5uqranQETbP8G1hf7tHc0/vENHO39AdCWiuh0hGVmlaYt5d0iqGFDT/KPhQgnF+jwGHBEme42GKd4b9nXGWbKrxAV/lvMAqZNF+nM+zs4Er5e/C75r5i9WHaWxBhbrFn60EyUaTPz/0TrKLavITA7OS3gKfP1m8V5tu4sxQK/ba3WlXU6IoeDp9Vn019Tiofn/zp8lNquOFdGNIrsraSPTgrvBN93OgtlsJj1pe1VfKbJ2SaC5opvPPI0lDYL+x9QGlTVnOofdyrAXvAIU
X-MS-Exchange-AntiSpam-MessageData: hIE0UYUbm3WfEbLA/RZ/k4Lb+xenO8BAebnjF1USg8FBWTrJogK8Pf/DqPGZCDrqOqjcdtftiZod+CrCNT/S+OMWtEYn/GtL2D043SYsmUfiBwdUPh5Q1YyuBdOTj2O7Jvy0VDVmFWtNrXGfU93J4YckngMTqmHAMpA5zXwasAR+QzHBAagI04Dkqcak/ed9
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae91337-2666-41bd-31d2-08d7bbd319f7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 22:19:24.9025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHNgy6TQdCLgTqZQLodeLqQ9c15Pyp/f1NtZRWEP1F4ivqucuhxDxFEbrKlyDVHd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB2150
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_08:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=856 malwarescore=0 impostorscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002270149
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/27/20 1:32 PM, Daniel Borkmann wrote:
> On 2/27/20 10:11 PM, Daniel Borkmann wrote:
>> [ +tj ]
>>
>> On 2/27/20 7:26 PM, Andrey Ignatov wrote:
>>> Stanislav Fomichev <sdf@fomichev.me> [Thu, 2020-02-27 10:01 -0800]:
>>>> On 02/26, Andrey Ignatov wrote:
>>>>> drgn is a debugger that reads kernel memory and uses DWARF to get types
>>>>> and symbols. See [1], [2] and [3] for more details on drgn.
>>>>>
>>>>> Since drgn operates on kernel memory it has access to kernel internals
>>>>> that user space doesn't. It allows to get extended info about various
>>>>> kernel data structures.
>>>>>
>>>>> Introduce bpf.py drgn script to list BPF programs and maps and their
>>>>> properties unavailable to user space via kernel API.
>>>> Any reason this is not pushed to https://github.com/osandov/drgn/ ?
>>>> I have a bunch of networking helpers for drgn as well, but I was
>>>> thinking about contributing them to the drgn github, not the kernel.
>>>> IMO, seems like a better place to consolidate all drgn stuff.
>>>
>>> I have this part in the commit message:
>>>
>>>>> The script can be sent to drgn repo where it's easier to maintain its
>>>>> "drgn-ness", but in kernel tree it should be easier to maintain BPF
>>>>> functionality itself what can be more important in this case.
>>>
>>> That's being said it's debatable which place is better and I'm still
>>> trying to figure it out myself since, from what i see, there is no
>>> widely adopted practice.
>>>
>>> I've been contributing to drgn as well mostly in two forms:
>>> * helpers [1];
>>> * examples [2]
>>>
>>> And so far I used examples/ dir as a place to keep small useful "tools"
>>> (tcp_sock.py, cgroup.py, bpf.py).
>>>
>>> But there is no place for bigger "scripts" or "tools" in drgn (yet?). On
>>> the other hand I see two drgn scripts in kernel tree already:
>>> * tools/cgroup/iocost_coef_gen.py
>>> * tools/cgroup/iocost_monitor.py
>>>
>>> So maybe it's time to discuss where to keep tools like this in the
>>> future.
>>>
>>> In this specifc case I'd love to see feedback from Omar and BPF
>>> maintainers.
>>
>> I can certainly see both sides given that drgn tools have been added to
>> tools/cgroup/ already. I presume if so, then these could live in tools/drgn/
>> which would also make it more clear what is needed to run as dependency
>> plus there should be be a proper high-level readme to document what developers
>> need to run in order to run them. But from looking at [1], I can also see that
>> those scripts would depend on new helpers being added/updated/deleted, so it
>> might be easier to add drgn/tools/ directory where scripts could be updated
>> in one go with updates to drgn helpers. Either way, I think it would be nice
>> to add documentation somewhere for getting people started.
> 
> One example that should definitely be avoided is 9ea37e24d4a9 ("iocost: Fix
> iocost_monitor.py due to helper type mismatch") due to both living in separate
> places. A third option to think about (if this is to be adapted by more subsystems)
> could be to have all the kernel-specific helpers from drgn/helpers/linux under
> tools/drgn/helpers/ in the kernel tree and the tools living under
> tools/drgn/<subsys>/ e.g. tools/drgn/bpf/.
> 
>>> [1] https://github.com/osandov/drgn/tree/master/drgn/helpers/linux
>>> [2] https://github.com/osandov/drgn/tree/master/examples/linux
> 
I can think of a few benefits of having this tool (and others like it)
in the drgn repository:

* Easier to keep in sync with new helpers/API changes
* More examples in one centralized place for people building new tools
* Potential to identify pain points in the API and possible new helpers

I think this would benefit the drgn project as a whole.

The downsides:

* More maintenance for me
* Tools will have to support multiple kernel versions (as opposed to
  only supporting the kernel that they shipped with)
* Less visibility for kernel developers

That second point is true of the helpers bundled with drgn anyways, so I
don't think it's a big deal. The third point will improve over time as
we get more people on the drgn train :)

I may come to regret the first point, but I think the upsides are worth
it. Andrey, feel free to submit a PR adding this to the drgn repository
under a new top-level tools/ directory.
