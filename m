Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2179601D79
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 01:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiJQXQ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 19:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiJQXQZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 19:16:25 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11020014.outbound.protection.outlook.com [52.101.51.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1EA7296C
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 16:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTV3rwIo9h6/cAaQpN3PYM+JyoCwm6cgS5W9QrqD/9W/Vy8IFFRoFz/h5X9IUEd6McAoaOAuhjIF2pp7uiLv98Y5i/9A6Pw98lbsFQd33IuiHGaEv8PBiNxqeOYQPLpMhw4PqySbSRvOqtOnYEpe9zg6xikchWjzit6jnkuEOBtmcGEfsJvzv4RDO80CcsT9V5a9zEtRuipu7xOXGHEjzW96D2h4P9QVFHOADI03LTEXNb5LfpQjwq21//8GMVrxFihUA0QozZOWvJz6C+nPRoSWj46Rxtyks6YDt7jdsKYTx0sOxv+1msjP2ZlFNrOSTv/Ridpn0Q5zMObeKooFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdSWq5oEHxCa6z46nHVL/zGzEyp/Wo1bzoR/EER6/gQ=;
 b=lbr18FeFK+Ke8uHO1gBlztqefAUpsKiiGdZer2CR8lSwMhimiiUpNTd4yA9QKv3Ee7jmWBNzGPUF8bBB+H8FzRmf6FJYmWUujwmlZStnCJOfQ6jSTKdiC5zsahDGg+keAoSeN6dIRbIhhoMz2DKGX+nUXHwYOesaKXjgLc5r1TIAhI7sKhLpyzxYeZ23T/+ycOxUc/G03JWCELPs45sQ/82DyoFMF9D+HvDNAnq5WvuXDvs0zj/LjERBNjWugPwiHlGf8B6/OpZCvDP9pqNqB46JGBozVsxJaD4xLAYTwjfVFoScw/ITSEYYIAmE1XmYOPiZr80Wq4EIPEHKJCczQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdSWq5oEHxCa6z46nHVL/zGzEyp/Wo1bzoR/EER6/gQ=;
 b=aE9KyPy6k7H1seM8G13GC/RZNfq9s0ZQEjH19jfYFeaK/Ohumf/NCeCNc+3q2MA4fBJxuxMpflxewtKPhmjL/zS0KRvXGiIun76sU1xl4pN1REy6wV8GcIYq/+jShc4SstiawyXOdC1Xse3kArhL/jsw9+CjjankaX2k0wBOizg=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 DS7PR21MB3741.namprd21.prod.outlook.com (2603:10b6:8:91::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.6; Mon, 17 Oct 2022 23:16:10 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5a88:f55c:9d88:4ac2]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5a88:f55c:9d88:4ac2%2]) with mapi id 15.20.5746.006; Mon, 17 Oct 2022
 23:16:10 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>
Subject: RE: [PATCH 1/9] bpf, docs: Add note about type convention
Thread-Topic: [PATCH 1/9] bpf, docs: Add note about type convention
Thread-Index: AQHY2ENV7HAf/RJQsUmx4FEyPcI2aK4TIJkQgAARMACAABpQgA==
Date:   Mon, 17 Oct 2022 23:16:10 +0000
Message-ID: <DM4PR21MB3440DA99F6621F50845E0A07A3299@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <20221004224745.1430-1-dthaler1968@googlemail.com>
 <DM4PR21MB3440B73030D09B1F09082807A3299@DM4PR21MB3440.namprd21.prod.outlook.com>
 <20221017214104.rtle5zdwnipqhwvb@macbook-pro-4.dhcp.thefacebook.com>
