Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE4C62CE00
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 23:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbiKPWrV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 17:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239162AbiKPWrK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 17:47:10 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B1A2B2
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 14:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668638829; x=1700174829;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q9zI4yjh0fq8Bl8sxDnj94F31htDS6HIgSDhvL/g4iY=;
  b=J3Gu8/4Hwy0rnOAwGLOA3aVeaf/qc9gKqO05C2Ydesw4Y3rzN2jDHoit
   zxBPKD6f4l3kcfePwL5kHUbSx/bcg7QGLsaVH/m03fXbGZL39PCnb8SpJ
   XM9CgRna1/b4kbMppjFsA5biLrzURp0Rff32qPJjNvoQj/rORo2/kVvdb
   Sb8duuSZVZ/19mm1hjAagG+PzD5Vq9VfbnASKV+X3IJfsppVvuTwImCGI
   G93hiTt98OvRfpZotbyZMY+G7cIVDht2rKhBfVDKPbHmk8OnDT6D74Cuq
   +FkoctxCaBAp0BPUIJtl1TKo/kGcAl/yaHHBvjtHrjKQ1R9zKeABLmzpM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="293084550"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="293084550"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 14:47:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590368702"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="590368702"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 16 Nov 2022 14:47:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 14:47:08 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 14:47:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 14:47:07 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 14:47:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6pROMQZz7E7upCpi6xMfRfLBjnVMbGbeC9OLlxFtWs5SJZlhS7SWZjsACWgO/jmMz4Ml6JO8WSDcBGJXLGgQstGwK6woe9wt+yiNulSG+5Rig7biSmGHeG1SbJQDvzJrjeM/UBF31G2KKKadhfZN9HObH8+wHqP6jfetlfqF+xVES9XSE2T51ZvffBVXyuZ0DNI8cY/CgOCiEXjWW02MXEpnUBc0Z7GviL/Z0XTfRrS8GGzpEcr4hcwFMJi+flCA/XKIZy5n0T6YICa6WcHehnwoQX+5un8HGMlCS8ubG4pir5bfH7sXEMwYgyaXTOf2jrnqrC0jQFz2bVY94BrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9zI4yjh0fq8Bl8sxDnj94F31htDS6HIgSDhvL/g4iY=;
 b=bVoxrNLlGxqyxjmsfUFsoFdZ4HlJVoaaIzR7SPqRngOUFW/pSa59kU3sf50XUGEKhBz0xiwyUA2fnzME13rHNM1VrwlXmP+rOcaubxhPdEsoNHecqJcWvR6S2eA3cqRu2+HvBvTKSt9BbBx9qgJ6vlZQ2tavPpIo37t8akpy8QuPvHrgQXDVi3GC7OAMWiRyXmX2Q7ehoEfIWzCXbLKwJjF2ph8YCQGK0t6IBBX75U4XdoHlD7VJB5DMcgUAWe9IzeEiaHWojobB0MyK104G0Ed3bsYEWqcEzmHHJzPkWcK+XfOyr0upuUtuSYyvx/0Ad6WjU0rGP7hka6gqeiR21g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB4677.namprd11.prod.outlook.com (2603:10b6:208:24e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 22:47:05 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 22:47:04 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "song@kernel.org" <song@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Topic: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Index: AQHY8vohJKeDurB03UipOT/gu9SMC64/PciAgAFJQwCAABumgIABjkqAgAADwYA=
Date:   Wed, 16 Nov 2022 22:47:04 +0000
Message-ID: <cea2f9f81db0a5db9cdc1ed9089454ddbd28541b.camel@intel.com>
References: <20221107223921.3451913-1-song@kernel.org>
         <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
         <Y3P/9DXAjKhmoIvm@bombadil.infradead.org>
         <CAPhsuW4_aYvPJUfCBkMygKPpHx7Y3xPCV7ewLGGAhyztJq3dhA@mail.gmail.com>
         <Y3VlQcsiEi273S+n@bombadil.infradead.org>
In-Reply-To: <Y3VlQcsiEi273S+n@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MN2PR11MB4677:EE_
x-ms-office365-filtering-correlation-id: d346ce04-03e7-41be-7ba3-08dac8247bbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o6EJTxJUdca7NNywcRCP6oBxgRWRCW2287xPLJcCww+VNtgVKrTNuY8HndQhKzz5ApAcE0fwMUyTArP0CPt+Lf7DHeVMYtusklwmt40zH2YUsQ+6Z5KTipHSo85cjLsilOSV70+NmASXzzew2VREKa7XjzkvssuZILMLVCx4JVTeqIL6OBa6ijK3keRCO6/nXmTmpMkqzE+rFk4dtgieE261WmW1S8NHESDJXoUu6rtkjqT/hmcyB0t3GrhBNFa12GurMq8gkKa0j4Enecl7sl+I8MvOzlSLQeYTawKnuYKMy2xlOL+IaahxNxnZZ4gKlSqZFr9idVXLGRcPDaAOc14Ae39SN7x+j1aJfT3PJSR/bxAijuj7zU/9ZpjloF9PXx4eeM3VFRRqjdpCqFUaG9kPl6ETA0HHPqVZ6o2ZL+MUR8ff7pJm57E5QGTgHkVnKF1Y/T7XuIsSeTXKNUuOARJGEwhINxWoIUqnE/vlUKMMbUAmK59gK8K9UuIE8kNce37ABY4n4KlkT3FMQWiZqXCSMtATy9yTJAP5IgdHcSwEc2QwOIHRruJ2UREPenDMAJ1T5ySR/hRtfYc7Mg8Z41DTB54c/k+Zg5bjOOltKPogtnDA3I+G+ueGinxCnHyLfet75u/DnV53yHBOsT4WKhO8vJXVnioKsBr6YoE2wK/pBZydMEKTiMqe1WoXUiEZX+1jix0J/hj2MIOwEviOp/mPNh89p4w3xS5secdWgQZvXWCaZ+0egCdO68FS8935VFFFQQ7MxREPR2u8azxuQYnD43KEGpgb3m4bKrIp++5Cxh7pcpCiDE+PLislH7DPi42WQKwD412Jp0zKLVvokw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199015)(6512007)(66556008)(26005)(316002)(91956017)(66946007)(186003)(76116006)(8936002)(66476007)(66446008)(2616005)(8676002)(64756008)(41300700001)(4326008)(36756003)(110136005)(54906003)(6506007)(4001150100001)(86362001)(2906002)(82960400001)(38070700005)(38100700002)(5660300002)(122000001)(107886003)(966005)(6486002)(71200400001)(478600001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWhUT2JjWWxRSGdzSCtHTWlXUjJQdE5WQzhMcUs5b0ZSMXRNV3k3TDhYTHEx?=
 =?utf-8?B?ZVRFTDUzKzVuUzZTajJhWHlkcUI5ZWcyQVVId28yc3hmVE9QUXpGOWJYM0Fj?=
 =?utf-8?B?ZGYvRURCeFdvRDFqM0tTYzUzOTVRVzZ6QlVudFN5VzNPN3NQQlZnZHg2NkQ3?=
 =?utf-8?B?T3l2Z1ROUE52NmIwZGsvSm05SDUreUUrTVFOV2dIMHhUS0ZSbFV4WkNIaW1p?=
 =?utf-8?B?czYweTVreHJvMWdsbGwwaFdVYlA5L3RBTmh6Z1V2b2JVMmZtY0ttNHgvZGtU?=
 =?utf-8?B?Ujg4d1VmZjJSelJ6dXF0cGNqLzB0MlJ4TWRWUmpDZTdmT0kyUng5SlhQYUtv?=
 =?utf-8?B?Y2VzSkp3NU5KQkRidCtSeEdaOUNvYkIxMlVDL2JyY1pTcDVkVzNKQkc0VEVs?=
 =?utf-8?B?TUF2K24vTzdINDduN1NNZ3NzdDcyaGdnNTEvYlo2Yzc0ZStIUmdNNHA3c0Nu?=
 =?utf-8?B?QVBMd0lNTEo1SE1pT2pVNHNTTnRpbnhMRDRQZlAydzYremR1VEdwTEVLQjEw?=
 =?utf-8?B?bFlPbUdTM1dBR09ONjJTUDUxOWlXQjVKc0x1MWpoVmhZMC9tQXc1VU5PWTVp?=
 =?utf-8?B?aHE2QlhFUm4yOFlJYTB4WVB4OHZ4MWp2YkJ3bGV6ZDIybUZ5YU01TktrSTZP?=
 =?utf-8?B?bDNUK0JUZDF2SFZ3cE5MSTdONk9QYW5lWGRneEs5Q0pkNWs5dFp5SkNVL1Vj?=
 =?utf-8?B?R2hsWWgvNkZOWlVIWmNXcmg0UE5QVEhYRHNhVTdWbUpVZ0NTM04zbnFNZk1Z?=
 =?utf-8?B?TEdCcWR0TzFUb3dnSWROUllBZnY5OVBISXNTbnpkMStETDVhTkxWS2NWMVpx?=
 =?utf-8?B?bTRKb1BxOHBVSmJQNzVjS05SL1RXMXFJckdsR2ZSYlZzcDZwZU1zVTlHcFZI?=
 =?utf-8?B?N2RoSmtuK3d0RGh1T280WHJ0Nk5iUFpOMW44UFU0aXZWQlZEL1VBbG0vZVpx?=
 =?utf-8?B?cVRlWG5STFFVTDErd0JvclkzTDRFcmVVNW1hUm00YjlXeWRQWE5yLzVqUUpx?=
 =?utf-8?B?Q25uTy9wM2dtNFMzaWtpQUxtTGZON0t2eWhYbGtTaDltNzZqcGdpc21mdDhu?=
 =?utf-8?B?RUdQcG5WdUZncitZcnVFYlZjS3o0bGpuUFVscUVwbnFoVzNZeXh0d0U4RjU1?=
 =?utf-8?B?eFNBdUNNS0xWTFg4eVZqZUo5dzR4SG8zR25PNmUwUDNWSHdwMlpvMDArT0Fn?=
 =?utf-8?B?dnJSYmNnbHlmdHEzNitIUC9iOVd4TlpQaURHZWtRN1BhQ3IrckF2OG5wRTNY?=
 =?utf-8?B?MVdrOGpYbUd6QzI1Qk03WTYzZ0hFcjdHSWhtditLWmRWelhISy96cEM3VVR3?=
 =?utf-8?B?TDFtckNOUWNkcGY2cDgxT3F3YVFuT09hZmRIVzJ3T1QvVGNuamIxY1M1ZENt?=
 =?utf-8?B?WUtNQnAzb3JWQ2xrTGllS09JZlJVMDlaL0N5NTh0UE54ZWRHS1RYK2RsSzh5?=
 =?utf-8?B?SHNwYWdqbnRZUmFjNjVKK0NJbzdaeWg0N3NVOUFIRXhvTFNVOHdxUjZOY1NP?=
 =?utf-8?B?VHlRUGZXSE1sdGNsa2VheWpwRkxUZk9qMU1mSEpIYVZzOFpQeXpFWmYxOGZm?=
 =?utf-8?B?alRVa0FFOU9NZURZWE44bzhDTERXcnBuK3VuU3hCaStDSWluZ3VqWHcxRTY5?=
 =?utf-8?B?bVhzMmp5K1NiNFRXQnpnY29wcW9FTzc0eHhWK1d1azRLQldCNkVaOFdMTEJB?=
 =?utf-8?B?bWFoWnJSOGpWOGNmVjhZZ2Vta2tHdmxkZDZHYTFGUVFnc1Bwd2VoajZ6N213?=
 =?utf-8?B?b0NuZkxXM2twV1JuQk1ZUWJKSnlmSDlpVmY0VG9YOGJ2WEg0YWdjS0NaSEFp?=
 =?utf-8?B?MVNMTGFvckt0Z2ttMzFDRnRDenJwd1Q4NTd5cDlmZGZTRHRjb1VyK3pKY3hS?=
 =?utf-8?B?b2M3blc4bHdCbnN6bG01SXdFblFoRGlFYlJpS2xyRk11YXE4aXY2RDk1NnQ2?=
 =?utf-8?B?UFZweE1WalJ5QzVFTGpyWVN1YTJKNGkzck9JekhDd25rWFVRaWx0NC9BdGc5?=
 =?utf-8?B?UGFRYm4raE5HZ2l5c3dyVEdzcFpqT0Fqb3ZwcjBURC9KOTZZUngzSFBVQ050?=
 =?utf-8?B?MHAvMXh6V091Z3FiakZDYkZhdktGYTFjZy9MV2dyN3JZcmhGRE4xOWJkeWZK?=
 =?utf-8?B?bW0vV2h3Ui9TSzhadDZiakdGUUgyZVhhUmo5R0xkVHVzY3U4VVBCWXZKWGJH?=
 =?utf-8?Q?T9yFSvdBKlT9C4e8tHIy5jE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8C55217D0EA144597454ACEF57355BA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d346ce04-03e7-41be-7ba3-08dac8247bbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 22:47:04.6336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MD2b5D1hDeZQuEa6QmWLNdKcH4CKSdV5DDLvfufw0Tlr9gdN8uMN8lXM7lwfSFBw9gckTD3HoeBaTRm2xg5vcQgOycf7xQfeeAXnKMOfhts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gV2VkLCAyMDIyLTExLTE2IGF0IDE0OjMzIC0wODAwLCBMdWlzIENoYW1iZXJsYWluIHdyb3Rl
Og0KPiBNb3JlIGluIGxpbmVzIHdpdGggd2hhdCBJIHdhcyBob3BpbmcgZm9yLiBDYW4gc29tZXRo
aW5nIGp1c3QgZG8NCj4gdGhlIHBhcmFsbGVsaXphdGlvbiBmb3IgeW91IGluIG9uZSBzaG90PyBD
YW4gYmVuY2ggYWxvbmUgZG8gaXQgZm9yDQo+IHlvdT8NCj4gSXMgdGhlcmUgbm8gaW50ZXJlc3Qg
dG8gaGF2ZSBzb2VtdGhpbmcgd2hpY2ggZ2VuZXJpY2FsbHkgc2hvd2Nhc2VzDQo+IG11bHRpdGhy
ZWFkaW5nIC8gaGFtbWVyaW5nIGEgc3lzdGVtIHdpdGggdG9ucyBvZiBlQlBGIEpJVHM/IEl0IG1h
eQ0KPiBwcm92ZSB1c2VmdWwuDQo+IA0KPiBBbmQgYWxzbywgaXQgYmVncyB0aGUgcXVlc3Rpb24s
IHdoYXQgaWYgeW91IGhhZCBhbm90aGVyIGlUTEIgZ2VuZXJpYw0KPiBiZW5jaG1hcmsgb3IgZ2Vu
ZWFybCBtZW1vcnkgcHJlc3N1cmUgd29ya2xvYWQgcnVubmluZyAqYXMqIHlvdSBydW4NCj4gdGhl
DQo+IGFib3ZlPyBJIGFzLCBhcyBpdCB3YXMgbXkgdW5kZXJzdGFuZGluZyB0aGF0IG9uZSBvZiB0
aGUgaXNzdWVzIHdhcw0KPiB0aGUNCj4gbG9uZyB0ZXJtIHNsb3dkb3duIGNhdXNlZCBieSB0aGUg
ZGlyZWN0bWFwIGZyYWdtZW50YXRpb24gd2l0aG91dA0KPiBicGZfcHJvZ19wYWNrLCBhbmQgc28g
c3VjaCBhbiBhcHBsaWNhdGlvbiBzaG91bGQgY3Jhd2wgdG8gaXRzIGtuZWVzDQo+IG92ZXIgdGlt
ZSwgYW5kIHRoZXJlIHNob3VsZCBiZSBudW1iZXJzIHlvdSBjb3VsZCBzaG93IHRvIHByb3ZlIHRo
YXQNCj4gdG9vLCBiZWZvcmUgYW5kIGFmdGVyLg0KDQpXZSBkaWQgaGF2ZSBzb21lIGJlbmNobWFy
a3MgdGhhdCBzaG93ZWQgaWYgeW91ciBkaXJlY3QgbWFwIHdhcyB0b3RhbGx5DQpmcmFnbWVudGVk
IChzdGFydGVkIGZyb20gYm9vdCBhdCA0ayBwYWdlIHNpemUpIHdoYXQgdGhlIHJlZ3Jlc3Npb24g
d2FzOg0KDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW1tLzIxM2I0NTY3LTQ2Y2Ut
ZjExNi05Y2RmLWJiZDBjODg0ZWIzY0BsaW51eC5pbnRlbC5jb20vDQoNCg==
