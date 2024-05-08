Return-Path: <bpf+bounces-29116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76AE8C0522
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 21:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3404D1F2240E
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 19:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09F73F9C3;
	Wed,  8 May 2024 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UxAT1dWb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cXfThYj3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AF21A2C30
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196940; cv=fail; b=KgLMbzCrszHirId/KMtOXfDfsd65ouiPj2X4yscGKAj5es2gBzsrVFNrPsR/N4XaRF0Bqax4EB6NHxKC/7MIj5WY8xxy60C17Th8fc67Nhkuxjf1xubusnxCL+dpiWgRX9qN+F4QGp9+JF2l5oobZnyLLBdslaFFK7iLDwYkDXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196940; c=relaxed/simple;
	bh=22XZkoLroeS6vH7xFeaMiUa69XTR+lDRps1cy4e3pxg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AKDH83JT9e0QoMYBe1sSdSXhBLBgQWamQiZpOoDJNd+7yo27WfPrBSqbjTUrCdjMlwMskkiFjR2DdGbBhVuPxfQgKT8TFkGdLBcnp2lm69hBGvOG5vSsVPyfEBL1oQh0VD45UVxc67WR5QGX/Xi54bFWTRAAuGXsG69t/3la8Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UxAT1dWb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cXfThYj3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 448JXf5x027935;
	Wed, 8 May 2024 19:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=9nI+/a8bi/Outt73pa0fN+mC9tk+t6pPWOqAPqiBnGY=;
 b=UxAT1dWbH4cLE/UM7ycwoc9BCflu+300sBUSl/arhbFPGZld41oL1KRml5uvcjrs4BIY
 Bb1jKcTYQgAArMIXtSdiYI7sgqoSHjXz97WAjqQnfJUMAWMcx2MTLqcY5ki4DN/ZXrNp
 d4GaiTiAQ39EBm0JjdKq3kbghHPCVCDFu4BcG6fdw8dADLMxV3fkT4zIq2TKO7NwomjO
 EGuXavsePtcDbbYGQYwZm8FWhDM8NDSToYCAh9awY0R8hMeJabM3DTNLetEy3LWdYL/8
 JSbJ14BCn8Eq+6TeUJIg14bH7P0V1N73XazXHWng3EwByQxpAl7+SAx3k+gBjr/hwuqo 9Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfv2m8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 19:35:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 448JMYSU031111;
	Wed, 8 May 2024 19:35:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfmgc5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 19:35:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alnTno5JUn+qvQX3un0qBp8eqOTFIP1tGNgoYF5JFWWra0szJtPYJW9zcd1qbu8s6G0Sda6DlIzgDgpo/od1exgPok+iFUbYj3N4ASI4y7kdWMtBtC8FJgAySZUZ8l2b8V8Rh7eKBy8wMnmYsqmxX7dxLhGSXhPoosOiIc+hDx6eeISg7VSuRkMack0H+5waEhsPkpBdNwfEm6qP2ku4NDxVw7G4r61PqJ6tRzgEb2g+PLjNjGeyBGocvDxmPvvlk6rQC2Ewqi/VbgfGq4S8T0qGEygoZ1WYYxMKDNM/+0Q2g8djkz2jfdT0UpVxXeTNPsgLgn5FIDow5Al+/8UF1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nI+/a8bi/Outt73pa0fN+mC9tk+t6pPWOqAPqiBnGY=;
 b=Jlx2HJn42dWaDqCALwB8ZwdOUn6w8TN05u8CGxON+gKndb+mLHUgoL6RSkeqbyMOTn78pSSZky9IgylGI7lb9eCGeSLQyFq9rM2DoRMzAS4ZHigptg5UUq94NCUV6sHPAonFkN9L/1tcpWj0Z1OytVoQATvvx7JNvwdE7eBMqsuWb7A75UsR6PvTqX4u+2VMiZWjQ5kf8Uc1Gi2vE1ezhUBQG5fjYhaAXGwaCUcW0mWcySOM2/cbxWMftewzb82DipOhmFgru7dbkQ5agIGCiw8LDnlot3wzLHFzwFEDl+ACL416tLJby+zWeUeYRiFVEa2/OLugAAQ+yp3QkwHDPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nI+/a8bi/Outt73pa0fN+mC9tk+t6pPWOqAPqiBnGY=;
 b=cXfThYj3RX36Di1sqbupMLEH4wWyxhn05Fo/HzHylPR+hRrpNJNLVZHoD+Qx1nHKDeSOXbLd9Ht0qi3Alq1SC6TDw+vST/GM7vXh2KoSExE1a2bVaTr2xkqDQABNCN1i5qrizlUmf94aOkISd9gcgxCcKzZzG5RjXFkV4ccgAbA=
