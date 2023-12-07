Return-Path: <bpf+bounces-16994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E741080820C
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 08:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E894283173
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 07:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C815819BB1;
	Thu,  7 Dec 2023 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRRro8GD"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38467137;
	Wed,  6 Dec 2023 23:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701934789; x=1733470789;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pm2PJ44tR8I32FbIiDQEZXZGIEXliuTGoE+ozgjuncQ=;
  b=iRRro8GDWjwpJqj+ggYZS02/4KI95lcn9cqrMO6LQWl/CbpqGgNe9gjd
   bJnZLLQ+5YteVON7b2IbOQZ2NvsA+GuygIObU1WhdtfvgNPZL+yGf09Hj
   n0n3TFJWsNodltOtVqciZZsbPKnOBAh4qRWjAizz3c4THNA7An+R0awXN
   +BKy6p/dzci/NKElItI5vivUiQICWQw4pRvUnXHP2rnWwOFI+krHr2YUu
   8MawUxSIs/Ver7OvDeLZ6qarvb5N4x86xYU9kemBuev0dp6Zpw1WfNClQ
   Q+FBD+HPECatPzt95GEIBRU3fSJ2znZUE7eM5Pp6sF7ehhZdIHdP6fJyC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="391363667"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="391363667"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 23:39:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="747879668"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="747879668"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 23:39:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 23:39:45 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 23:39:45 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 23:39:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3GWt+gX+9vXsHr51YFcmovxHOCEKfiBzRfCSGLMAWvQBeUdhYGTU3tUpaWlb5BC1mMFRH64jV7Ek0m3llQ8atkLKJhMHLN5jrVIUO5BYNLhB+HA9z6iwUg+u1xceJ8UWw5xZNrixbgfrdPylYyvFVkXNQnKi3rvyzOfvKKU2LUHmleELFHFrIwrfho4q1CnA2S18Depq4u5SERXO+LX322gzX4vrj5htSNhKE1JVuqwmBWpZolGYzgV6uR2h3toCWeec5HXhtj9utqyHHFMxW4HObOvl/ROxcxQSKn+wzrQZUxnwivgQJrXZYvK+DbZMWzLiAvGVQDakvl02aNmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7aqCj9JoDtNEvjThPCuZ077QvUsj+1OVb2JGqgXllc=;
 b=jyS45tbG8IP0Cyq8GTJ0dYjHLEswfmB6O8kWhJs3vcSl9olX8GNKgYhLaAZ2vPiK/KDy6XJJw5tGsNboKSk6Qh/MVF6NV2WwVZJiTr7auaaPPlCCRGeBb1ofP7TO0BOt0gPbDXmAg8DjvcfLZy+ywzOmlsyz7nlZIItSAs6GntB3A3SgQPE1rC+q3+NIoAwMo3AlXFVf2EY+0rUM9zE0or37rtVdZNuQpIvQ0xEtxWotjtAFpqBxkRmUlISFnRH1rYOuYydM6zxfYtLXQfvruMtrsSWEGJYxAfSz2sVJBqqOeHxHS0mxlZmfXAfVZJv73BRJGSsacWJVNezBO2qyCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by MW3PR11MB4652.namprd11.prod.outlook.com (2603:10b6:303:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 07:39:42 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 07:39:42 +0000
Message-ID: <1905b2b7-629d-4f80-1b77-0479596ba17d@intel.com>
Date: Thu, 7 Dec 2023 08:39:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [Intel-wired-lan] [PATCH net-next v5 2/3] checkpatch: add
 ethtool_sprintf rules
Content-Language: en-US
To: <justinstitt@google.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Shay Agroskin <shayagr@amazon.com>, Arthur Kiyanovski
	<akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, Noam Dagan
	<ndagan@amazon.com>, Saeed Bishara <saeedb@amazon.com>, Rasesh Mody
	<rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>,
	<GR-Linux-NIC-Dev@marvell.com>, Dimitris Michailidis <dmichail@fungible.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Louis Peens <louis.peens@corigine.com>,
	"Shannon Nelson" <shannon.nelson@amd.com>, Brett Creeley
	<brett.creeley@amd.com>, <drivers@pensando.io>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Ronak Doshi
	<doshir@vmware.com>, "VMware PV-Drivers Reviewers" <pv-drivers@vmware.com>,
	Andy Whitcroft <apw@canonical.com>, "Joe Perches" <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>, "Lukas Bulwahn"
	<lukas.bulwahn@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, "Andrew Lunn"
	<andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "Vladimir Oltean"
	<olteanv@gmail.com>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?=
	<arinc.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>, Landen Chao
	<Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Sean Wang
	<sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=c5=a0ipraga?=
	<alsi@bang-olufsen.dk>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team
	<linux-imx@nxp.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>, Jiawen Wu
	<jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"Alexei Starovoitov" <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, "Jesper Dangaard Brouer" <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
CC: <linux-hyperv@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
	<netdev@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
	<linux-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	<oss-drivers@corigine.com>, <intel-wired-lan@lists.osuosl.org>,
	<linux-mediatek@lists.infradead.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20231206-ethtool_puts_impl-v5-0-5a2528e17bf8@google.com>
 <20231206-ethtool_puts_impl-v5-2-5a2528e17bf8@google.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231206-ethtool_puts_impl-v5-2-5a2528e17bf8@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::6) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|MW3PR11MB4652:EE_
