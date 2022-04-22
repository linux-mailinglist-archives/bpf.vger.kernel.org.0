Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C108250C359
	for <lists+bpf@lfdr.de>; Sat, 23 Apr 2022 01:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiDVWLl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 18:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiDVWLC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 18:11:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837CB2FB723
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 13:57:07 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23MHt90d006697
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 13:57:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Vd62ALxWb1DLOgq1B6BAkZZYviDAGFCo+xGKAM8sZ9Y=;
 b=lvNrf0ka0Z9Sj6bBxDbz02+Y/K0nR+kH9JtUrjqtY2azn3O4JU2X59c7WoL8PSMk1z4a
 4Hboaumx3Y2QxEW9bqxmZVZhM4Ovvm0vZNaMQ+rCynR7vzaNwIoATZxr6iuRYydlsk/y
 D5NbTpmAVvKzpuuv+5Wha9ko6Qn5zSyfAmI= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fka36a3c7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 13:57:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M03bGNt21KuvykExA2aCRViupksSxCq8AhyauhD6bU68ebtSSU4VOI5iFXKcKJxkN1PY8zUsrLTTCNbKoWteqyeSQYggV94hn1E7jWBh8VuNQ6fN2cP56WYDZzz+U8vRemtDVq3EN4vxAPX4ridRJ6yTkTHBrPSU3ELzMD1RHZAyCK2Ru/9ynP7VE2NudQFyhRKGd8r2pY0O4yfLdhnG7NNKpWhy/UKtDPpqKbotMgdT7g1qLiL4QQxPdWhGVL+klXKLw+JgMJDA1+j9Ps86NL3KoI8xzckvZ8KuIJ68miQysCvw9MXhx1CVmMKbAYUFLobyIdDaltbawxHsum/lxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vd62ALxWb1DLOgq1B6BAkZZYviDAGFCo+xGKAM8sZ9Y=;
 b=i+e8NFvryExEukJ/YiTFIBD9dgX9hfKp5tqO90g4j83Qb5Meoaw9a0Q+hPRb4lyxDI2cWrm2F346skz5tp3uPJU3B0/prrJD8s7pimMSg8tUbEEdIdaZk3OOf3G8TxoGPz3dsVrkvbP4xoYA9jT1CqtBjk3zj9w3ScH0h6tkL39T8CIGQzKaneqDEUE7RbI0eN/SHEei9j5DXl+iW51X+TqjoaBP9ZYeHFig9VkRL5aKiu3LHUxoMtVxaM2RQFne27hAC2dihf/7+ybjkYHQem2dYQJYXp1IV4vmTaFZ3Ad6HAl5I8NQce1I0zRbYR4cKJPzwJ/XtdlVD4yl26HPsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by SA0PR15MB3760.namprd15.prod.outlook.com (2603:10b6:806:84::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 20:57:04 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::2174:fa72:f7fe:fe5c]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::2174:fa72:f7fe:fe5c%5]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 20:57:04 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 2/3] libbpf: teach bpf_link_create() to fallback
 to bpf_raw_tracepoint_open()
Thread-Topic: [PATCH bpf-next 2/3] libbpf: teach bpf_link_create() to fallback
 to bpf_raw_tracepoint_open()
Thread-Index: AQHYVTF/31FFXEnnqUSvXEfZbiDuw6z8bKWA
Date:   Fri, 22 Apr 2022 20:57:03 +0000
Message-ID: <84ecdc645f3306f2f4baa0762ed66e9606a8fd2f.camel@fb.com>
References: <20220421033945.3602803-1-andrii@kernel.org>
         <20220421033945.3602803-3-andrii@kernel.org>
