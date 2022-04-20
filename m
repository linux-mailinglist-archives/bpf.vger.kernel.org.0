Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C65B508AF2
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 16:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352161AbiDTOp2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 10:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbiDTOp1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 10:45:27 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831D228E3D;
        Wed, 20 Apr 2022 07:42:41 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23KBfgPw024070;
        Wed, 20 Apr 2022 07:42:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=w01TNDoAw/F2P5Z2ICY1odiri405XzNHvrL9ousHJkY=;
 b=UpxVsuCszv0Tj/MOYmhBpV9K4DcDoTdtKgR3egofLeK/pX/+C67JYZlVyYANmbkTMy3/
 SvJ5ebg5OKDCL5L88Wd7d0Oi4WYuA+4LKRRzGXvmW67XegilzEeh5eKs7ML/JZ1IZfpR
 8BoJt7wro18bOez6JWxt810O2ar5mDe+FVM= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fjhgxry76-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 07:42:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9Ci3ciSAFXO130WUdvpLzwaWRwlv6kchqQrQknIal++ySiViyZUZ2caMRfSJc3ybvPt2Dxwqsx3LiB3EyIkdHkFauEVb562Tx3HXaNliolcY+U48NQsq36MqBe7ZGF1J3GxFLWqODMREktTB4u/3jzf+GOfKSiH/jjJzxnm2Cd7ZiFYFj4eN3OgfViN7io+atpzO4k1k2Xb/qqL4j9btRvhjjLrMfsEtaNN6b8ISzKJrBIZfcSYRzwuBYS3QkG9fybJeHmn9Le6UEZikLI8IV2mnA7oE/Q0cKWMOHodHqgZ9IbKAi2uZg7IkgqXOpWusW0WVHT3EfookhwkyrvDTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w01TNDoAw/F2P5Z2ICY1odiri405XzNHvrL9ousHJkY=;
 b=RcUwaathUrM9vfTA1NPd/vL8+1ewOT7LNCthS9UwevSji7FRi+Sectkbj4v0S+p5pEazUoVx2zShouvVcxXJllmwQ9MgSKDsUqgkQw9j3pQIp1alzPwztnTd5h0hLWEcMZGbbV4YSZsIULy4T4ULV1jj8Zw2M2d7Zuh90Qqba2Pq8lMW0Kve8ijX8GwFYEw+o5liwtpB8e7lcko7V8JAZslyy+EuC4tArCiLme9pURNzmTRLbI3OrJJoWq/y4NyQTSo/+RcwNtitN5ZcJM23VCB8wdEnxkh2Wmpii5y3DHtJ9Gzk58sKKpy/E/+A6F0bApT2B8iIBfI8DwZVRlh/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB2905.namprd15.prod.outlook.com (2603:10b6:5:139::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 14:42:37 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::20d2:26a2:6cb1:3c4b]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::20d2:26a2:6cb1:3c4b%6]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 14:42:37 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Thread-Topic: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Thread-Index: AQHYUOjRr/eYt5HVI0ucQZg4JV/u/6zxVckAgACoe4CAAPedAIAACgKAgAAgN4CAAlYOAIAA9TuAgAAUC4CAAD2oAIAA23uAgAAKuICAAHT81IAAz6kA
Date:   Wed, 20 Apr 2022 14:42:37 +0000
Message-ID: <3F75142B-3E87-4195-A026-3A7F1E595960@fb.com>
References: <YlpPW9SdCbZnLVog@infradead.org>
 <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
 <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com> <Yl04LO/PfB3GocvU@kernel.org>
 <Yl4F4w5NY3v0icfx@bombadil.infradead.org>
 <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
 <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com> <Yl8CicJGHpTrOK8m@kernel.org>
 <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com>
 <20220420020311.6ojfhcooumflnbbk@MacBook-Pro.local.dhcp.thefacebook.com>
 <CAHk-=wiF1KnM1_paB3jCONR9Mh1D_RCsnXKBau1K7XLG-mwwTQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiF1KnM1_paB3jCONR9Mh1D_RCsnXKBau1K7XLG-mwwTQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 873d8637-3be4-4f84-a6df-08da22dc03c9
