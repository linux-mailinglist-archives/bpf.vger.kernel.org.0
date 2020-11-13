Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4872B1ABA
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 13:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgKMMFA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Nov 2020 07:05:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4160 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726795AbgKMME6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Nov 2020 07:04:58 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0ADC4qOc007107;
        Fri, 13 Nov 2020 04:04:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=WuK4DvhmbLT/BrETCtQOsAqdCBtI7WtHrX4uJg5ax2k=;
 b=mNUH5oz9gxbhAmHPd9WROznquOApSkDNBsnLDoKwCUa6kFzCd2diYd4x6ekP5NPrxGci
 KY7Q0SfXM90wBW1xoB6k0X6ciFrJaLOdVOwCrtNPeJ5sVP+ZeG6Rzjamv7sXaG8QL2LS
 3weTFwOdj0wjzsXa8JN1MhIFQKLV9UghSTE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 34se3ptu9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 13 Nov 2020 04:04:52 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 13 Nov 2020 04:04:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7GFc+IlytCbuImOfAQGTeQ4QPYZYU1HBUVBS0XBa4NGuoRmhkDTytTZB5X3e01VBgVcTrvkKqMiwwEPNOZ6TlSgbnVKbDiKM5XCWTCysJKbeNub4fN03Bn7Qm0X1JDNUUSN/P1YRhwysD8RG3F9GeZbxQBekVKREUkTm0mnBb94rKQ399cjSFq+g6DfjQDBGQ2PThsIVguq9TvPOIaT5Q5y1BpEBrYCQLYkfkPyCw/M1reBTGXnd9mDjUjtNV/oiKAPIraTNlt3ZDjRk04eWUURE8GOx/o+cAg5HZRifQp+LTV4ZpdPh2cuUFVTlT7Nugirid41Gs68HLmylvULQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuK4DvhmbLT/BrETCtQOsAqdCBtI7WtHrX4uJg5ax2k=;
 b=IqEh/4ubklSZJPrIfCvx7jO4T2XcnuMWqHlIOkbL1fQozgTWtXQO6Ud42GCIEcliSMxaYxgSsofcDV4YXdN8BFQjLEueQKjR30xvT6uG5v5Cu2nEvNH7xCb6Hl29t+ekxq0+d6f8YmDjItOOo77/LzeAlCCrx65XjKBGTDP8J6qLX6ANNhevlUk7G86aS4z8Ck0ra3gG9RbhQXuXCt1sSp2NASsbUJtGpAsXy5h6rT93HzS243bXfqVIXUSObiRz3wndNlRpHNiIDfqDowjPgyHeaC6KEFPwqzwEUKg4xxZQWgj24vtpYPS3JYheZmR6CBG2xILZDSkiM0G8/grk6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuK4DvhmbLT/BrETCtQOsAqdCBtI7WtHrX4uJg5ax2k=;
 b=MpBQFOkpAbA4y2NLWqOTykQ0cnLKpQROOah9JI4Heq4t7riNQFKdkaIxR2XhU2c6AJoiHDhsswPTY+JOIPhoOjRDUc7gRCd/qU1WPXz3OXx5/wX6N8v47LnbS5YH6q10tIbn1oCMSRn/LQZnVzefEjn/oGmcQIEkXjFrFzrS29g=
