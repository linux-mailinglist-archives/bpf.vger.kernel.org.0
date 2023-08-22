Return-Path: <bpf+bounces-8229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E86783D91
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 12:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A136D1C20AB0
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 10:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E607D9455;
	Tue, 22 Aug 2023 10:07:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41846FA2
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 10:07:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2120.outbound.protection.outlook.com [40.107.93.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC44CCA
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 03:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US7jITgmCfI/MZdvVONCLVKYFcwY6DHyHGhxjdP2nVN1pzhl8hiy/4SP0fJJiMACx0mCrT09otSi+NkG5PLPFcohXS1AFuOP9H1wkfAgLghJGxA34M35vweVkBcewbOC66Kc+Tvlyo77arXYIUeEdrwwMZssUwRSlPjzw66GzMkMhPHU9h7eX+P5J5YXO1ujeoz3963U6kvOQ0kSFQ/Wyi0DsalY96p3WXSMpKuCnmWaWX/n9vXwmAsBi8X3IyY6K/R1AQhWyoR2zbv2kTkZCcxztnXWKDsTKEA0twuhkhjZunDimYw/x/noPS16OBFf9I33jYoJ534gP4VYdR1IBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYdH/y3Y/ZoIEKyzGk/EmIIMSN+Y0MElCIHhazGCTbU=;
 b=MDqE1BDfNoZofBRV9lbtokkgcJ/g9ua5T/UDPbz+EF2sH1tsnPgw4vVGHt4AazT7R1u8Evd1Yjz3kE4HpSj3G4VyymNFUob2bE33MEizuwPKyEQRNFYokxv8Y82nIn6K8Rh/Mkl21dfOLvu2O1z9hFTLr0OLr2OuDe4q5bHlOp6g1ZYtAMq1Cw8l7ufEYkOQPo8M6n4t67sDp+kbqnY0JUFg99ZUpIAr3E0aQVid50HhqAi2+F63sQbNCGNsHFGO8M5RGDSS2yN45cZcewEpOyXKoSRySDYm8JsirXwIKVByGBOa4Owv4crC8bjJKXqqcJUAkE5C6Lo7FdoftM9lnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYdH/y3Y/ZoIEKyzGk/EmIIMSN+Y0MElCIHhazGCTbU=;
 b=N/XMK53r7HyBreJ5IrWFyu7oeCVkVbf/BOIUcoT2xGyyTkOAmrhpYccYH+BQPtfpQUk0NRCMrML5jgMGOsMqdwShBxfg9KewiGKbxx2p0bDoP2kXem+0NkmISAeKd88VYkxWt7s778nSlEmkhYsdLnExasSn3ihkmG1GYWywraw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BYAPR13MB4248.namprd13.prod.outlook.com (2603:10b6:a03:a2::31)
 by BLAPR13MB4562.namprd13.prod.outlook.com (2603:10b6:208:306::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 10:07:21 +0000
Received: from BYAPR13MB4248.namprd13.prod.outlook.com
 ([fe80::9e1d:aee:24af:f659]) by BYAPR13MB4248.namprd13.prod.outlook.com
 ([fe80::9e1d:aee:24af:f659%2]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 10:07:21 +0000
Date: Tue, 22 Aug 2023 12:06:57 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Shubham Bansal <illusionist.neo@gmail.com>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Paul Burton <paulburton@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Wang YanQing <udknight@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: bpf: Request to add -mcpu=v4 support for
 ARM/MIPS/NFP/POWERPC/RISCV/S390/SPARC/X86_32
Message-ID: <ZOSIwWu4nJuYayJn@LouisNoVo>
References: <79d3c797-17ba-bc9e-b1f9-44ad024b576f@linux.dev>
 <20230821124711.15babfee@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821124711.15babfee@kernel.org>
X-ClientProxiedBy: JN3P275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:70::18)
 To BYAPR13MB4248.namprd13.prod.outlook.com (2603:10b6:a03:a2::31)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR13MB4248:EE_|BLAPR13MB4562:EE_
X-MS-Office365-Filtering-Correlation-Id: d324da8d-644a-44fc-54af-08dba2f79334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	56dgLWB8QP2SlqJ1GuMngZiC2ZAJ2RRu8Iy2/i+t6SM1txsv0FUE9RXSThnDYjiTLagbiBUtekO1SamNqsSVLcf+E5o/H5RO0vOJEFjg5wcihotXXzA2ZnfKSBlyV8OKtmFW5Kr0eZQb97lHR/MA/A7PFhiwWVG8bk3SYnQgTu3qfsnkk8eC7owc+fGlHMVhi4s3FEJuorOhiZItuazPe+CyJjXzy9o3azx9Kjw5ljqMR6GDocMBd+b7F+sLtsZrGO9hVPkIaotv38NbP4+DCdprvtKBnjtlNpBmyOwFOm3mhmAbziUI6uZxLkwatKItnJe3hj65oWnzGuNZ2UARZBd+06vaIAHXOGR28ss+vqvHNN563K9aHHK+nlaGSzp83B9WDzREiZAi552OOlDPXZDLBeStVgu3AtSZD4ZDjbqBX2dtPH49EDw9yVVEw2Z01Hp1Ni5QA18jsPgFdYBhlY7WC/XvjvSCS5cCFCFnjYrMy4hvdLHtVzlaSvaz+QzrMIRk04U9BWS9BmhjxMkP9V9PLcOoS7foZH3ocPjni7ADOLlGOvvpp/FhUCs9I/un3hLKPTiK9q7f9QJk3Kl3sHW7g5x7ttzepU+vtbodFgFB8qR+9G8+4+Jog6dqvpj22VrsleXlBtqleKmhRZsyBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB4248.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(136003)(366004)(346002)(39830400003)(186009)(1800799009)(451199024)(2906002)(38100700002)(83380400001)(7416002)(6486002)(54906003)(66946007)(66556008)(66476007)(6506007)(6916009)(316002)(55236004)(6666004)(41300700001)(6512007)(478600001)(9686003)(12101799020)(966005)(33716001)(86362001)(26005)(5660300002)(8676002)(44832011)(8936002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BzJUUywsVAi9pBo+yXV43MysBT9eghs0JD5lcGQFbDZhdMlDg4MFBPyTTaRo?=
 =?us-ascii?Q?UK9NijaKjs4JmpxvKkA3E8w8EYPLr1V13GwhwEbzkT8pXvGYcgXIfB9BWwtq?=
 =?us-ascii?Q?rAslOOsZ0Wo+s1r7sGQJ0Uk7cjRRZkjXAt2zCHcpuI8KC6iRvwEw+FqevTrs?=
 =?us-ascii?Q?kKJv8VpvFbJ+P9GzZz7eGlMapMhzHKthBqSdIn4OmUb6hwo4uS9M7ModTK9S?=
 =?us-ascii?Q?scJw8MqcOh4HFZpkNgtsRAkBvjEZCiHhw6ImV0wfEAa3JCyvzibeLwjJlHc7?=
 =?us-ascii?Q?xaaHlBMFJrFSvkZneZ759yApGY30JB/MIoWVIvkmGPUrInc55okbWlH7IqPS?=
 =?us-ascii?Q?3GU6I0VXMjpKl2/CC4piQE7RP+TOSKprS8qn5/hwW15i/2hpDURlzzMRMuzB?=
 =?us-ascii?Q?XWZy/scZ/QCwRy8Wuu+OMF/qlXZq01gDnVcSytWuOyUc3knGQtqy6HdZ/Gy4?=
 =?us-ascii?Q?BWbstWFaWWiD7KKb/YZbFAlAsZ4feCdVOqIN0fuixwC/dPcSjbJqjOZZ67Fn?=
 =?us-ascii?Q?fNqSOkTb2ntwH667OYI/1G6e/qsgm598pDmMuw/kedPOoTzYyN/hntNeJUCw?=
 =?us-ascii?Q?yInqiPF/CJ9FWHtmCwz8hOtFezIBlnKTSknK0K1BiP8BeeuaWFaB1gt1krfw?=
 =?us-ascii?Q?uvNk8xmFC4hN+pB7UMpi5CTpOcq0Jk1qeFqlHLQexzIUDCbGcPpPEu9uVqAx?=
 =?us-ascii?Q?uEgl7dvRKm0PcJpm/ofe+XscCVRR3we8cX6LKXBA5p08ZPHtRI2v3S8UNuZf?=
 =?us-ascii?Q?MdeGr0REAs8evLvpZPxEKgrVe2hGCybzBl10WyWa+Qpvn/xbsI1o0kmOZkut?=
 =?us-ascii?Q?cCmh0giD0asJ1OZQbjz3MTjAduQw6b/iaaw0vZi7rdjS0JiGF22z+lvjgOs2?=
 =?us-ascii?Q?eMwsJg5chtC1SWT9Ydcwn+aCSA+EWG26bL4LYHIwbCpj+QLInMeV+77bN7zt?=
 =?us-ascii?Q?9GaeiHqV2Ofo/dzzm1qad4qhuE7MtYSc4pTQn3ScBkHjjvLG1k3WXLJoHkWF?=
 =?us-ascii?Q?kWLiGmrN+nef+LJZoxFjgrr6slVazVY/5PZK1wz4soXe6UxtZEUe3v9zSWpH?=
 =?us-ascii?Q?LImjjCJACgmgGzTi8qzdN/VpZ2NgxD3hT1SLa8uURWMfyv3uPHefcKZt5gTb?=
 =?us-ascii?Q?NOWu/DDAFjl+AMNY1BRsWaIRyiimxhdFmuJ/VoHoHcF0bBhSwOkaIlKnXe0t?=
 =?us-ascii?Q?nzhlXDTLK/tQ6qYVCJvax9JBvyNRD3gH72nHBcs70/m3T85dAjX02MSaoMUL?=
 =?us-ascii?Q?1JwyxZTSDyeaqF0qzjyTbeVcN2ljpxhhHfQXg2TT0BewkIFsYhe6aDaHPknp?=
 =?us-ascii?Q?9QNFtaaJJFedKkEiixu1+5EGl7fUfSQop9K8ynY+888rwvTeIqXojI/LqeED?=
 =?us-ascii?Q?Q9tzc5Bo46E1FJ0WLL9uFynZXy0x9pzzQTRXjAv7LbWmZK5vf27VAZI8DVHa?=
 =?us-ascii?Q?PQfV63fc3BAZgkuoqMw+sBGoE5tDoTXQIpq5f4V/fLa1L258IY/0GorSGQIO?=
 =?us-ascii?Q?8Xbqfx2cwA7JpYj6+7VyfYMhCN2BMAp4Cza4xW5sO5bp3kSOGLGKa/l29ApL?=
 =?us-ascii?Q?0CzRAQTWU3TsLURfJYvdU+GECuCWoFbCrQdqo2bTIm475MM/ILeYTFQnKXms?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d324da8d-644a-44fc-54af-08dba2f79334
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB4248.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 10:07:21.4937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTG3HX5yupRx9Xe4GXvCHOw5rmE9dL5RCdiUhS3mTIjYI02CHBuqwUC/D8JwpVhzQzp8g0ubVd7ki3iZsZlSK756kfcD1TBIpviy25Z5vfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4562
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 12:47:11PM -0700, Jakub Kicinski wrote:
> On Sat, 19 Aug 2023 18:41:30 -0700 Yonghong Song wrote:
> > Hi,
> > 
> > A new set of bpf insns have been recently added in llvm with flag
> > [-mcpu=v4](https://reviews.llvm.org/D144829). In the kernel,
> > x86_64 and arm64 have implemented -mcpu=v4 support:
> >    x86_64: 
> > https://lore.kernel.org/all/20230728011143.3710005-1-yonghong.song@linux.dev/
> >    arm64: 
> > https://lore.kernel.org/bpf/20230815154158.717901-1-xukuohai@huaweicloud.com/
> > 
> > The following arch's do not have -mcpu=v4 support yet:
> >    arm, mips, nfp, powerpc, riscv, sc90, sparc and x86_32
> > 
> > If you have a chance, could you take a look at what
> > x86_64/arm64 does and add support to the above arch'es?
> 
> Louis, is anyone on your side still working on BPF for NFP?
> div/mod and the jump will be impossible but there may be instructions
> for sign extend or bswap?
There isn't a lot of activity on the BPF side for nfp, but here and
there some things do get addressed. I will run it past the team, it does
seem like those might be possible with the architecture - thanks for the
ping.

