Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABF7B1A5BAC
	for <lists+bpf@lfdr.de>; Sun, 12 Apr 2020 02:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgDLAgn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Apr 2020 20:36:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51942 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbgDLAgn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 11 Apr 2020 20:36:43 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03C0ZXP8003315;
        Sat, 11 Apr 2020 17:36:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=MVBLNR1ddoXo7RNV8M8mG0c0BkDG3UkMNe39ohn0qr4=;
 b=RuNn9IsSZAxHAe4mhKgwLATGqdgVe/WPutlwc8CDJNNY9OEsQtkFSE9L3QR783RCvJcI
 FIp3m02+eVAYvjaKwgwx2Y1E9wyuJL8nXm0m9haKFMR1nwRvVOFNqcM5sUyy4kFOZFKR
 k6d1Y1crTIlnUs1mHZspE4rGCAf1Bv5lwBQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30b9xdjn1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 11 Apr 2020 17:36:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Sat, 11 Apr 2020 17:36:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oelJAbHtJCAKwkybBjnbfsduA5d0XDJSAf5bfhogHP1k1WVZJqAvUnJJXdjr+IZEaYHaGdr817kknwnDBdmRvDe4UOesaROEpo7BlBKO4hXPIDfF6BHlyN5VAsP0eGxV3OsU48FbVFdW+ohNPEwme+vVd0Z0SNxSQtIXYoYAFH3zGL+uucolo59lkiBSt/bAnC0vaFlrrem9SwQHrroxyVt8mycw85zp8VDQQrrzSyQ1s7/ftxFRYpiaXC5lrpO8T/Qwt0s+X4xPMbIH0f+/QXoVaLRvGJP4aP9wLn+0XMQdtbkxGycVr2aq7qe9Hz7sKaeoNSGc9MFKUJenNzkNCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVBLNR1ddoXo7RNV8M8mG0c0BkDG3UkMNe39ohn0qr4=;
 b=QhIztKuofXh+H+fpTS/HUX+ARCXMNK0lGlBRdLwr6Afih08w48PfufysBcTMAxPU3p16WeLdBdOoy92/1k3Gu/fEVKbjgHt/3osC/i8lbHtwTStbVuxYrmWy+RJZZClQZIWqIDSoc9hZ28BFxi/dsKMXqkiU6UUGE7EYjJvAJrYXE41ixgxJeswxsO66ExNQnm0EHn8otAT6JJLCvVDG7aQEGl97eZzWV6URMxy9pIy0hLa9oTPPuaCOG9lHj8Po3EQQ1mTv5nkDikNl6CNwyUdCnz7pbC4v7mJ+kpi0LoNeOMep+byWKpfgtz3lTsVedoUT7/1/3gDcz0s5eQE45w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVBLNR1ddoXo7RNV8M8mG0c0BkDG3UkMNe39ohn0qr4=;
 b=WO4L/q68qXHDHa+Er99yVY3yKqwp/SvGKQlo3fj2C2VE/rCpTaZVW+lr3jAkKlFj8tW4nLTkVnE4GpX0TJ1eqHViuAOA9Wh3CpJo1GEjqzJQ3BaICqDXZh6Kh4UGDgBCKPXoVEBqvkCIFTrmojJqKHiJoZZGFuyMcBanVP1vXX4=
Received: from BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20)
 by BYAPR15MB3159.namprd15.prod.outlook.com (2603:10b6:a03:101::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Sun, 12 Apr
 2020 00:36:14 +0000
Received: from BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::90d6:ec75:fde:e992]) by BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::90d6:ec75:fde:e992%7]) with mapi id 15.20.2900.026; Sun, 12 Apr 2020
 00:36:07 +0000
Date:   Sat, 11 Apr 2020 17:36:04 -0700
From:   Andrey Ignatov <rdna@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf 1/2] libbpf: Fix loading cgroup_skb/egress with ret
 in [2, 3]
