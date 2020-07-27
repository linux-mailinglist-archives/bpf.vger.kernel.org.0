Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42D722FB92
	for <lists+bpf@lfdr.de>; Mon, 27 Jul 2020 23:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgG0VoW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jul 2020 17:44:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35236 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726110AbgG0VoW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 27 Jul 2020 17:44:22 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RLeNQX002908;
        Mon, 27 Jul 2020 14:44:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=AT6OAw+qAtHH0H8cYCa/djBnBeuXn3EQrfuQGSSeqro=;
 b=a3DawDjBj8gN3sQ6r6irSVmmtnz+mxPXG5WU6TYw5BhwXfPj2r0rvinu6nPMH1uhfzrh
 A/P4LBzlW8XGKDIKi2MAx8xmZs6QCIl6PlZ8AX1GiO0LMh/q69/UZS89ZYTs7w4btDZB
 8WZZSuM4jHk7pijoTAsEYnqtOFw+SNoOnaY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32gj8kh1tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Jul 2020 14:44:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 27 Jul 2020 14:44:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPH7V4XhZcy/zNEaoJnFc/9Zl+xhnrBzyon5h0p0t7V9fkAwKrhoQPJfZxiFvYWA82R3yjYCcEKGd+R749wjFeUVVG+dELnWV8wICX6lCuDAFKCG7uQlvRL4KGSH15hgWgmImPQX7m25GvuPJnEsXKoczMIuDF+5mjs1TI6SpOTGHeYHF95p9/MAbcO2/ulXaTEFXUEHMaWrmsX4mgd+KT3Wi570eINWFuFdN9sBRa7jCaAUdutJ5cWH14B0WOEAdylVq2Vln6ZhAROqMd356FFrVHli9yVM4UJJmkz/mMY7qAU44RWUaFnhr/Oup3ayjwdbAsb+3nTrwDaIFFjwIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AT6OAw+qAtHH0H8cYCa/djBnBeuXn3EQrfuQGSSeqro=;
 b=iSMgZdpGIp9vc/Kq1Trq5cuR8XNKGnW+a/CUZgxX92nbgCuOrkyFuXVClCfrD8GbYE/K7GX+eQn1vcZbeSpYNXbtWIHqbXyY0zMXcSaY58jc5XUA7nsI0BgRQC/Nkrfr3HLhVJG1BMXXbytkAfxKcYdiwpONfpQ1s0qTgfYDJ1mgj6hBtktZfIWsG0QCpPbAY7K5NHhFK48c7j/hBdt+KNtGyPQ1EzsokvUs3MiN2ktocnsnEbgadKjI4nJV6DNc7T4A2r7paIE0rKRN61UHU9jusgfF40RnI8BdjUmbujwaiEJGPGo9ag7ksvCwjy7v+HnvgBKhjD/xDREKJupETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AT6OAw+qAtHH0H8cYCa/djBnBeuXn3EQrfuQGSSeqro=;
 b=bPwKv29XFw3f8yg2iy4/0iOu8jNaLhFT+5FuhByixWUtIlmEe9wTr2zpbcAQ8lWgfF0Z1xyqvj1AjSSlAF6eND+l4qOgM+MVAY4L46VObziN/7lpPUVZlizDSYjcmcd3EM4aVC8h44L9S79tLiZ8onn2ObSUdQWzA7xreYpImnY=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3367.namprd15.prod.outlook.com (2603:10b6:a03:105::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Mon, 27 Jul
 2020 21:44:05 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 21:44:05 +0000
Date:   Mon, 27 Jul 2020 14:43:59 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     KP Singh <kpsingh@google.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [RFC PATCH bpf-next] bpf: POC on local_storage charge and
 uncharge map_ops
Message-ID: <20200727214359.nchjgej4mfihefcp@kafai-mbp>
References: <20200723115032.460770-4-kpsingh@chromium.org>
 <20200725013047.4006241-1-kafai@fb.com>
 <c3c422c7-b15e-32ee-4156-b9d26896f7a0@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3c422c7-b15e-32ee-4156-b9d26896f7a0@chromium.org>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::24) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:f626) by BYAPR07CA0083.namprd07.prod.outlook.com (2603:10b6:a03:12b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24 via Frontend Transport; Mon, 27 Jul 2020 21:44:04 +0000
X-Originating-IP: [2620:10d:c090:400::5:f626]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e25d2f41-ff61-4fde-d988-08d832762f1f
X-MS-TrafficTypeDiagnostic: BYAPR15MB3367:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3367F8CF990143F29FAAA99AD5720@BYAPR15MB3367.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SmVqKWc90IMskkIDo0pxNmgWK1DD3GzXvJ3UhCU56Vt8sOvnJ4TvioebEyamCWmLt/88myqWBhUAHIZaMaZGmG7BmCAEO9k7pNl/WLaU0tZI4VAdojIQ/VTXGQ+eP90wRZhbQIMvTwFZWikzqhNTVai2jTWCrjYrDdQmD8r6cX1rS/oQb9tv6kKVd+o0WCzpJE74CBBtKZwrlNxUSwGqouP97CwkKEbaBhSclEgolK3QLMC9o0iJOlJ8aS44x3ND186UjZDOR35odYWQxVkw7M/8hmp1LnEWE9AxK+aBvnulG8Y5aMv607+rNlYLourk4z2F3kXoodMHcpEHzEiiBpo9iUOH7zjwIpFxHldUWEHIgJE7ElfTU8GgjuEW/Ergkm5F3lkLU5ouw1HdQJ0zPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(376002)(136003)(366004)(39860400002)(6916009)(83380400001)(53546011)(316002)(8676002)(54906003)(16526019)(4326008)(9686003)(2906002)(186003)(966005)(52116002)(6496006)(5660300002)(66556008)(86362001)(66476007)(8936002)(7416002)(66946007)(1076003)(55016002)(33716001)(6666004)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: cOzPVgxaUbReTHpSfmKhLkwZal9YmSuXIXCH3Y17EO2ZiqTjFxi+DAc235JtqCyQFpn0nkWvKMifjK+E49UzFFLcTf0PSyojh7ojBIZf5DbWalxZegv2cb4JjkHehOoDFxCdmvC2avwg0og4tpI7+Hg6w5iUeJRxys8OHWqS+7tT1hGQ3e7PEdc3995m+CwetU2kOzp42B2ZnN2Jf9yfciG+lLVbLbZuZfpUzEgOd0rWh+f4RRzIN5a53z0xt1Wj7cmEZBW3XH/3yHCxoBRf8xOOPzRkk0YyzAcJ/ZTamb3QzQSaTcbNB3E+ylZvXU4aUx5GzKswJ4uddezbfZTBFpkHWyfwe1PKWJS9UtCZ5QHk+OK8yMLwraeCVeabuIow0gM0k8PowIJjY7LDnmbKQLiX7x6ANigAd9FzjE7gMikBwP/yYXYBUYTVCovrtF4mRgIkt0lHXHqQ0hvTemHmCZB7JUCz/Zx8JNs7XlwNUCm2LlPm479ltgbat9lNdXk9+drbw3Az+mYkGOaqJ2EP9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: e25d2f41-ff61-4fde-d988-08d832762f1f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 21:44:05.3889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3ZVI7bEhRmQckO8dkhxHRsAY89+o+dy0yw76hdsBlzfHRR+N+0Cm5D8u2Dl4brz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3367
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_15:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270146
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 27, 2020 at 10:26:53PM +0200, KP Singh wrote:
> Thanks for this, I was able to update the series with this patch and it works.
> One minor comment though.
> 
> I was wondering how should I send it as a part of the series. I will keep the
> original commit description + mention this thread and add your Co-Developed-by:
> tag and then you can add your Signed-off-by: as well.
Sounds good to me.

Thanks for verifying the idea.  Feel free to make changes or clean up on
this RFC.

> I am not sure of the 
> canonical way here and am open to suggestions :)
> 
> - KP
> 
> On 25.07.20 03:30, Martin KaFai Lau wrote:
> > It is a direct replacement of the patch 3 in discussion [1]
> > and to test out the idea on adding
> > map_local_storage_charge, map_local_storage_uncharge,
> > and map_owner_storage_ptr.
> > 
> > It is only compiler tested to demo the idea.
> > 
> > [1]: https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_project_netdev_patch_20200723115032.460770-2D4-2Dkpsingh-40chromium.org_&d=DwICaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=VQnoQ7LvghIj0gVEaiQSUw&m=NZVmomh5sMPlIAqLmFQ_MXlMILuq1Z7TQqntbPoZ0ew&s=MLVevCJz2eNWswxXXF3jFYdAV2UG-xJEi0I1PkLL-fw&e= 
> > 
> > Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> > ---
> >  include/linux/bpf.h            |  10 ++
> >  include/net/bpf_sk_storage.h   |  51 +++++++
> >  include/uapi/linux/bpf.h       |   8 +-
> 
> [...]
> 
> > +
> > +static void sk_storage_uncharge(struct bpf_local_storage_map *smap,
> > +				void *owner, u32 size)
> > +{
> > +	struct sock *sk = owner;
> > +
> > +	atomic_sub(size, &sk->sk_omem_alloc);
> > +}
> > +
> > +static struct bpf_local_storage __rcu **
> > +sk_storage_ptr(struct bpf_local_storage_map *smap, void *owner)
> 
> Do we need an smap pointer here? It's not being used and is also not
> used for inode as well.
You are correct.  No, it is not needed.
I threw in there merely because it is a map_ops.  It is unused
and can be removed.

> > +{
> > +	struct sock *sk = owner;
> > +
> > +	return &sk->sk_bpf_storage;
> > +}
> > +
