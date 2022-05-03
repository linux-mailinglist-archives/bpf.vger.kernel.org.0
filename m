Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A8C51917B
	for <lists+bpf@lfdr.de>; Wed,  4 May 2022 00:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbiECWfo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 May 2022 18:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiECWfn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 May 2022 18:35:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453E94132F
        for <bpf@vger.kernel.org>; Tue,  3 May 2022 15:32:10 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243LNH9O032436;
        Tue, 3 May 2022 22:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=d+VpG58gw7+UO9JUzX38i3I/6QE5ug3fnodKypyJMAk=;
 b=a2e4ts0bgJ4JviW5EuQB3sR7y2z7ez+desdsaDIZzO53IC1Vg3Kdp4P9+hibfgxZZDcz
 pmausirA9anDNGJLdoFl4mKTotou0sG0lII7I4WwFjIPwH/xM48ehh5nX0pCQ1M3abdJ
 cFWLQHnavtGoxbmBDZBsqawKsYEMXPODFsu8jfclR+/G9pGrhodtu3XCaBsCcP/shklF
 j0oUb46EfB920E7eRcMjFqPEfIyRPNrMglxHK/dVzfzvyqvcRrG1Hcr6jmY2gP0asaQP
 LZFHfZfToE+ExF4KDQ8f4Fge8fmWotfDI60khMDTNUf3GWAWBfoWzx7EhI8uYv8Monrp eA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0apsh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 22:31:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 243MQTjb018396;
        Tue, 3 May 2022 22:31:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj9dguq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 22:31:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtaiAfgf/y6tobQyz624L/y8nVp7a7awhiNt3DJPbRr2EJmPcDOMyeeIA8nOlPXzkcmyutFiAun7nn6W7SZV2fGNDHsbO9YKTFCVM26QFJHX6tMwzumOGjzznORWn+gT70MV4dseWz/leOS7fS719KiVkm2cFzaEEjsuV6Nm4d+sN2VzqruWwohREaST6BNg8lOTbyJGnl3CPObnxhWkSpuaVUk3zeDiQqoxupjyL862zm+Lq/80xn2OKbKs503CQ/AS8a6g5IBWM9A740w3t3BaW+W7Nt1gQy9wwc6gy/R6StG2kqITFaP+K2uVZZi4OUWsKeeAnpDOGeUTijhyKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+VpG58gw7+UO9JUzX38i3I/6QE5ug3fnodKypyJMAk=;
 b=kwOssHP6YpJkSt5jw4OKooXE6JCFIBAWghtKZef5Ay1mpTIsGsaEfi0O4tvEIt7gyVF4P/C2uCN+i7dwc2GjaeAt1AvOsP7SAJjA3W6fEbKiLmALDTsoYiH/JCyNIU78STi0wTMkIvYY46Wk23nF89k0BIc8sscBH8wBEI+DpEsbbGgANOnQtrgARC6HnB5+dTr7l4T0Hrudjw5mZlNynJBacoRfBh0cfoB4Cmlk4BJn1CkBUB30QdmLB43/fC3sLe2c6T8XZ3oacgRMLB+A6dJZjA8wLgc4dtCEuyOZN7oBHMTY0ebc5w9Z9BXrLkpPoZJ2GItKlxwHmt9SC2uOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+VpG58gw7+UO9JUzX38i3I/6QE5ug3fnodKypyJMAk=;
 b=HCmRQ3FmjoHwqKDQfPWKw5MRwRqgmH+hvjPYShWCLLmt9bv0fQcxTWL1DYNueldx4l7NsGyHmZlgp8VcJoftbDnrQ0riZsNEjo5BRQQFjoeSuWqvl1Wheq/D+PjcC/39WAI0yRcIDNTWdH/2I4QV54Zcx0b+tDLy0gRHFzTj300=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 CH0PR10MB5500.namprd10.prod.outlook.com (2603:10b6:610:111::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 22:31:54 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::5436:f9e5:f6bf:6518]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::5436:f9e5:f6bf:6518%3]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 22:31:54 +0000
