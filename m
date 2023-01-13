Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFB96699DB
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 15:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjAMOP5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 09:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241025AbjAMOOJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 09:14:09 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B2010E4;
        Fri, 13 Jan 2023 06:13:42 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DBQjbA003991;
        Fri, 13 Jan 2023 14:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=c8VvRnFJnGD7Vrakoz6hao0WYz5zT49N58T03K6I1Hs=;
 b=gOhKSs2IzXlIgY0cVacipqgJN0Cbf7VSZpPAK0O7NF5Y2Ms7IEfXXYAWk7O2MKsFiUpm
 jNi/OsqvJ6wEP4uBj5oNhnipyenT/Aiqil4OugeRCdm7ZKxSo3LgTiRyKNyHEjmnSnpY
 GqaEgStTKZ1ou5eyTc/OUd4SSCDj/DMbfMBxSJawtSybA5LiASeqN0fd1xHdXjXUmhFY
 lU+aBqtL/SQ2l4X8qT0DZaKJbh/T1b844wW+kv1YOSoCPlNPu+UtlinwrLdIVNGMkaUj
 YRymvJ9LZ8s72bKYfLQmlCsSIz9xXXtt3KZxU9Zp9fyw/gHdGvL7MNYUH44mGUK8pe7P 1w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n36ed08jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 14:12:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30DDW5e6037471;
        Fri, 13 Jan 2023 14:12:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4dpcf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 14:12:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4nuf6WTiqpYbfytIAkfQR8rmURdvjB5/6I6sYK/JA5tuwi94EktpiDOaSjt4S8AFwNKVqI99FB1tnCcDf2B2BRudg5EddwByT7HdpE5M4pKKDjij62GlcmmS7j5xIJqFcJDMIP/Lom38mxnjphHUCwO04OYHjpzvdzDpuC9ZwgG5yypZa8ZKic6QzuGfupggxZz84kwYcQp/ZVWHMX9TcBvxDeWa0Y10ZHkr/iS19ZhACJIvP5uTnnyfPYyGg6mu3VSrasMPpviU5hunFHmWR2jiQsCNniyXzoq6f+IaHF6Fhg/Dkbpq7Kt5IfmtXtJNox7lT9g+Tj5LWYtLDk6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8VvRnFJnGD7Vrakoz6hao0WYz5zT49N58T03K6I1Hs=;
 b=KLeF6LYB7CA/sJF1xqbuFDQhzULivLDV1mdEpnHOrOf22SCBbypNIsmGvaOQpiN52DH9SYXeTqgV+GiFMdT1p4j/On3v9dIFIo9jKURgQGnksbV4oQ5goYGEVkK5Bc58jRUXv8i5KZvsIhGjKp2ajSTU3TPJMH+ak91mEhwZePmIYgdD+JP+PNnnbINRvcODS1Oor/lxgE81xg1pumV35wyW+i6dNRzZKI/zvPfc7DoVv+tjIF62pgoNbsUazZAr2vMECDO3zzN1Y/TwPcLB9xUmplSs82N4W8I90QGtwi+xY7zP7m4Y2tywfnhaJ7MFfiOILTJROiNf29nj5XV+cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8VvRnFJnGD7Vrakoz6hao0WYz5zT49N58T03K6I1Hs=;
 b=A/ZCWmNLKlRy12qeloqRc3ihrBq48Wm1INmoQLcgCJUs+yZVUHdCywjw1MGwpv2f4i3SnC++H91iAheH2yjkW4KlE8TeArzKW8yLFAAbb2IWhu84nFIM5VuhfAcdjij7eCwkeudmYwv19Z/6YMtoLXSBjO/GGdgh2LR2GuQ/JAc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB6625.namprd10.prod.outlook.com (2603:10b6:510:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 13 Jan
 2023 14:12:47 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%6]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 14:12:47 +0000
