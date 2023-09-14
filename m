Return-Path: <bpf+bounces-10039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7141B7A0A37
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 18:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238AB282410
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 16:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714F32134F;
	Thu, 14 Sep 2023 16:02:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151DF28E39;
	Thu, 14 Sep 2023 16:02:57 +0000 (UTC)
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B6230FD;
	Thu, 14 Sep 2023 09:02:57 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38ECXfpv006585;
	Thu, 14 Sep 2023 09:02:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=qb/6hZpBf5fJDojwGxCDfUzNAzzRFMvrW9m7p5PwFgw=;
 b=SlUrIh7VjjvNb66QzW8FKS+FRnBFmsyB+g9IOMvo5nxZdhgGWJheoTzhJUlzN29Atn9u
 gMBEcfPzwqMTpVGlHL2H3NagVEe02KOae2/+93TCNblY+IgZQrSPqWwvKgxaHug7UgkH
 s9ZZlS9032nlV8SddCP4B0qu2VvODQ/i5TJ8v2KEqvfLthpAwvzAveE1q3KirQKEawd4
 LaiGd+iO/PnZTdlz14nKo4JNjOPi6tB7ERL/XYH4y35ZWn74f03klcv9Qmi+K8RMThL9
 Q1p/IsMlKtedLjg3CVkzyI83MzuyysC7+VTjLbffcZIGRpFYkYFXOKVf9GAQ7XclBVnz 9A== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3t312ekase-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Sep 2023 09:02:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1694707320; bh=qb/6hZpBf5fJDojwGxCDfUzNAzzRFMvrW9m7p5PwFgw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Z/7eeOUaZQ5coMeNYB/uqOynQ5Zo06GcEKyGZh+WcxftTXEeytoxb4zxySE3ze7Ki
	 bbu5DRtksDpZf1MbOMoy2MczzblHOBjbCc6FxL165NghyNTURMvtAyb6ai6/bOK2hY
	 SAQBcc63nVdftDq1OGmAZvQcw4U3Cj/zKOloHRpVSMQ9ZAtK11MGnP2GNMNEqIlwmK
	 g0RkjdXSWjGHTitr6kTWSzlRZrauOSwlIIutXcaoPn2anXlKLaqe+P234sqwTJbW3+
	 mmdwvA/xTQRYTh4erAopzxuYauFDaAOnzitDs4/uzqCEXqQ6W96yeyMoYrAd4D+X9H
	 UUerpS2dU6QFA==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7B1E84011F;
	Thu, 14 Sep 2023 16:01:56 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 8D27CA0096;
	Thu, 14 Sep 2023 16:01:51 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=iJbEzCg9;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 72B0E40357;
	Thu, 14 Sep 2023 16:01:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2DZ88KGngf/rr002nE3KhSpWwfuPaUVgfGiCx2DF2l2XVBmUDBFkuSNaSvGlgnHsW0pv4C6uXk/yXdsGvvD7homsa9x1SOOwL00MgCJ3fy7rDJidbtmKz0dFqsz695W3Rbi3f7RmILmyiE2N9XlWfTTYN98Df8CS+1DnFgxRKxYL+TC1aay5tQ+UK7ZSaSd5vGDxzEId4gV7RAdbSSF7UKQJ7LxMyJcN3HyAjHNi7s/CAtmtZEwMdoaqCvsT8aGMYFdoVYfJxcHQFzlhRHMykwBmG29RQ3+qyrwIwQ2Vgx4GO3S4l24mI1LAzPpBoL+zwhhX/6GVocr826lKPGsSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qb/6hZpBf5fJDojwGxCDfUzNAzzRFMvrW9m7p5PwFgw=;
 b=oAJr4C+JrVPKhHpvUjzPNUGh0m8Hm8KHxtY6pDQc2ERAoNNwhHJxJpRulNuXFGXfS1B/xGJKNbesN69MR0OouzzEjb1+Q6KZvdJYPFiPnaebnUE4bwLQEaagsUtVnJqv1nn6i5qjRsnv1TYQLNKpjWO4s1cIzoGS9qM5FCeBYb62fy7Uwq53ExDAXfMo2sxy3NmLblCb47a98vAYM6BNerYNgtirM64Cht0nnt0HFk7AZREEz99zC7UnOiSKMaErpMkX7KhzvrtRdBmO5Ngb5Ja8M1XixoUT6JEexc/w33ozMtGU21DIMtu8b8PUHcuKqPAbhT2lz9uJPbrYL2GeyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb/6hZpBf5fJDojwGxCDfUzNAzzRFMvrW9m7p5PwFgw=;
 b=iJbEzCg95+iHySpds2kK0YMnnVZGEMOdr5Z0ZBMdjWIHLKuL+5NlkmLH3oMfUAM9h0DTb7gCNULY0flGN6j0d3Jt3Rs2XHwB+Eei1QrHRpDuvZki+dUjIY8RsbyGsl6UkYsKCxF7C8AUGJqAXXtECfqyr8UIDW5hTyiV6RIVU/4=
