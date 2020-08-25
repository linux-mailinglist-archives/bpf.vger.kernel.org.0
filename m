Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB6D251D44
	for <lists+bpf@lfdr.de>; Tue, 25 Aug 2020 18:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgHYQdy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Aug 2020 12:33:54 -0400
Received: from mail-eopbgr70130.outbound.protection.outlook.com ([40.107.7.130]:25829
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbgHYQdx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Aug 2020 12:33:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxbJQ9LsGfF9ItS1KX6CXNgRAnfhtPVaKREGLdv/LC6JkoZaFq7vfpOG1+w0ePUaL48iFBZxGjWaETQjq8zFW1qMfxV/trSZxNpCj+YRR0gf0ZoP39nPQAMHgXzZqozw0/NEzx0VqFxrAd13rUAvnwFdaZsnnC6TyIfA9MHBCW45oolcEo8If8Jf56hYKJKWSHAKdHKFeNSRhH+AXXTXJBog8X1nT2AFPIRDu3cWa4KJDS/CV29XbSQnUO6fynSC97c6XMWccsCG0Dwvm6eBpMPpfle9jAWaTS24LSNIfFLqZfOw5e9eSgpAdW5eaRB14trk6CLTIOCvvdRoVFP8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bt4dVngVpt+ArpAMv47GiEhZQxx9dEfwIoLFiaRNnHs=;
 b=YHmlhFfFwK/jpCGPPFwq8+OypgoYSYSiMUSDc1XD0itZcEKFHWQNYznsH+gbkpodtBjfIODR9ioSekpaCDfobG6YAusAwkTUJKpi4rvVKvKwGppoaG+oToGOT88ZFGsiJBt277YtIbopciMyMLnsw1fskwdC1VeuQNvnQ3lWQlJ3XQdy9U5VTyuVvsR4cgOqrHYvT/aOFTkyM2WZyu5Ei1I9S3v2UUVZ261Fj6RlgByqPFG6fNdec909RAwh7qR8SZdWD69eyCLSlIKxM+OyNi/9ynpwRh1G0ehkDzeyzXXdys9GR9drfW5JWeGO6K3GeLfi1SbOP/HDLbnfRYAqkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bt4dVngVpt+ArpAMv47GiEhZQxx9dEfwIoLFiaRNnHs=;
 b=L6sDRMQ0cBt4TWULFeeZ5XCY31NkO39ZMl8/k8bc8Cx4lw/7dmZktoscHVRnORM9lLR+L8eEUZqW3coa38+TjADyZh+c7fdY2MFNwZI05kcUZFnJzOOGOZnncg3KVOBnK61irOu3U4uqx8/XovZvbrAY3UZ/9766wnmAzq6Z8Hk=
Received: from AM0PR83MB0275.EURPRD83.prod.outlook.com (2603:10a6:208:94::26)
 by AM0PR83MB0292.EURPRD83.prod.outlook.com (2603:10a6:208:9a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.4; Tue, 25 Aug
 2020 16:33:48 +0000
Received: from AM0PR83MB0275.EURPRD83.prod.outlook.com
 ([fe80::4dd5:3b7e:321f:b1bd]) by AM0PR83MB0275.EURPRD83.prod.outlook.com
 ([fe80::4dd5:3b7e:321f:b1bd%8]) with mapi id 15.20.3348.004; Tue, 25 Aug 2020
 16:33:48 +0000
From:   Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Clang | llc incorrect jumps
Thread-Topic: Clang | llc incorrect jumps
Thread-Index: AdZ6+BhyKlwHLo/hTjGCiXuCkGGBSQ==
Date:   Tue, 25 Aug 2020 16:33:48 +0000
Message-ID: <AM0PR83MB0275B96730F50564861C3C55FB570@AM0PR83MB0275.EURPRD83.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kesheldr@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-08-25T16:33:46.6355500Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1383c17b-5a62-47fa-8741-d626b920c8e2;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [149.12.0.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83cd779a-7dba-4a7e-aae4-08d84914a4dd
x-ms-traffictypediagnostic: AM0PR83MB0292:
x-microsoft-antispam-prvs: <AM0PR83MB0292C4A0D17E221EEDBE4EB6FB570@AM0PR83MB0292.EURPRD83.prod.outlook.com>
x-o365-sonar-daas-pilot: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +k6Dx8IeB7WA53N7cN66941+PZRS/4ZFays8/NDkXs4vkFrlpmvFTFNSJ/TWaUdZnIJQdkHwWR8FEvJK0QnObCHd2PxfjnoqxhbSuXVDTIc7zLLuo8gHOAi6I02DdUMfx7h7PkG5GI+x218DocHpF5vXYjfDGtwUVZ82gglmLAvnry9KMH1mM6iXM4hO8UtN8pzNuTzKhjJIJ9YWLNPE1XicnInpXuf1asznhwZX3P2xGTTTabM2nG113zyz4eNOqxV9EIZk/ix7nOeCr4m9K+TtJo66ElX/7CL1eo0Ut56uHuKPlU3WOxe4KAzOlJ30
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR83MB0275.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(478600001)(33656002)(6506007)(26005)(66556008)(64756008)(66446008)(66946007)(66476007)(316002)(9686003)(8990500004)(7696005)(86362001)(6916009)(83380400001)(82950400001)(82960400001)(8676002)(55016002)(186003)(76116006)(8936002)(5660300002)(2906002)(10290500003)(71200400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ebKK1NemmhBYBQaRigbBYjwlNY6LXCpBzFCDR3umTjN9DKzaLqNxKixEj57vJ/Dw5Tx29dHMOTRiBHf7ZCVqkH2Ji17iEKpFTLuTK4Yh1c459OiWQSxNXI8DsqIai6w2KYXXNBTHhWjNF2sLgkSjvOcI2LOVUP54L8Ev8cZrNdWmViuxlUdNp4ahwvdEAqcbL+WAOrljqEVYLEEJCWfCd379GVXL4E2quoxFGUZhW62M2FEEo2mz2FMY08Yix3aKOe187mvBQyy94Tk+HN7IiVaQ8UtJ2Xd/PMVGzXy4Xu8A5lrJ6rOzZ0EttzyjBBWRQY9/ziOGrXdF/po3AbQZgPsuvrsmswuoAlnrEiDKYKto4aTYKNGnIpG6u0fZV+wI9524d4WkaclKx1r4yOgvZ0LZaMWIDuONDSb6KpPZBuOPbbdFhRcALO1cH/TMEcCj80ZkFpzQvwTvVGEn7ZOBilYq8eA9PTN/FzodmLvuzNsyMgNsXf5ojLSpLmYF8M0ikvGJqTFjmBIysDlEnTNSJ376pQ6DJ2Hv9lYqemOh8itV8XXmDwup0Nz1w+kiiaGdMH45UvPPYoSFY8VTdI8u1EfAmFpwaO0/jKWdnZ5xWL1UVXCnhI3BrZ+Yxo1fkpV6BiZF9bqjge1J7ADvL3XLcA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR83MB0275.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cd779a-7dba-4a7e-aae4-08d84914a4dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 16:33:48.5210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oSegcYJl8KdGSsJc5E5tPSoJAnZk4VYlxNsGSIeGSa8BxdmIOiFgJ5YwuQs9uWHVJ3WgfYCVsrXLAx7+Qw08qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR83MB0292
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello

I've got some odd behaviour and I'd like to ask if anyone could spare a few=
 moments to offer suggestions of what my error might be?  Maybe there is a =
different mailing list that this would be more appropriate to send to?

I'm building a relatively complex eBPF program that attaches to the raw tra=
cepoints, sys_enter and sys_exit, compiled with clang and llc using the sam=
e switches and includes as the kernel samples (kernel v5.3 on ubuntu 18.04)=
, loaded using the latest libbpf git sources.  The sys_exit program is quit=
e big at 55045 instructions (unrolled loops so the same code will run on ke=
rnel v5.1) and contains illegal jumps.  Everything is inlined - using __att=
ribute__((always_inline)) - and the programs themselves have the __attribut=
e__((flatten)) applied.  The verifier complains:
jump out of range from insn 15 to -10500

If I remove one section of code, unrelated to where the illegal jumps are, =
reducing the overall size to 24480 instructions, the illegal jumps disappea=
r.  If I reenable that section of code and remove a different section of co=
de, also unrelated to the illegal jumps, reducing the overall size to 47444=
 instructions, the illegal jumps disappear again.

The illegal jumps look like (there are many, these are a sample):
      15:       if r0 =3D=3D 0 goto -10516 <LBB1_8987+0xfffffffffff7ffd0>
    1285:       goto -11827 <LBB1_8987+0xfffffffffff7fe88>
   54994:       goto +28205 <LBB1_8987+0x36ff0>

Note the first two jump to before the program and the final one jumps to af=
ter the program.  Elsewhere there are jumps to the actual label:
   47846:       if r3 =3D=3D r4 goto +7195 <LBB1_8987>

And the label itself is the last in the program and doesn't appear special:
LBB1_8987:
   55042:       r1 =3D *(u32 *)(r1 + 0)
   55043:       r8 +=3D r1
   55044:       r3 =3D r8
   55045:       goto -7149 <LBB1_5498>
<END OF CODE>

FYI, the code was dumped with:
llvm-objdump -S -no-show-raw-insn EBPF_OBJECT.o

In my limited understanding, it appears that the length of the code has som=
ehow tricked clang/llc into thinking there are codes fragment in illegal lo=
cations.  I'm not certain, but I believe these jumps are all related to exi=
t conditions.

Am I missing something?  Does anyone have any suggestions?  I can share the=
 entire codebase including the build process if that would help?

Many thanks for any help or interest you can offer,

Kevin Sheldrake

