Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E575215F17
	for <lists+bpf@lfdr.de>; Mon,  6 Jul 2020 20:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgGFS4r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jul 2020 14:56:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12872 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729724AbgGFS4r (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 6 Jul 2020 14:56:47 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 066IjpuI008121;
        Mon, 6 Jul 2020 11:56:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=fBJ3J820TyQOp2nVCato1oQu9G5uCWs7wFLD+M6IjnI=;
 b=UVTOllYjKBAg5TQ5MLqutLy8d5TEnTKc8chYb3c0wAzlKBwrrcnA+tNh7jSM2a5ZpqBv
 UfAQziPA1L9J9kJIuCboxmXNijaq69slAGxOADTrDTMyc+ynCQ2zc0Dl5EggQN9fpeJI
 aJks2GmzsrP0z6KLDcM2PrCByoqCbU+2j4s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3239m1ntq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 06 Jul 2020 11:56:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 6 Jul 2020 11:56:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJcpFjK2FRVo2DQKiBgsrN5wtGUxzzWACrYQGRcdmoRjsUBzKnRvCFe+BqZOY45CQoI4Z9EoydIcTEwyf+EUaN/CwiXlVdQXpJ5S4fdazfw0h6T7PTDE/I39MsgBvAt3wSb0X9ak+/B0+Rbh3Dp6kBkja4TAAdMVNlW340egqffZkfiT2G0oehjYhJ3ASH6FWLGzeD0fK8GezJetQVXUhzTzTAriP1tTVw5Z1FlSM8rJsV0uwDBD+PeAypCX2gPE+p0oxByGTVXF1fNz/le5iQprEEC9AcLdlDmRJ7pQY6nJQ6kL+oFLXaDz/U7lp7nTYJKf6vJ5J98LGOOox0I7kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBJ3J820TyQOp2nVCato1oQu9G5uCWs7wFLD+M6IjnI=;
 b=dLR6UuewAyAmDOIPTOSr6EcaB6K16hH5xSM4J/qIIChOqVN824eQC5DF+kXzdPf9THEVcKoqupXG9WlBhpAmHVfJ1nS4UJhrYa1XK2g/f8AvHrL2qTJmavRy6dnMB7rx3RLCA7Oz3rlqGj6Dens0TsVvkU8zT8k4PRZDhH4rBV/14byWRlY9exf463NCwEOuc2ddMp93frWhcWneKIbqLrXtQm0ZgMHu3wFRjIwEQ05JgQDpm3Vna6YXuBNUskNy0QaY0kdYO78kTyES1cJK1o3ufr1x5ePjfy+7vgoREpLu17278FHuhbDGuEzYvcLgemRkZvLIZs0vFCmuI+AwIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBJ3J820TyQOp2nVCato1oQu9G5uCWs7wFLD+M6IjnI=;
 b=bgOwFTN49GiP4jGODz6mfDiBj7SxC/EB5jb/7JmJl6328HxtLLPNrmkejvJv6aB+uHPYNpGNeao/Jqk6kH6uvbgiUhwJZPxKOYhkFPWvb6ncpxY9yBNgWOA17Fa81A1R64gh3cQR/xyUIWduKF+JsiWJh8luTbzjwcbqE6q7tO8=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3205.namprd15.prod.outlook.com (2603:10b6:a03:104::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Mon, 6 Jul
 2020 18:56:26 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 18:56:26 +0000
Date:   Mon, 6 Jul 2020 11:56:21 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Generalize bpf_sk_storage
Message-ID: <20200706185606.j3asqqsxujomaq7z@kafai-mbp>
References: <20200617202941.3034-1-kpsingh@chromium.org>
 <20200617202941.3034-2-kpsingh@chromium.org>
 <20200619064332.fycpxuegmmkbfe54@kafai-mbp.dhcp.thefacebook.com>
 <20200629160100.GA171259@google.com>
 <20200630193441.kdwnkestulg5erii@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ6Vr3TtKQnTrJyB0L47goAMTC0uHoLpsNF8Vo2QySWECw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACYkzJ6Vr3TtKQnTrJyB0L47goAMTC0uHoLpsNF8Vo2QySWECw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:74::39) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:c149) by BYAPR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:74::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.14 via Frontend Transport; Mon, 6 Jul 2020 18:56:25 +0000
