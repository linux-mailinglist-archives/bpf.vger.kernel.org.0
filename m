Return-Path: <bpf+bounces-48139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7312CA0477F
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 18:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2756162160
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 17:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00CE1F2C35;
	Tue,  7 Jan 2025 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ihnnRrDd"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7927259493;
	Tue,  7 Jan 2025 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269437; cv=fail; b=OkgUju7aitssueDJiI12Cw/6SumyPzmGJ7pmVEsl5Nxk7DrRYkiKCT/oeqmLWtUzQNcMbAmZjzL5tAFaKojy26tiEc+j6YHF0pFEjMghvuKjAskQeVs+KaYkEnjEhul11tooetfldTFcAKPx9ZHbbS0vLX0WfZ0mrj43SGWcFjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269437; c=relaxed/simple;
	bh=RPctdKXSQtgif8mBN6fBR90yXAVIRVNxWApwJzTcflU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dZwXBxWR1kpm/vzYXvu/9hoU2Xd2puRsxGUoogW3BPmdL5x0WZJWek5m96oK8hJMXpy0rOs4KhsVOjGv6UmCsFOceHoO1UR3e7zntP8R1AfI2YO+Zys50UOZT9UxNPxzXmTVp6PqUeL7vjblHAnZ/wkTSIsOAwFZ5+510r5A+F8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ihnnRrDd; arc=fail smtp.client-ip=40.107.20.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hw6+UcmnmmM+WQOPN9McEyzzVkID4nJm793wwHQvTHrrDXWo3Cw4buUbcdlH4d0//cYf/rCD8vtUme35FmgJuYXMhRiW99vAdpghweS8F16+gx0Qd2Bf1OfbVqENPgvlaWaGrCiouj6tQ4Jei1VfbL8BawwXaMbj8gE9zTTwkw4lmo82yeX7bSuxHu2QTEabGH/xh4h0plkYC/G7kNXMyPUCNkxOQrA5o317O1Oo00bxHMqRFA3LW2n39gTxvr0CECx0QyXQ3JWqjy0m2Qk8/+yHPsvOpE4fFPp1/lJgMIUpS4Vl+HMtdRhse/JrwQ5ACHCG338T4AAn/uiQuti4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWUtpJORvEWVoa9uX50xKARIy2wa/ZVcj4WGh7gXIIM=;
 b=duZSEgJsWe8RelxLDPysfaXaonTPD6He9JG6rhBEy8+2AFnn5l1yoYOB2e+Lhm5LUkUHlp1ZehXlvf6HXjmey0UMbp8GY2iVjFjaBdgDkJp4JNNn7ZMcl9sG+EipuWbzIo3qroW7CyuVcim9t++JoWRhX3l31nmEVIhdDuFBXS5rP/bPkZZPKEwZkxqAY/JnCxtcuHuhniswt1gPt0lvHRDdHdD7246RtOHpbsU2it+27Qut+pKI461ktAkWg5KN5xH1xLELrAsxssG49LvEm1X3tIO2taNzP7GCSLLsl9H1mliQr8HJDzY3f7IQFXsLzlf9xloVx1GGlIKGFVCVSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWUtpJORvEWVoa9uX50xKARIy2wa/ZVcj4WGh7gXIIM=;
 b=ihnnRrDdmMTW/KY44wCQ6L7fkt5X/0vQm2OPpx/Imw230FIiWN5SLiXnvwjgLnGNXlSvgfphQQIWrEqxNP17EE/FgZ18i3Bsk1bk5k4zKj2zn6OCqf/Ol0oP8s16vyK8TnuBR8BFHqQFIOaCx9POxms/1sXZlaO03MRhshJxUOzFd5e5T8dATyOLb7uRBHScER/OirsF70DBCSDIs6vghjYZLak/fhn8A99tqVA8RPQZmFeIrUBFUvvMDBpQaU1u8K08uSz61IwiReamOjz4yTUgeH39qHpkqEtNf66ZBJrXjmRRCBAPniZTW3BzHovRx9+6mqnlROQtMo1QLOLRxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8182.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 17:03:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 17:03:50 +0000
Date: Tue, 7 Jan 2025 12:03:39 -0500
From: Frank Li <Frank.li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, robin.murphy@arm.com
Cc: Rob Herring <robh@kernel.org>, robin.murphy@arm.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org,
	broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org,
	lgirdwood@gmail.com, maz@kernel.org, p.zabel@pengutronix.de,
	will@kernel.org
