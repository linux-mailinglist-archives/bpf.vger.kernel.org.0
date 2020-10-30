Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F153D2A0506
	for <lists+bpf@lfdr.de>; Fri, 30 Oct 2020 13:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgJ3MI2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Oct 2020 08:08:28 -0400
Received: from mail-eopbgr150113.outbound.protection.outlook.com ([40.107.15.113]:36366
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726519AbgJ3MI2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Oct 2020 08:08:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2hR8vgkN72shuSOJayCGpIoCaqI/szlD+90tz15oLykAyF2BCAX/nS5W0PAlsrFo11XbQN1r+stTYgXR8VBGqOYK1QRDvwMlQ/CvqNNU/bBWShjodFvjhmMli3cbZmNFr8T0tHnRsina2sVxNEEhbMa5tv0CPM9tLDXSMoGWvamw+gqlONWd6Stll0UitszUoGJUIMXUp+HsUFDQaGxiM5NpNdwfiaLLzL4wVOIDfhHfHwg6d9ld02aH0qNwKny7ebHaIO/xQVrBp+nlm4Oi2x5E9NAeD8BjW6fFZ80exuVSgWYNS2mEFLFOkPGoDaO5iSKwMIfrOwuMF2QgJsL/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsavJvg5npk+jK0woA1MBQiCy5B58vVQbSUoxYPlhuI=;
 b=S/sl1uCa5cebsqmf+TESQqGIJ17AATtzuOL2yuBOjx2iaURplHaWkjggyR1REUVjyx8cEIlrskyoUrXzwmftJ9xU9yhfQD0+M3epS4Z+xZ0EZzHZHoJvfv4IcdJlXehY4x0ROXtbNhD0Tc7Fj1RknzErFlMBkLTmBMZiusPoyqSr+9K40CzfrXDbVhx2PGChXD6zD1GWliCnHOVxUbjECt4e60SMPPcpuqKbPruQ0HQQb3AAj/X28i+4+7C0iP7W3LUBucowspLuAT1SxwPZ2qWbzbENUtf7A0vcGqCQnTNPs6K9P8FiKLsbpZut8r6xanPpZLrVV8yt25JNF6ufKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsavJvg5npk+jK0woA1MBQiCy5B58vVQbSUoxYPlhuI=;
 b=PMBmg8egPEy6/u8Ru0gD/srsrOrTYtqyl7tK1Jujj9BeRzvZJkcpX1yZIwBSs96/c+qWDKm5BGDVD0yLhZvNYeEC53xOg+p2RLzqbTXFmCJdgAhrPpQPa3lGo7A/Fwuz5Y2bN11Fm5APM84knYRUMNglWdzy5pbORmxpyb2+CtI=
Received: from VI1PR8303MB0080.EURPRD83.prod.outlook.com
 (2603:10a6:820:1b::23) by VI1PR83MB0333.EURPRD83.prod.outlook.com
 (2603:10a6:802:3b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.7; Fri, 30 Oct
 2020 12:08:19 +0000
Received: from VI1PR8303MB0080.EURPRD83.prod.outlook.com
 ([fe80::c857:1a78:d155:fc99]) by VI1PR8303MB0080.EURPRD83.prod.outlook.com
 ([fe80::c857:1a78:d155:fc99%10]) with mapi id 15.20.3541.007; Fri, 30 Oct
 2020 12:08:19 +0000
From:   Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@google.com>
Subject: [PATCH bpf-next] bpf: update verifier to stop perf ring buffer
 corruption
Thread-Topic: [PATCH bpf-next] bpf: update verifier to stop perf ring buffer
 corruption
Thread-Index: AdautGZ4+1YSnWihRZa8ESQSP7NSdQ==
Date:   Fri, 30 Oct 2020 12:08:19 +0000
Message-ID: <VI1PR8303MB008003C9E3B937033A593C47FB150@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kesheldr@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-10-30T12:08:17.4323933Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c00ceaae-cd6b-42aa-8f23-a340a3b8d3a1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [149.12.0.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63d1f721-2a42-4098-ddc3-08d87ccc7d90
x-ms-traffictypediagnostic: VI1PR83MB0333:
x-microsoft-antispam-prvs: <VI1PR83MB0333A6858480C34C89985886FB150@VI1PR83MB0333.EURPRD83.prod.outlook.com>
x-o365-sonar-daas-pilot: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KSRAhUdArSp6qMYyCVsyo2kIPwbSQBrQ1/PyzrUBGEsJwdrKU9baXgc15EJWpWfLAWaU5xMschRtR7yOQ2KtOQV8MbCEf8/YroTMH9FzGSvITzI8SKt7GzrGeLCy+b3JUGFoGqcl5qDDnRxhUkoiDx0YxU1c6Ls9f0+ksqt4UH064ys5PTvu3n8VlvzKim4WtpuXd1wM6lCOSIGYriU2bBj2bPVybJCfN+5m8el7o67ODwYiX7z3buOI50/xLYwUH778rr4e/HYQyY0kjYBEpOmKcMchyQ4nh1Lyf3sNIOL44Aubwig0OM+8vm59+UhclXl7O6xzYdTb37NaYmv7RQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR8303MB0080.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(26005)(33656002)(55016002)(9686003)(7696005)(4326008)(8936002)(8676002)(6506007)(86362001)(8990500004)(6916009)(2906002)(186003)(52536014)(478600001)(54906003)(82960400001)(83380400001)(82950400001)(76116006)(5660300002)(66556008)(66476007)(66446008)(64756008)(10290500003)(71200400001)(66946007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bDfYRXHItrQodpoOjhpKhguEe4U5b3VJen/FVCk4YpmeIhbU0SHKpI5+xFuFj4S8KJoxeBV4Z2nejgupR4EtoyTVuBR1ym4+nPt0QgAutiHqnx1cwyzg85KbU+Sy8m5rimZeT46sBJpffG2SR49knxDKWRtO6emWjFbwrM8XIGc8dCfyWv9yvnvRe+J0zvjNYRIke7swJ0oc07ApHd3phL2ue4B4k3ndOw2HbnqKAvbucMuFzyRrymi6cJ9gX4VxXU+R/y9o408uvD+ZU3TnXnBSlv2a/2GG/AJVta5tq+4/fQEIUMsdfQ0YP85pAYkXHUYdhivwji0U4rZ8r0pdp1fxgWMVGAJ+/qdpiouR2cixBXDoGNb98XbEjfxlUBkwtLy9uzQBvGP47wk7l8gofQ9Q+JH8rCNSFdMDVMi48eGGGMyLtLjDDAIu7yhO07JX2r70CqC0aNopL494z1wrZEMwDCoDP0OrCMDlautnQuSgqKOceCS2S1KsZ3cY71OlbdTd/tWnM5PvBajRigSizeDkfQm/8m4wyS5S2tw3iNbRMCRLtnkGhWnsgEQg2AsLRa1ZgrfJMBOMEnLCApeTnwWtWfgPraiIet0fNVCHohHC7nA9uMxXpPW/FUBxRNqvMk2XkhIIEGUP/4C+tcd2vA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR8303MB0080.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d1f721-2a42-4098-ddc3-08d87ccc7d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 12:08:19.1545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aa4ahDsPPQQngqZqlv3/K7VIlsN7leHuSPxE705NX8IAY+9O4tjqpQqfBJBkaGZR0rUiVEcDk8UiywLKo4I0mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR83MB0333
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As discussed, bpf_perf_event_output() takes a u64 for the sample size param=
eter but the perf ring buffer uses a u16 internally.  This results in overl=
apping samples where the total sample size (including header/padding) excee=
ds 64K, and prevents samples from being submitted when the total sample siz=
e =3D=3D  64K.

This patch adds a check to the verifier to force the total sample size to b=
e less than 64K.  I'm not convinced it is in the right place stylistically,=
 but it does work.  This is the first patch I've submitted to this list so =
please forgive me if I'm doing this wrong, and let me know what I should ha=
ve done.  Also I don't know what the size reduction of -24 relates to (it d=
oesn't match any header struct I've found) but it was found through experim=
entation.

Thanks

Kevin Sheldrake

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e83ef6f..0941731 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -18,6 +18,13 @@
  */
 #define BPF_MAX_VAR_SIZ        (1 << 29)

+/* Maximum variable size permitted for size param to bpf_perf_event_output=
().
+ * This ensures the samples sent into the perf ring buffer do not overflow=
 the
+ * size parameter in the perf event header.
+ */
+#define BPF_PERF_RAW_SIZ_BITS sizeof(((struct perf_event_header *)0)->size=
)
+#define BPF_MAX_PERF_SAMP_SIZ ((1 << (BPF_PERF_RAW_SIZ_BITS * 8)) - 24)
+
 /* Liveness marks, used for registers and spilled-regs (in stack slots).
  * Read marks propagate upwards until they find a write mark; they record =
that
  * "one of this state's descendants read this reg" (and therefore the reg =
is
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6200519..42211d4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4997,7 +4997,7 @@ static int check_reference_leak(struct bpf_verifier_e=
nv *env)
 static int check_helper_call(struct bpf_verifier_env *env, int func_id, in=
t insn_idx)
 {
        const struct bpf_func_proto *fn =3D NULL;
-       struct bpf_reg_state *regs;
+       struct bpf_reg_state *regs, *reg;
        struct bpf_call_arg_meta meta;
        bool changes_data;
        int i, err;
@@ -5054,6 +5054,15 @@ static int check_helper_call(struct bpf_verifier_env=
 *env, int func_id, int insn
                        return err;
        }

+       /* special check for bpf_perf_event_output() size */
+       regs =3D cur_regs(env);
+       reg =3D &regs[BPF_REG_5];
+       if (func_id =3D=3D BPF_FUNC_perf_event_output && reg->umax_value >=
=3D BPF_MAX_PERF_SAMP_SIZ) {
+               verbose(env, "bpf_perf_output_event()#%d size parameter mus=
t be less than %ld\n",
+                       BPF_FUNC_perf_event_output, BPF_MAX_PERF_SAMP_SIZ);
+               return -E2BIG;
+       }
+
        err =3D record_func_map(env, &meta, func_id, insn_idx);
        if (err)
                return err;
@@ -5087,8 +5096,6 @@ static int check_helper_call(struct bpf_verifier_env =
*env, int func_id, int insn
                }
        }

-       regs =3D cur_regs(env);
-
        /* check that flags argument in get_local_storage(map, flags) is 0,
         * this is required because get_local_storage() can't return an err=
or.
         */
