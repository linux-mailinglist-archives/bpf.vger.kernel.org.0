Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9CC5BEDBD
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 21:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiITT2O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 15:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiITT16 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 15:27:58 -0400
X-Greylist: delayed 945 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Sep 2022 12:27:48 PDT
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.56.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5744676463
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 12:27:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYyrqtjlxS8l/CW8xUq0RDtOSgHccgT++JwmK47lpO240iXsJNcs/uSDAtlQ6yy6aIoPmQVq7NKrktWVuV98me0JMtANImZf3P6FwPJ24rIQrNgfIPrWtCWYGFi6wvgAngfwD5Q77BbLvenCwv+Py5LC3hvj482MK/H3kuYEq6XWEwvIA0caMEJNPthSY3atpVuBxkGMydkanrwty/WLSxPhKbnKDACrh60EtUmCJYGDt8pCo1+/HWIe8k+5gxjQy3K3Texp8pQnYaTTSP2b3tKq/ppHKobxOCQVuE4gEz/S6jBfVk29d73UYeubRGwk/VQMJljq5Xf22Y8+vs1IzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aemtIa0Urx6DWSd2Qpnw0/3Qba0L6H9/8nt5Un5Qc0U=;
 b=aBIYOln6eUVrn3OHnxxQrooQI4d//84WsKP/0+P0J7LBJkCiO4HPilLTyBqWk1b85bqjhI4BUeweAieMAd6CqFy90+q4kybilxpRVirMSwQZifMXL/119sokEOBehdnofLAc0Q8F03mWB3efs3qsQJWik1E7NEy5FW1NZs5WkgmcQRX+JdTeFLRrJxtEvreBsT8nA1QUOSyQh2iRe9L4/xngK+gb/q5wFoMOadFIvxogaDmERz2LKoc2wbgI5yWijVvBiNnRy+gjiDVfp0q7J1/HUW8BlM278DQPsXvTYng3OUh/tB6a3F8Mt1dt3uXIhBrmON8QRmjYkwFksaUp4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aemtIa0Urx6DWSd2Qpnw0/3Qba0L6H9/8nt5Un5Qc0U=;
 b=UpQNG9ZIi4aUTBI60TFhX0Ls1J5ZgwzBTkYc8MXPVG/m84UK/9G8wbSo3yfwbAUlh6BoAbULHDisaZP916zc2rQU8/gKc1kmZGsBOIFgK3XWryuVdTCvIL4PxErWMkvvEiapW/BeRZ/tmDPiQ/Ml5JMeXjzcRO5Jg0vo2wB3A84=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 DS7PR21MB3268.namprd21.prod.outlook.com (2603:10b6:8:7c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.6; Tue, 20 Sep 2022 19:12:01 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5872:7dd2:2a86:c111]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5872:7dd2:2a86:c111%9]) with mapi id 15.20.5676.004; Tue, 20 Sep 2022
 19:12:01 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>
CC:     bpf <bpf@vger.kernel.org>
Subject: RE: FW: ebpf-docs: draft of ISA doc updates in progress
Thread-Topic: FW: ebpf-docs: draft of ISA doc updates in progress
Thread-Index: AdjEi0anVH25Go4YTCyzpO9wKsLa4gCvUITgAC54c4ABEdxTAAA2fB1g
Date:   Tue, 20 Sep 2022 19:12:01 +0000
Message-ID: <DM4PR21MB344020798F08A9D967E70719A34C9@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <CY5PR21MB377000AC95B475C47B702293A3439@CY5PR21MB3770.namprd21.prod.outlook.com>
 <DM4PR21MB34401314FC9285A9F5A338E0A3479@DM4PR21MB3440.namprd21.prod.outlook.com>
 <YyFzO205ZZPieCav@syu-laptop> <YyihFIOt6xGWrXdC@infradead.org>
