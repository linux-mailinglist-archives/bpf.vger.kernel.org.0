Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7798A35FB3B
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 20:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhDNS7b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 14:59:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63430 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353232AbhDNS7U (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Apr 2021 14:59:20 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13EIh0gY013263;
        Wed, 14 Apr 2021 11:58:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=gDUBQJSiufK2MKYx5sExGUhCCJFWC8uY8B4+Ns4Fmwc=;
 b=IrBQ+g2zeS6uXhkZk5V6CynIq9apTIAM44fAWFfiFhXcwsCYmwSonGq3bv/uAFEPrAKr
 SHdo5wTG3WQNL09r7bJfMu1kCpx7mzkp85ST5lcReQvBTkE4wHahcAnSILEAbaxn238Q
 Awv2aLpZlZUonSQZbtKn5j9BzmzJ0CXFNp4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37wv6539mm-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 14 Apr 2021 11:58:45 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Apr 2021 11:57:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdPtlyaeaXqwTKCGcjuLGBE7F1YcY26Zb3eabZpBDIyynU77J7ZpKW0OX+sr0y/UQORkx9jpg4LNjG/dfxHsyqdl9fCbmcM4G/BaTgr2UOa3nYNtdyB/FI6bLy6DtdTKC8j4Ez0qtTV2On+5SCZ6Rn+fKggemK5O3B/HOfWo6ZKO//3MLNTMLqwfexgaC33Av2+1YodLv4rgph8BEL66CNm7lkzfzcXNwA3Ee8n8ooyy+qGxMcp9hls8uUKOLTLG3/oi1tpduud3fJV8xu3uUbatnpO6KDFFIMPvz2oFHPH/brI18h5shMEDcIcMbu1hNm/LesI62RjxwmKk/BhJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDUBQJSiufK2MKYx5sExGUhCCJFWC8uY8B4+Ns4Fmwc=;
 b=TtLERIlyFJ46wv2mN36kqmvh4ytmP3JjHZCpkTjx4WAHrb9QeikhmqdkbNjRPnY9y4RHMhooCByZUsJYyIOytHCh21GRT7JA3iIzh0+EHj7YUdsLDd4IL0+/cULwnqxep8SwrV2gk7cQHWgeWv7FSlkQmgeDcRJUqnUFZP1tfUVB0SdRT/cweg+W6aM6lsp+Dt1FZsnzxtL74eITIVjZ7hTjt7Q5j0cmCWj05tMDZImQ8yoNnIS0CoufK9lGdkLVOxAjjZD+7VQqi6OD0p+EWFz629Y1KVxDSXfpDhgzo8QqH5v66XMzfs4k7MfjWxEvPlVad5aYMrBhuzNE8zcNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by SJ0PR15MB4568.namprd15.prod.outlook.com (2603:10b6:a03:379::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Wed, 14 Apr
 2021 18:57:48 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::718a:4142:4c92:732f]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::718a:4142:4c92:732f%6]) with mapi id 15.20.4020.023; Wed, 14 Apr 2021
 18:57:48 +0000
