Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9E13D018B
	for <lists+bpf@lfdr.de>; Tue, 20 Jul 2021 20:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhGTRlg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Jul 2021 13:41:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31936 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230503AbhGTRi7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 20 Jul 2021 13:38:59 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16KIBBGh013227;
        Tue, 20 Jul 2021 11:19:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Oqo2HTC5i7DYwGCuZ5VIZAgMnmQC2uoWHSJTGNZwsuw=;
 b=o2S9+KmVSt2DeOSXclhXfJcJwSTwHEYGeP/ZCP4pCooyY5u/EYAPAkhh8xKFzo2bZOi5
 A3mCjCGPgw6mWAUA/QPe79pRoMdx+QpEQ6F7G03dtQDlgPkE177qamezZbyxoJvWLx1L
 5Ro6vJUg80Lzp9Oi8/V4dwAbPDrPjoZvwYk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 39vytcb8h9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 20 Jul 2021 11:19:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 20 Jul 2021 11:19:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bq09HCaYJZ6RZNXCsYp/VQZSe7GIC6pZEbfl95da8zUJfZ55Sq8wcZoPzmSmKYuxq9ASR2q+avnuEXm4D+kraaFSxq6YTn5lr22vRQ6NIYkBRI86sXaUL6bgG9ulXFfsszZd7xve4uk0W/5W3N5IxlmhsyIxEZ9JjB0PWV8//hBFIXHuok8LwyZxGqR0ggIRWbp9BwoUSJl4J4KQHgp79d8zZiAhglMiLzLKXQqaXvl+i51gv9VooGmW2qgfezS8QOONwyQ33GCKW4Xhbv4l0M0pCfZyOBy+Qx9aPlvzZVWHjubHzfMG7dNAFvlAM8CtSvKZ+5bpfMqeLR59LG0laA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oqo2HTC5i7DYwGCuZ5VIZAgMnmQC2uoWHSJTGNZwsuw=;
 b=czYfQz6Wj6Xj5W583FhOIsW8ppLPwYT+PAMnNJ0RhgPEK26ziP/kmi3jYSOaU0MXo8ymFiz3Mx18NJ/RavyFKJ7vMzUm3Clsly3hUelflnbRH58fl7cja9JUPA60eKIGfkT0g3CLvzCZNFV8d8aqqWJqs4Tc3OH3+6K5C3HLROMj9lBef2EYFWrMcWVMLHTSEyvo1mrTtAN6la0CGIMduqsVs0T9PVULeHoQ8R3fxLKXw7dhXhOYAtjb5xh4dIi7Ump98TzdE8yWKAOVRLcwN8lGRY0Ip6K1Ga+gOUKZV0OGZPpA1T6Po2L8foWyQR3aQXrN26vJRzrYLE81cHTBeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA0PR15MB3758.namprd15.prod.outlook.com (2603:10b6:806:81::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 18:19:15 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1b5:fa51:a2b9:28f]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1b5:fa51:a2b9:28f%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 18:19:15 +0000
Date:   Tue, 20 Jul 2021 11:19:13 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Vincent Li <vincent.mc.li@gmail.com>
CC:     <bpf@vger.kernel.org>, <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next] selftests, bpf: test_tc_tunnel.sh nc: cannot
 use -p and -l
