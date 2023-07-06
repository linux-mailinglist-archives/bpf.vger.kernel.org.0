Return-Path: <bpf+bounces-4233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C98F749B49
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 14:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48BFF2811E9
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 12:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0CB8F4E;
	Thu,  6 Jul 2023 12:00:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018637483;
	Thu,  6 Jul 2023 12:00:53 +0000 (UTC)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E16128;
	Thu,  6 Jul 2023 05:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688644851; x=1720180851;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5jlg9gw1eYUJlAY8AdVHSHTChBZ4WQ/7HFnggESrDk8=;
  b=ZtBe4lLt2EIafQZJihqvqebY7V1GPzqMngdwZ7J7my31YLF3nr1hoVH0
   uVHn2XJuJfA+rJgAx156Q8SN67YQMG1cXu1cRy4byjdDC0piyFt4P4IwZ
   J7jV2yXJiMSdOYmAQRJT/BBGNis2ytu3n+kWJRhx8/CFTHRHU3jVc+JzB
   EswISVH8zf3PskctPV3EwI+RqRJluCUTGLVeEbp5L9zl9gYVrWIe7Gr5j
   JFonofBumbesbOyfKINO7xj+h2Y14/Ki1r4f4LEsqWP1QvUHKxEBWbsn1
   uDQuAtN49Lb3vWA/i0/amt1SKWcglPkAqN7DzD4x4c0IRM6exsok6q6Qq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="427263459"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="427263459"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 05:00:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="719558422"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="719558422"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 06 Jul 2023 05:00:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 05:00:49 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 05:00:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 05:00:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 05:00:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu/uOzqY0Cp3abHzDVeIMqEzgXHPof6HrCjWhTXzZTo4heh7UmnksJ/eP85leys6t+svJDJhiHp7NzvdOm3pH8UEIM54sLaI59rwevRPm4HdNzySfa6gHzY7Bqnd6glj3FD1IZlnSxY//RlIysBExfsqS06KLwD0iIXyBZqDsAmUTCskDzVQcpAxsfUPDWRmtu+xooJ4CGOFr/WuJ8cCTkH5MwFJdSY67ihdsuTZwuuUHfOdMrG/3trZYQ/yO2EA2Eb5pRZHKCVFdztgObbcLghnVVsf44Esff1XVxO4bXnf9sUmEgK38VnPch1NJ3erw3kHj81vmG2iezRxsqanNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjGI3ANKy3h4+db/++gd2/1X1vESJ22To1mLQh9QCZA=;
 b=lpfmVn5s6gzOve4Bm8EcjT9DzhWjUOHtsVeFgbDWtL/DImHPk/YIJZW68sgx5QFXonk8jruauO1ydyHL7TRZPFLVeLV8ViJ3Tq8KZhyywcLs8eeVZKCmrLO8yqxGocvE7btvp2thn8drxryup/J9tVQZEzCwDMBuaT5sGbJDhp7NexvjMpZ6RbFDgeG28f1Rav0WRlgaeNujsszKs2bKqQhIzo1Z1Qh+ld05wmzvFPTk+I99c6UEmcoo0w8GW/HZf8vK4M+rKnwzrib38NoQjXKYkTeTlYOOnVsM8BFrkml8o6nV0Rbpweb8T7ODdRd+61Llr0sQV6SpXDFcN1fHOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DM8PR11MB5655.namprd11.prod.outlook.com (2603:10b6:8:28::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:00:46 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:00:46 +0000
Message-ID: <7df8d76c-e177-b06c-20e4-e6aacbea6471@intel.com>
Date: Thu, 6 Jul 2023 13:59:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 net 2/4] net: fec: recycle pages for transmitted XDP
 frames
