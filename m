Return-Path: <bpf+bounces-5972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51594763B08
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 17:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D41281DE8
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BE7253C1;
	Wed, 26 Jul 2023 15:29:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307B91DA3F
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 15:29:34 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CCA1FFC
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 08:29:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q8HN9R014615;
	Wed, 26 Jul 2023 15:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zLm1fmXKPAKPcxx6XQgry84hMe8X/5HoTshp4UvIJV0=;
 b=MoPmtQW/yJlwAQ8uKQYXe/VHr4m1YnxVVi/d7n5T+RzYApGKMSf4ym9cPhwnA4KmHqKm
 KPFTPIqJuuY6ufzwHfJzaZtCFGF0ZlamtlJdT1c+tCwAkAxPDKTxIQpkHH3vHLAxmbS8
 IZjCiAm6t5kdAokHQv68Rp3aEEzyPoZb8WBo2LGGot8zey+C4iXuvwSyd8Cz9DaBRKAH
 AlZqvjGpmizPyOXjifpeK8TV+NzY222GUXS1XEkpyME8CepzMCNi7Oou8eFDObXQEd9v
 qXs0yvWrpnHKWhZUqXa8U2Fnx2PbL4qWWIJxH8z6Z87u3VWU0aMmmKLAK2WiLMgTOlMK ZQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05w3qrs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jul 2023 15:29:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36QE0MBx023017;
	Wed, 26 Jul 2023 15:29:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j6brxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jul 2023 15:29:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLMgOQQ88gNhPrL+t6RztZZIQgnaeRj2eJrDZ8nDFzgHl7drYAf10eOYMthSitlQcLdw2xyenVfxrGTmgP8XjQEBxzSFx8GY2wFvIPMztmbvHKrZDV8euWohWMWmOcU11reKWgQLxgXpYtAcCeIDZnp/FaeKg1jfqrx3bPWVQC1MverjdxNn1JjUEzy4Q62C8kT3I4V58MO3ttWrExgCL1sMJCkQswWDqamrk9SYmbSXM9efNSeIy0jEmwDVddor45eL6D7vgYyW2kxWh6P7L938zIuu2drD1RrFub+153Zvx/JioZxFHT0CvwFQ26dcgqR39Y3J427W5Yzp0DNhUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLm1fmXKPAKPcxx6XQgry84hMe8X/5HoTshp4UvIJV0=;
 b=R4HFE5V1vNFKtVlu2Q2/v+vQhgJlPWGlxZ6EMCunaTMKvff8cZIGZMJ+89OL8C/iE2PvvcTBCCtR1BD+AXyev/GkOMKnZA3Wa3KT96N8xjiGcaUz5f7ifzNlxCrLXO2I28nMrHS1EGvy1ffxMYwt1xPM51tAMqxrBUTl98H4LfWNKHnp6EgBO1P2aCCsYgl4BoMFusQpM41KjapmKAgnCR24TwKIxWHfPoGgUJlGAx5jYiks9YVEUdODRX+uN5XmMSUw6gACVwbqcOnlJsgqHNj71gi9ri1UK1TTF7rCORuoAV71WQtrv3bJV3rIWk59uSGYXv4QqWdNmTKhOyZwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLm1fmXKPAKPcxx6XQgry84hMe8X/5HoTshp4UvIJV0=;
 b=msOsSQr8LwdA195O4Z1RTP47cBMXS+CgpVZnVQTJTUC+iYHKDl7YTFuGpa3BpricPZHrX11BH0xInF9uAnd8hB3oLlyP1phjwA7KLTXKE2540V3jz+pZt/AKBYOY7/p8Ba6BwAh7Oinx8dTgAlaLKIX0vZRuH255f2lrqAFrmZk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BLAPR10MB4947.namprd10.prod.outlook.com (2603:10b6:208:326::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 15:29:01 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 15:29:00 +0000
Message-ID: <a6ade0a3-a03d-d526-afc0-db9ffcfe86ea@oracle.com>
Date: Wed, 26 Jul 2023 16:28:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC dwarves 1/2] dwarves: auto-detect maximum kind supported by
 vmlinux
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: acme@kernel.org, andrii.nakryiko@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
References: <20230720201443.224040-1-alan.maguire@oracle.com>
 <20230720201443.224040-2-alan.maguire@oracle.com> <ZMD35ydVT69zDipR@krava>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZMD35ydVT69zDipR@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0355.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::31) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BLAPR10MB4947:EE_
