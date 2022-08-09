Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABDC58E00B
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 21:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343998AbiHITSv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 15:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348997AbiHITSE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 15:18:04 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C0AE59
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 12:14:31 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279EdZob011170;
        Tue, 9 Aug 2022 12:14:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=CNiMNh+lvknQEXaMNKyMTNSu0M951cx1OmRqhqaHyXE=;
 b=Hfs15Eon9xWml3pidADwP6l54ZWL+KMTPfd8BKJ3JlZAsD4a8Ibe7loCzKPQItA+Im/G
 COqTEamOjph3CQdgXcNX2PswK+9FiH3F8in62eCyRjI+dsShtKfcAPu74NOPq+tkGxI6
 nj9sw48noGprCdjouW//dTK0A3QhloOcZ8o= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3huagr7dkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 12:14:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBz1219Z7RRxTPtLvD3sAqpaNvBZZlV53oXZig5mqVRJkZ2UBEJk/J0o9dvFK+rtVgNnaUKbABkEdCuMAsLrDVTTNU1dos2ipJ2vaxZ/4H9ugALE2mN1ueGZ3Tq74o7pOq+gVAV0lQkGeiQrpKxYdObYz31EsCJ3OOoRBZ5khsx52TsQqts2f17SVD4pWirXPDSm6rymNgGBf9+mfTAS1H+Q2y/VZYSlVPCxIcthLexrHt39Q2s4Nboya9G2zDbYWL8xDleSLZPk3WfeYb1DPuXBlXyc5DOv9iOQXgNNxMg9aA9S2e0uTvGXxGOUcJk55GY3kNd8B/LsGA9l9HBn/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1m2k4BV7kaQgjxHlCKAGtet3ac0DxI/IgMPDRsqIU34=;
 b=XyyhYPY0HR0muHhkRw7nG3q4hqnEI8bmi0H4B0OTf8TGXIoCP7UjHtUQkHgslH4ET/c8QD5V5yr0S0n8a7WghyGWkMYlFk3hS5jEDx//T8Vn5iC6d5ZYrYzFyvCZX+NFrDOZ2/XXJD5r5uaWZye2OHO7Qo+RlDRS1krpPoLXbper/Twr3152y7u5wgpzWu6Skl8viDsLEa8HaRwHK9+LWimIwNX/LuNwszeld9FDzjj9RmE7HK2RQ1+bF9R4Nc+kSG6NcAfDqQA/m3xf/0lTeV+ZdCCBpE+weerLhfJV/o2pazvI9Qc/QCvhIYLOY0VS/pQ2ZjAj1KV6vJM8JYL9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4472.namprd15.prod.outlook.com (2603:10b6:a03:375::17)
 by SJ0PR15MB5279.namprd15.prod.outlook.com (2603:10b6:a03:42e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 9 Aug
 2022 19:13:58 +0000
Received: from SJ0PR15MB4472.namprd15.prod.outlook.com
 ([fe80::91e1:d581:e955:dd3a]) by SJ0PR15MB4472.namprd15.prod.outlook.com
 ([fe80::91e1:d581:e955:dd3a%9]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 19:13:58 +0000
Date:   Tue, 9 Aug 2022 12:13:57 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     houtao <houtao@huaweicloud.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
        Lorenz Bauer <oss@lmb.io>
Subject: Re: [PATCH bpf 7/9] selftests/bpf: Add tests for reading a dangling
 map iter fd
Message-ID: <20220809191357.ut6cza5x6t6ho4ej@kafai-mbp>
References: <20220806074019.2756957-1-houtao@huaweicloud.com>
 <20220806074019.2756957-8-houtao@huaweicloud.com>
 <32e803c8-4042-2d01-0249-b6358c0fb627@fb.com>
 <695edb91-dabf-2bff-9cba-12eb64162b1e@huaweicloud.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <695edb91-dabf-2bff-9cba-12eb64162b1e@huaweicloud.com>
X-ClientProxiedBy: SJ0PR05CA0154.namprd05.prod.outlook.com
 (2603:10b6:a03:339::9) To SJ0PR15MB4472.namprd15.prod.outlook.com
 (2603:10b6:a03:375::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a045914-df0a-46d4-c4b7-08da7a3b4fb5
X-MS-TrafficTypeDiagnostic: SJ0PR15MB5279:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0l8npXAb8BnurnLIe7r+0L+FNEm/YUpcrxi4zoHeSiD5IWlbf6lQ1fdAwf1CDHc01mDGbXDJzm3Z6SOVrTbfSP7k9P7O4KxuOYZwJlG5rWsZgZwn59dJ6JOWfUi5Mr0UqAPgJcV7WsRoalIQm2ns5KQAh3kmyEa3avmPpza39ogoxo9pJ6eHj62ZXOGanEnuKGgyngcIwfpbsZeXlN6U/Ih0AzsVrBLqFfGHegVmhFI8y70XbddZ95lHX6JyXEvwjPa7v6xyzef57G7AI6Y1/uwfgZmGZz1ZYeVY5VrSEVDKTdmRsGayEyTNBymQsx8YhUioIgMnJ7puPrL4/YRHOOMMNl9yRHk56GyBhybxcBXslJgXpTwElmwwiLBNyFjY/XO+4UrukmGXIu3Q/DDrfvQufm8/VRVLS7YItsThcQWCsan8IVWQgxGTIg7LlVl4+VH+CXN/0dFPjpANUcIFL3+EKk3cceqBlLEJiWcCMx6RwUiklbPiIV4IqEiTD+wIiOLJoKqODJzgLpfss6FtZ73wfqAOwlrInXGyRTzATzPB5/tL3oMLhAY8rfB78iMNqCoilGtZPhs87KQV72ArkMoqHHWstyJ0iDEoXh7v32tNOxlZTnhqaJhi655djNpsf9RGnTi+FPiabgAb6BOCEIhXANPiGa1Xp8QiuGVZg3PL3gh5iS2TQgpx22qfQNfHmA+8di9cVa8LCJGfJjBxEQ+9RH80MWOYSgELIwQsFpkXZOYephO6i3Or7Bi4PJQM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4472.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(33716001)(2906002)(4326008)(66476007)(8676002)(66946007)(66556008)(478600001)(54906003)(6916009)(6486002)(316002)(38100700002)(41300700001)(52116002)(6512007)(9686003)(6506007)(86362001)(7416002)(5660300002)(8936002)(1076003)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?N9MIFiDtyb5j2xSuO2/ziPhPi+eMOYUCH0oASgeW323+YPHZ1okcpS06qh?=
 =?iso-8859-1?Q?XHs7qaNtnWdgUuUQRc3jXrIIZ8C/s90eFuDWXaXMk6y+5ugO92/P5p54E0?=
 =?iso-8859-1?Q?04qFtUNmbeFRaZnU3zbqqSDFRjhif5haQVomKOsTtHLd+6LD2poDZ2nETj?=
 =?iso-8859-1?Q?WyvMSQsT40X7xyfnSW5UZIL+Z/HlR4BEfUqPXYQfw0L0HflFgSwvc8IBtu?=
 =?iso-8859-1?Q?eCnA+9yQqwIAv445jc31i0NoA7hnXS5W8cCK3gBY7iBbR7COkb8l9cFo5w?=
 =?iso-8859-1?Q?kVM/3RT+i/rV2wUbDuLTx/h7hkc1vi37FbvAbw66FvivymOVpkhM/eYQUY?=
 =?iso-8859-1?Q?OXloyaDzJ/TIDGNwZkAacD3nZfazlHnMnoT7NA1GpQ7tp0K+vfxCSZpElz?=
 =?iso-8859-1?Q?/C32I4CnndiLTilGXslXFOHkBGu3/IU3mPV0rJMgBM57J34n2U2sEfwj+u?=
 =?iso-8859-1?Q?eVmbavj8NwEtdcVS1JxD98IH8m92pBqW1nHm1XNo1nLBN5jXF6OB3fAWHS?=
 =?iso-8859-1?Q?M+XUROYwOlqSDcB/+QHIb7FePx6RrEzBoG+wJTVfUhyIGDIIjVPsZD4q87?=
 =?iso-8859-1?Q?f0FWGUeiclvb5e4Rq9HO3aO2d3gWokyaFm1nrm1j74U7ch5FQSs7RdAO/O?=
 =?iso-8859-1?Q?T71B1+DIb1MdKBoJeH+UVFaSDca9fu5NOz7DYz//TOtaTGKN0GTVlDkGbN?=
 =?iso-8859-1?Q?4aHvs3qfFOcGxV2F5M14nDvgZC3lyBKK9XJunxDwhTXNRpWJddO4IAJtZO?=
 =?iso-8859-1?Q?cUNJt2+XEZEmIbV5YGf1GuXwAJ1D77GRwJ/NNv2CQic5r5GV/3rV2FAd2d?=
 =?iso-8859-1?Q?CBOh/vDlWJIbXxbaeH+MdYspux/6i6T1YsZHOuJX10vCUxL9y8b1vF9nz9?=
 =?iso-8859-1?Q?4whja95TS0wpvTHakYr84tCE+1Gc0EAetlEk2hR+7sTRRjoOEhVcFT/CZw?=
 =?iso-8859-1?Q?0WBW4kptUu/309taDbJbgcHyJC8wx9tZIV/xNecJE68N1eCqlsUBRlYgza?=
 =?iso-8859-1?Q?LK2OP8HDkTJ+NYOniXcTdPrJtz6bLUx6Uh5VimtQr41CegG/HD0xGU+5bb?=
 =?iso-8859-1?Q?3HauEJehVTJCE2dweW6DeKM063ubbJtG935z1N5V6oQW/ayLTELSDKxFmx?=
 =?iso-8859-1?Q?NhpF8YVzwucareCfpLrNoJNVLgpxMb6oT/fJ/sHKTIzp0SCrTexB2hRP0f?=
 =?iso-8859-1?Q?eR6lADwvs3A5VsJeah3AFlUIuLcQmrN+uUWW3yO8vAUoIptMzQCdwuBDAI?=
 =?iso-8859-1?Q?25Gxudo6kOc4JoqrpmqfGw23iQT5pZkiTqI6hzSmMU2WEYkb24A6GhFKyI?=
 =?iso-8859-1?Q?q3UT4z4L0jPBuRpdk37xEDiU23uKWxkjKBwhEH1WTPo975OIikEO/buIYL?=
 =?iso-8859-1?Q?bmqMMhCOv5/tFs8SBuTMOzKcSaEwsFhUn7Rw+9nkLIFfrVrTzo+3oqEsj9?=
 =?iso-8859-1?Q?N2UgpBlugCgg9tqXcVhkyvo0klD2/xESxYn4jCfl04DW0ivypv0dM4LkUx?=
 =?iso-8859-1?Q?Ixgji1w/klP6G0QnNnxRoLtNYmYNh2Qo01be3TkM+yrfBBjxGZpoErloVN?=
 =?iso-8859-1?Q?ybzjxE07bahgykoL6yNrcdLuETgjXg9KLh5DEq5DhwHtNjO8E7EGEVLHOv?=
 =?iso-8859-1?Q?/UeCgez0SduWji1XnABM/+1cKoXMvM5eu98Sov8fjmAvT6Fz/wy49ZyA?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a045914-df0a-46d4-c4b7-08da7a3b4fb5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4472.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 19:13:58.6567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33XEnn8hXnNYmTf8SeHAaJCkgV6Aee131Jh5c2wKwvD4fk3iHVbhvojcP71qG2Ps
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5279
X-Proofpoint-ORIG-GUID: IMPrAddtwjy758Gn3s0G-sy_J-nj-iIu
X-Proofpoint-GUID: IMPrAddtwjy758Gn3s0G-sy_J-nj-iIu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 09, 2022 at 09:23:39AM +0800, houtao wrote:
> >> +    /* Sock map is freed after two synchronize_rcu() calls, so wait */
> >> +    kern_sync_rcu();
> >> +    kern_sync_rcu();
> >
> > In btf_map_in_map.c, the comment mentions two kern_sync_rcu()
> > is needed for 5.8 and earlier kernel. Other cases in prog_tests/
> > directory only has one kern_sync_rcu(). Why we need two
> > kern_sync_rcu() for the current kernel?
> As tried to explain in the comment,  for both sock map and sock storage map, the
> used memory is freed two synchronize_rcu(), so if there are not two
> kern_sync_rcu() in the test prog, reading the iterator fd will not be able to
> trigger the Use-After-Free problem and it will end normally.
For sk storage map, the map can also be used by the
kernel sk_clone_lock() code path.  The deferred prog and map
free is not going to help since it only ensures no bpf prog is
still using it but cannot ensure no kernel rcu reader is using it.
There is more details comment in bpf_local_storage_map_free() to
explain for both synchronize_rcu()s.
