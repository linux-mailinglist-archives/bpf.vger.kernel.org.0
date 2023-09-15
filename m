Return-Path: <bpf+bounces-10140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097B07A190D
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 10:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E3128268F
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 08:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB7ED51F;
	Fri, 15 Sep 2023 08:40:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187123C05;
	Fri, 15 Sep 2023 08:40:19 +0000 (UTC)
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE0510DF;
	Fri, 15 Sep 2023 01:40:18 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F7E0WW006327;
	Fri, 15 Sep 2023 01:39:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=OBk6WqHlVqXD1+/MIM4bK6ExmOcJIpfkPldqTfMfdyo=;
 b=HFYQOVlOFpf5sN/ZeOmvfmInBSAKNcHpqu3XXdL3CgnxyL+yu6FsT+8OJACbIGW9XewX
 A7rbksfn84RyJpw74TCxTTxr1POKruQ7tDAPj0l70qUWSNoa7gjk82t51tIFtV3cDuGd
 9BapkAclvft5oq/ZIECzti0ZxYXlizSNR5+7cCTq11noAZxbFjqmJmbbuWaMSUe5T/pi
 /o+IWgtPwSWM7jLSysYlyFRpDemXnB5b/FAAQMtx69W3Kr12AdyEiE7oInE5WKGqTmU4
 7ipOhkvXGgFIOx4tM01i/5w+ZMIg8y08hlRlZPXeUepqObViuDiZETpRSt7S+PrfkwgE fw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3t2y9b6h06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Sep 2023 01:39:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1694767147; bh=OBk6WqHlVqXD1+/MIM4bK6ExmOcJIpfkPldqTfMfdyo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=NasNBucIbw2LcfBAjT4nL3c8eDzGaMi9gyd2qVP8F9NLPb9BhwNRYmHBMFt293CV3
	 tyX2ed871qiw5yRXM3qV7YSH+AJhKc0P0DTTQ7rSZJZGxL8uE+20DrjotIoQUdbJq1
	 32R1qINTwpHwQ3n+GdSPX/WepVnJINaHBy13OJKcgu2KaGJblF6I2SyAhx10KeJvrp
	 E5a1JoEBodHJjiOseg9j44fI+hPfGf8O4ynAWbqOAfkONjMWSpUSxjgMAFG6jD4tWg
	 2xC8kDPT8rHYmOk9wLaiUWBcZ4z93KvLIgWMm3dAmeTPDwI/fbsauJKGDuETiGqUPf
	 x+sd7dWwY82wA==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 65C6440541;
	Fri, 15 Sep 2023 08:39:04 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id E82AEA005C;
	Fri, 15 Sep 2023 08:38:59 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ZBI3JYIy;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4794F40169;
	Fri, 15 Sep 2023 08:38:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uo2eac4qA/XwmzBpN9hTlscVisuuXI85UNvuz6FS+ch8e4RWuulsFVc/6TRWWpTD7rigdA8BIVnPwDJ2e29fkN2F8TRYD2OmzqHN4klFXx1I0mJAZpvM23W/619crfS4ohlqE88cAQkL7oUesSMYqVIwLWZM4dMkDL+1kKy5GGok/n9peE/XoZVBTfqJxCsm0Fa4A8tVtf/++oCL+C8zVt4qGvdYAG8VJUdWPeLUxUhbqtff/HBxWmWOcXY3TWeP7n2KKEorbhZGsW26EF1mmIRjWbiobMTJHRFc84NPW1EOYfZWTJNeJ2VCG2NHKQWr9QgXeO8QgKs2J7ymIQIEaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBk6WqHlVqXD1+/MIM4bK6ExmOcJIpfkPldqTfMfdyo=;
 b=bSQsdM6Vk45qt28ZNrNmww51F1znjeAdasPmLjYzmiUUaZJj+Wu+w6Lnye7bthoDecFgrIAZYCHg8OfpeQMBwW4VO0N9MXWTHfkqOeqwq92vlaJ0P/oSS1l5aCjuaaYB55alrhhPDqnzMkyhEUuYYnuuXxhHkxT1Z1SaYERH7JIcH5I06COcR7yMnE3F62ibaXxZlrYVi8XeVucZ8uCGGfnZ0itiGyPVkGW4U/7oiR1Jal/tp66bXdrfvb9R5EXpUGxjWN2whNS82aO6DYROtmrxDSFBh4BLuqsPUW6njIrOOYUYFPjIl2Ik/b9GXSDybB7jwIZwVSV4JHxQ4enN2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBk6WqHlVqXD1+/MIM4bK6ExmOcJIpfkPldqTfMfdyo=;
 b=ZBI3JYIy4ES2r77GBC8zERg8MLkQm7KF2kH/QBcmuRIKEr2LfNbtw9kcikFUyCA6aI54EXKOAvZELuZWiobMinL/Se2AZeJ6k5SFBG+JTMv2SC3GQR+zq1XKPto7I4zc6CDNN3IH+TebLSyzjqxrA50C2PfO+dYbYqhyHNG5Cmc=
