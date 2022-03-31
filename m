Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF694EDC75
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 17:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiCaPQR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 11:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbiCaPQQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 11:16:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7595F4DE
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 08:14:29 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VCfjpv029825;
        Thu, 31 Mar 2022 15:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=MSELgFys0lIDgHmB4F8PDDDHDJHB/8b1A8Ib0VGpdT0=;
 b=z1s/sU6qDw0qARxkh8rgJSiktaUy7B3WTEepPp+v0zHKslSqh42XYqW+SVtVn12EWwX1
 SlP4oEPu0dF8FuqYTDCvZeZtYMslkhLA+hxzWz4tAXpiENLSr0scIMYbD86HrPCQGMUH
 A65FHacx/DqpLRdNZVbi38/1c7CnJ0YLHUiDH3AkScliBxN/ThKPNIxEPrnD29f7Q+6n
 upsf0PAVEp/BozaoX/5z8gIAeDsjTH0mzWE5AxlF7tu0f7UTYJ4Pck0GuxBghBiiQVSV
 knDQ3rvyYL+kNCtoB10pSz0a4y5K4B6kixQ64JUSEe8b+ffR+C3k7D6+ZBHxOHiC+kwJ mA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tqbceky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 15:14:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VFAUrt026218;
        Thu, 31 Mar 2022 15:14:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s981bj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 15:14:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwwDnXZA8FUjkunOpZqUWx1sTtQ0urFJCBuBfpuxGFtM/K78eqZ+hVNixIBgMnLrzRfYQh14n5gbH7FpiExpTowHcVaZWqAAhbL2/GDG299PyNXyp7ahkmPwPH7pMY0iycbG2tkmriTs1s708OXyMCGe2dyZMbg05JkoSJsSZWd7KHAPDXAMO09AC1egxQKp6aoLXaP5gZFVv0yZrwex2wXg0Pt7NbIDRIeFkHsCgL1C6Ph/8xJPtbbXiIsOJYgsqhjbTgpCG8flFiS4ISXx/bPb1gW3GludPIU/dSdGCswy8p9C87vPP01yu7ubyshpSNyilM5FJ7l0XHEj/fA3Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSELgFys0lIDgHmB4F8PDDDHDJHB/8b1A8Ib0VGpdT0=;
 b=jKo6P1nibichgrWBAIOJn6L/JvBHc5hvLPZ7oRzO4Oaf1SGCCdIef2Vrq5f5auW25wJc51dCqtwafX0VZsgm645tmKfIxAS6zcUh7i5Bef852o/Gw85NFzMl1fUn+kg/qIazOjLTS6mHPnTyWQc1xka72IrzRO5zTAsssNwyLcEnnMDiG0yv4Yi7xlPGxiO/LcVoLqVDCL67QwBkery7dj0Pm1xCNJ4CXcwtgicmu5BmbW64aC27Mz27L+Pk2/Yi8nhnmQtlx1DcfB7wVfk0vtzujYJKwuc0fcM+j0nsAG8q8ITgKUlm+ub2GIjY5G/ZUzNRrD+JLuwgSM1iUdnp0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSELgFys0lIDgHmB4F8PDDDHDJHB/8b1A8Ib0VGpdT0=;
 b=ixKihQVGlnupKGnX5bPR+gQFAtA1W2FeNkm2+oqdiMaxchSDdBicP9DoxgkILH3CxveJ0BscpKwdimPs+Fvzb31hG4luoQVatpnZu6iHUPVTyaKZ/4dT0ozYy/w+rQMcu6k/KmVXiY1TWsTgnbKiFpGqotvnMh4NYq+d22C5WMg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM6PR10MB2745.namprd10.prod.outlook.com (2603:10b6:5:b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Thu, 31 Mar
 2022 15:14:07 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1483:5b00:1247:2386]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1483:5b00:1247:2386%4]) with mapi id 15.20.5123.020; Thu, 31 Mar 2022
 15:14:06 +0000
