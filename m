Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978673221FD
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 23:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhBVWMh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 17:12:37 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47534 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230511AbhBVWMg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Feb 2021 17:12:36 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11MLxXmi022594;
        Mon, 22 Feb 2021 14:11:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=46n8uulGBMJHdpr1cQWba2qxf49jKgq+iYoTY30FrjA=;
 b=RDUp2oaqLN7jLci60mh+grPGyADOZjk+G3BQog8Ngee5Xky4lKWSyZ4FiEg9+m7JAq7L
 inXGcH6BvJLp5fvJjKeDgl5RiXdyfMO6SimMUQNzixqb5gwI0IHi5h51w9wf31N5G2qM
 mdiv5wbsNJecfvGrROXS+CNEcZm4hZ4kdto= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36u14q2ped-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Feb 2021 14:11:37 -0800
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Feb 2021 14:11:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Feb 2021 14:11:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JICNyCx3DVGRx6VyzbJ6UX+H9IchjBDmEYjnP8kBOayrBXMRAYKcO+1cvqwzbDXdqMiQOTrpZdqi0xlH6QyYrXhEzxv1052frFKQGCK9w7cyH56bl31BME7l6D/YNDwaRpPQAj0fGZkW7fLS9qmNZWjXZAYD9fnckqa87I/LuyLfpcVa/HRY8ci97USTYbQmCRUwoi9K9TnolW6oPHgZN0vH2lYdvU2rC2kHtfXuIEBuU13NRw8lvUpTXrjz8iDydp9KRBjpS9NzYNP/lFtBWRGn/5q+pUnjy/662pF2K8/DlwQI2qKOOTz94Km9K7WTMwugCZj+xB2+xQtCGMkYyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46n8uulGBMJHdpr1cQWba2qxf49jKgq+iYoTY30FrjA=;
 b=C7FxFnkrqwkKkU9BwHntFmcIrRxqtpWQoeU2LWulERM6kM6lmsekWbJzuLDnl7JftzVSYF+vu1DHfLTGJ6CL4ap+8za+TNunKCHkR2/bCaSzr2dutqkfg5/IDhE8xv0m7FHIhve7fn/BmVPWTXA+ubJsK3SnADBxQT4/CFV+eJ11g0G0zXwyhykTxT14KdO7bl6ur02DZ7lX110rUFlyCFAYJLOAFHz1YmP1F8wP6eZst5kZY4d70ryxJZ1mynvjM1JuiQwm8rvHyGuak7m2gUF9GQZmhrQBtdMVXrscP9Vkz9FY+3OvqGVp0TtxqWbpKux2+Wvw4tnG2OMgxJA/gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: ubique.spb.ru; dkim=none (message not signed)
 header.d=none;ubique.spb.ru; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3208.namprd15.prod.outlook.com (2603:10b6:a03:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Mon, 22 Feb
 2021 22:11:36 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0%5]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 22:11:36 +0000
