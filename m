Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34191639381
	for <lists+bpf@lfdr.de>; Sat, 26 Nov 2022 03:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiKZC6H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 21:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiKZC6G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 21:58:06 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11022022.outbound.protection.outlook.com [40.93.200.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7600F17A92
        for <bpf@vger.kernel.org>; Fri, 25 Nov 2022 18:58:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBaW3kRi7LuOzCqoKjQxWQC6MqVg5s/i9OjUzNIMl7fsTbhiBnlTGr2iU/Bbgj3K6Js4ZGcpZa7pkxK6uLBq6Fx7w9bwqdA45LiTLHYugmQ7Vve39n/dyjtVuZ7/w5laP7jHcbWn7BAIPiB1lmUPCYZ/SS/kkfE6i4sMQYiyk48MyCmLFjzVchMhY13sS2hQmZ8bGCyggKjlUkAosRDtvajk7mpn9ppE0l6YYoJierhNh0sXP2VmrtrKovGLGpLoJmKSadb35NAsBIAjlwiyigYQ8y3rEZ6DOuA+gVOCbP1WsFOTr99srusYjfqONku1zGqFQtjInZmfmwG3bSWADw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6o/KiqrFAxEHGOLHacnzFvq6UGvK0Q/Iz2ffyHRUObk=;
 b=EQjRiP3QyLQ/uudxbF+IGQjeWI3hAgu98RcUkkXCKL++CHA6C9f430gA2afYvKLn0NdHY1YdwqgbQlzPLYqZZhmU3XQmXJgoSJPmilm3D5r/AT+KF0nIcwvZGyRlG4I5BRaJ3ijqVT61rAIFEtgwEpt7WAdKtTOWcEv6V65sJChIWQmb6Rq1Ji7utLU7U+T2ULb9pukwbkudgzsTSGJDjeAm6/FDUQQ359Nc7h559tHKIFiRWkESQDSETxRubWsbpGqqHZQOqS7yLtlaNrx8MmLXyt3fi8P7s4XU0fAQZRwUS+1M9I7KcZ5b3cganlNrDHgE1HP0ST5tYJaG6eWGTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6o/KiqrFAxEHGOLHacnzFvq6UGvK0Q/Iz2ffyHRUObk=;
 b=fw+2fDLZ4JtDhZ/RQkZFiA9EDe+qZgnI5LUsm8w1fuutnYvhBfdHXT3b0LfM33IkxawOOCTrBRUGhA17kuMhINyKZ5cy4dpWBPLwDlP9idQgbApB2+8UbsVWxWnr2+PXrwgMkdQVT5lV3CpsZ1kueEBgPnxZ6BbNZTLDqum6vEw=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 PH7PR21MB3212.namprd21.prod.outlook.com (2603:10b6:510:1d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.5; Sat, 26 Nov
 2022 02:58:01 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::a366:bc9c:a902:361d]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::a366:bc9c:a902:361d%5]) with mapi id 15.20.5880.006; Sat, 26 Nov 2022
 02:58:00 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     'bpf' <bpf@vger.kernel.org>
