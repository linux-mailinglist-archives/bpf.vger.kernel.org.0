Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273DD413E24
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 01:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhIUXyT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 19:54:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41234 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229824AbhIUXyT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 19:54:19 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLH5c1009578;
        Tue, 21 Sep 2021 16:52:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=88JhlAvb3MIiN87QvSup6cy6uAj5RbzHMJaCrPqI5MU=;
 b=Vcc6/WnLGbwgCYuRwVdQg/pK2i8SRoMGdZRs4oiq/KgGrnkK0ceA+TAj5BO30TF4Am44
 lJ5IGP0IFF+KkYzHddL9Ac1mP6UnxRYcy3FTUr6rYnKBFc/dIw/yoIbDH+cfFcByGonW
 k0PeyvGY/VLCKOwBRGGEgyq5pR1D2qTY54I= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7q62gvxj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Sep 2021 16:52:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 21 Sep 2021 16:52:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em0eGe1WOay8svG3tb1Th60a/B86QjiKPO9at6SUoMPK8tdOZVZVWs8BR1cRYLSWJa110ZtHMMAgpme1BnaTjyJAQAYxVPfzNCVGFyY+jb1QNVoLFfyAHP91W8SWXi4zj3K6H6QnMmaGqQi8DcTq0aPVEIA5z5qdR2GN3LlxrixiUnSkLe+SsKnoSKAM05xEhL5jxunxy14RzlhuEwTx2Cede5xGNjA5wUpQaVXpbkkxOXF/g4LIT8j1aOf1C3MHPdqVB0+yt99w7DQBV8iHAMQV2cgWbaXK5Fg5OK6ru8s3JwdHzQq/tT55ZxkWRtiYCUl34tH8AXlm+zVAIeHRiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=88JhlAvb3MIiN87QvSup6cy6uAj5RbzHMJaCrPqI5MU=;
 b=YPF9MTCV+LhdWsXM+ymgEufVK+p5+cU/pdOK/D5xbfj1FnrM/+oCceMqdH7eCmaaXv1w8ERPRmys4Mr0S1+7bHO3VOVt/NW8jrEl4B16zgTgg4t+e28O5q5R7lFOt19ebm+sv/MtahZaa2JEWbiM43JI1a1Uophl+ir1BqEH72JsL2JNLROk+ooS27iW6OhCdFYSODPMNOWupzJOq32Xcug7mwxHWRgyiIsra+5zwXY358iSOjSulhC3glDpCc8p/j5HYDNy6OKLMR+n5mi0AZkg32XNpT9y5X+ZEZ2mY0FgoMVMlIda9gVvEg9DdppQwFOeh6vhhex7A0eXfc5oYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 23:52:33 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%8]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 23:52:33 +0000
Date:   Tue, 21 Sep 2021 16:52:29 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: selftest: A bpf prog that has a 32bit
 scalar spill
Message-ID: <20210921235229.6jiri54fji6kiipe@kafai-mbp.dhcp.thefacebook.com>
References: <20210921013102.1035356-1-kafai@fb.com>
 <20210921013122.1037548-1-kafai@fb.com>
 <20210921023234.pjnby3s4q4o4agwe@ast-mbp>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210921023234.pjnby3s4q4o4agwe@ast-mbp>