X-MS-Office365-Filtering-Correlation-Id: e555f609-56a5-42bf-b64a-08db8ded095b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VS1a69Gz5vwv3YaMdZrsJHEhDK54yGp+NhihnJiKumXuLzf/gKHRztuPJyrswKNwKmXD641fgKb8UFZ8ChjYUMOcYHIRreJa5nFYELPBGMhIvTeRBxv9kPhe9ZcAnolxn5dMLLZAD67hSB9NA4k3ge8z7d2VoqLpqT9IbhoxKtmovLw07/Haj9Qu4sn2Lhq2r3BI9pfo68258FCf1UIbRDxacFgxQVs4k5pa7z/kK6ibLPN/A9Dj4ynXEE6Msphgh2PJeTJW+BaH2JMDllVJGoo1p8YDOmZxwG9yBWK6vDlcanvietAJxrKsiWCW4aJFS4M0M7A4qJ9+qVgiVLFqw6caM7WYfYe7OcKl+0ugu0txoI5ShuH88uQzrZMurBRzU/6nRZ9bOayRd9qH3qwepBHNfzh6fA0eHrZro7Ugxz6aSqqRQ9jaxh6NyCc/TYR/bE/Bf74y0CgTFFBO1oDBlMnieOyb4EQSbaTmOrlOhgQOQsofpz6BmQ6mEBbaG43YTKc7Lh3xN2V7RwG0J0Z8zKbTeUkLYZOAlx8E1O9Iwd1A3ClsIe/ImZTWqRds/WPTx9LBXtRJmhdXofWTRZkh7l9PgrSDsQGMfrpaIuY9SLrIfNTCjztWse51ZiYSmaAum4AYeGTdHheNLj3+gdcijw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(8676002)(31686004)(5660300002)(83380400001)(2616005)(186003)(44832011)(53546011)(6506007)(86362001)(7416002)(8936002)(31696002)(6666004)(6916009)(4326008)(316002)(6486002)(41300700001)(66556008)(66946007)(66476007)(6512007)(966005)(478600001)(2906002)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YkM3bmhlbWVtcjRlNXp6enJQempFZ25jMjVTVnMxdU5Ya3BXd1NUcVZtMjFT?=
 =?utf-8?B?TVhvZi9wVTB4aFlnWW9vdkZ4Vzg0V2c2K2tGd3h1dHpubGcrU2Q4aUlLRHBT?=
 =?utf-8?B?S0lwck11UkFkcEVZWjRjb3VlLzdISnpmb0V6cHFYUXQwVmVGU1N1TlBUL0gy?=
 =?utf-8?B?WG9LRUZUVlE4SDRjbDJLaEVZbHVaem1QZUlZRDNmeWQ0NkxHVHZZcnBobjNv?=
 =?utf-8?B?OVgzMjhIWklBZXAzTEdZTzhhR3R0NThzRWd1eFpiKzdIN1ZTUko1eG9rNlBW?=
 =?utf-8?B?RHJpeGY1YUlVdXdIaHNjTTdQeWNlTEpibG91NkExNTJpdU9lTzZpT0hoTkx3?=
 =?utf-8?B?cThCazBKY1lWa3llQWJRSjgrc1JXSkxsZjMwYlBaWmJ1c1NVNE5hQ2VKM2x6?=
 =?utf-8?B?c3RUcVErMUlnVFczT2hPWlN4MS90ZlBWN2ZLTWFHallFbFNqM1lLUGdTOU9L?=
 =?utf-8?B?TWI1UG83Ty95UU9EMjNXNnZlQ0NFNHpiRi9PU1RCWkZyQTdrc0pEVDR1UjNw?=
 =?utf-8?B?ek5ONlpuc3doN2tWSTEydDQ3OFlKRnh4eU1YOVJFNkEwamsrVGVyTzlhOXpn?=
 =?utf-8?B?emN6NXZ3dWpyVUJTVVFhTk9VSURxRFh1WVhKdUNjcW5hd2EvZnRyTncvbWgw?=
 =?utf-8?B?YnZPZDJxZjdlTlJ4c0pmRlNyVDBCdzJMblo4SkRvVE1talNQa0pBYjNPWFB1?=
 =?utf-8?B?ajdzM1ZpYjI4ZUZuOVdXL1Nsc0FRdmJlcUVIekNLVGVDM3Y5R3duWE9VL2k4?=
 =?utf-8?B?NnZrUmZNeUptS0htSFdMM0dQQy9CcmJjWENlTWQ1emluRDlJNzRDa0R2VDVI?=
 =?utf-8?B?YWtzUHZyVEVmRVJXOGVzY1JUSDdqNTBDTVBhNkgwODM3L2ZBclAzVHhFZDEw?=
 =?utf-8?B?M3NRZ0JEY3B4TWF2WDVaUCtYNlA5YXk3cFVtWmo1YzI5cGtUVEM3YWszV1ps?=
 =?utf-8?B?dnpOUE1uZStqNE9UQmVyNlNMcGQ5dVJHK0lMeUUrNEViZUt1QUtHa3hyZjl6?=
 =?utf-8?B?M2tpa085bVI2a2JDb0xrQm5tMWJyZ1MzbjZEN3piMkU5VTQxRWpjU2E2Rm9U?=
 =?utf-8?B?SWUxZmphYWJaSE50a1FTU0VENnY3Q0diZHB6MWU4ZUdKOWtid0ZpaHNEc1Fv?=
 =?utf-8?B?K2RTMGt1RFQ5ME9uK25zMGhjRTExcWlpOHB6bkZiZGEwaDRRV2kvV3RrZXUy?=
 =?utf-8?B?V25Fd2kxTHR3bWpxblVXbHBEUkZQRzlFR2F0dW5rZUNnRUs2WFlYQnl6dTIw?=
 =?utf-8?B?VmlUTThZaFNvVGFsUUFaY1BrNDVYdTcwcWZLNjA4UU9XTEJWWmtleEx0ajBY?=
 =?utf-8?B?TXBFVHJZMDFaV2V6WDJQNWJWZWpZQk9HeUl0RG5raVlDa1gzKy92NER0TEVN?=
 =?utf-8?B?dHNRSnhjSzFFWmRlY0NyUk1XQktmU0xTYm9wUktTT3E0Z2ROV29YQ1hsSDdC?=
 =?utf-8?B?KzhtWG5jdkNvcDA1djRDTnRMVnkvakZjUTJkL0hOdGpveXBXR25IdzZJWTF6?=
 =?utf-8?B?NC9rRXlCbEtrZE10blZHZkdBcDY5K1c2eG16RFM0OXhIZTliTW9QZjJJTkdW?=
 =?utf-8?B?TFFBZElDcnd3OGRzZ21zQklYVFZaV3QrcExIM1dyNUlOdDJVQndYdGZIRU1k?=
 =?utf-8?B?Qi90MmFVRlFjSDc4ZEM1UUVWTDRMSGszZ2R6OVNxZ0lsZE1DYmVUcjM0RlJO?=
 =?utf-8?B?MVdqRmQxRGZGRXNFYkZDQ3hINGpUd2tuQ2QxV3Y5L0tyRmFIdng5VEJ0NnNs?=
 =?utf-8?B?NE1FV1Rqc1VabFhNV1dHR1NkWitJeUxHZVZGL1RCblJPNFBmUTdUMk9HNjZN?=
 =?utf-8?B?OWpuVzFlcFhNczl6VGozb3dvaGZIcWUraXY2NHorV3Mvd3AvYUpuOUVFTG1W?=
 =?utf-8?B?TG1jdU5ZZ2xvSlIrMnMzMHNLRC94aVk1Z0drVFVBZ3VDRG5RaDVZbUJ2R1Qr?=
 =?utf-8?B?ZnhoUnFURXN5MFJ6c09DUExKRmZSNTNKeDlNanA5YjQrbjRDeVY3MGYyZ2JG?=
 =?utf-8?B?Qjl5c2tOWHFJSFZoQWpKaEZUdlZGeXBJVytFbzYxYzRldjNaWjJ0bytlMmRI?=
 =?utf-8?B?QWpJeTVpbzBWR3k3WXNYU0plRHRKYmF5N3lIS3VIdTJIdkhtTmVneGcrdElC?=
 =?utf-8?B?ZXlwSW1CK1NiS1hNRldhYXJWL0l4L216dTNvbDlJK09wUHlLa0szZ0ZlVHo5?=
 =?utf-8?Q?JfMpv7L+0H561Zz4NkoHORs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?Rk9lVzFhZk5LclM0TS9qQkEzNzhXNzZxQk9pN0QzaG11MlJDWmp6Q2s1STRC?=
 =?utf-8?B?MUVScVZCNjUydXVSQm9BQzBiUzEvSGhUK2lwZlZMZWtvK3FoYWFmOEdzR3dv?=
 =?utf-8?B?b2kvV0pLZlJVTzI2L244QXcwbGM4Qll4M1V1Z1ZyNDd3L3J0R2QzOHhnSGYw?=
 =?utf-8?B?QlBvZWVnZEtQMitCQm1yOUVONFd6OGVxdTJ5NitGa2QrRGU3TUZ5S1RVNzZK?=
 =?utf-8?B?L2JVVnlYcDJwajErU3VUcVNzbmdwVG5jQ2tkOW52bVh4bnpNbkcyRVhKdGRs?=
 =?utf-8?B?aS91VW9iVmNmLy9wQmZBdWRCS1NmaFFSV1hVUnhBTDNWdHJENEJmTHNVSnNp?=
 =?utf-8?B?V0NFOW1zWlNrQityV0loTVZjTkxRU0VYTDBMSmYxK2FPZEsxUlFlS3pWeTJy?=
 =?utf-8?B?ZzJ4eVZtZmJGbTFXZTcrUjA1TWd5VndMNEFQZVl2N044SmlmZTJKajAwbnMy?=
 =?utf-8?B?NEVPdzByclFxU2I1ZEVWbTB1c3dQVGlqVnNzQy9hbnM0d0RSc1l6VURlTHJv?=
 =?utf-8?B?enQ0bEdyWkJnbUtybE96UE9OTzNMY1o3UUdBYlZQRElGZ2p6OEdUcTRnYjVr?=
 =?utf-8?B?K0tCd3U5Zmp0SlcxTGFUMzBUa0NzY3pmN3RIeFFWdFpndEtKR1N2U0JRTUlo?=
 =?utf-8?B?WmhSTzBxb3dqZ1dKQ200Z0pnREQzT05wQjNhNDlqRVlPZVpoZjMvSFpacFIx?=
 =?utf-8?B?NkE0Nk12Z0JUWUtoOUNudGZlS2pqSXRjL0JmMHBqRXhldzdFcGIyTTE0bGR6?=
 =?utf-8?B?UVBqOFpma1RyaHhpODR2bnJBdHJzdFVOR0xMb1R3UW04bG9DczhKRFMwa3Bx?=
 =?utf-8?B?N1ZaZnc0QUxHSXpGNE9CQXNDY0ZpdDlPVHBRK2c4c0xrZlZTdmZPeDNqMFZ1?=
 =?utf-8?B?Rmt0NUhoN3VDL2dBN0d1SnV6T3QvUDByNTdoZ2VXb2ZGeTYzVENQNmdvYzBL?=
 =?utf-8?B?d0VvdGlkSzdLbjBpWWxUNTlDQ0tBQVcrZ1AzcHF4aDA2OVlpbmtpbXZ3ZFd3?=
 =?utf-8?B?OFp1cHNRZUZzdzkwNHd3a3hYZWJCeWNZREYrbXNCUHdqeGhBUmxrc0svcmJV?=
 =?utf-8?B?cjZaMjNyYm0zc0tQNjY5TGFGRWN5VGZLT0g4aUpzQWx4NTZBMHlWWTg0NHhJ?=
 =?utf-8?B?WmZtUkxaTldIZDNNbXR4VGtrR0xIa2pnMllWQ3AvbjZUT3BQOTVIT2Z4YUQ4?=
 =?utf-8?B?VVdiVitoS0FrN2FSdW9HSEJxT2pSanZQVG9LZkpDYXE2QVN5QWZza1FCTEJM?=
 =?utf-8?Q?yJ5+YkRF5KYYZPA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e555f609-56a5-42bf-b64a-08db8ded095b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 15:29:00.9027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14t4owKxa5ITFQAHW2i2ief7FbgwzGn6zeVDAqRunZ0IJaWMqnSNPMT50fyqrZV/IgaPeXhlJOQPzEM0c++IQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260138
