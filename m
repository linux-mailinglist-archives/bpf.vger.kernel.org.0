Return-Path: <bpf+bounces-54709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F14A70916
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 19:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B4837A63AD
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 18:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1984D1A3BA1;
	Tue, 25 Mar 2025 18:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="R40p9l7+"
X-Original-To: bpf@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020101.outbound.protection.outlook.com [52.101.61.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D5518DB03;
	Tue, 25 Mar 2025 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742927577; cv=fail; b=dx2bcSOIzHJ4VGjDbeiZeczoUiqgPS8pL65bW1ekYLZDfYUsuLNuaxkQlo3VUzPRQYd/L81LsCS06SVJBCf3LfEY4Q3SXwfgUkD6LN5b1VPLhBkQEL6/VgIMH2/Z+aHOTZDbbpKhu76LaFgEO/cJk7tYGtoLzMhxpfzIIpemnqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742927577; c=relaxed/simple;
	bh=7pykMVXiVw1bXTMQSLGn30QdX/LnV8dEur95UmEtf1M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NG13Wv4vPiz+FS36rPmR66CrpwDv8cMCuZ9gFIWbIkasHHq20hK7EbRj0XuoE7Ii6CWrIPPdMWqYx3BaCO2yZ2qQ/Il1bQZsyxdQDsI13awSia+zU7sCEyjRLQ2EYrn3gqG9qSQVDl7PR7V6qTpzLsD8YwwZyV7vllekTRyMG/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=R40p9l7+; arc=fail smtp.client-ip=52.101.61.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSkLTpCqhPhH92ZCTB+D2G+acahejgzQ7aVXv72TK+nYo7lJrrYneIaRwRAyLbvTm+QsIDINtvWneqAXjUGm6NKfNvMxIviNlTAg/du7NHhKEjdDB8/4aia5S//I/8ccc9nSKV+usnDmn6MDhVbG9DsOZB6vLwGvaWzFPA/RyzYd7CG2BpgSBGbNqJ/Pxl7JXHhUBimmWkDnl47SISFkzQZ+t/Qte4RrkPxPMQpuRtpyA2ttmQnCAj/fmGwtynFotxoVap4rYlucgo4qJK6l5Wy2OfCHTzwVoxshC0en5WGstKnpK85a6j4Jk59xW3xwmvJlYt7Xir/IBoL0us3YDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVrT+0ao8rTeum3iGctNXN6NFb9tHBbOlufOsMWUAR4=;
 b=NkwKSYDhiLZ98/1yiB34SNb6Mlw8+7jcwe+j9/xGjnyFy21x1/yOcY5xO0kxROIP5h4Kb7ded6S605Bpqii3Ukc82A529sh6Xxa1XQ9YpeO5/XhtHJ5VNC+1rbr0SiPdBU8DbMU1wgJqR0AzAIoSCOAIGcsEOxHEfG9CePcdewkreCzc85/MvazdA51tiZ3ulHJa3ngpfm0IGSHPXyvx9rFhl14PHPb3DAQU4q2OcHl/A9HyVj69023YFbXSIqkbgv/96Y2sv9r0sFJLnyz2fz4mLccRwq218h+hIrWeZ+BrbYpa/XTIrcPWT9l7u/9dQI6KScpVdq4vI20sBEM+Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVrT+0ao8rTeum3iGctNXN6NFb9tHBbOlufOsMWUAR4=;
 b=R40p9l7+M3eS3ZED/o/CUQDwWBzxwY5xQQqduLTzHiP17Psm+q7g+vdp6fK0d8goSjP/mfr3lZuKy6pbEGmt7hmPE2ig4X8zpG2wvhgRU0gYGyyG4YVcLTUDJhlCERWBoqPxULQ82RODrHLimw+sVHyG3/JTm9FtnwvIU93up3U=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4209.namprd21.prod.outlook.com (2603:10b6:806:414::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.24; Tue, 25 Mar
 2025 18:32:52 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::ebfa:8e51:9b6f:f94a]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::ebfa:8e51:9b6f:f94a%6]) with mapi id 15.20.8558.037; Tue, 25 Mar 2025
 18:32:52 +0000
From: Long Li <longli@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Dexuan Cui <decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets
	<vkuznets@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "jesse.brandeburg@intel.com"
	<jesse.brandeburg@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net,v2] net: mana: Switch to page pool for jumbo frames
