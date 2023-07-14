Return-Path: <bpf+bounces-5052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E11754568
	for <lists+bpf@lfdr.de>; Sat, 15 Jul 2023 01:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188C51C21655
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 23:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7196A2AB32;
	Fri, 14 Jul 2023 23:33:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C25A2C80
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 23:33:27 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020019.outbound.protection.outlook.com [52.101.61.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE85C12E
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 16:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZX1JuBc5tnWtY42RKbehpyx/8at4s7MfB3qR9XX72ZgsrsA7ZBuR3k0Ft62q2GR0GrOhUXzMeCSLtwwdn7dJsMna/apQ/NkG943v7KZA5fC4K0DbSeZvccbx0rMXNO0mraKY7SgxFp/Yl07HTqw/mKg4EuOyYIZ7CiDB5aLcdqLGKZ3i7yFOKERdx3VqZuoeuVa8oQPC4t3RA3zjpw9fcC6NoVSqcFLGtP4HQQtt0VNMumaQWzFmRu07f4OoGM7AJa52IwBA9/FvmpmrwLRogsDXjlUpBaXwU7qYp/cUTyJE0ORS+IPQJBv0zC50Ap7LQWkKznzJy3dTUdKRx72BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krXrK70rPna7s2eFPk17jCK7Fkk75WFowB7M5LeFyeU=;
 b=bntCD7k55n5xg+b0HkH8HCKpSU3A3Rop1l/tvq9wumlwiLruMzAVdtHIRainNP51mqZLuJIYlRVdJFst1whG02Da88g35Wj3xK4AfqHlhtyIUcIR53CMryCUtK4H8SkNLVTcKu9Ksh1Lqx7azM8eT0vYTmh2TfSlc5P77IrE5XsywurMa/dw8EzCWPr8nxjCLBO8Qu7fgAv4DEamtPpCfxQAxH4OQL9PC4oNSwE1aZBnvqdLla/wK4zxRYYP6JHV2vUXq/ulhOSSY70zBAabmahC269SoLgWnWa7vmtpbV6S9cjdfYL68NdPdjV2Ke/JBcp+D8E5rX098b9AO741Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krXrK70rPna7s2eFPk17jCK7Fkk75WFowB7M5LeFyeU=;
 b=Uw1ZhT/nqI1G5fUy959JvXIUIY7fuuIJKP/dTrFG6H0+f8T8WlXaSEcu6rqUoXmgCyhoeTvt6URwngJAo4kcFFWnWUzF606cGYIpm0RM8Ox0eq3GFtPeSubPdKXFAiKF3lMK4LOKDrUUen5/j0ZUocnY9vQvqgamiwOOsAmZNMk=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by BY1PR21MB3918.namprd21.prod.outlook.com (2603:10b6:a03:52a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.11; Fri, 14 Jul
 2023 23:33:24 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::2652:36f3:e0e1:a6f1]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::2652:36f3:e0e1:a6f1%3]) with mapi id 15.20.6609.015; Fri, 14 Jul 2023
 23:33:23 +0000
From: Dave Thaler <dthaler@microsoft.com>
To: Yonghong Song <yhs@fb.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"bpf@ietf.org" <bpf@ietf.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Fangrui Song <maskray@google.com>,
	"kernel-team@fb.com" <kernel-team@fb.com>
Subject: RE: [PATCH bpf-next v2 15/15] docs/bpf: Add documentation for new
 instructions
Thread-Topic: [PATCH bpf-next v2 15/15] docs/bpf: Add documentation for new
 instructions
Thread-Index: AQHZtVCtJfYai/KTlEmn0IofJHhKnK+5601w
Date: Fri, 14 Jul 2023 23:33:23 +0000
Message-ID:
 <PH7PR21MB38788F07F700A549DEB96F9BA334A@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <20230713060718.388258-1-yhs@fb.com>
 <20230713060847.397969-1-yhs@fb.com>
