Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE614578F59
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 02:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbiGSAgf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 20:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiGSAge (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 20:36:34 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB7A18E04
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 17:36:33 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IGhjeG029579;
        Mon, 18 Jul 2022 17:36:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=qei3CwQR59RJ+78d5EIK82rF1M/GZbGbahJnBUbCirY=;
 b=QXllukl9/7Z/ooSZibGUiK5SuefES86h6WN06o9cwS1SmAzIvHbMmIGJrr1muWzHov+z
 hgn8IqUs0y6UG64CTcD2a5jEjEymELJbDhkjw53toDXp5xhLQtHeew3+BTOnAOEPU5hP
 FAX7DUaprzKfXFT/Uvkgl5hQd410MsDibhc= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hd7excax9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 17:36:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hg59FXh2vouijQ9W+u8SzaJnrECeie7GXEY4O6T04Chhxb6NAu+irG9ryNsvmHRqs+MQF9cYbd8f249Oyr9+NJGK9wC8ro7kaERvS5Sf+yYRdZF+rVwsHJqqs6QiyKtOraf/Sa/RVVvgi0JVefqJTdvusuEuSvWCXLp5i+TIuKhJ+l5S8fbaWOepeilLl/RKAQq6dhmGV8BkbYgnZ9AvNpir924iWHdtTYtYTCfW10WijefH4xgGJtYwalqxvF6rvSg0tfpWmVV4zDnNkAzrs28eAiEt7wTsn3gTRr+qICu5swftNRfyebhBvKd9aDNvLy12T7i+3WX9MktwvpcyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qei3CwQR59RJ+78d5EIK82rF1M/GZbGbahJnBUbCirY=;
 b=Tc15lWVMGhwapeTjWRCic0re8hcJokF8CTH94xtosfmHrIHkSA15xRvtJp9hUgBoHHNL0JBi16M/fqiNsZfjDvoemXFOYskFY+Tm4uMJjDdclFIu+QSRS5W/KGRh9qJhrT9yE9WzxjeTnlY7yG/3dxfvaHVVViYJ+2sPvwHQUTW/pmOuPIkvv3RqxO0yw3m0Brp4A3Xn0Z8CgnOphhG9V6bCJ07Y6EHKKvd1DmoE56rbwVdUER2fsgagV9zB+DlT0C5qVyHbR2xoJTZ6ta0Mdi2bpe7RCnNnIQ44GO2Agve8f5zslGqECwOR0rwH3CL3laq/r7Of3wUOwI9EQHGtzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BY3PR15MB4995.namprd15.prod.outlook.com (2603:10b6:a03:3ca::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 00:36:15 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2%9]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 00:36:15 +0000
Date:   Mon, 18 Jul 2022 17:36:09 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] bpf: Add kptr_xchg to may_be_acquire_function
 check
Message-ID: <20220719003609.5yfchxkbxuyonir6@kafai-mbp.dhcp.thefacebook.com>
References: <20220713234529.4154673-1-davemarchevsky@fb.com>
 <CAP01T74k86cwBk22M=YgY=Vao196_wDezvmHjk5u_Nry98A6hQ@mail.gmail.com>
 <deb5310a-5ff5-0612-61f2-90d78a0bb147@fb.com>
 <CAP01T76iyDGvmWf1Sra153_3bQ1h5QpJm5NkgU9p31LyFUuuRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP01T76iyDGvmWf1Sra153_3bQ1h5QpJm5NkgU9p31LyFUuuRQ@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:208:256::7) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 555cffbb-8cc4-4947-1cf6-08da691eafd8
