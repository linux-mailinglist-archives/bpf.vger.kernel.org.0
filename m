Return-Path: <bpf+bounces-11180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AFD7B4991
	for <lists+bpf@lfdr.de>; Sun,  1 Oct 2023 22:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5D81728170F
	for <lists+bpf@lfdr.de>; Sun,  1 Oct 2023 20:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89C9199A3;
	Sun,  1 Oct 2023 20:19:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5552818C24
	for <bpf@vger.kernel.org>; Sun,  1 Oct 2023 20:19:01 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2129.outbound.protection.outlook.com [40.107.113.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E72EA7
	for <bpf@vger.kernel.org>; Sun,  1 Oct 2023 13:18:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlE9cZskfiZik7mIGX9mQkARwGhoiD8B0JmhqQ6bcL3VK88PdarAjF8WwsvlBxvDfpG3hfdKLVYQPXhSwat1PT4ufU/ZXSrTZCxs9XmDn6jARVq24JiJCz0yHI3ak06k/UQ+5eZUXgJ5CEeLUOHU2wwrNKZOf1/JGYyBnyUqm4AVHnLtg+LDlMEffqLFVbH2x60aovd3o8rJtyP4gTCus375c9/DyFpcC0SHPzQShSgwn7lvKbRDRpyY3jCvbrek4gJs9zf4M0SvmD8/S2F50ImzDyChMc+RoiC9zWqo9DrjLWspdWzoNNPErBYEZ2XSTrTE2EzFPpUmq+GBDhGbYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znIMf6mq6b7CbA3A3NuVnN3w+VrJwnjUg/IalOkiYOs=;
 b=HWxmzqLfo1Ywynf9SJicvzhuEd2sctvXGFnOL1UfmUs/gBUAyojx2k7zSTdqtFSbUixrcxwcB7MSk8MDg7+ZjM/znSewE1msRwaqlfaJnzFJ/dLBq53ksrpBj9pW2jN0ODw13Bdu418U/bLW6G4k2XkX5l6j4XoWYNQWqYmRLx5VryhWHO1YDyHGw3Wrnkapaj7dev74+pcmx0a2pA4jpuk5dpLm5rZqaupAnEi0jXVmHo+XSvkkuP1rjgaIak3JhmXSN8KJ6NXk9XNhid/FvG+fixOXZn/3nUcXIaPgUWGfKH6vsi31IhlIEJHsBzBmq3OBqlcrkXlOE8ZN/RZX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znIMf6mq6b7CbA3A3NuVnN3w+VrJwnjUg/IalOkiYOs=;
 b=wlCwC6gsDqKalzwCleFd3XcjYVfVvZznvCS6NgGDhBCCMiejIOStEJMtssUIUpiL9/CQ6C7oC9irtR2uVJcPC3lvknPvHjJdujD88cMTodFByGBtxCMXXf65z8iVp27ETCSYR4DSUQlCWwRQHnRfGT2XoqeR3Jc5D5W0Is8sogo=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSYPR01MB5415.jpnprd01.prod.outlook.com (2603:1096:604:89::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 1 Oct
 2023 20:18:53 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::9f88:8e:6f3e:640]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::9f88:8e:6f3e:640%2]) with mapi id 15.20.6838.030; Sun, 1 Oct 2023
 20:18:53 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "houtao@huaweicloud.com" <houtao@huaweicloud.com>
CC: "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
	"andrii@kernel.org" <andrii@kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"haoluo@google.com" <haoluo@google.com>, "houtao1@huawei.com"
	<houtao1@huawei.com>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "nathan@kernel.org"
	<nathan@kernel.org>, "sdf@google.com" <sdf@google.com>, "song@kernel.org"
	<song@kernel.org>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>, "Lad,
 Prabhakar" <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH bpf] bpf: Use kmalloc_size_roundup() to adjust size_index
Thread-Topic: Re: [PATCH bpf] bpf: Use kmalloc_size_roundup() to adjust
 size_index
