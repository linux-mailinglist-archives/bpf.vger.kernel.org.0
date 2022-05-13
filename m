Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D3B525B20
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 07:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377127AbiEMFsp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 01:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353680AbiEMFso (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 01:48:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F59B5D673
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 22:48:41 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CNMWh6024747;
        Thu, 12 May 2022 22:48:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Ca7IHMicFHHlNeotvhbptgjEj0HdTvBP2bhj/dOTdnc=;
 b=fVm2WXSDH5jlPlhHYoOnsZBw+lK4yq0PQKli8oBUt5UL4HerwxPc3kPL9SjXb+nZRcfy
 +V3s7yw4ocQhqI1FqdnpaMPAXnuhjxFkS+punQ9j7HaaPivEfRNzz2GOeLnXnnDFEBTN
 kh9yqgZvKlQLKromBM1Lkx0dNlEiUkXH4oQ= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g0gatd02s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 22:48:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORDfGs0fEzRuTt7VNFYO7N7n/XW9JzfXIqi1fcYv/5Yey4Rr1yFQiVlI7M8U8HlX8taDucWM0jUJDtKSuTaUSto3LDUUaPlfF+ETYRcZXc58rAhzQDRNxLAvjXzVM017YlIZQftu49CQicZwsIaq9OEcfOFNpfbumbkTVhAkHFkr4b40K9ztwVOYn0pLzks8m74qgYxxYZUMQe5QyKjpJnHLjMl3zlyxcqKiEah8xDTot5BLJt15YQKRGTRh4BpD5lUoT/hYH9XsluRaYX/ThKnct2r1F6PkNG31RYWQOR7Ga+NyGQjEQuvO3i8iwQO67aCyAMRyDK2Wpcoz7xaEpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ca7IHMicFHHlNeotvhbptgjEj0HdTvBP2bhj/dOTdnc=;
 b=OjtI0e9J0UyNEY+Sl4bUWyfbmRdXp01N/UWNmFJCUENM2zFnkq0aDZtaC2afnqfe1/fDVgT1YBgV1Kq+u53LspY4V79HYfQLk5UNy/hgggejq/tTSWxk1lFi7sNx/bNG8sBEVnSIVuwr5IFzf9amMVhj87wfZrg+IMXmUkBji4wDOQ1fdDJQUTHOumvjZcUJ3b8ngrVPYmzYcA/IUBRRvlrZI8PkmaPETpWArcueSPit+L1KRB1DpcWISq/wnTDJq2i2aTb3dLg3fvewv2cY8whOh3DQqXhXNj0xOnQ6AClkuirddZim+JW0RDKJeUXss+VfmW7sAeAfgmg3fkFDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by BLAPR15MB3985.namprd15.prod.outlook.com (2603:10b6:208:274::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 05:48:25 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::f172:8f37:fe43:19a3]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::f172:8f37:fe43:19a3%5]) with mapi id 15.20.5250.014; Fri, 13 May 2022
 05:48:25 +0000
Date:   Thu, 12 May 2022 22:48:21 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Check combination of jit
 blinding and pointers to bpf subprogs.
Message-ID: <20220513054821.2zlsu56ppvbd5mqc@kafai-mbp.dhcp.thefacebook.com>
References: <20220513011025.13344-1-alexei.starovoitov@gmail.com>
 <20220513011025.13344-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513011025.13344-2-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: BN0PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:408:ec::16) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92552833-33da-431c-d6b4-08da34a4323a
