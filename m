Return-Path: <bpf+bounces-70422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1FDBBE779
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 17:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 603E4349AA6
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218332D5C8E;
	Mon,  6 Oct 2025 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jFRrfQKg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B734C2D3EE3;
	Mon,  6 Oct 2025 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759763995; cv=fail; b=KJ+G3WlEZ8+0Hci5I9BPlLAX0SDDpwMRrE7Xll5UmR1t0m3LORTPQ4fmM0nSrYOLhriHBHfuFQkATtdn/NfNgwqE70Y1uq/QEspKNFJVKwq4yr0uB6PViAfp5oFQdOK8h/IfGyPKPyfSf0qowI48tdmyeUhN0cI8yN1p0W/rMgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759763995; c=relaxed/simple;
	bh=pQIjWPUV5omjvWKfOtWUbT9kvbVbJ244KBcGgCzrBxE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KfUu92HZHBkFFDAsXPIPrjoqAHnyH2i98Du2SPxJj8vVHtI+240jRb+jUEyi7E/u8Gm2q+WKrWW9imp/I594N3shH5r43PZkNZPYZHtQFup2epx6oUB2nG4xUk+68pWedS2957sT8N+QNuu5ZxYspgy78wogsT/d/OFrThY2m+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jFRrfQKg; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759763994; x=1791299994;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pQIjWPUV5omjvWKfOtWUbT9kvbVbJ244KBcGgCzrBxE=;
  b=jFRrfQKg7pNDtTvRUmS90mHANGtojWjsbyutbv62/8wECx5zP21kgYfp
   0jKRAcR3k/FB/utcN3LJc1pYVOHjxuyYFoI2VcXpNnWcZ5uqs+0oN5h3U
   i+kqIOA3w0koNc0Jy3ioSNY3GxbTdgf+bPbLXHTWqOT3c0mRJrD22W03Q
   IXL3jfN1wpm/m1jRLUT5+Srb4siz6rqUML0VicVTG2qfRk1piZia5ilKZ
   T2MEAqfUsz2BpXB2SDYxahUVpgfFacEldpeSR0MeM8UyZNTIkHfbixcHo
   jm75Qb0kYEJ4rRB8OAXKbuoGTXZrm1Xx4BzasH4aegnYNEZe3xWoUzb2U
   Q==;
