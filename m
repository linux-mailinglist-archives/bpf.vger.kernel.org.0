Return-Path: <bpf+bounces-3816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C2974412A
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 19:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1334280992
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 17:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B07E171D8;
	Fri, 30 Jun 2023 17:25:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCB2125C9
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 17:25:17 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7825119AF
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 10:25:16 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 2A7DDC1519AD
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 10:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688145916; bh=TEOwMTsF+S0IHmTYQREH7K1opfTB0zPAqY27qRQ2yqw=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From;
	b=weiEZ1ghaZoqCVG84Xvl7ZTAMy42cAu8jagaEKxmH1TTY5tWfybR2e6qtJ5YIxfgO
	 DWhSuDpyIs8x3RLtAggNYQpavCwDtia+oW46ZhTCYVH7J7KO47Tv9Z23eZyb0WDK25
	 ApwN/GuT3j4rcgWoiD9RymlWos4sYXyyfqC5zuhU=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id F16D5C1516F2;
 Fri, 30 Jun 2023 10:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1688145915; bh=TEOwMTsF+S0IHmTYQREH7K1opfTB0zPAqY27qRQ2yqw=;
 h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=vxnMBc5E7kWTHB4K744AOkkRfR5UNbgU+2suHzlxdWAyRziiH11+wVSXVulHQwYBw
 FwXqncAfEe+5c58pnftPuiorTj20U898Rl5tZp6soGbIomr0KKewU65YE7bFoB24Pt
 JwVfnrkALpAT03OV56uyhhwlHNIsfAIasMh7Ilnw=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 13E2CC1516F2
 for <bpf@ietfa.amsl.com>; Fri, 30 Jun 2023 10:25:15 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=microsoft.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id InKvoDlNrh2U for <bpf@ietfa.amsl.com>;
 Fri, 30 Jun 2023 10:25:10 -0700 (PDT)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2112.outbound.protection.outlook.com [40.107.102.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id EE3DAC14F726
 for <bpf@ietf.org>; Fri, 30 Jun 2023 10:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g87GPoUIYaWSnXIKXm/iMTlLEiLuQhpl/ZkD4giFD6YU4R6ZcRjvGkhZQNkIQVHCDgQ5S7Vm7CrpDzm3ieECwX9AkpengDHkGMls0h7q4qLVznaPrzXDzyXKIzr+6EhPwI7c+RI/bNMlry0T/6u+y5ST7lMP955xdPR88My70SutWa8pWXK5ul5843EaSywCcx7op3FVMjhFJWyq8edUOnpVO8QN3KxS54wkq5p+LHT+zIerdmlTZwwhHzc3hduFRi3imaJAtvLgZpfDuuasoT8jGb4iJlyEh9wMrtwjWfExel50UQ1twvQ0WczYmX7SAJXFPs4Pr2juNkXnbYi+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWOZwTxZb/aKcLKpXzT4166sfEazsvzxD3kTx41F2JU=;
 b=J09KkVMtrKI+1/t6wrwcvxWxZnqnOE5eMBDRNdWFvPqwhetkgEz/q+gNbirJnG9tAJuTgJcEQkLXftOMa2lvzmL2DeEzpoJBv6Kdfa3FfsgBG8NVqAHAt8j/aYiCRseJiFDNpA7g8fU3NNywNA7AkGlgnpRuZC8e7sCajLvViQjh/Uj0UiNV+iwdIRo/7yfOJ3W5laR98xwwEijpk4n6qU0IVoSt3UErsuQ4QFeO3vCQfxUHB7i1l0AMwnrFWM6aenr/vl+UtBMreJN4cEP33WVbcLWe1I/AE60KuSS/0I59WTxRxx+AtarnMXWqY/DFA4F5v9nukAIhTlwlkd2lyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWOZwTxZb/aKcLKpXzT4166sfEazsvzxD3kTx41F2JU=;
 b=J2KC2H9BmYmbmGsHflpBQmUnQDB4wSrG+mTdloMhO1u5VosWZNQZlojEKfStJz0FNc9JY/lIOGNsPwyNgZ9+mQlAFZVxkewtv+CWde36OJV3JhlnmcBzVSM7YOX8/8PC9DqXki+bMQBjjZEvX46s5ApdCef716LxR8zhkW+LNb0=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by PH7PR21MB3285.namprd21.prod.outlook.com (2603:10b6:510:1d9::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.4; Fri, 30 Jun
 2023 17:25:07 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::8708:6828:fb9f:7bd5]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::8708:6828:fb9f:7bd5%4]) with mapi id 15.20.6544.010; Fri, 30 Jun 2023
 17:25:07 +0000
