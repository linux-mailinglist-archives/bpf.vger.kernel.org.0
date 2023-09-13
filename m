Return-Path: <bpf+bounces-9856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 814CD79DF2F
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 06:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FBFB1C20B9C
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 04:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFAC10FF;
	Wed, 13 Sep 2023 04:35:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6323F37F;
	Wed, 13 Sep 2023 04:35:23 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120CBAC;
	Tue, 12 Sep 2023 21:35:22 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CKeso2014882;
	Tue, 12 Sep 2023 21:34:42 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3t2y84sbhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Sep 2023 21:34:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jm8fm/nBozz8gy94V7GeihyptiA0SH7zkDDjFW1w5QAHTKUP8cZU13JSQcusTTExy/DUfUqA9izNnvmVjsTH+GiYpLJi0uPpD8tCLvG7ZhKxwriIEYBaLmRoMG45JPFYehqaz9DfgqFmncgquPS318kRiLZ+kcNfR3cahVaB4jLLDC+ED1a0Ck+uKy9WBtPQz89YL4bnVmFy9hdFgJK7hOswSbhpaAyZ3k205qr9j2pD6oVvJd4gA17dLMVZ98NM5U1wr8lwVOCb9NvvZ0qKj6niontw3s/YuZ8MJiHIyuQIMS42pgkQqYPFiY3HGM6GDvMCb+ituATntYkCp1YT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3M4UvBVgAuxdROamSoeXoX4DDTdryzxb1t6nqy8/7Cc=;
 b=m+B5zkMTzCvwKaWf7Fe3cRLqBZxwmFcD2pmnhyBOIytODfJYdR4gqxyLLIFTEUgnUntU9CBLQnRZc0uuVY4AoPmCOt1v0Z9eB9bGckch1ce/nFxDpegYcPi6RNMG2cgC8zK88qhmXxXaefKtI4AxHsLwBbG538bFnra7qsWB2Vy5VUKYzMf3wHl8eUTOTmafBQvREodFPPDZcDtAyJ7erto7uSyU/TKAJ3iiuS6t8MdeagxGfpVhs7CZj2rLFQL623DgcVKU9Wi7bhD2BJdq/XBhc3tBMymvPZMwQjjKf3TiyQMQQ1RMKFB4OBmb7lenMDMvh/9PKPkthckEB26W2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3M4UvBVgAuxdROamSoeXoX4DDTdryzxb1t6nqy8/7Cc=;
 b=PmOPqM6SN2q+clMvPfR/bu25lb1W2xecvuIeNbc3O+nxYcKUU5Nxo+WupakbOhOBaeXL0pNzZ1BtqP5CAkdEL4LcPM+Q9COr+STpkxxo+DYcYh0M5x6cbf73oxJcjGOyT+fkGUqX/noc6A74cSPgQDxEyGb5JACY1rQKBScepvU=
