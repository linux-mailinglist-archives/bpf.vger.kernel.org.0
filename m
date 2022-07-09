Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B34856C59F
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 03:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiGIBOb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 21:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGIBO3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 21:14:29 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F424E630;
        Fri,  8 Jul 2022 18:14:28 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 268MnLpK013395;
        Fri, 8 Jul 2022 18:14:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=BAShS4QXAvdepB4wm01nnWFDZgmJdeXhvtasMcHgFxE=;
 b=fNfQCAcM61TjwYV4kAq5pt1y5HQKUcXhqOugPI1ToKZxJALjy252iNteVfXrGWV7cgI9
 W3hf6GnddDXSWbKl0odPITeqgL9gPtfyZL2CQJzYLxk76FFy1iUBOmW84X7GgxgYbPS/
 TGMPkoiM/nnLZL/hdXtftRE99hQj+qx0SR0= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h624utk9m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jul 2022 18:14:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0PUn914POybJxIK62Q8hkn/SO8QxVtML4Pnq76v20c15KVsEGxgwILidXQ/JewiPcqFmA10bK9TNZZFzukAijEcsRQKjH5XG/6zIsOMxIO3X+z9qRDd7LW8/GUBOoPZR0tfaTVZbR2jZiaN3tGpDrcwA7EIWxTNs0u9T4vdjCnrSbp8+lxUxLQ5zG2rPq4GzMYwsTQMN5GbpDHCSuF9g5DmIptdeCYoXDtKwf0RfsAS/jRwbeiJ9iuV9z4jfqkwtpEnsD3/djtAMnSU2RaZnuVlXoX2k1kydNbLGgxc+qtbrWSrgeP9UNnKKaf5+kPmnAKj2ljusG78DjrzDpjHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAShS4QXAvdepB4wm01nnWFDZgmJdeXhvtasMcHgFxE=;
 b=kSHjN1Hg6PuELn8ItSEu2QrBk/kKzHK8+4uaOWXaFG+kctBCTYnTN2S+vSujh87e/mS2lgA5Y07E4UbAInb77ibdq/84JQaX2GCkIwTUa3p7qpm7clk/b5CkK3R5lAflz1ND2sUc4ExkaNwxHkTrllbeT78T5nTojEJtPxmnsLBBqZdW0jrGcoR4QNVLiYahRehcrj0BDOOtAqdje0B9Eo3nyvfhuDw1RAdFg1wppyG72WYE/BrYyQkXnXamjfnT9jFHgO8mGfo5H5/IeqCWq9APRzb7N82Dgd9z1gQf8bCKDJxPnbdZxFE2gAUm8vkTncwce1bkOim2G7g5LV062Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB2202.namprd15.prod.outlook.com (2603:10b6:5:8f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Sat, 9 Jul
 2022 01:14:23 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e8cd:89e9:95b6:e19a]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e8cd:89e9:95b6:e19a%7]) with mapi id 15.20.5417.020; Sat, 9 Jul 2022
 01:14:23 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v6 bpf-next 0/5] bpf_prog_pack followup
Thread-Topic: [PATCH v6 bpf-next 0/5] bpf_prog_pack followup
Thread-Index: AQHYklIC37qezjyxh0moueFgoO/pNa1zhdgAgAAO4YCAABD0AIAAC/MAgADwxACAAEM5AIAAKMMAgAAvboA=
Date:   Sat, 9 Jul 2022 01:14:23 +0000
Message-ID: <6214B9C9-557B-4DC0-BFDE-77EAC425E577@fb.com>
References: <20220707223546.4124919-1-song@kernel.org>
 <YsdlXjpRrlE9Z+Jq@bombadil.infradead.org>
 <F000FF60-CF95-4E6B-85BD-45FC668AAE0A@fb.com>
 <YseAEsjE49AZDp8c@bombadil.infradead.org>
 <C96F5607-6FFE-4B45-9A9D-B89E3F67A79A@fb.com>
 <YshUEEQ0lk1ON7H6@bombadil.infradead.org>
 <863A2D5B-976D-4724-AEB1-B2A494AD2BDB@fb.com>
 <YsiupnNJ8WANZiIc@bombadil.infradead.org>
