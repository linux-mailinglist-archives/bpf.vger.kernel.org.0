Return-Path: <bpf+bounces-20334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5721C83C755
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 16:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8208B252EB
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 15:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F93D745FB;
	Thu, 25 Jan 2024 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ku3W0rks"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BB87319E;
	Thu, 25 Jan 2024 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198037; cv=fail; b=fBvmNku8nmRuIUu81q+d/uGdjqNBmpe/Oz762kpZw8VfY+Ql0K5mV9Ad1HAJ1WqPhMcP0yXckIeLTZFPEROKv386HgKc1Cf1wM30+hcUzTNaUfd811TA0kPY4POF+kqWVVdt49cm9oIkXklH4QPzuZiM5IJvLX5jdpyXKn1M2pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198037; c=relaxed/simple;
	bh=15zn1m97u4bwhGChAXftIMeG0/xhkN25P5cdQTqvBQ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FDOvdNOu/iouKH4sh2BaowGwXNmeyB4Y4JnHb3l7e+8Ao6kIlZwPmcKVAMLPUotsR5Iy5Y++1n/axQoO2S3GAbb7YRZMqeI3ea1NvyvrydMlhFK7KfnK/lgRo6XXJwBy4lkx/WwB0ZQhMxRvkeJMZX/5w9j3bm69cASJ4ed/f44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ku3W0rks; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2XGdDNXmCks3u8rPndunZqKoNzGHzzMs0raTpo+3myWBZf3Ugb9FLuwnjJ9UcSAVUw2/uApoczmNIX7zWXcbUmo7R4TZGzR1p5nJKpo/laVngVIjxXGtYkqxG/jlQyF46N5Y1+Owo/ENm90NZm5by+k56Kj2E6uRdOvhq91jDYZOW0sYfCtPiWFweI1+GKY2Do7EcjOtavBSxwe5ndjQ8nefEDPT0AXGM5PrF+GdMIm783Vxtdvfsx6O9FHnYbL5hZILSMYrrDqHm2ZZYc2aScv710zGGP3rS5OUP/TEvSsx/4CxRPvbT/mXrhknA814x39/MyNaKqeVDz414lVLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2t3m9vV9EIEP+2PkC72X/t0KpMis6RVyUMtZapQPL3E=;
 b=mVl/1+IBdJ04KhExeGokz8JJtP3or3PFSCiLNro6+ebm4GkBqUJ4Lqyi2qQ5QSi/l/yx6ymjtUrNG24QCslqR/k4KGavPmNnpEh8dlXg/Vjj+jSz+mMR09x9o0uW7AEpEHYj/b5O6NOl0t+SJJXgIjNONLnTMHhgvoGVprFazJuS1y5Ll4geLebsoLnHFXLra2dOUSlCTplZC8lZ/ueyYaaB17xyfRRGWC0HYkI1L5n1uMNTdlcPxO4zigZPh4PSaKGQ003WJeWMFdpP9zZin/0Ywi0VJMzG4NPojScH2DemxEtaxH+dJwiIqLMcU8dnq+yob/ZCJacrk1a/qyLAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2t3m9vV9EIEP+2PkC72X/t0KpMis6RVyUMtZapQPL3E=;
 b=ku3W0rksAS1RN79hV5f3GOdRax6azlclIbjMCyOInM2ajBABX/FCjinLW44G5nR41CUB7sYc6dmgd7mZEurgRgcjtxZcTiM8JoaGYBmSpaBFHxuxlCRnKhEc7PvARkt2ZKfLvl7aGUq3tHDmpbkwx7laWxoYzWeOZwXfiWkcJvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 15:53:51 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::e9c7:35dd:23f8:74a1]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::e9c7:35dd:23f8:74a1%4]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 15:53:49 +0000
Message-ID: <e27cb384-8f4d-41cc-b87a-2b5c84ccbd66@amd.com>
Date: Thu, 25 Jan 2024 07:53:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 bpf 04/11] ice: work on pre-XDP prog frag count
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 "Karlsson, Magnus" <magnus.karlsson@intel.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Eelco Chaudron <echaudro@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>,
 John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
