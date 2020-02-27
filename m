Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44DF617253C
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2020 18:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbgB0RiX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Feb 2020 12:38:23 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55230 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729232AbgB0RiX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Feb 2020 12:38:23 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RHTQFO020747;
        Thu, 27 Feb 2020 09:38:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=KRM3ppYKwM09/Vd/ZjPWrLK3E7C8OZUjhf77Tho9wro=;
 b=g+TUitG9U19cPIPg6eZYaQbraLlcz2c/uK0HZcta96ME8ZZ1XwfRLl2TywbUUu37rlF6
 y0zcnD0W83dOVc55vEuVdHCbJfPgeD+i5/dnRwkcOvUStv7wPyMktulP9kEEJWp/pCwG
 MKgw+jWHAvMfCS57YmxT1Sbu5W74/t/50Xg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yegvk0j4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 27 Feb 2020 09:38:09 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 27 Feb 2020 09:38:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTek9a/pgEGeAti4B2ze+SAKnH/VW4hoqO9uFIY584HBNEANbNlY1w3WSW7g1Qc1yUbCwhdVfcV11O3w6seeb4gdDmbTTfNkqzcWHLwbobZiCX2f9GOK8BdKv/Dx/jH9XUZVqIIvM8T5Z5N20LmizqlQVw8f0s0+37WIFONatthStw25sfigrsngHyadRlZ5NDznbc///BbM58LDiNd2jQCWFqsD/5/LfrPKe+znRC1fT8WfL9OuRQXtBKnEUB9fo5qzQeKVUSPCDDrnDuiTMB+ZMwGOZabqxGwe9nVhFV2VRJI0kJNC8pFmsJlXvF6StPOijuKa9ZzDdjsTnp/mgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRM3ppYKwM09/Vd/ZjPWrLK3E7C8OZUjhf77Tho9wro=;
 b=i2c8x5DmTWFy9nnXSiLyxAPbU2KVH4k37hWVg21JyPNEABkMGM6JMA1ZvTqRF9Cb0iNqUvRRyfSjLzNVmDQ1Vi9b6dM0HH+7zFpp4XwMH+8PS7F9WtjZJ7XBRjnDAaw8dHjCmU1zYFm4R/k5WLRd5hBpJc8RmSMwJzy75taikKugOMgFVMIzlaca2cZOYlz95RRbAYEdlsCLMD5CWAR30uCRS6/IgFuz0Id+230UZtNkVrRWNRBGslrBmFpKXNuyedJv5aBDdwK6G6ta1ZSKzd6QE2Yndw8f/U/gKyKSqhRjsgaAkT73wUXTXts8VANhGl8qjlCp5O0tuwph9epkyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRM3ppYKwM09/Vd/ZjPWrLK3E7C8OZUjhf77Tho9wro=;
 b=iAq6RN+4MiWs1zbHqKTqKpe2edZIzpsCCMyEozv9lR33KOcJA2hT9h+R89EqgtqL2mcPUnlYmNyrrAQ0AUOQih9fybj4isrjpRuHyILcu6Aq+VhRxFvce0a4cSVkjb4rJK3cgK0SDCP1REalWVZD9+NaZaNGP/uCfoq5BzHHXkk=
