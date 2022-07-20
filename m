Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB0657B388
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 11:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiGTJMC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 05:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiGTJMB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 05:12:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D80B31202;
        Wed, 20 Jul 2022 02:12:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K7I1tY003844;
        Wed, 20 Jul 2022 09:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=OU8aSZ5MI4a6FFzceAFcB2XV4gFAzKv/17sBE0WVWx8=;
 b=0Vup+2hu83UE4/9jOaP5na7D31KWE71n/XFz8BR+rjIvAC6fw4mYiRIwcB8JggDE8wzb
 npXuA9H9Zg9pCSS6eOUfhUUtJrLqyieRqkD/kqgdpn1dlSv4KEtBYpzNFTMex2cDZ14m
 jtosFrqkmrGoyzAmVs9FMDrrPvIexejHOL/CYPHIK00iTqy8GDdogTLAjd8gDWe6Mcd6
 k7Ll8MQvZFj/aaKC1TF7PXF9FGuKpsiXJauqJhEtC7oW8kH/BXm1P0DVMP3dZddJycnS
 QPM0mL3NtHgqpy/sE1luiroZvM8vhUXXc9JS+wDB5lePAoseIgEO9eWDq9hbXRyWYd5a qA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs8vn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 09:11:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K6WjDg007868;
        Wed, 20 Jul 2022 09:11:37 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k44bnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 09:11:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bd0mUMfyygr3GUOHbUMHr8Bag4rPKgXPk+w07SVhKlmjWJLaOmArPz7m443FR1/4Y6/GGQ4IUzsOPKlR33stNT3MfTii4XYJ4amKsTpuZeHr6JV7gtD1cgCxEfAPlHh+sg7yYs1Z5mclI3yU0BVDugYOKb0gy/DJdgzCG4nVpuPV18ucfTi7aAGMIWKNvrY1LJtzvtD95bxtP9S3at3Ysd9XxiijAWrXMiUoNMaigwnpuP5IqyNghfAHvxbwnM6+3nCY+JZgV7ZdP9yP5fKc71fYFoh2EkED5OUC7DvpWO0s/JCQr2o/oK7C4JWfocMHjRJm4o3UHSvd3I223exSgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OU8aSZ5MI4a6FFzceAFcB2XV4gFAzKv/17sBE0WVWx8=;
 b=DnrnTnWxZk2SNlKlSBa8DQRtMOf8BjKJk8krCtdrSJNtYv2wIxRiRXRypLiwjJf21ol3bjp3Jb32+0pLJOr1usUCjxTUX/DU5K4rKUiEr1NqXodX3wfmdLvZqT9N9JRAsnIwS9PJCdhvcrwCE96mHl9lwDExTZCqbD8m3xSIHO5U6r8bsHoWP/GEgvXkioVUNMLcUX+0w8hPttfN5QSfV8MGWgpurRTSSpGM0F0NworiYFjiaJR+bz3a+XWTFxWa7YIpeOwApFmKpihy0VntDrZSVz7rX9/N0Sdn9PF7CHaHvVaSOsmvV7ZFvxryzl3oNHME98ju3wgS2bbaDQnnxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OU8aSZ5MI4a6FFzceAFcB2XV4gFAzKv/17sBE0WVWx8=;
 b=O/6jX4ItwWHKnpDzz6PXh9RH7r7Cqec4V2aHTCEJ9ddX+GzcvZr2qmoe2PrUUczU+cEPQIDPcxCOALGpwAWuCMwRGOGZDVfJFWSmMhAbbnH+tvqkqrMmPS2X4AnPumO1IDhNRoi65GzE9AOBqu8LSyWdZRr24yStHbLHLUJ0wnc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1577.namprd10.prod.outlook.com
 (2603:10b6:3:10::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Wed, 20 Jul
 2022 09:11:36 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 09:11:35 +0000
Date:   Wed, 20 Jul 2022 12:11:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] libbpf: fix str_has_sfx()
Message-ID: <20220720091121.GH2338@kadam>
References: <YtZ+/dAA195d99ak@kili>
 <20220719171902.37gvquchuwf5e4gh@kafai-mbp.dhcp.thefacebook.com>
 <20220719175048.GC2316@kadam>
 <CAADnVQ+5rZv4ZeuXuMwiXBmnPkbM4qXTx3-otheErDY971kgfA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+5rZv4ZeuXuMwiXBmnPkbM4qXTx3-otheErDY971kgfA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0046.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::34) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ed15df1-bb10-453d-ed7b-08da6a2fd7e9
