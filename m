Return-Path: <bpf+bounces-4282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC96F74A2BB
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 19:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81251C20D9E
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 17:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B0EBA3B;
	Thu,  6 Jul 2023 17:00:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6691BA28
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 17:00:49 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AB91996
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 10:00:48 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3BB70C13AE4A
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 10:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688662848; bh=1A7Umlw+vfB5pi0uqr0ImmLdc2x+5J8HjEE63yEfNSQ=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From;
	b=GpA3FiUEkuzmhtEbIEqaVB+4I4tRiNzCK95ULNniF6W9/fg/OHV89kg99qlEer+jy
	 zccovwq09CNOeFOLWzl4CBAM2issWNcjSaJZe0jKxzBVl88nQAGSow2LQmfwwqZf6J
	 X0myqGTLzRtOlaSxba6w5tVnvv1SMNbDZytDBtvQ=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 0A46AC1519A1;
 Thu,  6 Jul 2023 10:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1688662848; bh=1A7Umlw+vfB5pi0uqr0ImmLdc2x+5J8HjEE63yEfNSQ=;
 h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=Bm2HRn2ame7G95Be677/mg02Lx1gTYsvlepIjtlqcJ1UMAmr+1DWiljeWm5bT2kRw
 Cj/xJTRhNUELJkMgWwpTyz/f0yVntEbVrT6SwLDXxHGusPgtk6pp8ttwFlkN/izbbY
 8rQj/ExCQilIJ+L9aeLoiLtonO+nzdLquQPR0Tnw=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 7386BC1519A1
 for <bpf@ietfa.amsl.com>; Thu,  6 Jul 2023 10:00:46 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.097
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=microsoft.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KiDsApsMpriL for <bpf@ietfa.amsl.com>;
 Thu,  6 Jul 2023 10:00:42 -0700 (PDT)
Received: from BN6PR00CU002.outbound.protection.outlook.com
 (mail-eastus2azon11021015.outbound.protection.outlook.com [52.101.57.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id CBF54C151092
 for <bpf@ietf.org>; Thu,  6 Jul 2023 10:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bT1evAs8uUEclipgfcrXnBMOfd/1ruQwFggd1FHKa69KFfcFd8rrRb4CxtzL8fuANFSH8KcjRNV8TaOTqYqMNkFbIm1xJeyW/8444aAVPnV/P6zIo8TeHetMe5AGkECJ2gHjiy+l314WuPp8IVXpVmHWFH88j5BpGxbQn9gjDeqMfgYlp9DCjw/FZszd/wMgnn1AM0Q+ul0Rwa4f9CkEJQBN5NwF68cBWhan3qe4qd21R5+vRPVABnfYKTAqSfPpARrmZ9zMtA4QESlH3vFvR252Y9LJq1Vt25JSIFxhLeenXXomKjMKznSzjv5ni8ImIP3SIBxu1rS7Xj/0BOi/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2GB3jCcan9PdUF0n1xXYwxpdPKYObQa43/JPfyAtUQ=;
 b=Emv4dmWkTfxi3t2Z+3dOrRy4RDMVtaT+pECX9mtB6EgEVB4ce1dsE0ip3zcir7jO6qBTE5AOJ7bGnKdBU77ckRdgAVJA8hmJKyXJycZqSwD+3q1/gJxTyINfrys/XFKKfBYo/GWU5MIcvmlx76sxWxQIbj9wsy0HPfXU2iAk5DOSpzTAJcHVkKyDrxtKoSen/Fblfgs6LRHod48zEJAYUugxK5Ia/NH1qwQF/zK9b6IAS8rtF4eQS0xv+X96a8KVExJKiwZetpEN5q8XZj6ykwCjS8q/dHKKrcuDMoJwiWGIsggAm2hkqpOWM3wraxYN0ZdSWAN+7mPxEeo5rzZqwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2GB3jCcan9PdUF0n1xXYwxpdPKYObQa43/JPfyAtUQ=;
 b=Ugnm0cPpWXcNXM/VFN1r8gN81t7NI6KhhwPE462KTPpRkvPc2ugfiFum2B2qJpfIVsKbEd9OEmTIqYLsOKGdhe0SHFkq4NlUzjlc+8NiNiYERAjD5ewvDZAxbH4dZgij0We/Oc6rtweJR2EFD7e6muRZnrPu078CGXZxvgXiAzU=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by MN0PR21MB3315.namprd21.prod.outlook.com (2603:10b6:208:380::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.5; Thu, 6 Jul
 2023 17:00:38 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::8708:6828:fb9f:7bd5]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::8708:6828:fb9f:7bd5%4]) with mapi id 15.20.6544.010; Thu, 6 Jul 2023
 17:00:38 +0000
