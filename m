Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF96C66BBAE
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 11:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjAPK2U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 05:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjAPK2P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 05:28:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E04813D45;
        Mon, 16 Jan 2023 02:28:14 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30G8DvvZ015404;
        Mon, 16 Jan 2023 10:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1L6rq84o8TKfVn1PJ6CxELWuw6V6rd4aGo/J2OPTdhk=;
 b=ks4xU0+BAfKIj6BuBeNleJp+Aca3a4AjywbjKcvSOl8K5T26OtnRfaSAwltowHAwi18S
 ZNtlKmAhWvIB0rlJZiYfQ9ziqlh76tW2gxYGJJ3QLM043qvHczX33UDsPwL4z712/F1z
 aZglIumkctWPWnhwssyYc8NFx3/NdG/WcTuKr/n1+T71t4nwwlYktgRKgH6bVKpAD7ne
 BvgFbMrrccKZINnu1wTpSHdB9LRcohXX5ceWU3n3lNL9C6yW0gC6+uT1oFGdCArBBqe1
 BWWh8D64dJmF5Y7IJOjSKb5Y++wzWREtJZqtUhDd9zm6SqPwzbKcPbpGEMdD21o2DwRy yA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k6c2evd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 10:27:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30G86KfR016739;
        Mon, 16 Jan 2023 10:27:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyx9cbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 10:27:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuvscXcFq7QECfdP7oBwltDyHT5yQT66J7HLIH0i2S1GsgkQwEM6so6M8xzUvC5XUE/V3QRYN2nAS6Fhs8gR5TBkdF9pybAOlxXeZRzXcsRrFSWgQpY9dj8Pn8DJPyCk/GpwGJ7usIe4lhl3hUuWDD25mSnGNC9WMvWCFMk2wOrw9F3LmiCT8p+2a3h5r7DiAfn6z1GM2hYRwdRg47z0vOwdyoEECSPvxs83gmrHG414D2yHD6ly/9xxI0bxgKvKY97bSCm50+ZRlrxTRTgHZiL0/Y//MDGhwg1WUL1Rq3Ccjf6sriqd45ygtFte1AIwHatm0uK4P7UV/+actOUX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1L6rq84o8TKfVn1PJ6CxELWuw6V6rd4aGo/J2OPTdhk=;
 b=FqhD5sfNOcHIW+zbUTWXhk36mJ/3792FmrUI78d0QkK7gzzaNXSinWHpFIPXLZQOx9mvN5bLpm5xfMzH4UO0DJTBqzbSg+Tag3yOdMGpOg68o7erJYKT5X2iKZ90LGPvw22fQokLd9Eaq19QmpAcVcwzJILcKUpqi2UXs/h6T7H8LFeJEM2WRpSHWnCOpN/R62hFj21c06Cc+yt+zYymldvhZFidwk1qhScM/ZrGQVqQpeUbNMsoH3ouVyImjPygLxt1oaVf9+8NWL3kCJVSRGy5JHuoU7ciDgb06Nnv+va09/cUGLE8FxuA9Me+msbDb1bqFlMCPNyrOl/QUVcjLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L6rq84o8TKfVn1PJ6CxELWuw6V6rd4aGo/J2OPTdhk=;
 b=fjTR1Nwb8CbqfWQAQzhCLHfoyD3sWdZqEftT1kNsoqFFn8OiriBDKlAmNmi4inHcEnFe52y5AEiI7kYXoRbo9uLcCDkx8emaqAwg15Sgs2iwP1JzsSuyw6PdCRY2zR57Qpvhq2jtl6a8ehag0bJgvM5l5xtspddYfl5Aii6gUFY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY5PR10MB6022.namprd10.prod.outlook.com (2603:10b6:930:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Mon, 16 Jan
 2023 10:27:21 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%6]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 10:27:21 +0000
Subject: Re: [PATCH] libbpf: replace '.' with '_' in legacy kprobe event name
To:     Menglong Dong <menglong8.dong@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
References: <20230113093427.1666466-1-imagedong@tencent.com>
 <bdca73eb-07e3-2187-c46f-a3f14a9e50a4@oracle.com>
 <CAEf4BzZ5FNw-j3F8cUpy4knRiM1sqQOOPZnM43Kj8peN9kKQLg@mail.gmail.com>
 <CADxym3YqgvYt71+WhMM4jzp+9uqkNdq3nB9kvBxT=CVM7hwRsA@mail.gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <76c1acd9-1981-279b-87ff-90860886abc6@oracle.com>