X-MS-TrafficTypeDiagnostic: BY3PR15MB4995:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NpMzfcLhU4DgXKzL3FOCgr/VxHDji91fqLaYktBM6Hk0KrcAvP3EWmzJgzqPdOnVQeupjHnULtd6CIHxNF2inf880358Kfk8W9r9FtdoIwTTSxavdrrMDoKLsDotPkBErMgU9sd6BJz4jno5G+LgxQm9P3Vou4JB1Xil+T6v50gBFEiWLOGnfjc75MQGf1Kc5KIffeFgmpZN/K0n1LaScdAZ0Lv529/Uja9zSK3bE81bWrQ71+GESq/SyXeluqoauYCJh+PlzUVldm+1ibzRo0hETOgCqUZ3Bad3aNxOD/lUd15zfb0dy6PpRqDKXHB17UXQzzBlJPF7jR78hg9sLzUlo1ITqqOoQZzmdu+Xjidclnn66/aC203bK1UCNUENJ6lELjcmR3I7Ho9cTQfnKNgLDu5g/1E18F5h7/K4rL9g57CWfUD+kW/Tw+TJ+zvcMfmabBXHsa9tgqdNdhuNpHj6UoKSIy2XloZMPC+r/ix/Y2eLhM4/s3mtZub1FJEvZRNqcRowpltfxjJ/lUKaLnE2bvZAuppzpq/85EbRxppQ1giXWfVn3Dk307ZNvwZhGDeN+ipnIgF3/8C3MFGDKJT8IlOLtqgGV3ug1P6hrAoBU5W5voIvBUGBc/GGiPbywyUilDJtUTCZfSATWuP0frZtZ7/rJGz43q4cKnVBaqQXUE4E6XDzqasSjk0sSzwd/wIErYHk0932uFgHmfkihnd2/ZdonGgHm09Uf9X9S6dLqhpU+zkj2lB51/RuB2Jl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(83380400001)(110136005)(186003)(66556008)(54906003)(38100700002)(66476007)(8676002)(316002)(66946007)(6636002)(478600001)(52116002)(6506007)(2906002)(53546011)(8936002)(6512007)(5660300002)(86362001)(9686003)(6486002)(1076003)(41300700001)(6666004)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXRUc1NIZmgrWHQxeERDL1lyYmxNRndvanV4ZUwyZkVkZVJsaHV0eGxkcFYw?=
 =?utf-8?B?OUNoOUdOMHlvYWtZYWtGVTR1dFRUWS9maGJRaXlYYWZPQ3JkTm9GQnE0N3Vi?=
 =?utf-8?B?U1lUTmlXbzU2QjN5QkNKWXFLU0RMUE9oR3c0bUNyaE9IS0hqQ1JWYmxnV0F2?=
 =?utf-8?B?Q0JJdS9TalV2ZHBMM3dyTzRKRmMzZE1VZ1ZWRnY4V21kWmk1SWRObndJN0lS?=
 =?utf-8?B?N1hLVno4eDRiRm1ZMGg5bEU1amlMR1lDSDA5d1gyRE8xTXRPcUdja09DTkxC?=
 =?utf-8?B?WkV4K3NLTUlIVVhVbExKUWZOb0w1K1d1QnltN3M2Z0lvcGdhWXAvWFdtTVll?=
 =?utf-8?B?YVBWVERMSGpiRFlXZFRVRjJBMDBLSEZiY1RoVUw3bVBVaHVUUnZaRWxPMElk?=
 =?utf-8?B?WHJEYXNTanAxQk5tMC9GQXB6SUVINldyUDlXUWV0VmcybzA1S29CbEJ3NDNW?=
 =?utf-8?B?TUpPMm1xT3hNei9zV3QvTE9TMmxXbW5jRit1eVhjajBHNHFzV0RyT2tQL1BX?=
 =?utf-8?B?QXJXMGhGWjlPU3p6L3lhN2VZNVJVbDFQUlliRnBCYXh0OGF4bCtXWkJlZGQ5?=
 =?utf-8?B?Nyt3c2lZSnhNQ1dqRzlRcTVFc3BabWl4Y1RRNHd4TktpZWZ4Q0Y5TnkyMEFv?=
 =?utf-8?B?MU5qcG5hbHU0djNhS3B6bFB2OWhTL25aWHdyenJCQ2RaVnNOV3lSRFc0eVpU?=
 =?utf-8?B?bmV4V3ZJUzFQQ1NkOFY4MGM1eS9lTW5MQzlycjd3eFg2NUM2ejVLTHZlUHJv?=
 =?utf-8?B?NFowdUVRZE1RcGhUQ2F3dEM5ajZkZnRBcHYwZUF5UWZKRTBsQ21hTlI5VzBR?=
 =?utf-8?B?czBIWnFWOVI0czhJalpKZVkrQy9UTDQ2NUxEWTVHM3hrSHVIa0pLSTRkOHBT?=
 =?utf-8?B?dVZuQ1M2Vng2d1FYTmw3b0JMbUZBZXZ4U2hLTVBmekp6V1VteFo2dC9CKys5?=
 =?utf-8?B?ek5ZSlpFV0xCRHFqeTBvYVdRRC82WDVXK0NhTjFya2NrR2RBWk50N1JZcXMy?=
 =?utf-8?B?SXdKcVBWbjlIQzRUYUw0bnZiT3A0TlFuaG54aHdsQVB0KzdpcUwrcEVlbkxK?=
 =?utf-8?B?UHpZcUtyS1hxZzE5TGU1VGk4V2RnVjUvcThLWkZmdTV0OVFKd0FVQzl2RXNZ?=
 =?utf-8?B?bGEvYWlzOVkzZmI1OE9HcXJZRENuMkxSbmxwR2JJTlEvUnRGVXowL1dWbXU3?=
 =?utf-8?B?TWRmL20zYzNieEpkUUhaUkRWYjBYS29nMHBINmhSa3lvOWM5OVlldVBOTEVY?=
 =?utf-8?B?enhjZVRtOTROKzArUDZ2YlBlTm5CVUJuL1RIT1FuL0RnYlBOTFBEeVYrMDBY?=
 =?utf-8?B?RzNWdStDM2FPZThQalNKL3dVZU43YU9LSXpOcnB6UllWNDlETW1Lbitqc2NK?=
 =?utf-8?B?Ui9NRm5Db2dGdCtzU2F2dUZWMG5aVGZwandlZytOVzY0RlAvTDk0SVh0S3Z4?=
 =?utf-8?B?cjE0SVZrVmpHdU85NnhlUEdhVkExSkhsTGxJbWJOcFhVeVZ6Q3hTN2NDMG5J?=
 =?utf-8?B?VGZZZnRjaysxWWt5ZWxFMlhma01xTkVlSmY0WlpEalE2eTRiZ0ZadUVCM1Fy?=
 =?utf-8?B?bHo4YVdvMXBoZGFHRW1ZMW9SaFRra0xGT0lmSUpnOTJhdEcxY3NjQlhQdWxi?=
 =?utf-8?B?WFNFbUZBQ05jVkJSQzlCZHRxY3E1NXlqaTdlU3lnOTh6a1gxWk15bVlqWkdN?=
 =?utf-8?B?bHFJYkdmTElpVTdWdnZ2dzRhbnd5bkc0MDdCYlZRb0dWRXlFd2xaOXVjVFdQ?=
 =?utf-8?B?Sll6SnZvYVJVejl3TjllWFh5bW83QlVPRG5rZ2x5TnlHLzAzWUtWQWd0Tld1?=
 =?utf-8?B?VU9nb1EwVURNdXF3UkFVeVRwQ2dzR3JtV0QrTVFWemg2ZzJSbHNZWVBjUWVR?=
 =?utf-8?B?d2JuVDZHRXhQYkFPU2lrdFJvU3JmTGlhT3F1QVYzckQwaXpCNVZYdkFGRTlq?=
 =?utf-8?B?OWdGVG94aDFzaUVZNitkYzNhVG41MmNENU1VdXVmbUdHS21VTlAxZDVqOVVU?=
 =?utf-8?B?VUx6N1ozcjVkNFlQRjZKT2VSV2V0WHl2WTY5NVNva1ZTWVNnOG9BWkFpSnNL?=
 =?utf-8?B?TUI5LzRFT1JKelBmY21tN2dvRFpveE03aHJaTU1SMnN1Y0FlbGRMRE14elZU?=
 =?utf-8?B?ZVZtREM0aG1vWEhWaXlTZnFzYXVzWHNmL2ZHNllmVGZlMk9HUDR3Y2hFL2Yx?=
 =?utf-8?B?MXc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555cffbb-8cc4-4947-1cf6-08da691eafd8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 00:36:14.9425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNWMKmmPKCVPcc2anl8bPpNdQAUZdKOC721QrO52q6kq5ONAo2KnmsRMO7C3Xf24
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4995
X-Proofpoint-ORIG-GUID: D98ei10f6QWuT1Z-grNNjMO-dU4LqqA_
X-Proofpoint-GUID: D98ei10f6QWuT1Z-grNNjMO-dU4LqqA_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 15, 2022 at 01:49:28PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Thu, 14 Jul 2022 at 19:33, Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >
> > On 7/14/22 2:30 AM, Kumar Kartikeya Dwivedi wrote:
> > > On Thu, 14 Jul 2022 at 01:46, Dave Marchevsky <davemarchevsky@fb.com> wrote:
> > >>
> > >> The may_be_acquire_function check is a weaker version of
> > >> is_acquire_function that only uses bpf_func_id to determine whether a
> > >> func may be acquiring a reference. Most funcs which acquire a reference
> > >> do so regardless of their input, so bpf_func_id is all that's necessary
> > >> to make an accurate determination. However, map_lookup_elem only
> > >> acquires when operating on certain MAP_TYPEs, so commit 64d85290d79c
> > >> ("bpf: Allow bpf_map_lookup_elem for SOCKMAP and SOCKHASH") added the
> > >> may_be check.
> > >>
> > >> Any helper which always acquires a reference should pass both
> > >> may_be_acquire_function and is_acquire_function checks. Recently-added
> > >> kptr_xchg passes the latter but not the former. This patch resolves this
> > >> discrepancy and does some refactoring such that the list of functions
> > >> which always acquire is in one place so future updates are in sync.
> > >>
> > >
> > > Thanks for the fix.
> > > I actually didn't add this on purpose, because the reason for using
> > > the may_be_acquire_function (in check_refcount_ok) doesn't apply to
> > > kptr_xchg, but maybe that was a poor choice on my part. I'm actually
> > > not sure of the need for may_be_acquire_function, and
> > > check_refcount_ok.
> > >
> > > Can we revisit why iit is needed? It only prevents
> > > ARG_PTR_TO_SOCK_COMMON (which is not the only arg type that may be
> > > refcounted) from being argument type of acquire functions. What is the
> > > reason behind this? Should we rename arg_type_may_be_refcounted to a
> > > less confusing name? It probably only applies to socket lookup
> > > helpers.
> > >
> >
> > I'm just starting to dive into this reference acquire/release stuff, so I was
> > also hoping someone could clarify the semantics here :).
> >
> > Seems like the purpose of check_refcount_ok is to 1) limit helpers to one
> > refcounted arg - currently determined by ﻿arg_type_may_be_refcounted, which was
> > added as arg_type_is_refcounted in [0]; and 2) disallow helpers which acquire
> 
> I think this is already prevented in check_func_arg when it sees
> meta->ref_obj_id already set, which is the more correct way to do it
> instead of looking at argument types alone.
> 
> > a reference from taking refcounted args. The reasoning behind 2) isn't clear to
> > me but my best guess based on [1] is that there's some delineation between
> > "helpers which cast a refcounted thing but don't acquire" and helpers that
> > acquire.
> >
> > Maybe we can add similar type tags to OBJ_RELEASE, which you added in
> > [2], to tag args which are casted in this manner and avoid hardcoding
> > ARG_PTR_TO_SOCK_COMMON. Or at least rename ﻿arg_type_may_be_refcounted now that
> > other things may be refcounted but don't need similar casting treatment.
> >
> 
> IMO there isn't any problem per se in an acquire function taking
> refcounted argument, so maybe it was just a precautionary check back
> then. I think the intention was that ARG_PTR_TO_SOCK_COMMON is never
> an argument type of an acquire function, but I don't know why. The
> commit [1] says:
> 
> - check_refcount_ok() ensures is_acquire_function() cannot take
>   arg_type_may_be_refcounted() as its argument.
> 
> Back then only socket lookup functions were acquire functions.
> Maybe Martin can shed some light as to why it was the case and whether
> this check is needed.
Trying to recall from the log history.