Subject: FW: eBPF standardization hybrid side meeting at IETF on Thursday
Thread-Topic: eBPF standardization hybrid side meeting at IETF on Thursday
Thread-Index: Adjy8J1rlmtvi3FbSBKfzfRImPxPAwOOcvJQAAYUFzA=
Date:   Sat, 26 Nov 2022 02:57:59 +0000
Message-ID: <DM4PR21MB3440837AE8F54F8E6EA5D475A3119@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <DM4PR21MB34403BD72A941DEDE07E1E0DA33C9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <DM4PR21MB34401F1FD6A3E885F8C2CD7AA3119@DM4PR21MB3440.namprd21.prod.outlook.com>
In-Reply-To: <DM4PR21MB34401F1FD6A3E885F8C2CD7AA3119@DM4PR21MB3440.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=20e6a502-eaaf-4587-9bac-a6181abd0f62;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-07T21:33:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|PH7PR21MB3212:EE_
x-ms-office365-filtering-correlation-id: 858f8437-5353-4974-6b72-08dacf5a06dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NL4mqSNFlPwczU/7q7MfNM2ClljxCcwKWh7d1075wwFZ1XUwg1v4x5bVLQ3vXXVZ+OprIUrF5hxJkeGpX5U9VU9NQWTDa2xwjdFJJzB8A5gAk0vEyJY0TCVTnZuvddMWemHnDycKgUEkSrcyziP4q7qlTZ+IrrlM2MvlvKKQtIgm7OaGfz19ZYGCUrahy8uVzrsOc+hAAuLBEuNSQeXcl3cfhte3ns6TjySBX/cqNJuV7Cz8mfPDPJrWyooIgyHP6B9F+Whi1q5DmlWxUbx8qL/vWzOHkK/jGwX2V3qdIxsflH2ssvUa0zj2Ieq4lXQzwPVGGodglmbkgmZD0NgRyMvEKt0rK/MAyXQHdMAmJlwlZmmCSNQsJ5RVmT3SZzKx3NxB7p+uMIWPbRkNHXXad6XlQJY4ecJz1JPivPm2U1zCTu1NEzV4n4FnVwx+2RvIu4DlqLJHtbs5kkqtlBHc/dpCnZRSj+yJGLBdWC34tTUXGav/FYQZthvmBupNgHYZ+WnKfRZItYM/etW6u41NUVGMTsjEYcy9fJe3bdxeDUczMjlO9nvdkVI12awWcPHGdHABAdBeXR3D9n6S0qnstlRXEcAsm9OQrBXu494/XTmee/LPMteUX6WEqWfW4q4hX3yH7PBNGQLOw383hQF6cjrORVIOWwt/ZwizXG54+VVFHo8CP7iGd3peXkUD63rK81XUA9456KIhc8lUiE1u+7xX1uycamQBTpCGyAnPyQ+iOYNVS5qUzA9zk9A3RVufy02WTqOeouxnzel7KvtvTCQ46kxzoAyrxQEqQF+u8oBrJQqO6UDviqgcMfz6/pnj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199015)(6506007)(186003)(66574015)(6916009)(7696005)(26005)(5660300002)(2940100002)(55016003)(9686003)(38070700005)(41300700001)(8936002)(52536014)(30864003)(33656002)(86362001)(316002)(10290500003)(66556008)(8676002)(71200400001)(66446008)(64756008)(66476007)(66946007)(966005)(478600001)(38100700002)(76116006)(122000001)(8990500004)(66899015)(83380400001)(82960400001)(2906002)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bKishPM/wZECJVlL3nZis7lGQWNfNF1McTtLBgrPea9q5MkRkPTagXEnEl?=
 =?iso-8859-1?Q?Xd84++OILgImm72CAEzyMvkPJqsNnnDVb1RAuQRelfpgtUUW/52M2ZR+Sr?=
 =?iso-8859-1?Q?m+kwwYEaMmgDwSLCWsF34ZtXHmb+aRdNI6G4J7bFdPFPnPOvVh7Y2w5RyU?=
 =?iso-8859-1?Q?adLTCutmIze8E+8pSnaeecPO/fbijv99nyDNseKLY/xAFr4tUIBoiu4kln?=
 =?iso-8859-1?Q?bEjOMD/qKF/DI+Hc6P1ZMKIY/bMRJBJPZkQXNoOLpAUm5H93IV7bt6KPS5?=
 =?iso-8859-1?Q?lNGMBKS4ou2BAe5sD9JKIVTJqSK5d8YMrkEueQ43O+mYFZtSlcgGeZJdjD?=
 =?iso-8859-1?Q?kox2TJ7aP7THXq9M/wESo6N3g8RsrMay+sCBhVkP3TDf1cdDGGT7tiVGoZ?=
 =?iso-8859-1?Q?uR3f4pS5gaWyAfL/9f5v0wx7Q0yDbVgjWmxUig4gnz4NYnQLDHk+0OnmO+?=
 =?iso-8859-1?Q?zSjPxr9Z6+FZgeWFMRc6dW9R3N2oA+VKN2+OIXo/BaX9lEivJgzfHqhw73?=
 =?iso-8859-1?Q?NzyxO/YMahg7TSXOmuk0++wu8XTqg2hNWLmNgCIIjG3onvimq59f3vJ1HU?=
 =?iso-8859-1?Q?ZRuoRDftwtAHmn0pX0HwouW52cCk5Tbqiy/M7YYtoidJa7d0vbRFZt5erq?=
 =?iso-8859-1?Q?fmoE6WTMw94+yzxbxXiv/QN9NHmYYXHjvNXXseU6ZroSP7rJvLuGxBHdfk?=
 =?iso-8859-1?Q?ui6Vs5E9Fi6ZfqhVk93Rw0PtAgkcnXkQzNBQ4uSQ2M1H6v4OUY6Kf+oYEk?=
 =?iso-8859-1?Q?Oknzrf8rg5c1Jko2gF9fOOnCTzFOSuJ5jm0xI7HUzu/yJaqlLs4PihoFE6?=
 =?iso-8859-1?Q?lfr1nsopdEwGSKz01Stu4jImNlC9+eApnDAM3T0gwHQlD5N6SHxrUmC/m3?=
 =?iso-8859-1?Q?cCVla68k+F9x1Jjasg3EadYKEgKniIsyipHNmNxcVYj2/49Sh/GiKB7sn3?=
 =?iso-8859-1?Q?psRjqtNdzcBoKcxnFarkbBDS2/QopNnnrbfsa3168XvOXPR+WlyEluv+8y?=
 =?iso-8859-1?Q?Hs+T1vEYJLkvYDJtsEslzGG2nK58pOB/IeaLrVBSmH2b+HE0YPM+E3+hzp?=
 =?iso-8859-1?Q?ubP87tSga622STehsUSWnZm4HVh7wyiSaeKTYSLGeIhlgPCd2Z9PscoG8h?=
 =?iso-8859-1?Q?htYUm/qW35TA0WMBtCKiVVzgdgMi72pjInOX4n23wUK0GbTtRmUnVN8n+O?=
 =?iso-8859-1?Q?/9m7wTtgGzmqWkhaW35I7e3SWI1W5iFEvzDpvG3oiaLI6OE0GDT4xK3Ba9?=
 =?iso-8859-1?Q?pc7HrtQPCp8VBD7Ir4G0sIjY5xE1efYfVUsf+L+2EAi/Cwy8bFlFLKWtgE?=
 =?iso-8859-1?Q?quu8lR6j9t28WseGpwwDrKxOQDE72u7SZ8Vzywqu1B52wo7F9tCbg2HT99?=
 =?iso-8859-1?Q?9duW0dFUapKcMEspscBDTMMickZW9vHTLWhTINfEKFgRWMFIqYc6LE67Um?=
 =?iso-8859-1?Q?w/7i4v+dCS8jk19OAgBh1ypWRlc8dAE4pObqr4wv5ouY73HJ4b1yvoklXC?=
 =?iso-8859-1?Q?98OwrSoAZbIzTAuCpinx6mdE40MpYx21d27y5G5/5f/8ejZ2fM0VTudJh8?=
 =?iso-8859-1?Q?OGzVTu44/mMkfWPSnz3zdStEI3RMcrqprtcZRXS/qC1yoBFsLYkEKLw5f1?=
 =?iso-8859-1?Q?jJPkGRRL/ibeoe58mmrMnZmKq3RFIX8nJGNPU1X2C1E7aS4P1tSRLwNw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858f8437-5353-4974-6b72-08dacf5a06dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2022 02:57:59.4992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhlZXoyUXBIjXn5R2uiYoc0Vk/RP2UcZBoU+B5xZ3+itqvFrpg91huhs+w/2RIYftmsqCEaTqRov2vWMHrxxEGLsZvMSk0OUeDsw/3uPtBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3212
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Notes from eBPF Side Meeting @ IETF 115

