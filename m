Return-Path: <bpf+bounces-12137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 126757C8518
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 13:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C371C20FB1
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 11:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26781400A;
	Fri, 13 Oct 2023 11:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SP3Cb/1b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jRwhjqBG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA8213AEC
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 11:55:17 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CA1A9
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 04:55:14 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D7NuWb009542;
	Fri, 13 Oct 2023 11:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=q52gi5w4UrX5Gai1lKNeI/mxrRef18HeZfywHtiAA7s=;
 b=SP3Cb/1bCy9b5YAh7TD/sl2fxJEmXjhUZpBEHdS21sKZB9CU3i8MGMXYTYx2GdAmhJ6V
 6iuzIyyU8TVp22cVKNkYQ+W/r9kqaD9hJ9OJXb015p9OZ+YWU7hTfGEfej9fQtGG/pZi
 eGqStNW3gm6RJTN0PNpUm0Y23b68DRL5kCc8/tQB78TH0rgCKwMZ5csvbqiRoM3EWzjh
 uPdbEqrlNqesj5+epF8x/TPCiYk7jo+lJwX2HcRNsgaVC0+w5PlcDqzFkHpIYmiOxvmG
 a0yc46e2670s0KzMEJ3LNy9PMbY615+aXUzXwqLfIFbpn/Be3z73KHicOYi7tyyRKh9i Mw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjycdvxke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Oct 2023 11:54:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39DAxHcJ022766;
	Fri, 13 Oct 2023 11:54:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tptas826b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Oct 2023 11:54:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHXtuPdAwe00uaxwwBg9ROPTFOxUyYVTuyCM2R3mgeD2YT/ATQ8mAewsyCmQVTuNKSgpK6pZftNFXQ21bM1ES8nRDcgyiKz2gEBEzvEqM2Qp7tt3G7sg6mT41nehRcONSzG2+eGCdC/N23WZ1BHkQshCkuT34ZebFNg6GKyV15nPrny7d2Ckou/wX3JCFkDTLKZeVlTUsxyudidOQOXKtprRTD/nS7iDxLhWMv9xlXzPmXcDnLzpTVysAnl+GPBL9HknKhbxEarGXgq2CRQnDtADGUcy/QXgOEPECMZBmINFR+gi5EaXboMyZSd85vhhKXfV84smN0G0Jetb3fet0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q52gi5w4UrX5Gai1lKNeI/mxrRef18HeZfywHtiAA7s=;
 b=llz0meMD5bq1wjiJP+2Bj1RupmSeFxKPINXYQwbQAuHqrjJ2JV8hP+cWFugxeVkmMiLmI2UIgfvnBtZHd5bJtDrNLxG9HHxdCl4MRAW5uOYru8MFGfLpl079qrYz44WiviJfuMN7uM3NdoElRD/zx5zjKYqWKyhvuOlDliUFdwUEBIimLpFt80LZoIUzxEYuiCPQlnTBCKq8xzC0sHcjnJ7gp40o3pr6MyACDuO64WonA5Cycd75szcL8fyoAj2ReEI5SsY4TnfyVDoQHZ/Lmf5V+0wxHYkDSy3TcT1A6MR4emWcBvjE0rxiVOoxcxMIRTdOsypL5jxdDh3kg9gLZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q52gi5w4UrX5Gai1lKNeI/mxrRef18HeZfywHtiAA7s=;
 b=jRwhjqBGoEMjSPKwU8kH2nhxgbTd7MJ3u8pe0S7LjVwCVemkrz8mDDIuXR0TX8YvL2tzsPukHNpc3pHP0QmsuQ3K19ItBqoHALqnr/hfkHANvn8ygFtIk/JwNBK/fkS/yi6UIRO/6uoYq/YTtSKR3pTi5pRcNGnrDqRh8NPuixQ=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 CY5PR10MB5985.namprd10.prod.outlook.com (2603:10b6:930:2b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Fri, 13 Oct 2023 11:54:50 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::9914:632d:759e:f34]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::9914:632d:759e:f34%7]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 11:54:50 +0000
