Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5C258489B
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 01:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiG1XRJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 19:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiG1XRH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 19:17:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065E874355
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 16:17:07 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SNEgaH010403;
        Thu, 28 Jul 2022 16:17:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=oOy3+OSp3x9JsFUuOiaJV1jM9MZjTYUqKhzis8dAqdY=;
 b=Z5lan+HDI6WKtHkS1ZfdE/u6sqSbXSjD5BVtkGiwy1cHDigGBcP6UmkJp2oSMkVlwRtP
 HiwObql4Cji6tT/J1KcBYDu+HN5TGqTGMP5idWUBDV3P8/v4w9hfIlJfK5omxO75xp9g
 tkcMwHF+ChSZ32EMbo0KlJxEUZ1jhNg4Gyc= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hks0pw1c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 16:17:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adEByQyyQeOigo2tV0c62U3y2YWsD+Qovddq41UJqkeM52h8+B/mlDp62wgExeH5NgiMiYagtYPiMnNzvQgFTec13vW/c23WUVeLcnYnT97v980OxiZrFLcvnSHhkbr3YnuPvfbXm/KUUMW16pErDc2iASgQ2UmfeoRF/65zSMjupg8cN++i8HjySMGOkdF7guggUPA+naHG1WzLnzbMI4/2R8wiCcZWu2FBiXY1d4dRnZvGbBWmpSh1jnYLv5S0hnDrvnPlDZT/pewiZthYzfiBxoC//HU5SZNkcDWZOtX1QWptk6fWHPLzhj2AyfgzLumdT65+W76/sjBhXXyCcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOy3+OSp3x9JsFUuOiaJV1jM9MZjTYUqKhzis8dAqdY=;
 b=dQvzWauy7pYjsezSRmL39sywXDEUbDkx6rfQznPOCycCDIxw1/WFGaq68y208s578uYU1NwsMmFbUSdcgtXbQHasBijU9FQCRLqp0LvSsb3TnphwAJqELnxRZGf0nxZrWRaIxBVUHjsAlXoINFewQYMBhU4gd5AnMSR+s3BNUSb/iUePOOOr2jsBtoUMTSBM6EoVDnlxErkhNhv8HiA8hqA9VsYPVRIykGJ7c09EiUa9TdJnsben0VdcnP2pGEnpsbXtG2HVjgGtWwmFeQ8hdAnm7xAlYpHmWtmj6wtLUWj1C9oDOQ0HHSztVCb4iWOMVrk86srIKOwuy1ILEVHIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4579.namprd15.prod.outlook.com (2603:10b6:806:19b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Thu, 28 Jul
 2022 23:16:59 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5458.024; Thu, 28 Jul 2022
 23:16:59 +0000
Message-ID: <7e5c0f32-7041-35d0-a18d-8d61f3cb3930@fb.com>
Date:   Thu, 28 Jul 2022 16:16:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] BPF: Fix potential bad pointer dereference in bpf_sys_bpf
Content-Language: en-US
To:     Jinghao Jia <jinghao@linux.ibm.com>, bpf@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        mvle@us.ibm.com, jamjoom@us.ibm.com, sahmed@ibm.com,
        Daniel.Williams2@ibm.com
References: <20220727132905.45166-1-jinghao@linux.ibm.com>
 <44fff416-49d5-458e-c464-e15483e2c90a@fb.com>
 <c7763b47-19ff-b369-1006-3bca38f4f083@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <c7763b47-19ff-b369-1006-3bca38f4f083@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5311fca1-a4c8-4e1e-73b8-08da70ef45bd
