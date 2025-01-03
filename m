Return-Path: <bpf+bounces-47811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB3AA001EA
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 01:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4632F162AEB
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 00:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218D83232;
	Fri,  3 Jan 2025 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B4bspPWJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oxHkvcgI"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23CA47
	for <bpf@vger.kernel.org>; Fri,  3 Jan 2025 00:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735863541; cv=fail; b=eP6VzcyQR+ReRmmmr4Em0HpvGtTY6mDaNhZ6l6D6TqJYb5A8amb/dkG/hIC+wEwwU3LnZPLXJn3kQiypiBJnZsfjNWNkSZPJzaMvgERsM4xvRuB4OESossOdUylZSdXxfD7nn3H0vTuYfm39NVCRFjIyBp9rvQ14oDPJU5889Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735863541; c=relaxed/simple;
	bh=ZY5twRR8kbZdTW3EViT7SmpSo55YldtIPVph9LskZCg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=rrlUMyK5UPMUxkj/7/k0rTEv/vQqVLyIrjyyNUm45YtXs0LhatH7I/OQse14r4C5sqefVEapX7ZfDJ12sRjZ1QQhmcg+ZnUQDwQexHo/TbsW1iJdrGvl1Xsv/FFI9+OUeqvVCojhR9374xmQRpKyChshH3U9u4EVXo/lKOqNYQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B4bspPWJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oxHkvcgI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502NNJn1017790;
	Fri, 3 Jan 2025 00:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GMysrb7CsexkDerlaWdi6paytIC6mkOKHpfZ1RAL0UU=; b=
	B4bspPWJ+Q5679Id52fNuEFp3NSatlvMAkGpaYbFXKdo3lf6kmUnBFvMHOILpXGM
	mfup968oGYLkAKscp4Q650kiHaszKUZZThHkc30E8fYg65DvF8tYnJ+J7wqrZZ7B
	A+6Bh8UYpMLvEYj9OdtvD/Nru5fKQAub3UBB4c9DX51xydAuAwKnmSQcixFyoc3o
	tvkVuhaOsK1Ip/C/x6ZotgzsmUNI/rh3YdJjdlZpB2k71mMJW1AZvyoU8xl9xol4
	AXF3tSu6dGFO/GoxvK+fGgjgm9eLrqbIuGitUZiu7AXCzs9BxkuWT6XMW0/zPXUx
	6t6Hm+ixCuHLjEqlDcc/gQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43wrb8ac26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 00:16:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502LVIOo027662;
	Fri, 3 Jan 2025 00:16:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43vry27n0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 00:16:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqgOsWPT4m+ilNu3lsIDKD+bPgKwozwnskezzvZOyBOLb1CNzuJeZq7z6qhRCKgRXsLndjbvxM+yLgP8xbdWbiR1wqhBG32k5JFziTHl/nYaOVO1nmtvyufBHc9sSTl1ZiWfnWtSfrcZhubHhd9pl+RQv24O5ZeOlxJxvgYjvdnK0OO1FbrnFxf72nWu6VVoMOKpRYC+mIlkUAf1gI1AcDRTY10WQgPjP1a9kBQ8VcJfYop2P3ZiMgV5IgGdeybl9nH9Ek39NN1MXT1JIwwiOOIP4IHJpPXeB4bs64BOk9LW25pAwvGsaJrgJlPU6lITWfPo7XMi/VN9Gw/sH2Gt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMysrb7CsexkDerlaWdi6paytIC6mkOKHpfZ1RAL0UU=;
 b=L1h2qijSld2dxA3S3GeuZXpBTSNq9957R+x8IWcKqqjd0NdDjylJLHlzAuF1p8JdMPGWJk35v+yRYl1KneFnQgJsB1bBqXg1pZExN+szXBgNRMEVxv6KmjrOeyRFLNWza+2ZFw/8URbwg20lAa2JmDmwsVJpxsQC5G8hfQAMUfQ3HOmcZhTqfVxnwNY57k14vZQfLdlj72yaRjnEF3QXBG/Mw61e3amHsvwvttTS5KO1U3ZfIShAu+THdSsF8jmriyRahsFGRfe1X40JHMJsmNmY+ZLduISzoGbV+OZIiP1BdJoZBNGz09uLuxhgiLr6WtKr0ie+XEqMIBhy5uAXRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMysrb7CsexkDerlaWdi6paytIC6mkOKHpfZ1RAL0UU=;
 b=oxHkvcgILFNc6eqz3o57uZQ+JDxZFuwdV5H/iAugBL1ebWvgVXeig5QEL1TXt2cSh73JFhRShFD4Ok922kzffF2vFY/Rp9TAD5IktBFwnkP1/BKhYpfEXUSFVwQF4Atd/xNSPXP79FOQg1VACEUnkPUj40oHBz+6syiyEWgWNH0=