Received: from MWHPR15MB1294.namprd15.prod.outlook.com (2603:10b6:320:25::22)
 by MWHPR15MB1565.namprd15.prod.outlook.com (2603:10b6:300:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Thu, 27 Feb
 2020 17:38:06 +0000
Received: from MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::b47a:a4d2:b9dd:eb1e]) by MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::b47a:a4d2:b9dd:eb1e%5]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 17:38:06 +0000
Date:   Thu, 27 Feb 2020 09:38:04 -0800
From:   Andrey Ignatov <rdna@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <osandov@fb.com>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] bpf: Add drgn script to list progs/maps
Message-ID: <20200227173804.GB29488@rdna-mbp>
References: <20200227023253.3445221-1-rdna@fb.com>
 <CAEf4BzZo7rmZejxJCT-s3OSiYqMxzP71Q9Xg+x=WFN00Yca0Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzZo7rmZejxJCT-s3OSiYqMxzP71Q9Xg+x=WFN00Yca0Sw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: CO2PR04CA0169.namprd04.prod.outlook.com
 (2603:10b6:104:4::23) To MWHPR15MB1294.namprd15.prod.outlook.com
 (2603:10b6:320:25::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:500::6:b3e7) by CO2PR04CA0169.namprd04.prod.outlook.com (2603:10b6:104:4::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 17:38:05 +0000
X-Originating-IP: [2620:10d:c090:500::6:b3e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8eb4128-7128-42eb-6bd5-08d7bbabcd60
X-MS-TrafficTypeDiagnostic: MWHPR15MB1565:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB1565F1707D0EAB59C757EB11A8EB0@MWHPR15MB1565.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:326;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10001)(10019020)(7916004)(396003)(346002)(376002)(366004)(39860400002)(136003)(189003)(199004)(81156014)(6496006)(8936002)(52116002)(33716001)(33656002)(81166006)(316002)(4326008)(9686003)(5660300002)(6916009)(8676002)(6486002)(66946007)(54906003)(66556008)(66476007)(478600001)(966005)(1076003)(2906002)(186003)(86362001)(53546011)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1565;H:MWHPR15MB1294.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rss0cz0Deaor1u7OFzoqUhIRCknMT+QimoV3Y/aiHpRQeJdxF0PTm5cgiNJM5IvQjxpFJ64rNDGJ8VKX1e2apSZ1daFDPcd2JsBpswePR9UAo+VtSKYTTL8lkpBCTlp7tLYgjsgnj0Jtgrmi2sp/uq8tCSytrzPfpRGQn9fgIhzREwhnBsvPHbJT11ve6NDIQ48+BmTpTZoSMFPWQX3031BgWUa6r61PwZLymHNBJcB8a4BF+JMAS6jaxS5HELn3Ei17BobHSNQJVpToIteQpUhk9rMDWf0S1aJ58rY2Yvp6M+BQ8fSxBgN7TSdaN6MlPN4OuyV8zPthtQjkim/+i9nJ8a7nOpHYY4FEWzyU9k7jQr+jwP5FKz7K7ohGeLB4gh5oynnoQfeBpGOM4aPuektj6VIfaVm2vs8DpqQIjy6883EcUmH4toLMIwxQ4QSBbAHJeMpMIC53HAI9vDTTbCSha3T9L2oIqEG8Hxs3NMiOdETPwkAOtzXHHEEiHdA3CIihU7fjkDehzfWwczmzAMOYAXD2W5g89sB7C7PKPlwIQv0ODUWnkwFDav/lgvgnviQMrweylEgLWTIfUeb1wkyctuXt012n0yBgdaBp2hXCbHFD4kDfVCwLZiPQMaJS
X-MS-Exchange-AntiSpam-MessageData: F+O+iPivmcgqnJ4vAEt3ZuMA7h/JttSzFbnad9djYl4H7GJHfa0ZbI9OmRyOfVka9kJcREV0XgQc28VBLnMx+sO+0/hJC63TLgAODkmGCwFt5X2rPnlEtyZnICFpcWzLucABwx2ezdvVjMzZDeIbnPpLro6sDoxKf4hqfv4GgF7DwXBQmCRg556E7SixwBar
X-MS-Exchange-CrossTenant-Network-Message-Id: c8eb4128-7128-42eb-6bd5-08d7bbabcd60
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 17:38:05.9902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71e4u+6d56tSkaJ7/fARK60LpDxR1Pk59X4+i+ZHAg1YxvdenbaFIJuzNOmMWTCJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1565
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_05:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=989 malwarescore=0 impostorscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002270128
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> [Wed, 2020-02-26 22:28 -0800]:
> On Wed, Feb 26, 2020 at 6:33 PM Andrey Ignatov <rdna@fb.com> wrote:
> >
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
> > Example:
> >
> >   % sudo tools/bpf/bpf.py p | grep test_pkt_access
> >      650: BPF_PROG_TYPE_SCHED_CLS          test_pkt_access
> >      654: BPF_PROG_TYPE_TRACING            test_main                        linked:[650->25: BPF_TRAMP_FEXIT test_pkt_access->test_pkt_access()]
> >      655: BPF_PROG_TYPE_TRACING            test_subprog1                    linked:[650->29: BPF_TRAMP_FEXIT test_pkt_access->test_pkt_access_subprog1()]
> >      656: BPF_PROG_TYPE_TRACING            test_subprog2                    linked:[650->31: BPF_TRAMP_FEXIT test_pkt_access->test_pkt_access_subprog2()]
> >      657: BPF_PROG_TYPE_TRACING            test_subprog3                    linked:[650->21: BPF_TRAMP_FEXIT test_pkt_access->test_pkt_access_subprog3()]
> >      658: BPF_PROG_TYPE_EXT                new_get_skb_len                  linked:[650->16: BPF_TRAMP_REPLACE test_pkt_access->get_skb_len()]
> >      659: BPF_PROG_TYPE_EXT                new_get_skb_ifindex              linked:[650->23: BPF_TRAMP_REPLACE test_pkt_access->get_skb_ifindex()]
> >      660: BPF_PROG_TYPE_EXT                new_get_constant                 linked:[650->19: BPF_TRAMP_REPLACE test_pkt_access->get_constant()]
> >
> > It can be seen that there is a program test_pkt_access, id 650 and there
> > are multiple other tracing and ext programs attached to functions in
> > test_pkt_access.
> >
> > For example the line:
> >
> >      658: BPF_PROG_TYPE_EXT                new_get_skb_len                  linked:[650->16: BPF_TRAMP_REPLACE test_pkt_access->get_skb_len()]
> >
> > means that BPF program new_get_skb_len, id 658, type BPF_PROG_TYPE_EXT
> > replaces (BPF_TRAMP_REPLACE) function get_skb_len() that has BTF id 16
> > in BPF program test_pkt_access, prog id 650.
> >
> > Just very simple output is supported now but it can be extended in the
> > future if needed.
> >
> > The script is extendable and currently implements two subcommands:
> > * prog (alias: p) to list all BPF programs;
> > * map (alias: m) to list all BPF maps;
> >
> > Developer can simply tweak the script to print interesting pieces of programs
> > or maps.
> >
> > The name bpf.py is not super authentic. I'm open to better options.
> 
> Just to throw another name into consideration: bpf_inspect.py?

bpf_inspect.py is good as well. That's probably better than bpfshow.py
since "inspect" better describes the goal of the script.

I'll use this name unless someone proposes a better one.


> > The script can be sent to drgn repo where it's easier to maintain its
> > "drgn-ness", but in kernel tree it should be easier to maintain BPF
> > functionality itself what can be more important in this case.
> 
> Unless it's regularly exercised as part of selftests, it will still break, IMO.

Yep, it may break especially since it relies on kernel internals. At
the same time I'm not sure it's worth spending time on selftest for the
script _now_:

* I don't know how useful the script will be for folks in general, if it
  turns out to be useful, I can follow up with a test later.

* It will bring drgn dependency into the tests that will need to be
  figured out separately (e.g. it can be optional but in this case the
  test will be skipped most of the time).

But we can come back to it in the future.

> > The script depends on drgn revision [4] where BPF helpers were added.
> >
> > More examples of output:
> >
> >   % sudo tools/bpf/bpf.py p | shuf -n 3
> >       81: BPF_PROG_TYPE_CGROUP_SOCK_ADDR   tw_ipt_bind
> >       94: BPF_PROG_TYPE_CGROUP_SOCK_ADDR   tw_ipt_bind
> >       43: BPF_PROG_TYPE_KPROBE             kprobe__tcp_reno_cong_avoid
> >
> >   % sudo tools/bpf/bpf.py m | shuf -n 3
> >      213: BPF_MAP_TYPE_HASH                errors
> >       30: BPF_MAP_TYPE_ARRAY               sslwall_setting
> >       41: BPF_MAP_TYPE_LRU_HASH            flow_to_snd
> >
> > Help:
> >
> >   % sudo tools/bpf/bpf.py
> >   usage: bpf.py [-h] {prog,p,map,m} ...
> >
> >   drgn script to list BPF programs or maps and their properties
> >   unavailable via kernel API.
> >
> >   See https://github.com/osandov/drgn/ for more details on drgn.
> >
> >   optional arguments:
> >     -h, --help      show this help message and exit
> >
> >   subcommands:
> >     {prog,p,map,m}
> >       prog (p)      list BPF programs
> >       map (m)       list BPF maps
> >
> > [1] https://github.com/osandov/drgn/
> > [2] https://urldefense.proofpoint.com/v2/url?u=https-3A__drgn.readthedocs.io_en_latest_index.html&d=DwIBaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=3jAokpHyGuCuJ834j-tttQ&m=-2VO-M__tHrQ5sFnwPDqT5b28akZ_J1zEqXg9uejcL8&s=HlNywgEgwjqMVZo67TSoHZtynK-CsqLnbh7cYLH5znI&e= 
> > [3] https://urldefense.proofpoint.com/v2/url?u=https-3A__lwn.net_Articles_789641_&d=DwIBaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=3jAokpHyGuCuJ834j-tttQ&m=-2VO-M__tHrQ5sFnwPDqT5b28akZ_J1zEqXg9uejcL8&s=uZSwKs3POR6r0nammsbhxvPur0RXFMa9w2cAnjq4Q_A&e= 
> > [4] https://github.com/osandov/drgn/commit/c8ef841768032e36581d45648e42fc2a5489d8f2
> >
> > Signed-off-by: Andrey Ignatov <rdna@fb.com>
> > ---
> >  tools/bpf/bpf.py | 149 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 149 insertions(+)
> >  create mode 100755 tools/bpf/bpf.py
> >
> 
> [...]

-- 
Andrey Ignatov
