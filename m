Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A937191975
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 19:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgCXSuz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Mar 2020 14:50:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21490 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727468AbgCXSuz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Mar 2020 14:50:55 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OIn1mG008716;
        Tue, 24 Mar 2020 11:50:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=XBUYh84XJvgf2flvNNmjzR0csAvDgDzHvzDsqW6OrvY=;
 b=kYeLh2YelOZTGwNI0lyRhbMFSbltWRe1Go059N5s/p3c8Nvzp0J9TmEVNpTaV6CxZykS
 mGdA9NItak7QkxwevQ0Hf/7NVZSIir488g4uOSSsKA2y/9nhyYn9mPKizhFu3P4uFPsk
 UTZG0MPRi967hU24vwzLbzzBqtW0H0fBYoc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yx2xyc5bb-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Mar 2020 11:50:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 24 Mar 2020 11:50:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKnib5XOe+AJw7L1KaL9N5BQ/Dn79HVVyIdAi/r4gLKVGltvPJv4cDM1gnXlwfx7SnhUe2aX/hBkacy/DQF1fMZxAPOvKqgVISo6mIcooBCV415f07dpKXvHBaB7ekdqVf3PIkjCNfbUWYe7P/ME0ZOhqtgiMDVHEO8PTUEiFj1pDmzfBYfe5G/U097CFV5/4KmwuUVcxMnL1Zh2VCOPcpnHRjnlfgoAVrgmIVNrBdUJTtQehRXAhwUX9gIjat9fdl8v8LDOGuEzr8KON+MfgvLKvvnrSJzYf10Uko2jUIFy5WQRE8uygQ9RMf1ilzLUQYtJJeSkXHpl+UztRxlWEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBUYh84XJvgf2flvNNmjzR0csAvDgDzHvzDsqW6OrvY=;
 b=CZMFtzOLUrOZspdYnDPiItCwRHEJNv/HjGLLDRK69XN7u1D4gIAncN9B5hIQcmr+p3TfK+/eTFL1WEvlh7adY1PdlHaoxlUXvRbIU8vHrjoQaXyfG4wloH9Rd9bQ46GTOSx8bollJi6kga5oNecxiLywjK3AOdS4P+rhLCso8NHWaoT3Z/wiAcgaDcb2748tcJO+KwO7H2VYv0Q+yPlXiArbHPRxJzkz/iExaaTJTg9gRCDRrY/RrAGLO/VQsPSwlg7f+aL7Oda966Xdpfj96Q2iRkj75+eb2fGFpY9orDQ4fbyYHcLusrr/Wupjma6VnljcC14raQHNKWirxSPJew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBUYh84XJvgf2flvNNmjzR0csAvDgDzHvzDsqW6OrvY=;
 b=Hc+eC+Er6yJI22UCdXp5FXRATQHAnRS2rbudtXTc2yghSHcZtOF9VT1vYg1LnGgp75ihv86Bg7ccf0q8BIG+bCKoki1Z5o3dN98ucM04BmznG6YmIh/tk1TaaiyX1Uj8CBsK3kA/XRCo6EiZOcgj08Xu3MOqTVEPiYtTR4gy/H0=
Received: from BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20)
 by BYAPR15MB2981.namprd15.prod.outlook.com (2603:10b6:a03:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Tue, 24 Mar
 2020 18:50:35 +0000
Received: from BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::90d6:ec75:fde:e992]) by BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::90d6:ec75:fde:e992%7]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 18:50:35 +0000
Date:   Tue, 24 Mar 2020 11:50:05 -0700
From:   Andrey Ignatov <rdna@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <osandov@fb.com>,
        <corbet@lwn.net>, <toke@redhat.com>, <brouer@redhat.com>,
        <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Document bpf_inspect drgn tool
