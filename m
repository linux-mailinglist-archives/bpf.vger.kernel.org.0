Return-Path: <bpf+bounces-14791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FDD7E823A
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 20:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08CF1F20EF7
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 19:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6DA3AC24;
	Fri, 10 Nov 2023 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="uyQUkJ98"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752E63A27F;
	Fri, 10 Nov 2023 19:07:34 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2043.outbound.protection.outlook.com [40.92.89.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF152EF38;
	Fri, 10 Nov 2023 11:07:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QABjSKEfKCbKTcFgvIX9Hyg/EdYwWeo+YNnxd/b0gEohN/ZRwL/DBa7hLPt4+tfrmE69/EoyoiUoQxHlyFGoMm4hxJ13C4Aa2e70n/eTVybJHESWrPQMm2uhDsJ5bCSU9VmBTMQTzkkvtflrIKIW6jQjMPbTuNpdz/ALXvM0OyFHmMSjC5wTJhYyeCAF8zCR8wvXnjoLZbT2wVTXn0vN92DT3+KSP5YAM/4KQNIDW0Vmkr+2OsMwDumx4A912ujc75/O7/GRggytquGgFwdIxUVrGUnN0gl0OvrM1hsdJm3qU4iJ9o2MV28cyXex8CPYRxgVfjpJZUdgcxgXGDxH5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92E9ItfYieonP35ZSDNlZ5zXLpNStjSEh2Ht2aJ77GM=;
 b=BAkxdEM22XE4geaTnu7fdDPXq+UZyWmILXBsmhQYhEl4MC84FsJl+kXt/9P2KZUF7sGNdQe5g5PZKRYYZE7RohbSjguXHLXS6Y3AZEoPxObui50AphOT7lpEkcuEm+b+fkjHvNgMi28KaLBsNKHwCq/w9ux3VW9d0XMGq8Ja3xVruegNfLLMnqPPQyAv7jOgFPDZcpYNx1tnvWEwZd6fjfLEGqUw+HKPFm4gRYTyVrakpL5Ut7Rt5zDdmyFpFYHAL76MJjQeoTIqDfMTfCXVuQONDcWYW5KX1+RSvAW45XKSeV6AN5325HOhGpgd0+nfSwb1B6riDEVL7KUOOMC7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92E9ItfYieonP35ZSDNlZ5zXLpNStjSEh2Ht2aJ77GM=;
 b=uyQUkJ98BL17AFQuUrE3RRl8ZA0yd2NMzw2Dxbx1ytXk8ooks3zO/oTmPaHq1l8wGA5TryNtRCdHAsBu2K6mYYGwsAdpze4212xivZL5X+KaeTH6nHiaOeNNafbg3NHBH1YISfREf0ycQ25U9PDjwYvjRUMSobOVqgknaOLDwOPpUUqylVEDzPc/NIPSH3Wr5Hf5jatT0IOOdqyJ/NFEgOmwIBwn1BvFqYUT7aAxXD5K6uYvMhdBbDn9rYGGWJK2X0tjVP0QPmpfo87VgI8QTWJ7C0buWGT3FcnNIM5I6WIcBTogBGP2ymE0ir6DeS3K6nDqJU8U3n8614IFXQ3gYQ==
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 (2603:10a6:20b:63e::17) by GV2PR02MB9424.eurprd02.prod.outlook.com
 (2603:10a6:150:e3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 19:07:29 +0000
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::2b9c:230f:3297:57e8]) by AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::2b9c:230f:3297:57e8%6]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 19:07:29 +0000
From: David Binderman <dcb314@hotmail.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "irogers@google.com" <irogers@google.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
Subject: linux-6.6/tools/perf/util/bpf_map.c:50:8: style: Suspicious condition
Thread-Topic: linux-6.6/tools/perf/util/bpf_map.c:50:8: style: Suspicious
 condition
Thread-Index: AQHaFAit7umFVzO0jEuo+/jUnZw6ew==
Date: Fri, 10 Nov 2023 19:07:29 +0000
Message-ID:
 <AS8PR02MB102175ECBFEE1AD4D124C9DE69CAEA@AS8PR02MB10217.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [c2ujlTM7bpwMdiPb8UMqMcHwwwN3HgL2]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB10217:EE_|GV2PR02MB9424:EE_
