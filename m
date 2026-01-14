Return-Path: <bpf+bounces-78939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D34D2062D
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 18:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1115C308BD6F
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 16:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C123A784D;
	Wed, 14 Jan 2026 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FnRvKk20";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TNk3keNy"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90FB3A7DFE;
	Wed, 14 Jan 2026 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409813; cv=fail; b=eiO1s/bU1WC3zGK363e2YIHRaxJssLcuLPWurFRfvl734+A8ON+EJBwyJCwp46H9Jhj11RYgp8biNNimdgy+BnSjx2hQ30amjAi9lMgGr8BvIbMYuag5swrNgin/xOIfVauEKCaoKs4rBkdukZxm/uxXPZtzktCCBgylXkPeMrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409813; c=relaxed/simple;
	bh=oqDg5qEyqVNCcfOLztpqyNVQPLPgowpSnX+5Ngcebcc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ojsEZFw0UVsT9Ph+7A0uII4dQfSq5u2OS8Lol1xTb2ytG5Pl9nSo0xQa5GxYGnrd2BwGYuoo2QGljOgNWj2vmnslsYd9q4mLuCZ9h+n6wzHLmB6WLoXeYGIGWSX0ErFiN7/otScsLkSaaVQiXLt4b2tiv3kVWkUrX+74ZiW5wPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FnRvKk20; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TNk3keNy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E6RApC1361981;
	Wed, 14 Jan 2026 16:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=f6C/IGd80Iauktmf/6jG9BkaThKTerxShDj77qybMI4=; b=
	FnRvKk20CyCcnDcj4mp+u+rWK3n3zLtGLgkalTXjkP+8vVQ17rDJLPjJFnHomVB2
	R2qQdTznnhZA0KBEf+67VLi6JFOy2OfY9gd4tN0XJhP5pK0UCu1tp5BlTxA2idXm
	82hzIvlM2BZE3OsM9C4ANXp2Fnz/fVgpaKrke3BKOBbvlasGJVX1pakfbAtQU83i
	ARIMtA5ftkThHmeZ81tMb5cu4zBZzsfSWAadfHLTkZRi1lEEqoAc4gP8kYv3TSiB
	R+FALhZnjPeG5OMCdDsLiqSq6qgyIgctVw09n6VF09kIhzya51/UtXUwk0b5dyrY
	at87+SqY3Wqg6AZ/V9aqDg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5vp0u19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 16:55:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60EFF0Yd039278;
	Wed, 14 Jan 2026 16:55:40 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010054.outbound.protection.outlook.com [52.101.193.54])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7e1tw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 16:55:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGEtFoVGSAGeVkDmEDWcNcVEa8Rq756PpUHjd+hisRc3zp8rPsHCVL3Ll09xIG+/i+rcJo4dFq5eFbuIuzq7pwAlYiBJu+Bv3oIVjwDRnvid7fx5TEOSp+p61aiX9DkuJTnX7QzDiGw6+0EVqM7lGXiFWH8jVNYK8L3apK7/dYPwK66HvBKg72x3wPCHu5qSBLKThztIcqHFLw6vK7sqWJ3sCdV/WRLR1SE2t0ygqsudOZOKVUO/7fDFce71m5X2WTQW63iUceVzc+PY2DIP52r9qaX2xcUr9hyayu/FCiNZQ4V4G/wrldhZlp8Yl55IplubmtlcEeV54gTaPCC9SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6C/IGd80Iauktmf/6jG9BkaThKTerxShDj77qybMI4=;
 b=Fw0DPKBz51DrDGsDuTzJ836h0Zb+obO7//EMSU1aBs2g+7LgKqeXM1i53Ya1X/KFv9sfOCGCyTwUtNijIVU2Xjm7rFyXG4NVfxoL/y9/6+ZHTBER1J3XCRJCN9eZkkM9ubAOxP+CoM7muSA5rCmAlGR4WOlPh3PKn7Bh/AYFf8AyD4kWiPG3mkWubA7hlkXYBUn1Nt8doYpKV4u0unjIpalG94BV1oxsSpq4/K67rVt7FOPGe4vQrnBuDSc9k6r7mpBIm/jOzLnv4qXdO9XmM5dsMU1X52Ek5m5Nqubn6tzPO4Hi/dUTizFfA06s0+qQHNuGdmbGk9BFQcPmx7kX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6C/IGd80Iauktmf/6jG9BkaThKTerxShDj77qybMI4=;
 b=TNk3keNycKbVvUWBt1FXf/1+NGZxFLQrHbQPrw/3DbLDxg2QTQ1yv2BdLOtgLRnZV2WkwIhpXsWOVFA6TFapd9u3RAQphGIoc7pLnZl+kmqO74o131iIt7uWdc+ck15vSzowevMxDzLJyu6STlWgpUj4MdwdmCqxOYbVzR1Hdvk=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SJ0PR10MB6399.namprd10.prod.outlook.com (2603:10b6:a03:44b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:55:36 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Wed, 14 Jan 2026
 16:55:36 +0000
Message-ID: <0486f774-6e09-483f-8e25-0e440eff1234@oracle.com>
Date: Wed, 14 Jan 2026 16:55:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 3/4] btf_encoder: Add true_signature feature
 support for "."-suffixed functions
