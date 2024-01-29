Return-Path: <bpf+bounces-20560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBB3840380
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 12:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623141C21EE3
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 11:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8906F5B5C9;
	Mon, 29 Jan 2024 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIIthtML"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355DE605AC;
	Mon, 29 Jan 2024 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526486; cv=fail; b=rWe3Bl9nObrM6GEXOT2oH6rrF3kTbjUcXNIz7vDrFTNNclk2/gstCGPs14QaSfX5F2t13gvIr9GqLOGq0Vb4Y6hYzpiVuVPbfDy7lBOZ+bzDBULS5mPta48PfNJu96oEFnA6wmmG3BJrV4dfl2FUuqpQQm9Dwh/nQjhIBglda/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526486; c=relaxed/simple;
	bh=U2R8uWD23yFuueWH/FM/DkUIfPqP6Kqlwp3krifQ9Gw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ixdk2WY1RcqKZPhdDn8USYZHRWI6YFK3MWKlFtfVFzvU4+0dGChwFVtio0pnu+kaz2WxNOY/RW7GH3LdFkYXWp51brQwR+LV/uHhk/mPJpRB1C0byWLhIMIgV0DmoBQNdnpvF2SOZvdEDao3un5UxDsbzfhanighodCEhi7L64c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIIthtML; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706526484; x=1738062484;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U2R8uWD23yFuueWH/FM/DkUIfPqP6Kqlwp3krifQ9Gw=;
  b=FIIthtMLiPcm7wNfYHWsZTZdzqrEKQHAjlgY8U//cPS5ffT/240LkA8/
   vT8IlPVnbTxWRNmggPTJWWpCzJB+NtGWy2tSMvLVFCaRL0Fdf+LfZCg2n
   CXuF2SD+6vCRG8wEK5sqO+8qJAK+PHhkFDUxxJkQPFsVXIMSoFiucMUm5
   2oA7hZFwp8JVOodiGGHU904D3dMsdwQVLVKh2gYuWwrea5yyR2AQMgdvU
   i+hqkxayvlrP7HuV611LYz+gQeR8SvafPvDVTKEfm2SFbeo49W6BhO+qV
   gK8umwVTsvc8Hpau0gYaEPHqalRtz+Ev9IxaGlW5pbJ65uwKTwlZ4ZqXu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="9666326"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="9666326"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 03:08:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="29747839"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 03:08:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 03:08:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 03:08:02 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 03:08:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSX4qQuVyC4LvOc2RUFWsx/WRkXPtke4ibeCiF7nttFpNzqJPxNmxVTDNKsTdsTwpO5PFJT3uahO83Cbt+XRv9BjVxIJQlzCZVlmWoEkI0e7dti7HuPyoO6zHlCb0A2lhGRj9f5clFw2Gb4NBk3r4QKe01Nll9FgauVGvhBKvjjeUKnSKkjhqGbmTR9mfgsGRLAhVhXJCiHSZzhLacNetrC1GgsrleOuntz/mRdGR8T7BkJCcT4YjbWPQhm4zynD5jlMkBXucEoXPqd+ayJInlDlasNarNS8W2TQCOJvUdXOT0l9xYU06cCPWxytse1JhHF1vo9bQvpA51rUhWMSTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPLQRTAtjRnjMGCVNNmBL4lezZVpGOUnEzA5uJH77cc=;
 b=hNfbbG0GyP0jbe9Aq+ksenIZV8VOK0KeLP4zA9RHquqpp1nTthKiL752I1Fyh2hqyhC1ZiGs6q6SoWGLBivCYSykPa+CLP+AkyYofyUcmpXYkT8HwUXbaty5X5VssPEdRiteWdgds1pSxhbpNX4Qr1FP+PLazucBKxnpUXffgEG6t1gGvOEpRFH+2TXv7CIYmVFbg3nCkc87N9cd7xPHGYITwtLs1Z/1MkHv2Mst9bGjaOM7cL+/wUGKXYVviYx3h3UcZvlLUABCsuweBvNSIm7ihFUgrKGlK/iZM54/EA8B0laV651511nDFgywefefMVzIt/oNT4JCYjbG7fhejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY5PR11MB6414.namprd11.prod.outlook.com (2603:10b6:930:36::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 11:08:00 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769%6]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 11:08:00 +0000
