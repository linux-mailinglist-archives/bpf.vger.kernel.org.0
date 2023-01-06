Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F173660448
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 17:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjAFQat (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 11:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjAFQas (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 11:30:48 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4630D6A0E6
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 08:30:47 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306FC3NG014294
        for <bpf@vger.kernel.org>; Fri, 6 Jan 2023 08:30:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 content-type : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=jFgQjo5fY0MaUIEgwpn1r0StjXeJ2niMdPY9SaQjm3k=;
 b=InuWjz2CTIHqoIxGqCYOXAxhlZqlmIMxOMZ376tIlptO7UDHlAJPYifXRxCRL+fI5VxD
 LOxKKnbFC6ZzdRrayWDAWHk+M/lUyDFsNPFT1aYEn5lecy1a/S84vqA90xBtTZ/aEAIQ
 0DEgqk8igAMIZwbt3kvPU6GEp+qxuaGSJ7fqHP3fDa3gPRwIRtg+OzLUXxmPufXGp/h/
 SBux8aZCtcB0/RW3aQM4IH0YffzbguMGxabqVPhIvjx0LGjLTYrkUXvU3ZZ5r0fbDt30
 TVAJ50ptrWybh1SABMa3M5ILzeKGGoeae4xormuqd7cSo1KM2H2CuyX77vahYqGpXGDa Ig== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mwk4nn59d-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 08:30:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHUQTe/RWUcX/f2MNQv5lkBU9kIbb9qKcY6cprfcEJouOGh2slrDiJuaITgLIunfODy8Dr2c3gtqeDN+rh1ONww5oe6DOw9t2Pf88vIsevx/5LvUBdd3SFSJ2wYBDq+JUt6zt/3U5h9IWjFXSdUMGnRzwg3uE5lUjhCh751Ij4nimDCA0JIH9+d4YW/C08/NaMGarSGrNgofuMpIrHhq+6iWH3JvQJ4wslvlNp61u5hmUsr3sBfjOHZyXNIPGQhsmxNs6Vkwl5yd7tfEKBaPg7UZkg9ZRsrYwW0Sm1kJVxrsGfAQdV63F0kfVrfk0c9PKtxVzLCzf/Yirp8dyppSwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFgQjo5fY0MaUIEgwpn1r0StjXeJ2niMdPY9SaQjm3k=;
 b=BsG2old+6+9rDgCxApjJw1ParQtcTZbChkXjh9nKbx2Lp0L5M4wzHvW+dtu+TNNIEddEmIetQRDRRQbl82/yAqdTk78NIdXEcT5k1SKpdaeoNgBZ3l2CB1SrM47jwi0ayp9tRTTCZy6zEQH71dxXYXTlhwFTAGGMtBOdVVBgPRjyGWPZ8BWIvhoMJ0W2cgRW0un9CAzbEXANZZzhp0ruySK5R5RaY2qomhVDLz5eolMdhSp8gJGOQU6pIrHJIVNKCH5sYs1TKtmC9o5f8EH60gIfrZCK30x3QWeV4BzwY64tSamXRG+NfLFhmSVuYIXiiGhZ33QwxOY8gsvbo7q9OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB3213.namprd15.prod.outlook.com (2603:10b6:208:3d::12)
 by MW4PR15MB4666.namprd15.prod.outlook.com (2603:10b6:303:10b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 16:30:43 +0000
Received: from MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::7ad3:6906:e150:8eaa]) by MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::7ad3:6906:e150:8eaa%3]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 16:30:43 +0000
From:   Mykola Lysenko <mykolal@meta.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
CC:     Mykola Lysenko <mykolal@meta.com>,
        =?iso-8859-1?Q?Daniel_M=FCller?= <deso@posteo.net>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@meta.com>,
        Andrii Nakryiko <andriin@meta.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@meta.com>
