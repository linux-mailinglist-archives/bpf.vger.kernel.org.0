Return-Path: <bpf+bounces-65267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96275B1EB68
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 17:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94FB1C21601
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 15:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C1E274FE8;
	Fri,  8 Aug 2025 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rn9CZq4Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dkjuZyoz"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E556482F2;
	Fri,  8 Aug 2025 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666172; cv=fail; b=i4aJqqGvV0rWuX0shfTALyPo6eTxj9srmsVZwtxJZhgBR7V6kipozheQOPf7nV88lbGSF7f+2aMkB8mhZI7DAk+V67t3cnxEnYdeeq5kk6Nn64EHrWU9R5sfcRLUqbL/D+QNzKrUiIsL6W9xQNwZBLVVN9+BJpiypui4jvbvNrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666172; c=relaxed/simple;
	bh=vvGqQvdPFTId6WoKYOd6hV26O4ovTAOsKW8nfpq3kno=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 Content-Type:MIME-Version; b=jgOD8451tQHx9ZF8EFiKLrE0YgBL+RySirWxEzeuAf5CMZ6UYa2yTWMGdYJ70MMBjOsf5Na0Xyx+Hg8nZDT6/GSdmLw8VBN+fe94ouhfKbm7FXdc0H5r+WKS2+TwJxLrd1DUoH5eQsGQdKHWk9lmvTXNI/ceKvgnEiE1UwBLt6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rn9CZq4Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dkjuZyoz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578DNP4r000755;
	Fri, 8 Aug 2025 15:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vvGqQvdPFTId6WoKYOd6hV26O4ovTAOsKW8nfpq3kno=; b=
	rn9CZq4YNLX8I5SKrlht4zd4E8xjJe4U+dVnvwaXzPpORJeGCqKKED3WCV1Fp2cx
	GtSDlId2H8quf3zkY8MSLkU5Vke6Vlj7+Ud/EqlrEKgfcrnfgP9f8tK+oYx++B2g
	uS3k/8U1Fx8XbEHCh9IbJHI+d06j+/PQJIu02x9WToGfev8H81rYOvMfoq2ypHFc
	ytwuujdFlWtf4wEP1bSGPOlfb55LuAVUicR3eql0LH7B7uokxWTE8OZ7SjlQMdmW
	mH9zjhudO1MjJww588DLmWj7mWoKHX9TGv7NSa92vPrU7T9hbo4I9g1A9bQBSiKt
	hyyYlpwuKGezKVOwuNnh2Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpxy6pst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 15:16:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 578DtA8Q032038;
	Fri, 8 Aug 2025 15:15:47 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013056.outbound.protection.outlook.com [40.93.201.56])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwtdsw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 15:15:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQQDJ5fZCpcrc05Et0z8CK7F/oJ65dTGx5fQNCQ0HiPPDBOpRK+/djm3z1z0QjjYgQBH8T28N0OkTsun5HEGhIVgsyW4Dw26IjhAYramHGySjgst4m9Hlnhz/KkbWNs+NYpU7fhXyVggZCap/j3CxV1qzzxLu9JD7iLjHuy9F+MzV6ja2n5SRrRqLcz5X1/HBP9OJ7Fpbrb9oFAfEhm7PC/SQCWWF4gFf6Q1a+2UNu7qkJQuCl8MTMHyEG/rTwIwxO+F+bSw4POqA74CwYcjbkDKFJ/p8QIbeVZM00lQRL/M3uZqAa1rZ5u43yZNqxi8QEWlP0PErar1UTQmK9Q8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvGqQvdPFTId6WoKYOd6hV26O4ovTAOsKW8nfpq3kno=;
 b=RQUOIGSuIjEhJtxl0cZFpoSL5TzfKhJQ3bgN54iqyIl3x7ugq/L7Af3l3hiag89+bpjpidzjJG94SSCzm6DHzwM+qI+ALsayWRfgrVcrvkBKSKlX4nAuK0nwUFZVddkY8DOVLv2XStn1i3VzIrr0PsqmAPaw65rDZyKH1vOwYDPcsI+cr02IjUxq+YioCb0sQThQY5Uexth15KKBZE4mAd3/OXB6v8fZwkMyn5HCDB2OMs7UEo3Jm1D7qvl8TRP69M8A2eJPuRUDOs2ZiNEf7FQFsln6Q3Vsi5OfsRA6R4rZllNwNv0Gm/mqCcCQMx2SeG37On9sWLXafcZDKg9wXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvGqQvdPFTId6WoKYOd6hV26O4ovTAOsKW8nfpq3kno=;
 b=dkjuZyozDWhM0dEYa9fagfs+xoVon6HwH4L4wn5LmSxACuV+nI81WhewIY9cikrhQsVD7KkmvgiKQII1UHfv9mBMHdK/lycMeFmIiaFJtMT0ykBaps4/IV7DRO6centHbByRghm0+6GpolV1henBINkBgbkJuhkbnjf3G8hBXB8=
