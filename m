Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFFF228CFE
	for <lists+bpf@lfdr.de>; Wed, 22 Jul 2020 02:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgGVAJz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jul 2020 20:09:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37674 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726587AbgGVAJy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Jul 2020 20:09:54 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 06M01CRd014707;
        Tue, 21 Jul 2020 17:09:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Mx4QPkZ68wmo5sh8xwpxQ8jG0v3xhM8wofXfq1Naq68=;
 b=ANkVDjYo+GBqbqVzRfq0OniJzZzeBqLmTRboQqA1GImVQGdZ8COqew0yC4FKLDhjXcop
 E3ZXhudd5XBuAuK/VMLsFtP90zDozhSLePVTgQ7B7eNsiMC78QFvvW4qeTVyh4E1tXCs
 OkhUUSvrX+8520bZC/IKnddd5DY41Rah2WA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 32bvk06vcf-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Jul 2020 17:09:38 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 21 Jul 2020 17:09:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bjsngj4E4q+92kl4+lw49bpkkhKJyuttp/uhWFqAecKpZ4XvvBwCuKaYJb7+DlA1agHay2J3StmQb5FS0zAKN0O0SEAL7BMqy9OjWaBBqav30/rSDW+36iKXVkrlFwHMuE4ADGdXq20H4CgXc7QmDbLG3uXFsLEVyuLBoQgm67tXCRzBcCAh/J67BgJ1UVVOgT9lSKihxIgo4t85uQpDdpJmG3cKlSNhTF55POSvcVO5ng1xQnUC+HheItdefTdybcT/8XaRKgKgyPbRZVf3ppS/etW7VFcrL2tCpr7fUPrlwLIXbbmX9y6evm9XxJyMRmdRskJPrBckKFFCq/P6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mx4QPkZ68wmo5sh8xwpxQ8jG0v3xhM8wofXfq1Naq68=;
 b=Y03mxIFyyeEaU8r0Xb/GQMcVuHQ/3CE1ItaoXmN6pZkPpVgPfv3OgiUCg1FjwoFIy4rqwpNfoo12zC93b8PdxudsTlyKovh3m0RhS2Z5Y0p1+tahBuLyGAhpST2PGJs6PkLWNORIU5AmZYAZeggIXVfF+sj1kLbp6b1soHkJCt6JasZTUV4tHORPIY14wbCceYhcn/tbivzE+4nMJ10xX/4nSTkGML/k6BkMsl++dGETDaWe4KHgdEktXFu7UZzz6zFZevBb2ziM0RsHKrixsS6TezlMYtinPYN/pu71Rq6ARxiZIMcLS0WsgtnvHwdCVYm0VufdUZ7zM7JyWZ1CBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mx4QPkZ68wmo5sh8xwpxQ8jG0v3xhM8wofXfq1Naq68=;
 b=YbV1qkduu8wst1pA2NDfnFXqjsPpp/s661dHSmWIttLR825oIjzSafyZrfcUXXV1hnWoFm22l53dF6d7F9sCABO36m0rAHaYWzTuVAbNvFkxXKXFmrISXnC8IbL7YtZU89wINz8yYdRBiPPMyNbPzVWNS99pglTm7EwlH6JR6NE=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3511.namprd15.prod.outlook.com (2603:10b6:a03:10e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 22 Jul
 2020 00:09:15 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3174.030; Wed, 22 Jul 2020
 00:09:15 +0000
Date:   Tue, 21 Jul 2020 17:09:13 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     <sdf@google.com>
CC:     YiFei Zhu <zhuyifei@google.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/5] bpf: Make cgroup storages shared across
 attaches on the same cgroup
Message-ID: <20200722000913.roxrdgomdgvy7ho4@kafai-mbp>
References: <cover.1595274799.git.zhuyifei@google.com>
 <f56279652110face35e35f2d4182da371cfe937c.1595274799.git.zhuyifei@google.com>
 <20200721180536.57kbngehupi4hqra@kafai-mbp>
 <CAA-VZPm9fgNKMHX1rbOEcUJ17=S5qS=rkYcBiqzcsOxCSSKuGg@mail.gmail.com>
 <20200721224158.ylrgjjljlighny4f@kafai-mbp>
 <20200721225636.GB184844@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721225636.GB184844@google.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20)
 To BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:b838) by BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend Transport; Wed, 22 Jul 2020 00:09:15 +0000
