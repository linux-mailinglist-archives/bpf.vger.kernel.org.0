Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC871616972
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 17:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiKBQmn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 12:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiKBQl5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 12:41:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1F52F3A3
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 09:36:49 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2GP055012296;
        Wed, 2 Nov 2022 16:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=JN8rVUIf5PGX0qe+nsLE0kXKjbMPnwoJlyawBfyw63Q=;
 b=bPR3CP7d88Sqdd7vLSuukw7UHgWz5ptXYaLiTjepA5qn8Jp4aqA7MF6rPDbYIKEYS14K
 bSR8qlU6kj4AOT7x5Z1ulAEhN7bH/EdRQmIJq2ElA/1AVMn4isyJMuMaHGQ9PgK0cnlI
 28iDjzdETnxoikNDJPyPpTTjcT1q6gx/Y9etTQ4gWnphe2EW3zNV1Nm12XG9EQsce5eQ
 q2Nvy4NOBlO7OMAqaPAx6i1mD/4s1Az0D5lY87rqcvqmCGtGLop9ufow8CVv98wJ53yy
 KHy9uUgrLYEikK8wYrsOsOg9QKptpc/8lFy6/OPyE/Ta/KQRTTrCvRWe8kYShkIabG9w aA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgtkd9v6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 16:36:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2FwhSA012081;
        Wed, 2 Nov 2022 16:36:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmc1rg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 16:36:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNbo36oPAjjPsCaATxc9zis9CGP1YyJleeIPEAGlMccTPA0Uf4JB+49Jw/dWNq11RGm1bE/vK4HgBrD2jswLhJx7KVXCV3E/LesXcwwU0U3ORzge+ZZA4QNGMnDFMpp12oFPbvvuSmxH8/QnKQzDdEbAuG0bjt73HdeCPNMS9Kk3ysWPCcZO5JqGn/zDxQdquc4snP4FW5v2pg4TpYju6L8IdN5YLONdCXct+hq8oo/CjaDojkCCOn9IGq9lLrkJ7gkfrbiQwRo/BuzM+/6Tr1BD2k0mBn9rr7AzHqG+SINx4o/N6pG4p2aIz4GWZG5kZq0U49TlBGRmEwPk1TYgpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JN8rVUIf5PGX0qe+nsLE0kXKjbMPnwoJlyawBfyw63Q=;
 b=MQ5kRRnP0CwuA+x01EPn3YztIsxoGwHu8sP/z+ojv8Y2yznq0MH2cLHvfxvjNAjGs8DTzEwTC5QgVqAG3Sr1IfaX1WETod/LpRjZP2uAyzfHIVDbjUC5WdMgyjmvEca9PvKvyz+GDB47Qr9yyoKodxP59znn6yts3Zqsj5cze/9LG9/pCt2FSCinDl9kYRYRAew2v+8/MG3M9f44Fe0WiH8PeJsPpzC1aY4xw97r+A8kCjfp521jnI7gnN4lMKJvBbD0mfpHDeWb+JHaub+FAgqoxt3acfvIheMpwYQwcCC16gcS3mZacnQ+OH3glmzHy2Nb6oJKH3F3dFN3q2cHrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN8rVUIf5PGX0qe+nsLE0kXKjbMPnwoJlyawBfyw63Q=;
 b=o89DhOtjVKccjSU5uDROaEG/0xS59MS9z0p1WsYRQLjtRRUNAUUFkmRn4TzMRuby4535cJKJ4qWAEBZE38D5MiF+aXRcEkCtZ7BoWoF5IBF81MTBUNAzwTN5P0yrGS3aeczystvp+A0/XTvzaqwjen4BO+6xONXusKrsHU1/+1c=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY8PR10MB6907.namprd10.prod.outlook.com (2603:10b6:930:86::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Wed, 2 Nov
 2022 16:36:27 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::46dc:29f:ee11:711]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::46dc:29f:ee11:711%7]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 16:36:27 +0000
Subject: Re: [PATCH bpf-next 3/4] libbpf: Resolve unambigous forward
 declarations
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com
References: <20221102110905.2433622-1-eddyz87@gmail.com>
 <20221102110905.2433622-4-eddyz87@gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <a3d3aa04-0247-e073-ebde-6c8f3d8abdf0@oracle.com>
