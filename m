Return-Path: <bpf+bounces-42902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D489ACDCA
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442031F22627
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 15:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B5C1CEAB2;
	Wed, 23 Oct 2024 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xy9LtHBH"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126981C6F6C;
	Wed, 23 Oct 2024 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695072; cv=fail; b=Prn4lddvpEqOlDsLNXI5/2uoL91YitrbkCQ9RnHc83ONQw0tfvKHReMrJBxH61Enn5qcsHnsLlJN4/eR5l4GrKhOedFSZpS+t+3FSoB0Qi0xhr52dwJ089seXrDpTDG4DEOGWhl4L+v8nvHw62RutvqlkmRzVPzOneyZnmOjKJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695072; c=relaxed/simple;
	bh=0TiYKa4oos52BMtisS2c2UacoZ2OweRYp60fhirCpVw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Eewp/SMhtqu/FhTaSHZkOJiw8y4MZVeX3T8ntU0SP+kjsXnSJ5zMMIDyRqwUzrIuwm0X086CIyreX+vvAXAU++GIqq5j65R0pZ2WY04fFPNMsOCWYAL4tUoZpX5SQcdyR8MfS3S+WNjRWh3GPSufySD79NvHBNp1K9EVx+J5JPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xy9LtHBH; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729695071; x=1761231071;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0TiYKa4oos52BMtisS2c2UacoZ2OweRYp60fhirCpVw=;
  b=Xy9LtHBH9UdLG/B1GabjMPvJePW30xOMjBtcOEED4Cz1gaPZzKnoX1Na
   dR2G3UKmOdLisJvP1n1ZVRnBWM+7tBKnWgTjE5zRm+znEuXR08ID4TEZs
   H73bUDYr+XlLKywK2lHow32AMbMGO3fEplTloL2jOt2cKfWva1huBwkHJ
   f1HGn+GAlWJmMFXkK0a8nrpVcNhxnKtYvSpkIoz1ZxYTnUZVf3tRN7V9P
   GxrTSECaT1DaXNWAB4GnSw5SiK3Pps1IqE6HNAAef+OuWlDzy+nR8XcUH
   /GNHcts+d9SWHHdK985aeLHcm6jhFjJ4P1TOmbELxcwaQrifToAF0iusv
   Q==;
