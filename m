Return-Path: <bpf+bounces-7490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D76B77810D
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 21:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA4E1C20C38
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 19:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A7B22F0D;
	Thu, 10 Aug 2023 19:11:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC5E20FB4
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 19:11:26 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D591B90
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 12:11:25 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AIcrD5018875;
	Thu, 10 Aug 2023 19:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=9OobCuFrlOXGALf9LYMTHAz8u1aUGEtqtHfc+vySqx8=;
 b=gbs6xfcoVWr0j5Psi+FCjMT3OZNVwK19JVJfdXvUdbChKqcurvinp9rG6uG0TwUXlhEm
 9eUr2gyyahD9VoQk7k/uKsTnfE425bpIJB/0HpH9Gq9JkA8lPCEkqJyYMvpucj8YKN7Y
 Puif28jHeOFAKsWYXQV6XnPUVaMTQzWYZ6JwwbtHVdu9yZQ3/col+9mJ07/jOAjeTnJE
 ahIUO9+2BWx/O3zYp+1jOxJhsjxwr5IkC9jKL2DHGrWBVIG++RkuzD7g7eqA9rMas2qT
 Yb9kqW76m/9KfsCywF1qokVOVfJj8BSWyFSgk8TUXiHz/98Rfl4M0vmqtUkgHNiVcez6 SQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9eyukyc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Aug 2023 19:11:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37AHqEkZ008813;
	Thu, 10 Aug 2023 19:11:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv8wn4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Aug 2023 19:11:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GalotbLq3JPrMXPWJf41xLKVkf760Z2MuyAv5a3TKACNzzO6bJTBq+arYjA4vriIEPyDyo62XcNqEiXx51mpZv2dMf+LCFWIvADNO7rreawvsh9hhgUlI8yDaDb46kYhvlnLFyJALZSxz2mY6buyB4xGH9HaSC9+IZld8dhaEy59xj3b1WFxnGgIW+qGJH/uKgaVyuaEovsGPzNu6tUMpFSqv3mb2kBP+MkFJwtcdD9mcLiw13UVfo09O6YRfOd31mTjkOEQuNAsDDbFCf5WHT5bcMAFnpOHdNU7Y2FRdZdVpo7FjDmbZ8NJgWi7DYqCaMdoZ9YpuHSybx/SI94p+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OobCuFrlOXGALf9LYMTHAz8u1aUGEtqtHfc+vySqx8=;
 b=CmLLkfhHIZ3PBb447lt8DbMrXeYOcB3gYzA8ELm8A+ZChc2lx/4js+/U5FnYiA1ntGvMKMAkJzlbKgDa/MYpTKsbKNNK3EfUXjxmcDISY6G1SG050BfomP8NH1QcP5cMtqAYhEcOQVy6fnSvhH9EABHETj37/AZCqye7sA9BWlTWus9uKbuAN3H1W+oBaqNKCHz4+t8h/yrVh3Wq4lS0v6jsJJWbbzyLYxWmE1lT04+BPrBw6jZwlCIJ8/6Zw+wHb8bKa/+OJ0qSBi81Yp6SajtzMrnL9M9iChJrkd8I9+wezmT2laP1zMTakY5+swBYBFksseL/s6KvrjOyvqmAaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OobCuFrlOXGALf9LYMTHAz8u1aUGEtqtHfc+vySqx8=;
 b=We+QFQtajVGaRaLoITcMXVnspX381eD2dOWXAz677ZSfHdNtM/AKVD18DcuBNKIgSOY3MfEZfA35aGJKPSbKOnhkBLQykmXov3xYr65BqG95/5zHp47J6Buz2yk89s1nar/yP2E6uW5srJ+ejHngqTy0G+ZG5mkIrXx0C+Pdv94=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by BLAPR10MB5268.namprd10.prod.outlook.com (2603:10b6:208:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 19:11:08 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::991c:237e:165e:1af]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::991c:237e:165e:1af%3]) with mapi id 15.20.6652.028; Thu, 10 Aug 2023
 19:11:08 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: yonghong.song@linux.dev, bpf@vger.kernel.org,
        Nick Desaulniers
 <ndesaulniers@google.com>