X-Proofpoint-GUID: KS58vDZGjfehDM8FxgAGLXX5HFuA2Z3A
X-Proofpoint-ORIG-GUID: KS58vDZGjfehDM8FxgAGLXX5HFuA2Z3A
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 26/07/2023 11:39, Jiri Olsa wrote:
> On Thu, Jul 20, 2023 at 09:14:42PM +0100, Alan Maguire wrote:
>> When a newer pahole is run on an older kernel, it often knows about BTF
>> kinds that the kernel does not support.  This is a problem because the BTF
>> generated is then embedded in the kernel image and read, and if unknown
>> kinds are found, BTF handling fails and core BPF functionality is
>> unavailable.
>>
>> The scripts/pahole-flags.sh script enumerates the various pahole options
>> available associated with various versions of pahole, but the problem is
>> what matters in the case of an older kernel is the set of kinds the kernel
>> understands.  Because recent features such as BTF_KIND_ENUM64 are added
>> by default (and only skipped if --skip_encoding_btf_* is set), BTF will
>> be created with these newer kinds that the older kernel cannot read.
>> This can be fixed by stable-backporting --skip options, but this is
>> cumbersome and would have to be done every time a new BTF kind is
>> introduced.
>>
>> Here instead we pre-process the DWARF information associated with the
>> target for BTF generation; if we find an enum with a BTF_KIND_MAX
>> value in the DWARF associated with the object, we use that to
>> determine the maximum BTF kind supported.  Note that the enum
>> representation of BTF kinds starts for the 5.16 kernel; prior to this
>> The benefit of auto-detection is that no work is required for older
>> kernels when new kinds are added, and --skip_encoding options are
>> less needed.
>>
>> [1] https://github.com/oracle-samples/bpftune/issues/35
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  btf_encoder.c  | 12 ++++++++++++
>>  dwarf_loader.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  dwarves.h      |  2 ++
>>  3 files changed, 66 insertions(+)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 65f6e71..98c7529 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -1889,3 +1889,15 @@ struct btf *btf_encoder__btf(struct btf_encoder *encoder)
>>  {
>>  	return encoder->btf;
>>  }
>> +
>> +void dwarves__set_btf_kind_max(struct conf_load *conf_load, int btf_kind_max)
>> +{
>> +	if (btf_kind_max < 0 || btf_kind_max >= BTF_KIND_MAX)
>> +		return;
>> +	if (btf_kind_max < BTF_KIND_DECL_TAG)
>> +		conf_load->skip_encoding_btf_decl_tag = true;
>> +	if (btf_kind_max < BTF_KIND_TYPE_TAG)
>> +		conf_load->skip_encoding_btf_type_tag = true;
>> +	if (btf_kind_max < BTF_KIND_ENUM64)
>> +		conf_load->skip_encoding_btf_enum64 = true;
>> +}
> 
> hi,
> so there are some older kernels other than stable that would use this feature
> right? because stable already have proper setup for pahole options
> 
> or it's just there to be complete and we'd eventually add new rules in here?
> wouldn't that be covered by the BTF kind layout stuff you work on? is there
> some overlap?
> 