Received: from MN2PR15MB2991.namprd15.prod.outlook.com (2603:10b6:208:f3::12)
 by MN2PR15MB2989.namprd15.prod.outlook.com (2603:10b6:208:ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Fri, 13 Nov
 2020 12:04:43 +0000
Received: from MN2PR15MB2991.namprd15.prod.outlook.com
 ([fe80::fc72:563c:526:7069]) by MN2PR15MB2991.namprd15.prod.outlook.com
 ([fe80::fc72:563c:526:7069%4]) with mapi id 15.20.3564.025; Fri, 13 Nov 2020
 12:04:43 +0000
From:   Blaise Sanouillet <blez@fb.com>
To:     Yonghong Song <yhs@fb.com>, Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "cneirabustos@gmail.com" <cneirabustos@gmail.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>
Subject: Re: Extending bpf_get_ns_current_pid_tgid()
Thread-Topic: Extending bpf_get_ns_current_pid_tgid()
Thread-Index: AQHWuUbDherKhQaNQEqJohDrmteEb6nFNNsAgAAIYACAADbcgIAAZ4vD
Date:   Fri, 13 Nov 2020 12:04:43 +0000
Message-ID: <MN2PR15MB2991E847DE47A265E71F1BC8A0E60@MN2PR15MB2991.namprd15.prod.outlook.com>
References: <C71Q73J0Y8S5.3PXMV3YTPDCL7@maharaja>,<13b5b2dd-bec0-cef2-7304-7e5a09bafb6c@fb.com>
In-Reply-To: <13b5b2dd-bec0-cef2-7304-7e5a09bafb6c@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c093:400::5:55d5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfabd624-6266-4fff-1138-08d887cc4eac
x-ms-traffictypediagnostic: MN2PR15MB2989:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR15MB29896C56238315D017D69926A0E60@MN2PR15MB2989.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7OHNryqwFmfSPutG+frx7l6B87k3s2VxkzvrZlHJm942sIgznWUpzqqKs1RFKQ3C2gqmiyZB33EEMS7bmGHuNS8m0Qo5bhgdKEDUHvmNpS616CnMJsQQjdr9cTU+6zd5LkLweGflzViINcSQFb9SZ60a3FrDNGqYG+0TjpGOkMVPfY8k+io7k9+7Fx2a6QCE+ALiN675Ba9yYFLzsOegxGhcWHXzNQZfesCU9Fsp1sdn/pTx69DK3nKlzfYZ5U3XbHvQNwIxCJIQs5AXK6C3eYObEdjDKKXK5qNU9d1nSAYqCUHg2hbr646aPGj/dkkg5TstiWkib3tWGjZxh5VIhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB2991.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(366004)(136003)(346002)(33656002)(8936002)(110136005)(7116003)(9686003)(54906003)(52536014)(5660300002)(7696005)(83380400001)(53546011)(71200400001)(6506007)(55016002)(66946007)(478600001)(186003)(4326008)(91956017)(8676002)(66446008)(64756008)(66556008)(66476007)(2906002)(86362001)(316002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: J7hpZeGNXBTrJwu76j2oWSRlK2lzBYTX6LrU0jCphKC3YpRSWv2yXrqlMx8EQqYQZFXQKw2JsZ2numVo4xBK5Q85OVOtowNhRIrwSPGpbj913CiXInofyHDJ/8MASRZom4JelsCmzxgS5dfFOwp0nWVylMrZ5CgDRrXYxVH0LulbR2vq9yUM7Goew8UrMAhn7kYAHJ9j3wbw6+0ImS7MQc7hqh0ofNXiawFemwsWhUh30koHiLCWIr41WwTeSYkoXHC86He4N4GT2ZOON7vNKAB56dhnDtrFZileyzaSZ7v9gL1dPPPfYJrXJQxwsTsvW+7s8/OtNq3rmKHz3W3yadSYGsxk5vKG0XJer7duXrYe9tltJatkMecJwZ+Rc1kRTMIGc4cCYsMNwNyYIYiCzYny/hjANqT4hnafUvUGtToAmGpwE7uxYokgNkJaZ+SVgQkRfQ1H3JwxDYTjFX5mnCm7fgu0P3Ys3CFBuFHrNzUo28qi5csvGwX9VGQ13n0BzBu8HX7+lAO19sY/X37gsiyVUYMzFeqxdYb3QpibK9ER7qzW3gjR/Q+DVBOTMdO8fX07bukv9oTIr9HlPS428xsGza3U33x1716OYmL66es+wYYKG/4Y1LoT0mZ8CbeDOK1Z/BSe2eqa8tB8SvNBjl4nBxuMoviIOYsZA/NWguxjpH6OX2ShmKFnzgsaenavocD92kTKVQFZFabEjud0Uq0PH4Zrb04qdthoXhC1k7MvWu2zBTWhIL3tbK1oLDGvSvLHSs5eGmxsicCIDL7rH/ZY0cLL4uEIeKE23mjhrBT6VwpHEfOi9Bi/NZTwRc28dn19HWSDpbVDP1OSlsoS6ZOj1039WQUod4fmxS4M4DBhjQj6RadqthQB9R6GB+6h+qlGAM3MBRumhh0A8Wr1qJMaoAkfv76sWyMluR+cNig=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB2991.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfabd624-6266-4fff-1138-08d887cc4eac
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 12:04:43.4243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqLAZ/cES44TeRhUl1JIcpPapg/pfm8RQbvUc2+NNEtbd3VwXmT5B6s8pyWH9lBx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2989
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-13_10:2020-11-13,2020-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011130076
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On 11/12/20 4:57 PM, Daniel Xu wrote:=0A=
>> On Thu Nov 12, 2020 at 4:27 PM PST, Yonghong Song wrote:=0A=
>>>=0A=
>>>=0A=
>>> On 11/12/20 2:20 PM, Daniel Xu wrote:=0A=
>>>> Hi,=0A=
>>>>=0A=
>>>> I'm looking at the current implementation of=0A=
>>>> bpf_get_ns_current_pid_tgid() and the helper seems to be a bit overly=
=0A=
>>>> restricting to me. Specifically the following line:=0A=
>>>>=0A=
>>>>       if (!ns_match(&pidns->ns, (dev_t)dev, ino))=0A=
>>>>               goto clear;=0A=
>>>>=0A=
>>>> Why bail if the inode # does not match? IIUC from the old discussions,=
=0A=
>>>> it was b/c in the future pidns files might belong to different devices=
.=0A=
>>>> It's not clear to me (possibly b/c I'm missing something) why the inod=
e=0A=
>>>> has to match as well.=0A=
>>>=0A=
>>> Yes, pidns file might belong to different devices in theory so we need=
=0A=
>>> to match dev as well.=0A=
>>>=0A=
>>> The inode number needs to match so we can ensure user indeed wants to=
=0A=
>>> get the *current pidns* tgid/pid.=0A=
>>=0A=
>> Right, this double-checking at the API level is what feels strange to=0A=
>> me -- why make the user prove they know what they're doing?=0A=
> =0A=
> If we do not have this checking, it is possible that in interrupt=0A=
> context, pidns #10 user may get a tgid/pid actually from pisns #11,=0A=
> and tgid/pid could be valid for pidns #10. This result will be=0A=
> actually wrong.=0A=
> =0A=
>>=0A=
>> Furthermore, the "proof" restricts flexibility. It's as if=0A=
>> bpf_get_current_task() required a (dev,ino) pair. How would you get the=
=0A=
>> namespaced pid for a process you don't know about yet? eg when you're=0A=
>> profiling the system.=0A=
> =0A=
> Did not fully understand questions here. Do you mean=0A=
>    bpf_get_current_task(dev, ino)=0A=
> that will be weird. task is not associated with dev/ino.=0A=
> =0A=
>>=0A=
>>>=0A=
>>> (dev, ino) input expressed user intention. Without this, in no-process=
=0A=
>>> context, it will be hard to interpret the results.=0A=
>>=0A=
>> But bpf_get_current_pid_tgid() doesn't return errors so this shouldn't=
=0A=
>> either, right?=0A=
> =0A=
> Different helpers can have different signatures.=0A=
> =0A=
>>=0A=
>>>=0A=
>>>>=0A=
>>>> Would it be possible to instead have the helper return the pid/tgid of=
=0A=
>>>> the current task as viewed _from_ the `dev`/`ino` pidns? If the curren=
t=0A=
>>>> task is hidden from the `dev`/`ino` pidns, then return -ENOENT. The us=
e=0A=
>>>> case is for bpftrace symbolize stacks when run inside a container. For=
=0A=
>>>> example:=0A=
>>>>=0A=
>>>>       (in-container)# bpftrace -e 'profile:hz:99 { print(ustack) }'=0A=
>>>=0A=
>>> I think you try to propose something like below:=0A=
>>> - user provides dev/ino=0A=
>>> - the helper will try to go through all pidns'es (not just active=0A=
>>> one), if any match pidns match, returns tgid/pid in that pidns,=0A=
>>> otherwise, returns -ENOENT.=0A=
>>=0A=
>> Right, exactly.=0A=
> =0A=
> If you want to do this, you will need a new helper like=0A=
>    bpf_get_ns_pid_tgid=0A=
> =0A=
> It actually will be weird to use this helper as it looks like=0A=
> you try to get pid/tgid of another ns. So we do need to nail=0A=
> down the use case here.=0A=
=0A=
I'll try and describe the use case I have in mind. I expect folks would lik=
e to use bpftrace in container X to trace events in container Y, where X ma=
y or not be Y, provided the bpftrace process has the required access to Y's=
 namespace. For symbolization to work, bpftrace needs to get the pid of pro=
