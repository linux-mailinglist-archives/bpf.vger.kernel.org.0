Return-Path: <bpf+bounces-35712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCAF93CF4F
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 10:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A60BDB23A4D
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 08:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E29F176ABD;
	Fri, 26 Jul 2024 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tTi3CSYc"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C116745E4;
	Fri, 26 Jul 2024 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981356; cv=fail; b=d1HtYdoXPLpfCnzF0kIo68z+cXy6mJXPNDGea5+6APlDqlesbj4l3QaRHfJpX9aOCLWEa22mIOMsOwqZSQXLKF/ctUYzjRH7gc3QAFNx8Qvkw3a4nlG3i71Y+EUo5rGf3luDlqicJl5Ks93xXK9G1Cx1q+yYJLwfuDOs12mOShw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981356; c=relaxed/simple;
	bh=iseNWJwegzSXTYafRCwzI480a+ubzpoiVT/5d43JTqU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iIQadb9tbCJa6rhwyk/UF8oWjxTiCiMPOylPqTs+dZIAgsimmjK1Za36O17L2ZYuI7YJyftzVeqBW4SNtclD2E0vqEHD1ONB/iedAknuIuO47pMsX/UbsU2yWpbAfJ7C9Bx5zHzm7Ic4FYRqQrvnF2B8EICe0M5/GVMqL0APxo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tTi3CSYc; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oB6AOK0q3ITv31O3y2GthEQGAeT+hQUpcUdZhcqnaOscli0Q+S+yueN1RnWogc9/aSST+CoJCN36YN8iW7VrZ6HHwDSgEjJF1Zx/315J6L2tsMNco1njJnWTFTcQU65h8c0lX9WsxckkJE/lU0eccFLglZm7MtoIqL9gdnQuB65KdfxCyOllj55TmVyKDO86GjJo1RGUlr0YlUqwQEP1zgaogTD+ijeURsTrsMGd29flFc1L9LYA4XhCKxJ8ZKLjASmP4GpPYzPIwOg7s/m8FP2210fio9RoTb0YJeCpKZaEq6IqcRWnFJapfeZqoYtW/Qlyu+JQJvD8CxY63zijFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iseNWJwegzSXTYafRCwzI480a+ubzpoiVT/5d43JTqU=;
 b=rnQSJQnK43/v9nLm1PK47vg5LrSxleZeARhuKZCQ4AHZqZesbYGEVrFc2217e2H3jZNoRzNebLaj58MQUjLsJmv2CT3zNbbZ2LI9bZFgBqCevtZUOnMcB5PvEpgBoKeFGnOSVesUTsWQhDyPd5ys0BtZp0bh0KVDvdjNePKpOH3OzL42QhAE1P4Ey8QUcXwgeeDHP9MgnQocesHvB8Aj2w7CqpyruJ1YLWUudrGXuPOAVHvRyVhpR3BzdrarImenQdB3wkc18aGfg663efEL6Ca7KSIk5VvATEVhKO5woE5rKvS1Wp5WXkSCthRNT4j0DQL/YQ9o7vzzhBF/PbWIXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iseNWJwegzSXTYafRCwzI480a+ubzpoiVT/5d43JTqU=;
 b=tTi3CSYca4EbxeDMj7orz2eOHV/uaMXSCLj8pkq1NTLgQI92bzRSYKuQHWRlu5unFQh76taCfH7+WYH8SGEyQTgAsUahUAu3qmSfzSrDgyHMeFmASKvjcVsrRMGSiubPu1UAgQclzzdcnUyqRhmzz9R+/5OHaSeFGfKY4dfL6kN1rIz1MwUVl2ssQCseyVukohFvFaEDJQMrLepPdWjp1G0MDUXM8Efa4qxpBpZzpDibKIA2c+mMtHb23LfLRYR2R/t19Mrr/miYuk2/JUyXjxfvw4+hgoCd5xIveNC4xHOA9haXd9S7vpvscYUaRHGAPt+vCujt47NWvcBn5PjFBQ==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 08:09:10 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1%3]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 08:09:10 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "toke@redhat.com" <toke@redhat.com>, Tariq Toukan <tariqt@nvidia.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, Carolina Jubran
	<cjubran@nvidia.com>, "sdobron@redhat.com" <sdobron@redhat.com>,
	"hawk@kernel.org" <hawk@kernel.org>, "mianosebastiano@gmail.com"
	<mianosebastiano@gmail.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: XDP Performance Regression in recent kernel versions