Thread-Topic: [PATCH net,v2] net: mana: Switch to page pool for jumbo frames
Thread-Index: AQHbnaOLMtMGcFkmHUqnlbDfcH1CsLOEFM+QgAASjACAAAXHEA==
Date: Tue, 25 Mar 2025 18:32:52 +0000
Message-ID:
 <SA6PR21MB423173F0DB9FE874F4F02966CEA72@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1742920357-27263-1-git-send-email-haiyangz@microsoft.com>
 <SA6PR21MB42317CBFF4D1437A3B39F98ECEA72@SA6PR21MB4231.namprd21.prod.outlook.com>
 <MN0PR21MB343793AB80403CBE9BE5EDFDCAA72@MN0PR21MB3437.namprd21.prod.outlook.com>
In-Reply-To:
 <MN0PR21MB343793AB80403CBE9BE5EDFDCAA72@MN0PR21MB3437.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e2d4f7ce-4753-4bcb-994f-e7b7d6feca24;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-25T17:05:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4209:EE_
x-ms-office365-filtering-correlation-id: 47ac3a49-2a34-4ffb-d731-08dd6bcb7407
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vdjNBjJ3BFO0TDiccJxOa1JRpltLAKTbS5eaNw/0MVOOcDLaLhMLjNPuyaZg?=
 =?us-ascii?Q?ndnYhAwC/R6FSuSP+6zDJdG7UecTl0lBJaT8GiO4CmYeibpTSXEoD9WfdOe+?=
 =?us-ascii?Q?z56k+DhF4EK5D5Xs95DtALQQy/7amC58ibAH0UfO44PlENM8xgm0Oqxu2Lo9?=
 =?us-ascii?Q?TQ8YE9issnctMGIi25VftdfxIf04MY93tXs1j7sTM8PsTyAj1CsqamrspVb7?=
 =?us-ascii?Q?lw/IXWrokYtWgq3LHIyoHyXzq+37YTIScbu1BpkXW8MSoEDNZCg6puM8FbbR?=
 =?us-ascii?Q?wDEdnLPSahFjWNd4jbkBdV5RQyG3DwzoCK5YbfLsJOttt9Jg3D9R2rR22pTN?=
 =?us-ascii?Q?Eo5ifVF03uUGU9jmdVMKHvlMto/atgRxi7qk2FETWqz2wRDgGZ/KjWDHSJYB?=
 =?us-ascii?Q?M5ggjYYKYXBT+uNxHjqg2mZxY4gm+Ifvd0/Q6RgdjURnUZO3v6iz6Em+f7/c?=
 =?us-ascii?Q?lOm5H9vophnPU2ES1l83CxZpfOOdx1TBBs+YlpXAIE6qxkFj/CTpgFVjP3x5?=
 =?us-ascii?Q?CxdUL7SdhCBfUQafMNi3LWjze58wxemcPBAiFdDp//VzHLVeMN5GkNflMDlq?=
 =?us-ascii?Q?1dpvnF6R18LvPozOKap3OCslPD3Gqx/5AiYflQnFFuG/heyZGh9/J4Pxp5Q8?=
 =?us-ascii?Q?rtUTsXAXCAG1vmm9Rn8LRn/pg2yTF1UaONZxZvhB4ef7+0VaOWDC+N7zUaBf?=
 =?us-ascii?Q?BSodZdRqYQXqXynn5cJuFi66YU/gZIMa1NI9DwUD/BzHFWJKsXiEEma4Rx1B?=
 =?us-ascii?Q?x2djK2ebJ378BcKGUy4E8WqtZSeCLLgrRV3fESdA7xvhPZVJFuSe0yXKd8uw?=
 =?us-ascii?Q?9NRGO0UhjwLWAWV5JneviVeqi733MdHNAUj/4Ay4s2RC//S4zn1TxEHCRU3O?=
 =?us-ascii?Q?ZXJL0rdkPJm9dmbAILt9wTQmuz+lwXYNzkHkEmTfnnaxaYjmshcD5yIKkmPX?=
 =?us-ascii?Q?fGLjKN52Tc8HbNM7001RydfQUGtTyhCMjJFMgld84AK9ZIKtzByn0xlttDN+?=
 =?us-ascii?Q?hlClI6z3hCxDaeVtnMmYA31FyMsO9SA1WQ1oIeA4XxdGmdU884shbtfnAKPh?=
 =?us-ascii?Q?01uuU+rn5wmAt7oMC4cTUcCZJnr3FXkPHIDqV4IQ2ulaJSzdQyueArjmFnAM?=
 =?us-ascii?Q?Ew2p69Z48v9mUqog4M4wq4/j/5QXqAfaQKvwu7aZIc/UFLH3KeihraLcNhG9?=
 =?us-ascii?Q?8FkAYwB58hyKi4bxG9eKKD/OLqlYuzqrN6+OyiYd/bI9T1X5OBxP/f66aFQr?=
 =?us-ascii?Q?lXg/YbztQHZ8PRLRtFMJaTHuFQmkuaKI+0GKszHDydiFvtZkLZBd2w88qIc5?=
 =?us-ascii?Q?hwzF6BIdXHmWuvQ8F8qlLWda2njdkERsLTpcHdViv6/+CWqf58iCeLOViKyv?=
 =?us-ascii?Q?bGHH9EYqF7ne5rHYLuct0s6ShOAh24LtHiN5ufKIXSV56xtdGpVvvnlHF9ss?=
 =?us-ascii?Q?H0n0jJKjcRY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8bBqU1cT9SrkQ99BtvW3xIequ7xU7HfvmOJ6GFlXkpYeZ5fnjxYSXr+a6HAG?=
 =?us-ascii?Q?XdY3PLWDF7Bzcz0PKclHzFUQNfxPJaMsS+jF/ZcXF2W2dMm0+W1YUb/+1DER?=
 =?us-ascii?Q?fNJcC3f3Gm5BMg0EzC9fqgm/a0nhekUjNUXK5WfEdP5fw+yL/2VO4zkbdV8G?=
 =?us-ascii?Q?hec56+UvGNuLNxFJESlE337LvwQE2zqyYtluKY6W24sXTQXxGEyKDHq7aBN4?=
 =?us-ascii?Q?wGvTXWYivA+dW3NZKy8xYHDepoiuzQTDZt0gi7xKXwkZoVOj43BPEd6Yk4YX?=
 =?us-ascii?Q?07HDPSuVM6Zxj2h+fFY93G0oadMcNFGTpQKWzMHLaNPK0SRxXgATNlhASofZ?=
 =?us-ascii?Q?qkgVxDK9+Cbf/C8i/NJEbC+f0SO95ZbyztF0/fYDqeMkrdONTkR+d9jiGSCv?=
 =?us-ascii?Q?AMRIEa7+Yr1/5CWEyp6+kBBiWgy8NI8A65xWnLeB107IN4L8SsYIhU5QFXH0?=
 =?us-ascii?Q?Qj1571Lc+JLThXyVzn6SotiiB4FUwdCh3zYAoFalFjxA1BWvdT6L9aXxXZZf?=
 =?us-ascii?Q?0yMHuwI+pgjY5mKU4R7NAOnq1YyUveNXBo+Bvq0FpxrWQAU6u/awr4Y8DSZD?=
 =?us-ascii?Q?5PuG0l6kvnJOKEjvF2euxjioy72aQeLacO08BKO7IGDxYB+ISgV11ngXRT95?=
 =?us-ascii?Q?NQd72c1Ws870/a6HPv26vUSwJjKGr8WuPiOzZ7iT5zFW9vaNPbjyn2QOC9rD?=
 =?us-ascii?Q?VY5Gs7OcLcI4fcTr50FfWVrZem9ZtlVJlI+bv4e+cl2tK0eQBoYqNlLTlrIq?=
 =?us-ascii?Q?2nUfsKZ/zJBX7EXkkSH7Q+4B82Jrg5RMPNsxUOF+gN5b6EqbPPOmWBMeh5Ye?=
 =?us-ascii?Q?tmrjacYLRLlBmx4d9CQyovXiaJ/p0woFElW1vT8Gnd6avmNys1pV5gLRJXZv?=
 =?us-ascii?Q?n33SyZLGWOKkr75Dt0t8h8ewIKjPDBeoMee+Ue0dsmfiCA6QmLgmXaE7RnUF?=
 =?us-ascii?Q?vz/3l0UMuq2CwnqXTeu2ucPJjUy4Q1U5IC85KLAHLnNTI1FtyifC0O63koen?=
 =?us-ascii?Q?URAqYTi+lL6NYjQiXFXbvRmiaKv1ABIWTOpyNenoEIyS/bcYrA78udJ3Yj/B?=
 =?us-ascii?Q?SN0mp0kUGQ4c6WAFocpZ3poN1l6zlar0LDYlBQsymjO7W0XKb3txhH4j87Os?=
 =?us-ascii?Q?bzfM9ceVPh1qSuFFk9IQUN8qeRYoO7zxfHzamW2EoKQc1Z2/xOaz0gqwV8sK?=
 =?us-ascii?Q?2n7di5cmjOpkc4jNIwqcRiX9NNINHTtlbqWdz8DqEcSWgywcYZ+dt3Nohi7L?=
 =?us-ascii?Q?BbsoaH3AjFrK9jou8NLNkKVcgnb7yLFvXdwgP0PvZVhL8hjgWco7v35MJR3d?=
 =?us-ascii?Q?UCZ92B+Vr/Z9D0jeVkJdeCuGueR//hM5RLJqjf8G5Guwi1HEv3uTxWgGEo/E?=
 =?us-ascii?Q?2sPIfYwtSVvfqs90yv7R8TCt2DXKXgKYXmyoL6FuF8ZVcq7ISo/i/sKcOcGC?=
 =?us-ascii?Q?pLlRQ6ag6tX7HKjsTLCHuQZyOhxIxDwNdyIFJqrfy3UJPF2w/0SIbjuFaPOK?=
 =?us-ascii?Q?jVfoaUPZYebdL6aH2zJNe/7uCFXY5AeG0f/1FadiyIp6ajf3xH6jZFMB3hP3?=
 =?us-ascii?Q?CSdxKbYVGSxT/pi1L89bTwWFU6BqYRrfwl5ttIZO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ac3a49-2a34-4ffb-d731-08dd6bcb7407
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 18:32:52.5285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqAi6fb6pruGvfIdhQqhwWVYyUjdZOXQHQaM+UzSblQ+lMi893D6J+iTANjj/2qgh4LVU/lo2fbslsQZ7iYbsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4209

