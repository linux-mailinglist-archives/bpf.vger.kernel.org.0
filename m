Return-Path: <bpf+bounces-1317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71A8712A2A
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 18:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5FC2818C1
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 16:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B803A2770D;
	Fri, 26 May 2023 16:05:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908F4742EE
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 16:05:51 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020021.outbound.protection.outlook.com [52.101.61.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC2CF7
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 09:05:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElOta5dB/wGTPp89PR3ef/tWvtqjS2CzejBiMEC3v5HV7u/t2otejd2Ze2iAHiNz/D9GMzeNuNkQznnIjDYDKWyz977dvqvtuXCK4swMVHXsmWI6mxqe8vHB23XW5yqs56ovPOQBGEiPnpUz6NjIs4HbmRZa33u+ljFS8/kjmwtO9IrEPClX1ZIKq3ttw+JOjfozz/PkOIysTzNFprB0fukjLU1UoyGDGRR+PFDyGhwa1DmP6+OumN6ZqOEus4lqAnsgZKBGBWFz8qY7apnyyx2z3GOpwSLASXFcIiUie1zDsLTC8BuJZTvS3kNSZUQ1ySgmYvUap7Tk+iXF1xRXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0W2XIHBGMYC3eM4jXqaShShoEyarhN3EoXVjfOtyfxE=;
 b=KbRaoG3ZJ0b1f9kvFmb+oZtzJD0SRVfW/IaYPCASEmZWRav/+dLtszAnu2Jkf0t19mmnm8mIjh3tAUCEq64oIPDmY2SOV+YOBtDHN0wwnE/EpPv7Wh8Wc095aN6phzFGdg6zLRY13Uab3yGdyLz087iO69kfMxNeUeJoA8A+njOQ1Q7UdX9+8jSca7Q/ViekBKz5FhM/VlC7kyLCIiiizkYDLY1RYxr06bVeGAaI6rVt5uQoL1q724i7YNjKwtcvd4gO3q/jYH3uN946ukXkUanj0slU3fUm6zTSV2AtJCoRzB/RKUKuo30tkTrP5/bHT29zQnkXNYrc4vT3Q0sgvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0W2XIHBGMYC3eM4jXqaShShoEyarhN3EoXVjfOtyfxE=;
 b=QoVDN1ykKn95Lstp+y9sf5GOH3njqJ758fwFhR7C2dH+VALgqplIfwRteUR10CsARsQgTCRSU27T+sE2YDdZRU+iVeiH7haLLbFBgQms/zb+XujU92rOCoaQCuqOO+emHmtPay6YvtNn5N/dPqxkMUqKnv8kzqQzqK+vxOeST7g=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by PH8PR21MB3873.namprd21.prod.outlook.com (2603:10b6:510:25b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.12; Fri, 26 May
 2023 16:05:46 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::b892:e1d5:71ec:8149]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::b892:e1d5:71ec:8149%4]) with mapi id 15.20.6433.013; Fri, 26 May 2023
 16:05:44 +0000
From: Dave Thaler <dthaler@microsoft.com>
To: "Jose E. Marchesi" <jemarch@gnu.org>, Suresh Krishnan
	<suresh.krishnan@gmail.com>
CC: David Vernet <void@manifault.com>, Michael Richardson
	<mcr+ietf@sandelman.ca>, "bpf@ietf.org" <bpf@ietf.org>, bpf
	<bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Erik Kline
	<ek.ietf@gmail.com>, "Suresh Krishnan (sureshk)" <sureshk@cisco.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: RE: [Bpf] IETF BPF working group draft charter
Thread-Topic: [Bpf] IETF BPF working group draft charter
Thread-Index:
 AdmIWSmp8uIYgrASRIKQXfLbLZQgdgAeO2knAAYWUOAAMSGf+AAD196wAPVwpgAAAwOVAAAFPnKAADKhxgAAAP4sJgBZ/HaA
Date: Fri, 26 May 2023 16:05:44 +0000
Message-ID:
 <PH7PR21MB3878F7518729EB48F116978EA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
References:
 <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
	<87v8grkn67.fsf@gnu.org>
	<PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
	<87r0rdy26o.fsf@gnu.org>
	<PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
	<20230523163200.GD20100@maniforge> <18272.1684864698@localhost>
	<20230523202827.GA33347@maniforge>
	<8FA12EFB-DB5A-4C6B-83BC-A3CBBE44F80B@gmail.com> <87a5xto2wg.fsf@gnu.org>
