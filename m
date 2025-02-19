Return-Path: <bpf+bounces-51920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F37A3BAC4
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 10:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 256217A574A
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 09:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292BC1CF284;
	Wed, 19 Feb 2025 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ifNjOYU5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DC41C549E;
	Wed, 19 Feb 2025 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958460; cv=fail; b=c07TfqNAiKecyyAwMEI8J9TFllwB5NKlEWr44acCvtvSSLYWKgzcR3YdlQZBZI1RHcFzUj9BZUlAdY9R00aQ36lQdTplChxZfQTv0Qsd+C/5sKJiLStOQq78YG5i7N1nCy992qsYhaRFL/ncD0nlxD6Acl6FpNiyb5ici+3ERAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958460; c=relaxed/simple;
	bh=gSJt6KdSloQX3lSSN1XqiXCcXLXerX8+ZLCiqvQYMMg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=anawA3ViMpAwiJ0FPW2GHgT293qnwayY7gRT/dOLMPwtCd2M6Y2KAIz74pSgrJB1xFNmQiqCcDIEhxbvbKe6NrniVUhG63MS5OmN7FNlq4+k4RwW3XSwz+b9Hod/rrhqh84Z1dfnQwG2owxscmteo8iV0IvjmrbQj/40apHY1J8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ifNjOYU5; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J8iZm6013944;
	Wed, 19 Feb 2025 01:47:11 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44wc2883te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 01:47:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVNjKYwt27bmRG+i0G2egwHgXOZUNZXkjmp2yxuxiGjIY+yvQh+UpcSWj7k5FYeBn6DKvEA3T3KAnn+NTkPleTK+sbiIvbvpfhmCvsGqUvHnEFk4X1f2jrdolUO1wCTGZuU9wb90X/QjYxVIbZ3338GDS3831jDSvxsyEojaF8jCAREb3RRpL6TfB503GNAItPgq012DJPGNX0rSxUQo56zEcm5e4UhMx/v4niOl2lcZOegXl+JgYlC8J4YhBQ1UpUOwB9ME2IpYBjgb1Et6dYGlk5DbrTbLFDeh7R89UKUnW42BPLVlV4zsUvYSE65N5ww553bctXk1HorSbLbsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSJt6KdSloQX3lSSN1XqiXCcXLXerX8+ZLCiqvQYMMg=;
 b=ejPWNcPzEF4nyhJNl6QPiLY9KFC+BWUxMunDxAfyRHXXCfeNiDY3ut+QaP+EI7F7dmBFVcXUYmLsgF8ZLSVJ+wLnZamMhrz48AG6jW0Z9WZXLLhVaGQ+CA4/P4L4YqzslWTQ5VU1pflBq+bmrnFPsWgLylL8/MV/VwzzOyywhLjzXF/lPbiQ/bAQffwoayDi+IzQzAdpS5qQB19CiwNlUFA9ZWutFYCJSdZnL2DHBgWAMemN7owXb84+G00uQ9STSFrEpxuCQU0gC9tn4qX4+kuQEmiDRW+fdvxzp0TbIHNeh8LbArP++h/afmwRbYJ8R9P76IOqRm1sj7zEYZBbiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSJt6KdSloQX3lSSN1XqiXCcXLXerX8+ZLCiqvQYMMg=;
 b=ifNjOYU5b288l9scWLYlVd3c5kezlNhWwR6myaJyvBM88f+M8RxrTZuAaxzHMHuq5NnG65+y5JBkfEYTR0ZFCPswRK5SzcPihXaNRWqzUaJHM1+mRpcNSJGbpUFma2ppiJ8t4rFXTG1RujT+4k7ns14mD/dvaYT9OYp6HEF1BoQ=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by BL1PPF85182F59C.namprd18.prod.outlook.com (2603:10b6:20f:fc04::da5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Wed, 19 Feb
 2025 09:47:09 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%4]) with mapi id 15.20.8445.013; Wed, 19 Feb 2025
 09:47:09 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: "horms@kernel.org" <horms@kernel.org>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya
 Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Linu Cherian <lcherian@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>,
        "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "larysa.zaremba@intel.com" <larysa.zaremba@intel.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v6 6/6] octeontx2-pf: AF_XDP zero
 copy transmit support
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v6 6/6] octeontx2-pf: AF_XDP zero
 copy transmit support