Date:   Mon, 16 Jan 2023 10:27:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CADxym3YqgvYt71+WhMM4jzp+9uqkNdq3nB9kvBxT=CVM7hwRsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0112.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::29) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY5PR10MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ba73b8-0b64-49bf-0977-08daf7ac405b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDNKoWit3auweDIyi2xWYWa8thUrnEWbzqcBSnd5FZzQCQp3P4E7rJwCxtsTXNF3dw9sb889l7fbw2Y8LfjXHMLn6QmJTfN6YIbWzlf1y9qoR38Zgi7uZyc7tzZCTb+FPm8alJqs7pgb0AWMgI68TMl1amJj4k4llBsAnCnBrljqJTEHS6v48wmwCzudZYNDIp6lnVo+Hmxj3ievUoWdUOXLvNYaF3Jy+H9zlESsNJeKPmL5VUjpn4viDAHEYAOxosawzBXLaAKERKSJ219qrfbo+1SnksOI5qB2C6+L5jJldNo9hUH5KfgAvvmhFfo2BuARW1+sLORradfnD4mKpZ+j9XYR56Rwtmozbf085bft/I9XEuopBF8DBeTKhApzkH3iyVvt9GwDjlNE6DZkPL2KXmkz9aUeJQ0qYmc814lJzxQAtD2w3Pjm1oMluhlz62Igpww0hxB3wTKzcLg1l0SV8MdhwKdQffUvQ9LReYsjFjD0cjtL4CT+ne04Z3xaQP5s6jLsjuZ/5Yt+S+OpQCLlLGubC1Zf/aOT4Kp9nL606nX5tDsLv7ENSKKzi3/oBC5gWbssGSpxuEp5KO1ULCgWglg7LOxvpE3HsXNk2L2/j7nzepXJho67nYnc90iN9jGINSoudmHk1UAqThNU2zMQDNmnXGf1nbpRedBF+QU1sXK7KmTxP+SL+m7t4ZG5YFPZ2RB7SvjrTK+tTmrfgtlNmSnnl0+zUAgRFe5zjXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199015)(6506007)(6666004)(53546011)(6512007)(36756003)(186003)(6486002)(478600001)(38100700002)(31696002)(86362001)(83380400001)(2616005)(66899015)(7416002)(8936002)(5660300002)(31686004)(66946007)(66556008)(44832011)(316002)(2906002)(4326008)(8676002)(66476007)(110136005)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0QxOE5Ydm56bFFkSk0zMVVTUnF2Mkt2WllVMjFkT3hNampBb1hxR2pGa3VU?=
 =?utf-8?B?dTE0bkh1MVNhZzVOMExWb1Iva1lmcWtGVnJpS2lUbWRGZCtsSElEK2dvTVJD?=
 =?utf-8?B?bjBpRWpiTmx2RlU3Vy9MZTRVK2VXcWFaR1JPeW9OSE9yNStFMHpoUE80L1A1?=
 =?utf-8?B?ZCtuc040NjI2MGcyTGJRcU9Ba2hCOGZtS05iQzQzZ0Vqek5ZV3FiN2xmVjhp?=
 =?utf-8?B?V1luNXR6bVZHc3BJUVJQRnJVVTFVWTVpTnRaZFYyOVdWOU9UYTZUeHlmZW9p?=
 =?utf-8?B?S2dNMm1GQzVtbXhJdzVZbGE1RktUeVlxMlNHRVdKOEZ3YVRuNGNBaUpyT3hj?=
 =?utf-8?B?bmIyUHI3MHUzbS9RMDczUHdEOVNYUkNqRUdScVdJS2Q4cUY5T0ViRVU2UVpG?=
 =?utf-8?B?NlFNQkJxc2w2YytwK1JXSlAxcWVkQStWVENMQk03U1lOTjVuOURaZW4xOE9j?=
 =?utf-8?B?Yks1TTd0VGdkaEFvbzNURUk3ZmdnZlp6MFpJeCtjQkFEU09lZlQ5MDFadGFy?=
 =?utf-8?B?R29HZzE1TUZTMjU1ZGtkYTU5Vkcvc0pxTFErY1Vrd0ZBRHlUUmZLWElITFVp?=
 =?utf-8?B?LzdubjdIOHRsVFVUUGdjaEtVbGFZUUNLdlJvc2JQNGxVSitESUhwTHE0TW5G?=
 =?utf-8?B?Vm9YMllIeWNIMk9YeU9YK0tvSXEzMTN1NEIreGZKZzNtYm5ieWhxL0lkbkRQ?=
 =?utf-8?B?cDhVZVB2b1l1eVdZbVMyRnNrV2pLeXR3RmdGWDF6Z0cwS0dHbkpEK3pRbDVs?=
 =?utf-8?B?K0I2V3RFQTFBZmtpVnFkUzlhT05CUWJDbEhkU0RYa1FybmV4Vm9ET1NKeTdB?=
 =?utf-8?B?Y3J2THdrN3V6WGZtWlZsbjRZb25kSlJIQ2haRGdBSUNub0swU00rQ1V6UXc0?=
 =?utf-8?B?eDd0VzAzUDA1M3VKS2NjTFJwTDBkWVZYb05zMTJPMUttaHJoN0t1WUoxejRt?=
 =?utf-8?B?S0tGSG9kYTExWlEzMU80NVdhZXljbVpjVnhiQjRkZjZpS0VpWFJUSGwvaVRy?=
 =?utf-8?B?QVJ1REVnK2l4NzJhVWpheGxkMU9PVStNdy8xcE05dUs5cVZXY3oxQ3JEbElN?=
 =?utf-8?B?VXM5b3laS2t0Z2QxalNZRWRkMFFvRVl5VUpHME9RcFVXdHpGQk5JUEpXVUxY?=
 =?utf-8?B?NW5KZkxxZzF0R0JreHprNkp6U1hSSG5mNVp1TTVzcENjbUVCaFh6dnFhMGFk?=
 =?utf-8?B?a3BlMDBpRWVWcGhmUUpnK2d2T2hiT0hWWFBaOU5YZFVjUW4wTzhVZHN4RmxU?=
 =?utf-8?B?dFJDRGl6ZTJRQStobGxHMndNM0dyczZwbWtPejJzOFdzVklGSk1pVVFQb1JD?=
 =?utf-8?B?NVNBU3lNdW1qb1NrTThNQ2tNQzk3eDBycElmOFdBdCsvMmt6Z0g5eTUyRGJU?=
 =?utf-8?B?NFBic0IxM0VBeExFRDUwcGR6N1dmVE8xMnRvVk91U0ZyNHNmalJUdFUvRWR4?=
 =?utf-8?B?clNyZTd6NjN0TjlXZU1uUmJrQS91YlNuOVRiRXBrSHF0QTNYcjFtaHJpWXBn?=
 =?utf-8?B?RW5ZTlp2eXZpTGpUUjZpb3pXRnN4b0ZFZEdtcEJHajJwTVg5Uzg1enZITkFD?=
 =?utf-8?B?VDVjdW9zNjZCNlpXUTg4YmhEbXp6STRxaytnM3MzUTkyY0lqeWdoUWZRRG4r?=
 =?utf-8?B?VVR4c2U4WEl5K2c2TmFwOWZ3ZjlpVmZHOWdvOTFuR1h6MHBJeFc5bjV4ZEhH?=
 =?utf-8?B?cUYyamxGWmhaWjRKQzFxRElhb01vMURxRXFVT3RkbTNoUkNaSnJ1YlNRRXUy?=
 =?utf-8?B?WC9SUEw0UmtLaFg2a1N2Zk0yNkFaV3hKOHg3Mzg1d3FMYkp3RVVQM1JtN09R?=
 =?utf-8?B?ZStLMzVSWExIU1EwU2FCd1l3M3VBRy80YlArNkNqQlNNblJIOW0rR0dPMUJD?=
 =?utf-8?B?QUFIT0ltbVJMYlBCVGpmZk9GWHF0c3dtNTBYeUhUWUZVTXlLY2ViM0xyWU4x?=
 =?utf-8?B?TWRGWEdXVDRLVVBsbXlUYzBYMjArREdTd1ppOWhvZHdoeHVZZlZhL2dPL1Vr?=
 =?utf-8?B?RGh2aUcxQ2RGZWZVUWhXaklxRkRNdUYxL3VaSkMwcUNobXRzZFJrOVFtZFJs?=
 =?utf-8?B?cUZvalhDWHhWNS8rOCtZUzRqaElzOWQwOGwvZU5oVDd6WUNvcFpGaDUxN1Z3?=
 =?utf-8?B?VVRMSTFZZk44SDF6Rjh6aGRxblZhR3VSTHlJSEZDV3FFZDc1RDJ2Vmp0WWI3?=
 =?utf-8?Q?BVUszTerC39JwTgNXqipEf0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?b291YXEyV28wTE5RM3NwNUpJRjJzOXE4MmRHWXFYU0JURlZleDhMNjRLSHln?=
 =?utf-8?B?YWJFU2xMSzJFUlNwMERSWEpkTjdCMWdRQ1FwSjVsVDJzbnB4bmJVdTA2eGt6?=
 =?utf-8?B?dXErOHk2eE84UFM5OFpyUTE5V3BOY09ZZjJscnhlSE5IZ1hxSmlrdElieWFT?=
 =?utf-8?B?N0NzdGFORytuU0JtS1Rxc1NpUCt6QjNjQkVqbGRsNGJuQy9LWmxxUVdLZG5s?=
 =?utf-8?B?N0xJMFAvZFY0VWNSeXNxYm15cGtqZytaZS9TZ1pPNXl2dzB2emFKTWZRdTNJ?=
 =?utf-8?B?TUE2c0ZQM09ULzNmOGJqclhJcklaUUxNbkZ3NVcyeEE4U0JTNTJjUFlwU2Yy?=
 =?utf-8?B?ZjhJVzZpNXpwY0JxZG9GR3hWZkczT2lSUStzekpTRU9pOHhtYVFjUVVJdlVv?=
 =?utf-8?B?d0RtM2NqbzJGa1NNeWRDTVIxcVhnd3UyQjRFeklCZTJaZHdpclRsbVJxbi8y?=
 =?utf-8?B?L0tvY1NzYmRIbkd3bGdMUDhzUXZIenQzdGpmSkxLZTgrb1hlaXdNcUcxbUhm?=
 =?utf-8?B?bGlSbUwvanpoT1NjdFI0cHNSNGlReGZSUThObzUvMFM3QlIrd08vZE42UTg4?=
 =?utf-8?B?REtGc2V2MVN4Z1FWVUNDQ2I1dXh5RGFBMWRRY2p6YUUweUIxZnJnc3FkTmlp?=
 =?utf-8?B?M2M4Q200S1FwMFhNVEhWeU9CRUg0MUNiT0w4aHVQTjZoRzV0d0k5THRJcGQ5?=
 =?utf-8?B?Wm5aNHZKSXJLNDJNZjdwcjNCOVBPWk5hZkRleTFVK0czVXV3MGcwYnc1YTVD?=
 =?utf-8?B?bFpHcEsxMTJTL2haeHZ2Z0dUMnk3T2tWQUdBYUpMQVJiTVo0bFBpcTkxbVow?=
 =?utf-8?B?L0tzemowRzRYamtER3VmSnRVZXJ0UjhGYjRQUUJYdjNzQXFnd0FXNk5zSWZG?=
 =?utf-8?B?MFloRktvdFJCM1ZWMWQ4OUQwbTdpMHRXRWNXb1lIV2I1V1BuWGtiZUtoMWs4?=
 =?utf-8?B?ZkEwOHNjQ1pkWXNDVEIzaVBBR1oycUhqNEtUakJXcFZDQkQxUmVGdUR2cDc4?=
 =?utf-8?B?U1RKanhEbnY3RGNRd1lId3F1eGYwVkpPeFpOZGM2WEZOOHNQeW1SQzNmeWhv?=
 =?utf-8?B?OVdMOEJPTzVkM3lsS3JaUGh1cVpQUWl6TnNBVE8rV24zenAzRDJrdEVRaGs4?=
 =?utf-8?B?MnhmMzFFMjZ1S1VSNVI2R0taMnhSdE11ZzhpbjFmanNKLzdzUXZKL3h5SFlr?=
 =?utf-8?B?aTVtR1JjNlJwbWdJWVNxWWVXSDNtS1IwRjJMa1QreXZFN3NUVUx6ZlIzL2hk?=
 =?utf-8?B?aVJuaEU0cnNodGhaZGZxRWJsZkVLME9oalgxNkhHYUpmRHdJQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ba73b8-0b64-49bf-0977-08daf7ac405b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 10:27:21.5004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/lNdherf1t7LwezdI0GO1k8/nYcaoRbcf7F7FGoPD1eaR4/VKXelTFjgviRzUqPubp7vUFA6fh/z+oTjeqsYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6022
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_08,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301160077
X-Proofpoint-GUID: RTxgaD5FiBMrX42IZhCfg3bCB_HSdSbP
X-Proofpoint-ORIG-GUID: RTxgaD5FiBMrX42IZhCfg3bCB_HSdSbP
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 16/01/2023 02:27, Menglong Dong wrote:
> Hello,
> 
> On Sat, Jan 14, 2023 at 6:07 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Fri, Jan 13, 2023 at 6:13 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>
>>> On 13/01/2023 09:34, menglong8.dong@gmail.com wrote:
>>>> From: Menglong Dong <imagedong@tencent.com>
>>>>
>>>> '.' is not allowed in the event name of kprobe. Therefore, we will get a
>>>> EINVAL if the kernel function name has a '.' in legacy kprobe attach
>>>> case, such as 'icmp_reply.constprop.0'.
>>>>
>>>> In order to adapt this case, we need to replace the '.' with other char
>>>> in gen_kprobe_legacy_event_name(). And I use '_' for this propose.
>>>>
>>>> Signed-off-by: Menglong Dong <imagedong@tencent.com>
>>>> ---
>>>>  tools/lib/bpf/libbpf.c | 7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>>> index fdfb1ca34ced..5d6f6675c2f2 100644
>>>> --- a/tools/lib/bpf/libbpf.c
>>>> +++ b/tools/lib/bpf/libbpf.c
>>>> @@ -9994,9 +9994,16 @@ static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
>>>>                                        const char *kfunc_name, size_t offset)
>>>>  {
>>>>       static int index = 0;
>>>> +     int i = 0;
>>>>
>>>>       snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(), kfunc_name, offset,
>>>>                __sync_fetch_and_add(&index, 1));
>>>> +
>>>> +     while (buf[i] != '\0') {
>>>> +             if (buf[i] == '.')
>>>> +                     buf[i] = '_';
>>>> +             i++;
>>>> +     }
>>>>  }
>>>
>>> probably more naturally expressed as a for() loop as is done in
>>> gen_uprobe_legacy_event_name(), but not a big deal.
>>>
>>> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>>
>> Applied, but tuned to be exactly the same loop as in
>> gen_uprobe_legacy_event_name. Thanks.
>>
> 
> Thanks for your modification, it looks much better now!
> 
>>>
>>> One issue with the legacy kprobe code is that we don't get test coverage
>>> with it on new kernels - I wonder if it would be worth adding a force_legacy
>>> option to bpf_kprobe_opts? A separate issue to this change of course, but
>>> if we had that we could add some legacy kprobe tests that would run
>>> for new kernels as well.
>>
>> Yep, good idea. If we ever have some bug in the latest greatest kprobe
>> implementation, users will have an option to work around that with
>> this.
>>
>> The only thing is that we already have 3 modes: legacy, perf-based
>> through ioctl, and bpf_link-based, so I think it should be something
>> like
>>
>> enum kprobe_mode {
>>     KPROBE_MODE_DEFAULT = 0, /* latest supported by kernel */
>>     KPROBE_MODE_LEGACY,
>>     KPROBE_MODE_PERF,
>>     KPROBE_MODE_LINK,
>> };
>>
>> LEGACY/PERF/LINK naming should be thought through, just a quick example.
>>
>> And then just have `enum kprobe_mode mode;` in kprobe_opts, which
>> would default to 0 (KPROBE_MODE_DEFAULT).
>>
>> Would that work?
>>

