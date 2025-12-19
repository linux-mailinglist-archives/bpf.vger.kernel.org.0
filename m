Return-Path: <bpf+bounces-77149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B264CCCFF89
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 14:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EF8830E599E
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 13:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699043242BE;
	Fri, 19 Dec 2025 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y4LFX4cx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BLuAd8+7"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124FD28DEE9;
	Fri, 19 Dec 2025 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766149319; cv=fail; b=sy9byBnitbF2AbQGUCZbmNiDowv3aQA9VK4hHHEnWzyU4fVdOWUYUpeSvSLoNfp/scF84Xs/LylEXI2Bi5XqW7OsOhXFTJT7AdSsa9xN5CiSEFu21Ql3bmafCzsPoV+9MOlB2LaZ9pdF4gHlHvMADO03VQ1esW3Esp8MKuQI8W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766149319; c=relaxed/simple;
	bh=rhTxuWLa/OPLE2+a17jqG9+aYFhNgYWlquz2IrENet4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZEcZIcMQVQjbwdtOe2fK1Ab+YKo2K2R88sWjmI8UIdjGNgm4EV04kJFXQH5JpKAbcy5nlaKWcjjeVrtXLWKaZVpRz4/0yk07LTDk8/igYKaZSg9nUPYVCkqDklHycydgxMtYikZ4voQKv2uVJTCfCVM9I4ghq+h03q7qENqSmGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y4LFX4cx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BLuAd8+7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ3EYd62740122;
	Fri, 19 Dec 2025 13:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RwYnOvHXXvFaRskS6hfUMWQ8f4fVfLbyyvh41iZqZL0=; b=
	Y4LFX4cx1omjL6583DXmWexjgUO2IHcpxsab+5m/1XkKfuxr7FBH3Xsl1Km62kDQ
	Htffnzh6H8JnxMF47c3ce9wFlhHS51OkgdpOhrvvr5sk7y8FpYL0Nolb1Z3TX+ub
	MlKedJlZLR70Z8icItRarY44VLmabnHoR7ml+aQ+2Zu1KLyUcfsE7r3gOwoBraBb
	CmIFYPU24eXz7WeAQNP8xX5elNEMov6rudLHi426YaeY1AZIdUST4bN5Ly1P6PNW
	Q33mtKImuyipZXc6auqGNjnPql0aoa30KxoNiC5hU8CetA8ig3LEFgvJU3HcpVnk
	QecuyEWLooi9lcJ8LKVGGA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b4r2bh2g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 13:01:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJCK6lV023489;
	Fri, 19 Dec 2025 13:01:01 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b4qtawke1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 13:01:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyNsYOD95E18mgH3GRgXplDzioMtb4o6hK8Z6h21nlQ/8kKuzPEsZwAgr+5/e+OcH79RFUtnC6reaBYsPGl7q/awbGXuxvm7xTLs4aNcw3snmPoBblFwvK7msTp1Pciya2pm7Y3wYfMyjfH3wnfCR9xykawFyQmCXrOft+uPysQkPzpoJPFtOgtwziYOy33xMLhqlsH81MAReUpdOY6u3vIC+aYyO+1aQvknZaji697qA2SfnI8FxjJTUiQl1q49MuRQ1ftk7qYBJYeA2kN9mxNTorDTXLZpCe0L03l4x1C2jwg0JhJPC5ieSPPlMhkbGvwAbXyhz2mFLSEcrhs3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwYnOvHXXvFaRskS6hfUMWQ8f4fVfLbyyvh41iZqZL0=;
 b=Gic3BP6sHUNQglfrdd4XKwrwBmAe2vg5Caa3BPO3qwRWDG4ByOTUBVHpNrl1w1+PUxORzMktJRVB+qdarTZxzMtMv+4tIvzw+Phqx2ffzZWksMFl4l8ajn6q9+HYKTd0x3LGqB/xbGpKF/XtPJEHvawulV8hDvk4E5qBMqEUaSnbVnMu1E/4BizZ+Eg9ISqKKHnvPytkzgiIS4eIPCYsIiVeseBIWl9lNZBJMolr7t7DvvHla8lI8yij/3aYDPg4sBE0hoI5AnuCZcPCCaBaE13neWc2OPq++dUZxi1856aI8cYrGB3MJL4aABS68ozdd1qIxJ99r1z6e94uXNcyjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwYnOvHXXvFaRskS6hfUMWQ8f4fVfLbyyvh41iZqZL0=;
 b=BLuAd8+7AeNzaiFTvOxbBpEaTzsOXYN3EzltE+Eow06zm/7mYg+kzoFUopUhYRVLPa3NoLlHXWzkNp6R5iqx1zm1+FMIoJMpTRCHIplOY/w6J9ycB1vuVWfx8beV/+xDlMMTu7RmmG53PC/0UIGaY0GqH63I61MB/qnVCklVBxE=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CO1PR10MB4660.namprd10.prod.outlook.com (2603:10b6:303:6d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.9; Fri, 19 Dec 2025 13:00:58 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 13:00:58 +0000
Message-ID: <b5e0a0bd-4d8a-4052-8e06-3e82c512ca86@oracle.com>
Date: Fri, 19 Dec 2025 13:00:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 0/8] resolve_btfids: Support for BTF
 modifications
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>,
        David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
        Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Donglin Peng <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, sched-ext@lists.linux.dev
