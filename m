Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEF6666F85
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 11:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjALK0b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 05:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjALKZv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 05:25:51 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C612E7F;
        Thu, 12 Jan 2023 02:20:56 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C9wlpE007835;
        Thu, 12 Jan 2023 10:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=eh3mq93AtXgPe/EmkZ2p9gcT4rFQEWlM5DDcjcJImZo=;
 b=1qcf7EeCy4nSlXqv33AR1rJOKomfiMIBCopMOMC/GKtGYprwWF4I1wV9T1XFvLYEt3aD
 QH8nDETlSysyc8wROOJa/HwlESuNl7kUcDUaqh6EA6plza7qlYr4/Blct9qbxEQmSR+n
 hfaniYrod5BEzju7aGTgIEAsyfhxM6BYrxsSs3jahSQXfbDhaUbOzExLRAXK+tWMGl9f
 pDYg2Ue94h9dI35YxDsykiK9VKIFx2NJtKkwu3fLu8eHPkGg5watw47hjekJwjSzJBEK
 vIdcW0kKyRAUX9UmPcrC660F+BRXoS+oKVBuxPAqSbsgGo4L0UaqMx1+w3hL2zeNQS7i CQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1y1nj4wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 10:20:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30C9OeJ6005167;
        Thu, 12 Jan 2023 10:20:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4ayy8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 10:20:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGzB1cqz2E9+S8x5GRUFOiicH6W9oMSoY56xI2mdTcYvABTNtVC+0Y7fBqh1oR3QXNBiKTGSjn1OEUkWLn4iJv1/K2EDn+d3HvaYjOpSwbfnaSgPNHzjDa8bi44pM+GyWlKZrAuB7Pvolfem8kz1OCRBlT2pPKxgBHh79OI1G+PezkrK98WNVisln6cdrbrx34cqbbilXhbCwL+a0emOl13Omraaa9zicXkQGOsd8i/8X0w7K/9fqaCevFPFcTNAggub0l9w+CMXjOlwRMQUKx4t3PL9CzL9s4Wgvpqcu7aiI/i0gZ0757AK0Fwmgp4ppxqk98wsbQIwM+dYyj4pbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eh3mq93AtXgPe/EmkZ2p9gcT4rFQEWlM5DDcjcJImZo=;
 b=So166hVf2943Qsszjq0//xnaUv9dWajLvcSG1yrQCBOzdrn3EuIT0GdhucKvZo61nA7aXAP8Cq388nych7P0TVa51FMeN8tp5MQ7VsFWlrpdtycZeGmRPs5NlHskLbpljIub1Cr5hXyLZVXWbZTFE8A9aCiiQs7kAlMqzl+ZUE8GEAOlcs3h0nBccqTqHrVC/XtIQ+/FaxUjxfo/e7gebgwsKBV23Dnx+jgVZxubp7KlRHidgwVq99dBpLwWoI1GYoWRMz6WCucHSKjnj+k1UoSp1qn4zAMvFJF4o2eANFodMJZ6XYreBN/eaCSuT2f700hLeqmSJCQBvgmDHBVjdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eh3mq93AtXgPe/EmkZ2p9gcT4rFQEWlM5DDcjcJImZo=;
 b=qIB638tpu2GUCLF1DLpd3zx8sRmjfuTWn4QkgNDxooGaHsjeWw576brNPWeaYDhXzegnCjrJIrSbffYctfs6DVMRJl0UTCKS8VTwb6JNaBNe2ndI+tW422nO9AfHSxZOkzOdFrKVx+1GBFaSW7rVV3FZo7eNwSGj5/oZYmyoRRQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM4PR10MB6741.namprd10.prod.outlook.com (2603:10b6:8:10f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Thu, 12 Jan
 2023 10:19:59 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%6]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 10:19:58 +0000
Subject: Re: [PATCH] libbpf: resolve kernel function name optimization for
 kprobe
To:     Yonghong Song <yhs@meta.com>,
        Menglong Dong <menglong8.dong@gmail.com>
