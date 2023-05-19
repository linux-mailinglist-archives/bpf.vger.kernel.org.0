Return-Path: <bpf+bounces-963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727E4709BAF
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 17:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F95A281CDC
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 15:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FA211193;
	Fri, 19 May 2023 15:51:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB1011182
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:51:48 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265CFB2;
	Fri, 19 May 2023 08:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684511507; x=1716047507;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VMntAVk1QBz7RaGCiSG6A0nACiQ4LKGuiYktrcdelVM=;
  b=dCyaY6e4mw86vXRFNpWpvg0Ky7RaKHiFmSLgfatCWmuHVEpb7T4mnvu2
   OahU0GQ0aPpLeN7gApdlaiffE35TPCU0Kyq1wBwPr/tQTJh0+X7eaW+LE
   A7vejtD0DGNSWvGfmh3jwEzWoehlYWgD3qEl9vNbIOVhsXmFPkHlSmV0e
   wNn1wSX+JsWgA+TSZKEaCpHG3ogWsfgRu0wXw2vbHYRqQiEuScRrJZb+T
   ckMhonr/uZVyxMN0yftQ9lgj71KdroDChIlqvPfuJMJoKOJYBr8G7NPyY
   VQsmidUp1ALAPDr051fhJdoah7m6M1TN2PRFeUg1s/hRFzvDPrzGWkNCG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="336998977"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="336998977"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 08:51:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="653099697"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="653099697"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 19 May 2023 08:51:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 08:51:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 08:51:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 19 May 2023 08:51:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGznJVGr/YiMfaHOFA4H7iHcpUNDBWgQsdY3bff6vKrPQ1fgTO6uEBCOX050estkm+1Jvj1zm8LlurjeAXfu+1+brEd9Rmc+saZMsTWWq5F2tDIeTlF0iXNQutfPwfFbGa0XUOPAvnfplOU9USvU3UZ5oxWHV7o572MQF9u2/4529lFSv14ml8NeaNFB5mm7BO75w8z8Srqu918A4wHO+UP02/QmnqHST8RSGODPSZzYxh5kFKDhfAy9TObRgy/Ys4Rh2siN1JPGA190ja9RcwW0HS7O3l5N4WteMMdKQ+MLAcPcZTgUeJNCAVc4gQ1R6yuIDoWfQCwhPZX+2YkmcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i91NkKWC38coTwQp53tTvOGe3oQ0QVkadMVskWCGi2c=;
 b=ZD5d09SPduUguYRmMNOqt9abm5YLQD+yKYvJHVu0MxWyLeZoEQv12IVKMhYgxa+WcSXBjCIgCgvGAH5q+c/dJV6uM4oUmZGMhX78YtIHerDg1eHudIJkyTrjlA20CLoziZ7uuFxSREoeAdd6Vfpfl+zEleAUZaBLrCNxmctHn6Voh+UVbpi3Ft0pCK4URwHNXXkaIa4elJKe09sWP33XYglM5vRhbFvfkgdNOt+ZqFPLBgELKO5Pfaw8+edsjghxuHM95g+g2d81fBl6WWazZdpW0cFxWoY0TV91QZmcTNhxO6JSRF6rklbl+9dJ0uGPyupJbc5axtcTIOXydwA/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DM4PR11MB6261.namprd11.prod.outlook.com (2603:10b6:8:a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 15:51:44 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::64d9:76b5:5b43:1590]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::64d9:76b5:5b43:1590%2]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 15:51:44 +0000
Message-ID: <e6662717-61a1-3e3d-5804-66629a1691e2@intel.com>
Date: Fri, 19 May 2023 17:50:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH modules-next v10 00/13] kallsyms: reliable symbol->address
 lookup with /proc/kallmodsyms
Content-Language: en-US
To: Nick Alcock <nick.alcock@oracle.com>
CC: Steven Rostedt <rostedt@goodmis.org>, <mcgrof@kernel.org>,
	<masahiroy@kernel.org>, <linux-modules@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<arnd@arndb.de>, <akpm@linux-foundation.org>, <eugene.loh@oracle.com>,
	<kris.van.hees@oracle.com>, <bpf@vger.kernel.org>, Jiri Olsa
	<jolsa@redhat.com>
