Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D286169B0
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 17:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiKBQtl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 12:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiKBQt1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 12:49:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0530619003
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 09:47:44 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2GOqTO011177;
        Wed, 2 Nov 2022 16:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7DwbOp0/IxZh0nXInvYoW8uJ1ga8ox1tNkddvbxAuXQ=;
 b=V7Nx5zc5ntUbTfXpJG4Z8Z70pYiGPItQiJ0Vw4TBX8fJN0O/uM0Y/3QkONYqkj2rynw6
 0XgAZoICFVWuTp0+R6YNvc+jtKa5o7avGQZTQq+CJ403T4cODW0iKQdW2LF10ei+jGcF
 i3I7D+a0sSDmTe3HG+e3PHStTpKoHkpNDcrrlnYJXhYr8x9UKdKw2kEeoMdDlcQXcymq
 B5Zn9QrYZCELMYIMeUkwlLWjwyouAO+ebz91eRyKU4hIKaOJeCeN3TXSq5jzGm0H+Eix
 Lb0cGZiguBoAFHHjPU1zC4BP+lczChXK/QER07ktuLgIol1oFXxgLMtLXdU+PryIhAOS bA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgty32c1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 16:47:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2G0UTu009749;
        Wed, 2 Nov 2022 16:47:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmbt5v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 16:47:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7JXKxcZ8URFRK9ZeZnDe00FZ5gzSMpXKT4dsjL64VRgu7I8v9YOSGrsBdDoIokNpv4NPQv9BhPv1r5fzFH8rQW7myk/fE7SkF/qk/swk/QHpMPjQwWlRlJ3jWyii01Bvjfw8GcR/MYkqIwjsDck55FvsQHeapvIoFs6DDal0MMKHr+pXiqre3rAXcMYM9QTfDoY7kl1VQAdr+JcdysfNMlrxGlVWgSnGJ8jLH6F0f4PoaSheJWYqvFTLc1agarJLXmiaSG18L+xonyxVaLLXOpgxbnoTy4A6KQ1acAVCEVmuSY9/LsLn8ag7beRDgaQe4JvriwpOeVxdFtE0rme1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DwbOp0/IxZh0nXInvYoW8uJ1ga8ox1tNkddvbxAuXQ=;
 b=mBunQ1lYJxz1n0xCFrp/3f+QwRIKPUc/1RPZN0+3ZF3SreWZOCJbJcEQxZpeK1mXs7GxE2OFnoKo9hIaBkW68TZaLljZR7Anee/iOc2IcisDzXXauZcaUV9ip3WRerbjCLX80saz7XBbdIIPXB2YZbS9oFuIPEr6YGv7HWNwh+lOqohJo5zXIEuPXyVKI0NGMi+TsXZEeAvL5OrA/DrBltC9QwCiqady2RaYlLJrkfvtctHg7gFCFmnE/q9RaJvo0APOPk1dAj1dYvdiwiCgFIJ8CQxCw7KGVLcYb8Wunp4op/q3iuOSF6QDMTmYWCKRmZtlyOaQ9GY15/inl+5Tnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DwbOp0/IxZh0nXInvYoW8uJ1ga8ox1tNkddvbxAuXQ=;
 b=WovSiiGEOySiBUfvz+2BkrR9XT9e2kh4fuhUIFnyLeM4JZRrYaEksb9kbyp5AfD2xlFlkbFktD3FaVHPZIX1yw4slMxtvCPZxmXbzWnCqnbi+0YfTJ/+XyGZO2O76t+L6Nojcm1IsNyWno10ke/XFUeOwv/BEdO0wnEZRjcZg9Q=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN2PR10MB4350.namprd10.prod.outlook.com (2603:10b6:208:1da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 16:47:21 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::46dc:29f:ee11:711]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::46dc:29f:ee11:711%7]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 16:47:21 +0000
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Tests for
 btf_dedup_resolve_fwds
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com
References: <20221102110905.2433622-1-eddyz87@gmail.com>
 <20221102110905.2433622-5-eddyz87@gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <5f8a9914-e6c2-1ebc-3f7c-f8d706cdd7ad@oracle.com>
