Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BAD57BD8E
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 20:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiGTSQe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 14:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiGTSQd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 14:16:33 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721F14E60B
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 11:16:32 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KHiokV015035;
        Wed, 20 Jul 2022 11:16:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Ii8BzBmdsCgpxeoVYIioI+sQtIBCqBeDhJY1Jz67HXs=;
 b=dv7WXZfiyTqQ+pTfCX2+0G7Dz+XFwROfJcXOI4oGUZiwwrgEAdTfSubnP8VudKcd40Is
 sy8EC4BRgSPlhJRBeCIVHxluvhkbqUUm1cltowsARFzAHUfIsQ8sQBPvyCuQo+9oc5UM
 3tHa9poqXqvlk/PNAKvfy4+alNTh7zUrinw= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hej1vj9qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 11:16:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aey8mSEKLSrdW6TLvF/kLaNfGTjWP8B0fd5BWVWLMcwJg8sJcUfJ+qmTxmkGjgv5z4NUbRRr7HCRUtp7gWeTPCnm4SXN2ToqhKvcaGXDLmiRsvH6lafZEbTHFmyTIUUM+RrLtgpRpFr37y7Rv7tRSI5UMPJrHFF7P9PyH7GlVlUSk9Rp/wMge2WqbgBnukmV3sczXQNHvLBwsQWapCBPcDPYrrzWyAyl+hVXK4kc6jCMNzBrwNO2FiRwvsRdwfuOWE0anRszwfgASbEzr2kpr/Vw5pK1pSl6rQk4St9iigtXTSzLNFjyj4Lol6KFsEieCUczrXqjZKy6I7aQ3pagDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ii8BzBmdsCgpxeoVYIioI+sQtIBCqBeDhJY1Jz67HXs=;
 b=IJBz0w2iwkxWs7kzOhZtrVADvD81pafWH8DAC8Hoz+Ume5XUM1YyHbV6qmvIOQshpLfGmqRrzQlRduSErFElAUaVF9VVMH2V+ND/ydnoMOfD0mocuxfDlL8rVuGjEyGE9e/ViDrHY3guSkv6fWZvxDGKaoroQ/DV8KLhdDug3Yd1Nv113Uz4lH2VaM+E3JAzN4kLmW2R5xSkuJV9idGTEzVjYccX/G9p1p5zSzwWpGcpWlQloNtu6+6grpKFW8Ms+0XlTvwQ8mfn5F/OaeBSVVpCX8Jrj+O0HhKa0MbFP2knoTO7RLcZPdrNj6iaD97vo93dFUPya7urEoL3vAXWIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by MW2PR1501MB2137.namprd15.prod.outlook.com (2603:10b6:302:c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 20 Jul
 2022 18:16:12 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2%8]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 18:16:12 +0000
Date:   Wed, 20 Jul 2022 11:16:09 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        syzbot+0f8d989b1fba1addc5e0@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next] bpf: Check attach_func_proto more carefully in
 check_helper_call
