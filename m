Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585F94FFAAE
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 17:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbiDMPyN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Apr 2022 11:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiDMPyM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Apr 2022 11:54:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB3847AC1;
        Wed, 13 Apr 2022 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649865111; x=1681401111;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aZ9XIjV/OANUshTkG9gHyNBMIfNS7jKLTVOPY/Z54JU=;
  b=ZY4aIcDeS9Gi5M4weCq95dzbmCzhdsvKtC7PMDqOKuJ0FGyWQo69r+QD
   1ZdMtv/5mH0wuwBcH3z5nMG5hQLpSEksX3fCY/7kPbI/mhgXA2XhGRuut
   UPJe1hdeISw4IMTSGdyt/YnBZhhKZnBLZcU8iq//svuBCIR0YNOXWdMS/
   E8X+eRRQTWVRkhukrJcFXYeQTIn4Vn9blsm72aDBXPUxAE9X/HZFyzhm7
   CeVaAbWWsyRUeCsgSq+mWJ0BGRqnK4lwRQ9nl2Ij2nCzuq3GHWajvrlLA
   UkXLHrgKKdCu3J0MwAVjfkBbdhjUPqWfsfBRVGWNWLKQaEWt8QavinBWF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="242638209"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="242638209"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 08:51:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="645219405"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Apr 2022 08:51:50 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Apr 2022 08:51:49 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Apr 2022 08:51:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 13 Apr 2022 08:51:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 13 Apr 2022 08:51:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIR0wX2t6ZcfiEZ7r/19dKVoig34FfREFK8oGzcMp4/zPzGWKwjzV+ZSg+mZvWgO2SyCdMAACxiLBzwc0Iq0xt5xM32ep3p7MVnK1NAq4urO/QKk/d8YC9o6SlpdfetR0+wPfDlXyA6hNIV8UUgxQBj71c002yG9he3o5BpwDsX+J7DO2/iYRmIM2gqTPJjXAG0xhssPrsV40WuL5CMhxZMPFNZ8ig7I5GTFuik0XS1vVZtOY+WVKM4EL33Rfp+xv/kH7l5ePLV2LhXUvzhq4sbTJco1Mj6da98Sjvl/7/2PvgYGyQMu6fyeWTgVOEO9LParnEk91btcJkwpJ8zFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZ9XIjV/OANUshTkG9gHyNBMIfNS7jKLTVOPY/Z54JU=;
 b=b7jZYF5MHZhPJIk3aRp1mFbVO4MbxsKpDg/USBEvU3xqshvKq14zKjKtyKZMmGf1blNCdBEk+GSzsNIRl0d+J3CHlsSwUAaMrgvfTL6Tvm6GFM6GO9IFjUiI6mn/dhCL9J8V/a9hUThsT9kOc0RTOtoM8Nt8jICcKgijbC2j7xDtfBRr7nJNPtRTjw9iYNoS5/cJY17Cv0Uyiz7WtwbU3l9cQVeNWukNWBCurOAedf/SjGUmX/LdLai+g/91Y/K0575aRJ98+5wvJTLYOiSd7Bj3yPxiX3/S6hbrNkThy4kH1tcfpOB0zZpDLK7XXWO4b/iJshNE9FiJ3Vy9t8nmOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BN6PR11MB2050.namprd11.prod.outlook.com (2603:10b6:404:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Wed, 13 Apr
 2022 15:51:47 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::69:f7e:5f37:240b]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::69:f7e:5f37:240b%3]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 15:51:47 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "song@kernel.org" <song@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v2 bpf 3/3] bpf: use vmalloc with VM_ALLOW_HUGE_VMAP for
 bpf_prog_pack
Thread-Topic: [PATCH v2 bpf 3/3] bpf: use vmalloc with VM_ALLOW_HUGE_VMAP for
 bpf_prog_pack
Thread-Index: AQHYTf2qaLgPk3a2NEqtdWyicAiNHqzsh1qAgAA9YICAATwMAA==
Date:   Wed, 13 Apr 2022 15:51:46 +0000
Message-ID: <7a14d025ea4de25d4989777f651d51117fc0a47c.camel@intel.com>
References: <20220411233549.740157-1-song@kernel.org>
         <20220411233549.740157-5-song@kernel.org>
         <0e8047d07def02db8ef33836ee37de616660045c.camel@intel.com>
         <CAPhsuW4pde5DTMNzRUHwPoxs6vh9AQPn+ny5-9cFVO4nVnYsGw@mail.gmail.com>