X-MS-TrafficTypeDiagnostic: SA1PR15MB4579:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1k55r2huYHCqfCRpakqf3thMqQasw98MnAnrZem+vFe5wRUXNJijvDSH1u9of/SHUm0KLcj9Y2w2TU3PoFc4aC5IbDR/qe/onRlns5uT8b8REdFfdGTwHnKxneleyhj4+KU/i+DY7zP1DnAZOff/xvruoTWlERIVOAc+gs7T2u1MOd09AOiJlIsSpqexgzrAADve13UDbqngDymzrmEvnrUW9Zu+6Z0sX5pZ0ZNBWW+qcd6p53uKvkYuOtYVulnHvtIuOxUdv4/PXlLel2FBUcIB2IojpNfDaDLT0jhrW22OyO2Nj2FqnuKuXMayfa0VGqWmXfhe7dJGZ8zEDoI6UwRGipp7YEh+SMQuDzxU7aQlYW3RngLmV94CJ6OvqgxU16M9dm5W3Mz7s2As5cw0Xz1l96QeaLw3QBnqw7IoBqKEqkaSdPIZ2nqczNgidjmzdWWsorPRgePaAigdKnc/QdZ5rci2/vyuapxb7uUzGevTBCumCBNUaqfyhvusJPX+dnYXkRtvaH8PQsHQ+SrPZO9nw+VpAm3e5JtM7b2AVddkB6r+zUF+KpQTRQet3cNMrEqKdOfRQwcnkbCIebmgsICpL4ek3S++Pexc2zRoEhpBOITh2rdKVs/wPiXJmeqxaDlf1XF/pRS4l5HxlmVSu6HijOw7Whqds8I1Gt+TxcJl583CbMnhRnVJIAVkg2BaIF+Qzd9n59IFOOXbZ5uu+j8gH2YELIKGaNRcs65C7CSGPJ0EN5XPhxGGu9ZoeOaUI3oOyeaqhcubgPokgAaW2G9yQtmHCtKkngQXMOh73FmDDnsHOclqCN3LxFFKHNV5XxzkBwPXE1Ti5yC0ul/2BjufULhda+zUjbFM7ZWRf/+zPQx2mbK0/2OoDx/EY/XYAuYr2vNKNAwcY6V5cHmoJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(53546011)(86362001)(6512007)(478600001)(38100700002)(6506007)(186003)(41300700001)(83380400001)(2616005)(31696002)(5660300002)(8936002)(2906002)(8676002)(4326008)(31686004)(36756003)(66946007)(66556008)(316002)(66476007)(966005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVRwL0llLzN5SU11RG0vbXFCMUt3QXY0cmYvZSs1Yy9Tc0J5enNaM2Q1SE9X?=
 =?utf-8?B?ajNQdVNxUzNudENQMTBaUzZHOVpjbE1hOGxOaS9HTnlCWWZFR01qSmUyY3VH?=
 =?utf-8?B?c3pnWERhaE53NENOMldRcU04QVh6ekdZVU10U2FoU3lIQ1pNYUNFd0FVRjh5?=
 =?utf-8?B?ZkpyQU0vY2lDVVJQWFZaSmN6NmRIWEFsekhFZDV3cHd2emtDSTZGM0lJd0h5?=
 =?utf-8?B?aC9ONkJmejRYdE9UWTVmcGJITDVuSnBmTHRVZk5mckovYmlKWWsrZFh4Q1o2?=
 =?utf-8?B?N0YxelluUXpLUk90VHRRNXNTMW9YYi9qMGJvWWhXcDFWN1M0UFFUbFR1WnFi?=
 =?utf-8?B?TERBYTRiRi9JT3hFY2NvM1pkdUE0eWkzWDVlaDZKRnd0SkJTMExZNm16NkJI?=
 =?utf-8?B?azJ2a3FKSEoxM3lqdkVJZHV4T2hhcWZveEhCQ2hjRnVMVVVhaUphRndMMnpK?=
 =?utf-8?B?bmJpT0kyUlJ4NU0vOUZ6L1VMSnBvYzk3SGIzcEl6emtmMlpUYnhLVitzVllu?=
 =?utf-8?B?WTYxY2xidUt6WUNTWGFtY21sWUhGVDRONXEvNGFHdkRCMkVad1dMczhIMzh4?=
 =?utf-8?B?NW9YSWxZY2lwKzVyQ3pJVE9Vek5lTDVXOVorSEJRTzdWaDNnWVNkb1VpMXVi?=
 =?utf-8?B?R2M1QnVSSTBpcnV3MitwZzhZdzlDdGhUazJESlFkWFovRHVWRnJrL0dtRGUz?=
 =?utf-8?B?QmNRQzVhUnZ5Y29PY0VNUXBxaWJvQk5ZS0taOTJibVdDbm1ZbnRYbTZmNlhP?=
 =?utf-8?B?WGtFditVcnlsZzJ0Z2tDL0ZvZEdUL000MTEzbDdma1llY2tETzM3Y055SEFk?=
 =?utf-8?B?NW9WOExyL09tR0MxbkpVT3V6a1I3ZHZpVjZ0UGpjUmtsNktIb2dYZ2RIbkdM?=
 =?utf-8?B?aXNPY3Zvd0VVcTA5a2FtMGtVaTZPVmRJd1ZRdVR3eHN5NlVBdlJvZ0Y4dERi?=
 =?utf-8?B?eFBTZ2xKcFptRjhMUnlUbUV1TXpyTXVpVTJuSGRWUzhHTGFTM2x4RXA3WnNm?=
 =?utf-8?B?Y3lwL1p5K0lCNVgrUkJhcUJiZmxFam1zNU9kT3dHV2c2UGlUMWczVDArbUh2?=
 =?utf-8?B?S3ZhZHBDRjdXdG1ZNXlEZ0xIZGtxa0dnNTIydVZObHVaS2NFdXljelZBSXJ3?=
 =?utf-8?B?QS9lR3A5Z1pxWFhaZ2NoOTI0QWdYSm1zYlExbHpkWVlXSzNNOWJseEFXQi8y?=
 =?utf-8?B?VzRrMUwxdDFHR2dWSGRNdU5xVFh6RTM2cWZsdVFIRlpsZmhMYmhaclUzOVhJ?=
 =?utf-8?B?UDRlQkd5YlluSXRlZVhkNUF0NVVyRWtWdC84WWl1OGtzUjhtUVZwTGxGTEZJ?=
 =?utf-8?B?V01ZNEdtQkdaL3J1QlhySzU0VHNHU0I2Z3p2TzVzcnVFVURaTk4wd2F4T1FT?=
 =?utf-8?B?TnRhLzMycG9sVDNNcVJDUnNTV1NIb1FtbWhUNFF1RmhnMmRoL3pPNTgvSk5X?=
 =?utf-8?B?eExXdmtEbUdLcmxneXhVUzBLVEZlM3I5YmlRVUJwUFZOYzR6QVhnWmxXWTNu?=
 =?utf-8?B?endKNDg5MlVxVjNIaHdUaDlxTFd4QTdJU1VFRGZFQU1ib3JMWlJZdTA1VjNP?=
 =?utf-8?B?K2NNVnZ1dEp0SUsvdzFqc3gwSzkzb2JxRGNqL29iS0ZmVkE5anIzNWJyTVNl?=
 =?utf-8?B?alB1YzNIdUNEVTJKT0xNVXk3SjVXZy8xRFYzdW1TU0taR3Nnb2xNZmlIblJW?=
 =?utf-8?B?eVk2TS92SjRNTnNJTUxncjJOejdPYUJRd20yYUp5NjdUd1U1NEttekJtbFZZ?=
 =?utf-8?B?M3F6Z3lwODA1K0lpZEpiaVdBOE45clBWeUZxek5BRFBMVXdoVFF5YzlkZ1hh?=
 =?utf-8?B?dVpGL2dmWlppa0oreU0xOWUrd2EybHFqalpvZzI5S3dDcFdvUDBSYVJkQVB5?=
 =?utf-8?B?VktnVE9qT0k1VjJsOXBqUUZaZ2tqL1dCTkNlbVk1cnlDb1ExQ1ROVCt3OHky?=
 =?utf-8?B?Yk8zVmpBVEwxcXZRQ3lVc1V0NG9kR3FkYVdwS09id2V4MnVNbEJrL3cwdlZN?=
 =?utf-8?B?ZEVYMklCbHdycEZOTnBoY1llVUVzakhsTHJtOC9ueFZLL2FDcktKVSs1a0JQ?=
 =?utf-8?B?ODJJZk1aUXRaTDFuUG54QnRmOTRtc1ZOMFN1NDc5YU4rSytFS2R4ZkFxODh0?=
 =?utf-8?B?amNiOGEyUDNsOU1Ub1ViOXBPVWZlVmo0Y1o4ZTEyNnJZQXZTRjBPOVpaTFV3?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5311fca1-a4c8-4e1e-73b8-08da70ef45bd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 23:16:59.7134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3RyvlvasWxe+kqcZG2X8JKCD08gtKPuipHyoqiuKPcqtGLWc3gv/I4A+cceTfHt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4579
X-Proofpoint-GUID: g_i5X_z2fLcTOVoAieaop9V7L1fv31kL
X-Proofpoint-ORIG-GUID: g_i5X_z2fLcTOVoAieaop9V7L1fv31kL
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/28/22 11:01 AM, Jinghao Jia wrote:
> 
> On 7/28/22 10:52 AM, Yonghong Song wrote:
>>
>>
>> On 7/27/22 6:29 AM, Jinghao Jia wrote:
>>> The bpf_sys_bpf() helper function allows an eBPF program to load another
>>> eBPF program from within the kernel. In this case the argument union
>>> bpf_attr pointer (as well as the insns and license pointers inside) is a
>>> kernel address instead of a userspace address (which is the case of a
>>> usual bpf() syscall). To make the memory copying process in the syscall
>>> work in both cases, bpfptr_t [1] was introduced to wrap around the
>>> pointer and distinguish its origin. Specifically, when copying memory
>>> contents from a bpfptr_t, a copy_from_user() is performed in case of a
>>> userspace address and a memcpy() is performed for a kernel address [2].
>>>
>>> This can lead to problems because the in-kernel pointer is never checked
>>> for validity. If an eBPF syscall program tries to call bpf_sys_bpf()
>>> with a bad insns pointer, say 0xdeadbeef (which is supposed to point to
>>> the start of the instruction array) in the bpf_attr union, memcpy() is
>>> always happy to dereference the bad pointer to cause a un-handle-able
>>> page fault and in turn an oops. However, this is not supposed to happen
>>> because at that point the eBPF program is already verified and should
>>> not cause a memory error. The same issue in userspace is handled
>>> gracefully by copy_from_user(), which would return -EFAULT in such a
>>> case.
>>>
>>> Replace memcpy() with the safer copy_from_kernel_nofault() and
>>> strncpy_from_kernel_nofault().
>>>
>>> [1]: 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/include/linux/bpfptr.h 
>>>
>>> [2]: 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/include/linux/sockptr.h#n44 
>>>
>>>
>>> Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
>>> ---
>>>   include/linux/sockptr.h | 11 +++--------
>>>   1 file changed, 3 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
>>> index d45902fb4cad..3b8a41c82516 100644
>>> --- a/include/linux/sockptr.h
>>> +++ b/include/linux/sockptr.h
>>> @@ -46,8 +46,7 @@ static inline int copy_from_sockptr_offset(void 
>>> *dst, sockptr_t src,
>>>   {
>>>       if (!sockptr_is_kernel(src))
>>>           return copy_from_user(dst, src.user + offset, size);
>>> -    memcpy(dst, src.kernel + offset, size);
>>> -    return 0;
>>> +    return copy_from_kernel_nofault(dst, src.kernel + offset, size);
>>>   }
>>
>> The subject and commit message mentioned it is bpf_sys_bpf() helper
>> might have issues. But the patch itself tries to modify 
>> copy_from_sockptr_offset() and strncpy_from_sockptr(), why?
>>
> 
> Hi Yonghong,
> 
> Sorry for the confusion. The problem happens when bpf_sys_bpf() helper 
> is called with a bad kernel address but the dereference takes place in 
> the copy_from_sockptr_offset() and strncpy_from_sockptr() functions.
> 
> Let's assume we are doing a BPF_PROG_LOAD operation using bpf_sys_bpf() 
> and our insns pointer inside the union bpf_attr argument is set to NULL 
> (could be any other bad address). The helper calls __sys_bpf() which 
> would then call bpf_prog_load() to load the program. bpf_prog_load() is 
> responsible for copying the eBPF instructions to the newly allocated 
> memory for the program, which uses the bpfptr_t API [1]. Internally, all 
> bpfptr_t operations are backed by the corresponding sockptr_t 
> operations. In other words, the code that performs the copy (and 
> therefore the deref of the pointer) is inside copy_from_sockptr_offset() 
> and strncpy_from_sockptr().

Thanks for explanation. It would be great if you can put the above
details in the commit message (esp. call stack) which leads to
the kernel panic(?).

> 
> [1]: 
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/bpf/syscall.c#n2566 
> 
> 
> Best,
> Jinghao
>>>     static inline int copy_from_sockptr(void *dst, sockptr_t src, 
>>> size_t size)
>>> @@ -93,12 +92,8 @@ static inline void *memdup_sockptr_nul(sockptr_t 
>>> src, size_t len)
>>>     static inline long strncpy_from_sockptr(char *dst, sockptr_t src, 
>>> size_t count)
>>>   {
>>> -    if (sockptr_is_kernel(src)) {
>>> -        size_t len = min(strnlen(src.kernel, count - 1) + 1, count);
>>> -
>>> -        memcpy(dst, src.kernel, len);
>>> -        return len;
>>> -    }
>>> +    if (sockptr_is_kernel(src))
>>> +        return strncpy_from_kernel_nofault(dst, src.kernel, count);
>>>       return strncpy_from_user(dst, src.user, count);
>>>   }

I think we should not modify copy_from_sockptr() and 
strncpy_from_sockptr(). These two functions are used by networking
as well and nofault version should not be called for calls in
networking stack.

So I suggest you directly modify copy_from_bpfptr() and 
strncpy_from_bpfptr() since these two functions indeed might
have invalid kernel address and may cause fault.

>>>
>>> base-commit: d295daf505758f9a0e4d05f4ee3bfdfb4192c18f
