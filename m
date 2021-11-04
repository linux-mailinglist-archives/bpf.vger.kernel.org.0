Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7724459AD
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 19:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbhKDS13 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 14:27:29 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58350 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232058AbhKDS12 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Nov 2021 14:27:28 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A4EbDU5014814;
        Thu, 4 Nov 2021 11:24:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Jqnrkv3vL1S1xN5dSPofILYKwZdtIYvSi94t003t38I=;
 b=ZTOTlLj8jONpNx/Pb4MjfJuiNH/R/AJ/aiIT80FOs9MkNERJOtIuraDhClfAWd9Ff9/+
 IwZWmv25PnoIwJw+qwSQI32kdMgMy3bxaSXauR5fqx7NSIbWDPPOtxKSEQEQSGTPK0+Y
 oeO0BlOMDmX9EpQX/ZndGEP/Deuyt6olTSc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c4hebhtbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Nov 2021 11:24:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 4 Nov 2021 11:24:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SByJOVAVvwhktJBkQKuMkn4Xcnegy7nOTkpJV1mrqul9bGhnRKriPisG9bpaf7aG+3e3C7E8Xs8wZbGLSR0v+RyBUnvdU81hPd2+olLA7EpiHpW2g8HnZI2zndF6a6qD48rSeUL7AKiiP+qfQssBgVA07xPB8ORMr9PyXFwXCN7znykUY9SAJ7lmD25C9xltzx5dRPgu6D8xbSKxzlZc4A/WUtgeOhoDqT3YG4E8y8b+xtkQqG9xxQbP0qTylpg51+cblGHUHr1Kzg76Hl/s60YkkDuKlp8w9psvqWzQ3ROqMEtrYx9Gsw7dwW3xfx5vWJEtk6RRJj1hVaQ56zoCLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jqnrkv3vL1S1xN5dSPofILYKwZdtIYvSi94t003t38I=;
 b=VKe9MDOAYyg0DsNj9MxhW6ecZmlcPnHRa9KR5p59RI5Bea1BFY/Ew5P3FTjaFQxx/TRmxbwNvCpsz8E83pjfzAyqm+fuNOqFtHlcXqjzmkdGz3Q55O97ibbWGZWRzOSAJToV0tAj4/mNlRSG1gUoI/EIiC8jbs5TCPr8+lBDypa1532dxwPnsFWaWjAK24OMg7AV/5lpZP0HAfFCCvS4cwuJzQcJw/tlZLRI1tYE2SPQUZ5EZmVh2SX/YAN2VHNoTqNgj0wWFI7xg594iJyID4fbRo/ZCSHkJ/ifMW4CzZNUCmniocdb+ahu770qw5mIHbhO2tE7kb0+XemlcgPIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4644.namprd15.prod.outlook.com (2603:10b6:806:19f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 4 Nov
 2021 18:24:48 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 18:24:48 +0000
Message-ID: <0eaf7a8d-b90f-7a55-f589-c41aa17bbe27@fb.com>
Date:   Thu, 4 Nov 2021 11:24:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH] libbpf: Fix lookup_and_delete_elem_flags
Content-Language: en-US
To:     Mehrdad Arshad Rad <arshad.rad@gmail.com>, <bpf@vger.kernel.org>
References: <20211104171354.11072-1-arshad.rad@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211104171354.11072-1-arshad.rad@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0239.namprd04.prod.outlook.com
 (2603:10b6:303:87::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e8::1253] (2620:10d:c090:400::5:e407) by MW4PR04CA0239.namprd04.prod.outlook.com (2603:10b6:303:87::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 18:24:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfb5c6c7-6490-4e9f-4793-08d99fc0623d
X-MS-TrafficTypeDiagnostic: SA1PR15MB4644:
X-Microsoft-Antispam-PRVS: <SA1PR15MB464420C5658163945772900AD38D9@SA1PR15MB4644.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khhVj3uF+0Rz+iPcH3KZ66c/UFWT0XXb2FjxgNxfSN0Gf2+HRNL4InTkOIqHtYg+gWsfHZ9EpfU2rKoPRVpfbfbz96kNV3CBQjEn+dkT9lFeFCJCr55kyPUvGRWIjXruWqHqEZkxuaMT+EtxBl04qmMJHz/tGH5dzL2IuzEk2hPMD4ir2MNJhBBuGqKPT6bj98votwrQsM3teSsxs1qmWVdkZ3xcFq9C+vmfHx5AbiRSeJQwehvEetZjBwXzHjw4cUwGU+1FLOfoKiznjApQQ1dsaAQ8tPjUxvJ/UFnnqn9UEi4RwQPlUMqUs3UdL+rm15wuNdzc0UT+NB/LFqONcqf0Trn47faKaUZvXK7kK/4vlgBjliHGALroQRxwGbiMdqpakdsFdrT5x+ooQDTxR/13w4dnaYLVF1hdzpsWEgFIU+zJxGkThIymyb+ul+tPyQQH4QVRzPoy8z/lXxFyYjLF+kDR0dDpjv5j8944TcjXQlWTbLqvo9/u2k79aWGBZL5KJARQzOtA/i5R1rj8GvEXN2ZINF0gwOUzVYssydLL3yPTtkQ/5eriNQ+tyBFBuT29XZfL3Zs+XzlSuktttZ6YRuiPIk7+noox+WiSsSc0XD+95eSKFDmt4I0fq7RwoqcMCHk0ji/KKOiJsi5qUZBa0dLThThwT6cwIzbjLz1HiMlUcT7J8/w/FmEH4tdtmZtkRXj6Q3TA1opIoMqSAMRqrDVS2dGpHNinVyx0VIc0GV9TAjU1h6tpieCR5k6b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(31686004)(31696002)(86362001)(8676002)(52116002)(6486002)(8936002)(2906002)(83380400001)(36756003)(38100700002)(66556008)(508600001)(316002)(66946007)(5660300002)(53546011)(2616005)(558084003)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym1FUlZSNk1POWdaYXNuQ0hock8yMktYWVg3OVM0Y0pGSG5WelFGRE12Y2F0?=
 =?utf-8?B?MFRjSHpUUVFNSWpXQzlSc201ZnhPeVBoaHFTNXpXb1lTdmJDNlRmQ2tkUHFn?=
 =?utf-8?B?S2JIN2NjZnIzL0pFR0VRSHFjcEFQUGpGRDdDT2h6Wkl4UVFvY0NmalQ5VW50?=
 =?utf-8?B?M0thS0h5cFZzUDMrbnIrakdHTDJTYTlpYnQrYVlnMkNYaFJLa0V4R3JVQUV0?=
 =?utf-8?B?dWZ5V1VLd0JnTW1GcG5ZYjZaWUJtMEhWNzN0Ync0Rmd6TnVlSHlWZjBPNkhC?=
 =?utf-8?B?N0U1UUg5ckVRRlptS1JLSHZkQ0tIcXJRLzV0c090a1UxYzRnc3hMYmlHalRQ?=
 =?utf-8?B?MnpIRTdXOXVZekM3UG1SRUJJV1pVSFRaZXJiaUhsalRUdzY5UGhEOFhITjdY?=
 =?utf-8?B?NUhwcnJVYUg4VWFYZDZPc1QwYm52bm1ObnpzeGRiazByMGhuazEyUjRZZWMr?=
 =?utf-8?B?Q0pwL2E4WUhSTDVvcGR0YVNpb1hJK3RYaFpTek0yVTNEdnFnT20zNXpOZ3Zu?=
 =?utf-8?B?OVI2VHpBcXJISkhwSSs2SHg2c2EveTRrRWJlTGFFdDRnb1l0ejZOVnBEcHpC?=
 =?utf-8?B?UTFSQ1U0U00vS3Q5aFdBMzM5OVlYaWVBTW0rVU1RMzkySmI0Q3l2UU9NWkt1?=
 =?utf-8?B?bUJ4TEZjQ3VrYjhGN1AyVkRVODFZcWpSL3dDM1dScEhQV01DSVZTK2Y2UXVI?=
 =?utf-8?B?SVhZZmdDQ3JsSDdLZEFpVTc1cWxoU0ZPeEhNYVk1M0JqRHlaZm9JTzhrQ1Z4?=
 =?utf-8?B?NzNGbzIrbTViZFZqRTF1NFN6ZG9MdnFWcWxGODR6S2Vhb3AyeXQwR2t2ZjZa?=
 =?utf-8?B?VXpSSC9xM1oxeGMvd1ZVTmJoNW4zRHN6U3dkdWZtOWpZcmlrNHVKUVkxRzhZ?=
 =?utf-8?B?ZmNYQ0dGUXArUGxiMXdVQjJuNy83UXExNERHRUJ5NE9MQkpsTkZVa0FtYzBK?=
 =?utf-8?B?VXJidlpoU1NrbThEME9CREJtcmljRUdPd2VpNno1ZDhFR2czUDZOdTQ1OWZC?=
 =?utf-8?B?N3lRVjBzS1hGV2tSMmtSbll2NmZabDdOWU5Rd25qckZCd2hnbjlZS0x0S0dT?=
 =?utf-8?B?d29LZWc1NFZkK2F4N1BPdUtockJHem5iZVJUMDN3QUdOT0RONGFZdkthODl2?=
 =?utf-8?B?dTM0TEVpWm05WXB3MExsajdzUk1wQkNacHhBQU14ZFpXYUFJWU5Gajl2dE5B?=
 =?utf-8?B?L2Npd1pVNDZYZFBESHdMdUgvMkZYU2Jiak8yaVN0QkptU2RKV1k3c25lVnN0?=
 =?utf-8?B?bDRZME1rZS84ai9EWWk1NlJNalpOSDJMY2JLQncrZEtlNSsrVEVWYThmSmll?=
 =?utf-8?B?MkFmMUNvS3hISnExSy9QMVFsd3lKVmhrV2t5ZGkvVVhuNU8zN2FDc2NHWGhT?=
 =?utf-8?B?VVBGSmlkVCtaQTljOUYrUXAvWVYxVyttcHJ6V2NKTit0SDBVK3FwTmo1RWIw?=
 =?utf-8?B?bXQ5ZUs3VjdPWFYwQmZCL3lhcUNiSlhZN0ZsbDBXbHVweCtMY21wc2V0SWVO?=
 =?utf-8?B?TFRHblNqUjB3bnBGd2pubzlaMFFBUC9IUjVEMU5hUnpTSXVjZ2krQndKUjFo?=
 =?utf-8?B?Ny95dkd4Mm9GYnpraHRJS0p0TS9EMU56aWtESnZON0g2cjgvZHgxcjhyeFdu?=
 =?utf-8?B?SUFjaTFDbXh1MHUyYTIwMlVieTRydUdUK2N4Q05RYzRrVzNobWE4NTQ2Ny9W?=
 =?utf-8?B?UWtEelFWQVE2eE12VkY3QjNrT3dITUF0TXpZM3hENmQ2cVYwa1psUGhHQkht?=
 =?utf-8?B?OFNkcitFejNsZ1M1d0NPV2pEQ0hPcDBPc3lZeTBtUk9NZTd4T3czSlhDQXUw?=
 =?utf-8?B?cURKQkNEa0ZNNEEzVmlFeGdLU1pmOWxaUjJWakE5dVlrTTMrblAxVDZWRmcw?=
 =?utf-8?B?S1pIMlNHc1NLV09kY2U4Zmdzc1lDb0tjdktVQ1A5WTlpd3JLa1dmeVpMSTB4?=
 =?utf-8?B?RDBQK3hjUHZ4WitMMlhSVG9CSVJYcFduanBqU2FMZzg0aW5VSW85K25QU1Rt?=
 =?utf-8?B?N2Nwb1RqSnMwMENHRGE0ZHNHbnpVM0pWR2xQTFN3Q1lnTzB0SUNjdnp5dFdm?=
 =?utf-8?B?S2I3aVBKbG5aTVduSVp5dnk0MmNDeWJ2ZHlKUTRPWHhnRWo1Z21xRXZlKzBk?=
 =?utf-8?B?dkdmZ3FQa1M1Nno1MWRudFdzT2c5R3E5OUQvRG1vUEE1NC85TGJIMkJWbUY1?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb5c6c7-6490-4e9f-4793-08d99fc0623d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 18:24:48.1785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9utzOsWrYoV2oSmSmERyqqeSUOuSNfYM8em2O4tcrDceewVjWrbAs0d5hXG8OKl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4644
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: gL2W1kLqPN8gddqJGaN8v2Axrrz4PyfD
X-Proofpoint-ORIG-GUID: gL2W1kLqPN8gddqJGaN8v2Axrrz4PyfD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-04_06,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 adultscore=0 bulkscore=0 mlxlogscore=607 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111040071
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/4/21 10:13 AM, Mehrdad Arshad Rad wrote:
> Added libbpf_err_errno to bpf_map_lookup_and_delete_elem_flags
> 
> Signed-off-by: Mehrdad Arshad Rad <arshad.rad@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>