Date:   Wed, 2 Nov 2022 16:36:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20221102110905.2433622-4-eddyz87@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY8PR10MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 17878495-aff6-491b-59dd-08dabcf0634d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVAhQH2t47p3gFOWeQuH1WTRQlNYoDfpU4nuCi7xMfYlfrxAGk8F3HruWnzaRbUGN35v5/RIOdqou+ZMZvLnTuIM7CJs+VFtdcUlhMVA9nDLbGwsLaF4qmGKThsrQ3SvHB3fWAcFs8/FR97S2aztKcjyzcSzY/73yniWJ3ch54a0GJXA7xZTs9Z8r40P01BURDKnp3yQ9RFVhuEoIY07iwYLk86MyNEmZ24hNYTo/qzgjxnPTPl2n1aPQFaZ9XfT4M+xOXu5W4MU6j0EnCNQD5j6J94eBrqHTgdLQdpzM7dbhXnB1TUcbc6dqADR2nqRtry2X3c2KSAJi4CEK85RWgR77k1FMHHyzQ+8iHe1Bjg/htg7VSnNfq0a2C0Wiz3k03ZR6nzU6YSck4GKpiGynnD8QDtzVDqOIQmeLG2hPZMy/Ni4mFRmgq4TcsrKmtjH2Q5pY0CgmI2lwvKeV+xBesm7jhrliNYfWdHJJZCgYRw44jrtQYB4q85UwEzr8LjfQxNxq8W7J/VZW5DyHhqR15387TfCKN6AMC3tJehhXo9wYmDpPhcS9wSKf0T/8VDJxED29wbAjR73RVbBHbxMq1Rp6W2j+FU+tEqsxdI90wVI79KAMDRlFfiXF/haVvimZL4JF3k6TYJkm3YI8sDk+HhZJxD7ghrgOFe9LMHf3a+yy8NThnWdHZ4LpIKY3cgWt9MuH6OH05u/elspyGe14lHdlMF2VuSpLNw4hzxF+JLJm5ULdIhupbCOxFbWc6XDmOpj8xDjrn9zNwMa/2qLTA3B3Co72tOxMf3oUVyjKYE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199015)(31686004)(83380400001)(186003)(41300700001)(8936002)(44832011)(66899015)(5660300002)(38100700002)(36756003)(66476007)(4326008)(2906002)(66556008)(2616005)(8676002)(6666004)(316002)(6506007)(31696002)(478600001)(86362001)(66946007)(53546011)(6486002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3NrcnBtYjNpd0J6RjdkL1BSL25YWmlLU2xVSEpyc0hFVGRRdW5qajhYZk8y?=
 =?utf-8?B?cnpWVkkxbGdIa1BtZUFQOC9Oa3pjb09Ka2xNcmdGNWFILyt4QlhiZVRWUUNU?=
 =?utf-8?B?ekc2Q0NIL0JNWURINnBjUEtqTWdURUUwUGdBYm1uajhsVk94Y05TSjVPUDJ5?=
 =?utf-8?B?MkE3c1UrRHVxa2h4NHczTC9jT3owNFdZVTBzNUpoR3dnUFRKVkFHSktGVHov?=
 =?utf-8?B?T0RpdHdrdGticGN3Rkxwczk1Q21wY3NibmFNbVhialNpSW1Gdk1iNU9KSlZy?=
 =?utf-8?B?OFgwZG9rTlkyQlNyYXFzVktyQ1YxZ1M1V1VYTm5McWRraTFYRkFuSmU5K1hT?=
 =?utf-8?B?amcxSy91OWtLU2J0MzlZNzZVaFBrQ2tuczFvNkRYY1V1Y0ZHVlNJYkF5K2lw?=
 =?utf-8?B?c0VFQjJUQS9NVXExS3N3OE1HV1pEbTYweFFucTdyK2tRbndQWGUvRGZpWk1z?=
 =?utf-8?B?Qmo2ZFpNalNpYUxueUdtNG4wTUorMG9raWE4alNIZ2hHeEoyR0lyMXN3ejc0?=
 =?utf-8?B?Yk1RK0VTNnBlT0pyRDladHlpTlYzYXU5TjV3VzQrM0p5RHp3UmVCN0Z5UTZE?=
 =?utf-8?B?SWlFUzVEUCs4cGx6Qk9sNzYwTWVGSHdwZ3M2Qi9vT3ZHOVd3KzcydjNsU0xq?=
 =?utf-8?B?RmtOQWx1ZUoxUytKaTJ3WkF0Q001TXd6RWJLWjJ0bVltVThwLzhiV0pFd2ow?=
 =?utf-8?B?YWVHVE1xYjVXSC9UL0xnSG1rUlNOcVNLemczM0lnMEhVdEdOVVFjRGRKb3hi?=
 =?utf-8?B?ckxrR1hBUmI1V0c5UlJTY1lYMm8wdlBGa0dROWUvVXVpd3BYNFR3eGRPblVW?=
 =?utf-8?B?YlpHaHd0ZWJYRHd2Q1NDUDhEdms4OWtkb0JmUGpONTRIbW1MWHp3Y21kUUhN?=
 =?utf-8?B?NWtIY3dWOXQ1TVcrRDM0VDVQdEtwUlJ1VkhnQ2txeC9yL2VqQ1Qwa2JsbGJT?=
 =?utf-8?B?NFQweDhQNDhiN3VuY2lCVElkMHFTK3ZrclgrWFpFbGxCK3ZCN01NbHMxVTVm?=
 =?utf-8?B?dnhVTldSUFhxN3JRQzZsZU1jK2NxQkNOdGZETkF1NHVBUGtwcXdEYXRuUUp4?=
 =?utf-8?B?T0VLSmFCSUN3WkFpUisyRmkxZkFNbVduWHE2S1dYZWlUOEptUTVWdXdhNFN5?=
 =?utf-8?B?YXhHZjJ0UXAyMDQxKzJTMDZzYUhKaS93KzRPSFhyNVRWV0xwLzBCQU9kOGFu?=
 =?utf-8?B?b1lkRVRjQlcvSENwOENhTVNxb2tzQkJsZ1E3bVlnUEpRaU5ZVUdMd0xVbi9J?=
 =?utf-8?B?OCtqOHV6WXZLQ3JwcEt0Q0FHS0tkNk8rWUV6V2lxNEdSOWt0enVuTFhZc0NG?=
 =?utf-8?B?b01TSFlvMjFlWVRrWnNUb1duZUMvdTFqeGl6MUhRb3VIVHJ5YWlkNS8vaDRP?=
 =?utf-8?B?MXR6Q2ZiRDFoaG50QVErZXFxQ1ZXenpaWmsxRUxVNC82ODlwYm5BMjB2RDBB?=
 =?utf-8?B?RHMva205UUc2M0h2cElzaHoxQnpYWnpOVk1wRFRxcjhNaHgxRW1lTmdhZ0Fk?=
 =?utf-8?B?RTBFZkZkd29xc3JDR3p2N3MrcFpHNkVWbUtEZy8renNJdGNvbnhZcDV1bzVL?=
 =?utf-8?B?YnUrMzRpYkh2UHFBSU5SdG1Jb2RqbEN0YXRyd2ZtdWVzSE1oT2wxSDlWeGRF?=
 =?utf-8?B?QjJBV1NpdVU1WnNpcllJV1V0M2s0QU5UK3RlY2prWHRzZ0Rla3hKUUFrN04v?=
 =?utf-8?B?aWcyNDcwNXpocm16azZHZmpSRmxjRUw4UCtCdVRUNjlvamZkNXd6QmF3MTRY?=
 =?utf-8?B?d2svNVQ3YTZNYnFCZU51QUl5bnhzMHlIb1lMRUxPa1hnVi9PME52VG1yVFF6?=
 =?utf-8?B?ajN6Rm9jaWVBY2VqRU5PbTNQOEZ2RE4vdHBROCtJTjN4L1h2Y3ZJTkJUSkFJ?=
 =?utf-8?B?M1V0MHpsMjFCUTBPL3Z2enJic3FuYVI0cnk2SitZWnJ3Tm1Ja1JOb3NqV25t?=
 =?utf-8?B?RTNUSFhUazVXTFR5T0xwMSt2NHY0OEhSMkErVUNjYmxtZ0ZqV0pLbXMrNWhK?=
 =?utf-8?B?YlNDYmcreW9PV3NubnBxNlpUQ0tyWG1mRzZvWStuY29td2lOZGgyQ005c0Vw?=
 =?utf-8?B?WjcycUVtcU4vNlpZY01ucXlMVUVyMTFMYjZKWjY2M2thamo1RVlNSklBZWYv?=
 =?utf-8?B?RkJwaE14NGxtdlptMzRVbDhRcFJ2bzB6OCs0SUc5dFNST1UxYjdBT09TVHhu?=
 =?utf-8?Q?1mm9C0zjGN6cxXdxUqcb7UY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17878495-aff6-491b-59dd-08dabcf0634d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:36:27.1626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdQKunUqPOX/D7dCng5wl2rlsnmXBa9lI6rbmpg2ax/C3sRNTGhvGGGFFzTBsx4wvSbgZfkJDCt4xs9W7wXYnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6907
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_13,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211020108
X-Proofpoint-ORIG-GUID: NZYXnC7Yc8c-W9oZz-QYGtQavhbuhydT
X-Proofpoint-GUID: NZYXnC7Yc8c-W9oZz-QYGtQavhbuhydT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/11/2022 11:09, Eduard Zingerman wrote:
> Resolve forward declarations that don't take part in type graphs
> comparisons if declaration name is unambiguous. Example:
> 
> CU #1:
> 
> struct foo;              // standalone forward declaration
> struct foo *some_global;
> 
> CU #2:
> 
> struct foo { int x; };
> struct foo *another_global;
> 
> The `struct foo` from CU #1 is not a part of any definition that is
> compared against another definition while `btf_dedup_struct_types`
> processes structural types. The the BTF after `btf_dedup_struct_types`
> the BTF looks as follows:
> 
> [1] STRUCT 'foo' size=4 vlen=1 ...
> [2] INT 'int' size=4 ...
> [3] PTR '(anon)' type_id=1
> [4] FWD 'foo' fwd_kind=struct
> [5] PTR '(anon)' type_id=4
> 
> This commit adds a new pass `btf_dedup_resolve_fwds`, that maps such
> forward declarations to structs or unions with identical name in case
> if the name is not ambiguous.
> 
> The pass is positioned before `btf_dedup_ref_types` so that types
> [3] and [5] could be merged as a same type after [1] and [4] are merged.
> The final result for the example above looks as follows:
> 
> [1] STRUCT 'foo' size=4 vlen=1
> 	'x' type_id=2 bits_offset=0
> [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> [3] PTR '(anon)' type_id=1
> 
> For defconfig kernel with BTF enabled this removes 63 forward
> declarations. Examples of removed declarations: `pt_regs`, `in6_addr`.
> The running time of `btf__dedup` function is increased by about 3%.
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

A few small things below, but looks great!

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/lib/bpf/btf.c | 140 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 136 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 04db202aac3d..d2f994d30af7 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -2881,6 +2881,7 @@ static int btf_dedup_strings(struct btf_dedup *d);
>  static int btf_dedup_prim_types(struct btf_dedup *d);
>  static int btf_dedup_struct_types(struct btf_dedup *d);
>  static int btf_dedup_ref_types(struct btf_dedup *d);
> +static int btf_dedup_resolve_fwds(struct btf_dedup *d);
>  static int btf_dedup_compact_types(struct btf_dedup *d);
>  static int btf_dedup_remap_types(struct btf_dedup *d);
>  
> @@ -2988,15 +2989,16 @@ static int btf_dedup_remap_types(struct btf_dedup *d);
>   * Algorithm summary
>   * =================
>   *
> - * Algorithm completes its work in 6 separate passes:
> + * Algorithm completes its work in 7 separate passes:
>   *
>   * 1. Strings deduplication.
>   * 2. Primitive types deduplication (int, enum, fwd).
>   * 3. Struct/union types deduplication.
> - * 4. Reference types deduplication (pointers, typedefs, arrays, funcs, func
> + * 4. Resolve unambiguous forward declarations.
> + * 5. Reference types deduplication (pointers, typedefs, arrays, funcs, func
>   *    protos, and const/volatile/restrict modifiers).
> - * 5. Types compaction.
> - * 6. Types remapping.
> + * 6. Types compaction.
> + * 7. Types remapping.
>   *
>   * Algorithm determines canonical type descriptor, which is a single
>   * representative type for each truly unique type. This canonical type is the
> @@ -3060,6 +3062,11 @@ int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts)
>  		pr_debug("btf_dedup_struct_types failed:%d\n", err);
>  		goto done;
>  	}
> +	err = btf_dedup_resolve_fwds(d);
> +	if (err < 0) {
> +		pr_debug("btf_dedup_resolve_fwds failed:%d\n", err);
> +		goto done;
> +	}
>  	err = btf_dedup_ref_types(d);
>  	if (err < 0) {
>  		pr_debug("btf_dedup_ref_types failed:%d\n", err);
> @@ -4526,6 +4533,131 @@ static int btf_dedup_ref_types(struct btf_dedup *d)
>  	return 0;
>  }
>  
> +/*
> + * Collect a map from type names to type ids for all canonical structs
> + * and unions. If the same name is shared by several canonical types
> + * use a special value 0 to indicate this fact.
> + */
> +static int btf_dedup_fill_unique_names_map(struct btf_dedup *d, struct hashmap *names_map)
> +{
> +	__u32 nr_types = btf__type_cnt(d->btf);
> +	struct btf_type *t;
> +	__u32 type_id;
> +	__u16 kind;
> +	int err;
> +
> +	/*
> +	 * Iterate over base and split module ids in order to get all
> +	 * available structs in the map.
> +	 */
> +	for (type_id = 1; type_id < nr_types; ++type_id) {
> +		t = btf_type_by_id(d->btf, type_id);
> +		kind = btf_kind(t);
> +
> +		if (kind != BTF_KIND_STRUCT && kind != BTF_KIND_UNION)
> +			continue;
> +
> +		/* Skip non-canonical types */
> +		if (type_id != d->map[type_id])
> +			continue;
> +
> +		err = hashmap__add(names_map, t->name_off, type_id);
> +		if (err == -EEXIST)
> +			err = hashmap__set(names_map, t->name_off, 0, NULL, NULL);
> +> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int btf_dedup_resolve_fwd(struct btf_dedup *d, struct hashmap *names_map, __u32 type_id)
> +{
> +	struct btf_type *t = btf_type_by_id(d->btf, type_id);
> +	enum btf_fwd_kind fwd_kind = btf_kflag(t);
> +	__u16 cand_kind, kind = btf_kind(t);
> +	struct btf_type *cand_t;
> +	uintptr_t cand_id = 0;
> +
> +	if (kind != BTF_KIND_FWD)
> +		return 0;
> +
> +	/* Skip if this FWD already has a mapping */
> +	if (type_id != d->map[type_id])
> +		return 0;
> +
> +	hashmap__find(names_map, t->name_off, &cand_id);

would it be safer to do 

	if (!hashmap__find(names_map, t->name_off, &cand_id))
		return 0;
	
> +	if (!cand_id)
> +		return 0;
> +

...and might be no harm to reiterate the special meaning of 0 here (multiple
name matches -> ambiguous) since it's a valid type id (void) in other cases.
While strictly you probably don't need separate conditions for not found
and found ambiguous name, it might read a bit easier and more consistently
with other users of hashmap__find().

> +	cand_t = btf_type_by_id(d->btf, cand_id);
> +	cand_kind = btf_kind(cand_t);
> +	if (!(cand_kind == BTF_KIND_STRUCT && fwd_kind == BTF_FWD_STRUCT) &&
> +	    !(cand_kind == BTF_KIND_UNION && fwd_kind == BTF_FWD_UNION))
> +		return 0;
> +

I'd find

	if ((cand_id == BTF_KIND_STRUCT && fwd_kind != BTF_FWD_STRUCT) ||
	    (cand_id == BTF_KIND_UNION && fwd_kind != BTF_FWD_UNION))

...a bit easier to parse, but again not a big deal.

> +	d->map[type_id] = cand_id;
> +
> +	return 0;
> +}
> +
> +/*
> + * Resolve unambiguous forward declarations.
> + *
> + * The lion's share of all FWD declarations is resolved during
> + * `btf_dedup_struct_types` phase when different type graphs are
> + * compared against each other. However, if in some compilation unit a
> + * FWD declaration is not a part of a type graph compared against
> + * another type graph that declaration's canonical type would not be
> + * changed. Example:
> + *
> + * CU #1:
> + *
> + * struct foo;
> + * struct foo *some_global;
> + *
> + * CU #2:
> + *
> + * struct foo { int u; };
> + * struct foo *another_global;
> + *
> + * After `btf_dedup_struct_types` the BTF looks as follows:
> + *
> + * [1] STRUCT 'foo' size=4 vlen=1 ...
> + * [2] INT 'int' size=4 ...
> + * [3] PTR '(anon)' type_id=1
> + * [4] FWD 'foo' fwd_kind=struct
> + * [5] PTR '(anon)' type_id=4
> + *
> + * This pass assumes that such FWD declarations should be mapped to
> + * structs or unions with identical name in case if the name is not
> + * ambiguous.
> + */
> +static int btf_dedup_resolve_fwds(struct btf_dedup *d)
> +{
> +	int i, err;
> +	struct hashmap *names_map =
> +		hashmap__new(btf_dedup_identity_hash_fn, btf_dedup_equal_fn, NULL);
> +
> +	if (!names_map)
> +		return -ENOMEM;
> +
> +	err = btf_dedup_fill_unique_names_map(d, names_map);
> +	if (err < 0)
> +		goto exit;
> +
> +	for (i = 0; i < d->btf->nr_types; i++) {
> +		err = btf_dedup_resolve_fwd(d, names_map, d->btf->start_id + i);
> +		if (err < 0)
> +			goto exit;

could just break; here I suppose

> +	}
> +
> +exit:
> +	hashmap__free(names_map);
> +	return err;
> +}
> +
>  /*
>   * Compact types.
>   *
> 
