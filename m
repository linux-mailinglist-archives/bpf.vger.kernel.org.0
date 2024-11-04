Return-Path: <bpf+bounces-43925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5669BBDEC
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 20:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F0DFB22563
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 19:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF1C1C4A18;
	Mon,  4 Nov 2024 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oB9lqwLP"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2047.outbound.protection.outlook.com [40.107.104.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B1AD2D;
	Mon,  4 Nov 2024 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730748206; cv=fail; b=c8C8gDx253aUlw3mWbg1NohdaJfmraLjkG6LFpQrpqzEhIFpQsuychuqMg5A/CfnYGNC5laib9AIMn7ZzgwxmNjRm5pzJ+Ezgc9MI9iQLpqS3SK65RB0Hf+Pb44ioBcJrp72vlDXZcB2owqbBxDVCZcg5uAxi/cfTi4VNHYtOjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730748206; c=relaxed/simple;
	bh=DdW+DjHukIg+E2C2bGmc4kgrMM/Gdf+3w7SHubv4zWc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=YAP1yYEg76PQefIpfa/WMa53wIvYZ8yj3hQOFP11Y8u/JF0KKjdddY/hldpMJ/t+tn9JvTGF+gCYh39VyFNIY77Ci9RQ4tjsjNpcn7iHXLirx5UrCbtpHH6WLpmgUo9N6BqKMAXK86Z0vBgpJdw3iC4NhPKRHEkhK4jXXDo4d38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oB9lqwLP; arc=fail smtp.client-ip=40.107.104.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNd3ZZ70105+v6CV1pooE0kkCAOp3zJNn3RXV4HPWCDpsyYacOMnqX25Q9G+IVQfVvN2RyYbbgReEUjaI+JRS0uJY4iIUQv+nSc/JbmkXq1Uxagms5jz4KaG69up5Pz+0bQwrjrYhZpDYRV5IVUvPQt344jNU83q9ESV+wZuKgWLp4DRslEKa2cUDUwQVs5no2vTBujFMR1mHqofiY6vBZJbBAGYNGsD+rw/jlpVzd1UggYnamakruO7fD1KBjGSp52nQ0czspOWp/4byh332dRyVL8O0VCFCUfNP4Pnq6TZi9DAbyra9rOm/RwKKNoTlSnAp8dqL4OLx/5y7OtLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T67ILxOoSKqJbYeYHr6Qv4wtB6ddMSM3eSk6wgytURM=;
 b=c9fFzTIwdw46irYyd6Xi/WHmfrpSMn1pXsICviVwYd2NItkCqgt5ydA07jbeifvM1ZySC58znWBejr+vw3/yXVklUKa58H0lF0GKFJpWLGNKO/5IGUGMCJ+uGgDQDIHZ6YCjfTJ2I1lMpzcmElOWOk0sl6CP4XtPYtuQvtqu/IOSsYAKBeomJ2t1OserCgPBSCmYbEno1CKGo5KBTHLehy5ygcPUmoRYOz0xF7WMIdWsrKCs6ECX5mr1OOH1G/rlgXBV9CcXQ0x1RDa1gxz16qHmpMlhK5pDjhItCZCH5SKRl5LhBoYZ8HpM8B+LNlw5fHDWJQoXytjT2T7Y4tlwGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T67ILxOoSKqJbYeYHr6Qv4wtB6ddMSM3eSk6wgytURM=;
 b=oB9lqwLP5gWxXjmnZQgTrJLhYQTROCr0wLo3A7TrCaQ9hvK7Wjv4YHe7fKAzkb6l82ygJ0+6S8L61/zY6X4RCKkQ7z5F9xsHR7wco47DcQM+2WzRC+dBVnccbAThV3HlQQr43+R4c28sSHDUNFiQ2ReqgjydljRDH74LU1X+iJB3Wz9a11wOicY1fqHVTxn8oENtUyn2m7OKmghWhxN5ofAfi/oU1vI3RZtTPmMceHhegsxc4MzgCTaPaPr57ZIwyrTg1/EYeS/gLewhspqA/QNp92umqbt+3zsXEYJucMaFhiX8T83xuTbqY7DtmpduxlwX5EEwYdKkMS+6reapBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6886.eurprd04.prod.outlook.com (2603:10a6:20b:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 19:23:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 19:23:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 0/2] PCI: add enabe(disable)_device() hook for bridge