Message-ID: <20200412003604.GA15986@rdna-mbp.dhcp.thefacebook.com>
References: <cover.1586547735.git.rdna@fb.com>
 <daa546903aa74cf844452b7f80788d67c15b42ea.1586547735.git.rdna@fb.com>
 <CAEf4BzYvPawqgdP+cU94+US=hKGaD8qCBFtnu_JZae3eJ0+SUw@mail.gmail.com>
 <20200410225739.GA95636@rdna-mbp.dhcp.thefacebook.com>
 <20200411224214.32hiebejlsl2rc2k@ast-mbp>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200411224214.32hiebejlsl2rc2k@ast-mbp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: MWHPR11CA0004.namprd11.prod.outlook.com
 (2603:10b6:301:1::14) To BYAPR15MB4119.namprd15.prod.outlook.com
 (2603:10b6:a02:cd::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:400::5:53d7) by MWHPR11CA0004.namprd11.prod.outlook.com (2603:10b6:301:1::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17 via Frontend Transport; Sun, 12 Apr 2020 00:36:06 +0000
X-Originating-IP: [2620:10d:c090:400::5:53d7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff10660f-1150-4504-de04-08d7de797d56
X-MS-TrafficTypeDiagnostic: BYAPR15MB3159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3159484C18C1647045227C42A8DC0@BYAPR15MB3159.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0371762FE7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4119.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(396003)(136003)(346002)(376002)(39860400002)(54906003)(5660300002)(16526019)(66476007)(6486002)(186003)(6496006)(66946007)(52116002)(66556008)(9686003)(4326008)(33656002)(6916009)(2906002)(316002)(478600001)(8936002)(8676002)(81156014)(86362001)(1076003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mDThVmljQa3/ylpW6J337vaPgMUBAJm267nXY84nWPCe96KY5CkW9Yyfv57hsWYA0+eEAtRiitRvvBqEIkhgJArp27e0SwDxb/Su4VbgRKwtE/DXBRNOKn+qt0OtsckS0I9h/yP876j+pPnQY1IuSZzcvfHa62HM3MtsZBY/EvbYd7hIfU9J+JeGxBW+yIRQS3usd8S9z+cdi8LhnA5ZGouvOakN1S3WezPbNcZhZA/dnCrNJRKv81j4KsyfZsb2p0748DoT+f+iTd6p6RJMwF9FHtvi3EtU4QmhlVcocg5kNR0HA0oPywaNu/y2wQ0LUFnktLKSJT1KAcJERqoTIk1PGYlAiVJrdgOeEf3hpV+Y+IXJOAIlTER5iMmLe8gf2GBvtCD8bBpCgr5y66x/3b/9YWrzXxG4U7gaXm7x5Omgg/MEyfxpoV/WnP/E/paQ
X-MS-Exchange-AntiSpam-MessageData: qnyk0G8Z0nbCpS8+zycnargAqu92kO3xp81v0A+IHySgqc8qjXE13LnBvz0l1V7EIeZox8fghH5BL48n4sw/r5pgY5qk/3o+q0NpRfERff6hdWjzGI3ZcG/CpeTGt2FQmvIJiABwKZtFXHuU02la7tUZo0DU0kXWFqN8okMyK7ZlsLKHBCQ3h9xPi3FBcskw
X-MS-Exchange-CrossTenant-Network-Message-Id: ff10660f-1150-4504-de04-08d7de797d56
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2020 00:36:07.5246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrI9mt4THLZweZXGpxzZ0axy2SRg8QusCIdz/DiURJmarExGcitV5DEKBD30wmfk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3159
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-11_06:2020-04-11,2020-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004120004
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> [Sat, 2020-04-11 15:42 -0700]:
> On Fri, Apr 10, 2020 at 03:57:39PM -0700, Andrey Ignatov wrote:
> > 
> > > Seems like kernels accept expected_attach_type
> > > for a while now, so it might be ok backwards compatibility-wise?
> > 
> > Sure, that commit is from 2018, but I guess backward compatibility
> > should still be maintained in this case? That's a question to
> > maintainers though. If simply changing BPF_APROG_SEC to BPF_EAPROG_SEC
> > is an option that works for me.
> > 
> > 
> > > Otherwise, we can teach libbpf to retry program load without expected
> > > attach type for cgroup_skb/egress?
> > 
> > Looks like a lot of work compared to simply adding a new section name
> > (or changing existing section if backward compatibility is not a concern
> > here).
> 
> I still don't understand that backward compatiblity concern.
> Fixing libbpf to do BPF_EAPROG_SEC("cgroup_skb/egress"
> will make egress progs to fail at load time if they use > 1 return value on old
> kernels

No. Changing BPF_APROG_SEC to BPF_EAPROG_SEC will fail loading programs
on old kernels with any return value, incl. 0 and 1.  That's the point.

> and fail at load time for > 3 return value on new kernels. Without
> libbpf fix such progs would rely on old and new kernels internal implementation
> details. Since on the latest kernel with current libbpf behavior the egress
> prog will get loaded as ingress type with return value 4 and then gets attached
> at egress. Argh. One really need to deep dive into kernel sources to figure out
> what kernel will do with such return value. Such behavior is undefined and broken.
> Did I misunderstand the whole issue?

Let me try to explain with an example.

I patched libbpf and built bpftool with this patch:

  17:00:43 0 rdna@dev082.prn2:~/bpf-next$>git di tools/lib/bpf/
  diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
  index ff9174282a8c..cc4d5b74e64a 100644
  --- a/tools/lib/bpf/libbpf.c
  +++ b/tools/lib/bpf/libbpf.c
  @@ -6330,7 +6330,7 @@ static const struct bpf_sec_def section_defs[] = {
          BPF_PROG_SEC("lwt_seg6local",           BPF_PROG_TYPE_LWT_SEG6LOCAL),
          BPF_APROG_SEC("cgroup_skb/ingress",     BPF_PROG_TYPE_CGROUP_SKB,
                                                  BPF_CGROUP_INET_INGRESS),
  -       BPF_APROG_SEC("cgroup_skb/egress",      BPF_PROG_TYPE_CGROUP_SKB,
  +       BPF_EAPROG_SEC("cgroup_skb/egress",     BPF_PROG_TYPE_CGROUP_SKB,
                                                  BPF_CGROUP_INET_EGRESS),
          BPF_APROG_COMPAT("cgroup/skb",          BPF_PROG_TYPE_CGROUP_SKB),
          BPF_APROG_SEC("cgroup/sock",            BPF_PROG_TYPE_CGROUP_SOCK,

Wrote a simple cgroup_skb/egress program that returns 1 and built it:

  17:00:59 0 rdna@dev082.prn2:~/bpf-next$>cat tools/testing/selftests/bpf/progs/skb_ret1.c
  #include <linux/bpf.h>
  #include <bpf/bpf_helpers.h>
  
  int _version SEC("version") = 1;
  char _license[] SEC("license") = "GPL";
  
  SEC("cgroup_skb/egress")
  int skb_ret1(struct __sk_buff *skb)
  {
          return 1;
  }

Made sure that it can be loaded on new kernel:

  17:00:39 0 rdna@dev082.prn2:~/bpf-next$>uname -srm
  Linux 5.2.9-93_fbk11_rc1_3610_g6a108f4f4a2b x86_64
  17:01:10 0 rdna@dev082.prn2:~/bpf-next$>sudo ./tools/bpf/bpftool/bpftool p load tools/testing/selftests/bpf/skb_ret1.o /sys/fs/bpf/skb_ret1
  17:01:25 0 rdna@dev082.prn2:~/bpf-next$>sudo ./tools/bpf/bpftool/bpftool p l pinned /sys/fs/bpf/skb_ret1
  87347: cgroup_skb  name skb_ret1  tag 9bf8e2a8bee581f5  gpl
          loaded_at 2020-04-11T17:01:25-0700  uid 0
          xlated 16B  jited 40B  memlock 4096B
          btf_id 4952

Then copied both bpftool and the program to a server with old kernel
(that doesn't have 5e43f899b03a ("bpf: Check attach type at prog load
time")) and tried same thing (note "./bpftool"):

  [root@<some_host> ~]# uname -srm
  Linux 4.11.3-45_fbk11_3602_gd67c71c x86_64
  [root@<some_host> ~]# ./bpftool p load ./skb_ret1.o /sys/fs/bpf/skb_ret1
  libbpf: Error loading BTF: Invalid argument(22)
  libbpf: Error loading .BTF into kernel: -22.
  libbpf: load bpf program failed: Invalid argument
  libbpf: failed to load program 'cgroup_skb/egress'
  libbpf: failed to load object './skb_ret1.o'
  Error: failed to load object file
  [root@<some_host> ~]# echo $?
  255
  [root@<some_host> ~]# ./bpftool p l pinned /sys/fs/bpf/skb_ret1
  Error: bpf obj get (/sys/fs/bpf/skb_ret1): No such file or directory

As you can see it fails to load (BTF errors are not relevant).

Then I tried to load same program on same old kernel but with prod
bpftool (w/o my patch) just to make sure BTF is not a problem and it
loads fine:

  [root@<some_host> ~]# bpftool p load ./skb_ret1.o /sys/fs/bpf/skb_ret1
  libbpf: Error loading BTF: Invalid argument(22)
  libbpf: Error loading .BTF into kernel: -22.
  [root@<some_host> ~]# echo $?
  0
  [root@<some_host> ~]# bpftool p l pinned /sys/fs/bpf/skb_ret1
  23944: cgroup_skb  name skb_ret1  tag 9bf8e2a8bee581f5
          loaded_at 2020-04-11T17:12:07-0700  uid 0
          xlated 16B  jited 64B  memlock 4096B
  [root@<some_host> ~]#

That's expected becase the error at loading time happens long before
running verifier and doesn't have anything to do with what program
returns. It fails on `if (CHECK_ATTR(BPF_PROG_LOAD))` in kernel's
bpf_prog_load() -- the very first check that happens in that function.

Old kernel checks that passed by user-space bpf_attr has all bytes after
bpf_attr.prog_ifindex (the BPF_PROG_LOAD_LAST_FIELD known to that
kernel) zero, but finds that there is non-zero unknown field, that is
expected_attach_type, and fails.

So changing BPF_APROG_SEC to BPF_EAPROG_SEC will break loading cgroup
skb egress progs on any kernel before 5e43f899b03a ("bpf: Check attach
type at prog load time"), no matter what those programs do. That's why I
think it's not a good idea.

Does it clarify?

-- 
Andrey Ignatov