X-CSE-ConnectionGUID: MkKR6n1XRZ6x24xlPIv4Jw==
X-CSE-MsgGUID: PqGpywbFTNqyfEa8g2TcGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="39901452"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="39901452"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 07:51:10 -0700
X-CSE-ConnectionGUID: ghS+bwf5T4WHv+aaKIsiiw==
X-CSE-MsgGUID: 0ZGCPA+vSqC1TrQPg0LuCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="85022654"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 07:51:10 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 07:51:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 07:51:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 07:51:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNLjk1nGNwl4cWrT1ht1jrKwyvMVu9VA0Kr4h5wnj5KZAKezjmpg1uCIdNPhBNJhWwy9L9Y3YeRc1dDylLXvj2VEwNUHeDMXxRhJ2NHZtphhSUYQfxUqE+eMWTX3xqe1Jsbvya7TkwddatGWo1ZuvtDYkjT3NakE+yYo9dPNp5ySoV5xsEdXozkDIp/HgdtmZBn4MQpOqeiQL6bOa15cMFAg1ShWN5+bpmYdhYwYuP7UIHnQfVCrZHAoY3hLVdyfF2lL3uc4Wqsv9rZTg0igc8dUvwsC1vZGqiZECCJ/UJKSVN00ycjq3Ws6sM1HLSoygMovnztz2u5pLEXxphdFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2ekb5WS0K8iHJP4ksrwQ9AZDVR78RnrCVP7aAy7u4o=;
 b=TI7UkutQAA4x2tJ6cIUWDYHbwFryt09BuFOn/45I7vEMvsj8aSZachrZcGTmXC5T/UeL7bIJuv/cOobYJUwVVZSWKeq3mhSe/DF98Wlsn1jSgb6APBiCAtlAmDx1BsNUXaNjUdVHn0H4WjbGgUjGeUo0te3WmjI2CWAT52bSX1FUygIl7lQe4F/+NBaXddmtMFLj7PpMNu4hudOxSYbXg1arcQlfkwQoGP98ja1489LYdgFTXkZxTMIgUJgpt+RZSoYtm0h4Vij4L6cY3CmIg2KniyFsEBO1M6mNZmTl6PA/6zwhaTmYWFl1rcIrFo4XONsy9DEHqYeW5xPee4AYCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB7019.namprd11.prod.outlook.com (2603:10b6:806:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 14:51:01 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 14:51:01 +0000
Message-ID: <e24250e5-3525-4fdf-8ac4-2fb8e33bca9e@intel.com>
Date: Wed, 23 Oct 2024 16:50:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 16/18] xsk: add helper to get &xdp_desc's DMA
 and meta pointer in one go
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
 <20241015145350.4077765-17-aleksander.lobakin@intel.com>
 <ZxfH1VmjcVdLeKUo@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ZxfH1VmjcVdLeKUo@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0227.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::22) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: b608c392-8df4-4a74-1bca-08dcf3721c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFRWSlFSV1JYeHJhMmVSY2RVK0NWL3MzbWZpUHAzckZpWlJWRUQ5a1hKc3ox?=
 =?utf-8?B?NDdnaWN2VkVodTN4Rk9tRGlLdFNMQ2x4WVpSd1BzeUpyQ1prajNSYThwbnE5?=
 =?utf-8?B?aU1wMDQvMjlma3B4MmRES2QxKzRPdnRUSzkvRTZyb3Vid3dYN1dORStYak1I?=
 =?utf-8?B?NzBIRXk3WVFqSzE3UVU1OHE5bGM4Qmo3TlVpSkdwWnFjRlNiMlUwSndJQjhT?=
 =?utf-8?B?dHVCd2UyMFFDVUJ4LzFocytkem5Sc0RaTWdEZWJpM3Y0NUIvWXl2UTNhSnlJ?=
 =?utf-8?B?aXpvTkg2OGF3TlN0Vys5RXJHYmVVUFI0OEpXWnR5VWFtWXZxL1Y1cmRjUlNB?=
 =?utf-8?B?eTZEWnZPZWxrQVBTSXE5NnRjbDlMbzN0bUVWbkdwTnRHWC9leU5rWnpkR2sx?=
 =?utf-8?B?K2Z2SXU2Vk1NeGw1TGVRdXB4cDM1NzdhOWE5K3ZJL2lreVhRWGZvYTkrRlFv?=
 =?utf-8?B?SVZ1cEh2MFl4YmMvYzhCTmNDUnlBR3JTZ0t2L2NxR3VLUXcwV2s5aEZTSVQv?=
 =?utf-8?B?cTkzOEU4eGp1YlRNR21aWHBYbGhUWm9lN2Q4cUtjbEZBcTF4dHE0eUtoUG8x?=
 =?utf-8?B?L3pJMjFxWG13SmZGRTVNK3UxWGpyUitDVzhIUDF2eFNYc0FXY082U2ZCdzQ3?=
 =?utf-8?B?MW94L0Z6MFdaeHh4UE1Mek1HZkdQVWlOVGV3by95Mklub0F0alRHdE9KMzlY?=
 =?utf-8?B?QStJdVBOTDRVSTh5VUN4dnc2SThUSXVWZnROdFB2R1N2WTZ5aDF5dnBqckZ0?=
 =?utf-8?B?akxVYnZGdU9MMTJOOUR4QnNLZXBqTTMzbXkvREN5eHJYZ3FwSmxFL3ZXVSto?=
 =?utf-8?B?ZENHN1hETjI2ZFdYa1RGWjU1RDJaMFA1YjUvWEtiVDlMY0QvVm5vbFl0czla?=
 =?utf-8?B?UEJmWUxVOFRISGIzMFh5VFM3ZXZ0eExpVVdwbWRrVnVOd1VxNkJCeitITWFt?=
 =?utf-8?B?S1FCdWp0UGVySzBrSG4ycXQvc1hkUksvbG9BdnZzLzBFVjJ2RmZBLzFsYWNv?=
 =?utf-8?B?T1B2eERiYi8ydVl0RGlRU3ZQYTluZllvcFJzcFhyZDArdzVYYkh6cUZqL1Jv?=
 =?utf-8?B?anZWcWt6ZnFJZm9QK0tJMDBsNHFCYXBHWC8weUlUaEtKL1lURDVnd1JDZDdj?=
 =?utf-8?B?YWNQcUo4Mm5pSk9aNzJyS3c2SEIvYTF1N21QQzBlbWFVelo5YXpWTG9yOFFR?=
 =?utf-8?B?VUg3bm1hRG5KVmFDL1loNXlaMnRlTytDSzI4dGplYzZ1UjNUalZDQk40RWRY?=
 =?utf-8?B?eFhiLzZqcitWZWo4d3lkWHc3UmlINGJISTFGRkZXN2JabUp2aTFPMTArMFJV?=
 =?utf-8?B?bHI4Uk9YN3FsKzhmZFdZOGtXRWtLUTdnbndSVjlYV3F0ZHJzeW14OXNDVHJq?=
 =?utf-8?B?dmdvS0N3VkV3T3hkZm1RaElnNEJrOU9peTZiSlltNTFnaXNUYWlGVE5UZlpG?=
 =?utf-8?B?TWpuZHpJREh1UDRiWUZNRWtvK0pXR1FMVVNDMkVmSDh4d1RXUFJKbFVIZ09a?=
 =?utf-8?B?Qm1RbGZqSERMdFFqb2hQZlZsZXJPYWZnbmJ0T1BLa1JzMTVwNWNLZEhCTjVY?=
 =?utf-8?B?MUYrUlVib01zb29FSVBvNWU2Y1ZCaUpDMzhnNzN0WmFwTzUzUGxaT1htNmlq?=
 =?utf-8?B?cU41OVVVeEdwcmc0ZWRQR3JKWlZ4ZStiOXdQVm5WSnBJOUszZWZRZnhjS3Vj?=
 =?utf-8?B?cE9oVnREaHdwczVCaXU1SEtiVkxsR0dqTEIrcDBkSkVZbW5IYlJoZ1A5U2FL?=
 =?utf-8?Q?hIhQ6zcf4oiXUE5yD8zxuSrN82DtvS3qrq66o8N?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWZYdGxnczcxOXhLSVI1UjhSdXNYQmczTVloc1NKZ1JMcDhXU09KckZwZWgy?=
 =?utf-8?B?eklSY0NoL0pxM0JzVVNVbGpkTHQrQ25FTThIcEpEZzU4Y1lNOWVXK3lEQlg5?=
 =?utf-8?B?TTVwNlVhOUgzdElwRm1VL2Y4Sko0UDNkaXRtVWoyQ0R1eFRKMmZBMlRaNUE1?=
 =?utf-8?B?QkYvK2tPQzU1SHlGTUszWDA5cVZ0TVBqcVZhTDg4UWNJcGpPeE1QRW5WemZt?=
 =?utf-8?B?eWtIeWZPU1UrZXh0UmFDaVN1eXdtbGlrODBsa3JmVm0yeEpBTkpPU1JwdVMv?=
 =?utf-8?B?VlhZcVRwV1lqU1hZYWQzdS9QKytwT3RGY0FoS2poa2JVdFBYUjRjeFFleFg3?=
 =?utf-8?B?dGRLVDVIZ0pmdi92V1grUUlmSUdGbm9kSjRsWTMzbmk2WUVHMWNhUVMrTklp?=
 =?utf-8?B?N2FEaEJUZVVDcUhYQWdZaWU3cUQyTkNCSnlJekk3NFgvMk16cjExZ01qZ0x3?=
 =?utf-8?B?cmttWUNtZGx0VitISlFaWVM4YjVZUTkvUG5KY2NjVHNKcVpOUDcrQXJvWGYw?=
 =?utf-8?B?VjQwZXB0UTZ4VmpPSDJzZkxVVjFCTEVsWVAwbnZ6UnVhUFZRUXZSUkRGeU0v?=
 =?utf-8?B?ZGxwU0MvQmFYUWNYVE44ejEyM3gvK0h4aWNLS2I5Z2k4UERDQmEyU0FqY2dK?=
 =?utf-8?B?VklUWmtlVkZST3lDbzJ4MUJrOXl6b2M5YmhlUWxGclpLRFVCQ1Q4cS8xYzVK?=
 =?utf-8?B?YWpBUDZMNzR2cS9PNWQxcEt4d0lEUzBDdmhuVjdjUDdLQ3l2TnEzNEVpTVlT?=
 =?utf-8?B?T2kzNWJFK0k2TVduRnBXRVpPSUl1cElTeEVTb2FRVjN6dEhOSUkxNzBvblRJ?=
 =?utf-8?B?QVdxdURFeUxXZWNyaXY3ZktrTkNKSE9LTjVPdWpTSXhMcjd6YkZuQTFmcDRh?=
 =?utf-8?B?d1g1cm14KzR1RUNFUkE3eFQ5NTlpUTN1N1cxbDk5Y3lxdGcxOVkvTlFQTnky?=
 =?utf-8?B?Y3lWY1JEVTE1NzJqVGkwQXg3aG5QSERjRG9vUEZiWmdlb1BKN2ZNQlplVjdQ?=
 =?utf-8?B?a1dlbjFzdnczTXZvWU5McldObWRlc3N1WkVleHhEYkNPMzlXamJBR0o1Z0w1?=
 =?utf-8?B?cENpTGJZb093TGhlMWs5SFA4N0J6RzhoeEpoSVBxNDlqMnBFYmJvSlhIQ1ha?=
 =?utf-8?B?L2pjcm9LZUFrekd1R0xGWWZTVFQ1SzJzS213d282L1cyV29ZMzZ2QkN1SEQ2?=
 =?utf-8?B?UlJUMzZMUTllcTJRc3N6RUFGQ0tVTm9GSXRDQWtTN29GSUNBcFR6VG9qUWZL?=
 =?utf-8?B?d3RTUDdkaUpIV24rV1N2ZVhjYjhualRPa21kSXhyOGlCeDhRRWx1WmpReStN?=
 =?utf-8?B?dmRod1B1TjI4MzdRVG1GSytNTm1qbDk1cTdSZ3NLeVdHNTV0QTQ1K2haSTN3?=
 =?utf-8?B?L3NoZWRIQU9xTi94ZjBpL3FwbEl2VnVQOUJmdEhsUDVzUENXUUxBT3hQWDVI?=
 =?utf-8?B?d1RxdW1OLy82QXNIR3k5R1lCRkVha3REOEhnZGJwVEpWQTZ0WEFUc293Tnd2?=
 =?utf-8?B?VE5vbXNNL0ovWjR3bGFnQWhMYjYxMGdCelNocnN2L3dvcEVKbTRmZzlOUi9Q?=
 =?utf-8?B?SHRqTitnWFVvUnI3ZU1mWDBRMnY0MzFRTmhQZFNSemVQTnEweEI5MWNaa3hR?=
 =?utf-8?B?aWIzNmdLY1IxUlU0U3BHck4wOVArbFNGb0MxcnBTTW1JOHplbGRick1LWUE0?=
 =?utf-8?B?RVVrMTJJSGlGdUpiNjlIOUF5NVlGeVZqZEVZempkVWZ5SlVHUmdNUWh6aElM?=
 =?utf-8?B?QUlESGtSME1jL09FNjN6TGdUNVJNUTFwU0RpVVpLTlpUblJka0JMelhrVTFQ?=
 =?utf-8?B?cTY5RURRQVdHSUtrR0R0YWtRTTNlYlNRQVVOeGJTZ2pHRENFQW5JVUxrR1lI?=
 =?utf-8?B?Qlc1Ni9aMzV1M1hSMkhidVdoeXJSMUNsZ3RaVTdDV3ZwOENWendpRzdzS0hP?=
 =?utf-8?B?akJXdG8zWVo0VG5iRXJUVlhvQlFkWU1aU1A1M2NweCt6eWR3QTBsWlRGUk8x?=
 =?utf-8?B?MmNwYnAySlI2S0RGWVU2Y2gzalFBa1RyZ0h6dmpxbUM1SG9YWkovZVJndlZV?=
 =?utf-8?B?WGUvdjMzUHJRRytDU1lvcU5jcTJDWVNPVy8yb2dPWGNMN25QQVZDVHJPalc3?=
 =?utf-8?B?b3VhTC9EY2gxNkI5TFRoTm1VT1JoR0kyMVNVV3F4RWVBTGZDaFhHWjNVN2Rt?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b608c392-8df4-4a74-1bca-08dcf3721c5f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 14:51:01.0727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tgJr8JvTVokP5sdWjijiV6ZJGSd6zVQwX23jtpOxMNpREiFCPC7hFBCdyf2oh/beQVoTeFUqaz7V80zGmP3XY2KOPWJOFlk7b88nF3Iygs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7019
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Tue, 22 Oct 2024 17:42:13 +0200

