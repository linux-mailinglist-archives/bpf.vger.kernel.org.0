Return-Path: <bpf+bounces-16992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1FA8081AE
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 08:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3AD1C216C9
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 07:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C2C168AA;
	Thu,  7 Dec 2023 07:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFPr2Ii7"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1A7181;
	Wed,  6 Dec 2023 23:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701933215; x=1733469215;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C7M3RD5xWev1r+5M07YF6P1h6hEHt7Xl5WvhA4yUhZI=;
  b=KFPr2Ii7+AYgBr0HJKfTwky8Vqa7aMXUbTv40or1aQ8RlVmwALEiiTKL
   TnAOkLoYcuyQQ2mw/w9QwFs5gSxJWkImJjrhcMMov5JCDt0KKWD9f6vpn
   0C7laRWIPtMb3leULweh4MNDzq2xOsFv27Q0ZrMzbYbhZyoowS4vmRZG6
   HmgvHARIQCjOUDjXSjqQMC9FaL+pC9fH77pgm5OgpZU13wbiypZSORSp6
   TX5mS8mKAX6YIYtOE2t5PMasQaOdqR881TgcqbRUPWqkZVgZ6kmqBfiDe
   WgjCPQ5xljKIFm7u5zMk6KLBq+upZSOxYps5WRYSCvL+REkiPYW/XATMw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="373675596"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="373675596"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 23:13:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1018846544"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1018846544"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 23:13:22 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 23:13:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 23:13:22 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 23:13:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUIAJkMb9Hmu1wLLMYZM/CS5U5Ly/Y05mXfy9efHo4kUp06Sxhsrm0RRUnw/S6WiM3wMaoYrjEtOLy89fN6H7JcMHP64EZWFaODMzKSu/EA6ZDrX1UViVYeuM5GlZCd2KU4ygqXrNyRNMtvIgebiQbaIIS4Bo4rXvK17D3xGbNyHsWW+jPWcdzEcz8fKEqKKRxK9vsmDSBhfNd5gngPqMi02HJ3M+jMMdPrOiWfG0Ic7DuFSEzRdubIX6Sn5Bvzm47xpe41/SlYNRpAk/8SN3GIVE4tVcz1bJHv7DCG7ekcIMzgH9PJRnQSOKqvC2qdAWeHc7e375gjBlvptLfMn6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ef+riWrPpuevj7x/R+V1g9jZvTOJS+WNMxj3YHsIFfo=;
 b=UBJOnXLsq9WRc6h/gLIYcAncqw6DrRXL2KU/OnNoTbTYyfy8QurpnVMGdZuT/yPaiKVOqG2d7JEw+LfIruxbsPuCM/yKPzAg9LcqEfov1Fo64dPmKlpdvU+5Sa+dPR+cUNH4Cy+MVJGlPYbg1Bi0n8zMIYudBu/593liqj3dmkbnxzxVCJnp8Q+cved7wILsYqRXEC+7pZfXyXcXcvcFEUP1Ry3Jmeq2QPy1a2TcM0rUO5dcdskf2pgMtg8GSjGmVbHko+9RpbtzvkisFB4BWrwso1vR+z8RGoZj2/mknKDX6IayqhANubJbdBKs9wui6huQMH/Pxz0XnG5x0Le8yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by BN9PR11MB5385.namprd11.prod.outlook.com (2603:10b6:408:11a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 07:13:17 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 07:13:17 +0000
Message-ID: <79adaf72-2401-9e95-f760-9d52adfd074c@intel.com>
Date: Thu, 7 Dec 2023 08:12:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [Intel-wired-lan] [PATCH net-next v5 1/3] ethtool: Implement
 ethtool_puts()
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
 <20231206-ethtool_puts_impl-v5-1-5a2528e17bf8@google.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231206-ethtool_puts_impl-v5-1-5a2528e17bf8@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::18) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|BN9PR11MB5385:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb3ea1a-77d6-4605-6e8f-08dbf6f3fbe4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qht9bwj72qOXWRQ1nUbS81Jcx4LiCQVIyMdWCdczYJDKb5R3b1j4BS5zDPG05oWh4OBytxpZHPqPwigicPKqIV5Wbn2reIRg9Id1p1EMFCMCWwGyS4ZYLu98jUkt5b9oQWRrXaFGa00Fl/CLMyybw4xdd3SzZU24H3QB50M1vQuT9Czy82MmybjlQnbcyAk2XVZK405WQGaBww4UPOVhluPEOMk6uSWr7VlpO6lKfgkpKxuA9f/rTA1cvMYugD3g7Wd9r6WGR8PdcU9yKb3Y0hsFcRBql0jDT7C6DofAYUfkuVWcBh/wv/S11O1aJXxgYwXceSc+HxvWmX8SdLB7rwEBofYU7GbHvCpySoDPYXk1f1GCUh44EkgFevF9Q9ccUh7uH5zs1Hk5+GUh71QLWf7iWmhd1qENSNCQ82Me3ReYOE67i7td/Rb0iVx4A9+3YuSpsE9TqG8D8drEBUEhHqlyQVQTAx2T88nETP2dMwrkvt4WJJCiZySs9ibtinBwWwObBdiP5D+R1WXNM9ZwjGLm6uULJiliW/X1CGeBgr/sonRnZF6UCbuif4zdjK2xsbkFwF5JRJR35UNVRcQSGK8SHQf+TTDNrKVOeoarBOcABSDYyNL4gwg6rw1cMEhWg54383R1dISgjlphaqhS+EO6OGd2kSuhQH6yvG81pF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2616005)(31696002)(6512007)(41300700001)(8936002)(1191002)(4326008)(8676002)(82960400001)(26005)(86362001)(6486002)(478600001)(66946007)(110136005)(921008)(66476007)(66556008)(54906003)(316002)(36756003)(6666004)(53546011)(2906002)(7416002)(7406005)(4744005)(5660300002)(7366002)(6506007)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUxCZlExM2FNMWdBWG16UU1zeW1WVktlY1A5TnRFOXpNQUlidGlKU0lQbTNG?=
 =?utf-8?B?THVKYVRodG1NQVJoY1dRY1VQakZ5aHhISzhmd3ZhS0R0LzFrQ3ZmeWd5U0oy?=
 =?utf-8?B?c3c4QzV2U3hKM2lpVDRPM1NEa0txYTZOMXlBZnJucCs4K2MzTERzQjZQVzNz?=
 =?utf-8?B?QVZYMDVJNEJDUWhsRERDTVhHdkdnRTJJS0IwWm9GVk4ya25URmd3MTZmYmRa?=
 =?utf-8?B?dkFyMkc2YU5GMGZRc3djMmdsbEpNdkJENWpPWUVIeTFmbC9FdSs1OWM1SVRp?=
 =?utf-8?B?WUVPcEs5eGt1YWQxRVBUbG1USnN5aG92TFpKWVl4NDBjSFdXU3A2TS91Rk9G?=
 =?utf-8?B?ZGpQZGFPeStJSkZtUkJBMUsyZFFrR0d3YWVjTDExNDY3dXlQZUZIUTJSdEw3?=
 =?utf-8?B?QXJDNW5QN3VKSzBwV2o4eDVvRnYrTmk0Z2JSZ2NhK1V0dWMwRi9tcjZabzRy?=
 =?utf-8?B?TlVRNWRjWUpISzRYZE9DY09LdU1rMVNGNnFPZ3IyV2J3eUQ4cUtOY0Q1VFV4?=
 =?utf-8?B?RFJSb04zbWNWRmJDelVhRDN4Y2dIaHlxSzlzaWhiVnduVXExSnZBZ0FRaE0v?=
 =?utf-8?B?YXczUzZwUWN2bENOb1E4TFgxTkhXbXBWVytDNmFIeWJxUE5PN2gzTHJsQ1pq?=
 =?utf-8?B?MUdrdmpSRzJadzhEWVJBZjZJYU8wNEs0WXNiYkZlaTk4eUNIeUhTOXdOQjlv?=
 =?utf-8?B?QjE2QWRPS3JDbkVzV2lmQXIxeDFVY201UHZ3QitUTXlNSm9oQ3RzRXNaeDZv?=
 =?utf-8?B?Zzd2MW4xU0VtakF0czR4TFZLRHZ2ZkFpRXovekdqckZBTkUrN0xJQUJDb0h1?=
 =?utf-8?B?OXhsaHhySHVGMmdTTWowRjNuZ0pTeWljdnp2alM3MEZ3SjFEYmdsaUFUMCt6?=
 =?utf-8?B?dmVXdWN4am1MZ1JoQzdNRjVHQ1Q4dTdsRTE1RzlnWGFUM1hlNHdlYmFVUk9O?=
 =?utf-8?B?d0M1YzFYMlpDKy9yOVcza0FJU3QyTkkrWVc5N1JYVG9rUkVxdTl4ZEs4QXhI?=
 =?utf-8?B?YTFKdWYzaFEvRHF4Z0NRdk9UdVZ1ZzB1OHpNaGN4ZlJLZHRzYkdFeEFtZGhU?=
 =?utf-8?B?ZGYyRDJMU202dmIrZkRXZWRLNnBaa1g3REtWUUlZVXZzYWNyaDR3N3BiR2Vi?=
 =?utf-8?B?OHQ2R01iRWJ2Z3BKdW5YLzRqTDZOT2owN01LYURZYkRkY2pPTllxb283MWhQ?=
 =?utf-8?B?SUh6cGFSWTcrdjZPWGpJQlZuSGdERExjYnl3ZEdsMzZoRlQyL3dqQkRZdjBC?=
 =?utf-8?B?ejdYaDVaZnBpRkRtVFJqaUY1aytsSkpUY0lyUmRnUXlaYm5jSndKUzR0azFu?=
 =?utf-8?B?WmYxckJJd1psdnJTVzc1TEI3dDlDcXhFd3J4di9MdTlJWGZSa1RicXpOK21h?=
 =?utf-8?B?czBuQnUrR2lWZEM2SGN1RmZFMUdMZGNiayt2Zkd2SXRRTlJVQUE5L2FZUnFG?=
 =?utf-8?B?NndUNENMTnVNVGxqUG9xc2diWWVFc2l1dkRSRFppT0NnZWtzVkRaVTZkK2Zx?=
 =?utf-8?B?RFphYm43RTVYT1FWcjdpNVNtZm9Pb01QYVlzRTJBbXdCRkkvbXBsOGlyT3V4?=
 =?utf-8?B?VGtCUkFIdkdOcnFGRElKY0JvcVlNZTJ2QnVETEUwcTYxbEo0amVSQ3J0RzFX?=
 =?utf-8?B?bk16cGczRzZKY2NldkxzY2orU3dzOTBBZmdlYUxyYkpqbHVEeER3OG5KTFBh?=
 =?utf-8?B?QUhVYXN2THZWV0svNTg0Z3hNZ3V3elNNRy8yNDNqVERuS2FZZWorSkl6UVI3?=
 =?utf-8?B?ZmdwbjNSTldGc1Q0YjlzMG9lTkFGWjdnby81T3NMazJhWmViTFlkZW9ITEZV?=
 =?utf-8?B?WmhJV3Vxa2xIcFFYaDVEWWVUeFNNajcrRWloZVMrYVkwMjl2SjQ1NThod2pC?=
 =?utf-8?B?SEY1MElpUmR4OFE1NSt0NEVkOEZhZU4vZ3BQRzFsSmRmeXNzd2w1eEtrV2F6?=
 =?utf-8?B?aGVpN0V6U05DWExBeE9uUm9nYi9pdFFjb3RGem5DNGhPbGx0VU9aYzBsaGts?=
 =?utf-8?B?bzZqNktQdW03Lyswd1BLRWZLdi9JOGRUTlZFRFZ1dWJDSk5wWklLbkZ4RVBh?=
 =?utf-8?B?YXBidXJHaHc5Vk1XZk5sM0FHYkRoeUFZRlk2RG1INktDdG9ReXU2c3dROVFw?=
 =?utf-8?B?RkdSa2hXTGRjODk5VnFNem9xcjZtTng3ZVYxSlM3TW1sLzlYT3hiL0twS25W?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb3ea1a-77d6-4605-6e8f-08dbf6f3fbe4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 07:13:16.9678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErjUcHtz9LQWqrLi4WbM0osCO+ATADT/kiw99dwpr35AE4AFNh73vBpgP23rCRxyBSEKKoti0Z+M+vtyCaui8Xfc34XIAlc4iMifQrFokkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5385
X-OriginatorOrg: intel.com

On 12/7/23 00:16, justinstitt@google.com wrote:
> Use strscpy() to implement ethtool_puts().
> 
> Functionally the same as ethtool_sprintf() when it's used with two
> arguments or with just "%s" format specifier.
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>   include/linux/ethtool.h | 13 +++++++++++++
>   net/ethtool/ioctl.c     |  7 +++++++
>   2 files changed, 20 insertions(+)
> 


Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