References: <20240124191602.566724-1-maciej.fijalkowski@intel.com>
 <20240124191602.566724-5-maciej.fijalkowski@intel.com>
 <f1ce06fd-30da-405e-8082-e35a9a88c5bd@amd.com>
 <CAADnVQ+7qB44dGT4xkMPRrxNJrY-MFVU8E=jPiD+_CXvL6Didw@mail.gmail.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <CAADnVQ+7qB44dGT4xkMPRrxNJrY-MFVU8E=jPiD+_CXvL6Didw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:217::31) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 8197b6f0-472c-4e21-0c7d-08dc1dbdd284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eMB6W5ogzpslhjVNsICX28bEB07RDCX0j4ZYYGcvBi2HEbuK4HeRr2QieIK7y7FNOUreSNkjErtHTIIaEs1O/sfu26tCb2QScBVAXCPY9HYPchlpTDOr3V5qso9aihPpsexzAmebaN3olJH/rVT2eH9oYQau90JixdUIT/wh6FKWqdPdtAe4dIi+xaRFKUZf3WdnvD9enKKoZy3E8sgfDhrGCRrD2Mz0m/8i9hOQAAkKlb7ia0hxaABWM/IW7Y3CrwMbIgm9XAB+KMz225yXBcjTQhSIGtxhV3fGhimaNtudbILRQI1Y9jBDs97EKfJYXxFxjJ1up9BxKCbPpRn47KwcvO/vxLBlfxVy6q8JMg/zHguZGjQWnr9xDbtc4mjOwClrlY+92GLw32aZeqvEO/WigbkwSgzJlXOH3v1WLMVtxNay/M2J9lQyaGHdxTGqr9a2/trNgQajQ/vSewwTVrX2I8JXzQ6fX1b82zZRbpNju6yVj3QjzPIRWAzm29q96o5ur98HzrHzy2ehdhROTIjSZ3R8yCGc9VVXcWx1qmvfNBsmFsq7l3oAJSo7M7jYTSLsYS0V+lGwkySNhjdimUYy8ViPTMM7HswjRMmuYzTDuEju+pvTCOBix3z+597AzzKmdOaJd15BcOUwPMc38wFBBRBLoq4fVqldXWhmBb5Y3qnGp48GxOqc8ytVDv7k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(186009)(1800799012)(7416002)(83380400001)(2906002)(4326008)(5660300002)(36756003)(8676002)(41300700001)(38100700002)(6916009)(66556008)(6506007)(54906003)(66476007)(31686004)(316002)(66946007)(53546011)(478600001)(2616005)(6486002)(31696002)(6512007)(26005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUJRNTdHb2NOdDJBdXJ2N1F2NWM1bmd3Sk1DZmlSbXgybmlId0xoN2h1bjZl?=
 =?utf-8?B?K3Fiekh4R1lBT3hDcUxtWVYwdFRUUGxvKzAvU3NYeVpYRkdNdXRqanhkL0lO?=
 =?utf-8?B?aVN6cE5OMWkxN2VzZWVFbGhGMFN2bEdCSkVjWWVLVDAzcU9FdUNWdE1QQ3ZP?=
 =?utf-8?B?ejFTRm91Ly9qeGxucXZXNEJkKzNUeDgraHlXUHdrbkZ1cHgxblNVOGVRb2I4?=
 =?utf-8?B?ZzdVRnFhMjEzTGF2OVR3MWtwVklMa0dwY1daSTFuWWV2MzdkYy9oNkhiVjRa?=
 =?utf-8?B?ajhQNTFYZ0pSS0pBYnZ6TVRUdlZyUlBZVEhGOHhSZXpJRHo4U2t3d0tJVGdw?=
 =?utf-8?B?QlN2KzhBMldRaVhXMjRPc05mMzlLR0tsS0tmaDVsOHdGSXFqOUgrUy9BN3VI?=
 =?utf-8?B?blZhNG13Vlc5bGowYWRXUGFMTnIzaVBNLzFDb1hsekpONWhIMlowekNDMlRZ?=
 =?utf-8?B?ZGxzbEJNVDBGckJUM0ZKY0licGV6aTc1RWJEcGVZdFpOVHRkQmxRT3M4aDRn?=
 =?utf-8?B?ajVGWU9meTFaQkR1d2RudlJKRFo3UFRHa3BQQjNKZWUwZmE1UTBWOHBIT1NQ?=
 =?utf-8?B?THNmSTJBUGY3QjFlV1loUERWUmRFT3RzY3IzeXpEZ2Jwd2pDb2g3a2l3WWFm?=
 =?utf-8?B?anU0Qm93ZCt2OU1SUDlEdnpPd2RVSmJtYWZkMklqeGlTc21hQTc3bW4rbHBl?=
 =?utf-8?B?ZXlnRFV2UUlmSTl4MnN0QzkrdnQ2K1NoZ2ZHTjdvM29VRFY1N3RUY2hCWWhR?=
 =?utf-8?B?YnJ3WjJJdnZCdkpmOFBkTWdLbDlvSWlCNG5BMGVZWnh4ZlNUY2VSbGJiNFhC?=
 =?utf-8?B?aFdKL3Z2V2MxdjUxQ051QWphdmtiSzBsNXFwc1BUbGlmY2NvSVdLZmREMDFm?=
 =?utf-8?B?Qmw3QlIxT0Jkc1dpdkpZRHlWQ280OVNnVmZrQTh6RThTSzRwU1VNaGRUaTBz?=
 =?utf-8?B?bEticG5PY3V2cmZUNXlMVGp1RTZZS25XdDVCQXpNZmlWeE1NS2ZEYlBRTGha?=
 =?utf-8?B?bjRHc1R2WFd1UzJPLzJOSUpVanNxdzBGUlZvdWg2ek5nODFmR3pQZTVhaUhv?=
 =?utf-8?B?SGZGdWxzamh1bkZ3Z09zZVNXNnd5VjhFSTEyVHAvR09JZExpSDFPYjduSlVN?=
 =?utf-8?B?VjN4V1NtUE1lcW14UTg5aDNxS2FxM01UYlJ3U09ZdFJkMzFzWER5L3JmNExW?=
 =?utf-8?B?QjFLYjhDOVNlZ0kvY0xsYjlacllIWlZuRWVpNTRDMDFMTDRFQXJQeU8rL2Fv?=
 =?utf-8?B?THdCRVBmWncvQmd1RzNNTGl1eXd0Y2VhMTlucmlLYzBwU2VwNUl1MEJweDln?=
 =?utf-8?B?aEdoZzBqaVFHQW1wN2x3N3NNaTFCR0JvQUE1YVQxZ3JTZGRFYkVadTJGUWln?=
 =?utf-8?B?b0tMUng0dXpTWFh1SHF6dGd1UFpyQTF6S1AzMEIxL3FxN3I3N3lzSXhyUlEv?=
 =?utf-8?B?bW5ZenRpVThDUzFFYzIycDdvcmErVzM3U0xNU3pvU016WkF3UVZjcFFzYmRC?=
 =?utf-8?B?UDk1S2JhNzNYYXVEYjRpN0dPZ3ROeWJLUFY0THp5eVp4UUcwYm02bG01Z1RJ?=
 =?utf-8?B?N3A4K01VUm1FS2ExNUE0NkRoczJvVFRJSGxkbVdkY0dYUDRhcW5ZNStGZlky?=
 =?utf-8?B?MS9Mekp0ZnBpWFBHZmFpVENrcnFzWExYTlk1UTYycDYvWFVPT2UyaXFuRzY5?=
 =?utf-8?B?bUx6VnVYUVJYU0lxeGM4WUF4MFVwUFhwZGt4UzZhWWtoTFF2cmtJMVhsT1N5?=
 =?utf-8?B?Uk8yZDZZQUdIMDBXbzdHdEN4VFJZanBjMzJlcWlYTlQ3RlEwdk5WNEhLSGVK?=
 =?utf-8?B?ZGdlV3Z1TVdCRUZGUHhlKzJTMSt0YkxPUkxDN3JiRWhKY2JVK2xGUFA3b1o3?=
 =?utf-8?B?Y25xVkhtUGxTc2xidzdvd2VjT2ZXeWhiUjFUdEgwSE9DS0VpN2hzNGN2NEpu?=
 =?utf-8?B?aDZPaUNIeTVEM3F6bDFKR2hwdzRmWTBnUDZRaUtTUjVFcTUzLzZRWVZhbDd6?=
 =?utf-8?B?VjdzMUlDUEJ2VUV0L3ZOUm12WGVod0w3MkJaVjFLQXdKbzhQQktxeTFmWGdL?=
 =?utf-8?B?Ly93TTVxK3ZybUNRVHdIU3p2ZnRjVFFTWXRjaWV1aFFRTkNmZlI4SzBxOFJt?=
 =?utf-8?Q?EMVz2atd2W6XtZuFczuMgheFi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8197b6f0-472c-4e21-0c7d-08dc1dbdd284
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 15:53:49.8932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BOnekKDm22ubRVMvg2Lsh1Q6RGPgTILzKkvyP3lRtrdc5pA6P4axlFza3bODVGaou0wOJ8gDdzspW/TTVkqew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229



On 1/24/2024 6:34 PM, Alexei Starovoitov wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Wed, Jan 24, 2024 at 6:26 PM Brett Creeley <bcreeley@amd.com> wrote:
>>
>>
>>
>> On 1/24/2024 11:15 AM, Maciej Fijalkowski wrote:
>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> Fix an OOM panic in XDP_DRV mode when a XDP program shrinks a
>>> multi-buffer packet by 4k bytes and then redirects it to an AF_XDP
>>> socket.
>>>
>>> Since support for handling multi-buffer frames was added to XDP, usage
>>> of bpf_xdp_adjust_tail() helper within XDP program can free the page
>>> that given fragment occupies and in turn decrease the fragment count
>>> within skb_shared_info that is embedded in xdp_buff struct. In current
>>> ice driver codebase, it can become problematic when page recycling logic
>>> decides not to reuse the page. In such case, __page_frag_cache_drain()
>>> is used with ice_rx_buf::pagecnt_bias that was not adjusted after
>>> refcount of page was changed by XDP prog which in turn does not drain
>>> the refcount to 0 and page is never freed.
>>>
>>> To address this, let us store the count of frags before the XDP program
>>> was executed on Rx ring struct. This will be used to compare with
>>> current frag count from skb_shared_info embedded in xdp_buff. A smaller
>>> value in the latter indicates that XDP prog freed frag(s). Then, for
>>> given delta decrement pagecnt_bias for XDP_DROP verdict.
>>>
>>> While at it, let us also handle the EOP frag within
>>> ice_set_rx_bufs_act() to make our life easier, so all of the adjustments
>>> needed to be applied against freed frags are performed in the single
>>> place.
>>>
>>> Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
>>> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
>>> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>>> ---
>>>    drivers/net/ethernet/intel/ice/ice_txrx.c     | 14 ++++++---
>>>    drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
>>>    drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 31 +++++++++++++------
>>>    3 files changed, 32 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
>>> index 74d13cc5a3a7..0c9b4aa8a049 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
>>> @@ -603,9 +603,7 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>>>                   ret = ICE_XDP_CONSUMED;
>>>           }
>>>    exit:
>>> -       rx_buf->act = ret;
>>> -       if (unlikely(xdp_buff_has_frags(xdp)))
>>> -               ice_set_rx_bufs_act(xdp, rx_ring, ret);
>>> +       ice_set_rx_bufs_act(xdp, rx_ring, ret);
>>>    }
>>>
>>>    /**
>>> @@ -893,14 +891,17 @@ ice_add_xdp_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>>>           }
>>>
>>>           if (unlikely(sinfo->nr_frags == MAX_SKB_FRAGS)) {
>>> -               if (unlikely(xdp_buff_has_frags(xdp)))
>>> -                       ice_set_rx_bufs_act(xdp, rx_ring, ICE_XDP_CONSUMED);
>>> +               ice_set_rx_bufs_act(xdp, rx_ring, ICE_XDP_CONSUMED);
>>>                   return -ENOMEM;
>>>           }
>>>
>>>           __skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++, rx_buf->page,
>>>                                      rx_buf->page_offset, size);
>>>           sinfo->xdp_frags_size += size;
>>> +       /* remember frag count before XDP prog execution; bpf_xdp_adjust_tail()
>>> +        * can pop off frags but driver has to handle it on its own
>>> +        */
>>> +       rx_ring->nr_frags = sinfo->nr_frags;
>>>
>>>           if (page_is_pfmemalloc(rx_buf->page))
>>>                   xdp_buff_set_frag_pfmemalloc(xdp);
>>> @@ -1251,6 +1252,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>>>
>>>                   xdp->data = NULL;
>>>                   rx_ring->first_desc = ntc;
>>> +               rx_ring->nr_frags = 0;
>>>                   continue;
>>>    construct_skb:
>>>                   if (likely(ice_ring_uses_build_skb(rx_ring)))
>>> @@ -1266,10 +1268,12 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>>>                                                       ICE_XDP_CONSUMED);
>>>                           xdp->data = NULL;
>>>                           rx_ring->first_desc = ntc;
>>> +                       rx_ring->nr_frags = 0;
>>>                           break;
>>>                   }
>>>                   xdp->data = NULL;
>>>                   rx_ring->first_desc = ntc;
>>> +               rx_ring->nr_frags = 0;
>>>
>>>                   stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_RXE_S);
>>>                   if (unlikely(ice_test_staterr(rx_desc->wb.status_error0,
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
>>> index b3379ff73674..af955b0e5dc5 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
>>> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
>>> @@ -358,6 +358,7 @@ struct ice_rx_ring {
>>>           struct ice_tx_ring *xdp_ring;
>>>           struct ice_rx_ring *next;       /* pointer to next ring in q_vector */
>>>           struct xsk_buff_pool *xsk_pool;
>>> +       u32 nr_frags;
>>>           dma_addr_t dma;                 /* physical address of ring */
>>>           u16 rx_buf_len;
>>>           u8 dcb_tc;                      /* Traffic class of ring */
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
>>> index 762047508619..afcead4baef4 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
>>> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
>>> @@ -12,26 +12,39 @@
>>>     * act: action to store onto Rx buffers related to XDP buffer parts
>>>     *
>>>     * Set action that should be taken before putting Rx buffer from first frag
>>> - * to one before last. Last one is handled by caller of this function as it
>>> - * is the EOP frag that is currently being processed. This function is
>>> - * supposed to be called only when XDP buffer contains frags.
>>> + * to the last.
>>>     */
>>>    static inline void
>>>    ice_set_rx_bufs_act(struct xdp_buff *xdp, const struct ice_rx_ring *rx_ring,
>>>                       const unsigned int act)
>>>    {
>>> -       const struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
>>> -       u32 first = rx_ring->first_desc;
>>> -       u32 nr_frags = sinfo->nr_frags;
>>> +       u32 sinfo_frags = xdp_get_shared_info_from_buff(xdp)->nr_frags;
>>> +       u32 nr_frags = rx_ring->nr_frags + 1;
>>> +       u32 idx = rx_ring->first_desc;
>>>           u32 cnt = rx_ring->count;
>>>           struct ice_rx_buf *buf;
>>>
>>>           for (int i = 0; i < nr_frags; i++) {
>>> -               buf = &rx_ring->rx_buf[first];
>>> +               buf = &rx_ring->rx_buf[idx];
>>>                   buf->act = act;
>>>
>>> -               if (++first == cnt)
>>> -                       first = 0;
>>> +               if (++idx == cnt)
>>> +                       idx = 0;
>>> +       }
>>> +
>>> +       /* adjust pagecnt_bias on frags freed by XDP prog */
>>> +       if (sinfo_frags < rx_ring->nr_frags && act == ICE_XDP_CONSUMED) {
>>> +               u32 delta = rx_ring->nr_frags - sinfo_frags;
>>> +
>>> +               while (delta) {
>>> +                       if (idx == 0)
>>> +                               idx = cnt - 1;
>>> +                       else
>>> +                               idx--;
>>> +                       buf = &rx_ring->rx_buf[idx];
>>> +                       buf->pagecnt_bias--;
>>> +                       delta--;
>>> +               }
>>
>> Nit, but the function name ice_set_rx_bufs_act() doesn't completely
>> align with what it's doing anymore due to the additional pagecnt_bias
>> changes.
> 
> The patch set was applied. Please advise whether this can stay as-is
> or follow up is absolutely necessary.

I'm okay with it as is. If Maciej agrees he could always provide a 
follow up.

Thanks,

Brett

