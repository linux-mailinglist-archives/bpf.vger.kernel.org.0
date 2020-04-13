Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CD71A6D31
	for <lists+bpf@lfdr.de>; Mon, 13 Apr 2020 22:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388344AbgDMUYq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Apr 2020 16:24:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34752 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388320AbgDMUYo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Apr 2020 16:24:44 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 03DK7tFM007884;
        Mon, 13 Apr 2020 13:24:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=3it2wqOd9LgDVrOdKYXuD1fKLthJ1d+S34f3jvqN7JQ=;
 b=g4mJ8sOiSsPVkGzxazd4ZJYvZ8wRVcFgfED9jn6JZIAaqJXZ1f3zTHvTc/BIt5YESwYW
 6O1Rix48G7O3y5HLhhIypSCZWB/1PkjFL+5L7JosXkzeCxLQRoTKqmMy+zGQCWmECvIB
 w9ODVzUwzePnrsoASz4RcikUDESfDv6sWzA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 30c9vbmquh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Apr 2020 13:24:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 13 Apr 2020 13:24:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJwuMIbmRDEq3KMb/79GtevBzWenssn80A2nGbGSpkp9b1NsypQT1i7lmdlmHiX/nau2DuNRSc+XEF18/UygcWkdsHVCAyuJl7I7vYNhPThQjbClhh0o8OsDTmLQidwXf0CJj+cUz8d7zZxRQkpY4M3prjWKx94HerSCJLU36GoICpAmeIt5l7PBc2JXiMHBiwalQTVTo13NCZXl8ui+OYU6nN4Na3PX2+ehbqIuFnzCkI3LB+CMO389PdhpwQQcW4/uMbIM8yd08SONwDZdMh8V8xLqrJvdHbI9eFkH7PtJ7maDiLt8zs6X/1OJtI/pObIWZKTMj3owSd9C+5o69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3it2wqOd9LgDVrOdKYXuD1fKLthJ1d+S34f3jvqN7JQ=;
 b=DBfSb6QgH4gDfaq3T/3gxofvBPY0tuQ/ZPHYlehvxnZzdeZYxrx+MW5Tkty17GO94N06KnK8lNigSNKntfX6c14DRCjT1672lJXJYmy4yOSSdET7V3IWdtrDF2xNlERn0m7K6ahFlijzG9beFf3Wk4kYfZqxaSMw+sQDHilG6mMGjX9V7eNv+1GEVPsxK2O050IYNXCAH/e+LIhWf2iT0h070avRGz9x/dnuZ5WFgfHaros7kZSPHEUBJ6mh4w4OT7wGd47h5qWxgnZfV0uyo/nI85cug+qMKKyuH2E6JmxsnlnS1mlaoqTZaPPYdgm1kKCHxWroFz8tstQJpbIEKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3it2wqOd9LgDVrOdKYXuD1fKLthJ1d+S34f3jvqN7JQ=;
 b=cUsiy1WhhFGmmErCnkaSjwQ/u90KWlT8MW9JQUAPpQm6n6dzOA2AfMcnNyvCUZbtLKnSv5miKJcrJyxO2DFk8HDv/LmNbI+kmShgdnAp3K1wpxKX01IzrOAtzLM5s5beoVgYtiK8YuziETdFoqMYY/FgaeEYjflwHbAPUvU01D0=
Received: from BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20)
 by BYAPR15MB2200.namprd15.prod.outlook.com (2603:10b6:a02:89::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Mon, 13 Apr
 2020 20:24:26 +0000
Received: from BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::90d6:ec75:fde:e992]) by BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::90d6:ec75:fde:e992%7]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 20:24:26 +0000
Date:   Mon, 13 Apr 2020 13:24:24 -0700
From:   Andrey Ignatov <rdna@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf 1/2] libbpf: Fix loading cgroup_skb/egress with ret
 in [2, 3]
