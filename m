Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950A055525C
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 19:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358620AbiFVR0y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 13:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359637AbiFVR0x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 13:26:53 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEB727FCE
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 10:26:52 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MGKiBQ032549;
        Wed, 22 Jun 2022 10:26:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=5XpnYXBZ3g84i+/r1E0fu0yhrfxtGr4FfgJ2e356R8U=;
 b=bSruzpICdeDAMnn3iOfrngMY83lTpKFPf2P2ORAWPC91eiFzjIrt7xsM+oBJRDrBxkVA
 hH2t8ODPLfQKXWzRyW5aFcExaxS+57S2uZ6S618msiA7GwRkd7f1OpWWvX4GH5f5/HZV
 GjcBkgiY6nBOA63eUkTBb7oIzdx942m8wGk= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3guef4sff9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 10:26:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfBujuaGNcVkmII8lOxoklkwwVqWzZSJFtX2TEZqmMB0T0lGO/wxb2HexBD2RAHE1yuk4O3Wy8NyH2c/ghSNzV8iSIzwspVsn+LOb/HIERlN7D3JTL46Gy+ki1yJp7pIyNn8Ed0GmvoA49GgrtHPxHfAeJjhLAg1jtfaRunkr3Dnn6PBj1sCJd2Rf9e2ce149U7jws5uGnO2TFswyno7rrLiqxpqC7w/Hqm/AWZkqf/xHhbBEOHH/gqFtywOnaNW89yQaMTgwij18ghEI67Ke+eDiJlX0q2cKGsJvUOOOPO0tGSakuNFYguFf0c3T8r1By7/OgKBmrxXH7CFUqFeTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p16T5+2jR5KIu3KucR8UsWcxqfqSyUCRPLYfHPBB2Ug=;
 b=OViHq7PKSvCTtIPLLlIiDaZNwbV66UmlAfUQlEc6xfMW52x3Ta9XIFOZPphikD+aDZTbWWNkVytOtYb9nCsGnKEOBrYtPJ+FP2tqYEn2WlF1E2+3bGHcxGwhdtWNXj8kVRiEtDq0EpXc0BQ8IUcyKbX69EQdcvAaV6c6ufX7IKhe95Tw0O0ol5cwuLcTJmqLUQ9CdcQWQdFoaQxEJDtND7W6dQIV19t9MueVDxWRCUHZZkdwcNti4h9AU+EC3efIVVA9iVOS2rr0vu9YuUZpKExCXI+TeeCkzvyakMxd838GMaPFzHoKOS+aIRuhlsguE3XVJqpQmJGNygFYFrNvfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by MWHPR15MB1133.namprd15.prod.outlook.com (2603:10b6:320:24::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 17:26:37 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762%7]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 17:26:37 +0000
Date:   Wed, 22 Jun 2022 10:26:32 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v6 bpf-next] selftests/bpf: Add benchmark for
 local_storage get
Message-ID: <20220622172632.psejkta24nwz3k5m@kafai-mbp.dhcp.thefacebook.com>
References: <20220620222554.270578-1-davemarchevsky@fb.com>
 <62b21962dc64_1627420844@john.notmuch>
 <20220622002952.6334ieb3kfysx7vl@kafai-mbp>
 <62b2ad7a21e88_34dc820812@john.notmuch>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62b2ad7a21e88_34dc820812@john.notmuch>
X-ClientProxiedBy: SJ0PR05CA0120.namprd05.prod.outlook.com
 (2603:10b6:a03:334::35) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f51d5c27-e711-4ff9-a384-08da54745c32
