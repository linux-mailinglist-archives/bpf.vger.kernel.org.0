Return-Path: <bpf+bounces-14203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA68A7E0EBF
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 11:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A241C20ABA
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 10:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42551125D7;
	Sat,  4 Nov 2023 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DFafR1Re"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9EBC2CD
	for <bpf@vger.kernel.org>; Sat,  4 Nov 2023 10:18:01 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020002.outbound.protection.outlook.com [52.101.56.2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ABBD44
	for <bpf@vger.kernel.org>; Sat,  4 Nov 2023 03:18:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7MPXNkWfT38zb2TJ9HGXnmaPwoXkz81u9F2o3v39PYzHcce+kxUJYrD0cmm3ki9AL/7dEyYeklsV8Aq/+zeIqdIWQzIOcRzgp9Yqro8osDxAI5Eteh2m7564aTm28xpeIKOUObdDTC+9lwXOrcW2LTTYuvs6sA6kSBrM5mqcm8hRLGBDEkkYXEQnm+QHUEV80p7Dhw9CQgiD7OlGKUYkKWal3tVBmQq2Z0IIBhPrKyGTgHVNlzlADmXIEQr66ypYzAqqUH+9DAgbBPBmRDQyzViMvdH13sjhEcjSVRFMiCDKRb0rxnksg0a4Oq+5ffB6qKW/HhRKUVgsX46lpPXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFelxb6RSQmwwMxfUTYiD5xRKbGNK3sYmM+ajA3Jnzg=;
 b=Nom7ixiqJErxCbSJBMZBa+dacb+0QgqSvVGiOmp/MV3igTd+6D3P9yuSoppdsyynV+iu4yt8wqt5lqDhtFZnypWgFsKFiAUvmgbLbWj494HkcBZKq2JgsJ39X1CcN4ZNBR5aDnWTCNbpU5egm4F5A7xuvyYs7Cd3y4RvDFvkbz/mnlw4kdOKdzy7s+AJYCvsYXrvS67Dl0Qe989MTBMXo0s/ZBC53xp0d78WUZ7KOL2UdOBMlv81QuZWC7I1mYuP0KFX9YmT8VozKdjyHJyyGvOg40OqGBk6uLuAgE9Fh7NqYOC0WQxPfvpKsqeldP2w8iuvNCnRSd5xPmadztFlng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFelxb6RSQmwwMxfUTYiD5xRKbGNK3sYmM+ajA3Jnzg=;
 b=DFafR1Rebw4XkV5DEJZcXB75k2j7nHCkQjJY0s8FC+TrAdOzjzCEaifc3rfVIpm4HFInb5J0WrBr6CW230iGvS+7lGVZXqEOHiz07cVfdsguGjpV8fLGSMAs0Ac5NAwRMEEPQMW2YcdxOMgL4G6IyzNqkqhxQJF+SwIrnaPp1Lg=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by DM4PR21MB3056.namprd21.prod.outlook.com (2603:10b6:8:5c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.12; Sat, 4 Nov 2023 10:17:57 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::f39b:6ed6:4485:747]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::f39b:6ed6:4485:747%3]) with mapi id 15.20.6933.014; Sat, 4 Nov 2023
 10:17:56 +0000
From: Dave Thaler <dthaler@microsoft.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: "bpf@ietf.org" <bpf@ietf.org>
Subject: RE: IETF 118 Call for Agenda Items
Thread-Topic: IETF 118 Call for Agenda Items
Thread-Index: AQHZ+tNJdpVGRcy7XE+cNwLUZIcWW7BqF5qg
Date: Sat, 4 Nov 2023 10:17:56 +0000
Message-ID:
 <PH7PR21MB38787378F01B057C9FF7D25BA3A4A@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <20231009170843.GA236066@maniforge>
