Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4610F45E2FB
	for <lists+bpf@lfdr.de>; Thu, 25 Nov 2021 23:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244248AbhKYW0w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Nov 2021 17:26:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56970 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345468AbhKYWZE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Nov 2021 17:25:04 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1APJhZJN001471;
        Thu, 25 Nov 2021 22:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=FGnwchF3rxqgUc7aL7I3xkjIohH3UN5D1qEroQKbaWc=;
 b=tPrmYDwa45stVdQGWlb5I6ufaxY2zxvDxLrKa2e01ZdNGFTzHQxMJOX86ulf/YX43khx
 vPN6FvURkk0UTtpiqVCo8WmYJZR6Ws++UMIUedRPsp4IYyAeWSpKBfU8aGxDllHXDI/R
 ydGkTQ5lscc78cZYbEymqpTpYOnFNDJe21zIK7RjgxHkOAN53nGd4C6JDy5p8nZ0Sjsj
 ds30XSNWQq9sv/iIZLV1jM+FITIH9e7wnkiscPDTbC6iz1RrgXbofDsJAIvrIRjLTmvj
 hWXxC9ZoV3WWYQtOx3bLfx7k21q/DG7b0VII6tXdaCZ8SL6E/eGEdPtmx/Sk4YgU4XHk ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3chk008qxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 22:21:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1APMFN0x185697;
        Thu, 25 Nov 2021 22:21:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by aserp3030.oracle.com with ESMTP id 3ceq2j3jfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 22:21:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoSB2ZKnhiLzTRh2Rzkf0W7Sy9cGG53N97iY5uxExP85dxwr0MP+5wBRtE6V4ch8x0BUK8iy7KijpgE+GJ1DBqXi9F/WLtZ9amTQpEQ/paile1VM5J6RzqgXuZjLGjD37bXJBAXZ6YFxzxbmdhw1CkbdUmMlpjCJQT3fL9j3QK4lsDBoQHdvEblNNcAe6lQqWANzbdIQOad/nAQ0AI4J6oU3JliIGL/cl9dADL6kdMmSfro/szKa4879R/nsOpegzzXIHymPy3MjGkwt0fkaW6hWiYlWuBvVkxJiIlSKCVv11n9i3/DdzFYQOAB77JTxyHT8xYBSKtmITs8MsN7d5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGnwchF3rxqgUc7aL7I3xkjIohH3UN5D1qEroQKbaWc=;
 b=lEGnSN0PZSF88yFPwPPm4YZXV+Q5yEpWtA9EYIjX09yDZguzg/EkgYCTnJ8LNvnC0kZpPX/FHRgJ/6JoVNiWER9036xSzgWmQF3JXAgsmcJLccRaRcxDhjxyoJdtYT0LFWL9U4LMGdH/j67HD7eW047a937HRY3Rq8sDeTSGVM8E6WW2MBWrbRqZqXx7J5mslQNglJ7bxlS2YhnitV9yb6zMYueChtWiqC7v+KUK0tv/gYrjDYnZkE9+mzRj34r+o5qFLgbsG6IakOdnsWT3op4a0mjBUlzWZtcWFPovuzlkJamLPxke1bv3aUMq9eYu9tom00+ayaCeqIvWMAtwHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGnwchF3rxqgUc7aL7I3xkjIohH3UN5D1qEroQKbaWc=;
 b=k1CH+itvMeOHrGEcvfpKXutzSNvLFR/oc0oxtZigWmtq804J2D+a0F73QvFnKi89nCNiOcNgA94XHLO6o431Sgge6uC8RcYhSF5Ody02coWftmBDgkMxKegu6D1b8VYusbGdk1O4Eetpy83Kr20EiSjYb+OlOJn4SAVpLC6/UXs=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BLAPR10MB5347.namprd10.prod.outlook.com (2603:10b6:208:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Thu, 25 Nov
 2021 22:21:25 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::998f:e9eb:ec26:1334]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::998f:e9eb:ec26:1334%9]) with mapi id 15.20.4734.022; Thu, 25 Nov 2021
 22:21:24 +0000
Date:   Thu, 25 Nov 2021 22:21:12 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     Andrii Nakryiko <andrii@kernel.org>
cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH v2 bpf-next 1/2] libbpf: load global data maps lazily on
 legacy kernels