Subject: Re: BPF CI issue with s390 build
Thread-Topic: BPF CI issue with s390 build
Thread-Index: AQHZIdA+wolRGOoOPUOK967Ph13eZa6RlM8A
Date:   Fri, 6 Jan 2023 16:30:43 +0000
Message-ID: <E5735DC1-7E84-412E-A7A4-432E5652AB91@fb.com>
References: <0c25d95234d8e009fe57199ce35b9fd18bd2cb78.camel@gmail.com>
In-Reply-To: <0c25d95234d8e009fe57199ce35b9fd18bd2cb78.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR15MB3213:EE_|MW4PR15MB4666:EE_
x-ms-office365-filtering-correlation-id: de173aec-1a05-4f2e-9fc2-08daf0035b4e
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tuMjHs5kbIPP8iiSmklHSS5Q4nd3alJ65DQo0FVS8mwU9Fx1XNhHhHrbQLr0XH0ZJLAXE+Bh08B1vlWFPxOGiinvyotVAWgm6gwS9CoYzLRQCA+HGIDhNs1fSqepYr7dsPs7SAWIEcd0XcjZ/tmiLEix8PBPqslyzY2q/a+1VQLe7u5IFj8I8FUKxRidlwmqmYAtBu6vHCmpUOA63DVUvezoWSteWTCq9lkiTLFs60M8JUu0fQADOypAp5mK1Z1ki1iu667KF/P3Hqr4OZ1T4mz52RW0dONmkzthJ3xOxOLdtA1bkvItG89QgP4X2DZMYi8KyBxoFWT8Z89kzorP9FiN54zJUuh/s/haljplq+GxU4GRRJevAE1DwBr6ek2WdDrPKLdU96XXo8wgJX4XdUwIP7zBNrT0jZUQUfzLWrq40vJvJzoN3mgUrGRAvrO1p+wcZbIQEtA1gnvuaDmrhOrnT25rT6bLrwHYqYjOd56JewgvfIV42xFdORmGpE4gFgaP1AIGX4tfXS7feYtXDF07/xgAtbF2MmrSY1Jz/+Or7+9Y0PY9GjhWBO3cFLUbgcNYJsITWazaoIZOkgnxqyWU/PXpcUEluy/FbFo/CR3bLX+tQ962OGsYWcOvHN8ozmoYfqcG+q9msxQOKesy8xsAD6N8PAEbrNHvfsZl+yhErdR/K8mDN2n4cSpUmc7vIYqa2okkAoB4DZloVSrtbqsB/3TU0rXKCMrFtuUSJzrD9vQm3MLnq/XTVaGC4mFJHP7GODY4gsIRlt/G08WnLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3213.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199015)(5660300002)(6486002)(2906002)(8936002)(41300700001)(8676002)(4326008)(66446008)(66946007)(91956017)(66476007)(76116006)(54906003)(64756008)(966005)(71200400001)(478600001)(316002)(6916009)(66556008)(6512007)(186003)(33656002)(6506007)(9686003)(107886003)(53546011)(83380400001)(38070700005)(38100700002)(86362001)(122000001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3oISCCTag7PS/TyKwMTn15Gdax7xrSRZJm4GlT7mBqN9qeO9Fu8naET8sB?=
 =?iso-8859-1?Q?BVsSdWkmkk7+vR57z4Q/7q4MCRfVTqon/vNsUkTvOd8GTyzdItefdYySjp?=
 =?iso-8859-1?Q?aJylHc0b6BkaW78C9945bKT6XCRNKR4xECQUPelCS6/GlK0O+SVJWWbjrX?=
 =?iso-8859-1?Q?h8j0FSQaOxmjA3nunPUii1Hp9cEMupmpCQOoo5EU+jB7d2LRXSi3b+d8KX?=
 =?iso-8859-1?Q?uzXc1cBL2xF/CEfA+lBJOAwoBrL6AFVtCZOI3H19baifjyw+BsZoV9//yA?=
 =?iso-8859-1?Q?r5MVz5syH+j/+2z0IpFF9dehLbBGRjP+wVcAh7Xpdbo3PMoF8Q4x6R1N/h?=
 =?iso-8859-1?Q?1FnSyInzON+UA357UU4xS4e3IEWjjbcxbne9F6WsFIP3WXv8RIXjaQphKV?=
 =?iso-8859-1?Q?uZeqZG/J2xWhySh/8yPzXM6cK6wynSb3rSrgvK8xWjDigQKL825un3e4n8?=
 =?iso-8859-1?Q?JzJJns4fuwHMjgj7LfAcQA2BmPKxVkIzJySqiNztoNJ+jLMeKXGDJQx255?=
 =?iso-8859-1?Q?Sk8IG60SD4QFdZZtihNgsfH8BTLOneFZZxy46dx/+fKh/bhQ9pJvF7rtOs?=
 =?iso-8859-1?Q?/LGcuft7F+9YqHayj7A48BrcA98i+s0BZIIO6+WnzlsuZzHMvvm8uytVri?=
 =?iso-8859-1?Q?JFKzo5ZEgdrAdm63XFj2FhOsrFxKEcB6D38O80dkZZoMGslO0qsVGtezLK?=
 =?iso-8859-1?Q?/wZEQEERqebYzAqBmXZMaGatPo8BnNFKFM8NxqJy2VOsnuM8LEm+RfYBo7?=
 =?iso-8859-1?Q?kc8KtzMfehobOfqhU4uRuH/IG6Uw6rK2JgsVyWr9Aq62ZC/OZL6Zw1bRYS?=
 =?iso-8859-1?Q?Ef8JJgi/7/WVnjXbluQmxHDOsHaC2ahNXCuATNIeATaXu82xTVvLKqt1vp?=
 =?iso-8859-1?Q?NeQ/X/pManvVlrKKe18HrbGtHq5IKWEUGbYOeZ2OhFtuaYCif2MTzMUDTU?=
 =?iso-8859-1?Q?0ZrIngR0+/bTMCKC2Fy8pE8BuN5FE3rlvxadvzSXYU3MLBurRmueM0+ptO?=
 =?iso-8859-1?Q?BnEKClHLHPPjnpKF1a8K4deGpTH9qaycyBCxV7203TcuD1/uDTJ4XwZkPs?=
 =?iso-8859-1?Q?V0A6LQNRGH9RgPQtVMr0Ex/iR5QbEK7xIZ/h0FDRyfBwvv99Bn6sR0A7ba?=
 =?iso-8859-1?Q?unnAZZWx1bmKn21hp1CSSJX31Aq78UnoesoP87QzwGrZt0ioxchY1mUL+I?=
 =?iso-8859-1?Q?yrP1MTLlaqWN3U4tfBqjwlxsvyqAFQYmJ5yf8Vh2IeLV2/zqRYeBnBmHbN?=
 =?iso-8859-1?Q?AOrxW8f35pWsnAl9FVSyZGw8laP1YqTU88RWpA72B/rNfYrJDSFYymRyFP?=
 =?iso-8859-1?Q?5t0lr98OgPNfXwJN/qGLh8PgG2awPD9WtNUbqZmCqZwyGd5NzXRUV3XxUZ?=
 =?iso-8859-1?Q?JsdTNDGg+s/jb6fpH+Sst03XkWZ5RAePKfKzNHYZf9eZff2IhN2eTNwc+s?=
 =?iso-8859-1?Q?1rYfut6ZCqjTcsN7gnSRfIa7SVX+ZUHVsPNvN75BZkVvRpBT5leq3Z65re?=
 =?iso-8859-1?Q?zdauEcH6pGXtPrY4pZceVF8YWI74LbofnZbpxsJ5F1xa9b1Vws6p/xqLgl?=
 =?iso-8859-1?Q?mMbtXLmpgM7uRZSAjhf+cYb7ZR2+P7NmfkaThbSVXpXuTdGOMFl63WXViN?=
 =?iso-8859-1?Q?kUE2Hea/B8BZJhVEdKN6E2IfoJG4XDK1tiKauqslUbwsv53MF47QLyD0AF?=
 =?iso-8859-1?Q?Z4mQAUz3l8pmD1xDd9Md8L7YRjGcsd/jijLAZREYIx46OVm+eaLs3wrwwM?=
 =?iso-8859-1?Q?227A=3D=3D?=
Content-ID: <F5AB6A4884493443B9923869287763F8@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3213.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de173aec-1a05-4f2e-9fc2-08daf0035b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 16:30:43.3637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +fGy5KAyb80UlIc//z+OF2TAX5FFNAHb8cz9Xmr5/ZPz6RL3H7ljn1rgDn5LVR8X+jefLqq8xEdi+UOrbS0Mqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4666
X-Proofpoint-GUID: Xf32gw-N19hNOD2ARyIFXiBbZ6uZmHbY
X-Proofpoint-ORIG-GUID: Xf32gw-N19hNOD2ARyIFXiBbZ6uZmHbY
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_10,2023-01-06_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

+ bpf list for wider visibility

Hi Eduard,

Thanks a lot for looking into this!

> On Jan 6, 2023, at 5:10 AM, Eduard Zingerman <eddyz87@gmail.com> wrote:
>=20
> !-------------------------------------------------------------------|
>  This Message Is From an External Sender
>=20
> |-------------------------------------------------------------------!
>=20
> Hi Guys,
>=20
> I think we have a temporary issue with CI on s390 caused by one of the
> upstream commits. All recent pull requests are failing because of the
> build issue on s390, e.g.:
> - https://github.com/kernel-patches/bpf/actions/runs/3851652311
> - https://github.com/kernel-patches/bpf/actions/runs/3851642638
> - https://github.com/kernel-patches/bpf/actions/runs/3851641331
>=20
> This LKML link discusses the issue:
> https://lkml.org/lkml/2023/1/2/30
>=20
> The suggestion is to revert commit 99cb0d917ffa1ab628bb67364ca9b162c07699=
b1 .
>=20
> I did this for my pull request and it worked:
> https://github.com/kernel-patches/bpf/pull/4299
>=20
> Maybe temporarily add this revert as a pre CI patch?

Yes, please, create a pull request to https://github.com/kernel-patches/vmt=
est.

Let's have PR pass the tests while waiting for BPF community input, if any.

>=20
> Thanks,
> Eduard