In-Reply-To: <20221017214104.rtle5zdwnipqhwvb@macbook-pro-4.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4935dd4d-b0bc-49db-9c00-ef7a866e6230;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-17T23:15:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|DS7PR21MB3741:EE_
x-ms-office365-filtering-correlation-id: 16817959-8f87-4e3f-7cbe-08dab09593b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JMS7etLatk9jPGYBXek/7AiLvSW6aKhws8aMxY1FKOQwv81lj1TWVImgw+ntvICn4dsaeIoa2SlwjqfMOK3MgFvgIgtlc7I2/E//7/yQFzVMjSRIdhHAkv8i36tceLTh98k7YdYXpxeqmZV2ca7WRxAoL4dpUDxtYbQ4iaNoxfie6S3YU6P8Hio6hjQT6Ipa16sLiDU4UTz7gnXnByMyWtpelF0c+ES6TURji+dtP/UlOjR0EfX7OxBEdX6gzHHAdHfj+TApditPjbA/S8tRfJlZvuDvWfHqeIseggzIa8AeMz+OWGPGJYQcrK16wr1zr9uARik8ER1Bx92AbXgrfjPmzCbgoyCKQyyUMChU5MYy/1RkQAZqWFQTr9uykQ5HVogN6oPkQ5lzIu8v3OjKZs8LgqjqcaIPKSFn+Yeso7UN7NLZOXjKGYmEWprM5StNjEZsDXkIAKWjyV6fVdcmj2X0A5u6EfmxOooVjWnwo0KBdRWEqMgLdH9Fx8g+Ae7iFtxU3jENgz68m4gWn4TDI14TRjIp9+kPUM8SPVPlS5w6mp178TfPOMUuUwxQyvO0/7cr1nNOnYCUvHHHopzc/+98BVFVa9IiVUoIc0vfY8tC4RZ7FImY1YEW4lNJ27OsTSLVEV/1OM2lz5M0YIgfX7a6h0Mw2jq3cAOqWAxSgEoUDEUKqDhqEwAGQoMm7ARRXZm2Yr7TlsSrM/Rx5shZK7tp4yNvJMU0vG4NJUasGpFHOPzgvnmnOsPwz9sUAZVCDFG1K6v1vOIkd6j2qvFjFgIosmwULqVo43U45O1ASnAy0BpD1zFJg4FAQ/3VDS9z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199015)(8990500004)(7696005)(6506007)(2906002)(8936002)(5660300002)(53546011)(86362001)(52536014)(33656002)(4326008)(186003)(41300700001)(26005)(9686003)(38070700005)(478600001)(66946007)(8676002)(10290500003)(64756008)(66446008)(71200400001)(76116006)(83380400001)(55016003)(66476007)(66556008)(82960400001)(82950400001)(38100700002)(6916009)(122000001)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kPdP1QbIiQCbAMe8l6QWPepsRlhwSYqAmat1cBc/ymOkimW9DZN1w9L9o4Bp?=
 =?us-ascii?Q?eypvGP+SWicuqfmxejhrOk1BzYNEFjtXthlc05N3vcB9Y9Z0Acsu08bXPsce?=
 =?us-ascii?Q?o3KmzOt1sN3qnFTeEzHEIhOLNr9rXNOPD5iEOle2svgzL08XShihMe0USUmF?=
 =?us-ascii?Q?xldgzv88V00MfQwx93+V7e2rO1vAyb79oBoJWc05zyumkqGxgD5lMHEHwP9g?=
 =?us-ascii?Q?A0zSDOCXxBG3rzA3Icb8DMOIaQZkbifFNJfuOyLMGEnXLwhv6x7+aOVK3LSC?=
 =?us-ascii?Q?TmKaouPx15E8K0gtutc6DKR+lsEXt0kVYcv4b65oi/wEIDg0o/6D2uHeSFIV?=
 =?us-ascii?Q?BQtZrs1cFi9J1rIE75JFJoDX+wc6W7bW23Vus7Gbd96Kzr9rv6kgOboxVr/e?=
 =?us-ascii?Q?jA4BlGwW9Fa/egEbFvU6tSqRSIVBrZo4xqrMj4XXAzV1ynTNTBhPc3LIE61x?=
 =?us-ascii?Q?14K4D51f8PV68um0wJwEGYmCh6Le1gFoPGzfiSxCFZDEI8fTKVtEYWIsJrIV?=
 =?us-ascii?Q?BMxNx7K0UzLg5OfVdSvk7cTEcT1zWhObvQAnM7dkgdg9tljg2Xe0U7WND5qJ?=
 =?us-ascii?Q?mOWZm/s4vZsxoTXbEZH9IPzXV0S1WaIWLYF43Zf4aVdY0QjbGPHg4aoa4tc9?=
 =?us-ascii?Q?aKjAcdMaKPO6tSPbeHhxlnk89wtKChqaPJcSLzRz5ffp576J0M7oUJ0WT4Jy?=
 =?us-ascii?Q?1BTHpBVnemzxDAf5Y84uqEkGV/cnpp57GOtewKDbBp3AIyOsElzEx4ps6c6c?=
 =?us-ascii?Q?5Tp5Mnj1+BwxNtVEHDuvznr5JCHhzlwLrwg+t1lbaeXzKWXyLKqg7aXFR1la?=
 =?us-ascii?Q?fFZl/M7OWQpTHiwOq4RLrd5MODNjLwmjUOJjmICgkGLgi90c21884e01slDr?=
 =?us-ascii?Q?RjyHeXCCRELm0mXnIcEt8V3ucfNm2qFZBkkj0ZqAizZeWnN5U+8mfSUoK8fj?=
 =?us-ascii?Q?Hpwr+mvkl9eNH2QFbwScLC9kmw/6AR8InCDOwmOEhvek/5+wBCNBSpzXSHVf?=
 =?us-ascii?Q?z8O+NeURk0hq3XDEP8xV8piVGannEh/nL6OrrmIYFq/eEQWWzXbwq1cSN8On?=
 =?us-ascii?Q?UCVCN6KXJSlqmfNWGRKhDQK5Xw4EZCw3nEldKQImfxc3me10uDyByXkrcSE1?=
 =?us-ascii?Q?plG+n69u1FTyg+qSn3y0c0wMHbNeAp6bhZkmpO1hhK9BSJFlYxighYXxxjz2?=
 =?us-ascii?Q?293YedUUNhilrFvJpp/5SyJx7RT3gds7dvcMiVjZNNt5obr4EZ5zLx+Ss6BJ?=
 =?us-ascii?Q?Rckbg1o4u4TnhLxl6oGri2f/3tEtcI3AzfnlVU3M6CGLfo6+0XyxSx3fI+el?=
 =?us-ascii?Q?s+7TnjUZNhDniQ55J+qiV0iebp5nST+hE4RK35CexmTTbe5IguU6ruicTWM5?=
 =?us-ascii?Q?YMCwuYIlRsy7B+Mto9/XoLsdtjMpMxAWDudW9vtXzjurUtBt4EjsP5BZhqns?=
 =?us-ascii?Q?PDlTNsLjQr3JP+DJL14M3yONuydbfQ4ml2CDVi9RiH6N7rKBJ5llDCXvphq5?=
 =?us-ascii?Q?5iVrP+zZhV9uJ+WGXy/xDGq3YbqQ8xSPVvqL3LF+C7KtxT/MLGtvjHGY45p1?=
 =?us-ascii?Q?hitVb+idi20P4TKoDuAonag+QFWC88zSgMiiA8kBFC68+/ia9gNpYqXY107V?=
 =?us-ascii?Q?Ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16817959-8f87-4e3f-7cbe-08dab09593b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 23:16:10.0573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X0cCCpSI/jOFD4LpimGgTYai0E81N2b2IjDmD4Hih8TzjwqF/x27v8sGr7JT5N9WWR8b0nyOcbzvaVpf3moV4UI0pSdn8zxo+saRKGcW8Tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3741
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> -----Original Message-----
> From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Sent: Monday, October 17, 2022 2:41 PM
> To: Dave Thaler <dthaler@microsoft.com>
> Cc: bpf@vger.kernel.org; dthaler1968@googlemail.com
> Subject: Re: [PATCH 1/9] bpf, docs: Add note about type convention
>=20
> On Mon, Oct 17, 2022 at 08:42:13PM +0000, Dave Thaler wrote:
> > Just checking if there is any more feedback on this patch set, as I've
> > seen no comments since this set was posted on October 4th which
> > addresses comments received on the previous submission.
>=20
> The was an issue found by build bot...
>=20
> > Let me know if I'm missing some step I should be doing as I'm new to
> > this submission process.
>=20
> I'm still not excited about 'appendix'. How about moving it into separate=
 file?
> instruction-set-opcodes.rst ?
>=20
> If folks really want to use it in automated way that table needs to be un=
iform
> and shouldn't be interleaved with normal text.
> That's why a separate file with just that table seems a better fit.

I can move it to a separate file, but that appendix is added in patch 5/9 o=
f this set.
Any comments on patches 1-4 or are they all good now?

Dave
