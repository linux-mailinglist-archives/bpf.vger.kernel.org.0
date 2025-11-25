Return-Path: <bpf+bounces-75492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A01DDC86C54
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 20:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 842FA4E4422
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 19:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B1C33556C;
	Tue, 25 Nov 2025 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Tq74001c";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="TtTE2H70"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104D4334C1B;
	Tue, 25 Nov 2025 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098338; cv=fail; b=XJKfU1ifBFHD/SPVPOpQtoS2SBtXjjIQIGgydQkIlw4zl2I58flBNNRwrb9ZaDDLz79+eNyxIk/imwcn9OL78ziHIWoBjKRlzgzpx2l8ageQUX5LOCckJ6wUx/CKMwdtI+ayUTbgslZoy1ozpqM902sT8+8KldDBgkei7Zhv7n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098338; c=relaxed/simple;
	bh=+aHizFZIDenk/WUQa2IxN91Zg3xXc2RKZpZV8N4R9OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sk1A45fMb9b4SRr7OIdVvNELQJwizcjrUF8rEyUFSbAak9imU/ojqJfqIkNmxqcdyIqO6ZL+SlHSxGE6ymN9IpWW+x3+UvCBmlEk/TX4cHKkW+uBR4kGCwVR4ZaiWWSUTIy1XIgXL20wdxmpiHbm1HW7n95/SnB5/RhOnRcn5fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Tq74001c; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=TtTE2H70; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APHAaSu4001123;
	Tue, 25 Nov 2025 11:18:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=oPxbb0VPnw0IRQLw+mG6WD0+PAz1qyLAT/LTM+U90
	KI=; b=Tq74001cSv7JER9ZnSrVFhYk1u7FRgGU3rXllPGBjPY5iugn1vSg1Azhx
	QLupYtmWXlL/1We+hcsY3oCTAQHF6kqplXZkAelI3WlCw4ninjfNW/cNm8dedtSC
	26d7rmwRk5hVOoVruL0ncC27i7G9FAYSP2kbbcrj/rDS1LMwaWNFb0CvEVw78PLt
	PX519HE0PSrRwTaAnzoTMe8yx6uxa7rYKUxXDCrRxNGkmUaWrVOnNucEVCDpQLNV
	oF4IbM3Hc8H1hF2KpXlylft9IwdKUk3HUT3gs3gjqxSk3g6zfNS65etyLEOQqCIY
	kADzSBIHfdbpK96FAVReh0fpIUgeg==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022111.outbound.protection.outlook.com [40.107.200.111])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4amvetasx9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:18:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJYVl0DP+r0wTe7cLVbAk9ja6hkgq2fOeTGubx1wovMwFs5yL7wbkT8pOyF+eTKgf5j6HFjaNIVJtSI32fMjVqu7LSKnuOMXt7/GpbcpjApmc/tiEkd3bA6BOtxIVF5vp1fRZYpRmyDm3WSPOgiTNwxF17gJgWGWjHpFJ5HiNaAz3D2wdYaG45BPz+yKHp7+yP37gkoSwbWJ1Phe06/eely/qP0ZDz578BaTLzVVI0UB8VMCZnnWqd8s8l4QWVAEx+OJf1/R2S5HHvCwfemaOa2IYdMH9kmW72gSPBCjPHcZStjwXfjxhdI9gvt1maXslhdPk5/uel9MSMmQj+wIkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPxbb0VPnw0IRQLw+mG6WD0+PAz1qyLAT/LTM+U90KI=;
 b=DMRuiEb4nsy+s5UnXFpkZAGl4t8LFYBGigDkLmK7X1ShlS+PLBTzC0fUfLYfP1vVxrTsFPv8mw6J5kRc7LR849hlrUnDqay4pQ/iJJlaWGf1nErcKlKOinrV4FVEw1AAuppQUmPMtUTwzEcoz+NsbzC83q0sF89y0UW+iGb7WydsJPtSaeueGm31+VzMfVA8jZpDTd6TlU+aeDPIzgya3sTn4lMaGYrGhr4ogRHM8CoRy8FLqsgpTHs5HmMtQBnDvhi1q+EZ6VMSDKQYH4c9cQspUaxedXJujYDASpXFvEQ9WnWPCrB321SgN83D7UTtfIYulpJvR1YRgNNHIS88cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPxbb0VPnw0IRQLw+mG6WD0+PAz1qyLAT/LTM+U90KI=;
 b=TtTE2H70wwLQ3l4BmtP+/mW8tj7AjRrPHNBZP+mA7wl4Sgw8tPWeNWgBCyLgypkNdoP0kCT2t+lOpMpBupoz/5OsyMBtaVRzwRRcWz0PjCBLvSNO1/8nu3d9okj0LopQOosRiwA/LhNNZjjF66XYq4eCjnCBpvB0hqI2BoR+te3lT3dAwXEnAU0HcLDfYfvnqw1gfDmNK48Ix8e/dWWT5Ea/BWuk266TtUcImfW8Zy9xFrN+eA9G3bBzDW1Auc685zIiYwxIcZ1ZE16/zo5ih8uxt6L9W+nSZfFq67ZZ6L+APDOhv8tl9cxv3RKXvaS2JyZKSBkrDgDQIqeYfUgH9A==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by PH0PR02MB7557.namprd02.prod.outlook.com
 (2603:10b6:510:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 19:18:27 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 19:18:27 +0000
From: Jon Kohler <jon@nutanix.com>
To: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        linux-kernel@vger.kernel.org (open list),
        bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH net-next v2 2/9] tun: correct drop statistics in tun_xdp_one
