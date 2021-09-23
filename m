Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2E741551E
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 03:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238789AbhIWBa1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Sep 2021 21:30:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64740 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238177AbhIWBa1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Sep 2021 21:30:27 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MKlN9l029482;
        Wed, 22 Sep 2021 18:28:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=qLB8aNm1J7qsE3hYtazuLJNsEYRHpaCn1oeyoX7EqAI=;
 b=lYDfyP2ybomGgnJ8i1jAM1cg6c8nStAQX3Fp4eu/zqqB4n1dCKqME4hC3Eh0QxWKpqqD
 RFsCM28dzoLW/Ts/dVOlQxtY/68dPrRBjlSi4mBXo45B/J5XoUNwtXKUdGGoAH5NICCo
 KNgxtRHuvv7ZurxxOQjrCVa8jlQ2McS5bfk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b8ba61js1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Sep 2021 18:28:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 22 Sep 2021 18:28:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAzoisrZI9q+nbd+sstjoSNLOzN3Iag+VGbrgYtCHtZwMaMbuTmDbdDLt6RD3nFRm21c09nUgCvahaCcS795YnHeVdMMzsF+S4TP0R1wayOksBzcrf+yukEEmIr+/0eOdj4Je7JJn2FJCBzKlrIT76iq7rKPMrgLbAH4BbSjo2swrjtv9JEey72oiKqEdgwDnrWEZhT+eoHGNaIvlu55VF/HnCfyeioDpByTR3L47+/Tc/NA2e0N0qS8zHr0+LzEN8rGY0F3jrZfbpMC0mXpXKIPGxeG52gJuSjcZYejuHeYJsGaltdL3FyhmsUwt7cGh7zgm/1s/2+nJcqn1I/r9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qLB8aNm1J7qsE3hYtazuLJNsEYRHpaCn1oeyoX7EqAI=;
 b=TAmohpSPVmRjPQawuj1j637AQC4HIDovwRhIcaKrX++6jkwsd0phizkSqV1R1f3Eg+zX+S/StYseizXDCDq+QzexbVyxu6ToHN6eQd4UADLYZMieuHo46ywoxXLJJb/gmOyFypPNzmaXjPnI0K6m4vMK+CROBqkkD0PxcmvxRljbxKb9fLraKZICrCXcTdRBx/PA8swEXcMKAYGmbi46VJP6/JcCgLNfoSl53O+/Q08iEB/cNtlxf9VjJF/2MtK4gvr1NBUp6O+u0i1TCT1U8SnR1mW2BvwqetcNAqYaaL54PDdLbruLH3Wvz0RpJ9aZ+a0dUCUS1e4KbB9luxynYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SN7PR15MB4239.namprd15.prod.outlook.com (2603:10b6:806:101::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 01:28:53 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%8]) with mapi id 15.20.4544.013; Thu, 23 Sep 2021
 01:28:52 +0000
Date:   Wed, 22 Sep 2021 18:28:49 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
Message-ID: <20210923012849.qfgammwxxcd47fgn@kafai-mbp.dhcp.thefacebook.com>
References: <20210921210225.4095056-1-joannekoong@fb.com>
 <20210921210225.4095056-2-joannekoong@fb.com>
 <CAEf4BzZfeGGv+gBbfBJq5W8eQESgdqeNaByk-agOgMaB8BjQhA@mail.gmail.com>
 <517a137d-66aa-8aa8-a064-fad8ae0c7fa8@fb.com>
 <20210922193827.ypqlt3ube4cbbp5a@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzYi3VXdMctKVFsDqG+_nDTSGooJ2sSkF1FuKkqDKqc82g@mail.gmail.com>
 <20210922220844.ihzoapwytaz2o7nn@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzaQ42NTx9tcP43N-+SkXbFin9U+jSVy6HAmO8e+Cci5Dw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAEf4BzaQ42NTx9tcP43N-+SkXbFin9U+jSVy6HAmO8e+Cci5Dw@mail.gmail.com>
