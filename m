Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C1168F484
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 18:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjBHR2b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 12:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjBHR2a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 12:28:30 -0500
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-cusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14CD1BA
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 09:28:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFh58LooZTORsF1T2VKUqzc6cm62ACE0uudLlzhzYQo8QavtW28C6XaaT7x1rMfjx5zFdcKsr80IzCs2+vewl4N7J77UQxB8yU2V/Fnl3Cw2/H1OWbG7omTP+0Yz0tS9t65gIh7KM9n0IePknuwBezHbg6/+rGl3rnAI4HgPGdozWptqSskfh1n6Vgh5OhT5aMsmvtaRI7yhovJbE+IthJZe3Bi7faAWIXNmBAyZ0kPeGadxG7LYJee/YmpC/6gGhRxmnqxhgRTL45puKga6UlEIhNLmG7h4EO939wUlyPnUEE8tqKjNgXbRzc5P8tOl6k0Ii49x7sBs3jt2VoEBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWsmrs8ufrzZFyp4D8HfrvZQIEbWQEOdyOf3DjP+dIc=;
 b=eqqwGE1e1H2M6s8faRtM7QdKueB+az/3bCGe3RRQIyalHgsBdvvG6nYoXBN+BBeFEdgSiKCYnpo8LJjrDgZSa1Nh1K2r+iXvA1KAQw26FllhJnTJ9PxRPX4jVNAnH0Ir34gNhWURim/V5KPONQ7/wqBegZpocYAbbOplmqo9Hjrd06zBm4ts5idtxKr77cYbQJ9CdjT1/a0iCTVPJoQCxI0EckORs2t7OhLXq2iehjEpBf/Hqbm/ne26fSrRgnGbwuOp39LPPVsnycDpYaF03yTdhpe4z2IjyQEXgk9MeGlF09BfvvRSnRe9qieVkhUsLCBRPNd4qbUIxWmzhHjuaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWsmrs8ufrzZFyp4D8HfrvZQIEbWQEOdyOf3DjP+dIc=;
 b=RcwcZjZjNCQufZPon/ANP9Qyq1Dyl+xHWT3qyE+1fpSwMutHsfDuf1tVwII+q7c2AeAgu6TaCWMH81nmavveEC6LdNCcisL0PE562Tkd+TK6CZ4dfTGUwyv/JnnUG8rcV7y69bGr/4cuWfxMCLsxv4YudvNqos8ExTEuDcb3eWk=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by BL1PR21MB3305.namprd21.prod.outlook.com (2603:10b6:208:39a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.3; Wed, 8 Feb
 2023 17:26:35 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::3112:be93:6758:2d0c]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::3112:be93:6758:2d0c%4]) with mapi id 15.20.6111.003; Wed, 8 Feb 2023
 17:26:34 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     David Vernet <void@manifault.com>,
        Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "bpf@ietf.org" <bpf@ietf.org>
Subject: RE: [Bpf] [PATCH bpf-next v2] bpf, docs: Explain helper functions
Thread-Topic: [Bpf] [PATCH bpf-next v2] bpf, docs: Explain helper functions
Thread-Index: AQHZOl+TrERI340YIUKwIUHtz2N6AK7FKkKAgAAlZIA=
Date:   Wed, 8 Feb 2023 17:26:34 +0000
Message-ID: <PH7PR21MB387847C84B7D6DA43607692DA3D89@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <20230206191647.2075-1-dthaler1968@googlemail.com>
 <Y+O7b5iKBUpskWLg@maniforge.lan>