Received: from DM6PR18MB2602.namprd18.prod.outlook.com (2603:10b6:5:15d::25)
 by BN9PR18MB4330.namprd18.prod.outlook.com (2603:10b6:408:11f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 04:34:27 +0000
Received: from DM6PR18MB2602.namprd18.prod.outlook.com
 ([fe80::a15e:25c6:d41d:3d84]) by DM6PR18MB2602.namprd18.prod.outlook.com
 ([fe80::a15e:25c6:d41d:3d84%4]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 04:34:26 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard
 Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Paolo
 Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Subbaraya
 Sundeep Bhatta <sbhatta@marvell.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXT] [PATCH net 3/4] octeontx2-pf: Do xdp_do_flush() after
 redirects.
Thread-Topic: [EXT] [PATCH net 3/4] octeontx2-pf: Do xdp_do_flush() after
 redirects.
Thread-Index: AQHZ4lx9voMh3WNCg028OP7HrAnuw7AYMMww
Date: Wed, 13 Sep 2023 04:34:26 +0000
Message-ID: 
 <DM6PR18MB26029EDFCE2D69803D7CF3A1CDF0A@DM6PR18MB2602.namprd18.prod.outlook.com>
References: <20230908135748.794163-1-bigeasy@linutronix.de>
 <20230908135748.794163-4-bigeasy@linutronix.de>
In-Reply-To: <20230908135748.794163-4-bigeasy@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ2FrdWxhXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctY2VhYTRmYmItNTFlZS0xMWVlLTk2NzQtNDhhNDcy?=
 =?us-ascii?Q?MGFkNGE3XGFtZS10ZXN0XGNlYWE0ZmJjLTUxZWUtMTFlZS05Njc0LTQ4YTQ3?=
 =?us-ascii?Q?MjBhZDRhN2JvZHkudHh0IiBzej0iNDY3MiIgdD0iMTMzMzkwNTMyNjE5OTA5?=
 =?us-ascii?Q?NjQ2IiBoPSI0bS9LVjhCd25IZHpOVFJxQ0N0aTFXaG5IcXc9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFONFBBQUFP?=
 =?us-ascii?Q?dWpXUisrWFpBZFNyWDJFSlUzSy8xS3RmWVFsVGNyOFpBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFCdUR3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUVCQUFBQTlSZW5Md0NBQVFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBWkFC?=
 =?us-ascii?Q?eUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWRRQnpBSFFBYndCdEFGOEFjQUJs?=
 =?us-ascii?Q?QUhJQWN3QnZBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBBWHdCd0FHZ0Fid0J1QUdVQWJnQjFB?=
 =?us-ascii?Q?RzBBWWdCbEFISUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCakFIVUFj?=
 =?us-ascii?Q?d0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFaQUJoQUhNQWFBQmZBSFlBTUFBeUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01B?=
 =?us-ascii?Q?ZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCckFHVUFlUUIzQUc4QWNnQmtB?=
 =?us-ascii?Q?SE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFHMEFY?=
 =?us-ascii?Q?d0J6QUhNQWJnQmZBRzRBYndCa0FHVUFiQUJwQUcwQWFRQjBBR1VBY2dCZkFI?=
 =?us-ascii?Q?WUFNQUF5QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJqQUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QWN3?=
 =?us-ascii?Q?QndBR0VBWXdCbEFGOEFkZ0F3QURJQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?UUFiQUJ3QUY4QWN3QnJBSGtBY0FCbEFGOEFZd0JvQUdFQWRBQmZBRzBBWlFC?=
 =?us-ascii?Q?ekFITUFZUUJuQUdVQVh3QjJBREFBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWkFCc0FIQUFYd0J6QUd3?=
 =?us-ascii?Q?QVlRQmpBR3NBWHdCakFHZ0FZUUIwQUY4QWJRQmxBSE1BY3dCaEFHY0FaUUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: 
 =?us-ascii?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmtBR3dBY0FCZkFI?=
 =?us-ascii?Q?UUFaUUJoQUcwQWN3QmZBRzhBYmdCbEFHUUFjZ0JwQUhZQVpRQmZBR1lBYVFC?=
 =?us-ascii?Q?c0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUdVQWJRQmhBR2tBYkFCZkFHRUFaQUJrQUhJ?=
 =?us-ascii?Q?QVpRQnpBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUZnQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFiUUJoQUhJQWRnQmxBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhB?=
 =?us-ascii?Q?YmdCaEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhB?=
 =?us-ascii?Q?R3dBWHdCaEFHd0Fid0J1QUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFY?=
 =?us-ascii?Q?d0J5QUdVQWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QVlRQnNBRzhBYmdCbEFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUY4QWNBQnlB?=
 =?us-ascii?Q?RzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFISUFaUUJ6QUhRQWNn?=
 =?us-ascii?Q?QnBBR01BZEFCbEFHUUFYd0JvQUdVQWVBQmpBRzhBWkFCbEFITUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUdFQWNnQnRBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refthree: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlB?=
 =?us-ascii?Q?QUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFad0J2QUc4QVp3QnNB?=
 =?us-ascii?Q?R1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZ?=
 =?us-ascii?Q?UUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBWXdCdkFH?=
 =?us-ascii?Q?UUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJB?=
 =?us-ascii?Q?QmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QmpBRzhBWkFCbEFITUFYd0JrQUdr?=
 =?us-ascii?Q?QVl3QjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFB?=
 =?us-ascii?Q?SUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhBYWdC?=
 =?us-ascii?Q?bEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFRQmtBR1VB?=
 =?us-ascii?Q?YmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUcw?=
 =?us-ascii?Q?QVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFiZ0Jo?=
 =?us-ascii?Q?QUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFBYVFCaEFHd0FY?=
 =?us-ascii?Q?d0J0QUdFQWNnQjJBR1VBYkFCc0FGOEFid0J5QUY4QVlRQnlBRzBBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFB?=
 =?us-ascii?Q?QUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdC?=
 =?us-ascii?Q?dUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRBQnBBR0VB?=
 =?us-ascii?Q?YkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0JuQUc4QWJ3Qm5B?=
 =?us-ascii?Q?R3dBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdV?=
 =?us-ascii?Q?QWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0Jm?=
 =?us-ascii?Q?QUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dCMkFHVUFi?=
 =?us-ascii?Q?QUJzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFB?=
 =?us-ascii?Q?QUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QndBSElB?=
 =?us-ascii?Q?YndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFCekFGOEFjZ0JsQUhNQWRBQnlB?=
 =?us-ascii?Q?R2tBWXdCMEFHVUFaQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3?=
 =?us-ascii?Q?QmhBSElBYlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNl?=
 =?us-ascii?Q?QUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhRQVpRQnlBRzBBYVFCdUFIVUFj?=
 =?us-ascii?Q?d0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJB?=
 =?us-ascii?Q?R1VBYkFCc0FGOEFkd0J2QUhJQVpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFVQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBIi8+PC9tZXRhPg=3D=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR18MB2602:EE_|BN9PR18MB4330:EE_
x-ms-office365-filtering-correlation-id: 91f42abb-14bc-4168-66f5-08dbb412b661
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 dpFlxJcOq7263sshsiu7a+cga3O/snS2Nq+VaREwbuHdKq5f7UzOHYzGvKA/H7kho6gO6GGSjEQeCU/Q51fvSqxWqcG+MDoTdAyTgIhMkuX1gzfRuP8lrSUdP9CLh1gOnM8e386hCD2hMFok8PURKLbSGUuPO274h2zk3n6GtrvxVZOLQwYtHsk8OGsyACkxmP+vk3Z66Hogaq6VoKsloTqYsKr7IPNYtvSZVinJeZ19UBg7vZSsU0Eu4SW3T8+U3wfXLI4a3z2LcP1PXIBakLdgFqnGVekjMXXgxb+hrqvD/KOkvQMyHGlOdrEYK8buX9YpUwtk9Rp0aT2SL+mwAcmpb30NosiWVqjmQWU11Fev6sKBuFhJkYVQBvMEwAaGA7KY2zy3SFD34/6am2d/DJB7X9N5d6FgBq5Wm8J+QMh6OxT1hssTIa2x8SSlqzuRlp18wH9o63rwQ9YFX6BOHNZDp4EtmzN7G/3+TkiuTxxpIEXcpoyNGtHLCqJRzP9nCtwvouDjCjENNyO3VZ+6AgAw4EhxmZtbtnmWl+M22mXpmNWy4h/Uy6fSH86/CUGtEHWF6h1XHx+aHu3fHqP7sZsiebCR3tCJAtU3ehl8Gw4HfcS1nwH6EVtKItWuMJLO
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2602.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(366004)(376002)(1800799009)(451199024)(186009)(478600001)(6506007)(7696005)(53546011)(71200400001)(110136005)(83380400001)(107886003)(2906002)(7416002)(41300700001)(64756008)(66556008)(66946007)(66476007)(66446008)(54906003)(316002)(5660300002)(8676002)(4326008)(8936002)(52536014)(76116006)(86362001)(33656002)(122000001)(38100700002)(38070700005)(9686003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?kMgYpJZMaNS1H1J2fmoVahcpJr4AlvMkNHgMGQASY3xZOZLXicJ3Xkplb1ip?=
 =?us-ascii?Q?PMUwwkpWGBmbx/Cg1yAj0qTkAFmcye5uKozsN7GfqUIzyO9suBkkPeBjKuPA?=
 =?us-ascii?Q?zv0H5VC7gqn/lm4fgLPGWxA+f43loBPAvPRqFYe/2Y0UMXIJ/SFxj1ciwezZ?=
 =?us-ascii?Q?5LWis3tDziwRY/iphaRPtkjxh9mURNP4vPCg264638cAQYil45A22QWBy0L6?=
 =?us-ascii?Q?hF5Z73ZAzrj0RV98T3gG5L1RI8nwN2lTZbbrogYlbgKihb0Ns91anWFNrZ8g?=
 =?us-ascii?Q?NZ8Wq+c9tRLuOKuV2RUiWR5pVFKrjGOxFpXj3Z2wSXTPXLqesbybWQt6v3hE?=
 =?us-ascii?Q?E9PApZbgh37sZtE2Hgww0MDfwIawIlz5ph3xIkj//JTOR5TFBLEttNBiJ5cN?=
 =?us-ascii?Q?UAaZ09UysozraUkpzJM4+IJrxGT5fFm9Q8sruJSOFQYNjReH3nF4lRHbJYlK?=
 =?us-ascii?Q?CF76e0tXlV3vlW35rvu+CqGQEoqWgzE5EDT8AYZRIpZMbngGFjcStut65EXU?=
 =?us-ascii?Q?c5SOvUFJRUHjdueKOefHA9pDzaNxXCsVn+GCh+8AXbU4H/dKRhyNS5QO54UM?=
 =?us-ascii?Q?ZhPEiN1afv8uaIKUz/6yjJrGmPgRab+IxAxcUAzePNdQ811TlYeocwwr+u7E?=
 =?us-ascii?Q?loAu4aecg/ouT9penpuebACtxhS/4eeZLrMbbTGfiJj7c2taZgwMjqMVR/Em?=
 =?us-ascii?Q?fLNTKfKXBSdaaVt4M25HiBPikSb1ZzakBy9c3TQKn6ZVue5zssUduk+HFVve?=
 =?us-ascii?Q?ghiTFkKi53sseykqqDBGy0Rcfs0TnGw0B9HNNKIKYuiVGsDA0XnnWzHAO7US?=
 =?us-ascii?Q?H6XT+AwEdqaAT6ugj+wID6rO7LbL/E59nrncfyHrOGyhbcCeK05d8yboLzW5?=
 =?us-ascii?Q?z5cFUUjyVwueoqk3DTlgnq4xWOtClfJocjv7zDGCLchBtgT0pXPDLY3twCno?=
 =?us-ascii?Q?cCCn/cbaT6HuTSFAKjD4lMzUI0KE4l5gHQR0lGtpaaas70T1FM/FtxIJDYGC?=
 =?us-ascii?Q?ZySrjRPhARbuo18gJQOsBO1vbCRyLnhKrmgLa8WKfSK9szM1BBF9um0RzNb+?=
 =?us-ascii?Q?PA6mvdBOaG7Ey58OtlMvSu14nSSeYRrA26zfCY3HB6q8KKHsHMK4wz/NCof9?=
 =?us-ascii?Q?X9WvR/5uZmn5X19WUMdfvoSWgFHfIBlsGuPNWlNk1n84pI2m6QgizCV/Ztot?=
 =?us-ascii?Q?ng6iXkhc0sV1cn+CVPjLpqqK//eensJlUeAaY81CTu9e2MTpPba6HQs532z9?=
 =?us-ascii?Q?jrP/pXNndsu4Mn1AgjZrJfmncDBFn/k6bQe0b/SyUtaHs08yjay2IIz2JvdD?=
 =?us-ascii?Q?NYSKGsM65sRG2+2HPgYH05C9ecOInsYClK5QY68mhoMuimtIHFHC5lgvv1AC?=
 =?us-ascii?Q?ry/+7STOLF0mDNgq4WfYx9NJJu1X9XjIDjBPri2rqWLTxY7zS6cJv6dRX7sI?=
 =?us-ascii?Q?LR+N3xD3r9DflV9y/R3XFvl12Nk2eV09V5Aun0rIgqUQKR/2UgYwQ0VMFjjS?=
 =?us-ascii?Q?IV2KWh9W2fYn8CXIrj+QyaxYaN7jLN3PTBZNHYePiJLkBVhCSQnlUfU8H0eH?=
 =?us-ascii?Q?hKw8Imq5hSl8J9ydw2FgC+BbKBElWZuXNSIHebjMIHtUIPjv8U+/foPlV4XH?=
 =?us-ascii?Q?g11NixdiJJZlv3ku9iHNTUrWRLDIDE1wvFZVpBHV6Jde?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2602.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f42abb-14bc-4168-66f5-08dbb412b661
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 04:34:26.4971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kOcfEkQliKwu2lHEfKRxG+RSz+PKWN1Tg0p3oxARVCt/a1M4nqOKNYtjeW3boT5RU5ZXYfUSUAGCCH/KVjqxbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4330
X-Proofpoint-GUID: xauridOPnYOPu1i8UKX4pa-be0AeHmhz
X-Proofpoint-ORIG-GUID: xauridOPnYOPu1i8UKX4pa-be0AeHmhz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_24,2023-09-05_01,2023-05-22_02

Thanks for the patch.

ACK.=20

> -----Original Message-----
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Sent: Friday, September 8, 2023 7:28 PM
> To: netdev@vger.kernel.org; bpf@vger.kernel.org
> Cc: David S. Miller <davem@davemloft.net>; Alexei Starovoitov
> <ast@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Jesper
> Dangaard Brouer <hawk@kernel.org>; John Fastabend
> <john.fastabend@gmail.com>; Paolo Abeni <pabeni@redhat.com>; Thomas
> Gleixner <tglx@linutronix.de>; Sebastian Andrzej Siewior
> <bigeasy@linutronix.de>; Geethasowjanya Akula <gakula@marvell.com>;
> Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; Sunil Kovvuri Goutham
> <sgoutham@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> Subject: [EXT] [PATCH net 3/4] octeontx2-pf: Do xdp_do_flush() after
> redirects.
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> xdp_do_flush() should be invoked before leaving the NAPI poll function if
> XDP-redirect has been performed.
>=20
> Invoke xdp_do_flush() before leaving NAPI.
>=20
> Cc: Geetha sowjanya <gakula@marvell.com>
> Cc: Subbaraya Sundeep <sbhatta@marvell.com>
> Cc: Sunil Goutham <sgoutham@marvell.com>
> Cc: hariprasad <hkelam@marvell.com>
> Fixes: 06059a1a9a4a5 ("octeontx2-pf: Add XDP support to netdev PF")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  .../marvell/octeontx2/nic/otx2_txrx.c         | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index e369baf115301..6c02eaa460277 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -29,7 +29,8 @@
>  static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
>  				     struct bpf_prog *prog,
>  				     struct nix_cqe_rx_s *cqe,
> -				     struct otx2_cq_queue *cq);
> +				     struct otx2_cq_queue *cq,
> +				     bool *need_xdp_flush);
>=20
>  static int otx2_nix_cq_op_status(struct otx2_nic *pfvf,
>  				 struct otx2_cq_queue *cq)
> @@ -337,7 +338,7 @@ static bool otx2_check_rcv_errors(struct otx2_nic
> *pfvf,  static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
>  				 struct napi_struct *napi,
>  				 struct otx2_cq_queue *cq,
> -				 struct nix_cqe_rx_s *cqe)
> +				 struct nix_cqe_rx_s *cqe, bool
> *need_xdp_flush)
>  {
>  	struct nix_rx_parse_s *parse =3D &cqe->parse;
>  	struct nix_rx_sg_s *sg =3D &cqe->sg;
> @@ -353,7 +354,7 @@ static void otx2_rcv_pkt_handler(struct otx2_nic
> *pfvf,
>  	}
>=20
>  	if (pfvf->xdp_prog)
> -		if (otx2_xdp_rcv_pkt_handler(pfvf, pfvf->xdp_prog, cqe, cq))
> +		if (otx2_xdp_rcv_pkt_handler(pfvf, pfvf->xdp_prog, cqe, cq,
> +need_xdp_flush))
>  			return;
>=20
>  	skb =3D napi_get_frags(napi);
> @@ -388,6 +389,7 @@ static int otx2_rx_napi_handler(struct otx2_nic *pfvf=
,
>  				struct napi_struct *napi,
>  				struct otx2_cq_queue *cq, int budget)  {
> +	bool need_xdp_flush =3D false;
>  	struct nix_cqe_rx_s *cqe;
>  	int processed_cqe =3D 0;
>=20
> @@ -409,13 +411,15 @@ static int otx2_rx_napi_handler(struct otx2_nic
> *pfvf,
>  		cq->cq_head++;
>  		cq->cq_head &=3D (cq->cqe_cnt - 1);
>=20
> -		otx2_rcv_pkt_handler(pfvf, napi, cq, cqe);
> +		otx2_rcv_pkt_handler(pfvf, napi, cq, cqe, &need_xdp_flush);
>=20
>  		cqe->hdr.cqe_type =3D NIX_XQE_TYPE_INVALID;
>  		cqe->sg.seg_addr =3D 0x00;
>  		processed_cqe++;
>  		cq->pend_cqe--;
>  	}
> +	if (need_xdp_flush)
> +		xdp_do_flush();
>=20
>  	/* Free CQEs to HW */
>  	otx2_write64(pfvf, NIX_LF_CQ_OP_DOOR,
> @@ -1334,7 +1338,8 @@ bool otx2_xdp_sq_append_pkt(struct otx2_nic
> *pfvf, u64 iova, int len, u16 qidx)  static bool
> otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
>  				     struct bpf_prog *prog,
>  				     struct nix_cqe_rx_s *cqe,
> -				     struct otx2_cq_queue *cq)
> +				     struct otx2_cq_queue *cq,
> +				     bool *need_xdp_flush)
>  {
>  	unsigned char *hard_start, *data;
>  	int qidx =3D cq->cq_idx;
> @@ -1371,8 +1376,10 @@ static bool otx2_xdp_rcv_pkt_handler(struct
> otx2_nic *pfvf,
>=20
>  		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
>  				    DMA_FROM_DEVICE);
> -		if (!err)
> +		if (!err) {
> +			*need_xdp_flush =3D true;
>  			return true;
> +		}
>  		put_page(page);
>  		break;
>  	default:
> --
> 2.40.1


