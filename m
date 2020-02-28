Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8A3B1740C8
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2020 21:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgB1UPc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Feb 2020 15:15:32 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8366 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726490AbgB1UPc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 28 Feb 2020 15:15:32 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01SKEiQM000359;
        Fri, 28 Feb 2020 12:15:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=6ae6M3+4+lFoMMjFwOjOGHLFBtstKRnrISUkbMVZUO0=;
 b=OdQkkjIuOrWJJoAo7TwksiKCw6uRB4cNEfdFfXnaoWfR/wFIXOhjBU2hFyIL5GrWtu/Z
 x9NmmgqOOkD1foLmUd7/H+mlSXs5uSaL0pkeDjPujWO09n/RWg1Hg41vtFuJ0XuxwgJx
 Ms9VVm+O0URpT1c4Z2nu8QXcYhUuGcLBbZo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yepv6n7yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 28 Feb 2020 12:15:18 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 28 Feb 2020 12:15:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNog6YvKS7bNrSZHg1CgvWnjrG232G7Jqo2EB7Kv32DiPxC1s1o/akZlkxhGOFuGKkFAOa+ORGylz7AE0LFtBH4wNJLPYP6mieLpHUlCpGkAXfunxHr3Rk7F2y33HWI6dZSz+PW+eCRDXSTCENNTeiIYGCMXbgVMsgnPVRo/fJWmY5NmzSqVKxZCR0AxezsnsHXWN5+bTM19Yn+v2X/O0I+ZejfbcR5f9GWm//VFpb+lWL8HBaM2+me6QoHCQs6y26GRv4DDb5NY5yt3SkRWi7/2oZqJR2X0PgOOINAfmF8IHimaWA63oEWEF8BO5A/OUdNn/0GTEac3OfTmc/rGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ae6M3+4+lFoMMjFwOjOGHLFBtstKRnrISUkbMVZUO0=;
 b=VIbXmTnl14BSTE6OF1XHuZ88cMtAHBoggFjSElAIdppPOGXCprS9PrXEUeFIDHR2bh+zAM9j5Cxf0cLrvnjU/CfCvm6flGwGnmwonWxSY9Vu9xG8N4zD5RYcKuJyHBgSWdtdibPLjCEh/ghYZVhCSzu6Eau2GDvlmcPt5z9FqJHwoPh8Aeg1grqD8ZuNcy82MDzTNMrKUtodWbJE3VuYq79GyRjwyn8+Ahlg7v94IfTbzSt1dsMbE07rzsOxsipF07hLwTpAz4KA5cBIa5EfK531Hyet/dcJ28b/DsU58OhJhTZ9+HqVBWghHV+tqfG6c+85k/2W38hONkAe4GvqsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ae6M3+4+lFoMMjFwOjOGHLFBtstKRnrISUkbMVZUO0=;
 b=UgMoZTdmmH9BV3knxjf/lBj6RALmvRpx0wIpnSD/3dcSYjCWotugQzhc9ISqDj6U2S3atajlO5NaHLQgZQwlVaNZSBkJESxH562UAu78gSavThC8Dh45VIG43Vco2M9nILqEEo4eUvDYm37lvKA64MmPw1PlQsKiB0777KsQVYU=
Received: from MWHPR15MB1294.namprd15.prod.outlook.com (2603:10b6:320:25::22)
 by MWHPR15MB1216.namprd15.prod.outlook.com (2603:10b6:320:22::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 28 Feb
 2020 20:15:16 +0000
Received: from MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::b47a:a4d2:b9dd:eb1e]) by MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::b47a:a4d2:b9dd:eb1e%5]) with mapi id 15.20.2750.021; Fri, 28 Feb 2020
 20:15:16 +0000
