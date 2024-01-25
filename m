Return-Path: <bpf+bounces-20288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C0F83B71E
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 03:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76071F228EA
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 02:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ACF6127;
	Thu, 25 Jan 2024 02:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EagHHiO7"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FB117EF;
	Thu, 25 Jan 2024 02:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706149565; cv=fail; b=MDDf1Z9fJb10AMX+keFp95rt2FgGnBhXFkzdN8ZW56Z4Z2q7TRPcreC8ik8MdbvZm/098ABIhNJrzA9shUbGYfjdNKq9e7SGQDAI4xOD0d3pd/DDfGprRI7wsEMuummIxnKtxDxQGC/gEkpJTgBFi7dkkyXz8MrPjCHsjtw3RPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706149565; c=relaxed/simple;
	bh=/GRnTzhjgov3UsABongNoc9I7jhGF6qHHG6TN5dTHNU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K/xNI9qAIP+ID7Sp0tLB5lLy9Y/Y02xs9ts+MDZHAv+YnI8jkhRHKCq02mU9hmhSee2LE+a2ADzfE44ekMlf0cD7eCkbM2ENpNprX063L5+XR4d/qcrAqCZ+9F/Xe+pNVhG6I8xs+n4vnStUKaPvhD0F4rKRSsfO45ja9/mIg2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EagHHiO7; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISOYSJ8Puvlz+BJKppx29sOC5Mur8pFQVaq0CQfQ/VDS8z66e/RxHkFK9SzT42Dm8kenXSSVp8kTtQo3UtEvIFOkd3rqxl9WGQokbEX+Tp1UpZ+J3cLQ+bBEc94kvfsofiCKBVOexrtPWfD1NLqkKdca9RWbUhnVl6w3jhQ0U3QTu8fRpGKcAEUce2DlLj9Z13wcc0TgPxOXjCAf6u3UGUxvX0DQYhhGrceFGxobQ4Zmws+3vcAZ5jGHIgryPkIPqKis4i4+zv8Qc8d/iENW0PQ9i6mgzOE43kTWcEohBG3F8jiysOWDBxO/Knsly7vG1GLb/ginq/xf5MPKN5KYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lHqZM4kB8DVaNdOn2wTRB7tNdFx3KexC1UxdnRrDy0=;
 b=eFvB5H01/k2qmCfgABaNRPeEZUXiLBlToP0Mp4yHB9ZRizdezUUcaIKScAoAUTKCfH6gSYU+hVmNRtd57scd4iTxReMeKRN33kckmYga1NFgGGqqWb3l6EpdRQvzy/tzNekBdSSS6UMCiJ8+cGBhpxJITI6T7+v+D4RljFsHdejrLtdBATaEBJw8lyidwhDfQDrohq6WdMtlmv/aO5WMjMJ7Ea3HkjRt7hXDDhtxHlRVr85+PXf11lDJ2vuor3aS5DCvROCCGP1Y/muV1IT1ullbUNgzJ7Adh/CmhhneEkq4mzDa5h7chEk4Qafx4FKUqziMMdEUPlG5h3s9u1io+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lHqZM4kB8DVaNdOn2wTRB7tNdFx3KexC1UxdnRrDy0=;
 b=EagHHiO7Pso0xJBmgR8yu6XZTjMftfoyKQkKUj0AWIuucIrlL0lE6cJs0C0J/unKouydDvC4w+DjzzJugLZie+9kvkhQf80awD9T63H9+Rn8znvhyZrQysGQs9o/yERUl9bC/JJFfF6FBa4E0AOAiM/h1xwJzCKgXQPaGWUG6d4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.38; Thu, 25 Jan
 2024 02:26:01 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::e9c7:35dd:23f8:74a1]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::e9c7:35dd:23f8:74a1%4]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 02:26:01 +0000