X-ClientProxiedBy: BLAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:32b::27) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c091:480::1:80ba) by BLAPR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:32b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 23:52:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02f5edfd-e9ac-4090-86fe-08d97d5ae13d
X-MS-TrafficTypeDiagnostic: SA1PR15MB5016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB50169676DE1178BAF952CE4ED5A19@SA1PR15MB5016.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UXKy4b3/L7Y6AJWRBKuP8mhVcHG8uLci0hM9hAdaMJZkbOuAXvLYlSDE6o0RXyE9jTqZ6ZM84xdamOcj3fy45Ib5egGIj08h6CciKTQlntV5LBLyHf9/M9TyuLXxqPqKCrHOL8b1XlfW4Vj4sjSouehaXHsea3eLUIoWCAxT+cNbdBIjuSi/XuVAxhfT4UMKUc8Bmj6mP+wAMZhQUERUhM5jj41p+lE3DMs3hyEaLQay8h1rUhERlv6NfdPTd1AZ0/VZRLNPDpzurhE1rRFLQulN5biyuPkqsSRsrUrgrdIujB00Z69/v1t9a+YEMBa0+0i2/rwcaX3oTXcsfwaBAdXbfI/pYy1UFCePHOS0tIZEtowRLqMZdCoR77sncdaRQiFCDW4vStwJrW/jxxZMHWS6H+zla6aivZjFlszzy0TArAzUMVD1F9pgQ/UM1JHxEJ9DRlYwD2eoQs6hqgNPqboirH6z6Yftj78R+/uA3c8m7TblVGkxN1eX5VsPm8X9VFxFT1Z48d58j9zhGHwJ9J0dBCs1BRuYWcPg+YFUSESeEH1QNnTB10FZxcAPvh+pDKhmml2FJJUS6NQ7xgcMFnqVG0peH35gpyQsI2iN8E+9079UUA1+qbk6piUHG9UnzP7BQDx2/UNlVGRDX36vew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(5660300002)(6916009)(316002)(54906003)(38100700002)(1076003)(2906002)(8936002)(186003)(66556008)(66476007)(508600001)(7696005)(83380400001)(6506007)(4326008)(66946007)(86362001)(8676002)(9686003)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mUXwLtyXds3eNR5ABUtump/drLKUvRCmKa2MoKPegvYUo0n/r0ImXpqT3LS+?=
 =?us-ascii?Q?YdLfsGyawNn9WolWfOiRsI1Z9HR1KPsIFltWXzidl3ndHgg/5KRROlGYpe86?=
 =?us-ascii?Q?SN1M4UNS0Wa/Q2RBizl0q1Vgx3G2JxPiqH5pFZ9VEDdeANSQxqfr6c7XyMcY?=
 =?us-ascii?Q?QfOqkaVRQ2cdvp8G1sWHquUoFV4FuaVT/+722dy6juKtBoTYqXgaFMSzRjAF?=
 =?us-ascii?Q?cBXSgjhmpZoXE+BkkmsxNKOBjhnQGwZdWcf9kYpJe14lYbDFWrwZn00CcG4H?=
 =?us-ascii?Q?nwoQnHCmO/V8CgDeaR8rLnku6asNblNe2dVdeKNqEW927qx24xMC2cRb5734?=
 =?us-ascii?Q?OtjWiJqkm8yFRUiIVToZYMvWs9qZ4vNNQVjwIW2eh4vgUaVmKNWjiqL/wxJE?=
 =?us-ascii?Q?2nAWCnfq9tP2al8EdUAy9i3hVj90a16hs3tc7okpcWvnn4yMJeH6e5SYvb3I?=
 =?us-ascii?Q?lTJnhz2tP6ToDnVB87+TFWdM6AMPsB1SUbACGvr7tXmeh9kpahFUqimkxgfd?=
 =?us-ascii?Q?9KrneR/Y2tJ1b8C5CDeB2rMyeChparJeOCXpBocJQ0Jlacu4539n7do3IWwR?=
 =?us-ascii?Q?fQMevN7nVemsHpSkSQcCTTeJUcDMm+6jPc73Tzvejd6DikQoaPWfPOCbMU+l?=
 =?us-ascii?Q?nPoPLk8TZRwfZYmyyPh4YUA56ueTf9H0l/HXsEQlXR5pu52xG/ESR+sa8aw4?=
 =?us-ascii?Q?ZOgWH4Z2fVeFwp62ARpReTCeF5y6+RQHI1aXg50PpADg/Y5eQCAdmTEzpVE5?=
 =?us-ascii?Q?nSQumzyU8TG2SbzzC3xTR4/69FWns6wgUiaYeM1AkVftsjmuQe6Tp1NcDjnL?=
 =?us-ascii?Q?5l/jsSBb5Y34PPjehHFOziXFL+INgRerXKETStKV9C5zbCHBg8op6GVYQWtm?=
 =?us-ascii?Q?o8Qzjlm/JvvQwSmQGi/TB1zY44I4UBp+yi2H0+YrqsnCfbuHQqJ1Iia+TJ53?=
 =?us-ascii?Q?0MQ/z7kNim74zfJaNsoEjsfeeGpKjZdswe7JE8NhaxGeRw+BWl4FOoHLeChr?=
 =?us-ascii?Q?zKzXEkEfYUn9soXWnsM4h22CVqMf+Sd8KKz3KcHecjWH4iLfaNjuPI1y7kOa?=
 =?us-ascii?Q?TytfTpBi6vr81fmrvjw+7aAkNpIUvSgpfooDcRMjfyVvFqwpotLjuvmDtP61?=
 =?us-ascii?Q?tDeYt2/0qT83EwfZ4wpC61jewVFAfT9KBOLz9g5Ne1qm59pcxXdm2UF/E9o4?=
 =?us-ascii?Q?Al4SrAIVlT0W48R6WKuaS2/pyEQ1Fs9yOdDMVy1DxLYTM+5KIxc6lpv7X6eO?=
 =?us-ascii?Q?4CedQ/m6xquHbzFmq/2Ysk8sqoRQyBhzERgOgluACGUqjCJAIfknxFYkBCaj?=
 =?us-ascii?Q?9962wrvjoM4E5ZbKrjvYJqNqsWfsmdzgRLVy2IDg6LhUaQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f5edfd-e9ac-4090-86fe-08d97d5ae13d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 23:52:33.2704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ud46ydm6fYSA+TXNuXkRVHpV8DsC8BoFx8Fo3s8SXg1cn8eG3iQMiu5r/WnkKQoW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5016
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: NxGh7nNePVdiuAAfdyGgVmDCtI9o7Ovr
X-Proofpoint-GUID: NxGh7nNePVdiuAAfdyGgVmDCtI9o7Ovr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 mlxlogscore=849 phishscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109210143
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 20, 2021 at 07:32:34PM -0700, Alexei Starovoitov wrote:
> On Mon, Sep 20, 2021 at 06:31:22PM -0700, Martin KaFai Lau wrote:
> > It is a simplified example that can trigger a 32bit scalar spill.
> > The const scalar is refilled and added to a skb->data later.
> > Since the reg state of the 32bit scalar spill is not saved now,
> > adding the refilled reg to skb->data and then comparing it with
> > skb->data_end cannot verify the skb->data access.
> > 
> > With the earlier verifier patch and the llvm patch [1].  The verifier
> > can correctly verify the bpf prog.
> 
> Let's land llvm patch and wait until CI picks up the new llvm build?
> Please add a comment to selftests/bpf/README.rst that describes
> the failing test when llvm is old.
> I'm guessing there is no easier way to reliably skip the test
> in such situation, since failure to load might be the result
> of some future changes.
> llvm version check won't work either.
> 
> the patch 2 looks correct to me. I couldn't spot any issue with the logic.
Thanks for the review.  I also don't see an easy way to detect and skip it
reliably.  I will update the README.rst and also the error message from
the xdpwall selftest.
