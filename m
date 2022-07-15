Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBBA5758A0
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 02:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241160AbiGOAYV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 20:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241155AbiGOAYU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 20:24:20 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C42473591;
        Thu, 14 Jul 2022 17:24:19 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26ENcYH3017590;
        Thu, 14 Jul 2022 17:24:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=KdwlNi2oy3dyEIb2q8WSUNlyrwBy1FMmlruypEXsif8=;
 b=qiM2TZJR2FKfwAEM8vFT2zfayU1nQ3ucAWXqUGmq5ADD1yagXwUyfVAzE5oo5GkHmD1l
 dzwtlfbLH+209TKFRjKa0gS3P0UKHo/ImQvrTlosDKBHssWoPFHvFmMqbRvKUNvM/KMm
 +q1rG0MGDxsc04e4K9fwP2m+7o2+QRoc1OM= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hak154kf7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 17:24:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDD1O5q2xee6tvSWOmgymRSHWdcFcTPw1ycEUkpWOzTuHWZewrvKbEJO6J3/PNIJZ63vQAVPKHb4ul0OuTDp1xXEZ7yEQv92a9C2cDwd0fPgn0UNmb/TyG6dmvbF4JrVfolNRKb8FYyOjjBXYMJ0S38T+VXke/PMKOKhxoUVid597BdWxZVjD/DFxgUbbBKhhv4XutZ2wwkfXI1Q7PfHCXoVka3wuo3yN0XLJiiOcFgrzs+emEfCF+nRnGOSnB54mwBjbn/0DotYsh6Xzzlo+GnF85rFyoEJR6XW3qhHmAeyg1wNDmE0pCNJw9jGp9e8u8oCuq8YUuIo37WcuOOgSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdwlNi2oy3dyEIb2q8WSUNlyrwBy1FMmlruypEXsif8=;
 b=Y9b89IlycxWr3Lg8J3/DWLZGei5ZkF1q9b6x6O808KwaMZ78gj5WD6n+v8EZc3Lo6M0ksUb8f9svP+89bPBnzkeXwrHDH2JxDq+KH6YhIVAGccyOgn7sD/Mfu1flhusCDWMvKH8aQ8/NDAPLl4RR1iLQ4heTlrzesynPEaku0Y0EaNRqL7IWEc1/PGdQpmTrI8dz4IQP47rtSt4UXRijAttO09BlMSy2OVpho3a4i+xgYjB88yWgVvMc1rhMIbeEvlYHsgnfEfBHljym6hn+5oZ3W/ny3QscTnAXAiXgUCJR3R09eWXCHt49kU5TsfTLEmCOBu6RUsDxqeW6UnlmCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM4PR15MB5356.namprd15.prod.outlook.com (2603:10b6:8:5f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Fri, 15 Jul
 2022 00:24:16 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::5de3:3999:66df:42d1]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::5de3:3999:66df:42d1%4]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 00:24:16 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Uladzislau Rezki <urezki@gmail.com>
CC:     Christoph Hellwig <hch@infradead.org>, Song Liu <song@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next 1/3] mm/vmalloc: introduce vmalloc_exec which
 allocates RO+X memory
Thread-Topic: [PATCH bpf-next 1/3] mm/vmalloc: introduce vmalloc_exec which
 allocates RO+X memory
Thread-Index: AQHYlpK25UY5kW1ND0S/krM8qG//OK18E8oAgABfaYCAANKuAIAACKAAgADf3wCAAGbogA==
Date:   Fri, 15 Jul 2022 00:24:15 +0000
Message-ID: <54BB27F6-13A4-4EA6-8775-05BF5D8E2BC8@fb.com>
References: <20220713071846.3286727-1-song@kernel.org>
 <20220713071846.3286727-2-song@kernel.org> <Ys6ZkDUhRZcmvPYy@infradead.org>
 <BE896037-B79C-4B38-B777-96002C5861F5@fb.com>
 <Ys+aVKFJaQd130Pn@infradead.org>
 <8AC2399B-F3B2-4F91-B18C-D9D3D5085471@fb.com> <YtBdSYbCyGJeIHHO@pc636>
