Return-Path: <bpf+bounces-4120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949C7748F7C
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 23:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66091C20C20
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 21:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5191548F;
	Wed,  5 Jul 2023 21:01:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E8D14276
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 21:01:38 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDFD1700
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 14:01:36 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 813D1C1522AB
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 14:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688590896; bh=NekCa60JuITBhpOV0TLCPTHTGoH7m8Hv1kknx5/sK10=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From;
	b=HSfLM2j5Z0DGut60lHiOse/Q+FuoLo+LPl2Vr++vSNxrac3/jNY+ntSt5/iXisqtJ
	 Svl+t3tSkfQo3+QUll1vBCqrTxcYr8Mx4dnn6TtjtroJad3Yu5mQj9MoAAhKdm3K4O
	 CiQXCqASGev/Lycjc9MIO5wOSdXySH7g+cv04oZ8=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 50EBBC14CE3F;
 Wed,  5 Jul 2023 14:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1688590896; bh=NekCa60JuITBhpOV0TLCPTHTGoH7m8Hv1kknx5/sK10=;
 h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=iUWVwKIE3cNRHQkYUWgxrV5wM52zPFhkfqa/ueMztl1l8l7QRMg2ojWiFQ2RlT3JH
 8Qni8+yU3YlhhVJ8HQDq6HHDxsWH1XOaDocwaF0j4urt46z7Efyj7Z2DNascP9enqx
 9Ok14MD7yH8i71y3xu1dDjrcVgnNGEtn09SFsaic=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id D5E7BC14CE3F
 for <bpf@ietfa.amsl.com>; Wed,  5 Jul 2023 14:01:34 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.096
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=microsoft.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tli6LI5A1UUk for <bpf@ietfa.amsl.com>;
 Wed,  5 Jul 2023 14:01:33 -0700 (PDT)
Received: from BN3PR00CU001.outbound.protection.outlook.com
 (mail-eastus2azon11020017.outbound.protection.outlook.com [52.101.56.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id E5195C14CF1E
 for <bpf@ietf.org>; Wed,  5 Jul 2023 14:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l93dhD0oIaZBgxZgz0zyEYkym4oW233I0B4Ra2/URwr5j7LHOzxIlizaAq+YfJcZnA943JXxEJc9/iBzzn41EJKH17nMIk3tUwDpUQwOi8ofd32nGqzNAjV2PHO2oWMuu3Vy7Z8QxdfhtaGqJuMEEpS0Ofu9VIWpdgjH24r2OgsgDfi5K0Pqth9krT8xZOhgGLTKlg+QROKhXcMekU3LJhfq0iDKixl4XlAkPHnXCKaaLCeUGqIpXB4eFuw5iSUEJG2ZSoNveFlxN8m5TZoC4ExIsM74s0FJAoL8lQum2hVINxaI3WmcKTZzuHW49RfDpn4eX7iAmQQr0m3pfRHmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MO/5jhRVbQkMlhOgEkEA1i4IAXM885JcfeSP4NF01rA=;
 b=GMXFLfuMnFWOLmlVNqdu12gshoYdTgDp/QXAU9yyFIxLkGQV4h56sO6vOXMl9fveb0Fz5zgwpFjf/InvPUL20URoo7ZaGG0C1NQRApHTLxcdbA7PrmSpgwIcXgf3bWOe6HhnRH0RJSA3r2vJtLLBy8qIvmV238/J2/RKWVH08YT3GgyKNrXf7nbWG2q0YQuJ/OuCadLmSr2Dn3W+VVj+4zJA4RI7PsQKS6xS0Ik2FpxW9GKC1wtQBnwo4YOas+Rd9L5qsN+zxrPFqCjatQLT+s/rNd4lbwbrmpM0VBOuqYVZO33Z3qYVZ/SFUxK6g+G3w02NRmzG+9YFh8gIO7Kd5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MO/5jhRVbQkMlhOgEkEA1i4IAXM885JcfeSP4NF01rA=;
 b=U0gDrWP6b/uwrX9tf9NOV8WXzO7d0jtYeXNV2VvxmVzRCFBi7v7MWI/btIZHSrVToSOn+TFDSVzvi179pkOLil4Y5Q666KHYLcOEamHtOgp0J7yjO6R4y+iycKicvBTOlTumzqyZVHPbE2g4bxbhq2wPh6V/0KT0s8+agLyX+/Y=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by CH2PR21MB1432.namprd21.prod.outlook.com (2603:10b6:610:84::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.11; Wed, 5 Jul
 2023 21:01:28 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::8708:6828:fb9f:7bd5]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::8708:6828:fb9f:7bd5%4]) with mapi id 15.20.6544.010; Wed, 5 Jul 2023
 21:01:28 +0000
