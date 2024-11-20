Return-Path: <bpf+bounces-45274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB419D3EEE
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 16:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45701F2618C
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 15:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDFA19F104;
	Wed, 20 Nov 2024 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1DGiFzg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA2A1F931;
	Wed, 20 Nov 2024 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116255; cv=fail; b=m4KBB7wO0Bhel6KSbkKNG2e7sIMDcIuvuHXXuZxR9qy+ClYb62PRQZ+HACNEOslATWHhy/jhCXc7W/I6EtuzvnQvGauH7nPpRAnqEN1C2GEM6/SSIM3Ddm1YTXZm/+IPerlRgSOdmO4LRZ/9folNfem08rGkGra7PJd3PInJcDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116255; c=relaxed/simple;
	bh=0FnZWD9JUKmmK/hXQzytNFHhDRWqz9w9zGHSG8up97I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UiCCLZecarI0OJerZwpvJnNNu6Q9TuIG+6cUhT8VvmEvE5zj4/9iaBtZcKdzqfVmf/1VU6AP1cXLZaFfnSRNLMbmgnCqwrFiH/KJIcCDQhywTKLGTuMIMHS5ISUabG8dyKXcScggmOEQLOXWswTbDu9VHSXVWNxxp95Jxy/TzWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1DGiFzg; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732116253; x=1763652253;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0FnZWD9JUKmmK/hXQzytNFHhDRWqz9w9zGHSG8up97I=;
  b=m1DGiFzglOcRPfoA0UJ7QWK6apSH5/aEunCKawHrqOF4r2wHhshE6a5N
   5B8YgHJdoIqYg4E6H4laW+Su6gac1B5Tvr2n1reqiX2WG7Nc3DSAMJPJ/
   NKTSZy9d4iNvX8ppd+rWte0Zr1BcN3hzou0GYeoyk2cIHxPAhnJQeOnmk
   /A+t8+kzeUe83Kbu/b8mxd41NLMLKAA1BXjx8qHMxUmHm9NEZl7lEHoBl
   tq6oOjIVn8QoVuA4bsIU/T35mz+4qnx8QqXun8JG1+fK6UYzrWRkigGUo
   woBZscfKnrieCuHEsuJaxdlfEG47pqLap+08yAL3rhDYJC+Zzipi+tLws
   g==;
X-CSE-ConnectionGUID: MuO65Kp7R2ip8LF0kEJPqw==
X-CSE-MsgGUID: CfylpYWxT1CI/IwK4ChYYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="35967871"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="35967871"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 07:24:09 -0800
X-CSE-ConnectionGUID: nX5EYtm3RbGpN+PNDOj+3A==
X-CSE-MsgGUID: FDNYakLSROiN/Oz33d84ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="95017550"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2024 07:24:09 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 20 Nov 2024 07:24:09 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 20 Nov 2024 07:24:09 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 07:24:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fi19Er4UyLwsG5blvToAHNU3A9z67WjXT9M5qbW6r5wvJ4gEOTDwVC2+c7pz44nf6RAv+FH8hPW8R91djPOvAqdkTz+7XcNrnE6FUA/rWyl9WQfx2Z2/OaNKqjaiAsLy2/5UOWqWAxQdoofU4iF2raMsbAcnM2CiYM5ac4cqdI46GYYrbXA28ycGr2hfRyVdI4h3aDES9YYzoVNsRakZUhttqZwS622nqMJNfOH898YpHSB4ZZQZ6bSk//sBXBVJMZlNmH0b3tYISTmsEAoiKklDh9In0i0StvqtIo162UmqYzVSTe/xCJCcFlUyZtBs6/3Yw/tnV5vElma8+dZZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfSelbFxMhyjv4CFxxvmg4LfE5UsutS0FmnNykauuF4=;
 b=Aw+4wJtDTHnQbQMKGB9HQlC956MVR1dj3AJ0l+aNLg6fUbJlw+2jGEyNgn2+ygiXTI8heHS4xbRmaw9HC1pLmE8328Yw0jemZUy2IHCA0qmNjO7zJUNj3epGsXSTqv3RL3oaNNyEXXc7U3ZXiRdGK9W3cFxK0ZP7RZoopOLM7maivhtD3W4BrjgjH8I5wpcdnqj/kyn05J6mWy3p5co9oQ216MgzWxGjTmyouydifuqmD/q1c0c5pBFb+oJ0wTWsd4DX/SbOVhvuColDDeAVBcSRy4LkGdamFqlu7N9Jz9RvW/X2w8DHd9XsxJDhpeEuLczSHbfCl2VePJ3nD91StA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB8717.namprd11.prod.outlook.com (2603:10b6:8:1ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 15:24:06 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%6]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 15:24:05 +0000
