Return-Path: <bpf+bounces-9729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F21AE79C92B
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 10:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B112814AF
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 08:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095211773D;
	Tue, 12 Sep 2023 08:01:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDE51640D;
	Tue, 12 Sep 2023 08:01:39 +0000 (UTC)
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFA28689;
	Tue, 12 Sep 2023 01:01:38 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C7pCNL023897;
	Tue, 12 Sep 2023 01:00:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=QNg7xNkVk8coKWOQ7AMSnGt3m0iU22Kw6rIoy22DVlo=;
 b=Qk/13Fm6N3AnlvlTm4b+yvMSSLJYIurX4Fmb9lz81iCx40zweYmvPxxkdRZy9yI+fYzq
 yazcgYwI1Dz4+kwQgM/Au2vMDHHchJx+wurHQ4AgzOYD/pMEVjB6qJT2TzdAyTSDzsYV
 58GdfhSOLlXK8hgSfq23ny8lGmXgCKOU+MqR88I+5a/xqdIQVh24MUzSAo7/BLnUEClJ
 8v44j14pQdv4dUOT7UDsJ2iGwpAYoShDc8Air7mEc5c8la5zGTQpwtFPQcvNFSqeejeD
 KCBtrVspsVgFWTfh4oJb41y2JP3V+GWUhkG1Wdbaplgbxw2Ha6c+VrWp3MmTC8mYQJA8 bQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3t0qmvnthf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Sep 2023 01:00:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1694505607; bh=QNg7xNkVk8coKWOQ7AMSnGt3m0iU22Kw6rIoy22DVlo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=bCn7x9f6NbWW85BTwsRhmHtiRyt0FLh1Y6wde67Hi3w8Tx6NtqVKfMBaOkT7kB8c/
	 wO1InGOZYEDOIkSgDFFGQxT1jSGVh/GzQiXBBpsHNHUICdQvuS/qg7c10mLnTL9VUC
	 M5Uax035jHqDkzhoP7OMrbVKyuHJtsyPXOf0F0NoHoNPUKzayRkgfaV7QC9YOxgs4g
	 Oh/Of5pVPCIr6cWmQLjwFo2KJZdPk0tgt1EhSOHg9kFy5MpfVSH1aMDh0PD+nQ1uvl
	 VIWeK0z62C5Lw54L+JZF+iyYQXUwzj2lMVhhXo6sz5iDD0j0Z9pGEL4mg04euMLrAc
	 fTAmNpf6mRAvQ==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D46E7404AC;
	Tue, 12 Sep 2023 08:00:02 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 41FE4A0075;
	Tue, 12 Sep 2023 07:59:58 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=U7Ys/HbS;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5272440147;
	Tue, 12 Sep 2023 07:59:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RE+YzWkbuk8dDf2Jf7MH6rLs5FXVvEUQzRpZDgzr3o5tCGtBaEwwks0lj1w67+GxE1S1LFlqA13BMsKm2GaPYA7NGLPnsW/UdQRPTyvA3pXl2o19t8EyUr04Si71FFKJzSkPfiUlffZ5R4B42dkxnhUNLuifkcJo4IDnYqlnKCyWDdXJ9eXVfoQJxq8t+7F9IY+AIWbRpaTRR/Bfk4X7R1RiCPH4nipwxqytyvom4Ox1XMeGplEfPbOyFSbV1d71URcn5jRkoHwyIHyssO/zdnf1sVK2etpVlxAV2abNi8CeKzQQTgnyeTZldsjzuWbCV1L+WKbKwerrd34fiyo82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNg7xNkVk8coKWOQ7AMSnGt3m0iU22Kw6rIoy22DVlo=;
 b=jNJ23S1jDwiGcZWqI7ECn8M7j+F6PNqqoTeV8aEYsh6LBUHG9IUC4r3s2rFl2Bsq4YfQMUhctRaDxMWoILL1S3elIRklSK3MuL+w5eZvxfCwk1DfY7EPrRKu9YTj5Vwk8FCgVez4Dys3Kqo760AUutHfcukMb+wkF2W/q7G33qSkSwoydPispyE4hhcjlbm6+bxAwS8Z5564iknmBDBnCsOgONqXRMr8ewaYrEmfXyGJXSiaWmHfbCrowu0Mp8TowBE9ASg04N0jyqfWMR57S+GNIWI3GA8p/eEZe+QMI7NtDK95opq3g3wJoMk5wZvvQFJyRv37cWvdvNwMcwyn/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNg7xNkVk8coKWOQ7AMSnGt3m0iU22Kw6rIoy22DVlo=;
 b=U7Ys/HbS6RHyAsOBBcNkCf0Ee4S4c+Z/yIKFQORaeakoPbxZzZIjvV29wedT1RjAgz8PsEpGywFfM9UcRGax/ouFaJDbahsuuRgvqZYp0N7XhgWNJVNr/CpA0pxzMsMNnDPeFGmIcvmQmdqRXSXR2bYR5N6o1HPww7WmqiGBuzI=
