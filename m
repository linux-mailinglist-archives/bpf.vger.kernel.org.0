Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2566AD0C4
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 22:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCFVqn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 16:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCFVqm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 16:46:42 -0500
Received: from BN6PR00CU002-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11021015.outbound.protection.outlook.com [52.101.57.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C39959E7E
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 13:46:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULG8JJX+jkHkkeMHpN6+FqRlLhdE5voMKBT7GLrAdgt8nRrp4gV36vGxTfsnyxPVO1w9VFwfnmv1bErXu/Lj01netg8SS0/OnJmEBEAxaoxzRX2SJgyzadNXdkgF3zonYS2pgRSILLC1i2nSwlzJQIoNS48pYWCg5KYmLuhR2IzmgFE2vYOtkdN22FSE8GYN6oN5+GZeX/o8wRtcpJBoGghkIs+KdkSXrahKdoKQ5bVhQK2BqTijyZN0D2wZ3wHHmU8StHSbi7uwuBsp/+JfKnjV2QxbxnrQAFnWzCaHWkzPQcPC+Biochdc/0XsPs6Mz/KpLmY01+RoXqyxsVC84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F71PG8uIHuL1frK8a1ITkeOGGlZVBKzuxfTjECWY86s=;
 b=KyEixtKbN1TA00Ae7yswg0GbwvKQZ3H1ionniUVp25P3Rtv/C7GMgeUJ7wr1/ilKWoQz646TcmiX3AiOnzd/cac/CoQYDCO95QwEDCv4nxhsBBt2ulTmtggyd7H0CzztCeRtnU3FqrDGnN+Pn0Cyc8phVGNnYxshN0yYPXzt3ppq/n2VXZyKj8etV6MajO6tQlyWbcVe9spu+e5xkC5ac2OoA8WJxJqD/lxiNlp57d0IuK3LrkGcQpuFAr1oq3nImtkh6HKA3Yt0J/cvvvEeAtIMTZPad9h+n72mwPF5otbzPqEIFY6wSi+RpJVfmU+7pvqXihyzh+2NQTEmBnyb9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F71PG8uIHuL1frK8a1ITkeOGGlZVBKzuxfTjECWY86s=;
 b=ByDojlg0ybeLXZevnNhBIu6t2LnpW3zed57WUMhGO4QJ6n4XBjKYYVPJLcGjnAmGPh5N2g5fqYvmCwZzTxnr/gICkYUQD8TtRDQ+Syqoe5HucsmGWJVB+19Vv2TdGyz56dtpD9ki7e4l0UJdWCzRgLRRCqBDKQPNN9IArkbBRTA=
Received: from SJ0PR00MB1005.namprd00.prod.outlook.com (2603:10b6:a03:2d3::18)
 by SA1PR00MB1172.namprd00.prod.outlook.com (2603:10b6:806:190::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6209.0; Mon, 6 Mar
 2023 21:46:38 +0000
Received: from SJ0PR00MB1005.namprd00.prod.outlook.com
 ([fe80::2a24:661d:db87:3976]) by SJ0PR00MB1005.namprd00.prod.outlook.com
 ([fe80::2a24:661d:db87:3976%3]) with mapi id 15.20.6213.000; Mon, 6 Mar 2023
 21:46:37 +0000
From:   Rae Marks <Raeanne.Marks@microsoft.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Leonid Liansky <lliansky@microsoft.com>
Subject: Suggested patch for bpftool
Thread-Topic: Suggested patch for bpftool
Thread-Index: AQHZUHOBrQIAckd6vU2Kp/uenfwQnw==
Date:   Mon, 6 Mar 2023 21:46:37 +0000
Message-ID: <SJ0PR00MB10058537EA379C1260C3C8A9FBB69@SJ0PR00MB1005.namprd00.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-06T21:46:37.637Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR00MB1005:EE_|SA1PR00MB1172:EE_
x-ms-office365-filtering-correlation-id: 510ed17e-f2af-4eef-e5b0-08db1e8c4375
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ShnOJTwAjvQs/elxI7Zaf4szV725bpcM66DGTSbJ6YcXo0aRsEeStkh8j1MhFh83ULBmgTqm+Am+wThPfD5wl8QG03lUFpWqE1R833f9SnvgHkkDQRVIj3Pd+IaAnG4d5IvpA5Hg1qrh0BycBHtXoCW3l3InRchuP4VY7yKYQ2/R0i6bDsSv+WhImrDcwDs8yLLTvRSvQxFHcBt/J60nWhXJp8HgTJYdoTk0jarOBFlOglMoOy2Ep5pg37C06U3XJdVkv/V64u8yvBgIh4ozZu3WAt0/EIZDPxl09zjpFREmAMeDi288zgzq4Ar/NTGip4+hgsFmLmGbNSJd8c3CgJ7NFpd4RRfiaOchgQ2/VJBkTXhW15MXlyE66iuFy8TiZ8rZQArqf/QfUTsRheCdABAXQcd/nGBsnT9iG+Mvuw76qhMJFjzancpYBmdADh0KbSvdfLV5cTDfB3ya89L0HUN5JyGuTaZ4C9RPpOsRZSp1UHl+6GJ6Venj22iloc5q87ifHbyxshTsHQziWRVsjtxPdpD2+AwFQVEPM9u52DxgwM/HqWG3AoSbH63Nhjmns1ZEmYQM9dHr9CqZCgi7lguWGW9mezw9EWaa+/YlO3iVoQbR60AW8oqfREBLFZU2KrCrAne0k2E59i4sntycyrzC/NoqE5Vfbrq8Z+zRkvct1koiy48EekI4xPXyMYnsrducg/Nd0GtnzZfyIZN+JjE6pj2ys1MQtzmoSDFvLXo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR00MB1005.namprd00.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199018)(52536014)(4744005)(107886003)(41300700001)(6506007)(8936002)(5660300002)(2906002)(478600001)(10290500003)(71200400001)(7696005)(64756008)(66556008)(66446008)(26005)(4326008)(186003)(316002)(66476007)(66946007)(9686003)(82950400001)(76116006)(8676002)(6916009)(33656002)(55016003)(86362001)(38070700005)(38100700002)(82960400001)(8990500004)(3480700007)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?JphT8KmkKfQrnjBU5gdE9dQaxexrmU+W601coGNobU6VAY6pRqhx7PIE?=
 =?Windows-1252?Q?KqWz+2QULTzkCBh364EXBcvb7ASbXcUYNWmi25u8pz9dQIJ9gSXXV9GB?=
 =?Windows-1252?Q?xpBsFfpozorS9x7+SHrvrc7SvmAVMXH4Zfx0gxYswh/UVfGOsaIcdO9M?=
 =?Windows-1252?Q?k+lCsk1N0J2qmYeaIJiqkhsfhhh9EIm1wSiQvPE/223L94huRHYNMaBT?=
 =?Windows-1252?Q?qIbnG8uxgJOkgSTpL+UqrOMDmNxUq66UnTrVHaps7ncyQlJDTJ2oK8bz?=
 =?Windows-1252?Q?svfNpBJUlzIekSa8lL5W/NVx2XcaVw4y/xrlAeCaN69p6TwuvMLpCcuV?=
 =?Windows-1252?Q?fNM5I3M7GkTXEJjWkcuFGBoeh1ySeOUHMciyjp0/ul4Fl7VExJ7lLSSk?=
 =?Windows-1252?Q?ebWwxeTfPZShnxL4JcccGvDhevj+HJV2Uyh/b+Akiqzr5uz2/ckXuSG1?=
 =?Windows-1252?Q?pCagWJkKezWKnSWEYRgQMiFjXLUBKeyqJ8GxoJ8NPz0v34DR1hIoEK90?=
 =?Windows-1252?Q?reI4aUXgkwYfyn1fD4GyDDzwk3GpTyflG1OouEWswhOHXCYlrdthOsdm?=
 =?Windows-1252?Q?jSEWIWw195R+EEwpaVc+NHREva4CKwb3k2yVgf/ECq+N4x7pN8WefIDu?=
 =?Windows-1252?Q?Tw3kzl5mptI5JpNLDKWeK17SUwF6AjqDg4hoIvLU+9t+P6YIXBWBemvK?=
 =?Windows-1252?Q?Ync7zFHITez07hzZzBQ31VgTBHZEpPrdU8LvWbr5jJOLCHa+JUczpBXY?=
 =?Windows-1252?Q?NI0v5XRq4XXKIugCB7q7+ZHSZEGtAh2pNLgw8eA4lG7BK8BVDRWz2AE5?=
 =?Windows-1252?Q?vEytH62NpoHpR1y6hoEv4EeMHVRlHeR9zMUCfkaj9wRvtRG/FodP2yI6?=
 =?Windows-1252?Q?67FVeqniurEUbDNReydBOsgowgR3TtutytTkruQ1zPsRCPPKA/pKsulK?=
 =?Windows-1252?Q?ivqrcyuumMn9xqoQ0bZeqr5G3Ld40SHnsIUjwcqnI3avTcELO76Bup7D?=
 =?Windows-1252?Q?2zOPzLT1CHD3ndkZMTjjP2FeBlqwzAOiIRTX53Jte1ozSLC8xEeUv3u0?=
 =?Windows-1252?Q?oZnjdFxp+4Qql6/vgMznyGD0q3iP7smcijWRiyOnJP2+xakzaM2oNKi4?=
 =?Windows-1252?Q?0HynrqLD2Cl7S3EV6aAMmSw+RUYBr3XyhyeyGomFfP24LniWvM4VIOZw?=
 =?Windows-1252?Q?EZsUNuZxqy/hx6E6aP+kIz1AfCyxHIpcqnsfjxvOor8f67h66jr4UJKg?=
 =?Windows-1252?Q?8oxElvJcZmXEmKSO+vcjdK2brnOGgeB7JuNmIY25wINIIys5KkYqnph9?=
 =?Windows-1252?Q?hcDzFqx6biKsB14AhkE1wZWPUvLpAjohRubuosUvumEkWznsSWGugLZ3?=
 =?Windows-1252?Q?JsZ4u2ZZf5CY6sVP1ih35NYIGHTE6WKO6lfYvim7uGMyULmahALpQmPg?=
 =?Windows-1252?Q?tuunv2+uQ84UMzrij9xO4NAXB9ujFNnapsazjp+pkBb0dEWT6+5OzofM?=
 =?Windows-1252?Q?znJMgbpRsQEFmZX9RHzifSdaGpznph4PZCgC6zgRhuUemm4b5QhS/Cs7?=
 =?Windows-1252?Q?lhTZYcc0weOfuCqS7AOpuHQvJ8WZNkYi4lpB8KhbuXyp0JUjpm+L12IS?=
 =?Windows-1252?Q?Z6JDaEewu3Bz6gvYRLjLMM/oC3uaDiYOlS3QBgit+Jg4K7W1DPRD9roS?=
 =?Windows-1252?Q?Kzaoi37hU2U2luuarGqcCuGyeuXhv0z8?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR00MB1005.namprd00.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510ed17e-f2af-4eef-e5b0-08db1e8c4375
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 21:46:37.8798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s8pFIPjpYIggo77w4fmBCFuq/XoP12vad+1KL5AYmk+jU9+Ph4PtyScGO1qmX20PNb6iNmDPxjsI+SMyfjvt/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR00MB1172
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,=0A=
=A0=0A=
Thank you for your work on bpftool, a great resource.=0A=
=A0=0A=
I have a legitimate reason why bpftool might fail to open an individual map=
 to dump its information. I would like to submit a patch so that it does no=
t bail from the loop iterating over all maps on the first map error. With t=
his change, one map failing to open would not affect showing information ab=
out other maps. Specifically, I=92d like to change this line (https://githu=
b.com/libbpf/bpftool/blob/master/src/map.c#L699) to be a continue rather th=
an a break.=0A=
=0A=
How can I submit a patch if you approve of this suggestion? I see that the =
GitHub mirror of libbpf/bpftool is not the appropriate place, according to =
the README.=0A=
=A0=0A=
Thank you!=0A=
=A0=0A=
Rae Marks=0A=
Senior Software Engineer | Microsoft=0A=
=A0=
