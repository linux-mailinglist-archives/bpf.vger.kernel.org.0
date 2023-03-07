Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2456AEF44
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 19:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjCGSWW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 13:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjCGSV5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 13:21:57 -0500
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3C6A403D
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 10:15:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZj8s7Wlk790FwiHAGvxfxVgyMQnxzAsmYtStCgwIEiaoqLWGTfa/WzvOrzNrcoVbTnPh9jekDHxORPkJ1Dk0/KcUAz6KnyHTwBHbaCeojT3rsHj+0Tnq+2ZJ+3+K+aK/3LOAlPtko/cS+GAYETte0lhvCOGzhYk5YT/g8Gi8GoD11s+JJPGCMXGUpC0rdIPhBCAHisprWSHefWwhSzCKPjW7xIl70PIZ0IBe8gCujKzcRGJdWnM9Af6b6g2mbYIAA8UuTIaPVWXoU4U9hYa4Ox37ZvcNqxsXPQES+Ez5CRWqew0/Gezm26E5msVVqYWnJolcXi6LfhtE9dR1moHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BmvB3azXFHneP1wVdQHrvu0gjZ8408ZgQMYcBJXD1s=;
 b=AB+lMjAMI1I6Xuu8dr/2EWvn4YRDtg9vQ/26DtpWbw3HDM3W84HkK0ht7Fe3BaijbzXj+OjoIwk5aA9epGXfLHF9+GWIRwnoEYBVP23SL4gfCxsICaAKQVqAeHgkPXUoyLJTPsJ+Mp5KzxsLlCrbaAcEM2fTKqk4xIcih6a+1jwDPhGHvgQSAK5umBsVD95IRYcSuuYMJqEDp5Jnq4rkBZD+EseLqIslwW1AWuT25uS/yB1thSpc1jgch1/e0rw5aF+AuSb6v1EVSxHVqwJ1eKz1+TODgG3IisZVr7hnMMf5iQPH8pM/9gGPmVOrAC6DURtEVWt/FhE7yQ61bOFG/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BmvB3azXFHneP1wVdQHrvu0gjZ8408ZgQMYcBJXD1s=;
 b=KFk+VKzayRIIuaee7Zc3/UzNaW/oZCgpsJ10bM9IINNYyGGK6dSIVRkKpBXIKv72vrH/F/g4LyLvuT2xiitEDelAB0IP5i6r3drQuZmJOC6OcyScklL8nq2bHue2E35jFOMJKN/VP/oLKVDWOh2+8a/sbkfIM8UEQ6pG2yBdq1Y=