To: bpf <bpf@vger.kernel.org>, "bpf@ietf.org" <bpf@ietf.org>
Thread-Topic: IETF BPF WG meeting scheduled
Thread-Index: Admrd7WZD2Oqb8esQTObev33yrwAGw==
Date: Fri, 30 Jun 2023 17:25:06 +0000
Message-ID: <PH7PR21MB3878E5586021FD86130CF03CA32AA@PH7PR21MB3878.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5613ba4c-b79c-4edc-b8c0-fb88995f9ed0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-30T17:19:14Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|PH7PR21MB3285:EE_
x-ms-office365-filtering-correlation-id: 805f78ca-9d6a-41f0-065a-08db798ef2d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hb3DQ/pR9+V2jljcVNY2nwXoF4kpjJJENq72QTc9NMjiaUgZqam+YlQLPmBNvJ1k5cB9Aq5svNTPCHrwGBorto9BAlvyJfikISlTNpKExwV3eR9q46x1WYoOqYtrwUGa6kbuEQt7cB9UDYVro/iC2ektX6bIfNzh3d8peF7YqmKJD71o/thJWq62SwNYOBor/0usGXPI9a6Kt98PF++vkgPAnA+VtvrqJ2TV4WR4SK/UkthyFrh+6Xo5IdJBoo81qXYe32QsUmlUA60Rg65XDcNn5CyDu5w9D8uGh2QRhPVCk+1X06upQw/MSHyfLnVcyif5dFEgwS/8xSFaN5q5shre9dYYgLfxn6gIkvd3ZSd2srepEwVviMgPY2wwnSZc7AJexhvUtpvgoEXwm7h44waqA7lD3+AlyCPIKaDezhv634iKPlh85d6zFVew/kQmJDlQ0LsFj6j+AxJ0wCQbGBLXjEZ0rjo0UyLQmQ6ZcmFXig9XrIpAzjCG9xkM+bZE0PHKLbOSmUXZJYHcfjM0h+EKpI6mlz+Z00QJDBd5nRwK4/xymWZ6dLuRpVixgnhaCto4OE+WJ5d8eawjQNWbYHgjj3IgUulwUIf2ZKrvDke5jV6cQSxgKXWsk3rBectPWPR59y4+517hXGKkvg10Nw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:PH7PR21MB3878.namprd21.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199021)(33656002)(66946007)(76116006)(66446008)(64756008)(66476007)(66556008)(10290500003)(166002)(478600001)(38070700005)(316002)(52536014)(8676002)(8936002)(5660300002)(4744005)(2906002)(41300700001)(55016003)(966005)(86362001)(110136005)(8990500004)(7696005)(71200400001)(6506007)(186003)(9686003)(82960400001)(38100700002)(82950400001)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ry2qrfFStAnPOyy2ccQ1Sa8L5igxYN+5gM2y6WtCoWVfYIMsQzg4Q1Q1MtPF?=
 =?us-ascii?Q?JC5+fQvaYPd7CjwyqC8UZ4JQYqMIdwSQ+QkpB5IBwmEuBI/MVHbnoqTzOCiS?=
 =?us-ascii?Q?ru9mm3eio2TY9SpRYkctbP3+jKAH+me8S74a4i/MCA+KX/mHLsOyjPOA3rzm?=
 =?us-ascii?Q?XeStxZfckjdIBxkvsbVX60vKhLzcUpjZWciY3FFZhEGX49X18+770IKezIIj?=
 =?us-ascii?Q?Pw9/FLDE6dsRu+sIS+DWPdnmulcYZVA/Es28CrXVzpAmh8oCctJPkS289ZpL?=
 =?us-ascii?Q?9gw0YIPIfod6R+Hgd71MM6WVUlZrcU9lY20LmRrrpjVviUDhZTXelHYV2Yvg?=
 =?us-ascii?Q?QBU+LuWjvGtUssS6tbUg+Yl15xa0qlsIvfq4HK/zbhTqPmsi5hUJ1GPO+G2t?=
 =?us-ascii?Q?XI0LPV0WqjfKfMvTE79R+SDD5y5ou68yRU4UcVtuPjpLtUuFmglLsDKXYWg3?=
 =?us-ascii?Q?EjHxVxEBaElGegnA6sFI3HEovgqs5nG4xGruIHPe5mzDXApWQJItzIxr6ZbS?=
 =?us-ascii?Q?O51+sJBJpdsV3qBkvfGcApRJDymjKuJwE+uWO0nIy5jICgBrJXZpVYupSxrI?=
 =?us-ascii?Q?QiKQ80Y+lS3osYzpcfl+y8QsdpVkSKGB4K8F9fm1+1xugsd3kT7eQmsLSkS4?=
 =?us-ascii?Q?SDF03f/IGWriz5V62+nVmFrBbqS18AAqZOekddlj9niyPd5PbaFBQmubSqnw?=
 =?us-ascii?Q?Mz8U3Ldlp1/4CKQv23CLyUv9HGlAU0KgNIPx21oaCCm5+ncWGTjI0IfyQ7TW?=
 =?us-ascii?Q?DxPdzvDym9OW1t8gbRvyyFON3ibuXwwMu/1I/Ifbp8L2blfFntl3JdsOd72s?=
 =?us-ascii?Q?oLnknOrBoik5PH2cNk/cygT7LB3pdnftgTXsWhfAVBLkp7BACG0+G7s+qqLo?=
 =?us-ascii?Q?0EeDGHBlrMPTQdzTL6L5TexAjkCFxjAHE+oBObyWM+QwQF8AevCEAB2GRtre?=
 =?us-ascii?Q?591bIdtXj0W62f3bKmbL5gvWBchfuvgYAyaApL9qu3EZkfZN3gZD+l8hlcIl?=
 =?us-ascii?Q?/F6sbqOF7enJIsbJ1tcYp6U3L57HiEEVWJ0ja19e3cZe7fgjILmTmxn5s2ww?=
 =?us-ascii?Q?Dg4ZORy2idzqEyMNK34GqI3K7u1j7a+n8qgOlzWHIqY3UBEaljd0mS1sG6nr?=
 =?us-ascii?Q?NDfsP8jx6Lg5BMUtWhVeBQX3xHgjOaM/oEKLhOQKuYWFGP/68KjSN6x/Xphc?=
 =?us-ascii?Q?Y+I+x6NHdpx/pE939rNwTPwPZtK/3BfkuM/LsVObergyrOQmn7Ectfp6fNjs?=
 =?us-ascii?Q?o+IG8DCH7G+TrA8b3zUwrwBOslZNN9Kkk4ytnRJZDwxBz/GYFYbrsKuqLST4?=
 =?us-ascii?Q?BMvGO3eZqI0SCHKO6XwlOUjSLk6vj5RPYGk4V36JYNgzE6oTCsxB4XA94UnN?=
 =?us-ascii?Q?4FHLoBa9fqO/tzE5aWSL0vRNAhfVHByezt802G48Jv9FFkj4Nv4IyfCMecO0?=
 =?us-ascii?Q?4CxbvBuZ5IokfkxMUmJIse9M/y3tD4dCc0YeOVpzduKlmQdUwHECKaPaZD6j?=
 =?us-ascii?Q?5k5zOSl1DvBVYuya5yqaX3ixGEE0Pro+MtEq4oZlynRGlfDOCJ89kOwXN0lv?=
 =?us-ascii?Q?3LMmyd7pqs8pmtkZJAgHhaBn0GqYAnCepJCeNpqaMApv748wRwyzE9aeVqFL?=
 =?us-ascii?Q?I1TTG+qDNTdFC0YhFEBlFqVk+Dw/PKTPE2ZT23RaKl5L5L0uVKTWthDg87Ys?=
 =?us-ascii?Q?l/2abg=3D=3D?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805f78ca-9d6a-41f0-065a-08db798ef2d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 17:25:06.9123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tfablTA3pdzjhJBror4Wm9olxSCtZIzUb+UnielXMb0RIhTSpAwqXWsqxgL0/wLYoqrwTKdaOy8JnEH33NjfHBpyKR9nJBCzlCyhz94Nugs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3285
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/oSnVy70MN1__wO5_l5C8Q-zvS9I>
Subject: [Bpf] IETF BPF WG meeting scheduled
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0408913538759246496=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Dave Thaler <dthaler@microsoft.com>
From: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--===============0408913538759246496==
Content-Language: en-US
Content-Type: multipart/alternative;
 boundary="_000_PH7PR21MB3878E5586021FD86130CF03CA32AAPH7PR21MB3878namp_"

