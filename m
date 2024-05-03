Return-Path: <bpf+bounces-28522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011698BB124
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 18:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6C63B24191
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 16:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7CA156C5C;
	Fri,  3 May 2024 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lQoMKKFQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oKUlSqCB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8D3155747
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754561; cv=fail; b=eS17vtv9Qf62/aU818piYFUvcrAzCvCwfG+hDtNXjdM5Xgm+kaXeOEnDZ0LkfurvMKrUUq6OgaD6XCpmxwQfrI+KWIRroIaCjjEFJdooJYl81P8xUJezX2V3uekLNHhEllIP0rVyDg28a2uom1LkzI1Wb4kqJPFOdkwQQh0oIIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754561; c=relaxed/simple;
	bh=dVSDgI3KWuhz3CAnN7kNjuB4x4DBs3zexHI6wAS7xt8=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=UmWro/BxQNwb1x84Nj1bUF48DmXRx/o3OwWGtjH0f1751DqHuttwcAAaVzg3QoDsY6xC61vUWiNtN/o5PhoMUO/xLzKCtNn1wgez9DT7wJzmOKmFR3be3mLCUhAXwotFrgMtwSJAwUBPad00S6Na4fNQzIpm0rI/TL1NqUUuts8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lQoMKKFQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oKUlSqCB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 443FXFZL028777;
	Fri, 3 May 2024 16:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=dVSDgI3KWuhz3CAnN7kNjuB4x4DBs3zexHI6wAS7xt8=;
 b=lQoMKKFQoBsTb2JsqQ5NV6WYiu10nATOtF2rZKdcKxwH7uDMh1rp9wcW3nQtAyCBWium
 hHfqnjPTzug5uYHlzn59AkuOp8OQVANM+BsyFVk6Ej+/JrG8Ln3IBf0AX0Z5hLIOHwcj
 v8Wczi7btaVT8owLQwANheWhLoPlHNbaqKwd7SMWCOFWwsEPym5ulJFzsLruXEOEuv1Z
 hy5UD/P4RhvnoMisqISEzE9TWHOIC2r5fLImxykzjAq/Y4yOGVANUdA0w7sCzNNDdom2
 m6Gab03u+cLM5uPMf3Q2TrJsATQkTN+r3fL/nubVlun9OkEp5FWPyA7fyOdU5uPLul4i NA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrryvheff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 16:42:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 443GUCFo006159;
	Fri, 3 May 2024 16:42:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtcj1b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 16:42:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxwV0L6mUpeG7phD2BWftSbJkLhz0EJskW05WANbUyddb4qJQ9yoXi8QyRyXibxJYsDGw1bzv1vzSVgRp1vIlG+YgM6g8XECW1mLmV1IUBWoc8+oj3qf0iHeu/ulJZoSS9iGfTN9erQZX+FOLzc+sAZ/VD0m1gMdwX539M3IQ+eNWYjQ27FZ3bL5tQ1LKqybQsK98jKf0mTRHWQXvaCe16xb2D1Hqm6XpSV9KZsjmDHEsACXy6IKmcDEhsxN12ASVlExriMw0sN5c2LDw1wntzsjcMuCCdzMHp8k1divv7FJSpOeTe3bylS6f6iiFAsGIikmq80v7uXQUOGdQICvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVSDgI3KWuhz3CAnN7kNjuB4x4DBs3zexHI6wAS7xt8=;
 b=X0wtYyrpq2C2ZNeudbYmn/DJHIfJI26GSgWgU7m6xcK2roWWGlHDRQRGPxZl9NsdmN6mcauq9g8GzoO3PVVnQ62trm8aHpYveEMC2uGIKJVY5uE78pBYRC744fQ80dFa3xtfNPLtIN44UwRJiOd0CDxnc7YoWFUyfX5n2oxj4Y808Pra4vefl1Pf/2BpEK79EZl9A9MsttNpZ8aGOf99+h9EVJUK+7QcQqUSpQM2eAgxp+h8i9kd8sf+eJqcX4PCb1G32gmBKE+i6fUwi3D6yboewr0OXOn3CrXmp86r1eRsRYwQemxUOOWmn78D3sQUkktFqG4sZ+7w8avlF/vsag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVSDgI3KWuhz3CAnN7kNjuB4x4DBs3zexHI6wAS7xt8=;
 b=oKUlSqCB8NQXV8O+J17VJof04V/9nI+mOHB1uVnZW8ndyKZ1E4AjaNJB+jUwFBixCggYhj3doNlE/Dd5lm3Gxd6OJ/COFdWegdvny0Gs4mSM81utoFngysBtBIS11eHC0SEWbVU696l3LOVgOhB4WuC4W8sQM++bswul5Li9YYs=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by SN7PR10MB6642.namprd10.prod.outlook.com (2603:10b6:806:2ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 16:42:30 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 16:42:30 +0000
References: <20240429212250.78420-1-cupertino.miranda@oracle.com>
 <87ikzvt22v.fsf@oracle.com>
 <CAADnVQJa9h7fgyHN3sbgpPrV7Kk8O+N2NVL4pF4qbE5xf59M9g@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        "Jose E. Marchesi"
 <jose.marchesi@oracle.com>
Subject: Re: [PATCH bpf-next v4 0/7] bpf/verifier: range computation
 improvements
In-reply-to: <CAADnVQJa9h7fgyHN3sbgpPrV7Kk8O+N2NVL4pF4qbE5xf59M9g@mail.gmail.com>
Date: Fri, 03 May 2024 17:42:25 +0100
Message-ID: <87cyq2u9se.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0223.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::9) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|SN7PR10MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f3612d-2122-4e50-547f-08dc6b9005fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MWVDSzdjcVRvT2tVbXZxcXJPeGNid1NQV3ZjMG8zWnlSSlppMUlLek1abG9X?=
 =?utf-8?B?S3BmaXVQUlZZRjIrZlJqZHh1ZHBVWjBaWkhjUnM4WjFacnJWMnV0UWtEbmpW?=
 =?utf-8?B?ekVDYlRmbVAyaS9hcTB1WG5VVGV0cjkramliQUgrTXYyTTFUVXZjS3IzaDVW?=
 =?utf-8?B?RHA1ZXNDaWp0Q0FaT2g0ZEdPYmJSdGwvWjVMeWpJUGEzZXBHWklGZUFmeGM0?=
 =?utf-8?B?R3JHSEtnOUtEOFBjcURzM0tBWUhWUVZQRDZEWXVLZHdpaHduZUpNV3o0OHdO?=
 =?utf-8?B?cXFwRlkvMlhoMS85dUhhVk9SN2c5clhtcndla3p4S2JLT2pwMWhLMEhCeWsy?=
 =?utf-8?B?RkFXL2VBcHZlL0RkUUhGRitkK1hZOGFvVy96RDd1RXVTVFZIQUpxUkNBNW1o?=
 =?utf-8?B?cy80SUJWV1ZYRGtuNjhiYnlYdCtIZ2NzR0FnbkdUSlI1UTBkemZHa3J6bkpV?=
 =?utf-8?B?MXRtTDZYaG9KdFM3dEpqaEZyYmpURlRVQnBEUjltYW5SUDd0c3RKN3VOZkRV?=
 =?utf-8?B?VkJoWXM2UlRuWC9RZGRhT2lXRSttSWxyL0lBKzFZQmNsNWVwZy9mUFhKWjlD?=
 =?utf-8?B?VUx1bmk0QjVnYU1LVmV1emJvd3pXdCtPWStTeDJDV3VyNHYxZVlpRnRiRno5?=
 =?utf-8?B?MjEvM1k2V21UL1RTekh6UWQ1QnZ4NlA1SDcyZ1NMUHBXdGpVd0U1NHp5Smtj?=
 =?utf-8?B?M252bWxSc0toV25hRnkvdWZRMUgvWGN4UWVkOXl6SlVub3dhblVTa0lQdjVW?=
 =?utf-8?B?MXIyMFhPaG9TcFBXMllvNkJhNFZtWWY0ck9Ub054b3p2Mm5DSHN4Q1JTaWZV?=
 =?utf-8?B?ZWV2ZnlLczVia3ZnR1lGVExjeWlzcGZhd2FkbUZCMTNzMUVDMUtlRzlnb3hO?=
 =?utf-8?B?empVSE9UZ29CRFJxenRuRGl0WDU1Q1dFMVdTSjllNVc0b01mRkpDcEtMWThK?=
 =?utf-8?B?WHRIWTlKMlV0NWY1RE81YnNxbjNJL2ZrK1lCL2huUW9jdU9wMkYzUVBXT1FY?=
 =?utf-8?B?NStkeHV6dUVSL1l4QjFZNkQwa3ZrbGxHNlJkVUE0M0ZWZDBzdjFaOHBvR3NL?=
 =?utf-8?B?aExldERTWEdUSnZsNFVFckx2WlJiOUkvWVNzMmd3ZENhdkVlSC9HZzFYbjBQ?=
 =?utf-8?B?eTRBYXYvQWF5OFVaL2JmKzArMlgxMWVCb2Ywc1czdXhwZGlzUDBOdzhxN08w?=
 =?utf-8?B?MERPTFNyWFJ3TDV1N0xPa0I1ZmxSc255M21MaXJZTmFxcFNtbFdzajhIZS8x?=
 =?utf-8?B?NURadU1EVHU1Qm1TL2J6MktVb3pBcFRpYkU2cE1ybm9WWlVWZThRR0xTSDJD?=
 =?utf-8?B?MCtobTFybUR6QkRwMzRxbGd2aVNpaURMSlE2ZUpIYzlqTndzcUtqRDByUEFu?=
 =?utf-8?B?b2J3L29SVWpyU293ZEpUa2tYMEEvTnhoMXYyZmZGTzVXSVlobHNsbmFnaTdP?=
 =?utf-8?B?eDRZU0pWeGI2OG5SSmNBdklCNVlPUXNBTDFHdzh1RU5BVEFkeldSbVRtaUNL?=
 =?utf-8?B?WmFDcmVoZEZEblczeGJoSWpGUXVLSnVuWkdFb3BzQUJSZ3NsWUZFWEZLQzhz?=
 =?utf-8?B?L1A5U1lSLzJuaC9iK3BRK1JFb2NNZ0ZmMmtQS0ZTU09zUUxwSlJNcFhrcUgx?=
 =?utf-8?B?M1BFY1dJancyT24vOVRMZEJzeG1KUjNHeHM2bzl1UzJWNnoydWhybzNubkJD?=
 =?utf-8?B?THFEY3BSYmRoNU4vSkF4M3R1RnVoQjdvdWxDRDFnMHhDTUNjRkJyYXBRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NWhBWlhUK0R1ZmZDeDNMSkdBVVdJU1hoSTNhanN1OC9aU3lZNzI1bVZMOVk2?=
 =?utf-8?B?d1Njcjl6bVFwWDZYTWk5dTlEZ3hwZ1c5cFdzN0RuR3NTYmVlaDN0cWRzUy9E?=
 =?utf-8?B?Sld1bHBrRjhXbHFUdXVaV0dmaVR0ZW12VnNacWpoYjJkY1gwL0RaK0h6bVo0?=
 =?utf-8?B?UjA5Y0FwRGhVWDc4SzJlbjduSUhQdGdnSjdLaVRyVjZiL1o2TGtOdmpmZFUw?=
 =?utf-8?B?c2lSRHJ2ZHFSL0JLWUlUQzB0b28zNi9yVlZKMHhWUXJyRmdtS3dJdnZkMVNB?=
 =?utf-8?B?WXhzZ2ZuM1hwbERDWWxuUGpBWGlTK3RaNEpBWDQvQklINjcySWRYM25WMUtQ?=
 =?utf-8?B?dnNBdUR0b0JUemoxYU5SSHJKQzZFZUJYcnMxOHhuVWtXMElTd2tYM25Jb1Ri?=
 =?utf-8?B?YlE0TmcwNkNYMW5mVlpjYWFXRGJOL01oeEpaMStldVpDUjc0TnZMSDhNRVlo?=
 =?utf-8?B?cXdqUmkzUFV4Q1FUS0ROK29STUtIWEQ1Wnl5SkhSaVhWakxCWHFHRDBjWUJT?=
 =?utf-8?B?N3JWa3N0cDAxODdGMTlJMTc0NEViMVIvNGRlY3dtY25iZTFaNWVtT3lLQUlE?=
 =?utf-8?B?WkMrS0o5MDl2a09nQVBuRDU4aVZXNDl1SjZhUDZ6Z05ZOUkwdjVzSDdyQ2hr?=
 =?utf-8?B?K1hjVlpaMGJiU3NIYnM1ZjVZaEpQendHbDZncTJxaFFCNnJpY1V2Z01sbTBs?=
 =?utf-8?B?Y2o1eTRPamUyWG02RnZ3cTVhZXFLUGlXVXZvVC83MWVHSDFkemI3emtjYUF2?=
 =?utf-8?B?S1pmQWxrQ0tCWUFnOWhTVEM1cFMwMS9HNksvVlFleFdTVWFIOHVKYUpWNWJj?=
 =?utf-8?B?RVU2dXNIcXB6Z0tTZ2pDZk5BdGhwM3R0WENDby9maUs3ak93bWR4SkpxMSsx?=
 =?utf-8?B?WnRBdzJkVlgvUFIvWlRtVkwvSnBOTHN6V1p3WkQxYjFVNFZFRUpTaFJ1RzVF?=
 =?utf-8?B?T3VVaSt2YXVSR295UmVGaWZjQTI2NWNkcEdnZGRCYVQ1dmE2THgrSFowZjZS?=
 =?utf-8?B?WDNUdkRzV3FHNitBNTBpUGE4VVpGcDRNWUtHdXpIbXhoamM4OU52MkpXOTM5?=
 =?utf-8?B?RTE5NXRObnNKaW45cUdxaC9uZWpDSkQ2RjIrRVZmRUx5eWdsdFdJODRJUldm?=
 =?utf-8?B?c2hvWVRMRVFHa0I1QnlRWFFrLy9VcDhNY2VJYTcyNXQxQ3M1WmZWc0NYQmpL?=
 =?utf-8?B?ZzZGUnRTRU14alVudlRtWkxOSDVOVnZaZSs3cXdZUXE3M1ZOOC92WW1QRkw3?=
 =?utf-8?B?VGY2OFV4Si9iZWVSZ2FHZS82aWE5ckhKbjFnTW9IMzVjVkZUajg1QlF2RUlS?=
 =?utf-8?B?K01naVVGbWJGRzZCZXBsS01MQkRXaExzQnByZFcvcDNtWlpPbmkwZmNudTRY?=
 =?utf-8?B?SHFLVzJxUENCSisrY2Fab09KcllGd25rMHkwYVZIc3pSZTFvTDEvK0hocXlh?=
 =?utf-8?B?emIzN2hsc3pWemdHZURPTFBTWUNhUFA4SnE2UEYraHRvb0NtbWkvbEtkbU9z?=
 =?utf-8?B?RnFxYzZoNWVXdGwraGlIZTIvbGNHTmNNSFdiVW5JZGxFSzRQYjZ3bTNpSExN?=
 =?utf-8?B?M3JVOFpEY0dIQTdKLzVtM1RvZHg0UUhpN3hNT1Jjd3FXUmFFSWt2VkVZWkVO?=
 =?utf-8?B?dzZjUllFbHhnNklGWTBMZTFRU2lxNVVvNE9WYkxGTlVyZUF3VkF0cCt2SnZk?=
 =?utf-8?B?T0VhbFhCbEVyaTRKYjZVSFdkWFhhNnM4dURvMXVlUDRhUGJHaERNcXd4c0FL?=
 =?utf-8?B?RE8yODRTODVqNlVEMm5pS3JtazZKQVBoWGl0SWJWWm9qNVk2ei9oa2xXSmJk?=
 =?utf-8?B?TVRUK0J1bzJQaytLUnBLYzlwdlpMNndUbTBINW1hUlc3VzJ3UDlNVUEwMFNF?=
 =?utf-8?B?MFd4Mm9HVVJ3SEZ5T3owcnNVYXY4U3RSbVhaUXhKUmVmMk9wK2UzcDc3bTBJ?=
 =?utf-8?B?L2QrMm1VZzNPUnF5L1J3b01jL1BqU0trNC9QblBKTXI5ZTY0OGhKaWJHSWVV?=
 =?utf-8?B?RVRlbEtZOVQzT2l2a3NmY1FlWWtLYVRoOXJTNENkWjc3K1NlS2Zrcmx1MC9Q?=
 =?utf-8?B?T2Y0SWJFVjF4a2g5QmNiTGQxWURCb010NGQwdEpTM0NsVXpWVUhCZUNwMXlB?=
 =?utf-8?B?QStxQzY2TVpTbERuKzM4S1JMc1RxVTliM0t3NzU0bU9LcU9nMnd2N3lJeTRn?=
 =?utf-8?Q?RSj/jeu6mSxtUDKXbUNQCG8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QC7kj/HPoKGE2fQDMYiV/GKkgMZk9v5AYld2SwdGX0vPZvzZ3sUBdaW/qleqSEX/KlL33ROOn4eG+HBLgyrt5MqUSJq+TN09fccjjz3+hOV5gMbkZmhOD4FJsZDhecy4Rt236bOaAcNoqqOswV/pTRT9VccB6A44MApQvBgmw21E2dJ8Dt4fQHHnsSb7qH79HDdFmTK827sVw0h7PTTB4VwvDRL8rCzTG9d1AKbkoU5/WD0rbxpo/ekA7aRWpb+FLDYgdyfBjjBWGvEWiDhiXQLB9JjJJOLflldbg40ekKN6eRPpHro9lCXVczo8loKEkdTp7xtAqhE+OwElilsW6V5NfxZaBckkAFsTzpoBwqG74wxI1FZgYVIy6AOquxGzDDMMe30uAwzO6V7qGOmSrttOX2tY1PXQQ+JxHlAXDW0FAi0AQpkxlS8a39DW+byBA5ZdpxarSGU7kWRWgjxHr0SjfEM1OoR5BbNjRm6vxNAaKF4XrwzP2s4Rpl7u1NMLGAHFdEWvnGV9e2i9EGByhpNUjB2ovIK0lNFxcGC3Ych1lT5QcZeAf6iedIhKGG4y2H265H2len/aNPejpi/633Rjt9AU5yZNrHlLpHsvIIg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f3612d-2122-4e50-547f-08dc6b9005fd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 16:42:30.0739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EBTwETJXGzCfuAtwp6RcZAUly6+QUyDdMn5A6clVm+dpJDa/CKWN3pMQjyu1ZJdKcdq2Btph1uk6CkbpMovHioZIwd/f1P8sY878lAM8SM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_11,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405030116
X-Proofpoint-GUID: ayINTXOB7_mthYfbSudHSfgqObf_nu4j
X-Proofpoint-ORIG-GUID: ayINTXOB7_mthYfbSudHSfgqObf_nu4j


Is it Ok to reduce all this to 2 patches.
One with the verifier changes and another with selftests.

Alexei Starovoitov writes:

> On Fri, May 3, 2024 at 7:14=E2=80=AFAM Cupertino Miranda
> <cupertino.miranda@oracle.com> wrote:
>>
>>
>> Hi everyone,
>>
>> I wonder if there is anything else to do for this patch series.
>> Alexei: Without that later removed change in patch 2, the intermediate
>> state of the patches does not properly work. Eduard refered to that and
>> agreed in the review for patch 7.
>
> Sorry, but I insist that the patches are done in the way that
> they don't introduce churn.

