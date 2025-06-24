Return-Path: <bpf+bounces-61459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9C9AE7277
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3101816A895
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 22:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169EF1FBEB1;
	Tue, 24 Jun 2025 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RAD0nhj9"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB44170826
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 22:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750805358; cv=fail; b=byPZ8ivKEAvhVltjUfo2RMo1LCpBcteNZpN+XvVaoxrUH9uVeU36dr4MGIuCZusL7aIeUycTAeaTjG/0DVyxO5NI1GkihoG7GZ5g5hbVlWCPkoO1uqeETTPYNgAf8c6dwItipyni5D/IHNMPFgCyYz02chr3F1tb1ylk5wzzQw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750805358; c=relaxed/simple;
	bh=WJhYe7m5W+AnCd/NPQSxmtqwHkT2ThjTMGJDxKyVKcM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hCEK2fDlSATqtebob25ep5flfJ0PgrwgrbLL528TKCT4QiIRhDr7Ul7MhOhk6mkLGC7HorcLuLSLNJLTXHOZOHYllLzmC7t6uzgON1EdymBZyUP60jgMYhGVgGFnaEVMay7BrZT1QpXwMTaEoH8A7Z0tOZ+8LvwNebsmyHPwX18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RAD0nhj9; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OMlGjD021807
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 15:49:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=WJhYe7m5W+AnCd/NPQSxmtqwHkT2ThjTMGJDxKyVKcM=; b=
	RAD0nhj9orKrNLvq9ZMBkWKZLFjflzYUPwrTEKS5wBj5JpGQPt6Of5SyUQrDVSIh
	T7GWqavEzsjSGMMeHBu2zVedtTgRradX50924IAJrwcdu0mTjxNELG8VvlslD/Pw
	WHF/zBtJ2VHaaAoCZlUiD53AGmpi1LeXNA54wcz7Qx9+RE2Mwbgtt7KPK1UNsVfT
	oCvt/eWdaEM++SEU3oBrvJgIJvZllNPdcfICyN71IYr94gC5Wm+h9XcJhSdXqhPq
	Id2As08fNinkAD4TfA4bKhSPUS4V6mFJv0s26GO/pYQmkX8SQtBjJl8Nr1rHXEI8
	eLoENWZO8nW7OP2bfn0n5w==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47g00eaj0y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 15:49:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXPtt/AAENTGnX+mJSGSJIH4kKh5vc/tkeJXBWA/47t4JTRUvqnjHNtajH0McBK1FFF4WWGHo7iK20L1kaBsjjH+88pCcqwtR9CP7iqt4wf4FKu2Kn0zk0Bov7PZjVf2TIkIzYwpV+PTRShMLWvhYwtSOoIDRTpEF4TdUYKpLhJEyTLlybDniY7yY5nPiT0+Y4jXrh/LfEaiORuPkWMaQ575nfcunXyVAZ4bqtWte72ljjQ6Zssxie1fkWAJUTLMg3FWKnEOBH2iJI+C59wYFbZmkGKZQYqFHA5inTSq0Vkc7CdSP2OftByjWxpbYzjMD4aVlPS90aYjS0h/ByqgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJhYe7m5W+AnCd/NPQSxmtqwHkT2ThjTMGJDxKyVKcM=;
 b=zP+MEuqHq5QwyGMoXN/rt5+8U9aK7U+tNBPA+3lLILpUEHV6euM6e8B0noF58B2qAlKgIxAieomsq9Y8sEPPcNjbWnw/J5Lknsuacx3LezgZcpVRUaJlci01OcaMI2AOeu7fyaavs/mQydmOFz2iXgjTDlVUZ7V+0YIFR1e3ayNPg+8vqN29127zFyDOLdtLgNfxLq1T16/feS4QgakgUmCYtWQu8lirF/0gTQ80mhtEyDwtY/2kVhWrXCFmd692CioZLEhKVsMVLHQFfitkxn2Kp2T5xOfRU3nLqHFNJ6dCOmYGQrWIunAOzPi0IeyBOZEmZmOHE0jqOPVBNeet5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB4055.namprd15.prod.outlook.com (2603:10b6:5:2be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 22:49:11 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%6]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 22:49:11 +0000