X-MS-TrafficTypeDiagnostic: MWHPR15MB1133:EE_
X-Microsoft-Antispam-PRVS: <MWHPR15MB113357E8B1ED2409CE45391ED5B29@MWHPR15MB1133.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2uMJDf01c+8tTrs+rmB1zTbFTHCIUEV0fw0Edb8835ji7LE0okoZYB1lJnZ5hGnSc+D32eI3vSAiU4zMB91mjHGH/JabfFZGX2bmkPRH4JkYkep4meZYam+8WxsMysB9haaVjrCF23Q8bICPql5SItdPCIy4PKcDPiEoEjF1M9oWGX6nZDuntuYmYaFrSawGDOl2xrSQwFFGg/L6F6onFklLcvUGDwimAg+BpOFlmg9KgSLi/0VyGNl7kNkuI+bqdNOzuik5PESjNZVdNw/q+pJ6OIXaE4cH3evF9Ti1KXPk/mqjSwib2X43MOtELN4x+yzLle/0yE+GWsb0Sy7AYxVxICgmd4l6rbIIk+ySNbiidwv/KJQsPyUzud8Ep+hSL5+z3A/XJ9Lban9wPKPWDzobLwaZVAqqBTl5gvWsD1BfOmxngV/+SkYjaoRCcNiUN2/HPuvJVhawhdJYPBVfMcdDubac04QHe10/JwzzesrmHqqk6UhkUCSOvI7IBCzeQmNdoK0t7gyvXfbNsXHJpSoEv5w8GLs36qnVxxhbovfdqCmvZSzfpRwYJhOCkJZaeBxvfwELXtyAbLu4vN/wZE7tj0ntLS/v7fLxXwSGrTy1gON9GYujo5rj1Xp54motcYzK2nVXa/TVnAWc3l4GgaqJDT7doODkrH4tun4vIIJatMvQdnBcRXtS7+RGTkrBr+fEaNGWtamTkJGjv68wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(8936002)(6486002)(6916009)(86362001)(9686003)(5660300002)(54906003)(478600001)(66556008)(6666004)(66946007)(8676002)(66476007)(4326008)(41300700001)(316002)(38100700002)(186003)(1076003)(2906002)(52116002)(6506007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9+/ebSP87SoGLIK5vp6MbPCC1ExXXWAD+Th2JT5a2xmikv27zCYsLYmC26?=
 =?iso-8859-1?Q?BvQY7wrXhaHt8ebTMLmZ/hDjPAhOAJ3s0NAU4PTBg0WoKzQA6z7oZEcjL5?=
 =?iso-8859-1?Q?KOCrj57d81FxFjOQqxluzdE8Y0xtX5ogtm2nd+0r6mtmMrnlZ5WdT8IH6L?=
 =?iso-8859-1?Q?B87ZU7fpYfsF4b5VEabralZMe/MMPZVq40NxFkPPt/oIj94YCjdYC1qMi8?=
 =?iso-8859-1?Q?oy4vwz6Kx2gxhu4zGyRTaVVKb00x1XKpZrJ0LSVZix3bBB6X8bxJSQNQA3?=
 =?iso-8859-1?Q?BnohWAN62y0rJ/y919pJsOgtkNfoaZCb3sRx29kcfZ7yg+A+FibY63jTA4?=
 =?iso-8859-1?Q?3nQR31A6QoYtb8RBtpDsO96/y9nzB/Ur4Z0ukD8kljcKwAAbDfPRJe6Ulm?=
 =?iso-8859-1?Q?/FYMoJ4KyAbW6FVB+lnOle92WxDPU+3Q04IsGdxp3LT1iVJcfR5WLmmC6E?=
 =?iso-8859-1?Q?qkuMo4p13YoimarQPNBL9o0k4rXdz0qYZiZNNc4yRlfSsWwETwusJBljBj?=
 =?iso-8859-1?Q?T1JGS3Jgl5Y49DM/gRebDsUYaywBz5oyfVjGbnnW4uMpBA39bPRMu6ACu2?=
 =?iso-8859-1?Q?lQmY02YN1fWJaeF/pRwXoGsK9zNZIdKxRjUpOXCUr8u4ZyYJ6GnpLRcNYO?=
 =?iso-8859-1?Q?qwtUKhgbv71ptTCPlpxM+B7w9KucVJDjzwNf82cuXNooPXe/CmQhJxffXm?=
 =?iso-8859-1?Q?kQO3z1h/DpjOo0x+it0+y7B5fXwBan/IvPGIufMu3NcPBYgIOGWV0wzY8K?=
 =?iso-8859-1?Q?09izSKcgfbYIvP3+fp0l51rosr1eN7LVerStgdcLXcjh4JBP9U6EliPvxm?=
 =?iso-8859-1?Q?3TYMlIj6zzJaGvOcPASKFO7vP3LXrgtyDJNWi/TzprtgBbu7mFaH2v/XBh?=
 =?iso-8859-1?Q?fKIFxiwLLhmEGzF8+It1cUPYU2bo49E6YoQc+evYNRZ7Q3Y3NQx0sDCnir?=
 =?iso-8859-1?Q?8StEFTTM+2cyZrCsGyy7nfkfSkcxeLrWKeG2l0UKBbQeStAhBm9q91VQy7?=
 =?iso-8859-1?Q?tnnONSeihyHmUWdZmZSqNjrNcvNoV/QUrZlFbdcDytgs6TglPu5SH8LfZ/?=
 =?iso-8859-1?Q?s33GabYjCJG66PzgIXe828ur0LAYiWgPQftWHisADU6iygc07mnhNSUsOS?=
 =?iso-8859-1?Q?ZjNateZS6EX/7cEDLBdmXvaAB6mBs1laN/2FKVK6trhzEEnn38GLSmGov0?=
 =?iso-8859-1?Q?J2NIDf/LYQ3sDxLKU7NpbGBCnCvCAKfH24HL+2DruNid1F1+kw6BaSh+Y8?=
 =?iso-8859-1?Q?NkB39NMyqCPQGNUCL6MpmQAM9V8hek7nZ935ulFG7tPYcQ7DGHWp6PvEFu?=
 =?iso-8859-1?Q?kMINEZo/Y1QdV7ZWirBKAc4JAnqu/ryUTkKGMY213F9P1ey6W5G2Ezyvsd?=
 =?iso-8859-1?Q?DTvk8hmRT/ydvjh9B+gMgCnfp5BFRlVXZnZjRxlFZ+TN0PHub4NupOJ9rk?=
 =?iso-8859-1?Q?ebd4EwV2fAVZEShLktemQIFEhZrNy1bQxEVhuj0j5FhEDzzUsOBrGQuCJx?=
 =?iso-8859-1?Q?53BWCT1jOzFuaPgfzOO48fk4NdeKO95PZZqBzZIQYD1GGoeFfUKnrOetVj?=
 =?iso-8859-1?Q?KxSDfShKH9Reqvle0hYJcFCOjg2gCkgsJ0DxxK9pbon5IdsufN/9je+yiH?=
 =?iso-8859-1?Q?56yRdsAKZKi1Ad4oD8uWPiucI6qrkZp42wCxaDOmXCKaUjmOW9zp7s1WMD?=
 =?iso-8859-1?Q?Xe6KHv5h1w59YQmBvxr0wpLafAaaE+5TuIgUB2bJYnSi7cpW6PStewSwUb?=
 =?iso-8859-1?Q?ZgsZxs175wBVeqU7mMhO/q5t4HPGlj5H5EwT1ZiMdzsAUG3Xrqwc1TWgTR?=
 =?iso-8859-1?Q?1xS617QvrofIeK7aUesPEmWW0IvQWFU=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51d5c27-e711-4ff9-a384-08da54745c32
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 17:26:36.8764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1HQlnj3VdpOkv4hK9FfkiJgesMyYqJVGCiR5I5qPqZDhCICJ3lyQQ0TdLN+dAVw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1133
X-Proofpoint-GUID: CHpSKBpA8S-eW8-cKnf9rlCANi0OINUW
X-Proofpoint-ORIG-GUID: CHpSKBpA8S-eW8-cKnf9rlCANi0OINUW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-22_04,2022-06-22_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 21, 2022 at 10:49:46PM -0700, John Fastabend wrote:
> Martin KaFai Lau wrote:
> > On Tue, Jun 21, 2022 at 12:17:54PM -0700, John Fastabend wrote:
> > > > Hashmap Control
> > > > ===============
> > > >         num keys: 10
> > > > hashmap (control) sequential    get:  hits throughput: 20.900 ± 0.334 M ops/s, hits latency: 47.847 ns/op, important_hits throughput: 20.900 ± 0.334 M ops/s
> > > > 
> > > >         num keys: 1000
> > > > hashmap (control) sequential    get:  hits throughput: 13.758 ± 0.219 M ops/s, hits latency: 72.683 ns/op, important_hits throughput: 13.758 ± 0.219 M ops/s
> > > > 
> > > >         num keys: 10000
> > > > hashmap (control) sequential    get:  hits throughput: 6.995 ± 0.034 M ops/s, hits latency: 142.959 ns/op, important_hits throughput: 6.995 ± 0.034 M ops/s
> > > > 
> > > >         num keys: 100000
> > > > hashmap (control) sequential    get:  hits throughput: 4.452 ± 0.371 M ops/s, hits latency: 224.635 ns/op, important_hits throughput: 4.452 ± 0.371 M ops/s
> > > > 
> > > >         num keys: 4194304
> > > > hashmap (control) sequential    get:  hits throughput: 3.043 ± 0.033 M ops/s, hits latency: 328.587 ns/op, important_hits throughput: 3.043 ± 0.033 M ops/s
> > > > 
> > > 
> > > Why is the hashmap lookup not constant with the number of keys? It looks
> > > like its prepopulated without collisions so I wouldn't expect any
> > > extra ops on the lookup side after looking at the code quickly.
> > It may be due to the cpu-cache misses as the map grows.
> 
> Maybe but, values are just ints so even 1k * 4B = 4kB should be
> inside an otherwise unused server class system. Would be more
> believable (to me at least) if the drop off happened at 100k or
> more.
It is not only value (and key) size.  There is overhead.
htab_elem alone is 48bytes.  key and value need to 8bytes align also.

From a random machine:
lscpu -C
NAME ONE-SIZE ALL-SIZE WAYS TYPE        LEVEL  SETS PHY-LINE COHERENCY-SIZE
L1d       32K     576K    8 Data            1    64        1             64
L1i       32K     576K    8 Instruction     1    64        1             64
L2         1M      18M   16 Unified         2  1024        1             64
L3      24.8M    24.8M   11 Unified         3 36864        1             64
