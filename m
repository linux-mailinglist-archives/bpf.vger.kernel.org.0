Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A320D607F8C
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 22:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJUUNM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 16:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJUUNL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 16:13:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF39E2958DC;
        Fri, 21 Oct 2022 13:13:09 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LK3nHT010027;
        Fri, 21 Oct 2022 20:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Rpl8L0YWXfzTV7CHUJieWO5XQXaf6Dz4Fz6cN5b8iPA=;
 b=sEAJeIOUZF8cI9fvuH/PmOfY9YGLJZCeI0AsJVIVXQnb6+O5tmPsMwoJm9MP5pBabBqG
 G8oQ4z7vreLYX9RSJyq+f/VbzI5KxOUaH+Xj2lc1BQ5cUMoocdVg2YtTcAdI8wsyCWDe
 MQCjZ6szcThB7IvJQXoJ6A00helVXttP/UDPEZ5peMQIL9v/L5ZF7EuqJozCO7/Dmz9Q
 rV/XR+mTrDufVh88njxFBwwE6fCCdUFwZ/j7jdoktHlcSnxWG1u7qgasa0s+RwwGw5s7
 aupNmN1S+zgJkKxQFs2dfR+wBGDSO4vJg5DFBhemsi3ZXZmGcH1pQTZ/AvyBDXXg5zNr 8A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99ntp24r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 20:12:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29LJ0HuT027370;
        Fri, 21 Oct 2022 20:12:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8htkw71s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 20:12:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGwKC88lPinYY6ql2GiELn86fg/z4959snrkQcL9jWHPcpA1xR7emj82io5t0Pg50Od4EcCpz81g8dVh653Wz7RO0t1R60sQ0+WvgbmYzVhzc7bQtGNBh2aup20xQn7tuFeGBAEME921K/FeBiOdkkTuXsmVpzB4Bi1g8o+xi53+QlwjS0ueeQnvyNOxCoJ0APE5PV53+e4rxdTawvLESozXQhPFkm35txRsw8EE/cOH2PEz/2DCi4LQe03gyq17psnw2OZQoMwh0Q1CTW4RWWMMeKN77iBsywI/Bkd5k1XU+U6KN0w1qAWx6W94hcLd899cd7R8d17rVn6Xd+1xXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rpl8L0YWXfzTV7CHUJieWO5XQXaf6Dz4Fz6cN5b8iPA=;
 b=mRKx2RR0uGw1LBdLm5Wmlg6yvP744Qkbd/dKFSMy7V6NJ9DdHQ8MGEE4oydeHwhZUocqmO93f8dfDPq2VWKd1YUBhX7QhEsCOABpszaoLH+n0+bELQtMsukun7JWhZYZ5pvdSzYiHkS2XuhEoKTt6hI/plnwyWlnrArzi7P0WRUAWbAwWBz4giS6gZB24iES9E4aFvRYWeh7MHEstWs6U2IGsoa14Rn0f9s+Yc7TNK2/SfjoIZ8SaCFT/rxYq1WL04lSXr3XKpJqxsQ6+WA+hqOkRAjFuF0p/M4BqiHpVsAA7Z5ph7vmqkE5xjhQjgBBc9+2oLShCIjHGL21oUwiSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rpl8L0YWXfzTV7CHUJieWO5XQXaf6Dz4Fz6cN5b8iPA=;
 b=G0NOQQnYbqtAjpN4NvkShDnTNGngT68YxGRtM3ALyxmrywr/bPqVi6wYerXHONVTlnV+QPQ7Lrkz4tfM6rgEhdS8/ShdhsMhP4eaQZ9gB3SHFc5zkCbXcCYf/PiWaKOUKwpO5fDZkkrn6PN0PmVbuv7JzjUADkAXEqivI+xsIpE=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BY5PR10MB4337.namprd10.prod.outlook.com (2603:10b6:a03:201::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 21 Oct
 2022 20:12:50 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8e3c:584c:3f1a:7825]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8e3c:584c:3f1a:7825%5]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 20:12:50 +0000