Note Takers:=20
. Mykola Lysenko mailto:mykolal@meta.com (remote)
. Kiran Makhijani mailto:kiran.ietf@gmail.com (in room)

Recording: https://www.youtube.com/watch?v=3DKRGYGBkJpWM

Attendance:=20
. Includes contributors and leaders from both the eBPF community and the IE=
TF community
. 17 on zoom
o Alexei Starovoitov (BPF Steering Committee)
o Daniel Migault
o Gyan Mishra
o KP Singh (BPF Steering Committee)=20
o Manu
o Mykola Lysenko
o Quentin Monnet
o Sharon Z.
o . (others)
. More than 16 in room
o Christoph Hellwig
o Dave Thaler (BPF Steering Committee)=20
o David Black
o Erik Kline (INT Area Director)
o Lars Eggert (IETF Chair)
o Lorenzo Colitti
o Kiran Makhijani=20
o Mirja K=FChlewind (IAB Chair)=20
o Paul
o Suresh Krishnan
o . (others)
--------------------------------------------------------
Meeting started at 6:05 PM with introductory slides by Dave
--------------------------------------------------------
The goal of this meeting was to discuss where to publish eBPF specification=
(s), where IETF may or may not be the right answer.=A0 The goal is not to g=
o in technical options (not a tech meeting).
Option A: publishing through BPF foundation
. Historically all bpf documents are in the Linux kernel source tree. They =
get reviewed and merged. Recently, a Github mirror under eBPF Foundation wa=
s created.=A0 We are in the middle of the process to generate specification=
 as pdf from the docs in the Linux kernel tree.