Date: Mon, 04 Nov 2024 14:22:58 -0500
Message-Id: <20241104-imx95_lut-v5-0-feb972f3f13b@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABMfKWcC/23NTQ6CMBAF4KuQrq2ZTn+grryHMaYtRZoIGFCCM
 dzd0YVC4mIWbzLfmycbYp/iwHbZk/VxTEPqWgp6k7FQu/YceSopMwRUYNHw1ExWny73GxfBFIg
 YwSrF6P7axypNn67DkXKdhlvXPz7Vo3hv/7WMggMvIRiEIi+98/t2um5D17B3x4gLJ2HpkJz0R
 pncOy2tWzv5dYJm6SS5XIMN1tO3wqyd+jkBYukUOajKyjqsYq7Vz83z/AKSCj5NSAEAAA==
To: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Frank.li@nxp.com, 
 alyssa@rosenzweig.io, bpf@vger.kernel.org, broonie@kernel.org, jgg@ziepe.ca, 
 joro@8bytes.org, l.stach@pengutronix.de, lgirdwood@gmail.com, 
 maz@kernel.org, p.zabel@pengutronix.de, robin.murphy@arm.com, 
 will@kernel.org, Robin Murphy <robin.murphy@arm.com>, 
 Marc Zyngier <maz@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730748193; l=4036;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=DdW+DjHukIg+E2C2bGmc4kgrMM/Gdf+3w7SHubv4zWc=;
 b=BeKbg9xkiLhYkWkEsP79+dRCxuyXlZ5GLgy/19ntQ587tMW08rGzet25gKQxwNlvHMViq9GwY
 zf6iTeV9LQSAfztzhTkBttFOJIN88UJYRhKVx1u7CDpCIFoxQy/w9iM
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: ddfa2b03-8707-436d-d452-08dcfd06239b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGZPcjZMSlJpQTVkSnRJTWU4aDFJcnYvRFZLNk16Y05TeGUwejNuZHc4a0Zm?=
 =?utf-8?B?NnREckZERkFvTndXazRiOTVRckVFWGo5SkVtT1A1ZWE0dHZIY05jdVJNeEtS?=
 =?utf-8?B?UmZ3SXVzc2JDeWpzOU5mWTZBMjhFZFlibnAybTVka1JWZDlYaUFlcVpaV2lV?=
 =?utf-8?B?T2wzTEVJcDhmbUgvcEc3ZkhtM2VQbXlkdDkxSXBJeldSUDV1RUMyb3lJbll4?=
 =?utf-8?B?eFNjVWxmK0pXU1YyMDB4UzQ4NU1kWk4wa2JsYVBJMzZmTmhBdnFsYlZMakZZ?=
 =?utf-8?B?VHdFNHVGK0o1aHQ1djZ4bVVGaFRrR3dFdXJBSHBCN2R6K0NXNWUwYVZibEdZ?=
 =?utf-8?B?ZjNSNXM4cFppdFFNK2lxaTZLYU0wam1IeUhkNVB0WHlCbVp4VnllVi8yb3hP?=
 =?utf-8?B?RjY4NG5ERG5wUEhiRlVuMXNyNjFRRTlBVTZ1MzczZjIwK3ZLczZHbUlYQ1Fn?=
 =?utf-8?B?UEorckpuYzBxNDM4cmwwclY1WFRHTjl3blRnZmdvTFRDUDRwS1d1bnJnY1Fa?=
 =?utf-8?B?ZmhEOWZDWUY5eHB2RWlnMG5qM1F1OW1Tb21sN0hrYWtHL01qTnJUOEZsRldC?=
 =?utf-8?B?cW1jdjYrdU55aGcvdkdFY0JLWTBWeHJJTGQ5S2hWcU83K3N2bzAvbUk4WVYx?=
 =?utf-8?B?THBJckhMZWM5R09nNVZ1ejZSQ1FaeW5JTE12enR3NW5Vb055aUxERG14Y1hI?=
 =?utf-8?B?SmdGdVcwZW15aFo3ZHZJZ0syWlhodUxGSFFuTkl3aWt4RzUzSFVDcmNqZkc4?=
 =?utf-8?B?QXNINFNFOVJ5VEdTOVFkRVVvaXFhZ1d3OXFVSUZ3bGlWOE9RMCtTVHNNZkY4?=
 =?utf-8?B?UGtiZFJ0UUt1L0FrbzNmNmRtUkNjdlovbmJZdUVjR2pFRWIzT3FWQnprd2xX?=
 =?utf-8?B?eWlqMUxzN0EvZmRRd0FNa2FCNkRjMUY1ak8vNjZ1NVJnZ1QzcWZJQkJoL2V6?=
 =?utf-8?B?eHZSQUp3WGxxallpdU11eE9nODRLZmN4SitpQkZ6dFhGdTAxaGpJMmUyc2Fn?=
 =?utf-8?B?VHI3NEhCZnpDZlRkd0lvYTk0ODUrNG1ta2dkME9VZGRoUXRROWtraTRjQi9R?=
 =?utf-8?B?eS9DY0QvNzc1OCtGUytWaW5rWTh1WXNsbUJTdVhCM05xWkkrZFYvSWFma1FJ?=
 =?utf-8?B?bUZIeXRPS3M0NEI1ZC9NRlZGa1QwZ2ZKdVM4Zm9Ha2pTZHY5Q0dLenN4M0JR?=
 =?utf-8?B?UUl1aGJDTEtqbUJsUnZ3Z2FWeXFLSHo0V2lOZEVJWXd5Mjc4REppMUNlbWll?=
 =?utf-8?B?ZExVQVVlenQ2N2NEZDRkNllNNThPQmhTZ2RDYXVlSWk1TnN0dUZyVHZWYW0y?=
 =?utf-8?B?ai9kL3FUdEMxQWZrRjVUcmZ4NHlQbVg4YVFTcEIvSUhQTmlEYmovdUo1eDZj?=
 =?utf-8?B?dFJveUk1M1huRHcxMHY3UXN0UVBObDM1YXphYU5CVWZlbjJ4T2lxczAxM0lI?=
 =?utf-8?B?T1Zoc2x2V0ljR2MxU0RidzZ6U1hMWWlnSmNxTjM2Z2NvRUVReGtyendqbkE5?=
 =?utf-8?B?KzY0MlNJay9FdGorUkFmdUZ0RWpxbVZyZnR5Z2d2SDI1ODNWczZ6SXJPM29o?=
 =?utf-8?B?d0prQjNaMVVjbFZ3TVJMQXhBa3BYMmdiSlpza2JQWHRBT0JSc09rL2NlUUZq?=
 =?utf-8?B?UGJnTjBsYzlLUVdENmEzMUZmMmpRVU1Ob29pNElnVnpBQ0F0NHVkUGhON1Ar?=
 =?utf-8?B?QU9GM1kraHk2NjB3OEJhYUhrUDJUSWovVGVkOXQ4NUFRcVE3K1RFQVczWjYr?=
 =?utf-8?B?d0tBUmpBL3R2cTVTc2l3MVNGbEdTRFlUOFk1d24rOUdKWmRXd1NEVTRJemVT?=
 =?utf-8?B?NXNhM0d3SGpseENuclB3UmZKbWRQSkd0VnVRSlVid1Z6d1FxMmRjRExjclpG?=
 =?utf-8?B?Y2tsTFNPMGVLQ3Bxc3hrUGZLM1dYcXRwV01SZzNDVHhMWVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3VJUEN1c093N1JrM1dJS0tUczdYSSt5akVINzR5eWx6YStSVXljYmhQMDBj?=
 =?utf-8?B?MStQQmxmRVQzY0tyY3JwYmdEWHllT1lEbmtSK1Y3T2ZFdzB5YkNGcnBleDI5?=
 =?utf-8?B?MC82MzRqUVduOXRkNEhrTmVReVpIMHZ0NGEyM21rbm9jbjRiSkYwd21GOTha?=
 =?utf-8?B?YngvdGc3aEhkajZsMzRDamhBQWRuN0orWXdza3M1V2tPczJHWDlmMmRhK3JH?=
 =?utf-8?B?djEvM2xiVVZBSE1ndGRtcGs5RWpUaWk0NVBSbmZ6T1NweGM4K2tqdDc1RG1O?=
 =?utf-8?B?UC9USlllbGRGQXBpV0tpTk1BNWc0TmVkOVEzbG42V1Uzd0RqRkVKTnZEd2kv?=
 =?utf-8?B?YXNwYjJXOTRmRFVnNi9IOURDSzVsVUxya3Uyek1rT0g1Q090a3ZlQ1J0QTZB?=
 =?utf-8?B?T3FxUCt3ejBtUzdFUk1WWE9tTUJmaWp3TFpobFNCcS8wMjRGd3dDNzBvQ0Zn?=
 =?utf-8?B?bEpUdk1HMFd0MDJnWmZHMzlJcG1xWnRzQkRpdHJpekk4YURsMHZHdkhaMTha?=
 =?utf-8?B?YkZqZHZRM0FVRmtWcmxpb1B5U3g5a1FLTjl4L2tWRmloWkNIeFAyaFQyejVX?=
 =?utf-8?B?OHVMSDdtL2dNUVFaK0xLR1c0VnovTHBMc0RzUHYyMFFBK0JFc202YmxzWDhi?=
 =?utf-8?B?ZHhQdElPV0dwMFZHdW1KVmpGTkZhRE9aTG1vZTdQUTI4NEIyWFlaNnRxOWdZ?=
 =?utf-8?B?SmZWRkZ3T2p4dUdoZkgvUEZrbHowbFN0NE9LVk0yTFQ2RHYxQk15MzJJaUNm?=
 =?utf-8?B?UzdwcjZKUkdyUjIzU0tidnozR1FHK3hQNnJaUkhsRXN6V1IrbkxLK3k4SVdL?=
 =?utf-8?B?QzhxNENGZWkxSVBseDFLMmkzQU9jemg2azVEbTFOTWZsaUJIWTdMSkNIdmhQ?=
 =?utf-8?B?amxwV09Id25rRjhKNks5WE9hUkJjNlBUcEFJeG1VRTdkK0RTVnZ2eFhBa1R1?=
 =?utf-8?B?MGUvYzRiZnFLTk1WQmMxWGE4ZUxySG5wbEk0ZUgwNmVkMk1BVW9YOGtnTnlX?=
 =?utf-8?B?bVdMdGpjdEI1bWVNSFlCMUI0Nm9Pd2RXMFhsSnFMRlpzYUo5eUFEdWR0VXZY?=
 =?utf-8?B?RHpyNGtuWTRGaDh3dEJRVlFCODNlVmJVTEV0Vm9LU3VqV0JYSWlvUFVHT3ll?=
 =?utf-8?B?T3ZGZGxnVDVmRG5NOEpQOXZUanJKSzN0MUJBRVZzcGZnY3VNdXNUS1hoTWJs?=
 =?utf-8?B?Q2VhNUVrOUxnbVNhQyt1OU00YUhXMjZhWkdkRkp2dm1nMFJkdCtkeUpzRm83?=
 =?utf-8?B?WWs3NDFpL3lUdWhXaXNkUlJFenBiejNMMVA1WDVjK0x2RUtDRFIxQ0FvblJW?=
 =?utf-8?B?Zi9PeDBPZkMvVVQ1Tk11cEIzNWN0QVhwVnF0V241LzhsUG9aQktGUlhIbFQ2?=
 =?utf-8?B?WXN0L0YyL05UYmUvT3FmMU5tazFLT0FuRktWVWdidk5nb1Y0b1NTRFk2ZVJ4?=
 =?utf-8?B?aTNqUk5FT2xldk1vMExsS0pLenI3NVdFUWRqRndTVjBNOUIvM1A5c3FtNW1i?=
 =?utf-8?B?YjM2ZzVuMjlnU1RrSGV4ek1kVWNNelA0Zk11emREL29ndko0YkZnMFlIc3cw?=
 =?utf-8?B?cFh6K0QvandnNDRGWi9nUzRDZ1FxU1lWUis1bGdaeU1oallrM3FCN1BuNFhL?=
 =?utf-8?B?SlZtLzJ2K1oySG1WNXpLQUMwbkRKV2hUOFEwTUIza05hRCtPVTNpSzZlQUxB?=
 =?utf-8?B?bzRBbjJEM0F2Z1BNSmZtcFk5c3RSTDZPZ0V6VzJkbTNWVjJtS3JSS0o4UVR0?=
 =?utf-8?B?YTY3WTZYMTRaOE1SZGVVS3ZKRHpqbm1pWGRnUXQ1blJrM2tYRHAxNWVPZHc5?=
 =?utf-8?B?Q3c4OG8vVVF1Rm4vUUg1MlI3V1hTcGFuZVdtbFk0YjAya1RkY0hyZU41SlRJ?=
 =?utf-8?B?R3VSYzcxVEoxTGw3N05JOFBOLzhQQ0Z5ME5CNmZqanhoODZnNUQ3dG96Vm12?=
 =?utf-8?B?U0tNOGk3K09yb0FQc0x5bGs2aFMvZFhmak9FN2ZUcU9sejhFOWtXR2k2ZEVC?=
 =?utf-8?B?VWtQcVl2RFNsRjUzMlQ0ZU16TGszdFh0YUJZV1FPc2p0SkxWV2tyV2g3cUMw?=
 =?utf-8?B?b0R3dHh5ME41a3E0UmlucjNnemNiVmk2QVMwYWswaFkwYldrSHNZdE80S0Vv?=
 =?utf-8?Q?2OKU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfa2b03-8707-436d-d452-08dcfd06239b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 19:23:19.0424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+dDxNLlHek2M9MxKGsKmQQGhe8BFoxoh1UJP4hdYckWacucUdJRQSQLvNG2BBzW3WyEQ0wzG17cBFeL0BnEAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6886

