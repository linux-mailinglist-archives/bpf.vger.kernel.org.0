Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E974C25F102
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 01:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgIFXFX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Sep 2020 19:05:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39234 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbgIFXFX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 6 Sep 2020 19:05:23 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 086N4nMM032569;
        Sun, 6 Sep 2020 16:05:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=p7qeJBk/tUza5IxryS8B/QQkbwOuoIIshdtABofKC7g=;
 b=JT2kh0PnZPAaEAWo45KcrqdBU8t8tF87jY77fEFGRGTbGYCaKJFeMAgofggDFjmG09yd
 DGWxDvwUdn/hYV9ufDKVb83SGgvLZwOQbm1ur4WANncKMm222aGy/l7Eas7FaKlnOq0e
 Z7LfUL4hcUxCnFjs/QxJunMAdUilS+poizg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33c86m55jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 06 Sep 2020 16:05:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 6 Sep 2020 16:05:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b14lgHv1XCPFW91y5AAFzZyytaK8pCZKcrwPKc6rSFu/TCpg2Q356J33jHXlrCiN0xCgiUX3JgStAiORJn+rFGyGfjgjNhjv8vkb/rz2RcPM5uG8neFsyF8bWljBEDTEcIVouJsJ1VmnwUx2nH11GjPUL3WRYKdWoUeVGz8drze9NtluTruD6PoPzB0vSs0woFyHaYKADICaFS4aJx/I5qtOJnA5M5sCchtYesfvN6/bQyoQr+LLscg4wpcNC/RdrM6Mz4bpBbMxBQD3GYF1svy3Ek7aqJHQn9PT36LcNLt05ny5RiRWxU5temEMVNVvtlFa7vnEvN2CelzMDdCABQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7qeJBk/tUza5IxryS8B/QQkbwOuoIIshdtABofKC7g=;
 b=HiBjo+gtJMpyzhB/7xpdoEKtoEDqXPnRTZQAYKOfzRuyuyb0PAqvYbJdjz/gWjpfPFBqVjBlpVW1hznp1c3vEkYcIamH6rXba/lKXWxvZsE9D+KyzkmzCPUv3WaxIt3EhNBqk6Fb5Vjznvn60ExKO4muPFUBpNV7mL0W4TDU4SM9e1P9/f86KGhn8zfQLLp/iL31c9HvLMCTjOY6RxYVg/SMKsqSxd+x3RXgKHD6tVu+nl33pUzkAPS6308k41AqYwsD+8qpMzO54YMn+QktV4qNK7WqILL943ZOqHEJBsvvT3HGvasdHq45z3rOfOt+IhrK36lqm23j5kklrgg40w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7qeJBk/tUza5IxryS8B/QQkbwOuoIIshdtABofKC7g=;
 b=GDQBmvIK9aiWkH8aML1kVb6wzQpx5qPquPAQZOx2Z6i+KLgNVGTRGXgUS+S11gxgl06CrE/CPuWQXpgcI+e+gtXXrLycxx7eqbS67luLi3QGbjluw6MiPnUadW5PHwirno7fwDvpl4QBmsCAZDnGSL/tY34CX5usFg1MoaX5T60=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2373.namprd15.prod.outlook.com (2603:10b6:a02:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Sun, 6 Sep
 2020 23:04:54 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3348.019; Sun, 6 Sep 2020
 23:04:54 +0000
Date:   Sun, 6 Sep 2020 16:04:48 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     <ast@kernel.org>, <yhs@fb.com>, <daniel@iogearbox.net>,
        <bpf@vger.kernel.org>, <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next 05/11] bpf: allow specifying a set of BTF IDs
 for helper arguments
Message-ID: <20200906230448.rd5rzcgg47qdzblj@kafai-mbp.dhcp.thefacebook.com>
References: <20200904112401.667645-1-lmb@cloudflare.com>
 <20200904112401.667645-6-lmb@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904112401.667645-6-lmb@cloudflare.com>