Option B. ISO/IEC JTC1 (after doing A)
. e.g. are W3C and OCF (links in the slides).
. Q: Are these ISO documents freely available.
. A: Yes
. documents can be updated, obsoleted by the newer versions of it
. may take up to 17 months to publish
. not super fast.=A0 They have meetings every 6 months. Long process; howev=
er, some org. provide it for free.=20
. David Black: They don't change the document name/title but the year of pu=
blication.
Option C: Independent Submission Stream RFC
. submission stream RFCs outside of the IETF, but they would not be "standa=
rds" and no one was in favor of that approach.
Option D: IETF stream RFC
. Dave went through IETF process/terms for non-IETFers, based on the IETF T=
ao https://www.ietf.org/about/participate/tao/=A0=20
. IETF and document authors own the copyright
. Contributors and participants agree to disclose if they are personally aw=
are of patents
. IETF takes no position on patents themselves
. Documents themselves do not mention patents

7 candidates for standardization were shared from previous BPF discussions =
in BPF office hours, Linux Plumbers, etc:
. ISA - somewhat analogous to Java VM
. ELF file format
. BPF type format
. Compiler expectations
. Verifier expectations
. Cross-platform map types (array, hash table, prefix table, etc) - some ne=
tworking specific, some not
. Cross-platform program types - some networking, some not=A0

Questions to answer:
. Is any of this in scope for IETF?
. Are IETF copyright/IPR rules ok?
. Is the speed of publication ok?
. Others?

Today the BPF community currently submits changes to BPF mailing list for r=
eview
We have a github repository synced with upstream Linux Kernel
Dave shared the patch workflow from his slides
So, is BPF in scope for IETF?

Dave gave examples of cases where documents not directly related to routing=
/networking were published as IETF RFCs. Those are not just API but pseudo =
code in them.
=A0=A0=A0 - Netlink specification is an RFC (informational). https://www.rf=
c-editor.org/info/rfc3549=20
=A0=A0=A0=A0- JavaScript is an RFC but also published by ECMA
=A0=A0=A0 - Some socket API extensions are in an RFC (e.g., https://www.rfc=
-editor.org/info/rfc3678) but it is informational not a standard, the stand=
ard comes from POSIX
=A0=A0=A0 - Java VM would be similar analogy but is not in any RFC
=A0=A0=A0 - A file format could be in scope of IETF (e.g., https://www.rfc-=
editor.org/info/rfc9116) but that example was for a format inherently tied =
to networking.=A0=A0 ELF file format isn't inherently tied to networking th=
ough.=20
=A0=A0=A0=A0- Tao of IETF recommends BOF to start a WG, goals for BoF inclu=
de determining whether a critical mass of IETF participants exists, and tha=
t IETF is the right place for that activity.=20
--------------------------------------------------------
Open discussion then started at 6:22 PM
--------------------------------------------------------
Lars: Dave and I talked about it at the Linux conference in Dublin. QUIC we=
 did option A.=20