Some system's IOMMU stream(master) ID bits(such as 6bits) less than
pci_device_id (16bit). It needs add hardware configuration to enable
pci_device_id to stream ID convert.

https://lore.kernel.org/imx/20240622173849.GA1432357@bhelgaas/
This ways use pcie bus notifier (like apple pci controller), when new PCIe
device added, bus notifier will call register specific callback to handle
look up table (LUT) configuration.

https://lore.kernel.org/imx/20240429150842.GC1709920-robh@kernel.org/
which parse dt's 'msi-map' and 'iommu-map' property to static config LUT
table (qcom use this way). This way is rejected by DT maintainer Rob.

Above ways can resolve LUT take or stream id out of usage the problem. If
there are not enough stream id resource, not error return, EP hardware
still issue DMA to do transfer, which may transfer to wrong possition.

Add enable(disable)_device() hook for bridge can return error when not
enough resource, and PCI device can't enabled.

Basicallly this version can match Bjorn's requirement:
1: simple, because it is rare that there are no LUT resource.
2: EP driver probe failure when no LUT, but lspci can see such device.

[    2.164415] nvme nvme0: pci function 0000:01:00.0
[    2.169142] pci 0000:00:00.0: Error enabling bridge (-1), continuing
[    2.175654] nvme 0000:01:00.0: probe with driver nvme failed with error -12

