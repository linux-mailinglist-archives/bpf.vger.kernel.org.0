Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34EC5B693E
	for <lists+bpf@lfdr.de>; Tue, 13 Sep 2022 10:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiIMIMg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Sep 2022 04:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiIMIMe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Sep 2022 04:12:34 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021015.outbound.protection.outlook.com [52.101.57.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250F4E01A
        for <bpf@vger.kernel.org>; Tue, 13 Sep 2022 01:12:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyNW9JhTgVKdepCC/pjiLkN0GSmv7ts7ElDcO0M8H90O/a/gDFj1I8Z0PKx3fccP7fyrvhnMO6Lbsx8sAu74VOfkRjMMgkvBWAuXjuDdG/5WDTq70g539+kSwwYbGRBwTKlM++wdBj2iDb81L3jXESP+s5lrUdDgolJfDuYPN9w8FHXbDqVtm/uTGWuoiieEgaRZy+M2A7sZiytI9G0D4P5t/+E0uXixJKfWg2UKDlwuaXj407pJp7SVQUzJVIPAGFu+HQB4WCAdzXz4v4LjGCabc275B63zE9YW7VjRFnJBo+FKLbmVMJfOawmz8oE0loywOF1Mroe9iyK7pbgIOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfpl06Nx3fgLLk3F7vk7cVwV2wCbN+v4xkiyliJ3810=;
 b=CTEkY6+sXKHseiIZu1LKUKgzj87gHlWYGXDiXFm+38DMmTlXxoKTQXi8TrT5hV/WI4GZ8zqbF1G1ExqOF6j3SoJAPaVMjN/GUj7oXnbWlKRZ3bX7jF+fFBLFUPAZ5P2Lkh1vHGhb9TV4xhNx6OIy+fotMOl3goxgQRx5Rsb5371IuYXyi/YzUu8/Plg7pQEEDOQKzXwGyk0QV0luR5XoNsScATfzn+qNAOTti6O96jrvzAffCgRZDlmXxvXMWyeHOM5HARjyBmk7+RQZ7O1GvguJ5PsQi7GXW3o60hqEJsx4GxcVSVOe3OCR36/9b7VzsvB3CdZ1MhZhvRTwg5xhFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfpl06Nx3fgLLk3F7vk7cVwV2wCbN+v4xkiyliJ3810=;
 b=S55SyrdK3E4sDIJDlv/+tNf0bqpLeu72BnqDWHzBG951AKtl3Vm01Lsm7PX8Fn8RhjAgsvP2leXm9kEWVQ1iBxibBk9aEBev+NnP+gZbK8lEe2ZHB8OwvorUIgMD+2HIE8fp8+DUbn7LNR4dliHjCRHjPVld3jSjHSWX4REEXEc=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 DS7PR21MB3174.namprd21.prod.outlook.com (2603:10b6:8:7a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.4; Tue, 13 Sep 2022 08:12:31 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5872:7dd2:2a86:c111]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5872:7dd2:2a86:c111%7]) with mapi id 15.20.5654.004; Tue, 13 Sep 2022
 08:12:30 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     bpf <bpf@vger.kernel.org>
