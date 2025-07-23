Return-Path: <bpf+bounces-64167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E15CB0F40F
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 15:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3128964935
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 13:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFD82E7198;
	Wed, 23 Jul 2025 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ciKEKoJS"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6422E7F28;
	Wed, 23 Jul 2025 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277575; cv=fail; b=SI2vpdNIn2quXSLE0yuKFF4rSQHtGAwk3VtwCxQMNF+uGHvdMKie3d3ZeFcXCDJdaDpoiuDLMqvGLaNhasjuNcBjH08XZ4CNJU15fHqfVYTcMvXDxdl99levpd03eggRzlO6Q2jZryR0UFKkRR4/tKifubFtEwsXfOcda5Q8m1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277575; c=relaxed/simple;
	bh=/qtAPQ7RcnfP3xbuaPMzHd7A0pUymuZnRd59aCVxMjU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PmPBOHdUBOpoN8UK/Y5B/A4NT5EeFLL5ukC4O6Vfq6Go5f593WbFkQk6LMO0SaLttkWEZ7ViXIwjf4XX9t3wgQcd37LR3dsOdTSOKdZzVRno7QalZMn2W3q1IS8cRVjmSZa85zUtcxYpo0FowwA9V9aqqr2LY/U/KevggbZGkqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ciKEKoJS; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ut7EEpPe/xYqqJox5b0yU6oNJXZ4t6+Gjlj5qrhHHbXGzhqmBVY6A/qV++s3eEApOAproDLC2lcOTC4uOSVt37OqwjiuhE8g16KaoShdWFevPiok3QnZ9DKX4fI0Q5b64TnqXw56MtYkfIWpBaNq7zYKtX+XoLXUr29VwGvkJMGG9qkIvhhhQ0ukKB50R3ZuVMvLsA5yNMbpDyC2UoNk169z/DR6PnCVaz3XdlN8TX0IsNwCHRIfZjwBor7iBcgv2p4CJJJROHmJg7lIbJ+B7Ob3+MjnOYC7fOnsjxMDqRhn+tHB1Cnmv6F5cYBDQOO/zspZhb8cQ3g2Fgk+ryHmiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qtAPQ7RcnfP3xbuaPMzHd7A0pUymuZnRd59aCVxMjU=;
 b=EnZRASEiL1nS6HeYoIWeq47qG5IYa+nCeQqp32vbECzKyfT8EXpopjAXPf7F9qCup+JrbHeKTob/73ikfmMYdVW+sjYPRwd8fQBoQr1RgqT7YscoflZWqCdoO+9f8js8Py7PzCOHE0j9XuLXAiZfOB9dPpxs3GZ+lv5BctqIXTzo857Sts+ONBZTMJjY1fI5uK0yWqMRdrI/RqoWPwSYVbbxlEkEQTxxkeR5QFfXvi7Ycxh+6g24Yi4WEfrgu6Kr/OeW+EFpkQBvokSkv4pcMY/7Aym/8AW9nvN5H9S76USpS2RYklPrxEtcsXNPSPIunmL0+lA20EmKl01Qz7uarg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qtAPQ7RcnfP3xbuaPMzHd7A0pUymuZnRd59aCVxMjU=;
 b=ciKEKoJSrInvdSFvjR71u2AQwRxM8PTUfnpgmx7tJjaAeBp8YhHp8qnHsvG0oHb9RNt8x2t79UQBEpKGYcrU5jmG2K/yUjkK/xAGmCRWPYjNYz+DZqiaRELrQ2cWa8rMqgLSjEZ94pIO8YOa1VmtASsZgbgByMUOFUWuHCbU6/qCYy4oQfIwznairH+EgmGDRLGiRmMACZ3uPTlLj7JKcd6A90JVjaAG1m9pyu05sM9+MjM0e5F3M3dSimBd9Fy0IiAlxnL7YoxbRNC6oYZnspnfnBcwPk+1mxiZl+6SBaezfKci2QtS6K50lPHIjzrzga4MVyZPAlW8TPr9iwLEQg==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Wed, 23 Jul
 2025 13:32:51 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8943.028; Wed, 23 Jul 2025
 13:32:50 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 5/4] srcu: Document __srcu_read_{,un}lock_fast()
 implicit RCU readers
