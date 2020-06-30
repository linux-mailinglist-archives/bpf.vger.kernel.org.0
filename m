Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A7F20F7EC
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 17:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgF3PI6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 11:08:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17224 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbgF3PI6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Jun 2020 11:08:58 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05UF19nl011041;
        Tue, 30 Jun 2020 08:08:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=4KBQdfW8b+YlHJDNBRCW+LXTjYA656HPUdSLnr/YOfI=;
 b=l/pHigIpgM+KBnMHq5TfGWitO64RLfuv68WVeyZ2eKe1jdcYV4FhojZxTUyH6oKLXqmb
 rtg+/u3Rq/vvTnWiGgSo8Er9jBp1fDhhyCdTNYUL0fKiKpG+zfcoMhVduADO0l5ycuDE
 4PDA8fJUgKgPmawLdP08K4XrtxYZLmIu6fw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31xny2aapk-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Jun 2020 08:08:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 30 Jun 2020 08:08:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGqQwuHb3LInQn5vMlR3WyOmDWLOVIaCykTrYVgVvtn74nG981nicYFb9ku9Z7JfRiTONC57o7XyHI5ERbxP/u8wic0O9w2UZ9VGhz1AxwaiHMHxOyLpuREaWksk7XOu/+HbQdyrIx/6M/6MRlOLoiiazN5G0lytMWcdqHbZWk8pZctA+6EL1WJh6FrKJTSFb8K7mEjjitHnv12YNMFFgeX6iKPOzuJh8M9W/Bu2vdVDNGkXgsO3tALDgQK+LsQmKVuLzj9Q8ZtmXsvS/J9O3Rjn9bPLiD6vAKZteeVET6cB1g7ARmFC7kHl4Gty6CUPjR3QePHRiwrlcNzFjxwKyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KBQdfW8b+YlHJDNBRCW+LXTjYA656HPUdSLnr/YOfI=;
 b=HJPR2kVoAdQZ+V6E2WNb43UeShoGv1QyUMWvS9BcdyDrT2+M5LDMoW0PLw4059NaZMlI/JHPboTM82hcCFXutNvc6BlJ17QrN565KeLEI6j/uom1pArT2s+SnN/YpT/vWDqdpn9LZ9N/+bRIkTv7pvfLLzAxvotD3TpfysJQ8tYfhSxthMrWT1PSZBydVtU7C2WYH2ghRdA9R/ksNpZreJI0IZ9QgVmGjR+BQ2cgkP3G5/5WeZHjDOXo0mShjrEDQoEHDQxt6pMKD2CndqQ4lnQJw+CM4zYrDKpz5wKL+KeZpx5kyPgTetrY7NoCWOH5r/epiMEw2Jrc7OXL9/5X1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KBQdfW8b+YlHJDNBRCW+LXTjYA656HPUdSLnr/YOfI=;
 b=OtNze9VXwEXSeHngetd6C2eUfLXv483RJlwAjWdddxlhPc74xVPl3m3W1UtnIh/sHhOy2rnM/io54HyW/NFxCg5bkicViuyu/ChfSBwFLA1xKgAnPdARPelvgM1td6FJ0K00i5qoI9oqwtwW34OBXD/K6hgqlC6RlccJm+uGAQA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3191.namprd15.prod.outlook.com (2603:10b6:a03:107::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Tue, 30 Jun
 2020 15:08:36 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 15:08:36 +0000
Subject: Re: [PATCH bpf v2 0/6] Fix attach / detach uapi for sockmap and
 flow_dissector
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>
References: <20200629095630.7933-1-lmb@cloudflare.com>
 <07d10dab-64f7-d7af-25b9-a61b39c8daf2@fb.com>
 <CACAyw9_5Dg=dTMk3TQiYFE3vzUuq68V2-NcpZCuiQqJFPn-0Dw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <8fcf1a4c-5a5a-280a-65eb-fa8bc8a298c1@fb.com>
Date:   Tue, 30 Jun 2020 08:08:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <CACAyw9_5Dg=dTMk3TQiYFE3vzUuq68V2-NcpZCuiQqJFPn-0Dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0050.namprd11.prod.outlook.com
 (2603:10b6:a03:80::27) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::15c2] (2620:10d:c090:400::5:c3b5) by BYAPR11CA0050.namprd11.prod.outlook.com (2603:10b6:a03:80::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Tue, 30 Jun 2020 15:08:35 +0000
X-Originating-IP: [2620:10d:c090:400::5:c3b5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 539602ab-5612-4c3d-b9e3-08d81d07767c
X-MS-TrafficTypeDiagnostic: BYAPR15MB3191:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3191940E5178FB21608011B0D36F0@BYAPR15MB3191.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0h74q/bhhnpAk2mIbLnAP7V2UYukDxa1GUGf1xRI/41BcoxaLUrQHuOIpaaffVafu8LXiBGYNs1eSQIJiITF5wA4YDHA8wLKqlleclkqZenmhC3FarPHm1+30fR09XEPmWdE1Qfng526iRJRrEPw9v5cb2CZ44ZwOzaLRNZR0CtaeKv5V51A/hajUNBdzqYL40HFB4IQOLs/Iwa3DYWyCxyUiT3Q5Kd2RB4w/AryvJRuY7J4h9v+zR7JDebpqihK/UzNhdj6mk+EsGutHFBdOtes85T6vMvDwcQfhcOFU2vzNwxJpBCHzHW1V/u1b2MCl2sQsPTWFcA/hC4TVAKldXZBJSKJiWrLnzQJhcLgDkptH60hQABY88NU1GaEH9FQhVSw02Hudnqhiq8DeUrVbykq1c8xJsPIwCY7d9ENP8S9QjOrewbRwP99eZxQ2Tw6LHpmptZzPIZg8DgQlA+9Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(5660300002)(66556008)(66476007)(66946007)(8676002)(2616005)(8936002)(6486002)(6916009)(2906002)(478600001)(966005)(53546011)(52116002)(54906003)(36756003)(316002)(31696002)(83380400001)(4326008)(16526019)(186003)(31686004)(86362001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 44WJvBvj1NIpDwv1NYYHcue5vFGyHksug6HHCWPQarN9vMbsTTWjL24GFASDS6afzd6xslCmDbWo7vIkGlKCTETAYoD1tuhE5ATFkEc5VMPRuOD0Pa6TjrU3/qpkafaGau5p/DRepwqreQTu2jwHKEW2DXmGAL8SOdzY2+t1Bp0l3Wu1WkqzAngKSNJM8ppWI3LexPeFwCm2WmGYDZkCe44EaDETZeh0tpTjFgiblhT6wV8grpHB+TxtxZ1tG3bjW/Y+/VtpaVm9fGdxT21OGDV1uxBHTGzrTFwWMUPsZvt2TApkbiyWZZyRgilxe/MDY/5PEUQgyiF5wbtQnV3v8PAYDGXTK8sQ+PjWN/MlU6yM9M9gWE0axMHM6ycyZqlTjKkWXNEW4nDEexysdh9y5vr7jv+y8asKaVEH4k9jM4Hxrek433tEq2+YLDNHtQApoJlH6PPyzPy5YhoIoxSIJLs3IwyYbLfa0JRVytPIgIvCxzc7U76mBuN4AJcM6wR8LDtjHP/KTlcUvlJQC6mTMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 539602ab-5612-4c3d-b9e3-08d81d07767c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 15:08:36.5085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmZbnHULfmkyADa2JXMdSgfT3tfVRKJ9jnNcNe1A0tfv11VzLneA3IQLlzZIKOEd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3191
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_06:2020-06-30,2020-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 cotscore=-2147483648
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300110
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/30/20 1:39 AM, Lorenz Bauer wrote:
> On Tue, 30 Jun 2020 at 06:48, Yonghong Song <yhs@fb.com> wrote:
>>
>> Since bpf_iter is mentioned here, I would like to provide a little
>> context on how target_fd in link_create is treated there.
> 
> Thanks!
> 
>> Currently, target_fd is always 0 as it is not used. This is
>> just easier if we want to use it in the future.
>>
>> In the future, bpf_iter can maintain that target_fd must be 0
>> or it may not so. For example, it can add a flag value in
>> link_create such that when flag is set it will take whatever
>> value in target_fd and use it. Or it may just take a non-0
>> target_fd as an indication of the flag is set. I have not
>> finalized patches yet. I intend to do the latter, i.e.,
>> taking a non-0 target_fd. But we will see once my bpf_iter
>> patches for map elements are out.
> 
> I had a piece of code for sockmap which did something like this:
> 
>      prog = bpf_prog_get(attr->attach_bpf_fd)
>      if (IS_ERR(prog))
>          if (!attr->attach_bpf_fd)
>              // fall back to old behaviour
>          else
>              return PTR_ERR(prog)
>      else if (prog->type != TYPE)
>          return -EINVAL
> 
> The benefit is that it continues to work if a binary is invoked with
> stdin closed, which could lead to a BPF program with fd 0.

For bpf_iter, there is no legacy. So I will have something like
     // somecondition could be new attr->flags, or some kernel internal 
checking
     if (somecondition) {
       /* not accepting fd 0 */
       if (attr->attach_bpf_fd == 0)
         return -EINVAL;
       prog = bpf_prog_get(attr->attach_bpf_fd)
       if (IS_ERR(prog))
         return PTR_ERR(prog)
     } else if (attr->attach_bpf_fd != 0)
       return -EINVAL;
or I could have
     if (somecondition) {
       /* accepting any fd */
       prog = bpf_prog_get(attr->attach_bpf_fd)
       if (IS_ERR(prog))
         return PTR_ERR(prog)
     } else if (attr->attach_bpf_fd != 0)
       return -EINVAL;

This "somecondition" is false for the current bpf_iter, so existing
behavior attr->attach_bpf_fd == 0 is still enforced.

> 
> Could this work for bpf_iter as well?
> 
>>
>> There is another example where 0 and non-0 prog_fd make a difference.
>> The attach_prog_fd field when doing prog_load.
>> When attach_prog_fd is 0, it means attaching to vmlinux through
>> attach_btf_id. If attach_prog_fd is not 0, it means attaching to
>> another bpf program (replace). So user space (libbpf) may
>> already need to pay attention to this.
> 
> That is unfortunate. What was the reason to use 0 instead of -1 to
> attach to vmlinux?

attaching to vmlinux happens first and at that time attach_prog_fd
does not exist. Later when replace prog feature is introduced,
attach_prog_fd is added. This field is used to differentiate
between vmlinux func attachment vs. bpf_prog attachment. A little
bit unfortunate, but using 0 is easier as we have check_attr
in the kernel to ensure all kernel-unsupported fields must be 0.
using -1 will break that.

> 
>>
>>> work around for fd 0 should we need to in the future.
>>>
>>> The detach case is more problematic: both cgroups and lirc2 verify
>>> that attach_bpf_fd matches the currently attached program. This
>>> way you need access to the program fd to be able to remove it.
>>> Neither sockmap nor flow_dissector do this. flow_dissector even
>>> has a check for CAP_NET_ADMIN because of this. The patch set
>>> addresses this by implementing the desired behaviour.
>>>
>>> There is a possibility for user space breakage: any callers that
>>> don't provide the correct fd will fail with ENOENT. For sockmap
>>> the risk is low: even the selftests assume that sockmap works
>>> the way I described. For flow_dissector the story is less
>>> straightforward, and the selftests use a variety of arguments.
>>>
>>> I've includes fixes tags for the oldest commits that allow an easy
>>> backport, however the behaviour dates back to when sockmap and
>>> flow_dissector were introduced. What is the best way to handle these?
>>>
>>> This set is based on top of Jakub's work "bpf, netns: Prepare
>>> for multi-prog attachment" available at
>>> https://lore.kernel.org/bpf/87k0zwmhtb.fsf@cloudflare.com/T/
>>>
>>> Since v1:
>>> - Adjust selftests
>>> - Implement detach behaviour
>>>
>>> Lorenz Bauer (6):
>>>     bpf: flow_dissector: check value of unused flags to BPF_PROG_ATTACH
>>>     bpf: flow_dissector: check value of unused flags to BPF_PROG_DETACH
>>>     bpf: sockmap: check value of unused args to BPF_PROG_ATTACH
>>>     bpf: sockmap: require attach_bpf_fd when detaching a program
>>>     selftests: bpf: pass program and target_fd in flow_dissector_reattach
>>>     selftests: bpf: pass program to bpf_prog_detach in flow_dissector
>>>
>>>    include/linux/bpf-netns.h                     |  5 +-
>>>    include/linux/bpf.h                           | 13 ++++-
>>>    include/linux/skmsg.h                         | 13 +++++
>>>    kernel/bpf/net_namespace.c                    | 22 ++++++--
>>>    kernel/bpf/syscall.c                          |  6 +--
>>>    net/core/sock_map.c                           | 53 +++++++++++++++++--
>>>    .../selftests/bpf/prog_tests/flow_dissector.c |  4 +-
>>>    .../bpf/prog_tests/flow_dissector_reattach.c  | 12 ++---
>>>    8 files changed, 103 insertions(+), 25 deletions(-)
>>>
> 
> 
> 
