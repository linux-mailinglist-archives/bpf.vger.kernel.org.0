Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A315A72EA
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 02:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiHaAsn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 20:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiHaAsi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 20:48:38 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0674B4E601
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 17:48:38 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UMjHFW007557;
        Tue, 30 Aug 2022 17:47:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=BNc11tJ7D8oXMqjRQWuzJLa4XmkGkX4na1GIG2zUhQU=;
 b=OOj8KybhcPDEuv+T8HL3Z/mw82PVWXbHDit1Y2awRJjbppuuwxdFmhutDVwPDE4/C67q
 KocdsgkJ/epTm3r2iNZYylAhWzOzP0D2+nl71INcsarHvIkrJX/T8IyOion8/DCbsMp4
 n7//p9QUb/agL2z689pf/yKN35zYgDUuuX8= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9a6j6k14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 17:47:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaNOS+SnS79a2fMZW+seI0iBDu+ExaYb6M58DUU38PUuloJpUDXLE6vV8qAxJFQ+SODA0b8qEZngMZ5kEaEpwiq+qHmAFTmdAKFBQEplS+Ke9d/1LetXubC6bmS2pOeugVM03H1F4Th/zo7BLiJeiaeIpYtI4S5hmJSfcSItacH7ZW3euVUA6hKAatDx9jTf76qWIuSVtObWnNDoHnGT+EIZwTNAEanbmbNPkojGn7+NRHrnK9fTg7uHREP/oMwwW3a4FvPRti7filwEGvdryQv4JBBCsky2rfn9e2GlMVlL4rOmIcLmjGWECWezgHWvwKAR5zd9Tc3c5Lm9/aYGyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNc11tJ7D8oXMqjRQWuzJLa4XmkGkX4na1GIG2zUhQU=;
 b=gsIr6LbOv2t7G6YtGtFxQSRBN6l/YYBfGKdWXWPDs5YyUOmlHiO56DBQ66KdtktjsX/SGn/Zt4qc0kWbcWJqxYBtXTgFNkJRiHExcwlhTR0qlRK+AOIS4IUNTJ/QUJW5kWZu32VFSYqcp1Qb/nkBsCnCri84kOhi6SjXKmyXL//aV20KTsOFsICs+YF+HzGCEEGFnL83AwmIiIC9VKhiboKO/f9/qXKA+Gin1dkMueNts1ogthZ0QfhC3JSg2cdtBpAYZkb5LyUPKdMk35NcdypAnq15BO0l7grc7UqEZ5Kgfg8regKGlGlSu9RpLHfsFgImMYc48NLJHXmEvo8BfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BYAPR15MB2696.namprd15.prod.outlook.com (2603:10b6:a03:156::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 00:47:47 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e%3]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 00:47:47 +0000
Date:   Tue, 30 Aug 2022 17:47:45 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hao Sun <sunhao.th@gmail.com>, Hao Luo <haoluo@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Test concurrent updates on
 bpf_task_storage_busy
Message-ID: <20220831004745.zhic65iei3o3l7bk@kafai-mbp.dhcp.thefacebook.com>
References: <20220829142752.330094-1-houtao@huaweicloud.com>
 <20220829142752.330094-4-houtao@huaweicloud.com>
 <20220830011350.ig3djlqfume5wqz2@kafai-mbp.dhcp.thefacebook.com>
 <86429073-f29e-207d-9869-056c54a3ba04@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86429073-f29e-207d-9869-056c54a3ba04@huaweicloud.com>
