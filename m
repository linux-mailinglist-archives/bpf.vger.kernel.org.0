Return-Path: <bpf+bounces-78333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 955D5D0AB4F
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 15:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E76163008891
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 14:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9875E29DB61;
	Fri,  9 Jan 2026 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Cw3gpUdG"
X-Original-To: bpf@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021141.outbound.protection.outlook.com [40.107.192.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE7F35FF63;
	Fri,  9 Jan 2026 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969623; cv=fail; b=MrjtdnGVBQXoK2Vcg309jlbe3IJnVkHA2CY2+hTKz8VedasON3JnJtXFS0CTh4p3/eG87clfQ9tqxaJBV3hvBd6ylkWgxv1P2BfxfoiyZXMdxWmIRnO5+pJ6sqTFpW5egPmJs53gGuTXCGEXHU7+rYaUS2cHepWUunmNFsR2acA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969623; c=relaxed/simple;
	bh=h2YVkOuZrTCNGSw6UdMEGkagEZGV0ShQ0YIEbYoYvMc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gx4sDXYs4hIhyPS+Wmd7mAHwdEFT+rqJD8A679ORkfunrxxycsGJp/WeNgtmyR+u4jOgq+5WGfW/TnF2pDYI60ku5Hf+RN8oRGxxmWWTN2jf9ue7vr3TTcq0IuTI/HRBW47JM3cn5lTpMMaRBOe4b5YDHfmYJWN7QJ5KB/3vfv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Cw3gpUdG; arc=fail smtp.client-ip=40.107.192.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcHrY/02UWCMYJ5ISxCZ/px1mCa5G2doh792kpdA+n7UgO5s2m7Fp+tHBjfq5YJzIGyFzB/gVB9w861oriC7jzIdF+thh3fwRDEMfc9TVIok4NUwhXoMmGW9vhWMOK8PloWPrBtpXmESwL2l+yzcsAhN2WtIXPhD1U6q/TfWOpSuL4X5ISXJIv5izcoEa0IHU15fbJVCddqqE+lmc1rRLhnp2VcX0+n3Cn+5QOpasLunNV/JoT0XQhSiLTGcxPNtgDh3Xv74TS7e7lWhVFsxkP7jAysO0EK1rlo+9JvK9pRjNfWDUNZVZuPEMFFxj5qODGtWah08jTdHTlX2JnhuwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqC+hohqa8ZPdVcwGie9Ki7kGXHu8HAgAfuKul8jFw8=;
 b=s5gTs+MfiVMbHiDM5xI1y+/KTfGGO6kKXipswgB6B7naEds88wceMb+3BSACIlpr/HpFtdCPH9qk1a3+1FBLvYqUjSUOeU9YMHEQ4Eo+zNE6ICVrQvjakm3vwMdelNX/lWKWwF+txKRQuHTnmLL2ZiX+lfH+N2oVtq0xXgxII9RNcXFDHdkHhPAoekB4Skfo3v8l77SE+SeO93jTSqBaen0j3E3z28/5lJ7yfFqu6unZfWNHf2Xr4QLEfPkMcfI2GG1EDOQpyeDnCIPlJ7TA5z+tIwppQg2AZ51v+J2xLNqH7qBfchoSKmbP2GMH2mzOhJJCllwoHh64jYyU73deNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqC+hohqa8ZPdVcwGie9Ki7kGXHu8HAgAfuKul8jFw8=;
 b=Cw3gpUdGAvTpIslkJLp+2pB78HjVOBl+mflojELOCeJyRx/nbINr8JZvlnbxV39mRkwhrlxDzVPpdBphnnL4IDs1kkc08B5qA/2320fAHTEOcXRsHepsaYj0de//O3TIX0K0ODpDIwGEZesmnMcOBCajjo52SbJPNbxhlNIlKyD+dmNQ4sTweWTKnxz9FnmTMYjHZWwZ7MNLW2D+ZMIM4gKkyU3kLdyGBWhOTVhikHxkSb6QioNSeSBprEq9W5bO0XADmfcqM0KNViM4vBFG9qri2ZEgeufW8U52/J3APA/8x2GToTvHLHAHyBHTnT1Nl01H5lR98F/YQp0vaRp/Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB8250.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 14:40:18 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 14:40:18 +0000
Message-ID: <da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
Date: Fri, 9 Jan 2026 09:40:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20260108220550.2f6638f3@fedora>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260108220550.2f6638f3@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::13) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a80c6d-20ab-466e-2c53-08de4f8d0279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rk15ODdGMzBjdkl4ME5IeFNvb3VVbVhEcXZOQTZFQkhNMSswN1dBaDNkSUV4?=
 =?utf-8?B?Z0Z2TTRJNDdpdWZwVldPVlpySGZGWFE4b0QySDF4ajRmRDZhYW1ESGo5OTA3?=
 =?utf-8?B?cTJFQnJDZmUrdGRvekJIR3dIaG10bkMzbGI0ay9EOWxpM2YySnF0bDJ4MEp1?=
 =?utf-8?B?eHJzdjkxa0VJRUY2dEhVWndhVFBoZEJiNXE1MWE2SUFXcWVpSmtRWXgxU1Qx?=
 =?utf-8?B?K3FYVW5HVW4wTHM4NTBWR290YmtWZ3Q0c09nU0ZrMWxCTS9IOXZXZ2tpSUFQ?=
 =?utf-8?B?UW1RWU9WN2xEVUNhYTdDQ05sMjdkWjBCcTNGMzFDMjNPdTFuV0lTZXp0TGk2?=
 =?utf-8?B?UTlST3NYdnZycjkyYWx2UDNiYzVKUzY1bEJYRmNOYkprQWFCc05kMlpmTGJF?=
 =?utf-8?B?QTJaejN1Zy9nYzF6R2ovY1NuenVMcnhNOXJmOUFzQnF3OEhmcy9iam03NFN6?=
 =?utf-8?B?WEVQZ3FTNzhhY3JtbitlT25xR1ZuY01ZaXBkTS9vdGtsYlI4Vm5Ja2RaZlZi?=
 =?utf-8?B?NWFYaFk4V3hXcnY5OFJMVUdoaHNEbjJoUVl2bm9iTkF2NFZwb2xDVy91MSs1?=
 =?utf-8?B?cFNRY0krN0tvMmJlT2t0NllVSjZRRWdOUVlQZm90RldTR2l0NGhUZkNPZjdL?=
 =?utf-8?B?dDlKK2U1SWYrZFJoV04xUStuYW5nZEtwb0tuc29mdUE0Z3VKbkRldVRhOFJx?=
 =?utf-8?B?eElXOHJLdUVIcDJZN0VsU0pKUnRYbmVmKzMxZXUvSVNvSDFVRTFsa3hpUVhS?=
 =?utf-8?B?NllTaDl2TTR1TVdoZHFZWE1TcEJuZmRLSHlwOHJEQ3BKTDE2Rzc2Y2hMOXB5?=
 =?utf-8?B?L2RvQm9YV002aGZDSWs5dVJ6bEJNenhZUzZFZkxTbmI2RzE0SWdEMmpaSXlw?=
 =?utf-8?B?Q3dKZStwUUZGSUVaUi9MazAzY2xqRWdLOHd0T1RmR2ZEZU10TThHRk9idUNp?=
 =?utf-8?B?SFI5RUhib0UwSTBTNGZRb2ltOWpSTE5mWERnem9EMGlRQ2FaaGlaeUdCbUtE?=
 =?utf-8?B?bFFwSlN1Q2FFOFF5L00xZUQ1b3c5cmV6NHo1dGRRa0pOUExsRktHRDE5MS9E?=
 =?utf-8?B?RnJiMkpCMVhsTDRPT2g1d1JzaTVua21oN2hGNVM1YlZ5Vzd4MStKVHU0aGVG?=
 =?utf-8?B?amxZMXFmd1c4eStWVmhFQkthZ3greVhvbnoxaE9jbjdhZXk4bnFYZld4YkpK?=
 =?utf-8?B?L20xQ2pnVkVNYjNYWWI4SUI1Z25oYlcxUHg2bFZwYlRXSmZZVU15RE1YQndL?=
 =?utf-8?B?OUg4dWdiYlV1Q3Q1d3VpamN5aUZUeFVPUytQTWdmSGQxbmswd2owTkJnR1lt?=
 =?utf-8?B?T0RoaHVaN1JEa2ZDR0ZZdW5mUjBVR09PL3JScmtGYUdLbXBLNEZrbFd4YndE?=
 =?utf-8?B?R1hRaGVTT1o4T3J1dndZejZhNG5aNGUzbUxaSGkydFR6OHcxcUF2QkJKaTJ1?=
 =?utf-8?B?akl4cTNFZkt4U25qTDM1SmMxRUhxeDR3Qmswd0YwbXVLNnNrbGxDNnhQdlhp?=
 =?utf-8?B?WHNWb0FXL1c5bld0U1FheWFxTlpnMW0wYi9wT3dUWmpXMU5WOWVMandVNTdU?=
 =?utf-8?B?eDNqOUYxd05zMlZQT1l0aVhzVGUzU0RNNHVLdmUrWGRFR2sxc2lUZUx6ODdl?=
 =?utf-8?B?MzltN1JKMHBDcmh5eEVFR1M2OHJiWS9QUzcxV1JyUzJacHdodGFjZjQ1NkZq?=
 =?utf-8?B?YmtFOXErZmlWVFUydjk3cFNId2xZeUI3L0VNZ1NoeER2bXFiNWNRQnhOTVRM?=
 =?utf-8?B?Q1JEc3hMQlhKcnQwS2RHdXNxVWlYQWJxN2hYM0tQLzBtYUJPTHpZcjYrcWVv?=
 =?utf-8?B?ZWFxUjBCa3QxUUdCZWFOYTQvZk1ZSXJVbnFIRkVCK3RhZ3E3NklOeTRBL1Mr?=
 =?utf-8?B?eEVINmR3TWw1Y29uTTR3WG0xL0c4M2hxUCtnRHBDQ0s1T0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEV2MXlYSUtwYmNvUlRBUGlrMWI2VXhtbmZtc05DT2JNWVZYUDRIVkEvd0Y4?=
 =?utf-8?B?MURCWXdNdkdoOUpDZERMNEhIeDJSN3pYaFV1T3NMaTJoN3lPVGJST1NjWHkv?=
 =?utf-8?B?RWlGRERoaXIySjNVSFoxRGFkbTA0Rk5qd2o2WGdZT24rMkhUSEdxYkZFQkRG?=
 =?utf-8?B?QkpuZzhlVjRzN1hwRUwwMlZoWXN1TUc2LzgxYy9DdDRLSGprY1JvMWN1MGpY?=
 =?utf-8?B?aDlsTEdyOE4wY0hWYXg4NzJWYmJHZ3hVQStseTBUVForYnZ5ZnZwSkNpdWpK?=
 =?utf-8?B?R3AyaVFuUEJBSDI2RzY4Y1J1eHhFNnlpQmlHanorZzNDMlhpQmM5U2RvM2g5?=
 =?utf-8?B?ZFNhd2dERUJXY3hlZmNoanBNUlpRdlE3N0RhQ3RMVGwyV21oMXZtMUQ3Rkl4?=
 =?utf-8?B?enQyOWhkb3A5MXE0cTN1dDUzK2E5VmN3dnF1NG43b3NXdDlnckxCeUlHRVdr?=
 =?utf-8?B?c0RWMEF5anhMb2ZDc3U3YUxWT0RhbXAzUnI3V3ZRbkJ2SC9Xd21JVFNaQVZ3?=
 =?utf-8?B?UWhjVHpBUFhXRVVWM2tsTkpIbEpUWHBWZEVqOUpKWmR6Rjdhcyt4UU9MeWNX?=
 =?utf-8?B?aFBjWXRNTkFaZGdoVG9YK2t1bFpubjlodG5MdXVCSGxlVUpreGZraWp1OUJu?=
 =?utf-8?B?YkV4SW0weHpaaEYyYUg5SDhwVmllWlYwVnE2MjQ2blo2WTZXWFh0SGRkank3?=
 =?utf-8?B?aWxZbENwOG42VzFUREVyWDNyOUJaUUtOUmFXNnJEMmdXOU42WWp6UjY4WkJS?=
 =?utf-8?B?RGVKSWIzL0k2VkhYV0JPZUx2bWFtM1Z1Y0lCUllyYTRha2RGWWNPa1BwZzlY?=
 =?utf-8?B?OGN4TlZiK25TY21TdzFzZXJBMVo5MHZTV0l6VnVPNW1wSXNTQ21ZT1d2Yk90?=
 =?utf-8?B?NUc5OFhZYUZqUVlac0ZCM0d6dlFIOC9sb1k1Z2pVUU11SU8rVjNQL25EeXlk?=
 =?utf-8?B?dUJvcCtXendscEtKMU91UlN0MGN4Z2lVM1dIcTZZakg1aGtYcWpmRGxaNG1W?=
 =?utf-8?B?SzdBakd1THloNDdTTVhqaDJoMUE4cUJSR1kydnU2aDNzcnhyRURZdkRick5I?=
 =?utf-8?B?UTBWQ0ZjL0MwZ0tZU1ZlOEs3MDNCZm9YWXk0a1I3YSttN1lBb0RQZXY0cFpP?=
 =?utf-8?B?ckR1aE1PZURLWUJva2JKUUxFeFE1Sk92eWdJcXNBVHZyTzRXRGZXSERJdk81?=
 =?utf-8?B?cE8vY2I4ek4vNDNqSFFKaTd5SWdHZjRLSWlxNGh4MkxVZGhVdThJc3gzb3di?=
 =?utf-8?B?b3F6VE5ybmpRVEEzZzI2NVV1TDBERnducDNoRGVpZzlXMnRiY3dGbk9zN2RY?=
 =?utf-8?B?bDFnVUVTSEh5eENQbkh0MStTcEd5R0l5b2h6c2FjM0psL3pQVUFHUzJFV2FZ?=
 =?utf-8?B?RjBXMitDRVpjQTdGemRYcFg3Mm1Sa2EvVy9vTW1sV0VWMU9sQ21pdGN3NUVW?=
 =?utf-8?B?eWp5bkIyZVpuTXVyeDNDRk5qTkRLaHJOaFJFS3pIbDN2VEFRNGNwN1U1dkM5?=
 =?utf-8?B?SHcrbGF5SzBvNTNiVGZLdmp5V0NJRDdFRUhOZGRrd1RLVlFxM05GZE00NXdJ?=
 =?utf-8?B?VExmMFExdlFQZjFzQ1NJTm03ek82VDkzSmRTSmE1dEVNWXl3dWZVMXBSMmVO?=
 =?utf-8?B?ZGtmWWYxWFY4OFhTUmtjbHY5c3RvRDlrWkU1SjdYL1grTDBoVURvaHlncjdI?=
 =?utf-8?B?TXd3OE5RMmczN3hxWlh4YlprRUhFRFZONGV5NDJlQVBySWRKOS9zOEhBZnFI?=
 =?utf-8?B?Vnh4ZEZOZTJka29qYUppNk5KNkplMjIwc0xQejRsSmNOeld0dno3QzlGNks3?=
 =?utf-8?B?bjdPYWdKS2YvWFUrb3l2NFphZnFtMFM1WU5GRTVlQ2syVG16ZzcxRjhyTEFK?=
 =?utf-8?B?YS85U0NnL09DSFBGTWc4emRVYlFzamxnK0F2eERRU3VGdmUrS1Ivc1VvdnRx?=
 =?utf-8?B?Wk9wMzNDUFp3bnN1OFBmNldCS0xTei9wOUdPOCtlYTNBQ0xMQTU2R3dhOHNh?=
 =?utf-8?B?QnFMQVd1NURwdUVuSWxZdjRsQ3NqYXhVMlZhbFZNUTFlTFd4SGx5K0c3USsz?=
 =?utf-8?B?R3R5T1doOFpGZHFiSko3R2hYVlFUd3h0ZjZYenJSZmlMQUZ6T3h1SlBqb2JI?=
 =?utf-8?B?Qm9TZkQxaUdqTy84OW9BY2lxNFovYVJNSmhjZ25nb0N5dFRXMExZSmdTWXpV?=
 =?utf-8?B?VU1kcGVDVFRyQ0VwdVRnTXA4aEdEUnNGZ3IwQjhVYjlYZzh3UlNvRGgyRGZa?=
 =?utf-8?B?Nzk1elBTeVdyWXY5c3IvS25mYnhjSlF5ZUVZSW9JVUlTaWNCK3pqTmRvWm9v?=
 =?utf-8?B?bVlPWVlTM2xacmZ2MUlJaEVzNzdKV05ZZ1A3aTFNUGUyZFhXLzNCRzduaDBH?=
 =?utf-8?Q?LTfy9vKwLCgQbPCjhnNduS+jJSKeSmZFyuuOR?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a80c6d-20ab-466e-2c53-08de4f8d0279
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 14:40:18.4952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykJ534+l1uR7tDdplBfXPpu9uh7yCnmor1Y4ArzxFMfeNH9E+FqKmcelUl3xm9t2YFCOjk0LlR/IqzKUKhzDUrXEcoGpDUCJzxLqSE+kofY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8250

