Return-Path: <bpf+bounces-5055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFB275456B
	for <lists+bpf@lfdr.de>; Sat, 15 Jul 2023 01:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48C528233D
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 23:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF93B2AB51;
	Fri, 14 Jul 2023 23:34:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804542C80
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 23:34:17 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CA612E
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 16:34:15 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 78E0EC151099
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 16:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689377655; bh=q4CfPWX9rL+TUU77PmfS2Mr0+IUKTi4fkeh2fDNATdg=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LBG1UWSVdaOBIOnCSptEfiOWOwoyisSTwELVC+b3WP03iP7RCD1aGIPoLsYXrNQyG
	 amI3kq5PTNzqoHwwBC8CXUNtugQdk6DPk//xoHRGtyfmddpTuNipsaxTt04HDJHmP3
	 PjNFD5pp5VrQt+D3TQmVeF46X22Rfp5Wn4/6y87I=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 66B31C14EB19;
 Fri, 14 Jul 2023 16:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1689377655; bh=q4CfPWX9rL+TUU77PmfS2Mr0+IUKTi4fkeh2fDNATdg=;
 h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=cGz0Rfyym3BlDiprqIO24bHfeoY9942ZAlMN1M1SyDEb+w9gbrHdVkWwoISsgr6F0
 kse5w7SSu4AfonUPhYgPTrT7/OY27V59p4dRvaML3FSoTn98Q1YQG/OSZXs7uMtFkh
 86OHPW2TmDgTz5DIWNpXhFvPnUi2173OPz633tTk=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 3FDFBC14EB19
 for <bpf@ietfa.amsl.com>; Fri, 14 Jul 2023 16:34:14 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.102
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=microsoft.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wpRiosLUE0Kb for <bpf@ietfa.amsl.com>;
 Fri, 14 Jul 2023 16:34:13 -0700 (PDT)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com
 (mail-centralusazon11020014.outbound.protection.outlook.com [52.101.61.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 732A9C14E515
 for <bpf@ietf.org>; Fri, 14 Jul 2023 16:34:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yq/3GwE0NKZxT5wdIu+lb0WI++wOyk8HqY2JBI03Coxua3mRZzqY5Zscl2NhpFIppK5KzOXLF882+ChwSVITTY051wqbKrNu/U8DZvru2v63ZZiv3rFkuxrISNhRan1tOmXWTQzyJY21FNCohue2xvQJPcKWGjeE/IQn8IcKIWdiT9ymBZAsgQi41OmzhSOTbUJFqZRSDHoPelRjAvF1EmQtCPI2B4M++3E2FdhNKn8DO21P8vNCiKg1UWhDljAxH4c1iH1t7lfVrvpHbrqfNP7f3i5NBjWMnvnAhiYew1aD3JFI7fxRhNxwWFbmSzuAs1rrDjoAOO32+TDclp0rkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/UlvbTu3IChnCX3BpLqWUyYZyIskSMjcCbiWwOdISA=;
 b=gYxnrcHzlsdmm6y1bM2w3g+atZDmgMi3Zz4GxGbgx6y4kbjrwg+av1+fO5WB2F9AJ+oDIZiSzcsplrZLuXTiK7Iyt0I4L7wgn66YqM9kiKmNi718Mfa0h3lJZn8nA9BPnKQE4xr9ZeT6yVbQulKPF6U47b/LhBqdOHXwaNso+e8FM4DJ0FBuqKYbhYTkz2LOHEqjioEKIrYTiJYgMAAWIVmNTPMuZgSl8dFHrFJSnAfC5grB8fSkzPMfqBDe9OnPj0oaZ84AyKcvxrH9yailSbv3c3E7xu82N9GJlDEb+t0MVhJpYAYldgdM09Y42hZuDPOIFyyrDLPWjZGk0wE1Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/UlvbTu3IChnCX3BpLqWUyYZyIskSMjcCbiWwOdISA=;
 b=Qkbx2utvE9FUVn0+Aw26550ORltgZQ9mN4OMDJnIz01gORad7t81LHP92jBN+sz2CQSFJmRdT385tCXdD0STWkbkwU5/kL5Eg9EHJprbidCnAqE9qOnn8Kt5V42S6g2bAaqrCRqTNvi0pEuzGbfQ4nopCYWfLg/aSbWZtvy45fM=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by BY1PR21MB3918.namprd21.prod.outlook.com (2603:10b6:a03:52a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.11; Fri, 14 Jul
 2023 23:34:11 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::2652:36f3:e0e1:a6f1]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::2652:36f3:e0e1:a6f1%3]) with mapi id 15.20.6609.015; Fri, 14 Jul 2023
 23:34:11 +0000
