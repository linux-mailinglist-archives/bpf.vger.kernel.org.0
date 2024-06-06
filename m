Return-Path: <bpf+bounces-31532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A07078FF451
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 20:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15BA41F282C8
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 18:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08C519923D;
	Thu,  6 Jun 2024 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kPZjtAvz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kI9RqJ/W"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23CC16FF26
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697293; cv=fail; b=WjwqEoOQTIDz56oGxeTQZip2W0Bdkxswub35yWSTz0rWBHyagEfjUH7nrfVB64Di3YL1GViLgQcjDvpfdIAybwjPAFlGEq7YK484usJTATsCtj7eBTu8pzwbiOr8Sa8xcJeCFphDnB34MFTBek4W51FF/9jJvcFd3TrqiGc+PSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697293; c=relaxed/simple;
	bh=670HzU823ruoBjS44szv8K1YKpB6QC5X/NWOHrXi5NI=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=o6QUVDfiSkNfT88EgILyh+nZ6uTZLqiDKPny2e5xyP15BA46tQeRpr+ys+SsjYTLtpgjpnHQfGw6FPuMCA0xpynWbMGGcLEoEqweDRWvJ+MTJbs9sPatrvl7zIeQ0EUja1SYGuCdI6ezdyD7M12SQ0ChTxReJsZexx1+tZkgNxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kPZjtAvz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kI9RqJ/W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456HxVs5011804;
	Thu, 6 Jun 2024 18:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=670HzU823ruoBjS44szv8K1YKpB6QC5X/NWOHrXi5NI=;
 b=kPZjtAvzKYYZxmhLeQwO1v2MYLOpROC5c+oCC/lHdC1QaZUiIWTBEYDnfx5mmb50yZ/g
 ef2I9+fd+7Qva2Cp+3j+KkRbHqknIMiSGdHCGPHdhg8uVSVtYlDKCJaO8haWXLlw8PD/
 C4Z5aaI9e6YBAFQEHhoB1Y7NvmZZojxLZ9bLWw3KHK5q2Ia/YaIGC/crFonK20M17OVZ
 fb9Gi4UmLKjLMvMUvx7rcKQw5+aTz0MM12UJypaqYTlHzgqocqo4DSZpF4h191BxcOPM
 Wnm6EbZ+iaqjyVZO1cjowqwFxK//ZaOhEMumZ/qF/9Upc2rQ7lyBFiEvv6CGtUXTIEYS Kg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrhc4p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 18:08:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456HUogc016196;
	Thu, 6 Jun 2024 18:08:00 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrsdf9wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 18:08:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTOxDg/Yk71Y+htZtgkE2We5aismY0CKHwGQwTLtww/NviHKBY1OxBK4OyOGpJjOspAmuOph+3PFqW9e/GfQ3X5u8ApG1rXCqHB2nMzRNQyBQ30YRtqOS8zupd7c7jfL4dE2WB6BXD6gO6sQUQsxveTwxY4+mjpN7ODNZpR0FLbvBlzy9aXK/DTk0vy3NeQujQrxvKG0WIGN/fpCCvUipaqnaBYYNE8scz5oCgpnPDOSxR73UFFolu0SomdG4y3BXsZSibcx4jNxHbb7nBf4qfbjGqco59/KABNpoA2KKUxzBiaTrbBQaYcfTlVojKXG13C94EYmYRaMeayCQi08pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=670HzU823ruoBjS44szv8K1YKpB6QC5X/NWOHrXi5NI=;
 b=AxConmCJg6OI5STVh+mf4zYNKRND5itj5NFS98/viKH0JW6mkX3HtAEBfplhAE22spuUB3nrAvhXhL0D6MYvQZlrxTaX8KlsBGhZMMehIwQAVDRTn5wpaZiPaygmU7kXIpnOEyN6Jgld/8TbipL3GNDDp+IUVar59B8sCgVsSioIcZx8LEfsLoDd59zN1/X3vbE/TEtbjuhTPBunDYJW0Cn+ryAw6FYsMpRk4M75SjJ2+iW1O84SXOyPEBoEYOvQ/Fvj2jg9bPVD6EIj0CLE1D+1yOl8+NRNp91UFHvikfeMSSWujvv82Q9Ue9puts5yvEhW7hmcGp31DeLXqxonEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=670HzU823ruoBjS44szv8K1YKpB6QC5X/NWOHrXi5NI=;
 b=kI9RqJ/WYGl80n9PRGsIwfkhaA7wYLwR3S+Q9yKD6ts80ElO62LDjeITw1XA9hf/2UFXV8BGhTy09HfornclBUGpz6bmlrHmtVL0VLYAwvjfDWnqqyA+MDg23guJLnbkK1gXOnS1fNwgLQSV6UQp01dwZ3ncLhmwptscc2Wm+wU=
