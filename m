Return-Path: <bpf+bounces-11461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F397BA734
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 19:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 040FF281F06
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 17:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F84374FB;
	Thu,  5 Oct 2023 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OkkGG0cJ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAD934198;
	Thu,  5 Oct 2023 17:00:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6BE10D9;
	Thu,  5 Oct 2023 10:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696525204; x=1728061204;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7qhoUkng+KfVoBxMvtgHeuVxeUIkhPgcOaTZIil+v3U=;
  b=OkkGG0cJhyk3XeP7ze162Z9zHY277RM7xw6I6mGOsnFdysfyBQ59c19n
   yEdkrtpqY2qCMZTZK1l/RMvcjaCKXLRi61vsvMaIGCZS9/s1m3CXbmHnu
   Fby4NZS3NRFknrkj2wlk8Rqtm9skl5vu34uYCgHNKu6hhOEbK331goQz7
   84JK+4Lt2+21rjlcLWiTSpzBKD9RKnGhsjl7OLs1nkWp4d5KwkVVZalqE
   0cbAFzCiuQrsB8z1TXe/OdkVwQmft8Gsr+JLiiUeEHGFcZKtYb2qDGJTG
   v4YU3CcLtRa4B5QUGTuQsdr2T7lI8NZuUgpyM9fRmS4lNoZJ2JLRwKBk2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="382428774"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="382428774"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 10:00:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="875617645"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="875617645"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 10:00:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 10:00:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 10:00:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 10:00:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 10:00:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYegj+RbqS1rDAxQ7fNdusyHa2TRQ18tmIR9Ho6ROwtxEocxYOtOE5f53NU1Aaq1dqgGpbHR3OXtEhDVaeIU4zGWgkl2POkEZGEdqZXxikV703ikZbiltiBXe/mbvoTyDSqwnPyQTJobT5/4UXjjcHZvUxnUY0NE7wf2xzLdfOwqCN/hS5MjJ6W1GF9CVK2n+ZMARRaB+es0D7y3EhkE8eqh4/wpB1p0zPjO3fgeFc+IOvU9ztZOqERVYRYFJ115T+KxoHD3bI2lUMLGKBxwO2TLVJowDFu5f9/8YMDiKDW1luC3GaoHtbRhj9ci7MRt2fdiFQIqte3GBTZUozPBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrudV9KkUd+OTCztl7iz8KDMfA5BUMinPPnoIYm3Or8=;
 b=O8CxF3/2DsqxADm9FxVYqoDxfXk0vIIKxxxrwKpjHEGAsEFm4XhjbwKtoB1bq1BZ84F4g5fSDmv2RRvIgMkoZCE7TorbjPL7VtHUKqL0Yqpm7pYpLVLFCrY/NEHCBIHR28yZLYEKBZRxZbbgjLDzKRIZLrcnJTyuzoeuZUSwOH0pJv1dskfn6gdFo17qDnTXvlMrktJ1IVTWM8rDis+k+i5yf36s0dC3qxdq24zGcVTAotrPnD+g16YLCHnuF0ErkgMgtOG4/FnNtnei/D4GR/UEzqeVqiaIGEeYODCeiJmKljiL87oRcBiKKow3AT+IeQC9HA4nNU3wpUqU8mH+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SJ0PR11MB5021.namprd11.prod.outlook.com (2603:10b6:a03:2dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 16:59:57 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Thu, 5 Oct 2023
 16:59:57 +0000
Message-ID: <e4bbe997-326f-b6cf-b6d6-f0a24f5aef39@intel.com>
Date: Thu, 5 Oct 2023 18:58:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [xdp-hints] Re: [RFC bpf-next v2 09/24] xdp: Add VLAN tag hint
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: Larysa Zaremba <larysa.zaremba@intel.com>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer
	<brouer@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>, "Alexander
 Lobakin" <alexandr.lobakin@intel.com>, Magnus Karlsson
	<magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>,
	<xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
References: <20230927075124.23941-1-larysa.zaremba@intel.com>
 <20230927075124.23941-10-larysa.zaremba@intel.com>
 <20231003053519.74ae8938@kernel.org>
 <8e9d830b-556b-b8e6-45df-0bf7971b4237@intel.com>
 <20231004110850.5501cd52@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20231004110850.5501cd52@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::8) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SJ0PR11MB5021:EE_
