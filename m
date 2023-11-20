Return-Path: <bpf+bounces-15351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F06B7F13AD
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 13:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A914B1F24257
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 12:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E44815AED;
	Mon, 20 Nov 2023 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ma8gzAf9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5776129
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 04:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700484107; x=1732020107;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=M2BIMNcoqnd1pRJ2mAIvhcHZo+6QQmaKErTgP70xf+0=;
  b=Ma8gzAf9JtIX/8HWOcupCuwDyNl8bsrwji9eEWr25Cqy6WuoPpiMoESD
   XppZTYlWnjn0s13/9UtRslFHKEQOO2d6pFR0HnpDIfF3ItJjhxFVK5bnP
   HZx+97LUswN/g77YnxnJvJy6Qj+FmXuObIdTtVGR8b8R+whCpYsXYNLQg
   HxuwdDB29rWgFWjdRY9N6KTaettvZ3ZANTntwe9+CPIQk8NJ8u84auX/m
   sea5WDNkl1GBmsX2rKD6PqIhwcvbskl1U6fy+9qxdyek/mFC9W3oSv2NY
   fjpAvZfptGAX1DpKCieLi3qLFLMYlfkxbDT7McQ/t25KK88CZQyTSYPX3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="376646731"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="376646731"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 04:41:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="1013575158"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="1013575158"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 04:41:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 04:41:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 04:41:45 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 04:41:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2qIVX4rxH8qby/GTJkutt54XkLY1k03juZpaVvazJC43UDRGPpaVCmv7NuvqJb7xNldElO1jxzbYG/KsBn+0IwmOYL6T4k8KHMWKtT0eR+NNcbDRT7Obg8tUWaQmHgO7AViQ5czS7rzHZNwo0IThE04racOD5E2ailVdXUH08NchrSEsefGhiTIGsUoBryMO+tXjbV3lE8tmGk3rgmPjdvpDKTBR71GGCYQYEBJIsXbZO1965TXJt9NXEPc0WdxF6b9HJLBN7kqD2KYE1CM6H7eBZaB090Zb/1W/i3lEupcQmDKHw9N8UelbI9aJ5P5fXXip3gxvgWfxrJ6sTCDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfEPxQnH1Hi5n1IfnN6XuLBRak89W+OHVU0k7c20+zY=;
 b=e5x9Jhtnm2ql3eosXldt4Jf3e7Hl2jIT7oR3uRBQwBKZETvGodaAMjN07i6S8lziOEoUJlDBHMQvq56H6t0hcaMdu4AXcYjcDkrW1j5yZA9D3yRqsB4ya1l/l/UwRn1bxIpbEfNcwAQl1oL3uyGwjNEOX5dbhBQExGeTzr3NrsLHRSoTRM9fK50MoBShkvimSk/GffKEK1j5tm1psVR6hbUV41SQfVMyiiNdSrL27sbD9is/NlD4Ff5+QnU+RkHUyDQC0oCcbqY5gosX0y/JuY3qmOJGJrS/4KSS0nlTnVoqvAvNyotEk4mJQDQDpN0VyXumUd4ouoXZ7+hcMRenxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA2PR11MB5212.namprd11.prod.outlook.com (2603:10b6:806:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 12:41:43 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 12:41:42 +0000
Date: Mon, 20 Nov 2023 13:41:37 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Leon Hwang <hffilwlqm@gmail.com>, bpf <bpf@vger.kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>,
	"Ilya Leoshkevich" <iii@linux.ibm.com>, Hengqi Chen <hengqi.chen@gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 0/4] bpf, x64: Fix tailcall hierarchy
Message-ID: <ZVtUATBtSTcMUhPl@boxer>
References: <20231011152725.95895-1-hffilwlqm@gmail.com>
 <5ee643a8-d39e-470b-83e9-9d550374e617@gmail.com>
 <CAADnVQLV5T9+_Dbd=yg4a5-4hQPznAVxdZ42ps50EL3BmnRdcQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLV5T9+_Dbd=yg4a5-4hQPznAVxdZ42ps50EL3BmnRdcQ@mail.gmail.com>
