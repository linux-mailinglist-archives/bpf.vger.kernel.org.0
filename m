Return-Path: <bpf+bounces-63329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42549B06164
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 16:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E4E5A4E9B
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 14:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E04221F34;
	Tue, 15 Jul 2025 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PzaXrBtG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xlYGddKM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CFF224F6;
	Tue, 15 Jul 2025 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589567; cv=fail; b=Dc9ZSehXnmbfC8eZn268GQZtNHje3EWz1Q21xsGjGdB01Oc7Fs3sOnTBrXdGSgeJgpPmi87/Ey05F7Jr+gCCBOQXw3RxxA5O3ageFUYOmlojNg8HCthtinSUKJEMK5VZMwx1hdYaCa6PP9b/VHMGZvMSX7OZeDn0BGQFbHqBxrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589567; c=relaxed/simple;
	bh=w/BgtDr0+zg+cF4vmnc2rQUpEr1MLw+GjBkKjmbK8DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UbZvCEQaeVfYdCzk7foiV81ln2ASq8XGbezkuXv4WnO2FNEGHVQXu+VQLtZW/1ETA1u3tuw+189+z1LJ+7RJofyBTVMb5bmA6p0DLT6Qf++iilOMWX25HeYliiHuOUEjiKv9WAXRLUPeze3Id4Ek7GS2O216M1ah1DfzE7E2CmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PzaXrBtG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xlYGddKM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZFZg025924;
	Tue, 15 Jul 2025 14:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=NK2hme1nbLezxKRuBv
	PrQE+kWQs/r4uqhuSFn4Z3H5g=; b=PzaXrBtGlNZGFKkPMRPBA4GGpPcCCQzWEt
	dnIIlrhg7Tnwpqse2wvg7BA1UhZbvkne0cj68kM71rIftEYXz30P//Sd5LCKdEum
	LiqXCwwXTNuE+JEcRtgZfD5xET0eeRI5e5rJlka3SoFQlo+7RL/pydyKGczx8zUI
	YYpNKRXoGosj2QOwAnQEwWd25lo58ceWoIcfgogiuiRhUBLurgo5ScS/Ggc3iCYy
	QJdNo5weezmohrlVCJwgptnqGSpF/K21tlMHJmQ5XYnhmAexqkGFtFA6S00DoYpx
	KwqwlcZ/zvzU6ynkC8HlbExPc1v6buOq9nmpO86FiadUr2aaQ1gg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr0xq9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 14:25:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FE5SuK023999;
	Tue, 15 Jul 2025 14:25:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5a1jyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 14:25:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kj83mQ5GDJDzi6cgmg4tzVq3pz7LIq+8nb2I3vs9IBVCQaNf4OiL/H6Oewu4lp9heVHnoZ+nHc6P6XKzbg5BrNgZOh6pO/Ef+tv4HV4FQZQ1gG7enbs7t9UeS6k7hjrO3qEiKnNc/TGy8epavszDK5xJ6cfs4RGuKVTMGqWijJ5ERRrWoOYU2KBby1zRSlRdn3x4P5+8JoFHaQMybkgMOmzQ5Dk7HlW0P37qhzMCWAyrIpDoqz6EuTtm5OdAJ7yXVDJ3bnr7rYIvRDBysUXgyG7i2izGpNdl4aOnwHLsDZlRa3CziSnqTYtTBgSX7PFCQsOdAxDDhyk4cbZd2M7ulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NK2hme1nbLezxKRuBvPrQE+kWQs/r4uqhuSFn4Z3H5g=;
 b=MOQm6Py7z+p5Hjr5FBy33L420W+sRg2e0Cx83OtEt1bDoZ7vmomyNJTYrcaRpdnsqihYNClEFMScllL8OT3ly3pvZAhpsvITwtvy0imgH6YEqSD6WSNyQV97sKuQq+8OLQXeo3IZetk+i/Xw8QZqFG2OTrtpsGKA6dtEyGhpDh5h4lWjolHSTu5jDwh0jhMYu2o5S7fyb9TJDw892RYiv7IHOqrDDtqSNk4hKYcXouRg87VgWTp5Ld4eq28D8q7cyNi/Gx2Ye+qhbpV8Fe5xhAZGwo4iLa4a0/ejlSZHp1/8GSx5ElHRyClxwdt9jfOVCZclzpeUZ+ws4almPVsPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NK2hme1nbLezxKRuBvPrQE+kWQs/r4uqhuSFn4Z3H5g=;
 b=xlYGddKManRIwkwPB3aAMYS3rkvOR6MU9gcKqR8SPXsLqBjJAoMmIcROdWcakJMnYmCgoJvvYjruoCX9POJtRJ7d9XV+KZNsSBBAAgEvGPdUBhzPqkM762cvoHpRrW6Jb3KAacB7WkzftNX5llgX8W31tXtQFJCsmlDO/0gXPtQ=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS7PR10MB4991.namprd10.prod.outlook.com (2603:10b6:5:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 15 Jul
 2025 14:25:34 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Tue, 15 Jul 2025
 14:25:33 +0000
Date: Tue, 15 Jul 2025 10:25:29 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, bpf@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v13 1/4] mm/vmalloc: allow to set node and align in
 vrealloc
