Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409725B319E
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 10:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiIIIZ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 04:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiIIIZ0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 04:25:26 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A25564F2
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 01:25:25 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288Ml59L021057;
        Fri, 9 Sep 2022 01:25:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=/8w/6dcwNM1IG76+UZ3A/sqaY5jl/7qm11p12uvJQlE=;
 b=iOOWI65iTtjZP+Z98JRNHjf3i+hOmBIkZT27IMfbc+rTO16s/aCmSajf/LKfJQ/g35kz
 fV3Yqj3MnRDxkh4njA7sbsf5Qb2gLVdnBNJp/2xMBlWoBdBLAMOwrJU2r2KMA7losJvt
 DGYa8HPxujc22rZpj/LegRKiFz8VP4xbuNY= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jfbqx81ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 01:25:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sly5VCFt6/iVf5gK30ZiFZzeHrzVvcDOGPM/D2jn/noeHM1mOWwBGxiKm1cxyle77NlQdHxRn/riBNLEWqCKBaCXiWTIiLy0jxCekv+zdYjlhTUNygw3tJIPZS0yGl2a0kwowGHSNmMo/kJmRpQtJxXQE5mFdwUSoITTecmQxtYr6Ka6dKOWqLQmGtyZDkXmi3KCx5T2Xu4Ccm95yNcqMFCKr3yN0vL6UzzKNoCTxv1qVcrb1M+y5+1IXdeZjWadZUs6Umxjm/FBbmKCupNRVuxrLicSUOAs6S8BcSEjCKFbxP+//nt+1h4AmiUjslM6pgijdUqVKe8ULT67csAbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8w/6dcwNM1IG76+UZ3A/sqaY5jl/7qm11p12uvJQlE=;
 b=RbpiVb+FpjdabaKC4ib2PXGxlN/ufuKzqFYu/dx9P2sd8M1+w9XjqXsNyADxMPKFBNY1otmTfmxSPrGlfdcIJRIXyhBPWMiuDxMsRl+wsF61GvlUzru/98jnIDGugqX6J39YNb+Og4QzK/TY3oXI/Tk9YqT7E7ccItb7Wy9BiDN9n7DLRLOsZkMn6+57uTdyVvPZOzDQGItZbWwCn64NS38wA+k1r8HPpzxIfBf/nrkuOaTHcTqVdV0j+fvBXws+1eLMSbAhrfRCIvtHyAck/kiZZ+7KhfJQ9xuVB3u3GzarFlDLgc09IQXSmbe15juTu1pNuGai6Y9/AcWGuEexOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by CY4PR15MB1751.namprd15.prod.outlook.com (2603:10b6:910:22::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 08:25:06 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::71bc:e86e:4920:407b]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::71bc:e86e:4920:407b%9]) with mapi id 15.20.5588.017; Fri, 9 Sep 2022
 08:25:06 +0000
Message-ID: <247e2959-410f-f494-1083-f53224fb6f7a@fb.com>
Date:   Fri, 9 Sep 2022 04:25:04 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH RFC bpf-next v1 18/32] bpf: Support bpf_spin_lock in local
 kptrs
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@fb.com>
References: <20220904204145.3089-1-memxor@gmail.com>
 <20220904204145.3089-19-memxor@gmail.com>
 <20220908003557.uqiiwfjmjoq2sp3j@macbook-pro-4.dhcp.thefacebook.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20220908003557.uqiiwfjmjoq2sp3j@macbook-pro-4.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0250.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::15) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69f8561c-e8d0-47c1-8a68-08da923cccde
