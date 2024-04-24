Return-Path: <bpf+bounces-27723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C268B143E
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECFDD1C2144D
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 20:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F35613F459;
	Wed, 24 Apr 2024 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c4ayV1Lo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qZUZWmOF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0556613D25E
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989586; cv=fail; b=TzJSHatRP2srtGHpfCmhP7z8XUz5j2ChUPzwcJtTjoCl98WZiD4uTmaZ7rGSTZZIWO2lP8RSkNschQqvthp65o17+GmpZQf2shOKe/1Cy2HZ+P812OQUKQ0bRLX8OMSvcjb60EAa4n1aw2rU+a9yv4O1l0oYnwdR+hUemGpnbZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989586; c=relaxed/simple;
	bh=K02KXpqx3wGLbbwh9ElXQ34OoQwV4YWIf6N2QCI2swc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=sjki9YlPaE0p+mU9Nv7k9JNAbAFa9b5lERdxueowFHRO1/qDS4svt3BuqkgulFGMwCFC2itDlfLTo76zkmAs6sVCXRjqyiDX5rEJ3XkQ6J8TotMaPGDkJTF3+Opkx8YordxYRpKmQ1d1ou3GeQm6+JW+d+X+S0E2MY8ihvPUh2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c4ayV1Lo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qZUZWmOF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OFvop9014718;
	Wed, 24 Apr 2024 20:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=udvFtVCnF8q7bNcXG3FrSI1BbpGNov1c1cTN1feAYgo=;
 b=c4ayV1LoA817k1QNHAR6MXo4JPgF6ZzlAae5QpQ6wRQb2dkuvBRb1eOklPpJirc3BGeY
 J73hLTI6p1tsHucNP4go15RQuotSb6cbN+dh674H/gMLXXlBSlco8R2VglTHKjf4p8Xz
 423SHg/I2VYnRGMb8UVNRYc09vUpC70gEGJTBF8iYds4CdmLDx0m//P+GSMMFCVXc+XG
 se8VDLutsleoh4p962Jy4GfiaQIadqw1j5jx6G1n7EJ+HZ4hnKPPZ/VI8sMiJreTG79b
 ojxciREXE7P6p4PSMjspO4jOq2f10Y/IRpt2aRmNBiF9baNtt/Z2pF5jiet/+OqbcMTG xg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4g4h55c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 20:13:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OIeM2B025244;
	Wed, 24 Apr 2024 20:13:02 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45fnfnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 20:13:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CA9Z08xyFJ6kopKMgOSj85HMVGqCkldN92OMOdwv4roHfH+/TQcylDnAPOrbfQ2Eb2b/J+iBkWDsvy46gBL8158kaGGwV6IskDwidnJaWuPaaOlxsqTYc3m3LMKx3HHgGZ/JRRaaDrpoG5B2CjK+8APf9Cszt+L7ZI/ezRAR+kO24S1i8yQmibfbO0kjxJpqJWOzyL+MrSP+POCgvizRHO5qZ9gZOU6pD6uk38pAy4m9VAR8HHgL5ZpQd5LHoWmb8xJs+NxoHQatcUVRbeNYYuOD9YK5FVI8Y1Fuvy2GPYEULxuE278/XKb/T7fTRcVLqY/DkvVQU6f7Ki1yhh9uMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udvFtVCnF8q7bNcXG3FrSI1BbpGNov1c1cTN1feAYgo=;
 b=RII/NrscrYKrX80MR+T29aiK+U0J31vZJpzuqLMt3+IPO+mHFrA/tf48grtyM7tnoHVW7O1izHcPFDLgSjFXrksaj3meUoDDL3nrJ9KIRfd5M3mXPEgKvQIIrSShwS3yeeHlsejxhQptXqpA/S1vrUnNNIRS5n3X0Fy5inVo2mSL5jIT96Esm54JblsTKKctO2vGo9GwuwczJgsXsol25e2D8WOu7E2CO/Xm4WWDWCrc9Q04Fg/hMmwXORURhRtburPXmrGgsXh/4dtt93vHusgp7j9PEx1pWqJwCg0Kt+Q0Yg6KhZCIymcn3bQa/35sMDB30MuA5M7vGip7BCStPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udvFtVCnF8q7bNcXG3FrSI1BbpGNov1c1cTN1feAYgo=;
 b=qZUZWmOFi7PNTY3t4zJdfwHnaOd9wM7TAHJBzhnxzEhcbGn6Pq3ZRR3BLuxScz3rHobk6GUQi8RumH+vpD8PPiwpDIC1F2wnpzEQwhmXbzCQoOtMTY6gAn7VqVQqwqy6KccoCoAA3FKTK7fJEnrCcXMl/Eb7wx/frGdrOmsjkKk=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by PH7PR10MB6459.namprd10.prod.outlook.com (2603:10b6:510:1ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Wed, 24 Apr
 2024 20:12:58 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 20:12:58 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, David Faust <david.faust@oracle.com>,
        Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: Re: process_l3_headers_v6 in test_xdp_noinline.c
In-Reply-To: <CAADnVQJqFYP2JraX+41VL=MWbZKFSMSNh=-skcQWY570xB7NFQ@mail.gmail.com>
	(Alexei Starovoitov's message of "Wed, 24 Apr 2024 12:37:24 -0700")
References: <87zftj9cdu.fsf@oracle.com>
	<CAADnVQJqFYP2JraX+41VL=MWbZKFSMSNh=-skcQWY570xB7NFQ@mail.gmail.com>
Date: Wed, 24 Apr 2024 22:12:53 +0200
Message-ID: <87bk5y7c56.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P250CA0002.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::20) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|PH7PR10MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: b0881db4-9c9d-4b87-8807-08dc649aef09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U2Vud3MzU0t5T1NYcjhtY2txRVh1alJuR1o5Vno0eFVhRXUzR0xFS2UxSEhI?=
 =?utf-8?B?WWpxTGVUcktRMk92TTJlV1VpRXROVlMrQ0l0ckRPUUx1UW1sbCtscHNtM1VB?=
 =?utf-8?B?enlZUHpzdjczbGNOOGxMK1AxNStwb1hoRjRObGZxWWxEUk1YZFZUa0FmQXBW?=
 =?utf-8?B?V3d5ajFFQzE2YWFLUTBsUmFQQTFTQVY4bzZybkROMWxwcUZKNnlvWlJ6N1BH?=
 =?utf-8?B?RSt3bk9ENFhCYzV5RVFBQ2V3djB4Z21lSHF5b05HTVlYOHVENHJsU3U3bVdv?=
 =?utf-8?B?SDhhaEJUTTdNL0ZQeE9ZRWQrV1ZrR0tmaTBOUGc3YjRyRU9mZEUxYnNjWnFC?=
 =?utf-8?B?elVyZUJZbU9WckpERTR0Z3lkNEVYSjREMHJLT0pQSjFZNVB4aGE3MjFSRXhp?=
 =?utf-8?B?b0dDUzFuQlUrdHZJNmtmNG1wS3J1ejZYWkIvblR6UkRnT3l1bncrMkI4cGkw?=
 =?utf-8?B?NUVSd1V1TDhmV0pBTlFCUnBGMXYvRkJGdzBlSE4wYlhCMk1Na0NGK241ZkZF?=
 =?utf-8?B?Sk12RXdRRHZXdVo3OWdicENYaFlld2tJclFJQ3BSczlzdG44YWZ5Z3BKay91?=
 =?utf-8?B?WVZTeU1HRnpzWWJHYjlxMEw0NWtsT0FVQjJmQ2F3Qm56ek1PRGlCRk42Q0Rs?=
 =?utf-8?B?L1h0U2dpTWZBaWkvaHR2RnQvNlNVbEVxNGJmbkVWbmFqVzBFaDBYZ25ZZzdw?=
 =?utf-8?B?dWxmUHgvbjRhZTl6ZExDQzg4d01vTi9wQnNMYU5NbGIwYTBvUVZvYzJVWVZ0?=
 =?utf-8?B?N053dDRCNGZXZHNKWFczT0NwSGVDRE5PK0RmbFpTaU5YeExKM2lKVVVSSVhq?=
 =?utf-8?B?czA5ZnRZMEtRcnJkTnBaTXYzVS9ack5kS2JTWXBSQXB1a1pTSGtRbkQwYmtK?=
 =?utf-8?B?QmxTdk9vYlBGUWU3SWNVQjh2Vlp0QWpUWE9meWdPVk5rNy9NU1JBVE5EcU95?=
 =?utf-8?B?RW1KVmt0bE5STnRxdGVST2ZySGp2bmFqUVErcnpUeTNpS1l3dFVaOU9DTFlj?=
 =?utf-8?B?VWRydGFhY0gxTHloY2dOVEtrSHZMY2xRd0R0eEFoZHlaMjNuMnBLaEVaaGdO?=
 =?utf-8?B?QitBeHVBOGsyUVU1cGcyMW5MMTUyTU1YN0RwbXJMZU1pdGNJYW9CT0NZSXl5?=
 =?utf-8?B?VXQ4bXVmNVh3bWlscUdpRmJieWpwM1lpN21jdXROQ3dxV0pmYkRBYndGNlNJ?=
 =?utf-8?B?RFFoOUJSZ2ZvUklnUUJrRUJWWmQrMEk1M2NXN013dFVZY2t2QmxLa2F3aFpW?=
 =?utf-8?B?WVBRZ0dqZ3JuTWJDN1NDSTkyWEdjUFE2VGEwYS94bVVJL2pibVhSYlZKdHQx?=
 =?utf-8?B?c0ZXMEJsMzRoRVludG9tZUQ2VzQ2aHBrWkgwVVNNVzBIL1cvVVFJK2hwYmsz?=
 =?utf-8?B?TXNrS0QwRHJUSm0xL0s1emVkM1JMTjRsSENOOGhsSU9jdFprZ0hHMEVraVQy?=
 =?utf-8?B?K0JNM210dUtOU0dWc1VoRGZiV2NVRG9KRXFXYWw0L211clJadVVQU3ZmKzNC?=
 =?utf-8?B?cjR5aVU5MlU5bytqR3RVdEhtT3VXTWJXVW43K3B5NkJkaVhqUUQwM295RHh2?=
 =?utf-8?B?K3lOTndaTHJ3VC9Jb3A4UWtEeTlhUFNSS1R3a1pVSEpqOW5WdE10Uk1USVY3?=
 =?utf-8?B?ckNCVkh2WEkvUDFzWGgvRTVBZ1ZBcFRkMUt5aTd3UVFUVGpCTWFLT2hqTUZY?=
 =?utf-8?B?bEpVaXZVeG9BaTFZY3N6S1c4empsNzBiTFZ5N0MrRlZkUnhQekM5RHhBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V3dvandaSDlNTHRjSVA3NW9jT3h0ZXk5N3RhT2M3TWlMZ0FENzQ5MWx2Q2Q1?=
 =?utf-8?B?bHBNOVF3dGFUSS8yK0lqenUwU0JUeDZSNW9Ca3lSaGFmVGVpeXFrajVmV0Jo?=
 =?utf-8?B?cGtWaUN0ZVNUZlFRMjREN1dZRlA5Z2UxeElJS0lGZVZqUU1GaTVicjR6ekdm?=
 =?utf-8?B?MmIxdHdJdW1Zc3dteFFUUEwxdXc0UVVUbS9OU0QyeWdkZW1oUFdHdktoa2FW?=
 =?utf-8?B?VGEyYVpqVUlMemZwYjVVN3ZuOTdvbmpML0h5WlI0WnZCN1ZrZU9oWFJ0NDVZ?=
 =?utf-8?B?bWlWYVc0VXUvQkhNaU40UTZ2b01IYjZKcXVoRkppQlNmc1lCd1FLTjlNd0o1?=
 =?utf-8?B?V3R4QkxQVlJUWVhia3o4blhkUVQrVFkvTE56emNKSFZoVTJqVkZjRzRoN0V6?=
 =?utf-8?B?OXFVKzlCa1NmSkg4Q2VPZ3huc0RBUXhPWlhLVERmMWdoKzd1MmE4ek5QMUJJ?=
 =?utf-8?B?RmhuRlJWREhXUlkxVXFYR0xLTXpWODBMVEVFaUdwQU9nbWo0d1NCRUpJWXFz?=
 =?utf-8?B?cWNqQTdCdXo3Q2tEUXluWmRkMU1aQUZvSzdCMmR6azBkZHZ6UFhWUWp5Yi90?=
 =?utf-8?B?RWhCOG8xZmtpbDhqR2xyckFCUDV0Um56UXllcUZsaXA1dWhlQ1oxamg5Z1BU?=
 =?utf-8?B?OCs3UEpqa05la2hBZWZzM3dJekpJSzFUaWplc1ZOMmtYZDd2S0d3Z05FMi9M?=
 =?utf-8?B?UUc4SGMyU3J2MktOUDMrK21IeFc3YkVCelhTM0N3amgrTzI2L3ZaV2t3ZUQ1?=
 =?utf-8?B?L1hOQTFHaEgrVGNPZ2xQVkRjSlE3VEZoL1FCbFlsOFN2R3ZlOU5yQ0k3TGZr?=
 =?utf-8?B?aERpcEdiVTAreG41SXRjb204UjFzbWk4K1c1eXpsMUEvOThBdFFkRlJKODQy?=
 =?utf-8?B?Y2c1bnBnUDU2MUxmWXFHZnIrNzM4a1ViYmhlTDlYWUlRei9FUFU2ay9tWnFk?=
 =?utf-8?B?a3lpdUd1YVg5UHhrQkJSbmxwbHZUYVAzU0JNMXJaSjhUaEJJeDJhMVBNcmZw?=
 =?utf-8?B?MUFsVVpSRjN5ekZ1MEVLTE91RXlKZExlSlVqMnU1RWhLUlo2Yk5MamVMTzk0?=
 =?utf-8?B?dGxoc0VkZWVWZnZqeG9vMXdpNG42MnJjOFVIR1R5dmZIRTNpQ1F6Y3JnY2tR?=
 =?utf-8?B?Y0UwWkRuT0N4TTlBZkFJWCtCK2JKbHZsMVp6Y0VmQ09Jb0RJSnRvNTJTUFlG?=
 =?utf-8?B?VDlaWU5HOTFobHA3Vkh1bzVPV2gyWTduRzVFdStWU3dKOHZENGVBTG84d1Mv?=
 =?utf-8?B?WG02YU9YN3NJTEsxcUkvbHNwbVdadzdGem1MT05pS1EyZ0FMK2ZTWUk4NFAr?=
 =?utf-8?B?MENyZTNtS080dkRKU2NvMUNYU3BwdlVJU2VGN1lSdFBOZmV0TnRNVERySVlq?=
 =?utf-8?B?NGtnTDRma25MR3Q1SGw0TUNNMCtXUVpNWldQdDJVMUdkOG1TVVBLcDRrVXg1?=
 =?utf-8?B?ektheFUrNGwxc29qSnByM0ZoU1UxSjNOazJ0aW55MmFPRUVsWlJTbHh3UENj?=
 =?utf-8?B?bC84c0dnOTlFYXlydzFpc29PTDRULzBpSFRsSjJkVnhYWEd6WWxNNi8xS003?=
 =?utf-8?B?Tmdoc1FZOFdIMkRTeXlYSTlqamR0UHptR214b0wydEdQaEpuR05qRXl0Wk9J?=
 =?utf-8?B?ZFpRRmJ6RHhTbUlKNWdCcUlvOVI1clBqYkxLNW11SUxHaFo4UWdWMHFqY3Np?=
 =?utf-8?B?QVFHRlFRTkE1b2VFN21Dc0hhVmt4VkU3dTJQajNtQVlVQmpUK0JrRE5PaXVy?=
 =?utf-8?B?cGt3ZDhXM0ZQWTJVUGpvNTdOUW1oN0hvNjdFNEVibkVSMUdScXA4bkRrZllL?=
 =?utf-8?B?a3U3T1JuYkduNFY0S00zYSt3c1J4WXRHeW9DQzFLTGFsWktDZFIzVVorT0FR?=
 =?utf-8?B?d2lQeUtCbW9KTXArb0FCVFgycHc3RlVVbWkyYjF2a2M5SHMvT2RmaThlRE9m?=
 =?utf-8?B?ZFVSbnlteVMrUEVsRkxUc1EwaG0wRmF6ZUtJMmZMWG05UVgrb2Vtc3Ria3dX?=
 =?utf-8?B?MllzUXlEYW5sMHEyUTN3aTRtb05tMlRzd1ZCNEVkbWEycXpTQTF5NG1VUzhp?=
 =?utf-8?B?WHRkUCtodkNCdXlXOEd3akM2dmhpYk1UR2ZxKzVPM1crU1pDMGFVcWFGT1B2?=
 =?utf-8?B?Z2pTUnRmdTJ1aVBwazNMeHlqUExDcHhLSUVxYVNtWVR2aGtxeDZnWXNNNWhz?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	C/7PRBgtRmF4kznXXHpG1VeLc82GdLHYhHj5PXM7edIr8M/vdwhQJQwMbyPOt+jd/PpMijoo4wyXCi79VI5lFZutG/I/2VfC8060DDUzJZXBKPQ0RRxPet3w/6qfQyiv8YQpri/98G29MC/X8f70u5Cx1vv9fYoQpdLOJSQui2p3zy3TzYXvhg2iYaXWKzJiVMeXbaSQxooTR9iuQQSCNvzucDVXPKblHcjKhEXg0ywkyLg1wnWrvd6axUl0A99I0OLfbcuyFjG3etO378oIH4NpmxagizTUhz577Uy/ZTSXeryECvI5gPUEapMSrv52dq4MuVHNAVW/Yut2XkVHmCwqOK3lRdkkraC/8LsqqUhj06pJU26q86BK1lQ6NeOcXyWFcRDReA6m/rxe0gmswKA0SYN5N6yRv+Sg9WmW9jBJBOGufdl0etaDnZdhIF+PkXz9zUcdB4N8Ew/ZbIC1Z9Rp8uZ3Ki3SHE1k2sVcLv08VN7/xIkeAxsYPp6kffgsFYSc/M0+9MV8SLbp7FRy2Fm7/Z2Go6WmzcqooARXXf9MEp2YlvboIE27JAp/tFwvFChxJ/mDOajjIy+7QDP0clLPxjHod7xIKTPSrcPPEZk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0881db4-9c9d-4b87-8807-08dc649aef09
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 20:12:58.0185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qz9yiDikFas/L5Eumpfxf5zfpGwiESKOFzP59IGfurHUJs1I2se182Y3fJSLD7V34K1L8ZW9nHJ4MgN9r/tvplBHGS9k17HlSKozz82cqoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6459
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_17,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240100
X-Proofpoint-GUID: Ry6hIRH9Ipbc_sYdU1gMBGDgl9Y86jmX
X-Proofpoint-ORIG-GUID: Ry6hIRH9Ipbc_sYdU1gMBGDgl9Y86jmX


> On Wed, Apr 24, 2024 at 5:25=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> Hello.
>> The following function in the BPF selftest progs/test_xdp_noinline.c:
>>
>>   /* don't believe your eyes!
>>    * below function has 6 arguments whereas bpf and llvm allow maximum o=
f 5
>>    * but since it's _static_ llvm can optimize one argument away
>>    */
>>   __attribute__ ((noinline))
>>   static int process_l3_headers_v6(struct packet_description *pckt,
>>                                  __u8 *protocol, __u64 off,
>>                                  __u16 *pkt_bytes, void *data,
>>                                  void *data_end)
>>   {
>>         struct ipv6hdr *ip6h;
>>         __u64 iph_len;
>>         int action;
>>
>>         ip6h =3D data + off;
>>         if (ip6h + 1 > data_end)
>>                 return XDP_DROP;
>>         iph_len =3D sizeof(struct ipv6hdr);
>>         *protocol =3D ip6h->nexthdr;
>>         pckt->flow.proto =3D *protocol;
>>         *pkt_bytes =3D bpf_ntohs(ip6h->payload_len);
>>         off +=3D iph_len;
>>         if (*protocol =3D=3D 45) {
>>                 return XDP_DROP;
>>         } else if (*protocol =3D=3D 59) {
>>                 action =3D parse_icmpv6(data, data_end, off, pckt);
>>                 if (action >=3D 0)
>>                         return action;
>>         } else {
>>                 memcpy(pckt->flow.srcv6, ip6h->saddr.in6_u.u6_addr32, 16=
);
>>                 memcpy(pckt->flow.dstv6, ip6h->daddr.in6_u.u6_addr32, 16=
);
>>         }
>>         return -1;
>>   }
>>
>> Relies, as acknowledged in the comment block, on LLVM optimizing out one
>> of the arguments.  As it happens GCC doesn't optimize that argument out,
>> and as a result it fails at compile-time when building
>> tst_xdp_noinline.c.
>>
>> Would it be possible to rewrite this particular test to not rely on that
>> particular optimization?
>
> Feel free to send a patch that reduces it to 5 args.
> This test was a copy paste of katran.
> There was no intent to test this 6->5 llvm optimization.

Ok perfect.  Will do.  Thanks!

