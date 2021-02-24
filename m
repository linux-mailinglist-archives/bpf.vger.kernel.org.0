Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538AC3246EF
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 23:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbhBXWfz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 17:35:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20676 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235408AbhBXWfw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Feb 2021 17:35:52 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11OMYaSB030965;
        Wed, 24 Feb 2021 14:34:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=facebook;
 bh=PGFefjn8QqshrC68IwSTWj8WqY8Eht51DC2PJd7Bv6M=;
 b=d7ArcO7FVrmfFt6o76l3g9//NUhzELm+N6cKCR7rI0z1LxVFXt/EBgOo947iC/CgS1ii
 B4L+DrjjrazX5cgxSW22UmPq4wSGonesGMuUYjB3QnKsRAfJIWZyDODIUy2SKm3yEZ8C
 V98rl1BVgLDVaEwdef+OVpkQNqqbeHIn8bY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36w7j1fk8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 24 Feb 2021 14:34:54 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 24 Feb 2021 14:34:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehEN5ErkTOmtwpxbXcHWwk+o5OkWZ2eJ3a/4GQHdKMsS70X3Y73+HqkegzPWKY44dmu+6gTKqKhRb04N0AG4HLOSpMspNNvqQNz7mO9mOEYUhXqOrzwUjJyRwc/yRHqtbfivfaLJtj6A4yRTfTTphfikH6s8YUWxcNSevC8+ztlFs+b9C4D0ehcsJLrunJfd5uVtQHO+DRmToI40hsGzRBIdZEG4BeNFDFlnS+whCeHDbq+7jfv/HvINFjxwbgIaAhCrtNMN+SciiKOS4c7ChPYy1BGy1MJmXGiTG3j7y7TfAftUQdBtsB+o3syZz1/sq4dHgKZ/cEJ9WiZt/0Yswg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfNEwGxcZhjvz7wuG32uax8mkvVcNw9rc2C2zHwJ4HM=;
 b=IO2zZxrcCSCYgmdyUUwhFOHmog6kxoWfpWlu1vNFtBC4NwU8nOoF1zRfMMsqCi91aANeAbVueEknJuEdpbFrMqJnLk4N8JS14+Js+wcmfQTjFwQbuN0OVg45kZaF+yKqCFzD4aY8PrRT3UiXxvLcJS+rOXo5UNteTMTmOlG5cMI7rPn4ZBDIXFTsjHzMrhiLKcAr4kmV/acEqKvq4g1nkWyJYrSxfa6xRVIZp8wLEDljIfglvI5DVg/H0hsc27wG14KORa2RSUBK+kZNOc2wFFHtaVV8UiUJYvhdqhbypq9Yg1ISV8sjssxecXmGZZm/tdvzW44Xx8HBfkPHWFAadw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by SJ0PR15MB4680.namprd15.prod.outlook.com (2603:10b6:a03:37d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Wed, 24 Feb
 2021 22:34:52 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0%5]) with mapi id 15.20.3868.032; Wed, 24 Feb 2021
 22:34:52 +0000
Date:   Wed, 24 Feb 2021 14:34:49 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
CC:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH v4 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit
 cmpxchg
Message-ID: <20210224223449.3vwtjzx7cvlvzpv5@kafai-mbp.dhcp.thefacebook.com>
References: <20210223150845.1857620-1-jackmanb@google.com>
 <3652fb931ee58813f083c9722223b89b56a2a1c0.camel@linux.ibm.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <3652fb931ee58813f083c9722223b89b56a2a1c0.camel@linux.ibm.com>
