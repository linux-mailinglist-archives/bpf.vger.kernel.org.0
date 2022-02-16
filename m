Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C434B8EAE
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 17:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbiBPQ7P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 11:59:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbiBPQ7O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 11:59:14 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2132.outbound.protection.outlook.com [40.107.93.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A002A521C
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 08:59:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDw3mOwilZ9wk9LxC5xupHUc/oPuThoXh96hakaE4VCT3KNvhLTKiAJAsPZUqw14XZNO6Y8DFieCmydHAD1bhbZU1qrtdqhSBBiA7cK8bu05sV3Z+srcwl/iPzqAsidLK5VZkW9I1PvK95Z8Z7JPrDjddLietMebP/vl6HtmxVnXDewhJAJ6hVmpl4BkRX/BHtHKPcl2pn0Vhxdboj33za2KyqV17imNiaGcUXoy49gXi2Ej6Mg0zUJ75oYtvbrotovJs9YCn2NDLK8zIbP5onoK7foHdfUCM84NatowXBXMAqIR2ly7eH+6naiUkzYAig8xBhyYyToOqLvGzMdTXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81s0H8zBWUC2kifrCZHcIbUdI7w21KktchypbkS2L7A=;
 b=T+lquUPmD0H9E+C2UZbkOS2Y0F9ZYF70owgjjvNiR7xVtkvWtMOGjYkJAGNVpK2cwt/M18B0fl30G28BMqPoQFzhj7pPx65IT9kiN15+ItcrfeTPEybd+yeHhCaXLh4mt0iS//c8LbtuAKUe3pTc28W/e4IyV0Hc0CCeh+FFAoTEZzBka2znoSQ4BRyvq6lFlorDCn3U3cM9faLSIHyDelzD92/G/acgiu+gltRsYVc0HweHUjGz7M9qeh1on7ogMALMROBh/0GMBx6vCF3WidPRiHmA7H9EuMZ+uKWO3HRRLXAxynJPxn27um1nuqC8iZfD03PXXIgliWS3IoSzvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81s0H8zBWUC2kifrCZHcIbUdI7w21KktchypbkS2L7A=;
 b=h/s4cGcioNIKbjoVzWxnbnsoohasU4fAAomb9/jZXz8Kpay17uKdYNzFiEh6zdkTr1KQHXNk8Dy9Dvx/5foKqpCn70KAdBAX0+6RUfLQjYXUGmoxNEWE3A1C90GEhMhU5H1IQtRRFs1mAmntH+fyMCYj1p5WXF+zwOGTs8lXVQ0=
Received: from CH2PR21MB1430.namprd21.prod.outlook.com (2603:10b6:610:80::17)
 by BL0PR2101MB0994.namprd21.prod.outlook.com (2603:10b6:207:36::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.6; Wed, 16 Feb
 2022 16:59:00 +0000
Received: from CH2PR21MB1430.namprd21.prod.outlook.com
 ([fe80::712b:2bf0:e60a:189a]) by CH2PR21MB1430.namprd21.prod.outlook.com
 ([fe80::712b:2bf0:e60a:189a%7]) with mapi id 15.20.5017.009; Wed, 16 Feb 2022
 16:58:59 +0000
From:   Alan Jowett <Alan.Jowett@microsoft.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: libbpf API to extract bpf_line_info from a ELF file?
Thread-Topic: libbpf API to extract bpf_line_info from a ELF file?
Thread-Index: AdgjVX6ZJL3GV0ZdQc+O2BUmTTDo/A==
Date:   Wed, 16 Feb 2022 16:58:59 +0000
Message-ID: <CH2PR21MB143007E8EFAA83E15F5B1572FA359@CH2PR21MB1430.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8cd061fb-e595-4287-9d8c-0f40df857626;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-16T16:50:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6beb981a-0bee-461f-64a0-08d9f16da0b8
x-ms-traffictypediagnostic: BL0PR2101MB0994:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BL0PR2101MB09943025910655F20E0B80D5FA359@BL0PR2101MB0994.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qs/ATQ1vNBvWrkK3+VdBFYo+PwlOHnlIyIyJkdAi8XMFmOtPWvAc9dPUrBfnPdl2Kn4y6mNrFcN4XOJ6noRsrXyqV/rkhw5BZ7vE0H53fHdJF59NkWUuVE1YXLL4FAz2Q49Sn44lkxpILTlmEglpFMZk6b6zxsVD4UeXhESEQOltl6+m4d6pzK0/G6SdfXcpq+uv7PlHU24kEQ4z9JiJbBwVoH14xdLGD+kvVABAVF0BIf+Vc32OS/ZFW1aLtUy9GaDq3RF57dK+UK96PSL8M0fmkGpKIA5KewJWtztE1vTgGe+nMk0cZfgx/6ZazDuQcJVHL49KUFh5lU5v5YhwTTVnjIhx6OCAQQaeauIANTbL2qqlb1XgHYFHGqCAlaLyhgU38clk7lXH5JOwQtWbhbcxx/1qmyvB4JLZYCA0xGZXhwPqRQitWTs/zHLXhgz7C1M5YqFHVEVj1t3zjZPrYMfhThyoW4KQkjlVqOgoQpVmTqLMJ1huaUZiDNeTmby0uwrM1w9NNAu7+S+gIcnA8Oes19B3nGOYk8QXzQqpkZcjCchWqYHt9etYHk50LCmXNx1IiJql9zhr03OMdgX+Y7dwxgT0h0X9btY8DDD1786HV32S0QnfWOnxLLkYytjgxKlaUJw7KUZ0fYOyeoLeogyKBDJF2T1QgJP77EgGykdUBzbDm+wDuDVhSt0/EGXyqlrTa4JtLp3y+JecBiDTOnmC0V2cY327HA4ckihtKnSoV2u6mZfKIimXIodUOcHI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR21MB1430.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(66556008)(76116006)(6506007)(7696005)(66946007)(38100700002)(33656002)(66476007)(8676002)(66446008)(55016003)(10290500003)(71200400001)(38070700005)(64756008)(52536014)(122000001)(4744005)(186003)(2906002)(26005)(5660300002)(508600001)(83380400001)(82960400001)(8990500004)(8936002)(86362001)(110136005)(82950400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ngHRll7s6VTKqa2Ew7YT8uil04p2f4T6SvohO0vbqtt2rUlubfV2oiPrnZtc?=
 =?us-ascii?Q?WeWZQtGzc1ANnoDaFAC67pn1aaETnq+71G4huogsbayGixmVCyTqkG/MINGa?=
 =?us-ascii?Q?afk6xg1cy/fFLvCLk+EqwDODTtH5pvXTNDfmAIKwFopsSx4x0GczeoNHFDIo?=
 =?us-ascii?Q?uUB6bBZYwxctbHNSg1KEuQbrQe4fBd8vqWWcpcJzNuICGnX6VlljIG47+VMS?=
 =?us-ascii?Q?+DsLpqLHOFVp2IR9T3q5+jeIzpg8yZOwXo8dJ5ij3SWwmwD2JLKWnx9xkqex?=
 =?us-ascii?Q?W6ZMTsQV2BwXYvpoxO46Zgo8w+2KmkjAEgAFjx2y4XZ/TafPrLgGkyPhkBqf?=
 =?us-ascii?Q?8AXdNYwg8daPc6eIRu+5P7gz6zK1ydmb+nSg0Tk7qtDtp/siOJvbvW0mq60s?=
 =?us-ascii?Q?4XEkEugdNjFg9Rmb2+dzNW7rQ2urQ1FgSX7Pr0B2yRWldNT4vtZTVEjBcdFG?=
 =?us-ascii?Q?5l7QXTOHASxaHofdbwCFF59CJRuby7u1f+lzAo+wJBQUpjFu2AeHFq+Hl11S?=
 =?us-ascii?Q?NEl7t27ABjwD/4KTDinKQa63gCHtd9u/VOzqKs+cvXHRtk7YMbMy/GFaknFW?=
 =?us-ascii?Q?ZMFBioSvYdV3noYXDuvFEK8guAuoe6f64r+nh+t7YMX+Hibr6N5itPmjFuCf?=
 =?us-ascii?Q?n6uKilw6Yr5LhOcUKl3R5tcwTQXDEypHwGgqqlyMnCs0554X1c1+VyVWrFY6?=
 =?us-ascii?Q?+0uzRD6rst8uVOzabYQxP+ke9X9sODafUJ/9p7Vht5UjghS7oWhAJmFdV+wY?=
 =?us-ascii?Q?AFNDXtPvaKCl9HgQRui4I5s68pnnGnwdUXT4Qh7YNq1uwyl8LEz46U3khpWi?=
 =?us-ascii?Q?pq3tlHjMrE9oIiz0m/cKLUdxUbd0g7GzRYiesE6VMZ9Q2ZBYUbB4jC3Q2xrU?=
 =?us-ascii?Q?qvEFlhLKirsFR+QN8a3YTvTbmSrRH2FE1CVCZ5WddNTkqCq2XyD1PB4UfpaG?=
 =?us-ascii?Q?amokW6VTi/ybmaKtc7mUUUpSCwqPMzONbIso259iUoONvv2GdIM1DB7YSzPO?=
 =?us-ascii?Q?HD49lWwPKWz4/+EIglFjiUmSwQL+1/h7uZq1fIY8S9GCeBKxiC/T7gLOcP0R?=
 =?us-ascii?Q?3LPjhO0FV+UYr9cEsmOhKauvd8EjxUf1xlR+WhAHe6/trbOnCX6lpE1lcdvx?=
 =?us-ascii?Q?NKtiJh9nlMUcAhXBA5XAvKAkPSJvKDgdZIEczKCY+1ImfPYYPIIOncJL+UQ2?=
 =?us-ascii?Q?rNbZH1m2EITR/VdA1w+xrPTzX426JtCLuspYhNLZrvxQRp1hiFs7Sp9kt4YG?=
 =?us-ascii?Q?VUcNkxRM+xiiddABXuJqWghWNCxx8cPgUJyGPTthB6LmhaazmuNhAFtPgrGV?=
 =?us-ascii?Q?jboyBaRzw7pVgusfnzlSdA1nyAuGXGwWxTBpDB5/Rhq30QsZUIVtQ3IPuLsP?=
 =?us-ascii?Q?Tw7pkxwzyaylBj6U5lQc13GGdXVBDykMICla4k9oJCVV/JSax/KBG1lyU8e/?=
 =?us-ascii?Q?+UWb1frp3I001bULoPH79m1knNhTEVpNkyl5oTBKA0TZLf83ALPY9xgJAocq?=
 =?us-ascii?Q?CoNKxDXv/7SRLfA07JLedbN5QkS7m0EQse5D8aLXOXBCUsMiH8g5bX17z61M?=
 =?us-ascii?Q?m7RSutV/CjWRd7FqgdCDOUEYlkN+0i5o0cP2LNs88Uw4LfA89W0KjamjrOLu?=
 =?us-ascii?Q?Pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR21MB1430.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6beb981a-0bee-461f-64a0-08d9f16da0b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 16:58:59.8954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z+VUpzHxVL5JMpiHxEGC5HHZS+QZo8yJIe/lA2yzpkab/6J7npKFL38W50lcDj1rTko1bAUsAQ1Ylo2h/s11OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0994
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Libbpf folks,

Is there already an API or are there plans to add a supported API to extrac=
t bpf_line_info from an ELF file?=20

The closest I can find is:
LIBBPF_API LIBBPF_DEPRECATED("btf_ext__reloc_line_info was never meant as a=
 public API and has wrong assumptions embedded in it; it will be removed in=
 the future libbpf versions")
int btf_ext__reloc_line_info(const struct btf *btf,
                 const struct btf_ext *btf_ext,
                 const char *sec_name, __u32 insns_cnt,
                 void **line_info, __u32 *cnt);

But this is marked as deprecated.

Use case:
Prevail ebpf-verifier emits "pretty printed" BPF instructions in various us=
e cases (verification failure, dump of assembly, and others). I was plannin=
g on augmenting it so that it would also emit the file/line number to make =
debugging verifier failures easier for developers.

I ended up writing my own code to extract bpf_line_info from a .BTF and .BT=
F.ext sections, but ideally, I would want to use the parser in libbpf.=20

Regards,
Alan Jowett