Date: Tue, 25 Nov 2025 13:00:29 -0700
Message-ID: <20251125200041.1565663-3-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125200041.1565663-1-jon@nutanix.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0128.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::15) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|PH0PR02MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3c6443-87d1-4cff-83f3-08de2c57697a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gIhEjemNG6QHq5VTWZnOJAowo2Zcjedp4yVhCd9E73LVUWWSz5exEVyQ1EGn?=
 =?us-ascii?Q?kYzcgX1e7kLAQAS8l3jGjtYxAiOddgR34ftlL2I2buoAZQRLp7IyOeLYVefL?=
 =?us-ascii?Q?vyIsi2hBB3iUT0A4S1df64J50/75K8s1+p4zZmpnd3taz/VkSt9RVVtSkzbk?=
 =?us-ascii?Q?pF9aFpaBl6qGpsKDTI8PHjq3KgmSdG0/h2FJT1eHH+FfaqBinLETBs8h2ihP?=
 =?us-ascii?Q?oU/i0R5TsRrtrXtjeQvY3pfX5KjAaf7xF3Gpc+ndmnf02sMeUiAhcf8eGiQz?=
 =?us-ascii?Q?mikP9EWDFkC/nZxIeYfJtK+1bS4CdY3jOlkSXtCy4KTVBQndyf+myOtzbPNI?=
 =?us-ascii?Q?LDoOgCy5OxvhNIQdx98qCe1t2yfruQcSOaKyPSAQryRYLrvafra2T515TzPh?=
 =?us-ascii?Q?uCdkWA2hV/Gv3nhkLqaIcRtjPEPV9zXbvTRxGq3bx/rYfVBOqT2gey63bKQ4?=
 =?us-ascii?Q?VcVy1NCZhX+GoafFpClvMzVRaZLLlpO8EycnI7OA7EtTJzTF4HpfN3ATYOum?=
 =?us-ascii?Q?0cxVpro+//FjOrqtjxsk1UdwI/na4TWttCZpuZ/VkKFZlQXl2Mery5a7iVAC?=
 =?us-ascii?Q?KTCrmVwQOYKmvdfYX6SdlDNVWxhio3qMhSssNoNfpt77cRmw0ZuKSsKcjh3e?=
 =?us-ascii?Q?++kHxBwAimLwVS422K74rXR6jPf8JhR9E+VcWSdu3tBbNUNERuG2k5t3MDci?=
 =?us-ascii?Q?VNY/m1O+S2+QQniGr28vWgd9jbwRe1BHW4R1El9Lg93k/FpzOpV51uxmTis5?=
 =?us-ascii?Q?9aGYDd/tZzQzliAfMhfWW43zJDTs6mB3caCOjUeiPsK4j86Keo3oMfrs7pwe?=
 =?us-ascii?Q?ESEXP1GfAB4xnoEELXzwKlj0Lrts7r9HMhuF1ho33NfndPknmzKwILraLb5j?=
 =?us-ascii?Q?dAu22d8WPnVOGTSL51ZnE418EjDSPKbvUci7bsXm2DxsZLUOGrqyEHOIUyPg?=
 =?us-ascii?Q?D2StQAitbPCVlNpTcAAMYlblHESjRNqrUf7BP/WNReFEs16blR2CrGmQDKSo?=
 =?us-ascii?Q?LZQRnrWdMIUP3+BlRTkG4nNBpz0ONjl4aS9JYNYLAWajWZdYSci3BZSOyilw?=
 =?us-ascii?Q?P1IDB19ixWs6MLVu1KPTTu3hdn+zq5UxqnxH/m1c1Qc/OnUSO22oOXriwoT5?=
 =?us-ascii?Q?nBGJABOo39h5Gt1ze6TfHTWYHmKYtbtp+a3twbml05Regiefw1yjiWUzpNkA?=
 =?us-ascii?Q?Pazh8oOIWmpP7J6d99qviC720qwb0SoXCuZcYLYb5PzAlyKqIVMgy1gtoQnP?=
 =?us-ascii?Q?kvdt2p2s+ZM+ZQ42nYJU3qEJeSHXkJPz8V2Z8sTl1911rDel+ao5u2FsgYpg?=
 =?us-ascii?Q?nlh0pBczkEMwTMwxZVIs+he0GouzhRysktJ3d7Ktn/mQq3oo1Xnf1Qahjy3+?=
 =?us-ascii?Q?8/nXO1hyJz0SFn7yFdlDdKh3O9j3qLtMfWMqZceUNqsIrqpNmj/O8hW2QX3U?=
 =?us-ascii?Q?gNFfpBv35pVdloBh3UbDVMgj/oxcd+OffWsOniGzM3OuuFcJTedM/HzRkCoM?=
 =?us-ascii?Q?E/9ntTqEkGrA3fAC2urw+Mw8qy38/A71e+k3uvX2220fz4TG27b0x4ezaQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FR1lP7mk54Mr2ROQ0ICilxOkKJgaKrVzmabgyO7uqtB8+q1oOMt/AKPHsg89?=
 =?us-ascii?Q?+uJTY1f8PsYo6Yb/4vVJ20jOwvoQ12VHOE8m8bMxXqCsDE4GAvY/QqwvW3Ns?=
 =?us-ascii?Q?i18mWLtPQOclHTgHis+N9nxPQHfL+ilXO7jFbkTo45m25Y8bUxMIi1NsmAD8?=
 =?us-ascii?Q?V4l3rVfc/Ybfr8fGLSkkIpWYv5jgWcLR9El8pRzmuYSJyB1ksIik/Xon3Ue9?=
 =?us-ascii?Q?oW3JvxZc5GGsTKpVBSZJRpfcR7IWaZEeGduId9Fd6TXY5OmM4GxkK8R8iIE3?=
 =?us-ascii?Q?qv3B5SRDc8iPxVH/yNVhZ45/FdEk6sxJqrhXDS+cEpNHE2nG6u1fIpTMiw7L?=
 =?us-ascii?Q?cSFhJoLshbxq7TDPD/ReCjaNhi0Yx2Ij4DzZsOD1eZbBLursdjMJUePNOEJ0?=
 =?us-ascii?Q?wLpUkNteccVngn1/nNZ8pebreRuKPAC7BJptU5gxFEMFBjxuhkAAn0a1iJSR?=
 =?us-ascii?Q?ZvZ8nLehNiC9XZqEW201mmsg1ovtut3N234+9xiY0bB6IxDZukacnPmfTEjv?=
 =?us-ascii?Q?6+brkd4C5npOzqStKhsfhQWT0RiLsajzilT+eJ8r4ZPVLuMtbhHuAdR2stwn?=
 =?us-ascii?Q?taWGl4qCGnGeh0C8bG8icr/fobo7XFRL88Mt75u1K5IqZlgMgaGOiV/FysiP?=
 =?us-ascii?Q?s8XCJgLwboEdRpFIAA1X4HKlZS3Pt452YPB2ojpN9jddxTvRpCCiRU9HrvOQ?=
 =?us-ascii?Q?r8GAi7UsFRayYW6Xj/n0l0qU0UnRgPTzKdC8sH7XUOXa30W4tzmt3oLUHiWK?=
 =?us-ascii?Q?HvxaYk1XgbKsm0Z8q7XeIfMS5KItV3un7yU55tYkzS20LjUBD8V+i0gYP+vE?=
 =?us-ascii?Q?tTNYYknAr69BG+3IIcGibvAy2LMcK11klV9uxNfFj687i6ad8Xt3fcQ9eF90?=
 =?us-ascii?Q?hY2Oxe7k7dCGFgVmYGzFK5u61LO0+RO5cw799/66Z78z+Gd0n3xldMCJz9y5?=
 =?us-ascii?Q?ShAKm7H44CEqmGKfR4B5eGUF75GKyN/XTLAro5NeIWbAt17ujpw8wh69gDpv?=
 =?us-ascii?Q?dgSbkC2oH7P0xv0z89bWU2R5fnjimge+8T+gE5yk9yecLk9A51+y/OdnNgXh?=
 =?us-ascii?Q?0NX2unYn2y6wunxDt4ZsrrDKspDzutheYG7DYQbCi/fx+4MqlfzPNc8sl4MZ?=
 =?us-ascii?Q?s90P/OzF8chxXPvQwerkCfQS5Uc2T1Vhir2zffqAIoxptzZHLBHzPhJ7bbKb?=
 =?us-ascii?Q?IcVs1mwi8oYq4ItJOAdu2GrO19CYsl31u91OgyNH+KM/WJQziP9ckanliRF4?=
 =?us-ascii?Q?fJiqgN1w7f8RSdYox4LiM2xR+LFtw0FnkGqiGxCB+y+sAhxNr6iLS7mEJdp1?=
 =?us-ascii?Q?NO/VdA5tyDrhGKuWEsl/yVHfgYS1JrNg9n5vl3D1LB3duBlntmiYOd/qy+dW?=
 =?us-ascii?Q?sBb1onwF95P99HtBtHMYbWSTnI3Cj/PyysfyQIIvxegFsjgVdw6eyAwju5Sk?=
 =?us-ascii?Q?nFbqM9Wpzf8+oXOqKP2lmTbRoRLDozHtmqvoLQL26dapyGY/EBvxwd2Kv1Wk?=
 =?us-ascii?Q?zUfNUv7kDQX64qGJRIDaGg2pgCyK2UwoGDQdbLtZs4SmiSSfa9ORIyTOvf4t?=
 =?us-ascii?Q?oGrF+8RNbYus350HlURwKIcDJy+lKINo4V/w+fO+w8K0QqA+qFxu74yx1cvE?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3c6443-87d1-4cff-83f3-08de2c57697a
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 19:18:27.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WaveygS+F7P5yCgkgUd6g5i5Tx7xQJI7Hq6qiZaszh3xlhPzSkPUbAoSGsy/gDo9ODM4hr3ay4QQKOUzO5Cc5L3YzsCG9EiThIzzfWu1/Ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7557
X-Authority-Analysis: v=2.4 cv=OamVzxTY c=1 sm=1 tr=0 ts=69260106 cx=c_pps
 a=b67Q/1ysVWfJPtmvsZ4wdw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=dAfStr-f-UxRwjxwkUYA:9