Message-ID: <20200324185005.GA66472@rdna-mbp>
References: <20200314003916.2753148-1-rdna@fb.com>
 <9b7e4709-80c2-7509-6cfd-1a46eef5c5d6@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b7e4709-80c2-7509-6cfd-1a46eef5c5d6@iogearbox.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: MWHPR19CA0078.namprd19.prod.outlook.com
 (2603:10b6:320:1f::16) To BYAPR15MB4119.namprd15.prod.outlook.com
 (2603:10b6:a02:cd::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:400::5:8baa) by MWHPR19CA0078.namprd19.prod.outlook.com (2603:10b6:320:1f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend Transport; Tue, 24 Mar 2020 18:50:34 +0000
X-Originating-IP: [2620:10d:c090:400::5:8baa]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2fd8783-a60f-4203-9f28-08d7d0243c8e
X-MS-TrafficTypeDiagnostic: BYAPR15MB2981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB29811FC1D5EB7EFFC88FE27EA8F10@BYAPR15MB2981.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(396003)(346002)(136003)(39860400002)(366004)(6666004)(52116002)(6496006)(33656002)(16526019)(33716001)(66476007)(5660300002)(66556008)(186003)(66946007)(1076003)(53546011)(6486002)(81166006)(81156014)(6916009)(8936002)(2906002)(316002)(9686003)(478600001)(8676002)(86362001)(966005)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2981;H:BYAPR15MB4119.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OPOQeWUyRpPrsObbkcvnIZgYdh/KYFRcr8HpWJLxw8xSRlJUC8kLuRkV1l509QfGKzjG9Cl5eHouY9wB4uHdIl+OxyFXXv2VzbPlYXdOVhM+S6b5ESXXKLmneDs/9EPTL9TI9THtSVt+jtL0wSZ9E1sCabXRjT8Lad6KKHKFDCtcsAgB1NTh1YGN6Y2SoQAvWNOaFFJ8972Kdlg/QtZp9fXGXVNbMOXmL39Gys8PTWc4JZmB06umuuABDLtgDkwsNTWApgAFYBv4NxMre8bqS7LmPeECzF6v8VFSlPonZHSU0tXbD8vJ9YXNc5ArPAr/SeJQlQLdU3ZENBgfyhrhwzIu3az0/SjjMEw7c6Bi5BPT/GXjDCV9LCQcjuGcjvE7gm/B6FmPzVb5i713T7C7htUR3GaiZiXKE3ZyPfHy/MprTdp7bqe2LALKNkIIywPIq53QXRM7UfKJu3QuLB20ugPCl8l7TF5uKfdcR3hh2uC/WxNO2KBAuwo9xK99a/cKfmq5AKFWQ1iFeHSIeJPOug==
X-MS-Exchange-AntiSpam-MessageData: afW69eBZabcZu5sJLIVulh2diYwlx2CvZ1WlVuKxMH5rSQ/5eHXdL7mbUUgwUZDOvX4PphUVqbYAYNXRUMCZFr45QtWDn5jdcVEMzx3kYIbDzqdGegnlVAt8G0k7dnmNV9JSZFyeUK+wuLu7SMfdenX/tC76V+9jRGrj0Y/uBaSvKzn1bAfn/l8E/JV7oq4J
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fd8783-a60f-4203-9f28-08d7d0243c8e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 18:50:35.2322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCSpHIs2LfcBX7TLJSAVMbmCcyPcAhptUxIctudWO1IbSMmkkpzoo7ViqwvDBmVF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2981
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_07:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240093
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> [Tue, 2020-03-17 12:57 -0700]:
> Hey Andrey,

Hey Daniel,


> On 3/14/20 1:39 AM, Andrey Ignatov wrote:
> > It's a follow-up for discussion in [1].
> > 
> > drgn tool bpf_inspect.py was merged to drgn repo in [2]. Document it in
> > kernel tree to make BPF developers aware that the tool exists and can
> > help with getting BPF state unavailable via UAPI.
> > 
> > For now it's just one tool but the doc is written in a way that allows
> > to cover more tools in the future if needed.
> > 
> > Please refer to the doc itself for more details.
> > 
> > The patch was tested by `make htmldocs` and sanity-checking that
> > resulting html looks good.
> > 
> > [1]
> > https://lore.kernel.org/bpf/20200228201514.GB51456@rdna-mbp/T/#mefed65e8a98116bd5d07d09a570a3eac46724951
> > [2] https://github.com/osandov/drgn/pull/49
> > 
> > Signed-off-by: Andrey Ignatov <rdna@fb.com>
> > ---
> >   Documentation/bpf/drgn.rst  | 39 +++++++++++++++++++++++++++++++++++++
> >   Documentation/bpf/index.rst |  5 +++--
> >   2 files changed, 42 insertions(+), 2 deletions(-)
> >   create mode 100644 Documentation/bpf/drgn.rst
> > 
> > diff --git a/Documentation/bpf/drgn.rst b/Documentation/bpf/drgn.rst
> > new file mode 100644
> > index 000000000000..2ff9ef3e0b58
> > --- /dev/null
> > +++ b/Documentation/bpf/drgn.rst
> > @@ -0,0 +1,39 @@
> > +.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +
> > +==============
> > +BPF drgn tools
> > +==============
> > +
> > +drgn scripts is a convenient and easy to use mechanism to retrieve arbitrary
> > +kernel data structures. drgn is not relying on kernel UAPI to read the data.
> > +Instead it's reading directly from ``/proc/kcore`` or vmcore and pretty prints
> > +the data based on DWARF debug information from vmlinux.
> > +
> > +This document describes BPF related drgn tools.
> > +
> > +See `drgn/tools`_ for all tools available at the moment and `drgn/doc`_ for
> > +more details on drgn itself.
> > +
> > +bpf_inspect.py
> > +**************
> > +
> > +`bpf_inspect.py`_ is a tool intended to inspect BPF programs and maps. It can
> > +iterate over all programs and maps in the system and print basic information
> > +about these objects, including id, type and name.
> > +
> > +The main use-case `bpf_inspect.py`_ covers is to show BPF programs of types
> > +``BPF_PROG_TYPE_EXT`` and ``BPF_PROG_TYPE_TRACING`` attached to other BPF
> > +programs via ``freplace``/``fentry``/``fexit`` mechanisms, since there is no
> > +user-space API to get this information.
> > +
> > +Any developer can edit the tool and get any piece of ``struct bpf_prog`` or
> > +``struct bpf_map`` they're interested in, e.g. the whole ``struct
> > +bpf_prog_aux``.
> > +
> > +See ``--help`` for more details.
> 
> I do like bcc's explicit usage examples/recipes so one can immediately grok
> whether it fits to a given use-case (e.g. [0]). Given this is targeted for
> developers perhaps it makes sense to add an example usage as you have described
> in [1] to the doc as well here?
> 
> Maybe last two paragraphs are not that useful. Could we structure each tool
> we're going to add here with two sub-headers "Description", "Getting Started"
> where the former has the first two paragraphs and then the latter has a usage
> example that shows e.g. [1] or as you write in your last paragraph a modification
> to dump the whole ``struct bpf_prog_aux``, for example?


I like the idea. Will split into these two sections, add examples and
send v3.

Thanks.


> Thanks,
> Daniel
> 
>   [0] https://github.com/iovisor/bcc/blob/master/tools/bpflist_example.txt
>   [1] https://github.com/osandov/drgn/pull/49
> 
> > +.. Links
> > +.. _drgn/doc: https://urldefense.proofpoint.com/v2/url?u=https-3A__drgn.readthedocs.io_en_latest_&d=DwICaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=3jAokpHyGuCuJ834j-tttQ&m=w0lb_NHL_dnKmx1BCxQa-nVyCGAmWxQxlGS28F4ah5w&s=IbEuBhH7sEDU3POS5E-0wx_hQWbsgrbKdOynGQFDQTs&e=
> > +.. _drgn/tools: https://github.com/osandov/drgn/tree/master/tools
> > +.. _bpf_inspect.py:
> > +   https://github.com/osandov/drgn/blob/master/tools/bpf_inspect.py
> > diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
> > index 4f5410b61441..7be43c5f2dcf 100644
> > --- a/Documentation/bpf/index.rst
> > +++ b/Documentation/bpf/index.rst
> > @@ -47,12 +47,13 @@ Program types
> >      prog_flow_dissector
> > -Testing BPF
> > -===========
> > +Testing and debugging BPF
> > +=========================
> >   .. toctree::
> >      :maxdepth: 1
> > +   drgn
> >      s390
> > 
> 

-- 
Andrey Ignatov