Subject: FW: ebpf-docs: cross-platform collaboration brainstorming
Thread-Topic: ebpf-docs: cross-platform collaboration brainstorming
Thread-Index: AdjEiCzrBN0wp9x1SICRffi716BB9gCwDrzQ
Date:   Tue, 13 Sep 2022 08:12:30 +0000
Message-ID: <DM4PR21MB344091825EFD6EB66737D590A3479@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <CY5PR21MB3770D72EF2C6D3AC669EE15DA3439@CY5PR21MB3770.namprd21.prod.outlook.com>
In-Reply-To: <CY5PR21MB3770D72EF2C6D3AC669EE15DA3439@CY5PR21MB3770.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=35ffb222-0f87-4400-b615-4bf4e30a1668;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-09T19:51:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|DS7PR21MB3174:EE_
x-ms-office365-filtering-correlation-id: 443fccde-4b0c-4988-c8fd-08da955fb47b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QkJpkoC2gNmvnuyHZdYvIQBa2OOPCeGhbmQ9qKMy24/bGFQyTr7poLoi2D9lFwijcCUVReH4K6GFC87UtHe6pvQZyLTfi5szGPdcn/cXCkGQQMBWiB0X8hFaNqpgX3O9kL1wBFzlT3dyzmMTxyhbs/7M0KxAFRaiML7OW2Q4N30nadbVx+pR+DshMj2/KUeAKZdHcTkPcrTm/vh62+48GPw+RORjO08PBqJVjVM/+Fw0ebaVKpXsWKztdymRuHCisQvcl9ogo9irJH0O1QXexnfBhfvyQoEz/BVL7+Csq8Ncg3lUaPbiR3DJ6HcQmlj+jmVuRyC1spOknpDEZfvSNTBtUu2hn+4mhUSesNpauKFLaQprgUxuj3EIoeRCxxyXoorMpXHX1gJia+ca/1QqUlkp5h87KAn9lwLjaFFdfRQwfQWa14muhqdUuCbS/xRYYBNpXpTeul66jQbEuxYCV2PMQh0CjqN5xeBzCQGMN+oxX3236FSMLogk/u2jglPSPVIi7wWa/qNytefG+Yr7d0P339BkfEIU2uRfO1E8ztOQMugxmCpn0yDs3aTihDlx+uNuP4YOwYZFdYW/YbSqqP9q3pSFLAzm0GBlrNAuNxOZ1O+qdQgdvYBf8F+BDQX3KX8DbmQCYlGaunAxr/N89XIyKthX38f26RyL43/HEm4ZN/OztT+9A/1vCWSCdzo4sCuRHTYAAtGhOnXXK4nKLNwjShMM6T38UznLH82xKQoX4IMbiG8BDiNsJYi2JoA1k933hsd+WLwN8skmYMmI4Bw1/NFM9vrtdR/vdFb1YFeQaibFLa7dQKWKOs5TePAUoJ0pUvjC6Gwi7INayp5957kNEoOlICopafmShIu8990=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199015)(76116006)(38100700002)(966005)(41300700001)(10290500003)(122000001)(66946007)(5660300002)(66446008)(7696005)(83380400001)(33656002)(38070700005)(55016003)(8676002)(316002)(53546011)(71200400001)(52536014)(478600001)(66476007)(2906002)(186003)(6916009)(64756008)(26005)(82950400001)(86362001)(82960400001)(66556008)(6506007)(9686003)(8990500004)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1wN8F8I7yrxRGXH7OGcyhoRE5Xn+UF51EZBzV1bD+gbZEHgXDdPdErRd49?=
 =?iso-8859-1?Q?CE6fs+z56d5f0xmWVhk1eC8Al4FNLcfTtis+CbjL5cqGuyg2O20ByT81JG?=
 =?iso-8859-1?Q?fxCrTBGrNRcVw156aHsRNdS8g37aqSbDjq5p+gtFHvs0rqy9YhB1/Lhk+Y?=
 =?iso-8859-1?Q?ZfRKPof2LkRh+yLxiScsDoYbnryk0Pe2NUn7gqpYWU7Vn1+yVn06KlHO+V?=
 =?iso-8859-1?Q?XB6mhHMnJB73sGZ5QyrSsQrrz7eYHL/CUtOuTIHpTEmymSVR/eFxopDgLl?=
 =?iso-8859-1?Q?xM7O194mYUXwdrKpLJeri3Rc9lCKN5osYnYKevVbrepkIDhM4WtmSi8Jrs?=
 =?iso-8859-1?Q?nrkSD+BmThmFKWNu4c14bFvfyNip0vjHH3YCo1ePsSSVuKB81TNgZo7PsD?=
 =?iso-8859-1?Q?v54PuGxIMJkmSrK5JvZn46YVqd9KX79HYU0i75ImMZ09rn+dSNmBrFRzn2?=
 =?iso-8859-1?Q?pz4LZQk46Hsr0hoN/Wzo8eLd7bfErnOH/dMrzFNvxxdWlA7FsoygckEW/F?=
 =?iso-8859-1?Q?C2sCQtEYjzZ1kSuXSrAFLpLNTTxZPMg/XWcuENmmbeuBc03DBA3eWxsqZO?=
 =?iso-8859-1?Q?E/yx40M3ZwRVF6mHF9WgQZ9oi1WK0ZqUf7EnR9KTkTBmu0MYwcAzQzuyJo?=
 =?iso-8859-1?Q?iqGDqSVrihYXzHKIxSMETG4dKgbx7LzPvYViiuOk+PynwXnwxLEBkD9czu?=
 =?iso-8859-1?Q?WyehkspHiimYX1r4ZuD8aab0C40L99RgC3dQ9jUtMnRdM/dNBOd6FaUVYb?=
 =?iso-8859-1?Q?s6um7y7lL8xHGjlzIhU1RS9QhbO5OnsGPUv9N3UI3R+pFhUo1rBtSoImzr?=
 =?iso-8859-1?Q?eb3cFT7Z90CM6gKDIZ2jIOoCMUtDlePq0ABo5silLrseExFG8HJ7EsGccI?=
 =?iso-8859-1?Q?4GWzR7vV0NRZHv0p+svhG2oA8fe0l2s+g2XOUkg3JUaSoXGPz43SCQp6Qy?=
 =?iso-8859-1?Q?0ygGCR7n1YvzHHRXS1L9guXdfHzDoZAfXyzHvwbsuWDhuiGgOxhUzbnoP2?=
 =?iso-8859-1?Q?YTTgPeG1jOho0x6D1O99cYnjMczZ9PzqQymDrnrPNrhMd8F5IurJZXJ/B/?=
 =?iso-8859-1?Q?2+8AQfHGI3P9W6xRiqj1Y2JsuZtCqbzZrUVIaza28XhuvxsveeIIsmkuHr?=
 =?iso-8859-1?Q?9TQ2tKqO5UlVXIGwropsbb1Q1vRuSih3xRokyvkpBe8XNT7nNAUQO+e+sy?=
 =?iso-8859-1?Q?7Hq7sqtYHFbp+4gPmOiS7gfdy3gvvgHOCuE6CYgDObE7U9qq0I0SuESzWf?=
 =?iso-8859-1?Q?C5ROO73TpLQk1mc2E2pGzrmazHG6Xm7fkX0L9RMrfTYOgCn/PvyW1Waez+?=
 =?iso-8859-1?Q?UW2PR18PmIFmrRUqbUmcNlfFZIOnBmBpKF7GLvNhL9SvE6kYbWr6LL1JV/?=
 =?iso-8859-1?Q?VhSf7mBXvjD/2yHmuR/VgaKTFlG9hSdtFvZsxTBg81E1nZ6JoDZcDde3kR?=
 =?iso-8859-1?Q?fp9rHk5XECF7099IZaVdvYuwHx2FJfqe2mDujvykKNrYI8KVicejV0B8Ox?=
 =?iso-8859-1?Q?I8y+pIbqCbkug9GLyuktWbfeE3lUQ5fs03SNCHRQfV6/DCx1WPCTzNu4p0?=
 =?iso-8859-1?Q?hu6nwEGgtg6T8nA09XaHfCaj0ARfqzCzG7lMjz3HbFsnRScDZVGzqs9M8C?=
 =?iso-8859-1?Q?biehILNI+qNh9gecZUYxTtS7RAl9MrCwZcyW2+KPBzeytAsraIPCsidA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3174
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Resending since the list apparently never got the emails I sent last Friday=
...

