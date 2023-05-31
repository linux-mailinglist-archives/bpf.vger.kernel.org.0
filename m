Return-Path: <bpf+bounces-1532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA956718A62
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 21:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286CF1C20F1A
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 19:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2F034CDF;
	Wed, 31 May 2023 19:44:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7667805
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 19:44:52 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020017.outbound.protection.outlook.com [52.101.56.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0E312C
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 12:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G03PsxRWOgs9sg88mD8Jp0GcrKgCwx4/fgyvUi0LXwrjorQOOcUYlrm37Hl/ix2Dhko3hZ5mIUAlh/ynbxMJYI+2g5P8h0UzJ7fzzyveYJBFbDdcSCPhBa5IN57gIhiAjq33zxNv1azHT89zu9CCHGnSIgmnpuh2s+OCudRpht6FLlxRSRAdA0ci92EQLAJg62KxUfG1zLatmI7UvWDl6TBQ8vbcQ8W19S53MyQSSZBgovs0ODsnyW+SoqX8jar7DbvpffzgYlWmJ97/Jyci4HGdChLVW3tx7Y7aF6eqNsFTrkr1DLmUvIrLChEnJrmVhjKTyk+Nlnuf9jiYeLaslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xV+aSd3L1JfQNd8wDDT65hC9MA4vt3O0W0JTm4MC2RA=;
 b=L/+1YHbYLn4H4gSALY++XCbPiqm8k+T4DRloNENdouCyHvbFU9b0Z09mIQo0rA873GmLSbghE0oYKSeA2vuIy4Df2h0K2+M+goZM5IoL8w+4POQ5JYivQe3Uqs16hhQEuWqMA1yGyM3fWNlO3yZgr7wmtuJvDYlgcZxOMeM7/9KT6k3c4MGjqIc1/rGsPBhSWgWdIPOb+cIJklSYnsf9vW9LGjfwfzpoAEg1DHkllmx41282MSF3b3IJLhizWVV/819FbUYc+j5o4PFN1wyQyzTDIn76viMPkSmeNSoL1iFU513W/i6NOsEwKLnXD4c/jT0YbpD2Ww7wUtHgMlASFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV+aSd3L1JfQNd8wDDT65hC9MA4vt3O0W0JTm4MC2RA=;
 b=ioeFCT3xVDEuJOB+327rbB+wvYi3q+nw+q3ojbbjQ1aKjhH1T40Gjl7SxfGtmM+4p0Df90rlLsMxvsdrikq7J6+U1nJuYHu3xdL8jG8o/5tB48N5YuZpsXcslprtlmqShrjX9i9OUYaXnqVZEhFqxm/UqopPQxvEZrEfA4mmXRM=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by SJ1PR21MB3576.namprd21.prod.outlook.com (2603:10b6:a03:454::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.5; Wed, 31 May
 2023 19:44:46 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::b892:e1d5:71ec:8149]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::b892:e1d5:71ec:8149%5]) with mapi id 15.20.6433.013; Wed, 31 May 2023
 19:44:46 +0000
From: Dave Thaler <dthaler@microsoft.com>
To: Michael Richardson <mcr+ietf@sandelman.ca>, "bpf@ietf.org" <bpf@ietf.org>,
	bpf <bpf@vger.kernel.org>
Subject: RE: [Bpf] IETF BPF working group draft charter
Thread-Topic: [Bpf] IETF BPF working group draft charter
Thread-Index:
 AdmIWSmp8uIYgrASRIKQXfLbLZQgdgAeO2knAAYWUOAAMSGf+AAD196wAPVwpgAAAwOVAAAFPnKAAEnmqgAABUBbrgA+cTCgAAHU2oAAABSogAAAxJqAAABQzoAA3s56AAAhLakAAAA2TBA=
Date: Wed, 31 May 2023 19:44:46 +0000
Message-ID:
 <PH7PR21MB3878F9FEAF8DAD233E2505B4A348A@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <20230523163200.GD20100@maniforge> <18272.1684864698@localhost>
 <20230523202827.GA33347@maniforge> <ZG8R3JgOPHo7xn61@infradead.org>
 <87y1lclnui.fsf@gnu.org>
 <PH7PR21MB38781A9FBC44A275FDF3D5F6A347A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230526165511.GA1209625@maniforge>
 <PH7PR21MB3878E80B01C2AA8273131D7CA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230526171929.GB1209625@maniforge>
 <PH7PR21MB3878E4B002049F825DDCD52BA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <ZHbDekB0KderhSTl@infradead.org> <9539.1685561890@dyas>
