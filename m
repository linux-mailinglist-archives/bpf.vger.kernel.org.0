Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD175F47B5
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 18:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiJDQg3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 12:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiJDQgZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 12:36:25 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11020016.outbound.protection.outlook.com [40.93.198.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB76C5E579
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 09:36:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3w+r7j0o5DD033wnk9ImlthNOyOinwuVJCZRTWmDw2iKPTQdhnZx18cUr9jirsFl+ZJCZx/5N2J2WVMOHv8uW8gvWk+iuESh3Yu8KueThJv33+4nz6WQhXcQzmGwb8AX8hHtleUefgKCd6PFnlSlUfOZ2YNH4P1e7NjqjnQDO+N57yrhFHwUzM8TiKAIqTMHT8fyvc2VAefqnchzN3LaW/tBBYW5+q6l/XEHXPhlRnXQ1cvhCV8Km3DPpBuVyTegUPxEZmQb2GkPAiX33uCpnlw0QPbSR/2zZl4+n7+pSXApOiLREPR7V6Jqzaom/ZZcofBVUmRgCXEooeO/apqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJsKbYdpE70iWiATDZA0Vk+tvWDfqQOHWmQUd82oMIc=;
 b=DM3mohZ6usamgseBUX80KQB9sivuCSNXEZg3AIp8QE0sF1lzXzw2obhSU0ynQjA8bHrcnpTOkA52N3Ht9CEAux/MNN58nutggaRYI69j+cShcbMvZYWGbpnimR6lKZzW6aaMWo44E3zw6fRcRlae5SQfz+lSRM14EeBrXa9Dg+wJ6UajXtT9k+oQxF+GXKX2xp02aFj7RtkqKSvZVLxmsSFUgv4aEahPZWNDVIDqrk/GXfh2pzX6PyHu99cIUtw7MxODbLu/40OI82Qw8LSYgfMnPwM3PL8B+4n+uUIEYHeitOex1mOjbIxX6JOru48UXx/C+lRR7j7nI0gxjI4vNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJsKbYdpE70iWiATDZA0Vk+tvWDfqQOHWmQUd82oMIc=;
 b=M4tRKLMueFqk9ntT/hMvGrlqPq8dafSeu2dW6amy28HANJoUgiODHu10EY7cphzkgd55sjowU5gzyUVeFv9GQClTnrzm0vlF0Jw20a/xbxXD7TwX81QdFpy2MMdSiOW6mIa7POC6gQDXvhrgrNEabhRcBFaoXxM549Gntv0Z50U=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 DS7PR21MB3148.namprd21.prod.outlook.com (2603:10b6:8:78::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.9; Tue, 4 Oct 2022 16:36:23 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d%3]) with mapi id 15.20.5723.008; Tue, 4 Oct 2022
 16:36:23 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH 07/15] ebpf-docs: Fix modulo zero, division by zero,
 overflow, and underflow
Thread-Topic: [PATCH 07/15] ebpf-docs: Fix modulo zero, division by zero,
 overflow, and underflow
Thread-Index: AQHY0qNnkHKOYI8p1UG845fwAHqmHq34d7+AgAAQ4JCAAAHbAIAACxbAgAARhYCABdEJwA==
Date:   Tue, 4 Oct 2022 16:36:22 +0000
Message-ID: <DM4PR21MB34409A021A6658DDAAB3B5AEA35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-7-dthaler1968@googlemail.com>
 <20220930205211.tb26v4rzhqrgog2h@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB3440CDB9D8E325CBEA20FFA7A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
 <20220930215914.rzedllnce7klucey@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB34402522B614257706D2F785A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQJto119zhc3oBuNa-OuwoNWW02bDDRb_SGKxZxq=Wid8A@mail.gmail.com>
