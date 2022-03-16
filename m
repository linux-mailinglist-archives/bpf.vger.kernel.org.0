Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3E34DB6F9
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 18:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345005AbiCPRTO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 13:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239155AbiCPRTN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 13:19:13 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5A11E3F5
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 10:17:54 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22GHCdZW013747;
        Wed, 16 Mar 2022 10:17:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=gO0qlDN1VLRARXqqr/XKqVLmH9tf7kuWS7OQBqW2bUQ=;
 b=nZB5dtfHzjszEfe8XP2CnIYhe+pCfKqPnFOFXHwechA4U+ujkk0SnJdV7cCElYbZMJSC
 F5NdOpgL6dX6zcAi8GuKyaKaMzBMNEHHj07RXOtwGJ72NNCelYUuZ+nU6SMGUmG6IHfK
 ABI3jHU6ctMAE1X8hQ3EyDI4BKf9I20oKP0= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eubhuut2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 10:17:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdsBRoW46Bnh8P8Ilrhgu1ahjRG9uwc94Gey8j4LBt7GDnM7/8y7OH+lhSYvkQPfKUhe0/5zNbnk8nRL2EAsv/Zx2JfVxR9yPO3kiXIDbnc7NKYdJE0vXK6U4bhC1wvVhQz+eJC3hD508Bun2iXzKdJ2NAh6cL2iTsz+qkM2SFAqfDldPerqBdAAF4Yp/eSValz24rtjp2Kf2eZL1VQ8tKGNfr6wNfwfw6ieEI0uWzkcUIzngDOErD2kknrlsX95vwoxQHAhN5MDfzdkje20k1q/0j6WkUsXjEAehx12j2tBrh+x+78FAPPCAoYVAZySxkdz62pnr+iU1WMN7iL3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gO0qlDN1VLRARXqqr/XKqVLmH9tf7kuWS7OQBqW2bUQ=;
 b=Sm9b+DaAAzdk26pv7wXSVfGhE2LfCTyVwG0b6ESe/xPOIrL3aeo9LAJih/n1OOlyvGyD41n2s6Qht+mzfZjBo5s/mEVEVZrfD0Sk4k8cB9ozKgq/R6UQfHu5ZldPmSrdENRy1MvUoBm6WLMvTjKm37QkT+JsypIvAK/XKKljZAvQwmV7sGmGQ1EptIkghOYqeINLfRhEpbpwdGFXx2R8pccVhtO+8GC3tKuREUwR/qnX+by3KiPBDE4OwOerzPPbYzfDrPXbKgXELYMi0qixJvkXPpTH/iyCOobns53T06p2BK4UVZKy+ntNik12ajaX5uomvrJnQEq8X0yqneF/cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by DM6PR15MB2748.namprd15.prod.outlook.com (2603:10b6:5:1a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Wed, 16 Mar
 2022 17:17:36 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca%3]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 17:17:36 +0000
Date:   Wed, 16 Mar 2022 10:17:32 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 0/3] Remove libcap dependency from bpf selftests
Message-ID: <20220316171732.2yonnhpynsyr6dwd@kafai-mbp.dhcp.thefacebook.com>
References: <20220316014841.2255248-1-kafai@fb.com>
 <CAEf4BzbcDJWy+JMGAawm5Q+_YOYjw6BJWOQBvLOZCmcjL5FGkA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbcDJWy+JMGAawm5Q+_YOYjw6BJWOQBvLOZCmcjL5FGkA@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0123.namprd04.prod.outlook.com
 (2603:10b6:303:84::8) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 952405c6-6cd7-47e6-0277-08da0770dd4a
