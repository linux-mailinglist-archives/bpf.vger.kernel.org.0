Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4307518535C
	for <lists+bpf@lfdr.de>; Sat, 14 Mar 2020 01:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgCNAfz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Mar 2020 20:35:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61802 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727711AbgCNAfz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Mar 2020 20:35:55 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 02E0TmxH030725;
        Fri, 13 Mar 2020 17:35:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=kbfGm3iNS0UUyGGO1/Ewr+8ahYVoKR+U+f0E6ufSe1U=;
 b=BwPZEohvDuOHTTPB70DRnDcwEV635e3k7pKEcabARAOVnShT0p1sX29f2Vv95v6BfKDO
 77aMjX8ND6Sg4s1Uz2EPN6aNXVt8WkuQhqCw27PoVFXOt2BfitGDYJMWuIAThFjJJNGZ
 BCCqzoq1cdntCVczQG8qRtDcLVpcR1TkVWE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 2yqt7ef5dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 13 Mar 2020 17:35:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 13 Mar 2020 17:35:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDbQd2D3zQqqF443b18QRp0f2NTUXc7rdvoSlgk/0mV1CLp50MEgfrCihrimswBC3JjdI+HuFkkdPEzpW9ZqU1bBEaa5TqeQWeTK6okoEEggyACsXtYhJxwzhlLgbnpCDKcHGJuOcugUTIBSVBJ21XdY1gKlkhXSTyvBLabQEY+9EjaPDjQQa7l3Odfv8WUOYF641CAahauBMr9Dj0OO98pxTCmCkbLGwWos+TXJdwL3dQok78x+21C181Yo86DYnTOrgaqRa+jyqRC73PnR8reVKTXlXzxHj3RiGqmdIbxnITJTTx704e/uycYs98QFy9Fo03AuLXy4emFtav1tyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbfGm3iNS0UUyGGO1/Ewr+8ahYVoKR+U+f0E6ufSe1U=;
 b=hnqpGhlyENv9R/bPADPmp5Jy6w3vBkPpVQ9FGAVqZwNjfuV/9vAa+k3G6a0aA+HZfl+xzJ4OSV7wmfN3vwguVjhlYhelB5QSu3PxCZ2eiSG9uDxbNtugDNuHf68JwK/4NXbNaaY1yFPMtE03LhiPp2rBlX7fDxHAHmu9NX6sFh7Najk2WwgIgvOdIj4difDj0kthQmu9q0wJzSAlEO+9/92HvDVzpnm/O4ljTGegFK8G3XrBhLG3KKCGtmFeWyfqpx0piKI018NxxBXZxu9eoPgxj9zV7w23sQs7XKkJ5encKzGJZuy6gYevnSsvwfLX58Al8Iet0S8Zj6o5HBav7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbfGm3iNS0UUyGGO1/Ewr+8ahYVoKR+U+f0E6ufSe1U=;
 b=AmhHuwoNIbWFrI0XfOA0vCrt8D+/UPD/Z9xYaPF5+Ih37eWrSOPllBdjHlI5aouQ83On6GmiGsv7GpVQxbY5EBzW2azm9TVR73uXUqzcL+OfStlcG2jnPPFb5L06FeD+N0yZKPs6iibUOXO+inTnWjBKFAsYD91cmwjPZbFltCc=
Received: from MWHPR15MB1294.namprd15.prod.outlook.com (2603:10b6:320:25::22)
 by MWHPR15MB1872.namprd15.prod.outlook.com (2603:10b6:301:5a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Sat, 14 Mar
 2020 00:35:38 +0000
Received: from MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::9c8d:a541:3706:1718]) by MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::9c8d:a541:3706:1718%8]) with mapi id 15.20.2814.018; Sat, 14 Mar 2020
 00:35:38 +0000
