Return-Path: <bpf+bounces-40970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFC8990A1D
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 19:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C59284232
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 17:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225051D9A73;
	Fri,  4 Oct 2024 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VcpqIm7r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fpDy34DX"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE86157492;
	Fri,  4 Oct 2024 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728062804; cv=fail; b=IJ3ceMx6R2MrU9lM6BzbUgdYJNahXk+uUlfFU8EXlp03oISDKdUv7ASWETXcj+TcHuztyWacPikRvOnUbkVyQJoA8gZgxPzt9BjzeAs0O5pTnYJTXCxDxYDuhoxkwCdGsmIRcS+SuOa4f9xojo7KEvpqJIe+/5ko204CT0k18fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728062804; c=relaxed/simple;
	bh=J/tCs23VsC3IAq9AyVx1T2jOdLDQN1dct4b3x9QbPvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D2caFZGFl/Wu9+dqqlLCUduTuamnDdTRT2HsXxDxGI3/oRDRCFNSLAE7W7TELBh3o6+lkA5MVHF0v4bvSKFMQu8kKjdr9kqow1ls+XcRVzYH2YiNR7tWefxS1Bc1j2gkoncrWH9caMqTGwDlg64iV2lSHppS7FfBotJuKKoi8po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VcpqIm7r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fpDy34DX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494GfvQ2031803;
	Fri, 4 Oct 2024 17:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=G2J1lWDlK/K8GQcwdp+Owxc9LxgqcAifnGnDVcIYq3g=; b=
	VcpqIm7rallycXxbCFmZ2fPNpPxtq78nMva/xKoI3Eh1MS2WzO3/kxvc8l1oC+4B
	ABuTBtGs5ATnY9XFytRGY1/owpGgPcDn88GYFnbkotH+1FyxI4cHG+EucEAxWudU
	5OzWCtpGLacwe+jiU0j6iulS0gmMXWP2S+LK2V+jRyx4eIed/fSR79YU+Hglp19k
	NxS2BZmu5qmMYQ9Q0mBCQcQ3SvlByi3SndFxktXOofdqPModnnEasv5UG2CoOUru
	OwyfNWvqmSKfJ8q6YTXyAwgWGfzIOSMIy50Om2tFlcARoYsE6P5q9m4AYnfEaFZN
	3ehxbl4BzQqx+IN4OknhqA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4220492429-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 17:26:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494H4rGL005877;
	Fri, 4 Oct 2024 17:26:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422056u661-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 17:26:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/sn74o/QJfnCBd+K+6oiiah9DlohES4M/LYszueUo7kIdxqIoCuOubj7dfj5kamCKdVj55I9pmxND05nSvq40svi7C2pbBPXp5X8BY8egI85fyMphKqsw/z3tGNhTz/6TEixgogdwO3NZVSrh8YV4nEA9Avjbf4j6dYWQ/5v9mXHCc/gJQjS2yQIL1sBpqOkoe0yXnDB4P4C3QpHBgmMMZ9V/Q7AeIGW/Yohjnx1B0IMBhrWMCXmHQVo+mobL8QOv17lheah0Gp6175CbfvhI3EE5+vSqk4ytBgv+Dg4TguXnytvCM35sw6uA6bI3qXtZbuGyIzR9x7vHqQYafnFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2J1lWDlK/K8GQcwdp+Owxc9LxgqcAifnGnDVcIYq3g=;
 b=P4FFqmFLECcSg/a+a7WfNsahLqjgzzPbpX4BZEm06OT5RgV5Ae0i4PX33yeVVTlCly8UIFk6xxpea+3TovM1dxmPYUscflOd4dYm7HxcDue7y8He0hXmnb5fZXi+8t7iziuiijj3aaTtvOGxROINK/qx3eha2PHNIVp/ymjFdjsK6/VEJmumjM4zNKih97ZxZ250es9r6dgwL0o1nyBpCfT8L6U73OWV550Okso+F+56LBm7WDQc/GLKJ8v/U4hpCRCneM6LeaZmBQqLO0Nj5c/xPUwNxBhXhS3X7Ce7jxN5Von9yf39uY1FDB9KIvYkUTBeAtCOqzodbFYYsVvfzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2J1lWDlK/K8GQcwdp+Owxc9LxgqcAifnGnDVcIYq3g=;
 b=fpDy34DX1Xr2V+mCQ9MkTD+BwQYv7ydvFCL8LTjUGwwDIPNjyP3RTrg92WAJFEhTzUcwkNq6nJE+irRXbIqW3yOFuqrIOhnmjLJdS8hyph8ii9lHLFmPEcP67tSW9f8vixpk1tV7F4V9iwCyK62CxRkhQyf7VtnedqnA+Yao46c=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by IA1PR10MB7485.namprd10.prod.outlook.com (2603:10b6:208:451::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 17:26:34 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 17:26:34 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves v4 1/4] btf_encoder: stop indexing symbols for VARs