X-MS-Office365-Filtering-Correlation-Id: f2519499-b269-479d-5292-08dbc5c4811e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TfiDH60KVOCJUnhUadGLOsGQjImua5gtqS7HItzKWzFBZ02bZX3V+7BQZvF5amEUowQ9fAMgQNClfFfg8sElf1ofN7Ms4yMbX4Irj0M7YL7jABSYn5WAq8rZd3+OA3Zg9s2cHnP0NYne4LnKnQR1NFNHjSYI0GZe1bBF22SjTwzdKunTzSih1DuetL1GDQSbRyd0CCNFBqh3FWXzk4+UfSTHZ67NyGxBgNUiOQQwiFZllX5X2YaUzmzug1hh1dndAb2yxe51qx8tLopqihZ54REi9O11E9KuxT8Qf3B8PXfMZ5018AmvQ+44gJdzadZT8Goc7Z+R9SMbsz9zoD3srFlUbmvLweQ4InsP/hnmBWnFM2vhxtlpnl2URVzORbq7jjNiJgBo7y48kPoXTq6WjFCWv4BfACU/21wURqp+IUDLLA4dHeByWGv7Wd4BpZNtQtbxMM9rLG/OTRCo/OydxP0ncSlYL3BacxZGfxxx6Ij6w0pphi/W/uVfCzu5k44jpeDExpq/oR5iPwC3Imv3yMD+7WL7bguyKKMt6wTXWEggsZgy2dRmaWk02rGhoFvj/a1lea610huaZ6Kt+eilYF1EBq3D1ZoWFE9VA/Cph53VbqvfRIVueZ5ptzuwnrS6qA8J2UeONtyjPC3IGLSf8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(346002)(366004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(66476007)(478600001)(6506007)(2616005)(6666004)(6486002)(6512007)(26005)(107886003)(7416002)(41300700001)(316002)(66946007)(6916009)(36756003)(54906003)(66556008)(8936002)(8676002)(5660300002)(4326008)(2906002)(86362001)(31696002)(38100700002)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHJUbVdiTmU3bHlrZUZMUWhDWnVCTGcwTmNxbVU4QmZWSGFLR2R1dGhia1h3?=
 =?utf-8?B?VFdON3poMUtsS3RmczNQcWx0K29UMklVTUFIRTArSEMwZ2JSMnhSY0RJN3pP?=
 =?utf-8?B?M3BoK3hRVTdSVm9VRXpvY3BsbmRTZitGb2NnQzdmN2pjVDBrVW1vbVZXRjk1?=
 =?utf-8?B?ZXp6bThrQ29yOVdldW83ZFcvY0U4dUgydjkrQ0Y0dGlRWFQzQStSNlEybEZQ?=
 =?utf-8?B?S3VYMU9uR1E3Q3krVkF4cDM4a1lhaVVhWVY4b1lUSXUzMnRyNGdJZnNPSkNG?=
 =?utf-8?B?dHo4R0pFa21MV1phcnZHR2pNTENmcGhEQ29keUdTeUgwSlV3U3dudDNqTjNC?=
 =?utf-8?B?K1p4RmN6SFhEc2tQQy9OcVhNb05uNWpvU21MZ213eEpXbmNQRzFHVDhKVHh1?=
 =?utf-8?B?VXpNdWZOMjRTN0NleXZuaSs4R2RLenA4U3RXRzJaYVhBSjNXZ3htSWVkSmJQ?=
 =?utf-8?B?RDBFOGlVeVNNVHZGUVhBdURVWlJPbkRsQ085Z1I1aEVZL2RwM3VoT3lGUkEz?=
 =?utf-8?B?UHNrQmhGK0pDQjhOQkQ1WlhQME01RkxHZ2Fpd0kxZjEyY1RFSnBheFYxM1Yw?=
 =?utf-8?B?cGRabUEyQmpCRUJDM29nUGI0cWRlM2srSkRkcWU4QnJaeDc2WUZNaFRzUnJ4?=
 =?utf-8?B?YmNMMnE5eWpTTFNkaStpQk9mbnBodmY4TGh1VTJzU1dyUmQ1NHlMSVJFMFZB?=
 =?utf-8?B?YnFKcnBVUHdNc1lJNVZ2ZVFvdXJTRk5ndEV5MEd2VGRFZzF1VExhdEdqbWdG?=
 =?utf-8?B?eE5hZU82bytsY1hSMzBzZHZ4L0VyMkVoVlBZL3o3bFk2bDV6S1B4UHVWYUN3?=
 =?utf-8?B?dnlqeWwwZys4WkgwcGo0bWlndHJuaENCeWtmMjg3VGRKdzUyclN0RDVMZHpo?=
 =?utf-8?B?Z2xwbUo5M0hWZ1pPOTkxam1XUWZaNTNSUExEdUhGeHE0dVNGTnQ0V0JYSXVZ?=
 =?utf-8?B?dWhhSEZ1UnRWdEF6RHdNZnoyalB3S0E1ZHptU2c1YldVVDN3aVp3K0FFNEo1?=
 =?utf-8?B?YWRwOTZscGM3eE43aXFqUHQycWI0Qk1HY3hwb3pKMXZORGJQelZGeHZHSzhw?=
 =?utf-8?B?cmsyVkg1d2dPdTBQRzlac3Z3b1RrMHVoc1Q3aHBJcEZBOUJ4RVZ4UXZZcGVF?=
 =?utf-8?B?bWI0ZkMwWEk1SkxkM2xydGdyNDduMzFvakhtbnNJVkpyZHpLcVhYbjhwTmV1?=
 =?utf-8?B?Y216UkdzV3RrRFJZejFaRDdzN0hONFl1aU9Uc0pOYmJMWVBFb3ZnYmxuVndt?=
 =?utf-8?B?OGsycG5jZ3hCKytGaGJmbjNnL3NEaWtDeDh6QTdkWUEySkd2SS92MDNrN0l4?=
 =?utf-8?B?MGZYMlI0dThUMUU3eHN2MHI2QlFGK0NOYnk5ZlRHNlJGejBVZUJqcHc5d2Yv?=
 =?utf-8?B?NWJDczB3NFVtQXUwYlhQd2R4NDVnN0J5SStxNmJ4eTRFUkpxa3NsYjRUNVYx?=
 =?utf-8?B?Z3E5S1ltTWt1SitFcmVBL0xOTjMzQjNlRUdsenM0MzNYdCs2dHlGKzF1NnBG?=
 =?utf-8?B?ZkxkNUd3Qzl5L2hRcDVYYXEwVHVJT1ltVHZObzJTb2xyNUVmQlZtTERHTDRN?=
 =?utf-8?B?ZTlnNG5VQlhaSUczNnc5SnRlNGtvNTd5TVcrWDV6MlNMTnVjTEtwSWw2V3BC?=
 =?utf-8?B?RTBMalF1dTZ4M2pzK2RSSWRabHFiNm1Hc3ZkUVk5K1c4Nk03TksrdUo1UUJN?=
 =?utf-8?B?UmxOVXo3SnBHYUVHWEx3NU1RNFIyRlQzdmc3U3ZBTldScU1Pc1ZYYVlydmRE?=
 =?utf-8?B?Zk8yYjFNKzJOSzRLMzN1QW5TYUlRVXB2YXhFNXg0NGpSWDg1SVMxVTNIVml0?=
 =?utf-8?B?amc3ZUdleDRMbTRubnp6bzZ6bkRlRFFYZzZwTG0rdWFuaFA3bzUvejdZNE0r?=
 =?utf-8?B?dVVTWm1ZaWF0UlBCTWNuT2xzOWZIWUtBUHpkV3BZWVU0OGVTTVA3TytjVGti?=
 =?utf-8?B?eXRkY1MvNVVyS3lwSHFoc1VDRTRYZXUxcFNqVFhxaWxPaWwzbW5TenpLK1U1?=
 =?utf-8?B?VlpxelFwaUkrbHdKdGg4V1NWOWczTG1RdlBBR2xyTnpYR3E0bGpHblpTRjYy?=
 =?utf-8?B?KzdBeS9adGpOdU8zbE9aTHBNczRpemFiZU90b0NqZExNQjd6anhnMUt3M29S?=
 =?utf-8?B?MG9ZRkNSQ2ZwUkZRYzkvWm8xT2l3aHlIa0p2WVpXMkxGVmtvTTZKVFJKQ2do?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2519499-b269-479d-5292-08dbc5c4811e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 16:59:57.5990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XhU+InBQ7qXMiuTMJEXEtHe+PdQYXUlw48d/jD1ZCGMeX3IFmaaJHOQiAba8qTNs66aP+kY/NMddElKO9+20KP+utcsKbAH0rn7jL2S9mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5021
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 4 Oct 2023 11:08:50 -0700

> On Tue, 3 Oct 2023 15:09:39 +0200 Alexander Lobakin wrote:
>>> Sorry for a random chime-in but was there any discussion about 
>>> the validity of VLAN stripping as an offload?
>>>
>>> I always thought this is a legacy "Windows" thing which allowed
>>> Windows drivers to operate on VLAN-tagged networks even before
>>> the OS itself understood VLANs...  Do people actually care about
>>> having it enabled?  
>>
>> On MIPS routers, I actually have some perf gains from having it enabled.
>> So they do, I'd say. Mediatek even has DSA tag stripping. Both save you
>> some skb->data push-pulls, csum corrections when CHECKSUM_COMPLETE, skb
>> unsharing in some cases, reduce L3/L4 headers cacheline spanning etc.
> 
> No unsharing - you can still strip it in the driver.

Nobody manually strips VLAN tags in the drivers. You either have HW
stripping or pass VLAN-tagged skb to the stack, so that skb_vlan_untag()
takes care of it.

> Do you really think that for XDP kfunc call will be cheaper?

Wait, you initially asked:

* discussion about the validity of VLAN stripping as an offload?
* Do people actually care about having it enabled?

I did read this as "do we still need HW VLAN stripping in general?", not
only for XDP. So I replied for "in general" -- yes.
Forcefully disabling stripping when XDP is active is obscure IMO, let
the user decide.

Thanks,
Olek

