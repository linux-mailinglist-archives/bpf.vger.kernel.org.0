Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A2A6EA075
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 02:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjDUAJX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 20:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjDUAJW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 20:09:22 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A310344A2
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 17:09:21 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KNp1Pt010110;
        Thu, 20 Apr 2023 17:09:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=imcl6rCBPjzhZpg8P7IEm6aJSNDkTY4mJDfM7J+2NKM=;
 b=m9q99oBr9KhVj98OG5eJ10v9OKFyhgYTu523dMfjHKm3zfCM2C48rcfqf5qA+9k8QVC/
 pGmoHi3jvVlCCHRzLHEnpYnqOfQkNKFEttrKnlx7JpboXzAOt8w3IuxxZfgpSyUMfkiY
 tYscVSewATtoDPJgAyWRE+kEap5TUshmjBxI7r22e3SKCBY32Rj91aiLZfMgOdrPA6jA
 jNIr+FNm84D8VGp0qAgeZ8KE3bOM3yjgTeaHIA7GzEI1xuSthV8E+b0g7efUXjPKCe21
 k0xpHWSagWS7t0ivI/2+VEWww90AGE5sRe9ONKUEsBxX4Ke/KOCoe9byzHiFDVzkQwaS 8A== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q34en4dve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 17:09:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DK4jsUnYfe5W3wSwpd8jJRDeGwbcuJNhTQYygbEK+9EhgrFPFVMyMGAMhB15s6jabuc5DvDkJVOw9jbC17TUKrZAnCYfF5d6e3CkHJSMIiVr75/cJU0gF/4kj9FOFb6cif4bQ32HtuhrrQv6wJfZqr1miVxOmd0oiGSalYF0zSBy5WNqF3gEABXz38d3eH7J1Jfjdbjcb9DmIWTU4sAFB2qWSxcE5vkK/vqvKeVNXr3F6/FUNaGXj6p06ckJvFhXp9IAWNICunEVvalAao/KlWpOvXf9qoHEH/DLxPsgruCpjV1R9cU/ukxl+SxTlWvOz2g3eU6V8ov87s0gBat3EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imcl6rCBPjzhZpg8P7IEm6aJSNDkTY4mJDfM7J+2NKM=;
 b=cQlshRUSh+TujKwVsxUeLcKKe+rIDF0+cTxlDWvYt2IzM9iQVUwL+Jv8rDbGfkrzml1FV1mweJ9RvMMzy+Iv09rcLtqDGU5jGQQzL49oK6aXNOspkDQxEMBgfVTsWFksyA3/gX3ucFgX0lxGOFiIJV+lyJpBxu0g80NKplKJd3MrlCmC6GRSICxBqqfwW83uOu9naIW72atbjIJJHdyPHH6wMz1VDPSchcfGHdfC+IlDQiPTKLg9P8nzyfxniM/CuIrrEJ8G6X1GPKa0nFAqDrkQySRjJ+k092NZczxuBJVY/amf3dKy7bXieVCbE6gpw8fD//yYp05bnG2W+dQ8Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by CO1PR15MB4828.namprd15.prod.outlook.com (2603:10b6:303:ff::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 00:09:13 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::c787:379d:2ce8:e19d]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::c787:379d:2ce8:e19d%6]) with mapi id 15.20.6319.020; Fri, 21 Apr 2023
 00:09:13 +0000
Message-ID: <2e59bc15-17dd-c055-2e07-71c1c0507ee6@meta.com>
Date:   Thu, 20 Apr 2023 20:09:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: bpf-next hang+kasan uaf refcount acquire splat when running
 test_progs
Content-Language: en-US
To:     Eduard Zingerman <eddyz87@gmail.com>,
        Florian Westphal <fw@strlen.de>