Received: from DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) by
 LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 08:38:51 +0000
Received: from DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::e258:a60c:4c08:e3a5]) by DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::e258:a60c:4c08:e3a5%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 08:38:51 +0000
X-SNPS-Relay: synopsys.com
From: Jose Abreu <Jose.Abreu@synopsys.com>
To: Serge Semin <fancer.lancer@gmail.com>,
        Russell King
	<linux@armlinux.org.uk>
CC: Russell King <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
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
 AQHZ5xKsKAjAs+AT/kqctVSTjjzi5rAaY8GAgAAHSICAAAVigIAAAVWAgAAAzYCAAAikUIAAEeWAgAEEAGA=
Date: Fri, 15 Sep 2023 08:38:51 +0000
Message-ID: 
 <DM4PR12MB5088A61E5F067EB459C06CCFD3F6A@DM4PR12MB5088.namprd12.prod.outlook.com>
References: <ZQMPnyutz6T23E8T@shell.armlinux.org.uk>
 <E1qgmkp-007Z4s-GL@rmk-PC.armlinux.org.uk>
 <7vhtvd25qswsju34lgqi4em5v3utsxlvi3lltyt5yqqecddpyh@c5yvk7t5k5zz>
 <ZQMgtXSTsNoZohnx@shell.armlinux.org.uk>
 <rene2x562lqsknmwpaxpu337mhl4bgynct6vcyryebvem2umso@2pjocnxluxgg>
 <ZQMmV2pSCAX8AJzz@shell.armlinux.org.uk>
 <ZQMnA1PgPDDQzDrC@shell.armlinux.org.uk>
 <DM4PR12MB50888CA414C76F5C59C27E50D3F7A@DM4PR12MB5088.namprd12.prod.outlook.com>
 <uzvjph54kg2jkfbmwrvmunqv64ig7j6szr6pxxbiesnz5lletg@zq57w7jj2up4>
