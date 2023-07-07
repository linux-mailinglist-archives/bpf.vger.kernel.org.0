Return-Path: <bpf+bounces-4412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B30474AD37
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 10:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1BA1C20F7A
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 08:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BC49465;
	Fri,  7 Jul 2023 08:37:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891442107;
	Fri,  7 Jul 2023 08:37:59 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DDE1997;
	Fri,  7 Jul 2023 01:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688719078; x=1720255078;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/MaA0GU0pXjWvMSQZjOdPDNE0W5JlxPUHFy3XTKhRSE=;
  b=Mah3B7koOvpYKDbN5w/tkiVH0ihtVi5zQRPnpcYxuTuqbSC1PgWDPJJb
   20ixzbYikOdcfZYzXDEOtNv9EO6UdQ8UUiPORJ1rDuUwcp9UoYozzi1lm
   noEPz9QZgcnujNRb+yq6fpIH8caOfby4clLVuncxwnz53BcFWTNlu8PRa
   i9igqfEh5+8h16KthrjZGTdeoK2wEikJ0ZC+koVW6u9RrNUpIIwin21Hk
   geZ9+qtFBFOU7xXJgStxnzBZAinti46zgxZDW+ZlGh+i6CpaLJt8fw73D
   Sx8LlqV1/8nXWmXQOEpn1/9lBlh5+RPn+f0bJqsHQgBnXOnpY55U4gXLt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="362706934"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="362706934"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 01:37:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="789890932"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="789890932"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jul 2023 01:37:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 01:37:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 01:37:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 01:37:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBhF82Dsfkh/6FTrzOT1tp5BrxOQICavgFULf550FWdvmkGBuh0qpOhqeBW8j9ZIREaKftFnnOb9t9OJAyfAIboBR+RCfTiiwEkKKsVY7Ey19yYhHQ4gVwGq54zHkwFelJT2COaRoKvHulu6Y6Ea2ikf2oLe+uBvPeOxMv1+s+MhQVkQmOCF5AFVe3AeV4vWFHVqJ76w37dic8EdbkVDYEGbacV84YSoyqcJtfb9VMXDQ8PG92/9SVeWFkQu9VG5aoXqGNudKN1YH6chfTZVMHKpowEKU7/cdxxEhk8yTOy5FSEnFSgqchxfkBSDdA7mbCnE1mkCGAZY8nISlB9Sxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlIdySANUoweiNFyOrglrUYFQ+t9KDr9u8JMl4Ubt8M=;
 b=KQazavweCfJPbfSVQjg2vfznM4doEfydU+JFz+4CVGF+sJs+YBnHzwGjZ9k1nDjzH6t/uG+T4rThSMSwWCQ0hjeEWbUeLxcGX28akLsUT7gbDRzdCeFuYlDNGHYqaOYbbsGknFm/eFPWj2u4TpHIB8JQj3EBMZJ/+8rq28zjUUWFTGF4JCABsSkIslySwh/3qDhvYhrY/+YaJaO9P9iKvkYuRJJt9LGpdHbuoUnqQFMttTyHed5HRGpnLm9FC13fYhWx6fZTYGl39911VW2cBY3OW4Ok+QENElfQqdfrvsLwWoyUTGkvwvt9fu7dSLrqq/cES7rQBGuCEcM2/b+Dfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SA0PR11MB4735.namprd11.prod.outlook.com (2603:10b6:806:92::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 08:37:26 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe%6]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 08:37:26 +0000
Date: Fri, 7 Jul 2023 10:33:20 +0200
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
Message-ID: <ZKfN0AZ9rLDhxsB3@lincoln>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-19-larysa.zaremba@intel.com>
 <ZKWq142tp/tI6NI3@google.com>
 <ZKbLd8brydTvSocG@lincoln>
 <CAKH8qBv9Mj6xmC9ru7oVAamaT+PLO62m4NAkOg=YS2vGpWntGQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKH8qBv9Mj6xmC9ru7oVAamaT+PLO62m4NAkOg=YS2vGpWntGQ@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::6) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SA0PR11MB4735:EE_
