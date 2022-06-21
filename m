Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155FB55293A
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 04:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245663AbiFUCFz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 22:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243751AbiFUCFw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 22:05:52 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-bgr052101064021.outbound.protection.outlook.com [52.101.64.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF6F1EC77
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 19:05:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcMiVN8cZgIsTWUGEr6raDKMYQYYKKoBpygr0ZdbMF9NKBQkIys4s10tgF8vJggRc0swU7AYzkN5iVO/3GQeEvTGkEjhw1jbjmwXTvlVxguABMe5mkCAl0edRd6vp4LH5soD7x7w0EKj8B1Kn2zsRTljctjAQERAhiK7340a4WVEXYVi7tjUO3jwzvrSPDU3mpBzUiN8IFR904hChFtxe/hFAreEDTCtf6wkbO1wifiX+OyQEsudaHgdZHXJ7NdZ33YsqteMvkh2N0NrbBMyp3kkJ07jIBU9A63d9Xgzq14/cQjJW0kVsNkVb36lrofj/nh7e2BdBgr1hycPdIfEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvkzDhC1adO7+1vegMs9n628dpundeHp1jmZXJjBRpc=;
 b=luxl2ZSh0BoyMNx3DulshKd9E9TQJf9JDgO9m2N54LYYbkb4j256YJRC5/pktPWe+5BJ5iwPRFWZWCQsKQx0uxoDo45Wqr3WICqaozU9IO0WIdScDMeuAmiu+CncbGqS7uWfWHpRVfhqDZeTLH2r1Wpiyqsc/ARf/FAWCGGYUfFGgXuX1JhWQk0hoDQv4/eNbm6x1fC7eZq/Efsbp0FAuqKp+aKqgtpDXUyRHAHoc13HJj4kjMUUZ01YzTsB66/LkQVAHluFeDA/1rGC+1+Trzdf1KMAmvcQj4dghSq3JPcwvKFR2zQPcrp46m8DiKbXPaBmQARSt6Hr8VO0a3Dljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvkzDhC1adO7+1vegMs9n628dpundeHp1jmZXJjBRpc=;
 b=UsvH24a/eYkAGdey3fAUi6GdulR3YY9Rz3yx8g52rFiwnjNSkSocIhGcdKYqLXQyRpE580PTE+UOblCsR3V/mWs1SZi8vmlFIpWFWphNkUgn90qb3vyKQDkfndzDXTJRkZnVGWsyhvI8RrCV9u1CdKnwqRZIdQOsOst1vfdnKuw=
Received: from CH2PR21MB1464.namprd21.prod.outlook.com (2603:10b6:610:89::16)
 by PH7PR21MB3287.namprd21.prod.outlook.com (2603:10b6:510:1db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.6; Tue, 21 Jun
 2022 02:05:48 +0000
Received: from CH2PR21MB1464.namprd21.prod.outlook.com
 ([fe80::5c95:b7b5:e99a:a026]) by CH2PR21MB1464.namprd21.prod.outlook.com
 ([fe80::5c95:b7b5:e99a:a026%9]) with mapi id 15.20.5395.003; Tue, 21 Jun 2022
 02:05:47 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Martin KaFai Lau <kafai@fb.com>,
        Matteo Croce <mcroce@linux.microsoft.com>
CC:     Andrey Ignatov <rdna@fb.com>, bpf <bpf@vger.kernel.org>
Subject: RE: scope id field in bpf_sock_addr
Thread-Topic: scope id field in bpf_sock_addr
Thread-Index: AQHYhMB4hBiLpvwe10aKofagEBr7Xa1ZELwAgAALfmA=
Date:   Tue, 21 Jun 2022 02:05:47 +0000
Message-ID: <CH2PR21MB14646DEA0B940D68DF13DFADA3B39@CH2PR21MB1464.namprd21.prod.outlook.com>
References: <CAFnufp2KL-qNyDtWH5cNQ4DARqSQAygSi9GXgHD-iWs0XzJMcw@mail.gmail.com>
 <20220621012040.7tdjpw5jno3mv5l2@kafai-mbp>
In-Reply-To: <20220621012040.7tdjpw5jno3mv5l2@kafai-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=235df51b-5650-4965-914e-64ec964dafc7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-21T02:01:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ed0f25f-36da-4392-b671-08da532a8eff
x-ms-traffictypediagnostic: PH7PR21MB3287:EE_
x-microsoft-antispam-prvs: <PH7PR21MB3287C256034553F309F8B423A3B39@PH7PR21MB3287.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D90EkMez6XzmRGzDxL7x+BuR7TToP3hu5++/YxFQ1pd2+jNvLxPd49l2NYay6gHr0vtlqUkWITMDOl2R5t10uHK9tx93RGVSmZ5hLG9JVWiix9ESpXFqvO+pdSU9QjsyyI9CRmpur8Wp6n1N7jfvV2WD0bwfShPXZVYo3H8J882EjhiCvWpzfGNh4Lb7jUwjhwJTmBaUQKbO1dvMVZU25+wC75EiYqtdwadVP1L0WckTjmRgtLFiHDQjMywq03fI4xmn2H2NDrYGORU5NZEWvqIYuLGRdvKQ07Z3vUfudBC1YA/CdSBcKN1UjMzev6dGqaQqF8+tjX6uaG7I9/80qZ0sFHVy8ZPfcGfTRZ8khvceZwK/tTp1sidLlUxcaacLrHElVNm2nYl0oRF+NYWfDyzRGk9uHgNR/EgXBLylG8VQRpaLQtzpPukLX868EUMcKFIwDhmSmCciWqz6aSAvY6uPfE3js0b8Je87pFABAO9wybrO6FaWoWzR8Hltnnm/b+BnUtVc4+j5U6vT/mfRDRbJ+bBi831+7pk9glWlJ5L+GDFSrYYVf7yFItdHKQjTs2Y5ZcK28KM05ixpSbLz6sJqdnVwjo9anLljNKh9Md/w9tPk1slvggJrNpGK6wd1l1mWe2JCXXrrPGlbQOP644FOu7omVC7OWTh+vlj5/BXenIfWEpGc21aOaMSDO0m9AHhsenTiWjyP/Qpme88S/F24ULFzjrcIQFh34KPUMJwqux8CeLXu1PbNfBoe534w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR21MB1464.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199009)(64756008)(4744005)(66946007)(66476007)(10290500003)(6506007)(82960400001)(110136005)(76116006)(4326008)(26005)(71200400001)(86362001)(7696005)(83380400001)(38100700002)(41300700001)(5660300002)(66446008)(38070700005)(66556008)(122000001)(8990500004)(2906002)(54906003)(478600001)(55016003)(82950400001)(9686003)(33656002)(8936002)(8676002)(52536014)(316002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZlIPfp8rIch1TUhXRttyVMOZ4brbnbZF/QQNBKDg5eK7/b04KlXTj5Vux5DB?=
 =?us-ascii?Q?CldKPFggvB1YZaCewHrZbOH9+o6Tj6O/T1WfujZTx8F0xcJ4DQ0lHLXYdOie?=
 =?us-ascii?Q?BxDoXqu41pEOQA/gIeGhMag16QZbHMBxeAXlbMh2H+2MF6SwS54C26JYTz9n?=
 =?us-ascii?Q?7PNBCXi0UwsnsnxLfy9WLSkrGebklJztnT0xsMA179Jx4sZKOHXQ6uRtvU9V?=
 =?us-ascii?Q?cjwhQncakwkQhOrHwID2AksCNYdax6R1Ddbe/6Ge5E3A3GCw1Ag7mBYSaci4?=
 =?us-ascii?Q?Q8xop89k44u1EhLu/D0Ropr7c8mjMPGNwFf7jx6MJGpHAzf2nlwTuCQS0QjA?=
 =?us-ascii?Q?QODa1cnTG/Y5OI5glx8zbJLWZrM4904ROk1fNiCykcYTYtral3XIDfmdOaGM?=
 =?us-ascii?Q?4IOyvCub58yFYP1jSaK5M9ib7io4qrNQr5jxmQWEYEeGnSpzai7D0JXnvO3e?=
 =?us-ascii?Q?JIpxKSPgAHmMqKTDWzYKyk4SFPaZPg7MFeugvbQ72lwQk4+leFB09ECvFV4W?=
 =?us-ascii?Q?szdIK54vbdAjFxstUYmv5Wznznu1ml8EZfvJNmdzJxdVjUv7rHB9fMXAmoNW?=
 =?us-ascii?Q?kiO/6O1qJtoGRCombjJKQig7hSwTiGWLYxpEeN95TJzqc/gK1E9vY6rlNyJo?=
 =?us-ascii?Q?fyDH6XJHIoN72wBp68qGd9X1wC+U+LMAr87bgduDakAq3She1ISex8UvDsvy?=
 =?us-ascii?Q?zILLpueARKqWfbwqMnoFgBZXJ8bG4inmFnHp8rJpSq0sPcs11kq6C+cv/J6Q?=
 =?us-ascii?Q?OCPSsSZ5MIUg3POXoC7tmOw6PUn5dybrkjcvvyND6g56MqvtB7KUSTlk1MsB?=
 =?us-ascii?Q?gJpV+yULDjZ/IDSIWVX4ckN6qiu66b1PjQKCHi6XTI3n9F5NDYwRfLWhxIts?=
 =?us-ascii?Q?R+nSpYy8DLBMIJRpAnu42t45HmYii6d5JF9qlGQ+mHBaDQItWgf9Po4cRl3w?=
 =?us-ascii?Q?DOWseCvUwIRVyyiQfjM6hWZl1J0dCZnpY7234eKtEMhpqTFzA0/xyXrUcbzo?=
 =?us-ascii?Q?t2ZO+gkrZhiDu1juoDqKAusedpYC/DBI4imyFVIOF4STWRhZOdHnFp0tUEgt?=
 =?us-ascii?Q?uLmqUFbuXZoaAVnyw6J+BYXMvGSsi8FsM1JDYjHqijqFsSQ4u/mdyibT5yHh?=
 =?us-ascii?Q?IgxJYB7N6Cc/dI2kLQnM8s5FwUnXDsNmwCgMlUmle9uAHwYSVdt/gahLxsr1?=
 =?us-ascii?Q?1SEImNeQMvdGttzkXuoUw6PTUWKmDGGc/RDrgXNFpZgc9Gn5dpDjjBenYY3D?=
 =?us-ascii?Q?LdRwDqFzbv7Vo5tLnrGplwiL5+090BoKnX4sX/Qd+/3PG9QRGHJ45tCnYBLz?=
 =?us-ascii?Q?MQU2EjA2ZdrAr418vpTdKZV+lIlTQV5PL3JqA1KEPHST+H0fA00ZWb+Ng5uW?=
 =?us-ascii?Q?zyS1pl0O1yH20TgvCRZSmq0xKfFtCwBEG0uwj6s7GzC2SVAL7CRRuwRz9eQB?=
 =?us-ascii?Q?bgXtlyAQdrsT1JAYUmrD2LmZD0c93gmTfr2DWp5n0X5wwRnFQj/hwaqDI1eW?=
 =?us-ascii?Q?2ytFFeIl3y3+KG5TZXQKbAlywMqhht52iOVCPSMA2s6KZmVK+mXgLdH8Ckdc?=
 =?us-ascii?Q?EgvyIQRcpC2HMKS87Q7JCtVGRz2PNzVts51xxgTVJ+QajrD5kfxDnQvGA9ye?=
 =?us-ascii?Q?yfukGZhPj4RE5JTCvyN/Olai3IXpix4bqPAL8RBxZ9ljNVQbkT8Te2gka/n5?=
 =?us-ascii?Q?KfSokoACZN4Vr7knAy2jIQ3/8sg9WhzZPcgl6clnQGGB9Sy3xd+OGOkMLZpO?=
 =?us-ascii?Q?E3cC4nU9r3WQpr2fazofdMXB1VdFgDs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR21MB1464.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed0f25f-36da-4392-b671-08da532a8eff
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 02:05:47.8732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YSFZKxzpEo94hLGrgu+MYWSUPuGlRDt7dtesNZnKky1sEDVDn0/WJ1oS+xyWOVywa8uDgyrgwSrpcUx0FgszR9WTEJlHQu257C2eWXASmCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3287
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau <kafai@fb.com> writes:=20
>> I wonder why struct bpf_sock_addr doesn't contain the sin6_scope_id as=20
>> in struct sockaddr_in6.
>> A program with type like BPF_PROG_TYPE_CGROUP_SOCK_ADDR might want to=20
>> access that field.
>
>
> I think usually there was no use case?
> Do you need to read from it or write to it?
> You can try to extend it.  Take a look at sock_addr_is_valid_access() and=
 sock_addr_convert_ctx_access().

For me: read it.  If you're trying to, say, track the set of all connection=
s, you can't do it simply from
the IP+port pairs, since IPv6 scoped addresses are ambiguous so you can hav=
e 2 or more connections
with the same IP+port pair, so I need either the scope id, or an interface =
(device) identifier, to disambiguate
and know which connection is which.

If Linux has an API to get to it, we'd ty to do the same in the ebpf-for-wi=
ndows project as well,
but right now I don't know the answer.

Dave

