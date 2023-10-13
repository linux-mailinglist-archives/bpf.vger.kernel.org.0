Return-Path: <bpf+bounces-12154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3FB7C8AF0
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 18:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026E52831A4
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 16:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1152921343;
	Fri, 13 Oct 2023 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="c54ItXc8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFD4210E0
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 16:22:43 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BE51732
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 09:22:32 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DDcmFZ004800
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 09:22:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=pWCR3gQePsdiyu4tAg7Ytis6CcItTRfWhzxTt9rSjBg=;
 b=c54ItXc8jmZpRciWHZNxOY+h/l2fcvnFKQGkuVgCGJInyQrFsx4hLLkmyLy3NGQrIg1M
 l24wVPu4rqpTYA34KaMWF9dfbzNeK/Uu0ah5C8AUKvyy07ksY7Y0o2zKhtkD/G0W4Ae1
 DYHx1s4JZokq9/2VEzfjG+qP615zpmtCj6wzGOS04bj9ZF5evZSOEL5YEzfKnJpcoP3z
 gt0C2Scc7JjjqEn/F2oY5XbUD9QWb9RmDMDsJxxTuEw90h1bkhvId3F6YxPciUKsY4xG
 rCm4hzFS+uepbNSC++xFxIbNzLr5zkKHWME7McxqbfyOyfDRAmP0va+ASorfmcR01gqt 4g== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tpt1r44s9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 09:22:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5cJiiiX87gjpXAR2kVaLKKl+KXfa0iO/dFuZiQ77pBI9AA6uzxl7qvU2qMpOlsoi78ppjfY0swZ2GDNtgEX2OFmgJF3TLy3gZmMWScLFmMv5pORsPUY8Diq72nHAlQ3zyb71zYohn6i7db5pqPiUoVlaJfkcVFOJDQDxBJ6sozDDfJK3aA4CI4SypGEpcIN0S51qgd66TNazwhNns9RsOoRDJRzWLfaanEhSOOEOM+7IvqgDoaWNIiDaVgQ3FhOuNO+t3RAjiaivI/N+OxEEuCtutrWzQjLk5Q1R8rEupJMualfO2I50UuTHJnLpnNE+6HCFJ1CgqE9317z6t2uLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCgl8G0BQla+in598lN8LAuPGRBoTHb7v380OYykMd4=;
 b=bPazMcu0L0JQqA+5Ix5134uvVkLBEZ2bDVIQdx8q9mjuNfjxFtVH+TIAslpfmTmSJXYEeAIy81bGJSmvPPs8OCGU8VCypeMNam6O3W9wEOn06vAHheutogE83+hig9ICZm3wQmHaBf2P0xB+CdpbkbI3AzYIt5qXIh3Whi4Ei56Tnkn7CMTThvWZDjOfTOK37Om+KG70sE2ZI6z0PKb5aCNluPfrIjQijkpbaFGhFgPDSncimeRdb64+6Enpk0lG+2LXv4cPE0sHJ/ilwcWqnPJujjngHpJiHlkMD7B/yCK8qm1bGpo7FW2vJQ3nwxkqLhzoNrAuPI8w81O1A/ifmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM4PR15MB5456.namprd15.prod.outlook.com (2603:10b6:8:8b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 16:22:29 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e0e7:7606:7fef:f9de]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e0e7:7606:7fef:f9de%5]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 16:22:29 +0000
From: Song Liu <songliubraving@meta.com>
To: kernel test robot <lkp@intel.com>
CC: Dave Marchevsky <davemarchevsky@meta.com>, bpf <bpf@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin
 KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Nathan
 Slingerland <slinger@meta.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: Introduce task_vma open-coded
 iterator kfuncs
Thread-Topic: [PATCH v6 bpf-next 3/4] bpf: Introduce task_vma open-coded
 iterator kfuncs
Thread-Index: AQHZ+6v1Z49s8H/1W0iMqRA7QBhzELBH4KEAgAAK8IA=
Date: Fri, 13 Oct 2023 16:22:29 +0000
Message-ID: <B6AD12E1-3BFC-4AC4-87C8-9E58A586C4B4@fb.com>
References: <20231010185944.3888849-4-davemarchevsky@fb.com>
 <202310132300.wnnctWmF-lkp@intel.com>