--_000_PH7PR21MB3878E5586021FD86130CF03CA32AAPH7PR21MB3878namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The preliminary IETF 117 agenda is posted at
https://datatracker.ietf.org/meeting/117/agenda
and the BPF WG is currently scheduled at 13:00 PST
on Monday July 24, 2023 in San Francisco.

Registration is open at https://www.ietf.org/how/meetings/117/
for on-site or virtual attendance.

We also expect to have a BPF table at the IETF hackathon
on July 22-23.  Registration (on-site or virtual) and details available at
https://www.ietf.org/how/runningcode/hackathons/117-hackathon/

Dave



--_000_PH7PR21MB3878E5586021FD86130CF03CA32AAPH7PR21MB3878namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">The preliminary IETF 117 agenda is posted at<o:p></o=
:p></p>
<p class=3D"MsoNormal"><a href=3D"https://datatracker.ietf.org/meeting/117/=
agenda">https://datatracker.ietf.org/meeting/117/agenda</a><o:p></o:p></p>
<p class=3D"MsoNormal">and the BPF WG is currently scheduled at 13:00 PST<b=
r>
on Monday July 24, 2023 in San Francisco.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Registration is open at <a href=3D"https://www.ietf.=
org/how/meetings/117/">
https://www.ietf.org/how/meetings/117/</a><br>
for on-site or virtual attendance.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We also expect to have a BPF table at the IETF hacka=
thon<br>
on July 22-23.&nbsp; Registration (on-site or virtual) and details availabl=
e at<br>
<a href=3D"https://www.ietf.org/how/runningcode/hackathons/117-hackathon/">=
https://www.ietf.org/how/runningcode/hackathons/117-hackathon/</a><o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Dave<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_PH7PR21MB3878E5586021FD86130CF03CA32AAPH7PR21MB3878namp_--


--===============0408913538759246496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============0408913538759246496==--