X-ClientProxiedBy: SJ0PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::27) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e52a99d-3523-4fc0-66e4-08da8aea6c65
X-MS-TrafficTypeDiagnostic: BYAPR15MB2696:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXswyLYIU+a/NHRLe6EgUlrtZExBQGT6Y7+3LGVifcvKZSpPJeSzkw8eD4Uwkqmm6t1k6N11uQtqv9UZVEgvKXaWdqoRnOtdrQECeSki3mTioIKiKTOKeJQu8VuDJuRD3SaEBHZOldqPdQ7zj1kMSc9LgfoRSxiI/iJKsqu/bpudZf5IjStPI3WnwIw/zQsRltwzRZRgYUfq/HBVqenhYre2ttpzcyPsj4QzrEfqCqfaNvEHhA/tpX2nmMapxZaQGgjXVxQN6RqmZjYprsPUCFo0prOxZDFd3Ejam0rUZXz4ydCbzu7/K5PhSMu4cUgWgfSxRI3YJt4LOmRw8xQbRJoKMpRBeKX3v13VPN0YMlwR+0+8LCDQEZNfX+EcWC82ohV388fr2P65iRbI4rZWmTerRoSFeJdfCItqxjqgh5jdDNuk68rjJUydzOTjremp+GbV4T8WKqHVkPuqffSRbckNAuoWRBsBexnfq+NmJj04su6HxQI3ixn3P0NZILzpUvODF1gsilXknvxJ2/nXsAlqwyVgB0xUZSZdntQV00ihdB97ExvDtVJPRXjWjjF79juhYGHr2eCn2B8qVVM0b9CcDfyC9QTreGbINhK4y8TrOimxQZ53WWP149aEFJGZ0ZMriYijKuSrhUwMahaOMqI1jTrIaVwj22rc4j6dY58P/1PJRfhQX3shWnz9sakLn7yaYKJ2Tn35wOog1igtwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(186003)(83380400001)(86362001)(1076003)(38100700002)(8936002)(5660300002)(7416002)(15650500001)(66946007)(66556008)(66476007)(8676002)(4326008)(2906002)(478600001)(41300700001)(6486002)(53546011)(52116002)(9686003)(6506007)(6512007)(54906003)(6916009)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xxH61UKaUkYkLWNXu7/usaPocg0GDJWuM2V9Yoa1YSqNGUgLo895Ia4NCuzS?=
 =?us-ascii?Q?VqRZWBI+OQOuvekZ/MrAS7vp3gjvZIMyYAwRvd2+kBYLIM+9OU9Ye82KuBVK?=
 =?us-ascii?Q?umaLC4DycVrqpZvsKv4qvi+IWjn7Vwyf1udAaiAeKakfd8gDrYnHDU4gP+O5?=
 =?us-ascii?Q?h4cm2DbWCndJw3Vuo5BwVs+HkpiMn2IUXd2wCiVNT0d8D4W5RZTX9cAGQGeO?=
 =?us-ascii?Q?UIgk0Fj5JprKZoB4vFEkwb4a0dYM7ViAEfd4Ao/vqWRrRGM+mU9nKhXqav54?=
 =?us-ascii?Q?HB8CHOaVhJuQpOWYpa9giOYEfCbptwXGWTG6y3pIasmjocqS4TTdFcrlZ/wd?=
 =?us-ascii?Q?7pWkrPakoWYAuDCoH3AYyZ3nHX7Q5awwfiqhYH0tVIpJHXQsEk2xP3mXwM8c?=
 =?us-ascii?Q?aLMS7IhXC97J/dZOaOl7jPwoHTZ5e9hMuNEjh86OnuCbxpCRcji7TVkYjD2y?=
 =?us-ascii?Q?n/azQ53BRbk3Hc56qZjVLGvZaWQ+DHvjH9OAq9a5N+xpDO3Z7VE+d6KOlmwh?=
 =?us-ascii?Q?XFDlsHmub6LFr0Z3ZTcnrPHfeCJxtpYxEKaIHNAvW/hcpxeCr+lbM8wDVxAK?=
 =?us-ascii?Q?5vX+vh/VdKKPAJCbPrnvmISi+H46RWT742e+q/G6832/wkmFXXJNQDB5Ml8o?=
 =?us-ascii?Q?6NEfiDTU/crTA0dX/dX/unSBK5LWS03uzztvuWo5F7n3sqWeTW3vq+9sAALz?=
 =?us-ascii?Q?jSVirSacaiZTPRmD/iHj7r0aks8Hlan0p/ZQFMGJyrmm+vVuvi0YB3VBB3Ab?=
 =?us-ascii?Q?gynLwsrYtbJK4DzG1ZKqnY+DuFnSGmXUgcvMJbrvQF1WmXXsAdTVtFNDmQ1p?=
 =?us-ascii?Q?TXCSGeD9IaafTzXmiv+0k3JwhEHF4+H6rhjYmQUTyjJ41xOyUcSbmmZDIbBR?=
 =?us-ascii?Q?DhNvpZ18d+Lw3bXTFI9QHE3PCiRPuYwOR8zS37k5ZgqYUp7mt5tJAg1z7nMt?=
 =?us-ascii?Q?L1m82ttU76bFGRSK24miSdo53lzFg4oIdCdfF5DPKiJwmCAyual2+k7L6KNt?=
 =?us-ascii?Q?HvTImoMYuKOvcF5+wPUn5BXvC9tudXfjZ4yBq+zo3do/Kajezz4K10RZ95Ux?=
 =?us-ascii?Q?j2PHFIWO8D1fiTp3P3jVpEXlmSdDWFBPvtuHZfY3/HUQN5atIvFOECoJmNWk?=
 =?us-ascii?Q?Wiyb7Thr4BluE0+bLm77YZZtMr0BUxmJTrgiuvbOLv2a9BaiXKsrIxX/+5e+?=
 =?us-ascii?Q?bgM7ngmYxqKdV1nuU/RBuJjFNetkGKbKyzCa2gD70sOOpaT+3xfO5sUr1y7s?=
 =?us-ascii?Q?RFQAV7hSqcCZaMKLwFVHM+E9VR2UzwT2A/leIYCVsCD9jJ1ub2BsUD1vFpa6?=
 =?us-ascii?Q?1fEzCOuoIBFGEPb+h5XkBCeEBi7jE8nQrEHhBhBbs6goHj8sHb87RSTm3jjS?=
 =?us-ascii?Q?QRbUyUUgX3Kh8nnEgPqU3eGDVhfxgrHOFcrLByEVm6Kb/IF4+wnicIhLzSci?=
 =?us-ascii?Q?5lZle2zF44w3PXbJ6bo4MSpIEDZ0kV4fw/xSr0OasZovzWdpZaLK0niFUXaG?=
 =?us-ascii?Q?jaB6JeGdFnETdCm16URC3XyzSum/ngvBxXpzuI5+RAgYuB2Xl0Ei0wrCsI44?=
 =?us-ascii?Q?GLS7KlTPSVsNae6+TjvoqL+JBPka17YU0SDfeDm5NWFO9kI3d4/BuIDaRAZs?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e52a99d-3523-4fc0-66e4-08da8aea6c65
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 00:47:47.3473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j130T475ZBRHgbNLe7IwONpk1cvQxo2KmriW/bcC9RcMZ+AekNMOOEjcLytsexli
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2696
X-Proofpoint-ORIG-GUID: V3GbP2c_EQuvhHt1-oTAPZ3YtLSiCqxK
X-Proofpoint-GUID: V3GbP2c_EQuvhHt1-oTAPZ3YtLSiCqxK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_13,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 30, 2022 at 10:37:17AM +0800, Hou Tao wrote:
> Hi,
> 
> On 8/30/2022 9:13 AM, Martin KaFai Lau wrote:
> > On Mon, Aug 29, 2022 at 10:27:52PM +0800, Hou Tao wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> When there are concurrent task local storage lookup operations,
> >> if updates on per-cpu bpf_task_storage_busy is not preemption-safe,
> >> some updates will be lost due to interleave, the final value of
> >> bpf_task_storage_busy will not be zero and bpf_task_storage_trylock()
> >> on specific cpu will fail forever.
> >>
> >> So add a test case to ensure the update of per-cpu bpf_task_storage_busy
> >> is preemption-safe.
> > This test took my setup 1.5 minute to run
> > and cannot reproduce after running the test in a loop.
> >
> > Can it be reproduced in a much shorter time ?
> > If not, test_maps is probably a better place to do the test.
> I think the answer is No. I have think about adding the test in test_maps, but
> the test case needs running a bpf program to check whether the value of
> bpf_task_storage_busy is OK, so for simplicity I add it in test_progs.
> If the running time is the problem, I can move it into test_maps.
> > I assume it can be reproduced in arm with this test?  Or it can
> > also be reproduced in other platforms with different kconfig.
> > Please paste the test failure message and the platform/kconfig
> > to reproduce it in the commit message.
> On arm64 it can be reproduced probabilistically when CONFIG_PREEMPT is enabled
> on 2-cpus VM as show below. You can try to increase the value of nr and loop if
> it still can not be reproduced.
I don't have arm64 environment now, so cannot try it out.
Please move the test to test_maps.
If it is CONFIG_PREEMPT only, you can also check if CONFIG_PREEMPT
is set or not and skip the test.  Take a look at __kconfig usage
under bpf/progs.
