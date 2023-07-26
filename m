Return-Path: <bpf+bounces-5918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCAC762FF1
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 10:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B5F1C21199
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 08:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42880A921;
	Wed, 26 Jul 2023 08:34:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D0AD3F
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 08:34:22 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58248689
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 01:34:00 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q8EqSh025954;
	Wed, 26 Jul 2023 08:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2023-03-30; bh=VBEsiq2S7vdtFeE52rTDryaiC8W7ZSXHbt75xkmnicI=;
 b=tA/bZrywOxWa3uMxXIJWfa0PSqRoBKO0i2FbZ/aaB3l/H+NU7YPKwjmONsMKD/rFqI5l
 qeVEeks/taB/ZpCzbeq1g/HvWSvfoMPkgAsjOi94mQV1G1lPGhslEa4iIk1zIUp7nIYU
 e4XI1rUaf0b5a/R2RSIQqfxbCC+ZUYkoQdvYauoQeIqUIS9NydnXLqkb0N2TFU26+nFt
 9eEbi+jDf882x5C12YXKMPn3JjOcSO1ciza26VO7s1CGio8L32x2vkU30+h58T4aBfc6
 iyBi+giXnNje6hg0Kiseq25stu1EyoKtHaqCB34ooQ339OTxBc0XuLkFcSG5c/CsEktz 4w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s075d6ysq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jul 2023 08:33:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q89MXE033437;
	Wed, 26 Jul 2023 08:33:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jc6kfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jul 2023 08:33:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/3OiWzSpY0u2sW2laLq/DMwXJYE20QTUJIRZ0fd/SZZ+lVFLVw7kWknj9TaQSg7so+jkrGYDgn1zGr5XkV88xbGrhXewvmhBY/WjQY6GYeKVM3Af0a4HHu3g9kB5MJJWMH+ejbH89qOr9kxCmnfZIuTXHtobqbYLVQAZb5hH1h5UcJnEkOaqg3VFv5v6A4pxfUY1iED5hKj8dbr4qtAHvuJDaRc5laNqml8DSmXJufCpQgbzkMSNzK7McZq6dKlL8hhjTZKttiQ0TRExIdKhfYOgPtErXSNkP3tsfZuSVs5dGfoP5gvy54/M5TBiaM8lKMsLR/Sh+KAAuUML31hWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBEsiq2S7vdtFeE52rTDryaiC8W7ZSXHbt75xkmnicI=;
 b=a3aAGyUpjG+MY4jv4AQ4wKcc5bfBFCL6SeQCu67xi85VpUjQRBerL9lXL6EbnmInEa/+xTjaR5ZhkQ4FwqRNEdElNVoYrCaORTmlS3aY6s5bH4BGS99QHcQ1WyGM50blOg2Ulz0RNcQ+SvDirQ9PzaGkvaVEoAJ2WQuMOAenPmStwHz9zrb6xdcMQeBCNXKOF1GKYMCScosy8f34xH1kx02QWy8GDHWa/UvmFZKuwd595oVDr77JLZTisPHJbqoBA/IJG4f0OmbVorxPOJdrOKYfn6DSJY204cAZoUv+Lipm3qIkarOcpokfza0UjFGY+ZUTVZ+b4763C4jtznWEKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBEsiq2S7vdtFeE52rTDryaiC8W7ZSXHbt75xkmnicI=;
 b=ieApOrzwQAVjMsV0dPOLYrDTNtVWrREOy2U6Y0lfHhMN6cQqAy1S4K3F7AQefY9nfgLVphSZa/YzgGXLcMhZx14Caom5hD1H8Xj7MEdlCt3Qh09QJ6vR4TEcB5GpsQeHdaM5DnSy/56zwxDSK2mA359f0hTRJ+FmNOaCY9PdIO0=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by IA0PR10MB7157.namprd10.prod.outlook.com (2603:10b6:208:400::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 08:33:34 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19%3]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 08:33:33 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>