Date:   Wed, 14 Apr 2021 11:57:44 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Florent Revest <revest@chromium.org>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kpsingh@kernel.org>, <jackmanb@chromium.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: Fix the ASSERT_ERR_PTR macro
Message-ID: <20210414185744.y6x4pmnkqph5tmnb@kafai-mbp.dhcp.thefacebook.com>
References: <20210414155632.737866-1-revest@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210414155632.737866-1-revest@chromium.org>
X-Originating-IP: [2620:10d:c090:400::5:ffda]
X-ClientProxiedBy: MWHPR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:300:95::29) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:ffda) by MWHPR13CA0043.namprd13.prod.outlook.com (2603:10b6:300:95::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.8 via Frontend Transport; Wed, 14 Apr 2021 18:57:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e17915f0-0fdc-456c-63ec-08d8ff77322f
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4568:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4568F97E1513499E55AE5463D54E9@SJ0PR15MB4568.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /1aKhzYa8CHvQks7XdBbFaP8U82QOgbh96GKqK9V4eHLO5tXXl9m8+a/GKwL9dUVmJdbsFZoBrvkIJLQoXw181Uv4vbxlRJmJAKbewKLD1WLeij5rhZDCo0c+sRxbFoD35T9qZ4kGPmpQ6LjVXodOPAS1fG49SuPLc3/NBgFwXJ+XGXVp8IDxnil9nq0sCzaoPey3oUPdrADGbbjIB+FUbUeEg8Z0vjZSHWTj6zjzyweCRNZh/WjZy6tcya0Xome+gkpHJ4Cg3INuOmUkOiFxRD1Rk+zWorw7s65V9EMnntnYkRa26fiqpxPBI6MPE9/FiP/hpnTb0wQE7Vlh/B5cm5qwXQNgjVoUkH7sIbJ7A5JDoR7e7Ze81qlzFiqypDefTwR8poyxE6SUxO4ifrAQtH9o9qLEYmr6jI3CI3CxCW8nlewHu5bbR9IJQgmK8jJ/JclM3eMf3C8ydYBONuzNAfoLaZB9tY9VVm1t/ll+NPASzxTDD7Fs+VaOeZGfWI5spzk8yOPuhXVHYExLnt9mSt6L3ihhZzU8iJc21oLuPMR+5wfKoYHO+buaV1fNtx6hXHfyCSFIPM3ApUUA5ejX3p1N+HofDEfwGCN60yY4Ow6XRIxxhT+EoeRpBzSfaqzbQZpmgeQQKpH8joKvDQ2Bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(39860400002)(376002)(396003)(66476007)(7696005)(6916009)(16526019)(66556008)(66946007)(478600001)(6666004)(8936002)(6506007)(4326008)(1076003)(2906002)(5660300002)(9686003)(316002)(4744005)(86362001)(55016002)(52116002)(38100700002)(8676002)(186003)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?I/23EUMwIlJtUYsVG/3hPvrkOF87OomDjCQezxWRNlfAyoNNpS4mqons3hYX?=
 =?us-ascii?Q?k+CHp9PC9GVQASrF+QVbOlE5iXEdvQ5BuNgD/2Ex8sZMcLUdPZ3+rLVz5unz?=
 =?us-ascii?Q?gEU0DJeWCzOKKph706gSCSZnlMU9/oJac/EvrfRWmj+awhECIWDqwVvAU3Bl?=
 =?us-ascii?Q?AYAQpfIQy9LtQIMkuXN62wcOYkvc96R0nXL+ffgOaVYlVV6mt6Hgogam6ldZ?=
 =?us-ascii?Q?UmGc11Higbvd+i1LFUnkHtPBDv97YmAuycUDAGGBHSzcUsqAeTlOqp5cOEu5?=
 =?us-ascii?Q?CnO8fk2xrmVS6b7eZty0cJvXPahpG7Fo79QccJV6S+ZVrblqs8Xppz7/4dLQ?=
 =?us-ascii?Q?RPIAsvyF1i/4m0+tjl2Kx7f33lAr2EB5iO3kHNQAXRi1nkqK8DH9dcMNplkn?=
 =?us-ascii?Q?vD7Sdwl54tIwRfqP2++3G9HlcAp6qbDeinThHzIQN64ZkNwmklP98byC7vXP?=
 =?us-ascii?Q?/n+196bvH29kPev/Hf3cFCyKpv0bSSnbozdrGE3SaGh9ScqFx/BVLEl12OiQ?=
 =?us-ascii?Q?NOtOmNVmaK5GQ+iAwYT/Mu0/IehtGOxcb99RTYuVGnFW1Oh2MWerNwdTRpSE?=
 =?us-ascii?Q?2P5JnhXl88U6vB6vMj4m/7/YdICzEhAwLVgIJDLkRW+1UCcN6OEmDt9nomBe?=
 =?us-ascii?Q?SiLSE+EjPMYBmJqwbXIQ/tMubJCBdfR49kSnVzmHO+U00/b743akwy60aYrx?=
 =?us-ascii?Q?i3jIehtoKQGFwlFlV4/8aHamwgcdxPpFkGepEufnQVjC8HzQ4QDUPdXMeuNe?=
 =?us-ascii?Q?TMMbqk/YSGrjeOCG2fsULVcML/ck5gU8nexw0DtlklV9rGgrXWtmiEgYzxjj?=
 =?us-ascii?Q?eJ4iPGZ48q8PcZoMPvMdnyosgC5QaAgKOH0mUf9/lgixQTsCyFqT/g2aDSD9?=
 =?us-ascii?Q?/N+ZC4qeWZGXwfqvzWkgO1a7+c7T+Zsn7/8cYHjCnRpwBB1HHy71BoEbqPjZ?=
 =?us-ascii?Q?eZYXcgmQyhBk0fIgiPql2cPSyCOh9Vsjb/0XueMW810p8uwXYFu425gE+c3z?=
 =?us-ascii?Q?YR9aOfgyth0MGNqkQxk3W8sJWVIeViqC9ogteTMaoLsXnvEL74+WuWP4BNyS?=
 =?us-ascii?Q?g1ZaQAZrrK4HdYF+tAV3urIaAVH0xccOjCMEk1Rv/j98eud0o8wY5/2qGU7f?=
 =?us-ascii?Q?1NiFJL9B6rDdk5NcG4YYJf8X3lR/ShgtDUR9SBKJL054FWMa/i3xjJLm3+X0?=
 =?us-ascii?Q?OcFFVy6Kezkgfmud/IdeCI+utL616zrP6gn7vA5u3uHkPqFj8c3nWtTfAgIa?=
 =?us-ascii?Q?lmIqPD8E4gVm8VkTWP2nQXYHDbtBdoBe3itaXFv5nVgz5qhpfTj9WHD/CJsb?=
 =?us-ascii?Q?xa16bDo0oHi94upngWlVuDfVpg+ems9MPMKgDo5i/Gk/7Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e17915f0-0fdc-456c-63ec-08d8ff77322f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 18:57:48.2272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z841tsRCEXOwuls9B434TWjzjQnkYPzmKU1rUwxHzBiwhEmDvrdXfaNFSLcscFKN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4568
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: XUttK43QqS7x7XlDvEXGAjRjIkOh6URu
X-Proofpoint-GUID: XUttK43QqS7x7XlDvEXGAjRjIkOh6URu
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-14_10:2021-04-14,2021-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=883 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 clxscore=1011 priorityscore=1501 spamscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 05:56:32PM +0200, Florent Revest wrote:
> It is just missing a ';'. This macro is not used by any test yet.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
Fixes: 22ba36351631 ("selftests/bpf: Move and extend ASSERT_xxx() testing macros")

Since it has not been used, it could be bpf-next.  Please also tag
it in the future.

Acked-by: Martin KaFai Lau <kafai@fb.com>