In-Reply-To: <20211123200105.387855-1-andrii@kernel.org>
Message-ID: <alpine.LRH.2.23.451.2111252218190.318@localhost>
References: <20211123200105.387855-1-andrii@kernel.org>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: AM0PR10CA0052.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::32) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
Received: from localhost.localdomain (2a02:6900:8208:1848::16ae) by AM0PR10CA0052.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21 via Frontend Transport; Thu, 25 Nov 2021 22:21:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59ff4c9d-1b16-448c-2258-08d9b061eaaf
X-MS-TrafficTypeDiagnostic: BLAPR10MB5347:
X-Microsoft-Antispam-PRVS: <BLAPR10MB53479EA7B3EDBD25B9D1D2F2EF629@BLAPR10MB5347.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L4hVD5HG2z3ebjNDcNKWn/YXCPeOciuwPQHFqOcNAA6TUIxwYJcg+g2tLnqucEzUymCuoy2JkgWmUFjLSi/gjK2wZ/0NEwAt+veeehVdUwambhh+WtrJ8k6Wvqi1OGOZlxsUKeWBZaamNa/tWpj6GafrL/yEvjFw30+idOIRv0Y/6XzCKb4VEizOsDgbuxY6MYwrih11BRdU8I82yQvPpeUUqn5paNfnXoFIaYQiK8LS6qkqbe3V4iR4xhQW64fmq0ZUsdbSazQ3fqc66TvZA5bGlR75e3UJpo+7z50yxfzjZ1ZmrBlHE+h3HwoFxVMyJzWut4V8O5aIfbOe7uf3MYsgKLdiIv0xaD0PtRSqueyDn9B/cjOk9XM5Uxo2Zic/5se8BkGpH0r/mPyZqA5UOJj0/kd8yn6e+h8isXIfaZXoMFo2oD6qvT4y8yeIvVisFPq5XGDvCeHipq48Zkj/rfLIxEpBf3bcSek2EDqSdHy6skPd2N8WW00nguN95tKYC3kq3DoZGjLQUSqjO1h7rBdiXROWfpFtlEP+0pTWnDPftRWz867plBH0tm05dUZOegniUTBIUt0sJYuIUYSMiMRcSO74s2M3UFsgAilvA68dHGW0OKcw0E/4iJihZWIqO8/2PTDxqGIocyrYWdd6+gn0dblXiF8KYTKC1m/umZGebyo3AUPnP22+TVY6onUFXt6A2QrwJUppVN05ZJgdaxVatF5JPMzylaKRpYIBbvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6916009)(44832011)(8676002)(6506007)(83380400001)(66556008)(9686003)(86362001)(38100700002)(6512007)(6486002)(316002)(966005)(2906002)(52116002)(66476007)(186003)(33716001)(6666004)(8936002)(508600001)(9576002)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aLyvCrMwVfnHRBug+jFuOtVBwqPgZfM1tLX3vGBHICXPtwh036LV/dOPS06F?=
 =?us-ascii?Q?U0MbTKgt92F9WRnnz4VJsD6B7mPLyETvNtsUNOQq/OJO6g0F7JDiLwoULqWF?=
 =?us-ascii?Q?14JsBtrZOyRAtKHDEWRW//lTqHeTNOP9HZ3Slt3AbBymrccliF6IM4P2F55Q?=
 =?us-ascii?Q?CuWmVNYqKtp77dfsa+qwCn6RiTs4Sm+m2ELJozgveXf70aERhQjMXHMKiagW?=
 =?us-ascii?Q?4RXgvAMeA4gb6D9gMwcGnxwjjhz2y8YEO9sqmEutXWm4oMEGcf4PmZTrzd7B?=
 =?us-ascii?Q?fPelTpt6+ucPBK2dKxYoFdj6P2pojiT5h4svZA5pHn9w5+aqsuGoRG3VyKaf?=
 =?us-ascii?Q?bzAaTN0XKEEpwdYi9aVOnXzyIYGNNm7bEvx5lVpE7MyK7nWoQlkgH7nUtYKr?=
 =?us-ascii?Q?tmrROOxY9IrWHXvsgO4fi5xp7EIq2dO0vG6Tq6WkN1CZTQ0Cp+2C5maG8Ojr?=
 =?us-ascii?Q?21egV9QtbZ2zTt3M0EkNa5i/GsAPelHy4gp7WO1IadELOzpWPxnKnE9wEelm?=
 =?us-ascii?Q?68POBluoaqvAUtaGIT2jf2qYBFuLqrzSgGqoyJ/7G0V9j6KZYBHiOS8ct4Rd?=
 =?us-ascii?Q?XS3AAHc+dTskLyGmvpyTx/nqBcPNnRnyegcdHYs6qbLBzNAqVxYm4Sr3gvuA?=
 =?us-ascii?Q?SSnuQP/KsZi2kq8mfvNA+DWiB62zULSlaGZK3+HqnYEVfJpRjM0CRYEjh3DS?=
 =?us-ascii?Q?sj7eIav1ye9Hkq/u9lowzXpxVnvkbW0qgbpAkjip1FPQWG35IG+CFvfPXAyu?=
 =?us-ascii?Q?5J8dvSLabyG+8VIy2i0Iw4SACnEVgFjl+Al1p6yFG2xQ0r7I2y4CJf0sXrPw?=
 =?us-ascii?Q?cZIL2sf93JZHC6ttqQaJKfny8fe7vikeLxVOPJMg+qIem6xHKztGSWwMrWfK?=
 =?us-ascii?Q?j6F9wjICPl3qDVHv+O4N0QACBB5+KBdIoSgodW6rLSqGm6xywco9mCSId0D2?=
 =?us-ascii?Q?W8HPVimB9PdOsN0DenNYGSf1WuXgQbGVXLXdXGX8EOVWVxaM+MUYE0cezYuG?=
 =?us-ascii?Q?VOP9X6asoSfuco+10TwFT7cF1NuptbwV5encdOzfoDd32AXptd5X8erqriT6?=
 =?us-ascii?Q?Xb9CIejozcSpDCaVi3jnxjuBroThg7uK5uyD/1Iqf1nmxZ3BiqgHHGgRBbmy?=
 =?us-ascii?Q?X6CYChDe6Vzi8eqKJJIHKMQ10F1s3l2th/etsk3tcJchH6i1ab1/YTVJEM0I?=
 =?us-ascii?Q?sYDphDBor9TBRN3DfhVTDw3qij8aTSok6sRqIRrTHX2LsTpv5xXbYI9PdiqK?=
 =?us-ascii?Q?9P9XVRakbvrMBZZB1nbnE/fq1EKpN0ZTDsyw0vOHPbpqywS1SRNM+30qChSV?=
 =?us-ascii?Q?Es0brNGpCc+Pl9INh0NHSP91xBLmpMGqUJ2KOnMqZUAmnOyfm1H2LivAOdrE?=
 =?us-ascii?Q?AOMcgPCqcnwW5w5KSk81ZmVs0DU80eTyY2hgs/RDtVIikMmmMXMTqGVnpefK?=
 =?us-ascii?Q?6V0NMRFVUhGn++YKw6SWKatoW184WWZReXZsYxzobTMFVCfEmFGTbbFJCL2L?=
 =?us-ascii?Q?ZUFNE5pXhLlCtlYfqS4EzjjyNKV9xHxogCuKdF0IdOk2rh7ZzSuqpnXiG/hU?=
 =?us-ascii?Q?sBf95H3k8lAmB7KxXJgo1/UtOV4FN2bDkfFt6sdSKup8uWTjcsfnmQFOTs6w?=
 =?us-ascii?Q?XdIkPhzYLEmWivadTtReGab7DG24Eqh0vYNhQfKmOUi3VJjZKMFC+0fcZabu?=
 =?us-ascii?Q?gnFzrw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ff4c9d-1b16-448c-2258-08d9b061eaaf
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 22:21:24.7209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0rZLLAJb/g+KugllPd5Z0b8C4L/gTpTqS7laMsfo4/8J9A3wUwnY6ZPHyZfSE2UCvxDgDoNyzA6OoytQyZA5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5347
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10179 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111250125
X-Proofpoint-ORIG-GUID: bcxI4_Ar4wxWztS3mRa9VGqd9xK-VIqv
X-Proofpoint-GUID: bcxI4_Ar4wxWztS3mRa9VGqd9xK-VIqv
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 23 Nov 2021, Andrii Nakryiko wrote:

