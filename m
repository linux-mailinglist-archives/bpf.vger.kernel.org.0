Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A10E2B212A
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 17:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgKMQ5g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Nov 2020 11:57:36 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22882 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726107AbgKMQ5f (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Nov 2020 11:57:35 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ADGuN1E004069;
        Fri, 13 Nov 2020 08:57:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=iGlc9ZTl9O2VuDRDt90b3yqBNc/Nl3/0P/vCUARTQaY=;
 b=JZxUXeW1b80JYWHTHx//1e2qMDbQFIH2YfbljNKia4OysnuK0Npb6QEgpl6g2rh8+Jl0
 wuYHWejFuGJInzy124iryzlGjV+o24zrF68oTfv+E4ot6Kez73BMIO+EFX0KpxFc/cX/
 /qqYxF6BrbwHR2VxY9CAcdkKSr5McLELi0U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34seqn402h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 13 Nov 2020 08:57:32 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 13 Nov 2020 08:57:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IB76mlXdtUkwlau3LSAkJS7DSmsi0dfmTTuWFVqS0muiazXKruhHTSoFbiYbQTZzwm/Kfqer+DWJae2MmWUUG80l8FXipW9bSEihUYEt1rWBnoxv86DBvCCp4z8VJDaGF9icLQ7TmBIRz24zK1h/DuxnBT53A1Auck0yCoVWQkUvLupDTcbaFE+hvxMLMkvP2ocPNKecro2HjVbPvrXBTDqmdNBYtu3bCd8XOl5ITF/7SbaCBKSUOol42oY/qx6iwiGkoDwCNqDXDxqZWJ3A7RLM1xtTfmHudt3kJtZIjQ6qZJcy+6kTiwX8k3oLmSNiH7qDpuQ2zqURJ3b5yc1gCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGlc9ZTl9O2VuDRDt90b3yqBNc/Nl3/0P/vCUARTQaY=;
 b=BxWi3Uqy78eaeZNxcDd9JEhLXfRvz9bS7kujd4g05eb6ph2C4qcugcdieKFbV0mKBvKVehlZq+361uwatO6M7xuY1TEj9JhAAAy2DWHsKjfmcErkENYKbFCzl3Nu55MaII3rtHVJStHEgl+fI9/UzwDbiCT93lzuDNQCgOioX6FpKFUQJzxQ52kWT425Z03r43iHco+6hiryCkWdlUqHjSvEMdZ0lyZ37HZ5L5gQOSsapL1KHUc02pl457JvSzFbgYNjW1I+5M6ywpk1gn2uaaBNj86lRncLqknqdwB2RPR71gZ9HtrKjEjQ8a1Ly/9f/bwtcBNvNASD4PdeVd2NzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGlc9ZTl9O2VuDRDt90b3yqBNc/Nl3/0P/vCUARTQaY=;
 b=VC5xSaFRmQLXUqNZkczGkeMKir5btT46okjUFzzDzpsSnYm5fypN4H7R8MRYAz004qL8Sx0cz7SjlkB4kU8pyCK78pj361rAN4JhnNRF1IAU51gXKZlAWphtHrb2zcMl3cdty6/nPEwX6fOpwjjrPikJrJnf0cbrxPl1z0tSSjs=
Authentication-Results: xmission.com; dkim=none (message not signed)
 header.d=none;xmission.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2328.namprd15.prod.outlook.com (2603:10b6:a02:8b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 16:57:30 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42%3]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 16:57:29 +0000
Subject: Re: Extending bpf_get_ns_current_pid_tgid()
To:     Blaise Sanouillet <blez@fb.com>, Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "cneirabustos@gmail.com" <cneirabustos@gmail.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>
References: <C71Q73J0Y8S5.3PXMV3YTPDCL7@maharaja>
 <13b5b2dd-bec0-cef2-7304-7e5a09bafb6c@fb.com>
 <MN2PR15MB2991E847DE47A265E71F1BC8A0E60@MN2PR15MB2991.namprd15.prod.outlook.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <ba5f3c14-8261-af6f-8850-90848963d63a@fb.com>
Date:   Fri, 13 Nov 2020 08:57:25 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.2
In-Reply-To: <MN2PR15MB2991E847DE47A265E71F1BC8A0E60@MN2PR15MB2991.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:a1da]
X-ClientProxiedBy: MWHPR1601CA0019.namprd16.prod.outlook.com
 (2603:10b6:300:da::29) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::11f6] (2620:10d:c090:400::5:a1da) by MWHPR1601CA0019.namprd16.prod.outlook.com (2603:10b6:300:da::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25 via Frontend Transport; Fri, 13 Nov 2020 16:57:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10d0fb68-4aa2-4052-9bbb-08d887f534e7
X-MS-TrafficTypeDiagnostic: BYAPR15MB2328:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB23281882BE0468941AE25BBBD3E60@BYAPR15MB2328.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PUUJ+KIRgql6rpSws7CdPFvYnyWp/XNHY9jTmpwlrg8b1KFZ37Dhm9KTVbrHF0PL49tXR9Q6j6yS5fXiFKCyK2EqbO0OfpETWacBCC+cQiFTApyYnmj/Vd/mTAf/tfFceF3MAVe1C16nGRKV61WsHwdHTOKfyE1oLheM6X7WihHxhAUMa8XhBQ9Lf/4gN27q03LgdQLYHBA+rqKYJGGkufii+J2drlNffCnyZhOv+F8S/dLwZtpP7dduMNxJcKzi0lVl9Bs/n28tiAl4YiMj6QDOqz1Eg+d2FFggqkHlmS9KOkzsaAIGwAcgnMHp9VgyOCTfHNkj4K+YFT/mjjqTfgSTQRl7u0alEWWtqm9iyGw7AsT9LsVmVXxKkZ9ccLYu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(346002)(376002)(39860400002)(8936002)(6486002)(186003)(7116003)(16526019)(478600001)(2616005)(36756003)(110136005)(5660300002)(316002)(31696002)(52116002)(4326008)(83380400001)(2906002)(54906003)(66476007)(6666004)(86362001)(8676002)(53546011)(31686004)(66946007)(66556008)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: JWl1gM/7yHVMeX1TJN6pKW3z4XKF4Ke6FejR0y9dN0k6bJbJsza4oI+FRZ1fFZgdDFyH0g2HRnTQ7rVgOh2skrC2uhlKMeMiS3ua5hD66u2R3a8+clSNHog5MaktH9Pz8VEXmbN+tKJNq0A0wJBrj7ROm3GYbB/S5VSCT1S/luQ9EUHbINyeuYsXpITZ2QDA5jZwrdBAXNl9ls1Hy9RWN79Sx92AQwgp3UXzD9DE7xJ9bDqBMPeVy+kOgqzQdm8/CjyCCpthYK7xtHm7QBXzVfPn6gKk3rkzDhnB+LsNLy3/BDqzOcHJ2t0XKSwZ+7rSVOtFzTU9bC11K2hocwftMUMh7QKvLVtCnh+DJyAOej5cbwlC7/ueGdcX0eOjJXumhLn++93rlkrrDbMLGMOrguF9JZ/Nc3o5T7vwbV3KToFEUMgf4i1t5OUx/GeahrXHKEcfKPN1B11tRBU4V/pfPre79Me1pn7wlLFV+VqXICjmoULyAvkvPr18RHwueU4tuQmOZEwDsyYD/r6usRwD7lKKedETbBCVtmZ6uIQe6KaNUnTCRIdevd0+xx57P487WJ7TOLccCc2SKOFbEu15PVbQVB18ZYqdyOBDZAb/L/apO0kP7ScuOMz/meBNpqlPLojx2cyVahG6NsCEnxXChmixzaNeAqwT6JwYdQc6wi9MbuB0zPODNlrAjKaKmyN5X/Kye8Lrxd72Ja30nBqV8x4kY+ET454T1iTDdpq8H8AxqYNpxYSROezcxm6uCXbfZHrptVU1Wl+iQKC4+daGRNFcpVe3kecarFo+lwmlmYE9hNCqIc2kvGJTu5J/WR1xFQYt+bo/gyCb3Ys2V+xw94QlHc201IhgP1oCIdBnCUMJb9+JqDFKhDo08KJdSPdOXhXfAURBl1JFzta7WrYljPuhLQOGCLaAFqJDE2e1ZZY=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d0fb68-4aa2-4052-9bbb-08d887f534e7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 16:57:29.8145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kaelBna/KHQYFxdKbiV4O40pdLOWbdsyxW2EI+dgVthKU8gCg9ZMnYdMRZn1Z6i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2328
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-13_10:2020-11-13,2020-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011130110
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/13/20 4:04 AM, Blaise Sanouillet wrote:
>> On 11/12/20 4:57 PM, Daniel Xu wrote:
>>> On Thu Nov 12, 2020 at 4:27 PM PST, Yonghong Song wrote:
>>>>
>>>>
>>>> On 11/12/20 2:20 PM, Daniel Xu wrote:
>>>>> Hi,
>>>>>
>>>>> I'm looking at the current implementation of
>>>>> bpf_get_ns_current_pid_tgid() and the helper seems to be a bit overly
>>>>> restricting to me. Specifically the following line:
>>>>>
>>>>>        if (!ns_match(&pidns->ns, (dev_t)dev, ino))
>>>>>                goto clear;
>>>>>
>>>>> Why bail if the inode # does not match? IIUC from the old discussions,
>>>>> it was b/c in the future pidns files might belong to different devices.
>>>>> It's not clear to me (possibly b/c I'm missing something) why the inode
>>>>> has to match as well.
>>>>
>>>> Yes, pidns file might belong to different devices in theory so we need
>>>> to match dev as well.
>>>>
>>>> The inode number needs to match so we can ensure user indeed wants to
>>>> get the *current pidns* tgid/pid.
>>>
>>> Right, this double-checking at the API level is what feels strange to
>>> me -- why make the user prove they know what they're doing?
>>
>> If we do not have this checking, it is possible that in interrupt
>> context, pidns #10 user may get a tgid/pid actually from pisns #11,
>> and tgid/pid could be valid for pidns #10. This result will be
>> actually wrong.
>>
>>>
>>> Furthermore, the "proof" restricts flexibility. It's as if
>>> bpf_get_current_task() required a (dev,ino) pair. How would you get the
>>> namespaced pid for a process you don't know about yet? eg when you're
>>> profiling the system.
>>
>> Did not fully understand questions here. Do you mean
>>     bpf_get_current_task(dev, ino)
>> that will be weird. task is not associated with dev/ino.
>>
>>>
>>>>
>>>> (dev, ino) input expressed user intention. Without this, in no-process
>>>> context, it will be hard to interpret the results.
>>>
>>> But bpf_get_current_pid_tgid() doesn't return errors so this shouldn't
>>> either, right?
>>
>> Different helpers can have different signatures.
>>
>>>
>>>>
>>>>>
>>>>> Would it be possible to instead have the helper return the pid/tgid of
>>>>> the current task as viewed _from_ the `dev`/`ino` pidns? If the current
>>>>> task is hidden from the `dev`/`ino` pidns, then return -ENOENT. The use
>>>>> case is for bpftrace symbolize stacks when run inside a container. For
>>>>> example:
>>>>>
>>>>>        (in-container)# bpftrace -e 'profile:hz:99 { print(ustack) }'
>>>>
>>>> I think you try to propose something like below:
>>>> - user provides dev/ino
>>>> - the helper will try to go through all pidns'es (not just active
>>>> one), if any match pidns match, returns tgid/pid in that pidns,
>>>> otherwise, returns -ENOENT.
>>>
>>> Right, exactly.
>>
>> If you want to do this, you will need a new helper like
>>     bpf_get_ns_pid_tgid
>>
>> It actually will be weird to use this helper as it looks like
>> you try to get pid/tgid of another ns. So we do need to nail
>> down the use case here.
> 
> I'll try and describe the use case I have in mind. I expect folks would like to use bpftrace in container X to trace events in container Y, where X may or not be Y, provided the bpftrace process has the required access to Y's namespace. For symbolization to work, bpftrace needs to get the pid of processes in container Y but in the namespace of X. For example X could be a parent cgroup to multiple workloads including X, and the owner of these workloads has access to X but not the host itself. I don't see it as trying to get pid/tgid from another namespace, it's actually to get the pid in the namespace where it can be acted upon (i.e. X).