Subject: Register constraint in NEG instructions
Date: Wed, 26 Jul 2023 10:33:24 +0200
Message-ID: <878rb3842z.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|IA0PR10MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: b900a1ab-25d0-48ec-990b-08db8db2ffb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DkHmtq/GlI3CFiru3czvOo9Bwn/SZBRvaA5n6sluHe1btTs+BbaPqCLqOTN6a6DfG3+IQnBSBq4WKP81v5PLOii1p3ZV/sojqR07RdfKTcqkicE6J2pgujq4Hsl+jc8aegsgBufyIy5TO3mt++uMwQV9AEp6r864RYSrkRnwk4gmER6+ECJKx3u2Yi10bGNIhEMMk6XSFMXMfoTRHWbroN8TnABnwCWN829B+a+d4f3J4en/Bobl7rfmaiORzwmQH4OlAyAG0pqIfMdJkrt9mUl+1Yp/4N/d32vQu1XKw77/+V1n3eArRSHVyIrJ3VDPBsFVRWWXEleMxuLg4/xzRXiKBAOO482Y5C/RDuQo0uBFuBPCCN+tKMzqVwkueMtxv5pOvPCW+pcRaT7N/p2ZwfSAyIGGSK/XTFE0FGM4kzW0k00ejx7aAI1xZd0gANjeXm9A5ePAFm7QoN7GAqBdTiNcOP9MhZV5PJGIk5CRzcBJ0hN0r/oCMwDCEA73R2kOkI047LVsSKCLfGCFTpswF5VX/u5I50AbT+qsgyX3MScr2gKdHqW9/qqJ8DqtOPQd
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(6666004)(6512007)(6486002)(54906003)(478600001)(36756003)(86362001)(4744005)(2906002)(2616005)(66556008)(186003)(6506007)(26005)(66476007)(38100700002)(66946007)(6916009)(316002)(4326008)(41300700001)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eg4uTB0fG718zZv4CdAko+gkY4HcHqHbXHwISXlNyxKP5Eie89GhzjwZh2xR?=
 =?us-ascii?Q?ATWVC5exmcqTlN7Z838Ci+3SgS603UAF8SPRuzxikbIk+A4my+KuJcCTwc+z?=
 =?us-ascii?Q?+/M7yNWnH89sNbSpVElYShCmyTkdCaxb8coTjvS38C9hl7ztD2Cbx/UyP2cO?=
 =?us-ascii?Q?pBSHotfn3XQkG/46WyawNXViWQKppX3Fm13e7BcZJbM//8v309qjMyq/fzXE?=
 =?us-ascii?Q?vGwJ9DcDdiM4xdEytjHAU6MLh8hlBOX+WE9XmSAayibbCAriP8Ji554KI4J6?=
 =?us-ascii?Q?kr+4fqRxtp5mAWzDlPzAQBnS19sh5sjg8YAcPIZDUp//vBR92X1iR07clzBA?=
 =?us-ascii?Q?suC9gDF7LStAicJu4svycZ3lzsR0+wdpYDddBZIl1MdtK1PQu001swU+WFr3?=
 =?us-ascii?Q?iofWdOpEEecBGdoADBIrqj69TdOELx50TEyvFEvpakmh06i+NIciqKEUN2bj?=
 =?us-ascii?Q?m39IaDP7tE5pQfzkys4xqfBsHPG8kOlCP1e2ZTo4acIknJ6642xikgb0TRAN?=
 =?us-ascii?Q?aRrPPWIcGH6Ga3HG5BFxBg9lxiQOp5Uaf3H8HFIm9/+Pk4nvcUehOn2cKmD9?=
 =?us-ascii?Q?H4m1w2p9fxqnAaOBeQ4VH+FHkNccdsab6xQjhm+nbGTsIVMfluSIYYZY4XG6?=
 =?us-ascii?Q?fjqP7P1xX04InGH8+Ku6QvAnM17G9fGVP7w+f2nrZMW32NbbxJyO86XlINrN?=
 =?us-ascii?Q?VbOWTRsFUHcK70nmAAXQcRocasgk5qAzKqgdtM23PWhwhOeDcNDIKHECj9/k?=
 =?us-ascii?Q?+7039mwm4YstQGklkGx3bXu9itfXnuYGJCcWWsUqpJ8Hy/s0PTiEFmxbor2q?=
 =?us-ascii?Q?Pag2LSmZPwmxxpZ5tHtMm/irVdbXPEwm4BLfLFDbfwEVJD4R8qcywbHMs4uD?=
 =?us-ascii?Q?kWZG6jsEUcSlCPD5x02g6t/fZ74he1IvBFBsS3+yVUtNHTnEn1E6v1/mHFaR?=
 =?us-ascii?Q?bY6pLt6IezI+sfS8oktQDPZAahP99br0BQOLkmOkc7pKnAh0rCYdnrzhv9Lg?=
 =?us-ascii?Q?sDnraEzh9FR9r0dxHD57yyD7RFw6ioY/NLtwqvOohp3v4yIzfGGxAKVu1CUO?=
 =?us-ascii?Q?PBt4lFQdoA/1VlEAqlDVRI6V3ekkkQIjeAqLOT7ebpSqMdAQMpbYfXV7VCNj?=
 =?us-ascii?Q?xNpuzSjPbvmxHpVJ0PVy6BzqEbR2cUBKIxT6eNqPMoCY078FJ1sB5eLBpdeC?=
 =?us-ascii?Q?TtAePdK4ePmSMR/vxZiLvqTzhv8SHxaeM2D4bXvFRQk+W0XWuyNMvFxSty/Q?=
 =?us-ascii?Q?1bUtHqKXiwWyqns0DJmvARXuAOQ7CDzXKY3pGTOsykwhxeeJCC8ljACwJbi3?=
 =?us-ascii?Q?JcFTUMPG6rrrwmOeAKA/4KyeV8WFz2P/YmSGaimUharjlOSRGb5yvx0Q/vss?=
 =?us-ascii?Q?9M2xcQQC9VhoTuv/gEIzl+y/gjYMFLtGWbTcDCrkeLf2r2asocQRQNGpnsWN?=
 =?us-ascii?Q?cLu74U9HNbYjoyy9dGBYkRwKt4zQBlt/ONUs4OVJOi7CjzRrz2xzbf+/dbt8?=
 =?us-ascii?Q?+thUGnpWsDtekGiG/nHnmX887SrR2Crn/4ORV/ayHJ83Sp8wgUfHReEebVWM?=
 =?us-ascii?Q?4PVUOxYkFEjkn3qr67xa0Wzv9e4+pWm+a2FH8lN7Ds2nUI8DduVbK5KxaQbw?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Vw0yfnCXGL0nUwrPYtT2QrWMuLZChbMHv3cvjMlfLwVZ/3N7Nd96idB37yI2KtLUjez4fL63WdJQTmIu6mTLEQ58LiVPnJ2eC1klvtOjavCP4qPXVNbWGWUwh0/2qwXYtd1XltoL0cA6N3djks02qZD8qrfscwGj/Ypu3z+o0gbSu5pl/BqhJvH1GvApCY8pObwUHDe26SRudDCDeaqVScAMVEVvYmxmhyzgHwe5iKO1IU1NwGBGa59SLOMnKU9nfIEnwQir6k7eQYVO9i2hy4kEHplPE9xx9LHNoYQrmph3RLVMmcRlwEHE4WzWBWufxrb8sjyTdI0Svarmd6A+97BA31+OmwnDD7+7QiA7khxEpWZ9X/t32mbQ2zGnbro9+zBMRsa/STwPp5mO11CzXijmIKxaSzpnSDTa3QJ5GpmxPcf2wM8IX1yL+Mkop3RTe2i5uL89K9BMd31PWVJOot9HAKzCXresJGDFrLUDjTdiy0yt8FJwRjk+aqqz7853MJwfoYIlr1LrTvgfvZJFtYZlNRt+ugHtDFSPgUkweSxZkL9CTMknA6i79/RTAs7Dk1auSb4VDzf/Rq+lIL55jya9FlvZ0cAesADnAEzW0HGKzLZRTqcEl2pjsh9hwaFz7e1R8Wxn7Xl5Bw6TYPp3TRZvLmam9rk3AncfkcfuybNXFzNglXu/km0wAoTAxNzEJrBVUa00HIp1bLdTOz2dnNjRtkhLhCbL9pS96bHSZxv8pJJ6lA+jjmtsP9eAv9BFMlkIeyw+KTlpdJKtmNiuh0G+wrARIUxXNaFcYDKXrMPXZMhp3f/heSo24fhbPf7/
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b900a1ab-25d0-48ec-990b-08db8db2ffb4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 08:33:33.8602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wz4I7Ljy2zOxXnxXX7VtLdjTrMSpOimHrG6kPbYWVzRIh66NAeFB6iZan6IH1k5TrFL+kLcjOxX9tF5WlMtxYjbv2bsHEZFLtDMANBTN8e8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_01,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=246 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260075
X-Proofpoint-ORIG-GUID: C6upj73LZ5d9gQ4w_wXUdHv7p-q0Dcd4
X-Proofpoint-GUID: C6upj73LZ5d9gQ4w_wXUdHv7p-q0Dcd4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Hello.

The neg (and neg32) instructions are documented to use (and encode) both
src and dst register operands in standarization/instruction-set.rst:

  BPF_NEG   0x80   dst = -src

However, in llvm's BPFAsmParser::PreMatchCheck, it is checked that both
source and destination registers refer to the same register.  If they
are not, an error is raised.

Is this to speed up JIT to different architectures, some like x86
featuring `NEG reg' and others like aarch64 featuring `NEG reg1,reg2'?

Should I send a patch for instruction-set.rst documenting the
requirement?

Thanks.