Message-ID: <vbrmz4m3wuf6hh3gcqfaumtmm5q2ghneofpmwbspfcgp5vx27r@qoh3wu4tg7z3>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vitaly Wool <vitaly.wool@konsulko.se>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-bcachefs@vger.kernel.org, bpf@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
References: <20250715135645.2230065-1-vitaly.wool@konsulko.se>
 <20250715135803.2230193-1-vitaly.wool@konsulko.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715135803.2230193-1-vitaly.wool@konsulko.se>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::18) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS7PR10MB4991:EE_
X-MS-Office365-Filtering-Correlation-Id: 548c5d7f-8bd1-45cc-bdcd-08ddc3ab753b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V59QX/braQ/70f5uCh8pxQyOCvfiQQ4NZZpvhr11BsNxsGTNUtcuxKyuX4Qa?=
 =?us-ascii?Q?PFfg15tt8icoPu7gk4j2T+HxhHoNLsjUaCzC3tR0BIrI5uZGAcGLc5I8dmVD?=
 =?us-ascii?Q?jBaUAaLDbJyLnHsVIsVb6ORgLhGUpr915nCgj0cSibx57QnHhWkgNiydTeDt?=
 =?us-ascii?Q?cyVwMYrsGHyj11O0vZzNOq26HaumZuU5H8RRgrABdvQ9YHEubd7k4sMAh9A9?=
 =?us-ascii?Q?3VnxdruMGACZcyiRt+kDAFYT7CQtq/apkUsojTbdG8x1iKRZqqYQ5eJEdJ6T?=
 =?us-ascii?Q?P9gAjn0T7SUtaeYLU5wxODnABkoC2J3S/fmUbM8DdMCuT61bV+fS01n/97u/?=
 =?us-ascii?Q?OCV7cWvkHzTKZjdBZhok5DWeDRaG+c4qyKTLjziGDV/lku559Gntyi7z+ayR?=
 =?us-ascii?Q?gJn17Tvk+CTrjOw879pl5jY18PA9q/IFYTpIs7h/3Ls1FviLgzKaSo+j4sQX?=
 =?us-ascii?Q?cj79/MUUiCr6xM4ewed+v1uVP/3YbIvwPtbQgpDHg0e3UAQVeRLvYfUgm/2X?=
 =?us-ascii?Q?RDoGD7JxbXCuenKY5pAcOaQk6Rm7jJUk7O7/SyiSPwPV4DS9bAxj4yFJC6Rp?=
 =?us-ascii?Q?FxhM/9tT1F4XR6BWH84qOQaOpSjNQ+EzwDC+CjAXUT8UTWnXg6MzwP9LsDAX?=
 =?us-ascii?Q?0/R0XCR58BQVwBN7rXGAZlC4JIbXhNvacTeIOO6ciQc3WOYj7ZEK1CJN1boc?=
 =?us-ascii?Q?YpfyNn/DIIwYRsEf6A/Y+mImDGlc1Lcnq7yLGJU085UisDAkNYsQjc3PNglZ?=
 =?us-ascii?Q?v/125cOBaiBFfWeF4sxW8NYE31F1O4Y4TXWBjkowKFBmyip4MAyAFisY9X6O?=
 =?us-ascii?Q?6eK6nHid5+znFug8c45bMii64TDtNmMIASLIdkuJ1vUy6lTpqEh2IFKXOGLL?=
 =?us-ascii?Q?qbhKGziau+D8UGL9ZOKVe6/wzKYZ0HQ4n9g27h1sbnWZKlrLRFosuyKahoEn?=
 =?us-ascii?Q?YO5DY26S8zwazrVV9La76H4bmlZM0Kwst2SwBXHOcy03c1VeqQh7zc9/JNJr?=
 =?us-ascii?Q?bCjt79d7bKaMDjf8B0GtSaPVjzfWQ1fdp1IfXTNPWNjI9p2bCXsiZHi+lTAZ?=
 =?us-ascii?Q?20jrLgSQvQwOE/wT6zNUlPr3e+UwZ6j9WZmSoGkXLblTAgUBbMP5W+B3lGdM?=
 =?us-ascii?Q?CISltrFCl7momgKMPTs0IxWhpNEU2XvP3fd2+5Oc+eTdFo9P1lMPFbYi1j+6?=
 =?us-ascii?Q?ormeVdGynoC4OUYUCZqQUX0gJN5unFmMBhRuazqEp+k42WY2vQ55V7t38VVs?=
 =?us-ascii?Q?yL6MI49y3zYTI96emAvwgySh9rmk18NBcflzfk4VHoug6wKLUhQx27v72R1F?=
 =?us-ascii?Q?4HLPK31uvPJJ1fJEL8k2bYABpsKu9vxA7ytIvg2xrADRzPvuokeY6dcDlVOD?=
 =?us-ascii?Q?SlstcJ/f49WCynwxw0kxEWbDULVCl50wxxx66dXje3XtDF6fEYdcCYxRdyFt?=
 =?us-ascii?Q?u3b90Vyw2Kw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mGpyWt649SmHmkfAh3N5nIO6TjGFZ1cBg8ZBxmFJbKQzFvFBrTquQ9IYBjei?=
 =?us-ascii?Q?+82DPXLIasIDQShqp1TanvJNlwA8VxnnFGto0AOPwEhgWNtZ0v5wlaGG/WYM?=
 =?us-ascii?Q?vnxFv2Yma2JEjdmb+2wJ2CBFEhgy6r0A6sgUaxL/eLYpiamC2bLiqC4VUqUZ?=
 =?us-ascii?Q?d5r33pnMCz3JgaOYNTI4oUnjOMiwD3mlr7fgkre9y+55oA/fjAED6UkrCegg?=
 =?us-ascii?Q?au4H3h9AAwVjADtvXoy6O88gc37rxvDiVYkADM73FS2MnyZdhqpxIjAQ6Fkk?=
 =?us-ascii?Q?ZNowQpAdTc4H7PHoP0P7enS7KD4ck1rmdBUoGN9ywWPe0YeIfJhr1rzs/hJO?=
 =?us-ascii?Q?U0hG78pcAtEInlIjUb4q+hO7Y6ncCzTuQShtYrBxK5jo7lvrv8/QjPfeXeMJ?=
 =?us-ascii?Q?n/BNAP3SWpu1xl01AtT7PO5nVHjfzibhRHQhm6EefQMy+vW+WY8h/KTGc3gi?=
 =?us-ascii?Q?ZHmwqyGRjh1n5CSYjUd777J3Iv6YXYXgjmlFO4ZN2kn4qhYoFi+QIllm0W+X?=
 =?us-ascii?Q?flhn9mgJ5ZXNfUyF2npanFxqzjstbO/jDVpvq5/6IzxU5qwbCvvGHbiZSjT7?=
 =?us-ascii?Q?bZ9r+RJGXcKL/zfS5NEfLf3PHtgZpi6P+bd3nhIrKdyzSEaiZbyQINCa5mhz?=
 =?us-ascii?Q?bFRrj4UD1PW/EACjmE/mRwGMxC02hTMUZEsFFx7BySuyw9kORQyj68lujtHa?=
 =?us-ascii?Q?mAIt1mSgYlmpvA4GkE+dYtO9CW+TpDheTy4AsKNt4nbja9bFK27W7fgr2c9y?=
 =?us-ascii?Q?lORza8e4pYkjJk2KR+YC/0lXiaIKYYYU63kZUw/FkyD6rJdSnpV/KQfvcEFF?=
 =?us-ascii?Q?8MCc58AT5tp03Pvg+F6qQHG/aw8HhGCRu1H1vb8hFyj9LFM9g2JxH7TrJ6Yz?=
 =?us-ascii?Q?28wzn4JeiqZJ7uNOEhZNt+Cq4+AX/+lxg+mi/3mwxCL7Kqul5/w7KyY3+7g8?=
 =?us-ascii?Q?V5Igi62SB1zGZESBz7awfx8MNW41b9tLB3VO8fmjp2BRUcUSXf3E/Ig/HnMG?=
 =?us-ascii?Q?0HR1rdqasQeJtBdL5Cs8D4byK0VEG3ARq4qI2NtCluikh/YAucWYlEXDnw8n?=
 =?us-ascii?Q?5SRWi8AfXfxASgO4uAmtOzMemmBmfZgBnDKtXBHgad/ff9YUqXNChDub3gM3?=
 =?us-ascii?Q?JLbUzSXuRp1MeCl79v4PUS9RtfHyCNiEsv6bbdGm+q2ivjHeO4AVxhIQrSQi?=
 =?us-ascii?Q?PqJmejBP6gRpKcvW/mBcCPIV/ax37lVosKc8BXxAADdh2Pju2O4IZuMbGdFD?=
 =?us-ascii?Q?an5fb4lIG7TBgpjx1LMH2tuOq7wWs02twwB/WxPOdkVfkg18ali5G75R92N/?=
 =?us-ascii?Q?eQ7l0x15JeeHGG7EWdxth9ANymsQG+YEUCq+Z0Hw/8janC/2rQGpYEXzgHjb?=
 =?us-ascii?Q?CAX3St5a0dNV0UR2mjzTsE5MjLnBFUY8pEesoOnvDMDJQYHIbHGCzSxsLwVe?=
 =?us-ascii?Q?d/4L0PPpJGJhqK3TFkBmEsD7xjcgrcFTZmMWe0ILGMOuSqzEElIx9jcjkrs1?=
 =?us-ascii?Q?6JXcQS732oiRoo/+xNUKUgxWFvMpkwZHh7J4OUoOxc0eoNhGYxkfPNV25fvl?=
 =?us-ascii?Q?lZU9vB6SYwt8yS0BF9eMTG3mPW2e5g3skvUuaMol?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	evt/ykkqhZWkmvA+0IeqKvnAb2XUuAcxPdDHzNXsEJkuy5++KkrJAyCxOfAIY5aVWIolwOxQ7zYPVQQ0nCpRWTodQy0rKwz8sKnIAKi6PCIGPNOYOkw3NtlWGOj9qi6YY50kobk4HpZbe1F0zbm1/nB2LbRinrLwODEQF6PigRC3xn0YYA0dxyIgpd2LPRICBMf76HrfZBTShaj0ryhZEKhW2JYumU7f22Vp5Q8Q2z5iCLH7AwmAkq3cgPBF7ZCfH+62D18tzAsuRdoF5qNA5GBRGiubvMiHpn+FvIOdABZIn6492I8afQgLBxsx5FNW+bEMFOU7NQCv5Yf7I6OTwUqi1M3aeXwMlElTgARFEAMGnl6ceOxlVtwupM+MsDs5s24r3XkGoLgIDjE1ZNeaB4RZpXNdiFr0b6mq3BEnpZR3bUMiyBc+pgEiYlOQ/OMFbM/pVbwwjeUiJFmk3hUlQw3cSAxc1TWOeCEoK9zfs9k+6D/yo9UrEOiuqKp/glXg5bCdRc5EzgLj2iPzXMjZbr0pPApbkO2wbzftyxK5rgMRyvbbQ+8QQGgNiRTgIzDzqsp/JQzB3GtCBICjfLQG/aqYnf5bgCm0TTUwzC54GF0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548c5d7f-8bd1-45cc-bdcd-08ddc3ab753b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:25:33.1465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zYQPVHpHIQnRC/ZFDozpIRSJg4s8CSqcSiGL74GU0JQKFnJ/9y/y7dIL0UVTZeM4OOIY0DMmSVgy2kOC08KgDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150132
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=687664e2 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=Y8mYsLuOk6LQwvwhDr0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: bpjtIarNtMztM8083Yq5AX3wOo5l-vvI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEzMiBTYWx0ZWRfX0xHjp9+e9Usd L4h/rj5JAAlnf51jhEQqvwuAUAqlMmYyP93wJdq3kI+IecapwYHCMWso1bDO8k4m65b58UMsiEa rVVqzQKU+5AXK5dM5Zkj0VfzcVaFTcwvlxsvb+srz65xWGp1qFFx2psofTEz3j0+znCMmLykBA2
 TklsCCTJLCgIKdWs9lDctGMDhDzgbAPgLEJQ3IEXQPNxrjF7uG2yEqXxgDOXi3Fibf28l0N7wxV 2Av328DRcT1secF5A/1ff6PySLHjRleChoum5rw3FOZNh/alg87xvcvxRFSmL80HfFZl1eBow7c Alq3naF8GSl4mQUzCkBGD38FF3ZxroNHM3ar/USXcW2KgCz3W7i4g6WppSr5ZZzjb49Vm3Uw+np
 6CH2TlnxsqvUEPYtjZTGYdDWIqyv4X7qqoHqsrRkWYMDuiPKOcBt5dmsWngHjbK/M5A3TdDK