In-Reply-To: <uzvjph54kg2jkfbmwrvmunqv64ig7j6szr6pxxbiesnz5lletg@zq57w7jj2up4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcam9hYnJldVxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTQ5ZTEwOGVkLTUzYTMtMTFlZS04NjMxLTNjMjE5Y2RkNzFiNFxhbWUtdGVzdFw0OWUxMDhlZi01M2EzLTExZWUtODYzMS0zYzIxOWNkZDcxYjRib2R5LnR4dCIgc3o9IjcyOCIgdD0iMTMzMzkyNDA3Mjg5NDQ1MjQ5IiBoPSI5eU05ZmliNldtRmJza0dGRktQeHhFT1luQWs9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5088:EE_|LV2PR12MB5967:EE_
x-ms-office365-filtering-correlation-id: 50074ebf-b1e3-453c-d46d-08dbb5c72ff3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 h4lSJnr1sC9VmW+a6tsSzSZ497MbPEeabl4rG+HPZAi3lDa0LxvtadOwm9snaHZiT+GyyS+PDagDyNzn+bKXkCc3NWt2gPWt6GhozTGNm6+mb3edIn6Ob9SlXDqSAH0fgWIlrR6xFBW0y27hEEMCjzRasnxeorO/2x4qyjiXD74XwGVSG6nbboKgJxEPvzK9c1oqxW15hJZP5UsDlPQu4pW1hFf+Mb7JLi1t3ouvdiFLbHc+w4Z8OxXarFkWTVmj0CNXUo1a80XDGo1Jff2f2gCvVmPI1nyru73LMVNmaTh9cVBdodVFp5fnOleuBvqy4Uwhc4/fHOKsVlD+3aSTUdXXsfobGAYUG8TgTtE0DB0Hp0S9GKtywQoPM2Ox+5Mi1OxoxDNCERtNOTp1pP4HTYEvhvJOwbd31X1uLz36W7v/mEmG1u9pGXk+sK7sVMfZDKJX6rsXwLvZbass3iShwI7d61piLSeYOtPkzPxteFCD5ZxJVD+gEb6v+qp9tNCB08UgMC6c3E5pivB6xjfzr1cObCRr0ZIMiVh1/opbYWzC7QqN8tZMTiIVkINVUkwEUcyDwQ9zL2f8ZQP/EGnn3gZBZksc3m2Ne5jaKTKzQdqxOoOAQe0jHA4L3h6LRbtw
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5088.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(1800799009)(186009)(451199024)(71200400001)(7696005)(110136005)(6506007)(316002)(52536014)(9686003)(55016003)(86362001)(122000001)(33656002)(38100700002)(38070700005)(4744005)(41300700001)(26005)(76116006)(66446008)(478600001)(66476007)(8936002)(7416002)(8676002)(54906003)(64756008)(5660300002)(66556008)(107886003)(66946007)(4326008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?WO9gbZHXOlmV3xP9Qe8RPK4Z7Mu+PJrYwV2hr9Yv6dy5S6G7Pf7KjIZVICjs?=
 =?us-ascii?Q?gjquxM+xrt8CRPThA8BUw/xn76vK8JopIXYmHqC1KyxLCjENLv+0k3xq5t2X?=
 =?us-ascii?Q?UcQL5k+hebVK+kjipf6YAnC3NsfDpD28BCXgketpRAurAcZ4oAtKP5M/R3Yv?=
 =?us-ascii?Q?adhODKSA7q6TYwqprnqPlsQ/U+B5+TIEO72CkeAUeUEHpQPkGuvVZueRLBB5?=
 =?us-ascii?Q?yDY99bI//CeKDQzG4E+Tf+jylWjaQvtu7NxPUelG5/JBd5HGAFqAB+V/5+Qt?=
 =?us-ascii?Q?5yU7v3CVm+hKUBBIv2roYZsh+Zt5Nhe1YFAWvqr05BQB+0ZR1w9fbCGbHPEb?=
 =?us-ascii?Q?Bb6j1B4kwHJCgEu6dMEMTVMQVjMTWosZ5zvT4u5fueBwRzhD/pJYNUeuiENe?=
 =?us-ascii?Q?5GVohHhmSFvuWO1F+QWM8DVTCKBjKQtIDOiwv4K0UrhnUD0IBFvSajP0Lth/?=
 =?us-ascii?Q?XFPEib2AKE76d2rpKxAwInv8cHEabORnqIkvXvnmaW8cA84SuI3aO+LEmr4X?=
 =?us-ascii?Q?ZlTOgL7K4N4qz3i9sevOZpm6kh7SNVH98cdQH/Xrr6J1YDgS/W4TOk8s5d+7?=
 =?us-ascii?Q?muVgGuP2JCCHVj4PodvpsOIO/yv61zgYVky6DgXDb1/i5aQzmHvZeFLrLPg9?=
 =?us-ascii?Q?JiaZBB/UPUoUdkarN8UbvoSxPnVj64wBp9mPqXxOEVbAyW35ZrWDJYAfoh5c?=
 =?us-ascii?Q?tvXPyl380QhezN6ENgtU/omzQkW8270HMD0swpNGNtqZ4TrVkQxnF0PyJIt3?=
 =?us-ascii?Q?pv04jYdLHyPdtA/VrC+3p6p93GHyTrhaXl8zXQQB2Yae0wfHgI4O93KaSDy2?=
 =?us-ascii?Q?qiPQt9O9qGBLNCAtTvMo5cOzgy64kyptogZc+fShxs4WOLcDcsRB9FHJwElo?=
 =?us-ascii?Q?qXV85qbLOCqMGKyQs6N1hshtBLKKlvE+RKc+Qit32iKuIMdrkqFlZAMVbb94?=
 =?us-ascii?Q?UeiExWTF/szQa7Ay79mXy5Fc7KzEKZX2fI7hSy0Ow2vgNBGJJGoAR9mYZFvy?=
 =?us-ascii?Q?PCAk9fzGXFy4SxNygp8/Vbsj+jeGKqqjv/yJ9LUITLFtjvAYiq3B+AmOEfHd?=
 =?us-ascii?Q?FJMkj2uK64qhrxJDpZfwHYNZwcYUwqJUd3T7xTqTJ4hOhw4v2gt43wtk/L0N?=
 =?us-ascii?Q?ZnSTABF2e0J6uF9Fpl3p5UD3cMEH4bkfjqgc41ALCNSFMB3Q/nIGWuvAuOcs?=
 =?us-ascii?Q?h/MLWDX8EpA+k72L1JNvNuSRr99Ttdnkz44t9E9EdyZQJYuE94EAk7zvg7a/?=
 =?us-ascii?Q?NYsfhIBZmfdQzTWIDOyLPDkqcN60OBx+etU/Xr/+8bh0c7egp0MnTYnA9Cd9?=
 =?us-ascii?Q?+QxujGs3wq2plYJIAB+4B8kGZzBx3aTgq45Ju8/xb2rKzTBZE9C3kyQN1XmJ?=
 =?us-ascii?Q?OTZKa4Fn7hkTj0dLFa5TU90tXjCfGJtr7igTZwXgEdI/X/p6GwLUdWyEYoM2?=
 =?us-ascii?Q?EfRNzGTZWjyNg3iruZN+OGExSBwI3Fd0uUIm6V1sA6+QJQJVvqIMP0rTfmtK?=
 =?us-ascii?Q?OKLN3V6K7muv93qjOQ10cRGiqnZYGY68Y6egPLgZT7v67J8osM4ErWAojQsJ?=
 =?us-ascii?Q?dRftgiEMgfhEUh/cAiX2Lf4KkMqnEamPVsmF3yuO?=
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
	=?us-ascii?Q?phTm4co8TKDG0fUIP31ANok5IWzg+jyQw0sSFL9Ep5gZwv2axrfRHRQD2gXZ?=
 =?us-ascii?Q?8rZ3Qk/JgdhCHFvuzmqGNMoJtpmVHq3RDbd2WCimltB0/ymWlq0FITx3jNHY?=
 =?us-ascii?Q?Cjnx4JYCM5+h0aRMVnmezl4D08FZDYUoo2zzmk+eW14DA6UeRFgVUPzIuTEA?=
 =?us-ascii?Q?i5WVDKnyghYi2t2XtdBPnJWwHtb3HfUfw3UYGJtMFwkhZkWQ2hQsNKybgFap?=
 =?us-ascii?Q?olSZaoMliMrmZUU3XyyTNfY/YOGoipv98mWA1UJqi06OZTx0f1/Hzdze9Z0R?=
 =?us-ascii?Q?tuoK/l5mefEBo1NeGdYRdguouwpBI/zmQaK5Fdn+0dkQWQWMRkn8gX10wUuh?=
 =?us-ascii?Q?rkxqmg2PwV1xoCK5Pw8jHyokmXSIlSsdZ7ft+jBK/HXplGXAJtnGyeIiKljS?=
 =?us-ascii?Q?YKYDq6LlYeJ80ZaFUS64tt0xCM7SA3pygL0ebcF7kJijporqVQjuvAk5igT4?=
 =?us-ascii?Q?BtvyM757mI5tjJ1UAeUKoZu4T9iZJT7VpXHUheL8GrHksV0k8n1hZemEssqm?=
 =?us-ascii?Q?NLVkNFfaSpEB5M2XrUnAJTB1NFXiurn5+y7FXLFzMfXtqzJwNy2ZqpItH+4V?=
 =?us-ascii?Q?aFlRYXraVM2bEvehUubZ0MjweQERrDTr47LA4WryjdJDDtU7YiAPY4fP0Jso?=
 =?us-ascii?Q?dM24G+8AVDVqHN8LNrEg2zQmkr9RTGUJ+Drme5ej+kwj21BkTicJCGqnKj+K?=
 =?us-ascii?Q?KV1FSAlsJTaPWSvw6z6jlPHp2MmwVkRNBhQoas6PUoLLZy4vr2DHajC9Lcj7?=
 =?us-ascii?Q?DGoNiwZEh/BxOT6FLYXw8+qMBTLBu55IEjXtnBDZe5QmEoMzZ24ooi7tNqVj?=
 =?us-ascii?Q?+F9LBOiJmFPvAVogJJ7egn28ixXINLp1C69T5O1+XphCsR0Fh7yLNETxTk7C?=
 =?us-ascii?Q?w5nejJZm1HKTq77tS+Kvh0BcINcGco/zShCoRkhkKlDU9uDfg4gXKBLQfCwS?=
 =?us-ascii?Q?gPgtSXl1eIsWRcElDLQKcxK5teNTvK9kzD8NC5klAS7ESrLTqlGqIErQJ3dC?=
 =?us-ascii?Q?uhORGxXMXqsJ8BR3gxoiDayldkyDmQNMWIBdU7tU7smw4aEAebaSyO3oez6L?=
 =?us-ascii?Q?svra7OrS7pE/58PCJAJQE4SkYyn0nIJrgrYLf0P0tig9oXz9bZGQq7f5WnPR?=
 =?us-ascii?Q?iYp4YHwporka4fDvNeR2uoua9mueSmQVqoR7BsGC5hsR9vdr22pZTQteNw4h?=
 =?us-ascii?Q?nFSfCMlDDs9viFk/u9hflTAx3QNeWhkmE7B7f4EB8imH7udBfbBAZE+gFvk8?=
 =?us-ascii?Q?B2uNwpWHUW222mRT3Ry5nPsC7WgNhmGzjUelMzhewpUFc5+XxelkG3QpbJow?=
 =?us-ascii?Q?V9QqlduuThL6ZTgz4Nbg30nq?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5088.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50074ebf-b1e3-453c-d46d-08dbb5c72ff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 08:38:51.0591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SqWoOxqIoSKKyuXQjDGRFDJ5Sy42xckclpjODCY0CldUwPi4hE8MFRf/aR8lBb3YudQyYEfqks7KiZKtV0rZBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967
X-Proofpoint-ORIG-GUID: 871KK6z1LoLroIS5htclbhCO97xW1g18
X-Proofpoint-GUID: 871KK6z1LoLroIS5htclbhCO97xW1g18
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_05,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=708 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309150075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Serge Semin <fancer.lancer@gmail.com>
Date: Thu, Sep 14, 2023 at 18:05:09

> I actually thought the driver has been long abandoned seeing how many
> questionable changes have been accepted. That's why I decided to step
> in with more detailed reviews for now. Anyway It's up to you to
> decide. You are the driver maintainer after all.

It's up to everyone to decide. I understand your comments on the patchset
and agree with most of them but on the topic of changing the entire
patchset to add the fix on "plat_stmmacenet_data->fix_mac_speed",
I don't think it's on the scope of this series.

Thanks,
Jose

