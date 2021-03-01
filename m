Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0951B32772E
	for <lists+bpf@lfdr.de>; Mon,  1 Mar 2021 06:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhCAFjJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Mar 2021 00:39:09 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36758 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231653AbhCAFjI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Mar 2021 00:39:08 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1215ZbPf022848;
        Sun, 28 Feb 2021 21:38:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=sRJGaZBnGUj2e2IWF/ZO6to1gNFIY8t8eySVaNkIy2E=;
 b=omACbnrqSZtDAU2PiQULC1ENxLc6kfT35F8avkeHZyns7XInL6dQrJ5ipgJu59vVrf30
 oQRd9sYYXaq6mHnKhjrjv1f15TjEVv/qK+BR4DWdC5Kt4dS2tMpskkRJGaWHxjuzoT09
 GPqwy/HXNW2ALWUSPoF0GNVZ3pjEyPjtziE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3706q137rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 28 Feb 2021 21:38:11 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 28 Feb 2021 21:38:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SW9OGfdmv6quBCCSuxP7WFBxAS8fYBPQctsMz5sMBi3/eg9RPQjqcJkgklJzO1oWTl6ZHi3VhD7m0Ic+SV5KQeUgULLpJS6MYwOJ5Z3pltFfaOCVXiHpKNIwvkHHwPh84ycUwFX9PsNVkuV+MCJ0HZyBBxQUifuL6pU5BHjyNWA0pH+M+pFrQFkGlfA4HT1umyP+iH5eWP7/tI3ICFhG7lkFZxeCELwC5xVhOa6HBjhlntaWdZz55+xCRPZZ6Lh849kzKFTsD1e7bQX7BrviV7wnyZYMGB1e+7Z4PbsF17DoIeoF5DtCrkhkUNo75YeLLmXLIZSFd1be5cpf/65eRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRJGaZBnGUj2e2IWF/ZO6to1gNFIY8t8eySVaNkIy2E=;
 b=AZq4BIMDI1A/PY7giK9WmuIugWKBIomIfijq9Q/0X2ZR5CnQmoymh5mnspB8+ckHs0uiSM8eVXb86x5eS9NdxVhru/gujdKUDBLyWfbKirGpiL1hDuxVUYOC+wN+/tqne9CFxfCSQRiXdzAhXkzBf0beK6GWNmfgb2QFaeKTqeJqquVo3oK3pmzilIjsuhkI9r+8F1S5Wo1vwe2MtW1YQQSOUQtPeUQbw4CVK8LN1Z/enwmi5MKTugI/OfQ1lGAEi33q0E3sE7lrw3V52LlFqMcq5j8POYROVT/1uZXrPQBVO6HDY2fjuDarjeYVcTA3yTO7C93gs282eZVrswA/vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2725.namprd15.prod.outlook.com (2603:10b6:a03:158::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 05:38:09 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0%5]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 05:38:09 +0000
