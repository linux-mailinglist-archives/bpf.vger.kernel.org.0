Return-Path: <bpf+bounces-6579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9422876B8C8
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 17:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A3D1C20F7B
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 15:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAFF1ADD0;
	Tue,  1 Aug 2023 15:39:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464391ADC2;
	Tue,  1 Aug 2023 15:39:37 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2208213E;
	Tue,  1 Aug 2023 08:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690904349; x=1722440349;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5yptCH1vGUPlrA4IjplFCXD6fXpq0LELS3jY1jH61HA=;
  b=G9/0BYHCFy3DcZa0zhevfuplaRMb90XHVZ43ombyf603cEr+EcYmxkXL
   SaZhtdG/w4+9VrM8c2ys67k8tlFN6jzhOLfrEG4oElyx1FiCRg3A/jgEp
   iQZQNeHwd8rFJ2BH3VvvehC+WKZ0wre0E1ABrURsvTp5VuTnZnGYRMSUH
   VBGDeLfxotdOhKL6WzbYiRa+/slmw0rbTc9TzF9QbYwaSqUDR08/NDt/o
   2uizK1cCfF5REURhTmtpJ7IKbGrb51bbmy4+x3o/nfYnv0etSl2JAbD+x
   kzJJn2FL9eWHg2TZ1DlHNqJ9Gcx3/MPq0DkjlyQ7t0ksjU/bl9/45LCvl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="366796661"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="366796661"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 08:38:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="705853595"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="705853595"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 01 Aug 2023 08:38:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 08:38:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 08:38:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 08:38:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfytBdqSd5FZn3/EYPOh5mQ8nT4USItF2qXJvmryG1uKa15qf/S1c3Asw5Q/wauCf6E/iw9XSX0ew3CR7YZnVNZNo5+pV9tdIHDJTDxj6MLC/lUhAOJ7jUCbcVW8hhdZJ2rtLS8V0lgiriAxwu0ClATCgyDZKopIAPIxFMHHG/vYxyqujpT0PzE/6MD7Q6aleBfeY41X1e1lcfnfrjiC0NOjBIkRV/Yc4JEMMrMM46QCmS8eEeMZa94lfxRXW0t2H6LRHPQuz3vOx9PKqWv1sj0pKTlvF4g60tVr2ufBBVMloAve9QMmdPT1IUh58vyTsc0RQB+dPma/xCOwHuS3zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E08xQ+GKW/0z2dQWw5azDzTdYAMDN7RtOBFul1BxZSM=;
 b=PSxBGxapCBCHRPVm17StBkXP3J7aSXdO7HORH7MIuINsWCDmGq7BRVc6CH6af0MJ4A00eFsKhTw6wSALddJmjo9ka4R9E5r8DV+dHRNpPbJcEpn1tDj8f94EzC1ofJlX7cJ7Ry4nBJAPo4qxtdfsGm9+fkxrhCAHfr+RQ4HytcjrFWj3CM/K9Lhh9SgO1R6ksc3KOqWIWIr7D7+Eg9niZP7QNRSeXhlSCDflJawfhzr1IUKRsaIsewwm+LXviuNMkG+nCVh900yMpfdU9y6yY8TLL8n7cttkcparZ6AXreWPFsLtUL34QEB0Yv7wGa0OtzPkE7ENBYen599gz0ktAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DS0PR11MB8052.namprd11.prod.outlook.com (2603:10b6:8:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 15:38:48 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a%7]) with mapi id 15.20.6631.026; Tue, 1 Aug 2023
 15:38:48 +0000