Message-ID: <20200413202424.GB36960@rdna-mbp.dhcp.thefacebook.com>
References: <cover.1586547735.git.rdna@fb.com>
 <daa546903aa74cf844452b7f80788d67c15b42ea.1586547735.git.rdna@fb.com>
 <CAEf4BzYvPawqgdP+cU94+US=hKGaD8qCBFtnu_JZae3eJ0+SUw@mail.gmail.com>
 <20200410225739.GA95636@rdna-mbp.dhcp.thefacebook.com>
 <CAEf4BzbBiqKNu8DAqYH0+Lyv3_-nZ1PWzs42EbsC96u6zvX=sw@mail.gmail.com>
 <CAEf4BzawkZ_aekiFUmkaskzCqfZJmaZ5Oww97L4_ZZhku7A1xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzawkZ_aekiFUmkaskzCqfZJmaZ5Oww97L4_ZZhku7A1xw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: MWHPR10CA0009.namprd10.prod.outlook.com (2603:10b6:301::19)
 To BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:400::5:f8c7) by MWHPR10CA0009.namprd10.prod.outlook.com (2603:10b6:301::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Mon, 13 Apr 2020 20:24:25 +0000
X-Originating-IP: [2620:10d:c090:400::5:f8c7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08947aa3-2a7b-435a-118e-08d7dfe8a91f
X-MS-TrafficTypeDiagnostic: BYAPR15MB2200:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2200C2155F4CAF36308F40F3A8DD0@BYAPR15MB2200.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4119.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(346002)(136003)(366004)(376002)(396003)(6496006)(8676002)(966005)(4326008)(53546011)(81156014)(54906003)(52116002)(8936002)(5660300002)(9686003)(316002)(478600001)(6916009)(6486002)(33656002)(2906002)(86362001)(66556008)(66476007)(16526019)(186003)(66946007)(1076003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xoy4xvXGTe3vtVoFXTczzeDJ2tdZ94R0bqUvk4HfRMlH9bTcONFtMyzhWt11FTP4NqaQiF6B0EvhE+ySwaIvlcY24DUuD1mdI6/L4WVxTf5p/xrv65yxqprDRx5lZBRzIWDaJFFXtQKAIq1nYg86B6rXvqJHZkb3B5M3+E2fh/4LxzcVRT1fDb0ZxRqCJ8bunvg6WA30vAleASIu7SIxbxP4rYU/YKVBWNo3G5V3CspNDyDEt8WroFSVvIyzU89N3SWlV9BfnLtxb8ACLYrOzNrdvwDya/y46raAVoQc1g1RG0/55VXcKxgOPI8UgY5cGS8sPA2j3z/Rhq5ZG/5Zm4RiHC3SnYCTcYdr2F+ZCpzk7Pj6dxW1ReS3uXPW+QP9EVjJaKoUfR9piPDvz1Vyd/J0SnRwQTYjA3V7Oo6VVg/PEBmE8dxtEx7Sesp9C0e0uzFzerGd4pDYyDJN8s0wWS2287RT21DXNafVuDKmDs779m8zT+tLpgB1uIN0Ne9meabb3CDJK0YVYeOIIrp9Zw==
X-MS-Exchange-AntiSpam-MessageData: OJ+g0ynyhoDG2XdDrqb9UzcTKPrIp8hXaKAyzsVWscUfr8+UlF1sfRJjWiuswCARkg+yw29of+j7sI/IIzobOppkNzoy+utnIS4WYq1JjYTiP5xkLjpw6nQa+LQcZ3qATTZhglFWQGGE7QUZTwB5wA2VcNqVZyXNrjbrnme0Oj08EBr0TSRFGcBofiIJFaoq
X-MS-Exchange-CrossTenant-Network-Message-Id: 08947aa3-2a7b-435a-118e-08d7dfe8a91f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 20:24:26.0905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJyS9NjHXQVdvqy6eh34PUiZIyTnLOVr6nLtCEA+nDCQgJkFKteZPVipEBs+WXSs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2200
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_09:2020-04-13,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004130151
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> [Sat, 2020-04-11 23:01 -0700]:
> On Fri, Apr 10, 2020 at 5:09 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Apr 10, 2020 at 3:57 PM Andrey Ignatov <rdna@fb.com> wrote:
> > >
> > > Andrii Nakryiko <andrii.nakryiko@gmail.com> [Fri, 2020-04-10 13:39 -0700]:
> > > > On Fri, Apr 10, 2020 at 12:54 PM Andrey Ignatov <rdna@fb.com> wrote:

...

> > > > Otherwise, we can teach libbpf to retry program load without expected
> > > > attach type for cgroup_skb/egress?
> > >
> > > Looks like a lot of work compared to simply adding a new section name
> > > (or changing existing section if backward compatibility is not a concern
> > > here).
> > >
> > > But that work may work may outweigh inconvenience on user side so no
> > > strong preferences. If this is what you were going to do anyway, that
> > > may work as well.
> >
> > Usability trumps extra code in libbpf :)
> 
> [0] should fix this issue without requiring unnecessary new section
> definitions. Please take a look and let me know if that won't work for
> some reason.
> 
>   [0] https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_patch_1269400_&d=DwIBaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=3jAokpHyGuCuJ834j-tttQ&m=gwtRFCwg1r2VaTv-GpXKX0e2c-HWZADFO3Ikynunse0&s=eFectzkso2WgfqSeWStlhCk3cEKaJ0_kjcnXhJ8tAFU&e= 

Thanks Andrii. This looks like a good option to me. I left a few
comments on the implementation.

-- 
Andrey Ignatov
