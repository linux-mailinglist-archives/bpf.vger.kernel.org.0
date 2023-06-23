Return-Path: <bpf+bounces-3284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AE373BBF9
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 17:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10D31C21268
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 15:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374E7D308;
	Fri, 23 Jun 2023 15:49:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AFCC2FD
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 15:49:01 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020021.outbound.protection.outlook.com [52.101.56.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD672116
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 08:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWpNLAD6AuaD0RNHkpSo1DH5JXOFVVJVYI589fAu/hIMOWguM/rkF6tb4og8Gdl4w1dz4dRrV4kdvBlFjJI3jdYrj6OMCCiXRkqvs58m4xC01vMkxaJ3B77/wEjQWIKiJiByZXpyzKyKDlK091jVc9V7/tAd9l6dxLagzVfsIOlSK64b4xmqHMK8xaRn+i+eItSulP5DtKgBr/RrpwFJhlg/Q3iyRvZiAtPX1In+/3RmTkT7j+Zo0cHOE6ZnmyxCqmWvfcepKlu/+bJhiuihzoX5FnFpwbMGvaYPgmkXtaV73wn9dEbFGzzVwZMC0qgww+UQ0oqgvOz1shgeC61LlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7p4btwTQuKSj0ppxYYBWa1YkWTs4cSjmdou8B/O4kw=;
 b=EGNhub55jrrjGPJHqB8IC+5kzdshTMt7KDBBRSrT1NltiXpiheR8OJQECQvTgJd8yVuwzz9sK4dbAIPcNFHE13LlD8zGlifylGyohpYqpsfw1ItIg/KxNOHvCbb77sJpehbPcMeinFOKUQTopvZuw1WHijliJXp3muq+P722xP/7s5xrgdcczraPwHmC9DM5TDzMPr7TGmGQgyWymZR5Oi7ijqdUO4GnLg0ZySMCwAQdtCRlL09igEbJPjU66apXGepCVCmXmOTgs9ccpNMymJropbpQDHTDNglfU+9A1HTEtT25XXvf7dyCAH73y3PMDL+JM3/7MpgcXr4YnwKtDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7p4btwTQuKSj0ppxYYBWa1YkWTs4cSjmdou8B/O4kw=;
 b=KZPc4G7EMOpOI/RyTwJrbbS8rEN/b4PC/cG/3u5ug+7gw5TUoDOqlR9+ABj0A66pxn8RQ7SDIuQ+J7loTMt3YtIpRz6fIRcNDVa2stRMAYghlfUaQvXSUGTByaq5XmFcUeaTjRL9vJaje/TZCFnc6csX/9WfYkMAQvNi7BJuQtM=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by SJ0PR21MB1323.namprd21.prod.outlook.com (2603:10b6:a03:3e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.11; Fri, 23 Jun
 2023 15:48:57 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::8708:6828:fb9f:7bd5]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::8708:6828:fb9f:7bd5%4]) with mapi id 15.20.6544.010; Fri, 23 Jun 2023
 15:48:57 +0000
From: Dave Thaler <dthaler@microsoft.com>
To: bpf <bpf@vger.kernel.org>
Subject: FW: [Bpf] WG Action: Formed BPF/eBPF (bpf)
Thread-Topic: [Bpf] WG Action: Formed BPF/eBPF (bpf)
Thread-Index: AQHZpeV9H6I8AI8+YUeXkmyy8P7Qz6+YiAxQ
Date: Fri, 23 Jun 2023 15:48:57 +0000
Message-ID:
 <PH7PR21MB38787877390DCE2602178B1AA323A@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <168753322448.55527.5678484455846608353@ietfa.amsl.com>