Subject: Re: [PATCH v8 2/2] PCI: imx6: Add IOMMU and ITS MSI support for
 i.MX95
Message-ID: <Z31eaxD1h3Om3bHS@lizhi-Precision-Tower-5810>
References: <20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com>
 <20241210-imx95_lut-v8-2-2e730b2e5fde@nxp.com>
 <Z1sTUaoA5yk9RcIc@lpieralisi>
 <Z1sdbH7N1Ly9eXc0@lizhi-Precision-Tower-5810>
 <Z1v/LCHsGOgnasuf@lpieralisi>
 <Z1xs6GkcdTg2c73F@lizhi-Precision-Tower-5810>
 <Z2FDp1zQ7JzxQKJT@lpieralisi>
 <Z2GdvpzT6MOygG4W@lizhi-Precision-Tower-5810>
 <Z256NxZF/+jO2bkR@lpieralisi>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z256NxZF/+jO2bkR@lpieralisi>
X-ClientProxiedBy: BYAPR02CA0052.namprd02.prod.outlook.com
 (2603:10b6:a03:54::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a1ec6d-35b2-4846-e677-08dd2f3d41cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZERtTFJLNk85TmhTM3NUcWNucjhFdGoxaGZ2Q2ZWdkRhTFd5ZVpLU1NhRzdX?=
 =?utf-8?B?WGt3bGVHblpLeFFOZkNSL0FxalZaRjFBcXRKSFQzVHViTlFjRTR3RXlYOUU3?=
 =?utf-8?B?ZFlzZ0hDQk5tckJQMDcvMWVpa1pydGtpaEZnMEpFN0luSDgwTDhJUUpyYmd5?=
 =?utf-8?B?YysrbXV2MUdFQmVNU3BZMkgvMXNzM3VnQVRTMFpid2tRcUZWTGFWSWIrZVda?=
 =?utf-8?B?dldzY3lKSWRnaTRqMkkzYjJKb1pYYWs4c29NWFo0VTU5RWF1YW96MUJ6SmlP?=
 =?utf-8?B?Rjg0ak9pS0RHMmU3NUVKcFkxcTcrVEdIVHFFV2tKNWIyeVdITFl4ZVZCNGUy?=
 =?utf-8?B?bTNtNXJDUlhoOHdSUVpOc0NzUUtQK25BNG45ajJwSXc0aFNWbXRFS3NYNVM1?=
 =?utf-8?B?RVRrbXhNWlZBRVQ2a0MwWDRMaEFZVTVKRWErTHFzSDhhZzM2SlkyN3Y1SVJP?=
 =?utf-8?B?dWkrV1VjYWFGWTV2a2F4NzRiTSttZEhyMWZwdFBkT2ErMUVwaFo4dWlhNUsy?=
 =?utf-8?B?RVVwL3lvMXlqSGhxSEdQK1pSYWI0V0JWZDNEdnJ3ZERsZHhtZFFtVEFzZmJI?=
 =?utf-8?B?SkMrWHVWNkhJU0wwRUZTL3pLVGFPZDFBK3RYOVc1cGN4cThWVWRmaFVqTEFj?=
 =?utf-8?B?WkVqeW1jUGJHOE1acXBUUnE0eGZlMG0xMXVNMVhFUVR0eFc1eUltV2RpVGJT?=
 =?utf-8?B?NUFYd0FQNm91TlVrRTNxZktLaGRhTlpoZDRIV2FUZlg3QVIvMUJ6bmo5Wlpv?=
 =?utf-8?B?YkNFaGlzc3NLSnhUTnEvc1BMNGFNOHdpVHFKTFUvQ2dGbHI5bllpL2tKWHBO?=
 =?utf-8?B?MlVNSERkRXRtNlJyVEh1NGhDQTVTZG5rcXZMTWs1QjQ3bEd5eFZVMDZabS9R?=
 =?utf-8?B?K0VUQVJpR004K2RtWC9qVUwyVm1VYXZpcHlEeCtuYlF5RWNvYlltK0lsbXR5?=
 =?utf-8?B?dFhzLzRiajhVd1dJaFMrUXEzZkxrQW1UZnd5OEVkT3NETEp6Rm5rRWpZVnBV?=
 =?utf-8?B?RTlJaWxPTndmK0lqdHRSc1B0Mk1iN1JtaXQ2VlhjUTFRVk5BZk5teDVsT0N0?=
 =?utf-8?B?Skc0NmJ2Nm1YM3J4SXRnZ3hWV21uQXNKckkxV0V4d0Jsb0hncTdXNkdmWlZX?=
 =?utf-8?B?Q1JMR0dhSzF5TUpkanNucVBIN0dTeTBGUWo0N0VmSXJhbjhwVTF1VXhDY1Rj?=
 =?utf-8?B?OXNKYkJvd3FzV2hpNk9BYUViTWRvTnh5ckxwZCs3dmdVS0pWN0pkQTg4ek5x?=
 =?utf-8?B?bjBlUFpCbmF4RDFmWEFldzBsYS9MRDkrdTQyQTAzajM5Zk02WEMrUkxIbFdv?=
 =?utf-8?B?S1drZXJBcldRTEUzRytyVVByaThzTlVFVmN2NEhnZnNVK2NJNVpEVkxjRUFF?=
 =?utf-8?B?NnhHVnZaWG9VNVJTOFQxdDNqTUlkOExuTjkwY0lyRjZBNzlLdytxRTFzdVh4?=
 =?utf-8?B?UHdVdmVSWWhJOVJGMUZQNCtRSHFhNlVGNE5FUllFNVR5bUltTW1YUXhWbGFk?=
 =?utf-8?B?VEdvaFZ5aUk0THpZVVBmejJic2NwNzh2VGQrNmRYWjhXUnQ2Q1k5ZS96dEVu?=
 =?utf-8?B?T3hUa2UxU1VVdW95VXFuZmhiMVplQzBZeFNaU0Q1U3N5aGZrZTN0TlBEdUZo?=
 =?utf-8?B?RXV2Tm5SN2pRYkI1dmFPYXBzaXlMbDRkWkE0NjE2cVBxV3JndmphUjF3UTBU?=
 =?utf-8?B?dnRSemMyRWtTQzJDV0J5SVNlY25LN2tlalJEVHdzSTVLVzdNbWNjaHZTY0Q4?=
 =?utf-8?B?YVhyUFV1TmVKWHFOMCs5YWFHaEF4dWw1cnU5VENUVmxLT3I3YUZXcTUralR6?=
 =?utf-8?B?VlZtTGJnemlHbkpGdmVCY2JoMGpiV0JNWnArNHJrV3dwQUI5Yy9HYUJZZDNh?=
 =?utf-8?B?MGUyNXNKR0pRdVQzNlJHMWdOdDZQSFR0eDFZS1VvSkp3bmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1F3aFYwbk5WWmxoaXFXSkVvU2lHQWdxbWpmVTFkY3pKTmJRaW1SSFR4bkV5?=
 =?utf-8?B?MVd0VURSTHM1bGJFSVlTRnhyWnVqcGdNQVNDWEFMN0wrQVl3NmdpWmRYMFJu?=
 =?utf-8?B?K3FNUDlOMFBlbzIzTEpHc3oyVDgxdUlQS21Ib05PWDdvM09mTllUeGZMd21G?=
 =?utf-8?B?bHdrZ0JQQXFIUkxvYzFXUUdmdFRQRDRKd2R2VnhDTmJROWkwSnV3U25lK1dS?=
 =?utf-8?B?cllOZWdRbjRoeFFwaWorcFd6akR1QnhjUDJUanJYYVFkdHdBWUJXcHJsdnc0?=
 =?utf-8?B?N0YvWmVhNUZSbEZHbWV1V0hTU2dSc1I4WmNndnJ0cGZZSENxQWFrVFRqZ0Vu?=
 =?utf-8?B?SGxTV2VpbW9jaUx3YjZramJTcitUWFdHTmRnTUhOT3NGTSt5bk1zcGVjNnpu?=
 =?utf-8?B?aVJJOTN1WjZGZmFyN080dERWY05oUG9zV0lnV3hGb2FkN3VYYzhYejRpaytt?=
 =?utf-8?B?bWVSZENXbnFyaVhZSzhXa2dOU21tT083MVNkcVlXcGFWZGd4STRRVmJ6cno5?=
 =?utf-8?B?Nkowd2FkcU5yUTZZVXVRUlJKejBhT3BPeGRpZ0JBNVJub0U2K1k5YkNxVlFt?=
 =?utf-8?B?clRQSFZuRzg1dENUWVRLK0E5UXh3Vmo2RmRlUUIxSmdmb2FkY1lpcU9pbDdl?=
 =?utf-8?B?bXJNSkZWd3J4TS90ckgwWG1nTEhSUkhBU2JZcktHUTBYY2VNdmpvV2d2S1VO?=
 =?utf-8?B?eW5yV2ZNQmZRZ1d2YnpyMi9Pa0JtY3FIR0c1eHpRcHJuTGUrTHR5UlFrSm5G?=
 =?utf-8?B?RVlHQzd4K1grSE5CdWdIbDlxbEN0MXZrbDhtc0RhRzl5RFNWZmFHbDB6Nmt6?=
 =?utf-8?B?Vm9PSWNZbnRYc0ovRVhDOC9jVWx4aG5MTUFGK21XelE2YlFsS2JpUE5pR0tX?=
 =?utf-8?B?MkdoTllrdit3Q0FldjliWHZtcmRwK2NOMDJkY1huU1JtcjJmU2JqSE1YenhG?=
 =?utf-8?B?WFFRSFIwcFJxZUpIUXpmeUVSekdrbUF6ZGNHeE8xcWlaalR4RlJvcmhnOWFJ?=
 =?utf-8?B?eVhxTlI5L1FmZzBGSEZJL0lkNW14bDFPUzJUVm1kSlJrRTNiTlZ0ZWdzTE9t?=
 =?utf-8?B?dllVKzlDVHNtZDI0UmRWVUJ3ckl4OUwvcSs0MEx0cnJyc0ZHaUNvaklzY3VB?=
 =?utf-8?B?ZTNmdlhIbnN0ODY4dVJNQlBIbTR2S1pnVTkzcEFJanZZTE8zdmk1OUl0VFJ2?=
 =?utf-8?B?NVNpNE9PcjlNcUdnNlM3cEE3NGZiaTdScmU4REhSMW45WndJajFteU1zc0I1?=
 =?utf-8?B?NVdIWTBJQUZ5UDUzNjhoKzd4YnU5UnJzZllTSCtpRUxVNTZHb3J1VWlWVndj?=
 =?utf-8?B?OGF1NFVxVTN5UVNkNGR5a2hyQkRVYXlaQTdYK3hkczBVUk5Qdm8yZVNnQ3or?=
 =?utf-8?B?SzFSNkpxMy9ZeVF1aVZRVEp3cCtsODZXY3Nod280eVRDZ0dvTlhWb0txRHpu?=
 =?utf-8?B?VThmbEdhTXZyMDZwRXptdWRseU03WEVPanZZcjBlLytoczFhY3FBV1RYbnFG?=
 =?utf-8?B?L2k5SFdDK1BMUU0xTlQxUndFVVBFak9yMzNRbWViN2d6R21FZGEzTU9lR3B5?=
 =?utf-8?B?VVZMNmVtTXZkZnIwM3ZBR2NKNURzdTVUOG55VGNjbndIOHFnaWRCazhZM053?=
 =?utf-8?B?eEhrSkp5WW1XUExzd1Rya1RyYzlzMldxeEVKRkVvOHBZbVh2OFJCeUp6MlZ1?=
 =?utf-8?B?QVNHWTlRT2c1U1Q4YUxncFMrTDl4MllmaHUva1l5eCtZckhPZlplQmc0eGFi?=
 =?utf-8?B?ejJsVzBjN1FhRlVRanR3Mkt1TSttQWdQMHpBOWxXcWhUNnpPajJpcjV3RnVz?=
 =?utf-8?B?VENDTXVub0JHcHpaMnhqMzdQaXRXNTJiZjZqSGdOcWFyazhPK2FhUjFEVXh0?=
 =?utf-8?B?WmRWZGUxRkl4UnVwMnpVNUk0UkNDQXpMZmpRNlE0ckkrOEtlZ3NNdm1telJ2?=
 =?utf-8?B?UncrVHFXQXRMRDk2WERKKzlOQmdLa0E5ZVViSVByVlFxM1kvYWVBQldJTURu?=
 =?utf-8?B?aHIxaHNDKzNnT2FDUFliWmlvb1Z4YnRJZGlqaTNYZndTNjlqMGtsdDhtK0pt?=
 =?utf-8?B?ZW1Sd2NHOUZMbG1lSk82UGd3dlBhYUNmVm81Y01aTWRCYXVmTXk0bzYydERm?=
 =?utf-8?Q?D3UN4utE1CfziunpwLcfdxyjB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a1ec6d-35b2-4846-e677-08dd2f3d41cb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:03:50.2065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9z2bpz3ZOCMrc4IUZLqcNAoU4QCAiEe5HS+EGhdMyW/zIiOGq+6p/OELaInqaAB2UN5KqgB5JVA+Xh8VtGaqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8182

On Fri, Dec 27, 2024 at 10:58:15AM +0100, Lorenzo Pieralisi wrote:
> On Tue, Dec 17, 2024 at 10:50:22AM -0500, Frank Li wrote:
>
> [...]
>
> > > > > Right. Question: what happens if DT shows that there are SMMU and/or
> > > > > ITS bindings/mappings but the SMMU driver and ITS driver are either not
> > > > > enabled or have not probed ?
> > > >
> > > > It is little bit complex.
> > > > iommu:
> > > > Case 1:
> > > > 	iommu{
> > > > 		status = "disabled"
> > > > 	};
> > > >
> > > > 	PCI driver normal probed. if RID is in range of iommu-map, not
> > > > any functional impact and harmless.
> > > > 	If RID is out of range of iommu-map, "false alarm" will return.
> > > > enable PCI EP device failure, but actually it can work without IOMMU.
> > >
> > > What does "false alarm" mean in practice ? PCI device enable fails
> > > but actually it should not ?
> >
> > Yes, you are right. It should work without iommu. but return failure for
> > this case.
>
> Rob, Robin, are you OK with this patch DT bindings usage (and the
> related dependencies described in Frank's reply) ?
>
> I am referring to "iommu-map" and "msi-map" usage, everything else
> is platform specific code.
>
> It looks like things can break in multiple ways but I don't want
> to hold up this series forever.

Rob and Robin:

	Let me simple summary situation. PCIe controler driver need config
"stream id" for each PCI endpoint devices for IOMMU and MSI.

	So add callback for host bridge enable/disable an endpoint devices.
In callback function, call of_map_id("iommu-map" | "msi-map") to get
devices's "stream id" from pci's rid.  Then config hardware.

	The limiation is, if smmu/its controller's "status" is disabled
and rid is out of the range of "iommu-map" and "msi-map". Enable device
will be fail although it should be success because "stream id" will not be
used at all at this case. The out of range of "iommu-map" and "msi-map" is
rare.

	dwc common pci driver simple check "msi-map", which should be
another limition and not related this patch.

	In many dwc platform (like qcom) need config "stream id" also. But
that direct parse "iommu-map" and "msi-map" by their drivers, which is not
prefered by Rob now when I try to upstream at v3
https://lore.kernel.org/imx/20240429150842.GC1709920-robh@kernel.org/

	Rob: can you help check if this is correct direction?

Frank Li

>
> Thanks,
> Lorenzo
>
> > > That does not look like a false alarm to me.
> >
> > My means:  return failure but it should work without iommu. Ideally
> > of_map_id() should return failure when iommu is disabled. It needs more
> > work for that. I think we can improve it later.
> >
> > >
> > > >
> > > > Case 2:
> > > > 	iommu {
> > > > 		status = "Okay"
> > > > 	}
> > > > 	but iommu driver have not probed yet.  PCI Host bridge driver
> > > > should defer till iommu probed.
> > > >
> > > > Worst case is "false alarm". But this happen is very rare if DTS is
> > > > correct.
> > >
> > > Explain what this means.
> >
> > It return failure, but it should return success if "iommu disabled" and
> > "RID is out of iommu-map range".
> >
> > >
> > > > MSI:
> > > > case 1:
> > > > 	msi-controller {
> > > > 		status = "disabled";
> > > > 	}
> > > > 	Whole all dwc drivers will be broken.
> > >
> > > What MSI controller. Please make an effort to be precise and explain.
> >
> > For example: ARM its, I use general term here because some other platform
> > such as RISC V have not use ARM ITS.
> >
> > pcie {
> > 	...
> > 	msi-map= <...>
> > 	...
> > }
> >
> > DWC common driver will check property "msi-map". if it exist, built-in
> > MSI controller will skip init by history reason. That is also the another
> > reason why Rob don't want us to check these standard property.
> >
> > Without MSI, system will failure back to INTx mode, same to no-msi=yes.
> > But some EP devices require MSI support.
> >
> > Frank
> >
> > >
> > > Thanks,
> > > Lorenzo
> > >
> > > > case 2:
> > > > 	msi-controller {
> > > > 		status = "Okay"
> > > > 	}
> > > > 	if msi driver have not probed yet, PCI Host bridge driver will
> > > > defer.
> > > >
> > > > Frank
> > > >
> > > > >
> > > > > I assume the LUT programming makes no difference (it is useless yes but
> > > > > should be harmless too) in this case but wanted to check with you`.
> > > > >
> > > > > Thanks,
> > > > > Lorenzo
> > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Register a PCI bus callback function to handle enable_device() and
> > > > > > > > disable_device() operations, setting up the LUT whenever a new PCI device
> > > > > > > > is enabled.
> > > > > > > >
> > > > > > > > Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > > +	int err_i, err_m;
> > > > > > > > +	u32 sid;
> > > > > > > > +
> > > > > > > > +	dev = imx_pcie->pci->dev;
> > > > > > > > +
> > > > > > > > +	target = NULL;
> > > > > > > > +	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", &target, &sid_i);
> > > > > > > > +	if (target) {
> > > > > > > > +		of_node_put(target);
> > > > > > > > +	} else {
> > > > > > > > +		/*
> > > > > > > > +		 * "target == NULL && err_i == 0" means use 1:1 map RID to
> > > > > > >
> > > > > > > Is it what it means ? Or does it mean that the iommu-map property was found
> > > > > > > and RID is out of range ?
> > > > > >
> > > > > > yes, if this happen, sid_i will be equal to RID.
> > > > > >
> > > > > > >
> > > > > > > Could you point me at a sample dts for this host bridge please ?
> > > > > >
> > > > > > https://github.com/nxp-imx/linux-imx/blob/lf-6.6.y/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > > > >
> > > > > > /* 0x10~0x17 stream id for pci0 */
> > > > > >    iommu-map = <0x000 &smmu 0x10 0x1>,
> > > > > >                <0x100 &smmu 0x11 0x7>;
> > > > > >
> > > > > > /* msi part */
> > > > > >    msi-map = <0x000 &its 0x10 0x1>,
> > > > > >              <0x100 &its 0x11 0x7>;
> > > > > >
> > > > > > >
> > > > > > > > +		 * stream ID. Hardware can't support this because stream ID
> > > > > > > > +		 * only 5bits
> > > > > > >
> > > > > > > It is 5 or 6 bits ? From GENMASK(5, 0) above it should be 6.
> > > > > >
> > > > > > Sorry for typo. it is 6bits.
> > > > > >
> > > > > > >
> > > > > > > > +		 */
> > > > > > > > +		err_i = -EINVAL;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	target = NULL;
> > > > > > > > +	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", &target, &sid_m);
> > > > > > > > +
> > > > > > > > +	/*
> > > > > > > > +	 *   err_m      target
> > > > > > > > +	 *	0	NULL		Use 1:1 map RID to stream ID,
> > > > > > >
> > > > > > > Again, is that what it really means ?
> > > > > > >
> > > > > > > > +	 *				Current hardware can't support it,
> > > > > > > > +	 *				So return -EINVAL.
> > > > > > > > +	 *      != 0    NULL		msi-map not exist, use built-in MSI.
> > > > > > >
> > > > > > > does not exist.
> > > > > > >
> > > > > > > > +	 *	0	!= NULL		Get correct streamID from RID.
> > > > > > > > +	 *	!= 0	!= NULL		Unexisted case, never happen.
> > > > > > >
> > > > > > > "Invalid combination"
> > > > > > >
> > > > > > > > +	 */
> > > > > > > > +	if (!err_m && !target)
> > > > > > > > +		return -EINVAL;
> > > > > > > > +	else if (target)
> > > > > > > > +		of_node_put(target); /* Find stream ID map entry for RID in msi-map */
> > > > > > > > +
> > > > > > > > +	/*
> > > > > > > > +	 * msi-map        iommu-map
> > > > > > > > +	 *   N                N            DWC MSI Ctrl
> > > > > > > > +	 *   Y                Y            ITS + SMMU, require the same sid
> > > > > > > > +	 *   Y                N            ITS
> > > > > > > > +	 *   N                Y            DWC MSI Ctrl + SMMU
> > > > > > > > +	 */
> > > > > > > > +	if (err_i && err_m)
> > > > > > > > +		return 0;
> > > > > > > > +
> > > > > > > > +	if (!err_i && !err_m) {
> > > > > > > > +		/*
> > > > > > > > +		 * MSI glue layer auto add 2 bits controller ID ahead of stream
> > > > > > >
> > > > > > > What's "MSI glue layer" ?
> > > > > >
> > > > > > It is common term for IC desgin, which connect IP's signal to platform with
> > > > > > some simple logic. Inside chip, when connect LUT output 6bit streamIDs
> > > > > > to MSI controller, there are 2bits hardcode controller ID information
> > > > > > append to 6 bits streamID.
> > > > > >
> > > > > >            Glue Layer
> > > > > >           <==========>
> > > > > > ┌─────┐                  ┌──────────┐
> > > > > > │ LUT │ 6bit stream ID   │          │
> > > > > > │     ┼─────────────────►│  MSI     │
> > > > > > └─────┘    2bit ctrl ID  │          │
> > > > > >             ┌───────────►│          │
> > > > > >             │            │          │
> > > > > >  00 PCIe0   │            │          │
> > > > > >  01 ENETC   │            │          │
> > > > > >  10 PCIe1   │            │          │
> > > > > >             │            └──────────┘
> > > > > >
> > > > > > >
> > > > > > > > +		 * ID, so mask this 2bits to get stream ID.
> > > > > > > > +		 * But IOMMU glue layer doesn't do that.
> > > > > > >
> > > > > > > and "IOMMU glue layer" ?
> > > > > >
> > > > > > See above.
> > > > > >
> > > > > > Frank
> > > > > >
> > > > > > >
> > > > > > > > +		 */
> > > > > > > > +		if (sid_i != (sid_m & IMX95_SID_MASK)) {
> > > > > > > > +			dev_err(dev, "iommu-map and msi-map entries mismatch!\n");
> > > > > > > > +			return -EINVAL;
> > > > > > > > +		}
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	sid = sid_i;
> > > > > > >
> > > > > > > err_i could be != 0 here, I understand that the end result is
> > > > > > > fine given how the code is written but it is misleading.
> > > > > > >
> > > > > > > 	if (!err_i)
> > > > > > > 	else if (!err_m)
> > > > > >
> > > > > > Okay
> > > > > >
> > > > > > >
> > > > > > > > +	if (!err_m)
> > > > > > > > +		sid = sid_m & IMX95_SID_MASK;
> > > > > > > > +
> > > > > > > > +	return imx_pcie_add_lut(imx_pcie, rid, sid);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static void imx_pcie_disable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
> > > > > > > > +{
> > > > > > > > +	struct imx_pcie *imx_pcie;
> > > > > > > > +
> > > > > > > > +	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
> > > > > > > > +	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> > > > > > > >  {
> > > > > > > >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > > > > > @@ -946,6 +1122,11 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> > > > > > > >  		}
> > > > > > > >  	}
> > > > > > > >
> > > > > > > > +	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
> > > > > > > > +		pp->bridge->enable_device = imx_pcie_enable_device;
> > > > > > > > +		pp->bridge->disable_device = imx_pcie_disable_device;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > >  	imx_pcie_assert_core_reset(imx_pcie);
> > > > > > > >
> > > > > > > >  	if (imx_pcie->drvdata->init_phy)
> > > > > > > > @@ -1330,6 +1511,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
> > > > > > > >  	imx_pcie->pci = pci;
> > > > > > > >  	imx_pcie->drvdata = of_device_get_match_data(dev);
> > > > > > > >
> > > > > > > > +	mutex_init(&imx_pcie->lock);
> > > > > > > > +
> > > > > > > >  	/* Find the PHY if one is defined, only imx7d uses it */
> > > > > > > >  	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
> > > > > > > >  	if (np) {
> > > > > > > > @@ -1627,7 +1810,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
> > > > > > > >  	},
> > > > > > > >  	[IMX95] = {
> > > > > > > >  		.variant = IMX95,
> > > > > > > > -		.flags = IMX_PCIE_FLAG_HAS_SERDES,
> > > > > > > > +		.flags = IMX_PCIE_FLAG_HAS_SERDES |
> > > > > > > > +			 IMX_PCIE_FLAG_HAS_LUT,
> > > > > > > >  		.clk_names = imx8mq_clks,
> > > > > > > >  		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> > > > > > > >  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.34.1
> > > > > > > >