Thread-Index: AQHbfdiziL3JtPoDeU2zWkEZIG1hHrNNDqmAgAFb4GA=
Date: Wed, 19 Feb 2025 09:47:09 +0000
Message-ID:
 <SJ0PR18MB5216EAAF8FE113CB96FC84C4DBC52@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20250213053141.2833254-1-sumang@marvell.com>
 <20250213053141.2833254-7-sumang@marvell.com> <Z7SEleIJ636O+XZI@boxer>
In-Reply-To: <Z7SEleIJ636O+XZI@boxer>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|BL1PPF85182F59C:EE_
x-ms-office365-filtering-correlation-id: c359b8f5-1f60-4605-311b-08dd50ca60a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dTR4MjdibWpmRlNCYUNBanlQdXRDTXFCVE9yM0xRaVdVZ285REVobEZmZ3hr?=
 =?utf-8?B?R09CQXlKOU10S2NZK3MvcTVYNEpPUUI4eTFBNWcvYkR5WEt4aVVRVW1ST0V6?=
 =?utf-8?B?U1RnSmIvMk9iN3YzbmtBS3dkT3FJWHFubEJqcHk1ZjRVdlpPRTZQVmlQaDdX?=
 =?utf-8?B?am5SUlRLQjRkNEpaaW1NbVhUL1FLMUtwdVQvMWtIKzlDbnBuWU5Vallab082?=
 =?utf-8?B?VEhOMEVlOWt2NXNUTmlrVldmMHhPU1NCRFVlMmJObVg2QTg1azdYZ3gyR1FY?=
 =?utf-8?B?a1gwaDBKa3RRQUFRS0J0Rno3dWhWcDREWVB2S1NXdlpJOXdKWmhWaSs5UEFi?=
 =?utf-8?B?WkdULzVSYUQxZjkzT0dvZTdhNDBCTnFpU1B3OW1ub3RhVDNUY1p1bnRiSVlB?=
 =?utf-8?B?QlVnTkRUTTAvOUVWVzVwYzdLNXliSXNGRStZNWFtRU04T0I0dzNMK2N4MWU2?=
 =?utf-8?B?S05qaWNtTGFrZ1dNTDVxTEIyZUxOWTh5VHovNEZIT3NFYUhoMmFwcktlamdt?=
 =?utf-8?B?NjY0QW94ajZVbFZONTE4OWU0cDVNVUxTUnc1Rno1R0xZVTZ4L3V4WDJUeEpi?=
 =?utf-8?B?cEcrVjhZTTBoaWZnU3krbnNQc3MvbWdaSEI5cHZDRGI2SEh0UElva0xuY0NL?=
 =?utf-8?B?TENsWGlBZWV6cU01Vm5iUEdiSmNGTXJIYkRXOEtPckRuam1XWUlpNTd6MElE?=
 =?utf-8?B?SXNJa3V3ZDFRYmJJUFZEMjVtWmtHYklWUno0V2M4a3dOeEtxcWtNMUViWDhL?=
 =?utf-8?B?alh0TDF1OEtORnFROHZ1ZmE2MkluVjNCRllLVmRlQVRuMVlXVExaTGVXVkVz?=
 =?utf-8?B?OE5lV3VOTmQxdXBvNXpZL01BYWsvTGQzeTN5bUprY21OWVJCbFNGa25oWXd3?=
 =?utf-8?B?UEJNeVBtMzhHR1BOSHJ0b0lmcDR0M2JMTEFwTnI4dkljcFlTb3R2N3o4M0pQ?=
 =?utf-8?B?S0pSOVhaZEpYZEZ6KzAwdHdwekxTQ0JRa1FFbVliYkJBcXFNVnpLZ1llWXFP?=
 =?utf-8?B?V0NXZ0cxdnVaVzJxTG9iNXZFUk1HbVJMd2dIVGw2K2Y1eGdUQU52Q2thMlox?=
 =?utf-8?B?N20yUXQwTS81b1dtRlpvQ3hiUHlsblpKYkN1VzhHeFQ5U245dnl5RmNvMnNM?=
 =?utf-8?B?Y0l3Q2NvZTVOZEVXZHJ4aVJiVTliZWRLZmxjenVraFZCZ050dWRJTVhCaGVs?=
 =?utf-8?B?VTJ1UHE4c3BYMWFDdXE5NjNtOTRqREM2Q3NmdVBFM0Y0T3pYU2dwV0UvSExP?=
 =?utf-8?B?NDc4QXJRRUFEYzFMdHk5d0QzQXlTWlJ3MHlObEhaNVVsRGxsQTJkTUt4Tndk?=
 =?utf-8?B?MjVmMjZvUkoxOXU1blE0UnBKTHRoWlc1UWFTcDRyRUYyTzIxUVp1QXVoZW03?=
 =?utf-8?B?d2tGUTJPK3l6RUl0d29kM01zOGpZNitnSm9qMFlxbFd0S3hVYjdLV2h1MEw0?=
 =?utf-8?B?Sml0c3AvVnZMTmpXK0RrdllIQy82RXRWWW1pcFRoVG4rOGp4YTgzRmpDMlhp?=
 =?utf-8?B?VWFlQU01QjZTTGx6ZDVNa25jam5pM21iVWZXVHMvR1c2LzdhV0F3VnJBbWNF?=
 =?utf-8?B?TjZ1QmJReTA3U0lzaXZVTTlsRlBIakJVS210MXdKZnVWeTB2MEx3WVVpNWRh?=
 =?utf-8?B?MEFKcXF1clNBTy9GWURrZmU0eXVuUXZkbVM1dWNFK3p5Z2NwdStFanhBYkdR?=
 =?utf-8?B?SWlJTXcvYlRuZU1jbHdTaGxUNDFWQ0xuUUdSeWFneENoSFRPTmVGUmVFRzdj?=
 =?utf-8?B?R1RyZXFra3A1NWFidERTb1JuZGkyMGlwY0NoQ0NUUkdGTXBSdjZUTXZSbHNQ?=
 =?utf-8?B?bjE3akNCWGlhYVh3YnVNMkh1b0VSRU90SmxscXdLbnV5bUlMYmk4ZTBXbDZX?=
 =?utf-8?B?Y1lDV1BMRUZtZWNkZG5XU2xib1dCUnZGVm1JK3ovOXhDeUZYYUF2cUk4R09u?=
 =?utf-8?Q?Wo54uRa0KsCAqSLDxRABFlSG6sdJ4ZFQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alBPOXNSZWF2aktqV044WG55aGF0SEJ2WDNoQXlESGRsQ2IrbTJoRFJCdlJr?=
 =?utf-8?B?U3FqdThzU2EydUdhODJQUGo0Q3pMWEJjeTlZRXp4UzQ4b0g4SEI4MnBLSE1o?=
 =?utf-8?B?NXNzdHJYcTBwYW80aW1SNEJnZTJBd2FzOFJmelFsRXlMUm1iSld5OTJsMGZV?=
 =?utf-8?B?TFhnUUYrcVBuQ1czelExTGRBazdwbmRhb3FmWk81Snh3c2hJRDZMZ1J2M0ov?=
 =?utf-8?B?NWV5SkxvekE2dDJOZ2xlcXd2SFVWLy9WUHErYW5DMis2Z0xNbks0WjhQTlFx?=
 =?utf-8?B?OFM0TW5IemR5Z1FGWDZLV2xtdlRvRVlvWW9YemdQcDZuVGRsSjdCNm0wOWxx?=
 =?utf-8?B?QmY2akRPQVhkZHI5MjIrWnBLNGN6K3lXQzdhNmRTdTFXRWRqRW1MS21PTjJ0?=
 =?utf-8?B?L3BIdjdiUHZSUFFjUGFIYVltVEpKMXhzWEMrNVNzaVk0NlczS2tEb0xoMjNL?=
 =?utf-8?B?MjBBaFdPeXdVRHdUckZSUHpFa2ZlUTBaeDArTTFBbEIwZFhtNC9OeVpYRVBt?=
 =?utf-8?B?VUdxQzBvL1ZaZzFJVkd4dFJtQkU2cjNBNmkwaE5xN0U3K2VtU1p5cDN1TkZT?=
 =?utf-8?B?NmJFcTNrU2hqeVBqb20za1JiWS9tdjJNRGZ2V2VGSGhJS29GTmpHQ1BidVpX?=
 =?utf-8?B?ZUJ5STYzTUdycnAyMzFmdm9tN000YWNvbkxtMVNuT2VtOEdpZFcwZVNHSkEr?=
 =?utf-8?B?djY5RnMzVmpmMVE2MkdqUXhtVGl5dXIzMW54c3NiNVNVek5rbDJGdHZQWC9l?=
 =?utf-8?B?V0dMWlZac2dTcU5wSm5oeXA4RW8zZXVhUnFpRXdqSlpZMW5CRGs5eDU2Zktk?=
 =?utf-8?B?MlU2d3JvdzcvYy9xUCtaS0RDSThhTFhtdmdtVjZIZGozRTFOYklpNlZKVjZi?=
 =?utf-8?B?VzIxVDhtdjVteVNyWUtjMEI2Y1NMdHNRMnU4QVZET2Fvb29FaDZ1Y3lKL0xp?=
 =?utf-8?B?Y1N3VlREcUJLNzNPLzYrQzhUdjdLVFhKUmRQZjlmVW5xeEkrd0UyMGtGTWZa?=
 =?utf-8?B?TjFLS2MvbHdqb3Noc0dGb0E5dlFOMHpsR3lrOHVDV3lVa1BKQlpraFd0dTNq?=
 =?utf-8?B?R1dWOXZnTVVNYzJhQlAvakNOT00yelo4VG42K1Ezc1RCaVNBNDRGZ050OURm?=
 =?utf-8?B?ZU9LTnpiYWErZ0tRbHMrUFpWTmE2MllCQ0FkbXNnR29IQXJBTk1VbXRDVlRz?=
 =?utf-8?B?L1VraGp0M2pIT3VGSnFKbll4M0lSSEw1bTFuUjJWanNhejdpbXp2OEJ6elo1?=
 =?utf-8?B?dWxGcXV5M2FER3FwUEdsQ0RwRzRSUTJUWFhaNlhBZWthNXdhaXlRMXRMNXZC?=
 =?utf-8?B?L0VpaC9ZL1BMSndBVW5lTHpNMzB6ZlZIUnVSYlQyWk83c3NyMTJ3clFHK2Ns?=
 =?utf-8?B?Um9OUTkxdklVNGluOHp2NWpyRVlJbUlBSWwwd2txWWNMdVFOc0ZBZERNZWVi?=
 =?utf-8?B?Qk8ranF2SllBcTBVT1N5cUh5LzlkMUo0QWJLc2NENXpiMGF3QXFWWFlZK3RI?=
 =?utf-8?B?S20vaXB0a25TRjdXc2dUVXJGUFJVRkozRGRmVjhjWDNCUFRLT0diVGVJZi9E?=
 =?utf-8?B?ejJiWGFHN1YydXN6MmNoVlBzaWZPR09FRXpJZXIyVkg0UlAzbUIyZU5PVjZD?=
 =?utf-8?B?Uk14UjQ0SGU0S09PMkJybVF3RXlqYXlFRGxKUmlxS2dEQmExQUc4ZXgzMDA3?=
 =?utf-8?B?YmNVclVqeFl2cWIrMDFNVjlYbDcxZ3FoalhlTE92b1hIZXNGM2RSc2pYUWcx?=
 =?utf-8?B?Znd5Nyt3Y1JYN2hXQ2U3NlZodG9Rc3gzUlFCbkpjcXBsMDlrZXMxbVIrclBo?=
 =?utf-8?B?N05JRXJHU1NudHdDa3FQaVozQWp1YVc5dnBMWW5BUnNKdVM2V05tLzBGZGxu?=
 =?utf-8?B?SkJJSW44ODNPUGF1Qjl6YmkyRlVzSnRnK05tVzdxUmdXS1dYcEtJTTdkelg3?=
 =?utf-8?B?MitUZDNpWlMxVDJ4TUlkVFUyVkQxc2Vad1habGlmajRZQ0xuQ05EbWpiclNX?=
 =?utf-8?B?TGxyNEZJbEhQUFd5YUF1US9LZWIvOFhCMXFnbU9VT2FuSmpxVnd4Nncxc05K?=
 =?utf-8?B?UnE3bHMycCt2RDgva2dUWm1FZGM1REI4ZElDcjFJNnJvMXQxMUpFZHczQlpm?=
 =?utf-8?Q?mOf8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c359b8f5-1f60-4605-311b-08dd50ca60a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 09:47:09.1118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sg+z3++g4XO5Lcy7seNgquqTKTrZyocMNUKIWIpQG0UbP34xJv+UEvC2dmvTDUFDTJmoj2zCrDKz4kgKTnq7Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF85182F59C
