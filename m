Return-Path: <bpf+bounces-76506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67858CB7CB3
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 04:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D2DC3007CA1
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 03:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E403E2D2499;
	Fri, 12 Dec 2025 03:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fyb4Ihn6"
X-Original-To: bpf@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF178242D84;
	Fri, 12 Dec 2025 03:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765510994; cv=fail; b=DCKsKV2ktjlc+PRV84IcM7iBZMEiKKT2wufp3QVUvYQgrW3eAHog7V3SZkpY/a9MZEC5Y1p/ZJBFjCi4feb+CgMpKec+lWNMu4wHtJ6SR5TWrH2MqDTTrFSBBXB3UsEPxooNuQTg6PMZ5PGfOpBwMebN3OKl65kmJr+Vt3xpIMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765510994; c=relaxed/simple;
	bh=/X3rzCL3cQ3RPoFnjL6sr8tyEFhwVIAEuSSwYzasU1c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gbt7aOiQdUyy+NMR0kRhT6ZY/J3L3Jf77pmUV2U/nZIIdM3jCzyyssOzBLXWYRDWM+W0kyNiIc+Jp7qUbcFGV8/PW8XGh4oRyxHAuLqB2nlDDDJv+vreusDixrtc1V0XOtydi2lB89XEGdWXOw833yA64DkQGgDikzC4bbLZa68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fyb4Ihn6; arc=fail smtp.client-ip=52.101.56.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmDAPp8hegeQKiNr/s0e8gIZB+hxdwd/seGLiQRr8XhbshsK4FG7RnR7v8DLwKeO3omChfJTqrg+VGfHXkYUxyLwvhBNjsN0a4TLkq4nJ9VNgKBnz53bb0GXRv8HvUHBUMqYl7XCKdYl92mx0XKih81b3XgypWD/L1M9YCsDk6CnwPMIuKSHL+v+4ZkqhCSOJdx8bbbyi8F/WX+I2Irm+GiSZlfGaCUfiHh7XbanqESDorfk2HebrGR7ASnoLvOJD/HQczWKDus/VjzkcM/UQyzrXZ+x/PoxOqDsrDkOvgMs9QBni+mltDkgSXa6w9J5+nMpoyUwOQ9avkmAGXs6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/X3rzCL3cQ3RPoFnjL6sr8tyEFhwVIAEuSSwYzasU1c=;
 b=lglQEdrHVHvh1GpBBSjksdBRECQFymGTwJCPsCWm310w8e+W+SjXuMb2FumDhYg1LcFrJeUcncWez4V8dQ+kIJ3bzZycHO+siJjl/3i6k4y2sBEGbeI2NrNEB1J1JjJz6ynYJjpjcmLd/LNUv9g24iLyNc2b7g8XxNX6NCJ+c3GM2Fs4Sa9lFHWQM6nlZ/Y27zwr1aU4l1MhXvVx40KhofeJFlz1JQ2OK5fLElgoPAzkpAdsE+ies2VbwLkBbC2d9T9IwdCh4JnNFH5BRCce+gqmXcHwTB5lsTkiQbh8jSJeB0cv/VHX9idYZesx3jrucB9cJmjBQPwdGNhj55yU1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/X3rzCL3cQ3RPoFnjL6sr8tyEFhwVIAEuSSwYzasU1c=;
 b=fyb4Ihn6XWpOtA24RdIWavn/GMEL+35PgOQs1u/pE0vIU3wS3EYyTETPdLNkhyCNdtK3apLx65ubKzPNOQrvzazybz1iRX93iQkzr1HQdnXQtKMSiB6AYyVPEL+PJNHJzGwM0/HIDhSPSBa38ZKQu66FIfXBJh4qZwlZDP8Fo4/iTzjGAN0AW4j5NI12k1H3CJEkTf8feuh3rHiyYwAM7VzNukgAkE4tp8fKFQHVTtPM2J3PXeC+tPgot5LO6AX4JCXz30i2ALZYM/khAelp+rf8wytuPV2GwzXLBdwZ4Ws5gTkDzJrwW5vFsJBFiWMVJYm7foHDoZ7tuzKSG0VDlg==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB6632.namprd12.prod.outlook.com (2603:10b6:8:d0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.8; Fri, 12 Dec 2025 03:43:07 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 03:43:07 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Steve
 Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Thread-Topic: [PATCH v3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Thread-Index: AQHcaWEJWse2oN3QYE+DLsuXp8aBkrUc31XkgAAF7oCAAD/igIAACeaAgAAxDkw=
Date: Fri, 12 Dec 2025 03:43:07 +0000
Message-ID: <C0D26D77-316D-467F-81C9-030D4E0EBCD8@nvidia.com>
References: <e2fe3162-4b7b-44d6-91ff-f439b3dce706@paulmck-laptop>
 <B5D08899-9C23-4FA3-B988-3BB3E8E6D908@nvidia.com>
 <febd477b-c111-4d5e-be89-cae3685853f5@paulmck-laptop>
 <bce9a781-3cc3-45d7-8c95-9f747e08a3cd@nvidia.com>
 <0ec97a2d-5aee-4214-b387-229e9822b468@paulmck-laptop>
In-Reply-To: <0ec97a2d-5aee-4214-b387-229e9822b468@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|DS0PR12MB6632:EE_
x-ms-office365-filtering-correlation-id: e3fe695a-ec1e-4a97-6852-08de39309021
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MmdKbGNoc1cvR0lzTVRpdkZNOWlRVlJCWURPMXZGVzAzMDVCTWRoT2hTVDlo?=
 =?utf-8?B?Z0RVRi9qY0J3WGdNcVFBUXIvV0JjREpDMENEc2x2eXRvbDM3eVZ6WDBQQUN3?=
 =?utf-8?B?dE1HSTZxaEFoRGlON2xDNi9pUERjcFJrUldCeG5iYTFJeFltazZBMDZCQmpa?=
 =?utf-8?B?YmJ1ZWtzdlFIR1kwbTU3dmUvU2lHakRBekN1SFFTNXZHZG5ZaXd1UVNYd3ZD?=
 =?utf-8?B?cXdBUnRFMGdId2REZ2R0cGMzZWxxdUdZT3ZaNkd4SVBSY09XR0M2NmlrL1FL?=
 =?utf-8?B?WHcwMSs0YnhHN0V3QVlJU0NjbXNTZCt2VjZSTFlodVByM3RUT0hEUkJ4cjF5?=
 =?utf-8?B?bk11YUJSRy9PQ2RZQUxJNWU3T1dERllucW0zWTFtRDAxelFHMTMyV0lpV2tw?=
 =?utf-8?B?U040NHFMUk90NmRaajRnNVRXS3A4cjRONkZueGVQSzN4VUhaSVk5dHdRYUtT?=
 =?utf-8?B?OWZuRHhERGF3MytZa1R3dG1Kb1lFMVUyRnJJOERzdWZRdVhBT2Q5UGM2cnJJ?=
 =?utf-8?B?eS92cXRWTWFzMDNiSDJuelNuWThLQlVteG1FdEdLOWhzZjZBL3pkc1c0Mzdh?=
 =?utf-8?B?bnR2RjdZWGx2dkZvajV2a1h1aUlQNlVUVjR0Q2FHd2l0SVZObTIwakY1NkN2?=
 =?utf-8?B?Z0xqbzBZZXJrT1FSaGZqWXd4dVp5UTViWUxQbHAwN2dmOWdDQVBiZkZmSjQv?=
 =?utf-8?B?SVBHQTRoUHhVbWlORkZrWWhWQWlTeExsWmdOamd0MVpKTjAvdVlUcU5uRHpi?=
 =?utf-8?B?NjNGZHpwRnhJZFVQNnlwcDQ3aVF5ZmlVYmp2QkRIdmdTQkxJcTM3SFBpMFVa?=
 =?utf-8?B?d0o1WGNJK1Nza3hPSVNHVzZSQWFLaC9CVUo2bXluMlNEd0Q3bUpENGlJRURw?=
 =?utf-8?B?bUNjdGoxaXFrdldYWmNxdklhN2NWdjdNZU9tbDdTZFFGL2xQTjZLNCtqZnVR?=
 =?utf-8?B?SVRTWi9rNnJOTnNoNjgvbWhyTzh0MDlFcnhmTExwVU1lRzROL2pSSlcwUVN6?=
 =?utf-8?B?LzdyOFZGSTVKRnpCSHRQbVI2cklqc2lvdWZuNWtIYlJjRlQrTWJQaXpIYmow?=
 =?utf-8?B?OUxwUGRZS0ZEaFVsdnFoNUNYWm0yTVlQMmRjVGlLNVJ5c2R4VFlBWjlQTVhF?=
 =?utf-8?B?QkJKMFZuWTEvY2szM0JRYk5XTkM0YysvY2gyd1k4N1ozRTNaRzdQZXdBcU41?=
 =?utf-8?B?ajc3RnB2alVSTE13SUo5dkhIOUdqYmxwNHZSUGRDZjV4bXM3MGFIazV1dGwv?=
 =?utf-8?B?MXVRbnhUYkZFSUp3d2xNQUFFK3R2dFZWWUxOYVhJODE5YjlXQ0kwcURONnpX?=
 =?utf-8?B?d1ppQXYxeHdqQ3JUalJlUEsyYlZERjYxSWxHajg4dHFVeVFKbEtYcG1jT2FE?=
 =?utf-8?B?cklUbFRqT1FBNmFiazBUekFTc2h0N1lBaHEwQWZuYkVnNkZDaGlGVy9EcmVm?=
 =?utf-8?B?WVNDb1lzcElWTE9qcGkzQTdCdktQTTRtK3VNaXlEYWhCRm9tMG5rbVluUHEz?=
 =?utf-8?B?TFRqcUV4RW1SUGdJWFBDT1RFWldNbkhsRkh6TlBiODFTM3JrM3lyUS8vbWc3?=
 =?utf-8?B?ZGFiTE1KTlJxWHBVQ0FnOTQvdVlOdTNrQVFMdE5qaGhoUDRFaitib1F1MFBz?=
 =?utf-8?B?TWJub2Uzbk5lVUNNUTlOdVpxblVnUi8xdUpTcTRZSDQ2NW1Sa0FJM2l3R0Q1?=
 =?utf-8?B?d0lodG5FanlsUzdxQUNvSS9qNDVNR1ZvdXU0dHN5VkRjZnd3cXRZS2tnbEUx?=
 =?utf-8?B?T2tndW9Xc0p6VEkyVHBmWHBxeFBMOUZGcFMrSHVtMUErSklYQ2dadEdDQi9s?=
 =?utf-8?B?aHNNUmJEUzVXUVI5OE9pWll6MHlhNUkyMlRhVTFPS1ZHb0JKdGszbTRRSXEw?=
 =?utf-8?B?NEI4M3hzdS9rOEZvUTZSMFhiK0IzcjZFRE5oYmd6aVA3c3M4VjNZWW9QUCt0?=
 =?utf-8?B?UG9tazFmWmt4czQxeVBYcGkyM3N6dG5qcUpLSXUvZWFDRlZrVlFZYnpXZVI2?=
 =?utf-8?B?QmlkNWNTR29qb0Z2Tk8xN09OMkw3RkpLSWtwVEx1RktKS1ZXS2FhWlloUUhp?=
 =?utf-8?Q?FdoxmH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzhTdHdtdUpjcHlxWGxsMFlGUGpUTDJEMVNybXJ3T3lzNWJKUlZkTEFRTzE2?=
 =?utf-8?B?eFh6QkhPWFQ3U1hERFFoS0txN1VpRzkvcU51TXdYbmJSdHZBNExnOFJDWkZy?=
 =?utf-8?B?aGhnZFJXcmlsOWdWblJDSzduSWRWVWdMUmtrZFNMWGtNUGlTNjJOT3dhaCtX?=
 =?utf-8?B?SXlJeEFsUUQvcnQ1eTFDaDhjVnhlS2llSDFJZm1JQ2pPTDROd2I3ckpvYzJX?=
 =?utf-8?B?b2cvaitVaHFxekFsVHc4VFBPUTUveEM1cHZQQzh0V016WXhWWUtlUHdXZEdZ?=
 =?utf-8?B?VWg4d3RQUUZuMHFJN00vVzE4bk1WV042U2IzSTNxMHpIbDhNQmxqT0IzN1do?=
 =?utf-8?B?NlhPMFBhRmJxamplMEpGOHR4WFYzbnlpVWc2ZWdiVDBIQzNqaGVhS0Y2dUlz?=
 =?utf-8?B?Z1FyMExSZ2l4dW9ERURjR01JSHVtakI4K1lWeW80emhtOWoyTmRDQzhNRklt?=
 =?utf-8?B?aVVyQllXbzVBanVrNzNzQndIYVRldDIzTDlxNjV3bTV2NFhEK2ZQTml3N2VS?=
 =?utf-8?B?bnVLS0tXMGFEeThoM09WT3JYbTNHSXZWTEpmUEZ3M2I4ZkxoTitoRS9DcndV?=
 =?utf-8?B?dm1SVFFmN0FVMUlObEJTRmlNNHRQY0J4OXdTS1VReTR4L0xZZHlNajN6ZXg5?=
 =?utf-8?B?OERIc2hKVFFMdld6YXE5OEQxalp6WkJzM2syTVY3QkoxanY3Q1dxKzh4Rkdw?=
 =?utf-8?B?aGtDZllSblcyOXlMY1Ixd3YvU1k0VjZPUk0vbVRRWFphTFhyMHpVZHdBbnc2?=
 =?utf-8?B?NENQbmd6cjNlVXkzYW8vbVNuSTBOSTNBaFpjZTRidzR2bUI5VEtKcGlxanV0?=
 =?utf-8?B?NFBvaHpZbEhPK1JaWXpBYm42TEhrbHQ3eUN4c1RGTG96SnlaZmIwcko0bFlX?=
 =?utf-8?B?UmFLOEtZbkcyT1BoY2tqNXdjZFk0dkVDK203SWl4eTFwdndiOE1LYzZBTXdm?=
 =?utf-8?B?L3YxUUY1UlZJWm1tbUlJQXpEeFZDa1ZDS1UybWd1L25kdjBWWTQ5M1lxODha?=
 =?utf-8?B?c085QzFwZjAzdGJ1NEpRTzlyYUtKVEpKQ0dheG56Z2haN3kwRGQreGtUaTRS?=
 =?utf-8?B?SzdVQW51T2dRemFKb1JVK05kTVhrK3k3K1hQamd3MTdNWGpGOGNpMUovYVVH?=
 =?utf-8?B?b1VOY1U3Vk1QR3ltMFUxMC9zVk1WOFk4TTFBaEJ2dXFxcmNJdVJRK3NoR0o4?=
 =?utf-8?B?bXI5U1RoK0F6UC9qZzJ0TzNIaWYwZ2VkRGFQb1ZSU044VUlHWGFDVnNWeXQz?=
 =?utf-8?B?c0poZGNEQXB0aTJQMnh1ZnZ2WFRVSDZXUFRuUnlEMzB6dkg0cjVDaG5WNGVU?=
 =?utf-8?B?blpvKzMxMFF2c2UwcTdHeDVPc09xUXljYnlCRk50V2R3dmZ5cEs1blBJL21s?=
 =?utf-8?B?cHRMYUNBM1QzYWR3cGRTcjBLV1lYb25mUVJRVThjVUNWNHhFM1VNYVBxelds?=
 =?utf-8?B?cDhWR3FoWFRHU1ErWTg0dHVHaElFRVhTc0tLMmY2QVVJNllqTGhKTkRWVjFj?=
 =?utf-8?B?dlRFK3JVQXFQMzdFcmdidUFySVBnSDUvSXV6dExwdkRNcDA4aE9HL01qSENI?=
 =?utf-8?B?QjlLbWxiWWZ4a3JrcnZuMk1ORURCRjBLbHNmR1JlaldkczZRU29TekVxKzFv?=
 =?utf-8?B?TkE2aUU2TUdkYWVXRHphbTRwT2JFR0FiNng4R2l3a3Nsb2VMRE5sKzkvcUxI?=
 =?utf-8?B?T0tjbU50NzZrNEQ0M25xajdoOGRZVHU1d01zd09HMHhGQjJnRTNnT0l5RGc4?=
 =?utf-8?B?NC9xWnZsVE9sQWw0cjZRdEo1anE3bDZBRlgrY2w2bkNSRnFQTTBJeXlGQVI4?=
 =?utf-8?B?UWgrSmpBYVM3UmlxWXAvQjc4Y3R4dW42dGdHN2FGNVp4ZlNodkJVYVRBZGpF?=
 =?utf-8?B?N1JvRHdLcDAvcXhZaG1PT0NBdFF1NzZ0dldQYVdRbFl2Y3pkUzEwZVRydGli?=
 =?utf-8?B?UGFFU0ZjTDdNNHJPd1g5YTBqaDJweDRDNzFJUzY3ekl3akRRdk13cUpGS0s1?=
 =?utf-8?B?aWlTSDU5emF6dTRTRlpyLzNlL0pLdmNYanMxdy9iem5obTRZcnRrUVFybU5S?=
 =?utf-8?B?cXcvaGVhMW12WGtpRWN6OE1POFJmM29uTzBOMTZuWElacmZHakY0UWRHdkhL?=
 =?utf-8?Q?3+nZBNo6viww5qoJKdEn2nYHE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fe695a-ec1e-4a97-6852-08de39309021
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 03:43:07.2178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9bB7BEoz7QTkotVjBl5ai41LbIJ67gQRVxuV/H4tavfREx7M2kmxvOsAibPJS+4HheBK4mW4WQscdIudd3e1Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6632

DQoNCj4gT24gRGVjIDEyLCAyMDI1LCBhdCA5OjQ34oCvQU0sIFBhdWwgRS4gTWNLZW5uZXkgPHBh
dWxtY2tAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBGcmksIERlYyAxMiwgMjAyNSBh
dCAwOToxMjowN0FNICswOTAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToNCj4+IA0KPj4gDQo+Pj4g
T24gMTIvMTEvMjAyNSAzOjIzIFBNLCBQYXVsIEUuIE1jS2VubmV5IHdyb3RlOg0KPj4+IE9uIFRo
dSwgRGVjIDExLCAyMDI1IGF0IDA4OjAyOjE1UE0gKzAwMDAsIEpvZWwgRmVybmFuZGVzIHdyb3Rl
Og0KPj4+PiANCj4+Pj4gDQo+Pj4+PiBPbiBEZWMgOCwgMjAyNSwgYXQgMToyMOKAr1BNLCBQYXVs
IEUuIE1jS2VubmV5IDxwYXVsbWNrQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiDv
u79UaGUgY3VycmVudCB1c2Ugb2YgZ3VhcmQocHJlZW1wdF9ub3RyYWNlKSgpIHdpdGhpbiBfX0RF
Q0xBUkVfVFJBQ0UoKQ0KPj4+Pj4gdG8gcHJvdGVjdCBpbnZvY2F0aW9uIG9mIF9fRE9fVFJBQ0Vf
Q0FMTCgpIG1lYW5zIHRoYXQgQlBGIHByb2dyYW1zDQo+Pj4+PiBhdHRhY2hlZCB0byB0cmFjZXBv
aW50cyBhcmUgbm9uLXByZWVtcHRpYmxlLiAgVGhpcyBpcyB1bmhlbHBmdWwgaW4NCj4+Pj4+IHJl
YWwtdGltZSBzeXN0ZW1zLCB3aG9zZSB1c2VycyBhcHBhcmVudGx5IHdpc2ggdG8gdXNlIEJQRiB3
aGlsZSBhbHNvDQo+Pj4+PiBhY2hpZXZpbmcgbG93IGxhdGVuY2llcy4gIChXaG8ga25ldz8pDQo+
Pj4+PiANCj4+Pj4+IE9uZSBvcHRpb24gd291bGQgYmUgdG8gdXNlIHByZWVtcHRpYmxlIFJDVSwg
YnV0IHRoaXMgaW50cm9kdWNlcw0KPj4+Pj4gbWFueSBvcHBvcnR1bml0aWVzIGZvciBpbmZpbml0
ZSByZWN1cnNpb24sIHdoaWNoIG1hbnkgY29uc2lkZXIgdG8NCj4+Pj4+IGJlIGNvdW50ZXJwcm9k
dWN0aXZlLCBlc3BlY2lhbGx5IGdpdmVuIHRoZSByZWxhdGl2ZWx5IHNtYWxsIHN0YWNrcw0KPj4+
Pj4gcHJvdmlkZWQgYnkgdGhlIExpbnV4IGtlcm5lbC4gIFRoZXNlIG9wcG9ydHVuaXRpZXMgY291
bGQgYmUgc2h1dCBkb3duDQo+Pj4+PiBieSBzdWZmaWNpZW50bHkgZW5lcmdldGljIGR1cGxpY2F0
aW9uIG9mIGNvZGUsIGJ1dCB0aGlzIHNvcnQgb2YgdGhpbmcNCj4+Pj4+IGlzIGNvbnNpZGVyZWQg
aW1wb2xpdGUgaW4gc29tZSBjaXJjbGVzLg0KPj4+Pj4gDQo+Pj4+PiBUaGVyZWZvcmUsIHVzZSB0
aGUgc2hpbnkgbmV3IFNSQ1UtZmFzdCBBUEksIHdoaWNoIHByb3ZpZGVzIHNvbWV3aGF0IGZhc3Rl
cg0KPj4+Pj4gcmVhZGVycyB0aGFuIHRob3NlIG9mIHByZWVtcHRpYmxlIFJDVSwgYXQgbGVhc3Qg
b24gUGF1bCBFLiBNY0tlbm5leSdzDQo+Pj4+PiBsYXB0b3AsIHdoZXJlIHRhc2tfc3RydWN0IGFj
Y2VzcyBpcyBtb3JlIGV4cGVuc2l2ZSB0aGFuIGFjY2VzcyB0byBwZXItQ1BVDQo+Pj4+PiB2YXJp
YWJsZXMuICBBbmQgU1JDVS1mYXN0IHByb3ZpZGVzIHdheSBmYXN0ZXIgcmVhZGVycyB0aGFuIGRv
ZXMgU1JDVSwNCj4+Pj4+IGNvdXJ0ZXN5IG9mIGJlaW5nIGFibGUgdG8gYXZvaWQgdGhlIHJlYWQt
c2lkZSB1c2Ugb2Ygc21wX21iKCkuICBBbHNvLA0KPj4+Pj4gaXQgaXMgcXVpdGUgc3RyYWlnaHRm
b3J3YXJkIHRvIGNyZWF0ZSBzcmN1X3JlYWRfeyx1bn1sb2NrX2Zhc3Rfbm90cmFjZSgpDQo+Pj4+
PiBmdW5jdGlvbnMuDQo+Pj4+PiANCj4+Pj4+IFdoaWxlIGluIHRoZSBhcmVhLCBTUkNVIG5vdyBz
dXBwb3J0cyBlYXJseSBib290IGNhbGxfc3JjdSgpLiAgVGhlcmVmb3JlLA0KPj4+Pj4gcmVtb3Zl
IHRoZSBjaGVja3MgdGhhdCB1c2VkIHRvIGF2b2lkIHN1Y2ggdXNlIGZyb20gcmN1X2ZyZWVfb2xk
X3Byb2JlcygpDQo+Pj4+PiBiZWZvcmUgdGhpcyBjb21taXQgd2FzIGFwcGxpZWQ6DQo+Pj4+PiAN
Cj4+Pj4+IGU1MzI0NGUyYzg5MyAoInRyYWNlcG9pbnQ6IFJlbW92ZSBTUkNVIHByb3RlY3Rpb24i
KQ0KPj4+Pj4gDQo+Pj4+PiBUaGUgY3VycmVudCBjb21taXQgY2FuIGJlIHRob3VnaHQgb2YgYXMg
YW4gYXBwcm94aW1hdGUgcmV2ZXJ0IG9mIHRoYXQNCj4+Pj4+IGNvbW1pdCwgd2l0aCBzb21lIGNv
bXBlbnNhdGluZyBhZGRpdGlvbnMgb2YgcHJlZW1wdGlvbiBkaXNhYmxpbmcuDQo+Pj4+PiBUaGlz
IHByZWVtcHRpb24gZGlzYWJsaW5nIHVzZXMgZ3VhcmQocHJlZW1wdF9ub3RyYWNlKSgpLg0KPj4+
Pj4gDQo+Pj4+PiBIb3dldmVyLCBZb25naG9uZyBTb25nIHBvaW50cyBvdXQgdGhhdCBCUEYgYXNz
dW1lcyB0aGF0IG5vbi1zbGVlcGFibGUNCj4+Pj4+IEJQRiBwcm9ncmFtcyB3aWxsIHJlbWFpbiBv
biB0aGUgc2FtZSBDUFUsIHdoaWNoIG1lYW5zIHRoYXQgbWlncmF0aW9uDQo+Pj4+PiBtdXN0IGJl
IGRpc2FibGVkIHdoZW5ldmVyIHByZWVtcHRpb24gcmVtYWlucyBlbmFibGVkLiAgSW4gYWRkaXRp
b24sDQo+Pj4+PiBub24tUlQga2VybmVscyBoYXZlIHBlcmZvcm1hbmNlIGV4cGVjdGF0aW9ucyB0
aGF0IHdvdWxkIGJlIHZpb2xhdGVkIGJ5DQo+Pj4+PiBhbGxvd2luZyB0aGUgQlBGIHByb2dyYW1z
IHRvIGJlIHByZWVtcHRlZC4NCj4+Pj4+IA0KPj4+Pj4gVGhlcmVmb3JlLCBjb250aW51ZSB0byBk
aXNhYmxlIHByZWVtcHRpb24gaW4gbm9uLVJUIGtlcm5lbHMsIGFuZCBwcm90ZWN0DQo+Pj4+PiB0
aGUgQlBGIHByb2dyYW0gd2l0aCBib3RoIFNSQ1UgYW5kIG1pZ3JhdGlvbiBkaXNhYmxpbmcgZm9y
IFJUIGtlcm5lbHMsDQo+Pj4+PiBhbmQgZXZlbiB0aGVuIG9ubHkgaWYgcHJlZW1wdGlvbiBpcyBu
b3QgYWxyZWFkeSBkaXNhYmxlZC4NCj4+Pj4gDQo+Pj4+IEhpIFBhdWwsDQo+Pj4+IA0KPj4+PiBJ
cyB0aGVyZSBhIHJlYXNvbiB0byBub3QgbWFrZSBub24tUlQgYWxzbyBiZW5lZml0IGZyb20gU1JD
VSBmYXN0IGFuZCB0cmFjZSBwb2ludHMgZm9yIEJQRj8gQ2FuIGJlIGEgZm9sbG93IHVwIHBhdGNo
IHRob3VnaCBpZiBuZWVkZWQuDQo+Pj4gDQo+Pj4gQmVjYXVzZSBpbiBzb21lIGNhc2VzIHRoZSBu
b24tUlQgYmVuZWZpdCBpcyBzdXNwZWN0ZWQgdG8gYmUgbmVnYXRpdmUNCj4+PiBkdWUgdG8gaW5j
cmVhc2luZyB0aGUgcHJvYmFiaWxpdHkgb2YgcHJlZW1wdGlvbiBpbiBhd2t3YXJkIHBsYWNlcy4N
Cj4+IA0KPj4gU2luY2UgeW91IG1lbnRpb25lZCBzdXNwZWN0ZWQsIEkgYW0gZ3Vlc3NpbmcgdGhl
cmUgaXMgbm8gY29uY3JldGUgZGF0YSBjb2xsZWN0ZWQNCj4+IHRvIHN1YnN0YW50aWF0ZSB0aGF0
IHNwZWNpZmljYWxseSBmb3IgQlBGIHByb2dyYW1zLCBidXQgY29ycmVjdCBtZSBpZiBJIG1pc3Nl
ZA0KPj4gc29tZXRoaW5nLiBBc3N1bWluZyB5b3UncmUgcmVmZXJyaW5nIHRvIGxhdGVuY3kgdmVy
c3VzIHRyYWRlb2ZmcyBpc3N1ZXMsIGR1ZSB0bw0KPj4gcHJlZW1wdGlvbiwgQW5kcm9pZCBpcyBu
b3QgUFJFRU1QVF9SVCBidXQgaXMgZXhwZWN0ZWQgdG8gYmUgbG93IGxhdGVuY3kgaW4NCj4+IGdl
bmVyYWwgYXMgd2VsbC4gU28gaXMgdGhpcyBkZWNpc2lvbiB0aGUgcmlnaHQgb25lIGZvciBBbmRy
b2lkIGFzIHdlbGwsDQo+PiBjb25zaWRlcmluZyB0aGF0IChJIGhlYXJkKSBpdCB1c2VzIEJQRj8g
SnVzdCBhbiBvcGVuLWVuZGVkIHF1ZXN0aW9uLg0KPj4gDQo+PiBUaGVyZSBpcyBhbHNvIGlzc3Vl
IG9mIDIgZGlmZmVyZW50IHBhdGhzIGZvciBQUkVFTVBUX1JUIHZlcnN1cyBvdGhlcndpc2UsDQo+
PiBjb21wbGljYXRpbmcgdGhlIHRyYWNpbmcgc2lkZSBzbyB0aGVyZSBiZXR0ZXIgYmUgYSByZWFz
b24gZm9yIHRoYXQgSSBndWVzcy4NCj4gDQo+IFlvdSBhcmUgYWR2b2NhdGluZyBhIGNoYW5nZSBp
biBiZWhhdmlvciBmb3Igbm9uLVJUIHdvcmtsb2Fkcy4gIFdoeSBkbw0KPiB5b3UgYmVsaWV2ZSB0
aGF0IHRoaXMgY2hhbmdlIHdvdWxkIGJlIE9LIGZvciB0aG9zZSB3b3JrbG9hZHM/DQoNClNhbWUg
cmVhc29ucyBJIHByb3ZpZGVkIGluIG15IGxhc3QgZW1haWwuIElmIHdlIGFyZSBzYXlpbmcgU1JD
VS1mYXN0IGlzIHJlcXVpcmVkIGZvciBsb3dlciBsYXRlbmN5LCBJIGZpbmQgaXQgc3RyYW5nZSB0
aGF0IHdlIGFyZSBsZWF2aW5nIG91dCBBbmRyb2lkIHdoaWNoIGhhcyBsb3cgbGF0ZW5jeSBhdWRp
byB1c2VjYXNlcywgZm9yIGluc3RhbmNlLg0KDQpUaGFua3MsDQoNCiAtIEpvZWwNCg0KDQo+IA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBUaGFueCwgUGF1bA0K