Cc:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
References: <20230109094247.1464856-1-imagedong@tencent.com>
 <504cc35a-74a8-751a-5899-186d7a0aff87@meta.com>
 <CADxym3bRciuyM1nYCrbaAwSMRJQvgV=hJFSLeiu9jysejPaTQQ@mail.gmail.com>
 <6c14e7ad-3b6d-4f88-64b8-8e3968d2b2e6@meta.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <6455133c-87a2-1a0f-7da4-f8b99f02fc95@oracle.com>
Date:   Thu, 12 Jan 2023 10:19:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <6c14e7ad-3b6d-4f88-64b8-8e3968d2b2e6@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0080.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::9) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM4PR10MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f99574c-bcc5-476b-437d-08daf4868eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +hJBlclj+HmDzkv2a4Co6/n2qcfWQAUJNShxDqDZjjZFTapWHQUrm7dSMYL5XHpvxPX3T7QQgXlVLYE35xeME7RXnnVG09p/3pETafx2rUY54gDn+gXuMot/amP/7cPv8gskqirqGp6786QRp3wAyiq+Ce+om2CYITvts9l4sTdEXlPAjM0x4qia5LuX/Op3yWkZaqpwHKf4v5kTAWW7culCOgGwAi73m71IwN8Ex55b7VQdRGQO4uxwbn1OoEkxEUvG4hDaJtdOWJx1T3z1A8iuih4i7EbdOG3SC62I0x6EqugXME0WZVdDaJc4MLv0QHtFGK8ptfwSzP8NYngL3fJ43APWTDVNDwq243iN/cnswsVXbT6nf4ku68GZLi06qAzZgxGIuIOAZy7VJF8mhTAjoTGX9PU1w88E9nEwocdhZQHEbEljZU2w8N5RJj88FF8347CneaToEbapZ0j9IDqvGeW48vxJQ0A+SUa1GAret1CqFcm4Os+nVnXXYvcNKCAcumsUCl/w5JsCh/u6MMSJGO4eNpSF9mPJt1YCqWRgKLHojofANQUt2c/ppvhrMJiau9GD0kQauIPzDDcVojMRc7e1lAXRSiXnRAcBkaAiZ+m67RP57DGm0T27MHViQYQlSgXjMxIA1Q7iqYHU4WhDVNPFuO2bd9LUipc5EReyMis1N1W/FRqIrXwxss6FPxGT7xjQ2GEygDBy+SrLJk545kiqKPwctF3RHyEL+jQ/3hgecez+I0qqbaUQjVfaR7eanOUCdeTd5hU4JxD+Vco5qD+Mrgp0B+8fPYKi1eI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199015)(36756003)(110136005)(38100700002)(316002)(86362001)(2616005)(31696002)(478600001)(83380400001)(6486002)(966005)(6512007)(53546011)(6666004)(186003)(6506007)(66899015)(8936002)(7416002)(5660300002)(2906002)(31686004)(44832011)(41300700001)(4326008)(66476007)(8676002)(66556008)(66946007)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejA3ZUkxZzFqSFhqVVVxa2ZySGFVNldBNWFSVHJmSkYxVGxPOWRpaWZ1Mldo?=
 =?utf-8?B?b3Z6ZzlYSHZENjNyd21ySi9oN3A5VTk4TzNSb1JzajZ2TW1wTzU2K1c5b1Vq?=
 =?utf-8?B?WmlQcmdEN2x4ajljMUVFNWZCWFdrK2JHOG5iaWJIOFdLTHJLeklOaEpreDM5?=
 =?utf-8?B?ZVErNnU1NlJOdEQrWG9kdmZ4OHExcTBnK3YyeHpVTm1NSjYyNG9hVjkxSzdS?=
 =?utf-8?B?Y0FwTHFVMXZTNXJzd1hvR3hrbVkzenJhZ2xwelV6V1FnZkRPenlsUmlJM0dC?=
 =?utf-8?B?bGpmdTd4cm80bkpBNlJTdzVSOU0yN083bjcrN01yS3g2NlBkQ1hRNExFRFBs?=
 =?utf-8?B?bHRHWU1oVk1JczI0cXdVZ0VIUVYwcTdYa3JuVmZla3VEcHh2NUFYOHczRlk2?=
 =?utf-8?B?SkZiRGpFUlFWeVJTai9UeXJCOUhhZHNpaW11OGUxdGd2ZVQ2eDlVbC9LeHpK?=
 =?utf-8?B?TXhxWUZ1OHlreG9PRnF1eVRWSW1ObUhPQzlqWUtwQjlNbW9HRURJZ3VnaElD?=
 =?utf-8?B?ME5hS1M0bXUraHdINUp0VjZsRHRody8yRVk1VlFJN3gvbGdMNjViL3pHS2Uz?=
 =?utf-8?B?UXlNQWJlc0pIbEhxdEFPUjBvblRMZFBZV1VnRmEzVjVGUFUza0tNTDFwblJM?=
 =?utf-8?B?MGt6UFhRZER1SWJpVkxWTTRRMVhVZ3ZWUG5SeUhKalcvYVJ1WWtVN3hBT09j?=
 =?utf-8?B?K29tbkxrZSsyMzUra2JiWEhyWnNlZldZYktrZnBuQ3ZqVlgzWkxKWlBWUFE3?=
 =?utf-8?B?ZFBRZmZwRjFHOEwzL3Vlb0ovZnZvd1VBd2l3eTlmT0VQUHROTTFGV3RSYWxT?=
 =?utf-8?B?VDN0WFRsa1dnNXNHZTNHSGVZdit1N01LWGhHcStLU05HR0o1MVRzaWhoUkNa?=
 =?utf-8?B?a0pCMW42bjdCMlp0eDhDNXdjd3psSUdTMVFIdjBFUVpVTjJoL1pJOUV6REJE?=
 =?utf-8?B?M0t4dy9zWGtuUFpXQlZmbFVLL2VUY2J4NVY0YWE1RGhkUU5RMFFGMUY1NGRZ?=
 =?utf-8?B?L2RQenZVaW5RdFRRdk5jWUtGNy81TmJ3SVRaQWh4N0RXc1ZsSUdFUHZPcndM?=
 =?utf-8?B?azFTYmplTkhrTExqNHRWU0c1aitBNllrUFU4K052YVd1cjZMMWdhWlE3SEp4?=
 =?utf-8?B?c3BGY3U2OVdyOEYzeldLMENiYnVVSjRvVG9VMGtRVHY2QjJrN0xGaVlSSEpV?=
 =?utf-8?B?UlF1bDI0SVgvQ2ExZVBrVXI0TGZvN0g5UnkxMmlsSEpibEdRS2tHNlhuRVRk?=
 =?utf-8?B?Y3RJU21tR2xxQzNsSXJ2bGhiam5uYWRlZGFLODBHSGxEekdOd3d6VloybkVB?=
 =?utf-8?B?NSsrbWJxVjZZc2orVHF5ODhEUWxubkNVenRWR2s0ZnhWMmRoamM4aFhnbDFH?=
 =?utf-8?B?MUxkdjFld3ZQejhweU1xOVJWVU9QVjNoSmVLRzdXYU5NT1JHMWtaUDJacmdw?=
 =?utf-8?B?dC83cWwrR2ZlK3lCWXZYUVhFVStCeFp4TDZETUM2NU5NVFB2bzMzK2F4djds?=
 =?utf-8?B?cGI3bmlnaVFxUDZXU0I2RWc2NTUvSmR3ZXFiQW5vdjRSeW1DVFdIUzBDTlFw?=
 =?utf-8?B?Um1wWk5BeWRSUzhaMlNFcSttc0phc014SE95d1ZRTHg2T1FIVHltSDN4WmtF?=
 =?utf-8?B?dDdEbUFiT0JjYURiYmsvL3Mrclh4ZDdTSlE4eDMxeTNIaHk5UVRjME05Qy9l?=
 =?utf-8?B?bW0yZUtnc0RaOWRWTXdEL1Z2dWc2djRhcGtlaHpnV0djNm1Gd3RGRUFUamhQ?=
 =?utf-8?B?RGwrV2ZxSW1zVVFTd0dWb1AwcFc4OGU0WVplRnZ1R1ZBZ2Q1WUZHZENZSEI4?=
 =?utf-8?B?OHczc1V0QlQrWWNBWDZGQjFSanRrMS9TN1AxNlF3VmRaZWdLVnliU0hURVQ0?=
 =?utf-8?B?cnBBci9mTmRmYzlobE5TUVQzUWF6dXNDbmFaRzI2ajU3b3JMeTVOSTJlTzZ0?=
 =?utf-8?B?OVdkM1BBWVV2QW10RXVYbWZPZWFWZnRZUVh2Q1lIenRlMlRKSU9rQU9vczJG?=
 =?utf-8?B?NzUwcnZ1dW9EeFEvMzU5MC9mbUZtRUsyb1ZtbldVN05HVFU1VHVGM3RFaCs5?=
 =?utf-8?B?SXV4WHJVS3poZUdjc2U3ajYzSzFSV25jV3VqQlQ5Mmk2TEZKNHc2OEFEc1NS?=
 =?utf-8?B?dlRRWmwxeGJRZmhNN0NsQWQ0MU1CZVdGY1FRYS8rL2l3QVNNUHU5UU9DdXlX?=
 =?utf-8?B?UjRMK045SDhXVnRzMFFKcFNJQ1h1KzVJVzdvQ3NYd1VhTUxIeGF2a201SUtp?=
 =?utf-8?B?TzBIWktoOTRzT0VMdjFuaFBDT0dnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eUIwN21pM1lqWWd4WUxrbC8wRlBhOFdDSHY1NFFqUVc2Q0dhTlMrUjV0SmFh?=
 =?utf-8?B?N2tERmVRSXd2SU5BblhxYzY5Z2JodnRiN3dSQ2RlLzBObUxrNjlFdmc5djZK?=
 =?utf-8?B?bkcvQldqajZ1Q3hsTnVxcEFERU1ROG5KWUp4bTNaYm9tV2l2amJob2NQN3NT?=
 =?utf-8?B?aUlNN0RuUUprN09SSmdpZmpxK3Q0QkQ2WHVqeFNVV0RvSURuSlJDdEhXR1Vo?=
 =?utf-8?B?Nzg4TU9uVXhXa21BQ0lqTG9YQ1B1RERVbUFYQWZybDVSUzl4dDJXUmlQbmp2?=
 =?utf-8?B?bGJRYjM0VDVDVWMyTUxuZ1ZhN3Fxa1RNRFV0QjgwVzFjbUI5MnZMVGJaYkJ0?=
 =?utf-8?B?TWFOckpRemw2MDF2NU16NHpDRkRJOUNrRUxleERZTEZIdkRDenlNUlZBbE1M?=
 =?utf-8?B?Y0hhS2dzMWlZTU1XZXpyNEltQml5eTZNeklmSkZ3c0dxVlRSK0NYem9hZ3o1?=
 =?utf-8?B?Vm5wS0dPMGVmODN2ZjhQbXViS1UrUnpFMG9DTGpaeFZ0aHVraXJ0TjhLQzZZ?=
 =?utf-8?B?ZUUvR2IyTlB0Vjk5SFJ6U0EzNThyeG5walQrckUzd0VzZzFOT090UGwxRjJX?=
 =?utf-8?B?aGticUtOdG9SSU11TWxyUFJXNmE1TEtMVXJ6eWV1aU83N1F1cU9sVXF4N2xZ?=
 =?utf-8?B?L09OY3RJWGV2OUlkNVRuV0lvNEEyTllPWE0weFgvY1FsNGdsODJpWDRsVDlR?=
 =?utf-8?B?Wlk2Sk5oMDRRaG5KbTcySC9qcCtMSFNTRzZZNHFxRHB4ek5vblVUN1prTUVz?=
 =?utf-8?B?MXFOcCtDdmVDRC82R0FiQTF4a3pRT0JnMGFIdDEvaTRKdjB2UGRvM2l3eXk2?=
 =?utf-8?B?QkY0cEJpQXBZQzZocVJrUHhCaWpNdlZ6djdvRFZMWW9jVTFObGZrVkx5MzRL?=
 =?utf-8?B?TGl0NGRpV0NYM3hMY0grbGdqc3JnMFAwQ2Y4UlFTY0pWZklMZDQxZkM1Y094?=
 =?utf-8?B?a0RCUGVvZ3ZIdURLWTBmTmxDaFdiK2hyTnJzYjFWT2RLa04wb2M2VWptL0xV?=
 =?utf-8?B?TEU4QVhETDd5RmJ5d2Y2aWFjOWlzRExvV3JZU3BudGJjZUc0bnBhVzBxcS9P?=
 =?utf-8?B?dTJmWWJMM3pldk9ZcjFEZ2xTaDdxL2d5cHJUUGM1dXRWUG9iODdMeVA3ZTVZ?=
 =?utf-8?B?aGpKMXk1RlNlVndNbDJNZWlCanJYellXd2NOZXMyVjl4QVo2ZFYzYjN1bVd3?=
 =?utf-8?B?bTZ5NTFQVGlucS9VOVE0S3U1andLOWxGQzRldTNiSEptRmVFSDNzSmdrOEJH?=
 =?utf-8?B?bmJ3T3RBaUpvcXBFOU41THpzYS9QZS9iZldPVCtpdU1GK2w0UWljWG5sS011?=
 =?utf-8?Q?Zl0hcFRrz7HpE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f99574c-bcc5-476b-437d-08daf4868eea
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 10:19:58.8421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIVBf3UWILstG+UcBoSST4UShh3uzn3Amw/gqztSrds6P0mlmCVAZ9Vt/pFqQDkhifunNgKHJt79XH1dpVD4rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_06,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120072
X-Proofpoint-GUID: tzN7c9lh5yDKHVJyizc41bQmq02S7Pn9
X-Proofpoint-ORIG-GUID: tzN7c9lh5yDKHVJyizc41bQmq02S7Pn9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/01/2023 07:23, Yonghong Song wrote:
> 
> 
> On 1/9/23 7:11 PM, Menglong Dong wrote:
>> On Tue, Jan 10, 2023 at 4:29 AM Yonghong Song <yhs@meta.com> wrote:
>>>
>>>
>>>
>>> On 1/9/23 1:42 AM, menglong8.dong@gmail.com wrote:
>>>> From: Menglong Dong <imagedong@tencent.com>
>>>>
>>>> The function name in kernel may be changed by the compiler. For example,
>>>> the function 'ip_rcv_core' can be compiled to 'ip_rcv_core.isra.0'.
>>>>
>>>> This kind optimization can happen in any kernel function. Therefor, we
>>>> should conside this case.
>>>>
>>>> If we failed to attach kprobe with a '-ENOENT', then we can lookup the
>>>> kallsyms and check if there is a similar function end with '.xxx', and
>>>> retry.
>>>
>>> This might produce incorrect result, so this approach won't work
>>> for all .isra.0 cases. When a function name is changed from
>>> <func> to <func>.isra.<num>, it is possible that compiler may have
>>> make some changes to the arguments, e.g., removing one argument,
>>> chaning a semantics of argument, etc. if bpf program still
>>> uses the original function signature, the bpf program may
>>> produce unexpected result.
>>
>> Oops, I wasn't aware of this part. Can we make this function disabled
>> by default and offer an option to users to enable it? Such as:
>>
>>      bpf_object_adapt_sym(struct bpf_object *obj)
>>
>> In my case, kernel function rename is common, and I have to
>> check all functions and do such adaptation before attaching
>> my kprobe programs, which makes me can't use auto-attach.
>>
>> What's more, I haven't seen the arguments change so far, and
>> maybe it's not a common case?
> 
> I don't have statistics, but it happens. In general, if you
> want to attach to a function like <foo>, but it has a variant
> <foo>.isra.<num>, you probably should check assembly code
> to ensure the parameter semantics not changed, and then
> you can attach to kprobe function <foo>.isra.<num>, which
> I assume current libbpf infrastructure should support it.
> After you investigate all these <foo>.isra.<num> functions
> and confirm their argument semantics won't change, you
> could use kprobe multi to do attachment.
> 