I believe {is,may_be}_acquire_function() in check_refcount_ok() was for
pre-cautionary.  At that time, in check_helper_call(),
regs[BPF_REG_0].ref_obj_id was handled for is_acquire_function() first
before is_ptr_cast_function().  If somehow a func proto could do
both 'acquire' and 'ptr_cast',  the ref_obj_id tracking will break.
May be a better check was to ensure a func cannot be both acquire and
ptr_cast.  This ordering in check_helper_call() is reversed now though,
so I think may_be_acquire_function() can be removed from check_refcount_ok().

Regarding to the original 'return count <= 1' check in check_refcount_ok(),
I believe the idea was to ensure the release func_proto only takes one
arg that is refcnt-ed.  [bpf_sk_release was the only release func proto].
Otherwise,  if a release func can take two args that could have ref_obj_id,
the meta->ref_obj_id tracking will not work.  Think about only one of them
has ref_obj_id and it is not the arg that the func proto is actually releasing.
Since there is OBJ_RELEASE now and sk is not the only refcnt type,
check_refcount_ok() may as well count by OBJ_RELEASE instead of
arg-type.

> 
> >   [0]: fd978bf7fd31 ("bpf: Add reference tracking to verifier")
> >   [1]: 1b986589680a ("bpf: Fix bpf_tcp_sock and bpf_sk_fullsock issue related to bpf_sk_release")
> >   [2]: 8f14852e8911 ("bpf: Tag argument to be released in bpf_func_proto")
> >
> > >> Fixes: c0a5a21c25f3 ("bpf: Allow storing referenced kptr in map")
> > >> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > >> ---
> > >>
> > >> Sent to bpf-next instead of bpf as kptr_xchg not passing
> > >> may_be_acquire_function isn't currently breaking anything, just
> > >> logically inconsistent.
> > >>
> > >>  kernel/bpf/verifier.c | 33 +++++++++++++++++++++++----------
> > >>  1 file changed, 23 insertions(+), 10 deletions(-)
> > >>
> > >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > >> index 26e7e787c20a..df4b923e77de 100644
> > >> --- a/kernel/bpf/verifier.c
> > >> +++ b/kernel/bpf/verifier.c
> > >> @@ -477,13 +477,30 @@ static bool type_may_be_null(u32 type)
> > >>         return type & PTR_MAYBE_NULL;
> > >>  }
> > >>
> > >> +/* These functions acquire a resource that must be later released
> > >> + * regardless of their input
> > >> + */
> > >> +static bool __check_function_always_acquires(enum bpf_func_id func_id)
> > >> +{
> > >> +       switch (func_id) {
> > >> +       case BPF_FUNC_sk_lookup_tcp:
> > >> +       case BPF_FUNC_sk_lookup_udp:
> > >> +       case BPF_FUNC_skc_lookup_tcp:
> > >> +       case BPF_FUNC_ringbuf_reserve:
> > >> +       case BPF_FUNC_kptr_xchg:
> > >> +               return true;
> > >> +       default:
> > >> +               return false;
> > >> +       }
> > >> +}
> > >> +
> > >>  static bool may_be_acquire_function(enum bpf_func_id func_id)
> > >>  {
> > >> -       return func_id == BPF_FUNC_sk_lookup_tcp ||
> > >> -               func_id == BPF_FUNC_sk_lookup_udp ||
> > >> -               func_id == BPF_FUNC_skc_lookup_tcp ||
> > >> -               func_id == BPF_FUNC_map_lookup_elem ||
> > >> -               func_id == BPF_FUNC_ringbuf_reserve;
> > >> +       /* See is_acquire_function for the conditions under which funcs
> > >> +        * not in __check_function_always_acquires acquire a resource
> > >> +        */
> > >> +       return __check_function_always_acquires(func_id) ||
> > >> +               func_id == BPF_FUNC_map_lookup_elem;
> > >>  }
> > >>
> > >>  static bool is_acquire_function(enum bpf_func_id func_id,
> > >> @@ -491,11 +508,7 @@ static bool is_acquire_function(enum bpf_func_id func_id,
> > >>  {
> > >>         enum bpf_map_type map_type = map ? map->map_type : BPF_MAP_TYPE_UNSPEC;
> > >>
> > >> -       if (func_id == BPF_FUNC_sk_lookup_tcp ||
> > >> -           func_id == BPF_FUNC_sk_lookup_udp ||
> > >> -           func_id == BPF_FUNC_skc_lookup_tcp ||
> > >> -           func_id == BPF_FUNC_ringbuf_reserve ||
> > >> -           func_id == BPF_FUNC_kptr_xchg)
> > >> +       if (__check_function_always_acquires(func_id))
> > >>                 return true;
> > >>
> > >>         if (func_id == BPF_FUNC_map_lookup_elem &&
> > >> --
> > >> 2.30.2
> > >>