Date: Fri,  4 Oct 2024 10:26:25 -0700
Message-ID: <20241004172631.629870-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241004172631.629870-1-stephen.s.brennan@oracle.com>
References: <20241004172631.629870-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0142.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::27) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|IA1PR10MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d0a8ee-162c-4683-e019-08dce499b185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?obPxx6ujCUqh7VkWylGFeOLQONzjFNfoqB0vPlRQZYfiVVlT+ctTbLTM9Nt/?=
 =?us-ascii?Q?4ZCZ4dLMPP6z3utn2jeEp2niTOPz8EdzCUy/5jCYhoHAgvcUFQUKCyha7c5Q?=
 =?us-ascii?Q?8aZJD1lDZpu5/led+lePyPiBlgps3ewmLhQInpHf6PksIh2zswvV3SABx2uL?=
 =?us-ascii?Q?+vvBc/UoyeAgEqh4qRtbJtICkt274/MmHsYbYUGx7ONAF6YY4QZdwWW8n5EK?=
 =?us-ascii?Q?oBWWy/OH1AiRboyOXnOzBPuScx3nbLFiejgmM9FM3DWwPLrm4Ce578KlSC5g?=
 =?us-ascii?Q?LidG4D8PBnlqIwMvl0sYPoDnVGYOdOe+ZI4+gsj3w2ZRSlQoPqZFYEpGsXmb?=
 =?us-ascii?Q?L/Kef8oPwjfLVnvDd1IGHgMV361eNu6HnyXdmk1q7M4xdIqs2QlyWDmFI2jn?=
 =?us-ascii?Q?7JV6QrhEQN0Ut03cnG/aqGHRYun/zlxbFnWbEQ8k6/Ry7qjWuzsLF4SV9RG1?=
 =?us-ascii?Q?hysyRB6NKl9/UuUjKWIy5CGPaLKGthrG5GRTwdAz9EtB3FASGwjsJO8AZ7Z6?=
 =?us-ascii?Q?GEvHrMPHNRnX6w82szS5y/bXKQVe8l38NgEeN9M648vrsWUrpNk4/T88H1z6?=
 =?us-ascii?Q?RsQ7uejQiLjfaU3m/zLL8tHVttQ3jWvtuVz3B3iHOgKJLOpm4xRi1nMUMqTb?=
 =?us-ascii?Q?lexG2arqUr/ED805us5wvMt5HQXbnGRqxHKud/diqyMjWdKIhvEqJb+sdFDA?=
 =?us-ascii?Q?ls6q4vEdJ2egigTX8D060NgwmSzSAXnuhv4pd8Y2KVvbMil9x8/bfAs2N8fZ?=
 =?us-ascii?Q?VdhXbmUMGEasqTe3I1PbwQb3C+u7rI0/2Q2bouLLuqAIL3qyFxwr819DkZ0u?=
 =?us-ascii?Q?EnoqeG3tYQQTL5DJDa8s0vEtL8/E9fJP6/0XqOxkPVa96HLbH3v9eICHC546?=
 =?us-ascii?Q?mfJkGtohJz1YMof+kH0WoBOS5WpFn83ABKCXof1SVxXsXlVj2pyLclHxSf5u?=
 =?us-ascii?Q?/C2WQjlu2JTKUhAWHjEYaso8Ng9FMyUuvPZ/62LaK4u9W6TuGCcgg2/2qpo+?=
 =?us-ascii?Q?vcYkkig77l4V9Aimf25e7uWlrZ4XqpM9BYeYlYfFZTQsizrYP1yVsO30TX4z?=
 =?us-ascii?Q?BEpdyT47/RNjDcPrENOhw7p6Jh5nWewM4xwFl0mKnOvsJiNFf2wDz8Au4fpu?=
 =?us-ascii?Q?11DhGUItHplcb4Zfh6a94TeRYFaAUmsfDt0pCtRBjnrv7ad0F2Cf+pt175Kh?=
 =?us-ascii?Q?9NDW1hhLkgYF+3Ceq/8IcHlnCcc08HmxnvAUkzmKJ7PtEzV1wXD/b+KJiuRz?=
 =?us-ascii?Q?Llroy+4Kg6QIGbgRNjuC4xSUeDqHpR6uc/FHn+T82Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?74skU2ANlLPzqZYXCKsYJdT79Eqb1ABROZooNMmcasXzhAhM68CfWdaLo3jW?=
 =?us-ascii?Q?+myLtWQh7FvT/pfpuNxn2Z+fRd4/HYlVhrVcuPJy1Lz+9/a4FXZUZBifXJaE?=
 =?us-ascii?Q?ShcKe1Ue+e+/F5d7UR0M/Pa/DjCbjNAqY5ufzMOsCKlT0ddZf3MUCVhZZxlD?=
 =?us-ascii?Q?2QKC4YiHhykkRQzj9Pv5BQdqhPingUxt5fzUTPW5Klf99TPjsXX+QYfeQAr1?=
 =?us-ascii?Q?dsiDQPtc9lZCTCcqh8PV4n0Go4I6gl8Yomj0ZPujMk2r+6uuGRPUk0pdS8W2?=
 =?us-ascii?Q?F2QzNCAfCbcqong6gWyJpoiAjwyUTX7nwjBYNwoRnIY6ljtuJpIG2IdS751V?=
 =?us-ascii?Q?WSB1yot41/7y3anLgaa++nCBq/TGQ9w2hGpbwQAbxVFhrsSqVsFehiRGq+nJ?=
 =?us-ascii?Q?af2TUyrE4CO2oZFtbZ0/IYxq1vdR11LV5JcrerL3S+Sa3ykNx7o9s9QsZ3JN?=
 =?us-ascii?Q?rVvE6tA933Lcqk259PFoiEbiOCwiqVr2ZkdbNreZdc4GNrren9OQNvpkicO8?=
 =?us-ascii?Q?lijnpByCDByLoUaSYPWa9vPjypkQwLYXV/OAqj8+z8PcjLQg4qPdSyyLZpmb?=
 =?us-ascii?Q?xzWpFt4iEZKPqInmH572EaU0RwTjnWRiT7tPNFKUHFnP7f2rNYqyL6SDGaDj?=
 =?us-ascii?Q?Tv3V2IEV7/CDDP1jxyZInln4m2T/jSV5Gfl4YfpFA/fw36Bo27kjJNwu0x45?=
 =?us-ascii?Q?OtTI4UtPLIDZ4Wxx/6+9QTl4jxkmFhmGWmlXnoI2Na5RHPNbdDJ5976PNjqa?=
 =?us-ascii?Q?eCnyrQCrxZLdISgO4TKRMZ4xZ9JygKYsNYQIFQIJJQxhU4VGs3FI9L/8pJm4?=
 =?us-ascii?Q?ewdQj3TDZOISEG+c5vd8D4THZWzcuseclkUAhLvq6TTAXgR5l1VhyA0tkSAX?=
 =?us-ascii?Q?8HnLldWVfBpMg9RzydbC3kQd1rAafC4wNnAdtQvuQBjkxl/3jF3LTw55dgDQ?=
 =?us-ascii?Q?tGxg2PgOSj9UWfAliYAV66lg6gPZkhwJzxV/XiJY0/kUBUhgfV7HyCqVU41k?=
 =?us-ascii?Q?kqAXoRzRXFubYz1jxikzJs3S3+4cA3yKeIFP/jc+cUbm9p98yGCV+OBlFcVZ?=
 =?us-ascii?Q?MsH0k+jwf4X2yMXeAM8coDysfhUnlUF9ab1q+bJ7wd7N167bo4dDD8ZBFCEe?=
 =?us-ascii?Q?lPxMLUGWf7VzfUhcdI+7Ga70ggs+mvYN0PqgARMc/zdF3+IfY6zyuLuzdBjt?=
 =?us-ascii?Q?coc0YyW/GwRgmn07rKMELHqyRNFpbzC91WKfbtJUcAPMoyrWFmHYbE+Xre3T?=
 =?us-ascii?Q?9KySkTVp1e+MtWOmha+Iwmxuhhbd0WBv4Na6aAfSs9BCRR8SYHAmutXsPjO+?=
 =?us-ascii?Q?AQKhA4KlaUI5Mb32CvrGEPKUi+vR+iLOZI/HegIZqwJfnXgcEC/xq3u+JR9N?=
 =?us-ascii?Q?BAgCmJSr4dl1H44dnbWoE1Jtx0jH6iH9GRzSN/P+Of8uWPMMGNZPN3N9KqeO?=
 =?us-ascii?Q?cO68eLP6HkoS2MjTvZzK47o8OcvCbdsNi8n5rE3QeDglsA/b3kjNzMxR8u5c?=
 =?us-ascii?Q?bcloXgb58nrsnGX+lGBFPOKbx3vHD+fW7E8bvOkHJvIkqr5QUIY1vYn7bVgl?=
 =?us-ascii?Q?jtUPM3Oi00nFJQy32ftm0J6oynB6KOQXsoyloIQKkmtnYg9dOJMQH3LJ1vYP?=
 =?us-ascii?Q?6XJXfwbdcXdySwUZP1DeH7A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ITNINJgLjxr11VugvXurtmDM5rpayQ5bSKY7i2ZTlhwOU9vvBso4YrD00SFbSmHXXL0Y8ginfqPRS7v1QiewtiDPI3yXQ6TqDs+tUaeV+UB/wEMwmXvbxf/fcEiXJFS5tgaho5fN5jci4EFSCj4slwG59YrKYupOmp/kDbjRMT4G5fkyI3ovcrYDBXmjYhGCszUSzVoLxLlkzqYQXh6hkjr4oXaExwyE1eRzc0iHaeAc5Nc8p9OMGGbATfb23IELRxtOBwXRpe1COAtJQZKEU18KG9jqhh3AlICY0JuRaMtSquBgUeqKfhHRFLWDJEE0LiCxF7A1e8RGTWErtyhZTz9D2oHaOQGtcbfwcYjhsXv8+Pj3K7tURqfmmlqTGXtvoANfEYbOok88NcVPNoEcE91UwxXbcV/lNe6cAOhTvRlmJhNZcUBMa7+hbAGGMuBcqIopigdWAqsyrVgNiW8uEk3e7WRkSralf9WsJRdfxj8ea4XxjBRovmPeMANI6cuIKUvqGiXTGWQVMPUbi2I7CRFQrQ9EMT89oEVp634jbuiy4Q3pe4tSWtCqg39Q35pKh97J2Kb1wbYlZVfqke1TbZFj9jG2Orgip4jh/AwQ63c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d0a8ee-162c-4683-e019-08dce499b185
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 17:26:34.1234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpl7kEYbSHOTeFLB8UNM033OH+kBDURspcX5ikqu+4hzUb2sZRWnLIavj5L/cfC2X8tkX6qqIj/Ku8Z6ZSefYQ25VA3CFq9L7Qf1zFP3SLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7485
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_14,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040119
X-Proofpoint-GUID: s1g5N-sW6RXk_bstJCAflitAlTVTlrT3
X-Proofpoint-ORIG-GUID: s1g5N-sW6RXk_bstJCAflitAlTVTlrT3