Date:   Sun, 28 Feb 2021 21:38:06 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Brendan Jackman <jackmanb@google.com>
Subject: Re: [PATCH v2 bpf] bpf: Account for BPF_FETCH in insn_has_def32()
Message-ID: <20210301053806.wybom4ir4gzzalwr@kafai-mbp.dhcp.thefacebook.com>
References: <20210226213131.118173-1-iii@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210226213131.118173-1-iii@linux.ibm.com>
X-Originating-IP: [2620:10d:c090:400::5:adf8]
X-ClientProxiedBy: MWHPR1601CA0015.namprd16.prod.outlook.com
 (2603:10b6:300:da::25) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:adf8) by MWHPR1601CA0015.namprd16.prod.outlook.com (2603:10b6:300:da::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 05:38:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 419951f2-f77f-46de-f0fd-08d8dc74324d
X-MS-TrafficTypeDiagnostic: BYAPR15MB2725:
X-MS-Exchange-MinimumUrlDomainAge: kernel.org#8760
X-Microsoft-Antispam-PRVS: <BYAPR15MB27250ACA017A4A84BAF9ADB3D59A9@BYAPR15MB2725.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHNepDW8SdGpfJc2IG9H4/AZmtrinKeEoUX9LpTgW0UpwmLLL2VpP2YQZIJoBkFMtBJOyoYAgY8wtXSBQkzVMyhdx2RGA9dyau/xCKAdbYrx68iftrVhPCYpfpUg/N7XzQjxyU9jshIJLpJ9FvBKmWk5FNUa6tzko2UmB5GElqNktgxz/DZut2tEux0Y4ZWRIyAm7O5+2npsmF9UlrYM7vgcYdlUEHuEaFtZcB8+k+FHeY1UXWD/EMHi8PL9EqHwEsVfEo0q5Jkiz88wD8dpqz6WtmMFzHHGCaI/FaO3p7j6xWiOWFi9bhBhG+O9Oellef7/JUCoqP9Po4mYZDxmruRBmOGkdUoagsxuQVL7jUvFo4Ur90NAVwS/t3NjaEOq+yHQ/K99BXiO3deGyorcH6Ej264WU/3yQi7p1ZZEdkDwr3MZ5hPzrjKxE+uOACx/hUGzYQMRJFN3QPWykYknAlSzaz4Adg8I4ENxfyEICx5xjZERGHwq/5xqjcSojbqIRaVTC6w4zFLvxfTY1SRZN5/SsVgALd1gnBfa+mmvuI8/JNl+64N0R1M16WVJ9enXBIh4iXAYTXyjczVCev2w4HHoNCEjymdQ+lWChBesP+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(376002)(366004)(346002)(316002)(8676002)(66946007)(5660300002)(66476007)(66556008)(55016002)(52116002)(9686003)(54906003)(8936002)(4326008)(2906002)(7696005)(6506007)(86362001)(6916009)(16526019)(478600001)(186003)(966005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KgjzCdYuicT7ayBcyU723mSKIcxboo+KUEd6SVptyj9Vp4Yb9Go92n7lx09p?=
 =?us-ascii?Q?ECOYk5DU7dB8u3fA2zPX5XpGZ1IP/4M+IthBJyI3HQgROqkPsMcmIlukWkI4?=
 =?us-ascii?Q?5snHVMMzNuvaAazFQfKJlMoZHp3KilxMAh5NzM1ySaIzRLDZvs2iDVZEwssi?=
 =?us-ascii?Q?SO4PLg3HW6TJkFyl7WWFlWFhlSdkthWDxb61atTFaEIjNDhZwc7Tbn17A+jO?=
 =?us-ascii?Q?ktPT3/6/L2IzOuhh19jsfUC7POnu8Hn3WRJISHtKcVHrgAlGSax8L/7vDCeZ?=
 =?us-ascii?Q?5rEVQ9dmMPvf382PQAM2RHaUta0H6hejH1/PHS7EaaA1PIBB+hyFH+qfVB4y?=
 =?us-ascii?Q?IguKDv8na8+jQg3iLT6qqzV9cf15b/inxeePPBzI6mr5ZPCobUdLzIYQge0s?=
 =?us-ascii?Q?kFwJqnp7ZqQeCazan3NVL0PAbxMamL4GpsShZ0EujqgO3Yjk34crc8zd3vS9?=
 =?us-ascii?Q?U7NN4eDGeF+D/7O2GefPj0d7zKcoVC2YbfvcAUyKg6FCvwEkhH4fVdYJYl/C?=
 =?us-ascii?Q?cWw6Wc3kZcuQrX8A8zhMZDqFnK9yAikTy4SXjPwIEbuuFljUFRLK5SRhHna0?=
 =?us-ascii?Q?vMnwHBy7icjulnHU0oVIZPqNYK94G6e3WuzM2v7wLmMh8tvEc9BK+GSF/JhT?=
 =?us-ascii?Q?5KWpC0BEheg5aijO2VCawq7N2j9kz0VL6Q+TgASpnTq5JhUx40jf3v4SuOYY?=
 =?us-ascii?Q?16P6xPGU2AtTgKilEFYdgv2O0rEk02RMajwSQqeuH/tk7IIs9PgkYtRc3ITV?=
 =?us-ascii?Q?dxH7DCkX1JibB92tdcX4ugiSsOpQSRXeWkmljdoZmxvvLJD1oVt/XxyHgqsq?=
 =?us-ascii?Q?cdBo0DhecueTOPJ22PKBhkD8vOb+eZBJ5Ge2RjJx4Zdws+yRv99MkY+PaGjB?=
 =?us-ascii?Q?iBAm3ljx72uTLCmry+kTWhJj7PXAZTcOlx778pmFsoI9kLuVHqWbjHaTynyU?=
 =?us-ascii?Q?L7HgxQ56CgBi0QuoNRNSWIO/E08t4bBDUlCRWJMjwE5PMIc5IY62g81x0EXQ?=
 =?us-ascii?Q?K76/aqBGtOdfhJPf5ZBYZL5bhdW1t7/kC44aP2y84hGqCidUknqzytJ14t1x?=
 =?us-ascii?Q?gyWC9nCQ8yFAOwf6dsVU1Z3QGjYuFq1lyzfUHaILBJ660I8AgN5Swn6ppkPE?=
 =?us-ascii?Q?oJdum9JOvBMq4MjFdEQOopFVFrkqfGMYVukUKnCls+IhjGjSBBjli2PlsQsT?=
 =?us-ascii?Q?Z32RhplNePHqTVSrQX9SQYHeQ2Vh6d3zaHqz+wVT/+UVqemFKCeo/6VN91xv?=
 =?us-ascii?Q?tvMM6ki2TgGU/hbBtg1wrmLF6ZL8Pvk/Vfa9l6YJbWywsUCyXk8fJSP2ygh0?=
 =?us-ascii?Q?Dq+2dzqKtVodfh3UDd2kjoijdinY61UJXSi5dzhTFi8/Wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 419951f2-f77f-46de-f0fd-08d8dc74324d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 05:38:09.7207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdYFjK01mtpYM7VHtOiH3jtTxkOnwPcqivEe9Tzx/0/oVlolvgQaGglPFn0BRKSa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2725
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_01:2021-02-26,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=975 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103010047
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 26, 2021 at 10:31:31PM +0100, Ilya Leoshkevich wrote:
> insn_has_def32() returns false for 32-bit BPF_FETCH insns. This makes
> adjust_insn_aux_data() incorrectly set zext_dst, as can be seen in [1].
> This happens because insn_no_def() does not know about the BPF_FETCH
> variants of BPF_STX.
> 
> Fix in two steps.
> 
> First, replace insn_no_def() with insn_def_regno(), which returns the
> register an insn defines. Normally insn_no_def() calls are followed by
> insn->dst_reg uses; replace those with the insn_def_regno() return
> value.
> 
> Second, adjust the BPF_STX special case in is_reg64() to deal with
> queries made from opt_subreg_zext_lo32_rnd_hi32(), where the state
> information is no longer available. Add a comment, since the purpose
> of this special case is not clear at first glance.
> 
> [1] https://lore.kernel.org/bpf/20210223150845.1857620-1-jackmanb@google.com/
> 
> Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> 
> v1: https://lore.kernel.org/bpf/20210224141837.104654-1-iii@linux.ibm.com/
> v1 -> v2: Per Martin's comments: rebase against the bpf branch, fix the
>           Fixes: tag, fix the comment style, replace ?: with the more
>           readable if-else, handle the internal verifier error using
>           WARN_ON_ONCE(), verbose() and -EFAULT.
Acked-by: Martin KaFai Lau <kafai@fb.com>