. thinks it is in scope of IETF
. if it is not of scope for IETF, we should change the scope
. github approach would work for us
[Someone on the Zoom] Are you open to standardize an interface? Do you mean=
 relationship between the program-type and network specifics like (unicast/=
multicast).=20
<--can not hear -->
KP:=A0 ??
Erik: At the minimum we have ART area and it fits under that area.=20
Lars: we will find an area.
Dave: there are use cases that fit in both INT and ART area. Different case=
s will have diff areas. Analogy is where should DHCP option go? Answer is t=
hat today a DHCP option can be done in the WG for whatever the option is co=
nfiguring, with review by the DHC WG.
Sharon:
. question: are you open to standardizing the interface to solve the proble=
m using the BPF set of skills? it is not for the sake of eBPF, but for the =
.=A0
. examples: people porting from cloud env to edge env, no streams that edge=
 graged, we can combine bpf and streams to help port streams to the edge
Dave:
. networking specific, interfaces
. Sharon might have spoken about networking specific program types
Sharon:
. Kafka does not work in the edge
. stream would be a topic=A0
. it would leverage BPF
. it would be useful to have kafka like streams
KP:
. eBPF code will run on routing equipment itself?
Sharon:
. no, it will run on Linux
. it will be an object portable by cilium
. it will have logical address associate with it
. city has a set of engines
. off at night
. vehicles will send packets of their instrumentation
Eric:
. gets too technical
. can we get back to the less technical conversation
Sharon:
. specific example of the networking
. network management area
o metric constructs
o subnet conversations
. the question are you open to specifying the RFC that is not specific to B=
PF but using BPF extensively
Mirja: To clarify on process, pdf is the only documentation?
Dave: yes, just to prove the process works.=20
Mirja: clarification question=A0 - so you need to standardize existing docu=
ments.=20
. I do not understand the technical topic enough
. Is this the only documentation we have for now?

Lorenzo: you need to standardize when interoperability is important and for=
 backward compatibility. backward compatibility implications will have to b=
e provided by BPF. Is it like a Linux guarantee, e.g. never breaking usersp=
ace?=A0 =A0Some APIs are guaranteed forever... some other things evolve mor=
e quickly.

Mykola: ISA is not stable

David: We can definitely find a place here... <missed some part...>
Suresh:
. (1) routing is a better area. Netlink and TIPC are another examples that =
group worked on.=20
. (2) eBPF community needs to think about change control. Anyone from IETF =
can have a discussion with you on changes, you will need to do the work her=
e based on IETF processes.
. (3) in terms of updates and backward incompatible changes - 4 in 6yrs are=
 good, but not 4 in 6 months.
Dave replying to Suresh: Some types of changes can break backward compatibi=
lity, such as in Instruction set architecture (ISA) are rare (gave example =
about divide-by-0 behavior). Whereas addition of new instructions is not br=
eaking backward compatibility.
=A0 - As long as 'sufficient' Linux community is participating, the risk is=
 low and manageable.
. two types of modifications done to ISA
o things can get from undefined to defined, e.g., what do you do if you try=
 to divide by a 0? now it is acceptable, before it was a broken program
o new instructions were added
. as long as Linux kernel community participates in the decision making - t=
he risk is low two communities will diverge
Christoph:
. (1) divide by 0 change was a good example where something that was undefi=
ned got defined and behavior changes. The behavior was not documented, that=
 was the other thing.=20
. (2) it is surprising how the 2 community works are similar, if Linux main=
tainer doesn't take it the functionality does not go to kernel.=20
Eric Kline: FoRCeS did netlink. You dont have to wait for full publication =
before you implement it.=20
. we can take a document and go through the process
. if Linus does not agree then you do not have consensus