To: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Thread-Topic: Instruction set extension policy
Thread-Index: AdmwKdCg+G2TzllJT+2ICM2r0nWi5A==
Date: Thu, 6 Jul 2023 17:00:38 +0000
Message-ID: <PH7PR21MB387813A79D0094E47914C5A8A32CA@PH7PR21MB3878.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4f26c140-2a7d-409c-bdfc-96cc81d12f7a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-06T16:46:57Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|MN0PR21MB3315:EE_
x-ms-office365-filtering-correlation-id: b4480d80-b80c-4dbc-35b4-08db7e42861a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l4Xt04Hl+WGq827vcrvS/1XoIlfQ6X/5g5qE7Crtxdtt4++A1ZPnjJobRIN8+E2tM3sNuKcd+YIgj5V18CKmQ/Q8HpVE9YMcqgHHJMeag4JobDIXP7w8p1dJdK/BQFPkSRLpNvdTCpUisVhTa3BCizNpNQmVfNOFUMz9xvKiQyCTA5LT5OXd8Rb3Dc1v2m+4U8PQvBJIeYcsFRhJfFqbmCmAbhok896HDGAcKnu5lh5nlDmzj8sHD4kZB1RbdHUZTYyOXhKsYR0AUH4YXJPA3ac5yCmrBqJGKLo1SzY7zTEK9W6AyKfRC7xT/vtLg0dzK7G409BRQAZwJQn1IsELZkkD/yeYkdEBHXg+nrd90kriw88jk6i7h7Dna3YOxQdRYQoAqLG6JQz0x1wKAzJcdWqOV1uui/0wpUznB1rpc1p0r9X0qER3Uju1vU85eTBeLRkQ0zIN9YMDHv06/gWzuzsonBIbZ4+hA8aYiGS98bBfiyIbRL2qF3sceG93Z3aXaIW0mlnDdaf4F89jJKXvGvt9M6JYsKNHR98a8fZ2+8XaMOeBtGKgNuoifXQGBrQvIs1JlbjyZW67+JppE2Dy7TF1g45ADson8GsEuAWb8rEVAGvQWkvJ0ZJFyQRzax+9JNTxSUKbhG0890VFVqWEZA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:PH7PR21MB3878.namprd21.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230028)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199021)(8990500004)(2906002)(66446008)(66556008)(64756008)(66476007)(76116006)(5660300002)(8936002)(66946007)(41300700001)(52536014)(316002)(33656002)(55016003)(8676002)(9686003)(26005)(71200400001)(6506007)(186003)(82950400001)(38100700002)(86362001)(166002)(3480700007)(966005)(38070700005)(122000001)(110136005)(7696005)(82960400001)(478600001)(10290500003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t3WoFAGn4iJCeKZ20ISWiNprhYvlVjw8qHQHxJdJQNdPaX46F7o20mL2qepD?=
 =?us-ascii?Q?5zx7wZyFsmb+oZYvQtcjebkJPtuZnuB3wm69BQHEwwuQ1L+yQtfF9AGZwO2I?=
 =?us-ascii?Q?D5AcYD7lOVJXhHrSeiDQ340kJ+uxqFYbrP0eunzTTLbJ2YVe99INiEcuhYPO?=
 =?us-ascii?Q?bNrN0MsCM5LBVWwDDegqYPbJGh1iOy+OpZiYaN1jNGj8PJlWQVCzEtEdXNYZ?=
 =?us-ascii?Q?ouC8F4disZrbS+TIUoIJy0BJj71Rg+d0U/7uWgiYwkmbfGSGEfOV8SkFvlIW?=
 =?us-ascii?Q?ASvWHH1FmNIvGjhdn6qGxLrQ7jas+YxUy3NgP321bieHdc5WUrYHpzp5vLDP?=
 =?us-ascii?Q?Zj2LKMCFlp3K7VzD7Y6H2+XKgoIAv5JHPdQ4Yt62b6TQ/6PRzBOm2rgKX348?=
 =?us-ascii?Q?ITs8QEgKIfkBPvcsE/uW7yun84NVoPyuhptaknr6vNYZZJ5US8KvPSMypo0y?=
 =?us-ascii?Q?ysp3YFh1AvxfgHgSPq2PsAwiUncAru+VxSX9ESOFE4sw/HQ0UBXXhPH7ddi9?=
 =?us-ascii?Q?l2TvcEdIhOEfiUHWHBAzz5+crU66LV/4bwaHmkvzQ8OE0RLIFa3TpBQHs58C?=
 =?us-ascii?Q?nZfmGO6lhsSUZPSKgYHAysCbtWEjXvpAqLtyySfievXnK1s3numfb8mVvepD?=
 =?us-ascii?Q?OiHdq4RvIn2hHeR0NruwvT3oHgcpPyASdw9WFU9gfYc0ToBg1yRciRn3qfwv?=
 =?us-ascii?Q?dZkvPy0qwAe6b5A8XDAyBPUcq6oW000cb1n2Bzg2URJ7pa9Ycyrti6Z6e5FG?=
 =?us-ascii?Q?8ZQED7n4cKOH2A3ZLccUryOlV3cdgRE/W2Po7siiGNCBPpcHdmzELIyqlsmr?=
 =?us-ascii?Q?2j2wki9pWE2EQg71kEeYgR6DUnzY6vJTPc8gdU3BTi1nCHl/iJDftXoqwGFP?=
 =?us-ascii?Q?IxRciJS7YgQbnmNFLSh2jto3VFzZZ6YLVIpzbI7meIGqix2TsTRczk60CoOS?=
 =?us-ascii?Q?t/RkTX6v0MhM/qA+8//JOsgzb3GJCqDIujrtwTSqsXUSdmXPSkPxerj+o6XU?=
 =?us-ascii?Q?NheOlsTIYGgsg1JLB8br27jKh8ZeMGi+rfpMTQoscVKhKQNikNPmusRNQl6I?=
 =?us-ascii?Q?cvlo9fuUF9WQtouxXXMLALwm8xeMAdc2bWPolTtqEuQ5XajI/dEqDJ7jWP21?=
 =?us-ascii?Q?4Un7VnHt9oGd9RnhmQHGBFpi/rx/1nnFh8XM1RTbhW5ux6Psr0dji+sPzexh?=
 =?us-ascii?Q?YAyY3BzdDxZE9oceBx0qZ4a86Bfy8cQ+vSlr6R6o6Gj1QOWJBtJNP+9Poxs2?=
 =?us-ascii?Q?amz+Fh88VoEGbiez1SX1a60ei3dkASP+bAAgRGGIa9Vtx6jgMeh9uReXz9Ib?=
 =?us-ascii?Q?lAIPztdkTs4Aff5XPsr7zOOb1FmWdbWi48AWV/sce2Cx9Qx6nAkfawSAbUeZ?=
 =?us-ascii?Q?R0PbW0hP7glIBm/8H26SBzwl6NrGJvqaRP9tdH185dOsaLg5n5Jb6+Bn0/ok?=
 =?us-ascii?Q?QhrKq7uqWow/GhJAfeFxx1e6vzfPCnZfSPckPdGl4ncR0QZI5/49zIL7hzRh?=
 =?us-ascii?Q?68WdcEJC5zcyYoPTHBtBnH3QqbCU5RODsnGF6Om9gq5SvRi8GW4t66F3Wh/W?=
 =?us-ascii?Q?WHnDmaQp1lIDEFP7aVVhVIqVijeYpZdIBqyts0jKq0KD4V/CdjYDIDTqooWF?=
 =?us-ascii?Q?kw=3D=3D?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4480d80-b80c-4dbc-35b4-08db7e42861a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 17:00:38.5294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MT/OnPVPpE4xXQQADS4I94ARJcLO4sSf9yw9miJZzPt1blsWUV1jnggAaam3tb1UW6FzFOyst0J6B3QrfDd5qurrk+IDcDscw2oEmMN6xF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3315
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/jyuPMZGorkLlMNT_PJU8U8J7F6Y>
Subject: [Bpf] Instruction set extension policy
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
Content-Type: multipart/mixed; boundary="===============2132464061937062888=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Dave Thaler <dthaler@microsoft.com>
From: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--===============2132464061937062888==
Content-Language: en-US
Content-Type: multipart/alternative;
 boundary="_000_PH7PR21MB387813A79D0094E47914C5A8A32CAPH7PR21MB3878namp_"

--_000_PH7PR21MB387813A79D0094E47914C5A8A32CAPH7PR21MB3878namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The charter for the newly formed IETF BPF WG includes:
"The BPF working group is initially tasked with ... creating a clear proces=
s for extensions, ..."

I wanted to kick off a discussion of this topic in preparation for discussi=
on
at IETF 117.

Once the BPF ISA is published in an RFC, we expect more instructions may be
added over time.  It seems undesirable to delay use such additions until
another RFC can be published, although having them appear in an RFC
would be a good thing in my view.

Personally, I envision such additions to appear in an RFC per extension
(i.e., set of additions) rather than obsoleting the original ISA RFC.  So
I would propose the ability to reference another document (e.g., one
in the Linux kernel tree) in the meantime.

For comparison, the IANA registry for URI schemes at
https://www.iana.org/assignments/uri-schemes/uri-schemes.xhtml
defines status values for "Permanent" and "Provisional" with different
registration policies for each of those two statuses.

Similarly, I would propose as a strawman using an IANA registry (as most
IETF standards do) that requires say an IETF Standards Track RFC for
"Permanent" status, and "Specification required" (a public specification
reviewed by a designated expert) for "Provisional" registrations.
So updating a document in say the Linux kernel tree would be sufficient
for Provisional registration, and the status of an instruction would change
to Permanent once it appears in an RFC.

Thoughts?

Dave

--_000_PH7PR21MB387813A79D0094E47914C5A8A32CAPH7PR21MB3878namp_
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
<p class=3D"MsoNormal">The charter for the newly formed IETF BPF WG include=
s:<o:p></o:p></p>
<p class=3D"MsoNormal">&#8220;<span style=3D"color:#212529;background:white=
">The BPF working group is initially tasked with &#8230; creating a clear p=
rocess for extensions, &#8230;&#8221;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#212529;background:white"><o:p>=
&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#212529;background:white">I wan=
ted to kick off a discussion of this topic in preparation for discussion<br=
>
at IETF 117.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#212529;background:white"><o:p>=
&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#212529;background:white">Once =
the BPF ISA is published in an RFC, we expect more instructions may be<br>
added over time.&nbsp; It seems undesirable to delay use such additions unt=
il<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#212529;background:white">anoth=
er RFC can be published, although having them appear in an RFC<br>
would be a good thing in my view.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#212529;background:white"><o:p>=
&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#212529;background:white">Perso=
nally, I envision such additions to appear in an RFC per extension<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#212529;background:white">(i.e.=
, set of additions) rather than obsoleting the original ISA RFC.&nbsp; So<b=
r>
I would propose the ability to reference another document (e.g., one<br>
in the Linux kernel tree) in the meantime.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#212529;background:white"><o:p>=
&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#212529;background:white">For c=
omparison, the IANA registry for URI schemes at<br>
<a href=3D"https://www.iana.org/assignments/uri-schemes/uri-schemes.xhtml">=
https://www.iana.org/assignments/uri-schemes/uri-schemes.xhtml</a></span><s=
pan style=3D"color:black;background:white"><br>
defines status values for &#8220;Permanent&#8221; and &#8220;Provisional&#8=
221; with different<br>
registration policies for each of those two statuses.</span><span style=3D"=
background:white"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"background:white"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"color:black;background:white">Similar=
ly, I would propose as a strawman using an IANA registry (as most<br>
IETF standards do) that requires say an IETF Standards Track RFC for</span>=
<span style=3D"background:white"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black;background:white">&#8220;=
Permanent&#8221; status, and &#8220;Specification required&#8221; (a public=
 specification<br>
reviewed by a designated expert) for &#8220;Provisional&#8221; registration=
s.<br>
So updating a document in say the Linux kernel tree would be sufficient<br>
for Provisional registration, and the status of an instruction would change=
<br>
to Permanent once it appears in an RFC.</span><span style=3D"background:whi=
te"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"background:white"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"color:black;background:white">Thought=
s?</span><span style=3D"background:white"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"background:white"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"color:black;background:white">Dave</s=
pan><o:p></o:p></p>
</div>
</body>
</html>

--_000_PH7PR21MB387813A79D0094E47914C5A8A32CAPH7PR21MB3878namp_--


--===============2132464061937062888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============2132464061937062888==--