Message-ID: <6af7f16f-2ce4-4584-a7dc-47116158d47a@intel.com>
Date: Wed, 20 Nov 2024 16:23:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 00/19] xdp: a fistful of generic changes
 (+libeth_xdp)
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
 <20241115184301.16396cfe@kernel.org>
 <6738babc4165e_747ce29446@willemb.c.googlers.com.notmuch>
 <52650a34-f9f9-4769-8d16-01f549954ddf@intel.com>
 <673cab54db1c1_2a097e2948c@willemb.c.googlers.com.notmuch>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <673cab54db1c1_2a097e2948c@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0114.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df4d65a-3dd4-40c5-8699-08dd09775ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1V1MllTZDFCVEdrOEo0MWFHVXJTZUZ4Z0lDSlVTTFFlNEhDMzE0amNxc3BM?=
 =?utf-8?B?cVFHQm82S2ZZZXBwK0J0bm5WT1dTVm5zL1h1YnhXb2FQVmpJS0VUUjFueUd3?=
 =?utf-8?B?Y3ZyWWhNM1Y0WmhuQUVtVm96N2NjQjFpRGg2OHAwUmZQRlczWVZDRnBCa3BJ?=
 =?utf-8?B?OEdneERFVlRYRm51SkhreVRkOTd4Ny9GZkNJZ2FJaWc0bXNQVlZGeG9KemhG?=
 =?utf-8?B?azRUQ05MWGhsOFlJL2xiOFhBaWZOWTZpaHdjbWR3RUtNbWh1WUQvME90RGNa?=
 =?utf-8?B?eEloNnlOOWk2eGdhcVhBTmNkWFZQV1hMWUI5VlR5dHZWVm9HeVNnVUlsbFJw?=
 =?utf-8?B?RUtiZmllRjIzVDVLWVNRQU9SWjNwWFFQdkNTbXkwaUNvVEFQbE1oaTJlOHVt?=
 =?utf-8?B?c0hiMzlQbUhEL2ZHMlpmNTA5Y3JqSHFCRjBSZFV6QTdFZTU1NVRuQUpVZ1pm?=
 =?utf-8?B?OXFQM2hVUHRITkdPRlEwdXZjNW52cEliQXlidFlOdllaSVlZWTRNaHNjRFRm?=
 =?utf-8?B?M1BZOXRCekJHdWhqMU4vWVZaVjVYVzBXbzhxejkyVTVmeGhocllGOFFFb3RR?=
 =?utf-8?B?cEFZSEJiOFY1N3o4T3haKzNqRGZteVMrSVo0SWl1Y3F0bTIzczk5UmplNEND?=
 =?utf-8?B?VUM5Tk0wVENQaGR2STk1M1pXNEpNb2s0ZCtjN1RWUVFldGEwMzFEcXBTWmpT?=
 =?utf-8?B?NnVzcDlmREdqNVJlSDlFOWdFSGNlUlVYb0I3Q1U3NHFRa05nZExaVnROc2Vt?=
 =?utf-8?B?WmZxdlozZWEveDZiV1REY0d2YjRsK2FnL1pLcjlHQTZFT0IzMFlMQ2pLdmc5?=
 =?utf-8?B?djF1bjN0a21tTHd4ZTRFb2J0a0tkV0J5R1IrMllYakNmYkhTMFozZEZxS01y?=
 =?utf-8?B?M1ZBWVc0dnB2d3FET3A5eHE1S0FzVS9LdUkvQ00zNkZlYUZkRVMrNGlTVk4y?=
 =?utf-8?B?T1JvdEtmSnFwWDhTZWRBdVlpYUkwUmNaSVo3MkJtc3BtdTBrSXRzVjF3aURj?=
 =?utf-8?B?R2pTUk1lNTRmU3YwNzdTK0ZodlFDcVhibks0QUg5VGRZTVBLT0VLYkQ3MmxS?=
 =?utf-8?B?bnpJRmpQZEhrd2xsS3FUUW9pYmY4d0ViUzQ3T2lqQ3hKZC9tWGVVQzBQRnpa?=
 =?utf-8?B?Nm1MV2tzWlRzcEdDVHBVbUQxSlBTY25peFFUaXV2TEpTZVlXSTl0aE5OL2FF?=
 =?utf-8?B?YUNyLzdPektHMk1wMHFHTmRSMVFNY2lYbk0xbnZZVXJZcDc5N0tzVHpzSDNY?=
 =?utf-8?B?eEtDQzVzR0djaWxmUFdqdTArVlg1RHNNb3RFNTlrbWZ1ZVBJQzBkcSs2Rmg1?=
 =?utf-8?B?emFLMERQYmk0eTRrcWtja01PVGJGMDdWb0N2cmEwS25pZmpsQXczd3pZV0tr?=
 =?utf-8?B?RGpUR2NZSk1DU2pQZDQrSlBsYjVmOE5VZnNjV2JjYTdjb2lWWG91bDVZcGg0?=
 =?utf-8?B?SC92OEhKTFp3ZlhOUmJRNjd1Y3Z4dFNvMzBJUWlKbGZQTzZLT0EzQ1QrZDkw?=
 =?utf-8?B?RjM4K2Q1TVJjYytOOFdDS2lIZ1Nza1JCZ21KRkFBYVFlUGg1NmQvNUdadVhL?=
 =?utf-8?B?UFVSV3JheXdHSVU2V2VoaG01ZDA3M1R4cUNwTmV3VFhSWFhuT2M1NGVLQ0Jj?=
 =?utf-8?B?MXhKMVhwamNDaE56ZGFQcE9IVXdZck43QjlIREs3N0xFbDE5bGk4TTk0ckZl?=
 =?utf-8?B?N2JVcngvT2pjbjEyUjMza1JIM0NVeXIwbGp5LzRXUE5ha3c4UEFGTWIwWkR1?=
 =?utf-8?Q?Z+2K7AkTMDMHcGH2gLVQ5VYOMXZxpxsaPR485QW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3o2ZFB0MEw1R0NyWjl6aHNrMXcwbENCWFhoZlV4WTAzL2QxTnRoaFMwSUVL?=
 =?utf-8?B?S21paGxRTmEvZnM4MHN5ZERRKzRhQWJGTWJ0cnVpSytQVTRreUxwQ2ZvNmZC?=
 =?utf-8?B?TlpHeldZZ0JEZDhMclJETGRNbkRDNS9FaXJlaFZrbE50a1pWWHZnWjhkc0V1?=
 =?utf-8?B?QzNYWC9OZytnUTZMUlhUUFUwRk5oWVJkNXIwSTYyOXBCLzVDYWV3OWRqV0ND?=
 =?utf-8?B?ZzZhYkJmRW1xaU9DOGlIcVdMWEt3dGgveEFxbjBncUp4S1RmdjBOc3Jib0Vj?=
 =?utf-8?B?eGVxcDFERUo5N0htQmZES2IyeGp0WWdDVDVBNU1BdUdSZ3VhWnIvcnZPWFc1?=
 =?utf-8?B?ZFJVRkxKZEZUeVZlK0pmZTlLdnBibHNrcjRDeVhtS1ozdzR5TXlYM2thSzRu?=
 =?utf-8?B?N0VFeGlsVGNhN2M1RnJBc1Q3eVNUQ2FVa3NxeFNvQjg3bTF0cExEMi9Eczhv?=
 =?utf-8?B?d3VJNVFVT3RKcEhScnVZY0xtcU9rT0FaWnA1ZlVwT2I1alFZRWIwTjdYOVBM?=
 =?utf-8?B?TmUvaGFSL0w3bDVQaFlRb2Y5dUMyWVlpbkhkZytBaUN5eGwxMGVwaXdQZDds?=
 =?utf-8?B?QUdQWTcySWlIdlRlRjBTb3NYR09GQjI2OXZ2ZDBpRk43anoyR05VcndsOVNo?=
 =?utf-8?B?cFFVOHh6MzlqWGt1OTg4TlJ5L3VtVHBwNTlOSGJiNW5pN1ZTbEthVjFnMHpN?=
 =?utf-8?B?SFdSOGM4NUJWMXk2bFdIMnV5TFRSUXVsNy96b2NkTjIzTnFZUDE1Zk9pTGVu?=
 =?utf-8?B?L3VNUTdKd1JBZldWdCt4RVFkR09mNEhqSWZoNUdtRm9jRlpqYlZNZUhMYTEy?=
 =?utf-8?B?VllxeGJISnBKTTFzSmZ6YWVwVklralR0SFppSTZ1cVlTZ3Fwak5PckV5VHoy?=
 =?utf-8?B?b0ppN1FpS0JJWU9BbDdZZnNmSVVEK2xHWDZZb0ZhVzJGUGZuM0FJaGQwekxz?=
 =?utf-8?B?OUVZZ1NIU0NtNTJOSVRJYkxoRlIvVGNxclFCdmtrSnBDK29heW0yR2dpNS9N?=
 =?utf-8?B?VHExT0lUS253VGo2NHQ4Qk5NNkMvd3ZHTm9kdUdOeXpWaHhlbWxoVzJnV3pI?=
 =?utf-8?B?dys5eko5Q3BPV3hWVTVqZE9HUnpSTEVjVHQ3U1MrMitUd2Jiek5hV3RoSWpr?=
 =?utf-8?B?akwvQXZMdzdmOVpnMGJBV3ZGWFF3dzZGOGpIVFYrZzdiUlNCVFlla0NMRWR6?=
 =?utf-8?B?ajFaUG4yeE96SWdQOHZscC9JbEJxdEFpRHBwM2JuSW1IVEtucWxDdUNwMFB5?=
 =?utf-8?B?QkJxZnUyUnRnbWJjU0QweXgwWWRybHg3NzI1Y2hFRGJHT3dQT3g4RHg2MFB0?=
 =?utf-8?B?SFRwbjRHTnlsZEN2NCtZMDM4SytGdTNEdG1Zd2JKTERMTUE5R0xpNmNPVGd2?=
 =?utf-8?B?M1BySE9aTS9QN0pBSFpPdko1Ry9pREQzMXNLbldzeXcyQzhPU0tnR0xUOGNm?=
 =?utf-8?B?cVg4QmdjMmxlMk8vbzZLOGVMeHZ2eFpTSnBJS2xzUzJXUXZWKzhrUkJLR1oz?=
 =?utf-8?B?cHBJbFBUeWpzaTZCRnZSbzBWeDZlZklnMkoyOXMvdUpBU1NMY21HTElZc0hC?=
 =?utf-8?B?VStML0VKRzdiUkRPYUUyS3NCaDJHbWNSSk1CdlNhald2eFdjL2tlSVhYY3V1?=
 =?utf-8?B?ZGsxdEtRSTRoN0g2U2dvTHhxUmRwMVdxbEMrTWhSQ211ZlRnUUdDZFd6bTBa?=
 =?utf-8?B?eEl0T0NpeFlFTGhRaU1JV0JqYTV6S3BlYWRMUzVMSGpvT3N3cmpBaWZRdDlv?=
 =?utf-8?B?ZkszRnorVjVmNzdvbzlYY3dqNW1BdVJBTjFxU3gyeHVlSEphTmpIWTJoSkkx?=
 =?utf-8?B?M0Fxd01mK1JqM0pRM21OZnloTCt4c2NhSkxYWEtBaHZUZlV2S0Q3a0JjL0xQ?=
 =?utf-8?B?UXJBT0pXOUJ4THEydEJtQ0FPUGN5SFIwT3k5V3hRRE5Ydnhyc2h6QXEwNzhM?=
 =?utf-8?B?MGhJeTRxWS9iYkhHbmlvRCtnSGt2YTJsTVlVUjYxdjNXcmsrTlR4SEhQeWYv?=
 =?utf-8?B?QmtwdGdzRllaM2JyRndmeWpKQ0hQRldPMk1XSVBRSWpEMVB0UFlkMmNxbEhX?=
 =?utf-8?B?KzhTWVNIakYvODFhTm5IdFpyVjJpS3JaTjJnaU91YkJSRDk1UW9JTVJ6UFFY?=
 =?utf-8?B?V1VKTXV5QWcrY0c4TzhQY1h1aHY5NWJUaVR5UFVCSlZQUlY0aGVtOVNQVzNK?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df4d65a-3dd4-40c5-8699-08dd09775ef2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 15:24:05.8486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftRUXqWw2w8l0Xl/lGTr20wqaTJAUxmOkKgIUUZkDiB9KGi+Mdf42iFKnPK2vUQe1DYHCqT5mexN570QQscM8XipGdv7SXE/ejGmpUwkF1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8717
