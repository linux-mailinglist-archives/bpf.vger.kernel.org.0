Return-Path: <bpf+bounces-17825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B314813154
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 14:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266E62831D2
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 13:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9572C55C39;
	Thu, 14 Dec 2023 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kazLAdeG"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581FCB9;
	Thu, 14 Dec 2023 05:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702560208; x=1734096208;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KrO46T/FJChGQLq6w+uu7BIdmYdx65+PzqJzW9LgLQo=;
  b=kazLAdeGPDFej3PnzKUTjkeSdrFCQqTGY7XcV8TaV1OwR5S1CCET6NSp
   /LoyyZwaczsIOZgoBvetxc9l9fiawrnhC22QIc6TwwUDrAw0zRffmPGvF
   Azmko2vVFsBrWyWjt3mHtNNp1UtHmaU1YqrpQmKISA1MWv0YnTQWwvwqk
   B3M+2a02sCqfrCYtfIhylUUMRt5lKjoKd6BEaMNnmPqm7EtxK9R0Ln1zt
   c/2yEZcHw7vqdLHDWmJ7+0J6rRsSo32LLDYFgifN/UJ0yflBM5owwJ5um
   GR/YOkERVwaJo48oBX2X7ZDjusVfsdsvTaAOKOzAuAMjRo/NX4DPTZDyg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="394863670"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="394863670"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 05:23:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="774365160"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="774365160"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 05:23:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 05:23:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 05:23:26 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 05:23:26 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 05:23:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrnGwcZU+7O5YR3vMDsiene7smmkLu561o5Xtt5oEaIcELTkSuQeE9jRUZ8RiEYY6KNZfnWiQF2MUJytHTV5RVtwOuK5ltIIhUYZ7pfbDRcmuKVX8YNwgdCR/Vi5PKiwHBmRRf09qEcsmJpHx7NUrFaxcIA/ushkI7NO7t7gW2KUbj+eZHfbq+X8e9QsnIMRAZpxGrx3HaHrd8gWxzuvMVCtUX+hdkywl5H23xohzCKQp/o29ys2sr8D6BOC6sxlOSAYaRsFexUPKLFJTdYm334b37KDiDNb5Rh6SAP5v318lVMK1RKmY2WtQEtQ81WD+Gt5JqbGxR0ux7C8v3wOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZq5LgB9LMVZ0YsXwiPk3nkGt82azpksbJe3fTGx9NY=;
 b=k4w46U27ID10K4PUf0kqRY8z5Qgm9LVAF+PDyE+Qea4Dom0e8l55dJ44peoGVe5Ge4Ti7gKoBbEmaeZc6LBXGdQ6yPrkebGz8WUUzQTG9yRcV5hfsPwxPrym3wXEf6CA+xUGVdzBG7lIT0+jl9tcGxUdk82gH6UzFlw7xHWQ1oCoIh2yFcZ6W4PhS0QSRyOn95JeVhDnEvTL5WeP9OeQxslupGnkGx6u3AY5XQcOQi4YuukPNNgMCda3S7+VHSR8ko6fRbhobKewF4NXTwv8cqEPS4CevUukfmVTLoTPhBDCLM7Fv3A/TaN0+RmeSm477mwdQPBD4GAiNNIFbl4kLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB8200.namprd11.prod.outlook.com (2603:10b6:208:454::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.28; Thu, 14 Dec 2023 13:23:24 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:23:24 +0000
Date: Thu, 14 Dec 2023 14:23:19 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>
Subject: Re: [PATCH bpf-next v2] selftests/xsk: fix for
 SEND_RECEIVE_UNALIGNED test
Message-ID: <ZXsBx31uOqyrfDvD@boxer>
References: <20231214130007.33281-1-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231214130007.33281-1-tushar.vyavahare@intel.com>
X-ClientProxiedBy: WA1P291CA0009.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::20) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: da6f1d38-c49c-483c-3b5c-08dbfca7d9c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9k0hu2xxEtt4FL3tVVB8ZAVHSZBzFBgPk5eBfXtjimkDZUY2IJkj/FmfZZQyv67yaj1faUO2ZMvu6kMXg40XuQEqL5G2Lmr967PUU5JiFJhxcbFyxu2z2mRyr9lUcZTosdjMO9E0XChzJ4blEeLif+JHhu+w7e5460uuizA5oOQiPUbtzZ3qc88GEOyhu4QE63oI/I74mmSGqXEZPKCOserOzXPyImxAVyPITT5tSixkWAT9gPKESwMojZczTOphAIWdwGu20HW+6dpawGuznXip8ABvYFPNZcvCnruVGAW5QBNc0OdWK7FiRESOgOCdbqXvWXFf/4zYou7+5R8w4Yz8nQQaVPTF0T9EjC4MUWmkqnBIHBGzDU+PAhmKN9R9BH6qXwpQ024dMFZwk2HN+bds4tBOPNsENmcKqDvAC8V8a8oS50386o0gTaMJ5Ss6k+ohnYsY2qJ1sVxBIBtpbhHWF9B5XPGm4Jjy3Vo9ifZytRRWi2AhaScBK3a2Ztvkd3qqr85Y7orw20MmZ+l2I/cbPXNpfavAvn2no+x2KhdMTsVu7yY8ftPxjElrtssg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(136003)(376002)(346002)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(5660300002)(26005)(107886003)(83380400001)(44832011)(6486002)(2906002)(478600001)(316002)(6636002)(41300700001)(66946007)(66476007)(66556008)(6862004)(4326008)(8676002)(33716001)(9686003)(6506007)(6512007)(6666004)(8936002)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MB/IFtnE18LxucSG8/ogG3uug0hUl+cD7VbIHl7Zdp8RAjysXd/f1PWX2vLE?=
 =?us-ascii?Q?MhQpaynRD1A1Ao+jWxILF2cJ3soooVkVCSQnzErCzvnRl5naGnuB5hfoI+wD?=
 =?us-ascii?Q?KVdaFcAKmlILgLBw0QSUkYvj7yuED0BohFPUT+PFshOmXw6RwwKo+Wkhtjt1?=
 =?us-ascii?Q?I8u2T0OOjqlMv7E7bICdsvbFPPaVQbTr/jyHM1euJnLWrhXx6jBAuRUKu2lg?=
 =?us-ascii?Q?xOEcZRBcK4dkWoODSZwbNxLHVoh58fmGWF5tYyONB+XCl/A62rvrjsfPJ/XY?=
 =?us-ascii?Q?0JNlEFcx3RiyTV9acDl1lGO6qUxNbblP9Y5Da/y0krvLdq10VxEfviHqH/5d?=
 =?us-ascii?Q?HeR4MECNrGYkm6WP37gAJVZYm3Myr2jl4vteT3C1NxIC6vAGYJssfzJX6/Am?=
 =?us-ascii?Q?Z+OV0Y23/qtBffzWT74N/zykHKWIraQ1DQgrdiTawNASu7HHzOqyk589aQ7X?=
 =?us-ascii?Q?zg3IfLah2uk9B/DTjkXYU9tEXLsusBmMPhbhKf2UUlCGD0zxLufHgjmeax7c?=
 =?us-ascii?Q?HudCrlIOv4Zrt+CrJt+9LzS55jsxyUHJOMj0hy3Cv4PCbeX60KoJ5r9Co8qE?=
 =?us-ascii?Q?3Kv3lAA2FeUwszx4yNHAJlrG2c4ohVpU4AdNAuurFv3TGxBRaZcxK15uUB33?=
 =?us-ascii?Q?YDrU0IUYXBwFkOcXkoZRsZFQ39AbLNT5WERoxqQ4I+WZzvu2th+NGWf8IG1t?=
 =?us-ascii?Q?kviRhSSPetcBTRWEI6nNzvbFwmww7MRLnAYiPdAq9MMDC43WyzTrNVXo+5NO?=
 =?us-ascii?Q?ekYc4zPI+Zl2ARTixWhfpNrOWagzFREthQTR51RFz1PEExbCXPBHIRMP3/Sr?=
 =?us-ascii?Q?9nK44hJKpWbVWrOPaHchjn83G4ZoCv9YMfFmx9AbeuUwieyX941UvLoXapQ1?=
 =?us-ascii?Q?McwDPdddn/cXRamQrELArsXl/ISo8RcViYu1VuXEG8CNA/h5wnDPUBtYPzVP?=
 =?us-ascii?Q?WPhfKaYZrbiL0ol1p0yIgQbYL4nMRsNgMHim9UW2EoEA+KAVV8jVgUb/bQcX?=
 =?us-ascii?Q?nA0/sgZEXPm/O6V/aakqqlat2GbaU4FI+5vmGjP9hIoVDRXxvqIxL29H74Vp?=
 =?us-ascii?Q?voD8pgKJ3+qDbl6XFYAcl++sA7ICrBCZ4k9uhHWed5ex3EOVyH8/CEpxqeuZ?=
 =?us-ascii?Q?Yie+jYrmkbBsqcqmkB5WDMoIk5AZKQj8JUSilJTueIt6aSlc5hV7DklmSf8x?=
 =?us-ascii?Q?kpIV07COSJq+R6SdS/GVtMtKgnfNakr211YEXLrGp7ZHZcznLI8nwRe87prA?=
 =?us-ascii?Q?yM82s5EoT15aVCmCA7u9XvmXg+htYdzlQRRrxWlyO9Uy8/+RHPlB1T9Qr0wH?=
 =?us-ascii?Q?KWZ3EaHC6wILwHoLsQbHvtUbUjQBoBzpmM/2rtp1/Ayy4YAV7WGD++Qzo1+S?=
 =?us-ascii?Q?FPH/ERzHs7sESaNm4M0fOEtRXnLnv5zKJwkqFTmVPmYVjF8L2SJHPOeiK9uC?=
 =?us-ascii?Q?zbsAoYESmRrYv2xFQkN7zc1VuFEpC0qVqmMPEznrBDLXDRAS+tzqeq8+xal0?=
 =?us-ascii?Q?Ho3KK2mlOazXYLAhspczrWFtUKe4pKyFLlxkHDZKehbo9sBZC96GeXUbetPf?=
 =?us-ascii?Q?EB5ZV5Lk6iI0OJjqwgc1rIMsJ/ivd5A+/qX/ygpF/cd+MLDbXrl8m3HT2SxJ?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da6f1d38-c49c-483c-3b5c-08dbfca7d9c2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:23:24.7405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4zKt2ln9cP6Ii7G2LGcOLSYHL26ha+tB0lvEsb2h/VTUG0ZNAQdAT4wmUGcmuHqNZcedBBls5Blh0VPYcp9Ex9g6eUJu+S6QWKuXEQYjjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8200