In-Reply-To: <20220421033945.3602803-3-andrii@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c7d2bd6-6e02-4942-0cc1-08da24a2a78b
x-ms-traffictypediagnostic: SA0PR15MB3760:EE_
x-microsoft-antispam-prvs: <SA0PR15MB3760DD9E8512F66486FFEF87CCF79@SA0PR15MB3760.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uypQWXJwcv8enMWXIUmgLD98rdEVxbmsL0FiQWV3FEygPRvaBFT6wGX2FoewRQfQCiA2fxz1Gpdg3WNIc4iqkyE7bKWCI+8hLu0KIfFu538l4XotrnAxRED3B82LR+Xy19ezfhMeHYwu34SVSIlzkmHpH6iF41gnVc+Eh1SJOG20PmG1cUyaU34MViLJ1Z+RfO2hcmKbgL67GZ3O+aDdkbCo1Ktex5Yly6xa/v4FpV6B0mR6ZRKgpPuBLIq1pHVj0H9eQeo4o8EdhrGwCx6omzVUqXPRX0ut1J9cgrd3Fh4+8pVPmNOmtZWcrSdO4WH1pNaHF/4kkRU57TdvbTzVyUwPXRG1XxNpIpW+lzb6Pw5otipRI6jDnC42VKeVb4z+3iYqifDVekxrW9WNUI5cXV3D/qfXKi7HDtFivDUGlpQHOFTX1XrkB0rlduGtPVxAlXDE8kVZo/2TvZGEugMdQyMpbLIq9+ZdMSPDDIkEp3fymb6ztxxy6mkouNFtDYssAH9RI33CkGkR7yKSpAeiURkm1hzVG4vGGihvEdzqSpcRFBMUtTTU8Je53jLaG3R2zP5Nc5ageTjMgmNJ8ZStkattXAJBEUQ1mjAIZJMeXQqt0tSrsh0koefOce4GrIIaCc6nNGgU6p0b4Xizq6CiyDraN84SD/b+Kvt1QByfHfa0Zdrq498/bvI/o98Kbjic4Yd2Uy4AGR0xZLtFR3qb2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6512007)(8936002)(66446008)(2616005)(122000001)(38100700002)(6506007)(83380400001)(86362001)(38070700005)(66556008)(66476007)(76116006)(64756008)(66946007)(5660300002)(8676002)(4326008)(36756003)(2906002)(110136005)(316002)(71200400001)(6486002)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3cvNVdOSjlHeTZrODlxYWpSRW5yK3hXZUFxTTJXdFowajBxOEhwTzAra2sv?=
 =?utf-8?B?a3ZBOGlhOGdnd3JjbjR3MWNBYWRIRE1ENFI0c0U1WU0xTlhhR2ZKazR2WnB5?=
 =?utf-8?B?NnJkOW5mY0VDcEdtdEVYR1I2OTF2SnZYR0x2RUR1YU1xeWZZelI3aDVqL2Zo?=
 =?utf-8?B?UldMV1VyL3FxM2xRejBBdEdEaTc5Z3FqaDJBYk5vQkNuYlZBWlh0RmM2YzlV?=
 =?utf-8?B?SHVBMEN1M2txdTVhM3QzWWY3ZUFmcERCMmI0c0V3bGhIL0ZWQXVPdFBrQlRO?=
 =?utf-8?B?cHpDMnRRSENIczFWTkR1Y1hBczVWQXM3MXd0RHl3UXdDVDZTY1BKS2tXa1hJ?=
 =?utf-8?B?Qy9wTHFkUnRYUEZ0dGNSSWRwbHlzMXBFUFp3MFVGZjg1ZGx2NmFzZDR4QWhs?=
 =?utf-8?B?dHlBTWNDUDUzVEdYVmpsRnh1SkhpU2Vkb1doUFlnWm92SjJsTmdTTXVxOWgy?=
 =?utf-8?B?ZWNIc0E4eHhnMzdqUmdEdmxyMnZuM0R5M3N3QW01UXdSMjY2Zm5GU3NWNFZs?=
 =?utf-8?B?MjVpU2U3cmZwaXBYVzlHa1EwVDV6R2NLRWNqMDM3VXU4NWdkU0F1c0JjV2FX?=
 =?utf-8?B?KzRGRXJxTmZFT1NLcE1MZ1hrT2hYSEhZNkFWN1ViNHNaNG9Pdnp0YVdBYzBH?=
 =?utf-8?B?WGxsVmFKV3ByQXZMNFFBcEZmWXJSL1VSVWVobTlEajVVU2VVRE9jamFYdzBW?=
 =?utf-8?B?SUMwZTV3aHp2emxnRWxEWG11UnI3c21hRUVnNUpVOWRKQjkzMG9FdS9PMC9q?=
 =?utf-8?B?NFg0NE5rRUZiSTBMcTdkQTkxb1IwZUtIKzM0RTlBWHhUeUJ3MnN0MmY2TU1L?=
 =?utf-8?B?bFdJd2Nsbklzb2dhdU5MdUNEZEJFb1JOaW5acEZqU1U5Y1czbWtXT0krMDdS?=
 =?utf-8?B?clk5MDY1NUxNb2Q1dkdTcmlVVEd5aXhuL01RR3pkNHZzYVVkY09MU1c1MGpX?=
 =?utf-8?B?ZTlHd3dlTXdvUW00UFk0cGIrQlFQOTE1cHl1eTNHdHRxaDFEcFVYU291M1Ez?=
 =?utf-8?B?M0Q0V2pwd25vVzVHcGpHb0VCMnRkSlVubWJ6Mk8zSFJJT0o2ejN5dFp4M0w4?=
 =?utf-8?B?djc2Sy9Zc2JOM0w3bjArYmFiaEx1ejVWdytHYStoNXZweU1SS2JNcjUvQnBL?=
 =?utf-8?B?UkNJMm10MEpZWXNuRkZmZGc5S2tLdENKemRPVHlzU0h1OFZpaDg5cktmRGFE?=
 =?utf-8?B?SldOSi84Vkw0NXdac05KM2REYlNncFFoTUJXdmVvYy8xdWlnZk5XWEpTTXNY?=
 =?utf-8?B?eHJZWHlIdDQrRGowV1g4ZDRzTFoyZzA0Z0NXVkpsN1ZVK29SaE1VUFFLMTdo?=
 =?utf-8?B?bE41bkNEYk94SFJ1OEY1SW1QZUpGSklMSGZxdG5jUUowNFdENWRMU3k5aEFi?=
 =?utf-8?B?VjRYMlZjMCtDaTlMS0d0dkhqbjNoN3lXUktha09naXZoVU4vOEE3QXVMTDJi?=
 =?utf-8?B?dzZOMVF1VzBudnZxNytUUmQxRGJ0V1QreFZnN1lnTjMyUWFDZ2JJZkFBNUlt?=
 =?utf-8?B?TlJ0d1hqSE5wVDB4WE13OEFCZGR1ZTdjaUVsUUp6NGpGYmZLczU0MFNxTWFn?=
 =?utf-8?B?b1pPM01OdkpkVXJHUFRDNFNJaW04ZDNuOWdWV2RkM0YwMG9vSG4zT3ZxQ3RJ?=
 =?utf-8?B?cGRCODNza2pzdzRSL0FpN3ppYm52ZituL2R4RS9ObU0yL0kzS2d6THNVQWJ4?=
 =?utf-8?B?YjUxZStQTHFHbkl4OE5kWTN5YTlMSTg5dUROaU5kZWdxSGo1TmxFUms1NG9N?=
 =?utf-8?B?Vjd3Y1VZUWdZdjNRQ29BMUd5NXN0ZjcxNEkvbVVVV3BYTkdQT1ptSmhWUmFO?=
 =?utf-8?B?dEVqcGpEbkxGQ1BnZE9Za04xYjNtNFEvaUlsWlpCcWphTnN4V1pYSVl6WFRJ?=
 =?utf-8?B?SGRRZHlBSi9RTjlEN2o2Q3M3eU9KWnh0bXNYQU0xMXQxYjA2SFNCaTZUM2hi?=
 =?utf-8?B?WU9xeE1EcjQ5bncrVHN3ZkJmaDRHbE50RVRZVWVQN1FJTm51SVdiYjBrLzVK?=
 =?utf-8?B?TFpGamxqbjBBOXlTZXl3R3VjaUkzejU4QURwcnFYbEpQTTh1NGw0SFJRSURY?=
 =?utf-8?B?U2d4STNVWVhyQUpjSmJNUmFTbSt5SXc4Nm5Wcy9Na1hDd0V3NGR3YVpDN1ZC?=
 =?utf-8?B?S2JyeG1VT0JCQVF5Ung0QTI2aUl0TUpxMUVhZ2NISCtuZUxSNlZhUFRNbUd0?=
 =?utf-8?B?NlYrZFcxdXBlbDRuLzg0dkIxS09FQjdKYTNVUlM0QmVCNngrUmZSYUtwS29N?=
 =?utf-8?B?KzdRQ1R4c3d3Y0YyTWxDeHhOaFp0Y3dCaHJvTTdRem4vdkJHZnk3dFEvNDRN?=
 =?utf-8?B?aVdoaG5sbzlGUDdSK2F1VXFPRVZPV0JjMGRIekc4d2VQUkpqRjF6eHBrMmdZ?=
 =?utf-8?Q?TZNCH9ZUBdzxpetZUOB/yr97FuN0hU2WBoJ+Q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D56BFBE249C11B4B9905FC2A4C6633AB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7d2bd6-6e02-4942-0cc1-08da24a2a78b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 20:57:03.9931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5HTnSlvjzCBLXcorL+cyqDshb2HCFRs6z28D453le+q8wEW+9QnI4+w8SLupjIWM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3760