X-ClientProxiedBy: FR2P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA2PR11MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f9f0df-be52-48f8-4f39-08dbe9c60c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61b3lJcBh1xw2+a0JErA4DESahSi/M/UcJUYNX+8fHi25/fjtPxmO4Zqo3k2tL4rwG36zOw8ByLrLJ+/qtuugT9PWvjD6NaH+HIx0pQbGS4bnAUai7bPS1302XuOe0OH/nircAPt1Kki22AipPAbFp0ciln9iqi6RN3rwdy74w0trJ+dOAA/n0VwHPXAHVY2X3f33QxYxEReBnaKiFwxY+eV/rJSV+VDYLukAeGe7muBCYBLNu5f7ToiIOCuSxjkqiAO5kd3OpIPkxZbbIm8t3N/ZbQ2R/45S89ybZuZ0vocPM+XOeqt9uCc/E6/C/aR3n45GunmQjz96jjomThYejsIeBg+M1P2j25dXCKLerDp3wxHfbRcnQvH5eGaPwP5jqEzKxK8kjONE83l+tyEetkc1Wm+7x4OFHhU8mCM9wmvq5bH/SDI2cKUF4Q6cy2G6mQm/avkG/skjbyJwcZp17PD8GOg5A+yDcPKjlvZahCGgSa7Rbc3juOdKEhgL6X/TAC2lNcu3qpAbcJ0tMXWlFBIzjLvpveFdvKSRoyQGkpVGkMFtLnn4HljUobCmIFt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(346002)(376002)(136003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(2906002)(86362001)(5660300002)(4744005)(44832011)(33716001)(26005)(6506007)(53546011)(82960400001)(6512007)(9686003)(6486002)(478600001)(6666004)(54906003)(66946007)(66556008)(66476007)(8676002)(38100700002)(8936002)(6916009)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHdKR2FJN0hzRFY0RzhHY2RMM256REtPN1F1RFQrRlp0THhoWno1aVhTNklC?=
 =?utf-8?B?ZTY3MVNFVnlhS1dJMTFLaTlDUUVLVDN6M2NPYlRWRXVBS2FvTVlZZnhCYk1o?=
 =?utf-8?B?cWxVeUZGVmduc1ZnM3h1MFlRUnBOVTBuQk45TGQ2bjV4Tm9MclNwQ3BCZEhO?=
 =?utf-8?B?ZmNKS1FOZkpSYnNqOWtBRkFnZnVjMUxLTXpnNjRzNEZnQUk1SDBDaU1DYUhm?=
 =?utf-8?B?UXdMMlR6OXFSV1NUaDlRTjhHS0FFYTk4ZjBpaGw5VGorNDMrWGFpRnFXWUZP?=
 =?utf-8?B?em96UEhGdlEyeGp5MEJndnI2d3h0ZXBwQWRLbzFPUXdnWUdBU1Nkcmd0RE1Y?=
 =?utf-8?B?b09sS1hFc2pGemJ1YVVrZnEyNGN6azZ0a3ZzRGppVy9uUnNQYkEwSXlxUGIr?=
 =?utf-8?B?WVkrVTFvc3lNRkJxTFp1dHdzKzkxUWNXc2ExbXdxZkVOVFgzaVF1bUw0R214?=
 =?utf-8?B?a1pidjFBeFc1eWxrNVJyaFJJZjhsTkVvdGpKdW5NbUNGNlAxWldlVXlqbGVk?=
 =?utf-8?B?ZmRvYmNzL016T2QyOGhTSXBUZmV2eFI0Yk1PcFJKODZyUFlyTG81UjF2UVhy?=
 =?utf-8?B?enZMdnN2aGN0c2xHdW1qMTg2NFFWWnJmQ25WdnpucFhOaWttRHF4alN1bUZt?=
 =?utf-8?B?cTlPUUJSeUpUYzFVNE5rQVA2MUdIUE0xSWd3TEpNYklMVGdaWGR4amlSQ0xu?=
 =?utf-8?B?cmRTL0RFWmtiZ0g0eFZxMnFEL3YrRlpTM21jQzc1SnRTSk1rMnNEWHhFaDJW?=
 =?utf-8?B?T2hoQnB0TmNRY1NWZ2NuT2xtR2YvKzhNckd6MUJGK0tqV3RValpNMDRZWHcz?=
 =?utf-8?B?WWxmcnVlYWJoak1NbS9nMXZNaEYwVk8xMjQ3Q1RQeG8rZWNid1pDSjRjaFFa?=
 =?utf-8?B?bE8zZTQyQXp4ODA4OVlsMSs2a3BtVXIxRmxuVFJNYzNQQW5nS1Z3clF3K0Ey?=
 =?utf-8?B?cUZrUzdVbnIzUnFENFBkY1R0bjlXZFd0VFd1YjJkUFZ3ZTh4UVI2VHg5bmpU?=
 =?utf-8?B?Y2xYa29GTFB3NGdGMDBtcEc2NW4vRFdDUWtaZWpaUkl3a2FKY0EzR1RmbXhq?=
 =?utf-8?B?THZaYmxHZ1RMYjRISk4xZFlib01IbEJOUkZYbnNzekJtdTNQTzBIMFNJYU53?=
 =?utf-8?B?Qi9vbkZyWVV0ZWc4UUlCWXJqY1JYeVVoZUU0UHkyNEtTNjhtTE5VZ0RQY1p5?=
 =?utf-8?B?TTJBVkxRMTZKdlFoMGY0dndpYlNZMGRSTWNXVFlVZXBLOWxhRHM5SWlKL04w?=
 =?utf-8?B?NGdMMmg4VzMzOTZIRGRxY0FiaWlSNVN1Sy9jUVM4OEoyVmtCMDNQRDIraFQy?=
 =?utf-8?B?SElCT2t3a05ydENtOTREYzF2cTBkSGp2ck1ValdrRDgyRURkdkJucTB4L3Vw?=
 =?utf-8?B?Nm9aeFE4OVBrSmF1NXdIRTl6bExzTWhDdk01bWMrRkRuMkgxMjVWK3cveTAz?=
 =?utf-8?B?bnZuWGJXa25Ba29DUUgrSmxQVDFNb0JFR3VuWFRnbkxGSjJoK0FwVk8wd3Er?=
 =?utf-8?B?L2xQN3N5dFRXWFZjdFBVSWg4NTFicHl1Z09RNUQvRncyK1hKaHZJNFUrVWFO?=
 =?utf-8?B?eVdKWHVCUGJoZzN6NmJXN0JTZE5wL1dLVjd6K1RXb0FrdytJbTdoaWo0bFVG?=
 =?utf-8?B?V3dEV2k0MjBKYlhPQ2Z2SDZTQ1g0cURoQXRQRG5mSXJldnFRMmhmamVGZlFI?=
 =?utf-8?B?elBJM1BxdlYrMy9JS3lxUDBkYkxtdDFraWtscGt2dVJTOUdNTVRFSmtTcVNn?=
 =?utf-8?B?Mk9hR0lqaXpnVG5qa29PdytTeW9qdVJ2UXlXMWIwU3phMXZQdmxsQWQ5MUlw?=
 =?utf-8?B?eXArb0RMZWtjSVplTW1nRjhyU0EyU0hsKytSbnFucXE4VnRPcjR5Vllkd1dS?=
 =?utf-8?B?UUVucjRtR21VNFVoZTRuWWpReS9zN2RKMSt4RGNkdWFlMUVoV1RRY3Y3N1dP?=
 =?utf-8?B?aURPY2NTM01oSGpJZ1pGaU9iUkJEUWJjYityUDlTWnNxRGpSYXZTNWt4Nk5G?=
 =?utf-8?B?U2JwdklZNG10bHBIM2pqSUJ3ZWEvNFZZOFVHeXBnMURTL3M1SVdQZUJpS2pa?=
 =?utf-8?B?OWtrNVJkVWFXMUorSWVxUWJ2UDlQR05GaFg0cnFYYkVrS3YzK2pnTkdZVFhP?=
 =?utf-8?B?OEpkbjh0c0Q1eVpMWUROc3dubm5RTy90cXpUVGFCR09pR2VXVTB4Znpza21s?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f9f0df-be52-48f8-4f39-08dbe9c60c4b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 12:41:42.3550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/LuvvL+5Q31cQumXzpBQXwMSvi8+J36fEZQVJ28MDUDu9M6D8sKbumh3j+qNFfp8ZILFxnFieiY/2L1tZHYg1JcPDjO7co+Bf/PsGaU9ZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5212
X-OriginatorOrg: intel.com

On Fri, Nov 17, 2023 at 01:40:41PM -0800, Alexei Starovoitov wrote:
> On Thu, Nov 16, 2023 at 12:33 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
> >
> > PING
> 
> Sorry for the delay. I didn't have a chance to think it through.
> I hope experts in the community can take a look soon.
> 

I'll take a look this week.

