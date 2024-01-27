Return-Path: <bpf+bounces-20496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D80FE83EFA5
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 20:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ACB81F23B6A
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 19:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFFB2D610;
	Sat, 27 Jan 2024 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="bxrH11V7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="HgdVqVGA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iCCLzmCB";
	dkim=neutral (0-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X/BqGffZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B3D2D60B
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 19:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=50.223.129.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706382397; cv=fail; b=gMURaDAzLDd8zTMc0XgZiq2rkC1QQJJoDkt+2oI5JDfUu6VGKZkqaUzRVj4zzXAtSxpCcyGDiPKIQjpvnpQHPUchmwNz5Yb4+7di3NqTWTmQiM3SsNA3hoBKM1D1PIcI12RqjM7E85J5OAtVsnE0/IzzOVanjOBsP5qSbSyCip8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706382397; c=relaxed/simple;
	bh=kkVKQgQQXuumFpEHuYzymrdbS48ULUvNi9xCDKrOpww=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Subject:Content-Type; b=u80rM0u5Zyok3S/47mKsfvSjMAEsalDPhBTykIXdnMQNGRLgf1t/+LU91DNTQ2RFEBhJSMdTVJYkiHrhFGwbYbJTBMrhcOC+f0rCQwHVyGWLvEBUYkx9fdnby8Nmnf5BKhU5Ax12K8FIpRZNPExyCb/6z1GxGRhJT33FA+yO1Bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=bxrH11V7; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=HgdVqVGA; dkim=fail (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iCCLzmCB reason="signature verification failed"; dkim=neutral (0-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X/BqGffZ; arc=fail smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 12A18C14F70A
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 11:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706382395; bh=kkVKQgQQXuumFpEHuYzymrdbS48ULUvNi9xCDKrOpww=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=bxrH11V7+3kBu4R9nczYhn08c9Ng+S8HnjSXcf+LU0eer3Ii8479MEVXvAuTFEZuJ
	 vZC+cno81If5ZiKlkqtGgUEE/74bqqzF8mMs5MjhSf9agpfTKbjwjP8xe1Y7ow+jcO
	 SbjN0Hs5Vgwtn9RQ7TUx1EcPDWE+zaIyuD8E/d4s=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sat Jan 27 11:06:34 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id C3C2FC14F60B;
	Sat, 27 Jan 2024 11:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706382394; bh=kkVKQgQQXuumFpEHuYzymrdbS48ULUvNi9xCDKrOpww=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=HgdVqVGAgXHY+WRag4wVw8VpYDz0D6NCqL7ofBFsv6kwlAVKqtZCCdyRmhwo6zkTl
	 Q36C+GUYQwTFEj8F2iUUVR4lkynWUWpX5SD+5y2GvC9FuruUBVAthBCrPu/MhGtpHy
	 q0clfV1R+82w32taca4p+OGoNFco46XMce/oWpqY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id CBB14C14F60B;
 Sat, 27 Jan 2024 11:06:33 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.803
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=oracle.com header.b="iCCLzmCB";
 dkim=pass (1024-bit key)
 header.d=oracle.onmicrosoft.com header.b="X/BqGffZ"
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IQx8q4mAiBDu; Sat, 27 Jan 2024 11:06:30 -0800 (PST)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id DD4A7C14F5F7;
 Sat, 27 Jan 2024 11:06:29 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40RGdvcj011356; Sat, 27 Jan 2024 19:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=hb4XSpTMVSplst8q/9b88YL3Q3bTRELsUUyJS6Mibqw=;
 b=iCCLzmCBv61j/VSt0o8kjVCFpL5NRodgwpBiLNRkABsLEqFfBG4tYUr2TTIg+rpAAL5G
 z630Z2nEPARpFJPMgfx5vHPF5EPGaeR/nzwp2G1BqV6v5JQ2GcuWhLHfh6J/biEtC/1y
 Vn6gVIL01wwg4AaOztQtgnt473zAoKGtGwN/2REDnpLzLzB8rmW4915DvE0RZq16m+Ug
 tDCNaTkfu7br6QefTiVxytzhwXGyfBnCylYoo19wizDgLaKeZmnanC5vBQWwfD6+NBRs
 cuvj9tFUsaSy1r+0rdur7ISVVrb1DzN/R5WCAZcU78piZCevCMrarmmu0eauq2coS6E/ CA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvr8e8vfq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 27 Jan 2024 19:06:28 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40RHVecw036092; Sat, 27 Jan 2024 19:06:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vvr9a2r46-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 27 Jan 2024 19:06:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hY8qCzPpUPF+JdNXGEx36PS4TPwlrfRNizjXqJm/vqmLV7TtrGtxKNLacJwhE4KY2YPc6/W7PEkYpwsKDx1hYU0aDhMKc/5EirN3awyrzNqLmTcfhUHDGngPWbL+M55q9HSIinqSGMBPZjjZokA0etOK16XQuKej73VjmN3d5lCrNEQ+adlEAuQO9++qYFj9dcUpc4OPUjNXZ5pDDJ69DGuqsa1MW6WPxpwCTWT9+CGOwrrONKFOV77TxXgoX5/0Jk++8gMqxQI5SRcBoUfO39+NUypt42SzA2P01EWx329GvD98THyJFpyc1agrPi/mHMHQ7flwJFe1ZTMNXSt8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hb4XSpTMVSplst8q/9b88YL3Q3bTRELsUUyJS6Mibqw=;
 b=j0M7S7+1OYG0iagK5HlY8NQdAu7v/5m1NnscnaKrmNK7eXkOeyZ1UpMBiFck1J643D2G3YFxyRExfpoTmRZpnGYTM1J0L3N2ZJB7u50+uJjFtU/wcrtzd6OjMHw66EJixetK3lU5M064D27lmAZAhHBQRAj3dlmNQaInbUtXX2tZCIwfN3Zut8inIk+nz1hVi99XRLIb6geuA60NtKgaDrTijRilNw0SHwEhjQLkJ9a4Xo7Odzms27TyNeecMPaB/NmSUIbjDMjlhMZ6+DoZyCblySAsVeanZsTkwGatXHNFC/W8re34R+vFVzqv/63DAKyHVE09WbjoYg6qap3nCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hb4XSpTMVSplst8q/9b88YL3Q3bTRELsUUyJS6Mibqw=;
 b=X/BqGffZt8ehH3LslU31/butOHB9GZVnb1jJZmJu22ry7Sf7IjQEl5Gdr2qMG04UbjGSm8m9OH8Gj4IrkwB50r6EkHMce9M143vLXNz/O+PXTOsfhXmOqkwNxuHBDn4x5bwRDy3B3jSh/NZfjBohIEn6EAsxCQnnIS3kxp03Ue8=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by LV3PR10MB7961.namprd10.prod.outlook.com (2603:10b6:408:21d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Sat, 27 Jan
 2024 19:06:25 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.029; Sat, 27 Jan 2024
 19:06:25 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: dthaler1968=40googlemail.com@dmarc.ietf.org
Cc: "'Yonghong Song'" <yonghong.song@linux.dev>, <bpf@ietf.org>,
 <bpf@vger.kernel.org>
In-Reply-To: <877cjutxe9.fsf@oracle.com> (Jose E. Marchesi's message of "Sat, 
 27 Jan 2024 19:59:58 +0100")
References: <006601da5151$a22b2bb0$e6818310$@gmail.com>
 <877cjutxe9.fsf@oracle.com>
Date: Sat, 27 Jan 2024 20:06:21 +0100
Message-ID: <8734uitx3m.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-ClientProxiedBy: FR0P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::23) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|LV3PR10MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d988a4-1675-48d2-b5fb-08dc1f6b0ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKRrgZJzSCs9bOtmH1rgb8wxcjb4GPxffMgYSgWRljlIRbaoKd41yp2VzAEZDIz104Iw+h09j46U8fOlkp0dck+JNBfeJCrJ7CDLQFvQibINNaqu867kXmExMfeVTiXhTFlWUXet1S5SE8zemTzM6T7EMmodVcgQ0FAK9QgyD5xc5/AebnvfPACGfVjSY036fjnnFhWetEUEH0SbIf+lRxqFXfI2Rydb9o486ZN22LGgN/CSVvdUDzYp6jwJ0+1JJkV3hDRtcpq9hOZO6wZF34EUZSU+2tCI66LDuwea3Haxo7GW0CbPIvbYf06Zq2BDucpk+/TjBHdFov746W0p5v3wgH/IssP1Y863KplBueRyK/CXYohlU7Xvph7RW43HMFpMpaSrCJjx7fJlD1pKhgcpJ1xDc7i8voubaC+l2bAB2cIy21HUPqHkFTHvviLIsMPlsX003oXBzkOSj4dL4DDpAHANs91vqVPNI8p9Mk15a9MU6AKXmWKx98hwh6PaeYxs7fvahCMBm0pkFkaTB+C3f9W1fdSiboqMtW48D2s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB3113.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(478600001)(966005)(6486002)(6506007)(6666004)(8936002)(66946007)(316002)(8676002)(66556008)(86362001)(54906003)(66476007)(41300700001)(4326008)(36756003)(2906002)(5660300002)(38100700002)(2616005)(6512007)(83380400001)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LlIl+XQdFlNi9GfR9ghX3JFRf/axsmc4xAGIhXbZcsovewOAfEUQecBlEINs?=
 =?us-ascii?Q?PCbcIkGTUTFxSkYUIsLMJ2htzpTuOeAyZlPrMNc2gRH8p2a0dzHDR+hBcJSj?=
 =?us-ascii?Q?Szq2wrqVx+HwdLXVgHOAfCSDY3i5j3xuWs9VNL67/jyArCQyXhvTJvQgRjqH?=
 =?us-ascii?Q?StCOGioviGIQW4PfQR0gwEf0elvpt+AXViemKF82blgJAg9sW3Z6qMJP609L?=
 =?us-ascii?Q?waC8JgMOpvPDPHzjOlrODuy+DryHg+Lk0pntLV0aXKvJKKQBbFTVbyKGCpMG?=
 =?us-ascii?Q?hBSa1gtKyqfCM5G5yauExys7liXvFHHR8YXVC4tnp/beHXRcxB2gN93bKgfz?=
 =?us-ascii?Q?SUYVtJaum/FiWurDjnUNh7En7gUvFJh8eNl6+NipWdCMy2xz1zQMcr88gZT1?=
 =?us-ascii?Q?L2eHX+kQDi5uTGvf6aAMWdT69CtdoLJXT5qT9qVHon58qFmOvTdcFRP2m6Ez?=
 =?us-ascii?Q?2dy7N8MVn+c+e1fEFMD1ASJu2wKmxsJfp8LXahIwHBLaRRm/j6OqoADoHv8B?=
 =?us-ascii?Q?PC9zIwiVNARs9XPYkjWsXQji8TD7JiQwCd8ZlttAyLS9BMTz6z5CTOc1Tejk?=
 =?us-ascii?Q?vQT8IXq+GkLAPtVA7yiVpQAE/QfSIUQlNGm6w59kj7JCOoJov7dxPVBXTIxt?=
 =?us-ascii?Q?GyU3exGRYgpP+IaLGZa+P+yk6b34OZqgp/Porf+tn0uCpE1bRwXLnXJjgVtA?=
 =?us-ascii?Q?TUkSR+zQ3pk15GbsnGrLRqrvITfHnm09MnMqajc1CIwcDVAl4exmTiC/R4lm?=
 =?us-ascii?Q?YYmSUjk3VFGrQFqN35aDQacTAb08zOTsudgJZgo/FfZrPV2pZJ7Qvs/tfQuu?=
 =?us-ascii?Q?xFsqo9JlSFlZ7TK6Gg6zOInsgpYNn2pmEL+WEtjqN2hbkZySy5JZwEa6k9ta?=
 =?us-ascii?Q?14/E9FoE8VJn+ok544g5S9NxLqH7JFz0Nuu8Z0CoXeIrufDPibzyUL/xvUGF?=
 =?us-ascii?Q?Qq8UUq8tI1WXHTXRE+99aXAwa1Lmpz3LZhUh8NclfwauVBqFbjcxvXGAwtLd?=
 =?us-ascii?Q?0q3B992u7LOkQWxpxL27/rKzuE0KjHwx+WBjw8hJBqiQx/hEbLD3eUcHOD3F?=
 =?us-ascii?Q?aAFXHPjtGcg6qGYIey6n1uFQKyMm9Ssn18mR1XQllxVYo/cCyMYV+mP0GlvT?=
 =?us-ascii?Q?ms1KuM4UW7Ci/INeeToSVIx1lOtHPbbdy7sLV3LvVA4Inlk1b1XVc5NJdN4/?=
 =?us-ascii?Q?QbJ2ududnt1iVzb4j2mfVale9zeP+HxxKzsnZzZGk8Kjw1hMqj3ePdTqe1h9?=
 =?us-ascii?Q?/rM2ylYBT1A5eCzjri/odi4sMwANueIJSb18W/VqRxKZRvRkc2C8/2fY6Liv?=
 =?us-ascii?Q?uQ7gxdFq1v69XXOjxJ+suN3cZWVjkX0uu7EG3bqoI+J1sX4k/kmuX44FRltK?=
 =?us-ascii?Q?TKfNwvJpxn/mT68cC3pCVZCf8Fl6rZPpTqUasv+Qi0389OVMdsqp6TzFdteM?=
 =?us-ascii?Q?n9yd17HRRUff07nMnObh463GVldsrDFlqTUIsVhxTFjfYf2UDFH0ZoG727n0?=
 =?us-ascii?Q?sYRE3GitIIgbFmF0lseDKawZ7xJRpCuTBMarFQyVTcD/4CLSqMMlSd92q1Tt?=
 =?us-ascii?Q?Ifgu1KQbqq+jYh1+swrrD8DLYIKkS166aY2uC3mQ0KnEMYtYDRuxKJdx9pEn?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J5IMbC4c7NlTqP6xYCt5nS0xV+ztTXtNP01mfgzu+Bd6nxGUUt7arhBazW3SXNwd0lfUsFj3C9ENOcK4R/vr7CxSNeVAnL+P1xXT5sso1VcvY+CMfE/PE8eo1viAVFRj+9ALM6Xqqjw8uTE9CF6QgxEVE3uiI51VdeFvVQp636dmdGBeS5tWnKT+/np2brI70lrMsamVV/+dqHcUWZ1kgagD83N59c43To+z/bBi+J4Q5MwqBLlp5mw0vtvS4v3DhUinyCW6nFgS5Zo9SfyehYvceazwbS84eQZy/ErE2+2rbAsWPWm5YIY64QZibJEuIlfE4GvE4Fm05ivkiKyKl7e4u5uacXUQPs7i4jqRHRxcRps3OfzHikHdRrnizS343GJt0rM3rV6rouBLihHLjuW8IxTB+FRdNXbKs82PndAzKQ/XqcuGNYLRfFCnr5Y9rt9fMKaoH63BGwFYfS2pzoL17x0heUbNmE9oowbLQl3SmftJhoBIkHu4XNjfYo/Ou7+gZp4Kf2UBrColzyzjPA2R5SoEHr/wnNJUwC2/etOWKY4Psi6NudvtwRosi4NfHVh4f7bQ+dYcTeR3QjcWF/yLYB/k2p31Gcu0aB/wfcU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d988a4-1675-48d2-b5fb-08dc1f6b0ec1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2024 19:06:25.0530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhGNmZ7XgxeGvHdF+ShheZai+VvaC2SRKDGtMFyJV5ZabIQn02ljHg5+SAWQ3uj9QjBdQGyQDnnovoD39Q15bkbIXWp0OxqYespT68hI2cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7961
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401270144
X-Proofpoint-ORIG-GUID: FTiH9JAqIkQE59-xcWiOZRrdpyOts2N7
X-Proofpoint-GUID: FTiH9JAqIkQE59-xcWiOZRrdpyOts2N7
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/CS6UL80Pq39uQQr9BY64MGShh4Q>
Subject: Re: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


> We do not support any load/sotre instruction with mode BPF_MSH in
> binutils.  Should we do so?  What are these?
>
>> Under "Load and store instructions", various mode modifiers are documented.
>> I notice that BPF_MSH (0xa0) is not documented, but appears to be in use in 
>> various projects, including Linux, BSD, seccomp, etc. and is even documented
>> in various books such as
>> https://www.google.com/books/edition/Programming_Linux_Hacker_Tools_Uncovere
>> d/yqHVAwAAQBAJ?hl=en&gbpv=1&dq=%22BPF_MSH%22&pg=PA129&printsec=frontcover
>>
>> Should we document it as deprecated and add it to the set of deprecated
>> instructions (the legacy conformance group) like BPF_ABS and BPF_IND
>> already are?
>>
>> Also, for purposes of the IANA registry of instructions where we list which
>> opcodes are "(deprecated, implementation-specific)", I currently list all
>> possible BPF_ABS and BPF_IND opcodes regardless of whether they were
>> ever used (I didn't check which were used and which might not have been),
>> so I could just list all possible BPF_MSH opcodes similarly.  But if we know
>> that some were never used then I don't need to do so, so I guess I should
>> ask:
>> do we have a list of which combinations were actually used or should we
>> continue to just deprecate all combinations?
>>
>> As an example,
>> https://github.com/seccomp/libseccomp/blob/main/tools/scmp_bpf_disasm.c#L68
>> lists 6 variants of BPF_MSH: LD and LDX, for B, H, and W (but not DW).
>> Other sources like the book page referenced above, and the BSD man page,
>> list only BPF_LDX | BPF_B | BPF_MSH, which is in Linux sources such as
>> https://elixir.bootlin.com/linux/v6.8-rc1/source/lib/test_bpf.c#L368
>>
>> So, should we list the DW variants as deprecated, or never assigned?
>> Should we list the H, W, and LD variants as deprecated, or never assigned?
>>
>> What about DW and LDX variants of BPF_IND and BPF_ABS?

These we support:

  /* Absolute load instructions, designed to be used in socket filters.  */
  {BPF_INSN_LDABSB, "ldabsb%W%i32", "r0 = * ( u8 * ) skb [ %i32 ]",
   BPF_V1, BPF_CODE, BPF_CLASS_LD|BPF_SIZE_B|BPF_MODE_ABS},
  {BPF_INSN_LDABSH, "ldabsh%W%i32", "r0 = * ( u16 * ) skb [ %i32 ]",
   BPF_V1, BPF_CODE, BPF_CLASS_LD|BPF_SIZE_H|BPF_MODE_ABS},
  {BPF_INSN_LDABSW, "ldabsw%W%i32", "r0 = * ( u32 * ) skb [ %i32 ]",
   BPF_V1, BPF_CODE, BPF_CLASS_LD|BPF_SIZE_W|BPF_MODE_ABS},
  {BPF_INSN_LDABSDW, "ldabsdw%W%i32", "r0 = * ( u64 * ) skb [ %i32 ]",
   BPF_V1, BPF_CODE, BPF_CLASS_LD|BPF_SIZE_DW|BPF_MODE_ABS},

  /* Generic load instructions (to register.)  */
  {BPF_INSN_LDXB, "ldxb%W%dr , [ %sr %o16 ]", "%dr = * ( u8 * ) ( %sr %o16 )",
   BPF_V1, BPF_CODE, BPF_CLASS_LDX|BPF_SIZE_B|BPF_MODE_MEM},
  {BPF_INSN_LDXH, "ldxh%W%dr , [ %sr %o16 ]", "%dr = * ( u16 * ) ( %sr %o16 )",
   BPF_V1, BPF_CODE, BPF_CLASS_LDX|BPF_SIZE_H|BPF_MODE_MEM},
  {BPF_INSN_LDXW, "ldxw%W%dr , [ %sr %o16 ]", "%dr = * ( u32 * ) ( %sr %o16 )",
   BPF_V1, BPF_CODE, BPF_CLASS_LDX|BPF_SIZE_W|BPF_MODE_MEM},
  {BPF_INSN_LDXDW, "ldxdw%W%dr , [ %sr %o16 ]","%dr = * ( u64 * ) ( %sr %o16 )",
   BPF_V1, BPF_CODE, BPF_CLASS_LDX|BPF_SIZE_DW|BPF_MODE_MEM},


>> Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

