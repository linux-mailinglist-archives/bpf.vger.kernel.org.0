Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F5127FD36
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 12:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbgJAKXA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 06:23:00 -0400
Received: from mail-eopbgr40122.outbound.protection.outlook.com ([40.107.4.122]:49652
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbgJAKXA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 06:23:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/XEyuBbj4h3DXToMqmxFtfAF9JxppXYgPsmB2GkC1RCdS+srGJ8WIqonFSdcYCZs/9pb1VxpRp0gRhdChZys2oFypV0KaBwXqMIaavhs/+OrDnGuJwJVkoGW2V6B8/4Ys10pQidaPC/u9/NXfVLB7wCLtGF6L9tb9WiOxXKQ3wEgV5RMp9sInMJQy7XSCSfnsklf9sGXe7d8ujsq4t8Fp95fWR3g9J4NLc7/AzDOjlFHgpJ3mozK8wfSNX51dOhOav9nZaS8ljUw98SGbjuZPA2U/IAsqRufPvUWdkwenI2JlsYZxwRm+8B4I6/kTosE2X2vHP0lPMCVkKGuO0J1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6alC3Uwt8TlYfzDLdQtCMLoUx36b3ayMS8Jq49ejdA=;
 b=Wkc6t4WCAp0QsOcZnaGVFJjKrxZt8GMtp5BCFmxtya0mT7YhLw8JbuPBfHA2epU1c9jbHHNXhbWiwbbffeoq07tdM/JWN6mCyZOnrW72G18pWrp72MgLKbhyFinHM2brmnJsWJzLHvGpCnNkx8khVd7fl5FnSlAziijNv+tRNgsAIf5hPRsv1Jj8D7gvfQJEopllWLdUSNsd9hDSCT+PrGAZoVOPXdndT1nn1wOsJnLnXvwW6Gko8GKbeI4QZ4xHYlEXkC3lq78sRaLXa53Ppmy6VFZDLCKNxzA4dFwttGkUz5fAJdF6qcoxz0rfqXLeLQVnEz9xtOKGXRkylgmzgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6alC3Uwt8TlYfzDLdQtCMLoUx36b3ayMS8Jq49ejdA=;
 b=PPlAt+ITGEAcWBTboX5qcDDWc8LkdKhBqIKQSjraAxxYnu+BrQ1Hy1OlPzVcNAlfVSwwCLGEjoX6sovRSgqHCmUKKEOF8ggm0GmNI6Hjk5gQJrw/2kP67IXcQJZTO4KV4VisrqZj4HeOM4CCr3UjhozXYxUn5PS7BHFBoSSABQo=
Received: from VI1PR83MB0254.EURPRD83.prod.outlook.com (2603:10a6:802:78::25)
 by VI1PR8303MB0095.EURPRD83.prod.outlook.com (2603:10a6:820:1b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.7; Thu, 1 Oct
 2020 10:22:57 +0000
Received: from VI1PR83MB0254.EURPRD83.prod.outlook.com
 ([fe80::ddc6:7443:478b:8514]) by VI1PR83MB0254.EURPRD83.prod.outlook.com
 ([fe80::ddc6:7443:478b:8514%4]) with mapi id 15.20.3433.037; Thu, 1 Oct 2020
 10:22:57 +0000
From:   Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: BTF without CONFIG_DEBUG_INFO_BTF=y
Thread-Topic: BTF without CONFIG_DEBUG_INFO_BTF=y
Thread-Index: AdaX253QAMQ5d8YuR4qajmYBYHeBJA==
Date:   Thu, 1 Oct 2020 10:22:56 +0000
Message-ID: <VI1PR83MB02542417DBEF45BBA9C90FF7FB300@VI1PR83MB0254.EURPRD83.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kesheldr@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-10-01T10:22:54.8050715Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fd7d8af8-e420-4cb2-91fd-c7eab57a6b1a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [149.12.0.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bc70a646-26df-49c9-81ff-08d865f3f72b
x-ms-traffictypediagnostic: VI1PR8303MB0095:
x-microsoft-antispam-prvs: <VI1PR8303MB00959FA471E0354FC8D5E67AFB300@VI1PR8303MB0095.EURPRD83.prod.outlook.com>
x-o365-sonar-daas-pilot: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ErPOrKp8aQFIHT8PQCge1BMJVoKOm4SNIwSZeAOITOGZ5ryNkJM3tr3LwMs7qmrOdjq/dbhEAe1KiAjxy723W5pwvPk0ollbmrw//AsBhqeC+hl6OwGxZk8YQ1ed3Av241i/vaBr4p5ycSQw7Pls/Q1CRSdrk0wWvHG4GVpmDPt5xs2m8Ka7Z1K0seYxyxirVjm5BB17ZuWvIHT+Q8vEOOXMryhm7Y6vX/wAYCLst8d2+FbXoiXtTl+kV4ziYvCCRQ6NX0Aa8+RUjvzFtia3YoZPdxc6hbEIVWHTpc86av2unBnGtheZ4a9Ak9zB+X3f+Bro6G0ijf+LCkXveSIprw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR83MB0254.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(55016002)(316002)(9686003)(76116006)(2906002)(8936002)(8676002)(6916009)(6506007)(10290500003)(478600001)(7696005)(33656002)(64756008)(5660300002)(186003)(26005)(66556008)(66446008)(66476007)(86362001)(52536014)(82950400001)(66946007)(71200400001)(8990500004)(83380400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 9E9hwtslsMNSUpNSKrH6Yi/AGfef3UUXnBSbaqUlCM1vUv8lOOZbVW7vU6xRUvU2KJjPNAt3lWSsD+U2JLnp+8npq6CL9IRTpGViLFiOkhRzZmamaFHXuzRiDX5fFRLwg/XxbPqbD14xTTDXjwsZEmKBAuzqnvJhTcH80mP0Sm8h9tgtwpsnOv3KkJHigBG97vtG7T7XbaEakXeXfBu74H3tEL6WJ+Bq9QczW7ygXzwkcqwFXtcc3FTwcQCGcCESOAKB40ucLs/3VAntshvDev59ASGpZ90LFVxPA/U+oFlq5ixjeE40ccjA54pKmku4hiVhyP1p8G2x0W4zVAxGQcZtjgJo3u0sq/IFc6s9nMXPB/hrthU1aerJYKRzYXLwiXc9IINJGKt6LGX+PbjFiVdg17YZF3MgBYG4RWF42H5IC4BeYGmL5G2Yd3c/fN94R0Du6igkck8AbPl3jzY8C2fPfFWzqYtdz/4vsBqphXryF++EjHesfl2dVn4H/s52/8LQWhEw2Q0hxrHpcqq8kYws/Hf4LEDRANqcepkxZinhcRyiLUIP0fEkLJEJKrX8W4Nv85uJ5XjuCU4NxspKmvXY9ydsI29GgHLJoq5AratifVcoXZktvkXBd2hRWejlT444zdeNDkio7Xw20xCz/g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR83MB0254.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc70a646-26df-49c9-81ff-08d865f3f72b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 10:22:56.8388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CWSrr/apt/MWVC/+6au3FoaMFDgs854tGDM3DBM+vleYIFJPw8LFYY96y/CbL7mDK7uXvkCFvFJj24mltrOEpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR8303MB0095
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello

I've seen mention a few times that BTF information can be made available fr=
om a kernel that wasn't configured with CONFIG_DEBUG_INFO_BTF.  Please can =
someone tell me if this is true and, if so, how I could go about accessing =
and using it in kernels 4.15 to 5.8?

I have built the dwarves package from the github latest and run pahole with=
 '-J' against my kernel image to no avail - it actually seg faults:

~/dwarves/build $ sudo ./pahole /boot/vmlinuz-5.3.0-1022-azure
btf_elf__new: cannot get elf header.
ctf__new: cannot get elf header.
~/dwarves/build $ sudo ./pahole -J /boot/vmlinuz-5.3.0-1022-azure
btf_elf__new: cannot get elf header.
ctf__new: cannot get elf header.
Segmentation fault
~/dwarves/build $ sudo ./pahole --version
v1.17

Judging by the output, I'm guessing that my kernel image isn't the right ki=
nd of file.  Can someone point me in the right direction?

Additionally, if this is possible, is there any documentation on the API so=
 I could incorporate the functionality into my own programs directly?

Thanks

Kev

