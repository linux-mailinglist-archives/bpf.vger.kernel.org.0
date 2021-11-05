Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B434144602D
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 08:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhKEHjA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 03:39:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50860 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229749AbhKEHi7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Nov 2021 03:38:59 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A53R9T8003199;
        Fri, 5 Nov 2021 00:36:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=mAKzlt/k3+C0doZZQ8uZbxJF9RVSg8x1Ywrb6y1zbxs=;
 b=bHNNFTYXfRDvy4rYzRcp3x3Cx8ivxDb74uPXKr8Tkkqwdnd2pbeZem7js+2gZwMmNsm/
 OY67G7lANoO3H7r32MlX3fDkLK4q6RtScapaiPrRZ658fBOYhD/nusshiWJFhHRdloCy
 kBRolpSMAauD5oTLtYx0P4g87dSWbXAp7dg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c4t4n200q-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Nov 2021 00:36:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 5 Nov 2021 00:36:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5kYj+F9rkBfg5HI/QUc1NAcDnHGn6Z84VhWceNTYeAoNSadoSC9ZLIG0wDL0WOjRMzqHRSuwJx+kBTnm8nDcHFXNPAF7QOBcav+bnhjIv6IIkjtxYg6p63m0/mN+MVywHMuUw6/7wdBf9PdeJXi0msfH78naEgMzoSdx+YdklhMQ12XskIgJf7KYibycElPUvIv5hjEbjJhaYW5pSep13IW4CuPtk7JYE+4KkaaO4OloxEHtMBjsM9ufUef83b9GXJ1pnoUB6C35ljv43QwBE0bVOYwvR8XxU1EhWSkHZTgKE7pyVAArHXV/A/dJDo53YivSkUGEZt3+aKGh+OKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAKzlt/k3+C0doZZQ8uZbxJF9RVSg8x1Ywrb6y1zbxs=;
 b=QM+NBxOzKW1cq3ydZzG9P0367IivZ1JNBq8BtdQtUE0qo+HhLNTBLbQVPmU24i0MVjKnqv/mxTgpWWQRuRj+XBxn0rEs44tUeDONp40rN1s9DbyC4SL2IWvkjEK06oJc+43JjUTAZN9/OOMmtvCvaixNJoczusQ7w4mqwfDbcUigRGJbf4Jgc451kX2eXag6v1lKzoSULnOYhNoecTG1m6MVetmtyH0vDmFaT+YCle+tAtD6AbsbztF+Tz0k7epa9v9sEYBIhUFivbMmALEfcPjT/ATNA9Q3TCCfR21JDsvzLx/OizkzC8Fu45sG8lXsQLfq83DNa4BgdAmla5cHlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB3193.namprd15.prod.outlook.com (2603:10b6:5:162::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 07:36:03 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953%5]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 07:36:03 +0000
Message-ID: <3b6d0dc7-d43d-8e1d-a302-311e946fd47c@fb.com>
Date:   Fri, 5 Nov 2021 03:36:01 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v2 bpf-next 11/12] selftests/bpf: use explicit
 bpf_prog_test_load() calls everywhere
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Hengqi Chen <hengqi.chen@gmail.com>
References: <20211103220845.2676888-1-andrii@kernel.org>
 <20211103220845.2676888-12-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20211103220845.2676888-12-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14)
 To DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c1::102f] (2620:10d:c091:480::1:7c65) by MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 07:36:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8070bdc8-bacd-4e9f-a706-08d9a02eeb97