Message-ID: <4e23d103-ea1c-4fd3-852e-f7e2ec9170ad@intel.com>
Date: Mon, 29 Jan 2024 12:07:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/7] dma: compile-out DMA sync op calls when not
 used
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Alexander Duyck
	<alexanderduyck@fb.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240126135456.704351-1-aleksander.lobakin@intel.com>
 <20240126135456.704351-2-aleksander.lobakin@intel.com>
 <20240129061136.GD19258@lst.de>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20240129061136.GD19258@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::10) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY5PR11MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7ab5a1-07e0-4c7b-7898-08dc20ba8e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hpMyeuM2ANyOKU9dlqcfHx0MjWHMwZTrlgzfcedRc0qhr9MKBaiyHU+adBH9w7bmKt84yzgy1JpDhQ3ETrHIAkqz5Fa4hLdEJGSBOcO0jRVOyEu5Avwt/6hlEJip+dyOP1Vdiv4SSQf73UAEDxog31gRx3NT82jhugDho3fukHA0ykySzvkaKO329SmZ9pa1xwN92H9hQnLyNJkD5r5NqSXqB4IJJxAD0poH2goSa1+Gf8UvGHXxORn0B+EAeivTijS63JuESPQlETAPekfMH1Z3XcVF3gJxj+5YqiQEM9AGNqGBkiYgObv6sCPya5OMf7Zi7rVE67C/z201a8jj+uVrwDUw4n1QwBNVYJR2QpUS09BNm0s3G8i59v572v6kpC/ap3SRBtm5S4KfQA5tutz1QDbsxtbkEQyMIxsfodg92RZP7R391x8fRK7TQ/D2YtWGsJpNgD16vxsSCnzZs16/FgTL40lLoh4/vkUqzq4PlIW+juzwf/Vau40ffOaxtal/XasTu/R2Jx5YKJjJvcmL7R9ATspMt1gxS3a8oBGWDdufVcu4xijC58ZhFYdmq+Ob5ZF3lXDe0RIkK7cMLwRt4ioCFOa+y+9C7PUR8UNslWxDlbjLWZtZ1swmYJjlJiTqni0BbIfriZpaa+ArqibworX1nwy9Qoqfa4rAwlGTeg/HC//UWDrw6odu7z0G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(366004)(376002)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2616005)(6506007)(6512007)(8676002)(26005)(41300700001)(4326008)(6916009)(7416002)(5660300002)(8936002)(36756003)(2906002)(316002)(54906003)(66476007)(66556008)(66946007)(86362001)(31696002)(6666004)(478600001)(6486002)(82960400001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cllLSXdSTkFuMlljYS9NbVJMQ0lPTEltSDJPZThnTXI0SmJFTGFmNzlZT0FE?=
 =?utf-8?B?Y3dUblV1MVd1Tkh2dThONFd1UGJCeU80eFFzcEx0bEJiNnNJczBKQXdrY21q?=
 =?utf-8?B?MG9OUTRKZTVPeC9FNVhwclFSVDcrL2ZMdTI3ZEcwcVJlb2RsNXBJQnpaWWZD?=
 =?utf-8?B?VUpOb0RVSzQrVExKRHRUemJWak1sQTA2TStNMnY0ZzdmdWVlWVJZVUh0S0c3?=
 =?utf-8?B?WWxkWmZGWlRFWmFXZ0hhanQxdEZKTWJqMDVqcTZPQ2ZFMGtMajRFcExzUi9L?=
 =?utf-8?B?WDZuVERlQ2hvWDRaUW1RakZ6ZHNJNk4zM0NoaXZFQVpONkJBOHFZUTFxRTZx?=
 =?utf-8?B?Znl6ZHdFTUQ2RktuVEx3TjFWcHNCUGtmRDJmZzl5QUJuOHdKZTRNc0ZJU1hz?=
 =?utf-8?B?bXNuQnZ5cnYzS2kvNlV2Qk5tZjlkSE0ydGhrbTNWUkFUZSthN0ZqdnU4bG5C?=
 =?utf-8?B?UVgwTmQ1dmhGZld5RFhWUVhMNHNsYnZDcGpwMjRNdkhqZzFGVUd5TitBVlBW?=
 =?utf-8?B?WlNzNEx4dGRGekhaVlJiejZyejEzMXpSdHl0NEpIYmhJd3piM3d3ZzNCRHFH?=
 =?utf-8?B?eDhzSUNIVnVpeWZDS2pnOFVXZVRpZUtHQ1lEMVpQNEd2NVVPci9JMjBWMDJI?=
 =?utf-8?B?UUE3bStPRFlTSFFORXZJUUdDNVFxSDB5Nmw1a0ZBUXBEdnNONWIyUTU5MkI5?=
 =?utf-8?B?NGZXcGo1aHpGRTlQNmxHU3FsVVRkMmJpOWFWZXk3MmpXRWF6MW5IODgwNG1H?=
 =?utf-8?B?MlhJQjFFQWdnWE9TUjlaN09UTXNKdllnQVRHU2NzOGl6eHRDWG83OEdDdWh4?=
 =?utf-8?B?eXIvYTNQSmRZVFNUblVncTlEeEs3d2xjcFRHVkxxM0FMYmdGSWVDVHdlNWF3?=
 =?utf-8?B?dlRUblJSWU5jSnBUQ1NjOHUraTAyWXNjQVpldjVZUWs3cHpMdXVXc1VXWnRL?=
 =?utf-8?B?UEJYT003Y2ZmM1FseXpzaExqVTZTY1RIYjJOazU2WFBYWFA1ZjdMUUh0MVZQ?=
 =?utf-8?B?dk5MSVFqUm1SYVFIbzBkM2pPWGJhSk0zbGk3WU5WTndLYnd1alIvSlNlZzZD?=
 =?utf-8?B?a2hiSDN1aFVxUTQ0bmxPbmtVS0xSRnBsbUpGaFBvTktEQ0s1YlVyWElNRE52?=
 =?utf-8?B?Mk1Sa0VJZHM3Y01yZnFZcHYzdGhqWkE2S0ZRMlVLY2FDem1TQys5U013L3dw?=
 =?utf-8?B?Z2Z2ZWtydk5BWEh0ekFrTDNhY2VoQU10ZEVHdkdUWGcxaWQ2dmhTdGViTTEz?=
 =?utf-8?B?R0kvNjh0NWhLeVgyVnFEOGY2T21Od2prbUIvR0E2UXVVcGcrZ3R2bll2N2tk?=
 =?utf-8?B?YUpKWTBHNkpuQzRKRWNYSzJPQWlVVU5Na1AwcnR1eVB5Um9DdTcwc0o3VjQ1?=
 =?utf-8?B?YmxiRFdWUU90RzVDWktQeEFZWTEyWUsxaFJHYU9uejZRTC9lSlNXOS9udTF4?=
 =?utf-8?B?YUlBMGFtZDJBSGJ5Sy8vUDRWMWxRbE9vR3ZjMVVSdERBclBjR3ZXWGthUzkv?=
 =?utf-8?B?bUEvbmljTXlia3FKSVlmeTBXVG9VQ3k0Y3lUZm10NEJISnZhY1A1UyswYzN6?=
 =?utf-8?B?ejVSaGJmRmpjVjRwdUN0bGUxRitKNEM4L0VGay84d2s3MnRqSFp2endGKzRM?=
 =?utf-8?B?NEFqdjJrWGVVSnBqSVV2K1JjTXRWMTMwZWpTaFNUYUpEcU8zRFRJRWlDOG0x?=
 =?utf-8?B?bmFIdTNVZVFwN3UyRDRNY3ZIUW85VHJrU2RyTkUvNWRLSkZmQklKdXNwM2Nw?=
 =?utf-8?B?b0tKSk9BSzBleEZJYU1TU24zMFViWHZRNm42SVY0U2N2bGRHL1JBUkFPMlpP?=
 =?utf-8?B?ZzhrUC9aL0lsTGQrU2ZwdW9ZQVpBc0JaSHM4U21Qb1VORVhOYmVIcEg4RU5u?=
 =?utf-8?B?eU1ZV29IY0FlZkRSL21EaXA3cXlGUUltNjRpSXl0SzdNY1NqVzJoWVVZWDBy?=
 =?utf-8?B?RFkrMFhwaU5kSkJRYVVSMDN6UkQwcHJlN1BqQ3dDUHFReG5kN3RzT0NjeWZk?=
 =?utf-8?B?K0NRQ2J2SzdscjJHblZhK3ZwK3UySStqKzFHc0p4OUM2R1VTdVk1NEsyTUZO?=
 =?utf-8?B?ZktxNTlRYlZldmZOQ1c0djdFWGtZa3BXN00vUTREa1U4UTRmdjVzR0k4WWhx?=
 =?utf-8?B?VWc0Y0E5TDJjVUxUL3dETEVBZ3BpR3Vwc0UzeEE5Z1l1cHZZTUdsRkZ6RFI1?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7ab5a1-07e0-4c7b-7898-08dc20ba8e5e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 11:08:00.6540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhKlG2hOLtb7r4toNNyFvhp3Fog0AMEgYbc0wX7DgUfMB8A5afeJnmAgMIc0k6ty5dFam8O6uuk/mlxeWyE0e0Kw2cBsG90NSGqAkvZXiOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6414
X-OriginatorOrg: intel.com

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 29 Jan 2024 07:11:36 +0100

> On Fri, Jan 26, 2024 at 02:54:50PM +0100, Alexander Lobakin wrote:
>> Some platforms do have DMA, but DMA there is always direct and coherent.
>> Currently, even on such platforms DMA sync operations are compiled and
>> called.
>> Add a new hidden Kconfig symbol, DMA_NEED_SYNC, and set it only when
>> either sync operations are needed or there is DMA ops or swiotlb
>> enabled. Set dma_need_sync() and dma_skip_sync() (stub for now)
>> depending on this symbol state and don't call sync ops when
>> dma_skip_sync() is true.
>> The change allows for future optimizations of DMA sync calls depending
>> on compile-time or runtime conditions.
> 
> So the idea of compiling out the calls sounds fine to me.  But what
> is the point of the extra indirection through the __-prefixed calls?

Because dma_sync_* ops are external functions, not inlines, and in the
next patch I'm adding a check there.

> 
> And if we need that (please document it in the commit log), please
> make the wrappers proper inline functions and not macros.

Thanks,
Olek