To: Yonghong Song <yhs@fb.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "bpf@ietf.org" <bpf@ietf.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Fangrui Song <maskray@google.com>, 
 "kernel-team@fb.com" <kernel-team@fb.com>
Thread-Topic: [PATCH bpf-next v2 15/15] docs/bpf: Add documentation for new
 instructions
Thread-Index: AQHZtVCtJfYai/KTlEmn0IofJHhKnK+57I5Q
Date: Fri, 14 Jul 2023 23:34:11 +0000
Message-ID: <PH7PR21MB3878E1F41C0CAEF3877BC077A334A@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <20230713060718.388258-1-yhs@fb.com>
 <20230713060847.397969-1-yhs@fb.com>
In-Reply-To: <20230713060847.397969-1-yhs@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0a893ca3-0720-4a33-840c-6234e68b49b3;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-14T23:33:28Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|BY1PR21MB3918:EE_
x-ms-office365-filtering-correlation-id: 74a2c748-1368-47e8-a918-08db84c2d38f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8KYbj00XI0ckqkjK9o3hnICjAuFJ00Aj1vQ+JCB7OsSb2778g7sao7NNRTakiIaKnR4h6gDw98RDKas2pjIo3kvxDHdCpE3dtu4bYxgIfqh3Yyy3Lpl7zkBLs94g01aHSw1ozRRxQ3SC+TYMqmGn8s3fp9yl8h2SCvxx8GjT9qgf6jPysG25rPLc4yDAlEcKolr5vJ9HSqFvSGnLMCShjokg+SRDI49VecT0vS16IpTwFhawfFNXrkn0vM+HpQi+wTIUuyMy0cfJDwhZmoGl/+uy3R4sqTfzhoME24MfeWKz5gPei9TIxMCe9VwVv6FpbGKQfrJsF+MjyE6Xc7MKZk3al9W161ZFxJ3eWuyw09gLbqwdfdgGXab5Epbsj8ZKvDRy7WLQS9Gh/kYPSHOV1k+h+pmAthMAAle+ChtuDTGiugqfvXDLVkI0Y6s47Y0DbCq02fFo0Z13O2XcjuScy5NQC+TKypnxQsim3VBBvnJOSvNO149V4zV/cG1Ki5dQu2fgfK4LKEeX8bJ+N7ou01Lq1rOZS6lLCYtdDHP5EF/Zf5TheDwmZYD774LU0ajRKBIXHD3LLN5Nnht9dgIRcy+xZ6vfKdy7M8XZcm80SgySLgTasUH5GjNeaT8W6rAmYTDKEG7r2w5YrvfrEUHsS8/8aPX91IwTPfad80wkGK4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:PH7PR21MB3878.namprd21.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199021)(9686003)(6506007)(53546011)(186003)(8936002)(86362001)(41300700001)(5660300002)(52536014)(8676002)(55016003)(122000001)(33656002)(4326008)(76116006)(82950400001)(82960400001)(54906003)(110136005)(316002)(38070700005)(66946007)(38100700002)(66476007)(64756008)(66446008)(66556008)(83380400001)(71200400001)(2906002)(7696005)(478600001)(10290500003)(8990500004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f2Nbl8bUbZwYFYcTJUyoWQ8WV/wGAjPz24Dw7bKGOk7Iy1Z4wd7ZE7HHWag7?=
 =?us-ascii?Q?BEm7rWRYa5Y1suunmkmPy694OPrqmwEcr5xICMIhu7o7ZokxbVvuINANs/om?=
 =?us-ascii?Q?396ucldzHRT0jwAygmt9D3aXtP97uazQWz/hAhc2FsSnC8M25rzuYTS8/uF3?=
 =?us-ascii?Q?cmGfNuwS0jERUSX3DNGHD019DPk4kBJR4OSOhU7Vv9Jagq+MdbZTlFATEO7w?=
 =?us-ascii?Q?+pWbejpfc3v+qt+BQbmpFFL82NuKdAU90s9o5mf2npt8kusanQCgqv2ZLIJO?=
 =?us-ascii?Q?jCPRpuadVwJdH7aQTDVZ8R1UYhiGaU3a+5j0sniSDfI3qFRWROvwRWPQTlfr?=
 =?us-ascii?Q?VcsR2hKi9eWnaX4UHlUg+L3eTmHb2LAEe8i6gH2AIaH8LfQKcIdftZvwhrNW?=
 =?us-ascii?Q?egkAXqbOqMVG2aBDHDmxIqKWoULXebhn1duC5WHqywZA/S2oxM6tMu0J0BhM?=
 =?us-ascii?Q?u1QDbqmb1z1AaWaBjGYM28wx+agWarfgVo+B8HQeCNN+G4NQR3vj4pKd4Jpx?=
 =?us-ascii?Q?lI0yPZib8uyQ4KhiKFs2YSTr8jfRBsYCL2BYfoCDYa1JisSrRWs+ReU/rYh9?=
 =?us-ascii?Q?SyW8DRvesOjrhoSLSPi7Y50tkPVimiS9y+gNuxXYkOy22mcAFCAWjYmKEbxK?=
 =?us-ascii?Q?QUZK0l4uAyUgK6x9uULGMHimQqXCUV8JJO35UqFARVI/TdK/v0qrwEMs7Zsq?=
 =?us-ascii?Q?VBIXfPy3c9/ljlGs7AzPzUUga7XxZofjsp2yU5vDMiU5tKOV6kxh1yYIHfRu?=
 =?us-ascii?Q?c1a4ZlZqmhuRJA/DX1eJHmokc/JVE2PStthq/VymPIF1p+qlnMGnlGKncYtZ?=
 =?us-ascii?Q?a0Ex7qrxT2MJnXdhpNalKaOZ/K1lOTLbhxWnDlqVUAzOIVaHMB9FantWnlsm?=
 =?us-ascii?Q?NjIjy3eIqW7yVmnqeqP0E7JTzmomysTvpxP2IiwhYXfGvwRd3N5LJ1RueTxY?=
 =?us-ascii?Q?uvU6wJAEPJqFtlx9yCzs6ri2enp9CGf8DtzE6XpI3MvWoDLMU5vXdbvcWrGX?=
 =?us-ascii?Q?zYkQp5mNlAyQ1BlPJcGWFBfqUcpuFXRYQQ5dLWipmHMG388UIQlfR3p2PLp4?=
 =?us-ascii?Q?XdLW9UPwI/LzRhfV3/Hw8xU3bI1xzYy3Uo3f5itM/sKg92Z1/Ais8pbTGHoH?=
 =?us-ascii?Q?9H4p3cjUsg8bzYl2ihBD3IzXXYM6yV1hM5vpf4J+qOAAI7hDpzgJKzXBWZks?=
 =?us-ascii?Q?Qs16COQjO0XmyRt4+lNA6B+c4CSVOBMLdsl83chOCEjGVj+lVtmBdYS9LDcB?=
 =?us-ascii?Q?9ivbVtRf4s/AN1lq/g4BlPFezVBa99BaBmtXmRGifSGCLn0ZpYi/iZ7t/G6P?=
 =?us-ascii?Q?ciuCvvNpf9LY07xNLTivN/9eN3S0Sti4k4kssYOYBu8hlmI6GbKstCtGirtl?=
 =?us-ascii?Q?OXhXr2QsKPCLgTnSeaoYdNZkhmNz5QjbeAmO6g0gPzUQ1LF1YcNNRjb/xsej?=
 =?us-ascii?Q?4JkGRE7k4sJcpmhvzsVaGRh7phA11nlxz1E7MhDvbI3sZSREBf7WKZdsH+39?=
 =?us-ascii?Q?vbeRfC5jpWFxNDDRNr9Oki5BY5sK3HEr/plVkm+aAICyMNAqC5Q9Gy4PymCB?=
 =?us-ascii?Q?p6pT0FC3+XDpp9rOub2Vt8/q9TtvKW/Tl4NhCosiu6oPTSniQFZBeITYQ2/b?=
 =?us-ascii?Q?TMfkKZTzdWzgSLpsdosdAJdXR1MJ0xK7eRcmzMMkH2Tb?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a2c748-1368-47e8-a918-08db84c2d38f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 23:34:11.0924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bzl7Nz99tSM5zyHurRkS08Hkjm1ZVEqjK+NJGwRfVgDbYWpWnCSTRLiBw88avkiUJVtFowoodPUT25RXf6OUd9PHL0V4DJtbBELOSL2KCb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB3918
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/LMVXFNkZ682Rrg0i2GF1xJvDb2E>
Subject: Re: [Bpf] [PATCH bpf-next v2 15/15] docs/bpf: Add documentation for
 new instructions
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Dave Thaler <dthaler@microsoft.com>
From: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Yonghong Song <yhs@fb.com>
> Sent: Wednesday, July 12, 2023 11:09 PM
> To: bpf@vger.kernel.org
> Cc: Alexei Starovoitov <ast@kernel.org>; Andrii Nakryiko
> <andrii@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>; Fangrui
> Song <maskray@google.com>; kernel-team@fb.com
> Subject: [PATCH bpf-next v2 15/15] docs/bpf: Add documentation for new
> instructions
> 
> Add documentation in instruction-set.rst for new instruction encoding and
> their corresponding operations. Also removed the question related to 'no
> BPF_SDIV' in bpf_design_QA.rst since we have BPF_SDIV insn now.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  Documentation/bpf/bpf_design_QA.rst           |   5 -
>  .../bpf/standardization/instruction-set.rst   | 100 ++++++++++++------
>  2 files changed, 66 insertions(+), 39 deletions(-)
> 
> diff --git a/Documentation/bpf/bpf_design_QA.rst
> b/Documentation/bpf/bpf_design_QA.rst
> index 38372a956d65..eb19c945f4d5 100644
> --- a/Documentation/bpf/bpf_design_QA.rst
> +++ b/Documentation/bpf/bpf_design_QA.rst
> @@ -140,11 +140,6 @@ A: Because if we picked one-to-one relationship to
> x64 it would have made  it more complicated to support on arm64 and other
> archs. Also it  needs div-by-zero runtime check.
> 
> -Q: Why there is no BPF_SDIV for signed divide operation?
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -A: Because it would be rarely used. llvm errors in such case and -prints a
> suggestion to use unsigned divide instead.
> -
>  Q: Why BPF has implicit prologue and epilogue?
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  A: Because architectures like sparc have register windows and in general diff
> --git a/Documentation/bpf/standardization/instruction-set.rst
> b/Documentation/bpf/standardization/instruction-set.rst
> index 751e657973f0..367f426d09a1 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -154,24 +154,27 @@ otherwise identical operations.
>  The 'code' field encodes the operation as below, where 'src' and 'dst' refer  to
> the values of the source and destination registers, respectively.
> 
> -========  =====
> ==========================================================
> -code      value  description
> -========  =====
> ==========================================================
> -BPF_ADD   0x00   dst += src
> -BPF_SUB   0x10   dst -= src
> -BPF_MUL   0x20   dst \*= src
> -BPF_DIV   0x30   dst = (src != 0) ? (dst / src) : 0
> -BPF_OR    0x40   dst \|= src
> -BPF_AND   0x50   dst &= src
> -BPF_LSH   0x60   dst <<= (src & mask)
> -BPF_RSH   0x70   dst >>= (src & mask)
> -BPF_NEG   0x80   dst = -src
> -BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst
> -BPF_XOR   0xa0   dst ^= src
> -BPF_MOV   0xb0   dst = src
> -BPF_ARSH  0xc0   sign extending dst >>= (src & mask)
> -BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_
> below)
> -========  =====
> ==========================================================
> +========  =====  ============
> ==========================================================
> +code      value  offset value  description
> +========  =====  ============
> ==========================================================
> +BPF_ADD   0x00   0             dst += src
> +BPF_SUB   0x10   0             dst -= src
> +BPF_MUL   0x20   0             dst \*= src
> +BPF_DIV   0x30   0             dst = (src != 0) ? (dst / src) : 0
> +BPF_SDIV  0x30   1             dst = (src != 0) ? (dst s/ src) : 0
> +BPF_OR    0x40   0             dst \|= src
> +BPF_AND   0x50   0             dst &= src
> +BPF_LSH   0x60   0             dst <<= (src & mask)
> +BPF_RSH   0x70   0             dst >>= (src & mask)
> +BPF_NEG   0x80   0             dst = -src
> +BPF_MOD   0x90   0             dst = (src != 0) ? (dst % src) : dst
> +BPF_SMOD  0x90   1             dst = (src != 0) ? (dst s% src) : dst
> +BPF_XOR   0xa0   0             dst ^= src
> +BPF_MOV   0xb0   0             dst = src
> +BPF_MOVSX 0xb0   8/16/32       dst = (s8,16,s32)src
> +BPF_ARSH  0xc0   0             sign extending dst >>= (src & mask)
> +BPF_END   0xd0   0             byte swap operations (see `Byte swap
> instructions`_ below)
> +========  =====  ============
> +==========================================================
> 
>  Underflow and overflow are allowed during arithmetic operations, meaning
> the 64-bit or 32-bit value will wrap. If eBPF program execution would @@ -
> 198,11 +201,19 @@ where '(u32)' indicates that the upper 32 bits are
> zeroed.
> 
>    dst = dst ^ imm32
> 
> -Also note that the division and modulo operations are unsigned. Thus, for -
> ``BPF_ALU``, 'imm' is first interpreted as an unsigned 32-bit value, whereas -
> for ``BPF_ALU64``, 'imm' is first sign extended to 64 bits and the result -
> interpreted as an unsigned 64-bit value. There are no instructions for -signed
> division or modulo.
> +Note that most instructions have instruction offset of 0. But three
> +instructions (BPF_SDIV, BPF_SMOD, BPF_MOVSX) have non-zero offset.
> +
> +The devision and modulo operations support both unsigned and signed
> flavors.
> +For unsigned operation (BPF_DIV and BPF_MOD), for ``BPF_ALU``, 'imm' is
> +first interpreted as an unsigned 32-bit value, whereas for
> +``BPF_ALU64``, 'imm' is first sign extended to 64 bits and the result
> +interpreted as an unsigned 64-bit value.  For signed operation
> +(BPF_SDIV and BPF_SMOD), for both ``BPF_ALU`` and ``BPF_ALU64``, 'imm'
> is interpreted as a signed value.
> +
> +Instruction BPF_MOVSX does move operation with sign extension. For
> +``BPF_ALU`` mode, 8-bit and 16-bit sign extensions to 32-bit are
> +supported. For ``BPF_ALU64``, 8-bit, 16-bit and 32-bit sign extenstions to
> 64-bit are supported.
> 
>  Shift operations use a mask of 0x3F (63) for 64-bit operations and 0x1F (31)
> for 32-bit operations.
> @@ -210,21 +221,23 @@ for 32-bit operations.
>  Byte swap instructions
>  ~~~~~~~~~~~~~~~~~~~~~~
> 
> -The byte swap instructions use an instruction class of ``BPF_ALU`` and a 4-bit
> -'code' field of ``BPF_END``.
> +The byte swap instructions use instruction classes of ``BPF_ALU`` and
> +``BPF_ALU64`` and a 4-bit 'code' field of ``BPF_END``.
> 
>  The byte swap instructions operate on the destination register  only and do
> not use a separate source register or immediate value.
> 
> -The 1-bit source operand field in the opcode is used to select what byte -
> order the operation convert from or to:
> +For ``BPF_ALU``, the 1-bit source operand field in the opcode is used
> +to select what byte order the operation convert from or to. For
> +``BPF_ALU64``, the 1-bit source operand field in the opcode is not used.
> 
> -=========  =====
> =================================================
> -source     value  description
> -=========  =====
> =================================================
> -BPF_TO_LE  0x00   convert between host byte order and little endian
> -BPF_TO_BE  0x08   convert between host byte order and big endian
> -=========  =====
> =================================================
> +=========  =========  =====
> =================================================
> +class      source     value  description
> +=========  =========  =====
> =================================================
> +BPF_ALU    BPF_TO_LE  0x00   convert between host byte order and little
> endian
> +BPF_ALU    BPF_TO_BE  0x08   convert between host byte order and big
> endian
> +BPF_ALU64  BPF_TO_LE  0x00   do byte swap unconditionally
> +=========  =========  =====
> +=================================================
> 
>  The 'imm' field encodes the width of the swap operations.  The following
> widths  are supported: 16, 32 and 64.
> @@ -239,6 +252,10 @@ Examples:
> 
>    dst = htobe64(dst)
> 
> +``BPF_ALU64 | BPF_TO_LE | BPF_END`` with imm = 16 means::
> +
> +  dst = bswap16(dst)
> +
>  Jump instructions
>  -----------------
> 
> @@ -249,7 +266,8 @@ The 'code' field encodes the operation as below:
>  ========  =====  ===  ===========================================
> =========================================
>  code      value  src  description                                  notes
>  ========  =====  ===  ===========================================
> =========================================
> -BPF_JA    0x0    0x0  PC += offset                                 BPF_JMP only
> +BPF_JA    0x0    0x0  PC += offset                                 BPF_JMP class
> +BPF_JA    0x0    0x0  PC += imm                                    BPF_JMP32 class
>  BPF_JEQ   0x1    any  PC += offset if dst == src
>  BPF_JGT   0x2    any  PC += offset if dst > src                    unsigned
>  BPF_JGE   0x3    any  PC += offset if dst >= src                   unsigned
> @@ -278,6 +296,10 @@ Example:
> 
>  where 's>=' indicates a signed '>=' comparison.
> 
> +Note there are two flavors of BPF_JA instrions. BPF_JMP class permits
> +16-bit jump offset while
> +BPF_JMP32 permits 32-bit jump offset. A >16bit conditional jmp can be
> +converted to a <16bit conditional jmp plus a 32-bit unconditional jump.
> +
>  Helper functions
>  ~~~~~~~~~~~~~~~~
> 
> @@ -320,6 +342,7 @@ The mode modifier is one of:
>    BPF_ABS        0x20   legacy BPF packet access (absolute)   `Legacy BPF
> Packet access instructions`_
>    BPF_IND        0x40   legacy BPF packet access (indirect)   `Legacy BPF Packet
> access instructions`_
>    BPF_MEM        0x60   regular load and store operations     `Regular load and
> store operations`_
> +  BPF_MEMSX      0x80   sign-extension load operations        `Sign-extension
> load operations`_
>    BPF_ATOMIC     0xc0   atomic operations                     `Atomic operations`_
>    =============  =====  ====================================
> =============
> 
> @@ -354,6 +377,15 @@ instructions that transfer data between a register
> and memory.
> 
>  Where size is one of: ``BPF_B``, ``BPF_H``, ``BPF_W``, or ``BPF_DW``.
> 
> +The ``BPF_MEMSX`` mode modifier is used to encode sign-extension load
> +instructions that transfer data between a register and memory.
> +
> +``BPF_MEMSX | <size> | BPF_LDX`` means::
> +
> +  dst = *(sign-extension size *) (src + offset)
> +
> +Where size is one of: ``BPF_B``, ``BPF_H`` or ``BPF_W``.
> +
>  Atomic operations
>  -----------------
> 
> --
> 2.34.1
> 

Adding bpf@ietf.org to the To line since this is proposing a chance to the ISA draft.

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

