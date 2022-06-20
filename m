Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9625F55170C
	for <lists+bpf@lfdr.de>; Mon, 20 Jun 2022 13:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241414AbiFTLOM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 07:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242185AbiFTLN6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 07:13:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5C017075;
        Mon, 20 Jun 2022 04:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655723565; x=1687259565;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=O9X7dLkZsNAa/7uUTxG4hgFMjAcXj6B1QGKyk5WA8uQ=;
  b=BN4ZVvWAuh1XXkv53ucuC+j2Xt5AalMqXNzvnSvA62GrJHm2RJIlI9PP
   rBZFGVy1q78OA1xNe7vJm7R52w6PCQhpVVoRukclfdtSE1HsrWAPML+7J
   Kx24CaFE6ZhRPqccHlemP20n91eCbS9jdXfB/GBLdvxz470526KmvBBiG
   efGOoJclrDLjp+01qtxE/y5Mk/OjDrIaX/0gIyixHHL3ii+IECjj70ClF
   83A39+5xFU8qUbo8/jdjh/MUbNnAkgK61YLaintmJ5tx0wtnKuTFwGW3j
   FgM7RU9sYVO3MnxcNC+5RgPh1LklXhA20tcTp4VQ3K+9JaVanrONBAX3x
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="343860523"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="343860523"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 04:12:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="764060230"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 20 Jun 2022 04:12:09 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 20 Jun 2022 04:12:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 20 Jun 2022 04:12:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 20 Jun 2022 04:12:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJUvXtJ6/Zenuf+9g5EnpafQGNiS0GLH+yCDNTp912jPAyj48z4YLzWBGGirt16hfgHz3oIn+bhJ1NzH/M2B1o2XErKQgZ4UpSmXKbHhsLA8eXXNu7ybIfgQ+aS34Xy1N6XJvMnMtWQ+dho9ChtYm1MRkCj4E/QxMX460B/b0U3bz0K/e0crOPssFowmYB/+oEslQ0qBuTSkuFNbW70//5OvQ+DKR967wpq+khfgx4Exyys82a8Sd+APOXVhL727vf5WkkvcMAJ02VQum87RxS0zhKNezNymfxZVeI1fC0TL+58JiKZyDbSM6wY4AOOxw8YaH63GsXJ/rtx7qmRYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9X7dLkZsNAa/7uUTxG4hgFMjAcXj6B1QGKyk5WA8uQ=;
 b=faCzaJqod1bjU84lHYq/G50BwMSyAvXvr/YYOw3JueR32xEpfmrkinL7AQtAfjAXiNVcv3hNELw3HWZC90OVoJHuW80EojGVfFXT7hp6Y89iL5Qdd8bdJ3eDtIYSHwEcuYje5HmZU+3yJhzsxtVTEM0VM8b0Qh2jz18SAgm/qwrIHV+zWN1SXRvNhWfP4h+Jsw2cZc8PZMSPW8HBuIqSVPxiVatmhV2rcQtm1IUz1pwNXKwm7tI9nMjuB06PBu0O/s/ytcdY346RcjKcpH0k2Iil15InZyufjYc5Z5g0/dIUFVXaHt4Rjr9XwUFXSfnHFDkJ/qOp3j9bZw/heOtUYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CY4PR11MB1990.namprd11.prod.outlook.com (2603:10b6:903:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Mon, 20 Jun
 2022 11:12:08 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::b513:4291:3790:a5a4]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::b513:4291:3790:a5a4%5]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 11:12:08 +0000
Date:   Mon, 20 Jun 2022 19:11:45 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Song Liu <song@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-mm@kvack.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <peterz@infradead.org>, <mcgrof@kernel.org>,
        <torvalds@linux-foundation.org>, <rick.p.edgecombe@intel.com>,
        <kernel-team@fb.com>