Message-ID: <f1ce06fd-30da-405e-8082-e35a9a88c5bd@amd.com>
Date: Wed, 24 Jan 2024 18:25:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 bpf 04/11] ice: work on pre-XDP prog frag count
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org,
 echaudro@redhat.com, lorenzo@kernel.org, martin.lau@linux.dev,
 tirthendu.sarkar@intel.com, john.fastabend@gmail.com, horms@kernel.org,
 kuba@kernel.org
References: <20240124191602.566724-1-maciej.fijalkowski@intel.com>
 <20240124191602.566724-5-maciej.fijalkowski@intel.com>
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240124191602.566724-5-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::13) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: 617d5810-b426-4e30-38b9-08dc1d4cf8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z1ikNcNukBkR6nHx9+D90KZ8N74AeTEXSabWvCVxOhWww2uU7c+S0HXIC3XFL0jqFOkP7FNZwezc5Q2qdHsIPTYw/zFVFQl7bw0sFxn1l2NL+kPbd90QRx7y0oaYGgP8IcdaY27IwZSA3mfPqtUMiIO05n6PxgdQ/IEHRlNjBkn+8f0N51zDss/B5wI3aDWEMPJ4ozNUQJtcyAJc+YpIVtb4dffUQdeJf+sosqezohLuIYgzPZ2Kr910eV6OMEATdyUbUGTooeWsQGlj/hfKgpZ2ujapYTF0ocmi+Wba5bf8TB4A9Npq/KK1zGexzeYcSJB2wLQ8v6xsoPCEaIi5qPbF2eOYKcW4bY4jzGNwn/PhGWz1M32pkaN3hc9dQC8+G7750kWqL2O8wIDSBD8iPrN9od2JGuWkfhX2W8NuIQ/dg9qlfHq90nSzdfllE0OOyN/F4XmM4mukJ9DU/GbVZe6Ac9gwomc6DupBXEDrrvjJE+ilg+qzDpDl6woj+RUaj6Dlz2Fu9o9Lz+qvpnZO3FWoQI6jY4stBu5tslv57uoqRP18anKsEkcfxJJlWEvhqgJUlLfcBS9u90DXleVsCmxB/soqWqTSsecunicX9kuofqfaWSqvaUa2XS1+Ik/xsOxObsPKh7xKf963kaaldbFy/yu8Fhev1vZMthaSRtsWNEFUww2Z+JXqBN4f5mAz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(39860400002)(136003)(230173577357003)(230922051799003)(230273577357003)(1800799012)(64100799003)(451199024)(186009)(31686004)(83380400001)(41300700001)(36756003)(31696002)(26005)(6486002)(38100700002)(2616005)(6512007)(4326008)(66946007)(6666004)(6506007)(478600001)(53546011)(66476007)(316002)(66556008)(2906002)(5660300002)(8936002)(7416002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnBpMFBWVFFKbGhBTW5UTHVEaHZCd3UvSlMxMjhkaXlxZUJJVDVlaVJrV3BL?=
 =?utf-8?B?VnNRMWN3VndlR1NDR0xJaDE3THlRdDVlcGZnTDhwMGtwUkVnQnNCOExTMjMx?=
 =?utf-8?B?RmpPdVpXWG9TZ2wyaGhoTlpWV1dIeUxnd0xhZ3c1ak9KMDhxTVR2OVkwb1RI?=
 =?utf-8?B?RWtrZ1M3VlRTOVlrcjJiKzRjRENzdHQxV0NoUFZzVEdCaitJVDh3V0ZueVdq?=
 =?utf-8?B?RHpLYjVkMzFsNmVnL1lidGMxVldKOC9JRjB6TXB4aWdsNlZaWTByU2dLOG5W?=
 =?utf-8?B?RjFqcFBoRDhweHU5UEF1MWdCTWg0NHJqK2thRUUyeHh4eUd3eGVWUUx4NURk?=
 =?utf-8?B?d09ybkl0YlFRbTkyRVQxSnNncTJHSHlMQjV0SnUrNFpMbHFqcXBiamRoRjVN?=
 =?utf-8?B?bnlTdWl6ZVc3aDVER0R3aGNyaU5BTG4rc28zbWRCOGtGK2Jmc3JYWGdmcUhy?=
 =?utf-8?B?T1pnc3M4RitWQ25lRmZ5YTQrRFQ3Y0h6dHNFemVTeEZVZDF5YlN2SklITjBZ?=
 =?utf-8?B?Y0RjcDlWU0E3QklLbW90Wms1bVdFSW1UcENGV3EwRHdScFB0S0ZsNENIRC9N?=
 =?utf-8?B?MEJUZzFma1YwdStVTWorYnB2dURBMW5jaGVhRmFkbFlqbjkrL0p1L3VBTkdV?=
 =?utf-8?B?RmJtWUU4UGREUTQwbWViL2p1YVljWDNTcGVVN2xMUzEyODBUMjBpUEI0R1B1?=
 =?utf-8?B?QzlrdmIxMFpLOGR2dktHdjB5bFRsR1g1RWFocXpzOFBONVJpcHhvTk9JZjB3?=
 =?utf-8?B?TG80cTY4aEJ2bGR6VkpJN085enUvMU9sVkU3TGlwSHlKWHQ2R1JkQ2xoWXZo?=
 =?utf-8?B?Q1o4cHlWbFVhWjZITTUrcWxTcG5SM3djS2puT0hwLzU4YUIwdndpUnZWaXpY?=
 =?utf-8?B?SmRqeWlobkFhNERBOVpGRGR5SGp1VWxjUFc2R1dwM3VZaFE3bG5nTERTZmNQ?=
 =?utf-8?B?cHNZZmRUNWVXL1h6QWRpcWd4R3liRVFnTk81SzJxaEdHaU83OG9mUlJ6K3c3?=
 =?utf-8?B?MkYyRFFVMkxUR082UlVPUmhqdWd0MGprWm5sMVVSTk9taGpFemFSYWNzODdq?=
 =?utf-8?B?UFdISHN1WEwxU2psNmZ3RXJ4ZEJNSmhEYlVzaS92TGpjRmVvbmFnelVEUTNB?=
 =?utf-8?B?ZHZFNWZpcXk2UlM4TzZaYXZxWlAxR1hMMllnNFhRNFZMYVhHSGk1cW12eGl5?=
 =?utf-8?B?MGxuYndZa0ZKSTV0emtKN1U1Q1BRR0NUOU9idk55bkQwSVFmVWtBMWMxUTYr?=
 =?utf-8?B?NXRHRWpwSUEySmwwQVJxckF1NlFjaDNBVVhPTGRNbkRyOWpLNlM0bldzd1Nq?=
 =?utf-8?B?YU5ndldkY2lzT1VRUVhPdUthektSK0tIZ1FnR0xZbkxQN280L29SbHVtUHEr?=
 =?utf-8?B?YmZ0NlRpaTg5T3RaVmpoQ0t0VnMxY2NXc0dpaEExV0FuT29XemI1N0VsbkZF?=
 =?utf-8?B?Smc3MnlFcVRrdW04Mm4vUW50TXVNbm01c2d2S2RQN1BvT3ltMVY4VktJRVV2?=
 =?utf-8?B?NGQza2FpWWk4a0kvNGV6cHdyc2E2Z2Nmd0JJTWdHNVBtaWR4dmxoQkF0L293?=
 =?utf-8?B?MTF4ZVJDbUt4U0plRXgrVHVnTks1WEFaMTdjdERLMklrZEswa0QzTnBkSUZm?=
 =?utf-8?B?QmdWaUJwOFBoendYUXUxQ2pieURuR0NhM2hKb0g5MGx5cGtVNGlCa1IzdUQy?=
 =?utf-8?B?SG1YZmRiUzdERmo5L2ZQOVFoN2tzTUFCcUtyVjVFemZacjZTaW9rUWNBYjNq?=
 =?utf-8?B?dmd2eThyY1Y3enBLY1FmZTBYeENiWENmaCt6R1Yya1E5b1lTN2pNMlhSL2pI?=
 =?utf-8?B?Q3pjdG8wcXhwWENuWnJOWjFta1hLTnJMbEZPSXhkdUdESE0vSFRlT3Y2UU1z?=
 =?utf-8?B?aklVc2ZJMVlQSEYwN0RkOWpybmlXVTZTOFhtK2prTE5Fa0FFbS8rMStsNy83?=
 =?utf-8?B?ZW16c3IyemNJQUJ5V2o5RWVXWmQzRGJjZjNJN1hnZ1d4d29MZkJIYXB3eTIw?=
 =?utf-8?B?SUJLVFZPVXY0R3FDSFhxZy9aZkFpUy9adU1wUTFVeXhiZjVCdGRPUkcxVU0x?=
 =?utf-8?B?UkF4SG8waUJ6ejRKUm44SDhyejg3dHMzeGU5cVVhZWhRZXVUUkdmQ1FXajJX?=
 =?utf-8?Q?5dUUvoZCVtAAXC3htTKwVHg1e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617d5810-b426-4e30-38b9-08dc1d4cf8f2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 02:26:01.2260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbpdWWHEAyvggisQKLs6Vhp2egyQSn7Q4WS3jdrvQ9u6Ggh2k0lXwH/N/6VAkCQdOTx86hgIahxmW69R4Ncyfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225



On 1/24/2024 11:15 AM, Maciej Fijalkowski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Fix an OOM panic in XDP_DRV mode when a XDP program shrinks a
> multi-buffer packet by 4k bytes and then redirects it to an AF_XDP
> socket.
> 
> Since support for handling multi-buffer frames was added to XDP, usage
> of bpf_xdp_adjust_tail() helper within XDP program can free the page
> that given fragment occupies and in turn decrease the fragment count
> within skb_shared_info that is embedded in xdp_buff struct. In current
> ice driver codebase, it can become problematic when page recycling logic
> decides not to reuse the page. In such case, __page_frag_cache_drain()
> is used with ice_rx_buf::pagecnt_bias that was not adjusted after
> refcount of page was changed by XDP prog which in turn does not drain
> the refcount to 0 and page is never freed.
> 
> To address this, let us store the count of frags before the XDP program
> was executed on Rx ring struct. This will be used to compare with
> current frag count from skb_shared_info embedded in xdp_buff. A smaller
> value in the latter indicates that XDP prog freed frag(s). Then, for
> given delta decrement pagecnt_bias for XDP_DROP verdict.
> 
> While at it, let us also handle the EOP frag within
> ice_set_rx_bufs_act() to make our life easier, so all of the adjustments
> needed to be applied against freed frags are performed in the single
> place.
> 
> Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_txrx.c     | 14 ++++++---
>   drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
>   drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 31 +++++++++++++------
>   3 files changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 74d13cc5a3a7..0c9b4aa8a049 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -603,9 +603,7 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>                  ret = ICE_XDP_CONSUMED;
>          }
>   exit:
> -       rx_buf->act = ret;
> -       if (unlikely(xdp_buff_has_frags(xdp)))
> -               ice_set_rx_bufs_act(xdp, rx_ring, ret);
> +       ice_set_rx_bufs_act(xdp, rx_ring, ret);
>   }
> 
>   /**
> @@ -893,14 +891,17 @@ ice_add_xdp_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>          }
> 
>          if (unlikely(sinfo->nr_frags == MAX_SKB_FRAGS)) {
> -               if (unlikely(xdp_buff_has_frags(xdp)))
> -                       ice_set_rx_bufs_act(xdp, rx_ring, ICE_XDP_CONSUMED);
> +               ice_set_rx_bufs_act(xdp, rx_ring, ICE_XDP_CONSUMED);
>                  return -ENOMEM;
>          }
> 
>          __skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++, rx_buf->page,
>                                     rx_buf->page_offset, size);
>          sinfo->xdp_frags_size += size;
> +       /* remember frag count before XDP prog execution; bpf_xdp_adjust_tail()
> +        * can pop off frags but driver has to handle it on its own
> +        */
> +       rx_ring->nr_frags = sinfo->nr_frags;
> 
>          if (page_is_pfmemalloc(rx_buf->page))
>                  xdp_buff_set_frag_pfmemalloc(xdp);
> @@ -1251,6 +1252,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
> 
>                  xdp->data = NULL;
>                  rx_ring->first_desc = ntc;
> +               rx_ring->nr_frags = 0;
>                  continue;
>   construct_skb:
>                  if (likely(ice_ring_uses_build_skb(rx_ring)))
> @@ -1266,10 +1268,12 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>                                                      ICE_XDP_CONSUMED);
>                          xdp->data = NULL;
>                          rx_ring->first_desc = ntc;
> +                       rx_ring->nr_frags = 0;
>                          break;
>                  }
>                  xdp->data = NULL;
>                  rx_ring->first_desc = ntc;
> +               rx_ring->nr_frags = 0;
> 
>                  stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_RXE_S);
>                  if (unlikely(ice_test_staterr(rx_desc->wb.status_error0,
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
> index b3379ff73674..af955b0e5dc5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> @@ -358,6 +358,7 @@ struct ice_rx_ring {
>          struct ice_tx_ring *xdp_ring;
>          struct ice_rx_ring *next;       /* pointer to next ring in q_vector */
>          struct xsk_buff_pool *xsk_pool;
> +       u32 nr_frags;
>          dma_addr_t dma;                 /* physical address of ring */
>          u16 rx_buf_len;
>          u8 dcb_tc;                      /* Traffic class of ring */
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> index 762047508619..afcead4baef4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
> @@ -12,26 +12,39 @@
>    * act: action to store onto Rx buffers related to XDP buffer parts
>    *
>    * Set action that should be taken before putting Rx buffer from first frag
> - * to one before last. Last one is handled by caller of this function as it
> - * is the EOP frag that is currently being processed. This function is
> - * supposed to be called only when XDP buffer contains frags.
> + * to the last.
>    */
>   static inline void
>   ice_set_rx_bufs_act(struct xdp_buff *xdp, const struct ice_rx_ring *rx_ring,
>                      const unsigned int act)
>   {
> -       const struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> -       u32 first = rx_ring->first_desc;
> -       u32 nr_frags = sinfo->nr_frags;
> +       u32 sinfo_frags = xdp_get_shared_info_from_buff(xdp)->nr_frags;
> +       u32 nr_frags = rx_ring->nr_frags + 1;
> +       u32 idx = rx_ring->first_desc;
>          u32 cnt = rx_ring->count;
>          struct ice_rx_buf *buf;
> 
>          for (int i = 0; i < nr_frags; i++) {
> -               buf = &rx_ring->rx_buf[first];
> +               buf = &rx_ring->rx_buf[idx];
>                  buf->act = act;
> 
> -               if (++first == cnt)
> -                       first = 0;
> +               if (++idx == cnt)
> +                       idx = 0;
> +       }
> +
> +       /* adjust pagecnt_bias on frags freed by XDP prog */
> +       if (sinfo_frags < rx_ring->nr_frags && act == ICE_XDP_CONSUMED) {
> +               u32 delta = rx_ring->nr_frags - sinfo_frags;
> +
> +               while (delta) {
> +                       if (idx == 0)
> +                               idx = cnt - 1;
> +                       else
> +                               idx--;
> +                       buf = &rx_ring->rx_buf[idx];
> +                       buf->pagecnt_bias--;
> +                       delta--;
> +               }

Nit, but the function name ice_set_rx_bufs_act() doesn't completely 
align with what it's doing anymore due to the additional pagecnt_bias 
changes.

>          }
>   }
> 
> --
> 2.34.1
> 
> 

