Return-Path: <bpf+bounces-10798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9FA7AE110
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id B4B141C208E4
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 21:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C10825109;
	Mon, 25 Sep 2023 21:57:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3A6241F0
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 21:57:34 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020014.outbound.protection.outlook.com [52.101.61.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12394112
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oI9CQ4lmpuD5wyKdeP8k9CgYF//kvLEzGoUbkKVLRCzixTxgkQ6HeP2lvuDXTpHf/cGVdTadtA5kxOnKjVeVkYmdcgWGkQS358UKTTFnEo+rVaddpQc+I8LbtenZwq9Vj6EqZ8JtOlDIS4BiMZWPpbdDvjbAS0OdJjgXwzSdozB7p93aHy/tisZlMBkjkVachShc3lLRYQBxKkC8opF4GzgdvtzgBgCiNbGPd8H1ZRyUieBDX3qkGlHJshKe2cfnSVweQL9XplpPc1zwbJyOYcO3Nh6XmFOEfECX2+VjcF0bRG57Emw+kgrMRz/wbOQh7TufXSRqaXCJ70c7QWNjxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lNsa3/o0Lp099/JOOwmXctRgGHSfsllsJ/mLtJKrIg=;
 b=RyeKT9R5LT3Y5T3Fb50PTOJAesBuNAAn3Odr50XFkOJW4bu887Y7JgsnNRQD+EpdJlBUCl49FQCO5fGOVngtRJQVDV5FQ9SxJOl9/KXrx0oTxgC5wqF16Y4Umtl5C3pELAb4sDyisEqtYKt9IlOwpgPqhk9uLJLOcKjRGuRCY8JMe7u0OD/x0GHCe3t8l0DotzyjzOMrotdlCjOrU2rdjHyixPhs/zI/WYqLmuw9TyQHUX89kHQg7ghpIjhGzeW6omDIh/CgyENO+3/ad4reRxmIt7VzsDiZ/IwyybADCWC3Vv+XzuYgKpJQ5S6st1qzKcnFzjnORMRVNhb7OF2CSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lNsa3/o0Lp099/JOOwmXctRgGHSfsllsJ/mLtJKrIg=;
 b=ZcCv5UqW7SYhnEIhejwYRcSWswGa/MP22mzpnsrkb3VAeWCUXJbDjcL/7dKcrYWOh/Kb8irKwoiyiRR9l7sXyNMrdJkAMdE89U9HfeaCw3/N6gvEXG1tl22BxChmnvlN+wyc9CiLpWovbK2M9Xzf8i9XY7OLa1yV/a7KSalRIb4=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by MW4PR21MB3805.namprd21.prod.outlook.com (2603:10b6:303:223::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.12; Mon, 25 Sep
 2023 21:57:30 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ec5c:279e:7bfe:50e9]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ec5c:279e:7bfe:50e9%3]) with mapi id 15.20.6838.010; Mon, 25 Sep 2023
 21:57:30 +0000
From: Dave Thaler <dthaler@microsoft.com>
To: "bpf@ietf.org" <bpf@ietf.org>
CC: bpf <bpf@vger.kernel.org>
Subject: New Version Notification for draft-thaler-bpf-isa-02.txt
Thread-Topic: New Version Notification for draft-thaler-bpf-isa-02.txt
Thread-Index: AQHZ7+NS+EVk77BJE0CfAIbYDFHGE7AsFBow
Date: Mon, 25 Sep 2023 21:57:29 +0000
Message-ID:
 <PH7PR21MB3878C2BD3D1BBF7EAE077A03A3FCA@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <169566875696.34978.17222195480011841703@ietfa.amsl.com>