Content-Language: en-US
To: <wei.fang@nxp.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <shenwei.wang@nxp.com>,
	<xiaoning.wang@nxp.com>, <netdev@vger.kernel.org>, <linux-imx@nxp.com>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20230706081012.2278063-1-wei.fang@nxp.com>
 <20230706081012.2278063-3-wei.fang@nxp.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230706081012.2278063-3-wei.fang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB6PR0301CA0090.eurprd03.prod.outlook.com
 (2603:10a6:6:30::37) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DM8PR11MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 09db7053-9f1f-41bc-73e5-08db7e18a1d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mwqej1/Uaf42y25q6ktHPJuMNiBfd+HsMmnTWYoGWoGqu56CffRhIviFbLhvvFptULOPHvJPzwOOCfs3EKRw12GakmfMXAAP3e+CLDr4g2i4ii4q7x8tXy43YUKPGf9D/TQP/7dck63b7i3o4gu7WC+bOzHm6Z3Ml+mDBt5Szon+SgGHSPQir8iRiVJqo+V2FUo6owA5jTO0LZMsZn3cPhMMRza9Mdf8kuIXNzIALApIVNDSbyZ08eO7WGGKVFgAayCiX2a4+h0Fp+HjHVIspnCybNfjciH1i9gr8uPIdW3xy5nrymMyK2oQHrNj154vgI7wYGBxSfybn97nCFnD4jEBeKN5fQJLsEZwqG3jtdz3wlYaH2GAaYgveklOMU+8+sj/6HvURxVJzUaizoUCk+UIqvfi+wpgcbHPm9Gm0NdIw7VMfvlNe82Jk8JRvF40wvvIuPl15JunLEwO25szJTY9p+G2dDMJGHsgrvcK23EU91q/VyTGo7ZqFo8AZA7LHv7p2+5fTqQd5tfsaDOQfaEPwPkLyyNYENGU7xchkANn/7rOT8sVTONBbGy+o/sB1IYxeGUWU8dJrOvdCM9VzcGXypbyawhsXttR4DwSwTuwFfmJi4Ql9blUdaTAdnrjTTtbvG71h4b7Zw6jF2O9RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(478600001)(6666004)(6486002)(186003)(6506007)(26005)(6512007)(66946007)(2906002)(4326008)(7416002)(41300700001)(8936002)(66556008)(316002)(66476007)(8676002)(5660300002)(6916009)(38100700002)(82960400001)(36756003)(31696002)(86362001)(2616005)(83380400001)(4744005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzlhTk5xeldQQWJnaEhQWEs4Q0ExTHVFNnhYamMxZTlacG9ZTlFQQTMvTHJn?=
 =?utf-8?B?N1R1L1RNSlo1TzJiR0t3TkthWDdhN1NQSm9zTGQxYXA3ajc5Z0hpYldwZzVU?=
 =?utf-8?B?TU5yeU4vLzBncEhXUGdZb3I2a0wxZWZ5U3FDZ200aW5KTFhwSmsvV2RzaEYy?=
 =?utf-8?B?dmhLUmoxek5SZnhHZXNkbGI3dnhDRnlhSFpSYzlpbUF6d2JCc2duV2thTys2?=
 =?utf-8?B?U3BXeE12QXVSS09uZlZ0dno5dG1Kb3RURklNVjhocFNscUthRlU4WjRnVDhn?=
 =?utf-8?B?VFpWNlE2RTJQcGFOTkVaTTZUcXNDQXJYSWJZeGV1OVZSR0FiOXovc3hNdkgr?=
 =?utf-8?B?MFRWTkV1RHpyVThIWGVFTVhoRHEwMnVmd2o0dklXYnhYeTc1Rm1jbm1VTCtr?=
 =?utf-8?B?MkxuSE5XdkxXWHFMb0Z4YWs3SnhnSXY0UExzbEhxZUhXd1NyQkU5bGc3bjFq?=
 =?utf-8?B?UGtXN2NRRUFpOFFBNFdKNi85SjI3YzMwMzhtVUlvRDZEczBRanVobXVpcVIz?=
 =?utf-8?B?SStnbTFGYnZabGttT0dRYXJzc3dKM3lUTTlLcEdpNitpTC9nNlMwTkk4OHE5?=
 =?utf-8?B?NXlFZWtXcTNiTDVsSHcwSlNJdmRMU2V4Y1dDbWdhWUV5ZWxTVTdHdHJzWE1m?=
 =?utf-8?B?cFdZWEV6Y3VLcE5ycWkyS2Vma2lMTkJISUE2UmEvRVNDSzREb3ZreS92eHE3?=
 =?utf-8?B?M3NtZkJBMmh5YUd0bXJvODczY1RXYk1xS3laS0JUMysyOFByNFlhcnRSOWdJ?=
 =?utf-8?B?bkU2b3NPMjhCUlBPa01JQWc1OExYc2tSTk1pU2ovYzNKVzFwaG5YbmRkYTZM?=
 =?utf-8?B?ZUZJakVhRWtEUDg4cHVGQzRtSW9VOUFrMldVUDVJU2ZXdnFtbTVLNTdMN1FE?=
 =?utf-8?B?UGpIbldacDhYNmZMbWhPNlE0WFhrUEg3OHBmS3RiWXdFbVZmMzNHUVdjQ0tE?=
 =?utf-8?B?OXRzTUYrTHpTTFJvVnIyK0xmVWRKZGxTdnlLK3NxWjdwN2g3OUszWE1saktY?=
 =?utf-8?B?ZXFTbnNCdHhUZTREeTJ1RjFOU0lSQW05TVN6bEUycWZUN21TbmpmSk5XSE52?=
 =?utf-8?B?dFBncEVoQWhXcDlyMUl3ejQ4dTczTjI4WXBTMENBSTNFMkpSeG91YUhWZXUx?=
 =?utf-8?B?YWZvT0lSdGZ5UjNlS0ZXRy9CS0luOUxJTThYQ085WXozcWlEWUxweTZtRHJD?=
 =?utf-8?B?OS81MnRXTDh6UXIxcmc1VDhJVHl2ZkU3ZlBUek9ZUGZvaDBKL0JFblBDK0Zx?=
 =?utf-8?B?THQ1S3NQTC9JcmNmdHpGeWFWQ0F4UjJYTTdFMllKTGhSOThHQ2xJZUNWelVT?=
 =?utf-8?B?NmZOc3FTOFk4VHRoSjRZY0hjUW13NCtpVUYxM09VMk56dFJvMDhDWGxzSFY4?=
 =?utf-8?B?SFY5R3QrNUtPUFpmSmE4aHFLcFkvUDR6a01kRi9zSGZSUzZEUjE3VXYvemxv?=
 =?utf-8?B?ZTRZbU1tODhuNmkrMTlBUG5GQUkwKzkvaGNSOXBrSkZ6R0tETmZKNzdhSEtz?=
 =?utf-8?B?NWVZNkVCNThRQkZGVHpyOTVDTzB5RDJid1FzZ085c0k4SUkvSDhzckhSWTVl?=
 =?utf-8?B?MXU2NFpqL1Bza2pnMkRndnFhWFRnNXQ5K051MXpLMkUzb3NCUzlUcmVaWUIw?=
 =?utf-8?B?Yi9DaVU4a0NIUHJuWEFkSnNlRDRvNXArR2xDazBJV1YxaGE3MWl1akZkTVlS?=
 =?utf-8?B?L1k5RzBwbGJFUFFKbis5Vkk0NXlERTcxN2R1d3V2c202NnVVOFg3ZzhqWUFR?=
 =?utf-8?B?SG9OTURPNkloNlNkVkJzVGwrNzloRjZPem5mYzBvRWg4SWlLSnQvOC9QT1Zk?=
 =?utf-8?B?Rkd2WklxM3g5djAwSVl4aGptcm5QS3dWK1pLTkN3ODJzcFFnNytpVlA5aXFG?=
 =?utf-8?B?UzROUzdYZUFKRjNCcE1DTFdYS052V0xwTi9NUjhnSjhFUjM5V0dQQWl0ZWJ0?=
 =?utf-8?B?aUtmZ3JqWUtLNTVFQWVtUkdXSUtFU3Z0cDBqQVJjTHJiRkVYZ2pOUWdCN0ho?=
 =?utf-8?B?M0FrQ0lVZWVlejBMM2dReGFjSUF4WFFQZkpmeXRGaU9seTNVWW1PU1FPL0hH?=
 =?utf-8?B?STVpNmlQTUZRbjZnL1h4T01IRFdicjcvZWQ0ZkxpbnBPUnNsQ1lJMUxDbkFk?=
 =?utf-8?B?NHZaYzJaY3R2UkFrWWlGOFByZUViTkRrNkY3aitETzRmZGw4L2xMQlNqVXhN?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09db7053-9f1f-41bc-73e5-08db7e18a1d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:00:46.4267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHJbEm4Mbk2YlZsYE+KBs4crQklWSJaGN+72ZHFoEeDERVOcerNVhMvTBMTk+GwDKBN3dzpdeAYtFl2+AJriSyp6eRJW5YR0Pr+mA2KpNUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5655
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wei Fang <wei.fang@nxp.com>
Date: Thu,  6 Jul 2023 16:10:10 +0800

> From: Wei Fang <wei.fang@nxp.com>
> 
> Once the XDP frames have been successfully transmitted through the
> ndo_xdp_xmit() interface, it's the driver responsibility to free
> the frames so that the page_pool can recycle the pages and reuse
> them. However, this action is not implemented in the fec driver.
> This leads to a user-visible problem that the console will print
> the following warning log.

[...]

> +				if (txq->tx_buf[i].xdp) {
> +					xdp_return_frame(txq->tx_buf[i].xdp);
> +					txq->tx_buf[i].xdp = NULL;
> +				}
> +
> +				/* restore default tx buffer type: FEC_TXBUF_T_SKB */
> +				txq->tx_buf[i].type = FEC_TXBUF_T_SKB;

Here and in the related places below: maybe set ::type dynamically when
sending to either SKB or XDP instead of setting it only for XDP and then
restoring each time?

>  			}
> +
>  			bdp->cbd_bufaddr = cpu_to_fec32(0);
>  			bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
>  		}
[...]

Thanks,
Olek

