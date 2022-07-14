Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7ECA575658
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 22:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiGNU2f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 16:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiGNU2e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 16:28:34 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C869130;
        Thu, 14 Jul 2022 13:28:32 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EKOcT1005810;
        Thu, 14 Jul 2022 13:28:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=R1fqD8NdYDIP/7qdQGOAUQJIMNyUOgqBmZgaTEw8CUk=;
 b=ALqwEaT833nYPneBe/hSCgRY8O9O87E0qAaf+zfJrcvxJs+/21+51quXzpPpOxMvZf7k
 cfUwtbSXDajXQ3pUhGQq2n1i5cnrQiierGpzfyUo4XFPz8SuE8hR/xkAql2787Pf6XQ1
 z9lpit9nHqgDpxhB9kLF0Pp+KUIKyKWtJ3M= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hat59r0tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 13:28:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LviofQIbkG+zBVcMvK15jBmJ8b3tXEdCCDetHsrx1EM97UrqjIo7/6jOFbtHpCioKK+xhv3yzbkhs1s3O8wf9KPtFOu9s7f0qoS/puTvH/1yvZkwOGB/+aSxVI3VZChC0m1d9B6hYc5C2v0n260sqcezou2yRt17nXeTQo90X6t7Z4PQVAX1ezHsmYvRq4YlwT1zg/YuMezrjfvnRb5k1sxEUHUVKhoRm6J6i7aQPfQz9R1y1ZMO60dXR0KEYx+oKgM4ohcaDgtANDWRsE7opPrDpY5raM7LiwPRMyeP9NsVeuD5xEb495n6YctPSojENVS5JQxvK0cB9RWGtHCcTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1fqD8NdYDIP/7qdQGOAUQJIMNyUOgqBmZgaTEw8CUk=;
 b=hzk8VOoIFu5w83+oDQLqofm+IHb3KdGo7EoyFOkJeHNu3egF9+YTvZpjd0zfIyJy0A66W69cV7L+KMCMNCuuhRDu7oXjMU/bzQ009sZZUelJSbsoXU45m36sUL2h975WLkWSb+9AsUbpD8tcFZ+bh7ab0oFCqU1b3mmKbOdwLaYIu3iaeiFWJ9L3maETiLBhPiEneuUQRdG2bjH/NvsF45ZgUmEeIPu0BpgTVqWwMyCHxzgT9L5op80D17+tVFOX9RXlh538eAl7LV8RomsF1hhRbYT60F0AYfI2ZvtVuNSN0+AHEMaEqy4nKvqR/cGfE14owgmAiMfGJCQYOi8fEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2312.namprd15.prod.outlook.com (2603:10b6:a02:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 20:28:28 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 20:28:28 +0000
Message-ID: <3aa0c96c-d42e-631b-5b4e-a5f67f0fc3e0@fb.com>
Date:   Thu, 14 Jul 2022 13:28:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] bpf: fix check against plain integer v 'NULL'
Content-Language: en-US
To:     Ben Dooks <ben.dooks@sifive.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20220714100322.260467-1-ben.dooks@sifive.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220714100322.260467-1-ben.dooks@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a3bef3b-01e9-4e3d-ac44-08da65d76908
X-MS-TrafficTypeDiagnostic: BYAPR15MB2312:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uHPoPD4JKebAj9j2IfOWXiTYm0UcGJeCHiqDEE0RYh5CK6kTTIhmxcNd8IFL7ZnD7FzGmUgw/MU9hnnaYS9qGaGdMT9BFW6vj2SB05wjUG1pzStRosY5KPn4Pqx8/OfosxwNm3loiY7xBqeAZ9fQ677olfAZggIBLbRXCnqgFpq7vFZDpHrzBLWWV+L+cDpX7HVcjdxYeC+uNnmeg7BPXz3/hnef5gZlynVvmiKW4Uc0b3SztdqjY1HdQpV3tVqhhLGKg8dUtwcglYoWwvp4CAOYEV0sVk//WHHad0yejbr8zWTUGm/iZABgO4ERpvsQgC3uQduqYn9EM880F34gqaeD0wkXdJiSWhcQwj6pzmmfQqGF0v/uCJvHKhhR7Ax389kSwPQ5SO6m/IydJRmsbL6X5QlEiQ0rQlJjNtMgfSribV29Wp1UPuJQUDkhmO9xvLbpd9SVlrtZm2UUeVB0ePR1otQcVFQtJ8dKQwk213RveoVfMI6ePq84LOaUL6sKbnxRXOPRqEYRj/Hc6PMpzEisGZNzjWdUUHCPrKmNpgjYswPG4MNDwgnRuCpxNFoLfXgAsqtXG5mdE69trKPcnsUSu6d3xf6PKaDLdHwOXOEvO8y21/HZk32uw7Zx/ZTQbMgG8vNMQAs+B0rlSwH9kvFKTXQ7vt/6qvdmH7SDROtVkGVPjIXGysTcFOgHDwb0Bcip384feQr2lB5oZ949jPQQITSDBcFxSM/sezJVlH4+45OCkCqknclBKEOjzayZ6UH7Ow30RcQMwdM3TQRyJDyoyCUtNeJbc6pbU2jovzosVXr4eO0wdoINrOeFo2afnQW5koJ/hRXHEXEpIYdCy4Ps5jWXxjiVdFbwDNtHGGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(31696002)(86362001)(36756003)(38100700002)(31686004)(83380400001)(186003)(2616005)(4744005)(6666004)(41300700001)(8936002)(5660300002)(53546011)(6506007)(478600001)(6486002)(6512007)(66946007)(4326008)(8676002)(66476007)(66556008)(54906003)(2906002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2hRR1ZPeWcvdzdlME5uR0c3NmFVeVhQWHNwQjByaDdrUHVMb2lGQjJzYVVJ?=
 =?utf-8?B?R1JORUw2MHBXUDNaQWVoNExXL2RNd0xJT3NwMlBtRmppMTE0b0gvSWJ2RmZB?=
 =?utf-8?B?SlRIenFtMCt1OXNBR1RqOHY0bGRURWZDTEl6dFJLZnZlSXFmcVFPZjhpZElJ?=
 =?utf-8?B?MXByaG5Yd21ETHJKZFhVcWlLQzVQeFdKcXlUZnY1eVhqMlV0ckJFVEF4aWI5?=
 =?utf-8?B?b1lJQWdWNXQ0WWR5MUdFL1dHa2p5Y3FweEJhb21EQ09oSXRxcWYzeTlTdUlL?=
 =?utf-8?B?ZHp3ZGh6alR4cGsrNWcyWE9NM2lDMlhRcWZ5SjhjWHd2K2FQa001TUU2U3px?=
 =?utf-8?B?emlhc294aUFFeHovYjRKUVEreEpKbGN6SnpxeVhkSnVKYWxDODNEamxXWm5s?=
 =?utf-8?B?T21IblZ4VDMvTGZvL0dvTkFQLzhRYlJQTERScVI5U0NzRVI1cWx3b2hxRXkw?=
 =?utf-8?B?c2pHRFczNFZTemd3aUpPaG1kUHFPT28wU1VxdENKMzNoaGR2ZTFnMWJueFNh?=
 =?utf-8?B?ZWN4OHhZWlZQdkxJRVE1dVorRlpmV25MTlFjRllrZjA2SUJDU2RIU2syTzRP?=
 =?utf-8?B?NE1qeS8yMzcwQk1ndXFUTURrM1dJYU5vWStBR1greEpMdXBYbnpTNzMzdjFm?=
 =?utf-8?B?dlF5dlFlSTZMSS9UT3l1Z2N6dlRIWWNKUGVKYTMxTFFLR3FPcStRdTBqcW9J?=
 =?utf-8?B?ZGkvOFR5ZjhveDNaYUx1VUlxWGU3Yk9WcGtkNzFMajF1NFJjVGd5V1c5T0c2?=
 =?utf-8?B?ZGR2THZtSk53cEhJMnc2ZlBiUU85NHZqV1Rja1pKNFZYZzVlNlJpWmY4czl5?=
 =?utf-8?B?V3ZNNTJ5dlZ1QTVUNXpPQy9tTGsvcEtUN3l1RmxvRW1sVHhTcTd2OGdzK2ha?=
 =?utf-8?B?bTF2YkNGSnE0dkNqNlFYcDRnSXJzTVNOWHhSQjVOU1RaNk1zYi9pRU9Vc2Qr?=
 =?utf-8?B?Vk5sNkJtbEpVOVRkWEJKMXpBWVdwbXdCUitJSDNsQjh4L0pkeDl4eUE1SUFq?=
 =?utf-8?B?NzYwaVBMblA0RG4wTlF5c2w0d2NKc1JxNi9XVFQvWkdTNDUxWXd6RnNKeXAx?=
 =?utf-8?B?b0tDb2Q5YzVEM1BxQ2kxNzQycWd0Zm1RU0xaUE56VFUxaFRlelJmeko1REJ3?=
 =?utf-8?B?OVFsT2g5ZFRCZHVadi91RWNtNVJDZjdTK2hXUkhZZ2pkUUcrZEdTcW1RdThN?=
 =?utf-8?B?ZmJiVGZvTVhrKzNneFdUSE1RcTUreFBXT0xSMis2QnRDL0g1MGcyMktqWUlM?=
 =?utf-8?B?dzhYcVh2QVpCeG1mUUNMVlhBWTdkajBnalQzVGxMeXFxS0VSUVVUcmZjMm9N?=
 =?utf-8?B?QmpmT2dXYzFJc0crcnZWRkhGT2ZxeEdPd1NCNGc4UVpWWldsTmo5UTgzQThS?=
 =?utf-8?B?VzVURnJqV1VxcGRWMkszZlAzaXRlaVJ2dVR0MlFKcllkK3JZeWt1eVU1aGZ4?=
 =?utf-8?B?S3lkMi9kL3FyNEVZQ093Zjl6UmU5ZkJQUVJqMnB6ZTMrSzdDUWoreTUwdGRJ?=
 =?utf-8?B?VDczZmxaZDd0aCs5cm1rSVNWcDBzeWdhQzJTYS9jWUJUYk1IV3JnVCtURThk?=
 =?utf-8?B?OWRTSTArTE51eHJnYUg3UXlidnN5YWRieTk0UXNqTWdhSHZUd0o2UUUzNE54?=
 =?utf-8?B?bm5FT2ZSS3k0WlI0MkRwSTg2bHY2WmttRWJtcHBKcHE4c3hOdlV1cEY1dE5o?=
 =?utf-8?B?endSZFBRSjd4eUZ1WXRzMFVaTSsrVGF1Y1ArdlRBV01XYnNNOXM4emQ0TlNG?=
 =?utf-8?B?U3JYRllRTEI4bDVqcHByaEswRllrUkhERTMxSG8yNnMxLzFtbTZ4ZVdEU1da?=
 =?utf-8?B?S3hsUTN6b2orRitzZGFjdWErT3A4YU9pdHQxYnBzc1B5c0FIUUp0QVpnekNW?=
 =?utf-8?B?SURkYzlKaHFQWFpxNEU4M0d0bjRhZWxxaHc5S2VBdURTSDRQa3pVUDhtUjZw?=
 =?utf-8?B?cStFdmR6WDdQaE1nSG1VVUV0dk9kVDRZUklscys4M1dyK0UvMUx6K3h4bG55?=
 =?utf-8?B?MERyeTFLamdYSkpmUHNHVkVwVmpHakN1M2M3OGtaZ1d3bGdMM1VsNGtPYnVJ?=
 =?utf-8?B?TW55azZRc0VXY0l0ZDloT2dxZG9aV0t0OUhNRENlYWtaMnVtR0E1K0tQOEVO?=
 =?utf-8?B?Rk15dGU0aEZNbEdMcEtmOHBBS2tQbnRWd0NMQWVvdDBHdkVKWm1nQ24wM3l5?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3bef3b-01e9-4e3d-ac44-08da65d76908
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 20:28:28.1990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PH2DP1YYkZMfqsV+GBjiU5vdJSsIgNirnzJ1k6WBB3ymh9DRSrmCBSk9JNa6NsMf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2312
X-Proofpoint-GUID: _Aojwhe6HoXsFw0umcIPr-a3SqvP3jIi
X-Proofpoint-ORIG-GUID: _Aojwhe6HoXsFw0umcIPr-a3SqvP3jIi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_17,2022-07-14_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/14/22 3:03 AM, Ben Dooks wrote:
> When checking with sparse, btf_show_type_value() is causing a
> warning about checking integer vs NULL when the macro is passed
> a pointer, due to the 'value != 0' check. Stop sparse complaining
> about any type-casting by adding a cast to the typeof(value).
> 
> This fixes the following sparse warnings:
> 
> kernel/bpf/btf.c:2579:17: warning: Using plain integer as NULL pointer
> kernel/bpf/btf.c:2581:17: warning: Using plain integer as NULL pointer
> kernel/bpf/btf.c:3407:17: warning: Using plain integer as NULL pointer
> kernel/bpf/btf.c:3758:9: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>

Acked-by: Yonghong Song <yhs@fb.com>