Looks good - I'd missed the "no BPF link" case, it'd be great to test that too.

So for legacy mode, we'd force using the legacy codepath, and to simulate the 
PERF mode where BPF link isn't supported I think we'd need to add to bpf_perf_event_opts
so that we could choose the "no bpf link" code path rather than purely relying on the
kernel support test.

This would be nice as it would allow us to test other "pre-BPF link" attach targets
too.
 
So I think we need add an option to bpf_perf_event_opts for when KPROBE_MODE_PERF is set,
such as PE_MODE_PERF or PE_MODE_NO_BPF_LINK.

All of this would generalize to uprobe too I think; having a perf option makes that
straightforward I suspect.

> 
> Sounds great, which means I don't have to switch to an older
> kernel to test this function for my app.
> 
> BTW, should I do this job, (which is my pleasure), or Alan?
> 
> 

Feel free to take this on if you've got time; I'm trying to get the dwarves patches
covering support for .isra functions out as soon as possible so it would probably be 
a week or so before I get to this. Something like the above combined with updating 
the attach_probe selftests to run through the various attach modes would be great for 
testing legacy codepaths on newer kernels. We could perhaps rework the test_attach_probe()
function to take an attach mode argument, and add subtests for each attach mode (skipping 
if it wasn't supported). Thanks!

Alan

> Thanks!
> Menglong Dong
> 
>>>
>>> Alan
>>>>
>>>>  static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
>>>>
