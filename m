Return-Path: <bpf+bounces-11205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E287B545B
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 15:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3CDC4282893
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 13:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C248199DD;
	Mon,  2 Oct 2023 13:53:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AE718E19;
	Mon,  2 Oct 2023 13:53:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36F7B0;
	Mon,  2 Oct 2023 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696254827; x=1727790827;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NQmGP6/3JEqMk2jwaz2lMPVo/R/x0fQEOxSfErvG4xs=;
  b=e4+Ao3Yf5MPxK58T47wxJuPcklf4QMVu9cuEwnMY37bcZRU0RRonDG7O
   adEPSWDO+gMjaKA4f8itdNnKrj52IPTG8TyQWbCKZdsBjvoPeTFaO4ARK
   yE4/piNixTgEvCOZHb5km3bF27ldDEKJyHPxoV6rc2RqQXu5RCpFXEIoC
   n4LZlr/sFaRH1aNil0zLuJxIU5xa4L1jHaaF0h3XaB7T+6cwaWXIozqe2
   kDBmTNh+1msB9+dv2NCzQjNVIS59ujyavGspi2mKz0glIsu4P8CiciayS
   ryX/HACmeLzlTRQXPzjxfKYvQCCS0Azq8/vBS7DOBFeq9x0S/9NTlgbSJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="372995177"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="372995177"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:53:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="924280571"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="924280571"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 06:53:46 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 06:53:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 06:53:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 06:53:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 06:53:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zmp5iwBBWx4HYGA1tk/uxKEsNgbaTFH3SEQR5ngBSMrm46J4Wh14zGOmd7Dnpk3xXmcExr26tz3NHs9QWYQQNfuNxTkyTDb5VleIUxhIiN+g/pB6TLaOE1uIvM3Svmrq33tNKGAHL8/63N5xecl5DG9uGY01YME9vlNUdPG98U01P7HLMMQcgKea6SIExBr0ep98TVpRZcPxSyWNldN6plqenwc2gnX2OjrhqhSNX13KIUfpTwagr7TyZZ0uPj6tTuKGx020PGjyiur8QaMaOsl9E5o5bDrLTUKHjv5HTLNupltT3TgiQwmnUWpnrrE4s8ezVwu+YqW+K0ygmQgflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5yBm8h7QQOfF9IBFieKu8K8Ub7iZWVdDf04239Kutk=;
 b=UKuCLOaDttC4Cocz2pV65hibLjA3G+Bqv/tEtkr2Moxw/9Fa6LRNg3vpDkRtrHeBamWIBP+JPH/EehH6eKbh9cJAgSO6iR240cIJExRpUB0W01Gq5rZnOtZESK8YpqjakQ98SP64w8nNITRlfiNh1WY/VThZ5+DkRvlvRRtMIGFdYcAKK/eoJ/NjSz3k6H+f/3ssey3j8GxZKRoOiYQmzTg5sRrZZQEyaCrKjNJ9Mv7jy27JCp7i5dQI6MKdblh9D/E62/EOCRTq6eMqHBgBixDc/TwkkT4kmwaVg8BwxucS096qQDL0U5ky1G73kYd4GC75M5hDp4Pr2JWeoZ7XYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA1PR11MB6371.namprd11.prod.outlook.com (2603:10b6:208:3ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 13:53:43 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Mon, 2 Oct 2023
 13:53:42 +0000
Message-ID: <2165e4a3-a717-f715-f7c3-e520d45ec21c@intel.com>
Date: Mon, 2 Oct 2023 15:52:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v1] net/xdp: fix zero-size allocation warning in
 xskq_create()