Currently we index symbols from the percpu ELF section, and when
processing DWARF variables for inclusion, we check whether the variable
matches an existing symbol. The matched symbol is used for three
purposes:

1. When no symbol of the same address is found, the variable is skipped.
   This can occur because the symbol name was an invalid BTF
   identifier, and so it did not get indexed. Or more commonly, it can
   be because the variable is not stored in the per-cpu section, and
   thus was not indexed.
2. If the symbol offset is 0, then we compare the DWARF variable's name
   against the symbol name to filter out "special" DWARF variables.
3. We use the symbol size in the DATASEC entry for the variable.

For 1, we don't need the symbol table: we can simply check the DWARF
variable name directly, and we can use the variable address to determine
the ELF section it is contained in. For 3, we also don't need the symbol
table: we can use the variable's size information from DWARF. Issue 2 is
more complicated, but thanks to the addition of the "artificial" and
"top_level" flags, many of the "special" DWARF variables can be directly
filtered out, and the few remaining problematic variables can be
filtered by name from a kernel-specific list of patterns.

This allows the symbol table index to be removed. The benefit of
removing this index is twofold. First, handling variable addresses is
simplified, since we don't need to know whether the file is ET_REL.
Second, this will make it easier to output variables that aren't just
percpu, since we won't need to index variables from all ELF sections.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c | 253 ++++++++++++++++++++------------------------------
 1 file changed, 99 insertions(+), 154 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 652a945..61e9ece 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -93,16 +93,11 @@ struct elf_function {
 	struct btf_encoder_func_state state;
 };
 