X-Proofpoint-GUID: Lw40m0JyYO8-G_0bQNy5WmL3l4beOoBw
X-Proofpoint-ORIG-GUID: Lw40m0JyYO8-G_0bQNy5WmL3l4beOoBw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE2MSBTYWx0ZWRfX1//YM3Ky5YGY
 5fFzizH7ON3IJWEKl5frNa4MGhsNTzU5wid1Pnwjxo4hNPvwKBxxNBvNsKkbFcxejPnRcvAXMuJ
 6P2bFM0k+8NEl92/vyrUYHQ+msMg7lMh/5G9TybKum7EnKPU2bQ5Jv8P9aXN6xhBoXwQ/5asPpV
 5zsS3ebVsGrj5OWaS70d89uB/SOqR6t9Hne4w4+KwyQt+l8YVgUnbP4GTLuLlCay+J9poW+WKvO
 xEa+682xZKK3QGpqwtZLxLgaKlAZ5Lm8i0hIHF+87+a8V85h+oIc1aWnpfrRbowra/M5BnRQtMP
 zZ9C+uiCZ/2ryx2/eocJ8fhghpadlIeTArvxkj8+eP4o0LvbENFEC3ng1jvGdi55W/FajUsoAat
 GVckMeJKsR6dvKMRSQeXI9XfMpoPuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