X-MS-Office365-Filtering-Correlation-Id: c4d75f9a-e952-41a5-3b46-08db7ec5647f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+a0l6OyQy+G8yIWUTNSOO++YGBPNI9fdVsM5r8zylRrrFOxnd4u5vzXphugdaPUOoszT/0nsGguqKKt+gHJqfoFw1Kr91lhMLaYWEzv53lYjcXD1UMRFVEMXZQtXqlD1HwMZsSNpcN6HAFtap0zL4K8vWzZPrSdLVic7lR6/MbFCjR0Gm4/DxnG7XqXX9+aIf8Fi6T2pDfhR9M8+wgSS1mGKZVVeQ09XG4FuDfI7Shx4BwA69sQyrxsGo+C2Npun3/bnbLk02nT22JDMglNkAZonUvqx9iPX22uyRhqCFuhS/iG1xNzOiMNSPwJ1k0i7NbAX4RM4CwNFE5SeXqpGS1+q6AmbA6NZB4d+p2DJP4v1DX6TGJmCiNoWHezk0YoOWWaKxKy/B5BEDPEd4fR0B7/rRkMiUQXX7PRJAN7GqalC96JDY+naDE+//l9zvv8PqMLTz29hk4Gx/WeLre4FU+mXAkca6iSrLk1vr3L9b/nmU/kiJgHpwCZ6mk3BS2f3Cpsgd8fCeD86bi6ThOOQcCOT9m5ma0sny4S5+wEZLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(83380400001)(6506007)(26005)(53546011)(186003)(6486002)(6666004)(54906003)(82960400001)(478600001)(966005)(6512007)(9686003)(316002)(8936002)(41300700001)(8676002)(5660300002)(66476007)(7416002)(38100700002)(44832011)(66556008)(4326008)(66946007)(6916009)(2906002)(86362001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWJSbGxHOEFRUzZHV0dCQytIQjUrc2xQYVZyenE2b1hKN09ySStYODhPMzha?=
 =?utf-8?B?MHU5SVJ2YzkreGc2R0lGS2U3SDVZbGxSdEtsTTNhcCtkdXRYQ3ppMXlqd2tx?=
 =?utf-8?B?clRrN1djVU5NbXRGR042MGxPZHBKdUMzYTcveGt6a2N2UFdUZ0F4bXdvNGJZ?=
 =?utf-8?B?TXV2KzFqYlM1R3J4ZmVoT01HQ25jZHhZRFI5U0tyVDlaemxrb1o2KzY3MjlV?=
 =?utf-8?B?RXJRMUM3SFZtbU9VL2pMTk5QZEZRaEorM2JocmhseG83LzlmckpmYThnK0hK?=
 =?utf-8?B?YTV4M1pRUG43em53bnJSbXg2OGxheGpNOWpNUUdseWE5MGhMUFJIdksrc3pO?=
 =?utf-8?B?NDJLOCs0eGJRamhIam1HNXNWdGdUd1JUMkJWcU5JRk1mNlNDTUt1K1pXc2tS?=
 =?utf-8?B?UGpDZXgwVVMzblJLN3pyWjd0QXA2emI5eUdDdzExWnEveldMdzBaVTVTak9S?=
 =?utf-8?B?enJ3U09nV254bHpLZGhJazZadksyR0dNcTVSY2J6R2FxUEh6TTI1U2tRUFBp?=
 =?utf-8?B?VlJWVHlseFVXdEFBMUxqZmQyUko5MC9keGpJTWsxS0RRZURzRjFURElEZ0VF?=
 =?utf-8?B?WG5XakNqS1YxS3NIYnRDUXRDaE8xSUJkZWRsMUdNYnFIcHB0WmFuNWkwNDI1?=
 =?utf-8?B?RTRkMjlKWVpmTk9vUE1qN3Z1K1VpQUVKcmxIOUJzQTNSTk9haDNrMWpuYVkr?=
 =?utf-8?B?b1FaazlveGZyV1pFVjdxY29rYTFucFZaTkM4OXI5aitXRC9sa3B5WWxQVGlL?=
 =?utf-8?B?c2hiMFVqNk9UNERGZndFN29QcWVNSU4wM2JRMllCTEZTQVJIdDNmWUZFSnRZ?=
 =?utf-8?B?Tnk3K1FwNjZibHNFbEpQRnU1dzhveWZVTkZ6dldjUXljZHpqNzVjL0htYUlI?=
 =?utf-8?B?VjBGOENBTkpDaFBYamhNangyTDZFT0xadlU1dWdQaWUvWUllQkFPWFBkY2Ew?=
 =?utf-8?B?VXVXbmdCNTI5cVFMeXd3WklmK1kwR05EVkFOOTVwYlk2a09vYTI3WlMxd1Ns?=
 =?utf-8?B?NVVsQWRyRGxVRDg1ajVnWkdFOUE4SmdCNnFYNmdxQ01LdjloMFJTMk9IbHNB?=
 =?utf-8?B?YUZIb1ZPUS9GQ3ArMXlncjRVSG5DTTBFMlZ2d3pUNFErRmZ1RFI4c1lzSG1i?=
 =?utf-8?B?clV3cDhZR09YTE1HLzRRZituclBMV2czMk9vYytiUHlyUllOV0o4S2NFUllC?=
 =?utf-8?B?VTcwN2NWSG1jR2s4enBXVGp2Ty9rVXhObmpTYVp5ZldVL05jVkgvMnZjdmZU?=
 =?utf-8?B?a3gxZU1JRExTT0FCVGVoUk83eUh3bDB1blE2NVEvY0pCQzZUU0NONmhmWlpR?=
 =?utf-8?B?Z2xZYWRCcUM5V29JemNuMlppR3haSFFrNE1HTUdhSm9xQmJua1dDMllOWWcx?=
 =?utf-8?B?Wk9KaHk1WHQzUjlvZHdwRVdDV3UyclBhbU50SG1acHB4YXRWVEJRWkllcEQ5?=
 =?utf-8?B?dElVNWtPSnJ6QnNDUk15ZjlWQkhGLzF2ZXIya1FBMEg3anJrYTR1Z2FORmtl?=
 =?utf-8?B?Q2J5YVZXcS8zaWRWSzNRWEhEZUhlbjcwS1ZYM21qZUV6UGo4cUFJdkF3ZWt6?=
 =?utf-8?B?NkdwL05xSENIaVRQN2J4U1oxYkNRcTh5VTNXUk9PNFFoWTBraUU2U0c2cUtO?=
 =?utf-8?B?UHJza08ySXBpb1R3ZVJNWWtDTExlc1FUWHVIN2Y0NmpMWVBwOGdnSXMrcVl3?=
 =?utf-8?B?MXI0YzVLRDNnR0tmSTFmZEpBOUNXZytrT2pralRhNEJlZGVRbSt1aytqQ0p4?=
 =?utf-8?B?NDY1ak1rT0lyUTRianEzcGJNZzhnK0ZVT01TSXJNam5WeHdmM01nNVFEOTNl?=
 =?utf-8?B?MFNQTW5UZDByaUNNYjd0U2FBTjdQbHRWSGkrUTBaZnFvQ0xzMjBGTEhTaFhh?=
 =?utf-8?B?cGp0Q1dpSUlGNWlheTFoazA5c05BQUtScjBVcUY0cURFZE5jWkxERDUzMERW?=
 =?utf-8?B?Q1N3ZDRSKy9NSTJ1REhlbjFIN3VlMklxL2I2M1pkSWlIU1Rzb2thak4zMTJV?=
 =?utf-8?B?REszK0k4RlAySEttYWlFUExIVDdSRDlyR3Ntdm9EVlRuQnBtMEM3enNiSzRU?=
 =?utf-8?B?Nys2bVdnZm5KSUU0dmhZY1Vzb3Z0dW1KQzJaek5KbExvZnVvTEJ5aHRyajYv?=
 =?utf-8?B?ampOWlcrdVBoRE9WVUd1TTg3YmorZ1hwYU1sbzdIZzlkT1FrS1JzaHdodEw4?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d75f9a-e952-41a5-3b46-08db7ec5647f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 08:37:26.6166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gB7Nn5ID/JyAqDTIRgXJC8Op6I1wQYfTm9AOwJNit35ydeXHcFfjbL4De+y2cdHEWa6Tyygsuh1f5GVeEBW25giH+UDr1LpctltwHSG87zM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4735
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 10:27:38AM -0700, Stanislav Fomichev wrote:
> On Thu, Jul 6, 2023 at 7:15 AM Larysa Zaremba <larysa.zaremba@intel.com> wrote:
> >
> > On Wed, Jul 05, 2023 at 10:39:35AM -0700, Stanislav Fomichev wrote:
> > > On 07/03, Larysa Zaremba wrote:
> > > > The easiest way to simulate stripped VLAN tag in veth is to send a packet
> > > > from VLAN interface, attached to veth. Unfortunately, this approach is
> > > > incompatible with AF_XDP on TX side, because VLAN interfaces do not have
> > > > such feature.
> > > >
> > > > Replace AF_XDP packet generation with sending the same datagram via
> > > > AF_INET socket.
> > > >
> > > > This does not change the packet contents or hints values with one notable
> > > > exception: rx_hash_type, which previously was expected to be 0, now is
> > > > expected be at least XDP_RSS_TYPE_L4.
> > > >
> > > > Also, usage of AF_INET requires a little more complicated namespace setup,
> > > > therefore open_netns() helper function is divided into smaller reusable
> > > > pieces.
> > >
> > > Ack, it's probably OK for now, but, FYI, I'm trying to extend this part
> > > with TX metadata:
> > > https://lore.kernel.org/bpf/20230621170244.1283336-10-sdf@google.com/
> > >
> > > So probably long-term I'll switch it back to AF_XDP but will add
> > > support for requesting vlan TX "offload" from the veth.
> > >
> >
> > My bad for not reading your series. Amazing work as always!
> >
> > So, 'requesting vlan TX "offload"' with new hints capabilities? This would be
> > pretty neat.
> >
> > But you think AF_INET TX is worth keeping for now, until TX hints are mature?
> >
> > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > ---
> > > >  tools/testing/selftests/bpf/network_helpers.c |  37 +++-
> > > >  tools/testing/selftests/bpf/network_helpers.h |   3 +
> > > >  .../selftests/bpf/prog_tests/xdp_metadata.c   | 175 +++++++-----------
> > > >  3 files changed, 98 insertions(+), 117 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> > > > index a105c0cd008a..19463230ece5 100644
> > > > --- a/tools/testing/selftests/bpf/network_helpers.c
> > > > +++ b/tools/testing/selftests/bpf/network_helpers.c
> > > > @@ -386,28 +386,51 @@ char *ping_command(int family)
> > > >     return "ping";
> > > >  }
> > > >
> > > > +int get_cur_netns(void)
> > > > +{
> > > > +   int nsfd;
> > > > +
> > > > +   nsfd = open("/proc/self/ns/net", O_RDONLY);
> > > > +   ASSERT_GE(nsfd, 0, "open /proc/self/ns/net");
> > > > +   return nsfd;
> > > > +}
> > > > +
> > > > +int get_netns(const char *name)
> > > > +{
> > > > +   char nspath[PATH_MAX];
> > > > +   int nsfd;
> > > > +
> > > > +   snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name);
> > > > +   nsfd = open(nspath, O_RDONLY | O_CLOEXEC);
> > > > +   ASSERT_GE(nsfd, 0, "open /proc/self/ns/net");
> > > > +   return nsfd;
> > > > +}
> > > > +
> > > > +int set_netns(int netns_fd)
> > > > +{
> > > > +   return setns(netns_fd, CLONE_NEWNET);
> > > > +}
> > >
> > > We have open_netns/close_netns in network_helpers.h that provide similar
> > > functionality, let's use them instead?
> > >
> >
> > I have divided open_netns() into smaller pieces (see below), because the code I
> > have added into xdp_metadata looked better with those smaller pieces (I had to
> > switch namespace several times).
> 
> Forgot to reply to this part. I missed the fact that you're extending
> network_helpers, sorry.
> But why do we need extra namespaces at all?

If veths are in the same namespace, AF_INET packets are not sent between them,
so XDP is skipped. So we need 2 test namespaces: for RX and TX.

