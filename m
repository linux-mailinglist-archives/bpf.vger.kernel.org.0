Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993B6228C16
	for <lists+bpf@lfdr.de>; Wed, 22 Jul 2020 00:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgGUWmR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jul 2020 18:42:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34278 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726148AbgGUWmR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Jul 2020 18:42:17 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 06LMfAEH005686;
        Tue, 21 Jul 2020 15:42:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ZsNv6XYDeMlDaxQCjNOz0Zc9j/6pPOjERHn9VE0Mn5s=;
 b=IgeiSf6jJxEAzzevgjXrYE6ISyrKOIS9NuO6RmRGgPzjvMmtxzm7eRkP51oCoRuJ6gRC
 eJLBU0vJDWEFkIxrlOCBteq0hSvK8AspWaYZHu/bWJXk4jP+lieUeZMj8eZEfElFbPZn
 28OViHqlUAMPonBl5jtx3tdOTqoHw5eCskU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 32bvk06khp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Jul 2020 15:42:01 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 21 Jul 2020 15:42:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaDzXrH4zuKxuPQyN20IksJpLdxW+hrOAqydDMdBemCyNWmYW94nuIegae+MPnHJ0rUBWJIWfuPdbfbF0Zi4Q0+kmJVUWb5lpkiuzb9ABcIUORKRk26rvBdWU3y3vZ64+mBIc/e2c9mxcuD10TD6iFaZQCooUOQqw85wjcMxz7qAUjWFGTeC97Z+9O50MTzmPw/vHbZlDmzsjaA+LBweZ1NdtV+0jVobTMekU1ZJ6pYRElXbbWiA8/5H176BCe0aGCykicuiTmYTixm0+EAcjJ9ipyAaNXXgph8xG3lXSPOjPLvxwFpQYImSMCFyWmGMv4KGXuAEPTGD2Y1xGMExdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsNv6XYDeMlDaxQCjNOz0Zc9j/6pPOjERHn9VE0Mn5s=;
 b=CqBVrr7aHYN2XtLLahrgnM79DBfBqmSkUwyCsrvF8mDvtEoV+eAdxMAO8oU7oLy/vdQWJ7giuecd1g7ClnwObh4FvbzAvBA/7YQm9yQfbf3Nlddz9bOM2vpnzQut0SQr64OgcrNBCYV6KUPPBoHM36vTRfwwFYSjk1kTzOaD1Ax5ciBJVh1ugarIoPUPM0MfdNSFxDpl4r1iu6UgvMwFGk0/sKDypyVwvg4xFeY/vuwNUVCzADLYnR8RcBPuQUnU8Uoe7YNQhZ2z7Ln+vPZcadE03Nl2Scavc8nQrBLabV+nqrgRrXqmZ7opCwfLtGpucWPcx1ZtQ1uFt2J8Pccxdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsNv6XYDeMlDaxQCjNOz0Zc9j/6pPOjERHn9VE0Mn5s=;
 b=RWH7YbRmJXg58zxQmWde9l+EROg3JZkaTOalDyRJGceXAN/VQPT6xUX8cG+L3tS0j75cfGECACHoRQ+YfZYqkP0OPz4AYRmiy+MIV76WqsxdBwyJRRtn3RqsH/2jflMg4AADKVqRKWE13ZH/h2t7IJVHTKPlfYvUakqIIkmtrBE=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3302.namprd15.prod.outlook.com (2603:10b6:a03:10f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Tue, 21 Jul
 2020 22:42:00 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3174.030; Tue, 21 Jul 2020
 22:42:00 +0000
Date:   Tue, 21 Jul 2020 15:41:58 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     YiFei Zhu <zhuyifei@google.com>
CC:     YiFei Zhu <zhuyifei1999@gmail.com>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/5] bpf: Make cgroup storages shared across
 attaches on the same cgroup
