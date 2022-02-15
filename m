Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006184B736A
	for <lists+bpf@lfdr.de>; Tue, 15 Feb 2022 17:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiBOPtS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 10:49:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiBOPtR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 10:49:17 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D72DD
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 07:49:03 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21FAEM5e027423;
        Tue, 15 Feb 2022 07:49:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=jd8PULi915yUi8b9DoLly/AfogdgqAlBS6Vhok/WhQ4=;
 b=kLTSsBrHxnQf40ud2gU47vKsccGoj1oQ5365T8yLFAP+uyyqYU6vAP/8anHbKmD3F9zi
 5kVQ9Loq3vK0HWMo3PLArdOd3ephawHj2sOvYEbnwpQUgIK622TCWNIGN92oxjnKPCs6
 /MC/LtpNpSoCog+ZOwy1pa9yAHwr2Zw/m8s= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e8a8et18c-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Feb 2022 07:49:02 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 07:48:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Usz+kO0STpShj/yd/JCFq4UQgf+ldNMvLA/Ly58MUBk5DDABU1fVml9fazQkemzLONQvfzYRxhwDVE+BUT9Ve5XiBIGFuKyt/uLSNab9lPxSMZFW2CxvX6I9JYZAiQQ53XsAex5bChBkP/bx3PHYk9EHfMWemOicW8QF+KILZuIt5bMFKiaAlKKeguf4+C6hfnmdppV9ovcbmVJjji5x4w8/qtCTAQemIYqP8Z80PZAbbcdfCgKa8/PppnVIkt22AgJw+eB0wCCO2rWKxckoNEo1XlJ9eaJyzgG3XQMzphlxAlqZAhCiYuNjDxDbhwvAzlDF/8eaN3Id0ffUzJlgbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwF9ZghvGZEiiO4nf8wIEl/6I2DW27xb2SaCUFxe/AA=;
 b=dXkeSWBKVOIetAu+qjd8NI/FpIT+/U5NANffYUgWjJOFWuljDU2naV3vxSjbtYIj+kNUQVUTPPrQmhNz4W9hEzbG6G2wZnM4hvRmOvU9+vCgmJEfXq3zac6ofgml9oVmwojcaRQ2pcXVU8ZHiUaPYtFl0VK3BwURNVqA4ijoO+b8QW5AMZN4uPrc9ssLo9AjZVkwuevr5843it/up0cf7UDWgC/zOXC3iumyFlMI57IDGuh5tozez0/ZX6VYYhi36zfKXozmjeA9Fbx82FBT/DYRMy8tEuPzLxbYEUXRwpzpFPtFwtR/uIS9pmRclo8OCeHqF26XGwq0ZZJWQMd6uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB3046.namprd15.prod.outlook.com (2603:10b6:a03:fa::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Tue, 15 Feb
 2022 15:48:48 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.4975.015; Tue, 15 Feb 2022
 15:48:48 +0000
Message-ID: <a7a8ade2-593c-957b-8748-b726b6127a30@fb.com>
Date:   Tue, 15 Feb 2022 07:48:45 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: BTF type tag not emitted to BTF in some cases
Content-Language: en-US
From:   Yonghong Song <yhs@fb.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, <bpf@vger.kernel.org>
References: <20220210232411.pmhzj7v5uptqby7r@apollo.legion>
 <bf1d4051-ae3b-c61e-131d-d6df9002529d@fb.com>
In-Reply-To: <bf1d4051-ae3b-c61e-131d-d6df9002529d@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: CO2PR04CA0190.namprd04.prod.outlook.com
 (2603:10b6:104:5::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b74d05e4-d250-4f74-a89e-08d9f09aa7c4
X-MS-TrafficTypeDiagnostic: BYAPR15MB3046:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB30460E313F51D8EAC91BB806D3349@BYAPR15MB3046.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sX+rkGrBj7wHSedE8H0PjfgY/nQfw4tFIH8xkNspRs/1KJ/k5d6kBSnwDSJ9SIw4+1oCpt+mHY094yAsmTf6m1euan85+Mm/NEKKQOrE4/sISxkGKSivt1zL8u9WQfZfyY7kjIhQYf+p+vhOlc5PMW9pRpLV2g1cT8MpvkLYWYWs+sAe2yPWlX/fXmer+AkQ3bE2HHCmM+N/YzE1cqjOOsAzHTNgcs5RjY3gX0QtYYHNDE6fCuaAQIsWnmrtz4HYB8XIFUevJy1y3sfX2AJXqeDgpgKj/4BFVwJuTajyRkXjuTKBBVyCefGg0wt9waIcOyRvv1ytAhqrcFEMpR45IqAxB3WRtV6AgdWOKWg8QFNrvLl2eN1PKYub9/8aW7pqr58svLDrJbYErjp6aKiEBg1I9XyRfcpKjnlecmmhtJrrCxe/YYGu2v3iukLd6jL1ilmU1y8dvkyOwlstmQ8E7MBP4c/v0eEfMcqhYNgmxc4YDXEVU0dRh7hTImuVjgcxOJq5DNGOunRQ8Ee1+GjGYjRLs6xMuMce7IY5eJvdHzLHwohs5qVTRuhH/sVskIArykD63Tr8LjlyYstvU0Qnz+AXT1wMEhMo3xM4CY/GmEjctf/86kCcX1ziELm07Mz6d0b5ft9mwupSe+ognzFdXYTcRIvmvej4SRlSU1h4CFlda64VT/n1zcOyVA3rWySWm5FV2hsX5LEIFeCOvAQicz8evg86jwHyFWeIEBY2/j8EqZdo/BZ8l7qHbl/9Gmo9rXJkuhjpgQSXV+Tyk40E+oM1LqPFhpTcZ54rryFW1/FxuIou+Clr4fYYUSF8mltTaxhp0be5Wjy0QXa6Lm8pPhJ7Xwoyhd0cJgWi0h/tfj4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(31696002)(8936002)(86362001)(5660300002)(38100700002)(8676002)(66476007)(66556008)(66946007)(53546011)(6512007)(52116002)(31686004)(36756003)(6506007)(6666004)(2616005)(186003)(83380400001)(6486002)(508600001)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTU2cCs2S3pWZ1ZJdWxMc2o2SjBUUXhEdVFGS3JTYjFrZnZzeWxDT2tQRUYw?=
 =?utf-8?B?MmlaYnlFSFVlb0VoTkJEZksrVnhiTHM4d0locEd0cDFHa3NWQ0V4WHZoQ2Js?=
 =?utf-8?B?cms5T0dnaEVka1ljU0Nwa3M5eER6dmVXUld5ZVE1ajZVc1YrdEdtdUpDbDFF?=
 =?utf-8?B?OTJmL3pBTXd4eGpCaGk2QVdLcXpOZ09kcDJGVWNVU0dNK2NnaXVFNmZvUEdU?=
 =?utf-8?B?ckJjS29UdWtWRHkzMjhDWWJjNjN1WkRRd0V0NExQMHdVTkxvc2o2bVZ4UTdn?=
 =?utf-8?B?NU1CWWRQc0g4WU9GbjRVMU1UbXZyUVBpbzdQWXdVWmRkZE5sWGUvWitmQ1hn?=
 =?utf-8?B?eGRjeWN1QUNJclc5YUZuNmVYczA1QUVyTGM0bmRZK3Vvd3ZzbTNSckhMUTFX?=
 =?utf-8?B?SmwwTlFtSXNZN010ZnluS0pSSnpkdWNrSjNkUDFBeGZwcUwrQmxFMFA1OWlQ?=
 =?utf-8?B?bXBrTE5kSFI2MElVQ2FJYnE0d3U1SlRWbHJvYWRnU3JpUUJZdnROZ3Z3VnNG?=
 =?utf-8?B?bDRUUXZrUWMyUndRQTlwU0xZS0t2NHB5b0NxanhTNjVlbDB0YWVMUVNQUjVT?=
 =?utf-8?B?Q0ppQlZhZGFSb3N3MjNOTjR3WFozOWV4MlNhQUk3anJxak03Yjg5bVAxamp6?=
 =?utf-8?B?VnI3SHRBbVFJbXdlME5keEJhN1ZlS1pWdHl3V2IrNE1weHpuTko1NlFDeFl3?=
 =?utf-8?B?YXFXTE1HMndsTGlpZ1lSVXR1OFI3UURmdldiaHVSVGIvalZsZU02c2tRdHJM?=
 =?utf-8?B?Z1JHeEVrWmpIc2pHLzJoV0dmd0tjdy91bEJBMkNWOE9Od3hqcHNMZWJwWnJS?=
 =?utf-8?B?UW55TEtrZCtUZ0dFMWZsZWFhbXZGeHB4T0JRVjJaODl6Ymc4cGlwTlY0MmxK?=
 =?utf-8?B?UlFpYjF3bXd3K05jZWU4eUt5UXZodHF0b3h1WEgwRzRMcThvcCs4YldUcVJQ?=
 =?utf-8?B?QklCbWhYajJFZ3ovaGhsb01PSUxMNGliZno1S2lBdkZ0clBLYnJsSjZzbkd1?=
 =?utf-8?B?MnppOHcrbmxVWEd5b2pMRjJGR2RKSnF2VHo4TmVCY0Zhb1h1MldVVWFhMzBR?=
 =?utf-8?B?YzBQNktqeWJwT2REMm5UaDArNFloNGtYUFdMcWlFR1NFcjRBaHJ5L3JnRSty?=
 =?utf-8?B?eUdqNUNBSkU4VWQwNGkweFBtYjRsZzBSZUk5a29MRFc1eWVtMEp2VU9TWFI5?=
 =?utf-8?B?c3hjUThoRGVWR0Rycm9NL05hOUJFMTBKdWFhSDB6UmJzc3c3dnR1elQraHcw?=
 =?utf-8?B?a2IxaGwwOGtjcEpMblBmOXZZMVNGMW1OVksySkViM1ozOWVmRmNLVW5yc2hk?=
 =?utf-8?B?cG9lbzdZRHI0RTcwSXdkem5oWG40MWJaL0RFOVppb2hrNGpleGRSVjBUVGRO?=
 =?utf-8?B?Vis3YWhKZzhFQ1JWbEtFRE1kMzQxWWJTdDJxZ05uanZnakhEQWpOUGRPN0JK?=
 =?utf-8?B?TDZrbWRZbllmK3NDcU9xOU4wcWRwV2M1YWdhWWMxQUoxaHFvcjFkZFFzUUk2?=
 =?utf-8?B?eW9yQTJhOGFDV0tSdFR2Y2JwaUVBYU9lMU9xODNjSnVvY2kxWkxIWU9XR2xL?=
 =?utf-8?B?bmh2VHVIWE14WFVyOGdxTzBWS0Nrd0VlK0xpN28wQXBaOW5Za3hWcDNKZEdX?=
 =?utf-8?B?ODJxeHpscEVUZTh4SGthZ0JVbXZoTG1zemFnTjZ0SDF3cXVtTUF3ZVRVeHFh?=
 =?utf-8?B?UkFlMU9MMmRzRVFWM3NvMkhITGtOSXllVGV3dy9RalVyZ1VGM05zY3VGcnIw?=
 =?utf-8?B?eHI0NE00WGptR3lyaUNuQVlRNTRiRDdIMzlCOFk3MUtKWWdGWWZTbDFnZ0xa?=
 =?utf-8?B?R214cHh4NlF6OUZrNFVYbFJ5bkNKWjd0SUdUMDhiWEFpbzlubEhSSmFvYXEy?=
 =?utf-8?B?MFZRR2J6VTlMUjFFSUxIRnVoN291a3p5dmVLMlZFbzcvckxLcUpuRGNBOVlv?=
 =?utf-8?B?Uzdjbk55czJRWXlyaUp0TTdQcjVycnVxbDh6dkVmUFJrY2VBdTNsemlYMm1q?=
 =?utf-8?B?S1FUMVdSRVlUeDk2OE9vZFkwWmhYTTl2RnZPMGFQeDVhWnljVmpoVWg4WFd3?=
 =?utf-8?B?MXlRV04zNWxvTThyUlp2bUs1U0tCM3ZVUkJiTFRySzNGUGJvU1FrTVJOVmdu?=
 =?utf-8?B?T3h3NEhDbW04SDlTUUs4ZStoZFNaN3U1eTJsY3J4dlUveitQa1NUWlRLU2Q5?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b74d05e4-d250-4f74-a89e-08d9f09aa7c4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 15:48:48.2292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ebg5COzKK3VAGZ86Ou80O0jsFzsg7f0qG7FMUcSqfHByAtKlZ+6YVQ1aRcdDJvz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3046
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: g4Yyn-0Sa3exH9pKzOnS6O6g_ij7nayf
X-Proofpoint-GUID: g4Yyn-0Sa3exH9pKzOnS6O6g_ij7nayf
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_04,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 priorityscore=1501 mlxlogscore=946 lowpriorityscore=0 malwarescore=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202150093
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/10/22 4:31 PM, Yonghong Song wrote:
> 
> 
> On 2/10/22 3:24 PM, Kumar Kartikeya Dwivedi wrote:
>> Hello,
>>
>> I was trying to use BTF type tags, but I noticed that when I apply it 
>> to a
>> non-builtin type, it isn't emitted in the 'PTR' -> 'TYPE_TAG' -> 
>> <TYPE> chain.
>>
>> Consider the following two cases:
>>
>>   ; cat tag_good.c
>> #define __btf_id __attribute__((btf_type_tag("btf_id")))
>> #define __ref    __attribute__((btf_type_tag("ref")))
>>
>> struct map_value {
>>          long __btf_id __ref *ptr;
>> };
>>
>> void func(struct map_value *, long *);
>>
>> int main(void)
>> {
>>          struct map_value v = {};
>>
>>          func(&v, v.ptr);
>> }
>>
>> ; cat tag_bad.c
>> #define __btf_id __attribute__((btf_type_tag("btf_id")))
>> #define __ref    __attribute__((btf_type_tag("ref")))
>>
>> struct foo {
>>          int i;
>> };
>>
>> struct map_value {
>>          struct foo __btf_id __ref *ptr;
>> };
>>
>> void func(struct map_value *, struct foo *);
>>
>> int main(void)
>> {
>>          struct map_value v = {};
>>
>>          func(&v, v.ptr);
>> }
>>
>> -- 
>>
>> In the first case, it is applied to a long, in the second, it is 
>> applied to
>> struct foo.
>>
>> For the first case, we see:
>>
>> [1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
>> [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
>> [3] FUNC 'main' type_id=1 linkage=global
>> [4] FUNC_PROTO '(anon)' ret_type_id=0 vlen=2
>>          '(anon)' type_id=5
>>          '(anon)' type_id=11
>> [5] PTR '(anon)' type_id=6
>> [6] STRUCT 'map_value' size=8 vlen=1
>>          'ptr' type_id=9 bits_offset=0
>> [7] TYPE_TAG 'btf_id' type_id=10
>> [8] TYPE_TAG 'ref' type_id=7
>> [9] PTR '(anon)' type_id=8
>> [10] INT 'long' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
>> [11] PTR '(anon)' type_id=10
>> [12] FUNC 'func' type_id=4 linkage=extern
>>
>> For the second, there is no TYPE_TAG:
>>
>>   ; ../linux/tools/bpf/bpftool/bpftool btf dump file tag_bad.o
>> [1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
>> [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
>> [3] FUNC 'main' type_id=1 linkage=global
>> [4] FUNC_PROTO '(anon)' ret_type_id=0 vlen=2
>>          '(anon)' type_id=5
>>          '(anon)' type_id=8
>> [5] PTR '(anon)' type_id=6
>> [6] STRUCT 'map_value' size=8 vlen=1
>>          'ptr' type_id=7 bits_offset=0
>> [7] PTR '(anon)' type_id=9
>> [8] PTR '(anon)' type_id=9
>> [9] STRUCT 'foo' size=4 vlen=1
>>          'i' type_id=2 bits_offset=0
>> [10] FUNC 'func' type_id=4 linkage=extern
>>
>> -- 
>>
>> Is there anything I am missing here? When I do llvm-dwarfdump for 
>> both, I see
>> that the tag annotation is present for both:
> 
> Thanks for trying and reporting! This should be a llvm bpf backend bug.
> Will fix it soon.

The issue is fixed in https://reviews.llvm.org/D119799 and
the patch is merged in llvm-project main branch.
Could you take a look again? Thanks!

> 
>>
>> For the good case:
>>
>> 0x00000067:   DW_TAG_pointer_type
>>                  DW_AT_type      (0x00000073 "long")
>>
>> 0x0000006c:     DW_TAG_unknown_6000
>>                    DW_AT_name    ("btf_type_tag")
>>                    DW_AT_const_value     ("btf_id")
> 
> BTW, if you use the same llvm-dwarfdump from 15.0.0,
> $ llvm-dwarfdump --version
> LLVM 
> (http://llvm.org/ 
> ):
>    LLVM version 15.0.0git
>    Optimized build with assertions.
>    Default target: x86_64-unknown-linux-gnu
>    Host CPU: skylake-avx512
> 
> You should see
> 0x0000006c:     DW_TAG_LLVM_annotation
>                    DW_AT_name    ("btf_type_tag")
>                    DW_AT_const_value     ("btf_id")
> 
> instead of
>          DW_TAG_unknown_6000
> 
>>
>> 0x0000006f:     DW_TAG_unknown_6000
>>                    DW_AT_name    ("btf_type_tag")
>>                    DW_AT_const_value     ("ref")
>>
>> For the bad case:
>>
>> 0x00000067:   DW_TAG_pointer_type
>>                  DW_AT_type      (0x00000073 "foo")
>>
>> 0x0000006c:     DW_TAG_unknown_6000
>>                    DW_AT_name    ("btf_type_tag")
>>                    DW_AT_const_value     ("btf_id")
>>
>> 0x0000006f:     DW_TAG_unknown_6000
>>                    DW_AT_name    ("btf_type_tag")
>>                    DW_AT_const_value     ("ref")
>>
>> My clang version is a very recent compile:
>> clang version 15.0.0 (https://github.com/llvm/llvm-project.git 
>> 9e08e9298059651e4f42eb608c3de9d4ad8004b2)
>>
>> Thanks
>> -- 
>> Kartikeya
