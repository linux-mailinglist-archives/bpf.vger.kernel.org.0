Return-Path: <bpf+bounces-12079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AD57C78E1
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 23:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D267CB20817
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 21:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93A93F4DD;
	Thu, 12 Oct 2023 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riverbed.com header.i=@riverbed.com header.b="NZD8YIot"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE2B3E476
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 21:58:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D88C9
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 14:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aP7dokLH1Govsu2tzuFVIfcBhGGDVtEI/wbD7fYwFrpojRtsm+d2ICG1wJZ6Dt96ww0yL5f/l8jyDDx8kWP0mm8+2MJOAYkvDzk6Xt2j5hOvqfBKc7AEgknifarA7swgoMk3XhZf5RvqIvw6kffGQAB5404KFEFI0BTLLV9CkirHV/1mxsBWpusS1TLkFTheAd5QwaS/s4/1coxgudHgCHg/e//O6AoKn2I01qF6A10rCyuJjZFQra2MABjxCSrx3zsrYyyEqt1NNb8eXXUYT6w5ecBawKo3LVWER6C4Vkyo4twO+FPESYVICvErFg9/goe6zX/LhuU4CeiIrASDoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5ny/CI2wSR+uBYWR6qdF1MXhUhc+/lVjB4JJrIXPvc=;
 b=U5TwK66J0dOuOONIcHbAqND/9MWldTgFj06cSG2JweaN2V+pelr+yUNuP1u4KBoRy0pLCDvLrmL36NOGJQ0qMSAjs+edPeEPIjYIDgSz7u+auurba5v9vYRpmsiDxOo/UBwhOYAxAEIGSgnKjqfxfyAAbJyaOZPpuGsdYOzBoEJfnWE/NrXGq72RRq7ErqF1Y4f4o5OlwZ0BYbICtLuLm7ZTQlnDpglLGxj9FDhhxTdDs2YY7mumPT22zpejm6stQraizaTvkhSYkrgQ+E9Ik/FbJX/mkCnOtPFIKIO3pCStGveJWKO9yUJ6OTTraf9ilblNQuCOQtcHSg9VbjgmYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=riverbed.com; dmarc=pass action=none header.from=riverbed.com;
 dkim=pass header.d=riverbed.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riverbed.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5ny/CI2wSR+uBYWR6qdF1MXhUhc+/lVjB4JJrIXPvc=;
 b=NZD8YIotNizbMvlSu57ackaWGnU3/RPbjKHkU/+jUivXNobCbNmqNL+tw1/QiGkSoYEoyugn+2TnT+DbK12Pz9aeagQcapsBrbcp841aukqqfXKDcUho/ExuN1DcmZdQMFYvczA89bvYbDDdPRK0PNmwg1ccrU8H4sM5i73G4nQ=