X-Originating-IP: [2620:10d:c090:400::5:c149]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dfc5d46-35d2-4c2e-6833-08d821de48d6
X-MS-TrafficTypeDiagnostic: BYAPR15MB3205:
X-Microsoft-Antispam-PRVS: <BYAPR15MB32053F2713ECFFDCC9B7B580D5690@BYAPR15MB3205.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eCPI+FTykTaR+n8efatOInmvupLpFx2SQFmkEDSBjU208+oJcn+HwxZ5ALGb911LARVksoJEF3g7M4kL3Vss7vFvKAz0xg3xZxvd1+sbOoBzzCa468b2KBX4d8+YHMxmfkv5OjbHsq614ZFdFpXWW1Q3P66A17ogsdAdkWKNEysd9UiaLmwqr6Cc3SLz6mh79EMQO/jcXgKXxl1sHZIR4j2/pj2Z5FX5vXF93b8XtnJ6tGAldapAM1sdRBNO+TogSpg+XViCTJmeBCvD9BM923OlNwofouKKqza4q81VJtDHp6e8ER7/+j+J32z++xwj5FxftKcsHRwJH1b5IpAZXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(316002)(478600001)(54906003)(6496006)(8676002)(52116002)(33716001)(16526019)(66556008)(66476007)(66946007)(4326008)(8936002)(83380400001)(6666004)(186003)(1076003)(5660300002)(53546011)(2906002)(6916009)(9686003)(86362001)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 2n+rA52e07KNNTl50bdv1xTD6ZIVO2w1guNB8D0YiqOjz3Qy2GSmtTmgAIUW8a3Q9LKkVYrUgyNaxR9nPHOV1CRIivahA7wy4Wy1cVVApNteu02lj7HfIATfquVWwTl8u9e3pHuFPKJx1/GbbYrhnc6QL5G6y/s463Gb5LVDUSON9LGbycsaVqa6eArXFM+NRO19KWOwk0vhxuHGT/tREw0GJBw5aQpbgaEAH7ubYhyJCZNRGuUUcxWlxy1fotLFCV4O+9qgrGCZANvIBg7mA+Z8eZhkNBFM4Nb4J74h3beqhMOwfcTZVU+eb8FEgQeQtRsVdOeEsyx9M548YQrUtR1L16+PbPVRF53y/qwE19soFr3SzJA6Edbq8924Q/qvm3ERzQh0bdukyFz8Z9yWiLtnzyPdJouNgDXbO35MYNwq/NM2uNtT0+Hv6lPD+ZVqAoGh3wx1YMY1x59Yqa1NR9c1HaWztADsY4H2/FCEhOXX59wYfT4Rx2RQwj6CmqTyc2hoSwH/e+rQgt+kTllLfw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfc5d46-35d2-4c2e-6833-08d821de48d6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 18:56:26.2831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2un0jg8/LpxsEf18iUZtR8jLuL//iSNLzzNQr2tbdckZ3jQwUISgtuALnlkkh+1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3205
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_16:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=945
 mlxscore=0 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 cotscore=-2147483648 clxscore=1015 adultscore=0 suspectscore=2
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007060129
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 30, 2020 at 10:00:18PM +0000, KP Singh wrote:
> 
> 
> On Tue, Jun 30, 2020 at 9:35 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Mon, Jun 29, 2020 at 06:01:00PM +0200, KP Singh wrote:
> > > > >
> 
> [...]
> 
> > > > >  static atomic_t cache_idx;
> > > > inode local storage and sk local storage probably need a separate
> > > > cache_idx.  An improvement on picking cache_idx has just been
> > > > landed also.
> > >
> > > I see, thanks! I rebased and I now see that cache_idx is now a:
> > >
> > >   static u64 cache_idx_usage_counts[BPF_STORAGE_CACHE_SIZE];
> > >
> > > which tracks the free cache slots rather than using a single atomic
> > > cache_idx. I guess all types of local storage can share this now
> > > right?
> > I believe they have to be separated.  A sk-storage will not be cached/stored
> > in inode.  Caching a sk-storage at idx=0 of a sk should not stop
> > an inode-storage to be cached at the same idx of a inode.
> 
> Ah yes, I see.
> 
> I came up with some macros to solve this. Let me know what you think:
> (this is on top of the refactoring I did, so some function names may seem new,
> but it should, hopefully, convey the general idea).
> 
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> index 3067774cc640..1dc2e6d72091 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -79,6 +79,26 @@ struct bpf_local_storage_elem {
>  #define SDATA(_SELEM) (&(_SELEM)->sdata)
>  #define BPF_STORAGE_CACHE_SIZE	16
>  
> +u16 bpf_ls_cache_idx_get(spinlock_t *cache_idx_lock,
> +			   u64 *cache_idx_usage_count);
> +
> +void bpf_ls_cache_idx_free(spinlock_t *cache_idx_lock,
> +			   u64 *cache_idx_usage_counts, u16 idx);
> +
> +#define DEFINE_BPF_STORAGE_CACHE(type)					\
> +static DEFINE_SPINLOCK(cache_idx_lock_##type);				\
> +static u64 cache_idx_usage_counts_##type[BPF_STORAGE_CACHE_SIZE];	\
> +static u16 cache_idx_get_##type(void)					\
> +{									\
> +	return bpf_ls_cache_idx_get(&cache_idx_lock_##type,		\
> +				    cache_idx_usage_counts_##type);	\
> +}									\
> +static void cache_idx_free_##type(u16 idx)				\
> +{									\
> +	return bpf_ls_cache_idx_free(&cache_idx_lock_##type,		\
> +				     cache_idx_usage_counts_##type,	\
> +				     idx);				\
> +}
Sorry for the late reply.  I missed this email.

The above looks reasonable.