x-ms-traffictypediagnostic: DM6PR15MB2905:EE_
x-microsoft-antispam-prvs: <DM6PR15MB2905D1DF1BA4FFF7E4110978B3F59@DM6PR15MB2905.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tfKrpjnSatjCP6MRzIpHDFT5SF9F3OaH3DnJbaMRqxpfNTgK5KB5WOLKCiKeSOZTT3a9mn2AZTZ+KO6HE8weA9zoqkc7Rxuj9+Q3L1Hq564rk7BOnFd75fvymolqnzs/zDyCne0H6KFlLacK9Gwwcws4onpyEIi5DEpW2b/0a2RaE+tYTYn4/4XjhA6m8deYYj6pKxDshrxfOM8BQwwm6dFpeeyS2TQ/401/exPdM1FatOuiBxZlzyM1Tzttsd3oQ9djuzzSAY/ac0hUTUGjdXiQgTxh85PgRSm8sakuABHnq/Ww/f7hzR1656AVyOsjzteVM/oT+eKeoG5s+aeUPp2kvpQNfPmUhJioJVbwWm6AQtsCyrMDOJ/ccq2dq/hcwQrakkEa50tR8wS6WBEIENlJY9GR1X/CcN0Eq93N9RKMrCTm3Pe2FFzr5uUIoYjB0W+zwsRbK6hEdRFyhmM3fmmgzvRo8eACVde99lkYKJl7LfkP8UWb/8bmu7cMbXxBNJrj4apYmU/pGp9hZVaguCAOrsUCYjKHSkTPs20Inf9NDtsOLWccxWe89jil/A6AXm31lYPEtdaDPcWzXh/cXyk74GvN/2/xFXdqSH7QkXRMELZbpPCrLXqRitcewtKMeGpJceW2t0MsqMeQYUDWB1a6cUI53dyFKz2rT5YO5dc6p/WBd6Gcl6+UcGYwQvcBag4fYxdXXQURbtpPrsF8kNvGw2SDqQ5NDYzCgby90iVkNhLg0041pk2qrwXaD4QSREWqOl29iq9aX5gULpsCPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(7416002)(91956017)(66476007)(71200400001)(5660300002)(64756008)(54906003)(36756003)(38070700005)(8676002)(316002)(86362001)(6916009)(122000001)(38100700002)(76116006)(2616005)(66946007)(508600001)(66446008)(8936002)(26005)(2906002)(6506007)(53546011)(33656002)(4326008)(6486002)(66556008)(186003)(14583001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wTh5VkcLZysLZxxnUi5+f43O+QkWg8rObtHhHR1T5GSEPpBNgaYmVse3dXCj?=
 =?us-ascii?Q?LlV9Nh7wacUNP5ebcV+m2DcWmA0Ln5Hlp4884duKz0AZZ2dbQwp8kUd8j9mb?=
 =?us-ascii?Q?n1aNk76TBbnLo0InTW9LavK3OWbvJKiV+C4RKqsz2dWMsDIQgE2O52oaFL+L?=
 =?us-ascii?Q?D8u97qDK9RYNaoG6if0eHeTbM8FhMdnf1lz5mEKZZoj5EwEW76bZVI4e50RN?=
 =?us-ascii?Q?ouzRdqJS4bTL/HTAQp6LKvqZWC6JnP/3o4pZK+tQlF7M7HR20wNx4TxCyisy?=
 =?us-ascii?Q?dhVYc+Js7gmgZctsHiSNaUsxFZirrAJ2mxuD61oTN9SUoG4mSqgswgh5lu0o?=
 =?us-ascii?Q?sdanO3wuaiYET22KgJrv/eorkQVgMoo3XryaxmpbYQc07epM1+c1uJKL8atP?=
 =?us-ascii?Q?/5QAVFOfbWxLa65G3K2+x3iW96tnOqtvCx+FsRp1b2IIaU98PRDEK62b7e1F?=
 =?us-ascii?Q?xn7jLxpdOMD393Wv3MXL5N5F+HwNT3p18zdGYYmPftXlymsVwJHnBBff/hjm?=
 =?us-ascii?Q?bALv6Z3BNPdrBniAa5/ExwqZ1/V7Fp+iv8w2F0L1J0o+JL4Gc7XyRWg8Npii?=
 =?us-ascii?Q?GqjIiNVLTGwVvKa2QQdG/IpisOinAc7ErS6zDdsgkid5IccyAF13ZQ09eteT?=
 =?us-ascii?Q?0LXm/5Thi2ihRcQHa+eaWsShK87BshdEFuOdsHMwQGFNDYlhtdZDQbZo/Sdq?=
 =?us-ascii?Q?TyWs3Gwfp1PkgO4Fjf8DRxEMy+WvC4/vXT3Y5XRGX/d9D5DPSf6Jr8Qqf46P?=
 =?us-ascii?Q?MZjFYKkKZzhE+wwvAMDCRLdiIH51zkxx1h7gFChJuJK6Ih0rhLwO7QGAEizl?=
 =?us-ascii?Q?vP/jk6XdVfO2Q17yZUIJjGZ/XlaFYTSvl3407OFzHSedhybwDBuHA0M8p6Ik?=
 =?us-ascii?Q?MSkiZQg1MbSblWjBJJJz/HHVwMQpkp9Ww3Q/baLJA0+ks2c8HJV78gL4cFtu?=
 =?us-ascii?Q?yDbG+/uHKOr33wT6/BdoSJygz9nj9LgfcQhHHUrGmnaAw3NOi2u5OrQRzPDM?=
 =?us-ascii?Q?aDHBHzzuRHedXML2ScyJRBhr9m7201dBie8OEe9p0zhyHDA6ruVgnBbmDPKO?=
 =?us-ascii?Q?+XfjbhF+wb1A7UR0/actohZv5dzqKLe2FLdSvh2XaQwmLK43h53/MlaT2alX?=
 =?us-ascii?Q?uCOpYJz0WBlceYdpPEmJJxoUlygVs1Uzp5MwMJCbkRcecegokuqN68GAQWCd?=
 =?us-ascii?Q?PEJptVow4qIcB9OWA4EXJYwIpuoOaRj+fxXnMA1b+aQjUNkdZSqcVyHvPVsx?=
 =?us-ascii?Q?6eAiWTi/SB2vg55Lg1pyvlStrev9wb7+NWHKKfwAx+1a6r+3klZaBjdutvQX?=
 =?us-ascii?Q?95g19Qt0m/TORRvc96OgbNlyRVQuPA9I7yYNDvQ4EBlU/qETTTQQW+yT2gvr?=
 =?us-ascii?Q?NoQ3J054fKOz8cjg4uwvUlVpVWx+ECaRT5MkiQ8NMPFwU5JncU6CupcmiNRV?=
 =?us-ascii?Q?qibUfQHJoh/oGuM1cur/osQ4cIsZEd5I6KL03l+4DF/MFyfJtcIt0xKONuXv?=
 =?us-ascii?Q?vNt1DcX0Sfo+jVkHF4FBauVyWQFiA8edJZdPdPtvx+zuqFv5rPvAgk83NAL2?=
 =?us-ascii?Q?5FpstDCHPFG9UMnERcyJiYmwbA4b5JeZU5pi8xmFaG06Cwme48vD8Ko+wbpm?=
 =?us-ascii?Q?h8wKUXGl2zI3re8TwLPkhmmz+T/Bi9UnM54Rypmu6V/tWlODczGslI2t61c3?=
 =?us-ascii?Q?XOqIdFQaWuHLrTodSNYGzWu6CMHKQmN+iKF0yceGr/aZ09Qk6+UcmvufKcZ7?=
 =?us-ascii?Q?uKUxzTTfO6jeGwILM9DrhTqlsk8qdbE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BFBE8765647F8E40A45856226D6FADD8@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873d8637-3be4-4f84-a6df-08da22dc03c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 14:42:37.7261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ks+T/flHOxZYHPl8D5iJdAjw65uwzCWGIVgNIOAgmlKUHk88ABeo3i2bLYJcowLuDX6w8BhJ0YlYnvOi+Pw1QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2905
X-Proofpoint-ORIG-GUID: uwA9Sc6SdeAW-kR36YZTo6ic6bgDB2HS
X-Proofpoint-GUID: uwA9Sc6SdeAW-kR36YZTo6ic6bgDB2HS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_04,2022-04-20_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Linus,

> On Apr 19, 2022, at 7:18 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> On Tue, Apr 19, 2022 at 7:03 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> 
>> Here is the quote from Song's cover letter for bpf_prog_pack series:
> 
> I care about performance as much as the next person, but I care about
> correctness too.
> 
> That large-page code was a disaster, and was buggy and broken.
> 
> And even with those four patches, it's still broken.
> 
> End result: there's no way that thigh gets re-enabled without the
> correctness being in place.
> 
> At a minimum, to re-enable it, it needs (a) that zeroing and (b)
> actual numbers on real loads. (not some artificial benchmark).
> 
> Because without (a) there's no way in hell I'll enable it.
> 
> And without (b), "performance" isn't actually an argument.

I will send patch to do (a) later this week. 

For (b), we have seen direct map fragmentation causing visible
performance drop for our major services. This is the shadow 
production benchmark, so it is not possible to run it out of 
our data centers. Tracing showed that BPF program was the top 
trigger of these direct map splits. 

Thanks,
Song
