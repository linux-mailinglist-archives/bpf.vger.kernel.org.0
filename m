Return-Path: <bpf+bounces-32289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F7E90AAF5
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 12:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3720A1F212EE
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 10:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8062194120;
	Mon, 17 Jun 2024 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dg53hSm9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G8pazK5R"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B146C19049D
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718619768; cv=fail; b=Xzyfy6qlM0nazuFSo3uyNKB2G0/XcbbKI/X2WhOBsN3pFYPSZTG0QtNj2cxOktvjJk/MzoEio5PlRF4PhnCaTDO3X/NCRGOaP15QcTrxvGukOdp1ObzXUgft80EsubIjEp5pZsoeKNvOKIQmQgdDKiqZDhOCbkqUIzMQSV0tvb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718619768; c=relaxed/simple;
	bh=KcrEKO1ZaBPriYPOJt2obFOe6TVnuYU0ZM/6004kzLs=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=RORfvXdsNIeBXzhovXuGVXP/hRvHv98xxj3aRnpZU72/iF5A8ZB1Ge55RusXd1p49J/l4VXr17EHCm4JIGVhKvC3fPLw5oxKqEZmS22iDqqc5kHpQyJJWT2te7V2PF4t22Yp0yMwVlH1ILglnN7aKuUM1rC5l4Lr1P2ZF5astXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dg53hSm9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G8pazK5R; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H7fobM013675
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 10:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:to:from:subject:content-type
	:content-transfer-encoding:mime-version; s=corp-2023-11-20; bh=K
	crEKO1ZaBPriYPOJt2obFOe6TVnuYU0ZM/6004kzLs=; b=dg53hSm9qaLxo0DcR
	jPRWo3442MRQ+zngVQ2U5FmvR7xw4zzAe8eV/gYu4FFDcUA+xGSrnfivC5Tm1F2Y
	RyrAOkA2ej6bqURtyiBaluopX4RCyC0/C14A7UnNeMnEGQ5jQcveUoYBz2/6VfdD
	YlxIGv5GnaBNs/lRUEs09yi7i2ET3Zbj64ygQTnwQshHxReGcsUAqlR8RgsOtHEz
	EAIcGvfW+ahK5kl/SDDLyVM5jKSmY7CqEbpM6k7bBV0+WBtTDxvqTOKljsMrJDiw
	MnJhMMj/CNLkuKrF9gN/ksKf/FiHTnraH7WMZNy7Hs6jTFekWxWzZpsIeKBx+t4o
	8oQgQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys2js29te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 10:22:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45HACh97031924
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 10:22:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d68nfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 10:22:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zq595nVGptfmCMaVbQF/tHertM0RAH5g9dNmEado9ngVDYA56dXR+Jl2Zdns5tdcgTqINP04epZP2tjj/6xaA8pEax2Jx7QTg9U3IJLG9DqHbGvuAdBTLN7p2yw/+dCu9tvD87/6OMV7Pq6XP8McOq70KWcgCuoI6eM7crIEHL8IDNBCy7oI5hELX68sDGBZJKv68gq4z9HI8latGvTUpzfnUBQxaVrz+d2XINDltQwzCVCYzKl4thXPznF208KSXrtcgiAQdV9yYEHJCuO7d9YuZ7DtDhkC15slk73fG2H7uv5KEXP/altXPWb0jfEJp8n/gXKNdYYbhrgKdIvDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcrEKO1ZaBPriYPOJt2obFOe6TVnuYU0ZM/6004kzLs=;
 b=YgiVffYjaYoK+Er0eT2aVJMvyBJVOA7nbFaMf92cadXPsfHQ8efOxC05Bs7TrMD5zoKWHTmtY4MoPLOnNO3f6oEU/Q4v+4GAnEM1ke1edC4ggcZC7710N6WcOrwXuK6DnPLUw53STmkHeO3Cx0tWxerfSPeycmyTZYmYl0Nytlq0yHEAv4HgrH2lxCj5uo6pIWk58k+JEhRzavqhGvAPjhULVIEjhMnXbljLlFcon+Fuw89THQFQWVQYy+cM9Qq6Xfc15DSDrb2q6ty5490BucKH0vt4Z6QI02GtjvWO/6HcI8aftWaoQkJv/nAxxr20SZdLoFec1FXrBEI8TYq5Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcrEKO1ZaBPriYPOJt2obFOe6TVnuYU0ZM/6004kzLs=;
 b=G8pazK5RxJe5z3AtSH7tuRT819tOKR/ib5R9dDom9gKGilA1dMLvrGoeWR/ei3ZdckvXWchA+5jq0R1J/GtEkly/USFPAKBOehVTVQRpqHhaOv5cjvqvScWFHdOyGeZ3wpCQHd9o0qmd6R0MKVi4R08xAXNMoKGaAeYkdEVf26Y=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by BLAPR10MB4945.namprd10.prod.outlook.com (2603:10b6:208:324::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 10:22:41 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 10:22:40 +0000
Message-ID: <571b7fbb-57c8-4e4d-9ca1-119548c4d8a0@oracle.com>
Date: Mon, 17 Jun 2024 03:22:39 -0700
User-Agent: Mozilla Thunderbird
To: bpf@vger.kernel.org
Content-Language: en-US
From: Rao Shoaib <rao.shoaib@oracle.com>
Subject: bpf map collision
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0036.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::49) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|BLAPR10MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ebb026b-94c4-40b6-08a7-08dc8eb76b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TGhvZVBVRVBCR0kzNk9mdkZsbVpLc0ttaElWL2hzdDdEcGhseGI1TUUyKzQy?=
 =?utf-8?B?Mkg4aW9RTVdITHZYcUZMVHJQYXNVcW5rQmllS3VWa2tPSkVSN2VjbzVnVG9Y?=
 =?utf-8?B?WnpIbGVWTFBtOVJYekFKTlFLR25hVUU0b084Z2FkZTROR2c1VjFLYnE0azVp?=
 =?utf-8?B?Wm0zK1lpcDJseThCcGs3dFlyZkJ2a2J5SGdRbEord2pQeE14YTBtV3k5Qi9X?=
 =?utf-8?B?Yk5Nd25aa0F2MVNzYXU3Y1NrOFdGOS9aRDVIWFZ1bndmMTQyY1VwSkFKMlZ6?=
 =?utf-8?B?MHN5d1VmdUhUOUl5RTc4cG11ajNlK3FmSFpGMHFmb2J2OVE1TitmWkJ3V3B4?=
 =?utf-8?B?QVFoc1lGRkh2MThHbTdwVURJU2gzcGJpNDJCNkRkdzQyZ3FLSlFrcWNhSVlU?=
 =?utf-8?B?bjRPZDhMRVhrMk9BbHUwOXNsUnNrcDRZVnpNdnlpMnBQRU5DaGdnQ2hndVoy?=
 =?utf-8?B?d3JaT2N4Sk9DQ1N3dElWaW1hemFMNEhpSWlLdzZTbnFzb1VZMWxBZXcya1JV?=
 =?utf-8?B?T3NPR0h1U21SakwrdTJXVGpGSUVmNFcxMEJpQ3FyTmt0YnhPNDZMd0lNTHpl?=
 =?utf-8?B?ci9yd0k2dzk0RWVheXZtd251NktyNWZXbjN3cDlxOUJjV1RxYy9pY216OWUz?=
 =?utf-8?B?enpKa1hLcmpVVzl0V0Rvd0Q3Y0tMKyt0dUFsSmRQR3FrM01IRHI4dXZtc29p?=
 =?utf-8?B?OGRJTlliSWJ0SzNFVkZPQytsbEkzZkFQL2NBQk12eFBaOG15NVRtcE9lMUV4?=
 =?utf-8?B?VjNldmMyNWdwSllIR016TWhVUHppWTJncVFKSEJNTFFhaGpFbzdYQXFMaHZm?=
 =?utf-8?B?ZHZVZVBvenRuZHNlNGxITHNLM1F4THdsdmQwek1VYkQzMmlCaUx0RkNoS2to?=
 =?utf-8?B?VGFvMGY5TVV3SEw2b3dvQW9Ia1RsQlZ3NlU3UllOWXhOUDFHWGI3WTl1WmRy?=
 =?utf-8?B?Yi9DSGFMZXV0ekRIekY0aVJXUUJkUXZ1NEMyWmcwOFNTMUxCTTk2ejlqa2Vs?=
 =?utf-8?B?UnZON3UydkttV0FKOUpXcHdNR2xVM0g5VndTQ1RIYXRzeGZtdmhiYi8wbHNy?=
 =?utf-8?B?Y2JZTHQrU3VNR0FjU21IbTkrMTFNSldkZ0ErNDcxR3gyOVVBaGJpRzY2VXNv?=
 =?utf-8?B?ODFRZU5yM2dUWVQrV3lXUHNZTzRQL3VFNnJjZC9tQzAzNFN5ZXJRSThvaWtB?=
 =?utf-8?B?cGRDWWRENGNoMzU0WHFpWlRUOEJwcGdsSGV1Vzhvd2U1V0o0VC91cFFnZmhH?=
 =?utf-8?B?QzMreXVNZUovYTJkTUZWWVkyRnVpbXJrMW1EYnpINlVnZjZnOWZGdmhQNXJm?=
 =?utf-8?B?QnozZjQyL3BjMXFkNUFoRm5BYmQvajdBZmxhb3VZODRHN2VVcHdTUjk1Z0dI?=
 =?utf-8?B?cEMwVDBJNllkQjRhVGRkempEZEYrWFJ4aHk2em9tN2lNNzlNTGNCQW9YeFJh?=
 =?utf-8?B?Z2VSUnR5b0xRalRwVE5vZVRSL0E2OHpUZ29NNEVYQWJYWWR0My8zSElPeHBj?=
 =?utf-8?B?elREZlNhODRiT3VIRmhtZDM3ZzRCZ0ttNTYrOEJZeEdjczFmSUdJUFowRFBM?=
 =?utf-8?B?SVAyS2U5M2wra0FCL1B6ZDhWeko1Zjkvc3hVWEg5RFZlT2JRTFBxRTY3a1JD?=
 =?utf-8?B?eGd0aDlNT0lFR1YyeWVTRllKK0hLcExITkxHRE5YUXBKNml2emhJUWdzN0Vn?=
 =?utf-8?B?Q1MzSmhvWk9nbjU1TFoyRjZDR1M1WFpOR0VtdCszRGNDQ3RhWHUwSWVsbFFj?=
 =?utf-8?Q?bPPL0+PQJEq9DpIuLNAZ3fw6wIpSCkNv0rDANxI?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VFF1a3ZLdys3KzljbTk3a2YvNzgyK1hzN2ZZRmEyNEVFcUs1NitmS3NFMGN5?=
 =?utf-8?B?VTUzYUtQUDJNSWlWcEx0TEFnL29VZTZ3S1Y3M1pucHduNk5XV2VQbWdPVHZ5?=
 =?utf-8?B?a3dpWmpQU25aUDh5Umh1ZHl4a1hnS3BiOE9Ccm5OcnV4aS85NGZtZGY3SFpw?=
 =?utf-8?B?a0pGK0ZNZGk0bHlSekd2VXpKN3hOWGUzMk40VVpOQ043ai9UbituajBOL1dl?=
 =?utf-8?B?SEJ4TE5iVXVXYlM5UUplbDhBRTMzUGp6YjZIS3c2L2xwaVJrOC9PYWtvQVlR?=
 =?utf-8?B?eGhBcGM0d2VuQmdCR3JCYzRBRG14WlpObHBVeSszM2ZhL2F2Z1MzKzhsZ1Vj?=
 =?utf-8?B?bzNNZVdkOTU2Y0VYZnJ1WktLUDFtWkl4YkFPY2tEZGl1YjBxNmwrUW9vcWxC?=
 =?utf-8?B?WW96NG5LUTRPZk53dXdOUHRBRUFVdmREYXVQTUVFRXZCZ0xVczlvM2lmem5N?=
 =?utf-8?B?OW85cTRHS0FMdEVaaGltMW02K0RuS0IxczFxQmhBUU9Ydk9ZOGpsUytQdi80?=
 =?utf-8?B?THFpZzh2a0xkQnZXaVN5YjRsUVJKVDRkQnZ3SDlkSGJFUkE0VzF2ZS96bDh2?=
 =?utf-8?B?d1Iyb0JZVzQ3NStXeUF5dVMyaVpncGV6Z0lxcnR3MGlzaHNINXRkU1RhSFpZ?=
 =?utf-8?B?VDV6MFpqUXpKSXNubU9RSThEWERjbTdvR1lsZ2lFSi9KUm9MVzZWbU1PU1VC?=
 =?utf-8?B?WHh0S3Vuck9LQU95LzY1M1JVSS9HK1U0R3hldXpvb08rbkFNMmtzN0Y3YXYz?=
 =?utf-8?B?VU51TGdSMWpzaUIyaGFkOGFmZ1ZsYXF2ZGNjUGRkOGE1TnJtL25FVWM5aTJR?=
 =?utf-8?B?eEN4ZmJOYThZV3ZPVi9vRWJQd3pVM2J2cTNVUTVVakljS3RxNU82ZEgzTkRo?=
 =?utf-8?B?eHQ3SnBwbmk4UmlKSzF3UXNpeWlZc3ZwK1dRb01aeVFqcVB6ZFpzMVcrVllV?=
 =?utf-8?B?MlFHV0V3S2hCeTZ5aXdhMmo3M1ROczlzZ2FnNmJYU2x2emo5MDRhOTRXNlg3?=
 =?utf-8?B?akFoNUNZeFROZStVeE9wQzFuU0NsSkgxb3pRdU05cE1kOEJMQU9ZQzdMRUxu?=
 =?utf-8?B?RjhWU3dNVTBvY0M4emdZTWd0Y1hDVGdRMlNnWTNxOGkzQzBaQlFiZ1ltZERt?=
 =?utf-8?B?NFplREJwSTFYYzlYb1NXR3FheS9YdEFIM2ZZR1MvUVVFQkNzKyt3elpXKys1?=
 =?utf-8?B?M3ZDUWFzQURZaUw1VEdsdFcrdjQzOTl0STJ1ZnRjWDRIdEU1bGdLSExlUmhX?=
 =?utf-8?B?dmF2dXdrSmJTczVlRkFpbHQzSC9uNGljSm0yRGZkNElpRnIvWkpWdHJDbXh1?=
 =?utf-8?B?eHBqOGRRUVlxTVVxMFg2eWhSZittWWQwNk1FclJtNk9pNVRsSHFESkRrdHFV?=
 =?utf-8?B?bzlIMmovRlhzL3kwR04zSGRCTEgrN2NEejlBNDdtM05LUUFxYVNBWVk0Q0N4?=
 =?utf-8?B?bjZYa0N6ODRpYnMyVjdLOTlvY0NSR0RZOWY4M2pXU1F0YllzU1l5RWlFZVJn?=
 =?utf-8?B?WFYraGF2WXhyczhiU2pmOGFLdktvRHI4UHlpb0hRVjZxQmNkeFREeHJqZUpW?=
 =?utf-8?B?b05HdzNZNDhYVUJnakdTQWZZSEJvbGljQzlkaE1LTnRLTWxpUVJpTC9udFBL?=
 =?utf-8?B?Y1ZPWjBIdk5QYWRVb1FZQkxUOEdES2lBUWg0OWZxdzdtdzNGd2lZcHJkWXNk?=
 =?utf-8?B?cStZdlBHaEVIWWhYS3lFRko0dkVlYmNtWi9FUVJVSFdLQW4wMzZtNDhxYmM3?=
 =?utf-8?B?MUdCa2EwSlRudlM5enQ3NWpCUFlQSzd2a0pscVpCQkprWDN1Vk1SK1gxZnR0?=
 =?utf-8?B?ckwzQXJqZm9LdFk0UWxxMkw1Z2VyQ3RCZkYvbUhRNUdBamluM0FqbUtWb0cw?=
 =?utf-8?B?cVdZWGVPekpjQm5HU1VkUGw1dzFENkUrT0tPTFlWL2JEL3lmZXprSnFSOHNI?=
 =?utf-8?B?NkZtejR0SWpiVXFJUXR6aXVyVlU4VWtTVXVUeEZsc1NkQlFQaFB4SUNxWUF4?=
 =?utf-8?B?MjZheEM0T0I2WDF6czdpelFwWHdJQmRaUDRlaFR3a1ZWODZOVjJ6bFhmUW9K?=
 =?utf-8?B?d2xocWhOU1EyaXBVMWx4dDZSOVFUcDNqTzI1L1JabnU5Slc4YXZjZHpaQ01a?=
 =?utf-8?Q?1RBc+DN3d1fMDu4WIyN2DKR81?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1y+R/GWFhqZ7Fd7LpLKu545UvLdL5NUu2BolaS6JY1aP2xC/FfyHbL0pJvxQC4CFWmLFTEgeXEQf8Suf1D//mcw72sgBbiPNYGWQgAPk+TXuYE95Q9yacAt4o0ToVeqvvE7WixpUB1NdJGJAyUvhpqOgicrbigDHTUWjZ5/3Ga/u/gsZSkyBMLu3y+xxlD/+6GWMFD48rOtEpW+k9xyu2ZnXJyXB8aIMfCa3oAyupJKiUiAkTu+AVwoUtKQDuASyDxpuJFqh2UTMjYtoxKdj4C8kG7HVaOSELlczXBMmtji6Ea7CNTLNPNERjZnQ0IIUUI24waFLjyJsPWfFAzcmnLw1Gkaac/ll4dSPk5bA6pjnMzu7I544YMeTcAdquv+CAkWL/FLJiPUU0oXqe8C14gyLUysFDJ3YuDfr1negMje2jgJhJbcQJA7TtaINZLhYYRn9P05pEeY/YvLcv0QHEzy9Xm9Hk4wdVzmb9uNTHcWjBpGyRfkqtOcFk07qAxPtSF0U4ZdCbl3artP6ce1vV3PYUZePGwLl9zR7Du+T2Z2OKx1x1dAY2FMpdFGF9Nr3i9NfdzK8xHFpPmXcwQO262LOX9X/97ZTGrbVHys5e2A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebb026b-94c4-40b6-08a7-08dc8eb76b14
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 10:22:40.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlJljkRufPtKoXZQnbfORxbdi6PP8mkk1XVfLGjBk/nH9YbMorA5O1VWGDh56m1TtEjzpnfE2TaL1KZMsNrVtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4945
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_08,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=526 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406170080
X-Proofpoint-ORIG-GUID: y-ol8nJ7Zn1bBcZPuoe6VAOT9q-5G_dk
X-Proofpoint-GUID: y-ol8nJ7Zn1bBcZPuoe6VAOT9q-5G_dk

Hi,

Can someone please explain to me the magic that makes the map accessed
in the program running in the kernel same as one created in the user
program. What is the use of the map name? can there be collision if say
two separate processes load the exact same program.

Thanks,

Shoaib


