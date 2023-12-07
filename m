Return-Path: <bpf+bounces-17055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFE58095A8
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 23:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467FE1F212FF
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 22:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623F350241;
	Thu,  7 Dec 2023 22:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lpItzG2g"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D000D5B
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 14:49:36 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3B7L2v6U011288
	for <bpf@vger.kernel.org>; Thu, 7 Dec 2023 14:49:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=+abyZH7+yfiZdBkAteKDdLP0kaYbKTm0o/eu+x6Zjgw=;
 b=lpItzG2gyLseLTl4sKlrtTSaj/YIH29jSVSxQ0Vvf/IxlyG9RvJTukM48zgCxOSQDt7w
 Qxe33le6djUNFWqjtiZYdwViNRcAxe+d9RiED9fabyD6byv8bRsiiGyadQZqGMtNY3KQ
 G9tBFDNpEuzt4Ayt6cCgsXq9EJyWioDHX+kpHVfZrAC+xAgxvOoqp0cW1g2X8cJhwKA/
 iWLpj0vgsonsgLmetLcC8DjfwwRm7GQjGmAQNdPtY1/wrCXHKnxdLIJoY0b6u64rz1VE
 JUuHAUYbxDG67SgvMSoMK7/E6Exazb17xCzuWZl/Vmu4fGwimMHTz/OfvoMT8+EXBgnA 9Q== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by m0089730.ppops.net (PPS) with ESMTPS id 3uufrv3w25-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 14:49:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKWJFQ0YscR1ndcmNaYZj3uek+ahvc8cMtJ5790j7aV3138qMpg8anzMYTEPuJkvFBCSE6bq9l7wOcQ6qkC1DODgZiBJktoh8axt2MMSggBw8p9YjY642edERH//y85iXSggKyioOb0bogyyn2PghMsZxRc+n0OhFhUEjvUBDibPRFf9ibD1/VlARpLjosi9MGoYJH1Kg7+Qyz6EzRRC6xGZ/fOZjvkAe77F/nVtlox8n+sW6wrTlY4HJDxyWWb7OlmY8P9TzMCRo7yVc+kZwIf2PCMBzfgG6cJKIPatjZFWPOT/prQmk4SN6v/4LgUWqDaX+yUNRJoNG0vyRkxSCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xyRYOEaW2Rxk+M6XUmtVu/sJHiYwXg5GW8ryKDq7bU=;
 b=RLLVAUCzqJ6ergQY7pADrd2MhyPdtympZZNmq+mImRSOfLFYtGviRGsqRYNRWE3y7eYcHsmEnkXrkBNDyGdjvUW0IuwEPO6n5oA2jofwuRj09BoiJJrFx/uFK2oFlJ/uMdyIPpiqQGFs8lCElkD9DU5GeELGzT6XwaTjtZP60ZEPUdyTwtzyabwERAsr0+LYLReNSe4dZoF02UFdodaMr2pIBr2NdeP71EYggxrjeGiwEJEmuqWpab3ngMZax354Df0Rjp8j0jDtZcFYTmEAjXAbTbvwGo42ki+W56ZrK4IweDwJjhIpkRgYeTKqCICHYcd2zKyC3sbgT7kH/1O/LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5639.namprd15.prod.outlook.com (2603:10b6:510:26d::13)
 by BY1PR15MB6173.namprd15.prod.outlook.com (2603:10b6:a03:52e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.26; Thu, 7 Dec
 2023 22:49:32 +0000
Received: from PH0PR15MB5639.namprd15.prod.outlook.com
 ([fe80::36a:b2b3:711d:7805]) by PH0PR15MB5639.namprd15.prod.outlook.com
 ([fe80::36a:b2b3:711d:7805%4]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 22:49:32 +0000
From: Yonghong Song <yhs@meta.com>
To: Hou Tao <houtao@huaweicloud.com>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
CC: Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov
	<alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu
	<song@kernel.org>,
        Hao Luo <haoluo@google.com>, Yonghong Song
	<yonghong.song@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>, KP Singh
	<kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, Jiri Olsa
	<jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Test the release of map btf
Thread-Topic: [PATCH bpf-next v2] selftests/bpf: Test the release of map btf
Thread-Index: AQHaKRe6g/PRj+v+rkaeu9aVzk+JLrCeazh7
Date: Thu, 7 Dec 2023 22:49:32 +0000
Message-ID: 
 <PH0PR15MB5639B11EBFABD845D82B9127CA8BA@PH0PR15MB5639.namprd15.prod.outlook.com>
References: <20231207141500.917136-1-houtao@huaweicloud.com>
In-Reply-To: <20231207141500.917136-1-houtao@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5639:EE_|BY1PR15MB6173:EE_
x-ms-office365-filtering-correlation-id: 81cfa5fc-e7ce-4a12-e957-08dbf776c76b
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 FBvQtvG7xOR+aJoDT1d7TYpujxIREKMy1FITa5GZiZT80J+FVrfsbUdDPijd5Xw2d/Xsl3HwE7VQQRbC/Gt+hyzpqeZEB6akmRprkm23AqbdeLG3aoeS9uiG2hlsfb1bFRbmWLcPmTH3/DK70F12HklFmSkyCv36zOeWq7pGEhwVFYKiigQ0byVFx+htc7nHiCl+j9UJmSIpa4TZS5JI1xum4MVCL3EEvHB1062U63V3sgkip1oLQaCwHCnedarYbBq9XEM71cbU+5hhnSUtyMpE8snuAL6bbkCg81HBkvAFF482sIouZlAx8IMruMQO1wwNh3/NHEuMpiK9ovGQhaVvB6JjkiGSFdzBQrayCuRqerxWJvKHPsmakbn/5aSvypojDvrB/pgs+N/OSa+Jd3NCIxE8N45oNChkKtizqTtquvc5OUEX5mcF7PntpaIeY4tAqwkuK8w6NcNCrS8ToY4eSoi+30fp8UEyrhqZqkuY8rUSlGBaLGJ1ljuO1gM2H2K07FJf9MvKDWc5bAb53KEU8uCFB75LWUZYMapKMDiynHJ3IBnfECEY6jD+INbsACcGirVPyy+T+iIgwl+dRgfhjKG9bEHfuBm/TuQuXLs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5639.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(41300700001)(7416002)(5660300002)(2906002)(52536014)(86362001)(33656002)(38070700009)(76116006)(122000001)(91956017)(110136005)(83380400001)(966005)(478600001)(7696005)(6506007)(71200400001)(55016003)(66946007)(8676002)(8936002)(316002)(4326008)(38100700002)(66556008)(54906003)(64756008)(66476007)(9686003)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?ZsMZ+5CM9WtDri6UXMEotSf9Swf4PCVpmN28gQOxTm8CBhkZZfOEnovEse?=
 =?iso-8859-1?Q?9UnNyRteUQ5WI/oJwjIBrFBLSMidCmuOje5wnSuOcY5uLYhYxdsmrw5gXG?=
 =?iso-8859-1?Q?5KjluFGk8Tv/yh3QCj8mdSj7uhpjvSnUSPWfRYLPM+KKGDARD4+yLlaiP8?=
 =?iso-8859-1?Q?UkjxPCMWsdCoKbUIDngJ55VV/SQgBnX4LNxo9m93pGMptI+3E6Z003FJmj?=
 =?iso-8859-1?Q?fwaalbiRBv6EJPWFq9VSXoObD33jQydVzIKrHqgkbCtGHyLbwyyUnCx7ZT?=
 =?iso-8859-1?Q?WZEsDDST+s998GcSXU3E2lszvYCFLSLfI8RthsPs0YIKeQckJd//WPlRjf?=
 =?iso-8859-1?Q?ucib1sLzZj8XW04EDIh8H4raETTFaRlN33OW6L0VEEeb1M1fVgxckWWPWi?=
 =?iso-8859-1?Q?/4yfJaBim8nsSBU3jlSqj5Lp3Bn1On3GWGBWK/nH0hdgkD/cNc4EyzrBdZ?=
 =?iso-8859-1?Q?KY1XAuKD4hh7eTplDTcf+oxYNrgwE2PaWP3Omm9vp+0FTqiUBWXwUAiYAp?=
 =?iso-8859-1?Q?kQPEcGauEzzyM7Cp6xElV7Vxc7zC0PpotxlMl8wU7aWJAhudxrymywwJni?=
 =?iso-8859-1?Q?rBxd4pmUB47wtfFji/sShTOgdiC0Hzg5F+4cUOFwXcM9+MSm88voLL4tIb?=
 =?iso-8859-1?Q?lC9+cKKngRPNznL+iBVyhbCgnP+NcNd3RF0u4tC5A7IrYlMRYVZyFcth2X?=
 =?iso-8859-1?Q?wF65F6oMMdnKMlisHMi/QYMqydH68p9BfxEYK/6paJ9E+ckZiLX16l5NFi?=
 =?iso-8859-1?Q?F7m6GNKBqvvjR6PclcGz9fsCvZiCOX3Ru7H0l8136w2LNQgOmiL8ffZvNh?=
 =?iso-8859-1?Q?xUVoI5UlOJ7J5l0eT+mCzhlD3A6ou+giAmIEhOTKJqZppc6lLgs82ojZF8?=
 =?iso-8859-1?Q?PkeQnb7/LA1iqIwF8gJKdLrlP/VNWgXFdsT2pHcZd/PA+E1CPfkaPhN39f?=
 =?iso-8859-1?Q?hBoSBJ12iUNJ4R6k9MlsIUCxeHoHHdhqSOmKe8hpiAFnBJJ0ORyaDDaBKd?=
 =?iso-8859-1?Q?ItHWQB/f+WHc2dvgJ/Yy/B1dkum+Hn2EaAMLhSXb+QbAFkycfV8KO01+I9?=
 =?iso-8859-1?Q?wk79LpKm657Kh7bknuk/8CtnqIXsMjsOjupi4lXM7U2ftbrcNYNwyCsOCv?=
 =?iso-8859-1?Q?DNliQ5SRc+Yp+SfcGFfdAc7RqiegCIuT8F8rBJbgOz8s9a3RP6yI3lc5vV?=
 =?iso-8859-1?Q?aqFtFTgW4l+fY5VfNqI4J5PyJBJqv97eFM5VdP5WQd7QhH5rTvv3F6mtSZ?=
 =?iso-8859-1?Q?9ARHOiPrrexpyBgunXIcudkI+WvseCVJscWkP7JehRtdaECvfkKRn5NT/S?=
 =?iso-8859-1?Q?LsjAxJURKu5L25YxA0T/wd9vtq6AZoeQ4XIvn1pnNC3rRq4y3V7PTnc+lr?=
 =?iso-8859-1?Q?JVfwSOGzWa1u/8RDRMafhs4DAdw1+silt705s8AL/OvqVBTNP0AdUKTs4E?=
 =?iso-8859-1?Q?QZ0nmD03BB7AmbWjeiDnvqRSuIzQVR530TMAlbcyEESdToebUcaooWAQbG?=
 =?iso-8859-1?Q?1EPFfMcqJp/Nx6o3JZCmd/UNUHGo/9SvqlaqP89jAB7gkwDv+9i+xZBal+?=
 =?iso-8859-1?Q?jEslt5OQ/5+ZptYtf0Jx2/sJMV4ZYzZ+Qh/CGwkWb00gPeDFG7VRRwsMf4?=
 =?iso-8859-1?Q?NF6KWwVGg+XQyCTDY82UcSEx1n7zSN62dc?=
Content-Type: text/plain; charset="iso-8859-1"
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5639.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81cfa5fc-e7ce-4a12-e957-08dbf776c76b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 22:49:32.6499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SSfeHI9Z4Hl9S69cVmwAqCevS44eLlvrvuOw4pu7+rffjza/i2KA0FIjAUO1DpDy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR15MB6173
X-Proofpoint-GUID: o7D0DLrcbpgjkdYsqkGeUMiX9a8VGz6t
X-Proofpoint-ORIG-GUID: o7D0DLrcbpgjkdYsqkGeUMiX9a8VGz6t
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_17,2023-12-07_01,2023-05-22_02



> From: Hou Tao <houtao1@huawei.com>

> When there is bpf_list_head or bpf_rb_root field in map value, the free
> of map btf and the free of map value may run concurrently and there may
> be use-after-free problem, so add two test cases to demonstrate it. And
> the use-after-free problem can been easily reproduced by using bpf_next
> tree and a KASAN-enabled kernel.
>
> The first test case tests the racing between the free of map btf and the
> free of array map. It constructs the racing by releasing the array map in
> the end after other ref-counter of map btf has been released. To delay
> the free of array map and make it be invoked after btf_free_rcu() is
> invoked, it stresses system_unbound_wq by closing multiple percpu array
> maps before it closes the array map.

I tested this version and it is indeed much better now and can reproduce
the issue within 5 tries. Considering the test in CI will run by multiple
configurations (compiler + arch + bpf cpu versions), I still recommend
to add the test to the bpf selftests.

>=20
> The second case tests the racing between the free of map btf and the
> free of inner map. Beside using the similar method as the first one
> does, it uses bpf_map_delete_elem() to delete the inner map and to defer
> the release of inner map after one RCU grace period.
>=20
> The reason for using two skeletons is to prevent the release of outer
> map and inner map in map_in_map_btf.c interfering the release of bpf
> map in normal_map_btf.c.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Note this patch can only be applied after
  https://lore.kernel.org/bpf/20231206210959.1035724-1-yonghong.song@linux.=
dev/
With the above

Acked-by: Yonghong Song <yonghong.song@linux.dev>