cesses in container Y but in the namespace of X. For example X could be a p=
arent cgroup to multiple workloads including X, and the owner of these work=
loads has access to X but not the host itself. I don't see it as trying to =
get pid/tgid from another namespace, it's actually to get the pid in the na=
mespace where it can be acted upon (i.e. X).=0A=
=0A=
>>> The current helper is=0A=
>>> bpf_get_ns_current_pid_tgid=0A=
>>> you want=0A=
>>> bpf_get_ns_pid_tgid=0A=
>>>=0A=
>>> I think it is possible, you need to check=0A=
>>> pid->numbers[pid_level].ns=0A=
>>> for all pid levels. You need to get a reference count for the namespace=
=0A=
>>> to ensure valid result.=0A=
>>>=0A=
>>> This may work for root inode, but for container inode, it may have=0A=
>>> issues. For example,=0A=
>>> container 1: create, inode 2=0A=
>>> container 1 removed=0A=
>>> container 2: create, inode 2=0A=
>>> If you use inode 2, depending on timing you may accidentally targetting=
=0A=
>>> wrong container.=0A=
>>=0A=
>> Yeah, so maybe an fd to /proc/<pid>/ns/pid or something.=0A=
>>=0A=
>>>=0A=
>>> I think you can workaround the issue without this helper. See below.=0A=
>>>=0A=
>>>>=0A=
>>>> This currently does not work b/c bpftrace will generate a prog that ge=
ts=0A=
>>>> the root pidns pid, pack it with the stackid, and pass it up to=0A=
>>>> userspace. But b/c bpftrace is running inside the container, the root=
=0A=
>>>> pidns pid is invalid and symbolization fails.=0A=
>>>=0A=
>>> bpftrace can generate a program takes dev/inode as input parameters in=
=0A=
>>> map. The bpftrace will supply dev/inode value, by query the current=0A=
>>> system/container, and then run the program.=0A=
>>=0A=
>> I don't think it's very feasible to have bpftrace integrate with every=
=0A=
>> container runtime out there. This also becomes really difficult to=0A=
>> manage if you want to trace N processes. You'd need N maps or N progs.=
=0A=
> =0A=
> Why, just one map to store dev/inode is shared among all progs, right?=0A=
> =0A=
>>=0A=
>>>=0A=
>>>>=0A=
>>>> What would be nice is if bpftrace could generate a prog that gets the=
=0A=
>>>> current pid as viewed from bpftrace's pidns. Then symbolization would=
=0A=
>>>> work.=0A=
>>>=0A=
>>> Despite the above workaround, what you really need is although it is=0A=
>>> running on container, you want to get stack trace interpreted with=0A=
>>> root pid/tgid for symbolization purpose? But you can already achieve=0A=
>>> this with bpf_get_pid_tgid()?=0A=
>>=0A=
>> No, this isn't possible when bpftrace runs inside the container. ie=0A=
>> bpftrace is in a pidns along with the tracees. Bpftrace gets the root=0A=
>> pidns pid from the kernel but cannot resolve it to the pidns pid. That=
=0A=
>> means bpftrace cannot find the executable file to symbolize against.=0A=
> =0A=
> Not sure whether I understand correct or not. You want root pid to=0A=
> find exec, right? but bpf_get_pid_tgid() will give your root pid?=0A=
> Maybe I miss something here...=0A=
=0A=
Looks like your suggestion is for bpftrace to use bpf_get_pid_tgid() when i=
t's running in the root namespace (i.e. the host), and bpf_get_ns_current_p=
id_tgid() when it's running in another namespace (i.e. a container). I thin=
k this would be fine in the short term, even though it doesn't cover all th=
e cases (see above). That said, I'd say the intelligence belongs more in a =
bpf helper than in user space.=0A=
=0A=
Thanks,=0A=
Blaise=
