Return-Path: <bpf+bounces-20761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDC0842BBC
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 19:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E407D1C24AF1
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 18:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7874F157E94;
	Tue, 30 Jan 2024 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="asAuUNn6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vm4gRb/c"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88688157050
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 18:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639080; cv=fail; b=Qt+teoTmu71by381JnUw/uj7px06/jbOdYo734g7fZFL249VgvzAyqiYqLi5MuJ/fzac5ena/U1shwlBNyCpnyJGr9mqc5X7cy4Ak36da+de6VY6VNrvKLhHRcoyLbl8TTevx29lxglN+TNhoJsCI8KQsucprhhiERaikDVrmus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639080; c=relaxed/simple;
	bh=KEepEm9rmjHj/IWk08p5ObOL+wHa10wjJA0P9xwyAY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=psT97e2pB8KhUt5d1qfyHwwwP59BbPPacIhewoSyWVcogvpzXHNtfeOUEGa42oaruo/Tw7bYNdst8EyjWikL9q4BhfJZHxlV0hi4/x+f2tR1vh/KWl4gFwfB0SFGaGMimYi/RGfW+A1Ag5sRd3aXF8GoVOs7ZawlR/vJprc4tdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=asAuUNn6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Vm4gRb/c; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40UHUV45020796;
	Tue, 30 Jan 2024 18:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+0ZZN/VwdfwW1BwDSQFb3JVOCsv81htdttFEeNOYXt4=;
 b=asAuUNn6qLZCK7kMt0hTi9iaJTVdPeiGJh0QuBXJ0+47NNezMfUy1GUP6e+QtDguPk5d
 6GD534PYsj0/JDtypjSv60dwz4+1lZ58bhic90HnBuHUqvS5n3PuodhN7lKKiM6U3Z/p
 TD+uyA9cZaRleeJ9oloJKfMbS5vDrnNOjIjty3DRFRrpLBZ33NX3GPR9KOxlW+otSghH
 QHEmMF7e+aHW2MS1XD+1Unnm4EJ+moCZLIzVEI7m/Vme6S8p58nI5/3VYz5rzGZhqpyI
 BmPYUYd55xmnA+nTFU6Ym4SVf105nSaDxqSF1sr/MBcI/s/l8231OIGbVyRMcorp4xks YQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcuynt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 18:24:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40UHuC3b008647;
	Tue, 30 Jan 2024 18:24:34 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9e4haf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 18:24:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6+QvAF0adqTFIusBxXjD6e7yKcURy8yhjqr3yZX9OslwLA9Y9f3wHFJkOoiIzzxer1W5xroRTvJf+XSv0l2BhxYV02R+/6wCGJHZmrgU90lbjAch8XSFzATRImUALz0c57TIsqdtyaxqg6hmhSEwSMZq1kx/U+U72QTpi1+B8CBc9wMR5K+3OG2R8JKHfuLVAd3dHlIsmC+uSikXf4Pl6do+KAp/ZNW1XA4QAPdK8ffgXnIFlHOP6NJXYX0Z42xCiT/hYKpJB9EFXutsXImQOd96bgG9n01tfdUc0OEnq32sZtJKIDQhnKbgBralIRxzUpd3k0ZzdT+AQMb06jpUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0ZZN/VwdfwW1BwDSQFb3JVOCsv81htdttFEeNOYXt4=;
 b=geScUEZsahxEj6zMA2HKHhccD9LfX15sshk+Cp5twQn4DhLnjIFVxMXvS5hmMRMJuFdfB1fnqgSlscsD8N1WVSE2c0u0k51arKZngLKchfRQ/gP3uLDsgx3l9s6Xf2kkuRaELmLwsakgWWs4q5DYcSLOjT1vzM2j9Fg/WW7A5ThzPuNVDEJXCWdkL0noln3CdOWaNn8I/Aa05idNMVe6QKHiCr1/gHCBC+EQB6XUJKPGxNzadb24gL4TCWl+AwMcHKSshvofBaARERRt3RXLBS4TMyGi8qUX0V+SEuu2hR4ukEF7OdRuWw4hZT1/U09phRo8wMtqeDDfQTMTiM+jMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0ZZN/VwdfwW1BwDSQFb3JVOCsv81htdttFEeNOYXt4=;
 b=Vm4gRb/cryIhGdwoskBPN9xK8ZGywzX8QDwgOiM3Wjmr9Cvv92N+Ko4g0iew9Ql2z3wDEwjd5g7GCXSUDNM5oD4V/VqVYOvHjoiKiXuApXuBTrAAd9kuoPmyvkN7VMm/c4lLi14tdne+bb/MjUWATC8cj6lyx7+FQkF8bgbtFP0=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by SJ0PR10MB4719.namprd10.prod.outlook.com (2603:10b6:a03:2d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 18:24:32 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 18:24:32 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yhs@meta.com>,
        Eduard Zingerman
 <eddyz87@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Cupertino
 Miranda <cupertino.miranda@oracle.com>
Subject: Re: [PATCH bpf-next] bpf: use -Wno-address-of-packed-member when
 building with GCC
In-Reply-To: <CAEf4BzY73K46a=VS-5M45H0abfqt1XCTE9vRnuuGn5rq65ibmg@mail.gmail.com>
	(Andrii Nakryiko's message of "Tue, 30 Jan 2024 10:14:17 -0800")
References: <20240130143220.15258-1-jose.marchesi@oracle.com>
	<CAEf4BzY73K46a=VS-5M45H0abfqt1XCTE9vRnuuGn5rq65ibmg@mail.gmail.com>
Date: Tue, 30 Jan 2024 19:24:28 +0100
Message-ID: <87o7d2k7c3.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P123CA0027.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::15)
 To DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|SJ0PR10MB4719:EE_
X-MS-Office365-Filtering-Correlation-Id: 263f4606-b174-4171-0d6b-08dc21c0b45c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bmXsb2MsRwUhATX+P1rd0MOyr4T54aKWYW70Q7zd1mOkq1L0DIhI33of6KOaMR5SzapbfzTfQIDO4LVgeJL7KIxLrFtRrZpJzpm1bNBhPOC+1g27bNloW+mFgZpB/9r46IWw9H9mIE6aBkq85mPLX5I090X2RLdQM9N5ph5XwKmsPWpfqnj/5ZaUdIPZpCyeELTu09rZR/qsJVrx1iBdfBrTr9UvBsdXz2D0JeRmKBLbrC1vpivLkA2ZLg0ATHrlzpSVPtCUrLgWvTyfFgzbUCRiqrMONdCiQaplh2zKgptK2Qg1BbtvgO/J2ayFWwZ428JVF86MlwXAz8mFXh3enbfMxi8bBtV0Qmbhk70STDloaZUhgwxaV2uB7R8paXoja4ieutLkwLaRelC2iH76SGyynXeL6BA3yWa90SbD68v/nf4t3rtNRZN0itgCxtJo6Cbs3/uI+fIANDXww2fZbpggGAXeesYznVD8EAcHIjc+GSbxfVA3l5r3B181bH59Bahsuk+UjnyKX7+23+cB+ZpwGDCMtpOm8yYmWieV9QkzkRVVFsqwP+OCQZx4akIxB6FApLp7DBcwhrvg9U9A7vETPwQ7AGdBdILCZr3DuOXZEePTR7hnPGoc2P7kE1IJ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(230273577357003)(230173577357003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(2616005)(107886003)(6512007)(38100700002)(26005)(8676002)(8936002)(4326008)(478600001)(6666004)(54906003)(6506007)(2906002)(6916009)(5660300002)(66556008)(6486002)(66476007)(53546011)(66946007)(316002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bnlZdG9obSthVzZWVS90S1Z4K1dqL25aT28vZHpTamxMQlgxbDN6dDVjbDUy?=
 =?utf-8?B?d3hMa05oeUVxeHhjUGZ6Y1pab2dEbFdVZjNVV2FzRm12a2t0V1U1TWYrSnJF?=
 =?utf-8?B?WmYzeXFkcGl3RzJQV2g2L0lSZjh1NGU5WisvTm9FcW53L0xFRyt6QVZHQzYr?=
 =?utf-8?B?TUR5ZHh5aUV5bDRNamd6ZWl6a3U5T21uaUZnUkR3SHBIZ2w1MVR4NE5JdG9T?=
 =?utf-8?B?YmsvOEJUUmpaK2RQVTU1MUNLZkZndW9rR21RUEVsNzk0Zkdzanl3ck5WR2ZS?=
 =?utf-8?B?OVBENXpKMzNIVW9aZkxFdlhBRXZDSERudkNLSXJNYngxNngzc3FRbC92R1RB?=
 =?utf-8?B?aXFQdFMwcktFSENRc0dTd2QvaHRFTGY4d01kd2VWTEhnRTFkQmJjcTN1aUU2?=
 =?utf-8?B?dGNjUHlkT2NYczAvbmJOSS9IWDBzZXdGWW9BQkhqQnhINkJNZHlJcXE0Qk1m?=
 =?utf-8?B?bUhJVisvb3lLM1ZRYU9tcWdtWThtWjUvdkZWNnpRbVdnZ1VpMGFRemY5NnNY?=
 =?utf-8?B?d0FDL2haa2o1dEVGY0NrV3lMdWpCQWVFcFVnUGo5WVNXeWhxc3dWcUN3eE9Y?=
 =?utf-8?B?Qi9MMnk2REtXUC9aV01QREc4NDNucVRNTjBjYXh6R3hIN2NQazFjanhCZXVy?=
 =?utf-8?B?YTdDWURReUY4b1BackNPaER6dDNDSE40S3dxM1hwblh2MVVhQ3diY2c1MjMr?=
 =?utf-8?B?QThxeW5UQkhOMm1wd1p3a3EzWXlEZlNTc21PUExKL05oWXpvZHU3Nk9YS1l0?=
 =?utf-8?B?R1FCRU1hMFB5YUtCQUo0eFZLdUpUNHR2aTg1c0VkZ0tPNlNkdG03bk5TM2ZU?=
 =?utf-8?B?dTVwaXJJc1IzOTVVQ0pqUXhrWjZLZmtYcXNPd0JyL2UramZSZHI2U0RjMGJo?=
 =?utf-8?B?bTAyMUtvZnJQa2hncWhNSGpSMlM0VDRVcVNVcVA5NVRXRGRUUitrSkNMdjRS?=
 =?utf-8?B?SHNQaG9MY3hNQmRYYmd3c3VTZ3F1YmltODVINHJSRURzMThjQUF3ZmpLUFdv?=
 =?utf-8?B?VlRtSkZVY2hidHg3MEcrblVGRFltOEJUakpMZEN0ZEgvWkxNNm9JU1ZIMUd5?=
 =?utf-8?B?VFJPcUtZUnV1UlVQNUlESHdaUDZ0cS9Nc2hIclg1S0pUTGFkOUpSbnorL09v?=
 =?utf-8?B?eERMR0hBelNweGVGZTFURHE2QWFsVHJ6cWVEUWRnRjcyNURBS0tRNXU5UmUx?=
 =?utf-8?B?N2oyUHBHelRBa3I1OFFESVV0M0IxSEVCQVQvYVUrQk80YVE5TWNtZzI5cDRX?=
 =?utf-8?B?MDMxWHl4dFduRUZHVmdicE1aZkowZVY0VlRmVDFWWjV5QW0vK215ckVySE9i?=
 =?utf-8?B?a2xBam9SK1Y3SlZpWDhZUEhhUUNJZnd2TmZLc0dEUlFXVFpLVCttVi80empt?=
 =?utf-8?B?OTdPbDdDR0w1QXdPMnBJNUVKMXZhdGNMSlZFeEdBMXBuQTl0Smt6L205bHpN?=
 =?utf-8?B?TGxINFhtRU5yaERTUFcwdG81ejhyTldCRUR2UHV3bzJUbDdLT1VvU1QxZjc3?=
 =?utf-8?B?aklPazVUbEVPMHhGaSt0cGgrUEFoU1Z6N0psY2ltNHc0M0d6bFpzdFdTT1FF?=
 =?utf-8?B?YlNLaVBQYlBBemR3NEY5MTVGNExGTVRILzcwMklUVGxEaXhxMmVVTU1HaWdE?=
 =?utf-8?B?YVhuRDZqY21SWG1ra3dYbkdJZXN2MlU4RkFaK3F4OWFETTJ4ellTbGRKQzBW?=
 =?utf-8?B?eUJNTDZrR08vWEo5WTBieEpmUG9xMU1xRlhuVENBZFBZRUdkS0QzaytTeitI?=
 =?utf-8?B?VjRicDZFVUViSEp6VnlNSUV6bUVnZDVUM21lTFoyMTViZVZRSTN3UWZtQnRH?=
 =?utf-8?B?MHdoeTRPdE9IRnR1SndTZmpRWmxPL0FpNTlXdlJWbkhlZXJsZWVvL2tXdG5N?=
 =?utf-8?B?N0hXWlQyeXc3UTNLMkRSbDNtMXJtMFFSTy9WNlNoK1ZOZUZxRFREUTBoNnVI?=
 =?utf-8?B?MzRTQVoxekwveGZ2VmhCa1JpV2dLeW5xVFN0eHdkOVY0amxMcjd4cnJTMmUw?=
 =?utf-8?B?eWYwTEw3OVJ3Zitpd21WZEc2cGJLa0JxL2NBL1JFUFg1UitIZkZSdUc4TFRo?=
 =?utf-8?B?UzltM1NnZ2tjY0hLYUxtM2hDRGI0MUNzNUFMeEtjWFg0NnNLWU4xaHk3UnBF?=
 =?utf-8?B?ZUpyaG1GTVZWaXpPSDlVWlF5YUttczZCMWtIMG54N01hdSs5Z21QcG0wV0p5?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	amGARPMWboOJnB4LlzaZhPEvHo7NRIDoWvMaWCpNPEL5acaJib+OVgNGoa/tKu4/r0hmbLTtSFovLamn4CjlhSMpR5DzgYcynxD7io4ScOwvfYx87YHAZxDdXQbvrDYj2mihNc8m1rXcclR3k3ciMdsuWreZQXcx+h9NFdKgd//iUPqGOHJN2hXEZFbdLrhYdsU4JRxw6dvfyjeYzuZGx+5Wodu68jCgPLEle2rHiAygWzJJZI/5OQnfs+U1NYmsPAaIQEK/xNA8v7KdWUFGm2eASim2XHo1Ejk356Sut+t96jGG8QniGmCIkUsfe0OzGecCeJULVbLQ+sIckgMSBN+5RyDfcafHrVMEDSf6mO+Gogl60t6U/+T/cjjD1HS3/EB3BS6tzvn5Cj6TqY8dTnRk8sppWfaw1g3u9l+OTDZSEzVtEHKLQBG1vHQidMnIn0kNHJlwShw1gcbvAN9vNu+tmxs1nsvj3mT8ssgCxsBQaZl6s0j4ysHdt3tmWFQyXk8uFnUbPysfSvHpgl1w7YSGwCr/M8y997afv8dBshvOgs4Jflq9JH2KIYLvRcIiKEKZCG40Jiwv314motzN/+kqEDUnDlXi83P+BlaK9Hw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263f4606-b174-4171-0d6b-08dc21c0b45c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 18:24:32.5987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wi5aQ6ux3HmIs3q9dkOpY7P2wNEw7LRB61kzJwSXiI8ALODjCKH/1I2bnKoHtiY153u8z5leYUmiKlHfSLWiDG7JRwDpgrGunHby/8JH8cY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_09,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300136
X-Proofpoint-ORIG-GUID: oZJwzdJb89VXq5_ZphZ62sWYa1O9wJPh
X-Proofpoint-GUID: oZJwzdJb89VXq5_ZphZ62sWYa1O9wJPh


> On Tue, Jan 30, 2024 at 6:32=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>> GCC implements the -Wno-address-of-packed-member warning, which is
>> enabled by -Wall, that warns about taking the address of a packed
>> struct field when it can lead to an "unaligned" address.  Clang
>> doesn't support this warning.
>>
>> This triggers the following errors (-Werror) when building three
>> particular BPF selftests with GCC:
>>
>>   progs/test_cls_redirect.c
>>   986 |         if (ipv4_is_fragment((void *)&encap->ip)) {
>>   progs/test_cls_redirect_dynptr.c
>>   410 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
>>   progs/test_cls_redirect.c
>>   521 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
>>   progs/test_tc_tunnel.c
>>    232 |         set_ipv4_csum((void *)&h_outer.ip);
>>
>> These warnings do not signal any real problem in the tests as far as I
>> can see.
>>
>> This patch modifies selftests/bpf/Makefile to build these particular
>> selftests with -Wno-address-of-packed-member when bpf-gcc is used.
>> Note that we cannot use diagnostics pragmas (which are generally
>> preferred if I understood properly in a recent BPF office hours)
>> because Clang doesn't support these warnings.
>>
>> Tested in bpf-next master.
>> No regressions.
>>
>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>> Cc: Yonghong Song <yhs@meta.com>
>> Cc: Eduard Zingerman <eddyz87@gmail.com>
>> Cc: David Faust <david.faust@oracle.com>
>> Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
>> ---
>>  tools/testing/selftests/bpf/Makefile | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selfte=
sts/bpf/Makefile
>> index 1a3654bcb5dd..036473060bae 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -73,6 +73,12 @@ progs/btf_dump_test_case_namespacing.c-CFLAGS :=3D -W=
no-error
>>  progs/btf_dump_test_case_packing.c-CFLAGS :=3D -Wno-error
>>  progs/btf_dump_test_case_padding.c-CFLAGS :=3D -Wno-error
>>  progs/btf_dump_test_case_syntax.c-CFLAGS :=3D -Wno-error
>> +
>> +# The following selftests take the address of packed struct fields in
>> +# a way that can lead to unaligned addresses.  GCC warns about this.
>> +progs/test_cls_redirect.c-CFLAGS :=3D -Wno-address-of-packed-member
>> +progs/test_cls_redirect_dynpr.c-CFLAGS :=3D -Wno-address-of-packed-memb=
er
>> +progs/test_tc_tunnel.c-CFLAGS :=3D -Wno-address-of-packed-member
>
> Why Makefile additions like these are preferable to just using #pragma
> in corresponding .c file? I understand there is no #pragma equivalent
> of -Wno-error, but these diagnostics do have #pragma equivalent,
> right?

Not with this particular one, because Clang doesn't support
-W[no-]address-of-packed-member so it would lead to compilation error.

Hence:

>> Note that we cannot use diagnostics pragmas (which are generally
>> preferred if I understood properly in a recent BPF office hours)
>> because Clang doesn't support these warnings.

>
>>  endif
>>
>>  ifneq ($(CLANG_CPUV4),)
>> --
>> 2.30.2
>>
>>

