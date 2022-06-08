Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E736543293
	for <lists+bpf@lfdr.de>; Wed,  8 Jun 2022 16:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241247AbiFHO3h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jun 2022 10:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241117AbiFHO3f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jun 2022 10:29:35 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557DE38C751
        for <bpf@vger.kernel.org>; Wed,  8 Jun 2022 07:29:34 -0700 (PDT)
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D4223C00B4
        for <bpf@vger.kernel.org>; Wed,  8 Jun 2022 14:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1654698573; bh=6JvkDIPUotM6x8XBcaH41jHFBD7d0jqxgh5GkfiSBMs=;
        h=From:To:CC:Subject:Date:From;
        b=OGH0Xd7hcaAZ2PvQVgd0HW2LtBS02DMSK1k5qZDi9p1gV6uoGbPAq0KsrIAuRxK50
         9BGPJjGejcmiLjjbPmVSFQ1Bz/aMLtkVjHvboUst4H76qwkG+xTH3HNhqSZ4kqMHkA
         i69lDJj6FFxJ5vcO5IB5kKN/+J7gKmpq/zRebs46rkjzRMLeAdUVHNZWIEW2zAAkpu
         nFtpo1Ihl15u1nP+7enufuo7lLvrRLlVf/UsKj33G+D8LfA8v13MDqfavaiaOh2mo6
         NvV7yVPuntemCy6YipzmIq5Qd+IkUU6rxTsNu3RGxiWhilp0V59fHojnrTDKmVlQCc
         DLuWygiU51lnA==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 48373A0071
        for <bpf@vger.kernel.org>; Wed,  8 Jun 2022 14:29:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id AAF2540086
        for <bpf@vger.kernel.org>; Wed,  8 Jun 2022 14:29:32 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=shahab@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="KFTJ5kj6";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gf17bofdcnIkg8DfcKOKYGRrjal2vrVSj1fAdtus7hczNus0T+ecrUVs49pUz5S9AKgWJ9uAWtU0d+PZWoOTZqE6THn92MEr5fDjk+6aVy1NNYrbHeSPDzpWWhFM5CLjYme2jyOjG70hXDFncRosjnQdK87fpFAJzWWzLkPgNwwLSuLJ1dtsPU9xHFLVmW3NDPqtPzcQS/7DiuC5EhneP8FhLmeeN8RKx23RCf1TqHepkTo78EYjspWdT5tVI0Dy8Fhj8JxaNxmPzAbHt8AzrU8nDOufFKq/aHvGtqxwnvGdFxxKAEfOkm2pqv/nRXV/48gTZAVgabYq2ZyCNIPSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JvkDIPUotM6x8XBcaH41jHFBD7d0jqxgh5GkfiSBMs=;
 b=Sw8RLsl2jufD2sUecOQB8W7OHcZ3p2qIrqflVchYzpyEg5o+WqAteMWBqoOiVQbjO1Wip43kAZQWlQtNySvp1yJk0WWY+vSvDRQZUx8ejRmm6pp3N/QMboRvRn/SwwE5Z/PoWdreF3q2mN6D0p9tqUbc64gN6ckqiNBTiBcH+TvP8Uinpf+UKLFXv1ZMMNvtkoqcdJFA2GwerYQeyUb4WOd4w+w3hyrXiInCJqfAhAFBFJab6v3Sw++bcjE9PWbOUMrRpkrShr68FOnMH5rFP1T8lunqeFWGCg+Ktl4tGj9otsyytTVJzRPm1i2EDbtssp06m310zMO9LdiyKo9FHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JvkDIPUotM6x8XBcaH41jHFBD7d0jqxgh5GkfiSBMs=;
 b=KFTJ5kj6pbGXCLGSAD7g9uF8jPB6cZTkFvvFvVJ4zxAdtqcxsJrCCkbWWJ306H22vyAQj6K63+0m18atFTXw6DUtrrpDbaAbzsJeyQb6pJPGoqUIJ2Q3KGqlOW54tO8bMt3CF2qN4WMZ0bUmN7gjefdHkPkGLyVjgRFAcH/8hqs=
Received: from SN6PR12MB2782.namprd12.prod.outlook.com (2603:10b6:805:73::19)
 by SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Wed, 8 Jun
 2022 14:29:30 +0000