Subject: Re: [PATCH v4 bpf-next 0/8] bpf_prog_pack followup
Message-ID: <YrBV8darrlmUnrHR@ziqianlu-Dell-Optiplex7000>
References: <20220520235758.1858153-1-song@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220520235758.1858153-1-song@kernel.org>
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6536740b-dd0a-4c82-5f77-08da52adb6d1
X-MS-TrafficTypeDiagnostic: CY4PR11MB1990:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB19900E74A2E7D7652DFB5E138BB09@CY4PR11MB1990.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V948OCtCjmmKUUWhG/s313gFVcnF7uwBMgFP9UkJXqd/WB6PFZcd9KyLhENc7c3+CQ4SKqXFdEuRMAfbv1k7GWSrvtl9OqW1PrgnOkJ+5anfuZYnGrN+21JEp+6SUxYQufvJFwevhOyS6t63LpRzXmU0tHZQsmVnU9o2y491I7udIDtBK15S7sx2+7aIJ82QUc1nBhJ8yAvmL1II/JuE5X40KfKhw1ontHIbFMVIfQUUMx9MdZf0WQ4y9ItnDeTXZ3QWS/bICxavdKgYeytFmwziAOzhSu9r3cZXrER1gnuQcJFdxWMbI5NnJjeCnNBWX1CMWse7sCOAa7S493hJRx+oFsGjPaXm1EUyhwQcczrzS+50ijSdZtTsO7oDl1QmrlonFjBXLYdAHlRaWNpNE7hJRg8XBLtF7yjfp4wG9txIW85fhIoGW3Pk9O7PqmnRw7aQOG4f1JT+2riQ1zCdjILJ9aH4Me+THm1wcEtC4jWduO7jDdaNjGwVm0a53J5HaliO7v06TukTN33wlH3J8QxcqLrT5QIPBGxqzf9UZarRX68Dlt/jFOIB2nL4iNFZBbefa2kypLa3NA/ApPtqICR5tQIQKJxhr2rZQWFRUXNeA1QHbTm9H2u+B80viPWr8SbkSCrUmizuI6rTLQ2ePQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(66946007)(8936002)(2906002)(7416002)(6506007)(66556008)(66476007)(33716001)(4326008)(6916009)(316002)(6486002)(498600001)(86362001)(6666004)(83380400001)(44832011)(8676002)(38100700002)(82960400001)(5660300002)(186003)(6512007)(26005)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j4jXP+2ZCzo3K0zbkRAissDcIukQTCdtfbLzj1Qaufik26WDGgIxHvwZKnEn?=
 =?us-ascii?Q?GMAtFAPgVKBAm76xlnpYVUHYmm1pZQkI4zlqBOJLPPlC2JlRsR+eFgGrZQt4?=
 =?us-ascii?Q?vVDHHsNVu51vWCC/J3hVzI6DHiiP6LfDu5TDxxMKxFCf+tDXqadMmpUb6zDQ?=
 =?us-ascii?Q?O4DYwhW2AeRSJz5/D/s+ZOhCEayT6ynKUMq8CbRHGZ8KTeJBTdunZo+ghP/v?=
 =?us-ascii?Q?I68JqkZKurTkKgJiR8sK4jcxCR1rMOl4VZTwXqB53cdTZ6X0PdwWqOQoUiL3?=
 =?us-ascii?Q?Yw5IOjwW+vf1usM2Os6vocove9W+W7k1RGURR3+m0eGFb+pllS6FduCeGgsm?=
 =?us-ascii?Q?Hu4j5m1xo+MOv0PSxuGAWgLY4mJewRR6LlpPW9VaRTq66t0QjoONgapSTOUc?=
 =?us-ascii?Q?28OhwiVIlfF/c43MW62Cr3YCOTXtn+SbIBE35GAvXpzIMtWbGp5o66h0eZ0l?=
 =?us-ascii?Q?vWLepHjnwvinvpiIcy+xg2t0ekOdhZSpiThzDYMzWEQkueeR62rqIOSVjB9m?=
 =?us-ascii?Q?c4DsQ1c4hbwzVShl98hcqkWouyppumAp4YxlSnc4P286OLMvGiP13pvRQ5DT?=
 =?us-ascii?Q?326U9nAR1WyavkDLCRO5lmfKKAT3zMBu6D2z2xr2/SeBa8MV3+2hDCwmm/xz?=
 =?us-ascii?Q?JFRMw+9r06R9vdDjpsefH7V7rCcnZaJVh8qq9s5QYrztlWu9mq8GuOfam4oe?=
 =?us-ascii?Q?Fr6AZIfkMMVFelx4gr3TqhY9hE3QqZeAUcTZE69go4TBIdg/BVr5RbPFl8KX?=
 =?us-ascii?Q?XID2YX5/OaqD8IJby68Smq7nkGLnPzzgge5widwEptvc0bpU4EcxU0OzDGwZ?=
 =?us-ascii?Q?GqrlLUgZ9mUifp1Y5JTh2/1FF5IQR3xL82qSli9gvx8JvXQGxKBvHIVUuFxE?=
 =?us-ascii?Q?y1D1gyK5ZgwTFOkQbQ5Li6tlect5CQEIEyUmSwGFGSeQ0o0G6Njrfo5wb++0?=
 =?us-ascii?Q?aq/DtHcFHnitnpBG9MgLqbe3ZtkLxDOEjUyb22sSTFU9IzSCQcizV+zHD3Mn?=
 =?us-ascii?Q?4rVm2bWQgiNqs7nnLtTryfqgRj69lcJgyQMtqdeUqkLOyYWVw/j+w2jzsU/b?=
 =?us-ascii?Q?Cx4GijZz4H6mDG7LhGRgdv2V3vVGXrKQzg1KKJqMUdnQP3TOgHWE4aC0Jw6b?=
 =?us-ascii?Q?KugMP1I1HtyDlrVcKFbDnOUIygjulxcPXe90X12gQ6LezMRrDtMMs+XZ/isf?=
 =?us-ascii?Q?XI8CNcZeAXlBknCW7/HkHl4y7ZBKtVjbKavLgLCrpChEuEe4u1j3RmTpjUF+?=
 =?us-ascii?Q?8a72FQH+emSZQewFdKCIgsq4akt2XneR++sfehT7AMo7ur1lb8a1TYgyDLRs?=
 =?us-ascii?Q?NoTlc4k1Uusb0jjsUv/nqX4HRSM+tqInGFUhBw6zvqygFZpuBfxHQLHdpar5?=
 =?us-ascii?Q?2lFeUJ5E5Ikm+fIrChTIPRhcFDQVTBCA6hJnGbyVNYkuG3ELfME02Z0nhHmj?=
 =?us-ascii?Q?5LU4irLYShvWT6ALFVvld8TosHOcmCfdUt8Mva3ZOlTpABov5sjnAshWgdFH?=
 =?us-ascii?Q?/pPLB98U+NTkWV4amF0fXCLd/gL6oAc3bT8gFNXtNyCwGFv6GKJJ02G4jlbi?=
 =?us-ascii?Q?qIGqXPk3VPOCJiDurM6rwNVgMt5cZmaemwMRSSGq7V11DmA0oUt3m4O5XLI2?=
 =?us-ascii?Q?zanfNgrzFHnLWAHwNWzS37zjMiv5QLtkPEikEWS5X3Rrt7u9MnjV8EWWfCk4?=
 =?us-ascii?Q?V7P249rUV/vAxPOaA/lDDH7Hy+yXHjk8zAe9igyZDbtly6oC83F5+xMcIUfK?=
 =?us-ascii?Q?5PylOxtKeA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6536740b-dd0a-4c82-5f77-08da52adb6d1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 11:12:07.8997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIXUkuqxSadAnzk/FwkQVd3dCv/jtWhZSKjV754b2esi7nYjLku+0M23stCtL7DQgj2FwS1UOJItNhJAR9T/+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1990
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Song,

On Fri, May 20, 2022 at 04:57:50PM -0700, Song Liu wrote:

... ...

> The primary goal of bpf_prog_pack is to reduce iTLB miss rate and reduce
> direct memory mapping fragmentation. This leads to non-trivial performance
> improvements.
>
> For our web service production benchmark, bpf_prog_pack on 4kB pages
> gives 0.5% to 0.7% more throughput than not using bpf_prog_pack.
> bpf_prog_pack on 2MB pages 0.6% to 0.9% more throughput than not using
> bpf_prog_pack. Note that 0.5% is a huge improvement for our fleet. I
> believe this is also significant for other companies with many thousand
> servers.
>

I'm evaluationg performance impact due to direct memory mapping
fragmentation and seeing the above, I wonder: is the performance improve
mostly due to prog pack and hugepage instead of less direct mapping
fragmentation?

I can understand that when progs are packed together, iTLB miss rate will
be reduced and thus, performance can be improved. But I don't see
immediately how direct mapping fragmentation can impact performance since
the bpf code are running from the module alias addresses, not the direct
mapping addresses IIUC?

I appreciate it if you can shed some light on performance impact direct
mapping fragmentation can cause, thanks.