In-Reply-To: <202310132300.wnnctWmF-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DM4PR15MB5456:EE_
x-ms-office365-filtering-correlation-id: 85ab057e-742b-4dd5-316d-08dbcc089887
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 mrZ/9KhppEWxryy88ldhSwAh/3eXKRXj/X4PYSfQVS0dcNcmistJkP4rWtt+DyChRrIY1Z3OTMuxnxw8/OAfzsZM8EX3J7pPs5xoTYywlY0EvPwCB/0gjNt83PLxUrsZ3btGsMun2eAQCTwCFXY0cIsVkIE0cFNu5N/uTAczOakV330Tcf7gSV3y3WfxJh03FRZxaonomhAEtt2zcU93R1HQQYurkspDs5bq9RxN4IdKSJWD23PmR8W2+vEGMM/woFeUql+xvCuCF3mHfgbexLnu0CBRTTRS2G95KmwzVjKO8zGjauzOxFWy4a0fYfN6TBG+HWaEdpBa6ka936wM3Id0AtVeGuX+LWzdgUtdtmR3br4j4XDDNUVH9TyCJw0PwJsMe+OoBf3Ctrz7hlMZSUAmFPYUG4rtS5xjjCa3UP2MPndX2kvXC2Rxe9ECFeCEt+SB6MAYgBzFXryWpqhXIe9oVtPJ6JmdqyXsA45ESNkZmULNQE8eIHbasHxHt/cp8j6kKRdqo37QZnvyWBatqKyI6R4PHmmQ+Sp2U1KjncOv8WA+bC9/dTFbuk86OHH4eWpJFpXkak54EjETdd1PrUFdbqKCld0uIpscnCNYExo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(478600001)(9686003)(6506007)(6512007)(107886003)(36756003)(33656002)(38070700005)(71200400001)(122000001)(86362001)(4326008)(8676002)(8936002)(5660300002)(6916009)(76116006)(66556008)(66476007)(66946007)(64756008)(91956017)(6486002)(54906003)(53546011)(966005)(83380400001)(316002)(41300700001)(66446008)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?+5oX0fEmad3Pxc/Ip7+x3ghVmfj+P7/PPz3Ccb+Mi9Q/lQ3uQpSl9mCBDU1X?=
 =?us-ascii?Q?6I/kFnXoE+BdIUFB+pEBdLYFXDI1cuEp+hD4AaxMdyICFjYNNg2R/sNdWPFZ?=
 =?us-ascii?Q?chQHTSmEIfMDX22QtFJn2zNcNevgbWfiDj+ddFz8L9QdTW7GjC1JPoJBVXOx?=
 =?us-ascii?Q?4PCpCtSkN/RD0FCYNS0DxKGxW5gDk4EoSZ72pDZKGQoosLOkbAM/79dHaap2?=
 =?us-ascii?Q?nC7mPnx+7aXLaELW/0KsM6JjZfLQKVh81tAOshT1o0TnMupAJxFP3jLGCFaB?=
 =?us-ascii?Q?xu9xiz9toQle6SUlnCBqWUKg4IpaBZIdeCc/RI97wxlRAND6fvMRIKJXu/J7?=
 =?us-ascii?Q?osMGq9ex47yOUC19nMo2Bi78d/58du6YkRUdht+4W5EB5Nz0wdZTFnKZS52w?=
 =?us-ascii?Q?CtKv6z2D6uWvuJ4jBo/0l9DLKoBxaROfNlyNufD59NQE0yne0MpPhkQnUvNf?=
 =?us-ascii?Q?wSZIVK6/KzXrSNabVRg2LBRaYjWRHdRwGRfYEBaOty4U8RZrn5udb/Of9lnW?=
 =?us-ascii?Q?MBqnYlwYBgoYRgzAsLvY/C2rc9W2y17pHn8FCSxeZlelfZyK7V1cwhjP/Opl?=
 =?us-ascii?Q?A1FScGN2s1LRnsJda4VY3icqApSFfuI0axc148XCjc2jrVsQXcRuOnct+mMT?=
 =?us-ascii?Q?nwEsDXu6NyIEUNlS0VEsyZKSZweW+3T0KRfjGOb4PXqM5cPA9C/lcXfaYTYP?=
 =?us-ascii?Q?49fU2lGqNxCLaGzvVHd3PoiC0C7wU/K8riJHscid8TI5MgZb+oxRW8XLSfDV?=
 =?us-ascii?Q?xmsK0WHd9oAmYHaQRsQuQua1Sc7+mF8OsINRLJFmvlZd/dcJe0pXOsuvd+J/?=
 =?us-ascii?Q?kHHai/xOZ7tEx54UR/RU1VRddNhefBEJiVdBTiZFhOgyAT1Bl2jp5dWEVGWb?=
 =?us-ascii?Q?m8ddpaEfc8oCE9Wj7TVnhBfNQ7rllwBpOod6E9aN4c48vt6hk0IUdMIQBX7G?=
 =?us-ascii?Q?4A/BlO+s87g06EnQ9fWCHWlBI0j9n9uszsz/aYfwu3Z6KECV/9bZI0wzSVw+?=
 =?us-ascii?Q?9wIdQSIIM/ln5RzG5cybRP7I6yYmYqC7Bn//XkNdavsNK7h9TlhV18Fya033?=
 =?us-ascii?Q?R2f7BE1xlTyvnLhxywm2m0wL1wUe7DdXC7fOlPkOUn9/YpVtO7kJjWnM6Zsx?=
 =?us-ascii?Q?OiIp2t2vVy/AuZyCpBJsrxOJOIs2TfbOGKYO2ugbBjSE3+FTs4m5wjnhkcYZ?=
 =?us-ascii?Q?HmnyuljTfoHAFoLe9js3X6oose+f1A8lB+ekDUdKvmp/Q9PxaLcA3le+In7n?=
 =?us-ascii?Q?u8pa2lt4dXJQmthVqmgBcCwrgwtJtww3exwY/PjKWsNXKWPUhFoKoczUtJrE?=
 =?us-ascii?Q?g829wiznk7d7q3dDej6z2IzgFK5DRm9VJmf+tRawaf3sWTgzYdxpWgJU48d5?=
 =?us-ascii?Q?8O6Mh2fySgYL2AbJZWCEZ6mzKiIn3RIQT4EFdHka0gILyf8QN3hnAYOAvHHX?=
 =?us-ascii?Q?eCXsqHFNVviZCfEmvYo59ijqFldL27TFtHuP7DhH8tWMtFEQKE2BDTPctRt4?=
 =?us-ascii?Q?841Ehar98phWYB4w7wycHbF478wLvShzvjjEzXFVseJJsjdhIOBQw0UVEhYZ?=
 =?us-ascii?Q?QFzD1yxQFWsY3Q7DKfzTGlBFn4ZPerrGGCIDn03wPGadgzEkgMB6xg4SgLOw?=
 =?us-ascii?Q?ax0w44D3GiDq+HADyx6SrCY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B9A2D3C64E679B4284A9A212E9A709DE@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ab057e-742b-4dd5-316d-08dbcc089887
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 16:22:29.3680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4/P4yP2iPd8WyvN0tehMRzDdNZZFUJ8UqiZYBBQf2vGMI5UT1MNzjssGOajhZQbqnkNUAFS0B5eaH/wIsF8kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5456
X-Proofpoint-GUID: LDK6DlhfpHQD41xsi4QmT2pebCONAvsF
X-Proofpoint-ORIG-GUID: LDK6DlhfpHQD41xsi4QmT2pebCONAvsF
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_07,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On Oct 13, 2023, at 8:43 AM, kernel test robot <lkp@intel.com> wrote:
> 
> Hi Dave,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on bpf-next/master]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Marchevsky/bpf-Don-t-explicitly-emit-BTF-for-struct-btf_iter_num/20231011-030202
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20231010185944.3888849-4-davemarchevsky%40fb.com
> patch subject: [PATCH v6 bpf-next 3/4] bpf: Introduce task_vma open-coded iterator kfuncs
> config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231013/202310132300.wnnctWmF-lkp@intel.com/config )
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231013/202310132300.wnnctWmF-lkp@intel.com/reproduce )
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310132300.wnnctWmF-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> kernel/bpf/task_iter.c:827:17: warning: no previous prototype for function 'bpf_iter_task_vma_new' [-Wmissing-prototypes]
>   __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
>                   ^
>   kernel/bpf/task_iter.c:827:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
>   __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
>               ^
>               static 
>>> kernel/bpf/task_iter.c:871:36: warning: no previous prototype for function 'bpf_iter_task_vma_next' [-Wmissing-prototypes]
>   __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it)
>                                      ^
>   kernel/bpf/task_iter.c:871:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
>   __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it)
>               ^
>               static 
>>> kernel/bpf/task_iter.c:880:18: warning: no previous prototype for function 'bpf_iter_task_vma_destroy' [-Wmissing-prototypes]
>   __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
>                    ^
>   kernel/bpf/task_iter.c:880:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
>   __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
>               ^
>               static 
>   3 warnings generated.


