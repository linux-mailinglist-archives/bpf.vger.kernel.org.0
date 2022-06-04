Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD1C53D797
	for <lists+bpf@lfdr.de>; Sat,  4 Jun 2022 18:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbiFDQBa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Jun 2022 12:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237875AbiFDQB2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Jun 2022 12:01:28 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021025.outbound.protection.outlook.com [52.101.62.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6B222B1D
        for <bpf@vger.kernel.org>; Sat,  4 Jun 2022 09:01:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5t6KBhjVPCqQ0mWO18hgtArcPE886jCeOMDYaJsMwx34+YAG3sRZFjdQ0SL7YUFNFCv/BVC6m6xTDKHgQeGJV54qFoh5C8A9kNahi/6lQlEPbBk/rwJVzQziAupKqm5LIME7WFPKZoZZPIEUN5HU2jLfl4XyG/sPSQttBoiR2Ogu6qW/3f4jU735rOoWPT0MqNnwRYO04XZWIYA/kS9NiPEvW+NpxfWi8BG/N1dt23hkKffbOCMGy2EuG1PIkt0s5iSrEGM2XfZ8GFsbLWCLp4H52C8Yr3X+5Iy2LQLk7QRR0hpyFrWJcrzzFfuVDq7JGHA37II9h2+pchbHhXs2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxhHUVvqIOiwqdovYXbfAEBG+S8xJfu+koFGKlppgD0=;
 b=K/o640WAkcMr8+cxUjOAdsYadKSNUbuX1WqhHjg5lKpNsRvy4OZmF1a2CtOLHRquvoLkSQgBInK1TWKUMVEmCjD8el2GRk9371Q+zNtJVSe1ErcnNZp61roQIa+GrdEa/QwxGsJ25F/qFzLU+GPO3IO1S6fHoZ92KaJc5mhRwkUeCwOmPpPmLot8WSnvrVwcBBpga9lwuaow64QBG56Qw0ha0mxD2AfjML3gz0I4xi0bALm4orwfdu/SwcLtLq9mwwZnp1Tr1Lm2zUdQ+7bMA6hyLEroS87MyshAHFIO8C0IzhBn6VxSGLVGQ4o5PstQCj8lq5EzqWPom3cjVsw4Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxhHUVvqIOiwqdovYXbfAEBG+S8xJfu+koFGKlppgD0=;
 b=R18x/hZnMivceMjNott9Am1KrcDKOsh35cS58CVbPpDuKUHMiaVPmbOwfSs4Gfy+uPUWRc7wk7nDDDUMIgFcwlrRVacMOkdMqcd5iBRWBnxBx7tAeH2Ch9LV3d9QtEzTev/CBpTWzhKJg1T+dcDlIYkd6Dd4s0+SU81vKQxlnCU=
Received: from CH2PR21MB1464.namprd21.prod.outlook.com (2603:10b6:610:89::16)
 by DM4PR21MB3320.namprd21.prod.outlook.com (2603:10b6:8:69::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.1; Sat, 4 Jun
 2022 16:01:23 +0000
Received: from CH2PR21MB1464.namprd21.prod.outlook.com
 ([fe80::f48c:ded2:4910:655a]) by CH2PR21MB1464.namprd21.prod.outlook.com
 ([fe80::f48c:ded2:4910:655a%6]) with mapi id 15.20.5332.007; Sat, 4 Jun 2022
 16:01:23 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     =?iso-8859-1?Q?Toke_H=F8iland-J=F8rgensen?= <toke@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
CC:     "andrii@kernel.org" <andrii@kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: RE: [PATCH bpf-next 00/15] libbpf: remove deprecated APIs
Thread-Topic: [PATCH bpf-next 00/15] libbpf: remove deprecated APIs
Thread-Index: AQHYd3ykhrkybblzoU2twGjvKbYJVq0/BTQAgABkOYA=
Date:   Sat, 4 Jun 2022 16:01:23 +0000
Message-ID: <CH2PR21MB146415476BF463AC2792F65BA3A09@CH2PR21MB1464.namprd21.prod.outlook.com>
References: <20220603190155.3924899-1-andrii@kernel.org>
 <87wndwvjax.fsf@toke.dk>
In-Reply-To: <87wndwvjax.fsf@toke.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62da3e9e-01df-4f39-6f23-08da46437936
x-ms-traffictypediagnostic: DM4PR21MB3320:EE_
x-microsoft-antispam-prvs: <DM4PR21MB33201201283D63F3D10C8C6CA3A09@DM4PR21MB3320.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vuaipq/fGltjfB++AR1ffSkZfsJFxN1zqZhR7OQRnkV66rrKGNd13ui8JAIJjVnGo/KcWHgp0r7sWM0cbMpw4wGbtYet3Zr748VvlVihwXgsXZnVlbib701EKMQld55l+JFCM1KxEOuPXAgl2DjZZuK4Ajm/7Ox2oqn9F4gqGfqTVD1jt+R8Qp+7tr7b5DJJ0xZ8gkJIOhQL+Of+irzWeb+OkSQowzlouHJX1dm+WPXm6VTmojRX75h22dKHILVa4HC942czDBArIws9/zjsL0NC/xHAUDESw4/EKktww97VD0nmFdn0eS8oGZ0ciso8tJSgrri1rMQEIK1OF4FQg4EP+FAI99UBSO9JDknCW/+Cxg1gugipztQe26itPO1ZHvukPinDz37wpKXoUqIl6yMuNjEGJ10RsFUXuMIdfTHkMiTOhp/YvZsUm2F6o0Klxf8y0YET/qz3XCqc7OpdGf4Rs44Ji5TOObmJWN724PcOz+BmTVWUtq1u8gsd1W9mgTtp/YczHRQFtf0m6JvOW/HStygw+gx8s8GhcTNoC0pqPwFJfUO60+uVmjrUJ3PRV/BoOQwZmLM0PNU2HqHlWYN6htsVltAhfLcPZtE4YJOE0GQgxBJloSfD1aurFnF1BIroWt1rnPU4zDtkNpLOESgN6T9XmpxNyD+AMqWHPuKSvVOl9G0FWWytP/TRE3hqg1y1jRT07NyI8AvMTJ1dI9wQJj33JijjqBRgeFiBomm7gBlrJBZq4a0LCUCb8RQ/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR21MB1464.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(9686003)(66446008)(66556008)(76116006)(186003)(26005)(4326008)(66946007)(8676002)(64756008)(66476007)(7696005)(6506007)(38100700002)(558084003)(316002)(52536014)(110136005)(82960400001)(5660300002)(54906003)(10290500003)(8936002)(55016003)(86362001)(508600001)(38070700005)(82950400001)(2906002)(71200400001)(122000001)(8990500004)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fOX7YRk1tsZoGEfX0iTZr+ttVM/O1gRR3pffs+CBTW8LM83LiDC8HsWwxc?=
 =?iso-8859-1?Q?tcrJ4kmqQqULButKZA2L0JMTlWpC5ljTZe2EFF4ultMCNtaWeRvc4H2yRH?=
 =?iso-8859-1?Q?6wWGVJEauUKdtpeT7/iUx1A68Mo0mhVhUGDgdnlnoWXEVeTFeENlqw1gRq?=
 =?iso-8859-1?Q?BmU5VVOZEZ757mIpkz1pd/FV9PwwlFGUObaSb/94l8FgIw8CWr8s8rcRE+?=
 =?iso-8859-1?Q?IWQ78LhcpDGBvPAmoGs/Xc6VwMvOJtEk5OPdOF56FVrZK+J0DSHUlzkqs7?=
 =?iso-8859-1?Q?myv1Pjc2PmZEu2x7beJ77Kv3lcP3R2UhQieao9XAFWEf1RW177tPqDG9kI?=
 =?iso-8859-1?Q?h82upLDISNZaUmTYgbt2KuhbELKOQ9YIO4P6Ssc8kgJrTsXPYFRks6xExq?=
 =?iso-8859-1?Q?cE9jkL0ESRKHqfZW4yMFFFwYylcFDppGS2PrNgbQgSufOg0dLDOdOimM+Y?=
 =?iso-8859-1?Q?RLgPL1Wo3UQbnO8N0RhE+LZzCsES24fUaiJ1pM2/uMfwQWK3leOlilnNeX?=
 =?iso-8859-1?Q?mf2t+2phq3GhW1jDLAjceeB4L1ZjJBwf7nt49G+iW8Sr5ZcewomlBX/RfA?=
 =?iso-8859-1?Q?m0T989lzrxvDmcRQKfskCaUxuzkF9OD4iWvCkSYepDOCdVErFJkAESpivY?=
 =?iso-8859-1?Q?MDmGHKfpUQNR7gb3l+DOSfpCHxhqLu5Og5l79b6f/Ql1tR48rJTqsjNlMA?=
 =?iso-8859-1?Q?D9KuR6xdwniChSeLBqmjc5uYOcaGZX2E0NZzeVR+1ZAna+dlxJdwaUJew2?=
 =?iso-8859-1?Q?bhX5Xm3XZgiPxWOcHiru1lwNV5zcSMsdpkNcdbF2vi3F0D4To1hV0WoL5O?=
 =?iso-8859-1?Q?fKdnH6ejK1S3hrVI6xRunekJM8fk4EGsl6iG6Y4ZCghPgfVj/uYqsTw3BE?=
 =?iso-8859-1?Q?eq3Hq67CXJntTjJjPYwzVOVl3UNBHniuUE40mf6ZTo7COL1Eiogep7FLTE?=
 =?iso-8859-1?Q?jBfz8Deb2nG8z088pEShztcBPKihKjrtRlNN4BhIRSg8AHJtAfXUEBS2+y?=
 =?iso-8859-1?Q?vxk7gdycz2cdCGCSxM8JfPYyoOSytUMiNqwkusuQCQ4iZCvulXsS/8OfvT?=
 =?iso-8859-1?Q?rfboLr7fzBLE5iqg6ybNHjPnyDKf1+Ki1aJKy1R3Pihl9p/7OCBz3P5Db+?=
 =?iso-8859-1?Q?rEYGRe+z346tTxCMUKzYLEfOjPZqSCx+Grl9BMszikUDVtzRY99seUE97l?=
 =?iso-8859-1?Q?wVQDRkIl9GSzjB97bf+zVyXddU5FCxrxb6KCJpnuuO2KJhgyiIyOwI5BCy?=
 =?iso-8859-1?Q?tP0jetAHBhV4P29b+IvbFJXtxCCtU5v9gYQ506VW+sx4qDJOMU74EiYo9S?=
 =?iso-8859-1?Q?SwclF779E5CKBFnIeW47Q7ul0RpIrBgXei7JGI+4XQj/JKIrs1NifI7Coh?=
 =?iso-8859-1?Q?u9OuLvfrhu2zz3/LILGjbkz9/m7DGlxhP3J7kbfmvulBDTp6vjn3luLoMX?=
 =?iso-8859-1?Q?/b8WTi1OPvRzIpQX/Dm415rVV2Dlai1eDcBPXra/Sy9+g/WBESUEgmrBTv?=
 =?iso-8859-1?Q?zC/Tbex1jajFOdZuAKh0oWZx/9zOieR1fakU8RBQhS+7u9Hp7z6YKE94pb?=
 =?iso-8859-1?Q?X2A7+4Dn62ovlWgam9kMTb/o4rMbxH8VZW802Uo0rCKQOHqfb8PjVCtcfF?=
 =?iso-8859-1?Q?9M18mq+PmX88LoMxGPVMyz6W9bucY3Vz9nVEUFN/mP8h4dfLYUjAMLTtk7?=
 =?iso-8859-1?Q?bmNcrkdXsZDoIzWKthHUOkeKWde1qGnIO1ABvPbITspjoFTf2FMpCTclea?=
 =?iso-8859-1?Q?Cdnld+iGcafwGxY13tNfbsCM4ZA58oi9IUhH4duffxKYpUoiZ7R7sauW5Y?=
 =?iso-8859-1?Q?93VI332bQ4SNMgOeBseQcvBj4D9VAqI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR21MB1464.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62da3e9e-01df-4f39-6f23-08da46437936
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2022 16:01:23.6554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+nt5ds2br/tOGu91Gi50zMR2SYkplOrykpT+9hoQjFw84Tz6666g/KShHMSE7xD7qfGEQJKt/t3O87Dj3oQZuw+xids8ne47ETaCjeLFuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3320
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Toke H=F8iland-J=F8rgensen <toke@kernel.org> writes:
> Andrii Nakryiko <andrii@kernel.org> writes:
>> Any chance you could push this to a branch of github as well? Makes it e=
asier to test libxdp against it :)

+1.  That would help us in the ebpf-for-windows project as well.

Dave