Subject: Re: [PATCH dwarves] dwarves: zero-initialize struct cu in cu__new()
 to prevent incorrect BTF types
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, dwarves@vger.kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org
References: <1666364523-9648-1-git-send-email-alan.maguire@oracle.com>
 <Y1LJlPBQauNS/xkX@krava>
 <CAEf4BzbtRqkcx8CHBqdXXWmWLeX-zsrEYMy_CgL7i48PTYjCNg@mail.gmail.com>
 <Y1Lm1al9YEGbjd7i@kernel.org>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <7115a52b-5dda-614a-7285-0023ab22f95b@oracle.com>
Date:   Fri, 21 Oct 2022 21:12:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <Y1Lm1al9YEGbjd7i@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0616.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BY5PR10MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: 164bf015-9171-4632-eae8-08dab3a0a0e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2jpHLYN36j5CwaX6uOLAoxivFZxgKVBNclyYDIKOARe6vlzRdhAA51L+WK7F4KlLDVuNSgFvmncmBYjurC4v5zZ6VV6hS2vVrrkoX6MCf+g8X6bwqbbW7DeWhbeKGVJnWQ3lfdVPAzhM+xRvIhXopDypq0nysbjTSmj9ddhqWeOzI4GHeBcZjioyQNvXAnI5DmlZqBuWDtuapQ4y3YkXR/IFyDMmETJH0so8Eqhxqo+tkDE/h3fATUnKS/tGI2omERJRaXmNlcH3no0p/v2sfSv6XUpfW26JRUYUW56GLCgboM/DVqqOra7LIW5gCWYJ+26mI9pRMt/PG/Iq3DBCflizM9OHOgX8S85UTkBc3zJXpd1+VzOIuMf6pI7JoSQAWLx1zoEiLEhCIdw9Yh1jPQ4J7kuBBY9gfn3kragGqdNt2JSpmAs8qaHAlah+E0Rjfk7e+u/h3K4i+l8LzKtbPgMR7R3WW2OBbppC4LwhsK3V7TpZQ6EMU1uuxTxbu9e4Opn99MwnCR0Z6L6MqqtnQ5A36V4OX9jjevuTAinm2ndAmWTP0fR6/OVR0cJVvA+F9fYOC13tc/3f4hraEqlCH6rveM9y61k/a2myIyWyNVDBPXAqNabrUgBODroGCFbdVrK41PQ+5HvhmagsbgAC3EWeM3a8kwVxFdpq56XnfstNlllAGTfnw5qcNu3AhnqXkrr9fzsx9GXstq0A5ck5A/+KrO3NvV33KgUEUvezQinTEuqIdLT1No3kkrqclPUcoJfgWnxavqmnl82g9EdYIpjOW35JVMqJXFGSZUsxMiu9qCBps3cYmMUpurWVhea25kfwdR7Y6CzGnbBNOCxlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199015)(66946007)(31686004)(8676002)(110136005)(478600001)(316002)(53546011)(6506007)(6486002)(6666004)(4326008)(66476007)(66556008)(6512007)(8936002)(186003)(86362001)(5660300002)(44832011)(2616005)(2906002)(31696002)(36756003)(41300700001)(83380400001)(38100700002)(101420200003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXNyNXVXVW5tM1M2UHZXdTVLM3RHNXZhaWFSV3dHeWkwL1d2K0hTRlhQQy8z?=
 =?utf-8?B?ZnJ4b0xhbEF3N1hlNERwcmVaUEN1TFBiTDNMcjN1WElkbXNxZ0U5b3BWWjd6?=
 =?utf-8?B?WVVXMnhlS28vOWVZM1FqN3hxR3N4WE5hWG54TWhEeHA3V2d0Ulh3RTRiT0Vy?=
 =?utf-8?B?VnpaTFhnaVVPMlEyekpkR2pmdkpSWlN0RERSdGhwa1pvNnhCdk1lYXQ3NHoz?=
 =?utf-8?B?ejBPK2QwcWJsK21XK0p0VXhmNEdZdm9lTzN6b1VMWlpHNXMxWUViRSsyMlFC?=
 =?utf-8?B?aHNQSDRnQS9XZVV6UGtSeGhvK1NPVnM2dXBjRjBQVUdtTHNCN28zMFhwUjAr?=
 =?utf-8?B?WVN1dGVKSndhbVBFTjhCZ0FtSGJuTWNjV3VCSjJUbjJlRnZpSUtUNHE1Q2NP?=
 =?utf-8?B?aHlmUDlxcG0rMllrcVBQNHFzdUF4KzI3MW8zbzdKRHZvemdJT21WUnUyWVRP?=
 =?utf-8?B?T2pNb2ZvaGRhVG5CWDRZaUdJQU5HUWl4UWVncjRwSHdwaXorT1YyNk02T284?=
 =?utf-8?B?STNnemJTemw3a2Qwc20zTjRyeHplMy9xd3lna2FEZmpLZS9vcCs1QkJtVkcy?=
 =?utf-8?B?ckJyL2EvenlOV29wbVJXSE0xY0RPRGdGWi8yN1FicXRreVQyK0xOazNnK1hR?=
 =?utf-8?B?MzhVRzN2NnJYOFJqSHQ1eWVGYjZGQVl5R1lnVUJMMWd1clA1ZGthZnBQVC9x?=
 =?utf-8?B?L1lkQWVwWnZHQmZ4bTRhL1JwUjFhVHg1UHQwSUMzVkpBR0dUQmNEOXZZRlVK?=
 =?utf-8?B?R1FIL2gwOFhKdkJQOEs1bC9jNmFNd0g0VkxnN2VmUzZDd2NTS1FxZkZMNllR?=
 =?utf-8?B?eVpjS01RcHpmVDdRUG8vUnlibHB6UHZ1SDhyTTJqaDhyQVNwcjVvdjhGT0tj?=
 =?utf-8?B?YityS1BmaldYazZEVjd6OUJPYVZKRldyMEp0NCtsUnFJQUZiOWRMWXJUK2pD?=
 =?utf-8?B?dzMxcm1CMHkxNVN4VFdOcm5vV29lRUp4elZKeWtJc0V1Q1c2dHFzUkEyNnRY?=
 =?utf-8?B?QTZwRXh4anhKM05RbmdRVktpWnhrR1Zqbnk5amVXc1Q0eGxFWXZoUS8zYy9T?=
 =?utf-8?B?cTVCTU9kOExibGxPUVdUcVhUbGxMcTIyZHZLUTdBM3U3V08wbjlOa2pXZmFG?=
 =?utf-8?B?aTlzQnBVSnlrL1IzZSt5dEg5MCtPVS9WbjgyWW9FTXdjTkZIMVdkT05sVVpn?=
 =?utf-8?B?MHpaUCtxTDg5ODBlK0FQZmUxVDFuRHVOZHZxRmFtM3k1NWhaNUNEa3pyd0xj?=
 =?utf-8?B?S0I4cEhZalNwS1VMYlpkdzRFTW1FZEppTGtsMHA0U2FybG1kdlZmSzZ4Slp0?=
 =?utf-8?B?NVZ2ZW92TWJxbk93eW95eUZHbHplOFBmSXN4ZVdmd1dlN1BHcng4Q0xJYlFy?=
 =?utf-8?B?cDgzNVg4aHlsSVlncEhhZkRkYUlCUG9sUzMvVk1WOWN2aWtES254WVVpMXZ6?=
 =?utf-8?B?cnhrSzNQS2FrUGdsNkR1QjEwTTJ0OWdvY1BhUTJwb0oxN0YvTjZQYVlHb21k?=
 =?utf-8?B?VGxjb3BjU2kzZU4zTUE1KytISno5VUhHcjRrOW5wQ2Z3MmwyMzFmK0hCMUx4?=
 =?utf-8?B?bEdHbFJzZUFBenc3dkF3V3c3bkEvQUhmT0R1VzZVSFA2Y0ZUWVlKVlpmTHdN?=
 =?utf-8?B?elQ4SUxhV1MwTDlCY3hEeGZ5OEVxeXhwUGRNcUQyam9YQitkTWx4cUxoalA5?=
 =?utf-8?B?ODV4cTExaDc1K2VrazBIcStvOEc5UkFMUmFRQ012MVVTa3FNSzVEM1VPL3dL?=
 =?utf-8?B?b0hIdEprZTNPbHRkUTVpSld3allGMktGSmQxUmlWQXRNNWFHdjBJcEJRVDB2?=
 =?utf-8?B?dG9GU2ZwOHFFTEdvV1ovZlRPVHJWYlM1cEZVTXhDWW5HV21NMCs3NHc1dmR5?=
 =?utf-8?B?eTcxVzZuTWFuR3VzbXpQclNaUWdtTWREbW9YUk5PblVRNlV3eEhhTmV1SmtS?=
 =?utf-8?B?NnJOWlhkazdVYlhuY3FIQlpLY3V3YlBKNjRLb2FSOFJ5YzJWbE1GRHg2M1hO?=
 =?utf-8?B?Yk9HV3dXOHpyMklXVHZzVCtVSXFFSFpqVFNKajRJMXhqQ1JHL2lFSzlncko5?=
 =?utf-8?B?anhuMmYvZTUyWWp3YkNRV3dsSWVqa0ROTW1Gajl6cU8xM09BRDQ0VkwrRWRp?=
 =?utf-8?B?VGhyVjRSbGF4R25NcUFya3JSTDFKeFcyd0Zud3JlbitiVC9lMG9mVEpCOFhk?=
 =?utf-8?Q?grizQ4Q9LcW5BY5ZWZ1EE1w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164bf015-9171-4632-eae8-08dab3a0a0e3
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 20:12:50.3808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anhykVq5ec+MgV8MbTGCxm7poPdaQCAcMsvVmlwm1QGKYPTFwJQbh6NKVP6R9J+hH2/o75Bh0NChF2CFwgwLVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4337
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210118
X-Proofpoint-ORIG-GUID: UPvQsvW5PVpKIFG3sAyTWgFDDpi9cY3E
X-Proofpoint-GUID: UPvQsvW5PVpKIFG3sAyTWgFDDpi9cY3E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 21/10/2022 19:37, Arnaldo Carvalho de Melo wrote:
> Em Fri, Oct 21, 2022 at 09:35:50AM -0700, Andrii Nakryiko escreveu:
>> On Fri, Oct 21, 2022 at 9:32 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>>> On Fri, Oct 21, 2022 at 04:02:03PM +0100, Alan Maguire wrote:
>>>> BTF deduplication was throwing some strange results, where core kernel
>>>> data types were failing to deduplicate due to the return values
>>>> of function type members being void (0) instead of the actual type
>>>> (unsigned int).  An example of this can be seen below, where
>>>> "struct dst_ops" was failing to deduplicate between kernel and
>>>> module:
>>>>
>>>> struct dst_ops {
>>>>         short unsigned int family;
>>>>         unsigned int gc_thresh;
>>>>         int (*gc)(struct dst_ops *);
>>>>         struct dst_entry * (*check)(struct dst_entry *, __u32);
>>>>         unsigned int (*default_advmss)(const struct dst_entry *);
>>>>         unsigned int (*mtu)(const struct dst_entry *);
>>>> ...
>>>>
>>>> struct dst_ops___2 {
>>>>         short unsigned int family;
>>>>         unsigned int gc_thresh;
>>>>         int (*gc)(struct dst_ops___2 *);
>>>>         struct dst_entry___2 * (*check)(struct dst_entry___2 *, __u32);
>>>>         void (*default_advmss)(const struct dst_entry___2 *);
>>>>         void (*mtu)(const struct dst_entry___2 *);
>>>> ...
>>>>
>>>> This was seen with
>>>>
>>>> bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returning routines as void")
>>>>
>>>> ...which rewrites the return value as 0 (void) when it is marked
>>>> as matching DW_TAG_unspecified_type:
>>>>
>>>> static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t type_id_off, uint32_t tag_type)
>>>> {
>>>>        if (tag_type == 0)
>>>>                return 0;
>>>>
>>>>        if (encoder->cu->unspecified_type.tag && tag_type == encoder->cu->unspecified_type.type) {
>>>>                // No provision for encoding this, turn it into void.
>>>>                return 0;
>>>>        }
>>>>
>>>>        return type_id_off + tag_type;
>>>> }
>>>>
>>>> However the odd thing was that on further examination, the unspecified type
>>>> was not being set, so why was this logic being tripped?  Futher debugging
>>>> showed that the encoder->cu->unspecified_type.tag value was garbage, and
>>>> the type id happened to collide with "unsigned int"; as a result we
>>>> were replacing unsigned ints with void return values, and since this
>>>> was being done to function type members in structs, it triggered a
>>>> type mismatch which failed deduplication between kernel and module.
>>>>
>>>> The fix is simply to calloc() the cu in cu__new() instead.
>>>>
>>>> Fixes: bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returning routines as void")
>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>
>>> awesome, this fixes the missing dedup I was seeing
>>> with current pahole:
>>>
>>>         $ bpftool btf dump file ./vmlinux.test | grep "STRUCT 'task_struct'" | wc -l
>>>         69
>>>
>>> with this patch:
>>>
>>>         $ bpftool btf dump file ./vmlinux.test | grep "STRUCT 'task_struct'" | wc -l
>>>         1
>>>
>>
>> Nice and a great catch! I generally try to stick to calloc() in libbpf
>> exactly so I don't have to worry about stuff like this.
>>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>  
>>> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Thanks, applied, my bad, I just changed it to zalloc():
> 
> ⬢[acme@toolbox pahole]$ grep -A3 'zalloc(size_t' dutil.c
> void *zalloc(size_t size)
> {
>         return calloc(1, size);
> }
> ⬢[acme@toolbox pahole]$
> 
> That is used in many places, but unfortunately not on this specific case
> :-\
>

Thanks for the quick turnaround Arnaldo, and thanks Jiri and Andrii 
for taking a look!

For me, this fix alone didn't sort out all the dedup issues; when
testing with gcc9/11 I also saw dedup failures which resulted
in core kernel data structure duplication in modules that wasn't
a result of this issue (or fwd resolution issues).  It turned out to 
be due to identical struct definitions that weren't quite handled
by the existing identical struct matching logic. I'm on final approach
with a libbpf patch for that that works for me, but if it works for 
others too it might be worth resyncing the libbf version in dwarves
to pull it in once it lands, as it seems to make a big difference in 
dedup. 
Thanks!

Alan

> - Arnaldo
> 
> ⬢[acme@toolbox pahole]$ grep 'zalloc(' *.c
> btf_encoder.c:	struct btf_encoder *encoder = zalloc(sizeof(*encoder));
> btf_loader.c:	struct tag *tag = zalloc(size);
> btf_loader.c:		struct class_member *member = zalloc(sizeof(*member));
> btf_loader.c:	struct tag *tag = zalloc(sizeof(*tag));
> ctf_loader.c:	struct tag *tag = zalloc(size);
> ctf_loader.c:		struct class_member *member = zalloc(sizeof(*member));
> ctf_loader.c:		struct class_member *member = zalloc(sizeof(*member));
> ctf_loader.c:	struct tag *tag = zalloc(sizeof(*tag));
> dutil.c:void *zalloc(size_t size)
> dwarf_loader.c:	struct dwarf_cu *dwarf_cu = cu__zalloc(cu, sizeof(*dwarf_cu));
> dwarf_loader.c:	struct dwarf_tag *dtag = cu__zalloc(dcu->cu, (sizeof(*dtag) + (spec ? sizeof(dwarf_off_ref) : 0)));
> dwarf_loader.c:	struct tag *tag = cu__zalloc(dcu->cu, size);
> dwarf_loader.c:		struct type *new_typedef = cu__zalloc(cu, sizeof(*new_typedef));
> dwarf_loader.c:		recoded = cu__zalloc(cu, sizeof(*recoded));
> dwarf_loader.c:		struct base_type *new_bt = cu__zalloc(cu, sizeof(*new_bt));
> dwarf_loader.c:		struct type *new_enum = cu__zalloc(cu, sizeof(*new_enum));
> dwarf_loader.c:	annot = zalloc(sizeof(*annot));
> dwarf_loader.c:			dcu = zalloc(sizeof(*dcu));
> dwarves.c:static void *obstack_zalloc(struct obstack *obstack, size_t size)
> dwarves.c:void *cu__zalloc(struct cu *cu, size_t size)
> dwarves.c:		return obstack_zalloc(&cu->obstack, size);
> dwarves.c:	return zalloc(size);
> dwarves.c:	struct cu *cu = zalloc(sizeof(*cu) + build_id_len);
> elf_symtab.c:	struct elf_symtab *symtab = zalloc(sizeof(*symtab));
> libctf.c:	struct ctf *ctf = zalloc(sizeof(*ctf));
> pahole.c:	struct prototype *prototype = zalloc(sizeof(*prototype) + strlen(expression) + 1);
> ⬢[acme@toolbox pahole]$
> 
