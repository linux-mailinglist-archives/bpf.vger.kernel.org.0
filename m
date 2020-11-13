Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B9D2B1506
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 05:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgKMENe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 23:13:34 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43252 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbgKMENe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Nov 2020 23:13:34 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AD4A6D6001696;
        Thu, 12 Nov 2020 20:13:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=09mDAvzZf1t+jeG3+XXzA81H4/w/qZkv9rdfPe/Q1Co=;
 b=DqoYhVDnQqPYeMN1YZNXYzEwF6Gjfz/5AjrBkBVcLP737+pOPqgkOG6bjjgtQpEqDf5U
 PfmFTA00V7pvtYqXbXXheKfnqNQmUyL8nHqIi60vH7gk3fU8uciFzBBhocTVTmJAjrhO
 +c4mDSnNLDjxRn9FxPAG8r/w7hufTE8Ot14= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34seqp91j2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 20:13:29 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 12 Nov 2020 20:13:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORZirPl/quAUbjosZCsb6/dH1RmOpVWvq+NTzRVfsf1TdNnTDKJ79D4jQHDpcTI4ETi/kG9oVUdB8XvDkjh6JUjusct3WNNhfvGMtPfc1lAe9xt3YmuGLu3rvcMWWTZLD8c7Q5UNv6kYZfcuN0qKLl2IrmnlOqGMkVHhEH5Xld0eMBbImFPAlxNFdL+U7gQTRceF7Uz2oYYTuLTGu19J/sBqO57VUROpN45f+ls2hDaXEA+s6pncJ5c8XYYhXKV5K87Mz3aGQ2iMIepdGWYA/ZcsmQlGFwxVzkqoCgdx3rVplNBaQXksPR1qofdRZXoMYgD8QKjUpnCy8aQVd9srnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09mDAvzZf1t+jeG3+XXzA81H4/w/qZkv9rdfPe/Q1Co=;
 b=FZbNJoD9qICx1TmI91OcnRjdpduG94DwNOXEGnfnTHGdNgN6jHcI3Bwq8q+D7SUJzQkfQvuJpHVKRovWEtzoXlYzMcZPJY4n/TyfzMd8z0fo4JtLeMX+9/4ZIfIw0HGRDuPoH/mkTDGUsfO7ZMYIkNtRjSq8MJIykGfzXNYDoLeElmwly/b6avFFBpDYQa2ifa8QFaUDpNgqaaE8DUw40PhtHohPKZ1XfYRhQsofMt9K+G3W8YgxQF2epCoDOunP4R4dFYl1UhSFziyF8Ec0M4Kwc9L2yaoa7YhL3nXiYPK88SRbPxL2S90bat8T3p9kUiSpAN8DhSxX+nJ5xpX0mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09mDAvzZf1t+jeG3+XXzA81H4/w/qZkv9rdfPe/Q1Co=;
 b=MLvA7YqWbO98sW/gRM9OiXhEyfGmshkLSAH60+wwNZQwNFW+LJMvdI/NDo1GkcLoGRx6AkK4OPU9t9EeUSkdY8iHyLxmFKagPLyRAPfkcHXu/L1Pz8+26kjTyG8hEsHgt0RPUXqK+6cwTCKUv3+UxBSNpBdQPNJqCTxdzjO+8/8=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2696.namprd15.prod.outlook.com (2603:10b6:a03:156::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Fri, 13 Nov
 2020 04:13:24 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42%3]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 04:13:24 +0000
