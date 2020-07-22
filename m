Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F38228D34
	for <lists+bpf@lfdr.de>; Wed, 22 Jul 2020 02:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbgGVAty (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jul 2020 20:49:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42564 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727049AbgGVAtx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Jul 2020 20:49:53 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 06M0mVJa024251;
        Tue, 21 Jul 2020 17:49:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Y8E8lny0Eq+SZNSq3sOmAw7PDQ3DOp/lkWgLznjnirw=;
 b=i4/yjWeP415jBi7b6nW2r1CzBHRCzbF0Cv1V33HPQrUKJWEMgt2hFtiFk/GuImhmSxcZ
 e75AU2eQ+3tW/5OET7wMdQZF0vEhBd0BrWYa1t7zPR2X1wxb2/MyZx4w+TGpeRtYnTda
 c8SyYrdrBZQluOWI4iZzniZSad07ajfQLbM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 32bvrnq3um-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Jul 2020 17:49:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 21 Jul 2020 17:49:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yf6FQ5GvDeuvTVTN9HJjnn7O7+POe5lJguZI9XGER+DMK+XpTcuZT1BWOHHQimJforA7F18pT0iTI5qqAhxZbrNXRYWXMYeu2Lu8VhjxKqFOF3KIa1hSZAnOo9A+rbWYw7bi8c7hah/mcTNKJLDO6vkCdxsVEs+586Ib9hs1BdaLmIDNJZSbShpfv9tFyjc9drVjTMBl0FV2p0VyBLX5qei6dncIsk79r5tBoUl8L93q9uM5sof1MbYwIQT0qyD9EGLlj/Btu9QSthRLMa0VkcNeMDHF3kr+xXzr3VOZiJXTNFfLK4E5z+Gk7Lj92J/PUDPUkJw7ldrL6paD6NlPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8E8lny0Eq+SZNSq3sOmAw7PDQ3DOp/lkWgLznjnirw=;
 b=mR6ZD5DBwXWes10PvdM3Xede2f5f0mMUZLj1gbNSIDgPvpka8zxlx3YrxfnqK1p4X0hsEZW+tmmhKtkZJh5AJxQt1xQ53UpYjM+q03NENoE1pKk8IgnY0+XMDa4Nqwz17U0Efr0qd/kJT2YP2ZNuA2I+v+EbrnpUHWC6VvVov0ygu+DIoqmgy4EQB9E7HcN84eWUdMlpfxc4MrJF+WLtXYza9dneoOLYcbDK/IDftXXtMWAycRldiXCH+pMxz1CHw7iwL1BapPWR23/MPOmj/tG9WHJTy1yL+uVujaOdgo7AQrCPFJB5/QBz1WiVCn10BogUzsJSU7eBrAvb3QbloA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8E8lny0Eq+SZNSq3sOmAw7PDQ3DOp/lkWgLznjnirw=;
 b=ihdCHa5nvq2aYo+Tybw2vdanByB0xnib2TDug2ip82dY3cD4KJQ1HZgrYCXP2Wsk60fbvhrQut7bvx1wZBkV85SCL8vmWEcDJ4H6VD91sTBBddG/bTOSLvnZQJ/QB07bPOpBXi+YHKZPPkn50/IAnQT7aW1d8A6jvYTWYTbIjrQ=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BY5PR15MB3619.namprd15.prod.outlook.com (2603:10b6:a03:1f9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Wed, 22 Jul
 2020 00:49:36 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3174.030; Wed, 22 Jul 2020
 00:49:36 +0000
Date:   Tue, 21 Jul 2020 17:49:34 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     YiFei Zhu <zhuyifei@google.com>
CC:     Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/5] bpf: Make cgroup storages shared across
 attaches on the same cgroup
Message-ID: <20200722004934.xfy4xh4kgw7cdxe2@kafai-mbp>
References: <cover.1595274799.git.zhuyifei@google.com>
 <f56279652110face35e35f2d4182da371cfe937c.1595274799.git.zhuyifei@google.com>
 <20200721180536.57kbngehupi4hqra@kafai-mbp>
 <CAA-VZPm9fgNKMHX1rbOEcUJ17=S5qS=rkYcBiqzcsOxCSSKuGg@mail.gmail.com>
 <20200721224158.ylrgjjljlighny4f@kafai-mbp>
 <20200721225636.GB184844@google.com>
 <20200722000913.roxrdgomdgvy7ho4@kafai-mbp>
 <CAA-VZPk0E6nfbm6NpM7_523tvRWGPFEMEkEp-UZW+Oht3pszLQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA-VZPk0E6nfbm6NpM7_523tvRWGPFEMEkEp-UZW+Oht3pszLQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::29) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:b838) by BYAPR05CA0088.namprd05.prod.outlook.com (2603:10b6:a03:e0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.15 via Frontend Transport; Wed, 22 Jul 2020 00:49:35 +0000
X-Originating-IP: [2620:10d:c090:400::5:b838]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 337e47e7-e5ae-42ad-d455-08d82dd91b49
X-MS-TrafficTypeDiagnostic: BY5PR15MB3619:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB36194B6D190400DC70E62729D5790@BY5PR15MB3619.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TtfIiGwj50P4QlszhqPAaKN85gDzpYP3EZ5H01XY6kmQWGM4oPetDyquYwZj3Th53QfFSOArtNfqOA70mAeEjGMToQd14lKJzzjwyT0niXCk5DIiAEVQ8cpKUTx1hRTP0i0oFb1bQqrOMGEctFSyE/RX67srDDzgbBoX2msl1s26B0LYPziduAEmdrP1G9VmzkHGeKSGYwLy9trMSdD51TwXReOBRQlXgDr///simMx60R98FOagYK9DPHQ7WnmtpWFVNqvOSAkWYXGyPrgc8pdFPoJ731lNkcrzDjyKj5dyQeDGbGUHUyGR6WWNSHeCC1p2Lk+pWFFUdc5m3bl4rQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(376002)(346002)(366004)(136003)(54906003)(478600001)(5660300002)(4326008)(6916009)(16526019)(33716001)(186003)(8676002)(83380400001)(8936002)(52116002)(9686003)(6496006)(66476007)(66556008)(66946007)(316002)(2906002)(1076003)(86362001)(55016002)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: M4brHiFw43Th+RprQ+FawPiqLfbkn7Uw1JS+6OjM5YA9uS0h99kvKnC6+5vsWJruNC419zM/RrCy9JWPVMRjtCnfcM7oZvb5IaRKRbCIp30lFKQAih7LmoBaAEs4nwBHxkBJaFex6z6A4mZM3Yjuati9nstW3Yhx3PCtgRidbP7G6yenCidFreB40slkvYleam/xEm7CStoDNcvk3D06x3bpSOdAz1tJK5Qwv1t+BoBTXuPvzsJJVZDAfdTS7+qqfADQ7eW3o8zPgkiEBweUqHzhrJm4dXIa200MmqLI1Wu3JchZGpSiBckzIyqlkb4v6Uv5n6a2dGQ3s+/928YhEIehgJ1+yIUfV2+XUwgHB8FNg4jRNsEHPvC8qS7XwcXiCMRqFpZOlQWvPWG2SqwZA6MPBxl+Tlgt4xMTczSJuKkKpG1cPDe3cxS1E3R4AigIpl3ox+lnRzPCG+rRLHiMplyphGgyQETHK1ZCBtrTb3hLkyZtTT0fPB2cr+66e9E33MaGUZJjDYwlf8/6DvqGdg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 337e47e7-e5ae-42ad-d455-08d82dd91b49
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 00:49:36.3640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uik/7LvcnIp3I9yzH9pl2rrvzGZLqfKWdwTKiwhsqqk3oc27OGvc21vrUiC4Gmbm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3619
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_01:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=584 impostorscore=0 clxscore=1015 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007220002
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 21, 2020 at 07:19:31PM -0500, YiFei Zhu wrote:
> On Tue, Jul 21, 2020 at 7:09 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > I think we are talking about the existing map->aux check in
> > bpf_cgroup_storage_assign()?  Right, the map is dedicated for
> > only one bpf prog which usually has only one expected_attach_type.
> > Thus, the attach_type of the key is not really useful since it will
> > always be the same.  However,  it does not mean the exposed
> > attach_type (of the key) is meaningless or the value is invalid.
> > The exposed value is valid.
> >
> > I am trying to say attach_type is still part of the key
> > and exposed to userspace (e.g. in map dump) but it is sort of
> > invalid after this change because I am not sure what that "0"
> > means now.
> >
> > Also, as part of the key, it is intuitive for user to think the storage is
> > unique per (cgroup, attach_type).  This uniqueness is always true now because
> > of the map->aux logic and guaranteed by the verifier.  With this patch, this
> > "key" intuition is gone where the kernel quietly ignore the attach_type.
> 
> Right. It is indeed non-intuitive for part of the "key" to be
> completely ignored in cmp. However, what would a sane solution be
> instead? I could at attach time, use the attach type to also perform
> the lookup, and store the attach type as the key, if and only if the
> size of the key == sizeof(struct cgroup_storage_key).
Yes, that makes sense.  cgroup_storage_lookup() has the map which
has the key_size, so it can decide which part of the key to use
for lookup.  bpf_cgroup_storages_alloc() does not need to know
the details and it just populates everything in bpf_cgroup_storage_key
and let cgroup_storage_lookup() to decide.

Thus, it should not be a big change on this patch.

> This storage
> will not be shared across different attach types, only across
> different programs of the same attach type. The lifetime will still
> bound to the (map, cgroup_bpf) pair, rather than the program, as the
> implementation prior to this patch did.
Right, the lifetime of the storage should be the same regardless of the key.

The major idea of this patch is to make storage sharable across
different bpf-progs and this part does not change.
How sharable is defined by the map's key.

The key of the map should behave like a normal map's key.
sharable among (cgroup_id, attach_type) or
sharable among (cgroup_id)

Then all lookup/update/map-dump will behave like a normal
map without an invalid value "0" (BPF_CGROUP_INET_INGRESS) in the attach_type.

Thus, I don't expect a big change in this patch.
May be restoring the original bpf_cgroup_storage_key_cmp() behavior
and a few key_size check in the map_ops's lookup/update/check_btf...etc.