Thread-Topic: [PATCH v3 5/4] srcu: Document __srcu_read_{,un}lock_fast()
 implicit RCU readers
Thread-Index: AQHb+1ZdFw8cKN8KDUemU1sVi4tWEbQ/tdgA
Date: Wed, 23 Jul 2025 13:32:50 +0000
Message-ID: <9FAE52D6-D073-43D9-93D3-3E49006943B2@nvidia.com>
References: <ce304859-e258-45e7-b40f-b5cacc968eaf@paulmck-laptop>
In-Reply-To: <ce304859-e258-45e7-b40f-b5cacc968eaf@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|DS0PR12MB8525:EE_
x-ms-office365-filtering-correlation-id: 361260f7-f3e1-48cc-d050-08ddc9ed6bb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFc1TWs1VzlZd3QxVmI5ODgra1J6SURnK2NuR0RBQko4elFVOFo0TWRRTTdk?=
 =?utf-8?B?UWgwTFQ4UENPTnlpTCsrbkFjRXJLT0pLVXpNVjdESXZrMVlLWCtUaDNIRFQx?=
 =?utf-8?B?M1FsajRpOUFTaTVJOThZOWk2NUd0V1VNQ2pycWxNdHFENWJuNzFuL1hyREJx?=
 =?utf-8?B?d005Y3ptMlFOWXJFU3NzNysrcCtEbzhRd2Jha3djNFM2b0lQSEtaK2xTVnlt?=
 =?utf-8?B?NWtJa0dpZEJCazFMc0M3QVlzQklhVWtraUs3bHA4cWNpWExhNDJodDhneEFw?=
 =?utf-8?B?ZFQ0dFJvb2Z3ZTZkaFJIMDBpVmMxeVpWVEs0QmtzWlpLaDY2Q2NTS25abytX?=
 =?utf-8?B?bGZleEdoZVY5UW1oRitIdGQ2c3dIZ2dLRDZTaUVmVElsUG40OEcyclJ2MGNI?=
 =?utf-8?B?VDd6UU1JS2xMVmJEdkhCTzF5TmxkNFRpUjB2L2xmei9tOXN5bHpIalJ6SlNT?=
 =?utf-8?B?cms3UHRFSEQvWjVpaEpTVmxSN3RBREpGYXE2byt2dHVRRjVnL1BtazEyMVdn?=
 =?utf-8?B?Z1JwZGV1V2tyT3hjKzV0Z0VncENkTUVQS3MwNnV6MUprMG5wOGdlWkxpWWJD?=
 =?utf-8?B?RFlVSVpqMzMrV2Y5VERxRXJsYUJVOWlhY09wNVZpQjkwdkdxcU03QTJEY0NX?=
 =?utf-8?B?eXpYN3BQeUxkRzNYVy9oUE5uTTdBdm9tZVpHM1FLQSswNUE4UHBXUHVuUzlR?=
 =?utf-8?B?TEVYM3ljMUdDTmZBd3dpNXMzVUN2dWFlYWpYQ29vZDVlZUNNMStlaGdKaDJq?=
 =?utf-8?B?RGpqTysxTis5UnNia1BqanVkTktWYmJwRm5Dek1jWGgwUnZPMTd3YlhqRzBx?=
 =?utf-8?B?aFJHUTkzMWZORVBraHpSWURLcklaYXlFbkRzU0sxNFVIL2lZTUdZRnBKaU9V?=
 =?utf-8?B?SlFWZGhvakx2amdKWjJ1d1kxMDJNRmd5dlJUTFFIK293RE1JL3hkdXFZNTNi?=
 =?utf-8?B?cnJsUXVSU1hTT2pDMi80bnlEbGdnVm9Ja3ozeFkyVFlhUVpxMWE0eUxsR1RK?=
 =?utf-8?B?Y2RYeXVQNUtwRENhbWdTZ0czVEIwd2hHdHpKV29XaTJ1VzR3Y2N4RERyMDl0?=
 =?utf-8?B?bExqa1RibThCcWJ6MWtCTlQwQ2E1N0YvWTI0OThoK3I3bDhrQXVmdkhqYXdl?=
 =?utf-8?B?NXBHSlBNengrNGZzUWpqTnB0ak5STnQrUkxma2kwSnpYYy9nNFJWQk9YVTQ0?=
 =?utf-8?B?VVlKQ2NlUUVzTjZUY3p1d251dVcvdmt0QXdLY2p0Mk1aNmpyVXU2R3RKWmxz?=
 =?utf-8?B?b2VvY0k4Tno3dmZxQTNKNFJmMnZ0N1RoVDEveHpVZXNBcHRJV2JoZGQ2RWIv?=
 =?utf-8?B?c0w2MHAyMkZJN2tZNWJkUmVrbUYvbGgxdWRnVmYyMnp6Umk0aW50NzBZVnl3?=
 =?utf-8?B?aDIvNzNIQjhneVg3S2tvRmUwdlI5bGgwbDhNYTRwREk4a0dJUUZZK3ptRXNE?=
 =?utf-8?B?cURla09yOVBNdmVVWXJ3eDdvcFg1MUZRaDhpcDZpbkxkeDM1TlR0NlJ3VHN6?=
 =?utf-8?B?UjlkYW50WnVXME1FQmx6UkE2QXcrYjFCWENTMW15NTlEVGx2RzBDSGsrejRr?=
 =?utf-8?B?SGREYS9aL0RJaVBGUDZvV2pNajFlMndrZnpqV3UvZUZ6STdMZmNCY2s3TTlH?=
 =?utf-8?B?a0JJbEEzcWgzeUhvcjUxMTV0UFZZUC9QWkNWNmswem5vR0oxbHY3NGs2V0tY?=
 =?utf-8?B?V3ZxZnh0QnNnWW1xTHdjZE1BMUh3NGZmQlI5elIvSms5Ym0vbGFxUFd4TXc5?=
 =?utf-8?B?R3dEeHVCcmptNGJCVGNHYndVMlE5aWRPUkUvVlhGblBjbWRJS21lYW1OQmVF?=
 =?utf-8?B?aURmZEJZNjY3R0NyeUxOSlRpcS83SndyZUxEMjVsNkNaOStEcTRVelVDY0dm?=
 =?utf-8?B?b0g3WW00R1ljYWNyajdOaWp4eDlHQW1PRmwrNjRjZ0RQL2JuTjN1ME1NbnRv?=
 =?utf-8?B?NGFkbmRNSWl6aDhOYkZuMzVOM1Z4OEl6ZElFcHdYV1hnem9iNGVtdEpITEJl?=
 =?utf-8?B?eVF6cHRET1d3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXBRV0NoeVNKcUhZbmZsbUY2NVdqMDRQU3Jrak8xWGhMdlpJdkk0R0dibXdG?=
 =?utf-8?B?bGVmajlWVmpGeDhWL2xyNGE4TEo1ZTA2V0lNTTh2eHdOYlFmY1Z0c09McWJm?=
 =?utf-8?B?OHJ2TVQyc1pnbmVnV0VYblVXRkxvbE80M2xHc1lMemM4RzN3eWxxc05yTGRx?=
 =?utf-8?B?NWx3VjA1NEdJeVJuVVQwTk82amhsZnB5MG1TUlpFb1oxR093aXIwRGVxSzBM?=
 =?utf-8?B?UWordjNGN0VzU1BHQ1hVSEJLSFFTUU94QUkyMnF2R0c0eXp1d2dUWkhoQXls?=
 =?utf-8?B?KzRwU3NhWXdyKzRWV01VWENXNXZPV0cxQlhEbEFyV1VMeUdhdmdMa0lFNTRC?=
 =?utf-8?B?cGFnUDViUngvMGtxTUJOMmNUZkt5ZmdmWjQrbHdzdEg4QlJUazA2ODgwOFZO?=
 =?utf-8?B?V0w2MCtEK2tvWVViNE8rL1lrSWJaU1JobDdWMnl3OWVBK0k0bHR3bWI5MWJD?=
 =?utf-8?B?MXZ5R0tlYmJHZFd5V0pSRVNJNXVreFU3VW5vUGhYbk1GV1NjR1NhUHRSbzBK?=
 =?utf-8?B?RHpsdzFMdkI2b2hLQkNoYTV4RXYwZ0VmTFoydFVuSG13OExhbjZtQm5pbmFO?=
 =?utf-8?B?d3Q1VGNLbTRBZmR1SWg5akhlZzRKYVlvNmhWNmVwdW1RSlBMb05GWTBvUjdh?=
 =?utf-8?B?aFBnRk16cnM2anFhck53Qnd2NUhSWnpuTDc2OC9BbXVwYklzendndGtvbTFa?=
 =?utf-8?B?ZTc0RXBvamJBZ1NhdVpLRFA4c05ETy9pZnRWdjNGVFZDTENLZThKanUxRVU2?=
 =?utf-8?B?bE5CalI1KzlvbU0zT1B3c2ZrQmNQcEJZc3BBcFBZNzJyS0RRUGtuK3UxV1Jn?=
 =?utf-8?B?a0dQenFIazRtWlgvRmd4cXdEQWhwbXRSSVZIMHZodmthK0ZSaGJmSWh0bnN0?=
 =?utf-8?B?MUgrZVFqMVE2M3JseWN5bjhUSjRVdlpQRDJYd3FuTmpnSE1VazZTSys0TGxR?=
 =?utf-8?B?Rzl5UlFDcUpuWElpVUtFTEUwUTc1MTRxc3RCRUJXamoyd3JaTEQ3eHNGUVBm?=
 =?utf-8?B?OTlSdlpzei9POGhBOXBOZjgzdW9ndFYwcURYYWh2QWM0TjMyTVVaRStzRnpK?=
 =?utf-8?B?L1hlZlJMYnNUQ3NGdFJwYkVKVkFYc0lIQnphdGpxODlkbEdnUVhnaGFaRjBX?=
 =?utf-8?B?cm5Ya0xGdnBzY0JrRW8vVHFkTlJnNDZDK1NjMVZwdVVpeUtoeU81ZUdnUmk0?=
 =?utf-8?B?MitiNjRVSFVpVnBSQkRzZVhITXhERiswOGdMV3lJMU9xL3FzTjRSalE3M3Nl?=
 =?utf-8?B?ZDNRUmRiNE5Oazd5NTB6QXFhKzVYYkR2cWtsaUhWK05vaW9jakV4RmQyK2Vh?=
 =?utf-8?B?Mmx1R1l6aTNqTWs2T3ExWU5pQk1iZkF5Zlo1RkdKUVZhTDhkTUpwS2xDdlNr?=
 =?utf-8?B?Ym4yNWp1YlV1anZraG90cXo5bEQ1Q05naHQrOFoyeklsVnJZNk5YZjdZZ3ly?=
 =?utf-8?B?V2ZmM0FCSkc2QUNmaTNMaktnRys0ZStIV05sY1UwNVZoOWgxMmFxSjIxQ0xJ?=
 =?utf-8?B?S08rdm1Dd3VQSkJKWXRGRFBPNFRtalNvVjBlMU4zNmsrTTFzSkMrYjBPNlRN?=
 =?utf-8?B?dVBMYkJzVUdIbm1ETU5GZ1lSbFJUcFBuNWU0SWdLWU91U0VZRDJLOVNvOCtF?=
 =?utf-8?B?cHUxbjQ5d2kwTnRoNTNOQjhkeW8rRHhqUkN1dUtJcFdETzhwdGpuZmJmU3Jo?=
 =?utf-8?B?SVk3NVZuamQyWXIxaGR3bVlTSmhieU5HSE5aNURBOFB2TlNBUDk0ZDE0eGVs?=
 =?utf-8?B?V3RwVlUwcnBmdDJIanljNkJid3YwNWxoZmZpdEpQbnh5VVpsNHdoWUpoNVV4?=
 =?utf-8?B?TnVCSms4Z3BLYWpMa0tXdTJJYnkvY1JWckdiaEpQNHJlWktmRWh5d1ZKZ2Z5?=
 =?utf-8?B?UFhwZFRrckY1bHdyQmxoSm9pNDJwT25QMlRpbTl5RXZmK2RDc3hkbEVXaWVk?=
 =?utf-8?B?dFVURkhoaktqYkFiRUNvT05HNFAyVTdJQytaakYwYkZEdjJRb3AxZ05wMy95?=
 =?utf-8?B?N1c1ZzBBMU51ZTFmeGp4ZVRJQkR5R1RUTjFkaU05VXZ6dUdEY1ZJd1lyOTU2?=
 =?utf-8?B?QWZPMzVVVDFIalQwbG1TZGhiSkEwa3VLNFRRMDlQYXVjMUUxN29IRzJHTjBP?=
 =?utf-8?Q?l0DXCqrPbpFV8jW+4Xu+9m/1C?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C8D4EE5409A5C41BFCD801343BE7D02@NVIDIA.onmicrosoft.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 361260f7-f3e1-48cc-d050-08ddc9ed6bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 13:32:50.7613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJRit5Bv9C0W+GwhEvy7GcvJeeHkghebv5y1C/8VJMDdes6vIef9glHsR2/kCm2nfkQQLqqbVPwbWrkWkSXuVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525

