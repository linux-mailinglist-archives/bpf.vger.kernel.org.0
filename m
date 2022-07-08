Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F27156C43F
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 01:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbiGHT6v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 15:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiGHT6u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 15:58:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0985017E2F;
        Fri,  8 Jul 2022 12:58:48 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 268IrJZA010299;
        Fri, 8 Jul 2022 12:58:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=C2bhzOEQ1nf+J3y5nFDaE2u4ul/FfeyRaniPa5ySFnw=;
 b=m0zUh06Ddur9Kmy+3ungCxy2tHqAPuBONlNggmfgo5OI7XAG0qm8p89ctYvFR7LfdmvJ
 krHx22nZv00ZYZ5OvfQBm2eJCSqDMEHp47LppMoaJZNHlxGHjy2itWAMCOKXdMYPuVSP
 npVgHA0SaFcJUXn4P7cwwmSXHsM+0MIJhtU= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by m0089730.ppops.net (PPS) with ESMTPS id 3h65q4fd3v-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jul 2022 12:58:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrxVYZRSNgZJePs5lhyDWAd15VE8NCMVyK8dKi8Pkd51+YzgnYYP96cKKjJnR2pe6SKtJ/fhmsx1ts5rKtUrcVRc1BrtiOAC5nBGP91OvhV3OPL3F9cUrpJ7WFSGBC8oQEsg9nXm4CSCrpNSl91yliur1tptZLmgcFzFoWi7/cVaMCQJG2M60tVtlKRRj5RFsMiYSdD+YmAx4occRZNNUgNUbskiCBh1rpyFfXzQC/OmgAOo1reFowV3jRuWlf781/JPJfyawBlXyNk3kIJjtEVWUYrYdbT7/+EJnVMtrAcfhQlq1f79AnKrj/qCqz1MpNtEU0Qla7LYj9XTuHKy5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2bhzOEQ1nf+J3y5nFDaE2u4ul/FfeyRaniPa5ySFnw=;
 b=eY/JEAwqWQEJ+XC1pnj53RYl/NzGlbY01a1fYC2amtvBUQkJtEHjaSLH3N+Rzxruxy0dGErdCwJBK5r8bEjoJ2+AFxvWn4jzTU7ZRU4bwTv3fFt8j7x0439jmntv09+ejPzVa/2rH6ZhjRs3AqB+pGErmMzx9yXY32MiAiyl7RigVAe2wXaN5uMMmBJBOglV4A3ELFJq9061jTRR+QOonT4obQaXOrfXLGPjscpczMw2cblz4Xo8Cdwg/MOlcT26PS23WSLUU0JBwIo7aXC476a0e5LPwECE6Dwe1E4CMfxsegWObvEEnyfs2epclPN8Bf5SiMEtvVNGzBVQD7iw5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CY4PR15MB1398.namprd15.prod.outlook.com (2603:10b6:903:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 19:58:44 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e8cd:89e9:95b6:e19a]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e8cd:89e9:95b6:e19a%7]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 19:58:44 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v6 bpf-next 0/5] bpf_prog_pack followup
Thread-Topic: [PATCH v6 bpf-next 0/5] bpf_prog_pack followup
Thread-Index: AQHYklIC37qezjyxh0moueFgoO/pNa1zhdgAgAAO4YCAABD0AIAAC/MAgADwxACAAEM5AA==
Date:   Fri, 8 Jul 2022 19:58:44 +0000
Message-ID: <863A2D5B-976D-4724-AEB1-B2A494AD2BDB@fb.com>
References: <20220707223546.4124919-1-song@kernel.org>
 <YsdlXjpRrlE9Z+Jq@bombadil.infradead.org>
 <F000FF60-CF95-4E6B-85BD-45FC668AAE0A@fb.com>
 <YseAEsjE49AZDp8c@bombadil.infradead.org>
 <C96F5607-6FFE-4B45-9A9D-B89E3F67A79A@fb.com>
 <YshUEEQ0lk1ON7H6@bombadil.infradead.org>