X-CSE-ConnectionGUID: eCN8tXLSQoqZLZFbf70FHQ==
X-CSE-MsgGUID: NX2AJd9PQuq8/q9Vu1q+Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="62106307"
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="62106307"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 08:19:52 -0700
X-CSE-ConnectionGUID: ksmyqEUESyqiklHR3em1dw==
X-CSE-MsgGUID: 0Mk5DfN4TpG92fo+OuMrfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="179179845"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 08:19:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 08:19:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 08:19:51 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.68) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 08:19:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjJEoqN6g278vKC/0fF7mrlxmlAIo4wnQOr59je39td7h8Wuiwuk43HTxn30WD7WonogLOtChzhQcSjIs9F+3CHsaldtRuRXszXHbA0sm4MpUXHIQhOEecZg8hrD1vN6A9uHMx9aAFM5rDjZAdpHBSOunWsES8AeFLiPIo9XgIQJFSOzdnsTqCy1ZbfVE04BB/9T/dr9OsoyfqEmHlIBCJ2FNhStyK6+MsAOUVb6nl2RI+cnN38kcV+ubBHeMOlZKF74LSrt3Qpu20sjvoKZIVLcvCPcbVmsZcb6YRp9t3LiUBk013JGFyCwpbl1SYZm5Go4sWQTHKvoLAZOH9SCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeL6QOAxQkk1f8ExzGKvY7+t6V+U5ADzVCChir4JH6I=;
 b=KKRgkcx6BkvexT1asLHqLOnK4i3Eq1vSQO8b8HeMx757i9w6xs8etvZdYYRrtPfv5yUAr44pVqPad71nPulDhistpUN6gl7ljJsl3AfJY7eFCZ5Irs6iGCwtna0mEyng1rN/qbe+gvj4od2pfkxTvKq/v4Q/8OTK7dVhz8Cl2yj0/1um27PRSmVgWLOVVa7R7A7LimLRbW2Wf/Dg+NOlKwbaTyyWAdI8hcnSjIm4aCFtnSevPPyOrxIN2NaZiy2LJtISK0cmyVoPp/S95YixZ6VKIif8KJcbUo8GqjcyExu7s2NXWQNZDp/cazdwg87Ec6HGckAhGHwmC8kOP2hKNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ2PR11MB8345.namprd11.prod.outlook.com (2603:10b6:a03:53c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 15:19:48 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 15:19:48 +0000
Message-ID: <c5a1c806-2c4c-47c5-b83a-cb83f93369b4@intel.com>
Date: Mon, 6 Oct 2025 17:19:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xsk: Fix overflow in descriptor validation@@
To: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
CC: Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Song Yoong Siang
	<yoong.siang.song@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20251006085316.470279-1-Ilia.Gavrilov@infotecs.ru>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251006085316.470279-1-Ilia.Gavrilov@infotecs.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0279.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ2PR11MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: b19ddc39-e637-4536-2eab-08de04ebc9b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlZWR3BUaW03WWEzcys0YjlBMmhLSGZNNEdOeFk1dkYxL0FPdHVmamVUQWRJ?=
 =?utf-8?B?MVZPc0FweDdLWUYvV0ppaEplSzVhcTdMMDYxa3BYajNQZVlUdEhyK0UxdVRy?=
 =?utf-8?B?M0JRb0tONVhDdDFvVWpzcmVQZkpTaFZnbFhlTDR2cWw1OTR0OEk3RGZIb2sr?=
 =?utf-8?B?VHdMclFQVzN0QjhLbnJHbFExZ3Zta2l2MHJySTh3MXRsVENtc2RhNE1DdXlY?=
 =?utf-8?B?QS8xZ3FtRFZsck5XMU9yU1FacG9aaDRyTHlIUTRER0hldDJZQ25FcDVleXFo?=
 =?utf-8?B?N3R1YjZlVDhycmhCYWJIZkEvUDhYN0g2cFhjV2tPYTNsT2lTUm1OYjJ4eDRZ?=
 =?utf-8?B?RnFkV3NBWG5YWVNtS1lWVDhacFlOYVAveVRkYU80c3JybDNrNGhwb2tEaFNk?=
 =?utf-8?B?a21xL3FFV3diR0FBeFQzQVNhd2hOa1RXcnE2NUFBemhKRFVCOXBDNlpnWndT?=
 =?utf-8?B?enI4YWpjOGxUK2sxekpDUmRlZ0Z3M2hIVWhJRnIwdm5rYm9GMmIwUTR1eUJp?=
 =?utf-8?B?RHZkOXljREZqTy9Iek12SVAxcStmYzd4KytHZDJ0cUxUZXJVTlZPcnNUZjlV?=
 =?utf-8?B?WkRxMkV1KzFDQXdmZFNwMGxVblpmWWpQd2tNZVAreThQZzZPblZsaVRPTmxX?=
 =?utf-8?B?c1EzVTR1SHFIYWc2ZkNlY1FNQlVJZFQ4em54Q0QvZ3VsbjN4SDRtSWxzaVlS?=
 =?utf-8?B?U1RheUJjOGJNbjJlRUxMOHBsZEZtNTRBVXU1cWFKZlNYckx2Z3VPREdXalJ0?=
 =?utf-8?B?K0pVMGRVNUhDMklNOXBwWDhSV01qTVBvdk5CV3pjTkoxbUM4VzJ3YUhEVzZQ?=
 =?utf-8?B?UEVpdWpEcEVqdkRBaEdac2Fxb3FSREtaelNxeU03aHJxVFUyemozaXBjVEUw?=
 =?utf-8?B?TVVTVjdQdjl5TmFDVWdmY2lKbVFrREwwVUlIdEhuT014Z1Q3d0c0OGRERW8r?=
 =?utf-8?B?SGV0RVhzTm9JZVJVSjZ5aFhMendxRUFpbTBpVEJMS0VjRk5DZTZPeFVQTm93?=
 =?utf-8?B?bmxUTmZzNEV2T29BSFBvWmdEdkI2WU9FODdnZkp3RWtGNVVjc0ZtajdhNmcw?=
 =?utf-8?B?YzBtWjhkWFNkK09zbTNqWWtTem9iSVFNVHVad3VuYjhRVGlhUHhkRXEzbEQy?=
 =?utf-8?B?UDlkWVFodzN3S3ZGQzVERFBNb20vWTR5S3F6b3pmUVRZR1FLTnBYUWtwcGRR?=
 =?utf-8?B?WmUzVzBEV1ErSFhlQlJDUVNHb0I4STZETE1ZV0twRGVVOFV0a3dSbWo1WldJ?=
 =?utf-8?B?R0NIbHFOL29xYWI4eU5iQ09UYytOd3VialNkVkd2SU9TOWlFWkNXb1NKSmJu?=
 =?utf-8?B?MXh1VU10Yzc3QjMrZ2dSK1MzbzhKMTQvNktHRU1KTnRGWHFsajFRdDVGV2xy?=
 =?utf-8?B?SytoMlJxTHh3L1VRekRBRzNZM0FrVXBQM0tGSUJoMVduZ1pBdzVPemJyWEp3?=
 =?utf-8?B?ZVVHNFlUU2dDNDN2WkxNMldPNXhWclBxUWVqMFJNVnprWGExdzhSalJ1Q3Zp?=
 =?utf-8?B?cEFMMldoRkhTWi9EbjBWbWcrQ3ZPWmNldnNvY0ZqQXVQU1JnNUhKK3UyL2tl?=
 =?utf-8?B?eG5wckExN1RxbFBBQmlFSnRyNkdGUHhFWlNCVjRneWEzRUtRRTltL1BTK0Yz?=
 =?utf-8?B?SXBqdDgwQlRmQWJHeTdkY25UQW9STkp3U09Pa0Q4c2R0ZlVVbDArdWtpSWJ4?=
 =?utf-8?B?dGppc3QrV2ZGOHMzZENXVnI0bWNQWHdBK3A3cVBwLzhxZkJVWjhZcnRFc2E1?=
 =?utf-8?B?UHZzTlg3SVU2Ymw4T2ppZ2YvKzVzd01SYUpSRmxhMDRsUzYvNUV1cDFiMlNz?=
 =?utf-8?B?dlVBc3FqTUdEZkhKRmdZV0VqR0RWV2tsZ1ZvNFhFUzlSN2w3dENxd21nejBF?=
 =?utf-8?B?WDcwUFlUSWZVS0xHVktIeFNsUGx5OXBTNFFnTEdoc0RKejRtczR4ZThxVVgw?=
 =?utf-8?Q?BrC33yfpHwoV7+zrazSLDFxMhKgjecvH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVZwcngvMnBQU3pvOUxoNVdNem9KVFFUbE9hT3hqZTRYNmEvQkxqd1VzM2o3?=
 =?utf-8?B?TW9hVGxwRzdtc0xTbTdaZ3llZHViT2xGQkJnekEzQU1RTjFNRkFjd2w1cmlw?=
 =?utf-8?B?OWJXUHBzbWFiUzZMc0J1ekFOb0VoeUNlQ0VFTFhZTUwrTXRKOEtmQzZONVMy?=
 =?utf-8?B?a25wTURCNmhGTlc3VSt5S1BUc1BQc3E3MllIY21vY2dyNnRoMmk5VHlEZzNo?=
 =?utf-8?B?ejFDcXFNWVBsV1ZHdlM4aXdxQkRza05wRlJ1OWJwek9hbEpNcm1qeGNEL1Zr?=
 =?utf-8?B?enVpenJDMzJBakFJV2NGNVI5THMreFNQS2hsQkNIdmRiOTB0d3lNQWxnQzlI?=
 =?utf-8?B?SEV2cGhaQnVwU2RpS1NpOUZvUUlZNlZ1NlhlNTRUWG5Ya0pSVjB1bXR1UW0y?=
 =?utf-8?B?bWE0SVRvRFlOd2hpWjJJNHBaWEVJMzI0VlB6S3NJaFYvQTJ1SWJTS2FscDlK?=
 =?utf-8?B?RmQ1SnE3RHZxQ1ZEdXRYTXlJclpqblREYkZjOGZROGZVczM4My84YW5uRmRt?=
 =?utf-8?B?TWkvdm00VkMvWk1qdGcvRk84Qkc4ZlBqYmhNUWJZQU5nMzlyL1EyR0xEMUZ3?=
 =?utf-8?B?c0J1RG1mT2w4aHRDeHA5TTc1amNCa1I3c3hZM1gzQkhva3Uvb2xjUFJvVjcy?=
 =?utf-8?B?emZKVWZXSkNBajlqRXA3THN0NUxoMjNveHBnc2hRclM1R200b0dLcVVxalY0?=
 =?utf-8?B?b3NKci80MW5hbGJYeE5IdFNxZStNWkpXK2NIL0xuN2VYcTNhdXFwSERIVHJa?=
 =?utf-8?B?RVp5bGYvYU02QlRzdzR5MDdSREJ2NHhpWFB2QjN5NUlLWXBkbThtaXkrQWQw?=
 =?utf-8?B?Y0dNZ2EwRTJ2aUpuRmRPQjBPdE1pbDRpQmllSDVIVGRxZm9FUnVBSlRyNGFi?=
 =?utf-8?B?MCtOTUJ3eVpTczNZRzluUUEzN3dWUWo5ZjNnak5UVXRmYS83MnZRdHNLbWI5?=
 =?utf-8?B?eUo3eHpEcGpoS3RJeXI1ZmRPMyswTW1ITFF0eC9BdHZRK1pwUHlTZzE4bFJT?=
 =?utf-8?B?ZFg0YXErZWR5SWhLT2M4SmJGdDBPVnhlcUVDUUUxWXUwMG5sSXcwMkFVRy9N?=
 =?utf-8?B?cDdUWW0vaFVNYWxKczZtK0w3Sm50STV0eHF2L1pMdEduZkhSYUE5Rlc5bUg2?=
 =?utf-8?B?d0JZem5yS3orckJsZWk5OHhKNUx2L3BVdm5rMmFGUWZRYlpodzBQQUVnWUNI?=
 =?utf-8?B?TGNlWWdRNm05NkpjWW8rV2hYQUllNHRHYXBRaTZRa1EzcnJ2R1RucmhVOTc5?=
 =?utf-8?B?NUFNYStUejYralFVS201RzJCa2tNMDBVbG1RemdneU5weGNUL2pxTEl0T3dx?=
 =?utf-8?B?cGdkOEc1bW5Ta1JjOGNvT1dMRzRSYUQ3ckJPaDMvbE01RzFMT1BOZGU2blZJ?=
 =?utf-8?B?Qlk2NjVnK2RDZEFFZm9vMkJPbzFXYWpkeXU4dFdzZFdCektTeGV3WVVBSTY3?=
 =?utf-8?B?WTArak5zZUV3UkJDVHVuT0JuYUlvOC9DdnBxN0dwc3BlSnM3VUFuK0JOb0hO?=
 =?utf-8?B?MmkvQzhOaUZaazY1SzdZOENoVDZqMnNjV2o2bmVxSzNndTJUSVJFZUdlRVlZ?=
 =?utf-8?B?VWVVTU9ON3FVa2UreGtMd1BpYXp1bkQ2bEswVkoxWTdSRGtqQ0FxUUErTlRo?=
 =?utf-8?B?Q3hEajdHQ2xZRDg4a2xJNDBKOURLanBXUmZYQ2F5WnlqczU1dEdjQU1Qb1J2?=
 =?utf-8?B?aURobjBqa0x6K01yVVBPNmRZWnFXT1VUU25lM0lYTlpMaXloVDdSTzlTblZi?=
 =?utf-8?B?Zyt1YVBLOCthL1lJcERHT1k2VE5aQ2FYZ25rTWpzMjI5Vzd1Mlh3dHR5SFBW?=
 =?utf-8?B?Rzdpa09VVHBWTEE3dkJNTEd2OW1VWUZQVjc2RWxMMGdwZERJWWtscjFUejVi?=
 =?utf-8?B?K0xsU3JzQlJZVSsxMXJlbzRaZkxoMGFvUGJCNmxYYVpTVnVmc2RUU2R5Y0F0?=
 =?utf-8?B?bmdGN1g1c3liRnpvLzE5aEFmRWhPK0UydEx3VWRIbWJNSC9QcEFkRExHZXBM?=
 =?utf-8?B?NkxCREIxaTd3eEsrb3AzU1ViU1h1a2FDaXFWQzlDL3RBemIyb2lIS1pHNGhB?=
 =?utf-8?B?SHJqUW5tb0tSeVF3Z2tEMU1EWHl2UlZrbElmcm9KSWxnaWRXOXh2KzlBSFNj?=
 =?utf-8?B?UEMvVVlGOTB1dU8zTTBCRFRYK2RtaW5oc256QnJBNXRiU1VoaXgzRGhURmt0?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b19ddc39-e637-4536-2eab-08de04ebc9b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 15:19:48.5424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fl4sOKtDdU8sgojJioOlaofiYvTZ7qf+mHm2MboD1JvAO5pEMFyl8o5Zrs4Mx+ijyoYf2dtgNyGkuRTFfYRGALXynwrROOAr5YdB1hWu+8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8345
X-OriginatorOrg: intel.com

From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
Date: Mon, 6 Oct 2025 08:53:17 +0000

> The desc->len value can be set up to U32_MAX. If umem tx_metadata_len

In theory. Never in practice.

> option is also set, then the value of the expression
> 'desc->len + pool->tx_metadata_len' can overflow and validation
> of the incorrect descriptor will be successfully passed.
> This can lead to a subsequent chain of arithmetic overflows
> in the xsk_build_skb() function and incorrect sk_buff allocation.
> 
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.

I think the general rule for sending fixes is that a fix must fix a real
bug which can be reproduced in real life scenarios.
Static Analysis Tools have no idea that nobody sends 4 Gb sized network
packets.

> 
> Fixes: 341ac980eab9 ("xsk: Support tx_metadata_len")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
> ---
>  net/xdp/xsk_queue.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
Thanks,
Olek