In-Reply-To: <CAADnVQJto119zhc3oBuNa-OuwoNWW02bDDRb_SGKxZxq=Wid8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cf180533-d37f-4e31-ac3e-e6729c34feb4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-04T16:31:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|DS7PR21MB3148:EE_
x-ms-office365-filtering-correlation-id: d0800ce0-d204-47f3-1d73-08daa62692e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UWWumNEFrPlBG1bJmne/1N5wGNmHm9d04cBIbxGil17aj+oLkDUwmK2BCS6vJE/UFS5G5ivbZZrt/M35TmbzRq4NBtCgdw9OIAZpdQa4DOoULKreoX9bszatwEVSzO7qV7iiaa0reKMmeYt1EafVWVzkLn7i1qxUbDg1yF6ozd0O5xpvWBzPF1mK7i8u9D8vjdipKzkgToTL7f4DY1AaqEnKzSE0wXrLKQsRx2zx7PcRb+wU5QYZyg4ObGXyWtj2jMgcixHC2t51ARN4g73ERKPxQGvByQ2jwCpHJnN1cOPEGcVlUpLeyO2XrNyANRwsKwJ60dnldJf1hghGtjG+LSe8XfItJHlfF5/ubtb4BrpWOZXquD8HLmgpLNcsKGO2YoisleWIoT4aLOqK0hcdENPB/eGy5v6YpxhYgsh/1BxGHYXge+Awxr2uQgLnkpOOPXQJI6YpUhRRdT0f8KZBOJPdXYCMmB5fJxECdU/It2G1CqiLY9DBLqCaKJR3X/oSGKQp3uPxuuYqhaUzP+rce5fWg7kkPpZsfPCCGjLOgX5r6+0VGtsGcPIVvJQoPM/sC+SltR8YmewUc1tv4K9jIznerAIlF/AwwtuV+fucftjVyQIfMA9/s0AmCIJIiZdu8hMtG9KlZMmfKxlC1iAWJZxWEY+TUTvXBfQhv4+0gK9wf6hh9tf+cpL42qdivNXPT1Bb5jgogHAQTA2CKCC798T1mZ2pvX9yDVwFy8hgdVjHZ9QD2KFm7w8Z+9WkxyaVKNSK07QrdaDnp8DjuaphDh+rk1MmwbwuuCJvrhp/37sU24qhJl5bZyXsSPS9flr0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199015)(41300700001)(10290500003)(66946007)(6916009)(8676002)(478600001)(4326008)(64756008)(66556008)(66476007)(66446008)(76116006)(316002)(33656002)(122000001)(82950400001)(38100700002)(82960400001)(55016003)(9686003)(6506007)(7696005)(86362001)(26005)(8936002)(52536014)(5660300002)(38070700005)(2906002)(186003)(8990500004)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3CCFUqUcNNdj/1K/t+GGy9I7wZFC1FQTwQcLPs95U+RhHbYm9PznXmsUdoFg?=
 =?us-ascii?Q?lqLoN/6yG3egnWTSdqLBKGgwg4NykxgE2jtpxQK/T+WYLcLk8nxf5HwOg0qw?=
 =?us-ascii?Q?5e/1LHkBUNb7qc+CiZMn+nni31pN7ozwvU9vmraw8GRNp4qE9wT0DApkn1aM?=
 =?us-ascii?Q?VJ1ppQx2ykHViU0X/+Jq92ZuiDSjUwrLK+huRBmCcMUhQYgqbtouHjF2NCIK?=
 =?us-ascii?Q?MsTp+lbb28K5RULr+A2x5tnPY7TBRsg/V+4WAP/uNgnJ4sZiokmaK63/R8FI?=
 =?us-ascii?Q?R/GjOV2kqP7sFtvoMI4El/iGr1dmnxUFcZhIBwp0rCv8X7uRDCQBA1Mx7Dn8?=
 =?us-ascii?Q?a+H2Fv4W3PG708viZTx59wsGqc3BaS2UAgBGawyOlENTuCAL55S/+OJdIBvu?=
 =?us-ascii?Q?GIUk+ABzrXX+WkGnlyjigD2Zoq9EdZtYyMjofRoCda9QSbqbomQ9M7gCUZ0n?=
 =?us-ascii?Q?02XZiBqi/lxP+X8y+prtEm1DIFYZKk+TkTsNRbhmSu7u5NeJkEPR5l4GYlwr?=
 =?us-ascii?Q?hInEshidajLm/2I4n+bQSp01sVTTnfkhaYN1IWdPsNSxZTYV9zTVNmMHqsHi?=
 =?us-ascii?Q?IaAd3gAa3vqKBrKWBzaqkVUUkCW17LOv9Es1KG12TV1v0rrno4qCOkJudoQy?=
 =?us-ascii?Q?7QO/gQey0lAjC07Wsw7SNHlsQBrOqG4B02HjlyL03+mwkmhFr+etUs1ai3M3?=
 =?us-ascii?Q?buVtdSsr5nqyJ402o9u3GrjUmMzZhjRdLbrGV4OE4d5cFKTRbTTTT9osF802?=
 =?us-ascii?Q?e1VW2mcKulTlyGQp4Q0BPBtJ4yJgCJZ9fvFqzxOVw/jV4gySg0q19p2YIvmd?=
 =?us-ascii?Q?9/9cVC44urYg/qaFFuaztlCkReIgl8qis1kX3LFavkFW+AefkmXffnfdGqRw?=
 =?us-ascii?Q?SOkylZttzQ/serfN3E0gvLNevtu64xGIF72JByCPr8fSvbVC2bFE8+a+Y48O?=
 =?us-ascii?Q?7jWiTQfXCSbVGdVYAvTdWYyR/rUyWXFWr4Yi3gGKdXspksHDvdaVGGCZr+uR?=
 =?us-ascii?Q?6KkoNKsAp/98fve9cdq/G3Cqara50vj/7cIDH0M+DUB/WUFQqsjA2DUgDkSf?=
 =?us-ascii?Q?DCT/oDSp3wAHjU7jCle4yiA/d8wdJe47w3zRQGbyttGNmVUAk9saQNH1QVxV?=
 =?us-ascii?Q?hN4mgsAtJD0fSM/LQ0VBLZm5N4Nijrdxn+q9uAr8BiBhOluNiyOwunqqpHgN?=
 =?us-ascii?Q?ZddTafP9hSbfs9wqqldTdKlY8zAexZjwmKnxxlx4nKQcXVq5JxMR/Mvb1EU9?=
 =?us-ascii?Q?Y7Tn5nyfgQTgmSw6gws0FbHID1HzytVEXutDAyC/aUsDIviM5nfP8gNRkQFx?=
 =?us-ascii?Q?P0h22rJuaMN/BaNiVRp4tIzM1L+p1HVjWjWc1yFeCwIdprmo0HMByuthCZaA?=
 =?us-ascii?Q?fIGsTN5BOBCJ9rFV7dIRo8bzWMzH2QjMPzCpTcVI0NCoo2PDPYwJBkO9JJfb?=
 =?us-ascii?Q?ue0IP+dp9Azd9UPp6wBfp6BpnyXHKt2/rlOF4BDSkJZiPG5iVboabm78WXe9?=
 =?us-ascii?Q?KcrNLn+7ff/+Uht5MjqMgz2IYOwUSSpQ/EOSdF4QvMXXpR2ecFRtp0hB3Uiz?=
 =?us-ascii?Q?T+W4K4XjfjP5tRCN0f4YaV1lYI/SRv6a1CCwaCzDRX7jMf9qBHdgz18zmgrv?=
 =?us-ascii?Q?XQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0800ce0-d204-47f3-1d73-08daa62692e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 16:36:22.9478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vghJF5i8RPcNbzzIAdDwqmkJZYb8o/EntLnEW8mJ4zCfDqIxz1Q1Z1THaVCoQcteD1YunGQy50jREhEgl7Z1slXoF4BMtdHIc+glAl+YzS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3148
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
[...]
> > > > > > +Also note that the modulo operation often varies by language
> > > > > > +when the dividend or divisor are negative, where Python, Ruby,
> etc.
> > > > > > +differ from C, Go, Java, etc. This specification requires
> > > > > > +that modulo use truncated division (where -13 % 3 =3D=3D -1) a=
s
> > > > > > +implemented in C, Go,
> > > > > > +etc.:
> > > > > > +
> > > > > > +   a % n =3D a - n * trunc(a / n)
> > > > > > +
> > > > >
> > > > > Interesting bit of info, but I'm not sure how it relates to the I=
SA doc.
[...]
> Those differences are in signed div/mod only, right?
> Unsigned div/mod doesn't have it, right?
> bpf has only unsigned div/mod.

Ah right, will replace.  However since imm is a signed integer, that leaves
an ambiguity that is important to clarify.

What is the expected value for the following 64-bit BPF_DIV operation:
    r0 =3D 0xFFFFFFFFFFFFFFFF
    r0 /=3D -10
Is it 0x1 or 0x10000000a?  i.e., is the -10 sign extended to
0xFFFFFFFFFFFFFFF6 or treated as 0xFFFFFFF6 when doing the unsigned
division?

Dave