Paul: understand the change control clearly, IETF has rough consensus, in L=
inux if Linus doesn't like it he vetoes it, that's not how IETF does it.
Lorenzo: Question for eBPF - is there a canary document, something that is =
available and can be brought to IETF? e.g., HTTP3 was standardized later in=
 IETF, was brought by Google.
Dave followed up with examples of those (ISA, file format etc. from the sli=
des)
Mykola, remote: why do we need to do standard?
Christoph: because some hardware vendors have aspiration to see and verify =
against a standard specification. gave NVMe example, when you download code=
 for storage h/w, people ask for standard document.=A0=A0 NVMe needs to hav=
e an ability to have one standard document reference, we really like IETF s=
pecs
Lorenzo: We need standards when more than one vendor is involved.
Lucas reply to Mykola: initiative is good. Will help get better collaborati=
on
. BPF networking code
. applications want to use=A0

<<someone>> what is IETF going to offer? -- You get RFC label, some of the =
work is not properly labeled. it will add an overhead, we need to document =
existing practices
Dave: right now we are documenting existing practice
Gyan: eBPF can help with programmability of routing protocols as reference =
open platform. will help in interoperability on different hardware:=20
. Would eBPF programmability be ported to any hardware?
. Is there a desire to port to router platforms?
. if yes, that would be a reason for interoperability
. BPF is programmability
. P4 programming, ASIC programming, beneficial for optimizations
. Does it really come into play?

Christoph: both for being covered

Lorenzo: move on reference interop platforms - it will be like support on c=
isco/juniper or kernel.
=A0 Non-Linux eBPF benefits are extremely useful. we use bpf in android

Christoph:
. interop
. another huge advantage is having people asking the questions

Eric Kline: recommending to bring this to RTGAREA. on programmability, eBPF=
 can improve the readability of the IETF documents. SRv6 will be a good exa=
mple. eBPF was used a lot to implement protocols in hackathon.=A0 you canno=
t process some options in the HW
Dave: eBPF was in multiple hackathon presentations last weekend

Alexei: two interesting things
. standardize ISA to standardize other things
. other parts like routing, maybe to consider standardizing using BPF

Christoph said he was willing take the lead on dealing with IETF process an=
d overheads for the documentation.
mailing list: mailto:bpf@vger.kernel.org
-----------------------------------------
Kiran's summary:
1. Unanimous support from the IETF to eBPF. eBPF really keen on putting RFC=
 # of ISA, file format etc.
2. Discussion on understanding what and how to standardize (it seems docume=
nts will be ready in kernel=A0=A0=A0 source, brought to IETF for standardiz=
ation). If IETF review causes changes to an implementation - will it change=
 existing implementation or not was not clear to me).
3. The eBPF community was warned about the overheads related to bringing wo=
rk to IETF - rough consensus, process overheads, IPR, anybody could comment=
, etc.
4. Benefits are clear: interop. eBPF can share standard RFC to refer to for=
 different vendor implementations (incl. hardware).
5. Implications of change control and backward incompatibility were discuss=
ed as potential risk and should be evaluated more seriously if eBPF is ok w=
ith slow-paced changes.
6. IETF community thinks it can use eBPF to improve documentation of its ow=
n protocols. e.g. ,SRV6 but how is not hashed out. Not the intent of eBPF.=
=20
7. Erik as Internet AD, said he wants this WG in routing area. Lars as IETF=
 chair, supported 100%.=20
8. someone from eBPF took lead responsibility to bridge eBPF and IETF and m=
itigate risks discussed.
-----------------------------------------
Mykola's summary:
we went through Dave Thaler's slides and introduced the audience to the cur=
rent BPF process of BPF documentation. Then we tried to answer the question=
 if IETF is the right approach to do BPF standardization. Participants disc=
ussed a few existing RFC standards that are not networking related and have=
 separate goals. E.g., compression, API interfaces, and others. We did not =
get a clear answer on why the hardware community needs to publish RFC excep=
t that they will be able to reference a particular version for the implemen=
tation and that IETF has a process reviewing such documents. In particular =
it is not clear why a versioned document published by the BPF community wou=
ld not suffice. In the end, everyone agreed more discussion is required.

