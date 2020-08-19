Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5836124A4A7
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 19:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgHSRM5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 13:12:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:2666 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726209AbgHSRMr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Aug 2020 13:12:47 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07JH6RCp006227;
        Wed, 19 Aug 2020 10:12:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=6w5k+llSOtpoXWdOSwFlY4teR1q2UPKQ8XHDpG8lTao=;
 b=A9SyPnX4fOwhnGd+RR6qLedDIyn4pEVM8QkEnA9zK4K6lyUdGhyQG0vEZBEANK0p0H4O
 PfTYqvNwuov1xORdubTAGZcxNf+WPEtcOoIc1qWgJKh9nCOn5T3G6asz4HudHV17+quW
 a6iuygtcDvCbUFlaT7xpbB9HDRfbgw2O2Js= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3304pb1kxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 19 Aug 2020 10:12:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 19 Aug 2020 10:12:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DE7wbhE+JDzTn7V/DeekLKQf4QZFmS3g1XV5/4Vu5cE1assAbM5ZxzreCrgRSpcxeUONavGUJRRIxX/uElImMsxqVh21Etxskmxt7eb35jKvmekCWmDIIstBQzv3DBxGbGKensZgjJSp019X8LRoYuXeXA8jZjkKNkdWUqMFupDUegecJI22bE4bCLy2qRpzeYYt6px4obABRdTgHMkAEPjfk8QSC4+49U4ig/VlQU3l2Z/ma07YHkqZ9kBgUhOrEWBNHSX2B21FWCVrv2TjK1bNchvwkUAlOi5zwnCoaPJK26Ho3YkeiZ+tgHKcII5fN4IZKL/J6h8ixleqES1ybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6w5k+llSOtpoXWdOSwFlY4teR1q2UPKQ8XHDpG8lTao=;
 b=hrPz5LRgoPbZfdctNmtnELleiyxiMuUfB4wPRVyEhiwJr5oyYhaswe4gYu7QSG7/HN9uQK2FM9LKmDTbdvmBUA6osNT3NPDPjUzH5L+DgPzWeRxEvLYYGxyhX7vbycTSI/we/B3mwvPPMHaZRQ3VoSdFctTpV2m9dwrOtU2gzrRunjFOdYqOObNoe5UixefCl31j3XYBVF4FlHVNvSf250HUw2/9v3Q6yck8c6y8m4nstATP4dKU+UBxzaYJ/0vDEDZQAH8Ou/4kR16lN1P/sFQ5xZZ7LfF75PYk4VXvWXIVkC2oorH7BTx9+FitS4zWrcywV1wWwwOgsAmlUEDbBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6w5k+llSOtpoXWdOSwFlY4teR1q2UPKQ8XHDpG8lTao=;
 b=CznWQpg39hnjJyYuqnbI7fB1Dh3ZmWeD6t0TrIWFcS90y0p7eGWEnOaoxw3KAQlwBXiChQuoUNDu9TCXDodwO7lInSxfniSR2S9FzP3TjreUQTcZmT+TtNWZP/lw0PW2QXKshjZl41pibJPspMWA5hMXVvzC+Mo3M7BljiFY0Zk=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BY5PR15MB3570.namprd15.prod.outlook.com (2603:10b6:a03:1f9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 19 Aug
 2020 17:12:20 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3283.018; Wed, 19 Aug 2020
 17:12:20 +0000
Date:   Wed, 19 Aug 2020 10:12:15 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v8 3/7] bpf: Generalize bpf_sk_storage
Message-ID: <20200819171215.lcgoon3fbm4kvkpc@kafai-mbp.dhcp.thefacebook.com>
References: <20200803164655.1924498-1-kpsingh@chromium.org>
 <20200803164655.1924498-4-kpsingh@chromium.org>
 <20200818010545.iix72le4tkhuyqe5@kafai-mbp.dhcp.thefacebook.com>
 <6cb51fa0-61a5-2cf6-b44d-84d58d08c775@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cb51fa0-61a5-2cf6-b44d-84d58d08c775@chromium.org>