X-OriginatorOrg: intel.com

From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 19 Nov 2024 10:14:28 -0500

> Alexander Lobakin wrote:
>> From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
>> Date: Sat, 16 Nov 2024 10:31:08 -0500

[...]

>> libeth_xdp depends on every patch from the series. I don't know why you
>> believe this might anyhow move faster. Almost the whole series got
>> reviewed relatively quickly, except drivers/intel folder which people
>> often tend to avoid.
> 
> Smaller focused series might have been merged already.

Half of this series merged wouldn't change that the whole set wouldn't
fit into one window (which is what you want). Half of this series merged
wouldn't allow sending idpf XDP parts.

>  
>> I remind you that the initial libeth + iavf series (11 patches) was
>> baking on LKML for one year. Here 2 Chapters went into the kernel within
>> 2 windows and only this one (clearly much bigger than the previous ones
>> and containing only generic changes in contrary to the previous which
>> had only /intel code) didn't follow this rule, which doesn't
>> unnecessarily mean it will stuck for too long.
>>
>> (+ I clearly mentioned several times that Chapter III will take longer
>>  than the rest and each time you had no issues with that)
> 
> This is a misunderstanding. I need a working feature, on a predictable
> timeline, in distro kernels.

Predictable timeline is not about upstream. At least when it comes to
series which introduce a lot of generic changes / additions.
A good example is PFCP offload in ice, the initial support was done and
sent spring 2022, then it took almost 2 years until it landed into the
kernel. The first series was of good quality, but there'll always be
discussions, different opinions etc.