Received: from SJ0PR08MB7702.namprd08.prod.outlook.com (2603:10b6:a03:3d3::8)
 by CH3PR08MB9208.namprd08.prod.outlook.com (2603:10b6:610:1cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 21:58:19 +0000
Received: from SJ0PR08MB7702.namprd08.prod.outlook.com
 ([fe80::27fd:4257:7ffa:8435]) by SJ0PR08MB7702.namprd08.prod.outlook.com
 ([fe80::27fd:4257:7ffa:8435%5]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 21:58:19 +0000
From: Gianluca Varenni <Gianluca.Varenni@riverbed.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: License for include/uapi/linux/bpf.h
Thread-Topic: License for include/uapi/linux/bpf.h
Thread-Index: Adn9VuAxeJDeHbZESei0CQgq6eMfyA==
Date: Thu, 12 Oct 2023 21:58:19 +0000
Message-ID:
 <SJ0PR08MB77029C75234C301E369D277CF1D3A@SJ0PR08MB7702.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=riverbed.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR08MB7702:EE_|CH3PR08MB9208:EE_
x-ms-office365-filtering-correlation-id: 3ac690bf-fd55-4a9f-ff9a-08dbcb6e5885
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dOWLrdYQr3S6NQlEb3pUpolCNeqYgDWkXBHVzkBQsmwmuOTi+8rimgs26obBpTMcC3VnkO/KdDOQ0qJsa43aBTGF72b83ufuGR4Y8M9HvMEeSidvbEutVmg1R+JKVMRRS3WPsvvBfp9M7eYy46mKNKvrnojM6gkO0wL2rvyGnIFzqNQiVCTJuFAuBeguEsZQ5jvVJhmz3PeGR4Kkwwy8B7Dgjf+nKL7wri8S2h07YHLcNtyLhvlinLGQ2x9j9L37I6k1bIOt5+GTo2aqNSN8EqvqQQTuXuM1oTMB5CGKO9zPpiTPYY0w83XhCDZI3PoQSQiECOkgbX0m9ssVr8qJBCAVP8sQHhCVR3u849PiAFNJOkj9McrhiNQTy+7m5/m8Y9EKSsT1TG4LHXcATB5ZpoQzje4JE0evJIg83G6y/tf26J8zZZ6aagoPNz0hQSjEDpBSRg9G4hac3SqDA2UjRV48D4HY/LfXMWmgYljhBU2QkPb2lkfrnMbiKaHEi3knaNj6ywoLfFRmLg7vVCQu+OzIGOXPBXWEJN/ggxfW5JYggXcx57RIAQk2U+adkU9Hx5GVkNFLy+AS46lydpHJ6EfVmWRY3uD8Km139wi3CqSokahv2aHG3xOFA8/He+/Z
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR08MB7702.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(33656002)(5660300002)(86362001)(8676002)(52536014)(8936002)(41300700001)(4744005)(2906002)(55016003)(966005)(71200400001)(9686003)(7696005)(122000001)(478600001)(26005)(6506007)(66556008)(64756008)(66476007)(66946007)(66446008)(76116006)(38100700002)(316002)(6916009)(38070700005)(2004002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KMO+ZqmPREs643aiMGz9zHLpkae6qPHYAdo6XBcvUi+drkjg92OKsScPWe?=
 =?iso-8859-1?Q?51dtFXU4tKqjX9wDNq0G5QnQ9Hmy7d1GmnEGZWCkvR5swNySrrCJKxd/IL?=
 =?iso-8859-1?Q?90bDDMG2vgGQDQLGcsA8/BG207yUzHf03tjK2UC1T7ouJgY0s9JOBCamp3?=
 =?iso-8859-1?Q?t1ejBJwwKCDdk+KBraWWveRPkIDUa6Z+VuNXt7QNLkXd2dfds4lyqpOjFi?=
 =?iso-8859-1?Q?jRCQSg3AoLsiTknbpJ4Y37tGH418NS01y3aMkaE7TIfzi75/NCazbDM7FQ?=
 =?iso-8859-1?Q?P6YqpzN/215DihwdpePVsOc8X2hWIYGBcgXtZUgUut4zK3kpg1M52ORS9Y?=
 =?iso-8859-1?Q?jqj1Jr3E0T3L+7zCCZvaQxqHE3D61Qg+9DTMJNReji8XgceyFKEFfeXaW8?=
 =?iso-8859-1?Q?/eQcyjBccJSQrIqelNTKH2H+g+BiX5NU3Up1M7C5NJ/JDlbUyd6hcB4uKb?=
 =?iso-8859-1?Q?7MWqb2bhcHuDOz5QiRfzq2mqkk3SMKz2vraDzZHflUZfc4u5/xStWy1alf?=
 =?iso-8859-1?Q?+bX3nPzRFEoSyJedZuhL/GN0I57Jrw9Vlae9GssImYWwLA4nQP2+yRuJrC?=
 =?iso-8859-1?Q?VYoZr0UaHHsEDvBUtdjsvt1YilYGcpqbEmm1cqEQF3vDf2oL33VzuXdq+X?=
 =?iso-8859-1?Q?JX6UL4ZwvnzHYsgns+uhP5Eu71BSixX19mOEwZe73iozOePQ8/c0J7NXu0?=
 =?iso-8859-1?Q?HMJkeztBjT08OEn6u1ia/L0iLrA5FMET0Q3Ukt6yaTH29Mga4eVJox2dQv?=
 =?iso-8859-1?Q?tCxwB5CqxfLDpn9ZpJxT3h5qORUzKhnHyLXnQymv9kxMnTDMWhRphSkfxX?=
 =?iso-8859-1?Q?8rO9DaW7IPG2hjbr8h7X/S8MXlANJ7CPdVcOKXSaQNcxSBI75EmkxCPDj+?=
 =?iso-8859-1?Q?KFvgAC09V/T97RiQSms8nOHOszDvg2tLQpl1en0ZvqVar/Q8fLywG7q6N8?=
 =?iso-8859-1?Q?fSuRe2hgjKusrOEcYtj+hvaeTEXyLD4O9xS5GCK/sSunIJZUDo7ep9WBcv?=
 =?iso-8859-1?Q?0ollh/JT8cGU83aG3ECiNhWGg/lL36Gb1IjQxJh7DbWm7gyktsHAZUNv4l?=
 =?iso-8859-1?Q?Y8S9t7I+blk13pDR3iNkE24h1UUOwo2GCawNXZHyuM80TFPLKUdB/l6vJp?=
 =?iso-8859-1?Q?/dImHF88KDwwYFVNFxMZT/HunLqcoBB/6mEUUuzcnCOj8JaQCoXbsNNnVz?=
 =?iso-8859-1?Q?rrg34cdgWbJrqnhcJvUaKrIEuSnWjh6m6tghn0GlfU2ADgCEE/36TdgBSz?=
 =?iso-8859-1?Q?pXKiIxq3XB4GCaqnPaRsRTOhFydDlSKmgm/niQG69A8FvFyKvN1xp7HeUa?=
 =?iso-8859-1?Q?l6cp2bSe1Ni0Ri6oTI3tN0EvNMnZp9qhFzeLmhdO2cZ6CEzP2yoP1y7uXM?=
 =?iso-8859-1?Q?HyqwOIMwv86Hq3Yln279cKKE2FgqjNLmaRS45IdpFPzNQwZJRoOrfGsbct?=
 =?iso-8859-1?Q?FA6tTh44wh0YakGMs31GNvrCPfS45i77lE1P1gPjXc4uN2lO2R7sfHeFjy?=
 =?iso-8859-1?Q?2MdjU3x541x/qeGfy/6AuZob8wdYbNpHXugMkESmM8JQOsOyloHF96mmsV?=
 =?iso-8859-1?Q?fOXKjgFYjOd1mTYn1ZHtXaFFu8YnkM0mTUC7Buqk1S3/xidniC+3BtRfs4?=
 =?iso-8859-1?Q?vB2jCWM78xzsaixbwHKN4Xd8ovCWBa6fOx?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: riverbed.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR08MB7702.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac690bf-fd55-4a9f-ff9a-08dbcb6e5885
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 21:58:19.4775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2526ba82-27d5-4ea6-9000-8800cc349da4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /K4wH6HRLIZO8CPOri48B5zajuCUkAp6533TA3EaHCZLFuXnsGmhoBb1QTmJ/YW0py1ALAzi8hX+Wdhd5wRqdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR08MB9208
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi.

I was redirected to the kernel mailing lists from the libbpf project group.

The file=A0https://github.com/libbpf/libbpf/blob/v1.2.0/include/uapi/linux/=
bpf.h, which is a copy of

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/inc=
lude/uapi/linux/bpf.h?h=3Dv6.6-rc5
=A0seems to have some conflicting license information

/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
/* Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of version 2 of the GNU General Public
 * License as published by the Free Software Foundation.
 */

The first line says that it's GPL-2.0 with linux-syscall-note, but the foll=
owing lines are the GPL 2 license, without the syscall note.

Which license applies to this file?

Thanks in advance
GV