Received: from PH3PPFA3184E4F2.namprd10.prod.outlook.com
 (2603:10b6:518:1::7bb) by BLAPR10MB5154.namprd10.prod.outlook.com
 (2603:10b6:208:328::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Fri, 8 Aug
 2025 15:15:43 +0000
Received: from PH3PPFA3184E4F2.namprd10.prod.outlook.com
 ([fe80::815c:d94d:29c8:ecb3]) by PH3PPFA3184E4F2.namprd10.prod.outlook.com
 ([fe80::815c:d94d:29c8:ecb3%8]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 15:15:43 +0000
From: Nick Alcock <nick.alcock@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Arnaldo Carvalho de
 Melo <acme@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>, Jiri
 Olsa <jolsa@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate
 Carcia <kcarcia@redhat.com>, dwarves <dwarves@vger.kernel.org>,
        Arnaldo
 Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko
 <andrii.nakryiko@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Nick Alcock
 <nick.alcock@oracle.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf
 <bpf@vger.kernel.org>
Subject: Re: [RFC 0/4] BTF archive with unmodified pahole+toolchain
References: <20250807182538.136498-1-acme@kernel.org>
	<CAADnVQ+cvvHN9CunLP03yRFKz2YJirmF0j80-fZ0A-8aVVopPg@mail.gmail.com>
	<CA+JHD92DODDESCfwiiCs_ZQ5bGesK5NC+xe5EvONF5g+-Bg+9Q@mail.gmail.com>
	<CAADnVQLr=-E1isAGDH1+U9h4Dta7hgzi==9SnWpKpCWtHQxa5g@mail.gmail.com>
Emacs: resistance is futile; you will be assimilated and byte-compiled.
Date: Fri, 08 Aug 2025 16:15:40 +0100
In-Reply-To: <CAADnVQLr=-E1isAGDH1+U9h4Dta7hgzi==9SnWpKpCWtHQxa5g@mail.gmail.com>
	(Alexei Starovoitov's message of "Thu, 7 Aug 2025 19:52:51 -0700")
Message-ID: <874iuhj143.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P302CA0008.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::16) To PH3PPFA3184E4F2.namprd10.prod.outlook.com
 (2603:10b6:518:1::7bb)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFA3184E4F2:EE_|BLAPR10MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a29bae5-51b3-4b3e-b6fb-08ddd68e716b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Slk2ak1Fd2FnSWZ6SkdDMGhDYm05dktSUmxwZThpLzZCMjJhcU11cHdjY042?=
 =?utf-8?B?UmRTbW40OTBFSHcxM0VPeFRsU0haZUc1V1RzSFZ0ejhNMHN4RDdNNVR5ZVZI?=
 =?utf-8?B?YkRyQnRZRmp4bDIxaW5jU2lmUXNkRkR6RzFmTGhjMHRBNGhmTEYrYUNubE5G?=
 =?utf-8?B?ek5mSzVwTzU3OTRXKzU1N29taG9iSCt6L21HZzFSU21LcUdZUE5vZkdzZm5T?=
 =?utf-8?B?QkxVRi9WZkREQ3ByYTJLb2l4blFsQkJYUGV6bWZJUXpSRVJXVG16UEFuK0ox?=
 =?utf-8?B?dnk5eUVkSmlYbXBVbGRUZTl3Zmd0VlRadjVGU01IT1o0UVlZbE93bkhZSExn?=
 =?utf-8?B?QmlSWWhtQWFGNWo1YnZMUk0xUFF5WElvTDhzMG1tN1c2Q0lkeXFNc0hrWHc2?=
 =?utf-8?B?ODZRWUFIbU1GbWJ4U2loY1YxTmQ5aEpodFZEQmF4VHQzY05hODRlT2pabVRS?=
 =?utf-8?B?bzU3S043L1c4NVd1ZUNTUmVOOVhaUHBtenA5RVhLRml3citUTmtOK1orSnBX?=
 =?utf-8?B?ZDRiUmd1L1FuRG9ORnB4Kytqc2pnTkNneWQ2UkpZc1psMkErWDhhTVZjbHRK?=
 =?utf-8?B?MXU1Qmg2cjhac1EwNnAwV212TkdsSDhjWGxqY2NFNElEQlNCMUdXV3dyZkc1?=
 =?utf-8?B?eEtqeFAwK0Y4cXpxbnRpWUxVdXNXcFRiRmZvOThvVUVMdnZGNlpRTzhnaHZa?=
 =?utf-8?B?ZDJLd1Q1NjZJeVdQUmllMFR5YnpPaEFVTkVraW9ocjZOZ0c5L3JXSGxKS0Rq?=
 =?utf-8?B?b3dML0hrV05waGlEM3c3N0UvZWU5UjRYQXMrSzVld0JvR3ltampUMnR2UjJh?=
 =?utf-8?B?ZHdWbzBDVnFHRVNIbHFnMkkybW1UUVQ1MDh5TitaMWxOS3p0bmRpSHM0Z2FH?=
 =?utf-8?B?QTlVbksrK2RnWWIvdzRwdGJqc0NMZHRSUjdBRHFnY3JRNzZ2YnlRN1plWkdt?=
 =?utf-8?B?UytPSWpyOXZ4SkFzcjlKMHZPMVFucGs0WExZaDQxVHpGYjl0SjVUeEFldGE0?=
 =?utf-8?B?S3lUa3VMWWw5dk13RGdONVJ1Vnl6a0tiRnpES1BSTUd0RE1GY1lZNlJyTTA2?=
 =?utf-8?B?RHR2R092cDB4OGRycEpXMWZOM0xOVStOVk5FR2lsQUg0T3RIdGlxRWdNdGFW?=
 =?utf-8?B?RmMrc0MyOHhaVUNCUSszbFFjTE5Nc2dWTURiUS9UOEhKZzBDUU5YZlhWa1Zj?=
 =?utf-8?B?ZFI3cldjZlA4OGlaYWpHYXAvV1dVd3cxK21nUUdrTE9CNFBiMEcwTTc1T3ZJ?=
 =?utf-8?B?UGhhK1ZackJWNDA5N05yVWJqZmx1Rmxrb0kzNUhsejVpVHBkSkxObjBydHRs?=
 =?utf-8?B?TlVTcVhjMFgxV0UxK3laZVpwbk4vR0Uxamt1bUhRVW5lbkFDMHJ1Y2thZlB1?=
 =?utf-8?B?dkswSFk1U0NsWlBvMlI5cWs0QXlWdU5CcnJlVHpNZ2VlT3ptWkkwdGFWSXQ4?=
 =?utf-8?B?R05Pc0h3K3BPdXVzTlhROW5KdHJjT0MwNlVVYnRGcXpFYkQ2d2lMRVZiQ3Zq?=
 =?utf-8?B?aTF4WkhDcTFJWUd3amwyTy9zVG9LWFFVRUpnN1RhWnRQWmlVNnVyemhJZHBw?=
 =?utf-8?B?TFRGalNwQ3pmTlNHeVJSODJneklINlBEWit4TTZ1UDNJNzUrODJYYi9nNW5a?=
 =?utf-8?B?OGlvZExBb3lLZVljcit5RktMQ0toV1NtTEFvY3JRRXZSVVhldUJBVTd3NlZP?=
 =?utf-8?B?OEIrMzVxMmN4QmFGZzVZdkFUSjhVQTJRdXRjMDd6VHlqUTh3T056djdiODNw?=
 =?utf-8?B?MU5lOVdUN1pRcCsrTWQzd0lxNGtSeGdpd0hCTW1JQ3o0WEdtbHdIdENLUVFV?=
 =?utf-8?Q?R81iNp5Ioe4u94quHy+VmHJILMbD+C3VBd8lU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPFA3184E4F2.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2dYSk9haXY1SldtYWdVVytWSktKWlE2NVdFbFFGRzV1dVZLdEhYczJXOUV6?=
 =?utf-8?B?SGMxNGU1clVEUGZvSVBiMWx2eTVyV1lMMkZtR1N0UmVxNTE4MTQ4Z2FZS2kw?=
 =?utf-8?B?ckJvU1ZDQ2dKa0c0S3pidzY0NHM4Y09BSmpwVkQ0VGJsQ2dnaVViL2ZRd0x3?=
 =?utf-8?B?NnkrRTFYdENFV0tnT2hYblNhSitINm1xSXlBSXhhTjgxZDBJQ0ptT0swb0NB?=
 =?utf-8?B?WlRaYkM3Rzd0NDMxTnppZXlETERONmZvUDE4amVTd1R4UG1JeVZyN0JRWW1j?=
 =?utf-8?B?ZC9UVmFrMHQxbUt4NmszbVFCN3BUSEt2NXVoamlFL2FzTlFzeWNUelVkRXVP?=
 =?utf-8?B?Lzl0Zkgwc01KRjVBOSsySUgwVzZEb3JHeGk0N2RWMEpCN1NJZzVUKzJNNmtw?=
 =?utf-8?B?bWFUZ3JvZkx3SHBPYnhNd0d1OGc1SGR4NmUwOUQvTk9qdEZvQ2FESmYyTXlK?=
 =?utf-8?B?M2ExWCt4dnpLK3RCNVpUK0JVWEFxL0lEbWY4eFIzb2FUbGhObHJJWGFmS3Zl?=
 =?utf-8?B?VFdwUitrY0pkMEROZUlFWWVSNEYxS1FDOER3YlVFK1JFZTBvU1k4NjZkakVl?=
 =?utf-8?B?K3RXL1ozQ2J6MEdnSGd5anZiUjRHRFVoTUZQblkzOVI0ZjNoQ1AyRllhYVQ5?=
 =?utf-8?B?RTQxZFdWMUJuTW5OWFBsMkkwT000ZTBLOS9UU05Ha01ZY21xQXIxMVAyNGVT?=
 =?utf-8?B?U0RoY2phdjU4Vzh1SkQvSG9MRkwzanJ1c0Q5dWlic1JIejRKUWlIVUtTdCtp?=
 =?utf-8?B?NUJtYjQwZktBNVNBQTFlQmFnTi9FRkpTYVhwMUpnZDA5Q2NJTVpwWFh0WC9w?=
 =?utf-8?B?VkJxNjFRZGxNbjJ4MDkrMkpRanZva2NBUm1aWEVhbHV3YXhEVHBNK2J1c3hw?=
 =?utf-8?B?TEVVQklJMzVrRlFHNXgzMGdrd01IckFDMjJkaFVJTXZ1bk5HOG9BUW9mSGIr?=
 =?utf-8?B?YlBvYlZacjZJc2E1NFlYYWFnSG5SOW5EbE80VU5oVzdCS3MwRkdieVp2aDNY?=
 =?utf-8?B?K3pOYm1SOGR1YllmVmtpdHhic0xmeC8vYm5tSitsR2ZDVmRNRnRDNW5qeEtM?=
 =?utf-8?B?Q20ySElJQ2dPVGRCTFk1b2oyNnAzMTJSK1BOT2tBdXNqdUIva1lkSlB4VmZW?=
 =?utf-8?B?UWordzlaanpuekVhNFFJL2hwTHVReUVJT084M0Njd1d2aDZCQTdGY2ltSHFD?=
 =?utf-8?B?MTVoMFkxZTFPR2xPUW1NYWpCcVZneFZyZVRDM1lkY2xiUjB5S29HdnVEYkxt?=
 =?utf-8?B?anB2V3FKbWprZTcxYVllYWo3V2VLUHh1UjBYaE5zeXo5Z0M0V3phTm1tVGg5?=
 =?utf-8?B?aXNDbWFWbnlJeXpMOVpWZkpKMnlyY2Jzei9rd0wwQkdBWWRUazFOUXFpdzkz?=
 =?utf-8?B?QVAyckxPbjlxLzN0OEd3bnlySFkyMzZ2RjlvUzlHeG5ZUlJIZjhscGdDTHRt?=
 =?utf-8?B?TTJWcGpCYW5JZEVnSEJLMGZNejJhS1lKVnYrSlVhTDl4cDArQzRYUjZ3L3Uw?=
 =?utf-8?B?a3ExMXVqL3dDZG9ZSHJPTVZZMlh6bUtuM1BLcTBiSlZwS0FNbGZWNHJpVEQ1?=
 =?utf-8?B?TUM2MzNSeVVNYXVyU1o2Y01lcUhLWStZN3FUVy9XcjR5cGFaN216eU5yYUw3?=
 =?utf-8?B?L3pQTXVxWURVVmhSalBldkptS2ZzRkdhdGI1dnVxdWY4clBnU2RmcytDZkFM?=
 =?utf-8?B?VHNrSU0rK0R4OFhsNlFOSVE4elBvTE96RC9nNlJFdVVudklmekhsOC83NGVx?=
 =?utf-8?B?RVQxTGltZUFlNWZpL1ZmTllJcEkvaUx6SExxQWJqS3lXaVAvWFZVQ2xqNDVL?=
 =?utf-8?B?ZGNvbllWYnUwczZKbFp4L3JOOVZzd1huTTdDNjhTMmFUR1FjTFFnbVNJY2NP?=
 =?utf-8?B?NkRIUDZKQTQzM2ZNY09WUGRuTWpTVXNHWDhWQjhoRXlhWFpWRStNb2Z3cXJO?=
 =?utf-8?B?NkRxOVB0bjZWRmFRUWJHci91U3lJeE04TUNjWGJVUkF0bFdVNUJEQlpwOUJs?=
 =?utf-8?B?UmZhYisxNXU1aVMyWkpxN2JZTnFVVEdINjhLVURxekdlS1NlNEJpaUVmWE5x?=
 =?utf-8?B?NGh6UU1aTWxUdStvQWZ2S2IxWU54a2wvS3FzaXBXRWgrUDZTY3JJdVZlWjdj?=
 =?utf-8?B?U0RtTHVrbG03SS9wajMxeCtVMU9WQWlhM051THpwUHlJSE53Vk0yYVFrSmlh?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CY9mKP91lAGpeSuAo/GyUaXl4+9EyOUMi3Sumj3wUCtWN9lqAN1GGqNz9us3+7B1EE34ejUNW/GDnXh+Z1prcXIQb08sqDFwjJ0WNJpcYP3F4Oo42McQOHNRdVVc9mQ1Gkedq8dmR8Nc2sdJkig9yYd6DBnUZVd0Iwbmo9EG4Nm26xYZvIfEhAMGWGosndlmmluFF6p32P7mUf6pNZO76qB1hLsPaRFifQCOfH3vKYRAtwbIJj3UjBHHHksSC1Ax92bm4DVQEARMQvWCClZfmbz15VNAIzX4LDuf3mB9wwPxeY1n9ZYrgrb9b7Tjhl413ZlDpkYRoQOvkHsFWNXgf+BumaQ1vQ73kO//kIakC+6i6/1IRqHGQeBApZpuFBJsKIuIfbcpg3ZiQBMWTcSRP5NMw9XBIktc7S/TtKwxFbHhwWc0v1h4SQB2VTRXVRKZcJT90wK0aEX6/jM2Hf3dIAlBzN+4gogdG4tEXQgjWy8KZdeZ9zfj8dNHQgyzskF6XJIH50xlVA9OeMqoWXLDrO53oRozgabBjTNdCWoua2mc0GbWTamTYiD3ZLk/O8/DEK1xYvn+AHr36nRKD6ZHyFnO4sa/JQrvl9fOQ8CgPnM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a29bae5-51b3-4b3e-b6fb-08ddd68e716b
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFA3184E4F2.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 15:15:43.5866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BumoXFZ7oiCKDtWy56y4oqPSIM9EdDqke17MVrWeeF95oc3BDJ/Oah3yH6Orav/0uMKHEo/Tf/48Ig0XUWmMFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508080123
X-Proofpoint-GUID: U-7_71OBZwEQk-LC_g-R_ikkiNOxfBOk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEyNCBTYWx0ZWRfX7sV0jisgspSK
 mhNTXPT+qFoY/tXG6Pm/BYvKJqy4sw5xQTGB54HSXmbRG4lTNXly142AqcJWgaSV+fcexXb/3Bh
 72v2tufh+HCheXTl5ArELdDRYLzCLyL9RZYE6h6m9pqUP1iGK+btYB7gT95D/wclzxh2TQzeISu
 OxXQWcvhu3JDNkuo2QEWT7Q1Xy0Ep03iyKCHYVZwdfZs1nQal0QR4qmzCs//Tk7Bg5EB6tVZHNO
 eHa7uGdQJIJLzDRSEAojFAGz/9dYS0zP4RX1E30JCHT9sSEC04vH/QuIOcqzfSPstaASn+atmVk
 EpRNjiDrXt5pwvJQ+ZdqgMh535R1S5hBbpgm1qDSbhHDoWwqMbqZkIrgT/Vs0aFWrmW0DdU9L1s
 oa7Kxm7MgCsiKps7sKT4q2JWkgLjLypVgnwW+f3/MUIfQrRQQcgUGkRiZZfTyyGaeLAhglYa
X-Authority-Analysis: v=2.4 cv=Y9/4sgeN c=1 sm=1 tr=0 ts=689614b0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=12XIpHxeAAAA:8 a=pGLkceISAAAA:8
 a=2Qvse8VfbOqPpM-GgxIA:9 a=QEXdDO2ut3YA:10 a=b13MXBykIRsG0unnZKD5:22 cc=ntf
 awl=host:13600
X-Proofpoint-ORIG-GUID: U-7_71OBZwEQk-LC_g-R_ikkiNOxfBOk

On 8 Aug 2025, Alexei Starovoitov stated:

> On Thu, Aug 7, 2025 at 7:36=E2=80=AFPM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
>> But the changes in my series are so small that I think they merit consid=
eration even so.
>
> Agree with that as well, but I'm just not easy about "BTF archives" :)
> The name is too ambitious. Concatenated BTF sections is fine,
> but let's not make a big deal out of it.

Just a note about the name -- it's ultimately derived from a thing I
wrote a decade ago to make it easier to package up CTF in kernels
without people losing half of it. It was rather more complex (its
descendant can still be seen at the tip of
https://ourceware.org/git/binutils-gdb.git users/nalcock/road-to-ctfv4
but I expect to remove support for writing that format and move to
something simpler: read support will be kept).

So the name "archive" is already embedded in libctf type names, source
file names, and its public API, and there is code using the term out
there in the wild. It seems like a reasonable term to me -- I mean,
obviously it does, I coined it, but a bunch of concatenated things with
minimal further structure is called an archive when tar does it.

Fundamentally, just as pahole's deduplicator imposes meaning on the BTF
sections in vmlinux and modules, so too libctf's deduplicator imposes
meaning on a concatenated stream of archives ("the first is shared
stuff, the rest is not"), so we do need a way to talk about this entity
in some fashion, for those occasions when it is in use (internally in
the kernel build process, as the content of ELF sections in userspace).

We have to call it *something*, and if you do end up calling it
something other than an archive the existing uses that do call it an
archive aren't going to instantly go away, so now we have to deal with
*two* terms.

