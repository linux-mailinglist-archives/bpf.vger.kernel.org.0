Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213F0427494
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 02:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243818AbhJIASf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 20:18:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22292 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243995AbhJIASe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Oct 2021 20:18:34 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 198L0AAB026477;
        Fri, 8 Oct 2021 17:16:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=zjpVu3Vzxu1j1m09gYowdw0aQBZBt+1m9xTPKizjQjU=;
 b=ed3CszLQoil5274EEsxboXY2HlHETOLqrsLa6MtyYF+hG2BAeDO+PHhJ/s6CxrQvoIYC
 VtvlMyGB1mBvexMdHqcSjXoV8rKBCaaeG+D1hObXmge7JbYyi5SG7pNfGzFDH9FG7Pc5
 XquY8oBgmAxooB70cssZDi+sREt+GRh+M9w= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bjwgu917g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 08 Oct 2021 17:16:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 8 Oct 2021 17:16:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5saFm6LMbbjfbo05ufJFUmAV/70Yu+My/WuFi8O7jkkjNaN2IT6ThBIE18/JLSq/J/2tXDtdRvedmt7sCiaylORGoOmleqnIwVt+/tHKtWwUN1YbpYVQ2h3oH9HrPSEP1KjB4o7yksIKdWVaR8V3Y4gynpVVSC7FWhsjz6Wm3u0zXxYgYLRTTFpy4TM20pixWDfw7V5eC4x2gUaeh/GU4uAqGC4SCmKvDdQRzO5Ajqm3GlmgYvw/G0iZzb+9fXFVKAU01WSkLV8aJKAyaX7Eadn9e4vqZokxh2def4oC3dudHcLgptUj3F3cy7aLmKRZ8IPla8HkdXsfqQ5jsF1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjpVu3Vzxu1j1m09gYowdw0aQBZBt+1m9xTPKizjQjU=;
 b=bNDE4BYdt9KJWuxc16DW2gn0RvH7ZQaBc7AYAGJh2Wm6Z+J7lvxXrGSTiUzzTDEI2zVTuvy0lGvAt0Vpd76Exvsf416hmTKrhdKTsTHTFp9fJ3McmD1uf5hP/lQT8azSWFo1oZN8X/NLj0K8UpTDqAWtCdgfVP+5Z113oeyzJO32ZyTFg9tlGgOzA0fy2CfgVhrLb8RAbmYvlalXW1AQAWvm0pMJRS95sJJTU6+63TvUN2GlQ8e3VCEz3XmSnh7pWtKkj8UzXu0ebDrHyEdFiegOdbrac3Yx3wOGN7CKCTpMGmi8Mo1Z8wkhRf3dGTzhacOiwmJr5U7gT/GfLLQ6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: riotgames.com; dkim=none (message not signed)
 header.d=none;riotgames.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA0PR15MB3838.namprd15.prod.outlook.com (2603:10b6:806:88::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Sat, 9 Oct
 2021 00:16:35 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%8]) with mapi id 15.20.4587.024; Sat, 9 Oct 2021
 00:16:34 +0000
Date:   Fri, 8 Oct 2021 17:16:30 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Zvi Effron <zeffron@riotgames.com>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bitset map with bloom filter
 capabilities
Message-ID: <20211009001630.3xvziwfdgajqzug6@kafai-mbp>
References: <20211006222103.3631981-1-joannekoong@fb.com>
 <20211006222103.3631981-2-joannekoong@fb.com>
 <CAEf4Bzb9GJaKGSL5fgA468aUL70eJSiPvknARt-KWDViOqT7cQ@mail.gmail.com>
 <CAC1LvL3k8N_=Q0aFaGExWD_+hOO-aBwdY4N3Lwz+4OZvj6CwPw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAC1LvL3k8N_=Q0aFaGExWD_+hOO-aBwdY4N3Lwz+4OZvj6CwPw@mail.gmail.com>
X-ClientProxiedBy: MN2PR16CA0002.namprd16.prod.outlook.com
 (2603:10b6:208:134::15) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp (2620:10d:c091:480::1:f2a6) by MN2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:208:134::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Sat, 9 Oct 2021 00:16:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec4e4836-d283-4b42-b52a-08d98aba0d91