Subject: Re: Extending bpf_get_ns_current_pid_tgid()
To:     Daniel Xu <dxu@dxuuu.xyz>, <bpf@vger.kernel.org>
CC:     <cneirabustos@gmail.com>, <ebiederm@xmission.com>, <blez@fb.com>
References: <C71Q73J0Y8S5.3PXMV3YTPDCL7@maharaja>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <13b5b2dd-bec0-cef2-7304-7e5a09bafb6c@fb.com>
Date:   Thu, 12 Nov 2020 20:13:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.2
In-Reply-To: <C71Q73J0Y8S5.3PXMV3YTPDCL7@maharaja>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:303d]
X-ClientProxiedBy: CO2PR04CA0159.namprd04.prod.outlook.com
 (2603:10b6:104:4::13) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::11f6] (2620:10d:c090:400::5:303d) by CO2PR04CA0159.namprd04.prod.outlook.com (2603:10b6:104:4::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25 via Frontend Transport; Fri, 13 Nov 2020 04:13:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 492fb66a-3b8c-4abc-f0ea-08d8878a76ac
X-MS-TrafficTypeDiagnostic: BYAPR15MB2696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB269651A504FC1330811F3BE5D3E60@BYAPR15MB2696.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FB/LR892v0008FNSSVbz38i45khfoDCDfgKTaZsLGKFy5qrEYRWj266Nd0x6saO2dA1y1CxPLPCLA2qQ1gkoTsLMkZ3tS6zJYQvB7YvoUHnnRfS1zyC+BGP+Yj0n3mVJMqslqYKkuIHheKB/2Cy7H1FyjNsIAkbcGmc7cwLSbPJ2nTJsy2QmDEPVCbh9l06F80XVUInXApp77gANMKS/wweQtINTKY5w+Sjp1BK/h8ewP/z9xdFXhgXQcLnma0RVeCyXkJ1U39k5QbUGsS/uwyLo7YjuEO9EhuUrjGEM81TCBWDHg8udl9Fpi2Wy/HdvVTDeuV+iFPWbWwqWCkiouCkxuKl/dLFOEaY2pmye3Ue/gaFanMh/22CSnICN+zxd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(376002)(366004)(39860400002)(2616005)(6486002)(5660300002)(8936002)(16526019)(316002)(31686004)(7116003)(52116002)(36756003)(2906002)(86362001)(66946007)(66556008)(8676002)(478600001)(53546011)(186003)(66476007)(31696002)(4326008)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: D5651pCTIWtthRgdqkiP85nQVfFGpCkt2XyF2HhZvSZ2SPUb1cozW9+QaEpLFfn/757EEZEcHBshNYVKAN5Gl53q9IQz4WKTLw+xSTbGsmb6jOLhXKzB2bRAWPisOIXI8wvLhoYa2Lkw7oMQHx64RF+q2aFGVL97ekJBPSGUQbqQR9JOj2UCk/VbPk/S2QMGPDosqC7qpobN8pfs7jnp1oNlAR56vokvqUQ23zfwW+xL2Nk4qpjILeDAZJspLMs+81EkhiQ0d79XTTTLX3DgXj0+4qAcX6C1bTzRJxUWCYKh1axuFt3QaYy/DxyJOur3ygeOKNF+YMplUiFDBNQ4ZltTnWZqaaCEiV6TqdY9aDqsWIL4O0/bpHZZON+6eVPe8KW9KfXs8x2JVekQrXWLjJg1bYjCZ+oBx9T08rMZ8usjDr9Rj33DSSLWOGCO/BQ5dpqKWz5xZrYn+u/Zs/5qPA9BtUIIaaTI4z6OI+mLbvn6Ze0E08CJSCaQ5i7vqJuzYqBeoQ+gLL2yavAEy6PCIT7v3lVvKL4XW7POZ7uQSL2VdQJTnxFN2okT9v4fcvlJxNBQif0N55eygfoT1Q+7q8+zlTfsv2BRwQIv6dGjEuTwO8Uvq7eR/KNUe+jm/Q8063jRy+UXa2OscXjMM14U/YAU7T/cB+Laeaw3qd9kcXeXeVgZIkin86ZoPkZ80FffLB+JAmc3tPezgmG6ozw24YNt2AbJEfKi8ImZ2na3BtbfP/yHrrzhHyskcvFfw6pc74YpKnBnlRqU0gADKz/sV6b8at1FYLDpuPkDhd1VEj75c55g6Cok0xgt58AgRhbNptLD0QVwh/A/t6yDUJpie1soynrA27IuS/t7NaWglvXDssitF9dKfYxjX3DuWxqsqMFR0IHn6/OvGe2e8W59BD7EWjyYkwZZQqB1b2MQEII=
X-MS-Exchange-CrossTenant-Network-Message-Id: 492fb66a-3b8c-4abc-f0ea-08d8878a76ac
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 04:13:24.0706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GP7JsAX4IL19HbDzt2S0psyuPApg6f3zsMz6amiPG9RIYYl2PVIIiWZ5gRp/mBup
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2696
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-13_03:2020-11-12,2020-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1015 mlxlogscore=999 mlxscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011130022
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/12/20 4:57 PM, Daniel Xu wrote:
> On Thu Nov 12, 2020 at 4:27 PM PST, Yonghong Song wrote:
>>
>>
>> On 11/12/20 2:20 PM, Daniel Xu wrote:
>>> Hi,
>>>
>>> I'm looking at the current implementation of
>>> bpf_get_ns_current_pid_tgid() and the helper seems to be a bit overly
>>> restricting to me. Specifically the following line:
>>>
>>>       if (!ns_match(&pidns->ns, (dev_t)dev, ino))
>>>               goto clear;
>>>
>>> Why bail if the inode # does not match? IIUC from the old discussions,
>>> it was b/c in the future pidns files might belong to different devices.
>>> It's not clear to me (possibly b/c I'm missing something) why the inode
>>> has to match as well.
>>
>> Yes, pidns file might belong to different devices in theory so we need
>> to match dev as well.
>>
>> The inode number needs to match so we can ensure user indeed wants to
>> get the *current pidns* tgid/pid.
> 
> Right, this double-checking at the API level is what feels strange to
> me -- why make the user prove they know what they're doing?

