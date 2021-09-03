Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312553FF880
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 02:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242358AbhICA5S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 20:57:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55388 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231161AbhICA5S (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 2 Sep 2021 20:57:18 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 1830kbWf025464;
        Thu, 2 Sep 2021 17:56:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=dC5hIDCOFrTR5OQVcxGO1STLH9dYuJgZ3rdh24g/DFI=;
 b=LJ0zuulVc1uulmqpPmYYQgwX8KscT3C3Clu736Gz7xegNzBHNAhoWzVen6120MM6pd9E
 CNKzsVXT8ZtsApAbyesRk3W4T08H+iKJ1rHxgpMToaeJQtR1hzeSGrbtHdGcgkvU6XYE
 IYItEzLUa6vSmUdrCpBADNxqID1U9wwq5hE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3atdyhjc27-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 02 Sep 2021 17:56:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 2 Sep 2021 17:56:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+xKZ1Wj3y21wxZ94TRkjsMG9cJ4D8iEU3k/yKw26dP+HsQ9+7S0F95AUOfwOGO5Se/bJeYYhaV6rqMKAs6sdF03gHZwn2MIC2SU5MHYxlnVQtTf15KCIQ1MQ4C5HLgipENCaB8eHCvbtAXPjy6vsHi6gTiQyB44YQh+uIbBdjBsQi5l+EcpeLlQzv0tt8THT16EPsfhiHGODnz9kjZPfk+K9D8iRXzdogfAqGk4+9mtaxvWw/SR+p26kUuaOFsnHmWIJBKP67VwbXyD6jDDsFRTjtiKVwy2Bmy1G4ajne8n0hSfD897vcmjOu0ehLQHKvCDcbm9/roiR5zgYKmr7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dC5hIDCOFrTR5OQVcxGO1STLH9dYuJgZ3rdh24g/DFI=;
 b=XcqXTWe3x9o5BpMw7q+KDpi0MuVRDp5UiHF3KvMVRrMMuPfEVuGTlY5Rm2bLOG/Zh4D/5zEEqGVQsI4lFKb7MBcOSwjmWQ/OWgzUOnWTa1kyN3S8F9ds+1y8pxRiAjNsbd3xHOADep+wWvADArVSM40MRCRjst0l/BIq2eR+/E+rsu9kusMWOxTJjRfhiOQw1gc8s2unlvo4x4irjHWPw7TciEVJXJz133IH4LmZZZ+MyhKS5QNO/Urfw3yXn2oLDwtMyvfzV+hpWsq3ESvrqfnadTlq89Bt98TNyLWR5eaB/apw4Hfs8aic8vcO1tIY1Z0UKklck8akN6wDHzxNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CO1PR15MB5017.namprd15.prod.outlook.com (2603:10b6:303:e8::19)
 by MW3PR15MB3836.namprd15.prod.outlook.com (2603:10b6:303:45::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Fri, 3 Sep
 2021 00:56:16 +0000
Received: from CO1PR15MB5017.namprd15.prod.outlook.com
 ([fe80::8951:d1eb:665:8807]) by CO1PR15MB5017.namprd15.prod.outlook.com
 ([fe80::8951:d1eb:665:8807%6]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 00:56:16 +0000
Date:   Thu, 2 Sep 2021 17:56:11 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannekoong@fb.com>
CC:     John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add bloom filter map implementation
Message-ID: <20210903005611.pnkvybwsc5uxddyx@kafai-mbp.dhcp.thefacebook.com>
References: <20210831225005.2762202-1-joannekoong@fb.com>
 <20210831225005.2762202-2-joannekoong@fb.com>
 <CAEf4Bza_y6497cWE5H04gDg__RkoMovkFYSqXjo-yFG7XH11ug@mail.gmail.com>
 <61305cf822fa_439b208a5@john-XPS-13-9370.notmuch>
 <0c1bb5a6-4ef5-77b4-cd10-aea0060d5349@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0c1bb5a6-4ef5-77b4-cd10-aea0060d5349@fb.com>
X-ClientProxiedBy: BLAPR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:208:32d::14) To CO1PR15MB5017.namprd15.prod.outlook.com
 (2603:10b6:303:e8::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c091:480::1:4739) by BLAPR03CA0039.namprd03.prod.outlook.com (2603:10b6:208:32d::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20 via Frontend Transport; Fri, 3 Sep 2021 00:56:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28a69a98-6f66-44a4-aa8e-08d96e75a1fc
X-MS-TrafficTypeDiagnostic: MW3PR15MB3836:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR15MB38362FD6D6B456B6DE317EACD5CF9@MW3PR15MB3836.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4iEaw8b2swg85aBWLu7w6YDbwYw0LZW07P8IJCOqeu/iwoBnRwQ+92S2htdKUIW4QEnC+4MnMwT2iTc//gtjDF5P04bvYFrKZg+XcXTwYDaayfVxBqWkEFfVYD/zFkdz2fDapZKwijCfM6cN0xCq9Adj0VfT8mVlbv04OFSiIirCoxiw74TcQjWigfTy0egLCjZeLBs/o70jaYB3xtgvLBL7nN3ycPnGfafX/lPt1XaFyWvLKGPlCba3gNpLd+a9vANsZosIyVIgzOoSY4pltG9l27Jt/jcl08Y3bNpm+vNYR6m+MbLuawhAMKlZ90jzTdQ15vSWOrBDkCv6XOEly6XuyAEqJeKldTpMPTVhTQMFp+yjKIHCmFaD/i5BEwS50ZpPBq48dLqrtm5U+a7Tvm3AD8I5xuS+48D2oRG4WgkQyKLkuUd0IW2yrTjplgkrymPvZ3zVGxAxwTwB+QADSAJf0/9n6qpOtdHg9gqJ6YAXDUbdz3FVH4oSsIqElqWrstge6Ju60e+PEDZclIp6bBxz865GiPbtUuXfve+USiUgnPiGPEf/n8FoVN2OWe5xpArcUbxvR7KBQP8fJJgMWr6Q/0zsUCewZseBQknWOuKzmabZaELx4UgVDV4sygQi6O1e1GOYYaSnqGJFgcP4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR15MB5017.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(54906003)(66946007)(52116002)(66556008)(6666004)(6862004)(7696005)(66476007)(9686003)(55016002)(316002)(2906002)(83380400001)(6506007)(478600001)(8936002)(4326008)(5660300002)(6636002)(8676002)(86362001)(1076003)(38100700002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?71DF/pzxPj8b66jtfVG7yOnu2wY0J8w3O88UkTdkU7gbslnS1QkRAJC7afwF?=
 =?us-ascii?Q?Ka3k0W/mb/oYXEpvbaoKdbElFNVIZrIHsxhnJemizekecQw7fydkRyAwn0Wi?=
 =?us-ascii?Q?JnyqtQIhf7HYF4m9gyFFJtKEApyWfOcSriATjTPVNdzu3swiHKuX3IT+0Pik?=
 =?us-ascii?Q?LRSU7mqOC+StbXKAk+knjwvs28UjiVMDOB/b+QDae3qrXHDNswYP3Z/7fRvy?=
 =?us-ascii?Q?LpkkrovJ4L4ZUqek3qs4fFb9lqKoHEvnk6E1EzCaf+E/SkPfHpnPMoR6Uh03?=
 =?us-ascii?Q?IVrP+tECXKh28VU0TXA4M6AUuVjEbdDyOf/Mx+aSWaacUeKqo2zr99shBwe/?=
 =?us-ascii?Q?GdTEwvzYfSqRJ/fe4J94GSR/WPBaoXD6/gDYlpSbw08h518YELeac71vT8Ug?=
 =?us-ascii?Q?uHSA+X+p35sea4uP6U5ZjqNx8PeJA5HJati3jlFis3ZPWBRBU6yU+IDnNfOl?=
 =?us-ascii?Q?RIpSSeRbsuF4IDF0q0WT7c16hm1ed4JND5Ln+kYYR2Pcsjwfr62c6PMsUaF6?=
 =?us-ascii?Q?f8+uXJGUnuztw5QU3AyjcCEolCvnmrYfKY690e6RI9RaJmXBa61NKv9VlmP3?=
 =?us-ascii?Q?vpJsnJVySjg2oRcYf8Bro5iK0NbxAZeu74pGgKZqbTGOTk6iNDc1iR+sUc3p?=
 =?us-ascii?Q?HEZhlNlgx3ThzY8ovG3O6C8GkKubXaHoooj2s9IN1KOPfN/aXfY5e/27HGcp?=
 =?us-ascii?Q?EFF7dMW6B+dNrIwVRtRNQMN2wMdo9uQNI0suxTqSl5HM5kly5cKjJ/UO5ZuV?=
 =?us-ascii?Q?zOUfqtPY3UwEXbh2xpeovneXLqLzyDv6YmmCBRT5UNSY5RS02YaoII5n4hPE?=
 =?us-ascii?Q?cuM5v237W1V2L8y/k3pr7mvlIbwk1QNxahAD/rKct9nd+l8HBhUmu8DSWFZf?=
 =?us-ascii?Q?ncIJxlLTh7Pzo2xGZKgDxj1Pw7YRdT34Wnwld4c8ZODZUNjgcg+S+zthHhvJ?=
 =?us-ascii?Q?Ytd4fv02f3AmzQbdwMdDkhHXZbcLgTAKunSc/gJJmPe184ca37VwY/F+y5+8?=
 =?us-ascii?Q?ZWOcm2lx1NDcNgA7woit5FwMIt9krYnGykqJfzMkNBNoLW9cH2amLBO4a9xa?=
 =?us-ascii?Q?pQdE+E1r+86tE6ShDfjP+sGRG6piCHp8qrH+OxHNZo6OwxA20u09TBGwK4Os?=
 =?us-ascii?Q?raMuSVA/eoCQL3doSuL2DqcNSzHceUEAyA61VnPudVLv2JOTJ8/OB9LHpG06?=
 =?us-ascii?Q?Vy0dDducar7HSAyFWycC+4MzGYZTRp3yQPfxDZuwkoJTc/W6A4Bx8unjSrY2?=
 =?us-ascii?Q?mh4FpPxztBHaRvHZnxNHMhFEm8tCd3M8Xm9LZDApxatiu4XQ5LgPtMm/FJAO?=
 =?us-ascii?Q?LC2m14yReZlnppfwkmCgOUJ+/ZeDkCKXGk8feJhV+zPzEccJVZSDcPXPMeZ2?=
 =?us-ascii?Q?u3SiplI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a69a98-6f66-44a4-aa8e-08d96e75a1fc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR15MB5017.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 00:56:15.9586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GBsPdFjeT5ZTHZQO9ai2pXu+T5WufKpdZfAlfT8OBb+a55aSU13RQFNgAnJ2Czs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3836
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: rE91B5ze5U0ftADYlHp2Ubl0UCg89DRO
X-Proofpoint-ORIG-GUID: rE91B5ze5U0ftADYlHp2Ubl0UCg89DRO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-02_04:2021-09-02,2021-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030003
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 02, 2021 at 03:07:56PM -0700, Joanne Koong wrote:
[ ... ]
> > > But one high-level point I wanted to discuss was that bloom filter
> > > logic is actually simple enough to be implementable by pure BPF
> > > program logic. The only problematic part is generic hashing of a piece
> > > of memory. Regardless of implementing bloom filter as kernel-provided
> > > BPF map or implementing it with custom BPF program logic, having BPF
> > > helper for hashing a piece of memory seems extremely useful and very
> > > generic. I can't recall if we ever discussed adding such helpers, but
> > > maybe we should?
> > Aha started typing the same thing :)
> > 
> > Adding generic hash helper has been on my todo list and close to the top
> > now. The use case is hashing data from skb payloads and such from kprobe
> > and sockmap side. I'm happy to work on it as soon as possible if no one
> > else picks it up.
> > 
> > > It would be a really interesting experiment to implement the same
> > > logic in pure BPF logic and run it as another benchmark, along the
> > > Bloom filter map. BPF has both spinlock and atomic operation, so we
> > > can compare and contrast. We only miss hashing BPF helper.
> > 
> > I've find small seemingly unrelated changes cause the complexity limit
> > to explode. Usually we can work around it with code to get pruning
> > points and such, but its a bit ugly. Perhaps this means we need
> > to dive into details of why the complexity explodes, but I've not
> > got to it yet. The todo list is long.
> > 
> > > Being able to do this in pure BPF code has a bunch of advantages.
> > > Depending on specific application, users can decide to:
> > >    - speed up the operation by ditching spinlock or atomic operation,
> > > if the logic allows to lose some bit updates;
> > >    - decide on optimal size, which might not be a power of 2, depending
> > > on memory vs CPU trade of in any particular case;
> > >    - it's also possible to implement a more general Counting Bloom
> > > filter, all without modifying the kernel.
> > Also it means no call and if you build it on top of an array
> > map of size 1 its just a load. Could this be a performance win for
> > example a Bloom filter in XDP for DDOS? Maybe. Not sure if the program
> > would be complex enough a call might be in the noise. I don't know.
> > 
> > > We could go further, and start implementing other simple data
> > > structures relying on hashing, like HyperLogLog. And all with no
> > > kernel modifications. Map-in-map is no issue as well, because there is
> > > a choice of using either fixed global data arrays for maximum
> > > performance, or using BPF_MAP_TYPE_ARRAY maps that can go inside
> > > map-in-map.
> > We've been doing most of our array maps as single entry arrays
> > at this point and just calculating offsets directly in BPF. Same
> > for some simple hashing algorithms.
> > 
> > > Basically, regardless of having this map in the kernel or not, let's
> > > have a "universal" hashing function as a BPF helper as well.
> > > Thoughts?
> > I like it, but not the bloom filter expert here.
> 
> Ooh, I like your idea of comparing the performance of the bloom filter with
> a kernel-provided BPF map vs. custom BPF program logic using a
> hash helper, especially if a BPF hash helper is something useful that
> we want to add to the codebase in and of itself!
I think a hash helper will be useful in general but could it be a
separate experiment to try using it to implement some bpf maps (probably
a mix of an easy one and a little harder one) ?