I crunched some numbers on this, and discovered out of ~1600
.isra/.constprop functions, 76 had a missing argument. The patch series
at [1] is a rough attempt to get pahole to spot these, and add
BTF entries for each, where the BTF representation reflects
reality by skipping optimized-out arguments. So for a function
like

static int ip6_nh_lookup_table(struct net *net, struct fib6_config *cfg,
			       const struct in6_addr *gw_addr, u32 tbid,
 			       int flags, struct fib6_result *res);

Examining the BTF representation using pahole from [1], we see

int ip6_nh_lookup_table.isra.0(struct net *net, struct fib6_config *cfg, struct in6_addr *gw_addr, u32 tbid, int flags);

Comparing to the definition, we see the last parameter is missing,
i.e. the "struct fib6_result *" argument is missing. The calling pattern -
where the callers have a struct fib6_result on the stack and pass a pointer -
is reflected in late DWARF info which shows the argument is not actually
passed as a register, but can be expressed as an offset relative to the current
function stack (DW_OP_fbreg).

This approach howvever introduces the problem that currently the kernel 
doesn't  allow a "." in a function name. We can fix that, but any BTF encoding 
that introduced optimized functions containing a  "." would have to be opt-in 
via a pahole option, so we do not generate invalid vmlinux BTF for kernels
without that change.