In-Reply-To: <Y+O7b5iKBUpskWLg@maniforge.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f27a25e8-f269-4cd4-8bbc-a68e339ece70;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-08T17:24:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|BL1PR21MB3305:EE_
x-ms-office365-filtering-correlation-id: 272dd129-0543-4617-6ac5-08db09f9a078
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8BwYmReGR+HazvjL1qphDH3fmNMRQ4JtYAutaZhHGCOv2e1w4BS+JSVJV1kIeEawUJKnhag6jsYaU/iTP4ypof+Bkk+ZEbf/9FZd7i4qZKZPh4YYe9YPwePP+fbxn1KwhVf4iXeKUHFLTJbxjgWcX7iQ3dZorGqqqW5W5E/YWmPzfyASdzE9g5z0DhGDD+UyHq9FFZd+iwun9rYOolC2G57qsCSPx/0JOi7G2TWlCwh1dAW6jaEkGmb9FVF6p2k1CzjlORNH27gvBMjusoP7mSr/d9iosIvcVqBgiTgJHVo23tncHK1ZVM9yNHIFHGGzBpGhSsvysB7UFHWdy/yRWLiCGjbYq96/oiyvIRz+ExgAWl/DyUlaD3T6VVxlWYrywZUV3lcCkjqvkYNRlZ2Sv9k6Gggi0zjArkKwtxEnWbZMDHb8d/z3ZPz6CsSqte5oU/7zSFy2Kxo9K6IaTTlBEf8LrXaxwCN/RAdCyz5D0qpXyfQEZFcUXenkvitAIidSg5uydQiUyTVbjhHmC1ubfedz/53ZB8vhja9vyOBKEVlLP9i7w/PUUK2U5xl6ublGEUyp+IvVDS0YAgrrirS62u4eLvhlaw/zUH7S0hF2qCH9j9UNSy97GJdDTsNAsAOrYy0K05HRLb6oDrPn/L4Q57WsUSi6BC6GArhzlfxikjPEgNdgkxInqzoz+9aD0bRtbmDZHkOn/SDFkK7bfGLC2ZTO/uvQPj+LtUZRNscZnrgoWd2TSYjD8IfAD9rM0lak
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199018)(8936002)(41300700001)(8676002)(9686003)(186003)(26005)(122000001)(54906003)(83380400001)(38100700002)(82950400001)(82960400001)(2906002)(66946007)(76116006)(66446008)(64756008)(66476007)(66556008)(10290500003)(4326008)(33656002)(110136005)(5660300002)(4744005)(316002)(52536014)(86362001)(478600001)(7696005)(38070700005)(55016003)(6506007)(8990500004)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QsHW+1+eJSjE9MTSrQsRntN51tkbui3bwOTjLXgzJ7iwqIWynDZNer20H/C2?=
 =?us-ascii?Q?8ECOjh3VhTQw2uQKgAHDeh7L7ZYK5D0wZdqEZ2oyavE6VF3uEmUB7sMbZ03u?=
 =?us-ascii?Q?4mF6GZpvic2hLkwWzN8UC55sRIpB00qgFkznIF1hh9xhaPNs5mLca6E/m72Q?=
 =?us-ascii?Q?vfnJ8yJcdkY7boZVl6/foVoGrGfb0zb0287sQBQv1DgaI4hAyK+EF+tjXoGm?=
 =?us-ascii?Q?9oa8NHI0EWVG4AZvuPY2GmNxXeIn1QMuaP+E5M7pp2rPbzcCscR5F6FI3LZk?=
 =?us-ascii?Q?y2I8dtThIcZrz499nyrpF5fkhJhL81ihBknNLc6J2qgrUfzMUzCoUcThIo+7?=
 =?us-ascii?Q?hQn//vJpSKlD0/O06H/vzEhrgOtJd5FFL4ByksB4gobnGqshXFPJ81EWI8mX?=
 =?us-ascii?Q?PNkVuHGBzq8VPLlO1uyoK57EU6MtdmvPzXbGMj4WDXS8ZR4ZSjt2++lMcebk?=
 =?us-ascii?Q?11BxvFWL0lp8gC/oy/1aRpM2qiocXfP9aJG3gADkfTHsRiCXcEHAl77W7wTP?=
 =?us-ascii?Q?HDYvkxP/YjVakhypvW3YtGoiiT8gr9+hYj/IE2zG8WklOhq5ypAaOqlO7yJi?=
 =?us-ascii?Q?2kb2uNmWtcfyEb4ZIfM8fcDR/InElz76DNo0CO7AOYnBud6UuevgA429LLXK?=
 =?us-ascii?Q?TQ3dc5VQuSlBSpbJqZm1wGRrCAKGRF5KKKPPEFwSEi7cYeIZDnGXGxPawAO6?=
 =?us-ascii?Q?HfGvtgXjW1qBNzvWAv8WGpVH1ok/2HBjDrNmroX/HTx1efWpnfTIl3Uuw8tV?=
 =?us-ascii?Q?efaYvQ3J+eIUN5ujO+dHzOycLdEICc8etWgimUtlM5Xvw1xVFkFGm9gZnkIT?=
 =?us-ascii?Q?7CjCtaLOAKdqrdyuuHo0z5fcVzWlsG5Hpo/CrfIFA5XnOdeZ+DAC3lS1OBog?=
 =?us-ascii?Q?0GXpCm119O1rrkfYYw1r8OCRCzLPwEldKiggX6JuL5sVXFWze7/yuA+YzTtE?=
 =?us-ascii?Q?3yE8Kcl5f8z/Ly50DMxdWLDZuGpyRmPjWaL6K/GBPMbalzy01M+avazRXJbr?=
 =?us-ascii?Q?NezCPjo4Ug7Ww0Zyk1UbjzBMo6kLRRBr9K3ksS0TTgQpjjjQEV0Lz5wI1NVM?=
 =?us-ascii?Q?yIs2pFuL1sig8FSv6jM88jUKsckDJexOKmJjyHYBy0/oknR/daeEMbGJ40B0?=
 =?us-ascii?Q?nDNnU3bfbRKjkbtudcKGYfy34fkbu1YEoXsl5OCH3BqXRb85bJsNx51cfFCI?=
 =?us-ascii?Q?0S/g94iGTxcO1FN8iuZJJ3K5m1azs696AeaPqgbrqb9YCIYtNEuBRxDRCT25?=
 =?us-ascii?Q?STDlQ9nYdQ87C5GTzB5qhjXT+GrD2QJPfJ8GvGPQyXgWSGx8HNaCj43bg1kn?=
 =?us-ascii?Q?ad//tf70F9V9SvIdblCyZaxCx+J4o0ozKyy8rgWH2RYvIVenMQFDTPsJ4lXN?=
 =?us-ascii?Q?/yXAhbnchydPjKdmUGh5mgCA7oiWDOzOjT9DlNAahZZc+j50Qot4cV4P2QMP?=
 =?us-ascii?Q?O7kuciEQmhhwaZqQkQCf53bwmniXGqLjr/1eV5Xhrx6bohSql4+K6eZkIroQ?=
 =?us-ascii?Q?ekzThMzROVMXbSNpSfBbdgReuU3v6n/fR09ibWYIc4xpJGYOooaJk2AOy364?=
 =?us-ascii?Q?uxoaEuCMmAoTQgdijKidV74bwwNi/jtBUDLlTI1E3LYySqcswgNNq20WdKuj?=
 =?us-ascii?Q?qQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272dd129-0543-4617-6ac5-08db09f9a078
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 17:26:34.6653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tu9frItlgvF3YzJTweBuWhWOLFlMMXWHa8chQtNiYqrHv0teAv30a71c7JPpO0I0xyJI2ROu5qwrgdRZ5sqCVdPeVgUJtUmBUgjRk4z2Bzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3305
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

David Vernet wrote:
> > +Reserved instructions
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> small nit: Missing a =3D

Ack.

> > +Clang will generate the reserved ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d)
> instruction if ``-O0`` is used.
>=20
> Are we calling this out here to say that BPF_CALL in clang -O0 builds is =
not
> supported? That would seem to be the case given that we say that BPF_CALL
> | BPF_X | BPF_JMP in reserved and not permitted in instruction-set.rst.=20

Yes, exactly.  I could update the language to add something like
"... so BPF_CALL in clang -O0 builds is not supported".

Dave
