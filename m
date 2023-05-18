Return-Path: <bpf+bounces-867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8012F708299
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 15:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365272818ED
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 13:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A35E23C9E;
	Thu, 18 May 2023 13:24:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE90C11CA8
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 13:24:54 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7226EF3
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 06:24:52 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6IrDp028576;
	Thu, 18 May 2023 13:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1KFS6qo6L8rO7V9eQp+w8aJ2GmhfGYg4AO3/D5aTntM=;
 b=AGUsx1Lb/Z4S1pEz7ZhYdsk1FtkFiOQ09HYn4dkchC2tTuX6lIRaQoiHPz5ZoE/vXbeJ
 WTuE2OwGLHiLhYAbGbh9SBV3fX9IyD+XJjGQEiFJpzjA277AkTbipJ6rRZG+KigXgAXd
 2EZAVZOO2tQc8AsFgilAtfldUkhAEJaz3loMxM/k8MaQbFDhpUS7oq7S3dVf0gr+B+w2
 v2wXfSgsMHkDtDXHtFn1mNfXYOHbisHe56vjhBRWl+Zl9Xergpfny2Zbw3uX58SSQBv9
 0A74fCfpkgh3RrznbORCugZ6viLG1opfl0YsaRntWeez70iWhRefXe7mXHMO1ltJG3zz 8w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc884e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 May 2023 13:24:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34ICDVjL032227;
	Thu, 18 May 2023 13:24:29 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10ct7jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 May 2023 13:24:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moFUClRlfsA5qXT0PPPwYVUM7Rxi17GkY/YpVnz1i4SkyuAW0ch5XDhLs0+lfrcnqfgOp6PEab1Hkx9vZR4+/QGea35/2u6jUM2AV6MALf0uHlZC2rMMrc9TvZxI5jNeeZSVPdmmgGGacOUBaMG/Ca597I7BUJjk5CkyzVVRfcoLF5Wy2X4lCX6Cju1ANUqZp6aJrvwA71S74tv/1c7IUTeGZU7SyibSEephqVVdVLiAUmZFWqwo3R8l6fSaTdLgYeIFtCUqph1lWC3Ud/k3Www3KpzJ7rPx5SrzPSW1OxNC1G1HvUjqqYwM0fEkJ8J9D8vRM93UL5zDhhnvyJepSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KFS6qo6L8rO7V9eQp+w8aJ2GmhfGYg4AO3/D5aTntM=;
 b=kauBgt0xfOMyeqxEJYB7X5Lhb8Eqb5E6ODukHpl+br6yrlUwX82LKNuqrPGF8ELF5o7QALYhwG28CA7+Z4FxIlB/twoIIvLseASIPRFyUrbXgwdPfQUb1SA006xfmd+zflbUPPvIP3/gc0Lp3yg8rtu5YWAZou3xOSoDt6+r/fCacDVywpZZ85ku7iwSWQ9m+UPpVQ1uAZcyNw8wyh72XcGUm25uKRltWZBEc2cp7rqm6MSD5xqg8qHVoX9GU0inOa+497w0xZ/spKr+hnCS4hV2omUans5Zu4OapmaLrD+pWWBClf9RSMsIl7btDJvudOeQhiVTr8hcB2fbVa4bXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KFS6qo6L8rO7V9eQp+w8aJ2GmhfGYg4AO3/D5aTntM=;
 b=yOqdUAnQWenRXnb1TFMnYR8xmnuJDa4V1w2VHSZ9rJQ2jpBQexEnaVt60grkUMEw0dQXdOSVH/JQiDz5ua9jmbLJ4Nyc+OTnvFOlF0nvlk9ZlGTLi6ib+LvnD/6LPPtBZEpBAYbyIUkLiwHiBf/S25mzQ9tsECFZzWqzyI3z+wo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH3PR10MB7308.namprd10.prod.outlook.com (2603:10b6:610:131::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 13:24:27 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace%6]) with mapi id 15.20.6411.020; Thu, 18 May 2023
 13:24:26 +0000