Message-ID: <20200721224158.ylrgjjljlighny4f@kafai-mbp>
References: <cover.1595274799.git.zhuyifei@google.com>
 <f56279652110face35e35f2d4182da371cfe937c.1595274799.git.zhuyifei@google.com>
 <20200721180536.57kbngehupi4hqra@kafai-mbp>
 <CAA-VZPm9fgNKMHX1rbOEcUJ17=S5qS=rkYcBiqzcsOxCSSKuGg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA-VZPm9fgNKMHX1rbOEcUJ17=S5qS=rkYcBiqzcsOxCSSKuGg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR01CA0012.prod.exchangelabs.com (2603:10b6:a02:80::25)
 To BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:b838) by BYAPR01CA0012.prod.exchangelabs.com (2603:10b6:a02:80::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend Transport; Tue, 21 Jul 2020 22:41:59 +0000
X-Originating-IP: [2620:10d:c090:400::5:b838]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd24f0e5-6097-4be4-0b8e-08d82dc7478d
X-MS-TrafficTypeDiagnostic: BYAPR15MB3302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3302B0CB0A188F22962B41F0D5780@BYAPR15MB3302.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2HUl8ZBkVaxwA3EPVlVH5Z+vILU2Ej16AyZFqea/ZV1QkIgapqlR5Ig305YZPqAkcxWg7XXzCsTVwb0zRKxUkl88SeXAaXxD3Zdv90azjsZ4vEILH1IlExLzsKusa3/tZ7UjWcEHvP+Znolqqibo23B9ZpUOvrIOk3ECwj8K/26cL8xUpYCL0H2TjUZKXb1sZGIpLOCyJQJCUJ684j9MwVaxhqxMc2vx8UZR8vDJu1gjsbyzuWqPAJZH+RI/Fo54GQZHTs+AjQVNPZ1gLTkNbyWeStpCAPBdCpk5uWmkk+i7isXGUj0FrLmLg/N0+e+p7eh6ljU3Edcl72fh71kbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(366004)(39850400004)(346002)(396003)(2906002)(8936002)(8676002)(6916009)(5660300002)(55016002)(9686003)(33716001)(316002)(83380400001)(54906003)(478600001)(6496006)(66946007)(1076003)(52116002)(16526019)(86362001)(66556008)(53546011)(4326008)(66476007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: MvB9ay3UcyOWwa6QTtsFxFdMeUlkzxwtXuCD5acpYCVEOs715APw1r+bDcUomOH+yAnMmI6m7EhxwsEUGyh7Uz2ycaSDkLbxz3ukwjo0HiUiXizZVKfswIQ5f8Hg3rejb98u84pLW0jmIIJATNr0Hib8Bv6sYV7+b3H4cyRH1RKZFXnuhZ9NBVoIsdjKRB8SJLvtnc7VCyrhiq9jX4/pg2waZ7IzEZ3XiQ54U62nNg7qBd/eLxaNicdsAIWH03a8+FUmlmBut+2qIFxZPaZ0lQDKJpK3mOSxBwuBk07AgbDfsWNFcsnkqvImpma0JKQpTCa2T5DL1zksvfnkiu7tnwVuuPBvr1i+LfcGLvvwIurEz2DPkoeb1i5eGg6aZBw7W/evzbFSXRjjrPg7OtLbyjS7swrPs6wS8aUjQduGGdMt9tCqYOtJTTriirmdnUDw1BW+bzrvPlKyQV9mGVj+ZkBNtZUe7ofSvXwSJVQbX+SRRd0VcyoMsZ/Z8B0zj04/6sQM8X6tBHD+RuOyizNyXg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fd24f0e5-6097-4be4-0b8e-08d82dc7478d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 22:41:59.8121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nopS0sU5GIRKcsr4TJnN6Gn2t01RGqviraQ1OY+R7KSVY9rxW7/4ilCYwsUKPPML
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3302
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_15:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=642 bulkscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210142
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 21, 2020 at 04:20:00PM -0500, YiFei Zhu wrote:
> On Tue, Jul 21, 2020 at 1:05 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > I quickly checked zero is actually BPF_CGROUP_INET_INGRESS instead
> > of UNSPEC for attach_type.  It will be confusing on the syscall
> > side. e.g. map dumping with key.attach_type == BPF_CGROUP_INET_INGRESS
> > while the only cgroup program is actually attaching to BPF_CGROUP_INET_EGRESS.
> >
> > I don't have a clean way out for this.  Adding a non-zero UNSPEC
> > to "enum bpf_attach_type" seems wrong also.
> > One possible way out is to allow the bpf_cgroup_storage_map
> > to have a smaller key size (i.e. allow both sizeof(cgroup_inode_id)
> > and the existing sizeof(struct bpf_cgroup_storage_key).  That
> > will completely remove attach_type from the picture if the user
> > specified to use sizeof(cgroup_inode_id) as the key_size.
> > If sizeof(struct bpf_cgroup_storage_key) is specified, the attach_type
> > is still used in cmp().
> >
> > The bpf_cgroup_storage_key_cmp() need to do cmp accordingly.
> > Same changes is needed to lookup_elem, delete_elem, check_btf, map_alloc...etc.
> 
> ACK. Considering that the cgroup_inode_id is the first field of struct
> bpf_cgroup_storage_key, I can probably just use this fact and directly
> use the user-provided map key (after it's copied to kernel space) and
> cast the pointer to a __u64 - or are there any architectures where the
> first field is not at offset zero? If this is done then we can change
> all the kernel internal APIs to use __u64 cgroup_inode_id, ignoring
> the existence of the struct aside from the map creation (size checking
> and BTF checking).
Just to be clear.  The problem is the userspace is expecting
the whole key (cgroup_id, attach_type) to be meaningful and
we cannot stop supporting this existing key type now.

This patch essentially sets all attach_type to 0 to mean unused/UNSPEC/dont_care
but 0 is actually BPF_CGROUP_INET_INGRESS in bpf's uapi.  "map dump" will be an
issue as mentioned earlier.  Also, as a key of a map,
it is logical for the user to assume that different attach_type will have
different storage.  e.g. If user lookup by (cgroup_id, 1),  what does it mean
to quietly return the storage created by (cgroup_id, 0/2/3/4/5)?

I think from the map's perspective, it makes more sense to
have different "key-cmp" operation for different key type.  When the map
is created with key_size == (cgroup_id, attach_type),  the "cmp"
will stay as is to compare the attach_type also.  Then the
storage will be sharable among the same cgroup and the
same attach_type.

Then add support for the new key_size == (cgroup_id) which the "cmp" will
only compare the "cgroup_id" as this patch does so that the storage can be
shared among all attach_types of the same cgroup.

Does it make sense?
