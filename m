Return-Path: <bpf+bounces-28032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAED8B48DC
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 00:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59266B21517
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 22:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BA214264A;
	Sat, 27 Apr 2024 22:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H1GZZ15W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Unbs5fen"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E7650A73
	for <bpf@vger.kernel.org>; Sat, 27 Apr 2024 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714258322; cv=fail; b=DK7PkU9C+J3ntDIzzTdDYSM7eHQGhdJ/GYCxc4l9qYJTGDv6caNqaj3P+7iFO5evA2YpciYGbMrkFURqDK1LnwFW+Sxyr0X41iaHlXxZG/dVspsXeGxUBD+hL6k6nlfpVKr5RjpC0iPlvV0z/C8RXrAQ4+tHlvrXMNqfot6E2a0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714258322; c=relaxed/simple;
	bh=bvjbjpISXOxvnXGfR2AaaJsG2llv45xw9g04VJOE6hY=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=MLkm7r1PLWD7D4mqMKy8X+DzhnDlbaNPVaj1UTXB8aBeFDKUh93uAmc05I7ULry8m/3cz48pMM7BGLz05ljkGyKKF0hAxCEVilfAolumGK1CJ59++5zuQ7lJSMQ0WvPqySEfuVxaJlw3C2/q/aCOGFeIEwZktrutYhUQQyTsmvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H1GZZ15W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Unbs5fen; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43RMmkdc002856;
	Sat, 27 Apr 2024 22:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BCTXbIcy+cAGZuXhwvvwfj9jMOebQX66oY/wvDPKPnU=;
 b=H1GZZ15W5l7LezxYvRdl2kLNFbYTDNlPlDGDJ6b3W6LX2eqeRgQZrMSa9j0u8oUX5/HI
 J4W56ivF4lAuTc762I2OIapXsVDOehbS1q3SKM8D6hLXP4x+PzAAEzU3rGNptmsCbzVh
 yN6F8sf0AFVgpaXJj6B6OBQ/35AvKWjbzF9hT4tWUMqMyCWzM1JpR9ulJnH49N4F5CUH
 s5j+6eVp9M0YJkIKWzRKZkDnuyXZygISndVV/bx2zdK0nvDuTl9UAJt3f89XQwmeDg6C
 3HhiK9O8WoG0siRdj8YCIg//bmfLjT3AmtgK6A0138vbE7AFTr/J3neHlXxEfnTS0eua /Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr548mqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Apr 2024 22:51:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43RLiVb8008552;
	Sat, 27 Apr 2024 22:51:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt4jxxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Apr 2024 22:51:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHxHY7t2p/38nT5aynnl2GQ1srIOC4LhqLXjEYHL51+3CIIiTQ7wMt9J9DrjeZ1um8YPgV4u2s6lGnlS3zzcXZwYLUCa8rCGRQSGx1JLLIcfnjfXP0RmoxngcVWI56Vr1OgPXW/wGRwzgmJG9p97cdCK3HD7K6mGPsWh48fuuCW5n8sGNFgcjdLX4KkvhnhimKDmhJAN39IdmEk46S0Mvb2XM96okUISOz5qB1GzeUl5y2vrBK/NBk6lf7IT0Ed+nE1W2slF77Ek5CxpRq1dR1Zr9l8KiXD0WPdX8TNm9JY76hy4erk5ZQuFRtb4V/kq+LdKbi4iXxZ8HMBauU+R/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCTXbIcy+cAGZuXhwvvwfj9jMOebQX66oY/wvDPKPnU=;
 b=SpkBKAb4P69oFzuLbdWs+/QqwU1C6+XrkDLqhjh24JBDydmP975PzBoS9YxV5jkEyoH1o06MqLkJXZC34JNIgfB9B+tD6Kdf0zfPZKMYvqI/Qcm6TzWnd/Wo7YrcqATpcog3sXPGWjNnqZ92Jmq7ihZrmouEaLEnzBdAnUAiXxtPjjMNal/bcR3q2qLFPAah6y7XX+rgFwFa2xYe1tXMJ/xFlqf1ixsQECVPyOZD4MszDsdiXrhAvVAFipp0xnEHQgmJx5LBWKNsjEoPtpxuDMCv/1UM5Lq6r9EN2haM9ATaug1d8e27aVBB/QIlt1znT5cfTtE+Tu7S2V7BOK7xEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCTXbIcy+cAGZuXhwvvwfj9jMOebQX66oY/wvDPKPnU=;
 b=Unbs5fen3/IzAfAcUlmfojVvSiL6HKHOvnHmNAyhR+1B2Kw/OJFJ4pEhNV68VM+CM71XgbhJLexwDwLipHxN3SceOOempGYCp9sCVHoyRor4YiIDZfqBhJCd+uWR4PJxVbXgNbnrJyt2N5sZ+oOs+AQSMP7CVX4Dgch2jizMPMk=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DM3PR10MB7948.namprd10.prod.outlook.com (2603:10b6:8:1af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 27 Apr
 2024 22:51:49 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7519.030; Sat, 27 Apr 2024
 22:51:49 +0000
References: <20240424224053.471771-1-cupertino.miranda@oracle.com>
 <20240424224053.471771-3-cupertino.miranda@oracle.com>
 <CAEf4BzYuHv7QnSAFVX0JH2YQd8xAR5ZKzWxEY=8yongH9kepng@mail.gmail.com>
 <87edasmnlr.fsf@oracle.com>
 <CAEf4BzazPWOgXFco=PJnGEAaJgjr2MG12=3Sr3=9gMckwTSDLg@mail.gmail.com>
 <CAADnVQ+mSfUbtgk9pD+j6b3XLZJ1w7mGzbh2+t40Q81jB==wLg@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        David Faust
 <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena
 Zannoni <elena.zannoni@oracle.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf/verifier: refactor checks for range
 computation
In-reply-to: <CAADnVQ+mSfUbtgk9pD+j6b3XLZJ1w7mGzbh2+t40Q81jB==wLg@mail.gmail.com>
Date: Sat, 27 Apr 2024 23:51:44 +0100
Message-ID: <87a5lemnb3.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0259.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::12) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DM3PR10MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d2b723-3075-4b35-fae6-08dc670c9f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q2o1cHJ5anBqYWFRdXltdi9qVkZTL1hkd0hvVXYwbWdrcW13ajcreE8xR3FQ?=
 =?utf-8?B?K2QxUTVmallkYzAxRkRNV3lvaVV4TWYzbUlJREtlYlgxZEpLMW41MlIrVHEr?=
 =?utf-8?B?U2FEMDZBSzIxUG5VS1dvNDQwbVp3RjFjbGJ4a21HYzhLMlRSYzNSVHNxd0xL?=
 =?utf-8?B?VE1jVTB6aUNQUnliejZMRldYcktadDNBcjI4aHBCQTkrdzdCVndVVW90Sm5T?=
 =?utf-8?B?OUo2THROK05kRzBFNTlIUCsvY0NuSXNOWmw1eU50dVlRamlaNVgyZXNwWVp4?=
 =?utf-8?B?cnF0djJRRkRyREJSdlcrcXRHdlN4MDFZTUl4ZHFUZThCeGxDaVVlcGkySFox?=
 =?utf-8?B?OWVSMmFuRW5pby8zRng3QXhrN21kNXVBZzg4WTU1Y0xZeUxmbjgzZ085d2FC?=
 =?utf-8?B?VWVIdWM5S0JIZW9tb0VOV0Q4YUdlczhjYmZLL3E5SnFHWU9SNEhiM3pwc0ts?=
 =?utf-8?B?WGJDTnRyMW0zQldSOFR0NXFDbVBNMW5TbTBiZm1JbHA5WTFGZDhsRVZrQzdT?=
 =?utf-8?B?dnVhOThPN1NPQ0FJOUtPUk1lV01aWUxJRVF5dU5wWTZqbElpNU44Z2dpSHlZ?=
 =?utf-8?B?YTFSdzF5ODJrUUZ6NXV5ZktGcGJNOGxoeFgzLzBPcTc4K3EyWFcvOG1DZHNS?=
 =?utf-8?B?ZzJuZkJVL0M4bjI5ZVBIeU5pUVVOcnEwbVBhVGNmZFJJK1VhdFZsU0E1akU5?=
 =?utf-8?B?MXptbkUrWkdCYmtsM0U2MGlyb1BKUHE2UE9tTUNoblBrZEJOcEhhNXBoMnJu?=
 =?utf-8?B?WU5TRjRrdVZwbmpYaWEvVU01SHF0Y2duS3hHUFk5UXB5dlFEVDZRUDNodEMw?=
 =?utf-8?B?Q2I4eEorMFR0UVFEc0xEbGNUMmNYR2tjMDhXc29NQTROZWgyWVI5MHEzL1J3?=
 =?utf-8?B?QisyNk90ZUNSZDc5TFJpdzZIbHJSMVpzWXBTRjNIUFRudVJ1Slg4ZW5ueG81?=
 =?utf-8?B?TlZwZW1tZXZZM05CRDNra1VxZlVSQWpQakJwVlJac0orZDZFSUdwT0grR3J6?=
 =?utf-8?B?WC8xMVp0V2E1aW0rd3MrdURaQVR3TGw1d20xZXNJckpsQjVjS0NHN1B2dzZI?=
 =?utf-8?B?Qzc0dmtqamRsQVZoN01SbUdNaGNpSktzd05OeG85eERBelVka2ZQYVpCcnVI?=
 =?utf-8?B?M2tXUnNUSjFnL0k5cWNWSkpFMzZ3enlhVEV3VHk2RGtwemtkZmFvY2U3VVlY?=
 =?utf-8?B?TzBscTlJMVdGVVFTSjR5M04ycGdsckRpUjgvOXpvclF3YjY5V2RXQXpCR0Va?=
 =?utf-8?B?NjM3Z3FYRG13V1JsZElLZjJSOTVjOFhZSUd6NXFlaDcrQUVjVkpOYTdVZFkw?=
 =?utf-8?B?SkFCb00yV0tIZlMvVG9NSkgvN25DRnhQVWF0TEZZa2ZFR29pWWd3ZlQzODY2?=
 =?utf-8?B?OUtlSjl4am9JdDlHQkdZNlZLUlc0dzYzTVBUNXBOOGtQNGszRDZQdnNrV2p6?=
 =?utf-8?B?OVZMUC9scFBaREExNFM3ZGZGL3FoSm9DWTZaNjhhbVUxQ1N4Y0MwcmpsTXFQ?=
 =?utf-8?B?RUUwU0dFTmVCckNxQytrV1dkcldqU25WOS9NcWFNVHZBMnJreG1JNWxRczZO?=
 =?utf-8?B?NFVPWDNvWEFwYnErVXFtSUo1OVFtakNnWUF1RGRSaTBYRGJlTGxJQVpraXFp?=
 =?utf-8?B?elpNbG9GWTFuYTJjcUQzeWNlc0FPK0xSMElEdSt1Y3h3N3plU0ZMcGpTQTJn?=
 =?utf-8?B?RzNEYWNzcjMrQ0diMnpoNFRjNE1VSWlXc05obm1td2dhb1pycGxYY1FnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UXZkclBsMnFMTFY2QXl1NDh0WG5IMkFMZVhQQVY1UittdGlVdGRIVTRZR2NQ?=
 =?utf-8?B?NWZSbG83dmZ5cnZaRmdETDFuNkFjWUU0U0huZWUyZzkxREdxM3c2SW5DbW9L?=
 =?utf-8?B?N0ZmZmxNMDN2dmJsd2lxNEs0Z3VLMmlvMSs0NXVlL0ViTkdMNTZEaHhUR1Ey?=
 =?utf-8?B?WC8rNXhtT09iNXE5WmpkSnU0TjMxU2ZZQVlFWllpd0twcXc2QnU5eUtvNXVh?=
 =?utf-8?B?R0RDcHhoNXNGbnFJWjBHak5td2FpY3RJRUhsa2ROQVEyVXQ4ZWlBZjc4OFdI?=
 =?utf-8?B?Nm1PZkx2TEIrdk52VytzSGtHdUcxREp3Q1dhL0dFZjdIekgvdHNVZytZUHlT?=
 =?utf-8?B?d1dKWW1JQmVsK3g4cStkZ0k5aXhPVEdwRWlqZTBsdGF2TGE4YmNvT0RQNWc5?=
 =?utf-8?B?bWdkMVF4cFBMTjgwdW1XdkJ2TTFsNjFJYm9mNW4zcHlRY0dlenlpZHFBTStU?=
 =?utf-8?B?VXc0Y2JBeWhPcU8vL3hCaU95eEpweWVTNDYxU0paT2dERHRraXN0bktCQlA2?=
 =?utf-8?B?WmpDTHlaQUJyRmtLVXZMdDMxQ2xRakxiM0M0UnVoeGNaQVkxMy9obzNmUS9V?=
 =?utf-8?B?bWRPSGoydjNJTkJIQUU4QW9wcVpxUkNoaTI4VGdQeksvak5jaDQ0NVJvTi9l?=
 =?utf-8?B?Sjd2a056TTFHbXlTSVVUdjNSZG90KzM3Mm1WS3dYZHhHeExRNTJtVmxHSDFl?=
 =?utf-8?B?Wk5Tb3VNOU9GRHRjMCtCVHc3ekJFMWZmalgzeVJNSWFFMFZoa29Ick9TWTJT?=
 =?utf-8?B?ellST0F5aW9nWWxCbFVFRGo5VUcyTWdnazJjMkI3K1U4OVJSVk55dlhVOVg3?=
 =?utf-8?B?VTQ0M1ZYdU83NDV0bXcwZkFaRzVTaldEWFEyWmVYbmVWRHdWemRla1M0djJG?=
 =?utf-8?B?bkx2bFVsZ3U5YnpVUE1wZjdZb1FLaTAvbGRmU2RYL0hUWEdnTXpWOGFhVW1p?=
 =?utf-8?B?YVBjRWpBdUd5citYQmh1azR1SEE2akxXUlRaUmN1WWI2ZUlNYms4UWZnZTFX?=
 =?utf-8?B?M0lnL21TMmo4WFJNUUJRemk4NkRsaDNwTEZLVlg0M01UcGtidEdRdFlhZlpI?=
 =?utf-8?B?bmRsSjd0S1hzVTIxS2xadzkyS1RvVy9iaDgwS1B0aWd2UkZtWWF6TmxSQjR6?=
 =?utf-8?B?QW9jMjZoT0doN0xuYkZzWWlUeEJsZTNJNnNtL3dlaTk2RmZkdklkcS82ZXA2?=
 =?utf-8?B?dm9UQzA0bXV3S01VWEgybnBzZzQ4Rkl1d0tZYlo0SUFYeHZpM0hNRmFxaU1a?=
 =?utf-8?B?VThqaFBFeTRBVEJKdUZGdnRPSnRMV2MvaHd4WGdaQjFkTnowUWJvVGRQanZZ?=
 =?utf-8?B?Q0R4ck16emFjK21YUnNoRzJyVVplRVNTT21FNStkZ2hEVHlMSlFvb01MQ1p1?=
 =?utf-8?B?Q3ZCbTBrWXNjemhiYmRWaDhxYSs1SW5HRnFtekNKcDdHN1dOVTJab2p6QTk1?=
 =?utf-8?B?WlNwUjk2N2RJTzV1T1JhTFVscldaU0lENzJMMDQ4TnlvOEQyb3l2MVdCM0RO?=
 =?utf-8?B?ZkVYYUo1NUs4ZDQwSTIrVFNYSVViSVhWSDhNZ202VURZVEkxa0tja1JUWWZ0?=
 =?utf-8?B?T2FXVDBnRWZndDFDWG8xOUgxTDlMUkJFckdhQ0JRbk9xRnJzdVlUNStmSFE1?=
 =?utf-8?B?QUVOZlZqNVRvU0FGc3ZKS0tPaVMxdDIyRUJuZkhOQW95UTMrY3dLczVyUWxV?=
 =?utf-8?B?akZUZWVDWDdEemxrRXhKN0tFQyt0bGs3aVp2czYvNHRWRFBlKzRpaDhzUjc2?=
 =?utf-8?B?Z0RiM2Q1TkZSOHZsUnp6Zlk2S3MzL3prZEZkd1JxM1ZmeHhaMVZPaTlFdkpU?=
 =?utf-8?B?U2RIUWt4UE9SdFJaOWEzNjBLOTBKQ2pRcjFoTWZkVTNpakJiR3IrRTdkeG5n?=
 =?utf-8?B?UHJKQnowSnNaM2lmamk5Y2dwZjRtMGhVKzVIR0J1b3pNTU14ZDd4eVVJMTRx?=
 =?utf-8?B?RVIwaVZzYTNnVjZrWEV0NlNydEpmcDhkZmlZdXdwUWord1FQanJBU1lVckFE?=
 =?utf-8?B?c1A5dExObUM1N3psTU9RNEY0S0dRV3hod0tvRm1RLzFxYm1mZVdzLzQ4YnZj?=
 =?utf-8?B?dFE4NUZvdTlDOUlXeTBWU2RUMm9TNFZ1dVVYeWVlWVJyNDhBaTJLcDlLQXV2?=
 =?utf-8?B?WWVOMXJQL3MweTNjQTRiTXdMWUxPZXUvTkVRUURoK1pRVVRhMTlrcm5KaFVD?=
 =?utf-8?Q?UaCvor2hYDaLom1naKgU4Z8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BGFvVU07lDoA+/uIAJSIdzAgpP942A3LX6ea7+/GBOwbP6w1nr57hcRMQQjSHSRSBHisk5LJMZrCOYR/y959sJ7n1/hKYWlX9V4hTWdB0M+U+yv/KJM3QKCaMODZ+2TMSTvLvcsa/saJ25Ke05l/kcx/5f/8jiRcWOnjdAuko9ciF12akXB+UR5A8ql/BwKLXd0yAe48xzl5Y7SG9Ocj2X6PaxvF0Ilm+zbl75Qn9JsyMrYs5uMJDqyFn80T0k3h3SX2PSOe+8qiFBnX48LEwGt/CcE3JmnCknqTirqOCjvGSoNUyPZSyd9sqMn7xMInJSG8Em62lKjzL/P2/9le6uhMD1Tlro5G4etjhdjmMb4zbY1p3PGGFcUkvlfogA/m4/qf5nbptN8lQ7YXq1Ekr42TD9lYD/avD2SlD6mRNu6OBLlcojZ9nizmLeM7j8si5asiy8hqrP1u54R23igXG8f4vipX3c9zClBBA+I/mXd0v2x+dn9Zv1qvwuD9ftPbIRZoqerxEKGIkCh+iHAW8ouOM/vDO325NjiNREJ5AbUxc72h95Bso/QL/pKvRCIC0Sv/UXUXvtdWLWczzxNehErfofl7OA+jWyG1ztTaLP4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d2b723-3075-4b35-fae6-08dc670c9f62
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 22:51:49.4336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJq0ClY2w2jU7tz1V6j5mBRlPfGeOz1WXQzbl8HopBMM56p1j3SnhjSqQO2zFB2XGUeaxtxHyE7/XV/AbH3ZKCPWXloEQ4GQFRSN+8RKp+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7948
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-27_22,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404270170
X-Proofpoint-ORIG-GUID: DXLh4vIXQUWum7uA71dSFjah-U0AJvBn
X-Proofpoint-GUID: DXLh4vIXQUWum7uA71dSFjah-U0AJvBn