X-ClientProxiedBy: BYAPR01CA0044.prod.exchangelabs.com (2603:10b6:a03:94::21)
 To BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:1a4) by BYAPR01CA0044.prod.exchangelabs.com (2603:10b6:a03:94::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Sun, 6 Sep 2020 23:04:53 +0000
X-Originating-IP: [2620:10d:c090:400::5:1a4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e23d886-5413-4185-6598-08d852b94402
X-MS-TrafficTypeDiagnostic: BYAPR15MB2373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2373BC6DCB0C4F4314754653D52B0@BYAPR15MB2373.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYH1KBWz/DJwhEO+A6zMV25zGeGie+EFn7DuW1TRSv/lrvIo/qxbFhhcCJtdrV/fzy1/SfXcjuKI0l0wi3xlZfZUpWksU9P4mfqWK+2p7643pMQQkndnlntkbUQeCLostrayaMSII5OlvoA/M2fgsouneBZ8wUVl7WNc5/V2fAvXtI0yzAnDoMqIgEZcr8Wbp8mNZ1qjthbBJ6+DWQw0qXGY7fRucvYpwYUG9hqOrAOsxGpBEqvnZ2yvldcLyfc+k5MeA4UXfOrzTT6+tHYoyRJv5BIf7nQGiI6rzwTW60EUrAM+rcXRR++K58bCn2esQ+Lk1B4jp2oRTmPX6G7C/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(136003)(376002)(346002)(478600001)(86362001)(83380400001)(6666004)(4326008)(1076003)(186003)(8936002)(66556008)(66476007)(8676002)(9686003)(55016002)(66946007)(16526019)(52116002)(7696005)(2906002)(6916009)(316002)(5660300002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 7j9uyQ2Kz5mHFekdgSFOSFgxd9l1+hBFEXFg3+vbNP8AS1g+8W+6IzrmS6XSr/dA5p6eDSWA2UIChMQF8q4EJYpBrstewNIKB+pn7VYpff9E33gsWwb5Kn0oj+jP7GFle5q28ppJBkXo6CTc0w4CzoCS2Hzg5h4byyLZoMl/bfYkjKT+auD2O/djsBFoiuQiKb8jDwOKWJ2zfEiuUjsm0pAPan5RtS2Vx819aqMhdt8zDPqll1GMcuk34x8NMNwhQf/+sjoomB2l1sm8k6DiGYRAlWrIxOyH2JyJlqriywKV05/ohZ+m3WXF0radzeqPwh5f+v9LyjzI5OaP4FNMWMEJdSvoWV8TpRRiaUk80WYHJnFaL/sWVwzvjBnsHP1rcT73xjpxfufHxeYWY6H+XwLGIXtuECseeZlAP54f+2AB//ECtfJcTJ5wg7HSk2BfiBbr9gs96OHCdiWgmbDtDg/1xFD9ePiSXilj1O9vF7JiJNXkTUJYmnyJd6vC3FKlzLc1Pu28EvogRO6D6jOT2v5v3S3e73VcwV9VAhFcV63ADLzehGIK+uO8WNpKsqN32K8vSn33kEFzZI3CsPb/53+NKrEp7QYxFkupQa0DgjTq+9twUTshY3E2WlLT3ZOkTIvJ/0+e4MaTveOs10eEJQtU1SE+yDG1jaylEVqTXCI=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e23d886-5413-4185-6598-08d852b94402
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2020 23:04:53.8848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4PFyd6kYXgmpbddHmFX7sSUf17mS4iZYNJ6SjhIxKapSo3VMtVTkPsndy6B7IFA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2373
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-06_18:2020-09-04,2020-09-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=1 lowpriorityscore=0 spamscore=0 mlxlogscore=933
 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009060238
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 04, 2020 at 12:23:55PM +0100, Lorenz Bauer wrote:
> Function prototypes using ARG_PTR_TO_BTF_ID currently use two ways to signal
> which BTF IDs are acceptable. First, bpf_func_proto.btf_id is an array of
> IDs, one for each argument. This array is only accessed up to the highest
> numbered argument that uses ARG_PTR_TO_BTF_ID and may therefore be less than
> five arguments long. It usually points at a BTF_ID_LIST. Second, check_btf_id
> is a function pointer that is called by the verifier if present. It gets the
> actual BTF ID of the register, and the argument number we're currently checking.
> It turns out that the only user check_arg_btf_id ignores the argument, and is
> simply used to check whether the BTF ID matches one of the socket types.
I believe the second way, ".check_btf_id", can be removed.  It currently ensures
it can accept socket types that has "struct sock_common" in it.

Since then, btf_struct_ids_match() has been introduced which I think can be
used here.  A ".btf_id" pointing to the "struct sock_common" alone is enough.

If the above is doable, is this change still needed?

> 
> Replace both of these mechanisms with explicit btf_id_sets for each argument
> in a function proto. The verifier can now check that a PTR_TO_BTF_ID is one
> of several IDs, and the code that does the type checking becomes simpler.
> 
> Add a small optimisation to btf_set_contains for the common case of a set with
> a single entry.
> 