In-Reply-To: <168753322448.55527.5678484455846608353@ietfa.amsl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d30eb757-4ec2-4ad5-bb89-c3a0624eae59;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-23T15:46:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|SJ0PR21MB1323:EE_
x-ms-office365-filtering-correlation-id: 5d86e7b4-f288-4b81-c5ab-08db74015aed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TJNmnVF94H8UQ2NOgl2uKlanyqZzUgvLIbaIE3NPXjmJPJh9Ib8IAwKIGoT6rR/UgIyPrrkzz64WGdt3QlokO85uznhiV3miGYHRcVmMEoXXkFwjIKIr/F6cF1tAjFv5Bb8wegc1AIEFpsttQGPT5iz49ia0j2Hl0JC6Dw7ukMJPj6d2ZIC6Mve1xEo0lLkvsDBrdPCzx1pINuVLpKutl+xILwrkocyzGZl188Xwfbst075xBpFKeqnpO7slFSDqbyZDyQIeX+5bUVwthPA2sqA2n2R1c6GpOBfRFX8WWbpaV6x5ZtEw/Bz1xeaLiGr3COa4aCKwFj+lPd/Q1yI9kqM/fsMYl6m5dWWVRDPs21QAAKAQ6cSg6cu9+85VU97q1v5Y+sgTZjvEunZVNYygJfOVakFv7ZNblToCunUjbWoYmvwLT7KldzJQOVW6Ev8Gs58mAMrF2UIGMTj4NwUjkzhOaQR8C7JzQIKpj1rKBeYJ1rHVgZAwSTzdZl1R42xuIou3b4fHYMe0qyqBWFOa95K4gCWsvApw0dFS9xOwneKU8UMgJBPC9QngqEP+22brEUM5VNpwp3gbdKezTLK7wMEnyElzqAy0LN/k8P9jHp/n1Cs4lW0Y4xElLfCZ0zVxWniS6q428vxzcmOUCzDJnQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199021)(66946007)(76116006)(66446008)(64756008)(66556008)(66476007)(6916009)(316002)(71200400001)(478600001)(10290500003)(82960400001)(82950400001)(8990500004)(33656002)(83380400001)(7696005)(186003)(26005)(9686003)(38100700002)(122000001)(86362001)(966005)(38070700005)(53546011)(6506007)(66574015)(55016003)(8676002)(8936002)(41300700001)(5660300002)(2906002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?lDepTAE/t968AlqiLwdYKzwxGKTsnaYe/UdFi+XuQtLS5PuaT/z767QwXu?=
 =?iso-8859-1?Q?zt3b2VfBhDnug/3OZ+Dkf9I6qF4jMjNPQqEMHTF/0uX7TJN51u8cMrtt7Q?=
 =?iso-8859-1?Q?dgfbw4IU9rqEcg0ykYZULdt0I7nmNukF0VbtWlIby5wnMqoLHYQSN6jDdh?=
 =?iso-8859-1?Q?F8VHrMKp6WtB8Zevem46T1CfRJSDqJxcmuEHMftiscmJdIfpGi+BZm0mYq?=
 =?iso-8859-1?Q?eceDYdqLq0P866C754M/ZfyCjq+OO8ucblviHogIB9L8G+3KzaCHnOmOxm?=
 =?iso-8859-1?Q?JM4oZPDHs35bMYLBr/brODDZqdp5TrX8mzhsfIvwnYcQYLGZmplpp8G9GU?=
 =?iso-8859-1?Q?acS4RH0YpTHw/7TkXDOt9cF9Vp5cXWYZfrO/zjVaWf7q6BccHg4uM1KIuG?=
 =?iso-8859-1?Q?vnIzqpVuGy3irmPUiP9O6q0kU3r33US3lMUUEiCEAI2cgRwZDLQ5EDQYCs?=
 =?iso-8859-1?Q?EkAkG9DKsG0n2MM05iVkmvaAm9omF/RI/xekKGAaGv2b0fydNB8RDsYrlT?=
 =?iso-8859-1?Q?NEbki4n2l7CaR1z5blYXRk/BoFHYK795vDE827+jx3wHyVX3M7oDVyD4ZX?=
 =?iso-8859-1?Q?1vzYYzX4l/eWRrCgkGXhQodrCgUfVqysW6qOGWvvAA7vXmK8mMi8oFgegS?=
 =?iso-8859-1?Q?aiBi86Qk6u/F2iYZ8pX4m0FZFdFC+hhNMGNtlM68BGLZ8bp1+0CWh9qFG5?=
 =?iso-8859-1?Q?cCIR8vISgkY0acfbWsfp/uRJaXJfB9pmxJd6fqz1lzxy3z4msnVzIiC8AW?=
 =?iso-8859-1?Q?J6ysx+sKDvpsfkDpVvj+fEKQAOUkURISbNVn080EHZefJbbLy78uUMVcK9?=
 =?iso-8859-1?Q?9mydn5glL6ldNHA+lvNRHCWD/Rl71NcrOX0upcrVIPm8uGxxhV7HR5r8So?=
 =?iso-8859-1?Q?kx48z+MifKejdba1x4vv5RP8x0eIECOFdAeTmKJcymiCEfVYxGJ+xaoMwR?=
 =?iso-8859-1?Q?Pr5MCLSpo9dXllHBX7JDa2EZvTTeprMCYaw6ov6xXViBW6FRNOmHIE/iWp?=
 =?iso-8859-1?Q?Fx7qXVfmra++lUJXy78tGP7ik8BNZdPndZlZyHucscts8GZgNh5ciDP2V3?=
 =?iso-8859-1?Q?jB/twjZyYgIQT5pytCoEcwps734mW6a6jlTas/mpI3k/jdINg67LOFX/fG?=
 =?iso-8859-1?Q?qMVlqxJkyWcNVtEYS9TQEglmouB1CMKmhNnbZqHAXQ36HOxAh1QiStPV9j?=
 =?iso-8859-1?Q?dbIE1syg9gJ+qAVbGWSlh1aFV3rS4r5MLVZrDm7z0Xv/MImPSeUONDTayb?=
 =?iso-8859-1?Q?2gAPYLHhvUT4MjDKjsv79bfA2HnqHx/+IziPKU205YV09QvFxeVISLb9d2?=
 =?iso-8859-1?Q?wKTvBMg5f5cHKfwlAGdJo+hGQIRMYRiC4eTQbBDfXGijokVfazvIPmkT6g?=
 =?iso-8859-1?Q?bK65abHft3WGkECIJeILQsS0LdnGQdAo/tVXFtGBLmZRwhjQ8Zlz6djyXD?=
 =?iso-8859-1?Q?BxJVjBLL4YfFf0zR7WA37TVSFj7KxMm8WJMHvp8jXNXOjCQ5Nyqo/IN4FU?=
 =?iso-8859-1?Q?iMEIKexSOWXYUntQu4UAi45cR3WROswH3FC18DGXN4iDrqTR4p8HmcigfP?=
 =?iso-8859-1?Q?zcjSkF+ZAkcDNsyyil7VPyDotJeDc2OqvF1fwzQv2sYShNldjfaqpCuiDB?=
 =?iso-8859-1?Q?EXhRVpobm7LZcKYrmcsp3h3fCSxhUKyZmRnrnqsKltmp7AwxAdK1A1Xw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d86e7b4-f288-4b81-c5ab-08db74015aed
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 15:48:57.2271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: frXgklC6iZ6jbsfW3+p0NBdHpQqpR6RMEJRxgetl6TkdTPgTAPJiOmT+Qjd6HW8gXcXoeD7JxpAMM+Yj9ZG1/43Nb9Z7eEG/RGBppJlvetM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

-----Original Message-----
From: Bpf <bpf-bounces@ietf.org> On Behalf Of The IESG
Sent: Friday, June 23, 2023 8:14 AM
To: IETF-Announce <ietf-announce@ietf.org>
Cc: The IESG <iesg@ietf.org>; bpf-chairs@ietf.org; bpf@ietf.org
Subject: [Bpf] WG Action: Formed BPF/eBPF (bpf)

A new IETF WG has been formed in the Internet Area. For additional informat=
ion, please contact the Area Directors or the WG Chairs.

BPF/eBPF (bpf)
-----------------------------------------------------------------------
Current status: Proposed WG

Chairs:
  Suresh Krishnan <sureshk@cisco.com>
  David Vernet <void@manifault.com>

Assigned Area Director:
  Erik Kline <ek.ietf@gmail.com>

Internet Area Directors:
  Erik Kline <ek.ietf@gmail.com>
  =C9ric Vyncke <evyncke@cisco.com>

Technical advisors:
  Dave Thaler <dthaler@microsoft.com>
  Christoph Hellwig <hch@lst.de>

Mailing list:
  Address: bpf@ietf.org
  To subscribe: https://www.ietf.org/mailman/listinfo/bpf
  Archive: https://mailarchive.ietf.org/arch/browse/bpf/

Group page: https://datatracker.ietf.org/group/bpf/documents/

Charter: https://datatracker.ietf.org/doc/charter-ietf-bpf/

eBPF (which is no longer an acronym for anything), also commonly referred t=
o as BPF, is a technology with origins in the Linux kernel that can run unt=
rusted programs in a privileged context such as the operating system kernel=
.

BPF is increasingly being used beyond just the Linux kernel, with implement=
ations in network interface cards, Microsoft Windows, etc.

The BPF working group is initially tasked with documenting the existing sta=
te of the BPF ecosystem, and creating a clear process for extensions, inclu=
ding initial extensions that are widely useful and showcase the process.  T=
he working group will not adopt work focused on new versions or extensions =
until all documents required to capture the existing goals, particularly th=
ose in the bullets below, have completed IESG approval.

The working group will produce one or more documents on the following work =
item topics (with intended document status annotations, e.g.
[PS] Proposed Standard and [I] Informational):

* [PS] the BPF instruction set architecture (ISA) that defines the
  instructions and low-level virtual machine for BPF programs,

* [I] verifier expectations and building blocks for allowing safe
  execution of untrusted BPF programs,

* [PS] the BPF Type Format (BTF) that defines debug information and
  introspection capabilities for BPF programs,

* [I] one or more documents that recommend conventions and guidelines
  for producing portable BPF program binaries,

* [PS] cross-platform map types allowing native data structure access
  from BPF programs,

* [PS] cross-platform helper functions, e.g., for manipulation of maps,

* [PS] cross-platform BPF program types that define the higher level
  execution environment for BPF programs, and

* [I] an architecture and framework document.

The BPF working group shall actively engage the BPF Foundation steering com=
mittee and the broader implementation community to ensure inclusion in the =
IETF's consensus-driven process.

The working group is intended to only work on cross-platform aspects of BPF=
 that are useful to the wider internet community and are not otherwise oper=
ating system or platform specific.

Milestones:

  Mar 2024 - eBPF Instruction Set Specification [wg adoption]



--
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