Alexei Starovoitov writes:

> On Fri, Apr 26, 2024 at 9:12=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Fri, Apr 26, 2024 at 3:20=E2=80=AFAM Cupertino Miranda
>> <cupertino.miranda@oracle.com> wrote:
>> >
>> >
>> > Andrii Nakryiko writes:
>> >
>> > > On Wed, Apr 24, 2024 at 3:41=E2=80=AFPM Cupertino Miranda
>> > > <cupertino.miranda@oracle.com> wrote:
>> > >>
>> > >> Split range computation checks in its own function, isolating pessi=
mitic
>> > >> range set for dst_reg and failing return to a single point.
>> > >>
>> > >> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
>> > >> Cc: Yonghong Song <yonghong.song@linux.dev>
>> > >> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> > >> Cc: David Faust <david.faust@oracle.com>
>> > >> Cc: Jose Marchesi <jose.marchesi@oracle.com>
>> > >> Cc: Elena Zannoni <elena.zannoni@oracle.com>
>> > >> ---
>> > >>  kernel/bpf/verifier.c | 141 +++++++++++++++++++++++---------------=
----
>> > >>  1 file changed, 77 insertions(+), 64 deletions(-)
>> > >>
>> > >
>> > > I know you are moving around pre-existing code, so a bunch of nits
>> > > below are to pre-existing code, but let's use this as an opportunity
>> > > to clean it up a bit.
>> > >
>> > >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> > >> index 6fe641c8ae33..829a12d263a5 100644
>> > >> --- a/kernel/bpf/verifier.c
>> > >> +++ b/kernel/bpf/verifier.c
>> > >> @@ -13695,6 +13695,82 @@ static void scalar_min_max_arsh(struct bpf=
_reg_state *dst_reg,
>> > >>         __update_reg_bounds(dst_reg);
>> > >>  }
>> > >>
>> > >> +static bool is_const_reg_and_valid(struct bpf_reg_state reg, bool =
alu32,
>> > >
>> > > hm.. why passing reg_state by value? Use pointer?
>> > >
>> > Someone mentioned this in a review already and I forgot to change it.
>> > Apologies if I did not reply on this.
>> >
>> > The reason why I pass by value, is more of an approach to programming.
>> > I do it as guarantee to the caller that there is no mutation of
>> > the value.
>> > If it is better or worst from a performance point of view it is
>> > arguable, since although it might appear to copy the value it also pro=
vides
>> > more information to the compiler of the intent of the callee function,
>> > allowing it to optimize further.
>> > I personally would leave the copy by value, but I understand if you wa=
nt
>> > to keep having the same code style.
>>
>> It's a pretty big 120-byte structure, so maybe the compiler can
>> optimize it very well, but I'd still be concerned. Hopefully it can
>> optimize well even with (const) pointer, if inlining.
>>
>> But I do insist, if you look at (most? I haven't checked every single
>> function, of course) other uses in verifier.c, we pass things like
>> that by pointer. I understand the desire to specify the intent to not
>> modify it, but that's why you are passing `const struct bpf_reg_state
>> *reg`, so I think you don't lose anything with that.
Well, the const will only guard the pointer from mutating, not the data
pointed by it.

>
> +1
> that "struct bpf_reg_state src_reg" code was written 7 years ago
> when bpf_reg_state was small.
> We definitely need to fix it. It might even bring
> a noticeable runtime improvement.

I forgot to reply to Andrii.

I will change the function prototype to pass the pointer instead.
In any case, please allow me to express my concerns once again, and
explain why I do it.

As a general practice, I personally will only copy a pointer to a
function if there is the intent to allow the function to change the
content of the pointed data.

In my understanding, it is easier for the compiler to optimize both the
caller and the callee when there are less side-effects from that
function call such as a possible memory clobbering.

Since these particular functions are leaf functions (not calling anywhere),
it should be relatively easy for the compiler to infer that the actual
copy is not needed and will likely just inline those calls, resulting in
lots of code being eliminated, which will remove any apparent copies.

I checked the asm file for verifier.c and everything below
adjust_scalar_min_max_vals including itself is inlined, making it
totally irrelevant if you copy the data or the pointer, since the
compiler will identify that the content refers to the same data and all
copies will be classified and removed as dead-code.

All the pointer passing in any context in verifier.c, to my eyes, is more
of a software defect then a virtue.
When there is an actual proven benefit, I am all for it, but not in all
cases.

I had to express my concerns on this and will never speak of it again.
:)

Thanks you all for the reviews. I will prepare a new version on Monday.