X-MS-TrafficTypeDiagnostic: BLAPR15MB3985:EE_
X-Microsoft-Antispam-PRVS: <BLAPR15MB3985F7B6FDDEF9AFF89A75F8D5CA9@BLAPR15MB3985.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2kuDJWNjXYafV6W5synCCbiFGmQtNCnwl1nT0lHtNA3mvbLrSwhYNa56dALJG4a6+m6PiwwYHD+dreOCvl/KaNrtLRgN5IN6gw/zCrc12V9Gj2WCxogSY80MFhduwvSP+1nUPsHTBw6pUoPbfSqWKutO+4lj0bnSAKTzYjyosblDsyeyBTwzREp/ViS6mtrgPjFoljjifw6wk/alwbQTS75XduTYIr3PJUXI0ONACle0MPcIZd3FmcWXH25Jw+bwGDDFWtv8ko92oITVsHcSE3Vkr50hL/WfHh+dsyevAkxAJvx1R9hiG229erRQtpmOHrZBGDkhbM2LiSV4DpUNK40FUkGPOeU1+0L1VgPSruWPU0p3uFnXaHuit4u6HBmfcRN+rF++Mu/pztJZ3/v3PVSTirR9vfV8MxrjfXddMMvBfQPRIsv8K66z1hUKiYSk44pgJHmk8Y3qw/tCedKufqka+BXQfLHNwsyQ5ONTwnHRGa8Z3CSlQSPInGNQu9rMZsjPxEKqejS5mQS+9NH84HnZOKTKjN2U/bpjmCOWEs4vntmSyfZaiYhfevIawBf3g98Ve1NDw3E3rs0g6xBu+SB3TOKoHzd4h1Ldq9F33JepUlXD2iYVGWvxLyK6AOdODE+7GVR+uew19aP6Hcmag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6486002)(9686003)(6512007)(1076003)(186003)(86362001)(558084003)(6666004)(6506007)(6916009)(5660300002)(38100700002)(316002)(8936002)(2906002)(66556008)(66476007)(52116002)(66946007)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cA70RAJzZn0GS633wFUGpzmp2Z8MCFq43BqO6QlVTippe9CppdG3jcl/Eexx?=
 =?us-ascii?Q?sEb8LRiDW0ImzR5mXWDOjoG+igmhC7WqB6s3MhH3RJIqhjGh17/VaZZ9ZFBL?=
 =?us-ascii?Q?vmdnP16/pXh0KAqvSIMfRYCyUdlSHinqjpX/v3IFucUezwhfEMRALIbwJmD9?=
 =?us-ascii?Q?P/jp+kpec80sB/qSAJ73Gmmpmsmw9ADRCdpQPRXABf9XSCqAsu7u5/YwhBrF?=
 =?us-ascii?Q?+Q0+M3TbKEj4COUbAMgRT8Tziwi84oZxVPSjnqUm90ALi2/OEybuIe3YEsZV?=
 =?us-ascii?Q?HC4w+GomWgMYAxT5G2rpKkmn0NuzMJeGAmug5QLCcyyBPTFnc/6LA0hHMi4i?=
 =?us-ascii?Q?+uGuRzZhgCXwzmH7LSQJD1TWxBIiAChy9omaXxLaYtkllsND7bdiQtVOmgfO?=
 =?us-ascii?Q?jcLmAblTt99YnFWY+UoLBpiFuPSONhShdczHadYxXF0nmn8pubVKgd3tEosP?=
 =?us-ascii?Q?QEOM2c0l8ctoNitjvoh9iR2AAM6l5QlyR4U2c4XBLDiAsWaPIpzZfpdizfLs?=
 =?us-ascii?Q?LZaKDx5jGp+cXZYFCC34mQIFQlMo8GEL3H911lbKsT69NzB7FANPUbzwHLYQ?=
 =?us-ascii?Q?dtoiCPhC9j1NgtVvp56tbXoL/TrJBo0DOkFolFxFsKa7zg44gxbYu4rsJhAA?=
 =?us-ascii?Q?XBMI+CBpa6qW66L+AO/oo/EL0DTaMCJW+NPlEcb47vXc5j+8SycQuzJFDkAC?=
 =?us-ascii?Q?FacQQ6aAbKPX0Y7vA59EIrdO/JfPhifaj1yxH1Vz46++rQXvTjxl7FZIqGrM?=
 =?us-ascii?Q?o9u1Fhagskdx+xF1uV2nBnhyLSChQwqUSFb/a3fT12ytyQV6KrahnqCf0BXt?=
 =?us-ascii?Q?DVOWkpJ5XDt9bNsLt72eSa/sw77EG1/Eo5YQeUomZPo9fEcfCVhzPKWQjLhl?=
 =?us-ascii?Q?E1GmrFxie2IIsCv3KjFMN/uwNiRiUryPtJmeP3fjA2fNg1/TO+mjZEyAUvYF?=
 =?us-ascii?Q?O44dKLeG3UETzS7jaAdeyJHYLEYEOq+pFOD5Ju1f/zMw8gd0HGzuGZ6Z6HFu?=
 =?us-ascii?Q?YqIk6fgT073RKSCQdgGx2OLo2NTw0oRfYsUNDtNaNqJkI6q7Pj8Dipl2bvP0?=
 =?us-ascii?Q?7WR6oDIuUAe3ECw+IhPqm+lW4sq+G0Kr99kiuv94PLSjgEtmk87UrjCSqNQJ?=
 =?us-ascii?Q?zyAU13zVJRkp+9GnEgZjJgLfARsyMtTQCZuMGaprSRo1/zV5dw3HXMbWRtuv?=
 =?us-ascii?Q?OqGm0OxWYLlERta0pZkJHtuwDboQKAkV2E6eXNSn32bB00wvvQwqQd7oMS91?=
 =?us-ascii?Q?UDV/nr3+1VSdjGECXVHE18o8VYLSW39sWLqclJwumHl/8TQ5pk9XbUyUk/AD?=
 =?us-ascii?Q?dnmRuw/gX05G/hzBZ6+3Q4IHEmUrOM7x8dW0jNDXLqX8E59vS3vtRnjVqEcN?=
 =?us-ascii?Q?AjKNSyvEEekt2LQ9lUmvnlScUGV3YbV9S+SsM5+C0ruWqih/KGUUdYLbI+w7?=
 =?us-ascii?Q?AJ+7xyYUs79F5HbwC/66Tw1i3Ar/HMsXKji34qCaoLVzjKCLvwrNlzNQO66R?=
 =?us-ascii?Q?sI239aa59b4f1/1dHO0w7zl5WrS8Oa6RklIu+J797Dhk/uZrG/nSygbr1UO6?=
 =?us-ascii?Q?qJBP3z742tnxnx8Utj4q9xLoC/FQ3Jw+L9PjjtZdsAXPT7XS6BFH9TNfFeTx?=
 =?us-ascii?Q?t9RuNDNnidsjwyQAlpupxUgGOORGQNFIY6eaZbjxWLIX5hd3Yp0oJApRUS6Z?=
 =?us-ascii?Q?Idf34gppqJ97XOSmL40VuHoUu+8/TUH6RDy/9w9ndaphBLLZlAaecv3+XWhV?=
 =?us-ascii?Q?bGaS5SZXvIAJYsBbV+2dZL9weO42pDo=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92552833-33da-431c-d6b4-08da34a4323a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 05:48:25.0686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6F+OQg1h75PhgpIH0J3QNdO5DL7vH8RrO7VYi+307GiZAWPk4ytlXIPQjdt59bt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3985
X-Proofpoint-ORIG-GUID: 4mxY0RXNjgKJQaN-yPxx7Qax-tFx8mqb
X-Proofpoint-GUID: 4mxY0RXNjgKJQaN-yPxx7Qax-tFx8mqb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_02,2022-05-12_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 12, 2022 at 06:10:25PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Check that ld_imm64 with src_reg=1 (aka BPF_PSEUDO_FUNC) works
> with jit_blinding.
Acked-by: Martin KaFai Lau <kafai@fb.com>