Date:   Thu, 31 Mar 2022 16:13:53 +0100 (IST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@MyRouter
To:     Andrii Nakryiko <andrii@kernel.org>
cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: Re: [PATCH bpf-next 5/7] libbpf: add x86-specific USDT arg spec
 parsing logic
In-Reply-To: <20220325052941.3526715-6-andrii@kernel.org>
Message-ID: <alpine.LRH.2.23.451.2203311551070.11363@MyRouter>
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-6-andrii@kernel.org>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: LO2P265CA0456.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::36) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 764cfaff-3fd6-45e1-51ae-08da13291965
X-MS-TrafficTypeDiagnostic: DM6PR10MB2745:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2745026AD1951C7695A97C57EFE19@DM6PR10MB2745.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IPKcbYxVNT1Xm94d5IqYD1Gqh5T/I0DQz2lmAhjRrqmkPb5b4nE5J1mYSA+kl9rhGBuATL7V6H9QCFr9Pr0/wTb5XVeAvqqkMddv0itz+16bjgy42JKSci/mbjZ+OvbCa0WFzb3ES9j+l8bQ5sIddT1rsylj6LyltXBn1Puf9S5cbliVCDRzvBW/o5BmdDqk/X6l32Cf8hra1hRaNRLkHFP4zBsDjMC/LF1g+0mc/QU1bEupC5yNn58d7sGNdxy9J8MzZrdbYu44PlLVPVZ5HMzbYzPqSknIUPqi6bL2+jPVTMpzq3qa01+Zr9lI3Bt6+Q4VW5lClhvL0gAoEoROrgjUnttPxg9/Wm17aPQG0ank5PR5V4DbwjtNdwW8tbmbx0xWnlJ8KNku7P8e3PZ616dRmrMEWq7hzSlRHNiuD0GMjrkOskoEasOGSbHgktY7yXObdCmIGoEFmKpvBsh/9wYPX38m84NoCB1zcHhtP24FYoMHa8RbqHz3qH2wHzA6bDCMmztL3bhRC95Mf0GV3v3F6yTY16pVSdqzXq5qkgj4IrPpn0th53PrTwcJG4mjT/GxtR/sBmmPoPEcn1W8haiI3+ZIMEd0AfKXnq/ScJCykKW70N+iFiNZMJ26aVolC8YN/+SpXuflSeIXllMRtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66556008)(4326008)(66946007)(2906002)(38100700002)(8676002)(66476007)(44832011)(83380400001)(86362001)(45080400002)(5660300002)(8936002)(33716001)(6916009)(508600001)(6512007)(6506007)(6666004)(52116002)(9686003)(54906003)(6486002)(186003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SlsH+AsoGYvKgCs1B8hq8pPFdssEZxLcMfTTCbHpygIR+mzFM976JNGLtSwb?=
 =?us-ascii?Q?w/wYkWLgRpFTVhndV0h/wqSMd/DeZjZMVwyaIMSp3apWcwWtgFlqpK7IZf67?=
 =?us-ascii?Q?Vwn6Jh4HFUjwbwd92cth3ceaMyQ0SZFXjUm/Pn+kjJ+YkjmGa6FZqWQ5E+N9?=
 =?us-ascii?Q?LuxPL5ecdbag6cEq3KsCXyok0o9PZe4jIESBZ+qh1VChH4odGna1Asn8tggL?=
 =?us-ascii?Q?lh8iCYeHyadtrPkSn02R5RzVhdDs73XgZPPF5gn9MpYf36tyOutMx9j+inEO?=
 =?us-ascii?Q?QSY2BBWWQZZfgt7seLR9dbpDK8PRxiAP/kPNm0i+NS5YHJw9wi3bpRZSzgkM?=
 =?us-ascii?Q?UbCfKJTJghhTFekqdPXCwvIGdAatb44KTTqqvpVyPbXEzokXLePa9EoLrR2/?=
 =?us-ascii?Q?3ND9MvUagCEetkYqpLnCeyOQr/igeqUS/8f4LGrF0nPFYlhCTrWFXqV5BbdI?=
 =?us-ascii?Q?vjBxV9kw+luzyQeljGPvN00CvguxD8h6X4eMmmY9B2Z9STLPOsZfjC4bJtEc?=
 =?us-ascii?Q?JN5sP9ISoq4trk8MqpXEHSMHTz87xYN0vaQ9uIbyYN6cz9F1R2/X+DtRqWGL?=
 =?us-ascii?Q?ZnGUfLFvJ4sDQo3w6E0nOIX2oMdrxdSWVSILi+gsIXLy7pcHES5dRiEUhQfO?=
 =?us-ascii?Q?0dwEcvXSk2SNkv3gd+E1rjlwmPsAiKMqJBMamOcSOcNteVekpQpXyqFWTD2T?=
 =?us-ascii?Q?J2PDVXkoqPVRDx8A5s+CZK7hyEGoqhtJzYTdyrWFOBygNOb/ZP1CQclxfTn3?=
 =?us-ascii?Q?dYssB/XO3xMmkIXV7hJE2SsFz33J6/bb/hfq49OK8ZcIPMmtthyNC/GMq1oe?=
 =?us-ascii?Q?nKfGDp6T7Jd2N4YIyXEI54y50Mm5H03erjPcAY3ZbjpX2ST1Ww2IvftNoGmP?=
 =?us-ascii?Q?HLGpxFbAlrU2O96sFRniTeQ/oWYRhdacWCJl/qCo5zBknD6QtVe+Qmke+qYp?=
 =?us-ascii?Q?yhN+zZVtZawja4GF/RiCvLbzGKjpgitAckwzeR6S2BSr+MNgcw6H+bmVi4ML?=
 =?us-ascii?Q?a0p2jYp96UST/7iD3c7Oqz9mCxbtnUg+ckKwu4LEypjeXiGv+b1GkkXignqI?=
 =?us-ascii?Q?YWaAp3FH1r4oSz4ox1CJzwkmvNdtld4by45Xo+rt2PkLoLCHain2LMn7mmtT?=
 =?us-ascii?Q?YVFmwx+fIkxw+lYcHVj5YTELD7lXXlj6Pceo7BowdhAXBLyzXbrUF+gqx6RA?=
 =?us-ascii?Q?OHo6AO4m1gTMmhzjTlndMxCIE/Etn5N+mcDrgwRuSw+WPmJ/KvbKKf//HRNQ?=
 =?us-ascii?Q?29tSEXXvjYIZeKpcKPngwelW+49r+/QlotFA0g3bU8w2ZjYZUXnJDYdFQKcJ?=
 =?us-ascii?Q?RHXZVYh33j+C2yv7e9rAoGEn/i8VoIm9eGo8uHSHFEME6W7BjpNn96qONTuN?=
 =?us-ascii?Q?BQxXOADgr2JhDG1vbhBdz4UsO+DxCrDCfmusBXpT/n/OcTulN/6C9Uhp++5f?=
 =?us-ascii?Q?Bn6IC0doPm8JytNk2HwVvZByj3e1Fi39s2ZYfWlE3Dypv/4jBB9S7Gh6q3TR?=
 =?us-ascii?Q?jv759/wU5Lt1jhhzHcFgZY28rSk9dSaZFB7qp7OtCt/TK1k9JhT/hLWRNqKW?=
 =?us-ascii?Q?03PTH9ykjPg3BUrSzXKA2mIU8R/WV8B/kCAPpjF0OsII8tlxllS0yikKPxg+?=
 =?us-ascii?Q?Gdltb6qwSKwZlopxaq/w+QDIujDLq804iosvUn4oWNMwTmnCQqOs0uGhDdO6?=
 =?us-ascii?Q?G/7t7kTLzIslGLTcJQvIjTt72YWUo/LjUkziwMKY9Y8NGtKUY3W6LVeNM2eo?=
 =?us-ascii?Q?a0gqJ0EpYCByv+0vN7z/QOaKufmgICLXrTT8jf/bU2k6kf4L4me3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764cfaff-3fd6-45e1-51ae-08da13291965
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 15:14:06.9190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEaC2c3FHDSScUwThc63SLrmCgeiNAkSKdC5NLQucrWiKDS6CaG8h+TfLB8WHocOW4Uf7K4FB2tNZdllShRplQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2745
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_05:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310085
X-Proofpoint-GUID: BG6FVxkhaAh9KgvKaoMaBdOY27QlEYlN
X-Proofpoint-ORIG-GUID: BG6FVxkhaAh9KgvKaoMaBdOY27QlEYlN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 25 Mar 2022, Andrii Nakryiko wrote:

> Add x86/x86_64-specific USDT argument specification parsing. Each
> architecture will require their own logic, as all this is arch-specific
> assembly-based notation. Architectures that libbpf doesn't support for
> USDTs will pr_warn() with specific error and return -ENOTSUP.
> 
> We use sscanf() as a very powerful and easy to use string parser. Those
> spaces in sscanf's format string mean "skip any whitespaces", which is
> pretty nifty (and somewhat little known) feature.
> 
> All this was tested on little-endian architecture, so bit shifts are
> probably off on big-endian, which our CI will hopefully prove.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

minor stuff below...

> ---
>  tools/lib/bpf/usdt.c | 105 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index 22f5f56992f8..5cf809db60aa 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -1007,8 +1007,113 @@ static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note,
>  	return 0;
>  }
>  
> +/* Architecture-specific logic for parsing USDT argument location specs */
> +
> +#if defined(__x86_64__) || defined(__i386__)
> +
> +static int calc_pt_regs_off(const char *reg_name)
> +{
> +	static struct {
> +		const char *names[4];
> +		size_t pt_regs_off;
> +	} reg_map[] = {
> +#if __x86_64__
> +#define reg_off(reg64, reg32) offsetof(struct pt_regs, reg64)
> +#else
> +#define reg_off(reg64, reg32) offsetof(struct pt_regs, reg32)
> +#endif
> +		{ {"rip", "eip", "", ""}, reg_off(rip, eip) },
> +		{ {"rax", "eax", "ax", "al"}, reg_off(rax, eax) },
> +		{ {"rbx", "ebx", "bx", "bl"}, reg_off(rbx, ebx) },
> +		{ {"rcx", "ecx", "cx", "cl"}, reg_off(rcx, ecx) },
> +		{ {"rdx", "edx", "dx", "dl"}, reg_off(rdx, edx) },
> +		{ {"rsi", "esi", "si", "sil"}, reg_off(rsi, esi) },
> +		{ {"rdi", "edi", "di", "dil"}, reg_off(rdi, edi) },
> +		{ {"rbp", "ebp", "bp", "bpl"}, reg_off(rbp, ebp) },
> +		{ {"rsp", "esp", "sp", "spl"}, reg_off(rsp, esp) },
> +#undef reg_off
> +#if __x86_64__
> +		{ {"r8", "r8d", "r8w", "r8b"}, offsetof(struct pt_regs, r8) },
> +		{ {"r9", "r9d", "r9w", "r9b"}, offsetof(struct pt_regs, r9) },
> +		{ {"r10", "r10d", "r10w", "r10b"}, offsetof(struct pt_regs, r10) },
> +		{ {"r11", "r11d", "r11w", "r11b"}, offsetof(struct pt_regs, r11) },
> +		{ {"r12", "r12d", "r12w", "r12b"}, offsetof(struct pt_regs, r12) },
> +		{ {"r13", "r13d", "r13w", "r13b"}, offsetof(struct pt_regs, r13) },
> +		{ {"r14", "r14d", "r14w", "r14b"}, offsetof(struct pt_regs, r14) },
> +		{ {"r15", "r15d", "r15w", "r15b"}, offsetof(struct pt_regs, r15) },
> +#endif
> +	};
> +	int i, j;
> +
> +	for (i = 0; i < ARRAY_SIZE(reg_map); i++) {
> +		for (j = 0; j < ARRAY_SIZE(reg_map[i].names); j++) {
> +			if (strcmp(reg_name, reg_map[i].names[j]) == 0)
> +				return reg_map[i].pt_regs_off;
> +		}
> +	}
> +
> +	pr_warn("usdt: unrecognized register '%s'\n", reg_name);
> +	return -ENOENT;
> +}

