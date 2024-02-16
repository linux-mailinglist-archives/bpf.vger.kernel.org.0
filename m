Return-Path: <bpf+bounces-22143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477AE857BE6
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 12:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80041F27356
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 11:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D9D77F23;
	Fri, 16 Feb 2024 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f7UDdoij"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674431E532;
	Fri, 16 Feb 2024 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083708; cv=fail; b=WXegtWBELsIzooBKnAHrX70ktZ01wk3D72Dqz4dQqWIcsseE0gltGJCigGurRJhVaxItTxz4gOk37YPksaUDe//S/eDB28ipCAWZ0Clqv2IXkTv7uBB0ieFIuRQqYGqmh7eecW9sAFQ052Vkr1nrkUXUibyiMP3QR8C1lZXnBbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083708; c=relaxed/simple;
	bh=4VCwNbm9R93YVJpFTA6/ljVdVMq1WLWo9Uqaiz2Ic5g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VU+rDkJPQv2xGmrKVCcsHxwXdbM9qcSZZcy5s2puqJ3wVx+qsStUWsCP9EXSAUusPenwEODPPveX4p+JUsZQvb/b2hGIOW1M/n5ktdE52Cun44XII405W5DV5NcbFP/UxMNooyvLqYT9qBUvDSH3h6mUB1dI+SE0UL/YKP1jE0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f7UDdoij; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708083706; x=1739619706;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4VCwNbm9R93YVJpFTA6/ljVdVMq1WLWo9Uqaiz2Ic5g=;
  b=f7UDdoijk8UMXj2JdOLF/7mDYCYXl1fw7vN0VT8kPrkDPK9jqY/e9zZU
   2yPhdYu+HAkxGJmonlx6Xkspq8+gtdNu+XJjfEj83VgvQG5zpPcm4Ochh
   Pfko1/icnGR0LoK55x1C4YD4u1H8z3xKTpWJtPeo3ZjzlrspdhHCLcyUn
   Tg3Hg6LA7QYC/bKRHWGWeb21L8gJDePk5Jl05go1lBkPQPKkC5V0UaOJo
   B3JfrZdcroJJj60k5uz8uRfaeLo6YUr5nVtkN0ChLga1lgvGhUFGogXCr
   7C1cEtlhMjPsp/4rz4pZJZCZAzCBVunK+nIcL9dcaC1lVVerDcx9FB538
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2613059"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2613059"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:41:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912349920"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="912349920"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 03:41:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 03:41:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 03:41:44 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 03:41:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfNAedPPk0ypO2EXohZ4PZMMnpQEhmkLY5mi6YafTcsf7plcFTkpnDS74mZvL8XYZsjGhkdiqikpcO7kZU1m//QSJQh/Ama60QV1qSaQLaRW8k0GfFqmyqqsa/IqN4SwDAKTb36d2pwbjOwrs/E40j7rUWZNZfkFvZa8V1Iy1CpHPNbsDYsxnkafl+aJ0iLf+KOGbIOod/BV9nVbLmbXA8oQI4mDhhZksxhsYj6iQ9SBej4pX14clC8VFiiXdMR3HM83VSPu82d2Badmm1rt7qrods+vrCbPte979aLl5OmjjaTidTUmqOOPMbpqrpz6TbhiHsnndTL5Hdtei2rAuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBEmG5INpnvj3uZiIeyY8kqh3g+U49SLpPfHbcqhv6c=;
 b=AzXSrSWQNOjnw9pVwEAU4vKi2hy6n0WQHEsCyYAUwx/K0+jMIp+4ub22VSDHbxvKsDeojQtupHo8KLgcR6MT+4dLzAsqeeM+LuW+179jR7clee+IkC1GHeu/7MeIc2MKPkpt9+Fsbfguc8HDJaJ/ZLOsJaPfrGsEZ7zl19J104xT2DBTRKhdFOaEvTm1bTXJlGFVnuYrbRDyvdCcYyl7CjjIKFy3eZzF3IAMWVtYpoe9N6i793jPyi+i0YMeEl7tBSA5XJlmserWLy71StKbiLx4XygoxAhVjT1dZqa1kSFyzCIubcIrz3nzAaxs1MjSrhS9OhAs+AFhggIM84so7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 11:41:41 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6%6]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 11:41:41 +0000