Message-ID: <35213852-1d29-e21f-e3f8-d3f164e97294@oracle.com>
Date: Thu, 18 May 2023 14:23:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC dwarves 5/6] btf_encoder: store ELF function representations
 sorted by name _and_ address
To: Jiri Olsa <olsajiri@gmail.com>
Cc: acme@kernel.org, ast@kernel.org, yhs@fb.com, andrii@kernel.org,
        daniel@iogearbox.net, laoar.shao@gmail.com, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, bpf@vger.kernel.org
References: <20230517161648.17582-1-alan.maguire@oracle.com>
 <20230517161648.17582-6-alan.maguire@oracle.com> <ZGXkN2TeEJZHMSG8@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZGXkN2TeEJZHMSG8@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0308.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::7) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH3PR10MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6673d8-3308-4464-b258-08db57a333df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	C7PAhfLzuRj6VxCTvY4nK5rETdBRDXu1STWOkm4GxoUumQJ0RJAqlFQZEjebtvjUjoEpkrCRUPuh2pcwNAe55jGimZehupfgf4ygoo//eYN1Q5aTosnWopA4BpXalpRhv/D9hGaaAtKsqgR++IOUG1DqNYBoPMcWgmbaG7ayNEMckHYakayvVhzGvrk+ExqGtYZ7g+VJbBdBdd6hgyrVuSmBwTVYm3B4GOup1JinBr2QxsJm8p4pLbBCdwwm36/ldx19Tup/n3uG2cKkh1oFxVPaW1rmrWiI/2bnq2IYGUzws8BuwlYFQEpKj1XZ+RA/5/X+9AAdw/rNzYnIUQhpOzY/aMOwnHy6peyf6SSHEiXy0kW++PvURSili0EPtStQ6wEGT+1TxyPB3Q/ZxBshrS63W9fodXlB1AktMeupmZpeAAYUkKfHzXD64ct5m4DCs8AM9LGySJykGxawnWQvEoga2opf0KXt38isCGqI8Kj80BSmkdqDvJWzZ1PiFK+R3uM23hWwEiritTBp+QXS1tSNSFDts8Iw9x9ziop9DRVtuffycXtq6chJxg8pKUIp8I1C79iyNBItyuDo2WNaYdgfNw06jnb0HuZ0dX5OY0ZfTxUJHMMXFMvpm+zIUYPHVrc2i93whHwWp3QWTn0sFQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199021)(31686004)(6916009)(84970400001)(4326008)(36756003)(2906002)(7416002)(44832011)(8676002)(5660300002)(8936002)(66556008)(31696002)(41300700001)(86362001)(66946007)(66476007)(6666004)(478600001)(6486002)(316002)(53546011)(6506007)(186003)(6512007)(966005)(83380400001)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZndJSy8yWDFoektlTmZ1eDlOOVJiUktaTzVacndzUDltZEttSExWTUNVLy9I?=
 =?utf-8?B?bm4ybVRIYThmNExFOGwvWncwOE9OekFBcElwTE1FL1JCU1JpV1JEVng4bXN4?=
 =?utf-8?B?dUhwbWJOcXhaZHpYZmk4NTdJVkNFNUZ6YVZ0R25lclUweUtpVHpKK0JDR0N2?=
 =?utf-8?B?TVQ1SDgwbEIzS05vLzRLVElQYURPUE1DOFlMSlVBWE5tWHY0aVU2Tm5tQk5U?=
 =?utf-8?B?cEFqTE5RSXp2aUlLQXJRclJGNGpqcEtKSkZlOGRMZGJUM29BRlQ0K0doWFRj?=
 =?utf-8?B?YlJoYTJScDBBa05YcmtIUmo4WU1XSTBiYjZWcW1VZVpqSUZ1dWdTWEF3U0sz?=
 =?utf-8?B?TjZhQWVFOGNnVEtuR05hQW5EUmZTbXJwQ3Vab24vSmdnSXJkeDJTSCtjdXBO?=
 =?utf-8?B?Qi9STXg4RVZKdllUMldORE4ybW9XMGZZaVZCUG5SYnRUdlJOVWtra1RCN3Fr?=
 =?utf-8?B?cDZOUXRNc0d3VlFmNVNYWEc1RTVlQ2ZaaEIybjJaNFRFaC8weU14UmpIUGhj?=
 =?utf-8?B?djIzL3d0YjNXbmlIOU9FWWZqTjNNVVRmV3huNVZZc010VVRPVEtjQVpLc3JM?=
 =?utf-8?B?UHRFdEk4b01MaFhwN1IxajUzVzJJbkxYM3VIYjA2bmhTeXRkYmRRTmJsUjZt?=
 =?utf-8?B?dGdzRFZnU1J5UTZtZExGeXBEZlI0cHduK3Rsd1NtMHlqL2YyUWtSUmVsc3Bh?=
 =?utf-8?B?RVVtYWZGQkJobGZPNmgvUlJycUZKemd5WjdVZE5qOFBockU3K2xpUWNIZnRr?=
 =?utf-8?B?V1ByZEtKcFNGS1d3MUhpOXFqRzV5L0xpRC9nOURuNjlHSzEvK0pYZEVmc0hy?=
 =?utf-8?B?WnhlMEc3cjBZbHdCY05VeEd2WVVrMmpudlVDaGJFRWEveXNsbG1HbEVRWVZV?=
 =?utf-8?B?ZGc4L1c0cnFsR2I0R0xJcXFxRkEzcEVEVUJJc2JBZUNjOHpRZnIxeGtsQy96?=
 =?utf-8?B?V3JXbFhoUjRyU1lvREtZZDFVSEs4RFhGcTlSYWFaaHJpUmNBQzdRYlpCVW5V?=
 =?utf-8?B?YlhzUTZ0Vk14dTNURlVjZkZ2cUM1K3cyTVRaOGRHQTFxY0c4R1NNcEpKb3RE?=
 =?utf-8?B?c0lyNVdOYjBTdGwrQnhGY3BoQ0lEUkdiUmtlU0MyRGNwZDBEUElBM002N05T?=
 =?utf-8?B?aFNZdEtydUNWQmYwZGN2SDdHR0V1WHNYL21laDFqRzFUZTB6N3hac3pnaUZ1?=
 =?utf-8?B?eStYdUlBempkVHhJZkpYL28xU0p4VVM2dHQ3cmt5cXRlR0QwcytFa3pKSHBB?=
 =?utf-8?B?QWtPVDU0elVaa0lJL0RUM1kraXZmK20xRFV6eWVEeTV2SjM2Rk9SSWFaWVA0?=
 =?utf-8?B?QlJCOW5DY2J6b2VnbFUrM1FZTExZUGE5Z1lTbCtMWFNZdk9PaWljRWh3ek9I?=
 =?utf-8?B?djB6WHRCMUpUK1pJaDRzRUo5V1JiN1hqYnpGM0xvZ0FZVE02WTh0dStQdWNF?=
 =?utf-8?B?elIrQkNsQzZRUzY1bnNlT01CUlNuTDZHSGxlSTQ2T0VHTjBaSjRnanovZzhH?=
 =?utf-8?B?aEFCRHF6azlUMXdMMlJYUmN3ZHRuSFhYWEFadDFidXJ3ZVhhdEtqTEtWZXRJ?=
 =?utf-8?B?MWUvNDNMQVNXaFlsL2dPRXRtR0xXQkladUNnd2dFRksxdGo2SlU5Q2JqbHZI?=
 =?utf-8?B?NHJNM2lsZlJMSWl3Q1B4YjJsTzNsczRQb1gvM0IwRHlvMTlUWngzOXdaUXBr?=
 =?utf-8?B?TEVucitRZWRYaHJaTnFONkpVWHdRRkkyNGE5ZUxzWlNYL3RwM3MwcnZHbUZM?=
 =?utf-8?B?QkVBd2o3VmhNSjc2eEc2QjQyWk5UNmM5bnlENUNwSDJYWTBId2twZXVla3VD?=
 =?utf-8?B?NVlBRjRiTXNKa0R5MGVMWlYyS253T1JPY25YV1NkV0VNb3NVem5kSFV2b2Jq?=
 =?utf-8?B?VytQL09ETCt6azdjNm1KS2c4UGI5Y1MwZnpGOCszL1ZRVnNKZmhhTHZYOEFm?=
 =?utf-8?B?SlE5Vzg5UlZFV2xabWtaVGpYQWlEQXNUVDRlS3NveDlpTkdub0dtejFUbDRG?=
 =?utf-8?B?UUFoOFp6QlRtR2tPcUNvUkpJdmZmc0pUajJRMytoMFNXbGRHcnZ1NUNSVytw?=
 =?utf-8?B?ZWFkS1h3UFNucHM1SkN5STdSRnEwYVhrSkZBWVRMZTViZEllV1FISTBuK205?=
 =?utf-8?B?L2VJOHZRYXNaYXkzZ1dBSEtVOFhhZjUzeE1CeUVFWTcxU0VXRDZWZUJ2b1ZK?=
 =?utf-8?Q?qi4Nc1pO/G3YnndyyexLdjg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?bUphaC9TS0RRellUNnEwOGxJMHI3clFKVDQ1SGdQZUVzNzF5VTh5OHlseDJv?=
 =?utf-8?B?aFRFam1wbjJaZ2ZRUlJFby9hV3J5dm5jc3dZR2hQdmhpZDlHMmNCSUp1aS8r?=
 =?utf-8?B?NUVLNHNVaVpHR1VYTFlnWEtVdWhZUXFMR0dGWU9WT3FXRmg0eHRNcVNKT25E?=
 =?utf-8?B?NUdSelhSZEw4NDlzeFhxakF0UmtQU3JPUDNqOEtLK2NSeitVaFRJc0d5RW1s?=
 =?utf-8?B?ZEZ6Tm1wQk51K3FpSmNvdktMd0x2QmFwVzZQNWZLZ0JqNTlmWDgxOTM1azRh?=
 =?utf-8?B?c05VTk8vN0hBaUVoOTRBVlFJVHZqeDh1Z0xFS3l3N2RVVXNFd3A2NEQwblRa?=
 =?utf-8?B?ZUlCTHFoY1NnRjhNSzhxZFdCd1g5QXFGeGxyRjJrSEc4L2NtNXRudk1heVpQ?=
 =?utf-8?B?R2NCVExuRHRwL0wwa0ZmRmd1THFEQ3BoT1NCZUlzNFNvdTVKbHRsZ01sSHNp?=
 =?utf-8?B?enlmeEdaaU1qOHhsNWFlVnNib1JLRWdiVTlDVE54OUsvaFNTeCt6UVl6OUht?=
 =?utf-8?B?cGFVdndiUUdMYnNwbVZsR2ZZRzNYc01nOUUvQ0xEa2JQZnFYOEFkWFpNS1hn?=
 =?utf-8?B?aTNmUU01TmF2cm5kaE5hWHdWMnNXVEp0NnhXOGV3SUkxOVpuS25vSmNxZzBs?=
 =?utf-8?B?clVLc2dqYWFtbmNRNG9kYTFsb1NQNkw3NDFicW5GQVFYQTd4eUgrK2FvbXI1?=
 =?utf-8?B?aHJKcjR2R2lLN0pEM21uaVZHZzMrQlJQdHhicmt2eFBqeXNMcXFCb2NjU3FZ?=
 =?utf-8?B?aEV1SmxsWFVvS1ltMlRTYm1LRTZlbmo2NHRhdXlNMnNXNDM5NWRka3NpbFda?=
 =?utf-8?B?Q1pUNzRJcVVHZW80S2l0aVFnL1lpZ25ZcXhnTVlwbUdCeHBzeFpMd2hodWpK?=
 =?utf-8?B?K3BVamJqYVdsQ25FNjVKQVBSL3NhYkd1Y205Vjh0M25hNERlN0lBcTR2bHUw?=
 =?utf-8?B?TjVmQU9vU040VlptNlBFQ1BOMFR3Rmo0RU9lKys1anpxbEZuMDV3UVJQKzk4?=
 =?utf-8?B?aFJrUWRVa1NJVWVyMlljVXdYMERFMTNMcHF1cWI1UHhybWQyK0hVZmhsVnpW?=
 =?utf-8?B?WVNEem04V3JXUTdhRGNLbDJJVHRUTXM2K1U5K0VnODlIVTVWQXE4dVR3NDF6?=
 =?utf-8?B?SjJ0TFdKNDhzVDRNRFZLT2dRQTMwdTNaS3pIeFJmcC9scTZnYW5OWWNQaSts?=
 =?utf-8?B?Y01IalZCRE9pZzdlSXNwRnFZZnlua09VS0ExbGtlSTd1VkJVZS91VkdFbEVo?=
 =?utf-8?Q?tZEPhm0GTC5LjCn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6673d8-3308-4464-b258-08db57a333df
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 13:24:26.6725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmWZIPRlw9QU9fIUlaE1t3dykW00QYtNtbrQAvy5NJ8NCU9+XuEDs3T2NtyH2roM2yr1my1z9QtxLj7barDI3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7308
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_10,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=702 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180106
X-Proofpoint-ORIG-GUID: -ACGSxuFBe7X68K_trtcrv1sIksU0kcF
X-Proofpoint-GUID: -ACGSxuFBe7X68K_trtcrv1sIksU0kcF
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 18/05/2023 09:39, Jiri Olsa wrote:
> On Wed, May 17, 2023 at 05:16:47PM +0100, Alan Maguire wrote:
>> By making sorting function for our ELF function list match on
>> both name and function, we ensure that the set of ELF functions
>> includes multiple copies for functions which have multiple instances
>> across CUs.  For example, cpumask_weight has 22 instances in
>> System.map/kallsyms:
>>
>> ffffffff8103b530 t cpumask_weight
>> ffffffff8103e300 t cpumask_weight
>> ffffffff81040d30 t cpumask_weight
>> ffffffff8104fa00 t cpumask_weight
>> ffffffff81064300 t cpumask_weight
>> ffffffff81082ba0 t cpumask_weight
>> ffffffff81084f50 t cpumask_weight
>> ffffffff810a4ad0 t cpumask_weight
>> ffffffff810bb740 t cpumask_weight
>> ffffffff8110a6c0 t cpumask_weight
>> ffffffff81118ab0 t cpumask_weight
>> ffffffff81129b50 t cpumask_weight
>> ffffffff81137dc0 t cpumask_weight
>> ffffffff811aead0 t cpumask_weight
>> ffffffff811d6800 t cpumask_weight
>> ffffffff811e1370 t cpumask_weight
>> ffffffff812fae80 t cpumask_weight
>> ffffffff81375c50 t cpumask_weight
>> ffffffff81634b60 t cpumask_weight
>> ffffffff817ba540 t cpumask_weight
>> ffffffff819abf30 t cpumask_weight
>> ffffffff81a7cb60 t cpumask_weight
>>
>> With ELF representations for each address, and DWARF info about
>> addresses (low_pc) we can match DWARF with ELF accurately.
>> The result for the BTF representation is that we end up with
>> a single de-duped function:
>>
>> [9287] FUNC 'cpumask_weight' type_id=9286 linkage=static
>>
>> ...and 22 DECL_TAGs for each address that point at it:
>>
>> 9288] DECL_TAG 'address=0xffffffff8103b530' type_id=9287 component_idx=-1
>> [9623] DECL_TAG 'address=0xffffffff8103e300' type_id=9287 component_idx=-1
>> [9829] DECL_TAG 'address=0xffffffff81040d30' type_id=9287 component_idx=-1
>> [11609] DECL_TAG 'address=0xffffffff8104fa00' type_id=9287 component_idx=-1
>> [13299] DECL_TAG 'address=0xffffffff81064300' type_id=9287 component_idx=-1
>> [15704] DECL_TAG 'address=0xffffffff81082ba0' type_id=9287 component_idx=-1
>> [15731] DECL_TAG 'address=0xffffffff81084f50' type_id=9287 component_idx=-1
>> [18582] DECL_TAG 'address=0xffffffff810a4ad0' type_id=9287 component_idx=-1
>> [20234] DECL_TAG 'address=0xffffffff810bb740' type_id=9287 component_idx=-1
>> [25384] DECL_TAG 'address=0xffffffff8110a6c0' type_id=9287 component_idx=-1
>> [25798] DECL_TAG 'address=0xffffffff81118ab0' type_id=9287 component_idx=-1
>> [26285] DECL_TAG 'address=0xffffffff81129b50' type_id=9287 component_idx=-1
>> [27040] DECL_TAG 'address=0xffffffff81137dc0' type_id=9287 component_idx=-1
>> [32900] DECL_TAG 'address=0xffffffff811aead0' type_id=9287 component_idx=-1
>> [35059] DECL_TAG 'address=0xffffffff811d6800' type_id=9287 component_idx=-1
>> [35353] DECL_TAG 'address=0xffffffff811e1370' type_id=9287 component_idx=-1
>> [48934] DECL_TAG 'address=0xffffffff812fae80' type_id=9287 component_idx=-1
>> [54476] DECL_TAG 'address=0xffffffff81375c50' type_id=9287 component_idx=-1
>> [87772] DECL_TAG 'address=0xffffffff81634b60' type_id=9287 component_idx=-1
>> [108841] DECL_TAG 'address=0xffffffff817ba540' type_id=9287 component_idx=-1
>> [132557] DECL_TAG 'address=0xffffffff819abf30' type_id=9287 component_idx=-1
>> [143689] DECL_TAG 'address=0xffffffff81a7cb60' type_id=9287 component_idx=-1
> 
> right, Yonghong pointed this out in:
>   https://lore.kernel.org/bpf/49e4fee2-8be0-325f-3372-c79d96b686e9@meta.com/
> 
> it's problem, because we pass btf id as attach id during bpf program load,
> and kernel does not have a way to figure out which address from the associated
> DECL_TAGs to use
> 
> if we could change dedup algo to take the function address into account and
> make it not de-duplicate equal functions with different addresses, then we
> could:
> 
>   - find btf id that properly and uniquely identifies the function we
>     want to trace
> 

