Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FC35B8524
	for <lists+bpf@lfdr.de>; Wed, 14 Sep 2022 11:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiINJh0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Sep 2022 05:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiINJhL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Sep 2022 05:37:11 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E15E491E4
        for <bpf@vger.kernel.org>; Wed, 14 Sep 2022 02:35:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kn0dYx7Core9AUN3y8+F5BNV9nfV50KL7kjrEDLnBCb0ShpoY1soSnWlfM3P0MluoCBxJJdxbieJY800GA1ODu/ggKXGVtcq8Zxxvm7oyCPrANY6H7YgDYFirXjmgGZZyaNgLGNBhkDCL7HT2E2mE8SrYvBIEYuWiVMl9iGC6OVM2/lr7xRGi0WUCntchO5XLWLFgF4T3BUvHwmePwcFClWkL65FOVNhCDa/lbRkb1ZDMnx45p5k44xD063BRXGQ426tB7sfSPbNML38B/purjyWtz9penb7RlZmdauCvCqzh4UMJLHAM5tWiriSGm3lmBgP3FGq0QdIPAvZx1WSxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L99tiW9utqBSFsBU1IGSZICqe8vf05qiM7ntSUIE9Uo=;
 b=DHMILsP57T0mrCTH8k8M/tRM0ABdetDzgtGAnp5aP0Y93gxAa2hjtb26MWkKkw1ZeKRAc0dxoRATUwI4rRlKmwVMjg1qlEt5YYTrny5Bl9z6M6KYhZpspgoOnb7bMIvqZ65hjqUI+gwyGKifpl6x0zv1cJPmwXlJ2ca7Z8Vysbr4jX72wM3F7irreVy1xZgJpdyDgXUi+Yc+NmkTiL5y7CvmoKrscaGNyGx1nRwIfl9DDDrwskpJdp4ICYrhHGQhEloWiBGDpQlQOQKNnURT/LQ/eqFfZLc4Usd2LtxHrkQOZi+73U4q47RbxkrtaHXly3F2Dz2nXJ8gwvsEXqjxGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L99tiW9utqBSFsBU1IGSZICqe8vf05qiM7ntSUIE9Uo=;
 b=OKEWSlIyOLnkuM9ULjcml1WWsWq/Ex0t5hJvzHfWjja1NEw7gopS96I7iMnxgSRa45U1gsDFrcTtPtD4YRaDcfXdKXLOWKa4xAxfu2kcx1r8f+dCxQl/Ut8bgrgHEwTLy4YNEgK3adYcQNYyJqBYa7uw0riGl/J5C/jvxKMbZow=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 DM4PR21MB3680.namprd21.prod.outlook.com (2603:10b6:8:a1::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.4; Wed, 14 Sep 2022 09:35:37 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5872:7dd2:2a86:c111]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5872:7dd2:2a86:c111%7]) with mapi id 15.20.5654.006; Wed, 14 Sep 2022
 09:35:37 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>
CC:     bpf <bpf@vger.kernel.org>
Subject: RE: FW: ebpf-docs: draft of ISA doc updates in progress
Thread-Topic: FW: ebpf-docs: draft of ISA doc updates in progress
Thread-Index: AdjEi0anVH25Go4YTCyzpO9wKsLa4gCvUITgAC54c4AABc9t8A==
Date:   Wed, 14 Sep 2022 09:35:37 +0000
Message-ID: <DM4PR21MB344027CA6C8F0A5D5CF56BCEA3469@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <CY5PR21MB377000AC95B475C47B702293A3439@CY5PR21MB3770.namprd21.prod.outlook.com>
 <DM4PR21MB34401314FC9285A9F5A338E0A3479@DM4PR21MB3440.namprd21.prod.outlook.com>
 <YyFzO205ZZPieCav@syu-laptop>
