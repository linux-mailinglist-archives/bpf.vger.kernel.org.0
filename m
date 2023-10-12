Return-Path: <bpf+bounces-12034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04A07C6FA7
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 15:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D459F1C2107B
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 13:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3D22E640;
	Thu, 12 Oct 2023 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QB1cO5D0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Te1OJNc4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ECB2942B
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 13:49:39 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C4F91
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 06:49:37 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CCvees001503;
	Thu, 12 Oct 2023 13:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5ivlOJ/q+fQ2bM+Y7NXfVk+PyveaTdzjPNlJAG4QCIs=;
 b=QB1cO5D0kZd54JTbgEzXjs7z65uXO7XwCu8wY/d4aTMys8+KgkHacCwGehMIfMeMc3V6
 HZSSSDVld7sbv2iNTSsoEcsacGwhb+PNsb2pFQjqoJLPFLzcrYsLUs6tZfE7bbSU9IIu
 aOU6PQhp07/+mUpfuC0x2W8YbgEngnyVzfrksMXvM5FiOze308nW5J0rvh+QPUFyzrWh
 2904nAkul8oAEjX5toDUyUZ5eTYe915rI9KKQ7/z+LVMxq306xDbRAquYwgzWtbc/OFt
 clxIYp+Z4Kgu5z8tHhFYjYQWK41ErpC56YX39nCKmhgcTIUVUaK6a/50UY0EtBrj46X8 Rw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx8cjx4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Oct 2023 13:49:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39CDhHQ9005049;
	Thu, 12 Oct 2023 13:49:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsa2tgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Oct 2023 13:49:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGZzRXIbnAxW/1czYfvFpsPxAvktQDPh5CNm3wqERNCj52+uscXN7ll0456yzbY1gxknhBmxtEB3lGY2oBipRda6flRMuz0fU8VvVaz4fXJV+MfOe3hNTDYYtOAV+fmfReikoXVGWw3i8pVJFciNKUkl5NadG8tOCx0xs4F+8mY3Alig2MlM3yE7sWgj7WGebO7Z4xXxgHdiRkG7WVWWWc6suOhZEF3nBNfGqPhY/SJ8hy7fOb90yqvdsEoqudm8gfib+8kGq/pLcv7c5Y4R+Q1GCv2LFxkMkOnQ19nsWOt1EXr0gg+/FwqaA2mQ2KZs8q9Oy/3rR73m7Zut04ZVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ivlOJ/q+fQ2bM+Y7NXfVk+PyveaTdzjPNlJAG4QCIs=;
 b=kAZvjMZV8SV6n2ZAP87MM7tx8q/YFtjkmewscj9HUf70hQ7r0ab15o4CwvnRL+456JDsK1IXy4S++3XQqDMA3dSfknqsFPW0xkWbB5jlhhnss5RPAUzYX6De5pSCeqvY906RoUnuQfoeUGlftkaiFmhSH2UxB4J/UusswI+auh14+8TINraiD1e0pVuNHr7rmTZmFbCkpkA2S/eldoXFdrf6+2EzQ91clrH5DROhphDUwY8VLZBOa59yjCHKmdI1ep31cOl/tmeFERmmrXCJmiUG5LGvbBSUgNP+e/yUOpEthUjq8pKI7yHFrztYIvDWrW7xkZ1XPMvCD4AVQx+w2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ivlOJ/q+fQ2bM+Y7NXfVk+PyveaTdzjPNlJAG4QCIs=;
 b=Te1OJNc4x88xn5udB9STYkV7QhWVH/tH1RMAYpQ9/cTDcJZuhB1qYX2UJ1wx5nI/LfqB4wf7eH+WNcvNDP2ajCvI5gI/x1/Jalab8Yl64d9akV/UsYHBzIaCvBpN5zsSPAPTnJSX1H+1MsxTtYaN6v2DYKPF3OPbFnJdIznkcb8=