An alternative approach would be to simply encode .isra functions
in BTF without the .isra suffix (i.e. using "function_name" not
"function_name.isra"), only doing the BTF encoding if no arguments were 
optimized out - i.e. if the function signature matches expectations.
The 76 functions with optimized-out parameters could simply be skipped.
To me that feels like the simpler approach - it avoids issues
with function name BTF encoding, and with that sort of model a
loose-matching kallsyms approach - like that described here - could be used
for kprobes and fentry/fexit. It also fits with the DWARF representation -
the .isra suffixes are not present in DWARF representations of the function,
only in the symbol table and kallsyms, so perhaps BTF should follow suit
and not add the suffixes. What do you think?

Alan

[1] https://github.com/acmel/dwarves/compare/master...alan-maguire:dwarves:optimized
>>
>> (Please just ignore this reply if it doesn't work :/ )
>>
>> Thanks!
>> Menglong Dong
>>>
>>>>
>>>> Signed-off-by: Menglong Dong <imagedong@tencent.com>
>>>> ---
>>>>    tools/lib/bpf/libbpf.c | 37 ++++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 36 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>>> index a5c67a3c93c5..fdfb1ca34ced 100644
>>>> --- a/tools/lib/bpf/libbpf.c
>>>> +++ b/tools/lib/bpf/libbpf.c
>>>> @@ -10375,12 +10375,30 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>>>>        return libbpf_err_ptr(err);
>>>>    }
>>>>
>>>> +struct kprobe_resolve {
>>>> +     char pattern[128];
>>>> +     char name[128];
>>>> +};
>>>> +
>>>> +static int kprobe_kallsyms_cb(unsigned long long sym_addr, char sym_type,
>>>> +                           const char *sym_name, void *ctx)
>>>> +{
>>>> +     struct kprobe_resolve *res = ctx;
>>>> +
>>>> +     if (!glob_match(sym_name, res->pattern))
>>>> +             return 0;
>>>> +     strcpy(res->name, sym_name);
>>>> +     return 1;
>>>> +}
>>>> +
>>>>    static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link)
>>>>    {
>>>>        DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
>>>> +     struct kprobe_resolve res = {};
>>>>        unsigned long offset = 0;
>>>>        const char *func_name;
>>>>        char *func;
>>>> +     int err;
>>>>        int n;
>>>>
>>>>        *link = NULL;
>>>> @@ -10408,8 +10426,25 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
>>>>
>>>>        opts.offset = offset;
>>>>        *link = bpf_program__attach_kprobe_opts(prog, func, &opts);
>>>> +     err = libbpf_get_error(*link);
>>>> +
>>>> +     if (!err || err != -ENOENT)
>>>> +             goto out;
>>>> +
>>>> +     sprintf(res.pattern, "%s.*", func);
>>>> +     if (!libbpf_kallsyms_parse(kprobe_kallsyms_cb, &res))
>>>> +             goto out;
>>>> +
>>>> +     pr_warn("prog '%s': trying to create %s '%s+0x%zx' perf event instead\n",
>>>> +             prog->name, opts.retprobe ? "kretprobe" : "kprobe",
>>>> +             res.name, offset);
>>>> +
>>>> +     *link = bpf_program__attach_kprobe_opts(prog, res.name, &opts);
>>>> +     err = libbpf_get_error(*link);
>>>> +
>>>> +out:
>>>>        free(func);
>>>> -     return libbpf_get_error(*link);
>>>> +     return err;
>>>>    }
>>>>
>>>>    static int attach_ksyscall(const struct bpf_program *prog, long cookie, struct bpf_link **link)
