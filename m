Return-Path: <bpf+bounces-4456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9822D74B57E
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 19:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704431C20FEA
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 17:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C05C11C8D;
	Fri,  7 Jul 2023 17:02:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100D8D511;
	Fri,  7 Jul 2023 17:02:19 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FAA1723;
	Fri,  7 Jul 2023 10:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688749338; x=1720285338;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=eS9kybMLsRA75P39a6OwN9qweNuREHHeDlbHxVg7B+s=;
  b=d6fCMqWahAvH4ZEj17oxYI5ggW3MxBK823xMfa8wMETiVVH15A85tjPR
   RkkTjaamwwVeV50gt+0caHmhE4jHm1TaHgFkmpIpTymZzCQg8rxTe+BTz
   3IFhsXztjeTLJ1FzDnxWeG1Xhjryf+f7hzbb8+XngsyNiRtrAxc51YqEl
   cCNj/HJiYEHkSGkxfoM33Qi0WxqXTYQ9w8YE00wjMR9PYFs8BNzwErO1J
   XPiC6kMvstcTaagmJ/4W45NeZSce/N77R/Y9ouo4QTsIu1KRCTsHCwoIX
   RH5SdJCXA8BnUWVrRZ4HvykrE2KLgwWFruqxS7MSW/0xqhGt9fN9Jium4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="450289942"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="450289942"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 10:02:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="755246865"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="755246865"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 07 Jul 2023 10:02:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 10:02:17 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 10:02:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 10:02:16 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 10:02:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2iBqyi75h/+rHlKyTCauduppjVJ8DPsgyhE2UHwhZsz0uZrZE9RKhxEKgP4CghmxFBRy1kpdID9ziMP8hay5btGgQeLpTvDyZYGqiPR0MRGVu83gEKFbKEr885phoGC+yZ7zvRhM2xj0IdOJg/l2D0AwLJ/FQDvLUe2qH4oNHVpFgK3zkhIsCYf+DucSHT7VlgLLobyUpc462/0ud5BeM8P5GcNxBlEG/DSH1oyDNt8cCyKt789eCAhVCVl0Je6ldU93T3mbCv4ZDH7OHrv2Yb/yn/9b68wKkmyB+h1sMGP/+yLqgH0jkahe+oN/0yD7ClEmEKLwrDLVg0YV0DURg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phce137Shn0ueFkhEBBUE5/SDwQnVmxlmz39jzJDnRM=;
 b=PkWhxq1byDhfQmk3/kB6Dsnas1FygSolSfHHuJkWwFfzblDX8N2TbLluHzogWHQb6XTUlKbfzLeJJkzF5VX9UrEFPb3t3PHEdkeW6uqcQ6jcHlv36MpqtZ5t5h5mL++6gnv+bqiYS/BLcwKzPmmLNOCe0V86CIVgndW3eF1ZabMCNJl3RU743+1C7y0c69YGAFZb+1pi0gixhSBMvDQ1tq9Nr9PPLjCpUGL1hwoV2UxO2Kv5kqxVgE5hASFJxIdd/bALeEZsDY2cg91srpCqLnflbouSL8PlIbhJnwMWy1jdQiFY2N8inX7UUtNRq6k+tVfoip7gouIrqBObp8ptyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DS0PR11MB8183.namprd11.prod.outlook.com (2603:10b6:8:161::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 17:02:10 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe%6]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 17:02:10 +0000
Date: Fri, 7 Jul 2023 18:58:00 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <haoluo@google.com>,
	<jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, "Jesper Dangaard
 Brouer" <brouer@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>, Magnus Karlsson
	<magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>,
	<xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 18/20] selftests/bpf: Use AF_INET for TX in
 xdp_metadata
Message-ID: <ZKhEGK8J8MEp1iIS@lincoln>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-19-larysa.zaremba@intel.com>
 <ZKWq142tp/tI6NI3@google.com>
 <ZKbLd8brydTvSocG@lincoln>
 <CAKH8qBv9Mj6xmC9ru7oVAamaT+PLO62m4NAkOg=YS2vGpWntGQ@mail.gmail.com>
 <ZKfN0AZ9rLDhxsB3@lincoln>
 <ZKhCL/YMo8dv4lqd@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZKhCL/YMo8dv4lqd@google.com>
