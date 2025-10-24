Return-Path: <bpf+bounces-72086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2D7C061F1
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 13:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6ED41B833EE
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 11:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B8F2D12EC;
	Fri, 24 Oct 2025 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="myziCNpw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zzTJqaiD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9732566F5
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761306871; cv=fail; b=Mr98NLOAaQ1kXlYEh+hFqxUWHM0qQX97bJlVrX20obbqnUDnkBXwvMJIp1kNujOvM/K2xADzFYaxh3XrNBHR+6VBG4SoKrsl5pOfVKNgB/wtRD8szYvuRiQrd4ohxyKeFZlM9WZPp8NG3Bkrv8M9WJ9RKjGp9zFnlrX7snL9ZdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761306871; c=relaxed/simple;
	bh=CaGD+lLc1EiZKCt5YcC6W8S11cLKrizxhKO69P/n0+k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JwmKY9h0POSVc0UFB0n6YO/itedI+p9JoNaiEiMSy+pthcxadK0gtKFzl//wndIyPgIzdnWa9HeMMXWQXe39HzGPWmNc+DscJvFVSU83YbqpbF8YJywSw6TSS9R+k+Pu8Rmz/eTiZ2+/iAAiGL+iNolk8cJXe7BZ3Kmn3qA1dZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=myziCNpw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zzTJqaiD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3NQ2B029139;
	Fri, 24 Oct 2025 11:54:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9S9rblJmwfA5w6y0xq10Qr6uU8sUrHl+j9jTjq76MUY=; b=
	myziCNpw3lbm8eNpa+0W5MmWPJMhKxV5xcD10LdwHowOVaw5oAiIaoA30iATNW8e
	Lr4gKcJVXFeKkj9mw/j//4MBLdwuphEsF9DsmstHUys4XLmH/Oe04adwnuX7j289
	4i5cFIVM69BjJPDtnRKywXTmolzyo0Roz+Lc330dk2PVgVcR9jzV7SK1fYdus9KH
	L/Q31KC/0x5x9Ah+4JLTwCcIen/Sxsz0bsK9EWHwVBJ+/81iU1FIK3Fl2s4Rho+d
	UR00AybTcEBzmcVMWGoH6PmCFQmRobZM72Aq/UvqqVW6qvrZ/N8BirYrRrDn5xkg
	OB+kehF0skvUVS89C2B+6A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xvd0vh4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 11:54:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O9TtJQ004481;
	Fri, 24 Oct 2025 11:54:05 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bfsfp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 11:54:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0DJcmH5bR9yvzVx7/wkVr4k9p/4zNXe7uDocYC5BzoTbsuwd3yjCbpydqOed+Y8Ecw+oNDaDzsi9hkZjD3f097LtKIirM+tfkgbBvmYiHIouM4ec/5jxLiKtG9R1IQBRUfxPljTTM/M5KVmxbdIMVEQp95GLUYEwZNE/dn11wZS8ad7XLNJE5uJMzW/MuyqdPrLfUPV4yUixKxLkbybj0Y7lKu+30vYfa/U6+oCxkEoPEB7Rr7Hezmw/wsPBoKJ0pdc5M3IYo4Lc2PqVDmyL7QBJrNWfzEHpRhIjNj6A1wXiWlBvK1yLchdFPjTQGM46z5yuXQqdVyI1byBAJb+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9S9rblJmwfA5w6y0xq10Qr6uU8sUrHl+j9jTjq76MUY=;
 b=qRwrkJEA8nByc0G+3CwoqPUID2gbfSZXgEUCw+KWX+R+D7yrNzXMt+Q/8fs0MSXr2ljx90foJYIeC0+n37RBg8PeHPZGGKUkoTbKEpGTQ8Je7JYJuRNKAiaJWqf8pnND7ZtYAOJFENyk5SH4Vfy6zsnkmfmOSqv9ryOke6AWF4DZQOw0vYA7aCv2GbsndqAlYuU+r0bEuw2sVOGaOJKMYlM63iv+J5hP0QknlUzwCLRhEviIUdLiCuHS17X4QrPsgIU2xsOc09qHsTRCdTA0Sm2vUqvmMl04pyYFb7nI7x974DaDQ4XzGRvPsQ40u1XYOy0hLj7C1bbV5gmYy5NKKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S9rblJmwfA5w6y0xq10Qr6uU8sUrHl+j9jTjq76MUY=;
 b=zzTJqaiDjJTQSbhxQD0+M+/N2Lj5ePeCH+NImEpgfgvOS8Ubf+4h9bqWPcIBtBwD0oEoXmtyzQITQT1K+oYoWnd423HP9liMJ172P00auMboAa6+CpmURG/zMBHJOG+F9pukLGEFIJ0thrt25yl0gxuAwnI8hAG89rF06ebeqOY=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BLAPR10MB4946.namprd10.prod.outlook.com (2603:10b6:208:323::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 11:54:02 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 11:54:02 +0000
Message-ID: <29e31824-5bf3-4bfa-a097-07d3bc36fa33@oracle.com>
Date: Fri, 24 Oct 2025 12:53:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 00/15] support inline tracing with BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thierry Treyer
 <ttreyer@meta.com>,
        Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Quentin Monnet <qmo@kernel.org>,
        Ihor Solodrai <ihor.solodrai@linux.dev>,
        David Faust
 <david.faust@oracle.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        bpf <bpf@vger.kernel.org>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <CAADnVQLN3jQLfkjs-AG2GqsG5Ffw_nefYczvSVmiZZm5X9sd=A@mail.gmail.com>
 <b4cd1254-59b4-4bac-9742-49968109c8af@oracle.com>
 <CAADnVQ+yYeX7G--X4eCSW_cyK_DH3xnS-s2tyQLeBYf=NnzUEQ@mail.gmail.com>
 <4201e67c-5a56-44f9-ad62-897326d84a41@oracle.com>
 <CAEf4Bza27n44nNcPUtQHMS9OR1BH_NafY1xcRqhKORJMNamP_w@mail.gmail.com>
 <1b7bd33c-1b50-421c-98be-4b6c41d89e1e@oracle.com>
 <CAEf4BzZx=X6vGqcA8SPU6D+v6k+TR=ZewebXMuXtpmML058piw@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzZx=X6vGqcA8SPU6D+v6k+TR=ZewebXMuXtpmML058piw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::12) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BLAPR10MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5c38ec-fa6b-45ef-ee90-08de12f40677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekF2bmZVdHBSMTFWOWd6Z3owR1F6MURRbDZqcXp0SnJCb1cycmxiSkordGdQ?=
 =?utf-8?B?SDk3RnlqR0s0NzZ5SnFxL0l6em11aEo4N2ExVDVwRTdralY5QVBKZU1oSGI4?=
 =?utf-8?B?QWhSdkt4bjgxQlk1YUFTcG1Pb2FXYkRsc0FIWDRXMXlxYmE3MEU2Y29Bc2dQ?=
 =?utf-8?B?My9DWktLbHFRSHBvR1puazdrdlF0Wkd5OHUzODJvUUxnbFowb0xna2ZPZEhB?=
 =?utf-8?B?cGNZWFgySVFSSUtxZUcxWTIyL3BtY0FJMS9QTHdidUhvbHlHdjhHTW0vbGdI?=
 =?utf-8?B?dU5CVC9CZmZjcm9VZHlzTDBabERHc0lST2IrSFo3TGU0OEd1QklHZEN1MVJK?=
 =?utf-8?B?WWtPZzdiVUpXdzUvcHV1MHdoNmd1TkNSUUY5cEtqYWhoUjRNWHhNRHNjYVhF?=
 =?utf-8?B?VEhuWjJpbnN0OHlMUEVmdWRPUXlXdHg2TG9vc2Q4V01mK0htVXBLNytCTGp4?=
 =?utf-8?B?cWYzNTJxMUJrUzI5eUlmdDVYOFRmcmd5N1pQNkc3ZjZ2ZUZ6QUhmNHFsV0NG?=
 =?utf-8?B?VEZlRmtSeFgxZjVhdzYrd3pnWk1vUVhsTkgzRDdBV215SUVOK0poTFpCMTZt?=
 =?utf-8?B?dGxFb2MrV1VoSnJocWFrcmdMYU9xUG9hd3BqVVZobGJoN0JZOWp1ZXlZc3g0?=
 =?utf-8?B?dUpBVEZudXNIWnROUjhiazdjQ0luNFlHbVZaR0JBS0dKZk9rYThtM2w1Tzdu?=
 =?utf-8?B?M2dBanVwY2NKYTRuR0tSNWd6alVNenBaMzlyRjhTZTAxMEZjcHZhS1JBV3JF?=
 =?utf-8?B?RlpGeWxDSDc0WTRJR3R0c1VrcmcxL0J1dUFFTEFsSHMzc3BTcUovSjZTMGdS?=
 =?utf-8?B?OVFDdllwTmljZ2pOeVc0UFA2WEZwRzhia0pPbVBrL3RkdmFHTklIbFRLekRD?=
 =?utf-8?B?RmhETzUvM0pFbFdlblN2ZDdRcTVuK3U5VGZMUmMvQ2FKcHJEYUhTL3o0QkVn?=
 =?utf-8?B?d2g2T0xPbFBjQ0s1a1BwKzhPOWQxZGlhSWxpOTRvNXZyelZCRTFFak80amgy?=
 =?utf-8?B?MTQ0V3dLaktyMUZZc2d3MG1zbEFzakJBVHlGVjUzMUFvNmpvWGlUMHIzNDg4?=
 =?utf-8?B?bTBlNStvREtMaUhoQ0lxL1Z5dGxTZU13MlpQQlRXWC9kcEVwR2FtbStEcEk3?=
 =?utf-8?B?TDIwM3U4b1ZzZTVNNENNVFRSN0szajZzaFA5eDhJRkpQdzdmZS9WWkhPOXVB?=
 =?utf-8?B?cDZZRW8zbjRMRDdnYXVCaHBWSzhHOGV0QXZmakI3SXZqQkRQUGN3azBXQmR2?=
 =?utf-8?B?VFVsZHlpTmQ2clZFb0IwbzV6aXB4bW51Mm1IVXpuc3liRXJqOFNVZFNIK05o?=
 =?utf-8?B?bkx5RnJQRE0yV0VmTEV6TFhBaWVkckI5am0rUm9tenM1bEl3VkJ4b1BRRWdG?=
 =?utf-8?B?Yi85VnlEaW5tT0xQNmlCdlYxRFh4YTFGWUx2NzBHOU01bzZKQTVnbWxCL3Qw?=
 =?utf-8?B?TVZpUUFJVjhVUzFNKzdyRVZ3VllFZ3A2b1lJMFl5VlhRRkNSeEErV2gwZzhr?=
 =?utf-8?B?ZUV4UlVIOUU1SE1qTEdBbWlTR2hGQzFUWEFsYzlhV25NOUNLT2JiY1JaNnZq?=
 =?utf-8?B?bTBlWW9hZUtCa2N6KzBNN0JRRmZxUnh6YjR5WGF2TG0zVjNNTEJsdlA4Q09n?=
 =?utf-8?B?U0thWVZTaXJYVElZRDltRzR3dTZoY2tnRHpQZEhXZ0ZueU5INGN3MUYwYlRC?=
 =?utf-8?B?Tm1rNTNTNDNGODZTRjhRMTlIaXNEWmd2WCthNDdsbFo0c2ZxTW5pV1RIVkNu?=
 =?utf-8?B?UlUrRWtiTHNQbndFY09GNy9JUHY4Rm1XRFkvdFdjajdMZ1d3VkZiUncrSnpT?=
 =?utf-8?B?alJJQXlqdm90ckEwK2ZtelVvaXBvUjAySGtTcSsyakt4KytCUGpEbE9Benl6?=
 =?utf-8?B?bnlrY1R5Rlk4REpUS0FLaHhHNXZleEs0SzdVUTJFSU1qVEs0TWFIbHNsZHFB?=
 =?utf-8?Q?CFqH8MyQqsFVMDF6pDfeHaSoepxDmYTC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1dXd0F0NnphWDRMY2ozN0Vyamg1anpCSTZNSmUrMTBkemZVbkVzbDdoMnYr?=
 =?utf-8?B?ZG1tcld3UUJRdlhvWUs0N3Z0SVhMOE95cEdJRE43cXBOSXFIaTB3aUtFTEdR?=
 =?utf-8?B?K2FGaytPTFArWU5lNDB0ck0yeDBjY0IvRkxQaTVuWnpHS0R5OVBQTzhpOGc4?=
 =?utf-8?B?c2pOTXFyTkJEZlBxdDdYZ0NVc1hrR2xZdjhtT1VDbHoybDNFZUJhTDFjcDBG?=
 =?utf-8?B?UmJUeUg0emhIODdMZE9nS2dpWmYvc1l3N2NYdmlhY2lDbzN4L0pNaXgrWldE?=
 =?utf-8?B?M3B1cnZQWEFMRm9kemRENkNEQlExMjFoVnk3VThUckV0MGlUbXhxOTN4YWZo?=
 =?utf-8?B?KzFKMlA2WXR0SkY1SHorcDJlZ3F4TzRJamlSK1ZGSmdVR2JiV2VnYUF4ZCtu?=
 =?utf-8?B?MEV0UXRqTWpLMEVFakVkVnVhc1MwcFdiOEhneHd0azJxRVZ6dE5FaGdsZXB5?=
 =?utf-8?B?eGhMUlB4OFNGM0EzRjZZOGtwcGw5d1ZOSjhYZW9aOXVMcXZsd0lQNGJvSlhC?=
 =?utf-8?B?bFd2dDcrUVQvby9iUjNiMjRSQmxqWWZMdkRpV2RrSHJvQ2tsV1E2K1BncFZn?=
 =?utf-8?B?a3g3TTA0MGxZM3BONUJLZXhDL2EwU2lCcE9GWWNyalMxNW13eGJsZURqbkJH?=
 =?utf-8?B?YVViZTA4M1lBdnQrSUZBUUZRNWJ1K0JXbS9vcUNYOHpzOE55VmY1NzBNNk04?=
 =?utf-8?B?QWVQNlZnWXc3YXlBUGpueC9ydHVVQlJ5RStNUUxKekhwbmVVT1BhUnI2d3dl?=
 =?utf-8?B?UHRrb3hTZ3VhZVJVVnBZcmdDSGxFa0U0NzRJODU2RlIyZkIwS09qaVl0Qkhn?=
 =?utf-8?B?L2p2cm03UGpIOGVCTWltbDBvSHltSitkdnBPWXpHVEFPa1Z2dVdhMHgxRUZv?=
 =?utf-8?B?UTRMQmplTTZoaWJVcG5PNmlqREJtOUNVY05LNWdrMWtuTUFoQlN3TG8vYllT?=
 =?utf-8?B?TUZjbXN3Tkc5MmFHVnBpNituMmRnZlBvZTJWYjVTUTVkTEdyZDhBMVVxeVpz?=
 =?utf-8?B?RmJsVlRHcTNKQ0tIL1FHWmhDb1RCWWZOalJ1Q2w4RXVRSE1uLzBuNzFMZlZ4?=
 =?utf-8?B?TGkxdk1xTnd1YlJXNTVlU2dyQUpqVWZvdmJlZ3lYNDF3a3c3NFJBcWZSUXZr?=
 =?utf-8?B?RlV4QTV2WTFFbmxFY1hBVVJiODBTZXgzNDZHLzhJbmZFSzFjckMyWERmZW8v?=
 =?utf-8?B?NGM0OENoUHM1NUltY0ZQZTRKQTAyYk9FalRubGZTOVhNdFF2NnhycGpNWXZ4?=
 =?utf-8?B?Z2twNCtMRTZSZGVub01FSElDOE55NUZJdllMbFdVeEl0MVVTdlhuajRPa1pY?=
 =?utf-8?B?ckUxaGppTVZUNXNKSWFpVjA3RFVJdldldXVsRWlFbHNRSnA0UFRmQ25UamQy?=
 =?utf-8?B?TVVhYW9TZSs4Mzl0R1lPSGRPcE5RRTBZVW9vOTNlY1ZtV3VxUUllMldzQ01L?=
 =?utf-8?B?Y1loazQ4SnQ4dzdYMVZLVlROMGFteVErYzdiUjdEVkxQQS9pdmlMU21MWWVY?=
 =?utf-8?B?bEpVTGM3S1Q0QkRLNUxGWmxUVmM5OElTSVJNUHlCditqMzMxQnpoTDBibG0z?=
 =?utf-8?B?WnRPUjV0aHptZEE1WUtONCtpVEp2blhSQW83cFQyT0JSV3pEc0hhZEFOOG5M?=
 =?utf-8?B?OHZsUWxucGVMN1BCTUNZWndkcUZhUENQTkRFZzQ1MlNPVFI5NUU0TmdSaFd3?=
 =?utf-8?B?K3BFb2pZUnJyU2tDL1hzVDBvQVVYZ3JXeHhjejZEckthaGtIMjdzZ0tZNDFl?=
 =?utf-8?B?cnJaUU4yQXIwMmErRUtteEZOTzA0dnVMaDZrN3A4b0J5UWJJcmFMaVdOcDI1?=
 =?utf-8?B?UEpKSmxIT2tsNWs3TkMxWTdMWDJGZEIvQThsd2VKT1RNWVlUaUdSOTRZemVo?=
 =?utf-8?B?ejErN0RFYVJNcG5aSk1ZZmJ0SVRRRnNhdktrOENKY0QrWmJXVnptT1dJRG8w?=
 =?utf-8?B?R280dUpaWmdvTVZiTmxoYWltWk0vRENXTXUrZWx2elZjbTE4T0ZzckhRZzM4?=
 =?utf-8?B?WnFMYW9vSTJFUldHUW5tTWxpb2lNMWp0Z1VOOXRkUUFtVkpKbzdIaHNuNGEz?=
 =?utf-8?B?b3g2azBhNTZUWmR1RGNJakRCUUFXZEhVR3NhNHd2UkhBVkZOWkFCQmVjdnRV?=
 =?utf-8?B?eGxUZGl5djVVU2oxZTZZaHljSkcwSXRuSXUyQ2hqeG10ekxWaUl4NFFxcUdW?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zbU+TtkxSTVVOfHbsCyOdHeLFs09Vkq0Ovkih4LoKbAAituUlLAhf1B1JYiTJFphn4JyoXAKQYhY75NFwm/5ynXfUwo9Qc56g86WetyfnY2l/7teGrWcBTev483yZVYRKg+K/7PdvjwKjfcVpD8uYd5SQnPyfM+Dz4Aj/fvhXtnS9qQIR0c3NqzM70UVboXlfLmPTFlFAZp0IjMs+U9hgI0acUTqD/eJRD3f5bdOboWb2JKHdaW42waeJXPsW5XQpFpdDUZBcBWPq1g8Q/XoYD1G26ZPDiiFhKxf1aXIGeMqJr7RlBcqqO1+hqBRM80fF8o7j546RP6vGopgGWwEr+0eS61NonXSp9OzUlOQNKi4PRNeruqFIzT73nlV5IAIuAUJ4ckp2cLlA555YrmraChyvjSAuj2MyAsgzt5obWE/8OcGWFIzoYJ3UVZKu/zeDKw2C7PwKixNdHfhvpfWJABoqLMCTrO0DbBhxLFTGcuW1SafmbkYqST3PjmvFRprwRoWGtOUAhwfBT2PuSDgLuEevXdLskJNxL6/dPBl6AJ1JvivA9031pZ/Wi6VLYOSaURJHhn03xPVLX8ZahSDCcetVuCAI8A9WPmdh16FV8k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5c38ec-fa6b-45ef-ee90-08de12f40677
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 11:54:02.5591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wc9/h0J/9U67T27aLUYNBpJtF26+2LYYANdL9a4QsnX3hJykDzaEtzeWT8yIjXo5mXH2Qu5MsD5YQld/YRD8HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4946
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240106
X-Proofpoint-ORIG-GUID: bppEZR9bgf39sy9uH0t6SSVsymVvT2oZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MyBTYWx0ZWRfX58SLjSHNDHkO
 6SscwIOFrA2no08uV2VgGBAaONwOc85cICccspwasBh6ra9R8nXws7JVBH8V6LdEh7cXPzRCZ3d
 gdPCjT8fAl01oTWLVcahuWGO3Nyos5uk8zBLlzzMbDTi3fTg8oEvSuxaVvbMbgwYD/vdkQRlxuj
 VdKhaCHaP8lOLVXF5auc4ZPzpJqYsUGHQxdvD80tSlgdkwDAbWeQlbFDuNH6GH5gxXw4IessjgZ
 l+TfFADmjiFfiqoklEACQq2P1VDEFiefSzRoQPG5SrThpILpdWnNOeISJJEk4m5y00gURoDimzl
 8nd9G4Cd5QBFxALBHj7OcrMkZlP1FU6Ga5XMLk2XBrEnXWXFE/2NdnAK8GCZimcUCrHNvLhzGHM
 5OrJbjjoTV/flTJ6fzz6hA7MnIfv8w==