In-Reply-To: <YyFzO205ZZPieCav@syu-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a3c6241b-c49c-45ec-8d7c-3b7984504e71;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-14T09:09:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|DM4PR21MB3680:EE_
x-ms-office365-filtering-correlation-id: bdd45663-1f03-424f-b4ba-08da96347aec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ibgK1XlnDIZFfVkx+ec5OH/bHe0F1eFZ/P2XiYUUKk53Kf0V7gC8Fb+fjaRAEiL6XAVr1glbkguKuWLgfnNUNXOts9vmtDuYbiVXiTxwUU8KxS4liQQYim6ttFovOjFztSqTa1HnJv9lw+N7Iz+RMAx8QCsyga5iealJgljEu2GR40cUUoiHeSM24ma3j/cJ7FJiZSvzECmX9w9biT/lNEG1GpJJL+FZEOb6ILk88BJNQPso6a/Sh1XO1kUTtbK7BAjIJ5KWIBKzDK2H1SyEmnLv7ttr1r/IolrU7QjjPIr4W9YEO7rkjJFiyRO7fFt4bs+KBl5hAjBdHkaijZBCKrAfZoxfhVhf7fzZafggYUcBw5WgPt8FUGcsYxCKSkEUS/e46LkR3OV+v0M0mB9LKopTZAbRlv86l6Twm4BZyumuMKpRXiHJOcvQPFiucUSEDkAf+AEOe15JgBAbdFrg8RiIkiPOryiyMDAzz1qTuR1WCJJ+e7veU04i6xySrhCZoRZ+S/5V7xvH/411oevRN6B/RVi1CovE1M0NVm52wehmo1nYzJ/j84MVgW5jxzeItTe4t+O4xMME9qdwnyB5BfrdKyEKBQZnmJOTXU8CJzhhNcwbLFQ24zGG4/JdO9q7ODyWJBP6kMeHGuSQ+AhESvRFqewvMRASWnX9544RsvQQROO5+CzxYtfS+9a5sCGm2lWVjkSOLCTDkijyntq38Gz55J+0VZshUq6wL4iih7SjbrP+1ABklpyIDMJITXWIP1cvjsW6bcy3sbW+BMkfPiuFbLgh0BRIO0EVGPNMrrkUglcRD7ldeP+NKasAHfu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199015)(6916009)(186003)(66446008)(8936002)(66556008)(26005)(64756008)(71200400001)(9686003)(86362001)(41300700001)(316002)(52536014)(478600001)(66476007)(82960400001)(4326008)(5660300002)(38100700002)(8676002)(10290500003)(38070700005)(122000001)(55016003)(7696005)(2906002)(6506007)(82950400001)(33656002)(83380400001)(76116006)(66946007)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/4xRnC+KBZ2zireITu454V7Z/tr/auAOMJlWFvvd7GTn7EaP028OTzbQx4?=
 =?iso-8859-1?Q?PLsY3pvrgeqDwQlAUKPflZ+5EnQ0mVxvEZlBVDuprcBVb3a48Bp+5LAvSW?=
 =?iso-8859-1?Q?DRovC0Ji2pvlvYl9/ZEwPobxpo2qvk7lpf0qKU4n8Y7pK38ReYqctp7ajt?=
 =?iso-8859-1?Q?6bnu2W1MBWmPBqrfErc60HP37bUSIZsnSuGJIXgXdRGkvnKF2zofof+Zjz?=
 =?iso-8859-1?Q?6bN8coCKXkyK47aw+h7xcYEPu9MVLUhJK88rkWEWCKFLTO3KpisALXXAwF?=
 =?iso-8859-1?Q?0eLi8nWHfJIpsm7LXUL/mbaEz+7ilXA/Z5XrrUuvog3XN6HuWrWR4peA90?=
 =?iso-8859-1?Q?3ez9bXP+r7ywGO7WXrJwDBay+Z3xj7wdVQ4W6V0VFsWwIW8iHqDcjI0cmP?=
 =?iso-8859-1?Q?vR3yczSQdfd+21Oca69a5nH/Vhs81mQaIQjjYoE0GBsXlzS/sU3MexG76g?=
 =?iso-8859-1?Q?bnhPw4/ODeE0z1/xsYaMtTXrei+UCDwiBnvtttGWPHrPvLWjgbKNJOb//h?=
 =?iso-8859-1?Q?Flj1YOErJlZCNNOAJg9ehRF0lqwUVBNP0rdHzajD/nfFePS2nMUqElxCFU?=
 =?iso-8859-1?Q?NrCXR1t7BCCDaj6ELGUYPaWTkcBNpa7e4J7cAPeIwFw1cg/m7DmlayvDRd?=
 =?iso-8859-1?Q?x2Q6aKKJYelFYUEYHDGd9zrKuOc/1UmTxtsFaCf7ZZ+8rtmAgKbeSX8orf?=
 =?iso-8859-1?Q?1dNhuSSNQXFz5AH73mE+QRM+nG49oi+y+Amn8emMWGgHUfU2hliztBTafg?=
 =?iso-8859-1?Q?ZD1BrdSsY42Rc0uXr6nkx8H2mtxWUUBSK88tfvk+qPdxXQ1RhkcJliL1sb?=
 =?iso-8859-1?Q?8omgAl4QddJ6q5u9EFIhRwop/MAGVqKCLSoQwmsjBGEXOZ+FzFdw8Xcx+2?=
 =?iso-8859-1?Q?z8JgKUP9qxmZnoIdSh1aAu8z+Q79ZbXek0o+svMXyxlhN/OtLWQPWXSWHr?=
 =?iso-8859-1?Q?OHbACTdKnHCgDLbt/eVybQFlM+E/WlgP0HPfZXd3C2HIGioy5X1zauN+c1?=
 =?iso-8859-1?Q?6+E2WpLhciR8UFibLkmAhuwsphTo5F4FJ1PxeHyFNxe/PxvaymaEUOvfQL?=
 =?iso-8859-1?Q?fpc3x5NT8UBios3RIwTQ1FQ0QyXPMWCYnQNwYTTDE7/aXh06XEfn9fwVTQ?=
 =?iso-8859-1?Q?3plPdQiCG6nmm7BNSSjxtighNQ96sRHy1PtFot5IrY21/t7D4QSe781GEM?=
 =?iso-8859-1?Q?ODjNwUN+5F5G1Y7nNuEOelsAExnLsGZ8bbjQNHEUmagRZ7HQaYUluO9cap?=
 =?iso-8859-1?Q?WBmQRaJQxTI4NhmG+QBJ+ZtiMtnxnOrIWG3wUFSTjzL7NGGynKzKQmkQ7K?=
 =?iso-8859-1?Q?/j+Qt8CYvw90YDMsSAgB/sxIrhvZWV1h6xJDmvFlOk63JKyRYqEuxQv34U?=
 =?iso-8859-1?Q?H+F+1Le014q1j86XnUDrhYSvcYZRwGYln7gQmAXO1kdQBYzbxHrm82pMCq?=
 =?iso-8859-1?Q?3EoB/6QkjZSgKSaMwNK6EBItZnufKmkjaRKczA9DrDpBO/FbwXQLmniOZs?=
 =?iso-8859-1?Q?yeg4p2sTs5JL8q6G8iF9Cy7GQMvwKiE//NpjAcu9A0IoECZkQoD5ZiWV0r?=
 =?iso-8859-1?Q?orU7XJ2AgJpXJMWhTMfQhWS4AlQr8wv3RotN2O0BsNJq6mUsJzyMQYjpW0?=
 =?iso-8859-1?Q?AGBqwfg8OlqO4F6OFxO5J44L6z3wqy5Ym939FQcw7FXA6jkcAH6H4xvA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3680
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Shung-Hsi Yu <shung-hsi.yu@suse.com> writes:
[...]
> > +imm
> > +=A0 integer immediate value
>=20
> Perhaps mention that imm is a _signed_ integer just like offset below?