Thread-Index: Adn0o4X5a8UsHuKkTTCN+9aLLPB2fQ==
Date: Sun, 1 Oct 2023 20:18:52 +0000
Message-ID:
 <OSZPR01MB701991D8F26C19D4A270F7A2AAC6A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|OSYPR01MB5415:EE_
x-ms-office365-filtering-correlation-id: 01ee4696-d806-4802-4731-08dbc2bba1b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7ZIfDSmpD9kq1inJ2Zo1HwXOiukELpG/JBgDTgpYgSHm3iuURnBZMLziklbBwhGTcL72fhbmItwD3MsQTNmFdVm40j2h0cq4VeL9MtHgNlfFmcPqQI0Nib58Jr5h6j/iLjLzox0i23Y5n8AaK9421GO0kKI5l0Cw21c9yiUo7lJNxOrnI5bcJc2fiyCcYrh9iTN2QUmzQ7BA15/0XHg5fQDvwpKMpT/AyMgnHPM19lIP/yOdskGEBprFlI5ZcymeZWWJMaMjV35kiSN/aZYwTTCj5mNipxhAYaKeOVNywTaq9u5+2ukB3BfH9R8fWQQd6ay2O0L1DPSxMf/XT3wZ8zsbjHxUn9NCkq1EC90U958R95RrWrA6YNVNGpqXOGjCrWZcIhUjMaU6TyMh0Ft/MAzLGJOdR0+zTYfuhT+6ihhutqGfGgjwJIXfdSw27mPE5enT2+ciprT8Z8JPZoetVFGFkDhx0RLzfPnATe+ln4yTR1tTlSjj2HdZvRmiwdifhbZg0zD1/XvzixXyqH0hM75e33rMutSfVQ2oEUYJDQOVdoTqzNVHPN1Fw+mC1BJFT5DFLaTeUR5vAW73+HIPlQJx+fCKRmauUsQepEROnBjIuUB3ZNFT6PhPG+0qpocX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(7696005)(38100700002)(38070700005)(9686003)(71200400001)(122000001)(558084003)(6506007)(33656002)(86362001)(4270600006)(26005)(55016003)(7416002)(6916009)(66446008)(316002)(66476007)(76116006)(66946007)(52536014)(54906003)(64756008)(2906002)(4326008)(66556008)(5660300002)(41300700001)(8936002)(478600001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XZStsQH2w9cu1DnIb9hV9vUwXKVmAUwNznc8Jtapn1Fkq0uqRZ8zQbOfJDKS?=
 =?us-ascii?Q?qjVNPmNqe2kE1Xpir9H8HM1hILmBpdOOxey+Iv0wqZB/QozYTIZILw6yHZKb?=
 =?us-ascii?Q?u5ajrcchBg+ZeyEd1+p83kUCBqJUoYgk7mwnSsNQw8twsImxWsONOSUf90Cc?=
 =?us-ascii?Q?IgnddqkjF3TbnNrbde2H9lkU24wkYyGRA/faGvB//L9shWtRoEtFX66K3DYA?=
 =?us-ascii?Q?VFi1XexcULmk5pvuPYxCpXlMSiwNAAjdhR05WtVVubVZ/AMUS0rjBX1w7mdI?=
 =?us-ascii?Q?88qmNqppp33Z99uPX9c4jsgbN+EeK6rE5QhDnUPBePdhzi+eCqb+qzDSJcR0?=
 =?us-ascii?Q?AvFgI1u3y8zxSzest8+0n3Fjbb412iNPfpZhz//3v2DXqMZdYIi+BT8KAOkJ?=
 =?us-ascii?Q?HGQmdWP/8Yt3VEpaDWUQlNvNRUgMsP9hHGjRQguMoINRG+J+uCCkMqmiByFv?=
 =?us-ascii?Q?vd7oGM4ZOQ3X5xtkoQLTalEwgl/nVsZsATk/06QJKY0SXrjIAxyOMUidVyzY?=
 =?us-ascii?Q?D055CMAcNZWgAS4TBFDhI8Z6bVMt4f29ndOgjh5doEdGQVQVlLiBdMCK/OLf?=
 =?us-ascii?Q?wV6m0ZlnLTD30Pvl8Q8+d1CgiapDZURhPH5RDSRQO1vjpEtP76wf0Y4mu9HZ?=
 =?us-ascii?Q?vDWEeWPKTfR01UVBcZyYSLYS/pB4tAI/Zi04pn6/L/+d5RbBuebfULUtG2FH?=
 =?us-ascii?Q?A5Ib7pPJQ2UpP4Ue2xqyUA2ZBwewNlF5AEBcXRYwwhCZvyIKaBIx8v2Z8LcI?=
 =?us-ascii?Q?3iRl1pnw99a2+qQ34iCwBnxTNEZ8QcVgmO39iBFa4x72DZMvpdMHVKt0FscE?=
 =?us-ascii?Q?iaSyd4cLgCVB7vEjRCanM88IqGgkK6TL6vMOp1G0Os/CxV+vpu5v0YEvF3Tk?=
 =?us-ascii?Q?fvV9588K0o6Z2sewOOimNLe02wexyAguDkL/mkBDYfLYfSzeCFBUB+Dwcury?=
 =?us-ascii?Q?VnRamY2Ew9aWSotvMXfBu+S8GLt4u0tIE1zrWhoHfg91UA70tm+PdTS/7SXB?=
 =?us-ascii?Q?Xef3bBMkFq2KBJBjAiRFpef2c3aFEqhMPycn+NnGhr46QdQMZsOPa+pDfY08?=
 =?us-ascii?Q?2/i3OIKGE55qgoJtFDIbU3y+3rqUKCDmkYkMnjiLjSx7yGpNZBfKlDHRsGoh?=
 =?us-ascii?Q?NfzmXLAWUW8KxiY5TxBtFWMiXUerBVOnAm6UDZgFVV6f5CqnrgegqfzjfH6V?=
 =?us-ascii?Q?oV/wc90u9e0+18ufcgORerhxP8BOcvfOvDGmE/e0i4pBklVaSphPNLog+Cyz?=
 =?us-ascii?Q?us1rTE1FQECPTrI5o4pKEpttoXOfwlUw+WJrmbCSDPmQdVCF2LxgXv/PPcsA?=
 =?us-ascii?Q?T7huA9RQWzQFSUxfJWOBH7eB2nU5i973yZi6505oMsD+Hwr2t+gnC0VDRf9+?=
 =?us-ascii?Q?EMIZUNaa33SLzvaQ3O8YQW0rQQ+eby9PpM3/T8/BDB3kT4ZGW6dTKHBkGbIM?=
 =?us-ascii?Q?9WwMvoqf4AlbEzqtyTPV3YT+V1rw7n3eS6/5q3NAYWyogJiCigoP4zC5Y3dH?=
 =?us-ascii?Q?OHTnwQWTfCBS8Ay23jHkpjzibKE/4rt0MKJ0tE+tbFTM5vdc27ZoHy3QWGgD?=
 =?us-ascii?Q?YC5MFVGaQYVFqGyeeWU0kTFOlWO+FSKcjc+YAioxKOVlcYFo7MDTm58XMLhA?=
 =?us-ascii?Q?UirdcqcAtPUYT/Z0oCgK4MM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ee4696-d806-4802-4731-08dbc2bba1b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2023 20:18:53.0374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8jwruJSgzg009AyAlwE9FIWDSdwzyK1/G4bFHNgJ9wDpwBStBpJqXf4I3r6b3DblGxyLOHa5kgH+lNc02gqmjb+geivQ1kp9SuuGnTyf4+vNAfbGgzNjKe0Xih4hLSm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5415
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # For RZ=
/Five SMARC

Cheers,
Prabhakar

