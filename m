Return-Path: <bpf+bounces-31498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 510688FE7D2
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 15:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5E411F2576A
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 13:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544A019642B;
	Thu,  6 Jun 2024 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fW9/fZkr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J3vwLDUP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA332A1C2
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680658; cv=fail; b=b7EgPEPlplSloWWW2gWWidpAIDZbZxShiatS9jWejMlhGdNS0s2TS/r0WhfCZGaI7QR6FujUiwf24kYwV+BbfSM7z+ggWqHk9z7pvjvguBJ2Jlkd7DjJXRMiZa3wxOeGR1fGZUFBfcD2gVJYVJuePnR9yWhqx4PCJDUAlqsQR3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680658; c=relaxed/simple;
	bh=vT0dQs8z/chr3LQpmecCDqwZk5Q/wHImGvITPhGq4zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X4NtYi/lviZiyPCv1uzNDzXizZV8Qdj/Cg1wjj0jf2WFHudgGUnfJwrSCdbKxYRo1FCNy5ZdZwA/CByuwk+cJsa22E/5KzptU4977fFgNnJWm3Pn4SXWioHcv0X04ANWCDU5U95LgdL6shjWZVp6fWZgsPNELxPXUVPk35TGwcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fW9/fZkr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J3vwLDUP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456C4hoI017901;
	Thu, 6 Jun 2024 13:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=KqjzhDMEeOyxbEnAuUmVmBJyEga/lgYJn9CprZyNMsE=;
 b=fW9/fZkrxqgDJc+s7CXkkppvcXrIYdd1EHmVdx+xbsISR/f3yCKBC5+2Qi3TFN4zRZwP
 pKYaZvS1m/FQQwaH2GYXGg391siuqJtF4Rnl4MauZ8uQEYNSWvTwbkY39erioAa3D9M3
 MkN1e7m+NiiBtEClXmH2u4lBEbLRsbGQjJbVWO6wHt3i44jWG8QoSIuIZse7hVNb8L2o
 JZOYM1wuMfB4lQ2x55f9abOyXm48KNkX8lhhVAtJ/Dxv+/jIJlkJZtnEMhSX1NjQXIMK
 8Tkmj41HXZHO2A4G+7zcR293QujeLOB3H0VO1OeisWzmdY3Ln+3p39JO9cmWq0paXBLu aQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ykct305k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 13:30:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456CJbNX020581;
	Thu, 6 Jun 2024 13:30:52 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj53xk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 13:30:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYO5VcVPWp7ennuVnuNDOS715mRg5NuJlknX/ko8Ml17FQ0U4wUl+y7f/UMCAmnePJ/3hPe4ELTr0FM3Hh9qntRuVgWL2D6DCSl6pTXiohflt2dR3Jxp0GwW+SbV+agGTUZwVusFs+ITMdzRzSiSRkpZcQOdlWAeMHniOZ4KbjhvBiwxPvDWCiGTDMuQf1UIx26EE6p7qLuLKPzuwd6lfwgrI9NimdgpfGJshlFbFE4FCQqJg4kWVAFwwEFFwaUFFcH5979902oBxqRcDDEzdAXkB/cKkqqq8zcjGk0MxMKQeZDutHE3vE29P/wZLzAwbZzRLJ47pxyP8Bdz14zzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqjzhDMEeOyxbEnAuUmVmBJyEga/lgYJn9CprZyNMsE=;
 b=jCw5T6LMqPpTdsMjzjiEvpElpZyICoaitXOJoHAcsHLhO3lH3HBDyD0DtRBBBMxOMdMv+9omY8H7lf+Pg6Px9mUeL9BgjMnCq8HeipZK8pB6Ee8yvl3uE0Rq8PCrcDFD44W9ufRaxIeQR3mBUa4ZLdKBmzX5u9DFSpQwKFpS9wDkyLdEd334qR2ZhaK8rRKcv3oudUGRGnZSMBRi//EvT0xX0SJYdJiFBcyukeOBBSLCCEQVb2brN7i2a/F9z5KUr0ef5jindAEEyXmGQEB7e3JJlcjAeFDdhd5jflMvfvh3Tx6Ydt2pbwfMLHZohPVjxahmSghXTCzGp5ktnlJyEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqjzhDMEeOyxbEnAuUmVmBJyEga/lgYJn9CprZyNMsE=;
 b=J3vwLDUP0gsdSbj6n3z+OxmXyN7XpyWnbfFkc/nFHG00mbAf+o3n5NUvGwSLSv/UvGP5ODvntSJvBg+AkQy/yGoZy/MN0/KWBa7Imo7/S9okMJ6gfRa42EVkY6XhL5SPNmIhqzWC23ihQsNl39td/gSlVcjejlWNBExDMtfPc0o=