In-Reply-To: <YtBdSYbCyGJeIHHO@pc636>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9d66d0b-6178-470e-5d6f-08da65f859d2
x-ms-traffictypediagnostic: DM4PR15MB5356:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pjwlFGy88QOnQlmDS1oNXbWoBtJKy7cv+S1IoRDproX+F+ADua/+N0tQe0iUNeiChkysfnviG1phIH22Zall3akRbk6QM3mhon1INVHVEMt3SASjrgI7E3LnxekgnxZ1SZcbEBSS69WkFkOFnLF9OKAbzbA34iuQYxSwVXhAAfZ/l1C1GFlMmwDtVCDX55RnOxDW1PRriBZN6seqf3Pj1YssdkxN6eTU8DnrhCgOFmux6P8t4Moabv8ZEzHZ29iNJ0eZtvBJ4GB1J65TnYO0O+048yuR0KykOdDMcQzLC05wJ41/wzciLXBdEYudJtFwe60kW8294/OrdkGP7CW7sxyMGajPOHYc7P/9ZFvjNgdrOlXViM0Slylph/34PmPiVsAW/kaFafTO4MWXK7PeXJNjFAQTOeUgEyzQpL47XoVRMaqXA9tyyLMqvIVQMX+HKCfeIByRIXqHw0ojBjxXUOi55UMOYvLXMVidFSeSgaJrZio6zcg2eZLkQuOSJKzvV4JmiFznm7aDKvbjhcDdij0WWpEsBfnGf2j9OTWjbWXGqpC8MGPdF862zAGN8OKSTF19OxOgLE9EDTOcQP1i/YLYry7xRQvTnYZ9W+vrD1DJuGihn9nfOcxVidrDMoxMcnl+0DZfhRsUTtPX0NgsrfHHxVsnzH5htgWF4eZ8SpLM0ZuSUUkT10SrE6TLAflxZXoLMEkSh7dYk2ZWqkaBp8MpA9yqL4CinJ+QcQ4kJ1NfjxttZ7jGX3omkEj1cu/2CBNEo+tySiBPbw2BjswppzvJMLWHORiRoZPtss/WslAMGMGIAMhXzzGUAlwYgxZj4j78ziiruqaQ/J7WxLySpvixOWhn5+VaBRsXaVhFbUM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(2906002)(2616005)(86362001)(6506007)(6512007)(41300700001)(6486002)(7416002)(38100700002)(53546011)(5660300002)(33656002)(8936002)(38070700005)(83380400001)(478600001)(54906003)(66476007)(91956017)(76116006)(186003)(66446008)(122000001)(64756008)(66946007)(316002)(66556008)(71200400001)(36756003)(6916009)(4326008)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bATYgzxWWDQZpGSmgF3VvhRguZO0bHYhzOgOMRIKoXbIjV1okcjDTEsHR7cq?=
 =?us-ascii?Q?xY2R892aWuDwyvdzckc0quKIe8NKDJU1RiThZZAUaMPWiAnl4/qStCx4YKcN?=
 =?us-ascii?Q?4UHM4I3PrSpkK9/wwfG0EyfhyymZvJ74k8dkKziC8RkWe6bObQzcK6nMVFsn?=
 =?us-ascii?Q?RLd28Abx0XkBp7WbSFyxYWzLBKuGCo49nmKLPTya2e58p/XHhFh2pitG2bqO?=
 =?us-ascii?Q?9y30An2Z7Z6PK/+32Zv9zZZAOkpjHJaCY12dAyNwBtflW/6bPMAMmBxb03OY?=
 =?us-ascii?Q?aP86jRBtlrYAVXJT+ZC6nfSs+oefXgmA61NZM1rPKlWgZ8v/Ydtxr1uaoFCX?=
 =?us-ascii?Q?bzV+EYgcHBGp65Yha6dODxrY/th1hB6B/HJ21FhnAKTLPScBM2cLEl6jKnp8?=
 =?us-ascii?Q?K3z7CN+38mrdQzOLBfHdDdkCxe/9EW9jqdxe/zR9G8cPfJBqxpzWBVVb99ae?=
 =?us-ascii?Q?jpP14ZbSL9ITVQwhzOJPRcIQRL69s/ERqBtATCGwu0Dw8tiAXVu1eo3qCsg5?=
 =?us-ascii?Q?fVjZOIzoSFG2P/UYsNRB9oorcLc20CBqi2EcuNB44vnZs0DDI86IWPydqGhO?=
 =?us-ascii?Q?9VCobwWKhz99+4tS4jHWMREMlY9z/LuA4yuk7fLnAZN7qubn9s6IDuVwi0Rk?=
 =?us-ascii?Q?XXVOautnq0Uc0xcmcv7OFoxQvknSTdSHosL8NQbB6XJapoUlMRohkJPY3647?=
 =?us-ascii?Q?tSWgr91MS/acn4pvzqN3T+xgoIPplvxzNmKXRBRHALnHO/+JCN3vf8TD9fm1?=
 =?us-ascii?Q?0nqdoBWjh/OgCPyzNekM4MNgQenwSWuHLRaT/tBLzQDsCrqqcRQoimE8sDF9?=
 =?us-ascii?Q?GO/+qknphI4Vd9VSxwg2QFyxsGrAAITugh0hp8p7lngTXAxzd9MdFsMXCP/L?=
 =?us-ascii?Q?IgmrgHrSVehgG9MSgtLIPc8IDNAIHP+Te1CKnLcqf1vOltwzKKofRYat+ReO?=
 =?us-ascii?Q?1ONZYg5EQEHPWaezPzskJh/m/dZMMRV901qPL2Qizkr3aBqLPQZ/o4wEpOHq?=
 =?us-ascii?Q?aX06TKMyJaY2Lg1KrYf3sETwh3v2XQcIOW58PZA6AS8bH7c3jnO95ALzsRtC?=
 =?us-ascii?Q?+KijBGlKQu2zLeV1nyZPj/BmDGyj0jJTRtkrNk4KziOydTf5TXjJ16Z1efAU?=
 =?us-ascii?Q?npwEPTf9/Nnr/6ltvp/B/Um/JIO63QSJUFfdjzvva4FDBTlKUn/InI7mJXXT?=
 =?us-ascii?Q?ukt51cOec8LOc0x2WuucIRUgkgDoETqMOjOXtYVHmGf/p2QSi44Iym7TBy/U?=
 =?us-ascii?Q?Kq2co3k4yLg1KID7/n3u2OAsqMhPR+nq3XGTvD7X9ZmvnxSWwmXnWnpuQJlQ?=
 =?us-ascii?Q?w9Rq5kXcTiC7AJiNJfTvth1OcnxPFmBBEmoa9ODHBgCMK/BZFB5o68U39URE?=
 =?us-ascii?Q?pmenQfK0Qzl8l+Tsyb+MQDKHmBX/tTEySkSIhKcuvVJ4YsH06fDF1KwtPf+U?=
 =?us-ascii?Q?lJXiuUEyqWDshFOi2/MN1WWrj+IMhxEPE85zhjRZZkDT7T/YEcXA3IVe75/t?=
 =?us-ascii?Q?pXfeHGvSR6GMuuH1rnWYxk8pjfUsUqetvt4YsfoQMuiFUGT3tOIPAkXhOhBz?=
 =?us-ascii?Q?2/UYQhDpCpyGaKg3tZT/SG1qhG0cz0KpoOIZ1PO97FivvteADYPzW+M18AB1?=
 =?us-ascii?Q?ZDrJM0t8z59r8PcBFvFqYbY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FAD233D3C648AA4BB9388C88E7EF0A42@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d66d0b-6178-470e-5d6f-08da65f859d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 00:24:15.9443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6lEd8Z+HH0Cf92cmDjzVANHrxaaLDZp/1BsKUx47usaY1BNnDumGXYx77RHSpk/KqQ63hbnpOQJUX8qlnUt+Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5356