X-Originating-IP: [2620:10d:c090:400::5:b838]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5223e8ec-e320-43c6-90b9-08d82dd3786b
X-MS-TrafficTypeDiagnostic: BYAPR15MB3511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB351138EFB1668D1BFDE64DF8D5790@BYAPR15MB3511.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 67h+SdZAbigLQ9vSTeIi9jQFD0bEWFTYkEVTBTz7U686HLEk+NrbF1llN3Iqwt9LzXWBQgJwfq6uFwITHUo+WYFwelCk1HIJErXOHGqPCBlhDTOeAW8U9Sqbdfdst3Us1jUIZsIE8cyKcl4CjtVOfHSSQErCmYMSCrloLM/w705E6LkbiEl2Y4Nd1DmXtDCxH+pdrnj0Rc2MvGs5AYze6WwvfXBmIJ06nBHrGrXmLJXDcWs2Br0uw6b8p0/t0hluxfbaJc4CJE6z04PtSbB2DZAWr8/xzrpY8NG++5tb8H7RZnfsOFCr9mhbqgxiCiFdW8fIamJPgUiua0UZevRgvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(136003)(376002)(366004)(396003)(83380400001)(186003)(8936002)(66476007)(66556008)(53546011)(52116002)(316002)(6496006)(8676002)(54906003)(478600001)(4326008)(66946007)(16526019)(1076003)(5660300002)(9686003)(55016002)(33716001)(6916009)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: sfizt5DOA257/A7W9p96pRlwPUsrq6WxEJmzjRp6chCUTMcPjdh4nKzc/hPp98imq1bTLdCL3ojBHY18j1JI1ZgxBq4VgI9TmKDORq33Qrhaa9KdJd5th1XpQYI1CVVA6BPQW9W/RqQryqXyxyDK3qlkxYns9z8ZBFv5svxDUqrkm7WDQrPAVEsopykoFPWOeoVAkL6NTnBsX6E4LLm4tlkUfqDSRY9KLZBHvzb0EFQ9krP0SRcgv9CMl0G1LII7/0C9cToAoHrinL808fqZ973ONrfRJWs4P+toe9vNZ8y0AqATJsA/eGtdhU4mUbsPpRjGW8YyX/CsG4Ki9Id4pv3vEI1IXs15q9O5ehQ0Wha1x2GpKYXHSOrGRt/ERhqSxX+LOdvVxfQn6Qqsfa9sJ2wawGlfjn4CPB190iNM+dl+NcTIjTa3KwP2Zo95B+RSXCf/+i/uzXmKZOrT+zwQA/n8LtSZY/XgiGwcZLorRSveSHXg7OZmGZDJQLCrrCHJeI/5H3WJhIfgFZi7j+e4Mg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5223e8ec-e320-43c6-90b9-08d82dd3786b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 00:09:15.7548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfguHPQzXxGKCC7s72rnkmLSARNMZrYvXpAW1DwY5mLz2Yw3zOw66mhxAVU+M2BU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3511
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_15:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=1
 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210152
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 21, 2020 at 03:56:36PM -0700, sdf@google.com wrote:
> On 07/21, Martin KaFai Lau wrote:
> > On Tue, Jul 21, 2020 at 04:20:00PM -0500, YiFei Zhu wrote:
> > > On Tue, Jul 21, 2020 at 1:05 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > > I quickly checked zero is actually BPF_CGROUP_INET_INGRESS instead
> > > > of UNSPEC for attach_type.  It will be confusing on the syscall
> > > > side. e.g. map dumping with key.attach_type == BPF_CGROUP_INET_INGRESS
> > > > while the only cgroup program is actually attaching to
> > BPF_CGROUP_INET_EGRESS.
> > > >
> > > > I don't have a clean way out for this.  Adding a non-zero UNSPEC
> > > > to "enum bpf_attach_type" seems wrong also.
> > > > One possible way out is to allow the bpf_cgroup_storage_map
> > > > to have a smaller key size (i.e. allow both sizeof(cgroup_inode_id)
> > > > and the existing sizeof(struct bpf_cgroup_storage_key).  That
> > > > will completely remove attach_type from the picture if the user
> > > > specified to use sizeof(cgroup_inode_id) as the key_size.
> > > > If sizeof(struct bpf_cgroup_storage_key) is specified, the attach_type
> > > > is still used in cmp().
> > > >
> > > > The bpf_cgroup_storage_key_cmp() need to do cmp accordingly.
> > > > Same changes is needed to lookup_elem, delete_elem, check_btf,
> > map_alloc...etc.
> > >
> > > ACK. Considering that the cgroup_inode_id is the first field of struct
> > > bpf_cgroup_storage_key, I can probably just use this fact and directly
> > > use the user-provided map key (after it's copied to kernel space) and
> > > cast the pointer to a __u64 - or are there any architectures where the
> > > first field is not at offset zero? If this is done then we can change
> > > all the kernel internal APIs to use __u64 cgroup_inode_id, ignoring
> > > the existence of the struct aside from the map creation (size checking
> > > and BTF checking).
> > Just to be clear.  The problem is the userspace is expecting
> > the whole key (cgroup_id, attach_type) to be meaningful and
> > we cannot stop supporting this existing key type now.
> To step back a bit. I think in the commit message we mentioned that
> attach_type is essentially (mostly) meaningless right now.
> If I want to share cgroup storage between BPF_CGROUP_INET_INGRESS and
> BPF_CGROUP_INET_EGRESS, the verifier will refuse to load those programs.
> So doing lookup with different attach_type for the same storage
> shouldn't really happen.
I think we are talking about the existing map->aux check in
bpf_cgroup_storage_assign()?  Right, the map is dedicated for
only one bpf prog which usually has only one expected_attach_type.
Thus, the attach_type of the key is not really useful since it will
always be the same.  However,  it does not mean the exposed
attach_type (of the key) is meaningless or the value is invalid.
The exposed value is valid.

I am trying to say attach_type is still part of the key
and exposed to userspace (e.g. in map dump) but it is sort of
invalid after this change because I am not sure what that "0"
means now.

Also, as part of the key, it is intuitive for user to think the storage is
unique per (cgroup, attach_type).  This uniqueness is always true now because
of the map->aux logic and guaranteed by the verifier.  With this patch, this
"key" intuition is gone where the kernel quietly ignore the attach_type.

> 
> Except. There is one use-case where it does make sense. If you take
> the same loaded program and attach it to both ingress and egress, each
> one will get a separate storage copy. And only in this case
> attach_type really has any meaning.
>
> But since more and more attach types started to require
> expected_attach_type, it seems that the case where the same
> prog is attached to two different hooks should be almost
> non-existent. That's why we've decided to go with
> the idea of completely ignoring it.
> 
> So the question is: is it really worth it trying to preserve
> that obscure use-case (and have more complex implementation) or we can
> safely assume that nobody is doing that sort of thing in the wild (and
> can simplify the internal logic a bit)?
I think it is a reasonable expectation for map-dump to show a
meaningful attach_type if it is indeed part of the key.