> lspci
0000:00:00.0 PCI bridge: Philips Semiconductors Device 0000
0000:01:00.0 Non-Volatile memory controller: Micron Technology Inc 2100AI NVMe SSD [Nitro] (rev 03)

To: Bjorn Helgaas <bhelgaas@google.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rob Herring <robh@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: imx@lists.linux.dev
Cc: Frank.li@nxp.com \
Cc: alyssa@rosenzweig.io \
Cc: bpf@vger.kernel.org \
Cc: broonie@kernel.org \
Cc: jgg@ziepe.ca \
Cc: joro@8bytes.org \
Cc: l.stach@pengutronix.de \
Cc: lgirdwood@gmail.com \
Cc: maz@kernel.org \
Cc: p.zabel@pengutronix.de \
Cc: robin.murphy@arm.com \
Cc: will@kernel.org \
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marc Zyngier <maz@kernel.org>

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v5:
- Add help function of pci_bridge_enable(disable)_device
- Because big change, removed Bjorn's review tags and have not
added
Marc Zyngier't review and test tags
- Fix pci-imx6.c according to Mani's feedback
- Link to v4: https://lore.kernel.org/r/20241101-imx95_lut-v4-0-0fdf9a2fe754@nxp.com

Changes in v4:
- Add Bjorn Helgaas review tag for patch1
- check 'target' value for patch2
- detail see each patches
- Link to v3: https://lore.kernel.org/r/20241024-imx95_lut-v3-0-7509c9bbab86@nxp.com

Changes in v3:
- disable_device when error happen
- use target for of_map_id
- Check if rid already in lut table when enable deviced
- Link to v2: https://lore.kernel.org/r/20240930-imx95_lut-v2-0-3b6467ba539a@nxp.com

Changes in v2:
- see each patch
- Link to v1: https://lore.kernel.org/r/20240926-imx95_lut-v1-0-d0c62087dbab@nxp.com

---
Frank Li (2):
      PCI: Add enable_device() and disable_device() callbacks for bridges
      PCI: imx6: Add IOMMU and ITS MSI support for i.MX95

 drivers/pci/controller/dwc/pci-imx6.c | 176 +++++++++++++++++++++++++++++++++-
 drivers/pci/pci.c                     |  36 ++++++-
 include/linux/pci.h                   |   2 +
 3 files changed, 212 insertions(+), 2 deletions(-)
---
base-commit: 06fb071a1aefbe4c6cc8fd41aacd0b9422361721
change-id: 20240926-imx95_lut-1c68222e0944

Best regards,
---
Frank Li <Frank.Li@nxp.com>