On 2026-01-08 22:05, Steven Rostedt wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
[...]

I disagree with many elements of the proposed approach.

On one end we have BPF wanting to hook on arbitrary tracepoints without
adding significant latency to PREEMPT RT kernels.

One the other hand, we have high-speed tracers which execute very short
critical sections to serialize trace data into ring buffers.

All of those users register to the tracepoint API.

We also have to consider that migrate disable is *not* cheap at all
compared to preempt disable.

So I'm wondering why all tracepoint users need to pay the migrate
disable runtime overhead on preempt RT kernels for the sake of BPF ?

Using SRCU-fast to protect tracepoint callback iteration makes sense
for preempt-rt, but I'd recommend moving the migrate disable guard
within the bpf callback code rather than slowing down other tracers
which execute within a short amount of time. Other tracers can then
choose to disable preemption rather than migration if that's a better
fit for their needs.

> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 3690221ba3d8..a2704c35eda8 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -222,6 +222,26 @@ static inline unsigned int tracing_gen_ctx_dec(void)
>   	return trace_ctx;
>   }
>   
> +/*
> + * When PREEMPT_RT is enabled, trace events are called with disabled
> + * migration. The trace events need to know if the tracepoint disabled
> + * migration or not so that what is recorded to the ring buffer shows
> + * the state of when the trace event triggered, and not the state caused
> + * by the trace event.
> + */
> +#ifdef CONFIG_PREEMPT_RT
> +static inline unsigned int tracing_gen_ctx_dec_cond(void)
> +{
> +	unsigned int trace_ctx;
> +
> +	trace_ctx = tracing_gen_ctx_dec();
> +	/* The migration counter starts at bit 4 */
> +	return trace_ctx - (1 << 4);

We should turn this hardcoded "4" value into an enum label or a
define. That define should be exposed by tracepoint.h. We should
not hardcode expectations about the implementation of distinct APIs
across the tracing subsystem.

[...]

> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -100,6 +100,25 @@ void for_each_tracepoint_in_module(struct module *mod,
>   }
>   #endif /* CONFIG_MODULES */
>   
> +/*
> + * BPF programs can attach to the tracepoint callbacks. But if the
> + * callbacks are called with preemption disabled, the BPF programs
> + * can cause quite a bit of latency. When PREEMPT_RT is enabled,
> + * instead of disabling preemption, use srcu_fast_notrace() for
> + * synchronization. As BPF programs that are attached to tracepoints
> + * expect to stay on the same CPU, also disable migration.
> + */
> +#ifdef CONFIG_PREEMPT_RT
> +extern struct srcu_struct tracepoint_srcu;
> +# define tracepoint_sync() synchronize_srcu(&tracepoint_srcu);
> +# define tracepoint_guard()				\
> +	guard(srcu_fast_notrace)(&tracepoint_srcu);	\
> +	guard(migrate)()
> +#else
> +# define tracepoint_sync() synchronize_rcu();
> +# define tracepoint_guard() guard(preempt_notrace)()
> +#endif

Doing migrate disable on PREEMPT RT for BPF vs preempt disable in other
tracers should come in a separate preparation patch. It belongs to the
tracers, not to tracepoints.

[...]
				\
> diff --git a/include/trace/perf.h b/include/trace/perf.h
> index a1754b73a8f5..348ad1d9b556 100644
> --- a/include/trace/perf.h
> +++ b/include/trace/perf.h
> @@ -71,6 +71,7 @@ perf_trace_##call(void *__data, proto)					\
>   	u64 __count __attribute__((unused));				\
>   	struct task_struct *__task __attribute__((unused));		\
>   									\
> +	guard(preempt_notrace)();					\
>   	do_perf_trace_##call(__data, args);				\
>   }
>   
> @@ -85,9 +86,8 @@ perf_trace_##call(void *__data, proto)					\
>   	struct task_struct *__task __attribute__((unused));		\
>   									\
>   	might_fault();							\
> -	preempt_disable_notrace();					\
> +	guard(preempt_notrace)();					\
>   	do_perf_trace_##call(__data, args);				\
> -	preempt_enable_notrace();	