So maybe a more natural approach would be to extend BTF_KIND_FUNC
(I think Alexei suggested something this earlier but I could be
misremembering) as follows:


2.2.12 BTF_KIND_FUNC
~~~~~~~~~~~~~~~~~~~~

``struct btf_type`` encoding requirement:
  * ``name_off``: offset to a valid C identifier
-  * ``info.kind_flag``: 0
+  * ``info.kind_flag``: 0 or 1 if additional ``struct btf_func`` follows
  * ``info.kind``: BTF_KIND_FUNC
  * ``info.vlen``: linkage information (BTF_FUNC_STATIC, BTF_FUNC_GLOBAL
                   or BTF_FUNC_EXTERN)
  * ``type``: a BTF_KIND_FUNC_PROTO type

- No additional type data follow ``btf_type``.
+ If ``info.kind_flag`` is specified, a ``struct btf_func`` follows.::
+
+	struct btf_func {
+		__u64 addr;
+	};
+ Otherwise no additional type data follows ``btf_type``.


With the above, dedup could be made to fail when functions have non-
identical associated addresses. Judging by the number of DECL_TAGs in
the RFC, we'd end up with ~1000 extra BTF_KIND_FUNCs, and the extra
space for struct btf_funcs would require roughly 400k. We'd still get
dedup of FUNC_PROTOs, so I suspect the extra size would be < 1MB.



>   - store the vmlinux base address and treat stored function addresses as
>     offsets, so the verifier can get proper address even if the kernel
>     is relocated
>

yep; when we read kernel/module BTF in we could hopefully carry out
this recalculation and update the vmlinux/module BTF addresses
accordingly.

Thanks!

Alan