X-Proofpoint-GUID: bppEZR9bgf39sy9uH0t6SSVsymVvT2oZ
X-Authority-Analysis: v=2.4 cv=D9RK6/Rj c=1 sm=1 tr=0 ts=68fb68de b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=HQALAdtHUm3FcPpWtRsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On 23/10/2025 17:16, Andrii Nakryiko wrote:
> On Thu, Oct 23, 2025 at 7:37 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 16/10/2025 19:36, Andrii Nakryiko wrote:
>>> On Tue, Oct 14, 2025 at 2:58 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> On 14/10/2025 01:12, Alexei Starovoitov wrote:
>>>>> On Mon, Oct 13, 2025 at 12:38 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>>
>>>>>>
>>>>>> I was trying to avoid being specific about inlines since the same
>>>>>> approach works for function sites with optimized-out parameters and they
>>>>>> could be easily added to the representation (and probably should be in a
>>>>>> future version of this series). Another "extra" source of info
>>>>>> potentially is the (non per-cpu) global variables that Stephen sent
>>>>>> patches for a while back and the feeling was it was too big to add to
>>>>>> vmlinux BTF proper.
>>>>>>
>>>>>> But extra is a terrible name. .BTF.aux for auxiliary info perhaps?
>>>>>
>>>>> aux is too abstract and doesn't convey any meaning.
>>>>> How about "BTF.func_info" ? It will cover inlined and optimized funcs.
>>>>>
>>>>
>>>> Sure, works for me.
>>>>
>>>>> Thinking more about reuse of struct btf_type for these...
>>>>> After sleeping on it it feels a bit awkward today, since if they're
>>>>> types they suppose to be in one table with other types,
>>>>> searchable and so on, but we actually don't want them there.
>>>>> btf_find_*() isn't fast and people are trying to optimize it.
>>>>> Also if we teach the kernel to use these loc-s they probably
>>>>> should be in a separate table.
>>>>>
>>>>
>>>> The BTF with location info is a separate split BTF, so it won't regress
>>>> search times of vmlinux/module BTF. Searching by name isn't really a
>>>> need for the non-LOCSEC cases; None of the FUNC_PROTO, LOC_PROTO and
>>>> LOC_PARAM have names, so the searching that will be done to deal with
>>>> inlines will all be within the LOCSEC representations for the inlines,
>>>> and from there it'll just be id-based lookup.
>>>>
>>>> Currently the LOCSECs are sorted internally by address, but we could
>>>> change that to be by name given that name-based lookup is the much more
>>>> likely search mode.
>>>>
>>>> One limitation we hit is that the max BTF vlen number is not sufficient
>>>> to represent all the inlines in one LOCSEC; we max out at specifying a
>>>> vlen of 65535, and need over 400000 LOCSEC entries. So we add multiple
>>>
>>> We have this, currently:
>>>
>>>
>>> /* Max # of struct/union/enum members or func args */
>>> #define BTF_MAX_VLEN    0xffff
>>>
>>> struct btf_type {
>>>         __u32 name_off;
>>>         /* "info" bits arrangement
>>>          * bits  0-15: vlen (e.g. # of struct's members)
>>>          * bits 16-23: unused
>>>          * bits 24-28: kind (e.g. int, ptr, array...etc)
>>>          * bits 29-30: unused
>>>          * bit     31: kind_flag, currently used by
>>>          *             struct, union, enum, fwd, enum64,
>>>          *             decl_tag and type_tag
>>>          */
>>>
>>>
>>> Note those unused 16-23 bits. We can use them to extend vlen up to 8
>>> million, which should hopefully be good enough? This split by name
>>> prefix sounds unnecessarily convoluted, tbh.
>>>
>>
>> That would be great! Do you have a preference for how libbpf might
>> handle this? Currently we have
>>
>>
>> static inline __u16 btf_vlen(const struct btf_type *t)
>> {
>>         return BTF_INFO_VLEN(t->info);
>> }
>>
>> As a result many consumers (in libbpf and elsewhere) use a __u16 for the
>> vlen value.  Would it make sense to add
>>
>> static inline __u32 btf_extended_vlen(const struct btf_type *t)
>> {
>>         return BTF_INFO_VLEN(t->info);
>> }
>>
>> perhaps?
> 
> just update btf_vlen() to return __u32 and use more bits. Those bits
> should be all zeroes today, so all this should be backwards
> compatible.
> 
>>
>>
>>>
>>>
>>>> LOCSECs. That was just a workaround before, but for faster name-based
>>>> lookup we could perhaps make use of the multiple LOCSECs by grouping
>>>> them by sorted function names. So if the first LOCSEC was called
>>>> inline.a and the next LOCSEC inline.c or whatever we'd know locations
>>>> named a*, b* are in that first LOCSEC and then do a binary search within
>>>> it. We could limit the number of LOCSECs to some reasonable upper bound
>>>> like 1024 and this would mean we'd binary search between ~400 LOCSECs
>>>> first and then - once we'd found the right one - within it to optimize
>>>> lookup time.
>>>>
>>>>> global non per-cpu vars fit into current BTF's datasec concept,
>>>>> so they can be another kernel module with a different name.
>>>>>
>>>>> I guess one can argue that LOCSEC is similar to DATASEC.
>>>>> Both need their own search tables separate from the main type table.
>>>>>
>>>>
>>>> Right though we could use a hybrid approach of using the LOCSEC name +
>>>> multiple LOCSECs (which we need anyway) to speed things up.
>>>>>>
>>>>>>> The partially inlined functions were the biggest footgun so far.
>>>>>>> Missing fully inlined is painful, but it's not a footgun.
>>>>>>> So I think doing "kloc" and usdt-like bpf_loc_arg() completely in
>>>>>>> user space is not enough. It's great and, probably, can be supported,
>>>>>>> but the kernel should use this "BTF.inline_info" as well to
>>>>>>> preserve "backward compatibility" for functions that were
>>>>>>> not-inlined in an older kernel and got partially inlined in a new kernel.
>>>>>>>
>>>>>>
>>>>>> That would be great; we'd need to teach the kernel to handle multi-split
>>>>>> BTF but I would hope that wouldn't be too tricky.
>>>>>>
>>>>>>> If we could use kprobe-multi then usdt-like bpf_loc_arg() would
>>>>>>> make a lot of sense, but since libbpf has to attach a bunch
>>>>>>> of regular kprobes it seems to me the kernel support is more appropriate
>>>>>>> for the whole thing.
>>>>>>
>>>>>> I'm happy with either a userspace or kernel-based approach; the main aim
>>>>>> is to provide this functionality in as straightforward a form as
>>>>>> possible to tracers/libbpf. I have to confess I didn't follow the whole
>>>>>> kprobe multi progress, but at one stage that was more kprobe-based
>>>>>> right? Would there be any value in exploring a flavour of kprobe-multi
>>>>>> that didn't use fprobe and might work for this sort of use case? As you
>>>>>> say if we had that keeping a user-space based approach might be more
>>>>>> attractive as an option.
>>>>>
>>>>> Agree.
>>>>>
>>>>> Jiri,
>>>>> how hard would it be to make multi-kprobe work on arbitrary IPs ?
>>>>>
>>>>>>
>>>>>>> I mean when the kernel processes SEC("fentry/foo") into partially
>>>>>>> inlined function "foo" it should use fentry for "foo" and
>>>>>>> automatically add kprobe into inlined callsites and automatically
>>>>>>> generated code that collects arguments from appropriate registers
>>>>>>> and make "fentry/foo" behave like "foo" was not inlined at all.
>>>>>>> Arguably, we can use a new attach type.
>>>>>>> If we teach the kernel to do that then doing bpf_loc_arg() and a bunch
>>>>>>> of regular kprobes from libbpf is unnecessary.
>>>>>>> The kernel can do the same transparently and prepare the args
>>>>>>> depending on location.
>>>>>>> If some of the callsites are missing args it can fail the whole operation.
>>>>>>
>>>>>> There's a few options here but I think having attach modes which are
>>>>>> selectable - either best effort or all-or-none would both be needed I
>>>>>> think.
>>>>>
>>>>> Exactly. For partially inlined we would need all-or-none,
>>>>> but I see a case where somebody would want to say:
>>>>> "pls attach to all places where foo() is called and since
>>>>> it's inlined the actual entry point may not be accurate and it's ok".
>>>>>
>>>>> The latter would probably need a flag in tracing tools like bpftrace.
>>>>> I think all-or-none is a better default.
>>>>>
>>>>
>>>> Yep, agree.
>>>>
>>>>>>> Of course, doing the whole thing from libbpf feels good,
>>>>>>> since we're burdening the kernel with extra complexity,
>>>>>>> but lack of kprobe-multi changes the way to think about this trade off.
>>>>>>>
>>>>>>> Whether we decide that the kernel should do it or stay with bpf_loc_arg()
>>>>>>> the first few patches and pahole support can/should be landed first.
>>>>>>>
>>>>>>
>>>>>> Sounds great! Having patches 1-10 would be useful as that would allow us
>>>>>> in turn to update pahole's libbpf submodule commit to generate location
>>>>>> data, which would then allow us to update kbuild and start using it for
>>>>>> attach. So we can focus on generating the inline info first, and then
>>>>>> think about how we want to present that info to consumers.
>>>>>
>>>>> Yep. Please post pahole patches for review. I doubt folks
>>>>> will look into your git tree ;)
>>>>>
>>>>
>>>
>>> BTW, what happened to the self-described BTF patches? With these
>>> additions we are going to break all the BTF-based tooling one more
>>> time. Let's add minimal amount of changes to BTF to allow tools to
>>> skip unknown BTF types and dump the rest? I don't remember all the
>>> details by now, was there any major blocker last time? I feel like
>>> that minimal approach of fixed size + vlen * vlen_size would still
>>> work even for all these newly added types (even with the alternative
>>> for LOC_PARAM I mention in the corresponding patch).
>>>
>>>
>>
>> Yep that scheme would still work. The reason I didn't prioritize it here
>> is that the BTF with new LOC kinds is separate from the BTF that legacy
>> tools would be looking at, but I'd be happy to revive it if it'd help.
> 
> We are coming up on another big BTF update, so I think it's time to
> add this minimal self-describing info and teach bpftool and other
> tools to understand this, so that going forward we can add new types
> without breaking anything. So yeah, I think we should revive and land
> it roughly in the same time frame.
>

Ok sounds good, I'll work on reviving that series as a prerequisite for
the location stuff ASAP.

One other BTF UAPI issue maybe we should look at; should we steal one
more bit for BTF kind representation; we currently have room for 32 and
are using 19, with 3 more for the location stuff. Feels like we should
move to supporting 64 kinds by stealing a bit there too, what do you
think? That would still leave us with one unused bit in "info".

Alan