In-Reply-To: <CAPhsuW4pde5DTMNzRUHwPoxs6vh9AQPn+ny5-9cFVO4nVnYsGw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf14d82e-a167-42c9-328a-08da1d658404
x-ms-traffictypediagnostic: BN6PR11MB2050:EE_
x-microsoft-antispam-prvs: <BN6PR11MB2050C4D10D7AD2C13957A3E7C9EC9@BN6PR11MB2050.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vOvBWDvF1RJPLJ90IL40beWheQ/E+kpG9pZW4CMhlhg+GmquYygx3zrMYTkN0xUzIGgSNRPtV6kfcsqwDgPI+zsxa3IzOSpB6jrye6kHgUIwvBLzCKIO17AAGq5Zm3fuK36q8cpoyO+/V0dCsVRrMdSv3C6QcEEcvagjMnEKiBg8vUvz1dGVcEmwntmn4w6UHlIpAAMY6q0W4zlgzg0HINp8ifyoFeBJtHBfbylcNWoCse+QsIyKr1xj2xeKn6UyfvETgBOCF+zCK0IuSnvI3WiUdpCgAFXhItfU3iJmEqNo5l1c9no3BtELWmljd0t2LyQzUyjpo3PdHXbWRHuS0U8XRmfKdKc7XY5BUihxgtGHuKFhBJ2PoYQDI7XEsJCbt7N8OlMk3BuaV+t4FGezJ8RoDzq5itWUwYlLwH/WT5EjJvN4m4fRRvdmM5g+GVPmzcuejzCb3mZN69CHR/YuxPo76kAH6rEy0qA6SB1Qks+xU+E4a1Eu8u7T+7Frmcf4oeomx/B0wfVCKP/z8c4kZyrfPcGuyF+eLBGuUWYFZGGS8jOQ346HRURcNo64vYZIoPnH7judRGcRPQAeyVJSFlrdeqcbN6CWl0+GDei4+BXTdiOx3BKXBgb1NKNH8CB8qJErCRtg1OhYGI3O5qKEw8oShX62k1ukODO0tmbMe1+AgJYstroltOtErrqmD2Cu/6vPd9lAZd79YmmHo7kNXrXbA21IoP6u5TkwlvvBGzWDono1RzuMtF8+qY2rada9fS8YKHOuyr3pQAzZhk+VSmJwOYCZASh3UCyNrPLyoacoVvfO8DEKel5NGo+X6VVKTTzYwX9aAUdMetWC4IZjuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(6916009)(54906003)(8676002)(66556008)(66476007)(186003)(316002)(91956017)(7416002)(86362001)(6486002)(76116006)(8936002)(122000001)(4326008)(6512007)(82960400001)(6506007)(38070700005)(38100700002)(66946007)(71200400001)(66446008)(2616005)(966005)(26005)(508600001)(2906002)(36756003)(5660300002)(4744005)(99106002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWZJOWxOVmZXdHRRNm5ublFvTGpOM1FZMlJxU2sranZab3Q2NnBuRElaS29D?=
 =?utf-8?B?TEcrYS9EK3R0ajlIaE8rWFgzODRBYlJyTlBkcWlHc0IwMjRIWFJ5bkNsQVcy?=
 =?utf-8?B?ODAwZEpPZjdzakQySWNjSllaSUk1NWNhSW8vTU9IR25hLzJlcWd2eWorZFFE?=
 =?utf-8?B?UWluY0kwSHNQdklkVjRWRzMyQXUzbUtaazVpSGp2ckRnY25lUlJCeDBKYmhm?=
 =?utf-8?B?QTZ1bUczeGJ1cVFLUTZkTlE1TnpicDZoeFFlTkprQ01xQ1RQa1I1Z2Z0Wmt1?=
 =?utf-8?B?WXozc0pNdTNicFJtQks1S25GVkdObjVhZEh2c1k4MTgrYTJwRFlXZU9UMmE5?=
 =?utf-8?B?ZVZEZjV3azJvRkN3VUU5OGRnZVU0blNra0dhU2FMNFRaVTliQ25DODNISlBM?=
 =?utf-8?B?bTc0QUlhTkExMmpxOE9Qc1c2aERHc040cndIWVVGZXhQdnovOTFWZllmQzdj?=
 =?utf-8?B?cUhTQ3oxNkgwKzhUVENuVzd6TXNJOGJMWkRFcks5amVlRnNvVkhXRjJzcTVv?=
 =?utf-8?B?bmhxd1ZteE1xWUN2MHRzblpHUjA4NlZsSm9RYnlkaVR2OTJIVXFXa2lWUnQ1?=
 =?utf-8?B?SFBqbmdBZXNaUVhtZUhVa3Fsc2tVY1pCNzgxdDFsN3RZQWZDOUY0SEVqRlk2?=
 =?utf-8?B?YVNZQ0pVQjBaNW02TzhkcWhxTlBxOTV2WWc0d3BYd2hPNVo2UC9OYnRDMVhp?=
 =?utf-8?B?ODRCemlYN1V3RDJpUzJYa0Vxei85T2RyZEJMVXIzYmk2WWtFb0FENW5PYmpt?=
 =?utf-8?B?UkU1VDFpYWlhajVGSnJpNWpXSkRZOWVMZEF2dE54N2lhQ2VNNEZnc0k3R3c5?=
 =?utf-8?B?OTFtQzNsc2lOaFR0N1Z0L2JITUdRV2VkeStJYlExQmxVY29oTDBLbi9sWUtq?=
 =?utf-8?B?N1Y3RFRaaWo5V1lIcGdVNEZLbGIza1ZEdlUxWWIyTUdtaE1EZ3RtMHdvNXBw?=
 =?utf-8?B?YURQYVk1YmpDbUF3ZTZsZEkxUTFkQ3dhRTFJNEJhNzVMY3JlbUxMd3pHWjF4?=
 =?utf-8?B?d2RmL1QyMEIxQVBBRmJ5eHNYWjloMUlKc3dOT0hUN0t6cXpCaTZrU3lqK1Nr?=
 =?utf-8?B?YmJXZjBXNjJLSXRCQzlPdCtkRGhka3BYSlpDUjJ5cU9kdHdhVUM5dnEzb015?=
 =?utf-8?B?UWZua3gwTHlIbGswOFExY2JQOXFsMm04U1I2M0d5eUNqRG03ZW1iUWRMVjBJ?=
 =?utf-8?B?bFNPaThRS1pHR3N1Y1Y4bUVNbGdhZTZadjdidFJFK1NFcmJ1eW1rYlNWOGJv?=
 =?utf-8?B?VStybzNmd3dOWVgxM0IwMllBWHFpNGM5ZkVBODVlck1KYitMdzdJZmZqTXdu?=
 =?utf-8?B?TzM3a1hsb1Azd3pZRzJDUnhneWdKK2oxeXJnMWhTY2FzZEpNSXdJVUZVWTg0?=
 =?utf-8?B?T09aVGl4YUJ6RW93dXY2dGsvTGtoYm1idVVHaU1Hd0N4Y284SFV1ZFhpZTl4?=
 =?utf-8?B?SXU2Tk5CbFg2dWgvcm44ZTdUanMxRXVEYnE2R2daS1dKVDBIMkxoRnl4T21s?=
 =?utf-8?B?UkRhKzdUbXFaUGVzclhTbzU4Z2YrOUFFWE1ueWJ2R0tTOHVrREFsQytZWUcx?=
 =?utf-8?B?L2E2OGtQSWkvTXlNNzB5NkxDL28vTktNZmVodnBCYnA4b2dGVkN6VmhKcUFM?=
 =?utf-8?B?VVdKcTB2elI0ek5QZTExalUyQ3dLeWZ5SFY2cGRJQ1M3eGlqbThTOGxyV21J?=
 =?utf-8?B?eE5pOFgxSGRFbHcwK2ZFU3NDaUtVVlU3dmNUVE5qZ0VKeUlTZ0paTmpNZWFr?=
 =?utf-8?B?Y2F1a2YzWU1Gb3g0WFlZSy9HZ2ExZGtPNnBVSGkwZGwvLzdYZ1FERWR3ZTZr?=
 =?utf-8?B?SlhCTGRKbUhpbnJqdTF2aFcxSk93MkRPUlIrSnhjR2VUclU3eG5qOHRKSWxW?=
 =?utf-8?B?RG5KMzhiMFBqekI0K3I2ZDhKQjh1WWlzYkNicjlic2ExU2VZYm5IMnRhYits?=
 =?utf-8?B?SlB3YXBranhCSkFmNndOajNZbXQ2NTl6Q2xrZWs4ZTBpN3RaTUMvUGswQW9M?=
 =?utf-8?B?VUxudW05dVpLR2VJY3YxZmc0ZTJkWFIrdVlHeUlnQWFyeFFiN2lwaHhzcStp?=
 =?utf-8?B?NXI2K1diaUs3SmZjbGpDcjkwOGRsNFNabEdlelQzN1ZzT1BLQ2Iva3dwNURp?=
 =?utf-8?B?dUs3SkVLcVJYb1FwUzY3VjVxU1RBNjdtckFZeXBrK09vVldBV0F5eWZKcGlm?=
 =?utf-8?B?SkdqTVNEUjdCa1orenpGd3RWWkIvRTZUYnlEbFZQZ0NXeEtlYnJtNXVvbGwv?=
 =?utf-8?B?aEw3cWlVVXc3RElGaEFTZjNkTEVOTEJxSTN6MkdpNnU4WXRsL2RuVDNVRXlT?=
 =?utf-8?B?ckRBVnFTRFNTaEsrVVc5enBrMzZUbzlYdzM0TWlhL2twUjNvN2NqTHVoeU93?=
 =?utf-8?Q?HDgX9z2tU7qza8i98qDBnFijzN2eGuuIPYH92?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23EB388610E12B4DB42047B3E2D9754E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf14d82e-a167-42c9-328a-08da1d658404
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 15:51:46.9179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YrOypw0XucoUrtktbUm0PE+tkyN3uoYxaPhprGZB79le6Jsm+TDoRhXZ1YFI1Oc9u5QvRPDqOMGpOkBV5BeJis0IrAiurossm1OgYPHTISo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2050
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Q0MgTWlrZSwgd2hvIGhhcyBiZWVuIHdvcmtpbmcgb24gYSBkaXJlY3QgbWFwIGZyYWdtZW50YXRp
b24gc29sdXRpb24uDQpbMF0NCg0KT24gVHVlLCAyMDIyLTA0LTEyIGF0IDE0OjAwIC0wNzAwLCBT
b25nIExpdSB3cm90ZToNCj4gU2luY2UgSSBhbSBzdGlsbCBsZWFybmluZyB0aGUgdm1hbGxvYy9t
b2R1bGVfYWxsb2MgY29kZSwgSSB0aGluayBJIGFtDQo+IG5vdCByZWFsbHkgY2FwYWJsZSBvZiBj
b21tZW50aW5nIG9uIHRoZSBkaXJlY3Rpb24uIEZyb20gb3VyIHVzZQ0KPiBjYXNlcywgd2UgZG8g
c2VlIHBlcmZvcm1hbmNlIGhpdCBkdWUgdG8gbGFyZ2UgbnVtYmVyIG9mIEJQRg0KPiBwcm9ncmFt
IGZyYWdtZW50aW5nIHRoZSBwYWdlIHRhYmxlLiBLZXJuZWwgbW9kdWxlLCBPVE9ILCBpcyBub3QN
Cj4gdG9vIGJpZyBhbiBpc3N1ZSBmb3IgdXMsIGFzIHdlIHVzdWFsbHkgYnVpbGQgaG90IG1vZHVs
ZXMgaW50byB0aGUNCj4ga2VybmVsLiBUaGF0IGJlaW5nIHNhaWQsIHdlIGFyZSBpbnRlcmVzdGVk
IGluIG1ha2luZyB0aGUgaHVnZSBwYWdlDQo+IGludGVyZmFjZSBnZW5lcmFsIGZvciBCUEYgcHJv
Z3JhbSBhbmQga2VybmVsIG1vZHVsZS4gV2UgY2FuDQo+IGNvbW1pdCByZXNvdXJjZXMgdG8gdGhp
cyBlZmZvcnQuDQoNClRoYXQgc291bmRzIGdyZWF0LiBQbGVhc2UgZmVlbCBmcmVlIHRvIGxvb3Ag
bWUgaW4gaWYgeW91IGRvLg0KDQoNClswXSANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
MjAyMjAxMjcwODU2MDguMzA2MzA2LTEtcnBwdEBrZXJuZWwub3JnLw0K
