Return-Path: <bpf+bounces-11127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AAD7B3B24
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 22:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8BE34282FD0
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 20:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B82167266;
	Fri, 29 Sep 2023 20:17:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39FE66DE4
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 20:17:15 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020016.outbound.protection.outlook.com [52.101.61.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286BC113
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 13:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUdwR98zXff44LtvVu2TcR2mlYc0YgxwOHJTrDC3ZBOt5EtlkacKWCX4zWqJ811EMhC7acHK940Bwu2okiF7MvALdh0f7MO4HwGKy7gxPdLDpEJwXiV73RnxVqAccjCALDTXh4jJ+dXyf+Gs1bPcqSKhckztBQrMdQsR7sz9lB0wM9ekBmQqdbVo0ijOscXVtkPsZHoLFZgGRMgwY0Wx7WZmpM+OkPD1UqVZCkroUawfxAFOhVQzy2+HYnILL0gHe3d6E8WLQQvHKMxLpoTgs9nFXZ3mAfcIUjQSghQAq7c3tJKpPjrTeAGawFEr3rOj/qznJYC/VKtkVE/ncZww8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Du0TUyaXzWlcz1ePFoJa4PiMkoGXdBTyFw9ysnQw+64=;
 b=nK07HdCCHBpHcOiS1cSSgwvcgUcHqVUPzGnS0mIvVhFW913WNH8N12fodeqEAVUxZ3HCZy4fSoUD25U5luUdtUMk6F3IJEyoQtRNL5hX4x3l3IOts8gOvxuiI9i5HCV0wfF/AxaXlmGzRT/sQHQCD5OaGd1M7wWGW079p0c/y4iji9vKdO37fZULTDdR06+T0jZ7IaXRz3KcCXhkwvaABvzOaecluREuE6HcQWtG+VTueRuwsLCfRN99OPtmBFDC0yAbx7xhmFz0heMmR2uinBftk/8EurJOityFdZVEK0u4GNsSyBrYgFVym5b3DDKG85FB7onyaCYGfIvUeJEY/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Du0TUyaXzWlcz1ePFoJa4PiMkoGXdBTyFw9ysnQw+64=;
 b=DAdt+XQiOAN8C0/gQgtgQevXNht8y3Wxw0ZnbHIRYeSSzLE0UMXXjWScuNvWUVy7ApW6gwyvWJ8HUTo7VXHpsQqKpf7f5BQOo7txI9f7w43b9QpQi/+4om4g1p6s3qHAyp+BJERuTEcDITXRFqE4RRP7Fp543MPDsxIrWxCCj1w=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by SJ0PR21MB2014.namprd21.prod.outlook.com (2603:10b6:a03:2aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.12; Fri, 29 Sep
 2023 20:17:10 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ec5c:279e:7bfe:50e9]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ec5c:279e:7bfe:50e9%3]) with mapi id 15.20.6838.010; Fri, 29 Sep 2023
 20:17:10 +0000
From: Dave Thaler <dthaler@microsoft.com>
To: "bpf@ietf.org" <bpf@ietf.org>
CC: bpf <bpf@vger.kernel.org>
Subject: RE: ISA RFC compliance question
Thread-Topic: ISA RFC compliance question
Thread-Index: AdnzENHOvm4O8LpYSx6FMQlLag6r9QAAQXug
Date: Fri, 29 Sep 2023 20:17:10 +0000
Message-ID:
 <PH7PR21MB3878027C6E6FB01651023912A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
References:
 <PH7PR21MB387850B8DB6A2A5FB87DAC06A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To:
 <PH7PR21MB387850B8DB6A2A5FB87DAC06A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=77ec43e0-99aa-49cd-b566-df416a63fa3f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-09-29T20:08:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|SJ0PR21MB2014:EE_