Thanks for explanation. If I understand correctly, you have a privileged
namespace which is used to trace other namespaces. So the helper's input
is other namespace dev/inode and the result is other namespace tgid/pid.

I think this is a valid use case.

> 
>>>> The current helper is
>>>> bpf_get_ns_current_pid_tgid
>>>> you want
>>>> bpf_get_ns_pid_tgid
>>>>
>>>> I think it is possible, you need to check
>>>> pid->numbers[pid_level].ns
>>>> for all pid levels. You need to get a reference count for the namespace
>>>> to ensure valid result.
>>>>
>>>> This may work for root inode, but for container inode, it may have
>>>> issues. For example,
>>>> container 1: create, inode 2
>>>> container 1 removed
>>>> container 2: create, inode 2
>>>> If you use inode 2, depending on timing you may accidentally targetting
>>>> wrong container.
>>>
>>> Yeah, so maybe an fd to /proc/<pid>/ns/pid or something.
>>>
>>>>
>>>> I think you can workaround the issue without this helper. See below.
>>>>
>>>>>
>>>>> This currently does not work b/c bpftrace will generate a prog that gets
>>>>> the root pidns pid, pack it with the stackid, and pass it up to
>>>>> userspace. But b/c bpftrace is running inside the container, the root
>>>>> pidns pid is invalid and symbolization fails.
>>>>
>>>> bpftrace can generate a program takes dev/inode as input parameters in
>>>> map. The bpftrace will supply dev/inode value, by query the current
>>>> system/container, and then run the program.
>>>
>>> I don't think it's very feasible to have bpftrace integrate with every
>>> container runtime out there. This also becomes really difficult to
>>> manage if you want to trace N processes. You'd need N maps or N progs.
>>
>> Why, just one map to store dev/inode is shared among all progs, right?
>>
>>>
>>>>
>>>>>
>>>>> What would be nice is if bpftrace could generate a prog that gets the
>>>>> current pid as viewed from bpftrace's pidns. Then symbolization would
>>>>> work.
>>>>
>>>> Despite the above workaround, what you really need is although it is
>>>> running on container, you want to get stack trace interpreted with
>>>> root pid/tgid for symbolization purpose? But you can already achieve
>>>> this with bpf_get_pid_tgid()?
>>>
>>> No, this isn't possible when bpftrace runs inside the container. ie
>>> bpftrace is in a pidns along with the tracees. Bpftrace gets the root
>>> pidns pid from the kernel but cannot resolve it to the pidns pid. That
>>> means bpftrace cannot find the executable file to symbolize against.
>>
>> Not sure whether I understand correct or not. You want root pid to
>> find exec, right? but bpf_get_pid_tgid() will give your root pid?
>> Maybe I miss something here...
> 
> Looks like your suggestion is for bpftrace to use bpf_get_pid_tgid() when it's running in the root namespace (i.e. the host), and bpf_get_ns_current_pid_tgid() when it's running in another namespace (i.e. a container). I think this would be fine in the short term, even though it doesn't cover all the cases (see above). That said, I'd say the intelligence belongs more in a bpf helper than in user space.

Using bpf_get_pid_tgid() should work if you have host access. But if you 
only have a privileged namespace, this won't work and indeed a new 
helper is needed.

> 
> Thanks,
> Blaise
> 