Date: Tue, 1 Aug 2023 17:34:00 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Wei Fang <wei.fang@nxp.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shenwei.wang@nxp.com>, <xiaoning.wang@nxp.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>, <linux-imx@nxp.com>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Message-ID: <ZMkl6HUYMGWXj87P@lincoln>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230731060025.3117343-1-wei.fang@nxp.com>
X-ClientProxiedBy: FR0P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::19) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DS0PR11MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d27663-ce89-450d-7c67-08db92a565ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KK0mTE2PPKaMEvhV184+48RbwwnRUEE4xmwobQCHhtA/zR6LbFf6r1ml9Sg6/BBKket935zQloeYCgrd6Bbm0YEzKU1NsENxkVh41fmk6yeTjiYZ6XBdNFEDcmFzn8II0oP7G7hHFVCQ0b3nylyTZy07uYUCapLB1YfvDlQkM7f5BJCfPwuc+kIK8Yxk8XcTqjOl4ilLpSfopnNS97IDC9A3JvdLDzUPG2XgVWL5Ns1pEvgL0nrQ2wFu5pys+0bKj64vNKXg72suopbYDSvc4A3oQo+ymeFpJaN/Fb/cgPbg1CdBXP8uePheRHIMzi5rTrlZqqJPxz8QPAV/VzUlvCrClEEkC6Z1VI4bhwGzrqNGgAtLfhddqaIaiyk4fvK7fGKMUv62T8/0ciJSoFT/hI21HwUsbdD5bWkbqTpY40aYMmndU834ScHxuCol4s3nSjFrADHZDP2GVjdn4DsLwexHRKjbyc7TdIAjdlWtMYACSgHpBsR+0HcznjYizrjrSH0U0/BUeJPREgnT/JeZYZs4ok8yYsHmZ5hc58lUxR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199021)(66946007)(9686003)(5660300002)(66476007)(66556008)(7416002)(44832011)(41300700001)(316002)(2906002)(6916009)(4326008)(6666004)(478600001)(6486002)(6506007)(8936002)(186003)(26005)(8676002)(83380400001)(38100700002)(82960400001)(33716001)(966005)(6512007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+lIsOz/RKqB1vsUOQvg0DI5ja4tCdNU2LYPRDGdWy9CGqHLEYC423I15sT32?=
 =?us-ascii?Q?/9Xg6KoG6cHOUJDy3h+uLcL//puxiAqlIMX4Jo9rUm/vAr5wyweg7mqWAq29?=
 =?us-ascii?Q?zG0Xa74FDcJ/ZPumKUVWjnpd6zg6PgH0E57futxPjIvhL/WvHnxTfHh6BVMX?=
 =?us-ascii?Q?FnSmjQuOMWfBXaDymTgxUROXENJ7mCdYufbwGJQGQ2zIuCWqVI4f+cvuzoOG?=
 =?us-ascii?Q?KyxSZrLSQkeZwZ4VKQWCYSe9p9/XU+Pmp+ux8y8fDECDKtvjZ3ixjfTSpnls?=
 =?us-ascii?Q?Y1psmCg6rYyQFnJWgeH6F9zmcbIUFZEXLZ43W3YrG4FGhS75Yr2cbPCp3PW6?=
 =?us-ascii?Q?w46Z1vakJDZeRIq6Rf023y6QEd3vTHwkSDzR/WnXixkwp4i14ACz+j0lf8EJ?=
 =?us-ascii?Q?7EhyJRySt6i84XfiZDmbEmqIlYO/idPRMeUfNLPc1eraIQIo5LugYlV7B/bk?=
 =?us-ascii?Q?RoRylw01pn7DZeK28B1fPNDO7cCpF7kwk2tiEyzm4gT4bLfHaUs7a9vowUwn?=
 =?us-ascii?Q?3seJsfAXPRXgtK8G2XrE0f7U2uRProyGn2Hn6VktrM04JTtP6x+Fq/1jDpRN?=
 =?us-ascii?Q?9Brgbpnv5gQYXiyQu/Fv8PJsd8b8tB3VOJGx2TTJF1xIfmWiTqVPxeKtbB36?=
 =?us-ascii?Q?w2Sy/5OtLscGm9BDulULSja4kbkmlI1wC38+CZe/iP1dTXhtfhmJ8Ww1UU7l?=
 =?us-ascii?Q?7tyfSyqupIUPsg8YbELeezU0YeS2i8dnZcJ+Lft4vXrbXosbgm8A7yPYMHhx?=
 =?us-ascii?Q?QB494KLbtLS5ApnFYMAuFr5t0PI6Yqs148x5mlAmvqaDhkUneUDJFUHZsSFB?=
 =?us-ascii?Q?At1v09xQDFZ/yEArlQW+iylx7TqxdHyk1k+Jyl4fSu+yaQx9W3GTbQi+GtC/?=
 =?us-ascii?Q?dRoPwb1O6Pe4IY43KYBMb9TRI+VwMJkkUrRaTa8qTvcX8gpi3zGf+Re8MPzU?=
 =?us-ascii?Q?kxwX8DEVkpp/qtxlDkUV1UeZpkl7dvwM4IZQndRXSKoxKhFhp9xUmhI4VZ5/?=
 =?us-ascii?Q?eiWKpPIEn70jJYBKGo+/rVDgk8XKmOfFhqqQW1jfgK3RdETTHnjyvfJejOmI?=
 =?us-ascii?Q?eHlbLMfNj+5wMMtbwNgeC9kf4/R8Dp5YSh15ZJQE7f1hzvBfw+ydpb23RQh5?=
 =?us-ascii?Q?P8937/HKI8kqg7es5I0MF5f1hs247RZSaVby2O8oxskKmsTOgndk61CEjZCn?=
 =?us-ascii?Q?ilvGqcFxMEZEuxBrxselLFDpxZfSrXF3rHrHula7TScGb2D4GSK9IpVWuPCD?=
 =?us-ascii?Q?BKy4cfqUiDFoFSdlcz7N6fXCeQtjjGfIzp5HS2jlGe+DCMGo2Nlryco76ty2?=
 =?us-ascii?Q?YSinxyoU/bc1cJg0WIlPRoC6AzxVyiOvtZVAx5emfAMsxVhMfDyh45sHMT91?=
 =?us-ascii?Q?Bvu5SYrvdZ0VXm9ZP9thrAczTuM69gcBF3czEHIksV2SU0Z/FZiuAPEJO+Vf?=
 =?us-ascii?Q?KCPurArXmNYlzD7HB3LOBuGOsJNWSztgYU7y3k8o/w1Vq+7Q/IebMgRSX/ND?=
 =?us-ascii?Q?Ivzlz0j2U5OzbHfx6CfsM8HH8G5+n6wO0lfY4ebeC73c2lQI3PAxYtpP+92d?=
 =?us-ascii?Q?OGuJxvEJGfymxkWiW+Ku3SwCAUtgBVtzHrxPrcmOc9nbgbN3+IJ5D6CMVXbD?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d27663-ce89-450d-7c67-08db92a565ef
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 15:38:48.3248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJo7+SJ7JHBRmNN/zct4Br4S3/Qp91rl3guhtGT2iGeNB1gEJuR9RmvTgLt9pfgdzuGssCRYv5FtGgL6hLMSPFrdf3FK3h1uuYtu+WUdEzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8052
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 02:00:25PM +0800, Wei Fang wrote:
> The XDP_TX feature is not supported before, and all the frames
> which are deemed to do XDP_TX action actually do the XDP_DROP
> action. So this patch adds the XDP_TX support to FEC driver.
> 
> I tested the performance of XDP_TX feature in XDP_DRV and XDP_SKB
> modes on i.MX8MM-EVK and i.MX8MP-EVK platforms respectively, and
> the test steps and results are as follows.
> 
> Step 1: Board A connects to the FEC port of the DUT and runs the
> pktgen_sample03_burst_single_flow.sh script to generate and send
> burst traffic to DUT. Note that the length of packet was set to
> 64 bytes and the procotol of packet was UDP in my test scenario.
> 
> Step 2: The DUT runs the xdp2 program to transmit received UDP
> packets back out on the same port where they were received.
> 
> root@imx8mmevk:~# ./xdp2 eth0
> proto 17:     150326 pkt/s
> proto 17:     141920 pkt/s
> proto 17:     147338 pkt/s
> proto 17:     140783 pkt/s
> proto 17:     150400 pkt/s
> proto 17:     134651 pkt/s
> proto 17:     134676 pkt/s
> proto 17:     134959 pkt/s
> proto 17:     148152 pkt/s
> proto 17:     149885 pkt/s
> 
> root@imx8mmevk:~# ./xdp2 -S eth0
> proto 17:     131094 pkt/s
> proto 17:     134691 pkt/s
> proto 17:     138930 pkt/s
> proto 17:     129347 pkt/s
> proto 17:     133050 pkt/s
> proto 17:     132932 pkt/s
> proto 17:     136628 pkt/s
> proto 17:     132964 pkt/s
> proto 17:     131265 pkt/s
> proto 17:     135794 pkt/s
> 
> root@imx8mpevk:~# ./xdp2 eth0
> proto 17:     135817 pkt/s
> proto 17:     142776 pkt/s
> proto 17:     142237 pkt/s
> proto 17:     135673 pkt/s
> proto 17:     139508 pkt/s
> proto 17:     147340 pkt/s
> proto 17:     133329 pkt/s
> proto 17:     141171 pkt/s
> proto 17:     146917 pkt/s
> proto 17:     135488 pkt/s
> 
> root@imx8mpevk:~# ./xdp2 -S eth0
> proto 17:     133150 pkt/s
> proto 17:     133127 pkt/s
> proto 17:     133538 pkt/s
> proto 17:     133094 pkt/s
> proto 17:     133690 pkt/s
> proto 17:     133199 pkt/s
> proto 17:     133905 pkt/s
> proto 17:     132908 pkt/s
> proto 17:     133292 pkt/s
> proto 17:     133511 pkt/s
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

But I thought XDP-related code should go to bpf-next :/
Could somebody clarify this?

> ---
> V2 changes:
> According to Jakub's comments, the V2 patch adds two changes.
> 1. Call txq_trans_cond_update() in fec_enet_xdp_tx_xmit() to avoid
> tx timeout as XDP shares the queues with kernel stack.
> 2. Tx processing shouldn't call any XDP (or page pool) APIs if the
> "budget" is 0.
> 
> V3 changes:
> 1. Remove the second change in V2, because this change has been
> separated into another patch and it has been submmitted to the
> upstream [1].
> [1] https://lore.kernel.org/r/20230725074148.2936402-1-wei.fang@nxp.com
> ---
>  drivers/net/ethernet/freescale/fec.h      |  1 +
>  drivers/net/ethernet/freescale/fec_main.c | 80 ++++++++++++++++++-----
>  2 files changed, 65 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index 8f1edcca96c4..f35445bddc7a 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -547,6 +547,7 @@ enum {
>  enum fec_txbuf_type {
>  	FEC_TXBUF_T_SKB,
>  	FEC_TXBUF_T_XDP_NDO,
> +	FEC_TXBUF_T_XDP_TX,
>  };
>  
>  struct fec_tx_buffer {
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 14d0dc7ba3c9..2068fe95504e 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -75,6 +75,8 @@
>  
>  static void set_multicast_list(struct net_device *ndev);
>  static void fec_enet_itr_coal_set(struct net_device *ndev);
> +static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
> +				struct xdp_buff *xdp);
>  
>  #define DRIVER_NAME	"fec"
>  
> @@ -960,7 +962,8 @@ static void fec_enet_bd_init(struct net_device *dev)
>  					txq->tx_buf[i].skb = NULL;
>  				}
>  			} else {
> -				if (bdp->cbd_bufaddr)
> +				if (bdp->cbd_bufaddr &&
> +				    txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO)
>  					dma_unmap_single(&fep->pdev->dev,
>  							 fec32_to_cpu(bdp->cbd_bufaddr),
>  							 fec16_to_cpu(bdp->cbd_datlen),
> @@ -1423,7 +1426,8 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  				break;
>  
>  			xdpf = txq->tx_buf[index].xdp;
> -			if (bdp->cbd_bufaddr)
> +			if (bdp->cbd_bufaddr &&
> +			    txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO)
>  				dma_unmap_single(&fep->pdev->dev,
>  						 fec32_to_cpu(bdp->cbd_bufaddr),
>  						 fec16_to_cpu(bdp->cbd_datlen),
> @@ -1482,7 +1486,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  			/* Free the sk buffer associated with this last transmit */
>  			dev_kfree_skb_any(skb);
>  		} else {
> -			xdp_return_frame(xdpf);
> +			xdp_return_frame_rx_napi(xdpf);
>  
>  			txq->tx_buf[index].xdp = NULL;
>  			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
> @@ -1573,11 +1577,18 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
>  		}
>  		break;
>  
> -	default:
> -		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
> -		fallthrough;
> -
>  	case XDP_TX:
> +		err = fec_enet_xdp_tx_xmit(fep->netdev, xdp);
> +		if (err) {
> +			ret = FEC_ENET_XDP_CONSUMED;
> +			page = virt_to_head_page(xdp->data);
> +			page_pool_put_page(rxq->page_pool, page, sync, true);
> +		} else {
> +			ret = FEC_ENET_XDP_TX;
> +		}
> +		break;
> +
> +	default:
>  		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
>  		fallthrough;
>  
> @@ -3793,7 +3804,8 @@ fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
>  
>  static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>  				   struct fec_enet_priv_tx_q *txq,
> -				   struct xdp_frame *frame)
> +				   struct xdp_frame *frame,
> +				   bool ndo_xmit)
>  {
>  	unsigned int index, status, estatus;
>  	struct bufdesc *bdp;
> @@ -3813,10 +3825,24 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>  
>  	index = fec_enet_get_bd_index(bdp, &txq->bd);
>  
> -	dma_addr = dma_map_single(&fep->pdev->dev, frame->data,
> -				  frame->len, DMA_TO_DEVICE);
> -	if (dma_mapping_error(&fep->pdev->dev, dma_addr))
> -		return -ENOMEM;
> +	if (ndo_xmit) {
> +		dma_addr = dma_map_single(&fep->pdev->dev, frame->data,
> +					  frame->len, DMA_TO_DEVICE);
> +		if (dma_mapping_error(&fep->pdev->dev, dma_addr))
> +			return -ENOMEM;
> +
> +		txq->tx_buf[index].type = FEC_TXBUF_T_XDP_NDO;
> +	} else {
> +		struct page *page = virt_to_page(frame->data);
> +
> +		dma_addr = page_pool_get_dma_addr(page) + sizeof(*frame) +
> +			   frame->headroom;
> +		dma_sync_single_for_device(&fep->pdev->dev, dma_addr,
> +					   frame->len, DMA_BIDIRECTIONAL);
> +		txq->tx_buf[index].type = FEC_TXBUF_T_XDP_TX;
> +	}
> +
> +	txq->tx_buf[index].xdp = frame;
>  
>  	status |= (BD_ENET_TX_INTR | BD_ENET_TX_LAST);
>  	if (fep->bufdesc_ex)
> @@ -3835,9 +3861,6 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>  		ebdp->cbd_esc = cpu_to_fec32(estatus);
>  	}
>  
> -	txq->tx_buf[index].type = FEC_TXBUF_T_XDP_NDO;
> -	txq->tx_buf[index].xdp = frame;
> -
>  	/* Make sure the updates to rest of the descriptor are performed before
>  	 * transferring ownership.
>  	 */
> @@ -3863,6 +3886,31 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>  	return 0;
>  }
>  
> +static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
> +				struct xdp_buff *xdp)
> +{
> +	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
> +	struct fec_enet_private *fep = netdev_priv(ndev);
> +	struct fec_enet_priv_tx_q *txq;
> +	int cpu = smp_processor_id();
> +	struct netdev_queue *nq;
> +	int queue, ret;
> +
> +	queue = fec_enet_xdp_get_tx_queue(fep, cpu);
> +	txq = fep->tx_queue[queue];
> +	nq = netdev_get_tx_queue(fep->netdev, queue);
> +
> +	__netif_tx_lock(nq, cpu);
> +
> +	/* Avoid tx timeout as XDP shares the queue with kernel stack */
> +	txq_trans_cond_update(nq);
> +	ret = fec_enet_txq_xmit_frame(fep, txq, xdpf, false);
> +
> +	__netif_tx_unlock(nq);
> +
> +	return ret;
> +}
> +
>  static int fec_enet_xdp_xmit(struct net_device *dev,
>  			     int num_frames,
>  			     struct xdp_frame **frames,
> @@ -3885,7 +3933,7 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
>  	/* Avoid tx timeout as XDP shares the queue with kernel stack */
>  	txq_trans_cond_update(nq);
>  	for (i = 0; i < num_frames; i++) {
> -		if (fec_enet_txq_xmit_frame(fep, txq, frames[i]) < 0)
> +		if (fec_enet_txq_xmit_frame(fep, txq, frames[i], true) < 0)
>  			break;
>  		sent_frames++;
>  	}
> -- 
> 2.25.1
> 
> 