I've no idea what misunderstanding are you talking about, I quoted what
Oregon told me quoting you. The email I sent with per-patch breakdown
why none of them can be tossed off to upstream XDP for idpf, you seemed
to ignore, at least I haven't seen any reply. I've no idea what they
promise you each kernel release, but I haven't promised anything except
sending first working RFC by the end of 2023, which was done back then;
because promising that feature X will definitely land into upstream
release Y would mean lying. There's always risk even a small series can
easily miss 1-3 kernel releases.
Take a look at Amit's comment. It involves additional work which I
didn't expect. I'm planning to do it while the window is closed as the
suggestion is perfectly valid and I don't have any arguments against.
Feel free to go there and argue that the comment is not valid because
you want the series merged ASAP, if you think that this "argument" works
upstream.

> 
>>>
>>> The first 3 patches are not essential to IDFP XDP + AF_XDP either.
>>
>> You don't seem to read the code. libeth_xdp won't even build without them.
> 
> Not as written, no, obviously.

If you want to compare with the OOT implementation for the 10th time,
let me remind you that it differs from the upstream version of idpf a
ton. OOT driver still doesn't use Page Pool (without which idpf wouldn't
have been accepted upstream at all), for example, which automatically
drops the dependency from several big patches from this series. OOT
implementation performs X times worse than the upstream ice. It still
forces header split to be turned off when XDP prog is installed. It
still uses hardcoded Rx buffer sizes. I can continue enumerating things
from OOT unacceptable here in upstream forever.

