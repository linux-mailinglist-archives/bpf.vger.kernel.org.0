Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EFC244C4A
	for <lists+bpf@lfdr.de>; Fri, 14 Aug 2020 17:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgHNPpF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Aug 2020 11:45:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45348 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbgHNPpC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 14 Aug 2020 11:45:02 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07EFdOQb005308;
        Fri, 14 Aug 2020 08:44:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=agtIDy6hUKFfFCCo8uCxcHlAE4vnSEKuqTkQkzQiuws=;
 b=jydmcE1Dx0kyoWtjX8B8XoQzyuHq0VcX9hBPur+g7UI/gOFvOegKmQAwHSQ7WODNzA3K
 owp+roex35CNUBKjkUAITe7qsnOXfivJMV/p8Q7UjjdY7apNOhm4UiqBuLYdgT4Wq3yu
 6UO7hqtb49olaUpoWPe1+Fq3AvdJcAB5xJk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32v0kg7wue-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 14 Aug 2020 08:44:09 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 14 Aug 2020 08:43:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGDCaweP4tuNyqpNIh7bgd884zwJH/Wi/4eqV+XfYfdAVUfDmRkT94dlTHkn8To3P9d+bUJWJ3R8SsQhMC9xT9q3XBn7t6xVwz4SMyfa8mjmP9xkxVO/9Yg5AWtvREmHKFLk7U90E/O465RS78BrHnKLcs4RsT9Wig8fX5CEfrBYe4xmMKCclshCRx64aBpm6LJS8TkiTNHIfc5zFh56KrT1i5NJOy6/hbjIOLDJh4M5I52ye08G/WXOaLwvIwHeu93j/OpBRuoPKLIbDQmCdvmrsDJnT8TPqmujC89lW3xzau8/OcLCm0/7ikEQZeVJ7K/+uDKPCO8KYWiEahKA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agtIDy6hUKFfFCCo8uCxcHlAE4vnSEKuqTkQkzQiuws=;
 b=HnYiomERHGq/3VUrY4D3ViQ7G82zKamVcNvPXhLVMMy1xUytHWcHs74rXDdfvKXwtxP4g9TUniJMTmlSmS7PPH3B96D/oXSWBADlbvbxTknz2qe78+cfbxgl1eykg13eejFFiGck8nKXxIqwSvOqDnIabRkABMazNk8QwWsb8oK9qfKPbTCvyKT4NGiHRbrfX1Sj5rGYvP4qBY96D7JLr3DsxEAuvkSZvaWHhF5Wk0AUkU+MIXabSxmR6OOlGWLXVmbqLPiS/f+ASsl6zYjrPHowJ6YRXORgTSEDATM/SGYvVjiwtqLquctc7YNRhAls3xqsdUOmE+uGFVbLkxapeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agtIDy6hUKFfFCCo8uCxcHlAE4vnSEKuqTkQkzQiuws=;
 b=ZOqcMGpSoDaj2FJTtHAbMbC+uzwGUd184hMFZXqzoQg5bOREZb2fg89txCgXBNy0QdJGl2RCxLj1vBiEnf+pdiF8tZSu8GqbMNrCD8zijxF70HdxP9tlMq5dVlZ/hfTpMPnSCvEEC6ISOvyN8NJ8m76trWSo1BTC9ia9xjgjKco=