From: Dave Thaler=20
Sent: Friday, September 9, 2022 9:15 PM
To: bpf@vger.kernel.org
Subject: ebpf-docs: cross-platform collaboration brainstorming

Last month we had a bpf standardization meeting during the bpf office hours=
 slot.
We can discuss again at LPC, but I wanted to put a few things out on the li=
st for discussion beforehand, to seed discussion.

This email focuses on the cross-platform (not just Linux) collaboration asp=
ect.
I'd like to make it easy for people from multiple ecosystems (Linux, Window=
s, etc.) to be able to collaborate effectively and efficiently.

As Mykola's notes from the meeting summarized:
> Standardization artifacts will be upstreamed in the Linux kernel tree.=20
> Communication will be done over the email using BPF mailing lists.
> Now, the BPF community will look for volunteers to drive the effort.

And we also said the eBPF Foundation should publish a snapshot in PDF forma=
t.

I wanted now to get back to my latest thoughts on how to submit/review patc=
hes,
to start some more brainstorming (but keeping in mind that this list is a p=
rimarily Linux-centric audience, rather than the full audience though we'd =
really like this list to not be Linux-only).

I've heard from Linux kernel folks that creating a github account is too hi=
gh a burden, whereas using the bpf list for patch review is the norm in ebp=
f today.

And I've heard from folks that use github for ebpf projects that "git send-=
email" is a burden (or even apparently incompatible) for people using Excha=
nge two-factor-auth which seems to preclude SMTP as required by git send-em=
ail.

I'm hypothesizing some future solution that would somehow accommodate BOTH =
ways of working, while retaining the main agreements from in the meeting no=
tes.

We already have github mirrors of libbpf and bpftool, so having a mirror of=
 any ebpf-docs is straightforward, which make consumption easy but by itsel=
f doesn't help contribution.=A0=20
We also already have https://github.com/iovisor/bpf-docs in github which is=
 not authoritative or a mirror, but rather a logically separate effort it s=
eems.

So in a hypothetically ideal world, a patch would show up both on the bpf m=
ailing list and as a github PR, where doing either one would result in the =
other happening automatically.=A0 I expect that may be impractical at least=
 in the short term, though I'd love to hear of anyone knows of tools that c=
ould be used to do parts of that.

A possible intermediate workaround might be if (say) 2 folks involved in th=
e standardization effort manually did the mirroring, and then over time tha=
t gets
automated.

Other ideas?

My goal would be to unify the discussion rather than splitting discussion i=
nto two separate places (as arguably is already the case with iovisor/bpf-d=
ocs vs kernel.org docs).

Dave

=A0
