Return-Path: <bpf+bounces-43395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA989B4F9B
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 17:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF6A28880E
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 16:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412821CC885;
	Tue, 29 Oct 2024 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5augkyu"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6401A5C96;
	Tue, 29 Oct 2024 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730220066; cv=fail; b=lIch2pYC/MGpx9q2cHGrLt6b6IR7rLQZ2ogLpUBL/s2khypqf92bX+DFYDUfQxEdplHY1efmZY18vHxVx2ba4cIYRR4bNL/C+vmPehF/zzNb7HfGI+wHMqlXRc6jE5d/nrKF87k4qu1KAciayY2axo8yVIzQ52mn/f5QQJKdGb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730220066; c=relaxed/simple;
	bh=/MhxfaeuG1SdtkczC4spMQYobZlongMIVaR+YulAjQo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U+3n19uEqCBUkKtPeTx3DYZ6QxwmykodQbgQZjix9ee3fDILTUjOF5ZMSQXMEofCZL9AnwqHAiPwLsKh5r6dqHxd2Usa6kV2gxODEdkww0I+b2sVgKEswflFBKBokAn3MbTMZFobODIJTkPq6gHuur4YZRG7wkv+JCGrg5Kn0iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z5augkyu; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730220065; x=1761756065;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/MhxfaeuG1SdtkczC4spMQYobZlongMIVaR+YulAjQo=;
  b=Z5augkyuY5/JIUvjESZIKiKrq0rbNBwYiNsAmWxcEBC+8rR7RkI6prl+
   eX2unPWLYfhAR797TyE9N+E6yn0GzXYRDHTv1VSNS8UXayN4Iv2UGK/xh
   u7+1SIrrabqzsnUQUvFZQGQxHuiWMNJOAodKXuwUgMTXt3Vr9IlSCYfu8
   eJyPKO9QEmQnj2ouhGMPjDfEEp/TElN2s9hL3kwTvhxwNNuwq8ajpC4WI
   +7AjsjYAf7tWHhwtSjFTCkOnvXpOpWTQGnfu8uwT1/ubyX5ysT5vxXIP6
   R622AQ6z89TodMJpIBKvYviN0oZjoQcXZLwCaHYUwlIdF/4jREdTTWDlj
   Q==;