x-ms-office365-filtering-correlation-id: bddef1c6-2f45-422b-50ca-08dbe22048c9
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 S2Wqsh68HsYnKRGmgvhwVIRG7oL2nkUOl3FVFpiuwAW6EdSxYWV4njDP9ycKVFrpxvoo8VUBoeDOzw9mUkCpyfTRCmoPYYpQkemNXTmLXnOEQpo6wTGGwsY+C/pHwRzbQoThDax5Y90ySsHSRrnUCtnO8L+UPswWuE0REVe3AFIgYU5wRVBaPByUSEMKUvNx1IqFQ8RT/BGGpCX6FrgribBve9JUy4yv7asbFVnrhF4Zegf1Vs1wWCXhac6cXTjuyBZN9cHU4H9JT/EadfX5RSdUYPer+OScV59izDjdOa9sRR0S6N28JOgXYMdTt9rPyhNtbERlvrrZ/orLa80bj7GAGxucYOqGq8gkEjL1xL5XMm44owgjavxKYaMnX8p/I9blq79jy0ms8/LH79RcnoMg9/PdfJkQ45k9mxyhyUEDRsuFLp4m2XK1yqbwZyyYufGYZv+93hgG+HiBacB1unhtSUwojplxBMbuHgZzEFTHvSG38su8GDQtsIb+bl9J9+9AsGjVkwvmaNjg3+aMX/8w1xdwTPZP+ib+qYHFIExFJ54vYLs0rVIGxzUPdXS0
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?aG6NImPF3tYbNYsOMuYUIBvCao9JIUwHcBowUJDtMf6Ja74AXo2cGx7kjb?=
 =?iso-8859-1?Q?SVR3U45V5En2OkVsXotoWW3Y4APNaJGErAvPiq6rignusUg61dOeIenWW8?=
 =?iso-8859-1?Q?VgwkbUZWUvqoZwzKmALTe6qvvvYBzuQohl1HnTpTtnS+xkurX/Bs5othin?=
 =?iso-8859-1?Q?k5RLaHOMlsy9DJLK2O1iCdg54qVuNei52JRYubqwvh5jM2SPL+DrfSCGGs?=
 =?iso-8859-1?Q?94raEcBT5q1j6GkNot/75Frn2RHEiLJ6aNUensRIQcgTuVPZbRLjd6wjHK?=
 =?iso-8859-1?Q?xknZ5kO1LFvJCypx8v+fis/6f7lqWW5Yfc8sWAzXHFGph+zkVtIjiJzj3S?=
 =?iso-8859-1?Q?naf6TwHNY+4ZHnv3NXwqvv9NR0rILwoYy3YojfNM1yd02kSPPLl06jz/vd?=
 =?iso-8859-1?Q?VPSRXV8JSDmrJz9unyLlcDKAo7xWkXGW2nJEuCA+6di/XHGo0YYW9uW3So?=
 =?iso-8859-1?Q?kdgZSoFPCEeR+Z1dSDB1rl2K1QvleGBR1zbUowLXqmdohbdsiwvwqZNq2X?=
 =?iso-8859-1?Q?J/jySGRgncLQzb3HrF1WeL5SHLUOskIQnAAJ9/6hN9d143YnNZbO6yZL1F?=
 =?iso-8859-1?Q?GyOIPbn3WAoZz2KCNZkMzycIpi6AeMcY4Uyg2lJlypVmvhjUtSExgaG4lq?=
 =?iso-8859-1?Q?O5KFSw/sSjTT0vF6ibBSxYzJ3DUcPuoHw5t6+ewhEFImj6/ruvBN3FKFCn?=
 =?iso-8859-1?Q?qsntJnLFcJR8eHZ7yNz9bO2DDlVnYbuYDJ9DXkSDUk0V7byF/7lAZ9ggF2?=
 =?iso-8859-1?Q?LxtU7DZ+nBtVDVpxGYA/XQYazTKEwaYBDYtPnkQ67UlEvmyVKT6O61GcRb?=
 =?iso-8859-1?Q?bd94gsZWrlu011hdU5P+n57l7lCGan2CKqrv2YXR11QI7K/xZJ+Ec0i2EI?=
 =?iso-8859-1?Q?+nHQATIiceXeyAjQ+nAZ9+/Jrdv/IXdFvmRKIwjcD7Hoc+B997QVaKh1wX?=
 =?iso-8859-1?Q?W7JNUhVPAl5gLsG96qX1IE6QZeHl7Dgh31NMghk1zLUc9t5hZRwDd1gWlv?=
 =?iso-8859-1?Q?agkSNhmRb/SwKUa5PTnhzXgWk4p5fCf6vZVnO8ZfUuOZj+1ozbN2DgcyzP?=
 =?iso-8859-1?Q?Srz7WwBwkb9fE6gvkGTjT1HK/jxFomcLXkO/83lE2bNdbQazryK2CUyoWj?=
 =?iso-8859-1?Q?MK9yfz3mExkKjjtFHO0PEjgBDhIRXYqwOtRbMQr3IYouTvSJ9LP+2xH7y/?=
 =?iso-8859-1?Q?4G7fRCW2v9Xbalh92ebB8KclbS3HiGY6UuLOpbzaol4vHILI8ITqJZPx?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB10217.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bddef1c6-2f45-422b-50ca-08dbe22048c9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 19:07:29.0452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB9424

Hello there,=0A=
=0A=
Static analyser cppcheck says:=0A=
=0A=
linux-6.6/tools/perf/util/bpf_map.c:50:8: style: Suspicious condition (assi=
gnment + comparison); Clarify expression with parentheses. [clarifyConditio=
n]=0A=
=0A=
Source code is=0A=
=0A=
    while ((err =3D bpf_map_get_next_key(fd, prev_key, key) =3D=3D 0)) {=0A=
=0A=
Suggest new code:=0A=
=0A=
    while ((err =3D bpf_map_get_next_key(fd, prev_key, key)) =3D=3D 0) {=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
=0A=