In-Reply-To: <YshUEEQ0lk1ON7H6@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd22fbbe-0d05-4ea7-ad12-08da611c437a
x-ms-traffictypediagnostic: CY4PR15MB1398:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uOiFbsyl/enytZJokpi/OD+RCGV05O/g4q0pM/WGCc+//HmPNcJHAnNE8wyYPZcArMwmvMRrDVGjrzUbWE6edUG1Nu1jThmtYMDENcZwU+NJnIrec0MTMYL5btUv0gckXyzsZNwO2IbQWqoGTyxb05ti67reDki2SeClob/78rCI8bsOiIJDHl0bLfU98Sgv0cuN0jcJAwY8Rgtfk+5++kvYPFxM808ZKkwD2eb1Guh2OSgFOXv9WYpCXt278m3NgA2ZsF9eMUijA3K5K+5v2sExLs+cG6f79lic4pwVSykLkZhTSUwVuUVODw1GrtbV2GVL3c8yC4y0mD9MEgW5Rb90DxmcGzxiH/v5ZHmVOHPAaG87O9depVqPCRJvWlsIkqt/K3TlCIsQLb5LXnBLugTwrbunAoW4QfHQumDUY7VH7TjdizESdHfRucfh87JoXCkAK9Q3yG2Cyu/6V7vanHccEEEiHMWZ9/UAhICwThO0I99IDEo3jScgY4PdVQSMR7/g6YLDFoY8SvZJOF5ZcqObK6/TPpiEX7LZlgBhIHmaAXdYRAtzSAh18KvXUIeQlRXnppCQbBlziXGKA8uOZ8yjU3GLtDYGTtcRaIpeBNQ66+10Zvzkzv8aWsZfhJHiQ0TR7GsA+4HEOO4GLt76mETa45nZC5g3wrL95B5ogDbQPd409MMx9ZaZKy1lEZXRsvnVo6AtduhscgdvPOQa4krzDFds2ODsAPl4NsYp1VyDy10orxwxHe82Xj7w5WCKwEs0/sVanRpNoiPf7ZcdbIGP4263yw78wupSQSl3EpfzFed0qsjYQW4nqJzW0LKaXGzoo73pk6emAlZmFwTsFV6Yv3VT3WtoBbqExUE9TqM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(38100700002)(33656002)(8936002)(478600001)(54906003)(122000001)(6916009)(316002)(71200400001)(6486002)(76116006)(5660300002)(8676002)(66476007)(66946007)(66446008)(64756008)(4326008)(186003)(2616005)(66556008)(41300700001)(6512007)(83380400001)(38070700005)(2906002)(91956017)(53546011)(36756003)(6506007)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aXlclE+jIr55uyTEbLPrK3wlkVFUFunvVpkWIPHWQv2Fx9VFPeZhoB0xIWAi?=
 =?us-ascii?Q?CW7IMV4YTY32JlpUi3WR/Dt9/QlOiw7lxy9HMMqA9eHz6vxfy1KPo8kKm2u/?=
 =?us-ascii?Q?sfoVn6gxY62X0z0hzN5xehuZ391PkP3Whbbd68hM3oXOENg7JJhhCNqHYzsh?=
 =?us-ascii?Q?zieIGkiu0ARF+NlnLmMYnUwvHJxCkkT9JQXqdP8zpvki1D9R7q+qpCB7HgHq?=
 =?us-ascii?Q?4KtSQfxY/bag+VgoRtM4iiVQTCehpBPkMmLmxyyn5k9mONHtV/M6KcieP3yI?=
 =?us-ascii?Q?Debs/RYFwFMbJ6ItQpwuEay0j57M/5NWCItH+RZiNu7MOEtG0lxdHwr5Y9U0?=
 =?us-ascii?Q?kBh2rr7NEclrZLzqZhjhhtMujkT5SL+DKtrHJcE/nzCQXp0a7TLLSh+jN6p0?=
 =?us-ascii?Q?t1hjj/QYeKcRyviUDO8CXcKUcOr6VsNSSWmU/g9AeWT/GlEsURuYIz9Tnnq+?=
 =?us-ascii?Q?hEj2n8ZQ1zoGiIKEcY2skm3YbfXJUpOqShvybe9P9bXaYXxfhhiMEK1GhNXd?=
 =?us-ascii?Q?vwT5DPztHexz+8sTz4N57hpX9CsshxDAjzsPdb4jVjMIsqk7HEQeEVLPOxT6?=
 =?us-ascii?Q?v4rZd9R08lKKcg0T9XY1CFcowA+0R9elpV4cCK76Z8Du8Hzdrs7JMSqboZg7?=
 =?us-ascii?Q?pDeK76KKg9oIY2YE02QM34kdA+k/088R8jdQsMTS9lV3zjpOQ2QdjMX+9jvR?=
 =?us-ascii?Q?b4T4d38VAiRpKvPbNCH40r+X1Ew4Fn7CyrrxwvktBb6esw5+8xxjEuLDb7tt?=
 =?us-ascii?Q?Vf7BIm4GVCoBLgBuCdi0rVLgXVtjdpurUu3wiOpL/E+1G1dyGiS7lC06AByp?=
 =?us-ascii?Q?t3bJ3n7OUVbzPnlR0gH3z9PG0mZ10TPsEMoDzlqpMti1PrQK0/MIPgDIvJ+5?=
 =?us-ascii?Q?nMArBbJ6APkD9dowiodz1pCDRuGLXEesuQVeNQO5uGLCOHUoQpxGv/wZmr3o?=
 =?us-ascii?Q?qKIuu++iLO/gPcCWFiAovfbFFQzqkViqeJMDVT6GHTLv0h/+9gq/5fAsKKs9?=
 =?us-ascii?Q?Ga/3ScnTNtoACCpOnSlJxD8E20KheuToQHA9Dv3LFi2gTjToFWd+L2lY5Hm8?=
 =?us-ascii?Q?9dgtU3MYJpmdtWlovFzv3cmJd5+/WWm+o5oeKu8x7ekHuDBRcx4bUihmDh6z?=
 =?us-ascii?Q?7//QGFBqcwBkvKbMAvF7dhNxbTTaUGKMlcGH3QfdAb/FovvFWUxrKOdBD8ZY?=
 =?us-ascii?Q?5WEAiuBhfEbm7nX5vEhi3xgNZA5qVZMtyoz/HJV/vefUUey/Sxal+B9SZlZT?=
 =?us-ascii?Q?0X/sdqBP7P22arDH4Z+HGUgltKqXwOw0ZarN2F4vSoWN7jw0lk6C/BpRWxk0?=
 =?us-ascii?Q?X1Ja5SZ4WNgxG44wHGhnvLaAC8JipYvbgBwkDt49XTukOUj2W8HF2/veY8qh?=
 =?us-ascii?Q?pLMaLVD6J7oTHZvEvxoNRdPFKj2x6bhRsRHqkOstSkkBxlTnteKxyo/Y27sz?=
 =?us-ascii?Q?FeYz8Hq2Ky3vz2r9dGhNHkNbYdiWRzopq+COXp85r75MZfhsYTZNG1W4h7yU?=
 =?us-ascii?Q?W/7IY+o5qBKdPzAs3gR3newSb8xfZuG1aa1Rvht1QG+IF6G0kJHMx0n0xqII?=
 =?us-ascii?Q?P1B2ZEstbABtgD3noirMmxCPmffqIrJeQYPuomoNG/2HRg0BGxW8jTmQNku1?=
 =?us-ascii?Q?6xR/U75huh6XpJTgOn2W/zk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EEEBAD2A9046FB45802D9A0FC13B1CC2@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd22fbbe-0d05-4ea7-ad12-08da611c437a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 19:58:44.4969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WsxaT7Si3u8w7hlJYWsOysZ342Y9iFrtgNqsm5MAm2begE1knQW1WhZFB/N63DUOjkpiBPILNFAemHRmdeUeEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1398