Received: from LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
 by CH0PR10MB4825.namprd10.prod.outlook.com (2603:10b6:610:da::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 00:16:44 +0000
Received: from LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e]) by LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e%4]) with mapi id 15.20.8293.000; Fri, 3 Jan 2025
 00:16:44 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, "gcc@gcc.gnu.org"
 <gcc@gcc.gnu.org>,
        Cupertino Miranda <cupertino.miranda@oracle.com>,
        David Faust <david.faust@oracle.com>,
        Elena Zannoni
 <elena.zannoni@oracle.com>,
        Alexei Starovoitov
 <alexei.starovoitov@gmail.com>,
        Manu Bretelle <chantra@meta.com>, Mykola
 Lysenko <mykolal@meta.com>,
        Yonghong Song <yonghong.song@linux.dev>, bpf
 <bpf@vger.kernel.org>
Subject: Re: Errors compiling BPF programs from Linux selftests/bpf with GCC
In-Reply-To: <64d8a1a7037c9bf1057799c04f2d5bb6bdad3bad.camel@gmail.com>
	(Eduard Zingerman's message of "Thu, 02 Jan 2025 15:04:30 -0800")
References: <ZryncitpWOFICUSCu4HLsMIZ7zOuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteNbQ9I=@pm.me>
	<87jzbdim3j.fsf@oracle.com>
	<64d8a1a7037c9bf1057799c04f2d5bb6bdad3bad.camel@gmail.com>
Date: Fri, 03 Jan 2025 01:16:40 +0100
Message-ID: <87v7uw21lj.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4PR09CA0029.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::18) To LV8PR10MB7822.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7822:EE_|CH0PR10MB4825:EE_
X-MS-Office365-Filtering-Correlation-Id: 022d34c0-7328-43bf-c251-08dd2b8be77a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzlwQjF4U3Vndk92aVVKeitZbjA0SksyakJwdmpWLzlXTVFMdmJSRnZoNFdV?=
 =?utf-8?B?aERqM29yVkdVZUtUSnhYRit4b0U3TklNd01OR2lMdWR6NzVwUFRtb0hESTJM?=
 =?utf-8?B?OVdFTk1lMVMxVmwxQU5KQmNjb0NQOVRpTStGRmRIeWhObUNVeXdLamtjL0di?=
 =?utf-8?B?Z2R6RWtTcXh2ZmI1V0sxY1VwUTBnSUp0aTRwM2dwVmxSL3h0R1N3VXczdDNE?=
 =?utf-8?B?RXRXakpleGhCZkMvck01UU1KL25yZlVRaUFldVphZWRnc3ZTNlI4amxralJs?=
 =?utf-8?B?eGFEK0d3ZTFReFh4K2JJS2NwWDZtaisrM2xmQVZIbHRmNzY2YjBGODZRT2Vm?=
 =?utf-8?B?Um95eHViK0Z2bnFNSFJsVUpyZE1qVWFvd083SW9DaXNGL1ZIK2I0MG91VVIx?=
 =?utf-8?B?TE0yQzBHK0VmbW1ialNPc3RiYVVFYkhteE16MXVGTzhTK0RmQlNKNlRzMkdv?=
 =?utf-8?B?Q0JiejQ5NmNvYWxxc3hBSWp4SEtsdCt3SXE0Z2ZUckFRN0l0aFIzNWpGVmhU?=
 =?utf-8?B?VFVZTTlLVTdiM1NtcEd4aVMwWlRpdGJzVWY1aXgrUVlpMUxja2pRSG1zV2ZI?=
 =?utf-8?B?WDdDczR5LzhUeEZtekx4WXBMbHo0aWlZVDcwRkNvWnliazVqYllpV295dGhW?=
 =?utf-8?B?VE5qMXdIalRSR3V6OVo4TjFWMGhReHA0cWh1Q3RqK2l5RUtLNUtLZ2xBcFQ4?=
 =?utf-8?B?VS9wbDYwZWVsdDQvUWpCZWdrVk1wb1hKMk9HZ241cWtQbU8yaEZCSXNjYlJH?=
 =?utf-8?B?OWR4M0NPWllHM3pqa1lxbTlGbStFcUYzSTVXUEdZMTJ6NjNLTStrT0lhaXVO?=
 =?utf-8?B?N1lIL1ZhV28vTFQ3ZUJMazVvTTJMR0tHZ0F0SGR6NXJNN01rWXk2dXd5cFls?=
 =?utf-8?B?VllnMHlpWW8wRDFYUWxuWmI5WEFuVDdhSjFkZ1VNT3pkSEtnSjVlSUlGUGdH?=
 =?utf-8?B?SHdNRlNGMmY2RTViMjZlaGt5dGhxRm5MR0RXWXlpNUxhekJYMHY3cU5UczNx?=
 =?utf-8?B?QzdLK1hrRkRvWjVNbktkREtSNnhWdGZqT01ML00vYXNadW4reDVINldXaURs?=
 =?utf-8?B?NHljTGFHdllEdTFLdjVkaHMyQ2tkTEgxZXhkQ3ZxTEJyMk5KU2VJZXFlSFdS?=
 =?utf-8?B?cEo0MGJHOTIwcDRlaHN2OERaenRWSEtsSWdwUU5kMjVjRzd6SWkyem13cG9z?=
 =?utf-8?B?Y1NSS2p4aTh4anRNYitnbTY3dVRKTTYrbVlXSjh4MlRFVnZhdDRrOEYwaElH?=
 =?utf-8?B?K3JHUGVpK3A5aXZLdjNDdjJXZWVUdXJNOUl5d2xVb2EvS1l3MDFFREhtR0pQ?=
 =?utf-8?B?WUlmakpiVld5ZWVUNWtvVXVySlZJZHpwVnVjVC9ybUxtbWlUWThUUHdnWDRQ?=
 =?utf-8?B?ZnluOEFZNVVxODV4NkRzYk5rS0hqRi8xSUdwV3BEdHdLK0g1STM3Y0RuaFNU?=
 =?utf-8?B?QXYvdUowcDVTRU5kdklvRmxFQlhwRUMxeExCSy8vMGRwTVFYemtVcUpEZzF2?=
 =?utf-8?B?YXoxZHdoZWM0Q3l4aHlObEZqdndtRTM3MVNlUEc5ZkNQaGVyZ01nQzg2c3Rt?=
 =?utf-8?B?UnlyMGlSTUtDQ0orNWF1c082bDFCY3M3RnJaMnFDd1I2QUJVOTZ5QXhQRkJJ?=
 =?utf-8?B?VmZUbVB6RWl1eVgzTVQ4RUpCNTVBcHcybm4rRGdDMi9wcytkWUFYcTdrbG5w?=
 =?utf-8?B?aDZGY1c1cEZxb2d5V0RBTWh2NGxyM09SZDdmVzRSYTlTak1RejMrUjhSRUxM?=
 =?utf-8?B?bzYvUS9odTlYTkpycytNK3NrZDEvRzNDR2V4VTBDYU9CNktaZGJ2Rm00NVJR?=
 =?utf-8?B?MGpWNm5Ea2gwckNuQ0kydz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3ordTZkYnp2dmNXcVFKRnJ3OFlicnVaaUw0Ymc1c2podFdPZWE0NFk0cjNi?=
 =?utf-8?B?RFptdU5PNU1qSUdOalhnOFIzU1RmVk5abHJ1cjlpQ2FjQVp2alZMaE1Cak41?=
 =?utf-8?B?bUszQ2hXalVnRWJSOTlaMzR5MmlGNmU4dk5MZ3VOZWFXRVhDUk95MU12Qmsz?=
 =?utf-8?B?QXM1QWJpYUhuUmpaT3A5d1krSXFJb2pYd2tGSUNhSnRaUlFWeC9TanpmQ2tv?=
 =?utf-8?B?eU01VkNjcW9BVG9PQUxjcmRGQVVwM3RoV0xCTkZVRkRIQ2pjOEdtWmZYZjd1?=
 =?utf-8?B?d2N1aUNqdzBGWjlJU0thMnhhUXN6YjdSaDlNK29DZU1zSXNXbXRQY2d3eGJn?=
 =?utf-8?B?R2x4TWF6MWZ0QlFIUHJ0Ni9NYVd2bW9FTVJNTkF2Y0NOVTErbEM2SnkwVzVh?=
 =?utf-8?B?bnQzcWdKaG9rMDlEV2VTblFQaG9UV21iL3o2OEQrSjNaR2RySnZRa3IzQjd6?=
 =?utf-8?B?cThPUmpVQjZINkc4bnNObUo5bVlFdnBJdWJHblM4Vi8xU0h3VXB3c2x2VnQx?=
 =?utf-8?B?R2g1Ny8vbjl4YlpXNmNkM1NrZHVGN2ZYSTFEcjlTMGh5RUlzK0N1Q3djL2pE?=
 =?utf-8?B?ZTVZVVV2K3FpOHo4T2xvUldOWCtkZDlLYmNMYWl4V2Iwc3Y5MkpjWHJPWlpU?=
 =?utf-8?B?QitaNFFNYzdWSEdVTzg4YlV0SHM1Z2hOZUpic3hvUXBkNGxrK1NlalhlRUZO?=
 =?utf-8?B?K1JTME04YzdCYnJ6bDhqVEszTGZJK3BLVDNUUElaakoyU2xXdW9pemI0NGt4?=
 =?utf-8?B?SkRsM0tMSkR1bVhoKzRmdTZ1L0w5N0VqUjN2NWpoZWxPcm55S2tiNFVKeTEr?=
 =?utf-8?B?aGFPdnEwQjNCVkVzaEhQakVuWE5sanp0K2Q2YlcrRVdzU3lkQTNIVEFYdG1Y?=
 =?utf-8?B?SkxaODdjWU1yWHVCUngwTWp0Z2ZuSnVRMnN6em5tUkYzZ2VOc3djeWlJTHFr?=
 =?utf-8?B?YlhlYTFxSjBoWFBGek9CVzc3MWs5RnF4Z1lEemo3WkNpdVY3RlU4dDllSXJ4?=
 =?utf-8?B?b0FuZDJZTDBCVTRsbXJ6WDQ1RWcxa1V2ZmU2L3NiVmxoc1o5T0p1REhnaEVK?=
 =?utf-8?B?UFRSRUU5TGloUkN2S2syWUVCbitSUW5ZUXJYdEdKWERMK0xLemF0NDdZcFZ2?=
 =?utf-8?B?S1NzQVlxVC9ncGVtNkFFRHpCRkVUaEJRY1hOZExZZkQ4OWc0eW1wR2xBWlQ4?=
 =?utf-8?B?NzdYQzFjcXhpZGdPUEliK0NrN1RXdklzUjVTdkV3MzNkOGgraEJ0elFIenpX?=
 =?utf-8?B?NTFwc1FXZS9SMmlUME43VXdtekIvUFBsZE1JVmhzTVM2MDg3NW1DbG1PMEFP?=
 =?utf-8?B?OFk5d3NxbndXaVNDM3BUY0xqd0I1OGNXcEVZQ1Nnb09KUjMxbGJzZFp0ZDRp?=
 =?utf-8?B?UzRQV1ltVHF4cXdETkdqZDJSOHMxY0FSQjF3UEh5U2xsTWJXMHpoMk1BbURE?=
 =?utf-8?B?QUdIMXdDT25xLzJ1MnBEU0lTQkJRZ2FueGhYUHF3QmhRYjEwQWQzMUV0K3NQ?=
 =?utf-8?B?Wmk4TkZsTWxzd2ZhMkRxYVpEL0EwckFES0IyQml3anBBZit4cGV2QkYrOE1u?=
 =?utf-8?B?YkticjRyeTIzYi9MT1ErUTgrcGFGZW4rMUZENTUwM0wwc2tYaFlMUkNkam9o?=
 =?utf-8?B?czQ0RnhsUnhOcm9aTUkwVitjRFliaWg0ZGJTdnRLa3ZGZGh1OG82akJVOEps?=
 =?utf-8?B?YzBYRllFS0h1VHpreExJcmcxdWVSK2xmbnUybW1VRGJ6bmZJbjlyajZlQjMr?=
 =?utf-8?B?MzRSRk5ENFlwMklzcW5MODJ1V1JIQUFleVFPdHRlcUpJTEdqVlI3ai9XWFRj?=
 =?utf-8?B?R1BmZEkyNEp5NTY1VjFRVURQQmMzQWVmNmI0UTRDWlJJVGZ6b2VaeWlDTlgv?=
 =?utf-8?B?NUpCZ1dnSjR4TEVXRklEcTNxaStnOHluYlFWbzlyL0VoR241UjhUSWREQThR?=
 =?utf-8?B?azB4SFJQdHl6bVduQVVUR1ZVekpqN1doeEZyaU84aFBBNGVuRy9heU5XSmdX?=
 =?utf-8?B?Vkp0UFBRVnh1d3lnVGZBSDVYMUgxd21EK2J1SkphYzA4Z3N3NVhKcjcxbllp?=
 =?utf-8?B?bmFGUEo1RkpTVEV5WGVtd1NESkJEYzIxVnRLUm9BcVp3bkYySVRGUE5GaEF4?=
 =?utf-8?B?Q2dJZmtRZ3gveUVaSVhkcjVPanUvd1BPcjg0MmVUUi96WXQ0YlZEZDJFVTha?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EbsG8iGOTUxeVTasSzk8h4uRp4aud5zC0RA9LsYE08mGkGiPVcQ1Nkhhkk7IJtDBfkBgF+CljccOpHxCHd6In86c6cASY1hR2DgyZp7wSIYJUlt4yGbsJtH28x6AXEOJrIH2neHd8A2xcc8adNTFQWDnXSg2hQRFzwz1Y2JK4xJczXpaxv/jZm7rEIAw6ZLJvpxK3Kygx8DTI0Nyt1RKav6gpBQjTFB5AF763ESmJBFaXkB8COn7Xzpom7SOp6sX4cwoPQRCafYqOoj7nLyu78RAMqVmp0rumU6AObiQbHAC9YSV3WVkeBdzjZzrHp5CF2rrSRBAewqQU6VvzYcn3xHmufYltQPy+nxv0jq3EMDZ9LlXFrZT8pGcmzeiaCKfzD1siLrPsvLLBBtGhQjTGuPA27XJd0AEbI5YAHXG9VE3Mpyztf+mRfWeYLmd066LW5muyk+Ign5kVXpE7cVuRWffA7gp6wRgkG/g/SZCx0Si/21FofCWtdd8Fk9h+hbbiocYTcSwBobYd5KT2vXryiBTv9vp2oxrqk/VQ+esKUpBduRJhJPopJtuM0XLN94jgWWBgrlkJ6PSe8ZN90T0Mvc9uC75wWYCGDlhwz72lNE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022d34c0-7328-43bf-c251-08dd2b8be77a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 00:16:44.2777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2ytos9wqwQm3AFXjPWQA9Y4n5NiCjD+rD9J4LHdzj5rkTDgpgMO5WonHucEh0A5XoqSd8v2EKIn2w21wR81wHsAcxfLC+ZV9aSM6aW/mgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501030000