References: <20251219020006.785065-1-ihor.solodrai@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20251219020006.785065-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::6) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CO1PR10MB4660:EE_
X-MS-Office365-Filtering-Correlation-Id: f5239782-72c0-4728-a505-08de3efea71f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Um1vd01ucStvcC9aSGpxK3E5TTFxbG1YcVZ6blZIcUNtY1R1ZjFzakMwMXhj?=
 =?utf-8?B?WnNPYUlKUlgxT0JSQlE4WXV1ckxCM3ZNU3pOOFdhaWNyOStXamNMaHJ2Z1V6?=
 =?utf-8?B?RE5ZM2hLeWVtUW5mUVRjTXpMQjQyMXJlTmc5L2NEcmhqYW0razQwU3N1d05h?=
 =?utf-8?B?aHUwMlFjdlgvKzNmck0vNUJodm84TW1YMEJmRDJwdnA5VjJqWmIycDlGYkNt?=
 =?utf-8?B?bXQ4aEU5KzZIVG5Fcm9wVVAwaTh4T0ZLTHNkemNWd1czRzB3UWRTckRqWUc2?=
 =?utf-8?B?THpBMytDZlNMZm1wQVNGY1VjVHZ5NHFPekVERHZaK1JVZjgyQzI0bko2Smlv?=
 =?utf-8?B?M0ZaNUhSSktjaTF0elJERG4ySzF4K200cDFuUnRBV2pxbGRGUFkyeEVmcEp5?=
 =?utf-8?B?UHorcU41TkNzWkxiZUJoTHpPRlIzYXNXU3ZvUW9OS1p6TWZtMmpNcGNHQlhp?=
 =?utf-8?B?T3N6MDRGNktJc3ZJZWlUa2VSbWh1Zk8zYTlOdmFvRzdLc3hFWmJ6MmxQYzBx?=
 =?utf-8?B?ZXplUktHOEpMNHc2Z0hnTEVGUVoxak9SRFFkcm9SelNHVWtqc203QjZYRkJj?=
 =?utf-8?B?SUxLNHlqeVBSdDlhQUk5Zkp6STJWTzlQd05yNVJiTGExeFQ1NXdEUGM3VWcy?=
 =?utf-8?B?MTNVdTR2VSs0NEZzUWxYZ3Z0OXRmOGt4TDA2YUhLNlIwYms0aFhhSnNvV0p2?=
 =?utf-8?B?akRqa3JtMEVUcmlxU1MwRkxqSU5zMEYrMTVRTlJITjZFWGtTTytkeWVtQXhh?=
 =?utf-8?B?cWlYTWc3cmdjM2tnbkgrb3A1OVg0M2pqakppREptU2JEcGNrMnF6N1VHVU1a?=
 =?utf-8?B?SWh5cFRFa20ybko5WHZ6eVlRRE55OFJiMmplVXltV3RJRTM3QW9FM0pKTVlu?=
 =?utf-8?B?NVNKdFpHM04vUitDbDlzMHZRekRzdVlWZC8waFQ0eVZyc3VHbTFOSGFHNHFt?=
 =?utf-8?B?MjV2UVl0eGtTTlVwTjBrWkF1S3hHanE3clZyRzE4NXhYZ0FkMHZyZjVPdnNU?=
 =?utf-8?B?SjY0S043K1BxZXRVTFNQNnFjcnFOK2V6TTdLRDVYYS9XaGRyNVJxZm5ORitn?=
 =?utf-8?B?V0FLUmZ2LzlrRmdRak1ZWnBieGExSnZKQlFiSXpISnZDRFBqaGZMYTdadDR1?=
 =?utf-8?B?cU5qRDV5bi9vSFN3ZTdQdHp1LzdvVm9oV2w2SjQzc2Z0eTRUcURkUzFxQU5m?=
 =?utf-8?B?c2JremllK3Fka2dWK0tIeDBKMFJtbEU2TDgwNDNOdjh1ckNSVmV1UHU3S010?=
 =?utf-8?B?VFRGdHFWS0NyUGRNbHlzbFE3N2NBOVJDSkZucEVjMXRFTkdMb0xUUlpFL2ta?=
 =?utf-8?B?QmUzdS8wQkRLSUJTMC8wYXU2Nkw0VTdQcEZWM1psK1NUa1lKZjBtUGhjSzIr?=
 =?utf-8?B?dHBUNDJ4dCtiTzEyRjFLUmpTQ2Flb0VDSjFaTG1ITkZKNHhmRjRLeVhEZ0Nq?=
 =?utf-8?B?QkY1VVZaSG55cFdNMlhqU2VPNjVVLzlESDFIYmdQeWhlbUI5Z2hZRlU3YnV4?=
 =?utf-8?B?bVh6aTZYaWNGQmRCY0tUYWlwZ3VFK2VwMnZXZWNTcy9UYXF4cys0V2ZqQ0tJ?=
 =?utf-8?B?WXpSQ1pvakRwWE9BRXJ5cVE5UHpienFTSjJ4eXRiVE9MTUZ4NXlCdlMwZzJa?=
 =?utf-8?B?NTdyQkYyZHczRmhpeHNjeDE4SlZPc3I0KzJqQWFYT2hEc3U2bVN2RVBuOWhO?=
 =?utf-8?B?ZTUvaHUzcXNjbEVNbE5JYzJKb3VLTlV4MzU1TzBHNnZPT1JzVUhBNTF6dGNZ?=
 =?utf-8?B?U0FzRlVzVHhsWkxIWHFQdnZqdGJLTmpHQWpXTTU0ZzllejZ5NHE5eXpDa3B0?=
 =?utf-8?B?OWRvRGt1c1BvdXROcHo2S2NFUWhDUlhlWFdRQTlPRWhJd0t5L041SGM3K1JC?=
 =?utf-8?B?bnk5d1AwbXk5M0pRalNWRzVrMGpXOXBtbzRVQjZIUGNGMzZLRnNDdDByTFpN?=
 =?utf-8?B?enU5dnZoaTFoNEJPeUpteG9uVEVNeTh6bHhxZEg4M01nV0wxd3I3czFQckxi?=
 =?utf-8?B?aHpMWWNrTnFqV1VCMnl2Q0hVbnpjT0haVE9neDl6c0NoOTRqb2FpeUlyb1ZZ?=
 =?utf-8?Q?rDPkKP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEJYOFlzUXhtV3dTRHcvZ3BoT2hWY1Z5V282eldHUjJ1TzNuSlZ6cmlZY29G?=
 =?utf-8?B?TE1lNnZhUzVNZFJOeDVkODBpbkM1OUFYMXNYdjJyL3BQb3EyNmcrSEV5cnB6?=
 =?utf-8?B?eW5BR21TQ3M5ZlN1aXkxOUpQNThYOUwxYVVhc2FTSjQzTjdmSHZoNXdWMG4z?=
 =?utf-8?B?SG9nZDVueDJhU1kxWWhUdE5wQVh5L1hRMWNVUmo3V3Z4UDhDRzJDOHpwc3lY?=
 =?utf-8?B?T3hEeGIwOC9UajRpeDd5NUF3MDN4SE9WdWY1UFZMNER4dzJndC9DaXB4aWlT?=
 =?utf-8?B?ZmwxdnFZQ1Eya25YQWxkYlZiYWZnOHBxM2RXVGRTbUpTenE1ZU5EU2hEUDRH?=
 =?utf-8?B?aDEvc3pQMmlpUGRSRlZpMjlkMUFGQmlLSlJRcUk4WVlJZU1iYTBRT001VDFT?=
 =?utf-8?B?TXVYYWVUK0p4VHdUNWpOVkc1eXVQcGsySVhjdG9la2Zsc0JCTmZITXFFQjk5?=
 =?utf-8?B?OVVpT3kveTNwZVZncCtWbkhtRy94OG9MYkh1NkxSaEdHanhXOU5qSmZNZ3FL?=
 =?utf-8?B?ZGhWQnd2c0xkNFMvSEI2T2cwZjNZTkY2cExySVNhbTdnOTcvOTVDMnFqR0Qx?=
 =?utf-8?B?MStXSDE5eVJSZkhGcnZ2ZHZKNkprMURNT1ZZMFBFMTlESXdlTVNmTmNYZWtH?=
 =?utf-8?B?ZEVxaitCeUlaK1dpMWdydDJ0NnVDbDlGT3R6VnN6WXpscVR2eEl0NER2VHp6?=
 =?utf-8?B?V1BDSUV1ZkQzdnR2a1dtaE9LMWdWSDF5OHZvNm1DejhGQXBlVjRxazNIVmFp?=
 =?utf-8?B?Wk9EUWRPU2VkNmN0NEVzNHdTUFFHMlVjVWN3aW9tSUdVTWhLaFlMVFNwZ2kz?=
 =?utf-8?B?SnFOREtFcUhSeDEzYXFPbWlBRzI0c1dsSkVFZEFRUXdJaFRJb3QzdWQ3dDZ2?=
 =?utf-8?B?NXBjUWFINnpTOFMzSE9BYnRvT2Nkd1MwSnJER003S3g1ZUFHRXZLbWt3NFdE?=
 =?utf-8?B?OFYzVXhmQ1pmNU5PdzAxcUl4QW5mT0d5MWY4UDFEcS9FK3ltUlBKbzB3V00r?=
 =?utf-8?B?U3FFd2VISDRER3FsTTZ2WndZbCt0dmNJYllpSk1sNGlFMnRqWmtNWVQ5a3Vl?=
 =?utf-8?B?cWMwK09oT011WU9qdWlPZ3JSZlFlTzhtRkYxMkdPVXFaUUhnc051N1BNUVN3?=
 =?utf-8?B?TmkzUzE2Q1BsSklNenF2KyswcmxaVVo3a28xQVJvb2E2c2wvWnREV3NEU0Rx?=
 =?utf-8?B?R0VIYlRFQ1hrM3FYVDVKQjZaeXJ3SUg5Vk5HYXdzckhYQ3JsclRQSEVudGhs?=
 =?utf-8?B?UGNvT1F5Y2NST3lnT3c2ekVhSm9Ld0wwMDVnS1R2OTdNdzdHSVBpV1VxYWtj?=
 =?utf-8?B?U2JndUxRY1BMYi9JSk5zaHFEWWJaZmNPd3VTQS84RFBRTWJTczVieFpicEc3?=
 =?utf-8?B?dlluRDBJd0FCczFoVTk2Um1ySnBhSVpYekd1QTVIZktnT2l3T0cwb2RsOGMw?=
 =?utf-8?B?VlpSRWdTR1NjaDJoTXdRbUpkQ3A2aVpmUjV1dzZBVkxId3MxclBOMXBjZ09r?=
 =?utf-8?B?RFdjVkt5b1JtL2VseVBKTjExOUMrUDZud2hvMm8rNW8vekUwempGeUNUNWc5?=
 =?utf-8?B?MThkVjFYQmQ1VzBiazkyU2FIUVBGSXlMTWRRengzTlZTbGFKUi9RR3BpSERz?=
 =?utf-8?B?dEVQSEZvNmoveXRRNzZ1KzQ0OTBWT0pOcUw2VmRNVEVDVXkzQkd5TWVhOGNo?=
 =?utf-8?B?cXdYOEpZNkZyL0RuQnoxSUFMdzgxV0RKOXQwMWhMaXN6bjg1SXp4SXJOUENk?=
 =?utf-8?B?YmNrRktqZVZIM2NPU0pOeEIrdVNNWnI1R0w5NjN0anhISnM3a3dIclI4eW1S?=
 =?utf-8?B?S1Y3VXoxU2ExanBDaEF4bDFGb2JOMVZFOGZzdkxDbzlGNTduTG1sZUQwUW9t?=
 =?utf-8?B?MEhEUzJENzA5aVB0cHBHelcwQStOME9TdERVR0pmbnpYcGRPNGxnRFhUSmRh?=
 =?utf-8?B?bVBLV1FIM29VOEh5U3ZNS1k4MHFYNG82VmxxVS91UmpPdE5vL0dhZVcxR1h5?=
 =?utf-8?B?RFNJV1l6RGQxa09wdGdKS2VTbVNyTHhsaERmdEptTEpuazkrZVhrK1h0dEN6?=
 =?utf-8?B?VFpFWGMrem9ENGxBRE9MSkVZMGUzcmNCVlhKaysrdWVhaHhqY093ZS8ydnIx?=
 =?utf-8?B?eXcvZWtab2dxdmtkTk1kWEk5SEM4aU5JTVVHOTE2a1c0OUtZUDMzTnNaTWw3?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vG/jQBB+71NqIIXeGOIdQ/e7q5D9k4tpkh5YsvuGkMm2Ff0Phr+37ipvG1/SD2wkiEaaIFydNASpPEwguMwoFrloNQv34ZjRhYAvK6JzIEdh2I3jKaW4dEv2lgHy2YUElc7MKBs93yEVrQUN+eO5ac9OrHkzmP/J9rxTpLhfkJc3hi8hAgoJi9UdJBpazbg8QH9CqF1D5nYd9KYgov7ZJTkAYk1wolDJRXKQfQEFIOwYrqFv+sBX/5BS4QYY8fGL406sbOBft9hrbKQ84Wzsn+Jg06g3uNnVZsRKDPDYMY4rqNO92cm7mZw3TFRU8yF6QFHJh7kC0H6hGfctaP49RmsK5zCOph5eatFTXPDPow6OGe+pNdNiM6IRg5npDn9NfVfwO0vE9074GFgK7GdZ8nC9IkTz673T68VRneM90M98MKQnVE1eM0Dq//iohefvGwvkCRk1YLZTqP1zY5PxWvgOXXaF/MBx64sCUHJbaTZ37kDWYFfXtkcnCY6kbSWNzXJU8JSZLts3DFYFjU+74lYse3mET7ccKJ2q/llzhWLiJs8dm2iJ977m5aO4r4X4FQJCMYudLpEHHUTEED5mWGN57muIJrha1fT/y+K6+aY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5239782-72c0-4728-a505-08de3efea71f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 13:00:58.1956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pumYSqpy04io4BYw8zGb/mm2VEUfvf4W7ioZLTa1q+0EpEB4nOxq5qBFEHMp+oqUUNRLkYkNBTwPh2piSi91w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4660
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_04,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512190108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEwOCBTYWx0ZWRfX//0ASzIe9amP
 HmvgUBsQmXskCb6E4k+1yn1VYDGe1zOuLbhYP18TQLfItVy6NNa61ZGSx/Gm40fK8raRkNWrwrX
 7POo4a1C5rHAL5u0I1euFTnwUTUyRLkSJBJJnTfKFZvktmzSOpIQHjsVT7KH4ucUKtj51MVWUOK
 QZ6a/iaFaNBU20lTtmG8bn8LTIPmaQoxUKLqCtTuLLm1GkPymcy+eEaBb/LB+tPUczgbmBjrgWN
 hJgisfNQHiOBJxP7Pz/zT3J3ibmvIKnopUFbe+AoBeW3Xia/xQDzDEEH1XCge16R1tmbGQo9BdI
 zsW0BS6amD/lJQYMpxWR4y7AWA9Jy5EBveVQc4kOYelzqwCUZathfMUh4XLAqLvbz0du1iePnol
 9aYSr/d/XpykakT7x/fEEAD37y38po4rN4J4sIW/pzODdGFSmz45gwyMTcZRW8FE4IrtM0+9oDY
 Ao7WfDNil0SkEnu2Cog==
