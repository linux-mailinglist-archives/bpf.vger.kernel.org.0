Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86384556DD5
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 23:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiFVV3d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 17:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbiFVV23 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 17:28:29 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2121.outbound.protection.outlook.com [40.107.243.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BFF12629
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 14:28:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmz5qtvZbZOmQZGyBnHiadhVVDBw+WHnTXuakackcTZxfnNSxUBcMe8pA75ajF6AFrHLDdj8bOSF1DeoX6h3XEUrzaMR5G7lb4bPGvcz1r+GylHQWz9453N1Qhj5pj2UoXy47v40GOVQ9b7kqLAEGHLQtFW9p1WMRLvI8/07vHoAOE++DFZUT7JRm9eHlYQJo/h5m4RR/6w76sX27Lywh5FqAkj52ojUVyeUVqhzVcHtlPhSkBeumUzdEKEiFIhyZw668IXyzrHLfce9/JC1Kut0Pt/8LtSNGmfcWnMN97ko4hC4Q95GXKih9f/pTdY7uWnpWfYOCsZAerMcDGzOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bm+5w8XFE3xTvpGM3PK+J4/Fxkd9APKTDzNwtIxeLOA=;
 b=LJ4f0XCln/MOoG9FZANG8bgxVzk1r6JGk3ywe2eDzv77Ej1Uyuti5PnhPYDmIQuXjmfHEJKq/WcBbWA82bDgMS/Q9fhoYlpZSWjEK3YyH7grp1UnBYghlwTu970i2upDTQxJ2GzDak9xyqKQWL+b2+F7v6ZfHWNchhg1oEirY+mPoDxWXHRMpCTHE0RDMvufEUJUN2d1bIQlgYjNfQmRWww0yh2BEyWi8CII55MKjqai9s0IUze9Bc50qAg83ePNzHi6gp8HvJb6kaQpmAiSrGaXZCQHFm1MuOcLXlmb30CLhxY699Vvi8A7JksRW2IxXKYY+vRCJDdr/IDJJ3OwtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bm+5w8XFE3xTvpGM3PK+J4/Fxkd9APKTDzNwtIxeLOA=;
 b=GqDh+53noektIwdhCl6cAvsh2f9UzACCARWl3RsCdk8xeklcbkDc3pQWtGIVGG80DfFyRARxYgm28H7U8OM9IWPgwXW4ozyDvv1EiRuj7joHQHIa3SRLDcqWndE+PI2/+JvAY2rJuCRP8xFI+BPjgsuo9VaHqNY0DR2x9L3x9yU=
Received: from CH2PR21MB1464.namprd21.prod.outlook.com (2603:10b6:610:89::16)
 by DM6PR21MB1417.namprd21.prod.outlook.com (2603:10b6:5:254::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.5; Wed, 22 Jun
 2022 21:28:24 +0000
Received: from CH2PR21MB1464.namprd21.prod.outlook.com
 ([fe80::5c95:b7b5:e99a:a026]) by CH2PR21MB1464.namprd21.prod.outlook.com
 ([fe80::5c95:b7b5:e99a:a026%9]) with mapi id 15.20.5395.003; Wed, 22 Jun 2022
 21:28:23 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Martin KaFai Lau <kafai@fb.com>
CC:     Matteo Croce <mcroce@linux.microsoft.com>,
        bpf <bpf@vger.kernel.org>
Subject: RE: scope id field in bpf_sock_addr
Thread-Topic: scope id field in bpf_sock_addr
Thread-Index: AQHYhMB4hBiLpvwe10aKofagEBr7Xa1ZELwAgAALfmCAAsGpAIAAFjeQ
Date:   Wed, 22 Jun 2022 21:28:23 +0000
Message-ID: <CH2PR21MB1464302C5A2E2F83D36AE472A3B29@CH2PR21MB1464.namprd21.prod.outlook.com>
References: <CAFnufp2KL-qNyDtWH5cNQ4DARqSQAygSi9GXgHD-iWs0XzJMcw@mail.gmail.com>
 <20220621012040.7tdjpw5jno3mv5l2@kafai-mbp>
 <CH2PR21MB14646DEA0B940D68DF13DFADA3B39@CH2PR21MB1464.namprd21.prod.outlook.com>
 <20220622200728.yffuefokf54rijfg@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220622200728.yffuefokf54rijfg@kafai-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e11ab2b5-92c9-4279-b6cb-17f99be2f636;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-22T21:26:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2013ff8-b95f-4e45-f065-08da5496232f
x-ms-traffictypediagnostic: DM6PR21MB1417:EE_
x-microsoft-antispam-prvs: <DM6PR21MB141780231CCD589542A118E0A3B29@DM6PR21MB1417.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 73TB4pwRItpUDimpFzW0qkUMdv1+G00iWW+QmuCZNF9EC3qVsmRKxF8+GH/GptcfpSwpzxi8ZebA+IEgWrrl3zsv6h980Y4LI7f8pbKDbjxUEt0Ldp0C60Lryykydf6q0yyRvLvWfZpsK6CI3NemFLRf/vRcGKYx9k6pGM09iVb1oMg4+JzaIrDS7oO/ATZdT99cszP+5Hvv5uVo8ZPimTUYA5mLFRrGB3dRx6GvWBEVFEjh8vucy5UBIbJMB90zecs9yrONl/Vp1kSuyKB2NnKZ/cji6eyDbu+Zy3uIYA+oVqbD1KlUTuszU2IWZ75WrCc+EcUP4h8f8DO/6h/sO72f/fwVfrLkiVS0oJYeF6wJYIo9+1S41HtEiMGxfAnVMCFhm6SVJWoYTfexZI7Osq2ERyvZYMWyNUZH3SXLSCfuvnoYTp9da4/tqjg6kuzlELBc4asT5mltLDWkuABoXkkRdlPAY6NRXq6JgY3vXmQDaH9WJtLtXO5nTR9Fzj75JiWXSi3BkDPP01Rpc2DnITZefMpBktVOK5wxqevv2bU4zz0W/ziXS6TSyURjRh6waIMZvFbakfELoDSw2NpL2e5OYxjNqnFkp5c/v4rBvEeMBf7xZw6ppFvvWWWatThky1ASgb59sufa+IVi8luJa/zgDkKy3iBw1SJO97up9RPmmyuB1stuuxBU0Tk52Vkz56AHU0y5H91ql1RiwRaixpjgBm+YaLNgiqdenjVFGW1o9+3KIjbQz2Yu/CnpeZ3ERtbJaWlGZJGggzcQSLbGzzRNciC48bIZtSDMViXbRu1mVl++q8oY878W0fRQ276E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR21MB1464.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199009)(2906002)(83380400001)(66556008)(64756008)(478600001)(55016003)(54906003)(316002)(66446008)(8990500004)(8676002)(6916009)(66946007)(76116006)(38070700005)(71200400001)(66476007)(82950400001)(186003)(4326008)(6506007)(38100700002)(5660300002)(52536014)(8936002)(41300700001)(33656002)(82960400001)(86362001)(122000001)(9686003)(7696005)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lqxSqrq37tPms6D+USOq+FPYIMp5OhPmCJqRNHDWcSqHLyzNepLkdMCvTRZA?=
 =?us-ascii?Q?H6XHsQpX6njB2AhqlbHKBvE4QXh4qKM+1Hg14vN8VkYJRxJhg8js0/dmy6RZ?=
 =?us-ascii?Q?mBKj7YB3ZX7Q47UQbJ3SmKMAZIQ5mxYjGfoCJC+nqB6X7BuIEcb5olaC8Ipv?=
 =?us-ascii?Q?OeJa4nKaHvNJj9wyp4F2cFKA2Cfs/f2hNH3c1VKtEiIGALD5//bGFuD+RwjF?=
 =?us-ascii?Q?1sBNU71RRt24xZlbd7ic0cwfE204UdvBNEEUmK4q/aQiCDqnbX9nh9MXBsx6?=
 =?us-ascii?Q?Iaed7OPVdbQmeVLXzN5PjPRrwYPRQBrji2M5kpY9WFFWIlesgCEma41+ezVO?=
 =?us-ascii?Q?0qH+3YU7q668EBxIxxFN81aZYHpri40YWWsvEA6ulLVQvPofbnlEH4+eSWsD?=
 =?us-ascii?Q?wxSdmy6FUul9TDn6AnkyTNR7FRWbtS5dkQFAszzRJ9Q++7DT/5+yOJOdW1ns?=
 =?us-ascii?Q?KQMq8xzooHN6xSRLTONecrFV3B6x2zVMZtfbVM/OczwLHKNqt9RKl8z9UORW?=
 =?us-ascii?Q?NMUSi6zEOnpVQdxuGMezUIhQLISgVWpR2RdDI/WjmZ3oFtJ1CBLovr6h1KLo?=
 =?us-ascii?Q?bX2vvFVCAKT+TfQfdZOQ2UQAllL5L3x90BFyLhdKbvEjbj3eYbpdMTqe5BtB?=
 =?us-ascii?Q?BMeFNQr70MbXrncmh6PyjEf7dBxzSmF1Rg1a6j3gveP+nQ+GNJRRWHEK14hz?=
 =?us-ascii?Q?Mntz09xgReLOU85l7qvBNscnQtSD2fzC8aiE1Wg5eCaNPdz7YtyTmGfv2tqt?=
 =?us-ascii?Q?bxpBqTRaZtWkRIxJmkxe8o+bf/hKlTOg85+BalT16Cz0l8UueMwao07DwBBH?=
 =?us-ascii?Q?zsBfL1OOEgDj+1yGMU+hlWZfLcSqyCgx2RqxzDMsct59nSMgss1yk8Vopcwb?=
 =?us-ascii?Q?nkncQQpE+J5jHa+yKxNQ8yOBdBfTJEVwcWXswoL4SPF+Lce42+hTUcqBOncp?=
 =?us-ascii?Q?3GgrQquzCQpBP3QrzZNg75gpLZv/qiTYfpBbWtU+Y9ajSceOgNNuUuHnJ5/t?=
 =?us-ascii?Q?eIUqoasRgHtM7RmylC6cFTW0JTVWScU6zXbH2fyaxsAiXQQDpGmdOTOCA1Zv?=
 =?us-ascii?Q?MI443yXoXlMb0nDTC8BiTbY3p+0V/CVyaSVpQWX/c1iBI4bhl1RjQLZy0ciB?=
 =?us-ascii?Q?1+k+EKcMa/YwkCiGPmEWmWWZuw3c46pxNhedm0s0gJ90rF/bnSW9p9Gm+xYN?=
 =?us-ascii?Q?qi3EmXEtBRYGvLH4J36rN4q67LOsC6u25Msx+dGrhFOQEvl8VZTAz1mXEraJ?=
 =?us-ascii?Q?3A5xeUi0qm/vkjKt6SZdLgHapG2wEFw6yNJTuQquUP8mK+BXfYg+mBXrkncz?=
 =?us-ascii?Q?CfHtld34Ie+43Zn3h7w5eQcWTHj2gWg3ERvbxMYUvCOOTu0friNSBqSO8ks9?=
 =?us-ascii?Q?ioIjGRbH2/Klak5541BVblXTUq/hM0HfwviLtj176bEA8snCT7zYdAlMMznk?=
 =?us-ascii?Q?3kzxEmk7HKBkbEtKUb5Xa9vbq9El+bfuTlQBB60oY1HlkylVT6TbLmJtFyGk?=
 =?us-ascii?Q?Kuf5oGAOzhUFHSRTayQyQ0N0wX4Ltc08Y6Iz4ceVEPzSf9dehWhpymx3rt0I?=
 =?us-ascii?Q?+uzhPRnx9xhgNd/RskIIPCpAB9tLklGphAIN7vE3mT8Tw6uZuk8vot7KC0VW?=
 =?us-ascii?Q?m4S3aPW9rr74hvjLYZfzKXplZQpK+C7mVvJMiiJ2ZlDQOYlQ0SHnInkYJaET?=
 =?us-ascii?Q?vH0rmw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR21MB1464.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2013ff8-b95f-4e45-f065-08da5496232f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 21:28:23.7893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /TH51eGjqyoXrlANXtvh2eMTTnvl4nnwfzuBOvgr1TwvPtRtv4Wihv/2YLDVHngFUGqk+tw9XvFrstYJd8Tdv/y16kB9MnSBsD5OUZO193M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1417
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau <kafai@fb.com> writes:
[...]
> > > Do you need to read from it or write to it?
> > > You can try to extend it.  Take a look at sock_addr_is_valid_access()=
 and
> sock_addr_convert_ctx_access().
> >
> > For me: read it.  If you're trying to, say, track the set of all
> > connections, you can't do it simply from the IP+port pairs, since IPv6
> > scoped addresses are ambiguous so you can have 2 or more connections
> > with the same IP+port pair, so I need either the scope id, or an interf=
ace
> (device) identifier, to disambiguate and know which connection is which.
> >
> > If Linux has an API to get to it, we'd ty to do the same in the
> > ebpf-for-windows project as well, but right now I don't know the answer=
.
> For read only into any syscall like functions, it is usually done with bp=
f-tracing
> in Linux which can read the scope id and other args.
>=20
> afaik, the cgroup sock_addr hook is more for changing the sockaddr rather
> than only reading it.  If the sock_addr prog is to be extended for
> sin6_scope_id, it should be changeable also.

Sure.   But I'm getting the impression that it's a current bug/limitation
since I haven't heard a way to get (or change) it...

Dave