If we do not have this checking, it is possible that in interrupt
context, pidns #10 user may get a tgid/pid actually from pisns #11,
and tgid/pid could be valid for pidns #10. This result will be
actually wrong.

> 
> Furthermore, the "proof" restricts flexibility. It's as if
> bpf_get_current_task() required a (dev,ino) pair. How would you get the
> namespaced pid for a process you don't know about yet? eg when you're
> profiling the system.

Did not fully understand questions here. Do you mean
   bpf_get_current_task(dev, ino)
that will be weird. task is not associated with dev/ino.

> 
>>
>> (dev, ino) input expressed user intention. Without this, in no-process
>> context, it will be hard to interpret the results.
> 
> But bpf_get_current_pid_tgid() doesn't return errors so this shouldn't
> either, right?

Different helpers can have different signatures.

> 
>>
>>>
>>> Would it be possible to instead have the helper return the pid/tgid of
>>> the current task as viewed _from_ the `dev`/`ino` pidns? If the current
>>> task is hidden from the `dev`/`ino` pidns, then return -ENOENT. The use
>>> case is for bpftrace symbolize stacks when run inside a container. For
>>> example:
>>>
>>>       (in-container)# bpftrace -e 'profile:hz:99 { print(ustack) }'
>>
>> I think you try to propose something like below:
>> - user provides dev/ino
>> - the helper will try to go through all pidns'es (not just active
>> one), if any match pidns match, returns tgid/pid in that pidns,
>> otherwise, returns -ENOENT.
> 
> Right, exactly.

If you want to do this, you will need a new helper like
   bpf_get_ns_pid_tgid

It actually will be weird to use this helper as it looks like
you try to get pid/tgid of another ns. So we do need to nail
down the use case here.

> 
>>
>> The current helper is
>> bpf_get_ns_current_pid_tgid
>> you want
>> bpf_get_ns_pid_tgid
>>
>> I think it is possible, you need to check
>> pid->numbers[pid_level].ns
>> for all pid levels. You need to get a reference count for the namespace
>> to ensure valid result.
>>
>> This may work for root inode, but for container inode, it may have
>> issues. For example,
>> container 1: create, inode 2
>> container 1 removed
>> container 2: create, inode 2
>> If you use inode 2, depending on timing you may accidentally targetting
>> wrong container.
> 
> Yeah, so maybe an fd to /proc/<pid>/ns/pid or something.
> 
>>
>> I think you can workaround the issue without this helper. See below.
>>
>>>
>>> This currently does not work b/c bpftrace will generate a prog that gets
>>> the root pidns pid, pack it with the stackid, and pass it up to
>>> userspace. But b/c bpftrace is running inside the container, the root
>>> pidns pid is invalid and symbolization fails.
>>
>> bpftrace can generate a program takes dev/inode as input parameters in
>> map. The bpftrace will supply dev/inode value, by query the current
>> system/container, and then run the program.
> 
> I don't think it's very feasible to have bpftrace integrate with every
> container runtime out there. This also becomes really difficult to
> manage if you want to trace N processes. You'd need N maps or N progs.

Why, just one map to store dev/inode is shared among all progs, right?

> 
>>
>>>
>>> What would be nice is if bpftrace could generate a prog that gets the
>>> current pid as viewed from bpftrace's pidns. Then symbolization would
>>> work.
>>
>> Despite the above workaround, what you really need is although it is
>> running on container, you want to get stack trace interpreted with
>> root pid/tgid for symbolization purpose? But you can already achieve
>> this with bpf_get_pid_tgid()?
> 
> No, this isn't possible when bpftrace runs inside the container. ie
> bpftrace is in a pidns along with the tracees. Bpftrace gets the root
> pidns pid from the kernel but cannot resolve it to the pidns pid. That
> means bpftrace cannot find the executable file to symbolize against.

Not sure whether I understand correct or not. You want root pid to
find exec, right? but bpf_get_pid_tgid() will give your root pid?
Maybe I miss something here...

> 
> [...]
> 
> Thanks,
> Daniel
> 
