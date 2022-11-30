Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF8563D538
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 13:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiK3MIh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 07:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiK3MIf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 07:08:35 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82A01EECF;
        Wed, 30 Nov 2022 04:08:09 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AUAKop2027405;
        Wed, 30 Nov 2022 04:08:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=7xJD/cejjWxC5vbuDPxPZsic/EGS8IpYIXahGFDby50=;
 b=E5hGyJ/F9jhSkxHh3B9AaXANZovUVrdLMdcxZk4WXzgW4C1zkPIvjNaMvC+keuvQMvjA
 /ifvnoUc7BDEkw7OYDDmHslIsIKVAH/P0S2uvr4nKBRHQ06ZLQ9P7TCEAePeOpWqa2Fw
 bqxc9f4vTGL7eyQDZ/2GksRyfhAN/TRzS1IbtIVcGUX/Bu1Y8ZBNZUsKKilWjxZnqgsK
 SNoRFXrKqfOT4vuOPYO6cfLjhTeUQs4Ez0aL6TwBO0ETEJVRdj8Behj7zGdH6+FzOk4Y
 jW0DKZxguxyorhgNJ4G3chCJ4g0MAyeKSGSbUzSN1tcxUgJWOT4pScrqvsRBxpgbxkNo 1g== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m65bcgrux-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 04:08:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRtP9KQB28CuB4+pXV2bTzNY054sLMkaSVrj1X3Tq82UIaNMdGIIzfEaSAlRWPRQX4NcAPSvvrrJkeDf6cE7q+qTewGHT8K0ODHiqgbxy9KEwoXwEbnNUTjPSnFKeIl64UnViURe4vbwIQEaTkWj3kLYzxKHalX2hYB6TPJ8Hk4Iqm3BFkbWZdDcU0IspmfPp8smxBBIbEJjDfiIgSfR9+Pi/A+yWGl4bRJ7ooUm7+2pWCWEPFBWWH0K+J//ol/3zsZpuWEk6bkgazrdXZr4paC5n313vJQ1e2o1DnJJcm0L+A6+rLkhkakS5lVrvOcE7UR0+325pKFuoJ5vMbY9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xJD/cejjWxC5vbuDPxPZsic/EGS8IpYIXahGFDby50=;
 b=JSnet/4cByS53NJIeePfyHmQaWLpCaIHvUyd8xXMF02XYjN/Z8k+Swbq15swD8lQGq439ljVH5rEcIK2egMwHvEKj4bkq4bhQ27eCWC9jQPW2OHi22ZX27gnytvu9Doxcwnyag9Y9qzkd84nQvCsLfLbLZk7YZLfFCFZruquxf0Dh2Jc48CTAghCtZMjnPuSeCYnKLQdrEPK8U6IbQrGRGHoKRN8/i+coZapl2EWJ0OpyTZVl/6mpfRb4pud6lInoTdVbKyVzEZnsnJ8mst5VaR/v1L0t+KKW8HIpKZugL8P3C12ttIDlF+78eD271EJxg9dyoXizJdFSs0e4de9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5191.namprd15.prod.outlook.com (2603:10b6:510:14c::12)
 by MWHPR15MB1711.namprd15.prod.outlook.com (2603:10b6:301:4d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Wed, 30 Nov
 2022 12:08:05 +0000
Received: from PH0PR15MB5191.namprd15.prod.outlook.com
 ([fe80::d410:da8a:ad1b:a6bc]) by PH0PR15MB5191.namprd15.prod.outlook.com
 ([fe80::d410:da8a:ad1b:a6bc%7]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 12:08:05 +0000
From:   Tomislav Novak <tnovak@meta.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Alexei Starovoitov <ast@kernel.org>, Will Deacon <will@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] hw_breakpoint: fix single-stepping when using
 bpf_overflow_handler
Thread-Topic: [PATCH] hw_breakpoint: fix single-stepping when using
 bpf_overflow_handler
Thread-Index: AQHYz4xNSRmGp4l1PUKwAHNo0kfo465AaXSAgBQ5MQCAAxHJAIAAFUKA
Date:   Wed, 30 Nov 2022 12:08:05 +0000
Message-ID: <Y4dHocXjElVzTOms@tnovak-mbp.dhcp.thefacebook.com>
References: <20220923203644.2731604-1-tnovak@fb.com>
 <Y3OrsU9M+X2UUcRG@arm.com> <Y4SiohG4P7nX0GWb@tnovak-mbp.dhcp.thefacebook.com>
 <Y4c1zOZYi3sCxzo9@arm.com>
In-Reply-To: <Y4c1zOZYi3sCxzo9@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5191:EE_|MWHPR15MB1711:EE_
x-ms-office365-filtering-correlation-id: 15739534-1f9d-4ce3-d296-08dad2cb89a3
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T0Idj9HwulHjORUiT0L5gtOvwNeJAOaI+sWQ+3N6djZ1myPwjOFHOVvrTYmo7vAcPaP0I6FElC5eyT6YsLa0hj+W/bvxPSXnJUfz6rWv1FpkY/hEWejsyhApOHuwMUbEX0xUPYKf82FwRBCjsOSGJqDM0ZJWa8fChbwqG6wi8JNpqv+CIeYaiKoLInItGoeVquipGOj5uxtoBCEQKTzwp20XR9hftDoc1TDVfRar35+BD4TfFWhXwM+DHkGt2vzr/Wgb4qLequfgJp3mnP6MJCld95kpVKfcxuOIsYV9iollmJ1zJO9s9YE85wSq/ztbnrPe7osXXfVZHjYCFuwUPDpNUZFGGlFY1Wcr1eeIcgDeLSosUc2d/WsNfwgqvIWkOAzE2973xsfpHHuX5nN+SzLcCryM/BMkUQ2ucSe0Ljy/OtoOoTA6ox1j1+VlOh7tbSFWTtiEpN36NMXgTyGzrpJ2zF0ONQqUxrCR+yux13foraSIdL7QhtznmKaevZMGcUpAgNWCH0B2nvfAGZPDbjrjVY8sU4ewyWYdy8dtvbmMOyuIzNE0z8FFzzAkrbyraJyn1Uw2rB6a6F/zHXbZ3fP+X9BdRlO6QZyGY6UO9n+hA6ljnLkKRRIPq69z1PfBJwxjJ2XgwEXd7fX7Pp1/R9rzrZfkS0HlAbpXwyrCxTNeQo6ytXmGLGOLcnjMNtiH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5191.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(26005)(316002)(122000001)(9686003)(86362001)(71200400001)(54906003)(6916009)(6506007)(38100700002)(6512007)(83380400001)(2906002)(66446008)(4326008)(8676002)(64756008)(66556008)(76116006)(91956017)(66476007)(5660300002)(8936002)(66946007)(41300700001)(186003)(66899015)(6486002)(478600001)(38070700005)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0hvGsWffbitqHW7L6ypV7mBJVIKtp5jrwa3kkVeDiLtWI/r2Is68cSDXJUIQ?=
 =?us-ascii?Q?QN9LyCnUrVvja8zho9qmSxL7KnDiMOvggpCmckl1MLRqRpG04+oslYi4uYyi?=
 =?us-ascii?Q?N1iDxgz728j0mY8vrQZVLkAXnLYZUybBbDdC58TzLUf9EO4SrIG3Eu+23sYo?=
 =?us-ascii?Q?aPho3+pF3AbScEmITFp3BPbwBQ37ftB282fobixwOLfJ6ysdGH/llcjjHP1e?=
 =?us-ascii?Q?AAlZdBYoZHsUxWGD8rL6OxUasrNgy9eJ7v+OrTzlbRgJ5ZHfNolp4C1UAqdF?=
 =?us-ascii?Q?sao6eyqqL47qIy+nVYn19JzpixQNkeOhQuBLD+2+eta93f7Y5K0d8ULZDQwf?=
 =?us-ascii?Q?3dks2FLB3yzuvHVZfZjvOSXIwO8IJh1YIXCgpYC4YmmGkEC80tmOf3ZvJmjx?=
 =?us-ascii?Q?PCQzGqdPlGWvl8YfnEWiodavIxCKWwY2q7mLLvVLTWw5Fen+madpWjySkK+c?=
 =?us-ascii?Q?lAQLA3JWquMfShm5Ail8R42yFySyU7E0OOiv/RurRC/u5M73SJiKwBz2QXkj?=
 =?us-ascii?Q?8jMSgLmIXbomd3wj9y8+EqnoV4bs04n/4n6LM8teCrqeVETKrhUzL/gnlUhg?=
 =?us-ascii?Q?46aUB9YCxViNPgQVUpUL7EZFVSb5hZyrXjNtyW+F31PLIRAKfuBv9wew+p+A?=
 =?us-ascii?Q?NmiSGbf3gi9EqiWlN/n43/Ck9PDU5q18sn5BIOdtB19DjLHnldoAInj6G011?=
 =?us-ascii?Q?UPZ54D5vzMUmS+SkEG1ZFjsehyIXN3MMeBdoJBPywB68HGNMYvDfvXv1OcX2?=
 =?us-ascii?Q?q4AAU+dqmdQnVcX4He+DIgMrP6vrSlgAFlhrGO7Y9bhvGChXn91EB0CoqWmU?=
 =?us-ascii?Q?APHROT/0ugYo7lM1IHGG+LEJiC00MF6ROyG21vYKztOf37PxWdbR1LVuNKWP?=
 =?us-ascii?Q?3BTY0dOblQMIjJJANWFU1d/qaa1o7pzStAlbE+B3FZWapNMDoeqCVsc6EOWR?=
 =?us-ascii?Q?xNEiJ1Rluri5KtPLcKwRZknQjOArBrtPRJKoTGyf2XmrJRQZ/t3KW4dl/Mdw?=
 =?us-ascii?Q?u/t2ZSTqNuq+DtSQfja8YIN7SWHzbWZxx7vx0guUXLNjJlnGROxyHLF38VfT?=
 =?us-ascii?Q?QgxPc7sHZ205cA00Chxnhl5hSEOvfrvIQGlzOfAtOOEcS210NS1Upp2TcsqD?=
 =?us-ascii?Q?BUjFKflTmSsw5rR7yVaZ16RVwSACFXMdyzyfa2/ShdejiYcwEK5G0tqTlfEa?=
 =?us-ascii?Q?NrMbOuRuoxc1LM3DJmwYcQTqRf7eHBWIL++hc+rzqWeMi+YFQFj58XYvJjd+?=
 =?us-ascii?Q?CJ3tUEbxvbAZICzSfQqXJIR5UQzJaZEmKkLA8hby3TkEA0iFxcZ/GN/EV33/?=
 =?us-ascii?Q?nzzlwReLjTrIKSgJ0dcCIwP7SGHj8i2xbmGykVkksS4VftpyLJr39Bxlj5E1?=
 =?us-ascii?Q?d7dgwBFXB/VPDWivP9mc47qLgpOfsUQTTj6NWznyxLQNU3nK3Y32NIZ+Whfl?=
 =?us-ascii?Q?YXifcIFQpxSUpyKwtVftL2ElRFz/g1LwOYiBsQUcYD+Ugg5JPXY0JpNsSzjA?=
 =?us-ascii?Q?NkRazafgbqb+ZQSawmGbspDlTzre8SjfpG4wanDxlxad1SLKqo4Vrlfd3MzK?=
 =?us-ascii?Q?vVO9/t+et7Mm1b/4whR0DbdsKZw4AeVWs9F168Q1?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <769DAE826B69074EA165DF465CAE5966@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5191.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15739534-1f9d-4ce3-d296-08dad2cb89a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 12:08:05.5130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fbtDyFeYS4Movh6RiHPfd7ExHW3FtGIP7YYyt/7yaU1XL5L8YblggYYaVI0obIC6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1711
X-Proofpoint-GUID: bq5bkCpqx1EOFG2oTVxqTN2pJW0YiPW5
X-Proofpoint-ORIG-GUID: bq5bkCpqx1EOFG2oTVxqTN2pJW0YiPW5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-30_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 30, 2022 at 10:51:56AM +0000, Catalin Marinas wrote:
> On Mon, Nov 28, 2022 at 11:59:37AM +0000, Tomislav Novak wrote:
> > On Tue, Nov 15, 2022 at 03:09:37PM +0000, Catalin Marinas wrote:
> > > > On ARM platforms is_default_overflow_handler() is used to determine if
> > > > hw_breakpoint code should single-step over the watchpoint trigger or
> > > > let the custom handler deal with it.
> > > > 
> > > > Attaching a BPF program to a watchpoint replaces the handler with
> > > > bpf_overflow_handler, which isn't recognized as a default handler so we
> > > > never step over the instruction triggering the data abort exception (the
> > > > watchpoint keeps firing):
> > > > 
> > > >   # bpftrace -e 'watchpoint:0x10000000:4:w { printf("hit\n"); }' ./wp_test
> > > >   Attaching 1 probe...
> > > >   hit
> > > >   hit
> > > >   hit
> > > >   [...]
> > > > 
> > > > (wp_test performs a single 4-byte store to address 0x10000000)
> > > > 
> > > > This patch replaces the check with uses_default_overflow_handler(), which
> > > > accounts for the bpf_overflow_handler() case by also testing if the handler
> > > > invokes one of the perf_event_output functions via orig_default_handler.
> > > > 
> > > > Signed-off-by: Tomislav Novak <tnovak@fb.com>
> > > > Tested-by: Samuel Gosselin <sgosselin@fb.com> # arm64
> > > > ---
> > > >  arch/arm/kernel/hw_breakpoint.c   |  8 ++++----
> > > >  arch/arm64/kernel/hw_breakpoint.c |  4 ++--
> > > >  include/linux/perf_event.h        | 22 +++++++++++++++++++---
> > > >  3 files changed, 25 insertions(+), 9 deletions(-)
> > > 
> > > It looks like this slipped through the cracks. I'm fine with the patch
> > > but could you split the arm and arm64 parts in separate patches? Unless
> > > rmk acks it and we can take the patch through the arm64 (or perf) tree.
> > 
> > Thanks for reviewing!
> > 
> > Given the changes in the arch-independent perf_event.h, I think merging it
> > as a single commit may be easiest (assuming rmk acks it).
> > 
> > Alternatively I could move arm changes into a separate patch, keeping arm64
> > and perf_event.h in this one (possibly splitting out the latter into its own
> > commit). One that's merged, the arm patch could be submitted to linux-arm.
> > What would you prefer?
> 
> Actually, arch/arm*/kernel/hw_breakpoint.c come under the ARM PMU
> profiling, so no need to split the patch. It may need an ack from the
> generic perf maintainers for include/linux/perf.h.

Good point! I realized I've neglected to CC perf_event maintainers (sorry!),
doing so now.

-- 
T.