Message-ID: <20220720181609.eopn2k6ryif7wlr6@kafai-mbp.dhcp.thefacebook.com>
References: <20220720164729.147544-1-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720164729.147544-1-sdf@google.com>
X-ClientProxiedBy: SJ0PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::21) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f63161d6-013a-49f5-cce6-08da6a7bed26
X-MS-TrafficTypeDiagnostic: MW2PR1501MB2137:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 87iD8HwUG0xde7/+pLWI8QyJd1CCQ/u3tmvvfjcMeEFRGUGF9UNlUqP6GT3PV1e3hhi7Lf91jjXOE/PVPZ0PKsgKW+xTqWWesVvCTgIKzWTvNqETK/QJz0LeYEIPaPIDjjYi06ADev5qvYMAm9xznGnyiY4/sK/MC7ZYbt/EcLgeDoNdQmOwm106Uga6KidWaoq+03LspPvEBGzzRpjcJdL4NzL8tJ761P9BUMEZoGI/3QQoFLu9Ehi37KhneX8r544oeXAXGxMKOAj0J9hz0mjm7YaRO2E8wJrQeMk2iP2Iw1MXTYvEMOcZ9u1Zc3t8Zpch2SycRxsF13OKmzIZntlbr78LLGgZxEHf/+TqasOIw1HNj4HerCnYYgI9DN5UKR3YiobJxqbarwo7SreBYje5X2sXV6ij0Xd2V4OrU8kKsmfj6kyLM+CDJl+JxGuHB4lr8N8U7uBmQ4m3AGAQ+TZpNOOyJ2w5AFfrN1Ww5NgN5gva2vQTAaXEH8lQ0udRm14tNOEzJoYEJWKwkytDBnkiZsJ9xrZi0+xlPaEIDTSKJ3gRxB4LfV6mWGGUhtmKQP22ydKj5+kQ4aB5+mM0FLW/7QWCoX+o7PK1+vVtLorob33A7B23883B/fUw9IjTwE5FbGmWA5Qf4oZUU1zisI84yn6PVNnV1b1W4lNUj9FzgoMfSK0f9KvK0RMHZNJAz7qhjKvurF4H1IE0VURd2KFrLxLCyy+/iO1NM6VrWN00QIz4Bdru36kYM3oVoudX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(316002)(41300700001)(6916009)(478600001)(6666004)(6486002)(38100700002)(52116002)(6506007)(9686003)(6512007)(7416002)(5660300002)(186003)(8936002)(2906002)(4326008)(1076003)(66556008)(8676002)(86362001)(66946007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P5w5nnnf9T1VwrfFqTIs3eD550iz6Se4+6DQIQzPEZZE7jA4P9zGksMJphRP?=
 =?us-ascii?Q?TwYHExn/kH3z+FmV8E5Yi7d8ksU0Kptcm//+Rywh7yrWAOMJxb03e2gxJO1Z?=
 =?us-ascii?Q?6uUNdgrQvFj+9VOoXhJXultqreSwUGCKEfjIdQPVCkYS4iVh0V6lv3ej/fVm?=
 =?us-ascii?Q?K2a72spFWk/Xd9fKlcD7zGU2ca0dYcrYXUwRXfIEujOOXVCVGZVB1MF2LPm8?=
 =?us-ascii?Q?5fttgLlJ8jxm4A+6zoQuHkORzbHWFM4TfVEhu15eW5/Xa39IHXz/Y6Arc8bb?=
 =?us-ascii?Q?omIxYQy4JXG/dul/fUGU0QpujiyYRKQl/YD4foxPtEueDsd0Qpc5t2o5oj6u?=
 =?us-ascii?Q?RUYTBulnqalbr0PmF058d3HedH9+xTqX1yqU9iSbjLeWUnpceAC/FEN8szXj?=
 =?us-ascii?Q?BrrcqYyJQPZ8gH7L4Etzs3tVAOpj6Xu5aEE6LH36XodToHL9DTgQM7D8G7v/?=
 =?us-ascii?Q?wsYPXbrxpdANTEnE3CH5E+VDN+xz1OBkA1CXqzpLfcB40VkB2w6dY4OChuch?=
 =?us-ascii?Q?IW7kI1f0hlohyQZvUE5bek61z8eNgDau2y3Rq2A8x34JLIP+EMAgVbEMclA+?=
 =?us-ascii?Q?Ogm9ke28hIPDEH+ml0INM3p8z9ywpc67d9oSldzI7HN5usGvhncGkhDb+yxy?=
 =?us-ascii?Q?HMyrNiPN0n1JXBeMfr0xXCmJzBt8I3LnG0B+LYwpo8yp2dL5q6TBRegOII9s?=
 =?us-ascii?Q?Aw5xdv39oZ9Sh/lQ/4fiVi+HhmS4oo9EWhOh14JDV/PNeghukL0WA+jhuTf+?=
 =?us-ascii?Q?OKM/IUJz//ZsZTg5RT7anD/i/f1nRp1NzQhBqHan3PH+P2ia7BxuXdoLb0Rb?=
 =?us-ascii?Q?CPSLOUlbyMBrW+Qcw2CQLkI4QaTNST4Ydb0chDIXPtnpQyY/VF6nalyF7yVD?=
 =?us-ascii?Q?ejKNXNGGQt1hAnseKEjPHk31fl6SxD5GXzij/Ad46JDQ2GpKgLUfWwUXgNwa?=
 =?us-ascii?Q?YgVnqUbQ+E+Z7a6WxjL8CEhM7/jo8zor7rpsj8/Mym/l9paiYaYWkr1NpiYx?=
 =?us-ascii?Q?q5/IWcmPA/+h/t6I8J2oWRLEsrUerM4mVDFZWwqcK3hAd6p3aq7XuHZvkwON?=
 =?us-ascii?Q?wFNQdzm4F9Y2UalYN/AqwHVUmPtiTvbsjVaxgvfOslqkdUiuXFd2kQ22VeuX?=
 =?us-ascii?Q?3CwM8dxf+f/JcrugEs5VaryBrjjB8ohcO1SFsCEF5OYfA1CGmZy5Up/GeiHF?=
 =?us-ascii?Q?o998QJPfnTXGGlPZNow514Lob2w7GqlMDq0hKhAT+KEdCcZq7qmHhcM1XGq0?=
 =?us-ascii?Q?M3PUkUfWDJx95RzP6HhurBr7Sn+3eYfF5K/4TFffzqkRkhPO09xqZxYRBqKg?=
 =?us-ascii?Q?hX6LtgH//sLus+f7vRFK6YNIwENP+QGqH7gOEdeB0BB8qFuwcTQpCNyVQIW9?=
 =?us-ascii?Q?/VJaI6rNYO6Ks5X1UiHsewPFK34aQBcwQAvwgYUVYxmNUuDEzszD2H5fYMur?=
 =?us-ascii?Q?90xeLUcPLLbUnuYzofSspXP00w0Iy+OSmwNZVedM3LF1j0xUqvrZ5ZoDU7Bf?=
 =?us-ascii?Q?E01QMKocWlS3LRZTrWk8RjvmBZ7FJEQP97CjnnVokS8uh8nSC2Qk61hlk4Iq?=
 =?us-ascii?Q?J91yOCZzRZ6d/W+4QZhA4jF/p7oGBhwG4xhkgvpUymaECmwXGaGxi74VsVM3?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63161d6-013a-49f5-cce6-08da6a7bed26
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 18:16:12.1735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CF8cORNc6PWRileZUXQ6caOC1DBB/8BWdcHLvHUsKUx8sU1DCdZk4W9rLKq5BNc+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2137
X-Proofpoint-GUID: ePPtSeree5Rg6aAM0d4kT07SEmuRlwqW
X-Proofpoint-ORIG-GUID: ePPtSeree5Rg6aAM0d4kT07SEmuRlwqW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_12,2022-07-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 20, 2022 at 09:47:29AM -0700, Stanislav Fomichev wrote:
> Syzkaller found a problem similar to d1a6edecc1fd ("bpf: Check
> attach_func_proto more carefully in check_return_code") where
> attach_func_proto might be NULL:
> 
> RIP: 0010:check_helper_call+0x3dcb/0x8d50 kernel/bpf/verifier.c:7330
>  do_check kernel/bpf/verifier.c:12302 [inline]
>  do_check_common+0x6e1e/0xb980 kernel/bpf/verifier.c:14610
>  do_check_main kernel/bpf/verifier.c:14673 [inline]
>  bpf_check+0x661e/0xc520 kernel/bpf/verifier.c:15243
>  bpf_prog_load+0x11ae/0x1f80 kernel/bpf/syscall.c:2620
> 
> With the following reproducer:
> 
>   bpf$BPF_PROG_RAW_TRACEPOINT_LOAD(0x5, &(0x7f0000000780)={0xf, 0x4, &(0x7f0000000040)=@framed={{}, [@call={0x85, 0x0, 0x0, 0xbb}]}, &(0x7f0000000000)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0, 0x2b, 0xffffffffffffffff, 0x8, 0x0, 0x0, 0x10, 0x0}, 0x80)
Only BPF_PROG_TYPE_CGROUP_* (and the new lsm_cgroup) can get to
the set_retval func proto.  I thought all BPF_PROG_TYPE_CGROUP_* has enforced
expected_attach_type.  It turns out not true for BPF_PROG_TYPE_CGROUP_DEVICE and
BPF_PROG_TYPE_CGROUP_SYSCTL.

Acked-by: Martin KaFai Lau <kafai@fb.com>