Message-ID: <a33c3cb6-a58c-440a-b296-7e062fa8f967@intel.com>
Date: Fri, 16 Feb 2024 12:41:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] Change BPF_TEST_RUN use the system page pool
 for live XDP frames
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20240215132634.474055-1-toke@redhat.com>
 <4a1ef449-5189-4788-ae51-3d1c4a09d3a2@intel.com> <87mss1d5ct.fsf@toke.dk>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <87mss1d5ct.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MN0PR11MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a69b1d2-d858-43d2-c26a-08dc2ee43e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PJzB8gOVS++UlNUDACHmAd20A5EyrbfmM4wUnz9cSNpUAa0cY/3G1Zf09o8b8luQIeyLNCSsAqtEjfGCKfbOUCR656iyGic2xu8E8fO2Tos3EgH8/0R28sP9wzyMCRnbI4equYmWdNbaYT+NaSlZvGG5vyL0lennJHcuG97icvq9ryl5JbU/v0evskSXXODTwTLPKkqtP+rtOkbkuVcIQZcTGgajhJvt1hWH11dmL/8WsMQYdkHZTYW4ePl446yjQ8uKmwUgLHdhAsJUpfGpJ7HFKy/lfisaoixJxWqCuaaHLQOy8Rr63WFccd/eHM7FCUiBZW3Qf4IJUqK3q+8i/Dot8+qRIsEcAHhJonuqOFJygjjR+c1zuS4fT/ALpSA3TKrARJOdsreuwPItHk+y2ttJuJaGQ7Fn3z2gXu04Z0KiCPmJp+wYqIsa4vdOfVP1rRmfg8bsYqEkfJhmRAL16VCYzG231CxVjUC3hJU87rL+R7cgThk2oxK2uDWkbUOp/EGcHjddFY+M0jjawvfiKb+076vdloBp+8kMO5waGxuMWGan0979Kb1iftFM4FFH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(346002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(31686004)(6486002)(6666004)(6512007)(478600001)(41300700001)(8676002)(66556008)(8936002)(5660300002)(2906002)(4326008)(7416002)(4744005)(6506007)(316002)(54906003)(66476007)(66946007)(6916009)(31696002)(2616005)(86362001)(36756003)(26005)(82960400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDd3UFZUWEo4ekhGN0RiRHJ6SmNnYTkwem5Nem5LQnlBK0J4b2FkTEgxSmxO?=
 =?utf-8?B?UGgzallobVZjbWMxakhuZjMvemx3NE1mVStHTzV4dGdLM01wRXpKZEZySlE1?=
 =?utf-8?B?RW11Qm50Q1VkTzltRmIxMmUyQ2t0OVlCS1piaWE2aDR4b1VEaFB4d3g0S01u?=
 =?utf-8?B?cnZQUVI4ZFpQOWdTekIyckpVMmtISEMzWUtLbVZMdHp3VGZTNFFpbkVvQUZx?=
 =?utf-8?B?MXpGdnBtUGtVVldJWkloZFdMNENSZ0JtdDJPNjk0QTVaNnUxdEMzWFBzME1D?=
 =?utf-8?B?bHE4NGVYRTFIRTlFMzVxVE5QRVpsYXBScG96TFMreXBFOGRZejVmR20wdXBU?=
 =?utf-8?B?Y0kvZGRudU83TjVyOVhzdUZLVCt6Z081dVNKckxuMHpBeE5IalpPVzNaV0Ur?=
 =?utf-8?B?cy9YcEM0ci9VL1RQMzkyamw5QzBpRU1kWVhiamlyN0xpc3d5cityb1lZaTht?=
 =?utf-8?B?SURwTEdTV0R5QWtyTk51RDVzdURDMHpJUEpTNHJiSlJIdkd5T3J0TzBXVzlF?=
 =?utf-8?B?elpmcFdTYXl3NkxsYnNqSEs5V0ttZjZlUjhPMUtBZU1RRlBnS1RYQVdFdmhK?=
 =?utf-8?B?LzVvZXRGR1NkYWx0c1o1K2J2OTFNU1RwWVhEcmQ0TVo1UWtIMHVKMS9yMExY?=
 =?utf-8?B?Mkp1LzFiclhRTFVIYlRqRWRlVE5mQ3BsclN4S0s2dFNid29aYml2Wjd3L2wv?=
 =?utf-8?B?V1ZpM1FZQ2YyU1I2SnBHa3FSVnlSRXpoUGFKYXplMkV1NkZQeEZzeEJDYW1C?=
 =?utf-8?B?UkVEZ2pqajk3UFB6bmIxM1g5eklHQWY2UGJ4V3ZrK3NGeEF2dERNTVdQeXFO?=
 =?utf-8?B?WDZGSHlEdW55YTF6S3RJSGVqNXlYUTdhNHFQb0hCVUpwRkMyWGgvNm9LSzZz?=
 =?utf-8?B?UGNFNG9Yb25CM1VDNjBmNlc3dmlUWHVFT25kOU1Xb1VPNW5QRDBVcUkwM1BO?=
 =?utf-8?B?ZkhsQi9TUTNnSWR4V2l6V1FZTFJCZFlrRElhbE1UbDZQZlhDZUh5YWlkR2Zi?=
 =?utf-8?B?VHE0a1dTeFZraXFZYmVra2xhTzRpVHlRdXRMZDdyY09vVlBxTWZ4R1NwUkJV?=
 =?utf-8?B?djJING1ZSzZFd2tWa2dFQllRRVplRFg3bGEyeFFNeTRuS0lDcm1SaWttYVZP?=
 =?utf-8?B?N2c5R0VqNExuc3IvMk1wRk9BV01YZlBFYkk2VTl6aHZ2ZzlCNjk0amk5QU5O?=
 =?utf-8?B?OXlid2VuYTRTOWs3dUwydU9rMVZueE1QWldKWExQU0pyRzVyU3NmRzB6THQ0?=
 =?utf-8?B?RVcxSFJBS3QvUjJPVDl5Q1FDVzRyL3R5SndzVjlWcE9tY2hFd2JQUk41UTB3?=
 =?utf-8?B?UHVmOWVUYmZ0L3ZkMHJMdkUxS2Y2RTdrVWR0U1lSMFZQT3VESWxDVVJEMUEw?=
 =?utf-8?B?blB2QjdwVmMyVUtLUVdoRjFmUzhCdEhLYXVhTFo1ZHVJeCtVdjhXVzFDcjNC?=
 =?utf-8?B?bUhLZ0M5QkJEb01SVFlieUhVc0VsMWEybWw5MlNnYmVtUkNqNE5ncWNBMFRQ?=
 =?utf-8?B?eDhmU0Z4Z0xHZGNIamxkQUt0d1NFSXFidEFXQTlvUWoxMGtuYmVKN2VScnZ0?=
 =?utf-8?B?M0xRYk40Q0tYOFJGaUo1MW5oejdUL3RrMWFPcGY3YnJzVGNMcFlBNlVJNk1y?=
 =?utf-8?B?anl2UjlKMFBUamdPQmpacVVVM1RzRGZtdEwxVkdBQ1JweG43cjdWZHBENXBJ?=
 =?utf-8?B?RytTMHY5Tjl6VXQrbXlmK0p5RUR5OU4xM2VZTngxM1dYelJjbUJLcEoxemdj?=
 =?utf-8?B?Y0dBeFlmYmpObHA4ZC9SSXJQMklqd3lNMmpiazhWLy83UFNvU0VLbFMvMGRN?=
 =?utf-8?B?ZW1wVCtSQnBOSlp6aGQySWkrOWFGWFFuUFV4TkIrNU0yLzBqdThPc0NBMGZ4?=
 =?utf-8?B?L3JDMTV1QmFqZ3BYOVYwVGttRms1NW4vTlZLWXFyaHEyWDhQNmdKZmxiNUd6?=
 =?utf-8?B?MGhxSjFIWlpaSFRlTjZXcTRKcUxLTVkyRzQzYWhZREpiU3FuTjBuRXVwWTJV?=
 =?utf-8?B?TXFOWHVBT2NjZ1F4bHNzSVNnYkdkNnJFUVBsVFVrVHBTVldSZmpHbmc5VVd1?=
 =?utf-8?B?d3Z3ZHkycnV6ekQ3a3FpdXNkWTN2TkltU0RqQ0NKQTF5V002SzF0Z01NQzVt?=
 =?utf-8?B?Ym16WmtlUGdjUElVbVJCbzZzSUhFdEdCVUE0b2FSdWtkaktaMHRXZjhDWjY5?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a69b1d2-d858-43d2-c26a-08dc2ee43e81
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 11:41:41.8183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEKWjM1wQFcWh6g+HDe0eJfPuTEA2XhlKkU/v795BDx6ZIU6qByRYyrqhPZ9QdX8gkX01LSReanClL3hgMxikX1c5sM8rHnpZXmtcmUx43A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6206
X-OriginatorOrg: intel.com

From: Toke Høiland-Jørgensen <toke@redhat.com>
Date: Thu, 15 Feb 2024 18:06:42 +0100

> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
> 
>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>> Date: Thu, 15 Feb 2024 14:26:29 +0100
>>
>>> Now that we have a system-wide page pool, we can use that for the live
>>> frame mode of BPF_TEST_RUN (used by the XDP traffic generator), and
>>> avoid the cost of creating a separate page pool instance for each
>>> syscall invocation. See the individual patches for more details.
>>
>> Tested xdp-trafficgen on my development tree[0], no regressions from the
>> net-next with my patch which increases live frames PP size.
>>
>> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Great, thanks for taking it for a spin! :)

BTW, you remove the usage of page_pool->slow.init_callback, maybe we
could remove it completely?

> 
> -Toke

Thanks,
Olek

