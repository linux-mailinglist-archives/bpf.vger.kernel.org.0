Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B99950C36D
	for <lists+bpf@lfdr.de>; Sat, 23 Apr 2022 01:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiDVWOS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 18:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbiDVWNZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 18:13:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDC330FDDD
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 14:02:21 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 23MHt7wZ025238
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 14:02:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=KOr7/AoYga2w5v30kQ6C1E/hD9L6RAveXKWE5GAyWvY=;
 b=bCBvS3zChhEt9i42vHvS+bLWWfB5wP1/otyqC7TBegwT+B5G1I/vsnMeRybpM8QucOXN
 sI3OC3ZjiGflGTohf7ZldX5LdfA6+R86TUh+ux43i3oHh6gDIQJjsQ9YfdzSScYvn8ks
 ZWad+NG/4SgX2pY0y+QcUwbspIjY45mTH34= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by m0001303.ppops.net (PPS) with ESMTPS id 3fm09f1q20-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 14:02:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzEeTmgI37vagqaKpgsMPM5p4wY/JthTWjIfN0EVPN7FkZWrpC3loX9WKuxBZxxh6AvIft4C67xA8q22YkZnXJWFkR45RAnRAR+2N6RY50uoaryAEvozTxifCh32v6yPhmKdJrTc7FtTPkkeehO6/LjmNPorT2rehC6VPNAiGx0m2ZJFmzE2Xj6HmDijTR9o6hVRVNHshxx88cv01kLisb7pnv6KRyqsWIHW7YLP/bAVuK63UAJREWKdcOhXWdkOuWTluMwThFxP2i2FT/BKXjb1FzfN2mutTPkhhkOGzmHlNB5MJAP8vzvI9JzPJXd8A1epB0UszBBy9fVXxa6z+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOr7/AoYga2w5v30kQ6C1E/hD9L6RAveXKWE5GAyWvY=;
 b=h30KmUFD343bcHERoutwxRv7kDDebsKKJMcj7nRk9VBtCGyYUi7ymOflPBKipynbHn8HsgYwGmQV1Mn1HWIqWJ/fXK+OSTAx19Gmrt11OSgpAkB8tAG0h9SMprYyThGtNi+TOs+gdtrU52b/ymLwCvSSK63BjuKffaDTxULhHFMl7IpJqzC5+55izqc06WB2KyjWEGU09fjmey28sCooadbFUks1MRozqfpcGEIyX9ogYZKNaIYvH6SvUhGHaNOawWDmaKvWLWPMiufJSP69jIzk4JpivAr5VGW3c5BSrmuE6anQpz+sZnmDSYwb0xxwqqAhivsfDqTNKd6HPNAkmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by BYAPR15MB3143.namprd15.prod.outlook.com (2603:10b6:a03:b5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 21:02:17 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::2174:fa72:f7fe:fe5c]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::2174:fa72:f7fe:fe5c%5]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 21:02:17 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: switch fexit_stress to
 bpf_link_create() API
Thread-Topic: [PATCH bpf-next 3/3] selftests/bpf: switch fexit_stress to
 bpf_link_create() API
Thread-Index: AQHYVTF/wErk4A7nTUuT1ZcQRNz0D6z8bhsA
Date:   Fri, 22 Apr 2022 21:02:17 +0000
Message-ID: <09c00df2359ca069b1f757ae46f13843fe95cc7e.camel@fb.com>
References: <20220421033945.3602803-1-andrii@kernel.org>
         <20220421033945.3602803-4-andrii@kernel.org>