X-OriginatorOrg: intel.com

On Thu, Dec 14, 2023 at 01:00:07PM +0000, Tushar Vyavahare wrote:

I think target tree should be bpf, not bpf-next

> Fix test broken by shared umem test and framework enhancement commit.
> 
> Correct the current implementation of pkt_stream_replace_half() by
> ensuring that nb_valid_entries are not set to half, as this is not true
> for all the tests. Ensure that the expected value for valid_entries for
> the SEND_RECEIVE_UNALIGNED test equals the total number of packets sent,
> which is 4096.
> 
> Create a new function called pkt_stream_pkt_set() that allows for packet
> modification to meet specific requirements while ensuring the accurate
> maintenance of the valid packet count to prevent inconsistencies in packet
> tracking.
> 
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Fixes: 6d198a89c004 ("selftests/xsk: Add a test for shared umem feature")
> Reported-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

besides subject fix,

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> 
> ---
> v1->v2
> - Updated git commit message for better clarity as suggested in the
>   review. [Maciej]
> - Renamed pkt_valid() to set_pkt_valid() for better clarity. [Maciej]
> - Fixed double space issue. [Maciej]
> - Included Magnus's acknowledgement.
> - Remove the redundant part from the set_pkt_valid() if condition.
>   [Maciej]
> - remove pkt_modify().
> - added pkt_stream_pkt_set(). [Magnus]
> - renamed mod_valid to prev_pkt_valid. [Tirtha]
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 25 +++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index b604c570309a..b1102ee13faa 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -634,16 +634,24 @@ static u32 pkt_nb_frags(u32 frame_size, struct pkt_stream *pkt_stream, struct pk
>  	return nb_frags;
>  }
>  
> +static bool set_pkt_valid(int offset, u32 len)
> +{
> +	return len <= MAX_ETH_JUMBO_SIZE;
> +}
> +
>  static void pkt_set(struct pkt_stream *pkt_stream, struct pkt *pkt, int offset, u32 len)
>  {
>  	pkt->offset = offset;
>  	pkt->len = len;
> -	if (len > MAX_ETH_JUMBO_SIZE) {
> -		pkt->valid = false;
> -	} else {
> -		pkt->valid = true;
> -		pkt_stream->nb_valid_entries++;
> -	}
> +	pkt->valid = set_pkt_valid(offset, len);
> +}
> +
> +static void pkt_stream_pkt_set(struct pkt_stream *pkt_stream, struct pkt *pkt, int offset, u32 len)
> +{
> +	bool prev_pkt_valid = pkt->valid;
> +
> +	pkt_set(pkt_stream, pkt, offset, len);
> +	pkt_stream->nb_valid_entries += pkt->valid - prev_pkt_valid;
>  }
>  
>  static u32 pkt_get_buffer_len(struct xsk_umem_info *umem, u32 len)
> @@ -665,7 +673,7 @@ static struct pkt_stream *__pkt_stream_generate(u32 nb_pkts, u32 pkt_len, u32 nb
>  	for (i = 0; i < nb_pkts; i++) {
>  		struct pkt *pkt = &pkt_stream->pkts[i];
>  
> -		pkt_set(pkt_stream, pkt, 0, pkt_len);
> +		pkt_stream_pkt_set(pkt_stream, pkt, 0, pkt_len);
>  		pkt->pkt_nb = nb_start + i * nb_off;
>  	}
>  
> @@ -700,10 +708,9 @@ static void __pkt_stream_replace_half(struct ifobject *ifobj, u32 pkt_len,
>  
>  	pkt_stream = pkt_stream_clone(ifobj->xsk->pkt_stream);
>  	for (i = 1; i < ifobj->xsk->pkt_stream->nb_pkts; i += 2)
> -		pkt_set(pkt_stream, &pkt_stream->pkts[i], offset, pkt_len);
> +		pkt_stream_pkt_set(pkt_stream, &pkt_stream->pkts[i], offset, pkt_len);
>  
>  	ifobj->xsk->pkt_stream = pkt_stream;
> -	pkt_stream->nb_valid_entries /= 2;
>  }
>  
>  static void pkt_stream_replace_half(struct test_spec *test, u32 pkt_len, int offset)
> -- 
> 2.34.1
> 