> 
>> I don't believe the model taken by some developers (not spelling names
>> loud) "let's submit minimal changes and almost draft code, I promise
>> I'll create a todo list and will be polishing it within next x years"
>> works at all, not speaking that it may work better than sending polished
>> mature code (I hope it is).
>>
>>> The IDPF feature does not have to not depend on them.
>>>
>>> Does not matter for upstream, but for the purpose of backporting this
>>> to distro kernels, it helps if the driver feature minimizes dependency
>>> on core kernel API changes. If patch 19 can be made to work without
>>
>> OOT style of thinking.
>> Minimizing core changes == artificial self-limiting optimization and
>> functionality potential.
>> New kernels > LTSes and especially custom kernels which receive
>> non-upstream (== not officially supported by the community) feature
>> backports. Upstream shouldn't sacrifice anything in favor of those, this
>> way we end up one day sacrificing stuff for out-of-tree drivers (which I
>> know some people already try to do).
> 
> Opinionated positions. Nice if you have unlimited time.

I clearly remember Kuba's position that he wants good quality of
networking core and driver code. I'm pretty sure every netdev maintainer
has the same position. Again, feel free to argue with them, saying they
must take whatever trash is sent to LKML because customer X wants it
backported to his custom kernel Y ASAP.

> 
>>> some of the changes in 1..18, that makes it more robust from that PoV.
>>
>> No it can't, I thought people first read the code and only then comment,
>> otherwise it's just wasting time.

Thanks,
Olek