-struct var_info {
-	uint64_t    addr;
-	const char *name;
-	uint32_t    sz;
-};
-
 struct elf_secinfo {
 	uint64_t    addr;
 	const char *name;
 	uint64_t    sz;
+	uint32_t    type;
 };
 
 /*
@@ -125,17 +120,11 @@ struct btf_encoder {
 			  gen_floats,
 			  skip_encoding_decl_tag,
 			  tag_kfuncs,
-			  is_rel,
 			  gen_distilled_base;
 	uint32_t	  array_index_id;
 	struct elf_secinfo *secinfo;
 	size_t             seccnt;
-	struct {
-		struct var_info *vars;
-		int		var_cnt;
-		int		allocated;
-		uint32_t	shndx;
-	} percpu;
+	size_t             percpu_shndx;
 	int                encode_vars;
 	struct {
 		struct elf_function *entries;
@@ -2098,111 +2087,18 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 	return err;
 }
 
-static int percpu_var_cmp(const void *_a, const void *_b)
-{
-	const struct var_info *a = _a;
-	const struct var_info *b = _b;
-
-	if (a->addr == b->addr)
-		return 0;
-	return a->addr < b->addr ? -1 : 1;
-}
-
-static bool btf_encoder__percpu_var_exists(struct btf_encoder *encoder, uint64_t addr, uint32_t *sz, const char **name)
-{
-	struct var_info key = { .addr = addr };
-	const struct var_info *p = bsearch(&key, encoder->percpu.vars, encoder->percpu.var_cnt,
-					   sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
-	if (!p)
-		return false;
-
-	*sz = p->sz;
-	*name = p->name;
-	return true;
-}
-
-static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym *sym, size_t sym_sec_idx)
-{
-	const char *sym_name;
-	uint64_t addr;
-	uint32_t size;
-
-	/* compare a symbol's shndx to determine if it's a percpu variable */
-	if (sym_sec_idx != encoder->percpu.shndx)
-		return 0;
-	if (elf_sym__type(sym) != STT_OBJECT)
-		return 0;
-
-	addr = elf_sym__value(sym);
 