X-Proofpoint-ORIG-GUID: XWjQZPXfgbDIY2NjdSoGiylirXrVJtRc
X-Proofpoint-GUID: XWjQZPXfgbDIY2NjdSoGiylirXrVJtRc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_04,2025-02-18_01,2024-11-22_01

Pj4gK3ZvaWQgb3R4Ml96Y19uYXBpX2hhbmRsZXIoc3RydWN0IG90eDJfbmljICpwZnZmLCBzdHJ1
Y3QgeHNrX2J1ZmZfcG9vbA0KPipwb29sLA0KPj4gKwkJCSAgaW50IHF1ZXVlLCBpbnQgYnVkZ2V0
KQ0KPj4gK3sNCj4+ICsJc3RydWN0IHhkcF9kZXNjICp4ZHBfZGVzYyA9IHBvb2wtPnR4X2Rlc2Nz
Ow0KPj4gKwlpbnQgZXJyLCBpLCB3b3JrX2RvbmUgPSAwLCBiYXRjaDsNCj4+ICsNCj4+ICsJYnVk
Z2V0ID0gbWluKGJ1ZGdldCwgb3R4Ml9yZWFkX2ZyZWVfc3FlKHBmdmYsIHF1ZXVlKSk7DQo+PiAr
CWJhdGNoID0geHNrX3R4X3BlZWtfcmVsZWFzZV9kZXNjX2JhdGNoKHBvb2wsIGJ1ZGdldCk7DQo+
PiArCWlmICghYmF0Y2gpDQo+PiArCQlyZXR1cm47DQo+PiArDQo+PiArCWZvciAoaSA9IDA7IGkg
PCBiYXRjaDsgaSsrKSB7DQo+PiArCQlkbWFfYWRkcl90IGRtYV9hZGRyOw0KPj4gKw0KPj4gKwkJ
ZG1hX2FkZHIgPSB4c2tfYnVmZl9yYXdfZ2V0X2RtYShwb29sLCB4ZHBfZGVzY1tpXS5hZGRyKTsN
Cj4+ICsJCWVyciA9IG90eDJfeGRwX3NxX2FwcGVuZF9wa3QocGZ2ZiwgTlVMTCwgZG1hX2FkZHIs
DQo+eGRwX2Rlc2NbaV0ubGVuLA0KPj4gKwkJCQkJICAgICBxdWV1ZSwgT1RYMl9BRl9YRFBfRlJB
TUUpOw0KPj4gKwkJaWYgKCFlcnIpIHsNCj4+ICsJCQluZXRkZXZfZXJyKHBmdmYtPm5ldGRldiwg
IkFGX1hEUDogVW5hYmxlIHRvIHRyYW5zZmVyDQo+cGFja2V0IGVyciVkXG4iLCBlcnIpOw0KPj4g
KwkJCWJyZWFrOw0KPj4gKwkJfQ0KPj4gKwkJd29ya19kb25lKys7DQo+PiArCX0NCj4+ICsNCj4+
ICsJaWYgKHdvcmtfZG9uZSkNCj4+ICsJCXhza190eF9yZWxlYXNlKHBvb2wpOw0KPg0KPnRoaXMg
aXMgYnJva2VuIGFjdHVhbGx5LiB0aGUgYmF0Y2ggYXBpIHlvdSdyZSB1c2luZyBhYm92ZSBpcyBk
b2luZyB0eA0KPnJlbGVhc2UgaW50ZXJuYWxseSBmb3IgeW91Lg0KPg0KPlNvcnJ5IGZvciBub3Qg
Y2F0Y2hpbmcgdGhpcyBlYXJsaWVyIGJ1dCBpIHdhcyBuZXZlciBDQ2VkIGluIHRoaXMgc2VyaWVz
Lg0KW1N1bWFuXSBUaGFua3MgZm9yIHRoZSBjb21tZW50LCBJIHdpbGwgcHVzaCBhIGZvbGxvdy11
cCBwYXRjaC4NCg==