In-Reply-To: <20231009170843.GA236066@maniforge>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ebc73624-b6b0-41a3-aba4-7aec04b1926c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-11-04T10:06:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|DM4PR21MB3056:EE_
x-ms-office365-filtering-correlation-id: a0846f17-d66f-4c61-572c-08dbdd1f5066
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gMuUpFGATk+7ZEYkofezG+0+27kVuDD5O3K+H9hcz3ydCo2mkmiGrSvfnotKHb1LW7Sox0enP8hZ0sdUFJ9q2EqhAQOI7OrhMVmrXJcQ+rsIf2tvPq886I4yeOhCirWe6wFpQjkw6WvrFbQ+VVgLvjGtXSdlISgzyPHevDnFUQ6BbFAK1eIZ6lHCc8Hk5G8DVebeB4D+3JI5mgruLjuiMU8jIt96wgg2lShxUEhcwc/B/DIKihlFlvL6TrWnh5fTu9fjJjF+HbyhwChlMDIeXtgPTlIqjCWONqUOou87EEPFLGE+jNGOgrlC0n8DPbwZ+t+x915BHWsuORg+cT5ROd5Q72Q8TgTPxXiCK69cDNoWrn0HAw+F4L9H8rF2zcUYX7oN+zApdwdx4h1uRZrIsD4rEGbnuRSskX3YjGA6pHkFS17ekrs+F2dNwkNPtlHhgYDSzFgzoSjjeDlHAWRqozPlocql6NLztJCCwRC42ALn5zyAOoxFWhgY76XHq1dEeG+FkE6ZaG1gH8TVT6m44naw3CrlidZSjRjcLOY41ppgwqTdZHN/gSSybG7mUUMi7RNhdBK6xG+OQhRJXpC1/vqQTzBA0PZ+4LQemwU9gL7VITVdzQ7SgbPyfTazDgTQHs0F3mH4uHGViGfVVmDIZQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(52536014)(8936002)(8676002)(76116006)(66556008)(66476007)(64756008)(66446008)(6916009)(316002)(4326008)(66946007)(33656002)(8990500004)(2906002)(41300700001)(86362001)(5660300002)(38100700002)(83380400001)(38070700009)(10290500003)(55016003)(478600001)(966005)(9686003)(82960400001)(82950400001)(6506007)(7696005)(71200400001)(122000001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VOogbdSGs5TLidaWie0OjEEr/Xhyq6z9k90qnAaY9QO8OkWPUXpLiZpP1yuJ?=
 =?us-ascii?Q?vtZHdCNys/Cvfd9O33cY6fIzy43bMKlUScizwm31SHwnJcEbb2+FKlxKb+0q?=
 =?us-ascii?Q?EA1ShqGSVQW49XvnJXiI3fSJ/5Yaa4eXnefAgtkpWpoB1u3gvrtvLPLnbXag?=
 =?us-ascii?Q?0MevkdxhX71p35/PzoF3KerSjL3h+Y3htvHdRR+ICByN1aTYC9hb/TWDJI3M?=
 =?us-ascii?Q?GU8aTGbQ7atuoGTsaQaMlAezZqtPQSdLmagaGPqU+Yc7K3djEsLIEGU557nW?=
 =?us-ascii?Q?3XXbw9t+vhzIYbw8ILKgp9hRPXl4CXA5uhVD5JzEnlQFJRbjkbz48iebYSQO?=
 =?us-ascii?Q?E+LhW8NjEgi7sL5/CRKtwNyAXneBkn9jwv4+tkW9A3bpb/xI72XFszOBTMYN?=
 =?us-ascii?Q?WSzmVkX7HeNrjHMmYjfXTZMqRZi8sEJgT9FiIV9bVm6CAlkONXYnLVMGi/Xk?=
 =?us-ascii?Q?mrw1KZ9w8spRxrtrMT5SUlVO2Ay1FWKT1kO0nSP7tLe1K6FLhCNJwhD0pMie?=
 =?us-ascii?Q?rQZPPkpRzFsCieQalg3qaeUUSnr90TwQHbeki/2IG+6MlodEiCM70AZVJHkj?=
 =?us-ascii?Q?BxxpEb5ixBanx2sXhodcVkUibD64wVLak82MEH1XRZUss93KAVqzZKX0ERAM?=
 =?us-ascii?Q?lEc5eyUDIgCEIT3eg+TjIAoif1g4OLgGGZvCzSqPcwOXniNklaDUMBgsXwnH?=
 =?us-ascii?Q?Ig/z1zJQh2NcGbI/pVZXvxkhOB4k+ux2sD42UQLwluTEpDUxsL9muCiDtAGa?=
 =?us-ascii?Q?F1j5Xw9X8QjcmBM7gGZwMWc02/76PsN04+v9pj+EXOXm29UCQH77ThHY++Gk?=
 =?us-ascii?Q?83aYd24sJ8547w83RG8fFBA/6QYpIMQ/lbGQEvP/wg+Vc1x08cAiNtPf33nI?=
 =?us-ascii?Q?BvD0+aJjaOD2vFQZOjC9zsOxFTU0L5bmwFObtNVUGTSxDqE51crq3AbCUzUs?=
 =?us-ascii?Q?PbuJBvGcMk/lxRFOMH2+j1cK6OWkk0OyZdEC1g3nZkXZIMS45dY8sQxop0LU?=
 =?us-ascii?Q?EdTVdcxfHfMetEuxli/2sXkTzKt2mGMuaVFlAxTGGGvrCMGGpeWcXuxAdTTu?=
 =?us-ascii?Q?+88C/oKOHBzGtLiS7DurE6cuA5AC43l3KXYnIIUd3ECEonA4e1gqf8xX7mA5?=
 =?us-ascii?Q?ed6YOGUjf1iKsh9ZDAlA0KnzrWjla/xUAJOXJqBwh2V48tXhyTMgBeK/XfL4?=
 =?us-ascii?Q?usQuw7N4NMwls83EnJcJw8eBC6IE3my0hm8N3xU1X26gD7NsLtMz8i8BexWQ?=
 =?us-ascii?Q?q5eA3JiZDbMAIMYfJpKI6QMcOQsbOmttH0lYatbBfoo0LeoHbgAzx7+fzCj9?=
 =?us-ascii?Q?BBzX8ngytsV2F32M5eRBiRxkyf+xWo0F3+6cn1bEBMdNRwfWhEp/iTM+rk6/?=
 =?us-ascii?Q?bTNIDbmXIZJcEAwARMCWwGAJVGzqH5pNh/QQhFO+jp+ewtKwtPNXK8EZuB+I?=
 =?us-ascii?Q?vBEtI8N1s7mJP4ANKRfF/W2CwaeW4oXY4CxWGfU0IcADBKlZ/ddHoJspGOU9?=
 =?us-ascii?Q?8mDmoyy1IPqx2xpY1+rzFn7vkn8f8RACdCgiBZzG82kufGbIMscqN/LZ2u2S?=
 =?us-ascii?Q?UNyGchLIHDDa6XouSA7iDWGK8KcSWdbLUQBeRsIXUePWJLO1bb+LD4bqIpun?=
 =?us-ascii?Q?vVmwl14CLbWRHgfjspg2m8e7LDe+24pERX54sD1csa6C8mc9zUFGz0ErDQoY?=
 =?us-ascii?Q?hDXxnA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a0846f17-d66f-4c61-572c-08dbdd1f5066
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2023 10:17:56.5485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fff5fEJcA27cRb8cLW7I5K6UGmNuaKjMqZ3UthNkElpxy2PN9NdgVMU6P0OK0bY60KkUFA2iyqE8G2MlSeBaIl8upiRBk69MJHqZ8ZbK5LY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3056

> -----Original Message-----
> From: David Vernet <void@manifault.com>
> Sent: Monday, October 9, 2023 7:09 PM
> To: bpf@ietf.org
> Cc: bpf@vger.kernel.org; bpf-chairs@ietf.org; Erik Kline <ek.ietf@gmail.c=
om>;
> Suresh Krishnan <suresh.krishnan@gmail.com>
> Subject: IETF 118 Call for Agenda Items
>=20
> Hello,
>=20
> The BPF working group will be holding a meeting at IETF 118 in a two hour
> time slot. The chairs are in the process of setting the agenda. We would =
like
> to solicit agenda items that would be of interest to the WG participants =
with a
> preference to the items that address the topics of interest covered by th=
e
> charter. Please send us your request(s) for slots to bpf-chairs@ietf.org,
> detailing:
>=20
> * Topic and presenter info
> * Name of associated draft (if any)
> * Requested slot duration
>=20
> Thanks
> Suresh and David

Just wanted to remind everyone that the BPF working group meeting is coming
up on Monday 2023-11-06 09:30-11:30 CET (yes that's 1:30am US Pacific time)=
,
and anyone who registers can participate online.

Registration: https://registration.ietf.org/118/=20
Online day pass for Monday is $140 USD or $55 for students.

Agenda, slides, link to join, etc. are all available via the icons next to =
the "bpf" line
at https://datatracker.ietf.org/meeting/118/agenda

Dave







