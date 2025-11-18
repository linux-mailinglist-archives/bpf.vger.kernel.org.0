Return-Path: <bpf+bounces-74992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3857AC6A965
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 17:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E225F4FA8FC
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 16:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF2B365A10;
	Tue, 18 Nov 2025 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="FH2uIfWU"
X-Original-To: bpf@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010034.outbound.protection.outlook.com [52.101.228.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE07036CDE2;
	Tue, 18 Nov 2025 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482450; cv=fail; b=ps2cOVY/15KJb+sR6vZxn54jb0ZafyuiaPCtrU3bFcYrbQUydGGn0VCIjw28l8jFcXpkdOFbGisVeC6qW+8Ur2z5Hk6xVzyQzvxmwyFGvLp/n6sE5Crmns0R/QOMAIFTcqK+HC+V7H+Yex8UyPFwi53jC075cABIZBtHYQ3SdRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482450; c=relaxed/simple;
	bh=u9r87n15KPH2372WYCoNrY8TdvnM74u/PQpyM1CyLV0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RmdrzDwM6G5u8GR6d945Dnq3fBKcMs503cU8h5QJqk73B4aWd9szhQmZMmRjGreTTKbZlApOP2mtnsGIfjHO5zTMVXZ4BVyzkS+iZPRAIkLROwiNLspofYw6qD3aJ/bI3lxFg0MZ8xjfy3sMmvj+BYlDaxf/6cq6w/EQ2EzUCS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=FH2uIfWU; arc=fail smtp.client-ip=52.101.228.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVoq50PVgNGFEzDZbe3VdLbYRIx8u4y7JTcZSbC/AW3+i4ECC92iSHKPljCX0RJBypjQfjv5GOHOGV41thVpEScPcFKqmLmvD9XeB/b2dQeIyM+0VDKuPIxTrDWIE7rCa+IrUTCrkRG5eUJr/ssm4WnEvUm+aLv+Qg77YR1F4PlBF8cQ0m982dASPTL7VRibQi8VX01TYnGsF3WAFNHnEsAnmBsbs8PezZXggvk9oXLkORnlAlTiRN9NNcUXlb1MWZr4bw/bwMWCR5TCo9HBDdFvjCtg+cm9hlHXKuSAhUqqvLszFNmbRzfMU3dBSrjfTbKpaRAM09AhlXUR3saXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxbBmJBpyzuAPBHFmhLBPLL/qpKqcUhLIcFCwuRde6I=;
 b=H/K6hRjPx1HIWCbfg/o0beSVfI7vhxjsumhHFXidhwRvYvuDkNI+IBhSEaPMgD04BeYhd0lsWv6cisqI4iH1fIDCjpF+3h+AIR6nOrxpb0vbv21kkqmGXpsK3treGiBNAw20lx5cZRfkIiZqdyNzGlVl7fgcUMJQ5Jjg3AfPqsTfO1nZW2M0A3Cl3tVVoxu+1apHiDDy7Tq35EzVu+/6cbSoEbZrmg7tlZPoUpF+ipT0T/e5TLL3mqd6o0E0ulIM94WaZStG61mI1Hdqb/aVk5JCBUS/TW3n/3HLQeEibVhKK1xzmDD9i3QC9ZflAqh3t3wxgLRgZ4gUnY476//KCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxbBmJBpyzuAPBHFmhLBPLL/qpKqcUhLIcFCwuRde6I=;
 b=FH2uIfWU0XMZQDCDnZ8PtkIpU+j2GMX9GRgAgbkmOedTzPZYIw1LnCFE0ynA3CTZSWwqYba/mRLlm+p2mFHSHCa+B/yIEbBUQR74cO8HU0Q33GuoLSEyVVTQ1S165ZWw/y95aDeko3yYW0mL264I+76JOogjKYvRlFJf4riuL7k=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB15020.jpnprd01.prod.outlook.com (2603:1096:405:25c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 16:14:02 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 16:14:02 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "vishal.moola@gmail.com" <vishal.moola@gmail.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "hch@infradead.org"
	<hch@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"urezki@gmail.com" <urezki@gmail.com>
Subject: Re: [PATCH v3 0/4] make vmalloc gfp flags usage more apparent
Thread-Topic: Re: [PATCH v3 0/4] make vmalloc gfp flags usage more apparent
Thread-Index: AdxYpgG2R8Ke9P80QDCbhLvsa+PIeA==
Date: Tue, 18 Nov 2025 16:14:01 +0000
Message-ID:
 <TY3PR01MB11346E8536B69E11A9A9DAB0886D6A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB15020:EE_
x-ms-office365-filtering-correlation-id: c6b81d0f-e422-44d3-b53e-08de26bd7cf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PP1G+pgcAXopQ6LvifBjq/JoYwzidnyyrXMs95orRGTrh0UR8OPcJQ4qvlzi?=
 =?us-ascii?Q?mZC3dfEK0WV4lv8XCDTzq2OhnD7kWfN8ef9zSYV/FiAhus4k2rIdBSsUG9Sf?=
 =?us-ascii?Q?pTr4/6w8WjCUleRRAzvwdaBOLkpRdeON+2VjjcquKZfX8qmyZs15/uHRJ4p9?=
 =?us-ascii?Q?5jWmJkVtlnX694fmOwDnNNyzI629xQE7emZPxfYAEavqhQV7xVsI+vJxRLHl?=
 =?us-ascii?Q?/3ZUu5J48rstY3kcjm7IPIfiu+bX5F2AA6zzRH3sk+e8ItIYnR0ySg5IvDVT?=
 =?us-ascii?Q?KhYGByDc428axDHMbj0iQBuc/PmWX9lb9wLx9BjzSU2Jmt6Zu7YB/5hozVeO?=
 =?us-ascii?Q?jJ5660I7IjAMrbsYw/bn782mfRBWnZ+AC/TcmdDyeAvPzL3o0HZBXdGjWUDx?=
 =?us-ascii?Q?eFWuedAed55olCt/dJqQVrYiSqtumbvSg76lcfj+NwKlLY6vDqBcnE1dIcQn?=
 =?us-ascii?Q?lfQyjC15U3oFR9NvTNOtl0LnT6r3mMCMinQtnMB7DEB/MhbuGZNuRt1u1LkE?=
 =?us-ascii?Q?MsuW9QJIqzGlA4Dri2jmaxjafOK1kWm57XbkLuztDAcmXFMKwXzZowETjXMz?=
 =?us-ascii?Q?CsaCpLAOSdetz9Zvw1WDPHShro730RXKOOBnaXgvpa3/tgSdXceUYXVIxnB4?=
 =?us-ascii?Q?v7H8tzujF0Jf2wUAX2/cQlqmCb1SFZnHM65IVRVwxETHFbgUr5j5orMlMAbP?=
 =?us-ascii?Q?Pzrz458JD5Fr/oJMaCNOU9KxTwWyQW3AkFgNVSsgc/QDM335M6x7/RHlDH7x?=
 =?us-ascii?Q?Xpjsrj6x/b9Xc6hu+Q3rRgMFnIgNyFzNFRbHPMWNJXghDoO0G/7VCAgVwRcq?=
 =?us-ascii?Q?0/8p0OJdePqg6svKXGj/+CrLjs30AphOejfqxwm8IfY/h/nJ1GFe1+sHRmWX?=
 =?us-ascii?Q?yY/7zbt3+4cXA4275gccMvHxWlf24w54QaX+GekBlb7tSeb7x0wjQ3chI5oh?=
 =?us-ascii?Q?UNMhdL2w5RR8qpOmiNF9nwRBmG8VfhgKNfjy4SHBOBQ5LP/jBFRiTk0bSi7H?=
 =?us-ascii?Q?JunhnhRkk+KidrW7aSsSyxDuAdcu97a273kTN1X9DRnrCmNQOEJMi/fomD6S?=
 =?us-ascii?Q?KFRqBURGnQOcPHExpRxWR9t7tMhzKSCZmAq+ZGSgNV9ePjDrBHM4/jgixB3B?=
 =?us-ascii?Q?e5IoxVWrShHVk9yyiOr0lWPPyhmFdYgmFE2OgoCd7ABAQ5jd7PJUURf8WHyP?=
 =?us-ascii?Q?CcvwpixymzGIFx85LAh4ypAmNhoYg9uM5fPj5Fqdnl5p33K+YcVtPTybqNN1?=
 =?us-ascii?Q?+24ojQ52d40iDbTxKGKK9fiLKDsJdGpJyS7pe0G6rzP2UBceM+bROHXH6uRb?=
 =?us-ascii?Q?Us6qsPXwfnIVDVnWH4h2zXfubmr94qGFKsuF0bziTn5iSDIII37XqFjTDNY1?=
 =?us-ascii?Q?xU/wXUmmwmv6I6sHiqgUFrRcvG/MA/0sSCJYb2nJUHGfT1cXUiC1H6MGtzkU?=
 =?us-ascii?Q?UN9rXfw9FAMyeQWN0rgVgLuYY7/q4lETt/CvPpInzoC1JQQVBqQsL2p+F8wF?=
 =?us-ascii?Q?SM6+makkrJYG0JOAGVnRXKznRQTt1U6Z2Ea4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lQflGwG4YXhIPwWk/Rgjnyrhn1lHOklAQUBHMeCV8yk1Tmxqg5XW5F1ulC0D?=
 =?us-ascii?Q?A/0UY6WeNdmntBXQaxyT4wFbdPD8qszKf1mEtWEqqxRJ8vV4qzfBujJTMqdl?=
 =?us-ascii?Q?8zpxLdPaeKAVA0aFiifMpvDqEsk/Amp0ZtUiU8ApTlGipGgCw3kLdkRypuvl?=
 =?us-ascii?Q?Kk5NaOhbbTf301QZOUNRYpFX0N4FBR4cmdeAJss02ab/Ul1d1jQ+cyWxYZgz?=
 =?us-ascii?Q?YPdkzN1ToKpbHZH9VS16M6jV+HNBCIZeoTQpm+QwJWVnwaLMLOc0A/UBHBXd?=
 =?us-ascii?Q?uh6REVsnK5YrJ3B1Y6wCOqRG1alMSdOpJ6R5eUgJDpX7BniyngYBbpK3zksW?=
 =?us-ascii?Q?2aJigvGjDCEvBaziQWfAGKtyksNcPEgRZ4H136dJWOSgKLUQsddltLDJNziN?=
 =?us-ascii?Q?ZMfSovcRTs87LxQ95+Qo6E82oT/xhuZ10E2/dwKvOaAcF1a1Xio9EcMfVBGa?=
 =?us-ascii?Q?NBCBtX/o9FLgAGA0WyGy6mwWlzt2PDIp18COXLyFpsMP73ffmvzPgM8HKTEj?=
 =?us-ascii?Q?Xjp38JdgBtYL6o+uCoDmmF8xKTsBhK6kHZV62zPsnANW+XepVAEUOcvYWWmJ?=
 =?us-ascii?Q?Iu1JuPNS1nAC7tIsixWug1frkvynZEqTmAXgk2Fp00l7rUBIQl02VasLbk18?=
 =?us-ascii?Q?+UwOqCHI5DKE/vx4JqYfLkCu6x1zA27MIQw34l2BF1d92d9vrIhmZu7XPtPT?=
 =?us-ascii?Q?6F4QAz+eKE6ukHhj621E54NaqzCIyHveNv4iH+7UoKBFOU1mjQlYsDx1u/8o?=
 =?us-ascii?Q?EEBhj+b1xSORO+7HKZSAno55NCzOPJbQ+CENR2VU4s18ua7MIep786G7dHui?=
 =?us-ascii?Q?fpo9k36nQoLABJlpcCKKD3tMKgJSLtbwVtUxFg5aIbOc0cso2nuFVxmb42FA?=
 =?us-ascii?Q?nXVcWlmhlhdhGM2yOaOH/nJrYraPr1b1PntqvRGmoI/LK7qwuObJQJfOv7QZ?=
 =?us-ascii?Q?6C4KwJkbm1Ssw3dsvqvFJXGfk8EwXRYMOnH4Dyj2BteV1y+YI24K7VBEZ0yr?=
 =?us-ascii?Q?q8Pad33qo7N++BPYvJR1JsaPzWEM9vrUu1yXyrn61Va1A1hU2QcKwj3RlCrU?=
 =?us-ascii?Q?c6G1wzxAHq7xPkFLf7T8JHM0QLHuOEnivrlFQ45tqDVZAS6BmCIT8vQkFkZm?=
 =?us-ascii?Q?6BzNwVowJ77F99AxptMp7kqUuBzdFth6PgDJDA/AQUTe1BPN1xzgGRAbBCsH?=
 =?us-ascii?Q?1e0V+6nOVB0QRhx6223B8QBjnSSG8suXtw7eM87EieMZQv9V9RnLzWwOJWLb?=
 =?us-ascii?Q?jdlsiBS5LcioWHdt/zslGfX/vr2whWVPfrdoUyfMY7YyveNvGItPd25IiQ7G?=
 =?us-ascii?Q?7kvGUFsvbq1osSXqwM47H00UmD+fTjqCrysfPQcfxcI9+9L78nrFev+Z64Gl?=
 =?us-ascii?Q?xx0cH8zgQDY7SyV5P5HzxygHAIZp37jLQ28o9nRsFKXQnphGBD29WFUf8G68?=
 =?us-ascii?Q?xkRHY7aO8md6oYZ4vISHg6PH9cPCpJfCCce89KvmoEFxlnL+DRxBdJhL8f9m?=
 =?us-ascii?Q?3paGrIyY9vP7briEPYdbK9i4Ik0B5jTjpWrTrZ2vKJC+YQ5FFLY4SkBFfx3D?=
 =?us-ascii?Q?kD7T7Cq4St3g6ZsQi86KMrJ8DWq6HlOGqcFnplEADRuGLHaTpx/1drZay0TY?=
 =?us-ascii?Q?YQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b81d0f-e422-44d3-b53e-08de26bd7cf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 16:14:01.9959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DLtN3E3R+UTHKpbGlutnA9bNIU9KqTD20TZE7C7FjEs+ze2fcJzE6EuEgqa50lCRpxa90TBKOEcSpKK+NNfahNhec1bGviz88qZ/0xrvgCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15020

Hi All,

I get below warning with today's next. Can you please suggest how to fix th=
is warning?


[   13.122280] systemd[1]: File System Check on Root Device was skipped bec=
ause of an unmet condition check (ConditionPathIsReadWrite=3D!/).
[   13.142562] ------------[ cut here ]------------
[   13.147308] Unexpected gfp: 0x400000 (__GFP_ACCOUNT). Fixing up to gfp: =
0x100dc0 (GFP_USER|__GFP_ZERO). Fix your code!
[   13.158526] WARNING: mm/vmalloc.c:3937 at vmalloc_fix_flags+0x9c/0xac, C=
PU#1: systemd/1
[   13.166576] Modules linked in: backlight ipv6
[   13.170983] CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.18.0-rc6-ne=
xt-20251118-gcc318393a5df #175 PREEMPT
[   13.181082] Hardware name: Renesas SMARC EVK based on r9a07g054l2 (DT)
[   13.187641] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   13.194675] pc : vmalloc_fix_flags+0x9c/0xac
[   13.194705] lr : vmalloc_fix_flags+0x9c/0xac
[   13.194715] sp : ffff8000828fbab0
[   13.194719] x29: ffff8000828fbad0 x28: 0000000000000000 x27: 00000000000=
00000
[   13.194734] x26: 0000000000000000 x25: 0000000000000000 x24: 00000000000=
0000f
[   13.194746] x23: 0000ffffcc595b58 x22: 0000000000001000 x21: 00000000001=
00cc0
[   13.194757] x20: ffff8000801d7af0 x19: 0000000000001000 x18: 00000000000=
00006
[   13.194768] x17: 0000000000000000 x16: 0000000000000000 x15: 006c3267030=
00000
[   13.194779] x14: 00000000000001da x13: 00000000000001da x12: 00000000000=
00000
[   13.194790] x11: 00000000000000c0 x10: 0000000000000ac0 x9 : ffff8000828=
fb920
[   13.194802] x8 : ffff00000aca8b20 x7 : 00000000021cb08a x6 : 00000000000=
00186
[   13.194813] x5 : 000000009d17f2f7 x4 : ffff800037e00000 x3 : 00000000000=
00010
[   13.194824] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00000ac=
a8000
[   13.194836] Call trace:
[   13.194842]  vmalloc_fix_flags+0x9c/0xac (P)
[   13.194855]  __vmalloc_noprof+0x60/0x74
[   13.194865]  bpf_prog_alloc_no_stats+0x44/0x218
[   13.194879]  bpf_prog_alloc+0x28/0xec
[   13.194888]  bpf_prog_load+0x168/0xcdc
[   13.194899]  __sys_bpf+0x814/0x211c
[   13.194907]  __arm64_sys_bpf+0x24/0x40
[   13.194916]  invoke_syscall+0x48/0x104
[   13.194927]  el0_svc_common.constprop.0+0x40/0xe0
[   13.194935]  do_el0_svc+0x1c/0x28
[   13.194943]  el0_svc+0x34/0x108
[   13.194955]  el0t_64_sync_handler+0xa0/0xf0
[   13.194964]  el0t_64_sync+0x198/0x19c
[   13.194975] ---[ end trace 0000000000000000 ]---
[   13.328233] fuse: init (API version 7.45)
[   13.339395] systemd[1]: Starting Journal Service...


Cheers,
Biju