X-CSE-ConnectionGUID: aBLAjF4GQjK2ypJM6kyGfQ==
X-CSE-MsgGUID: DLrrk1yvT2i76W25k4qGHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40409641"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40409641"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 09:41:04 -0700
X-CSE-ConnectionGUID: 5svShQunQluk249QAhVwPA==
X-CSE-MsgGUID: 2RJiFX/3Q+qrbQq73OWulg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="112824941"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 09:41:03 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 09:41:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 09:41:02 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 09:41:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVsCHNdHHIH+rKotSvhlyXPxG/1EL61xw/uTYVSmv01bU5EhnCAh/S2GO2OeET9LZ6gwBCDoxs0w0qjs+CI2EG92majjHhbyHpWr0GJJtM4FCjB3Ikh8KdhdRLWd780M2qYYbWep8Soi5kXUwcbExnbilJz7alaJQUvTg07Qgs76ij/Jozl8liwp3ouBGMQr8MjXOyToKKBsNnaBziS3cB3wSTlnXDKz2y1XS/GqVBIh2arlkm4mApXjvQ+I/IGj/k/lZcuxmkbNQ6n4t3EIVS2HKH73BjWWB0Mxhx6Pw30Txx4g6NYX8aohd+xDm9lySRDCMugbB3dDUs56J0JogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBb3HSnk84F40YOrwnXVUcyZZZGV8sfnz5knhG9ukXY=;
 b=dRZaANglpJ1Mll6QCwlEhhYcwNkRMB5gtrUHkJQT4fylO2m83CLCP2fHw3XNDz0DBJn9w52RY0aGYH+vWdaqP6ixEXTpedmBKB4+jrNMielbH5WX/pBYLOnG8kCX6vmcec6BfVsNprztutSqhmyqsXUzM522FdW973c75RW7/bPlmH9TKcJ/2ultC5VFnJvV63ubb6oYLfc9j5YkMN+0to2cI1/rSDDuy/mIub/KS4Jst62xPRwQ3Skf6rewlUrO4oNqiTOfqWt7xW9YX/iW+AIhBmDa8vRHAylnjuKi5RoVvFyg0QFiKw77JULdJJ7nbn8e+n3na8QUaGNVJevqDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYXPR11MB8712.namprd11.prod.outlook.com (2603:10b6:930:df::17)
 by SJ0PR11MB6669.namprd11.prod.outlook.com (2603:10b6:a03:449::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 16:41:00 +0000
Received: from CYXPR11MB8712.namprd11.prod.outlook.com
 ([fe80::4441:4b98:d42e:82fc]) by CYXPR11MB8712.namprd11.prod.outlook.com
 ([fe80::4441:4b98:d42e:82fc%7]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 16:41:00 +0000
Message-ID: <9b6bc5f1-9e10-4bf1-a6b0-bb6178d771b0@intel.com>
Date: Tue, 29 Oct 2024 17:40:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Drop packets with invalid headers to prevent KMSAN
 infoleak
To: Daniel Yang <danielyangkang@gmail.com>
CC: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "open
 list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)" <bpf@vger.kernel.org>, "open
 list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	<syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com>
References: <20241019071149.81696-1-danielyangkang@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241019071149.81696-1-danielyangkang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::19) To CYXPR11MB8712.namprd11.prod.outlook.com
 (2603:10b6:930:df::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR11MB8712:EE_|SJ0PR11MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: f22e9608-cdbd-4412-9745-08dcf8387828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmJUYmFPcGVTRHpHMGp2WkFvellUek10SEdsa1E2bm1BU3JlVExFSCtvci9v?=
 =?utf-8?B?WVJKMkh1QnVScm1tTWRSZkkyTVRWcThmdnNxT05hZzl2bFZhOE9lKy8veWZG?=
 =?utf-8?B?dDMyRW5VUlV2Wm1HNTZWY0dSMUdxTVY1bEZJZVIzc2V5UnVQZ1pNbElBSDYx?=
 =?utf-8?B?Qm40RlNNQXRES2dxUkptazlPMG41VkluZzNMN01vYUFMOEt2NWRmQXJwaHFi?=
 =?utf-8?B?bng5VWkxMGoxK3EvNzVCQm1WUkNyVDYxRHljUGRhOXJJek1UTEJtNGUxQjJJ?=
 =?utf-8?B?c21xVVlMWU5Gd0NkckhGY3NBeDlLaldWcWxlQ0hodFRrRW91REwrdlRROXhE?=
 =?utf-8?B?cldOb2N0UkNpZVZVbkFlbHJOMUNmb1R6b204aWRCZUQrRWhEMEp3R2QxRnhJ?=
 =?utf-8?B?RlYvcjMrTWY3QWFZK0tKV1licmtkaUtpemtuc3g4M2o2cnBHM1JZRjAzbGJv?=
 =?utf-8?B?VFZObmZUYmRmMDk1dGhrN2JlQmVBVGMxbnNZRTF6L28wVTVSOExyMEtPeVdC?=
 =?utf-8?B?TGJlQzFYSmZCQ1Z4cmRBWVgyK3hISHpyL25BVFl4M0NORkFWVGdjc2V5RTNz?=
 =?utf-8?B?ZklHUXRESVkvRDBkV3RKZ1BEb1RmZDAwTG1DTzBVY3ZUQXBBV3l5eitVYTcy?=
 =?utf-8?B?T3ZnbGk4T2d2Mld5di9WeERoRzVqa0N6cmR6c3BuZmtUWG5kTlpZK3pIbk9a?=
 =?utf-8?B?R2pDL2gvT01NZ0pqYVlIbjJxYjNMVlF0enJTc0ZPcjhaNnExM1VTYVlOMTk3?=
 =?utf-8?B?T1lZbENNb0RDZGkxSkRoZGxYZWZhayswRzBqOHZZa1dYSkhEUlVDRzJIRHRE?=
 =?utf-8?B?NW1jL05Bc2ZMTWI0RmJ3S2tkMFFCMXRwSEtkN2U1U2RtTk90UHo2VnlOR1Ri?=
 =?utf-8?B?NnM5TVBsVWlnT0JkMjBqdmVRcDh0Q29NZ0d6NG90bGx4SjRhcnRqOVNLS3Bl?=
 =?utf-8?B?S2ZJVlJlQ1VsOEIwbVg1V2dlRWdLU2NnajNpMXVWbjJKM0k0NEhRWVZSKzZN?=
 =?utf-8?B?Y3FoSmhjKzlRRE1nU0htNDFzQjNNQkhScUlPYnRGV2djVjhhei9hc24rci9p?=
 =?utf-8?B?QVhVY0VRdFdLNWhlbFJ3RG40cHlWM0JHRTdKVWtuVmxhY0dVZGcxMVNPWkJx?=
 =?utf-8?B?NWM3QzVuQUxaR1QrdHBVZ1FzN2FONnVMcEphVWlUbkdsMU9HRmdLdUgzbEtI?=
 =?utf-8?B?MDd2UGtQZFVxVDFidDVCNnJZb3YzS3NBdHZseVA3bk9nR2VlVVVVM3dwRVhW?=
 =?utf-8?B?MzZKZ0hJZnB6WW9PNXllZVZ5SEhMNWNULy9Cc1h0VkM5ZFNKVFkwcWdBYUFo?=
 =?utf-8?B?T3dPS2F1R1luWEVDaVkyZmJ0RXk5Y1F2cEcvWHVZeG9Ib3h3UE1NcGtuWG8v?=
 =?utf-8?B?ZnFyY0VWYnZJUml5OEdrNFdMU1ZRQWloUVoxeFhzWGZoMlZYbHY5LzFCUlQx?=
 =?utf-8?B?UHAwcm1Ba0lCQ05aOGJnZ2syQngwVmJCeTdjUE5JeXd2WHBkQWdWVTBkRVo5?=
 =?utf-8?B?L0lDMFpkTDdVRjBncDNVM2RhMC92b2NUMjhoVmdGU3EvOENkUU1uWWh5bEhQ?=
 =?utf-8?B?UXdRY014R2tYbzFPTUlSRmR1TllCdE9GTTdjSTIrNGpYSGZpMlYycE1lbzFK?=
 =?utf-8?B?Q0RtYkluVHpmazVtYWVya0poMnZDSEJWSXIwYmhIY1Z3a0xoVnJGM0wreHV3?=
 =?utf-8?Q?oxEZzjAujh90NJlQ8kIR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR11MB8712.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d21sZkVSWS9tcjlzUDZZNmpmejBYWUpMY0FsSnF6OVRTVDY0cWNxZ0ExM0x4?=
 =?utf-8?B?d2xlWnFnN0o3U21zdHZOYjJxZm5uamxRMyt5WU9XMmttY3dPSTdWb1VNelBX?=
 =?utf-8?B?R0R6clk1TVVkWCsyLzBpTTMxeitqSEMwSzJvbC9YaEgwaVc5WGVUVVdMVWl6?=
 =?utf-8?B?L2hUR2FkRkZLaTZPd0lkN0xYaTdQendYTHB3VzN1cUlWdVNKRDkrNnNKYjdV?=
 =?utf-8?B?SFdjVkJFakRpT1VNb3AwbndweVNZYWd2blBkd1FMMGZ4Y2Z0b3p2STlFS0Uv?=
 =?utf-8?B?ZU9mbGhWVndNRUI2U3VwSXJoMUlzR20wd0NVUlJ0eWVxU0tYV2VXNFdweDJK?=
 =?utf-8?B?cE9zTEkvY1hWOHpHa0NPVzZpRUJ1UGlJcG9RK09XbG1HQmFCYytseVlIczc4?=
 =?utf-8?B?SS9rKzB4bi9ZMDBISlp1L2Y0d0FCVE9rVmk1MHJObVo1aDQ5Q3E3dFlPdjBH?=
 =?utf-8?B?ZG9kc1hGTWtpTzlWNDBhb0V6STFYaU41RVhxelBmV05SUFFZMjNydmpLRk5P?=
 =?utf-8?B?blpnajJGcnhNYTJRTXpoQUtNQ1d0cnRaellydFVDeENvcU1YcjUxY1oxZGI5?=
 =?utf-8?B?OHEyaVdBdHMxVzlrTHdvZWRvQXlEZ1lOSkVranlMSG9HRzE2a1h3cm9YbHhI?=
 =?utf-8?B?aTV1alpCR1RNOFYwQVM5RkllZzhaSk1RK0grcUY2QUVoTStnODBnajZWV0FS?=
 =?utf-8?B?UkVnWFNKME1xSWw5aUM3QiszdEFKbXBodm45VkJic3JNaXFuVnBVcllkYlBK?=
 =?utf-8?B?Nk82UjB2NlVabzVLU2laeEJkWkZMVytQSkFsR0J0Y0ZjWSs2bGVWc0R2bTNE?=
 =?utf-8?B?WkxkMTU5WkNnbWtBMmZuZUtxV0JwR25lblR5cWszK1ZwekdjVFF5Zyt4STZa?=
 =?utf-8?B?Nm94Q0FXSVBCSzU4cXh3dTdYN1JwdEFZWmtpdkNzNFhTdG11RXlCYlREMmw1?=
 =?utf-8?B?RS9PMG0xL1pjU3JidU9iZjdQc1ZtOHc2TWFmNGJKR2JWZHR2QXIzQktzN1o5?=
 =?utf-8?B?YkQyRXk3T0tEb21MYWQ2UEdvcnk3Ulc3dEl0dE1yYWwzSEpBb2U5cklHWDY3?=
 =?utf-8?B?S2dOU016bHlGazZCTWhOUmpzWEpwRzlCS0NwK3I2d3FNa3FMUmNIbGpuYW9W?=
 =?utf-8?B?SnpWQ1BXY1p0elFIdjkzaHVhRm1CZGNiV2RiU3BIditISjN6Z2VwelcyYkw3?=
 =?utf-8?B?ZXVQU2tqMkxSdmVFM3VKLzhKb0U5Rm10WFFnRktNYmdKanNValFOejIxZis5?=
 =?utf-8?B?M1hyZkVaVFdRc1Z5aFQ1TEwreVpZMVl0TERWaW56UXlLWmo4ZllMaUZtMGVK?=
 =?utf-8?B?dWN5SVNzeWNiSTFGMXBTWUNFOG1abGE3TVhERE9zSXF4QWh5bXRuUEtYcjIw?=
 =?utf-8?B?eWhrZUY5UXhtbmFTVklUSjM0SFVwUG5ZTjA1SWFCQXF4d2R3V2VXbGU5NUhH?=
 =?utf-8?B?bGduRzQzVkJvQ0RuVFVtVmVVd0h0eGpWYkw5RXdqaUsxUjhnNGpjVU02TjVx?=
 =?utf-8?B?aEJvanlRcGgyanlubGVoRzM2T2N0RmYwT0tuWkRlSk5rVS9zYWk5dndtUVMv?=
 =?utf-8?B?NVhsK1BuTFNid05kcXdiVjhQaGp0aENOaEJ6V0x6QnY0emZDWit2aTdHSWN0?=
 =?utf-8?B?UlV1aHp5dVNDSXRTdUNJaCtLZEIxNGhXV3pSZ202T2hCcGlNMEpIdE54QUx2?=
 =?utf-8?B?QS9HNmVSRHpIeTN2bytzQlJDMTNSWWhuZXV3V0ZBbTljdy9jWVFuYkhwcjRF?=
 =?utf-8?B?NjNGYkszRGhwcTQ5QzJ6OVN3NmtHaExiNFFTdVA2cytzV0FFdFEvRGlBQU1W?=
 =?utf-8?B?T1NGaVRtYnZYNVM5bW93MHhRa2ltbGplOUVjMWhaVG15SlpUdWwrdXdkd0gz?=
 =?utf-8?B?YklFVmlTSldWUEF2ajdiVUpZYzdNcGhFUFlvRmlCaG4wbWM3WUl0Mmxwcm0v?=
 =?utf-8?B?Vzd2U05XOER3VjdZS2pEeFg1bDNpeHEvQm9jZHBzUzk0d1daTGpsWFdxRStm?=
 =?utf-8?B?N3pxYWJPdjR4ZU9iUXo1OFdKc1gwaTBpbDZXQmpCRmRLWEt5NEVBeTRhSFor?=
 =?utf-8?B?K0VqMXlna1ZCRU1qSFhYODBFS1I5UkkrVzlKQVJJQ1hzL0lLbVZCaHRrUFJr?=
 =?utf-8?B?bGhzc1RLZ2R3M3BSbkJ4bnN0U1U1NDJzK00yc2xmcy8xZ3BkeVZwZ2FqUFcw?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f22e9608-cdbd-4412-9745-08dcf8387828
X-MS-Exchange-CrossTenant-AuthSource: CYXPR11MB8712.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:41:00.1135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9memjVhV3YwiQ3PVdR+Vnd9ansltlbcHpuoh0nlGe8vp9rAb/0WyjqQnynp5ffmM/KX2q+fQQcX+Gug/8tesNLK8vQT+r9ssHDejsABGGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6669
X-OriginatorOrg: intel.com

From: Daniel Yang <danielyangkang@gmail.com>
Date: Sat, 19 Oct 2024 00:11:39 -0700

> KMSAN detects uninitialized memory stored to memory by
> bpf_clone_redirect(). Adding a check to the transmission path to find
> malformed headers prevents this issue. Specifically, we check if the length
> of the data stored in skb is less than the minimum device header length.
> If so, drop the packet since the skb cannot contain a valid device header.
> Also check if mac_header_len(skb) is outside the range provided of valid
> device header lengths.
> 
> Testing this patch with syzbot removes the bug.
> 
> Fixes: 88264981f208 ("Merge tag 'sched_ext-for-6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext")
> Reported-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> ---
>  net/core/filter.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index cd3524cb3..92d8f2098 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2191,6 +2191,13 @@ static int __bpf_redirect_common(struct sk_buff *skb, struct net_device *dev,
>  		return -ERANGE;
>  	}
>  
> +	if (unlikely(skb->len < dev->min_header_len ||
> +		     skb_mac_header_len(skb) < dev->min_header_len ||
> +		     skb_mac_header_len(skb) > dev->hard_header_len)) {
> +		kfree_skb(skb);
> +		return -ERANGE;
> +	}

I believe this should go under IS_ENABLED(CONFIG_KMSAN) or
CONFIG_DEBUG_NET or so to not affect the regular configurations.
Or does this fix some real bug?

> +
>  	bpf_push_mac_rcsum(skb);
>  	return flags & BPF_F_INGRESS ?
>  	       __bpf_rx_skb(dev, skb) : __bpf_tx_skb(dev, skb);

Thanks,
Olek

