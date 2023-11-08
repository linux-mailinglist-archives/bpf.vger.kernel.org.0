Return-Path: <bpf+bounces-14515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4967F7E58FE
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 15:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F9D281654
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 14:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E26F2A1A2;
	Wed,  8 Nov 2023 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NV6Zj27B"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2C02A1A1;
	Wed,  8 Nov 2023 14:30:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369D61FD0;
	Wed,  8 Nov 2023 06:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699453859; x=1730989859;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MPEB4LdjBfyCPBNA6Uf6ywj9LolqiBOdlB9OW1SRGPw=;
  b=NV6Zj27BCcDJSip5enyXRyUX+In5kJIuiPXHCOUGeh0fwnClnHXg/bde
   GP3E3odGop7+Rd9FM6y0PBOYASn5iesvAOAfi1VG84rhcy6bOkg66vIwx
   izps0AHXhSKcs/Qh4o4Mj6SW+JvP91ArX7HIb+nqwyUCjLhtb6EUb9sTI
   pXEWYpQucGfLD2aKMm9QOIEcrjzXMGV8K6v9BmGH3AuRtH3DlpvsUGhY8
   cBzwtnts9TKKxbNj2FQwDjg2CC72AjQ2UQaaxRXMrZb3erpZsmgEbWteB
   bstjJVnY4uImq8Kvs41iByHzfgbDeeUT8OtU59ZquzdTinbZnuKXLdEpS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="380170061"
X-IronPort-AV: E=Sophos;i="6.03,286,1694761200"; 
   d="scan'208";a="380170061"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 06:30:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="798015164"
X-IronPort-AV: E=Sophos;i="6.03,286,1694761200"; 
   d="scan'208";a="798015164"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2023 06:30:58 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 06:30:58 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 06:30:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 06:30:57 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 06:30:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCH53unvQQa5epesU0Dq3fRcYSl27rbh4kRVBXGtn8iTECJtCplKngMilCn2crShm2Yr9bBZBvuw7Ml2fievbqmH+AKNalKool/fBwoO1RAgrq+1f5MZkSsZcVXqBSfn/MWZywPrAbkRxSzJPZyQVJFgNrGI4N7w9A7w0IqEU8PWPJrEiDchVZ80nn1ozYxgGKj9YM1xiqG/jgV+D8mshScwXPV5N6k3Ry2DgvClEcZgobuoI3zp9GXsaOD9i+xNDCH1Yd0t40cvLOwMnTHl6KlmE9KL5/gpve51IJNuHD3zAY0BzR9UBu0xfsZKRqgOiIOyzTXO18iJhToN2RQagw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BR6oxOSRnYlSjyaTj4YcDHVTwK3WQ59Q9LIAgd5p1hI=;
 b=MWG8Z8cAf+JP0dmNerWN62UlzvftC83gPpDON50PemqbGzLld9f2zAwnQGLTax8FS3phis6yJ5yssnkJNpnxt2llpUPL8f5iOvOtOq6RooEkKylViN4DueYcBz29xQojUMf3l6jhl7gj9a4l0bCrn+Bpe7G2lSVT8i5O+QGLgEuGkXfsS3eUHEiiRe41ueIUj8Hx2YOZvqLlLe04l6ywwamayE3R1y822jGuKsfSUP+2+BSyvGJUU3Dnf5Tx7bTsVnhOEYKNrMLZlTrhMCenFVwqHq+HxOopx2wzH3v9KDIxg+gJwYZPZKb15WcD4tdlE8zaVOVrjMACvNePAtI35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CYYPR11MB8408.namprd11.prod.outlook.com (2603:10b6:930:b9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Wed, 8 Nov 2023 14:30:55 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%6]) with mapi id 15.20.6954.029; Wed, 8 Nov 2023
 14:30:54 +0000
Date: Wed, 8 Nov 2023 15:30:43 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>
Subject: Re: [PATCH bpf-next] selftests/xsk: fix for SEND_RECEIVE_UNALIGNED
 test.