Received: from BY5PR10MB4371.namprd10.prod.outlook.com (2603:10b6:a03:210::10)
 by LV3PR10MB7866.namprd10.prod.outlook.com (2603:10b6:408:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 18:07:58 +0000
Received: from BY5PR10MB4371.namprd10.prod.outlook.com
 ([fe80::d2e6:4de0:fdd1:fb2c]) by BY5PR10MB4371.namprd10.prod.outlook.com
 ([fe80::d2e6:4de0:fdd1:fb2c%7]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 18:07:58 +0000
References: <20240603155308.199254-1-cupertino.miranda@oracle.com>
 <20240603155308.199254-3-cupertino.miranda@oracle.com>
 <CAEf4BzbqhhLsRRTP=QFm6Sh4Ku+9dKN4Ezrere0+=nm_8SzwYA@mail.gmail.com>
 <87ikymz6ol.fsf@oracle.com>
 <CAADnVQJ8sykfiVbRuV8BSSNCxP2p2huOjORdP-0cgXriXeZVQA@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        David Faust
 <david.faust@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Eduard
 Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Match tests against regular
 expression.
In-reply-to: <CAADnVQJ8sykfiVbRuV8BSSNCxP2p2huOjORdP-0cgXriXeZVQA@mail.gmail.com>
Date: Thu, 06 Jun 2024 19:07:49 +0100
Message-ID: <871q5a9c7e.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0320.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::13) To BY5PR10MB4371.namprd10.prod.outlook.com
 (2603:10b6:a03:210::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4371:EE_|LV3PR10MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: 736c4265-ac4b-41de-d71a-08dc8653989c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WHNKOWtKWTFFLzBrbmJEU0tsNnp3cU9Fb1hOWFQvTEJVUGZDTWhpZkI3TUtq?=
 =?utf-8?B?QWFtYmdZc2pXaHdCMnBHcTdKdmFaZFJBemRicHdNa3VRdHJUL2dZS3hUQi90?=
 =?utf-8?B?NnZ1Z1ZGc0JKOWNUUkZCT2lHNGdwM2xkOUZyMk95WGVOZGw0Rm5veFJMYk94?=
 =?utf-8?B?Y0hSL3o4UWVoa1o3aTFPLzB0RnV1VWNYOWFBVDYzaDd3ZFZJWEg5MEJSL0JD?=
 =?utf-8?B?VnRHaHRwOE8zRndsVlF3dVR2Rmx2U1ByVUhZYlhYNmZ1WTFXNzQ0Y2wwU1Zy?=
 =?utf-8?B?ck9jT000ODA4T0gxa1ZvRHpiRW54amVGYXYvdHBkYWZaSVlOcm1Ta1A1YzJR?=
 =?utf-8?B?dkZFUHFpV1Bsd0diSmhpTEovL1h3Z2VwSnV0N3NQK2xTeEJlV1JkN2NFWUJN?=
 =?utf-8?B?MFRzWE0yWGpZNGNhRDc1dVBpQnhndXppS2ZEN2djSzN6b25qcDVLWUZra3V5?=
 =?utf-8?B?NUVEVkJ6bGxQd0crUFZpcjhlckVzemc5OVB0WWl1UFVwSmZYRVRCNlhpMEk5?=
 =?utf-8?B?UkFBc0syTWUrVHNnbXVzUDZTM1pMVUVtZ3lVclJDNGVpK0sxUGFoZnh4QVVR?=
 =?utf-8?B?T1BsQ3cxM2poRXhYYUVxN0ZyNHBMSFBMRTdUV3dLMDlRM3hMTGFmSm1zSi80?=
 =?utf-8?B?N2l6MGlSMEtPSnRhS24yd3hTTnhCbElaTlJCamkyRTB3Ykd0OVV1d2ZQb0JC?=
 =?utf-8?B?M29XdnBIRjlCM3pieU1hK0FxbnV4cFNKY2FCVUtnSHYxbTJUc1hUVFBYblRj?=
 =?utf-8?B?WTZzMXZuV2xXTkxtUHNNRkJIZHJJVjZEcTc1UUVaR2FmaC84NXJXRzNmbUJt?=
 =?utf-8?B?UWJXaENrZG5XaUhFd3lnWElXVzFEQVlUY1pLaFROUm1Semp6NVVkR1pUdmdF?=
 =?utf-8?B?dHZkKzZrY01FdEszajFVRVdDeFlOaXlwNkZGODhSaldYMFB6R3lLRHRKTnQv?=
 =?utf-8?B?dkwrRm9TY0JSQW52aTAwQUlMcFNOUXV0bU9LSElkMk9lQVR2QWRlZStyMTJL?=
 =?utf-8?B?dUNJOHRSdFVPR3k5cE1QdnU4TzM4WlErV05hSmE3NVZxdC8zbVNZaERTY3Nw?=
 =?utf-8?B?VFhZNmZmOWJMK1c1MlJrSTFOa0lwRVI3RVA5ODV2TzdCN210d1I5cVhPa1V6?=
 =?utf-8?B?d1gwcWJFSmlKLzJzOWFyRUwwU1k0MjU5UUZQU3NoVjYvZXVjb2FsOGltOS9L?=
 =?utf-8?B?b09nSFg1a0YyekxLVFFuY1JZcXlzeUwwU2IyaVJJcC80a0dRRS8vVFg4dWI4?=
 =?utf-8?B?My9oQkVjVGdjWmtsQWtuWHdMNjFsZXpQZ1dyc1dsU3pWYzlnYlJvRkY1K1dy?=
 =?utf-8?B?V2ZFUFRCeGJFckJua25XclFSRExrOU1kQUJSSExQdDVMS25NdGorVjUwNXlZ?=
 =?utf-8?B?eGpIZlN5ZVA0RUhEeHd1V3JzcE1Id0hOZXdGMml6SXBMSU9qWS9kQzBhbGJw?=
 =?utf-8?B?ck9rZHdCUU12cmlLWEZhVUdlNlZMQmlTMjZqMHBPUlVqdVVLRmlYWVAyUGVL?=
 =?utf-8?B?VGl4RCtCR0RKejVwUnFMejNkSmhEdzcxZUd2WG9EQm1WTEVEQUxxZTBwa3pv?=
 =?utf-8?B?QXhxT1lwdVVzQmdnN05nT1JkaVNFZ0QreWRTUzA4RU1NZDRLdUYvUzEveWlN?=
 =?utf-8?B?V3JRcVdhczJOb3hTNzFZQlJraEUxREdiRzdqMmpzcU9VZDRCTkxXR09DajVV?=
 =?utf-8?B?YWtWR0F0bFlnZVJBK1FybUpReEpLYUMyNVZyc3N1SWhsVjc5dzhBUVV2VGhQ?=
 =?utf-8?Q?ffg6p+pTJthiCj/0hmHaSnEMyMODbuJhPhe4Nrx?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4371.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MWQzNnZoaThvY0cvVWlWRzBaOG1vZmhpeGJPc3gzTUVZa2d1UVo4QlNDcWJ5?=
 =?utf-8?B?REMrT2NXeitRN1pWRkVUUDNMd1YrTW5wY3JQZzZHZWZHcFZRclovTUhaYnpx?=
 =?utf-8?B?U0t4L3N2TkhYTzI5OFkzWXk5MTdSenhxUkRPWW93YWpVVS9sN2hvWEU1dmRU?=
 =?utf-8?B?azc2SlJqUmVzaDRPcUFSOEpPaTB4UUVmUGY2ekRxakJMZ0ZhckJRMDVrZENw?=
 =?utf-8?B?UWZaZzgvUmVnMGVSRXdrSjRuVHVuSm9QelRiTkQ5RnBvT3BBTmpWRm9adVUv?=
 =?utf-8?B?VWp0aEJBWTJmVlNGQzA5cksvRWxrWVNzdzZwY3pvVk9YRmRwOW5RSUh2cUtT?=
 =?utf-8?B?eEZXemZFK0wyZmpGNmhtZVpYMitjaGlGVnpKTzRzOTJEK3YwZGVMREZoVmQ2?=
 =?utf-8?B?NE5HRWdzR0xablNoQktiK29VaVFkdmlpUXdyS2dlSThJUE1LVFBxdTlFRCt1?=
 =?utf-8?B?Y2ppdUpqSWJxRjZzVTIzdkRYVjdOZC9tUGRMR0NuUlBQd2pyUk1BblRoSDBK?=
 =?utf-8?B?TGxIMkFVTnR5T3VIRUczeXRLNmFSMXNBQmlKR3hqckNGdVhleFN3WEtockUz?=
 =?utf-8?B?bkRUdGpGOThSeE5GNlRvdkpTVjcveWVMYktzZ1NnQ1BMc3c3dVhDZ2dRUXha?=
 =?utf-8?B?eFlSUm41aEs4QzVaNERFd0JpcGpnUGNBRWZaaHdHZitRR2hvbEJzcWhjc1VQ?=
 =?utf-8?B?TCtHd25heG5tcTlSZWFzajBGU3B6Sm4ySXQ0TUplZXhBMVpFQXA0VEhsZ3h0?=
 =?utf-8?B?OXhwUTAzd29yV25WQW9OaWhEYjJUZmtGalVxVFJ4eWxNVURPbUh5bk9mVG1V?=
 =?utf-8?B?ZlhUaEc1S0pqV3BEb3d0akovajRadTRTcndoVG9lamI0VEtXNW9Vak41RnN4?=
 =?utf-8?B?T1R4WHBPazUzSUI2czgwbkU5VXF6dnBBc05oNGMyMXh3eVZ1YjdobWVLUGlE?=
 =?utf-8?B?U1BzS3RpWFlPY1pORXZrNFJNdlZWM1kwMlpEaEZQWUJWMnlsM1JscHhZc2xK?=
 =?utf-8?B?Qkp2OXl1dms3bEgwRThMTmdMZXhad3hlNkJBN3U5OUQxSkNWdzM4SGJ5dmcw?=
 =?utf-8?B?YkNxNU82L1FlamNCSVZvbXNDTGxEQjFWdmt1OHBNNXF2Z1NJZjJrNmR6RWJi?=
 =?utf-8?B?SnA4dVNrZzZYdHpSbWJwVklqVUVndjd6VEZaeU1oZDQ2b1BHSWZCbUJDVm5H?=
 =?utf-8?B?NDkzMkFkKzlqTnh2SEVlVmU1dXl1U3pYWjMxSEExVFFqSXdjazUrRUxrQTh2?=
 =?utf-8?B?MGxiRnVNT2IvL3dhSS95ZUoyOWl4YjN4Umpham1lWWEvVG05L2RlaDVrYWJw?=
 =?utf-8?B?SEpDWDJjL29zelFkRmtwVDl6aUhpeXFFVWJQSjVEZTYzanNZWnBUbUJwbFg3?=
 =?utf-8?B?alpqNHVXbWtTYVZEdEw0WUNMZFl0WjZTTW9yUUtSTXpHcnN5T09iekNRYnRD?=
 =?utf-8?B?eHNseDhiWS9UakRjUjcrMVkwK0lVVkJ3dFUwZVZ5dFNoZThmV092MFMvdVk0?=
 =?utf-8?B?VEo2c0llaDhrYTROc0NJU3RUOFZ5TWoreWNyU1pnRnl3a2VMTFFHYlFCUTJy?=
 =?utf-8?B?VThXczhJRGQvbmFGcHZTcWdiemV0NkIySjA0SWtzd2oxa3BXWW9pRlN3VlFD?=
 =?utf-8?B?ZUdoQWtxREgrUThuSUNreGRlaUR2K2xIQlEvcVB0Zlp0d3UvOGVIeUtZeFJC?=
 =?utf-8?B?UnhuK1Q1SXhCNFVUTjB0TEQrYmRRZ2g4TGhKQUtJZGFlcCsvSFYySTdXNHhQ?=
 =?utf-8?B?WGxOaTVlTFJtZEtyb05XS3ZlOU4xM0xZMjdUdDR2Q3BzejExN3VQRi8xVFNr?=
 =?utf-8?B?eWxrZGZyZ0xnbkZCOW05MzlsdTFNZW9MU0NhNml6MkszY0lDeE1XTmZaVzBC?=
 =?utf-8?B?dHYzU0c4OXdMbWFYWld1SHd6Z2xwRTNlK1BkUWRXcVBUZ1gra2FxM3l3aE1z?=
 =?utf-8?B?dzZOcmJRUzBrMXFUejZIdnRsS1lmYXhFYndKdVVyeDhsMzdZTnl2YUpJQjBM?=
 =?utf-8?B?V2E2Y1RKUGNQV1g4N1ZaNnkxMFhlUjhJMFJQN3dPV3VaN1kwWDBTanJHN25D?=
 =?utf-8?B?T2VzZ0RFckg5cm52OWxLdC9GazN5U2ppOFhwa2p3V2VKNURpOS94RDBpdjA2?=
 =?utf-8?B?b0RtdGdoL3p0bFk0UlZaOFRMS3p1SWpLeTBzMGhxMXNLbmh5LzJ3c0cyZSs2?=
 =?utf-8?Q?KBTTmZRqfBqZnxoUSvRehRU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	johbVFNmYK1A+KH8lTfJeFF4qNYL7fDyYUc6GpRhYJx/fM2N1GR6EO29aKV528oGP4BW+2SN6QOR/KpOGjrvyokpQMRSYfCn+PoF2KWjbmSfmbAbBsNewE52rEzf5U3le4E20vhg9YfjHfYab2PM+NMftaWszQyevlqQLfBKyHyADKr/S5vsNQ4tnk9BHdUw2Mg0yQ3W969g+/sOY1GvP1aWMSR+Jst550LHup2SVRTQ4OGaTRrMYC+cOeds0Hkq7BEQHh2C5aJg0w8wjYCmvvMKnQ856HTdi9Pex04dw3l8Wc37iZCZjfXkqzm1cEpKX8rXkiNX//OtiL/k8DNtjzqIZrYOX4mV1GSHN9ZGIS0V9UcocJQ78Ns8mAbJPSmYNadYgH4+D6tZt3I+ucyGczILX4afkDck8A23hvqC3h1vyroGxpynJboQn3JysNGJ+TDzHqKoNJNVTdCWDaV/iOZg+9jMa22T/7nAwLi9yWel3F2LPFI2D5FmcwhiK9VTsNaZiwC3YtBNjQlnZoWlJHvYbYx16Mf9w8xhcoVrPKbpWBXPldv6/ovGGSWH1SgAIxkl32RLkDw92Ww/NJiSa10Ya4nakj6rXMwzgHK/LwM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736c4265-ac4b-41de-d71a-08dc8653989c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4371.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 18:07:58.4114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyFsfLRiZDHElRStkRrE2Itrjl4I80rPmWGYFmaZ1vPGpKK+5msykWl8jqttxIicTyxg7jtaNh1/FGBvc4IhfNuULQYtBcaIVh7prqI8Rk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7866
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060125
X-Proofpoint-GUID: QYQ3KwE3lHPLbLwQoNBjIMWFZG1-P_85
X-Proofpoint-ORIG-GUID: QYQ3KwE3lHPLbLwQoNBjIMWFZG1-P_85


Alexei Starovoitov writes:

> On Thu, Jun 6, 2024 at 3:51=E2=80=AFAM Cupertino Miranda
> <cupertino.miranda@oracle.com> wrote:
>>
>> GCC will allocate variables in a different order then clang and when
>> comparing content is not where comparisson is expecting.
>>
>> Some other test, would expect that struct fields would be in some
>> particular order, while GCC decides it would benefit from reordering
>> struct fields. For passing those tests I need to disable GCC
>> optimization that would make this reordering.
>> However reordering of the struct fields is a perfectly valid
>> optimization. Maybe disabling for this tests is acceptable, but in any
>> case the test itself is prune for any future optimizations that can be
>> added to GCC or CLANG.
>
> Not really.
> Allocating vars in different order within a section is fine,
> but compilers are not allowed to reorder fields within structs.
> There is a plugin for gcc that allows opt-in via
> __attribute__((randomize_layout)).
> But never by default.

Apologies for the mess up. Indeed the reordering happens on variable
declarations. In prog/test_core_autosize.c, it declares variables and in
prog_tests/core_autosize.c it checks content with a "template" struct
that should map how the data is layout in memory.
Somehow I miss remembered the actual problem and got confused with what
was actually being reorderd.

In the end both examples are the same.

