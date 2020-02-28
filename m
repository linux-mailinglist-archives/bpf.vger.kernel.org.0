Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 398DE174179
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2020 22:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgB1Vaa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Feb 2020 16:30:30 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21986 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbgB1Vaa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 28 Feb 2020 16:30:30 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01SLUFZA021569;
        Fri, 28 Feb 2020 13:30:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=wON3dAfKP/MJRbqD2a4eJvPZD0sFN0VntIlruxVaS3M=;
 b=J7DNagP0KwgWIDoi9e0eC1d6DfnaubqLTyDETHqu75+2g8u/QZKUqLUD6Ul+bthZMcsV
 hD5x9HYIdrYZhIZeeZhpAWC6B8lMcHGHF/gCgkCstzcetfA7WQRWQYgZk8ts8ZdA6csh
 pEGWyu6CONYOkDfYNSKrwimIhy68t8Vcly8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yepu8wnde-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 28 Feb 2020 13:30:16 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 28 Feb 2020 13:30:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VE7CDSGwEOEEVUgBzBD6wpmbJqiap38CEud2nI6fQqiEmgvKTuqaapBWSZPdC8ePUSn6rlXA4HjnQ17P9Yd6h+H1wA9r188Ge9ZrGXlGlHa7ZsYNOTZWcmwzim+AywVf+Iaja9mexJya3R7L2xOmioRfqM4hmSWR00IcxYkQc9fkjbiB/Kjrb9GU4h/8cdixaxGlz9Tx1MlpdVv1LlgqPkg9CLrs/5Zw2VtmgJTTIDxL7P7fezMkVeQJNUBfcWq1NVTvpzoSTFXmMplXtB4sjQSzQB/x3OqomR2KOQYcU+FozgcjsKUwPb/fc5+KY03OheJIo8BXZFrVkJpsU4xTmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wON3dAfKP/MJRbqD2a4eJvPZD0sFN0VntIlruxVaS3M=;
 b=IYeSb7kZ8VqY84vlo0Ty1bENdcEhq8v6Mh5iWlrCyM1b7FJjmdIgD8mL9tdKpAI3/88VT96Hc4p49Eg9FEGGP3X55KNHKKkyYM+rqJdQyz/HhOhykhs5OKcer77z5MM9glNzk9/OVl9+qshxp14pBIr77Cue2dsT0y57Bg0GTk0swIW71r4mgtA+NWUKcJgJHb9MRyaCstdLm/HsWb/I0GQCl1FLASQiQjh2oUNZNfQNCQzLwvIT9ZinA98rasm6HraxuLfb/uJtD42vDG7BUt3MLSHLYqGozH2WD9I1oG9bAaC6GsrnNzNtdgStzbHIzT/ppIS+CDIgQxd9EibH0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wON3dAfKP/MJRbqD2a4eJvPZD0sFN0VntIlruxVaS3M=;
 b=MVQ7yJGztQEkb316qTItQYpTir6aiqf9V8puuaeTXmE6/CUTqbF/x4xP7gMuXBJDb0YM1uUc0rnWWCFs7+k6AIkrrPYzZRS7nB6ZdzlmzQdEPFkcYAf/O8dlHFjqdTOxQB0HcXnw5nWx/Uii7+Q0NdDy0ac1gn7rPbKX/ANguRg=
Received: from MWHPR15MB1294.namprd15.prod.outlook.com (2603:10b6:320:25::22)
 by MWHPR15MB1630.namprd15.prod.outlook.com (2603:10b6:300:11b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Fri, 28 Feb
 2020 21:30:01 +0000
Received: from MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::b47a:a4d2:b9dd:eb1e]) by MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::b47a:a4d2:b9dd:eb1e%5]) with mapi id 15.20.2750.021; Fri, 28 Feb 2020
 21:30:01 +0000