In-Reply-To: <20230713060847.397969-1-yhs@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=91c5ea5c-d478-42f3-900a-7ca8e23faa8b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-14T23:28:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|BY1PR21MB3918:EE_
x-ms-office365-filtering-correlation-id: b9646f45-2384-40ed-3cce-08db84c2b746
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 A2iqz6ko8VlP3FVWroKzVoz5oVH8ItYPBMT5jNP0Mz0vWNhqSimwm9w/OGNVwrF8Y8x2+UuWKYjqlsbtBqJAx8G4E1jSVNaupNKa5iF+xkiWf3Qv0HDR4aJTFnBtSLNCSNXK1c18F2bCXm7mj7IDYYTa9RXiOnRiN8vrbq6CeGpzf225jnMB7FhI2uSqSTpyf7c3xb3Z5khUpfcb/eXUuBtjH/7HukjCJ9jWTIc9nMgtRsehN16oOOpHVYlMdgwK54QeJEzVR9+CFLa6N0mPWyUigny966RI5ZcNX8esmWBHUu2oA27jiIN6POk3d3vjLxXbiugQtM0ipJhGorG35Yt+2szZfsaMHvBxdFCZZioiWBaEX9kAMOaQ4U2oY0BM3RdERkFejeDwpBsrAsKKpoQIr0ACBDEcHekWJ3zpVIpc6FuMYqTlRcVr/IRSqmEnS2/LZR7PQTg9ZPYVX6fRg2jsTrSeRti2XVjdFj0z8o3z1qPVVTG8lFb6SEYJE5T7uU0cQ9O0pszpqAGaZ4nWybyh18IUOVwzL/90lWZJgFaWUXlUK2mKJGt4BoMmoMMQQ3vhD0ZAEREVqkEofYV+jj4Jp5FIEloW/OZgsIrXoesCtBo63pvonHQ4osasHBT+zqUWl3zBx/1uvhE/HoLSiN3Inn7WYCDkSOCS3dLVuDs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199021)(9686003)(6506007)(186003)(8936002)(86362001)(41300700001)(5660300002)(52536014)(8676002)(4744005)(55016003)(122000001)(33656002)(4326008)(76116006)(82950400001)(82960400001)(54906003)(110136005)(316002)(38070700005)(66946007)(38100700002)(66476007)(64756008)(66446008)(66556008)(71200400001)(2906002)(7696005)(478600001)(10290500003)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AUhcIGJ3cMtwfXuE/I9Icl9pUx2vF2fNys+i4f8eE61eguluRCZxiFjn4qoc?=
 =?us-ascii?Q?c/BLyvHqloQ5/Qn730CmAWn3Q1bt1mq1TnJiScR1eVtG1277r/1WZax/wr1h?=
 =?us-ascii?Q?rqJ5WyweIDegTVFIZ+/n30xJjakOgcDgkpqHhE1EOlheW22trViX95Fr6+0W?=
 =?us-ascii?Q?PB9t3TydOTR+IHVpV34Wh4Xe5U5Rjjqy+kvsBq0HBPqY7S7zBHtHwPcAkBIS?=
 =?us-ascii?Q?P8IE1jAZgudUKotxMoYhP+XZ6v2arSjkKlxX7eVXK5jvvsoB42ytfetHK+7Q?=
 =?us-ascii?Q?L2JaQbc6zksgE2Rwkc/ZwX+86xJRRquAGVUcJYvxqFlA4V56f42DlNBg+bZO?=
 =?us-ascii?Q?9Je7OKHaTq5HMtvdgmEn97KjqyhS5xNoxw1Ze/Uh+gXcahlBDakhac8NW8EL?=
 =?us-ascii?Q?mDOJAGVFgr40LX/Q2Pm1/CTvsad8BEdxsLN9c0nxyynkvpKCBq4/xnaBFOdO?=
 =?us-ascii?Q?7tQp0uAsk9USjWB4o61Ig0DNRElL1Gw+eVV9lCffdugWKptXap9noy/ntgs/?=
 =?us-ascii?Q?OpylUztFvwKYM77We4NYpFhEqVx1GJx0F7uIHspIEAcz5DgjT1yPvXzmlp0q?=
 =?us-ascii?Q?YJkJVZ9jESKMIg4coB9+UAp7NR66m2SwVcsyhFsXLxzgqMwqNBHARKwOOU8q?=
 =?us-ascii?Q?GMGqW+V+lTO/HltgNxRt+BxvjtFV89a/Ou6bEqztCXMtvrqRZFx12jI0GKRC?=
 =?us-ascii?Q?P3SpaQ0IDycndevS3pApIp1Gg29C1uT9ZQIgSoNf+QtXcuKdyuSNDY4AvIaT?=
 =?us-ascii?Q?hwiDcSxEDlcbhvXWcMj9388dfOtpsii8XHb78jqQd+ObiAWPBTyKyucFw5oP?=
 =?us-ascii?Q?7jDg1iCDsD5dZINC0709+K4R2O0RAhreaCY5E81lzWgBI3LDAyGCRjJliUMU?=
 =?us-ascii?Q?s7bwq7Xmi3CZloda9ivOnBb2ZVjry41Yddkj7j3w0qMS/+Hl+p0PYxRxN/N+?=
 =?us-ascii?Q?z+awBl1QdJLZU1ifiDsnq/h8bBy6Cy+z5CGmTua185ZHVtcpwl5q0ia6+6EM?=
 =?us-ascii?Q?CZEv2zaYiX+FEyUqCkNL1UfWeuCNxm+qswy2oWxwqVFkz3iQneA9UrC8WsN5?=
 =?us-ascii?Q?R8OGsRV5ZZk9g7H3yrOQ3UZKjkekNpcp0io0BZhxBu3g4BZgUHUc1habbbgq?=
 =?us-ascii?Q?UBorz4qP8c0Owg+etdcxRXsjx8E62QDxYiLRIvjXxsnshODM9bL+JdROn+bQ?=
 =?us-ascii?Q?lEbk4DCXLairwhHkqPWGSf3Fdz6jyDumLa9IHmAosBbuOXB8N0uLf9fHQqEG?=
 =?us-ascii?Q?dNE3wso6gs5G11yw/2cN2Uq6+YquDYFHOdc2cEHN+IeyvQFfmTs85TDmqLxc?=
 =?us-ascii?Q?RBXHM03aBbyXH5ubVlWCgMzAPJhm5sZUWEveHTxb84cqGRdUyrG0GppwYoUu?=
 =?us-ascii?Q?Hykws4nqOMW1N760afXH/mmM3rCOxin6xIgnJgyTrbM7XrQEYPGFB+nOYNcn?=
 =?us-ascii?Q?v/lkBYKdOiLmGTQem5EkS+ulAY2HUumUINDYc+h19LSFobLSmwShMDGeUltX?=
 =?us-ascii?Q?lPwJOGvyNaPYw3b/Cpro7xRaowfjU9kO1DGQUkMPGSAwt5MYWPn+6xzW+NcU?=
 =?us-ascii?Q?oBfej2FYOP+cqf6yoZzMQ9rsyWQRxmnUmcpFPsw5FEkYI4zj3rjhBVQ+HZA5?=
 =?us-ascii?Q?XtjZQW8yFR8GNVq3M7qU1msZV+/9byG54hie+cNcNZuC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b9646f45-2384-40ed-3cce-08db84c2b746
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 23:33:23.5999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gH6S5WSb3S1pqXqFEgQwRyTuL5bkqPnYGuvmqPM+NvAiaPjBAAaoDTYEkeOZdftgUY+nYtUZ2Go9joIt1haFD1Hwch7+y9ypvMigWEO16Cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB3918
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Yonghong Song <yhs@fb.com> wrote:
> Add documentation in instruction-set.rst for new instruction encoding and
> their corresponding operations. Also removed the question related to 'no
> BPF_SDIV' in bpf_design_QA.rst since we have BPF_SDIV insn now.

Why did you choose to differentiate the instruction by offset instead of us=
ing a separate
opcode value?  I don't think there's any other instructions that do so, and=
 there's spare
opcode values as far as I can see.

Using a separate offset works but would end up requiring another column in =
the IANA
registry assuming we have one.  So why the extra complexity and inconsisten=
cy
introduced now?

Dave