Message-ID: <20210720181913.ps2qj7ttxszijv5i@kafai-mbp.dhcp.thefacebook.com>
References: <20210719223022.66681-1-vincent.mc.li@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210719223022.66681-1-vincent.mc.li@gmail.com>
X-ClientProxiedBy: BYAPR08CA0018.namprd08.prod.outlook.com
 (2603:10b6:a03:100::31) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:e784) by BYAPR08CA0018.namprd08.prod.outlook.com (2603:10b6:a03:100::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 18:19:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8dfe247-e979-4a8b-55c5-08d94baae1b8
X-MS-TrafficTypeDiagnostic: SA0PR15MB3758:
X-Microsoft-Antispam-PRVS: <SA0PR15MB3758279D044716C2854C7CAAD5E29@SA0PR15MB3758.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NlDF/wq+PnWdIlqQVkvXUg9YVz5NZWPkSewl05+ilXSyG9UHcT+nD11ei7BlULTuMw25l7HutYs7MG5UKyz9k/BxoPQAk+CnyYAGsLZmvdcy0sOp1xW1DBw2GKEEI4hmMKeHAEhUZvrPeyzA5awnrAqiP3iA9ovoOUfoWJR9frzrbBFYqJ/oPIcpG+WQeFmSPTueADx0yPrA4gsUOUmzicGCiERbP79wA1R3claNvN5z3JKteZHeC/hnuNYHaFTpVFTm6PwvaHPQQ/t6J/fF1mBlGHRdVxA2mMmdIqHZ1+TSJoR2JvPgH14V+AezTMc7UcMJ0mMZI3SCO3uSndp1iU8IgPIoQ4XF5igIJsPi1VMmBv7/nTiMhBlbcHpUXGx4kUPR8OlfaC+6Ww63kvP3N+pavxZ0Aj8uhWXMU1RHW8s9XPUICSHmqKGlAfzOJZDyFA1bBPGMLL5Tt+NsveSgwv2/YAv9aCaXQOQ5tcwC0z1UWtvI6KJf/tx0NceG/GTwVgmb/jTLMVEJbz5D8353UaLgm8SL5gsSK//Jo1TRDH+n9qJ4RF2lMwCsBlD2Ow6QnK/Ry3H4PHMISe2vytDvGsFyZ+8rLu6IzsItsMK8/OZ0KK3vZcRLISdmlUPcTSeGpAXLsKpZluoEtiI5mrqwcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(86362001)(55016002)(186003)(8936002)(4744005)(9686003)(2906002)(4326008)(7696005)(52116002)(8676002)(5660300002)(66556008)(478600001)(66946007)(6506007)(316002)(66476007)(38100700002)(1076003)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ervmax39YfCWuQZcsljwDGP/wjYRlsBG+kaMKe8eF53QN1TvwI88oREEkZ2m?=
 =?us-ascii?Q?p3b8Dt7aruL39jVaNfzBduJewDr2q1j9fM6KePeX5cX/g2R4ozArxQpwRDSb?=
 =?us-ascii?Q?W7Qkcz++xpGzalmK5mKvMsGu2i8f8Y4F+Y8KonHiMzNL567XTuVNTY+3YVlw?=
 =?us-ascii?Q?llfRbjp8A2uaApZOOiSO0xhZOLImyEpXZHG4gqubQnzSXsezg0ehUdlEyXgl?=
 =?us-ascii?Q?Y4leTm+TPbjC/nRr+sqV7rqAwkL2kQztMVR2YfCEBlnA92C6OjkXrhO/yEmB?=
 =?us-ascii?Q?N5JBveup6mwsU5RMwvDs++kOX5n4FS+29vPfqWoPdyebIMNoUwgFjTIBVjBs?=
 =?us-ascii?Q?OoL9TRTkjYZcDar8Vzf+dyGdoxL70dn1ciSG4Gx3moUCMitceIxT/2y3dIRN?=
 =?us-ascii?Q?ay/JOWQllBcTKDltHhsc7LXH5WWznPKH1vpLI+ZYU0fyAhjC/9E8tjvzpxhW?=
 =?us-ascii?Q?WC1J5wW9FpktE6s9Z5gYXXgY72HpPfyLvNA9oYf9JrZ0jjWBQKgXRJnE9SUY?=
 =?us-ascii?Q?n3HR50mdYG9PKS1W0w9Sn1Dgmk+MG4wYpaw7q5EI668Y4jGiAdBC4M963jJJ?=
 =?us-ascii?Q?ZyWx+maGHFoKCXFwzeiVgENO42Oqo4RGESFA/irKWHxLhM5F4lr3AwLJuujz?=
 =?us-ascii?Q?pTUG9gdNqrghZbgwEtArmMbKi+BHFbqHbCHPTthiPEJXzd+NZEUulKXiUaSu?=
 =?us-ascii?Q?34wgp6ity4jSKApHPFI3IGo7LUbVMRDC/WosjarAx/LoQYDl+fBPehUWMdcY?=
 =?us-ascii?Q?dr6xQCVpo3h0kszhu7iLXQfxG2x4xufz6H/SddDIU5aFjfchRMgJ/VcB0qA2?=
 =?us-ascii?Q?vLY3T/PkZLf3dMf0Ny4wrltgE2f5ADDYsHG2I9WWmeaXQkoKRbRUIoVAc3H0?=
 =?us-ascii?Q?qUZ/KWDqsSnIEtcGs0JdoqmuGpBab6Fa4VqmGRi0ZKByeMjuGThSANWvxZAB?=
 =?us-ascii?Q?/+niO4xrdSPhMpVZtJwioQ9uTWB5F4TmVP9MkiMq0M4vHEtIu4dd/oXkDl29?=
 =?us-ascii?Q?Jne9e2rA3oUmCoUJB9TCtqBTNFlp9HMpUdUCULBz8AO7qm4+oRmoyIPCm8Fd?=
 =?us-ascii?Q?seHjciHG8FNZQA/p772xkh4x69qryWUHYf0/kfpqspiXHOf1oC0qGk8IY15b?=
 =?us-ascii?Q?rhMw9+LbGEcZHyMIFOsMEjvQ58Jr5bnnEN55/IgQy5e6T10xaH/o0jUH6TRe?=
 =?us-ascii?Q?o+6WvhNRnD43H/FynILwFA20vhRsc3E8QdDdDrhYrNo4uw/7TQWQywdZeA28?=
 =?us-ascii?Q?N9A6QOC6izCjyW1vOt2ykYPfjJaafL1IA5aYAn/c5K1lPLlQd2j9kEWkR9Pv?=
 =?us-ascii?Q?xBXH8i1MxBOitHyRv1mzEXKPDKE77vJ+qqIl/zupKFiqZg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8dfe247-e979-4a8b-55c5-08d94baae1b8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 18:19:15.4746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bNgImkNZAndBp6HavT/EwAmdfyVbWH/aAZIc4bVirfX6b63ySxlGi5SJG4zaP/85
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3758
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: eng-1zuXTiCKo4VkePz0oN2ruaSGL1ze
X-Proofpoint-ORIG-GUID: eng-1zuXTiCKo4VkePz0oN2ruaSGL1ze
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-20_12:2021-07-19,2021-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1011
 mlxscore=0 mlxlogscore=543 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107200120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 19, 2021 at 03:30:22PM -0700, Vincent Li wrote:
> When run test_tc_tunnel.sh, it complains following error
> 
> ipip
> encap 192.168.1.1 to 192.168.1.2, type ipip, mac none len 100
> test basic connectivity
> nc: cannot use -p and -l
> 
> nc man page has:
> 
>      -l  Listen for an incoming connection rather than initiating
>          a connection to a remote host.Cannot be used together with
>          any of the options -psxz. Additionally, any timeouts specified
>          with the -w option are ignored.
> 
> Correct nc in server_listen().
I have two distros and both work with -p in listen.
However, they also work the same without -p, so it makes sense to remove it.

Acked-by: Martin KaFai Lau <kafai@fb.com>
