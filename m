Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F3452C016
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 19:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240527AbiERQtl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 12:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbiERQtj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 12:49:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992381078A0;
        Wed, 18 May 2022 09:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652892578; x=1684428578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q+bhvzt8wt4g80Hzx2cY0R5pyzk0egzhTGMX3cAQPTc=;
  b=B4nKFwFA+D++dHZmsryMSujsIbi4MHZe1IRQ63apB168gYJkMtXR+vr/
   T4r/m7ARKGwKt0n5r5SewWSIZTWqWHGp3STo5cCTt1Fx/CtSb0aMAX9mx
   d35ELtm9pHyhHkqx44Xs/YfXjeyvMoCXMdHbejsHCHtKnxLe07ra1hIt5
   VvVu9PjHVKAubPVmkr5jE1PhNjUhpjOEnY1o4daobV/aZJK7PvXDIUHNW
   LEJuYHIsrHNzHKee9NaF7HT5wFdZu8mhA0Jal8j93JFhZR1G8MLh3AmGC
   yzmaZVGotuTDs/UrkTL3ZsJTxRhpQJQjLgIByZoP9/5M4El/uFdbF0vOs
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="252293015"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="252293015"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 09:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="673531181"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 18 May 2022 09:49:37 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 18 May 2022 09:49:37 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 18 May 2022 09:49:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 18 May 2022 09:49:36 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 18 May 2022 09:49:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ML9YWUXupeAwfAg5ZSnhh7RINGIBJy2AZFDrc+qHEJAl7eoxuVqAF5HqAs9KeA7t+ZaXiVNJXIZShqRbfheX/PNc/s2TikUUMyP0JmMOxMloVFypPK0ktaOwFcBoilmdDfttcjMEfDpChTbWjN+HKOi96F3fKoxgRUV6hCfY6/Lw3kz8ZxM2Pw+YGobqmYTc08sXUjYTb6jvCLPdiXzxLCPNZGJ9LLMZhbMmThOSArQlktK6QIK2h5Ct0+MDs/KaxBRBsnUDN8AKE2SUOc/C4Laujyn69BVoKTcwsy4/jUUWlSr37YIXH5T6uZmbTvq0OgAbLjdzCdeauRMSRBJzjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+bhvzt8wt4g80Hzx2cY0R5pyzk0egzhTGMX3cAQPTc=;
 b=LfzkANm4QiBx2w0Q33UHzMmjDjWVElkHYIY5TZqKwjdzo9DDBHeo/LsilbuIOpr8+bBhQlvJSSlhm0piFwJe7BoL993HX3G9X+zMwDUsV21OZhBFWylqqEIjt68zmH7QOXUU4vCslqcOVPGi/eCRTQLuEE76N/JfEwWwmOzZ9mfuIi8Xm+8mF7yUpakZOtZkz1ecycfNUbIpUzkZN29STuWn8XA7sHTs5Q3KX5z0oPNXUq8OFIRKzd9Ydii3tYSGdNyGDqBQ88uNOMAnzFNl5m+uwmnFpEbIJ/BNLl+xk3XpSH5SIzBS8cf01iUqM+4iDuUm4d2LILsPLMkgo3dxtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CY4PR11MB1815.namprd11.prod.outlook.com (2603:10b6:903:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 18 May
 2022 16:49:34 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5273.015; Wed, 18 May
 2022 16:49:34 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "songliubraving@fb.com" <songliubraving@fb.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "song@kernel.org" <song@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next 5/5] bpf: use module_alloc_huge for bpf_prog_pack
Thread-Topic: [PATCH bpf-next 5/5] bpf: use module_alloc_huge for
 bpf_prog_pack
Thread-Index: AQHYaOe12KXACXSTpU+YN3bK6iMF8a0jcwCAgAAfpACAAC+eAIAAbpWAgACr2YA=
Date:   Wed, 18 May 2022 16:49:34 +0000
Message-ID: <3ab4c6cf8158891167c145015bdf5754f972223a.camel@intel.com>
References: <20220516054051.114490-1-song@kernel.org>
         <20220516054051.114490-6-song@kernel.org>
         <83a69976cb93e69c5ad7a9511b5e57c402eee19d.camel@intel.com>
         <68615225-D09D-465A-8EEC-6F81EF074854@fb.com>
         <dc23afb892846ef41d73a41d58c07f6620cb6312.camel@intel.com>
         <42042EE3-EDDF-4DBF-AFD5-89A5CCC59AA3@fb.com>