Message-ID: <698efb39-c5d2-c322-e83c-f836c0166bd7@oracle.com>
Date: Fri, 13 Oct 2023 12:54:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC dwarves 3/4] pahole: add
 --btf_features=feature1[,feature2...] support
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: acme@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
References: <20231011091732.93254-1-alan.maguire@oracle.com>
 <20231011091732.93254-4-alan.maguire@oracle.com>
 <CAEf4BzZOMOBpwT6wkXeoh9gBQa5jruE=ynsH-1FOB6TRDxFqzQ@mail.gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzZOMOBpwT6wkXeoh9gBQa5jruE=ynsH-1FOB6TRDxFqzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0031.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::19) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|CY5PR10MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a5e754-6e16-49d4-35a4-08dbcbe3347a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EvkNCWDuVUXzPATIwE4pHMIR/MGSUQ1P25VMIqYtWB6GRECxlDIzygVG0imcXUcO8v6vrmgCKBLnZnr0oKZmfrj4eNcllrUFJR/b3vba5allXFByjZ/NLlH2VxNLFw3RLCx6+Rg4V1vC0ykpPXuELWPrGHZ6WAb4jzkfWGb/vuvB7cxS8AVsO3/JalC7l14pMSq93dJwBdmsrnQ2Ep9wELlkuUKDHvQTrrc5fcoDWQriR5Gq+J/k7Q4Xkp+JAJsWsHSPCeVMkkkuKzpB0RzNoDeUORfz3UVPHbZ7RxOI3uBdJoPzZBl6KgoFXF8ZKlGIsUou8UhMJ5zd8WJ7IOhS+sNWm/MvqoIF8vj6dGpMT1xjwGB5vEXpQ6HZITVjaOOkqcevqyhkUIXgTx9lfZJ8Ii2m9Bq2PAjGmfQrv9lIN/QYSRNSTgiVuTsHi7eySXJQnuNmOQgiCgMioZa9vPXbu5GFee7OiD4StcEg9SQWIP0NE84FMJMWBlzhjrHkb5MkBE/jMeGXdPfDDEpw8VONyvVY30Nv/i98VGIX4iR6AfLBmuvgI6UYa0a6XLu20FwZuVUZg0snrfoAd90oWckiAEBmsFmSZpofs9mBo0YzdRNBXnClgnKKRiLH7T9x3djOcHz7/vXMk3bbYvYKRtQNsg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(5660300002)(2906002)(7416002)(86362001)(36756003)(31696002)(38100700002)(6916009)(2616005)(316002)(66946007)(41300700001)(66476007)(66556008)(6666004)(31686004)(6486002)(6512007)(6506007)(53546011)(478600001)(83380400001)(44832011)(8936002)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bkJxd3Zsc2FMOU42MEx1OEdVNTNEZEZVemlBVHZ0N3pqTFlENHkwelZ2bFBL?=
 =?utf-8?B?K1FWSW5oK2NVWVlBc2s1N2R6dUtpZ1RTR2M4ZkhWL0x6RCsrNWRRNnZ5TGN4?=
 =?utf-8?B?dkdtQjdTK0dRNnE5Zlp4WEhlNXQvanBzQVE1UG9hRUl2eTRRRUtDSlVKbkVK?=
 =?utf-8?B?Rm9qTlhmcG8xS0ppRXM5My9OaXlKQmVMNUZPeUVtWTVSWTdnb0kyMUNtdmdr?=
 =?utf-8?B?SVhibkI1akpqUzR1Y1V4NjRINVNSdmh5R1hGWU9EYTJsZkI4dmZZaDdVTEhn?=
 =?utf-8?B?YlYwOUNzQ2dxTlJvRjA5RS9BUUh0MlpnOElIbjdqL2huRUFlRHhrdDFHZUtJ?=
 =?utf-8?B?Mk92eGd2WStyQitKaXd3Z3phL0YyQ0R4TEJMVmhKelUvU0hzaHlDY25aZUda?=
 =?utf-8?B?QnZFaWR4ZUdkd1VtbUNXbmN6YWpWZGFzblllNnA3bG5BcERuT0hDRUNmSWls?=
 =?utf-8?B?R2loNGxTbGNWQ1ZDTHBVOUJ0QXhNWjNSekxwTGVqa05BcGVLNTZDRUNDTlhE?=
 =?utf-8?B?L0JFYmE1Zmo1UUpCWkhvQ1A5VHl2T1FDeU5PL0F2ZWtGcGplcUtHeDdFZWhs?=
 =?utf-8?B?cUIzc0tqSXQyZFl5R1lxZ3dpeHBINnBoODE4enlJcmZaU0FHSFcyZUhPK0NP?=
 =?utf-8?B?ZEdiRmJlQVpwck9rOXh3UDBPaENBU3JzS1hodFVVSURDbmlNWkplSVJPcHNs?=
 =?utf-8?B?SWNTKy9HV2QrM29HRUZBQ2V3QmlJU0tuaUkyWXI4V1N5RXltTHYzTVZ3L081?=
 =?utf-8?B?OE5ibmI5M25WUUdjVGltQUozVnV3cWllWVdyM0NvNXJabXhmSnU4OG5QeEJx?=
 =?utf-8?B?OCthMGZ6QS9aSHV1OWZwN0F4RzE1VUhZSU5aSEFHZEx2aEVIV0ZhNUhUMzRO?=
 =?utf-8?B?YjMrT0RscURWTUdvYzJ0ZkxYQkZwRnhTU2VYalc1NXZLYVpFSUhDaUZWWUYz?=
 =?utf-8?B?NDZVaWdJZVg3ZVdZaytlZWJxVVliUEdwSXNVbGZqSEpETDhpSWVFaDNKR0dU?=
 =?utf-8?B?aTNUZE5rVWJzTlY0V2pTcGlJbm1IQ3Q5UmgrdzhnbjZnTXJnbUFKSnYxdkpj?=
 =?utf-8?B?UE1GTVFjQkRFRjhpNERLSXd4bDFxVDBXY3p1WHdVNHVpak9SRVYyVllYK2Jw?=
 =?utf-8?B?WXdPalhHSkRpWEs0d0ZlSzJuakVZVWpRbHZ6M01SSmxIR0t0djVLMHNURVN6?=
 =?utf-8?B?QjFxTG0yVHlFcFMrcHJVZnpkeisxZDNsc2pXTWpvV3VnVnRDMGtzUlNhUnJ5?=
 =?utf-8?B?eFlua2dHYmNuVXl1b2dLU3hYeFZpRHlLTUlYbExZMVV0a1BLT051VEU0V1Fn?=
 =?utf-8?B?RlU3eHdQOVgxMllYVFM4WkVZZHlmb0lGc2tNUDZIWG1Dd3hJUzM2UjZidTI3?=
 =?utf-8?B?dW5mK09ZZVcyRFFuT0RmOGJEWVVEVlk3UFdJMTBXeWNkandrUDZUY3RERExL?=
 =?utf-8?B?Z0tHYng2amQ2Tno3ZHROOXlpalBjNlljTjlpR1dJOCtjWUd3a2pBa1hPMklj?=
 =?utf-8?B?N1F0cVA0ZDZIYm1aM0gxNGRRcWxvN0JNY3FDQmdCbGN0VXI4ZkpMVnFBT0d4?=
 =?utf-8?B?L1J2Q3N1aTF3cXZCRzNTVzYrWTllSGxKUWp6TWZubGVDZ3NoRGVHUWJGMXN6?=
 =?utf-8?B?cUtNUE44aG5aei9rdnhIY3hoYzk1M291ek1XcUVsTUV0NU5ua0cvR1l4ZnlN?=
 =?utf-8?B?ZDlhMWJkQXgxQlhyaEVBUEdPN1c2YjVyZjd4V1RiRFhkdW5OVVRRQ29tNS9r?=
 =?utf-8?B?MWt4dVBDM2QyZCtEeWRlYmRpSW80dGpFVE1aZHZiSHloTjhpTk1oZlJvVFBk?=
 =?utf-8?B?Q3M2NE5aVWtrL3l5UjNpYTZ6bFdSYnFWMUZhUDkxcHNONnRzKzEzVmRncTJQ?=
 =?utf-8?B?aHhqcTltQUljSW11ZVJ0S1VGdmVEbCtJMG03dG8vMzlPQkc4d0FUTUFIclF0?=
 =?utf-8?B?TE9iOWh5ZlYyRUxGdGxMS1RUV0RsVmx6UVhxWnRDb0VFaHNlcjF1ZEJkQm5X?=
 =?utf-8?B?RU5mNnBUZ1hxM0JvTnFJOGtaZWNGdFEwYVNGa0ZRaDdCdWtLZXd5Y1l1cXkr?=
 =?utf-8?B?aXJzb09DK1FrZkNBR29yVm9SR2poUy9QRWYxdjlVRjZOVWphczdKM2trVHZu?=
 =?utf-8?B?Tm1XZTRGRWFycHNPSkVLZHg4eGNEZ05WOUZCOUJPWjFrMjRVQ1FKMzM1K2N1?=
 =?utf-8?Q?dtO2I/TNbQ5rin/qkUgI51U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?aHZSVjBNd1NYUHg4Q084ZzM2dnlCcnhkamRsNEluTzhzK3ViWHlDbUhMcHM4?=
 =?utf-8?B?V1ZtNWdlTjQvME51VC9PRHJHSFBOZEJLcnFtVTFPOS90eFc3L1k3bC9yWXUz?=
 =?utf-8?B?VTYvRVZxRHZrcWtRL29iOXd5QmNFUklFcWh4OXVkbDhyMC9mOGdObnBKdjdF?=
 =?utf-8?B?SkZyRnJsZG03YisxL2RYc21YSkhXbFpycEJ6UkduQWYwSllkZ08yUWsxOTl6?=
 =?utf-8?B?K2V0ZzltQmkvOFhLeERzeEFxdWxjbnJPNDJmTUZaR1RLKzlOQTF5L1oxVUVH?=
 =?utf-8?B?S1BLZk9BQXdqTkh6SDU0L3pKTWFXTVZmMTd4MzY2TWhpV1hHZ290N3BOdDI3?=
 =?utf-8?B?MG1mVk9PNE52OEpjSmZxeTFLTkpRdTl2cjBQbVZ1TnVhSjBOM08vWHFmUXZi?=
 =?utf-8?B?RDh2Q2NjbUJsMXlwb3l3RENTRkRSMlluaEdNcmZ2MGMyTkpLWG5ldXdkMWhV?=
 =?utf-8?B?TS91WkZwVDhSWjVKcE9Oell4TkZsM0ZieVJKbXVBUkIrNHQ4enJXaUg1cUVw?=
 =?utf-8?B?RmpMeUxYWUdqcForVUJPMk5aSHlrNi9QVkRKRnFlS3VXRVNuNHNyUkFDL2ph?=
 =?utf-8?B?MFZya3RHZEd0RU9QUkpKRkV3UEtaVmN1NWl6aC8zN0hRMGdFOWtEbU8rWkN4?=
 =?utf-8?B?b2lqSS80SWxiT1ZYYTYxeTB4OFFnZC8zTk9qemN2dDhqeTZSNHFUZisrL0NN?=
 =?utf-8?B?cFNQZmR6TlVXRDN3ZWhzcmpVKzJINDN6Q2VONkNWNFpEdThIWmxJNWNoOFZ4?=
 =?utf-8?B?d0JiRk1ITWh0MlMvVVB3NUpzK0RBWGdhQWJwSnpNUS94RGlNNjE5am0xQllF?=
 =?utf-8?B?Z09HY2F1RmtnVExlOVVwWEZVbytpYU4zUUZEcnlla2RpY0xvM045OUtkaWJx?=
 =?utf-8?B?SyttbnA2L3N5bUVKekxEeVVaMkYxelR4OEJ4Zjl2VXdXRjMzbDh1ZUVGc3Bi?=
 =?utf-8?B?enUzd2trRzVvb2ViekRTYzdReFQrTGs0RkZiVmtQU0hnbkNSTUxFM1U0YUxW?=
 =?utf-8?B?Z091bXMyZHR3bHFEdjVvNXp1Y2NjVFc4Z2wrWlNpSXB1dXUyQ0lUOFliVG5O?=
 =?utf-8?B?aXJBSXNJMzZLT0RpaHIvLzdJYzhHbHNXNlJvNWdxUDVxd3RsRXZhdUgxbko1?=
 =?utf-8?B?Tlg0a24zVDg2bEZhajhqemhpc3lzM2Q5OHZTaVI4bGUxOXVGVFBjTTNHV0l0?=
 =?utf-8?B?RXVYU3BNaDZFdmhJKzV2MzRPaFNHN0dTRzQvSXVjZ2Zxb25MREZMK25vaW9x?=
 =?utf-8?Q?bWQfLa1PCQw5kD8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a5e754-6e16-49d4-35a4-08dbcbe3347a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 11:54:50.2745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3goAtjMQSvDMMt3WCIqhbV9hzbWnJ0qUOvc2rQBZwOFYUVhyapCnIrHoyOhQWNE0T2AsKlk3wS3NKDTLsGjQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5985
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130098
X-Proofpoint-ORIG-GUID: oP5vIXEyzyjF4k7BEYZBV-riR2_eeIEw
X-Proofpoint-GUID: oP5vIXEyzyjF4k7BEYZBV-riR2_eeIEw
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13/10/2023 01:21, Andrii Nakryiko wrote:
> On Wed, Oct 11, 2023 at 2:17 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> This allows consumers to specify an opt-in set of features
>> they want to use in BTF encoding.
> 
> This is exactly what I had in mind, so thanks a lot for doing this!
> Minor nits below, but otherwise a big thumb up from me for the overall
> approach.
> 