DQoNCj4gT24gSnVsIDIyLCAyMDI1LCBhdCA2OjE34oCvUE0sIFBhdWwgRS4gTWNLZW5uZXkgPHBh
dWxtY2tAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79UaGlzIGNvbW1pdCBkb2N1bWVudHMg
dGhlIGltcGxpY2l0IFJDVSByZWFkZXJzIHRoYXQgYXJlIGltcGxpZWQgYnkgdGhlDQo+IHRoaXNf
Y3B1X2luYygpIGFuZCBhdG9taWNfbG9uZ19pbmMoKSBvcGVyYXRpb25zIGluIF9fc3JjdV9yZWFk
X2xvY2tfZmFzdCgpDQo+IGFuZCBfX3NyY3VfcmVhZF91bmxvY2tfZmFzdCgpLiAgV2hpbGUgaW4g
dGhlIGFyZWEsIGZpeCB0aGUgZG9jdW1lbnRhdGlvbg0KPiBvZiB0aGUgbWVtb3J5IHBhaXJpbmcg
b2YgYXRvbWljX2xvbmdfaW5jKCkgaW4gX19zcmN1X3JlYWRfbG9ja19mYXN0KCkuDQoNCkp1c3Qg
dG8gY2xhcmlmeSwgdGhlIGltcGxpY2F0aW9uIGhlcmUgaXMgc2luY2UgU1JDVS1mYXN0IHVzZXMg
c3luY2hyb25pemVfcmN1IG9uIHRoZSB1cGRhdGUgc2lkZSwgdGhlc2Ugb3BlcmF0aW9ucyByZXN1
bHQgaW4gYmxvY2tpbmcgb2YgY2xhc3NpY2FsIFJDVSB0b28uIFNvIHNpbXBseSB1c2luZyBzcmN1
IGZhc3QgaXMgYW5vdGhlciB3YXkgb2YgYWNoaWV2aW5nIHRoZSBwcmV2aW91c2x5IHVzZWQgcHJl
LWVtcHQtZGlzYWJsaW5nIGluIHRoZSB1c2UgY2FzZXMuDQoNCk9yIGlzIHRoZSByYXRpb25hbGUg
Zm9yIHRoaXMgc29tZXRoaW5nIGVsc2U/DQoNCkkgd291bGQgcHJvYmFibHkgc3BlbGwgdGhpcyBv
dXQgbW9yZSBpbiBhIGxvbmdlciBjb21tZW50IGFib3ZlIHRoZSBpZi9lbHNlLCB0aGFuIG1vZGlm
eSB0aGUgaW5saW5lIGNvbW1lbnRzLg0KDQpCdXQgSSBhbSBwcm9iYWJseSBtaXN1bmRlcnN0b29k
IHRoZSB3aG9sZSB0aGluZy4gOi0oDQoNCi1Kb2VsDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBh
dWwgRS4gTWNLZW5uZXkgPHBhdWxtY2tAa2VybmVsLm9yZz4NCj4gQ2M6IE1hdGhpZXUgRGVzbm95
ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+DQo+IENjOiBTdGV2ZW4gUm9zdGVk
dCA8cm9zdGVkdEBnb29kbWlzLm9yZz4NCj4gQ2M6IFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3Ig
PGJpZ2Vhc3lAbGludXRyb25peC5kZT4NCj4gQ2M6IDxicGZAdmdlci5rZXJuZWwub3JnPg0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc3JjdXRyZWUuaCBiL2luY2x1ZGUvbGludXgv
c3JjdXRyZWUuaA0KPiBpbmRleCAwNDNiNWE2N2VmNzFlLi43OGUxYTdiODQ1YmE5IDEwMDY0NA0K
PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NyY3V0cmVlLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9z
cmN1dHJlZS5oDQo+IEBAIC0yNDUsOSArMjQ1LDkgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3Qgc3Jj
dV9jdHIgX19wZXJjcHUgKl9fc3JjdV9yZWFkX2xvY2tfZmFzdChzdHJ1Y3Qgc3JjdV9zdHJ1Y3QN
Cj4gICAgc3RydWN0IHNyY3VfY3RyIF9fcGVyY3B1ICpzY3AgPSBSRUFEX09OQ0Uoc3NwLT5zcmN1
X2N0cnApOw0KPiANCj4gICAgaWYgKCFJU19FTkFCTEVEKENPTkZJR19ORUVEX1NSQ1VfTk1JX1NB
RkUpKQ0KPiAtICAgICAgICB0aGlzX2NwdV9pbmMoc2NwLT5zcmN1X2xvY2tzLmNvdW50ZXIpOyAv
KiBZICovDQo+ICsgICAgICAgIHRoaXNfY3B1X2luYyhzY3AtPnNyY3VfbG9ja3MuY291bnRlcik7
IC8vIFksIGFuZCBpbXBsaWNpdCBSQ1UgcmVhZGVyLg0KPiAgICBlbHNlDQo+IC0gICAgICAgIGF0
b21pY19sb25nX2luYyhyYXdfY3B1X3B0cigmc2NwLT5zcmN1X2xvY2tzKSk7ICAvKiBaICovDQo+
ICsgICAgICAgIGF0b21pY19sb25nX2luYyhyYXdfY3B1X3B0cigmc2NwLT5zcmN1X2xvY2tzKSk7
ICAvLyBZLCBhbmQgaW1wbGljaXQgUkNVIHJlYWRlci4NCj4gICAgYmFycmllcigpOyAvKiBBdm9p
ZCBsZWFraW5nIHRoZSBjcml0aWNhbCBzZWN0aW9uLiAqLw0KPiAgICByZXR1cm4gc2NwOw0KPiB9
DQo+IEBAIC0yNzEsOSArMjcxLDkgQEAgc3RhdGljIGlubGluZSB2b2lkIF9fc3JjdV9yZWFkX3Vu
bG9ja19mYXN0KHN0cnVjdCBzcmN1X3N0cnVjdCAqc3NwLCBzdHJ1Y3Qgc3JjdV8NCj4gew0KPiAg
ICBiYXJyaWVyKCk7ICAvKiBBdm9pZCBsZWFraW5nIHRoZSBjcml0aWNhbCBzZWN0aW9uLiAqLw0K
PiAgICBpZiAoIUlTX0VOQUJMRUQoQ09ORklHX05FRURfU1JDVV9OTUlfU0FGRSkpDQo+IC0gICAg
ICAgIHRoaXNfY3B1X2luYyhzY3AtPnNyY3VfdW5sb2Nrcy5jb3VudGVyKTsgIC8qIFogKi8NCj4g
KyAgICAgICAgdGhpc19jcHVfaW5jKHNjcC0+c3JjdV91bmxvY2tzLmNvdW50ZXIpOyAgLy8gWiwg
YW5kIGltcGxpY2l0IFJDVSByZWFkZXIuDQo+ICAgIGVsc2UNCj4gLSAgICAgICAgYXRvbWljX2xv
bmdfaW5jKHJhd19jcHVfcHRyKCZzY3AtPnNyY3VfdW5sb2NrcykpOyAgLyogWiAqLw0KPiArICAg
ICAgICBhdG9taWNfbG9uZ19pbmMocmF3X2NwdV9wdHIoJnNjcC0+c3JjdV91bmxvY2tzKSk7ICAv
LyBaLCBhbmQgaW1wbGljaXQgUkNVIHJlYWRlci4NCj4gfQ0KPiANCj4gdm9pZCBfX3NyY3VfY2hl
Y2tfcmVhZF9mbGF2b3Ioc3RydWN0IHNyY3Vfc3RydWN0ICpzc3AsIGludCByZWFkX2ZsYXZvcik7
DQo+IA0K