References: <20221205163157.269335-1-nick.alcock@oracle.com>
 <20230508180653.4791819e@rorschach.local.home>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230508180653.4791819e@rorschach.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0048.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::36) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DM4PR11MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 894b93cf-6e39-408a-d494-08db5880f1bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BGkuy+llplIQE7fEda2hjE4rXbmiS/BfOQG0RS0UeCP5kF6tUEvV/zFvk5indJUa7KSUE/xg34w84DjTY0YHeOKidn0hWck9HfhiZd669R7FbdED34rutTvjgpi+3CSqs6Oztu0OFwRYpdSpidqF+tJzUcx4R1rByWBb0LbaNpy6JAsHYJT9hFin7E5PI4h9EhiJITSMEH3FbxMtwYtvHhb2DRK0yAtTv18++HKjm+LWkHrQTkyKxZMJKaftGEjrxyYLh2ACdmSUNDq7Ba1ke7U4u6vrbH2QEUDsoLk/uwoOmuLnzyCiF/KE/1OlBfInEXrCtU3KWgYx8le3wQS4cPJQk097I6Flx2GJMSy3ZZGhQHk4WU9xTfNJU9/0hvYzi0CK5STrtT6jXbZJsIv83W2R6FaHvtmNgPeHyxnqR/wooX4LintoAu+z7lnpZkQ97x1PKxiYSr9xV1+S5ZEul7GtZk0zm65cH8E+V4pJMEch6odYRLSjdxN+7OwdzYmbLJvtef/QNyFP+5T6qM6tvAjWzjS6M4krZr/6KCcRdryycRx0QZfo5Hh/5bLOOBw3dl3iXR08g3H/Mi/e/AwlQ76ZocB1gmZoH+OmIziNGGqaQZl6LoijmvwQrYpObWHdd1xRHOUNUZp8RyW2mnFvDnly3GTuHx3AKUxeLN6LAEuoGWOUi1ragRT266cWnL6U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(31696002)(86362001)(36756003)(316002)(54906003)(66556008)(66946007)(66476007)(966005)(4326008)(478600001)(6916009)(6666004)(6486002)(8936002)(5660300002)(41300700001)(2906002)(7416002)(8676002)(38100700002)(82960400001)(2616005)(186003)(26005)(6506007)(6512007)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFlhUEZmNVpTSXZ4VjI0SUttbFJEMUtUbXZxZk93NzVPc1JJdGxxSG05Y1hP?=
 =?utf-8?B?L2FLQTFBaHkweW1JS1lrMFc4eFYxWXJIM1p3TlFFQVAvRnJVMGpKN25hUStF?=
 =?utf-8?B?OTR1bzdZd1J1U2dUTDNzWURjNFVZUGFQNXIvdlV5QkhmVFpodjVGTVN0TWE2?=
 =?utf-8?B?NDVYN1JuUDExaW9INVZ0dFBjSUtqYTJMTDNwa3lrdlM2dGM2WG82NUVwQ1dH?=
 =?utf-8?B?MGFIR080VnhVaWphR2ZPaWhQbWJGOHZoSHkzYWN5SmxBWWdCWGlkV1ZaZmRN?=
 =?utf-8?B?M0xDUm96N0ZVUllLWEtWWnpCY0d3WFoyZDNFVjFkNmJSQ3RNR1JqdGloZ2Z2?=
 =?utf-8?B?dnN0OTdNUnQzbVlQYk9pa0VjcXVBNDRzZW1XdGZHZG95SVFrYUNMWldZcUVL?=
 =?utf-8?B?NERzR3Jnc3BWVm8xSy8wYmw4VC9pKzVoLzl4TStudktkOGRoZGYvTHRRZERQ?=
 =?utf-8?B?SU14SWtwWFZBL1hDZm9UdTQ2OUQzc2Z6a09pMm5tL0hpMTJlR1MyeWRBZ21k?=
 =?utf-8?B?QllKcVEyUWYxZSt6TXNURTBwQmpBT00xNTBxeUtpc3lBTG5hNXRqaVQ4RVIr?=
 =?utf-8?B?WnNRc0RJS0FqYnVXek5TQzFkNUwvWDlzMjJJd2k3WHU3NVhxUHZWWjRmenh4?=
 =?utf-8?B?NHlNMXoxVk50Q2Q4QzJXK2pScGNpb0tEclNndW5Ja1pHY2VZOHlLSFgvWU04?=
 =?utf-8?B?OEVYL3d5bTBEVHB0VXlGcUE1UzdpOTFOWVVia05pN2xENUVzaW1Za295TEhy?=
 =?utf-8?B?ZkdvTU95dDQvNmh5TTMrTGRkcGNZeDZyVU9jZGIzVmJVTjhoRW1TZS9Vdmla?=
 =?utf-8?B?RGNyd3BEQW81cmV6QXFVY0x2S3pKdmprRDIvQ3R2RElKdjRCeW1tUTBCZUZU?=
 =?utf-8?B?ZWxWcFRBdzFiVnJwMm5CcC9DbGlCUU5ZUnU2bHJhK0EzQjRZaWNPQ0ViblJi?=
 =?utf-8?B?b1VVdE1TN2hUbS9BVWxhSCtKY3o4eVNxckNwYTZJclhOSlFBc0dVWGZxVHU1?=
 =?utf-8?B?eEpzUy9KTzhlQlNidkVnTjExMU5lV29JbWZ6WUtnUmJHLytoSUF0TVhleEU2?=
 =?utf-8?B?NEtvRG4zc05MVysyQWdWNmh0Q2RJTWVGSElmT21CakEvRnloZ2ZrSmF2SDdq?=
 =?utf-8?B?Nmk0VHQwa2FIbndhVENKUkU5VDhEQnRxWjZYN2Y2VnV0Z3ZsdGQrREhXS0JX?=
 =?utf-8?B?TnE2ZnlZYmxXK25jb083NFhIT3MvcDY1VDc0TUhVb2Q1Sks0bHJTZkY0WC82?=
 =?utf-8?B?U25hUkJZMUJRTnZHQlkzVEZRdzZVRkhuY2ZmV2duUjhDdjlUSlRCMEx4Uy9S?=
 =?utf-8?B?dWVWckdrSmduNWZ3MERjZHRHK1dndzBKZGM1NWliZit0Y1FVRjdyZGU1M21p?=
 =?utf-8?B?UWc0TFpjN0hkVytESHVTVVZVK2ZibWU2NGF2ZmNoZFRMWVJrdGhzeUZ1YlFr?=
 =?utf-8?B?OEttOW5YUnZmZHFCYjdMSjF2bjkyOFduR0NHeEtyeDBRVFkxOTVBT0pkSHVk?=
 =?utf-8?B?R0g1OGdvY0tBeXIvRWw2Y2krL3RISGpxTDN6U2NPN3Y2N2F2ZmU0WHBPNnZu?=
 =?utf-8?B?YVA4bVpiaGltUWRvWE8rSm1FbXlkVXVyRkVKNHBVOG1YSmxSbVpnV1ZNUHVR?=
 =?utf-8?B?amhFL3VxYlZseDh1c0hyTndKcW9qSkhXK0FOMWtjYkJpdXNRZlU4VG5QRkdC?=
 =?utf-8?B?QWNUZm5URWNDcGROek9YVzdQSExCNmxtNEM2YVU4SFZZdlJLelNMeWE1TGQy?=
 =?utf-8?B?b0FmMWtuS0pqOTdYTmdCWUVWcUhHWkJtOG81NGdxNzU2ZURBQ3lHSDR1aEZl?=
 =?utf-8?B?UnRqUWVsdms0dUlpc25LN3JEMlJnVDJyWVpWN2wvTCsrTkppcHJqVmJ5SE91?=
 =?utf-8?B?T1ZKVzhPei9SZUE4d1NMQXg5ZTdkZldJbmJ5ZGN4R0pxOGEyaHBHRTN4Tml2?=
 =?utf-8?B?dWtHaVRieXNIdnBCSnJTU1dDTEkyOHN0bkFSREF6Rlo0S0M4TlVQakZFR1J2?=
 =?utf-8?B?aGsxc0t5WFh1WFZiblY3emY5TXpWT3pkYno1ek1PNDFkVjNnVEdzREtZTUNl?=
 =?utf-8?B?c05KSHkwQVh4RVlrdkprS0hUQW9acGxLeTJVWEV4enc4MGRBNFdYb1BWd2Yz?=
 =?utf-8?B?QzdqQy9ldHVWT1hkWFdLNzdkOHB6NHVyc2VuZkhBNVV4R2dVaXk5UGFBWDBq?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 894b93cf-6e39-408a-d494-08db5880f1bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 15:51:44.0433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIEttWkD/R4y/7DAmJp2LnO9jgFbOgKaGdiBv/aDOLwEPh6MeT4p5A//lCyKevuCSvn869f3jdIX4cUFhK0cYi0d6ysbRBgSpxas6ny6Mws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6261
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Steven Rostedt <rostedt@goodmis.org>
Date: Mon, 8 May 2023 18:06:53 -0400