Authentication-Results: lists.debian.org; dkim=none (message not signed)
 header.d=none;lists.debian.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3512.namprd15.prod.outlook.com (2603:10b6:a03:10a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Fri, 14 Aug
 2020 15:43:55 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3283.020; Fri, 14 Aug 2020
 15:43:55 +0000
Subject: Re: [PATCH] bpftool: Fix version string in recursive builds
To:     Ben Hutchings <benh@debian.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     <bpf@vger.kernel.org>, <debian-kernel@lists.debian.org>
References: <20200813235837.GA497088@decadent.org.uk>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <1c00ee1f-5103-e8ec-7953-e09a1c0de707@fb.com>
Date:   Fri, 14 Aug 2020 08:43:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
In-Reply-To: <20200813235837.GA497088@decadent.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::33) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::117a] (2620:10d:c090:400::5:238a) by BY5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:1e0::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18 via Frontend Transport; Fri, 14 Aug 2020 15:43:55 +0000
X-Originating-IP: [2620:10d:c090:400::5:238a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bbc9734-21e2-4245-012b-08d84068da50
X-MS-TrafficTypeDiagnostic: BYAPR15MB3512:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3512741A358E56924FC3FF84D3400@BYAPR15MB3512.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gxnw/vrM+XrEBkz6l5eEnFb+yjD7UhasFD5XHyksOE8KeN4cM9qLCufr8teHxAF0tBeNU+k2+ZP/j8b9Ttg28B4ONR5aFjlNWE/v0Pl4KkybtbFpHzpTpppABYg4V0A+Q00SPYzkTV5sSj2lwXkDQeLf7k+XU0Fias57WdmxBXYKzZXgDylSghpv8P3VfgxQRz2jM9w3oIsXCXAjN7v/QVLJfne2XVZvR7C+fhJTR8EeQkpRHQUIK43jjF31a+H2BnFhmKiNVzg1Tt8gsI8Zo8DFuVdhqfy9oJHMS9DYWK0fuvs+xOjMpcJlV8+ZY01uE8cs86WlpVGaw+FlAn5l/oJqOXBUOUDRNGZGzmTFOllSuPk1l/wx8344TbSt+W+I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(346002)(39860400002)(376002)(316002)(8936002)(16526019)(186003)(110136005)(5660300002)(8676002)(31696002)(83380400001)(66946007)(53546011)(2616005)(52116002)(66556008)(86362001)(478600001)(2906002)(6486002)(4326008)(31686004)(36756003)(66476007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: UkCNbPTR8Dm1Gi+UtNYdZg9ix3T+5/zvaIL2O/6t0dfMKw1kDj43UrwJKvniBJ4dFQaXSJ5PrpF6vFsLH2PyQZCL6k5s7LiZe7JWYmlUshg3j9h4CMcDwBMcaFOt9ipG4Zgg9v5HXxLefhJQC9huceTylSQhNM/pZfMuCtxy4EUr5+3qEo6g895E6oF1/MpUZRWac9xlIEClTzTUVISzwcqfgi5cVTrFCAc6I+kJFwCH0C7PzoRACfGm452Fpg8VA2QJEAnewqVG92jLuLDdugRq4RBWWSSpuEUV0Qu1mU9P2UfWqj3H4UbHX341JXom6DIu4nSwxw31Vo1E/+PK313T1ybpcgkUYRfUJmwjVWokBMsy8+s90dASQJTctCYGb493ZApz0hhZOoKylFEWq1oN97Y6ryMHMRaTj9k8replevKQt7KjxXn7SK5qGRvAB60PsB0MSPH9t2HeK8D8FQWWJnuPuzzMTDiuwUC+zt2nuYYYaVN+3Yy5ACpjFBl0R733KCSO60aWDsK+AyKEUUQ/uyc71ap3ihQWLSyOkyKI+G89mPfGhBDP0+0/K9WrnwDKBFqEcL71OLTyRqM5CIuLOg0Jl3XjH+KYCE6n8Da5kT31oNVlKinr1AlM64ViwJBkNN/W4KnRNvEhK7nwE99dVQqn7l0/U/kPrFtneBg=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbc9734-21e2-4245-012b-08d84068da50
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 15:43:55.7467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dq4/6zxJEIP7akaIIemE8HSiwv1tc0N6Ryvgf4y6/r/PszJbumowzihBTD2+Rc/b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3512
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-14_10:2020-08-14,2020-08-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008140117
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/13/20 4:58 PM, Ben Hutchings wrote:
> When bpftool is built as part of a Debian package build, which itself
> uses make, "bpftool version" shows:
> 
>      bpftool vmake[4]: Entering directory /build/linux-5.8/tools/bpf/bpftool 5.8.8.0 make[4]: Leaving directory /build/linux-5.8
> 
> Although we pass the "--no-print-directory" option, this is overridden
> by the environment variable "MAKEFLAGS=w".  Clear MAKEFLAGS for the
> "make kernelversion" command.
> 
> I have no explanation for the doubled ".8" in the version string, but
> this seems to fix that as well.
> 
> Signed-off-by: Ben Hutchings <benh@debian.org>
> ---
>   tools/bpf/bpftool/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 9e85f101be85..7fbad8cbd171 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -25,7 +25,7 @@ endif
>   
>   LIBBPF = $(LIBBPF_PATH)libbpf.a
>   
> -BPFTOOL_VERSION := $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
> +BPFTOOL_VERSION := $(shell MAKEFLAGS= make -rR --no-print-directory -sC ../../.. kernelversion)

I tried the following

--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -25,7 +25,7 @@ endif

  LIBBPF = $(LIBBPF_PATH)libbpf.a

-BPFTOOL_VERSION := $(shell make -rR --no-print-directory -sC ../../.. 
kernelversion)
+BPFTOOL_VERSION := $(shell MAKEFLAGS=w make -rR --no-print-directory 
-sC ../../.. kernelversion)

-bash-4.4$ ./bpftool version
./bpftool v5.8.0

I set env variable MAKEFLAGS=w, and build bpftool it works fine too.
Maybe I miss something or debian changed top level Makefile?

I am testing against latest bpf tree.

>   
>   $(LIBBPF): FORCE
>   	$(if $(LIBBPF_OUTPUT),@mkdir -p $(LIBBPF_OUTPUT))
> 
