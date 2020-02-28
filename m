Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA9261740BD
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2020 21:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgB1ULW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Feb 2020 15:11:22 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57246 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725886AbgB1ULV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 28 Feb 2020 15:11:21 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01SJtlbu004121;
        Fri, 28 Feb 2020 12:11:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=XYKsiL3aE/m/YzUtjeZL0Uuc3p5TZR2bP9Y/QBGISuI=;
 b=C8K3YCP/asMN7wH7SC1X2j3NT0CDCG6DvB2mR5X6J8gS7ySuv1Ogjz71YyY+dG78anDG
 baJqAau4YaGhWvh1cc1K2ULKvQcT477lrtNILkssWIxdBRJM2ay5LLn5ZTOhfelruK/w
 K6AcRIaikss6mT6CPlGApCYc3OEYBbZHMVA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yepurwan0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 28 Feb 2020 12:11:08 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 28 Feb 2020 12:11:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdC4qFTwTJqhkU41K+MTfcYDmXvH2KPrILPUotmL6KnU2XY6XIGVlvToHWq86qrwxkPnNNoJHAskax+9R7SeUJaP6POhYbY10hIKSyuDVwzgb89uKHAXqfyL6oNzvjFffrOD5WYFHw3HaMxz38jZaqKxRkM9lSf/rEIyJapgzFb7mucMUCaGtkEJzISGYh0exLYuhnjrY23a0vji5ZXz4dVEXDG/h56n1voZ/YfbIanNCEFf7mq+UcDaqe9LbmR0VQK7vfjnJfQxAGvT5O6Rz58aaWxsQbGC6QLMbxZvA7hZYi9S7T7spOzD+gMQg1ieWHIQbugvl72NZz8krNoEjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYKsiL3aE/m/YzUtjeZL0Uuc3p5TZR2bP9Y/QBGISuI=;
 b=J8iP0NA4qUMdA+Cf5peDR6VCafbARAUzJYBufaAMXxTWEOJLsiUx3dije+p/b1Dcpd1YTeyA5YfI8LTKKWit44HLwLcbzvmLFl3AhxhqZpFzIRQB3pVkTEEo3PQyp5LVZ70V0AX/RZXA1XyLMddiX/jXM8hP+jEgLpdkohn8t5iqa55ZFczziMawcI3FsUhjnN/z4I+28lAUc9vBpXBQ0XjGzejLmNySLDYkSx5T/+8Yz8ot22ypcwKccU4QpTtokITdXsCtmveo2dMMv6Uwnh5kqvRwdGhYserLBI2PKfSPmg0vzjbYr0+n98W1SqaLWhlEPpmh3DKxIsPYgYSWEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYKsiL3aE/m/YzUtjeZL0Uuc3p5TZR2bP9Y/QBGISuI=;
 b=YLz+ZCjhZu9GOvT7MYFvEWyyMp9XQmpUA0PWeY/m414EnVWUb6FrPlWrVXoGZW39dqpSlhWHDYyOr0jJvn8d9MN0Hk1GbDEbxeBGZyYF3UG0HVKguhR8SU9Oa/68Qc1jBrRYCF8JE3M/zIiLtpBOLRvcOF2uoJTp5Zb6ZrsQ0K8=
Received: from MWHPR15MB1294.namprd15.prod.outlook.com (2603:10b6:320:25::22)
 by MWHPR15MB1216.namprd15.prod.outlook.com (2603:10b6:320:22::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 28 Feb
 2020 20:11:06 +0000
Received: from MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::b47a:a4d2:b9dd:eb1e]) by MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::b47a:a4d2:b9dd:eb1e%5]) with mapi id 15.20.2750.021; Fri, 28 Feb 2020
 20:11:06 +0000