> On Tue, Oct 15, 2024 at 04:53:48PM +0200, Alexander Lobakin wrote:
>> Currently, when you send an XSk frame without metadata, you need to do
> 
> you meant *with* metadata?

Eeeeh... Maybe, I forgot already what I wanted to say =\

> 
>> the following:
>>
>> * call external xsk_buff_raw_get_dma();
>> * call inline xsk_buff_get_metadata(), which calls external
>>   xsk_buff_raw_get_data() and then do some inline checks.
>>
>> This effectively means that the following piece:
>>
>> addr = pool->unaligned ? xp_unaligned_add_offset_to_addr(addr) : addr;
>>
>> is done twice per frame, plus you have 2 external calls per frame, plus
>> this:
>>
>> 	meta = pool->addrs + addr - pool->tx_metadata_len;
>> 	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
>>
>> is always inlined, even if there's no meta or it's invalid.
> 
> when there is no meta you bail out early in xsk_buff_get_metadata() as
> tx_metadata_len was not set, no?

Yes, but this code is still inlined.
See below (at the end of the reply).

> 
>>
>> Add xsk_buff_raw_get_ctx() (xp_raw_get_ctx() to be precise) to do that
>> in one go. It returns a small structure with 2 fields: DMA address,
>> filled unconditionally, and metadata pointer, valid only if it's
>> present. The address correction is performed only once and you also
>> have only 1 external call per XSk frame, which does all the calculations
>> and checks outside of your hotpath. You only need to check
>> `if (ctx.meta)` for the metadata presence.
> 
> IMHO adding this might confuse future users which approach should be
> preferred.

It's a regular practice in the kernel that we have several functions to
do +/- the same. It's up to the developer which one to pick, he reads
the code and decides himself.

> 
> Thinking out loud...couldn't we export address correction logic and pass
> the corrected addr to xsk_buff_get_metadata and then add it to
> pool->addrs. But that would require modifying existing callsites +
> addressing xp_raw_get_dma() as well :<

Yes, modifying current API requires touching the users.
+ keeping xsk_buff_get_metadata negates most the main purpose of this
patch, see below.

> 
> Standard question - any perf improvement when micro benchmarking? :P

TBH I didn't test before/after with the meta enabled, but it was enough
for me that using this function instead of the get_dma + get_meta pair
reduces the object code size by 1 Kb when unrolling by 8.

Thanks,
Olek