X-Proofpoint-GUID: nXWKyprY6TSh414_P5AZ6zg52XAlLjEK
X-Proofpoint-ORIG-GUID: nXWKyprY6TSh414_P5AZ6zg52XAlLjEK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_16,2022-07-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jul 8, 2022, at 8:58 AM, Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> On Fri, Jul 08, 2022 at 01:36:25AM +0000, Song Liu wrote:
>> 
>> 
>>> On Jul 7, 2022, at 5:53 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
>>> 
>>> On Thu, Jul 07, 2022 at 11:52:58PM +0000, Song Liu wrote:
>>>>> On Jul 7, 2022, at 3:59 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
>>>>> 
>>>>> On Thu, Jul 07, 2022 at 03:35:41PM -0700, Song Liu wrote:
>>>>>> This set is the second half of v4 [1].
>>>>>> 
>>>>>> Changes v5 => v6:
>>>>>> 1. Rebase and extend CC list.
>>>>> 
>>>>> Why post a new iteration so soon without completing the discussion we
>>>>> had? It seems like we were at least going somewhere. If it's just
>>>>> to include mm as I requested, sure, that's fine, but this does not
>>>>> provide context as to what we last were talking about.
>>>> 
>>>> Sorry for sending v6 too soon. The primary reason was to extend the CC
>>>> list and add it back to patchwork (v5 somehow got archived). 
>>>> 
>>>> Also, I think vmalloc_exec_ work would be a separate project, while this 
>>>> set is the followup work of bpf_prog_pack. Does this make sense? 
>>>> 
>>>> Btw, vmalloc_exec_ work could be a good topic for LPC. It will be much
>>>> more efficient to discuss this in person. 
>>> 
>>> What we need is input from mm / arch folks. What is not done here is
>>> what that stuff we're talking about is and so mm folks can't guess. My
>>> preference is to address that.
>>> 
>>> I don't think in person discussion is needed if the only folks
>>> discussing this topic so far is just you and me.
>> 
>> How about we start a thread with mm / arch folks for the vmalloc_exec_*
>> topic? I will summarize previous discussions and include pointers to 
>> these discussions. If necessary, we can continue the discussion at LPC.
> 
> This sounds like a nice thread to use as this is why we are talking
> about that topic.
> 
>> OTOH, I guess the outcome of that discussion should not change this set? 
> 
> If the above is done right then actually I think it would show similar
> considerations for a respective free for module_alloc_huge().
> 
>> If we have concern about module_alloc_huge(), maybe we can have bpf code 
>> call vmalloc directly (until we have vmalloc_exec_)? 
> 
> You'd need to then still open code in a similar way the same things
> which we are trying to reach consensus on.

>> What do you think about this plan?
> 
> I think we should strive to not be lazy and sloppy, and prevent growth
> of sloppy code. So long as we do that I think this is all reasoanble.

Let me try to understand your concerns here. Say if we want module code
to be a temporary home for module_alloc_huge before we move it to mm
code. Would you think it is ready to ship if we:

1) Rename module_alloc_huge as module_alloc_text_huge();
2) Add module_free_text_huge();
3) Move set_memory_* and fill_ill_insn logic into module_alloc_text_huge()
  and module_free_text_huge(). 

Are these on the right direction? Did I miss anything important?

Thanks,
Song