In-Reply-To: <YsiupnNJ8WANZiIc@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9216f3c-978a-41f2-0c35-08da61485c14
x-ms-traffictypediagnostic: DM6PR15MB2202:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hzuWXTWPyMwHTDPKJB4Ak7ohfkwyWIX3ywiPdUjvI4CZz53PCkOHmj/QgaXgN2vsPmpsP9WEapyTW+mn5CqLPX1T8uwLHs+hlSJ0ftrCYiSeADNeIWxmIZzEDPKGCLsmX+EoDNNLcNP7RBaft91+P/k1nb68QUVdoIsAHO8We1wWlUWbvI/WPFKInQXZZgWuc3tbCdyNK20cyGvU99hW1DWqJq0rkA05/Xw7q7Wrn3oXkyKGM0VG6BiXV3Xk5X+YWoxAsgHl/pPraerXk9G14oRx0yzfk5jiVdGKxaDLkzHtgjNBpVkoDIJzM0dyOWU3j609m+hXcidOSnbTdw4RC/B+oOckYUseg6cni/vJEMi+EnB5q7p5GNXp7tOSibNyRg+tRUxORbLy6tTrjX+nutqN/F4D+efWIswj9SeHZ2EgLfW8NxR3SU7mvKhs2AmkIIdv0/zSozwEJQ8xpvlAa09jwPrQXGcuNjRzPEQ+7dwBglAep1c2KaSeuI17cvvVAwXF+vjUaQUKpZo7rlDlbSTmRu8owgo2yAnE8TtFP3ZcpZHCWIlnD4pi1IqdjMgzuSOn4ypMlG+l21O0rhGBu4Gh+ZSbGvgHtuFtAFljaegCu22wNvNjSHRlvjrYSK/c3TB82KZLp0E+K90OhOfNKMgYnOnT6JS5YxCTRS6Dcpun5Vfb0aVmZGAIg9CvSejkeNSgzDm1w18VsY+TjNvaeRpo62M2F5ZUIh1scwkkRUwFUg3XsL36HhttHqInw1+Q0Ke3q69ZpCGn4YptLgUzgG0SwF7aABJrQyGDAsttJI66fi3+Hna2M3sKFDNc4alS7KHoabWbFybuMI3LC8yFfyx69kOg/RFQVdrjJb7M27q5QqutzoziLJE6Vr/GFOpC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(6916009)(91956017)(7416002)(54906003)(316002)(4326008)(36756003)(6512007)(53546011)(41300700001)(83380400001)(71200400001)(2906002)(186003)(38070700005)(66446008)(66556008)(8936002)(38100700002)(966005)(66476007)(5660300002)(6506007)(122000001)(66946007)(2616005)(64756008)(8676002)(6486002)(478600001)(86362001)(33656002)(76116006)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fXEPGDfOCTH4MkL7LcvvGYnIE+umElI+UjJvlaxPZ58hPIYx3cnQ3W+vGbCq?=
 =?us-ascii?Q?Wxxz9XMTrPONnT8Plh3fCsvDFVUWe2kqK34AIo9YgbS9n1jLKAHic8pQahkn?=
 =?us-ascii?Q?CZ/noSDotqh8aR8XSChMkmnut0MgqH8vqeUXHy4K8jv14bM4P7RUCNN25wQF?=
 =?us-ascii?Q?VT2sNX6eimEjFei15T7tZknuyHJjx8xi4Ef8kqe9rUeR94bH62vHJ91SdDcb?=
 =?us-ascii?Q?qJVfeT9cvqkLo69zIs8zCjM4HyAtHBelxvDMGf9hd1xLgtSlZc0Ecvky4chh?=
 =?us-ascii?Q?RKW4z/w/RR1vqXSKZMLiU/1HWLnK2QaEI75//LfD58bvSyrzENK2oP1Xn02D?=
 =?us-ascii?Q?QA5xCuBnNmCV2/pGzTWbmWCIjWrqXXFP+RaFEaDh5TBPAQMKqKI3I51OOaEI?=
 =?us-ascii?Q?QmcGq6B/2FoPsGsIfww74n/mLdQNIoQBUnd8RaICLWqZCBy9ZII4fVmmi31q?=
 =?us-ascii?Q?VpbvV5VeRjoCYOz0pAjOrQtsjFqyEqthvET8/AKLLCXmlj7hjdilDC9iVION?=
 =?us-ascii?Q?T1HSvvGOWJdlDsOWQkRotsfgBPQWNkpMFCDSy3vmiRrz8C9PzbecPErBOgPy?=
 =?us-ascii?Q?n9DrPHkcKkKoF8CHmiSouBDwi98l9Irda4z8SddQZq9qMjoyBWc4CrGns/xE?=
 =?us-ascii?Q?dDfifZbd+YIEEpJbS8BwA2SE5RmJShjPVrhDZyEp59IzZuaeBAW/BG3cQVaz?=
 =?us-ascii?Q?3bqQMXBeJxJMeHhbk3vMJ9caDzGYMzXkQwYJmeb4bRPU1iH9PH/e8a0CVF5b?=
 =?us-ascii?Q?Y8abOSMem/FjdZ3ObvUMJR+VA/9Nb8kfaIg+SWToL27lQMHsJlnRPFLqbmba?=
 =?us-ascii?Q?kthnL7SScFeE6iXEUGwSLB8KZ9HFxPpxWH3xJa1LmcwzGcbvrzjZ9HGpZ+ID?=
 =?us-ascii?Q?vnTI0jPf/TjY4kFCHARF+dLddHdZrr8hKAmmvw5+oGngJuwImJjIB2WMnHyk?=
 =?us-ascii?Q?wOCyoGNVSkh0qZN5uDdmbXSdDPCQiGMAuQLLn+SsZxK89gBB7X3s0F67R2g0?=
 =?us-ascii?Q?52rsVlLMV9TSyfQIsIEzWvjWVa0JHnkoik/NHiNxG98fstT5967MDcY9yCwN?=
 =?us-ascii?Q?7t2+dgp+8ftgApx4Jl2YnzyXcT6GUl08HW2sTaj8SDwhkkJBkTb72V7rnZmY?=
 =?us-ascii?Q?/F5Oxf2L8JC65S31jkqbOMS8Gj8xJ64259T2utq/u6n8jjVmkPKoEKnBtlyL?=
 =?us-ascii?Q?5BtMbvbSDi0Xs4WP5Amgixi0EjBYdDDT5jQbkK6FOElAFrMxW1f3RkoR9GrZ?=
 =?us-ascii?Q?achM3CVU+ZVtz8nTonapWjJ+FGUHb0PXamluL3Qd5xIMrrWkhic2QMnuyTNc?=
 =?us-ascii?Q?mvG4QWq5t8gQQSTjfJE1EKegpB1/X1ZjXdm60YUbpkJaNN+epmmETr2ONX1/?=
 =?us-ascii?Q?wiy7ah8cShZrVIgZe2iB4YNXHzwLqIPgREkiXXrv1XCMBO89wP27kcPZO2vm?=
 =?us-ascii?Q?pyAMqhb5jim0FC1ZrpXPrfh1RrQePUkTgBnTWU/1qDbwcZOubve+soinSkhv?=
 =?us-ascii?Q?ehrtGwPsRnsUY3ycg1F5fHbC30BLmAZoHBszaeOZPzePTbjVsr1d8glmT+9m?=
 =?us-ascii?Q?1E8mUv2FtGcWW1x2MpnUvsQWXGmWav68lcN+6Zl4hkxiDHhRUHo964T1jj/M?=
 =?us-ascii?Q?lUP/vpATj3pcQqtvQrmtHo8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C9CBD60CA4E9FE4B959673DB00B282F0@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9216f3c-978a-41f2-0c35-08da61485c14
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2022 01:14:23.6235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dG9pA4Wuots3SJNkBLT4Q7RyMj/eUuzgliGnwUADlX62+6Ypt5CjMnfgOLZXjLEO4SrA0EM/6qAKEQdGk0FNzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2202
X-Proofpoint-GUID: CoDevRocvJ-yu2Qf8uyV2OHOtV1zSBqK
X-Proofpoint-ORIG-GUID: CoDevRocvJ-yu2Qf8uyV2OHOtV1zSBqK
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_20,2022-07-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jul 8, 2022, at 3:24 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> On Fri, Jul 08, 2022 at 07:58:44PM +0000, Song Liu wrote:
>> 
>> 
>>> On Jul 8, 2022, at 8:58 AM, Luis Chamberlain <mcgrof@kernel.org> wrote:
>>> 
>>> On Fri, Jul 08, 2022 at 01:36:25AM +0000, Song Liu wrote:
>>>> 
>>>> 
>>>>> On Jul 7, 2022, at 5:53 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
>>>>> 
>>>>> On Thu, Jul 07, 2022 at 11:52:58PM +0000, Song Liu wrote:
>>>>>>> On Jul 7, 2022, at 3:59 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
>>>>>>> 
>>>>>>> On Thu, Jul 07, 2022 at 03:35:41PM -0700, Song Liu wrote:
>>>>>>>> This set is the second half of v4 [1].
>>>>>>>> 
>>>>>>>> Changes v5 => v6:
>>>>>>>> 1. Rebase and extend CC list.
>>>>>>> 
>>>>>>> Why post a new iteration so soon without completing the discussion we
>>>>>>> had? It seems like we were at least going somewhere. If it's just
>>>>>>> to include mm as I requested, sure, that's fine, but this does not
>>>>>>> provide context as to what we last were talking about.
>>>>>> 
>>>>>> Sorry for sending v6 too soon. The primary reason was to extend the CC
>>>>>> list and add it back to patchwork (v5 somehow got archived). 
>>>>>> 
>>>>>> Also, I think vmalloc_exec_ work would be a separate project, while this 
>>>>>> set is the followup work of bpf_prog_pack. Does this make sense? 
>>>>>> 
>>>>>> Btw, vmalloc_exec_ work could be a good topic for LPC. It will be much
>>>>>> more efficient to discuss this in person. 
>>>>> 
>>>>> What we need is input from mm / arch folks. What is not done here is
>>>>> what that stuff we're talking about is and so mm folks can't guess. My
>>>>> preference is to address that.
>>>>> 
>>>>> I don't think in person discussion is needed if the only folks
>>>>> discussing this topic so far is just you and me.
>>>> 
>>>> How about we start a thread with mm / arch folks for the vmalloc_exec_*
>>>> topic? I will summarize previous discussions and include pointers to 
>>>> these discussions. If necessary, we can continue the discussion at LPC.
>>> 
>>> This sounds like a nice thread to use as this is why we are talking
>>> about that topic.
>>> 
>>>> OTOH, I guess the outcome of that discussion should not change this set? 
>>> 
>>> If the above is done right then actually I think it would show similar
>>> considerations for a respective free for module_alloc_huge().
>>> 
>>>> If we have concern about module_alloc_huge(), maybe we can have bpf code 
>>>> call vmalloc directly (until we have vmalloc_exec_)? 
>>> 
>>> You'd need to then still open code in a similar way the same things
>>> which we are trying to reach consensus on.
>> 
>>>> What do you think about this plan?
>>> 
>>> I think we should strive to not be lazy and sloppy, and prevent growth
>>> of sloppy code. So long as we do that I think this is all reasoanble.
>> 
>> Let me try to understand your concerns here. Say if we want module code
>> to be a temporary home for module_alloc_huge before we move it to mm
>> code. Would you think it is ready to ship if we:
> 
> Please CC Christoph and linux-modules@vger.kernel.org on future patches
> and dicussions aroudn this, and all others now CC'd.