Cc:     bpf@vger.kernel.org, Dave Marchevsky <davemarchevsky@fb.com>
References: <ZEEp+j22imoN6rn9@strlen.de>
 <8c669c50ac494b9618e913f2e4096d5bdd8e2ee0.camel@gmail.com>
 <20230420125252.GA12121@breakpoint.cc>
 <7e38a7462b76a23b67dbf62e068f3cd1727bd7b8.camel@gmail.com>
 <f4c4aee644425842ee6aa8edf1da68f0a8260e7c.camel@gmail.com>
 <167cbaa496d047803f3d7cf14e13abe2deffb147.camel@gmail.com>
 <3c239d87-5163-bc3f-cc2c-a963494f0971@meta.com>
 <10bc6b3fa19e26c0b78718367cc45d7f021da868.camel@gmail.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <10bc6b3fa19e26c0b78718367cc45d7f021da868.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: BL0PR02CA0094.namprd02.prod.outlook.com
 (2603:10b6:208:51::35) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|CO1PR15MB4828:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff5e29c-1b5a-49e6-63a9-08db41fca353
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fgYWICMWArFSfRj36YyDw2zlOKfrfOOEBntk9/V7Ji51SQW3Wx9BjYCdkHOlB/IrOnQGW2bHCKsdnIY968DqTkKCQaqF/oX6UZx/8LHLtc6gTWjpl7Botbsszr70SjXKq3ZgdOMK7igYDGUYGehJrey02j8ziDZS3OBFkO/1PuoRe+KJN7IHIX2xNa1Ltfpj47t5l4mezyVPYCNE3wf0A1vv5Hu1aySureoWWQzhRErBYFgvwt/Y5pBANYRWBWKFubuVmD0tULdD22OQe08khxG5YE+RIDHHES3q89Jq8YF+by/uKmqzGBMBOFYBrC3Hw2Q9J37Y2iUWbdDuM7Uerg6qAY6rq20siU4KvbCCvZ+5KqC4CeV402X0RKey9zKuMOK9S4eAaL93aSnIlbleddWJcu7pzsVZDl1+FxfBGaHUPHPpcfjZDOOMgLRHoh/TK3K/aiOcmJFshsz7jpPJVYJje5GRS+QbpwwMtdQlhSOs6ZvMAlJn3Mza4E+MMKyNV8OadOJvALmpGirVF6NLmy21IwLvL7qXsTxPn7PLy4+7hOWEQj74Wzc2C6LTiJguaVQ0uuYGFJxk4iGGE1Ma5q7Km2pJ39+GNixGmdVIGXs8n8CzYyykWAklBjns64getJh1ai9bk3nrFe4dJe+zRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199021)(186003)(6506007)(6512007)(53546011)(6486002)(4744005)(966005)(5660300002)(41300700001)(2616005)(4326008)(66476007)(8936002)(66946007)(8676002)(66556008)(38100700002)(110136005)(478600001)(2906002)(316002)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUV1TUNVUzV2OTU2RmVjaXYyTU1FTytHQW9zTTg2UWxjZW0zZGpWQTRNV0NW?=
 =?utf-8?B?aHJESm0xQ2JNZnI5aktiSGpuRzhiN0JLZUxQbWNLTStQamNYVDJ3cXVRWUxr?=
 =?utf-8?B?cFp1bHpFTG9mbGxJKys3NWpqUzNVSWU5Ymx1M1h2K2pNcVlzWjgzK0MrbStK?=
 =?utf-8?B?QjVFaE1sSzRjN3Y2Tmc1TWlvemxId0NhNk9idjA2aFBSV0IydnJQcmNpbVpr?=
 =?utf-8?B?T1Q3TVVCRlNyZXgzT2tQRDhsdUQ5S2JZczIxT0ZWNkhiUVNkQzJQMDA4RXNp?=
 =?utf-8?B?eTA1cGNORjZKM1YvSWVoRzUrT0JRM3NuUExTODc0UjhqY0NuTkRjd1pyb3Fi?=
 =?utf-8?B?clRsMU4vTUV1Zmlkb25oT21BVjczZGhwUW5mM1pvTExCZlU1T3oxcjk5enRh?=
 =?utf-8?B?UFh4cHZZSFA0aWpYWmxnLzhTS3J6a0tNY1Z5Q2cxVVJaNDZrMWh1YmZFZlJB?=
 =?utf-8?B?bE5PR0t3THZ1RUUzbmdBSkZWTmMwSXFoS0hNc0tsNWw0YnNzYko1TERCMGVy?=
 =?utf-8?B?WWVla2dmTlJOTnVuT05jcStCVk9odDlBZzRjSGhYN3VSYW9tTko5aWdVTksy?=
 =?utf-8?B?RmcxKzM3ZDdldW54U00wRmFVWElOVTkvSktWMmEreVhxOUs2WU43aDE0N2dR?=
 =?utf-8?B?U2pKSGY3d3NmcktCRWljYVhXdElEeGE2dW9laXo2VjV5ZnF1aGpMM25BUThx?=
 =?utf-8?B?OTRIK0YvWE5ZMmhaQkxMYXdOUDRNYTI5bzFjcGQzaEJrYWJ0S1F4SksxSVkx?=
 =?utf-8?B?MURzRkowb0MxSHVzZjNVZTY1UFBVd01tNVFLd0lwQkdBNHRXR292bk1ZN3R3?=
 =?utf-8?B?Vy9VdUR4RjdKUjlIMHpwYTFFVk9tbzZKaFZxb2pQbXRjWldZRVRYdEk4U1c4?=
 =?utf-8?B?aWdtWjlQMG95ZXNXN3pnWjJaaDRNNEdqdWVySlVGWXJ3dFhsYnNJd0xmdUR1?=
 =?utf-8?B?dHF2TkdvcTRRUW1CYTIvSDRqRFJTemVJaWpaa1lGK3VmUWdiNk4zaTJsUTQ2?=
 =?utf-8?B?REFzNTd3emJOeTJ0bmVYVkgyVGN0LzErNklHSXRXREVwWjFUcG5Qb0ZaOHF3?=
 =?utf-8?B?b0wrUGVkSC94SG41dzhleVpKTUNHRHl0SXphQVhIM2lmeWZ4UmpFd1NmQ1d1?=
 =?utf-8?B?UG5MRzVFZmxWQThnek52U3RHR3ptSkFNSzBnMER6Sm1Wci9JN2h0c1p5NGp2?=
 =?utf-8?B?dTdHaDZmMkdEOUVrS3NRZEJxNU5zdzRzU0habTJaZzJyekhsOU9zWnhBdEE2?=
 =?utf-8?B?clBLWHRJY0ZFeEgrYWNXaTZVT3YyQWh2b1gxL3dZV25OcnFaRWRielRSdGdr?=
 =?utf-8?B?SEJySEo2NVpIWUp3cnpRMVl6Mmx1dytYd3dQelM3bGxUSGtKS3VneWd6MUNW?=
 =?utf-8?B?clByS3BOZEJ5c2RxVmsvUjZLR3pzbk5INytiVWlaSTFVajk0dzl0eFBRbU1h?=
 =?utf-8?B?VUVINVpFSmhaL2xBSGpYcE1tL0p4QjJJVlNJRzJqN05XSWhlUUFUTkhIZm5Q?=
 =?utf-8?B?aTBXb3A0V0NzcXdTNFQ3UUtuNmUzM0hhUGQ1RWljVmJ0TTJxbVdzdFRjSlJh?=
 =?utf-8?B?dXhHeFJSRzBQMFNMU2FqeE1ET3hlS2x1TlVGVE1UL1BwNmljT0dqeEhYUGls?=
 =?utf-8?B?YTJRdmtZS2FsZHo1Sk42Z1IwcWZNSkZHU1ZtWjZNbXR6dUpoMWV3VWJZOGFR?=
 =?utf-8?B?YjdUbmR4NG5QRTY2VGg1U1VxZkdhMHppUkZldDVMbGpSWlVmRCtlOElyRzRC?=
 =?utf-8?B?YnRFRGlXTzJHUk5ZclhQbVlDYVV1Qy9Cc2phWEZXamVuMGZubHI5NzB2VnZo?=
 =?utf-8?B?bU5wZkxRVkhCUDluZ2RFMlFVczQ3UkxSODRFRjFPWE5NdnJEMEx2TnBOcjJY?=
 =?utf-8?B?WmFocXJGNWVyUlducmFXTW1YcFB0RUl1ZDI2U05rY202d213VVJtamFnRVVl?=
 =?utf-8?B?S2xaT000NE5GN0lWc0NXdEJhZkMzUU1WUVpNYjFlS1dxUmRoOFNsWDllOHRL?=
 =?utf-8?B?SWJhV3pQbEp2V3pva2h6YVNSZW85elFBRTdHVkZFOFFOeUdUbjBkSlpGTkZG?=
 =?utf-8?B?bEFuOUl2ZmhMajl6SEp5dEIvUjNpZXVVb0VnRzBhM0FOd05EUnJ0bHlaU2lo?=
 =?utf-8?B?UmJ0RXJYVW8yYTFpTUk1REN5QkROcEdKb3gyMFZlSUMyL3BmNTl5SHBwSHph?=
 =?utf-8?Q?nI4FS+OPml2PLRr6sCgSdsM=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff5e29c-1b5a-49e6-63a9-08db41fca353
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 00:09:13.2142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRIOKkSyUxwVKJmZ39Q2jZNLRg/idsIikpgblPr0QVaFMW/35g5mkUPqdhCkTjARA67m2i5iDkk8pB0cyJIEBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4828
X-Proofpoint-GUID: ZIHx4FR9FkdEENBIqh5sE-9Ex2vRm9Dm
X-Proofpoint-ORIG-GUID: ZIHx4FR9FkdEENBIqh5sE-9Ex2vRm9Dm
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_16,2023-04-20_01,2023-02-09_01
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/20/23 8:00 PM, Eduard Zingerman wrote:
> On Thu, 2023-04-20 at 19:54 -0400, Dave Marchevsky wrote:
>> Hi Eduard and Florian, thanks for finding this issue. I am looking into the
>> bpf_refcount side of things, and IIUC Eduard just submitted a series fixing
>> __retval / test infra.
>>
>> I'm having trouble reproducing the refcount-specific splats, would you mind
>> sharing .config?
> 
> Here is what I use:
> https://gist.github.com/eddyz87/6c13e1783b5ae4b11b2d9e29fbe5ee49

After looking at your __retval fix series I understand why
I couldn't repro. I didn’t realize the __retval issue was that
the tests weren’t being run _at all_. I thought they were just 
always reporting success. My mistake, able to repro now.