Date:   Mon, 22 Feb 2021 14:11:32 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Dmitrii Banshchikov <me@ubique.spb.ru>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <songliubraving@fb.com>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>, <rdna@fb.com>
Subject: Re: [PATCH bpf-next] bpf: use MAX_BPF_FUNC_REGISTER_ARGS macro
Message-ID: <20210222221132.brp4iuc744qfzbzk@kafai-mbp.dhcp.thefacebook.com>
References: <20210222092531.162654-1-me@ubique.spb.ru>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210222092531.162654-1-me@ubique.spb.ru>
X-Originating-IP: [2620:10d:c090:400::5:bb5a]
X-ClientProxiedBy: MW4PR03CA0276.namprd03.prod.outlook.com
 (2603:10b6:303:b5::11) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:bb5a) by MW4PR03CA0276.namprd03.prod.outlook.com (2603:10b6:303:b5::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 22:11:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a16882d2-1805-4eb6-7e94-08d8d77ed1c2
X-MS-TrafficTypeDiagnostic: BYAPR15MB3208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3208BE5C0FB2BF9CEB5B2DA7D5819@BYAPR15MB3208.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHb5BmHZuztZy3r/WjHHg9MFTtDT//pQboCfeeOXatK3MnXKQLlvfEUnOl3ACTxHwM2IEaD5P9V13hVXNS3eDRIYpHylP+im4FWs6Gfbr84+BPH89EsoTK0mZyTrV+K1Boi/SviynoXKGxHg4T+UZ+f3gFMGyo7ZcY8++byNnNJdN9Bq+f+7L/Rsjb7z80CwXXjrPLzxX8/50+zyNkvQzGkBd88mqcSClcHWr3hSVVMHuvWLDRrCGy+7P2CgCIUmjKL3gzxwMtHYIIphrEhQej4xS4ofLVHzlhlSWTidBCejPOPv90sFz4AXj3Ps4XljenYhwOjSg0NUfQwGw5gKbu850tnPFkOu63wUbbMAlGnFNCMsJGnslEGWIoypDtac4nCYTd0PyX8BUVP7k+9+HDPy+htjhsJsSgD6rS6zbvrkKEdx7LhQ3VClbslb5tlHKvG3qMDcNo+rT0FsB0nN6iqc7+LS0mlMJpI32DySYQe22KG0BuUyAjFaH99O9CiFhlZR9qs/DqAisjptTHE11A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(136003)(396003)(346002)(4326008)(6916009)(83380400001)(2906002)(6506007)(4744005)(52116002)(5660300002)(7696005)(66476007)(55016002)(66946007)(9686003)(478600001)(66556008)(8936002)(316002)(8676002)(1076003)(16526019)(86362001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Q1WQvdOF/hKSqh0xK+rXW1cbEmq7wKJ8R4Qm7Zz/fsZx7si9vmHBTeNDFfWT?=
 =?us-ascii?Q?al+ea/fZ40SUpriU/l2Ybpc3yww9N1j6mQ9B/PvHPJ3tUtxxlM5Azwp9ihGa?=
 =?us-ascii?Q?G0T/1v85LsxeNXWGj57fouPo9UyXHD+A2fXuDXPcXUm9/eGQ4lFI9y6Qwe7m?=
 =?us-ascii?Q?DRO8wDi/ogUoZfYFHS9/m5ylCXdpxPNDDfW43bu89uQu2POrG34KtOrHmbP2?=
 =?us-ascii?Q?2WoaEmOy4kLSP2xtozH7+pkM5cWOneGXudJyo+Ufl/VM4xDAyLc8txShPu9q?=
 =?us-ascii?Q?z/INVxEQHxx0cy+FjRCO38p9pfZbjDlyXoNuVeQaV7xgqnAARbfDpnfh+JVC?=
 =?us-ascii?Q?eVoISsKD9h8W1n70zD2zzz7RvQYOmp/N3ncWbP9U2rSrjcnmccAFG/Y+aSZc?=
 =?us-ascii?Q?xyyPHh4s8K9wYXW+/511eNjIafiFsRDCXXnwtWCvlGiHye2OYXYsj2CGMbhI?=
 =?us-ascii?Q?pMvaml8Ol5n1rwSg6emLrYX5dthmB7jgO0VMwUGb1NFXdD9b19+wyEQIOSXa?=
 =?us-ascii?Q?LMdyueAdZT3h/Nj06+Hxxer4APe8cYYp3sVFe6Hdd05VOZI0Ry5bF0bhHGQG?=
 =?us-ascii?Q?5pOWKkUmXP3A6vXMSe/hNYTazrb7pbBAjYnEogkHuYyyc68keFIrCRG9DpxJ?=
 =?us-ascii?Q?GOYJ0toB1yMKJ/+EeGg9hzGOl33qM2A9EPOTefypXqNLuDDF7StcI8wIVGKf?=
 =?us-ascii?Q?59r86RnieCbu1uZjaw2i8xaNGvCQNxHa+7D/Y/+FeXFic194WvR7/ZcTI//Z?=
 =?us-ascii?Q?jt9qiP6dm6Evj3wGwT0wSsAF4eS3L2lTYUKZ/PJV7quLoycyM5RZnv5ImGNt?=
 =?us-ascii?Q?Jczarn3MQXyZDv5DaHUrzr4UqL0D8e6RqTJV4V4sRI3wazvUUZ2NYg1BvEry?=
 =?us-ascii?Q?dtHOq/9xLTQVU/WFkWJKsHx6XWDo/mC5Hql0Z10VDfQqhCDqWG7ULuDNNZ3e?=
 =?us-ascii?Q?SzJglweu9Eok8HrLZXdGxXmj5N29U6XZf0FoDSUXcRpTHEtwy8d8jODOA6xK?=
 =?us-ascii?Q?GOzlsnS0sX5qFQ67mpLkxvWgT5kioSjB2+M4PNTSJgdPv9Ja2S9Fu4ESjLDN?=
 =?us-ascii?Q?KPi7DGK8xNmK99GlXJd9meXHcRj9f6mXFVj/kEc8eGD5IOfbZjGnJ8O3ubnF?=
 =?us-ascii?Q?p6d+1efp6Z88SickKs4fh3CxUAGSHfo3n8cuhCMGhuPBdJ+qVH9gbOUVlQgX?=
 =?us-ascii?Q?I3aPL9N/qaGxRggJhBTIcuRuv+V2npDib3UQ83EKRIF+Uqnykd9p9C+77zPn?=
 =?us-ascii?Q?esmHSnPaczwRFSFrZeTAjKBdOs+HjxhD3JH+CwTSSy+91vhLbbICv+HZbWD9?=
 =?us-ascii?Q?44FF75hKc3HTGz14GSNYUZWqhyBaSJRCnHuPY4v29z7mT/YKQtzGcgEXtZmb?=
 =?us-ascii?Q?wvu6hRQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a16882d2-1805-4eb6-7e94-08d8d77ed1c2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 22:11:36.0239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Isri1okQK/KHSDu8wSEz0g6Cp1tetAoJgCuJggT3ahXa7xJbI6gzhnNMoAeQfcVK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3208
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_07:2021-02-22,2021-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220190
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 22, 2021 at 01:25:31PM +0400, Dmitrii Banshchikov wrote:
> Instead of using integer literal here and there use macro name for
> better context.
> 
> Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
> ---
>  include/linux/bpf.h   |  1 +
>  kernel/bpf/btf.c      | 25 ++++++++++++++-----------
>  kernel/bpf/verifier.c |  2 +-
>  3 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cccaef1088ea..6946e8e6640a 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -505,6 +505,7 @@ enum bpf_cgroup_storage_type {
>   * See include/trace/bpf_probe.h
>   */
>  #define MAX_BPF_FUNC_ARGS 12
> +#define MAX_BPF_FUNC_REGISTER_ARGS 5
nit. How about s/REGISTER/REG/?  REG is commonly used in the
current code.

A few word comment will be useful also to avoid confusion with
the MAX_BPF_FUNC_ARGS above.