Received: from CH0PR10MB5276.namprd10.prod.outlook.com (2603:10b6:610:c4::23)
 by SA2PR10MB4619.namprd10.prod.outlook.com (2603:10b6:806:11e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 13:48:57 +0000
Received: from CH0PR10MB5276.namprd10.prod.outlook.com
 ([fe80::5b90:1cb6:408:90e3]) by CH0PR10MB5276.namprd10.prod.outlook.com
 ([fe80::5b90:1cb6:408:90e3%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 13:48:57 +0000
Message-ID: <632ce05e-1c22-62cc-9512-616627d2a6e2@oracle.com>
Date: Thu, 12 Oct 2023 14:48:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC dwarves 3/4] pahole: add
 --btf_features=feature1[,feature2...] support
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: acme@kernel.org, andrii.nakryiko@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com, mykolal@fb.com,
        bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
References: <20231011091732.93254-1-alan.maguire@oracle.com>
 <20231011091732.93254-4-alan.maguire@oracle.com> <ZSfsRzfcGuiJPVnb@krava>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZSfsRzfcGuiJPVnb@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::25) To CH0PR10MB5276.namprd10.prod.outlook.com
 (2603:10b6:610:c4::23)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5276:EE_|SA2PR10MB4619:EE_
X-MS-Office365-Filtering-Correlation-Id: e99994f5-a8c7-4d0c-0990-08dbcb29fb0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cntqAKh/vgD9GaYhpA61FVvvIrJJ6EGjvsDovWRLmioOTdpT40uKG1uN6ySkwBZZ+m5JmEgpBHTKw+kZcj45t0zXXDjr8khVGTnKbj9Q8v0bec6dVwuJj91xFCzC++Copkq35/ectbSbGq8GqMrP4PBcgo303V1aBswNMYWU3BIhUCPhJ/yMx0FoHPkFsUJvSSfrfiAF4/fs+MJPhN6frqZT+5pueMC+E8Ey3g6ffu8g59/6SwMEWSc8tEZch7WZVFAxM+DhRi6LduMej+G/JmmjS09/g3+yJb84e4UlykUnmDh+VZmN+V/zyW9KpE3+bkZdXUY3JaOWu8m0cbEJG6hxWUuQuS5nbJKdoQISMMrFyl6RDJdlZbv4F24+txJ4ge0KHOa3RJCuJOY683XTxF9qOJAUQTjlsOrCS+xInCNNRtlVU/NskUhPMJTGnEkjl9pqya7tPkWUxP4o2ZW54S3i5I9WF7zwFHTHZN8Aub0kUw0fzFOetEC0uQsnfYST4qARHMMt5REwGAchDrEY2nFmskkt+hVuP+YKUomz8uFlRqP4GBMCbMh2TejGvFIneUdvjKNQ4gtsTtWtQJrdjRmJHm3GUjt4iVYsXbG+3YDNXsz2SqYDeq3NhNVpcjg1KPJoGqTKC0PcNk3dTh+6zQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5276.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2616005)(53546011)(6666004)(6506007)(6486002)(6512007)(478600001)(86362001)(31686004)(66946007)(66476007)(316002)(6916009)(66556008)(31696002)(5660300002)(8936002)(38100700002)(41300700001)(44832011)(8676002)(4326008)(7416002)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aGMxSEo4UHlFYnFoajJ0SmVzbnJteDZrdjBOc0diVUtKSnM2OWNuUy9ibFNu?=
 =?utf-8?B?bHhrWmFLNE1VbnZSc0JWSVFybkw2eXcxd2ZHMW1oNUxXNkE4S1VhTTlHL2ky?=
 =?utf-8?B?a1k4VzNBTFVydDBSSWxEWE5RRlpEbnpmcFp6THYxUWZmQ2lZOXUxdGQvTUcv?=
 =?utf-8?B?SDhhVko5bTFLd2ZwUmFkSlNnVzkxWTNIRjkrU2tPZW5wa1dubG01T2g1UFpF?=
 =?utf-8?B?alNJd05WTStzTzBCVmdCYk5kelp6aE9EcVlZQ2ZYRVpiU0FPTmpjT1pLd1Q5?=
 =?utf-8?B?YjVLVWpzUzVPQjAweUdiUXovcjFhcnlScndrNUhnRmlHeHQvMDB6RGNBeEhw?=
 =?utf-8?B?VTVCSGhQOUl5ODQwSHcvb200eWJnNmhWNWJxckJzOTJ3eU5venpOeVVtVCtU?=
 =?utf-8?B?VlB2YWV3aGZtbCt4NzRsL2x0MG9wRktOZDhKLytnaTlvay9BK2EzTkpWc3VV?=
 =?utf-8?B?OWR3K016OWxvTjNCVTJoRlR3TnFpZ2xkYkNodGh5WjEydTg4Ykd3a1l4dmRW?=
 =?utf-8?B?ckVycUJnMVZmcUIxM1laWlNjZW9WWlhNWEI1cE0vZUhTRmlpeUZpSmJxeHMy?=
 =?utf-8?B?ZzlBMmNpelcxbnJoY29ldUxLc1I3MFNQUDBTbXJoNHFDbStIcUd0alVmeFdn?=
 =?utf-8?B?Kzhsb1pKLzFkWFV6S2pqWG9lcFgyR3YrbmNCU2pCVTd4WjF6c2JiUWx0S3R6?=
 =?utf-8?B?MEc0bGVhRllRSXFHYWlTd1N2b3dNWUluRDc3RmxqdjFuTmpuYkIrWUc3WHRa?=
 =?utf-8?B?RGNGSzF5R3Q1aUsxNktva3M4VDY5SGVObGN0Ni9ZekIvNzZRem00UEZJYmJm?=
 =?utf-8?B?a2dGc04ydEFwOWhJbVhFWFR2aEpWQWNrSXlzMlI1N3oxaG9KMXZOMjEvOUM2?=
 =?utf-8?B?TGFCVXZRWitNMDJ0bEFjQ20wbU9WbzFESittenZxRm9WOEVMQUNDY29pVW5N?=
 =?utf-8?B?UmhWdEdrQXoyWTFEeWJCQVVkZmxpR0Rob3ljN2tlcXgvQWIyWW80bHpTLzlO?=
 =?utf-8?B?M3FpMUg5eWFsY29DU0Vac1ZSQVZKMjFuME0wdUFzY0JIY0Jlc0RoUWlHYzM4?=
 =?utf-8?B?bHpNZjVyY0VyeDhUclhJeUtoNU5aay9VbytXRW1qTU9MQnJCcUVqNndxWE9Y?=
 =?utf-8?B?REpWR0dIbTBLdjVVcWpaNTRCaEd0THRtRjRzOExCejhwZmg4VDBZTGZ4U3ZS?=
 =?utf-8?B?L0gxVGg4U1dxQWwrMVA1M3hqVG5SdExtRk5xeCt2NWhqN1pDL3NPRFozZFUv?=
 =?utf-8?B?RS9SOUpBOUE3QkRBc0NuTmNvaUpDS2RaSCtUbm5ZSkZQMHcyVVJJN3RObm5Q?=
 =?utf-8?B?TXNBQTROZjdQVlhJK29wckZ4OFc2UWZPdGJpTitPb2FuTjBYQUUyUGFjL3Ey?=
 =?utf-8?B?aEFXb2I1REViSStuT0hZS0tlUVhpVW4zZU5sSERsZ0N2dk9USkdCZld1RzF6?=
 =?utf-8?B?WjdITFNEcEpMTFQ3Z0hHSGxPdG0vNzdkZVhkWUNELzkvRm9OVUNNZHdIYmhN?=
 =?utf-8?B?U2JVcVE0ZkN4d1RvQzBuekxUcU9SajhVTGVsZGkrK0R0MTVCdVBvSlVERGx5?=
 =?utf-8?B?VGJtUGp1Zzdrc0VubHNmL0ZhWTF2ellnSlR4aUZETWpKcXRic1pqNkE0S1ZG?=
 =?utf-8?B?eElsV2cxQTdGOW5GUnlNQjlZU3VoS1FCUGhoMnRCRWZHMlBkV2FLQUEybSsx?=
 =?utf-8?B?alB6b0ZLU0hpUjR6eG9Ia3BNYzdOL3QzaHdLSVlRRzJiMlV3bzZNYlpTOVpn?=
 =?utf-8?B?RWtxOUpkRE1mcU15d253UFFjb2g0SmRpbEtUMnNid3BSV2FJbHJUaUZyYmho?=
 =?utf-8?B?dzV5WHJJMVNyaE4yUUNYUTlPeW1RQU1EeStUYUxBbFczUXRHMnRuWTNxTVYz?=
 =?utf-8?B?T2J0dlhlcEZDSWltVEx5S2hkVy8xa3BkaTA1ajR0OG1KUWpiQ0wvYVJuMkJL?=
 =?utf-8?B?ekV3YytuZHdSaW1KVGVBV2tBdGk3dnR1dmRuOTUxU0FFTjhsRG1ERnBTdDU5?=
 =?utf-8?B?MjVkeUtJR3p1Y3FQRDFSMWJROERPK1VwNm1QVmxjZVF4aVordWJTc24welRP?=
 =?utf-8?B?cFJHc0hhSlJpdkNud2xoWklnTWphV0VpdXF3anBHUU9URUJnQnU0b2cwSjhj?=
 =?utf-8?B?UjBsSGlMRkRiZ0J4Z25rQVlQTndCL1ZYbHZCaWd1TjdZMkF4ZWFSV2thQjVG?=
 =?utf-8?Q?7YsSqLj/GuLZ0cDvY2O0ILM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?eVN1bTVtaVlvVDFZa1JLck9QRFJZeERKc2NGOGhPTExFcHJRdndBSS9wQWkv?=
 =?utf-8?B?bWZSK0FCY1dUY1lZcSs0QUk2N3dNSllrazF1RXBmaWxOZXFONWk4c25kRHlJ?=
 =?utf-8?B?RFYxT2t5ODBOZXVmN3ZNT1hNdHhOREU3Zkc2bVFZem1vUkEyQVp0aDU2Tkhm?=
 =?utf-8?B?NEhtLzFzMkZmRytxS3AvNlcwOFJzZVo2MlpGeXl3WlVhUnNja1dkTG9CeTZp?=
 =?utf-8?B?b2l6RlNBSGV3akVNbTlybzJzV2JtRmh1cnRxM0o5WjhMK25OSXdWMkQ1Q3B0?=
 =?utf-8?B?QnFMekdyZlU1bmhrYlJ6bGhzaE1LZXQzMTg4V0RLTm1OQXFKWjEyUHNHbTdM?=
 =?utf-8?B?QjJkZFpoc2lNSlB0RDkrKzBCaEpJVVlVRW5yV1Y5R2QyemEvQklEb3ZlUXp1?=
 =?utf-8?B?UUIveWl1UENndmZIV2NXWmVGZm80SVRzUXdIZEozZWM3MkVQNXFSZ25kdDJZ?=
 =?utf-8?B?NGk5aTFzcjRkeHQwL3MwMG8wL0hTSXZ3ejBUN2EwK3RjNTVER2xGN1ZFdGJ5?=
 =?utf-8?B?azFaOXZMT3VDalhBT3poUjRSNW54eTByWVBqVjRPd0JzU05pYU9pL0RQbmVG?=
 =?utf-8?B?bm93M3FML0ZoaHNEUHhzT0JqcS83dlZUcFNMTE9QVklQVmkzdExlc0JZb0gr?=
 =?utf-8?B?U3p0Q24rQjArWElVRVBKRmRtWklHUlVrU1V2N3psR21ESlk4S2IrejR3YWhv?=
 =?utf-8?B?M0RGN3dxNXhvM1NyYldJSmw0M05VNmxPOXhJNlJMU2NVZFREUWlEd3NTZExv?=
 =?utf-8?B?UUFQK0tOK0MwUm9IbGVQMGRLUFhJTFh6K2tlSGI0bkREVkVkL1FLM1hqSzlY?=
 =?utf-8?B?S0tJSC9MOTlhR0cwdWhxZ093OFZIU3VQZHB4ZzdtYzdDOWpTT1dSYjF0Z3Y1?=
 =?utf-8?B?T1IzZVQ4TDZCMjM1V2l4V24yRGlEc3M2TXUvb1AwbnlWd1lrZ1I2ZGdYZTlt?=
 =?utf-8?B?R0ZqcGRwV2pVUTkreWFmZ1AwcGRPZzZtamZvYURjMWdMc2JQSk9yNGxzbmVa?=
 =?utf-8?B?dDE3aVBoSHgrem80MjVDY25JU05aMTgvbnROYURaR0lLSmRycldRTERIdnN1?=
 =?utf-8?B?aWFPR3FRMHdXWVVIR0NIRlFVSHlPUXc3L29mZmJaRmY1Y3BhVXcxS3VLaTlm?=
 =?utf-8?B?RDZETnZzSkhQYXpvZ2NPdzNGR3FneThYdzU5d3prQnBseW5hOWZ1VW9nc1dM?=
 =?utf-8?B?NmE5dnQxdXVKZVF2M2Jld0l5OHg5Uk1tZUQzMFRDckRMMWsyd25mRlpKLzB0?=
 =?utf-8?Q?eDjlzPPkcsizXbl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99994f5-a8c7-4d0c-0990-08dbcb29fb0d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5276.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 13:48:57.1629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76QP0aQCVBf6mAqDwpcj6xAzZj+staeG1tiNUYjQ5rqtedxh7piA4bT+pBrsCEhwzE7vc4eonyzT92sLdLAY1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120113