X-MS-TrafficTypeDiagnostic: DM6PR15MB3193:
X-Microsoft-Antispam-PRVS: <DM6PR15MB31934B69FB41DC43EC72202EA08E9@DM6PR15MB3193.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N0J6eSSz4ympATEehRHz7VU71AJOFuwsLpYGkW1XyybhEBay4U17pFUJN3zrcoG0gH+4I5oAvCxrAD/hQTNESX4XrfAXkkIfBzHPRS52bgglRghqp6bbgtI9HnSLWFF4R5zjru59z1WnwkEJaaCSRxJUhy7KW6xCtkG6sucfrI+/qUWBHg7j5uigQae9QscZDoYrCy1dy/Eu7qm2i9+oHHa1A5zGy6kO/zyj5MyPJ++I3/8r5N14UlnpY0Q4M/p+aZN2upHh0526vZEZlFMqpKSxEN8HRl24EufYuieYhEMrBTMVIg9VtGJIi/wa2gAaoGL1YQThsiZIbMdWUe3jFDjCQvsBiuDKlnrcLx8W1JFqkS8ijLfdnECrRituAiK5ijeL2iRlbbEyOXRyL4K372Np5TL9OysCX55ZP0Je0oac9CaFMvOBFpqZESbqzSqcYylEEz/UqdgxwsgtgNTMaZwo2kpV/z/OgRFr7quUn4tP7YMYhHt35yJh8m77e7/YOFybvqp5oP9Zgs6jm8+wre4XNWVYhcNqDVg9paAEC7c29Fgcvlf+nPiyL6/EpAbFIUhAevQSfuSLEfqN1vtltb7hnvM+WG5BxLDM4ORJ347wNx4uEh/szZIY5kJfUE3VBKQWUlze4uigp5WwMoR6aQpUAI9/o45NTYAmKt9bSmHO55QVux9ajw0R3AV5Ac0xMJXK7gTPC+uKaRcrtKDLEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(31696002)(5660300002)(2906002)(38100700002)(186003)(8676002)(31686004)(66946007)(508600001)(86362001)(66476007)(66556008)(316002)(36756003)(53546011)(4326008)(2616005)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHE2QnZOK08zUm1ELzNlck41ZGo4WC91QWVZOG1qMzIrTzJ3VjcrdTNlUkk5?=
 =?utf-8?B?WTFlL3IreXpjUkRUUGhZeFlMMHROZHhiRDNvcTBrSHppdHpjQVhCWXpMNGpv?=
 =?utf-8?B?emFzUnNVSHhLdGNuZjhiUFFGaHRiTlQvMk53RUFnSzNYTDFIWG95VGg5Y3RR?=
 =?utf-8?B?aHRLRm50V3c3ZS84a2lEa2lUT3dzRHZCWFJ3UW9WaVJ4UGQvTjJKaU9veDVC?=
 =?utf-8?B?WmRKN2lVcHJVQTM3b3lwUGl5OHZxNXRScFJ2UmM4SmJkL2ZiV281NEdwRUlW?=
 =?utf-8?B?ajdwS0p3NW5pTVhUcUpHWmw1QW8zMFd5cjZqL0RwdkVtQTg1RWVaeVEyNm9U?=
 =?utf-8?B?R01JdlBMWjMvOGYwZXFpSkhUcGhCOTV5S1Z3MGtCM2FPajd6L2J4SjBENTZS?=
 =?utf-8?B?U1c0aCs0aEc2SVpzd2ZJbVNuKzZxQXRkdUUwWXErd2FDQTB1aEpVK2YyYXdZ?=
 =?utf-8?B?UWtITEk4aldjeG9DS2tJakU4OEVHTFlXelNnNzFwK0NBNHFPQTRZWnVlOWtM?=
 =?utf-8?B?eXJUajFBNWN2NXRoTzJyVUlGdWtLYlVjMWg5WDR5c0gwZ0lMakExQkhXMjY3?=
 =?utf-8?B?NHE1cFBIbUZ6ZGtER0p4bFMvWGpVMzFTSFpvUkRJaU5Wbk9qQVFIUXE1SUty?=
 =?utf-8?B?RHA2VzF3Q1JCaEFWOEg1Si95Wit6UlRaa2hMQUVqM1g2SmxtVmNLRy9kVDNq?=
 =?utf-8?B?MEFmRTRxVWZIQ011SUd5alIzZmhLYkRxTDk3bnB0QXdGazdNVjljRnZKblpS?=
 =?utf-8?B?KzJwN2ZFc05YSTEvbi9XYVNheGZ6OHR2d1BYeDkweU5lNnRndHYzeGpmcS9M?=
 =?utf-8?B?SS80NGZkQjhkWFMwWWxocWNDWmhDN3hqbjEvNkw4aDhITkVuRGRUdlVmdWhP?=
 =?utf-8?B?d3NrbUNralpHM01tMW94eHhUbHdIWTA1Y3VIZXpyZGgrcFpYZzZ4UlBNdkRi?=
 =?utf-8?B?Uld5czg4Q09KVnZXTTBsZmJRTHdibXdlc3J3YThlbXV4cWVPOGJYOVpsT0tz?=
 =?utf-8?B?ak15WTYvSkVTVmpnaGJlZ0VNMkF1NmF4d3F4N3E5VmZCZXRENk5IVzRRdUVi?=
 =?utf-8?B?dEgrelpiWWRRZHRIODMrVXJza2lScERxVHBBanZ0TTY2d25SQllvUjcvTlZx?=
 =?utf-8?B?MldTMWI1QktzaWkzZkVJZGpmcEFpYnI2MDM1NHRUcmtqaEpCck8yRmFkR2hk?=
 =?utf-8?B?azhUeU1zVU9Zc2JNdnhVMDFkbmFGUjJ6bU5na0krb0JWaXlzV1h3dkVadzVJ?=
 =?utf-8?B?eG9CaEh4Nm43SnBWMTJVMW1Renl4UXhBd05xQmpidnhCUGwxRlp0UUJqOXJJ?=
 =?utf-8?B?OTZJdTh4MzI2bGEzSUx0WUJFWC81bkRTZVVwSUVNeTg2STJLWDJLdzFuaUIx?=
 =?utf-8?B?SFRDQ3FZT3Bhb3NyNlVjeGVqZmxEQXJ5WktpQVVRZ3BoNmJmcTM1MzVtOXYx?=
 =?utf-8?B?V053aWhIM0d1eThNeStYVktLRzhNUzlxL3JObVV4b1FsaVR5NWpPZ1B0MHpt?=
 =?utf-8?B?ZFAxS050WUdRVUpGMzRRSTVmamluUXQxL2swTUdmR21kWWFBclhqLzlHSmpK?=
 =?utf-8?B?Y0NqZzl1a0hWZ1cxblFySXdRcDlNVGllNkNDd1lxYmxlaGRVVDJMZkFTdXE5?=
 =?utf-8?B?b01renkzbzlIOVNtb2VUWVhTYy9GL2duOEVENkEzWi9Sb3FBTjBjeUQzRTN5?=
 =?utf-8?B?blp2dithZGYrTFVWZ29iWGZLRmt4aGFmdndqTGpwamVMUW5sNktLQm4yelVG?=
 =?utf-8?B?YXZieTRLdURON2kxTG9wSmI3K0lQczNPdzZzMUlYSWk4VldsaWNSMzUzZDFv?=
 =?utf-8?B?VDZPQzNoMnJEVklLYng1YkNvZ0VEdGpOV3gydXh6dWUvaWdwa01oc2VueENX?=
 =?utf-8?B?YUtHUXpkdlo5dHBTb3c5clJCc2g4a3llOUpheDNnWTR6Y0JQS1RNRFJLVVVE?=
 =?utf-8?B?VmpuTDBvelZpQURQelRTMm9WQzZyN3hBc1BGOE04TWRsTm94aVczTURHb3Q2?=
 =?utf-8?B?SEtpcTFSREY0dkllYWFoWG0zd290emxvdkVjamZkVktxcllBbktEZFZQcG5n?=
 =?utf-8?B?OG5QeElIbHFORmZZQkVRUnVSczk2cmJoZHJScUwza0JweFZXaTdqd3E3aUs2?=
 =?utf-8?B?dUdYaVRtVFR2SXAyUXZRSkZKUEw3RjdaMXZ6YnNRWHRabjllZ3dZWjNKajV4?=
 =?utf-8?Q?dkUURCmWf3e1yM8N26EqkpLbOBDsc//WlydeVtSuN5iC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8070bdc8-bacd-4e9f-a706-08d9a02eeb97
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 07:36:03.2544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5b100pDfOsLTpIJH+Znhsge/eDziFu5RPGiaCCn1egw02W/g1daCTt+v4s9VYKtnimBXsJgRTOsam6MwC3QcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3193
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: fiJhlNNcHlAetcsHo6xE5PMFG027NKQx
X-Proofpoint-ORIG-GUID: fiJhlNNcHlAetcsHo6xE5PMFG027NKQx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111050041
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/3/21 6:08 PM, Andrii Nakryiko wrote:   
> -Dbpf_prog_load_deprecated=bpf_prog_test_load trick is both ugly and
> breaks when deprecation goes into effect due to macro magic. Convert all
> the uses to explicit bpf_prog_test_load() calls which avoid deprecation
> errors and makes everything less magical.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

[...]

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 5588c622d266..2016c583ed20 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -24,7 +24,6 @@ SAN_CFLAGS	?=
>  CFLAGS += -g -O0 -rdynamic -Wall $(GENFLAGS) $(SAN_CFLAGS)		\
>  	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
>  	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)			\
> -	  -Dbpf_prog_load_deprecated=bpf_prog_test_load			\
>  	  -Dbpf_load_program=bpf_test_load_program
>  LDLIBS += -lcap -lelf -lz -lrt -lpthread
>  

I'm glad that this magic is going away, it's very unintuitive.

That said, I wonder if there's some way to complain loudly if a prog_test uses
bpf_prog_load instead of bpf_prog_test_load. Otherwise will have to manually
guard against it slipping in in some test. This comment applies to patch 12
as well for bpf_load_program.

> @@ -207,6 +206,7 @@ $(OUTPUT)/test_lirc_mode2_user: testing_helpers.o
>  $(OUTPUT)/xdping: testing_helpers.o
>  $(OUTPUT)/flow_dissector_load: testing_helpers.o
>  $(OUTPUT)/test_maps: testing_helpers.o
> +$(OUTPUT)/test_verifier: testing_helpers.o

[...]

