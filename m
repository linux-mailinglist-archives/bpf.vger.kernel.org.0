Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C2159A59C
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 20:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349790AbiHSSeB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 14:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350829AbiHSSdx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 14:33:53 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA245AA1B
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 11:33:51 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JHbTph032478;
        Fri, 19 Aug 2022 11:33:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=e8Qp+TP/QJUMTOrFO5rLvvTuM0F3enJtSU09DmPQKY0=;
 b=gb8Q0GeTZ78iOtc5StSx84YJT4JIzAh4HK8X8Vf2vGrU35vmZhFgZ+s6QM1V5vsFI5xN
 g3mE9V2qdgM7XPrJ7mxD1Kc58/wk+l8vOu5PChjHX+OLvi7G2PXJACk15KGebCW6/QGe
 0FrPlfVTgSPBkZ3Lz6WoUI+BoQTtaWu5YVI= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j2b9rjsq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 11:33:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEl11+LYQdQM57y5NiNqHjCeAbCeNdml9/7A7DG4bUnFCGD1mfVSD7uJfp1WlAQ005C4PBcwke5sxjDLvhQhTxat2/HTdsLMIb7oDlw8il3ctCbsovBf6KECbkWwoJOGoicKYG4Qperj3jntW2K/rYEpa+tFlnjdEq3mAYJzJyFUyo1N0Lrc3q5SNYA6a2NVzk7pK9UaIqlbuTD1GuMIBvx5EIQkYs2vuF4/4haNzj/21X+UMftFAQICdfteQvhJG6eQQZeCk7hie5e4f0VMGDVnDsm8C7vBlkHqXQSkCRL+7baI4KL27SU9gFs3aoAEENrlNUcBLLGE2ENBobBzKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8Qp+TP/QJUMTOrFO5rLvvTuM0F3enJtSU09DmPQKY0=;
 b=AYOS577TBxWKrjuh+cD0Au3D21yYFw3jvcaXCGJTkPv+wx5w649/LC9wsmtYliJBU+W+zf9MqqBeh6uWgYT93bQ6z7PTZpkQXtwJ3/vuFVHNgyMBGKp2WjkJ8DoFZw5HNlXjaCOesoWkp2NXMmSxfHBwqhYu9BrxTRx3l0DCHwnsjrEiRFpxXIWuBjy2IbVNYIjN5yOhysbiNi+O0qSpM9CXt6IfkC3fa5f+31nhY81hO5EltZIjfqfmc4WJhLZDVgy9A5PqaYv7OeFJ35E4MgzC8zpuqQdslux2ckJKuuAlAv0DAovYAgpjzO9VExUXnjMMJgHdgH+9uFjpZ5juGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by CH2PR15MB3720.namprd15.prod.outlook.com (2603:10b6:610:d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Fri, 19 Aug
 2022 18:33:33 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%5]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 18:33:33 +0000
Date:   Fri, 19 Aug 2022 11:33:31 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next v3 5/5] selftests/bpf: Make sure
 bpf_{g,s}et_retval is exposed everywhere
Message-ID: <20220819183331.vomzsfinylljrcmm@kafai-mbp>
References: <20220818232729.2479330-1-sdf@google.com>
 <20220818232729.2479330-6-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818232729.2479330-6-sdf@google.com>