Received: from DS0PR10MB7953.namprd10.prod.outlook.com (2603:10b6:8:1a1::22)
 by CH3PR10MB6714.namprd10.prod.outlook.com (2603:10b6:610:142::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 19:35:25 +0000
Received: from DS0PR10MB7953.namprd10.prod.outlook.com
 ([fe80::ddec:934d:1117:499d]) by DS0PR10MB7953.namprd10.prod.outlook.com
 ([fe80::ddec:934d:1117:499d%3]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 19:35:25 +0000
From: David Faust <david.faust@oracle.com>
To: bpf@vger.kernel.org
Cc: jose.marchesi@oracle.com, cupertino.miranda@oracle.com, eddyz87@gmail.com,
        yonghong.song@linux.dev
Subject: [PATCH bpf-next] bpf: avoid gcc overflow warning in test_xdp_vlan.c
Date: Wed,  8 May 2024 12:35:12 -0700
Message-ID: <20240508193512.152759-1-david.faust@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:303:b4::35) To DS0PR10MB7953.namprd10.prod.outlook.com
 (2603:10b6:8:1a1::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7953:EE_|CH3PR10MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: 8843a117-a53d-406c-c8fc-08dc6f9601d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?f3ZaT1ss91cxe0Ns7QncVPkpnRw0P9JKriwmP05DbkAwaUyWIDlaiHZ+yjcV?=
 =?us-ascii?Q?tqZ35U3zCBRtSkImbj1F1gNtV/yN/CcTj6MKsBl9hTbM7Gy4PjZalzJyyop4?=
 =?us-ascii?Q?uGqyPBb9+ER03FZOE/wGgdHICKdcTurBcrNlihzDI0lZ4ykPH4I4a894rLM+?=
 =?us-ascii?Q?P+gE35JP6Lq2OJf267/UpgvyDZhYhVnHHhktZ19ibbcjZyG3yvl2En/AT+4T?=
 =?us-ascii?Q?tzQpY5/jM36OIfOUjnR4D2MBhjFOVy3EAKNaQxel436kQM4XvCBO63+YGtp5?=
 =?us-ascii?Q?GVxCOV4DQxtvm65vSgAvBAk/OVlpTYfjG+flt6cfGfPk2HvI7AC+NVR1o/fy?=
 =?us-ascii?Q?ruN0jPuHz9qOEnpiFBLBl9VD1+VxbwWKyW6anTgLytcp7fzGjXxpTA6N3FDc?=
 =?us-ascii?Q?4gBG+KLtT3NKNObq7aB/lafQ79o/vbS93P/LVVDR7+J0vYCCWZsG8NpepC9m?=
 =?us-ascii?Q?U/dLBl9qJMB8NfbFqQ4l5jJsdfBNNdCcEfGQQcA4FJJ686tjSZSj5aFrNdyt?=
 =?us-ascii?Q?II5DT2NAIj9USzfX8IZF76NUwUzNuf/neV4tlSMw3FYETI+qtW6TPSSDulLu?=
 =?us-ascii?Q?FDwK82FXkrUJkG0Gq820upS/BdlT6Ou2YBHsHZTFbcQ+Q3itlDet3VPMgjdS?=
 =?us-ascii?Q?pzIybyRWzFNCw8dKbC6U9dIPIYLc7J+Qay/vcrvEQmwtkOam3SKw33LWm2sH?=
 =?us-ascii?Q?6NenKy4Bt9tgLQISg1ObJKlYU28ok575UHNDlBPJL7CXnhhLkrdgWVelcQIL?=
 =?us-ascii?Q?2+Lh6nurWbZCgAuG4JS5bsecJS5HEi6PZk6+V7uMJ+46zxKCcT2xlzpnjIx/?=
 =?us-ascii?Q?R4PkUDHEPyQHe39bqJlIz4rCz9KVkX/S60AtadzA8bJ7xQT9NTbQq+RnKWcq?=
 =?us-ascii?Q?1YKkOBEw+Q62/KOSL2Mc3lxp5DH3EGHiJ1ErimvL6q0WYGq6mK9A19aaB8MV?=
 =?us-ascii?Q?AdAk4LkOf5JmWPXPZMJOJFYrTaL9rVSIlmq2vLRiKrTPJ6LG3ZSQgkrT6uOJ?=
 =?us-ascii?Q?pLtQ/MvScMrlYdMIvblrAtoLB2QmTnsVE8gjpF6yxczS1IeVuErmxGEVGjqF?=
 =?us-ascii?Q?3YAI8T6Q1Dv63AnrKAojCGMU4UfFFEqnPhpz+eVN1t1tNs0EfxgkuJ9DSNaA?=
 =?us-ascii?Q?T0+9E3RKOIERjtWrrPjQdhGzSEHM0+4NDvT0DAdzHu4EKh46gysMZQfvxp+k?=
 =?us-ascii?Q?d1OWgsnMKYtr6tmCOVSGDcJw266UkwgwwZ1OokZ3RME1guEZaYPXAIkIm1Y1?=
 =?us-ascii?Q?fo+zg0q4I9OSRExR0WyW379mTuhwsI7s0+OhBpcFlg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7953.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cuOIMNlkxoJpH46zslzAZLK4PaQc7r3bgkFB7fiz7Szz5rFq1zwzRmwtv8rP?=
 =?us-ascii?Q?E2i1OZys5XL8VCUdNTmET5kCz5J3OvM+i5SWHG3Lev5Hc8DlERBQlckQj39Z?=
 =?us-ascii?Q?ODh4+lQnax8AVieOTAztGMIPCBvojvOsDrIgRVuxxrWqEC/t3uYlbs5SnRHF?=
 =?us-ascii?Q?3fQzdKgniy4WkWlPOhMkoUeEtxT/SlJWwm4c1TW1Rn81ZKCe3OyJZdjhMK2z?=
 =?us-ascii?Q?osARX9gh2dF6bDTixj4Pw6TiUZd/30azYMv/JYYL2rB5mXda6QTDBf8Atjuu?=
 =?us-ascii?Q?+uHEPGIq/nbSg70jXxd1/1sKReueCXrs/jHpJ3Z88RFws2/HU++z1fUOalam?=
 =?us-ascii?Q?+t1DyPYX3eH9U+cSo3WuqXAnISU1VonJGUcO88vugt7TMkR4FG/WoMPVfrPW?=
 =?us-ascii?Q?WcRTR7li6Rhrvwj/JIE/c00D72zG4+MyzOOFXZRrkdunNE84ccFPItxgYYAi?=
 =?us-ascii?Q?LDyAVxn8uN1uKOvND24jePJlGYlECqQcka8JVBKo0Lecy5OJpgq21LApJOMr?=
 =?us-ascii?Q?YXTSUFwne/4P/BYFqJ0WwInQV1VF/9Y58BZ4mwya7dXirF1oZkTyYRm8/2aX?=
 =?us-ascii?Q?mgC/KJsOUcwrUdmTfOxW1UypQoJhkw3NzQUK5W7R5ewFEchvvSPgC5SWGwEV?=
 =?us-ascii?Q?XD9fYmmZKuoJrmQY2YuG8Joaz3qO0kXTRTc4UTqYBQ9UkWZ8AauW+xO7mxqc?=
 =?us-ascii?Q?6iEycf/qC8FsQ15Q/EG1Gh5CXB2CA+8j/lI5+wf14DpyqsMpFrL21VxhdsPY?=
 =?us-ascii?Q?nQQVXvkKLwCUWGT5KatXx4EpwXJn6BpxQ+0Q+loX9IgDUl1bw98sMQmpdnAc?=
 =?us-ascii?Q?6hjnQdpMJJBNStnQbFIF9Q5fdpfOQiYFAdYZ0hCYcl+BfG5dTouJ69Ygm2ki?=
 =?us-ascii?Q?csGiHysCS3Vn2Y7WNz0FhTiCMG77QrmpVAPmPPzCEMaD2dfErh5XvRc0UOZU?=
 =?us-ascii?Q?8OQ4a8yGV6/83dZ7EbkFLzhLPGs8DQKIpJrhp5BG4XJnVy2XWXw82X/Eh9y+?=
 =?us-ascii?Q?xV5kEn4U47cPb3AntZm7wXg5ir2hAMA/AnB7r8W45lth4f+p1Q5svDCiFK9t?=
 =?us-ascii?Q?RRghwHk2hg9qodVxt6KLy7cCYb/tvP4QIcdg/+Lw4nDRZhNWbYTRDACeAgE8?=
 =?us-ascii?Q?hJTHP8YLrqVMMuHU89zLW2UCDXtbPtUlsFrUlLZaGEwU2Vtv/1013LXYkkEI?=
 =?us-ascii?Q?flXSetTxDlTO7OkiW7OpCMcwD+oZfUtgbpmJlX+LfOuTSzm0ppD6rI4eia+T?=
 =?us-ascii?Q?WPg8RGM1oNevqEfS0bkhI2jQxAcZAkEmGSVG90I6Cf1j+okQyEp648Bpa/HI?=
 =?us-ascii?Q?C8hZAr5yLAGBCyqeP8vNzmE8qmEXX4RAFcsSMVF6VwDs62ypi0vFDME3yP47?=
 =?us-ascii?Q?LBryCpJycVWyV9s6na3PhVhPA3uYPwqNdSVdwpPfUfP279CLo8zp2DMQxGen?=
 =?us-ascii?Q?pZuRqXQ+f61NmJPGL6L6AMGZJjRs6SA47iV0tVQXpXsAjhUmmAI2vCp3Icfj?=
 =?us-ascii?Q?Lr2iR9Sc4BI8Hbp0x4eeTZdyFVkAn2ZbCwSpvs7riEj1iK76+Dad448qkecD?=
 =?us-ascii?Q?7D8+B9+3AjIiwSjtFg+WabEWD0t1tF4T5QIls4z64YrY0kaDk8zHmWQI+N23?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3QRiSL6KqxC5ZNy5p7+fGO9u/6MkQ7C9Tk8cTNEBVzpI16t8ITPkFiw1d7FJkRV1LpdVLZMN87RuITBL5RKuQmz5R4jDXBDcrl5k1zTKSPhZ9S6lhOCwl8wpMqwcb/QRt9feD4nC+1FfvAHAoWitBx22zy5GlGDCUw6LP5h/xKcNjOpwbLY9IvDjdRd/pLUdUrQoI+x+eQ5BJbWsgG6pXTO6+Wd7LBoZ2qp0VmFuQd87wQnSyeEk9+Di70sPF0v8iqYNCwfjfX1/vrxV/i8Dly3sj+HVdDaRWOsnQUyqj+zPoXdd7daxyY2cpSjFZQr5XIiNkOJYuByt/25cHxkR7aXgRwwQPdmHFz4buIDqrkLyC5knYfI0ih2isOjk2AIkawxn6ubGv0hOk2Gl+4L/3PlXRWvKy07XAS5aw3EUg7sWPJLm7LglVA8of1hQK1twMrDw1gQ8Pr+MLGPjsBYfLuOOvWDIrFGqFNj5q/HzwqRMJACiyRrUjo0UICmR0B21kCzgMsB7WIIhhj/FwznTgg0qB0LTuYZ/ewypf2cCZAmEwaQ5+4HlOsvZ5uufbUmj3lfTzyjoleMacYME820w6/XRy0VPzwJXrNXoBxv6neI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8843a117-a53d-406c-c8fc-08dc6f9601d5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7953.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 19:35:24.8613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXU6Bn56+AHdu+F6ii845/Ygjzw5BCx3yZSXOF/1SuvBMfBsNhMi1LHgvchXfYetY/wfkmBN9dnx86ddzo7yRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405080143
X-Proofpoint-GUID: XYKHzX5bQt24Oc4u-2Yd8pj7WPvKF0hy
X-Proofpoint-ORIG-GUID: XYKHzX5bQt24Oc4u-2Yd8pj7WPvKF0hy

This patch fixes an integer overflow warning raised by GCC in
xdp_prognum1 of progs/test_xdp_vlan.c:

  GCC-BPF  [test_maps] test_xdp_vlan.bpf.o
progs/test_xdp_vlan.c: In function 'xdp_prognum1':
progs/test_xdp_vlan.c:163:25: error: integer overflow in expression
 '(short int)(((__builtin_constant_p((int)vlan_hdr->h_vlan_TCI)) != 0
   ? (int)(short unsigned int)((short int)((int)vlan_hdr->h_vlan_TCI
   << 8 >> 8) << 8 | (short int)((int)vlan_hdr->h_vlan_TCI << 0 >> 8
   << 0)) & 61440 : (int)__builtin_bswap16(vlan_hdr->h_vlan_TCI)
   & 61440) << 8 >> 8) << 8' of type 'short int' results in '0' [-Werror=overflow]
  163 |                         bpf_htons((bpf_ntohs(vlan_hdr->h_vlan_TCI) & 0xf000)
      |                         ^~~~~~~~~

The problem lies with the expansion of the bpf_htons macro and the
expression passed into it.  The bpf_htons macro (and similarly the
bpf_ntohs macro) expand to a ternary operation using either
__builtin_bswap16 or ___bpf_swab16 to swap the bytes, depending on
whether the expression is constant.

For an expression, with 'value' as a u16, like:

  bpf_htons (value & 0xf000)

The entire (value & 0xf000) is 'x' in the expansion of ___bpf_swab16
and we get as one part of the expanded swab16:

  ((__u16)(value & 0xf000) << 8 >> 8 << 8

This will always evaluate to 0, which is intentional since this
subexpression deals with the byte guaranteed to be 0 by the mask.

However, GCC warns because the precise reason this always evaluates to 0
is an overflow.  Specifically, the plain 0xf000 in the expression is a
signed 32-bit integer, which causes 'value' to also be promoted to a
signed 32-bit integer, and the combination of the 8-bit left shift and
down-cast back to __u16 results in a signed overflow (really a 'warning:
overflow in conversion from int to __u16' which is propegated up through
the rest of the expression leading to the ultimate overflow warning
above), which is a valid warning despite being the intended result of
this code.

Clang does not warn on this case, likely because it performs constant
folding later in the compilation process relative to GCC.  It seems that
by the time clang does constant folding for this expression, the side of
the ternary with this overflow has already been discarded.

Fortunately, this warning is easily silenced by simply making the 0xf000
mask explicitly unsigned.  This has no impact on the result.

Signed-off-by: David Faust <david.faust@oracle.com>
Cc: jose.marchesi@oracle.com
Cc: cupertino.miranda@oracle.com
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/test_xdp_vlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_xdp_vlan.c b/tools/testing/selftests/bpf/progs/test_xdp_vlan.c
index f3ec8086482d..a7588302268d 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_vlan.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_vlan.c
@@ -160,7 +160,7 @@ int  xdp_prognum1(struct xdp_md *ctx)
 
 		/* Modifying VLAN, preserve top 4 bits */
 		vlan_hdr->h_vlan_TCI =
-			bpf_htons((bpf_ntohs(vlan_hdr->h_vlan_TCI) & 0xf000)
+			bpf_htons((bpf_ntohs(vlan_hdr->h_vlan_TCI) & 0xf000U)
 				  | TO_VLAN);
 	}
 
-- 
2.43.0


