Return-Path: <bpf+bounces-28039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 295698B4B6D
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 12:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44BF1F21DAE
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 10:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD86E56B6C;
	Sun, 28 Apr 2024 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KUstLFMN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HdWdjMfE"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D0554BEA
	for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714301783; cv=fail; b=Yl4Z1qLSL2HXW/9OEvpjo/Lo6wd42lVnEUXHvYamwNusGe1+IL9LareN5zi9SMshPiWHOlOZV4efiZqSL0FPvvVN6bohxVYGwmYTBn10girbJrFA2KjD25kxnaoALolHT3Mhp/35N/Kuz/xh2LohNcqdyfKe4PTUFJiMatLa2Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714301783; c=relaxed/simple;
	bh=4Qk7PChRLem2pxxmPHs2zERTuJo9jh9fB0xS7g3wxog=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=sgjULAqlaQScJxGZOhs10mOcG2uwEgbQmZTQYg/qxkDDxD3VTPm2/Ul8vDyx6M71d26xJgX6cgW35kcOmAYhrzvIui355pY6qt6F3gP0dRgxiWJfLKreKsBB7thBN2a1WudCx/mluXbrFDW7HfHM1AajrQ3d7XTDEx/b9Ls4DFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KUstLFMN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HdWdjMfE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43S5fZXO030661;
	Sun, 28 Apr 2024 10:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=q1F+d8DOv0Gzxa5/c38+BOBuyHlzI4oBdURdVcBfI1g=;
 b=KUstLFMNcbQqOYubx0V1IjcP9Sw1AraJ6HxS+c4YcucmzKqH7dQQRkbmn7vcGA+F74fW
 3RgekJPfuqnB1xB/bZIvsJCDxDRx5a2IDDia3oh82p0OkCAICHHbloboFiuvhgszdNXY
 pHB/7GGbkb2HCPf1wxafyCSuO517xt89NzWdwzVVS9Q0dib/phAGTD/XFH+yhJshEloY
 MrPiTKw8vb7IlrUoqqr2FPCwLdVnoJqHRsPOel7fQsUCCaxSrFFTNdZKFUIwOwwtoqVa
 wqlqC8P1h5pNgTpe+O64cLaO2ePBAoqmoMTkAkia3HoRj6oi7Lp+C50pA0hn9IO7WLX6 ZA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqses6as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Apr 2024 10:56:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43S92g30011469;
	Sun, 28 Apr 2024 10:56:18 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt56vxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Apr 2024 10:56:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFMs1E5R179SQSrSrwjUMfItm8g13qX+o63MsxGVSs7/LGrHGORZOCvFh3r1QT+PN8oWloUJ01x1aRFhUVsirYHL8QAF4LbRJhNasauqc7Y9rFfcRbpOEmxvp/8DR4tDCztknWQGUPDGijx/X1HMtxTaDF365ENaI78nAC4a6LyvupmpgwH2rWxMcUEkfqKhMn38/HTh9L6ShezVVahTBFtsz1d/02jqgVl6kd2zR3RM9q0Ve/pIWTVtD0hA7MvtDaMH+mNnqb8joy8h58qDdp9lfSAvnKGWuXI90uST/vlaJaGyRYAr/Yf/w8srJOIrJPafTFWKUVffVO2XqUPIxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1F+d8DOv0Gzxa5/c38+BOBuyHlzI4oBdURdVcBfI1g=;
 b=oEfh8NE7YO6ml2y3zhc/Qe0NPLeYL22s4kKmXZSDPuQKzyeE2A5G/fpRRqNFlnCsCChf0XgWRCWScCC7ulSuH28oIzGBC/zSzdzuYZal6qMyOhiW+Qd85gFquSyvVi8YXHmiLC3HcsYo/O/W0HrRSmTd95lX2SsyCDFiOzb+NCk5iVwJVS6bTv0krbss+IgmUFUpvlD0x84UTPPphB6gq+RWX1BoNRUfsTJ1PtlGlsMB0ODpVOXlyNHCY4AbBQKa3Q5X3RBUsrjLUn050xqHqcZtEFdoxyy6x6ORsqsiZWW5Hq755rRySUkCtQobJIMV8tAG2/++0ha1C5su/eP1yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1F+d8DOv0Gzxa5/c38+BOBuyHlzI4oBdURdVcBfI1g=;
 b=HdWdjMfE1Xv9WAuGSfe0YctRr1tB1AReGr+yFEfydewP9HdT6JsbU0lcGGPHEjKYAYjqZYgIGYhlxcZtv+wm1iI8d3Ia3AUW7ERF21fm0vrh6HtjtneumIzrHgGYwv6D5TLAwHJ2cQ9qTXAb04/vhXD42lFWwcRYZ4f+nChlcSU=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DS0PR10MB6848.namprd10.prod.outlook.com (2603:10b6:8:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sun, 28 Apr
 2024 10:56:16 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7519.030; Sun, 28 Apr 2024
 10:56:16 +0000
References: <20240424224053.471771-1-cupertino.miranda@oracle.com>
 <20240424224053.471771-3-cupertino.miranda@oracle.com>
 <CAEf4BzYuHv7QnSAFVX0JH2YQd8xAR5ZKzWxEY=8yongH9kepng@mail.gmail.com>
 <87edasmnlr.fsf@oracle.com>
 <CAEf4BzazPWOgXFco=PJnGEAaJgjr2MG12=3Sr3=9gMckwTSDLg@mail.gmail.com>
 <CAADnVQ+mSfUbtgk9pD+j6b3XLZJ1w7mGzbh2+t40Q81jB==wLg@mail.gmail.com>
 <87a5lemnb3.fsf@oracle.com>
 <CAEf4BzYRyAAv2an3+vq6sswM8Rx7Ys3qsz-9FUjGb4B6vgHYhQ@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf
 <bpf@vger.kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
        David
 Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf/verifier: refactor checks for range
 computation
In-reply-to: <CAEf4BzYRyAAv2an3+vq6sswM8Rx7Ys3qsz-9FUjGb4B6vgHYhQ@mail.gmail.com>
Date: Sun, 28 Apr 2024 11:56:10 +0100
Message-ID: <877cghn4c5.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR04CA0092.eurprd04.prod.outlook.com
 (2603:10a6:208:be::33) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DS0PR10MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: ba639a56-4a19-46ef-ee1c-08dc6771d312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZzUrRnBza0tmaERuZ0JWNGkxMUtpL3Rhd0hoRnU0TG4wU2loL2pVc1hlL3Y1?=
 =?utf-8?B?ZktDL0Vzd01YWXdiTzk1MHUxN0E5R2swYW0zMmlHNXlZREtCWWZUNWI4Q2FS?=
 =?utf-8?B?dlUrTDhoWTZTT0c5OEdMeWhwQUhENmkxUElZcVlGRHlFSDVmckNRb040c2c1?=
 =?utf-8?B?SnQ5SG9QMTQ2bllxdHY3WEZSM1pQTHlCOE9WVklqK0FYdHRKY3FGOFdOMUs2?=
 =?utf-8?B?bi9kbTZRbVRFcFloQzM1Y1hUOU1kL2FHOXIzbnFPZHFMRGZKbmdyRFVRaUJk?=
 =?utf-8?B?Q2Zyd3hybmtnQzNDVmN0SW03S3B2OExMQ3h6cmF2NU43KzlDYnhpcGJ5QWxU?=
 =?utf-8?B?eXlTaUk3Zm9pdzVCWTF6eEVEajdRWThDV2s2T1ZYN0RZSjdHUnpnMnFJRHR5?=
 =?utf-8?B?c2xLcVZFdVJnQngvbHo1SFRkWGl0dzNGNFFVb2RrdEsvdjdURXhBZUdiVHUv?=
 =?utf-8?B?S0w2NExySjdSUEhEZktDV0R2VVg1U1pad2RoWnhxTFFBc2FjYXlkOEtQRWtj?=
 =?utf-8?B?YmNsdFRjL05KVjdZcnpkTzdvZGRWZ00wN2VHU1kwNUhra1crREJkY3p0T1JM?=
 =?utf-8?B?SHJDd2JQeUhIc3dDQkJ4WHRtTnNhUE1EQzM3a0NWK25DbUVGMGU1em82LzdK?=
 =?utf-8?B?RmJOUDhubytSakpRQlU1SHV0cjNMVUZkbUxPWFZwVjQ4dFlXV2RTTnlMMGQx?=
 =?utf-8?B?VTZJYlU3elQrRnVXbERnMkhHSHNnYy9Vb1h0S21HUXVmSUE1cXBSSlJxcXNM?=
 =?utf-8?B?dGNoeXBKUFpjS0FEUm0ydFgzYXdIQWFJZnNaSHl4QjVUVFhwZUhSRG9IMFpy?=
 =?utf-8?B?UnRwS3E0TnZ3UUxnalU0dGdMNmN4eGgrdEd2dnFGRWpXSFpZUlBmbml1UHp1?=
 =?utf-8?B?Szd2czEwNHJwdTR6YnF5djdMQ0RIQXhvNlJXUjJXN2ZRckpZQy8vMHYyd3la?=
 =?utf-8?B?UVdZVGlTRk1FM09uU0h2VHBjMWsvNlNBTGdsVUFiSWNBYWRraHZWbEJaelVM?=
 =?utf-8?B?ejROZHVNZGFXbDQxRk9kWUdML3lnTlpxeDlIQ01IcUtQbmprNVY3SmNGOVlZ?=
 =?utf-8?B?SXlBZGRGcGx1SmlObnVzTG5VR093NzF0VFBmd0JoTU8wNysyTDF1SHllcGtm?=
 =?utf-8?B?cnhEcDFKYktJdkM3WlZsTzIxbWVnOHBnU29TYlY4N0h4My93dFdYcUE4bjhm?=
 =?utf-8?B?SXRITk5oek4zcDdTbnkzK3lBd2Z2RU1mcDAzdDA3K3liMkpJWDBqanE3WXV3?=
 =?utf-8?B?V3pTd2pSVldJcjBGYnpQR0Q0RTJ4T09aKy9WYmhKUmp2WWNUbnR4bXl2UWJV?=
 =?utf-8?B?bW83MnhOc29oaFZwdHI5Znlta0hGK0JmbTF4clBQMGpQcTlBaWF0SnQzVTMx?=
 =?utf-8?B?ZXNkRjU1aG9TMkN4SnVWc2FjSHorZ3lMNXhxK2VHN1F0cTBVRE1JRUttMEZL?=
 =?utf-8?B?RGZSQkk5RUZxWXR5SkNRV1p0c0pOUElaa2F1MUV1WVVBSHFwd0EydG9UMk1M?=
 =?utf-8?B?cnplMWc5dWpYRk4xcnVFQ1pNN3NHbWFwNTdkR2tDUm5JZkJJTkFSejZ4TXBv?=
 =?utf-8?B?bEp0RFBpU2VNVkY3ejAwUm1zZHVvM2tGckF1a2p4Z3dmTnRMaHlXakdiOVhM?=
 =?utf-8?B?L2xURnhwRlZSZ2h4a0tGYXpDS0dMRnFYVWhNUFIyV3FhempWdkpSWjcwdHRR?=
 =?utf-8?B?cUREYnRoTUNzQ3FFb3J5V2QrY0M3bEgrY2UzWGczRE5pZGZZNzJ4STdRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aHNOQmt1NFVnNDhFTkxiSEI3dmZCVWtBMXBZNUJMMXB6bXNSblRBaitwWFZK?=
 =?utf-8?B?clYyOE80cFpvR1BaRTg4Y2Vtb1N5eWZiT2NJVEtKWHF5dm9haTRkUkY5ZDNk?=
 =?utf-8?B?eEtyK04rOHpZaDRrMzRKUUNBcm9YanNRbWpNUWdER2JpZmpNbnVWdFZyclFt?=
 =?utf-8?B?cTk5VExTRjZiZ2t6RXZOYUJacllOblU3d2NlRisvVlpIaW1PcXBtZnhBTmor?=
 =?utf-8?B?RjFSdndadGEwVmh5M08vLzRPVlUrdGJ0cEV3Vm9PVURmQU5OSmhZdzhsOFJC?=
 =?utf-8?B?L3FxNXdGN200bzJLVUdicWZTUTBqTjR3dVlUdWx5bEdsd2hYMEhpVjlYN0Jx?=
 =?utf-8?B?QkpTbjFVQjNSbXBvc042ejMreUpuYWpKTXdxSnZyK2ZoNGxPcU1MWDNnNzNv?=
 =?utf-8?B?dVl6MklvekV1aWgvdnRlMVdFTnZRRnY4dVpTcDlSSFpSMGVKTEp2T2xLbjNS?=
 =?utf-8?B?dnhMcE04czdrMGlidTRmMy9jVFpHR2lJaUpSbTBwNk9Oalk5NE5WcXcyakhH?=
 =?utf-8?B?ZG9ocWZoYVJxWTlFOS9RVkF2d05UVC9oaVBsYU9KTlNtTElPZWozOVdvOVdO?=
 =?utf-8?B?NHFPUUliQkFoNTJUN0JITnNpMHp0cFo4a2w5K08yaU9KOHVnOUovd3hqYkgr?=
 =?utf-8?B?MTJKcEJhTmR3Y3lZcnpJcVlKcG13a3REVE12SVJCUG1SWm5kenFGUGtpc1Fk?=
 =?utf-8?B?N1FSRDhoRFJxNzBzSVN2UHY4VU9wL29VV1JObGUwUHh1aU5lb3JUeW9YZ1Nr?=
 =?utf-8?B?QkpERGgxNkpOY2UrbkJQZVAyTWp1eHdBUVgvNGpDcjlxTmlYVDYyT3E2UjFY?=
 =?utf-8?B?eTdPUHJQSkloMXp4V1gwQkE5MXdkZ3VOaEhDM3pYYnQ5c0ZkblpsUm94dHZt?=
 =?utf-8?B?bENOc29FNVJtc3ZYaFhiVGRPVUJrUnpxRDhQc2ZwQmQ1eUtTYTZBYXhycXFp?=
 =?utf-8?B?QjFkbXFpdEJweHFxK2c3QW94TC9menV2YlJERkNlR2RSVyt4M0sySDkvQXNV?=
 =?utf-8?B?b3dKRGhmTTdLUHlsellLVGtyakxyeXp6VGVvL3VaT3pTekNLSHk2eHdvbDZa?=
 =?utf-8?B?SG1KRDMwWHlIbmFzYTNReGdZWFpraWVncFJjZ1dtMDlBTk9rUVA2bVVOZVlo?=
 =?utf-8?B?Vzl1cG5yTytkcHJ6K0dIeXZ6Y3JTVktYZ0wvT2xiZHZWRjBEb0ZHLzhMd054?=
 =?utf-8?B?UWFxRnAvVVdodnR5ZkV6dXR3V1JrS1FRSHhWRkhHWCtjWGt4cXpKMnExWjRN?=
 =?utf-8?B?M05aTDJJQ2JpVjl3djlzUWk4MndaY3l6Q2hnc3VseHN4OFMwU0FXV1pKc1Zp?=
 =?utf-8?B?SUUxNHVEcXJZdkNGejBkK2swZCt5TXZ0OUZDQ0pnbHIvTXJhTGs4dXNlVGtD?=
 =?utf-8?B?aHl1OXQydzBXUmlXOUduZmJvdmFoRzZvTmFhdkVJUFNPNk5CbllrclcrMmFj?=
 =?utf-8?B?NjhDQVZybUJiY2NYMUtJSVc2Sy9QQXFRSVNTejlhZ0lNZ0pBQlQxNmt3NE5n?=
 =?utf-8?B?RGd0SkZjRzdYcXE2MGRzdmJ0bEl3STBmVXhSZ0xEZEdKeEdLK240QjF2QzJ3?=
 =?utf-8?B?WjBRdld6VmJJOFZISnBjaGVMZENjRmFzNVVSWGFPUVFsWkF2V0drcUY4WXU0?=
 =?utf-8?B?dnhucmEvOVU1UVhPMXBwZzlPeGFUWkJmclUwSytha2xBbmRFUU5aNFZNbFkx?=
 =?utf-8?B?TEc5c0FtNGRJN3JzVWF2Y2lJV0NvVFhuZUw3T2VNU2ljQkcvSnBXNmxVNStj?=
 =?utf-8?B?T3o0VUpXUVQvR0NXK0JsZG41bVBTQjkzOVdmNk9TdUlhQ2orbGt4SHNqa0hZ?=
 =?utf-8?B?Y1hhWHY5ZXgwTUJHOVhFZEJMR0xRRFZhNmpJdXV3ZFYyR0I2blJaNEJObTdM?=
 =?utf-8?B?c3laMTJWMEJjd3o3UlNORFc4SDJLWThRMERUYkV3TUVRM1FvN29Mdll0ekpY?=
 =?utf-8?B?a3ZROExMYTM1Z1F1WlNhVVBTZlFhRmlBdStpYisyYVFVSy95N3pja0FoS1dm?=
 =?utf-8?B?ZUEzQWphNDdlSm9KczFoZmt6Vk9jVG5GNXBsQzM3RGRBOWNkYVFEbWN5aWdw?=
 =?utf-8?B?TTRZUTNHZGtNczl0cVNLcEpWa3pJeDBaSS9BQnBSMUM1YmFZWmNTdkdkY29C?=
 =?utf-8?B?TXVDVDEvNVpjSUVxa01VMWdQc0xDc0lKTm1FdUh0b010Y1AxN09ycndRelNx?=
 =?utf-8?Q?y4c1mjFgtTcMcsU21MX2ClA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tzs8jN8aWVJiN+aL9fCnw9wGe48uOTNWdeF9yuoKzY3c8gO5HYuH7RDu1Q47nnOZgZpkpk76/fadNbq92MDqzmwJGApy5LBmyk1/O1x+Ry5mSO8otcR3C8cSymFA0fBw1RdKlhzws84FUf4YNzirJX6ApG4Whg95a75QTdi9qeXiHq2kjo7lGuyjvWvpKS1jk5EVpsm8iz/46IuZ+LpUy0SS57kbS9zUSDhJnKznW4LKc8niRlaAKSt6aZzRjpAq+qF6IGMspsyvXnFHoS1jUIHN90mmJ9Ew8aIbBle7lxd6yUXPr69ALBD8PgowuebLJwwWttjt6MgaZGSTpvwCIRQhy9DNBtByVPkzxPfiuQ4vkN/+fhsmRARQVvDtknItt+wUBT5fr1ioayBLLxSce62k04rs91xzqcZX1oNbLLvCRNGMykXZ3In/ZfuNBJUli48alQA0ubEygKPgiVr2D7QQWn0BUXZk5qCzpDWpduiBHlqPfXecADxafl2+zeoxNISzoSQ/Pnu1oa1tJ2gbk63WAzsw3ccWiJSF2PtcKvh2lyQorBHC0bn80R8Ts0U9s7R1/rQ6/G7sEk/UJIm0Lf5mLvqn9xWUzOLFu95JMGA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba639a56-4a19-46ef-ee1c-08dc6771d312
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 10:56:16.0930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dG96lVE8xSZaYodK7ykfqeNR3tdFL8eX/mhagDgVodlvnoCwkgPeA9udAjjkG+fp+nCZudPfuEIXaHgpq5pc5IxKAsPhZcEwIxre9OWTM/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-28_07,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404280076
X-Proofpoint-ORIG-GUID: vzdBdAZfPUWquE3mt-z7BD9YAKscrwsp
X-Proofpoint-GUID: vzdBdAZfPUWquE3mt-z7BD9YAKscrwsp


Andrii Nakryiko writes:

> On Sat, Apr 27, 2024 at 3:51=E2=80=AFPM Cupertino Miranda
> <cupertino.miranda@oracle.com> wrote:
>>
>>
>> Alexei Starovoitov writes:
>>
>> > On Fri, Apr 26, 2024 at 9:12=E2=80=AFAM Andrii Nakryiko
>> > <andrii.nakryiko@gmail.com> wrote:
>> >>
>> >> On Fri, Apr 26, 2024 at 3:20=E2=80=AFAM Cupertino Miranda
>> >> <cupertino.miranda@oracle.com> wrote:
>> >> >
>> >> >
>> >> > Andrii Nakryiko writes:
>> >> >
>> >> > > On Wed, Apr 24, 2024 at 3:41=E2=80=AFPM Cupertino Miranda
>> >> > > <cupertino.miranda@oracle.com> wrote:
>> >> > >>
>> >> > >> Split range computation checks in its own function, isolating pe=
ssimitic
>> >> > >> range set for dst_reg and failing return to a single point.
>> >> > >>
>> >> > >> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
>> >> > >> Cc: Yonghong Song <yonghong.song@linux.dev>
>> >> > >> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> >> > >> Cc: David Faust <david.faust@oracle.com>
>> >> > >> Cc: Jose Marchesi <jose.marchesi@oracle.com>
>> >> > >> Cc: Elena Zannoni <elena.zannoni@oracle.com>
>> >> > >> ---
>> >> > >>  kernel/bpf/verifier.c | 141 +++++++++++++++++++++++------------=
-------
>> >> > >>  1 file changed, 77 insertions(+), 64 deletions(-)
>> >> > >>
>> >> > >
>> >> > > I know you are moving around pre-existing code, so a bunch of nit=
s
>> >> > > below are to pre-existing code, but let's use this as an opportun=
ity
>> >> > > to clean it up a bit.
>> >> > >
>> >> > >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> >> > >> index 6fe641c8ae33..829a12d263a5 100644
>> >> > >> --- a/kernel/bpf/verifier.c
>> >> > >> +++ b/kernel/bpf/verifier.c
>> >> > >> @@ -13695,6 +13695,82 @@ static void scalar_min_max_arsh(struct =
bpf_reg_state *dst_reg,
>> >> > >>         __update_reg_bounds(dst_reg);
>> >> > >>  }
>> >> > >>
>> >> > >> +static bool is_const_reg_and_valid(struct bpf_reg_state reg, bo=
ol alu32,
>> >> > >
>> >> > > hm.. why passing reg_state by value? Use pointer?
>> >> > >
>> >> > Someone mentioned this in a review already and I forgot to change i=
t.
>> >> > Apologies if I did not reply on this.
>> >> >
>> >> > The reason why I pass by value, is more of an approach to programmi=
ng.
>> >> > I do it as guarantee to the caller that there is no mutation of
>> >> > the value.
>> >> > If it is better or worst from a performance point of view it is
>> >> > arguable, since although it might appear to copy the value it also =
provides
>> >> > more information to the compiler of the intent of the callee functi=
on,
>> >> > allowing it to optimize further.
>> >> > I personally would leave the copy by value, but I understand if you=
 want
>> >> > to keep having the same code style.
>> >>
>> >> It's a pretty big 120-byte structure, so maybe the compiler can
>> >> optimize it very well, but I'd still be concerned. Hopefully it can
>> >> optimize well even with (const) pointer, if inlining.
>> >>
>> >> But I do insist, if you look at (most? I haven't checked every single
>> >> function, of course) other uses in verifier.c, we pass things like
>> >> that by pointer. I understand the desire to specify the intent to not
>> >> modify it, but that's why you are passing `const struct bpf_reg_state
>> >> *reg`, so I think you don't lose anything with that.
>> Well, the const will only guard the pointer from mutating, not the data
>> pointed by it.
>
> I didn't propose marking pointer const, but mark pointee type as const:
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4e474ef44e9c..de2bc6fa15da 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -363,12 +363,14 @@ __printf(2, 3) static void verbose(void
> *private_data, const char *fmt, ...)
>  }
>
>  static void verbose_invalid_scalar(struct bpf_verifier_env *env,
> -                                  struct bpf_reg_state *reg,
> +                                  const struct bpf_reg_state *reg,
>                                    struct bpf_retval_range range,
> const char *ctx,
>                                    const char *reg_name)
>  {
>         bool unknown =3D true;
>
> +       reg->smin_value =3D 0x1234;
> +
>         verbose(env, "%s the register %s has", ctx, reg_name);
>         if (reg->smin_value > S64_MIN) {
>                 verbose(env, " smin=3D%lld", reg->smin_value);
>
> $ make
>
> ...
>
> /data/users/andriin/linux/kernel/bpf/verifier.c: In function
> =E2=80=98verbose_invalid_scalar=E2=80=99:
> /data/users/andriin/linux/kernel/bpf/verifier.c:372:25: error:
> assignment of member =E2=80=98smin_value=E2=80=99 in read-only object
>   372 |         reg->smin_value =3D 0x1234;
>       |                         ^
>
> ...
>
> Works as it logically should.
>
Your right, pointer is better. I should have validated that myself.
Apologies for the noise. Please disregard all I said.

>>
>> >
>> > +1
>> > that "struct bpf_reg_state src_reg" code was written 7 years ago
>> > when bpf_reg_state was small.
>> > We definitely need to fix it. It might even bring
>> > a noticeable runtime improvement.
>>
>> I forgot to reply to Andrii.
>>
>> I will change the function prototype to pass the pointer instead.
>> In any case, please allow me to express my concerns once again, and
>> explain why I do it.
>>
>> As a general practice, I personally will only copy a pointer to a
>> function if there is the intent to allow the function to change the
>> content of the pointed data.
>
> I'm not sure why you have this preconception that passing something by
> pointer is only for mutation. C language has a straightforward way to
> express "this is not going to be changed" with const. You can
> circumvent this, of course, but that's an entirely different story.
>
>>
>> In my understanding, it is easier for the compiler to optimize both the
>> caller and the callee when there are less side-effects from that
>> function call such as a possible memory clobbering.
>>
>> Since these particular functions are leaf functions (not calling anywher=
e),
>> it should be relatively easy for the compiler to infer that the actual
>> copy is not needed and will likely just inline those calls, resulting in
>> lots of code being eliminated, which will remove any apparent copies.
>>
>> I checked the asm file for verifier.c and everything below
>> adjust_scalar_min_max_vals including itself is inlined, making it
>> totally irrelevant if you copy the data or the pointer, since the
>> compiler will identify that the content refers to the same data and all
>> copies will be classified and removed as dead-code.
>>
>> All the pointer passing in any context in verifier.c, to my eyes, is mor=
e
>> of a software defect then a virtue.
>> When there is an actual proven benefit, I am all for it, but not in all
>> cases.
>>
>> I had to express my concerns on this and will never speak of it again.
>> :)
>>
>> Thanks you all for the reviews. I will prepare a new version on Monday.