In-Reply-To: <42042EE3-EDDF-4DBF-AFD5-89A5CCC59AA3@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd387f52-083b-4ed7-eed6-08da38ee6337
x-ms-traffictypediagnostic: CY4PR11MB1815:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR11MB1815C9974A2DAD7B84D6422EC9D19@CY4PR11MB1815.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XLm9Ars/8HInCeVJ3JEikQeB7qPgOMjyRR83+v5YBd6EVTtynDwSfRTcc5wP8MhLl2M1FbrgNU0UerbL8fLd/rPdJ+C6yl3KmaDlp5yeJISOQqh6Lrb4jsmP5m8OTXHI2O8x/umxNfpSxDIRQJN7CrRiP0zuNfAcDFOy8/I4VihxLYlFZpXBS9yc0T77KNqJvX5+BBtiznLkxuxaO7GTO/V90oHpwufWQfCKEj+kfx7ASneFRvGAa0z+BsaRp5G+Z2CFzzwboMXo2QSKItTCFFohOjdxt04X/N3CWCav3e2zXMvD2Kl/mc/2h+Q4117Vm1I2heCoOnFdsNtzrGnjR+lmUMT8Me+cRo36L7/1UKafr+2afOrAfyyy6xyj7iyED389UWLl4GuGdDzlbzVmQ4w5mQMrr2nFeJZmVHf4OP9A3j8cFGFESIr4cPvA09BGgzrRkCNP6kNrSq+WAvj7Ek/j6cnRN4LiuUEJyzAAeEKRV73jpWxDlumYSllajT6J0ycE//bB74isHmtMOmMJQleldXpsT8Po1t1AAbqZBZAehOiUw7ky9aWYZJUQ2o/hotf0/ZtDuAaS9+EPCy2zMfAKhSxFiZXuQoLsZ/ruv/fqPvX85+WnK6lUZlkaBziafjPfMiHaxTXorNuK3H1WvDmyAwwJV836BURHmySRDOqacwtK+UGv8s7ETkLOLx7qT0qWMzLuS7IefmVGABhe7QLikv3+eLNJg8L1TfltJZgwbNPAXLQXIp7PGjPfnhzzu9aKYm+kt37JAIhT98/ucP/KKBYvShWDW6ypg/2RP66gNDfzJQGF6qw0bjxL2B3KFlu4OfrL72q0Y80uhlm1WA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(5660300002)(8936002)(71200400001)(6506007)(186003)(83380400001)(76116006)(36756003)(91956017)(7416002)(2616005)(26005)(38100700002)(6916009)(54906003)(966005)(66476007)(66556008)(64756008)(6486002)(316002)(2906002)(86362001)(122000001)(82960400001)(8676002)(4326008)(66946007)(508600001)(38070700005)(66446008)(99106002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eE05R05UZDNDbWM1VDBERWgyV2ZJUEhUbUZURk5XblpLU3BYVm1GZE8wMW1o?=
 =?utf-8?B?Mk5KZFF3OVl6QU0zNzl5MDRXRVNxV2JTVU1BSEVYd0pEbWxuWE4vQ0RUWjZS?=
 =?utf-8?B?WE9CL3pXMWNwV0JjRmppVmJrT1E5UlRuSTlCSUxqNnpmcHFXVnZZdWhmUHlj?=
 =?utf-8?B?MmQyTzA0VTdmMk9qaGdBNmJkai9kZUI1VVYvNEtGbEZmTlFqMXJORE5GWGVs?=
 =?utf-8?B?S1dGM2dnNGNSL1Z2R3hkVTdjNDZWcEJzV29UbWhOUGVVSnVjRVUxUDdiZ0RW?=
 =?utf-8?B?aDlJUkJ5dUUvMXNCa2trc3ByU1Z1NlE4WEY5NkYraDRIbzZMZ3VLK2k2a0V1?=
 =?utf-8?B?a0RHelpTdld1eFh5R2VNVzE0YTBMQ01lcWdHdjBtbU03OTBLMXFkSDZTNkx0?=
 =?utf-8?B?RUdPZmdqenpnQW44UTBveSs3azNJOUpoUXhJYTlCV2Vnc0lCNDA1WjhINnlH?=
 =?utf-8?B?dWhTVDVWUUl5ZWFYUkgzQ1ROWkNnbitCQjJnNlFjOW0vR2YxME9CSEJPVzVG?=
 =?utf-8?B?VDdUSmZCMVVnMDJLeENUWUE4K25jdURwM0hmL3l4WnYvcDhoRERvTFBoK0ZI?=
 =?utf-8?B?RHBta2RGdmhFc2h0dTR4Q3M2N09pemdRbHhOaGphRTc3c0R2L2FDaTBHbVRo?=
 =?utf-8?B?dUM5L0hueVpFaVNSMS9sTG1qeEFvblN1eGMyT296ajFYWFpzNzhieXVJL2do?=
 =?utf-8?B?Z2U5dTlRUk9RdTluWWZGZVpFS1RmV3FiWi8xb0h4UURvODM2NEdCQ2RRMmhn?=
 =?utf-8?B?TVBZZ1o0UFlBMlpOdFYxRktNRGRYYTN5R0JyOFVtY0UvNGZsTEQvb3NsTEVK?=
 =?utf-8?B?UEpaL3BMRUs2ZkVLcllzTkdUVjVXV0hyU2FhdkV5c2hSS3htUVU5NmUySUxT?=
 =?utf-8?B?K2N2Skx4dFQzUmNCcUJzUDdFSWNhY0JpMDhpRkNDd1JES3p5cUJOVDA0N0pL?=
 =?utf-8?B?TkwxVUxJcmNSUitFb3QwdmI0Wk4rSWMyT1lrTzQ4R3lVemZ2dmpLUHpkeUJu?=
 =?utf-8?B?ZjhCYnBGcno4SUFMYTRwV1NocjRHSks1M2lrZ0I3YzYwV3RZQ09BdkIxNGZF?=
 =?utf-8?B?QmdwTWhBTSs4MnREdDN6c25JcXdPLzBJUVhaWHIwLzdKanpRd3ZvejhCRmd2?=
 =?utf-8?B?NkNDYUQxSlZvT2JXMXc1MmdtRDVGS051RlpRYWIwR2J0cHBxOC9qeXMvNG15?=
 =?utf-8?B?dW5lcWRrenhMOEpxMFVwSTl1WHYwaDhpL0t5ekE0NmZtalA2Z1lIZWJURHJh?=
 =?utf-8?B?Mzh1TWVGTEx1UDZVaHN1TGFMMDl4dkt4cUZKa1ZZYkZrWjM1Z0ZtdFZqZ2FZ?=
 =?utf-8?B?R1NNcGJVTTFxM01JSEFJNC9XcXErRFc4Y0NLMHAyM0RTeVdDcGplb3N5S1lD?=
 =?utf-8?B?VUFjWUFoUmFJVFFPUjh0M1hiRmJJYW03MjZIdE9iWENvWkV3cWZPckcrM29L?=
 =?utf-8?B?ZFR3UDB2VGwycnZ4ZDlheHFzWGxBby9UZmk3dURxT1RwMUt2eExVdWtJNEhy?=
 =?utf-8?B?cDhmRlB0VERwcmVOMTlUcUk4UEJRUGtMMkFwUUVtaUhYVGVURjJkM252UXdy?=
 =?utf-8?B?NWQweFR0bVhRWHZSdHZ4MXR2RlRRU3ovM0p1R1VVTTVEM3R1VWRNYVRCSmcw?=
 =?utf-8?B?d2Jmc2RWNlF0ekpic3ZTSG8yRWx6S2VURkVmVUJIWlk1bHBlS3dqaWxXUW4w?=
 =?utf-8?B?L3l4OTByRVlYemM4bHB6c3dvUnRTa1lJY21XY0VuYjhWQ2tXVWtiQmt0bzgw?=
 =?utf-8?B?dUtZd0xXSFljcm9ubnMwTE9iNS9HbzdFQUJQQi9CVUhzUUQvNVl0alF3NTN3?=
 =?utf-8?B?RFFhaWNpRkE3UllZUm1SRjMyQWM0QncrWUczdXNrOElmT2FSQ2V3V0llQlVy?=
 =?utf-8?B?NW4ySyswdTVJMjgwdGR2YUUzcFdKeEVKNTA1dmUvUGhQSVkzUnZXQ0dabm83?=
 =?utf-8?B?cTBFMmRhNkt1NXVEaEV3Vi9OZDVpek45MlR5STBSQitkbEhvaE9vRHB5MGUz?=
 =?utf-8?B?ZWw0T29SdVRkVGF0eDdkYitrbDRVcUQyVDAvR0Z5ZVRRQlZRUDRFb3hJOGVm?=
 =?utf-8?B?SllDYUNmOUdlNDcrWm1ZTkxJbW5kQmthM1c5SkNsQ3ptaGtMcHNNWVBDK2FD?=
 =?utf-8?B?TG9kMlhha2pUVGVtTXN2enUxcjVkOTBOTDVxNnJnY1VyczYwNDczOW1PbEVl?=
 =?utf-8?B?eUs1VFJvdFlLVkx2UHpoZUZhcm9FSm9tMlBMYnBwcWF0Wm16NVVYS0UzZDdj?=
 =?utf-8?B?K0dlemNSTFd1OG1rdUxoaE52dmVibmZjMWh0N3VCcXNWYlFnMUFwbVJVZG5L?=
 =?utf-8?B?ZWpMcWhHaEQ4dERCaWh0ZzRJaENteE82UUFocE05Y0tOZTBZNU5FVE9YYjF2?=
 =?utf-8?Q?8QwV8FQxpFkNYHPehIODJCToGo5Nq8iyYlkpT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91C32945991FAE4EAAF76645820E2C8D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd387f52-083b-4ed7-eed6-08da38ee6337
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 16:49:34.3703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SmGRwE0k8tdMUROWoe9CU5QlW5AvcUURgiSR9HrypFw7Wl6FWywC8cOh0JfRzoughzrpSTRONSbmLkQGTXIp7k/eQFjBNfNo027Gp/nZcCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1815
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gV2VkLCAyMDIyLTA1LTE4IGF0IDA2OjM0ICswMDAwLCBTb25nIExpdSB3cm90ZToNCj4gPiA+
IEkgYW0gbm90IHF1aXRlIHN1cmUgdGhlIGV4YWN0IHdvcmsgbmVlZGVkIGhlcmUuIFJpY2ssIHdv
dWxkIHlvdQ0KPiA+ID4gaGF2ZQ0KPiA+ID4gdGltZSB0byBlbmFibGUgVk1fRkxVU0hfUkVTRVRf
UEVSTVMgZm9yIGh1Z2UgcGFnZXM/IEdpdmVuIHRoZQ0KPiA+ID4gbWVyZ2UgDQo+ID4gPiB3aW5k
b3cgaXMgY29taW5nIHNvb24sIEkgZ3Vlc3Mgd2UgbmVlZCBjdXJyZW50IHdvcmsgYXJvdW5kIGlu
DQo+ID4gPiA1LjE5LiANCj4gPiANCj4gPiBJIHdvdWxkIGhhdmUgaGFyZCB0aW1lIHNxdWVlemlu
ZyB0aGF0IGluIG5vdy4gVGhlIHZtYWxsb2MgcGFydCBpcw0KPiA+IGVhc3ksDQo+ID4gSSB0aGlu
ayBJIGFscmVhZHkgcG9zdGVkIGEgZGlmZi4gQnV0IGZpcnN0IGhpYmVybmF0ZSBuZWVkcyB0byBi
ZQ0KPiA+IGNoYW5nZWQgdG8gbm90IGNhcmUgYWJvdXQgZGlyZWN0IG1hcCBwYWdlIHNpemVzLg0K
PiANCj4gSSBndWVzcyBJIG1pc3NlZCB0aGUgZGlmZiwgY291bGQgeW91IHBsZWFzZSBzZW5kIGEg
bGluayB0byBpdD8NCg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzViZDE2ZTJjMDZh
MmRmMzU3NDAwNTU2YzZhZTAxYmI1ZDNjNWMzMmEuY2FtZWxAaW50ZWwuY29tLw0KDQpUaGUgcmVt
YWluaW5nIHByb2JsZW0gaXMgdGhhdCBoaWJlcm5hdGUgbWF5IGVuY291bnRlciBOUCBwYWdlcyB3
aGVuDQpzYXZpbmcgbWVtb3J5IHRvIGRpc2suIEl0IHJlc2V0cyB0aGVtIHdpdGggQ1BBIGNhbGxz
IDRrIGF0IGEgdGltZS4gU28NCmlmIGEgcGFnZSBpcyBOUCwgaGliZXJuYXRlIG5lZWRzIGl0IHRv
IGJlIGFscmVhZHkgYmUgNGsgb3IgaXQgbWlnaHQNCm5lZWQgdG8gc3BsaXQuIEkgdGhpbmsgaGli
ZXJuYXRlIHNob3VsZCBqdXN0IHV0aWxpemUgYSBkaWZmZXJlbnQNCm1hcHBpbmcgdG8gZ2V0IGF0
IHRoZSBwYWdlIHdoZW4gaXQgZW5jb3VudGVycyB0aGlzIHJhcmUgc2NlbmFyaW8uIEluDQp0aGF0
IGRpZmYgSSBwdXQgc29tZSBsb2NraW5nIHNvIHRoYXQgaGliZXJuYXRlIGNvdWxkbid0IHJhY2Ug
d2l0aCBhDQpodWdlIE5QIHBhZ2UsIGJ1dCB0aGVuIEkgdGhvdWdodCB3ZSBzaG91bGQganVzdCBj
aGFuZ2UgaGliZXJuYXRlLg0KDQo+IA0KPiA+IA0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+DQo+ID4gPiA+ID4gLS0t
DQo+ID4gPiA+ID4ga2VybmVsL2JwZi9jb3JlLmMgfCAxMiArKysrKysrLS0tLS0NCj4gPiA+ID4g
PiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL2NvcmUuYyBiL2tlcm5lbC9i
cGYvY29yZS5jDQo+ID4gPiA+ID4gaW5kZXggY2FjZDg2ODRjM2M0Li5iNjRkOTFmY2IwYmEgMTAw
NjQ0DQo+ID4gPiA+ID4gLS0tIGEva2VybmVsL2JwZi9jb3JlLmMNCj4gPiA+ID4gPiArKysgYi9r
ZXJuZWwvYnBmL2NvcmUuYw0KPiA+ID4gPiA+IEBAIC04NTcsNyArODU3LDcgQEAgc3RhdGljIHNp
emVfdA0KPiA+ID4gPiA+IHNlbGVjdF9icGZfcHJvZ19wYWNrX3NpemUodm9pZCkNCj4gPiA+ID4g
PiAgICAgICB2b2lkICpwdHI7DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gICAgICAgc2l6ZSA9IEJQ
Rl9IUEFHRV9TSVpFICogbnVtX29ubGluZV9ub2RlcygpOw0KPiA+ID4gPiA+IC0gICAgcHRyID0g
bW9kdWxlX2FsbG9jKHNpemUpOw0KPiA+ID4gPiA+ICsgICAgcHRyID0gbW9kdWxlX2FsbG9jX2h1
Z2Uoc2l6ZSk7DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIHNlbGVjdF9icGZfcHJvZ19wYWNrX3Np
emUoKSBmdW5jdGlvbiBhbHdheXMgc2VlbWVkIHdlaXJkIC0NCj4gPiA+ID4gZG9pbmcgYQ0KPiA+
ID4gPiBiaWcgYWxsb2NhdGlvbiBhbmQgdGhlbiBpbW1lZGlhdGVseSBmcmVlaW5nLiBDYW4ndCBp
dCBjaGVjayBhDQo+ID4gPiA+IGNvbmZpZw0KPiA+ID4gPiBmb3Igdm1hbGxvYyBodWdlIHBhZ2Ug
c3VwcG9ydD8NCj4gPiA+IA0KPiA+ID4gWWVzLCBpdCBpcyB3ZWlyZC4gQ2hlY2tpbmcgYSBjb25m
aWcgaXMgbm90IGVub3VnaCBoZXJlLiBXZSBhbHNvDQo+ID4gPiBuZWVkDQo+ID4gPiB0byANCj4g
PiA+IGNoZWNrIHZtYXBfYWxsb3dfaHVnZSwgd2hpY2ggaXMgY29udHJvbGxlZCBieSBib290IHBh
cmFtZXRlcg0KPiA+ID4gbm9odWdlaW9tYXAuIA0KPiA+ID4gSSBoYXZlbuKAmXQgZ290IGEgYmV0
dGVyIHNvbHV0aW9uIGZvciB0aGlzLiANCj4gPiANCj4gPiBJdCdzIHRvbyB3ZWlyZC4gV2Ugc2hv
dWxkIGV4cG9zZSB3aGF0cyBuZWVkZWQgaW4gdm1hbGxvYy4NCj4gPiBodWdlX3ZtYWxsb2Nfc3Vw
cG9ydGVkKCkgb3Igc29tZXRoaW5nLg0KPiANCj4gWWVhaCwgdGhpcyBzaG91bGQgd29yay4gSSB3
aWxsIGdldCBzb21ldGhpbmcgbGlrZSB0aGlzIGluIHRoZSBuZXh0IA0KPiB2ZXJzaW9uLg0KPiAN
Cj4gPiANCj4gPiBJJ20gYWxzbyBub3QgY2xlYXIgd2h5IHdlIHdvdWxkbid0IHdhbnQgdG8gdXNl
IHRoZSBwcm9nIHBhY2sNCj4gPiBhbGxvY2F0b3INCj4gPiBldmVuIGlmIHZtYWxsb2MgaHVnZSBw
YWdlcyB3YXMgZGlzYWJsZWQuIERvZXNuJ3QgaXQgaW1wcm92ZQ0KPiA+IHBlcmZvcm1hbmNlDQo+
ID4gZXZlbiB3aXRoIHNtYWxsIHBhZ2Ugc2l6ZXMsIHBlciB5b3VyIGJlbmNobWFya3M/IFdoYXQg
aXMgdGhlDQo+ID4gZG93bnNpZGUNCj4gPiB0byBqdXN0IGFsd2F5cyB1c2luZyBpdD8NCj4gDQo+
IFdpdGggY3VycmVudCB2ZXJzaW9uLCB3aGVuIGh1Z2UgcGFnZSBpcyBkaXNhYmxlZCwgdGhlIHBy
b2cgcGFjaw0KPiBhbGxvY2F0b3INCj4gd2lsbCB1c2UgNGtCIHBhZ2VzIGZvciBlYWNoIHBhY2su
IFdlIHN0aWxsIGdldCBhYm91dCAwLjUlIHBlcmZvcm1hbmNlDQo+IGltcHJvdmVtZW50IHdpdGgg
NGtCIHByb2cgcGFja3MuIA0KDQpPaCwgSSB0aG91Z2h0IHlvdSB3ZXJlIGNvbXBhcmluZyBhIDJN
QiBzaXplZCwgc21hbGwgcGFnZSBtYXBwZWQNCmFsbG9jYXRpb24gdG8gYSAyTUIgc2l6ZWQsIGh1
Z2UgcGFnZSBtYXBwZWQgYWxsb2NhdGlvbi4NCg0KSXQgbG9va3MgbGlrZSB0aGUgbG9naWMgaXMg
dG8gZnJlZSBhIHBhY2sgaWYgaXQgaXMgZW1wdHksIHNvIHRoZW4gZm9yDQpzbWFsbGVyIHBhY2tz
IHlvdSBhcmUgbW9yZSBsaWtlbHkgdG8gbGV0IHRoZSBwYWdlcyBnbyBiYWNrIHRvIHRoZSBwYWdl
DQphbGxvY2F0b3IuIFRoZW4gZnV0dXJlIGFsbG9jYXRpb25zIHdvdWxkIGJyZWFrIG1vcmUgcGFn
ZXMuDQoNClNvIEkgdGhpbmsgdGhhdCBpcyBub3QgYSBmdWxseSBhcHBsZXMgdG8gYXBwbGVzIHRl
c3Qgb2YgaHVnZSBtYXBwaW5nDQpiZW5lZml0cy4gSSdkIGJlIHN1cnByaXNlZCBpZiB0aGVyZSBy
ZWFsbHkgd2FzIG5vIGh1Z2UgbWFwcGluZyBiZW5lZml0LA0Kc2luY2UgaXRzIGJlZW4gc2VlbiB3
aXRoIGNvcmUga2VybmVsIHRleHQuIERpZCB5b3Ugbm90aWNlIGlmIHRoZSBkaXJlY3QNCm1hcCBi
cmVha2FnZSB3YXMgZGlmZmVyZW50IGJldHdlZW4gdGhlIHRlc3RzPw0KDQo=