Received: from DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) by
 SJ2PR12MB8112.namprd12.prod.outlook.com (2603:10b6:a03:4f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 07:59:49 +0000
Received: from DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::e258:a60c:4c08:e3a5]) by DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::e258:a60c:4c08:e3a5%3]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 07:59:49 +0000
X-SNPS-Relay: synopsys.com
From: Jose Abreu <Jose.Abreu@synopsys.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: Alexei Starovoitov <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S.  Miller" <davem@davemloft.net>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
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
Subject: RE: [PATCH net-next 1/6] net: stmmac: add platform library
Thread-Topic: [PATCH net-next 1/6] net: stmmac: add platform library
Thread-Index: AQHZ5MS34d3H+d6TiEebdtTyLIXHS7AW1Apg
Date: Tue, 12 Sep 2023 07:59:49 +0000
Message-ID: 
 <DM4PR12MB5088F83CE829184956147E6BD3F1A@DM4PR12MB5088.namprd12.prod.outlook.com>
References: <E1qfiq8-007TOe-9F@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qfiq8-007TOe-9F@rmk-PC.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcam9hYnJldVxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTU2ZGQ4YzJlLTUxNDItMTFlZS04NjMxLTNjMjE5Y2RkNzFiNFxhbWUtdGVzdFw1NmRkOGMzMC01MTQyLTExZWUtODYzMS0zYzIxOWNkZDcxYjRib2R5LnR4dCIgc3o9IjgyMCIgdD0iMTMzMzg5NzkxODcyMjM3MDA4IiBoPSJsODZOZU1wc3BSQlo4OStldUVkTDhhSGY5Y009IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5088:EE_|SJ2PR12MB8112:EE_
x-ms-office365-filtering-correlation-id: 70c0f79d-fa26-42bc-0b4a-08dbb3663cce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zSnfLs2KNcad7J4zuZNwATtXiExMSk35yVUiwnJfFPojROVT5okutNp0dWSGamu9LShyaxioOh2wiT+oWmpGPi++JM97UY1efafIEW6afqphXxjEpz8ZoXvLNPmHkKfuzCbh29olWmIDXFQ1QGFHDvX1Dy+ZZVBHxaoVhi60ofAL3qFqGXK6Ez7RDc9bf0nrqrjx/BufyC21hFBuuPwk1Dk4kFmyIRkhkzoWHiqj4NAVKvnFqyKhfo5ej67U2gyKQIrmZzABf2FYOHPKS4KEbLtXZsYjy/6Zq2c2GxMr+x4iLwvuISYmlnpaTucoPyQ5jGIUa7vRjt/nVRd3E1gvlums0OVDl6O6CEjhr+G1fmlQTi/+NmiWbSzxYzqGmMg/PvZzz6ZPMzYchBiDLiPgQdEoi73ZTdd/Bxq4llXDxjg9Aa86/nyC2qFtyMiUH6330hDmf+PAHhFwOyDdDcUu8/McwMyjwPU9HljkQ4Mz2NIBNsGYZ71v3t24yE8U2F/v1OtCD2NYRLbT/fmUx8YapZC+IXmBXS7+LT7i8PWYIa4NanhwQCk0NNeO2vkPfDiY/qfJJn5IzdxRQz3YyF9dv5n3aj2neKBdcXlY++TrSunjw//p6PUaYDQ0Z7PkZGMV
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5088.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(1800799009)(186009)(451199024)(316002)(71200400001)(6506007)(7696005)(478600001)(26005)(2906002)(9686003)(4744005)(66446008)(110136005)(107886003)(4326008)(54906003)(64756008)(66476007)(66556008)(66946007)(41300700001)(76116006)(7416002)(83380400001)(8936002)(8676002)(86362001)(38100700002)(33656002)(55016003)(38070700005)(122000001)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SHBvR1d0amJjVFBXbVYvVll6dG4vTTlkWkl3NUhPSyt2UmZtYmVPN1F3UmVR?=
 =?utf-8?B?a0tNQWJLUE5HcDgrRHFTU0swbDdtY3VLUlJyKzF6Rmg0emswVmpNakZ4SG9n?=
 =?utf-8?B?eTRmbmlrSmYzNEpPaU1CMFBmc2ZqNkdIVDE1aHZva3JVZDJZdXpBME5tZHNz?=
 =?utf-8?B?MlpMbVBXRjQyYmRFLzQ1NnUvVUVWWkFZcGhIL0FCMGdST2RsU1ZtMnlNUWpJ?=
 =?utf-8?B?aXRrcVAwZWNleEJST1ZkWTl4S0FmS0loeHF0ZEdzNHMzd3R2UFNuQ3drMGR6?=
 =?utf-8?B?cjlDSDliZHlMOWlHTkhsUStRNVAzNSszUURBaVRIOHZUby9jQTRZdEVYSmVL?=
 =?utf-8?B?Ykg0ZklOTHIvd01mR2tzOFREeEtwYm5ZN1JNb1hpNUlNQjl4WEZoVUJTVWFH?=
 =?utf-8?B?bDVxMWlnRkdVMzBWbUV1L3RqK2p1Qko1VGkyNWZ5Zmg3S3pkOCs0TXZLc21R?=
 =?utf-8?B?RmwyaUNPcDFJR1VnenBpdmQ3Tmk1ZzFrSUI5YjMvM3lpNHY4TzhTV3hqTGp4?=
 =?utf-8?B?b05EMy9xRGZiSktHbk5QMHhJazQwYzRMTGxvaE16OTZ6SHBDdWtOSFBEUG11?=
 =?utf-8?B?NFR1TlgvcWdSYXNYSXFxQVRucjhnVTFheUlDVG5zNElZUllXdytGa05CcXI2?=
 =?utf-8?B?RW5Bb0hpd1E5S2RuZzNXQlFUUFJKMzRmVDNpSkMyZThqYzl4dFArS09aSE1E?=
 =?utf-8?B?Vlpmd0Ntb1MyYjlXakg2RGgxeTVCNnhaZWVtdHVEY0VyQ1dTRWZrS01BOEd0?=
 =?utf-8?B?NTQyRmlibm5vK2lwdS9QczhDU2hnMTh3SWhTRkhuM3hoVzgrM0RxcW1CT0I3?=
 =?utf-8?B?SVFXczFQU0NUVDlJdDdlZWhaaDZrTVMzaG5KeEJMWDBHZVVZZ2ZtNGtDenJZ?=
 =?utf-8?B?b1hsZWt3MjRtVkxBcFR5ZTZwaWg1NmFqU2RXWUtneDgyRnJvbjdES1A1Uk9E?=
 =?utf-8?B?LzBRZWVsMnhMWXN6azBwbmpCUkI3eTdlay8yT3ZTYi9yM0xVckJBdXZYc0lp?=
 =?utf-8?B?YWw5d3NLZGwvTnd5T21NbGZjUTBib293ZEhrNDAzbzN6bGgvZEN0cVBMaFRN?=
 =?utf-8?B?LzBGc2tEY1BPQW1JRmdGTUtZTU5xZGwwT3BYTHpYTVNpaXVqNEloMWJxWVRj?=
 =?utf-8?B?SHFVcGhJd29lZEtodWZHN2VxVHBDdThQZGJLaVoveWh6MStSQ096SkZQUzdR?=
 =?utf-8?B?Sm5YYld6UFFiTFU4c2g5ZXRSTUhRTUJCamdvN2NmOWRNTTdLQ1VRazQ4TmNX?=
 =?utf-8?B?LzdVdzdhaTlJOVU4VE5mNzNlM1M0OVFwMDdhWHJCMnNpZ084RFdlVFVVaHVW?=
 =?utf-8?B?RHJ1OTFEbVpRUy9rOXYwRitza3BkVEZka01mMEhmNk4rNjh6S3oxRE96bEVK?=
 =?utf-8?B?WkQ4eVllY3F5dFVRZ0xxM3MreC82REU0VXkvbUJvbHQzb20zN2N5aWJhNWl4?=
 =?utf-8?B?aysyOVZPcmVqbTdDRjhPbkh6Wjc5RW1NeS84SitJWXhBOGl3VWRKOTJrSzVQ?=
 =?utf-8?B?RE5oNjBhYW9GYWtuTEFJTk1JblFFUU91QWdYVCtXWVUxQ1J2UlFYNHgzT2NC?=
 =?utf-8?B?M1JEd2thOHlaUGdYZUQ3cmthaHF3VDlGdFZiOVJqdzU2N3U2OXBabWVndFhD?=
 =?utf-8?B?aDRtRDRxNG5ITFRyUUQ1TUlHRjhuTVhsRmRRN1B5YXRJYlJRS1JYdk54cFVQ?=
 =?utf-8?B?cVJiejZ1cWFrTVAyUGUwWFE3Nlo3djFUNnBiSEppUm9Xb213bWpvemhUOTNt?=
 =?utf-8?B?bmRPeExJL1VIVnA2N0hXekR6UURmNC9KYnRYSk9oNnkxcDR5U242dFVmNlRj?=
 =?utf-8?B?Wms3empXOVZkQ2REeVRQL08xWWt5Sm1NL28zaGhuYklZSnBkUUpQR0pjMXpY?=
 =?utf-8?B?eW5uUWdxSEdHTkwyMjI1a2lYU1krUlpqamJ4cGl1cDRGM091V0JoRGM2ODg4?=
 =?utf-8?B?MmxsUTBaenVldU1UaDZuWFZKM1JaMVc1c3FYYXNaZGE5TTNnOGc2UWlzaG4z?=
 =?utf-8?B?ZW03VG1qZy9IL2ZRYWdrL3Bla0ZwR2R3a3Zvdm9lVlYrZlJ6L0hYajY1cW01?=
 =?utf-8?B?clBySVhWVmlBcEhjQ1BkaHRMWWlyTHpGN2x2aUw3VTV3UU5xdEtpWExhVWJk?=
 =?utf-8?Q?OUUCh+V+xLrotONpzoShf3noX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?ZEFGWDNnNDVpVUN6ZGhVcWVOV01ZVVVIaGpCMm1KYUM0K1ByU21XNnkxMjZw?=
 =?utf-8?B?bXUyTkFGSmsvREpOQlFIdmxHZUQ4c2hBRGlnN2Zxamc2dFdQV0ZWaXh1ZTZJ?=
 =?utf-8?B?YzJiYmhrblR1RmprQUx6WnFpeHp1ejRDYnVtT0VkVEsrcERvQkRPeGhKeEJY?=
 =?utf-8?B?djRGUnV6VWF0NFRycVBtN0dKbmdta01TMHQrV2IvWjJ4UHMxY1gxd2Nwc2Nu?=
 =?utf-8?B?blhvWWkvQWd1aWE4VTdIRmFsNHFxeTNKL1NwNENoVjFHdE5XVmVSRFVId0pp?=
 =?utf-8?B?ZnpiYUdlQ05HMVdtYzNPbHpMQUkxbVp6SjdDY3pIRGRqOFZaZTJydEkyMXNQ?=
 =?utf-8?B?cThrTldBVU1tN2svT1hLUzdOTkZIekpqODRIR3dnWnFkbXA3KzZPOXFTNnpv?=
 =?utf-8?B?OGFCQTZac0k2VVRFckxQRGprcWxhMnpJa0ZTdTBFN3N0TXRnRVdGc0dvSEZu?=
 =?utf-8?B?Q2lZV2NsMThvamNNTVlaaDVzNnRMWGo5TGlDb2VpMXlMbGlwUElKZytnTndz?=
 =?utf-8?B?Qm1JS1V3TG1LSUovNkl0cVJiL2VDY2FKTlF6dXFUblBxbDl1QzVBd2xpdHBS?=
 =?utf-8?B?WmJHeUhzQytRMXJhZVlhWmhLNFBaTVVaVnpFSWhLemRQRWJ5MWxBYUVnaHhv?=
 =?utf-8?B?UkdFaURFRFJMS0Y2V1NHakM4ZlZKdFJFUW1ISEhCQWYycDJGeXhiUStzMG1B?=
 =?utf-8?B?cW1kU2Vja1BHUU5xWE9lT0dodkx5NWdWSS9UQVl4MUs4QnM2TWJZUFNSN21v?=
 =?utf-8?B?dll3VDVuM3ZCTjVmR0JiMmJMUmxIYWdlU2k4TUViTzFNbjF0RHVVQWpWSi93?=
 =?utf-8?B?WjJuemR2RXg4KzJ6eUZJaDA0TTFaN3VZK0gydzhoeVJ4dFVudmptQTJ3RjB1?=
 =?utf-8?B?NzArZW5kWk51Q3I2d3NINzQ1ck5XZHlQMDNoREFWVVJFQWNYbFYyNS9pNWUz?=
 =?utf-8?B?dnNpb3VQMWJocS9WQmxnTEJQQ1JTb090NmNhV2FvUXJlandYenBhUXVldldX?=
 =?utf-8?B?V09sbDZ1ai92U25jMTE4VzlITENLc2tlWkJ0TmFhZlJwVWp5YlIzc21VS2pU?=
 =?utf-8?B?NG9CN2l4TU9heUFXbDc5d3dMRGtEdzYvd00xU1RiQlVXRWtUckJHSXVUQjhQ?=
 =?utf-8?B?MDBLOEkvWk01ejd4NHlzdm51Qi95NStwQzNXYmpvV09RRVNsNW1wSXp1ejQy?=
 =?utf-8?B?VzBMNndXbGIrNEFUMktKc1V6MzNuanlPc2Y1dmdvLzhWY3JST2VjL1dDcW1p?=
 =?utf-8?B?ZFMzdGJKM04vcVMwUjgwUXBZb0NqZHB4RjlmT3NBdjVHcEszcldaUitYWFZw?=
 =?utf-8?B?V0V3bml2RWxidnA0NWZudTFiVVlxTW9FKys3YU9FTEtRcGhyNnVJeFVtZGRk?=
 =?utf-8?B?cEdqc0d1Qmx6SkZEdHhwT3Q0TDZCb3o1Sjc5cElaU3pNQUZTT21CdkRJRTg1?=
 =?utf-8?B?a3NFVHFnbE0rK1pudHA5Y0ZKK3VxMDV0eUUvMDQzZmNRWkd1alRMTkQxMkhZ?=
 =?utf-8?B?M1ZTR011MEhjUGRXTVRodUpXSk5IcHpwRUhWQWg5OGpOTzgyOVJQeXAybWhZ?=
 =?utf-8?B?dEh3ZUZaY3pmanFSSmx1ZDhybTh3Z3d3dEpzaDFnRllUVXRYYzZydy9Kc011?=
 =?utf-8?B?bHlOUUUyOEd2TndHak9UdDVlY1BwdkIwbWVxTEQyV0NtTjhoU2xJanZkK1R2?=
 =?utf-8?B?bHZocG9lMU1sQm1mQnplV1FLaFRWT2VldFFoZjRoYmx3dGlVR2JKZmZmZHFa?=
 =?utf-8?Q?iytXlESHWhBqASONiXFPfkY0B0DG4jx8oRsic99?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5088.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c0f79d-fa26-42bc-0b4a-08dbb3663cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 07:59:49.0713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: koo2uFPLPoqbdd77DRMquOteGKYPDwlee7GYe/uHSSjZWRDP7D5Y+6il6xpgFm9xiHkWDwsDqCWx7Nw5dtT4aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8112
