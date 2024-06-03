Return-Path: <bpf+bounces-31211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7CE8D8695
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 17:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5626C281440
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 15:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D973136E34;
	Mon,  3 Jun 2024 15:53:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431132576F
	for <bpf@vger.kernel.org>; Mon,  3 Jun 2024 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430021; cv=fail; b=GXgV7Na+trFlUN+dfOJ/0qr8FXixHrYsAyA2+7hhmNIG26ZXHxPAe72f0rbsyAWI4SJ8CG3LQEKWfetUuO3wQNrtO8Y7+97d1rjFW67eZ1/ZSBlE6KgI42fG+jSL4d84nonLW51OZzQHkC1dRqPIm7GhwwFpbc7Hch8QiXEqn7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430021; c=relaxed/simple;
	bh=3WHSVKioFQrrBdK2GmNAhHsiCoA+nU3v54MORpb2abA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JZAhgLdCGpYtKwOJAOc+2QY2kQAowQiJ2ty13YhlOsjUu+gDENUEWSpZnAQ1c2+I2LCk3ziv/8ZLxIzyB8XA3Rh3YMt7A+yNlRkhJJA1NsFUfE7J0S5f54F6Yjqb1IiMDbgCunekx8P12lEmF0J8H/X3SXiBOlVlm0EAaTNy/7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 453CGB1f024393;
	Mon, 3 Jun 2024 15:53:37 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DUx2u+CMiuFcdgbPKzRgs4C1AYBcJL4odDIDVdRfox1M=3D;_b?=
 =?UTF-8?Q?=3DBwS+ssaY30Yh90IZqjJovWN15MTaim0FO0mjJgywT3+/9AbzcjnEW6CUWEee?=
 =?UTF-8?Q?LvMZFzSa_c5L2I1Q/cbKyrVIXMm7Y7ZTukdeFi+PMQkqShI0pSdQmQJzkMQB+rW?=
 =?UTF-8?Q?IGFCrJsHc6oEPF_T8+wu9ecxc9tkuKqoxzjmUMidz6Eaac5OLzVfQxiVWj4V8o9?=
 =?UTF-8?Q?I2CLzkOG3D4x9UtoeOoJ_6ylVTXua/nbLenXI/hrG/cd4srTS/1UAQWVnX9C2MU?=
 =?UTF-8?Q?1nVFJyQQgaIyqsYTHSPCl9h19a_AzbpRj1kiPxd7m3s6G0t48aXGp0V4lz6KXRd?=
 =?UTF-8?Q?Am4SkT2Mvldg9mipjniXVigj63ziEQWo_cA=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuyu355s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 15:53:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 453FGVMT020722;
	Mon, 3 Jun 2024 15:53:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj0pre4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jun 2024 15:53:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTDlBV1IAn9G/0yy/OfwRs9Nag5DrfQkirGl/7l5D2IvhUmkk6BdO2Wezv4AX0YEaVtxhIkbrph1QUc/n0CcLQQpkCwmsLcC4hK5CJlVuM98SPy0DIOMAX2Ar4+5QNZ6ky/r8bAz2VPST/BsBVsH+cBBZyGdCoxQczszcOoIhN9L+eglNoPeXsHA2tVYy2oj/NzOyCL9UowWe/dawUVTHzqZ5k83Em0Ub8uN6NGOcx/1mEXi/rdYgRLrE/UFZbJEuFtV/6PVo3oBullbahjwQtEl9m6zRQCL865e34e+fkN98skKwliMSigSmczKPxGu540dI3ZgUFHbEAbjT2Nz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ux2u+CMiuFcdgbPKzRgs4C1AYBcJL4odDIDVdRfox1M=;
 b=l0faoThF5B894pAaDnzWwLSfnejJkRLvN/G3VZD3uuLbMj5rqq26uTjLI6XypHoCQYerdZVmTWTrq1au5SU8R3jCEE7rFIE2CzJv3V1uSmS9MpJ5WtnwNgafDuaq7R4YNx/4D3nR/ajOsZgLNoY3AkDMoCsDU+1aFzRvmRc/fSxL1lVwlVy6VMBEZ7KGtmP0fxAMFOrwwYal6hH3tr4ZycS7KWokaiWi+wBDXjq13tn4mxbkxRJHLnqIbnvW394oDs4Ye1sDsd7NZ2jCCpydnfY1BmPAYsLhiSnFYPChzNlT3HhtgYp1wBP1xNURbBZhQlTGz0uGegGEPZ91zPSSFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux2u+CMiuFcdgbPKzRgs4C1AYBcJL4odDIDVdRfox1M=;
 b=I6cczN3R6JPCeB/hR/bHaUA3heX0ZVTU3tTe8jLuVDU2c37GzUy59fUVh3nYfXbCeyF7UvgGzeerRS6vJ2OxZAPxHC+eSKqGqK2ZVABRL+i+Uh1QTZBR3COTXtam5KkLZfjy4TkxZs4fJufsVAG5QQ5JT7tlV7CBcJzi7V/k5Ik=