In-Reply-To: <9539.1685561890@dyas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=071dd062-cf26-4d8e-817d-2607bce6cbf1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-31T19:44:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|SJ1PR21MB3576:EE_
x-ms-office365-filtering-correlation-id: f71c9ff1-3e51-4123-c512-08db620f7d2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zj3I1MdRzqYlEVyKtfDaxdbPBpCHjgC5aiOrKg9c5+d+rnKzGBmjjh/IhdTu8f9Tu0/6gsc96L1EtYynTROFRlo3IUszo8fkXH6e5zdltajPZ8dCv6yuOXz1o0H3V2wQcQltz1eD1IavrEaMzZL2lDJCplTw5xBgCRi/DsE1oqDQxzvhgl+oHYYKMHL94L548Y3TwqguU3tPjOchv36/H5D1lh0cq0/GcMduXbHr95wVzLm7dtl6D3Gsi71LGMxpLMA+Ec4YzfeNYb1CaxY9t6n3cZxVhw0UAb1Z57Ik5hv/s0pTnr96NxHxQdfiICdlEkichwEonOgi+MGaZQpw1rN8uXeULCcMasCVs0CMJWQNpWi+inJsmcJKptw0AVhOp8OLAYECmzQsgw0FtU5H7oYYH7OD5VLC98RRmavtvXmLMdB9F79ykV2UahCDkgUM0Mun10Ot3kxiXi06sKWgng3yIcWJd25+UrbLYsiFXqkGALnCpL45JCFwpIh/OQ8gYFBwglEdM+F6gyys/go8ehk/Y48LE3eSHW6NOeUBu0v0YGgobHqPKW4mPvuS0Z3eKPrBXH85r4ntsGMq0heOtdaDVxutWL3ym+zWQ3zNd4ghKT/CK3gpXxUrThFZYjn9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199021)(83380400001)(8990500004)(2906002)(4744005)(186003)(38070700005)(82960400001)(82950400001)(122000001)(38100700002)(55016003)(8676002)(8936002)(52536014)(66476007)(478600001)(76116006)(66556008)(5660300002)(66946007)(86362001)(64756008)(66446008)(7696005)(41300700001)(10290500003)(6506007)(316002)(71200400001)(786003)(9686003)(53546011)(26005)(110136005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?R8ot2QO1Q522On5LZBuJ0+PnBH5cZ57zPRhkGJn4tv5Ji7KSMk4bD76fhyjy?=
 =?us-ascii?Q?r4eHUwrPPnjL4fDdHD8Bb3tcNCFgWs+NFZR48muShUJd8+jAGJ2cbfoYtX+6?=
 =?us-ascii?Q?FSr39H+4gXUlQk5PC9kXkaHQ2qMK/LeGnAP0p66xFt1l46J5YpU7LYbV56Hs?=
 =?us-ascii?Q?CzSbXMfCQlk+aa1jXvARsQrMYrMFYJ9adsX27lbhQCLIKYU1pRDh+0P6C1jI?=
 =?us-ascii?Q?rB2N9P+M9gy0VoVjjdimdxV2EGXlBQ3kwV4QnlynCI5i97mpy//HilbPkrMF?=
 =?us-ascii?Q?8PqX/YwKpspXI8aY6nwecdCYhL/iXOyP89OosENJEKbudflBzVylBwXLDkXV?=
 =?us-ascii?Q?WM0XpWw0nPS4880pXdAVNtJljBwV0h7W0ZOwWHghrBwOQBUzQAUGsIxTKIE8?=
 =?us-ascii?Q?/3NKScf01bTtocCncmpay0aKEqTCwFoXlMcVpBloJO0kt51iKAlajlQEQ2C7?=
 =?us-ascii?Q?jvs5KOZzVDBewLF8Buq1ngco8PighRTwNbh0+UPk3zQvqxDgFM+//SWaLlgD?=
 =?us-ascii?Q?b/ppf5kin7qYg1kXnwrZSdwPfQoWuY/EpDWP8yINikmK13d47jXlhJFxu7AE?=
 =?us-ascii?Q?w4n/nGi6doXM5Y5nUGQBTXsRh0lpuaHNnm6LDZ0FLd8qy6jJQkl0JhyjfK8r?=
 =?us-ascii?Q?xnK1N0bKwzvCBSeggFYGsmGepiysRFOepzw245BTLa6eMcKEhirNNttu+jWo?=
 =?us-ascii?Q?d7IoVmOpkfgCrGrJjddtgqkv7bGzvVsOtMuN8cDigZ6NKGrT+da+kt61sjcM?=
 =?us-ascii?Q?2eYSlCYAEe8hBfjlhTFqoAlazyI/j99lHc/vTw+SXMlIgaB+TblEkHnkDif0?=
 =?us-ascii?Q?cry9Zn8T6ldxSdty/hJRFsVwY6VmCd3z2+8P5X7Vh2owcB4FDCHOokJh+dnc?=
 =?us-ascii?Q?uvFk0RMCeku6Kul20FRWt1FjbnufeXrNRW8b+rjqKWjRsS2cpO9w5SiNz5Rv?=
 =?us-ascii?Q?LzCfhKGeMUj5RJP/B3GoUw5CkRXaE7nXVP9Nv7K2bauKoSPFVswqLpV4ebpa?=
 =?us-ascii?Q?2fl3Em3LwhNzHS8qxODwTmbjxPDDgpL7CuoyvrYdjiPlSecUkeOSCpXXj8II?=
 =?us-ascii?Q?Yn+E8ieVX7jISI+Nmtxwv2zpvd6P7g6YYlToaHf0AwRgNvmjIFw+/KM5o3Am?=
 =?us-ascii?Q?bo1Z6UPqUPh1Iiv53l5GTGz0WPm+a5Hr0sOOXAWQ+XM79KeWpIJRcPrnRxtf?=
 =?us-ascii?Q?7wln5HUiDgnifa3Qfxw2NcUeXGCxdSLQvWWMnBjzPjqk7QgiisGuD9PJ2NEr?=
 =?us-ascii?Q?YNUKkT2t74eswy2rt/WLJI5u1wP0lF6WjDYLUb/ACThhqwc797O/PC8FXIgt?=
 =?us-ascii?Q?FdVryMlaah3TCR5A01uIBwqlCAn8bfAHD7RLrE2f2tMdpmZlDH/pNSaAnpA5?=
 =?us-ascii?Q?3JNqp9IaJxh2zgvOBCcNEoSFjrOWWmlX1Qao9HDGyoftIjvRiHCEe/5QaZag?=
 =?us-ascii?Q?6/2Q8PmmuL8i3gjKYfcTHxaBvBnB5rIANJPBeT8j6yGlOF++QfPB9HORbyXA?=
 =?us-ascii?Q?d3aqSW5RNsa3E8RvXzHMZ+M0cLYBs/Od9XJ9CgDYwtLpRXMGYImLgpNiY9o8?=
 =?us-ascii?Q?OH7ldgoOTz4y8jmoTEZYaL/F097f0XHt04jzSSk36A/DjzheRcF1ukVT+5fP?=
 =?us-ascii?Q?Sg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f71c9ff1-3e51-4123-c512-08db620f7d2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 19:44:46.6767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RytqQR1aBbQPxyzMnQ7hmylomjFMSZp/iMR62OnuxRyuwAAcmkcNH54Ll42147ejXPeh+i/JcacLISkzEomN+Iu93jksAq1+AmC2fYnRYt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3576
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Bpf <bpf-bounces@ietf.org> On Behalf Of Michael Richardson
> Sent: Wednesday, May 31, 2023 12:38 PM
> To: bpf@ietf.org; bpf <bpf@vger.kernel.org>
> Subject: Re: [Bpf] IETF BPF working group draft charter
>=20
>=20
> I assume that one use cases is where a VM (windows or Linux inside) does =
a
> eBPF (XDP) load into a virtual network interface, and the hypervisor mana=
ges
> to push that down to some engine in a physical card.
>=20
> In that case, we might have mixes of Windows, Linux and network card
> implementations of eBPF on the same "transaction" path.

Yes, exactly right.

Dave