Great!

>>
>> Supported features are
>>
>>         encode_force  Ignore invalid symbols when encoding BTF.
> 
> ignore_invalid? Even then I don't really know what this means even
> after reading the description, but that's ok :)
>

The only place it is currently used is when checking btf_name_valid()
on a variable - if encode_force is specified we skip invalidly-named
symbols and drive on. I'll try and flesh out the description a bit.


>>         var           Encode variables using BTF_KIND_VAR in BTF.
>>         float         Encode floating-point types in BTF.
>>         decl_tag      Encode declaration tags using BTF_KIND_DECL_TAG.
>>         type_tag      Encode type tags using BTF_KIND_TYPE_TAG.
>>         enum64        Encode enum64 values with BTF_KIND_ENUM64.
>>         optimized     Encode representations of optimized functions
>>                       with suffixes like ".isra.0" etc
>>         consistent    Avoid encoding inconsistent static functions.
>>                       These occur when a parameter is optimized out
>>                       in some CUs and not others, or when the same
>>                       function name has inconsistent BTF descriptions
>>                       in different CUs.
> 
> both optimized and consistent refer to functions, so shouldn't the
> feature name include func somewhere?
> 

Yeah, though consistent may eventually need to apply to variables too.
As Stephen and I have been exploring adding global variable support for
all variables, we've run across a bunch of cases where the same variable
name refers to different types too. Worse, it often happens that the
same variable name refers to a "struct foo" and a "struct foo *" which
is liable to be very confusing. So I think we will either need to skip
encoding such variables for now (the "consistent" approach used for
functions) or we may have to sort out the symbol->address mapping issue
in BTF for functions _and_ variables before we land variable support.
My preference would be the latter - since it will solve the issues with
functions too - but I think we can probably make either sequence work.