X-ClientProxiedBy: FR0P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::15) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DS0PR11MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 000349d6-a343-4516-fd24-08db7f0be6d2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FOZsU/+uiDQE/uQjlYf6tYMSIAiSJZodxqAtOqMoKj3QV8sp4pgoNze/bEqev+X0Hg1Xx2Ddo6WdM+m3JshPScTts8eFrBpas8ASt/DwV0Of+8up3EpbWLc7m0go7DSlqRCHIt4ibnHe0qQyPo3g2Vw3biqMWFYknYqfcLurxoRcFCdN3swanG0K4WJ9rFXgZlI8/+AVD8N5sGUT6Sbuu7QGNi6XtHsmpdVn1bwt+p1cEDyt5L6tV9HwXsqPb83lcxKaCUrepESbUxRUHPf6a9lXzt0s4+dL26xfqIJRTh3q5YT/fMvaV7Td02vjTLvCdv9aLUrHhvY1Xnb9olDHZkBA1aDjEkTwiuxufyCcFVFYSagSuUcp5+m7EC6Kz0KDYX2l9E8wrJ6ztz/7MSiRpXsNpmU01CZaAWIQl8Yzpi9lYt8CZcMmgvkF6rG2bG1VwdmBNVUVruZUb6q5bPWadvfd6ph0N1XjFUdpI5a34auqsDEvoDs/8n1w8wDIgCJ5nGoxmIXvJHZioRvFxZNJ5J+a8RpqOg6VVvcvBll0pv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(82960400001)(38100700002)(86362001)(33716001)(8936002)(8676002)(6512007)(41300700001)(9686003)(26005)(5660300002)(966005)(6506007)(7416002)(53546011)(44832011)(186003)(2906002)(83380400001)(316002)(6666004)(478600001)(66946007)(54906003)(6486002)(66476007)(66556008)(6916009)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEErMWlJWFFQRWlDV0kwcXl1QzJzejFVbGFyM09jTnpsZXdBbFBqb21EMm1O?=
 =?utf-8?B?dG41RWVHWFNZL25xZWZha0E5dTN4Tm9QbW9uWkFtNEt1UDluNVFodFZpUklE?=
 =?utf-8?B?SnhTQ2RWNlF1dlJNV3IrNmlsclAxUnkwU3NkQk5xVTUydnJaYzZLWGc1THVL?=
 =?utf-8?B?Q1E2YkY0NDNiR0RxcGpKSytOaHU0alJnR2JDN2IwRmQreitHM2ZlckxRL2pv?=
 =?utf-8?B?aE44Y1o5Qjh3cGdrVXZZb1ZtQ3g3YWpsWWtQVitnWUJEMEFyY2JrRW1GR1hV?=
 =?utf-8?B?SDZPWE4rSmFDbEt1MEZEMzhkcmM0TWxKeTBJdUxjVTF5UjA4aWdPZE5KL2Fs?=
 =?utf-8?B?TThWa2tzYlZKNXpGTW8zcUVXM3JNREpNeTBYT2t2cjBCL0s0N2hEbkh4STFT?=
 =?utf-8?B?eVU3bVUwWVRLd2hHNTNsM1JUc2RrY1RrMDBGejNic3JGRTB6WGZtWnJKY2xV?=
 =?utf-8?B?cG1DOHdrV3pabm50a2FZR1JHaGFHRGdvUVNDajgwY1pPaWNNQ3JZd1JZRFBM?=
 =?utf-8?B?azd6RWZIcWI3ak5KMHk0YjlIcStDNlhGUElPemg1WlBva0RLZW0vRU9xbGpm?=
 =?utf-8?B?SnNDTjZoOGh0OUpjc1BnSjg4QWZibWpRRDRaQXZ3dXhaK2JETE90R2dRczhD?=
 =?utf-8?B?OFUrZll4QWRGZGkzRkpWUkN1V0pDbWpLSFhHS1JDQlZpdXRKTDE0bEhrR0Fy?=
 =?utf-8?B?czRQZzFKT21YdjJJZ1ovRUE3cHF4T255dFFzdTFtb3RqMUpveWtrZkZ4UElL?=
 =?utf-8?B?L3p6R1hwYnFHNkE3cEdyVjdsZFJxREpsVlZ0cUhKS09jVlVFYXlsb2pxZlJU?=
 =?utf-8?B?MjVacnRxZXdyb2pVVW1uSkdJVTVFbHFOUVRsU1NhOW1YWFFkWjF3a2VMVkJD?=
 =?utf-8?B?a09YemtiUlM4NU5nc0ZpeTlWbGdIWmxRNkxrMGd2T2pyWENPNEpUV2dtY05G?=
 =?utf-8?B?cS8rYk1EK1BVb1FEbjZ3OGk5MldPMnJ5S3kvQ3Z5Q2RDTkE4ZXFVU1orcFFs?=
 =?utf-8?B?QTFheTJVVE44MDhGaXFxQXRpSVlaT3NiV29TaVNqckgza2dHTllXV3R2VlRL?=
 =?utf-8?B?cWhGV3hmVWw2YUlzYTMwb0gvU0dVNzVyYk1KMFh0NE13VW15d1VpUFF4WnJw?=
 =?utf-8?B?QjZpK1I5a1BwSzJjRGJuSEQ1Nm9Bd3lleVFQamlBM25YQVdITEVNeElrQW5z?=
 =?utf-8?B?dU5QZDkzTU5JV0ZyMm91K1VvNHFlZSs2OTJVcmt1cHo4WTVtUjcyU05sMWdR?=
 =?utf-8?B?ZllnVnlOV2txUmwwQitNVmh0T2ZwaWt5OWd0bXJaNlpFWitLdWhzTlV5Njd5?=
 =?utf-8?B?MC9mMi9Kc0IrcnFmM1gxeVo5WEJGZ3ZTa3hwMFZOTnNvcnhZRFV5YkdQZDFX?=
 =?utf-8?B?RDNMUE9sYU83WGNLdURlYTlFc28wd3BwdU9iZmw2cXozcEhSbXFFQm1pdS9V?=
 =?utf-8?B?R2gxNVV1eDJ2UCtRWjQ3bTBsREY2cDVxNEV6M09QRWN5aFRicWppMjhNSmVi?=
 =?utf-8?B?NDg3ekFoMnNwOEpWdTZ5N3NPRXRhUjROK1pwTEhpSkZoanIyMS9wcnQ2S2h0?=
 =?utf-8?B?aVAyVmRkMy9CMFUwNGVDSUdHL05xR0NhRzBxRzNjMkM2NHRRalNtMC9xazNG?=
 =?utf-8?B?aVJNcXBVZEdGY1I4Mjh3MVdtRWZ2elNxT0ZpV3dDMktGZ003OWIxR1RMQk1a?=
 =?utf-8?B?SWJXUjZBTmNaMDRtaTJJaHhWT254L21iYjUvSzdzblVZZGtCMWwyRmdVSzc1?=
 =?utf-8?B?QTFhQjJoazVNaVhpUFJPbXV3LzZjZThYelBSbzRXc2VoTVlMV2JaQVFQZFU1?=
 =?utf-8?B?bmlzTFZzL2M1UnJyeVBUcGkzQWVtZGlGTTB4VFZJZDhUUjRQWGh3c3kyclZU?=
 =?utf-8?B?TE1BMzVoVitmbm5rOFFSQWt5ejk2dHM2Y1lZVkJIVUl5Qy9QME04U3ZyTmdW?=
 =?utf-8?B?N0hsejZtRXU4Z3BSejdaNUNodGJ6dGNFM3YrcllSUWgvSmMxc1UzTEdLVlds?=
 =?utf-8?B?R3NtUHpBWUd6akZrWlI5d1UweG9heklSV2FpQ0EvZTFISDN2N1lCNHRTdXF2?=
 =?utf-8?B?dnpEdGxOWUxYbjhBUlE5WjAyQU1VZUVHdCtuVW1QQkc0djk1WldsS0htZld1?=
 =?utf-8?B?SXFscCtKdmFDQjFmb0Rybklnb3RsV0s3S0VCQTVEOHA1MWMydDBOd0toT0g4?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 000349d6-a343-4516-fd24-08db7f0be6d2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 17:02:10.0381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5oVYGAdMmh4IIGJlCX0Ml8GQwQv1Cuad53hG6a8BGXJdgfMpczvL9hQ+j+Y9/3yb6WfMQQhgUIHFVNKF1RKvCs/q+69eo+DFZMG/fG5xWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8183
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 07, 2023 at 09:49:51AM -0700, Stanislav Fomichev wrote:
> On 07/07, Larysa Zaremba wrote:
> > On Thu, Jul 06, 2023 at 10:27:38AM -0700, Stanislav Fomichev wrote:
> > > On Thu, Jul 6, 2023 at 7:15 AM Larysa Zaremba <larysa.zaremba@intel.com> wrote:
> > > >
> > > > On Wed, Jul 05, 2023 at 10:39:35AM -0700, Stanislav Fomichev wrote:
> > > > > On 07/03, Larysa Zaremba wrote:
> > > > > > The easiest way to simulate stripped VLAN tag in veth is to send a packet
> > > > > > from VLAN interface, attached to veth. Unfortunately, this approach is
> > > > > > incompatible with AF_XDP on TX side, because VLAN interfaces do not have
> > > > > > such feature.
> > > > > >
> > > > > > Replace AF_XDP packet generation with sending the same datagram via
> > > > > > AF_INET socket.
> > > > > >
> > > > > > This does not change the packet contents or hints values with one notable
> > > > > > exception: rx_hash_type, which previously was expected to be 0, now is
> > > > > > expected be at least XDP_RSS_TYPE_L4.
> > > > > >
> > > > > > Also, usage of AF_INET requires a little more complicated namespace setup,
> > > > > > therefore open_netns() helper function is divided into smaller reusable
> > > > > > pieces.
> > > > >
> > > > > Ack, it's probably OK for now, but, FYI, I'm trying to extend this part
> > > > > with TX metadata:
> > > > > https://lore.kernel.org/bpf/20230621170244.1283336-10-sdf@google.com/
> > > > >
> > > > > So probably long-term I'll switch it back to AF_XDP but will add
> > > > > support for requesting vlan TX "offload" from the veth.
> > > > >
> > > >
> > > > My bad for not reading your series. Amazing work as always!
> > > >
> > > > So, 'requesting vlan TX "offload"' with new hints capabilities? This would be
> > > > pretty neat.
> > > >
> > > > But you think AF_INET TX is worth keeping for now, until TX hints are mature?
> > > >
> > > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > > ---
> > > > > >  tools/testing/selftests/bpf/network_helpers.c |  37 +++-
> > > > > >  tools/testing/selftests/bpf/network_helpers.h |   3 +
> > > > > >  .../selftests/bpf/prog_tests/xdp_metadata.c   | 175 +++++++-----------
> > > > > >  3 files changed, 98 insertions(+), 117 deletions(-)
> > > > > >
> > > > > > diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> > > > > > index a105c0cd008a..19463230ece5 100644
> > > > > > --- a/tools/testing/selftests/bpf/network_helpers.c
> > > > > > +++ b/tools/testing/selftests/bpf/network_helpers.c
> > > > > > @@ -386,28 +386,51 @@ char *ping_command(int family)
> > > > > >     return "ping";
> > > > > >  }
> > > > > >
> > > > > > +int get_cur_netns(void)
> > > > > > +{
> > > > > > +   int nsfd;
> > > > > > +
> > > > > > +   nsfd = open("/proc/self/ns/net", O_RDONLY);
> > > > > > +   ASSERT_GE(nsfd, 0, "open /proc/self/ns/net");
> > > > > > +   return nsfd;
> > > > > > +}
> > > > > > +
> > > > > > +int get_netns(const char *name)
> > > > > > +{
> > > > > > +   char nspath[PATH_MAX];
> > > > > > +   int nsfd;
> > > > > > +
> > > > > > +   snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name);
> > > > > > +   nsfd = open(nspath, O_RDONLY | O_CLOEXEC);
> > > > > > +   ASSERT_GE(nsfd, 0, "open /proc/self/ns/net");
> > > > > > +   return nsfd;
> > > > > > +}
> > > > > > +
> > > > > > +int set_netns(int netns_fd)
> > > > > > +{
> > > > > > +   return setns(netns_fd, CLONE_NEWNET);
> > > > > > +}
> > > > >
> > > > > We have open_netns/close_netns in network_helpers.h that provide similar
> > > > > functionality, let's use them instead?
> > > > >
> > > >
> > > > I have divided open_netns() into smaller pieces (see below), because the code I
> > > > have added into xdp_metadata looked better with those smaller pieces (I had to
> > > > switch namespace several times).
> > > 
> > > Forgot to reply to this part. I missed the fact that you're extending
> > > network_helpers, sorry.
> > > But why do we need extra namespaces at all?
> > 
> > If veths are in the same namespace, AF_INET packets are not sent between them,
> > so XDP is skipped. So we need 2 test namespaces: for RX and TX.
> 
> Makes sense. But let's maybe use the existing helpers to jump to/from
> namespaces?
> 
> It might be a bit more verbose, but it makes it easy to annotate namespace
> being/end. (compared to random jumping around with setns)
> 
> tok = open_netns("tx");
> do_something();
> close_netns(tok);
> 
> tok = open_netns("rx");
> do_something_else();
> close_netns(tok);
> 
> Should be doable?

I guess you are right, will rewrite this part to use open_netns()/close_netns(), 
especially considering I have messed up namespace FD management according to CI.