X-MS-Office365-Filtering-Correlation-Id: db75d587-aacd-46ea-f714-08dbf6f7accb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/LLvMoORqZA13QBRkieAtG9Iy+Jgyv5/WjeBTpGMwzXzmzXfELtYVtQXZSI8xUzyIig7Viy5X2kWd4cHMXVz9jslAEo5WzrAgucM1w+gjEYbMYgpT4oDvmAbTN12B8IBryvq3ciiFCkA9yhR6nKS/hxBN59mZ2OP1iB72hu3GboLCKOs/u5o7JGSGnIsVxP3PPp4fjItT69eSVGTB2+BltzL29c68hbB52HbEQAJTnUetveXyuUjUwJwHoHySN9I/fIJ+YEo+9rlYXpu5G3THMc9GTouHaFEHbipngskiTpID5bBe1NdeW3Sajy3j7kk4eU7a/askEROzkZTj1FkYQAxTR0arngFBuSEk582GIF6OJyJUFAXSTWioxD2Nofcv9PU4CM1gVPM0FnCmHgR9k+MM9w7wauQgLsO4MfhKgqPIqI9JvRxK5+OR3XSmRaiFJR/MwribEXdQHqs9xbXAPK/tyMOJdS9diRx2NuZmMaKL4Xjv1OUrj1/DIbgqHGOXT5RQX3Chr3Rvf6N3sbEyBi8mmcJntQip0gljSl6GhZE2CgG1VuKZ71rjlg8BOaN3MRyQax3LiGMz2UC5oHqsMVa3reWb+3zA/nhj2sFsoX9qVqIJRNeUfIqnNiCtCxCnqtXiYwYV01f01tFjiHMw46n2G5OOdQ8mRCt8haEG4QZ9ViYe8Gy7IfCVP28b47
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(7416002)(7406005)(7366002)(5660300002)(2906002)(1191002)(41300700001)(38100700002)(66556008)(86362001)(82960400001)(66476007)(54906003)(31696002)(66946007)(110136005)(478600001)(26005)(2616005)(53546011)(6506007)(6512007)(6666004)(966005)(6486002)(83380400001)(8936002)(8676002)(4326008)(921008)(316002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmVGRTdCQ28rMVFtQTJkcjBTSnllTkFhTnp2Q0syajJZS05HekNtZ3lWVlNo?=
 =?utf-8?B?WjlFdXVId2JFeHpEdE1lRkpoLzhmNzl0MVYyV1hLUFRBb3ZJYlZNNzQ5aHd3?=
 =?utf-8?B?VWtGT2JYMzFZL2kyamZlQnRQeDNrUGxDdng3UlIrZk1peXp3ZS9sWlpaVElz?=
 =?utf-8?B?Zk55c01KKzZyRnlWMmkwQXlEellGdkZUaWJTZkk5aEFCRExCUDNyRWxSK2JE?=
 =?utf-8?B?RHkzcW5JZU4vaFV1UVkzdzBLdVV3ejVkMkQ4MFZINWMwTXlOUHBhUng0ZDRm?=
 =?utf-8?B?bndHVlZaTEY2a0MxMkY2MGpObzV3V3U3UU5EM2dydmgxcUZQTm8xT1pLVlEr?=
 =?utf-8?B?ZGFwam0rK0pJMTlReG5mYkQ2d3l2eXRqdUh0Y0RVMXRuS0ZKS2psMnI1eG82?=
 =?utf-8?B?TXZKUFFjeWhlYzNjbVExZ1EvbGZYa2pyRFZkNVRqQXZyb3pGV041Z2V3eFBr?=
 =?utf-8?B?eWV5QUs1YmJuTWdxV0RsamlYK2c1Zk5qNk1yQWlTV0RqQndxWmkwSXZPNkpj?=
 =?utf-8?B?V2NHcXlYeG8vNGg0RTVCcDZxbWtBWXVuNWdVdHFSYkROUnFORmNGUHRLYmJl?=
 =?utf-8?B?c25QOFUrSk9hcllxeG5qYWJwWWowSTU1MnpVanIxZkZmMlhWdVBUck1xSEpI?=
 =?utf-8?B?VDJKOXN4ckhIeEk1R1dkTzA5RnNPanluZ2VzOG5aWkw2TnZMVE5YMkVkV0hz?=
 =?utf-8?B?c0laU2dsSncyK1Q4cm00NlZTcHdLczhQYm9hcDlYNTBrNmwvdU5BTklHNFhE?=
 =?utf-8?B?MEZ2Y3VZcTVFT2I2WE9nemszT1FSVjVOeGRIb1NYWkloOTNQVU1VYVpBZTBk?=
 =?utf-8?B?WFhzNFdUY0loY3NLcDdrQTluM2xpcXBDNVkzWkZqTFduY05aQkVXOFZDbkFH?=
 =?utf-8?B?bGljVG0yVFBsQVIrUTMxOHRPcWJuWERiUTVPVUFvUjh4ODV0RFlQSEVXZjJt?=
 =?utf-8?B?L0c1NFkwWVZkNUcwbHB6Y1FLSGU3Wngra2J2cDh5cFhLTkFPbFRadEFTQlRZ?=
 =?utf-8?B?dWZ5SjltTGd3UTV5b1M3QzdkRU1RQ21NM0RIa09UNmhJZFJkd05rd1BWellw?=
 =?utf-8?B?akM1ZHEzUHk3czlHdG90ZVdXamk2YU03NmV2MjFXSGhWamFpUk05em92a1ZB?=
 =?utf-8?B?RTRYYzZKWkhvYkxGWm1tS3c1b2RocTVxbzdDY3ZuSklLOEVwYWZlVCs5TElr?=
 =?utf-8?B?eUczVjU3cEZSbWxablpvNG02NEFjVWNocDdTUGdQNFFRSDZoRG1KSmtPbXZ1?=
 =?utf-8?B?WkkxYzZpUEJidGU3NXAzeEtVWk5uNzJIek9VOUZxZVNlNW9BMXNMRGRTMkFI?=
 =?utf-8?B?OVVDRTBaRlBmeUErYkpYNmlWTmhCZk4vZWZuSXZWTTBidVdSRnVPMHdJWGRw?=
 =?utf-8?B?R0g5RlZFRS9rWEF3RW50VnBKc2gyc0w4bWJnN0p6U1lDNDZvaUtrQXQ2ejNR?=
 =?utf-8?B?dURnYXV6aHY4WDhtUTZkTGozYkJrb1RWaW11SnFVK3p4YitZSFdsNEt3Y3gw?=
 =?utf-8?B?ak84c2JSY25wclNnNE9tMHQxK0hjaU1QQUtLY0VCaHJzVkVlWGIvdXh5a1FS?=
 =?utf-8?B?cWVLZXp0U2VZQVdyd0cvT0piKzNpVXJybVhxa0w5UjVmd1hsc1hBeVArbk9V?=
 =?utf-8?B?ZWJ6YVl1VWdRc1htSTVSRzd0d0FIYjZEY3NaUGZwakZjQlhUT245dW9PZGhs?=
 =?utf-8?B?c2xGUVpta25mY0JJdGpoZXhydDhYZnhtcHZvZldvT3Y4QXlPbEIwaHNxK2JE?=
 =?utf-8?B?UU5nMVV2VUkyUHh1VXZnNkRlaUhxOXExa2Qvbm1tWDR5K1UwNVRFSFRid2ZZ?=
 =?utf-8?B?bWZGL0tNR1hveXhOaE5sRW5ER3NjTmdaZzRBMHpkNTNKSHZrTm9lSkhqcENX?=
 =?utf-8?B?V1d4Q1l4bWM0SUhrWkI4bitSTWdidlYwUEQxRDcxdnZPZ1h2Q29WemoxdDQ4?=
 =?utf-8?B?N1J6SWtveFBwUXJRd1NQN3c0ZWRjcGVBUXQycDVzTnU5VHoyZTd5QlQ0RUhB?=
 =?utf-8?B?SzNlcnlBcGY3eGlpZnVHYUg2Q1dkSGVlUHpMS2pxeUN5Y2JvYkpjTWVYeC9N?=
 =?utf-8?B?MW1xYmx1WmtFMWUycytHbnBmOEtPY0I1TnBYbUxZcWNQZFJoR3Z2bVBRdzMr?=
 =?utf-8?B?VmJNZFlZVUo3aW13RG11VzJLQnZSR0QwYVFKNXppSWNuYlpWVCtQdHQ1WmJ6?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db75d587-aacd-46ea-f714-08dbf6f7accb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 07:39:42.2250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2iGJwuAFlHnyPbvMo/NtiIXp9Kzj/T2RFLMJmTqhBZiKHdyiCa6IMJZJWXJI+Xrk1LciSo2P3IorTJa0S3r08LS/461DSPGUIiI3/5ZqunY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4652
X-OriginatorOrg: intel.com

On 12/7/23 00:16, justinstitt@google.com wrote:
> Add some warnings for using ethtool_sprintf() where a simple
> ethtool_puts() would suffice.
> 
> The two cases are:
> 
> 1) Use ethtool_sprintf() with just two arguments:
> |       ethtool_sprintf(&data, driver[i].name);
> or
> 2) Use ethtool_sprintf() with a standalone "%s" fmt string:
> |       ethtool_sprintf(&data, "%s", driver[i].name);
> 
> The former may cause -Wformat-security warnings while the latter is just
> not preferred. Both are safely in the category of warnings, not errors.
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>   scripts/checkpatch.pl | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 25fdb7fda112..6924731110d8 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7011,6 +7011,25 @@ sub process {
>   			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
>   		}
>   
> +# ethtool_sprintf uses that should likely be ethtool_puts
> +		if ($line =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*\)/) {
> +			if (WARN("PREFER_ETHTOOL_PUTS",
> +				 "Prefer ethtool_puts over ethtool_sprintf with only two arguments\n" . $herecurr) &&
> +			    $fix) {
> +				$fixed[$fixlinenr] =~ s/\bethtool_sprintf\s*\(\s*($FuncArg)\s*,\s*($FuncArg)/ethtool_puts($1, $7)/;
> +			}
> +		}
> +
> +		# use $rawline because $line loses %s via sanitization and thus we can't match against it.
> +		if ($rawline =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*\"\%s\"\s*,\s*$FuncArg\s*\)/) {
> +			if (WARN("PREFER_ETHTOOL_PUTS",
> +				 "Prefer ethtool_puts over ethtool_sprintf with standalone \"%s\" specifier\n" . $herecurr) &&
> +			    $fix) {
> +				$fixed[$fixlinenr] =~ s/\bethtool_sprintf\s*\(\s*($FuncArg)\s*,\s*"\%s"\s*,\s*($FuncArg)/ethtool_puts($1, $7)/;

(not related to the patch)
without deeper digging it was completely unclear why it is $7 for the
"second" capture group, turns out that FuncArg contains parens and other
vars with parens :~

> +			}
> +		}
> +
> +
>   # typecasts on min/max could be min_t/max_t
>   		if ($perl_version_ok &&
>   		    defined $stat &&
> 