Received: from SJ0PR00MB1007.namprd00.prod.outlook.com (2603:10b6:a03:2ad::8)
 by BY3PR00MB1390.namprd00.prod.outlook.com (2603:10b6:a03:3b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6216.0; Tue, 7 Mar
 2023 18:15:48 +0000
Received: from SJ0PR00MB1007.namprd00.prod.outlook.com
 ([fe80::945:20f6:a7d8:2684]) by SJ0PR00MB1007.namprd00.prod.outlook.com
 ([fe80::945:20f6:a7d8:2684%4]) with mapi id 15.20.6215.000; Tue, 7 Mar 2023
 18:15:48 +0000
From:   Rae Marks <Raeanne.Marks@microsoft.com>
To:     quentin <quentin@isovalent.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Leonid Liansky <lliansky@microsoft.com>
Subject: Re: [EXTERNAL] Re: Suggested patch for bpftool
Thread-Topic: [EXTERNAL] Re: Suggested patch for bpftool
Thread-Index: AQHZUHOBrQIAckd6vU2Kp/uenfwQn67vESOAgACJl28=
Date:   Tue, 7 Mar 2023 18:15:47 +0000
Message-ID: <SJ0PR00MB10072E7C794A3E2D8C1E86FDFBB79@SJ0PR00MB1007.namprd00.prod.outlook.com>
References: <SJ0PR00MB10058537EA379C1260C3C8A9FBB69@SJ0PR00MB1005.namprd00.prod.outlook.com>
 <b32ecbd4-4ac8-d925-18fb-735bf7d30ad4@isovalent.com>
In-Reply-To: <b32ecbd4-4ac8-d925-18fb-735bf7d30ad4@isovalent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR00MB1007:EE_|BY3PR00MB1390:EE_
x-ms-office365-filtering-correlation-id: 7937d30f-2ccc-4a1c-1b53-08db1f37f9e6
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wf+LZ6eHi+3i4Eap7qSa5Do/lpZ4uDOXSzr3r4OM43O14sq0AzRij1DtdLeDIhguLLO97PYtUq85/zMASv2+SIxabkSSl55+lPczl8bX1KW1WVJfpXJ0A4PDSysZynyjaQrowmDIhX6c8/KBrsVXJwFuIBNyu31zIs3H0BMsG4sxq6On5r5WEiblnwFHxcmVopx+1oUPp7ObqARcPVhDk5F82FtzcZPdnMwPIgH98taqh8iYXRcQ+EtLOM/KcQw9hZuMx2wBm5kpmB9Vj8fP58NGBNFv8wYnZMN10oM6EsR5TrKJNPmL2gK6i3o+yZD4hgWpCicMXvaPomKu/SIsE41YzxFxysllWrvShghYw1IG0otKgIqG6zNtrko7JqEqgy1Z9wWTHQ+5Hin+YV9RBwXjekGtKlZN0ivRXiIzc7AIw1YSLuZ9/d7PqpCREAxqSOEefS4arEwLoIpgN9tYjEQ9k/5VdOYhX7YFy5AWn6HEF/0rk7A0aogZspwJGA8YoWu/aPn1Y8+MkhdB79wJXR6wycr2C9X8jQQkWn7kFqoWMLvmAPYFxXhGoeGw8qLo0Ld+ghAKCPyCeO480prQmQGVpqG24mNnSQ7ILnfUfdYe0xH7B7Zt0MsLrYmh5QV7IgKbTlIkR/qK6Rxbfj0V3Ap14+kDVeQ8HEgITA8HWanSJvPYDrExXO64c8E/1/GYtGn5MmS+L4l+EBFvQxfTi3n86c0rHUyo43Yzxr715Lg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR00MB1007.namprd00.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199018)(66556008)(66476007)(478600001)(8990500004)(6506007)(26005)(66946007)(76116006)(66446008)(64756008)(8676002)(4326008)(53546011)(107886003)(83380400001)(66899018)(82950400001)(82960400001)(38070700005)(86362001)(41300700001)(10290500003)(122000001)(33656002)(2906002)(966005)(186003)(55016003)(110136005)(38100700002)(52536014)(7696005)(5660300002)(71200400001)(8936002)(9686003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?3OO+FM0r2mtyNYyMi3irQ1vR3ilDmnIg1B68mFDmqWg/DWoO3h6CAhcf?=
 =?Windows-1252?Q?pQMIRBelb5vLnikZPTshVoIQtOgRlhRele5he2WH+1IucEWI95KZH3ib?=
 =?Windows-1252?Q?Yu2Oikq6PVYIfvn3ru32kJQ0vODaIulw0DxXEEiE0lX9wDutQPSQb2wE?=
 =?Windows-1252?Q?vvYt1/247Bx4m+jxCtjmz0ye/qdY/vprYPUPzYLG7eWg4j5i4qSEkt8U?=
 =?Windows-1252?Q?fmA6+gB19yqHF8DgkK+7puQBFVAN3ySu2AoSvxgF5bJZloieIRVw4F0W?=
 =?Windows-1252?Q?uGc7pGc0pC2t3YCO9mayf4wb5D+xFaWFZQqqgsf8t64xhXUYkfS65cQ/?=
 =?Windows-1252?Q?rdUylviJwApPBTdw/dsC4gH/JiRuqt3YWlymzluf7etwglNiRMoGh/OS?=
 =?Windows-1252?Q?MaUTU5tbHNd+vqWVHEkZ7NuJWG4/tjIjq6trKzsxY/99Cz/wB4aveMxh?=
 =?Windows-1252?Q?nYFzUkxX8GaMRCzoc1oUPZWdCi4xHkXphDSlBAIb2UzKAogVjq0rPgxf?=
 =?Windows-1252?Q?Y3W9CuZaA4VUqvM3GspYoYIaHg8jjLs6LzECbV2NWO0nWkcbM2M6EFlo?=
 =?Windows-1252?Q?yhQXeJ+JMpL5zxpjWtVsrPzk+LKUCcATBcSFeI/HYcdFNBcl+hSW8qO0?=
 =?Windows-1252?Q?hfjEZGYfm6CCJ4/2Fsys5zdjC8f7JBmfuUS2K9KcfjBnmocqiag2+1yj?=
 =?Windows-1252?Q?+2sVKuzk7d+LCewzGcs1iwGZSH9Mu00Eq97naEbPYVlXqmFjqGDa+Asg?=
 =?Windows-1252?Q?GQ8WL1NxvQ/MB2JxlDPYjh/ZIGmlURi1/fe6lPT2tT+t3etTmA0bLluq?=
 =?Windows-1252?Q?/TpyaBaS7bLh/SAb5d250gtbaJ7S8VwdVDt2QlYYZpYEXSl0TsaENVTA?=
 =?Windows-1252?Q?f7rgstZ0RMrrkN/hJoHlCOHdek6ECtuC1L+YyhAjGtvRfX41ULPBlKJx?=
 =?Windows-1252?Q?+7rktWnywXAu0gjjrvgtNhSyVcX8vcji9mwHUTko6LdQGxW5HkdT8Fy0?=
 =?Windows-1252?Q?SldlTnngZJSeLEpy/k5Uy6yUadW9xP1o0keS53csu3Nut8saXNw9yZ5F?=
 =?Windows-1252?Q?2+0lLxQuZdHFutrKcvuYGfkzBrG3zFnUHj2Ikby5Fo7TEO9miKGJovYu?=
 =?Windows-1252?Q?5n0pkDlRWND0/wzLd1OO08S/VhFqaZtESzqD8/X7JZTs1nLCO/KNzFul?=
 =?Windows-1252?Q?QcG1hQcwSfof6JBj1YHfxsN/TCXHbs2YTOxxhHrbaiX20aV4GwOWP/LQ?=
 =?Windows-1252?Q?wXt6Cia6Voxes8+gmuPbewE7iy1BU9OpDUzCkolXnrlruf7MT1EJUhku?=
 =?Windows-1252?Q?S8ddscwALXoMtKVOlI0wV/FNxUDw/PAFOCuDbsrQy8zf8LTpkRdROpuh?=
 =?Windows-1252?Q?qPdCFLM6Yjp/FHXkb49WtRVh79F+Vk8Of8GGU5yLksJMmQpghmB0ypMB?=
 =?Windows-1252?Q?HIpIOyTvRvLDwV1m/22c3yotJSbECL0ZsPmjSBMC82YY8mHI3iw3Il1R?=
 =?Windows-1252?Q?v5zP86dmG7Npyca44XydZec4Ttjb+Y+XC01oNb3qhivRl8lGTdSQeOjj?=
 =?Windows-1252?Q?Olonxp3WK6FJP+ajy+12NbF5omkNFRWjK8TYd/ejqVXvSWe4JNPsUIXi?=
 =?Windows-1252?Q?FWD3ualv/bF1Wv4A8kvNwe64bfr1aTb257yKCLtbfGtoCGaO7KQiayxM?=
 =?Windows-1252?Q?AYAWNXI2r7DjXT9oxy9JqRgurFbhbS1t?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR00MB1007.namprd00.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7937d30f-2ccc-4a1c-1b53-08db1f37f9e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 18:15:47.9014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GgiV2Y0rNs2hBhul4DXPMe71R/onp4Okus81KNyGUWwcjhshAGwQCHtgZ/o5lLQNkLDn398D+2hFEGNJLt7G1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR00MB1390
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Quentin,=0A=
=A0=0A=
My apologies, I linked to the incorrect line. In particular, I want to cont=
inue iterating if the call to bpf_map_get_fd_by_id fails. I cannot disclose=
 at this time our use case due to confidentiality, but I can imagine a scen=
ario for example if a kernel module wants to override the return value for =
some reason (not our use case, but a legitimate one). Below is my patch.=0A=
=0A=
From 7f3eb5c045ec0169435c18af448ebe5eeb642cc6 Mon Sep 17 00:00:00 2001=0A=
From: Rae Marks ramark@microsoft.com=0A=
Date: Tue, 7 Mar 2023 10:06:34 -0800=0A=
Subject: [PATCH] bpftool: Continue iterating if individual map operations f=
ail=0A=
=0A=
If a call to bpf_map_get_fd_by_id or bpf_map_get_info_by_fd fails,=0A=
the current behavior is to bail out of the loop, which means no=0A=
other maps can be displayed or modified. With this change, the loop=0A=
will continue, so an error with one map will not affect the others.=0A=
---=0A=
 src/map.c | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/src/map.c b/src/map.c=0A=
index aaeb893..17074c1 100644=0A=
--- a/src/map.c=0A=
+++ b/src/map.c=0A=
@@ -705,14 +705,14 @@ static int do_show(int argc, char **argv)=0A=
 				continue;=0A=
 			p_err("can't get map by id (%u): %s",=0A=
 			      id, strerror(errno));=0A=
-			break;=0A=
+			continue;=0A=
 		}=0A=
 =0A=
 		err =3D bpf_map_get_info_by_fd(fd, &info, &len);=0A=
 		if (err) {=0A=
 			p_err("can't get map info: %s", strerror(errno));=0A=
 			close(fd);=0A=
-			break;=0A=
+			continue;=0A=
 		}=0A=
 =0A=
 		if (json_output)=0A=