In-Reply-To: <87a5xto2wg.fsf@gnu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ba679a4c-094f-4dc0-9aba-2fd047330bf4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-26T16:03:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|PH8PR21MB3873:EE_
x-ms-office365-filtering-correlation-id: 1216cab7-f2b7-4b1c-6597-08db5e030fa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PqzpTcx32fDnIDzU0wejkQvptAew6GezZJ7iKd3i1cS7bQYjvprloSPDCMSPkMgjDKdTe5Ie9xBl/jmdoqACNcf+ffbwz3Sd1YDhVZoos5dGgtty4qXagrq6DSRGT1ARwn7DdGcOlIi+pCRBs4yImhRl/Av54LB7FJRWjkKBMjUr2Fm+OWRgO48w0lhyENr7UOzDsPWZcwwXzJL5o3fDkZo0pOfyJed433ubOU1QD6q3zlFkDfeoHnaeKWUE1ETMNjnNJ3IkSCUEcx4PQpvQ8mjJEjzoq6pzH5fjmB5BCcmdrd5NmG3eGIXA1kGTehVO6qs4P/6RAtzWxFer/xZRG0MHeuEdozHAHGfk4g4hDTd+1tTuuokj1YKyne7pNfG0Hw/kyMGJITX18jouFoculAxeIo3+hQZXKLrEUhJPEIFH5UMw3MsKV2xpcMu0x31dvUUf6rXjiMpscS6N1/w4Wd+TGXZn6gilVy+0wAgfGNCviP+tHYkdo0pDZ9bLbFyu0a5vFhTaKe/s+YAc+ILHf/rhRFsEi/cD8Yz8tfKRZGgic/C0hVSYXBxbKdE9IWx35yxaZfZawQdve+z9kXLzrCjjtTc1k/EH/rwCIZDGlLc+jcYgpE06c55bs3nAK34tJs92c03o+XXHaAyDmGPQyOplElhnhiWzhOwaYQ3P3cSLwCtw1At7KPAxWdyQubPv
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199021)(76116006)(66946007)(64756008)(66446008)(66476007)(4326008)(66556008)(7416002)(8936002)(8676002)(5660300002)(52536014)(478600001)(71200400001)(316002)(786003)(10290500003)(54906003)(110136005)(41300700001)(7696005)(122000001)(55016003)(82960400001)(38100700002)(82950400001)(9686003)(4744005)(186003)(2906002)(83380400001)(8990500004)(26005)(6506007)(38070700005)(33656002)(86362001)(2004002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?U8E3HKnjA2U90EFhzgoZoLYN7pQ77+1rbIM/+jlxEjCtuB1CCgPsTeplfgew?=
 =?us-ascii?Q?aTkWXho+Ofgbcb7wOIzTKKVs8NPvGzkwmC511G2F/NX4z7A6qmvau2fULWgA?=
 =?us-ascii?Q?6bakJQVpGJ5aASun5nRV1nykiFSVTqe45PrZY5/cGLcDZ/dvb7p7uGuDG1un?=
 =?us-ascii?Q?uzQaFmlamrWrIFh2KbOugtbK7kHAVT6XPz+h2E3hjIvME0ywJ+PD9khkGVCn?=
 =?us-ascii?Q?5rLvXeQscNW94xwph3Of0qx/LnD20rOyN+qLA8/JAoyAgzIASPsH9Bjtz48J?=
 =?us-ascii?Q?537mSOCSMBdUlYmGU1Q1Fc4Pxqdp2V+Uwhxibh7cbDP7TboxKOM/tizg0NEh?=
 =?us-ascii?Q?Pev6b2A5G1npvbV2+mhwxU3GcwamdkK4YntOA4vHtuWrRoqWGIrrz415lmxK?=
 =?us-ascii?Q?eqTTSf9cnP8jy4NWJqCP123oGh0lZOtKq2S+YjTw60atZpM3gohGRuqGXG7s?=
 =?us-ascii?Q?lrQB7hI8Y5d4vT1TJUOCthQngS8z93qlu28cacTQh5yJY/npbZzVsnotsSfc?=
 =?us-ascii?Q?WuH/jRAsYYVFRnxlp1kVZmTRPPUV2PfwlJz8sEvImJkqt31lWPqOmcZ2SuCW?=
 =?us-ascii?Q?ysjlJj9T5GDXTvxtLuqhFuq7NQm5DGwPSy75ryO0hnRPcHLRtXIHX195+++5?=
 =?us-ascii?Q?6bV9cqR749swNK5NbSxQfQ2uQoOJFoA2HcXD/b+/AAkVJHC9mM19B4yBg9E7?=
 =?us-ascii?Q?Chd7YumlIN8q1Z5iFZPpn186ITbWuZO5y5Prl3TtWUTee4c5/s4w2LR+4/jm?=
 =?us-ascii?Q?fBR203JSOLfsV/7IpdFtYXvEHXZdH+IoC3dyRQdv15o6MM0WV7BqKhNS2iDX?=
 =?us-ascii?Q?+2fzIsUAgL79TP7YhH1JYXVW9/td2R16XJ8mPiaxPsbB3v/b4vJ2On0fG7/j?=
 =?us-ascii?Q?pQC/U9gl6HJ31zRAVZGygo3a1FLJXweLREEXebB3rQdha8pVNwOQoc6R+M3i?=
 =?us-ascii?Q?+YO++bbHcaxtu/rNbZ6qQ5YkEvCiT4r09XD/8jRsvwuqQoetrpGEKrw53w7Z?=
 =?us-ascii?Q?L96s1sLi0mPKjbKkzJ8rNoIuwSK3nL4y+KfaNu/zhwuldmjnBwaFkESW11b8?=
 =?us-ascii?Q?qu7M+JxBO1s9okzHNkmxGmWJyFMBZtwEzuH9AiOQWzDeSxWyivVDeUaho/lE?=
 =?us-ascii?Q?GRp5IEqsZ01FvVJyK+MGWCvM+5ZaEnDsoywYncrPYbbd9ShInBZw+Cpa/1Xd?=
 =?us-ascii?Q?Kbf9MYNlfURm8BDt8cyUiz2aFs5IpunJwV0YE/pTx7AiTrZe3TZRKAQbX/rF?=
 =?us-ascii?Q?Yd2YWp4dEYE4o0np3iKmWAVMT0fplKFjQxXhCHoSyecJJixqYpVl8tHBcG8i?=
 =?us-ascii?Q?/YN1pu0OMWxJyiCg+P5BQpDmLQqQ3Z//MM8AaVRbc4AY7fF2amYc9pt0wHZ6?=
 =?us-ascii?Q?4urY26NDq8yKAU4Jjl7b1tBXBNaclfw9FXa39p0RpW/MKAKuzDNIt7uiax1Q?=
 =?us-ascii?Q?62Qt1iJ+Hhe6/eqhEyY5R1xEQf8KX0crmYIaQOJSeAzl21W4PyBG9vnSUypp?=
 =?us-ascii?Q?pYlEEn/9aF07a/iO3D6BCr9Rg4wk3LmowxPqom7Ai2sEP61YzcsxrZFkOdJT?=
 =?us-ascii?Q?lyXe49HalhjomlVsYgEdTFhOh6/8OVUz33dWXdI3mr6FMFxlD4B7zFJkzKxH?=
 =?us-ascii?Q?MQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1216cab7-f2b7-4b1c-6597-08db5e030fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 16:05:44.3222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 920CdT2cVN1KiXmE5U2PzcXW5YV/HHV0WdzpzrrYPBqADnA3VzBjw2dILv+Ul+I5MseS0DerQKTmVRK7uBo0sc56gY5LgwQvIS93faXnAjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR21MB3873
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jose E. Marchesi <jemarch@gnu.org> writes:=20
[...]
> I wonder.  Lets suppose the ABI and ELF extensions are maintained and evo=
lved
> in the usual way it is done for all other architectures, i.e.
> in the kernel git repository or a dedicatd public one, in textual form, u=
nder a
> free software license, not requiring copyright assignments nor bureocrati=
c
> processes to be updated, etc.

Let's not confuse code and documentation.  Here we are discussing documenta=
tion
not code.   For documentation, see the RISC-V standard in my previous email=
.
The calling convention document isn't part of a kernel git repository, it's=
 part
of a standards group that is specific to RISC-V.  That's what we're talking=
 about here.

Dave