Subject: Re: [PATCH] libbpf: replace '.' with '_' in legacy kprobe event name
To:     menglong8.dong@gmail.com, andrii@kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
References: <20230113093427.1666466-1-imagedong@tencent.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <bdca73eb-07e3-2187-c46f-a3f14a9e50a4@oracle.com>
Date:   Fri, 13 Jan 2023 14:12:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20230113093427.1666466-1-imagedong@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0273.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::8) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: ef7eeea6-0bae-49ac-a1ff-08daf5703efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jD+FHpIEfm5ZsbWmwdRHA5+ENHysOnu+nxq8DP6hYxHqM7Sah1SGGBYtkW+vLD2MA0OZyDBpMUsIKOmcQmr7pVaM8DuF2qKqNdeqn+nA1fNShNBgnqumV1gLnHvNrwRILb7N1PbEzCMgC+VLj2EYz6fejKs7Ibhyuk3DQzU25H7GAPmKWdrFl+VBL5Qw36ew0xlVdqgmpAa1a6RyV6mFlXexGpblKUeXA08lxAwi051HDtY+gK/U1ofHQXRn99FfNTeIKQ/5yCDC/34XE5n1JuK0yI6g2LaT1xCoe/IiMD4XXyBwKqTbWWbaQSLivucSM6cJEVdv2v2c5YoGBFytcJR3mma8V/8gd4iJqNhZYODhRYIFLKKnZ0wiF0Rc2M65nKd6CPENeqOv0cYU4Q0cTVx4x7NMqduvWHjrBoLQK/FTZBPKwla0vTWh1Q7huAMZ05DY6QR+eJNsWKRUHhBMkF0lZj89fJkJccivitNDbFuWgtJ01bbT/DHoD31geplmTg8+AiAXVmE5fqnG0Zj9/4EadnJLhvNonQ8j5FvUg19HXCzXTEvCOk9a7yVd+ZM0hTUw77ao6gKkIEMyozYwwhJUVKTShmfhcmdcpE7Ml14hfuHXfXbwKanlUguubAzVjhWHdAhrZqu3sfk3/1mhbjNfuH1ZmDcm3qjiLyGkoJ6As9MiZbMegFjVZyop/hlazdyfjQpP7s1IwoEGzNCsK91DoZJe0yzTsf4gmqrVlhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199015)(2906002)(53546011)(31686004)(6506007)(6666004)(38100700002)(7416002)(5660300002)(44832011)(66899015)(2616005)(478600001)(8936002)(66556008)(41300700001)(83380400001)(4326008)(86362001)(8676002)(36756003)(66476007)(6486002)(66946007)(186003)(316002)(6512007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVcrM2pZb1hUSkhNa1QyanYxSEdTRlRvay8vOGY0Z1drTDJadm45Zkl4cWRC?=
 =?utf-8?B?MGhtRVUrVGRsbGxsRmkrN2tZalRNbzF5eHQwcWJCdWtLUVIybTRpc1krUkZp?=
 =?utf-8?B?d3o4amNMUGxPVjVzT2pGcVdOaU9xMFRPRmNhS0lqRzF5Tmo2UkFkM1V1SG9r?=
 =?utf-8?B?RlZzTEdzclRseXBYbEdtYWNHTldZaEdYU1JpSElITlcxeGFCSkg2WjJjS2la?=
 =?utf-8?B?QldldjJQUThtb0dxVTNCWXJVaXVyNFVrNml4MXVVN2VOdXNIUDh5aXIvbDM0?=
 =?utf-8?B?WkNQV25VbWJTUktzY3FERUdSdUtFb3RUMFFlenhRRW1JdWhkMDBjd3Z2eXlx?=
 =?utf-8?B?RHVVTGxEcjNLd3VlY05mYnVOZDJGWVE4b0dHSENpMk1JZmorY3R5bFZMd1VZ?=
 =?utf-8?B?Q21vbTVHVzNZTTdHUFU4WVcxbitzd1p2UGpUVFN6UFVYdGRQY1pySENkQ2tT?=
 =?utf-8?B?dDcvUmg3V1lFalpYNDNyRldrS2RJM1JsR3l5ay9wcVBIeG1rTytUTkpRMmFn?=
 =?utf-8?B?NUN4aHhod0pSRDAzc1crSjRaZzcwQ2VHUzJvYlJxZHJaS0xzaDVRcm9LZ3hU?=
 =?utf-8?B?TzZTNzc4K09kaEw0ZHVYWjlwVjFoMHZlWExXMnZZaGJBVHBNZ0tkVHRQeGVW?=
 =?utf-8?B?VUNvcFYyMjhXemNsSzA2alphaWQ2RjZqTVJsMnJBWGp6WW13MWVFK1g4c251?=
 =?utf-8?B?eGhoSStaUHNMVThUMzhhUklFWGpFVWVxNnlJZlUvblV5RStLNE5SUTA3L1VW?=
 =?utf-8?B?L0NYQnJiNGk1L05BZG5PWUFid3dsWHU4R1VjY2Z6NWs0cXQvcFc3OTBjVGJU?=
 =?utf-8?B?dzFiZ1FpTzdKMGY1MFNENzJ3UzhIRWpvSGRjbDVES0ZQS1lqWXM1eXFGYkZD?=
 =?utf-8?B?Z3orUU45cTM0OU42eUoybHEvdm9kTnBWRG8yS0JHeUJxRmg4QUxRQVpvUFdp?=
 =?utf-8?B?YUkwL1BDYjFqdUdzaHd3YjEwY0RPMnFISFZQdlFMMDJ0RHJLZkVIdVErd3Zu?=
 =?utf-8?B?KzVJUkl0bDUzVUpVbVVYMXJya1JVN0ZXSmczQVZucGgwK2lqZmFZbU9VZmYy?=
 =?utf-8?B?TENLZXZzaDJyTmVudXBKeUkxNHdRMFNoQTJKS3F5ZUFCcWZzbERSSVowLzky?=
 =?utf-8?B?UitBK3puV1pOTFJCTittQlRrUVgwYmgzc0NWYnF3ZThxN1luZmlEaVlHekpP?=
 =?utf-8?B?Tmt1Q0xQdTFNcXI2M3BIaG5RN21EZ1VBOU51SnNha3JXcHZ0RXVwaVQ3Z3NL?=
 =?utf-8?B?dnU4aFNHU1ZkdndpMjRpWE9kK09oOGY0aWhqc0hmQnJYVTMxdEJSS0dLY0E4?=
 =?utf-8?B?L0s3SXM5T3VSZlVXbURpMll0U0pNY2s0b2kyOGRqYkNWTVN2WkJTd0U2UmRD?=
 =?utf-8?B?VS8wNmtMWFJlTmdyK09aR1drNkVCNy90b3laNC9HZnczOXpTK1ZkMnFEVzdj?=
 =?utf-8?B?OGI0Q1VGd29VV1RacUNMT2FYL0FyakZDWktxblg5dUVXRnR0L0pzTEs5SmJs?=
 =?utf-8?B?ZEVCTndHTUtteStGaSt5d3VDZ1pxdkJ1ZmlraW1PT0JjdHpBa0hpVHl2R3kv?=
 =?utf-8?B?VVBINGZaRytyMmhYWEl5M0k3T2F4dWdrcFEwRmtSS3hDTTVEUXRMcDdYbjZo?=
 =?utf-8?B?amltam9xaW5DNytCODlPeUNsUGRXSmduYm5xL3RadklKM0syZ0JIVUhVTWYr?=
 =?utf-8?B?SERqTm83TE5zMStLeEQ4RmhZU2NvUHJHMHdINC9KQW4weVl1azh0empZV0k0?=
 =?utf-8?B?L3lDdVFoT0hXS0hyR3preDZIL0Q0a3VpckpvQUVFTXNYTFpQVXNQcDJuTThS?=
 =?utf-8?B?WWl5UzQ2eWFMVENxUTByZDMrd05ZNFYyZW14dVlLUGpOTGMwSlZtNzNrbE15?=
 =?utf-8?B?eTBQVlN2VzlYU0UxY0p5WTdoK0ttV0NVVGRKdzVnRGJsWlNIRXRyVGxVK00z?=
 =?utf-8?B?N1U3cTdPWjZhUGhwdDJZRXlrejBkTjhiTDgyZWpheVk3Y1FEb1VCeVR5aWVY?=
 =?utf-8?B?WW8wT1JGbkxPM3VyWE8wc3JhSG9NSTdvd1BTd0lpNWl6ZENpNVZWMkdsdjBw?=
 =?utf-8?B?R1h2MWtWY2wraUwrL29VOGVERlZ3ZUt5aDhIWmZRRVpIc21jN1ZTbmJFWE5j?=
 =?utf-8?B?TG41M3QwbzR6TjJ5eGNHb1lDbGZ3NHoycnRsa1dvSXA4aDFKb1NVcGpUL040?=
 =?utf-8?B?VjFQeDFpcjByMG5IOUJxYkZvUnNrd1oyK2R3OUdQR2Z2S0V3S25ZMnJvZlgw?=
 =?utf-8?B?cUtaTW5HT2tYUUxkT2M1WUFrR01RPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YW1mNGY4cDlyZE1PdlNERkNMNjRIdXVBUjNzYWZxYkhNV3cyZWUxWGNWSXhO?=
 =?utf-8?B?c2FTYlNXeFFPMFZzMWRjakhzYStvWXE1OUNpbkhMdHF4MFJDMmVhODdHMmY4?=
 =?utf-8?B?c05lR2piQnhsZDFxa3d0YllhTklmSEREcVcvTlhJKzU5YWVRTmpPcmYzdmtn?=
 =?utf-8?B?QnNKWXhXSHZoY21EZmswM3NqK054VS95NG9WVTN1L0wxSGRSczlFOS9rMG0r?=
 =?utf-8?B?ZjBkZ3hiMmNJaUNERVMwcGFUWFg1bVJkU1FUU21mM3BmM3NuQkVwcWtrVFI1?=
 =?utf-8?B?SGVST2NLZ0tLdzIwcnpteWN3cXNEekU2cnNTRjFBdXFCZE14alFWQ0wyTFlC?=
 =?utf-8?B?UitJOWR0UEY3STFRMzgrSWpmclFpSUdxaGYvU0dOOHV3TDZjM3QrRHVJY0JX?=
 =?utf-8?B?UHU4ZlI3bUltcStqZTJzZERMSngvb2dERDZCTEhjV3lwK2RQWlRSa0h4eGd1?=
 =?utf-8?B?N2xZNjExR1NoOSt6YktzMVhXZUtOaHJkNk5pZjMreVJrcEpPcmlOMTJ0czkw?=
 =?utf-8?B?VU1EdWxlVFFmMlRiTzZsZUd1OWtFVmxhZjVtZHljUlJKL3B1U21qbFU4ZGVQ?=
 =?utf-8?B?bngrT1BmazlxSVkxNkVWMXh3bDdIMnordDEwTmdHRys2a2FYa3gzQWRKTnE4?=
 =?utf-8?B?T2E1ODRXT0h2SVo5TWNLaEpxWnVyaW5OTlp1dXFld2pJL0gzL0F2eDBuMEx0?=
 =?utf-8?B?bU9YaHRFNVVvckpncC9YUDNQNTY2cS9nQmtVVjRUc0VNRTJxQTZET3VQNEIy?=
 =?utf-8?B?YVBDTHdDU2lmeWE2OGl4K2RUbitUMm93ZmJhTEFXTlhxM3dEdDNIZW56UlEy?=
 =?utf-8?B?ZWNNRTRhby9TdTJHUTluQ25yR0l2eHZyUkgra1ZxK0dsQWhrbDQ2VzUrTzE5?=
 =?utf-8?B?bG1TVlVrZ3VBTlBpVzZzTE5WUC9GZ3dLVmMrR0pTZW9sTk9QcHZjT1dCYUxW?=
 =?utf-8?B?dFlDcUhEMWZRZXZLalBWdE56UThRbHdMVWQxK3k1T3lyZ0VEdDk3YUYyaFBY?=
 =?utf-8?B?Vmd5KzRmcFZudWgzMStLVmlSRm12aGUyaG1ucDNORW56Y2hZZm1TTVY5cUJo?=
 =?utf-8?B?Y2hGcTcvNnc2dHUybTVTR2MwTVNsRkFGWUNnQ3RxeERFZWtRSzZ6UnNzeExm?=
 =?utf-8?B?dytFd2F0ZTVScDJJeHBTLzdncEJZb3JOVjZ1enNyVFNXZ2tUbDFGZmNOZVNW?=
 =?utf-8?B?bjJtVVI4Nm9uL2tYWWRGeVUzbEY5cUptV3lRM3l2REhZQnY3YnByWThVWXdR?=
 =?utf-8?B?a0RwUk9nM2x3djkrR1lCU2lxL2p1cDBSUkhseFIvTWtIZ1Yxbk1MRWxKRkNr?=
 =?utf-8?B?L0FMSVRoTnVKOE44eFNaYmFRY0Z5T2JYYlRMTzhRUjBScUZLcTgrZ2VXdWNr?=
 =?utf-8?B?dHQ2N2ZlaWZYSy8ycmdGQVNldGQySnQydStPVGRqMy95YkF3cEJZRENJZDli?=
 =?utf-8?B?VDdDaXZpQW4yM2JqeUNnVmpKTTYrVTNUL2dTSzhtMWNyeVpHdW1pcFh5SjZa?=
 =?utf-8?B?NDB6UEJEeE1vWGxpeDR2SWl1ZmxLdHB4WjlnWElMb2JRaW1SWWt6N2tUMUtD?=
 =?utf-8?Q?L/roxeEaPKWI0JqASFMy0teaY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7eeea6-0bae-49ac-a1ff-08daf5703efe
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 14:12:47.0550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6nvxjWLcFqlsa0rp8qO/qShMsfA9+02gc5Onm0U8iymQKz+A2KXJ6XSo1vjJ9hesUDgtglaX9+RlUoiL6RMug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6625
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_06,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301130093
X-Proofpoint-GUID: cqsP72NM5jJNuEzK1V23A2dn6tYwGE4S
X-Proofpoint-ORIG-GUID: cqsP72NM5jJNuEzK1V23A2dn6tYwGE4S
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 13/01/2023 09:34, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> '.' is not allowed in the event name of kprobe. Therefore, we will get a
> EINVAL if the kernel function name has a '.' in legacy kprobe attach
> case, such as 'icmp_reply.constprop.0'.
> 
> In order to adapt this case, we need to replace the '.' with other char
> in gen_kprobe_legacy_event_name(). And I use '_' for this propose.
> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
>  tools/lib/bpf/libbpf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index fdfb1ca34ced..5d6f6675c2f2 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9994,9 +9994,16 @@ static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
>  					 const char *kfunc_name, size_t offset)
>  {
>  	static int index = 0;
> +	int i = 0;
>  
>  	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(), kfunc_name, offset,
>  		 __sync_fetch_and_add(&index, 1));
> +
> +	while (buf[i] != '\0') {
> +		if (buf[i] == '.')
> +			buf[i] = '_';
> +		i++;
> +	}
>  }

probably more naturally expressed as a for() loop as is done in
gen_uprobe_legacy_event_name(), but not a big deal.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

One issue with the legacy kprobe code is that we don't get test coverage
with it on new kernels - I wonder if it would be worth adding a force_legacy
option to bpf_kprobe_opts? A separate issue to this change of course, but
if we had that we could add some legacy kprobe tests that would run
for new kernels as well.

Alan
>  
>  static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
> 