Sometimes, vger drops my patch because the CC list is too long. That's 
the reason I often trim the CC list. I will try to keep folks in this
thread CC'ed. 

> 
>> 1) Rename module_alloc_huge as module_alloc_text_huge();
> 
> module_alloc_text_huge() is too long, but I've suggested names before
> which are short and generic, and also suggested that if modules are
> not the only users this needs to go outside of modules and so
> vmalloc_text_huge() or whatever.
> 
> To do this right it begs the question why we don't do that for the
> existing module_alloc(), as the users of this code is well outside of
> modules now. Last time a similar generic name was used all the special
> arch stuff was left to be done by the module code still, but still
> non-modules were still using that allocator. From my perspective the
> right thing to do is to deal with all the arch stuff as well in the
> generic handler, and have the module code *and* the other users which
> use module_alloc() to use that new caller as well.

The key difference between module_alloc() and the new API is that the 
API will return RO+X memory, and the user need text-poke like API to
modify this buffer. Archs that do not support text-poke will not be
able to use the new API. Does this sound like a reasonable design?

> 
>> 2) Add module_free_text_huge();
> 
> Right, we have special handling for how we free this special code for regular
> module_alloc() and so similar considerations would be needed here for
> the huge stuff.
> 
>> 3) Move set_memory_* and fill_ill_insn logic into module_alloc_text_huge()
>> and module_free_text_huge(). 
> 
> Yes, that's a bit hairy now, and so a saner and consistent way to do
> this would be best.

Thanks for these information. I will try to go this direction. 

> 
>> Are these on the right direction? Did I miss anything important?
> 
> I've also hinted before that another way to help here is to have draw
> up a simple lib/test_vmalloc_text.c or something like that which would
> enable a selftest to ensure correctness of this code on different archs
> and maybe even let you do performance analysis using perf [0]. You have
> good reasons to move to the huge allocator and the performance metrics
> are an abstract load, however perf measurements can also give you real
> raw data which you can reproduce and enable others to do similar
> comparisons later.
> 
> The last thing I'd ask is just ensure you Cc folks who have already been in
> these discussions.
> 
> [0] https://lkml.kernel.org/r/Yog+d+oR5TtPp2cs@bombadil.infradead.org

Let me see how we can test it. 

Thanks,
Song