Received: from DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) by
 CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.35; Thu, 14 Sep 2023 16:01:43 +0000
Received: from DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::e258:a60c:4c08:e3a5]) by DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::e258:a60c:4c08:e3a5%3]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 16:01:41 +0000
X-SNPS-Relay: synopsys.com
From: Jose Abreu <Jose.Abreu@synopsys.com>
To: Russell King <linux@armlinux.org.uk>,
        Serge Semin
	<fancer.lancer@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Subject: RE: [PATCH net-next 4/6] net: stmmac: rk: use
 stmmac_set_tx_clk_gmii()
Thread-Topic: [PATCH net-next 4/6] net: stmmac: rk: use
 stmmac_set_tx_clk_gmii()
Thread-Index: 
 AQHZ5xKsKAjAs+AT/kqctVSTjjzi5rAaY8GAgAAHSICAAAVigIAAAVWAgAAAzYCAAAikUA==
Date: Thu, 14 Sep 2023 16:01:41 +0000
Message-ID: 
 <DM4PR12MB50888CA414C76F5C59C27E50D3F7A@DM4PR12MB5088.namprd12.prod.outlook.com>
References: <ZQMPnyutz6T23E8T@shell.armlinux.org.uk>
 <E1qgmkp-007Z4s-GL@rmk-PC.armlinux.org.uk>
 <7vhtvd25qswsju34lgqi4em5v3utsxlvi3lltyt5yqqecddpyh@c5yvk7t5k5zz>
 <ZQMgtXSTsNoZohnx@shell.armlinux.org.uk>
 <rene2x562lqsknmwpaxpu337mhl4bgynct6vcyryebvem2umso@2pjocnxluxgg>
 <ZQMmV2pSCAX8AJzz@shell.armlinux.org.uk>
 <ZQMnA1PgPDDQzDrC@shell.armlinux.org.uk>
