Return-Path: <bpf+bounces-78256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E5BD066CA
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 23:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 751ED3013EF6
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 22:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC1F325723;
	Thu,  8 Jan 2026 22:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MZrgHpcE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dMIKyLdq"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0627B2EAD1B;
	Thu,  8 Jan 2026 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767911251; cv=fail; b=ofjqWeC3DPo7PxmIBk7dF7FcJjTZMUE0OG2zdimxX3t2qLffx29v+iKnj4UXcM4D/qjbO8XtKQ/+Je27E0nTcuV31CLfOt+GLoRc01V3W3CIjWUvjC6LnTV4b8OGGyHB8VqL0Ws04DgHN0EIjGStn7aSOJaxY6tFVDRGolOafQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767911251; c=relaxed/simple;
	bh=1MU0o8CnbN3T6rmc6DrVOm/MWLXKXik8CliVhDiA3UU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oOyfBen77skE/ag/9mWnnyCOOiKLTDQ5FNfGIPMeuHVIduZgg3cze3UVBf50VdPkx3lP6Q4eq6aVtsKYuYgcx9pCtwsNWaDbQgTzoeAlT6hoPFsjodhYvPa0nHGPAw3gVg4fmiyUXhB0RWaObDGgTddipwtq2ybRjAF49We053E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MZrgHpcE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dMIKyLdq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608MLQaO1564811;
	Thu, 8 Jan 2026 22:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Sxr9teDRmWLkCTgVzhtw7+qDDh9lX5koTr/JznDyuaU=; b=
	MZrgHpcEvrRglev0hMOBYiyykUkRUT5vdaU3tEytglOLUq9+mbZ2idh4mfNhNB2t
	QuEUilomLjdv/vOZUMYa6uHHkP/Arbh8AZVRfWPSiCYdaZy/JTjeRPZe/QAMD0Qy
	6GV6W35zB3c/9OdfVQqfwPLbOBq+CoYHRynnmWOkzMVWSIYrx/vkIei9Eo0C/d8n
	gMdnfaBw8qd/MTJ96wF8KGD/4dKE+M8A9YTdzaurBjGL3jpTnIqZueZK4mnryQyz
	EPhku5SaGhZwLKK8QdkywFvt0lTy7ufjL1CCiFsoHfDL6ookNSasZl64rywiTw4R
	kXlLh+GqPyhzdVlT7aEkbA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bjn9ur06s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 22:27:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 608M6g86020432;
	Thu, 8 Jan 2026 22:27:18 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013062.outbound.protection.outlook.com [40.107.201.62])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjnnrma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 22:27:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWTX8/2rC4vl6YtmBR4o0QJoK9eIrxfhyymw8ZeC01xNOn5SkI39vBVIEo9jClRefzsxkS8JJbSN+w+H/B8zV616XJhMBiVjgW3en6kRDfwF5SSPY+3atWhBUp4EO7egzqdWGCdMRi+r+JxwmqpHcyU4Foe3sOaqKsNpf5oU3cUGxkokXddDQY40U3ay7Ecy1QVlRDkiW/MK03lZvGSSve6A3OXR6JDsha4iNjIWckZSdtU99WZAUAbeMPztOUjTcKHP6T6LnejVUEZdq8yl35gMbRJLIkGnfMcZyvBDS253EQUDVD3xkwQOJ2NEPnKyH5vVLo3kilkflHevhnAl4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sxr9teDRmWLkCTgVzhtw7+qDDh9lX5koTr/JznDyuaU=;
 b=MzDOkzXsfX439gvEDwKIy11XcKYIGz4iAfAhgarpwrp5MoLO+aNDThBrLt2/hvzE5Z3or32W4VzSlVRu18VIUCiNchh8rGUa6ihpGrp+Pgo+TgjroiNxErbkn55r4su4w6Cv3weIs3p29amsRr7HWHPDam/fjix4vKjbL4gCsuAMa00wVRd7FGTY97VhJk92gB4/UDbBt6veSvX7jy/cmcXwVPIPB1aWZgujEnMGzpdzeZCVRYEyVkj0fZd/rjty8pgcPniAHa22a9l9MQtH0WrnWkJVFRnKwgTsS4kS28vFuAslYKuflhs0Hk7lPNagLOs+LRqP/CFezttJ4g8d6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sxr9teDRmWLkCTgVzhtw7+qDDh9lX5koTr/JznDyuaU=;
 b=dMIKyLdq/ZhO+5GAgk00gAIJnAtU4T6qbfh5EwWwrSIfNi+oLRO+qZJV7L2HQ/QP4CKPLk9JZzKRLobdSaWIaVyikdo5UO0q5bRg/RKuPlHRrFAhX1ybKMtYZLtL+9pyV+t0+D/8gl7hiljp3kiG5WDkJvuC+yglSEGGGSLjTDM=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CH0PR10MB4955.namprd10.prod.outlook.com (2603:10b6:610:c2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.2; Thu, 8 Jan 2026 22:27:16 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Thu, 8 Jan 2026
 22:27:16 +0000
Message-ID: <0deddc46-2571-498d-9986-084fe69cad7e@oracle.com>
Date: Thu, 8 Jan 2026 22:27:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: kernel build failure when CONFIG_DEBUG_INFO_BTF and CONFIG_KCSAN
 are enabled
To: Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <olsajiri@gmail.com>,
        Nilay Shroff <nilay@linux.ibm.com>
Cc: Alan Adamson <alan.adamson@oracle.com>, bpf@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linux.ibm.com>
 <aSgz3h0Ywa6i3gKT@krava> <214308ce-763c-47a8-8719-70564b3ef49c@oracle.com>
 <f895a0ad-def6-4273-805c-40dc9d70bb20@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <f895a0ad-def6-4273-805c-40dc9d70bb20@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::13) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CH0PR10MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb9b415-f5c6-4040-3b9a-08de4f0513e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OU1FRXFzYjFqVVdic1hzZmFoVmpoQ0R6M1MrMk0vSTNXcmJENlZqakxTN1Nz?=
 =?utf-8?B?T3lLc0RPcFJ5S1dtMGRPS3UxSVdwcXh1eWY1aW9ESUxFcW9XMTh4OWJJamcy?=
 =?utf-8?B?R2svUGdPR1h2TlNTOXE2b1hvNVVVTW81emZlSTAyOHhkS3A1dEJrZVJ0THZR?=
 =?utf-8?B?MWJvd3ZiSW5MOWdDK0V5TXVJbkFrTHhnc1g5bkN6aVp3cTFXWUQranBnZ25G?=
 =?utf-8?B?LzRVN09MSEp0MEpTUkFhcmNFTDlaODlZQ21LWnVTY2Yya2lEUlJwRExqS3dk?=
 =?utf-8?B?YlZWWkRGUXp0RmF3VExUQmkvSTMzMkl2ZnJ4eFdJdHFYa2dsY1I0bndXWU4z?=
 =?utf-8?B?c0J3MGNPeUpHNTN1TS9DUVdrS0Z4NEsvczlpWmtBaXZ3YlBoQlNXYzBRK3J2?=
 =?utf-8?B?L0FmRHZnYXA0Wm16Wi9iRlpEK0lYZmlQSWErYnJ5a0ptbG5kaURka2lkWFUw?=
 =?utf-8?B?TVhlbW9QUHhSMXlqZUNKclRFL0tvTnl0MDZYbm91MlRhRkZWZklmTVpQd2dp?=
 =?utf-8?B?QjcvUzZTdVE2MUVwRiswNEdlM2MwMnNGMmdKSHRHNml6RDQ0NDI4eGtycFJ6?=
 =?utf-8?B?bWlTMExDUG43K21hb3V4clArbk5wbmNTRXk5bFl2ZGRaYnRpcExUc3EreFZ2?=
 =?utf-8?B?MG16V2hZMFc2cG9wTFpMcEZlazhkOUhqcFRLTnRPb0c5TFVpT0w0b3pnSDBP?=
 =?utf-8?B?L1FHcnZqMHFVNkVCcC9uejNIR2xEN1pWaWpjOXc3dXM0QjQvTjl3VXo0bmFk?=
 =?utf-8?B?aHlLTGxSNGVLajJEZDVVOVJkVmFBVDR1V0hUTUpTeXhEekdwckFaQ2xNblZo?=
 =?utf-8?B?eVdhU3dTT001Q3ZvL0hidjdtTWg2ampPMnFocXUyTXJ0ZUNZZzN6ODdsTFdL?=
 =?utf-8?B?Vm5HeFUvS0tIbUU4ckZyajJrcE9IYjVhY0RqUGVrYURyMEoyVDRpR01nN24x?=
 =?utf-8?B?bEdsenZkSVlDaEh0d3pHZWw5NXh6bzFjU2Z3WGlqTUxFMWJkMlFndlA2ai9C?=
 =?utf-8?B?RTFGRmFPS3oveDhSb09DVHlMNVpPYXhnczBZZGgyMjFxZXEyT3NyM3FneGx2?=
 =?utf-8?B?L1lzQy9oRUZHcWtyL3NrZEhyWkNmV1lLRHgzemZWOVoxYUowcXBKV1ZuYStZ?=
 =?utf-8?B?K09zZE96NFhwSDAxZXhzQ2c5ZXkwRTh5QVo4ZW5DK3Q1L3lwY3M3WkJnNElv?=
 =?utf-8?B?YlR1elErZ1FFSG5oRXB2cFBycHpxbURnTWNYOTAxaisxWHYrK0ZKTXRERE81?=
 =?utf-8?B?T01HaVlUS3NVSlpHUkEvT0ZjclN4ZDcyd2hJTnZ3YWJVdU53OGR2ODUwSy9K?=
 =?utf-8?B?Z1RFSTFwWnJ5cnpEckJRR3BnSVNmaGNva1JESnArellUWmViMnhxbW5KdWxJ?=
 =?utf-8?B?VWY1anoyQlU0cWVEMkVTYVdCZHhGa1RIODhXalpZWnREdUZxeXVyUWNaZ090?=
 =?utf-8?B?WXBUa1drb1lvOTRCRmhPN3NGRENjQ3IwazNmRDJ2dGRXdTRWZEl6N2RkeDBx?=
 =?utf-8?B?ODduSUpqd05ET25IUnJkRDEvZnV3SFMxZ2NqQ1dqSUMyMWRYSVNSa3pVYlV4?=
 =?utf-8?B?eElqRDA1ZVVYS0dRVG1ZbllJdGt6UmJjeWpEaXVaaFhFVnVxZ2NIOThtRFNj?=
 =?utf-8?B?WjJIZ2VucTV6c3FLRjFUdHpxQTJuQlRCeXZoeDBmbFJmT0hJdWpvSTVoOEdR?=
 =?utf-8?B?QTcvdmx6Ym5XTlZPTkJWOE9pYmtlclNkK2t5V0ZMTVJYZnp6OG56Z3pwSjFR?=
 =?utf-8?B?Y0VDTXZpRWU4ZHNaWmVYYm8xR1FjRlVoOS9TbGc4aWlVNGpWbnplTlZTNU56?=
 =?utf-8?B?cXI4L1NZU2dDdUIvUytVL1k3bjZOT3BQYnRwSUs5b25IcTdlMDNpT0pPQ2pE?=
 =?utf-8?B?L1JJZjYyYWc1dXI5alg1TDBYODJNSXQ4cVJzbnlPckxIV2I2dkg0a1FpNE1I?=
 =?utf-8?B?YXVXT3R4NUFISldVSnVXTXdvelQ1YXlOWTVTbUpzUmQ1amxIZUVFOGhNa09n?=
 =?utf-8?B?U2hueUVObzFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3hwQlB1S1ZvNmJVQ1l3U3N3Vmx2Zm9hQytoU01MdmFEWWw4VWdRWXZERlhV?=
 =?utf-8?B?TER3UU5hT2ZaR3lzRzJIODY0UzZnY2dZeEtpN21SWGRwVEZFNTR6bDhSNFZF?=
 =?utf-8?B?NjdkSzZlVVlvN0JJWi9nRCtyMFJDOU1TK01LckpNdy92UVhTUzhkM1M5VFF0?=
 =?utf-8?B?Sm5qNUowQ1pHVlhWT2pSeGp2S045YUtNTXkyWVpQUFRVR0U2akhpT0wrTWw3?=
 =?utf-8?B?L2RkazM1UkxIaTZXbmE2SHZOc3JZaElYY2Z1V0xweXR5aGJZWUFzNVQrVTRy?=
 =?utf-8?B?UEFVSHViMFA0L2tkWTF1ZUVPc3Bwb1dXeHQ0MjVRRlE2ZVlzUk9QRG9QYmJL?=
 =?utf-8?B?NUkwOE5DSWJsZzJMa05GS2RweVVoaTUvdHEyUkZmYU1mb1hnTGU2a0o5MExv?=
 =?utf-8?B?NllTd2Y2TXhlMnd3UHh5cDVaNEx6OFBqeStSMHBnTlNDRS8yQkwzcmNiMThi?=
 =?utf-8?B?cUVCTDFLNzR3UTJ6SWJsRUM2WVYwL0RqdHN5UklMWVNaU3RNaU1tY0lzQWNp?=
 =?utf-8?B?YmJ0WXNjMi8yclFtZU5wTklkbkFNODVuOXlNT3RUZTFXVnpyT3VzcUZzdWM2?=
 =?utf-8?B?OVZ0SmtReERnaDdyUW11cmFranBTdVNHdlBDdW9CdHVGOFhDeHJBVmdhcEJj?=
 =?utf-8?B?OGg5cDZKR29BNjZmUmRhVHpuVytaUXhyaTNCMHJkVXhZWnNUOHh0VGY4TmVl?=
 =?utf-8?B?RlBOeWY3UG9QN3kvV09uK3pzZGY2Y09uWXdIclYvL0RNNlQxUGJkWDYra1Rt?=
 =?utf-8?B?a2RlaUtlUHhWQitMMWZaRGxlRHhnemx1QzMyN0k0S2RLU2UvUFhBOTZHekVZ?=
 =?utf-8?B?cUNQQUJJRjBxNjZvT3g2aGM3enk4cWxYRVFqYjB5Nzh2RnBHZEtGeGNQSmJD?=
 =?utf-8?B?S0p2KzNCVUFLdWU4QXNIT2hLbnBJYithRnpNVEpXMndBYzZZY3JtZDFmb2FU?=
 =?utf-8?B?V0lyMGNWRGcvS0xZVkIxV3Q0aWhOdGFDejBjZUFlQVpnUERkR0ZKeS9aMFEx?=
 =?utf-8?B?b0h5WVptd0RONVAyN1hVbzMrL3FtbEZjNC9ZMTBGbmM4NmoxUWh5c2xkV2Vu?=
 =?utf-8?B?eDBMOUE3UnNGREJtRnV3MisxT091VldiV0NRL3VCQjNoei9TKzE4MitXYUxZ?=
 =?utf-8?B?NHdXWFlVMG5ZVlA5TnVOeXIyNURLS2lwbzM1TnZVZ1BXZGVDTmlxdXNYaHhz?=
 =?utf-8?B?UWhXdWdVZzZnWm42S1krWkZLTFJ0QTJhTFZ1aGpUVXBtTzNwQUFPMHdrWkVH?=
 =?utf-8?B?c0hZNnRySm4xaVJxazJsUjB0Y1ZoWjhMYkxhMFMwSEZrUEF5cHRveGd0dHpm?=
 =?utf-8?B?bWdkTXNSS0IwL2pWajJ6LzJDbFdROUh3WWRib2pkSzZ1c0daS2gvak5rVUwr?=
 =?utf-8?B?TEZvd3piZncwNTNrSWFaU0lFSlNOejh0Q3BPSS9xZTdMNG96MkhHLytUODFp?=
 =?utf-8?B?SnZTTW95WE51M0hYMXZtUjdscFhxcXdabzcxK0lkcEJjREtZd0lRRzZOT3lF?=
 =?utf-8?B?NEs4VmhteTA4WWdmMnBOUXF3L3FSWXJRZnlsM3p6blZyNGo0US9RamFLeFJ4?=
 =?utf-8?B?alJzR1J2WllGQ1BJencwTSsyZi9RVSt0NFZJTzVVMWZXRVQwMVFrWHJOMDdG?=
 =?utf-8?B?cHVjVjMzeGx6NXZlTWZGZU9ocVhOdkxYcFRBSG1FdGpZNDMzNVhnMkp5eDJR?=
 =?utf-8?B?UysvTnU0TENBZk9SQk9Tb3VhQmFZeSs1TS90ZUJlV1FEODV4SCtOYUhPd3VZ?=
 =?utf-8?B?dW55eU9ieC8xRlJldi9JQmtxK1RFZnI2cnZaSG1JNlk1enlLTnpNa3hWL0Ry?=
 =?utf-8?B?ZkFHd1RYcWNicmhwR0NjR0toNW9vQTF2REM5elJNQzNzb2dyNnl4c2swWlRK?=
 =?utf-8?B?UWFmS0dCakZxNkVoYVBsa3lUVDA5bWF1UjNWOW8ybGN1MzRKRXRFRFV6QjFL?=
 =?utf-8?B?elZtQTZDV2RjRS83RDdLQlpkZGJoWGkzRlhnTUtERzNOL0NDdVUyQVVXRzI3?=
 =?utf-8?B?Zi9zWjNxWkJqN211em9aY0ExKzlhZ3dZa0ZhTXZvNENWTkZIL0haSXFaNEw5?=
 =?utf-8?B?eGRLbEFjN0RJUXVDT3hkeUFlZXdQUGlOSkxmQzhZcE5zS096ZG5HU0p2US9v?=
 =?utf-8?B?Rm1QTWkrRUNGaE41ZE4zWS9rMXZIVVdFOGVjNXlSdjRMeWlTdjlRK2QxYkZr?=
 =?utf-8?B?K0JJcFpObllQM1FKVnFscVR2L0J1bDJ4UDdPMXhCMENIdTNmU0FncVFRZjVr?=
 =?utf-8?B?RndLclMxNm1KVk8veUVuUlhjRmsvTnRneXV2Qm5ELzliTm1FUnhFR0NSTmNm?=
 =?utf-8?B?UjRGMEJkdFUrWE5tSlViOExGeFFxYkYvMkw2QXNCWWRZMmZ2czdWUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vjzl62gt+eyy4BD7iQ42GaxQDUGGhJ/8mM6QZzLNhXU9EFbItroMsVtgTlzFiOgGsW3iBFHjlkhE3XaRbXjrYo/JxCYvidb2k5vlfnYQorr3qVrbjZDxh9QUIAAglF8FgcGwW2WEwYNtWAI4Tx9IC6xKQso5kcE5LRFK5WyXl4MCOTwfHfqLifaSG0pspJgCOUKAFkCmdh5sPGAsUeTyB+9JO+Lp6DPRe/0GNJYNZ5F7G2/WhOsspFzD0AfirBdFcl0EnC5L3InqQyEeJ4bjwDhG0pmfTGzbpRPWnG8s1gLKleIgdGWWgw2HEooqEmJQlgsBawvOe52vgjhGjBOtKlubILhKKgBotT9pDeFjAvcjWb1CLjx6nEhGYiDqsq8u/kqCw2o4gmpma65gFwqqNZfFUpqAbd2zq02h4C7EMifzqFMqtpPRNWq9L4sGwc8FT5xDYAgUI9sF5Zc68o/FnSVWWRfTRJPyuRIXamOiDpda4uq7GI+Je6+ILWKEOxvPoARCgYF0Q8gI5489qo7iFjILFebkg30mYqd9ENdeQ0Z432IeIyOsBbz2vXKT1qlDLadXjeCQ2W++joVeO7glZAHOrBeH+gasV7Ae451DHOA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb9b415-f5c6-4040-3b9a-08de4f0513e5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 22:27:16.1834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8kBYESy4Da7LUWF/KQeLPfzDSKMgijox1+suO79EvCc8aQg9vX5SYQK7VGtVnZRVYABBkuhCy+8EUQygp5Llg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4955
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601080169
X-Authority-Analysis: v=2.4 cv=YL2SCBGx c=1 sm=1 tr=0 ts=69602f47 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=dyRerlrsIYKZr8SAcIwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: uXx6zaY1eHMhLgcNrxBL164WXdbHAtFn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDE3MCBTYWx0ZWRfXxeTfzd/rz0cv
 6fEC89ZHahJfoRkHVbq5aToManJx12D1UC25J9RrFvZQLBtZzAG2ITsmmeAx5pqhzTVVOxwf9ay
 QmWHuw/HbaPyRnI9fod6CzqE0WDU+DrE2HRhBmFnJ2Ww+2kt1I07v7JwG6Ij/EoGZTZvgbWlQpd
 L9dge7CudsDUbM7oRFO/7zPQ9UvzC/z4EevQ0f+KcubR76GZe4ez8wa8lAcxVAT2jyKssLGrsbW
 Mh9HVLK7nJym+2crCOGzJ8pwURjw4MVJb3guzHF9U3KMuj0MDZZKDPUQ6T5/8YDeHRCJa5um19j
 QoBuIJh9McfNEkLMSWYdR2bg/+dYci6PaoX86aufkO4tcyo5ZuXADBfixJfnmKThIytJG6NWQgt
 Q0PpeEuk98+q7UQukXYB3w0CJWzNQoYFRRqQ7f3w/PNF+UpQaI8DKFyXf7qlpvR2NLLAZinx3B0
 haOQJ9vhxvaNEkjrv1gFwoMo3GU6GC7bP7jhi5eg=