Received: from CH2PR10MB4373.namprd10.prod.outlook.com (2603:10b6:610:a9::22)
 by SA1PR10MB7790.namprd10.prod.outlook.com (2603:10b6:806:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 3 Jun
 2024 15:53:34 +0000
Received: from CH2PR10MB4373.namprd10.prod.outlook.com
 ([fe80::ce3e:31a5:f731:d5ae]) by CH2PR10MB4373.namprd10.prod.outlook.com
 ([fe80::ce3e:31a5:f731:d5ae%6]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 15:53:34 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>, jose.marchesi@oracle.com,
        david.faust@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Match tests against regular expression.
Date: Mon,  3 Jun 2024 16:53:08 +0100
Message-Id: <20240603155308.199254-3-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240603155308.199254-1-cupertino.miranda@oracle.com>
References: <20240603155308.199254-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0009.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::17) To CH2PR10MB4373.namprd10.prod.outlook.com
 (2603:10b6:610:a9::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4373:EE_|SA1PR10MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a4f7b8-cc9c-479e-3122-08dc83e552b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IcyRNXdqBQOq0NMKybKmcadTMnSN+/K4zt9hH6ks7kWQ4d+ZZBcE59wh3qd4?=
 =?us-ascii?Q?clhlvGf16tScjbXTIhEgJJKbPLU+t8b3tgZfo8fTJOul5RtSD59XTvLjmhdu?=
 =?us-ascii?Q?ulJY9Eh8JQE+xXeD+/qPB4wnbTQyvjiF/xMxuAha70zFIfx6fnhZqr+tTd+M?=
 =?us-ascii?Q?EmA/il2hxINpvvdNfiW6JleJk2gpj24/bJgpJnQnpv2m2igyHgvUL8Q9aAF0?=
 =?us-ascii?Q?m9B4Ysnonru4GWIIuJsQ6h4uF6FvCduzCSYireFPIVknkHcmC4CJBvo4iMIY?=
 =?us-ascii?Q?TNLEiRDShAymgwafqHpxjSm4U4nsMUtrvAc8cXlEiTmCeZ0gRxvgM4GHxvNM?=
 =?us-ascii?Q?AXMIhIZApWy1gpAEx6ljaAg4pdMpO+FUzsr2Zc5/fF72Xt2T48NZ4iA18IT4?=
 =?us-ascii?Q?js4BALcQzuV44NlugQrhZ8Q+wLDNYRyfZ+WN6GppGrD07RQSzvebR0qVrryv?=
 =?us-ascii?Q?K8Q6gN92tJAm22X7E2FF3DQ6n/KFW9s/kb1wBzxp6ysSo8WiPLr8Y42FlT4L?=
 =?us-ascii?Q?QjKiOziA0lxJ2wue2c+ac/oEbMsldqS7zf3J6pzg9kqy9lES+pdsKkuDI9tt?=
 =?us-ascii?Q?d83Z3OqyzcFLnkHX21vOP1xnHFDDvsrjM6JrHvbCEv0VIz5mef+IRQ2myDvP?=
 =?us-ascii?Q?xcN+V4IciHl7JEN2KahlLbgI6Aw1/sy5toBbvMkwYmDX+vP0vZPXWB4Kc+1A?=
 =?us-ascii?Q?OWIXFTEeaMyKhsn06ILPeplv+26kxvf6aSdRKVYQp8ZNz8F5Q9x/pGdMCRgL?=
 =?us-ascii?Q?Dfod7pOLL1j7Sn3d5LyPgd0Ap1pculE7HVOpYOqCoGag/5VZwt9K3ToEoOpC?=
 =?us-ascii?Q?57xgcy5wWrHCs+YFwyowfeaCG4bD/6Xb7QMb1s5prZ+RY4WckS0QsHjCtYUT?=
 =?us-ascii?Q?IJAO5Dtjufs9neAv20eFYHEX/OJRiu7lTGxUJhwKkmpySkfskFN/PYHdShUh?=
 =?us-ascii?Q?qBzuBWm7kYqO5e9qtl+2bZERCis0y8HvJ4K/l3Cm+fcxYRHhjHJuqyBVn4/m?=
 =?us-ascii?Q?T2kg2qxhR/5JDFbmfzaUYKOV3iff5GlfLKWDTVTmZqYjrK2UKZP7PNFmvUVn?=
 =?us-ascii?Q?9s0fknGscmRdjIIACoKtszdTPDPnMgPJsB7u4pazEYWpIcqWFUp8LWzRPdJI?=
 =?us-ascii?Q?jd6IvBH6foGd59ZeYzs9xVkDYVnFHIRNwUcxIBkg+DvFuZy4z2Y1ogDDPODI?=
 =?us-ascii?Q?zfdB+neI1fi7IPpH2IPb1RitO4A2oY6gZIsxBWA0GlDLg2+A4qR4nlr92PoM?=
 =?us-ascii?Q?GFdg4nG5lgoB0odrHn5rpE1/RGE5y7CBEhdOyyi+vA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4373.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fJaashlQB5D8E4kQr7lFTxBsxbQB6jKtWyqqjeM2pOZY9rGDJsx0uy4Zhsng?=
 =?us-ascii?Q?bXQuBMPRqw5EtEOwF/Gb5G9PV5N04dAr9vxaY2N2Xra0/5ZCK85nHxwtyjwj?=
 =?us-ascii?Q?8jEz5yyMjoCQdkk4qGP8YClIQRxNoU+T5M/qBAuKsUhrnBLlSSaLyqWmVVqv?=
 =?us-ascii?Q?pa3zQOL6j9KHz2CbijEoc+X/PxptPcWNwnbwd2uumHl1mK7N34Lct+bQ8aWo?=
 =?us-ascii?Q?0EPUDVqU+VRbJjDJ8He5uB0DHJHKcb4fhuY9a4Q6NyMc31KxtFL2LSFDpjnK?=
 =?us-ascii?Q?+1mVX63aEIcLAk7TtKHLs0P+EZVMn2Gf0KCOcNSnEgizcoerwZuOFI/Ys1A+?=
 =?us-ascii?Q?FVM7dLLyjJmdw81hrEshgRkQa3PyME5e7Ybtzz6lQKtXr20e8ol84TDfKIxw?=
 =?us-ascii?Q?lCE/n5mi7UalZ73QgL903cf6JJIYnRLe/X7IHjH2iyK3xvdH0qNxxRxtscn/?=
 =?us-ascii?Q?xiKrLuxPX2fpMnlY5r+BNgEo/5EbjEeocbZs5GSCA2SloU1oJHQ/T59OlOzW?=
 =?us-ascii?Q?HcnbMAVLQvjet948Aw/ij0M0FR/zLgX2TzEAy4VYr3zh2HTW2TZ+4jju+zai?=
 =?us-ascii?Q?armDdxku9dfz8j4D9cdzIKMWXbbD5EN8fUNljxTiPmQqHZYfGwfa/7cm/lHA?=
 =?us-ascii?Q?k5gybt+ZYv1OdP96epyEJzK8FAQJXo/AmGGNwrycsmlwCqSgfyhZDSg6VA87?=
 =?us-ascii?Q?3hZmnnvZ20xb5QvOsJdFEANK70x5qXYZ65oI5CbOQzVp2h0s1oUSJyuSRwAk?=
 =?us-ascii?Q?Ujnvj4PAG+I9fLyy6cGqZ6vQWrmHVkMVlcCpSgUcYFrO3XiBScr/rKH8qUP4?=
 =?us-ascii?Q?3xY1xLAQDBfZhuWIiuuYR5CjzntSjVeVC73djzkywCDFUER3m1/tQJWhF0cD?=
 =?us-ascii?Q?3/g4cbrPBo+YHt3xGqgByqbtVQj1Tg6W6JWy37DYlfhOWR8ecdqljzuUmGUt?=
 =?us-ascii?Q?CsIbICENRRPMGTLwkIN6rdcqF77MCFSzSd5HFjPbb7GrLCx1KDpD4W4tdGzU?=
 =?us-ascii?Q?WLYICKUdK9Gv0SZF+pVXKFgJkcSsh6UZ1JbwrVsaQJxjl8njK/dd7YDbt9SR?=
 =?us-ascii?Q?j6/ke0grGI+8NS++OMGPPDNV3+r7/TW8wPBl82cwnWwLSz8qoMbWt1W8O52v?=
 =?us-ascii?Q?WfFbmqphzocZk7s0ufOGykm5YNQP8FH35mPfkTlad+dRpXqDcMz4XST9dtkU?=
 =?us-ascii?Q?nIXM79oRUKhMkCBM5E9z7LsfwVEZk653behv0Az+YyqndgNHZ3KwIkmTac9G?=
 =?us-ascii?Q?LIoEEKRKuEOawJ96TS6bGuW3UJhW+ZbYwCTRcTzpJFl3jYEcNo/lDEZGqYOg?=
 =?us-ascii?Q?AI3s78o+Mw8GPmmTRvcIbTtEAE4eMx7VBw0rw69aRAEVXEEoF2C5eSH41uUG?=
 =?us-ascii?Q?RSz75NQlYkv+1JbiVeeTncNkFBjuxS2SQvD2Wz2HUDdh36qwAro1HKLO9eHR?=
 =?us-ascii?Q?SJMczpfaBaCw9PCyeibvKShJUC1FTqzQwKLRwPjz/WkDMu/aPY7Q45UbCUI4?=
 =?us-ascii?Q?B8uQPRpdeQPTov/GQzwOMHivOw5/XF1goeb+gQ00dPPZosDPJr2Yh8Sg5vyX?=
 =?us-ascii?Q?i65gcBgg1Wih4Td/pr+uJjX4zoAlxfI5uRMelkZBJn+RIoGZg+RhSk9UEXcV?=
 =?us-ascii?Q?AiAqVhlpz8W90GYyZ/wnkGQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zrf3fj+jwMdYTD1zn3Sa01atbZhuql5Q1PvWQ669WjFPv1JhlTyFlseQJsYwU1qK8jmP9+l1hLP/kFxm0TXqNKZ7svUt7qifHLjBbBezJbpv90TB/XYU+pb40+W6zmmgv6YAoDYx7M5/0TYI9TsKeRt+SzyyDEpBFh7yoXMBB9dK6jf/Xmmf51hcbSaJf6YJvPOJf1CXcnLlYx+DZ1qrOQMlvWJ5y7MFEb6ABroNIaQ+iInRH4voVdEhaAgDVULxMm3oi6sG+Uvg3l3RNqU9SGynizzBm6fU3eXJTNib796sLOCpIdTK5n4trUrCoXdcG2f636ghtDIXHivUgC1PIrUZf92RU3lkYE0nGlCA3zCqrAP6FLrl4rj7HJPePeFhJIYukBV114fEC3U+9viZV12N+uiCUKFT7t/8q14L8KxVP/Cf2LOhNA18yMMwGf6vP5iInp+HtypjfUtmBqMFL/h7LB528HFMzMBapUJ2Hs0b8ZTmBlP0pJfSYAOpmkQdwhjYvXtxk1IPSxOU5mct5JKnqa8jdo94/2Q/n7NekO9k6+cY31fzU1QaMyyH3ycd6nKqmaJcsicFZ/bDIEZqfCGPsfWS+iBwsHLsM1OwNE4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a4f7b8-cc9c-479e-3122-08dc83e552b5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4373.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 15:53:34.0260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: or41yzeQwUa+6X5FMwXc3CkR/W4XkZvOidxPnDfsaplDl7Xoei0jxhozozDzCgSKONXW/PclRO0YjsRIxgoSa+zG8svSoJf05GAamCdPAYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406030132
X-Proofpoint-GUID: 2CD0GQ65WzPQR8bhHh_E8wDwpZtOj-YI
X-Proofpoint-ORIG-GUID: 2CD0GQ65WzPQR8bhHh_E8wDwpZtOj-YI

This patch changes a few tests to make use of regular expressions such
that the test validation would allow to properly verify the tests when
compiled with GCC.

signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: jose.marchesi@oracle.com
Cc: david.faust@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 tools/testing/selftests/bpf/progs/dynptr_fail.c          | 6 +++---
 tools/testing/selftests/bpf/progs/exceptions_assert.c    | 8 ++++----
 tools/testing/selftests/bpf/progs/rbtree_fail.c          | 8 ++++----
 tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c | 4 ++--
 tools/testing/selftests/bpf/progs/verifier_sock.c        | 4 ++--
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 66a60bfb5867..64cc9d936a13 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -964,7 +964,7 @@ int dynptr_invalidate_slice_reinit(void *ctx)
  * mem_or_null pointers.
  */
 SEC("?raw_tp")
-__failure __msg("R1 type=scalar expected=percpu_ptr_")
+__failure __regex("R[0-9]+ type=scalar expected=percpu_ptr_")
 int dynptr_invalidate_slice_or_null(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -982,7 +982,7 @@ int dynptr_invalidate_slice_or_null(void *ctx)
 
 /* Destruction of dynptr should also any slices obtained from it */
 SEC("?raw_tp")
-__failure __msg("R7 invalid mem access 'scalar'")
+__failure __regex("R[0-9]+ invalid mem access 'scalar'")
 int dynptr_invalidate_slice_failure(void *ctx)
 {
 	struct bpf_dynptr ptr1;
@@ -1069,7 +1069,7 @@ int dynptr_read_into_slot(void *ctx)
 
 /* bpf_dynptr_slice()s are read-only and cannot be written to */
 SEC("?tc")
-__failure __msg("R0 cannot write into rdonly_mem")
+__failure __regex("R[0-9]+ cannot write into rdonly_mem")
 int skb_invalid_slice_write(struct __sk_buff *skb)
 {
 	struct bpf_dynptr ptr;
diff --git a/tools/testing/selftests/bpf/progs/exceptions_assert.c b/tools/testing/selftests/bpf/progs/exceptions_assert.c
index 5e0a1ca96d4e..deb67d198caf 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_assert.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_assert.c
@@ -59,7 +59,7 @@ check_assert(s64, >=, ge_neg, INT_MIN);
 
 SEC("?tc")
 __log_level(2) __failure
-__msg(": R0=0 R1=ctx() R2=scalar(smin=0xffffffff80000002,smax=smax32=0x7ffffffd,smin32=0x80000002) R10=fp0")
+__regex(": R0=[^ ]+ R1=ctx() R2=scalar(smin=0xffffffff80000002,smax=smax32=0x7ffffffd,smin32=0x80000002) R10=fp0")
 int check_assert_range_s64(struct __sk_buff *ctx)
 {
 	struct bpf_sock *sk = ctx->sk;
@@ -75,7 +75,7 @@ int check_assert_range_s64(struct __sk_buff *ctx)
 
 SEC("?tc")
 __log_level(2) __failure
-__msg(": R1=ctx() R2=scalar(smin=umin=smin32=umin32=4096,smax=umax=smax32=umax32=8192,var_off=(0x0; 0x3fff))")
+__regex("R[0-9]=scalar(smin=umin=smin32=umin32=4096,smax=umax=smax32=umax32=8192,var_off=(0x0; 0x3fff))")
 int check_assert_range_u64(struct __sk_buff *ctx)
 {
 	u64 num = ctx->len;
@@ -86,7 +86,7 @@ int check_assert_range_u64(struct __sk_buff *ctx)
 
 SEC("?tc")
 __log_level(2) __failure
-__msg(": R0=0 R1=ctx() R2=4096 R10=fp0")
+__regex(": R0=[^ ]+ R1=ctx() R2=4096 R10=fp0")
 int check_assert_single_range_s64(struct __sk_buff *ctx)
 {
 	struct bpf_sock *sk = ctx->sk;
@@ -114,7 +114,7 @@ int check_assert_single_range_u64(struct __sk_buff *ctx)
 
 SEC("?tc")
 __log_level(2) __failure
-__msg(": R1=pkt(off=64,r=64) R2=pkt_end() R6=pkt(r=64) R10=fp0")
+__msg("R1=pkt(off=64,r=64)")
 int check_assert_generic(struct __sk_buff *ctx)
 {
 	u8 *data_end = (void *)(long)ctx->data_end;
diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/testing/selftests/bpf/progs/rbtree_fail.c
index 3fecf1c6dfe5..8399304eca72 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
@@ -29,7 +29,7 @@ static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 }
 
 SEC("?tc")
-__failure __msg("bpf_spin_lock at off=16 must be held for bpf_rb_root")
+__failure __regex("bpf_spin_lock at off=[0-9]+ must be held for bpf_rb_root")
 long rbtree_api_nolock_add(void *ctx)
 {
 	struct node_data *n;
@@ -43,7 +43,7 @@ long rbtree_api_nolock_add(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("bpf_spin_lock at off=16 must be held for bpf_rb_root")
+__failure __regex("bpf_spin_lock at off=[0-9]+ must be held for bpf_rb_root")
 long rbtree_api_nolock_remove(void *ctx)
 {
 	struct node_data *n;
@@ -61,7 +61,7 @@ long rbtree_api_nolock_remove(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("bpf_spin_lock at off=16 must be held for bpf_rb_root")
+__failure __regex("bpf_spin_lock at off=[0-9]+ must be held for bpf_rb_root")
 long rbtree_api_nolock_first(void *ctx)
 {
 	bpf_rbtree_first(&groot);
@@ -105,7 +105,7 @@ long rbtree_api_remove_unadded_node(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("Unreleased reference id=3 alloc_insn=10")
+__failure __regex("Unreleased reference id=3 alloc_insn=[0-9]+")
 long rbtree_api_remove_no_drop(void *ctx)
 {
 	struct bpf_rb_node *res;
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index 1553b9c16aa7..f8d4b7cfcd68 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -32,7 +32,7 @@ static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 }
 
 SEC("?tc")
-__failure __msg("Unreleased reference id=4 alloc_insn=21")
+__failure __regex("Unreleased reference id=4 alloc_insn=[0-9]+")
 long rbtree_refcounted_node_ref_escapes(void *ctx)
 {
 	struct node_acquire *n, *m;
@@ -73,7 +73,7 @@ long refcount_acquire_maybe_null(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("Unreleased reference id=3 alloc_insn=9")
+__failure __regex("Unreleased reference id=3 alloc_insn=[0-9]+")
 long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
 {
 	struct node_acquire *n, *m;
diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index ee76b51005ab..450b57933c79 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -799,7 +799,7 @@ l0_%=:	r0 = *(u32*)(r0 + %[bpf_xdp_sock_queue_id]);	\
 
 SEC("sk_skb")
 __description("bpf_map_lookup_elem(sockmap, &key)")
-__failure __msg("Unreleased reference id=2 alloc_insn=6")
+__failure __regex("Unreleased reference id=2 alloc_insn=[0-9]+")
 __naked void map_lookup_elem_sockmap_key(void)
 {
 	asm volatile ("					\
@@ -819,7 +819,7 @@ __naked void map_lookup_elem_sockmap_key(void)
 
 SEC("sk_skb")
 __description("bpf_map_lookup_elem(sockhash, &key)")
-__failure __msg("Unreleased reference id=2 alloc_insn=6")
+__failure __regex("Unreleased reference id=2 alloc_insn=[0-9]+")
 __naked void map_lookup_elem_sockhash_key(void)
 {
 	asm volatile ("					\
-- 
2.39.2