this is a really neat approach! could we shrink the arch-dependent
part even further to the reg_map only? so instead of having the
parse_usdt_arg() in the #ifdef __x86_64__/___i386__ , only the
reg_map is, and we have an empty reg_map for an unsupported arch
such that calc_pt_regs_off() does

	if (ARRAY_SIZE(reg_map) == 0) {
		pr_warn("usdt: libbpf doesn't support USDTs on current 
architecture\n");
		return -ENOTSUP;
	}

> +
> +static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg)
> +{
> +	char *reg_name = NULL;
> +	int arg_sz, len, reg_off;
> +	long off;
> +

nit but it took me a moment to notice that you had examples in each 
clause; might be good to have a higher-level comment stating

we support 3 forms of argument description:

- register dereference "-4@-20(%rbp)"
- register "-4@%eax"
- constant "4@$71"

I _think_ you mentioned there were other valid arg formats that we're not 
supporting, would be good to be explicit about that here I think; "other
formats are possible but we don't support them currently".

> +	if (3 == sscanf(arg_str, " %d @ %ld ( %%%m[^)] ) %n", &arg_sz, &off, &reg_name, &len)) {
> +		/* -4@-20(%rbp) */
> +		arg->arg_type = USDT_ARG_REG_DEREF;
> +		arg->val_off = off;
> +		reg_off = calc_pt_regs_off(reg_name);
> +		free(reg_name);
> +		if (reg_off < 0)
> +			return reg_off;
> +		arg->reg_off = reg_off;
> +	} else if (2 == sscanf(arg_str, " %d @ %%%ms %n", &arg_sz, &reg_name, &len)) {
> +		/* -4@%eax */
> +		arg->arg_type = USDT_ARG_REG;
> +		arg->val_off = 0;
> +
> +		reg_off = calc_pt_regs_off(reg_name);
> +		free(reg_name);
> +		if (reg_off < 0)
> +			return reg_off;
> +		arg->reg_off = reg_off;
> +	} else if (2 == sscanf(arg_str, " %d @ $%ld %n", &arg_sz, &off, &len)) {
> +		/* 4@$71 */
> +		arg->arg_type = USDT_ARG_CONST;
> +		arg->val_off = off;
> +		arg->reg_off = 0;
> +	} else {
> +		pr_warn("usdt: unrecognized arg #%d spec '%s'\n", arg_num, arg_str);
> +		return -EINVAL;
> +	}
> +
> +	arg->arg_signed = arg_sz < 0;
> +	if (arg_sz < 0)
> +		arg_sz = -arg_sz;
> +
> +	switch (arg_sz) {
> +	case 1: case 2: case 4: case 8:
> +		arg->arg_bitshift = 64 - arg_sz * 8;
> +		break;
> +	default:
> +		pr_warn("usdt: unsupported arg #%d (spec '%s') size: %d\n",
> +			arg_num, arg_str, arg_sz);
> +		return -EINVAL;
> +	}
> +
> +	return len;
> +}
> +
> +#else
> +
>  static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg)
>  {
>  	pr_warn("usdt: libbpf doesn't support USDTs on current architecture\n");
>  	return -ENOTSUP;
>  }
> +
> +#endif
> -- 
> 2.30.2
> 
> 