Yeah, the idea is to minimize the complexity when adding new kinds. The
approach explored here does this because when adding a new kind we have
to either

- make it a pahole opt-in parameter, which means more --btf_encode_*
parameters for dwarves; or
- make it an opt-out parameter, which means more stable backports to set
the opt-out.

My original hope was BTF kind layout encoding would solve the problem,
but the problem is that new kinds are often entwined tightly in the
representation of structures, functions etc. When that happens, even
knowing the kind layout won't help an older kernel interpret what the
BTF actually means when it was generated by a newer pahole. Kind layout
still has value - it means BTF can always be dumped for example - but it
can't really help the kernel to reliabily _use_ kernel/module BTF
information. So the approach here is to try to streamline the process by
not requiring new options when a new kind is added; we can simply detect
if the kernel knows about the kind and skip it if not. Since this
detection is all internal to pahole, nothing needs to be exposed to the
user.


>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index ccf3194..8984043 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -3358,8 +3358,60 @@ static int __dwarf_cus__process_cus(struct dwarf_cus *dcus)
>>  	return 0;
>>  }
>>  
>> +/* Find enumeration value for BTF_KIND_MAX; replace conf_load->btf_kind_max with
>> + * this value if found since it indicates that the target object does not know
>> + * about kinds > its BTF_KIND_MAX value.  This is valuable for kernel/module
>> + * BTF where a newer pahole/libbpf operate on an older kernel which cannot
>> + * parse some of the newer kinds pahole can generate.
>> + */
>> +static void dwarf__find_btf_kind_max(struct dwarf_cus *dcus)
>> +{
>> +	struct conf_load *conf = dcus->conf;
>> +	uint8_t pointer_size, offset_size;
>> +	Dwarf_Off off = 0, noff;
>> +	size_t cuhl;
>> +
>> +	while (dwarf_nextcu(dcus->dw, off, &noff, &cuhl, NULL, &pointer_size, &offset_size) == 0) {
>> +		Dwarf_Die die_mem;
>> +		Dwarf_Die *cu_die = dwarf_offdie(dcus->dw, off + cuhl, &die_mem);
>> +		Dwarf_Die child;
>> +
>> +		if (cu_die == NULL)
>> +			break;
>> +		if (dwarf_child(cu_die, &child) == 0) {
>> +			Dwarf_Die *die = &child;
>> +
>> +			do {
>> +				Dwarf_Die echild, *edie;
>> +
>> +				if (dwarf_tag(die) != DW_TAG_enumeration_type ||
>> +				    !dwarf_haschildren(die) ||
>> +				    dwarf_child(die, &echild) != 0)
>> +					continue;
>> +				edie = &echild;
>> +				do {
>> +					const char *ename;
>> +					int btf_kind_max;
>> +
>> +					if (dwarf_tag(edie) != DW_TAG_enumerator)
>> +						continue;
>> +					ename = attr_string(edie, DW_AT_name, conf);
>> +					if (!ename || strcmp(ename, "BTF_KIND_MAX") != 0)
>> +						continue;
>> +					btf_kind_max = attr_numeric(edie, DW_AT_const_value);
>> +					dwarves__set_btf_kind_max(conf, btf_kind_max);
>> +					return;
>> +				} while (dwarf_siblingof(edie, edie) == 0);
>> +			} while (dwarf_siblingof(die, die) == 0);
>> +		}
>> +		off = noff;
>> +	}
>> +}
>> +
>>  static int dwarf_cus__process_cus(struct dwarf_cus *dcus)
>>  {
>> +	dwarf__find_btf_kind_max(dcus);
> 
> first I though this should be enabled by some (detect) option.. but that
> would probably beat the main purpose.. also I think we don't need kernel
> with BTF that it can't process
> 

Hmm, maybe it might be good to have it associated with --btf_gen_all in
case we ever want to disable it for debugging purposes? What do you
think? Thanks!

Alan

> jirka
> 
>> +
>>  	if (dcus->conf->nr_jobs > 1)
>>  		return dwarf_cus__threaded_process_cus(dcus);
>>  
>> diff --git a/dwarves.h b/dwarves.h
>> index eb1a6df..f4d9347 100644
>> --- a/dwarves.h
>> +++ b/dwarves.h
>> @@ -1480,4 +1480,6 @@ extern const char tabs[];
>>  #define DW_TAG_skeleton_unit 0x4a
>>  #endif
>>  
>> +void dwarves__set_btf_kind_max(struct conf_load *conf_load, int btf_kind_max);
>> +
>>  #endif /* _DWARVES_H_ */
>> -- 
>> 2.39.3
>>