-	size = elf_sym__size(sym);
-	if (!size)
-		return 0; /* ignore zero-sized symbols */
-
-	sym_name = elf_sym__name(sym, encoder->symtab);
-	if (!btf_name_valid(sym_name)) {
-		dump_invalid_symbol("Found symbol of invalid name when encoding btf",
-				    sym_name, encoder->verbose, encoder->force);
-		if (encoder->force)
-			return 0;
-		return -1;
-	}
-
-	if (encoder->verbose)
-		printf("Found per-CPU symbol '%s' at address 0x%" PRIx64 "\n", sym_name, addr);
-
-	/* Make sure addr is section-relative. For kernel modules (which are
-	 * ET_REL files) this is already the case. For vmlinux (which is an
-	 * ET_EXEC file) we need to subtract the section address.
-	 */
-	if (!encoder->is_rel)
-		addr -= encoder->secinfo[encoder->percpu.shndx].addr;
-
-	if (encoder->percpu.var_cnt == encoder->percpu.allocated) {
-		struct var_info *new;
-
-		new = reallocarray_grow(encoder->percpu.vars,
-					&encoder->percpu.allocated,
-					sizeof(*encoder->percpu.vars));
-		if (!new) {
-			fprintf(stderr, "Failed to allocate memory for variables\n");
-			return -1;
-		}
-		encoder->percpu.vars = new;
-	}
-	encoder->percpu.vars[encoder->percpu.var_cnt].addr = addr;
-	encoder->percpu.vars[encoder->percpu.var_cnt].sz = size;
-	encoder->percpu.vars[encoder->percpu.var_cnt].name = sym_name;
-	encoder->percpu.var_cnt++;
-
-	return 0;
-}
-
-static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool collect_percpu_vars)
+static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
 {
-	Elf32_Word sym_sec_idx;
+	uint32_t sym_sec_idx;
 	uint32_t core_id;
 	GElf_Sym sym;
 
-	/* cache variables' addresses, preparing for searching in symtab. */
-	encoder->percpu.var_cnt = 0;
-
-	/* search within symtab for percpu variables */
 	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
-		if (collect_percpu_vars && btf_encoder__collect_percpu_var(encoder, &sym, sym_sec_idx))
-			return -1;
 		if (btf_encoder__collect_function(encoder, &sym))
 			return -1;
 	}
 