X-Proofpoint-ORIG-GUID: oZTr52DJGloAJMNA93IT5sNxxxjFBQ7f
X-Proofpoint-GUID: oZTr52DJGloAJMNA93IT5sNxxxjFBQ7f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_04,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309120067

RnJvbTogUnVzc2VsbCBLaW5nIChPcmFjbGUpIDxybWsra2VybmVsQGFybWxpbnV4Lm9yZy51az4N
CkRhdGU6IE1vbiwgU2VwIDExLCAyMDIzIGF0IDE2OjI4OjQwDQoNCj4gQWRkIGEgcGxhdGZvcm0g
bGlicmFyeSBvZiBoZWxwZXIgZnVuY3Rpb25zIGZvciBjb21tb24gdHJhaXRzIGluIHRoZQ0KPiBw
bGF0Zm9ybSBkcml2ZXJzLiBDdXJyZW50bHksIHRoaXMgaXMgc2V0dGluZyB0aGUgdHggY2xvY2su
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSdXNzZWxsIEtpbmcgKE9yYWNsZSkgPHJtaytrZXJuZWxA
YXJtbGludXgub3JnLnVrPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8v
c3RtbWFjL01ha2VmaWxlICB8ICAyICstDQo+ICAuLi4vZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMv
c3RtbWFjX3BsYXRfbGliLmMgfCAyOSArKysrKysrKysrKysrKysrKysrDQo+ICAuLi4vZXRoZXJu
ZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFjX3BsYXRfbGliLmggfCAgOCArKysrKw0KDQpXb3VsZG4n
dCBpdCBiZSBiZXR0ZXIgdG8ganVzdCBjYWxsIGl0ICJzdG1tYWNfbGliey5jLC5ofSIgaW4gY2Fz
ZSB3ZSBuZWVkIHRvIGFkZA0KbW9yZSBoZWxwZXJzIG9uIHRoZSBmdXR1cmUgdGhhdCBhcmUgbm90
IG9ubHkgZm9yIHBsYXRmb3JtLWJhc2VkIGRyaXZlcnM/DQoNCkkgYmVsaWV2ZSBpdCdzIGFsc28g
bWlzc2luZyB0aGUgU1BEWCBpZGVudGlmaWVycz8NCg0KVGhhbmtzLA0KSm9zZQ0K