> Load global data maps lazily, if kernel is too old to support global
> data. Make sure that programs are still correct by detecting if any of
> the to-be-loaded programs have relocation against any of such maps.
> 
> This allows to solve the issue ([0]) with bpf_printk() and Clang
> generating unnecessary and unreferenced .rodata.strX.Y sections, but it
> also goes further along the CO-RE lines, allowing to have a BPF object
> in which some code can work on very old kernels and relies only on BPF
> maps explicitly, while other BPF programs might enjoy global variable
> support. If such programs are correctly set to not load at runtime on
> old kernels, bpf_object will load and function correctly now.
> 
>   [0] https://lore.kernel.org/bpf/CAK-59YFPU3qO+_pXWOH+c1LSA=8WA1yabJZfREjOEXNHAqgXNg@mail.gmail.com/
> 
> Fixes: aed659170a31 ("libbpf: Support multiple .rodata.* and .data.* BPF maps")
> Acked-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Thanks for fixing this! I ran into it today on a 4.14 kernel and verified 
that with the patch applied to latest libbpf, BPF objects with legacy maps 
loaded and ran where previously loading failed.

Tested-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/libbpf.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index af405c38aadc..27695bf31250 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5006,6 +5006,24 @@ bpf_object__create_maps(struct bpf_object *obj)
>  	for (i = 0; i < obj->nr_maps; i++) {
>  		map = &obj->maps[i];
>  
> +		/* To support old kernels, we skip creating global data maps
> +		 * (.rodata, .data, .kconfig, etc); later on, during program
> +		 * loading, if we detect that at least one of the to-be-loaded
> +		 * programs is referencing any global data map, we'll error
> +		 * out with program name and relocation index logged.
> +		 * This approach allows to accommodate Clang emitting
> +		 * unnecessary .rodata.str1.1 sections for string literals,
> +		 * but also it allows to have CO-RE applications that use
> +		 * global variables in some of BPF programs, but not others.
> +		 * If those global variable-using programs are not loaded at
> +		 * runtime due to bpf_program__set_autoload(prog, false),
> +		 * bpf_object loading will succeed just fine even on old
> +		 * kernels.
> +		 */
> +		if (bpf_map__is_internal(map) &&
> +		    !kernel_supports(obj, FEAT_GLOBAL_DATA))
> +			continue;
> +
>  		retried = false;
>  retry:
>  		if (map->pin_path) {
> @@ -5605,6 +5623,14 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
>  				insn[0].src_reg = BPF_PSEUDO_MAP_IDX_VALUE;
>  				insn[0].imm = relo->map_idx;
>  			} else {
> +				const struct bpf_map *map = &obj->maps[relo->map_idx];
> +
> +				if (bpf_map__is_internal(map) &&
> +				    !kernel_supports(obj, FEAT_GLOBAL_DATA)) {
> +					pr_warn("prog '%s': relo #%d: kernel doesn't support global data\n",
> +						prog->name, i);
> +					return -ENOTSUP;
> +				}
>  				insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
>  				insn[0].imm = obj->maps[relo->map_idx].fd;
>  			}
> @@ -6139,6 +6165,8 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
>  		 */
>  		if (prog_is_subprog(obj, prog))
>  			continue;
> +		if (!prog->load)
> +			continue;
>  
>  		err = bpf_object__relocate_calls(obj, prog);
>  		if (err) {
> @@ -6152,6 +6180,8 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
>  		prog = &obj->programs[i];
>  		if (prog_is_subprog(obj, prog))
>  			continue;
> +		if (!prog->load)
> +			continue;
>  		err = bpf_object__relocate_data(obj, prog);
>  		if (err) {
>  			pr_warn("prog '%s': failed to relocate data references: %d\n",
> @@ -6939,10 +6969,6 @@ static int bpf_object__sanitize_maps(struct bpf_object *obj)
>  	bpf_object__for_each_map(m, obj) {
>  		if (!bpf_map__is_internal(m))
>  			continue;
> -		if (!kernel_supports(obj, FEAT_GLOBAL_DATA)) {
> -			pr_warn("kernel doesn't support global data\n");
> -			return -ENOTSUP;
> -		}
>  		if (!kernel_supports(obj, FEAT_ARRAY_MMAP))
>  			m->def.map_flags ^= BPF_F_MMAPABLE;
>  	}
> -- 
> 2.30.2
> 
> 