-	if (collect_percpu_vars) {
-		if (encoder->percpu.var_cnt)
-			qsort(encoder->percpu.vars, encoder->percpu.var_cnt, sizeof(encoder->percpu.vars[0]), percpu_var_cmp);
-
-		if (encoder->verbose)
-			printf("Found %d per-CPU variables!\n", encoder->percpu.var_cnt);
-	}
-
 	if (encoder->functions.cnt) {
 		qsort(encoder->functions.entries, encoder->functions.cnt, sizeof(encoder->functions.entries[0]),
 		      functions_cmp);
@@ -2224,15 +2120,57 @@ static bool ftype__has_arg_names(const struct ftype *ftype)
 	return true;
 }
 
+static size_t get_elf_section(struct btf_encoder *encoder, uint64_t addr)
+{
+	/* Start at index 1 to ignore initial SHT_NULL section */
+	for (size_t i = 1; i < encoder->seccnt; i++) {
+		/* Variables are only present in PROGBITS or NOBITS (.bss) */
+		if (encoder->secinfo[i].type == SHT_PROGBITS ||
+		    encoder->secinfo[i].type == SHT_NOBITS)
+			continue;
+
+		if (encoder->secinfo[i].addr <= addr &&
+		    (addr - encoder->secinfo[i].addr) < encoder->secinfo[i].sz)
+			return i;
+	}
+	return 0;
+}
+
+/*
+ * Filter out variables / symbol names with common prefixes and no useful
+ * values. Prefixes should be added sparingly, and it should be objectively
+ * obvious that they are not useful.
+ */
+static bool filter_variable_name(const char *name)
+{
+	static const struct { char *s; size_t len; } skip[] = {
+		#define X(str) {str, sizeof(str) - 1}
+		X("__UNIQUE_ID"),
+		X("__tpstrtab_"),
+		X("__exitcall_"),
+		X("__func_stack_frame_non_standard_")
+		#undef X
+	};
+	int i;
+
+	if (*name != '_')
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(skip); i++) {
+		if (strncmp(name, skip[i].s, skip[i].len) == 0)
+			return true;
+	}
+	return false;
+}
+
 static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 {
 	struct cu *cu = encoder->cu;
 	uint32_t core_id;
 	struct tag *pos;
 	int err = -1;
-	struct elf_secinfo *pcpu_scn = &encoder->secinfo[encoder->percpu.shndx];
 
-	if (encoder->percpu.shndx == 0 || !encoder->symtab)
+	if (encoder->percpu_shndx == 0 || !encoder->symtab)
 		return 0;
 
 	if (encoder->verbose)
@@ -2240,59 +2178,69 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 
 	cu__for_each_variable(cu, core_id, pos) {
 		struct variable *var = tag__variable(pos);
-		uint32_t size, type, linkage;
-		const char *name, *dwarf_name;
+		uint32_t type, linkage;
+		const char *name;
 		struct llvm_annotation *annot;
 		const struct tag *tag;
+		size_t shndx, size;
 		uint64_t addr;
 		int id;
 
+		/* Skip incomplete (non-defining) declarations */
 		if (var->declaration && !var->spec)
 			continue;
 
-		/* percpu variables are allocated in global space */
-		if (variable__scope(var) != VSCOPE_GLOBAL && !var->spec)
+		/*
+		 * top_level: indicates that the variable is declared at the top
+		 *   level of the CU, and thus it is globally scoped.
+		 * artificial: indicates that the variable is a compiler-generated
+		 *   "fake" variable that doesn't appear in the source.
+		 * scope: set by pahole to indicate the type of storage the
+		 *   variable has. GLOBAL indicates it is stored in static
+		 *   memory (as opposed to a stack variable or register)
+		 *
+		 * Some variables are "top_level" but not GLOBAL:
+		 *   e.g. current_stack_pointer, which is a register variable,
+		 *   despite having global CU-declarations. We don't want that,
+		 *   since no code could actually find this variable.
+		 * Some variables are GLOBAL but not top_level:
+		 *   e.g. function static variables
+		 */
+		if (!var->top_level || var->artificial || var->scope != VSCOPE_GLOBAL)
 			continue;
 
 		/* addr has to be recorded before we follow spec */
 		addr = var->ip.addr;
-		dwarf_name = variable__name(var);
 
-		/* Make sure addr is section-relative. DWARF, unlike ELF,
-		 * always contains virtual symbol addresses, so subtract
-		 * the section address unconditionally.
-		 */
-		if (addr < pcpu_scn->addr || addr >= pcpu_scn->addr + pcpu_scn->sz)
+		/* Get the ELF section info for the variable */
+		shndx = get_elf_section(encoder, addr);
+		if (shndx != encoder->percpu_shndx)
 			continue;
-		addr -= pcpu_scn->addr;
 
-		if (!btf_encoder__percpu_var_exists(encoder, addr, &size, &name))
-			continue; /* not a per-CPU variable */
+		/* Convert addr to section relative */
+		addr -= encoder->secinfo[shndx].addr;
 
-		/* A lot of "special" DWARF variables (e.g, __UNIQUE_ID___xxx)
-		 * have addr == 0, which is the same as, say, valid
-		 * fixed_percpu_data per-CPU variable. To distinguish between
-		 * them, additionally compare DWARF and ELF symbol names. If
-		 * DWARF doesn't provide proper name, pessimistically assume
-		 * bad variable.
-		 *
-		 * Examples of such special variables are:
-		 *
-		 *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
-		 *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
-		 *  3. __exitcall(fn), functions which are labeled as exit calls.
-		 *
-		 *  This is relevant only for vmlinux image, as for kernel
-		 *  modules per-CPU data section has non-zero offset so all
-		 *  per-CPU symbols have non-zero values.
-		 */
-		if (var->ip.addr == 0) {
-			if (!dwarf_name || strcmp(dwarf_name, name))
+		/* DWARF specification reference should be followed, because
+		 * information like the name & type may not be present on var */
+		if (var->spec)
+			var = var->spec;
+
+		name = variable__name(var);
+		if (!name)
+			continue;
+
+		/* Check for invalid BTF names */
+		if (!btf_name_valid(name)) {
+			dump_invalid_symbol("Found invalid variable name when encoding btf",
+					    name, encoder->verbose, encoder->force);
+			if (encoder->force)
 				continue;
+			else
+				return -1;
 		}
 
-		if (var->spec)
-			var = var->spec;
+		if (filter_variable_name(name))
+			continue;
 
 		if (var->ip.tag.type == 0) {
 			fprintf(stderr, "error: found variable '%s' in CU '%s' that has void type\n",
@@ -2304,9 +2252,10 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		}
 
 		tag = cu__type(cu, var->ip.tag.type);
-		if (tag__size(tag, cu) == 0) {
+		size = tag__size(tag, cu);
+		if (size == 0) {
 			if (encoder->verbose)
-				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", dwarf_name ?: "<missing name>");
+				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", name);
 			continue;
 		}
 
@@ -2388,8 +2337,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			goto out_delete;
 		}
 
-		encoder->is_rel = ehdr.e_type == ET_REL;
-
 		switch (ehdr.e_ident[EI_DATA]) {
 		case ELFDATA2LSB:
 			btf__set_endianness(encoder->btf, BTF_LITTLE_ENDIAN);
@@ -2430,15 +2377,16 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			encoder->secinfo[shndx].addr = shdr.sh_addr;
 			encoder->secinfo[shndx].sz = shdr.sh_size;
 			encoder->secinfo[shndx].name = secname;
+			encoder->secinfo[shndx].type = shdr.sh_type;
 
 			if (strcmp(secname, PERCPU_SECTION) == 0)
-				encoder->percpu.shndx = shndx;
+				encoder->percpu_shndx = shndx;
 		}
 
-		if (!encoder->percpu.shndx && encoder->verbose)
+		if (!encoder->percpu_shndx && encoder->verbose)
 			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
 
-		if (btf_encoder__collect_symbols(encoder, encoder->encode_vars & BTF_VAR_PERCPU))
+		if (btf_encoder__collect_symbols(encoder))
 			goto out_delete;
 
 		if (encoder->verbose)
@@ -2480,9 +2428,6 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 	encoder->functions.allocated = encoder->functions.cnt = 0;
 	free(encoder->functions.entries);
 	encoder->functions.entries = NULL;
-	encoder->percpu.allocated = encoder->percpu.var_cnt = 0;
-	free(encoder->percpu.vars);
-	encoder->percpu.vars = NULL;
 
 	free(encoder);
 }
-- 
2.43.5


