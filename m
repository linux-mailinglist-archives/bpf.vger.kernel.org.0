Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E91370456
	for <lists+bpf@lfdr.de>; Sat,  1 May 2021 02:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhEAARy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Apr 2021 20:17:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48408 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229915AbhEAARx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 30 Apr 2021 20:17:53 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14108S0N021203;
        Fri, 30 Apr 2021 17:16:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=E+LHO26TfNbQfOG50LqX79g3a2wzSae90G2ZSzsZkbM=;
 b=J9+09cbvbCZEyfo6CGe+B/NrRV1xi5ezKtuZNxHnSwK9Vkrlpp7ZjieKPJQrNTEANQfU
 QRKh1a2csAjIfDRH3rwl4S8k5hT7eJAAyyb1/yg4PL8bcibNRNWsjU0Aj1mijTcqi3Se
 yzRbjLPngc03QJXOoePmbeKQPF1/+fuXG74= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3883fqynhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 30 Apr 2021 17:16:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 30 Apr 2021 17:16:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0IpdAlmnSQRUdAAopFY4SikxQ/tQWJVOwVRDRlUujjPHkUrpPMdWQ7s34PBUhwpTyAEGUG0XBcgHOUPW29mpcg6MK+PyXcCtyHjhmuTmlddVE9OfIoLUenqtiFD0S8IZh0aJK7VtbFH5g171PR4Mr688KPhH1uf7I6zc4FSGXtwZKUK9wt4ekCRP95ijfHw+Qy79fAM5zJdWE27qzrKxNaboJju3r4pp58Pok5ktEWYDW0S0TSPFycpWsR6gsDSl6CyG8UrolKpIgucLNRnywENA4i9ee4Ox/i/YxnXR+7K5rf69jpcXj1XOTv3shbrJE3fXPDALtIn/bvlAQ/DmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+LHO26TfNbQfOG50LqX79g3a2wzSae90G2ZSzsZkbM=;
 b=KjPWCyRoMwWGCbcyFtXmSiEoCmoVz+kIOb59XdkUXNhHR97aLcd8WoVo3KIgLT+bVqrO327W2S6AZ9nlO9+fNL20a52CyCP3jZYa3ihSsQWGJpBOvVQ/gP6gO7sl6BnuHqxDpQrwmj81RcbGSVSMFTab1PUOeHv28D2eXks2GijoUgDL1Paf4sgOtz1DohFbx9a4o+QbqTgqv89EJe6a4NCImsJAD0rXO4kei+J2aqsgIY3uGiCogsbyn/rjy/qWF6jk+ozz/T1i9DyQHeaejQRWvufrP7PwbJMvgdiqqHeU5FwqorqjQVh4GefCbfYpOhskbEy15PI+L8e/tu2RVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by SJ0PR15MB4679.namprd15.prod.outlook.com (2603:10b6:a03:37c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Sat, 1 May
 2021 00:16:57 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::718a:4142:4c92:732f]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::718a:4142:4c92:732f%6]) with mapi id 15.20.4087.035; Sat, 1 May 2021
 00:16:57 +0000
Date:   Fri, 30 Apr 2021 17:16:53 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>
CC:     Jiri Olsa <jolsa@kernel.org>, <dwarves@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH dwarves] btf: Generate btf for functions in the .BTF_ids
 section
Message-ID: <20210501001653.x3b4rk4vk4iqv3n7@kafai-mbp.dhcp.thefacebook.com>
References: <20210423213728.3538141-1-kafai@fb.com>
 <CAEf4BzY16ziMkOMdNGNjQOmiACF3E5nFn2LhtUUQbo-y-AP7Tg@mail.gmail.com>
 <YIf3rHTLqW7yZxFJ@krava>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YIf3rHTLqW7yZxFJ@krava>