X-Proofpoint-ORIG-GUID: jTkdb24RTTRhiDKM0m1wAirA37rX3T0v
X-Proofpoint-GUID: jTkdb24RTTRhiDKM0m1wAirA37rX3T0v
X-Authority-Analysis: v=2.4 cv=ObyVzxTY c=1 sm=1 tr=0 ts=69454c8e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=rmKMVxmpicAL6nMj2gkA:9 a=QEXdDO2ut3YA:10

On 19/12/2025 01:59, Ihor Solodrai wrote:
> This series changes resolve_btfids and kernel build scripts to enable
> BTF transformations in resolve_btfids. Main motivation for enhancing
> resolve_btfids is to reduce dependency of the kernel build on pahole
> capabilities [1] and enable BTF features and optimizations [2][3]
> particular to the kernel.
> 
> Patches #1-#4 in the series are non-functional changes in
> resolve_btfids.
> 
> Patch #5 makes kernel build notice pahole version changes between
> builds.
> 
> Patch #6 changes minimum version of pahole required for
> CONFIG_DEBUG_INFO_BTF to v1.22
> 
> Patch #7 makes a small prep change in selftests/bpf build.
> 
> The last patch (#8) makes significant changes in resolve_btfids and
> introduces scripts/gen-btf.sh. See implementation details in the patch
> description.
> 
> Successful BPF CI run: https://github.com/kernel-patches/bpf/actions/runs/20353330265
>

Thanks for this; in particular patch 5 is a great help! I verified that
changing pahole version (without running "make oldconfig") results in updates
to the CONFIG_PAHOLE_VERSION etc. Feel free to add for the series

Tested-by: Alan Maguire <alan.maguire@oracle.com>
 
> [1] https://lore.kernel.org/dwarves/ba1650aa-fafd-49a8-bea4-bdddee7c38c9@linux.dev/
> [2] https://lore.kernel.org/bpf/20251029190113.3323406-1-ihor.solodrai@linux.dev/
> [3] https://lore.kernel.org/bpf/20251119031531.1817099-1-dolinux.peng@gmail.com/
> 
> ---
> 
> v5->v6:
>   - patch #8: fix double free when btf__distill_base fails (reported by AI)
>     https://lore.kernel.org/bpf/e269870b8db409800045ee0061fc02d21721e0efadd99ca83960b48f8db7b3f3@mail.kernel.org/
> 
> v5: https://lore.kernel.org/bpf/20251219003147.587098-1-ihor.solodrai@linux.dev/
> 
> v4->v5:
>   - patch #3: fix an off-by-one bug (reported by AI)
>     https://lore.kernel.org/bpf/106b6e71bce75b8f12a85f2f99e75129e67af7287f6d81fa912589ece14044f9@mail.kernel.org/
>   - patch #8: cleanup GEN_BTF in Makefile.btf
> 
> v4: https://lore.kernel.org/bpf/20251218003314.260269-1-ihor.solodrai@linux.dev/
> 
> v3->v4:
>   - add patch #4: "resolve_btfids: Always build with -Wall -Werror"
>   - add patch #5: "kbuild: Sync kconfig when PAHOLE_VERSION changes" (Alan)
>   - fix clang cross-compilation (LKP)
>     https://lore.kernel.org/bpf/cecb6351-ea9a-4f8a-863a-82c9ef02f012@linux.dev/
>   - remove GEN_BTF env variable (Andrii)
>   - nits and cleanup in resolve_btfids/main.c (Andrii, Eduard)
>   - nits in a patch bumping minimum pahole version (Andrii, AI)
> 
> v3: https://lore.kernel.org/bpf/20251205223046.4155870-1-ihor.solodrai@linux.dev/
> 
> v2->v3:
>   - add patch #4 bumping minimum pahole version (Andrii, Alan)
>   - add patch #5 pre-fixing resolve_btfids test (Donglin)
>   - add GEN_BTF var and assemble RESOLVE_BTFIDS_FLAGS in Makefile.btf (Alan)
>   - implement --distill_base flag in resolve_btfids, set it depending
>     on KBUILD_EXTMOD in Makefile.btf (Eduard)
>   - various implementation nits, see the v2 thread for details (Andrii, Eduard)
> 
> v2: https://lore.kernel.org/bpf/20251127185242.3954132-1-ihor.solodrai@linux.dev/
> 
> v1->v2:
>   - gen-btf.sh and other shell script fixes (Donglin)
>   - update selftests build (Donglin)
>   - generate .BTF.base only when KBUILD_EXTMOD is set (Alan)
>   - proper endianness handling for cross-compilation
>   - change elf_begin mode from ELF_C_RDWR_MMAP to ELF_C_READ_MMAP_PRIVATE
>   - remove compressed_section_fix()
>   - nit NULL check in patch #3 (suggested by AI)
> 
> v1: https://lore.kernel.org/bpf/20251126012656.3546071-1-ihor.solodrai@linux.dev/
> 
> Ihor Solodrai (8):
>   resolve_btfids: Rename object btf field to btf_path
>   resolve_btfids: Factor out load_btf()
>   resolve_btfids: Introduce enum btf_id_kind
>   resolve_btfids: Always build with -Wall -Werror
>   kbuild: Sync kconfig when PAHOLE_VERSION changes
>   lib/Kconfig.debug: Set the minimum required pahole version to v1.22
>   selftests/bpf: Run resolve_btfids only for relevant .test.o objects
>   resolve_btfids: Change in-place update with raw binary output
> 
>  Documentation/scheduler/sched-ext.rst         |   1 -
>  MAINTAINERS                                   |   1 +
>  Makefile                                      |   9 +-
>  init/Kconfig                                  |   2 +-
>  lib/Kconfig.debug                             |  13 +-
>  scripts/Makefile.btf                          |  21 +-
>  scripts/Makefile.modfinal                     |   5 +-
>  scripts/Makefile.vmlinux                      |   2 +-
>  scripts/gen-btf.sh                            | 157 ++++++++
>  scripts/link-vmlinux.sh                       |  42 +-
>  tools/bpf/resolve_btfids/Makefile             |   3 +-
>  tools/bpf/resolve_btfids/main.c               | 358 ++++++++++++------
>  tools/sched_ext/README.md                     |   1 -
>  tools/testing/selftests/bpf/.gitignore        |   3 +
>  tools/testing/selftests/bpf/Makefile          |  11 +-
>  .../selftests/bpf/prog_tests/resolve_btfids.c |   4 +-
>  16 files changed, 443 insertions(+), 190 deletions(-)
>  create mode 100755 scripts/gen-btf.sh
> 