In-Reply-To: <20220421033945.3602803-4-andrii@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2b44ac5-47e0-4268-46ff-08da24a36253
x-ms-traffictypediagnostic: BYAPR15MB3143:EE_
x-microsoft-antispam-prvs: <BYAPR15MB31430C30BD5E78235125403ECCF79@BYAPR15MB3143.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rptDIh2709ZjiqPcHK9qvFJPmWMB2N1r/aXkmjuJWdcNlVS1ZbzCA3C9u7bzNhWMs9xzXW3I8s7lHFVzCrQSXY8RBiFeeFiDstF+17CdvebVzzrMUh0/ZRm/848bddtV3/FQRjJH2McRRPq8PkR5hn9SZqII3SyDQaVfInZVAJyzgAR1rijTbkEF9NYIsPr+OIbuF0/cpEc8M+xGPt02aI8N6n0hnFkEk1SuJAapjeTNC9RCPnAaYCDz/JuRE5e1m5H97rHMzabbCA9sG5Eq3flL6iKEkxCW5p4rX/PLNOgkB720jTdRINAHqK2hyZq0Dyc0lZxY6SrQ4sMymBtohbLRZ4K54OYBXDtl9/iAVkUquSxwju98h3p0xL93vWX9viuIsDYBmLFN4nA+ne0DTUB/32jdaAYzfbZOdZRr9GuG6eDOKYu/gYetWLkDiw25sfUiLb9jlDhVq4ei3FNr6to00TH7YG29948L+UjxJIifQIzeKHQnK7EfzK/X/Iw4i+pI1CNCXXe+7OSKn/ixRVRMxdQQH2UA/qhdTcfaXzlNKXRBZXyK+xqGd0JFh+wiZ4dtheKf4fHXd6JZcAXTffpGitQs7rTX/bG1IkgELayCJ9hHXeibnAmMbFPrdSeJAChTBfFH6R/nbtzIMwb0Dtbt56kHejANeg85DsaVuWQlkPrmBxsORzQYnjHFUqlhS5rAlrFyQKl1rGXMAFk13w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(36756003)(6512007)(6486002)(83380400001)(6506007)(66476007)(8676002)(64756008)(66446008)(66556008)(66946007)(4326008)(76116006)(2616005)(86362001)(8936002)(5660300002)(38100700002)(2906002)(38070700005)(186003)(316002)(4744005)(110136005)(71200400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWJJdDlkZ0srOEswWVpoNnNkQnBxNkZCcCswUjR6TjZFTjN1QisreWlZQzYy?=
 =?utf-8?B?RVZEamtCcE5vd0JaaE9CMGxuY0xUUW9oZytQWEQ3czUxRnNmVEcyYTZlcVFL?=
 =?utf-8?B?d1lnWnRlVHl4ZmwvdVJoYVVybWRYZ3NDS3h2c3NaZGR1TkJjRHloNmRoZUdS?=
 =?utf-8?B?bStqRHRsSjkybThNMmRZRGM5VFU2UzdZRDB2OUVVdW1HcHJEOVhITm1oNlBQ?=
 =?utf-8?B?YmcwdzBVQ1FyTnl4S3lOazhaWnFVSXI5WTg2RXhWRGFnR0NrcktSckJiOGxs?=
 =?utf-8?B?aDFrWU1mdEwwV0RPRVkxS25XWHNOd05TVXdSZlNPdHJ3REhuV0VOVDgvZUI1?=
 =?utf-8?B?SFEzdnVYc2FuVzR3VDQ5RnoreS9iNjU0QUU1akE5WnNtUWpEWi9lUjQ1Q2pG?=
 =?utf-8?B?ZkFkTWduMnk4WnNSdE9JRTE4L2pUb016L2dFL1JTT252SVlRcUhnTzhLcmZw?=
 =?utf-8?B?eEJwS01zOXFmT0FHWDBOTlZyS0l0R2liZ1l5ZDJqS3JuQkt4aUlxVnE4TVJx?=
 =?utf-8?B?ak9ORUpwakxCMUdSU28xazhTZk4rVDdobWFjNGlGMytFRzRhb1Joa3ZERGEv?=
 =?utf-8?B?TE5tcU52SmhhdkRRelJ2TnRodVJncURYTjBRVDk1aFVBeVF3eE10RVlCTWdi?=
 =?utf-8?B?MGRoVkovdG5wbyt1Nng1bER1cm1odndpZWhNU2RmNGRJVlJVRFpvWTN0TGkw?=
 =?utf-8?B?QjhEM2NjclNOOXpuR1B5LzJhV1BjaTI5SjZIaTBPYUdDV1RURmNXR2x1YzVU?=
 =?utf-8?B?ZkZ1Ym9xc2lzQ1VBQkZub3QrVDB5bHBidlBCVms5RGQzTUxWLzBUZEtkekJK?=
 =?utf-8?B?ZlNFSTRCNi8vb29MV01ZeWMyWXU4bFZaM0NqUEZqWkZrbXFnUnZERHZ5cHhu?=
 =?utf-8?B?KytsZmh4S2tkZVg3dFNyR2V0OUJNNE1ISkNUcEVHWVdGdUhscCtFRGMwWVBo?=
 =?utf-8?B?U3BoUDk3TmRHMGFTSXpWL29RSk1lNWV0bnRwTU8rVzAzdVRmMDJvbU5IZUV2?=
 =?utf-8?B?aFBTRHc3THVYU3NneXFkL244MkRYTGNuMmgzWlZ1VDdsd2x4eTlEWDg4MklC?=
 =?utf-8?B?WXpyK2FZUmcxbHFqalRjajJ3L2dpcnZxd0xVc0FERFBpVm92TUVFZ3Ivak55?=
 =?utf-8?B?RmhPM05YYTVXYWZ5VXpqUkYyN2JDdzBaSG40N0FUTllOS2hKbnZZck9xbi9u?=
 =?utf-8?B?c1R5MFAxSjYra1hGTUR6bEU3aTlHTWxuSlFZTmNreDJGY2JLOTlBK2drZ1pi?=
 =?utf-8?B?c3Q5Ym5mMWFXNDkwR0F5ampySmtiSDlYL3RjR3pLMkJwZUlJU2NWZzNzcG41?=
 =?utf-8?B?M3BFc3dDeS9hTU5YNS9YcndOcEdvaHZic040TDI2SENPQ1VtY2pLenRSOXRz?=
 =?utf-8?B?ZTBnQTlCbUV2cUZGcVdGS1duQXBUL1Y2Sm1LZGpYN3NacmhUQ1c1VmpRV1U0?=
 =?utf-8?B?bXdNWFBaS1V1ME1xRkZKaVU1T2lqbEhOZWdqSXc5NlVEVVhnSW9jdGxHaXRY?=
 =?utf-8?B?cmpINllXN0dnVlJ0cnlTQW5rWHEzZElYS01jeHl1N3RKL2NwS1FsY2xEb0Nu?=
 =?utf-8?B?VHV3TlFWUlY0dVQ1OE5UTVhmZFc4aThaSW0vaG5JR1d6b0p6cDhZSi9oRzg0?=
 =?utf-8?B?R3IxNGp4L0N6R3VhejdEN1lOdGlIT1I4WUUwRWk5NG9RRlM2aTF3V2FDeHBw?=
 =?utf-8?B?Z2p6SENVU284SGo4Ni9OM3I3ZW9aRlRacjZmU0dBUTJPM2p2ZTJRT0dMdGll?=
 =?utf-8?B?T0FZclI1Y2NWQkloVWRyTEk3aFJlTWVPWVd5cTFaUjV6SEZmUmVPTFJhT1la?=
 =?utf-8?B?YUlmSzd2K2Fic1RRMEozc1FuOGZsMzJyU0p3NmI5em83U1ZRZXFkbXp4YmMz?=
 =?utf-8?B?QWdWOVVXZTVpZVN2aFN4bzJwYjkwcDlDei95NExtdi9qSmJoaTZJMTdqcFQv?=
 =?utf-8?B?R08ydGxERjBqNmdEa0VkWmdJdjJHbVlTQmViSWd5eDMwblJ5VG1DODJKMGpR?=
 =?utf-8?B?QmZkNHF1aU85a3RNcGRFMkZiVHhLVTc2SUpmaDdPZ0NxTngzaEJlaXFvYVFx?=
 =?utf-8?B?Mi9DU0lNS203Q1cwc1h3WUloR3R5M1g3MDE2OVVaUi9XcU5HM1QyNmJnUXNW?=
 =?utf-8?B?WStFYThCY1E0UnBVZzVkZ3VLN1JpV0lSWDg4d1JRdzBmR2hBS2JXaWhEOHE3?=
 =?utf-8?B?SHlTSUZ4YUo1NFV2ajN5ekRyaHVvdTFRdzZVdWc0QVhGT1NYalpqTDB4bTE3?=
 =?utf-8?B?VDliZC8rU3FEcG93US9EdjNjSUN3M3FpZ0tnU1RmMklxbm1rcTd4Q29BNDdi?=
 =?utf-8?B?MW9rMjB0NGhwanlYdEx4ejlTKzBoUHplK1RLbnVDMUdyS3F0QVFwaCtaajQr?=
 =?utf-8?Q?Mj38PqNjP4FpOzg2wvCr0AczJmb9lq69RaxDe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB5BDF57B5A4A24D94FA3B7A56C35F71@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b44ac5-47e0-4268-46ff-08da24a36253
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 21:02:17.3771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3dsKuV7tAN6le7b9rfLeMtC7l5wk0eNPkyXRjtgnZXxFDhI+TtnhuDsNahMv0Obs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3143
X-Proofpoint-ORIG-GUID: qZevPrAG1X8yLByIhQA3yq4sVKZLaj3G
X-Proofpoint-GUID: qZevPrAG1X8yLByIhQA3yq4sVKZLaj3G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_06,2022-04-22_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gV2VkLCAyMDIyLTA0LTIwIGF0IDIwOjM5IC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
Cj4gVXNlIGJwZl9saW5rX2NyZWF0ZSgpIEFQSSBpbiBmZXhpdF9zdHJlc3MgdGVzdCB0byBhdHRh
Y2ggRkVYSVQKPiBwcm9ncmFtcy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBBbmRyaWkgTmFrcnlpa28g
PGFuZHJpaUBrZXJuZWwub3JnPgoKUmV2aWV3ZWQtYnk6IEt1aS1GZW5nIExlZSA8a3VpZmVuZ0Bm
Yi5jb20+CgoKPiAtLS0KPiDCoHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3Rz
L2ZleGl0X3N0cmVzcy5jIHwgMiArLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2JwZi9wcm9nX3Rlc3RzL2ZleGl0X3N0cmVzcy5jCj4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9icGYvcHJvZ190ZXN0cy9mZXhpdF9zdHJlc3MuYwo+IGluZGV4IDNlZTIxMDdiYmY3YS4uZmUx
ZjBmMjZlYTE0IDEwMDY0NAo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9n
X3Rlc3RzL2ZleGl0X3N0cmVzcy5jCj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBm
L3Byb2dfdGVzdHMvZmV4aXRfc3RyZXNzLmMKPiBAQCAtNTMsNyArNTMsNyBAQCB2b2lkIHRlc3Rf
ZmV4aXRfc3RyZXNzKHZvaWQpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnRyYWNl
X29wdHMpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFBU1NFUlRfR0Uo
ZmV4aXRfZmRbaV0sIDAsICJmZXhpdCBsb2FkIikpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXQ7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGxpbmtfZmRbaV0gPSBicGZfcmF3X3RyYWNlcG9pbnRfb3BlbihOVUxMLAo+IGZl
eGl0X2ZkW2ldKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbGlua19mZFtpXSA9
IGJwZl9saW5rX2NyZWF0ZShmZXhpdF9mZFtpXSwgMCwKPiBCUEZfVFJBQ0VfRkVYSVQsIE5VTEwp
Owo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFBU1NFUlRfR0UobGlua19m
ZFtpXSwgMCwgImZleGl0IGF0dGFjaCIpKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0Owo+IMKgwqDCoMKgwqDCoMKgwqB9Cgo=