Date:   Fri, 13 Mar 2020 17:35:35 -0700
From:   Andrey Ignatov <rdna@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <osandov@fb.com>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] bpf: Document bpf_inspect drgn tool
Message-ID: <20200314003535.GA99215@rdna-mbp.dhcp.thefacebook.com>
References: <20200311191440.3988361-1-rdna@fb.com>
 <20200313012648.4sttadqm7g52gldw@ast-mbp>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200313012648.4sttadqm7g52gldw@ast-mbp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: MWHPR21CA0041.namprd21.prod.outlook.com
 (2603:10b6:300:129::27) To MWHPR15MB1294.namprd15.prod.outlook.com
 (2603:10b6:320:25::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:400::5:858e) by MWHPR21CA0041.namprd21.prod.outlook.com (2603:10b6:300:129::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.5 via Frontend Transport; Sat, 14 Mar 2020 00:35:37 +0000
X-Originating-IP: [2620:10d:c090:400::5:858e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f561da62-2c18-49a0-450b-08d7c7af9dd3
X-MS-TrafficTypeDiagnostic: MWHPR15MB1872:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB1872101622C275D0CE3EFE69A8FB0@MWHPR15MB1872.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 034215E98F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10001)(10019020)(396003)(136003)(366004)(376002)(346002)(39860400002)(199004)(66476007)(66946007)(186003)(16526019)(8676002)(81156014)(316002)(86362001)(81166006)(66556008)(8936002)(9686003)(478600001)(52116002)(966005)(5660300002)(2906002)(33656002)(6496006)(6916009)(1076003)(6486002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1872;H:MWHPR15MB1294.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a5fDm0Lkzq8rR696UuYZ0dqvYOjRst+fkiGJYvWHsj7/fAO9GVfVieCydzKQCyiMcQUG1+Cbx/H98OOT2bxyia1DtX5C7Y8sjjZC3/Lz/bI37xzfkR8c6zoMjfa0y70+fSOKK7ER3IynnOuXMdl3LHFGPW+uB/+9D6u1VzM4LiG3PFg5n1OTCHMoTBzUV3MYyIHxwMe6N4gpB5oMTuO0YNb6VGp83TPSi3jMan7rcjYjEoQAej/Rp/MopqfoWLsDJYG02IgZZKuVRJ1cngh+22yQnETekX7S/o1qxG6O9NaDev9VCauipLvf7m76UE/0aiACIX/nt8Ls3TnoSrbhFjTucbWZZSNHSsqMHbeC4aLJkF94s6ZVZ4Wf64Do1fqXslPX8tsDfBcsSGzdrURJJpLxYIdO1bOup7GWL3FR4oCpuKWxQRPhIqNk2z097EZMdGY48CRBkMv70VKutyr7bdyZrbfqqGuGlb4U1S52ihyu1JCxW7LLDmp81S6+l50v0p4cB/7Q5yRPJM97Bsk3T90Er//8bsmok1duP/ltNN9j8kk/PIIxjnLViZJka1k+nECMmUUmi/rTirkf1lpDqARI2uVR3XFyNB1cAvdsdemEevAwmCtCmQ0PdO2HgS83
X-MS-Exchange-AntiSpam-MessageData: N9qI3T9vjG3OqPK2FTK4t8+5m6kywxm06X0RbVFHMPAI5AhLYtVSsVSLcmZP/7Dhw65bJuVb+QE9iLOhBDCVQdKNyy8tS2O/bWN9uECqZx/XMMVTbgubDRtY2dZYo6B9dlHtYdvDkVDb3MJqEDLgakAv7Llf+D+UXgMJvDDCQNtfCilQqOdkMJQrtYQaLEhL
X-MS-Exchange-CrossTenant-Network-Message-Id: f561da62-2c18-49a0-450b-08d7c7af9dd3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2020 00:35:38.3344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCWMog8/9fcdklC3mh456nCnPY4ThuGt6HfBo/2Dgw3c+3FrJhEkgs4mCGN6T04+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1872
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-13_12:2020-03-12,2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003140000
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> [Thu, 2020-03-12 18:27 -0700]:
> On Wed, Mar 11, 2020 at 12:14:40PM -0700, Andrey Ignatov wrote:
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
> >  Documentation/bpf/drgn.rst  | 42 +++++++++++++++++++++++++++++++++++++
> >  Documentation/bpf/index.rst |  5 +++--
> >  2 files changed, 45 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/bpf/drgn.rst
> 
> Location looks good, but I gotta nit pick on wording...

Thanks for review. Both comments below make sense. I'll send v2.


> > diff --git a/Documentation/bpf/drgn.rst b/Documentation/bpf/drgn.rst
> > new file mode 100644
> > index 000000000000..9a9ad75ab066
> > --- /dev/null
> > +++ b/Documentation/bpf/drgn.rst
> > @@ -0,0 +1,42 @@
> > +.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +
> > +==============
> > +BPF drgn tools
> > +==============
> > +
> > +drgn scripts are great to debug kernel internals including BPF and get
> > +information unavailable via conventional kernel UAPI.
> > +
> > +If there is a piece of kernel state useful for a small number of users, e.g.
> > +only for BPF developers, or too expensive to expose to user space, drgn script
> > +can be a good option to still have access to that state but without extending
> > +UAPI.
> 
> Above two paragraphs are true for any piece of kernel data.
> I think they're unnecessary focusing attention on bpf.
> May be rephrase the whole thing like:
> "
> drgn scripts is a convenient and easy to use mechanism to retrieve arbitrary
> kernel data structures. drgn is not relying on kernel UAPI to read the data.
> Instead it's reading directly from /proc/kcore or vmcore and pretty prints the
> data based on dwarf debug information from vmlinux.
> "
> 
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
> > +But developer can edit the tool and get any piece of ``struct bpf_prog`` or
> 
> Just drop 'but' and say 'Any developer can edit ...'
> 
> > +``struct bpf_map`` they're interested in, e.g. the whole ``struct
> > +bpf_prog_aux``.
> > +

-- 
Andrey Ignatov