In-Reply-To: <YyihFIOt6xGWrXdC@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1290af94-5dfb-4ec3-b457-ed7f6807aa3f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-20T19:04:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|DS7PR21MB3268:EE_
x-ms-office365-filtering-correlation-id: 88cf3507-03a2-4ddf-5e97-08da9b3bff64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /s0O0e4ZQp8HH4kL7U25A1y8JcbCbHgKv9HNPVvJ2/9UgPs1hH+WWABzarapyM9v5HLoE97yALqyWcE6dE14v5XLIGffv1JZeA7yOoyXaN1knhSDMwXDMoDXn1elYzf9+M5ywEOC0p1FBhjT2yDw9ie/CXAu6vO/ofL0ympMN+3hdocl/PmunGfHCNBWdD18J9LJv6TpmUETQVpweZkkCxn8ebMORCrU/5/5YDWAViTmqP5w3RL7Y5UCJnJCihivzJseI2NTnosa6LsWBZIrAszqdJ6MVlXfxZeTG37R74mKpg/ML1yrTJUH1rSGmMkYJ0h+nbNxW8TvhKi4vSDpz29JOB1pA26NZDj+Tszjf2KdvG7Eq4heLiR83AOqFV33b+2MD+btOx78+OH6U8RlZQtqNmdQml4z+JKL8bjdf1d3VdBUyEhYOO0zl2I/hkbLaz1vOECearb0ONuK15RTBZ5rRGlxJM/ajrhvOiKvGVL/HflbludXsO0F1b7Ooe9Vmqwqgh8G5GETzwrUYisv5IFD8TCts07j5aesh/RPercZUrntjEehUedrFIcnYzzA5/HfAXIh4Dk5kzqwUJpvv7tJFAPVSlT78jdxL0CpWEPTPhQ2z/7talrgLLwHZTQe9e8QLaRgXyuxToNY8Qxl/cXcljaBMa87QC1gvMb2bxukzrTtGyEqOlaEVizgBFtCpN04TRqp+oIy6ViEqD7U5o1to8uerWYWMNgTB98ma5wU/ervQ+Ukv/OxF2+Se6NjtlqQCR9fvR/e8+6PPtKe9zXz+vhryNI6wTn2d6DZULoVAX34AmQCPi0YC/LDHpQxrkXmvEyXJ0JhaNBINGrlpPUHlu5g05U8AHDA78/Zr+8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199015)(122000001)(82950400001)(82960400001)(83380400001)(38070700005)(38100700002)(6506007)(26005)(186003)(9686003)(7696005)(2906002)(15650500001)(53546011)(966005)(71200400001)(478600001)(10290500003)(316002)(66446008)(64756008)(76116006)(66946007)(66556008)(66476007)(86362001)(4326008)(8676002)(41300700001)(8936002)(33656002)(8990500004)(52536014)(5660300002)(110136005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4QitbEPkPXvbdkMBEwKcboDUp/M5Rm9zV9kSeN0akAAHWkFo6XST7uyTAo+q?=
 =?us-ascii?Q?szdJQ558kZA5uPZJRlPYOPVINVbM9Vs4rBaZ3v0KKe1BLE0eXGWeG29cYtz4?=
 =?us-ascii?Q?V8Ke3Dtd0TkpQbXhDXzl756CKZWY6vW6D4DKikRcPjHu6T672tvo6DTGN+w7?=
 =?us-ascii?Q?jqFKTMndIcjzQJEqKb5FM84RQKFi/cGslDCgDI7QX1pVQv013HOwMKkqNTR3?=
 =?us-ascii?Q?DsTx7r2e7H4KhyIFr3qpmW0rwCaNs2RuekoZmwGVmc5wrGJ2B8qSynppEcuA?=
 =?us-ascii?Q?N27/WkWD0eH6kVYcFLAFJBcJ5AVNtE3U05IZg4bfbALKKg068czyzYnS64Zv?=
 =?us-ascii?Q?6x3Tpj32YI0Re41i/8sJZTYii1olyUvWlKOODgvDR1etaZQ5GLAazt5QE8bM?=
 =?us-ascii?Q?gA2rurmGi+3whWAr9+VtcCF1qzx9ddK43tzluMufa/kc3OKXDWqNIhZl+zSA?=
 =?us-ascii?Q?e41dCDlgq2NxtS17dciPDupI/T5+/EZwGdK/rSdS7w1OIaxKx8vihuo2PDWH?=
 =?us-ascii?Q?VLzsdHWVomDy6rIIFKLyHrKQtKhZXcQ9aZ6uyhhIE8CfpioLZUXbGwGeTye7?=
 =?us-ascii?Q?YLfL+xWX7xYrTR8T6or4hPcuGwk/twHfOR7gzI5IZId+WeoBEFgvf3xjsw9P?=
 =?us-ascii?Q?Gg4DKmZb7cBJ1r0JXVmCPKPMLgQU/Li78cTWxZ+DwVsKrwhDcq6PR1/pblLo?=
 =?us-ascii?Q?Xn604rCn/e/G04KbBDNYZHmfej5Ln0FS1sE42L+cEFjUD/L6yM1HvnyNtrMA?=
 =?us-ascii?Q?5/p8eoeD35XkKVai36YIV1yIZmPWiXZCKynS3Oh8K54xXmx/ybDcpjDgpmQw?=
 =?us-ascii?Q?GhEkpM1XDaauxKAuauujoOrq/2ghwh3LMdK/CR0Yiwx/ZM1tw2HTGZJVZjR7?=
 =?us-ascii?Q?q2jZRWbnhGgEjTNaAfHkCG5uczyPO1gbv66Bo7tnRZknYyKFf3uRXr1KNwYF?=
 =?us-ascii?Q?E9JkEoNhyUTnwL24UbBODiiO1unutaoGAOKV06+0atS+Syt/UMxPM7no2pZM?=
 =?us-ascii?Q?CWkfDIeFnxYWoOthlXP7xJs1WkHbXwlYOJN8N/XL1yTGI1kcbecqYQo1eIh1?=
 =?us-ascii?Q?lsb3n+QCh0DKSZhOQe/kd+W9hY8SXdb5FimMaAzJK6krbR+GhNk90BIZP+kl?=
 =?us-ascii?Q?fEUQ+Glsrvm467PxOWgw2D3o5qOK619gog7iBPCSTdManM4xqJxVMWN5wA2H?=
 =?us-ascii?Q?iXwZYD2NEl33NYq3ZNFtGiLCvevo2GwJVdz/2Ve+jxbmlIHAy+03lT+uea3V?=
 =?us-ascii?Q?rlhsM8k8FPtcJX/Tg1i3TD0HbuHR7cjhsN3KfoKVjEHuQ1E33AF4odnww7gv?=
 =?us-ascii?Q?OtcA3AqNv8s8YCJfTfFA0O4g0qRDDWwbpTO8arzydKxDqjbHJ3S8DnIKd+la?=
 =?us-ascii?Q?nZbZnqHHH/PpyemzuGlX2LHmcij+WSfZsk5cuwWbsJ/hkDysKhwPYslajGwk?=
 =?us-ascii?Q?rleguATryTi/nyuhQ8X40H/5EcVFh+Z6WI1eX5fzgljaVXs1zJ44/5A6LI0Q?=
 =?us-ascii?Q?6xiJF3jk3+lm7DmqSlAwj9dSiaPRGE+ELgYRxm2wxjeK7HjWv9Musbpf503S?=
 =?us-ascii?Q?z/xUNl/yppiTivd+ncIlvRWulXrZnevhIkarecPTKqwiLqFnLdoMm6nATBHL?=
 =?us-ascii?Q?vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cf3507-03a2-4ddf-5e97-08da9b3bff64
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 19:12:01.6177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DEfgwASalZcp/E3mopiiy5OrMJHU2evj3WjqYHDsOqmNm2ylj6IYqIGt7GzT9ZTS6w/PQ62PY4GWfHVLO0mGeO5oyCW1OHPyoZNWU1IKv+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3268
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Monday, September 19, 2022 10:04 AM
> To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Cc: Dave Thaler <dthaler@microsoft.com>; bpf <bpf@vger.kernel.org>
> Subject: Re: FW: ebpf-docs: draft of ISA doc updates in progress
>=20
> On Wed, Sep 14, 2022 at 02:22:51PM +0800, Shung-Hsi Yu wrote:
> > As discussed in yesterday's session, there's no graceful abortion on
> > division by zero, instead, the BPF verifier in Linux prevents division
> > by zero from happening. Here a few additional notes:
>=20
> Hmm, I thought Alexei pointed out a while ago that divide by zero is now
> defined to return 0 following.  Ok, reading further along I think that is=
 what
> you describe with the pseudo-code below.

Based on the discussion at LPC, and the fact that older implementations,
as well as uBPF and rbpf still terminate the program, I've added this text
to permit both behaviors:

> If eBPF program execution would result in division by zero,
> the destination register SHOULD instead be set to zero, but
> program execution MAY be gracefully aborted instead.
> Similarly, if execution would result in modulo by zero,
> the destination register SHOULD instead be set to the source value,
> but program execution MAY be gracefully aborted instead.

And elsewhere in the doc defined gracefully aborted as:

> After execution of an eBPF program, register R0 contains the exit code
> whose meaning is defined by the program type, except that an exit code
> of -1 means the program was gracefully aborted.  That is, if a program
> is gracefully aborted for any reason, it means that no further instructio=
ns
> are executed, and a value of -1 is returned in register R0 to the caller =
of
> the program.

The problem with that, as Quentin pointed out, is that -1 is a valid return
code from some program types like TC.  Do we suddenly declare
uBPF etc as being non-compliant?  My preference is just to document
the issue, since such runtimes might choose to make -1 be a reserved
value for all program types they support.  After all the ISA does not
define program type details so they can use the ISA without TC etc.

> > While BPF ISA only supports direct call BPF_CALL[1], technically there
> > is an opcode 0x8d (BPF_JUMP | BPF_CALL | BPF_X) that has the indirect
> > call semantic, and Clang emit such indirect call instruction if user
> > attempt to compile with -O0.
> >
> > I think it worth mentioning in this document for better clarity,
> > perhaps simply saying that indirect call is not part of BPF ISA is enou=
gh.
>=20
> Which brings up another question:  Do we need a list of opcodes that
> someone else defined somewhere that are not considered valid eBPF?

That's what my document currently does, saying:

> Note that ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d), where the helper
> function integer would be read from a specified register, is not currentl=
y
> permitted.
>
>   **Note**
>
>   *Clang implementation*:
>   Clang will generate this invalid instruction if ``-O0`` is used.

The latest version can be viewed at=20
https://github.com/dthaler/ebpf-docs/blob/update/isa/kernel.org/instruction=
-set.rst
I can post another patchset after addressing any other comments.

Dave