To: Andrew Kanner <andrew.kanner@gmail.com>
CC: <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <jonathan.lemon@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<linux-kernel-mentees@lists.linuxfoundation.org>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com>
References: <000000000000c84b4705fb31741e@google.com>
 <20230928204440.543-1-andrew.kanner@gmail.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230928204440.543-1-andrew.kanner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0274.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:84::19) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA1PR11MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4b8e19-3bef-4d45-8657-08dbc34efd3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MW5YbGZOVHZxODFZcTF2andnR2EyKzBCQWRtKzZ0dnpTcFh6eFB4dFFxSnh6?=
 =?utf-8?B?RzdNUllSbWx3NDF2b2lWcDZ4N08zeTdHUnA3OHZZakhjRUdQK1JxZWFFOEpL?=
 =?utf-8?B?Z3g1K0M2SjlKZUJHdlNta0tpVkxaTUhIMkNUUmtURmEyZ3JBMjVqMkd0WEE1?=
 =?utf-8?B?WjVsTGVjUTZVZW5vbC9tWVhhRDlGVVpFem5zVEw4OTltbkJFQTJkdjN3c2N6?=
 =?utf-8?B?dmsrVFp1enZ2WWp4QUZRbE9KcGpYNFQzcDVoMk5pUmxqY3N4YVFFZEF1TTkx?=
 =?utf-8?B?NENlZGt1UFZ2amFha1dRUXFNYSt0U296M2FxUU1EVWxnREFLZkJOZ1hDZEZJ?=
 =?utf-8?B?OEQvSkNGOUdYN0RXMVBNZ0tMOVYyZ1VmQS9xRndLNi84dEkxNFp3bEJaK2lk?=
 =?utf-8?B?UGF4RzdvRDFOQkJIcy9xeU5peVo2MnU0M1ljUERvSzlObXdqL3hqcTdPK0Vk?=
 =?utf-8?B?U3dWbFo5aEpydDVJR0hmRnR5RXR6ZGxhZE9SOWFGaS9WSmJPc0liY09WZ3Nu?=
 =?utf-8?B?ZkFOdkxhYXBhb0VWMVJTdGpiNlNxNCswdHhsU3hWb2JTYkZTbTZhWVRIbUJP?=
 =?utf-8?B?TlpLMGx6clEvR2srWG5QbHNMS3hBUDhtWTgrS3dlU1RwQ3M3RGhVZnhBQzBE?=
 =?utf-8?B?NTVzUW40U2RKelh1UW1yK2JTdWk1SWxUb3FSbXl4cUtvMnBpMlNJenZHQTFx?=
 =?utf-8?B?RDRMdGFnNzJTcGFrMmxXNTQ3b09DN1RZTGtiaVNTazZWMXFLbjFGVmIwOEEv?=
 =?utf-8?B?UDVRY0FNR1ZDRUF4eXZJczlPUExXcitzMzJTOGhNei9NMGJYbVI1dHZjSm1H?=
 =?utf-8?B?UHdaeGlIUTFDa3hMcUdTL1VCc1VZbDZJTGNncHhJck5zYmY0M2JJVHMxUnlO?=
 =?utf-8?B?TGtRc0Z2ZktaYk5PNnZDQXhGMEIrVjFyY05aYW1iZmtqaFpVZm8xWm5CZWlh?=
 =?utf-8?B?VmI3NlhML0NrMlhrZVBrR2R3NEtsdFNENzNHY1IxOGQrQlByN0F3TG5pN3Yx?=
 =?utf-8?B?Nnh4SERGNFFNeXlhcUcyWjVaeGthVWNNMHFXMFRnUlFMOFJLeDI2RmVLaWl6?=
 =?utf-8?B?VjNMK3c4WE1YSW4rcnMvdTVkZWc3R3A3QW01Q1Zad09GQXAzM0hHUkpLZSt5?=
 =?utf-8?B?WHFBK3p1RjdUOEtJdUxqOVFMdVFwVFlSaDA1dlZkMHhTbk5iWkUyL3pOSVJP?=
 =?utf-8?B?S25oWVBVY0F5NzdSZ2o5YlRiOGF2d29Wd050cUg5R2tsRU0xWmw4Q041T0xM?=
 =?utf-8?B?SHVoTjFtY0d0VXVHQU5ndmphSHZXTWhZY0VWdURpRzQyVW56QjF6N0c0M0Y1?=
 =?utf-8?Q?O6wQya0NSFfdM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(366004)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(36756003)(4744005)(2906002)(7416002)(26005)(966005)(478600001)(8676002)(4326008)(8936002)(6512007)(6486002)(6506007)(2616005)(41300700001)(6916009)(316002)(31686004)(66476007)(66556008)(66946007)(5660300002)(38100700002)(31696002)(86362001)(82960400001)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVVUeXBIY3hrbS9tL3pKdVE1WFl2cCtsc0hNcFVFTzJmZ2ZYQzVLZXR5YThr?=
 =?utf-8?B?MmhQaHlsaHR0bGQrS21iSjQwQTcyRDEzSW8yTnM4L1UrWnEwaG4wS1A1eWhZ?=
 =?utf-8?B?WmpIOENNR0V6UldSL21lQ2ZwckxKL1ZERHY3bDJFcUNWbkNjL2d6RWhyVERi?=
 =?utf-8?B?SEVYbUxjRjRNem1EQ2I4SEhUd0paYU9HM2FhUGZ0Zm0relphbzB4enNxSnY5?=
 =?utf-8?B?YU0xdXRyZFNZcDlGTW8xL1JPMFI0S08rSDRUWGZmb2JIbnRrc2FTVVJaWi9L?=
 =?utf-8?B?cHRnWUZuVWcrMDA5cUdRbnVBdFViVDh1UHdtZzRESFZQWnE5NmNqQzA3R2xW?=
 =?utf-8?B?dktzdHY5SlgreHBIN1pxK2swZXVoSFlxZFBDU0xmWkZOWk1qV0x5M1ZOZDJi?=
 =?utf-8?B?TzZwYXU5U3pkOXFnUkVIWERqZTlHck1aZjMrV2tuSWNsUDVQWVdrSy9JRzgz?=
 =?utf-8?B?aURzQkdMZkFHMjUyU3ZjWndqQVFhS09OL01YVTAvQVh5RDhOZ0dXU1h3dUp2?=
 =?utf-8?B?OUZ0aktPVis4UlVqRWNLRnNJTEtISmR2bDh4azhwZ0hRUWFlU254ajVvRnh5?=
 =?utf-8?B?bnhaZEsyMkY5UEppTXYvSjc5MFNLSGxRbjBMNHNOZkl2MXdITnpweEF6S2pU?=
 =?utf-8?B?a1N2SW5HMXd4YTdFck52Ti82VGd0bEhSTFA1QXFrcGxraU5wdE1INVQwNDhM?=
 =?utf-8?B?Nzc5NkUwQWhhWlFjaG03MGxmZ1BkQ2lBREtxWEh1MGpPbEN5RWpWcGlvRkxq?=
 =?utf-8?B?K09VSjk2eXlRZ0IyNU5odXNCKy8rTlZDQnlEK2IyRlV0R3FnVUhweGhEQUI4?=
 =?utf-8?B?NDRmbWpXN1llcTdkRUtlbzMraytaSmpxbTlHMDhhSWtuNXBpdXQ1Qi9UNjI5?=
 =?utf-8?B?OGt1TndhL0ZCY3VSbklRL3IwbGptSXlRaWdkUFVpdjZ3bFBDWCtkNEpIdExJ?=
 =?utf-8?B?RU9oR3pMd0NIeXp1N1RyakRIZjJIdGpIR1JTVm5jaml6VFZzUU45NnJhdUdp?=
 =?utf-8?B?b3ZMSXFuVHRvTDdVREVadHNSZkZ0WGg1WVNpRjVpaWUwcTdOTUlsS3h5ZEo5?=
 =?utf-8?B?VExZTldhVXJwZ0pCb2ZPa2lZdlZpYmYydTJaa0gydkNDa2I3K25OSk5kV0Nk?=
 =?utf-8?B?YkgzcDBzZWJPL1RzdnBRakpvZjUyWi9vSy9JZG5UVXpwUkZLMWIrUXU2UGlX?=
 =?utf-8?B?cHl3VDZhZmRVU252Vm9Cd0lpd1dhalVLaEs2UDZXeFFmdUw1QitBUGRhTFlx?=
 =?utf-8?B?Q0FTRDh0cFZHMURGWWtxbGdLM1FlZjBiM3B5N0k5aUJJZVhOZWVZaWhTYUlG?=
 =?utf-8?B?QmUzMEc0UVJua25yOTZUN0F0SUU1WG5EcVNhWVlWQml0V3VLRjBIODRXQW1r?=
 =?utf-8?B?ZG03ZHFGSDVhVzYwdThBWkhjNnQ4ckZSTkRia25MTnR1NURqYVBpTHhhSkUw?=
 =?utf-8?B?SjdZcFBQV1FXdXpkSjEvWFZHaWxaWXhvU1Nkc2gvYTZBek9TeDJzNXhoWGVR?=
 =?utf-8?B?dEFVc2orbEF0WTlvZnQxd3RCM25BcnIyeUlqcndpTnZhOW0raUFDR05jMWhP?=
 =?utf-8?B?b1pJUXFSZENLRm0wYmZrcVEyTzNDKzZoYWhIV01zV3E5djBYZGwweXZWNk8y?=
 =?utf-8?B?SDlHa1gvSWVYdjFPWUQ3dGh0ZmUxU25weEk5b2lTUXVyT0hkS3ExVVU0bUc3?=
 =?utf-8?B?cWdiY3dFMVF4VXlyMUt4anROYjFZa1RmanVyT3ZjMnZCVC90cXZJOENFREY4?=
 =?utf-8?B?dHVsL1VVNTEyZGN4NHpaZzRwZkg3dDNRemxLdUxrUXBwS2NQSlVEdzdsTVV3?=
 =?utf-8?B?WGFoQmIyTEJxaTVuYjhxN1NaUk10NW90ajJsNGNFTloxU1hqNnAzbnoxeXV1?=
 =?utf-8?B?dmVhaFNmUU1uWC82cDB2Q2k1MjRacnJ4ZzRIbU5ocVYxSHBPZUFqTkZwRklW?=
 =?utf-8?B?YnlTZGFvM3lINlRpTTZVWEl2Z1dBbndIcmtpdHBqUXpuOTZ1clpTRUhxOWYv?=
 =?utf-8?B?SVdWK2pkdE5wSGh2aS9lM0IwdGpRZkRYbG1tVmpOcGdhb0tyS25XNml0MmVU?=
 =?utf-8?B?NFUzYTNRaFFFbHYyK2pGbDQ0RFlINlBXZTArUFhrVGNvU2NUT21CZjhhNkJI?=
 =?utf-8?B?OXFvdFRoaG5vVHhqZlJnUTdIaWNma0N6dTNFb1o3Nm9CZGVSNjhVRWtldE9x?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4b8e19-3bef-4d45-8657-08dbc34efd3a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 13:53:42.9184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJ58jjTf0UhmZqySfojvXY3DmNfPFRHtHH79770Y96c421OUwbmIaMxeNSDSw4POj1V2a4ApDCT39m9gP0MDEzHjupuA+kpz5DXmo6cqeBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6371
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Andrew Kanner <andrew.kanner@gmail.com>
Date: Thu, 28 Sep 2023 23:44:40 +0300

> Syzkaller reported the following issue:

[...]

> PS: the initial number of entries is 0x20000000 in syzkaller repro:
> syscall(__NR_setsockopt, (intptr_t)r[0], 0x11b, 3, 0x20000040, 0x20);
> 
> Link: https://syzkaller.appspot.com/text?tag=ReproC&x=10910f18280000
> 
>  net/xdp/xsk_queue.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/xdp/xsk_queue.c b/net/xdp/xsk_queue.c
> index f8905400ee07..1bc7fb1f14ae 100644
> --- a/net/xdp/xsk_queue.c
> +++ b/net/xdp/xsk_queue.c
> @@ -34,6 +34,9 @@ struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
>  	q->ring_mask = nentries - 1;
>  
>  	size = xskq_get_ring_size(q, umem_queue);
> +	if (size == SIZE_MAX)

unlikely().

> +		return NULL;
> +
>  	size = PAGE_ALIGN(size);
>  
>  	q->ring = vmalloc_user(size);

Thanks,
Olek