In-Reply-To: <ZQMnA1PgPDDQzDrC@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcam9hYnJldVxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWZkNzFmYTZjLTUzMTctMTFlZS04NjMxLTNjMjE5Y2RkNzFiNFxhbWUtdGVzdFxmZDcxZmE2ZS01MzE3LTExZWUtODYzMS0zYzIxOWNkZDcxYjRib2R5LnR4dCIgc3o9IjEwNzciIHQ9IjEzMzM5MTgwOTAwNjY0MjAwMSIgaD0ieXI2KzZTbkJ1Y1p1NjUxSDd3THkwT2NVNVYwPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5088:EE_|CY5PR12MB6371:EE_
x-ms-office365-filtering-correlation-id: 46a3341e-ee91-49fa-bedb-08dbb53be2f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 H2AoB1Rsvfd+QdvEenQ6nSGak3V7D93eCoiNB2JtJKlk91M88LgUefUyBvG/uHWbShwkITWFrUwqxCwqmqF9dw7JfCOiDEUW2SUU/HaOp5ywLc1WW899qVL55mY14D/s1KZannQifH5RC86LvPueGwLuMxJn1UOgjASHPmJ3AsCN8ME6jRz1Eh2RbfAkW0vKp2nxXELlFo1XQHVEpezr1DYhtnfAP3dTA3Nq/gh0tZBsSegl86Is541wuJrg4z178k5LvVd1roiMAIGmCdsmxufViSw90yl2KsTy3/Rb6r30/Ik84cqifoVohg/cSi+z6xHnDPeFjYHc9i98BgTwtx815aoLR36g3dLK3av3VQGH1Dk9FUuN9m8A1mivpCJwLnOJ1Ve4T+aWr6KTZnWmHf4uiDa7G11zIKvYAysi5Bnw+piVPHkYBEK9NGznTcFfHKF3ztgXFD64kFj0JujNfdPwXoiTfvGYu7byX8e1UbBMYqJIG93lGvXV/JyTgEsOa+YjckCmduqAz6inmVM1WwHd2kJ+23JcCuV+DPvMrjtnSzICoJVqtCAuXpDXYRGHSw4Wbn0xC22xt2obCVusxRBUzukPeXDieFVwUFXT1WGKWDNi+kjg6KvGLYtLH++F
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5088.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(186009)(1800799009)(451199024)(2906002)(55016003)(7416002)(66899024)(86362001)(122000001)(71200400001)(107886003)(9686003)(6506007)(33656002)(7696005)(4744005)(26005)(38070700005)(38100700002)(478600001)(316002)(52536014)(54906003)(4326008)(64756008)(66446008)(8936002)(5660300002)(66476007)(41300700001)(110136005)(66946007)(76116006)(8676002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?GqZ6oMMultwLJYn6lE/SKaEptD6vTsFUR9XUseF99MAJxwA/KYgd6HE5IbRN?=
 =?us-ascii?Q?E9MQGxjp4GjL5005JYRQA98GYaRofOVRRxtJZaCj7e5EVYlg0UTHKvmRJwTS?=
 =?us-ascii?Q?7FvgtDsT/uz6186L/rf/Ci5ol1p2fojWLjkOZXcaWBOxBKZoBn8ST9cRX6uF?=
 =?us-ascii?Q?SHcpf1Lyi+3zSwJ9UFbcu4ZnkXfVv6YlsMM/95n0rzeotp5vAR+2V/zaoNTi?=
 =?us-ascii?Q?fjII7BGZf0AR73B39qw9sefEoqBx9tj5KORSeoyN5apPs4DHtTVPd/kvaTxa?=
 =?us-ascii?Q?AiMCTRk6v03C+0gfSDVcKFqGwN67u1zSIZVuC0tzjpcpHoNhb68ReVfRnrQ/?=
 =?us-ascii?Q?bsqQmkAAJ8w28PngzyX2cqwJsOgH6JKeWato2FUkAXQFviksHRDLyiNAS1tT?=
 =?us-ascii?Q?KSP8M8/1waZrp2qO3bvVfVPx8dHr2w5cmP4Ah0Lgjjv/nppozZAX7FbepZLE?=
 =?us-ascii?Q?IaG77lz5N43Bg+obvcbQ1chAwTvTjxHyu+tOInTNzd3A7c8aGthpFwVOT8sf?=
 =?us-ascii?Q?kKLYxIlHrA/kV9JK208iKiIvmneX1pcjMoguo8bdhIkHPBPa4hlcu4OmaUh0?=
 =?us-ascii?Q?aEtIxvyyjhcDnH3yxhq6gPUj+zA0o+7Jws43U7gLuETdm+wFgdZBIK81mOJn?=
 =?us-ascii?Q?odkWpA+/QZW/xdmujXnBzoHbDYKcBkSenboeqfdhyW7EJFuC5DqLalixNpQL?=
 =?us-ascii?Q?EUAhwDFWOF1CtZVzzPQyDDKdk2SoZ4onKdv7TIZ+GyNHqsI72R9bzQs9fn0L?=
 =?us-ascii?Q?7qJRaSonXCXI3HzkWSB/qNu832VuW/MAtajzMjFMnESXs+zhLD6gM+11nNqL?=
 =?us-ascii?Q?7yq5aaMNO3S95doet9lxIYVzV0z71I3O+G7h9PgNdjrjYP0QClFHJv67AcQD?=
 =?us-ascii?Q?LchCJK7aoM/I7fUZbm0w9tmDFTcWXg3fACcaKiQiCH1eJ9JflXCVfE+1R+Vn?=
 =?us-ascii?Q?2xr+auX1QTXhmv0kwu8JSAhozejzuv57OZbhsYoHIOBOeNDABuFj9H1U8NtV?=
 =?us-ascii?Q?kmDsL82pI8mI+ww549hGMwsxmxjqBy67VvaVnusOPhS7viGQ4sDXWqifveSs?=
 =?us-ascii?Q?uUgJtKjTKefZ9kA1GGkb1J6VTPq2O6NJqMhigE7aFRU7TzA24BnjInLA0Ld3?=
 =?us-ascii?Q?AHkMA9zDrZw8dCGjrEeDl6NL+Uu7YZD0MhtldGZR9lDKH4EAqkKC3DdAVe9s?=
 =?us-ascii?Q?Ehw9WAPE6QoewWIj/Z9Lz89p3wMnsRIjRj9S27nhBVXdRdl//YRGNvvupaoN?=
 =?us-ascii?Q?be8LgdgbsguVzVvCofM3MKJnvQhTP9i6MT4i687jI5HQJ4G62MRy9vAGBfcg?=
 =?us-ascii?Q?EdaxPkK0nFLkCfKX+IJsWDoxvwrKkv3KNSvERvxrIsEXhZi/jKsAkqfPZOfl?=
 =?us-ascii?Q?JJ9ZtBlXtmDf+wdMuG5siLJA8uEXrRXQODnlzLLPd3Lto4As+P4SDDEYPkH8?=
 =?us-ascii?Q?btU5xu6TyeGJfYMC1gWYslA1PjBUXvCI8HDriuqMWQJBMgmq3Z83cGLp8aSr?=
 =?us-ascii?Q?epykBnHHEj/6xa3k2JNmd/fiQR+R4OXY/kKhQnG8QxDNADmcluCiYBrNOooB?=
 =?us-ascii?Q?uPZnbWsGPxRDbWwx+ElMCHMLS7mZdsZnQQaRSuHf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?Pdll8eOIHhU/PGAk60ONr3wnzdp97V0S9HVs+gc4TV7M+mqtQLqTAU2qSjHG?=
 =?us-ascii?Q?G4BbSxvn9lhiJjySS1/1XxsbTkKqdHL2yc0evyd1IvCWwCy7lAGff12jON+1?=
 =?us-ascii?Q?Rl7jz+Xr70qHh+6lwHoiHKj/N8ESGMtK6vMHyuRt0L8rpm3mXoki3b6khWaO?=
 =?us-ascii?Q?bJQ79kOyMeYAHtJ9uZpjvzG6xgwlIpxW1cgpmQC27fZw26Divk9zXe29h3va?=
 =?us-ascii?Q?vSgUCvLsy/TDbtkawxeNCfMBaqLSASrtYeZFzz95G9dxOu/L2VdZu6G+XWs+?=
 =?us-ascii?Q?3dWEhwaAV7Yat8+yREaPQNkk1fjajZ+jX3lzEGSHlIIcq6mkofF6m8/X3Nxf?=
 =?us-ascii?Q?8ny2VMD4ZgjttKWOYZRCvgok7LHjbkQZ+TtiiyiSM52TsfAIJeQsw+9qLzlS?=
 =?us-ascii?Q?fzW9vRmCHUVW3UQFkLLlBk8QzoVChT5Hk70Gk21I4FGUTBWn6LBirCJhkXqZ?=
 =?us-ascii?Q?if56LcL0FT0Nh6/9R0zDTe4w9mSmye4b1EQRH8LO0yfY57oJsqYIVe/gQuQ0?=
 =?us-ascii?Q?+GRCZtQo59IQbYq0vgoMpMVZw9l2HU3YTd+1dVMGO6PTUXur1/SoqvvKcOJc?=
 =?us-ascii?Q?9EF0fSTlvdFEAoqq/bDh+pREUYldoEygWLFIEsSctrLXMjZZXYSheNaqz7F1?=
 =?us-ascii?Q?hzJFglbb/9C4VT8Mpv6BJdrLReSBoa0tzXlp9y5QpqO6zwjUNftTmdwAF8q/?=
 =?us-ascii?Q?s4IyGYkRRf/J7nshzksIR7yNYa1c7frLIuKkStFFKFdLYXts7tNsNmrtMaFZ?=
 =?us-ascii?Q?c8XoUKtJ43ZnRBQLBFFgni1t3iRRPAqYvXopO+dRantngBIRWC+XDrLkqbSH?=
 =?us-ascii?Q?gRyz+8WYmUC9o/bYLoF02w76pjzVqS+kiiJDrhmVBGdSgGUgz0pBiSvMz+Pu?=
 =?us-ascii?Q?CIQ79408yG3gbQmaxM4G7s8VeB/3Jrpv6C3IlsZ+Ngs+mj50cIJttS+asVWd?=
 =?us-ascii?Q?ey4Q+yCOm9v5C+OWx1TekWGqBseRyoaqfKuw/gqob+msG3/ygcyxgp8LOCGA?=
 =?us-ascii?Q?04QuuERNsq4EPOFQVa9umrvr2t6f/IRsMTOl4KS5YhYiLIC/vytqcRl2sBXW?=
 =?us-ascii?Q?+BmBwno1xGm18Zsbx3OFtM8sT3z9w/vIM0kjm/FmjM4a9ZGBpzYu7dzhfgve?=
 =?us-ascii?Q?gchWtvPbyD3yd+l0lcFu2XL3i0wehO637pWd8w2FPlKy4UZeiSscZe4vez12?=
 =?us-ascii?Q?sUW4n6ozSux1bk3m61s72qm9qToJdNYiyFmKMwW46iK5tjXXhVPHcZ89dM45?=
 =?us-ascii?Q?PLifGGt7o49i4fy+tX9DehzYpW0GJLlZ8+kcv1bjzdL41LoxLrryxM+YOp88?=
 =?us-ascii?Q?FR3FlmdyxtDTVV+ObLIE0Tm6?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5088.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a3341e-ee91-49fa-bedb-08dbb53be2f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 16:01:41.7901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mwvq7CmVV4xWKC5CUqgpApDKkJRpAGcdjF4uOmmYghpVCJJ3DaTc81+XxZ9RfKVXj1vq+4DoafpWQToiEzs/nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371
X-Proofpoint-GUID: sTuCVm4jytzLnDGIqnNuN1pIdZz9KLea
X-Proofpoint-ORIG-GUID: sTuCVm4jytzLnDGIqnNuN1pIdZz9KLea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 clxscore=1011 phishscore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140138

From: Russell King (Oracle) <linux@armlinux.org.uk>
Date: Thu, Sep 14, 2023 at 16:30:11

> On Thu, Sep 14, 2023 at 04:27:19PM +0100, Russell King (Oracle) wrote:
> > I won't be doing that, sorry. If that's not acceptable, then I'm
> > junking this series.
>=20
> In fact, no, I'm making that decision now. I have 42 patches. I'm
> deleting them all because I just can't be bothered with the hassle
> of trying to improve this crappy driver.

Hi Russell, Serge, Jakub,

My apologies for not being that active on the review. I totally understand
there's a lot of revamps needed on "stmmac", somethings may even
need to be totally re-written.

I'm also aware that Russell has contributed significantly for this process
and was of great help when we first switched "stmmac" to phylink.

So, my 5-cents here is that, on this stage, any contribution on
"stmmac" is welcomed and we shouldn't try to ask for more
but focus instead on small steps.

Thanks,
Jose