We need the following to mute these:

__diag_push();
__diag_ignore_all("-Wmissing-prototypes",
                  "kfuncs which will be used in BPF programs");

__bpf_kfunc ...


__diag_pop();

Thanks,
Song
> 
> 
> vim +/bpf_iter_task_vma_new +827 kernel/bpf/task_iter.c
> 
>   826 
>> 827 __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
>   828      struct task_struct *task, u64 addr)
>   829 {
>   830 struct bpf_iter_task_vma_kern *kit = (void *)it;
>   831 bool irq_work_busy = false;
>   832 int err;
>   833 
>   834 BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) != sizeof(struct bpf_iter_task_vma));
>   835 BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) != __alignof__(struct bpf_iter_task_vma));
>   836 
>   837 /* is_iter_reg_valid_uninit guarantees that kit hasn't been initialized
>   838 * before, so non-NULL kit->data doesn't point to previously
>   839 * bpf_mem_alloc'd bpf_iter_task_vma_kern_data
>   840 */
>   841 kit->data = bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_iter_task_vma_kern_data));
>   842 if (!kit->data)
>   843 return -ENOMEM;
>   844 
>   845 kit->data->task = get_task_struct(task);
>   846 kit->data->mm = task->mm;
>   847 if (!kit->data->mm) {
>   848 err = -ENOENT;
>   849 goto err_cleanup_iter;
>   850 }
>   851 
>   852 /* kit->data->work == NULL is valid after bpf_mmap_unlock_get_irq_work */
>   853 irq_work_busy = bpf_mmap_unlock_get_irq_work(&kit->data->work);
>   854 if (irq_work_busy || !mmap_read_trylock(kit->data->mm)) {
>   855 err = -EBUSY;
>   856 goto err_cleanup_iter;
>   857 }
>   858 
>   859 vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
>   860 return 0;
>   861 
>   862 err_cleanup_iter:
>   863 if (kit->data->task)
>   864 put_task_struct(kit->data->task);
>   865 bpf_mem_free(&bpf_global_ma, kit->data);
>   866 /* NULL kit->data signals failed bpf_iter_task_vma initialization */
>   867 kit->data = NULL;
>   868 return err;
>   869 }
>   870 
>> 871 __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it)
>   872 {
>   873 struct bpf_iter_task_vma_kern *kit = (void *)it;
>   874 
>   875 if (!kit->data) /* bpf_iter_task_vma_new failed */
>   876 return NULL;
>   877 return vma_next(&kit->data->vmi);
>   878 }
>   879 
>> 880 __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
>   881 {
>   882 struct bpf_iter_task_vma_kern *kit = (void *)it;
>   883 
>   884 if (kit->data) {
>   885 bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
>   886 put_task_struct(kit->data->task);
>   887 bpf_mem_free(&bpf_global_ma, kit->data);
>   888 }
>   889 }
>   890 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