In-Reply-To: <169566875696.34978.17222195480011841703@ietfa.amsl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8ffb551c-f1ec-4c25-9b50-738a387f2663;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-09-25T21:47:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|MW4PR21MB3805:EE_
x-ms-office365-filtering-correlation-id: bdb63abb-ea1b-4cd9-f146-08dbbe126a00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dRvuZTYHyUZAu1AW/CrL+2FBklpO12Qtvz09+531odrDFsijGzgjF9uPpgVlmo+aBe03q/K6z9y7FaTNl/s7/9FkdN4tdmY3URsWn4ua7Gr0g+48pqwUNJOTcv7Z/2ZVG1AQFGoEN9W9CU3emEnW1K9cAwRQoPh9OC+0MdwsqjGHDTtmgnsSIf8TfnF6bTk8pJsaeW/T6SogOtm52J2nDuY0Px8zG55zIOXRgU0bdMw2moC/5sd8GmrqhP+AVdf8kMBfvjQD631CNZ4teGuh/GqGkG5/GA382F8M3ooCjmk7A9KfgopPGVEfoKpPwDgULdWrdqTROCFNLBeqUJ0r7/dKa1MikKiSyz2jKfE64S60/eWXaGU0oInBNkGDCQbzXIaKCEfr5Vi25kM8dFZVDa6xp4IWkIjFQrBnF9vRiXjwbClgctmjrb1pAiHXpZvi+2PcTiP8IzoVC8QMSsvTACK7xJld7FnE47aAq+RI12KZU+I0ISlUll1yxR/xqoYevCUw115z8uSKOx0m7IPrNBC5oB/loIFq/AjZNNeRmTRhG+lbrV5OrO+2a62wN2em5kANjzOzVqhnZ+xVkS/DJYvC0DbjocM5NMqvIpsA3lOrP/JKUhgYocZ8//dyGW/FEsnq17cKUEGcu2c1m0cLqHdLxTPDowSG5YRYoJ70zBRsnP+8eOuYVaX4VmEMGjoF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(230922051799003)(451199024)(186009)(1800799009)(55016003)(7696005)(478600001)(71200400001)(10290500003)(966005)(6506007)(9686003)(38070700005)(82960400001)(82950400001)(122000001)(38100700002)(8990500004)(8936002)(33656002)(2906002)(66556008)(316002)(86362001)(76116006)(66946007)(66476007)(4326008)(66446008)(52536014)(41300700001)(64756008)(83380400001)(8676002)(6916009)(15650500001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VeQF5kh45B3P6r6YIULKzO9lW2VRbKKxx+iIm2tPFK/ldH8ud+LGyT3U+ju8?=
 =?us-ascii?Q?u4DdGjhcqH+C60i2CgZDVMGijrGosAHcxI+fLEZ+pCRoYYXecawvbNXILM2c?=
 =?us-ascii?Q?VJ4ps/CMVzNFEx4w9x77ToG+Tvu5QLR4DTVmWDMTfH9hOWa9Jj2sdGls6K4q?=
 =?us-ascii?Q?Q0LnrWIrs1IYbKFg4Lr7EokWb+D0pyiBPN/LXOGCMB6l8eeUsPEcRVoxPRrh?=
 =?us-ascii?Q?TVITRxh313/n4GwicNzFAKZfZAU1/fKxkwA0osWj47g32Inec3BzDsGNQqzY?=
 =?us-ascii?Q?sd2gxvSfxorxG5Lp7ueAjxwq3B4Q759p1zCNb4t6YCpMcJfV429o7KJuil6Z?=
 =?us-ascii?Q?6Z/32yrf//YAEfOahHqu8hx8AyT2NROZpvhP1baJyWWX1qj4+0PYZWdwKdRx?=
 =?us-ascii?Q?JPWlq7JtD3FbY0rDpPFmsWKYmwgCU3ArUK4KAzgwPi8P9IJQY11PyL0yWcBD?=
 =?us-ascii?Q?7g2ABpn4WaNWxEBDA6/Aj9NJOL+2qHGPlRU/neusIcNl64YP3etqn/sxg5t2?=
 =?us-ascii?Q?sBJ19+yB1b3a5QHrIe8hhUtnjhaVSHiA6dpe9AJnOsUEvOHdiyWogS/3kezr?=
 =?us-ascii?Q?d2qCoh4V2w138dCP1uSfkQReJTmNFx8kceB4iCS1rj7rEsfojd+4bcfDCAMj?=
 =?us-ascii?Q?8meQQfaa7z/v/spABiAths9z1rrTNozxzje7GQ6niKn9OPHx55uHeOrpOu+I?=
 =?us-ascii?Q?17IGCq1qFCH2BEr+LRI240IGVSpV1tZs/3O7NMGsN/zLWkH4UOSFuOUhzVcg?=
 =?us-ascii?Q?Xq9XUjFvyuXTFgpksQGsDY/DD4pzwW/1/0E+hq5HEWfbh+IlRawS9kkR4mzz?=
 =?us-ascii?Q?mCnDIvO1yEU50GCTmso2D4hXKvg1ihd0E0KWrSP42Wy/DlW/Iyb0gfViMV5u?=
 =?us-ascii?Q?QC/lGvx5Y1J+KQmRC0UuATMECDtRvCPhakPdIVOkNROWOGd1VESMeqvNEjmI?=
 =?us-ascii?Q?XH+DM8w+EjUkdnTKuV+kwrioXs16XPAUanicUrxQkPmS4oPV/LPxYeZkJVJT?=
 =?us-ascii?Q?lBbQbkSi06i5d0Cz5vrYVx8w8BkGlzlfMUemz01GuVagS+HbdFXPYrLuyrEm?=
 =?us-ascii?Q?aDP70U4r04XCczZMues+M8R5A4fjcK07tyO4ueIyGK5yDrfMV8GDv7fcN9XO?=
 =?us-ascii?Q?s6TCyHbKVXEzriTHSx1C/X/qkyC7MEkxRGv8UgOD01aiOAXr2pqGCj2/gwWE?=
 =?us-ascii?Q?y9z+2fNhi22swinmD0rWycda69RpzesVAEuWkyxZpJC32qGxTRSpA+niqazE?=
 =?us-ascii?Q?F1VR1Vbd9tgoiON3DgA+Swrc5dVeBMfikqmty5+2rpsrUJxACPD/pn+oXpx3?=
 =?us-ascii?Q?Ti9NoqDV8rkRkhjQyDKgOUEtr6zdjiZik4LVQd+zWw82kx3J5q6AQLubLvuI?=
 =?us-ascii?Q?CSWhEZWtroapAfuYstykLxcA2ycbOJF4retmZJai2FReY0ycvk/urHxdTWOj?=
 =?us-ascii?Q?j2n8Y/AAkrhW4KVE5sIziZhJxB8cONI9yHGSmrH2VqtKKXObMMphgAnCNs/Q?=
 =?us-ascii?Q?9H2yY+RTPK8LO7KF+MddygaoOHlQqfbefFmLpILoqwIwTwCgXty2cD+hriq4?=
 =?us-ascii?Q?9/j00Jtfc5YTVGUcwW/ISl8rQyXGlRkqawqSG+L/5gQr9UjJ0WpKTozKc1vl?=
 =?us-ascii?Q?wgs3G4MRchH9ZgJ+vdnuhX4trW7hMDV1P8QxKP9pjea4ji0JF99Ez7ADhP4n?=
 =?us-ascii?Q?IPoOkQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb63abb-ea1b-4cd9-f146-08dbbe126a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 21:57:29.9734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2l+QO4sn5SXO1IApZtFExFvlSx/ev+1wHyQ6cT4zxdTKNFXw9DNgPARM6svip/HU3wZeNutSy6BhEviRu+zRRytkk0oNjYR0i1xt88pdg4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB3805
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

draft-thaler-bpf-isa-02.txt is now posted in the Linux kernel repository:
https://datatracker.ietf.org/doc/draft-thaler-bpf-isa/

All changes in the Linux kernel repository's RST files are automatically in=
cluded in this update.

Diffs from -01 include:
* s/eBPF/BPF (David Vernet)
* remove ABI text (David Vernet)
* fix BPF_NEG entry (Jose Marchesi)
* add documentatoin for cpu=3Dv4 instructions (Yonghong Song)
* formalize type notation and function semantics (Will Hawkins)
* define semantics of sign extension (Will Hawkins)
* correct source of offset for program-local call (Will Hawkins)
* add IANA considerations section as discussed at IETF 117 (Dave Thaler)

It took me a while to generate this update since the RST source in the Linu=
x repository
now includes more RST markup/directives than before, so I've had to add fea=
tures into
the rst2rfcxml conversion tool.  However, I've finally finished those featu=
re additions
so I submitted a draft update to match.  Let me know if anyone spots any re=
ndering
errors, and I plan to submit another update before IETF 118.

As mentioned at IETF 117, https://github.com/ietf-wg-bpf/ebpf-docs is the g=
ithub
repository that does the conversion.

Dave