From: Song Liu <songliubraving@meta.com>
To: Eduard Zingerman <eddyz87@gmail.com>
CC: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net"
	<daniel@iogearbox.net>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add tests for BPF_NEG
 range tracking logic
Thread-Topic: [PATCH v2 bpf-next 2/2] selftests/bpf: Add tests for BPF_NEG
 range tracking logic
Thread-Index: AQHb5VN34QfXsmdeNEWG3TDLyijZx7QS4TCAgAAIggA=
Date: Tue, 24 Jun 2025 22:49:11 +0000
Message-ID: <323C8849-FE4F-47A7-ACF1-D30FC066111F@meta.com>
References: <20250624220038.656646-1-song@kernel.org>
 <20250624220038.656646-3-song@kernel.org>
 <9c18fcc83b4fa0c5685519bfb80f102436bcd675.camel@gmail.com>
In-Reply-To: <9c18fcc83b4fa0c5685519bfb80f102436bcd675.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DM6PR15MB4055:EE_
x-ms-office365-filtering-correlation-id: bd534753-9f21-412e-6bdc-08ddb3715600
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MUdvWjBqdjlYbmM2N015QTE1eEp1Nm5EUUFOSXlHSzZPRENJMGpsMzd2ZUly?=
 =?utf-8?B?eTFQSFVkeUNXekhYOXlPVjZBbFJtbmtBdnI3OHQvNm5YMzRtc2xSU0tDYk0x?=
 =?utf-8?B?M1VNWVhrSTEwSWdpUmF6TEM3ZEpLM0Y2MVNicXZUamRlLzIvL3R2dkFVcVcr?=
 =?utf-8?B?TTMxTmVRZEcyeks1V1BjbVFLbmtwaEovUVZHc2xPVUczV0dGN3BkcXhSYzkv?=
 =?utf-8?B?Qjl3czFieC9vSjdsR3Z6QnBvVjBoNUQ0U0xMWTBiRHdOamwvc0pLMHJQaEpC?=
 =?utf-8?B?Q0xGVG41VlI0VHJ6WU16dWhnb2NFV0FoMlFKN1h6RWo0b3J6U1BWQ3UrZGhi?=
 =?utf-8?B?S2lWQ0p5bTJXY0tmQkZWQkFMMGNMVXNRU2RzdEpoQUhjOEFTQ0lBaTA2eXJ3?=
 =?utf-8?B?eEo5QUpZb1o4dTVQa3N5TlVSa3diVUpRc1lJRFVuT3JhVXRNYmdhNHllM1hI?=
 =?utf-8?B?UmRBdWlQWWl0cUNkdkxXYkFzWlowdzFDMHJrbzVzQ1dYSE1vamlHSFNJV2dl?=
 =?utf-8?B?ZGlUSnJrVGdIYUpnWTkyRWluK0ZFV2gxTURrRSs3cDFjaW1KdWNOVnBoaGFo?=
 =?utf-8?B?QWxHYXB4ZXFoU2t4eVgyeEtHOUtydUxzc25wYmIzVlpoWDI5TUw5dUN6Y0Iw?=
 =?utf-8?B?SFkyUWhHT0RLcVBpMXVIWDFDbU1Uay82d3lONTd5amt6MU5kVXVLZUhvSGVJ?=
 =?utf-8?B?ajRBdi9OZk1VQmwrZFIzUy9ZTXA1bnh4Mk1QMnlaTmdheU9sekowcmZqVWJD?=
 =?utf-8?B?UTlmelJsUCtiOWx0dnVXSHptbjhhZ1J3UkRBYmJDVHRuT2VuK0lXY1MySzVj?=
 =?utf-8?B?aFY0cStNY09LZTlTVWYxU0VjUEcxaGFORWJwNFFFbSs5UVFRRittZmhsMnda?=
 =?utf-8?B?Q2xObTlMbnRTdXZTNXJ3M0wwdkVpVU93cXBxSGU2OVdBSUV6eE4veWFiOHox?=
 =?utf-8?B?VUVRdzlnTTU4NmpWRVFVM0JWNXh0MUZDVUk5M0hnSEllL0NwYWY0Yi93RTlJ?=
 =?utf-8?B?UDVFczQ5NDl5YWlyL21EV1BNOE1yVnhncTNiM25PR3FXcEpmNEFHUXZ0cFhS?=
 =?utf-8?B?YlNTK3NXWVpIbHUzYlpma1Rrcm11UDN4WEpwSVVSK05IU1JNYitsdFFPWXkx?=
 =?utf-8?B?UXJGek5ML0hwelZrU0E2TEtMQ0ZyZW5lNUxQblFjbnBENHlZK1pSbnJXVHpt?=
 =?utf-8?B?VUVHdVZKOTB6bEhCYy90RkM3bXJDMm0wZlVwcEtLWGtqVkkvWDc1THFweTdE?=
 =?utf-8?B?RXJUcGFTYlRnN1YvNkZ2QXJaK0xLOWdjUVdTdUNXM3ROK2lIMVZRNHlTTVNz?=
 =?utf-8?B?TGNHb1MwVm5JYmRBbmNSdUIyWFFkcFlsa0F4UWh1MklONWhKdXVJcHIzNTFG?=
 =?utf-8?B?VGhJK01BbkErL2lQUmRhdU9LNFo1VlMvUXcwVzVWZG8zOThRbU9sVXNJOUdD?=
 =?utf-8?B?SnZoWCtJSlRlQktuRGFZaUliZ3liK0dOaG5Sdml4WUtLajAvWXliN3BwWFVs?=
 =?utf-8?B?QTlIQnE4TnVCSW1nSzkrbkFyYWg2cTAvUTZQWW5iMWdxMUR0dS9DbW16YjFS?=
 =?utf-8?B?VkVpbXh1SWxrWHlrRDR0S1hkWUVtdmFsNjRUbFljU0wzUGxIYWtOa1lLdWhN?=
 =?utf-8?B?Lzg3Q2FrakljR3J6K1FXL0xTazQ4em02QXlSL2VLNk4vdlpKdnVMM3R1WGo0?=
 =?utf-8?B?ZEpaS2VtcWtUK2k5dllORStTcjJjZ1lFTVUyNHFad25lR3pKUDNObVorcWFv?=
 =?utf-8?B?QmRacmU4OE5QeExyMUh5cXpNMXFpNlQydGZ4U3VFd2JDZk53VnpKa21uLzgw?=
 =?utf-8?B?K1JyWHRyeHQyZjI5Z3llUjhwRXhhTTg1VTcxQ0dYdVAyUFlkSUNVNkxiOTgz?=
 =?utf-8?B?c3YwTjA5MitHeVExanpGejhtU3BOWHQ5RDc0cmhaeEd0UnV6dk9TTDl4Nk42?=
 =?utf-8?B?bDVlNll3UWgzakFrdS9PdkZtQUlqbjBvbW5kMUZFSDNXNlNxOXlCWWttZEcx?=
 =?utf-8?Q?ijbEjVr6qoVLdou4PqpYNpI4XRvcXY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFpYUWpmRVBjdzhTbE5tQXN4bnZWVlF6Y0JLbzdQZy83RkY3c2hEZ004ZG5r?=
 =?utf-8?B?V25FYmlhMXNtd0g4dHIzNU8wRFZPNkdubG9nZS9ldUlIc3lZeE90NEd3dXBS?=
 =?utf-8?B?a1I1cjhSVjhrT2MrbHJJb1g1RHFtakxoUjI0T21hOVp0VHVjWktFMUsrNDQw?=
 =?utf-8?B?Q2ZvVE5LeHdqVjhhdDJFbFpEUGdLUkEzOWtuVkRYVW1yT0YxaDFSZi9Od29a?=
 =?utf-8?B?d21oTjlyL2Y1NVRzZFZHejFoSEowb3QveXJZU3kyd1NXQ25MZFJXdU1kUnhI?=
 =?utf-8?B?RmVLOWxmYjEzTjRubUZRM0tmU0JCbTd6RGpPeGxQN2ppZUhmcmthY3BTZEJL?=
 =?utf-8?B?MmJ4YmtPdkpDdFdhZDI1Mm1XYVNoSlV0ZGNjNWl6STNzczZyMW45dkcxS2sw?=
 =?utf-8?B?ZkpicUtuWVlPRWVQMTBtMk55Szhsc2dvL1NxeWZiSU1wRTdJMW5qWUdpTzZl?=
 =?utf-8?B?TU00dGVEVXhRbDZMbDNuc29CZThXUS9aY2R0MEJjeUNheWlkOTlRRTVGY3Ju?=
 =?utf-8?B?YUN4R3NpNy9hUC9pSHAxY2NnSTFQb204a3ExVmphQ1Q3NlFBdEgxZDg3T3hj?=
 =?utf-8?B?U1R6cXUzaW1oRWlVemFsQmJtU242ZHl3eGkrYk8wZlVnZHoxZEhSNzZhSS9L?=
 =?utf-8?B?b1FoVzFyV0k2ZERXZG5KMHJIUzdBOVFkdFZGYmNrZnFMb2Rkdi8rZis2TkxS?=
 =?utf-8?B?cjZsWEkzNWloeVNRVjVtcDNMZWMrM2hWVW82djFBbVlRTDVnOCsvSWp3U2Vo?=
 =?utf-8?B?bFhvMDB6VGdRSHQ4a3hsWTZJRDQ5emhOeENtNEduc2h1Z0NQbGRKbnhBY1dM?=
 =?utf-8?B?bnI4RCsrTjdXNTFmQ2QwME1yMHAzNUVKWThYdjBuNTFsWmZHOTdVbkt5M0la?=
 =?utf-8?B?cjZmOEpuTE5Ja2R5bE1WS1VvWmFPQWtyNVBZcEhqci9hZkhJTVBKUnhZNnVL?=
 =?utf-8?B?N3hJeXo5dmx4TnVsaWZlUHM4Wm9uWEdpWHhNeXVOWjk0SURGWlBBOWp2VWhu?=
 =?utf-8?B?ZXZkZ1NCUmVTU3VOQ2gyUTdCOVNsRTJjNTBGS0pmVnptMWVrZ3p4Q1VacEVS?=
 =?utf-8?B?L3ZxeDZocUtPdjNpcDljb0x1dEdUR1p1YlNYTDlXdGM0cmtpc0lGODYrZUt5?=
 =?utf-8?B?WDA1TzR0blhGVjlSN3F3Y2Noc3RYcUtXNUxkQmp5ak04NStZOUpYRnBMM1NE?=
 =?utf-8?B?b1VYd1c5Z1dweEc0RE11eGQzNDdDWFpySUxkbDJQY3ZXL3o1YXR1bjEyZ0hW?=
 =?utf-8?B?RmN2c3dWTlNpYy9UdDlLcFdzRWF6WEx6REVtaGFia1RTbGl4dzFWOHdqU09Z?=
 =?utf-8?B?dm9Ick1HY3FXRzNBUEVwaFhxSVk1NHpzMVV5OWNjVHVuenpoMXpiYm9ENFhj?=
 =?utf-8?B?TVNIUDYzSk01clhvQkxNT1dIVmpkK0llZnh0VDB4QzhvR2Q4Y0NkSEswNzRu?=
 =?utf-8?B?R2VlL2hBSjliOXRkbE5mTjkyRlE5WjBjZjBxSm5DOXVnZFBZby94WWRiTGdq?=
 =?utf-8?B?N1cra0t0UytKYUQwRjFkWGpESzhKYnZzRnF0OFl4QkhoenllaGg4L3MvcGdh?=
 =?utf-8?B?OUxzR2xFYStkTEw0N2ltd0R5T1g0ZW04Y1VkS0d4bjU3bDZpRlgyYStHOHJz?=
 =?utf-8?B?aUwyVWVpVGNQMWdTRmZPRktnRkNoRTBoTkEySXkzOTZHdTBTT3RKcHNveDRW?=
 =?utf-8?B?VW9xNzc0TXpTbUNTY2JXRFFlb1lXRmdGMGxnT2NZMkJUQVJneE5XM2RXaVBs?=
 =?utf-8?B?OXlwdytET1dPcndKLzZjSDJ5Tm1ZQ3hXVk1FN0tqWC9pdE1hei9CWm5Ja09W?=
 =?utf-8?B?ZTRmUmVTd0NJU2dOWkNDVE13OXNoQVArdkNHT0xqSWdHUjRUelhVZm9xci9h?=
 =?utf-8?B?V1h4VmM5TGtDNHRTNTdDSzFDcDhMNFBOMmkzbms4dGhBTDhNWXFQb01yVk83?=
 =?utf-8?B?Vk01TStZOHlPMENjOHVjS2ZndGpMek1UYldGa1d2UDZuWVZYYTRscE9rQzdS?=
 =?utf-8?B?dlRNb2pZUFV2QW56U2Q5Sk4yM0IvMEpQQTlIMlN6UnFaMmhSOEs4YWR1bllS?=
 =?utf-8?B?WER5eitwK3ZmenRnNUlvZlU1cjBsTi9xUVM0MG9teTRUZlBpS2FEWEJFVS8y?=
 =?utf-8?B?YXJydmtTR1N6UTN0MzhLNzdsZGtQL2JwUmMwaWsyVjdrQVFGZEduVUlKaTdW?=
 =?utf-8?Q?uGvuNus+E+zkc7LOIidy4ik=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <779D27B4DA1049478221A57AE2805A94@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd534753-9f21-412e-6bdc-08ddb3715600
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 22:49:11.1941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hd7zZkAZA+VnE4VDUpYMvyz2rWRCiuQYJoQam4rfSQqbuxkVX6z0m9zuz86vHxgkrX0YlK8I74jR8ueT+GBH8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4055
X-Authority-Analysis: v=2.4 cv=aaxhnQot c=1 sm=1 tr=0 ts=685b2b6a cx=c_pps a=L9yf2vioRF/+oJH3m7olGQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=tmeKAcLKw7KokybKUPwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QGXdNtieEYHVl2dTXsNIEDKoieLRa23d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE4MiBTYWx0ZWRfX0q61ZxaGgb8Q CRTyTcXeaQhyfzz6MufOsW9Rab5dh4b9P/OOaM/nUZgM9yrczv9djX72dRyWibL/SoeehPbPkEe mzmW+IDeaOcsrqR2PchQJ/LHFN/yDPZjBMLRQ+3wexcZ1y7Vn8gHS/vE8pjxXvIMSdiNt+1fwks
 xZBlmA2UcTayPSf0dgVyFdy2b+kHRLo9ZlqDg/KPRU1tnlJY129bAPFECMHMcTm5G5I7lUAhOIM hd+0Woa5i+o283ieT+aAMVOYqnzdj+G7Y/6DVmrPzrysMtlLygx3jy5y1mbKdzJMW3Qa14eFc7b pwdnKHV/SVmaPkVIOC90D2dWF10o4hSgh5qHNXt7yk3jcYNoonRWWi505qeFMc9R669QkrSQpbp
 ddnRj/pPZGkc2ful7y56dIor8f/DejN+b5zuNoEL9N4PgsbLlfcATYAK4PqyF5x44HlWSqWB