X-MS-TrafficTypeDiagnostic: DM5PR10MB1577:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 75nr2lgqgsRAgG6gtm/AK41zbTUbvHoLWj1pou0NKXoIj2a6Voa9lN/c7dutIaEiaQbqcVBPvoaD0EVmrEN60I2CEaT+LgkVaYysI9bS9cCpuR1eGj7oM2RstVbHjHI1lwzyZfAbayIk38FHHToKplDnhuMMRKIRCrepUxgXOVSBBpd1MPmbGcCsZgNy44WbYGAK9PwiNixQ5Y0803lEm0glbP9b3wt56HeyJ4lwWasU/d4DUmL7o91yeNBfR/SWUT/AYVQ9xXM4Xmc9jiBxFngnzWliltu7DQSXFetydhu+asssrsg7pW5jfyl751NTWT8uqwFDHUYvtxojLHnbiLqLLndPQEYSaz3jZyjQBUb9Y5hSV36OY1/oUh0LyBklHV5J4wHrC+Qc86MuAegnooKdD7ywsel5MORj6aRapZIs+tFX/w1DmbcTE4W+Ugtp99DCImLwqYJXHVNUMYNodplM/l40Pfe+njCVCPNU54Eu1ZRmHTasfmKLaxWUScvDj8m6c1aexMA8fIX8fF8AHv/HokMUsolDVqrshBrO2fbkNYrn32rVFIV0RheOyqfaT5tfaYjmbwrHz7R6yDWoQj1+cMI4IJ88JwI9SKyshCTjvvUTu22WyA1RQ807u3SyKD8Aq2E8q+Vfu3PqL8Fc+SbD2c5+cHMUR7xLhFATl4b5H3E/clJfLe7bMGV1SwzsvXvkFtSZS2qCFULMghcB3PnbLvQwgHAXX3rLDut8napSNMcrMtR9XU6GsaDtLLw7B2/DfsTxV/SV6D3rVQzt8OlapaZVSnJ0uCxLLrsiBZc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(136003)(376002)(346002)(396003)(366004)(1076003)(41300700001)(6666004)(33716001)(186003)(9686003)(44832011)(26005)(7416002)(6512007)(2906002)(83380400001)(6486002)(478600001)(5660300002)(66476007)(8936002)(86362001)(33656002)(4326008)(8676002)(66556008)(54906003)(6916009)(52116002)(316002)(53546011)(38350700002)(38100700002)(66946007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L0NDO9JASR7dLpo0abXPT1RGHlr/6VSdBj/zXSd28Zr/mG1i6ZrqKnSyZDEf?=
 =?us-ascii?Q?rngN5bBQKJ5D/E+JA4iLWz6d6lXYF7a2mO2SO0dBh1HftWF8ATBStCarUdgi?=
 =?us-ascii?Q?KOBP2zQhER1k0jWrPRFhVfjV54Ixa8G3JxBsUebxUw9o8e6NQyuXocFnH3XM?=
 =?us-ascii?Q?9A+n2tFRt+zUMrVUogMzP7b/QAhIsC5fWbb2LP466sqN3NhkdSYmKHUwfGqN?=
 =?us-ascii?Q?h/+D5OF/HOvi7kF71c+Ex2J++NM5y8XBJet0zWx52o4sBE6uJAA1es3VhSfM?=
 =?us-ascii?Q?D7StL4VqU9PcOyPH+EsPxLFs5MmaaLpxCVDzz/gvLB//H4N2YQSMsIxR5SKq?=
 =?us-ascii?Q?XTjE0v0vmTp3vPU/PulRLyE87z8R6+HJsOG3j8/k3KalYnvOUDx+FrQMcY+H?=
 =?us-ascii?Q?sYLzytZVZShEnxUHv2ftWq/gh3pbl8WGT8yWQHHpbbH6CLupbdkeoY4asGwj?=
 =?us-ascii?Q?klI67lE8znVAlq6e1f/iAp2iNsUN/sA/4c+E6mBdlUhyWBtRet5b81oiGLx/?=
 =?us-ascii?Q?2tRrowDGTZuqHDtvEyPHoeYTsuZI2cX7M3bvTJrmjrhYLfzN6mb4jw5DGtQ3?=
 =?us-ascii?Q?DIoo/lRjLMM1phURHeNCzf41oD+S2I50EgzNbPcstoIIFXs3Si6XjEx0gID4?=
 =?us-ascii?Q?YJY5Q2k3Q9iIMoa4xneO4GxJlHm5aFPuiu8JvQIlVU7EaJDTSKBAPUUw+eXj?=
 =?us-ascii?Q?JCgG2wUJCwb283iiLHCYXa6X1+O8372TluRHs6yuXIdCfG0+9bMQwmfXFr0/?=
 =?us-ascii?Q?ARMNxW/Vvls94UXp2HkYX0wdx+E3fpOAnlwtSfufSDCIk1z5/hCvh5snc+kQ?=
 =?us-ascii?Q?UQIDfLGs83E/i68pK82yZyqGxqi74MuxrCHWiaDz8R3JOGm77rMFu0uzgQeB?=
 =?us-ascii?Q?6rpD288u9DW6Zsa7jZUe6Vr6ceRyHhE+vW3m2vRSxq8wtiHoAxdcu4MnKoPc?=
 =?us-ascii?Q?+Ombh/JZxYcz1R4L3CdvVNTWfMadRG0Hpj/CCkwJ4ApHzjelMzvoiLmfNtRv?=
 =?us-ascii?Q?/htK1zswJ/4elFh8epaI96i9BzIpN2mPgD5/fH3VpbBhaz0Ax0YNBh3527Bl?=
 =?us-ascii?Q?3tqKxEm6J33vykFtj0+ZlxhMLIiaMNs9EhHsXhW+g/S+WaDWBWnHg2qBPuK8?=
 =?us-ascii?Q?HAxqkjtQ9fsX+FjqSsb0MIRDC35Psvyi9ezRLFCv4rFZI9kaDM45GH2Dfgnf?=
 =?us-ascii?Q?8FcBsagM2b/AiwrSHjQK5VX5gWyG29++c6Z9pnb1BsLCZzTCf2HExxmxAz4G?=
 =?us-ascii?Q?XdAFMlJ+LOHJ0L5hgyF/LWIDFwQM3mKwsuqEyP+/I9YLfNxzgwFCG1nvkKmW?=
 =?us-ascii?Q?Glp8dRIBrizWkRueAmTUp2jf3WZWryPk/7lQ8kctcJfuueRf2qPn1JmLtpWA?=
 =?us-ascii?Q?eN1SNXnhVTYMj2ZnoaaE94fH4fJuipnnJ4TMYZ0XhB8IwwXSsId8C78Mx0zP?=
 =?us-ascii?Q?DGLkxlQwTAatBcMXIyK6KgYoJNkxSrVLFjiduzCcQoQUL4IVkJr+PtDoZ2bp?=
 =?us-ascii?Q?nZbAW94NzMfaj/Ali2s0PViW0t8yv6zIKdebW/GOwyiI5jqo8OiVrZo0dFQ6?=
 =?us-ascii?Q?DEwnyYTjLc43EU+0kVAgMYFbYoWgFIclz033KXa4uiL/r/ACsLRmWY6qjaAC?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed15df1-bb10-453d-ed7b-08da6a2fd7e9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 09:11:35.8222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PaUnAOukWIvQAAuux+lZzQbhxPrQamqKW0h/OZjI5ncMJ6fLk2bR2I+K84hVcsndYIf1G+Q5j8TEvlXJyyFmSzVbKOJlsrwOyveu68vkmXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1577
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_05,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200038
X-Proofpoint-GUID: n_Oj3-JOYBeR6r8n2EhYleCm-XLOkmrv
X-Proofpoint-ORIG-GUID: n_Oj3-JOYBeR6r8n2EhYleCm-XLOkmrv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 10:54:13AM -0700, Alexei Starovoitov wrote:
> On Tue, Jul 19, 2022 at 10:51 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Tue, Jul 19, 2022 at 10:19:02AM -0700, Martin KaFai Lau wrote:
> > > > @@ -108,9 +108,9 @@ static inline bool str_has_sfx(const char *str, const char *sfx)
> > > >     size_t str_len = strlen(str);
> > > >     size_t sfx_len = strlen(sfx);
> > > >
> > > > -   if (sfx_len <= str_len)
> > > > -           return strcmp(str + str_len - sfx_len, sfx);
> > > > -   return false;
> > > > +   if (sfx_len > str_len)
> > > > +           return false;
> > > > +   return strcmp(str + str_len - sfx_len, sfx) == 0;
> > > Please tag the subject with "bpf" next time.
> >
> > I always work against linux-next.  Would it help if I put that in the
> > subject?
> >
> > Otherwise I don't have a way to figure this stuff out.  I kind of know
> > networking tree but not 100% and that is a massive pain in the butt.
> > Until there is an automated way that then those kind of requests are
> > not reasonable.
> 
> Dan,
> 
> you were told multiple times to follow the rules.
> bpf patches should target bpf of bpf-next trees only.
> If you send against linux-next you're taking a random chance
> that they will pass CI.
> In turn making everyone waste time.
> Please follow the simple rules.

That's true.  We have this discussion every time and I always tell you
that the rules are untenable.  I'm just going to send bug reports to
whoever introduces bug and they can deal with it.

regards,
dan carpenter