Date:   Fri, 28 Feb 2020 13:29:59 -0800
From:   Andrey Ignatov <rdna@fb.com>
To:     Omar Sandoval <osandov@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     Stanislav Fomichev <sdf@fomichev.me>, <ast@kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>, <tj@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Add drgn script to list progs/maps
Message-ID: <20200228212959.GD51456@rdna-mbp>
References: <20200227023253.3445221-1-rdna@fb.com>
 <20200227180102.GA188741@mini-arch.hsd1.ca.comcast.net>
 <20200227182653.GC29488@rdna-mbp>
 <8cbe6219-004c-e4f0-5f1e-5270c326f21b@iogearbox.net>
 <24d4115d-d36b-91fe-cad9-ce7fbb5d714a@iogearbox.net>
 <7d2e2356-e0c1-4a31-d820-c07317b5746c@fb.com>
 <20200228201104.GA51456@rdna-mbp>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200228201104.GA51456@rdna-mbp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: MWHPR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:301:4c::12) To MWHPR15MB1294.namprd15.prod.outlook.com
 (2603:10b6:320:25::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:500::5:5d39) by MWHPR15CA0050.namprd15.prod.outlook.com (2603:10b6:301:4c::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend Transport; Fri, 28 Feb 2020 21:30:00 +0000
X-Originating-IP: [2620:10d:c090:500::5:5d39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f1c827d-0641-4edf-f5fc-08d7bc955de7
X-MS-TrafficTypeDiagnostic: MWHPR15MB1630:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB16302A3127AF8D56F8CA37A1A8E80@MWHPR15MB1630.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10001)(10019020)(7916004)(346002)(396003)(39850400004)(376002)(366004)(136003)(199004)(189003)(66556008)(66476007)(316002)(81166006)(81156014)(8676002)(9686003)(66946007)(186003)(1076003)(33716001)(86362001)(16526019)(4326008)(6496006)(5660300002)(33656002)(52116002)(966005)(53546011)(6486002)(110136005)(2906002)(478600001)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1630;H:MWHPR15MB1294.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Z30sAOddB65dvoxxilbfBtIL0ZtF6lqcTQjyaNQ3QD1AioHlN6RZgg44wt370sAaXVwepGUSxJxEi6DkWEoyb6fZ1l3qXXETi+7mR6LfUgEnlzoE7NrT9DXActBbDAcTjy7DLfGbEXuoG1+Vt2eB7/sImOBRN5RzujmtZ6KMXft7Y1d85pGKQdzAe/JP2AZ0hynVvL7rQ0mf9ZRUUakUa58kEhFc4S4qP7ZaX9rJIiVFZcAT123lasXnaIBTSo2ZYCDzohmRu+ciE8hjJJ4npbLV8qC3RAKIzIz7dMO/xN5poadKFNJXbgFudXQpnY2cJTlsGg3mYLLWSX52Zomppb511M67SVSJKYC1+GIq8kycDRzPGXy3nLO8AFPEDOJgmcBKbvDDcTilGn8tmpycB9yKghMgCefhFenTqdxHH+IWB1g2fyM4OX1sHrVU85RjglyMWrSNt0AUT0uUGIziGFktvOdEC18vcbsruwdANvMpSR5a6licHUblw+G5UlrEYf8hoUZqjW2FYEikQWx1ZGH6f/IR/5HpfO02ggyw5ffwkvGpApxtTWJzJmP8/SoHFjNXS0KCQlHlAOPoyqbGMNVAiRm8BJtiilVHiAizeqers53PqNiWlCk2ov1xjv4
X-MS-Exchange-AntiSpam-MessageData: lVe4If94TGtlZhfOPhPe2vfwvpLZRpoTQGDpxGZhksS56rAloKoIJR/o7S1zcBj+trAJkfzpCGrYrxxGd3waMVxWYf2J6roMxrvjhLvuUHsEmRHWmLp03beUN6cQTILBcFMHhdMzSt/RRdkQClECXtrSDKVdg8M+jqnf6TfZjRWgouopppB/yghjzQGhyzpW
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1c827d-0641-4edf-f5fc-08d7bc955de7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 21:30:01.1514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ywOYCrSNLeI+bcMB53qY39eogWbfd1CK6BS/Xpxv3ZUkDLTqwqV57zrVM4iJ6u2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1630
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-28_08:2020-02-28,2020-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002280152
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrey Ignatov <rdna@fb.com> [Fri, 2020-02-28 12:11 -0800]:
> Omar Sandoval <osandov@fb.com> [Thu, 2020-02-27 14:19 -0800]:
> > On 2/27/20 1:32 PM, Daniel Borkmann wrote:
> > > On 2/27/20 10:11 PM, Daniel Borkmann wrote:
> > >> [ +tj ]
> > >>
> > >> On 2/27/20 7:26 PM, Andrey Ignatov wrote:
> > >>> Stanislav Fomichev <sdf@fomichev.me> [Thu, 2020-02-27 10:01 -0800]:
> > >>>> On 02/26, Andrey Ignatov wrote:

[...]

> > >>>
> > >>> In this specifc case I'd love to see feedback from Omar and BPF
> > >>> maintainers.
> > >>
> > >> I can certainly see both sides given that drgn tools have been added to
> > >> tools/cgroup/ already. I presume if so, then these could live in tools/drgn/
> > >> which would also make it more clear what is needed to run as dependency
> > >> plus there should be be a proper high-level readme to document what developers
> > >> need to run in order to run them. But from looking at [1], I can also see that
> > >> those scripts would depend on new helpers being added/updated/deleted, so it
> > >> might be easier to add drgn/tools/ directory where scripts could be updated
> > >> in one go with updates to drgn helpers. Either way, I think it would be nice
> > >> to add documentation somewhere for getting people started.
> > > 
> > > One example that should definitely be avoided is 9ea37e24d4a9 ("iocost: Fix
> > > iocost_monitor.py due to helper type mismatch") due to both living in separate
> > > places. A third option to think about (if this is to be adapted by more subsystems)
> > > could be to have all the kernel-specific helpers from drgn/helpers/linux under
> > > tools/drgn/helpers/ in the kernel tree and the tools living under
> > > tools/drgn/<subsys>/ e.g. tools/drgn/bpf/.
> > > 
> > >>> [1] https://github.com/osandov/drgn/tree/master/drgn/helpers/linux
> > >>> [2] https://github.com/osandov/drgn/tree/master/examples/linux
> > > 
> > I can think of a few benefits of having this tool (and others like it)
> > in the drgn repository:
> > 
> > * Easier to keep in sync with new helpers/API changes
> > * More examples in one centralized place for people building new tools
> > * Potential to identify pain points in the API and possible new helpers
> > 
> > I think this would benefit the drgn project as a whole.
> > 
> > The downsides:
> > 
> > * More maintenance for me
> > * Tools will have to support multiple kernel versions (as opposed to
> >   only supporting the kernel that they shipped with)
> > * Less visibility for kernel developers
> > 
> > That second point is true of the helpers bundled with drgn anyways, so I
> > don't think it's a big deal. The third point will improve over time as
> > we get more people on the drgn train :)
> > 
> > I may come to regret the first point, but I think the upsides are worth
> > it. Andrey, feel free to submit a PR adding this to the drgn repository
> > under a new top-level tools/ directory.
> 
> Daniel, Omar, thanks for your input. This all makes sense and it seems
> we're coming to an agreement that it'll be easier to support tools like
> this in drgn repo. That works for me and with this in mind I see the
> followig way forward:
> 
> - I'll submit PR to drgn repo to create a new tools/ directory and place
>   the script there using the bpf_inspect.py name suggested by Andrii.
>   This way the script will be in sync with all the recent changes to 
>   drgn helpers;
> 
> - As soon as PR is merged I'll add documentation to kernel tree to make
>   folks aware that such a tool exists, if there are any recommendation
>   where to add the documentation to I'd appreciate it.
> 
> - I'll try to make the script less dependent on kernel version
>   (Quentin's feedba) since it'll exist separate from the kernel
>   sources.
> 
> 
> Hope it works for everyone, please lmk if it doesn't for some reason of
> if I missed something. Thanks.

For anyone following: https://github.com/osandov/drgn/pull/49

-- 
Andrey Ignatov