X-Proofpoint-GUID: cqGDozNWpMM-3Pznv2xMGjeLm5Sv1Lif
X-Proofpoint-ORIG-GUID: cqGDozNWpMM-3Pznv2xMGjeLm5Sv1Lif


> On Thu, 2025-01-02 at 10:47 +0100, Jose E. Marchesi wrote:
>> Hi Ihor.
>> Thanks for working on this! :)
>>=20
>> > [...]
>> > Older versions compile the dummy program without errors, however on
>> > attempt to build the selftests there is a different issue: conflicting
>> > int64 definitions (full log at [6]).
>> >=20
>> >     In file included from /usr/include/x86_64-linux-gnu/sys/types.h:15=
5,
>> >                      from /usr/include/x86_64-linux-gnu/bits/socket.h:=
29,
>> >                      from /usr/include/x86_64-linux-gnu/sys/socket.h:3=
3,
>> >                      from /usr/include/linux/if.h:28,
>> >                      from /usr/include/linux/icmp.h:23,
>> >                      from progs/test_cls_redirect_dynptr.c:10:
>> >     /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: error: con=
flicting types for =E2=80=98int64_t=E2=80=99; have =E2=80=98__int64_t=E2=80=
=99 {aka =E2=80=98long long int=E2=80=99}
>> >        27 | typedef __int64_t int64_t;
>> >           |                   ^~~~~~~
>> >     In file included from progs/test_cls_redirect_dynptr.c:6:
>> >     /ci/workspace/bpfgcc.20240922/lib/gcc/bpf-unknown-none/15.0.0/incl=
ude/stdint.h:43:24:
>> > note: previous declaration of =E2=80=98int64_t=E2=80=99 with type =E2=
=80=98int64_t=E2=80=99 {aka =E2=80=98long
>> > int=E2=80=99}
>> >        43 | typedef __INT64_TYPE__ int64_t;
>> >           |                        ^~~~~~~
>>=20
>> I think this is what is going on:
>>=20
>> The BPF selftest is indirectly including glibc headers from the host
>> where it is being compiled.  In this case your x86_64 ubuntu system.
>>=20
>> Many glibc headers include bits/wordsize.h, which in the case of x86_64
>> is:
>>=20
>>   #if defined __x86_64__ && !defined __ILP32__
>>   # define __WORDSIZE	64
>>   #else
>>   # define __WORDSIZE	32
>>   #define __WORDSIZE32_SIZE_ULONG		0
>>   #define __WORDSIZE32_PTRDIFF_LONG	0
>>   #endif
>>=20
>> and then in bits/types.h:
>>=20
>>   #if __WORDSIZE =3D=3D 64
>>   typedef signed long int __int64_t;
>>   typedef unsigned long int __uint64_t;
>>   #else
>>   __extension__ typedef signed long long int __int64_t;
>>   __extension__ typedef unsigned long long int __uint64_t;
>>   #endif
>>=20
>> i.e. your BPF program ends using __WORDSIZE 32.  This eventually leads
>> to int64_t being defined as `signed long long int' in stdint-intn.h, as
>> it would correspond to a x86_64 program running in 32-bit mode.
>>=20
>> GCC BPF, on the other hand, is a "baremetal" compiler and it provides a
>> small set of headers (including stdint.h) that implement standard C99
>> types like int64_t, adjusted to the BPF architecture.
>>=20
>> In this case there is a conflict between the 32-bit x86_64 definition of
>> int64_t and the one of BPF.
>>=20
>> PS: the other headers installed by GCC BPF are:
>>     float.h iso646.h limits.h stdalign.h stdarg.h stdatomic.h stdbool.h
>>     stdckdint.h stddef.h stdfix.h stdint.h stdnoreturn.h syslimits.h
>>     tgmath.h unwind.h varargs.h
>
> I wondered how this works with clang, because it does not define
> __x86_64__ for bpf target. After staring and the output of -E:
> - for clang int64_t is defined once and definition originate from
>   /usr/include/bits/stdint-intn.h included from /usr/include/stdint.h;
> - for gcc int64_t is defined two times, definitions originate from:
>   - <gcc-install-path>/bpf-unknown-none/15.0.0/include/stdint.h
>   - /usr/include/bits/stdint-intn.h included from /usr/include/sys/types.=
h.
>
> So, both refer to stdint-intn.h, but only gcc refers to
> compiler-specific stdint.h. This is so because of the structure of the
> clang's /usr/lib/clang/19/include/stdint.h:
>
>     ...
>     #if __STDC_HOSTED__ && __has_include_next(<stdint.h>)
>       ...
>       # include_next <stdint.h>
>       ...
>     #else
>       ...
>       typedef __INT64_TYPE__ int64_t;
>       ...
>     #endif
>     ...
>
> The __STDC_HOSTED__ is defined as 1, thus when clang compiles the test ca=
se,
> compiler-specific stdint.h is included, but it's content is ifdef'ed out =
and
> it refers to system stdint.h instead. On the other hand, gcc-specific std=
int.h
> unconditionally typedefs int64_t.

Yes, in the GCC BPF backend we are using

  use_gcc_stdint=3Dprovide

which makes GCC to provide the version of stdint.h that assumes
freestanding ("baremetal") mode.  If we changed it to use

  use_gcc_stdint=3Dwrap

then it would install a stdint.h that does somethins similar to what
clang does, at least in hosts providing C99 headers (note the lack of
__has_include_next):

  #ifndef _GCC_WRAP_STDINT_H
  #if __STDC_HOSTED__
  # if defined __cplusplus && __cplusplus >=3D 201103L
  #  undef __STDC_LIMIT_MACROS
  #  define __STDC_LIMIT_MACROS
  #  undef __STDC_CONSTANT_MACROS
  #  define __STDC_CONSTANT_MACROS
  # endif
  #pragma GCC diagnostic push
  #pragma GCC diagnostic ignored "-Wpedantic" // include_next
  # include_next <stdint.h>
  #pragma GCC diagnostic pop
  #else
  # include "stdint-gcc.h"
  #endif
  #define _GCC_WRAP_STDINT_H
  #endif

We could switch to "wrap" to align with clang, but in that case it would
be up to the user to provide a "host" stdint.h that contains sensible
definitions for BPF.  The kernel selftests, for example, would need to
do so to avoid including /usr/include/stdint.h that more likely than not
will provide incorrect definitions for int64_t and friends...

>
> Links:
> - test case pre-processed by clang and gcc:
>   https://gist.github.com/eddyz87/d381094d67979291bd8338655b15dd5e
> - LLVM source code for stdint.h:
>   https://github.com/llvm/llvm-project/blob/c703b4645c79e889fd6a0f3f64f01=
f957d981aa4/clang/lib/Headers/stdint.h#L24