Thanks, will add.

[...]
> > +``BPF_DIV`` has an implicit program exit condition as well. If
> > +eBPF program execution would result in division by zero,
> > +program execution must be gracefully aborted.
>=20
> As discussed in yesterday's session, there's no graceful abortion on
> division by zero, instead, the BPF verifier in Linux prevents division by
> zero from happening. Here a few additional notes:
>=20
> 1. Modulo by zero is also prevented for the same reason
[...]

Thanks, Daniel pointed that out too after the session so I am adding this i=
nfo.

> > +Helper functions are a concept whereby BPF programs can call into
> > +set of function calls exposed by the eBPF runtime.=A0 Each helper
> > +function is identified by an integer used in a ``BPF_CALL`` instructio=
n.
> > +The available helper functions may differ for each eBPF program type.
>=20
> While BPF ISA only supports direct call BPF_CALL[1], technically there is=
 an
> opcode 0x8d (BPF_JUMP | BPF_CALL | BPF_X) that has the indirect call
> semantic, and Clang emit such indirect call instruction if user attempt t=
o
> compile with -O0.
>=20
> I think it worth mentioning in this document for better clarity, perhaps
> simply saying that indirect call is not part of BPF ISA is enough.

Noted, will try to add something to that effect.

[...]
> > +0xc3=A0=A0=A0 0x00=A0 lock \*(uint64_t \*)(dst + offset) +=3D src=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 `Atomic
> operations`_
>    ^^^^
> The opcode should be 0xdb as well

Ack.

> Otherwise,
> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

Thanks,
Dave