Subject: Re: Usage of "p" constraint in BPF inline asm
In-Reply-To: <37b9680f074a871041c3dd61d22e6a6c9fd02fb0.camel@gmail.com>
	(Eduard Zingerman's message of "Thu, 10 Aug 2023 22:01:48 +0300")
References: <87edkbnq14.fsf@oracle.com>
	<a4c550e4-1d65-aace-d9ba-820b89390f54@linux.dev>
	<87a5uyiyp1.fsf@oracle.com>
	<223ef785-8f8a-14bf-58e4-f9ed02b21482@linux.dev>
	<37b9680f074a871041c3dd61d22e6a6c9fd02fb0.camel@gmail.com>
Date: Thu, 10 Aug 2023 21:10:55 +0200
Message-ID: <87v8dmhfwg.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::7) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|BLAPR10MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: 9401c520-e996-471a-f47f-08db99d58d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uEfVY258259MvYeOkd4yiWc0Pf88yhvGs7TdUkxnOpIMcyAWp9bVMRuqrvbYcM3lrsIkOk5qYokQX0f0YFoyMEcwtfJNa15Sas2Er1T6XCU0kuSSZZhiYXIhvjVz2fWZQqHyT6MugoYL7BVO5GuFhyPAwCvyIQ/LclKdPEEWpv+JeQWarxkg+n62YtbLRMkUNuoRnJIm+yEQNBShe1y1HXnF71NUKjNKA6OItOFvs/HrJCp6gpmBl8H7P2v+9ZgKW2WPgFMhurrJAJ61NZbgkOFB7Zk65B4z6P+dSVvW0KnYctXBVTo0+KhEwsk1PpZJsTaG+jNlNW+j85+MDGqXKXTfx8+TWnUHnoeVWFkwy1meX+bPxsX864vsNXo2/vVdoVJoZ6JnCbAxMZzaQgJCW6+d+24nGCm/QGOTUDLmfXTirnV0xR/z5bIIa8w+EXm2CGwbmrfYcvqaw/fxGkUPNl8bcBSW4gTSsomeeYOSM4gdQ/0hagXdsWrVxUCaQMU4/UWq4v6L7CYh1ThGQrRKd9e2R9xYyOmyCW+tXpEzvFG56IuyMAKGtICt2uIwr1S3
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(136003)(376002)(346002)(1800799006)(451199021)(186006)(5660300002)(316002)(38100700002)(8936002)(8676002)(41300700001)(6666004)(478600001)(6486002)(66476007)(66946007)(66556008)(4326008)(6916009)(2906002)(6512007)(86362001)(36756003)(6506007)(26005)(53546011)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QkVhZ2x4WitRbmRLcU9iL2dkS0VVcmJEbXZtMDRVSEg2VGp3TENmWStVb0dS?=
 =?utf-8?B?MHpjV2hiV0dUNlFXUHVDMVNTYkhBaVMyN055WW5ZaWUzSDlPTW9zTmNPSkhm?=
 =?utf-8?B?Qmh0eVhETFcydFI5bUpLUGJZeDl4R2tIa005ZzNHN0MxV2h1c3NtQzBLZlk3?=
 =?utf-8?B?VE40WVplWDY0aC9NcGFoOGdyRml2K05jc0I5dkVnd1FZZGRqNVAwWWFldHUw?=
 =?utf-8?B?b09jcGo1WnpRQnJ1NnNJRit4ZytMaDFtcENPSUhWcXFjYk1kS1NaR1RFNEth?=
 =?utf-8?B?WTNLNUx3enFPVmVVTWNLRGtCQlA4WVUwL21JTnJkaXJVUDBlUjVlUldzcHZ1?=
 =?utf-8?B?cmlTZFRjUTRObk5zV3ZqZ3RIMGN5bWd2NHB2eEZpSGFXZnBsaHFndjVoSXZC?=
 =?utf-8?B?QVFQVG4rc0l6dUErcHJsdXFkUWZ5eGxIKy9qbExOaS9Cd21BeWdLcWNlUkt5?=
 =?utf-8?B?azNoUFMvMnVGUjVoNjZ3RlZHQXVSR2RtQjVpTWRaSDI4R3hOOXRITmQ0eS9I?=
 =?utf-8?B?d3BqSlhkSjA1VDRiUzM3RlY3VXBEejBNT0tHK3gya2pEMnExNmEyMVdQRmha?=
 =?utf-8?B?a3dhRFB4V2dub2wxR2xXWHdoYWo3dGtMakNvS3NBb244S05CK1Q0eDhEbmdI?=
 =?utf-8?B?RVRpUjJKRnZoeElXNjIzUUlYbFFqNGN4czU0dGpsT1dCTFh4TnFGZnhUZWRz?=
 =?utf-8?B?dlZicGJnYzl1ZFBvenFNcit4UnF3N3JMSGlYQytmVzh2eDZZUzNtTjUrU0tG?=
 =?utf-8?B?aDhUL2ZNUkNRa1RjdWRxc3FWZGgzVm01T21rTUN3N0hsNit2RHBUbUdkTzBq?=
 =?utf-8?B?aXJNWXlSNnE3T2pVQm1xcGxod0FQbXdvWXZCUjlnZWx3bEpNNGdYM2txbC9Y?=
 =?utf-8?B?Zit6c0NQeGhTWkY4WVl5alF1N0lyV0pGWFc3RVpGeElMdFJORkFJMk9rR1Qy?=
 =?utf-8?B?RndPZFk4cGRjYkZ3Vml3SHMxOFBFSnIyNlJQeGxzd0tRTWZpTGVSaHpyaUYx?=
 =?utf-8?B?ajU0QVJWODA3d2RHZlFkU0lBSnlmSjU1NFhLR1FNTFRxdlBlbisza2Fja21p?=
 =?utf-8?B?eUFpMVdMbGVBSDE3L1BnY3dHTzhRWVdsQXlaUm96UW1PVm10MjNhVVlVL0F1?=
 =?utf-8?B?MFQwdjU4WVdTQ1pUOENkWWw1QmhIT290NEkyUkhVbDFCTUEraWl5N3prZUhl?=
 =?utf-8?B?ellFV0Y0V29nV1ZJZGFLSXBEeVpjenJ0Sy9wa1JONnBCUUFSMEhrL2wvYTRB?=
 =?utf-8?B?YldwNFAvOU1hbktBdFhhWlhCcjZBUUM1RkZ5Y3BwcmZ3RE1BZTAxZ0hVbWF0?=
 =?utf-8?B?R1dwWk54d2oyY1Q1VFh6VUxTb1pNSTVmTENtaXc3aUlpd2NWRWVXWDRGc2d0?=
 =?utf-8?B?MHJTRUYrSEppMGtjYnZRbG80aUJTcVZnVnJTQ0pjMXkzK2MvdTQ5S2hDeEZR?=
 =?utf-8?B?M1JndGhFNHVCcWVQbFZIeVVBRXpNRWc1YXF6NVJBSWZrTDlOSmhIa3RiWnRK?=
 =?utf-8?B?aDA4Z1NqSTVJWHloRWtKc0d4Q3AwR1F6RkdXeWluQzJCa3F1d1pXT0ZiWjVO?=
 =?utf-8?B?bEVINkovMmZhbFJQZkRqTDNsck5ESit0bzdORkNRR3k5UTl5ZWVkWnNxbFpn?=
 =?utf-8?B?dDFZVjhYWVUyNjk2d0FubEhya0FLbUVjaFpHV1BRZHhuaG9ZZ1NRRUNXeWQ2?=
 =?utf-8?B?L1NtU3MxRnRISHg0UUsrUzFFdnNiM2UvN3NGa3ZadkdZbEVuZSt3d2dHTFB4?=
 =?utf-8?B?QmtGbEc1Q2IzeG5Rd1A1OEdPeXNpemhkYkR1VHc5c0FHc1Uwc0NHd3p1cDBV?=
 =?utf-8?B?T3orQ1VoUURlYmt0S1VBN2J5RFdOblVnS2Z1dlZxN2dOam1VQ0hLaEI4Y1c0?=
 =?utf-8?B?M3Q5Z2JJMEhmcGxpUkIzaDhuQzYyVUxaampXRDE3bkdnajZ4ZUgrbkhTb0hT?=
 =?utf-8?B?T2pORjhCYjUrenFkREwxWjRWTmdnZTVtaGo1RGVzdHRhZWJUVzhiU2V6RWp6?=
 =?utf-8?B?MXpWQzU3NEEySTIzVDlOQU9zN0VwRnovNCthYWpYNVFiY2ZzU21GRVFDUjR0?=
 =?utf-8?B?WHVadUR2RGVkdnRkWHZjL3A3UW1UcmxkcWc1U0hmbExHdmZMQ1phR3g0MEhL?=
 =?utf-8?B?ait4OXVVN1JYczdaMGplNVBKYzJJb2RzeDRGYU1TeTh1Y2xFUGRyV2JaSHZK?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OPkM2oAfgLy+wv9KQjFxrDPQ/a8pBZbfJBsKBQy3Gn2bUbSbHZfMGWt8d6mxeX9wjORu3iBLUvtQUD786GoJiYREHt1OeZsnz8JjVj4l40BgeERgVV3pjoXPgYrzF+NFUM30O42Y7aFN12szpmu+ZNoJExxlyik0kIPwEjxhijXIFPc13fBgzH4ce5PBLG3JzlUIbZARVyZFJb7vPEYovxluN/i0bzeO7tEDJBlzCazOJPOJ8488ojrN5LKYnDDLq1fWo0FxWpujDVByz2LfUtlSUDGEsPRZ8dNpcBn7nAm3AxcauPzB8U0RROPPNA3zJFEcjpjLg6fG0AxfXaivZRIz0MHW7IUgJ03kAO5/MDP8LrFY6arOEJlxlpvAJOVA0VV9Jc8RqbpfNUYRjwLwCeb1iOjTzzzwrVZ/5tBr0bi6kqZXHMLbjPyYr0CJoKRii7TJkwD380t82+2QlIT4uzxQJshNRYa6kt9u2QC54l8RFWr46/C48NCMCiTzkyVm7TNj1UJ7BZ7fxWmywerpNwIyBL3ayt7pKqsTrtouPM8Vi7ZMvfmtoePhTl/1I2A+XLAKb15Mu93jWpzZ8d7pHK8QRAzmGGtSbBQjXoB+EdprYtQJ9q0Sskjvg8tBsD8gG1xbJpvxvNSicz5pa4xSM23RGWmaTTgeTR9X67EAXLdlVO90xlBiV/wtWpJlE5wmZjqv2rBHErsGeMpquL3wL5ZmXj8xGzYK35VIMiGmzZWO66avSvMMfZWIpu3AaN0VyK9JDkFvEcdQPf4wgT/wFbFR88GRua9k8C/V27DEXPYDNhn7GFolBDOJv6v+fuNpnwG38hQuM3RAz8fRNecpaw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9401c520-e996-471a-f47f-08db99d58d39
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 19:11:08.2729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boIepz3A2Y0uIgDHsoeDym+1i8omDl5y5DVXDeExn6+xP5q9X04IsKLYmP+y+y8pT5HwT3AG+qk/RpbtvlSwclyj7qT/ZK+ELcuNcU9axtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5268
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_15,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100165
X-Proofpoint-GUID: 42NI2x8RjjdVncOz6C4XV482lm351E4A
X-Proofpoint-ORIG-GUID: 42NI2x8RjjdVncOz6C4XV482lm351E4A
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On Thu, 2023-08-10 at 10:45 -0700, Yonghong Song wrote:
>>=20
>> On 8/10/23 10:39 AM, Jose E. Marchesi wrote:
>> >=20
>> > > On 8/10/23 3:35 AM, Jose E. Marchesi wrote:
>> > > > Hello.
>> > > > We found that some of the BPF selftests use the "p" constraint in
>> > > > inline
>> > > > assembly snippets, for input operands for MOV (rN =3D rM) instruct=
ions.
>> > > > This is mainly done via the __imm_ptr macro defined in
>> > > > tools/testing/selftests/bpf/progs/bpf_misc.h:
>> > > >     #define __imm_ptr(name) [name]"p"(&name)
>> > > > Example:
>> > > >     int consume_first_item_only(void *ctx)
>> > > >     {
>> > > >           struct bpf_iter_num iter;
>> > > >           asm volatile (
>> > > >                   /* create iterator */
>> > > >                   "r1 =3D %[iter];"
>> > > >                   [...]
>> > > >                   :
>> > > >                   : __imm_ptr(iter)
>> > > >                   : CLOBBERS);
>> > > >           [...]
>> > > >     }
>> > > > Little equivalent reproducer:
>> > > >     int bar ()
>> > > >     {
>> > > >       int jorl;
>> > > >       asm volatile ("r1 =3D %a[jorl]" : : [jorl]"p"(&jorl));
>> > > >       return jorl;
>> > > >     }
>> > > > The "p" constraint is a tricky one.  It is documented in the GCC
>> > > > manual
>> > > > section "Simple Constraints":
>> > > >     An operand that is a valid memory address is allowed.  This is
>> > > > for
>> > > >     ``load address'' and ``push address'' instructions.
>> > > >     p in the constraint must be accompanied by address_operand as =
the
>> > > >     predicate in the match_operand.  This predicate interprets the=
 mode