X-Proofpoint-ORIG-GUID: 7rNXUBovaQI1rvt6yf01TwYAap6hkfEd
X-Proofpoint-GUID: 7rNXUBovaQI1rvt6yf01TwYAap6hkfEd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_19,2022-07-14_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jul 14, 2022, at 11:15 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> On Thu, Jul 14, 2022 at 04:54:40AM +0000, Song Liu wrote:
>> 
>> 
>>> On Jul 13, 2022, at 9:23 PM, Christoph Hellwig <hch@infradead.org> wrote:
>>> 
>>> On Wed, Jul 13, 2022 at 03:49:45PM +0000, Song Liu wrote:
>>>> 
>>>> 
>>>>> On Jul 13, 2022, at 3:08 AM, Christoph Hellwig <hch@infradead.org> wrote:
>>>>> 
>>>>> NAK.  This is not something that should be an exported public API
>>>>> ever.
>>>> 
>>>> Hmm.. I will remove EXPORT_SYMBOL_GPL (if we ever do a v2 of this..)
>>> 
>>> Even without that it really is not a vmalloc API anyway.  
>> 
>> This ...
>> 
>>> Executable
>>> memory needs to be written first, so we should allocate it in that state
>>> and only mark it executable after that write has completed.
>> 
>> ... and this are two separate NAKs.
>> 
>> For the first NAK, I agree that my version is another layer on top of 
>> vmalloc. But what do you think about Peter's idea? AFAICT, that fits
>> well in vmalloc logic. 
>> 
> I am not able to find the patch/change to see what you have done.

vger dropped my patch again. :(

> But
> please do not build a new allocator on top of vmalloc code. We have
> three different ones what make things to be complicated :)

It was a bpf_prog_pack like allocator, but named as vmalloc_exec(), 
vfree_exec(). I guess I have got enough NAKs for it. 

Thanks,
Song