> > > Subject: [PATCH net,v2] net: mana: Switch to page pool for jumbo
> > > frames
> > >
> > > Frag allocators, such as netdev_alloc_frag(), were not designed to
> > > work
> > for
> > > fragsz > PAGE_SIZE.
> > >
> > > So, switch to page pool for jumbo frames instead of using page frag
> > allocators.
> > > This driver is using page pool for smaller MTUs already.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 80f6215b450e ("net: mana: Add support for jumbo frame")
> > > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> > > ---
> > > v2: updated the commit msg as suggested by Jakub Kicinski.
> > >
> > > ---
> > >  drivers/net/ethernet/microsoft/mana/mana_en.c | 46
> > > ++++---------------
> > >  1 file changed, 9 insertions(+), 37 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > index 9a8171f099b6..4d41f4cca3d8 100644
> > > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > > @@ -661,30 +661,16 @@ int mana_pre_alloc_rxbufs(struct
> > > mana_port_context *mpc, int new_mtu, int num_qu
> > >   mpc->rxbpre_total =3D 0;
> > >
> > >   for (i =3D 0; i < num_rxb; i++) {
> > > -         if (mpc->rxbpre_alloc_size > PAGE_SIZE) {
> > > -                 va =3D netdev_alloc_frag(mpc->rxbpre_alloc_size);
> > > -                 if (!va)
> > > -                         goto error;
> > > -
> > > -                 page =3D virt_to_head_page(va);
> > > -                 /* Check if the frag falls back to single page */
> > > -                 if (compound_order(page) <
> > > -                     get_order(mpc->rxbpre_alloc_size)) {
> > > -                         put_page(page);
> > > -                         goto error;
> > > -                 }
> > > -         } else {
> > > -                 page =3D dev_alloc_page();
> > > -                 if (!page)
> > > -                         goto error;
> > > +         page =3D dev_alloc_pages(get_order(mpc->rxbpre_alloc_size))=
;
> > > +         if (!page)
> > > +                 goto error;
> > >
> > > -                 va =3D page_to_virt(page);
> > > -         }
> > > +         va =3D page_to_virt(page);
> > >
> > >           da =3D dma_map_single(dev, va + mpc->rxbpre_headroom,
> > >                               mpc->rxbpre_datasize, DMA_FROM_DEVICE);
> > >           if (dma_mapping_error(dev, da)) {
> > > -                 put_page(virt_to_head_page(va));
> > > +                 put_page(page);
> >
> > Should we use __free_pages()?
>
> Quote from doc:
> https://www.ker/
> nel.org%2Fdoc%2Fhtml%2Fnext%2Fcore-api%2Fmm-
> api.html&data=3D05%7C02%7Clongli%40microsoft.com%7Cada2b7bad76e4ab7286
> 508dd6bc87430%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C638785
> 230869082534%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIl
> YiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C
> 0%7C%7C%7C&sdata=3DVINKfrv80MzhE1mmibv1RrRz4WCmr%2BZhWDf1ZaOv47
> w%3D&reserved=3D0
> ___free_pages():
> "This function can free multi-page allocations that are not compound page=
s."
> "If you want to use the page's reference count to decide when to free the
> allocation, you should allocate a compound page, and use put_page() inste=
ad of
> __free_pages()."
>
> And, since dev_alloc_pages returns compound page for high order page, we =
use
> put_page() which works for both compound & single page.
>
> Thanks,
> - Haiyang