>> > > >     specified in the match_operand as the mode of the memory refer=
ence for
>> > > >     which the address would be valid.
>> > > > There are two problems:
>> > > > 1. It is questionable whether that constraint was ever intended to
>> > > > be
>> > > >      used in inline assembly templates, because its behavior reall=
y
>> > > >      depends on compiler internals.  A "memory address" is not the=
 same
>> > > >      than a "memory operand" or a "memory reference" (constraint "=
m"), and
>> > > >      in fact its usage in the template above results in an error i=
n both
>> > > >      x86_64-linux-gnu and bpf-unkonwn-none:
>> > > >        foo.c: In function =E2=80=98bar=E2=80=99:
>> > > >        foo.c:6:3: error: invalid 'asm': invalid expression as oper=
and
>> > > >           6 |   asm volatile ("r1 =3D %[jorl]" : : [jorl]"p"(&jorl=
));
>> > > >             |   ^~~
>> > > >      I would assume the same happens with aarch64, riscv, and
>> > > > most/all
>> > > >      other targets in GCC, that do not accept operands of the form=
 A + B
>> > > >      that are not wrapped either in a const or in a memory referen=
ce.
>> > > >      To avoid that error, the usage of the "p" constraint in inter=
nal
>> > > > GCC
>> > > >      instruction templates is supposed to be complemented by the '=
a'
>> > > >      modifier, like in:
>> > > >        asm volatile ("r1 =3D %a[jorl]" : : [jorl]"p"(&jorl));
>> > > >      Internally documented (in GCC's final.cc) as:
>> > > >        %aN means expect operand N to be a memory address
>> > > >           (not a memory reference!) and print a reference
>> > > >           to that address.
>> > > >      That works because when the modifier 'a' is found, GCC prints=
 an
>> > > >      "operand address", which is not the same than an "operand".
>> > > >      But...
>> > > > 2. Even if we used the internal 'a' modifier (we shouldn't) the 'r=
N
>> > > > =3D
>> > > >      rM' instruction really requires a register argument.  In case=
s
>> > > >      involving automatics, like in the examples above, we easily e=
nd with:
>> > > >        bar:
>> > > >           #APP
>> > > >               r1 =3D r10-4
>> > > >           #NO_APP
>> > > >      In other cases we could conceibly also end with a 64-bit labe=
l
>> > > > that
>> > > >      may overflow the 32-bit immediate operand of `rN =3D imm32'
>> > > >      instructions:
>> > > >           r1 =3D foo
>> > > >      All of which is clearly wrong.
>> > > > clang happens to do "the right thing" in the current usage of
>> > > > __imm_ptr
>> > > > in the BPF tests, because even with -O2 it seems to "reload" the
>> > > > fp-relative address of the automatic to a register like in:
>> > > >     bar:
>> > > > 	r1 =3D r10
>> > > > 	r1 +=3D -4
>> > > > 	#APP
>> > > > 	r1 =3D r1
>> > > > 	#NO_APP
>> > >=20
>> > > Unfortunately, the modifier 'a' won't work for clang.
>> > >=20
>> > > $ cat t.c  int bar ()  {     int jorl;     asm volatile ("r1 =3D
>> > > %a[jorl]" : : [jorl]"p"(&jorl));     return jorl;  }  $ gcc -O2 -g -=
S
>> > > t.c  $ clang --target=3Dbpf -O2 -g -S t.c  clang:
>> > > ../lib/Target/BPF/BPFAsmPrinter.cpp:126: virtual bool
>> > > {anonymous}::BPFAsmPrinter::PrintAsmMemoryOperand(const
>> > > llvm::MachineInstr*, unsigned int, const char*, llvm::raw_ostream&):
>> > > Assertion `Offs
>> > > etMO.isImm() && "Unexpected offset for inline asm memory operand."' =
failed.
>> > > ...
>> > >=20
>> > > I guess BPF backend can try to add support for this 'a' modifier
>> > > if necessary.
>> >=20
>> > I wouldn't advise that: it is an internal GCC detail that just happens
>> > to work in inline asm.  Also, even if you did that constraint may resu=
lt
>> > in operands that are not single registers.  It would be better to use
>> > "r" constraint instead.
>>=20
>> Sounds good. We also do not want to add support for this 'a' thing
>> if there are alternatives.
>>=20
>> >=20
>> > >=20
>> > > > Which is what GCC would generate with -O0.  Whether this is by cha=
nce or
>> > > > by design (Nick, do you know?) I don't think the compiler should b=
e
>> > > > expected to do that reload driven by the "p" constraint.
>> > > > I would suggest to change that macro (and similar out of macro
>> > > > usages of
>> > > > the "p" constraint in selftests/bpf/progs/iters.c) to use the "r"
>> > > > constraint instead.  If a register is what is required, we should =
let
>> > > > the compiler know.
>> > >=20
>> > > Could you specify what is the syntax ("r" constraint) which will wor=
k
>> > > for both clang and gcc?
>> >=20
>> > Instead of:
>> >=20
>> >     #define __imm_ptr(name) [name]"p"(&name)
>> >=20
>> > Use this:
>> >=20
>> >     #define __imm_ptr(name) [name]"r"(&name)
>> >=20
>> > That assures that the operand (the pointer value) will be available in
>> > the form of a single register.
>>=20
>> Okay, this seems work for both gcc and clang.
>> Eduard, what do you think about the above suggested change?
>
> BPF selftests are passing with this change.
> The macro in question is used in 3 files:
> - verifier_subprog_precision.c
> - iters_state_safety.c
> - iters_looping.c
>
> I don't see any difference in the generated object files
> (at-least for cpuv4).
>
> So, I guess we should be fine.

Note the same fix would be needed in the inline asm in
selftests/bpf/progs/iters.c:iter_err_unsafe_asm_loop.

>
>>=20
>> >=20
>> > >=20
>> > > > Thoughts?
>> > > > PS: I am aware that the x86 port of the kernel uses the "p"
>> > > > constraint
>> > > >       in the percpu macros (arch/x86/include/asm/percpu.h) but tha=
t usage
>> > > >       is in a different context (I would assume it is used in x86
>> > > >       instructions that get constant addresses or global addresses=
 loaded
>> > > >       in registers and not automatics) where it seems to work well=
.
>> > > >=20
>>=20