Received: from BY5PR10MB4371.namprd10.prod.outlook.com (2603:10b6:a03:210::10)
 by CY8PR10MB6468.namprd10.prod.outlook.com (2603:10b6:930:60::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 6 Jun
 2024 13:30:49 +0000
Received: from BY5PR10MB4371.namprd10.prod.outlook.com
 ([fe80::d2e6:4de0:fdd1:fb2c]) by BY5PR10MB4371.namprd10.prod.outlook.com
 ([fe80::d2e6:4de0:fdd1:fb2c%7]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 13:30:49 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>, jose.marchesi@oracle.com,
        david.faust@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: Support checks against a regular expression.
Date: Thu,  6 Jun 2024 14:30:31 +0100
Message-Id: <20240606133032.265403-2-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240606133032.265403-1-cupertino.miranda@oracle.com>
References: <20240606133032.265403-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::12) To BY5PR10MB4371.namprd10.prod.outlook.com
 (2603:10b6:a03:210::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4371:EE_|CY8PR10MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 051e5d8f-149e-46b7-b7b2-08dc862ce115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/xJDoCRf5ItUzf4Bvl3+5mM9zSy0RBs516RUflcD28q3WNnvXAnjG0iaHHXj?=
 =?us-ascii?Q?sJ/bNswiRw3dQzQE/Sp8G3T+IdtoDoystq2leyHy4apJK1haJkJehmwzySiz?=
 =?us-ascii?Q?5+Sr9fCgDTwhcgukSZUM/uPvuOy8n5GcPru7VVcwtRqAt0vuQGl/8TU5X3rM?=
 =?us-ascii?Q?/O1e09dYNjNyPaHiU8mv77PN2QJr4b1l5ID++5TuIzScsZ88AP8dqo0cs27f?=
 =?us-ascii?Q?pmNOLfyz41bugPC3Ozrm1egAvFcIS3mp9FmY4I1zRe0I27gQDwST/PsD3GVH?=
 =?us-ascii?Q?gab8pocCy33jfnjlKxh/eBWZG5N1uxQ7vusIK0DnUAnJmmjaqtpWgQbPxL7S?=
 =?us-ascii?Q?d9N7mgAHpdVNysBLrAf4ixqDFDNEo9VfOp+ylIjJ53ARBjCTD71R70uLAFPD?=
 =?us-ascii?Q?qAq2tFW8T+g288c7fr+mTlSH/1R40Nh83Hlmo8ElYxdQe6g3N6FwKBVs4WCP?=
 =?us-ascii?Q?S41Yv6aJZVr6z6WJbWFOmMFuIumudtdiE/ekmd9q46HusG5XsENGQWknsCZn?=
 =?us-ascii?Q?UWnhlDgOP0quyMt7Ko7euNDwHpzTT7roBfHNkRPLA0i427FTKAJf++Z9Z0pS?=
 =?us-ascii?Q?4ATJN5FjJ2z0eApTpfH94hC3qDWvLQg/XyVJkWjncBHbKp8y4oMk+dx3D/ly?=
 =?us-ascii?Q?Pwg/LZ6HvL5h4VdFk9PKwe2yW4NrVwxolFVMQEF4X+ttfAvarF3VOpvzzK5T?=
 =?us-ascii?Q?n/p8WFXxZKyViFUhY/cuehyTMLlwkX3oukeLMvdcgDKl5zkW6NGXgYi9Md1W?=
 =?us-ascii?Q?FoWgMMouDOrd7j82ofJMKVZcBoGwyXgltmeLG88FJzFtr5Iay4VNvyULSBRZ?=
 =?us-ascii?Q?ZrZkknLdrQxp5jyKZbXs4TOmRH41O5hM6jSfFhEbi8mZNK9n4K2QjZSgAbuO?=
 =?us-ascii?Q?KN+dTzdRMejcGgqmVj9AdzkSQRyX1zS+4YmGsHnj8VBCJyOahvoJvTN3GJI9?=
 =?us-ascii?Q?7i5hyNu1C8fMGL8RpdWSoP78HO6LQ1ZVxmTMZTXio8kU49HtSISCF3Fnnhcd?=
 =?us-ascii?Q?WOZUR7f+6ATKanjtLARZ1bmfHX+iYstB3mADRtHL4T7DoUAXgeQpREYOZqNx?=
 =?us-ascii?Q?GCxNAuDPhFn9pOqRXqyFeiF/oQ0vHd3Tj4SLiUA9rcbX6QG7m9FkN6s556ri?=
 =?us-ascii?Q?12mY6aqgfPjiZRs+H34CQwit8RjjWWasUlzAkO+LQle+4RTN4M0SYOu2DvE0?=
 =?us-ascii?Q?/ln/+P+MjR6yI9bpi/DSlhmvEPSftJBpR3zHzmd2Id9BguvX3DSJxpCmPLWp?=
 =?us-ascii?Q?jcwOQnolHaotRXg+k27lo8UGNemGQVx0PPIRp226pk02PylqVuz8hRjGvX3x?=
 =?us-ascii?Q?22LL61+C8dml0v7y/KTPOwJu?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4371.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?N08+8EF/BAMnYDf0Hsx9gSlUZgGHIy8etLRS1GAtlJ+taC2CRr36Uy1h0HU1?=
 =?us-ascii?Q?8uWbtWvoNqMI9qdNRLf3E5i57ZTq9xhU/b5Gw05/s26AFeiKHH2+J1Wa3RaW?=
 =?us-ascii?Q?5uhur5MZU2dScmMkXZa4RY7TbZI8hfOWdcrqIeWEjTcgd9iPq9Vfst+qC3vn?=
 =?us-ascii?Q?g3RsdjnkcsBdepr48E4nPbrKnnAoFGvMwVWjDq35YoHAiTKTQDKbyEY8/D6B?=
 =?us-ascii?Q?SfizgKAAHtA0S9BLET9OmWJGEOa/O3vFtxq5wONHQqeoY03ixs/RAyGXU47f?=
 =?us-ascii?Q?2R5KKXwNVBK0zF0oJ2sxOr4Zr/DL7lcBYUTX+jT5q1ucS+dwaoe00fxLg46a?=
 =?us-ascii?Q?DFmGLV6BLQPY6V6fHzcdjVqukuvLLnnIOU2GqB0vf6MFjYkpKS37x0krsSej?=
 =?us-ascii?Q?DiHXfzQcYljg0GicJUSnVEvOxllFEk93EDz7TjRsXk6w24NZTJ+dMsx4LmvG?=
 =?us-ascii?Q?inYLMGrW8Fve0YbErTiHvaBdtbFmP3BCsU4xOFO6recgESC/leBml8jvameC?=
 =?us-ascii?Q?MTjc6B2dAyjCNNm5irryfthQs7Rsug/gRgHLHmym9XT03YVsJDoKsnxZ4L8i?=
 =?us-ascii?Q?+Qf0P0Fswb6IZPZrCbxknpUTZbbLRyFFfkVYx5/P9IYekoc3nCm8TU5j17VU?=
 =?us-ascii?Q?cJFzO14AbZI1CdZVhqnQd/4J5D+a+7R1AvwQmdHs0YNieVG93pExgJgym2se?=
 =?us-ascii?Q?VeAHMENuQGa1NFzQmudoHyzYPo7Kc9kMKvz0R96G/1Ap74Ka6k0Hib877uc5?=
 =?us-ascii?Q?i6It1+Iq2KCXbcbSMJJa4Mt+72vjJHH92XFAf4iuuLfCa3XWYAfgOaM64UBU?=
 =?us-ascii?Q?6C3ZuzikVTeKY4N0KsLmo2j1aKw7/aSUPd9SEMpPqG1i2bizcMuHhCBbASOn?=
 =?us-ascii?Q?zTkW7P+jtktxLH/kGrEswoFIaDh4exvTDU8F24kbvopNmZds/w/ArFaaC/hu?=
 =?us-ascii?Q?7v9LBelWz7SdivYOgQ3GPmIDDd2by1hckqr0to+mpwdZ9l1j3pqlbThBeUh0?=
 =?us-ascii?Q?m5FpWLtKzM8QyQ/fSlSf6EIz5NDoHWKfwTss37OjjJuzO+xZZORtOtzOI/CC?=
 =?us-ascii?Q?2Oh6DkuOHScmSGHLvd0WO4WFvgonlvqFm749hg7i3gnpQPHtjazYlYDF/jt4?=
 =?us-ascii?Q?avmzUAmhkUqiDaIKx5bcGpo0pJl15v4LxqMUA7lwcj4G4IZfh02AB/wdvEYe?=
 =?us-ascii?Q?PlTq1md7NT4Dv3eFoC3cUbmfceYTe+oyAV0A0U+QwXFPoU1AOf4OESVQ83zO?=
 =?us-ascii?Q?y66iAcqJc1gOg2lSNiFjqyqQyzkkx3YEo+3d+AGAcSUeHOis7mh7L41nBjF3?=
 =?us-ascii?Q?uUp2ZGgenfbfPO/cD4l0CXFBsEeGZfjaLxuVIdvbR+1wr7ITrsAI5Uk5ipQA?=
 =?us-ascii?Q?9hGW/pTbYTFr0PRRGs40Y5QSI93Y+hfTpHRRJivd4cd7uyLTl6m/ifhWDzTr?=
 =?us-ascii?Q?BDI09LxNLQ1Szr+usKlKJJjpw8Bi7pJ9S9tF+1fUmrSMKwIxgd2Y3MPTnaWr?=
 =?us-ascii?Q?yxxC0Lfn9wtl4cc7/L/GiFf19qLEOu6PtiUKAcRc3fkxrUtHCtORNXHJd8gf?=
 =?us-ascii?Q?+5cT8U8t5gWTJRCNrkM/8nX2hDU0dX6+0K3uJHgNUAWuwYvCndpxrn4RwXZn?=
 =?us-ascii?Q?vGbP6A8kpllKyM09qzm7pyU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5S8rk89V6OLLMQMavaEge5BtNVLfWmnbZ+VBUIm9VbQXjM89dg/sWPLp4G1mN/6vJvwnd9U3PyZ03McNf7AKieGyii9fYjmY/uqSaFTLBogRm2Qlmo6YT5RYZUYrwpDORLMVhF3LMLwZ3hZih9kJpXvmu9MLRakvIFFnXCjoO59ZZOYI1j+VW7u1kVq2skm5OYy4fuUqPKzlbPCgQSF55gUQPprMWSPewo+F4CYBg5Dg7oYdXvQy9jJQz7smaN0FvM0nRufmUf5dKuusqBX68QMnljwHMZqxoVYjEOxZppLSN9VyA80WHNzWxH+Ty1eRPY6GmfBPnuylNeTl6MtV1g1Fv1Em2qIg98BLtKjB2L+NTd5zQCzfMueB1oxoUI9XILgadPZnvM7j3hDVWthqgyLtrjolIBtoG6q2V2SbR6ZNuEJaNF4dHaAybkdOABjfhDxu/6DM4qBKUWxEwEdKkuea3NNnCDEbJjRNOoFaisWIHApoDJK4rgWE5/S6G+lVqrP+DaRNjNacF6nOItlgsHoziGRhoDnTsAKZjfue22pBJk6QPGsNT5SSdYAVbyAugpIVS6qI6mYBMFMF3AHK5WqPmJFx6/maJBgxqNWweTg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051e5d8f-149e-46b7-b7b2-08dc862ce115
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4371.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 13:30:49.5200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvxmmNxiFrHNb8+rxxUfafay2LI09uzqEGBjiW5AiWmegKyTXv2/Ul6/Hst3pKAUN/s91g5Vc1MMnDbqYD8uKvt0GOpZqIP9WNHIiZEhDx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6468
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060097
X-Proofpoint-GUID: MYpwc6q9t6R-tTVwGU5uapQgrHuFpt6_
X-Proofpoint-ORIG-GUID: MYpwc6q9t6R-tTVwGU5uapQgrHuFpt6_

Add support for __regex and __regex_unpriv macros to check the test
execution output against a regular expression. This is similar to __msg
and __msg_unpriv, however those expect full text matching.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: jose.marchesi@oracle.com
Cc: david.faust@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  11 +-
 tools/testing/selftests/bpf/test_loader.c    | 143 +++++++++++++++----
 2 files changed, 121 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index fb2f5513e29e..c0280bd2f340 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -7,9 +7,9 @@
  *
  * The test_loader sequentially loads each program in a skeleton.
  * Programs could be loaded in privileged and unprivileged modes.
- * - __success, __failure, __msg imply privileged mode;
- * - __success_unpriv, __failure_unpriv, __msg_unpriv imply
- *   unprivileged mode.
+ * - __success, __failure, __msg, __regex imply privileged mode;
+ * - __success_unpriv, __failure_unpriv, __msg_unpriv, __regex_unpriv
+ *   imply unprivileged mode.
  * If combination of privileged and unprivileged attributes is present
  * both modes are used. If none are present privileged mode is implied.
  *
@@ -24,6 +24,9 @@
  *                   Multiple __msg attributes could be specified.
  * __msg_unpriv      Same as __msg but for unprivileged mode.
  *
+ * __regex           Same as __msg, but using a regular expression.
+ * __regex_unpriv    Same as __msg_unpriv but using a regular expression.
+ *
  * __success         Expect program load success in privileged mode.
  * __success_unpriv  Expect program load success in unprivileged mode.
  *
@@ -59,10 +62,12 @@
  * __auxiliary_unpriv  Same, but load program in unprivileged mode.
  */
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" msg)))
+#define __regex(regex)		__attribute__((btf_decl_tag("comment:test_expect_regex=" regex)))
 #define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
 #define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
 #define __description(desc)	__attribute__((btf_decl_tag("comment:test_description=" desc)))
 #define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" msg)))
+#define __regex_unpriv(regex)	__attribute__((btf_decl_tag("comment:test_expect_regex_unpriv=" regex)))
 #define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
 #define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 524c38e9cde4..a9a7f5f55855 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
 #include <linux/capability.h>
 #include <stdlib.h>
+#include <regex.h>
 #include <test_progs.h>
 #include <bpf/btf.h>
 
@@ -17,9 +18,11 @@
 #define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
 #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
 #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
+#define TEST_TAG_EXPECT_REGEX_PFX "comment:test_expect_regex="
 #define TEST_TAG_EXPECT_FAILURE_UNPRIV "comment:test_expect_failure_unpriv"
 #define TEST_TAG_EXPECT_SUCCESS_UNPRIV "comment:test_expect_success_unpriv"
 #define TEST_TAG_EXPECT_MSG_PFX_UNPRIV "comment:test_expect_msg_unpriv="
+#define TEST_TAG_EXPECT_REGEX_PFX_UNPRIV "comment:test_expect_regex_unpriv="
 #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
 #define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags="
 #define TEST_TAG_DESCRIPTION_PFX "comment:test_description="
@@ -46,10 +49,26 @@ enum mode {
 	UNPRIV = 2
 };
 
+enum message_type {
+	SUBSTRING = 0,
+	REGEX
+};
+struct expect_msg {
+	union {
+		const char *substring;
+		struct {
+			const char *expr;
+			regex_t regex;
+			bool failed_to_compile;
+		} regex;
+	};
+	enum message_type type;
+};
+
 struct test_subspec {
 	char *name;
 	bool expect_failure;
-	const char **expect_msgs;
+	struct expect_msg *expect_msg;
 	size_t expect_msg_cnt;
 	int retval;
 	bool execute;
@@ -89,28 +108,58 @@ void test_loader_fini(struct test_loader *tester)
 
 static void free_test_spec(struct test_spec *spec)
 {
+	int i;
+
+	/* Delalocate regex from expect_msg array. */
+	for (i = 0; i < spec->priv.expect_msg_cnt; i++)
+		if (spec->priv.expect_msg[i].type == REGEX)
+			regfree(&spec->priv.expect_msg[i].regex.regex);
+
 	free(spec->priv.name);
 	free(spec->unpriv.name);
-	free(spec->priv.expect_msgs);
-	free(spec->unpriv.expect_msgs);
+	free(spec->priv.expect_msg);
+	free(spec->unpriv.expect_msg);
 
 	spec->priv.name = NULL;
 	spec->unpriv.name = NULL;
-	spec->priv.expect_msgs = NULL;
-	spec->unpriv.expect_msgs = NULL;
+	spec->priv.expect_msg = NULL;
+	spec->unpriv.expect_msg = NULL;
 }
 
-static int push_msg(const char *msg, struct test_subspec *subspec)
+static int push_msg(const char *match, enum message_type msg_type, struct test_subspec *subspec)
 {
 	void *tmp;
+	int regcomp_res;
+	char error_msg[100];
+	struct expect_msg *em;
 
-	tmp = realloc(subspec->expect_msgs, (1 + subspec->expect_msg_cnt) * sizeof(void *));
+	tmp = realloc(subspec->expect_msg,
+		      (1 + subspec->expect_msg_cnt) * sizeof(struct expect_msg));
 	if (!tmp) {
 		ASSERT_FAIL("failed to realloc memory for messages\n");
 		return -ENOMEM;
 	}
-	subspec->expect_msgs = tmp;
-	subspec->expect_msgs[subspec->expect_msg_cnt++] = msg;
+	subspec->expect_msg = tmp;
+	em = &subspec->expect_msg[subspec->expect_msg_cnt];
+	subspec->expect_msg_cnt += 1;
+
+	em->type = msg_type;
+	switch (msg_type) {
+	case SUBSTRING:
+		em->substring = match;
+		break;
+	case REGEX:
+		em->regex.expr = match;
+		regcomp_res = regcomp(&em->regex.regex, match, REG_EXTENDED|REG_NEWLINE);
+		if (regcomp_res != 0) {
+			regerror(regcomp_res, &em->regex.regex, error_msg, 100);
+			fprintf(stderr, "Regexp compilation error in '%s': '%s'\n",
+				match, error_msg);
+			ASSERT_FAIL("failed to compile regex\n");
+			return -EINVAL;
+		}
+		break;
+	}
 
 	return 0;
 }
@@ -233,13 +282,25 @@ static int parse_test_spec(struct test_loader *tester,
 			spec->mode_mask |= UNPRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
-			err = push_msg(msg, &spec->priv);
+			err = push_msg(msg, SUBSTRING, &spec->priv);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX_UNPRIV) - 1;
-			err = push_msg(msg, &spec->unpriv);
+			err = push_msg(msg, SUBSTRING, &spec->unpriv);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= UNPRIV;
+		} else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX)) {
+			msg = s + sizeof(TEST_TAG_EXPECT_REGEX_PFX) - 1;
+			err = push_msg(msg, REGEX, &spec->priv);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= PRIV;
+		} else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX_UNPRIV)) {
+			msg = s + sizeof(TEST_TAG_EXPECT_REGEX_PFX_UNPRIV) - 1;
+			err = push_msg(msg, REGEX, &spec->unpriv);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
@@ -336,16 +397,16 @@ static int parse_test_spec(struct test_loader *tester,
 			spec->unpriv.execute = spec->priv.execute;
 		}
 
-		if (!spec->unpriv.expect_msgs) {
-			size_t sz = spec->priv.expect_msg_cnt * sizeof(void *);
+		if (!spec->unpriv.expect_msg) {
+			size_t sz = spec->priv.expect_msg_cnt * sizeof(struct expect_msg);
 
-			spec->unpriv.expect_msgs = malloc(sz);
-			if (!spec->unpriv.expect_msgs) {
-				PRINT_FAIL("failed to allocate memory for unpriv.expect_msgs\n");
+			spec->unpriv.expect_msg = malloc(sz);
+			if (!spec->unpriv.expect_msg) {
+				PRINT_FAIL("failed to allocate memory for unpriv.expect\n");
 				err = -ENOMEM;
 				goto cleanup;
 			}
-			memcpy(spec->unpriv.expect_msgs, spec->priv.expect_msgs, sz);
+			memcpy(spec->unpriv.expect_msg, spec->priv.expect_msg, sz);
 			spec->unpriv.expect_msg_cnt = spec->priv.expect_msg_cnt;
 		}
 	}
@@ -402,27 +463,49 @@ static void validate_case(struct test_loader *tester,
 			  struct bpf_program *prog,
 			  int load_err)
 {
-	int i, j;
+	int i, j, reg_error;
+	char *match;
+	regmatch_t reg_match[1];
 
 	for (i = 0; i < subspec->expect_msg_cnt; i++) {
-		char *match;
-		const char *expect_msg;
-
-		expect_msg = subspec->expect_msgs[i];
+		struct expect_msg *em = &subspec->expect_msg[i];
+
+		match = NULL;
+		switch (em->type) {
+		case SUBSTRING:
+			match = strstr(tester->log_buf + tester->next_match_pos, em->substring);
+			tester->next_match_pos = match - tester->log_buf + strlen(em->substring);
+			break;
+		case REGEX:
+			reg_error = regexec(&em->regex.regex,
+					    tester->log_buf + tester->next_match_pos,
+					    1, reg_match, 0);
+			if (reg_error == 0)
+				match = tester->log_buf + tester->next_match_pos + reg_match[0].rm_so;
+			tester->next_match_pos += reg_match[0].rm_eo;
+			break;
+		}
 
-		match = strstr(tester->log_buf + tester->next_match_pos, expect_msg);
 		if (!ASSERT_OK_PTR(match, "expect_msg")) {
-			/* if we are in verbose mode, we've already emitted log */
 			if (env.verbosity == VERBOSE_NONE)
 				emit_verifier_log(tester->log_buf, true /*force*/);
-			for (j = 0; j < i; j++)
-				fprintf(stderr,
-					"MATCHED  MSG: '%s'\n", subspec->expect_msgs[j]);
-			fprintf(stderr, "EXPECTED MSG: '%s'\n", expect_msg);
+			for (j = 0; j <= i; j++) {
+				const char *header = (j < i) ? "MATCHED" : "EXPECTED";
+				struct expect_msg *tmp = &subspec->expect_msg[j];
+
+				switch (tmp->type) {
+				case SUBSTRING:
+					fprintf(stderr,
+						"%s  MSG: '%s'\n", header, tmp->substring);
+					break;
+				case REGEX:
+					fprintf(stderr,
+						"%s  REGEX: '%s'\n", header, tmp->regex.expr);
+					break;
+				}
+			}
 			return;
 		}
-
-		tester->next_match_pos = match - tester->log_buf + strlen(expect_msg);
 	}
 }
 
-- 
2.39.2