x-ms-office365-filtering-correlation-id: 340affdc-de97-47b0-391a-08dbc1290fcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wdQZM77kx5C2bFFSqUssYsY4a7/XHq4mFjLSWBwpPW42L0YLeNCoPk1KC1ztP1Q7jGio9TUGG3dR/AMw5vOfv+wiaOBf6lzWcSuVlxuvvkcFFPMrWxpeuzxVEZOUhcRCUCanRrIepuh5Skr0F1/NK+EQO7jOQMIpeCMkIIAaA6WcqJmFoC77gVbtS6bL89zT9q0do3w9INDeZaCu+mMpLz9OxZFc4odPGuoDZHQMLRExA4Vfec1Lb+hUhHtdMBvKOlM22X5JMeni14PjO1K81LWDVXtmvmV6clIo8T3DJmDiB0Z/43XQdNm99moVjhe9WBFfPph59ObWEch74Onoibsr6QoG9zv39fDRYlKwg0f/G6fIk65ujEagypaACFTiOQfw3BRGexpxIZk9TkN6lhIjAp9YQjaKwI4JbdHNHc7eFwqFL0hfxtxE+YETZsJiFa39FMFsVh0nLxLXV1DMFfO/ymoeFNIUyuqY6HolS0LlWuRPaQxRwGp1jLdumJDELaYAAiFQ8VO4yjWo9SimD82rEi8MqUW0bi7m07UbQEihcSFYG90GnkKSatd98CyCqD0pzsa6pfEu9ceSygzi5OLkfl32bWSl03NknhFRMHrw4VccXg8KAdj7wSGTi8hhlTncuo4k4omxbJC8x8Xf9wT4dS7LGfXH4XmxE99peRo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(9686003)(2940100002)(71200400001)(7696005)(6506007)(38100700002)(122000001)(82960400001)(38070700005)(33656002)(86362001)(82950400001)(3480700007)(26005)(8990500004)(55016003)(66476007)(66946007)(66446008)(64756008)(76116006)(66556008)(41300700001)(316002)(6916009)(2906002)(4744005)(52536014)(4326008)(5660300002)(8676002)(8936002)(478600001)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bszUi/g/UVnBG+6iA5s9ewQWBk0MPUd8IhrDQDnc8jFCN83RdD0nHLqudm?=
 =?iso-8859-1?Q?9Tk1R41ZOoXc44TwuI6bT+qBdrqApsGBLXBeZAn07bHngJckqqF026Br6Y?=
 =?iso-8859-1?Q?IWXVCIy/Xm/COJR7n5jrQbboOdYKxTuzGYUIY384Eqv9RJ1EVTZYuNNM+X?=
 =?iso-8859-1?Q?e1y0O16KUvlfe9S9AJ6QhGSsBxQIvICkcYgUYj3N7Fs9SHqVvrePG/PQXx?=
 =?iso-8859-1?Q?YsCcnzFBc2AIaxptmCSVhMukQQSHv0U4KMS2fcHge1y+btmHwm5fHPbR55?=
 =?iso-8859-1?Q?xziYaIGUe8FKMLiB8AKvf/RLrLxQldN9wbEdOw6wTxAQe5PwrnTegdU/xO?=
 =?iso-8859-1?Q?8sV676kPGSjko7/KvgH+PNzzwRGigXlH3Nto9mUVy9c+X56YU0IguS/GmX?=
 =?iso-8859-1?Q?lGDTFl7/ZwBFQ+Sl8KyWLWspP12ROAxxBWpw4G/68GDYpASdWd2ZIngBVy?=
 =?iso-8859-1?Q?zEt/ZLMtABBrfUAl5+uMaAlYeYW62tBZNtuggKNp6igiDXDg7BG2OkOOpv?=
 =?iso-8859-1?Q?9Yp3l436xJhLn0kwM0Zhqj4MQtEyK8t58tcx2d0lu6cg2MIUhfbqJa1mAd?=
 =?iso-8859-1?Q?s5UkeR+CUmIZQNIzruIRKX1C7A1tTyRt0OsV+hKaeoE/bsbou8Wp6hhp5P?=
 =?iso-8859-1?Q?CtaI8HS1IxwcGxgWMLKSAvbFhQ1C550Iuc9VStm4JRJ6sczDTgf1+okDQ6?=
 =?iso-8859-1?Q?xEU5kFnwvW+XJE9/LrJJHGZ1pN/HgyWMvNvOjzr9Us1X6Onh6BitaKegTK?=
 =?iso-8859-1?Q?xw7Si6vSyrWeuQBTgWWDLmYcYXfCqhwPNX+1ogeeHm6+Gi+VvAPSrojY9w?=
 =?iso-8859-1?Q?2GO2QPRLHKPnZEjj6q4mdS0nO8LgE3gcd+D15eutX9UDFfcp6WicJKj4Av?=
 =?iso-8859-1?Q?G9zpFOVFnsjCpOnxnl/VILdCOAFR2ULosPS0+5YEAb2TZP+YNTzOWENWHS?=
 =?iso-8859-1?Q?3wvzm0Il6FTBNCpsqRR1I5AWnPuBSDI39skUPnQoAjLLk0RhuOAfGxIz47?=
 =?iso-8859-1?Q?vE0rAhD5NP85lQcKyPWInt0WcRQcHJ8V3D+Mrou+pWw6o15nLyw9PFNKQY?=
 =?iso-8859-1?Q?kENvLaqdNgBSlUgFusFIqYKl+FX1u7GzggK0jbpcEPA7Hp9Lavbm0DeJ8/?=
 =?iso-8859-1?Q?IO6XVKbkm7BJcvZQCbYkMI41XEpSH+u81QeOBokEa0WgjmjpGpnnmtfmHt?=
 =?iso-8859-1?Q?P72VdnzCtUVdYu9jGgdQAPdMmk96zT23WG1DLMXXkG+zck+gXxe3s1uDSw?=
 =?iso-8859-1?Q?LZ473Mmr4p7WGLHLZA9D7Y7bk1ystreloHuBVuf/ajHOQxRe9GDUi7B01m?=
 =?iso-8859-1?Q?/UUlnjbaNzPVhYgO3wc2vLto+TMNTEgz7VZ2DUfRmD/izg+QaxgtN3ckv9?=
 =?iso-8859-1?Q?DLOtkVjzlMA85XwnZ8c+wYjPxPQblA7ydC89LM3ObkOMAo96MrDZv1MUBz?=
 =?iso-8859-1?Q?BzTwBGOrY30iP326PD/uxSr+LI9nHi5nvZVYb98q59IsCw3OVXxyrw5hw7?=
 =?iso-8859-1?Q?a8HrDWbPwvFuPZ6SaL8ngdvOtP84qDJKXzxeyGmzYO5bzkPEYzmPG/TE0A?=
 =?iso-8859-1?Q?XPOxmzRRgWJjV8ab0AUT0/SSwhM0r35I4YmbCIPQICc/yNZPdg7P1gksf/?=
 =?iso-8859-1?Q?ZtjbZcCU1hYlbmi7mKLPo7rxncUuE/hqEueIsIQZizoEpO2BGr7hj6JA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 340affdc-de97-47b0-391a-08dbc1290fcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 20:17:10.5646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BYVZKg69Eb7GHJdgBybhpjh7F194IB2D4mhhGMu5qDwfepyr/qMY2gzoHGVs36rgR1I9R8adF1dkEKjMJWmOcjylkEUG4H1IvXNthHQ2H8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2014
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[fixing weird character issue in email below that caused a bounce]

Now that we have some new "v4" instructions, it seems a good time to ask ab=
out
what it means to support (or comply with) the ISA RFC once published.=A0 Do=
es
it mean that a verifier/disassembler/JIT compiler/etc. MUST support *all* t=
he
non-deprecated instructions in the document?=A0=A0 That is any runtime or t=
ool that
doesn't support the new instructions is considered non-compliant with the B=
PF ISA?

Or should we create some things that are SHOULDs, or finer grained units of
compliance so as to not declare existing deployments non-compliant?
Previously we only talked about cases where instructions were added in an
extension RFC which would naturally provide a separate RFC to conform to.
But I don't think we discussed things like new instructions in the main spe=
c like
we have now.

Dave