X-ClientProxiedBy: BY5PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::26) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 846f0d82-5ec5-4b0a-4daf-08da82115204
X-MS-TrafficTypeDiagnostic: CH2PR15MB3720:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujKAEYIYkcoIJiwxlrBLusGGb697Y4mYyIzIF1bAXpLoKZVsiZGBBq4aVaIEeutwIkMl3YvM/G1FVOyCxK7oBYIny2wk0kxrbf7gHHPvHRq9PEYEtUnP31HWvJxcgvsE3E4Ut/rWy3YLLu2UH2kwdw8XjbUBjFGb/0PIv6MmyfaC2/Yn5Bz7U15/y4VcGd8EU6S2OGZCLQIsAr4+yrZzRU+PlpuO+pR8JZ8u0phZiRR6QwL6rl1BXncl9Bv9x2bghwqObvf8LoBemonUUYgFDpu3sr38JcU1JwKeVETTAkNyaXPWPeCsi6fxhEqylXFy+KD65jy0Y9bEB4XPBO+4TmcfvcUKwbPBlqN20zwSRDifiUIIILmi/HgnTNGz4PLhtWIYZCzuuqQyNI5D9+VBmU8xBi1WA9MkNMvjb778q3zqLzM6Np0vxQf75I2k8HENAdJzFe7+UoopaIdPrrwfFUXYGSzJ+MlbBXCL2eZtTpbVi4uk2M77opdt1HYVQCLLENdk7Zg27JuLbzQV9cBMqzKWea6q6W0K9nPTF4RgSL3s+N37OxiZpCmH8ST6c+DLsyOZMPkAdXPblRala6H9S5YqiLiTd3/1mUOQU9R3Q/M1sTODNF9HdqHp5dtP5rhwPjYMds4C3WH2+VQmn3v2VEIOAuaYZ2Klnv22jHa829kW/FIcoQTH3N54A8YFeo5PMppZ0tquNkEtEXLgoyfB7gyVpw/2o9r2h9yCh0Fp50IoCiK6Rzlfep0sWoUeXJLrLbDCw37SovDe1q8EQift5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(39860400002)(376002)(136003)(346002)(396003)(6486002)(41300700001)(478600001)(33716001)(2906002)(3716004)(6916009)(86362001)(316002)(186003)(1076003)(6506007)(52116002)(6512007)(9686003)(5660300002)(66476007)(4744005)(8936002)(66946007)(4326008)(8676002)(7416002)(66556008)(38100700002)(31153001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Ak8K22sEportsiUUS9wKA1n3pIDO/wckvbAcFYcvcpOydlI3muE5HywoWUe?=
 =?us-ascii?Q?dXfYPbvvpsRo5qBNnaw3tfjfhR8VSOW2rLRAcD5KdQtApmC+WPxP6E4HdUjz?=
 =?us-ascii?Q?iDig74EgxMirJ6G9gSDEfWflmY9iivwl9N7+2TPoaV3ndArI3bcoOE3tlCJI?=
 =?us-ascii?Q?9tP8Nb1N98sGn/onn7gy78lyPBlPFtTT9QvV1KzYvEFVLkqT/u7Wp8VSsj0K?=
 =?us-ascii?Q?XdJSB1wIwHToSGWMeC+DCrkd4lBZ4qMa9Z3ePCqXwBAlVJdIciVCUyl35lxJ?=
 =?us-ascii?Q?Q8UHlxax95ebS8Er21VrM05BZHjxGrtTYkloojmYfDKw+thX/3AUKCmWCl3k?=
 =?us-ascii?Q?TziygaDfeMtWuIK8l6IeTWXN/MSwjpfuSPqEaBySQPPBvuMVavwqP4fEwJ2q?=
 =?us-ascii?Q?CMlJ4Y7dCFxs5AsBjnfRYp98tiOjk5edVs/yjiIsaCMK6CMgBkFM+rG1ROuh?=
 =?us-ascii?Q?saZM0KTgJtMlsHm8/JQCvBuRlbqKF2baLAHctYrewnxMCk0ulMfQis8DECbF?=
 =?us-ascii?Q?Y7VCjQVbQz/R50C1K9e3YlAOhltGfYTc8JNTPA7fdimg2FBR2Em7tigWs9Lb?=
 =?us-ascii?Q?cC0kApjcKYy33IVXUh6DK/i8jgoz+HzZw+hiWyiCIk1NTzUAnVEMvAKQcV7b?=
 =?us-ascii?Q?ulR7iSEMimO9bXClvr6BoXJB4LFtd1gbhT/nRvzf5hX1Ldz+gH4KUhZZGbiz?=
 =?us-ascii?Q?S8T1I5qjZTU54K3AonVzsbgdkuFd02SRJ/95z0dyPbTNyBqG//k47x5OwcUr?=
 =?us-ascii?Q?PvldVYd/zCxaqjsIphQpUJwzo/kdATCVu6jEL2/4YmvpQLhAotmo8fFcPx3q?=
 =?us-ascii?Q?BnCoULe4i645a8ihPfwy8g3j2uo3d/BnBYBXppKOiAcMxy2rf42aR1TOVmFa?=
 =?us-ascii?Q?m3Hej/Nnypi7GWMQiREIFtiOQC2kPUj9ttVheReXYXUwPfJbA8aEafiQ1F3E?=
 =?us-ascii?Q?4SxCKcw0/+aHf/NkrKFOE/TI5K60MggB/o36scxm3u3jn/YTUsIK422frVf6?=
 =?us-ascii?Q?ZtjOPgVdOs4pceSHS2irWTRw7hw8T5A8JGphRLJ0xVi4C1r75tcQ82poo+lZ?=
 =?us-ascii?Q?EZEh1vhQ0ao2CwcuqLTlJqvoL4wXKicJHSW6R/lTOh0ewYHtGX2ord7ij5u+?=
 =?us-ascii?Q?rLWg+xL+I/1GFEYQC5OMNsCaA3y7q18LaHAvWphG3GnkiqYRDf2Z4jE95l/F?=
 =?us-ascii?Q?lm8HtA/GnxUG4lAbwua4qJmIg4pA0jJX1UsBjUfemgqkwBLfSjJxRuMgmIVB?=
 =?us-ascii?Q?CKpJnmjVgGpAZSVse/TM8voPVEIUKEdQkUCrPCVT2YNWZvgWRbCXcsBEOw6d?=
 =?us-ascii?Q?LiasHYMrBi0hgdYh686Z5B5zLf/Ux4II/Brds7CsQt1+jg4nMYc1yw4HTc9l?=
 =?us-ascii?Q?YPmxDiTrCCJmAwc8twP3tFV7+DdqFzJseV4yNTn5pLcTWWjb1mwhhmwVbTPS?=
 =?us-ascii?Q?WfmJ/f3x6W1E2QZ0QXsTjUiYoJkhgzk3nDnQFgeC2piaSd3UsgUPrhya0UmS?=
 =?us-ascii?Q?JS2t1PZlGwN/lBsFN3cLhGkK//2oGdQUNwF4pMyzUbZo5kzDWDn1z7VETHLK?=
 =?us-ascii?Q?5Z/ePj9Skcbh8bi0t6MQfUFL2/7q/YJ6eY39ubCz1uhBAssU6qV6L3PHgCtu?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846f0d82-5ec5-4b0a-4daf-08da82115204
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 18:33:32.9677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiLxu7rnHIVPTRqXB0PPUmuQh/rVo0DEPQQ5E+vGp9JhctCcwvE3XyiDxx8a+HZ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3720
X-Proofpoint-GUID: FfT3OVxrU2QrAqhOSNd8GDwqm-H9h8jg
X-Proofpoint-ORIG-GUID: FfT3OVxrU2QrAqhOSNd8GDwqm-H9h8jg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_10,2022-08-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 18, 2022 at 04:27:29PM -0700, Stanislav Fomichev wrote:
> For each hook, have a simple bpf_set_retval(bpf_get_retval) program
> and make sure it loads for the hooks we want. The exceptions are
> the hooks which don't propagate the error to the callers:
> 
> - sockops
> - recvmsg
> - getpeername
> - getsockname
and also
  - cg_skb ingress and egress

Acked-by: Martin KaFai Lau <kafai@fb.com>