X-ClientProxiedBy: MN2PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:208:d4::18) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c091:480::1:4522) by MN2PR04CA0005.namprd04.prod.outlook.com (2603:10b6:208:d4::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 01:28:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c6aa88a-23de-4686-5971-08d97e3180b8
X-MS-TrafficTypeDiagnostic: SN7PR15MB4239:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN7PR15MB423903D08751AA13CA909A48D5A39@SN7PR15MB4239.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G0KyggUgtiPJdXoPPFepyoFbLgvCFL4uk2OsHDTJ8x+hf+fP08ZDGMJ44A8u+tFZsgO7huw7SdRtzeVP9z4pYsYlWtjpYpjbJXtSlFfxSc1W5AW4KYK6Zk0gcPFzP5Ya3OY0/NQ5xcGc21UXMiin3/EB60yMQ9TIW7AeX9x0ESz3Hwd9qQNf6nu/VrEGhrySGf1zWQVVn1FsnL+nII+nzYbpsTrb74JApvPeYWPwSk+gH/dKjMBFPHbnaYp8m+DWATaoV4UA08szuqxRV4eMK1ChyL816E5ffK3F6ab6pjGrfq1okMDXwsldRxP6AIaGCJRQEke++e/vbh+oHn3VLbOJDggaGAjLtltcRmtUaFuv4mJTvHWOPiq4XaClu8mQ7pRw9DXNNrH2XKRebm/x3hxGc9e4mYNCEeHgR1dmIFkcffYYYOHy81eWkKaQX28pVVhknkrxn+7K05o5CNfHjQ37kWvo6whwLWEYqKuRWhus6iZauY5+O1vNorlXDr6w8s0U3A2gpd7NA6Xk0A3UNvTu2DiaFpcYZpP1vt80e8NqwFEIcs3OFkReKIbuKSipoyS7xKdBCgqUNDEiiP09DwGhW4mqDS3QmAC/O9JECYV3HtKt+vIhP4RdqDep1iwyaazYKivrhEPkqzFtu/ZLKfJk7U9B8BKMCINobntDr5RO01fWuqGdBcrEcASFD1EddD5KDSZdVctlpr7IVb9CZgb/VLdohrSniCMWWhyGbhA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(52116002)(38100700002)(6916009)(5660300002)(508600001)(966005)(6666004)(66556008)(1076003)(6506007)(54906003)(66476007)(8676002)(9686003)(186003)(86362001)(2906002)(8936002)(66946007)(83380400001)(55016002)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y8rlvllhn1uZvd0r5O4wctgzSWRruXwU6b1AAyTQ5iQgFXtpLbsR25yEyNJq?=
 =?us-ascii?Q?AGn8CnF4QfvkmvAcWkaqfnb4a+hxQ1tcGocICmdrReH+PgStcx7i5jgoeeqj?=
 =?us-ascii?Q?LhVu9gjeMVRz3NZlfX3R+k2Mhe+yXNavIyX/XtnvI1x1CF9uAe7jAjtugS8O?=
 =?us-ascii?Q?HKFY9MqlqWyowu/TJOm4xnDA7s4btFENyh4SEhYVB15nihTdMucDT+j1lvbH?=
 =?us-ascii?Q?B1ToWoJly/BmKoMynCEK5bgFTxZublt5XekhTWy0oEn28qlGwC/7z9nKhteJ?=
 =?us-ascii?Q?cM6/5jlkSNRlFJwidIDUY3tTBPHJiI6QcC+MEgLrG3xR4IFmuNc7xAovJz9e?=
 =?us-ascii?Q?AvMkHg47Aho/hpiPYGRGGRYMJL389IyNUMn0AaiYXpc1tLhFC3L+BSPlRrgi?=
 =?us-ascii?Q?xPr45xoKtrqMjwMi76cHyU54aZqiiUW6LIM0KlIrAjO1PHzMP6tbj5xhCt0K?=
 =?us-ascii?Q?KH57E4He7w5TZkA2/eJC72iX5+C4c1TuV+j8of0Pp8MAwmV29B4We3mvFpAE?=
 =?us-ascii?Q?X4k08grXTetKrswpxlTao1RqJgEII5EDGgxVL2zLN38IT4y52p5Ew3obvqak?=
 =?us-ascii?Q?uXC4UJ4Fg78nQta231P5XaJbVp4xfuSF1/hdQWoOdFioC9kQhlF39FD0T/TY?=
 =?us-ascii?Q?Z+wSjI26Nv0mQM4Nth2GRO62kGgOUxTXfkRtp/oZ6w4J0Qa4FB74pqEkOOoq?=
 =?us-ascii?Q?AVAgyFNQHKXTECUoss1Rg8P3BwXLwNd1GKKq8OSS8VrgnCGLG+nw5ogRMF9Y?=
 =?us-ascii?Q?acRCE/R2Q+lCiykXnlFAUrtbzrlqHhC6WDhlCmpDb5uZvUq5xJEe9vp//Sq+?=
 =?us-ascii?Q?kv11jT6Qg9/NvSiArOgCH0a9iYKESm7mIybn0rHPc77n75nWbNjGYkDU5/03?=
 =?us-ascii?Q?puYewPggeyrlhqRQuoKlp2Lrzt4Aeka2+HPA3/lQ3nWLp65U/ElomOGUTA5V?=
 =?us-ascii?Q?V0qEciNbt257rK8eRBXclUgPGls8Mkg/78XbzOH5ujNgWHJjMfQ7RKLS9sJK?=
 =?us-ascii?Q?vfurx1+3YPK8oh/DbjGAWKkquo242q8bbFYq4N1qZccAS6vfeiK5/tJl+Dvb?=
 =?us-ascii?Q?GGOMNPOVi0mG2ucR0L1M+ZVd4t3u6jOV5xv08YpRazyhF5Y1UZZEvYPf/Vo9?=
 =?us-ascii?Q?4Pl66jh0twqDVhtN57c73w6XGvtn+ZtEisDsJOFYn29f7jbOtWVGiwGpL8iA?=
 =?us-ascii?Q?P3ez9GJJBb0Iv1a16vqzbUSo1aogUhsa7EtCzNNM3+TPFByxj3qvV1nk+Dee?=
 =?us-ascii?Q?IdVFqAvr7Xoex5Pn5Wm6jl0OKDvm7mVcwmVlu2U2AUBRNz0AcyMFI5VC+GkI?=
 =?us-ascii?Q?yF3AKrl6ERLuqDnQKjSMDybKq8NMmucApFGpJdikl4+WxQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6aa88a-23de-4686-5971-08d97e3180b8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 01:28:52.8833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNhup9ZnFeQdAG2mfbFXhj6MqV6YspQ+kq10j3KKp3qSrrzpi1DY2extfT3oEwzw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4239
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: kPo-ggnUzfpD0XTSouTXS3JEwHni0vne
X-Proofpoint-ORIG-GUID: kPo-ggnUzfpD0XTSouTXS3JEwHni0vne
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_09,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 22, 2021 at 04:07:52PM -0700, Andrii Nakryiko wrote:
> > > Please see my RFC ([0]). I don't think there is much to coordinate. It
> > > could be purely BPF-side code, or BPF + user-space initialization
> > > code, depending on the need. It's a simple and beautiful algorithm,
> > > which BPF is powerful enough to implement customly and easily.
> > >
> > >   [0] https://lore.kernel.org/bpf/20210922203224.912809-1-andrii@kernel.org/T/#t
> > In practice, the bloom filter will be populated only once by the userspace.
> >
> > The future update will be done by map-in-map to replace the whole bloom filter.
> > May be with more max_entries with more nr_hashes.  May be fewer
> > max_entries with fewer nr_hashes.
> >
> > Currently, the continuous running bpf prog using this bloom filter does
> > not need to worry about any change in the newer bloom filter
> > configure/setup.
> >
> > I wonder how that may look like in the custom bpf bloom filter in the
> > bench prog for the map-in-map usage.
> 
> You'd have to use BPF_MAP_TYPE_ARRAY for the map-in-map use case.
Right, another map is needed.  When the user space generates
a new bloom filter as inner map, it is likely that it has different
number of entries, so the map size is different.

The old and new inner array map need to at least have the same value_size,
so an one element array with different value_size will not work.

The inner array map with BPF_F_INNER_MAP can have different max_entries
but then there is no inline code lookup generation.  It may not be too
bad to call it multiple times to lookup a value considering the
array_map_lookup_elem will still be directly called without retpoline.
The next part is how to learn those "const volatile __u32 bloom_*;"
values of the new inner map.  I think the max_entires can be obtained
by map_ptr->max_entries.   Other vars (e.g. hash_cnt and seed) can
be used as non-const global, allow the update, and a brief moment of
inconsistence may be fine.

It all sounds doable but all these small need-to-pay-attention
things add up.