X-Proofpoint-GUID: QGXdNtieEYHVl2dTXsNIEDKoieLRa23d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01

DQoNCj4gT24gSnVuIDI0LCAyMDI1LCBhdCAzOjE44oCvUE0sIEVkdWFyZCBaaW5nZXJtYW4gPGVk
ZHl6ODdAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgMjAyNS0wNi0yNCBhdCAxNTow
MCAtMDcwMCwgU29uZyBMaXUgd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4+ICtTRUMoImxzbS5z
L3NvY2tldF9jb25uZWN0IikNCj4+ICtfX3N1Y2Nlc3MgX19sb2dfbGV2ZWwoMikNCj4+ICtfX21z
ZygiMDogKGI3KSByMCA9IDEiKQ0KPj4gK19fbXNnKCIxOiAoODQpIHcwID0gLXcwIikNCj4gDQo+
IFNvcnJ5LCBteSBwcmV2aW91cyBjb21tZW50IHByb2JhYmx5IHdhcyBhbWJpZ3VvdXMuDQo+IFdo
YXQgSSBtZWFudCBpcyB0aGF0IHlvdSBjYW4gbWF0Y2ggdmVyaWZpZXIgb3V0cHV0IGZvciAidzAg
PSAtdzAgOyBSMD0tMSIsDQo+IHRodXMgY2hlY2tpbmcgdGhhdCBpbmZlcnJlZCB2YWx1ZSBmb3Ig
IncwIi4NCg0KQWgsIEkgcmVtb3ZlZCB0aGF0IHBhcnQgYmVjYXVzZSBJIGZvdW5kIHNvbWUgb3Ro
ZXIgX19tc2cgZG9lc27igJl0IGhhdmUNCnRoZSB3aG9sZSBsaW5lLiBMZXQgbWUgYWRkIGl0IGJh
Y2suIA0KDQpUaGFua3MsDQpTb25nDQoNCj4gDQo+PiArX19tc2coIm1hcmtfcHJlY2lzZTogZnJh
bWUwOiBsYXN0X2lkeCAyIGZpcnN0X2lkeCAwIHN1YnNlcV9pZHggLTEiKQ0KPj4gK19fbXNnKCJt
YXJrX3ByZWNpc2U6IGZyYW1lMDogcmVncz1yMCBzdGFjaz0gYmVmb3JlIDE6ICg4NCkgdzAgPSAt
dzAiKQ0KPj4gK19fbXNnKCJtYXJrX3ByZWNpc2U6IGZyYW1lMDogcmVncz1yMCBzdGFjaz0gYmVm
b3JlIDA6IChiNykgcjAgPSAxIikNCj4+ICtfX25ha2VkIGludCBicGZfbmVnXzIodm9pZCkNCj4+
ICt7DQo+PiArIC8qDQo+PiArICogbHNtLnMvc29ja2V0X2Nvbm5lY3QgcmVxdWlyZXMgYSByZXR1
cm4gdmFsdWUgd2l0aGluIFstNDA5NSwgMF0uDQo+PiArICogUmV0dXJuaW5nIC0xIGlzIGFsbG93
ZWQNCj4+ICsgKi8NCj4+ICsgYXNtIHZvbGF0aWxlICgNCj4+ICsgInIwID0gMTsiDQo+PiArICJ3
MCA9IC13MDsiDQo+PiArICJleGl0OyINCj4+ICsgOjo6IF9fY2xvYmJlcl9hbGwpOw0KPj4gK30N
Cj4gDQo+IFsuLi5dDQoNCg==