Date:   Tue, 3 May 2022 23:31:31 +0100 (IST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@MyRouter
To:     Stephen Brennan <stephen@brennan.io>
cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        bpf <bpf@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: Re: Question: missing vmlinux BTF variable declarations
In-Reply-To: <87zgjy8qzi.fsf@brennan.io>
Message-ID: <alpine.LRH.2.23.451.2205032254390.10133@MyRouter>
References: <586a6288-704a-f7a7-b256-e18a675927df@oracle.com> <Yi7qQW+GIz+iOdYZ@syu-laptop> <f6f4a548-8e50-f676-8482-0ca541652cc6@fb.com> <8735jjw4rp.fsf@brennan.io> <YjDT498PfzFT+kT4@kernel.org> <878rt9hogh.fsf@brennan.io>
 <CAEf4BzbiFNnsu9pji5ifzj4nVEyAYYdqP=QVZ3XFwzL48prP3A@mail.gmail.com> <87r15iv0yd.fsf@stepbren-lnx.us.oracle.com> <CAADnVQ+YuxB8gZGjx+RP=04z4SgYEmPjEjDa_=Q6HmUecxK8QQ@mail.gmail.com> <YnE+k33iUtLH7Lks@kernel.org> <87zgjy8qzi.fsf@brennan.io>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: AM0PR02CA0100.eurprd02.prod.outlook.com
 (2603:10a6:208:154::41) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf7f10e8-954c-464d-b936-08da2d54b93d
X-MS-TrafficTypeDiagnostic: CH0PR10MB5500:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5500FBEF813D802D3E6D3AE0EFC09@CH0PR10MB5500.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVhdFMmv0jpIhjmwTFiUmVqPNfUTYiZpi3cVQpg7dMtk0jzvsPd4Rl2CDK4r1iB2hWKGNJL1eDMAMdHQzUIEdLdlSmhCB5afOimxwPDX9JTbzCe1tTcdOi8EWaFRp1H73f/HDCIZDbsozS/+cBx5ukgz7f63d8ef387UB5Rdi+GDGxw8+7/yM2DWc9OUIV0kM5uYEd/15GEGjzc5fANo63cu7MrKhgpecWYmHiyp8QIWNqYXklgJc75xqTgxGBiu7nrY96+e2WC5NqTpCP3InDipZTOgEzI0rWvxSJhb6ROGKFDoNGUuArvipbvn8wJRbXmvDudGqE5BDljcht/fmvnSxB9BP0Qjzii2qPXj1F8vq/l4TFZC9p0c+chJoDBGytqzc20gwf0sPdUmJkcyb7dFFmsHTe5NPlAW2I3eev4DX7X+ZfLRPKfQMV7tZolHWfqUytGvGjdPwL60uVjE5n+tFdg+f/GK21H5kkCX7KSwocXOw/RdmfwgLGeRt9OHZq7LhwtyS7vYbfdoYyZgMmKdkjiCXTurZk73ACfQhwyEv9+6nnhiDRjcWQatYX19HBeMxJZ8HkBXoKXvgerSK3mItiEE1g+PaoN7KZFwn8w48+0dkuGb9Z2ok3gYqqzCCwyPvs+AP2waNCGA0hd7uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66556008)(66476007)(66946007)(107886003)(8676002)(4326008)(6916009)(54906003)(186003)(316002)(9686003)(86362001)(6512007)(2906002)(6506007)(6666004)(33716001)(5660300002)(52116002)(44832011)(38100700002)(508600001)(6486002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iIsk2fcHxiSHOAXyK4sbr7YQmwGiqUK2zPPX88Ka++zRRsZ7j1JUhAeOmWuM?=
 =?us-ascii?Q?xxJp9Pwez+Iu0QnkXCZMOIz8D7NKkNQoDC5cCUU9BoloJs+2giPfrHHlLE4M?=
 =?us-ascii?Q?i7Z1SjbU5k/rvS7ETBb5gD8nyMCF5TjCxHua34yHjFuyxG8VCMAZYEMo6bEz?=
 =?us-ascii?Q?d2LougzvAZOVFIMDOLYL9O8tMB1yqZHeC2NXAEOA7iC0pWS8QFHuhj7yUYEk?=
 =?us-ascii?Q?Bv9qXF27qU781rZS29jfvi7BBc3XCCIC3yKyY0rb0OFaBRAi+YI4Kmc0MUFD?=
 =?us-ascii?Q?fLTAx2jM7g8BgGA5B4ofkM1CLvIbOetHEFEmqFigO6Vao+rkR8AXIznyIXjG?=
 =?us-ascii?Q?0CNHKr9sihu5v+Nlenx4u+RnKu+jiv1GTgURw7myLsdI/2ReSZyhUJjw4RNT?=
 =?us-ascii?Q?MtI0cfmFpJLplUE86fZ+nh3YUeTXv6o4aSQQE5KPZeZ+hF3o4It08XAoS/M2?=
 =?us-ascii?Q?QCTYEV0+YoBjEZGCyYTLQ1nnckA4+usqfAmPEaOW7MpKjrzJe8LfNBLELrdR?=
 =?us-ascii?Q?p5aK07NMshDqmCzo/CumfdjBT8vO0jVfGeNfhOuM+rbs34qzwy5Fi/BzyU6L?=
 =?us-ascii?Q?21xSX+VzYqTlruJTOdaMRR0t2Xms7g8OBpxmhg44yOgqr9c7Tu0IXTViGpOf?=
 =?us-ascii?Q?UpNU5cTrf07lMAF3TEqA7XSLAgmrh0rMFBayeulqhJF23AKDxKdEnZk9Nzpw?=
 =?us-ascii?Q?WV8cnd45BpxP6lLf9S/drTMa5L0f63EvaMxpzKyqgpq2g418FQjRqpCqw085?=
 =?us-ascii?Q?iIh9xo477YoIM8baYf/o8aQONrsgpJMz3EIqvqyVNkHRLzkFtBhhzuSaXdK4?=
 =?us-ascii?Q?1Ydh8IkFhxDD9k/IxiVR5K8UEAb/CU8nk4YDLOBp60R/hq5pmN+mPrsgw24A?=
 =?us-ascii?Q?3CBUxutt6Sz8YLTU6aD0UZCyUGnssAHZTdC3EQNJHRB15xwct2YsPSGlM/gR?=
 =?us-ascii?Q?rob39lJkV6WoQRaF8MrqBvOcRDux3jW5lHWEVFfVwtFT9UexcGjJiq3aenLs?=
 =?us-ascii?Q?uRinSdHgUjj6K2lZB0Vc2hzLjiCvXkRNpXW/Uw3z6oZdmY6pFDhod+DhPbDJ?=
 =?us-ascii?Q?SZyytVhFLD9sDGtNUDC74MljBuR8t62e+/P3GRs7hkwzHmvt1od5pd1HQxi0?=
 =?us-ascii?Q?0412kYnpb2mX5cYa2N7Uq0a4i+IdKEcxDbVFP3ryzTFrzJsTG6cKSCtPCmYn?=
 =?us-ascii?Q?7uofimv6z/TrfQDznFaJyP9tENTsKRk6JSxuBx5ZIiL2M2ngRCb12wCKbmV4?=
 =?us-ascii?Q?9aTpII5U3dTNy8vM4YJ8uOIFqFKNXuC+H6sxbH6IHHDLWOK3D17AOhJwaKdz?=
 =?us-ascii?Q?bdLvYznMdnSx3/VgORbVFMr211mYjhoynsEg7ugxUqVYoVnsx3UZ9xi7Qwsj?=
 =?us-ascii?Q?bPtrJGqnIvErnxuT+9uSGTxBaN9yErMCbchGxTgQQGP1nKaXamvlaCkvLqyj?=
 =?us-ascii?Q?KcLRTwjL1grTYHChzRMzvmcgpYokLFu82Lh2qPzWp5St4MFc1d79AntjKVnt?=
 =?us-ascii?Q?tDlytLpEpP+LrLzApGFqKo1ITTAOXIh2ED7QRQtnZdPI2asBg8QFYyYWOHR7?=
 =?us-ascii?Q?sOkDyjjvS8Dbbg10r9j8BvWtGWEho+/VLvNCBdJAm4/DNTg6jfEfBRRGbGTH?=
 =?us-ascii?Q?6b+jOEC97cCwxodvnVVq4AYDrMo+AiD7Nq7TinhDjcmEU5BExL8A+vJTfeRa?=
 =?us-ascii?Q?BAg89sgaWWjKEt7EQIvj3eeamnsc6Cye2r3fpu6s1TVb+zDjSMs7Q2eT8Q+t?=
 =?us-ascii?Q?KsN+q7LCUxgI/07QwsX0ioaazKHfYO9vjLTdoHS41lYX/XD+q8K08wV1cpie?=
X-MS-Exchange-AntiSpam-MessageData-1: RbA1zA7dtpaLNw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7f10e8-954c-464d-b936-08da2d54b93d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 22:31:54.1865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8WZepsZm1gljpu9P2Q/zWUTPa+frc8noCWDkNBPee74WeVq2hfviZpqfvbiWbKQtxKM89dHAqQmZpQAVAI5Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5500
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_09:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205030136
X-Proofpoint-GUID: N2hL6ytcpGlXi7PfPGCazUZzW9hnw295
X-Proofpoint-ORIG-GUID: N2hL6ytcpGlXi7PfPGCazUZzW9hnw295
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 3 May 2022, Stephen Brennan wrote:

> >> Ideally we structure BTFs as a multi level tree.  Where BTF with
> >> global vars and other non essential BTF info can be added to vmlinux
> >> BTF at run-time. BTF of kernel mods can add on top and mods can have
> >> split BTF too.
> 
> I see what you mean. It does sound a bit frustrating to have an
> additional BTF module to augment every external module, which would be
> the third level of that tree.
> 
> We'll need to allocate more module structs and pages within the kernel
> for that data, I wonder whether it would be cheaper for the
> "non-essential" module BTF to just reside in the same BTF section of
> that module.
> 
> I suppose I can run my modified pahole on some sample modules and see
> the BTF size difference, rather than just speculating, I'll do that in a
> follow-up here.
> 
> > Yeah, reuses existing mechanizm, doesn't increase the kernel BTF
> > footprint by default, allows for debuggers, profilers, tracers, etc to
> > ask for extra info in the form of just loading btf_global_variables.ko.
> 
> I agree, this is a quite elegant solution. Though it'll require a fair
> bit of work to achieve, I do think it's important to keep the footprint
> down. One thing I'd like to see in this world is a way to instruct the
> kernel that "I always want the non-essential BTF loaded", maybe via
> cmdline or sysctl. This way, the module loader would know to search for
> "$MODNAME-btf" for each module which doesn't end with "-btf".
>

Hmm, could we just have a tristate CONFIG_DEBUG_INFO_BTF_EXTRA?
If set to y, the extra vars are builtin to vmlinux BTF and
modules, and if set to m, they reside in /sys/kernel/btf/vmlinux-btf-extra
courtesy of the vmlinux-btf-extra.ko module (or whatever naming
scheme makes sense). Looks like pahole already has an option to
store encoded BTF elsewhere:

--btf_encode_detached=FILENAME

...so maybe all we need is something like --btf_gen_var_only for
the case where we build the btf-extra module

pahole -J --btf_base vmlinux  --btf_gen_var_only 
--btf_encode_detached=vmlinux_btf_extra

?

That's still only 2-way split BTF (base vmlinux BTF
plus vmlinux variables); we'd only need the
three-way split for the case where modules use the
-extra approach too, and I'd wonder about the viability
of having an -extra BTF module for each module, especially
if space-saving is the goal.

Alan