Received: from SN6PR12MB2782.namprd12.prod.outlook.com
 ([fe80::1175:61f1:71e9:2038]) by SN6PR12MB2782.namprd12.prod.outlook.com
 ([fe80::1175:61f1:71e9:2038%6]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 14:29:29 +0000
X-SNPS-Relay: synopsys.com
From:   Shahab Vahedi <Shahab.Vahedi@synopsys.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Shahab Vahedi <Shahab.Vahedi@synopsys.com>
Subject: [PATCH] bpftool: Fix bootstrapping during a cross compilation
Thread-Topic: [PATCH] bpftool: Fix bootstrapping during a cross compilation
Thread-Index: AQHYe0Qp1eGJCiibuEuC+dJXsd+L2w==
Date:   Wed, 8 Jun 2022 14:29:28 +0000
Message-ID: <8d297f0c-cfd0-ef6f-3970-6dddb3d9a87a@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e36a918d-1e11-4b37-f5a9-08da495b4ba0
x-ms-traffictypediagnostic: SN1PR12MB2575:EE_
x-microsoft-antispam-prvs: <SN1PR12MB2575201768E5544719791F1DA6A49@SN1PR12MB2575.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pMeCuuLnWq5/nhT/nQfvQ2ttBC2Fys6DzkxuYHHV/iN98JXvr6ZxxiYKpGCxcAOntwvV/FbQrEtDM2jgtW0v6Kml5jJrFrwR1LyPncoKxoJGtwOKCtW0uhT+ndiSLMQle/XTC90v9fzS8o8hpOjILW9lcuGIbr6zKf0URqRj1e/wX0FnQghY5IBNbpDNetpT6CsOSCUgqecmYnNHgJ641vhMdvE3eJ+Pf50SU2kF+NzB1TbozC64/DL8Jqbd7DKBWtOeaiBGW60pSmM/6LtRw7pRyrHUZClC2DPjy3xMy0QHKMUgLy2xzvVe36R4FiLk3I6w5+/wrTKv7+AKThSDkoirOfuC3h+IU37oJ0ijRbI460Wvmv/v0Oas4UaekSjMRYRIY0O74QM6B6V2EYOam0JEwfszf8PZtlU/NdjQgU0zp0os5c5C/sSprYqa9ePw9TBUnqOkYb91ThwoJuB2MZRMg2s1UA/ngdTe5IGkxY+ZOr0STfI065REsShg7p3POflOnF+D3zomEi2SBLZRtD23WYNRrws97pOMD9ykW1rgZt3WgaBk91L4YvkUzcnxXOBsizXn/iQTL6tyg7K6iHrnc7miQ0gAqD1uUgjXc9bssL9xwAkbBPnWLgIV8CXfMBDqwQ22MNS1IUIcmssg6tNdCImxdAw0shDJBU/+HdMlNyr9O+zvMr4ZRxBSKCBkgAHlYuVppvvsqEeuO1JkxBtZJnTon90t3d15UWBssm8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2782.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(6486002)(186003)(107886003)(6506007)(122000001)(38070700005)(36756003)(31696002)(86362001)(38100700002)(6512007)(2906002)(316002)(6916009)(76116006)(66946007)(66446008)(66476007)(64756008)(2616005)(66556008)(8676002)(91956017)(5660300002)(31686004)(508600001)(83380400001)(8936002)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWt2VGF4S3ZDaDlGYUgwbExpbDdvTStYOUwzbEY0MGs5amN1ZkZ2QWpIZUpp?=
 =?utf-8?B?R0JtVGduczZKRUp6THBFbjBxaUxmNGtZVnZoYWp5L0VQaWhYa2lQVFVQK2Yx?=
 =?utf-8?B?WjgxZFB0WDZOU1VVTlk3bkVvYmp6SHdDTGcwSnNZTU16Qm02emQ2Q09xSlhu?=
 =?utf-8?B?bTdqZmhRM25oa1dKSmZvWTJMUWo1WTUyM0pBSjV2bjByYXU4K0lCR1E4eHc1?=
 =?utf-8?B?MmpiWFBodUJmMm5xd3poNW9yQ2dNbnlnWWlZUVhrSXBUTkhMV1hFcmNCL1Jl?=
 =?utf-8?B?TW91WUp1cHZtWVk0VnhYQWFWc0FBVlZNWW9tOXIxYnRkRnFpaFBndHMvLzJW?=
 =?utf-8?B?UzlOa3pnK09ZMk82TnZqOFRSUU5WZmI3eXlKUkdMV0NNLytFUmpvRWlKVzlu?=
 =?utf-8?B?bHkwRXpsZ015WUlVODZuWiswbFhyUmpacEdQQm5NUm1aKzZVMFE2Y2JXQlVT?=
 =?utf-8?B?S1c2bzZNdmVKUTdGMUJvcE9NbGJRZU9OWUZzb2Q3dlZjQWJKQWthbjJlVGhv?=
 =?utf-8?B?RCtJWGJHRGUxM1FTNjBzVXBvL3lKRjR6SzNiZHZIaVlWdTJtNzhTK21BNE1O?=
 =?utf-8?B?aHMyTjdSSG1BNTNUTWlkL0hOMXowK3grUlBlUEhoNTZtRi9lRjZPZm1TVWI0?=
 =?utf-8?B?aWJ4Y25aUStKdmpiaEV3MTZPTEdIeFkvTEM3dGRvSXpOK0hqL0lDMy9yLy92?=
 =?utf-8?B?cGRTR3VmbWFuVzh4WE9OZzhHQk83S0xZYm9FN0ZMVGRmNWVMSFB2L2lzTGk0?=
 =?utf-8?B?QnlsMUlSYUxqd3Z6eW9kQTB3NEpIVGtTdWJrQ0M5ckk5VzgxTW5KSGEyaUR2?=
 =?utf-8?B?VE9SZVVOR3RCVUNqeDVpOCtLYkk5YTBuU2J3Vzgxd0VXeURxMmlzcmJTMWFu?=
 =?utf-8?B?Mk1UV3F5S2hGd0plNlM2Y3lCTnAxRDU3SW10UlpoeFJGUlJSZjdPdTBzVnE3?=
 =?utf-8?B?TkZpTXBkTkY0alNGMVEzeTd4aDllZ1NRTDhrMFRHM1lFYzF2M00vLyt3M21N?=
 =?utf-8?B?U1RTYTBBd0VZckZRUy9PTU1QTXQ1Z1QyY0VkMWNIelIxbXptUFVSQ2ZPaGgz?=
 =?utf-8?B?d0QzaTlRUmNkNE5LQ1p5enZkckJtQ3kxREpXajgvQzZadHo1ODlmNHlEOGF3?=
 =?utf-8?B?cmtpZkhHdjZBczVvaDY5QXhFd0lUMENSeld1cm1qQ255RXFaUFN4U2ZjdFRS?=
 =?utf-8?B?TStrQWh0cWNnM055bDVWMmNtNlhidWFtWmJoam5jTkloUU9WSXRENU5oMC9a?=
 =?utf-8?B?dmxua3phcEd2NWNJMXk5UjFtNHRyNGlTckozOFpEVHk0ekFZMjBSWFpqTi9m?=
 =?utf-8?B?M3RqVXlQSlVxK2UyY2ZlaEhUUXVhYnFsUHl4ZGNHNXpxd0dEUm1aOVJSak9J?=
 =?utf-8?B?Z2tWamFTWHRaY0VvdzNCazN5UWJ0NW1GcDFkMVlQdWpVdWlIVm5aMEQrUHlJ?=
 =?utf-8?B?TzRhd3NtZUY4T1lBc2I2MTNGTTBUWnRydFp2VXhxWmROTHQ3NCs3ZjQyOU4z?=
 =?utf-8?B?UW9wTWViYVdHNEE0ZjdJTjBVd2pWbVJ1WW9vTVVoNmNGdHBlM0FZTWxVMTBL?=
 =?utf-8?B?czUrN1p5NDFaNUdlVVkyK3ZKQ3piazdRQUk2Zjg3UHVFT2YyaW91VG9NQXVH?=
 =?utf-8?B?M0hJMGM1MWVQcVpJZzhqSHlNNjNiNnFxckhjdmd5YUx6eGY0YjdnR0ZId3Jo?=
 =?utf-8?B?eDc0N21LcWpWaFhLcVdhYjNid0IvTExIN2Z3RzhFVnhYcHBwWlAwMVdaWjli?=
 =?utf-8?B?NUFZSDBEZEE2di9tcUtVUnJIendpSTdWVTUwdHJ3OVM4RnN3cmxZaWowSzk5?=
 =?utf-8?B?em9GK1F5NEgwNitWOU4vR0FoYjgyaVd6Y1lnNm9xQXlwcXBjTWtDNEhqalVm?=
 =?utf-8?B?MzJMMEYwTml4YzhxampETWVzczBCU0JkL1VhMWpuOG1pQ3Y1Tmsxdml1VDZ4?=
 =?utf-8?B?V21tUkNNc1JPOWJWSThybDBsZFFvc0U0bmdlMWRiVjV2NWtIemo5S0V2bkl6?=
 =?utf-8?B?T1kyYnYzRGlkU1doMExEamZFamNGQWk0Mko4dlBBZUdVbU81ckQwK0NKSzJZ?=
 =?utf-8?B?c2ZTUU5LMkdtUzM1VFZ6QWpIN1o0Ni96OTdIQ2REUzdJOHVNTUFEUmpCVWxH?=
 =?utf-8?B?TnZ0Z0t3Z0EzMm4zMWVXaDZlNitLTHBJeS94MVFMNzh0a1p2TS94L2F6Z2hC?=
 =?utf-8?B?bEZPZi9yMzBmU29WTUdRUmg2OFgvTDR2T09BODlXUDI4dFFnSW02d3VaS3o3?=
 =?utf-8?B?aVcrbHVnemRKNXJVYTd5WVEyQ3I1cVluaTUxdzZZd25YRUFWdW1xWHN3UXp4?=
 =?utf-8?B?L0JSQjMrOWdFTjRDN09lKzgxdktDRzBKaFJYR0hwZjFYRVdPUWp1YklaVkxG?=
 =?utf-8?Q?MtN+eeKMHMaYPEx4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5C2191A8A50DF47A763544ECC11FA31@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2782.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36a918d-1e11-4b37-f5a9-08da495b4ba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 14:29:28.5725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZnMDfKaOIFdvnDv7svxogsQkB4sYH8JD6icKQ7pOMIQfQBxtN997qRSWc69rZKuTVR/pnzZUbMtNgT+hxoHk9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2575
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

VGhpcyBjaGFuZ2UgYWRqdXN0cyB0aGUgTWFrZWZpbGUgdG8gdXNlICJIT1NUQVIiIGFzIHRoZSBh
cmNoaXZlIHRvb2wNCnRvIGtlZXAgdGhlIHNhbml0eSBvZiB0aGUgYnVpbGQgcHJvY2VzcyBmb3Ig
dGhlIGJvb3RzdHJhcCBwYXJ0IGluDQpjaGVjay4gRm9yIHRoZSByYXRpb25hbGUsIHBsZWFzZSBj
b250aW51ZSByZWFkaW5nLg0KDQpXaGVuIGNyb3NzIGNvbXBpbGluZyBicGZ0b29sIHdpdGggYnVp
bGRyb290LCBpdCBsZWFkcyB0byBhbiBpbnZvY2F0aW9uDQpsaWtlOg0KDQokIEFSPSIvcGF0aC90
by9idWlsZHJvb3QvaG9zdC9iaW4vYXJjLWxpbnV4LWdjYy1hciIgXA0KICBDQz0iL3BhdGgvdG8v
YnVpbGRyb290L2hvc3QvYmluL2FyYy1saW51eC1nY2MiICAgIFwNCiAgLi4uDQogIG1ha2UNCg0K
V2hpY2ggaW4gcmV0dXJuIGZhaWxzIHdoaWxlIGJ1aWxkaW5nIHRoZSBib290c3RyYXAgc2VjdGlv
bjoNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTg8LS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQogIG1ha2U6IEVudGVyaW5nIGRpcmVjdG9yeSAnL3NyYy9i
cGZ0b29sLXY2LjcuMC9zcmMnDQogIC4uLiAgICAgICAgICAgICAgICAgICAgICAgIGxpYmJmZDog
WyBvbiAgXQ0KICAuLi4gICAgICAgIGRpc2Fzc2VtYmxlci1mb3VyLWFyZ3M6IFsgb24gIF0NCiAg
Li4uICAgICAgICAgICAgICAgICAgICAgICAgICB6bGliOiBbIG9uICBdDQogIC4uLiAgICAgICAg
ICAgICAgICAgICAgICAgIGxpYmNhcDogWyBPRkYgXQ0KICAuLi4gICAgICAgICAgICAgICBjbGFu
Zy1icGYtY28tcmU6IFsgb24gIF0gPC0tIHRyaWdnZXJzIGJvb3RzdHJhcA0KDQogIC4NCiAgLg0K
ICAuDQoNCiAgICBMSU5LICAgICAvc3JjL2JwZnRvb2wtdjYuNy4wL3NyYy9ib290c3RyYXAvYnBm
dG9vbA0KICAvdXNyL2Jpbi9sZDogL3NyYy9icGZ0b29sLXY2LjcuMC9zcmMvYm9vdHN0cmFwL2xp
YmJwZi9saWJicGYuYToNCiAgICAgICAgICAgICAgIGVycm9yIGFkZGluZyBzeW1ib2xzOiBhcmNo
aXZlIGhhcyBubyBpbmRleDsgcnVuIHJhbmxpYg0KICAgICAgICAgICAgICAgdG8gYWRkIG9uZQ0K
ICBjb2xsZWN0MjogZXJyb3I6IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0dXMNCiAgbWFrZTogKioq
IFtNYWtlZmlsZToyMTE6IC9zcmMvYnBmdG9vbC12Ni43LjAvc3JjL2Jvb3RzdHJhcC9icGZ0b29s
XQ0KICAgICAgICAgICAgRXJyb3IgMQ0KICBtYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hl
ZCBqb2JzLi4uLg0KICAgIEFSICAgICAgIC9zcmMvYnBmdG9vbC12Ni43LjAvc3JjL2xpYmJwZi9s
aWJicGYuYQ0KICAgIG1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5ICcvc3JjL2JwZnRvb2wtdjYu
Ny4wL2xpYmJwZi9zcmMnDQogICAgbWFrZTogTGVhdmluZyBkaXJlY3RvcnkgJy9zcmMvYnBmdG9v
bC12Ni43LjAvc3JjJw0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPjgtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNClRoaXMgb2NjdXJzIGJlY2F1c2Ugc2V0
dGluZyAiQVIiIGNvbmZ1c2VzIHRoZSBidWlsZCBwcm9jZXNzIGZvciB0aGUNCmJvb3RzdHJhcCBz
ZWN0aW9uIGFuZCBpdCBjYWxscyAiYXJjLWxpbnV4LWdjYy1hciIgdG8gY3JlYXRlIGFuZCBpbmRl
eA0KImxpYmJwZi5hIiBpbnN0ZWFkIG9mIHRoZSBob3N0ICJhciIuDQoNClNpZ25lZC1vZmYtYnk6
IFNoYWhhYiBWYWhlZGkgPHNoYWhhYkBzeW5vcHN5cy5jb20+DQotLS0NCiB0b29scy9icGYvYnBm
dG9vbC9NYWtlZmlsZSB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL3Rvb2xzL2JwZi9icGZ0b29sL01ha2VmaWxlIGIv
dG9vbHMvYnBmL2JwZnRvb2wvTWFrZWZpbGUNCmluZGV4IGM2ZDJjNzdkMDI1Mi4uYzE5ZTBlNGM0
MWJkIDEwMDY0NA0KLS0tIGEvdG9vbHMvYnBmL2JwZnRvb2wvTWFrZWZpbGUNCisrKyBiL3Rvb2xz
L2JwZi9icGZ0b29sL01ha2VmaWxlDQpAQCAtNTMsNyArNTMsNyBAQCAkKExJQkJQRl9JTlRFUk5B
TF9IRFJTKTogJChMSUJCUEZfSERSU19ESVIpLyUuaDogJChCUEZfRElSKS8lLmggfCAkKExJQkJQ
Rl9IRFJTXw0KICQoTElCQlBGX0JPT1RTVFJBUCk6ICQod2lsZGNhcmQgJChCUEZfRElSKS8qLltj
aF0gJChCUEZfRElSKS9NYWtlZmlsZSkgfCAkKExJQkJQRl9CT09UU1RSQVBfT1VUUFVUKQ0KIAkk
KFEpJChNQUtFKSAtQyAkKEJQRl9ESVIpIE9VVFBVVD0kKExJQkJQRl9CT09UU1RSQVBfT1VUUFVU
KSBcDQogCQlERVNURElSPSQoTElCQlBGX0JPT1RTVFJBUF9ERVNURElSOi89KSBwcmVmaXg9IFwN
Ci0JCUFSQ0g9IENST1NTX0NPTVBJTEU9IENDPSQoSE9TVENDKSBMRD0kKEhPU1RMRCkgJEAgaW5z
dGFsbF9oZWFkZXJzDQorCQlBUkNIPSBDUk9TU19DT01QSUxFPSBDQz0kKEhPU1RDQykgTEQ9JChI
T1NUTEQpIEFSPSQoSE9TVEFSKSAkQCBpbnN0YWxsX2hlYWRlcnMNCiANCiAkKExJQkJQRl9CT09U
U1RSQVBfSU5URVJOQUxfSERSUyk6ICQoTElCQlBGX0JPT1RTVFJBUF9IRFJTX0RJUikvJS5oOiAk
KEJQRl9ESVIpLyUuaCB8ICQoTElCQlBGX0JPT1RTVFJBUF9IRFJTX0RJUikNCiAJJChjYWxsIFFV
SUVUX0lOU1RBTEwsICRAKQ0KLS0gDQoyLjMwLjINCg0K
