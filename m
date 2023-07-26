Return-Path: <bpf+bounces-5913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C49762E7C
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 09:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E76281A21
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 07:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CCEA924;
	Wed, 26 Jul 2023 07:47:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49844946E;
	Wed, 26 Jul 2023 07:47:18 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2133.outbound.protection.outlook.com [40.107.101.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A15C4EF5;
	Wed, 26 Jul 2023 00:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBqCihgHwKZ0MfwiDxrSQsFXAowZU8NEAfCVzJzPtKBc7l8+aKDvPtSEGKDXj1InXK6QOCfjZ9IpV+eWA2BvoK3tDipRayCnT2wIvN7KO6XP7+dlUa+BaBE9TgpxoyeyG8xQHhnku4QrKOorGb+uwmuPj3DA9YODhmbE/bC4ULvoLm70yoewPm1epatQVmHZo0Ma+qSYyrnKszR5q3Nkp4sT74nespAhVh92jj+X9ege8Nrmhu+1kS3N4CgUYCjXGF63JDfXFyEcL9Kll3Jl7rY/AxcaOLtiurO9NHfsL58gbLsOTNCy5B+PrGIA+MQ/vyuoRwmIrAF5Yz6Ffol5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8VnIfWw59WJDgJvmy58TPN7yVSBhXfyNvaBAjuvo7Q=;
 b=jcBt2fF/2hmi2BFjcmSaEXud3Fa3EaNFnzBJy0C1xv5AFCau/xWdAjAYI2DiibF6vV/uvxiWT+Vs2iKsBnMYtSa1pqccIar1CTolbDZhgsxa6oPZU7iS55qlqO1WVMdr8RgrDujZ4Vkt7IST5kepSHAy3hQf8y2hoDPyts5JGOaj99VnKJhUaTlZOxlsQmA7AWve0gb0Omgl2vHXib/ViR4iBjYeYxeIpszaRU3Ftyu3hJEMKewhuZ8naONvywOnbqTfmGBHVQkQtYA66Xg/koA1y5RPAmJ0kbo6CDCsaYdN8xa5PZsc0CcVNxZO0bKx3POLk/flm8O1zamETlWkCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8VnIfWw59WJDgJvmy58TPN7yVSBhXfyNvaBAjuvo7Q=;
 b=iY80cpGcZWLbM7osx2uhlt7pj6LCXOqHJabNUTMADm7mAaPSNdiX7LeLQTt0aRL0U+qiWIUcTvV/aXeQbfEtu1Vd2iV3KDHJbhoS6eLyXXjG7hWf6LP8rOq97M2mZ62TtSn0ZLP+jWTBEUEP9QIk5HoO2198LPYHG/EcquvytC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH7PR13MB6540.namprd13.prod.outlook.com (2603:10b6:510:2fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 07:47:10 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 07:47:10 +0000
Date: Wed, 26 Jul 2023 09:47:01 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
	toke@kernel.org, willemb@google.com, dsahern@kernel.org,
	magnus.karlsson@intel.com, bjorn@kernel.org,
	maciej.fijalkowski@intel.com, hawk@kernel.org,
	netdev@vger.kernel.org, xdp-hints@xdp-project.net
Subject: Re: [RFC net-next v4 2/8] xsk: add TX timestamp and TX checksum
 offload support
Message-ID: <ZMDPdUIhgzUhrr+v@corigine.com>
References: <20230724235957.1953861-1-sdf@google.com>
 <20230724235957.1953861-3-sdf@google.com>
 <ZMAiYibjYzVTBjEF@corigine.com>
 <ZMAxAmg187DgPCAr@google.com>
 <20230725142811.07f4faa2@kernel.org>
 <ZMBPVqyUb9N8OEWL@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMBPVqyUb9N8OEWL@google.com>
X-ClientProxiedBy: AM8P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::33) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH7PR13MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f47e8a-f65d-4731-b533-08db8dac8459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YJIsdNL1ahGLeIfonCJahFJuMujJoBmIwGRi7MgMpGvEhE5YYEr9j+mS8uiSkVIDfeK17NyQ7dTSPJ/Yp7O99gViJ0NUwUUSiyVGRZkdsw5Doh0y4mlHDbGLybq4L/4isQLBpZbyztbE7DE8mk4fsOBldt32iz4k6KlDXjUnnC9r8voD9B+V8qY73vZ7JuRg1a1MgF+w5wHHJm2GPtZo6fKcdqpl48SM8nNGId/hbyrYiUNhcEn2nYsb+c/7FuOxTXkLk0a8t0qzDLzBHfmdw+CYmUngnKYS+Aip7LJTNO/O6HAzNLgVEsURhmBCtq4gtZQcjjslZX4S23ONXWUZir8z4lRrpz9CNCclzEUf2ppQ5+fTK9v37Pd/y9GVf/yMymwaAXLkmkWAT28muFMjpukE7aeUwD3/q2J/2pIbnLx45GUKmsItNzW1PZRt314RL1xZuVbo2GSzXNGQKKWeZcFAdDvjrZgwW9IH8ao2qDxW6+SgRIOi1PWYUkVNesUR0YuoD/hrrzix46rDm+5thbgA3fGqr1KtmJu5FQxuiJfneU2IxY77JcLs1cUfi7tvi+xVuTocL+I//tPpouWdCAgEmE4qmodsS9H/n0oUMzZG2jDgb3I8HapvXIG98DvQf3vPPt8Pipa7wzUhSDN/qKg6C4FLTlC+D7ZEhR0EGAY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(366004)(376002)(136003)(346002)(396003)(451199021)(36756003)(7416002)(44832011)(86362001)(2906002)(186003)(6506007)(38100700002)(6512007)(6486002)(6666004)(4326008)(66556008)(6916009)(316002)(66476007)(2616005)(8936002)(5660300002)(66946007)(41300700001)(478600001)(8676002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mQcFLO5JGlKPihSa7Sl7mMy9DleZFgBPrvuHfvtrWyqlNBH9GQpFZp+R1dVo?=
 =?us-ascii?Q?k20Tpf91u6ggDp/QrBCDPq3JSoZmp7og4j8zwPzSAO5BVJqBqODfjkxJ9CAC?=
 =?us-ascii?Q?+WarcTl2CRDp5Am9VEh5uvsdM++Ylaiq8N2/2jGP///b6aJbIbzvN+5yzMmK?=
 =?us-ascii?Q?H+xoxD0y3xftW1LSNScd/2DvUYQPTt8XuEWOglA22Kut0YF3ig+d5YCgldAA?=
 =?us-ascii?Q?x9tFxsSPe82N41inlC1tSQ8LfrST1sHRzKI2UizHV+aj6rCxfFhfKHEqzcuy?=
 =?us-ascii?Q?MxvYThlF2/UDdAALInJo5WtKeIfEFjZDIKGbWAdGtOa5GPME37/LvO/GKZR0?=
 =?us-ascii?Q?pVv+40a2B8+80Iu7zjvnQxkSIaF4kCDXks12Kv0E5ELCvuCfs3eYxcWjyp6L?=
 =?us-ascii?Q?2zxAz/Q7jsiVt02o7LD4CCHf0Hl/qDYLyymSl22iC5HHyw/xvL2DBZWD7VSW?=
 =?us-ascii?Q?U7F8kMzmchqZuGpAxTOD4EwtQJPjzggV2zC5P0W67pSBRAtn31FeuaMycowQ?=
 =?us-ascii?Q?JiFAme04XvEgmGOYwwfzudd+IkC22x4UBBONFptKeC2GYptKusa21IF0fz/I?=
 =?us-ascii?Q?IUmsR/tuul+NJCNjtdzfa5PXhXjwYpHHJig8cFDGVJDY+JpHPx+TsZjqhokl?=
 =?us-ascii?Q?fCwmyX5vDWXlr4g06a1zoEXgP0PNPVAfn5f47seHM7hqieccc6tuJyyy0ZOL?=
 =?us-ascii?Q?EbuU9cGRkRtEwMlIWK09sJqFA1KtmviMJKBYn6GzFHAqApAU5LAXXMK4FM9O?=
 =?us-ascii?Q?4C9bTus/+H7f6XXRrRBI1uANMJ27xtvAbkc2fhnwc4QGLOMyyqvYvQK/Su+V?=
 =?us-ascii?Q?xWMLIx08/zhYWHO8l7IE/Fb2xVbNZgtYVAnxrDZU8iafKHHb2CnUFrowktgz?=
 =?us-ascii?Q?Yrs7rQMrnJMXm41rF1qUWPy4v5xnGs8AQ0Y/Nw8KcrlHqVMw9b2k/hJwIWri?=
 =?us-ascii?Q?W/sWaTjthtYPxcnidfhZsX0fgOVnBRys3ZsDW8qvhG7+3mj7yRQmC2lkyc7l?=
 =?us-ascii?Q?1H1mvBNkx6OrJbOz5ewHv48kiYvvgNW1HdlNr3KcMLwdOt1h3SHAwKnLiQ/R?=
 =?us-ascii?Q?mSYAZEmcFgXO2dmK+V72C+H6YUcUgAhjAZNvLCAC2H0QCLr9FOv9LOFMfBQi?=
 =?us-ascii?Q?mVcdiBzKaFU3x+aXjK4fD4ZOUog7BJCM+rAjWnvfP/dsWUyA3G0JjrvBkhbu?=
 =?us-ascii?Q?O0Tw2DgmuW1yRhgbB01ZZxJcVrrHRY/RKHyF5y1eIfx280bGEJYxVlBvhQHq?=
 =?us-ascii?Q?Fia8bxaRoOw4pZy/mHD+VdDKa+rjTZS7uuM7l0/78ES+lHMpf7lkHKzG8C36?=
 =?us-ascii?Q?jRt+tnGU6yUKZ7TiYef2Fce4DU21g/B8JY4AklDNpyMMDI9k6hPl1tcQGB01?=
 =?us-ascii?Q?udLmnfG7QmjPJEYtGUyNBuEVYTyvDC7SBb6OdhFdpmz9zzzmiMOyRgPcPtan?=
 =?us-ascii?Q?Bl1Qm1RocvP9Cb9pt6oXLrgI20iJFWIg1zedRf0zV7vdz+V60Ba3m29Ml3iH?=
 =?us-ascii?Q?TEsrEyNMjQ+2GI9p6nhbTc2icW4CayeK/atN9indzOVPiMbUhemqjWp4p17m?=
 =?us-ascii?Q?ZfmFMg9S2d3q0L8e0ptMblr1Dnff0wwyT3DB71k9SsQxu+YpForgXCS6RSth?=
 =?us-ascii?Q?992fLiB2UlZAsxerjjsVnOKFFlBcBcQ1d5soKbn0xCmL6RJZwe41fENrFjy6?=
 =?us-ascii?Q?7c4saQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f47e8a-f65d-4731-b533-08db8dac8459
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 07:47:09.9803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBr59IXADaqeeJidvzquMw62VROCGpUdL5l43U0rEwN6JCoqbr/tY0Ysz8kkl9JTQAcb9s7UhvEcEOcJYolPj41MsVuP0OjToFsBoKSLnGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6540
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 03:40:22PM -0700, Stanislav Fomichev wrote:
> On 07/25, Jakub Kicinski wrote:
> > On Tue, 25 Jul 2023 13:30:58 -0700 Stanislav Fomichev wrote:
> > > > I know that it isn't the practice in this file.
> > > > but adding the following makes kernel-doc happier
> > > > about NETDEV_XSK_FLAGS_MASK not being documented.
> > > > 
> > > > 	/* private: */  
> > > 
> > > This is autogenerated file :-( But I guess I can try to extend ynl
> > > scripts to put this comment before the mask. Let me look into that...
> > 
> > Yes, please! I think I even wrote a patch for it at some point...
> > but then we realized that enums didn't support /* private: */.
> > Commit e27cb89a22ada4 has added the support, so we can get back
> > to getting the YNL changes in place.
> 
> Let me actually route these separately to you. I'll fix mxdp_zc_max_seg
> thing as well..

Thanks.
I did miss that this is an auto generated file, sorry about that.
But I do think it would be good to resolve this, at some point.