X-Proofpoint-GUID: bpjtIarNtMztM8083Yq5AX3wOo5l-vvI

* Vitaly Wool <vitaly.wool@konsulko.se> [250715 09:58]:
> Reimplement vrealloc() to be able to set node and alignment should
> a user need to do so. Rename the function to vrealloc_node_align()
> to better match what it actually does now and introduce macros for
> vrealloc() and friends for backward compatibility.
> 
> With that change we also provide the ability for the Rust part of
> the kernel to set node and alignment in its allocations.
> 
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/vmalloc.h | 12 +++++++++---
>  mm/nommu.c              |  3 ++-
>  mm/vmalloc.c            | 29 ++++++++++++++++++++++++-----
>  3 files changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index fdc9aeb74a44..68791f7cb3ba 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -197,9 +197,15 @@ extern void *__vcalloc_noprof(size_t n, size_t size, gfp_t flags) __alloc_size(1
>  extern void *vcalloc_noprof(size_t n, size_t size) __alloc_size(1, 2);
>  #define vcalloc(...)		alloc_hooks(vcalloc_noprof(__VA_ARGS__))
>  
> -void * __must_check vrealloc_noprof(const void *p, size_t size, gfp_t flags)
> -		__realloc_size(2);
> -#define vrealloc(...)		alloc_hooks(vrealloc_noprof(__VA_ARGS__))
> +void *__must_check vrealloc_node_align_noprof(const void *p, size_t size,
> +		unsigned long align, gfp_t flags, int nid) __realloc_size(2);
> +#define vrealloc_node_noprof(_p, _s, _f, _nid)	\
> +	vrealloc_node_align_noprof(_p, _s, 1, _f, _nid)
> +#define vrealloc_noprof(_p, _s, _f)		\
> +	vrealloc_node_align_noprof(_p, _s, 1, _f, NUMA_NO_NODE)
> +#define vrealloc_node_align(...)		alloc_hooks(vrealloc_node_align_noprof(__VA_ARGS__))
> +#define vrealloc_node(...)			alloc_hooks(vrealloc_node_noprof(__VA_ARGS__))
> +#define vrealloc(...)				alloc_hooks(vrealloc_noprof(__VA_ARGS__))
>  
>  extern void vfree(const void *addr);
>  extern void vfree_atomic(const void *addr);
> diff --git a/mm/nommu.c b/mm/nommu.c
> index b624acec6d2e..afde6c626b07 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -119,7 +119,8 @@ void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL(__vmalloc_noprof);
>  
> -void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
> +void *vrealloc_node_align_noprof(const void *p, size_t size, unsigned long align,
> +				 gfp_t flags, int node)
>  {
>  	return krealloc_noprof(p, size, (flags | __GFP_COMP) & ~__GFP_HIGHMEM);
>  }
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ab986dd09b6a..e0a593651d96 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4081,19 +4081,29 @@ void *vzalloc_node_noprof(unsigned long size, int node)
>  EXPORT_SYMBOL(vzalloc_node_noprof);
>  
>  /**
> - * vrealloc - reallocate virtually contiguous memory; contents remain unchanged
> + * vrealloc_node_align_noprof - reallocate virtually contiguous memory; contents
> + * remain unchanged
>   * @p: object to reallocate memory for
>   * @size: the size to reallocate
> + * @align: requested alignment
>   * @flags: the flags for the page level allocator
> + * @nid: node number of the target node
> + *
> + * If @p is %NULL, vrealloc_XXX() behaves exactly like vmalloc_XXX(). If @size
> + * is 0 and @p is not a %NULL pointer, the object pointed to is freed.
>   *
> - * If @p is %NULL, vrealloc() behaves exactly like vmalloc(). If @size is 0 and
> - * @p is not a %NULL pointer, the object pointed to is freed.
> + * If the caller wants the new memory to be on specific node *only*,
> + * __GFP_THISNODE flag should be set, otherwise the function will try to avoid
> + * reallocation and possibly disregard the specified @nid.
>   *
>   * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
>   * initial memory allocation, every subsequent call to this API for the same
>   * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
>   * __GFP_ZERO is not fully honored by this API.
>   *
> + * Requesting an alignment that is bigger than the alignment of the existing
> + * allocation will fail.
> + *
>   * In any case, the contents of the object pointed to are preserved up to the
>   * lesser of the new and old sizes.
>   *
> @@ -4103,7 +4113,8 @@ EXPORT_SYMBOL(vzalloc_node_noprof);
>   * Return: pointer to the allocated memory; %NULL if @size is zero or in case of
>   *         failure
>   */
> -void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
> +void *vrealloc_node_align_noprof(const void *p, size_t size, unsigned long align,
> +				 gfp_t flags, int nid)
>  {
>  	struct vm_struct *vm = NULL;
>  	size_t alloced_size = 0;
> @@ -4127,6 +4138,12 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
>  		if (WARN(alloced_size < old_size,
>  			 "vrealloc() has mismatched area vs requested sizes (%p)\n", p))
>  			return NULL;
> +		if (WARN(!IS_ALIGNED((unsigned long)p, align),
> +			 "will not reallocate with a bigger alignment (0x%lx)\n", align))
> +			return NULL;
> +		if (unlikely(flags & __GFP_THISNODE) && nid != NUMA_NO_NODE &&
> +			     nid != page_to_nid(vmalloc_to_page(p)))
> +			goto need_realloc;
>  	}
>  
>  	/*
> @@ -4157,8 +4174,10 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
>  		return (void *)p;
>  	}
>  
> +need_realloc:
>  	/* TODO: Grow the vm_area, i.e. allocate and map additional pages. */
> -	n = __vmalloc_noprof(size, flags);
> +	n = __vmalloc_node_noprof(size, align, flags, nid, __builtin_return_address(0));
> +
>  	if (!n)
>  		return NULL;
>  
> -- 
> 2.39.2
> 