X-ClientProxiedBy: BY5PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::34) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:af4e) by BY5PR16CA0021.namprd16.prod.outlook.com (2603:10b6:a03:1a0::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Wed, 19 Aug 2020 17:12:19 +0000
X-Originating-IP: [2620:10d:c090:400::5:af4e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9273afa-7b65-4b25-1118-08d84463081c
X-MS-TrafficTypeDiagnostic: BY5PR15MB3570:
X-Microsoft-Antispam-PRVS: <BY5PR15MB357052C7892B9777AD43EA5DD55D0@BY5PR15MB3570.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KaWueGP2td+OmATlNZufTPsIlDyDBnCjf+6VhfxaDlSN0igaqCY9tCWk647J4j9qYM+dWl5Fy+BdbVT25pAvM2pjFx9QXdgfbaxizss/Vn0kpwNTmVDNpcsSxNI1E+6kVUjyeKoGhrwMJGSrCUNDIaCfa6k38RlqXSbje+eCTat9Qh4DoQxgtL/QokpWb2cf7pqw+toEJaRCxKnm9EG6le991ePt2nkjvVY7TvdVK5ljTyfORmSvQik8rpilar0kds7qIb7W73T9AlVSjN/OOCs/2gapS6UYMD8zzP+L2P/RTECqa4OxU2dYwc8I8qQHKTA/VJDQAcm+0TsLRX2L0/8eVWpUMxDDU8T7Px3tS7vg9FITpZeX/8pnvcIKQ0BFtzPcmuhad4PmFSQlq70dTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(366004)(136003)(396003)(8676002)(7696005)(16526019)(5660300002)(83380400001)(86362001)(55016002)(316002)(52116002)(6916009)(4326008)(478600001)(966005)(2906002)(6506007)(53546011)(6666004)(186003)(1076003)(8936002)(54906003)(66476007)(66556008)(9686003)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: PXEzAE6+pWtdJtuEhpGk0kqOSpODRL+f6jsY1w6ldUmwtpKGXHThuC6TbKhrZIrpCDRbxPTXctp6IXjuM39zhGpkIR06+IoRIEUavdz64gl+supqlQd7Nsndgu3hEoVaRWPaiG5J38D60M4uPFe7YrrN79M0FgtmEd8F4VIX3Bo8KM7JquwmYelSQsTGDXBSFuFJcnEcHoiCWekFpUjYpx6Tl1HyHUXHt90jQD8aAClu2+3R7avgbYCKdSI2wfS0uyyvEztkvuj6RD9n0msFwmy4vl9t9yhvKz9HaaMIAE1uTKfJv8iiiImF9VpNQzvPLsexS7OaO1LYmp2G74ExaXYjHtvIv+X4lsZaXlKx7L7XGOI4E4vyzWk1dNiouDWGObc3RC4Jb9eE4Smzj5d4+3Ts5bh3N99YUaHOS3B+lji9ZToD48bMDCVSiDdFBhINuKCan9i7hAJAvssQmsxKc4ukW+beZG54IZd7Qdnb3TiKATenGPo5DEp8RFY6+jq1iji8D5lwDCrqbPVO//99l76FnHHDCRRqyekDeNta5E8sHrMpzoKzEj2VHo3GuIaq2B6k8VIrS2TEoJs6HwjN/pRSUzhyD9uaJXaokmqSif6ZSwmrYXaJ0y/rTKBjnTVG3TVXN+hfX/ggKGasRMIouIl3aavMqRbiAHUx80Vd+mIa1E3UJZVODBT3XVYp/zo/
X-MS-Exchange-CrossTenant-Network-Message-Id: f9273afa-7b65-4b25-1118-08d84463081c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 17:12:20.3871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XBSZw+Fisi+TVvsiprp93RpMpSzWH8cnnVKLlqaG40mVQtba4mnxryB6fCDMqP0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3570
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_10:2020-08-19,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190143
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 19, 2020 at 02:41:50PM +0200, KP Singh wrote:
> On 8/18/20 3:05 AM, Martin KaFai Lau wrote:
> > On Mon, Aug 03, 2020 at 06:46:51PM +0200, KP Singh wrote:
> >> From: KP Singh <kpsingh@google.com>
> >>
> >> Refactor the functionality in bpf_sk_storage.c so that concept of
> >> storage linked to kernel objects can be extended to other objects like
> >> inode, task_struct etc.
> >>
> >> Each new local storage will still be a separate map and provide its own
> >> set of helpers. This allows for future object specific extensions and
> >> still share a lot of the underlying implementation.
> >>
> >> This includes the changes suggested by Martin in:
> >>
> >>   https://lore.kernel.org/bpf/20200725013047.4006241-1-kafai@fb.com/
> >>
> >> which adds map_local_storage_charge, map_local_storage_uncharge,
> >> and map_owner_storage_ptr.
> > A description will still be useful in the commit message to talk
> > about the new map_ops, e.g.
> > they allow kernel object to optionally have different mem-charge strategy.
> > 
> >>
> >> Co-developed-by: Martin KaFai Lau <kafai@fb.com>
> >> Signed-off-by: KP Singh <kpsingh@google.com>
> >> ---
> >>  include/linux/bpf.h            |   9 ++
> >>  include/net/bpf_sk_storage.h   |  51 +++++++
> >>  include/uapi/linux/bpf.h       |   8 +-
> >>  net/core/bpf_sk_storage.c      | 246 +++++++++++++++++++++------------
> >>  tools/include/uapi/linux/bpf.h |   8 +-
> >>  5 files changed, 233 insertions(+), 89 deletions(-)
> >>
> 
> >> +			struct bpf_local_storage_map *smap,
> >> +			struct bpf_local_storage_elem *first_selem);
> >> +
> >> +struct bpf_local_storage_data *
> >> +bpf_local_storage_update(void *owner, struct bpf_map *map, void *value,
> > Nit.  It may be more consistent to take "struct bpf_local_storage_map *smap"
> > instead of "struct bpf_map *map" here.
> > 
> > bpf_local_storage_map_check_btf() will be the only one taking
> > "struct bpf_map *map".
> 
> That's because it is used in map operations as map_check_btf which expects
> a bpf_map *map pointer. We can wrap it in another function but is that
> worth doing?
Agree.  bpf_local_storage_map_check_btf() should stay as is.

I meant to only change the "bpf_local_storage_update()" to take
"struct bpf_local_storage_map *smap".

> > 
> >>  	 *
> >>  	 * The elem of this map can be cleaned up here
> >>  	 * or
> >> -	 * by bpf_sk_storage_free() during __sk_destruct().
> >> +	 * by bpf_local_storage_free() during the destruction of the
> >> +	 * owner object. eg. __sk_destruct.
> > This belongs to patch 1 also.
> 
> 
> In patch, 1, changed it to:
> 
> 	 * The elem of this map can be cleaned up here
> 	 * or when the storage is freed e.g.
> 	 * by bpf_sk_storage_free() during __sk_destruct().
>
+1