X-MS-TrafficTypeDiagnostic: CY4PR15MB1751:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kjzijMkDpL1ujfVGI74ckF8DeHuPgvjP8xbKucx37RdBQ9R5vnHavVhZPNI5ayY7D11PHooepj/fvUvuBhG9/0T33M1R71QaOd7ZsiYRczWwceNU+dgrbrgp9kGGyMBHtgfYPBHWt+e3DQrbWKq7naTgBzV9lOoPxPH4EmwNXaTDI9sweUQArJzBNlwKyhKKQdtGjXPHRN2zc70siX9U1pdg7gMGNcn6c4ORE4SFsOQQCJs4QLipZbvS1UQj8dT0REHkI8sVZzP4T7FDYebKWAkOrh72F+N2RvqOaTB82CqoOKvK3UtzblAtvTpGKAg5c54GE9itX/G6NLaQrfX9mUfxkk0ro8j2sjLCmjmn1LmeRAfglyBk+EujsrCj8EqLsegOd/JaIZLX8OiWyPhbJDJoe6kElNny4RoFscbjpf8DKyWuHZIdKSn/NlvBrWeQJg+jSFr/u3UZrWayypbY5XOIibkC+ys9fD2ZtEJGeSP90Hs6z5sKUBxf0zFUPmLpcp6ROvoM9O2BbkGiMEgke5Gvc+jaDsz64svL1Rp5pWsaNVz9eITT1UpqmUw1yAQaHLnrsgPnrQQEspOualwUNrf2o4FtfN2YRB8njmtipaYkj+pFe9ZXUHdZtLWkIYs5fcrGIBb2YZhMu79jkdKJt44dZsTu7SXtVmb/y4VSG3RQdl724+DVnxEpewv0yjdIn8KJevdg4H4dDjPSvlzhUlsVWaEuSUUnq+Er+qKJa8S3snRV5g7cMlVknNoPDqPCJqRdCnSAwrjSs5gyw+OE0cjY1iaaHTz6i+eRv2TxsziuHwM09Rbm0i2C1YeNNIIO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(2906002)(66556008)(5660300002)(31686004)(8936002)(6506007)(53546011)(38100700002)(41300700001)(6512007)(66946007)(66476007)(4326008)(36756003)(8676002)(31696002)(86362001)(6486002)(316002)(54906003)(110136005)(478600001)(2616005)(186003)(83380400001)(17423001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWxrRUV5bGJyM2t5ZUJldThVSzdBdnYySTlabUpCdTB4UEtPK09RWCtPSXBy?=
 =?utf-8?B?SGxvRGxWV3UzVVA3cjVRWlUvWExaRkpNUytnNlcrdmFPaUhLK1pEaDViblNy?=
 =?utf-8?B?TDkyTi9tb2p5MGlhU0tMbDVIdnRncXFFY2UyWUl1UTFLWVZITXdsTW9oZjgr?=
 =?utf-8?B?YU1EU3BhWlBydVBkazVPRXJPQnVJU2w2dkNPL1BCeUhjUWhVWnhCbGpmckdw?=
 =?utf-8?B?ZlVEbGxGTVc4MGZHVlEvTzVra3huMDFkRlJRcmIyMVY1QTRMdHM2cXVBWEhD?=
 =?utf-8?B?dm5UNkpKNjlTdXltUlpyUjdUWFpqU1h6Yk1HMjdMZ2E0OWdkQnkvK011UERQ?=
 =?utf-8?B?U1pVRjEyMmwxbk1Ybm9JQ0hRWEs0cjE5REYwdmtNVkhxQXVRajJzWDBEU2tQ?=
 =?utf-8?B?S2xpdGNmblROYytmQU5XbUVlZzBVWTJyVng0N3RQbkVMeHhGYi8xS0ZzTGgy?=
 =?utf-8?B?QXVLVldjKytBUjYzeWNGdFE0T3NzejJBMVNFSUhtNXRaRzVGVnNaSlhkTldk?=
 =?utf-8?B?VXJSRXJLODV2bFRXWklKWFVYQXJIUCtrQ2laS2d5eUt3TnpaNFdKM1dWZStn?=
 =?utf-8?B?d0hmM29iTHRpQ1BzeHBGeGw2NGR6WC9SOWZsL0hvWUxXNC9sNFV6cm9QR1lT?=
 =?utf-8?B?dENkeDBWQ3hxajh0NHpESHpPYS8rWjc5M01Cd2Nuck5KWDg2cFZuUjdnWGI1?=
 =?utf-8?B?bkh3MWx0S0p3T1ZPMTcwQ3NIVldrOEI3Wm1Ubzh5eEN6WXJHelVUU01BeHR6?=
 =?utf-8?B?NTB0UHRJbjNoMFVLTkNib3h3YjZOQlYzWjBLN3ZEQStTMHRXVTB4U3ZoVmxq?=
 =?utf-8?B?SkZiNllSVkpxM0lUMXlVZkhrOWZxMzljMXlHQ2h4UEl0YXpISitpN2ZETTdP?=
 =?utf-8?B?VjBJSDdOdS9mL1A3OHh0eHVQaUJjTEdRdnBScENtaU91NGlTZ0x3MXI2M1lv?=
 =?utf-8?B?L0ZWcXhHK05OWTZmUWlteUdqUDRUa3NPRVF6SnRPbm5Jc2tHWGxoTUFGVDJP?=
 =?utf-8?B?VFNRc01uSTFJTzgwWmpudGtqQWY2MUJCMFI5bEo3K3g1SGp3M2VqY3phNVFL?=
 =?utf-8?B?emRKWWUxYmFIYUkrSGNNdFQ2TkNjTWVSbFlUQ3Y2SDZlVFo5ckFkTFBJeEs3?=
 =?utf-8?B?WE5lMXV3YlJWWmp1R1V2bDlpQXZXaFcvb09VQ2Yya1hrNWRhS0Z5TVlMOEd2?=
 =?utf-8?B?aXY4OWIzVzBsUm4xUVpBMkRjTWtUalVOUEdwd3M1b1BnUnkzaXdiT3BOdFk4?=
 =?utf-8?B?NGVMNmtrVVJSTkpTaU1LMlNWTVo0czMrZXptVmJrSG5Gb09TNWF2LzFERHk0?=
 =?utf-8?B?WVcwbXBWbk5CYkZWOWJqdy8wVXBMb2ZlTTRZOVY4T2dveTBDbTRIaDdoVi9E?=
 =?utf-8?B?bnJnOUpDcWg2Wkx1aDZlUW5sbjdxK0x1dUtndGhodHBIajI0dUlnVm1ua3lq?=
 =?utf-8?B?WW56UERkMVdXY2h2UFIySlJVR1J0dXlFYkNLVXZCdlNrdDFZeDB4M1ZkSlU3?=
 =?utf-8?B?ODB5MktSWjNKZWxWb2RFYzJPaExLNDE4dHkra0JVckNhOWtaQkp2NXdFZWVq?=
 =?utf-8?B?d2tob1orN2x5VWx2Q01XSXRZQnd0WDhBczN1UHJhZlZoWlZuK1RwQW1aMmg1?=
 =?utf-8?B?YWIwU0lMR0Nkd2ZSREdXakdHd1JrbTI2Um9CNHNKTlJKSUViTGlTQ0w3blVu?=
 =?utf-8?B?TklyU3lCWXJYUUh1YndwZXFqUTRDcWpZME1tT2ZlZzNadG1JM0hLZWQ3Y3Ro?=
 =?utf-8?B?by9CaXhvMkQ0bHBsc0R1SWtjcVRoR05lV2tobFFLTUw0MERoaFVYaUJYOVVV?=
 =?utf-8?B?NVlsamZCZmVXT3NTT3Fid05XcDdpKzNvelI0WEJRbGlqbjhTWitBdEphbnYv?=
 =?utf-8?B?akZCbXFtRnZoQzdJYnUwRWxhUGtyNDJLalUrSmY2ZHE2RDFHL0VGVmh4ODA1?=
 =?utf-8?B?QjZDWXovR0VwOEQwdHVBcnhxVGEzREp1Z0NrZWRJSlIwZmI4TXdxU1Y0MTYw?=
 =?utf-8?B?S0gwOUtjUmF6d0MyQVcwSDFsNWVaLy8xbk9GY0NFRTBZWFJVMlJSMFplM3Ry?=
 =?utf-8?B?K284ZExPak11RVlBTTZuT2VqSUxXMWNsVU5BYmRBczlMQ2dnTEJZTHZQUU1j?=
 =?utf-8?B?T1k2c3Y4VGJlUGVubVJENEN2SElFK1c5dEduZGo1QzRQNTlycUNsQjlJZDFr?=
 =?utf-8?Q?1UYYoSb0cCBPm2eH7PebI/k=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f8561c-e8d0-47c1-8a68-08da923cccde
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 08:25:06.0426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCyY0SJuBj2x49Q7Xi+Hawf5E2NLmyPIu3KAbU+m2A7+nqHdcgEXw2vXN6AJQoRHXum+18uiMcgErIdVkHy0WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1751
X-Proofpoint-GUID: Ria67jCjshjG7ChrZbDN-t6Tg9HyUjuO
X-Proofpoint-ORIG-GUID: Ria67jCjshjG7ChrZbDN-t6Tg9HyUjuO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_04,2022-09-09_01,2022-06-22_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/7/22 8:35 PM, Alexei Starovoitov wrote:
> On Sun, Sep 04, 2022 at 10:41:31PM +0200, Kumar Kartikeya Dwivedi wrote:
>> diff --git a/include/linux/poison.h b/include/linux/poison.h
>> index d62ef5a6b4e9..753e00b81acf 100644
>> --- a/include/linux/poison.h
>> +++ b/include/linux/poison.h
>> @@ -81,4 +81,7 @@
>>  /********** net/core/page_pool.c **********/
>>  #define PP_SIGNATURE		(0x40 + POISON_POINTER_DELTA)
>>  
>> +/********** kernel/bpf/helpers.c **********/
>> +#define BPF_PTR_POISON		((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
>> +
> 
> That was part of Dave's patch set as well.
> Please keep his SOB and authorship and keep it as separate patch.

My patch picked a different constant :). But on that note, it also added some
checking in verifier.c so that verification fails if any arg or retval type
was BPF_PTR_POISON after it should've been replaced. Perhaps it's worth shipping
that patch ("bpf: Add verifier check for BPF_PTR_POISON retval and arg")
separately? Would allow both rbtree series and this lock-focused patch to drop
BPF_PTR_POISON changes after rebase.