Move this to a perf-specific preparation patch.				\
>   }
>   
>   /*
> diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> index 4f22136fd465..6fb58387e9f1 100644
> --- a/include/trace/trace_events.h
> +++ b/include/trace/trace_events.h
> @@ -429,6 +429,22 @@ do_trace_event_raw_event_##call(void *__data, proto)			\
>   	trace_event_buffer_commit(&fbuffer);				\
>   }
>   
> +/*
> + * When PREEMPT_RT is enabled, the tracepoint does not disable preemption
> + * but instead disables migration. The callbacks for the trace events
> + * need to have a consistent state so that it can reflect the proper
> + * preempt_disabled counter.

Having those defines within trace_events.h is poking holes within any
hope of abstraction we can have from the tracepoint.h API. This adds
strong coupling between tracepoint and trace_event.h.

Rather than hardcoding preempt counter expectations across tracepoint
and trace-events, we should expose a #define in tracepoint.h which
will make the preempt counter nesting level available to other
parts of the kernel such as trace_events.h. This way we keep everything
in one place and we don't add cross-references about subtle preempt
counter nesting level details.

> + */
> +#ifdef CONFIG_PREEMPT_RT
> +/* disable preemption for RT so that the counters still match */
> +# define trace_event_guard() guard(preempt_notrace)()
> +/* Have syscalls up the migrate disable counter to emulate non-syscalls */
> +# define trace_syscall_event_guard() guard(migrate)()
> +#else
> +# define trace_event_guard()
> +# define trace_syscall_event_guard()
> +#endif
This should be moved to separate tracer-specific prep patches.

