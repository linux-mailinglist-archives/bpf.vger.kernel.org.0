Return-Path: <bpf+bounces-20726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9F3842497
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 13:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE7C1C263A7
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 12:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A9967E7F;
	Tue, 30 Jan 2024 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="VY47aMDP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="VY47aMDP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BbDRvWSM";
	dkim=neutral (0-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xiaDDDgO"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B866775E
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 12:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=50.223.129.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616816; cv=fail; b=lmLDz+LvQ8ailkne2TMU9L/fcxDmGehoQk0vhRGDEqGAPjD9j3QZLuVDh+V+WAAu26IWzodpxhmbAyza3hYHDoaa3KvqzsGuib6yQIpH4Ns6QdO+ERqgellcgh4yyRZxFc3Cjv6zeOSJ7ZEYEzLL/1PoahiTMAG+1uPiHQdIks8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616816; c=relaxed/simple;
	bh=msb/BeeZg30BR+dpRVwLObxIoeQ6IawvHq92aAsBvLw=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Subject:Content-Type; b=JMDlG9Y6TP/djbpaGsc4phGZNpY2DOjIvW0fsxj5xUKv5Ep5dEFTjkpoyVijY25VgpGqk2uD9j64KVSlEDBvIMz4jqObuXC5bhUG/1gZrvzRzW4pwtmZyozHH7gEDKzBYKQllNP/3UOMRK7B4OSbuhBplxguh8AmGd7N9+fKbgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=VY47aMDP; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=VY47aMDP; dkim=fail (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BbDRvWSM reason="signature verification failed"; dkim=neutral (0-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xiaDDDgO; arc=fail smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A7545C2FEE1D
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 04:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706616808; bh=msb/BeeZg30BR+dpRVwLObxIoeQ6IawvHq92aAsBvLw=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=VY47aMDPzUrk0ZuQ/rqsIC+sQDxCzvAyyCpUXAVdMGSQgu0KZ1ImxSUEhXJ7N8gMC
	 hbY5qwGYvzFJk0bCCdkwfPXu3yEnLXlQyrLwTfUoRwkmTB+IGspsx3umKvg+fMGmAY
	 cy7v0HgyKexJtB3HpcajsJBy8ZEwTmiUvGRIOycU=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Jan 30 04:13:28 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7868DC00EA74;
	Tue, 30 Jan 2024 04:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706616808; bh=msb/BeeZg30BR+dpRVwLObxIoeQ6IawvHq92aAsBvLw=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=VY47aMDPzUrk0ZuQ/rqsIC+sQDxCzvAyyCpUXAVdMGSQgu0KZ1ImxSUEhXJ7N8gMC
	 hbY5qwGYvzFJk0bCCdkwfPXu3yEnLXlQyrLwTfUoRwkmTB+IGspsx3umKvg+fMGmAY
	 cy7v0HgyKexJtB3HpcajsJBy8ZEwTmiUvGRIOycU=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 09100C00EA72
 for <bpf@ietfa.amsl.com>; Tue, 30 Jan 2024 04:13:27 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.805
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=oracle.com header.b="BbDRvWSM";
 dkim=pass (1024-bit key)
 header.d=oracle.onmicrosoft.com header.b="xiaDDDgO"
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RNj-nVbW2bSY for <bpf@ietfa.amsl.com>;
 Tue, 30 Jan 2024 04:13:24 -0800 (PST)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 76B87C2FEE1C
 for <bpf@ietf.org>; Tue, 30 Jan 2024 04:13:24 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40UCA4B4006895; Tue, 30 Jan 2024 12:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+6Oaof/rXmH/FBCPTFqjFEi+HiJ8wsrPAiW1ej+sVhM=;
 b=BbDRvWSMJtX9skzsZ+fAo9vV6IkI2tbkahCc+DcV5acCuZcpfQj9zhCZpqtCPSKuYGE1
 LEwbTlzgrJQrFx1Cn+T3J2ontyfEojTbhxDjQsbD20aHAeEhH8+GPJ+Bt30niC6KeWX7
 Cl299d6PjOVK0Iqn3S/GPSg0rsP1lPJvvYrUwzrWNbxzgZ8BWqOGb8J6Bc6IRO3nRMBk
 +dgq8MilfwY40iGYKoG8bK3pT44D1KciqOxKn6P0NjTvicLSF7Pnozy4E0dkPj2i2wfs
 sX+DRszNep/TRu4X/kLjco+Fsod0roZ0zGmHd9Jk2RBmJRW09Dk3LLY40wfObGGqoWUV 9A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrm3xkwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jan 2024 12:13:22 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40UC9AMV035335; Tue, 30 Jan 2024 12:13:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vvr9d2ptg-1
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
Cc: Dave Thaler <dthaler1968@googlemail.com>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@ietf.org, bpf <bpf@vger.kernel.org>
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
X-Microsoft-Antispam-Message-Info: Aos2W6kcC9s9fV0sJ88/ObEJD263I9sFdldBVuBpbqHCBmD7WK21fg3eNSOkA+obDW6Bf9nyRzM6FVLM+chOsnquU06lkfVFMHUKGZfVGqYQx4XFH+NKINHkpVOdqJ/PnZYOwN+4Vgiiz14LhWMSED3DHW3ZisZtsZiTiypetnGWh+zcf3QulMaiJhRdq4jJ2yFWIVnvSeM5vpd62UNTiNkPJlfW7n5ggaq40G9Z9whExICmGyv5HqizKPoODCfuHer7bCySXbvd6td7d3sh2MYJoPHgtZFD0EW8Y+Ete1dKTvBYujsyCsZAO7uhurhpqpkw7h5BiNprMbMgdcJLCIyexH+NHrSNHFP/qKHN6MoXhkCWRnKDFaaFACZz613bw8pZGSoDWDxH61SwwGprA8NfK1/KuzBRFDrb14pt8oXuMJHmSWkDlSeifLBeettrUt6cVyNj12KXPlsA6JWsKj3GHLlh7OOs/lCk/ob2qukoseGxb3ckqoiKVYos2Q+fZk52Vm1K6jjYBuy5tWeZGroD6CANrNc0zJgBIkLy51z3Oc/EWn/RUSTwzYt6QWY0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB3113.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39860400002)(376002)(396003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(86362001)(36756003)(6512007)(2616005)(38100700002)(26005)(6486002)(66556008)(53546011)(6666004)(8676002)(6506007)(2906002)(478600001)(316002)(54906003)(41300700001)(66476007)(66946007)(6916009)(4326008)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEJueGdMQzhYUWtUZEFSenFOUkpteUNaN2QraU9HeW1uY0RHbDlVeUdjbUpj?=
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
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y/xvF0DzHD4ANBqjKcdYgwKImMOvh9dwKNl2IQJGMLE1mtFWGIhihrwwP22tsNwOEzPoMhjGQfSfamCQJmsunGzZ1STTlvVmkUVulvM+zarzFKlxc9eix9gtqB+4UfYAYA6u6umEveZwl1faMSGXZ0pask3LgWAvCc2MhEq9oRR8I8vROIQLXdhrtA+yCnoqCP18A1FrXdTUD/Yk87ILumFgfBj0jKN2+7mOu1QCVOftfUZ0L80obx1KQ59TaAnwfSNLicM9TvGVj0Mch1gbZJMcfz6Zp4oHUnnvLeCB/u3hI4mO1m/G1Dj64hPkyJvMiIBa2oCWnKtr0q6WGqX0aknaGzbV/6jtRS9Dl7w3142ISI/TfaqAThLGkjPaJDrFmrFxoFYjoJJJIZfVhcK1ylcMcwvB2J6qd9aO3qIOuoby+px5ZjoYCb77DNna+FC6akVrGkJbpjqMemOBFjOoMOJKOW8Rdaz7FZO33Pnid/UucguQKmXdHMCfAgIRqscSHX9/WjeSHSEz+Us2yey+cj3Y9GhIvXDUSz4j491jfwfiwW96mQWdTc3dVeHM6gdOklsanuu90I+HeNYIxWvmswfO+eg5GcwUjY1uVlsqGKQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea7859a-2c01-4400-e0b4-08dc218cd8a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 12:13:19.4971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtSclhqdnMUG3uHNth0jRCcpIXAz/w4ChscRuwf82NQPibUKYBeygUZPYWe7dSlPQskT5xGzg04sJuTRTI7JsaSBucimnC04ozXx0h8bkNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300089
X-Proofpoint-GUID: HuSWFNGn0ipzQt6jWKGt83tBvEy7ARa4
X-Proofpoint-ORIG-GUID: HuSWFNGn0ipzQt6jWKGt83tBvEy7ARa4
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/AdtudkdnEqCpgz3gPv-Q_lAGt9Q>
Subject: Re: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

Cj4+IE9uIFNhdCwgSmFuIDI3LCAyMDI0IGF0IDEwOjU54oCvUE0gPGR0aGFsZXIxOTY4QGdvb2ds
ZW1haWwuY29tPiB3cm90ZToKPj4+Cj4+PiBJIGFza2VkOgo+Pj4gPiA+PiBXaGF0IGFib3V0IERX
IGFuZCBMRFggdmFyaWFudHMgb2YgQlBGX0lORCBhbmQgQlBGX0FCUz8KPj4+Cj4+PiBKb3NlIEUu
IE1hcmNoZXNpIDxqb3NlLm1hcmNoZXNpQG9yYWNsZS5jb20+IHdyb3RlOgo+Pj4gPiBUaGVzZSB3
ZSBzdXBwb3J0Ogo+Pj4gPgo+Pj4gPiAgIC8qIEFic29sdXRlIGxvYWQgaW5zdHJ1Y3Rpb25zLCBk
ZXNpZ25lZCB0byBiZSB1c2VkIGluIHNvY2tldCBmaWx0ZXJzLgo+Pj4gKi8KPj4+ID4gICB7QlBG
X0lOU05fTERBQlNCLCAibGRhYnNiJVclaTMyIiwgInIwID0gKiAoIHU4ICogKSBza2IgWyAlaTMy
IF0iLAo+Pj4gPiAgICBCUEZfVjEsIEJQRl9DT0RFLCBCUEZfQ0xBU1NfTER8QlBGX1NJWkVfQnxC
UEZfTU9ERV9BQlN9LAo+Pj4gPiAgIHtCUEZfSU5TTl9MREFCU0gsICJsZGFic2glVyVpMzIiLCAi
cjAgPSAqICggdTE2ICogKSBza2IgWyAlaTMyIF0iLAo+Pj4gPiAgICBCUEZfVjEsIEJQRl9DT0RF
LCBCUEZfQ0xBU1NfTER8QlBGX1NJWkVfSHxCUEZfTU9ERV9BQlN9LAo+Pj4gPiAgIHtCUEZfSU5T
Tl9MREFCU1csICJsZGFic3clVyVpMzIiLCAicjAgPSAqICggdTMyICogKSBza2IgWyAlaTMyIF0i
LAo+Pj4gPiAgICBCUEZfVjEsIEJQRl9DT0RFLCBCUEZfQ0xBU1NfTER8QlBGX1NJWkVfV3xCUEZf
TU9ERV9BQlN9LAo+Pj4gPiAgIHtCUEZfSU5TTl9MREFCU0RXLCAibGRhYnNkdyVXJWkzMiIsICJy
MCA9ICogKCB1NjQgKiApIHNrYiBbICVpMzIgXSIsCj4+PiA+ICAgIEJQRl9WMSwgQlBGX0NPREUs
IEJQRl9DTEFTU19MRHxCUEZfU0laRV9EV3xCUEZfTU9ERV9BQlN9LAo+Pj4gPgo+Pj4gPiAgIC8q
IEdlbmVyaWMgbG9hZCBpbnN0cnVjdGlvbnMgKHRvIHJlZ2lzdGVyLikgICovCj4+PiA+ICAge0JQ
Rl9JTlNOX0xEWEIsICJsZHhiJVclZHIgLCBbICVzciAlbzE2IF0iLCAiJWRyID0gKiAoIHU4ICog
KSAoICVzciAlbzE2Cj4+PiApIiwKPj4+ID4gICAgQlBGX1YxLCBCUEZfQ09ERSwgQlBGX0NMQVNT
X0xEWHxCUEZfU0laRV9CfEJQRl9NT0RFX01FTX0sCj4+PiA+ICAge0JQRl9JTlNOX0xEWEgsICJs
ZHhoJVclZHIgLCBbICVzciAlbzE2IF0iLCAiJWRyID0gKiAoIHUxNiAqICkgKCAlc3IKPj4+ICVv
MTYKPj4+ID4gKSIsCj4+PiA+ICAgIEJQRl9WMSwgQlBGX0NPREUsIEJQRl9DTEFTU19MRFh8QlBG
X1NJWkVfSHxCUEZfTU9ERV9NRU19LAo+Pj4gPiAgIHtCUEZfSU5TTl9MRFhXLCAibGR4dyVXJWRy
ICwgWyAlc3IgJW8xNiBdIiwgIiVkciA9ICogKCB1MzIgKiApICggJXNyCj4+PiAlbzE2Cj4+PiA+
ICkiLAo+Pj4gPiAgICBCUEZfVjEsIEJQRl9DT0RFLCBCUEZfQ0xBU1NfTERYfEJQRl9TSVpFX1d8
QlBGX01PREVfTUVNfSwKPj4+ID4gICB7QlBGX0lOU05fTERYRFcsICJsZHhkdyVXJWRyICwgWyAl
c3IgJW8xNiBdIiwiJWRyID0gKiAoIHU2NCAqICkgKCAlc3IKPj4+ID4gJW8xNiApIiwKPj4+ID4g
ICAgQlBGX1YxLCBCUEZfQ09ERSwgQlBGX0NMQVNTX0xEWHxCUEZfU0laRV9EV3xCUEZfTU9ERV9N
RU19LAo+Pj4KPj4+IFlvbmdob25nIFNvbmcgPHlvbmdob25nLnNvbmdAbGludXguZGV2PiB3cm90
ZToKPj4+ID4gSSBkb24ndCBrbm93IGhvdyB0byBkbyBwcm9wZXIgd29yZGluZyBpbiB0aGUgc3Rh
bmRhcmQuIEJ1dCBEVyBhbmQgTERYCj4+PiA+IHZhcmlhbnRzIG9mIEJQRl9JTkQvQlBGX0FCUyBh
cmUgbm90IHN1cHBvcnRlZCBieSB2ZXJpZmllciBmb3Igbm93IGFuZCB0aGV5Cj4+PiA+IGFyZSBj
b25zaWRlcmVkIGlsbGVnYWwgaW5zbnMuCj4+Pgo+Pj4gQWx0aG91Z2ggdGhlIExpbnV4IHZlcmlm
aWVyIGRvZXNuJ3Qgc3VwcG9ydCB0aGVtLCB0aGUgZmFjdCB0aGF0IGdjYyBkb2VzCj4+PiBzdXBw
b3J0Cj4+PiB0aGVtIHRlbGxzIG1lIHRoYXQgaXQncyBwcm9iYWJseSBzYWZlc3QgdG8gbGlzdCB0
aGUgRFcgYW5kIExEWCB2YXJpYW50cyBhcwo+Pj4gZGVwcmVjYXRlZCBhcyB3ZWxsLCB3aGljaCBp
cyB3aGF0IHRoZSBkcmFmdCBhbHJlYWR5IGRpZCBpbiB0aGUgYXBwZW5kaXggc28KPj4+IHRoYXQn
cyBnb29kIChub3RoaW5nIHRvIGNoYW5nZSB0aGVyZSwgSSB0aGluaykuCj4+Cj4+IERXIG5ldmVy
IGV4aXN0ZWQgaW4gY2xhc3NpYyBicGYsIHNvIGFicy9pbmQgbmV2ZXIgaGFkIERXIGZsYXZvci4K
Pj4gSWYgc29tZSBhc3NlbWJsZXIvY29tcGlsZXIgZGVjaWRlZCB0byAic3VwcG9ydCIgdGhlbSBp
dCdzIG9uIHRoZW0uCj4+IFRoZSBzdGFuZGFyZCBtdXN0IG5vdCBsaXN0IHN1Y2ggdGhpbmdzIGFz
IGRlcHJlY2F0ZWQuIFRoZXkgbmV2ZXIKPj4gZXhpc3RlZC4gU28gbm90aGluZyBpcyBkZXByZWNh
dGVkLgo+Cj4gV2UgaGF2ZSBubyByZWFzb24gdG8gc3VwcG9ydCB0aGVzZSBpbnN0cnVjdGlvbnMg
aW4gdGhlIGFzc2VtYmxlciwgYW5kCj4gR0NDIGNlcnRhaW5seSBuZXZlciBnZW5lcmF0ZXMgdGhl
c2UuICBTbyBJIHdpbGwgcmVtb3ZlIHRoZSBBQlMvSU5EIERXCj4gaW5zdHJ1Y3Rpb25zIGZyb20g
dGhlIGFzc2VtYmxlciB0b2RheS4KClRoaXMgaGFzIGJlZW4gZG9uZSBub3cgaW4gdXBzdHJlYW0g
YmludXRpbHMuCgo+PiBTYW1lIHdpdGggTVNILiBCUEZfTERYIHwgQlBGX01TSCB8IEJQRl9CIGlz
IHRoZSBvbmx5IGluc24gZXZlciBleGlzdGVkLgo+PiBJdCdzIGEgbGVnYWN5IGluc24uIEp1c3Qg
bGlrZSBhYnMvaW5kLgoKLS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYub3JnCmh0dHBzOi8v
d3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