Date:   Fri, 28 Feb 2020 12:15:14 -0800
From:   Andrey Ignatov <rdna@fb.com>
To:     Quentin Monnet <quentin@isovalent.com>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <osandov@fb.com>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] bpf: Add drgn script to list progs/maps
Message-ID: <20200228201514.GB51456@rdna-mbp>
References: <20200227023253.3445221-1-rdna@fb.com>
 <42af50cc-acde-d7a9-19da-8e2fb87bce48@isovalent.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42af50cc-acde-d7a9-19da-8e2fb87bce48@isovalent.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: CO2PR04CA0152.namprd04.prod.outlook.com (2603:10b6:104::30)
 To MWHPR15MB1294.namprd15.prod.outlook.com (2603:10b6:320:25::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:500::6:b9bd) by CO2PR04CA0152.namprd04.prod.outlook.com (2603:10b6:104::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend Transport; Fri, 28 Feb 2020 20:15:15 +0000
X-Originating-IP: [2620:10d:c090:500::6:b9bd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bd0ac3b-d781-40ee-51dc-08d7bc8aec7c
X-MS-TrafficTypeDiagnostic: MWHPR15MB1216:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB1216B3EBD77261AFCBF24630A8E80@MWHPR15MB1216.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10001)(10019020)(7916004)(366004)(136003)(396003)(376002)(346002)(39860400002)(189003)(199004)(6486002)(6496006)(52116002)(316002)(1076003)(81156014)(66556008)(81166006)(66476007)(8936002)(66946007)(478600001)(16526019)(4326008)(33656002)(33716001)(8676002)(2906002)(9686003)(86362001)(6916009)(966005)(5660300002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1216;H:MWHPR15MB1294.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UdA2S2GlqeyQmuhHoUcRp6JR3ERRu9zxvtVw6V3+eyvcQBCks2WEaSx6N4xcgXvzXWZSKjvKTAVCde9NLs8TJYlfxQnKaddK7EKBMRxBKwV4rzjL6gs1HiCeMz7/JWNhBueKF0NrD9fU9EaN7lRgtECgz5x1+iQr7pylFCQKFnUrABrbEu7SLG5Co53aeB25jhHTyI8dHNoNy33J9o0n2rMqOLkuKXAbCp6nqKkW9U+E8IkhpSZhTdgGgbusv+jViPz9WOJ3eDGFiYI9S1KX2A5DtRVx+o/WquShx6l9CS5aF7UQ4rzcVwxTQtmR+3ZtSdccu+xfO5UbZkA7+2Id2iK6AmjSnkpty8cx7AvsAWJAJyOW339SQR94JwUBAtsPklL/yvrE7dn3cnhs1aP9SQv+cvDuiz7KYGNR47W1xXRbpVpqSvHp7t/S5i/itPucJGgF7mS3EyPcKsz5VUB2gfLxD/0hUokaz199w+pfUYLnBSKYMdIGmwtvGqEFprRKQrt5sTM7TpESvYtm4Sv2OObrNqRfEv/FKmsX2uvXygA198bV8ct9ii3oj+p31OXqRyyTRqZ4QZuHEJ1O3uVg4SJ078FZIhWWoa83J7xvDOy/nLvWrjunu2NNV+jZ/AiB
X-MS-Exchange-AntiSpam-MessageData: tMO/DghSBDYOu3+3fSYNbIGo3HamHSH4B/TVdMfnKOn9YAp3qpU5Ofu6l3YIzjMR66TVWZwxIoOy+B4khnEs7fonBSSjw0xcYyPttHlqVQw0tqWYQNWgHo8piHhY00eSdKhyjR4hOG2hCl5YFrdq46czyG+tTFiNPFU4TiO6oQCD1aou/+4Q4f+PMCzwBP/I
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd0ac3b-d781-40ee-51dc-08d7bc8aec7c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 20:15:16.0111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZNa25ueFUBz/M6wXgRuiRYqI21YfI5IBJs/1eaKmxv6U95pCbK45Uou4KYAMv/k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1216
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-28_07:2020-02-28,2020-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002280141
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Quentin Monnet <quentin@isovalent.com> [Fri, 2020-02-28 04:51 -0800]:
> 2020-02-26 18:32 UTC-0800 ~ Andrey Ignatov <rdna@fb.com>
> > drgn is a debugger that reads kernel memory and uses DWARF to get types
> > and symbols. See [1], [2] and [3] for more details on drgn.
> > 
> > Since drgn operates on kernel memory it has access to kernel internals
> > that user space doesn't. It allows to get extended info about various
> > kernel data structures.
> > 
> > Introduce bpf.py drgn script to list BPF programs and maps and their
> > properties unavailable to user space via kernel API.
> > 
> > The main use-case bpf.py covers is to show BPF programs attached to
> > other BPF programs via freplace/fentry/fexit mechanisms introduced
> > recently. There is no user-space API to get this info and e.g. bpftool
> > can only show all BPF programs but can't show if program A replaces a
> > function in program B.
> > 
> 
> [...]
> 
> > 
> > Signed-off-by: Andrey Ignatov <rdna@fb.com>
> > ---
> >   tools/bpf/bpf.py | 149 +++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 149 insertions(+)
> >   create mode 100755 tools/bpf/bpf.py
> > 
> > diff --git a/tools/bpf/bpf.py b/tools/bpf/bpf.py
> > new file mode 100755
> > index 000000000000..a00d112c0486
> > --- /dev/null
> > +++ b/tools/bpf/bpf.py
> > @@ -0,0 +1,149 @@
> > +#!/usr/bin/env drgn
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +#
> > +# Copyright (c) 2020 Facebook
> > +
> > +DESCRIPTION = """
> > +drgn script to list BPF programs or maps and their properties
> > +unavailable via kernel API.
> > +
> > +See https://github.com/osandov/drgn/ for more details on drgn.
> > +"""
> > +
> > +import argparse
> > +import sys
> > +
> > +from drgn.helpers import enum_type_to_class
> > +from drgn.helpers.linux import (
> > +    bpf_map_for_each,
> > +    bpf_prog_for_each,
> > +    hlist_for_each_entry,
> > +)
> > +
> > +
> > +BpfMapType = enum_type_to_class(prog.type("enum bpf_map_type"), "BpfMapType")
> > +BpfProgType = enum_type_to_class(prog.type("enum bpf_prog_type"), "BpfProgType")
> > +BpfProgTrampType = enum_type_to_class(
> > +    prog.type("enum bpf_tramp_prog_type"), "BpfProgTrampType"
> > +)
> > +BpfAttachType = enum_type_to_class(
> > +    prog.type("enum bpf_attach_type"), "BpfAttachType"
> > +)
> 
> Hi Andrey, the script looks neat, thanks for this work!
> 
> I tried to run it on my system. Because my kernel is 5.3 and does not have
> "enum bpf_tramp_prog_type", the script crashes on the above assignments. But
> even without that enum, it could be possible to print program and map ids
> and types (even if we don't show the trampolines).
> 
> Do you think it would be worth adding error handling on that block,
> something like:
> 
>     try:
>         BpfMapType = ...
>         BpfProgType = ...
>         BpfProgTrampType = ...
>         BpfAttachType = ...
>     except LookupError as e:
>         print(e) # Possibly add a hint as kernel being too old?
> 
> I understand that printing the BPF extensions is the main interest of the
> script, I'm just thinking it would be nice to use it / tweak it even if not
> on the latest kernel. What do you think?

Hi Quentin,

Thanks for feedback. That's a nice usability improvement indeed.

I'll add something like this and tag you on the github PR (since we're
coming to the conclusion that drgn repo is a better place for it).

> > +
> > +
> > +def get_btf_name(btf, btf_id):
> > +    type_ = btf.types[btf_id]
> > +    if type_.name_off < btf.hdr.str_len:
> > +        return btf.strings[type_.name_off].address_of_().string_().decode()
> > +    return ""
> > +
> > +
> > +def get_prog_btf_name(bpf_prog):
> > +    aux = bpf_prog.aux
> > +    if aux.btf:
> > +        # func_info[0] points to BPF program function itself.
> > +        return get_btf_name(aux.btf, aux.func_info[0].type_id)
> > +    return ""
> > +
> > +
> > +def get_prog_name(bpf_prog):
> > +    return get_prog_btf_name(bpf_prog) or bpf_prog.aux.name.string_().decode()
> > +
> > +
> > +def attach_type_to_tramp(attach_type):
> > +    at = BpfAttachType(attach_type)
> > +
> > +    if at == BpfAttachType.BPF_TRACE_FENTRY:
> > +        return BpfProgTrampType.BPF_TRAMP_FENTRY
> > +
> > +    if at == BpfAttachType.BPF_TRACE_FEXIT:
> > +        return BpfProgTrampType.BPF_TRAMP_FEXIT
> > +
> > +    return BpfProgTrampType.BPF_TRAMP_REPLACE
> > +
> > +
> > +def get_linked_func(bpf_prog):
> > +    kind = attach_type_to_tramp(bpf_prog.expected_attach_type)
> > +
> > +    linked_prog = bpf_prog.aux.linked_prog
> > +    linked_btf_id = bpf_prog.aux.attach_btf_id
> > +
> > +    linked_prog_id = linked_prog.aux.id.value_()
> > +    linked_name = "{}->{}()".format(
> > +        get_prog_name(linked_prog),
> > +        get_btf_name(linked_prog.aux.btf, linked_btf_id),
> > +    )
> > +
> > +    return "{}->{}: {} {}".format(
> > +        linked_prog_id, linked_btf_id.value_(), kind.name, linked_name
> > +    )
> > +
> > +
> > +def get_tramp_progs(bpf_prog):
> > +    tr = bpf_prog.aux.trampoline
> > +    if not tr:
> > +        return
> 
> Same observation here, I solved it with
> 
>     try:
>         tr = bpf_prog.aux.trampoline
>         if not tr:
>             return
>     except AttributeError as e:
>         print(e)
>         return

Yep, sounds good.  Will address in v2 on github as well. Thanks!


-- 
Andrey Ignatov