[...]

> + * The @trace_file is the desrciptor with information about the status

descriptor

[...]

> + *
> + * Returns a pointer to the data on the ring buffer or NULL if the
> + *   event was not reserved (event was filtered, too big, or the buffer
> + *   simply was disabled for write).

odd spaces here.

[...]

>   
> +#ifdef CONFIG_PREEMPT_RT
> +static void srcu_free_old_probes(struct rcu_head *head)
> +{
> +	kfree(container_of(head, struct tp_probes, rcu));
> +}
> +
> +static void rcu_free_old_probes(struct rcu_head *head)
> +{
> +	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
> +}
> +#else
>   static void rcu_free_old_probes(struct rcu_head *head)
>   {
>   	kfree(container_of(head, struct tp_probes, rcu));
>   }
> +#endif
>   
>   static inline void release_probes(struct tracepoint *tp, struct tracepoint_func *old)
>   {
> @@ -112,6 +149,13 @@ static inline void release_probes(struct tracepoint *tp, struct tracepoint_func
>   		struct tp_probes *tp_probes = container_of(old,
>   			struct tp_probes, probes[0]);
>   
> +		/*
> +		 * Tracepoint probes are protected by either RCU or
> +		 * Tasks Trace RCU and also by SRCU.  By calling the SRCU

I'm confused.

My understanding is that in !RT we have:

- RCU (!tracepoint_is_faultable(tp))
- RCU tasks trace (tracepoint_is_faultable(tp))

And for RT:

- SRCU-fast (!tracepoint_is_faultable(tp))
- RCU tasks trace (tracepoint_is_faultable(tp))

So I don't understand this comment, and also I don't understand why we
need to chain the callbacks rather than just call the appropriate
call_rcu based on the tracepoint "is_faultable" state.

What am I missing ?

> +		 * callback in the [Tasks Trace] RCU callback we cover
> +		 * both cases. So let us chain the SRCU and [Tasks Trace]
> +		 * RCU callbacks to wait for both grace periods.
> +		 */
>   		if (tracepoint_is_faultable(tp))
>   			call_rcu_tasks_trace(&tp_probes->rcu, rcu_free_old_probes);
>   		else

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