X-Proofpoint-GUID: uXx6zaY1eHMhLgcNrxBL164WXdbHAtFn

On 08/01/2026 21:50, Yonghong Song wrote:
> 
> 
> On 11/27/25 7:36 AM, Alan Maguire wrote:
>> On 27/11/2025 11:19, Jiri Olsa wrote:
>>> On Wed, Nov 26, 2025 at 03:59:28PM +0530, Nilay Shroff wrote:
>>>> Hi,
>>>>
>>>> I am encountering the following build failures when compiling the kernel source checked out
>>>> from the for-6.19/block branch [1]:
>>>>
>>>>    KSYMS   .tmp_vmlinux2.kallsyms.S
>>>>    AS      .tmp_vmlinux2.kallsyms.o
>>>>    LD      vmlinux.unstripped
>>>>    BTFIDS  vmlinux.unstripped
>>>> WARN: multiple IDs found for 'task_struct': 110, 3046 - using 110
>>>> WARN: multiple IDs found for 'module': 170, 3055 - using 170
>>>> WARN: multiple IDs found for 'file': 697, 3130 - using 697
>>>> WARN: multiple IDs found for 'vm_area_struct': 714, 3140 - using 714
>>>> WARN: multiple IDs found for 'seq_file': 1060, 3167 - using 1060
>>>> WARN: multiple IDs found for 'cgroup': 2355, 3304 - using 2355
>>>> WARN: multiple IDs found for 'inode': 553, 3339 - using 553
>>>> WARN: multiple IDs found for 'path': 586, 3369 - using 586
>>>> WARN: multiple IDs found for 'bpf_prog': 2565, 3640 - using 2565
>>>> WARN: multiple IDs found for 'bpf_map': 2657, 3837 - using 2657
>>>> WARN: multiple IDs found for 'bpf_link': 2849, 3965 - using 2849
>>>> [...]
>>>> make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
>>>> make[2]: *** Deleting file 'vmlinux.unstripped'
>>>> make[1]: *** [/home/src/linux/Makefile:1242: vmlinux] Error 2
>>>> make: *** [Makefile:248: __sub-make] Error 2
>>>>
>>>>
>>>> The build failure appears after commit 42adb2d4ef24 (“fs: Add the __data_racy annotation
>>>> to backing_dev_info.ra_pages”) and commit 935a20d1bebf (“block: Remove queue freezing
>>>> from several sysfs store callbacks”). However, the root cause does not seem to be specific
>>> yep, looks like __data_racy macro that adds 'volatile' to struct member is causing
>>> the mismatch during deduplication
>>>
>>> when you enable KCSAN some objects may opt out from it (via KCSAN_SANITIZE := n or
>>> such) and they will be compiled without __SANITIZE_THREAD__ macro defined which means
>>> __data_racy will be empty .. and we will get 2 versions of 'struct backing_dev_info'
>>> which cascades up to the task_struct and others
>>>
>>> not sure what's the best solution in here.. could we ignore volatile for
>>> the field in the struct during deduplication?
>>>
>> Yeah, it seems like a slightly looser form of equivalence matching might be needed.
>> The following libbpf change ignores modifiers in type equivalence comparison and
>> resolves the issue for me. It might be too big a hammer though, what do folks think?
>>
>>  From 160fb6610d75d3cdc38a9729cc17875a302a7189 Mon Sep 17 00:00:00 2001
>> From: Alan Maguire <alan.maguire@oracle.com>
>> Date: Thu, 27 Nov 2025 15:22:04 +0000
>> Subject: [RFC bpf-next] libbpf: BTF dedup should ignore modifiers in type
>>   equivalence checks
>>
>> We see identical type problems in [1] as a result of an occasionally
>> applied volatile modifier to kernel data structures. Such things can
>> result from different header include patterns, explicit Makefile
>> rules etc.  As a result consider types with modifiers (const, volatile,
>> restrict, type tag) as equivalent for dedup equivalence testing purposes.
>>
>> [1] https://lore.kernel.org/bpf/42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linux.ibm.com/
>>
>> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>   tools/lib/bpf/btf.c | 27 +++++++++++++++++++++------
>>   1 file changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index e5003885bda8..384194a6cdae 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -4678,12 +4678,10 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>>       cand_kind = btf_kind(cand_type);
>>       canon_kind = btf_kind(canon_type);
>>   -    if (cand_type->name_off != canon_type->name_off)
>> -        return 0;
>> -
>>       /* FWD <--> STRUCT/UNION equivalence check, if enabled */
>> -    if ((cand_kind == BTF_KIND_FWD || canon_kind == BTF_KIND_FWD)
>> -        && cand_kind != canon_kind) {
>> +    if ((cand_kind == BTF_KIND_FWD || canon_kind == BTF_KIND_FWD) &&
>> +        cand_type->name_off == canon_type->name_off &&
>> +        cand_kind != canon_kind) {
>>           __u16 real_kind;
>>           __u16 fwd_kind;
>>   @@ -4700,7 +4698,24 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>>           return fwd_kind == real_kind;
>>       }
>>   -    if (cand_kind != canon_kind)
>> +    /*
>> +     * Types are considered equivalent if modifiers (const, volatile,
>> +     * restrict, type tag) are present for one but not the other.
>> +     */
>> +    if (cand_kind != canon_kind) {
>> +        __u32 next_cand_id = cand_id;
>> +        __u32 next_canon_id = canon_id;
>> +
>> +        if (btf_is_mod(cand_type))
>> +            next_cand_id = cand_type->type;
>> +        if (btf_is_mod(canon_type))
>> +            next_canon_id = canon_type->type;
>> +        if (cand_id == next_cand_id && canon_id == next_canon_id)
>> +            return 0;
>> +        return btf_dedup_is_equiv(d, next_cand_id, next_canon_id);
>> +    }
>> +
>> +    if (cand_type->name_off != canon_type->name_off)
>>           return 0;
>>         switch (cand_kind) {
> 
> Thanks Alan. I can confirm that this fixed clang build issue as well.
> 
> As I mentioned earlier, the clang based kernel build will hang with both
> CONFIG_DEBUG_INFO_BTF and CONFIG_KCSAN enabled. I did a little bit
> debugging and found the repeated logs for the following code (btf.c)
> during dedup.
> 
>                                 if (cand_type->name_off) {
>                                         pr_debug("%s '%s' size=%d vlen=%d cand_id[%u] canon_id[%u] shallow-equal but not equiv for field#%d '%s': %d\n",
>                                                  cand_kind == BTF_KIND_STRUCT ? "STRUCT" : "UNION",
>                                                  btf__name_by_offset(d->btf, cand_type->name_off),
>                                                  cand_type->size, vlen, cand_id, canon_id, i,
>                                                  btf__name_by_offset(d->btf, cand_m->name_off), eq);
>                                 }
> 
> The following are some of logs:
> 
> ...
> libbpf: STRUCT 'static_call_key' size=16 vlen=2 cand_id[2719764] canon_id[1005933] shallow-equal but not equiv for field#1 '': 0
> libbpf: STRUCT 'tracepoint' size=72 vlen=8 cand_id[2719744] canon_id[1005913] shallow-equal but not equiv for field#2 'static_call_key': 0
> libbpf: STRUCT 'bpf_raw_event_map' size=32 vlen=4 cand_id[2722229] canon_id[1008430] shallow-equal but not equiv for field#0 'tp': 0
> ...
> libbpf: STRUCT 'static_call_key' size=16 vlen=2 cand_id[2719764] canon_id[1005933] shallow-equal but not equiv for field#1 '': 0
> libbpf: STRUCT 'tracepoint' size=72 vlen=8 cand_id[2719744] canon_id[1005913] shallow-equal but not equiv for field#2 'static_call_key': 0
> libbpf: STRUCT 'bpf_raw_event_map' size=32 vlen=4 cand_id[2722229] canon_id[1008430] shallow-equal but not equiv for field#0 'tp': 0
> ...
> libbpf: STRUCT 'static_call_key' size=16 vlen=2 cand_id[2719764] canon_id[1005933] shallow-equal but not equiv for field#1 '': 0
> libbpf: STRUCT 'tracepoint' size=72 vlen=8 cand_id[2719744] canon_id[1005913] shallow-equal but not equiv for field#2 'static_call_key': 0
> libbpf: STRUCT 'bpf_raw_event_map' size=32 vlen=4 cand_id[2722229] canon_id[1008430] shallow-equal but not equiv for field#0 'tp': 0
> ...
> 
> and looks they caused the infinite recursion.
> 
> Anyway, you above patch fixed the problem. Thanks!
> 

Thanks for the additional info; I'll try and repro the issue for clang. In terms
of the fix, the part I'm worried about is type tags; specifically if we end up
choosing the type without the type tag as the canonical type that ends up in
the deduplicated BTF we'd potentially end up losing critical info in the final
BTF representation. So I might tweak it slightly to eliminate type tag skipping; 
that shouldn't effect the resolution of this specific issue as far as I can see,
and it would be a bit less risky I think. 

I'll retest and send it out tomorrow all going well. Thanks!

Alan

