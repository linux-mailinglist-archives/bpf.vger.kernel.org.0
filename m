Return-Path: <bpf+bounces-11275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55887B69E9
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 15:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 864832817D5
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 13:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A10F250F1;
	Tue,  3 Oct 2023 13:10:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959742915;
	Tue,  3 Oct 2023 13:10:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953AA90;
	Tue,  3 Oct 2023 06:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696338651; x=1727874651;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AqhVZGCQWGC4cJWEDVXE+sYJ08BhIF7flAS2DicX4Y4=;
  b=WHmF4aoNR+usE2NLKkxertwlXuPA1BVZPAZpid5u65lAqNInZeIAF6br
   0SQIkEELPNYc/HyukMkoItwPCNbDJPcOhs/of5ZX+Trv0hMXSU5l2wkzS
   TAPdp9FLaCYScGdcR6+PLBNyKNipVahOzLxLYq2nvX2X7U7NaCIyOQJYF
   zZ5zAoby0oH7IE8Pk/krjV11aU4+6vTv0UxR8TOx/KMwOGxBWplz65YvK
   DWAqiFMVJxSXZq9wwq2a8vehN6FoAlYvPVTc7fBnShKOZkxWWCgqfh7y8
   DZcpH2ZTLbmxqK88TRV2lJ83N7o+pRIaSRm4SCqs2QY7KUE/Xep49ClVe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="381747837"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="381747837"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 06:10:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="786087054"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="786087054"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 06:10:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 06:10:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 06:10:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 06:10:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 06:10:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHnjy478aYkR5qlrP7IjEJUhQTn8FultVtn99ff7idcpgzCKakiojg8LJjNOnfNLNWMEhfZJpPocjUDPMIUWwawcZTGmFM4/t6b1XmRaw/qbZgktPPuhvQDYqN/VpPlDfYJWcAeyIOTpvBdUv/7u2BcdzG4ZYrwDsVXrtel85IVnZPpfqqWvHhLoCHzxiVRN2z9ZSHXTmXPGL3E0E/F92hEONy/0I/iqXs9tZjTyRG3C3hQXcaOenaV3Bba6qi5ok2LqGiQh7wVrh4r2zD2yNMpWg6ImfavUZyBBY5xxjj1vzBKI3f/Llw2pfq7FrnavSaONJzzbZ04Hm8qRpX9u6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9d8jwc2b9sinFXKt247ZH5BVkib9fVJ+2sE2PbjFo8=;
 b=FxF4rcKXkjwxMvhkIiCEZN836LUiNg2Dr010GyIeYTsFl42/zNpZA/+N4RWdeb8ziWDZQl7EewbHzQrtOOXhHOmWnNr2vNmifxO5z4yt6yuQyDP+hqMB/tdZBJvrmNzLdrXJwznYSW3BSfgDTzN8FmDzkClcndI+JgSvv6xAepg2iENhjNWHNIQPAdzQrmnj/jPXRAXNj6lucdAop5BwHDYnOcxjCtqDbfPVC/zRd8Zg4HRv8zzi+Hdq2lCAfhLa8tTFgF30XJp1iO2a9DqU5LpGokiOcDy16dX8dhXOhLQMjmpt7ziEWCcBhweX7aPvexG2apB+k1cnUm39h8960w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SJ2PR11MB8369.namprd11.prod.outlook.com (2603:10b6:a03:53d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Tue, 3 Oct
 2023 13:10:47 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Tue, 3 Oct 2023
 13:10:47 +0000
Message-ID: <8e9d830b-556b-b8e6-45df-0bf7971b4237@intel.com>
Date: Tue, 3 Oct 2023 15:09:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC bpf-next v2 09/24] xdp: Add VLAN tag hint
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Larysa Zaremba
	<larysa.zaremba@intel.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer
	<brouer@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>, "Alexander
 Lobakin" <alexandr.lobakin@intel.com>, Magnus Karlsson
	<magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>,
	<xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