X-MS-TrafficTypeDiagnostic: DM6PR15MB2748:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB274817BF9635938133EA6374D5119@DM6PR15MB2748.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWXsJm0YQln/vDLZe3QPqNisLGLKep/99Faq+QnebGL+RRHFWfe0unm/l347KjmW067JFEQsAGUxmBIVAuCxDnK84+neHD15hlYCk6vitCvl57iiM89PSoOUTkLjV3aJH/Xekqi9a7Eo5FaOl2GbBTINudQFHnb20bTC2a+V74w8ZUDneV1cJOdx78skICW6PEU6m4WYx7mHTAZS1u4vROEL6hPNaKejvHysGH7L/otIK+bKa5gydFUsXIn+SWgfAvj1GOfJYDLNXTFl2h8P/OgpwVCoUTHm7fu0fPVj118/wZBzHUCtiPXZyzjPmYszM65zqAD6H5ZkqckoyCx7xHPm47m9BAyV68KMJ05B8eJQ0Gkevwpv9GPoo4qnGz5m0QmT4ypom7XS1a6WHwnCz3iLExjMRuIFUpp2C1pRKNAFTxIPbl1tuneoBEL4ZPh9QhRVE9tdp0azG+B8qtV58y4bZ6NqafifduQOGe2arKCnFADUpiD0nVuDmI8DwA67UquBofsOZmGCB5/5JmsS8X4bBw9pUSFoB7D9JixDuQVl8Ck/TiY+92TxY39u1FomffAn8zsmQX/va9nNmkJ933sYVSf5s6ZzhkFrNtwzNcoLYjk5bTg3/4Ut44uY9TfGhNtGelWGH4FZ35t744IBPrH09BQmEPlDYPJL4pW274hnpq9mDfTOnA0qytmG0uWU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(8676002)(4326008)(66946007)(66556008)(2906002)(66476007)(54906003)(110136005)(5660300002)(186003)(83380400001)(508600001)(1076003)(52116002)(53546011)(9686003)(6666004)(6512007)(6506007)(86362001)(316002)(6486002)(38100700002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y+oX04e5/DEFT1BrK/ceU6saOriPz2vohFDDm0te256XqZFjPujE3Uyrg099?=
 =?us-ascii?Q?6iC9IwiwOMj9LeWVdIk30+A9xPF5jn/v/lMtmP22AtKRbsZXaYoNCd6F/aRZ?=
 =?us-ascii?Q?UWHxOIFfSmMmPmhmRsnp3wUL+i993UeOPVUqoX9OWE7Sm8EO0ok5mHm0PC2I?=
 =?us-ascii?Q?9y+nArHJudAl1EcVi2SaSJm+MLAP1bWs0xDyseiGh2FfvfBeJSqd3AaJQhaj?=
 =?us-ascii?Q?+ZBKc6DYyGMUSryi1BHQd+2Jdgd8y6X+HlmiUqiHooveyTSBB7GlI+NeckyL?=
 =?us-ascii?Q?zMPRBvMKfn40zvnNNZQTQLxw2mRzRHO14sQ5GGTueuT0Dj/tcWel/HJcghhB?=
 =?us-ascii?Q?HU2WDfJEdbGJkHae0awYw2ewmVKk+AB+sB2ofJ+uSbfa4B9XIHxs6JUlRa6S?=
 =?us-ascii?Q?AmLd6tfYu6FQGn0pRzT7e/68ckIFHuF5calauFijY2306zViz0Xc2uJ4SZDt?=
 =?us-ascii?Q?zgyE4XvAWSwB6OCcuzmI1YY0E8JnCAo8yL1M5N7jOiayokbrg559Ty45aaQ6?=
 =?us-ascii?Q?FcnDWzeHeSQeFR4CR3qu6mX7y3T6JJS1ged7jKnIlDfqUEkeZHL0jN30Ac5p?=
 =?us-ascii?Q?g6OATSv7w1ZF6W+vfYPCPvhsi9tktrDDkuNYKEbVe28tfelkKXKmt1TfL6ku?=
 =?us-ascii?Q?CU71Yi3/g3nhkD2m52aC3Gyu1kXy1mlttx4ad9cG7ALBMMUdvcG3XIy2pEPf?=
 =?us-ascii?Q?B8Av9GMoLA/6ZFWVIHNholjMEzXAanGvB1Nm817lgJgu3x73JUYBr6nz6OOn?=
 =?us-ascii?Q?+g97g/g5ziJvQ4xdterQPC7j2A4oeG6E8M6b2GAmSzAEsPnFwpvgNJqxNLZx?=
 =?us-ascii?Q?Bbyuwglg3QlSqjHBaBScYjq0yHMhMcKjqNvD+518xpK2DFFigaEbYbHfcWRM?=
 =?us-ascii?Q?JIWuFUPqzAWO2mb/LYiSO2LAUgGepkaF2JRqk42sW81XZcR0tEAKD1zJ5t7m?=
 =?us-ascii?Q?i092TjEO7uAfeiCFMbo9nopHiBaI6Mdmk2uVh2Tk2LzeEIFGNz9pdMhr6L0o?=
 =?us-ascii?Q?ReU+hjTnvLPhgaAhM2CADyF7gtthMwdcsd1n8KpHl/a5hVyhSynHOg1wvxv5?=
 =?us-ascii?Q?nhxEqJmkJwT2KFwM0ZZ9tT9S41LGbzUf2scp8+309SXq6NfKu/8B++DF45ux?=
 =?us-ascii?Q?c1Bro3bw9/ZaKsHU4plqv4idBDo3FvsNz+OI5uZXhF83WV363q/GiNZYcOsA?=
 =?us-ascii?Q?AZkZGjiScJWDGbfjdOlb8+GQVb3VjqLi4g7yPYlg36w6Hk5TmA50VrKXUgAy?=
 =?us-ascii?Q?8xO8dOstsdRbI/YyoiaM4LT2CfRYsvzSVHNje3P47FeEk+XJOuXkgLMW6DXz?=
 =?us-ascii?Q?kqWaqpkJpcMOiiJryYhH11PiPa5G+EbwDLz3696UTDTcjOLrOkUvUGfqji7S?=
 =?us-ascii?Q?2/8r09Ggvrm4IHLD/+xyZfRFgYwhoRVgrCqCeRWIxMyH7gQfy2MDHxIpnFym?=
 =?us-ascii?Q?voBOPE073XQZh4KsIZl7oEDF2mUSbFBAu5oaY/0xJHMwmug/brWLlA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952405c6-6cd7-47e6-0277-08da0770dd4a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 17:17:36.1547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlQ7A1o40RROUv7/yUP0uBbHne797XlKpiGJkXrluEyVDgjED+quAzgeCjJsnF+0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2748
X-Proofpoint-GUID: fzlOMRoIKwJCPgGKSa2QKjgWh7grxNFb
X-Proofpoint-ORIG-GUID: fzlOMRoIKwJCPgGKSa2QKjgWh7grxNFb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_06,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 15, 2022 at 10:36:48PM -0700, Andrii Nakryiko wrote:
> On Tue, Mar 15, 2022 at 6:48 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > After upgrading to the newer libcap (>= 2.60),
> > the libcap commit aca076443591 ("Make cap_t operations thread safe.")
> > added a "__u8 mutex;" to the "struct _cap_struct".  It caused a few byte
> > shift that breaks the assumption made in the "struct libcap" definition
> > in test_verifier.c.
> >
> > This set is to remove the libcap dependency from the bpf selftests.
> >
> > Martin KaFai Lau (3):
> >   bpf: selftests: Add helpers to directly use the capget and capset
> >     syscall
> >   bpf: selftests: Remove libcap usage from test_verifier
> >   bpf: selftests: Remove libcap usage from test_progs
> >
> 
> Love the clean up and dropping the dependency on libcap! But it
> currently breaks CI, probably because of missing CAP_BPF definitions
> due to old system headers. Let's add #ifndef CAP_BPF/#define CAP_BPF
> XXX/#endif guards for newer capabilities to make it work in CI as
> well?
will spin v2. Thanks everyone for the review !