X-Originating-IP: [2620:10d:c090:400::5:a9e1]
X-ClientProxiedBy: MW3PR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:303:2a::11) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:a9e1) by MW3PR06CA0006.namprd06.prod.outlook.com (2603:10b6:303:2a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.32 via Frontend Transport; Sat, 1 May 2021 00:16:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2123aa41-6eb9-437c-ed05-08d90c366e79
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4679:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4679F3B241A2F09B95CC7827D55D9@SJ0PR15MB4679.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0bnfQNBlS7c3mzZ0Y3NotMzuvsOMCj1SnBGIWSzlzrgh2M+PcjztTh0fJlX8lhJRLHeSQy9BVy+KkU0y55VYzJrtNgtaumQOmqFAxmwpqD4mZlIY7V6/u6Fk5dHFeGg97YY9qs3LBD6AiIlia/R9IZahmoy4sX1nsrZaY45teqT55RfsR9HcObg8g7Lidy5Ekl4OWVWqjepnKrbT/cn+ib14scuAg68nuNsmsBitDzF3nMNWGg1erpm0VkvwoAJn8VB9WAzwEhcWJ+wnu38nAK1Tf01UWppVss4lWyedxAi2PcBrRqjiqu/oYXbWYV4bG1WXUr7DcR97bmQNRnU0rYVtENR5tnSDEEsM+7VoqI8pTzyGT7vOJrDV2s050AYZfQ2u5QgnEiCQSYy387+fEXqxQEpqXf9J02Aq2S5bT+DrjxHtH/QCkeOASctT7sbDfSqD9Kykj5OZV9V74nhEmvF3Rg6pCwFelbX1j27SJUHGt7ssm2hbti3oZasG5v17f+TWtJgdsd3Lz3oPo1HlAXqEDcdOYYuLqbnTcFepoOmYn8jltBnxH8fv1TQluNmYAI+tOfJmbesIw/PWBS2lZT4ICU3MpwJn2jnFgzKlQK09IlxDlCUVGzPE50ICT8EGr/CqA4MLglcFHT2Rl+vzlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(9686003)(186003)(1076003)(8936002)(66946007)(66476007)(55016002)(4326008)(5660300002)(8676002)(6666004)(16526019)(6506007)(52116002)(478600001)(7696005)(316002)(86362001)(66556008)(53546011)(110136005)(54906003)(38100700002)(2906002)(142923001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9rLVRDRShu9JXgncBq0Zz3IaQeTsJ7JMy+ScjY/RzW2PtQykbRvhV5wYmRee?=
 =?us-ascii?Q?N1ZSYAyrpbZ+0VHiBM0Idplk6Sit4K+ieIidMvJ1pJVUORgfb22A17QB+AYd?=
 =?us-ascii?Q?sIgZMJrX/WjkXPLU+W4qSXjC7iKv3C1z3Dav0D11IomTeQF3jR8GKP+x2xY/?=
 =?us-ascii?Q?iUjOWl0Ec88dEekjd7G3MPUHK+1PlJFImIQCPuPixaIe0YOF8XAQ4KSSqD0f?=
 =?us-ascii?Q?YZ52vYh6rb96rxlAQdQYDMq5jSe3DU2kmaYidFFinWsc382LCxjXvkS0marM?=
 =?us-ascii?Q?Elk4XDIQWVnnfY+5d6ntkL+ZidwQeq3Vmi+059YCKqnCR+Tti3nc7MNrBDs4?=
 =?us-ascii?Q?Rc3unUGpYMd84fQvbBSHVzBC8qPFAZogWEZFmaejWcfgAPHZVaqMEzHfE0Xo?=
 =?us-ascii?Q?3UZo+l9/Jy9s6fJL5CGKjADLUG6bmW3wYkY32Vyj75OeJ4zL3hyTP3KAK/J7?=
 =?us-ascii?Q?WPCeKQYpq1IMHT8MUIqfEB7OU9i8UVRoOFHtZ9BMch+GlOG5A2sbiyxtqOtm?=
 =?us-ascii?Q?LrTnO7FTpkzGO4xNO5GNy7q3ec7qR7HzdJUOMK7O15ocXxbq3jM0/DIhOE5n?=
 =?us-ascii?Q?NDhxWh+ZCvp/SVknTh+ezk+dlIjQU1rn7emeKTXDeuTaJJjgBKqRRrgYK+cq?=
 =?us-ascii?Q?f3TLu04FDvdfpAvHxAHgyVouv068dhZM8fOxsLI3YVJUDawBBKlvJ8+Rk5sH?=
 =?us-ascii?Q?04ShNOvVs/2hIAxMwKRt0X5DexCt8mqnAaRKmZX/XmzXrtHAqtunSukT3anb?=
 =?us-ascii?Q?65HIslNWq5yY/vRhfLmf9iwGQ/cMOB2aINk8z6t19tohsGyLV6ESPUoqmud6?=
 =?us-ascii?Q?OIQhMXgkHL9oI9e/aFG0vQmZBI2hEVDRZlLAgqt4Jd9RzP0zF/H4Zg5GYuR2?=
 =?us-ascii?Q?aMYQD9JIiDForftE0U2iwN/Njb8MFaVS6O/DS8EiAHTCyVSby55v8ux3Se/Q?=
 =?us-ascii?Q?iQ8chdXM4T2IbAIqk3NNYI1y9pt8txlRS50Qaq2OBxov+ifTM3b/kfIG+C92?=
 =?us-ascii?Q?eg4F20AtdD1rAzNbdad2P71Q5YcPSVZ7kQ3kqHQKoX23EHwY+T1bgLgwI+4O?=
 =?us-ascii?Q?jhCElcX2LmVd4OC2S9rjgp1j3wZrxrz1914AzK5wgbN/rGPXVbXcL3r167A0?=
 =?us-ascii?Q?PtjkzB6JC6WGaxu4hNu4jpQsRVoyyEuo3w/Q5rrAx7dUqK+lr8eYygSuPppt?=
 =?us-ascii?Q?tpZN5DUT9CLwSGu2Z2loz+MnNgZ09FLcVdF5tBxWGLYcr2OBX4H79mBYkDd4?=
 =?us-ascii?Q?vbcuMK8Td5FzDFn/ExB+lwDJYbi7AEgec8LyaqqJojChFiZ2U22DNWmccCKb?=
 =?us-ascii?Q?h1RTpW5hO0pJETBR+ORVnFYudcvy+pNG4GS2v6YVdnaMEQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2123aa41-6eb9-437c-ed05-08d90c366e79
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2021 00:16:57.4115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIrHS9m6Mehd4DX/YCWJTOA3RZ2UiyZxyS/9fpGc6DFNfSVk6LKmUy65MuUozmqo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4679
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: DdB61IIT_lw7v7F9YWx4XpbOte8ur4oC
X-Proofpoint-GUID: DdB61IIT_lw7v7F9YWx4XpbOte8ur4oC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-30_15:2021-04-30,2021-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxlogscore=830
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105010000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 27, 2021 at 01:38:20PM +0200, Jiri Olsa wrote:
> On Mon, Apr 26, 2021 at 04:26:11PM -0700, Andrii Nakryiko wrote:
> > On Fri, Apr 23, 2021 at 2:37 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > BTF is currently generated for functions that are in ftrace list
> > > or extern.
> > >
> > > A recent use case also needs BTF generated for functions included in
> > > allowlist.  In particular, the kernel
> > > commit e78aea8b2170 ("bpf: tcp: Put some tcp cong functions in allowlist for bpf-tcp-cc")
> > > allows bpf program to directly call a few tcp cc kernel functions.  Those
> > > functions are specified under an ELF section .BTF_ids.  The symbols
> > > in this ELF section is like __BTF_ID__func__<kernel_func>__[digit]+.
> > > For example, __BTF_ID__func__cubictcp_init__1.  Those kernel
> > > functions are currently allowed only if CONFIG_DYNAMIC_FTRACE is
> > > set to ensure they are in the ftrace list but this kconfig dependency
> > > is unnecessary.
> > >
> > > pahole can generate BTF for those kernel functions if it knows they
> > > are in the allowlist.  This patch is to capture those symbols
> > > in the .BTF_ids section and generate BTF for them.
> > >
> > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> > > ---
> > 
> > I wonder if we just record all functions how bad that would be. Jiri,
> > do you remember from the time you were experimenting with static
> > functions how much more functions we'd be recording if we didn't do
> > ftrace filtering?
> 
> hum, I can't find that.. but should be just matter of removing
> that is_ftrace_func check
In my kconfig, by ignoring is_ftrace_func(),
number of FUNC: 40643 vs 46225

I would say skip the ftrace filtering instead of my current patch.  Thoughts?