Date:   Wed, 2 Nov 2022 16:47:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20221102110905.2433622-5-eddyz87@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0023.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN2PR10MB4350:EE_
X-MS-Office365-Filtering-Correlation-Id: 77da1018-a73e-495d-6964-08dabcf1e929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TWmrVG0axVtnNw0McO2uKlR3fbch4KYBc90Tzo8P8E4oNJJ25vPDT2bh2EY75jbuC8zy6r70gXd1cOyC4mDqjZP182/0fTHEUSNIJ+IYt9CkPGQRiI56r7PqcmgmhQeM42bk6w6xUKrTvDO76TQiWmiXhaz26GFkl5qUblkYgbUea2ArO56JAs5qUc9CnEPH60ABF735zw1BKC+AxpdFk4Kmmh60w8XTYWSlSqy4UhGXT3lYl421kvXYQk/+eQ2Ec09j72rBTswJjjTqDytesLMq1Vw5RdeVVk777YeU/lsVKjO4sJWsOggLV1ywwb6xgGQsWFhcbJUTyA3mZ2SB8VbIJYHbdDhNvcBQbOxv1TG7JKQEsvjN/MMh6e7TwF5FCFhg7ULeG/bWEZd5OfgqyTy7Mzws2vU1414iRnyNehxS1Ge+JM7was5s2HBafskszV+QjWmL8MKt/alM47IdmojorrLE2oQpIbh5DdUxGzUEAXF7bj2GTRn26tIhEIqL20IaXd/EamBj1IvDmaFCH0Qx9XdmYfXIURZOke/yt4UtSvCq/SvQq7BJH41m+PsGQr8ANPHZ9D1KkjU3hpohwuqFJ5vBtWdAseZkioR3pXUYWL8QVQXss6K+sAIGo2lectcFrvCNNWR+dMcK0armXeAAnz2POi+eDHjIU1zX10OpPLtj7+DWMzi9igm8xD8eHFHI5sq+CIdsEZNNdis4oi/+UUwx/VvwSfmKVsAJwnlNDxxxnYne/UKyZ1r0R4Nz/2JIrJ8HiSGxIu5Nh+LnQquuGGjp968O8b+KAuhsYwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199015)(31686004)(2906002)(83380400001)(186003)(86362001)(53546011)(36756003)(31696002)(8936002)(41300700001)(6506007)(6512007)(6666004)(38100700002)(5660300002)(44832011)(66946007)(4326008)(2616005)(316002)(66556008)(66476007)(6486002)(8676002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjRjTmJMSENtbG5KTHpxaytzTnJaaHR6L21oS3N1cFg5ekRQdHNEOEVLVjVV?=
 =?utf-8?B?S1NKSTdqdlJmOGt6V29PMlBHMDVScmM2UzNWNU1xU3krUlc0UXkrK2ZFNTJ0?=
 =?utf-8?B?dEVzbzkyeUVwYVFWYlNVY0ptNVVSdVRmRDEzelpvMjhRQTB6QlVURGU5eEt0?=
 =?utf-8?B?dnZoUnF2VmFIQ2FTbUU3VTkwMmNsNGd5dXlDS0FXQlA1VXlyQWVRZmVPcUxn?=
 =?utf-8?B?cTA3S0daTmFNN0huVnpaUERiMlQrQVVGRzE0QkdoUUtiYTFwaGQ1V0tXTW5v?=
 =?utf-8?B?c09QeE9QTUZpdDhCQ0Z6b2NZU0lpS2svN3NtNlJBVG9acURBNjBjVUtOVDRP?=
 =?utf-8?B?bEsyNTNXTVVsSy9WSi9mWVpKN3lhNzdJVndVdlZVNEJUK3lRUjhOdDRkVFFG?=
 =?utf-8?B?a3p2SThpekxPbVVKUTlCR3ZMUWEzV3A1NlpTcm9xSHBsTzc5YXpzc0daaGJS?=
 =?utf-8?B?bGplZkxReGpPQVdqWVc2S2ZEQVFHUFRhSlRqRjZnUldOajUyVG9LRVp6NkUr?=
 =?utf-8?B?blZJMFBXdm5TUjY5VjVUMVcrSVRxazd5SWhRcERSVUoyQ1Y5RzJnYWJ2SFFX?=
 =?utf-8?B?SENZYXZmb01UZUk4SWFiNFFWclBTVmJaeW5RTWJlMUE5WnhWZGQ2bk95RHFw?=
 =?utf-8?B?ZmZQSFJyZWJIem9UbUdLelRYdGwrNzVBMWxUSnFkQkFqa0owMW95cnZtRGU4?=
 =?utf-8?B?d29scmJJa2VsYXh0ZnRpSUduYUkzdW92UmZrcFZwaEltbEVMcFdVWUl4ZHlD?=
 =?utf-8?B?ZzBxekhxZnQ4ZlF6bCtVeDJuNlFVekM2T0hFKzJDaXlqaisxMUpQdW5oU2wr?=
 =?utf-8?B?KzhDVTBYZlVNcjFsK2J2dnh4SnMyakRwcGtGZTdXOFRya3FKUis3NHcweHVT?=
 =?utf-8?B?czh0Y2RkcllGeVlYdmkzYUhSdjJPTmlvVmZJYWR5WDE4eHl0MXZuMU96SWVH?=
 =?utf-8?B?bkIrVFdkNE5RM1hRaEx2VXZXZm5PR1ZYdlE1NVc0dThpcTVuT09YNFBhSDU0?=
 =?utf-8?B?cFhKTS93c09QekNMSkZDWmJrSEFEN0NQTnkzYWhTb24vUWo4OHQwV1M2MGxx?=
 =?utf-8?B?S3JaempCQXZpMDF2ZktyVHV6TmhRenhPbWJHb21QbTNLdXRkMzFBTENvTlRX?=
 =?utf-8?B?cmd6SDYyK0VvME9USnZNVnlsQm5nZzUwN3h0dTFjQWFZb3czRzJMWHg0VWh4?=
 =?utf-8?B?MmVsNkFJNzBsNWEvNVdrMlI5YU1MbEJ5Uk9hVVdNcHdXb1pMQ1FhTnQ5MkE1?=
 =?utf-8?B?RDB6cFcxYzRhOXE4elBnV1pHaWxqUTNyV1BtaVk3ZUk5QXoxbW5YRW50M2Vm?=
 =?utf-8?B?YWR4ek1IV1FTMVJORFNlNkkwNGk3b1NMYWN0QkNMN0g4Q3hwU2FjWWUxamgv?=
 =?utf-8?B?ak5iZXhzdjhaOVFkZWsrRzZxMkU1ZFpmc1R1bkZla29oNENBVU12R3RGZ1Nm?=
 =?utf-8?B?UUJvOWRJSzBpRWlrajJsV1FpV05qMVpNTGFYV3hNRS9zOFgxZ1Y0Q3lWU1Zl?=
 =?utf-8?B?TFcxZFRqVGNxSnRTcjJFbllBQTVsajRMa3YweXpGRzkxVTBuaEREaW94ZzY2?=
 =?utf-8?B?cjlmVXhZMEJNOWRtZ016MXVaYi94ajlTMHhOUlVEVmVVazBBbDcrYithT3Iz?=
 =?utf-8?B?S3lLUEt6WllyNzRRSTVybGJYdGZFa3haRFJsbmF0YVRtUjRESE5ROFVqZVIx?=
 =?utf-8?B?QTI1L3Y5bVVpbGxRRWtZSk1IMTRJUEVzclNRNENYWmtOSXBqYVFEZU9vTHJy?=
 =?utf-8?B?Kzk3cGtOUmxiUWZ5b0o2VGxlVkhCcDFYTGpXN2xWY0ExNkFYeVNSVHN6UkFB?=
 =?utf-8?B?VFlYRERPT3k1VmZBN1dPYzBhWWtndXNzTzFRMXFha3QxYWZnV2RDR2RydjRi?=
 =?utf-8?B?ckM0dW5GbFNtYUtrZ2pKSkNXdkx6UWNxQ1hmazFOcGtsRTQ4bi9Rd1AxSEMw?=
 =?utf-8?B?Z3dzQi80UDZhQmMxbE56djJLSlo0a3E3OHp3LzhOWCtQcm9vTmJGRHBpMFBU?=
 =?utf-8?B?L3lFeXRGTTZaa01uQSszWXdMSlhYYjRvYy8vZVRId1RjN1FSakxoMVdidDNV?=
 =?utf-8?B?bWh0aEhDbVRYblhkbjNxM2xvQjBYeW1yNDQ4ZmtoYThhdjFyVmVVeTcvb04r?=
 =?utf-8?B?blUwQVF2NDJCTHh6bFFiMWEreGoyMDBGOUt3dHo2S0VkK0hnUmFSSzhTTmM2?=
 =?utf-8?Q?RFcm2Q3DiU5JxbxgqdjgDSM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77da1018-a73e-495d-6964-08dabcf1e929
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:47:21.3559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqOCGUgkOKq7pDM7+2HRMtKYDN/QGuZb/2K7TvXKhm7OX6VhCdBtMBspLS5tqa+frLgeTiNCLYYbfFV0SgsVtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4350
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_13,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211020109
X-Proofpoint-ORIG-GUID: WPOVlG-jnoyK3T-tTGp9BGp_DwawTk0E
X-Proofpoint-GUID: WPOVlG-jnoyK3T-tTGp9BGp_DwawTk0E
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
> Tests to verify the following behavior of `btf_dedup_resolve_fwds`:
> - remapping for struct forward declarations;
> - remapping for union forward declarations;
> - no remapping if forward declaration kind does not match similarly
>   named struct or union declaration;
> - no remapping if forward declaration name is ambiguous;
> - base ids are considered for fwd resolution in split btf scenario.
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Really nice having positive and negative tests here!

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/btf.c  | 152 ++++++++++++++++++
>  .../bpf/prog_tests/btf_dedup_split.c          |  45 ++++--
>  2 files changed, 182 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
> index 127b8caa3dc1..f14020d51ab9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -7598,6 +7598,158 @@ static struct btf_dedup_test dedup_tests[] = {
>  		BTF_STR_SEC("\0e1\0e1_val"),
>  	},
>  },
> +{
> +	.descr = "dedup: standalone fwd declaration struct",
> +	/*
> +	 * // CU 1:
> +	 * struct foo { int x; };
> +	 * struct foo *a;
> +	 *
> +	 * // CU 2:
> +	 * struct foo;
> +	 * struct foo *b;
> +	 */
> +	.input = {
> +		.raw_types = {
> +			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
> +			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> +			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
> +			BTF_PTR_ENC(1),                                /* [3] */
> +			BTF_FWD_ENC(NAME_TBD, 0),                      /* [4] */
> +			BTF_PTR_ENC(4),                                /* [5] */
> +			BTF_END_RAW,
> +		},
> +		BTF_STR_SEC("\0foo\0x"),
> +	},
> +	.expect = {
> +		.raw_types = {
> +			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
> +			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> +			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
> +			BTF_PTR_ENC(1),                                /* [3] */
> +			BTF_END_RAW,
> +		},
> +		BTF_STR_SEC("\0foo\0x"),
> +	},
> +},
> +{
> +	.descr = "dedup: standalone fwd declaration union",
> +	/*
> +	 * // CU 1:
> +	 * union foo { int x; };
> +	 * union foo *another_global;
> +	 *
> +	 * // CU 2:
> +	 * union foo;
> +	 * union foo *some_global;
> +	 */
> +	.input = {
> +		.raw_types = {
> +			BTF_UNION_ENC(NAME_NTH(1), 1, 4),              /* [1] */
> +			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> +			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
> +			BTF_PTR_ENC(1),                                /* [3] */
> +			BTF_FWD_ENC(NAME_TBD, 1),                      /* [4] */
> +			BTF_PTR_ENC(4),                                /* [5] */
> +			BTF_END_RAW,
> +		},
> +		BTF_STR_SEC("\0foo\0x"),
> +	},
> +	.expect = {
> +		.raw_types = {
> +			BTF_UNION_ENC(NAME_NTH(1), 1, 4),              /* [1] */
> +			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> +			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
> +			BTF_PTR_ENC(1),                                /* [3] */
> +			BTF_END_RAW,
> +		},
> +		BTF_STR_SEC("\0foo\0x"),
> +	},
> +},
> +{
> +	.descr = "dedup: standalone fwd declaration wrong kind",
> +	/*
> +	 * // CU 1:
> +	 * struct foo { int x; };
> +	 * struct foo *b;
> +	 *
> +	 * // CU 2:
> +	 * union foo;
> +	 * union foo *a;
> +	 */
> +	.input = {
> +		.raw_types = {
> +			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
> +			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> +			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
> +			BTF_PTR_ENC(1),                                /* [3] */
> +			BTF_FWD_ENC(NAME_TBD, 1),                      /* [4] */
> +			BTF_PTR_ENC(4),                                /* [5] */
> +			BTF_END_RAW,
> +		},
> +		BTF_STR_SEC("\0foo\0x"),
> +	},
> +	.expect = {
> +		.raw_types = {
> +			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
> +			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> +			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
> +			BTF_PTR_ENC(1),                                /* [3] */
> +			BTF_FWD_ENC(NAME_TBD, 1),                      /* [4] */
> +			BTF_PTR_ENC(4),                                /* [5] */
> +			BTF_END_RAW,
> +		},
> +		BTF_STR_SEC("\0foo\0x"),
> +	},
> +},
> +{
> +	.descr = "dedup: standalone fwd declaration name conflict",
> +	/*
> +	 * // CU 1:
> +	 * struct foo { int x; };
> +	 * struct foo *a;
> +	 *
> +	 * // CU 2:
> +	 * struct foo;
> +	 * struct foo *b;
> +	 *
> +	 * // CU 3:
> +	 * struct foo { int x; int y; };
> +	 * struct foo *c;
> +	 */
> +	.input = {
> +		.raw_types = {
> +			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
> +			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> +			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
> +			BTF_PTR_ENC(1),                                /* [3] */
> +			BTF_FWD_ENC(NAME_TBD, 0),                      /* [4] */
> +			BTF_PTR_ENC(4),                                /* [5] */
> +			BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),             /* [6] */
> +			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> +			BTF_MEMBER_ENC(NAME_NTH(3), 2, 0),
> +			BTF_PTR_ENC(6),                                /* [7] */
> +			BTF_END_RAW,
> +		},
> +		BTF_STR_SEC("\0foo\0x\0y"),
> +	},
> +	.expect = {
> +		.raw_types = {
> +			BTF_STRUCT_ENC(NAME_NTH(1), 1, 4),             /* [1] */
> +			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> +			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4), /* [2] */
> +			BTF_PTR_ENC(1),                                /* [3] */
> +			BTF_FWD_ENC(NAME_TBD, 0),                      /* [4] */
> +			BTF_PTR_ENC(4),                                /* [5] */
> +			BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),             /* [6] */
> +			BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
> +			BTF_MEMBER_ENC(NAME_NTH(3), 2, 0),
> +			BTF_PTR_ENC(6),                                /* [7] */
> +			BTF_END_RAW,
> +		},
> +		BTF_STR_SEC("\0foo\0x\0y"),
> +	},
> +},
>  
>  };
>  
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
> index 90aac437576d..d9024c7a892a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
> @@ -141,6 +141,10 @@ static void test_split_fwd_resolve() {
>  	btf__add_field(btf1, "f2", 3, 64, 0);		/*      struct s2 *f2; */
>  							/* } */
>  	btf__add_struct(btf1, "s2", 4);			/* [5] struct s2 { */
> +	btf__add_field(btf1, "f1", 1, 0, 0);		/*      int f1; */
> +							/* } */
> +	/* keep this not a part of type the graph to test btf_dedup_resolve_fwds */
> +	btf__add_struct(btf1, "s3", 4);                 /* [6] struct s3 { */
>  	btf__add_field(btf1, "f1", 1, 0, 0);		/*      int f1; */
>  							/* } */
>  
> @@ -153,20 +157,24 @@ static void test_split_fwd_resolve() {
>  		"\t'f1' type_id=2 bits_offset=0\n"
>  		"\t'f2' type_id=3 bits_offset=64",
>  		"[5] STRUCT 's2' size=4 vlen=1\n"
> +		"\t'f1' type_id=1 bits_offset=0",
> +		"[6] STRUCT 's3' size=4 vlen=1\n"
>  		"\t'f1' type_id=1 bits_offset=0");
>  
>  	btf2 = btf__new_empty_split(btf1);
>  	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
>  		goto cleanup;
>  
> -	btf__add_int(btf2, "int", 4, BTF_INT_SIGNED);	/* [6] int */
> -	btf__add_ptr(btf2, 10);				/* [7] ptr to struct s1 */
> -	btf__add_fwd(btf2, "s2", BTF_FWD_STRUCT);	/* [8] fwd for struct s2 */
> -	btf__add_ptr(btf2, 8);				/* [9] ptr to fwd struct s2 */
> -	btf__add_struct(btf2, "s1", 16);		/* [10] struct s1 { */
> -	btf__add_field(btf2, "f1", 7, 0, 0);		/*      struct s1 *f1; */
> -	btf__add_field(btf2, "f2", 9, 64, 0);		/*      struct s2 *f2; */
> +	btf__add_int(btf2, "int", 4, BTF_INT_SIGNED);	/* [7] int */
> +	btf__add_ptr(btf2, 11);				/* [8] ptr to struct s1 */
> +	btf__add_fwd(btf2, "s2", BTF_FWD_STRUCT);	/* [9] fwd for struct s2 */
> +	btf__add_ptr(btf2, 9);				/* [10] ptr to fwd struct s2 */
> +	btf__add_struct(btf2, "s1", 16);		/* [11] struct s1 { */
> +	btf__add_field(btf2, "f1", 8, 0, 0);		/*      struct s1 *f1; */
> +	btf__add_field(btf2, "f2", 10, 64, 0);		/*      struct s2 *f2; */
>  							/* } */
> +	btf__add_fwd(btf2, "s3", BTF_FWD_STRUCT);	/* [12] fwd for struct s3 */
> +	btf__add_ptr(btf2, 12);				/* [13] ptr to struct s1 */
>  
>  	VALIDATE_RAW_BTF(
>  		btf2,
> @@ -178,13 +186,17 @@ static void test_split_fwd_resolve() {
>  		"\t'f2' type_id=3 bits_offset=64",
>  		"[5] STRUCT 's2' size=4 vlen=1\n"
>  		"\t'f1' type_id=1 bits_offset=0",
> -		"[6] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
> -		"[7] PTR '(anon)' type_id=10",
> -		"[8] FWD 's2' fwd_kind=struct",
> -		"[9] PTR '(anon)' type_id=8",
> -		"[10] STRUCT 's1' size=16 vlen=2\n"
> -		"\t'f1' type_id=7 bits_offset=0\n"
> -		"\t'f2' type_id=9 bits_offset=64");
> +		"[6] STRUCT 's3' size=4 vlen=1\n"
> +		"\t'f1' type_id=1 bits_offset=0",
> +		"[7] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
> +		"[8] PTR '(anon)' type_id=11",
> +		"[9] FWD 's2' fwd_kind=struct",
> +		"[10] PTR '(anon)' type_id=9",
> +		"[11] STRUCT 's1' size=16 vlen=2\n"
> +		"\t'f1' type_id=8 bits_offset=0\n"
> +		"\t'f2' type_id=10 bits_offset=64",
> +		"[12] FWD 's3' fwd_kind=struct",
> +		"[13] PTR '(anon)' type_id=12");
>  
>  	err = btf__dedup(btf2, NULL);
>  	if (!ASSERT_OK(err, "btf_dedup"))
> @@ -199,7 +211,10 @@ static void test_split_fwd_resolve() {
>  		"\t'f1' type_id=2 bits_offset=0\n"
>  		"\t'f2' type_id=3 bits_offset=64",
>  		"[5] STRUCT 's2' size=4 vlen=1\n"
> -		"\t'f1' type_id=1 bits_offset=0");
> +		"\t'f1' type_id=1 bits_offset=0",
> +		"[6] STRUCT 's3' size=4 vlen=1\n"
> +		"\t'f1' type_id=1 bits_offset=0",
> +		"[7] PTR '(anon)' type_id=6");
>  
>  cleanup:
>  	btf__free(btf2);
> 