Message-ID: <ZUubk1lZ6WDDV2k+@boxer>
References: <20231103142936.393654-1-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231103142936.393654-1-tushar.vyavahare@intel.com>
X-ClientProxiedBy: FR4P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CYYPR11MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cbfa565-9e69-484a-9e1f-08dbe06750df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /LxwFo5WquhTipva/gtIuohJDVZfAYTThBTaCSHjM8F+kEq2lj8z9n2mZYVVRhJoDrlYseu6gelLJHMLk5Iim7P6UOs+cRs7x1G4DEh32tltD+/o8BZDRevceM3Z0CsBwDM3SLly4HDksDeRT4zWIX4wBUIkJZkUA34uq2CcjXM0gk+Pg7uFQ5P1G/t43lEOSCP5jSMcl68W+keJ8hCjFPEwPpcYnyAWm9TVwtDH1bKmemC0vAZAK1DEpOQC5alC9e28lHOGcViGg7EiZA7gZzEDbCVVISOTVYm430uIfaDna67foLzNHG2WC9qxn+y18gfd3OHkXSAJPwcXVLGdUXN/B99ovCAb+o1SmVwpm5at7u6x/WWCT/oTNGVUXsb3vJ/w7+nyf3h3QCs8NenJHIf4erLVKEUVU8rcg+/2A5LRz9vcieNvc8lyh+oLI/DHw/VsRyOZ61zNU8qze2NAgg84ZehamtqZSSpzFXQsUw9WZ7sk3W8AkWM37+XHDeiv0FrWVkPOuBwFpTExzkAtyARG87J6Y6rVXknt5vdE9gjALf7dDcoKBHrz5TK7MCi3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(44832011)(6512007)(9686003)(6636002)(316002)(66946007)(41300700001)(66556008)(6486002)(66476007)(6666004)(6862004)(8676002)(478600001)(8936002)(6506007)(4326008)(5660300002)(107886003)(2906002)(83380400001)(82960400001)(26005)(86362001)(33716001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u2u2WFEpy1z4BJ//n+P5CUCzsbNhfdhk73/MUBTHXmi77NH0HXRWuNV9mIoc?=
 =?us-ascii?Q?utUnnYojMYPIZ6oxGxiBWp9vgtrmtN8iSar9IeyXK5vqsUjVf2ZTo/RJz3R7?=
 =?us-ascii?Q?nt7wBdLKtzzJKGJsKHieyZD/gThZF529TEP+nEBQLvh2642liEQ2ecEk5c2C?=
 =?us-ascii?Q?tDX++Q6L8maHo5P5RPIFQ2RWUgB3Iad/4/3bxcyXqJy5d2sNxMgKvTiNKCmg?=
 =?us-ascii?Q?7hBRtCLO/T0EVlugT52CyDjMQ7RMzhwVlRgRqet18H/aF6woHTcxJKVrn1Rp?=
 =?us-ascii?Q?ji9Qezdn35Q8uR/6omSTGUdShl3fBu67x+nf5hRKmeOWIKgDMyooDDDe/m/G?=
 =?us-ascii?Q?WbYzqygeCcn/RFMDgpqrIeAQVkEhogmLefLqkv4P8jaFeZpzT9i0oV7WV/ma?=
 =?us-ascii?Q?Jpi4qX/Nq+vGjhwYCMdJDcJ9Pexq5k0USkyo/ioI9iL+Ir9PlBwnlY8XeZa6?=
 =?us-ascii?Q?76Xq5+hLmZxDnRHgQJykFrUSHO+Lz6M1kNxENj9kxTaMnf1pv6AOevMYHmuj?=
 =?us-ascii?Q?HaKAh1/4/2i8K+ET28vv/6al7y5a3bRwD9le7xta7BczNBS7djI8bB+4obuy?=
 =?us-ascii?Q?Sx3/us7jZYJvAcoyO+YgC4Krbhe7+s2faS8SdH3mDwMdMmmyZlGamdtdc8nU?=
 =?us-ascii?Q?czK9YJ6niaEhD7vlIqJY5ZYc/XSRhhkdsuZADoffFBHVmZuH+xtmwleA7X4D?=
 =?us-ascii?Q?Cvduv7BfslucxGQOlMqgu/zIAEFHqyF/4UigrnNa2Ca4a/Kw0ANs2VV1ciGh?=
 =?us-ascii?Q?CcsMkpYBPnHJ4GCfRk5J/KqWcIdcyeLkRJBxtlsJElKfagZie6MwJFgKRRZs?=
 =?us-ascii?Q?VP/g9WhOFS77xr+0vHPzcTSMSIuNKy9BFuSxEN3kviKBV2Q8u+gGqlqgUzj/?=
 =?us-ascii?Q?qjda/0hdYpHTF7A3YjZQyhzYfae89WAWjICdpssc11jW1G673MqSato/txdY?=
 =?us-ascii?Q?ZwD/Hj6LgCIF6nyIIrSGIjouIC/Fqh6wnsRP4x5i825LEpZh5NVQ23oZ4c7Q?=
 =?us-ascii?Q?ok8BaUI5lh1sc+1FgYjBwhubuBG/oK4JJDd8DLUluUubD5/4yp5wly3ZW/B+?=
 =?us-ascii?Q?pSFEH7nDSBT/frgf5cSZS6ZF69JAE/D6Ty2SUTccwN1dArnjiPG2vwJUacdH?=
 =?us-ascii?Q?52t9p8fXYvifZErQIu5dLn9qibtC1upAZcHP6iljp5O61hc7WE+eiFFb8eUD?=
 =?us-ascii?Q?RYHCGUG3QjlqlP4pU9oD+OStTq4ZHQIgDrfbK9mtsmB/AG3SYRobPt85cueD?=
 =?us-ascii?Q?GnVDjJiwNtryVBx6wZmDF48RnAyVUR3n96b+tStK8TE/0Px6V74h4HaarpDS?=
 =?us-ascii?Q?RsGz+B0NTbdiU5ugJqlta9TM9AZ4MLVYp0Pjkrv3HHuKd+hJSy8Vsyi7O/KQ?=
 =?us-ascii?Q?ccBiqS/zD5N8LBiuo9qZIgFr5z9cwc6cVxF9VHoq9X/i7H79xLAc2wXNOmYN?=
 =?us-ascii?Q?W8mLIXp1BMETI+V098Y7ASOjzMsjEJiylAGrGXaNgl2a/7BApk0XGTPwIBq+?=
 =?us-ascii?Q?9oTFNTUitzD/U2HF/mN9YZuo1LabkdTx3+IuVnnyWnSfcbCvATYSXzmG58Mx?=
 =?us-ascii?Q?OBF/ez73SJ/QBBvjG7D+jEhMJfPvq50HUFe2eM+4vecuqSb/2Hnv+M/ZnXhI?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbfa565-9e69-484a-9e1f-08dbe06750df
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 14:30:54.8504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXPM+rxwx4UDhPolQ9r5PomkP7r7vqockW3ndafe5nh+jztCzfjGvlpDfAqnRfBJh8ZlNMxU9XaElVMGoa6m/EmfZyH7XJGoGgWPt0pbnNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8408
X-OriginatorOrg: intel.com

On Fri, Nov 03, 2023 at 02:29:36PM +0000, Tushar Vyavahare wrote:
> Fix test broken by shared umem test and framework enhancement commit.
> 
> Correct the current implementation of pkt_stream_replace_half() by
> ensuring that nb_valid_entries are not set to half, as this is not true
> for all the tests.

Please be more specific - so what is the expected value for
nb_valid_entries for unaligned mode test then, if not the half?

> 
> Create a new function called pkt_modify() that allows for packet
> modification to meet specific requirements while ensuring the accurate
> maintenance of the valid packet count to prevent inconsistencies in packet
> tracking.
> 
> Fixes: 6d198a89c004 ("selftests/xsk: Add a test for shared umem feature")
> Reported-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 71 ++++++++++++++++--------
>  1 file changed, 47 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 591ca9637b23..f7d3a4a9013f 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -634,16 +634,35 @@ static u32 pkt_nb_frags(u32 frame_size, struct pkt_stream *pkt_stream, struct pk
>  	return nb_frags;
>  }
>  
> -static void pkt_set(struct pkt_stream *pkt_stream, struct pkt *pkt, int offset, u32 len)
> +static bool pkt_valid(bool unaligned_mode, int offset, u32 len)

kinda confusing to have is_pkt_valid() and pkt_valid() functions...
maybe name this as set_pkt_valid() ? doesn't help much but anyways.

> +{
> +	if (len > MAX_ETH_JUMBO_SIZE || (!unaligned_mode && offset < 0))
> +		return false;
> +
> +	return true;
> +}
> +
> +static void pkt_set(struct pkt_stream *pkt_stream, struct xsk_umem_info *umem, struct pkt *pkt,
> +		    int offset, u32 len)

How about adding a bool unaligned to pkt_stream instead of passing whole
xsk_umem_info to pkt_set - wouldn't this make the diff smaller?

>  {
>  	pkt->offset = offset;
>  	pkt->len = len;
> -	if (len > MAX_ETH_JUMBO_SIZE) {
> -		pkt->valid = false;
> -	} else {
> -		pkt->valid = true;
> +
> +	pkt->valid = pkt_valid(umem->unaligned_mode, offset, len);
> +	if (pkt->valid)
>  		pkt_stream->nb_valid_entries++;
> -	}
> +}
> +
> +static void pkt_modify(struct pkt_stream *pkt_stream, struct xsk_umem_info *umem, struct pkt *pkt,
> +		       int offset, u32 len)
> +{
> +	bool mod_valid;
> +
> +	pkt->offset = offset;
> +	pkt->len = len;
> +	mod_valid  = pkt_valid(umem->unaligned_mode, offset, len);

double space

> +	pkt_stream->nb_valid_entries += mod_valid - pkt->valid;
> +	pkt->valid = mod_valid;
>  }
>  
>  static u32 pkt_get_buffer_len(struct xsk_umem_info *umem, u32 len)
> @@ -651,7 +670,8 @@ static u32 pkt_get_buffer_len(struct xsk_umem_info *umem, u32 len)
>  	return ceil_u32(len, umem->frame_size) * umem->frame_size;
>  }
>  
> -static struct pkt_stream *__pkt_stream_generate(u32 nb_pkts, u32 pkt_len, u32 nb_start, u32 nb_off)
> +static struct pkt_stream *__pkt_stream_generate(struct xsk_umem_info *umem, u32 nb_pkts,
> +						u32 pkt_len, u32 nb_start, u32 nb_off)
>  {
>  	struct pkt_stream *pkt_stream;
>  	u32 i;
> @@ -665,30 +685,31 @@ static struct pkt_stream *__pkt_stream_generate(u32 nb_pkts, u32 pkt_len, u32 nb
>  	for (i = 0; i < nb_pkts; i++) {
>  		struct pkt *pkt = &pkt_stream->pkts[i];
>  
> -		pkt_set(pkt_stream, pkt, 0, pkt_len);
> +		pkt_set(pkt_stream, umem, pkt, 0, pkt_len);
>  		pkt->pkt_nb = nb_start + i * nb_off;
>  	}
>  
>  	return pkt_stream;
>  }
>  
> -static struct pkt_stream *pkt_stream_generate(u32 nb_pkts, u32 pkt_len)
> +static struct pkt_stream *pkt_stream_generate(struct xsk_umem_info *umem, u32 nb_pkts, u32 pkt_len)
>  {
> -	return __pkt_stream_generate(nb_pkts, pkt_len, 0, 1);
> +	return __pkt_stream_generate(umem, nb_pkts, pkt_len, 0, 1);
>  }
>  
> -static struct pkt_stream *pkt_stream_clone(struct pkt_stream *pkt_stream)
> +static struct pkt_stream *pkt_stream_clone(struct pkt_stream *pkt_stream,
> +					   struct xsk_umem_info *umem)
>  {
> -	return pkt_stream_generate(pkt_stream->nb_pkts, pkt_stream->pkts[0].len);
> +	return pkt_stream_generate(umem, pkt_stream->nb_pkts, pkt_stream->pkts[0].len);
>  }
>  
>  static void pkt_stream_replace(struct test_spec *test, u32 nb_pkts, u32 pkt_len)
>  {
>  	struct pkt_stream *pkt_stream;
>  
> -	pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
> +	pkt_stream = pkt_stream_generate(test->ifobj_rx->umem, nb_pkts, pkt_len);
>  	test->ifobj_tx->xsk->pkt_stream = pkt_stream;
> -	pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
> +	pkt_stream = pkt_stream_generate(test->ifobj_tx->umem, nb_pkts, pkt_len);
>  	test->ifobj_rx->xsk->pkt_stream = pkt_stream;
>  }
>  
> @@ -698,12 +719,11 @@ static void __pkt_stream_replace_half(struct ifobject *ifobj, u32 pkt_len,
>  	struct pkt_stream *pkt_stream;
>  	u32 i;
>  
> -	pkt_stream = pkt_stream_clone(ifobj->xsk->pkt_stream);
> +	pkt_stream = pkt_stream_clone(ifobj->xsk->pkt_stream, ifobj->umem);
>  	for (i = 1; i < ifobj->xsk->pkt_stream->nb_pkts; i += 2)
> -		pkt_set(pkt_stream, &pkt_stream->pkts[i], offset, pkt_len);
> +		pkt_modify(pkt_stream, ifobj->umem, &pkt_stream->pkts[i], offset, pkt_len);
>  
>  	ifobj->xsk->pkt_stream = pkt_stream;
> -	pkt_stream->nb_valid_entries /= 2;
>  }
>  
>  static void pkt_stream_replace_half(struct test_spec *test, u32 pkt_len, int offset)
> @@ -715,9 +735,10 @@ static void pkt_stream_replace_half(struct test_spec *test, u32 pkt_len, int off
>  static void pkt_stream_receive_half(struct test_spec *test)
>  {
>  	struct pkt_stream *pkt_stream = test->ifobj_tx->xsk->pkt_stream;
> +	struct xsk_umem_info *umem = test->ifobj_rx->umem;
>  	u32 i;
>  
> -	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(pkt_stream->nb_pkts,
> +	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(umem, pkt_stream->nb_pkts,
>  							      pkt_stream->pkts[0].len);
>  	pkt_stream = test->ifobj_rx->xsk->pkt_stream;
>  	for (i = 1; i < pkt_stream->nb_pkts; i += 2)
> @@ -733,12 +754,12 @@ static void pkt_stream_even_odd_sequence(struct test_spec *test)
>  
>  	for (i = 0; i < test->nb_sockets; i++) {
>  		pkt_stream = test->ifobj_tx->xsk_arr[i].pkt_stream;
> -		pkt_stream = __pkt_stream_generate(pkt_stream->nb_pkts / 2,
> +		pkt_stream = __pkt_stream_generate(test->ifobj_tx->umem, pkt_stream->nb_pkts / 2,
>  						   pkt_stream->pkts[0].len, i, 2);
>  		test->ifobj_tx->xsk_arr[i].pkt_stream = pkt_stream;
>  
>  		pkt_stream = test->ifobj_rx->xsk_arr[i].pkt_stream;
> -		pkt_stream = __pkt_stream_generate(pkt_stream->nb_pkts / 2,
> +		pkt_stream = __pkt_stream_generate(test->ifobj_rx->umem, pkt_stream->nb_pkts / 2,
>  						   pkt_stream->pkts[0].len, i, 2);
>  		test->ifobj_rx->xsk_arr[i].pkt_stream = pkt_stream;
>  	}
> @@ -1961,7 +1982,8 @@ static int testapp_stats_tx_invalid_descs(struct test_spec *test)
>  static int testapp_stats_rx_full(struct test_spec *test)
>  {
>  	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
> -	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
> +	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(test->ifobj_rx->umem,
> +							      DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
>  
>  	test->ifobj_rx->xsk->rxqsize = DEFAULT_UMEM_BUFFERS;
>  	test->ifobj_rx->release_rx = false;
> @@ -1972,7 +1994,8 @@ static int testapp_stats_rx_full(struct test_spec *test)
>  static int testapp_stats_fill_empty(struct test_spec *test)
>  {
>  	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
> -	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
> +	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(test->ifobj_rx->umem,
> +							      DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
>  
>  	test->ifobj_rx->use_fill_ring = false;
>  	test->ifobj_rx->validation_func = validate_fill_empty;
> @@ -2526,8 +2549,8 @@ int main(int argc, char **argv)
>  	init_iface(ifobj_tx, worker_testapp_validate_tx);
>  
>  	test_spec_init(&test, ifobj_tx, ifobj_rx, 0, &tests[0]);
> -	tx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
> -	rx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
> +	tx_pkt_stream_default = pkt_stream_generate(ifobj_tx->umem, DEFAULT_PKT_CNT, MIN_PKT_SIZE);
> +	rx_pkt_stream_default = pkt_stream_generate(ifobj_rx->umem, DEFAULT_PKT_CNT, MIN_PKT_SIZE);
>  	if (!tx_pkt_stream_default || !rx_pkt_stream_default)
>  		exit_with_error(ENOMEM);
>  	test.tx_pkt_stream_default = tx_pkt_stream_default;
> -- 
> 2.34.1
> 