X-MS-TrafficTypeDiagnostic: SA0PR15MB3838:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB38384637C62ED4E0B2EB593AD5B39@SA0PR15MB3838.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HqbjJKoqCagcZBA2mzCaLamhwPt2FdB+PuvkBtZCC074tRet0G5+F641g00FVRrlknTmhvWJCtTSNgW9PEBzyiCqX1h+fpWmpSR55roojaDW58JOgwig1zXzlx3r0pgZ+jVXAMTHRZUtPndo+sfFx2Z5TK1PBZZoDb1HMaFL3G0ztOeNIMQJi2P64/4SNJaoTJokPKh1+fV8olFZVwbZ5pz5yn0f5LDjJcwsyR8i5UOpC0IAKHuJ3dJKv3LFZZTjcCX6rMORUQYCW0dP92VuSf8OvtD1gSAH3ieVvvQksiZdYp6BOTZCDz5/qKOYLKo06AJLx9onpPx3tEjjSTJTU023Iqbc/Qb5BCkTygE4tJM2+5iacN3/Lt+PnuAJQm4r+Ct8j9I5t5vDve8/Pk4Ud/hdl/wSwUpBePLhubf2lIBGhwwKj5R9Br+jbZBVOV45Zraq8U9mfEjTvhkNI4bGTJXpOymlqDjFwg7l0BY7+OhB+p7GCxDxqyt+oJMV/0EOn6QmUPnLrS5k5LkMe3pnnfG8razN7OPlQhwAdu2iu2yzQDenk6KR4PHVS8CVYp9lh9va9eBSetJA1iWse5sfk3DtjBsdPnHoujWNsKt6/PoXQQ7aml8+qMdlT7+6GLaaRcSnxEDZSoJGartPusaiog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(508600001)(8936002)(38100700002)(316002)(4326008)(83380400001)(54906003)(186003)(55016002)(86362001)(52116002)(53546011)(66556008)(66476007)(6916009)(1076003)(8676002)(6496006)(66946007)(33716001)(2906002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6CJvk3nHhveVJd0Fgom0adyNSDsZqyzVQakNS2w8MyGVv/V5+uUxx6USknB5?=
 =?us-ascii?Q?BZqy8eyWFWS9Nv9PfEkVOn2dh9OH8dWNpRNcOMUK3wt0x8CsxRxBYr2vnA05?=
 =?us-ascii?Q?wA3I94rPM53+MGd7ov0p/LNKSq4/JeeBQz7rWRugzCsDJIE6HnbLCCdweAh6?=
 =?us-ascii?Q?PvfQN0uFRmw1aToRuR/HqWIn4+6mLDpbvL0/8jzbsC0DoOBpFXMELxHsaJWf?=
 =?us-ascii?Q?C/jyg1JG/EbnygWCEwwDW9XMPJM/e1PXpfAB5r85CVza6wMR+ho6ZDlhDyKK?=
 =?us-ascii?Q?8/x5H0k7HVgh6ZKkQLDbCvoekkgnw2V9QLrM3W/k4QJ3OnlWROcjCg5RTqsg?=
 =?us-ascii?Q?Veq2PhPmEmxtNZzv8TDeoIwwm4cpPY2fi3+vg3gNGRueHurloWx93qg8cTrd?=
 =?us-ascii?Q?xHqdxIWgR2Z8wNHGeyXruq4qjmXzpmvpm/0JTuSU1AiGSmbRGRYhuG1//2l4?=
 =?us-ascii?Q?XQlFCNwMq/D7/RkGBKKpJdBZPb3MLLCZR0fpYg0PFtDCEZ81t9KDus8SDd+n?=
 =?us-ascii?Q?EVltR1LJVA5LQNJx0OxWnoZHfkIPkQHX2MoSiDydZzSridnbJvJI5jM5fsFs?=
 =?us-ascii?Q?JQcOgDCme45SpZXpk5AT6b+9sFt65JIaq/2+LCgnRErRQIW8H1iaRRAJUPxI?=
 =?us-ascii?Q?GmT4BMqXOBkt31iYqGm2GqpvyJv3yo9C5e5Ppn6+AvvOtFfuBRukgo/3CTAH?=
 =?us-ascii?Q?RJ7f9kKGJi1eD2NztciIVqzL1YLVXiejOiCeWaFVhMKyefyI44Zt1mCBbvLT?=
 =?us-ascii?Q?gEl6amgGogT5HtbSURIzM5y6Xh/tZSuYBl5F7wsHJ2N1ieWp7DNIRBlURvtX?=
 =?us-ascii?Q?Tyis+ntpMUTc8/x0lTxZlo/x1TjCa2UI09fJsGv/R5l8LCu/oB/G1AGkWwuN?=
 =?us-ascii?Q?vM3mtbFZAPNQ/S4qpBahyAl+Qaxgy//c6U+8V2rL3UsSh+2XBZTddI959Byi?=
 =?us-ascii?Q?RLNwlbAQXbrbeWmgVyc9wy8EyL7pyHgPAEQar4OidtOnXbwH67+iuWvqvIfY?=
 =?us-ascii?Q?fhfW5peypjDNUzjnJ1b1OU7K5nQNoRvojQi8osF6znTz2iA0S/AhF99vWwky?=
 =?us-ascii?Q?W99T5Zpgggtzn+6ZQECLioR+cDtjmgylTqZ+7SuTbkI19XfWAhs0jtETP9ES?=
 =?us-ascii?Q?NgpT68sgLzf9OcVUrblEkxoyTa2tHtB4/ft8Bj4dnc2CyiULxrd1KQhA5dVD?=
 =?us-ascii?Q?vBIrjZuv05msu+N/uK+pSdKJ+pgIAvFRGrIaqHlV9DhXPs16JwSfGU0R1TJr?=
 =?us-ascii?Q?ryUChLPp+nORgPGFOMyIL5fo3EDwy5i+KsE1LXW42V0hc5MeP7ZwmNOTS3wl?=
 =?us-ascii?Q?WozCdFzqZFK7u4s5GQi67JXT/45/DL6wNKgF9u5PDdOtWA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4e4836-d283-4b42-b52a-08d98aba0d91
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2021 00:16:34.7431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymzsQtrmqg4xzXADHl25olXMR81lQaoGeeen8kKreyYjXz9X3mBVs8Nt5pPbP/YA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3838
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 0T5jv7zp3i8iLXME7ZklGTPXDK7PA3b3
X-Proofpoint-ORIG-GUID: 0T5jv7zp3i8iLXME7ZklGTPXDK7PA3b3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-08_08,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 spamscore=0 malwarescore=0 clxscore=1011 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=931 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110090000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 08, 2021 at 04:24:58PM -0700, Zvi Effron wrote:
> On Fri, Oct 8, 2021 at 4:05 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Oct 6, 2021 at 3:27 PM Joanne Koong <joannekoong@fb.com> wrote:
> > >
> > > This patch adds the kernel-side changes for the implementation of
> > > a bitset map with bloom filter capabilities.
> > >
> > > The bitset map does not have keys, only values since it is a
> > > non-associative data type. When the bitset map is created, it must
> > > be created with a key_size of 0, and the max_entries value should be the
> > > desired size of the bitset, in number of bits.
> > >
> > > The bitset map supports peek (determining whether a bit is set in the
> > > map), push (setting a bit in the map), and pop (clearing a bit in the
> > > map) operations. These operations are exposed to userspace applications
> > > through the already existing syscalls in the following way:
> > >
> > > BPF_MAP_UPDATE_ELEM -> bpf_map_push_elem
> > > BPF_MAP_LOOKUP_ELEM -> bpf_map_peek_elem
> > > BPF_MAP_LOOKUP_AND_DELETE_ELEM -> bpf_map_pop_elem
> > >
> > > For updates, the user will pass in a NULL key and the index of the
> > > bit to set in the bitmap as the value. For lookups, the user will pass
> > > in the index of the bit to check as the value. If the bit is set, 0
> > > will be returned, else -ENOENT. For clearing the bit, the user will pass
> > > in the index of the bit to clear as the value.
> > >
> > > Since we need to pass in the index of the bit to set/clear in the bitmap
> >
> > While I can buy that Bloom filter doesn't have a key, bitset clearly
> > has and that key is bit index. Are we all sure that this marriage of
> > bit set and bloom filter is the best API design?
> >
> 
> Adding on to this, as a user of the bpf helpers, peek, push, and pop have
> meaning to me as operating on data structures for which those are well defined,
> such as stacks and queues. For bitsets, "push"ing a bit doesn't make sense to
> me as a concept, so needing to use bpf_map_push_elem to set a bit is not
> intuitive to me. bpf_map_lookup_elem, bpf_map_update_elem, and
> bpf_map_delete_elem make more sense to me (though if we have update, delete is
> redundant).
The peek, push, and pop helpers could be given a different name
like test_bit, set_bit, and clear_bit in bpf_helper_defs.h.  I think this
was also mentioned in the earlier discussion.