References: <20230927075124.23941-1-larysa.zaremba@intel.com>
 <20230927075124.23941-10-larysa.zaremba@intel.com>
 <20231003053519.74ae8938@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20231003053519.74ae8938@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::17) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SJ2PR11MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: 411cee8f-9036-42b3-bfce-08dbc4122825
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ru2rX4L7AI8jdLKZfcEzhJJFugTPpVVzfMey7RYllMmEVaEkSSNdZqvJHt4dzX6RseL9VFPQYORJJOr0RLX4uoNCXGJNz6U2bgtZevNGuPMGWO2fVdjD/l8PplvK+kU5IluiRhJ8UgKIIdP/sbohMB6pSEtW3z7lH+RLTGJuYK6KTP+6m2mk0rtCV+uSAYTe4UGiFYeYKQDDuk6nl3y3q9wUVvTa/pxCk+KRa9/l3qKeDAxXqwh8jJgnyfg0PU3mN5CBHw3LnIlo8nssiIHW3Mf7DD4vYMTyl4l2/2qwGY0qUj+9nIrdAfb/QafKl+k9WW5s2HvX2ZnRFPoCzlH5/2lAveixtTh4c5ZlzzLzbM3LjhsZ5S+e913AFig0V/ddaeOLGsdEhpFfw7qYukp3wX1UyT38aEsJYtJiMd0ZtlbT7FdwunbRBPUXVMVTbCnCOMVax5J8r8hTGed5GYCj+aoJ3lwZJUaGr1KjP02xtzQUfpRwpqmJpGbwMa52MM+cmQDtTVaz56ybKwQqrJdUS0DqXK6XfG+k0iPaniGF+g98vVkAmV/MhA+jAMkyEYzXKDCPI2GGqeD7Fms71yXQEzV7mD4O1aQNo8H2cwj29dBZwSShuPC/nHrbWbT4wytNMd94dTKgVXGZ9wZA3DnAzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(136003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(4744005)(4326008)(54906003)(6636002)(66946007)(66556008)(66476007)(41300700001)(316002)(110136005)(7416002)(6486002)(478600001)(8676002)(8936002)(31686004)(5660300002)(6666004)(6506007)(6512007)(36756003)(26005)(2616005)(107886003)(86362001)(38100700002)(82960400001)(31696002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YThyejZKRFNRMXJCSFJ0SkkvQVZlSDNKc3psWlFJajU3MVhieGFPSlhacWoy?=
 =?utf-8?B?MGkzcHdhVkVaMFpqcXdnWlRTNTR0c2g2azNwWDZCQXZUYUpFSitJV0RIeWV2?=
 =?utf-8?B?Qm5FdjhrSkhFOUtVZmZCVmlncXFVV1NROGorcWFHSlhNWWsvMFFpSjdTb1N5?=
 =?utf-8?B?bTB6b0hRaGNEMDNldmVTSi9mVmVSVHo5NFJuQnNTUm9WNUU5bG55TUZCeTgy?=
 =?utf-8?B?T1FnZTVMYkxCem9MclErN1R1eGk1cXltOUVvaEJOMUc2YllQYlFHN2RiT210?=
 =?utf-8?B?R254cnlRNEdpTWxJNU5IU0ZydGc0VHJVVm5uNXc3ZmpEWjJ0Wm81cHZhMnQw?=
 =?utf-8?B?NnZNNU5nMlY0cFhNVFphU2RWbUVmVDkremhMNDN3NDJHcmlBTkFUUWIwQUZw?=
 =?utf-8?B?Y2VTK043SG9DUUZLTC82ZnhxZldoM0pjNHhpMHVRSlZKVmZ1QnhLRC9teGpZ?=
 =?utf-8?B?UXJ1QzVJNUxHMmFZWjMzZFFJdS9WNFRROTdSSDhLTEhXdnIvN0U1VEF3QnN1?=
 =?utf-8?B?aFJkck1IMElTOXR1UWtDSGZsRGpxRFYvd1BDeTF4Z0c1bm1jc0NTVkhpenZY?=
 =?utf-8?B?QVBnbFRNY0xQOE1mZi91anZVN25XN2RnYlZxdUFRWGJEcFdJOVRaRVhlRWFu?=
 =?utf-8?B?aGhNK3ltV2lwSklJTXRNcDRmZStqOU9hTXNGc0hwUVRacXZLOXNUejFDaVpm?=
 =?utf-8?B?Znh0OG5vYnlXZm5aU1dTcjZ3U2o2QkhDMDJSZXRwTjFZMU5LSElvOUhiU0V3?=
 =?utf-8?B?VTlQdElTT3ZaeWEza05BQUh6cWNMNnZzK0laRjhqZTAxV2V0Q0NQVW42SDU1?=
 =?utf-8?B?ZFN1eXZTUzByY3BUZzBFZnNsZW5UeEtVeFoxTVI4R0xEbDl5c2VIbEZNZWNo?=
 =?utf-8?B?L0tLSDd5Q2E4MDc0YTVkUzdNRXBmUkRrVXZVckJOZGw5RHA2elFKbUQrQkRZ?=
 =?utf-8?B?TCtGcHJjYjI0RWhXZnVyYjM0b25BVmg4T1NjTGFRaHVXemNjWkcyYXpMcEJ0?=
 =?utf-8?B?ZGxGR1BjTEFMaHpqelVYNEM2TEdOdWFXb3JCb3ZmZHZYN0Q2clNqWDhNVzZV?=
 =?utf-8?B?OXgvRTJ2THI1STVJMHh6cTdrK2UxV214QkI2TE5FTDJkL1pKN1pOcEN3cW4y?=
 =?utf-8?B?cHRDS3NtSk9qK0VZM3Q4Y2d4bTV1MEUxT2QvbEFVeFk0ZThSeFowY201RHh5?=
 =?utf-8?B?YWUyRlBMdVVFU2RnTmNVVmFQb0ZtMis5Yk1DUXhPRGpHU0xPZnl3K0RhZkg0?=
 =?utf-8?B?aFc2TFAyeEExYXlEN2NxVit4aGloVkNoLzh1WGt6MDczV2FEOUIvMXJMWWxy?=
 =?utf-8?B?OFlyT1ZGaWp6ZUl4b0FQeFJONTB4VmhzdlRuaWlZNEVSQUlaNUx4VUYrd0Zz?=
 =?utf-8?B?M2w1RUJlNERnSWI4UmNMZzBYVWp1dzdxUS9UY1FGalkvOEIwVG5ac04vQi9X?=
 =?utf-8?B?bGJyWkY2a2FjMHJqa1hKVkYxRWZZK1hMaHhxcktibjU0RmMrWVZ5d2QzQ2M3?=
 =?utf-8?B?QWVnc0pTWWR6aTdzVWlRR3FmZ25aY2k1SnRQNjhRRmNFQ0RrU3lRZnBtNlBu?=
 =?utf-8?B?b3NHV2lCUGNNc1huWmE2bHNtWTRCWWM0ZVpNa0I5UnRLbldxb2swQlNkdit3?=
 =?utf-8?B?RUVwc1U3VlUxcXJUTXZEbEsxdmQ1WmNuMmFWR01kNk5SVUpJV3FLM3dGT1hj?=
 =?utf-8?B?Mzg4NE9PVFBZYjR4RWhYb1JYeXRCMkozekl5WisxaXFTQjMzMTB3VWxhRDQz?=
 =?utf-8?B?cUpBQm04MTcwc25oQVYzcXVaWW9aTnBaUkJESzV6VHQ0YXRJQjV2bUhKZjZQ?=
 =?utf-8?B?aWJjd0ovV09RR0tIOE83VXNweEZmV3BHbGRYZTRSQXlBU3JpVUNSeGpZZzhT?=
 =?utf-8?B?NWY4Qjd4clpyUlYwTEJSS1N3bkEycVRMYjNBQjc1Q2NWSGJYNkJINE91RmVu?=
 =?utf-8?B?M01rN0x5bFBCVlN4WHpJR2hycmRUS2FEYmkyYzNYbTNSNXRpQ2orRXBqVk5l?=
 =?utf-8?B?SHNGNVJvd0tVZGxkOGhlY3FJNm1CR1V5b1pMK1dPZWpEc0ZKU25udkc4b0I0?=
 =?utf-8?B?dnltaThxMi9KekI1MHUyWE1wNXNieFFaMGN0MWZmQTkzMitvWVBMbU92OFoy?=
 =?utf-8?B?Y0JSd0NVV21BaWwyRGVNQm9ZSGxldkRMMkROMEp4WXp2OHZrQm4wYzlkakk4?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 411cee8f-9036-42b3-bfce-08dbc4122825
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 13:10:47.2386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHNkKKFtq19pjfMHEAmbemP4DkG5mPv01YHQxryTnNLpiMnNunys03ElZNBOviLJPzISOws9JdVl16QroRXJ7Laee38kVo0INJYkYH8KpMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8369
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 3 Oct 2023 05:35:19 -0700

> On Wed, 27 Sep 2023 09:51:09 +0200 Larysa Zaremba wrote:
>> Implement functionality that enables drivers to expose VLAN tag
>> to XDP code.
>>
>> VLAN tag is represented by 2 variables:
>> - protocol ID, which is passed to bpf code in BE
>> - VLAN TCI, in host byte order
> 
> Sorry for a random chime-in but was there any discussion about 
> the validity of VLAN stripping as an offload?
> 
> I always thought this is a legacy "Windows" thing which allowed
> Windows drivers to operate on VLAN-tagged networks even before
> the OS itself understood VLANs...  Do people actually care about
> having it enabled?

On MIPS routers, I actually have some perf gains from having it enabled.
So they do, I'd say. Mediatek even has DSA tag stripping. Both save you
some skb->data push-pulls, csum corrections when CHECKSUM_COMPLETE, skb
unsharing in some cases, reduce L3/L4 headers cacheline spanning etc.

Thanks,
Olek