Thread-Topic: XDP Performance Regression in recent kernel versions
Thread-Index:
 AQHawZQu7pYCTnvmyUq17tC6Eto8LrHPR9wAgAAvuoCAAPRZAIABv8wAgA4WlgCAIm0DAIABma4AgAHyOACAAqfMgA==
Date: Fri, 26 Jul 2024 08:09:09 +0000
Message-ID: <7aa360d4486155e811d045043704227276ab112c.camel@nvidia.com>
References:
 <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
	 <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org> <87wmmkn3mq.fsf@toke.dk>
	 <ff571dcf-0375-6684-b188-5c1278cd50ce@iogearbox.net>
	 <CA+h3auMq5vnoyRLvJainG-AFA6f=ivRmu6RjKU4cBv_go975tw@mail.gmail.com>
	 <c97e0085-be67-415c-ae06-7ef38992fab1@nvidia.com>
	 <2f8dfd0a25279f18f8f86867233f6d3ba0921f47.camel@nvidia.com>
	 <b1148fab-ecf3-46c1-9039-597cc80f3d28@nvidia.com> <87v80uol97.fsf@toke.dk>
In-Reply-To: <87v80uol97.fsf@toke.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (3.52.3-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|SJ2PR12MB7961:EE_
x-ms-office365-filtering-correlation-id: 3c89309d-b519-407c-29fd-08dcad4a3a7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VzBXMm16Nm5vdjVqTXphT2tXTVhyT3NOY3dWcGdpZkxuTHFhRmJOdzdFczZ2?=
 =?utf-8?B?SlJza2lET1JuTEMyU005QmJXay9uZk9HOXdIZ29MbU9CdmJnWUVHOGVITEJU?=
 =?utf-8?B?K1hiajNpdGNUNHRoU3h3eUtETmxVUHUvSG9mWm83UDJ6SzhiN1F1UHI2eWov?=
 =?utf-8?B?cG9sOEoxNVZXT0lHR3Jsak5GWGI5N2lZZUgrSXBXZUQzL002ZitLejFmN0F1?=
 =?utf-8?B?OFFNbjFMOTZBNXZtdTZrTVVqSzFnQTc4VlR5WkVMK085WnJKMkorUVcxNVBO?=
 =?utf-8?B?dVIzSGc4U3AxMHNmd0lqNUtTVExoUWMxNmVQdVZBZnMzdlN2eUZ6Y2ZYa0VJ?=
 =?utf-8?B?bkxaRDdUaU9Hc3hSeEdqNExzRXlVVEVUdDZOZjBqVk55elVuRUlBQytSTGFG?=
 =?utf-8?B?VTlJN1JMeWFyRHluUzBFd2dCZkxhMStSVHNSb1c3NHFHWE5jeXQ4b203RzJy?=
 =?utf-8?B?L1MxVnh3cERORjFyZVRGOFZFOENLWE80SFdLekdLU2xuOHFZUXBjMzA3TzVC?=
 =?utf-8?B?Rld1bm5rUVBQRnE0dHZYWi9SMzczTzNTZ3BWQUZNNHhjcXZXTmR0NG1QdU9N?=
 =?utf-8?B?cjhOVW03NDVRRGdjTU8yQTdKWUJUdmU1anU4WmhQaWtVTzJmVEJEQnQ3NWpG?=
 =?utf-8?B?NlVwT05IcEY5Sm9QSFluVitBWDZmUFpLREJyQm5OWWdMeWFlbnpaOGY3OFVY?=
 =?utf-8?B?L1ltNzlaMTNCNWJiMEI4YmQyVDB1ZDdRTXB4S3o4Rk9mTHkrTFFESDRJYkwy?=
 =?utf-8?B?RUZuTEZiRnhPZ1p0eU1wVkVZZmx4ZDIxdVk4TThjek9pR1RQdDdOVUNVS1U5?=
 =?utf-8?B?UmlvelR5clNXRlFORHBxeU9rUTMvQW4zc1NmeER4QktaN0FZcVhoSEFSWU9J?=
 =?utf-8?B?Tnkzb0R3U09MRlBpMmVsVFRHcUZqbE54bU5SVExHMXY1enhJR0tjTGxWb0No?=
 =?utf-8?B?SmxlZnFsRXA5YmdwMmJySHp5cWNFTXhjT3I4MVAvTnM3RUxySnBPVnhkcFNE?=
 =?utf-8?B?UTlucE9Eb2dkRTU2Tk1QblpvODdLcEllNVBieGdlQWNoeUpMRFlwZG9DS3ZM?=
 =?utf-8?B?bCsreEloeTdvZHZPR3RaNXZEZEtuanRlZ0czaFEyRS9UQk5VcXJMS3dGbUpZ?=
 =?utf-8?B?enhtNWZKcS9pUzYyc2l5SWl2VjE3V3AvY3N5U3JwamJPbU5JcTN2UHA4dE90?=
 =?utf-8?B?MW1iVmV2MStwZWdCV0RQSGxWb25lcHEzNTdaMGttOHgrZkpzVlNJVUZvaVhX?=
 =?utf-8?B?UGs2UVFpMHlzSVQ0NDhqK3p5a2N5LzczY2prRVl4NnNrNllvWTFObksrKzdt?=
 =?utf-8?B?dzZYelQ5UnJhUnFBV1dwZXczdGVRY3JabnBvS2ZvbFdVTERVd0ZhNkI4Z294?=
 =?utf-8?B?Vk8veGdyQy8wN1hybTRBKytUNXdKMkRPZVJPS0hMYXFVdDhCbkZjUzVQMElW?=
 =?utf-8?B?dlZUM2NURC94WHc4M0Ixb1ZkOVpMWlpLa0JVVkNJMEJ0dkdyUUM1QWl5MDI5?=
 =?utf-8?B?bFZsMHg3ODRsRUpPOGZma29XLzc5V09HM1hTWVdrek9BN3Ivd3hSaW4zUXE1?=
 =?utf-8?B?RndjcXA0c2YreTBNMjBpSW1WWWtNTnk3OEUzM3h0Vmk3ZnpPZkcyZlRWbWdQ?=
 =?utf-8?B?T2t5aDFINHJNajhVTENNY0daam9ONlpTRGVWZWNDdjBrQkt4SllpdFlOUDA3?=
 =?utf-8?B?VU9qY1dETERkdVdxRXJuT25HVXp6UXo4dVV1S2VjTkRxcGYzdUt1dWxVcDhv?=
 =?utf-8?B?V3FjUzRMbDVOL0VYWUsrM2JlT0EwMUdYK2hSeGhMSTltKzZ5elRsOWxXaDgy?=
 =?utf-8?B?WGVFQTZLejNyZ2VzeWJDNnNMRTI5bzZuUHhvV29FQ3MxV3ZpTmNBakJwQjJB?=
 =?utf-8?B?a3FmYXJjbzNoM1FYNGsyNDZEUUtrRktuMy9oS1F0dHlXZXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1dwN2Fxc3l0ck9IQnQwM2tPRm5TeXcvQ3Rac3JMekRpc1R0MjRpUU9aaDZE?=
 =?utf-8?B?OERIKzYzRFVCVzhjazNTSmdnL1RjclB5UXJFK3pqbmliMkdaVEROaWRYNUZD?=
 =?utf-8?B?NGdsTmh2azlzUnN6OFN6SzBIWjlJMWNjNWtzT0kyOVhQaXZuTzhTK2R2a1hm?=
 =?utf-8?B?cUtIcTgvU3d2YXBKeWQvNUFEa2tzWHVqeUtRSXlqejJmTzNuVXNVdkhUSC9J?=
 =?utf-8?B?RmdzNldwVXIwQ1BCUGx5aU5RTGlTWTNtSUEyYzJIQzUvWVBpeUw5L01IZW5U?=
 =?utf-8?B?akNPemdETGptUTRnbE5sSDI5UjFLb1hJS21PMTFsamlIK1FSdkVKNkgybEpj?=
 =?utf-8?B?T01qSlNKbHBYTFZUdndlSENrSUFjSm51L3luQ3loTE9VM3pwRG5iWVVadk1o?=
 =?utf-8?B?QmxPeEJNZ0FaeUp5aFJ6TVV2Ri9EOEJzWEVPNnU5dWEwcWhqaXl6MFhZczNR?=
 =?utf-8?B?b2RpV0FRV0l1K1Z2ajFqWjl0NmV2MVhiUm1neU9JT0s4RG1VZGZ1TmNwMnow?=
 =?utf-8?B?dldDZ0lMY1lyMWVZYzBFZUpJdlFVM0p2dUVkWlYvWTJ0N2N4cUcrWWI3UVB1?=
 =?utf-8?B?dFNWL3VIOC80aW1kTzRCQXAvRC9RcVMwdXF6N0Q4N1JmcU5VNGtGTWZEbFRC?=
 =?utf-8?B?MXY1ZzlVRDEwVVU5NnpWNUR4TC9pdEd0Ny8xdkxNNHJBcTlyaHhJeVY0bDVS?=
 =?utf-8?B?MEwrTjZwQ0FDTnlmd1JOTXZEeHFORmE3MnFuVXhjRlRMTHJUMFAvL2pPRFFO?=
 =?utf-8?B?MEVjSXhuZWFzeWgvVVUzc1N0WFZtREkwK2s4UWRoTWNHNUVaN1RXTUpvcGFD?=
 =?utf-8?B?RCt6eGsvSzRFSlJ1SUR1RzVMNEhISW9JeW9ibnFqLzlvOVZ0c1dCK1c2TXZk?=
 =?utf-8?B?TWNnc0pjZzZyL0d3aUUwbDlaaDIraGZtcWI0a1MrYWhpSDZxeFh1QWdhQnJ1?=
 =?utf-8?B?MFBFY1BvcnE4K0xlNEgvREJNeHVVRC9KYzIvVWt1SENoR3R0VFZoNnJoVjdy?=
 =?utf-8?B?SENsb2dta0xuaVpTVXFhYmF5QXpVbzRWUnl4cFA1OXViditnSjJybnNiaVdp?=
 =?utf-8?B?MXpua2FwcCs0b2RlZm9RWmkyTlNrZUprelZaWUFUVThYWHlTVlpRem1naXRB?=
 =?utf-8?B?WGpIN0doTEI5TGRUVjQyUUVyVXdPdDZMR0F4WTh2UlArSTZNUXQySklueUs5?=
 =?utf-8?B?ek0wc0dSYzRNeUtQRUxiWU9uUmVvTHB4RkZ1bEs1SmhTSDlDeDN3ck5DUG5w?=
 =?utf-8?B?SjJkQWkzdjF1Y2EzNXVuTTE4eVkwOUR0RThRcTJ1Qjg1SFRDeGMxQlNVOXN6?=
 =?utf-8?B?QnQ4L1hOMks4cnpZa3FPWlRML2dScTNpKzByU3IzSHE5Z1UzSUMvV1QyMU8x?=
 =?utf-8?B?Z0VVUWRWNFV0T2xYamg4d1RxTjJGc05LeWNSemFBRWNJUEhLVlI2SXpkRWRD?=
 =?utf-8?B?VnVuY1d6NFdhVnJhT0k1MG85Z1d5Sklnb1dURm5vUkdtWFZVUmxZUnpnbDV3?=
 =?utf-8?B?NmxhM0VWNjJyL204TnNoOWN2aUpIY252NHgyYlQxaXJTRG9HWTUxRFFkUnJU?=
 =?utf-8?B?ejZPaFUyZ1c4MzlCT1U1bFIvQ2VWbkJla21ySHNzeWR5L3FSbjJxVjdIbXhZ?=
 =?utf-8?B?dTlNaGdPL2N1bllKMGdhdEl2cW5tS1FySHRqdFlSUEpDVkNvSVpQZCsreCsz?=
 =?utf-8?B?cnJ4VkNVZEtKMXBKUC85YVZRUFRzdHZHZmVjUWRXUmxQS3FvUTdxNEVwNzZH?=
 =?utf-8?B?ZzVLVSs0enZMY1RVRU5lZWVtUjRYK0JJa3g4VkdjazlKUmZVZDhUb0o1NW40?=
 =?utf-8?B?ZFp6dlgvMDlZeFVPcVZGV2hPdDJjS0dRU1ptS3pibGVzZFVzS2tURTM3R2RC?=
 =?utf-8?B?TTFNVFN6Z3NHZk5BMzY1Z2M3dHpWWFBtYnZSRHJJOGMwNDNrb1VHRk5XWmxT?=
 =?utf-8?B?bzYxS1BVdTFSMXJEWEdkTDFSWDJFYW9wa2M3SnhGYW4vemcwc3gxTXdwSkpa?=
 =?utf-8?B?bmRtaytpNUFyOWhpN0gzWmpkVTB6YlZxNTZWOHF4cXFNbjJjY1BzK00zL1Q0?=
 =?utf-8?B?ZGdlSkF5S1lhUzJ2eGc4T0xXMmNaM2VaSVBEclRHUVZpVGN6ZlhVNXdSektM?=
 =?utf-8?B?Tm10dFQzMGlmelFtcTlwZ1hVTTE3K0p5UE94NkRKZmFveE8xbWFNU1Z2dFVC?=
 =?utf-8?Q?lfZCnR91ajjcoaBlwmpuvdz7o9C7oUtyXjxouzTFEoZd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AD6252400FF0545A682586C342BD272@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c89309d-b519-407c-29fd-08dcad4a3a7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 08:09:09.9896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7CjuCDzNyRmtITK9pxdsWsQ1vmCUc/14jP8OQtjHGgdr/OEOG939Exh+GQL7Eq8EmvxYtSVSFn6qMiVhafxe0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961

SGksDQoNCk9uIFdlZCwgMjAyNC0wNy0yNCBhdCAxNzozNiArMDIwMCwgVG9rZSBIw7hpbGFuZC1K
w7hyZ2Vuc2VuIHdyb3RlOg0KPiBDYXJvbGluYSBKdWJyYW4gPGNqdWJyYW5AbnZpZGlhLmNvbT4g
d3JpdGVzOg0KPiANCj4gPiBPbiAyMi8wNy8yMDI0IDEyOjI2LCBEcmFnb3MgVGF0dWxlYSB3cm90
ZToNCj4gPiA+IE9uIFN1biwgMjAyNC0wNi0zMCBhdCAxNDo0MyArMDMwMCwgVGFyaXEgVG91a2Fu
IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gT24gMjEvMDYvMjAyNCAxNTozNSwgU2FtdWVsIERv
YnJvbiB3cm90ZToNCj4gPiA+ID4gPiBIZXkgYWxsLA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFll
YWgsIHdlIGRvIHRlc3RzIGZvciBFTE4ga2VybmVscyBbMV0gb24gYSByZWd1bGFyIGJhc2lzLiBT
aW5jZQ0KPiA+ID4gPiA+IH5KYW51YXJ5IG9mIHRoaXMgeWVhci4NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBBcyBhbHJlYWR5IG1lbnRpb25lZCwgbWx4NSBpcyB0aGUgb25seSBkcml2ZXIgYWZmZWN0
ZWQgYnkgdGhpcyByZWdyZXNzaW9uLg0KPiA+ID4gPiA+IFVuZm9ydHVuYXRlbHksIEkgdGhpbmsg
SmVzcGVyIGlzIGFjdHVhbGx5IGhpdHRpbmcgMiByZWdyZXNzaW9ucyB3ZSBub3RpY2VkLA0KPiA+
ID4gPiA+IHRoZSBvbmUgYWxyZWFkeSBtZW50aW9uZWQgYnkgVG9rZSwgYW5vdGhlciBvbmUgWzBd
IGhhcyBiZWVuIHJlcG9ydGVkDQo+ID4gPiA+ID4gaW4gZWFybHkgRmVicnVhcnkuDQo+ID4gPiA+
ID4gQnR3LiBpc3N1ZSBtZW50aW9uZWQgYnkgVG9rZSBoYXMgYmVlbiBtb3ZlZCB0byBKaXJhLCBz
ZWUgWzVdLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE5vdCBzdXJlIGFsbCBvZiB5b3UgYXJlIGFi
bGUgdG8gc2VlIHRoZSBjb250ZW50IG9mIFswXSwgSmlyYSBzYXlzIGl0J3MNCj4gPiA+ID4gPiBS
SC1jb25maWRlbnRhbC4NCj4gPiA+ID4gPiBTbywgSSBhbSBub3Qgc3VyZSBob3cgbXVjaCBJIGNh
biBzaGFyZSB3aXRob3V0IGJlaW5nIGZpcmVkIDpELiBBbnl3YXksDQo+ID4gPiA+ID4gYWZmZWN0
ZWQga2VybmVscyBoYXZlIGJlZW4gcmVsZWFzZWQgYSB3aGlsZSBhZ28sIHNvIGFueW9uZSBjYW4g
ZmluZCBpdA0KPiA+ID4gPiA+IG9uIGl0cyBvd24uDQo+ID4gPiA+ID4gQmFzaWNhbGx5LCB3ZSBk
ZXRlY3RlZCA1JSByZWdyZXNzaW9uIG9uIFhEUF9EUk9QK21seDUgKGN1cnJlbnRseSwgd2UNCj4g
PiA+ID4gPiBkb24ndCBoYXZlIGRhdGEgZm9yIGFueSBvdGhlciBYRFAgbW9kZSkgaW4ga2VybmVs
LTUuMTQgY29tcGFyZWQgdG8NCj4gPiA+ID4gPiBwcmV2aW91cyBidWlsZHMuDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gICBGcm9tIHRlc3RzIGhpc3RvcnksIEkgY2FuIHNlZSAobW9zdCBsaWtlbHkp
IHRoZSBzYW1lIGltcHJvdmVtZW50DQo+ID4gPiA+ID4gb24gNi4xMHJjMiAoZnJvbSAxNU1wcHMg
dG8gMTctMThNcHBzKSwgc28gSSdkIHNheSAyMCUgZHJvcCBoYXMgYmVlbg0KPiA+ID4gPiA+IChw
YXJ0aWFsbHkpIGZpeGVkPw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEZvciBlYXJsaWVyIDYuMTAu
IGtlcm5lbHMgd2UgZG9uJ3QgaGF2ZSBkYXRhIGR1ZSB0byBbM10gKHRoZXJlIGlzIHJlZ3Jlc3Np
b24gb24NCj4gPiA+ID4gPiBYRFBfRFJPUCBhcyB3ZWxsLCBidXQgSSBiZWxpZXZlIGl0J3MgdHVy
Ym8tYm9vc3QgaXNzdWUsIGFzIEkgbWVudGlvbmVkDQo+ID4gPiA+ID4gaW4gaXNzdWUpLg0KPiA+
ID4gPiA+IFNvIGlmIHlvdSB3YW50IHRvIHJ1biB0ZXN0cyBvbiA2LjEwLiBwbGVhc2Ugc2VlIFsz
XS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTdW1tYXJ5IFhEUF9EUk9QK21seDVAMjVHOg0KPiA+
ID4gPiA+IGtlcm5lbCAgICAgICBwcHMNCj4gPiA+ID4gPiA8NS4xNCAgICAgICAgMjAuNU0gICAg
ICAgIGJhc2VsaW5lDQo+ID4gPiA+ID4gPiA9NS4xNCAgICAgIDE5TSAgICAgICAgICAgWzBdDQo+
ID4gPiA+ID4gPDYuNCAgICAgICAgICAxOS0yME0gICAgICBiYXNlbGluZSBmb3IgRUxOIGtlcm5l
bHMNCj4gPiA+ID4gPiA+ID02LjQgICAgICAgIDE1TSAgICAgICAgICAgWzQgYW5kIDVdIChtZW50
aW9uZWQgYnkgVG9rZSkNCj4gPiA+ID4gDQo+ID4gPiA+ICsgQERyYWdvcw0KPiA+ID4gPiANCj4g
PiA+ID4gVGhhdCdzIGFib3V0IHdoZW4gd2UgYWRkZWQgc2V2ZXJhbCBjaGFuZ2VzIHRvIHRoZSBS
WCBkYXRhcGF0aC4NCj4gPiA+ID4gTW9zdCByZWxldmFudCBhcmU6DQo+ID4gPiA+IC0gRnVsbHkg
cmVtb3ZpbmcgdGhlIGluLWRyaXZlciBSWCBwYWdlLWNhY2hlLg0KPiA+ID4gPiAtIFJlZmFjdG9y
aW5nIHRvIHN1cHBvcnQgWERQIG11bHRpLWJ1ZmZlci4NCj4gPiA+ID4gDQo+ID4gPiA+IFdlIHRl
c3RlZCBYRFAgcGVyZm9ybWFuY2UgYmVmb3JlIHN1Ym1pc3Npb24sIEkgZG9uJ3QgcmVjYWxsIHdl
IG5vdGljZWQNCj4gPiA+ID4gc3VjaCBhIGRlZ3JhZGF0aW9uLg0KPiA+ID4gDQo+ID4gPiBBZGRp
bmcgQ2Fyb2xpbmEgdG8gcG9zdCBoZXIgYW5hbHlzaXMgb24gdGhpcy4NCj4gPiANCj4gPiBIZXkg
ZXZlcnlvbmUsDQo+ID4gDQo+ID4gQWZ0ZXIgaW52ZXN0aWdhdGluZyB0aGUgaXNzdWUsIGl0IHNl
ZW1zIHRoZSBwZXJmb3JtYW5jZSBkZWdyYWRhdGlvbiBpcyANCj4gPiBsaW5rZWQgdG8gdGhlIGNv
bW1pdCAieDg2L2J1Z3M6IFJlcG9ydCBJbnRlbCByZXRibGVlZCB2dWxuZXJhYmlsaXR5Ig0KPiA+
ICg2YWQwYWQyYmY4YTY3KS4NCj4gDQo+IEhtbSwgdGhhdCBjb21taXQgaXMgZnJvbSBKdW5lIDIw
MjIswqBbLi4uXQ0KPiANClRoZSByZXN1bHRzIGZyb20gdGhlIHZlcnkgZmlyc3QgbWFpbCBpbiB0
aGlzIHRocmVhZCBmcm9tIFNlYmFzdGlhbm8gd2VyZQ0Kc2hvd2luZyBhIDMwTXBwcyAtPiAyMS4z
TXBwcyBYRFBfRFJPUCByZWdyZXNzaW9uIGJldHdlZW4gNS4xNSBhbmQgNi4yLiBUaGlzDQppcyB3
aGF0IENhcm9saW5hIHdhcyBmb2N1c2VkIG9uLiBGdXJ0aGVybW9yZSwgdGhlIHJlc3VsdHMgZnJv
bSBTYW11ZWwgZG9uJ3Qgc2hvdw0KdGhpcyByZWdyZXNzaW9uLiBTZWVtcyBsaWtlIHRoZSBkaXNj
dXNzaW9uIGlzIG5vdyBmb2N1c2VkIG9uIHRoZSA2LjQgcmVncmVzc2lvbj8NCg0KPiBbLi4uXSBh
bmQgYWNjb3JkaW5nIHRvIFNhbXVlbCdzIHRlc3RzLA0KPiB0aGlzIGlzc3VlIHdhcyBpbnRyb2R1
Y2VkIHNvbWV0aW1lIGJldHdlZW4gY29tbWl0cyBiNmRhZDUxNzhjZWEgYW5kDQo+IDQwZjcxZTdj
ZDNjNiAoYm90aCBvZiB3aGljaCBhcmUgZGF0ZWQgaW4gSnVuZSAyMDIzKS4NCj4gDQpUaGFua3Mg
Zm9yIHRoZSBjb21taXQgcmFuZ2UgKG5vdyBJIGtub3cgaG93IHRvIGRlY29kZSBFTE4ga2VybmVs
IHZlcnNpb25zIDopKS4NClN0cmFuZ2VseSB0aGlzIHJhbmdlIGRvZXNuJ3QgaGF2ZSBhbnl0aGlu
ZyBzdXNwaWNpb3VzLiBJIHdvdWxkIGhhdmUgZXhwZWN0ZWQgdG8NCnNlZSB0aGUgcGFnZV9wb29s
IG9yIHRoZSBYRFAgbXVsdGlidWYgY2hhbmdlcyB3b3VsZCBoYXZlIHNob3duIHVwIGluIHRoaXMg
cmFuZ2UuDQpCdXQgdGhleSBhcmUgYWxyZWFkeSBwcmVzZW50IGluIHRoZSB3b3JraW5nIHZlcnNp
b24uLi4gQW55d2F5LCB3ZSdsbCBrZWVwIG9uDQpsb29raW5nLg0KDQo+ICBCZXNpZGVzLCBpZiBp
dCB3YXMNCj4gYSByZXRibGVlZCBtaXRpZ2F0aW9uIGlzc3VlLCB0aGF0IHdvdWxkIGFmZmVjdCBv
dGhlciBkcml2ZXJzIGFzIHdlbGwsDQo+IG5vPyBPdXIgdGVzdGluZyBvbmx5IHNob3dzIHRoaXMg
cmVncmVzc2lvbiBvbiBtbHg1LCBub3Qgb24gdGhlIGludGVsDQo+IGRyaXZlcnMuDQo+IA0KPiAN
Cj4gPiA+ID4gSSdsbCBjaGVjayB3aXRoIERyYWdvcyBhcyBoZSBwcm9iYWJseSBoYXMgdGhlc2Ug
cmVwb3J0cy4NCj4gPiA+ID4gDQo+ID4gPiBXZSBvbmx5IG5vdGljZWQgYSA2JSBkZWdyYWRhdGlv
biBmb3IgWERQX1hEUk9QLg0KPiA+ID4gDQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9u
ZXRkZXYvYjZmY2ZhOGItYzJiMy04YTkyLWZiNmUtMDc2MGQ1ZjZmNWZmQHJlZGhhdC5jb20vVC8N
Cj4gDQo+IFRoYXQgbWVzc2FnZSBtZW50aW9ucyB0aGF0ICJUaGlzIHdpbGwgYmUgaGFuZGxlZCBp
biBhIGRpZmZlcmVudCBwYXRjaA0KPiBzZXJpZXMgYnkgYWRkaW5nIHN1cHBvcnQgZm9yIG11bHRp
LXBhY2tldCBwZXIgcGFnZS4iIC0gZGlkIHRoYXQgZXZlciBnbw0KPiBpbj8NCj4gDQpOb3BlLCBu
byBYRFAgbXVsdGktcGFja2V0IHBlciBwYWdlIHlldC4NCg0KVGhhbmtzLA0KRHJhZ29zDQo=

