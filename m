Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906B563A77F
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 12:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiK1L7v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 06:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiK1L7t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 06:59:49 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1113186E2;
        Mon, 28 Nov 2022 03:59:48 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASB62ur012752;
        Mon, 28 Nov 2022 03:59:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=nNI5cg7UFjPYLhHb+dpnjButGOjOP0RsEAHayE/RUiQ=;
 b=EYGo27H9e9W4pX6DNsz290cqrtAQiaW+q50b/3BLNDEojV3NkoYl+nokA6hX9NX3lfiv
 u8lT0XUuy9r9+KfwTAQ7BxryqyVT0DWZrl6BOnyYSNLUwbJBgP8RibEY/dEpVK9rpuDc
 pGOpxLhYUy+9luuxOzuHkp8ADLYdVvjBz/yEvlfTtynohXHXKn+uwuD/eLfMupqLS8Mg
 WaDuC3CUinsMZhE3PnvKBCjRfhiepvJC+Ayc6FgzdjIKww3XFKlG76B9fmd6nV95ZjPO
 NVcvwebD5R0s2Ku5R/QfPQFrJkJx8Q0ntEFsBGoWBiTRlruDpOyjXdM+LP2caEq+IgCW QQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m3hcvderr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 03:59:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiYqmgxpax19FQNOPQKDlfGbGa6PsBXlMU4KgfDmaOgQozM2b2GgwGoHVe7rjcQdYaBCvpa5+dQMir/JrghNgMR18CkHlvNp1SRbOGxtNb/z2LNgGUCZypMlWcQWFoKuzwaxf9oCFWAi7MHDnGYqCtImtaYARFZhg2TYhOKrgCV+5n9tmMY0Cj+ULasnoclJkwJN3uvij35VNeZIF4l/trF3eep+kzeUccHHI8ZEYD6UbV/PPXo88+1eHyc0kCoYY5ct04p2SeCDCyVf4OzM9WQf8Ee9RZe9rVBSHVItnNz7lmPP1JMS1/X+kEvGWTn17GJ/tkA7ZrEvp7s8qeofpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNI5cg7UFjPYLhHb+dpnjButGOjOP0RsEAHayE/RUiQ=;
 b=a06LAdFZNDQrw2JcNtZbNW6PTDOfCeFDX5Kww/zFuLy/vDwUv3BPyEIakEO95zzkBt3XahDWT1WCFZkKfAbyujDssuITsU+SJ+UvemnnMgOTp6zqMtnRl1drdkc/3g118cDPHfzpstVl8KkUdIen6+M4jzNAqjg9+s29ggAWwCZcW8q651pGMnHVYp+CYV3jlyArVtaQdghWSSWBNIrvBQz3H9BZejhwayyTohEGCxlg2d9OrDIDs3nOz9l+qfYQ/+U6V2xsuy+IBrWo/Yd0Gp872lt2i4LMaOwKGWU3E+ISrHvmRrHEsZrFuqkixgUjT3vAIkiYPpMR2BkRN/fdfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5191.namprd15.prod.outlook.com (2603:10b6:510:14c::12)
 by BYAPR15MB2728.namprd15.prod.outlook.com (2603:10b6:a03:14c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Mon, 28 Nov
 2022 11:59:37 +0000
Received: from PH0PR15MB5191.namprd15.prod.outlook.com
 ([fe80::d410:da8a:ad1b:a6bc]) by PH0PR15MB5191.namprd15.prod.outlook.com
 ([fe80::d410:da8a:ad1b:a6bc%6]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 11:59:37 +0000
From:   Tomislav Novak <tnovak@meta.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Alexei Starovoitov <ast@kernel.org>, Will Deacon <will@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Samuel Gosselin <sgosselin@fb.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] hw_breakpoint: fix single-stepping when using
 bpf_overflow_handler
Thread-Topic: [PATCH] hw_breakpoint: fix single-stepping when using
 bpf_overflow_handler
Thread-Index: AQHYz4xNSRmGp4l1PUKwAHNo0kfo465AaXSAgBQ5MQA=
Date:   Mon, 28 Nov 2022 11:59:37 +0000
Message-ID: <Y4SiohG4P7nX0GWb@tnovak-mbp.dhcp.thefacebook.com>
References: <20220923203644.2731604-1-tnovak@fb.com>
 <Y3OrsU9M+X2UUcRG@arm.com>
In-Reply-To: <Y3OrsU9M+X2UUcRG@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5191:EE_|BYAPR15MB2728:EE_
x-ms-office365-filtering-correlation-id: 83b82ed9-0e9b-457a-e7df-08dad1380608
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XNfhq7lqHpJro/Wr0IdYn23QhDDUKM3Tku37NOdO5hrV2E3FAeyWHjxHD2GSQIkOgWRZFa5QHIQ48169FwVm+zAyqJJME7D3olTBNoXD25slLwexbNZnOuUsjLHoGrfBGD9wU2hrVxqx6OsYiFA55g7RYaOZsnxlLqUW9SwxjKjC/T8nAPGTbiPrYMbj/Sb4MYI8TijHHvHegfBWzOjPuxm40apoph3ZNEkMsKAaBJutnzitCpAgfm2lKHsbyBFNINWs1W4k5n3QQSqKNWHuSa4AuivSxnmRYEPGddDCVXKHdQ0aNqxdfjo4pnzYRszfq+8rKFH6sh2GjaymYmx1R5wt2ESv2kHNaHXAAoH21IqtqS9Ggag2woo2MrA0k3mZye3D/WWl6/qifpwln1DrA37hhr8G5xPNmHq262G0hLuxGebgeAHg7XBR4geyXJl+ZBa5+PIooknLb3fYGvThttiDhcEpLQG/gCBTxAb0C6jHHucnoY3g0e2ITleV6gD6KgbwrLC/RMADZJpWTNnJJ8gkktyr7lT6ILLUCZL3BJOrkmGGn/X/IY0ch3TmwRd+H97WsW6Q3W7nrxkOLiJfZVrLkCTAt1EfSUtiDeCVs9CT5y1VFQEnFUdqpRoZK2a5qpd/UrY0GrFRu8DWrCkv/bELR2xod5jZ8fQHh/wp18OLtf3GGgxvfVBjReZANhHb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5191.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199015)(86362001)(186003)(66899015)(38100700002)(83380400001)(6486002)(9686003)(26005)(6512007)(41300700001)(6506007)(8936002)(71200400001)(6916009)(478600001)(54906003)(64756008)(66476007)(66946007)(66556008)(66446008)(76116006)(122000001)(38070700005)(2906002)(5660300002)(316002)(91956017)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IE0YoDUALH0zxMPMNcrtecGarXPy6Q2s4uSHAuYswMF//f9EkqQlGPyqa5DK?=
 =?us-ascii?Q?Cxx38qDoFJK8QtmZsNy8Ea5EgzHAmVFUG/6igEXeyrlnnCJmoBfS3wRsLkWC?=
 =?us-ascii?Q?C1qmwLzWkFK+lCcYKLJzFU5D1mAk0gUolX4xDzrQSZISNuqmrnrlJkm4ugvS?=
 =?us-ascii?Q?0Lbkjb6ssrKQpAiwuDW069qlW8Z4+y1sgwxzrY4Brln0nRkANKSQRqU2Sj4x?=
 =?us-ascii?Q?tzrc8iFmWXsfy/Fzal6A3ZJRuWKyyr0NkyeUY3IFf/zK0K6PPHKDMqEHt0hi?=
 =?us-ascii?Q?wi3+MR0Ss9iWxbT3MQPHsBrKaLMhWytR9fg3m+HwzIySGsawmWenZVURPbsu?=
 =?us-ascii?Q?2D+dmIm4hZM83N7JhUYsAyRQLgXE3XpTG0VBFfLcQ4hmuqG1Qu5OMbtpTIpN?=
 =?us-ascii?Q?QwgiEBmNMYf2jtxXnOsdqkNXLiYYCyPWIPLmlrL5CWZCQqizvnznyjyGXLzj?=
 =?us-ascii?Q?09gkz6mJIzK+rfQXJIiPZYYNomUDLzD+wipzNz8U9aTKPIkgePceChCGkBwT?=
 =?us-ascii?Q?YOfOjjMZj+6u1qjMgHP01X/mg/AzQAkS+kxkpyThly6jGkq4uyPFK4i63NLB?=
 =?us-ascii?Q?DIGWO+Vx/awgq6V+gxK6zA9R1hCD4Q9uaM511vbYayOvGn2N+OOfTfxgwiS3?=
 =?us-ascii?Q?W5UDHJH/mXaTM+ChYkwr+SCy9wTHrStrNv7SLf5u05noDYS36NmDF/rQhyBr?=
 =?us-ascii?Q?lBiGyJrg9SpmKJjds8JyKSA6mOXlcmTgcpOQ3F1I/kULkA3Mp+ZEI9yAzAPe?=
 =?us-ascii?Q?SPQVssR4PJchtbJrePA772eLmuRkcwYoKdJnnaV/x042SiEPiJjSWMyIw7N1?=
 =?us-ascii?Q?q2jM9YhIauBzwpU2trw2jFKPcWSlESQYhYqfse6gU8dV82CIxE8FEK4/nfr/?=
 =?us-ascii?Q?O1XqBu+9394GHtVsrU58m+o6xf50syAUQbNs03jaEDkaTVvRIrfoGJW2vBkb?=
 =?us-ascii?Q?raZ4UgBz1yg/WIfu2wtzgPFDnil79mZcHa0WP0enXDfuhCmPqxt6TPpzykUJ?=
 =?us-ascii?Q?kS7jV7Sg4fogc4kDPhGhPfz074WNfH0vHFtUhHhnRPyoNJRgaPKTppjNGIYW?=
 =?us-ascii?Q?6bE2xxCg7ysJPpKDxKWgMqzBRbBEfXvE6om+WrmXNW2UYYoVD+c205vqX5Nu?=
 =?us-ascii?Q?BnDvX3K3zF8NB8WR4T8Zv4f7LvJVcLCWxeCuUsA/2FHbQott/0yK32EuL3o8?=
 =?us-ascii?Q?EHUeuMbjf+QJLygiOU197DRty/aGnPsEtln7+GIFwR3eo0E2rPd0PcCOXcxx?=
 =?us-ascii?Q?tcVJMZhCzCjuwOJYkwp8UBVyVM2fc4rO0iNZtU0agcyI9vlz2pAdzdaFnSnC?=
 =?us-ascii?Q?n6LTYUEPjnHOUeeQq3uA8rQCKF9z3RM09aKvwKl3UHmBCnCQeTnC1IMRQmDI?=
 =?us-ascii?Q?z3Od7WWRSXZe5MGibtV26hEQwNEg59x8qm4ox/eol9NdhyX0IuFB9P/F5okK?=
 =?us-ascii?Q?6z7xlsT6Cbs/Nza3esK1esIuO8n+BizCreNkXJw1THIQnua1fReeP+emebbR?=
 =?us-ascii?Q?QhVhDNH+ViHUtLJE4UGiAs42pFvgj9EBoKv5UzcaZISMaEx0LNtCjDFSSMF8?=
 =?us-ascii?Q?kn5nrW5i578o30P77yH/jSmIs4MyyrxKg6+690rB?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2D2BC5EC79B6F24F8882FA278233C15B@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5191.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b82ed9-0e9b-457a-e7df-08dad1380608
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 11:59:37.5342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2dYGwpxlxXUCnJW7t/sDjLNLoM7EXy4gwC95tL/7vNd7KszF3fR7SsgpR0OOuTmC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2728
X-Proofpoint-GUID: V2a1oqfYX_Sk5xPr_l1TFaw1X0iQOpdJ
X-Proofpoint-ORIG-GUID: V2a1oqfYX_Sk5xPr_l1TFaw1X0iQOpdJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_09,2022-11-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 03:09:37PM +0000, Catalin Marinas wrote:
> > On ARM platforms is_default_overflow_handler() is used to determine if
> > hw_breakpoint code should single-step over the watchpoint trigger or
> > let the custom handler deal with it.
> > 
> > Attaching a BPF program to a watchpoint replaces the handler with
> > bpf_overflow_handler, which isn't recognized as a default handler so we
> > never step over the instruction triggering the data abort exception (the
> > watchpoint keeps firing):
> > 
> >   # bpftrace -e 'watchpoint:0x10000000:4:w { printf("hit\n"); }' ./wp_test
> >   Attaching 1 probe...
> >   hit
> >   hit
> >   hit
> >   [...]
> > 
> > (wp_test performs a single 4-byte store to address 0x10000000)
> > 
> > This patch replaces the check with uses_default_overflow_handler(), which
> > accounts for the bpf_overflow_handler() case by also testing if the handler
> > invokes one of the perf_event_output functions via orig_default_handler.
> > 
> > Signed-off-by: Tomislav Novak <tnovak@fb.com>
> > Tested-by: Samuel Gosselin <sgosselin@fb.com> # arm64
> > ---
> >  arch/arm/kernel/hw_breakpoint.c   |  8 ++++----
> >  arch/arm64/kernel/hw_breakpoint.c |  4 ++--
> >  include/linux/perf_event.h        | 22 +++++++++++++++++++---
> >  3 files changed, 25 insertions(+), 9 deletions(-)
> 
> It looks like this slipped through the cracks. I'm fine with the patch
> but could you split the arm and arm64 parts in separate patches? Unless
> rmk acks it and we can take the patch through the arm64 (or perf) tree.

Thanks for reviewing!

Given the changes in the arch-independent perf_event.h, I think merging it
as a single commit may be easiest (assuming rmk acks it).

Alternatively I could move arm changes into a separate patch, keeping arm64
and perf_event.h in this one (possibly splitting out the latter into its own
commit). One that's merged, the arm patch could be submitted to linux-arm.
What would you prefer?

-- 
T.
