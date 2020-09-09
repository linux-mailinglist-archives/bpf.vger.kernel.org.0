Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D832626EE
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 07:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgIIF5T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 01:57:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5192 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725807AbgIIF5P (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 01:57:15 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0895sCdt008624;
        Tue, 8 Sep 2020 22:57:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=rh3Q//YplmmBpZ9RAxm59n5f50ymhJT2rr67VqXDfJs=;
 b=LnvMKGSKpQesxbwXyCFLmypo+xPKrsEBX7+FxydTbwgVUy5lormELfjUxvnH9jgKd08l
 xl1PLbUdYg4M1eIK4yxzzwkXQL/M6olKW3HYr54cwmKsIzAdfGM1bC31ZkOtXRRcCq9R
 4BMZSZDqC5Cs9h8vYFIWJ2kWhafEuAl5CCQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33efrwjghj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Sep 2020 22:57:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 8 Sep 2020 22:57:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPQWnBVHdBGqZpLEFOfscgJ2UHQNtO8itew1suEerhnoxzwG1qUAesUBEze7CYaMVCax2ExdI+Vz2Lx9WLa12ue6muoqt6qoC2Y/5PoFPA1hTeYT3vjYGsNix1YSam+lOVdS3kBHA3/lWOD8raVX0wXJzn+YDNQCeIivflhyWikydGJze4F1wpJrOVCyVEXqR/GJIH6z9Kj69yHN31gwvsRrKcE6fX1/vhIf5wezH0fmLB6pnt2wKUTiurAf3qXhJp8wKKyJQGVGGTVyoRwuaCJjtNnd3GH4ChpaU52a5dkBQDgV9OJqnBi/GMQx9suAC0Fro0SDijfX0+ktfydUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rh3Q//YplmmBpZ9RAxm59n5f50ymhJT2rr67VqXDfJs=;
 b=BZA2VGiy/ZZz04CjGPsxFJCOTWGZtxXzf4SRN9iqHR/3SgyxdehsOwMoQ3G7qpSP0D7FHDZhY0k+HZJaME32+BKwtHSVqOisK/xpIZiwkkzHD7ByF6Wd1P0u5la5C9vXSDej7RiupO2XBaVb6ncCYE3lt/KXB0XTJOvv4PGP+8CMN1NsjivvWaR835QneYEScEvdYdRwvLuCHGXqMOHflp747Qrmbdtq9gyMOHhFl9Zn2sZU4nd/bqRxgX0SBvjM4d1TXzS/OJgrruMbXd40UElEbrKBldU4HLWbPfSXVnR4CoKMprTjSfPznqo9xaxoQk72rFOSe98kbfAj3L0taw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rh3Q//YplmmBpZ9RAxm59n5f50ymhJT2rr67VqXDfJs=;
 b=fPeec/1LwFHiZADDXbwDwwgl4pU/QQHxAW7icZgmm/RzbJTQIb32enuWM6iabzCJKWrLX2h1LjC5uc4dtcJcvW+KkilFwGvLS2m4Ikt4LncJXkK+k7c5O9So3H2TtceIIf1cdHQ0Fv4+7imfp8sed0KnMM6kNSu0ymcmWrgh4P8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3045.namprd15.prod.outlook.com (2603:10b6:a03:f9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 05:56:59 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 05:56:59 +0000
Date:   Tue, 8 Sep 2020 22:56:54 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next 05/11] bpf: allow specifying a set of BTF IDs
 for helper arguments
Message-ID: <20200909055654.sge564w5nws5krlj@kafai-mbp>
References: <20200904112401.667645-1-lmb@cloudflare.com>
 <20200904112401.667645-6-lmb@cloudflare.com>
 <CAEf4BzbPJKK+YPTgPmaUVsKg3GQdwJKypfSZXg09M+sY8BzDbQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbPJKK+YPTgPmaUVsKg3GQdwJKypfSZXg09M+sY8BzDbQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR06CA0039.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::16) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:d222) by BYAPR06CA0039.namprd06.prod.outlook.com (2603:10b6:a03:14b::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 05:56:58 +0000
X-Originating-IP: [2620:10d:c090:400::5:d222]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 635f8fab-bbc4-4f48-6228-08d854852a4a
X-MS-TrafficTypeDiagnostic: BYAPR15MB3045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3045AE5AF13657F1DE795E9BD5260@BYAPR15MB3045.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lfrgcr2wyFejeJunm20C3w0OIFej2H/Q5onHADrU38z4Y9+To6wuJ2di5/qKHlI4y1PNEQ2yTEkmyYcoZQH1MvrvwQG32lB8HG9dUfibln3iQfcBEAAZaywq6TVFvD3y14hrSnuF2oPv25ziwGtjPh+lG4ivCnQY/qLlBZksOaGUCtCtINuMuzZm9N35rWfqSECU6S3drBNEJWaZjyR0hvwONlWLrQQX6yXJjrfyXIP5q3RCCa96dSV3R1UoDCWCDFdmx0re8titU6uZ+m2t4APscUbp3GzK/w+xraX6CKWjrdZozxjq+jvsZbxZT/41eTqAxBw3TiDY9Zf1wRHv5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(66946007)(55016002)(9686003)(66476007)(66556008)(54906003)(186003)(16526019)(83380400001)(6916009)(8676002)(2906002)(316002)(6666004)(86362001)(8936002)(478600001)(53546011)(6496006)(4326008)(33716001)(52116002)(5660300002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ZgPyjVBEF7PcI1kolK/7TCUepD7ZtykimKC5PfcTKux42V9OS5vgEm79Cv8sRlfEw3MKO5NGcZPpjGQOVbGk3lOjlnAEWcfBCny9dnLOb3opDAB0DaFxaFIEV6qDCcE4QAu2dQEYyrnxnkiH/FCCvZBhgArNSnAC7QvfVenz9wjV1eJoQUU1h1cfAcgXlqzBJ8PTX9j0p04Va8oPUkDinjy87EgriKc23eN6SV9qJQ0Fj0p8z0cOd0uk/jcr2P28v5ey7eBQ9l8lKSAMmvVwzaqvjz2/BZmA3DyWvfpczeROWyAFRHG2s/N5vHK0L1cPNc5hrfAg03v00m/oL86en7X77+nb/e4biw7m44fWgNm08nzcR/VXknYAlyTDRbiZrxMfmLKqe8W4brRtjdVXSOH1do9Od4GvEtYbF+KEgX4lsvsmZLDz0lYHEj090Emhim9ovmACCJTRtSbItgMB/zHMf4OIEgLYf1C7Po5tlg4pg6HtNsqHsauWqDlmsyGOQgK4TsNINZnk37fzawdIEGV3nJbnOFUdLqj1K2H7UgkmRGe5NeUmLt9tlbIsZyuZXv3kiup35SXNcP7Htwv4iuwXxQ1ABbkEn1tkhzLLqthz/cilZul8IcDrYeVtu2mMQvWmZblNPIiAAj30oExVoYVYFNlVVX2cwTILxJ7D8Tg=
X-MS-Exchange-CrossTenant-Network-Message-Id: 635f8fab-bbc4-4f48-6228-08d854852a4a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 05:56:59.0916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsBuvdM06TsfK8sckeElAvmJx7VLZVC+qSqiymlM/a9yzCAWSkprk/BcFrN4ZAF6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3045
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_03:2020-09-08,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 suspectscore=1 clxscore=1011 priorityscore=1501
 spamscore=0 mlxlogscore=981 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009090054
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 08, 2020 at 09:47:04PM -0700, Andrii Nakryiko wrote:
> On Fri, Sep 4, 2020 at 4:30 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >
> > Function prototypes using ARG_PTR_TO_BTF_ID currently use two ways to signal
> > which BTF IDs are acceptable. First, bpf_func_proto.btf_id is an array of
> > IDs, one for each argument. This array is only accessed up to the highest
> > numbered argument that uses ARG_PTR_TO_BTF_ID and may therefore be less than
> > five arguments long. It usually points at a BTF_ID_LIST. Second, check_btf_id
> > is a function pointer that is called by the verifier if present. It gets the
> > actual BTF ID of the register, and the argument number we're currently checking.
> > It turns out that the only user check_arg_btf_id ignores the argument, and is
> > simply used to check whether the BTF ID matches one of the socket types.
> >
> > Replace both of these mechanisms with explicit btf_id_sets for each argument
> > in a function proto. The verifier can now check that a PTR_TO_BTF_ID is one
> > of several IDs, and the code that does the type checking becomes simpler.
> >
> > Add a small optimisation to btf_set_contains for the common case of a set with
> > a single entry.
> >
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > ---
> 
> You are replacing a more generic and powerful capability with a more
> restricted one because no one is yet using a generic one fully. It
> might be ok and we'll never need a more generic way to check BTF IDs.
> But it will be funny if we will be adding this back soon because a
> static set of BTF IDs don't cut it for some cases :)
> 
> I don't mind this change, but I wonder what others think about this.
With btf_struct_ids_match(), the only check_btf_id() use case is gone.
It is better to keep one way of doing thing.  The check_btf_id can be
added back if there is a need.

I think this only existing check_btf_id() use case should be removed
and consolidate to the bpf_func_proto.btf_id.

Also, for the "struct btf_id_set *arg_btf_ids[5]" change,
there is currently no use case that a helper can take two different
btf_ids (i.e. two different kernel structs) at the verification time.
The btf_id_set will always have one element then.  May be we can cross
that bridge when there is a solid use case.