X-Proofpoint-ORIG-GUID: nktUaz1xJ532_dkEP8ou2V_roRDo7wHX
X-Proofpoint-GUID: nktUaz1xJ532_dkEP8ou2V_roRDo7wHX
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12/10/2023 13:53, Jiri Olsa wrote:
> On Wed, Oct 11, 2023 at 10:17:31AM +0100, Alan Maguire wrote:
> 
> SNIP
> 
>> +#define BTF_FEATURE(name, alias, skip)				\
>> +	{ #name, #alias, offsetof(struct conf_load, alias), skip }
>> +
>> +struct btf_feature {
>> +	const char      *name;
>> +	const char      *option_alias;
>> +	size_t          conf_load_offset;
>> +	bool		skip;
>> +} btf_features[] = {
>> +	BTF_FEATURE(encode_force, btf_encode_force, false),
>> +	BTF_FEATURE(var, skip_encoding_btf_vars, true),
>> +	BTF_FEATURE(float, btf_gen_floats, false),
>> +	BTF_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
>> +	BTF_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
>> +	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true),
>> +	BTF_FEATURE(optimized, btf_gen_optimized, false),
>> +	/* the "skip" in skip_encoding_btf_inconsistent_proto is misleading
>> +	 * here; this is a positive feature to ensure consistency of
>> +	 * representation rather than a negative option which we want
>> +	 * to invert.  So as a result, "skip" is false here.
>> +	 */
>> +	BTF_FEATURE(consistent, skip_encoding_btf_inconsistent_proto, false),
>> +};
>> +
>> +#define BTF_MAX_FEATURES	32
>> +#define BTF_MAX_FEATURE_STR	256
>> +
>> +/* Translate --btf_features=feature1[,feature2] into conf_load values.
>> + * Explicitly ignores unrecognized features to allow future specification
>> + * of new opt-in features.
>> + */
>> +static void parse_btf_features(const char *features, struct conf_load *conf_load)
>> +{
>> +	char *feature_list[BTF_MAX_FEATURES] = {};
>> +	char f[BTF_MAX_FEATURE_STR];
>> +	bool encode_all = false;
>> +	int i, j, n = 0;
>> +
>> +	strncpy(f, features, sizeof(f));
>> +
>> +	if (strcmp(features, "all") == 0) {
>> +		encode_all = true;
>> +	} else {
>> +		char *saveptr = NULL, *s = f, *t;
>> +
>> +		while ((t = strtok_r(s, ",", &saveptr)) != NULL) {
>> +			s = NULL;
>> +			feature_list[n++] = t;
>> +		}
>> +	}
>> +
>> +	for (i = 0; i < ARRAY_SIZE(btf_features); i++) {
>> +		bool *bval = (bool *)(((void *)conf_load) + btf_features[i].conf_load_offset);
> 
> nit, would it be easier to have btf_features defined inside the function
> and pass specific bool pointers directly to BTF_FEATURE macro?
>

thanks for taking a look! I _think_ I see what you mean; if we had
conf_load we could encode the bool pointer directly using
the BTF_FEATURE() definition, something like

#define BTF_FEATURE(name, alias, default_value)                 \
        { #name, #alias, &conf_load->alias, default_value }

struct btf_feature {
        const char      *name;
        const char      *option_alias;
        bool		*conf_value;
        bool            default_value;
} btf_features[] = {
...

This will work I think because conf_load is a global variable,
and I think we need to keep it global since it's also used by
patch 4 to get the list of supported features. Is the above
something like what you had in mind? Thanks!

Alan

> jirka
> 
>> +		bool match = encode_all;
>> +
>> +		if (!match) {
>> +			for (j = 0; j < n; j++) {
>> +				if (strcmp(feature_list[j], btf_features[i].name) == 0) {
>> +					match = true;
>> +					break;
>> +				}
>> +			}
>> +		}
>> +		if (match)
>> +			*bval = btf_features[i].skip ? false : true;
>> +	}
>> +}
>>  
>>  static const struct argp_option pahole__options[] = {
>>  	{
>> @@ -1651,6 +1728,12 @@ static const struct argp_option pahole__options[] = {
>>  		.key = ARGP_skip_encoding_btf_inconsistent_proto,
>>  		.doc = "Skip functions that have multiple inconsistent function prototypes sharing the same name, or that use unexpected registers for parameter values."
>>  	},
>> +	{
>> +		.name = "btf_features",
>> +		.key = ARGP_btf_features,
>> +		.arg = "FEATURE_LIST",
>> +		.doc = "Specify supported BTF features in FEATURE_LIST or 'all' for all supported features. See the pahole manual page for the list of supported features."
>> +	},
>>  	{
>>  		.name = NULL,
>>  	}
>> @@ -1796,7 +1879,7 @@ static error_t pahole__options_parser(int key, char *arg,
>>  	case ARGP_btf_gen_floats:
>>  		conf_load.btf_gen_floats = true;	break;
>>  	case ARGP_btf_gen_all:
>> -		conf_load.btf_gen_floats = true;	break;
>> +		parse_btf_features("all", &conf_load);	break;
>>  	case ARGP_with_flexible_array:
>>  		show_with_flexible_array = true;	break;
>>  	case ARGP_prettify_input_filename:
>> @@ -1826,6 +1909,8 @@ static error_t pahole__options_parser(int key, char *arg,
>>  		conf_load.btf_gen_optimized = true;		break;
>>  	case ARGP_skip_encoding_btf_inconsistent_proto:
>>  		conf_load.skip_encoding_btf_inconsistent_proto = true; break;
>> +	case ARGP_btf_features:
>> +		parse_btf_features(arg, &conf_load);	break;
>>  	default:
>>  		return ARGP_ERR_UNKNOWN;
>>  	}
>> -- 
>> 2.31.1
>>
> 