> This topic came up at LSFMM, presented by Jiri.
> 
> I'm Cc'ing this email to the BPF mailing list.
> 
> -- Steve
> 
> 
> On Mon,  5 Dec 2022 16:31:44 +0000
> Nick Alcock <nick.alcock@oracle.com> wrote:
> 
>> The kallmodsyms patch series was originally posted in Nov 2019, and the thread
>> (https://lore.kernel.org/linux-kbuild/20191114223036.9359-1-eugene.loh@oracle.com/t/#u)
>> shows review comments, questions, and feedback from interested parties.
>> Most recent posting: <https://lore.kernel.org/linux-modules/20221109134132.9052-1-nick.alcock@oracle.com/T/#t>.
>>
>> All review comments have been satisfied, as far as I know: in particular
>> Yamada's note about translation units that are shared between built-in
>> modules is satisfied with a better representation which is also much, much
>> smaller, and we are no longer using modules_thick.builtin but Luis's new
>> modules.builtin.objs.
>>
>> A kernel tree containing this series alone:
>>    https://github.com/oracle/dtrace-linux-kernel kallmodsyms/6.1-rc4-modules-next
>>
>>
>> The whole point of symbols is that their names are unique: you can look up a
>> symbol and get back a unique address, and vice versa.  Alas, because
>> /proc/kallsyms (rightly) reports all symbols, even hidden ones, it does not
>> really satisfy this requirement.  Large numbers of symbols are duplicated
>> many times (just search for __list_del_entry!), and while usually these are
>> just out-of-lined things defined in header files and thus all have the same
>> implementation, it does make it needlessly hard to figure out which one is
>> which in stack dumps, when tracing, and such things.  Some configuration
>> options make things much worse: my test make allyesconfig runs introduced
>> thousands of text symbols named _sub_I_65535_1, one per compiler-generated
>> object file, and it was fairly easy to make them appear in ftrace output.

FYI for devs: I posted RFC of kallsyms with file paths almost a year
ago[0], but it went unnoticed =\

`file name + function name` is not a unique pair: in one of FG-KASLR
discussions, someone even wrote simple script, which showed around 40
collisions in the kernel. My approach was to include file path starting
at the kernel root folder, i.e. `net/core/dev.o:register_netdev`.
I'm not sure why no comments happened back then tho. Maybe you could
take a look, I'm pretty busy with other projects, but if you find
anything useful there in the RFC, I could join to a little bit.

[0]
https://lore.kernel.org/all/20220818115306.1109642-1-alexandr.lobakin@intel.com

Thanks,
Olek