To: bpf <bpf@vger.kernel.org>, "bpf@ietf.org" <bpf@ietf.org>
Thread-Topic: IETF BPF blog
Thread-Index: Admvg7T9pf8LUVH4Q2ugOXPk1CEBOA==
Date: Wed, 5 Jul 2023 21:01:28 +0000
Message-ID: <PH7PR21MB3878B9CB5354FA71EA90B87EA32FA@PH7PR21MB3878.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=08319211-83cb-4f3c-ae1c-d9a7ee430cb6;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-05T21:00:07Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|CH2PR21MB1432:EE_
x-ms-office365-filtering-correlation-id: f0e06ce3-034a-44f8-e7f1-08db7d9b00a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bMv+HimxoCHjAfzJNXF3HuYtLrn5JpkM5cMKxVGrE+ZrL3/S+VOlvScK3b+lQxxwzkOyIHobAPJ38kv/CjJ89eDEcaRr3jH1xnDEG4xv66GIk6ArOZsNYHwBqoCblTZcKarpeJMISgxVCwby8qFm2/KBXMCSTdKkK+qoh5li9LLP7fRUE5lyP4wp2dlc6Q8PypcIKy1qHm5pRVPMzPza3u2K6MOsO8reCfertnc1cnORc7FEqTfVG7kb0Mce/DdZlxuAJX1hFXDxGwBqJ1D7T+I3ljN70qrqWQ50CrB+VDE/1ATsbA/W64r1ijD8lG7k8l2riGVSDZfVbqJI7JCQLbzFlbufyhG2K0clK1sdbbnK/AMfa0OJBA51yEHSqr85hzjRXvASbs6KrbeqBQrgq0ULeoGwk4fFKUjOr5RwaE41IDmOZFLrEeDc9SfHnYIA7vIOK7RLA4xqP0uxfUiSGEuCZW7aqT54pXIZj4cubcEBTwxKq54Xx2BZ03G8GdGWsVUCcTABLwF069lhECs7DkSCA8QbjS/D3+FmbAOD79ZnSv2Z5POk5CfLWmyWUmFETJjuAvR0UVtt6ImnI6l41m6UgamWSZrRwuM4yyYa+F7G2b1ktB0HyTG8LjSOtRl7F4xu69mj+oznaBVgWyJOuQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:PH7PR21MB3878.namprd21.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(7696005)(10290500003)(478600001)(71200400001)(110136005)(33656002)(86362001)(38070700005)(166002)(3480700007)(55016003)(82960400001)(8990500004)(2906002)(9686003)(26005)(76116006)(6506007)(186003)(966005)(122000001)(38100700002)(82950400001)(64756008)(66946007)(316002)(66446008)(66476007)(66556008)(8676002)(41300700001)(558084003)(8936002)(5660300002)(7116003)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TiyAcOY26MD0gwnkRp+uep+kmu56g9htWCkT+WWHd9hckTnNeOAPmdBUtN0g?=
 =?us-ascii?Q?CmZFFsJg0xEl5pN3qPUFmBUTOccL4CJA61ciZbXDBf2A4tgux4C9QCKh5dEi?=
 =?us-ascii?Q?ncCWDmmfUWToJPydpkthkg525RCK3MODynLff2srLyqwiIYPyWxykIyUmS+w?=
 =?us-ascii?Q?ZaUyR9PsULT83ynA1bEm8SLGrk9sUEjBskqJLf51bbgNFhngxz03QFfPIoFD?=
 =?us-ascii?Q?L2ISMil/WCsouVvKLNQBIX8/6Y5psjm5Qw4U7VIwY8R4ZVI2oE0l8Y6+ezWr?=
 =?us-ascii?Q?rd1R9+Aw4AK1xWa6gPsxXlQ+P+crIax3X/0slBJBjGoMr+WI8uphQmWReXiR?=
 =?us-ascii?Q?EhFNcRQY3M8zra14nOz6qng/a/sOvs7FwxvyTWvHkq28VsFfiawzbh1bVHXc?=
 =?us-ascii?Q?dEKTuW6oc68EgTAqe/m+TeIe9x/ejO9VA8FA30XRzjYcRvG5iCfTvsoBx13n?=
 =?us-ascii?Q?gLPkP9WmcigKcbMfwwrB7PFNPiLQ5una8fpKiUkIbiIfghbat4UNa7WAidK2?=
 =?us-ascii?Q?buYHijT0UvHK3RUStd0/BVtnMZZ4EPgPrDNT3D89HswGA3CjIxSpz+z0tmf0?=
 =?us-ascii?Q?wcA2kqL2suCBMOZy/Evf9+yHzLSDJ+pvT9LtIFImrfDXJvbX+o//3mXAESBL?=
 =?us-ascii?Q?f9wTT7sewMTIRACTa+CSvzy8gw2qVzCgwW9FSgFMN/BT9CEkpG1/MHOEnAF9?=
 =?us-ascii?Q?ORR/yoJnhQqJKTsHkCTrGg9HesFjXlaNSvOCgDHhVDJfSmmis/MnHVWiSclz?=
 =?us-ascii?Q?p8sVYLxnTZ62vPgSXH39DpoVngFxvhJ3nelU8cccHrSnyEx2QdsR7dIZlPFf?=
 =?us-ascii?Q?WXe6xx4T2JWSqrsG3ivnEJ3wTY3UmkAurHA83uelV72RRMGrF7hOj0TidZgL?=
 =?us-ascii?Q?h+o1+6QA/iq7J8UZUWS7oPvQhTA+gdg+eZLNYmrZnuRxZL1r8LY3gBmVyQdL?=
 =?us-ascii?Q?8ROdpq4paWWx5qiLSnW10UwBFwTvGd28vOSJQCbKFfpid45C2xXAnEiXlhBJ?=
 =?us-ascii?Q?LMgtpR3aOxlSCFj/fihQ/+ecs/p0I0XneB3NdTqrprevS0g04tO0KFk+8n/x?=
 =?us-ascii?Q?RqYQiYCTSpI5j3u0ZOF4Lqfz+Y3bVfCKSYdqP6e5nA8QXMzo/9rNtGPp2CdN?=
 =?us-ascii?Q?gPvX8hLpEHfWPjFpoxMdCwYuLrsRIBkY/MpY2CLgM/jCLl/F3HWjMsJkeX2S?=
 =?us-ascii?Q?3fmRolZYgC261VkAE+PHaRU/oo3jgmiwj5e51G2OUxr5w+9mTuGkSVkv09kP?=
 =?us-ascii?Q?P6mQ7f7w1jvtittHnQgQ3MKXPJkHZrkhB8Bkpz4/+zTuc9u1bNbXAh3q1aOn?=
 =?us-ascii?Q?EB3IX4Gf5JzVlim+ARYhEcz9ieI2nKlHbGx5H++Lfz6cm6rzTTJuTOfbm7lV?=
 =?us-ascii?Q?cq26Ew1jc+r/MSW+japjtYtcQk4v5YNryjNlEiqNG9ZfT2IzkFxsbxhor/h4?=
 =?us-ascii?Q?hSIPchcazkglpfOLJ0WvuRfZe2k9VHifQ7DTvPgb1b4yRBi50JqbywesXyHX?=
 =?us-ascii?Q?F+Xv+s1p/JL9nG+IPh5qnqr8OZt7vPkBnzoETm6OPtplkIwarj0cFMvn+ADS?=
 =?us-ascii?Q?o+W4wsz89irO9nPiMJnpTZ/VHEEvrSo1zrLsuCEfVo4N5pFUTUdawVqYVDGi?=
 =?us-ascii?Q?jA=3D=3D?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e06ce3-034a-44f8-e7f1-08db7d9b00a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 21:01:28.6665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TSLP2gDD1YKEY/ahSdPCUtYxkel35xW+IIkr4Gz6E8d2FZ+miOhipNO7DzvtiZUuMPRElpi/2vgnEBSJAQ/FCx/aZ0Ddeoo/8tx4Dvk1Hww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1432
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/L-bKmzj-i1T5LWkyaBaT8_s86vk>
Subject: [Bpf] IETF BPF blog
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
Content-Type: multipart/mixed; boundary="===============0931635130572195107=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Dave Thaler <dthaler@microsoft.com>
From: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--===============0931635130572195107==
Content-Language: en-US
Content-Type: multipart/alternative;
 boundary="_000_PH7PR21MB3878B9CB5354FA71EA90B87EA32FAPH7PR21MB3878namp_"

--_000_PH7PR21MB3878B9CB5354FA71EA90B87EA32FAPH7PR21MB3878namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

David Vernet and Suresh Krishnan published a blog today
about the new IETF BPF working group.

Check it out at https://www.ietf.org/blog/bpf/

Dave Thaler

--_000_PH7PR21MB3878B9CB5354FA71EA90B87EA32FAPH7PR21MB3878namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">David Vernet and Suresh Krishnan published a blog to=
day<br>
about the new IETF BPF working group.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Check it out at <a href=3D"https://www.ietf.org/blog=
/bpf/">https://www.ietf.org/blog/bpf/</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Dave Thaler<o:p></o:p></p>
</div>
</body>
</html>

--_000_PH7PR21MB3878B9CB5354FA71EA90B87EA32FAPH7PR21MB3878namp_--


--===============0931635130572195107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============0931635130572195107==--