To: Yonghong Song <yonghong.song@linux.dev>, mattbobrowski@google.com
Cc: eddyz87@gmail.com, ihor.solodrai@linux.dev, jolsa@kernel.org,
        andrii@kernel.org, ast@kernel.org, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        David Faust <david.faust@oracle.com>
References: <20260113131352.2395024-1-alan.maguire@oracle.com>
 <20260113131352.2395024-4-alan.maguire@oracle.com>
 <79fac2fa-b5f8-4a7e-aafb-5b80d596db34@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <79fac2fa-b5f8-4a7e-aafb-5b80d596db34@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0029.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::16) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SJ0PR10MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: dede6697-ad77-4782-0d27-08de538dbd10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0tVdU5aRGE2aFRKbXpSZVRIV3BMNkRTK1NZUiswNEZaUEV4UW4zT1JaNk1V?=
 =?utf-8?B?S3Q2TlUxVWo2ZWpDM01udTFxbnVnVW1ZeXhBdVB5ZDg1SjNza24zSys0aDJk?=
 =?utf-8?B?VFdWckViMHVpdklrbjR3ZkR2QmVUcndndVEvRFZFTVNSUDNiVEdoMWtJNHpl?=
 =?utf-8?B?aDRsNWI0b3dDM05GeVBMMWIyM0s5K2NJSUJMT0NJQ0JHMXZwT0VPdHhsVHY4?=
 =?utf-8?B?eWkxNi9KbFBYUzdweEhrVG5HTTFPSTB5VkZTc0ZQcXhBdTVoWk1la3EyRkNC?=
 =?utf-8?B?aU5la2NTTjVTczg5S0xZRHJ5Y3pYREJpZVZER25MZ3AwME1PMUpRNmtlbE9j?=
 =?utf-8?B?WkVxenJTOEl6T0tVYmluRTQrR2hCaUswQmxjcXFqTm1uakZTVHpDUWx3UWNE?=
 =?utf-8?B?ZG5aYmVVd3NaUkxtUWFHajY3c3VqZ2NBd3pZSjBkUGNYSDVZVFBMcFFpeG5H?=
 =?utf-8?B?NDR4OUxhZGJUSnY0ckQzVnVLMTAzeDR1K2Y2NWQ4eUNOWUNzZzdYNEpZSTVG?=
 =?utf-8?B?OGNQNWN5aVQ3S1hvajdsVFFKVC9oVS9BZDdOQ2d3NGNXaXlwZHNxNFFTNERQ?=
 =?utf-8?B?L01aYjBWOGsxZmdMRFYrUnNCaklUdEUxajZyVFU3S0wrTkkxVjVkeHpUSzRW?=
 =?utf-8?B?RFQrRDdRR2Vta3RXM1pKNmN3aXFUMmZ5R0IyWjBWT2gycHVlWUtoL2N3UjdW?=
 =?utf-8?B?dXB2RU1zelUwMTJXNlV6bXFMcVA3SERTNWRvU3JLTTZ0L2QvWHowaGlsWG41?=
 =?utf-8?B?SjFhZ1F1dFF6T21BckR6TTBZWmVyN3NVTFJCclBsTlpkdmF4VzBqaWJhdjlH?=
 =?utf-8?B?Sy8yTlgyeWFZRGZpUjBNN1MyaFY3RFhlbHU1NURhUTh1MFFDM0NTK21LT2Y4?=
 =?utf-8?B?UFZ2NTdrZ2xhVStTUkVqSjk4TGd3NEFaYkhhZysrRWovOXJUV2tVby9WNUsr?=
 =?utf-8?B?ekFYN2NOazBYRDR0bDlKbE1QYjJlK0xoSzhweFBSNnlTK0tIUC9xb3dVUmw3?=
 =?utf-8?B?ZWUvQUkvN2VXRis3Q2JUY0pBMWk3VkhsVkVXTzRUWjV2dzJUTFduazZ4c1U2?=
 =?utf-8?B?K2RNY1dwMVQ0Z0VsdDB6QktTc3VkVlNSc3JSNUUyaHJ4VmRvWHpsZlRhdWgx?=
 =?utf-8?B?U3FIbUhWOWlaUWp4VUlNTlBDb3AxcEhWRzN2NmZ6OGtkcDhqdXZWUVhrYlhi?=
 =?utf-8?B?Z0hWckxGaE1kNFlMVm1YWG1nUzFTME5PWkYvQXVvVWJJNDNXSXUyZ24wN01T?=
 =?utf-8?B?OUY4c2FJcVZUcmUvdEJ1WWZMd05PeDJTM1Mzd29zMk9ac1FFbnBhbGJVL08z?=
 =?utf-8?B?TTBCMGYrVFcwSU8zbUFOVWVIdVBUaGhzOFFmRjNKT08vTnhKZUQwM1k2anl2?=
 =?utf-8?B?YXNiclhnUDNUd0JKWXFNK3RsMUk3QnNkQU94R0p1bFpNQTlVU2RmbEEzeElI?=
 =?utf-8?B?UWNqV212N3BsdWptY3dhTnE0VEM2SU1mWHpOcVNnWTNNTS9LQUVEdkJTeWZt?=
 =?utf-8?B?bkRXcUdTZnlkTUZYZkZobFE3NG9RKzhiZkdkcUZBallxS0ViNGVVVlNVem45?=
 =?utf-8?B?OGIxcmozcENlZmZjMzRBU3UwL2ZJcnQ2V2kyZTZObEtGMDVnZFBHRnQ4YmVG?=
 =?utf-8?B?TnRhdDNkZDVKdnJOdWtyQXBXZzhWUHdOczBFcklneHE1TTNjMUpPdzRDbDV1?=
 =?utf-8?B?dmhKbEN3eFJ4Q0pwd2czUTlUcDcvWVZaWWxWRkFMUGpaRHRwbGlSY0gwamF0?=
 =?utf-8?B?dWpESmFYY3RtMExFS2I3MUJzVTRKWGJyaG1vcmFka2VzRDBwYXF4VThiSjNU?=
 =?utf-8?B?UzJPSE85c0UzbGhHVUEwNFZNN0MzU1Bnam9xQkllc3BsY1grRTBPUnQ3ZVdy?=
 =?utf-8?B?UGNIZ0g5MGs1UmNXb29qTHdkZGVNU3FRaGZCMkFMNTBLTjJRMjJjcmQzSFhJ?=
 =?utf-8?B?ajFHaW0xcFllemluRFA2R0owZWM0QXNrcXUvTkZDN2JTbUE4VSt5MVQwZTc2?=
 =?utf-8?B?UlErTUNybTJ3dGxoUUhFWTcvUWVBNTA0TUtCOCsxVW9VcEZERi9oaS9DeDZV?=
 =?utf-8?B?QkJrbkpGTTFUY0RDUGNTMGE1MXBDcmZWZ015M3lnVjlrZmtFY3NmaU95RjBO?=
 =?utf-8?Q?SJHw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0RicGgrS1RuRmFOWFgzYkFwUUVGUENQcUppZ0F2a2lCbm1IY1FkakNxcXc3?=
 =?utf-8?B?UUxlWENJcjRIVk03ODdMdnB5UmN5L2Q3enFtcVFXTGFwdngzUEJCQis0YUs2?=
 =?utf-8?B?eVYxOXZpcWVET1VEL3dUOG5ORmppVWxQczQ3bUJqQVpPV29lRjJpNGNCUzBO?=
 =?utf-8?B?NWxpMHdpVk4zY1J6ZlVIdEE0TmUxbHlSYzlveVE0V3d3amRQTEp2M1lhV2FB?=
 =?utf-8?B?eTl5ek9XL1RtL0x0U2R3Q3pBeFBrZWl2SW80U2FHc0MrQmx2OUxaaDJhWFdl?=
 =?utf-8?B?VFNPdmE3L3NHV1AvRzlId0hMQWUxYm9kR1YwaE5sbzhBZXEyQ1g4bWlYYytj?=
 =?utf-8?B?dE9aVmQ5Y1loOXNqSFlmRzhJRDgrWWk0RXlEcXRJYXh4WGUxbFp1MXZjZnQz?=
 =?utf-8?B?N000YzhFeU1qYXdXR1UydDFXVSs2RWFwZmNHeWN6YVdOUDNZTVp4K1NhdFRZ?=
 =?utf-8?B?WWlnTWhJNVFEbTlRSENuQUdMZEg3Qndyd3E0WTNRd05PYUFubzdTQzRYc1Bv?=
 =?utf-8?B?RWRHYno5ZmlaWkNQcVBYQUpPUGZVa1FYQUZDRmFKWUwxQktHek1QMFV2K0xX?=
 =?utf-8?B?NEJ0L0JmSW1jVTZkZVRpTnRoeXFHVGgzU2d5WmpCN05JWTBEcVFPT1V6dWhl?=
 =?utf-8?B?dWxSWlhhWTZKcnExSE5GWGQxeEJpRXNGZ3lzMXhOSzJEOVA4K0ZSVjlCWE43?=
 =?utf-8?B?dDJPeU0yRjdDZWNTb1JuOHkvUi8xZ3V2anFOTm85SG0wbW1EMFNYNEhrL2pq?=
 =?utf-8?B?Z05jV3RuRGZSMlRsVVZVeWFHTHRiVXV1eWpxbVFwdEoxNmhvQmJNdmNSbGdI?=
 =?utf-8?B?bWZYLy9iYVQ2WnhzZE1zOVlLZ2xaVExZZEQ2OSsweFRSZ3hpR3JzdzE2VFVZ?=
 =?utf-8?B?SG9XNWVQcXg1SGcrK3RiNWNKY0YzV2c2MVBCR0RVSVBVV1ozc2hwSjUzYXho?=
 =?utf-8?B?dUk5MTZOZjVZNHpsbnhESmM4ZUtvQndaT3M4WHhaTFNmWkJ4R2NFdE5CZC8z?=
 =?utf-8?B?eDUxUmJJaXpSVVFRci80US9EUGg4TUVtYXljQ3BmNUlQeUN0M2MxM0dQUTU0?=
 =?utf-8?B?cklSMlZYdDhibzFwQU04dDlOSEdPb0EwaGpGalVkYmwwZEIyWk5UV2hDeFJr?=
 =?utf-8?B?dVVHWldHckJnaFJQV0kzNTBsSCtzQ1NndHJRSnNrR0VFdXRKNkZwWWtyR2Rw?=
 =?utf-8?B?UGJUU0h1QllHOXVPYU9KQmt1Y0hVbitDOTJaT2VzSy9idUc5dVVzN1lKa3NX?=
 =?utf-8?B?dzkrcFN5bUtDbFBnTTgzQ3Q5YzdiRnFuKzQvYVB6WTM0Tmw5Q1FJZ29MRnB5?=
 =?utf-8?B?UW5LMWd2djBad3VIK0EvdXdCYTBGcWVOaXQ3SExxMnZlY2xrMUdMRzQwd0lN?=
 =?utf-8?B?cVpZclEwMGVGa1VoOURLcFJNMk95VXFhUEJSRnUvdTFQWTdQVmZQZDRPUGpM?=
 =?utf-8?B?bkkva0Rxdk1QV1lUcGpPQmdRY0VUYnlXNmpoM2F1bjl0Zy9EM0F3NFBhV1dQ?=
 =?utf-8?B?REhJN0RpalQxZHo4VDQ0RlBDb2czeER2MGlvbGlRNTNZSEl2UEIvMGFORlhM?=
 =?utf-8?B?dDJmcGs5S0JyUm14OVRlc3BEK05YdGVFdkVqZE5WVGMxN3dNMlhTYnUwNHVB?=
 =?utf-8?B?MEpZckw3M3R4MEVTb2VCYkk1ZEU2SUpHYVk0d3lMWWxtWGhkckdscHVIZkxH?=
 =?utf-8?B?Z1d6YmV1ZFFOSUk3a0ZMak5XMjJWSENtVjZJQnN5Z1dlWUNWK3B2alNNTkZz?=
 =?utf-8?B?YWJKV2djbVhLY2V1Z3MxSjQ4UnIrVG9lKzJvaVlqbkNEK2J3QWRWa0ptZ0Jw?=
 =?utf-8?B?TGRyRnFOQWk2Q3VzbS9DWm4xdm80RWhQanhnT0lucmJ2ZFF2aU96YXpZK3I1?=
 =?utf-8?B?RGFSNEF0elpGVVplMEhMTlBzRFhkSklyeVBrc1ZZWjJrcjJCL2lXVkdJZng4?=
 =?utf-8?B?YTJEZlFpYzdMSEp0WEtNemkrbEZyaW5vVVUzTHRoZ1dhUnluVThnN2hTMm96?=
 =?utf-8?B?ek1MKy9Rcm9oQUVCdnpiaXdMVm9TZFhrVjM4SGtmYkJ1MHB5VWxaT3dIOEhQ?=
 =?utf-8?B?TGp2dDdTMzJVSjBiMjBpOGJQL2YydHRYTXNtUjEwL3kvdXkvRytJeXExc3BS?=
 =?utf-8?B?YzFRUlRrbG1rQVBLRkptQTd5TE44VE10amJSUTZLM2JtZWFaZHdXRmdRWWtt?=
 =?utf-8?B?ekR0M1dpelcza2prbTYzOVpZRXNMNXZrRHZUMXN5ODQ1OXlSOUNaZFR5aEYx?=
 =?utf-8?B?OVd4NHkvMTFuZVEyblczOUVReDJBMlFGTWNrWUVma0NHeVJWd05wMnIwWWVY?=
 =?utf-8?B?cC9LSU1yeGpvUVZKYmVoT3QwUzd4MW5tZ2twTlhTd0dQNE1TY1ZNZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gI6egVeROUjlfG6H94vNQdASDyKboU283hSY3jkxAGuYejgcBBZaUPpg8jx8SWXrAAb4Romz0k+m1fc/r0vwwebJ9Zk7XQ0UAGntK5c3HRlsR56Cywmw8txTjAjB4AMrBXGbZgzTlck0dZpXuYkRxc7Ws8MfN2hlPqIBqNS7CTwl1dW+8XhctYYzDbQgkAyPixDiyt4YoAOtUUAlZ+yy+nzrbbWf92nsrU9EQU0h5PhFe4EaixNz2i5MkAb4l/qC5n2oBINnAw7sipJVE1RdhKfwSK4Ru98c+1bGzL5MNP5CUYzrvnlVntwynCE4jxLPrHQ2R01EnxTPA/CRLHDquid0rX66VB/i1D8ppVMWh8O3HqYBlHRVp4pWNt2ZP+etklELGNNuD/I6mvCzr+eYyCtrxrU2UQa6p4mMMu1HcHOZ6CsXgbPwUvEUAxZrIzYH7HOj3Gii0uwhCM0oiRr8oSs1PxXZAC4qfjPOb4Ynjh6YEUdswpH9DxqK9W6QjU8CLN5fTQYHpWaw6y1QBHRXIqhRaaHP2xPL4mgGdA/wdSHBXYn2Yf94odWelyL8W61B0d4TaNDVs+W1z08YoRGZBoQm2hU0rC+YLGmKNg/ilt4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dede6697-ad77-4782-0d27-08de538dbd10
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:55:36.2640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TF9PqK2GcVOqI1tbpBLNMWoWs80qaCSi76SeMpN38dWoORiB4o4geBRsbvQD5qLKwHjqS1yES0KKvkulnx/apw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_05,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601140142
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE0MiBTYWx0ZWRfX9MtROI5A3G2c
 x5+W5CTCg1/WZrzrr6CUkLfzkdP2SKzGa01vq9otlasDSWMN58sXhrBhRpo5Oipy5kiyDpVvCJq
 Ha34t1LdoqF0u0HhmfnkuwDE9Dmc4gyvd/MOCDxvC5eB0ZECRBGM/xr7mFu80G4GkmvGW/eXwla
 F4Y5xiybctgEjG2EDsLV1cx9mQViO/owO50m+N/TdKMwbxPal4iR5oT98B+Qx+KRjRIWsqmTgvL
 Go5zh3K3ac2gGqxRA9mS83Ab27toceOoc5mBn4Mz9Ti51VQOvDRWIkH9/iLjLm9zM0yu4BZFu7N
 dYNOZwULV7prmC7VA2VIH4d3JZVuE+OC59D9Uxz6GL/Mr4nqvwc/xaFI59f6XfKgZo6X3jMtLE+
 1FPbSCEILMfhJP/64+UV5BjMvW1D0c74x0dcVBE4LIGnl5dnyz6SiU8BkpcLa9VcqLt2Mju4TKU
 QF/e0icRWkptV/P8yHHHzdocAR6NVxH7QqvLHu3E=