-- =0A=
2.34.1=0A=
=0A=
=0A=
Thank you,=0A=
Rae=0A=
=0A=
=A0=0A=
From: Quentin Monnet <quentin@isovalent.com>=0A=
Date: Tuesday, March 7, 2023 at 1:41 AM=0A=
To: Rae Marks <Raeanne.Marks@microsoft.com>, bpf@vger.kernel.org <bpf@vger.=
kernel.org>=0A=
Cc: Leonid Liansky <lliansky@microsoft.com>=0A=
Subject: [EXTERNAL] Re: Suggested patch for bpftool=0A=
[You don't often get email from quentin@isovalent.com. Learn why this is im=
portant at https://aka.ms/LearnAboutSenderIdentification ]=0A=
=0A=
2023-03-06 21:46 UTC+0000 ~ Rae Marks <Raeanne.Marks@microsoft.com>=0A=
> Hello,=0A=
>=0A=
> Thank you for your work on bpftool, a great resource.=0A=
>=0A=
> I have a legitimate reason why bpftool might fail to open an individual m=
ap to dump its information. I would like to submit a patch so that it does =
not bail from the loop iterating over all maps on the first map error. With=
 this change, one map failing to open would not affect showing information =
about other maps. Specifically, I=92d like to change this line (https://nam=
06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.com%2Flibbp=
f%2Fbpftool%2Fblob%2Fmaster%2Fsrc%2Fmap.c%23L699&data=3D05%7C01%7CRaeanne.M=
arks%40microsoft.com%7C851d494f2eb6471a13d408db1ef029a3%7C72f988bf86f141af9=
1ab2d7cd011db47%7C1%7C0%7C638137789073658744%7CUnknown%7CTWFpbGZsb3d8eyJWIj=
oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7=
C&sdata=3DeFnU5gwT%2Fc5Zbk7mYd5cbUnTeMYz2ee6Y%2B8mXjzofJo%3D&reserved=3D0) =
to be a continue rather than a break.=0A=
>=0A=
> How can I submit a patch if you approve of this suggestion? I see that th=
e GitHub mirror of libbpf/bpftool is not the appropriate place, according t=
o the README.=0A=
>=0A=
> Thank you!=0A=
>=0A=
> Rae Marks=0A=
> Senior Software Engineer | Microsoft=0A=
>=0A=
=0A=
Hi Rae,=0A=
=0A=
Thanks for reaching out.=0A=
=0A=
Let me start with how to submit. The GitHub repository is just a mirror=0A=
indeed, the sources of bpftool are maintained as part of the Linux=0A=
kernel repository. This means that patches should be sent to this=0A=
mailing list, please refer to [0] for more details.=0A=
=0A=
Regarding the patch that you propose, I'd welcome a way to keep=0A=
iterating if we fail to retrieve the id for the following map, but we=0A=
can't just "continue" in the loop if we don't have the id from=0A=
bpf_map_get_next_id(): If we don't get a valid id, we can't reuse it on=0A=
the following loop iteration to fetch the id of the following map. We=0A=
would have to start again with a null id and to loop over all maps again.=
=0A=
=0A=
Can I ask in what context you saw bpftool stop before printing all the maps=
?=0A=
=0A=
[0] https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdoc=
s.kernel.org%2Fbpf%2Fbpf_devel_QA.html%23submitting-patches&data=3D05%7C01%=
7CRaeanne.Marks%40microsoft.com%7C851d494f2eb6471a13d408db1ef029a3%7C72f988=
bf86f141af91ab2d7cd011db47%7C1%7C0%7C638137789073658744%7CUnknown%7CTWFpbGZ=
sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3=
000%7C%7C%7C&sdata=3DLVZMI%2Be4och7tG%2BG7JuW6xuWwgoXNHgZjkiT%2B57rGNk%3D&r=
eserved=3D0=0A=
=0A=
Thanks,=0A=
Quentin=