X-Originating-IP: [2620:10d:c090:400::5:88e6]
X-ClientProxiedBy: MW4PR04CA0048.namprd04.prod.outlook.com
 (2603:10b6:303:6a::23) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:88e6) by MW4PR04CA0048.namprd04.prod.outlook.com (2603:10b6:303:6a::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Wed, 24 Feb 2021 22:34:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6200ac2-d010-4173-3bce-08d8d91466bd
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4680:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB468001AAA9C460187458081BD59F9@SJ0PR15MB4680.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yWouVrOBDGeqNmgdjPYgEZnquRRAKaLlqoQO7gHcz/QzuLBF3P2LZXHXNwKZjm1BD00MzwGzdOmvJ1egcXLfc7y5cbxWMSR/s/O8ymGXPUqCA0ECltmL3BzR6T/DnTD1t6VTX0TNjo2B6e0P3QI/WsFArRaSA8mq6qcREGEQ668sa2itihl6kbR5UAxTFWPF3WfOmOWlzm4fXvjzFnjpq11QFWKYjvzAiGjpgMI61/ZR1ZYACn9NSpuK5w+4ItMCRdX7QcepNRHv++q38pJ4HbNDBKCvuNzaZL2xSTm0bcF10A/BwDW7AXJifDQoT7Zc6kWgK8iNXF2FKfumkZwwYSbzSgWOKXxR17IFcUwop6X0K8buDdXDsQusTXUtNtLYB6eAEPMlK0erk/d1CYxaoCfVwESXOKnQSBLBiTQ1Ja3D6MckzXDEilTOtj1Hx1J8mlT/czLdDsFyxTa2m0qQLC48A+ZQVrflaU6V7vTr1s34nLrV5xdSY6UuZheT6XUXZui1X6/eIq0dALP7o9sN8hOL9H7poxZVLHYsxbd9z+KHVupkGT6HpnCp4aVE6LHob7Zi5bW91nFuZ1Lj6ElRUx1yikDnU+FLmSVcZh5w+gS45XE9au3sQnvwF7dA4DweEfsJrik4J0ZkUsCEWvfi2GI9hiaHeQBX+QPoaD2Uyvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(136003)(366004)(396003)(9686003)(8676002)(55016002)(52116002)(6506007)(7696005)(8936002)(966005)(6916009)(16526019)(66946007)(66476007)(66556008)(478600001)(1076003)(5660300002)(2906002)(86362001)(186003)(4326008)(83380400001)(54906003)(316002)(17423001)(156123004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?EJNjhFURMQoFP9bYt55KALJrm2bOfldXB1DtUJ4bP0PIOCl4/qOWdFqnwO?=
 =?iso-8859-1?Q?/OEdpD19X+EYWdJndmujfwsJ3imwDZ/D2zwefIeu+uyPyYu2Q3D4k+Dv/D?=
 =?iso-8859-1?Q?IJ0hQ1TsIu8F/AIwC5+jHDrstBYJKiPvpqa4y3S0vKS54SpfjK47ZtwgGk?=
 =?iso-8859-1?Q?fNC/Ov65ljXrnW8SyUa3fG37uR8ZKnN+po2rwxHjhnkzNF9iO06ZH8PwgF?=
 =?iso-8859-1?Q?jCN3AMubIb+sO0zqc4XQBPaT0XNJu6wDAMqe+uKr3SxrY8zs6Dz1fi0KDY?=
 =?iso-8859-1?Q?N9qEID72GArp4Y4mSczqBNmFzaFnuGY4MP1641WZkoHdHuOanXF4eIwBBq?=
 =?iso-8859-1?Q?MPsnhp2N8vV4SonB46v5o0DCkEXxttC0iHaRPfyUYWA4JnunEFGCc/xP9N?=
 =?iso-8859-1?Q?CLBTGFcVkO/mWPaMF1M3zqmvgnc4dMP3nNiB5JEU1brFtjh3gUkAP8P0mX?=
 =?iso-8859-1?Q?5F7sfFEEBURwvqtKJpVf9zphm2G1Svh21Z4lWuXQseeiraNS30R/i3YS0H?=
 =?iso-8859-1?Q?p5taUmk+4+JKGIMmXGBghx3E0aIvEf1yunsfTRpzjxRGQgsDE0zqOGENXd?=
 =?iso-8859-1?Q?Y31SpcCGv6WCdufamNWW6GN9IgN+gzn8GEYap7Gvj+t21F1N7lIYWpTVwX?=
 =?iso-8859-1?Q?JHfxtYvmPod9E/4UGJYQGTJEBFlhJC+TTp8M2i0eRYdy6GsKKVr1eWCTM4?=
 =?iso-8859-1?Q?nJaFGDytzLssbcW3jSjeg4mb9k+nwjxPI46EvH4FIYs3pQ7W0BzSE+zS9o?=
 =?iso-8859-1?Q?b7baMJz8tFdqx0vBmSW85AzlcoQ353K9aQG8Q8ZQz7QUxqSFWDKsz6It6j?=
 =?iso-8859-1?Q?XVuak5YQduLpoN6lPaPs7Sbrycv5rmmYTm4gsZjWV7Y8+Gi2VumF9k3nvw?=
 =?iso-8859-1?Q?f1ORrBKJWWBPGIu7+ZSTB8nBXxzrlmgSuRQSPCkEv6PnRuP/Zh5LHmK6zn?=
 =?iso-8859-1?Q?ihTyoMYRmBbGDyKWvkSB/zvaazwo+NQtCqJZY2a/a0jyiRMAmZ6PQgocyq?=
 =?iso-8859-1?Q?Z84bTdRz4wCE12CKZ7z3Efs8sBzvKu31fHc5x+2CnZXg5O1vztZcaITLsn?=
 =?iso-8859-1?Q?N8eYU/9/Do7E+Pqi7CzsPoyuhh2pmlfTtiizvTmfb0UuGYZfWCo8djiqSS?=
 =?iso-8859-1?Q?RkwTLptJH5oHeDiHiFglapFS8mZ/1eUFTSOq1nuUjkIDyjOwd0sV77suk0?=
 =?iso-8859-1?Q?tRb7/5Gb3VYlyWykfAhuXMYM6UMb0XBxmRClLjNuWFDAHVIBrke/yKglU+?=
 =?iso-8859-1?Q?VOIln2OomUs9u0cqQjVvebc+U2Fb6/UK/HbLGBnE+82jzak1FP1bJw1FEm?=
 =?iso-8859-1?Q?cY8zUwX4jIGTiV5KzYN4jbQTOOYA7O6ElLATRIWDHHKOXhdtkonYf+PlqZ?=
 =?iso-8859-1?Q?LKj0oHqLpYikNYaC9RwPsoAV5iw142KwD0O5UwLi7C2qF1LV4On+0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6200ac2-d010-4173-3bce-08d8d91466bd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:34:52.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pN+J2Q9qOKM0M/aTXBA69Pjr0dbQPe+mz3qanV0JM/7bJ8hHzUZijnoIzPvicaD3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4680
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_13:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240174
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 24, 2021 at 03:16:18PM +0100, Ilya Leoshkevich wrote:
> On Tue, 2021-02-23 at 15:08 +0000, Brendan Jackman wrote:
> > As pointed out by Ilya and explained in the new comment, there's a
> > discrepancy between x86 and BPF CMPXCHG semantics: BPF always loads
> > the value from memory into r0, while x86 only does so when r0 and the
> > value in memory are different. The same issue affects s390.
> > 
> > At first this might sound like pure semantics, but it makes a real
> > difference when the comparison is 32-bit, since the load will
> > zero-extend r0/rax.
> > 
> > The fix is to explicitly zero-extend rax after doing such a
> > CMPXCHG. Since this problem affects multiple archs, this is done in
> > the verifier by patching in a BPF_ZEXT_REG instruction after every
> > 32-bit cmpxchg. Any archs that don't need such manual zero-extension
> > can do a look-ahead with insn_is_zext to skip the unnecessary mov.
> > 
> > There was actually already logic to patch in zero-extension insns
> > after 32-bit cmpxchgs, in opt_subreg_zext_lo32_rnd_hi32. To avoid
> > bloating the prog with unnecessary movs, we now explicitly check and
> > skip that logic for this case.
> > 
> > Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > ---
> > 
> > Differences v3->v4[1]:
> >  - Moved the optimization against pointless zext into the correct
> > place:
> >    opt_subreg_zext_lo32_rnd_hi32 is called _after_ fixup_bpf_calls.
> > 
> > Differences v2->v3[1]:
> >  - Moved patching into fixup_bpf_calls (patch incoming to rename this
> > function)
> >  - Added extra commentary on bpf_jit_needs_zext
> >  - Added check to avoid adding a pointless zext(r0) if there's
> > already one there.
> > 
> > Difference v1->v2[1]: Now solved centrally in the verifier instead of
> >   specifically for the x86 JIT. Thanks to Ilya and Daniel for the
> > suggestions!
> > 
> > [1] v3: 
> > https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
> >     v2: 
> > https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
> >     v1: 
> > https://lore.kernel.org/bpf/d7ebaefb-bfd6-a441-3ff2-2fdfe699b1d2@iogearbox.net/T/#t
> > 
> >  kernel/bpf/core.c                             |  4 +++
> >  kernel/bpf/verifier.c                         | 33
> > +++++++++++++++++--
> >  .../selftests/bpf/verifier/atomic_cmpxchg.c   | 25 ++++++++++++++
> >  .../selftests/bpf/verifier/atomic_or.c        | 26 +++++++++++++++
> >  4 files changed, 86 insertions(+), 2 deletions(-)
> 
> I think I managed to figure out what is wrong with
> adjust_insn_aux_data(): insn_has_def32() does not know about BPF_FETCH.
> I'll post a fix shortly; in the meantime, based on my debugging
> experience and on looking at the code for a while, I have a few
> comments regarding the patch.
Ah. good catch.

If adjust_insn_aux_data()/insn_has_def32() is fixed to set zext_dst
properly for BPF_FETCH, then that alone should be enough for s390?