X-Proofpoint-GUID: a4jhW1viFDaJ9dRXNx6FiEsk4P9Lnk3k
X-Authority-Analysis: v=2.4 cv=aZtsXBot c=1 sm=1 tr=0 ts=6967ca8d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=8Ue_EvT9psjrZuRCt4kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13654
X-Proofpoint-ORIG-GUID: a4jhW1viFDaJ9dRXNx6FiEsk4P9Lnk3k

On 14/01/2026 16:15, Yonghong Song wrote:
> 
> 
> On 1/13/26 5:13 AM, Alan Maguire wrote:
>> Currently we collate function information by name and add functions
>> provided there are no inconsistencies across various representations.
>>
>> For true_signature support - where we wish to add the real signature
>> of a function even if it differs from source level - we need to do
>> a few things:
>>
>> 1. For "."-suffixed functions, we need to match from DWARF->ELF;
>>     we can do this via the address associated with the function.
>>     In doing this, we can then be confident that the debug info
>>     for foo.isra.0 is the right info for the function at that
>>     address.
>>
>> 2. When adding saved functions we need to look for such cases
>>     and provided they do not violate other constraints around BTF
>>     representation - unexpected reg usage for function, uncertain
>>     parameter location or ambiguous address - we add them with
>>     their "."-suffixed name.  The latter can be used as a signal
>>     that the function is transformed from the original.
>>
>> Doing this adds 500 functions to BTF.  These are traceable with
>> their "."-suffix names and because we have excluded ambiguous
>> address cases we know exactly which function address they refer
>> to.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>   btf_encoder.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++-----
>>   dwarves.h     |  1 +
>>   pahole.c      |  1 +
>>   3 files changed, 68 insertions(+), 7 deletions(-)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 5bc61cb..01fd469 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -77,9 +77,16 @@ struct btf_encoder_func_annot {
>>       int16_t component_idx;
>>   };
>>   +struct elf_function_sym {
>> +    const char *name;
>> +    uint64_t addr;
>> +};
>> +
>>   /* state used to do later encoding of saved functions */
>>   struct btf_encoder_func_state {
>>       struct elf_function *elf;
>> +    struct elf_function_sym *sym;
>> +    uint64_t addr;
>>       uint32_t type_id_off;
>>       uint16_t nr_parms;
>>       uint16_t nr_annots;
>> @@ -94,11 +101,6 @@ struct btf_encoder_func_state {
>>       struct btf_encoder_func_annot *annots;
>>   };
>>   -struct elf_function_sym {
>> -    const char *name;
>> -    uint64_t addr;
>> -};
>> -
>>   struct elf_function {
>>       char        *name;
>>       struct elf_function_sym *syms;
>> @@ -145,7 +147,8 @@ struct btf_encoder {
>>                 skip_encoding_decl_tag,
>>                 tag_kfuncs,
>>                 gen_distilled_base,
>> -              encode_attributes;
>> +              encode_attributes,
>> +              true_signature;
>>       uint32_t      array_index_id;
>>       struct elf_secinfo *secinfo;
>>       size_t             seccnt;
>> @@ -1271,14 +1274,34 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>>               goto out;
>>           }
>>       }
>> +    if (encoder->true_signature && fn->lexblock.ip.addr) {
>> +        int i;
>> +
>> +        for (i = 0; i < func->sym_cnt; i++) {
>> +            if (fn->lexblock.ip.addr != func->syms[i].addr)
>> +                continue;
>> +            /* Only need to record address for '.'-suffixed
>> +             * functions, since we only currently need true
>> +             * signatures for them.
>> +             */
>> +            if (!strchr(func->syms[i].name, '.'))
>> +                continue;
>> +            state->sym = &func->syms[i];
>> +            break;
>> +        }
>> +    }
>>       state->inconsistent_proto = ftype->inconsistent_proto;
>>       state->unexpected_reg = ftype->unexpected_reg;
>>       state->optimized_parms = ftype->optimized_parms;
>>       state->uncertain_parm_loc = ftype->uncertain_parm_loc;
>>       state->reordered_parm = ftype->reordered_parm;
>>       ftype__for_each_parameter(ftype, param) {
>> -        const char *name = parameter__name(param) ?: "";
>> +        const char *name;
>>   +        /* No location info + reordered means optimized out. */
>> +        if (ftype->reordered_parm && !param->has_loc)
>> +            continue;
>> +        name = parameter__name(param) ?: "";
>>           str_off = btf__add_str(btf, name);
>>           if (str_off < 0) {
>>               err = str_off;
>> @@ -1367,6 +1390,9 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
>>         btf_fnproto_id = btf_encoder__add_func_proto_for_state(encoder, state);
>>       name = func->name;
>> +    if (encoder->true_signature && state->sym)
>> +        name = state->sym->name;
>> +
>>       if (btf_fnproto_id >= 0)
>>           btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id,
>>                                 name, false);
>> @@ -1509,6 +1535,38 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>>           while (j < nr_saved_fns && saved_functions_combine(encoder, &saved_fns[i], &saved_fns[j]) == 0)
>>               j++;
>>   +        /* Add true signatures for case where we have an exact
>> +         * symbol match by address from DWARF->ELF and have a
>> +         * "." suffixed name.
>> +         */
>> +        if (encoder->true_signature) {
>> +            int k;
>> +
>> +            for (k = i; k < nr_saved_fns; k++) {
>> +                struct btf_encoder_func_state *true_state = &saved_fns[k];
>> +
>> +                if (state->elf != true_state->elf)
>> +                    break;
>> +                if (!true_state->sym)
>> +                    continue;
>> +                /* Unexpected reg, uncertain parm loc and
>> +                 * ambiguous address mean we cannot trust fentry.
>> +                 */
>> +                if (true_state->unexpected_reg ||
>> +                    true_state->uncertain_parm_loc ||
>> +                    true_state->ambiguous_addr)
>> +                    continue;
>> +                err = btf_encoder__add_func(encoder, true_state);
>> +                if (err < 0)
>> +                    goto out;
>> +                break;
>> +            }
>> +        }
>> +
>> +        /* True symbol that was handled above; skip. */
>> +        if (state->sym)
>> +            continue;
>> +
>>           /* do not exclude functions with optimized-out parameters; they
>>            * may still be _called_ with the right parameter values, they
>>            * just do not _use_ them.  Only exclude functions with
>> @@ -2585,6 +2643,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>           encoder->tag_kfuncs     = conf_load->btf_decl_tag_kfuncs;
>>           encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
>>           encoder->encode_attributes = conf_load->btf_attributes;
>> +        encoder->true_signature = conf_load->true_signature;
>>           encoder->verbose     = verbose;
>>           encoder->has_index_type  = false;
>>           encoder->need_index_type = false;
>> diff --git a/dwarves.h b/dwarves.h
>> index 78bedf5..d7c6474 100644
>> --- a/dwarves.h
>> +++ b/dwarves.h
>> @@ -101,6 +101,7 @@ struct conf_load {
>>       bool            btf_decl_tag_kfuncs;
>>       bool            btf_gen_distilled_base;
>>       bool            btf_attributes;
>> +    bool            true_signature;
>>       uint8_t            hashtable_bits;
>>       uint8_t            max_hashtable_bits;
>>       uint16_t        kabi_prefix_len;
>> diff --git a/pahole.c b/pahole.c
>> index ef01e58..02a0d19 100644
>> --- a/pahole.c
>> +++ b/pahole.c
>> @@ -1234,6 +1234,7 @@ struct btf_feature {
>>       BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
>>       BTF_NON_DEFAULT_FEATURE_CHECK(attributes, btf_attributes, false,
>>                         attributes_check),
>> +    BTF_NON_DEFAULT_FEATURE(true_signature, true_signature, false),
>>   };
>>     #define BTF_MAX_FEATURE_STR    1024
> 
> Currently, in pahole, when checking whether signature has changed during
> optimization or not, we only check parameters.
> 
> But compiler optimization may optimize away return value and such
> information is not available in dwarf.
> 
> For example,
> 
> $ cat test.c
> #include <stdio.h>
> unsigned tar(int a);
> __attribute__((noinline)) static int foo(int a, int b)
> {
>   return tar(a) + tar(a + 1);
> }
> __attribute__((noinline)) int bar(int a)
> {
>   foo(a, 1);
>   return 0;
> }
> 
> In this particular case, the return value of foo() is actually not used
> and the compiler will optimize it away with returning void (at least
> for llvm).
> 
> $ /opt/rh/gcc-toolset-15/root/usr/bin/gcc -O2 -g -c test.c
> $ llvm-dwarfdump test.o
> ...
> 0x000000d9:   DW_TAG_subprogram
>                 DW_AT_name      ("foo")
>                 DW_AT_decl_file ("/home/yhs/tests/sig-change/deadret/test.c")
>                 DW_AT_decl_line (3)
>                 DW_AT_decl_column       (38)
>                 DW_AT_prototyped        (true)
>                 DW_AT_type      (0x0000005d "int")
>                 DW_AT_inline    (DW_INL_inlined)
>                 DW_AT_sibling   (0x000000fb)
>                                                                                                                     0x000000ea:     DW_TAG_formal_parameter
>                   DW_AT_name    ("a")
>                   DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadret/test.c")
>                   DW_AT_decl_line       (3)
>                   DW_AT_decl_column     (46)
>                   DW_AT_type    (0x0000005d "int")
>                                                                                                                     0x000000f2:     DW_TAG_formal_parameter
>                   DW_AT_name    ("b")
>                   DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadret/test.c")
>                   DW_AT_decl_line       (3)
>                   DW_AT_decl_column     (53)
>                   DW_AT_type    (0x0000005d "int")
> 
> 0x000000fa:     NULL
> 
> 0x000000fb:   DW_TAG_subprogram
>                 DW_AT_abstract_origin   (0x000000d9 "foo")
>                 DW_AT_low_pc    (0x0000000000000000)
>                 DW_AT_high_pc   (0x0000000000000011)
>                 DW_AT_frame_base        (DW_OP_call_frame_cfa)
>                 DW_AT_call_all_calls    (true)
> 
> 0x00000112:     DW_TAG_formal_parameter
>                   DW_AT_abstract_origin (0x000000ea "a")
>                   DW_AT_location        (0x00000026:
>                      [0x0000000000000000, 0x0000000000000007): DW_OP_reg5 RDI
>                      [0x0000000000000007, 0x000000000000000c): DW_OP_reg3 RBX
>                      [0x000000000000000c, 0x0000000000000010): DW_OP_breg5 RDI-1, DW_OP_stack_value
>                      [0x0000000000000010, 0x0000000000000011): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>                   DW_AT_GNU_locviews    (0x0000001e)
> 
> 0x0000011f:     DW_TAG_formal_parameter
>                   DW_AT_abstract_origin (0x000000f2 "b")
>                   DW_AT_const_value     (0x01)
> ...
> 
> Assembly code:
> 0000000000000000 <foo.constprop.0.isra.0>:
>        0: 53                            pushq   %rbx
>        1: 89 fb                         movl    %edi, %ebx
>        3: e8 00 00 00 00                callq   0x8 <foo.constprop.0.isra.0+0x8>
>        8: 8d 7b 01                      leal    0x1(%rbx), %edi
>        b: 5b                            popq    %rbx
>        c: e9 00 00 00 00                jmp     0x11 <foo.constprop.0.isra.0+0x11>
>       11: 66 66 2e 0f 1f 84 00 00 00 00 00      nopw    %cs:(%rax,%rax)
>       1c: 0f 1f 40 00                   nopl    (%rax)
> 
> 0000000000000020 <bar>:
>       20: 48 83 ec 08                   subq    $0x8, %rsp
>       24: e8 d7 ff ff ff                callq   0x0 <foo.constprop.0.isra.0>
>       29: 31 c0                         xorl    %eax, %eax
>       2b: 48 83 c4 08                   addq    $0x8, %rsp
>       2f: c3                            retq
> 
> $ clang -O2 -g -c test.c
> $ llvm-dwarfdump test.o
> ...
> 0x0000004e:   DW_TAG_subprogram
>                 DW_AT_low_pc    (0x0000000000000010)
>                 DW_AT_high_pc   (0x0000000000000022)
>                 DW_AT_frame_base        (DW_OP_reg7 RSP)
>                 DW_AT_call_all_calls    (true)
>                 DW_AT_name      ("foo")
>                 DW_AT_decl_file ("/home/yhs/tests/sig-change/deadret/test.c")
>                 DW_AT_decl_line (3)
>                 DW_AT_prototyped        (true)
>                 DW_AT_calling_convention        (DW_CC_nocall)
>                 DW_AT_type      (0x00000096 "int")
> 
> 0x0000005e:     DW_TAG_formal_parameter
>                   DW_AT_location        (indexed (0x1) loclist = 0x00000022:
>                      [0x0000000000000010, 0x0000000000000018): DW_OP_reg5 RDI
>                      [0x0000000000000018, 0x000000000000001a): DW_OP_reg3 RBX
>                      [0x000000000000001a, 0x0000000000000022): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>                   DW_AT_name    ("a")
>                   DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadret/test.c")
>                   DW_AT_decl_line       (3)
>                   DW_AT_type    (0x00000096 "int")
> 
> 0x00000067:     DW_TAG_formal_parameter
>                   DW_AT_name    ("b")
>                   DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadret/test.c")
>                   DW_AT_decl_line       (3)
>                   DW_AT_type    (0x00000096 "int")
> ...
> Assembly code:encs 
> 0000000000000000 <bar>:
>        0: 50                            pushq   %rax
>        1: e8 0a 00 00 00                callq   0x10 <foo>
>        6: 31 c0                         xorl    %eax, %eax
>        8: 59                            popq    %rcx
>        9: c3                            retq
>        a: 66 0f 1f 44 00 00             nopw    (%rax,%rax)
> 
> 0000000000000010 <foo>:
>       10: 53                            pushq   %rbx
>       11: 89 fb                         movl    %edi, %ebx
>       13: e8 00 00 00 00                callq   0x18 <foo+0x8>
>       18: ff c3                         incl    %ebx
>       1a: 89 df                         movl    %ebx, %edi
>       1c: 5b                            popq    %rbx
>       1d: e9 00 00 00 00                jmp     0x22 <foo+0x12>
> 
> 
> The compiler knows whether the return type has changed or not.
> Unfortunately the information is not available in dwarf. So
> BTF will encode source level return type even if the actual
> return type could be void due to optimization.
> 
> This is not perfect but at least it is an improvement
> for true signature. But it would be great if llvm/gcc
> side can coordinate to propose something in compiler/dwarf
> to encode return type change as well. In llvm,
> AFAIK, the only return type change will be
> 'original non-void type' -> 'void type'.
> 

Yeah, we dug into this a bit on the gcc side with David's help and it 
appears the only mechanism used seems to be abstract origin reference 
unfortunately. It seems to me that in theory the compiler could encode 
the actual type for return types and any parameters that change type
from the abstract to concrete representation, and we could end up with
a mix of abstract origin refererences for the types that don't change and
non-abstract for the types that do.

David, Jose, I'm wondering if the information is available to gcc to do 
that at late DWARF encoding time? Thanks!

Alan