Add drop reason to kfree_skb calls in tun_xdp_one and ensure that
all failing paths properly increment drop counter.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 drivers/net/tun.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index dcce49a26800..68ad46ab04a4 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2392,8 +2392,10 @@ static int tun_xdp_one(struct tun_struct *tun,
 	bool skb_xdp = false;
 	struct page *page;
 
-	if (unlikely(datasize < ETH_HLEN))
+	if (unlikely(datasize < ETH_HLEN)) {
+		dev_core_stats_rx_dropped_inc(tun->dev);
 		return -EINVAL;
+	}
 
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog) {
@@ -2407,6 +2409,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 		act = bpf_prog_run_xdp(xdp_prog, xdp);
 		ret = tun_xdp_act(tun, xdp_prog, xdp, act);
 		if (ret < 0) {
+			/* tun_xdp_act already handles drop statistics */
 			put_page(virt_to_head_page(xdp->data));
 			return ret;
 		}
@@ -2435,6 +2438,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 build:
 	skb = build_skb(xdp->data_hard_start, buflen);
 	if (!skb) {
+		dev_core_stats_rx_dropped_inc(tun->dev);
 		return -ENOMEM;
 	}
 
@@ -2453,7 +2457,8 @@ static int tun_xdp_one(struct tun_struct *tun,
 	tnl_hdr = (struct virtio_net_hdr_v1_hash_tunnel *)gso;
 	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) {
 		atomic_long_inc(&tun->rx_frame_errors);
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_DEV_HDR);
+		dev_core_stats_rx_dropped_inc(tun->dev);
 		return -EINVAL;
 	}
 
@@ -2479,7 +2484,8 @@ static int tun_xdp_one(struct tun_struct *tun,
 
 		if (unlikely(tfile->detached)) {
 			spin_unlock(&queue->lock);
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
+			dev_core_stats_rx_dropped_inc(tun->dev);
 			return -EBUSY;
 		}
 
-- 
2.43.0