Date:   Fri, 28 Feb 2020 12:11:04 -0800
From:   Andrey Ignatov <rdna@fb.com>
To:     Omar Sandoval <osandov@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     Stanislav Fomichev <sdf@fomichev.me>, <ast@kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>, <tj@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Add drgn script to list progs/maps
Message-ID: <20200228201104.GA51456@rdna-mbp>
References: <20200227023253.3445221-1-rdna@fb.com>
 <20200227180102.GA188741@mini-arch.hsd1.ca.comcast.net>
 <20200227182653.GC29488@rdna-mbp>
 <8cbe6219-004c-e4f0-5f1e-5270c326f21b@iogearbox.net>
 <24d4115d-d36b-91fe-cad9-ce7fbb5d714a@iogearbox.net>
 <7d2e2356-e0c1-4a31-d820-c07317b5746c@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d2e2356-e0c1-4a31-d820-c07317b5746c@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: MWHPR15CA0029.namprd15.prod.outlook.com
 (2603:10b6:300:ad::15) To MWHPR15MB1294.namprd15.prod.outlook.com
 (2603:10b6:320:25::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:500::6:b9bd) by MWHPR15CA0029.namprd15.prod.outlook.com (2603:10b6:300:ad::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend Transport; Fri, 28 Feb 2020 20:11:05 +0000
X-Originating-IP: [2620:10d:c090:500::6:b9bd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1478495-cfc2-4fa6-8c4d-08d7bc8a57ab
X-MS-TrafficTypeDiagnostic: MWHPR15MB1216:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB1216BFB95F3F34DAB01E9D4FA8E80@MWHPR15MB1216.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10001)(10019020)(7916004)(346002)(376002)(396003)(39860400002)(136003)(366004)(199004)(189003)(16526019)(4326008)(33656002)(966005)(5660300002)(186003)(9686003)(33716001)(2906002)(8676002)(86362001)(316002)(53546011)(110136005)(1076003)(52116002)(6486002)(6496006)(66946007)(478600001)(81156014)(66556008)(81166006)(66476007)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1216;H:MWHPR15MB1294.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLXp9kZ1MhadoUo180Oh246R4B7J6O8gfZhFiJBHVzSpctODVWASjY8J8cw0rWDyoWnz9jTueVRrBLjpcoYKe32JZs/thW6QCfDyCxo8cqgLbAqK1J3NJhpnUTtjzjwXp+MYbsOrnWVrK8daw/qTvivMNlLquD9tCHZMXmVNQr9M5s2JHJebQj0u9kmXO587+Saqj54SdfGMHU9S4JUiGqY0kuhedsQboxdAPwW1mMYPBAcn3Lqh6S06Dv33okJByx1Bbl1M8MCRfO5gy2H/Gx50jj6AhDPC9MZkFewMPsu6kXP09MDOnuYmkJ9uJZtUGXbgDJ+nsFoyNnoKhaIjODsdiqpZcrcNALUQYXEYddtwww1To8YmLpxpq8TeS9KPG5llawAXDfJm5hLQT40Le+qoan08S6YZIueKqvngY9+ro0T0ibxQJfdGEjg0d1KfYdon5ekHhHJzAgRDUknC6GfK+idDUeDcYeqCmEcit4anzq+8uQKPmaE1zxVq3nEF9WgUzkXYhWC9cKoSHWbVTjtpAfpjKl4zICCa07epXys83xNrT5r+CQHjGAvsC+IiRlwi8GyzLI0Lqb0Lak7aSw8uHuvu/0cE7Pc1ROAbytfOrhH/y2tDdb2PVETLy9r4
X-MS-Exchange-AntiSpam-MessageData: +01W/imgVX5FqJG12qkS/D/qnB26ODrvUoab2o0DcC4o36qLPWthNjRoN3gAvJz8bKNh/qvDxGcalXmoVfkJTrQW0UHfGEvHIRUbt1Gayhdf9vlbA5C0whgLaOdqhKH4rYgp/64eJp2cfcdTXee89K5z1zx6iG+slTe1Z8vkUCI8xmKvmIHtyLfPn64stRDb
X-MS-Exchange-CrossTenant-Network-Message-Id: d1478495-cfc2-4fa6-8c4d-08d7bc8a57ab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 20:11:06.3141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCC8HKiY622vCnH+bySrYhkgCL3nXVB22f92U5C4JMYr3coypN1Vkz4TvclRWYpC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1216
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-28_07:2020-02-28,2020-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002280140
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Omar Sandoval <osandov@fb.com> [Thu, 2020-02-27 14:19 -0800]:
> On 2/27/20 1:32 PM, Daniel Borkmann wrote:
> > On 2/27/20 10:11 PM, Daniel Borkmann wrote:
> >> [ +tj ]
> >>
> >> On 2/27/20 7:26 PM, Andrey Ignatov wrote:
> >>> Stanislav Fomichev <sdf@fomichev.me> [Thu, 2020-02-27 10:01 -0800]:
> >>>> On 02/26, Andrey Ignatov wrote:
> >>>>> drgn is a debugger that reads kernel memory and uses DWARF to get types
> >>>>> and symbols. See [1], [2] and [3] for more details on drgn.
> >>>>>
> >>>>> Since drgn operates on kernel memory it has access to kernel internals
> >>>>> that user space doesn't. It allows to get extended info about various
> >>>>> kernel data structures.
> >>>>>
> >>>>> Introduce bpf.py drgn script to list BPF programs and maps and their
> >>>>> properties unavailable to user space via kernel API.
> >>>> Any reason this is not pushed to https://github.com/osandov/drgn/ ?
> >>>> I have a bunch of networking helpers for drgn as well, but I was
> >>>> thinking about contributing them to the drgn github, not the kernel.
> >>>> IMO, seems like a better place to consolidate all drgn stuff.
> >>>
> >>> I have this part in the commit message:
> >>>
> >>>>> The script can be sent to drgn repo where it's easier to maintain its
> >>>>> "drgn-ness", but in kernel tree it should be easier to maintain BPF
> >>>>> functionality itself what can be more important in this case.
> >>>
> >>> That's being said it's debatable which place is better and I'm still
> >>> trying to figure it out myself since, from what i see, there is no
> >>> widely adopted practice.
> >>>
> >>> I've been contributing to drgn as well mostly in two forms:
> >>> * helpers [1];
> >>> * examples [2]
> >>>
> >>> And so far I used examples/ dir as a place to keep small useful "tools"
> >>> (tcp_sock.py, cgroup.py, bpf.py).
> >>>
> >>> But there is no place for bigger "scripts" or "tools" in drgn (yet?). On
> >>> the other hand I see two drgn scripts in kernel tree already:
> >>> * tools/cgroup/iocost_coef_gen.py
> >>> * tools/cgroup/iocost_monitor.py
> >>>
> >>> So maybe it's time to discuss where to keep tools like this in the
> >>> future.
> >>>
> >>> In this specifc case I'd love to see feedback from Omar and BPF
> >>> maintainers.
> >>
> >> I can certainly see both sides given that drgn tools have been added to
> >> tools/cgroup/ already. I presume if so, then these could live in tools/drgn/
> >> which would also make it more clear what is needed to run as dependency
> >> plus there should be be a proper high-level readme to document what developers
> >> need to run in order to run them. But from looking at [1], I can also see that
> >> those scripts would depend on new helpers being added/updated/deleted, so it
> >> might be easier to add drgn/tools/ directory where scripts could be updated
> >> in one go with updates to drgn helpers. Either way, I think it would be nice
> >> to add documentation somewhere for getting people started.
> > 
> > One example that should definitely be avoided is 9ea37e24d4a9 ("iocost: Fix
> > iocost_monitor.py due to helper type mismatch") due to both living in separate
> > places. A third option to think about (if this is to be adapted by more subsystems)
> > could be to have all the kernel-specific helpers from drgn/helpers/linux under
> > tools/drgn/helpers/ in the kernel tree and the tools living under
> > tools/drgn/<subsys>/ e.g. tools/drgn/bpf/.
> > 
> >>> [1] https://github.com/osandov/drgn/tree/master/drgn/helpers/linux
> >>> [2] https://github.com/osandov/drgn/tree/master/examples/linux
> > 
> I can think of a few benefits of having this tool (and others like it)
> in the drgn repository:
> 
> * Easier to keep in sync with new helpers/API changes
> * More examples in one centralized place for people building new tools
> * Potential to identify pain points in the API and possible new helpers
> 
> I think this would benefit the drgn project as a whole.
> 
> The downsides:
> 
> * More maintenance for me
> * Tools will have to support multiple kernel versions (as opposed to
>   only supporting the kernel that they shipped with)
> * Less visibility for kernel developers
> 
> That second point is true of the helpers bundled with drgn anyways, so I
> don't think it's a big deal. The third point will improve over time as
> we get more people on the drgn train :)
> 
> I may come to regret the first point, but I think the upsides are worth
> it. Andrey, feel free to submit a PR adding this to the drgn repository
> under a new top-level tools/ directory.

Daniel, Omar, thanks for your input. This all makes sense and it seems
we're coming to an agreement that it'll be easier to support tools like
this in drgn repo. That works for me and with this in mind I see the
followig way forward:

- I'll submit PR to drgn repo to create a new tools/ directory and place
  the script there using the bpf_inspect.py name suggested by Andrii.
  This way the script will be in sync with all the recent changes to 
  drgn helpers;

- As soon as PR is merged I'll add documentation to kernel tree to make
  folks aware that such a tool exists, if there are any recommendation
  where to add the documentation to I'd appreciate it.

- I'll try to make the script less dependent on kernel version
  (Quentin's feedba) since it'll exist separate from the kernel
  sources.


Hope it works for everyone, please lmk if it doesn't for some reason of
if I missed something. Thanks.


-- 
Andrey Ignatov