So all of that is to say we can either stick with "consistent" with
the expectation that it may be more broadly applied to variables, or
convert to "consistent_func", I've no major preference which.

Optimized definitely refers to functions so we can switch that to
"optimized_func" if you like.

>>
>> Specifying "--btf_features=all" is the equivalent to setting
>> all of the above.  If pahole does not know about a feature
>> it silently ignores it.  These properties allow us to use
>> the --btf_features option in the kernel pahole_flags.sh
>> script to specify the desired set of features.  If a new
>> feature is not present in pahole but requested, pahole
>> BTF encoding will not complain (but will not encode the
>> feature).
> 
> As I mentioned in the cover letter reply, we might add a "strict mode"
> flag, that will error out on unknown features. I don't have much
> opinion here, up to Arnaldo and others whether this is useful.
> 

I think this is a good idea. I'll add it to v2 unless anyone has major
objections.

>>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  man-pages/pahole.1 | 20 +++++++++++
>>  pahole.c           | 87 +++++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 106 insertions(+), 1 deletion(-)
>>
>> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
>> index c1b48de..7c072dc 100644
>> --- a/man-pages/pahole.1
>> +++ b/man-pages/pahole.1
>> @@ -273,6 +273,26 @@ Generate BTF for functions with optimization-related suffixes (.isra, .constprop
>>  .B \-\-btf_gen_all
>>  Allow using all the BTF features supported by pahole.
>>
>> +.TP
>> +.B \-\-btf_features=FEATURE_LIST
>> +Encode BTF using the specified feature list, or specify 'all' for all features supported.  This single parameter value can be used as an alternative to unsing multiple BTF-related options. Supported features are
>> +
>> +.nf
>> +       encode_force  Ignore invalid symbols when encoding BTF.
>> +       var           Encode variables using BTF_KIND_VAR in BTF.
>> +       float         Encode floating-point types in BTF.
>> +       decl_tag      Encode declaration tags using BTF_KIND_DECL_TAG.
>> +       type_tag      Encode type tags using BTF_KIND_TYPE_TAG.
>> +       enum64        Encode enum64 values with BTF_KIND_ENUM64.
>> +       optimized     Encode representations of optimized functions
>> +                     with suffixes like ".isra.0" etc
>> +       consistent    Avoid encoding inconsistent static functions.
>> +                     These occur when a parameter is optimized out
>> +                     in some CUs and not others, or when the same
>> +                     function name has inconsistent BTF descriptions
>> +                     in different CUs.
>> +.fi
>> +
>>  .TP
>>  .B \-l, \-\-show_first_biggest_size_base_type_member
>>  Show first biggest size base_type member.
>> diff --git a/pahole.c b/pahole.c
>> index 7a41dc3..4f00b08 100644
>> --- a/pahole.c
>> +++ b/pahole.c
>> @@ -1229,6 +1229,83 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
>>  #define ARGP_skip_emitting_atomic_typedefs 338
>>  #define ARGP_btf_gen_optimized  339
>>  #define ARGP_skip_encoding_btf_inconsistent_proto 340
>> +#define ARGP_btf_features      341
>> +
>> +/* --btf_features=feature1[,feature2,..] option allows us to specify
>> + * opt-in features (or "all"); these are translated into conf_load
>> + * values by specifying the associated bool offset and whether it
>> + * is a skip option or not; btf_features is for opting _into_ features
>> + * so for skip options we have to reverse the logic.  For example
>> + * "--skip_encoding_btf_type_tag --btf_gen_floats" translate to
>> + * "--btf_features=type_tag,float"
>> + */
>> +#define BTF_FEATURE(name, alias, skip)                         \
>> +       { #name, #alias, offsetof(struct conf_load, alias), skip }
>> +
>> +struct btf_feature {
>> +       const char      *name;
>> +       const char      *option_alias;
>> +       size_t          conf_load_offset;
>> +       bool            skip;
>> +} btf_features[] = {
>> +       BTF_FEATURE(encode_force, btf_encode_force, false),
>> +       BTF_FEATURE(var, skip_encoding_btf_vars, true),
>> +       BTF_FEATURE(float, btf_gen_floats, false),
>> +       BTF_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
>> +       BTF_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
>> +       BTF_FEATURE(enum64, skip_encoding_btf_enum64, true),
>> +       BTF_FEATURE(optimized, btf_gen_optimized, false),
>> +       /* the "skip" in skip_encoding_btf_inconsistent_proto is misleading
>> +        * here; this is a positive feature to ensure consistency of
>> +        * representation rather than a negative option which we want
>> +        * to invert.  So as a result, "skip" is false here.
>> +        */
>> +       BTF_FEATURE(consistent, skip_encoding_btf_inconsistent_proto, false),
>> +};
>> +
>> +#define BTF_MAX_FEATURES       32
>> +#define BTF_MAX_FEATURE_STR    256
>> +
>> +/* Translate --btf_features=feature1[,feature2] into conf_load values.
>> + * Explicitly ignores unrecognized features to allow future specification
>> + * of new opt-in features.
>> + */
>> +static void parse_btf_features(const char *features, struct conf_load *conf_load)
>> +{
>> +       char *feature_list[BTF_MAX_FEATURES] = {};
>> +       char f[BTF_MAX_FEATURE_STR];
>> +       bool encode_all = false;
>> +       int i, j, n = 0;
>> +
>> +       strncpy(f, features, sizeof(f));
>> +
>> +       if (strcmp(features, "all") == 0) {
>> +               encode_all = true;
>> +       } else {
>> +               char *saveptr = NULL, *s = f, *t;
>> +
>> +               while ((t = strtok_r(s, ",", &saveptr)) != NULL) {
>> +                       s = NULL;
>> +                       feature_list[n++] = t;
>> +               }
>> +       }
> 
> I see that pahole uses argp for argument parsing. argp supports
> specifying the same parameter multiple times, so it's very natural to
> support
> 
> --btf_feature=var --btf_feature=float --btf_feature enum64
> 
> without doing any of this parsing. Just find a matching feature and
> set corresponding bool value in the callback.
>

Sure, will do.

>> +
>> +       for (i = 0; i < ARRAY_SIZE(btf_features); i++) {
>> +               bool *bval = (bool *)(((void *)conf_load) + btf_features[i].conf_load_offset);
>> +               bool match = encode_all;
>> +
>> +               if (!match) {
>> +                       for (j = 0; j < n; j++) {
>> +                               if (strcmp(feature_list[j], btf_features[i].name) == 0) {
>> +                                       match = true;
>> +                                       break;
>> +                               }
>> +                       }
>> +               }
>> +               if (match)
>> +                       *bval = btf_features[i].skip ? false : true;
>> +       }
>> +}
>>
>>  static const struct argp_option pahole__options[] = {
>>         {
>> @@ -1651,6 +1728,12 @@ static const struct argp_option pahole__options[] = {
>>                 .key = ARGP_skip_encoding_btf_inconsistent_proto,
>>                 .doc = "Skip functions that have multiple inconsistent function prototypes sharing the same name, or that use unexpected registers for parameter values."
>>         },
>> +       {
>> +               .name = "btf_features",
>> +               .key = ARGP_btf_features,
>> +               .arg = "FEATURE_LIST",
>> +               .doc = "Specify supported BTF features in FEATURE_LIST or 'all' for all supported features. See the pahole manual page for the list of supported features."
>> +       },
>>         {
>>                 .name = NULL,
>>         }
>> @@ -1796,7 +1879,7 @@ static error_t pahole__options_parser(int key, char *arg,
>>         case ARGP_btf_gen_floats:
>>                 conf_load.btf_gen_floats = true;        break;
>>         case ARGP_btf_gen_all:
>> -               conf_load.btf_gen_floats = true;        break;
>> +               parse_btf_features("all", &conf_load);  break;
>>         case ARGP_with_flexible_array:
>>                 show_with_flexible_array = true;        break;
>>         case ARGP_prettify_input_filename:
>> @@ -1826,6 +1909,8 @@ static error_t pahole__options_parser(int key, char *arg,
>>                 conf_load.btf_gen_optimized = true;             break;
>>         case ARGP_skip_encoding_btf_inconsistent_proto:
>>                 conf_load.skip_encoding_btf_inconsistent_proto = true; break;
>> +       case ARGP_btf_features:
>> +               parse_btf_features(arg, &conf_load);    break;
>>         default:
>>                 return ARGP_ERR_UNKNOWN;
>>         }
>> --
>> 2.31.1
>>

