Return-Path: <bpf+bounces-20725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D108842494
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 13:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D0A1C26EB8
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 12:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD4367E60;
	Tue, 30 Jan 2024 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BbDRvWSM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xiaDDDgO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60C366B37
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616810; cv=fail; b=IPfZwyyGrtR5o1e8c2paHiWZRhEFibWKfbiYqakd5e4Z+Fhty1VYLvyHQzRbH+1QsMUHMNooY+U1vf6lrJInOrJ/tAQHpZshyI3IbQFNBJQTFKqr+QKCD5i/EBLT+DHwZ3wjIlPt5A+xV15E/1T7wjz1OklYcjvc63/BSZOLsQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616810; c=relaxed/simple;
	bh=dL5SRDCMh2qwyx78/wa3qUjPzSFSYIx6OhCWrQTgCC0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=LDAl0OIMOxvkdZoBaJ2gFiFRYPuGWaS3Y42LRow6odxIxcgbgB03RItYuMGP6qOVPwnoZq3AqiGhSR1pr/8QyxiuUWnWRUy/lh2zEBQvj+UfiGupnoArFxA2T2pvTTY4JuEHNwpzCZej3D6z2C/WTAPQbCJu7oSSY1z3e9rac8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BbDRvWSM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xiaDDDgO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40UCA4B4006895;
	Tue, 30 Jan 2024 12:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+6Oaof/rXmH/FBCPTFqjFEi+HiJ8wsrPAiW1ej+sVhM=;
 b=BbDRvWSMJtX9skzsZ+fAo9vV6IkI2tbkahCc+DcV5acCuZcpfQj9zhCZpqtCPSKuYGE1
 LEwbTlzgrJQrFx1Cn+T3J2ontyfEojTbhxDjQsbD20aHAeEhH8+GPJ+Bt30niC6KeWX7
 Cl299d6PjOVK0Iqn3S/GPSg0rsP1lPJvvYrUwzrWNbxzgZ8BWqOGb8J6Bc6IRO3nRMBk
 +dgq8MilfwY40iGYKoG8bK3pT44D1KciqOxKn6P0NjTvicLSF7Pnozy4E0dkPj2i2wfs
 sX+DRszNep/TRu4X/kLjco+Fsod0roZ0zGmHd9Jk2RBmJRW09Dk3LLY40wfObGGqoWUV 9A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrm3xkwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 12:13:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40UC9AMV035335;
	Tue, 30 Jan 2024 12:13:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9d2ptg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 12:13:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adieFrRQhX9OQqEQZzYTvOD6KOZBcxZU44hNsfCqareVH2/C45HMrIyxChezaBVA0SjKZRuOmIIItLc71BuczaAgxLixs6NwyC+ycDxzFpCyOCvGoAO1bvToisKscTj5OkdpDfNJc/EWlFuLAyjmXU9YRAYKth95ZemS9G61nRgwgtqu92635FMX8BGny2gQlI+oTRxJKhT5WbQPqTmtmD8wIfp6lSES/rmnT9J6TE5nTAzwU7yLvGBt588QoZEtSWWaDWIJMs5j0svgZJahGTDGTlwqymLcd5RfHCQ82b3Y4WZCIg9kkLrVLHX6cU4QYcJsOzKCNSZB/sKvYwcs7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6Oaof/rXmH/FBCPTFqjFEi+HiJ8wsrPAiW1ej+sVhM=;
 b=f4+qYj93LJF+xu3VaB93f9MbWqen3o4um4P3TrLVacJdW+Rx3rky0vxQTZcTCxf846btxJp4EEOUSIz2w9s62o1abwzbn0pz4jX8ageP3jQ4sZOsHzNecFVS8bX7i9Tw459SC0Z8Wf8Bu2uOoA9xeSCq/gSpFmNBiBiQxTOwAlZH22r55iNyOypIzapV4IlA/ju5B0XkP+LPgkhWZ2Y2VCQS6s7RiESJ/bFyHSPtk15cVsoX7BMkR4FqBMl/Nk4YSCeGqxUYdVjeaYc4O+nVvox8f1FDtXytnDUyr6Ak4QClYkqHzb4kcbkRLgHzXgJy2tZ3HOeV2sPJWraE57INxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6Oaof/rXmH/FBCPTFqjFEi+HiJ8wsrPAiW1ej+sVhM=;
 b=xiaDDDgOBhfEhhBJ0GXwtcfVq4uBe1Bd7KgifP+9R68xPhOy1dxArLosNiNK1Vc8/xaTrpXAP929eoEVWJEO/hSbGRS4sqtBqrMJkQPOafrYpurD0mkCHoUEkqyKUVy4s02jpb3LNV6Zt10krFSgvhws77mNRBkZMF90cdgXKEs=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by CH3PR10MB7808.namprd10.prod.outlook.com (2603:10b6:610:1ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 12:13:20 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 12:13:19 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Thaler <dthaler1968@googlemail.com>,
        Yonghong Song
 <yonghong.song@linux.dev>, bpf@ietf.org,
        bpf <bpf@vger.kernel.org>
Subject: Re: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
In-Reply-To: <87plxkqr56.fsf@oracle.com> (Jose E. Marchesi's message of "Mon,
	29 Jan 2024 13:07:49 +0100")
References: <006601da5151$a22b2bb0$e6818310$@gmail.com>
	<877cjutxe9.fsf@oracle.com> <8734uitx3m.fsf@oracle.com>
	<01e601da51b7$92c4ffa0$b84efee0$@gmail.com>
	<CAADnVQK8JegsSxgbQbO=DR71cRgkvN-y9LH_ZQYxmj1a-hCz5g@mail.gmail.com>
	<87plxkqr56.fsf@oracle.com>
Date: Tue, 30 Jan 2024 13:13:15 +0100
Message-ID: <87a5onkois.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0123.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::10) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|CH3PR10MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: eea7859a-2c01-4400-e0b4-08dc218cd8a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Aos2W6kcC9s9fV0sJ88/ObEJD263I9sFdldBVuBpbqHCBmD7WK21fg3eNSOkA+obDW6Bf9nyRzM6FVLM+chOsnquU06lkfVFMHUKGZfVGqYQx4XFH+NKINHkpVOdqJ/PnZYOwN+4Vgiiz14LhWMSED3DHW3ZisZtsZiTiypetnGWh+zcf3QulMaiJhRdq4jJ2yFWIVnvSeM5vpd62UNTiNkPJlfW7n5ggaq40G9Z9whExICmGyv5HqizKPoODCfuHer7bCySXbvd6td7d3sh2MYJoPHgtZFD0EW8Y+Ete1dKTvBYujsyCsZAO7uhurhpqpkw7h5BiNprMbMgdcJLCIyexH+NHrSNHFP/qKHN6MoXhkCWRnKDFaaFACZz613bw8pZGSoDWDxH61SwwGprA8NfK1/KuzBRFDrb14pt8oXuMJHmSWkDlSeifLBeettrUt6cVyNj12KXPlsA6JWsKj3GHLlh7OOs/lCk/ob2qukoseGxb3ckqoiKVYos2Q+fZk52Vm1K6jjYBuy5tWeZGroD6CANrNc0zJgBIkLy51z3Oc/EWn/RUSTwzYt6QWY0
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(396003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(86362001)(36756003)(6512007)(2616005)(38100700002)(26005)(6486002)(66556008)(53546011)(6666004)(8676002)(6506007)(2906002)(478600001)(316002)(54906003)(41300700001)(66476007)(66946007)(6916009)(4326008)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VEJueGdMQzhYUWtUZEFSenFOUkpteUNaN2QraU9HeW1uY0RHbDlVeUdjbUpj?=
 =?utf-8?B?a3NTcUVnaldDN2NkWkpSbE9ZbTNRKzBuSmQzSEZFaDJIYnpNbHBaOFNqb0VP?=
 =?utf-8?B?QXpIL0t1Z2VPc0lxRUFMVTBHV1BIN3NXR0lNWFVlQnprMFQ1TFoxVU5WcjRr?=
 =?utf-8?B?d0VMRFhHMkRGQkFoN3ZWeWNld2RpczVHSnRnNnNlQ2xhZmtqQTdxS3h2bG1Y?=
 =?utf-8?B?djBkdk9Yc2IyaHpWM2EzTW9aTWhiN0p1SzY4cHVBWXFNY1lhejRxTTdkT3Vr?=
 =?utf-8?B?ZTNhSVA0T0pNRmVmT044Nk92Ylk1OU41SnJDMHlwNmJnNXhEcFpOaDJ1RkxV?=
 =?utf-8?B?eUY2aWRUdFFkT2ZrRnpuekNWTExBV2RsYzY5ZHkydy9hVVRtWVBPdGxPdkVp?=
 =?utf-8?B?elNwTzBrK0J4RkpqVzZ1UWZhcEVuZGlLYjBvM0ozTzRmSUtBeGwzdSt3czFo?=
 =?utf-8?B?MGE1NENnazhtZmVhV1FOcTJObjFCdXJNOGRpV2dCMFJMTXRpL0o5Vm5Hdklu?=
 =?utf-8?B?MGw0R1lUZTE1THc5NUlLeVZuZFpERWNHbWJHYW1uMVUvajNxVFVWMWY0Zk5S?=
 =?utf-8?B?MXh3VG1jS052UVgyVG93L3lsUVlWcFBUMTdtMXQzUFVQMnRnZmdzdndNT2ly?=
 =?utf-8?B?ZkVYU1QrK0pCLzcyNmNCbXE2Zi9DK2kwSUhXczJJWFhTcWxhZnRCcERtS2Vq?=
 =?utf-8?B?eWUrK0tUVzJncWd6K3cycmhzWHBPVkhUb3dYQkF2KzIzd1Fzd29KSVN1M1Zl?=
 =?utf-8?B?aVZaa3JWRkZ3aUdUM2RtWnkxQXIyTjNUbldFdWN3cHk4SS93c2RHMTJwSmxF?=
 =?utf-8?B?NVpIVlBxMUhHOXkyd1BwZmZFUXlOSGtQYUowTlMvWk5NRUN1OG5JbExEemY3?=
 =?utf-8?B?YmxpYytYS1lFZlJURkNzWXlKQk1aZW9WcnN4Y0dhRjQzWTI2eFcrdDUwVFdm?=
 =?utf-8?B?SUJxZXRzUE4xc3hibUZodkNmOEVyRmVyeStlSW5VWVdDaFEvVTdmVld6bXdX?=
 =?utf-8?B?YmJxaGF0N0w0Z3dMTm1TbWF2VWd3dzlRcVVFd2I1dzJtKzRCa1pGWHhCd1kr?=
 =?utf-8?B?aVFHWFl2RkhwSVN3V252aWE1cHUydEZUQlh4YjZ2Sklhd09XenF4WG5qbGNo?=
 =?utf-8?B?cFBQNmhHQ3k3N1pNdmtTUnpiSk4xL01kd2hpTWdyQWZUeWpqUGRKK3dxRnlq?=
 =?utf-8?B?Z3F1bHh1dkFzL1VmdkRyalZ0eklmRHB2R0YrVzI2elNWaTNCb2NDb2ZsR2tR?=
 =?utf-8?B?M293V25vbERYdFpPNGxhSjRzcFFKQnM4QlRESFkxNVJQMTZBRjAvb09rWE5z?=
 =?utf-8?B?NVBDRzM0Nm1EQzdVUHowU2RkRjZEbmlyclJwc2xMZ0h1UjNuNUxZMnVDZXI1?=
 =?utf-8?B?OWtFOVVoVWpYVGNFWkwyWDViODZzaTN3MkpJN2gyVjAvek1BMUxTQzNXVmtQ?=
 =?utf-8?B?VFA0cERHUlNzTTlSOEJzQldKdTBFUUpJSkRTOTZMQnptMFlLVEJOR1A3VG11?=
 =?utf-8?B?MVo1NUdKd1FjVjdzc2x2Qk91ckc1RFJYSG4vbDE5MFZhT0t3WVhxVm5takph?=
 =?utf-8?B?WFR3ZVhleHhPdVVGY3F2SG5aZFNBYnROL2VQRldYOERFcTJic1pFSXhENTlJ?=
 =?utf-8?B?MmRSbE9ZeCtkS3FhSXNUbnlkbnBjNWtIWE1OZmZhQmpndVpnU05BOUFXZDlR?=
 =?utf-8?B?NHN0OUFreDZDalhUNkJzMmVGK1JXc25yYnFhNGJPZnI4TzdMNEVGUENCS3Fu?=
 =?utf-8?B?WG9xc0JqNnlPWVhlOXdKeGdsUWpzYTVKdnBUYmo2ckJnRmlUaHg2a05VRlQ1?=
 =?utf-8?B?eW5jbVRHcnQ5WDRQOXU4QU02ek11eW5QRE0vNWhoYmwyMHkzR2dycmRMaE9t?=
 =?utf-8?B?QS9CZFUvcWM2T3ZNV0FJNmFGR2s5NVFERTY1MTJ0UmlCWDVZbXBWQXRyNE5i?=
 =?utf-8?B?alpsMzVNZTZuYjgvLzBiZW4vZFNadkJOY2syK3daN2RCK092S0Fabmk5TnJ3?=
 =?utf-8?B?bWRrc1lqZy9RUWVPTU55Vks0WXZzUnByZXpwYVo0RTZXV2UzaDg3TnBDU0Rn?=
 =?utf-8?B?ZTRJRFFvM09ha3V6RW9WM0VwcTdyeTBYMnB3bDBFb05ESW96aFFMVXd2bHJH?=
 =?utf-8?B?NUlvanNmQVo0Mit1NVdjb0RsNU96TGFMbUNxSCt6NmRyMTk0VWpMTnk1cXI2?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Y/xvF0DzHD4ANBqjKcdYgwKImMOvh9dwKNl2IQJGMLE1mtFWGIhihrwwP22tsNwOEzPoMhjGQfSfamCQJmsunGzZ1STTlvVmkUVulvM+zarzFKlxc9eix9gtqB+4UfYAYA6u6umEveZwl1faMSGXZ0pask3LgWAvCc2MhEq9oRR8I8vROIQLXdhrtA+yCnoqCP18A1FrXdTUD/Yk87ILumFgfBj0jKN2+7mOu1QCVOftfUZ0L80obx1KQ59TaAnwfSNLicM9TvGVj0Mch1gbZJMcfz6Zp4oHUnnvLeCB/u3hI4mO1m/G1Dj64hPkyJvMiIBa2oCWnKtr0q6WGqX0aknaGzbV/6jtRS9Dl7w3142ISI/TfaqAThLGkjPaJDrFmrFxoFYjoJJJIZfVhcK1ylcMcwvB2J6qd9aO3qIOuoby+px5ZjoYCb77DNna+FC6akVrGkJbpjqMemOBFjOoMOJKOW8Rdaz7FZO33Pnid/UucguQKmXdHMCfAgIRqscSHX9/WjeSHSEz+Us2yey+cj3Y9GhIvXDUSz4j491jfwfiwW96mQWdTc3dVeHM6gdOklsanuu90I+HeNYIxWvmswfO+eg5GcwUjY1uVlsqGKQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea7859a-2c01-4400-e0b4-08dc218cd8a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 12:13:19.4971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtSclhqdnMUG3uHNth0jRCcpIXAz/w4ChscRuwf82NQPibUKYBeygUZPYWe7dSlPQskT5xGzg04sJuTRTI7JsaSBucimnC04ozXx0h8bkNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300089
X-Proofpoint-GUID: HuSWFNGn0ipzQt6jWKGt83tBvEy7ARa4
X-Proofpoint-ORIG-GUID: HuSWFNGn0ipzQt6jWKGt83tBvEy7ARa4


>> On Sat, Jan 27, 2024 at 10:59=E2=80=AFPM <dthaler1968@googlemail.com> wr=
ote:
>>>
>>> I asked:
>>> > >> What about DW and LDX variants of BPF_IND and BPF_ABS?
>>>
>>> Jose E. Marchesi <jose.marchesi@oracle.com> wrote:
>>> > These we support:
>>> >
>>> >   /* Absolute load instructions, designed to be used in socket filter=
s.
>>> */
>>> >   {BPF_INSN_LDABSB, "ldabsb%W%i32", "r0 =3D * ( u8 * ) skb [ %i32 ]",
>>> >    BPF_V1, BPF_CODE, BPF_CLASS_LD|BPF_SIZE_B|BPF_MODE_ABS},
>>> >   {BPF_INSN_LDABSH, "ldabsh%W%i32", "r0 =3D * ( u16 * ) skb [ %i32 ]"=
,
>>> >    BPF_V1, BPF_CODE, BPF_CLASS_LD|BPF_SIZE_H|BPF_MODE_ABS},
>>> >   {BPF_INSN_LDABSW, "ldabsw%W%i32", "r0 =3D * ( u32 * ) skb [ %i32 ]"=
,
>>> >    BPF_V1, BPF_CODE, BPF_CLASS_LD|BPF_SIZE_W|BPF_MODE_ABS},
>>> >   {BPF_INSN_LDABSDW, "ldabsdw%W%i32", "r0 =3D * ( u64 * ) skb [ %i32 =
]",
>>> >    BPF_V1, BPF_CODE, BPF_CLASS_LD|BPF_SIZE_DW|BPF_MODE_ABS},
>>> >
>>> >   /* Generic load instructions (to register.)  */
>>> >   {BPF_INSN_LDXB, "ldxb%W%dr , [ %sr %o16 ]", "%dr =3D * ( u8 * ) ( %=
sr %o16
>>> )",
>>> >    BPF_V1, BPF_CODE, BPF_CLASS_LDX|BPF_SIZE_B|BPF_MODE_MEM},
>>> >   {BPF_INSN_LDXH, "ldxh%W%dr , [ %sr %o16 ]", "%dr =3D * ( u16 * ) ( =
%sr
>>> %o16
>>> > )",
>>> >    BPF_V1, BPF_CODE, BPF_CLASS_LDX|BPF_SIZE_H|BPF_MODE_MEM},
>>> >   {BPF_INSN_LDXW, "ldxw%W%dr , [ %sr %o16 ]", "%dr =3D * ( u32 * ) ( =
%sr
>>> %o16
>>> > )",
>>> >    BPF_V1, BPF_CODE, BPF_CLASS_LDX|BPF_SIZE_W|BPF_MODE_MEM},
>>> >   {BPF_INSN_LDXDW, "ldxdw%W%dr , [ %sr %o16 ]","%dr =3D * ( u64 * ) (=
 %sr
>>> > %o16 )",
>>> >    BPF_V1, BPF_CODE, BPF_CLASS_LDX|BPF_SIZE_DW|BPF_MODE_MEM},
>>>
>>> Yonghong Song <yonghong.song@linux.dev> wrote:
>>> > I don't know how to do proper wording in the standard. But DW and LDX
>>> > variants of BPF_IND/BPF_ABS are not supported by verifier for now and=
 they
>>> > are considered illegal insns.
>>>
>>> Although the Linux verifier doesn't support them, the fact that gcc doe=
s
>>> support
>>> them tells me that it's probably safest to list the DW and LDX variants=
 as
>>> deprecated as well, which is what the draft already did in the appendix=
 so
>>> that's good (nothing to change there, I think).
>>
>> DW never existed in classic bpf, so abs/ind never had DW flavor.
>> If some assembler/compiler decided to "support" them it's on them.
>> The standard must not list such things as deprecated. They never
>> existed. So nothing is deprecated.
>
> We have no reason to support these instructions in the assembler, and
> GCC certainly never generates these.  So I will remove the ABS/IND DW
> instructions from the assembler today.

This has been done now in upstream binutils.

>> Same with MSH. BPF_LDX | BPF_MSH | BPF_B is the only insn ever existed.
>> It's a legacy insn. Just like abs/ind.