X-Proofpoint-ORIG-GUID: yCJHVXKYNIB47WOh3N72JsewS9XPzgPA
X-Proofpoint-GUID: yCJHVXKYNIB47WOh3N72JsewS9XPzgPA
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
Cj4gVGVhY2ggYnBmX2xpbmtfY3JlYXRlKCkgdG8gZmFsbGJhY2sgdG8gYnBmX3Jhd190cmFjZXBv
aW50X29wZW4oKSBvbgo+IG9sZGVyIGtlcm5lbHMgZm9yIHByb2dyYW1zIHRoYXQgYXJlIGF0dGFj
aGFibGUgdGhyb3VnaAo+IEJQRl9SQVdfVFJBQ0VQT0lOVF9PUEVOLiBUaGlzIG1ha2VzIGJwZl9s
aW5rX2NyZWF0ZSgpIG1vcmUgdW5pZmllZAo+IGFuZAo+IGNvbnZlbmllbnQgaW50ZXJmYWNlIGZv
ciBjcmVhdGluZyBicGZfbGluay1iYXNlZCBhdHRhY2htZW50cy4KPiAKPiBXaXRoIHRoaXMgYXBw
cm9hY2ggZW5kIHVzZXJzIGNhbiBqdXN0IHVzZSBicGZfbGlua19jcmVhdGUoKSBmb3IKPiB0cF9i
dGYvZmVudHJ5L2ZleGl0L2Ztb2RfcmV0L2xzbSBwcm9ncmFtIGF0dGFjaG1lbnRzIHdpdGhvdXQg
bmVlZGluZwo+IHRvCj4gY2FyZSBhYm91dCBrZXJuZWwgc3VwcG9ydCwgYXMgbGliYnBmIHdpbGwg
aGFuZGxlIHRoaXMgdHJhbnNwYXJlbnRseS4KPiBPbgo+IHRoZSBvdGhlciBoYW5kLCBhcyBuZXdl
ciBmZWF0dXJlcyAobGlrZSBCUEYgY29va2llKSBhcmUgYWRkZWQgdG8KPiBMSU5LX0NSRUFURSBp
bnRlcmZhY2UsIHRoZXkgd2lsbCBiZSByZWFkaWx5IHVzYWJsZSB0aG91Z2ggdGhlIHNhbWUKPiBi
cGZfbGlua19jcmVhdGUoKSBBUEkgd2l0aG91dCBhbnkgbWFqb3IgcmVmYWN0b3JpbmcgZnJvbSB1
c2VyJ3MKPiBzdGFuZHBvaW50Lgo+IAo+IGJwZl9wcm9ncmFtX19hdHRhY2hfYnRmX2lkKCkgaXMg
bm93IHVzaW5nIGJwZl9saW5rX2NyZWF0ZSgpCj4gaW50ZXJuYWxseQo+IGFzIHdlbGwgYW5kIHdp
bGwgdGFrZSBhZHZhbnRhZ2VkIG9mIHRoaXMgdW5pZmllZCBpbnRlcmZhY2Ugd2hlbiBCUEYKPiBj
b29raWUgaXMgYWRkZWQgZm9yIGZlbnRyeS9mZXhpdC4KPiAKPiBEb2luZyBwcm9hY3RpdmUgZmVh
dHVyZSBkZXRlY3Rpb24gb2YgTElOS19DUkVBVEUgc3VwcG9ydCBmb3IKPiBmZW50cnkvdHBfYnRm
L2V0YyBpcyBxdWl0ZSBpbnZvbHZlZC4gSXQgcmVxdWlyZXMgcGFyc2luZyB2bWxpbnV4IEJURiwK
PiBkZXRlcm1pbmluZyBzb21lIHN0YWJsZSBhbmQgZ3VhcmFudGVlZCB0byBiZSBpbiBhbGwga2Vy
bmVscyB2ZXJzaW9ucwo+IHRhcmdldCBCVEYgdHlwZSAoZWl0aGVyIHJhdyB0cmFjZXBvaW50IG9y
IGZlbnRyeSB0YXJnZXQgZnVuY3Rpb24pLAo+IGFjdHVhbGx5IGF0dGFjaGluZyB0aGlzIHByb2dy
YW0gYW5kIHRodXMgcG90ZW50aWFsbHkgYWZmZWN0aW5nIHRoZQo+IHBlcmZvcm1hbmNlIG9mIHRo
ZSBob3N0IGtlcm5lbCBicmllZmx5LCBldGMuIFNvIGluc3RlYWQgd2UgYXJlIHRha2luZwo+IG11
Y2ggc2ltcGxlciAibGF6eSIgYXBwcm9hY2ggb2YgZmFsbGluZyBiYWNrIHRvCj4gYnBmX3Jhd190
cmFjZXBvaW50X29wZW4oKSBjYWxsIG9ubHkgaWYgaW5pdGlhbCBMSU5LX0NSRUFURSBjb21tYW5k
Cj4gZmFpbHMuIEZvciBtb2Rlcm4ga2VybmVscyB0aGlzIHdpbGwgbWVhbiB6ZXJvIGFkZGVkIG92
ZXJoZWFkLCB3aGlsZQo+IG9sZGVyIGtlcm5lbHMgd2lsbCBpbmN1ciBtaW5pbWFsIG92ZXJoZWFk
IHdpdGggYSBzaW5nbGUgZmFzdC1mYWlsaW5nCj4gTElOS19DUkVBVEUgY2FsbC4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBBbmRyaWkgTmFrcnlpa28gPGFuZHJpaUBrZXJuZWwub3JnPgoKUmV2aWV3ZWQt
Ynk6IEt1aS1GZW5nIExlZSA8a3VpZmVuZ0BmYi5jb20+CgpUaGlzIGlzIHZlcnkgc3RyYWlnaHQg
Zm9yd2FyZC4KCj4gLS0tCj4gwqB0b29scy9saWIvYnBmL2JwZi5jwqDCoMKgIHwgMzQgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLQo+IMKgdG9vbHMvbGliL2JwZi9saWJicGYuYyB8
wqAgMyArKy0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbGliL2JwZi9icGYuYyBiL3Rvb2xzL2xpYi9i
cGYvYnBmLmMKPiBpbmRleCBjZjI3MjUxYWRiOTIuLmE5ZDI5MmMxMDZjMiAxMDA2NDQKPiAtLS0g
YS90b29scy9saWIvYnBmL2JwZi5jCj4gKysrIGIvdG9vbHMvbGliL2JwZi9icGYuYwo+IEBAIC04
MTcsNyArODE3LDcgQEAgaW50IGJwZl9saW5rX2NyZWF0ZShpbnQgcHJvZ19mZCwgaW50IHRhcmdl
dF9mZCwKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoMKgX191MzIgdGFyZ2V0X2J0Zl9pZCwgaXRlcl9p
bmZvX2xlbjsKPiDCoMKgwqDCoMKgwqDCoMKgdW5pb24gYnBmX2F0dHIgYXR0cjsKPiAtwqDCoMKg
wqDCoMKgwqBpbnQgZmQ7Cj4gK8KgwqDCoMKgwqDCoMKgaW50IGZkLCBlcnI7Cj4gwqAKPiDCoMKg
wqDCoMKgwqDCoMKgaWYgKCFPUFRTX1ZBTElEKG9wdHMsIGJwZl9saW5rX2NyZWF0ZV9vcHRzKSkK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBsaWJicGZfZXJyKC1FSU5W
QUwpOwo+IEBAIC04NzAsNyArODcwLDM3IEBAIGludCBicGZfbGlua19jcmVhdGUoaW50IHByb2df
ZmQsIGludCB0YXJnZXRfZmQsCj4gwqDCoMKgwqDCoMKgwqDCoH0KPiDCoHByb2NlZWQ6Cj4gwqDC
oMKgwqDCoMKgwqDCoGZkID0gc3lzX2JwZl9mZChCUEZfTElOS19DUkVBVEUsICZhdHRyLCBzaXpl
b2YoYXR0cikpOwo+IC3CoMKgwqDCoMKgwqDCoHJldHVybiBsaWJicGZfZXJyX2Vycm5vKGZkKTsK
PiArwqDCoMKgwqDCoMKgwqBpZiAoZmQgPj0gMCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmV0dXJuIGZkOwo+ICvCoMKgwqDCoMKgwqDCoC8qIHdlJ2xsIGdldCBFSU5WQUwgaWYg
TElOS19DUkVBVEUgZG9lc24ndCBzdXBwb3J0IGF0dGFjaGluZwo+IGZlbnRyeQo+ICvCoMKgwqDC
oMKgwqDCoCAqIGFuZCBvdGhlciBzaW1pbGFyIHByb2dyYW1zCj4gK8KgwqDCoMKgwqDCoMKgICov
Cj4gK8KgwqDCoMKgwqDCoMKgZXJyID0gLWVycm5vOwo+ICvCoMKgwqDCoMKgwqDCoGlmIChlcnIg
IT0gLUVJTlZBTCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGxpYmJw
Zl9lcnIoZXJyKTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgLyogaWYgdXNlciB1c2VkIGZlYXR1cmVz
IG5vdCBzdXBwb3J0ZWQgYnkKPiArwqDCoMKgwqDCoMKgwqAgKiBCUEZfUkFXX1RSQUNFUE9JTlRf
T1BFTiBjb21tYW5kLCB0aGVuIGp1c3QgZ2l2ZSB1cAo+IGltbWVkaWF0ZWx5Cj4gK8KgwqDCoMKg
wqDCoMKgICovCj4gK8KgwqDCoMKgwqDCoMKgaWYgKGF0dHIubGlua19jcmVhdGUudGFyZ2V0X2Zk
IHx8Cj4gYXR0ci5saW5rX2NyZWF0ZS50YXJnZXRfYnRmX2lkKQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gbGliYnBmX2VycihlcnIpOwo+ICvCoMKgwqDCoMKgwqDCoGlm
ICghT1BUU19aRVJPRUQob3B0cywgc3opKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gbGliYnBmX2VycihlcnIpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqAvKiBvdGhlcndp
c2UsIGZvciBmZXcgc2VsZWN0IGtpbmRzIG9mIHByb2dyYW1zIHRoYXQgY2FuIGJlCj4gK8KgwqDC
oMKgwqDCoMKgICogYXR0YWNoZWQgdXNpbmcgQlBGX1JBV19UUkFDRVBPSU5UX09QRU4gY29tbWFu
ZCwgdHJ5IHRoYXQKPiBhcwo+ICvCoMKgwqDCoMKgwqDCoCAqIGEgZmFsbGJhY2sgZm9yIG9sZGVy
IGtlcm5lbHMKPiArwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKgwqBzd2l0Y2ggKGF0
dGFjaF90eXBlKSB7Cj4gK8KgwqDCoMKgwqDCoMKgY2FzZSBCUEZfVFJBQ0VfUkFXX1RQOgo+ICvC
oMKgwqDCoMKgwqDCoGNhc2UgQlBGX0xTTV9NQUM6Cj4gK8KgwqDCoMKgwqDCoMKgY2FzZSBCUEZf
VFJBQ0VfRkVOVFJZOgo+ICvCoMKgwqDCoMKgwqDCoGNhc2UgQlBGX1RSQUNFX0ZFWElUOgo+ICvC
oMKgwqDCoMKgwqDCoGNhc2UgQlBGX01PRElGWV9SRVRVUk46Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybiBicGZfcmF3X3RyYWNlcG9pbnRfb3BlbihOVUxMLCBwcm9nX2Zk
KTsKPiArwqDCoMKgwqDCoMKgwqBkZWZhdWx0Ogo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gbGliYnBmX2VycihlcnIpOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiDCoH0KPiDC
oAo+IMKgaW50IGJwZl9saW5rX2RldGFjaChpbnQgbGlua19mZCkKPiBkaWZmIC0tZ2l0IGEvdG9v
bHMvbGliL2JwZi9saWJicGYuYyBiL3Rvb2xzL2xpYi9icGYvbGliYnBmLmMKPiBpbmRleCA5NDk0
MDQ5NzM1NGIuLmFlMzE3ZGYxZmM1NyAxMDA2NDQKPiAtLS0gYS90b29scy9saWIvYnBmL2xpYmJw
Zi5jCj4gKysrIGIvdG9vbHMvbGliL2JwZi9saWJicGYuYwo+IEBAIC0xMTI2Miw3ICsxMTI2Miw4
IEBAIHN0YXRpYyBzdHJ1Y3QgYnBmX2xpbmsKPiAqYnBmX3Byb2dyYW1fX2F0dGFjaF9idGZfaWQo
Y29uc3Qgc3RydWN0IGJwZl9wcm9ncmFtICpwcm8KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiBsaWJicGZfZXJyX3B0cigtRU5PTUVNKTsKPiDCoMKgwqDCoMKgwqDCoMKg
bGluay0+ZGV0YWNoID0gJmJwZl9saW5rX19kZXRhY2hfZmQ7Cj4gwqAKPiAtwqDCoMKgwqDCoMKg
wqBwZmQgPSBicGZfcmF3X3RyYWNlcG9pbnRfb3BlbihOVUxMLCBwcm9nX2ZkKTsKPiArwqDCoMKg
wqDCoMKgwqAvKiBsaWJicGYgaXMgc21hcnQgZW5vdWdoIHRvIHJlZGlyZWN0IHRvCj4gQlBGX1JB
V19UUkFDRVBPSU5UX09QRU4gb24gb2xkIGtlcm5lbHMgKi8KPiArwqDCoMKgwqDCoMKgwqBwZmQg
PSBicGZfbGlua19jcmVhdGUocHJvZ19mZCwgMCwKPiBicGZfcHJvZ3JhbV9fZXhwZWN0ZWRfYXR0
YWNoX3R5cGUocHJvZyksIE5VTEwpOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAocGZkIDwgMCkgewo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGZkID0gLWVycm5vOwo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZnJlZShsaW5rKTsKCg==
